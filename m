Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDB0032446A
	for <lists+linux-pci@lfdr.de>; Wed, 24 Feb 2021 20:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235867AbhBXTKS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Feb 2021 14:10:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:40262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235981AbhBXTJU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Feb 2021 14:09:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3878D64F19;
        Wed, 24 Feb 2021 19:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614193418;
        bh=Hly0qc2rcGx5rC+eSIjorIZ9n3/XacOcce+dmg3qeDg=;
        h=Date:From:To:Cc:Subject:From;
        b=bsq7k2YK1JUFtRjsyz+mpaHQYXOlWAx56/TXIXyckaT6u/9UI9zqps6inYeSpNVbA
         Q/gGVdXsjmAyTrKvJ+71VBARVDmDo3TUWOtNXZ8Bwtr6oAhbZpDUyHt7VuEZBpNhYr
         Gwx9INQo+3JcXp1cgoFQwNMbaSqwzkhWiPY1lw5oP/P87jiIL/86Sgza5nTRnGPw3T
         yzUP+HL5TFSN/UbpmN72iMpApX/rAEFd52kXu2rFezgmrcMwJuXu3ohphz3b3Q4OjE
         REgjNNI9zklwGSx00tZc/OatUDil5WwlE9QyAszt1SvLrTHZDBEKavUQJ2vwM/xfzl
         U4St6dvqr6Zqw==
Date:   Wed, 24 Feb 2021 13:03:35 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [GIT PULL] PCI changes for v5.12
Message-ID: <20210224190335.GA1583051@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The following changes since commit 7c53f6b671f4aba70ff15e1b05148b10d58c2837:

  Linux 5.11-rc3 (2021-01-10 14:34:50 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.12-changes

for you to fetch changes up to 2bd36c391515cba855b8db8ae5708154f1082b8e:

  Merge branch 'remotes/lorenzo/pci/misc' (2021-02-24 11:17:05 -0600)

----------------------------------------------------------------

Enumeration:
  - Remove unnecessary locking around _OSC (Bjorn Helgaas)
  - Clarify message about _OSC failure (Bjorn Helgaas)
  - Remove notification of PCIe bandwidth changes (Bjorn Helgaas)
  - Tidy checking of syscall user config accessors (Heiner Kallweit)

Resource management:
  - Decline to resize resources if boot config must be preserved (Ard
    Biesheuvel)
  - Fix pci_register_io_range() memory leak (Geert Uytterhoeven)

Error handling (Keith Busch):
  - Clear error status from the correct device
  - Retain error recovery status so drivers can use it after reset
  - Log the type of Port (Root or Switch Downstream) that we reset
  - Always request a reset for Downstream Ports in frozen state

Endpoint framework and NTB (Kishon Vijay Abraham I):
  - Make *_get_first_free_bar() take into account 64 bit BAR
  - Add helper API to get the 'next' unreserved BAR
  - Make *_free_bar() return error codes on failure
  - Remove unused pci_epf_match_device()
  - Add support to associate secondary EPC with EPF
  - Add support in configfs to associate two EPCs with EPF
  - Add pci_epc_ops to map MSI IRQ
  - Add pci_epf_ops to expose function-specific attrs
  - Allow user to create sub-directory of 'EPF Device' directory
  - Implement ->msi_map_irq() ops for cadence
  - Configure LM_EP_FUNC_CFG based on epc->function_num_map for cadence
  - Add EP function driver to provide NTB functionality
  - Add support for EPF PCI Non-Transparent Bridge
  - Add specification for PCI NTB function device
  - Add PCI endpoint NTB function user guide
  - Add configfs binding documentation for pci-ntb endpoint function

Broadcom STB PCIe controller driver:
  - Add support for BCM4908 and external PERST# signal controller (Rafał
    Miłecki)

Cadence PCIe controller driver:
  - Retrain Link to work around Gen2 training defect (Nadeem Athani)
  - Fix merge botch in cdns_pcie_host_map_dma_ranges() (Krzysztof
    Wilczyński)

Freescale Layerscape PCIe controller driver:
  - Add LX2160A rev2 EP mode support (Hou Zhiqiang)
  - Convert to builtin_platform_driver() (Michael Walle)

MediaTek PCIe controller driver:
  - Fix OF node reference leak (Krzysztof Wilczyński)

Microchip PolarFlare PCIe controller driver:
  - Add Microchip PolarFire PCIe controller driver (Daire McNamara)

Qualcomm PCIe controller driver:
  - Use PHY_REFCLK_USE_PAD only for ipq8064 (Ansuel Smith)
  - Add support for ddrss_sf_tbu clock for sm8250 (Dmitry Baryshkov)

