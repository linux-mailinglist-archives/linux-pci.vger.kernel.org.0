Return-Path: <linux-pci+bounces-37618-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE78BBE979
	for <lists+linux-pci@lfdr.de>; Mon, 06 Oct 2025 18:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EA643B3F51
	for <lists+linux-pci@lfdr.de>; Mon,  6 Oct 2025 16:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A26723ABA1;
	Mon,  6 Oct 2025 16:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYRVzctv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BD41DF982;
	Mon,  6 Oct 2025 16:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759766960; cv=none; b=pZidLJbOndZDBUdz2DBNBRGKy9y8i73Ibk2D6T7w996zLz0KdR7o3CZbBidGlZTxf4qRKgXNxzS4EagWwSm+pYVMmaxePA2451rEq9x8Kkhp/sR02yqToq0xFcfI67JlPOwbtcIfPFG04hc/I351V32seVLRNWD8uTswOTlspPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759766960; c=relaxed/simple;
	bh=d4xsFcAGGgUrdtPPV0KDNkTO3F0J320061tG8Xpn9Dg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RfWdkjHP98bdh99bdbrezH6/cJ6/c/BppBYmY0+CDdihSA+ZVVDb1dkanIyvATMxcwi4Cc6JhmotyiDjoqVej5RGXYW+Yte4ddcXlmRj5iT5GHj0RoEXmsNhr0UC+4GtPFJlkGlWD0c9amNyRQ7KhzU/3YDX50hcz3Jh3stRueg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYRVzctv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 994AAC4CEF5;
	Mon,  6 Oct 2025 16:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759766959;
	bh=d4xsFcAGGgUrdtPPV0KDNkTO3F0J320061tG8Xpn9Dg=;
	h=Date:From:To:Cc:Subject:From;
	b=VYRVzctvh95AVHfJhwlA99hpa6dDKhxnBZPjwshl7YmjSSNZ+ZU9QN55OJrSYY5LC
	 DD/vp8C/0PpkV8O4DNO8o8JAqz8FY/oO9ffm1WibzO1w5lbG/aews3b42clNnzQgby
	 TDV9F8h0jB2eNUoXOEwadaN14diVaHQGIolm/g+0KpMjp66xBQEvycore2PvAND+rr
	 g7LtsRdPBJroIDxhjdbfJZl3AEALDnw1C7Jw67ERfBIT1n/AT9w1sT696au8h8T3z8
	 ipTgfQGvdWZy/8eHJ5f4d8CtkL/IfDWaXm9Mcv0JoRP6J9ztxqdTBRpSHsgOb6SgXy
	 7UAVg8fy1blcA==
Date: Mon, 6 Oct 2025 11:09:18 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: [GIT PULL] PCI changes for v6.18
Message-ID: <20251006160918.GA521548@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.18-changes

for you to fetch changes up to 51204faa4273a64b7066b5c1b5383e9b20d58caa:

  Merge branch 'pci/misc' (2025-10-03 12:13:25 -0500)

----------------------------------------------------------------

Enumeration:

  - Add PCI_FIND_NEXT_CAP() and PCI_FIND_NEXT_EXT_CAP() macros that take
    config space accessor functions; implement pci_find_capability(),
    pci_find_ext_capability(), and dwc, dwc endpoint, and cadence
    capability search interfaces with them (Hans Zhang)

  - Leave parent unit address 0 in 'interrupt-map' so that when we build
    devicetree nodes to describe PCI functions that contain multiple
    peripherals, we can build this property even when interrupt controllers
    lack 'reg' properties (Lorenzo Pieralisi)

  - Add a Xeon 6 quirk to disable Extended Tags and limit Max Read Request
    Size to 128B to avoid a performance issue (Ilpo Järvinen)

  - Add sysfs 'serial_number' file to expose the Device Serial Number
    (Matthew Wood)

  - Fix pci_acpi_preserve_config() memory leak (Nirmoy Das)

Resource management:

  - Align m68k pcibios_enable_device() with other arches (Ilpo Järvinen)

  - Remove sparc pcibios_enable_device() implementations that don't do
    anything beyond what pci_enable_resources() does (Ilpo Järvinen)

  - Remove mips pcibios_enable_resources() and use pci_enable_resources()
    instead (Ilpo Järvinen)

  - Clean up bridge window sizing and assignment (Ilpo Järvinen),
    including:

    - Leave non-claimed bridge windows disabled

    - Enable bridges even if a window wasn't assigned because not all
      windows are required by downstream devices

    - Preserve bridge window type when releasing the resource, since the
      type is needed for reassignment

    - Consolidate selection of bridge windows into two new interfaces,
      pbus_select_window() and pbus_select_window_for_type(), so this is
      done consistently

    - Compute bridge window start and end earlier to avoid logging stale
      information

