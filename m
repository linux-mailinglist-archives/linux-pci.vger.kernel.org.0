Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F396E5646
	for <lists+linux-pci@lfdr.de>; Tue, 18 Apr 2023 03:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjDRBR3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Apr 2023 21:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjDRBR2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Apr 2023 21:17:28 -0400
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8C83AA2;
        Mon, 17 Apr 2023 18:17:27 -0700 (PDT)
From:   Patrick McLean <chutzpah@gentoo.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-ide@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, Dave Airlie <airlied@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org,
        Patrick McLean <chutzpah@gentoo.org>
Subject: [PATCH 2/2] ata: libata-core: Apply ATI NCQ horkage to ASPEED as well
Date:   Mon, 17 Apr 2023 18:17:20 -0700
Message-Id: <20230418011720.3900090-3-chutzpah@gentoo.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230418011720.3900090-1-chutzpah@gentoo.org>
References: <20230418011720.3900090-1-chutzpah@gentoo.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We have some machines with ASPEED SATA controllers, and are seeing the same NCQ
issues that ATI controllers (I am not sure if it's a rebranded ATI controller,
or they both have some faulty implementation). This NCQ breakage is consistent
across a few different types of drives.

Instead of maintaining a list of drives that are broken with ASPEED controllers
as well as ATI, let's just treat ASPEED controllers like ATI ones, and disable
NCQ on drives that have ATA_HORKAGE_NO_NCQ_ON_ATI set on them.

We have been running this patch on several machines for over a week now without
reproducing an issue that was happening almost daily before.

Signed-off-by: Patrick McLean <chutzpah@gentoo.org>
---
 drivers/ata/libata-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 14c17c3bda4e..051492e8e9f9 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2219,7 +2219,8 @@ static int ata_dev_config_ncq(struct ata_device *dev,
 	}
 
 	if (dev->horkage & ATA_HORKAGE_NO_NCQ_ON_ATI &&
-	    ata_dev_check_adapter(dev, PCI_VENDOR_ID_ATI)) {
+	    (ata_dev_check_adapter(dev, PCI_VENDOR_ID_ATI) ||
+		ata_dev_check_adapter(dev, PCI_VENDOR_ID_ASPEED))) {
 		snprintf(desc, desc_sz, "NCQ (not used)");
 		return 0;
 	}
-- 
2.40.0