Renesas R-Car PCIe controller driver:
  - Drop PCIE_RCAR config option (Lad Prabhakar)
  - Always allocate MSI addresses in 32bit space (Marek Vasut)

Rockchip PCIe controller driver:
  - Add FriendlyARM NanoPi M4B DT binding (Chen-Yu Tsai)
  - Make 'ep-gpios' DT property optional (Chen-Yu Tsai)

Synopsys DesignWare PCIe controller driver:
  - Work around ECRC configuration hardware defect (Vidya Sagar)
  - Drop support for config space in DT 'ranges' (Rob Herring)
  - Change size to u64 for EP outbound iATU (Shradha Todi)
  - Add upper limit address for outbound iATU (Shradha Todi)
  - Make dw_pcie ops optional (Jisheng Zhang)
  - Remove unnecessary dw_pcie_ops from al driver (Jisheng Zhang)

Xilinx Versal CPM PCIe controller driver:
  - Fix OF node reference leak (Pan Bian)

Miscellaneous:
  - Remove tango host controller driver (Arnd Bergmann)
  - Remove IRQ handler & data together (altera-msi, brcmstb, dwc) (Martin
    Kaiser)
  - Fix xgene-msi race in installing chained IRQ handler (Martin Kaiser)
  - Apply CONFIG_PCI_DEBUG to entire drivers/pci hierarchy (Junhao He)
  - Fix pci-bridge-emul array overruns (Russell King)
  - Remove obsolete uses of WARN_ON(in_interrupt()) (Sebastian Andrzej
    Siewior)

----------------------------------------------------------------
Ansuel Smith (1):
      PCI: qcom: Use PHY_REFCLK_USE_PAD only for ipq8064

Ard Biesheuvel (1):
      PCI: Decline to resize resources if boot config must be preserved

Arnd Bergmann (1):
      PCI: Remove tango host controller driver

Bjorn Helgaas (28):
      PCI/ACPI: Make acpi_pci_osc_control_set() static
      PCI/ACPI: Remove unnecessary osc_lock
      PCI/ACPI: Clarify message about _OSC failure
      PCI: xgene: Fix CRS SV comment
      PCI: hv: Fix typo
      Fix "ordering" comment typos
      MAINTAINERS: Fix 'ARM/TEXAS INSTRUMENT KEYSTONE CLOCKSOURCE' capitalization
      PCI/LINK: Remove bandwidth notification
      Merge branch 'pci/enumeration'
      Merge branch 'pci/error'
      Merge branch 'pci/hotplug'
      Merge branch 'pci/link'
      Merge branch 'pci/resource'
      Merge branch 'pci/host-probe-refactor'
      Merge branch 'pci/misc'
      Merge branch 'remotes/lorenzo/pci/brcmstb'
      Merge branch 'remotes/lorenzo/pci/cadence'
      Merge branch 'pci/dwc'
      Merge branch 'pci/layerscape'
      Merge branch 'remotes/lorenzo/pci/mediatek'
      Merge branch 'pci/microchip'
      Merge branch 'pci/ntb'
      Merge branch 'pci/qcom'
      Merge branch 'remotes/lorenzo/pci/rcar'
      Merge branch 'pci/rockchip'
      Merge branch 'remotes/lorenzo/pci/tango'
      Merge branch 'remotes/lorenzo/pci/xilinx'
      Merge branch 'remotes/lorenzo/pci/misc'

Chen Lin (1):
      PCI: acpiphp: Remove unused acpiphp_callback typedef

Chen-Yu Tsai (2):
      PCI: rockchip: Make 'ep-gpios' DT property optional
      dt-bindings: arm: rockchip: Add FriendlyARM NanoPi M4B

Daire McNamara (4):
      PCI: Call platform_set_drvdata earlier in devm_pci_alloc_host_bridge
      dt-bindings: PCI: microchip: Add Microchip PolarFire host binding
      PCI: microchip: Add Microchip PolarFire PCIe controller driver
      MAINTAINERS: Add Daire McNamara as Microchip PCIe driver maintainer

Dmitry Baryshkov (2):
      dt-bindings: PCI: qcom: Document ddrss_sf_tbu clock for sm8250
      PCI: qcom: Add support for ddrss_sf_tbu clock

Geert Uytterhoeven (1):
      PCI: Fix pci_register_io_range() memory leak

Heiner Kallweit (1):
      PCI: Align checking of syscall user config accessors

Hou Zhiqiang (2):
      dt-bindings: PCI: layerscape: Add LX2160A rev2 compatible strings
      PCI: layerscape: Add LX2160A rev2 EP mode support

Jisheng Zhang (2):
      PCI: dwc: Don't assume the ops in dw_pcie always exist
      PCI: al: Remove useless dw_pcie_ops

Junhao He (1):
      PCI: Apply CONFIG_PCI_DEBUG to entire drivers/pci hierarchy

