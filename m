Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD873D8C4D
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jul 2021 12:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235817AbhG1K4A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jul 2021 06:56:00 -0400
Received: from mga14.intel.com ([192.55.52.115]:51552 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236134AbhG1Kzw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Jul 2021 06:55:52 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10058"; a="212365218"
X-IronPort-AV: E=Sophos;i="5.84,276,1620716400"; 
   d="scan'208";a="212365218"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2021 03:55:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,276,1620716400"; 
   d="scan'208";a="417728466"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 28 Jul 2021 03:55:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 28C0DD7; Wed, 28 Jul 2021 13:56:01 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] PCI: keystone: Use device_get_match_data()
Date:   Wed, 28 Jul 2021 13:55:58 +0300
Message-Id: <20210728105558.23871-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Instead of manipulations with OF APIs, use device_get_match_data().

While at it, drop of_match_ptr() completely and make compiler happy,
otherwise it complains:

  pci-keystone.c:1069:34: warning: ‘ks_pcie_of_match’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index bde3b2824e89..f36ea618a248 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -24,6 +24,7 @@
 #include <linux/of_pci.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/resource.h>
 #include <linux/signal.h>
@@ -1091,7 +1092,6 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	const struct ks_pcie_of_data *data;
-	const struct of_device_id *match;
 	enum dw_pcie_device_mode mode;
 	struct dw_pcie *pci;
 	struct keystone_pcie *ks_pcie;
@@ -1108,8 +1108,7 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	int irq;
 	int i;
 
-	match = of_match_device(of_match_ptr(ks_pcie_of_match), dev);
-	data = (struct ks_pcie_of_data *)match->data;
+	data = device_get_match_data(dev);
 	if (!data)
 		return -EINVAL;
 
@@ -1309,7 +1308,7 @@ static struct platform_driver ks_pcie_driver __refdata = {
 	.remove = __exit_p(ks_pcie_remove),
 	.driver = {
 		.name	= "keystone-pcie",
-		.of_match_table = of_match_ptr(ks_pcie_of_match),
+		.of_match_table = ks_pcie_of_match,
 	},
 };
 builtin_platform_driver(ks_pcie_driver);
-- 
2.30.2

