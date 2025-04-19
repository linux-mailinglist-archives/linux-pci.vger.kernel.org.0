Return-Path: <linux-pci+bounces-26272-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 999DBA94243
	for <lists+linux-pci@lfdr.de>; Sat, 19 Apr 2025 10:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 352F819E25C3
	for <lists+linux-pci@lfdr.de>; Sat, 19 Apr 2025 08:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE911FB3;
	Sat, 19 Apr 2025 08:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hvql5noU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B132F7E1
	for <linux-pci@vger.kernel.org>; Sat, 19 Apr 2025 08:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745051616; cv=none; b=RxarwZ+22UicD+cP12P2o2FMOT88vuAY6xOJRgAkStOZ5E0qSV/8zyGfbrILaGGI+JSBamn45GAhfZKQ/DbK1QA+s1FavOZX3bqOj93Wwe3eZsQg33RbeY6LPIysBvByMOq/BkS5CSYOwqHrLxKAHr6REtQcsmt1GcfaFt3lUqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745051616; c=relaxed/simple;
	bh=tnZpf7E4jUTvl0WeReZ1fpPOpf5sY8X3PMWxEUc/hMQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hzd6NLNS9OA/WNvwVpypm6/JC99R5S0Cmlb8/aY1smSNKvZLxZ8wNPgCqJWkKzurXocaOjRcLK2VNJ7GbffbMo+JQFnAQ4FfzTXeK00urYuDUZYWoB2CUjhHTgn0OQfpRf33bjgFvb4QruiU+wb1Hrb8qZ+vWzZTtxTtRHIKyWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hvql5noU; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-226185948ffso28905235ad.0
        for <linux-pci@vger.kernel.org>; Sat, 19 Apr 2025 01:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745051614; x=1745656414; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YaJakh9xM66cZD5S9FiPEP38vFx8wsqvS4Jg/X0PNME=;
        b=hvql5noUBWhduRELCjYuWxqsXM62h38FUzeIfIza036HvLEHXf8e+4mgayEQjr2H61
         PrhhzSEyoFzB0lLAepUKf+0QuF8ZqK/QkJgaD+cSvgybT/pla/RFn7N5subfYCpHRS0t
         yCXlW6gIZ6v+6hEIcIHNmTvFZeflIXRlsHr2lZPtr4A40ZME5IZXeLpIrWSKWLUen6y8
         fIHIMHOTiMBdITYQUDwu6D/uOkQ/RzX3SXsOEwB0VxrPeIqrrJMdbJMEQPdEIHziljBX
         XsNpyg7DUJqJg8YYShxm0bVy3SH1g5/83u3oOFPUuRwiZfjJsO4fYYbwytDRKouIdLbY
         5luA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745051614; x=1745656414;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YaJakh9xM66cZD5S9FiPEP38vFx8wsqvS4Jg/X0PNME=;
        b=ApowxDanU/eEgwODjcjwl1sS/WINZQqi1pwwUR78cx2Lv/a+ECGusGwmPUKnBRRV5G
         XIlaQi8al9P370etSkAtGmbxCgVMPp2RAs+TMW9RPE9VbBwkvxBlKUTkUL6Jf9vFXmTZ
         QidLct2eoEPoNVarSZLu9cCwYix2c5z3I5P7HT7Iwo0bILFDsShmIUiZPTTo/vIwbCdZ
         6s1GHp0ZqI7i9QeMaLyvHCGITEvZcgOjR/ezfFvMPK7qJEaAtlN3pWvJJYlmVfWwCK3J
         8lWmGqKeHHN9wtA5DOvh2GTnE2DcSN9P6Q0Fx7SozcUNVOQAwz6Kbx3HxvNjHJgVt49f
         WTmg==
X-Forwarded-Encrypted: i=1; AJvYcCVxJ9fOQPvGqZfTy39a6Ftw/yNF1zjCBlQCskm3/7NU9kKwqTeD3qJ1h1dKME/nCqCop9UHR0QgmyU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvbc7Nm5wZ5iWXVvkMz4lAhBzCCzLBSNM9F1q1Pqu28UHtwHzY
	KGlI6X5vC5flA2vSK8vtmFw+vuivVefi37Zs7swrJClFbwvMOFL/lY6xTtAs7A==
X-Gm-Gg: ASbGncuoKnVY+vzbE0yfvFd6haDg7CXzlHpif1V9anh9FLKAMg/FcS3uBFiCM546zjh
	1li26xOR1R4GHEshsn3UuDD7BPMZkjSxusWUjdOlyJCb8GN11wiTrjt4T57Ajxk1ndYmOL7ozzV
	gG3CMsm2vQpWXqxs9wDjFYX4Y2oYVmHnzaI3hS2FtIWMnHd9vviD37DvMOP1Xzvkgqb/6fX2nB3
	oWKWd/sYkhoRbC27h/P2OrY2jsj4qlSdC6QX7Z55idft72+/4qSgl1OzjTu5xeZs1k0922YU6qY
	3NLlvBrCvB+IXcPDu/lM19yUHMeGEeRDpv9ELmzY3SawXAuzO5s=
X-Google-Smtp-Source: AGHT+IETJzORaZc9rUcQZjfqRJ8DIbC4gX4Kf2XDO9y1bvddXq8XcEhC0o1p38D01fW61AQYlWaodA==
X-Received: by 2002:a17:903:2441:b0:220:ea90:191e with SMTP id d9443c01a7336-22c535679abmr74340825ad.4.1745051614002;
        Sat, 19 Apr 2025 01:33:34 -0700 (PDT)
Received: from thinkpad ([36.255.17.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50bf5425sm29195875ad.98.2025.04.19.01.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 01:33:33 -0700 (PDT)
Date: Sat, 19 Apr 2025 14:03:27 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/23] arm64: dts: qcom: Add 'global' IRQ to supported
 SoCs
Message-ID: <zm75vxwx7pgcu6sok4g5ujrg2drc2jst3gscrl46jr7votygoo@5qsdre2fxtre>
References: <20250227-pcie-global-irq-v1-0-2b70a7819d1e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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
> 
> [1] https://lore.kernel.org/linux-pci/20250221172309.120009-1-manivannan.sadhasivam@linaro.org/
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Applied the bindings patches to pci/dt-bindings!

- Mani

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
மணிவண்ணன் சதாசிவம்

