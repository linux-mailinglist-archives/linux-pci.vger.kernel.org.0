Return-Path: <linux-pci+bounces-34369-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A87E9B2D732
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 10:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B7F516D88B
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 08:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B33A2D9EDF;
	Wed, 20 Aug 2025 08:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hBtjH4wD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AF72D8DB7
	for <linux-pci@vger.kernel.org>; Wed, 20 Aug 2025 08:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755680107; cv=none; b=sQ2JkN+QKfUvPn2QF74nhoYkDmhyyGo32JtXnlRHuuegM6+NPOPFaEdKtQCI8y69HLjwmf3FrihbyK46vq2VvGs1oScqx+Ng5vk8kCp3H5rf164K9GaS4KaBecvRn6D434xoCpK+bk+OVPTekbkeY1MqdI/29YdtW0sznizB1iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755680107; c=relaxed/simple;
	bh=GqmYU65tMcAaCGa4cOzMMQRQzTAiG9TRjGmlEXh2nnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oubokgdhRkYS41NeE3KsCxG18cR5jw85iKQ8mehdIR0MfbqbRQKt32ceQdNBxd6Q8FlEP94IojX4p9XPvjjcF6yV2TMiIXXAZtpDP09VDuPTG342thJ+r1tjG7ak/Kx1EFLaBqnv/3dQktA0Xp3gQPa240YrpRvEBODvQJxZZXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hBtjH4wD; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3b9e41101d4so3315807f8f.2
        for <linux-pci@vger.kernel.org>; Wed, 20 Aug 2025 01:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755680103; x=1756284903; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Z3/u8sJAwQxbkGnKIhFxnnPFecI1U3zoWEcGlytMh4=;
        b=hBtjH4wDYAb7hN45SQQB+4ByXSuLX4K76EDgJZC2/2jKBc4IrYnXFk6OyxqYiBvP6r
         LPwDrF47vzGGDebpV0L1wZJAVFmyiK/zbJWZsAa9ncj4QAIK3H7UxEICxuNRyjsrQ7o+
         v8Z9jEx2j0GqxUTl+FtQBPhY3svSTAWav1l2tBZDYpu2GVfm301fqbHDMLD5f2fAN5hJ
         SLTfh621MA8jmhwMJt2JIROcM9bFIBSMWvdN4NQ9zK8S6UHigfzHksAItCRVDuW8IKwN
         w41Pw5MLGFxDrQhf0cUMVTmXmB+8sPUF9+fOqeIlP9wsBFkXCaeXvFjrtfGBlZ9iMfmF
         B3SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755680103; x=1756284903;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6Z3/u8sJAwQxbkGnKIhFxnnPFecI1U3zoWEcGlytMh4=;
        b=EQ30IgKPHr+KUHldykeyXoN7wJgnvv6Hf1Gxlb8M7eIn3PZA6YbCs+TAFqulZCsAzp
         1Q6OOublTX73iCK3pL/IlvmD24d8Q4ecBrlW6EZH5dFE/AUg5fwOiAOZan3Q19U1aBrX
         qTWi+JopCv5dK8H68h896N7O6suNCNPoUL6PpcNrNOpSg/uJOhGTV5IUbwgfszHpoWfH
         JgFLZdase6ZtcuKHv1Mvb2XrGXbiHJC7Vobzbo3hc+HoSke0+qDoWwZtucyCI2YguUwB
         g5u2ScXFCJoOR9GSxBBjAaCz/5SVQLnnFy0nhWcr4don2JeRLYmFgnR8WY5yv2l5fLE6
         VKOw==
X-Forwarded-Encrypted: i=1; AJvYcCV5b5l0cFh/UDS/kn09/5Q455i4VEbAUJKHcH3CanbbesblH0ZOIpRuFlXY8cgjoNKaLXSQgVQ+oT8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvcf+zs0vCNcQ3PmwTF26uiCEgCdWFB3YPd2nqZ5GZ9nQdYkjQ
	FQCvTveqBdqodxnur5duqnGb9hI1dogZMyHFugfrdBxiUw7pC2P6iefI8mp65S4jZBg=
