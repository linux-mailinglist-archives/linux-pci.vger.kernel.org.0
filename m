Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D12E6446776
	for <lists+linux-pci@lfdr.de>; Fri,  5 Nov 2021 18:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbhKERC7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Nov 2021 13:02:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:34918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229763AbhKERC6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Nov 2021 13:02:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 58B5F610D0;
        Fri,  5 Nov 2021 17:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636131618;
        bh=ilO8+x+wKXsqAz7WKiLJVYLwzZK7u7DLUNg+FsYTCD4=;
        h=Date:From:To:Cc:Subject:From;
        b=V67yGbuK+6wknkTMYDyYJ8ObVtf2YsygFLInOascT73U7DSFvIeydHrv/w8q1Bw15
         6CvDEkdJYy6JbR1cfO6yZZSPfENY2mSQnLccoZJb2ZLEQWnAqDzotd8AgWHKhHDZPu
         cv+DcjhHrT40g7GwXQSCEkgIyzPVFEVORAS4JSHi+tSCop89qLSHc90kkig8CSo95m
         AeyLIRHogOFaqSfCeCRkV19jBF+8lI0zT3cU8ISMBNfYpOvT+Lpv4DFDRpeIzLXhW1
         hUS1Cxqp9RFtvt1dU9bz0ZcxX9ymXmLvDLMdYYNDEdO6TvVN6+vEQiOyHQW73+yvE7
         65vS7w20MCUFA==
