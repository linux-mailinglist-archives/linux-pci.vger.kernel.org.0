Return-Path: <linux-pci+bounces-13298-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1389597CE31
	for <lists+linux-pci@lfdr.de>; Thu, 19 Sep 2024 21:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C567D28454A
	for <lists+linux-pci@lfdr.de>; Thu, 19 Sep 2024 19:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342B550288;
	Thu, 19 Sep 2024 19:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQohY1rt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99F849647;
	Thu, 19 Sep 2024 19:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726775117; cv=none; b=mIUlSNJ1mzIeqYLnGCubu4i6fNIX++NS3ZwVkvrln/cUL7L22IG4YP9TVwvM8X8huDP1uz4d0zi8FCeMYuCLjKToop6xbRQazhUHQUwfNeQPEeu8pv0x01Ozqzp9M9xGtNihYqCKAkNHQTYqkb8V6W+HAIxaLfqNN4wny6gHs6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726775117; c=relaxed/simple;
	bh=N90NJs3NwAC4hWjsgGnSlJZRnqf+llHmgCa0f+J7yZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TUPl7zsSuuUJxhhHphb1P5sJVGzdeeFqA7MqznyXzDU1O0F3ekLtldVfHTEVzVxKFySLCKb9s347N4A5ygXkKDwDqgTwTboB7ZdvIr4Hkr+NMDs+C3a0QJGohn8WKVjpnc44rD41NxGL04f/uv/q3PUrBFh0Jwet3nhklddBGIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQohY1rt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F13CDC4CEC5;
	Thu, 19 Sep 2024 19:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726775116;
	bh=N90NJs3NwAC4hWjsgGnSlJZRnqf+llHmgCa0f+J7yZQ=;
	h=Date:From:To:Cc:Subject:From;
	b=AQohY1rtNBvOj5ZEJbfRwQtK4+aBdQEj94XVRRz6U7qMli74WtDWNChWxK2tWqRXT
	 1o5w8GbmxE+U4F1RA/UaSrZzdIXlFX9wtGkgxnBFY17UiYFXl1XRKMAt3SeQRA7+cl
	 85AURJb51Dv7NvsAluCDCHdiuJrs0F3mgsHzyQXCnsISTrIoZ2dzy5hkHnIf014eI2
	 2XpeO/b5lRVWl2q0HSbDu4syD3TqTp+lszthWbSnJ1yyV7KQFs52IIvY/rD2IPR//S
	 JIFduYdyMt3TVq1oUnvC6iKsOVcrLgCTulmMQGbHfXuJY7d5s9pHoCvbp8o7rlvetC
	 Qm0LdqUJKTn6g==
Date: Thu, 19 Sep 2024 14:45:14 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: [GIT PULL] PCI changes for v6.12
Message-ID: <20240919194514.GA1025547@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.12-changes

for you to fetch changes up to 81e53c0da8f8b153e049036e5ca5ca20e811c0c8:

  Merge branch 'pci/tools' (2024-09-19 14:25:34 -0500)

Rebased today to fix comment typos and drop a duplicate patch; no code changes.
----------------------------------------------------------------

Enumeration:

  - Wait for device readiness after reset by polling Vendor ID and looking
    for Configuration RRS instead of polling the Command register and
    looking for non-error completions, to avoid hardware retries done for
    RRS on non-Vendor ID reads (Bjorn Helgaas)

  - Rename CRS Completion Status to RRS ('Request Retry Status') to match
    PCIe r6.0 spec usage (Bjorn Helgaas)

  - Clear LBMS bit after a manual link retrain so we don't try to retrain a
    link when there's no downstream device anymore (Maciej W. Rozycki)

  - Revert to the original link speed after retraining fails instead of
    leaving it restricted to 2.5GT/s, so a future device has a chance to
    use higher speeds (Maciej W. Rozycki)

  - Wait for each level of downstream bus, not just the first, to become
    accessible before restoring devices on that bus (Ilpo Järvinen)

  - Add ARCH_PCI_DEV_GROUPS so s390 can add its own attribute_groups
    without having to stomp on the core's pdev->dev.groups (Lukas Wunner)

Driver binding:

  - Export pcim_request_region(), a managed counterpart of
    pci_request_region(), for use by drivers (Philipp Stanner)

  - Export pcim_iomap_region() and deprecate pcim_iomap_regions() (Philipp
    Stanner)

  - Request the PCI BAR used by xboxvideo (Philipp Stanner)

  - Request and map drm/ast BARs with pcim_iomap_region() (Philipp Stanner)

