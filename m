Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8BB295417
	for <lists+linux-pci@lfdr.de>; Wed, 21 Oct 2020 23:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505696AbgJUVYt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Oct 2020 17:24:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:44668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2505810AbgJUVYs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 21 Oct 2020 17:24:48 -0400
Received: from localhost (170.sub-72-107-125.myvzw.com [72.107.125.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AE5120848;
        Wed, 21 Oct 2020 21:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603315485;
        bh=0ujxCMDq/Kuzsa7k0HhxKyNBmV6sMXg07SilApHaXQA=;
        h=Date:From:To:Cc:Subject:From;
        b=ldtVpLzQwJw4j6dVsZjFVOp8N3YQpG6vub4em6mJAMkLf+1B9Ig9JmFXPk9J+KqsI
         kNUPpLgGE6peKtj27c8/+2hhjTo2GFJ6eRVuofCZDURsDkV1msa89me+XRVVHJ7UKG
         fNp11a1bQ+dDE9ImztOOmRnPnVXCAJ0r/tSUxv/M=
Date:   Wed, 21 Oct 2020 16:24:43 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [GIT PULL] PCI changes for v5.10
Message-ID: <20201021212443.GA466346@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.10-changes

for you to fetch changes up to 28e34e751f6c50098d9bcecb30c97634b6126730:

  Merge branch 'remotes/lorenzo/pci/xilinx' (2020-10-21 09:58:44 -0500)

----------------------------------------------------------------

You should see the following conflicts:

1) drivers/pci/controller/vmd.c
     upstream 585dfe8abc44 ("PCI: vmd: Dont abuse vector irqomain as parent")
     PCI      42443f036042 ("PCI: vmd: Create IRQ Domain configuration helper")

     Upstream replaced pci_msi_create_irq_domain() parent argument
     "x86_vector_domain" with "NULL".  PCI moved
     pci_msi_create_irq_domain() call to new vmd_create_irq_domain().

     Replace "x86_vector_domain" with "NULL" in vmd_create_irq_domain().

2) drivers/pci/controller/pcie-brcmstb.c
     upstream f48cc509c935 ("Revert "PCI: brcmstb: Wait for Raspberry Pi's firmware when present"")
     PCI      1cf1b0a6dd95 ("PCI: brcmstb: Add bcm7278 register info")

     Upstream removed "struct device_node *fw_np".  PCI added "const struct
     pcie_cfg_data *data" on the next line.

     Remove "*fw_np", "add "*data".

3) drivers/pci/controller/dwc/pci-imx6.c
     upstream df561f6688fe ("treewide: Use fallthrough pseudo-keyword")
     PCI      61660dbf08e1 ("PCI: imx6: Do not output error message when devm_clk_get() failed with -EPROBE_DEFER")
          use dev_err_probe() instead of dev_err()

     Upstream converted "/* fall through */" to "fallthrough".  PCI
     converted dev_err() and "return PTR_ERR()" to "return dev_err_probe()"
     nearby.

     Accept PCI version unchanged.

----------------------------------------------------------------

Enumeration:
  - Print IRQ number used by PCIe Link Bandwidth Notification (Dongdong
    Liu)
  - Add schedule point in pci_read_config() to reduce max latency (Jiang
    Biao)
  - Add Kconfig options for MPS/MRRS strategy (Jim Quinlan)

Resource management:
  - Fix pci_iounmap() memory leak when !CONFIG_GENERIC_IOMAP (Lorenzo
    Pieralisi)

PCIe native device hotplug:
  - Reduce noisiness on hot removal (Lukas Wunner)

Power management:
  - Revert "PCI/PM: Apply D2 delay as milliseconds, not microseconds" that
    was done on the basis of spec typo (Bjorn Helgaas)
  - Rename pci_dev.d3_delay to d3hot_delay to remove D3hot/D3cold ambiguity
    (Krzysztof Wilczyński)
  - Remove unused pcibios_pm_ops (Vaibhav Gupta)

IOMMU:
  - Enable Translation Blocking for external devices to harden against DMA
    attacks (Rajat Jain)

Error handling:
  - Add an ACPI APEI notifier chain for vendor CPER records to enable
    device-specific error handling (Shiju Jose)

