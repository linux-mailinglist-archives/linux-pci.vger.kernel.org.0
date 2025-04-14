Return-Path: <linux-pci+bounces-25831-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A1EA880C8
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 14:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 814077A5413
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 12:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13962BD5A0;
	Mon, 14 Apr 2025 12:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hH0gb+8Y"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0B029C333
	for <linux-pci@vger.kernel.org>; Mon, 14 Apr 2025 12:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744634945; cv=none; b=I27+0UINMTgQ97uQFPXCQ0SJUk1TYUdS+L4cP3nbNw3SncpdifvBe+riSi+ZR2YhOOCXCw44IwE5Uzl52hlP5wKOy4iip63Xg3Y7uat/GdwxW3Ms4xZD+PiZxY4URGRkng+01iSXzTbz3TG4OlVVfwTmubsFAhWKt8rHNPduQ90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744634945; c=relaxed/simple;
	bh=pgTXZ7T0kREJFhqQfhjzGMWPlR9y7pVF4ppbZuRjtYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f7sii07ezptedrFiECipue9YAjRmLux3Gjx0F+Mu5kJqJi7jkFoWg8wGXa0AkXg6SPo3NjCbRpGxuomH5j0WLys9kyVxK3yJMMKbW/zpxzK4xutBkGp7ocFBfq7vE5LJdH0URqC9+ku4Uc30YtmshHoGzlsImh8j19pOVjm49ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hH0gb+8Y; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43d0618746bso32849445e9.2
        for <linux-pci@vger.kernel.org>; Mon, 14 Apr 2025 05:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744634942; x=1745239742; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sAiRwoIBQeS8CLJ0a9KnyQoPyTuXm99/84zDGKBFhxE=;
        b=hH0gb+8YxhU5JeA/nHAVxlIP/GA2V9oHeo0OAj8dxCJCVe3GjldCByx2DzxU9dZYqx
         zUmLt7/c6I+V4wm7rD/pHJNCuhT8xDtk+UhfZhtYMj9EoiXBqi40tuvAAhwkXLNLFIbo
         FNDa+L9GPCrik/YDukEdmM4LvdtfAQs4jh04t3AhFsGIHnnof7zurxubXYCFcycStnFc
         0fZual7PLrnMm8NgCRWMA1bzM/xtRoapbUuZhJFMYe1qGSmVPZHcytN1ueIhas/2ea7q
         0PVAZYKMDS8ZtX50I6ueSiWIjad7A1ITsS/tJsW7FeF8/ggqGrK1MT5U5Mu37M5U6CZZ
         QHCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744634942; x=1745239742;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sAiRwoIBQeS8CLJ0a9KnyQoPyTuXm99/84zDGKBFhxE=;
        b=R8KJVCXxbFflDC4elo/6WuaqGtjYiklRAGIZ7Y9vALHHWe+6ouBsgNp7bp14R+9jdV
         oHjeGjPBbeooT0mNq4Rgi5lSX9bltPnEslK4/RmRHyezUpFqnIvWPCTCFz+n+Tryvgnr
         USBoeZ3NQhER4hdKVMcJ/1UIJ7f4o8xOWWKLP7mq3EtyZeWvNjq6bD0Woxtx99d/q5pD
         Tznm8Mpaj2PBogYc9X9BGHT1efRXxjlcyvdWQQfO1lW0ws4RnuV2lT2AaosqLoJJ0x1A
         WW+njHiKzy1SXJbbdzbIhiQhDvyPWhSpNqL9x/5rAzCmXjbZyp4YvEWrDmFbztseXBMF
         DeFg==
X-Forwarded-Encrypted: i=1; AJvYcCXjfLX6v9SS721mz305Rkr/2/vk0vkjde4tHc3MrPWzSKdxAyxOHH8CgM5VLy67IPM6nJgXGN1tY3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyntCSg7JQpsIZGDg531tdgu5uld6vOg6ZWONQWscD3yGCkoiag
	lviPT9qVkzCCoa9JblL2x1/fWWmNQvqwCD1P/PACEcd7oOtemWUFRDbNWZuWQD8=
X-Gm-Gg: ASbGnctw9SLZPyopo6O2yHvV1Rsd63MdiAh2/HVnEDfAjQOsrCqUAOmEiTfAW4V89Au
	1pTDsgfRjF41BERRN6LcpEPNhST1zByqyELCUReh37qod+vtrxJ2jrsailiTXqeyGTlpoWa49a/
	Qjq2FzT3QJon5RKkd/Mi8tnXvYhoGj0G6pyL4K4pdEDlGLvM1FL6TOf+1J7dpZ0884XO/ZS4ut1
	7z/ayELU3QmBCYPRHnZ7PENYhLl3rTsAHDEOdFpv1BjEp7yK42rSQNP9MSyUDa+F+V12JTLTQMv
	lF8eLMQbBq3V7jkHE64XU/a0+6UyIXPnCixB/vmJof9CCMN9pSFTP+GQx218S+aBWmkkvCc=
