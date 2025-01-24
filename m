Return-Path: <linux-pci+bounces-20345-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C43A1BC87
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2025 19:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E7AB16A059
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2025 18:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276592248B4;
	Fri, 24 Jan 2025 18:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bCo0FsvA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F5D2248AE;
	Fri, 24 Jan 2025 18:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737745058; cv=none; b=aBYu5xVH2Xb0lWhMgbEZLecco5LnSsk5RbZBVO2opL8tIqOJm+gcdhjejVclxu1aC1M4ckgCjOvaHDJs+QrhHu2HOOMXMheg20So06lErulb6e41JXBVbktn4XEWUx38Di4q5Shc7j0lq94qpb7IPfbjxWnTtGKRpBHRotgN2jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737745058; c=relaxed/simple;
	bh=p623ErKB+eiegrQNPJvDPEtTb89Jz8yeLkbu5YF25pg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oAjbrJ5u2rYJQFAGKRkJyRhjueX54agG84NXK3pJCKm7zVOjrnhXMGh2SygOMXult88YCxaqer8ndxZmMjAwQi6dRSeMoynGTZctYPdxMgIKkwr1JQCVkexpy4T+wkPBmd1fyckOxyuM1OaskxcboNoeobquZZBtNY/czEtVfYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bCo0FsvA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10A40C4CED2;
	Fri, 24 Jan 2025 18:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737745057;
	bh=p623ErKB+eiegrQNPJvDPEtTb89Jz8yeLkbu5YF25pg=;
	h=Date:From:To:Cc:Subject:From;
	b=bCo0FsvAANfZGKtie7URsHLq2EnYGNCWNNp9DCpOpCfX0e3zuo+SI/3llUmU3MwJU
	 ORMbUPaien0gmdS2lO76quH2PyJexZD7CcosAdMxJAFbuMktBNsvP9t5Fz85lNzBjG
	 gOIXls0XyT9fRYoZSC/Vuy4O4McS/1tUxdpMcJTjIMxuIt6ole8o8ZI86Vp84fSCwn
	 c44E/BwE073jpwVy7OPZIq39QrlbIX1ZCejUYhvm78hGmf9ER5uEneef/hB1PI038O
	 Mrx8/UFTVdI7j/0hQneF5IZ0N5HtyfkwD4fAR5ATpUnQI0oNkcmydQvEwEau8bbIgJ
	 xwATRuxXdWnYw==
Date: Fri, 24 Jan 2025 12:57:34 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: [GIT PULL] PCI changes for v6.14
Message-ID: <20250124185734.GA1372974@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:

  Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.14-changes

for you to fetch changes up to 10ff5bbfd4b020e58fd8863e44ae59f0d4c337bf:

  Merge branch 'pci/misc' (2025-01-23 13:05:06 -0600)

----------------------------------------------------------------

Enumeration:

  - Batch sizing of multiple BARs while memory decoding is disabled instead
    of disabling/enabling decoding for each BAR individually; this
    optimizes virtualized environments where toggling decoding enable is
    expensive (Alex Williamson)

  - Add host bridge .enable_device() and .disable_device() hooks for
    bridges that need to configure things like Requester ID to StreamID
    mapping when enabling devices (Frank Li)

  - Extend struct pci_ecam_ops with .enable_device() and .disable_device()
    hooks so drivers that use pci_host_common_probe() instead of their own
    .probe() have a way to set the .enable_device() callbacks (Marc
    Zyngier)

  - Drop 'No bus range found' message so we don't complain when DTs don't
    specify the default 'bus-range = <0x00 0xff>' (Bjorn Helgaas)

  - Rename the drivers/pci/of_property.c struct of_pci_range to
    of_pci_range_entry to avoid confusion with the global of_pci_range in
    include/linux/of_address.h (Bjorn Helgaas)

