Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78D1C438520
	for <lists+linux-pci@lfdr.de>; Sat, 23 Oct 2021 22:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhJWUE2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 23 Oct 2021 16:04:28 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:57409 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbhJWUE2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 23 Oct 2021 16:04:28 -0400
Received: from pop-os.home ([92.140.161.106])
        by smtp.orange.fr with ESMTPA
        id eNDSmCwfQTdRTeNDSmKOiE; Sat, 23 Oct 2021 22:02:07 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 23 Oct 2021 22:02:07 +0200
X-ME-IP: 92.140.161.106
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     toan@os.amperecomputing.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] PCI: xgene-msi: Use bitmap_zalloc() when applicable
Date:   Sat, 23 Oct 2021 22:02:05 +0200
Message-Id: <32f3bc1fbfbd6ee0815e565012904758ca9eff7e.1635019243.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

'xgene_msi->bitmap' is a bitmap. So use 'bitmap_zalloc()' to simplify code,
improve the semantic and avoid some open-coded arithmetic in allocator
arguments.

Also change the corresponding 'kfree()' into 'bitmap_free()' to keep
consistency.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/pci/controller/pci-xgene-msi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pci-xgene-msi.c b/drivers/pci/controller/pci-xgene-msi.c
index c50ff279903c..bfa259781b69 100644
--- a/drivers/pci/controller/pci-xgene-msi.c
+++ b/drivers/pci/controller/pci-xgene-msi.c
@@ -269,9 +269,7 @@ static void xgene_free_domains(struct xgene_msi *msi)
 
 static int xgene_msi_init_allocator(struct xgene_msi *xgene_msi)
 {
-	int size = BITS_TO_LONGS(NR_MSI_VEC) * sizeof(long);
-
-	xgene_msi->bitmap = kzalloc(size, GFP_KERNEL);
+	xgene_msi->bitmap = bitmap_zalloc(NR_MSI_VEC, GFP_KERNEL);
 	if (!xgene_msi->bitmap)
 		return -ENOMEM;
 
@@ -360,7 +358,7 @@ static int xgene_msi_remove(struct platform_device *pdev)
 
 	kfree(msi->msi_groups);
 
-	kfree(msi->bitmap);
+	bitmap_free(msi->bitmap);
 	msi->bitmap = NULL;
 
 	xgene_free_domains(msi);
-- 
2.30.2

