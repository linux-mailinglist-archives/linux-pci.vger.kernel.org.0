Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5BAC19DA90
	for <lists+linux-pci@lfdr.de>; Fri,  3 Apr 2020 17:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391093AbgDCPst (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Apr 2020 11:48:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:51202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391042AbgDCPsp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 3 Apr 2020 11:48:45 -0400
Received: from localhost (mobile-166-170-223-166.mycingular.net [166.170.223.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A52DA206F8;
        Fri,  3 Apr 2020 15:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585928924;
        bh=ClutEkvWzy40wJdpeVsN6E+lDbhBTswzI/pOY83WazM=;
        h=Date:From:To:Cc:Subject:From;
        b=yloAg2N8fqFuYvumXq7o1Re+Q2Czh8iZgk10DtpEif/WEuPo4GOP6j+2A0+7/hVq9
         p+d4RhoUrFO8/42FeZfLB53sTy+gClvZd5qklL7n++Jz8V1ebmc0upidrdD8bWddTR
         AcTk8hCDNWDvmZivTsxeW1xi5gqhISiineudlb7k=
Date:   Fri, 3 Apr 2020 10:48:41 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [GIT PULL] PCI changes for v5.7
Message-ID: <20200403154841.GA241702@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

  Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.7-changes

for you to fetch changes up to 86ce3c90c910110540ac25cae5d9b90b268542bd:

  Merge branch 'remotes/lorenzo/pci/vmd' (2020-04-02 14:27:09 -0500)

----------------------------------------------------------------

Enumeration:

  - Revert sysfs "rescan" renames that broke apps (Kelsey Skunberg)

  - Add more 32 GT/s link speed decoding and improve the implementation
    (Yicong Yang)

Resource management:

  - Add support for sizing programmable host bridge apertures and fix a
    related alpha Nautilus regression (Ivan Kokshaysky)

Interrupts:

  - Add boot interrupt quirk mechanism for Xeon chipsets and document boot
    interrupts (Sean V Kelley)

PCIe native device hotplug:

  - When possible, disable in-band presence detect and use PDS (Alexandru
    Gagniuc)

  - Add DMI table for devices that don't use in-band presence detection but
    don't advertise that correctly (Stuart Hayes)

  - Fix hang when powering slots up/down via sysfs (Lukas Wunner)

  - Fix an MSI interrupt race (Stuart Hayes)

Virtualization:

  - Add ACS quirks for Zhaoxin devices (Raymond Pang)

Error handling:

  - Add Error Disconnect Recover (EDR) support so firmware can report
    devices disconnected via DPC and we can try to recover (Kuppuswamy
    Sathyanarayanan)

Peer-to-peer DMA:

  - Add Intel Sky Lake-E Root Ports B, C, D to the whitelist (Andrew Maier)

ASPM:

  - Reduce severity of common clock config message (Chris Packham)

  - Clear the correct bits when enabling L1 substates, so we don't go to
    the wrong state (Yicong Yang)

Endpoint framework:

  - Replace EPF linkup ops with notifier call chain and improve locking
    (Kishon Vijay Abraham I)

  - Fix concurrent memory allocation in OB address region (Kishon Vijay
    Abraham I)

  - Move PF function number assignment to EPC core to support multiple
    function creation methods (Kishon Vijay Abraham I)

  - Fix issue with clearing configfs "start" entry (Kunihiko Hayashi)

  - Fix issue with endpoint MSI-X ignoring BAR Indicator and Table Offset
    (Kishon Vijay Abraham I)

  - Add support for testing DMA transfers (Kishon Vijay Abraham I)

  - Add support for testing > 10 endpoint devices (Kishon Vijay Abraham I)

  - Add support for tests to clear IRQ (Kishon Vijay Abraham I)

  - Add common DT schema for endpoint controllers (Kishon Vijay Abraham I)

Amlogic Meson PCIe controller driver:

  - Add DT bindings for AXG PCIe PHY, shared MIPI/PCIe analog PHY (Remi
    Pommarel)

  - Add Amlogic AXG PCIe PHY, AXG MIPI/PCIe analog PHY drivers (Remi
    Pommarel)

Cadence PCIe controller driver:

  - Add Root Complex/Endpoint DT schema for Cadence PCIe (Kishon Vijay
    Abraham I)

Intel VMD host bridge driver:

  - Add two VMD Device IDs that require bus restriction mode (Sushma
    Kalakota)

Mobiveil PCIe controller driver:

  - Refactor and modularize mobiveil driver (Hou Zhiqiang)

  - Add support for Mobiveil GPEX Gen4 host (Hou Zhiqiang)

Microsoft Hyper-V host bridge driver:

  - Add support for Hyper-V PCI protocol version 1.3 and PCI_BUS_RELATIONS2
    (Long Li)

  - Refactor to prepare for virtual PCI on non-x86 architectures (Boqun
    Feng)

  - Fix memory leak in hv_pci_probe()'s error path (Dexuan Cui)

NVIDIA Tegra PCIe controller driver:

  - Use pci_parse_request_of_pci_ranges() (Rob Herring)

  - Add support for endpoint mode and related DT updates (Vidya Sagar)

  - Reduce -EPROBE_DEFER error message log level (Thierry Reding)

Qualcomm PCIe controller driver:

  - Restrict class fixup to specific Qualcomm devices (Bjorn Andersson)

Synopsys DesignWare PCIe controller driver:

  - Refactor core initialization code for endpoint mode (Vidya Sagar)

  - Fix endpoint MSI-X to use correct table address (Kishon Vijay Abraham
    I)

TI DRA7xx PCIe controller driver:

  - Fix MSI IRQ handling (Vignesh Raghavendra)

TI Keystone PCIe controller driver:

  - Allow AM654 endpoint to raise MSI-X interrupt (Kishon Vijay Abraham I)

Miscellaneous:

  - Quirk ASMedia XHCI USB to avoid "PME# from D0" defect (Kai-Heng Feng)

  - Use ioremap(), not phys_to_virt(), for platform ROM to fix video ROM
    mapping with CONFIG_HIGHMEM (Mikel Rychliski)

----------------------------------------------------------------
Alexandru Gagniuc (2):
      PCI: pciehp: Disable in-band presence detect when possible
      PCI: pciehp: Wait for PDS if in-band presence is disabled

Andrew Maier (1):
      PCI/P2PDMA: Add Intel Sky Lake-E Root Ports B, C, D to the whitelist

Bjorn Andersson (1):
      PCI: qcom: Fix the fixup of PCI_VENDOR_ID_QCOM

Bjorn Helgaas (21):
      PCI: Add pci_speed_string()
      PCI: Use pci_speed_string() for all PCI/PCI-X/PCIe strings
      PCI/DPC: Move DPC data into struct pci_dev
      Merge branch 'pci/aspm'
      Merge branch 'pci/edr'
      Merge branch 'pci/enumeration'
      Merge branch 'pci/hotplug'
      Merge branch 'pci/interrupts'
      Merge branch 'pci/misc'
      Merge branch 'pci/p2pdma'
      Merge branch 'pci/resource'
      Merge branch 'pci/virtualization'
      Merge branch 'remotes/lorenzo/pci/amlogic'
      Merge branch 'remotes/lorenzo/pci/dt'
      Merge branch 'remotes/lorenzo/pci/dwc'
      Merge branch 'remotes/lorenzo/pci/endpoint'
      Merge branch 'remotes/lorenzo/pci/hv'
      Merge branch 'remotes/lorenzo/pci/mobiveil'
      Merge branch 'remotes/lorenzo/pci/qcom'
      Merge branch 'remotes/lorenzo/pci/tegra'
      Merge branch 'remotes/lorenzo/pci/vmd'

Boqun Feng (3):
      PCI: hv: Move hypercall related definitions into tlfs header
      PCI: hv: Move retarget related structures into tlfs header
      PCI: hv: Introduce hv_msi_entry

Chris Packham (1):
      PCI/ASPM: Reduce severity of common clock config message

Colin Ian King (1):
      PCI/ACPI: Move pcie_to_hpx3_type[] from stack to static data

Dexuan Cui (2):
      PCI: hv: Remove unnecessary type casting from kzalloc
      PCI: hv: Add missing kfree(hbus) in hv_pci_probe()'s error handling path

Gustavo A. R. Silva (1):
      PCI: hv: Replace zero-length array with flexible-array member

Hou Zhiqiang (13):
      PCI: mobiveil: Introduce a new structure mobiveil_root_port
      PCI: mobiveil: Move the host initialization into a function
      PCI: mobiveil: Collect the interrupt related operations into a function
      PCI: mobiveil: Modularize the Mobiveil PCIe Host Bridge IP driver
      PCI: mobiveil: Add callback function for interrupt initialization
      PCI: mobiveil: Add callback function for link up check
      PCI: mobiveil: Allow mobiveil_host_init() to be used to re-init host
      PCI: mobiveil: Add 8-bit and 16-bit CSR register accessors
      PCI: mobiveil: Add Header Type field check
      dt-bindings: PCI: Add NXP Layerscape SoCs PCIe Gen4 controller
      PCI: mobiveil: Add PCIe Gen4 RC driver for Layerscape SoCs
      PCI: mobiveil: Fix sparse different address space warnings
      PCI: mobiveil: Fix unmet dependency warning for PCIE_MOBIVEIL_PLAT

Ivan Kokshaysky (2):
      PCI: Add support for root bus sizing
      alpha: Fix nautilus PCI setup

Kai-Heng Feng (1):
      PCI: Avoid ASMedia XHCI USB PME# from D0 defect

Kelsey Skunberg (1):
      PCI: sysfs: Revert "rescan" file renames

Kishon Vijay Abraham I (21):
      PCI: endpoint: Use notification chain mechanism to notify EPC events to EPF
      PCI: endpoint: Replace spinlock with mutex
      PCI: endpoint: Fix for concurrent memory allocation in OB address region
      PCI: endpoint: Protect concurrent access to pci_epf_ops with mutex
      PCI: endpoint: Assign function number for each PF in EPC core
      dt-bindings: PCI: Add PCI Endpoint Controller Schema
      dt-bindings: PCI: cadence: Add PCIe RC/EP DT schema for Cadence PCIe
      dt-bindings: PCI: Convert PCIe Host/Endpoint in Cadence platform to DT schema
      PCI: endpoint: functions/pci-epf-test: Add DMA support to transfer data
      PCI: endpoint: functions/pci-epf-test: Print throughput information
      misc: pci_endpoint_test: Use streaming DMA APIs for buffer allocation
      tools: PCI: Add 'd' command line option to support DMA
      misc: pci_endpoint_test: Add support to get DMA option from userspace
      PCI: endpoint: Fix ->set_msix() to take BIR and offset as arguments
      PCI: dwc: Fix dw_pcie_ep_raise_msix_irq() to get correct MSI-X table address
      PCI: keystone: Allow AM654 PCIe Endpoint to raise MSI-X interrupt
      misc: pci_endpoint_test: Avoid using module parameter to determine irqtype
      misc: pci_endpoint_test: Add ioctl to clear IRQ
      tools: PCI: Add 'e' to clear IRQ
      misc: pci_endpoint_test: Fix to support > 10 pci-endpoint-test devices
      misc: pci_endpoint_test: Use full pci-endpoint-test name in request_irq()

Kunihiko Hayashi (1):
      PCI: endpoint: Fix clearing start entry in configfs

Kuppuswamy Sathyanarayanan (9):
      PCI/ERR: Combine pci_channel_io_frozen cases
      PCI/ERR: Update error status after reset_link()
      PCI/ERR: Remove service dependency in pcie_do_recovery()
      PCI/ERR: Return status of pcie_do_recovery()
      PCI/DPC: Cache DPC capabilities in pci_init_capabilities()
      PCI/AER: Add pci_aer_raw_clear_status() to unconditionally clear Error Status
      PCI/DPC: Expose dpc_process_error(), dpc_reset_link() for use by EDR
      PCI/DPC: Add Error Disconnect Recover (EDR) support
      PCI/AER: Rationalize error status register clearing

Lad Prabhakar (1):
      misc: pci_endpoint_test: remove duplicate macro PCI_ENDPOINT_TEST_STATUS

Long Li (2):
      PCI: hv: Decouple the func definition in hv_dr_state from VSP message
      PCI: hv: Add support for protocol 1.3 and support PCI_BUS_RELATIONS2

Lukas Wunner (1):
      PCI: pciehp: Fix indefinite wait on sysfs requests

Mikel Rychliski (1):
      PCI: Use ioremap(), not phys_to_virt() for platform ROM

Raymond Pang (3):
      PCI: Add Zhaoxin Vendor ID
      PCI: Add ACS quirk for Zhaoxin multi-function devices
      PCI: Add ACS quirk for Zhaoxin Root/Downstream Ports

Remi Pommarel (6):
      dt-bindings: Add AXG PCIE PHY bindings
      dt-bindings: Add AXG shared MIPI/PCIE analog PHY bindings
      dt-bindings: PCI: meson: Update PCIE bindings documentation
      phy: amlogic: Add Amlogic AXG MIPI/PCIE analog PHY Driver
      phy: amlogic: Add Amlogic AXG PCIE PHY Driver
      PCI: amlogic: Use AXG PCIE

Rob Herring (1):
      PCI: tegra: Use pci_parse_request_of_pci_ranges()

Sean V Kelley (2):
      PCI: Add boot interrupt quirk mechanism for Xeon chipsets
      Documentation: PCI: Add background on Boot Interrupts

Stuart Hayes (2):
      PCI: pciehp: Add DMI table for in-band presence detection disabled
      PCI: pciehp: Fix MSI interrupt race

Sushma Kalakota (1):
      PCI: vmd: Add two VMD Device IDs

Thierry Reding (1):
      PCI: tegra: Print -EPROBE_DEFER error message at debug level

Vidya Sagar (8):
      PCI: endpoint: Add core init notifying feature
      PCI: dwc: Refactor core initialization code for EP mode
      PCI: endpoint: Add notification for core init completion
      PCI: dwc: Add API to notify core initialization completion
      PCI: pci-epf-test: Add support to defer core initialization
      soc/tegra: bpmp: Update ABI header
      dt-bindings: PCI: tegra: Add DT support for PCIe EP nodes in Tegra194
      PCI: tegra: Add support for PCIe endpoint mode in Tegra194

Vignesh Raghavendra (1):
      PCI: dwc: pci-dra7xx: Fix MSI IRQ handling

Yicong Yang (3):
      PCI: Add 32 GT/s decoding in some macros
      PCI: Add PCIE_LNKCAP2_SLS2SPEED() macro
      PCI/ASPM: Clear the correct bits when enabling L1 substates

 Documentation/PCI/boot-interrupts.rst              | 155 +++++
 Documentation/PCI/index.rst                        |   1 +
 Documentation/PCI/pcieaer-howto.rst                |  23 +-
 .../devicetree/bindings/pci/amlogic,meson-pcie.txt |  22 +-
 .../devicetree/bindings/pci/cdns,cdns-pcie-ep.txt  |  27 -
 .../devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml |  49 ++
 .../bindings/pci/cdns,cdns-pcie-host.txt           |  66 --
 .../bindings/pci/cdns,cdns-pcie-host.yaml          |  76 +++
 .../devicetree/bindings/pci/cdns-pcie-host.yaml    |  27 +
 .../devicetree/bindings/pci/cdns-pcie.yaml         |  31 +
 .../bindings/pci/layerscape-pcie-gen4.txt          |  52 ++
 .../bindings/pci/nvidia,tegra194-pcie.txt          | 125 +++-
 Documentation/devicetree/bindings/pci/pci-ep.yaml  |  41 ++
 .../phy/amlogic,meson-axg-mipi-pcie-analog.yaml    |  35 +
 .../bindings/phy/amlogic,meson-axg-pcie.yaml       |  52 ++
 MAINTAINERS                                        |  12 +-
 arch/alpha/kernel/sys_nautilus.c                   |  52 +-
 arch/x86/include/asm/hyperv-tlfs.h                 |  41 ++
 arch/x86/include/asm/mshyperv.h                    |   8 +
 drivers/acpi/pci_root.c                            |  15 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c           |  31 +-
 .../gpu/drm/nouveau/nvkm/subdev/bios/shadowpci.c   |  17 +-
 drivers/gpu/drm/radeon/radeon_bios.c               |  30 +-
 drivers/misc/pci_endpoint_test.c                   | 213 +++++-
 drivers/net/ethernet/intel/ice/ice_main.c          |   4 +-
 drivers/ntb/hw/idt/ntb_hw_idt.c                    |   4 +-
 drivers/pci/controller/Kconfig                     |  11 +-
 drivers/pci/controller/Makefile                    |   2 +-
 drivers/pci/controller/dwc/Kconfig                 |  29 +-
 drivers/pci/controller/dwc/pci-dra7xx.c            | 231 +++++--
 drivers/pci/controller/dwc/pci-keystone.c          |   5 +-
 drivers/pci/controller/dwc/pci-meson.c             | 116 +---
 drivers/pci/controller/dwc/pcie-designware-ep.c    | 144 +++--
 drivers/pci/controller/dwc/pcie-designware.h       |  12 +
 drivers/pci/controller/dwc/pcie-qcom.c             |   8 +-
 drivers/pci/controller/dwc/pcie-tegra194.c         | 712 ++++++++++++++++++++-
 drivers/pci/controller/mobiveil/Kconfig            |  34 +
 drivers/pci/controller/mobiveil/Makefile           |   5 +
 .../pci/controller/mobiveil/pcie-layerscape-gen4.c | 267 ++++++++
 .../pcie-mobiveil-host.c}                          | 564 ++++------------
 .../pci/controller/mobiveil/pcie-mobiveil-plat.c   |  61 ++
 drivers/pci/controller/mobiveil/pcie-mobiveil.c    | 231 +++++++
 drivers/pci/controller/mobiveil/pcie-mobiveil.h    | 226 +++++++
 drivers/pci/controller/pci-hyperv.c                | 260 +++++---
 drivers/pci/controller/pci-tegra.c                 | 187 ++----
 drivers/pci/controller/pcie-brcmstb.c              |   4 +-
 drivers/pci/endpoint/functions/pci-epf-test.c      | 402 ++++++++++--
 drivers/pci/endpoint/pci-ep-cfs.c                  |  28 +-
 drivers/pci/endpoint/pci-epc-core.c                | 137 ++--
 drivers/pci/endpoint/pci-epc-mem.c                 |  10 +-
 drivers/pci/endpoint/pci-epf-core.c                |  35 +-
 drivers/pci/hotplug/pciehp.h                       |   1 +
 drivers/pci/hotplug/pciehp_hpc.c                   |  93 ++-
 drivers/pci/p2pdma.c                               |   3 +
 drivers/pci/pci-acpi.c                             |   4 +-
 drivers/pci/pci-sysfs.c                            |  33 +-
 drivers/pci/pci.c                                  |  25 +-
 drivers/pci/pci.h                                  |  32 +-
 drivers/pci/pcie/Kconfig                           |  10 +
 drivers/pci/pcie/Makefile                          |   1 +
 drivers/pci/pcie/aer.c                             |  40 +-
 drivers/pci/pcie/aspm.c                            |   6 +-
 drivers/pci/pcie/dpc.c                             | 137 ++--
 drivers/pci/pcie/edr.c                             | 239 +++++++
 drivers/pci/pcie/err.c                             |  66 +-
 drivers/pci/pcie/portdrv.h                         |   5 -
 drivers/pci/pcie/portdrv_core.c                    |  21 -
 drivers/pci/probe.c                                |  42 ++
 drivers/pci/quirks.c                               | 120 +++-
 drivers/pci/rom.c                                  |  17 -
 drivers/pci/setup-bus.c                            |  34 +-
 drivers/pci/slot.c                                 |  38 +-
 drivers/phy/amlogic/Kconfig                        |  22 +
 drivers/phy/amlogic/Makefile                       |  12 +-
 .../phy/amlogic/phy-meson-axg-mipi-pcie-analog.c   | 188 ++++++
 drivers/phy/amlogic/phy-meson-axg-pcie.c           | 192 ++++++
 drivers/scsi/lpfc/lpfc_attr.c                      |   4 +-
 include/linux/acpi.h                               |   6 +-
 include/linux/aer.h                                |   9 +-
 include/linux/pci-acpi.h                           |   8 +
 include/linux/pci-epc.h                            |  27 +-
 include/linux/pci-epf.h                            |  29 +-
 include/linux/pci.h                                |  10 +-
 include/linux/pci_ids.h                            |   2 +
 include/soc/tegra/bpmp-abi.h                       |  10 +-
 include/uapi/linux/pci_regs.h                      |   2 +
 include/uapi/linux/pcitest.h                       |   8 +
 tools/pci/pcitest.c                                |  37 +-
 88 files changed, 4832 insertions(+), 1631 deletions(-)
 create mode 100644 Documentation/PCI/boot-interrupts.rst
 delete mode 100644 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt
 create mode 100644 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
 create mode 100644 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/cdns-pcie-host.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/cdns-pcie.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/layerscape-pcie-gen4.txt
 create mode 100644 Documentation/devicetree/bindings/pci/pci-ep.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/amlogic,meson-axg-mipi-pcie-analog.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/amlogic,meson-axg-pcie.yaml
 create mode 100644 drivers/pci/controller/mobiveil/Kconfig
 create mode 100644 drivers/pci/controller/mobiveil/Makefile
 create mode 100644 drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c
 rename drivers/pci/controller/{pcie-mobiveil.c => mobiveil/pcie-mobiveil-host.c} (54%)
 create mode 100644 drivers/pci/controller/mobiveil/pcie-mobiveil-plat.c
 create mode 100644 drivers/pci/controller/mobiveil/pcie-mobiveil.c
 create mode 100644 drivers/pci/controller/mobiveil/pcie-mobiveil.h
 create mode 100644 drivers/pci/pcie/edr.c
 create mode 100644 drivers/phy/amlogic/phy-meson-axg-mipi-pcie-analog.c
 create mode 100644 drivers/phy/amlogic/phy-meson-axg-pcie.c