Driver binding:

  - Update resource request API documentation to encourage callers to
    supply a driver name when requesting resources (Philipp Stanner)

  - Export pci_intx_unmanaged() and pcim_intx() (always managed) so callers
    of pci_intx() (which is sometimes managed) can explicitly choose the
    one they need (Philipp Stanner)

  - Convert drivers from pci_intx() to always-managed pcim_intx() or
    never-managed pci_intx_unmanaged(): amd_sfh, ata (ahci, ata_piix,
    pata_rdc, sata_sil24, sata_sis, sata_uli, sata_vsc), bnx2x, bna, ntb,
    qtnfmac, rtsx, tifm_7xx1, vfio, xen-pciback (Philipp Stanner)

  - Remove pci_intx_unmanaged() since pci_intx() is now always unmanaged
    and pcim_intx() is always managed (Philipp Stanner)

Error handling:

  - Unexport pcie_read_tlp_log() to encourage drivers to use PCI core
    logging rather than building their own (Ilpo Järvinen)

  - Move TLP Log handling to its own file (Ilpo Järvinen)

  - Store number of supported End-End TLP Prefixes always so we can read
    the correct number of DWORDs from the TLP Prefix Log (Ilpo Järvinen)

  - Read TLP Prefixes in addition to the Header Log in pcie_read_tlp_log()
    (Ilpo Järvinen)

  - Add pcie_print_tlp_log() to consolidate printing of TLP Header and
    Prefix Log (Ilpo Järvinen)

  - Quirk the Intel Raptor Lake-P PIO log size to accommodate vendor BIOSes
    that don't configure it correctly (Takashi Iwai)

ASPM:

  - Save parent L1 PM Substates config so when we restore it along with an
    endpoint's config, the parent info isn't junk (Jian-Hong Pan)

Power management:

  - Avoid D3 for Root Ports on TUXEDO Sirius Gen1 with old BIOS because the
    system can't wake up from suspend (Werner Sembach)

Endpoint framework:

  - Destroy the EPC device in devm_pci_epc_destroy(), which previously
    didn't call devres_release() (Zijun Hu)

  - Finish virtual EP removal in pci_epf_remove_vepf(), which previously
    caused a subsequent pci_epf_add_vepf() to fail with -EBUSY (Zijun Hu)

  - Write BAR_MASK before iATU registers in pci_epc_set_bar() so we don't
    depend on the BAR_MASK reset value being larger than the requested BAR
    size (Niklas Cassel)

  - Prevent changing BAR size/flags in pci_epc_set_bar() to prevent reads
    from bypassing the iATU if we reduced the BAR size (Niklas Cassel)

  - Verify address alignment when programming iATU so we don't attempt to
    write bits that are read-only because of the BAR size, which could lead
    to directing accesses to the wrong address (Niklas Cassel)

  - Implement artpec6 pci_epc_features so we can rely on all drivers
    supporting it so we can use it in EPC core code (Niklas Cassel)

  - Check for BARs of fixed size to prevent endpoint drivers from trying to
    change their size (Niklas Cassel)

  - Verify that requested BAR size is a power of two when endpoint driver
    sets the BAR (Niklas Cassel)

Endpoint framework tests:

  - Clear pci-epf-test dma_chan_rx, not dma_chan_tx, after freeing
    dma_chan_rx (Mohamed Khalfella)

  - Correct the DMA MEMCPY test so it doesn't fail if the Endpoint supports
    both DMA_PRIVATE and DMA_MEMCPY (Manivannan Sadhasivam)

  - Add pci-epf-test and pci_endpoint_test support for capabilities (Niklas
    Cassel)

  - Add Endpoint test for consecutive BARs (Niklas Cassel)

  - Remove redundant comparison from Endpoint BAR test because a > 1MB BAR
    can always be exactly covered by iterating with a 1MB buffer (Hans
    Zhang)

  - Move and convert PCI Endpoint tests from tools/pci to Kselftests
    (Manivannan Sadhasivam)

Apple PCIe controller driver:

  - Convert StreamID mapping configuration from a bus notifier to the
    .enable_device() and .disable_device() callbacks (Marc Zyngier)

