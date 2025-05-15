Return-Path: <linux-pci+bounces-27780-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3581CAB84FA
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 13:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0C6F1BC1FAF
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 11:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8A9222586;
	Thu, 15 May 2025 11:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MvWNruar"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCDD298275
	for <linux-pci@vger.kernel.org>; Thu, 15 May 2025 11:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747308632; cv=none; b=Bm3GnH4eiVrJA3iyNTl5px1Q73N8bE7GbvD2LDGG5qPiWHxjsDi2pDKgRG1ubVL47o8RNqoXQY+4zE8FNkK4n1m1lGwRyn1lhDSDsC+TMzhtf29JwpKad1BQ+iz4cLK+ifkluETJtZT6aHQeXhkBh05DvXWErEYw1SSSBEhbHPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747308632; c=relaxed/simple;
	bh=UxmxWDtTNxz4UkuAhMesCDbToXhLDINegkNSlIWcX+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=orCkUDgW7aQkXyh4GclvjJ6y2j15gh7jAkCOk+vCLJvgWHUaBU19F1xTvSD85OB0jO9xlNvU25CkC1PcWa+ogub7Uit9wyOoHHumzpay2eAmOY9KscyB0s8mMuxs0kw3HVhauHVCGe4wEBtYBV79wcd/uABq2OiLQjateL4EilY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MvWNruar; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a0b9625662so705089f8f.3
        for <linux-pci@vger.kernel.org>; Thu, 15 May 2025 04:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747308628; x=1747913428; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cxppJmf9UDttPWLLLNWxW9/hdmIXIIsGflBYvlk55PI=;
        b=MvWNruarb3bF56bdPtbZWFyWsrye3rm9Bl0+YZCxK69bxDp32Ay1I34dAAhpVsnGIn
         dSOmJYLT8UTbp6iU2ddozqhvd61+KxYDQCkYVgWBIFF2JGNZY+WgPsWqbRph23dmslHv
         UvGBebu6rS/VQxxJAGbgzKo+sIGYBETkOncKvRj8ZCI2p8tYnikzmCAv5/5rKjTJZNop
         V6iCbXPVf+32J0ZELwJ/jiLICyXNj2m/QsmA6yu6Ha/tYFaLofsbjhN5FgKPZzqp0IPN
         ppgBI4cQp/1iWRC0si1u3j2jbyODHjm1rLEDQo6M1fSaHyhWE3S5vgBHr09xS5ZpN+NF
         3K9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747308628; x=1747913428;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cxppJmf9UDttPWLLLNWxW9/hdmIXIIsGflBYvlk55PI=;
        b=vRCKkeSDvkI2WWwLJEOtx0JaXku025W4csdb2+DnkkxYKdiZpNru/18FCyfPzUokl2
         2ENUS2N3pRSj7hLv52OiiJaQv9MAXvzet+ca/4uUfsPCh4QpQG1EBb/XvSm6WL0ic3kJ
         pr0lnNpRkunP6u0KStZGbMIJRTaPuZitlVSjxuNbIys5mGzcAU0vYNyDsgDiaLK2aJnA
         kSqwh3sWLY/dVCbprjhS9Dmsn7xtwkTj3sex0+nlUYpbuLilzJ3JFOv2OiAmP2N++gfG
         hVH7xgHK/BDMMOhdk7EyHU5e+VgOVsscnEFY2Mth0p2cXAa3N86WyMreAwDmkWaFQH/G
         GGOA==
X-Forwarded-Encrypted: i=1; AJvYcCW0wJ+6SJ9xyOs7wUilqr2nEfj1qT3TcDoChF9jUteJKYml3nspMcssnMsU7XLXxF5+soKzf7lypgI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq3Q1ohmw/p0Hz7xnZU2tnHrhcxGxZjnRMayYBsRyWoRjZ47FJ
	S/Naf1+LXPdvls9vDr6Fl0pyAmCnYLdAhX38hL8Fe1oSKLDlI+PnjX4g9pLrRA==
X-Gm-Gg: ASbGncv83tEyOb2hwH72Jy7M6Yulb5H95KHGdpjtjNrAidISYhbSKoYGLlvRXkPMtMx
	Dkt7iz+C+dr3FpMJpE2T+dSIYjIoTkDKd9fFwcgevz8l4MJrbR+mbOKLL7AGZrNreowETbnyV5r
	fYbb8+4IZxYoKVlEFXus0ebv+Ya7CcDIofjvIh9SgT/IICuIEMWv5dNcs44VLf1eWozdxt1qOPJ
	COTinl9N0FEV9x7fPiTx2LxEQstPJc5J9+VcSHrenHxYfl7+OQmWB8a/aX80G6yrPXxsl3jl8Nz
	EzU38tUWFZD2Nj7OEALChgkDd8Jm/zDPUhLfK0tYCZQhjp0pTQTFafsIGcwdodmAibWnkarz+8U
	mLiClxnGFJYwEIg==
X-Google-Smtp-Source: AGHT+IFjyhky0WjJzQJQ5Ed1Oysv28o+Tx9PsLGNR0Eb6F+Ar6MSQ3hQvGlBY2Vc8Vp6DQEa27in4A==
X-Received: by 2002:a5d:5983:0:b0:3a1:f6fd:63fc with SMTP id ffacd0b85a97d-3a34994b188mr6493795f8f.47.1747308628493;
        Thu, 15 May 2025 04:30:28 -0700 (PDT)
Received: from thinkpad (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a22ea7a53asm10520669f8f.23.2025.05.15.04.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 04:30:27 -0700 (PDT)
Date: Thu, 15 May 2025 12:30:24 +0100
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, 
	bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org, 
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, p.zabel@pengutronix.de, 
	thippeswamy.havalige@amd.com, shradha.t@samsung.com, quic_schintav@quicinc.com, 
	cassel@kernel.org, johan+linaro@kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 0/9] Add STM32MP25 PCIe drivers
