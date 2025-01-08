Return-Path: <linux-pci+bounces-19572-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCD7A0686B
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 23:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D2963A37C2
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 22:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9443E204C34;
	Wed,  8 Jan 2025 22:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rx9HS+yp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67845204C2A;
	Wed,  8 Jan 2025 22:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736375696; cv=none; b=MyhUoDhFU/2DDiUwKpQOcAgjOUgPyC19RTRGSLFzj3ntWqbzgzCKUp9/Tl1A6N5SoFgyJ/NG7km8xIE8VvFs7QY4MrnG5OXWmXwc3ARkynN0LVLsZMveaU4sWsiu6BmcSfyYz9jvwcT2woNgmZq4JsgGx5VefmJ4lJmJhyEwfpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736375696; c=relaxed/simple;
	bh=qUnfcLL7DmzaEUrl0dbIayBRi5xKxhUN4wvIeYtQsiE=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=HPnYeI5Da3hgtkImZaWgmfqtl3b3sovJlDs9Y0HVdb9guKxINgfBgpZmlOKFOtvm1iKyfipFkw4LY6IXPO3E3UrbtgWec/9k/1aSPIMdn7oezwV3C2jiuU3/v2tlEGOxADrQhYU4X8GssRQw2WtvYoT6MuXUoQ4Fx7ArCcri5yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rx9HS+yp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4886C4CEE8;
	Wed,  8 Jan 2025 22:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736375695;
	bh=qUnfcLL7DmzaEUrl0dbIayBRi5xKxhUN4wvIeYtQsiE=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=rx9HS+ypENvBSNz7FKOl8bkHLl1SbM8t+gqHIOQotCIDp8bxrVNiW9XYEW10gtsya
	 W4rmJpKVx7zU0hdcdV/tWYhLOPfZy0bLJp0fZecRmssDaq/C+1bVug9adxB+qR4/6Q
	 ywpU2mwAUOHD4FNWKVEiH3abDCvGLtqI96nzCdLeFe5UVqSxA15YHWJIkmn5JDDcwP
	 IQYOdC/GZdQX81Q15tu3OubbAoulheSnKZ/JSB1/s1Pfhg2SNlUapeHecFPJnt43os
	 e7DivjNux5+Pw9vGFxP0f7lX14mt4+Lzed1akpRCOMlar7IoD2RoBeC8O9CwKXOgWy
	 sjWhU8zkbaHew==
Date: Wed, 08 Jan 2025 16:34:54 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: lpieralisi@kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, joyce.ooi@intel.com, bhelgaas@google.com, 
 krzk+dt@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org, 
 devicetree@vger.kernel.org, matthew.gerlach@altera.com, dinguyen@kernel.org, 
 conor+dt@kernel.org
To: Matthew Gerlach <matthew.gerlach@linux.intel.com>
In-Reply-To: <20250108165909.3344354-1-matthew.gerlach@linux.intel.com>
References: <20250108165909.3344354-1-matthew.gerlach@linux.intel.com>
Message-Id: <173637565876.1164245.9757409308054353190.robh@kernel.org>
Subject: Re: [PATCH v3 0/5] Add PCIe Root Port support for Agilex family of
 chips