Freescale i.MX6 PCIe controller driver:

  - Add Requester ID to StreamID mapping configuration when enabling
    devices (Frank Li)

  - Use DWC core suspend/resume functions for imx6 (Frank Li)

  - Add suspend/resume support for i.MX8MQ, i.MX8Q, and i.MX95 (Richard
    Zhu)

  - Add DT compatible string 'fsl,imx8q-pcie-ep' and driver support for
    i.MX8Q series (i.MX8QM, i.MX8QXP, and i.MX8DXL) Endpoints (Frank Li)

  - Add DT binding for optional i.MX95 Refclk and driver support to enable
    it if the platform hasn't enabled it (Richard Zhu)

  - Configure PHY based on controller being in Root Complex or Endpoint
    mode (Frank Li)

  - Rely on dbi2 and iATU base addresses from DT via
    dw_pcie_get_resources() instead of hardcoding them (Richard Zhu)

  - Deassert apps_reset in imx_pcie_deassert_core_reset() since it is
    asserted in imx_pcie_assert_core_reset() (Richard Zhu)

  - Add missing reference clock enable or disable logic for IMX6SX, IMX7D,
    IMX8MM (Richard Zhu)

  - Remove redundant imx7d_pcie_init_phy() since
    imx7d_pcie_enable_ref_clk() does the same thing (Richard Zhu)

Freescale Layerscape PCIe controller driver:

  - Simplify by using syscon_regmap_lookup_by_phandle_args() instead of
    syscon_regmap_lookup_by_phandle() followed by
    of_property_read_u32_array() (Krzysztof Kozlowski)

Marvell MVEBU PCIe controller driver:

  - Add MODULE_DEVICE_TABLE() to enable module autoloading (Liao Chen)

MediaTek PCIe Gen3 controller driver:

  - Use clk_bulk_prepare_enable() instead of separate clk_bulk_prepare()
    and clk_bulk_enable() (Lorenzo Bianconi)

  - Rearrange reset assert/deassert so they're both done in the
    *_power_up() callbacks (Lorenzo Bianconi)

  - Document that Airoha EN7581 requires PHY init and power-on before PHY
    reset deassert, unlike other MediaTek Gen3 controllers (Lorenzo
    Bianconi)

  - Move Airoha EN7581 post-reset delay from the en7581 clock .enable()
    method to mtk_pcie_en7581_power_up() (Lorenzo Bianconi)

  - Sleep instead of delay during Airoha EN7581 power-up, since this is a
    non-atomic context (Lorenzo Bianconi)

  - Skip PERST# assertion on Airoha EN7581 during probe and suspend/resume
    to avoid a hardware defect (Lorenzo Bianconi)

  - Enable async probe to reduce system startup time (Douglas Anderson)

Microchip PolarFlare PCIe controller driver:

  - Set up the inbound address translation based on whether the platform
    allows coherent or non-coherent DMA (Daire McNamara)

  - Update DT binding such that platforms are DMA-coherent by default and
    must specify 'dma-noncoherent' if needed (Conor Dooley) 

Mobiveil PCIe controller driver:

  - Convert mobiveil-pcie.txt to YAML and update 'interrupt-names' and
    'reg-names' (Frank Li)

Qualcomm PCIe controller driver:

  - Add DT SM8550 and SM8650 optional 'global' interrupt for link events
    (Neil Armstrong)

  - Add DT 'compatible' strings for IPQ5424 PCIe controller (Manikanta
    Mylavarapu)

  - If 'global' IRQ is supported for detection of Link Up events, tell DWC
    core not to wait for link up (Krishna chaitanya chundru)

Renesas R-Car PCIe controller driver:

  - Avoid passing stack buffer as resource name (King Dix)

Rockchip PCIe controller driver:

  - Simplify clock and reset handling by using bulk interfaces (Anand Moon)

  - Pass typed rockchip_pcie (not void) pointer to
    rockchip_pcie_disable_clocks() (Anand Moon)

  - Return -ENOMEM, not success, when pci_epc_mem_alloc_addr() fails (Dan
    Carpenter)

