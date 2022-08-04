Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20011589FD2
	for <lists+linux-pci@lfdr.de>; Thu,  4 Aug 2022 19:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbiHDRZN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Aug 2022 13:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbiHDRZM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Aug 2022 13:25:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E5E28711;
        Thu,  4 Aug 2022 10:25:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2CF4DB82614;
        Thu,  4 Aug 2022 17:25:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7044FC433D6;
        Thu,  4 Aug 2022 17:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659633906;
        bh=EBIAYg3O7qleVnKNfxduFdRXlUnGq3ZO0MKwb7+Lmfk=;
        h=Date:From:To:Cc:Subject:From;
        b=qJgG7vj5sSDnplfsaP5kqMv3vc6Ec6OP5di4ejvBLPPSVRICAbPu1yD13V8g1CF/K
         10S4wg/ba6T4XHUKx+/VER8iO/ICanaAhEO264dy1PAFF3e1qK7RyGyXxxPPGaO8hU
         NSLhUY3eaqZMS08Wp0aJ50ZAKxmyTjixOaAQccrpahe0Ku84HgoOM/qkbVDGgfY5YA
         etaADea90g60paPa4IxgPxuwNkP3uwUfHJ11EVmjap4+NVojrY+dZyclfpPtWtKLHc
         Yw1G+qsrEQj0p4NuKldQ8bUVEdzgDqxENPDN+aYHtPEsXlXlRwvs6apTopyVaUBJTf
         BRtJu8aHjEQSw==
Date:   Thu, 4 Aug 2022 12:25:04 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>
Subject: [GIT PULL] PCI changes for v5.20
Message-ID: <20220804172504.GA943002@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.20-changes

for you to fetch changes up to c4f36c3ab065065a87d641ca2fd5d5c4eb2bfa82:

  Merge branch 'pci/header-cleanup-immutable' (2022-08-04 11:46:53 -0500)

----------------------------------------------------------------

Enumeration:
  - Consolidate duplicated "next function" scanning and extend to allow
    "isolated functions" on s390, similar to existing hypervisors (Niklas
    Schnelle)

Resource management:
  - Implement pci_iobar_pfn() for sparc, which allows us to remove the
    sparc-specific pci_mmap_page_range() and pci_mmap_resource_range().
    This removes the ability to map the entire PCI I/O space using
    /proc/bus/pci, but we believe that's already been broken since v2.6.28
    (Arnd Bergmann)
  - Move common PCI definitions to asm-generic/pci.h and rework others to
    be be more specific and more encapsulated in arches that need them
    (Stafford Horne)

Power management:
  - Convert drivers to new *_PM_OPS macros to avoid need for "#ifdef
    CONFIG_PM_SLEEP" or "__maybe_unused" (Bjorn Helgaas)

Virtualization:
  - Add ACS quirk for Broadcom BCM5750x multifunction NICs that isolate the
    functions but don't advertise an ACS capability (Pavan Chebbi)

Error handling:
  - Clear PCI Status register during enumeration in case firmware left
    errors logged (Kai-Heng Feng)
  - When we have native control of AER, enable error reporting for all
    devices that support AER.  Previously only a few drivers enabled this
    (Stefan Roese)
  - Keep AER error reporting enabled for switches.  Previously we enabled
    this during enumeration but immediately disabled it (Stefan Roese)
  - Iterate over error counters instead of error strings to avoid printing
    junk in AER sysfs counters (Mohamed Khalfella)

ASPM:
  - Remove pcie_aspm_pm_state_change() so ASPM config changes, e.g., via
    sysfs, are not lost across power state changes (Kai-Heng Feng)

Endpoint framework:
  - Don't stop an EPC when unbinding an EPF from it (Shunsuke Mie)

Endpoint embedded DMA controller driver:
  - Simplify and clean up support for the DesignWare embedded DMA (eDMA)
    controller (Frank Li, Serge Semin)