Date:   Fri, 5 Nov 2021 12:00:17 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [GIT PULL] PCI changes for v5.16
Message-ID: <20211105170017.GA929912@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The following changes since commit e4e737bb5c170df6135a127739a9e6148ee3da82:

  Linux 5.15-rc2 (2021-09-19 17:28:22 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.16-changes

for you to fetch changes up to dda4b381f05d447a0ae31e2e44aeb35d313a311f:

  Merge branch 'remotes/lorenzo/pci/xgene' (2021-11-05 11:28:53 -0500)

----------------------------------------------------------------

I don't think you'll see any conflicts, but you will see an apple-dart.c
build failure unless you add the patch below.  b2b2781a9755 ("iommu/dart:
Clean up IOVA cookie crumbs") removed an #include that is now required
again by 946d619fa25f ("iommu/dart: Exclude MSI doorbell from PCIe device
IOVA range")

  diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
  index b7265a8e9540..565ef5598811 100644
  --- a/drivers/iommu/apple-dart.c
  +++ b/drivers/iommu/apple-dart.c
  @@ -15,6 +15,7 @@
   #include <linux/bitfield.h>
   #include <linux/clk.h>
   #include <linux/dev_printk.h>
  +#include <linux/dma-iommu.h>
   #include <linux/dma-mapping.h>
   #include <linux/err.h>
   #include <linux/interrupt.h>

----------------------------------------------------------------

Enumeration:
  - Conserve IRQs by setting up portdrv IRQs only when there are users (Jan
    Kiszka)
  - Rework and simplify _OSC negotiation for control of PCIe features
    (Joerg Roedel)
  - Remove struct pci_dev.driver pointer since it's redundant with the
    struct device.driver pointer (Uwe Kleine-König)

Resource management:
  - Coalesce contiguous host bridge apertures from _CRS to accommodate BARs
    that cover more than one aperture (Kai-Heng Feng)

Sysfs:
  - Check CAP_SYS_ADMIN before parsing user input (Krzysztof Wilczyński)
  - Return -EINVAL consistently from "store" functions (Krzysztof
    Wilczyński)
  - Use sysfs_emit() in endpoint "show" functions to avoid buffer overruns
    (Kunihiko Hayashi)

PCIe native device hotplug:
  - Ignore Link Down/Up caused by resets during error recovery so endpoint
    drivers can remain bound to the device (Lukas Wunner)

Virtualization:
  - Avoid bus resets on Atheros QCA6174, where they hang the device (Ingmar
    Klein)
  - Work around Pericom PI7C9X2G switch packet drop erratum by using store
    and forward mode instead of cut-through (Nathan Rossi)
  - Avoid trying to enable AtomicOps on VFs; the PF setting applies to all
    VFs (Selvin Xavier)

MSI:
  - Document that /sys/bus/pci/devices/.../irq contains the legacy INTx
    interrupt or the IRQ of the first MSI (not MSI-X) vector (Barry Song)

VPD:
  - Add pci_read_vpd_any() and pci_write_vpd_any() to access anywhere in
    the possible VPD space; use these to simplify the cxgb3 driver (Heiner
    Kallweit)

Peer-to-peer DMA:
  - Add (not subtract) the bus offset when calculating DMA address (Wang
    Lu)

ASPM:
  - Re-enable LTR at Downstream Ports so they don't report Unsupported
    Requests when reset or hot-added devices send LTR messages (Mingchuang
    Qiao)

Apple PCIe controller driver:
  - Add driver for Apple M1 PCIe controller (Alyssa Rosenzweig, Marc
    Zyngier)

Cadence PCIe controller driver:
  - Return success when probe succeeds instead of falling into error path
    (Li Chen)

HiSilicon Kirin PCIe controller driver:
  - Reorganize PHY logic and add support for external PHY drivers (Mauro
    Carvalho Chehab)
  - Support PERST# GPIOs for HiKey970 external PEX 8606 bridge (Mauro
    Carvalho Chehab)
  - Add Kirin 970 support (Mauro Carvalho Chehab)
  - Make driver removable (Mauro Carvalho Chehab)

Intel VMD host bridge driver:
  - If IOMMU supports interrupt remapping, leave VMD MSI-X remapping
    enabled (Adrian Huang)
  - Number each controller so we can tell them apart in /proc/interrupts
    (Chunguang Xu)
  - Avoid building on UML because VMD depends on x86 bare metal APIs
    (Johannes Berg)

Marvell Aardvark PCIe controller driver:
  - Define macros for PCI_EXP_DEVCTL_PAYLOAD_* (Pali Rohár)
  - Set Max Payload Size to 512 bytes per Marvell spec (Pali Rohár)
  - Downgrade PIO Response Status messages to debug level (Marek Behún)
  - Preserve CRS SV (Config Request Retry Software Visibility) bit in
    emulated Root Control register (Pali Rohár)
  - Fix issue in configuring reference clock (Pali Rohár)
  - Don't clear status bits for masked interrupts (Pali Rohár)
  - Don't mask unused interrupts (Pali Rohár)
  - Avoid code repetition in advk_pcie_rd_conf() (Marek Behún)
  - Retry config accesses on CRS response (Pali Rohár)
  - Simplify emulated Root Capabilities initialization (Pali Rohár)
  - Fix several link training issues (Pali Rohár)
  - Fix link-up checking via LTSSM (Pali Rohár)
  - Fix reporting of Data Link Layer Link Active (Pali Rohár)
  - Fix emulation of W1C bits (Marek Behún)
  - Fix MSI domain .alloc() method to return zero on success (Marek Behún)
  - Read entire 16-bit MSI vector in MSI handler, not just low 8 bits (Marek
    Behún)
  - Clear Root Port I/O Space, Memory Space, and Bus Master Enable bits at
    startup; PCI core will set those as necessary (Pali Rohár)
  - When operating as a Root Port, set class code to "PCI Bridge" instead of
    the default "Mass Storage Controller" (Pali Rohár)
  - Add emulation for PCI_BRIDGE_CTL_BUS_RESET since aardvark doesn't
    implement this per spec (Pali Rohár)
  - Add emulation of option ROM BAR since aardvark doesn't implement this per
    spec (Pali Rohár)

MediaTek MT7621 PCIe controller driver:
  - Add MediaTek MT7621 PCIe host controller driver and DT binding (Sergio
    Paracuellos)

Qualcomm PCIe controller driver:
  - Add SC8180x compatible string (Bjorn Andersson)
  - Add endpoint controller driver and DT binding (Manivannan Sadhasivam)
  - Restructure to use of_device_get_match_data() (Prasad Malisetty)
  - Add SC7280-specific pcie_1_pipe_clk_src handling (Prasad Malisetty)

Renesas R-Car PCIe controller driver:
  - Remove unnecessary includes (Geert Uytterhoeven)

Rockchip DesignWare PCIe controller driver:
  - Add DT binding (Simon Xue)

Socionext UniPhier Pro5 controller driver:
  - Serialize INTx masking/unmasking (Kunihiko Hayashi)

Synopsys DesignWare PCIe controller driver:
  - Run dwc .host_init() method before registering MSI interrupt handler so
    we can deal with pending interrupts left by bootloader (Bjorn
    Andersson)
  - Clean up Kconfig dependencies (Andy Shevchenko)
  - Export symbols to allow more modular drivers (Luca Ceresoli)

TI DRA7xx PCIe controller driver:
  - Allow host and endpoint drivers to be modules (Luca Ceresoli)
  - Enable external clock if present (Luca Ceresoli)

TI J721E PCIe driver:
  - Disable PHY when probe fails after initializing it (Christophe JAILLET)

MicroSemi Switchtec management driver:
  - Return error to application when command execution fails because an
    out-of-band reset has cleared the device BARs, Memory Space Enable, etc
    (Kelvin Cao)
  - Fix MRPC error status handling issue (Kelvin Cao)
  - Mask out other bits when reading of management VEP instance ID (Kelvin
    Cao)
  - Return EOPNOTSUPP instead of ENOTSUPP from sysfs show functions (Kelvin
    Cao)
  - Add check of event support (Logan Gunthorpe)

Miscellaneous:
  - Remove unused pci_pool wrappers, which have been replaced by dma_pool
    (Cai Huoqing)
  - Use 'unsigned int' instead of bare 'unsigned' (Krzysztof Wilczyński)
  - Use kstrtobool() directly, sans strtobool() wrapper (Krzysztof
    Wilczyński)
  - Fix some sscanf(), sprintf() format mismatches (Krzysztof Wilczyński)
  - Update PCI subsystem information in MAINTAINERS (Krzysztof Wilczyński)
  - Correct some misspellings (Krzysztof Wilczyński)

----------------------------------------------------------------
Adrian Huang (1):
      PCI: vmd: Do not disable MSI-X remapping if interrupt remapping is enabled by IOMMU

Alyssa Rosenzweig (2):
      PCI: apple: Add initial hardware bring-up
      PCI: apple: Set up reference clocks when probing

Andy Shevchenko (2):
      PCI: dwc: Clean up Kconfig dependencies (PCIE_DW_HOST)
      PCI: dwc: Clean up Kconfig dependencies (PCIE_DW_EP)

Barry Song (2):
      PCI: Document /sys/bus/pci/devices/.../irq
      PCI/sysfs: Explicitly show first MSI IRQ for 'irq'

Bjorn Andersson (2):
      PCI: dwc: Perform host_init() before registering msi
      PCI: qcom: Add sc8180x compatible

Bjorn Helgaas (30):
      PCI: Return NULL for to_pci_driver(NULL)
      PCI/ERR: Factor out common dev->driver expressions
      cxl: Factor out common dev->driver expressions
      Merge branch 'pci/acpi'
      Merge branch 'pci/aspm'
      Merge branch 'pci/enumeration'
      Merge branch 'pci/driver'
      Merge branch 'pci/hotplug'
      Merge branch 'pci/msi'
      Merge branch 'pci/p2pdma'
      Merge branch 'pci/portdrv'
      Merge branch 'pci/resource'
      Merge branch 'pci/switchtec'
      Merge branch 'pci/sysfs'
      Merge branch 'pci/virtualization'
      Merge branch 'pci/vpd'
      Merge branch 'pci/misc'
      Merge branch 'remotes/lorenzo/pci/aardvark'
      Merge branch 'pci/host/apple'
      Merge branch 'pci/host/cadence'
      Merge branch 'remotes/lorenzo/pci/dt'
      Merge branch 'pci/host/dwc'
      Merge branch 'remotes/lorenzo/pci/endpoint'
      Merge branch 'remotes/lorenzo/pci/imx6'
      Merge branch 'pci/host/kirin'
      Merge branch 'pci/host/mt7621'
      Merge branch 'remotes/lorenzo/pci/qcom'
      Merge branch 'pci/host/rcar'
      Merge branch 'remotes/lorenzo/pci/vmd'
      Merge branch 'remotes/lorenzo/pci/xgene'

Cai Huoqing (1):
      PCI: Remove unused pci_pool wrappers

Christophe JAILLET (1):
      PCI: j721e: Fix j721e_pcie_probe() error path

Chunguang Xu (1):
      PCI: vmd: Assign a number to each VMD controller

Colin Ian King (1):
      PCI: Remove redundant 'rc' initialization

Geert Uytterhoeven (2):
      PCI: rcar-ep: Remove unneeded includes
      PCI: rcar-host: Remove unneeded includes

Heiner Kallweit (5):
      PCI/VPD: Add pci_read/write_vpd_any()
      PCI/VPD: Use pci_read_vpd_any() in pci_vpd_size()
      cxgb3: Remove t3_seeprom_read and use VPD API
      cxgb3: Use VPD API in t3_seeprom_wp()
      cxgb3: Remove seeprom_write and use VPD API

Ingmar Klein (1):
      PCI: Mark Atheros QCA6174 to avoid bus reset

Jan Kiszka (1):
      PCI/portdrv: Do not setup up IRQs if there are no users

Joerg Roedel (4):
      PCI/ACPI: Remove OSC_PCI_SUPPORT_MASKS and OSC_PCI_CONTROL_MASKS
      PCI/ACPI: Move supported and control calculations to separate functions
      PCI/ACPI: Move _OSC query checks to separate function
      PCI/ACPI: Check for _OSC support in acpi_pci_osc_control_set()

Johannes Berg (1):
      PCI: vmd: depend on !UML

Kai-Heng Feng (1):
      PCI: Coalesce host bridge contiguous apertures

Kelvin Cao (4):
      PCI/switchtec: Error out MRPC execution when MMIO reads fail
      PCI/switchtec: Fix a MRPC error status handling issue
      PCI/switchtec: Update the way of getting management VEP instance ID
      PCI/switchtec: Replace ENOTSUPP with EOPNOTSUPP

Krzysztof Wilczyński (13):
      PCI/sysfs: Check CAP_SYS_ADMIN before parsing user input
      PCI/sysfs: Return -EINVAL consistently from "store" functions
      PCI: Use kstrtobool() directly, sans strtobool() wrapper
      PCI: imx6: Remove unused assignment to variable ret
      PCI: visconti: Remove surplus dev_err() when using platform_get_irq_byname()
      PCI: Correct misspelled and remove duplicated words
      PCI: hv: Remove unnecessary use of %hx
      PCI: Use unsigned to match sscanf("%x") in pci_dev_str_match_path()
      PCI: cpqphp: Format if-statement code block correctly
      PCI: Prefer 'unsigned int' over bare 'unsigned'
      MAINTAINERS: Update PCI subsystem information
      PCI: cpqphp: Use <linux/io.h> instead of <asm/io.h>
      PCI: vmd: Drop redundant includes of <asm/device.h>, <asm/msi.h>

Kunihiko Hayashi (2):
      PCI: endpoint: Use sysfs_emit() in "show" functions
      PCI: uniphier: Serialize INTx masking/unmasking and fix the bit operation

Li Chen (1):
      PCI: cadence: Add cdns_plat_pcie_probe() missing return

Logan Gunthorpe (1):
      PCI/switchtec: Add check of event support

Luca Ceresoli (4):
      PCI: dwc: Export more symbols to allow modular drivers
      PCI: dra7xx: Make it a kernel module
      PCI: dra7xx: Remove unused include
      PCI: dra7xx: Get an optional clock

Lukas Wunner (5):
      PCI/portdrv: Rename pm_iter() to pcie_port_device_iter()
      PCI: pciehp: Ignore Link Down/Up caused by error-induced Hot Reset
      PCI/portdrv: Remove unused resume err_handler
      PCI/portdrv: Remove unused pcie_port_bus_{,un}register() declarations
      PCI/ERR: Reduce compile time for CONFIG_PCIEAER=n

Manivannan Sadhasivam (3):
      dt-bindings: PCI: Add Qualcomm PCIe Endpoint controller
      PCI: qcom-ep: Add Qualcomm PCIe Endpoint controller driver
      MAINTAINERS: Add entry for Qualcomm PCIe Endpoint driver and binding

Marc Zyngier (7):
      irqdomain: Make of_phandle_args_to_fwspec() generally available
      of/irq: Allow matching of an interrupt-map local to an interrupt controller
      PCI: of: Allow matching of an interrupt-map local to a PCI device
      PCI: apple: Add INTx and per-port interrupt support
      PCI: apple: Implement MSI support
      iommu/dart: Exclude MSI doorbell from PCIe device IOVA range
      PCI: apple: Configure RID to SID mapper on device addition

Marek Behún (5):
      PCI: aardvark: Don't spam about PIO Response Status
      PCI: aardvark: Deduplicate code in advk_pcie_rd_conf()
      PCI: pci-bridge-emul: Fix emulation of W1C bits
      PCI: aardvark: Fix return value of MSI domain .alloc() method
      PCI: aardvark: Read all 16-bits from PCIE_MSI_PAYLOAD_REG

Mauro Carvalho Chehab (12):
      PCI: kirin: Reorganize the PHY logic inside the driver
      PCI: kirin: Add support for a PHY layer
      PCI: kirin: Use regmap for APB registers
      PCI: kirin: Support PERST# GPIOs for HiKey970 external PEX 8606 bridge
      PCI: kirin: Add Kirin 970 compatible
      PCI: kirin: Add MODULE_* macros
      PCI: kirin: Allow building it as a module
      PCI: kirin: Add power_off support for Kirin 960 PHY
      PCI: kirin: Move the power-off code to a common routine
      PCI: kirin: Disable clkreq during poweroff sequence
      PCI: kirin: De-init the dwc driver
      PCI: kirin: Allow removing the driver

Mingchuang Qiao (1):
      PCI: Re-enable Downstream Port LTR after reset or hotplug

Nathan Rossi (1):
      PCI: Add ACS quirk for Pericom PI7C9X2G switches

Oliver O'Halloran (1):
      PCI: Rename pcibios_add_device() to pcibios_device_add()

Pali Rohár (16):
      PCI: xgene: Use PCI_VENDOR_ID_AMCC macro
      PCI: Add PCI_EXP_DEVCTL_PAYLOAD_* macros
      PCI: aardvark: Fix PCIe Max Payload Size setting
      PCI: aardvark: Fix preserving PCI_EXP_RTCTL_CRSSVE flag on emulated bridge
      PCI: aardvark: Fix configuring Reference clock
      PCI: aardvark: Do not clear status bits of masked interrupts
      PCI: aardvark: Do not unmask unused interrupts
      PCI: aardvark: Implement re-issuing config requests on CRS response
      PCI: aardvark: Simplify initialization of rootcap on virtual bridge
      PCI: aardvark: Fix link training
      PCI: aardvark: Fix checking for link up via LTSSM state
      PCI: aardvark: Fix reporting Data Link Layer Link Active
      PCI: aardvark: Fix support for bus mastering and PCI_COMMAND on emulated bridge
      PCI: aardvark: Set PCI Bridge Class Code to PCI Bridge
      PCI: aardvark: Fix support for PCI_BRIDGE_CTL_BUS_RESET on emulated bridge
      PCI: aardvark: Fix support for PCI_ROM_ADDRESS1 on emulated bridge

Pranay Sanghai (1):
      PCI: Tidy comments

Prasad Malisetty (2):
      PCI: qcom: Replace ops with struct pcie_cfg in pcie match data
      PCI: qcom: Switch pcie_1_pipe_clk_src after PHY init in SC7280

Selvin Xavier (1):
      PCI: Do not enable AtomicOps on VFs

Sergio Paracuellos (3):
      dt-bindings: PCI: Add MT7621 SoC PCIe host controller
      PCI: mt7621: Add MediaTek MT7621 PCIe host controller driver
      MAINTAINERS: Add Sergio Paracuellos as MT7621 PCIe maintainer

Simon Xue (1):
      dt-bindings: rockchip: Add DesignWare based PCIe controller

Uwe Kleine-König (21):
      PCI: Drop pci_device_remove() test of pci_dev->driver
      PCI: Drop pci_device_probe() test of !pci_dev->driver
      scsi: message: fusion: Remove unused mpt_pci driver .probe() 'id' parameter
      crypto: qat - simplify adf_enable_aer()
      bcma: simplify reference to driver name
      ssb: Use dev_driver_string() instead of pci_dev->driver->name
      powerpc/eeh: Use dev_driver_string() instead of struct pci_dev->driver->name
      crypto: hisilicon - use dev_driver_string() instead of pci_dev->driver->name
      net: hns3: use dev_driver_string() instead of pci_dev->driver->name
      net: marvell: prestera: use dev_driver_string() instead of pci_dev->driver->name
      mlxsw: pci: Use dev_driver_string() instead of pci_dev->driver->name
      nfp: use dev_driver_string() instead of pci_dev->driver->name
      xen/pcifront: Drop pcifront_common_process() tests of pcidev, pdrv
      xen/pcifront: Use to_pci_driver() instead of pci_dev->driver
      cxl: Use to_pci_driver() instead of pci_dev->driver
      usb: xhci: Use to_pci_driver() instead of pci_dev->driver
      powerpc/eeh: Use to_pci_driver() instead of pci_dev->driver
      perf/x86/intel/uncore: Use to_pci_driver() instead of pci_dev->driver
      x86/pci/probe_roms: Use to_pci_driver() instead of pci_dev->driver
      PCI: Use to_pci_driver() instead of pci_dev->driver
      PCI: Remove struct pci_dev->driver

Wang Lu (1):
      PCI/P2PDMA: Apply bus offset correctly in DMA address calculation

 Documentation/ABI/testing/sysfs-bus-pci            |  11 +
 .../bindings/pci/mediatek,mt7621-pcie.yaml         | 142 ++++
 .../devicetree/bindings/pci/qcom,pcie-ep.yaml      | 158 ++++
 .../devicetree/bindings/pci/qcom,pcie.txt          |   5 +-
 .../devicetree/bindings/pci/rockchip-dw-pcie.yaml  | 141 ++++
 MAINTAINERS                                        |  40 +-
 arch/microblaze/pci/pci-common.c                   |   3 +-
 arch/mips/ralink/Kconfig                           |   3 +-
 arch/powerpc/include/asm/ppc-pci.h                 |   5 -
 arch/powerpc/kernel/eeh.c                          |   8 +
 arch/powerpc/kernel/eeh_driver.c                   |  10 +-
 arch/powerpc/kernel/pci-common.c                   |   2 +-
 arch/powerpc/platforms/powernv/pci-sriov.c         |   2 +-
 arch/s390/pci/pci.c                                |   2 +-
 arch/sparc/kernel/pci.c                            |   2 +-
 arch/x86/events/intel/uncore.c                     |   2 +-
 arch/x86/kernel/probe_roms.c                       |   2 +-
 arch/x86/pci/common.c                              |   2 +-
 drivers/acpi/pci_root.c                            | 161 ++--
 drivers/bcma/host_pci.c                            |   6 +-
 drivers/crypto/hisilicon/qm.c                      |   2 +-
 drivers/crypto/qat/qat_4xxx/adf_drv.c              |   7 +-
 drivers/crypto/qat/qat_c3xxx/adf_drv.c             |   7 +-
 drivers/crypto/qat/qat_c62x/adf_drv.c              |   7 +-
 drivers/crypto/qat/qat_common/adf_aer.c            |  10 +-
 drivers/crypto/qat/qat_common/adf_common_drv.h     |   3 +-
 drivers/crypto/qat/qat_dh895xcc/adf_drv.c          |   7 +-
 drivers/iommu/apple-dart.c                         |  27 +
 drivers/message/fusion/mptbase.c                   |   7 +-
 drivers/message/fusion/mptbase.h                   |   2 +-
 drivers/message/fusion/mptctl.c                    |   4 +-
 drivers/message/fusion/mptlan.c                    |   2 +-
 drivers/misc/cxl/guest.c                           |  30 +-
 drivers/misc/cxl/pci.c                             |  35 +-
 drivers/net/ethernet/chelsio/cxgb3/common.h        |   2 -
 drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c    |  38 +-
 drivers/net/ethernet/chelsio/cxgb3/t3_hw.c         |  98 +--
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c |   2 +-
 .../net/ethernet/marvell/prestera/prestera_pci.c   |   2 +-
 drivers/net/ethernet/mellanox/mlxsw/pci.c          |   2 +-
 .../net/ethernet/netronome/nfp/nfp_net_ethtool.c   |   3 +-
 drivers/of/irq.c                                   |  17 +-
 drivers/pci/controller/Kconfig                     |  28 +-
 drivers/pci/controller/Makefile                    |   3 +
 drivers/pci/controller/cadence/pci-j721e.c         |   2 +-
 drivers/pci/controller/cadence/pcie-cadence-plat.c |   2 +
 drivers/pci/controller/dwc/Kconfig                 |  30 +-
 drivers/pci/controller/dwc/Makefile                |   1 +
 drivers/pci/controller/dwc/pci-dra7xx.c            |  22 +-
 drivers/pci/controller/dwc/pci-imx6.c              |   2 +-
 drivers/pci/controller/dwc/pcie-designware-ep.c    |   3 +
 drivers/pci/controller/dwc/pcie-designware-host.c  |  19 +-
 drivers/pci/controller/dwc/pcie-designware.c       |   1 +
 drivers/pci/controller/dwc/pcie-kirin.c            | 644 ++++++++++++----
 drivers/pci/controller/dwc/pcie-qcom-ep.c          | 721 ++++++++++++++++++
 drivers/pci/controller/dwc/pcie-qcom.c             |  96 ++-
 drivers/pci/controller/dwc/pcie-uniphier.c         |  26 +-
 drivers/pci/controller/dwc/pcie-visconti.c         |   5 +-
 drivers/pci/controller/pci-aardvark.c              | 493 +++++++-----
 drivers/pci/controller/pci-hyperv.c                |   4 +-
 drivers/pci/controller/pci-thunder-ecam.c          |   4 +-
 drivers/pci/controller/pci-xgene-msi.c             |   2 +-
 drivers/pci/controller/pci-xgene.c                 |   3 +-
 drivers/pci/controller/pcie-apple.c                | 824 +++++++++++++++++++++
 drivers/pci/controller/pcie-brcmstb.c              |   2 +-
 drivers/pci/controller/pcie-iproc.c                |   2 +-
 .../pci-mt7621.c => pci/controller/pcie-mt7621.c}  |  24 +-
 drivers/pci/controller/pcie-rcar-ep.c              |   5 +-
 drivers/pci/controller/pcie-rcar-host.c            |   2 -
 drivers/pci/controller/vmd.c                       |  47 +-
 drivers/pci/endpoint/functions/pci-epf-ntb.c       |  22 +-
 drivers/pci/endpoint/pci-ep-cfs.c                  |  48 +-
 drivers/pci/endpoint/pci-epc-core.c                |   2 +-
 drivers/pci/endpoint/pci-epf-core.c                |   4 +-
 drivers/pci/hotplug/acpiphp_glue.c                 |   2 +-
 drivers/pci/hotplug/cpqphp.h                       |   2 +-
 drivers/pci/hotplug/cpqphp_ctrl.c                  |   4 +-
 drivers/pci/hotplug/cpqphp_pci.c                   |   6 +-
 drivers/pci/hotplug/ibmphp.h                       |   4 +-
 drivers/pci/hotplug/pciehp.h                       |   2 +
 drivers/pci/hotplug/pciehp_core.c                  |   2 +
 drivers/pci/hotplug/pciehp_hpc.c                   |  26 +
 drivers/pci/hotplug/shpchp_hpc.c                   |   2 +-
 drivers/pci/iov.c                                  |  38 +-
 drivers/pci/msi.c                                  |   3 +-
 drivers/pci/of.c                                   |  10 +-
 drivers/pci/p2pdma.c                               |   8 +-
 drivers/pci/pci-bridge-emul.c                      |  13 +
 drivers/pci/pci-driver.c                           |  57 +-
 drivers/pci/pci-sysfs.c                            |  51 +-
 drivers/pci/pci.c                                  |  65 +-
 drivers/pci/pci.h                                  |   1 +
 drivers/pci/pcie/Makefile                          |   4 +-
 drivers/pci/pcie/aer.c                             |   2 +-
 drivers/pci/pcie/aspm.c                            |   4 +-
 drivers/pci/pcie/err.c                             |  40 +-
 drivers/pci/pcie/portdrv.h                         |   6 +-
 drivers/pci/pcie/portdrv_core.c                    |  67 +-
 drivers/pci/pcie/portdrv_pci.c                     |  27 +-
 drivers/pci/probe.c                                |  62 +-
 drivers/pci/quirks.c                               |  70 +-
 drivers/pci/rom.c                                  |   2 +-
 drivers/pci/setup-bus.c                            |   2 +-
 drivers/pci/setup-irq.c                            |  26 +-
 drivers/pci/switch/switchtec.c                     |  95 ++-
 drivers/pci/vpd.c                                  | 113 +--
 drivers/pci/xen-pcifront.c                         |  56 +-
 drivers/ssb/pcihost_wrapper.c                      |   6 +-
 drivers/staging/Kconfig                            |   2 -
 drivers/staging/Makefile                           |   1 -
 drivers/staging/mt7621-pci/Kconfig                 |   8 -
 drivers/staging/mt7621-pci/Makefile                |   2 -
 drivers/staging/mt7621-pci/TODO                    |   4 -
 drivers/staging/mt7621-pci/mediatek,mt7621-pci.txt | 104 ---
 drivers/usb/host/xhci-pci.c                        |   2 +-
 include/linux/acpi.h                               |   2 -
 include/linux/irqdomain.h                          |   4 +
 include/linux/pci.h                                |  21 +-
 include/linux/switchtec.h                          |   1 +
 include/uapi/linux/pci_regs.h                      |   6 +
 kernel/irq/irqdomain.c                             |   7 +-
 121 files changed, 3954 insertions(+), 1202 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/mediatek,mt7621-pcie.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-qcom-ep.c
 create mode 100644 drivers/pci/controller/pcie-apple.c
 rename drivers/{staging/mt7621-pci/pci-mt7621.c => pci/controller/pcie-mt7621.c} (95%)
 delete mode 100644 drivers/staging/mt7621-pci/Kconfig
 delete mode 100644 drivers/staging/mt7621-pci/Makefile
 delete mode 100644 drivers/staging/mt7621-pci/TODO
 delete mode 100644 drivers/staging/mt7621-pci/mediatek,mt7621-pci.txt
