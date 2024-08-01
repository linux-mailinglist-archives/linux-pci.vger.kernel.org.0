Return-Path: <linux-pci+bounces-11112-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD657944F35
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2024 17:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CF5EB25A01
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2024 15:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9EE1B150E;
	Thu,  1 Aug 2024 15:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B4jA4XyV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F9B1B1500;
	Thu,  1 Aug 2024 15:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722526174; cv=none; b=cxmch+YSu0whPSZrSjS+5hy97aOb+Zby7B1bcOrs3xkmfx+Osxii8yHQoE9lL8UwsQhSD2tSDB8wVZM9W/crC/v7ISN7VknJ3Ju3Zdc62gX3CYf5n5ccFjGWyFpMEuGqclQxPlg7lUiHnWXktD7DK5A28PkFzxvJ4xUuHfPcC70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722526174; c=relaxed/simple;
	bh=FbmbzTFxN58ftHLh71DWR+4cCKAmUjn7TgMEmB6sFYU=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=dheXAunIEnHB3sRtJOcdoKg+GV35tPirL4n7ahdfVb+vUabBW2Nk6pfT2aw39aZB7dTptlq7VG5GqW9p4Byb1FtkDEbRTp04z6TJUJU7s0W6T2r7Hd3tLqxr17ps3GHBSMPy7DN7lCi6WT8yQ7Yon1ejrkZlaWPaCeurhF9Zvgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B4jA4XyV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2204C32786;
	Thu,  1 Aug 2024 15:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722526174;
	bh=FbmbzTFxN58ftHLh71DWR+4cCKAmUjn7TgMEmB6sFYU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=B4jA4XyVSMZxrVCdqEpkeJYr7xgAe2GkviSKDqmGTOO2NbZD7P3BhqjBJIpeAFInU
	 dxtoaqibjnmJ41NnBnUEpEhcgxDJmgBGXbH4k7cErcJtBHFYqjG2P5SPCabyKVtkTc
	 lHUYFhBjU2GbXt0eo1HR5oeR+EwG8lcWohBrSc564ah/nJDYxqzwACQMf4jqaoJ98w
	 g0ggiQJrp45O+5ai8+ThJeuOlO+Y6OAWJVov+QAaot/W812+spYV38SpZ/92Fxy5nw
	 Sf8Igz0vP7jOXyj6sSeBEb42e8JRE3vFoE1wM9PEmGNWLyXtvk1zYerBXf3qG5VFRP
	 2d3CZdTchBmKQ==
Date: Thu, 01 Aug 2024 09:29:32 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: matthew.gerlach@linux.intel.com
Cc: conor+dt@kernel.org, lpieralisi@kernel.org, devicetree@vger.kernel.org, 
 bhelgaas@google.com, joyce.ooi@intel.com, linux-kernel@vger.kernel.org, 
 kw@linux.com, dinguyen@kernel.org, krzk+dt@kernel.org, 
 linux-pci@vger.kernel.org
In-Reply-To: <20240731143946.3478057-1-matthew.gerlach@linux.intel.com>
References: <20240731143946.3478057-1-matthew.gerlach@linux.intel.com>
Message-Id: <172252600567.120573.8819016513209910959.robh@kernel.org>
Subject: Re: [PATCH 0/7] Add PCIe Root Port support for Agilex family of
 chips


On Wed, 31 Jul 2024 09:39:39 -0500, matthew.gerlach@linux.intel.com wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> 
> This patch set adds PCIe Root Port support for the Agilex family of FPGA chips.
> Patches 1 and 2 have been reviewed previously and individually on the mailing
> list and are included here with their revision history and Reviewed-by: tags
> for convenience and completeness.
> 
> Patch 1:
>   Convert text device tree binding for Altera Root Port PCIe controller to YAML.
> 
> Patch 2:
>   Convert text device tree binding for Altera PCIe MSI controller to YAML.
> 
> Patch 3:
>   Add new compatible strings for the three variants of the Agilex PCIe controller IP.
> 
> Patch 4:
>   Add a label to the soc@0 device tree node to be used by patch 5.
> 
> Patch 5:
>   Add base dtsi for PCIe Root Port support of the Agilex family of chips.
> 
> Patch 6:
>   Add dts enabling PCIe Root Port support on an Agilex F-series Development Kit.
> 
> Patch 7:
>   Update Altera PCIe controller driver to support the Agilex family of chips.
> 
> D M, Sharath Kumar (1):
>   pci: controller: pcie-altera: Add support for Agilex
> 
> Matthew Gerlach (6):
>   dt-bindings: PCI: altera: Convert to YAML
>   dt-bindings: PCI: altera: msi: Convert to YAML
>   dt-bindings: PCI: altera: Add binding for Agilex
>   arm64: dts: agilex: add soc0 label
>   arm64: dts: agilex: add dtsi for PCIe Root Port
>   arm64: dts: agilex: add dts enabling PCIe Root Port
> 
>  .../bindings/pci/altera-pcie-msi.txt          |  27 --
>  .../devicetree/bindings/pci/altera-pcie.txt   |  50 ----
>  .../bindings/pci/altr,msi-controller.yaml     |  65 +++++
>  .../bindings/pci/altr,pcie-root-port.yaml     | 123 +++++++++
>  MAINTAINERS                                   |   4 +-
>  arch/arm64/boot/dts/intel/Makefile            |   1 +
>  arch/arm64/boot/dts/intel/socfpga_agilex.dtsi |   2 +-
>  .../socfpga_agilex7f_socdk_pcie_root_port.dts |  16 ++
>  .../intel/socfpga_agilex_pcie_root_port.dtsi  |  55 ++++
>  drivers/pci/controller/pcie-altera.c          | 260 ++++++++++++++++--
>  10 files changed, 507 insertions(+), 96 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pci/altera-pcie-msi.txt
>  delete mode 100644 Documentation/devicetree/bindings/pci/altera-pcie.txt
>  create mode 100644 Documentation/devicetree/bindings/pci/altr,msi-controller.yaml
>  create mode 100644 Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml
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


New warnings running 'make CHECK_DTBS=y intel/socfpga_agilex7f_socdk_pcie_root_port.dtb' for 20240731143946.3478057-1-matthew.gerlach@linux.intel.com:

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
arch/arm64/boot/dts/intel/socfpga_agilex7f_socdk_pcie_root_port.dtb: /soc@0/sysmgr@ffd12000: failed to match any schema with compatible: ['altr,sys-mgr-s10', 'altr,sys-mgr']
arch/arm64/boot/dts/intel/socfpga_agilex7f_socdk_pcie_root_port.dtb: /soc@0/sysmgr@ffd12000: failed to match any schema with compatible: ['altr,sys-mgr-s10', 'altr,sys-mgr']
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
arch/arm64/boot/dts/intel/socfpga_agilex7f_socdk_pcie_root_port.dtb: bridge@80000000: $nodename:0: 'bridge@80000000' does not match '^([a-z][a-z0-9\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#






