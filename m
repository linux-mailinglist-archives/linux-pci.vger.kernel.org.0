Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B72E92DB5CE
	for <lists+linux-pci@lfdr.de>; Tue, 15 Dec 2020 22:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729470AbgLOVYD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Dec 2020 16:24:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:48776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728002AbgLOVX7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Dec 2020 16:23:59 -0500
Date:   Tue, 15 Dec 2020 15:23:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608067397;
        bh=BFJStl2cp+QJ6kRSS/u0VDJuj5rWhQ4qeSpVbh/LSQM=;
        h=From:To:Cc:Subject:From;
        b=WS0K9yi4V2xKYMmjdOgjpvds7f+mT37TKW5J+9dYxnGEKyB0YftqT057+Pz+wlwbB
         0AXHNtNa7i3GgpMOCo1Q0xDhug1w3U8QaLL6GCzk+YAzhDaIZvBkX2hN3qdIjV5ZI9
         WSh227cLuWBGEqawyHRl+Q8yHM+OotrmyQErAry165YCm/WRyzH7Jk29cBPqI3Bnt1
         q+nC5Q4hfa17ufdqFHi4nioEtelc5Vz4edRp9LikLe72OzVefzp2QR+S5w66HMHNa6
         1ZzaGY5uy1xQAI4Kfc8et+i7Kyytt1dpLMjX3KgjkPNWBJNno6HeKV4uwxZN0ynQtD
         yIqCS+xDgoXwA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [GIT PULL] PCI changes for v5.11
