Return-Path: <linux-pci+bounces-7692-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F628CA474
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2024 00:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77FB21C2031F
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2024 22:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1599D2D7A8;
	Mon, 20 May 2024 22:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FBoF8aYD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E242D05D;
	Mon, 20 May 2024 22:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716244186; cv=none; b=iMI8ZW6hVmr+9i+JUs1aMGEUES6mC2qzicZvMtGi2MiIrYeW3sKnRfa2Lydg5h9eZeWBaY61nwrcoay7gxPrb4qIej4GvVEyIYLfwjWyDHKQ4uDHJ9fhjEoLAVNnFryiTfl/RU8lRt7bm9yMZzuJGua7H6ucaG6mAYYhF68c3XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716244186; c=relaxed/simple;
	bh=RR/yF8QP2vwDDr9BvJmNrqRVyEgUVgRjQWH7T6pXxMc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Z6SeWOXwVAYbtpeb+ltY7pNGPlDWrpDfT2VUkZWGVAhMP/XE6Qq7729Nv+LRsLpCh7sZPSzY3Gjo2+TCcMrZ3usmSbuiy1Zk3tO9IkJXQStaPxTOOP+cm+p8i3jB14jvF+bAx2E+A0whWRPYsJBZDPPG2P0Hc4BOc8L8uNAnOQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FBoF8aYD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9677C2BD10;
	Mon, 20 May 2024 22:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716244185;
	bh=RR/yF8QP2vwDDr9BvJmNrqRVyEgUVgRjQWH7T6pXxMc=;
	h=Date:From:To:Cc:Subject:From;
	b=FBoF8aYDcavzQf/O89zww2aFm01JOj3NUvNIQHpcID3gSSy2cpHgiQCkmyz33MKGB
	 67DpyQE4ePKJ3enUHKRQXGoVi/HKT6NwJYTwCO/MMBW74iRPMFE8pEFVbr1NS1Ou4v
	 yxBYCOTrdc6T2+RSI8fJay9gv77iWMpluLG9hm+Z0ou/CNV6QuqmEvcKN5xzhPHWN1
	 rJUdKmglDjX5ODlZI77YFViLqUfz6Rx7NQG96aW2ojDWJYzC37X4l7p0TlSNGo/t/U
	 zkmrOgmhTBu2scXSvAneLvYDqyP1d+DMIBlaZQPNp8YW1Wp4H7GZ0otx2VN6zJUh9M
	 lf73OP5vNR/rw==
Date: Mon, 20 May 2024 17:29:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: [GIT PULL] PCI changes for v6.10
Message-ID: <20240520222943.GA7973@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.10-changes

for you to fetch changes up to 7ecf13fd35feed2e888686320d378769305b8322:

  Merge branch 'pci/misc' (2024-05-16 18:14:14 -0500)

----------------------------------------------------------------
Enumeration:

  - Skip E820 checks for MCFG ECAM regions for new (2016+) machines, since
    there's no requirement to describe them in E820 and some platforms
    require ECAM to work (Bjorn Helgaas)

  - Rename PCI_IRQ_LEGACY to PCI_IRQ_INTX to be more specific (Damien Le
    Moal)

  - Remove last user and pci_enable_device_io() (Heiner Kallweit)

  - Wait for Link Training==0 to avoid possible race (Ilpo Järvinen)

  - Skip waiting for devices that have been disconnected while suspended
    (Ilpo Järvinen)

  - Clear Secondary Status errors after enumeration since Master Aborts and
    Unsupported Request errors are an expected part of enumeration (Vidya
    Sagar)

MSI:

  - Remove unused IMS (Interrupt Message Store) support (Bjorn Helgaas)

Error handling:

  - Mask Genesys GL975x SD host controller Replay Timer Timeout correctable
    errors caused by a hardware defect; the errors cause interrupts that
    prevent system suspend (Kai-Heng Feng)

  - Fix EDR-related _DSM support, which previously evaluated revision 5 but
    assumed revision 6 behavior (Kuppuswamy Sathyanarayanan)

