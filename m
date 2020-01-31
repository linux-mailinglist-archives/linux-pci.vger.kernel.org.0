Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7138314F4C2
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jan 2020 23:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbgAaWeL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 31 Jan 2020 17:34:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:38400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbgAaWeL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 31 Jan 2020 17:34:11 -0500
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4981520707;
        Fri, 31 Jan 2020 22:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580510049;
        bh=FO3EBR0Qmuy+VdMsgwG+8OivuDlJpCjiJx5i0UgxeMA=;
        h=Date:From:To:Cc:Subject:From;
        b=1A1YogOATqtHC1rPi8vbqBH/jfMliUnVBzprfzIGINHrGFoEQ8rzE/LYW0AVkNptC
         4miPpv/EyV4UHf62oY+El4w8nab3Wb7WTH4naYPnuCUQAyQviCWtK7JbnTIg1NcIYK
         Xyd/q9cBJOvl6OI5BCS4vogBhgcIX1h2BrrBdkdQ=
Date:   Fri, 31 Jan 2020 16:34:07 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [GIT PULL] PCI changes for v5.6
Message-ID: <20200131223407.GA105848@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git 01b810ed7187

for you to fetch changes up to 01b810ed71878785d189d01e4d7425a11203d7a8:

  Merge branch 'remotes/lorenzo/pci/uniphier' (2020-01-29 17:00:08 -0600)

----------------------------------------------------------------

Resource management:

  - Improve resource assignment for hot-added nested bridges, e.g.,
    Thunderbolt (Nicholas Johnson)

Power management:

  - Optionally print config space of devices before suspend (Chen Yu)

  - Increase D3 delay for AMD Ryzen5/7 XHCI controllers (Daniel Drake)

Virtualization:

  - Generalize DMA alias quirks (James Sewart)

  - Add DMA alias quirk for PLX PEX NTB (James Sewart)

  - Fix IOV memory leak (Navid Emamdoost)

AER:

  - Log which device prevents error recovery (Yicong Yang)

Peer-to-peer DMA:

  - Whitelist Intel SkyLake-E (Armen Baloyan)

Broadcom iProc host bridge driver:

  - Apply PAXC quirk whether driver is built-in or module (Wei Liu)

Broadcom STB host bridge driver:

  - Add Broadcom STB PCIe host controller driver (Jim Quinlan)

Intel Gateway SoC host bridge driver:

  - Add driver for Intel Gateway SoC (Dilip Kota)

Intel VMD host bridge driver:

  - Add support for DMA aliases on other buses (Jon Derrick)

  - Remove dma_map_ops overrides (Jon Derrick)

  - Remove now-unused X86_DEV_DMA_OPS (Christoph Hellwig)

NVIDIA Tegra host bridge driver:

  - Fix Tegra30 afi_pex2_ctrl register offset (Marcel Ziswiler)

Panasonic UniPhier host bridge driver:

  - Remove module code since driver can't be built as a module (Masahiro
    Yamada)

Qualcomm host bridge driver:

  - Add support for SDM845 PCIe controller (Bjorn Andersson)

TI Keystone host bridge driver:

  - Fix "num-viewport" DT property error handling (Kishon Vijay Abraham I)

  - Fix link training retries initiation (Yurii Monakov)

  - Fix outbound region mapping (Yurii Monakov)

Misc:

  - Add Switchtec Gen4 support (Kelvin Cao)

  - Add Switchtec Intercomm Notify and Upstream Error Containment support
    (Logan Gunthorpe)

  - Use dma_set_mask_and_coherent() since Switchtec supports 64-bit
    addressing (Wesley Sheng)

----------------------------------------------------------------
Andrew Murray (1):
      MAINTAINERS: Update my email address

Armen Baloyan (1):
      PCI/P2PDMA: Add Intel SkyLake-E to the whitelist

Bjorn Andersson (2):
      dt-bindings: PCI: qcom: Add support for SDM845 PCIe
      PCI: qcom: Add support for SDM845 PCIe controller