MSI:

  - Add MSI_FLAG_NO_AFFINITY flag for devices that mux MSIs onto a single
    IRQ line and cannot set the affinity of each MSI to a specific CPU core
    (Marek Vasut)

  - Use MSI_FLAG_NO_AFFINITY and remove unnecessary .irq_set_affinity()
    implementations in aardvark, altera, brcmstb, dwc, mediatek-gen3,
    mediatek, mobiveil, plda, rcar, tegra, vmd, xilinx-nwl, xilinx-xdma,
    and xilinx drivers to avoid 'IRQ: set affinity failed' warnings (Marek
    Vasut)

Power management:

  - Add pwrctl support for ATH11K inside the WCN6855 package (Konrad
    Dybcio)

PCI device hotplug:

  - Remove unnecessary hpc_ops struct from shpchp (ngn)

  - Check for PCI_POSSIBLE_ERROR(), not 0xffffffff, in cpqphp (weiyufeng)

Virtualization:

  - Mark Creative Labs EMU20k2 INTx masking as broken (Alex Williamson)

  - Add an ACS quirk for Qualcomm SA8775P, which doesn't advertise ACS but
    does provide ACS-like features (Subramanian Ananthanarayanan)

IOMMU:

  - Add function 0 DMA alias quirk for Glenfly Arise audio function, which
    uses the function 0 Requester ID (WangYuli)

NPEM:

  - Add Native PCIe Enclosure Management (NPEM) support for sysfs control
    of NVMe RAID storage indicators (ok/fail/locate/rebuild/etc) (Mariusz
    Tkaczyk)

  - Add support for the ACPI _DSM PCIe SSD status LED management, which is
    functionally similar to NPEM but mediated by platform firmware (Mariusz
    Tkaczyk)

Device trees:

  - Drop minItems and maxItems from ranges in PCI generic host binding
    since host bridges may have several MMIO and I/O port apertures (Frank
    Li)

  - Add kirin, rcar-gen2, uniphier DT binding top-level constraints for
    clocks (Krzysztof Kozlowski)

Altera PCIe controller driver:

  - Convert altera DT bindings from text to YAML (Matthew Gerlach)

  - Replace TLP_REQ_ID() with macro PCI_DEVID(), which does the same thing
    and is what other drivers use (Jinjie Ruan)

Broadcom STB PCIe controller driver:

  - Add DT binding maxItems for reset controllers (Jim Quinlan)

  - Use the 'bridge' reset method if described in the DT (Jim Quinlan)

  - Use the 'swinit' reset method if described in the DT (Jim Quinlan)

  - Add 'has_phy' so the existence of a 'rescal' reset controller doesn't
    imply software control of it (Jim Quinlan)

  - Add support for many inbound DMA windows (Jim Quinlan)

  - Rename SoC 'type' to 'soc_base' express the fact that SoCs come in
    families of multiple similar devices (Jim Quinlan)

  - Add Broadcom 7712 DT description and driver support (Jim Quinlan)

  - Sort enums, pcie_offsets[], pcie_cfg_data, .compatible strings for
    maintainability (Bjorn Helgaas)

Freescale i.MX6 PCIe controller driver:

  - Add imx6q-pcie 'dbi2' and 'atu' reg-names for i.MX8M Endpoints (Richard
    Zhu)

  - Fix a code restructuring error that caused i.MX8MM and i.MX8MP
    Endpoints to fail to establish link (Richard Zhu)

  - Fix i.MX8MP Endpoint occasional failure to trigger MSI by enforcing
    outbound alignment requirement (Richard Zhu)

  - Call phy_power_off() in the .probe() error path (Frank Li)

  - Rename internal names from imx6_* to imx_* since i.MX7/8/9 are also
    supported (Frank Li)

  - Manage Refclk by using SoC-specific callbacks instead of switch
    statements (Frank Li)

  - Manage core reset by using SoC-specific callbacks instead of switch
    statements (Frank Li)

  - Expand comments for erratum ERR010728 workaround (Frank Li)

  - Use generic PHY APIs to configure mode, speed, and submode, which is
    harmless for devices that implement their own internal PHY management
    and don't set the generic imx_pcie->phy (Frank Li)

  - Add i.MX8Q (i.MX8QM, i.MX8QXP, and i.MX8DXL) DT binding and driver Root
    Complex support (Richard Zhu)

