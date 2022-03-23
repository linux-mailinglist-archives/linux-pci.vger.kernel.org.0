Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2994E5A87
	for <lists+linux-pci@lfdr.de>; Wed, 23 Mar 2022 22:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241060AbiCWVTT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Mar 2022 17:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239195AbiCWVTT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Mar 2022 17:19:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E54685644;
        Wed, 23 Mar 2022 14:17:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7EB01B820BC;
        Wed, 23 Mar 2022 21:17:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07754C340ED;
        Wed, 23 Mar 2022 21:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648070265;
        bh=v5e4k963RO31bJDETxEOIn5BWVaRc2DhlX7tt5acHug=;
        h=Date:From:To:Cc:Subject:From;
        b=qKRqWz7esmgtQQDVc81K+/mQRuHJuJrQYiAhaTgNK2RwWFkWFTNbBnd4Bq2NxULaN
         E2RqKbj1H101IC2CIljcSuVdqQIAX+9ROuQoABzO/QeORek6cpLB6SzKD1CAvNiq9d
         JEFnAQ0hBpfA/ATH5BMloSlcC1LjPK3hdODYWmVejr4YGpJy/ryB+FzQG4HhySEtHN
         uRt3CxB/YCAjk3hK6VJRJ2gQ6FRSQvSDUfH6Z3DAaskQ8iICvfsq+UaN+mbm7gz/LQ
         SqyvutbXQS0tLz8GAwWvVvmVz9eLocundVe0AyNjQjilGT3G8VyUJYkZXhMdSYD7rn
         dZ2KLyHUXDsiQ==
Date:   Wed, 23 Mar 2022 16:17:43 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [GIT PULL] PCI changes for v5.18
Message-ID: <20220323211743.GA1372301@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.18-changes

for you to fetch changes up to 611f841830aa5723ea67682628bd214cbc18df41:

  Merge branch 'remotes/lorenzo/pci/xgene' (2022-03-22 17:16:27 -0500)

----------------------------------------------------------------

Enumeration:
  - Move the VGA arbiter from drivers/gpu to drivers/pci because it's
    PCI-specific, not GPU-specific (Bjorn Helgaas)
  - Select the default VGA device consistently whether it's enumerated
    before or after VGA arbiter init, which fixes arches that enumerate PCI
    devices late (Huacai Chen)

Resource management:
  - Support BAR sizes up to 8TB (Dongdong Liu)

PCIe native device hotplug:
  - Fix "Command Completed" tracking to avoid spurious timouts when
    powering off empty slots (Liguang Zhang)
  - Quirk Qualcomm devices that don't implement Command Completed
    correctly, again to avoid spurious timeouts (Manivannan Sadhasivam)

Peer-to-peer DMA:
  - Add Intel 3rd Gen Intel Xeon Scalable Processors to whitelist (Michael
    J. Ruhl)

APM X-Gene PCIe controller driver:
  - Revert generic DT parsing changes that broke some machines in the field
    (Marc Zyngier)

Freescale i.MX6 PCIe controller driver:
  - Allow controller probe to succeed even when no devices currently
    present to allow hot-add later (Fabio Estevam)
  - Enable power management on i.MX6QP (Richard Zhu)
  - Assert CLKREQ# on i.MX8MM so enumeration doesn't hang when no device is
    connected (Richard Zhu)

Marvell Aardvark PCIe controller driver:
  - Fix MSI and MSI-X support (Marek Behún, Pali Rohár)
  - Add support for ERR and PME interrupts (Pali Rohár)

Marvell MVEBU PCIe controller driver:
  - Add DT binding and support for "num-lanes" (Pali Rohár)
  - Add support for INTx interrupts (Pali Rohár)

Microsoft Hyper-V host bridge driver:
  - Avoid unnecessary hypercalls when unmasking IRQs on ARM64 (Boqun Feng)

Qualcomm PCIe controller driver:
  - Add SM8450 DT binding and driver support (Dmitry Baryshkov)

Renesas R-Car PCIe controller driver:
  - Help the controller get to the L1 state since the hardware can't do it
    on its own (Marek Vasut)
  - Return PCI_ERROR_RESPONSE (~0) for reads that fail on PCIe (Marek Vasut)

SiFive FU740 PCIe controller driver:
  - Drop redundant '-gpios' from DT GPIO lookup (Ben Dooks)
  - Force 2.5GT/s for initial device probe (Ben Dooks)

Socionext UniPhier Pro5 controller driver:
  - Add NX1 DT binding and driver support (Kunihiko Hayashi)

