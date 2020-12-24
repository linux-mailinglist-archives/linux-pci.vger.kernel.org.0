Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91E7E2E25BE
	for <lists+linux-pci@lfdr.de>; Thu, 24 Dec 2020 10:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgLXJqs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Dec 2020 04:46:48 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:34822 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727144AbgLXJqs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Dec 2020 04:46:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1608803207; x=1640339207;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=UkyWuBWrroLsO2FpQfjCVCVsDnNl57MHyirL6oeWkEY=;
  b=GK6595lqZ43W31kEghfG+vvO9bCXgkw2maZahT4ANvQyfAdwTkfNkeWA
   wX54QUEkPONgcxwP7YyEcfiBRTcsxjc5b4j62Da2XjLARNOLBgP+wgnwj
   0czfaju+ClCc6xX7mb/d7XHbETjcV+bS/CkUcf4eTL0hhhZ+hicJPLBb+
   3FvoQFk/EZUfsq2yTzCBFfEfeLVcQCv/d9o5Ge8086eSoIpFOQuIffdkV
   dJAzeJadhCqW/lrGiXyhTysUaplbG9OhZgoZWKqr4ZmfQj+Meuamml7Kr
   eNT6Ua0+PInr/EyBdY2T7fEhcTyTnrxgYWQK9VlLQwTldxRj/3ZO5TX0+
   g==;
IronPort-SDR: +tudgKHMO/UfplBl4gCIoWnmWadjT9IoxJzfnvc4muzDAGzcwfbqQtCNl62jWF8wkdr/XBZqw0
 DBHsAWXsGOJga1OUMcCGzgUPkR/lm4k1ik/XmALmg0rx8ixT2eZzPhe63puKVg9l8jqJ+GtGXP
 VThnJcBuE1ag382MrqvdnU91Jik3idJHM7PgY2MbzdaSe2z6m5sdO1+7K2Br/swLzaX7+62d3q
 tXMEJ59F0cqmg3uYpFKTQMp8tTJnAWpt/y2SgbiEAoKKbKEPZLR1GjuTGrMSF+XhBbFwrp4+k4
 zpg=
X-IronPort-AV: E=Sophos;i="5.78,444,1599548400"; 
   d="scan'208";a="103376092"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Dec 2020 02:45:06 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 24 Dec 2020 02:45:06 -0700
Received: from ryzen.microchip.com (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 24 Dec 2020 02:45:04 -0700
From:   <daire.mcnamara@microchip.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh@kernel.org>, <linux-pci@vger.kernel.org>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <david.abdurachmanov@gmail.com>, <cyril.jean@microchip.com>,
        <ben.dooks@codethink.co.uk>,
        Daire McNamara <daire.mcnamara@microchip.com>
Subject: [PATCH v19 0/4] PCI: microchip: Add host driver for Microchip PCIe controller
Date:   Thu, 24 Dec 2020 09:44:56 +0000
Message-ID: <20201224094500.19149-1-daire.mcnamara@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Daire McNamara <daire.mcnamara@microchip.com>

This patchset adds support for the Microchip PCIe PolarFire PCIe
controller when configured in host (Root Complex) mode.

Updates since v18:
* Upgraded interrupt handling as per Lorenzo Pieralisi's suggestions.
  Gathered disparate registers onto an event register, created a new event domain,
  and split out end-of-interrupt functionality.

Updates since v17:
* Regenerated to apply to v5.10rc1
* Added self as maintainer
* Added clock enables and extra interrupt handling

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

Daire McNamara (4):
  PCI: Call platform_set_drvdata earlier in devm_pci_alloc_host_bridge
  dt-bindings: PCI: microchip: Add Microchip PolarFire host binding
  PCI: microchip: Add host driver for Microchip PCIe controller
  MAINTAINERS: Add Daire McNamara as maintainer for the Microchip PCIe
    driver

 .../bindings/pci/microchip,pcie-host.yaml     |   92 ++
 MAINTAINERS                                   |    7 +
 drivers/pci/controller/Kconfig                |   10 +
 drivers/pci/controller/Makefile               |    1 +
 drivers/pci/controller/pci-host-common.c      |    4 +-
 drivers/pci/controller/pcie-microchip-host.c  | 1119 +++++++++++++++++
 6 files changed, 1231 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
 create mode 100644 drivers/pci/controller/pcie-microchip-host.c


base-commit: 3650b228f83adda7e5ee532e2b90429c03f7b9ec
-- 
2.25.1