Freescale Layerscape PCIe controller driver:

  - Replace layerscape-pcie DT binding compatible fsl,lx2160a-pcie with
    fsl,lx2160ar2-pcie (Frank Li)

  - Add layerscape-pcie DT binding deprecated 'num-viewport' property to
    address a DT checker warning (Frank Li)

  - Change layerscape-pcie DT binding 'fsl,pcie-scfg' to phandle-array
    (Frank Li)

Loongson PCIe controller driver:

  - Increase max PCI hosts to 8 for Loongson-3C6000 and newer chipsets
    (Huacai Chen)

Marvell Aardvark PCIe controller driver:

  - Fix issue with emulating Configuration RRS for two-byte reads of Vendor
    ID; previously it only worked for four-byte reads (Bjorn Helgaas)

MediaTek PCIe Gen3 controller driver:

  - Add per-SoC struct mtk_gen3_pcie_pdata to support multiple SoC types
    (Lorenzo Bianconi)
  
  - Use reset_bulk APIs to manage PHY reset lines (Lorenzo Bianconi)

  - Add DT and driver support for Airoha EN7581 PCIe controller (Lorenzo
    Bianconi)

Qualcomm PCIe controller driver:

  - Update qcom,pcie-sc7280 DT binding with eight interrupts (Rayyan
    Ansari)

  - Add back DT 'vddpe-3v3-supply', which was incorrectly removed earlier
    (Johan Hovold)

  - Drop endpoint redundant masking of global IRQ events (Manivannan
    Sadhasivam)

  - Clarify unknown global IRQ message and only log it once to avoid a
    flood (Manivannan Sadhasivam)

  - Add 'linux,pci-domain' property to endpoint DT binding (Manivannan
    Sadhasivam)

  - Assign PCI domain number for endpoint controllers (Manivannan
    Sadhasivam)

  - Add 'qcom_pcie_ep' and the PCI domain number to IRQ names for endpoint
    controller (Manivannan Sadhasivam)

  - Add global SPI interrupt for PCIe link events to DT binding (Manivannan
    Sadhasivam)

  - Add global RC interrupt handler to handle 'Link up' events and
    automatically enumerate hot-added devices (Manivannan Sadhasivam)

  - Avoid mirroring of DBI and iATU register space so it doesn't overlap
    BAR MMIO space (Prudhvi Yarlagadda)

  - Enable controller resources like PHY only after PERST# is deasserted to
    partially avoid the problem that the endpoint SoC crashes when
    accessing things when Refclk is absent (Manivannan Sadhasivam)

  - Add 16.0 GT/s equalization and RX lane margining settings (Shashank
    Babu Chinta Venkata)

  - Pass domain number to pci_bus_release_domain_nr() explicitly to avoid a
    NULL pointer dereference (Manivannan Sadhasivam)

Renesas R-Car PCIe controller driver:

  - Make the read-only const array 'check_addr' static (Colin Ian King)

  - Add R-Car V4M (R8A779H0) PCIe host and endpoint to DT binding
    (Yoshihiro Shimoda)

TI DRA7xx PCIe controller driver:

  - Request IRQF_ONESHOT for 'dra7xx-pcie-main' IRQ since the primary
    handler is NULL (Siddharth Vadapalli)

  - Handle IRQ request errors during root port and endpoint probe
    (Siddharth Vadapalli)

TI J721E PCIe driver:

  - Add DT 'ti,syscon-acspcie-proxy-ctrl' and driver support to enable the
    ACSPCIE module to drive Refclk for the Endpoint (Siddharth Vadapalli)

  - Extract the cadence link setup from cdns_pcie_host_setup() so link
    setup can be done separately during resume (Thomas Richard)

  - Add T_PERST_CLK_US definition for the mandatory delay between Refclk
    becoming stable and PERST# being deasserted (Thomas Richard)

  - Add j721e suspend and resume support (Théo Lebrun)

TI Keystone PCIe controller driver:

  - Fix NULL pointer checking when applying MRRS limitation quirk for AM65x
    SR 1.0 Errata #i2037 (Dan Carpenter)

Xilinx NWL PCIe controller driver:

  - Fix off-by-one error in INTx IRQ handler that caused INTx interrupts to
    be lost or delivered as the wrong interrupt (Sean Anderson)

  - Rate-limit misc interrupt messages (Sean Anderson)

  - Turn off the clock on probe failure and device removal (Sean Anderson)

  - Add DT binding and driver support for enabling/disabling PHYs (Sean
    Anderson)

  - Add PCIe phy bindings for the ZCU102 (Sean Anderson)