ASPM:
  - Remove struct aspm_register_info to simplify code (Saheed O. Bolarinwa)

Amlogic Meson PCIe controller driver:
  - Build as module by default (Kevin Hilman)

Ampere Altra PCIe controller driver:
  - Add MCFG quirk to work around non-standard ECAM implementation (Tuan
    Phan)

Broadcom iProc PCIe controller driver:
  - Set affinity mask on MSI interrupts (Mark Tomlinson)

Broadcom STB PCIe controller driver:
  - Make PCIE_BRCMSTB depend on ARCH_BRCMSTB (Jim Quinlan)
  - Add DT bindings for more Brcmstb chips (Jim Quinlan)
  - Add bcm7278 register info (Jim Quinlan)
  - Add bcm7278 PERST# support (Jim Quinlan)
  - Add suspend and resume pm_ops (Jim Quinlan)
  - Add control of rescal reset (Jim Quinlan)
  - Set additional internal memory DMA viewport sizes (Jim Quinlan)
  - Accommodate MSI for older chips (Jim Quinlan)
  - Set bus max burst size by chip type (Jim Quinlan)
  - Add support for bcm7211, bcm7216, bcm7445, bcm7278 (Jim Quinlan)

Freescale i.MX6 PCIe controller driver:
  - Use dev_err_probe() to reduce redundant messages (Anson Huang)

Freescale Layerscape PCIe controller driver:
  - Enforce 4K DMA buffer alignment in endpoint test (Hou Zhiqiang)
  - Add DT compatible strings for ls1088a, ls2088a (Xiaowei Bao)
  - Add endpoint support for ls1088a, ls2088a (Xiaowei Bao)
  - Add endpoint test support for lS1088a (Xiaowei Bao)
  - Add MSI-X support for ls1088a (Xiaowei Bao)

HiSilicon HIP PCIe controller driver:
  - Handle HIP-specific errors via ACPI APEI (Yicong Yang)

HiSilicon Kirin PCIe controller driver:
  - Return -EPROBE_DEFER if the GPIO isn't ready (Bean Huo)

Intel VMD host bridge driver:
  - Factor out physical offset, bus offset, IRQ domain, IRQ allocation (Jon
    Derrick) 
  - Use generic PCI PM correctly (Jon Derrick)

Marvell Aardvark PCIe controller driver:
  - Fix compilation on s390 (Pali Rohár)
  - Implement driver 'remove' function and allow to build it as module
    (Pali Rohár)
  - Move PCIe reset card code to advk_pcie_train_link() (Pali Rohár)
  - Convert mvebu a3700 internal SMCC firmware return codes to errno (Pali
    Rohár)
  - Fix initialization with old Marvell's Arm Trusted Firmware (Pali Rohár)

Microsoft Hyper-V host bridge driver:
  - Fix hibernation in case interrupts are not re-created (Dexuan Cui)

NVIDIA Tegra PCIe controller driver:
  - Stop checking return value of debugfs_create() functions (Greg
    Kroah-Hartman)
  - Convert to use DEFINE_SEQ_ATTRIBUTE macro (Liu Shixin)

Qualcomm PCIe controller driver:
  - Reset PCIe to work around Qsdk U-Boot issue (Ansuel Smith)

Renesas R-Car PCIe controller driver:
  - Add DT documentation for r8a774a1, r8a774b1, r8a774e1 endpoints (Lad
    Prabhakar)
  - Add RZ/G2M, RZ/G2N, RZ/G2H IDs to endpoint test (Lad Prabhakar)
  - Add DT support for r8a7742 (Lad Prabhakar)

Socionext UniPhier Pro5 controller driver:
  - Add DT descriptions of iATU register (host and endpoint) (Kunihiko
    Hayashi)

Synopsys DesignWare PCIe controller driver:
  - Add link up check in dw_child_pcie_ops.map_bus() (racy, but seems
    unavoidable) (Hou Zhiqiang)
  - Fix endpoint Header Type check so multi-function devices work (Hou
    Zhiqiang)
  - Skip PCIE_MSI_INTR0* programming if MSI is disabled (Jisheng Zhang)
  - Stop leaking MSI page in suspend/resume (Jisheng Zhang)
  - Add common iATU register support instead of keystone-specific code
    (Kunihiko Hayashi)
  - Major config space access and other cleanups in dwc core and drivers
    that use it (al, exynos, histb, imx6, intel-gw, keystone, kirin, meson,
    qcom, tegra) (Rob Herring)
  - Add multiple PFs support for endpoint (Xiaowei Bao)
  - Add MSI-X doorbell mode in endpoint mode (Xiaowei Bao)

