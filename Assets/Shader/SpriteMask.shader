Shader "Sprites/SpriteMask"
{
	Properties
	{
		[PerRendererData] _MainTex("Sprite Texture", 2D) = "white" {}
		_Cutoff("Base Alpha cutoff", Range(0,1)) = .5
	}

	SubShader
	{
		Tags
		{
			"Queue" = "AlphaTest"
		}

		Cull Off
		Lighting Off
		ZWrite On
		Blend SrcAlpha OneMinusSrcAlpha

		Pass
		{
			CGPROGRAM
#pragma vertex vert 
#pragma fragment frag
#include "UnityCG.cginc"

			struct appdata_t
			{
				float4 vertex   : POSITION;
				float4 color    : COLOR;
				float2 texcoord : TEXCOORD0;
			};

			struct v2f
			{
				float4 vertex   : SV_POSITION;
				fixed4 color : COLOR;
				float2 texcoord  : TEXCOORD0;
			};

			fixed4 _Color;
			float _Cutoff;

			v2f vert(appdata_t IN)
			{
				v2f OUT;
				OUT.vertex = UnityObjectToClipPos(IN.vertex);
				OUT.texcoord = IN.texcoord;
				OUT.color = IN.color * _Color;

				return OUT;
			}

			struct fragOut
			{
				float4 color : SV_Target;
				float zvalue : SV_Depth;
			};

			sampler2D _MainTex;

			fixed4 SampleSpriteTexture(float2 uv)
			{
				fixed4 color = half4(1,1,1,1 - tex2D(_MainTex, uv).a);
				return color;
			}

			fixed4 frag(v2f IN) : SV_Target
			{

				fixed4 c;
				c = SampleSpriteTexture(IN.texcoord);
				c.rgb *= c.a;

				if (c.a > _Cutoff)
					discard;

				return c;
			}
		ENDCG
		}
	}
}
