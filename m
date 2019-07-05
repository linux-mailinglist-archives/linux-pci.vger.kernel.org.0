Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6883E6029A
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2019 10:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbfGEItG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Jul 2019 04:49:06 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:8397 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfGEItG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 Jul 2019 04:49:06 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d1f0f050001>; Fri, 05 Jul 2019 01:49:09 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 05 Jul 2019 01:49:05 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 05 Jul 2019 01:49:05 -0700
Received: from HQMAIL106.nvidia.com (172.18.146.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Jul
 2019 08:49:05 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 5 Jul 2019 08:49:04 +0000
Received: from moonraker.nvidia.com (Not Verified[10.26.11.221]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d1f0eff0002>; Fri, 05 Jul 2019 01:49:04 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH] PCI: tegra: Fix support for GPIO based PERST#
Date:   Fri, 5 Jul 2019 09:48:50 +0100
Message-ID: <20190705084850.30777-1-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1562316549; bh=tBHCslONGNXrTuqR08BQriljhrvSbQNaMiL9a/TIMAo=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=mJAWtXLuY1JNrR9BMi1//luoq7N7RQzV7q4o2a8v/v9v1QaqQkNEVTrOdJkZyYWzN
         Bzizezio0/QJN6c1IDzuk1IuqK0EfHChlCErUvY+domCQXoS4JCMwOlaCutYlg+9yG
         H0OVifUDuhYmON08B9tW0YDOctONAb8JcZnhliFI+QzSOtIoxObXOMrhQqCZz9Dnx9
         QlKEYZRPco8SWFYg2cUNWa0NIO1zsqZ8KuG4u9nSIt0Y6H/7lKX0G81/6Wzl7hfCt1
         TnFr/kHpaOnpH0+nyn5IyYskyB2V8wflU2jOrFfAIMQlUCJc1vGBnuebN1zqr0Nue9
         68PX0w28Noe7w==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Commit 5e5e9c23f82a ("PCI: tegra: Add support for GPIO based PERST#")
calls the function devm_gpiod_get_from_of_node() to request a GPIO.
Unfortunately, around the same time this was merged, commit 025bf37725f1
("gpio: Fix return value mismatch of function gpiod_get_from_of_node()")
was also merged to fix the return value of the function
devm_gpiod_get_from_of_node() that was incorrectly returning NULL
instead of an error pointer encoded with -ENOENT if no GPIO was found.
When this fix for the GPIO subsystem was merged, PCI support for Tegra
devices that did not provide a GPIO for the PERST# (which is optional)
broke because the Tegra PCI driver was expecting NULL to be returned if
no GPIO was present and not -ENOENT.

Fix this by checking to see if -ENOENT is returned from the function
devm_gpiod_get_from_of_node(), to indicate there is no GPIO for PERST#
present, and if this is the case set the variable 'reset_gpio' to NULL.
If the variable 'reset_gpio' is NULL then the Tegra PCI driver will
fallback to using the AFI register to toggle the PERST#. Finally,
correct the comment now that NULL is no longer returned from
devm_gpiod_get_from_of_node().

Fixes: 5e5e9c23f82a ("PCI: tegra: Add support for GPIO based PERST#")
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/pci/controller/pci-tegra.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 9cc03a2549c0..ff8a346f3e04 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -2295,18 +2295,22 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
 		}
 
 		/*
-		 * Returns null if reset-gpios property is not populated and
-		 * fall back to using AFI per port register to toggle PERST#
-		 * SFIO line.
+		 * Returns -ENOENT if reset-gpios property is not populated
+		 * and in this case fall back to using AFI per port register
+		 * to toggle PERST# SFIO line.
 		 */
 		rp->reset_gpio = devm_gpiod_get_from_of_node(dev, port,
 							     "reset-gpios", 0,
 							     GPIOD_OUT_LOW,
 							     label);
 		if (IS_ERR(rp->reset_gpio)) {
-			err = PTR_ERR(rp->reset_gpio);
-			dev_err(dev, "failed to get reset GPIO: %d\n", err);
-			return err;
+			if (PTR_ERR(rp->reset_gpio) == -ENOENT) {
+				rp->reset_gpio = NULL;
+			} else {
+				dev_err(dev, "failed to get reset GPIO: %d\n",
+					err);
+				return PTR_ERR(rp->reset_gpio);
+			}
 		}
 
 		list_add_tail(&rp->list, &pcie->ports);
-- 
2.17.1