Miscellaneous:
  - Use fallthrough pseudo-keyword (Gustavo A. R. Silva)
  - Fix "0 used as NULL pointer" warnings (Gustavo Pimentel)
  - Fix "cast truncates bits from constant value" warnings (Gustavo
    Pimentel)
  - Remove redundant zeroing for sg_init_table() (Julia Lawall)
  - Use scnprintf(), not snprintf(), in sysfs "show" functions (Krzysztof
    Wilczyński)
  - Remove unused assignments (Krzysztof Wilczyński)
  - Fix "0 used as NULL pointer" warning (Krzysztof Wilczyński)
  - Simplify bool comparisons (Krzysztof Wilczyński)
  - Use for_each_child_of_node() and for_each_node_by_name() (Qinglang
    Miao)
  - Simplify return expressions (Qinglang Miao)

----------------------------------------------------------------
Anson Huang (1):
      PCI: imx6: Do not output error message when devm_clk_get() failed with -EPROBE_DEFER

Ansuel Smith (1):
      PCI: qcom: Make sure PCIe is reset before init for rev 2.1.0

Bean Huo (1):
      PCI: kirin: Return -EPROBE_DEFER in case the gpio isn't ready

Bjorn Helgaas (34):
      PCI/PM: Remove unused PCI_PM_BUS_WAIT
      PCI/PM: Revert "PCI/PM: Apply D2 delay as milliseconds, not microseconds"
      PCI/ASPM: Move pci_clear_and_set_dword() earlier
      PCI/ASPM: Move LTR path check to where it's used
      PCI/ASPM: Use 'parent' and 'child' for readability
      PCI/ASPM: Remove struct aspm_register_info.l1ss_ctl2 (unused)
      PCI/ASPM: Pass L1SS Capabilities value, not struct aspm_register_info
      Merge branch 'pci/acs'
      Merge branch 'pci/aspm'
      Merge branch 'pci/enumeration'
      Merge branch 'pci/hotplug'
      Merge branch 'pci/pm'
      Merge branch 'pci/misc'
      Merge branch 'remotes/lorenzo/pci/apei'
      Merge branch 'remotes/lorenzo/pci/pci-iomap'
      Merge branch 'remotes/lorenzo/pci/arm'
      Merge branch 'remotes/lorenzo/pci/aardvark'
      Merge branch 'remotes/lorenzo/pci/brcmstb'
      Merge branch 'remotes/lorenzo/pci/cadence'
      Merge branch 'remotes/lorenzo/pci/dwc'
      Merge branch 'remotes/lorenzo/pci/hv'
      Merge branch 'remotes/lorenzo/pci/imx6'
      Merge branch 'remotes/lorenzo/pci/iproc'
      Merge branch 'remotes/lorenzo/pci/kirin'
      Merge branch 'remotes/lorenzo/pci/loongson'
      Merge branch 'remotes/lorenzo/pci/meson'
      Merge branch 'remotes/lorenzo/pci/mobiveil'
      Merge branch 'remotes/lorenzo/pci/mvebu'
      Merge branch 'remotes/lorenzo/pci/qcom'
      Merge branch 'remotes/lorenzo/pci/rcar'
      Merge branch 'remotes/lorenzo/pci/tegra'
      Merge branch 'pci/vmd'
      Merge branch 'remotes/lorenzo/pci/xgene'
      Merge branch 'remotes/lorenzo/pci/xilinx'

Clint Sbisa (1):
      PCI: Update mmap-related #ifdef comments

Dexuan Cui (1):
      PCI: hv: Fix hibernation in case interrupts are not re-created

Dongdong Liu (1):
      PCI/LINK: Print IRQ number used by port

Flavio Suligoi (1):
      PCI: cadence-ep: Remove obsolete path from comment