Message-ID: <20201215212315.GA329401@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The following changes since commit f8394f232b1eab649ce2df5c5f15b0e528c92091:

  Linux 5.10-rc3 (2020-11-08 16:10:16 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.11-changes

for you to fetch changes up to 255b2d524884e4ec60333131aa0ca0ef19826dc2:

  Merge branch 'remotes/lorenzo/pci/misc' (2020-12-15 15:11:14 -0600)

----------------------------------------------------------------

You should see a trivial conflict:

  drivers/gpu/vga/vga_switcheroo.c:
    upstream 9572e6693cd7 ("vga_switcheroo: simplify the return expression of vga_switcheroo_runtime_resume")
    PCI      99efde6c9bb7 ("PCI/PM: Rename pci_wakeup_bus() to pci_resume_bus()")

----------------------------------------------------------------

Enumeration:
  - Decode PCIe 64 GT/s link speed (Gustavo Pimentel)
  - Remove unused HAVE_PCI_SET_MWI (Heiner Kallweit)
  - Reduce pci_set_cacheline_size() message to debug level (Heiner
    Kallweit)
  - Fix pci_slot_release() NULL pointer dereference (Jubin Zhong)
  - Unify ECAM constants in native PCI Express drivers (Krzysztof
    Wilczyński)
  - Return u8 from pci_find_capability() and similar (Puranjay Mohan)
  - Return u16 from pci_find_ext_capability() and similar (Bjorn Helgaas)
  - Fix ACPI companion lookup for device 0 on the root bus (Rafael J.
    Wysocki)

Resource management:
  - Keep both device and resource name for config space remaps (Alexander
    Lobakin)
  - Bounds-check command-line resource alignment requests (Bjorn Helgaas)
  - Fix overflow in command-line resource alignment requests (Colin Ian
    King)

Driver binding:
  - Avoid duplicate IDs in driver dynamic IDs list (Zhenzhong Duan)

Power management:
  - Save/restore Precision Time Measurement Capability for suspend/resume
    (David E. Box)
  - Disable PTM during suspend to save power (David E. Box)
  - Add sysfs attribute for device power state (Maximilian Luz)
  - Rename pci_wakeup_bus() to pci_resume_bus() (Mika Westerberg)
  - Do not generate wakeup event when runtime resuming device (Mika
    Westerberg)
  - Save/restore ASPM L1SS Capability for suspend/resume (Vidya Sagar)

Virtualization:
  - Mark AMD Raven iGPU ATS as broken in some platforms (Alex Deucher)
  - Add function 1 DMA alias quirk for Marvell 9215 SATA controller (Bjorn
    Helgaas)

MSI:
  - Disable MSI for Pericom PCIe-USB adapter (Andy Shevchenko)
  - Improve warnings for 32-bit-limited MSI support (Vidya Sagar)

Error handling:
  - Cache RCEC EA Capability offset in pci_init_capabilities() (Sean V
    Kelley)
  - Rename reset_link() to reset_subordinates() (Sean V Kelley)
  - Write AER Capability only when we control it (Sean V Kelley)
  - Clear AER status only when we control AER (Sean V Kelley)
  - Bind RCEC devices to the Root Port driver (Qiuxu Zhuo)
  - Recover from RCiEP AER errors (Qiuxu Zhuo)
  - Recover from RCEC AER errors (Sean V Kelley)
  - Add pcie_link_rcec() to associate RCiEPs (Sean V Kelley)
  - Add pcie_walk_rcec() to RCEC AER handling (Sean V Kelley)
  - Add pcie_walk_rcec() to RCEC PME handling (Sean V Kelley)
  - Add RCEC AER error injection support (Qiuxu Zhuo)

Broadcom iProc PCIe controller driver:
  - Fix out-of-bound array accesses (Bharat Gooty)
  - Invalidate correct PAXB inbound windows (Roman Bacik)
  - Enhance PCIe Link information display (Srinath Mannam)

Cadence PCIe controller driver:
  - Make "cdns,max-outbound-regions" property optional (Kishon Vijay
    Abraham I)

Intel VMD host bridge driver:
  - Offset client MSI-X vectors (Jon Derrick)
  - Update type of __iomem pointers (Krzysztof Wilczyński)

NVIDIA Tegra PCIe controller driver:
  - Move "dbi" accesses to post common DWC initialization (Vidya Sagar)
  - Read "dbi" base address to program in application logic (Vidya Sagar)
  - Fix ASPM-L1SS advertisement disable code (Vidya Sagar)
  - Set DesignWare IP version (Vidya Sagar)
  - Continue unconfig sequence even if parts fail (Vidya Sagar)
  - Check return value of tegra_pcie_init_controller() (Vidya Sagar)
  - Disable LTSSM during L2 entry (Vidya Sagar)

Qualcomm PCIe controller driver:
  - Document PCIe bindings for SM8250 SoC (Manivannan Sadhasivam)
  - Add SM8250 SoC support (Manivannan Sadhasivam)
  - Add support for configuring BDF to SID mapping for SM8250 (Manivannan
    Sadhasivam)

Renesas R-Car PCIe controller driver:
  - rcar: Drop unused members from struct rcar_pcie_host (Lad Prabhakar)
  - PCI: rcar-pci-host: Document r8a774e1 bindings (Lad Prabhakar)
  - PCI: rcar-pci-host: Convert bindings to json-schema (Yoshihiro Shimoda)
  - PCI: rcar-pci-host: Document r8a77965 bindings (Yoshihiro Shimoda)

Samsung Exynos PCIe controller driver:
  - Rework driver to support Exynos5433 PCIe PHY (Jaehoon Chung)
  - Rework driver to support Exynos5433 variant (Jaehoon Chung)
  - Drop samsung,exynos5440-pcie binding (Marek Szyprowski)
  - Add the samsung,exynos-pcie binding (Marek Szyprowski)
  - Add the samsung,exynos-pcie-phy binding (Marek Szyprowski)

Synopsys DesignWare PCIe controller driver:
  - Support multiple ATU memory regions (Rob Herring)
  - Move intel-gw ATU offset out of driver match data (Rob Herring)
  - Move "dbi", "dbi2", and "addr_space" resource setup into common code
    (Rob Herring)
  - Remove intel-gw unneeded function wrappers (Rob Herring)
  - Ensure all outbound ATU windows are reset (Rob Herring)
  - Use the common MSI irq_chip in dra7xx (Rob Herring)
  - Drop the .set_num_vectors() host op (Rob Herring)
  - Move MSI interrupt setup into DWC common code (Rob Herring)
  - Rework MSI initialization (Rob Herring)
  - Move link handling into common code (Rob Herring)
  - Move dw_pcie_msi_init() into core (Rob Herring)
  - Move dw_pcie_setup_rc() to DWC common code (Rob Herring)
  - Remove unnecessary wrappers around dw_pcie_host_init() (Rob Herring)
  - Drop keystone duplicated 'num-viewport'" (Rob Herring)
  - Move inbound and outbound windows to common struct (Rob Herring)
  - Detect number of iATU windows (Rob Herring)
  - Warn if non-prefetchable memory aperture size is > 32-bit (Vidya Sagar)
  - Add support to program ATU for >4GB memory (Vidya Sagar)
  - Set 32-bit DMA mask for MSI target address allocation (Vidya Sagar)

TI J721E PCIe driver:
  - Fix "ti,syscon-pcie-ctrl" to take argument (Kishon Vijay Abraham I)
  - Add host mode dt-bindings for TI's J7200 SoC (Kishon Vijay Abraham I)
  - Add EP mode dt-bindings for TI's J7200 SoC (Kishon Vijay Abraham I)
  - Get offset within "syscon" from "ti,syscon-pcie-ctrl" phandle arg
    (Kishon Vijay Abraham I)

TI Keystone PCIe controller driver:
  - Enable compile-testing on !ARM (Alex Dewar)

----------------------------------------------------------------
Alex Deucher (1):
      PCI: Mark AMD Raven iGPU ATS as broken in some platforms

Alex Dewar (1):
      PCI: keystone: Enable compile-testing on !ARM

Alexander Lobakin (1):
      PCI: Keep both device and resource name for config space remaps

Andy Shevchenko (2):
      PCI: Disable MSI for Pericom PCIe-USB adapter
      PCI: Use predefined Pericom Vendor ID

Bharat Gooty (1):
      PCI: iproc: Fix out-of-bound array accesses

Bjorn Helgaas (25):
      PCI: ibmphp: Remove unneeded break
      PCI: Bounds-check command-line resource alignment requests
      PCI/MSI: Move MSI/MSI-X init to msi.c
      PCI/MSI: Move MSI/MSI-X flags updaters to msi.c
      PCI: Return u16 from pci_find_ext_capability() and similar
      PCI: Add function 1 DMA alias quirk for Marvell 9215 SATA controller
      Merge branch 'pci/aspm'
      Merge branch 'pci/enumeration'
      Merge branch 'pci/err'
      Merge branch 'pci/hotplug'
      Merge branch 'pci/misc'
      Merge branch 'pci/msi'
      Merge branch 'pci/pm'
      Merge branch 'pci/ptm'
      Merge branch 'pci/virtualization'
      Merge branch 'pci/ecam'
      Merge branch 'remotes/lorenzo/pci/aardvark'
      Merge branch 'remotes/lorenzo/pci/brcmstb'
      Merge branch 'remotes/lorenzo/pci/cadence'
      Merge branch 'remotes/lorenzo/pci/dwc'
      Merge branch 'remotes/lorenzo/pci/iproc'
      Merge branch 'remotes/lorenzo/pci/keystone'
      Merge branch 'remotes/lorenzo/pci/rcar'
      Merge branch 'remotes/lorenzo/pci/vmd'
      Merge branch 'remotes/lorenzo/pci/misc'

Colin Ian King (1):
      PCI: Fix overflow in command-line resource alignment requests

David E. Box (2):
      PCI/PTM: Save/restore Precision Time Measurement Capability for suspend/resume
      PCI: Disable PTM during suspend to save power

Gustavo Pimentel (2):
      MAINTAINERS: Add missing documentation references to PCI Endpoint Subsystem
      PCI: Decode PCIe 64 GT/s link speed

Heiner Kallweit (2):
      PCI: Remove unused HAVE_PCI_SET_MWI
      PCI: Reduce pci_set_cacheline_size() message to debug level

Jaehoon Chung (2):
      phy: samsung: phy-exynos-pcie: rework driver to support Exynos5433 PCIe PHY
      PCI: dwc: exynos: Rework the driver to support Exynos5433 variant

Jim Quinlan (1):
      PCI: brcmstb: Initialize "tmp" before use

Jon Derrick (1):
      PCI: vmd: Offset Client VMD MSI-X vectors

Jubin Zhong (1):
      PCI: Fix pci_slot_release() NULL pointer dereference

Kishon Vijay Abraham I (6):
      dt-bindings: PCI: Make "cdns,max-outbound-regions" optional property
      PCI: cadence: Do not error if "cdns,max-outbound-regions" is not found
      dt-bindings: pci: ti,j721e: Fix "ti,syscon-pcie-ctrl" to take argument
      dt-bindings: PCI: Add host mode dt-bindings for TI's J7200 SoC
      dt-bindings: PCI: Add EP mode dt-bindings for TI's J7200 SoC
      PCI: j721e: Get offset within "syscon" from "ti,syscon-pcie-ctrl" phandle arg

Krzysztof Wilczyński (5):
      PCI: Unify ECAM constants in native PCI Express drivers
      PCI: thunder-pem: Add constant for custom ".bus_shift" initialiser
      PCI: iproc: Convert to use the new ECAM constants
      PCI: vmd: Update type of the __iomem pointers
      PCI: xgene: Removed unused ".bus_shift" initialisers from pci-xgene.c

Lad Prabhakar (2):
      PCI: rcar: Drop unused members from struct rcar_pcie_host
      dt-bindings: PCI: rcar-pci-host: Document r8a774e1 bindings

Manivannan Sadhasivam (3):
      dt-bindings: pci: qcom: Document PCIe bindings for SM8250 SoC
      PCI: qcom: Add SM8250 SoC support
      PCI: qcom: Add support for configuring BDF to SID mapping for SM8250

Marek Szyprowski (3):
      dt-bindings: PCI: exynos: drop samsung,exynos5440-pcie binding
      dt-bindings: PCI: exynos: add the samsung,exynos-pcie binding
      dt-bindings: phy: exynos: add the samsung,exynos-pcie-phy binding

Mauro Carvalho Chehab (1):
      PCI: Fix kernel-doc markup

Maximilian Luz (1):
      PCI: Add sysfs attribute for device power state

Mika Westerberg (2):
      PCI/PM: Rename pci_wakeup_bus() to pci_resume_bus()
      PCI/PM: Do not generate wakeup event when runtime resuming device

Pali Rohár (1):
      PCI: aardvark: Update comment about disabling link training

Puranjay Mohan (1):
      PCI: Return u8 from pci_find_capability() and similar

Qiuxu Zhuo (3):
      PCI/ERR: Bind RCEC devices to the Root Port driver
      PCI/ERR: Recover from RCiEP AER errors
      PCI/AER: Add RCEC AER error injection support

Rafael J. Wysocki (1):
      PCI/ACPI: Fix companion lookup for device 0 on the root bus

Rob Herring (16):
      PCI: dwc: Support multiple ATU memory regions
      PCI: dwc/intel-gw: Move ATU offset out of driver match data
      PCI: dwc: Move "dbi", "dbi2", and "addr_space" resource setup into common code
      PCI: dwc/intel-gw: Remove some unneeded function wrappers
      PCI: dwc: Ensure all outbound ATU windows are reset
      PCI: dwc/dra7xx: Use the common MSI irq_chip
      PCI: dwc: Drop the .set_num_vectors() host op
      PCI: dwc: Move MSI interrupt setup into DWC common code
      PCI: dwc: Rework MSI initialization
      PCI: dwc: Move link handling into common code
      PCI: dwc: Move dw_pcie_msi_init() into core
      PCI: dwc: Move dw_pcie_setup_rc() to DWC common code
      PCI: dwc: Remove unnecessary wrappers around dw_pcie_host_init()
      Revert "PCI: dwc/keystone: Drop duplicated 'num-viewport'"
      PCI: dwc: Move inbound and outbound windows to common struct
      PCI: dwc: Detect number of iATU windows

Roman Bacik (1):
      PCI: iproc: Invalidate correct PAXB inbound windows

Sean V Kelley (13):
      PCI/AER: Write AER Capability only when we control it
      PCI/ERR: Cache RCEC EA Capability offset in pci_init_capabilities()
      PCI/ERR: Rename reset_link() to reset_subordinates()
      PCI/ERR: Simplify by using pci_upstream_bridge()
      PCI/ERR: Simplify by computing pci_pcie_type() once
      PCI/ERR: Use "bridge" for clarity in pcie_do_recovery()
      PCI/ERR: Avoid negated conditional for clarity
      PCI/ERR: Add pci_walk_bridge() to pcie_do_recovery()
      PCI/ERR: Clear AER status only when we control AER
      PCI/ERR: Recover from RCEC AER errors
      PCI/ERR: Add pcie_link_rcec() to associate RCiEPs
      PCI/AER: Add pcie_walk_rcec() to RCEC AER handling
      PCI/PME: Add pcie_walk_rcec() to RCEC PME handling

Srinath Mannam (1):
      PCI: iproc: Enhance PCIe Link information display

Vidya Sagar (12):
      PCI: of: Warn if non-prefetchable memory aperture size is > 32-bit
      PCI: dwc: Add support to program ATU for >4GB memory
      PCI/ASPM: Save/restore L1SS Capability for suspend/resume
      PCI: tegra: Move "dbi" accesses to post common DWC initialization
      PCI: tegra: Read "dbi" base address to program in application logic
      PCI/MSI: Set device flag indicating only 32-bit MSI support
      PCI: tegra: Fix ASPM-L1SS advertisement disable code
      PCI: tegra: Set DesignWare IP version
      PCI: tegra: Continue unconfig sequence even if parts fail
      PCI: tegra: Check return value of tegra_pcie_init_controller()
      PCI: tegra: Disable LTSSM during L2 entry
      PCI: dwc: Set 32-bit DMA mask for MSI target address allocation

Yoshihiro Shimoda (2):
      dt-bindings: PCI: rcar-pci-host: Convert bindings to json-schema
      dt-bindings: PCI: rcar-pci-host: Document r8a77965 bindings

Zhenzhong Duan (2):
      PCI: Move pci_match_device() ahead of new_id_store()
      PCI: Avoid duplicate IDs in driver dynamic IDs list

 Documentation/ABI/testing/sysfs-bus-pci            |   9 +
 .../devicetree/bindings/pci/cdns-pcie-ep.yaml      |   3 -
 .../devicetree/bindings/pci/qcom,pcie.txt          |   6 +-
 .../devicetree/bindings/pci/rcar-pci-host.yaml     | 115 ++++++
 Documentation/devicetree/bindings/pci/rcar-pci.txt |  72 ----
 .../bindings/pci/samsung,exynos-pcie.yaml          | 119 +++++++
 .../bindings/pci/samsung,exynos5440-pcie.txt       |  58 ---
 .../devicetree/bindings/pci/ti,j721e-pci-ep.yaml   |  23 +-
 .../devicetree/bindings/pci/ti,j721e-pci-host.yaml |  27 +-
 .../bindings/phy/samsung,exynos-pcie-phy.yaml      |  51 +++
 MAINTAINERS                                        |   2 +
 drivers/gpu/vga/vga_switcheroo.c                   |   2 +-
 drivers/pci/Makefile                               |   3 +-
 drivers/pci/controller/cadence/pci-j721e.c         |  28 +-
 drivers/pci/controller/cadence/pcie-cadence-ep.c   |   9 +-
 drivers/pci/controller/cadence/pcie-cadence.h      |   1 +
 drivers/pci/controller/dwc/Kconfig                 |  14 +-
 drivers/pci/controller/dwc/pci-dra7xx.c            | 141 +-------
 drivers/pci/controller/dwc/pci-exynos.c            | 389 ++++++++-------------
 drivers/pci/controller/dwc/pci-imx6.c              |  39 +--
 drivers/pci/controller/dwc/pci-keystone.c          |  79 +----
 drivers/pci/controller/dwc/pci-layerscape-ep.c     |  37 +-
 drivers/pci/controller/dwc/pci-layerscape.c        |  67 +---
 drivers/pci/controller/dwc/pci-meson.c             |  53 +--
 drivers/pci/controller/dwc/pcie-al.c               |  41 +--
 drivers/pci/controller/dwc/pcie-armada8k.c         |  37 +-
 drivers/pci/controller/dwc/pcie-artpec6.c          |  76 +---
 drivers/pci/controller/dwc/pcie-designware-ep.c    |  58 +--
 drivers/pci/controller/dwc/pcie-designware-host.c  | 147 +++++---
 drivers/pci/controller/dwc/pcie-designware-plat.c  |  70 +---
 drivers/pci/controller/dwc/pcie-designware.c       | 105 +++++-
 drivers/pci/controller/dwc/pcie-designware.h       |  27 +-
 drivers/pci/controller/dwc/pcie-hisi.c             |   2 -
 drivers/pci/controller/dwc/pcie-histb.c            |  37 +-
 drivers/pci/controller/dwc/pcie-intel-gw.c         |  67 +---
 drivers/pci/controller/dwc/pcie-kirin.c            |  62 +---
 drivers/pci/controller/dwc/pcie-qcom.c             | 127 +++++--
 drivers/pci/controller/dwc/pcie-spear13xx.c        |  62 ++--
 drivers/pci/controller/dwc/pcie-tegra194.c         | 129 +++----
 drivers/pci/controller/dwc/pcie-uniphier-ep.c      |  38 +-
 drivers/pci/controller/dwc/pcie-uniphier.c         |  51 +--
 drivers/pci/controller/pci-aardvark.c              |  22 +-
 drivers/pci/controller/pci-host-generic.c          |   1 -
 drivers/pci/controller/pci-thunder-ecam.c          |   1 -
 drivers/pci/controller/pci-thunder-pem.c           |  13 +-
 drivers/pci/controller/pci-xgene.c                 |   2 -
 drivers/pci/controller/pcie-brcmstb.c              |  17 +-
 drivers/pci/controller/pcie-iproc.c                |  60 ++--
 drivers/pci/controller/pcie-rcar-host.c            |   2 -
 drivers/pci/controller/pcie-rockchip-host.c        |  27 +-
 drivers/pci/controller/pcie-rockchip.h             |   8 +-
 drivers/pci/controller/pcie-tango.c                |   1 -
 drivers/pci/controller/pcie-xilinx-nwl.c           |   9 +-
 drivers/pci/controller/pcie-xilinx.c               |  11 +-
 drivers/pci/controller/vmd.c                       |  56 +--
 drivers/pci/ecam.c                                 |  32 +-
 drivers/pci/hotplug/ibmphp_pci.c                   |   2 -
 drivers/pci/msi.c                                  |  70 +++-
 drivers/pci/of.c                                   |   5 +
 drivers/pci/p2pdma.c                               |  10 +-
 drivers/pci/pci-acpi.c                             |  22 +-
 drivers/pci/pci-driver.c                           | 151 ++++----
 drivers/pci/pci-sysfs.c                            |  10 +
 drivers/pci/pci.c                                  | 125 ++++---
 drivers/pci/pci.h                                  |  72 ++--
 drivers/pci/pcie/Makefile                          |   2 +-
 drivers/pci/pcie/aer.c                             | 101 ++++--
 drivers/pci/pcie/aer_inject.c                      |   5 +-
 drivers/pci/pcie/aspm.c                            |  44 +++
 drivers/pci/pcie/err.c                             |  95 +++--
 drivers/pci/pcie/pme.c                             |  16 +-
 drivers/pci/pcie/portdrv_core.c                    |   9 +-
 drivers/pci/pcie/portdrv_pci.c                     |  13 +-
 drivers/pci/pcie/ptm.c                             |  60 ++++
 drivers/pci/pcie/rcec.c                            | 190 ++++++++++
 drivers/pci/probe.c                                |  30 +-
 drivers/pci/quirks.c                               |  41 ++-
 drivers/pci/slot.c                                 |  11 +-
 drivers/phy/samsung/phy-exynos-pcie.c              | 304 ++++++----------
 include/linux/pci-ecam.h                           |  27 ++
 include/linux/pci.h                                |  27 +-
 include/linux/pci_ids.h                            |   1 +
 include/uapi/linux/pci_regs.h                      |  11 +
 83 files changed, 2140 insertions(+), 2059 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/rcar-pci-host.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/rcar-pci.txt
 create mode 100644 Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/samsung,exynos5440-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/phy/samsung,exynos-pcie-phy.yaml
 create mode 100644 drivers/pci/pcie/rcec.c
