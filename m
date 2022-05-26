Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D786535615
	for <lists+linux-pci@lfdr.de>; Fri, 27 May 2022 00:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243146AbiEZWd0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 May 2022 18:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiEZWdZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 May 2022 18:33:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F34C48E61;
        Thu, 26 May 2022 15:33:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1ED361C2E;
        Thu, 26 May 2022 22:33:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55E34C385B8;
        Thu, 26 May 2022 22:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653604402;
        bh=uhUhd/1+WmiNDYpxV8OU2WYboVDxpMoRjlq3tWYatkw=;
        h=Date:From:To:Cc:Subject:From;
        b=BKFsscl0j2/F+qfDjz+vlzsZ/sya7ucvYzS/P7uLl3W9vbVZtIbAGSWkaqaO3aVl6
         s759km1ySzERtPfVuGusyRx8H0zsrBp+gv/tUzLDbBzKsgNLC4jyb4gYI41jvPx90e
         t9v2b3VZmOe6QTqbo4rsCZMqWySW4HGBojgEAPFSUOW3rfl6Y8sxtX6ssyn97pcY5k
         ksYc0t7HAyYBBx3rTZAUO0W7AMurRZzaonAGBBao/Gggg+epVZgG8tbeMTmPkyG/5V
         VvwVPLU9e+z14jLh5AL+LHBGfxyf+DwHU2eJzDF2aweEtp9tLp7h4kxO2loaz6r3Fk
         SaHlgBwpchsBg==
Date:   Thu, 26 May 2022 17:33:20 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>
Subject: [GIT PULL] PCI changes for v5.19
Message-ID: <20220526223320.GA419755@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.19-changes

for you to fetch changes up to 32f479d05a445b52cb7fcbe6e06f579fb852be71:

  Merge branch 'remotes/lorenzo/pci/vmd' (2022-05-24 16:42:28 -0500)

----------------------------------------------------------------

Resource management:
  - Restrict E820 clipping to PCI host bridge windows (Bjorn Helgaas)
  - Log E820 clipping better (Bjorn Helgaas)
  - Add kernel cmdline options to enable/disable E820 clipping (Hans de
    Goede)
  - Disable E820 reserved region clipping for IdeaPads, Yoga, Yoga Slip,
    Acer Spin 5, Clevo Barebone systems where clipping leaves no usable
    address space for touchpads, Thunderbolt devices, etc (Hans de Goede)
  - Disable E820 clipping by default starting in 2023 (Hans de Goede)

PCI device hotplug:
  - Include files to remove implicit dependencies (Christophe Leroy)
  - Only put Root Ports in D3 if they can signal and wake from D3 so AMD
    Yellow Carp doesn't miss hotplug events (Mario Limonciello)

Power management:
  - Define pci_restore_standard_config() only for CONFIG_PM_SLEEP since
    it's unused otherwise (Krzysztof Kozlowski)
  - Power up devices completely, including anything platform firmware needs
    to do, during runtime resume (Rafael J. Wysocki)
  - Move pci_resume_bus() to PM callbacks so we observe the required bridge
    power-up delays (Rafael J. Wysocki)
  - Drop unneeded runtime_d3cold device flag (Rafael J. Wysocki)
  - Split pci_raw_set_power_state() between pci_power_up() and a new
    pci_set_low_power_state() (Rafael J. Wysocki)
  - Set current_state to D3cold if config read returns ~0, indicating the
    device is not accessible (Rafael J. Wysocki)
  - Do not call pci_update_current_state() from pci_power_up() so BARs and
    ASPM config are restored correctly (Rafael J. Wysocki)
  - Write 0 to PMCSR in pci_power_up() in all cases (Rafael J. Wysocki)
  - Split pci_power_up() to pci_set_full_power_state() to avoid some
    redundant operations (Rafael J. Wysocki)
  - Skip restoring BARs if device is not in D0 (Rafael J. Wysocki)
  - Rearrange and clarify pci_set_power_state() (Rafael J. Wysocki)
  - Remove redundant BAR restores from pci_pm_thaw_noirq() (Rafael J.
    Wysocki)

Virtualization:
  - Acquire device lock before config space access lock to avoid
    AB/BA deadlock with sriov_numvfs_store() (Yicong Yang)

Error handling:
  - Clear MULTI_ERR_COR/UNCOR_RCV bits, which a race could previously leave
    permanently set (Kuppuswamy Sathyanarayanan)

Peer-to-peer DMA:
  - Whitelist Intel Skylake-E Root Ports regardless of which devfn they are
    (Shlomo Pongratz)