Synopsys DesignWare PCIe controller driver:
  - Restore MSI configuration so MSI works after resume (Jisheng Zhang)

----------------------------------------------------------------
Ben Dooks (2):
      PCI: fu740: Drop redundant '-gpios' from DT GPIO lookup
      PCI: fu740: Force 2.5GT/s for initial device probe

Bjorn Helgaas (31):
      PCI/VGA: Move vgaarb to drivers/pci
      PCI/VGA: Factor out vga_select_framebuffer_device()
      PCI/VGA: Remove empty vga_arb_device_card_gone()
      PCI/VGA: Use unsigned format string to print lock counts
      PCI/VGA: Replace full MIT license text with SPDX identifier
      PCI: Avoid broken MSI on SB600 USB devices
      PCI: Remove unused assignments
      PCI: kirin: Remove unused assignments
      PCI: fu740: Remove unused assignments
      PCI: cpqphp: Remove unused assignments
      PCI: ibmphp: Remove unused assignments
      Merge branch 'pci/acpi'
      Merge branch 'pci/bridge-class-codes'
      Merge branch 'pci/enumeration'
      Merge branch 'pci/hotplug'
      Merge branch 'pci/misc'
      Merge branch 'pci/msi'
      Merge branch 'pci/p2pdma'
      Merge branch 'pci/vga'
      Merge branch 'remotes/lorenzo/pci/aardvark'
      Merge branch 'pci/host/dwc'
      Merge branch 'remotes/lorenzo/pci/endpoint'
      Merge branch 'pci/host/fu740'
      Merge branch 'remotes/lorenzo/pci/hv'
      Merge branch 'remotes/lorenzo/pci/imx6'
      Merge branch 'remotes/lorenzo/pci/misc'
      Merge branch 'remotes/lorenzo/pci/mvebu'
      Merge branch 'remotes/lorenzo/pci/qcom'
      Merge branch 'remotes/lorenzo/pci/rcar'
      Merge branch 'remotes/lorenzo/pci/uniphier'
      Merge branch 'remotes/lorenzo/pci/xgene'

Boqun Feng (1):
      PCI: hv: Avoid the retarget interrupt hypercall in irq_unmask() on ARM64

Christophe Leroy (1):
      sizes.h: Add SZ_1T macro

Dmitry Baryshkov (4):
      dt-bindings: pci: qcom: Document PCIe bindings for SM8450
      PCI: qcom: Remove redundancy between qcom_pcie and qcom_pcie_cfg
      PCI: qcom: Add ddrss_sf_tbu flag
      PCI: qcom: Add SM8450 PCIe support

Dongdong Liu (1):
      PCI: Support BAR sizes up to 8TB

Fabio Estevam (1):
      PCI: imx6: Allow to probe when dw_pcie_wait_for_link() fails

Hou Zhiqiang (1):
      PCI: endpoint: Fix alignment fault error in copy tests

Huacai Chen (6):
      PCI/VGA: Move vga_arb_integrated_gpu() earlier in file
      PCI/VGA: Factor out default VGA device selection
      PCI/VGA: Move firmware default device detection to ADD_DEVICE path
      PCI/VGA: Move non-legacy VGA detection to ADD_DEVICE path
      PCI/VGA: Move disabled VGA device detection to ADD_DEVICE path
      PCI/VGA: Log bridge control messages when adding devices

Jisheng Zhang (1):
      PCI: dwc: Restore MSI Receiver mask during resume

Krzysztof Wilczyński (1):
      PCI: Declare pci_filp_private only when HAVE_PCI_MMAP

Kunihiko Hayashi (3):
      dt-bindings: PCI: uniphier-ep: Add bindings for NX1 SoC
      PCI: uniphier-ep: Add SoC data structure
      PCI: uniphier-ep: Add NX1 support

Li Chen (1):
      PCI: endpoint: Fix misused goto label

Liguang Zhang (1):
      PCI: pciehp: Clear cmd_busy bit in polling mode

Manivannan Sadhasivam (1):
      PCI: pciehp: Add Qualcomm quirk for Command Completed erratum

Marc Zyngier (2):
      PCI: xgene: Revert "PCI: xgene: Use inbound resources for setup"
      PCI: xgene: Revert "PCI: xgene: Fix IB window setup"

Marek Behún (5):
      PCI: aardvark: Make MSI irq_chip structures static driver structures
      PCI: aardvark: Make msi_domain_info structure a static driver structure
      PCI: aardvark: Use dev_fwnode() instead of of_node_to_fwnode(dev->of_node)
      PCI: aardvark: Drop __maybe_unused from advk_pcie_disable_phy()
      PCI: aardvark: Update comment about link going down after link-up

