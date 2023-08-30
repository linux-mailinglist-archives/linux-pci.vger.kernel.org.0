Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D5178E357
	for <lists+linux-pci@lfdr.de>; Thu, 31 Aug 2023 01:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240574AbjH3Xi2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Aug 2023 19:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344511AbjH3Xi2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Aug 2023 19:38:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6873ACC;
        Wed, 30 Aug 2023 16:38:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 18AEEB81FE5;
        Wed, 30 Aug 2023 19:06:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DFCEC433C7;
        Wed, 30 Aug 2023 19:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693422404;
        bh=iRqnsv9y7tkmU32EaV3W3mQhTk6ohgWD7Qxama0hDCo=;
        h=Date:From:To:Cc:Subject:From;
        b=LAPR9e1+IWgBonCreNTCUd8xQL4P/L/FbPr6hq+x/y/cHiYVt0fUE6TpPu5i3MhZ3
         +Jt/ufguSeLMm9dXIpfxuH6itMwhShLVVNXIxkhcAaQrc05dkB7Ar3Cc9C+HQ1lVuB
         qPcjim+0Nt/Y66jHRKIFfSt0/tkFwkOYF92H25x/6BE5Fe/6scHyE1w/NW8QRv+Lqw
         gBLWHgFllJaG9vT0G5SAYGmlWCjLg6oFo9CNybjZ9e0rY8y2mQ5r08uLXs79TS+2tg
         I1crrKCTkCY/T8h5FbuRmhaB9frgEd/cAxDEByL+Vl6LRYg1+bzPYfNi0ioqO4H9b2
         3ae05nKo+WZKA==
Date:   Wed, 30 Aug 2023 14:06:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: [GIT PULL] PCI changes for v6.6
Message-ID: <20230830190642.GA10547@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.6-changes

for you to fetch changes up to 43cc31da9146f9ce60e4a03d96ef0807c2cdac94:

  Merge branch 'pci/misc' (2023-08-29 11:03:57 -0500)

----------------------------------------------------------------

Enumeration:

  - Add locking to read/modify/write PCIe Capability Register accessors for
    Link Control and Root Control

  - Use pci_dev_id() when possible instead of manually composing ID from
    dev->bus->number and dev->devfn

Resource management:

  - Move prototypes for __weak sysfs resource files to linux/pci.h to fix
    "no previous prototype" warnings

  - Make more I/O port accesses depend on HAS_IOPORT

  - Use devm_platform_get_and_ioremap_resource() instead of open-coding
    platform_get_resource() followed by devm_ioremap_resource()

Power management:

  - Ensure devices are powered up while accessing VPD

  - If device is powered-up, keep it that way while polling for PME

  - Only read PCI_PM_CTRL register when available, to avoid reading the
    wrong register and corrupting dev->current_state

Virtualization:

  - Avoid Secondary Bus Reset on NVIDIA T4 GPUs

Error handling:

  - Remove unused pci_disable_pcie_error_reporting()

  - Unexport pci_enable_pcie_error_reporting(), used only by aer.c

  - Unexport pcie_port_bus_type, used only by PCI core

VGA:

  - Simplify and clean up typos in VGA arbiter

Apple PCIe controller driver:

  - Initialize pcie->nvecs (number of available MSIs) before use

Broadcom iProc PCIe controller driver:

  - Use of_property_read_bool() instead of low-level accessors for boolean
    properties

Broadcom STB PCIe controller driver:

  - Assert PERST# when probing BCM2711 because some bootloaders don't do it

Freescale i.MX6 PCIe controller driver:

  - Add .host_deinit() callback so we can clean up things like regulators
    on probe failure or driver unload

Freescale Layerscape PCIe controller driver:

  - Add support for link-down notification so the endpoint driver can
    process LINK_DOWN events

  - Add suspend/resume support, including manual PME_Turn_off/PME_TO_Ack
    handshake

  - Save Link Capabilities during probe so they can be restored when
    handling a link-up event, since the controller loses the Link Width and
    Link Speed values during reset

Intel VMD host bridge driver:

  - Fix disable of bridge windows during domain reset; previously we
    cleared the base/limit registers, which actually left the windows
    enabled

Marvell MVEBU PCIe controller driver:

  - Remove unused busn member

Microchip PolarFlare PCIe controller driver:

  - Fix interrupt bit definitions so the SEC and DED interrupt handlers
    work correctly

  - Make driver buildable as a module

  - Read FPGA MSI configuration parameters from hardware instead of
    hard-coding them

