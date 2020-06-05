Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 197C81F00EE
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jun 2020 22:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbgFEUXB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Jun 2020 16:23:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:49646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727960AbgFEUXB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Jun 2020 16:23:01 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3E44206E6;
        Fri,  5 Jun 2020 20:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591388579;
        bh=9guvPJMO8ZPbCognxOBpSdZnw4MQdgYCJiHRy1Rh9F8=;
        h=Date:From:To:Cc:Subject:From;
        b=RGzNPOsvbv1aDB1UvU64HUz68SJBgIh66Iw/maKakqUes1yZowXLy/bGvzn632XxH
         n0HyLoRJBNQ5srhCS703+Xy4V83UbyTKoNruDHlHiT2ee84ZL0iC0LaUItpHApqFnm
         nM7nQvsEJLw1VySBbBd6LTTbdOGILKZrhp2nquow=
Date:   Fri, 5 Jun 2020 15:22:57 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [GIT PULL] PCI changes for v5.8
Message-ID: <20200605202257.GA1152522@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.8-changes

for you to fetch changes up to 2bd81cd04a3f5eb873cc81fa16c469377be3b092:

  Merge branch 'remotes/lorenzo/pci/vmd' (2020-06-04 12:59:20 -0500)


You should see two conflicts:

  1) drivers/pci/quirks.c: conflict with my own for-linus branch; I
  resolved by moving apex_pci_fixup_class() to the end so the two
  PME-related quirks stay together.

  2) Documentation/devicetree/bindings/pci/cdns-pcie.yaml: conflict
  between Rob's 3d21a4609335 ("dt-bindings: Remove cases of 'allOf'
  containing a '$ref'") and Kishon's fb5f8f3ca5f8 ("dt-bindings: PCI:
  cadence: Deprecate inbound/outbound specific bindings").

  Kishon moved a hunk from cdns-pcie.yaml to cdns-pcie-ep.yaml and
  cdns-pcie-host.yaml, so I think the new homes need Rob's change:

    Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml
    Documentation/devicetree/bindings/pci/cdns-pcie-host.yaml

My resolution of these is below and at
https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?id=d1446bebeef8

diff --cc Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml
index 000000000000,6150a7a7bdbf..016a5f61592d
mode 000000,100644..100644
--- a/Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml
@@@ -1,0 -1,25 +1,24 @@@
+ # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+ %YAML 1.2
+ ---
+ $id: "http://devicetree.org/schemas/pci/cdns-pcie-ep.yaml#"
+ $schema: "http://devicetree.org/meta-schemas/core.yaml#"
+ 
+ title: Cadence PCIe Device
+ 
+ maintainers:
+   - Tom Joseph <tjoseph@cadence.com>
+ 
+ allOf:
+   - $ref: "cdns-pcie.yaml#"
+ 
+ properties:
+   cdns,max-outbound-regions:
+     description: maximum number of outbound regions
 -    allOf:
 -      - $ref: /schemas/types.yaml#/definitions/uint32
++    $ref: /schemas/types.yaml#/definitions/uint32
+     minimum: 1
+     maximum: 32
+     default: 32
+ 
+ required:
+   - cdns,max-outbound-regions
diff --cc Documentation/devicetree/bindings/pci/cdns-pcie-host.yaml
index cb4e700c0269,3d64f85aeb39..303078a7b7a8
--- a/Documentation/devicetree/bindings/pci/cdns-pcie-host.yaml
+++ b/Documentation/devicetree/bindings/pci/cdns-pcie-host.yaml
@@@ -14,6 -14,15 +14,14 @@@ allOf
    - $ref: "cdns-pcie.yaml#"
  
  properties:
+   cdns,max-outbound-regions:
+     description: maximum number of outbound regions
 -    allOf:
 -      - $ref: /schemas/types.yaml#/definitions/uint32