Broadcom STB PCIe controller driver:
  - Avoid config space accesses when link is down because we can't recover
    from the CPU aborts these cause (Jim Quinlan)
  - Look for power regulators described under Root Ports in DT and enable
    them before scanning the secondary bus (Jim Quinlan)
  - Disable/enable regulators in suspend/resume (Jim Quinlan)

Freescale i.MX6 PCIe controller driver:
  - Simplify and clean up clock and PHY management (Richard Zhu)
  - Disable/enable regulators in suspend/resume (Richard Zhu)
  - Set PCIE_DBI_RO_WR_EN before writing DBI registers (Richard Zhu)
  - Allow speeds faster than Gen2 (Richard Zhu)
  - Make link being down a non-fatal error so controller probe doesn't fail
    if there are no Endpoints connected (Richard Zhu)

Loongson PCIe controller driver:
  - Add ACPI and MCFG support for Loongson LS7A (Huacai Chen)
  - Avoid config reads to non-existent LS2K/LS7A devices because a hardware
    defect causes machine hangs (Huacai Chen)
  - Work around LS7A integrated devices that report incorrect Interrupt Pin
    values (Jianmin Lv)

Marvell Aardvark PCIe controller driver:
  - Add support for AER and Slot capability on emulated bridge (Pali Rohár)

MediaTek PCIe controller driver:
  - Add Airoha EN7532 to DT binding (John Crispin)
  - Allow building of driver for ARCH_AIROHA (Felix Fietkau)

MediaTek PCIe Gen3 controller driver:
  - Print decoded LTSSM state when the link doesn't come up (Jianjun Wang)

NVIDIA Tegra194 PCIe controller driver:
  - Convert DT binding to json-schema (Vidya Sagar)
  - Add DT bindings and driver support for Tegra234 Root Port and Endpoint
    mode (Vidya Sagar)
  - Fix some Root Port interrupt handling issues (Vidya Sagar)
  - Set default Max Payload Size to 256 bytes (Vidya Sagar)
  - Fix Data Link Feature capability programming (Vidya Sagar)
  - Extend Endpoint mode support to devices beyond Controller-5 (Vidya
    Sagar)

Qualcomm PCIe controller driver:
  - Rework clock, reset, PHY power-on ordering to avoid hangs and improve
    consistency (Robert Marko, Christian Marangi)
  - Move pipe_clk handling to PHY drivers (Dmitry Baryshkov)
  - Add IPQ60xx support (Selvam Sathappan Periakaruppan)
  - Allow ASPM L1 and substates for 2.7.0 (Krishna chaitanya chundru)
  - Add support for more than 32 MSI interrupts (Dmitry Baryshkov)

Renesas R-Car PCIe controller driver:
  - Convert DT binding to json-schema (Herve Codina)
  - Add Renesas RZ/N1D (R9A06G032) to rcar-gen2 DT binding and driver
    (Herve Codina)

Samsung Exynos PCIe controller driver:
  - Fix phy-exynos-pcie driver so it follows the "phy_init() before
    phy_power_on()" PHY programming model (Marek Szyprowski)

Synopsys DesignWare PCIe controller driver:
  - Simplify and clean up the DWC core extensively (Serge Semin)
  - Fix an issue with programming the ATU for regions that cross a 4GB
    boundary (Serge Semin)
  - Enable the CDM check if "snps,enable-cdm-check" exists; previously we
    skipped it if "num-lanes" was absent (Serge Semin)
  - Allocate a 32-bit DMA-able page to be MSI target instead of using a
    driver data structure that may not be addressable with 32-bit address
    (Will McVicker)
  - Add DWC core support for more than 32 MSI interrupts (Dmitry Baryshkov)

Xilinx Versal CPM PCIe controller driver:
  - Add DT binding and driver support for Versal CPM5 Gen5 Root Port
    (Bharat Kumar Gogada)