Microsoft Hyper-V host bridge driver:

  - To avoid a NULL pointer dereference, skip MSI restore after hibernate
    if MSI/MSI-X hasn't been enabled

NVIDIA Tegra194 PCIe controller driver:

  - Revert "PCI: tegra194: Enable support for 256 Byte payload" because
    Linux doesn't know how to reduce MPS from to 256 to 128 bytes for
    Endpoints below a Switch (because other devices below the Switch might
    already be operating), which leads to Malformed TLP errors

Qualcomm PCIe controller driver:

  - Add DT and driver support for interconnect bandwidth voting for
    "pcie-mem" and "cpu-pcie" interconnects

  - Fix broken SDX65 "compatible" DT property

  - Configure controller so MHI bus master clock will be switched off while
    in ASPM L1.x states

  - Use alignment restriction from EPF core in EPF MHI driver

  - Add Endpoint eDMA support

  - Add MHI eDMA support

  - Add Snapdragon SM8450 support to the EPF MHI driversupport

  - Add MHI eDMA support

  - Add Snapdragon SM8450 support to the EPF MHI driversupport

  - Add MHI eDMA support

  - Add Snapdragon SM8450 support to the EPF MHI driversupport

  - Add MHI eDMA support

  - Add Snapdragon SM8450 support to the EPF MHI driver

  - Use iATU for EPF MHI transfers smaller than 4K to avoid eDMA setup
    latency

  - Add sa8775p DT binding and driver support

Rockchip PCIe controller driver:

  - Use 64-bit mask on MSI 64-bit PCI address to avoid zeroing out the
    upper 32 bits

SiFive FU740 PCIe controller driver:

  - Set the supported number of MSI vectors so we can use all available MSI
    interrupts

Synopsys DesignWare PCIe controller driver:

  - Add generic dwc suspend/resume APIs (dw_pcie_suspend_noirq() and
    dw_pcie_resume_noirq()) to be called by controller driver
    suspend/resume ops, and a controller callback to send PME_Turn_Off

MicroSemi Switchtec management driver:

  - Add support for PCIe Gen5 devices

Miscellaneous:

  - Reorder and compress to reduce size of struct pci_dev

  - Fix race in DOE destroy_work_on_stack()

  - Add stubs to avoid casts between incompatible function types

  - Explicitly include correct DT includes to untangle headers

----------------------------------------------------------------
Alex Williamson (2):
      PCI/VPD: Add runtime power management to sysfs interface
      PCI: Fix runtime PM race with PME polling

Arnd Bergmann (1):
      PCI/sysfs: Move declarations to linux/pci.h

Bjorn Helgaas (40):
      PCI/AER: Drop unused pci_disable_pcie_error_reporting()
      PCI/AER: Unexport pci_enable_pcie_error_reporting()
      PCI: Unexport pcie_port_bus_type
      PCI: Remove unnecessary initializations
      PCI: Fix printk field formatting
      PCI: Use consistent put_user() pointer types
      PCI/AER: Simplify AER_RECOVER_RING_SIZE definition
      PCI: Simplify pci_pio_to_address()
      PCI: Simplify pci_dev_driver()
      PCI: Fix pci_bus_resetable(), pci_slot_resetable() name typos
      PCI: Fix typos in docs and comments
      PCI: Fix code formatting inconsistencies
      PCI: Tidy config space save/restore messages
      PCI: Simplify pcie_capability_clear_and_set_word() control flow
      Merge branch 'pci/aer'
      Merge branch 'pci/hotplug'
      Merge branch 'pci/ioport'
      Merge branch 'pci/pcie-rmw'
      Merge branch 'pci/pm'
      Merge branch 'pci/virtualization'
      Merge branch 'pci/vga'
      Merge branch 'pci/vpd'
      Merge branch 'pci/controller/apple'
      Merge branch 'pci/controller/brcmstb'
      Merge branch 'pci/controller/dwc'
      Merge branch 'pci/controller/fu740'
      Merge branch 'pci/controller/hv'
      Merge branch 'pci/controller/iproc'
      Merge branch 'pci/controller/layerscape'
      Merge branch 'pci/controller/microchip'
      Merge branch 'pci/controller/qcom'
      Merge branch 'pci/controller/qcom-edma'
      Merge branch 'pci/controller/qcom-ep'
      Merge branch 'pci/controller/rockchip'
      Merge branch 'pci/controller/tegra194'
      Merge branch 'pci/controller/vmd'
      Merge branch 'pci/controller/remove-void-cast'
      Merge branch 'pci/controller/resources'
      Merge branch 'pci/controller/switchtec'
      Merge branch 'pci/misc'