Bjorn Helgaas (16):
      PCI/AER: Factor message prefixes with dev_fmt()
      Merge branch 'pci/aer'
      Merge branch 'pci/misc'
      Merge branch 'pci/p2pdma'
      Merge branch 'pci/pm'
      Merge branch 'pci/resource'
      Merge branch 'pci/switchtec'
      Merge branch 'pci/virtualization'
      Merge branch 'pci/host-vmd'
      Merge branch 'remotes/lorenzo/pci/brcmstb'
      Merge branch 'remotes/lorenzo/pci/dwc'
      Merge branch 'remotes/lorenzo/pci/keystone'
      Merge branch 'remotes/lorenzo/pci/misc'
      Merge branch 'remotes/lorenzo/pci/qcom'
      Merge branch 'remotes/lorenzo/pci/tegra'
      Merge branch 'remotes/lorenzo/pci/uniphier'

Chen Yu (1):
      PCI/PM: Print config space of devices before suspend

Christoph Hellwig (2):
      x86/PCI: Add to_pci_sysdata() helper
      x86/PCI: Remove X86_DEV_DMA_OPS

Daniel Drake (2):
      PCI: Add generic quirk for increasing D3hot delay
      PCI: Increase D3 delay for AMD Ryzen5/7 XHCI controllers

David Engraf (1):
      PCI: tegra: Fix return value check of pm_runtime_get_sync()

Dilip Kota (3):
      dt-bindings: PCI: intel: Add YAML schemas for the PCIe RC controller
      PCI: dwc: intel: PCIe RC controller driver
      PCI: artpec6: Configure FTS with dwc helper function

Dongdong Liu (1):
      PCI/AER: Initialize aer_fifo

James Sewart (3):
      PCI: Fix pci_add_dma_alias() bitmask size
      PCI: Add nr_devfns parameter to pci_add_dma_alias()
      PCI: Add DMA alias quirk for PLX PEX NTB

Jim Quinlan (3):
      dt-bindings: PCI: Add bindings for brcmstb's PCIe device
      PCI: brcmstb: Add Broadcom STB PCIe host controller driver
      PCI: brcmstb: Add MSI support

Jon Derrick (5):
      x86/PCI: Expose VMD's pci_dev in struct pci_sysdata
      PCI: Introduce pci_real_dma_dev()
      iommu/vt-d: Use pci_real_dma_dev() for mapping
      iommu/vt-d: Remove VMD child device sanity check
      PCI: vmd: Remove dma_map_ops overrides

Kelvin Cao (3):
      PCI/switchtec: Add Gen4 flash information interface support
      PCI/switchtec: Add Gen4 MRPC GAS access permission check
      PCI/switchtec: Add Gen4 device IDs

Kishon Vijay Abraham I (1):
      PCI: keystone: Fix error handling when "num-viewport" DT property is not populated

Krzysztof Kozlowski (1):
      PCI: exynos: Rename Exynos to lowercase

Logan Gunthorpe (8):
      PCI/switchtec: Fix vep_vector_number ioread width
      PCI: Don't disable bridge BARs when assigning bus resources
      PCI/switchtec: Add support for Intercomm Notify and Upstream Error Containment
      PCI/switchtec: Rename generation-specific constants
      PCI/switchtec: Add 'generation' variable
      PCI/switchtec: Factor out Gen3 ioctl_flash_part_info()
      PCI/switchtec: Separate Gen3 register structures into unions
      PCI/switchtec: Add Gen4 system info register support

Marcel Ziswiler (1):
      PCI: tegra: Fix afi_pex2_ctrl reg offset for Tegra30

Masahiro Yamada (1):
      PCI: uniphier: remove module code from built-in driver

Navid Emamdoost (1):
      PCI/IOV: Fix memory leak in pci_iov_add_virtfn()

