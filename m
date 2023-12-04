Return-Path: <linux-pci+bounces-400-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC5A802F2F
	for <lists+linux-pci@lfdr.de>; Mon,  4 Dec 2023 10:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 217AC1F2111B
	for <lists+linux-pci@lfdr.de>; Mon,  4 Dec 2023 09:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9345D1D553;
	Mon,  4 Dec 2023 09:48:13 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A291AA
	for <linux-pci@vger.kernel.org>; Mon,  4 Dec 2023 01:48:09 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rA5YQ-0003eN-1D; Mon, 04 Dec 2023 10:47:54 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rA5YP-00DUAe-KX; Mon, 04 Dec 2023 10:47:53 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rA5YP-00DwV1-BZ; Mon, 04 Dec 2023 10:47:53 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Rob Herring <robh@kernel.org>,
	linux-pci@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 2/3] PCI: keystone: Convert to platform remove callback returning void
Date: Mon,  4 Dec 2023 10:47:41 +0100
Message-ID:  <06612aff79dfb52d5b0b20129dff5e4b1f04d3a7.1701682617.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1701682617.git.u.kleine-koenig@pengutronix.de>
References: <cover.1701682617.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2028; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=mk9zdVe5tMt6+ZxMJkEQ3eo3rih7oRpb819a2sIwFhU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlbaA8Q4i2FMdcMbyyLdwWz7KrqVVjamnMPqaW1 P240UoMWGyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZW2gPAAKCRCPgPtYfRL+ TlaYCAC7KqR/i/7KyfYDewDeiey3TGt3Liv9LWmE/qQunQfORBVBdLm/6bWfnwjt9x88R1zuAUE IngLm4i25Y4T7Jle02BPeCuEC4UfVHVkoJpEPbbGvBV3Q0fDlbEAsZBKuE2QGIjDYzcWceZvZ76 S1IL2Fp5XCy7X1bNCMGq+yR/KFTBwml2O5YvrWMqn8upkkrrtNI0pLU3gJ3ockCV8V3i2GBlIJ1 vEdOC2bQXOiU8GUBNxV0Gp84C26wqwKp2J9KPuWuHMk/jc/VWq51pjkuP039l3PrrgHuFfiwvc5 6WNqmELWJRlFIrgqsUAsIBn+10NCh6LJqseSC8OxXcoq2Wrh
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.

To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
.remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

In the error path emit an error message replacing the (less useful)
message by the core. Apart from the improved error message there is no
change in behaviour.

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pci/controller/dwc/pci-keystone.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 0def919f89fa..41c7ff862732 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -1302,7 +1302,7 @@ static int ks_pcie_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int ks_pcie_remove(struct platform_device *pdev)
+static void ks_pcie_remove(struct platform_device *pdev)
 {
 	struct keystone_pcie *ks_pcie = platform_get_drvdata(pdev);
 	struct device_link **link = ks_pcie->link;
@@ -1314,13 +1314,11 @@ static int ks_pcie_remove(struct platform_device *pdev)
 	ks_pcie_disable_phy(ks_pcie);
 	while (num_lanes--)
 		device_link_del(link[num_lanes]);
-
-	return 0;
 }
 
 static struct platform_driver ks_pcie_driver = {
 	.probe  = ks_pcie_probe,
-	.remove = ks_pcie_remove,
+	.remove_new = ks_pcie_remove,
 	.driver = {
 		.name	= "keystone-pcie",
 		.of_match_table = ks_pcie_of_match,
-- 
2.42.0