Christophe JAILLET (3):
      PCI: Reorder pci_dev fields to reduce holes
      PCI: Change pdev->rom_attr_enabled to single bit
      x86/PCI: Use struct_size() in pirq_convert_irt_table()

Colin Ian King (1):
      PCI: ibmphp: Make read-only arrays static

Daire McNamara (7):
      PCI: microchip: Correct the DED and SEC interrupt bit offsets
      PCI: microchip: Enable building driver as a module
      PCI: microchip: Align register, offset, and mask names with HW docs
      PCI: microchip: Enable event handlers to access bridge and control pointers
      PCI: microchip: Clean up initialisation of interrupts
      PCI: microchip: Gather MSI information from hardware config registers
      PCI: microchip: Re-partition code between probe() and init()

Dexuan Cui (1):
      PCI: hv: Fix a crash in hv_pci_restore_msi_msg() during hibernation

Feiyang Chen (1):
      PCI/PM: Only read PCI_PM_CTRL register when available

Frank Li (3):
      PCI: layerscape: Add support for link-down notification
      PCI: Add PCIE_PME_TO_L2_TIMEOUT_US L2 ready timeout value
      PCI: dwc: Implement generic suspend/resume functionality

Hou Zhiqiang (1):
      PCI: layerscape: Add power management support for ls1028a

Ilpo Järvinen (12):
      PCI: Add locking to RMW PCI Express Capability Register accessors
      PCI: Make link retraining use RMW accessors for changing LNKCTL
      PCI: pciehp: Use RMW accessors for changing LNKCTL
      PCI/ASPM: Use RMW accessors for changing LNKCTL
      drm/amdgpu: Use RMW accessors for changing LNKCTL
      drm/radeon: Use RMW accessors for changing LNKCTL
      net/mlx5: Use RMW accessors for changing LNKCTL
      wifi: ath11k: Use RMW accessors for changing LNKCTL
      wifi: ath12k: Use RMW accessors for changing LNKCTL
      wifi: ath10k: Use RMW accessors for changing LNKCTL
      PCI: Document the Capability accessor RMW improvements
      net/mlx5: Convert PCI error values to generic errnos

Ira Weiny (1):
      PCI/DOE: Fix destroy_work_on_stack() race

Jim Quinlan (2):
      PCI: brcmstb: Assert PERST# on BCM2711
      PCI: brcmstb: Remove stale comment

Kelvin Cao (2):
      PCI: switchtec: Use normal comment style
      PCI: switchtec: Add support for PCIe Gen5 devices

Krishna chaitanya chundru (2):
      dt-bindings: PCI: qcom: ep: Add interconnects path
      PCI: qcom-ep: Add ICC bandwidth voting support

Krzysztof Kozlowski (1):
      dt-bindings: PCI: qcom: Fix SDX65 compatible

Krzysztof Wilczyński (3):
      PCI: meson: Remove cast between incompatible function type
      PCI: keembay: Remove cast between incompatible function type
      PCI: microchip: Remove cast between incompatible function type

Manivannan Sadhasivam (9):
      PCI: qcom-ep: Switch MHI bus master clock off during L1SS
      PCI: qcom-ep: Pass alignment restriction to the EPF core
      PCI: epf-mhi: Make use of the alignment restriction from EPF core
      PCI: qcom-ep: Add eDMA support
      PCI: epf-mhi: Add eDMA support
      PCI: epf-mhi: Add support for SM8450
      PCI: epf-mhi: Use iATU for small transfers
      PCI: endpoint: Add kernel-doc for pci_epc_mem_init() API
      PCI: qcom-ep: Treat unknown IRQ events as an error

Mark Brown (1):
      PCI: dwc: Provide deinit callback for i.MX

Mrinmay Sarkar (2):
      dt-bindings: PCI: qcom: Add sa8775p compatible
      PCI: qcom: Add support for sa8775p SoC

Niklas Schnelle (2):
      PCI: Make quirk using inw() depend on HAS_IOPORT
      PCI/sysfs: Make I/O resource depend on HAS_IOPORT