MSI:

  - Add quirk to disable MSI on RDC PCI to PCIe bridges (Marcos Del Sol
    Vives)

Error handling:

  - Align AER with EEH by allowing drivers to request a Bus Reset on
    Non-Fatal Errors (in addition to the reset on Fatal Errors that we
    already do) (Lukas Wunner)

  - If error recovery fails, emit FAILED_RECOVERY uevents for the devices,
    not for the bridge leading to them; this makes them correspond to
    BEGIN_RECOVERY uevents (Lukas Wunner)

  - Align AER with EEH by calling err_handler.error_detected() callbacks to
    notify drivers if error recovery fails (Lukas Wunner)

  - Align AER with EEH by restoring device error_state to
    pci_channel_io_normal before the err_handler.slot_reset() callback;
    this is earlier than before the err_handler.resume() callback (Lukas
    Wunner)

  - Emit a BEGIN_RECOVERY uevent when driver's err_handler.error_detected()
    requests a reset, as well as when it says recovery is complete or can
    be done without a reset (Niklas Schnelle)

  - Align s390 with AER and EEH by emitting uevents during error recovery
    (Niklas Schnelle)

  - Align EEH with AER and s390 by emitting BEGIN_RECOVERY,
    SUCCESSFUL_RECOVERY, or FAILED_RECOVERY uevents depending on the result
    of err_handler.error_detected() (Niklas Schnelle)

  - Fix a NULL pointer dereference in aer_ratelimit() when ACPI GHES error
    information identifies a device without an AER Capability (Breno
    Leitao)

  - Update error decoding and TLP Log printing for new errors in current
    PCIe base spec (Lukas Wunner)

  - Update error recovery documentation to match the current code and use
    consistent nomenclature (Lukas Wunner)

ASPM:

  - Enable all ClockPM and ASPM states for devicetree platforms, since
    there's typically no firmware that enables ASPM

    This is a risky change that may uncover hardware or configuration
    defects at boot-time rather than when users enable ASPM via sysfs
    later.  Booting with "pcie_aspm=off" prevents this enabling
    (Manivannan Sadhasivam)

  - Remove the qcom code that enabled ASPM (Manivannan Sadhasivam)

Power management:

  - If a device has already been disconnected, e.g., by a hotplug removal,
    don't bother trying to resume it to D0 when detaching the driver; this
    avoids annoying "Unable to change power state from D3cold to D0"
    messages (Mario Limonciello)

  - Ensure devices are powered up before config reads for 'max_link_width',
    'current_link_speed', 'current_link_width', 'secondary_bus_number', and
    'subordinate_bus_number' sysfs files; this prevents using invalid data
    (~0) in drivers or lspci and, depending on how the PCIe controller
    reports errors, may avoid error interrupts or crashes (Brian Norris)

Virtualization:

  - Add rescan/remove locking when enabling/disabling SR-IOV, which avoids
    list corruption on s390, where disabling SR-IOV also generates hotplug
    events (Niklas Schnelle)

Peer-to-peer DMA:

  - Free struct p2p_pgmap, not a member within it, in the
    pci_p2pdma_add_resource() error path (Sungho Kim)