----------------------------------------------------------------
Arnd Bergmann (2):
      PCI: Remove pci_mmap_page_range() wrapper
      sparc: Use generic pci_mmap_resource_range()

Baruch Siach (3):
      PCI: dwc: Move GEN3_RELATED DBI definitions to common header
      PCI: qcom: Define slot capabilities using PCI_EXP_SLTCAP_*
      dt-bindings: PCI: qcom: Fix description typo

Bharat Kumar Gogada (3):
      dt-bindings: PCI: xilinx-cpm: Add Versal CPM5 Root Port
      PCI: xilinx-cpm: Add support for Versal CPM5 Root Port
      MAINTAINERS: Add Xilinx Versal CPM Root Port maintainers

Bjorn Helgaas (39):
      PCI: Drop of_match_ptr() to avoid unused variables
      PCI/doc: Convert examples to generic power management
      PCI/ASPM: Unexport pcie_aspm_support_enabled()
      PCI: fu740: Remove unnecessary include files
      PCI: Convert to new *_PM_OPS macros
      PCI: imx6: Convert to NOIRQ_SYSTEM_SLEEP_PM_OPS()
      PCI: imx6: Move imx6_pcie_grp_offset(), imx6_pcie_configure_type() earlier
      PCI: imx6: Move PHY management functions together
      PCI: imx6: Move imx6_pcie_enable_ref_clk() earlier
      PCI: imx6: Factor out ref clock disable to match enable
      PCI: imx6: Disable clocks in reverse order of enable
      Merge branch 'pci/aspm'
      Merge branch 'pci/endpoint'
      Merge branch 'pci/enumeration'
      Merge branch 'pci/err'
      Merge branch 'pci/pm'
      Merge branch 'pci/resource'
      Merge branch 'pci/virtualization'
      Merge branch 'pci/ctrl/aardvark'
      Merge branch 'pci/ctrl/brcmstb'
      Merge branch 'pci/ctrl/dwc'
      Merge branch 'pci/ctrl/dwc-edma'
      Merge branch 'pci/ctrl/exynos'
      Merge branch 'pci/ctrl/fu740'
      Merge branch 'pci/ctrl/imx6'
      Merge branch 'pci/ctrl/iproc'
      Merge branch 'pci/ctrl/loongson'
      Merge branch 'pci/ctrl/mediatek'
      Merge branch 'pci/ctrl/mediatek-gen3'
      Merge branch 'pci/ctrl/microchip'
      Merge branch 'pci/ctrl/qcom'
      Merge branch 'pci/ctrl/rcar-gen2'
      Merge branch 'pci/ctrl/switchtec'
      Merge branch 'pci/ctrl/tegra194'
      Merge branch 'pci/ctrl/vmd'
      Merge branch 'pci/ctrl/xilinx-cpm'
      Merge branch 'pci/ctrl/pm-ops'
      Merge branch 'pci/misc'
      Merge branch 'pci/header-cleanup-immutable'

Christian Marangi (1):
      PCI: qcom: Set up rev 2.1.0 PARF_PHY before enabling clocks

Christoph Hellwig (1):
      PCI/ERR: Recognize disconnected devices in report_error_detected()

Christophe JAILLET (2):
      PCI: iproc: Use bitmap API to allocate bitmaps
      PCI: dwc: Use the bitmap API to allocate bitmaps

Dmitry Baryshkov (10):
      clk: qcom: regmap: add PHY clock source implementation
      clk: qcom: gcc-sm8450: use new clk_regmap_phy_mux_ops for PCIe pipe clocks
      clk: qcom: gcc-sc7280: use new clk_regmap_phy_mux_ops for PCIe pipe clocks
      PCI: qcom: Remove unnecessary pipe_clk handling
      PCI: qcom: Drop manual pipe_clk_src handling
      PCI: dwc: Correct msi_irq condition in dw_pcie_free_msi()
      PCI: dwc: Split MSI IRQ parsing/allocation to a separate function
      PCI: dwc: Convert struct pcie_port.msi_irq to an array
      PCI: dwc: Handle MSIs routed to multiple GIC interrupts
      dt-bindings: PCI: qcom: Support additional MSI vectors

