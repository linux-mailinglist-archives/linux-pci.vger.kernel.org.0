Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88A583B1BE4
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jun 2021 16:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhFWOEa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Jun 2021 10:04:30 -0400
Received: from mga12.intel.com ([192.55.52.136]:20145 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230505AbhFWOEa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Jun 2021 10:04:30 -0400
IronPort-SDR: xRyhFs5uJKNrA4bJVtw7Bol+SF5gEz02dztZNeSej4+OD7mA7th1CMUDIn200aPubJ+m6hJFez
 asg0kOBcXHYA==
X-IronPort-AV: E=McAfee;i="6200,9189,10024"; a="186952936"
X-IronPort-AV: E=Sophos;i="5.83,294,1616482800"; 
   d="scan'208";a="186952936"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2021 07:00:45 -0700
IronPort-SDR: I8TbkGBw6UGsu7YJpdrCWl+DcPYbqeOZc6VkiPGbAq5zl7Wg1oYjQbFE71fzIyZSsaqFyFP3PU
 v5KOa2urwscQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,293,1616482800"; 
   d="scan'208";a="453044333"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 23 Jun 2021 07:00:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4C50E23A; Wed, 23 Jun 2021 17:01:08 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/2] PCI: dwc: Clean up Kconfig dependencies (PCIE_DW_EP)
Date:   Wed, 23 Jun 2021 17:01:03 +0300
Message-Id: <20210623140103.47818-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210623140103.47818-1-andriy.shevchenko@linux.intel.com>
References: <20210623140103.47818-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The "depends on" is no-op in the selectable options.

Clean up the users of PCIE_DW_EP and introduce idiom

	depends on PCI_ENDPOINT
	select PCIE_DW_EP

for all of them.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pci/controller/dwc/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 9bfd41eadd5e..ca5de4e40fbe 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -12,7 +12,6 @@ config PCIE_DW_HOST
 
 config PCIE_DW_EP
 	bool
-	depends on PCI_ENDPOINT
 	select PCIE_DW
 
 config PCI_DRA7XX
@@ -37,8 +36,8 @@ config PCI_DRA7XX_HOST
 config PCI_DRA7XX_EP
 	bool "TI DRA7xx PCIe controller Endpoint Mode"
 	depends on SOC_DRA7XX || COMPILE_TEST
-	depends on PCI_ENDPOINT
 	depends on OF && HAS_IOMEM && TI_PIPE3
+	depends on PCI_ENDPOINT
 	select PCIE_DW_EP
 	select PCI_DRA7XX
 	help
-- 
2.30.2