Greg Kroah-Hartman (1):
      PCI: tegra: No need to check return value of debugfs_create() functions

Gustavo A. R. Silva (2):
      PCI: rcar-gen2: Use fallthrough pseudo-keyword
      PCI: imx6: Use fallthrough pseudo-keyword

Gustavo Pimentel (3):
      PCI: Remove unnecessary header includes
      PCI: endpoint: Use "NULL" instead of "0" as a NULL pointer
      PCI: dwc: Fix 'cast truncates bits from constant value'

Hou Zhiqiang (3):
      PCI: designware-ep: Fix the Header Type check
      misc: pci_endpoint_test: Add driver data for Layerscape PCIe controllers
      PCI: dwc: Add link up check in dw_child_pcie_ops.map_bus()

Jeremy Linton (1):
      PCI/ACPI: Tone down missing MCFG message

Jiang Biao (1):
      PCI: Add schedule point in pci_read_config()

Jim Quinlan (11):
      PCI: brcmstb: PCIE_BRCMSTB depends on ARCH_BRCMSTB
      dt-bindings: PCI: Add bindings for more Brcmstb chips
      PCI: brcmstb: Add bcm7278 register info
      PCI: brcmstb: Add suspend and resume pm_ops
      PCI: brcmstb: Add bcm7278 PERST# support
      PCI: Add Kconfig options for MPS/MRRS strategy
      PCI: brcmstb: Add control of rescal reset
      PCI: brcmstb: Set additional internal memory DMA viewport sizes
      PCI: brcmstb: Accommodate MSI for older chips
      PCI: brcmstb: Set bus max burst size by chip type
      PCI: brcmstb: Add bcm7211, bcm7216, bcm7445, bcm7278 to match list

Jisheng Zhang (2):
      PCI: dwc: Skip PCIE_MSI_INTR0* programming if MSI is disabled
      PCI: dwc: Fix MSI page leakage in suspend/resume

Jon Derrick (5):
      PCI: vmd: Create physical offset helper
      PCI: vmd: Create bus offset configuration helper
      PCI: vmd: Create IRQ Domain configuration helper
      PCI: vmd: Create IRQ allocation helper
      PCI: vmd: Update VMD PM to correctly use generic PCI PM

Julia Lawall (1):
      PCI/P2PDMA: Drop double zeroing for sg_init_table()

Kevin Hilman (1):
      PCI: meson: Build as module by default

Krzysztof Wilczyński (6):
      PCI: Use scnprintf(), not snprintf(), in sysfs "show" functions
      PCI: shpchp: Remove unused 'rc' assignment
      PCI/PM: Rename pci_dev.d3_delay to d3hot_delay
      PCI: Simplify bool comparisons
      PCI: xgene: Remove unused assignment to variable msi_val
      PCI: iproc: Fix using plain integer as NULL pointer in iproc_pcie_pltfm_probe

Kunihiko Hayashi (4):
      dt-bindings: PCI: uniphier: Add iATU register description
      dt-bindings: PCI: uniphier-ep: Add iATU register description
      PCI: dwc: Add common iATU register support
      PCI: keystone: Remove iATU register mapping

Lad Prabhakar (5):
      dt-bindings: pci: rcar-pci-ep: Document r8a774a1 and r8a774b1
      misc: pci_endpoint_test: Add Device ID for RZ/G2M and RZ/G2N PCIe controllers
      dt-bindings: pci: rcar-pci-ep: Document r8a774e1
      misc: pci_endpoint_test: Add Device ID for RZ/G2H PCIe controller
      dt-bindings: PCI: rcar: Add device tree support for r8a7742

Liu Shixin (4):
      PCI/IOV: Simplify pci-pf-stub with module_pci_driver()
      PCI: tegra: Convert to use DEFINE_SEQ_ATTRIBUTE macro
      PCI: iproc: Use module_bcma_driver to simplify the code
      PCI: mobiveil: Simplify mobiveil_pcie_init_irq_domain() return expression

Lorenzo Pieralisi (6):
      PCI: xilinx-cpm: Remove leftover bridge initialization
      PCI: mvebu: Remove useless msi_controller pointer allocation
      ARM/PCI: Remove unused fields from struct hw_pci
      sparc32: Remove useless io_32.h __KERNEL__ preprocessor guard
      sparc32: Move ioremap/iounmap declaration before asm-generic/io.h include
      asm-generic/io.h: Fix !CONFIG_GENERIC_IOMAP pci_iounmap() implementation