X-Google-Smtp-Source: AGHT+IETwcdqSWAHTq3QoeUATJXYSc4gAa1L7vf/YNEJK/cRM1V6QRl3HprdoCFJadXMO+Mj9tQQ4w==
X-Received: by 2002:a05:600c:4e09:b0:43d:45a:8fca with SMTP id 5b1f17b1804b1-43f3a9b035fmr130109435e9.30.1744634942029;
        Mon, 14 Apr 2025 05:49:02 -0700 (PDT)
Received: from [192.168.1.47] (i5E863B76.versanet.de. [94.134.59.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2075fc78sm180134335e9.27.2025.04.14.05.49.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Apr 2025 05:49:01 -0700 (PDT)
Message-ID: <511f8414-bbb1-4069-a0a6-f7505190c1e0@linaro.org>
Date: Mon, 14 Apr 2025 14:49:00 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] arm64: qcom: sc7280: Move phy, perst to root port
 node
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 quic_vbadigan@quicinc.com, quic_mrana@quicinc.com
References: <20250414-perst-v2-0-89247746d755@oss.qualcomm.com>
 <20250414-perst-v2-2-89247746d755@oss.qualcomm.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20250414-perst-v2-2-89247746d755@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/14/25 07:39, Krishna Chaitanya Chundru wrote:
> Move phy, perst, to root port from the controller node.
> 
> Rename perst-gpios to reset-gpios to align with the expected naming
> convention of pci-bus-common.yaml.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>   arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts   | 5 ++++-
>   arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 5 ++++-
>   arch/arm64/boot/dts/qcom/sc7280-idp.dtsi       | 5 ++++-
>   arch/arm64/boot/dts/qcom/sc7280.dtsi           | 6 ++----
>   4 files changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> index 7a36c90ad4ec8b52f30b22b1621404857d6ef336..3dd58986ad5da0f898537a51715bb5d0fecbe100 100644
> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> @@ -709,8 +709,11 @@ &mdss_edp_phy {
>   	status = "okay";
>   };
>   
> +&pcie1_port0 {
> +	reset-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
> +};
> +
>   &pcie1 {
> -	perst-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
>   
>   	pinctrl-0 = <&pcie1_reset_n>, <&pcie1_wake_n>;
>   	pinctrl-names = "default";
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> index 2ba4ea60cb14736c9cfbf9f4a9048f20a4c921f2..ff11d85d015bdab6a90bd8a0eb9113a339866953 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> @@ -472,10 +472,13 @@ &pcie1 {
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&pcie1_clkreq_n>, <&ssd_rst_l>, <&pe_wake_odl>;
>   
> -	perst-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
>   	vddpe-3v3-supply = <&pp3300_ssd>;
>   };
>   
> +&pcie1_port0 {
> +	reset-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
> +};
> +
>   &pm8350c_pwm {
>   	status = "okay";
>   };
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> index 7370aa0dbf0e3f9e7a3e38c3f00686e1d3dcbc9f..3209bb15dfec36299cabae07d34f3dc82db6de77 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> @@ -414,9 +414,12 @@ &lpass_va_macro {
>   	vdd-micb-supply = <&vreg_bob>;
>   };
>   
> +&pcie1_port0 {
> +	reset-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
> +};
> +
>   &pcie1 {
>   	status = "okay";
> -	perst-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
>   
>   	vddpe-3v3-supply = <&nvme_3v3_regulator>;
>   
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 0f2caf36910b65c398c9e03800a8ce0a8a1f8fc7..376fabf3b4eac34d75bb79ef902c9d83490c45f7 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -2271,9 +2271,6 @@ pcie1: pcie@1c08000 {
>   
>   			power-domains = <&gcc GCC_PCIE_1_GDSC>;
>   
> -			phys = <&pcie1_phy>;
> -			phy-names = "pciephy";

Isn't this a huge API breakage that will break using new DT with old 
kernels? It will also break U-boot which uses upstream DT.

This is bad enough, but at least let's break it a clean break by 
changing all platforms at once.

As I understand it, we seem to allow these breakages in DT for now (and 
this patch landing will confirm that), but perhaps we could at least 
track them somewhere or at acknowledge the breakage with a tag in the 
commit message pointing to the relevant dt-bindings patch.

Breaks-dt: 
https://lore.kernel.org/linux-arm-msm/20250414-perst-v2-1-89247746d755@oss.qualcomm.com

Kind regards,

> -
>   			pinctrl-names = "default";
>   			pinctrl-0 = <&pcie1_clkreq_n>;
>   
> @@ -2284,7 +2281,7 @@ pcie1: pcie@1c08000 {
>   
>   			status = "disabled";
>   
> -			pcie@0 {
> +			pcie1_port0: pcie@0 {
>   				device_type = "pci";
>   				reg = <0x0 0x0 0x0 0x0 0x0>;
>   				bus-range = <0x01 0xff>;
> @@ -2292,6 +2289,7 @@ pcie@0 {
>   				#address-cells = <3>;
>   				#size-cells = <2>;
>   				ranges;
> +				phys = <&pcie1_phy>;
>   			};
>   		};
>   
> 

-- 
Caleb (they/them)