Xilinx XDMA PCIe controller driver:

  - Add support for Xilinx QDMA Soft IP PCIe Root Port Bridge to DT binding
    and xilinx-dma-pl driver (Thippeswamy Havalige)

Miscellaneous:

  - Fix buffer overflow in kirin_pcie_parse_port() (Alexandra Diupina)

  - Fix minor kerneldoc issues and typos (Bjorn Helgaas)

  - Use PCI_DEVID() macro in aer_inject() instead of open-coding it (Jinjie
    Ruan)

  - Check pcie_find_root_port() return in x86 fixups to avoid NULL pointer
    dereferences (Samasth Norway Ananda)

  - Make pci_bus_type constant (Kunwu Chan)

  - Remove unused declarations of __pci_pme_wakeup() and pci_vpd_release()
    (Yue Haibing)

  - Remove any leftover .*.cmd files with make clean (zhang jiao)

  - Remove unused BILLION macro (zhang jiao)

----------------------------------------------------------------
Alex Williamson (1):
      PCI: Mark Creative Labs EMU20k2 INTx masking as broken

Alexandra Diupina (1):
      PCI: kirin: Fix buffer overflow in kirin_pcie_parse_port()

Bjorn Helgaas (39):
      PCI: endpoint: Fix enum pci_epc_bar_type kerneldoc
      PCI: mediatek: Drop excess mtk_pcie.mem kerneldoc description
      PCI: cadence: Drop excess cdns_pcie_rc.dev kerneldoc description
      PCI: brcmstb: Sort enums, pcie_offsets[], pcie_cfg_data, .compatible strings
      PCI: Wait for device readiness with Configuration RRS
      PCI: aardvark: Correct Configuration RRS checking
      PCI: Rename CRS Completion Status to RRS
      PCI: Fix typos
      Merge branch 'pci/aer'
      Merge branch 'pci/crs'
      Merge branch 'pci/devres'
      Merge branch 'pci/enumeration'
      Merge branch 'pci/hotplug'
      Merge branch 'pci/iommu'
      Merge branch 'pci/npem'
      Merge branch 'pci/pwrctl'
      Merge branch 'pci/reset'
      Merge branch 'pci/sysfs'
      Merge branch 'pci/dt-bindings'
      Merge branch 'pci/controller/endpoint'
      Merge branch 'pci/controller/affinity'
      Merge branch 'pci/controller/altera'
      Merge branch 'pci/controller/brcmstb'
      Merge branch 'pci/controller/cadence'
      Merge branch 'pci/controller/dra7xx'
      Merge branch 'pci/controller/imx6'
      Merge branch 'pci/controller/j721e'
      Merge branch 'pci/controller/keystone'
      Merge branch 'pci/controller/kirin'
      Merge branch 'pci/controller/loongson'
      Merge branch 'pci/controller/mediatek'
      Merge branch 'pci/controller/mediatek-gen3'
      Merge branch 'pci/controller/qcom'
      Merge branch 'pci/controller/rcar-gen4'
      Merge branch 'pci/controller/vmd'
      Merge branch 'pci/controller/xilinx'
      Merge branch 'pci/quirks'
      Merge branch 'pci/misc'
      Merge branch 'pci/tools'

Colin Ian King (1):
      PCI: rcar-gen4: Make read-only const array check_addr static

Dan Carpenter (1):
      PCI: keystone: Fix if-statement expression in ks_pcie_quirk()

Frank Li (11):
      dt-bindings: PCI: host-generic-pci: Drop minItems and maxItems of ranges
      dt-bindings: PCI: layerscape-pci: Replace fsl,lx2160a-pcie with fsl,lx2160ar2-pcie
      dt-bindings: PCI: layerscape-pci: Add deprecated property 'num-viewport'
      dt-bindings: PCI: layerscape-pci: Change property 'fsl,pcie-scfg' type
      PCI: imx6: Fix missing call to phy_power_off() in error handling
      PCI: imx6: Rename imx6_* with imx_*
      PCI: imx6: Introduce SoC specific callbacks for controlling REFCLK
      PCI: imx6: Simplify switch-case logic by involve core_reset callback
      PCI: imx6: Improve comment for workaround ERR010728
      PCI: imx6: Consolidate redundant if-checks
      PCI: imx6: Call common PHY API to set mode, speed, and submode

