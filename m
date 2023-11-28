Return-Path: <linux-pci+bounces-218-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A57E77FB479
	for <lists+linux-pci@lfdr.de>; Tue, 28 Nov 2023 09:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44C87B20F78
	for <lists+linux-pci@lfdr.de>; Tue, 28 Nov 2023 08:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B365F17729;
	Tue, 28 Nov 2023 08:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Apc9CIzX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E03A8
	for <linux-pci@vger.kernel.org>; Tue, 28 Nov 2023 00:42:27 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-50aaaf6e58fso7821254e87.2
        for <linux-pci@vger.kernel.org>; Tue, 28 Nov 2023 00:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701160945; x=1701765745; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Erf0gitB2S5rXXmcEeV/xkrurthBZdKYZBJso/PS/Ac=;
        b=Apc9CIzXM4rfC5ZSXd1ivVWekxUkRBkorcQrIfWg9UxFpW/kkcBW693lTkSMe0p91X
         dH+AGuEp8gSJLF8weWBEyByCMpOdvUUB36/gkLdXCoQBGOHS/mjf9YbfV3Td0OHKVNBF
         HCqKD2BP7JxUDZLWgKdyrr1NZ/0t3dkOC+ypfHUAjXVmQR32qUbxgfWxa6LXZ8FfyPOs
         5BxuNGFhc9VaGfA4/508bxDJBAy96WcsxAXF16v698Rn70cdDsrmcAx4kFZhQ/teflhB
         dUln7Gu116rsaKGhKstouo33XNVghztbLvvGfDcUfUodzNCsLSIo98m50zhV0h0gVU2h
         4KrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701160945; x=1701765745;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Erf0gitB2S5rXXmcEeV/xkrurthBZdKYZBJso/PS/Ac=;
        b=j1U/+4xrSLXSziJ75huxXtILww3jQnUmKjmkQjshK0uYjEwtI+mWhjrgL3+2PHvoAP
         E70zK40A0Z7pJfAC/78kdfvTDj/cpgeUHz++sfslBc0h847fSnEDCGUHaG/XnbBjezQz
         jnuPS5YJJGKk5WmffZPq8+Z6t4XTlilg2qZveqniq9O9pMwmbyYUUrfLC8/1zzqP6IlQ
         bHMrfD/uBSx2wHnLQEHr+Nz2JAsuvRYa922FeyT4aoLRsfL3kghfxkz95c4W4ZYRDXDU
         qRbP6nYmUEUs/d74Lao7+hZsNv8latjJvvwUs1qZFvBV+Qrp7anZq5B4hDBBXyj8lmWi
         9y1A==
X-Gm-Message-State: AOJu0YxZIa5zcQpwj+2vM3YnrqtdllUv8Ap/Eg6E4vfyLx3ZW+28BNjG
	pNLDraXBwpWzPkkvC6gxFrkKmQ==
X-Google-Smtp-Source: AGHT+IGpPMz6U7UlSZRGx1bf2JkG6T7mTur+DF+VvbtmPQO99UJytTF3JNBbD72JCUwE18GKibK6OA==
X-Received: by 2002:a05:6512:2244:b0:50b:bd7a:abbc with SMTP id i4-20020a056512224400b0050bbd7aabbcmr560068lfu.66.1701160945641;
        Tue, 28 Nov 2023 00:42:25 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:eada:f40e:7ab3:2afe? ([2a01:e0a:982:cbb0:eada:f40e:7ab3:2afe])
        by smtp.gmail.com with ESMTPSA id q19-20020a194313000000b0050a78dac3fasm1795027lfa.12.2023.11.28.00.42.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 00:42:25 -0800 (PST)
Message-ID: <9bb9b7e3-ba59-4c29-99b8-173b1e8f247a@linaro.org>
Date: Tue, 28 Nov 2023 09:42:23 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH RESEND] dt-bindings: PCI: qcom: document the SM8650 PCIe
 Controller
Content-Language: en-US, fr
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231128-topic-sm8650-upstream-bindings-pcie-v1-1-9c803b439952@linaro.org>
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro Developer Services
In-Reply-To: <20231128-topic-sm8650-upstream-bindings-pcie-v1-1-9c803b439952@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Lorenzo,

On 28/11/2023 09:36, Neil Armstrong wrote:
> Document the PCIe Controller on the SM8650 platform by using the
> SM8550 bindings as a fallback.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Please ignore this resend, I forgot to add reviews.

Thanks,
Neil

> ---
> For convenience, a regularly refreshed linux-next based git tree containing
> all the SM8650 related work is available at:
> https://git.codelinaro.org/neil.armstrong/linux/-/tree/topic/sm85650/upstream/integ
> ---
>   Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index eadba38171e1..af537732ded6 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -41,6 +41,10 @@ properties:
>             - qcom,pcie-sm8450-pcie0
>             - qcom,pcie-sm8450-pcie1
>             - qcom,pcie-sm8550
> +      - items:
> +          - enum:
> +              - qcom,pcie-sm8650
> +          - const: qcom,pcie-sm8550
>         - items:
>             - const: qcom,pcie-msm8998
>             - const: qcom,pcie-msm8996
> 
> ---
> base-commit: fe1998aa935b44ef873193c0772c43bce74f17dc
> change-id: 20231016-topic-sm8650-upstream-bindings-pcie-56e90536c258
> 
> Best regards,


