Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8C552CD537
	for <lists+linux-pci@lfdr.de>; Thu,  3 Dec 2020 13:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729290AbgLCMLq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Dec 2020 07:11:46 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:2743 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729247AbgLCMLq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Dec 2020 07:11:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1606997506; x=1638533506;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=QLD5ONWunMLZJL3jGQBpiCqmYmq6E0jPrkEC5wisJVM=;
  b=RTWuOWyEUs+U9bHlvDG05z5wcfp4R5jED+q7Q4Eaj2N0Wl9yp04Cbnwl
   4QDU4mIiyjtCht7pqrb6LAdwOh/FR2zGgHGUpzZBVunwVkrA8TuZkDmiL
   a9ePsvGYMMUKO/qSRHj4FUgQ/+P8TpfsWx3sxHLvBLmpwa1BwMM9axp/z
   1oWXxvkLAg8PCmiFBOVb7dVUw3QTfsd0t+koDf3pixagug4EGQ8Z7iFKv
   EbXQYk+lRFKDBCJwM+4zTCqFpfchrpOxoms9/YoxLlHIxvyw672xodRd2
   DaYnu80RFnnKGJBZuEQ/TXShZ3k3cNwygsosRTtbSH81pr1ghUJMGMlKq
   g==;
IronPort-SDR: YtRVcY0CYsKYlGpu8xWPzx2rqN0poWspN0aoYKa78ZRBAI7jE1I7qzUxIVHX5jcumiiYkocCPs
 eM9Py3zflDmm+9Tbk4Eqti6EH1/rizznryWrxGPl+dQgITwBm0I82eLejJYBuvGILg6tejcPFk
 XICHgLKlkcLfkxrSSDLEhuS7dimS+Y63eNb8GIEJXBBgoczPF60WA6+f25AF4KnzEz9mBAvps5
 plRqRMXZ4TCn6YJ/1C93vpCFMRiw57NnHeDx6vsl/02n4l1+1cKQIq0jVQcHW1v8+H7MOwJz7M
 y0A=
X-IronPort-AV: E=Sophos;i="5.78,389,1599548400"; 
   d="scan'208";a="101273943"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Dec 2020 05:10:40 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 3 Dec 2020 05:10:39 -0700
Received: from ryzen.microchip.com (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 3 Dec 2020 05:10:37 -0700
From:   <daire.mcnamara@microchip.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh@kernel.org>, <linux-pci@vger.kernel.org>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <david.abdurachmanov@gmail.com>, <cyril.jean@microchip.com>,
        <ben.dooks@codethink.co.uk>,
        Daire McNamara <daire.mcnamara@microchip.com>
Subject: [PATCH v18 0/4] PCI: microchip: Add host driver for Microchip PCIe controller
Date:   Thu, 3 Dec 2020 12:10:14 +0000
Message-ID: <20201203121018.16432-1-daire.mcnamara@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Daire McNamara <daire.mcnamara@microchip.com>

This patchset adds support for the Microchip PCIe PolarFire PCIe
controller when configured in host (Root Complex) mode.

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
  Add Daire McNamara as maintainer for the Microchip PCIe driver

 .../bindings/pci/microchip,pcie-host.yaml     |  93 +++
 MAINTAINERS                                   |   7 +
 drivers/pci/controller/Kconfig                |  10 +
 drivers/pci/controller/Makefile               |   1 +
 drivers/pci/controller/pci-host-common.c      |   4 +-
 drivers/pci/controller/pcie-microchip-host.c  | 607 ++++++++++++++++++
 6 files changed, 720 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
 create mode 100644 drivers/pci/controller/pcie-microchip-host.c


base-commit: 3650b228f83adda7e5ee532e2b90429c03f7b9ec
-- 
2.25.1