Nicholas Johnson (9):
      PCI: Remove unnecessary braces
      PCI: Rename variables
      PCI: Pass size + alignment to pci_bus_distribute_available_resources()
      PCI: Remove local variable usage in pci_bus_distribute_available_resources()
      PCI: Consider alignment of hot-added bridges when assigning resources
      PCI: Rename extend_bridge_window() parameter
      PCI: Rename extend_bridge_window() to adjust_bridge_window()
      PCI: Set resource size directly in adjust_bridge_window()
      PCI: Allow adjust_bridge_window() to shrink resource if necessary

Sushma Kalakota (1):
      PCI: vmd: Add two VMD Device IDs

Wei Liu (1):
      PCI: iproc: Apply quirk_paxc_bridge() for module as well as built-in

Wesley Sheng (3):
      PCI/switchtec: Use dma_set_mask_and_coherent()
      PCI/switchtec: Remove redundant valid PFF number count
      PCI/switchtec: Move check event ID from mask_event() to switchtec_event_isr()

Yicong Yang (1):
      PCI/AER: Log which device prevents error recovery

Yurii Monakov (2):
      PCI: keystone: Fix link training retries initiation
      PCI: keystone: Fix outbound region mapping

Zenghui Yu (1):
      Documentation: PCI: Fix pci_alloc_irq_vectors() function name typo

 .mailmap                                           |    2 +
 Documentation/PCI/msi-howto.rst                    |    2 +-
 .../devicetree/bindings/pci/brcm,stb-pcie.yaml     |   97 ++
 .../devicetree/bindings/pci/intel-gw-pcie.yaml     |  138 +++
 .../devicetree/bindings/pci/qcom,pcie.txt          |   19 +
 MAINTAINERS                                        |    2 +-
 arch/x86/Kconfig                                   |    3 -
 arch/x86/include/asm/device.h                      |   10 -
 arch/x86/include/asm/pci.h                         |   31 +-
 arch/x86/pci/common.c                              |   48 +-
 drivers/iommu/amd_iommu.c                          |    7 +-
 drivers/iommu/intel-iommu.c                        |   11 +-
 drivers/pci/controller/Kconfig                     |   10 +-
 drivers/pci/controller/Makefile                    |    1 +
 drivers/pci/controller/dwc/Kconfig                 |   11 +
 drivers/pci/controller/dwc/Makefile                |    1 +
 drivers/pci/controller/dwc/pci-exynos.c            |    2 +-
 drivers/pci/controller/dwc/pci-keystone.c          |    6 +-
 drivers/pci/controller/dwc/pcie-artpec6.c          |    8 +-
 drivers/pci/controller/dwc/pcie-designware.c       |   56 ++
 drivers/pci/controller/dwc/pcie-designware.h       |   12 +
 drivers/pci/controller/dwc/pcie-intel-gw.c         |  545 +++++++++++
 drivers/pci/controller/dwc/pcie-qcom.c             |  150 +++
 drivers/pci/controller/dwc/pcie-uniphier.c         |   31 +-
 drivers/pci/controller/pci-tegra.c                 |    4 +-
 drivers/pci/controller/pcie-brcmstb.c              | 1015 ++++++++++++++++++++
 drivers/pci/controller/pcie-iproc.c                |   24 +
 drivers/pci/controller/vmd.c                       |  156 +--
 drivers/pci/iov.c                                  |    9 +-
 drivers/pci/p2pdma.c                               |    3 +
 drivers/pci/pci.c                                  |   48 +-
 drivers/pci/pci.h                                  |    3 +
 drivers/pci/pcie/aer.c                             |    1 +
 drivers/pci/pcie/err.c                             |   12 +-
 drivers/pci/quirks.c                               |  117 ++-
 drivers/pci/search.c                               |   10 +-
 drivers/pci/setup-bus.c                            |  163 ++--
 drivers/pci/switch/switchtec.c                     |  370 +++++--
 include/linux/pci.h                                |    3 +-
 include/linux/switchtec.h                          |  160 ++-
 include/uapi/linux/pci_regs.h                      |    1 +
 include/uapi/linux/switchtec_ioctl.h               |   17 +-
 42 files changed, 2800 insertions(+), 519 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-intel-gw.c
 create mode 100644 drivers/pci/controller/pcie-brcmstb.c