Lukas Wunner (2):
      PCI: pciehp: Reduce noisiness on hot removal
      PCI: Simplify pci_dev_reset_slot_function()

Mark Tomlinson (1):
      PCI: iproc: Set affinity mask on MSI interrupts

Pali Rohár (7):
      PCI: aardvark: Fix compilation on s390
      PCI: aardvark: Check for errors from pci_bridge_emul_init() call
      PCI: pci-bridge-emul: Export API functions
      PCI: aardvark: Implement driver 'remove' function and allow to build it as module
      PCI: aardvark: Move PCIe reset card code to advk_pcie_train_link()
      phy: marvell: comphy: Convert internal SMCC firmware return codes to errno
      PCI: aardvark: Fix initialization with old Marvell's Arm Trusted Firmware

Qinglang Miao (3):
      PCI: rpadlpar: Use for_each_child_of_node() and for_each_node_by_name()
      PCI: cadence: Simplify cdns_pcie_host_init_address_translation() return expression
      PCI: loongson: Simplify loongson_pci_probe() return expression

Rajat Jain (1):
      PCI/ACS: Enable Translation Blocking for external devices

Randy Dunlap (1):
      x86/PCI: Fix intel_mid_pci.c build error when ACPI is not enabled

Rob Herring (40):
      PCI: Allow root and child buses to have different pci_ops
      PCI: dwc: Use DBI accessors instead of own config accessors
      PCI: dwc: Allow overriding bridge pci_ops
      PCI: dwc: Add a default pci_ops.map_bus for root port
      PCI: dwc: al: Use pci_ops for child config space accessors
      PCI: dwc: keystone: Use pci_ops for config space accessors
      PCI: dwc: tegra: Use pci_ops for root config space accessors
      PCI: dwc: meson: Use pci_ops for root config space accessors
      PCI: dwc: kirin: Use pci_ops for root config space accessors
      PCI: dwc: exynos: Use pci_ops for root config space accessors
      PCI: dwc: histb: Use pci_ops for root config space accessors
      PCI: dwc: Remove dwc specific config accessor ops
      PCI: dwc: Use generic config accessors
      PCI: Also call .add_bus() callback for root bus
      PCI: dwc: keystone: Convert .scan_bus() callback to use add_bus
      PCI: dwc: Convert to use pci_host_probe()
      PCI: dwc: Remove root_bus pointer
      PCI: dwc: Remove storing of PCI resources
      PCI: dwc: Simplify config space handling
      PCI: dwc/keystone: Drop duplicated 'num-viewport'
      PCI: dwc: Check CONFIG_PCI_MSI inside dw_pcie_msi_init()
      PCI: dwc/imx6: Remove duplicate define PCIE_LINK_WIDTH_SPEED_CONTROL
      PCI: dwc: Add a 'num_lanes' field to struct dw_pcie
      PCI: dwc: Ensure FAST_LINK_MODE is cleared
      PCI: dwc/meson: Drop the duplicate number of lanes setup
      PCI: dwc/meson: Drop unnecessary RC config space initialization
      PCI: dwc/meson: Rework PCI config and DW port logic register accesses
      PCI: dwc/imx6: Use common PCI register definitions
      PCI: dwc/qcom: Use common PCI register definitions
      PCI: dwc: Remove hardcoded PCI_CAP_ID_EXP offset
      PCI: dwc/tegra: Use common Designware port logic register definitions
      PCI: dwc: Remove read_dbi2 code
      PCI: dwc: Make ATU accessors private
      PCI: dwc: Centralize link gen setting
      PCI: dwc: Set PORT_LINK_DLL_LINK_EN in common setup code
      PCI: dwc/intel-gw: Drop unnecessary checking of DT 'device_type' property
      PCI: dwc/intel-gw: Move getting PCI_CAP_ID_EXP offset to intel_pcie_link_setup()
      PCI: dwc/intel-gw: Drop unused max_width
      PCI: dwc: Move N_FTS setup to common setup
      PCI: dwc: Use DBI accessors