ASPM:

  - Simplify link state definitions and mask calculation (Ilpo Järvinen)

Power management:

  - Avoid D3cold for HP Pavilion 17 PC/1972 PCIe Ports, where BIOS
    apparently doesn't know how to put them back in D0 (Mario Limonciello)

CXL:

  - Support resetting CXL devices; special handling required because CXL
    Ports mask Secondary Bus Reset by default (Dave Jiang)

DOE:

  - Support DOE Discovery Version 2 (Alexey Kardashevskiy)

Endpoint framework:

  - Set endpoint BAR to be 64-bit if the driver says that's all the device
    supports, in addition to doing so if the size is >2GB (Niklas Cassel)

  - Simplify endpoint BAR allocation and setting interfaces (Niklas Cassel)

Cadence PCIe controller driver:

  - Drop DT binding redundant msi-parent and pci-bus.yaml (Krzysztof
    Kozlowski)

Cadence PCIe endpoint driver:

  - Configure endpoint BARs to be 64-bit based on the BAR type, not the BAR
    value (Niklas Cassel)

Freescale Layerscape PCIe controller driver:

  - Convert DT binding to YAML (Frank Li)

MediaTek MT7621 PCIe controller driver:

  - Add DT binding missing 'reg' property for child Root Ports (Krzysztof
    Kozlowski)

  - Fix theoretical string truncation in PHY name (Sergio Paracuellos)

NVIDIA Tegra194 PCIe controller driver:

  - Return success for endpoint probe instead of falling through to the
    failure path (Vidya Sagar)

Renesas R-Car PCIe controller driver:

  - Add DT binding missing IOMMU properties (Geert Uytterhoeven)

  - Add DT binding R-Car V4H compatible for host and endpoint mode
    (Yoshihiro Shimoda)

Rockchip PCIe controller driver:

  - Configure endpoint BARs to be 64-bit based on the BAR type, not the BAR
    value (Niklas Cassel)

  - Add DT binding missing maxItems to ep-gpios (Krzysztof Kozlowski)

  - Set the Subsystem Vendor ID, which was previously zero because it was
    masked incorrectly (Rick Wertenbroek)

Synopsys DesignWare PCIe controller driver:

  - Restructure DBI register access to accommodate devices where this
    requires Refclk to be active (Manivannan Sadhasivam)

  - Remove the deinit() callback, which was only need by the
    pcie-rcar-gen4, and do it directly in that driver (Manivannan
    Sadhasivam)

  - Add dw_pcie_ep_cleanup() so drivers that support PERST# can clean up
    things like eDMA (Manivannan Sadhasivam)

  - Rename dw_pcie_ep_exit() to dw_pcie_ep_deinit() to make it parallel to
    dw_pcie_ep_init() (Manivannan Sadhasivam)

  - Rename dw_pcie_ep_init_complete() to dw_pcie_ep_init_registers() to
    reflect the actual functionality (Manivannan Sadhasivam)

  - Call dw_pcie_ep_init_registers() directly from all the glue drivers,
    not just those that require active Refclk from the host (Manivannan
    Sadhasivam)

  - Remove the "core_init_notifier" flag, which was an obscure way for glue
    drivers to indicate that they depend on Refclk from the host
    (Manivannan Sadhasivam)

TI J721E PCIe driver:

  - Add DT binding J784S4 SoC Device ID (Siddharth Vadapalli)

  - Add DT binding J722S SoC support (Siddharth Vadapalli)

TI Keystone PCIe controller driver:

  - Add DT binding missing num-viewport, phys and phy-name properties (Jan
    Kiszka)

Miscellaneous:

  - Constify and annotate with __ro_after_init (Heiner Kallweit)

  - Convert DT bindings to YAML (Krzysztof Kozlowski)

  - Check for kcalloc() failure in of_pci_prop_intr_map() (Duoming Zhou)