On Wed, 08 Jan 2025 10:59:04 -0600, Matthew Gerlach wrote:
> This patch set adds PCIe Root Port support for the Agilex family of FPGA chips.
> Version 3 of this patch set removes patches that have been accepted.
> 
> Patch 1:
>   Add new compatible strings for the three variants of the Agilex PCIe controller IP.
> 
> Patch 2:
>   Add a label to the soc@0 device tree node to be used by patch 5.
> 
> Patch 3:
>   Add base dtsi for PCIe Root Port support of the Agilex family of chips.
> 
> Patch 4:
>   Add dts enabling PCIe Root Port support on an Agilex F-series Development Kit.
> 
> Patch 5:
>   Update Altera PCIe controller driver to support the Agilex family of chips.
> 
> D M, Sharath Kumar (1):
>   PCI: altera: Add Agilex support
> 
> Matthew Gerlach (4):
>   dt-bindings: PCI: altera: Add binding for Agilex
>   arm64: dts: agilex: add soc0 label
>   arm64: dts: agilex: add dtsi for PCIe Root Port
>   arm64: dts: agilex: add dts enabling PCIe Root Port
> 
>  .../bindings/pci/altr,pcie-root-port.yaml     |   9 +
>  arch/arm64/boot/dts/intel/Makefile            |   1 +
>  arch/arm64/boot/dts/intel/socfpga_agilex.dtsi |   2 +-
>  .../socfpga_agilex7f_socdk_pcie_root_port.dts |  16 ++
>  .../intel/socfpga_agilex_pcie_root_port.dtsi  |  55 ++++
>  drivers/pci/controller/pcie-altera.c          | 246 +++++++++++++++++-
>  6 files changed, 319 insertions(+), 10 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex7f_socdk_pcie_root_port.dts
>  create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex_pcie_root_port.dtsi
> 
> --
> 2.34.1
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y intel/socfpga_agilex7f_socdk_pcie_root_port.dtb' for 20250108165909.3344354-1-matthew.gerlach@linux.intel.com:

arch/arm64/boot/dts/intel/socfpga_agilex7f_socdk_pcie_root_port.dtb: /firmware/svc: failed to match any schema with compatible: ['intel,agilex-svc']
arch/arm64/boot/dts/intel/socfpga_agilex7f_socdk_pcie_root_port.dtb: /firmware/svc/fpga-mgr: failed to match any schema with compatible: ['intel,agilex-soc-fpga-mgr']
arch/arm64/boot/dts/intel/socfpga_agilex7f_socdk_pcie_root_port.dtb: cb-intosc-hs-div2-clk: 'clock-frequency' is a required property
	from schema $id: http://devicetree.org/schemas/clock/fixed-clock.yaml#
arch/arm64/boot/dts/intel/socfpga_agilex7f_socdk_pcie_root_port.dtb: cb-intosc-ls-clk: 'clock-frequency' is a required property
	from schema $id: http://devicetree.org/schemas/clock/fixed-clock.yaml#
arch/arm64/boot/dts/intel/socfpga_agilex7f_socdk_pcie_root_port.dtb: f2s-free-clk: 'clock-frequency' is a required property
	from schema $id: http://devicetree.org/schemas/clock/fixed-clock.yaml#
arch/arm64/boot/dts/intel/socfpga_agilex7f_socdk_pcie_root_port.dtb: clock-controller@ffd10000: 'clocks' is a required property
	from schema $id: http://devicetree.org/schemas/clock/intel,agilex.yaml#