Saheed O. Bolarinwa (7):
      PCI/ASPM: Remove struct aspm_register_info.support
      PCI/ASPM: Remove struct aspm_register_info.enabled
      PCI/ASPM: Remove struct aspm_register_info.latency_encoding
      PCI/ASPM: Remove struct aspm_register_info.l1ss_cap_ptr
      PCI/ASPM: Remove struct aspm_register_info.l1ss_ctl1
      PCI/ASPM: Remove struct aspm_register_info.l1ss_cap
      PCI/ASPM: Remove struct pcie_link_state.l1ss

Shiju Jose (1):
      ACPI / APEI: Add a notifier chain for unknown (vendor) CPER records

Tom Rix (1):
      PCI: v3-semi: Remove unneeded break

Tuan Phan (1):
      PCI/ACPI: Add Ampere Altra SOC MCFG quirk

Vaibhav Gupta (1):
      PCI/PM: Remove unused pcibios_pm_ops

Xiaowei Bao (10):
      PCI: designware-ep: Add multiple PFs support for DWC
      PCI: designware-ep: Add the doorbell mode of MSI-X in EP mode
      PCI: designware-ep: Move the function of getting MSI capability forward
      PCI: designware-ep: Modify MSI and MSIX CAP way of finding
      dt-bindings: pci: layerscape-pci: Add compatible strings for ls1088a and ls2088a
      PCI: layerscape: Fix some format issue of the code
      PCI: layerscape: Modify the way of getting capability with different PEX
      PCI: layerscape: Modify the MSIX to the doorbell mode
      PCI: layerscape: Add EP mode support for ls1088a and ls2088a
      misc: pci_endpoint_test: Add LS1088a in pci_device_id table