Nirmal Patel (1):
      PCI: vmd: Disable bridge window for domain reset

Pali Rohár (1):
      PCI: mvebu: Remove unused busn member

Rick Wertenbroek (1):
      PCI: rockchip: Use 64-bit mask on MSI 64-bit PCI address

Rob Herring (2):
      PCI: iproc: Use of_property_read_bool() for boolean properties
      PCI: Explicitly include correct DT includes

Sui Jingfeng (6):
      PCI/VGA: Correct vga_str_to_iostate() io_state parameter type
      PCI/VGA: Correct vga_update_device_decodes() parameter type
      PCI/VGA: Simplify vga_arbiter_notify_clients()
      PCI/VGA: Simplify vga_client_register()
      PCI/VGA: Replace full MIT license text with SPDX identifier
      PCI/VGA: Fix typos

Sven Peter (1):
      PCI: apple: Initialize pcie->nvecs before use

Vidya Sagar (1):
      Revert "PCI: tegra194: Enable support for 256 Byte payload"

Wu Zongyong (1):
      PCI: Mark NVIDIA T4 GPUs to avoid bus reset

Xiaowei Bao (1):
      PCI: layerscape: Add workaround for lost link capabilities during reset

Xiongfeng Wang (3):
      PCI: apple: Use pci_dev_id() to simplify the code
      PCI/AER: Use pci_dev_id() to simplify the code
      PCI/IOV: Use pci_dev_id() to simplify the code

Yang Li (4):
      PCI: rcar-gen2: Use devm_platform_get_and_ioremap_resource()
      PCI: v3: Use devm_platform_get_and_ioremap_resource()
      PCI: xgene-msi: Use devm_platform_get_and_ioremap_resource()
      PCI: imx6: Use devm_platform_get_and_ioremap_resource()

Yong-Xuan Wang (1):
      PCI: fu740: Set the number of MSI vectors

Yue Haibing (1):
      PCI: Remove unused function declarations