----------------------------------------------------------------
Alexey Kardashevskiy (1):
      PCI/DOE: Support discovery version 2

Andy Shevchenko (1):
      PCI/MSI: Make error path handling follow the standard pattern

Bjorn Helgaas (28):
      Revert "PCI/MSI: Provide stubs for IMS functions"
      Revert "PCI/MSI: Provide pci_ims_alloc/free_irq()"
      Revert "PCI/MSI: Provide IMS (Interrupt Message Store) support"
      Revert "iommu/amd: Enable PCI/IMS"
      Revert "iommu/vt-d: Enable PCI/IMS"
      Revert "x86/apic/msi: Enable PCI/IMS"
      Revert "genirq/msi: Provide constants for PCI/IMS support"
      PCI: Update pci_find_capability() stub return types
      x86/pci: Skip early E820 check for ECAM region
      Merge branch 'pci/aer'
      Merge branch 'pci/aspm'
      Merge branch 'pci/cxl'
      Merge branch 'pci/doe'
      Merge branch 'pci/edr'
      Merge branch 'pci/enumeration'
      Merge branch 'pci/hotplug'
      Merge branch 'pci/msi'
      Merge branch 'pci/of'
      Merge branch 'pci/pm'
      Merge branch 'pci/dt-bindings'
      Merge branch 'pci/controller/cadence'
      Merge branch 'pci/controller/dwc'
      Merge branch 'pci/controller/mt7621'
      Merge branch 'pci/controller/rockchip'
      Merge branch 'pci/controller/tegra194'
      Merge branch 'pci/endpoint'
      Merge branch 'pci/ims-removal'
      Merge branch 'pci/misc'

Damien Le Moal (29):
      PCI/MSI: Use PCI_IRQ_INTX instead of PCI_IRQ_LEGACY
      PCI/portdrv: Use PCI_IRQ_INTX instead of PCI_IRQ_LEGACY
      Documentation: PCI: Use PCI_IRQ_INTX instead of PCI_IRQ_LEGACY
      ASoC: Intel: avs: Use PCI_IRQ_INTX instead of PCI_IRQ_LEGACY
      usb: hcd-pci: Use PCI_IRQ_INTX instead of PCI_IRQ_LEGACY
      tty: 8250_pci: Use PCI_IRQ_INTX instead of PCI_IRQ_LEGACY
      platform/x86: intel_ips: Use PCI_IRQ_INTX instead of PCI_IRQ_LEGACY
      ntb: idt: Use PCI_IRQ_INTX instead of PCI_IRQ_LEGACY
      mfd: intel-lpss: Use PCI_IRQ_INTX instead of PCI_IRQ_LEGACY
      drm/amdgpu: Use PCI_IRQ_INTX instead of PCI_IRQ_LEGACY
      IB/qib: Use PCI_IRQ_INTX instead of PCI_IRQ_LEGACY
      RDMA/vmw_pvrdma: Use PCI_IRQ_INTX instead of PCI_IRQ_LEGACY
      VMCI: Use PCI_IRQ_ALL_TYPES to remove PCI_IRQ_LEGACY use
      net: amd-xgbe: Use PCI_IRQ_INTX instead of PCI_IRQ_LEGACY
      net: atlantic: Use PCI_IRQ_INTX instead of PCI_IRQ_LEGACY
      net: alx: Use PCI_IRQ_INTX instead of PCI_IRQ_LEGACY
      r8169: Use PCI_IRQ_INTX instead of PCI_IRQ_LEGACY
      net: wangxun: Use PCI_IRQ_INTX instead of PCI_IRQ_LEGACY
      wifi: ath10k: Refer to INTX instead of LEGACY
      wifi: rtw88: Use PCI_IRQ_INTX instead of PCI_IRQ_LEGACY
      wifi: rtw89: Use PCI_IRQ_INTX instead of PCI_IRQ_LEGACY
      scsi: arcmsr: Use PCI_IRQ_INTX instead of PCI_IRQ_LEGACY
      scsi: hpsa: Use PCI_IRQ_INTX instead of PCI_IRQ_LEGACY
      scsi: ipr: Use PCI_IRQ_INTX instead of PCI_IRQ_LEGACY
      scsi: megaraid_sas: Use PCI_IRQ_INTX instead of PCI_IRQ_LEGACY
      scsi: mpt3sas: Use PCI_IRQ_INTX instead of PCI_IRQ_LEGACY
      scsi: pmcraid: Use PCI_IRQ_INTX instead of PCI_IRQ_LEGACY
      scsi: vmw_pvscsi: Do not use PCI_IRQ_LEGACY instead of PCI_IRQ_LEGACY
      PCI: Remove PCI_IRQ_LEGACY

