Return-Path: <linux-pci+bounces-33295-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D1BB183A4
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 16:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93A943B7C59
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 14:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E79726B75B;
	Fri,  1 Aug 2025 14:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nOI1wN2F"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB09225C833;
	Fri,  1 Aug 2025 14:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754058177; cv=none; b=LTNQNSz9fcCiPx43mczFgjhNmDJoo+GNQPwUqjij0J2wH3Fk+u3GWoDSGXRKBQErRCGXehN42y9GwHlvEWcJKogcgkQfB2ydcfaifBltsH9S37RBU0ReqP6EmHzE42GD/pfSB5Q8cBONpKBb6odXR5B+5Szy1xF8jchDbd7wMxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754058177; c=relaxed/simple;
	bh=fE/tn9r3Wla87IudWXAa61XOPYJ8WJsA+NE0fakKSaE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hHQrSXmdRjervYlP7TB6O20oC/ZuewVzpIpKv/hGKXy2Z9noHO7Ew896V3rRWK+OQqQ91wY8h13U/d1orCYgvkaUiXMlAFZz/zUoCMFYNQN/MC20KWUpMaPF1ooPzmrU67ebjUlptYh2eFd6efZNgh0R29hGsKqFRnJyBVD5EhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nOI1wN2F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20321C4CEE7;
	Fri,  1 Aug 2025 14:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754058177;
	bh=fE/tn9r3Wla87IudWXAa61XOPYJ8WJsA+NE0fakKSaE=;
	h=Date:From:To:Cc:Subject:From;
	b=nOI1wN2FpAEGc9jPggXpkUM07AbQBkZQOjUKo2BgnGcHtNbZjSC3CCS8UqkeK/Pgo
	 Rp7gypII+38MSW4CP48flwGCbVxb+v3VBqD4Ak5LP31kNvVf5MhWo/2YWuqoaGNQdB
	 8nmKwCZie7bTReNcFJfh/nyjYUfdd108+HP/Ve6S5M4F/F4XH3rFkATn+LwCUwuoFV
	 +8R84gTp1PePBVNhSdspI2Fvg+N2FDfnhuu/muFT5bXiQ5VOzipQaceDw1dMIp61oU
	 tPcGcBUKr9vzzha0eTgZTQNKd0MWAQKq/ZPvULkNKO7wQHktOsueAMQMbXQP61AX1D
	 CU3iNxZct+fcQ==
