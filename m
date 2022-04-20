Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B130508193
	for <lists+linux-pci@lfdr.de>; Wed, 20 Apr 2022 08:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359549AbiDTHBf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Apr 2022 03:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234566AbiDTHBe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Apr 2022 03:01:34 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C7235276
        for <linux-pci@vger.kernel.org>; Tue, 19 Apr 2022 23:58:49 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nh4IU-0003jM-6G; Wed, 20 Apr 2022 08:58:42 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nh4IS-00473Q-Um; Wed, 20 Apr 2022 08:58:39 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nh4IQ-004QRg-Np; Wed, 20 Apr 2022 08:58:38 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Daire McNamara <daire.mcnamara@microchip.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        kernel@pengutronix.de, Ian Cowan <ian@linux.cowan.aero>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] PCI: microchip: Add a missing semicolon
Date:   Wed, 20 Apr 2022 08:58:32 +0200
Message-Id: <20220420065832.14173-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1045; h=from:subject; bh=uqX7eUKAZl2N3lbv0wRjiMDwfFurq6GeZw4NpyhgDKU=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBiX65zvclX+PBXsHOa9fGIyGcjIhpbmRyGIv/MMFPD gVYjHjOJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYl+ucwAKCRDB/BR4rcrsCfauB/ 9qIsCQ/KtIpYZmtTJBGj7R8kw23rSlWGthp16Ud7dLGX9lsFhC56n5a0tb4nHtTYzPW7nrpZSgoiQm vIRlrw5yvftqxPUed4e1WXP8wkLu4Uqx7+kRoapOycW54xFubvh+6M5Q/iG2O3u2f4nR7FAHgVymoB vc/XGMN0tR5wrTbAtyZVOZi6QLR07TyEOKL4tkZwwj+6qp7YNJgyPddb/6LCCyUFXDRAoHKyVXiISX AGhBt8/bv+TqNkRgq6k9knAccxtxXTCxT8yQyLUg28Qm2XBiRNU0WGUVi2wwk0QjPFvg/hE0sYCC3i 8wNNmuXjZ3NW1bIvrDVp2QI29x/Wej
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If the driver is configured as a module (after allowing this by changing
PCIE_MICROCHIP_HOST from bool to tristate) the missing semicolon makes the
compiler very unhappy. While there isn't a real problem as
MODULE_DEVICE_TABLE always evaluates to nothing for a built-in driver,
do it right for consistency with other drivers.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

I wonder if there is a technical reason to have PCIE_MICROCHIP_HOST (and
some others) only bool. With this patch applied the driver compiles just
fine with PCIE_MICROCHIP_HOST=m.

Best regards
Uwe

 drivers/pci/controller/pcie-microchip-host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-microchip-host.c b/drivers/pci/controller/pcie-microchip-host.c
index 29d8e81e4181..4b1e130f88a3 100644
--- a/drivers/pci/controller/pcie-microchip-host.c
+++ b/drivers/pci/controller/pcie-microchip-host.c
@@ -1115,7 +1115,7 @@ static const struct of_device_id mc_pcie_of_match[] = {
 	{},
 };
 
-MODULE_DEVICE_TABLE(of, mc_pcie_of_match)
+MODULE_DEVICE_TABLE(of, mc_pcie_of_match);
 
 static struct platform_driver mc_pcie_driver = {
 	.probe = pci_host_common_probe,
-- 
2.35.1

