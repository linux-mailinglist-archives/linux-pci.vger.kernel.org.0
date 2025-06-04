Return-Path: <linux-pci+bounces-28997-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2A4ACE43A
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 20:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 806D516AE7A
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 18:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4891139D;
	Wed,  4 Jun 2025 18:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VATsoje6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFAD149C55
	for <linux-pci@vger.kernel.org>; Wed,  4 Jun 2025 18:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749061001; cv=none; b=AjHUbHjSbZjV5Gb6GEmvqXunYq+nrhiN7UL4YwP/GPOlnYtOj/8z+pVfMKR4KOZVMBvZZgAK+YBob68XzWp570tZ2uQRMVu7ucGKZcrkuH3CNWvO4ggRQ08xRkYbtASFDpId0059aq5G+/MZveBb2KcCSGi46fFwSExuj8adX/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749061001; c=relaxed/simple;
	bh=zK7vdQyIbPYAAsJhypTmzLbKX/Zy6KY0Nmx8W/IIUy0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=NEnYOSsw2wUZh1SGx9Tgk6qBzy9QT7XMcyRhyngT/XFr66oQa3oy9qBYPg7RHycZFDs3qDrO/cMDPYVm/deA3FTeBthccpUPT7kxyWb95ZrLCLacjfKMOp0gX50czgkAbRQxOaYa/ftrYm/X8RxhPYtKS2RzTW3i57zHc9O2Pj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VATsoje6; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-451d7b50815so654255e9.2
        for <linux-pci@vger.kernel.org>; Wed, 04 Jun 2025 11:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749060998; x=1749665798; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ttjgH0cT0DxWlBa65PV80AJpjnePegqRqixNcnWRFlI=;
        b=VATsoje6CxxeN7Wm4X30j9EGIuK+iuZa9hbkJiRBe4pbVSknbj/f4TTxPHLnuQXqV6
         +HndxBKZNwIQAY4qc07W9YW8tdVw8rIMd+t8x58DsFMKzh04UIjksO5Yx4VRM5rFO8Ij
         LrEUxuSVLxZz9pTRLuXh+flP7qF7g2rZEtwOP4D9AjlI562eKOWu+OJN+Jwdyfk01srQ
         bkmm6VAl2QhivKEgY5a1jlutVbGVt6Ui82Xri9ThXXtYBScsFm9VQpHVdZr7+I6hHxXw
         YwCAVHwEOtZ8C8VGT0V1Vyr3kc4i9gw3sS9PxkkpmtPnexGJnkppDvO+2tSjHkyZXghQ
         UdAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749060998; x=1749665798;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ttjgH0cT0DxWlBa65PV80AJpjnePegqRqixNcnWRFlI=;
        b=u0Jdr95GaVPB47JIPZULOtWs0Ipf09XD/jNdrJc49Nqgx126Mcnmu8eNq4RregcQwq
         VAWLoVW9wUVzKelhnNMnQOZ7vqAGvbZEIH4CU/Q3QAtT+/pVnVUoh+HH2AXWf7jQJ8/r
         ayjXaBB5yv9VefMM2xeQ3zTjio4/7KbhwaaLVC5CvdAfHYojAyZ4+cIrF4OS/J134TmQ
         7w9jXLXn2RAyp0dW6znbWNKRk/bagcCJ1srZddgw9DP+7jMDQ1zJIF4Fzm7SK/NHiPZ8
         1btFXTU1Lm0iW335XSHraWbxXlr/hPiPEGCELe2B3JPPfqQ7BGRONjxqoRaIYPmWUDSF
         xSNg==
X-Forwarded-Encrypted: i=1; AJvYcCX+euS14gxh+PUQ/qATX5ibhNMuvqrFd+3ay4vGPeMRR6juAerD6oCMih+737fkvCib/+4KmycJk+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI/YTeTYPI2OMaNocI4yTsG+R1QddcBKyGGmzT0V67WaE/1ldj
	SNG930Iz2M/I20r//ouELpNYyQiP2ug9hwYAlpakKaKJeFlGdkjfngVZ8Wn3N/Y9nkY=
X-Gm-Gg: ASbGncv8hhOcRbcI9i03w3QrwK7RGZAyYFt7tDjzV4VEvEHvDg8hy2ZyWg7PlZg+aPQ
	0zemxNEy9GzOfM2+5YUtoxhtCQ3IOdt6VqONDP1HHNqK2RpDnhbSzOBjI59z2DKC+z06pWqIxLw
	Hp/qgvhtkW4uU0isFWvVq3hUMfrlQj/vH/w2Glu5WA9WJR+FTAYNeqv/4iywv9DqV0WLHJ6TIXB
	MeAv3WEfQpgjUxDCDvhmDtOy86FX6r0GdZfWrMxiNvsLfsP3Ac6in9qPSpbKY7J+bVj+vqJKvyG
	LAr8B5aXM0LZFLGFbm7IXf71hBbmCeDOgDdx6VqiomAsuBCF/X6/WwytOXVyUp9NaJexaWB1j8+
	daDXUmxnafvpxXBrB240067aKtw==