++    $ref: /schemas/types.yaml#/definitions/uint32
+     minimum: 1
+     maximum: 32
+     default: 32
+     deprecated: true
+ 
    cdns,no-bar-match-nbits:
      description:
        Set into the no BAR match register to configure the number of least
diff --cc drivers/pci/quirks.c
index ca9ed5774eb1,97df1f90160d..812bfc32ecb8
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@@ -5568,9 -5595,15 +5595,22 @@@ static void pci_fixup_no_d0_pme(struct 
  }
  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x2142, pci_fixup_no_d0_pme);
  
+ /*
+  * Device [12d8:0x400e] and [12d8:0x400f]
+  * These devices advertise PME# support in all power states but don't
+  * reliably assert it.
+  */
+ static void pci_fixup_no_pme(struct pci_dev *dev)
+ {
+ 	pci_info(dev, "PME# is unreliable, disabling it\n");
+ 	dev->pme_support = 0;
+ }
+ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_PERICOM, 0x400e, pci_fixup_no_pme);
+ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_PERICOM, 0x400f, pci_fixup_no_pme);
++
 +static void apex_pci_fixup_class(struct pci_dev *pdev)
 +{
 +	pdev->class = (PCI_CLASS_SYSTEM_OTHER << 8) | pdev->class;
 +}
 +DECLARE_PCI_FIXUP_CLASS_HEADER(0x1ac1, 0x089a,
 +			       PCI_CLASS_NOT_DEFINED, 8, apex_pci_fixup_class);

----------------------------------------------------------------

Enumeration:

  - Program MPS for RCiEP devices (Ashok Raj)

  - Fix pci_register_host_bridge() device_register() error handling (Rob
    Herring)

  - Fix pci_host_bridge struct device release/free handling (Rob Herring)

Resource management:

  - Allow resizing BARs for devices on root bus (Ard Biesheuvel)

Power management:

  - Reduce Thunderbolt resume time by working around devices that don't
    support DLL Link Active reporting (Mika Westerberg)

  - Work around a Pericom USB controller OHCI/EHCI PME# defect (Kai-Heng
    Feng)

Virtualization:

  - Add ACS quirk for Intel Root Complex Integrated Endpoints (Ashok Raj)

  - Avoid FLR for AMD Starship USB 3.0 (Kevin Buettner)

  - Avoid FLR for AMD Matisse HD Audio & USB 3.0 (Marcos Scriven)

Error handling:

  - Use only _OSC (not HEST FIRMWARE_FIRST) to determine AER ownership
    (Alexandru Gagniuc, Kuppuswamy Sathyanarayanan)

  - Reduce verbosity by logging only ACPI_NOTIFY_DISCONNECT_RECOVER events
    (Kuppuswamy Sathyanarayanan)

  - Don't enable AER by default in Kconfig (Bjorn Helgaas)

Peer-to-peer DMA:

  - Add AMD Zen Raven and Renoir Root Ports to whitelist (Alex Deucher)

ASPM:

  - Allow ASPM on links to PCIe-to-PCI/PCI-X Bridges (Kai-Heng Feng)

Endpoint framework:

  - Fix DMA channel release in test (Kunihiko Hayashi)

  - Add page size as argument to pci_epc_mem_init() (Lad Prabhakar)

  - Add support to handle multiple base for mapping outbound memory (Lad
    Prabhakar)

Generic host bridge driver:

  - Support building as module (Rob Herring)

  - Eliminate pci_host_common_probe wrappers (Rob Herring)

Amlogic Meson PCIe controller driver:

  - Don't use FAST_LINK_MODE to set up link (Marc Zyngier)

Broadcom STB PCIe controller driver:

  - Disable ASPM L0s if 'aspm-no-l0s' in DT (Jim Quinlan)

  - Fix clk_put() error (Jim Quinlan)

  - Fix window register offset (Jim Quinlan)

  - Assert fundamental reset on initialization (Nicolas Saenz Julienne)

  - Add notify xHCI reset property (Nicolas Saenz Julienne)

  - Add init routine for Raspberry Pi 4 VL805 USB controller (Nicolas Saenz
    Julienne)

  - Sync with Raspberry Pi 4 firmware for VL805 initialization (Nicolas
    Saenz Julienne)

