Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3249128B320
	for <lists+linux-pci@lfdr.de>; Mon, 12 Oct 2020 12:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387622AbgJLK55 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Oct 2020 06:57:57 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:28535 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387573AbgJLK55 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Oct 2020 06:57:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1602500277; x=1634036277;
  h=from:to:subject:date:message-id:mime-version;
  bh=jKRvl6jMqXwX/vE4hJPTv8XOCpYAkpzoiU+WD9OSHsw=;
  b=eD2+cPRKENEoCp2rvdAttOQ8LfZmIOMA3zciNfwNZNVRXsq1HAP0YPaT
   jV6NpHCcdiCRDLAjuZDxwvVjMmDLJev9M9SS4MQb8j5ikD46aHtk6WR1/
   wwpQE614R25ldgn/R/NpMY5e5SvynNXZ97sj6MiJPvKqPGUSEwZcKhGig
   NtAgMp6H9gao1/fyTmve4QEIEFID9U9yVdJNfb/IEzRDuUmLNGva0Df9+
   72Y6n+OMsBWXTVOHuVTO062PJ8zPzgtcNY+VHWUPY5nCULZ2Lx1Up5MDS
   PhhqRkH7vlZp6wEDXf1tFjHqgT9bDHz71+CH/0exp9cCLahRmziFSwx8J
   g==;
IronPort-SDR: kik4SbWL+IThQSJzRhWB8Yq/PzSHJFTT9Lx++ZF690OWb3FcsFvcfkC7Jy9jQtgYeeIODWi8Jy
 0sRpILzjjXjc41KMK1r5nYrLK0C3joYk3OCwRe4qh89B7+YnOGhPVUKE4RkxR7lSU1qSyRAs3+
 Yy94cUS0XYfeUJmhe2PEcHaf1hzOXAzWm0QCSR/W3D/1lhld3mu3ezL/uUn17zjp6AujxsbgtA
 SJvRCjuHZjA782sQkbqkAcPtpO9fYLAPlf1m3yK53hDK/etd/EoQolLFfAlApiTqzFpcx+Fb/o
 6SA=
X-IronPort-AV: E=Sophos;i="5.77,366,1596524400"; 
   d="scan'208";a="89886348"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Oct 2020 03:57:56 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 12 Oct 2020 03:57:56 -0700
Received: from ryzen.microchip.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Mon, 12 Oct 2020 03:57:54 -0700
From:   <daire.mcnamara@microchip.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <robh@kernel.org>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <david.abdurachmanov@gmail.com>
Subject: [PATCH v16 0/3] PCI: microchip: Add host driver for Microchip PCIe controller
Date:   Mon, 12 Oct 2020 11:57:51 +0100
Message-ID: <20201012105754.22596-1-daire.mcnamara@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patchset adds support for the Microchip PCIe PolarFire PCIe
controller when configured in host (Root Complex) mode.

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

Daire McNamara (2):
  dt-bindings: PCI: microchip: Add Microchip PolarFire host binding
  PCI: microchip: Add host driver for Microchip PCIe controller

Daire McNamara (3):
  PCI: Call platform_set_drvdata earlier in devm_pci_alloc_host_bridge
  dt-bindings: PCI: microchip: Add Microchip PolarFire host binding
  PCI: microchip: Add host driver for Microchip PCIe controller

 .../bindings/pci/microchip,pcie-host.yaml     |  93 +++
 drivers/pci/controller/Kconfig                |   9 +
 drivers/pci/controller/Makefile               |   1 +
 drivers/pci/controller/pci-host-common.c      |   4 +-
 drivers/pci/controller/pcie-microchip-host.c  | 541 ++++++++++++++++++
 5 files changed, 646 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
 create mode 100644 drivers/pci/controller/pcie-microchip-host.c


base-commit: 7fe10096c1508c7f033d34d0741809f8eecc1ed4
prerequisite-patch-id: b98abc1ad412692a95e3eb3f7adfaff214750282
prerequisite-patch-id: b77f4eea4090304b5c113e4ccc29e64fc82cdc45
-- 
2.25.1