Rockchip DesignWare PCIe controller driver:

  - Use dll_link_up IRQ to detect Link Up and enumerate devices so users
    don't have to manually rescan (Niklas Cassel)

  - Tell DWC core not to wait for link up since the 'sys' interrupt is
    required and detects Link Up events (Niklas Cassel)

Synopsys DesignWare PCIe controller driver:

  - Don't wait for link up in DWC core if driver can detect Link Up event
    (Krishna chaitanya chundru)

  - Update ICC and OPP votes after Link Up events (Krishna chaitanya
    chundru)

  - Always stop link in dw_pcie_suspend_noirq(), which is required at least
    for i.MX8QM to re-establish link on resume (Richard Zhu)

  - Drop racy and unnecessary LTSSM state check before sending PME_TURN_OFF
    message in dw_pcie_suspend_noirq() (Richard Zhu)

  - Add struct of_pci_range.parent_bus_addr for devices that need their
    immediate parent bus address, not the CPU address, e.g., to program an
    internal Address Translation Unit (iATU) (Frank Li)

TI DRA7xx PCIe controller driver:

  - Simplify by using syscon_regmap_lookup_by_phandle_args() instead of
    syscon_regmap_lookup_by_phandle() followed by
    of_parse_phandle_with_fixed_args() or of_property_read_u32_index()
    (Krzysztof Kozlowski)

Xilinx Versal CPM PCIe controller driver:

  - Add DT binding and driver support for Xilinx Versal CPM5 (Thippeswamy
    Havalige)

MicroSemi Switchtec management driver:

  - Add Microchip PCI100X device IDs (Rakesh Babu Saladi)

Miscellaneous:

  - Move reset related sysfs code from pci.c to pci-sysfs.c where other
    similar code lives (Ilpo Järvinen)

  - Simplify reset_method_store() memory management by using __free()
    instead of explicit kfree() cleanup (Ilpo Järvinen)

  - Constify struct bin_attribute for sysfs, VPD, P2PDMA, and the IBM ACPI
    hotplug driver (Thomas Weißschuh)

  - Remove redundant PCI_VSEC_HDR and PCI_VSEC_HDR_LEN_SHIFT (Dongdong
    Zhang)

  - Correct documentation of the 'config_acs=' kernel parameter (Akihiko
    Odaki)

----------------------------------------------------------------
Akihiko Odaki (1):
      Documentation: Fix pci=config_acs= example

Alex Williamson (1):
      PCI: Batch BAR sizing operations

Anand Moon (3):
      PCI: rockchip: Simplify clock handling by using clk_bulk*() functions
      PCI: rockchip: Simplify reset control handling by using reset_control_bulk*() function
      PCI: rockchip: Refactor rockchip_pcie_disable_clocks() signature

Bjorn Helgaas (32):
      PCI: Unexport of_pci_parse_bus_range()
      PCI: of: Drop 'No bus range found' message
      PCI: of: Simplify devm_of_pci_get_host_bridge_resources() interface
      sparc/PCI: Update reference to devm_of_pci_get_host_bridge_resources()
      PCI: dwc: Add dw_pcie_suspend_noirq(), dw_pcie_resume_noirq() stubs for !CONFIG_PCIE_DW_HOST
      PCI: of_property: Rename struct of_pci_range to of_pci_range_entry
      PCI: imx6: Clean up comments and whitespace
      PCI: dwc: Simplify config resource lookup
      Merge branch 'pci/aspm'
      Merge branch 'pci/devres'
      Merge branch 'pci/dpc'
      Merge branch 'pci/enumeration'
      Merge branch 'pci/err'
      Merge branch 'pci/of'
      Merge branch 'pci/pci-sysfs'
      Merge branch 'pci/pm'
      Merge branch 'pci/switchtec'
      Merge branch 'pci/endpoint'
      Merge branch 'pci/endpoint-test'
      Merge branch 'pci/dt-bindings'
      Merge branch 'pci/controller/iommu-map'
      Merge branch 'pci/controller/dra7xx'
      Merge branch 'pci/controller/dwc'
      Merge branch 'pci/controller/imx6'
      Merge branch 'pci/controller/layerscape'
      Merge branch 'pci/controller/mediatek'
      Merge branch 'pci/controller/microchip'
      Merge branch 'pci/controller/mvebu'
      Merge branch 'pci/controller/rcar-ep'
      Merge branch 'pci/controller/rockchip'
      Merge branch 'pci/controller/xilinx-cpm'
      Merge branch 'pci/misc'