Keith Busch (5):
      PCI/ERR: Clear status of the reporting device
      PCI/AER: Clear AER status from Root Port when resetting Downstream Port
      PCI/ERR: Retain status from error notification
      PCI/AER: Specify the type of Port that was reset
      PCI/portdrv: Report reset for frozen channel

Kishon Vijay Abraham I (17):
      Documentation: PCI: Add specification for the PCI NTB function device
      PCI: endpoint: Make *_get_first_free_bar() take into account 64 bit BAR
      PCI: endpoint: Add helper API to get the 'next' unreserved BAR
      PCI: endpoint: Make *_free_bar() to return error codes on failure
      PCI: endpoint: Remove unused pci_epf_match_device()
      PCI: endpoint: Add support to associate secondary EPC with EPF
      PCI: endpoint: Add support in configfs to associate two EPCs with EPF
      PCI: endpoint: Add pci_epc_ops to map MSI IRQ
      PCI: endpoint: Add pci_epf_ops to expose function-specific attrs
      PCI: endpoint: Allow user to create sub-directory of 'EPF Device' directory
      PCI: cadence: Implement ->msi_map_irq() ops
      PCI: cadence: Configure LM_EP_FUNC_CFG based on epc->function_num_map
      PCI: endpoint: Add EP function driver to provide NTB functionality
      PCI: Add TI J721E device to PCI IDs
      NTB: Add support for EPF PCI Non-Transparent Bridge
      Documentation: PCI: Add configfs binding documentation for pci-ntb endpoint function
      Documentation: PCI: Add PCI endpoint NTB function user guide

Krzysztof Wilczyński (2):
      PCI: mediatek: Add missing of_node_put() to fix reference leak
      PCI: cadence: Fix DMA range mapping early return error

Lad Prabhakar (1):
      PCI: Drop PCIE_RCAR config option

Marek Vasut (1):
      PCI: rcar: Always allocate MSI addresses in 32bit space

Martin Hundebøll (1):
      PCI: Add Silicom Denmark vendor ID

Martin Kaiser (4):
      PCI: altera-msi: Remove IRQ handler and data in one go
      PCI: dwc: Remove IRQ handler and data in one go
      PCI: xgene-msi: Fix race in installing chained irq handler
      PCI: brcmstb: Remove chained IRQ handler and data in one go

Michael Walle (1):
      PCI: layerscape: Convert to builtin_platform_driver()

Nadeem Athani (1):
      PCI: cadence: Retrain Link to work around Gen2 training defect

Pan Bian (1):
      PCI: xilinx-cpm: Fix reference count leak on error path

Rafał Miłecki (2):
      dt-bindings: PCI: brcmstb: add BCM4908 binding
      PCI: brcmstb: support BCM4908 with external PERST# signal controller

Rob Herring (1):
      PCI: dwc: Drop support for config space in 'ranges'

Russell King (1):
      PCI: pci-bridge-emul: Fix array overruns, improve safety

Sebastian Andrzej Siewior (1):
      PCI: Remove WARN_ON(in_interrupt())

Shradha Todi (2):
      PCI: dwc: Change size to u64 for EP outbound iATU
      PCI: dwc: Add upper limit address for outbound iATU