Felix Fietkau (1):
      PCI: mediatek: Allow building for ARCH_AIROHA

Francisco Munoz (1):
      PCI: vmd: Add DID 8086:7D0B and 8086:AD0B for Intel MTL SKUs

Frank Li (6):
      dmaengine: dw-edma: Remove unused irq field in struct dw_edma_chip
      dmaengine: dw-edma: Detach the private data and chip info structures
      dmaengine: dw-edma: Change rg_region to reg_base in struct dw_edma_chip
      dmaengine: dw-edma: Rename wr(rd)_ch_cnt to ll_wr(rd)_cnt in struct dw_edma_chip
      dmaengine: dw-edma: Add support for chip-specific flags
      PCI: endpoint: Enable DMA tests for endpoints with DMA capabilities

Herve Codina (3):
      dt-bindings: PCI: pci-rcar-gen2: Convert bindings to json-schema
      dt-bindings: PCI: renesas,pci-rcar-gen2: Add device tree support for R9A06G032
      PCI: rcar-gen2: Add RZ/N1 SOC family compatible string

Huacai Chen (4):
      PCI/ACPI: Guard ARM64-specific mcfg_quirks
      PCI: loongson: Use generic 8/16/32-bit config ops on LS2K/LS7A
      PCI: loongson: Add ACPI init support
      PCI: loongson: Don't access non-existent devices

Jianjun Wang (1):
      PCI: mediatek-gen3: Print LTSSM state when PCIe link down

Jianmin Lv (1):
      PCI: loongson: Work around LS7A incorrect Interrupt Pin registers

Jim Quinlan (6):
      PCI: brcmstb: Remove unnecessary forward declarations
      PCI: brcmstb: Prevent config space access when link is down
      PCI: brcmstb: Split post-link up initialization to brcm_pcie_start_link()
      PCI: brcmstb: Enable child bus device regulators from DT
      PCI: brcmstb: Disable/enable regulators in suspend/resume
      PCI: brcmstb: Rename .map_bus() functions to end with 'map_bus'

Johan Hovold (1):
      dt-bindings: PCI: qcom: Fix reset conditional

John Crispin (1):
      dt-bindings: PCI: mediatek: Add Airoha EN7532 support

Kai-Heng Feng (2):
      PCI: Clear PCI_STATUS when setting up device
      PCI/ASPM: Remove pcie_aspm_pm_state_change()

Ke Liu (1):
      PCI: switchtec: Prefer ida_alloc()/free() over ida_simple_get()/remove()

Krishna chaitanya chundru (1):
      PCI: qcom: Allow ASPM L1 and substates for 2.7.0

Marek Szyprowski (2):
      phy: samsung: phy-exynos-pcie: sanitize init/power_on callbacks
      PCI: exynos: Correct generic PHY usage

Mario Limonciello (1):
      PCI/ACPI: Update link to PCI firmware specification

Miaoqian Lin (3):
      PCI: microchip: Fix refcount leak in mc_pcie_init_irq_domains()
      PCI: tegra194: Fix PM error handling in tegra_pcie_config_ep()
      PCI: mediatek-gen3: Fix refcount leak in mtk_pcie_init_irq_domains()

Mohamed Khalfella (1):
      PCI/AER: Iterate over error counters instead of error strings

Niklas Schnelle (5):
      PCI: Clean up pci_scan_slot()
      PCI: Split out next_ari_fn() from next_fn()
      PCI: Move jailhouse's isolated function handling to pci_scan_slot()
      PCI: Extend isolated function probing to s390
      s390/pci: allow zPCI zbus without a function zero

