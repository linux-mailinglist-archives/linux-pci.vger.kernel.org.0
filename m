Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8677BBB22
	for <lists+linux-pci@lfdr.de>; Fri,  6 Oct 2023 17:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbjJFPCZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Oct 2023 11:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232622AbjJFPCW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Oct 2023 11:02:22 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048848F
        for <linux-pci@vger.kernel.org>; Fri,  6 Oct 2023 08:02:20 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qomLK-0004VY-Gz; Fri, 06 Oct 2023 17:02:18 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qomLK-00BXcf-1B; Fri, 06 Oct 2023 17:02:18 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qomLJ-00AK0f-OB; Fri, 06 Oct 2023 17:02:17 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH trivial] pci: Replace a strange letter by a normal one
Date:   Fri,  6 Oct 2023 17:02:09 +0200
Message-Id: <20231006150209.87666-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=841; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=mroQWcQsxUtin1DNdma+Dad2UrvwsKB5w/nrFuMoEpo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlICFviW+97Buio9C+IbunVH02mf5eQbTAyHff3 efxPnOVBZSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSAhbwAKCRCPgPtYfRL+ TtRbB/9WmFA+NQt956rehZ8r10FsMliJBUoRG/Qz1YVdSf84BvCmKrepEnms3Bw33dA3tRD+3UD HxarSA4iqgegugXJPC6yaPNoqizz75gQeV6+fZc54TmYZrfrNnuLJbjFuPAwHzjJPmBCsY6pZdx AVA2VR/AIaD7edey8FRpM2Q3KKiCuSzcNcz7Du4jYOXsgdndNk8jMMBB7o3SS5XBn4AIO18Hjlw ZjGle3eVGKKBegE/KC/xkSO4H8r2Dbm8yxkepJrkyifbDcoXBVNQJV017X3zEEuCswCf46dmQYy NK6no33wJ5yyJ4t5R3XWbhs0yuCBpyePnPqmXhFzQEHAJIyx
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The help text contains a cyrillic small "dse" (ѕ). Replace it by a plain
"s".

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pci/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index e9ae66cc4189..74147262625b 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -170,7 +170,7 @@ config PCI_P2PDMA
 	select GENERIC_ALLOCATOR
 	select NEED_SG_DMA_FLAGS
 	help
-	  Enableѕ drivers to do PCI peer-to-peer transactions to and from
+	  Enables drivers to do PCI peer-to-peer transactions to and from
 	  BARs that are exposed in other devices that are the part of
 	  the hierarchy where peer-to-peer DMA is guaranteed by the PCI
 	  specification to work (ie. anything below a single PCI bridge).
-- 
2.40.1