Huacai Chen (1):
      PCI/ACPI: Increase Loongson max PCI hosts to 8

Ilpo Järvinen (1):
      PCI: Wait for Link before restoring Downstream Buses

Jim Quinlan (13):
      dt-bindings: PCI: brcm,stb-pcie: Change brcmstb maintainer and cleanup
      dt-bindings: PCI: brcm,stb-pcie: Use maxItems for reset controllers
      dt-bindings: PCI: brcm,stb-pcie: Add 7712 SoC description
      PCI: brcmstb: Use common error handling code in brcm_pcie_probe()
      PCI: brcmstb: Use bridge reset if available
      PCI: brcmstb: Use swinit reset if available
      PCI: brcmstb: PCI: brcmstb: Make HARD_DEBUG, INTR2_CPU_BASE offsets SoC-specific
      PCI: brcmstb: Remove two unused constants from driver
      PCI: brcmstb: Don't conflate the reset rescal with PHY ctrl
      PCI: brcmstb: Refactor for chips with many regular inbound windows
      PCI: brcmstb: Check return value of all reset_control_* calls
      PCI: brcmstb: Change field name from 'type' to 'soc_base'
      PCI: brcmstb: Enable 7712 SoCs

Jinjie Ruan (2):
      PCI/AER: Use PCI_DEVID() macro in aer_inject()
      PCI: altera: Replace TLP_REQ_ID() with macro PCI_DEVID()

Johan Hovold (1):
      dt-bindings: PCI: qcom: Allow 'vddpe-3v3-supply' again

Konrad Dybcio (1):
      PCI/pwrctl: Add WCN6855 support

Krzysztof Kozlowski (3):
      dt-bindings: PCI: hisilicon,kirin-pcie: Add top-level constraints
      dt-bindings: PCI: renesas,pci-rcar-gen2: Add top-level constraints
      dt-bindings: PCI: socionext,uniphier-pcie-ep: Add top-level constraints

Kunwu Chan (1):
      PCI: Make pci_bus_type constant

Lorenzo Bianconi (4):
      dt-bindings: PCI: mediatek-gen3: Add support for Airoha EN7581
      PCI: mediatek-gen3: Add mtk_gen3_pcie_pdata data structure
      PCI: mediatek-gen3: Rely on reset_bulk APIs for PHY reset lines
      PCI: mediatek-gen3: Add Airoha EN7581 support

Lukas Wunner (1):
      s390/pci: Stop usurping pdev->dev.groups

Maciej W. Rozycki (4):
      PCI: Clear the LBMS bit after a link retrain
      PCI: Revert to the original speed after PCIe failed link retraining
      PCI: Correct error reporting with PCIe failed link retraining
      PCI: Use an error code with PCIe failed link retraining

Manivannan Sadhasivam (12):
      PCI: qcom-ep: Drop the redundant masking of global IRQ events
      PCI: qcom-ep: Reword the error message for receiving unknown global IRQ event
      dt-bindings: PCI: pci-ep: Update Maintainers
      dt-bindings: PCI: pci-ep: Document 'linux,pci-domain' property
      PCI: endpoint: Assign PCI domain number for endpoint controllers
      PCI: qcom-ep: Modify 'global_irq' and 'perst_irq' IRQ device names
      dt-bindings: PCI: qcom,pcie-sm8450: Add 'global' interrupt
      PCI: qcom: Enumerate endpoints based on Link up event in 'global_irq' interrupt
      PCI: qcom-ep: Enable controller resources like PHY only after refclk is available
      PCI: dwc: Rename 'dw_pcie::link_gen' to 'dw_pcie::max_link_speed'
      PCI: dwc: Always cache the maximum link speed value in dw_pcie::max_link_speed
      PCI: Pass domain number to pci_bus_release_domain_nr() explicitly

Marek Vasut (15):
      genirq/msi: Silence 'set affinity failed' warning
      PCI: aardvark: Silence 'set affinity failed' warning
      PCI: altera-msi: Silence 'set affinity failed' warning
      PCI: brcmstb: Silence 'set affinity failed' warning
      PCI: dwc: Silence 'set affinity failed' warning
      PCI: mediatek-gen3: Silence 'set affinity failed' warning
      PCI: mediatek: Silence 'set affinity failed' warning
      PCI: mobiveil: Silence 'set affinity failed' warning
      PCI: plda: Silence 'set affinity failed' warning
      PCI: rcar-host: Silence 'set affinity failed' warning
      PCI: tegra: Silence 'set affinity failed' warning
      PCI: vmd: Silence 'set affinity failed' warning
      PCI: xilinx-nwl: Silence 'set affinity failed' warning
      PCI: xilinx-xdma: Silence 'set affinity failed' warning
      PCI: xilinx: Silence 'set affinity failed' warning

