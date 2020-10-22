Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C29FA295FDA
	for <lists+linux-pci@lfdr.de>; Thu, 22 Oct 2020 15:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507110AbgJVNWc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Oct 2020 09:22:32 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:22266 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2507080AbgJVNWb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Oct 2020 09:22:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1603372951; x=1634908951;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=NLfXWL4KmHeAdQGESXdGuAVG0outUMERCHn1ewac87Q=;
  b=wYCB+fRouts9i5DRvDdtp8jtjJHz9fsRLihv/2zMREvBHh3Q4lX1tXiZ
   hJKsMFG4yNfyKYVRv9jqvrxToPM/jRjSH/xumcu+R+RF69k0tLc23LeJ+
   KSY8u8xceTEJzMD7owx6RxstKTbjA/cqyOmxPocWAkFMFrIafOk+nG0Qn
   UwCJR7TxX+KiTvZH6eSZyMbuOX8QYMvImg1YSmxX9PFSGoiB3HrQmSzlw
   xT1cwa03lP1yTPjVai47kDUHJ+cvzw2JTuJfEPjomiWmNo6xX0NkmkykL
   UCrenf9DucZ5/aXkXFVK6nTOOAQj5YQRjRVqxXUqCIrfuTM4gd1jwuDZu
   g==;
IronPort-SDR: GbI151RDgx46gYkbTpk5KkOyyeakZFq826XQQkD+085pnFmuIb5yFAA3w2lCBBzVClJVEGO7en
 pf6Gunxe3HojypJK9bx69x4pyx3Q7PkFn8Ke3gDoF8TBDw9oYUq3R8HpLothpqRsK0+Kqa8pb9
 8fnPdUXN4c8/AbwxHrJFj5fzDrX4vlbNTASBmQjZp5XcHsPPQqj5kkzk0HYKJT7sQKwB4RLoxW
 X2QxPGhqegN9CElt2BFped71oFShS/SsOKhRKgbfa+DfIhr7tRmxiuk4PR29LhA9sp7j1q2DC4
 eiU=
X-IronPort-AV: E=Sophos;i="5.77,404,1596524400"; 
   d="scan'208";a="91058327"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Oct 2020 06:22:30 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 22 Oct 2020 06:22:30 -0700
Received: from ryzen.microchip.com (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 22 Oct 2020 06:22:28 -0700
From:   <daire.mcnamara@microchip.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <robh@kernel.org>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <david.abdurachmanov@gmail.com>
CC:     Daire McNamara <daire.mcnamara@microchip.com>
Subject: [PATCH v17 0/3] PCI: microchip: Add host driver for Microchip PCIe controller
Date:   Thu, 22 Oct 2020 14:22:20 +0100
Message-ID: <20201022132223.17789-1-daire.mcnamara@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Daire McNamara <daire.mcnamara@microchip.com>

This patchset adds support for the Microchip PCIe PolarFire PCIe
controller when configured in host (Root Complex) mode.

Updates since v16:
* Patch needs CONFIG_PCI_HOST_COMMON.  Add this to Kconfig stanza

Updates since v15:
* Call platform_set_drvdata earlier in devm_pci_alloc_host_bridge()
* Use host_common_probe() and an init function to set up hw windows
* status is u32 in mc_pcie_isr()
* Removed mask var in mc_mask_intx_irq(), mc_unmask_intx_irq()
* irq var is now signed in mc_platform_init()

Updates since v14:
* Removed cfg_read/cfg_write inline functions
* Updated to irq_data_get_irq_chip_data()
* Updated to use devm_platform_ioremap_resource()
* Replaced of_pci_range parsing to setup windows via bridge pointer.

Updates since v13:
* Refactored to use pci_host_common_probe()

Updates since v12:
* Capitalised commit messages.  Use specific subject line for dt-bindings

Updates since v11:
* Adjusted so yaml file passses make dt_binding_check

Updates since v10:
* Adjusted driver as per Rob Herring's comments, notably:
  - use common PCI_MSI_FLAGS defines
  - reduce storage of unnecessary vars in mc_pcie struct
  - switched to read/write relaxed variants
  - extended lock in msi_domain_alloc routine
  - improved 32bit safety, switched from find_first_bit() to ilog2()
  - removed unnecessary twiddle of eCAM config space

Updates since v9:
* Adjusted commit logs
* make dt_bindings_check passes

Updates since v8:
* Refactored as per Rob Herring's comments:
  - bindings in schema format
  - Adjusted licence to GPLv2.0
  - Refactored access to config space between driver and common eCAM code
  - Adopted pci_host_probe()
  - Miscellanous other improvements

Updates since v7:
* Build for 64bit RISCV architecture only

Updates since v6:
* Refactored to use common eCAM driver
* Updated to CONFIG_PCIE_MICROCHIP_HOST etc
* Formatting improvements
* Removed code for selection between bridge 0 and 1

Updates since v5:
* Fixed Kconfig typo noted by Randy Dunlap
* Updated with comments from Bjorn Helgaas

Updates since v4:
* Fix compile issues.

Updates since v3:
* Update all references to Microsemi to Microchip
* Separate MSI functionality from legacy PCIe interrupt handling functionality

Updates since v2:
* Split out DT bindings and Vendor ID updates into their own patch
  from PCIe driver.
* Updated Change Log

Updates since v1:
* Incorporate feedback from Bjorn Helgaas

Daire McNamara (3):
  PCI: Call platform_set_drvdata earlier in devm_pci_alloc_host_bridge
  dt-bindings: PCI: microchip: Add Microchip PolarFire host binding
  PCI: microchip: Add host driver for Microchip PCIe controller

 .../bindings/pci/microchip,pcie-host.yaml     |  93 +++
 drivers/pci/controller/Kconfig                |  10 +
 drivers/pci/controller/Makefile               |   1 +
 drivers/pci/controller/pci-host-common.c      |   4 +-
 drivers/pci/controller/pcie-microchip-host.c  | 541 ++++++++++++++++++
 5 files changed, 647 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
 create mode 100644 drivers/pci/controller/pcie-microchip-host.c


base-commit: c4d6fe7311762f2e03b3c27ad38df7c40c80cc93
prerequisite-patch-id: b98abc1ad412692a95e3eb3f7adfaff214750282
prerequisite-patch-id: b77f4eea4090304b5c113e4ccc29e64fc82cdc45
-- 
2.25.1

