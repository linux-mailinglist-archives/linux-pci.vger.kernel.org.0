Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225134C2F3D
	for <lists+linux-pci@lfdr.de>; Thu, 24 Feb 2022 16:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233983AbiBXPR7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Feb 2022 10:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235924AbiBXPRx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Feb 2022 10:17:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57841CF3A4
        for <linux-pci@vger.kernel.org>; Thu, 24 Feb 2022 07:17:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7A4D60EAA
        for <linux-pci@vger.kernel.org>; Thu, 24 Feb 2022 15:17:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E11F8C340EC;
        Thu, 24 Feb 2022 15:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645715842;
        bh=w6A0U9Uhn4+JdPjAJvGRWzWyHpMuNYJAcNXTqv1RpnE=;
        h=From:To:Cc:Subject:Date:From;
        b=D09ac/tosSnGDopFS9Edb8PNDaMMUpFvuuta+tLxwmCWTOumSHj0wSBXk55jZ6TpM
         Xor5YC/mTY+rM6lt+nBxCvvjwmeYn7S8TUzSTkrxNEQYwqcngicbKlWvR83WN71UnS
         8qXr+mbNcn40lVtbPQZoMDa55FFSIjw9m4yy3RrQfLJ+FZh9BIF+veXTtvdcY2QFat
         Qa1oMD1oggkIrv6TF21FwNV4UsQnm2RhdS+jdY6cbqJHGlf6mtqer8p9FyGUxyLerC
         r55ohhInEWt71Pq6kntBZ4R0UlKGZ3qp0aoNHJ0rB71EYr6lCCncn9jeK19GsysYjK
         7wjyQVqCEQ9HA==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     pali@kernel.org, linux-pci@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH phy v4 5/5] Revert "PCI: aardvark: Fix initialization with old Marvell's Arm Trusted Firmware"
Date:   Thu, 24 Feb 2022 16:17:18 +0100
Message-Id: <20220224151718.7679-1-kabel@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

This reverts commit b0c6ae0f8948a2be6bf4e8b4bbab9ca1343289b6.

Armada 3720 phy driver (phy-mvebu-a3700-comphy.c) does not return
-EOPNOTSUPP from phy_power_on() callback anymore.

So remove dead code which handles -EOPNOTSUPP return value.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
Dear Lorenzo,

could you please give your Ack for this, so that Vinod can apply it
with the rest of the comphy series?
The series can be found at
  https://lore.kernel.org/linux-phy/20220203214444.1508-1-kabel@kernel.org/

Marek
---
 drivers/pci/controller/pci-aardvark.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 4f5b44827d21..6bae688852a5 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1482,9 +1482,7 @@ static int advk_pcie_enable_phy(struct advk_pcie *pcie)
 	}
 
 	ret = phy_power_on(pcie->phy);
-	if (ret == -EOPNOTSUPP) {
-		dev_warn(&pcie->pdev->dev, "PHY unsupported by firmware\n");
-	} else if (ret) {
+	if (ret) {
 		phy_exit(pcie->phy);
 		return ret;
 	}
-- 
2.34.1

