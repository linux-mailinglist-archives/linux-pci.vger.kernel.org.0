Return-Path: <linux-pci+bounces-22570-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8000FA4821D
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 15:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71BCC3A646F
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 14:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417AA25E464;
	Thu, 27 Feb 2025 14:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rJKktULN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2AE25DD19
	for <linux-pci@vger.kernel.org>; Thu, 27 Feb 2025 14:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740668092; cv=none; b=qkQE3Ompn8p5GjEQ9mk6HttSjsDkXEWas99GdlZ5kfFdZT0qn1/wgKLHAdEzFkrAno19lUawa3g0CE/6zxQMoVQz5LHZGm2OI9uY6KXw8wRprPDg2XsNzaPuAtfqRiDyV7+omDUIIy55H/L1HSuST5RkxdkYXrZMGNgDSIC3M3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740668092; c=relaxed/simple;
	bh=KboGCxx7OgmWNnz4unI5atpIG8j1s+NhJgz2Wlu5UaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EXN2Pfpi2nwauQx5jhnX3IKJ2tSy2PyB0fwQYMksVsx3q3qnHe6Iun/0VbOzKvP5D4cJe8uC6JwxOreRCDdeAqZ9FcJE4daaEf673Os3KPzWPDoa666YA+sGOA7HUucDHJV2E2zSgZD/k3GxevNhcmBMdvSr5QyzEnPMv3ROQBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rJKktULN; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-54605bfcc72so2507851e87.0
        for <linux-pci@vger.kernel.org>; Thu, 27 Feb 2025 06:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740668088; x=1741272888; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sCMeltnZVSG7sz0LhzAVQweBa8yRnjaqRK41n2Tk0AM=;
        b=rJKktULNRwmz5XhYh7Ao7P2IEkXIaqACQ8BjfV+6U2+0ipde90bPpyfp2DHYol3aEw
         W/TcIzf9uZm4a9eW2uNIjX5BkP6/jvWigBzk/UIbEp5VKhoPH6tvgTdR7qXtPoDwbmaJ
         L86Uml4QaHSqiT7mAp5nXR2PkzLt1lvEOseWmTQ0UyfATE3LZPgGmTZPLq8c84JesUZL
         geqA4k3TdvE7EL7w2hZD78722+idldzwyqQRlPF9RsccMc+oFFFTFkE74S0MMHJ0HR0U
         N4dcM1I1aPha080jaZAOsZtziHr7uGY4sDk521TnuVR01IkKTl27dxbrg217v9+XEt5T
         SDRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740668088; x=1741272888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sCMeltnZVSG7sz0LhzAVQweBa8yRnjaqRK41n2Tk0AM=;
        b=WDt+4+R/C2od1ySPWUyqM480I+NLWHDwScOUels47OfaHsm+qpwtpBIXCnesvuXI15
         5SDrfdXtILgiVaZNH+vxnTsse9QQw2+NgNHxY4WAT98xeHLuUXQMh3ri/tkSeOWqiJof
         nZuWRolO3w34WGwhOcoCoNs1ZA0O0wMirGjpgLl/FBlU/+BuQ6s5Ir1rYWqIF2Zpdyg4
         CCO8q3EIFLdtCnYpD0D61XYnGXJ/mgTJhGqjGhoZFUo0bxmWgMTRPPjFVUGla+uMzh8N
         H0gFiBAsywkTL09aK5a5Snh+Gb7sUSj6MFRV5G4HP2JQq5HJFvxqe5+RzbxsrX70z3SI
         A02Q==
X-Forwarded-Encrypted: i=1; AJvYcCUFR3K7w1OFbS1LnAi2ihs7UxXRzdljW30CtQPMhGkf1ztQ99Xrk2WTfGqDXuWYrpXeEh7S+5ww/1I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3z0SAcjtOLOO9nK0aT2kW9OJTp+8Kb59HCdWFeD9bevELIvna
	IC/76hyXw4qiaGM1kGbjvtQEllRPr06MFjTx76FFNo0m2AY12GL9zhuwyl8DLVo=
X-Gm-Gg: ASbGncvqD68/3IN+cQH3ODwaNJX2lPsuh/Iwj3P+Xg7cLDvwsGaXmTLe4HNvjeEKn8V
	gGU3dBiOO7GgALU16PZtZ3U+y9Jr8SuqPEVVfuUutCiWrBFGa/uFDtM2KndqnbRpPwZsXR99T/J
	44La5GY285lW6iuyJwngQaSil253xPOmT+czIAYD9omCuCUgxt0XFy0BKm2oEBSjke9dw0HXoIH
	HlMEomlm1EaEILOLZ53BymQONxC9w0AKM+xbcYQxg7gKSfLah59Epr9TYGmnatZ2+UuUyoUe58W
	TB5gZ7Cl5RgTS+4oiLHmmB23/0xFYybBeMoYN+UQtijxW89g3mbVMS8K31RiIXzdUhEExB1PpvX
	MpXNPNg==
X-Google-Smtp-Source: AGHT+IF94UxahrgvKnqbDIyQP2SoOHuqTWRLMtDqEw4LEuHBKdFhk7jgfYz2acmAzH6fUFJ672CotA==
X-Received: by 2002:a05:6512:308c:b0:545:4f00:f92a with SMTP id 2adb3069b0e04-5494332104amr1421507e87.20.1740668088335;
        Thu, 27 Feb 2025 06:54:48 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549441741d4sm184217e87.33.2025.02.27.06.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 06:54:47 -0800 (PST)
Date: Thu, 27 Feb 2025 16:54:45 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: manivannan.sadhasivam@linaro.org
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/23] arm64: dts: qcom: Add 'global' IRQ to supported
 SoCs