X-Gm-Gg: ASbGncvwmUWn1fsXxkhwne2HPQ3/cQTX9Oi/YoVgkLMDYv/S89tIkf0XlQl2htW5rj0
	zaKUH8kw2vMobs3VO+tGjQkkuw5wTAaPL7tLTG/PeIoE1XEG6iN26xkZJwRaw45mgZgcVsEijR2
	YTLbavxnt9Awbff6VadQFUvnd1DfAJQFFyLfoj/8lUknpiTGUp9InoupySr4RN2aAECetc1GdzE
	Vp00jwRK9niCkrBbXbRMY3gZGEx4zE7ocD9iy+YeltQ4rbQAqVmDS4FDsQNXa+psLFlYnaUrOoJ
	1/oYngP3cDC65DM3sKC8se+sVNfp2EEk4Wrb1b6KPZEvVyNONzSqy7PUJFKDMYkSmmceQHyJh80
	amIU3UPS7+4nmj3oEqk/T2+32GxNHy2I3rsYuNKyVLkDD9RyW2gU3iM0P+3AXwfO20A+RKpdzLY
	I=
X-Google-Smtp-Source: AGHT+IFTWrxSgTC2l5dPH7zS0dWJFEEgFXtWsP9ZePc+WhJK6g+xnGV3HMGvKKHwru3cuNJ86ZsSlw==
X-Received: by 2002:a05:6000:3107:b0:3b7:837c:5679 with SMTP id ffacd0b85a97d-3c32e6068ccmr1373896f8f.40.1755680102580;
        Wed, 20 Aug 2025 01:55:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:dc4b:4af3:f382:7aa7? ([2a01:e0a:3d9:2080:dc4b:4af3:f382:7aa7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b47c8e98dsm24191625e9.14.2025.08.20.01.55.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Aug 2025 01:55:02 -0700 (PDT)
Message-ID: <6b9fb458-bce1-4d16-a708-b05fdeb22d4d@linaro.org>
Date: Wed, 20 Aug 2025 10:55:01 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 7/7] PCI: qcom: Use frequency and level based OPP
 lookup
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
 Stephen Boyd <sboyd@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20250820-opp_pcie-v4-0-273b8944eed0@oss.qualcomm.com>
 <20250820-opp_pcie-v4-7-273b8944eed0@oss.qualcomm.com>
From: Neil Armstrong <neil.armstrong@linaro.org>
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
In-Reply-To: <20250820-opp_pcie-v4-7-273b8944eed0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/08/2025 10:28, Krishna Chaitanya Chundru wrote:
> PCIe supports multiple data rates that may operate at the same clock
> frequency by varying the link width. In such cases, frequency alone
> is insufficient to identify the correct OPP. Use the newly introduced
> dev_pm_opp_find_key_exact() API to match both frequency and
> level when selecting an OPP, here level indicates PCIe data rate.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>   drivers/pci/controller/dwc/pcie-qcom.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 294babe1816e4d0c2b2343fe22d89af72afcd6cd..4f40fc7b828483419b87057c53e2f754811bdda0 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1555,6 +1555,7 @@ static void qcom_pcie_icc_opp_update(struct qcom_pcie *pcie)
>   {
>   	u32 offset, status, width, speed;
>   	struct dw_pcie *pci = pcie->pci;
> +	struct dev_pm_opp_key key;
>   	unsigned long freq_kbps;
>   	struct dev_pm_opp *opp;
>   	int ret, freq_mbps;
> @@ -1582,8 +1583,10 @@ static void qcom_pcie_icc_opp_update(struct qcom_pcie *pcie)
>   			return;
>   
>   		freq_kbps = freq_mbps * KILO;
> -		opp = dev_pm_opp_find_freq_exact(pci->dev, freq_kbps * width,
> -						 true);
> +		key.freq = freq_kbps * width;
> +		key.level = speed;
> +		key.bw = 0;
> +		opp = dev_pm_opp_find_key_exact(pci->dev, key, true);
>   		if (!IS_ERR(opp)) {
>   			ret = dev_pm_opp_set_opp(pci->dev, opp);
>   			if (ret)
> 

Fine but you should still support DTs without the opp-level property as fallback,
since stable kernels has the opp tables without level property (v6.12+ for 8450/x1e, v6.16 for 8550/8650)

Neil