Dave Jiang (5):
      PCI/CXL: Move CXL Vendor ID to pci_ids.h
      PCI: Lock upstream bridge for pci_reset_function()
      PCI/CXL: Fail bus reset if upstream CXL Port has SBR masked
      PCI/CXL: Add 'cxl_bus' reset method for devices below CXL Ports
      cxl: Add post-reset warning if reset results in loss of previously committed HDM decoders

Duoming Zhou (1):
      PCI: of_property: Return error for int_map allocation failure

Frank Li (1):
      dt-bindings: PCI: layerscape-pci: Convert to YAML format

Geert Uytterhoeven (1):
      dt-bindings: PCI: rcar-pci-host: Add missing IOMMU properties

Heiner Kallweit (4):
      PCI: Constify pcibus_class
      PCI: Annotate pci_cache_line_size variables as __ro_after_init
      ata: pata_cs5520: Remove unnecessary call to pci_enable_device_io()
      PCI: Remove unused pci_enable_device_io()

Ilpo Järvinen (8):
      PCI: Wait for Link Training==0 before starting Link retrain
      PCI: Clarify intent of LT wait
      PCI/ERR: Cleanup misleading indentation inside if conditions
      PCI: Clean up accessor macro formatting
      PCI/ASPM: Consolidate link state defines
      PCI/ASPM: Clean up ASPM disable/enable mask calculation
      PCI: Make pcie_bandwidth_capable() static
      PCI: Do not wait for disconnected devices when resuming

Jan Kiszka (1):
      dt-bindings: PCI: ti,am65: Fix remaining binding warnings

Kai-Heng Feng (1):
      PCI: Mask Replay Timer Timeout errors for Genesys GL975x SD host controller

Krzysztof Kozlowski (5):
      dt-bindings: PCI: cdns,cdns-pcie-host: Drop redundant msi-parent and pci-bus.yaml
      dt-bindings: PCI: mediatek,mt7621: Add missing child node reg
      dt-bindings: PCI: host-bridges: Switch from deprecated pci-bus.yaml
      dt-bindings: PCI: mediatek,mt7621-pcie: Switch from deprecated pci-bus.yaml
      dt-bindings: PCI: rockchip,rk3399-pcie: Add missing maxItems to ep-gpios

Kunwu Chan (1):
      x86/pci: Remove OLPC dead code

Kuppuswamy Sathyanarayanan (3):
      PCI/AER: Update aer-inject tool source URL
      PCI/EDR: Align EDR_PORT_DPC_ENABLE_DSM with PCI Firmware r3.3
      PCI/EDR: Align EDR_PORT_LOCATE_DSM with PCI Firmware r3.3

Manivannan Sadhasivam (8):
      PCI: dwc: ep: Fix DBI access failure for drivers requiring refclk from host
      PCI: dwc: ep: Add Kernel-doc comments for APIs
      PCI: dwc: ep: Remove deinit() callback from struct dw_pcie_ep_ops
      PCI: dwc: ep: Rename dw_pcie_ep_exit() to dw_pcie_ep_deinit()
      PCI: dwc: ep: Introduce dw_pcie_ep_cleanup() API for drivers supporting PERST#
      PCI: dwc: ep: Rename dw_pcie_ep_init_complete() to dw_pcie_ep_init_registers()
      PCI: dwc: ep: Call dw_pcie_ep_init_registers() API directly from all glue drivers
      PCI: endpoint: Remove "core_init_notifier" flag

