Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7103630E1CC
	for <lists+linux-pci@lfdr.de>; Wed,  3 Feb 2021 19:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbhBCSCz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Feb 2021 13:02:55 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:49780 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232439AbhBCR61 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Feb 2021 12:58:27 -0500
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id CF338402A6;
        Wed,  3 Feb 2021 17:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1612375047; bh=0LPtbl9/ClUF4yDOkawYP8loLWswFVdF/V71qFngQe4=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=F50/7Ozy5T34Q+AxMniZvA9jVAoSXA5k6WuhgaR4yfXsiSplx+eF0utu0k4Yu6Rzn
         oFq9Vql8YV0yLUf/RuAdH75OEY06WUc8EN+VLntR9xpsqSilm7IAFQu9tkczFa3FbE
         c8vnW+6WRhGXhDOMV7/HweIPc/4MI15uV4EnyOmK3TDKUcJvXHTdglAV0kJuSgiGVI
         NOCWS7RPAk//umWs/bvG9tew/q1fuc4vU+gYqZznrc0DZL9e7y7IePe3Z3xLr5h3iN
         l0sQI3bnTAkVvRclNVFYX/2/NrrkjGDn2Ql/BKdubnLTSoWKmQoJ6RXptWxGAJTF6m
         cNyACV6gAMIMg==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 9F6B6A005E;
        Wed,  3 Feb 2021 17:57:25 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH v3 11/15] dmaengine: dw-edma: Move struct dentry variable from static definition into dw_edma struct
Date:   Wed,  3 Feb 2021 18:57:03 +0100
Message-Id: <83c8ce1eb27455b87b5f4fb3485c1e118e2ccd34.1612374941.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1612374941.git.gustavo.pimentel@synopsys.com>
References: <cover.1612374941.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1612374941.git.gustavo.pimentel@synopsys.com>
References: <cover.1612374941.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Move struct dentry variable from static definition (dw-edma-v0-debugfs.c)
into dw_edma struct (dw-edma-core.h)

Also the variable was renamed from base_dir to debugfs.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/dma/dw-edma/dw-edma-core.c       |  2 +-
 drivers/dma/dw-edma/dw-edma-core.h       |  3 +++
 drivers/dma/dw-edma/dw-edma-v0-core.c    |  4 ++--
 drivers/dma/dw-edma/dw-edma-v0-core.h    |  2 +-
 drivers/dma/dw-edma/dw-edma-v0-debugfs.c | 22 +++++++++++++---------
 drivers/dma/dw-edma/dw-edma-v0-debugfs.h |  4 ++--
 6 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 48887b5..8d8292e 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -1003,7 +1003,7 @@ int dw_edma_remove(struct dw_edma_chip *chip)
 	dma_async_device_unregister(&dw->rd_edma);
 
 	/* Turn debugfs off */
-	dw_edma_v0_core_debugfs_off();
+	dw_edma_v0_core_debugfs_off(chip);
 
 	return 0;
 }
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index cba5436..60316d4 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -137,6 +137,9 @@ struct dw_edma {
 	const struct dw_edma_core_ops	*ops;
 
 	raw_spinlock_t			lock;		/* Only for legacy */
+#ifdef CONFIG_DEBUG_FS
+	struct dentry			*debugfs;
+#endif /* CONFIG_DEBUG_FS */
 };
 
 struct dw_edma_sg {
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 5b0541a..329fc2e 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -506,7 +506,7 @@ void dw_edma_v0_core_debugfs_on(struct dw_edma_chip *chip)
 	dw_edma_v0_debugfs_on(chip);
 }
 
-void dw_edma_v0_core_debugfs_off(void)
+void dw_edma_v0_core_debugfs_off(struct dw_edma_chip *chip)
 {
-	dw_edma_v0_debugfs_off();
+	dw_edma_v0_debugfs_off(chip);
 }
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.h b/drivers/dma/dw-edma/dw-edma-v0-core.h
index abae152..2afa626 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.h
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.h
@@ -23,6 +23,6 @@ void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first);
 int dw_edma_v0_core_device_config(struct dw_edma_chan *chan);
 /* eDMA debug fs callbacks */
 void dw_edma_v0_core_debugfs_on(struct dw_edma_chip *chip);
-void dw_edma_v0_core_debugfs_off(void);
+void dw_edma_v0_core_debugfs_off(struct dw_edma_chip *chip);
 
 #endif /* _DW_EDMA_V0_CORE_H */
diff --git a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
index 157dfc2..4b3bcff 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
@@ -38,7 +38,6 @@
 #define CHANNEL_STR				"channel"
 #define REGISTERS_STR				"registers"
 
-static struct dentry				*base_dir;
 static struct dw_edma				*dw;
 static struct dw_edma_v0_regs			__iomem *regs;
 
@@ -272,7 +271,7 @@ static void dw_edma_debugfs_regs(void)
 	struct dentry *regs_dir;
 	int nr_entries;
 
-	regs_dir = debugfs_create_dir(REGISTERS_STR, base_dir);
+	regs_dir = debugfs_create_dir(REGISTERS_STR, dw->debugfs);
 	if (!regs_dir)
 		return;
 
@@ -293,18 +292,23 @@ void dw_edma_v0_debugfs_on(struct dw_edma_chip *chip)
 	if (!regs)
 		return;
 
-	base_dir = debugfs_create_dir(dw->name, NULL);
-	if (!base_dir)
+	dw->debugfs = debugfs_create_dir(dw->name, NULL);
+	if (!dw->debugfs)
 		return;
 
-	debugfs_create_u32("mf", 0444, base_dir, &dw->mf);
-	debugfs_create_u16("wr_ch_cnt", 0444, base_dir, &dw->wr_ch_cnt);
-	debugfs_create_u16("rd_ch_cnt", 0444, base_dir, &dw->rd_ch_cnt);
+	debugfs_create_u32("mf", 0444, dw->debugfs, &dw->mf);
+	debugfs_create_u16("wr_ch_cnt", 0444, dw->debugfs, &dw->wr_ch_cnt);
+	debugfs_create_u16("rd_ch_cnt", 0444, dw->debugfs, &dw->rd_ch_cnt);
 
 	dw_edma_debugfs_regs();
 }
 
-void dw_edma_v0_debugfs_off(void)
+void dw_edma_v0_debugfs_off(struct dw_edma_chip *chip)
 {
-	debugfs_remove_recursive(base_dir);
+	dw = chip->dw;
+	if (!dw)
+		return;
+
+	debugfs_remove_recursive(dw->debugfs);
+	dw->debugfs = NULL;
 }
diff --git a/drivers/dma/dw-edma/dw-edma-v0-debugfs.h b/drivers/dma/dw-edma/dw-edma-v0-debugfs.h
index 5450a0a..d0ff25a 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-debugfs.h
+++ b/drivers/dma/dw-edma/dw-edma-v0-debugfs.h
@@ -13,13 +13,13 @@
 
 #ifdef CONFIG_DEBUG_FS
 void dw_edma_v0_debugfs_on(struct dw_edma_chip *chip);
-void dw_edma_v0_debugfs_off(void);
+void dw_edma_v0_debugfs_off(struct dw_edma_chip *chip);
 #else
 static inline void dw_edma_v0_debugfs_on(struct dw_edma_chip *chip)
 {
 }
 
-static inline void dw_edma_v0_debugfs_off(void)
+static inline void dw_edma_v0_debugfs_off(struct dw_edma_chip *chip)
 {
 }
 #endif /* CONFIG_DEBUG_FS */
-- 
2.7.4