Pali Rohár (2):
      PCI: aardvark: Add support for AER registers on emulated bridge
      PCI: aardvark: Fix reporting Slot capabilities on emulated bridge

Pavan Chebbi (1):
      PCI: Add ACS quirk for Broadcom BCM5750x NICs

Randy Dunlap (1):
      x86/cyrix: include header linux/isa-dma.h

Richard Zhu (14):
      PCI: imx6: Move imx6_pcie_clk_disable() earlier
      PCI: imx6: Collect clock enables in imx6_pcie_clk_enable()
      PCI: imx6: Propagate .host_init() errors to caller
      PCI: imx6: Disable i.MX6QDL clock when disabling ref clocks
      PCI: imx6: Call host init function directly in resume
      PCI: imx6: Turn off regulator when system is in suspend mode
      PCI: imx6: Move regulator enable out of imx6_pcie_deassert_core_reset()
      PCI: imx6: Mark the link down as non-fatal error
      PCI: imx6: Reduce resume time by only starting link if it was up before suspend
      PCI: imx6: Do not hide PHY driver callbacks and refine the error handling
      PCI: imx6: Move the imx6_pcie_ltssm_disable() earlier
      PCI: imx6: Reformat suspend callback to keep symmetric with resume
      PCI: imx6: Set PCIE_DBI_RO_WR_EN before writing DBI registers
      PCI: imx6: Support more than Gen2 speed link mode

Robert Marko (2):
      PCI: qcom: Power on PHY before IPQ8074 DBI register accesses
      PCI: qcom: Power on PHY before DBI register accesses

Selvam Sathappan Periakaruppan (1):
      PCI: qcom: Add IPQ60xx support

Serge Semin (34):
      dmaengine: dw-edma: Drop dma_slave_config.direction field usage
      dmaengine: dw-edma: Fix eDMA Rd/Wr-channels and DMA-direction semantics
      PCI: dwc: Stop link on host_init errors and de-initialization
      PCI: dwc: Add unroll iATU space support to dw_pcie_disable_atu()
      PCI: dwc: Disable outbound windows only for controllers using iATU
      PCI: dwc: Set INCREASE_REGION_SIZE flag based on limit address
      PCI: dwc: Deallocate EPC memory on dw_pcie_ep_init() errors
      PCI: dwc: Always enable CDM check if "snps,enable-cdm-check" exists
      PCI: dwc: Add braces to multi-line if-else statements
      PCI: dwc: Add newlines to log messages
      PCI: dwc: Simplify unrolled iATU detection
      PCI: dwc: Convert dw_pcie_link_up() to use dw_pcie_readl_dbi()
      PCI: dwc: Organize local variable usage
      PCI: dwc: Reuse local pointer to the resource data
      PCI: dwc: Add start_link/stop_link inlines
      PCI: dwc: Move io_cfg_atu_shared to struct pcie_port
      PCI: dwc: Rename struct pcie_port to dw_pcie_rp
      PCI: dwc-plat: Simplify dw_plat_pcie_probe() return values
      PCI: dwc-plat: Drop unused regmap pointer
      PCI: dwc-plat: Drop dw_plat_pcie_of_match[] forward declaration
      PCI: dwc: Log link speed and width if it comes up
      PCI: dwc: Detect iATU settings after getting "addr_space" resource
      PCI: dwc: Use native DWC IP core version representation
      PCI: dwc: Read DWC IP core version from register
      PCI: dwc: Add macros to compare Synopsys IP core versions
      PCI: intel-gw: Drop manual DW PCIe controller version setup
      PCI: tegra194: Drop manual DW PCIe controller version setup
      PCI: dwc: Add dw_pcie_ops.host_deinit() callback
      PCI: dwc: Drop enum dw_pcie_as_type in favor of PCIE_ATU_TYPE_MEM/IO
      PCI: dwc: Drop enum dw_pcie_region_type in favor of PCIE_ATU_REGION_DIR_IB/OB
      PCI: dwc: Simplify in/outbound iATU setup methods
      PCI: dwc: Add iATU regions size detection procedure
      PCI: dwc: Validate iATU outbound mappings against hardware constraints
      PCI: dwc: Check iATU in/outbound range setup status