Conor Dooley (1):
      dt-bindings: PCI: microchip,pcie-host: Allow dma-noncoherent

Daire McNamara (1):
      PCI: microchip: Set inbound address translation for coherent or non-coherent mode

Damien Le Moal (1):
      PCI: rockchip: Add missing fields descriptions for struct rockchip_pcie_ep

Dan Carpenter (1):
      PCI: rockchip-ep: Fix error code in rockchip_pcie_ep_init_ob_mem()

Dongdong Zhang (1):
      PCI: Remove redundant PCI_VSEC_HDR and PCI_VSEC_HDR_LEN_SHIFT

Douglas Anderson (1):
      PCI: mediatek-gen3: Enable async probe by default

Frank Li (8):
      PCI: Add enable_device() and disable_device() callbacks for bridges
      PCI: imx6: Add IOMMU and ITS MSI support for i.MX95
      dt-bindings: PCI: fsl,imx6q-pcie-ep: Add compatible string fsl,imx8q-pcie-ep
      PCI: imx6: Add i.MX8Q PCIe Endpoint (EP) support
      PCI: imx6: Configure PHY based on Root Complex or Endpoint mode
      PCI: imx6: Use DWC common suspend resume method
      of: address: Add parent_bus_addr to struct of_pci_range
      dt-bindings: PCI: mobiveil: Convert mobiveil-pcie.txt to YAML

Hans Zhang (1):
      misc: pci_endpoint_test: Remove redundant 'remainder' test

Ilpo Järvinen (11):
      PCI: Don't expose pcie_read_tlp_log() outside PCI subsystem
      PCI: Move TLP Log handling to its own file
      PCI: Add defines for TLP Header/Prefix log sizes
      PCI: Use same names in pcie_read_tlp_log() prototype and definition
      PCI: Use unsigned int i in pcie_read_tlp_log()
      PCI: Store number of supported End-End TLP Prefixes
      PCI/sysfs: Move reset related sysfs code to correct file
      PCI/sysfs: Use __free() in reset_method_store()
      PCI/sysfs: Remove unnecessary zero in initializer
      PCI: Add TLP Prefix reading to pcie_read_tlp_log()
      PCI: Add pcie_print_tlp_log() to print TLP Header and Prefix Log

Jian-Hong Pan (1):
      PCI/ASPM: Save parent L1SS config in pci_save_aspm_l1ss_state()

King Dix (1):
      PCI: rcar-ep: Fix incorrect variable used when calling devm_request_mem_region()

Krishna chaitanya chundru (3):
      PCI: dwc: Don't wait for link up if driver can detect Link Up event
      PCI: qcom: Don't wait for link if we can detect Link Up
      PCI: qcom: Update ICC and OPP values after Link Up event

Krzysztof Kozlowski (2):
      PCI: layerscape: Use syscon_regmap_lookup_by_phandle_args
      PCI: dra7xx: Use syscon_regmap_lookup_by_phandle_args

Liao Chen (1):
      PCI: mvebu: Enable module autoloading

Lorenzo Bianconi (6):
      PCI: mediatek-gen3: Rely on clk_bulk_prepare_enable() in mtk_pcie_en7581_power_up()
      PCI: mediatek-gen3: Move reset/assert callbacks in .power_up()
      PCI: mediatek-gen3: Add comment about initialization order in mtk_pcie_en7581_power_up()
      PCI: mediatek-gen3: Move reset delay in mtk_pcie_en7581_power_up()
      PCI: mediatek-gen3: Rely on msleep() in mtk_pcie_en7581_power_up()
      PCI: mediatek-gen3: Avoid PCIe resetting via PERST# for Airoha EN7581 SoC