Cadence PCIe controller driver:

  - Remove "cdns,max-outbound-regions" DT property (replaced by "ranges")
    (Kishon Vijay Abraham I)

  - Read 32-bit (not 16-bit) Vendor ID/Device ID property from DT (Kishon
    Vijay Abraham I)

Marvell Aardvark PCIe controller driver:

  - Improve link training (Marek Behún)

  - Add PHY support (Marek Behún)

  - Add "phys", "max-link-speed", "reset-gpios" to dt-binding  (Marek
    Behún)

  - Train link immediately after enabling training to work around detection
    issues with some cards (Pali Rohár)

  - Issue PERST via GPIO to work around detection issues (Pali Rohár)

  - Don't blindly enable ASPM L0s (Pali Rohár)

  - Replace custom macros by standard linux/pci_regs.h macros (Pali Rohár)

Microsoft Hyper-V host bridge driver:

  - Fix probe failure path to release resource (Wei Hu)

  - Retry PCI bus D0 entry on invalid device state for kdump (Wei Hu)

Renesas R-Car PCIe controller driver:

  - Fix incorrect programming of OB windows (Andrew Murray)

  - Add suspend/resume (Kazufumi Ikeda)

  - Rename pcie-rcar.c to pcie-rcar-host.c (Lad Prabhakar)

  - Add endpoint controller driver (Lad Prabhakar)

  - Fix PCIEPAMR mask calculation (Lad Prabhakar)

  - Add r8a77961 to DT binding (Yoshihiro Shimoda)

Socionext UniPhier Pro5 controller driver:

  - Add endpoint controller driver (Kunihiko Hayashi)

Synopsys DesignWare PCIe controller driver:

  - Program outbound ATU upper limit register (Alan Mikhak)

  - Fix inner MSI IRQ domain registration (Marc Zyngier)

Miscellaneous:

  - Check for platform_get_irq() failure consistently (negative return
    means failure) (Aman Sharma)

  - Fix several runtime PM get/put imbalances (Dinghao Liu)

  - Use flexible-array and struct_size() helpers for code cleanup (Gustavo
    A. R. Silva)

  - Update & fix issues in bridge emulation of PCIe registers (Jon Derrick)

  - Add macros for bridge window names (PCI_BRIDGE_IO_WINDOW, etc)
    (Krzysztof Wilczyński)

  - Work around Intel PCH MROMs that have invalid BARs (Xiaochun Lee)

----------------------------------------------------------------
Alan Mikhak (1):
      PCI: dwc: Program outbound ATU upper limit register

Alex Deucher (1):
      PCI/P2PDMA: Add AMD Zen Raven and Renoir Root Ports to whitelist

Alexandru Gagniuc (1):
      PCI/AER: Use only _OSC to determine AER ownership

Aman Sharma (1):
      PCI: Check for platform_get_irq() failure consistently

Andrew Murray (1):
      PCI: rcar: Fix incorrect programming of OB windows

Ani Sinha (1):
      PCI: pciehp: Remove unused EMI() and HP_SUPR_RM() macros

Ard Biesheuvel (1):
      PCI: Allow pci_resize_resource() for devices on root bus

Ashok Raj (2):
      PCI: Program MPS for RCiEP devices
      PCI: Add ACS quirk for Intel Root Complex Integrated Endpoints