Vidya Sagar (1):
      PCI: dwc: Work around ECRC configuration issue

 .../PCI/endpoint/function/binding/pci-ntb.rst      |   38 +
 Documentation/PCI/endpoint/index.rst               |    3 +
 Documentation/PCI/endpoint/pci-endpoint-cfs.rst    |   10 +
 Documentation/PCI/endpoint/pci-ntb-function.rst    |  348 ++++
 Documentation/PCI/endpoint/pci-ntb-howto.rst       |  161 ++
 .../devicetree/bindings/arm/rockchip.yaml          |    1 +
 .../devicetree/bindings/pci/brcm,stb-pcie.yaml     |   37 +-
 .../devicetree/bindings/pci/layerscape-pci.txt     |    1 +
 .../bindings/pci/microchip,pcie-host.yaml          |   92 +
 .../devicetree/bindings/pci/qcom,pcie.txt          |   17 +-
 MAINTAINERS                                        |    9 +-
 arch/s390/include/asm/facility.h                   |    2 +-
 drivers/acpi/pci_root.c                            |   40 +-
 drivers/gpu/drm/qxl/qxl_drv.c                      |    2 +-
 drivers/misc/pci_endpoint_test.c                   |    1 -
 drivers/net/wireless/intel/iwlwifi/fw/file.h       |    2 +-
 drivers/ntb/hw/Kconfig                             |    1 +
 drivers/ntb/hw/Makefile                            |    1 +
 drivers/ntb/hw/epf/Kconfig                         |    6 +
 drivers/ntb/hw/epf/Makefile                        |    1 +
 drivers/ntb/hw/epf/ntb_hw_epf.c                    |  753 +++++++
 drivers/pci/Makefile                               |    2 +-
 drivers/pci/controller/Kconfig                     |   35 +-
 drivers/pci/controller/Makefile                    |    2 +-
 drivers/pci/controller/cadence/pci-j721e.c         |    3 +
 drivers/pci/controller/cadence/pcie-cadence-ep.c   |   60 +-
 drivers/pci/controller/cadence/pcie-cadence-host.c |   86 +-
 drivers/pci/controller/cadence/pcie-cadence.h      |   11 +-
 drivers/pci/controller/dwc/pci-layerscape-ep.c     |    7 +
 drivers/pci/controller/dwc/pci-layerscape.c        |    5 +-
 drivers/pci/controller/dwc/pcie-al.c               |    4 -
 drivers/pci/controller/dwc/pcie-designware-ep.c    |    8 +-
 drivers/pci/controller/dwc/pcie-designware-host.c  |   53 +-
 drivers/pci/controller/dwc/pcie-designware.c       |   70 +-
 drivers/pci/controller/dwc/pcie-designware.h       |    4 +-
 drivers/pci/controller/dwc/pcie-qcom.c             |   22 +-
 drivers/pci/controller/pci-host-common.c           |    4 +-
 drivers/pci/controller/pci-hyperv.c                |    2 +-
 drivers/pci/controller/pci-xgene-msi.c             |   10 +-
 drivers/pci/controller/pci-xgene.c                 |   13 +-
 drivers/pci/controller/pcie-altera-msi.c           |    3 +-
 drivers/pci/controller/pcie-brcmstb.c              |   35 +-
 drivers/pci/controller/pcie-mediatek.c             |    7 +-
 drivers/pci/controller/pcie-microchip-host.c       | 1138 +++++++++++
 drivers/pci/controller/pcie-rcar-host.c            |    2 +-
 drivers/pci/controller/pcie-rockchip.c             |   12 +-
 drivers/pci/controller/pcie-tango.c                |  341 ----
 drivers/pci/controller/pcie-xilinx-cpm.c           |    1 +
 drivers/pci/endpoint/functions/Kconfig             |   13 +
 drivers/pci/endpoint/functions/Makefile            |    1 +
 drivers/pci/endpoint/functions/pci-epf-ntb.c       | 2128 ++++++++++++++++++++
 drivers/pci/endpoint/functions/pci-epf-test.c      |   13 +-
 drivers/pci/endpoint/pci-ep-cfs.c                  |  176 +-
 drivers/pci/endpoint/pci-epc-core.c                |  130 +-
 drivers/pci/endpoint/pci-epf-core.c                |  105 +-
 drivers/pci/hotplug/acpiphp.h                      |    3 -
 drivers/pci/pci-bridge-emul.c                      |   11 +-
 drivers/pci/pci.c                                  |    4 +
 drivers/pci/pcie/Kconfig                           |    8 -
 drivers/pci/pcie/Makefile                          |    1 -
 drivers/pci/pcie/aer.c                             |    5 +-
 drivers/pci/pcie/bw_notification.c                 |  138 --
 drivers/pci/pcie/err.c                             |   16 +-
 drivers/pci/pcie/portdrv.h                         |    6 -
 drivers/pci/pcie/portdrv_pci.c                     |    4 +-
 drivers/pci/search.c                               |    4 -
 drivers/pci/setup-res.c                            |    6 +
 drivers/pci/syscall.c                              |   10 +-
 include/linux/acpi.h                               |    3 -
 include/linux/pci-epc.h                            |   39 +-
 include/linux/pci-epf.h                            |   28 +-
 include/linux/pci_ids.h                            |    3 +
 lib/logic_pio.c                                    |    3 +
 73 files changed, 5543 insertions(+), 781 deletions(-)
 create mode 100644 Documentation/PCI/endpoint/function/binding/pci-ntb.rst
 create mode 100644 Documentation/PCI/endpoint/pci-ntb-function.rst
 create mode 100644 Documentation/PCI/endpoint/pci-ntb-howto.rst
 create mode 100644 Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
 create mode 100644 drivers/ntb/hw/epf/Kconfig
 create mode 100644 drivers/ntb/hw/epf/Makefile
 create mode 100644 drivers/ntb/hw/epf/ntb_hw_epf.c
 create mode 100644 drivers/pci/controller/pcie-microchip-host.c
 delete mode 100644 drivers/pci/controller/pcie-tango.c
 create mode 100644 drivers/pci/endpoint/functions/pci-epf-ntb.c
 delete mode 100644 drivers/pci/pcie/bw_notification.c