Shunsuke Mie (1):
      PCI: endpoint: Don't stop controller when unbinding endpoint function

Stafford Horne (5):
      PCI: Remove pci_get_legacy_ide_irq() and asm-generic/pci.h
      PCI: Move isa_dma_bridge_buggy out of asm/dma.h
      csky: PCI: Define ARCH_GENERIC_PCI_MMAP_RESOURCE
      asm-generic: Add new pci.h and use it
      PCI: Stub __pci_ioport_map() for arches that don't support it at all

Stefan Roese (3):
      PCI/AER: Configure ECRC for every device
      PCI/portdrv: Don't disable AER reporting in get_port_device_capability()
      PCI/AER: Enable error reporting when AER is native

Subramanian Mohan (1):
      PCI: vmd: Use devm_kasprintf() instead of simple kasprintf()

Vidya Sagar (13):
      dt-bindings: PCI: tegra194: Convert to json-schema
      dt-bindings: PCI: tegra234: Add schema for tegra234 Root Port mode
      dt-bindings: PCI: tegra234: Add schema for tegra234 Endpoint mode
      PCI: Disable MSI for Tegra234 Root Ports
      Revert "PCI: tegra194: Rename tegra_pcie_dw to tegra194_pcie"
      PCI: tegra194: Find RAS DES PCIe capability offset
      PCI: tegra194: Fix Root Port interrupt handling
      PCI: tegra194: Clear bandwidth management status
      PCI: tegra194: Enable support for 256 Byte payload
      PCI: tegra194: Clean up the exit path for Endpoint mode
      PCI: tegra194: Fix link up retry sequence
      PCI: tegra194: Extend Endpoint mode support
      PCI: tegra194: Add Tegra234 PCIe support

