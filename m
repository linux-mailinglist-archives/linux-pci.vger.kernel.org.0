Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F099742AE4
	for <lists+linux-pci@lfdr.de>; Thu, 29 Jun 2023 18:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbjF2Q6o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jun 2023 12:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjF2Q6n (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Jun 2023 12:58:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29B32D4C;
        Thu, 29 Jun 2023 09:58:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2007B615AF;
        Thu, 29 Jun 2023 16:58:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE46C433C8;
        Thu, 29 Jun 2023 16:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688057920;
        bh=FQntZ6/LqIfW8Aeoys0cCNfrFRK7KsODpzAfiQHGArw=;
        h=Date:From:To:Cc:Subject:From;
        b=KYMGAygL8Pgw8FEm1HNU2K1M980PCp/iQxpFr8rL63KnuhfuMCinIowq2os1CVdp1
         GdYL1wjbiZ/DskRVksAVnVFBXA74xbyOHx53RSAgPQTTg2afYihXTZmJikDL3EDfoj
         DD7i0SDByIe0HYSP4eQeDONSGApRcu/U7DkCvvQfHGUHRYuBOjfwIHtaz/0Pqq757o
         OrMCqtFwlsrnRJAd1PYAJyjNgo3Hg6A3TOOxbqUD1CgPUrSMnIAkN7U0BK1Fe42kHw
         9p13j+XYZ6AStLDytCWT+8knPQFywnWU+HuhaUMfRcOdgGULPiJ+f//+ykCGmZ19n5
         GnUnF+jKiL3cw==
Date:   Thu, 29 Jun 2023 11:58:38 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: [GIT PULL] PCI changes for v6.5
Message-ID: <20230629165838.GA438762@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.5-changes

for you to fetch changes up to 6ecac465eee887de7ceda7ffe3bccf538eb786bc:

  Merge branch 'pci/controller/remove-void-callbacks' (2023-06-26 13:00:00 -0500)

----------------------------------------------------------------

Enumeration:

  - Export pcie_retrain_link() for use outside ASPM

  - Add Data Link Layer Link Active Reporting as another way for
    pcie_retrain_link() to determine the link is up

  - Work around link training failures (especially on the ASMedia ASM2824
    switch) by training first at 2.5GT/s and then attempting higher rates

Resource management:

  - When we coalesce host bridge windows, remove invalidated resources from
    the resource tree so future allocations work correctly

Hotplug:

  - Cancel bringup sequence if card is not present, to keep from blinking
    Power Indicator indefinitely

  - Reassign bridge resources if necessary for ACPI hotplug

Driver binding:

  - Convert platform_device .remove() callbacks to return void instead of a
    mostly useless int

Power management:

  - Reduce wait time for secondary bus to be ready to speed up resume

  - Avoid putting EloPOS E2/S2/H2 (as well as Elo i2) PCIe Ports in D3cold

  - Call _REG when transitioning D-states so AML that uses the PCI config
    space OpRegion works, which fixes some ASMedia GPIO controllers after
    resume

Virtualization:

  - Delay extra 250ms after FLR of Solidigm P44 Pro NVMe to avoid KVM hang
    when guest is rebooted

  - Add function 1 DMA alias quirk for Marvell 88SE9235

Error handling:

  - Unexport pci_save_aer_state() since it's only used in drivers/pci/

  - Drop recommendation for drivers to configure AER Capability, since the
    PCI core does this for all devices

ASPM:

  - Disable ASPM on MFD function removal to avoid use-after-free

  - Tighten up pci_enable_link_state() and pci_disable_link_state()
    interfaces so they don't enable/disable states the driver didn't
    specify

  - Avoid link retraining race that can happen if ASPM sets link control
    parameters while the link is in the midst of training for some other
    reason

Endpoint framework:

  - Change "PCI Endpoint Virtual NTB driver" Kconfig prompt to be different
    from "PCI Endpoint NTB driver"

  - Automatically create a function specific attributes group for endpoint
    drivers to avoid reference counting issues

  - Fix many EPC test issues

  - Return pci_epf_type_add_cfs() error if EPF has no driver

  - Add kernel-doc for pci_epc_raise_irq() and pci_epc_map_msi_irq() MSI
    vector parameters

  - Pass EPF device ID to driver probe functions

  - Return -EALREADY if EPC has already been started/stopped

  - Add linkdown notifier support and use it in qcom-ep

  - Add Bus Master Enable event support and use it in qcom-ep

  - Add Qualcomm Modem Host Interface (MHI) endpoint driver

  - Add Layerscape PME interrupt handling to manage link-up notification

Cadence PCIe controller driver:

  - Wait for link retrain to complete when working around the J721E i2085
    erratum with Gen2 mode

Faraday FTPC100 PCI controller driver:

  - Release clock resources on error paths

Freescale i.MX6 PCIe controller driver:

  - Save and restore Root Port MSI control to work around hardware defect

Intel VMD host bridge driver:

  - Reset VMD config register between soft reboots

  - Capture pci_reset_bus() return value instead of printing junk when it
    fails

Qualcomm PCIe controller driver:

  - Add SDX65 endpoint compatible string to DT binding

  - Disable register write access after init for IP v2.3.3, v2.9.0

  - Use DWC helpers for enabling/disabling writes to DBI registers

  - Hide slot hotplug capability for IP v1.0.0, v1.9.0, v2.1.0, v2.3.2,
    v2.3.3, v2.7.0, v2.9.0

  - Reuse v2.3.2 post-init sequence for v2.4.0

Renesas R-Car PCIe controller driver:

  - Remove unused static pcie_base and pcie_dev

Rockchip PCIe controller driver:

  - Remove writes to unused registers

  - Write endpoint Device ID using correct register

  - Assert PCI Configuration Enable bit after probe so endpoint responds
    instead of generating Request Retry Status messages

  - Poll waiting for PHY PLLs to lock

  - Update RK3399 example DT binding to be valid

  - Use RK3399 PCIE_CLIENT_LEGACY_INT_CTRL to generate INTx instead of
    manually generating PCIe message

  - Use multiple windows to avoid address translation conflicts

  - Use u32 (not u16) when accessing 32-bit registers

  - Hide MSI-X Capability, since RK3399 can't generate MSI-X

  - Set endpoint controller required alignment to 256

Synopsys DesignWare PCIe controller driver:

  - Wait for link to come up only if we've initiated link training

Miscellaneous:

  - Add pci_clear_master() stub for non-CONFIG_PCI

----------------------------------------------------------------
Ajay Agarwal (6):
      PCI/ASPM: Disable only ASPM_STATE_L1 when driver disables L1
      PCI/ASPM: Set only ASPM_STATE_L1 when driver enables L1
      PCI/ASPM: Set ASPM_STATE_L1 when driver enables L1.1 or L1.2
      PCI/ASPM: Rename L1.2-specific functions from 'l1ss' to 'l12'
      PCI/ASPM: Remove unnecessary ASPM_STATE_L1SS check
      PCI: dwc: Wait for link up only if link is started

Andy Shevchenko (1):
      PCI: of: Propagate firmware node by calling device_set_node()

Ben Dooks (1):
      PCI: Add PCI_EXT_CAP_ID_PL_32GT define

Bjorn Helgaas (26):
      PCI: pciehp: Simplify Attention Button logging
      PCI: Expand comment about sorting pci_ids.h entries
      PCI: Unexport pci_save_aer_state()
      Documentation: PCI: Drop recommendation to configure AER Capability
      Documentation: PCI: Update cross references to .rst files
      Documentation: PCI: Tidy AER documentation
      PCI/ASPM: Return 0 or -ETIMEDOUT from  pcie_retrain_link()
      PCI/ACPI: Validate acpi_pci_set_power_state() parameter
      Merge branch 'pci/aer'
      Merge branch 'pci/aspm'
      Merge branch 'pci/enumeration'
      Merge branch 'pci/hotplug'
      Merge branch 'pci/pm'
      Merge branch 'pci/resource'
      Merge branch 'pci/virtualization'
      Merge branch 'pci/misc'
      Merge branch 'pci/controller/dt'
      Merge branch 'pci/controller/cadence'
      Merge branch 'pci/controller/dwc'
      Merge branch 'pci/pci/ftpci100'
      Merge branch 'pci/controller/qcom'
      Merge branch 'pci/controller/rcar'
      Merge branch 'pci/controller/rockchip'
      Merge branch 'pci/controller/vmd'
      Merge branch 'pci/controller/endpoint'
      Merge branch 'pci/controller/remove-void-callbacks'

Damien Le Moal (19):
      PCI: rockchip: Set address alignment for endpoint mode
      PCI: endpoint: Automatically create a function specific attributes group
      PCI: endpoint: Move pci_epf_type_add_cfs() code
      PCI: epf-test: Fix DMA transfer completion initialization
      PCI: epf-test: Fix DMA transfer completion detection
      PCI: epf-test: Use dmaengine_submit() to initiate DMA transfer
      PCI: epf-test: Simplify read/write/copy test functions
      PCI: epf-test: Simplify pci_epf_test_raise_irq()
      PCI: epf-test: Simplify IRQ test commands execution
      PCI: epf-test: Improve handling of command and status registers
      PCI: epf-test: Cleanup pci_epf_test_cmd_handler()
      PCI: epf-test: Cleanup request result handling
      PCI: epf-test: Simplify DMA support checks
      PCI: epf-test: Simplify transfers result print
      misc: pci_endpoint_test: Free IRQs before removing the device
      misc: pci_endpoint_test: Re-init completion for every test
      misc: pci_endpoint_test: Do not write status in IRQ handler
      misc: pci_endpoint_test: Simplify pci_endpoint_test_msi_irq()
      PCI: endpoint: Improve pci_epf_type_add_cfs()

Ding Hui (1):
      PCI/ASPM: Disable ASPM on MFD function removal to avoid use-after-free

Frank Li (2):
      PCI: endpoint: pci-epf-vntb: Fix typo in comments
      PCI: layerscape: Add the endpoint linkup notifier support

Geert Uytterhoeven (1):
      PCI: rcar-host: Remove unused static pcie_base and pcie_dev

Igor Mammedov (1):
      PCI: acpiphp: Reassign resources on bridge if necessary

Ilpo Järvinen (2):
      PCI/ASPM: Factor out pcie_wait_for_retrain()
      PCI/ASPM: Avoid link retraining race

Junyan Ye (1):
      PCI: ftpci100: Release the clock resources

Maciej W. Rozycki (14):
      PCI: Initialize dev->link_active_reporting earlier
      PCI: pciehp: Rely on dev->link_active_reporting
      powerpc/eeh: Rely on dev->link_active_reporting
      net/mlx5: Rely on dev->link_active_reporting
      PCI/ASPM: Use distinct local vars in pcie_retrain_link()
      PCI/ASPM: Avoid unnecessary pcie_link_state use
      PCI/ASPM: Factor out waiting for link training to complete
      PCI: Execute quirk_enable_clear_retrain_link() earlier
      PCI: Export PCIe link retrain timeout
      PCI: Export pcie_retrain_link() for use outside ASPM
      PCI: Add support for polling DLLLA to pcie_retrain_link()
      PCI: Use pcie_wait_for_link_status() in pcie_wait_for_link_delay()
      PCI: Work around PCIe link training failures
      PCI: Add failed link recovery for device reset events

Manivannan Sadhasivam (18):
      PCI: qcom: Disable write access to read only registers for IP v2.3.3
      PCI: qcom: Use DWC helpers for modifying the read-only DBI registers
      PCI: qcom: Disable write access to read only registers for IP v2.9.0
      PCI: qcom: Do not advertise hotplug capability for IPs v2.7.0 and v1.9.0
      PCI: qcom: Do not advertise hotplug capability for IPs v2.3.3 and v2.9.0
      PCI: qcom: Do not advertise hotplug capability for IP v2.3.2
      PCI: qcom: Use post init sequence of IP v2.3.2 for v2.4.0
      PCI: qcom: Do not advertise hotplug capability for IP v1.0.0
      PCI: qcom: Do not advertise hotplug capability for IP v2.1.0
      PCI: endpoint: Add missing documentation about the MSI/MSI-X range
      PCI: endpoint: Pass EPF device ID to the probe function
      PCI: endpoint: Return error if EPC is started/stopped multiple times
      PCI: endpoint: Add linkdown notifier support
      PCI: endpoint: Add BME notifier support
      PCI: qcom-ep: Add support for Link down notification
      PCI: qcom-ep: Add support for BME notification
      PCI: endpoint: Add PCI Endpoint function driver for MHI bus
      MAINTAINERS: Add PCI MHI endpoint function driver under MHI bus

Mario Limonciello (1):
      PCI/ACPI: Call _REG when transitioning D-states

Mika Westerberg (1):
      PCI/PM: Shorten pci_bridge_wait_for_secondary_bus() wait time for slow links

Mike Pastore (1):
      PCI: Delay after FLR of Solidigm P44 Pro NVMe

Nirmal Patel (1):
      PCI: vmd: Reset VMD config register between soft reboots

Ondrej Zary (1):
      PCI/PM: Avoid putting EloPOS E2/S2/H2 PCIe Ports in D3cold

Randy Dunlap (1):
      Documentation: PCI: correct spelling

Richard Zhu (1):
      PCI: imx6: Save and restore root port MSI control in suspend and resume

Rick Wertenbroek (9):
      PCI: rockchip: Remove writes to unused registers
      PCI: rockchip: Write PCI Device ID to correct register
      PCI: rockchip: Assert PCI Configuration Enable bit after probe
      PCI: rockchip: Add poll and timeout to wait for PHY PLLs to be locked
      dt-bindings: PCI: Update the RK3399 example to a valid one
      PCI: rockchip: Fix legacy IRQ generation for RK3399 PCIe endpoint core
      PCI: rockchip: Fix window mapping and address translation for endpoint
      PCI: rockchip: Use u32 variable to access 32-bit registers
      PCI: rockchip: Don't advertise MSI-X in PCIe capabilities

Robin Murphy (1):
      PCI: Add function 1 DMA alias quirk for Marvell 88SE9235

Rohit Agarwal (1):
      dt-bindings: PCI: qcom: Add SDX65 SoC

Rongguang Wei (1):
      PCI: pciehp: Cancel bringup sequence if card is not present

Ross Lagerwall (1):
      PCI: Release resource invalidated by coalescing

Shunsuke Mie (1):
      PCI: endpoint: Fix a Kconfig prompt of vNTB driver

Siddharth Vadapalli (1):
      PCI: cadence: Fix Gen2 Link Retraining process

Sui Jingfeng (1):
      PCI: Add pci_clear_master() stub for non-CONFIG_PCI

Uwe Kleine-König (15):
      PCI: aardvark: Convert to platform remove callback returning void
      PCI: altera: Convert to platform remove callback returning void
      PCI: altera-msi: Convert to platform remove callback returning void
      PCI: brcmstb: Convert to platform remove callback returning void
      PCI: j721e: Convert to platform remove callback returning void
      PCI: dwc: Convert to platform remove callback returning void
      PCI: hisi-error: Convert to platform remove callback returning void
      PCI: iproc: Convert to platform remove callback returning void
      PCI: mediatek: Convert to platform remove callback returning void
      PCI: mediatek-gen3: Convert to platform remove callback returning void
      PCI: mt7621: Convert to platform remove callback returning void
      PCI: mvebu: Convert to platform remove callback returning void
      PCI: rockchip-host: Convert to platform remove callback returning void
      PCI: tegra: Convert to platform remove callback returning void
      PCI: xgene-msi: Convert to platform remove callback returning void

Wolfram Sang (1):
      PCI: rcar: Use correct product family name for Renesas R-Car

Xinghui Li (1):
      PCI: vmd: Fix uninitialized variable usage in vmd_enable_domain()

Yoshihiro Shimoda (1):
      PCI: endpoint: functions/pci-epf-test: Fix dma_chan direction

 Documentation/PCI/endpoint/pci-ntb-howto.rst       |  11 +-
 Documentation/PCI/endpoint/pci-vntb-howto.rst      |  13 +-
 Documentation/PCI/msi-howto.rst                    |   2 +-
 Documentation/PCI/pci-error-recovery.rst           |   2 +-
 Documentation/PCI/pcieaer-howto.rst                | 183 +++-----
 .../devicetree/bindings/pci/qcom,pcie-ep.yaml      |   2 +
 .../bindings/pci/rockchip,rk3399-pcie-ep.yaml      |   4 +-
 MAINTAINERS                                        |   1 +
 arch/powerpc/kernel/eeh_pe.c                       |   5 +-
 drivers/misc/pci_endpoint_test.c                   |  25 +-
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c |   8 +-
 drivers/pci/controller/cadence/pci-j721e.c         |   6 +-
 drivers/pci/controller/cadence/pcie-cadence-host.c |  27 ++
 drivers/pci/controller/dwc/pci-imx6.c              |  23 ++
 drivers/pci/controller/dwc/pci-layerscape-ep.c     | 100 ++++-
 drivers/pci/controller/dwc/pcie-bt1.c              |   6 +-
 drivers/pci/controller/dwc/pcie-designware-host.c  |  13 +-
 drivers/pci/controller/dwc/pcie-designware.c       |  20 +-
 drivers/pci/controller/dwc/pcie-designware.h       |   1 +
 drivers/pci/controller/dwc/pcie-histb.c            |   6 +-
 drivers/pci/controller/dwc/pcie-intel-gw.c         |   6 +-
 drivers/pci/controller/dwc/pcie-qcom-ep.c          |  10 +-
 drivers/pci/controller/dwc/pcie-qcom.c             |  73 ++--
 drivers/pci/controller/dwc/pcie-tegra194.c         |   8 +-
 drivers/pci/controller/pci-aardvark.c              |   6 +-
 drivers/pci/controller/pci-ftpci100.c              |  14 +-
 drivers/pci/controller/pci-mvebu.c                 |   6 +-
 drivers/pci/controller/pci-tegra.c                 |   6 +-
 drivers/pci/controller/pci-xgene-msi.c             |   6 +-
 drivers/pci/controller/pcie-altera-msi.c           |   5 +-
 drivers/pci/controller/pcie-altera.c               |   6 +-
 drivers/pci/controller/pcie-brcmstb.c              |   6 +-
 drivers/pci/controller/pcie-hisi-error.c           |   6 +-
 drivers/pci/controller/pcie-iproc-platform.c       |   6 +-
 drivers/pci/controller/pcie-iproc.c                |   4 +-
 drivers/pci/controller/pcie-iproc.h                |   2 +-
 drivers/pci/controller/pcie-mediatek-gen3.c        |   6 +-
 drivers/pci/controller/pcie-mediatek.c             |   6 +-
 drivers/pci/controller/pcie-mt7621.c               |   6 +-
 drivers/pci/controller/pcie-rcar-host.c            |  25 +-
 drivers/pci/controller/pcie-rockchip-ep.c          | 221 +++++-----
 drivers/pci/controller/pcie-rockchip-host.c        |   6 +-
 drivers/pci/controller/pcie-rockchip.c             |  17 +
 drivers/pci/controller/pcie-rockchip.h             |  49 ++-
 drivers/pci/controller/vmd.c                       |  11 +-
 drivers/pci/endpoint/functions/Kconfig             |  12 +-
 drivers/pci/endpoint/functions/Makefile            |   1 +
 drivers/pci/endpoint/functions/pci-epf-mhi.c       | 458 +++++++++++++++++++++
 drivers/pci/endpoint/functions/pci-epf-ntb.c       |   4 +-
 drivers/pci/endpoint/functions/pci-epf-test.c      | 271 ++++++------
 drivers/pci/endpoint/functions/pci-epf-vntb.c      |  14 +-
 drivers/pci/endpoint/pci-ep-cfs.c                  |  81 +++-
 drivers/pci/endpoint/pci-epc-core.c                |  56 ++-
 drivers/pci/endpoint/pci-epf-core.c                |  42 +-
 drivers/pci/hotplug/acpiphp_glue.c                 |   5 +-
 drivers/pci/hotplug/pciehp_ctrl.c                  |  21 +-
 drivers/pci/hotplug/pciehp_hpc.c                   |  12 +-
 drivers/pci/of.c                                   |  14 +-
 drivers/pci/pci-acpi.c                             |  53 ++-
 drivers/pci/pci.c                                  | 194 +++++++--
 drivers/pci/pci.h                                  |  19 +-
 drivers/pci/pcie/aspm.c                            | 101 ++---
 drivers/pci/probe.c                                |  12 +-
 drivers/pci/quirks.c                               | 111 ++++-
 include/linux/aer.h                                |   4 -
 include/linux/pci-epc.h                            |   2 +
 include/linux/pci-epf.h                            |  11 +-
 include/linux/pci.h                                |   1 +
 include/linux/pci_ids.h                            |   4 +-
 include/uapi/linux/pci_regs.h                      |   1 +
 70 files changed, 1631 insertions(+), 848 deletions(-)
 create mode 100644 drivers/pci/endpoint/functions/pci-epf-mhi.c