Message-ID: <26ohpisuitzaghsxbbyjgb2rbhrubu4ipt7zopyuakxbgyqi7i@xa3tjwlwwjoq>
References: <20250227-pcie-global-irq-v1-0-2b70a7819d1e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227-pcie-global-irq-v1-0-2b70a7819d1e@linaro.org>

On Thu, Feb 27, 2025 at 07:10:42PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> Hi,
> 
> This series adds the Qualcomm specific 'global' IRQ to the supported SoCs.
> This IRQ is used to receive the PCIe controller and link specific events
> such as Link Up/Down, MSI, PTM etc... in the driver. Support for this IRQ
> was already added to the pcie-qcom driver. So enabling this IRQ would allow
> the driver to enumerate the endpoint device and also retrain the link when
> the device is removed [1] without user intervention.
> 
> This series also adds missing MSI SPI IRQ to some of the SoCs.
> 
> Testing
> =======
> 
> This series was tested on Qualcomm RB5 board based on SM8250 SoC and
> Qualcomm Ride MX board based on SA8775p SoC.
> 
> NOTE
> ====
> 
> I've left a few SoCs in the tree like QCS404, SC8280XP due to lack of
> documentation. Those will be added later.

Also IPQ9574. For the series:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> 
> [1] https://lore.kernel.org/linux-pci/20250221172309.120009-1-manivannan.sadhasivam@linaro.org/
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
> Manivannan Sadhasivam (23):
>       dt-bindings: PCI: qcom,pcie-sm8150: Add 'global' interrupt
>       arm64: dts: qcom: sm8150: Add 'global' PCIe interrupt
>       dt-bindings: PCI: qcom,pcie-sm8250: Add 'global' interrupt
>       arm64: dts: qcom: sm8250: Add 'global' PCIe interrupt
>       dt-bindings: PCI: qcom,pcie-sm8350: Add 'global' interrupt
>       arm64: dts: qcom: sm8350: Add 'global' PCIe interrupt
>       dt-bindings: PCI: qcom,pcie-sa8775p: Add 'global' interrupt
>       arm64: dts: qcom: sa8775p: Add 'global' PCIe interrupt
>       dt-bindings: PCI: qcom,pcie-sc7280: Add 'global' interrupt
>       arm64: dts: qcom: sc7280: Add 'global' PCIe interrupt
>       dt-bindings: PCI: qcom: Add 'global' interrupt for SDM845 SoC
>       arm64: dts: qcom: sdm845: Add missing MSI and 'global' IRQs
>       arm64: dts: qcom: msm8996: Add missing MSI SPI interrupts
>       dt-bindings: PCI: qcom: Allow MSM8998 to use 8 MSI and one 'global' interrupt
>       arm64: dts: qcom: msm8998: Add missing MSI and 'global' IRQs
>       dt-bindings: PCI: qcom: Allow IPQ8074 to use 8 MSI and one 'global' interrupt
>       arm64: dts: qcom: ipq8074: Add missing MSI and 'global' IRQs
>       dt-bindings: PCI: qcom: Allow IPQ6018 to use 8 MSI and one 'global' interrupt
>       arm64: dts: qcom: ipq6018: Add missing MSI and 'global' IRQs
>       dt-bindings: PCI: qcom,pcie-sc8180x: Add 'global' interrupt
>       arm64: dts: qcom: sc8180x: Add 'global' PCIe interrupt
>       arm64: dts: qcom: sar2130p: Add 'global' PCIe interrupt
>       arm64: dts: qcom: x1e80100: Add missing 'global' PCIe interrupt
> 
>  .../devicetree/bindings/pci/qcom,pcie-sa8775p.yaml | 10 ++--
>  .../devicetree/bindings/pci/qcom,pcie-sc7280.yaml  |  9 ++--
>  .../devicetree/bindings/pci/qcom,pcie-sc8180x.yaml | 10 ++--
>  .../devicetree/bindings/pci/qcom,pcie-sm8150.yaml  |  9 ++--
>  .../devicetree/bindings/pci/qcom,pcie-sm8250.yaml  |  9 ++--
>  .../devicetree/bindings/pci/qcom,pcie-sm8350.yaml  |  9 ++--
>  .../devicetree/bindings/pci/qcom,pcie.yaml         | 14 ++++--
>  arch/arm64/boot/dts/qcom/ipq6018.dtsi              | 20 +++++++-
>  arch/arm64/boot/dts/qcom/ipq8074.dtsi              | 40 ++++++++++++++--
>  arch/arm64/boot/dts/qcom/msm8996.dtsi              | 54 +++++++++++++++++++---
>  arch/arm64/boot/dts/qcom/msm8998.dtsi              | 20 +++++++-
>  arch/arm64/boot/dts/qcom/sa8775p.dtsi              | 28 ++++++++---
>  arch/arm64/boot/dts/qcom/sar2130p.dtsi             | 12 +++--
>  arch/arm64/boot/dts/qcom/sc7280.dtsi               | 14 ++++--
>  arch/arm64/boot/dts/qcom/sc8180x.dtsi              | 24 ++++++----
>  arch/arm64/boot/dts/qcom/sdm845.dtsi               | 40 ++++++++++++++--
>  arch/arm64/boot/dts/qcom/sm8150.dtsi               | 12 +++--
>  arch/arm64/boot/dts/qcom/sm8250.dtsi               | 18 +++++---
>  arch/arm64/boot/dts/qcom/sm8350.dtsi               | 12 +++--
>  arch/arm64/boot/dts/qcom/x1e80100.dtsi             | 18 +++++---
>  20 files changed, 300 insertions(+), 82 deletions(-)
> ---
> base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
> change-id: 20250227-pcie-global-irq-dd1cd5688d71
> 
> Best regards,
> -- 
> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> 

-- 
With best wishes
Dmitry

