Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0A26474DC6
	for <lists+linux-pci@lfdr.de>; Tue, 14 Dec 2021 23:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbhLNWPU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Dec 2021 17:15:20 -0500
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:40596 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232252AbhLNWPQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Dec 2021 17:15:16 -0500
Received: from [77.244.183.192] (port=63782 helo=melee.fritz.box)
        by hostingweb31.netsons.net with esmtpa (Exim 4.94.2)
        (envelope-from <luca@lucaceresoli.net>)
        id 1mxG4n-000AP5-2s; Tue, 14 Dec 2021 23:15:13 +0100
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-pci@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sekhar Nori <nsekhar@ti.com>, kernel test robot <lkp@intel.com>
Subject: [PATCH 2/2] PCI: dra7xx: Fix clk disabling in some error paths
Date:   Tue, 14 Dec 2021 23:14:50 +0100
Message-Id: <20211214221450.589884-2-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211214221450.589884-1-luca@lucaceresoli.net>
References: <20211214221450.589884-1-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

dra7xx->clk is not disabled+unprepared in some one the error paths,
specifically devm_phy_get() fails.

Fix by moving the clk_prepare_enable() stanza after all the devm_*()
resource grabbing but before all the goto-based error management. This way
it is possible to keep the 'return err' without the need to replace it with
a new goto statement.

Fixes: 5af9405397bf ("PCI: dra7xx: Get an optional clock")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/lkml/202111301803.NOwoj4Jd-lkp@intel.com/
Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
---
 drivers/pci/controller/dwc/pci-dra7xx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index 2ccc53869e13..d17cc088d07e 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -748,10 +748,6 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(dra7xx->clk),
 				     "clock request failed");
 
-	ret = clk_prepare_enable(dra7xx->clk);
-	if (ret)
-		return ret;
-
 	for (i = 0; i < phy_count; i++) {
 		snprintf(name, sizeof(name), "pcie-phy%d", i);
 		phy[i] = devm_phy_get(dev, name);
@@ -759,6 +755,10 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
 			return PTR_ERR(phy[i]);
 	}
 
+	ret = clk_prepare_enable(dra7xx->clk);
+	if (ret)
+		return ret;
+
 	for (i = 0; i < phy_count; i++) {
 		link[i] = device_link_add(dev, &phy[i]->dev, DL_FLAG_STATELESS);
 		if (!link[i]) {
-- 
2.25.1