Marek Vasut (2):
      PCI: rcar: Finish transition to L1 state in rcar_pcie_config_access()
      PCI: rcar: Use PCI_SET_ERROR_RESPONSE after read which triggered an exception

Mark Tomlinson (1):
      PCI: Reduce warnings on possible RW1C corruption

Michael J. Ruhl (1):
      PCI/P2PDMA: Add Intel 3rd Gen Intel Xeon Scalable Processors to whitelist

Pali Rohár (39):
      MAINTAINERS: Add Pali Rohár as pci-mvebu.c maintainer
      PCI: pci-bridge-emul: Make struct pci_bridge_emul_ops as const
      PCI: pci-bridge-emul: Rename PCI_BRIDGE_EMUL_NO_PREFETCHABLE_BAR to PCI_BRIDGE_EMUL_NO_PREFMEM_FORWARD
      PCI: pci-bridge-emul: Add support for new flag PCI_BRIDGE_EMUL_NO_IO_FORWARD
      PCI: mvebu: Add help string for CONFIG_PCI_MVEBU option
      PCI: mvebu: Remove duplicate nports assignment
      PCI: mvebu: Set PCI_BRIDGE_EMUL_NO_IO_FORWARD when IO is unsupported
      PCI: mvebu: Properly initialize vendor, device and revision of emulated bridge
      PCI: mvebu: Update comment for PCI_EXP_LNKCAP register on emulated bridge
      PCI: mvebu: Update comment for PCI_EXP_LNKCTL register on emulated bridge
      PCI: mvebu: Fix reporting Data Link Layer Link Active on emulated bridge
      PCI: aardvark: Replace custom PCIE_CORE_INT_* macros with PCI_INTERRUPT_*
      PCI: aardvark: Fix reading MSI interrupt number
      PCI: aardvark: Fix support for MSI interrupts
      PCI: aardvark: Rewrite IRQ code to chained IRQ handler
      PCI: aardvark: Check return value of generic_handle_domain_irq() when processing INTx IRQ
      PCI: aardvark: Refactor unmasking summary MSI interrupt
      PCI: aardvark: Add support for masking MSI interrupts
      PCI: aardvark: Fix setting MSI address
      PCI: aardvark: Enable MSI-X support
      PCI: aardvark: Add support for ERR interrupt on emulated bridge
      PCI: aardvark: Fix reading PCI_EXP_RTSTA_PME bit on emulated bridge
      PCI: aardvark: Optimize writing PCI_EXP_RTCTL_PMEIE and PCI_EXP_RTSTA_PME on emulated bridge
      PCI: aardvark: Add support for PME interrupts
      PCI: aardvark: Fix support for PME requester on emulated bridge
      PCI: aardvark: Use separate INTA interrupt for emulated root bridge
      PCI: aardvark: Remove irq_mask_ack() callback for INTx interrupts
      PCI: aardvark: Don't mask irq when mapping
      PCI: Add defines for normal and subtractive PCI bridges
      PCI: iproc: Set all 24 bits of PCI class code
      PCI: pci-bridge-emul: Add support for PCI Bridge Subsystem Vendor ID capability
      dt-bindings: PCI: mvebu: Add num-lanes property
      PCI: mvebu: Correctly configure x1/x4 mode
      PCI: mvebu: Add support for PCI Bridge Subsystem Vendor ID on emulated bridge
      PCI: mvebu: Add support for Advanced Error Reporting registers on emulated bridge
      PCI: mvebu: Use child_ops API
      dt-bindings: PCI: mvebu: Update information about intx interrupts
      PCI: mvebu: Fix macro names and comments about legacy interrupts
      PCI: mvebu: Implement support for legacy INTx interrupts

Rafael J. Wysocki (1):
      PCI/ACPI: Replace acpi_bus_get_device() with acpi_fetch_acpi_dev()

Randy Dunlap (1):
      x86/PCI: Add #includes to asm/pci_x86.h

Richard Zhu (3):
      PCI: imx6: Enable i.MX6QP PCIe power management support
      PCI: imx6: Invoke the PHY exit function after PHY power off
      PCI: imx6: Assert i.MX8MM CLKREQ# even if no device present

Russell King (2):
      PCI: pci-bridge-emul: Re-arrange register tests
      PCI: pci-bridge-emul: Add support for PCIe extended capabilities