Endpoint framework:

  - Document sysfs interface for BAR assignment of vNTB endpoint functions
    (Jerome Brunet)

  - Fix array underflow in endpoint BAR test case (Dan Carpenter)

  - Skip endpoint IRQ test if the IRQ is out of range to avoid false errors
    (Christian Bruel)

  - Fix endpoint test case for controllers with fixed-size BARs smaller
    than requested by the test (Marek Vasut)

  - Restore inbound translation when disabling doorbell so the endpoint
    doorbell test case can be run more than once (Niklas Cassel)

  - Avoid a NULL pointer dereference when releasing DMA channels in
    endpoint DMA test case (Shin'ichiro Kawasaki)

  - Convert tegra194 interrupt number to MSI vector to fix endpoint
    Kselftest MSI_TEST test case (Niklas Cassel)

  - Reset tegra194 BARs when running in endpoint mode so the BAR tests
    don't overwrite the ATU settings in BAR4 (Niklas Cassel)

  - Handle errors in tegra194 BPMP transactions so we don't mistakenly skip
    future PERST# assertion (Vidya Sagar)

AMD MDB PCIe controller driver:

  - Update DT binding example to separate PERST# to a Root Port stanza to
    make multiple Root Ports possible in the future (Sai Krishna Musham)

  - Add driver support for PERST# being described in a Root Port stanza,
    falling back to the host bridge if not found there (Sai Krishna Musham)

Freescale i.MX6 PCIe controller driver:

  - Enable the 3.3V Vaux supply if available so devices can request wakeup
    with either Beacon or WAKE# (Richard Zhu)

MediaTek PCIe Gen3 controller driver:

  - Add optional sys clock ready time setting to avoid sys_clk_rdy signal
    glitching in MT6991 and MT8196 (AngeloGioacchino Del Regno)

  - Add DT binding and driver support for MT6991 and MT8196
    (AngeloGioacchino Del Regno)

NVIDIA Tegra PCIe controller driver:

  - When asserting PERST#, disable the controller instead of mistakenly
    disabling the PLL twice (Nagarjuna Kristam)

  - Convert struct tegra_msi mask_lock to raw spinlock to avoid a lock
    nesting error (Marek Vasut)

Qualcomm PCIe controller driver:

  - Select PCI Power Control Slot driver so slot voltage rails can be
    turned on/off if described in Root Port devicetree node (Qiang Yu)

  - Parse only PCI bridge child nodes in devicetree, skipping unrelated
    nodes such as OPP (Operating Performance Points), which caused probe
    failures (Krishna Chaitanya Chundru)

  - Add 8.0 GT/s and 32.0 GT/s equalization settings (Ziyue Zhang)

  - Consolidate Root Port 'phy' and 'reset' properties in struct
    qcom_pcie_port, regardless of whether we got them from the Root Port
    node or the host bridge node (Manivannan Sadhasivam)

  - Fetch and map the ELBI register space in the DWC core rather than in
    each driver individually (Krishna Chaitanya Chundru)

  - Enable ECAM mechanism in DWC core by setting up iATU with 'CFG Shift
    Feature' and use this in the qcom driver (Krishna Chaitanya Chundru)

  - Add SM8750 compatible to qcom,pcie-sm8550.yaml (Krishna Chaitanya
    Chundru)

  - Update qcom,pcie-x1e80100.yaml to allow fifth PCIe host on Qualcomm
    Glymur, which is compatible with X1E80100 but doesn't have the
    cnoc_sf_axi clock (Qiang Yu)

Renesas R-Car PCIe controller driver:

  - Fix a typo that prevented correct PHY initialization (Marek Vasut)

  - Add a missing 1ms delay after PWR reset assertion as required by the
    V4H manual (Marek Vasut)

  - Assure reset has completed before DBI access to avoid SError (Marek
    Vasut)

  - Fix inverted PHY initialization check, which sometimes led to timeouts
    and failure to start the controller (Marek Vasut)

  - Pass the correct IRQ domain to generic_handle_domain_irq() to fix a
    regression when converting to msi_create_parent_irq_domain() (Claudiu
    Beznea)

  - Drop the spinlock protecting the PMSR register; it's no longer required
    since pci_lock already serializes accesses (Marek Vasut)

  - Convert struct rcar_msi mask_lock to raw spinlock to avoid a lock
    nesting error (Marek Vasut)

SOPHGO PCIe controller driver:

  - Check for existence of struct cdns_pcie.ops before using it to allow
    Cadence drivers that don't need to supply ops (Chen Wang)

  - Add DT binding and driver for the SOPHGO SG2042 PCIe controller (Chen
    Wang)

STMicroelectronics STM32MP25 PCIe controller driver:

  - Update pinctrl documentation of initial states and use in runtime
    suspend/resume (Christian Bruel)

  - Add pinctrl_pm_select_init_state() for use by stm32 driver, which needs
    it during resume (Christian Bruel)

  - Add devicetree bindings and drivers for the STMicroelectronics
    STM32MP25 in host and endpoint modes (Christian Bruel)

Synopsys DesignWare PCIe controller driver:

  - Add support for x16 in devicetree 'num-lanes' property (Konrad Dybcio)

  - Verify that if DT specifies a single IRQ for all eDMA channels, it is
    named 'dma' (Niklas Cassel)

TI J721E PCIe driver:

  - Add MODULE_DEVICE_TABLE() so driver can be autoloaded (Siddharth
    Vadapalli)

  - Power controller off before configuring the glue layer so the
    controller latches the correct values on power-on (Siddharth Vadapalli)

TI Keystone PCIe controller driver:

  - Use devm_request_irq() so 'ks-pcie-error-irq' is freed when driver
    exits with error (Siddharth Vadapalli)

  - Add Peripheral Virtualization Unit (PVU), which restricts DMA from PCIe
    devices to specific regions of host memory, to the ti,am65 binding (Jan
    Kiszka)

Xilinx NWL PCIe controller driver:

  - Clear bootloader E_ECAM_CONTROL before merging in the new driver value
    to avoid writing invalid values (Jani Nurminen)

----------------------------------------------------------------
Alok Tiwari (2):
      PCI: tegra: Fix devm_kcalloc() argument order for port->phys allocation
      PCI: j721e: Fix incorrect error message in probe()

AngeloGioacchino Del Regno (3):
      PCI: mediatek-gen3: Implement sys clock ready time setting
      dt-bindings: PCI: mediatek-gen3: Add support for MT6991/MT8196
      PCI: mediatek-gen3: Add support for MediaTek MT8196 SoC

Bjorn Helgaas (33):
      Merge branch 'pci/aer'
      Merge branch 'pci/aspm'
      Merge branch 'pci/enumeration'
      Merge branch 'pci/hotplug'
      Merge branch 'pci/msi'
      Merge branch 'pci/of'
      Merge branch 'pci/p2pdma'
      Merge branch 'pci/pm'
      Merge branch 'pci/pwrctrl'
      Merge branch 'pci/resource'
      Merge branch 'pci/virtualization'
      Merge branch 'pci/switchtec'
      Merge branch 'pci/capability-search'
      Merge branch 'pci/dt-binding'
      Merge branch 'pci/endpoint'
      Merge branch 'pci/controller/amd-mdb'
      Merge branch 'pci/controller/dwc'
      Merge branch 'pci/controller/dwc-edma'
      Merge branch 'pci/controller/hv'
      Merge branch 'pci/controller/imx6'
      Merge branch 'pci/controller/j721e'
      Merge branch 'pci/controller/keystone'
      Merge branch 'pci/controller/mediatek-gen3'
      Merge branch 'pci/controller/plda'
      Merge branch 'pci/controller/qcom'
      Merge branch 'pci/controller/rcar-gen4'
      Merge branch 'pci/controller/rcar-host'
      Merge branch 'pci/controller/sophgo'
      Merge branch 'pci/controller/stm32'
      Merge branch 'pci/controller/tegra'
      Merge branch 'pci/controller/xgene'
      Merge branch 'pci/controller/xilinx-nwl'
      Merge branch 'pci/misc'

Breno Leitao (1):
      PCI/AER: Avoid NULL pointer dereference in aer_ratelimit()

Brian Norris (1):
      PCI/sysfs: Ensure devices are powered for config reads

Chen Wang (3):
      dt-bindings: pci: Add Sophgo SG2042 PCIe host
      PCI: cadence: Check for the existence of cdns_pcie::ops before using it
      PCI: sg2042: Add Sophgo SG2042 PCIe driver

Christian Bruel (10):
      misc: pci_endpoint_test: Skip IRQ tests if irq is out of range
      misc: pci_endpoint_test: Cleanup extra 0 initialization
      selftests: pci_endpoint: Skip IRQ test if IRQ is out of range.
      Documentation: pinctrl: Describe PM helper functions for standard states.
      pinctrl: Add pinctrl_pm_select_init_state helper function
      dt-bindings: PCI: Add STM32MP25 PCIe Root Complex bindings
      PCI: stm32: Add PCIe host support for STM32MP25
      dt-bindings: PCI: Add STM32MP25 PCIe Endpoint bindings
      PCI: stm32-ep: Add PCIe Endpoint support for STM32MP25
      MAINTAINERS: Add entry for ST STM32MP25 PCIe drivers

Claudiu Beznea (1):
      PCI: rcar-host: Pass proper IRQ domain to generic_handle_domain_irq()

Colin Ian King (1):
      PCI: hotplug: Clean up spaces in messages

Dan Carpenter (3):
      PCI: endpoint: pci-ep-msi: Fix NULL vs IS_ERR() check in pci_epf_write_msi_msg()
      PCI: xgene-msi: Return negative -EINVAL in xgene_msi_handler_setup()
      misc: pci_endpoint_test: Fix array underflow in pci_endpoint_test_ioctl()

Emilio Perez (1):
      Documentation: PCI: Fix typos

Erick Karanja (1):
      PCI: switchtec: Replace manual locks with guard

Geert Uytterhoeven (1):
      PCI/pwrctrl: Fix double cleanup on devm_add_action_or_reset() failure

Hans Zhang (7):
      PCI: Clean up __pci_find_next_cap_ttl() readability
      PCI: Refactor capability search into PCI_FIND_NEXT_CAP()
      PCI: Refactor extended capability search into PCI_FIND_NEXT_EXT_CAP()
      PCI: dwc: Implement capability search using PCI core APIs
      PCI: dwc: ep: Implement capability search using PCI core APIs
      PCI: cadence: Implement capability search using PCI core APIs
      PCI: cadence: Use cdns_pcie_find_*capability() to avoid hardcoding offsets

Ilpo Järvinen (33):
      PCI: Use header type defines in pci_setup_device()
      PCI: Clean up early_dump_pci_device()
      PCI: Clean up pci_scan_child_bus_extend() loop
      PCI: Add Extended Tag + MRRS quirk for Xeon 6
      PCI: Ensure relaxed tail alignment does not increase min_align
      PCI: Fix pdev_resources_assignable() disparity
      PCI: Fix failure detection during resource resize
      m68k/PCI: Use pci_enable_resources() in pcibios_enable_device()
      sparc/PCI: Remove pcibios_enable_device() as they do nothing extra
      MIPS: PCI: Use pci_enable_resources()
      PCI: Move find_bus_resource_of_type() earlier
      PCI: Refactor find_bus_resource_of_type() logic checks
      PCI: Always claim bridge window before its setup
      PCI: Disable non-claimed bridge window
      PCI: Use pci_release_resource() instead of release_resource()
      PCI: Enable bridge even if bridge window fails to assign
      PCI: Preserve bridge window resource type flags
      PCI: Add defines for bridge window indexing
      PCI: Add bridge window selection functions
      PCI: Fix finding bridge window in pci_reassign_bridge_resources()
      PCI: Warn if bridge window cannot be released when resizing BAR
      PCI: Use pbus_select_window() during BAR resize
      PCI: Use pbus_select_window_for_type() during IO window sizing
      PCI: Rename resource variable from r to res
      PCI: Use pbus_select_window() in space available checker
      PCI: Use pbus_select_window_for_type() during mem window sizing
      PCI: Refactor distributing available memory to use loops
      PCI: Refactor remove_dev_resources() to use pbus_select_window()
      PCI: Add pci_setup_one_bridge_window()
      PCI: Pass bridge window to pci_bus_release_bridge_resources()
      PCI: Alter misleading recursion to pci_bus_release_bridge_resources()
      PCI: Don't print stale information about resource
      PCI: Set up bridge resources earlier

Jan Kiszka (1):
      dt-bindings: PCI: ti,am65: Extend for use with PVU

Jani Nurminen (1):
      PCI: xilinx-nwl: Fix ECAM programming

Jerome Brunet (1):
      Documentation: PCI: endpoint: Document BAR assignment

Johan Hovold (3):
      PCI/pwrctrl: Fix device leak at registration
      PCI/pwrctrl: Fix device and OF node leak at bus scan
      PCI/pwrctrl: Fix device leak at device stop

Konrad Dybcio (1):
      PCI: dwc: Support 16-lane operation

Krishna Chaitanya Chundru (6):
      dt-bindings: PCI: qcom,pcie-sm8550: Add SM8750 compatible
      PCI: qcom: Restrict port parsing only to PCIe bridge child nodes
      PCI: dwc: Add support for ELBI resource mapping
      PCI: dwc: Prepare the driver for enabling ECAM mechanism using iATU 'CFG Shift Feature'
      PCI: qcom: Prepare for the DWC ECAM enablement
      PCI: dwc: Support ECAM mechanism by enabling iATU 'CFG Shift Feature'

Krzysztof Kozlowski (1):
      dt-bindings: PCI: Correct example indentation

Leon Romanovsky (1):
      PCI/P2PDMA: Reduce scope of pci_has_p2pmem()

Lorenzo Pieralisi (1):
      PCI: of: Update parent unit address generation in of_pci_prop_intr_map()

Lukas Wunner (11):
      PCI/AER: Allow drivers to opt in to Bus Reset on Non-Fatal Errors
      PCI/ERR: Fix uevent on failure to recover
      PCI/ERR: Notify drivers on failure to recover
      PCI/ERR: Update device error_state already after reset
      PCI/ERR: Remove remnants of .link_reset() callback
      PCI/AER: Support errors introduced by PCIe r6.0
      PCI/AER: Print TLP Log for errors introduced since PCIe r1.1
      Documentation: PCI: Sync AER doc with code
      Documentation: PCI: Sync error recovery doc with code
      Documentation: PCI: Amend error recovery doc with DPC/AER specifics
      Documentation: PCI: Tidy error recovery doc's PCIe nomenclature

Manivannan Sadhasivam (4):
      PCI: qcom: Move host bridge 'phy' and 'reset' pointers to struct qcom_pcie_port
      PCI/ASPM: Enable all ClockPM and ASPM states for devicetree platforms
      PCI: qcom: Remove custom ASPM enablement code
      PCI: tegra194: Rename 'root_bus' to 'root_port_bus' in tegra_pcie_downstream_dev_to_D0()

Marcos Del Sol Vives (1):
      PCI: Disable MSI on RDC PCI to PCIe bridges

Marek Vasut (8):
      PCI: rcar-gen4: Fix PHY initialization
      PCI: endpoint: pci-epf-test: Limit PCIe BAR size for fixed BARs
      PCI: rcar-host: Drop PMSR spinlock
      PCI: rcar-gen4: Add missing 1ms delay after PWR reset assertion
      PCI: rcar-gen4: Assure reset occurs before DBI access
      PCI: rcar-gen4: Fix inverted break condition in PHY initialization
      PCI: tegra: Convert struct tegra_msi mask_lock into raw spinlock
      PCI: rcar-host: Convert struct rcar_msi mask_lock into raw spinlock

Mario Limonciello (1):
      PCI/PM: Skip resuming to D0 if device is disconnected

Matthew Wood (1):
      PCI/sysfs: Expose PCI device serial number

Nagarjuna Kristam (1):
      PCI: tegra194: Fix duplicate PLL disable in pex_ep_event_pex_rst_assert()

Nam Cao (1):
      PCI: hv: Remove unused parameter of hv_msi_free()

Niklas Cassel (7):
      PCI: endpoint: Drop superfluous pci_epc_features initialization
      PCI: endpoint: pci-epf-test: Fix doorbell test support
      PCI: dwc: Verify the single eDMA IRQ in dw_pcie_edma_irq_verify()
      PCI: qcom-ep: Remove redundant edma.nr_irqs initialization
      PCI: tegra194: Fix broken tegra_pcie_ep_raise_msi_irq()
      PCI: tegra194: Set pci_epc_features::msi_capable to true
      PCI: tegra194: Reset BARs when running in PCIe endpoint mode

Niklas Schnelle (5):
      PCI/AER: Fix missing uevent on recovery when a reset is requested
      s390/pci: Use pci_uevent_ers() in PCI recovery
      powerpc/eeh: Use result of error_detected() in uevent
      PCI/IOV: Add PCI rescan-remove locking when enabling/disabling SR-IOV
      PCI: Add lockdep assertion in pci_stop_and_remove_bus_device()

Nirmoy Das (1):
      PCI/ACPI: Fix pci_acpi_preserve_config() memory leak

Qianfeng Rong (1):
      PCI: keystone: Use kcalloc() instead of kzalloc()

Qiang Yu (2):
      PCI: qcom: Select PCI Power Control Slot driver
      dt-bindings: PCI: qcom,pcie-x1e80100: Set clocks minItems for the fifth Glymur PCIe Controller

Richard Zhu (1):
      PCI: imx6: Enable the Vaux supply if available

Sai Krishna Musham (2):
      dt-bindings: PCI: amd-mdb: Add example usage of reset-gpios for PCIe RP PERST#
      PCI: amd-mdb: Add support for PCIe RP PERST# signal handling

Shin'ichiro Kawasaki (1):
      PCI: endpoint: pci-epf-test: Add NULL check for DMA channels before release

Siddharth Vadapalli (3):
      PCI: j721e: Fix module autoloading
      PCI: j721e: Fix programming sequence of "strap" settings
      PCI: keystone: Use devm_request_irq() to free "ks-pcie-error-irq" on exit

Sungho Kim (1):
      PCI/P2PDMA: Fix incorrect pointer usage in devm_kfree() call

Vernon Yang (1):
      PCI/AER: Fix NULL pointer access by aer_info

Vidya Sagar (1):
      PCI: tegra194: Handle errors in BPMP response

Xichao Zhao (1):
      PCI: plda: Remove dev_err_probe() when the errno is -ENOMEM

Ziyue Zhang (2):
      PCI: qcom: Add equalization settings for 8.0 GT/s and 32.0 GT/s
      PCI: qcom: Fix macro typo for CURSOR

 Documentation/ABI/testing/sysfs-bus-pci            |   9 +
 Documentation/PCI/endpoint/pci-vntb-howto.rst      |   9 +-
 Documentation/PCI/pci-error-recovery.rst           |  43 +-
 Documentation/PCI/pcieaer-howto.rst                |  83 +-
 .../bindings/pci/amd,versal2-mdb-host.yaml         |  24 +-
 .../bindings/pci/mediatek-pcie-gen3.yaml           |  35 +
 .../devicetree/bindings/pci/qcom,pcie-sa8255p.yaml |  74 +-
 .../devicetree/bindings/pci/qcom,pcie-sm8550.yaml  |   1 +
 .../bindings/pci/qcom,pcie-x1e80100.yaml           |   3 +-
 .../bindings/pci/sophgo,sg2042-pcie-host.yaml      |  64 ++
 .../bindings/pci/st,stm32-pcie-common.yaml         |  33 +
 .../devicetree/bindings/pci/st,stm32-pcie-ep.yaml  |  73 ++
 .../bindings/pci/st,stm32-pcie-host.yaml           | 112 +++
 .../devicetree/bindings/pci/ti,am65-pci-host.yaml  |  28 +-
 Documentation/driver-api/pin-control.rst           |  57 +-
 MAINTAINERS                                        |   7 +
 arch/m68k/kernel/pcibios.c                         |  39 +-
 arch/mips/pci/pci-legacy.c                         |  38 +-
 arch/powerpc/kernel/eeh_driver.c                   |   2 +-
 arch/s390/pci/pci_event.c                          |   3 +
 arch/sparc/kernel/leon_pci.c                       |  27 -
 arch/sparc/kernel/pci.c                            |  27 -
 arch/sparc/kernel/pcic.c                           |  27 -
 arch/x86/pci/fixup.c                               |  40 +
 drivers/misc/pci_endpoint_test.c                   |  16 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c    |   1 -
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c   |   2 -
 drivers/net/ethernet/sfc/efx_common.c              |   3 -
 drivers/net/ethernet/sfc/falcon/efx.c              |   3 -
 drivers/net/ethernet/sfc/siena/efx_common.c        |   3 -
 drivers/pci/bus.c                                  |  17 +-
 drivers/pci/controller/cadence/Kconfig             |  10 +
 drivers/pci/controller/cadence/Makefile            |   1 +
 drivers/pci/controller/cadence/pci-j721e.c         |  28 +-
 drivers/pci/controller/cadence/pcie-cadence-ep.c   |  40 +-
 drivers/pci/controller/cadence/pcie-cadence-host.c |   2 +-
 drivers/pci/controller/cadence/pcie-cadence.c      |  18 +-
 drivers/pci/controller/cadence/pcie-cadence.h      |  45 +-
 drivers/pci/controller/cadence/pcie-sg2042.c       | 134 ++++
 drivers/pci/controller/dwc/Kconfig                 |  26 +
 drivers/pci/controller/dwc/Makefile                |   2 +
 drivers/pci/controller/dwc/pci-dra7xx.c            |   1 -
 drivers/pci/controller/dwc/pci-exynos.c            |  62 +-
 drivers/pci/controller/dwc/pci-imx6.c              |   8 +-
 drivers/pci/controller/dwc/pci-keystone.c          |   9 +-
 drivers/pci/controller/dwc/pcie-al.c               |   1 +
 drivers/pci/controller/dwc/pcie-amd-mdb.c          |  52 +-
 drivers/pci/controller/dwc/pcie-artpec6.c          |   2 -
 drivers/pci/controller/dwc/pcie-designware-ep.c    |  31 +-
 drivers/pci/controller/dwc/pcie-designware-host.c  | 148 +++-
 drivers/pci/controller/dwc/pcie-designware-plat.c  |   1 -
 drivers/pci/controller/dwc/pcie-designware.c       |  94 +--
 drivers/pci/controller/dwc/pcie-designware.h       |  55 +-
 drivers/pci/controller/dwc/pcie-dw-rockchip.c      |   2 -
 drivers/pci/controller/dwc/pcie-keembay.c          |   1 -
 drivers/pci/controller/dwc/pcie-qcom-common.c      |  58 +-
 drivers/pci/controller/dwc/pcie-qcom-common.h      |   2 +-
 drivers/pci/controller/dwc/pcie-qcom-ep.c          |  23 +-
 drivers/pci/controller/dwc/pcie-qcom.c             | 211 ++---
 drivers/pci/controller/dwc/pcie-rcar-gen4.c        |  30 +-
 drivers/pci/controller/dwc/pcie-stm32-ep.c         | 364 +++++++++
 drivers/pci/controller/dwc/pcie-stm32.c            | 358 +++++++++
 drivers/pci/controller/dwc/pcie-stm32.h            |  16 +
 drivers/pci/controller/dwc/pcie-tegra194.c         |  51 +-
 drivers/pci/controller/pci-hyperv.c                |   8 +-
 drivers/pci/controller/pci-tegra.c                 |  29 +-
 drivers/pci/controller/pci-xgene-msi.c             |   2 +-
 drivers/pci/controller/pcie-mediatek-gen3.c        |  23 +
 drivers/pci/controller/pcie-rcar-ep.c              |   2 -
 drivers/pci/controller/pcie-rcar-host.c            |  42 +-
 drivers/pci/controller/pcie-rockchip-ep.c          |   1 -
 drivers/pci/controller/pcie-xilinx-nwl.c           |   7 +-
 drivers/pci/controller/plda/pcie-plda-host.c       |   3 +-
 drivers/pci/endpoint/functions/pci-epf-test.c      |  38 +-
 drivers/pci/endpoint/pci-ep-msi.c                  |   2 +-
 drivers/pci/hotplug/cpqphp_pci.c                   |   8 +-
 drivers/pci/hotplug/ibmphp_hpc.c                   |   6 +-
 drivers/pci/iov.c                                  |   5 +
 drivers/pci/of_property.c                          |  22 +-
 drivers/pci/p2pdma.c                               |   5 +-
 drivers/pci/pci-acpi.c                             |   6 +-
 drivers/pci/pci-driver.c                           |   3 +-
 drivers/pci/pci-sysfs.c                            |  68 +-
 drivers/pci/pci.c                                  |  81 +-
 drivers/pci/pci.h                                  |  96 ++-
 drivers/pci/pcie/aer.c                             |  49 +-
 drivers/pci/pcie/aspm.c                            |  45 +-
 drivers/pci/pcie/err.c                             |  40 +-
 drivers/pci/probe.c                                |  88 ++-
 drivers/pci/pwrctrl/slot.c                         |  12 +-
 drivers/pci/quirks.c                               |   1 +
 drivers/pci/remove.c                               |   3 +
 drivers/pci/setup-bus.c                            | 855 +++++++++++----------
 drivers/pci/setup-res.c                            |  46 +-
 drivers/pci/switch/switchtec.c                     |  23 +-
 drivers/pinctrl/core.c                             |  13 +
 drivers/scsi/lpfc/lpfc_init.c                      |   2 +-
 drivers/scsi/qla2xxx/qla_os.c                      |   5 -
 include/linux/pci-p2pdma.h                         |   5 -
 include/linux/pci.h                                |   7 +-
 include/linux/pinctrl/consumer.h                   |  10 +
 include/uapi/linux/pci_regs.h                      |  10 +
 .../selftests/pci_endpoint/pci_endpoint_test.c     |   4 +
 103 files changed, 3166 insertions(+), 1298 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/sophgo,sg2042-pcie-host.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/st,stm32-pcie-common.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/st,stm32-pcie-ep.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/st,stm32-pcie-host.yaml
 create mode 100644 drivers/pci/controller/cadence/pcie-sg2042.c
 create mode 100644 drivers/pci/controller/dwc/pcie-stm32-ep.c
 create mode 100644 drivers/pci/controller/dwc/pcie-stm32.c
 create mode 100644 drivers/pci/controller/dwc/pcie-stm32.h