Zheng Zengkai (1):
      PCI/P2PDMA: Use pci_dev_id() to simplify the code

 Documentation/PCI/pci-error-recovery.rst           |  12 +-
 Documentation/PCI/pciebus-howto.rst                |  14 +-
 .../devicetree/bindings/pci/qcom,pcie-ep.yaml      |  27 +-
 .../devicetree/bindings/pci/qcom,pcie.yaml         |  28 ++
 arch/alpha/include/asm/pci.h                       |   3 -
 arch/x86/pci/irq.c                                 |   4 +-
 drivers/gpu/drm/amd/amdgpu/cik.c                   |  36 +-
 drivers/gpu/drm/amd/amdgpu/si.c                    |  36 +-
 drivers/gpu/drm/radeon/cik.c                       |  36 +-
 drivers/gpu/drm/radeon/si.c                        |  37 +-
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c |  21 +-
 drivers/net/wireless/ath/ath10k/pci.c              |   9 +-
 drivers/net/wireless/ath/ath11k/pci.c              |  10 +-
 drivers/net/wireless/ath/ath12k/pci.c              |  10 +-
 drivers/pci/access.c                               |  40 +-
 drivers/pci/controller/Kconfig                     |   2 +-
 drivers/pci/controller/cadence/pci-j721e.c         |   2 +-
 drivers/pci/controller/cadence/pcie-cadence-plat.c |   3 +-
 drivers/pci/controller/cadence/pcie-cadence.c      |   1 +
 drivers/pci/controller/cadence/pcie-cadence.h      |   2 +-
 drivers/pci/controller/dwc/pci-dra7xx.c            |   2 +-
 drivers/pci/controller/dwc/pci-exynos.c            |   2 +-
 drivers/pci/controller/dwc/pci-imx6.c              |   6 +-
 drivers/pci/controller/dwc/pci-keystone.c          |   1 -
 drivers/pci/controller/dwc/pci-layerscape-ep.c     |  20 +
 drivers/pci/controller/dwc/pci-layerscape.c        | 140 ++++++-
 drivers/pci/controller/dwc/pci-meson.c             |  13 +-
 drivers/pci/controller/dwc/pcie-artpec6.c          |   2 +-
 drivers/pci/controller/dwc/pcie-designware-host.c  |  71 ++++
 drivers/pci/controller/dwc/pcie-designware-plat.c  |   2 +-
 drivers/pci/controller/dwc/pcie-designware.c       |   2 +-
 drivers/pci/controller/dwc/pcie-designware.h       |  28 ++
 drivers/pci/controller/dwc/pcie-dw-rockchip.c      |   2 +-
 drivers/pci/controller/dwc/pcie-fu740.c            |   1 +
 drivers/pci/controller/dwc/pcie-intel-gw.c         |   2 +
 drivers/pci/controller/dwc/pcie-keembay.c          |  11 +-
 drivers/pci/controller/dwc/pcie-kirin.c            |   3 +-
 drivers/pci/controller/dwc/pcie-qcom-ep.c          |  81 +++-
 drivers/pci/controller/dwc/pcie-qcom.c             |   3 +-
 drivers/pci/controller/dwc/pcie-tegra194.c         |  11 -
 drivers/pci/controller/dwc/pcie-uniphier-ep.c      |   2 +-
 .../pci/controller/mobiveil/pcie-mobiveil-host.c   |   3 -
 drivers/pci/controller/pci-ftpci100.c              |   3 +-
 drivers/pci/controller/pci-host-common.c           |   2 +-
 drivers/pci/controller/pci-hyperv.c                |   3 +
 drivers/pci/controller/pci-ixp4xx.c                |   3 +-
 drivers/pci/controller/pci-loongson.c              |   2 +-
 drivers/pci/controller/pci-mvebu.c                 |   1 -
 drivers/pci/controller/pci-rcar-gen2.c             |   3 +-
 drivers/pci/controller/pci-v3-semi.c               |   6 +-
 drivers/pci/controller/pci-xgene-msi.c             |   3 +-
 drivers/pci/controller/pcie-altera.c               |   5 +-
 drivers/pci/controller/pcie-apple.c                |  10 +-
 drivers/pci/controller/pcie-brcmstb.c              |   6 +-
 drivers/pci/controller/pcie-iproc-msi.c            |   5 +-
 drivers/pci/controller/pcie-microchip-host.c       | 407 ++++++++++++---------
 drivers/pci/controller/pcie-rockchip-host.c        |   4 +-
 drivers/pci/controller/pcie-rockchip.c             |   1 +
 drivers/pci/controller/pcie-rockchip.h             |   6 +-
 drivers/pci/controller/vmd.c                       |  19 +-
 drivers/pci/doe.c                                  |   2 +-
 drivers/pci/endpoint/functions/pci-epf-mhi.c       | 286 ++++++++++++++-
 drivers/pci/endpoint/functions/pci-epf-vntb.c      |  32 +-
 drivers/pci/endpoint/pci-epc-core.c                |   1 -
 drivers/pci/endpoint/pci-epc-mem.c                 |  10 +
 drivers/pci/hotplug/acpiphp.h                      |   1 -
 drivers/pci/hotplug/cpci_hotplug.h                 |   2 -
 drivers/pci/hotplug/ibmphp.h                       |   2 -
 drivers/pci/hotplug/ibmphp_pci.c                   |  10 +-
 drivers/pci/hotplug/pciehp_hpc.c                   |  12 +-
 drivers/pci/iov.c                                  |   3 +-
 drivers/pci/msi/irqdomain.c                        |   4 +-
 drivers/pci/p2pdma.c                               |   5 +-
 drivers/pci/pci-driver.c                           |  18 +-
 drivers/pci/pci-sysfs.c                            |   4 +
 drivers/pci/pci.c                                  |  72 ++--
 drivers/pci/pci.h                                  |  41 +--
 drivers/pci/pcie/aer.c                             |  22 +-
 drivers/pci/pcie/aspm.c                            |  30 +-
 drivers/pci/probe.c                                |   4 +-
 drivers/pci/quirks.c                               |  48 ++-
 drivers/pci/setup-bus.c                            |   2 +-
 drivers/pci/setup-res.c                            |   4 +-
 drivers/pci/switch/switchtec.c                     | 158 +++++---
 drivers/pci/syscall.c                              |  12 +-
 drivers/pci/vgaarb.c                               | 358 +++++++++---------
 drivers/pci/vpd.c                                  |  34 +-
 include/linux/aer.h                                |  11 -
 include/linux/pci.h                                |  46 ++-
 include/linux/switchtec.h                          |   1 +
 include/linux/vgaarb.h                             |  27 +-
 91 files changed, 1622 insertions(+), 870 deletions(-)
