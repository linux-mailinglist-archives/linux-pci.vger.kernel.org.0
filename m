Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC613027EC
	for <lists+linux-pci@lfdr.de>; Mon, 25 Jan 2021 17:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730422AbhAYQdA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Jan 2021 11:33:00 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:49305 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730716AbhAYQbB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Jan 2021 11:31:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1611592260; x=1643128260;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=5T0tL0eM/uXkBAlgie2iGOOkH8kELjiZXsLnUHU+EI4=;
  b=PUbP3K+hVY5W5+kad3U4tuIXChrawPpjRE1GNvid8hKr5WxNiYivO925
   FRMOIVWYKcJBCKawbKYjuw/8qXgAzGxJJNCtd9Fju9yYLpoBApT6R40oJ
   BLXEiBj0b980V4hu5SNffFRmBADzPOaM3JQHCBZaKe0vE2SEje4fCNfgZ
   FLS8h6WbghFNfZuWlR+xRTjqQLwfboxW3ytUVeQgC4NNtYwahFcvFYZlT
   3daV/BBQECoow0N+3138eq5ad4kCbi/Jv/5oNXA58Pal54xI7AWXwz7K2
   jRjco1FcCFnKI3hYet67pDn4M4+VxXADdb4vniBUZOm3+jqV3sbG4/uZ/
   g==;
IronPort-SDR: +vXmFQxdCb4ofR9bMCjfFh+5qxZEqcZc0fTAxDd1eONUgWH0xe7BEpKbzi0OPsAOaVNu96+aW/
 iHCJdN2Vqz3EeXe5UHSLmNthCgGYRpZtaQqJ9rbCLtHIe8Y26SrQx7jVhKnqKFZ8k1MuMLeQrc
 WivDHWFupfzWh2a9Fc6Dt/etwer08JalJ5h88ZrZWWci8YfDS3DhWtN4+AmSQzmYz5otB2QdOs
 NP3eeF71ULrJzBQczTzaywFZtUdkhcbUagi3WKfXL4Z34lceadq1RTD1r5z6LmLB0RGtrM8nVs
 aUU=
X-IronPort-AV: E=Sophos;i="5.79,374,1602572400"; 
   d="scan'208";a="101330561"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Jan 2021 09:29:41 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 25 Jan 2021 09:29:40 -0700
Received: from ryzen.microchip.com (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Mon, 25 Jan 2021 09:29:38 -0700
From:   <daire.mcnamara@microchip.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh@kernel.org>, <linux-pci@vger.kernel.org>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <david.abdurachmanov@gmail.com>, <cyril.jean@microchip.com>,
        "Daire McNamara" <daire.mcnamara@microchip.com>
Subject: [PATCH v21 0/4] PCI: microchip: Add host driver for Microchip PCIe controller
Date:   Mon, 25 Jan 2021 16:29:30 +0000
Message-ID: <20210125162934.5335-1-daire.mcnamara@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Daire McNamara <daire.mcnamara@microchip.com>

This patchset adds support for the Microchip PCIe PolarFire PCIe
controller when configured in host (Root Complex) mode.

Updates since v20:
* Changed module license from GPLv2 to GPL
* Removed bus-shift for mc_ecam_ops

Updates since v19:
* Fixes for typos

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