Yicong Yang (1):
      PCI: hip: Add handling of HiSilicon HIP PCIe controller errors

 .../devicetree/bindings/pci/brcm,stb-pcie.yaml     |  56 ++-
 .../devicetree/bindings/pci/layerscape-pci.txt     |   2 +
 .../devicetree/bindings/pci/rcar-pci-ep.yaml       |   8 +-
 Documentation/devicetree/bindings/pci/rcar-pci.txt |   3 +-
 .../bindings/pci/socionext,uniphier-pcie-ep.yaml   |  20 +-
 .../devicetree/bindings/pci/uniphier-pcie.txt      |   1 +
 Documentation/power/pci.rst                        |   2 +-
 arch/arm/include/asm/mach/pci.h                    |   7 -
 arch/arm/kernel/bios32.c                           |  16 +-
 arch/sparc/include/asm/io_32.h                     |  17 +-
 arch/x86/pci/fixup.c                               |   2 +-
 arch/x86/pci/intel_mid_pci.c                       |   3 +-
 drivers/acpi/apei/ghes.c                           |  63 +++
 drivers/acpi/pci_mcfg.c                            |  22 +-
 drivers/hid/intel-ish-hid/ipc/ipc.c                |   2 +-
 drivers/misc/pci_endpoint_test.c                   |  17 +-
 drivers/net/ethernet/marvell/sky2.c                |   2 +-
 drivers/pci/Kconfig                                |  62 +++
 drivers/pci/controller/Kconfig                     |  12 +-
 drivers/pci/controller/Makefile                    |   1 +
 drivers/pci/controller/cadence/pcie-cadence-ep.c   |   1 -
 drivers/pci/controller/cadence/pcie-cadence-host.c |   8 +-
 drivers/pci/controller/dwc/Kconfig                 |   3 +-
 drivers/pci/controller/dwc/pci-dra7xx.c            |  46 +--
 drivers/pci/controller/dwc/pci-exynos.c            |  45 ++-
 drivers/pci/controller/dwc/pci-imx6.c              |  93 ++---
 drivers/pci/controller/dwc/pci-keystone.c          | 146 ++-----
 drivers/pci/controller/dwc/pci-layerscape-ep.c     | 100 +++--
 drivers/pci/controller/dwc/pci-meson.c             | 164 ++------
 drivers/pci/controller/dwc/pcie-al.c               |  70 +---
 drivers/pci/controller/dwc/pcie-artpec6.c          |  48 +--
 drivers/pci/controller/dwc/pcie-designware-ep.c    | 257 +++++++++---
 drivers/pci/controller/dwc/pcie-designware-host.c  | 362 +++++++----------
 drivers/pci/controller/dwc/pcie-designware-plat.c  |   4 +-
 drivers/pci/controller/dwc/pcie-designware.c       | 170 ++++----
 drivers/pci/controller/dwc/pcie-designware.h       | 110 ++---
 drivers/pci/controller/dwc/pcie-histb.c            |  45 ++-
 drivers/pci/controller/dwc/pcie-intel-gw.c         |  65 +--
 drivers/pci/controller/dwc/pcie-kirin.c            |  49 ++-
 drivers/pci/controller/dwc/pcie-qcom.c             |  46 +--
 drivers/pci/controller/dwc/pcie-spear13xx.c        |  39 +-
 drivers/pci/controller/dwc/pcie-tegra194.c         | 140 ++-----
 drivers/pci/controller/dwc/pcie-uniphier.c         |   3 +-
 .../pci/controller/mobiveil/pcie-mobiveil-host.c   |   7 +-
 drivers/pci/controller/pci-aardvark.c              | 108 +++--
 drivers/pci/controller/pci-hyperv.c                |  50 ++-
 drivers/pci/controller/pci-loongson.c              |   7 +-
 drivers/pci/controller/pci-mvebu.c                 |   3 -
 drivers/pci/controller/pci-rcar-gen2.c             |   2 +-
 drivers/pci/controller/pci-tegra.c                 |  51 +--
 drivers/pci/controller/pci-v3-semi.c               |   1 -
 drivers/pci/controller/pci-xgene-msi.c             |   4 +-
 drivers/pci/controller/pcie-brcmstb.c              | 444 ++++++++++++++++++---
 drivers/pci/controller/pcie-hisi-error.c           | 327 +++++++++++++++
 drivers/pci/controller/pcie-iproc-bcma.c           |  13 +-
 drivers/pci/controller/pcie-iproc-msi.c            |  13 +-
 drivers/pci/controller/pcie-iproc-platform.c       |   2 +-
 drivers/pci/controller/pcie-xilinx-cpm.c           |   4 -
 drivers/pci/controller/vmd.c                       | 306 ++++++++------
 drivers/pci/ecam.c                                 |  10 +
 drivers/pci/hotplug/pciehp_ctrl.c                  |   4 +-
 drivers/pci/hotplug/pciehp_hpc.c                   |  15 +-
 drivers/pci/hotplug/rpadlpar_core.c                |   8 +-
 drivers/pci/hotplug/shpchp_ctrl.c                  |   1 -
 drivers/pci/p2pdma.c                               |  10 +-
 drivers/pci/pci-acpi.c                             |   6 +-
 drivers/pci/pci-bridge-emul.c                      |   4 +
 drivers/pci/pci-driver.c                           |  26 --
 drivers/pci/pci-pf-stub.c                          |  14 +-
 drivers/pci/pci-sysfs.c                            |   7 +-
 drivers/pci/pci.c                                  |  54 +--
 drivers/pci/pci.h                                  |   9 +-
 drivers/pci/pcie/aspm.c                            | 294 +++++++-------
 drivers/pci/pcie/bw_notification.c                 |   3 +
 drivers/pci/pcie/dpc.c                             |   7 +-
 drivers/pci/probe.c                                |  17 +-
 drivers/pci/quirks.c                               |  78 ++--
 drivers/phy/marvell/phy-mvebu-a3700-comphy.c       |  14 +-
 drivers/phy/marvell/phy-mvebu-cp110-comphy.c       |  14 +-
 drivers/staging/media/atomisp/pci/atomisp_v4l2.c   |   2 +-
 include/acpi/ghes.h                                |  18 +
 include/asm-generic/io.h                           |  39 +-
 include/linux/pci-ecam.h                           |   1 +
 include/linux/pci-ep-cfs.h                         |   4 +-
 include/linux/pci.h                                |   8 +-
 include/uapi/linux/pci_regs.h                      |   6 +-
 86 files changed, 2554 insertions(+), 1793 deletions(-)
 create mode 100644 drivers/pci/controller/pcie-hisi-error.c