ASPM:
  - Override L1 acceptable latency advertised by Intel DG2 so ASPM L1 can
    be enabled (Mika Westerberg)

Cadence PCIe controller driver:
  - Set up device-specific register to allow PTM Responder to be enabled by
    the normal architected bit (Christian Gmeiner)
  - Override advertised FLR support since the controller doesn't implement
    FLR correctly (Parshuram Thombare)

Cadence PCIe endpoint driver:
  - Correct bitmap size for the ob_region_map of outbound window usage (Dan
    Carpenter)

Freescale i.MX6 PCIe controller driver:
  - Fix PERST# assertion/deassertion so we observe the required delays
    before accessing device (Francesco Dolcini)

Freescale Layerscape PCIe controller driver:
  - Add "big-endian" DT property (Hou Zhiqiang)
  - Update SCFG DT property (Hou Zhiqiang)
  - Add "aer", "pme", "intr" DT properties (Li Yang)
  - Add DT compatible strings for ls1028a (Xiaowei Bao)

Intel VMD host bridge driver:
  - Assign VMD IRQ domain before enumeration to avoid IOMMU interrupt
    remapping errors when MSI-X remapping is disabled (Nirmal Patel)
  - Revert VMD workaround that kept MSI-X remapping enabled when IOMMU
    remapping was enabled (Nirmal Patel)

Marvell MVEBU PCIe controller driver:
  - Add of_pci_get_slot_power_limit() to parse the
    'slot-power-limit-milliwatt' DT property (Pali Rohár)
  - Add mvebu support for sending Set_Slot_Power_Limit message (Pali Rohár)

MediaTek PCIe controller driver:
  - Fix refcount leak in mtk_pcie_subsys_powerup() (Miaoqian Lin)

MediaTek PCIe Gen3 controller driver:
  - Reset PHY and MAC at probe time (AngeloGioacchino Del Regno)

Microchip PolarFlare PCIe controller driver:
  - Add chained_irq_enter()/chained_irq_exit() calls to mc_handle_msi() and
    mc_handle_intx() to avoid lost interrupts (Conor Dooley)
  - Fix interrupt handling race (Daire McNamara)

NVIDIA Tegra194 PCIe controller driver:
  - Drop tegra194 MSI register save/restore, which is unnecessary since the
    DWC core does it (Jisheng Zhang)

Qualcomm PCIe controller driver:
  - Add SM8150 SoC DT binding and support (Bhupesh Sharma)
  - Fix pipe clock imbalance (Johan Hovold)
  - Fix runtime PM imbalance on probe errors (Johan Hovold)
  - Fix PHY init imbalance on probe errors (Johan Hovold)
  - Convert DT binding to YAML (Dmitry Baryshkov)
  - Update DT binding to show that resets aren't required for
    MSM8996/APQ8096 platforms (Dmitry Baryshkov)
  - Add explicit register names per chipset in DT binding (Dmitry
    Baryshkov)
  - Add sc7280-specific clock and reset definitions to DT binding (Dmitry
    Baryshkov)

Rockchip PCIe controller driver:
  - Fix bitmap size when searching for free outbound region (Dan Carpenter)

Rockchip DesignWare PCIe controller driver:
  - Remove "snps,dw-pcie" from rockchip-dwc DT "compatible" property
    because it's not fully compatible with rockchip (Peter Geis)
  - Reset rockchip-dwc controller at probe (Peter Geis)
  - Add rockchip-dwc INTx support (Peter Geis)

Synopsys DesignWare PCIe controller driver:
  - Return error instead of success if DMA mapping of MSI area fails
    (Jiantao Zhang)

Miscellaneous:
  - Change pci_set_dma_mask() documentation references to dma_set_mask()
    (Alex Williamson)

----------------------------------------------------------------
Alex Williamson (1):
      PCI/doc: Update obsolete pci_set_dma_mask() references

AngeloGioacchino Del Regno (1):
      PCI: mediatek-gen3: Assert resets to ensure expected init state

Bhupesh Sharma (2):
      dt-bindings: pci: qcom: Document PCIe bindings for SM8150 SoC
      PCI: qcom: Add SM8150 SoC support