Message-ID: <ey7s64iavsb64eavu7i55b7nflqexn7nb65wcrlrqgo63mv6jt@ueut7quj6qpp>
References: <20250514091530.3249364-1-christian.bruel@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250514091530.3249364-1-christian.bruel@foss.st.com>

On Wed, May 14, 2025 at 11:15:21AM +0200, Christian Bruel wrote:
> Changes in v9:
>    - Describe atu and dbi2 shadowed registers in pcie_ep node
>    Address RC and EP drivers comments from Manivanna:
>    - Use dev_error_probe() for pm_runtime_enable() calls
>    - Reword Kconfig help message
>    - Move pm_runtime_get_noresume() before devm_pm_runtime_enable()

Please do not post the next revision without resolving all the comments for the
previous one. It just adds more noise.

- Mani

> 
> Changes in v8:
>    - Whitespace in comment
>    
> Changes in v7:
>    - Use device_init_wakeup to enable wakeup
>    - Fix comments (Bjorn)
> 
> Changes in v6:
>    - Call device_wakeup_enable() to fix WAKE# wakeup.
>    Address comments from Manivanna:
>    - Fix/Add Comments
>    - Fix DT indents
>    - Remove dw_pcie_ep_linkup() in EP start link
>    - Add PCIE_T_PVPERL_MS delay in RC PERST# deassert
>    
> Changes in v5:
>    Address driver comments from Manivanna:
>    - Use dw_pcie_{suspend/resume}_noirq instead of private ones.
>    - Move dw_pcie_host_init() to probe
>    - Add stm32_remove_pcie_port cleanup function
>    - Use of_node_put in stm32_pcie_parse_port
>    - Remove wakeup-source property
>    - Use generic dev_pm_set_dedicated_wake_irq to support wake# irq
>    
> Changes in v4:
>    Address bindings comments Rob Herring
>    - Remove phy property form common yaml
>    - Remove phy-name property
>    - Move wake_gpio and reset_gpio to the host root port
>    
> Changes in v3:
>    Address comments from Manivanna, Rob and Bjorn:
>    - Move host wakeup helper to dwc core (Mani)
>    - Drop num-lanes=<1> from bindings (Rob)
>    - Fix PCI address of I/O region (Mani)
>    - Moved PHY to a RC rootport subsection (Bjorn, Mani)
>    - Replaced dma-limit quirk by dma-ranges property (Bjorn)
>    - Moved out perst assert/deassert from start/stop link (Mani)
>    - Drop link_up test optim (Mani)
>    - DT and comments rephrasing (Bjorn)
>    - Add dts entries now that the combophy entries has landed
>    - Drop delaying Configuration Requests
> 
> Changes in v2:
>    - Fix st,stm32-pcie-common.yaml dt_binding_check	
> 
> Changes in v1:
>    Address comments from Rob Herring and Bjorn Helgaas:
>    - Drop st,limit-mrrs and st,max-payload-size from this patchset
>    - Remove single reset and clocks binding names and misc yaml cleanups
>    - Split RC/EP common bindings to a separate schema file
>    - Use correct PCIE_T_PERST_CLK_US and PCIE_T_RRS_READY_MS defines
>    - Use .remove instead of .remove_new
>    - Fix bar reset sequence in EP driver
>    - Use cleanup blocks for error handling
>    - Cosmetic fixes
> 
> Christian Bruel (9):
>   dt-bindings: PCI: Add STM32MP25 PCIe Root Complex bindings
>   PCI: stm32: Add PCIe host support for STM32MP25
>   dt-bindings: PCI: Add STM32MP25 PCIe Endpoint bindings
>   PCI: stm32: Add PCIe Endpoint support for STM32MP25
>   MAINTAINERS: add entry for ST STM32MP25 PCIe drivers
>   arm64: dts: st: add PCIe pinctrl entries in stm32mp25-pinctrl.dtsi
>   arm64: dts: st: Add PCIe Root Complex mode on stm32mp251
>   arm64: dts: st: Add PCIe Endpoint mode on stm32mp251
>   arm64: dts: st: Enable PCIe on the stm32mp257f-ev1 board
> 
>  .../bindings/pci/st,stm32-pcie-common.yaml    |  33 ++
>  .../bindings/pci/st,stm32-pcie-ep.yaml        |  67 +++
>  .../bindings/pci/st,stm32-pcie-host.yaml      | 112 +++++
>  MAINTAINERS                                   |   7 +
>  arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi |  20 +
>  arch/arm64/boot/dts/st/stm32mp251.dtsi        |  57 +++
>  arch/arm64/boot/dts/st/stm32mp257f-ev1.dts    |  21 +
>  drivers/pci/controller/dwc/Kconfig            |  24 +
>  drivers/pci/controller/dwc/Makefile           |   2 +
>  drivers/pci/controller/dwc/pcie-stm32-ep.c    | 411 ++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-stm32.c       | 364 ++++++++++++++++
>  drivers/pci/controller/dwc/pcie-stm32.h       |  16 +
>  12 files changed, 1134 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/st,stm32-pcie-common.yaml
>  create mode 100644 Documentation/devicetree/bindings/pci/st,stm32-pcie-ep.yaml
>  create mode 100644 Documentation/devicetree/bindings/pci/st,stm32-pcie-host.yaml
>  create mode 100644 drivers/pci/controller/dwc/pcie-stm32-ep.c
>  create mode 100644 drivers/pci/controller/dwc/pcie-stm32.c
>  create mode 100644 drivers/pci/controller/dwc/pcie-stm32.h
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

