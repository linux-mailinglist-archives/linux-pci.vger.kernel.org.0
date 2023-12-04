Return-Path: <linux-pci+bounces-402-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E10802F31
	for <lists+linux-pci@lfdr.de>; Mon,  4 Dec 2023 10:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CD22280BD1
	for <lists+linux-pci@lfdr.de>; Mon,  4 Dec 2023 09:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5D81D6A1;
	Mon,  4 Dec 2023 09:48:21 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9534100
	for <linux-pci@vger.kernel.org>; Mon,  4 Dec 2023 01:48:15 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rA5YQ-0003eM-Lw; Mon, 04 Dec 2023 10:47:54 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rA5YP-00DUAb-ET; Mon, 04 Dec 2023 10:47:53 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rA5YP-00DwUx-5M; Mon, 04 Dec 2023 10:47:53 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 1/3] PCI: exynos: Convert to platform remove callback returning void
Date: Mon,  4 Dec 2023 10:47:40 +0100
Message-ID:  <50de44ea8931465fd9cdc821854ea761cb43adf6.1701682617.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2176; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=9oCbK0Yp2ShnHinACpz//7VPzlCB2atD67l4w2424ac=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlbaA7EZ/F4tEiJskKzsrfntxU1ZtsOFxR7BjDd N9/kDC5CLWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZW2gOwAKCRCPgPtYfRL+ TqEiB/4iyJ4y1VKKxiUqbDiqLhOplsfsGFe1+HkQ/ZmB1829tSI79b1ywjcYdZ/KcQkQP+N24w0 N6EOKjzYXVSv9/jL5ff7eResILz34nRL1mDl4QJiGSkyMEvwqPIf4LC/vzCw7pjajoHDqEeIPXH uLAU5nHvXbZIU38NJwOo8nHLA/+6g872BJWUYgCapA/L52AIkThRubOqGSHrIO49hzzZpBjBkim NLasvbp3O0J6zkAzLlk0qd4IvjAZTlOBQQrCScpF64AZMZa5NWUOhcuYJGgkM7MFVcFJsVpCoOG Nnom509ePBkMRK9N7SRtcG6dmuumX4cGKJr4gx6TD4zmkNEy
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
 drivers/pci/controller/dwc/pci-exynos.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
index c6bede346932..104397ba45bd 100644
--- a/drivers/pci/controller/dwc/pci-exynos.c
+++ b/drivers/pci/controller/dwc/pci-exynos.c
@@ -375,7 +375,7 @@ static int exynos_pcie_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int exynos_pcie_remove(struct platform_device *pdev)
+static void exynos_pcie_remove(struct platform_device *pdev)
 {
 	struct exynos_pcie *ep = platform_get_drvdata(pdev);
 
@@ -385,8 +385,6 @@ static int exynos_pcie_remove(struct platform_device *pdev)
 	phy_exit(ep->phy);
 	exynos_pcie_deinit_clk_resources(ep);
 	regulator_bulk_disable(ARRAY_SIZE(ep->supplies), ep->supplies);
-
-	return 0;
 }
 
 static int exynos_pcie_suspend_noirq(struct device *dev)
@@ -431,7 +429,7 @@ static const struct of_device_id exynos_pcie_of_match[] = {
 
 static struct platform_driver exynos_pcie_driver = {
 	.probe		= exynos_pcie_probe,
-	.remove		= exynos_pcie_remove,
+	.remove_new	= exynos_pcie_remove,
 	.driver = {
 		.name	= "exynos-pcie",
 		.of_match_table = exynos_pcie_of_match,
-- 
2.42.0