Bjorn Helgaas (33):
      PCI/PM: Call .bridge_d3() hook only if non-NULL
      PCI: dra7xx: Don't select CONFIG_PCI_DRA7XX_HOST by default
      PCI: keystone: Don't select CONFIG_PCI_KEYSTONE_HOST by default
      PCI/AER: Don't select CONFIG_PCIEAER by default
      driver core: platform: Clarify that IRQ 0 is invalid
      PCI/PM: Adjust pcie_wait_for_link_delay() for caller delay
      PCI/PTM: Inherit Switch Downstream Port PTM settings from Upstream Port
      PCI/AER: Use "aer" variable for capability offset
      Merge branch 'pci/aspm'
      Merge branch 'pci/enumeration'
      Merge branch 'pci/error'
      Merge branch 'pci/hotplug'
      Merge branch 'pci/kconfig'
      Merge branch 'pci/misc'
      Merge branch 'pci/p2pdma'
      Merge branch 'pci/pm'
      Merge branch 'pci/resource'
      Merge branch 'pci/switchtec'
      Merge branch 'pci/virtualization'
      Merge branch 'remotes/lorenzo/pci/aardvark'
      Merge branch 'remotes/lorenzo/pci/altera'
      Merge branch 'remotes/lorenzo/pci/brcmstb'
      Merge branch 'remotes/lorenzo/pci/cadence'
      Merge branch 'remotes/lorenzo/pci/dwc'
      Merge branch 'remotes/lorenzo/pci/endpoint'
      Merge branch 'remotes/lorenzo/pci/host-generic'
      Merge branch 'remotes/lorenzo/pci/hv'
      Merge branch 'remotes/lorenzo/pci/misc'
      Merge branch 'remotes/lorenzo/pci/pci-bridge-emul'
      Merge branch 'remotes/lorenzo/pci/rcar'
      Merge branch 'remotes/lorenzo/pci/tegra'
      Merge branch 'remotes/lorenzo/pci/v3-semi'
      Merge branch 'remotes/lorenzo/pci/vmd'

Bryce Willey (1):
      Documentation: PCI: Give unique labels to sections

Christophe JAILLET (1):
      PCI: v3-semi: Fix a memory leak in v3_pci_probe() error handling paths

Colin Ian King (1):
      PCI: altera: Clean up indentation issue on a return statement

Dinghao Liu (2):
      PCI: tegra194: Fix runtime PM imbalance on error
      PCI: tegra: Fix runtime PM imbalance on error

Gustavo A. R. Silva (2):
      PCI: Replace zero-length array with flexible-array
      PCI: hv: Use struct_size() helper

Jason Yan (1):
      PCI: dwc: intel: Make intel_pcie_cpu_addr() static

Jay Fang (1):
      PCI/PME: Fix kernel-doc of pcie_pme_resume() and pcie_pme_remove()

Jim Quinlan (4):
      PCI: brcmstb: Don't clk_put() a managed clock
      PCI: brcmstb: Fix window register offset from 4 to 8
      dt-bindings: PCI: brcmstb: New prop 'aspm-no-l0s'
      PCI: brcmstb: Disable L0s component of ASPM if requested

Jiri Slaby (1):
      PCI: dwc: Clean up computing of msix_tbl

Jon Derrick (5):
      PCI: pci-bridge-emul: Fix PCIe bit conflicts
      PCI: pci-bridge-emul: Fix Root Cap/Status comment
      PCI: pci-bridge-emul: Update for PCIe 5.0 r1.0
      PCI: pci-bridge-emul: Eliminate the 'reserved' member
      PCI: vmd: Filter resource type bits from shadow register

Kai-Heng Feng (3):
      PCI/ASPM: Allow ASPM on links to PCIe-to-PCI/PCI-X Bridges
      serial: 8250_pci: Move Pericom IDs to pci_ids.h
      PCI: Avoid Pericom USB controller OHCI/EHCI PME# defect

Kazufumi Ikeda (1):
      PCI: rcar: Add suspend/resume

Kevin Buettner (1):
      PCI: Avoid FLR for AMD Starship USB 3.0

Kishon Vijay Abraham I (4):
      dt-bindings: PCI: cadence: Deprecate inbound/outbound specific bindings
      PCI: cadence: Remove "cdns,max-outbound-regions" DT property
      PCI: cadence: Fix to read 32-bit Vendor ID/Device ID property from DT
      PCI: dwc: Use private data pointer of "struct irq_domain" to get pcie_port