Date: Fri, 1 Aug 2025 09:22:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: [GIT PULL v2] PCI changes for v6.17
Message-ID: <20250801142254.GA3496192@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit 66db1d3cbdb0e89f8a3b5d06a8defb25d1c3f836:

  PCI/pwrctrl: Add optional slot clock for PCI slots (2025-06-13 16:59:52 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.17-changes

for you to fetch changes up to 58d2b6b6b214d8b4914cd4c821a8bd0c75436c2c:

  Merge branch 'pci/misc' (2025-07-31 16:12:19 -0500)

This is based on v6.16-rc1, but you have 66db1d3cbdb0 ("PCI/pwrctrl: Add
optional slot clock for PCI slots") already via 0dc89a25468e ("Merge tag
'renesas-dts-for-v6.17-tag1' of https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel into soc/dt")

You should see a minor conflict in drivers/pci/pci.c between upstream
commit:

  907a7a2e5bf4 ("PCI/PM: Set up runtime PM even for devices without PCI PM")

and this commit from the PCI tree:

  5c0d0ee36f16 ("PCI: Support Immediate Readiness on devices without PM capabilities")

My resolution (same as linux-next) is here:

  https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git/tree/drivers/pci/pci.c?id=7b76d8fd6a64#n3213

Relative to the first pull request, this drops the pci/capability-search
branch, which caused a regression on s390:
https://lore.kernel.org/r/4e10bea3aa91ee721bb40e9388e8f72f930908fe.camel@linux.ibm.com

----------------------------------------------------------------

Enumeration:

  - Allow built-in drivers, not just modular drivers, to use async initial
    probing (Lukas Wunner)

  - Support Immediate Readiness even on devices with no PM Capability (Sean
    Christopherson)

  - Consolidate definition of PCIE_RESET_CONFIG_WAIT_MS (100ms), the
    required delay between a reset and sending config requests to a device
    (Niklas Cassel)

  - Add pci_is_display() to check for "Display" base class and use it in
    ALSA hda, vfio, vga_switcheroo, vt-d (Mario Limonciello)

  - Allow 'isolated PCI functions' (multi-function devices without a
    function 0) for LoongArch, similar to s390 and jailhouse (Huacai Chen)

Power control:

  - Add ability to enable optional slot clock for cases where the PCIe host
    controller and the slot are supplied by different clocks (Marek Vasut)

PCIe native device hotplug:

  - Fix runtime PM ref imbalance on Hot-Plug Capable ports caused by
    misinterpreting a config read failure after a device has been removed
    (Lukas Wunner)

  - Avoid creating a useless PCIe port service device for pciehp if the
    slot is handled by the ACPI hotplug driver (Lukas Wunner)

  - Ignore ACPI hotplug slots when calculating depth of pciehp hotplug
    ports (Lukas Wunner)

Virtualization:

  - Save VF resizable BAR state and restore it after reset (Michał
    Winiarski)

  - Allow IOV resources (VF BARs) to be resized (Michał Winiarski)

  - Add pci_iov_vf_bar_set_size() so drivers can control VF BAR size
    (Michał Winiarski)

Endpoint framework:

  - Add RC-to-EP doorbell support using platform MSI controller, including
    a test case (Frank Li)

  - Allow BAR assignment via configfs so platforms have flexibility in
    determining BAR usage (Jerome Brunet)

Native PCIe controller drivers:

  - Convert amazon,al-alpine-v[23]-pcie, apm,xgene-pcie, axis,artpec6-pcie,
    marvell,armada-3700-pcie, st,spear1340-pcie to DT schema format (Rob
    Herring)

  - Use dev_fwnode() instead of of_fwnode_handle() to remove OF dependency
    in altera (fixes an unused variable), designware-host, mediatek,
    mediatek-gen3, mobiveil, plda, xilinx, xilinx-dma, xilinx-nwl (Jiri
    Slaby, Arnd Bergmann)

  - Convert aardvark, altera, brcmstb, designware-host, iproc, mediatek,
    mediatek-gen3, mobiveil, plda, rcar-host, vmd, xilinx, xilinx-dma,
    xilinx-nwl from using pci_msi_create_irq_domain() to using
    msi_create_parent_irq_domain() instead; this makes the interrupt
    controller per-PCI device, allows dynamic allocation of vectors after
    initialization, and allows support of IMS (Nam Cao)

APM X-Gene PCIe controller driver:

  - Rewrite MSI handling to MSI CPU affinity, drop useless CPU hotplug
    bits, use device-managed memory allocations, and clean things up (Marc
    Zyngier)

  - Probe xgene-msi as a standard platform driver rather than a
    subsys_initcall (Marc Zyngier)

Broadcom STB PCIe controller driver:

  - Add optional DT 'num-lanes' property and if present, use it to override
    the Maximum Link Width advertised in Link Capabilities (Jim Quinlan)

Cadence PCIe controller driver:

  - Use PCIe Message routing types from the PCI core rather than defining
    private ones (Hans Zhang)

Freescale i.MX6 PCIe controller driver:

  - Add IMX8MQ_EP third 64-bit BAR in epc_features (Richard Zhu)

  - Add IMX8MM_EP and IMX8MP_EP fixed 256-byte BAR 4 in epc_features
    (Richard Zhu)

  - Configure LUT for MSI/IOMMU in Endpoint mode so Root Complex can
    trigger doorbel on Endpoint (Frank Li)

  - Remove apps_reset (LTSSM_EN) from
    imx_pcie_{assert,deassert}_core_reset(), which fixes a hotplug
    regression on i.MX8MM (Richard Zhu)

  - Delay Endpoint link start until configfs 'start' written (Richard Zhu)

Intel VMD host bridge driver:

  - Add Intel Panther Lake (PTL)-H/P/U Vendor ID (George D Sworo)

Qualcomm PCIe controller driver:

  - Add DT binding and driver support for SA8255p, which supports ECAM for
    Configuration Space access (Mayank Rana)

  - Update DT binding and driver to describe PHYs and per-Root Port resets
    in a Root Port stanza and deprecate describing them in the host bridge;
    this makes it possible to support multiple Root Ports in the future
    (Krishna Chaitanya Chundru)

  - Add Qualcomm QCS615 to SM8150 DT binding (Ziyue Zhang)

  - Add Qualcomm QCS8300 to SA8775p DT binding (Ziyue Zhang)

  - Drop TBU and ref clocks from Qualcomm SM8150 and SC8180x DT bindings
    (Konrad Dybcio)

  - Document 'link_down' reset in Qualcomm SA8775P DT binding (Ziyue Zhang)

  - Add required PCIE_RESET_CONFIG_WAIT_MS delay after Link up IRQ (Niklas
    Cassel)

Rockchip PCIe controller driver:

  - Drop unused PCIe Message routing and code definitions (Hans Zhang)

  - Remove several unused header includes (Hans Zhang)

  - Use standard PCIe config register definitions instead of
    rockchip-specific redefinitions (Geraldo Nascimento)

  - Set Target Link Speed to 5.0 GT/s before retraining so we have a chance
    to train at a higher speed (Geraldo Nascimento)

Rockchip DesignWare PCIe controller driver:

  - Prevent race between link training and register update via DBI by
    inhibiting link training after hot reset and link down (Wilfred
    Mallawa)

  - Add required PCIE_RESET_CONFIG_WAIT_MS delay after Link up IRQ (Niklas
    Cassel)

Sophgo PCIe controller driver:

  - Add DT binding and driver for Sophgo SG2044 PCIe controller driver in
    Root Complex mode (Inochi Amaoto)

Synopsys DesignWare PCIe controller driver:

  - Add required PCIE_RESET_CONFIG_WAIT_MS after waiting for Link up on
    Ports that support > 5.0 GT/s.  Slower Ports still rely on the
    not-quite-correct PCIE_LINK_WAIT_SLEEP_MS 90ms default delay while
    waiting for the Link (Niklas Cassel)

----------------------------------------------------------------
Akshay Jindal (1):
      PCI/AER: Add message when AER_MAX_MULTI_ERR_DEVICES limit is hit

Bartosz Golaszewski (1):
      PCI/pwrctrl: Fix the kerneldoc tag for private fields

Bjorn Helgaas (28):
      PCI: Fix typos
      Merge branch 'pci/aer'
      Merge branch 'pci/aspm'
      Merge branch 'pci/boot-display'
      Merge branch 'pci/enumeration'
      Merge branch 'pci/hotplug'
      Merge branch 'pci/iommu'
      Merge branch 'pci/pwrctrl'
      Merge branch 'pci/resources'
      Merge branch 'pci/dt-bindings'
      Merge branch 'pci/endpoint/core'
      Merge branch 'pci/endpoint/doorbell'
      Merge branch 'pci/endpoint/epf-vntb'
      Merge branch 'pci/controller/msi-parent'
      Merge branch 'pci/controller/linkup-fix'
      Merge branch 'pci/controller/brcmstb'
      Merge branch 'pci/controller/cadence'
      Merge branch 'pci/controller/dwc'
      Merge branch 'pci/controller/dw-rockchip'
      Merge branch 'pci/controller/imx6'
      Merge branch 'pci/controller/mvebu'
      Merge branch 'pci/controller/qcom'
      Merge branch 'pci/controller/rockchip'
      Merge branch 'pci/controller/rockchip-host'
      Merge branch 'pci/controller/sophgo'
      Merge branch 'pci/controller/vmd'
      Merge branch 'pci/controller/xgene'
      Merge branch 'pci/misc'

Damien Le Moal (2):
      PCI: endpoint: Fix configfs group list head handling
      PCI: endpoint: Fix configfs group removal on driver teardown

Florian Fainelli (2):
      MAINTAINERS: Drop Nicolas from maintaining pcie-brcmstb
      PCI: brcmstb: Replace open coded value with PCIE_T_RRS_READY_MS

Frank Li (8):
      PCI: imx6: Add helper function imx_pcie_add_lut_by_rid()
      PCI: imx6: Add LUT configuration for MSI/IOMMU in Endpoint mode
      PCI: endpoint: Add RC-to-EP doorbell support using platform MSI controller
      PCI: endpoint: pci-ep-msi: Add checks for MSI parent and mutability
      PCI: endpoint: Add pci_epf_align_inbound_addr() helper for inbound address alignment
      PCI: endpoint: pci-epf-test: Add doorbell test support
      misc: pci_endpoint_test: Add doorbell test case
      selftests: pci_endpoint: Add doorbell test case

George D Sworo (1):
      PCI: vmd: Add VMD Device ID Support for Panther Lake (PTL)-H/P/U

Geraldo Nascimento (2):
      PCI: rockchip: Use standard PCIe definitions
      PCI: rockchip: Set Target Link Speed to 5.0 GT/s before retraining

Guilherme Giacomo Simoes (1):
      PCI: hotplug: Remove TODO about unused .get_power(), .hardware_test()

Hans Zhang (10):
      PCI: rockchip-host: Fix "Unexpected Completion" log message
      PCI: rockchip-host: Correct non-fatal error log message
      PCI: rockchip-host: Remove unused header includes
      dt-bindings: PCI: pci-ep: Extend max-link-speed to PCIe Gen5/Gen6
      PCI/ASPM: Use boolean type for aspm_disabled and aspm_force
      PCI/ASPM: Consolidate variable declaration and initialization
      PCI/AER: Use bool for AER disable state tracking
      PCI: cadence: Replace private message routing enums with PCI core definitions
      PCI: rockchip: Remove redundant PCIe message routing definitions
      PCI: dwc: Simplify the return value of PTM debugfs functions returning bool

Huacai Chen (1):
      PCI: Extend isolated function probing to LoongArch

Inochi Amaoto (2):
      dt-bindings: pci: Add Sophgo SG2044 PCIe host
      PCI: dwc: Add Sophgo SG2044 PCIe controller driver in Root Complex mode

Jerome Brunet (3):
      PCI: endpoint: pci-epf-vntb: Return -ENOENT if pci_epc_get_next_free_bar() fails
      PCI: endpoint: pci-epf-vntb: Align MW naming with config names
      PCI: endpoint: pci-epf-vntb: Allow BAR assignment via configfs

Jim Quinlan (2):
      dt-bindings: PCI: brcm,stb-pcie: Add num-lanes property
      PCI: brcmstb: Set MLW based on "num-lanes" DT property if present

Jiri Slaby (SUSE) (1):
      PCI: controller: Use dev_fwnode() instead of of_fwnode_handle()

Jiwei Sun (2):
      PCI: Fix link speed calculation on retrain failure
      PCI: Adjust the position of reading the Link Control 2 register

Konrad Dybcio (2):
      dt-bindings: PCI: qcom,pcie-sc8180x: Drop unrelated clocks from PCIe hosts
      dt-bindings: PCI: qcom,pcie-sm8150: Drop unrelated clocks from PCIe hosts

Krishna Chaitanya Chundru (2):
      dt-bindings: PCI: qcom: Move PHY & reset GPIO to Root Port node
      PCI: qcom: Add support for parsing the new Root Port binding

Lukas Wunner (5):
      PCI: Allow built-in drivers to use async initial probing
      PCI/ACPI: Fix runtime PM ref imbalance on Hot-Plug Capable ports
      PCI/portdrv: Use is_pciehp instead of is_hotplug_bridge
      PCI: pciehp: Use is_pciehp instead of is_hotplug_bridge
      PCI: Move is_pciehp check out of pciehp_is_native()

Manivannan Sadhasivam (2):
      PCI: dwc: Make dw_pcie_ptm_ops static
      PCI: endpoint: pci-epf-vntb: Fix the incorrect usage of __iomem attribute

Marc Zyngier (13):
      genirq: Teach handle_simple_irq() to resend an in-progress interrupt
      PCI: xgene: Defer probing if the MSI widget driver hasn't probed yet
      PCI: xgene: Drop useless conditional compilation
      PCI: xgene: Drop XGENE_PCIE_IP_VER_UNKN
      PCI: xgene-msi: Make per-CPU interrupt setup robust
      PCI: xgene-msi: Drop superfluous fields from xgene_msi structure
      PCI: xgene-msi: Use device-managed memory allocations
      PCI: xgene-msi: Get rid of intermediate tracking structure
      PCI: xgene-msi: Sanitise MSI allocation and affinity setting
      PCI: xgene-msi: Resend an MSI racing with itself on a different CPU
      PCI: xgene-msi: Probe as a standard platform driver
      PCI: xgene-msi: Restructure handler setup/teardown
      cpu/hotplug: Remove unused cpuhp_state CPUHP_PCI_XGENE_DEAD

Mario Limonciello (5):
      PCI: Add pci_is_display() to check if device is a display controller
      vfio/pci: Use pci_is_display()
      vga_switcheroo: Use pci_is_display()
      iommu/vt-d: Use pci_is_display()
      ALSA: hda: Use pci_is_display()

Mayank Rana (4):
      PCI: dwc: Export DWC MSI controller related APIs
      PCI: host-generic: Rename and export gen_pci_init() for PCIe controller drivers
      dt-bindings: PCI: qcom,pcie-sa8255p: Document ECAM compliant PCIe root complex
      PCI: qcom: Add support for Qualcomm SA8255p based PCIe Root Complex

Michał Winiarski (5):
      PCI/IOV: Restore VF resizable BAR state after reset
      PCI/IOV: Add pci_resource_num_to_vf_bar() to convert VF BAR number to/from IOV resource
      PCI/IOV: Allow IOV resources to be resized in pci_resize_resource()
      PCI/IOV: Check that VF BAR fits within the reservation
      PCI/IOV: Allow drivers to control VF BAR size

Nam Cao (15):
      PCI: dwc: Switch to msi_create_parent_irq_domain()
      PCI: mobiveil: Switch to msi_create_parent_irq_domain()
      PCI: aardvark: Switch to msi_create_parent_irq_domain()
      PCI: altera-msi: Switch to msi_create_parent_irq_domain()
      PCI: brcmstb: Switch to msi_create_parent_irq_domain()
      PCI: iproc: Switch to msi_create_parent_irq_domain()
      PCI: mediatek-gen3: Switch to msi_create_parent_irq_domain()
      PCI: mediatek: Switch to msi_create_parent_irq_domain()
      PCI: rcar-host: Switch to msi_create_parent_irq_domain()
      PCI: xilinx-xdma: Switch to msi_create_parent_irq_domain()
      PCI: xilinx-nwl: Switch to msi_create_parent_irq_domain()
      PCI: xilinx: Switch to msi_create_parent_irq_domain()
      PCI: plda: Switch to msi_create_parent_irq_domain()
      PCI: vmd: Convert to lock guards
      PCI: vmd: Switch to msi_create_parent_irq_domain()

Niklas Cassel (6):
      PCI: Rename PCIE_RESET_CONFIG_DEVICE_WAIT_MS to PCIE_RESET_CONFIG_WAIT_MS
      PCI: rockchip-host: Use macro PCIE_RESET_CONFIG_WAIT_MS
      PCI: dw-rockchip: Wait PCIE_RESET_CONFIG_WAIT_MS after link-up IRQ
      PCI: qcom: Wait PCIE_RESET_CONFIG_WAIT_MS after link-up IRQ
      PCI: dwc: Ensure that dw_pcie_wait_for_link() waits 100 ms after link up
      PCI: Move link up wait time and max retries macros to pci.h

Richard Zhu (4):
      PCI: imx6: Add IMX8MQ_EP third 64-bit BAR in epc_features
      PCI: imx6: Add IMX8MM_EP and IMX8MP_EP fixed 256-byte BAR 4 in epc_features
      PCI: imx6: Remove apps_reset toggling from imx_pcie_{assert/deassert}_core_reset
      PCI: imx6: Delay link start until configfs 'start' written

Rob Herring (Arm) (6):
      dt-bindings: PCI: Convert st,spear1340-pcie to DT schema
      dt-bindings: PCI: Convert axis,artpec6-pcie to DT schema
      dt-bindings: PCI: Convert apm,xgene-pcie to DT schema
      dt-bindings: PCI: Convert marvell,armada-3700-pcie to DT schema
      dt-bindings: PCI: Convert amazon,al-alpine-v[23]-pcie to DT schema
      dt-bindings: PCI: Remove 83xx-512x-pci.txt

Robin Murphy (1):
      PCI: Fix driver_managed_dma check

Salah Triki (1):
      PCI: mvebu: Use devm_add_action_or_reset() instead of devm_add_action()

Sean Christopherson (1):
      PCI: Support Immediate Readiness on devices without PM capabilities

Wilfred Mallawa (1):
      PCI: dw-rockchip: Delay link training after hot reset in EP mode

Ziyue Zhang (3):
      dt-bindings: PCI: qcom,pcie-sm8150: Document QCS615
      dt-bindings: PCI: qcom,pcie-sa8775p: Document QCS8300
      dt-bindings: PCI: qcom,pcie-sa8775p: Document 'link_down' reset

 Documentation/PCI/endpoint/pci-test-howto.rst      |  15 +
 .../devicetree/bindings/pci/83xx-512x-pci.txt      |  39 --
 .../devicetree/bindings/pci/aardvark-pci.txt       |  59 ---
 .../bindings/pci/amazon,al-alpine-v3-pcie.yaml     |  71 ++++
 .../devicetree/bindings/pci/apm,xgene-pcie.yaml    |  84 ++++
 .../devicetree/bindings/pci/axis,artpec6-pcie.txt  |  50 ---
 .../devicetree/bindings/pci/axis,artpec6-pcie.yaml | 118 ++++++
 .../devicetree/bindings/pci/brcm,stb-pcie.yaml     |   4 +
 .../bindings/pci/marvell,armada-3700-pcie.yaml     |  99 +++++
 Documentation/devicetree/bindings/pci/pci-ep.yaml  |   2 +-
 Documentation/devicetree/bindings/pci/pcie-al.txt  |  46 ---
 .../devicetree/bindings/pci/qcom,pcie-common.yaml  |  32 +-
 .../devicetree/bindings/pci/qcom,pcie-sa8255p.yaml | 122 ++++++
 .../devicetree/bindings/pci/qcom,pcie-sa8775p.yaml |  18 +-
 .../devicetree/bindings/pci/qcom,pcie-sc7280.yaml  |  16 +-
 .../devicetree/bindings/pci/qcom,pcie-sc8180x.yaml |  14 +-
 .../devicetree/bindings/pci/qcom,pcie-sm8150.yaml  |  21 +-
 .../devicetree/bindings/pci/snps,dw-pcie.yaml      |   2 +-
 .../bindings/pci/sophgo,sg2044-pcie.yaml           | 122 ++++++
 .../devicetree/bindings/pci/spear13xx-pcie.txt     |  14 -
 .../devicetree/bindings/pci/st,spear1340-pcie.yaml |  45 +++
 .../devicetree/bindings/pci/xgene-pci.txt          |  50 ---
 MAINTAINERS                                        |   7 +-
 drivers/gpu/vga/vga_switcheroo.c                   |   2 +-
 drivers/iommu/intel/iommu.c                        |   2 +-
 drivers/misc/pci_endpoint_test.c                   |  83 ++++
 drivers/pci/bus.c                                  |   5 +-
 drivers/pci/controller/Kconfig                     |  11 +
 drivers/pci/controller/cadence/pcie-cadence-ep.c   |   2 +-
 drivers/pci/controller/cadence/pcie-cadence.h      |  20 -
 drivers/pci/controller/dwc/Kconfig                 |  12 +
 drivers/pci/controller/dwc/Makefile                |   1 +
 drivers/pci/controller/dwc/pci-imx6.c              |  40 +-
 .../pci/controller/dwc/pcie-designware-debugfs.c   |  16 +-
 drivers/pci/controller/dwc/pcie-designware-host.c  | 103 ++---
 drivers/pci/controller/dwc/pcie-designware.c       |  14 +-
 drivers/pci/controller/dwc/pcie-designware.h       |  19 +-
 drivers/pci/controller/dwc/pcie-dw-rockchip.c      |  16 +-
 drivers/pci/controller/dwc/pcie-qcom.c             | 327 ++++++++++++++--
 drivers/pci/controller/dwc/pcie-sophgo.c           | 257 +++++++++++++
 drivers/pci/controller/mobiveil/Kconfig            |   1 +
 .../pci/controller/mobiveil/pcie-mobiveil-host.c   |  48 +--
 drivers/pci/controller/mobiveil/pcie-mobiveil.h    |   1 -
 drivers/pci/controller/pci-aardvark.c              |  57 ++-
 drivers/pci/controller/pci-host-common.c           |   5 +-
 drivers/pci/controller/pci-host-common.h           |   2 +
 drivers/pci/controller/pci-mvebu.c                 |   6 +-
 drivers/pci/controller/pci-xgene-msi.c             | 426 ++++++++-------------
 drivers/pci/controller/pci-xgene.c                 |  33 +-
 drivers/pci/controller/pcie-altera-msi.c           |  43 +--
 drivers/pci/controller/pcie-altera.c               |   3 +-
 drivers/pci/controller/pcie-brcmstb.c              |  80 ++--
 drivers/pci/controller/pcie-iproc-msi.c            |  44 +--
 drivers/pci/controller/pcie-mediatek-gen3.c        |  64 ++--
 drivers/pci/controller/pcie-mediatek.c             |  48 ++-
 drivers/pci/controller/pcie-rcar-host.c            |  68 ++--
 drivers/pci/controller/pcie-rockchip-ep.c          |   4 +-
 drivers/pci/controller/pcie-rockchip-host.c        |  64 ++--
 drivers/pci/controller/pcie-rockchip.h             |  26 +-
 drivers/pci/controller/pcie-xilinx-dma-pl.c        |  47 +--
 drivers/pci/controller/pcie-xilinx-nwl.c           |  44 +--
 drivers/pci/controller/pcie-xilinx.c               |  54 +--
 drivers/pci/controller/plda/Kconfig                |   1 +
 drivers/pci/controller/plda/pcie-plda-host.c       |  43 +--
 drivers/pci/controller/plda/pcie-plda.h            |   1 -
 drivers/pci/controller/plda/pcie-starfive.c        |   2 +-
 drivers/pci/controller/vmd.c                       | 249 ++++++------
 drivers/pci/endpoint/Kconfig                       |   8 +
 drivers/pci/endpoint/Makefile                      |   1 +
 drivers/pci/endpoint/functions/pci-epf-test.c      | 130 +++++++
 drivers/pci/endpoint/functions/pci-epf-vntb.c      | 144 ++++++-
 drivers/pci/endpoint/pci-ep-cfs.c                  |   1 +
 drivers/pci/endpoint/pci-ep-msi.c                  | 100 +++++
 drivers/pci/endpoint/pci-epf-core.c                |  40 +-
 drivers/pci/hotplug/TODO                           |   4 -
 drivers/pci/hotplug/pciehp_hpc.c                   |   2 +-
 drivers/pci/iov.c                                  | 153 +++++++-
 drivers/pci/msi/msi.c                              |   2 +-
 drivers/pci/pci-acpi.c                             |   7 +-
 drivers/pci/pci-driver.c                           |   6 +-
 drivers/pci/pci.c                                  |  30 +-
 drivers/pci/pci.h                                  |  84 +++-
 drivers/pci/pcie/aer.c                             |   7 +-
 drivers/pci/pcie/aspm.c                            |  11 +-
 drivers/pci/pcie/portdrv.c                         |   2 +-
 drivers/pci/pcie/ptm.c                             |   2 +-
 drivers/pci/probe.c                                |  12 +-
 drivers/pci/quirks.c                               |   6 +-
 drivers/pci/setup-bus.c                            |   3 +-
 drivers/pci/setup-res.c                            |  35 +-
 drivers/vfio/pci/vfio_pci_igd.c                    |   3 +-
 include/linux/cpuhotplug.h                         |   1 -
 include/linux/hypervisor.h                         |   3 +
 include/linux/pci-ep-msi.h                         |  28 ++
 include/linux/pci-epf.h                            |  18 +
 include/linux/pci-pwrctrl.h                        |   2 +-
 include/linux/pci.h                                |  27 ++
 include/linux/pci_hotplug.h                        |   3 +-
 include/uapi/linux/pci_regs.h                      |   9 +
 include/uapi/linux/pcitest.h                       |   1 +
 kernel/irq/chip.c                                  |   8 +-
 sound/hda/hdac_i915.c                              |   2 +-
 sound/pci/hda/hda_intel.c                          |   4 +-
 .../selftests/pci_endpoint/pci_endpoint_test.c     |  28 ++
 104 files changed, 2996 insertions(+), 1375 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pci/83xx-512x-pci.txt
 delete mode 100644 Documentation/devicetree/bindings/pci/aardvark-pci.txt
 create mode 100644 Documentation/devicetree/bindings/pci/amazon,al-alpine-v3-pcie.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/apm,xgene-pcie.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/axis,artpec6-pcie.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/marvell,armada-3700-pcie.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/pcie-al.txt
 create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie-sa8255p.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/sophgo,sg2044-pcie.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/spear13xx-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/st,spear1340-pcie.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/xgene-pci.txt
 create mode 100644 drivers/pci/controller/dwc/pcie-sophgo.c
 create mode 100644 drivers/pci/endpoint/pci-ep-msi.c
 create mode 100644 include/linux/pci-ep-msi.h