Bjorn Helgaas (22):
      x86/PCI: Eliminate remove_e820_regions() common subexpressions
      x86: Log resource clipping for E820 regions
      x86/PCI: Clip only host bridge windows for E820 regions
      Merge branch 'pci/aspm'
      Merge branch 'pci/error'
      Merge branch 'pci/hotplug'
      Merge branch 'pci/misc'
      Merge branch 'pci/p2pdma'
      Merge branch 'pci/pm'
      Merge branch 'pci/resource'
      Merge branch 'pci/virtualization'
      Merge branch 'remotes/lorenzo/pci/cadence'
      Merge branch 'remotes/lorenzo/pci/dwc'
      Merge branch 'remotes/lorenzo/pci/imx6'
      Merge branch 'remotes/lorenzo/pci/layerscape'
      Merge branch 'remotes/lorenzo/pci/mediatek'
      Merge branch 'remotes/lorenzo/pci/microchip'
      Merge branch 'remotes/lorenzo/pci/power-slot'
      Merge branch 'pci/host/qcom'
      Merge branch 'remotes/lorenzo/pci/rockchip'
      Merge branch 'remotes/lorenzo/pci/versatile'
      Merge branch 'remotes/lorenzo/pci/vmd'

Christian Gmeiner (1):
      PCI: cadence: Allow PTM Responder to be enabled

Christophe Leroy (1):
      PCI: hotplug: Clean up include files

Colin Ian King (1):
      PCI: versatile: Remove redundant variable retval

Conor Dooley (1):
      PCI: microchip: Add missing chained_irq_enter()/exit() calls

Daire McNamara (1):
      PCI: microchip: Fix potential race in interrupt handling

Dan Carpenter (2):
      PCI: cadence: Fix find_first_zero_bit() limit
      PCI: rockchip: Fix find_first_zero_bit() limit

Dmitry Baryshkov (5):
      PCI: qcom-ep: Move enable/disable resources code to common functions
      dt-bindings: PCI: qcom: Convert to YAML
      dt-bindings: PCI: qcom: Do not require resets on msm8996 platforms
      dt-bindings: PCI: qcom: Specify reg-names explicitly
      dt-bindings: PCI: qcom: Add schema for sc7280 chipset

Francesco Dolcini (1):
      PCI: imx6: Fix PERST# start-up sequence

Hans de Goede (3):
      x86/PCI: Add kernel cmdline options to use/ignore E820 reserved regions
      x86/PCI: Disable E820 reserved region clipping via quirks
      x86/PCI: Disable E820 reserved region clipping starting in 2023

Hou Zhiqiang (2):
      dt-bindings: pci: layerscape-pci: Add a optional property big-endian
      dt-bindings: pci: layerscape-pci: Update the description of SCFG property

Jiantao Zhang (1):
      PCI: dwc: Fix setting error return on MSI DMA mapping failure

Jisheng Zhang (1):
      PCI: tegra194: Remove unnecessary MSI enable reg save and restore

Johan Hovold (3):
      PCI: qcom: Fix pipe clock imbalance
      PCI: qcom: Fix runtime PM imbalance on probe errors
      PCI: qcom: Fix unbalanced PHY init on probe errors

Krzysztof Kozlowski (1):
      PCI/PM: Define pci_restore_standard_config() only for CONFIG_PM_SLEEP

Kuppuswamy Sathyanarayanan (1):
      PCI/AER: Clear MULTI_ERR_COR/UNCOR_RCV bits

Li Yang (1):
      dt-bindings: pci: layerscape-pci: define AER/PME interrupts

Mario Limonciello (1):
      PCI/ACPI: Allow D3 only if Root Port can signal and wake from D3

Miaoqian Lin (1):
      PCI: mediatek: Fix refcount leak in mtk_pcie_subsys_powerup()

Mika Westerberg (1):
      PCI/ASPM: Make Intel DG2 L1 acceptable latency unlimited

Nirmal Patel (2):
      PCI: vmd: Assign VMD IRQ domain before enumeration
      PCI: vmd: Revert 2565e5b69c44 ("PCI: vmd: Do not disable MSI-X remapping if interrupt remapping is enabled by IOMMU.")

Pali Rohár (3):
      PCI: Add PCI_EXP_SLTCTL_ASPL_DISABLE macro
      PCI: Add function for parsing 'slot-power-limit-milliwatt' DT property
      PCI: mvebu: Add support for sending Set_Slot_Power_Limit message

Parshuram Thombare (1):
      PCI: cadence: Clear FLR in device capabilities register

Peter Geis (3):
      dt-bindings: PCI: Remove fallback from Rockchip DesignWare binding
      PCI: rockchip-dwc: Reset core at driver probe
      PCI: rockchip-dwc: Add legacy interrupt support