Krzysztof Wilczynski (4):
      PCI/switchtec: Correct bool variable type assignment
      PCI: shpchp: Make shpchp_unconfigure_device() void
      PCI: Use bridge window names (PCI_BRIDGE_IO_WINDOW etc)
      pcmcia: Use CardBus window names (PCI_CB_BRIDGE_IO_0_WINDOW etc) when freeing

Krzysztof Wilczyński (1):
      PCI: Rename _DSM constants to align with spec

Kunihiko Hayashi (3):
      PCI: endpoint: functions/pci-epf-test: Fix DMA channel release
      dt-bindings: PCI: Add UniPhier PCIe endpoint controller description
      PCI: uniphier: Add Socionext UniPhier Pro5 PCIe endpoint controller driver

Kuppuswamy Sathyanarayanan (4):
      PCI/EDR: Log only ACPI_NOTIFY_DISCONNECT_RECOVER events
      PCI/AER: Remove HEST/FIRMWARE_FIRST parsing for AER ownership
      PCI/AER: Remove redundant pci_is_pcie() checks
      PCI/AER: Remove redundant dev->aer_cap checks

Lad Prabhakar (8):
      PCI: rcar: Rename pcie-rcar.c to pcie-rcar-host.c
      PCI: rcar: Move shareable code to a common file
      PCI: rcar: Fix calculating mask for PCIEPAMR register
      PCI: endpoint: Pass page size as argument to pci_epc_mem_init()
      PCI: endpoint: Add support to handle multiple base for mapping outbound memory
      dt-bindings: PCI: rcar: Add bindings for R-Car PCIe endpoint controller
      PCI: rcar: Add endpoint mode support
      MAINTAINERS: Add file patterns for rcar PCI device tree bindings

Lukas Bulwahn (1):
      MAINTAINERS: correct typo in new NXP LAYERSCAPE GEN4

Marc Zyngier (2):
      PCI: dwc: Fix inner MSI IRQ domain registration
      PCI: amlogic: meson: Don't use FAST_LINK_MODE to set up link

Marcos Scriven (1):
      PCI: Avoid FLR for AMD Matisse HD Audio & USB 3.0

Marek Behún (3):
      PCI: aardvark: Improve link training
      PCI: aardvark: Add PHY support
      dt-bindings: PCI: aardvark: Describe new properties

Mika Westerberg (1):
      PCI/PM: Assume ports without DLL Link Active train links in 100 ms

Nicolas Saenz Julienne (5):
      PCI: brcmstb: Assert fundamental reset on initialization
      soc: bcm2835: Add notify xHCI reset property
      firmware: raspberrypi: Introduce vl805 init routine
      PCI: brcmstb: Wait for Raspberry Pi's firmware when present
      USB: pci-quirks: Add Raspberry Pi 4 quirk

Pali Rohár (7):
      PCI: tegra: Fix reporting GPIO error value
      PCI: aardvark: Train link immediately after enabling training
      PCI: aardvark: Don't blindly enable ASPM L0s and don't write to read-only register
      PCI: of: Zero max-link-speed value is invalid
      PCI: aardvark: Issue PERST via GPIO
      PCI: aardvark: Add FIXME comment for PCIE_CORE_CMD_STATUS_REG access
      PCI: aardvark: Replace custom macros by standard linux/pci_regs.h macros

Rob Herring (6):
      PCI: Use of_node_name_eq() for node name comparisons
      PCI: Constify struct pci_ecam_ops
      PCI: host-generic: Support building as modules
      PCI: host-generic: Eliminate pci_host_common_probe wrappers
      PCI: Fix pci_register_host_bridge() device_register() error handling
      PCI: Fix pci_host_bridge struct device release/free handling

Wei Hu (2):
      PCI: hv: Fix the PCI HyperV probe failure path to release resource properly
      PCI: hv: Retry PCI bus D0 entry on invalid device state