Yicong Yang (1):
      PCI/AER: Update aer-inject URL

 .../devicetree/bindings/pci/mvebu-pci.txt          |  16 +
 .../devicetree/bindings/pci/qcom,pcie.txt          |  22 +-
 .../bindings/pci/socionext,uniphier-pcie-ep.yaml   |  22 +-
 Documentation/gpu/vgaarbiter.rst                   |   2 +-
 MAINTAINERS                                        |   1 +
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h  |   2 -
 arch/mips/pci/fixup-sb1250.c                       |   2 +-
 arch/mips/pci/pci-bcm63xx.c                        |   2 +-
 arch/powerpc/platforms/powernv/pci.c               |   2 +-
 arch/powerpc/sysdev/fsl_pci.c                      |   2 +-
 arch/sh/drivers/pci/pcie-sh7786.c                  |   2 +-
 arch/x86/include/asm/pci_x86.h                     |   3 +
 drivers/gpu/vga/Kconfig                            |  19 -
 drivers/gpu/vga/Makefile                           |   1 -
 drivers/pci/Kconfig                                |  19 +
 drivers/pci/Makefile                               |   1 +
 drivers/pci/access.c                               |   9 +-
 drivers/pci/controller/Kconfig                     |   4 +
 drivers/pci/controller/dwc/pci-imx6.c              |  19 +-
 drivers/pci/controller/dwc/pci-keystone.c          |   8 +-
 drivers/pci/controller/dwc/pci-meson.c             |  16 +-
 drivers/pci/controller/dwc/pcie-designware-host.c  |   7 +-
 drivers/pci/controller/dwc/pcie-fu740.c            |  57 ++-
 drivers/pci/controller/dwc/pcie-kirin.c            |   3 -
 drivers/pci/controller/dwc/pcie-qcom.c             |  95 +++--
 drivers/pci/controller/dwc/pcie-uniphier-ep.c      | 142 ++++++-
 .../pci/controller/mobiveil/pcie-mobiveil-host.c   |   2 +-
 drivers/pci/controller/pci-aardvark.c              | 394 +++++++++++++------
 drivers/pci/controller/pci-hyperv.c                | 233 ++++++------
 drivers/pci/controller/pci-loongson.c              |   2 +-
 drivers/pci/controller/pci-mvebu.c                 | 416 +++++++++++++++++----
 drivers/pci/controller/pci-tegra.c                 |   2 +-
 drivers/pci/controller/pci-xgene.c                 |  36 +-
 drivers/pci/controller/pcie-iproc-bcma.c           |   2 +-
 drivers/pci/controller/pcie-iproc.c                |  11 +-
 drivers/pci/controller/pcie-mediatek-gen3.c        |   2 +-
 drivers/pci/controller/pcie-rcar-host.c            | 132 +++++--
 drivers/pci/controller/pcie-rockchip-host.c        |   2 +-
 drivers/pci/controller/pcie-rockchip.h             |   1 -
 drivers/pci/endpoint/functions/pci-epf-test.c      |  14 +-
 drivers/pci/hotplug/acpiphp_glue.c                 |   7 +-
 drivers/pci/hotplug/acpiphp_ibm.c                  |   5 +-
 drivers/pci/hotplug/cpqphp_core.c                  |   2 +-
 drivers/pci/hotplug/cpqphp_ctrl.c                  |  22 +-
 drivers/pci/hotplug/cpqphp_pci.c                   |   2 +-
 drivers/pci/hotplug/ibmphp_hpc.c                   |   2 -
 drivers/pci/hotplug/ibmphp_res.c                   |   3 +-
 drivers/pci/hotplug/pciehp_hpc.c                   |   4 +
 drivers/pci/hotplug/shpchp_core.c                  |   2 +-
 drivers/pci/p2pdma.c                               |   1 +
 drivers/pci/pci-acpi.c                             |   6 +-
 drivers/pci/pci-bridge-emul.c                      | 190 +++++++---
 drivers/pci/pci-bridge-emul.h                      |  31 +-
 drivers/pci/pci-sysfs.c                            |   7 +-
 drivers/pci/pcie/Kconfig                           |   2 +-
 drivers/pci/pcie/aer_inject.c                      |   2 +-
 drivers/pci/pcie/portdrv_pci.c                     |   4 +-
 drivers/pci/proc.c                                 |   6 +-
 drivers/pci/quirks.c                               |  12 +
 drivers/pci/setup-bus.c                            |   4 +-
 drivers/{gpu/vga => pci}/vgaarb.c                  | 313 ++++++++--------
 include/linux/pci.h                                |   1 +
 include/linux/pci_ids.h                            |   2 +
 include/linux/sizes.h                              |   2 +
 64 files changed, 1593 insertions(+), 766 deletions(-)
 rename drivers/{gpu/vga => pci}/vgaarb.c (90%)
