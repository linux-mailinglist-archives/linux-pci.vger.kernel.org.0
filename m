Return-Path: <linux-pci+bounces-403-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D08B802F32
	for <lists+linux-pci@lfdr.de>; Mon,  4 Dec 2023 10:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ED8B1C20A5E
	for <lists+linux-pci@lfdr.de>; Mon,  4 Dec 2023 09:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11AD1C6A5;
	Mon,  4 Dec 2023 09:48:23 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA2FF2
	for <linux-pci@vger.kernel.org>; Mon,  4 Dec 2023 01:48:18 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rA5YR-0003eR-UH; Mon, 04 Dec 2023 10:47:55 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rA5YP-00DUAh-RO; Mon, 04 Dec 2023 10:47:53 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rA5YP-00DwV5-ID; Mon, 04 Dec 2023 10:47:53 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Xiaowei Song <songxiaowei@hisilicon.com>,
	Binghui Wang <wangbinghui@hisilicon.com>,
	Rob Herring <robh@kernel.org>,
	linux-pci@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 3/3] PCI: kirin: Convert to platform remove callback returning void
Date: Mon,  4 Dec 2023 10:47:42 +0100
Message-ID:  <c3a51791d54deaa818b8526975fc4e16ef1090ce.1701682617.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2032; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=Gbn99g16uISFS3ntBb31dpggvIxd71Aoibn5+ZdXAnc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlbaA9yOURlUmMMwUE8yK0LvQ5gVnyOxBkPUL6S M8UKLUi0eeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZW2gPQAKCRCPgPtYfRL+ Thc0B/0RqclwIVvIjTuFoVLp1SsCar+mZPHoQsHhub/Kv5yjtbtk/7MaKzmghUmEFFjmIRGvstw +lNQ8itkzbOYSRfS/BgKfjtoGVca7S7J8OxJUGBTZM+iJfbIKHisDK+HIn/CEJwO+UQnrb1wEiC OnsQTZbQTrfAdh/Q2ble/iANMQFdbxUqYLQrb1PEL3oo3muvYiz54SVUh9DPADWVQKkyoMPotHb 2dpqdO8imlClUNkPFMANqJqXUNUT3arliegswDsaAtDaq7kakFMkOWfOxxIr+qA8Ev/5TP9jurs OP/K9pAgXaWvttsI6WgsNEE+mOV+sd+4wo5wBH6/jA5mmSL3
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
 drivers/pci/controller/dwc/pcie-kirin.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index 2ee146767971..ca317cb06fbd 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -741,15 +741,13 @@ static int kirin_pcie_power_on(struct platform_device *pdev,
 	return ret;
 }
 
-static int kirin_pcie_remove(struct platform_device *pdev)
+static void kirin_pcie_remove(struct platform_device *pdev)
 {
 	struct kirin_pcie *kirin_pcie = platform_get_drvdata(pdev);
 
 	dw_pcie_host_deinit(&kirin_pcie->pci->pp);
 
 	kirin_pcie_power_off(kirin_pcie);
-
-	return 0;
 }
 
 struct kirin_pcie_data {
@@ -818,7 +816,7 @@ static int kirin_pcie_probe(struct platform_device *pdev)
 
 static struct platform_driver kirin_pcie_driver = {
 	.probe			= kirin_pcie_probe,
-	.remove	        	= kirin_pcie_remove,
+	.remove_new		= kirin_pcie_remove,
 	.driver			= {
 		.name			= "kirin-pcie",
 		.of_match_table		= kirin_pcie_match,
-- 
2.42.0