Mario Limonciello (1):
      PCI/PM: Avoid D3cold for HP Pavilion 17 PC/1972 PCIe Ports

Nam Cao (2):
      PCI: hotplug: Document unchecked return value of pci_hp_add_bridge()
      PCI: hotplug: Remove obsolete sgi_hotplug TODO notes

Niklas Cassel (7):
      PCI: cadence: Set a 64-bit BAR if requested
      PCI: rockchip-ep: Set a 64-bit BAR if requested
      PCI: endpoint: pci-epf-test: Simplify pci_epf_test_alloc_space() loop
      PCI: endpoint: Allocate a 64-bit BAR if that is the only option
      PCI: endpoint: pci-epf-test: Remove superfluous code
      PCI: endpoint: pci-epf-test: Simplify pci_epf_test_set_bar() loop
      PCI: endpoint: pci-epf-test: Clean up pci_epf_test_unbind()

Rick Wertenbroek (1):
      PCI: rockchip-ep: Remove wrong mask on subsys_vendor_id

Sergio Paracuellos (1):
      PCI: mt7621: Fix string truncation in mt7621_pcie_parse_port()

Siddharth Vadapalli (2):
      dt-bindings: PCI: ti,j721e-pci-host: Add device-id for TI's J784S4 SoC
      dt-bindings: PCI: ti,j721e-pci-host: Add support for J722S SoC

Vidya Sagar (2):
      PCI: tegra194: Fix probe path for Endpoint mode
      PCI: Clear Secondary Status errors after enumeration