Lukas Wunner (1):
      PCI: Update code comment on PCI_EXP_LNKCAP_SLS for PCIe r3.0

Manikanta Mylavarapu (1):
      dt-bindings: PCI: qcom: Document the IPQ5424 PCIe controller

Manivannan Sadhasivam (4):
      PCI: endpoint: pci-epf-test: Fix check for DMA MEMCPY test
      misc: pci_endpoint_test: Fix IOCTL return value
      selftests: Move PCI Endpoint tests from tools/pci to Kselftests
      selftests: pci_endpoint: Migrate to Kselftest framework

Marc Zyngier (2):
      PCI: host-generic: Allow {en,dis}able_device() to be provided via pci_ecam_ops
      PCI: apple: Convert to {en,dis}able_device() callbacks

Mohamed Khalfella (1):
      PCI: endpoint: pci-epf-test: Set dma_chan_rx pointer to NULL on error

Neil Armstrong (1):
      dt-bindings: PCI: qcom,pcie-sm8550: Document 'global' interrupt

Niklas Cassel (12):
      PCI: dwc: ep: Write BAR_MASK before iATU registers in pci_epc_set_bar()
      PCI: dwc: ep: Prevent changing BAR size/flags in pci_epc_set_bar()
      PCI: dwc: ep: Add 'address' alignment to 'size' check in dw_pcie_prog_ep_inbound_atu()
      PCI: artpec6: Implement dw_pcie_ep operation get_features
      PCI: endpoint: Add size check for fixed size BARs in pci_epc_set_bar()
      PCI: endpoint: Verify that requested BAR size is a power of two
      PCI: dwc: Fix potential truncation in dw_pcie_edma_irq_verify()
      PCI: dw-rockchip: Enumerate endpoints based on dll_link_up IRQ
      PCI: dw-rockchip: Don't wait for link since we can detect Link Up
      PCI: endpoint: pci-epf-test: Add support for capabilities
      misc: pci_endpoint_test: Add support for capabilities
      misc: pci_endpoint_test: Add consecutive BAR test

Philipp Stanner (12):
      PCI: Encourage resource request API users to supply driver name
      PCI: Export pci_intx_unmanaged() and pcim_intx()
      drivers/xen: Use never-managed version of pci_intx()
      ntb: Use never-managed version of pci_intx()
      misc: Use never-managed version of pci_intx()
      vfio/pci: Use never-managed version of pci_intx()
      PCI/MSI: Use never-managed version of pci_intx()
      ata: Use always-managed version of pci_intx()
      wifi: qtnfmac: use always-managed version of pcim_intx()
      HID: amd_sfh: Use always-managed version of pcim_intx()
      net/ethernet: Use never-managed version of pci_intx()
      PCI: Remove devres from pci_intx()

Rakesh Babu Saladi (1):
      PCI: switchtec: Add Microchip PCI100X device IDs

Richard Zhu (10):
      dt-bindings: PCI: fsl,imx6q-pcie: Add Refclk for i.MX95 RC
      PCI: imx6: Add Refclk for i.MX95 PCIe
      PCI: imx6: Fetch dbi2 and iATU base addesses from DT
      PCI: imx6: Skip controller_id generation logic for i.MX7D
      PCI: imx6: Deassert apps_reset in imx_pcie_deassert_core_reset()
      PCI: imx6: Add missing reference clock disable logic
      PCI: imx6: Remove surplus imx7d_pcie_init_phy() function
      PCI: dwc: Always stop link in the dw_pcie_suspend_noirq
      PCI: dwc: Remove LTSSM state test in dw_pcie_suspend_noirq()
      PCI: imx6: Add i.MX8MQ, i.MX8Q and i.MX95 PM support

Rick Wertenbroek (1):
      PCI: endpoint: Replace magic number '6' by PCI_STD_NUM_BARS