Will McVicker (1):
      PCI: dwc: Fix MSI msi_msg DMA mapping

 Documentation/PCI/pci-iov-howto.rst                |   7 +-
 Documentation/PCI/sysfs-pci.rst                    |   2 +-
 .../devicetree/bindings/pci/mediatek-pcie.txt      |   1 +
 .../bindings/pci/nvidia,tegra194-pcie-ep.yaml      | 319 ++++++++++
 .../bindings/pci/nvidia,tegra194-pcie.txt          | 245 --------
 .../bindings/pci/nvidia,tegra194-pcie.yaml         | 350 +++++++++++
 .../devicetree/bindings/pci/pci-rcar-gen2.txt      |  84 ---
 .../devicetree/bindings/pci/qcom,pcie.yaml         |  55 +-
 .../bindings/pci/renesas,pci-rcar-gen2.yaml        | 186 ++++++
 .../devicetree/bindings/pci/snps,dw-pcie.yaml      |   4 +-
 .../devicetree/bindings/pci/xilinx-versal-cpm.yaml |  38 +-
 MAINTAINERS                                        |   8 +
 arch/alpha/include/asm/dma.h                       |   9 -
 arch/alpha/include/asm/pci.h                       |   6 -
 arch/arc/include/asm/dma.h                         |   5 -
 arch/arm/include/asm/dma.h                         |   6 -
 arch/arm/include/asm/pci.h                         |   5 -
 arch/arm64/include/asm/pci.h                       |  18 +-
 arch/csky/include/asm/pci.h                        |  23 +-
 arch/ia64/include/asm/dma.h                        |   2 -
 arch/ia64/include/asm/pci.h                        |   6 -
 arch/m68k/include/asm/dma.h                        |   6 -
 arch/m68k/include/asm/pci.h                        |   2 -
 arch/microblaze/include/asm/dma.h                  |   6 -
 arch/mips/include/asm/dma.h                        |   8 -
 arch/mips/include/asm/pci.h                        |   6 -
 arch/parisc/include/asm/dma.h                      |   6 -
 arch/parisc/include/asm/pci.h                      |   5 -
 arch/powerpc/include/asm/dma.h                     |   6 -
 arch/powerpc/include/asm/pci.h                     |   1 -
 arch/riscv/include/asm/pci.h                       |  31 +-
 arch/s390/include/asm/dma.h                        |   6 -
 arch/s390/include/asm/pci.h                        |   1 -
 arch/s390/pci/pci_bus.c                            |  82 +--
 arch/sh/include/asm/dma.h                          |   6 -
 arch/sh/include/asm/pci.h                          |   6 -
 arch/sparc/include/asm/dma.h                       |   8 -
 arch/sparc/include/asm/pci.h                       |  10 +-
 arch/sparc/kernel/pci.c                            | 149 +----
 arch/um/include/asm/pci.h                          |  24 +-
 arch/x86/include/asm/dma.h                         |   8 -
 arch/x86/include/asm/pci.h                         |   3 -
 arch/x86/kernel/cpu/cyrix.c                        |   1 +
 arch/xtensa/include/asm/dma.h                      |   7 -
 arch/xtensa/include/asm/pci.h                      |   3 -
 drivers/acpi/pci_mcfg.c                            |  13 +
 drivers/clk/qcom/Makefile                          |   1 +
 drivers/clk/qcom/clk-regmap-phy-mux.c              |  62 ++
 drivers/clk/qcom/clk-regmap-phy-mux.h              |  33 +
 drivers/clk/qcom/gcc-sc7280.c                      |  49 +-
 drivers/clk/qcom/gcc-sm8450.c                      |  49 +-
 drivers/comedi/drivers/comedi_isadma.c             |   2 +-
 drivers/dma/dw-edma/dw-edma-core.c                 | 141 +++--
 drivers/dma/dw-edma/dw-edma-core.h                 |  31 +-
 drivers/dma/dw-edma/dw-edma-pcie.c                 |  83 +--
 drivers/dma/dw-edma/dw-edma-v0-core.c              |  41 +-
 drivers/dma/dw-edma/dw-edma-v0-core.h              |   4 +-
 drivers/dma/dw-edma/dw-edma-v0-debugfs.c           |  18 +-
 drivers/dma/dw-edma/dw-edma-v0-debugfs.h           |   8 +-
 drivers/pci/controller/Kconfig                     |   4 +-
 drivers/pci/controller/cadence/pcie-cadence.c      |   6 +-
 drivers/pci/controller/dwc/pci-dra7xx.c            |  22 +-
 drivers/pci/controller/dwc/pci-exynos.c            |  19 +-
 drivers/pci/controller/dwc/pci-imx6.c              | 676 ++++++++++----------
 drivers/pci/controller/dwc/pci-keystone.c          |  34 +-
 drivers/pci/controller/dwc/pci-layerscape-ep.c     |  12 -
 drivers/pci/controller/dwc/pci-layerscape.c        |   2 +-
 drivers/pci/controller/dwc/pci-meson.c             |   2 +-
 drivers/pci/controller/dwc/pcie-al.c               |   6 +-
 drivers/pci/controller/dwc/pcie-armada8k.c         |   6 +-
 drivers/pci/controller/dwc/pcie-artpec6.c          |   4 +-
 drivers/pci/controller/dwc/pcie-designware-ep.c    |  82 +--
 drivers/pci/controller/dwc/pcie-designware-host.c  | 404 ++++++++----
 drivers/pci/controller/dwc/pcie-designware-plat.c  |  25 +-
 drivers/pci/controller/dwc/pcie-designware.c       | 502 +++++++--------
 drivers/pci/controller/dwc/pcie-designware.h       | 178 ++++--
 drivers/pci/controller/dwc/pcie-dw-rockchip.c      |   4 +-
 drivers/pci/controller/dwc/pcie-fu740.c            |   4 +-
 drivers/pci/controller/dwc/pcie-histb.c            |  10 +-
 drivers/pci/controller/dwc/pcie-intel-gw.c         |  36 +-
 drivers/pci/controller/dwc/pcie-keembay.c          |   6 +-
 drivers/pci/controller/dwc/pcie-kirin.c            |   2 +-
 drivers/pci/controller/dwc/pcie-qcom.c             | 459 ++++++++------
 drivers/pci/controller/dwc/pcie-spear13xx.c        |  10 +-
 drivers/pci/controller/dwc/pcie-tegra194-acpi.c    |   7 +-
 drivers/pci/controller/dwc/pcie-tegra194.c         | 684 +++++++++++++--------
 drivers/pci/controller/dwc/pcie-uniphier.c         |  10 +-
 drivers/pci/controller/dwc/pcie-visconti.c         |   6 +-
 drivers/pci/controller/pci-aardvark.c              | 112 +++-
 drivers/pci/controller/pci-loongson.c              | 206 +++++--
 drivers/pci/controller/pci-mvebu.c                 |   4 +-
 drivers/pci/controller/pci-rcar-gen2.c             |   1 +
 drivers/pci/controller/pci-tegra.c                 |   9 +-
 drivers/pci/controller/pci-xgene.c                 |   2 +-
 drivers/pci/controller/pcie-brcmstb.c              | 443 ++++++++-----
 drivers/pci/controller/pcie-iproc-msi.c            |   4 +-
 drivers/pci/controller/pcie-mediatek-gen3.c        |  62 +-
 drivers/pci/controller/pcie-mediatek.c             |   8 +-
 drivers/pci/controller/pcie-microchip-host.c       |   2 +
 drivers/pci/controller/pcie-rcar-host.c            |   4 +-
 drivers/pci/controller/pcie-rockchip-host.c        |   8 +-
 drivers/pci/controller/pcie-xilinx-cpm.c           |  60 +-
 drivers/pci/controller/vmd.c                       |  13 +-
 drivers/pci/endpoint/functions/pci-epf-test.c      | 117 +++-
 drivers/pci/mmap.c                                 |  44 --
 drivers/pci/pci-acpi.c                             |   5 +-
 drivers/pci/pci.c                                  |   8 +-
 drivers/pci/pci.h                                  |   2 -
 drivers/pci/pcie/aer.c                             |  15 +-
 drivers/pci/pcie/aspm.c                            |  20 -
 drivers/pci/pcie/err.c                             |  12 +-
 drivers/pci/pcie/portdrv_core.c                    |   9 +-
 drivers/pci/probe.c                                |  90 ++-
 drivers/pci/proc.c                                 |   7 +-
 drivers/pci/quirks.c                               |  24 +-
 drivers/pci/switch/switchtec.c                     |   7 +-
 drivers/phy/samsung/phy-exynos-pcie.c              |  25 +-
 drivers/pnp/resource.c                             |   5 +-
 include/asm-generic/pci.h                          |  41 +-
 include/asm-generic/pci_iomap.h                    |   2 +
 include/linux/dma/edma.h                           |  61 +-
 include/linux/hypervisor.h                         |   8 +
 include/linux/isa-dma.h                            |  14 +
 include/linux/pci-ecam.h                           |   1 +
 include/linux/pci.h                                |  12 +-
 sound/core/isadma.c                                |   2 +-
 126 files changed, 4166 insertions(+), 2830 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
 create mode 100644 Documentation/devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml
 create mode 100644 drivers/clk/qcom/clk-regmap-phy-mux.c
 create mode 100644 drivers/clk/qcom/clk-regmap-phy-mux.h
 create mode 100644 include/linux/isa-dma.h