arch/arm64/boot/dts/intel/socfpga_agilex7f_socdk_pcie_root_port.dtb: /soc@0/ethernet@ff800000: failed to match any schema with compatible: ['altr,socfpga-stmmac-a10-s10', 'snps,dwmac-3.74a', 'snps,dwmac']
arch/arm64/boot/dts/intel/socfpga_agilex7f_socdk_pcie_root_port.dtb: /soc@0/ethernet@ff800000: failed to match any schema with compatible: ['altr,socfpga-stmmac-a10-s10', 'snps,dwmac-3.74a', 'snps,dwmac']
arch/arm64/boot/dts/intel/socfpga_agilex7f_socdk_pcie_root_port.dtb: /soc@0/ethernet@ff802000: failed to match any schema with compatible: ['altr,socfpga-stmmac-a10-s10', 'snps,dwmac-3.74a', 'snps,dwmac']
arch/arm64/boot/dts/intel/socfpga_agilex7f_socdk_pcie_root_port.dtb: /soc@0/ethernet@ff802000: failed to match any schema with compatible: ['altr,socfpga-stmmac-a10-s10', 'snps,dwmac-3.74a', 'snps,dwmac']
arch/arm64/boot/dts/intel/socfpga_agilex7f_socdk_pcie_root_port.dtb: /soc@0/ethernet@ff804000: failed to match any schema with compatible: ['altr,socfpga-stmmac-a10-s10', 'snps,dwmac-3.74a', 'snps,dwmac']
arch/arm64/boot/dts/intel/socfpga_agilex7f_socdk_pcie_root_port.dtb: /soc@0/ethernet@ff804000: failed to match any schema with compatible: ['altr,socfpga-stmmac-a10-s10', 'snps,dwmac-3.74a', 'snps,dwmac']
arch/arm64/boot/dts/intel/socfpga_agilex7f_socdk_pcie_root_port.dtb: /soc@0/eccmgr: failed to match any schema with compatible: ['altr,socfpga-s10-ecc-manager', 'altr,socfpga-a10-ecc-manager']
arch/arm64/boot/dts/intel/socfpga_agilex7f_socdk_pcie_root_port.dtb: /soc@0/eccmgr: failed to match any schema with compatible: ['altr,socfpga-s10-ecc-manager', 'altr,socfpga-a10-ecc-manager']
arch/arm64/boot/dts/intel/socfpga_agilex7f_socdk_pcie_root_port.dtb: /soc@0/eccmgr/sdramedac: failed to match any schema with compatible: ['altr,sdram-edac-s10']
arch/arm64/boot/dts/intel/socfpga_agilex7f_socdk_pcie_root_port.dtb: /soc@0/eccmgr/ocram-ecc@ff8cc000: failed to match any schema with compatible: ['altr,socfpga-s10-ocram-ecc', 'altr,socfpga-a10-ocram-ecc']
arch/arm64/boot/dts/intel/socfpga_agilex7f_socdk_pcie_root_port.dtb: /soc@0/eccmgr/ocram-ecc@ff8cc000: failed to match any schema with compatible: ['altr,socfpga-s10-ocram-ecc', 'altr,socfpga-a10-ocram-ecc']
arch/arm64/boot/dts/intel/socfpga_agilex7f_socdk_pcie_root_port.dtb: /soc@0/eccmgr/usb0-ecc@ff8c4000: failed to match any schema with compatible: ['altr,socfpga-s10-usb-ecc', 'altr,socfpga-usb-ecc']
arch/arm64/boot/dts/intel/socfpga_agilex7f_socdk_pcie_root_port.dtb: /soc@0/eccmgr/usb0-ecc@ff8c4000: failed to match any schema with compatible: ['altr,socfpga-s10-usb-ecc', 'altr,socfpga-usb-ecc']
arch/arm64/boot/dts/intel/socfpga_agilex7f_socdk_pcie_root_port.dtb: /soc@0/eccmgr/emac0-rx-ecc@ff8c0000: failed to match any schema with compatible: ['altr,socfpga-s10-eth-mac-ecc', 'altr,socfpga-eth-mac-ecc']
arch/arm64/boot/dts/intel/socfpga_agilex7f_socdk_pcie_root_port.dtb: /soc@0/eccmgr/emac0-rx-ecc@ff8c0000: failed to match any schema with compatible: ['altr,socfpga-s10-eth-mac-ecc', 'altr,socfpga-eth-mac-ecc']
arch/arm64/boot/dts/intel/socfpga_agilex7f_socdk_pcie_root_port.dtb: /soc@0/eccmgr/emac0-tx-ecc@ff8c0400: failed to match any schema with compatible: ['altr,socfpga-s10-eth-mac-ecc', 'altr,socfpga-eth-mac-ecc']
arch/arm64/boot/dts/intel/socfpga_agilex7f_socdk_pcie_root_port.dtb: /soc@0/eccmgr/emac0-tx-ecc@ff8c0400: failed to match any schema with compatible: ['altr,socfpga-s10-eth-mac-ecc', 'altr,socfpga-eth-mac-ecc']
arch/arm64/boot/dts/intel/socfpga_agilex7f_socdk_pcie_root_port.dtb: /soc@0/eccmgr/sdmmca-ecc@ff8c8c00: failed to match any schema with compatible: ['altr,socfpga-s10-sdmmc-ecc', 'altr,socfpga-sdmmc-ecc']
arch/arm64/boot/dts/intel/socfpga_agilex7f_socdk_pcie_root_port.dtb: /soc@0/eccmgr/sdmmca-ecc@ff8c8c00: failed to match any schema with compatible: ['altr,socfpga-s10-sdmmc-ecc', 'altr,socfpga-sdmmc-ecc']