X-Google-Smtp-Source: AGHT+IEcknHa0jklsTHK2Sa0FI3Bf5pRVp6W6gGePL7R94mxRH5Vo6lZGA6amhcBYAnFzViV8qqrDQ==
X-Received: by 2002:a5d:5f48:0:b0:3a4:ead4:5ea4 with SMTP id ffacd0b85a97d-3a51d930f6cmr3665520f8f.24.1749060997959;
        Wed, 04 Jun 2025 11:16:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:fef9:cf1c:18f:2ab8? ([2a01:e0a:3d9:2080:fef9:cf1c:18f:2ab8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe6d0dbsm21967626f8f.40.2025.06.04.11.16.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jun 2025 11:16:37 -0700 (PDT)
Message-ID: <c09fda8d-a023-47f7-a89b-80a368d06193@linaro.org>
Date: Wed, 4 Jun 2025 20:16:36 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v1 1/2] PCI: qcom: Add equalization settings for 8.0 GT/s
To: Ziyue Zhang <quic_ziyuzhan@quicinc.com>, lpieralisi@kernel.org,
 kwilczynski@kernel.org, manivannan.sadhasivam@linaro.org, robh@kernel.org,
 bhelgaas@google.com, krzk+dt@kernel.org, abel.vesa@linaro.org, kw@linux.com,
 conor+dt@kernel.org, vkoul@kernel.org, kishon@kernel.org,
 andersson@kernel.org, konradybcio@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, quic_qianyu@quicinc.com,
 Qiang Yu <qiang.yu@oss.qualcomm.com>
References: <20250604091946.1890602-1-quic_ziyuzhan@quicinc.com>
 <20250604091946.1890602-2-quic_ziyuzhan@quicinc.com>
Content-Language: en-US, fr
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
Organization: Linaro
In-Reply-To: <20250604091946.1890602-2-quic_ziyuzhan@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 04/06/2025 11:19, Ziyue Zhang wrote:
> Adding lane equalization setting for 8.0 GT/s to enhance link stability
> and fix AER correctable errors reported on some platforms (eg. SA8775P).
> 
> GEN3 and GEN4 require the same equalization setting. This setting is
> programmed into a group of shadow registers, which can be switched to
> configure equalization for different GEN speeds by writing 00b, 01b
> to `RATE_SHADOW_SEL`.
> 
> Hence program equalization registers in a loop using link speed as index,
> so that equalization setting can be programmed for both GEN3 and GEN4.
> 
> Co-developed-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
> ---
>   drivers/pci/controller/dwc/pcie-designware.h  |  1 -
>   drivers/pci/controller/dwc/pcie-qcom-common.c | 55 ++++++++++---------
>   drivers/pci/controller/dwc/pcie-qcom-common.h |  2 +-
>   drivers/pci/controller/dwc/pcie-qcom.c        |  3 +-
>   4 files changed, 32 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index ce9e18554e42..388306991467 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -127,7 +127,6 @@
>   #define GEN3_RELATED_OFF_GEN3_EQ_DISABLE	BIT(16)
>   #define GEN3_RELATED_OFF_RATE_SHADOW_SEL_SHIFT	24
>   #define GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK	GENMASK(25, 24)
> -#define GEN3_RELATED_OFF_RATE_SHADOW_SEL_16_0GT	0x1
>   
>   #define GEN3_EQ_CONTROL_OFF			0x8A8
>   #define GEN3_EQ_CONTROL_OFF_FB_MODE		GENMASK(3, 0)
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-common.c b/drivers/pci/controller/dwc/pcie-qcom-common.c
> index 3aad19b56da8..48040f20b29c 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-common.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-common.c
> @@ -8,43 +8,46 @@
>   #include "pcie-designware.h"
>   #include "pcie-qcom-common.h"
>   
> -void qcom_pcie_common_set_16gt_equalization(struct dw_pcie *pci)
> +void qcom_pcie_common_set_equalization(struct dw_pcie *pci)
>   {
>   	u32 reg;
> +	u16 i;
>   
>   	/*
>   	 * GEN3_RELATED_OFF register is repurposed to apply equalization
> -	 * settings at various data transmission rates through registers namely
> -	 * GEN3_EQ_*. The RATE_SHADOW_SEL bit field of GEN3_RELATED_OFF
> +	@@ -19,32 +21,34 @@ void qcom_pcie_common_set_16gt_equalization(struct dw_pcie *pci)
>   	 * determines the data rate for which these equalization settings are
>   	 * applied.
>   	 */
> -	reg = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
> -	reg &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
> -	reg &= ~GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK;
> -	reg |= FIELD_PREP(GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK,
> -			  GEN3_RELATED_OFF_RATE_SHADOW_SEL_16_0GT);
> -	dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, reg);
> +	for (i = PCIE_SPEED_8_0GT; i <= (pcie_link_speed[pci->max_link_speed] < PCIE_SPEED_32_0GT ?
> +		 pcie_link_speed[pci->max_link_speed] : PCIE_SPEED_16_0GT); i++) {

This is pretty hard to read, please simplify like:

u16 speed, max_speed = PCIE_SPEED_16_0GT;

if (pcie_link_speed[pci->max_link_speed] < PCIE_SPEED_32_0GT)
	max_speed = pcie_link_speed[pci->max_link_speed];

for (speed = PCIE_SPEED_8_0GT; speed < max_speedl; ++speed) {
	blah;
}


> +		reg = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
> +		reg &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
> +		reg &= ~GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK;
> +		reg |= FIELD_PREP(GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK,
> +			  i - PCIE_SPEED_8_0GT);
> +		dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, reg);
>   
> -	reg = dw_pcie_readl_dbi(pci, GEN3_EQ_FB_MODE_DIR_CHANGE_OFF);
> -	reg &= ~(GEN3_EQ_FMDC_T_MIN_PHASE23 |
> -		GEN3_EQ_FMDC_N_EVALS |
> -		GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA |
> -		GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA);
> -	reg |= FIELD_PREP(GEN3_EQ_FMDC_T_MIN_PHASE23, 0x1) |
> -		FIELD_PREP(GEN3_EQ_FMDC_N_EVALS, 0xd) |
> -		FIELD_PREP(GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA, 0x5) |
> -		FIELD_PREP(GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA, 0x5);
> -	dw_pcie_writel_dbi(pci, GEN3_EQ_FB_MODE_DIR_CHANGE_OFF, reg);
> +		reg = dw_pcie_readl_dbi(pci, GEN3_EQ_FB_MODE_DIR_CHANGE_OFF);
> +		reg &= ~(GEN3_EQ_FMDC_T_MIN_PHASE23 |
> +			GEN3_EQ_FMDC_N_EVALS |
> +			GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA |
> +			GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA);
> +		reg |= FIELD_PREP(GEN3_EQ_FMDC_T_MIN_PHASE23, 0x1) |
> +			FIELD_PREP(GEN3_EQ_FMDC_N_EVALS, 0xd) |
> +			FIELD_PREP(GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA, 0x5) |
> +			FIELD_PREP(GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA, 0x5);
> +		dw_pcie_writel_dbi(pci, GEN3_EQ_FB_MODE_DIR_CHANGE_OFF, reg);
>   
> -	reg = dw_pcie_readl_dbi(pci, GEN3_EQ_CONTROL_OFF);
> -	reg &= ~(GEN3_EQ_CONTROL_OFF_FB_MODE |
> -		GEN3_EQ_CONTROL_OFF_PHASE23_EXIT_MODE |
> -		GEN3_EQ_CONTROL_OFF_FOM_INC_INITIAL_EVAL |
> -		GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC);
> -	dw_pcie_writel_dbi(pci, GEN3_EQ_CONTROL_OFF, reg);
> +		reg = dw_pcie_readl_dbi(pci, GEN3_EQ_CONTROL_OFF);
> +		reg &= ~(GEN3_EQ_CONTROL_OFF_FB_MODE |
> +			GEN3_EQ_CONTROL_OFF_PHASE23_EXIT_MODE |
> +			GEN3_EQ_CONTROL_OFF_FOM_INC_INITIAL_EVAL |
> +			GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC);
> +		dw_pcie_writel_dbi(pci, GEN3_EQ_CONTROL_OFF, reg);
> +	}
>   }
> -EXPORT_SYMBOL_GPL(qcom_pcie_common_set_16gt_equalization);
> +EXPORT_SYMBOL_GPL(qcom_pcie_common_set_equalization);
>   
>   void qcom_pcie_common_set_16gt_lane_margining(struct dw_pcie *pci)
>   {
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-common.h b/drivers/pci/controller/dwc/pcie-qcom-common.h
> index 7d88d29e4766..7f5ca2fd9a72 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-common.h
> +++ b/drivers/pci/controller/dwc/pcie-qcom-common.h
> @@ -8,7 +8,7 @@
>   
>   struct dw_pcie;
>   
> -void qcom_pcie_common_set_16gt_equalization(struct dw_pcie *pci);
> +void qcom_pcie_common_set_equalization(struct dw_pcie *pci);
>   void qcom_pcie_common_set_16gt_lane_margining(struct dw_pcie *pci);
>   
>   #endif
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index c789e3f85655..51eac2dc6222 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -298,8 +298,9 @@ static int qcom_pcie_start_link(struct dw_pcie *pci)
>   {
>   	struct qcom_pcie *pcie = to_qcom_pcie(pci);
>   
> +	qcom_pcie_common_set_equalization(pci);
> +
>   	if (pcie_link_speed[pci->max_link_speed] == PCIE_SPEED_16_0GT) {
> -		qcom_pcie_common_set_16gt_equalization(pci);
>   		qcom_pcie_common_set_16gt_lane_margining(pci);
>   	}
>   

Thanks,
Neil