Wei Liu (1):
      x86/PCI: Drop unused xen_register_pirq() gsi_override parameter

Wei Yongjun (1):
      PCI: dwc: pci-dra7xx: Use devm_platform_ioremap_resource_byname()

Xiaochun Lee (1):
      x86/PCI: Mark Intel C620 MROMs as having non-compliant BARs

Yicong Yang (2):
      PCI: Unify pcie_find_root_port() and pci_find_pcie_root_port()
      PCI/DPC: Print IRQ number used by port

Yoshihiro Shimoda (1):
      dt-bindings: pci: rcar: add r8a77961 support

Zou Wei (1):
      PCI: dwc: Make hisi_pcie_platform_ops static

 Documentation/PCI/endpoint/pci-endpoint.rst        |   16 +-
 .../devicetree/bindings/pci/aardvark-pci.txt       |    4 +
 .../devicetree/bindings/pci/brcm,stb-pcie.yaml     |    2 +
 .../devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml |    2 +-
 .../bindings/pci/cdns,cdns-pcie-host.yaml          |    3 +-
 .../devicetree/bindings/pci/cdns-pcie-ep.yaml      |   25 +
 .../devicetree/bindings/pci/cdns-pcie-host.yaml    |   10 +
 .../devicetree/bindings/pci/cdns-pcie.yaml         |    8 -
 .../devicetree/bindings/pci/rcar-pci-ep.yaml       |   77 ++
 Documentation/devicetree/bindings/pci/rcar-pci.txt |    3 +-
 .../bindings/pci/socionext,uniphier-pcie-ep.yaml   |   92 ++
 MAINTAINERS                                        |    7 +-
 arch/arm64/kernel/pci.c                            |    4 +-
 arch/x86/pci/fixup.c                               |    4 +
 arch/x86/pci/xen.c                                 |   16 +-
 drivers/acpi/pci_mcfg.c                            |    8 +-
 drivers/acpi/pci_root.c                            |   11 +-
 drivers/base/platform.c                            |   40 +-
 drivers/firmware/Kconfig                           |    3 +-
 drivers/firmware/raspberrypi.c                     |   61 +
 drivers/pci/controller/Kconfig                     |   22 +-
 drivers/pci/controller/Makefile                    |    3 +-
 drivers/pci/controller/cadence/pcie-cadence-ep.c   |    2 +-
 drivers/pci/controller/cadence/pcie-cadence-host.c |   10 +-
 drivers/pci/controller/cadence/pcie-cadence.h      |    6 +-
 drivers/pci/controller/dwc/Kconfig                 |   17 +-
 drivers/pci/controller/dwc/Makefile                |    1 +
 drivers/pci/controller/dwc/pci-dra7xx.c            |    8 +-
 drivers/pci/controller/dwc/pci-imx6.c              |    4 +-
 drivers/pci/controller/dwc/pci-meson.c             |    4 +-
 drivers/pci/controller/dwc/pcie-al.c               |    2 +-
 drivers/pci/controller/dwc/pcie-designware-ep.c    |   22 +-
 drivers/pci/controller/dwc/pcie-designware-host.c  |    4 +-
 drivers/pci/controller/dwc/pcie-designware.c       |    7 +-
 drivers/pci/controller/dwc/pcie-designware.h       |    3 +-
 drivers/pci/controller/dwc/pcie-hisi.c             |   19 +-
 drivers/pci/controller/dwc/pcie-intel-gw.c         |    2 +-
 drivers/pci/controller/dwc/pcie-tegra194.c         |    9 +-
 drivers/pci/controller/dwc/pcie-uniphier-ep.c      |  383 +++++++
 .../pci/controller/mobiveil/pcie-mobiveil-host.c   |    4 +-
 drivers/pci/controller/pci-aardvark.c              |  266 ++++-
 drivers/pci/controller/pci-host-common.c           |   18 +-
 drivers/pci/controller/pci-host-generic.c          |   26 +-
 drivers/pci/controller/pci-hyperv.c                |   82 +-
 drivers/pci/controller/pci-tegra.c                 |    7 +-
 drivers/pci/controller/pci-thunder-ecam.c          |   14 +-
 drivers/pci/controller/pci-thunder-pem.c           |   16 +-
 drivers/pci/controller/pci-v3-semi.c               |    6 +-
 drivers/pci/controller/pci-xgene.c                 |    4 +-
 drivers/pci/controller/pcie-altera.c               |    2 +-
 drivers/pci/controller/pcie-brcmstb.c              |   37 +-
 drivers/pci/controller/pcie-mediatek.c             |    3 +
 drivers/pci/controller/pcie-rcar-ep.c              |  563 +++++++++
 drivers/pci/controller/pcie-rcar-host.c            | 1130 ++++++++++++++++++
 drivers/pci/controller/pcie-rcar.c                 | 1211 +-------------------
 drivers/pci/controller/pcie-rcar.h                 |  140 +++
 drivers/pci/controller/pcie-rockchip-ep.c          |    2 +-
 drivers/pci/controller/pcie-tango.c                |   13 +-
 drivers/pci/controller/vmd.c                       |    6 +-
 drivers/pci/ecam.c                                 |   10 +-
 drivers/pci/endpoint/functions/pci-epf-test.c      |    3 +
 drivers/pci/endpoint/pci-epc-mem.c                 |  204 +++-
 drivers/pci/hotplug/pciehp.h                       |    2 -
 drivers/pci/hotplug/rpaphp_core.c                  |    2 +-
 drivers/pci/hotplug/shpchp.h                       |    2 +-
 drivers/pci/hotplug/shpchp_ctrl.c                  |    3 +-
 drivers/pci/hotplug/shpchp_pci.c                   |    5 +-
 drivers/pci/of.c                                   |    2 +-
 drivers/pci/p2pdma.c                               |    2 +
 drivers/pci/pci-acpi.c                             |    6 +-
 drivers/pci/pci-bridge-emul.c                      |   61 +-
 drivers/pci/pci-label.c                            |    4 +-
 drivers/pci/pci.c                                  |   64 +-
 drivers/pci/pcie/Kconfig                           |    1 -
 drivers/pci/pcie/aer.c                             |  340 ++----
 drivers/pci/pcie/aspm.c                            |   10 -
 drivers/pci/pcie/dpc.c                             |    3 +-
 drivers/pci/pcie/edr.c                             |    4 +-
 drivers/pci/pcie/pme.c                             |    4 +-
 drivers/pci/pcie/portdrv.h                         |   13 +-
 drivers/pci/pcie/ptm.c                             |   22 +-
 drivers/pci/probe.c                                |   65 +-
 drivers/pci/quirks.c                               |   50 +-
 drivers/pci/remove.c                               |    2 +-
 drivers/pci/setup-bus.c                            |  115 +-
 drivers/pci/setup-res.c                            |    9 +-
 drivers/pci/switch/switchtec.c                     |    2 +-
 drivers/pcmcia/yenta_socket.c                      |   40 +-
 drivers/thunderbolt/switch.c                       |    4 +-
 drivers/tty/serial/8250/8250_pci.c                 |    6 -
 drivers/usb/host/pci-quirks.c                      |   16 +
 include/linux/pci-acpi.h                           |   18 +-
 include/linux/pci-ecam.h                           |   25 +-
 include/linux/pci-epc.h                            |   38 +-
 include/linux/pci.h                                |   43 +-
 include/linux/pci_ids.h                            |    6 +
 include/soc/bcm2835/raspberrypi-firmware.h         |    9 +-
 97 files changed, 3682 insertions(+), 2007 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-uniphier-ep.c
 create mode 100644 drivers/pci/controller/pcie-rcar-ep.c
 create mode 100644 drivers/pci/controller/pcie-rcar-host.c
 create mode 100644 drivers/pci/controller/pcie-rcar.h