Mariusz Tkaczyk (3):
      leds: Init leds class earlier
      PCI/NPEM: Add Native PCIe Enclosure Management support
      PCI/NPEM: Add _DSM PCIe SSD status LED management

Matthew Gerlach (2):
      dt-bindings: PCI: altera: Convert to YAML
      dt-bindings: PCI: altera: msi: Convert to YAML

Philipp Stanner (4):
      PCI: Make pcim_request_region() a public function
      drm/vboxvideo: Add PCI region request
      PCI: Deprecate pcim_iomap_regions() in favor of pcim_iomap_region()
      drm/ast: Request PCI BAR with devres

Prudhvi Yarlagadda (1):
      PCI: qcom: Disable mirroring of DBI and iATU register space in BAR region

Rayyan Ansari (1):
      dt-bindings: PCI: qcom,pcie-sc7280: Update bindings adding eight interrupts

Richard Zhu (5):
      PCI: imx6: Fix establish link failure in EP mode for i.MX8MM and i.MX8MP
      PCI: imx6: Fix i.MX8MP PCIe EP's occasional failure to trigger MSI
      dt-bindings: PCI: imx6q-pcie: Add i.MX8Q PCIe compatible string
      PCI: imx6: Add i.MX8Q PCIe Root Complex (RC) support
      dt-bindings: PCI: imx6q-pcie: Add reg-name "dbi2" and "atu" for i.MX8M PCIe Endpoint

Riyan Dhiman (1):
      PCI: vmd: Fix indentation issue in vmd_shutdown()

Samasth Norway Ananda (1):
      x86/PCI: Check pcie_find_root_port() return for NULL

Sean Anderson (7):
      PCI: xilinx-nwl: Fix off-by-one in INTx IRQ handler
      PCI: xilinx-nwl: Fix register misspelling
      PCI: xilinx-nwl: Rate-limit misc interrupt messages
      PCI: xilinx-nwl: Clean up clock on probe failure/removal
      dt-bindings: pci: xilinx-nwl: Add phys property
      PCI: xilinx-nwl: Add PHY support
      arm64: zynqmp: Add PCIe phys property for ZCU102

Shashank Babu Chinta Venkata (2):
      PCI: qcom: Add equalization settings for 16.0 GT/s
      PCI: qcom: Add RX lane margining settings for 16.0 GT/s

Siddharth Vadapalli (4):
      dt-bindings: PCI: ti,j721e-pci-host: Add ACSPCIE proxy control property
      PCI: j721e: Enable ACSPCIE Refclk if "ti,syscon-acspcie-proxy-ctrl" exists
      PCI: dra7xx: Fix threaded IRQ request for "dra7xx-pcie-main" IRQ
      PCI: dra7xx: Fix error handling when IRQ request fails in probe

Subramanian Ananthanarayanan (1):
      PCI: Add ACS quirk for Qualcomm SA8775P

Thippeswamy Havalige (2):
      dt-bindings: PCI: xilinx-xdma: Add schemas for Xilinx QDMA PCIe Root Port Bridge
      PCI: xilinx-xdma: Add Xilinx QDMA Root Port driver

Thomas Richard (5):
      PCI: cadence: Extract link setup sequence from cdns_pcie_host_setup()
      PCI: cadence: Set cdns_pcie_host_init() global
      PCI: j721e: Use dev_err_probe() in the probe() function
      PCI: Add T_PERST_CLK_US macro
      PCI: j721e: Use T_PERST_CLK_US macro

Théo Lebrun (2):
      PCI: j721e: Add reset GPIO to struct j721e_pcie
      PCI: j721e: Add suspend and resume support

WangYuli (1):
      PCI: Add function 0 DMA alias quirk for Glenfly Arise chip

Yoshihiro Shimoda (2):
      dt-bindings: PCI: rcar-gen4-pci-host: Add R-Car V4M compatible
      dt-bindings: PCI: rcar-gen4-pci-ep: Add R-Car V4M compatible

Yue Haibing (2):
      PCI/PM: Remove __pci_pme_wakeup() unused declarations
      PCI/VPD: Remove pci_vpd_release() unused declarations