Yoshihiro Shimoda (2):
      dt-bindings: PCI: rcar-gen4-pci-host: Add R-Car V4H compatible
      dt-bindings: PCI: rcar-gen4-pci-ep: Add R-Car V4H compatible

 Documentation/PCI/msi-howto.rst                    |   2 +-
 Documentation/PCI/pci.rst                          |   2 +-
 Documentation/PCI/pcieaer-howto.rst                |   2 +-
 .../devicetree/bindings/pci/amlogic,axg-pcie.yaml  |   2 +-
 .../devicetree/bindings/pci/apple,pcie.yaml        |   2 +-
 .../devicetree/bindings/pci/brcm,iproc-pcie.yaml   |   2 +-
 .../devicetree/bindings/pci/brcm,stb-pcie.yaml     |   2 +-
 .../bindings/pci/cdns,cdns-pcie-host.yaml          |   3 -
 .../devicetree/bindings/pci/cdns-pcie-host.yaml    |   2 +-
 .../devicetree/bindings/pci/faraday,ftpci100.yaml  |   2 +-
 .../bindings/pci/fsl,layerscape-pcie-ep.yaml       | 102 +++++++++
 .../bindings/pci/fsl,layerscape-pcie.yaml          | 167 ++++++++++++++
 .../devicetree/bindings/pci/host-generic-pci.yaml  |   2 +-
 .../devicetree/bindings/pci/intel,ixp4xx-pci.yaml  |   2 +-
 .../bindings/pci/intel,keembay-pcie.yaml           |   2 +-
 .../devicetree/bindings/pci/layerscape-pci.txt     |  79 -------
 .../devicetree/bindings/pci/loongson.yaml          |   2 +-
 .../bindings/pci/mediatek,mt7621-pcie.yaml         |   7 +-
 .../bindings/pci/mediatek-pcie-gen3.yaml           |   2 +-
 .../bindings/pci/microchip,pcie-host.yaml          |   2 +-
 .../devicetree/bindings/pci/qcom,pcie-common.yaml  |   2 +-
 .../devicetree/bindings/pci/qcom,pcie.yaml         |   2 +-
 .../devicetree/bindings/pci/rcar-gen4-pci-ep.yaml  |   4 +-
 .../bindings/pci/rcar-gen4-pci-host.yaml           |   4 +-
 .../devicetree/bindings/pci/rcar-pci-host.yaml     |   5 +-
 .../bindings/pci/renesas,pci-rcar-gen2.yaml        |   2 +-
 .../bindings/pci/rockchip,rk3399-pcie.yaml         |   3 +-
 .../devicetree/bindings/pci/snps,dw-pcie.yaml      |   2 +-
 .../devicetree/bindings/pci/ti,am65-pci-host.yaml  |  22 +-
 .../devicetree/bindings/pci/ti,j721e-pci-host.yaml |   5 +
 .../devicetree/bindings/pci/versatile.yaml         |   2 +-
 .../devicetree/bindings/pci/xilinx-versal-cpm.yaml |   2 +-
 .../bindings/pci/xlnx,axi-pcie-host.yaml           |   2 +-
 .../devicetree/bindings/pci/xlnx,nwl-pcie.yaml     |   2 +-
 .../devicetree/bindings/pci/xlnx,xdma-host.yaml    |   2 +-
 Documentation/translations/zh_CN/PCI/msi-howto.rst |   2 +-
 Documentation/translations/zh_CN/PCI/pci.rst       |   2 +-
 arch/x86/kernel/apic/msi.c                         |   5 -
 arch/x86/pci/mmconfig-shared.c                     |  40 +++-
 arch/x86/pci/olpc.c                                |   3 -
 drivers/ata/pata_cs5520.c                          |   6 -
 drivers/cxl/core/pci.c                             |  35 ++-
 drivers/cxl/core/regs.c                            |   2 +-
 drivers/cxl/cxl.h                                  |   2 +
 drivers/cxl/cxlpci.h                               |   1 -
 drivers/cxl/pci.c                                  |  24 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c            |   2 +-
 drivers/infiniband/hw/qib/qib_iba7220.c            |   2 +-
 drivers/infiniband/hw/qib/qib_iba7322.c            |   5 +-
 drivers/infiniband/hw/qib/qib_pcie.c               |   2 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c     |   2 +-
 drivers/iommu/amd/iommu.c                          |  17 +-
 drivers/iommu/intel/irq_remapping.c                |  19 +-
 drivers/mfd/intel-lpss-pci.c                       |   2 +-
 drivers/misc/vmw_vmci/vmci_guest.c                 |   3 +-
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c           |   2 +-
 drivers/net/ethernet/aquantia/atlantic/aq_cfg.h    |   2 +-
 drivers/net/ethernet/aquantia/atlantic/aq_hw.h     |   2 +-
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c    |   2 +-
 .../net/ethernet/aquantia/atlantic/aq_pci_func.c   |   9 +-
 .../ethernet/aquantia/atlantic/hw_atl/hw_atl_a0.c  |   2 +-
 .../ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c  |   2 +-
 .../ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c   |   2 +-
 drivers/net/ethernet/atheros/alx/main.c            |   2 +-
 drivers/net/ethernet/realtek/r8169_main.c          |   2 +-
 drivers/net/ethernet/wangxun/libwx/wx_lib.c        |   8 +-
 drivers/net/wireless/ath/ath10k/ahb.c              |  18 +-
 drivers/net/wireless/ath/ath10k/pci.c              |  36 ++--
 drivers/net/wireless/ath/ath10k/pci.h              |   6 +-
 drivers/net/wireless/realtek/rtw88/pci.c           |   2 +-
 drivers/net/wireless/realtek/rtw89/pci.c           |   2 +-
 drivers/ntb/hw/idt/ntb_hw_idt.c                    |   2 +-
 drivers/pci/access.c                               |  44 ++--
 drivers/pci/controller/cadence/pcie-cadence-ep.c   |   7 +-
 drivers/pci/controller/dwc/pci-dra7xx.c            |   9 +
 drivers/pci/controller/dwc/pci-imx6.c              |  10 +
 drivers/pci/controller/dwc/pci-keystone.c          |  11 +
 drivers/pci/controller/dwc/pci-layerscape-ep.c     |   9 +
 drivers/pci/controller/dwc/pcie-artpec6.c          |  15 +-
 drivers/pci/controller/dwc/pcie-designware-ep.c    | 240 ++++++++++++++-------
 drivers/pci/controller/dwc/pcie-designware-plat.c  |  11 +
 drivers/pci/controller/dwc/pcie-designware.h       |  14 +-
 drivers/pci/controller/dwc/pcie-keembay.c          |  18 +-
 drivers/pci/controller/dwc/pcie-qcom-ep.c          |   4 +-
 drivers/pci/controller/dwc/pcie-rcar-gen4.c        |  28 ++-
 drivers/pci/controller/dwc/pcie-tegra194.c         |   8 +-
 drivers/pci/controller/dwc/pcie-uniphier-ep.c      |  15 +-
 drivers/pci/controller/pcie-mt7621.c               |   2 +-
 drivers/pci/controller/pcie-rcar-ep.c              |   2 +
 drivers/pci/controller/pcie-rockchip-ep.c          |  10 +-
 drivers/pci/doe.c                                  |  12 +-
 drivers/pci/endpoint/functions/pci-epf-test.c      |  80 ++-----
 drivers/pci/endpoint/pci-ep-cfs.c                  |   9 +
 drivers/pci/endpoint/pci-epc-core.c                |  22 ++
 drivers/pci/endpoint/pci-epf-core.c                |   9 +-
 drivers/pci/hotplug/TODO                           |  12 +-
 drivers/pci/msi/api.c                              |  58 +----
 drivers/pci/msi/irqdomain.c                        |  59 -----
 drivers/pci/msi/msi.c                              |  15 +-
 drivers/pci/of_property.c                          |   2 +
 drivers/pci/pci.c                                  | 143 ++++++++++--
 drivers/pci/pci.h                                  |   2 -
 drivers/pci/pcie/Kconfig                           |   2 +-
 drivers/pci/pcie/aer_inject.c                      |   2 +-
 drivers/pci/pcie/aspm.c                            | 182 ++++++++--------
 drivers/pci/pcie/edr.c                             |  28 ++-
 drivers/pci/pcie/err.c                             |  12 +-
 drivers/pci/pcie/portdrv.c                         |   8 +-
 drivers/pci/probe.c                                |   8 +-
 drivers/pci/quirks.c                               |  20 ++
 drivers/perf/cxl_pmu.c                             |   2 +-
 drivers/platform/x86/intel_ips.c                   |   2 +-
 drivers/scsi/arcmsr/arcmsr_hba.c                   |   2 +-
 drivers/scsi/hpsa.c                                |   2 +-
 drivers/scsi/ipr.c                                 |   2 +-
 drivers/scsi/megaraid/megaraid_sas_base.c          |   4 +-
 drivers/scsi/mpt3sas/mpt3sas_base.c                |   2 +-
 drivers/scsi/pmcraid.c                             |   2 +-
 drivers/scsi/vmw_pvscsi.c                          |   2 +-
 drivers/tty/serial/8250/8250_pci.c                 |   2 +-
 drivers/usb/core/hcd-pci.c                         |   3 +-
 include/linux/irqdomain_defs.h                     |   1 -
 include/linux/lockdep.h                            |   5 +
 include/linux/msi.h                                |   2 -
 include/linux/msi_api.h                            |   1 -
 include/linux/pci-epc.h                            |   7 +-
 include/linux/pci.h                                |  74 +++----
 include/linux/pci_ids.h                            |   2 +
 include/uapi/linux/pci_regs.h                      |   6 +
 sound/soc/intel/avs/core.c                         |   2 +-
 130 files changed, 1232 insertions(+), 761 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/layerscape-pci.txt