Rafael J. Wysocki (15):
      PCI/PM: Power up all devices during runtime resume
      PCI/PM: Resume subordinate bus in bus type callbacks
      PCI/PM: Drop the runtime_d3cold device flag
      PCI/PM: Rearrange pci_update_current_state()
      PCI/PM: Split pci_raw_set_power_state()
      PCI/PM: Relocate pci_set_low_power_state()
      PCI/PM: Set current_state to D3cold if the device is not accessible
      PCI/PM: Unfold pci_platform_power_transition() in pci_power_up()
      PCI/PM: Do not call pci_update_current_state() from pci_power_up()
      PCI/PM: Write 0 to PMCSR in pci_power_up() in all cases
      PCI/PM: Split pci_power_up()
      PCI/PM: Do not restore BARs if device is not in D0
      PCI/PM: Clean up pci_set_low_power_state()
      PCI/PM: Rearrange pci_set_power_state()
      PCI/PM: Replace pci_set_power_state() in pci_pm_thaw_noirq()

Shlomo Pongratz (1):
      PCI/P2PDMA: Whitelist Intel Skylake-E Root Ports at any devfn

Uwe Kleine-König (1):
      PCI: microchip: Add a missing semicolon

Xiaowei Bao (1):
      dt-bindings: pci: layerscape-pci: Add EP mode compatible strings for ls1028a

Yicong Yang (1):
      PCI: Avoid pci_dev_lock() AB/BA deadlock with sriov_numvfs_store()

 Documentation/PCI/pci.rst                          |   4 +-
 Documentation/admin-guide/kernel-parameters.txt    |   9 +
 .../devicetree/bindings/pci/layerscape-pci.txt     |  65 +-
 .../devicetree/bindings/pci/qcom,pcie.txt          | 397 ------------
 .../devicetree/bindings/pci/qcom,pcie.yaml         | 714 +++++++++++++++++++++
 .../devicetree/bindings/pci/rockchip-dw-pcie.yaml  |  12 +-
 arch/x86/include/asm/e820/api.h                    |   5 +
 arch/x86/include/asm/pci_x86.h                     |   2 +
 arch/x86/kernel/resource.c                         |  23 +-
 arch/x86/pci/acpi.c                                |  93 +++
 arch/x86/pci/common.c                              |   8 +
 drivers/pci/controller/cadence/pci-j721e.c         |   3 +
 drivers/pci/controller/cadence/pcie-cadence-ep.c   |  21 +-
 drivers/pci/controller/cadence/pcie-cadence-host.c |  10 +
 drivers/pci/controller/cadence/pcie-cadence.h      |   7 +
 drivers/pci/controller/dwc/pci-imx6.c              |  23 +-
 drivers/pci/controller/dwc/pcie-designware-host.c  |   3 +-
 drivers/pci/controller/dwc/pcie-dw-rockchip.c      | 119 +++-
 drivers/pci/controller/dwc/pcie-qcom-ep.c          | 113 ++--
 drivers/pci/controller/dwc/pcie-qcom.c             |  23 +-
 drivers/pci/controller/dwc/pcie-tegra194.c         |   9 -
 drivers/pci/controller/pci-mvebu.c                 |  97 ++-
 drivers/pci/controller/pci-versatile.c             |   3 +-
 drivers/pci/controller/pcie-mediatek-gen3.c        |   8 +
 drivers/pci/controller/pcie-mediatek.c             |   1 +
 drivers/pci/controller/pcie-microchip-host.c       |  18 +-
 drivers/pci/controller/pcie-rockchip-ep.c          |   3 +-
 drivers/pci/controller/vmd.c                       |   7 +-
 drivers/pci/hotplug/pnv_php.c                      |   1 +
 drivers/pci/hotplug/rpadlpar_core.c                |   1 +
 drivers/pci/hotplug/rpaphp_core.c                  |   2 +
 drivers/pci/hotplug/rpaphp_pci.c                   |   1 +
 drivers/pci/hotplug/rpaphp_slot.c                  |   1 +
 drivers/pci/of.c                                   |  70 ++
 drivers/pci/p2pdma.c                               |  25 +-
 drivers/pci/pci-acpi.c                             |  41 +-
 drivers/pci/pci-driver.c                           |  45 +-
 drivers/pci/pci.c                                  | 353 +++++-----
 drivers/pci/pci.h                                  |  15 +
 drivers/pci/pcie/aer.c                             |   7 +-
 drivers/pci/quirks.c                               |  47 ++
 include/linux/pci.h                                |   4 -
 include/uapi/linux/pci_regs.h                      |   1 +
 43 files changed, 1656 insertions(+), 758 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie.yaml