Takashi Iwai (1):
      PCI/DPC: Quirk PIO log size for Intel Raptor Lake-P

Thippeswamy Havalige (2):
      dt-bindings: PCI: xilinx-cpm: Add compatible string for CPM5 host1
      PCI: xilinx-cpm: Add support for Versal CPM5 Root Port Controller 1

Thomas Weißschuh (4):
      PCI/sysfs: Constify 'struct bin_attribute'
      PCI/VPD: Constify 'struct bin_attribute'
      PCI/P2PDMA: Constify 'struct bin_attribute'
      PCI/ACPI: Constify 'struct bin_attribute'

Werner Sembach (1):
      PCI: Avoid putting some root ports into D3 on TUXEDO Sirius Gen1

Wolfram Sang (1):
      PCI: Don't include 'pm_wakeup.h' directly

Zijun Hu (3):
      PCI: endpoint: Destroy the EPC device in devm_pci_epc_destroy()
      PCI: endpoint: Simplify pci_epc_get()
      PCI: endpoint: Finish virtual EP removal in pci_epf_remove_vepf()

 Documentation/PCI/endpoint/pci-test-howto.rst      | 168 ++++----
 Documentation/admin-guide/kernel-parameters.txt    |   2 +-
 .../bindings/pci/fsl,imx6q-pcie-common.yaml        |   4 +-
 .../devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml |  39 +-
 .../devicetree/bindings/pci/fsl,imx6q-pcie.yaml    |  25 +-
 .../bindings/pci/layerscape-pcie-gen4.txt          |  52 ---
 .../devicetree/bindings/pci/mbvl,gpex40-pcie.yaml  | 173 ++++++++
 .../bindings/pci/microchip,pcie-host.yaml          |   2 +
 .../devicetree/bindings/pci/mobiveil-pcie.txt      |  72 ----
 .../devicetree/bindings/pci/qcom,pcie-sm8550.yaml  |   9 +-
 .../devicetree/bindings/pci/qcom,pcie.yaml         |   4 +
 .../devicetree/bindings/pci/xilinx-versal-cpm.yaml |   1 +
 MAINTAINERS                                        |   5 +-
 arch/sparc/kernel/pci_common.c                     |   2 +-
 arch/x86/pci/fixup.c                               |  30 ++
 drivers/ata/ahci.c                                 |   2 +-
 drivers/ata/ata_piix.c                             |   2 +-
 drivers/ata/pata_rdc.c                             |   2 +-
 drivers/ata/sata_sil24.c                           |   2 +-
 drivers/ata/sata_sis.c                             |   2 +-
 drivers/ata/sata_uli.c                             |   2 +-
 drivers/ata/sata_vsc.c                             |   2 +-
 drivers/clk/clk-en7523.c                           |   1 -
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c             |   4 +-
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c      |   2 +-
 drivers/misc/pci_endpoint_test.c                   | 354 ++++++++++------
 drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c |   2 +-
 drivers/of/address.c                               |   2 +
 drivers/pci/ats.c                                  |   2 +-
 drivers/pci/controller/dwc/pci-dra7xx.c            |  27 +-
 drivers/pci/controller/dwc/pci-imx6.c              | 449 +++++++++++++++------
 drivers/pci/controller/dwc/pci-layerscape.c        |  10 +-
 drivers/pci/controller/dwc/pcie-artpec6.c          |  13 +
 drivers/pci/controller/dwc/pcie-designware-ep.c    |  54 ++-
 drivers/pci/controller/dwc/pcie-designware-host.c  |  56 ++-
 drivers/pci/controller/dwc/pcie-designware.c       |   7 +-
 drivers/pci/controller/dwc/pcie-designware.h       |  19 +-
 drivers/pci/controller/dwc/pcie-dw-rockchip.c      |  69 +++-
 drivers/pci/controller/dwc/pcie-qcom.c             |   7 +-
 drivers/pci/controller/pci-host-common.c           |   2 +
 drivers/pci/controller/pci-mvebu.c                 |   1 +
 drivers/pci/controller/pcie-apple.c                |  75 +---
 drivers/pci/controller/pcie-mediatek-gen3.c        | 115 ++++--
 drivers/pci/controller/pcie-rcar-ep.c              |   2 +-
 drivers/pci/controller/pcie-rockchip-ep.c          |   5 +
 drivers/pci/controller/pcie-rockchip.c             | 219 ++--------
 drivers/pci/controller/pcie-rockchip.h             |  35 +-
 drivers/pci/controller/pcie-xilinx-cpm.c           |  50 ++-
 drivers/pci/controller/plda/pcie-microchip-host.c  |  96 +++++
 drivers/pci/controller/plda/pcie-plda-host.c       |  17 +-
 drivers/pci/controller/plda/pcie-plda.h            |   6 +-
 drivers/pci/devres.c                               |  40 +-
 drivers/pci/endpoint/functions/pci-epf-test.c      |  25 +-
 drivers/pci/endpoint/pci-epc-core.c                |  37 +-
 drivers/pci/endpoint/pci-epf-core.c                |   1 +
 drivers/pci/hotplug/acpiphp_ibm.c                  |   6 +-
 drivers/pci/iov.c                                  |   8 +-
 drivers/pci/of.c                                   |  22 +-
 drivers/pci/of_property.c                          |   4 +-
 drivers/pci/p2pdma.c                               |   6 +-
 drivers/pci/pci-sysfs.c                            | 150 ++++++-
 drivers/pci/pci.c                                  | 275 ++++---------
 drivers/pci/pci.h                                  |  23 +-
 drivers/pci/pcie/Makefile                          |   2 +-
 drivers/pci/pcie/aer.c                             |  15 +-
 drivers/pci/pcie/aspm.c                            |  35 +-
 drivers/pci/pcie/dpc.c                             |  22 +-
 drivers/pci/pcie/tlp.c                             | 115 ++++++
 drivers/pci/probe.c                                | 107 +++--
 drivers/pci/quirks.c                               |  18 +-
 drivers/pci/switch/switchtec.c                     |  26 ++
 drivers/pci/vpd.c                                  |  14 +-
 drivers/vfio/pci/vfio_pci_config.c                 |   5 +-
 include/linux/aer.h                                |  12 +-
 include/linux/of_address.h                         |   1 +
 include/linux/pci-ecam.h                           |   4 +
 include/linux/pci-epf.h                            |   4 +-
 include/linux/pci.h                                |   5 +-
 include/uapi/linux/pci_regs.h                      |  16 +-
 include/uapi/linux/pcitest.h                       |   1 +
 tools/pci/Build                                    |   1 -
 tools/pci/Makefile                                 |  58 ---
 tools/pci/pcitest.c                                | 250 ------------
 tools/pci/pcitest.sh                               |  72 ----
 tools/testing/selftests/Makefile                   |   1 +
 tools/testing/selftests/pci_endpoint/.gitignore    |   2 +
 tools/testing/selftests/pci_endpoint/Makefile      |   7 +
 tools/testing/selftests/pci_endpoint/config        |   4 +
 .../selftests/pci_endpoint/pci_endpoint_test.c     | 221 ++++++++++
 89 files changed, 2248 insertions(+), 1670 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pci/layerscape-pcie-gen4.txt
 create mode 100644 Documentation/devicetree/bindings/pci/mbvl,gpex40-pcie.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
 create mode 100644 drivers/pci/pcie/tlp.c
 delete mode 100644 tools/pci/Build
 delete mode 100644 tools/pci/Makefile
 delete mode 100644 tools/pci/pcitest.c
 delete mode 100644 tools/pci/pcitest.sh
 create mode 100644 tools/testing/selftests/pci_endpoint/.gitignore
 create mode 100644 tools/testing/selftests/pci_endpoint/Makefile
 create mode 100644 tools/testing/selftests/pci_endpoint/config
 create mode 100644 tools/testing/selftests/pci_endpoint/pci_endpoint_test.c