ngn (1):
      PCI: shpchp: Remove hpc_ops

weiyufeng (1):
      PCI: cpqphp: Use PCI_POSSIBLE_ERROR() to check config reads

zhang jiao (2):
      tools: PCI: Remove .*.cmd files with make clean
      tools: PCI: Remove unused BILLION macro

 Documentation/ABI/testing/sysfs-bus-pci            |   72 ++
 .../devicetree/bindings/pci/altera-pcie-msi.txt    |   27 -
 .../devicetree/bindings/pci/altera-pcie.txt        |   50 -
 .../bindings/pci/altr,msi-controller.yaml          |   65 ++
 .../bindings/pci/altr,pcie-root-port.yaml          |  114 +++
 .../devicetree/bindings/pci/brcm,stb-pcie.yaml     |   42 +-
 .../devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml |   13 +-
 .../devicetree/bindings/pci/fsl,imx6q-pcie.yaml    |   16 +
 .../bindings/pci/fsl,layerscape-pcie.yaml          |   41 +-
 .../bindings/pci/hisilicon,kirin-pcie.yaml         |    3 +-
 .../devicetree/bindings/pci/host-generic-pci.yaml  |    2 -
 .../bindings/pci/mediatek-pcie-gen3.yaml           |   68 +-
 Documentation/devicetree/bindings/pci/pci-ep.yaml  |   14 +-
 .../devicetree/bindings/pci/qcom,pcie-common.yaml  |    7 +-
 .../devicetree/bindings/pci/qcom,pcie-ep.yaml      |    1 +
 .../devicetree/bindings/pci/qcom,pcie-sc7280.yaml  |   27 +-
 .../bindings/pci/qcom,pcie-sc8280xp.yaml           |    3 -
 .../devicetree/bindings/pci/qcom,pcie-sm8450.yaml  |   10 +-
 .../devicetree/bindings/pci/qcom,pcie.yaml         |    3 +
 .../devicetree/bindings/pci/rcar-gen4-pci-ep.yaml  |    1 +
 .../bindings/pci/rcar-gen4-pci-host.yaml           |    1 +
 .../bindings/pci/renesas,pci-rcar-gen2.yaml        |    8 +-
 .../bindings/pci/socionext,uniphier-pcie-ep.yaml   |    8 +-
 .../devicetree/bindings/pci/ti,j721e-pci-host.yaml |   10 +
 .../devicetree/bindings/pci/xlnx,nwl-pcie.yaml     |    7 +
 .../devicetree/bindings/pci/xlnx,xdma-host.yaml    |   36 +-
 MAINTAINERS                                        |    8 +-
 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts  |    1 +
 arch/s390/include/asm/pci.h                        |    9 +-
 arch/s390/pci/Makefile                             |    3 +-
 arch/s390/pci/pci.c                                |    1 -
 arch/s390/pci/pci_sysfs.c                          |   14 +-
 arch/x86/pci/fixup.c                               |    4 +-
 drivers/Makefile                                   |    4 +-
 drivers/acpi/pci_mcfg.c                            |   12 +
 drivers/bcma/driver_pci_host.c                     |   10 +-
 drivers/gpu/drm/ast/ast_drv.c                      |   12 +-
 drivers/gpu/drm/vboxvideo/vbox_main.c              |    4 +
 drivers/pci/Kconfig                                |    9 +
 drivers/pci/Makefile                               |    1 +
 drivers/pci/ats.c                                  |    4 +-
 drivers/pci/controller/Kconfig                     |    2 +-
 drivers/pci/controller/cadence/Kconfig             |    2 +-
 drivers/pci/controller/cadence/pci-j721e.c         |  160 +++-
 drivers/pci/controller/cadence/pcie-cadence-host.c |   44 +-
 drivers/pci/controller/cadence/pcie-cadence.h      |   13 +-
 drivers/pci/controller/dwc/Kconfig                 |    5 +
 drivers/pci/controller/dwc/Makefile                |    1 +
 drivers/pci/controller/dwc/pci-dra7xx.c            |   11 +-
 drivers/pci/controller/dwc/pci-imx6.c              | 1000 +++++++++++---------
 drivers/pci/controller/dwc/pci-keystone.c          |    9 +-
 drivers/pci/controller/dwc/pcie-designware-host.c  |   12 +-
 drivers/pci/controller/dwc/pcie-designware.c       |   24 +-
 drivers/pci/controller/dwc/pcie-designware.h       |   35 +-
 drivers/pci/controller/dwc/pcie-intel-gw.c         |    4 +-
 drivers/pci/controller/dwc/pcie-kirin.c            |    4 +-
 drivers/pci/controller/dwc/pcie-qcom-common.c      |   78 ++
 drivers/pci/controller/dwc/pcie-qcom-common.h      |   14 +
 drivers/pci/controller/dwc/pcie-qcom-ep.c          |   41 +-
 drivers/pci/controller/dwc/pcie-qcom.c             |  133 ++-
 drivers/pci/controller/dwc/pcie-rcar-gen4.c        |   13 +-
 drivers/pci/controller/dwc/pcie-spear13xx.c        |    2 +-
 drivers/pci/controller/dwc/pcie-tegra194.c         |   37 +-
 .../pci/controller/mobiveil/pcie-mobiveil-host.c   |   11 +-
 drivers/pci/controller/pci-aardvark.c              |   74 +-
 drivers/pci/controller/pci-tegra.c                 |   10 +-
 drivers/pci/controller/pci-xgene.c                 |    6 +-
 drivers/pci/controller/pcie-altera-msi.c           |   11 +-
 drivers/pci/controller/pcie-altera.c               |    3 +-
 drivers/pci/controller/pcie-brcmstb.c              |  602 ++++++++----
 drivers/pci/controller/pcie-iproc.c                |   18 +-
 drivers/pci/controller/pcie-mediatek-gen3.c        |  193 +++-
 drivers/pci/controller/pcie-mediatek.c             |   12 +-
 drivers/pci/controller/pcie-rcar-host.c            |   10 +-
 drivers/pci/controller/pcie-xilinx-dma-pl.c        |   64 +-
 drivers/pci/controller/pcie-xilinx-nwl.c           |  150 ++-
 drivers/pci/controller/pcie-xilinx.c               |    9 +-
 drivers/pci/controller/plda/pcie-plda-host.c       |   11 +-
 drivers/pci/controller/vmd.c                       |   17 +-
 drivers/pci/devres.c                               |    9 +-
 drivers/pci/endpoint/pci-epc-core.c                |   14 +
 drivers/pci/hotplug/TODO                           |    5 -
 drivers/pci/hotplug/cpqphp_core.c                  |    2 +-
 drivers/pci/hotplug/cpqphp_pci.c                   |    4 +-
 drivers/pci/hotplug/s390_pci_hpc.c                 |    2 +-
 drivers/pci/hotplug/shpchp.h                       |   38 +-
 drivers/pci/hotplug/shpchp_core.c                  |   15 +-
 drivers/pci/hotplug/shpchp_ctrl.c                  |   79 +-
 drivers/pci/hotplug/shpchp_hpc.c                   |   63 +-
 drivers/pci/iomap.c                                |    2 +-
 drivers/pci/npem.c                                 |  595 ++++++++++++
 drivers/pci/pci-bridge-emul.c                      |    4 +-
 drivers/pci/pci-driver.c                           |    2 +-
 drivers/pci/pci-sysfs.c                            |    5 +
 drivers/pci/pci.c                                  |   75 +-
 drivers/pci/pci.h                                  |   46 +-
 drivers/pci/pcie/aer_inject.c                      |    4 +-
 drivers/pci/probe.c                                |   37 +-
 drivers/pci/pwrctl/pci-pwrctl-pwrseq.c             |    5 +
 drivers/pci/quirks.c                               |   39 +-
 drivers/pci/remove.c                               |    4 +-
 include/linux/bcma/bcma_driver_pci.h               |    2 +-
 include/linux/msi.h                                |    2 +
 include/linux/pci-epc.h                            |    3 +
 include/linux/pci.h                                |   11 +-
 include/linux/pci_ids.h                            |    2 +
 include/uapi/linux/pci_regs.h                      |   41 +-
 kernel/irq/msi.c                                   |    2 +-
 sound/pci/hda/hda_intel.c                          |    2 +-
 tools/pci/Makefile                                 |    2 +-
 tools/pci/pcitest.c                                |    2 -
 111 files changed, 3369 insertions(+), 1339 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pci/altera-pcie-msi.txt
 delete mode 100644 Documentation/devicetree/bindings/pci/altera-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/altr,msi-controller.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-qcom-common.c
 create mode 100644 drivers/pci/controller/dwc/pcie-qcom-common.h
 create mode 100644 drivers/pci/npem.c

