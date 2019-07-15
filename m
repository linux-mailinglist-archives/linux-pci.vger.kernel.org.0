Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F96F69B53
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2019 21:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730450AbfGOT1H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Jul 2019 15:27:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:49160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730322AbfGOT1H (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 Jul 2019 15:27:07 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 367DD2081C;
        Mon, 15 Jul 2019 19:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563218825;
        bh=w47sUIQfeALAyD7hUd9Yb9VtYDDuZGssxv8BADnMD6w=;
        h=Date:From:To:Cc:Subject:From;
        b=VuH3kB1s/kLlx5OeTQMprOY7laIQq7m4e2bM7+1kb8/WRf8wwDCVeKVCQwl8anYGk
         pGYECccCnrbA7Ta48K2iPzQj0Prb4XTn96Uuuf81YgoBqYHTN/t2cxM9Um4LnfY3a9
         1etyxOligEPeTeW4hPJDmJkND2W7PjW+oGkvwTBM=
Date:   Mon, 15 Jul 2019 14:27:02 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [GIT PULL] PCI changes for v5.3
Message-ID: <20190715192702.GF46935@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.3-changes

for you to fetch changes up to 7b4b0f6b34d893be569da81ffad865a9d3a7d014:

  Merge branch 'pci/trivial' (2019-07-12 17:08:41 -0500)

----------------------------------------------------------------

You should see one trivial conflict in Documentation/index.rst


Enumeration changes:

  - Evaluate PCI Boot Configuration _DSM to learn if firmware wants us
    to preserve its resource assignments (Benjamin Herrenschmidt)

  - Simplify resource distribution (Nicholas Johnson)

  - Decode 32 GT/s link speed (Gustavo Pimentel)

Virtualization:

  - Fix incorrect caching of VF config space size (Alex Williamson)

  - Fix VF driver probing sysfs knobs (Alex Williamson)

Peer-to-peer DMA:

  - Fix dma_virt_ops check (Logan Gunthorpe)

Altera host bridge driver:

  - Allow building as module (Ley Foon Tan)

Armada 8K host bridge driver:

  - add PHYs support (Miquel Raynal)

DesignWare host bridge driver:

  - Export APIs to support removable loadable module (Vidya Sagar)

  - Enable Relaxed Ordering erratum workaround only on Tegra20 &
    Tegra30 (Vidya Sagar)

Hyper-V host bridge driver:

  - Fix use-after-free in eject (Dexuan Cui)

Mobiveil host bridge driver:

  - Clean up and fix many issues, including non-identify mapped
    windows, 64-bit windows, multi-MSI, class code, INTx clearing (Hou
    Zhiqiang)

Qualcomm host bridge driver:

  - Use clk bulk API for 2.4.0 controllers (Bjorn Andersson)

  - Add QCS404 support (Bjorn Andersson)

  - Assert PERST for at least 100ms (Niklas Cassel)

R-Car host bridge driver:

  - Add r8a774a1 DT support (Biju Das)

Tegra host bridge driver:

  - Add support for Gen2, opportunistic UpdateFC and ACK (PCIe
    protocol details) AER, GPIO-based PERST# (Manikanta Maddireddy)

  - Fix many issues, including power-on failure cases, interrupt
    masking in suspend, UPHY settings, AFI dynamic clock gating,
    pending DLL transactions (Manikanta Maddireddy)

Xilinx host bridge driver:

  - Fix NWL Multi-MSI programming (Bharat Kumar Gogada)

Endpoint support:

  - Fix 64bit BAR support (Alan Mikhak)

  - Fix pcitest build issues (Alan Mikhak, Andy Shevchenko)

Bug fixes:

  - Fix NVIDIA GPU multi-function power dependencies (Abhishek Sahu)

  - Fix NVIDIA GPU HDA enablement issue (Lukas Wunner)

  - Ignore lockdep for sysfs "remove" (Marek Vasut)

Misc:

  - Convert docs to reST (Changbin Du, Mauro Carvalho Chehab)


----------------------------------------------------------------
Abhishek Sahu (2):
      PCI: Generalize multi-function power dependency device links
      PCI: Add NVIDIA GPU multi-function power dependencies

Alan Mikhak (6):
      tools: PCI: Fix broken pcitest compilation
      tools: PCI: Fix compiler warning in pcitest
      PCI: endpoint: Set endpoint controller pointer to NULL
      PCI: endpoint: Allocate enough space for fixed size BAR
      PCI: endpoint: Skip odd BAR when skipping 64bit BAR
      PCI: endpoint: Clear BAR before freeing its space

Alex Williamson (4):
      PCI: Return error if cannot probe VF
      PCI: Always allow probing with driver_override
      Revert "PCI/IOV: Use VF0 cached config space size for other VFs"
      PCI/IOV: Assume SR-IOV VFs support extended config space.

Andy Shevchenko (1):
      tools: PCI: Fix installation when `make tools/pci_install`

Benjamin Herrenschmidt (4):
      PCI/ACPI: Evaluate PCI Boot Configuration _DSM
      PCI: Don't auto-realloc if we're preserving firmware config
      arm64: PCI: Allow resource reallocation if necessary
      arm64: PCI: Preserve firmware configuration when desired

Bharat Kumar Gogada (1):
      PCI: xilinx-nwl: Fix Multi MSI data programming

Biju Das (1):
      dt-bindings: PCI: rcar: Add device tree support for r8a774a1

Bjorn Andersson (3):
      PCI: qcom: Use clk bulk API for 2.4.0 controllers
      dt-bindings: PCI: qcom: Add QCS404 to the binding
      PCI: qcom: Add QCS404 PCIe controller support

Bjorn Helgaas (19):
      PCI: Fix typos and whitespace errors
      Merge branch 'pci/docs'
      Merge branch 'pci/enumeration'
      Merge branch 'pci/misc'
      Merge branch 'pci/peer-to-peer'
      Merge branch 'pci/resource'
      Merge branch 'pci/virtualization'
      Merge branch 'remotes/lorenzo/pci/altera'
      Merge branch 'remotes/lorenzo/pci/armada'
      Merge branch 'remotes/lorenzo/pci/dwc'
      Merge branch 'remotes/lorenzo/pci/hv'
      Merge branch 'remotes/lorenzo/pci/mobiveil'
      Merge branch 'remotes/lorenzo/pci/qcom'
      Merge branch 'remotes/lorenzo/pci/rcar'
      Merge branch 'remotes/lorenzo/pci/tegra'
      Merge branch 'remotes/lorenzo/pci/xilinx'
      Merge branch 'remotes/lorenzo/pci/endpoint'
      Merge branch 'remotes/lorenzo/pci/misc'
      Merge branch 'pci/trivial'

Changbin Du (12):
      Documentation: add Linux PCI to Sphinx TOC tree
      Documentation: PCI: convert pci.txt to reST
      Documentation: PCI: convert PCIEBUS-HOWTO.txt to reST
      Documentation: PCI: convert pci-iov-howto.txt to reST
      Documentation: PCI: convert MSI-HOWTO.txt to reST
      Documentation: PCI: convert acpi-info.txt to reST
      Documentation: PCI: convert pci-error-recovery.txt to reST
      Documentation: PCI: convert pcieaer-howto.txt to reST
      Documentation: PCI: convert endpoint/pci-endpoint.txt to reST
      Documentation: PCI: convert endpoint/pci-endpoint-cfs.txt to reST
      Documentation: PCI: convert endpoint/pci-test-function.txt to reST
      Documentation: PCI: convert endpoint/pci-test-howto.txt to reST

Dexuan Cui (1):
      PCI: hv: Fix a use-after-free bug in hv_eject_device_work()

Gustavo Pimentel (1):
      PCI: Decode PCIe 32 GT/s link speed

Hou Zhiqiang (27):
      PCI: mobiveil: Unify register accessors
      PCI: mobiveil: Remove the flag MSI_FLAG_MULTI_PCI_MSI
      PCI: mobiveil: Fix PCI base address in MEM/IO outbound windows
      PCI: mobiveil: Update the resource list traversal function
      PCI: mobiveil: Use WIN_NUM_0 explicitly for CFG outbound window
      PCI: mobiveil: Use the 1st inbound window for MEM inbound transactions
      PCI: mobiveil: Fix the Class Code field
      PCI: mobiveil: Move the link up waiting out of mobiveil_host_init()
      PCI: mobiveil: Move IRQ chained handler setup out of DT parse
      PCI: mobiveil: Initialize Primary/Secondary/Subordinate bus numbers
      PCI: mobiveil: Fix devfn check in mobiveil_pcie_valid_device()
      dt-bindings: PCI: mobiveil: Change gpio_slave and apb_csr to optional
      PCI: mobiveil: Reformat the code for readability
      PCI: mobiveil: Make some register updates more readable
      PCI: mobiveil: Refactor the MEM/IO outbound window initialization
      PCI: mobiveil: Fix error return values
      PCI: mobiveil: Remove an unnecessary return value check
      PCI: mobiveil: Clean-up program_{ib/ob}_windows()
      PCI: mobiveil: Fix the valid check for inbound and outbound windows
      PCI: mobiveil: Add configured inbound windows counter
      PCI: mobiveil: Clear the control fields before updating it
      PCI: mobiveil: Mask out hardcoded bits in inbound/outbound windows setup
      PCI: mobiveil: Add upper 32-bit CPU base address setup in outbound window
      PCI: mobiveil: Add upper 32-bit PCI base address setup in inbound window
      PCI: mobiveil: Move PCIe PIO enablement out of inbound window routine
      PCI: mobiveil: Fix infinite-loop in the INTx handling function
      PCI: mobiveil: Fix INTx interrupt clearing in mobiveil_pcie_isr()

Leonard Crestez (1):
      PCI: imx6: Simplify Kconfig depends on

Ley Foon Tan (3):
      PCI: altera: Allow building as module
      PCI: altera-msi: Allow building as module
      PCI: altera: Fix configuration type based on secondary number

Logan Gunthorpe (1):
      PCI/P2PDMA: Fix missing check for dma_virt_ops

Lukas Wunner (1):
      PCI: Enable NVIDIA HDA controllers

Manikanta Maddireddy (25):
      soc/tegra: pmc: Export tegra_powergate_power_on()
      PCI: tegra: Handle failure cases in tegra_pcie_power_on()
      PCI: tegra: Rearrange Tegra PCIe driver functions
      PCI: tegra: Mask AFI_INTR in runtime suspend
      PCI: tegra: Fix PCIe host power up sequence
      PCI: tegra: Add PCIe Gen2 link speed support
      PCI: tegra: Advertise PCIe Advanced Error Reporting (AER) capability
      PCI: tegra: Program UPHY electrical settings for Tegra210
      PCI: tegra: Enable opportunistic UpdateFC and ACK
      PCI: tegra: Disable AFI dynamic clock gating
      PCI: tegra: Process pending DLL transactions before entering L1 or L2
      PCI: tegra: Enable PCIe xclk clock clamping
      PCI: tegra: Increase the deskew retry time
      PCI: tegra: Add SW fixup for RAW violations
      PCI: tegra: Update flow control timer frequency in Tegra210
      PCI: tegra: Set target speed as Gen1 before starting LTSSM
      PCI: tegra: Fix PLLE power down issue due to CLKREQ# signal
      PCI: tegra: Program AFI_CACHE_BAR_{0,1}_{ST,SZ} registers only for Tegra20
      PCI: tegra: Change PRSNT_SENSE IRQ log to debug
      PCI: tegra: Add AFI_PEX2_CTRL reg offset as part of SoC struct
      dt-bindings: pci: tegra: Document PCIe DPD pinctrl optional prop
      PCI: tegra: Put PEX CLK & BIAS pads in DPD mode
      PCI: Add DT binding for "reset-gpios" property
      PCI: tegra: Add support for GPIO based PERST#
      PCI: tegra: Change link retry log level to debug

Marek Vasut (1):
      PCI: sysfs: Ignore lockdep for remove attribute

Markus Elfring (1):
      PCI: Use seq_puts() instead of seq_printf() in show_device()

Mauro Carvalho Chehab (1):
      docs: power: convert docs to ReST and rename to *.rst

Miquel Raynal (1):
      PCI: armada8k: Add PHYs support

Nicholas Johnson (2):
      PCI: Simplify pci_bus_distribute_available_resources()
      PCI: Skip resource distribution when no hotplug bridges

Niklas Cassel (1):
      PCI: qcom: Ensure that PERST is asserted for at least 100 ms

Vidya Sagar (4):
      PCI: dwc: Add API support to de-initialize host
      PCI: dwc: Cleanup DBI,ATU read and write APIs
      PCI: dwc: Export APIs to support .remove() implementation
      PCI: tegra: Enable Relaxed Ordering only for Tegra20 & Tegra30

YueHaibing (1):
      PCI: dwc: pci-dra7xx: Fix compilation when !CONFIG_GPIOLIB

 Documentation/ABI/testing/sysfs-class-powercap     |   2 +-
 Documentation/PCI/{acpi-info.txt => acpi-info.rst} |  15 +-
 Documentation/PCI/endpoint/index.rst               |  13 +
 .../{pci-endpoint-cfs.txt => pci-endpoint-cfs.rst} |  99 ++--
 .../{pci-endpoint.txt => pci-endpoint.rst}         |  92 ++--
 ...pci-test-function.txt => pci-test-function.rst} |  84 +--
 .../{pci-test-howto.txt => pci-test-howto.rst}     |  81 ++-
 Documentation/PCI/index.rst                        |  18 +
 Documentation/PCI/{MSI-HOWTO.txt => msi-howto.rst} |  85 +--
 ...i-error-recovery.txt => pci-error-recovery.rst} | 287 +++++-----
 .../PCI/{pci-iov-howto.txt => pci-iov-howto.rst}   | 161 +++---
 Documentation/PCI/{pci.txt => pci.rst}             | 356 ++++++-------
 .../PCI/{pcieaer-howto.txt => pcieaer-howto.rst}   | 156 ++++--
 .../PCI/{PCIEBUS-HOWTO.txt => picebus-howto.rst}   | 140 ++---
 Documentation/admin-guide/kernel-parameters.txt    |   6 +-
 Documentation/cpu-freq/core.txt                    |   2 +-
 .../devicetree/bindings/pci/mobiveil-pcie.txt      |   2 +
 .../bindings/pci/nvidia,tegra20-pcie.txt           |   8 +
 Documentation/devicetree/bindings/pci/pci.txt      |   3 +
 .../devicetree/bindings/pci/qcom,pcie.txt          |  25 +-
 Documentation/devicetree/bindings/pci/rcar-pci.txt |   1 +
 Documentation/driver-api/pm/devices.rst            |   6 +-
 Documentation/driver-api/usb/power-management.rst  |   2 +-
 Documentation/index.rst                            |   1 +
 Documentation/power/{apm-acpi.txt => apm-acpi.rst} |  10 +-
 ...sic-pm-debugging.txt => basic-pm-debugging.rst} |  79 +--
 .../{charger-manager.txt => charger-manager.rst}   | 105 ++--
 .../{drivers-testing.txt => drivers-testing.rst}   |  15 +-
 .../power/{energy-model.txt => energy-model.rst}   | 105 ++--
 ...freezing-of-tasks.txt => freezing-of-tasks.rst} |  91 ++--
 Documentation/power/index.rst                      |  46 ++
 .../power/{interface.txt => interface.rst}         |  24 +-
 Documentation/power/{opp.txt => opp.rst}           | 175 +++---
 Documentation/power/{pci.txt => pci.rst}           |  87 ++-
 .../{pm_qos_interface.txt => pm_qos_interface.rst} | 127 +++--
 Documentation/power/power_supply_class.rst         | 282 ++++++++++
 Documentation/power/power_supply_class.txt         | 231 --------
 Documentation/power/powercap/powercap.rst          | 257 +++++++++
 Documentation/power/powercap/powercap.txt          | 236 ---------
 .../power/regulator/{consumer.txt => consumer.rst} | 141 ++---
 .../power/regulator/{design.txt => design.rst}     |   9 +-
 .../power/regulator/{machine.txt => machine.rst}   |  47 +-
 .../power/regulator/{overview.txt => overview.rst} |  57 +-
 Documentation/power/regulator/regulator.rst        |  32 ++
 Documentation/power/regulator/regulator.txt        |  30 --
 .../power/{runtime_pm.txt => runtime_pm.rst}       | 234 ++++----
 Documentation/power/{s2ram.txt => s2ram.rst}       |  20 +-
 ...d-cpuhotplug.txt => suspend-and-cpuhotplug.rst} |  42 +-
 ...d-interrupts.txt => suspend-and-interrupts.rst} |   2 +
 ...nd-swap-files.txt => swsusp-and-swap-files.rst} |  17 +-
 .../{swsusp-dmcrypt.txt => swsusp-dmcrypt.rst}     | 122 ++---
 Documentation/power/swsusp.rst                     | 501 ++++++++++++++++++
 Documentation/power/swsusp.txt                     | 446 ----------------
 Documentation/power/{tricks.txt => tricks.rst}     |   6 +-
 .../{userland-swsusp.txt => userland-swsusp.rst}   |  55 +-
 Documentation/power/{video.txt => video.rst}       | 156 +++---
 Documentation/process/submitting-drivers.rst       |   2 +-
 Documentation/scheduler/sched-energy.txt           |   6 +-
 Documentation/trace/coresight-cpu-debug.txt        |   2 +-
 .../zh_CN/process/submitting-drivers.rst           |   2 +-
 MAINTAINERS                                        |   8 +-
 arch/arm64/kernel/pci.c                            |  13 +-
 arch/x86/Kconfig                                   |   2 +-
 drivers/acpi/pci_root.c                            |  12 +
 drivers/gpu/drm/i915/i915_drv.h                    |   2 +-
 drivers/opp/Kconfig                                |   2 +-
 drivers/pci/ats.c                                  |   2 +-
 drivers/pci/controller/Kconfig                     |   4 +-
 drivers/pci/controller/dwc/Kconfig                 |   2 +-
 drivers/pci/controller/dwc/pci-dra7xx.c            |   1 +
 drivers/pci/controller/dwc/pcie-armada8k.c         |  84 ++-
 drivers/pci/controller/dwc/pcie-designware-host.c  |  12 +
 drivers/pci/controller/dwc/pcie-designware.c       |  61 ++-
 drivers/pci/controller/dwc/pcie-designware.h       |  39 +-
 drivers/pci/controller/dwc/pcie-kirin.c            |   2 +-
 drivers/pci/controller/dwc/pcie-qcom.c             | 115 ++--
 drivers/pci/controller/pci-aardvark.c              |   2 +-
 drivers/pci/controller/pci-hyperv.c                |  15 +-
 drivers/pci/controller/pci-tegra.c                 | 589 ++++++++++++++++++---
 drivers/pci/controller/pcie-altera-msi.c           |  10 +
 drivers/pci/controller/pcie-altera.c               |  69 ++-
 drivers/pci/controller/pcie-iproc-platform.c       |   2 +-
 drivers/pci/controller/pcie-iproc.c                |   2 +-
 drivers/pci/controller/pcie-mobiveil.c             | 525 ++++++++++--------
 drivers/pci/controller/pcie-xilinx-nwl.c           |  11 +-
 drivers/pci/controller/vmd.c                       |   2 +-
 drivers/pci/endpoint/functions/pci-epf-test.c      |  35 +-
 drivers/pci/endpoint/pci-epc-core.c                |   3 +-
 drivers/pci/iov.c                                  |   2 -
 drivers/pci/mmap.c                                 |   2 +-
 drivers/pci/msi.c                                  |  43 +-
 drivers/pci/p2pdma.c                               |  16 +-
 drivers/pci/pci-bridge-emul.c                      |   2 +-
 drivers/pci/pci-driver.c                           |  16 +-
 drivers/pci/pci-pf-stub.c                          |   2 +-
 drivers/pci/pci-sysfs.c                            |   5 +-
 drivers/pci/pci.c                                  |   6 +-
 drivers/pci/pci.h                                  |   1 -
 drivers/pci/pcie/aer_inject.c                      |   2 +-
 drivers/pci/probe.c                                |  28 +-
 drivers/pci/proc.c                                 |   2 +-
 drivers/pci/quirks.c                               | 110 +++-
 drivers/pci/setup-bus.c                            |  60 ++-
 drivers/pci/slot.c                                 |   1 +
 drivers/power/supply/power_supply_core.c           |   2 +-
 drivers/soc/tegra/pmc.c                            |   1 +
 include/linux/interrupt.h                          |   2 +-
 include/linux/mod_devicetable.h                    |  29 +-
 include/linux/pci-acpi.h                           |   7 +-
 include/linux/pci.h                                |  53 +-
 include/linux/pci_ids.h                            |   7 +-
 include/linux/pm.h                                 |   2 +-
 include/uapi/linux/pci_regs.h                      |   4 +
 kernel/power/Kconfig                               |   6 +-
 net/wireless/Kconfig                               |   2 +-
 tools/pci/Makefile                                 |   5 +-
 tools/pci/pcitest.c                                |   8 +-
 117 files changed, 4502 insertions(+), 2994 deletions(-)
 rename Documentation/PCI/{acpi-info.txt => acpi-info.rst} (96%)
 create mode 100644 Documentation/PCI/endpoint/index.rst
 rename Documentation/PCI/endpoint/{pci-endpoint-cfs.txt => pci-endpoint-cfs.rst} (64%)
 rename Documentation/PCI/endpoint/{pci-endpoint.txt => pci-endpoint.rst} (83%)
 rename Documentation/PCI/endpoint/{pci-test-function.txt => pci-test-function.rst} (55%)
 rename Documentation/PCI/endpoint/{pci-test-howto.txt => pci-test-howto.rst} (78%)
 create mode 100644 Documentation/PCI/index.rst
 rename Documentation/PCI/{MSI-HOWTO.txt => msi-howto.rst} (88%)
 rename Documentation/PCI/{pci-error-recovery.txt => pci-error-recovery.rst} (67%)
 rename Documentation/PCI/{pci-iov-howto.txt => pci-iov-howto.rst} (63%)
 rename Documentation/PCI/{pci.txt => pci.rst} (68%)
 rename Documentation/PCI/{pcieaer-howto.txt => pcieaer-howto.rst} (72%)
 rename Documentation/PCI/{PCIEBUS-HOWTO.txt => picebus-howto.rst} (70%)
 rename Documentation/power/{apm-acpi.txt => apm-acpi.rst} (87%)
 rename Documentation/power/{basic-pm-debugging.txt => basic-pm-debugging.rst} (87%)
 rename Documentation/power/{charger-manager.txt => charger-manager.rst} (78%)
 rename Documentation/power/{drivers-testing.txt => drivers-testing.rst} (86%)
 rename Documentation/power/{energy-model.txt => energy-model.rst} (74%)
 rename Documentation/power/{freezing-of-tasks.txt => freezing-of-tasks.rst} (75%)
 create mode 100644 Documentation/power/index.rst
 rename Documentation/power/{interface.txt => interface.rst} (84%)
 rename Documentation/power/{opp.txt => opp.rst} (78%)
 rename Documentation/power/{pci.txt => pci.rst} (97%)
 rename Documentation/power/{pm_qos_interface.txt => pm_qos_interface.rst} (62%)
 create mode 100644 Documentation/power/power_supply_class.rst
 delete mode 100644 Documentation/power/power_supply_class.txt
 create mode 100644 Documentation/power/powercap/powercap.rst
 delete mode 100644 Documentation/power/powercap/powercap.txt
 rename Documentation/power/regulator/{consumer.txt => consumer.rst} (61%)
 rename Documentation/power/regulator/{design.txt => design.rst} (86%)
 rename Documentation/power/regulator/{machine.txt => machine.rst} (75%)
 rename Documentation/power/regulator/{overview.txt => overview.rst} (79%)
 create mode 100644 Documentation/power/regulator/regulator.rst
 delete mode 100644 Documentation/power/regulator/regulator.txt
 rename Documentation/power/{runtime_pm.txt => runtime_pm.rst} (89%)
 rename Documentation/power/{s2ram.txt => s2ram.rst} (92%)
 rename Documentation/power/{suspend-and-cpuhotplug.txt => suspend-and-cpuhotplug.rst} (90%)
 rename Documentation/power/{suspend-and-interrupts.txt => suspend-and-interrupts.rst} (98%)
 rename Documentation/power/{swsusp-and-swap-files.txt => swsusp-and-swap-files.rst} (83%)
 rename Documentation/power/{swsusp-dmcrypt.txt => swsusp-dmcrypt.rst} (67%)
 create mode 100644 Documentation/power/swsusp.rst
 delete mode 100644 Documentation/power/swsusp.txt
 rename Documentation/power/{tricks.txt => tricks.rst} (93%)
 rename Documentation/power/{userland-swsusp.txt => userland-swsusp.rst} (85%)
 rename Documentation/power/{video.txt => video.rst} (56%)
