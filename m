Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCA072D9B08
	for <lists+linux-pci@lfdr.de>; Mon, 14 Dec 2020 16:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbgLNPbv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Dec 2020 10:31:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731495AbgLNP21 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Dec 2020 10:28:27 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F4CC0613D6;
        Mon, 14 Dec 2020 07:27:46 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id hk16so6743130pjb.4;
        Mon, 14 Dec 2020 07:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zod9g0ucmYQBVnFLZZB9W/Bw5VKVjG5oSiWxDHXjy38=;
        b=bXYK1ZSyjNXW0Qh+M9C2SfRd7r1pKszYRp26r4cxtylix/RS6bG6mpeRD/E372JTD1
         fpf3a9iiJOOsh7SqakQ+H8POqiWMeQcZiG8AmdC4579fLMnqSZfsTnxPhfMxxOpa51RG
         qpMDgefR5lpG1xShf/T5e4KxPLleWKU7IA4YW887h+maYDZ5D3rbuom7R5EIQcugIuJT
         9iEKkKyT8hb+IZft0m4ruG5SFBGxdEnIYo3i5wGvHdMSyHFVIKYM2XD6LK1t8dppU9Te
         fothtOHrTonFpS2q4LQMU/mMZ9DQKY9xzGGdlldZmSkUtx/JIaG/9cyri9dK4l8BruQm
         3ayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zod9g0ucmYQBVnFLZZB9W/Bw5VKVjG5oSiWxDHXjy38=;
        b=Kab0BzRD3svqrL0nprzClwpPVDaIg4ovkD23pNTJonIReZXyggMFuVZmKIfO5/QFio
         67qBmQ2387+GnNmlMy4lAxNobCQeW7ISc+Vq6Zf9nKGx76BqtdTOwv2t1CdhxFgTMMwl
         5GEgHkqkGrRNUduNIX3jlWGwS1LfLREVxD8dP7wpXzogjiVSkAnq/ZugAwexiJZ4AN1T
         uGh19DZeG/9PH3lYcIn2oGaFUUgpe4XLXQXluf+LvXvpb1kfAaWZ7W8jw10h8aoTN1CF
         GMMsThm3ETlQDnSvmvwGFtYFf7jh4TnzgNXxd6weiG2CjBK1H9Ob8Bc8DWEG054ik/g4
         WdJg==
X-Gm-Message-State: AOAM531fbWY0nddzxWQ9XeO1U3x/klSPyMAtY3ummaIO2tbgpmdYg2nQ
        bzSXHscr/z4pYgo4B3aLAkWlkVfgmm55/3cI
X-Google-Smtp-Source: ABdhPJwg6z41nULlj+fBpHui3mHcsEEdsSWv2Url9DdIMk0b8MqzGdSGYGJWk/tDMRfFUjVbLs5lpw==
X-Received: by 2002:a17:902:8f94:b029:da:d168:4443 with SMTP id z20-20020a1709028f94b02900dad1684443mr22760620plo.57.1607959666413;
        Mon, 14 Dec 2020 07:27:46 -0800 (PST)
Received: from localhost.localdomain ([124.253.101.135])
        by smtp.googlemail.com with ESMTPSA id y6sm19656391pjl.0.2020.12.14.07.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 07:27:45 -0800 (PST)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     bjorn@helgaas.com, linux-pci@vger.kernel.org,
        Damien.LeMoal@wdc.com, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH v1] drivers: block: skd: remove skd_pci_info()
Date:   Mon, 14 Dec 2020 20:57:20 +0530
Message-Id: <20201214152720.11922-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Change the call to skd_pci_info() to pcie_print_link_status().
pcie_print_link_status() can be used to print the link speed and
the link width, skd_pci_info() does the same and hence it is removed.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
v1 - Add call to pcie_print_link_status()
---
 drivers/block/skd_main.c | 33 +--------------------------------
 1 file changed, 1 insertion(+), 32 deletions(-)

diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
index a962b4551bed..efd69f349043 100644
--- a/drivers/block/skd_main.c
+++ b/drivers/block/skd_main.c
@@ -3134,40 +3134,10 @@ static const struct pci_device_id skd_pci_tbl[] = {
 
 MODULE_DEVICE_TABLE(pci, skd_pci_tbl);
 
-static char *skd_pci_info(struct skd_device *skdev, char *str)
-{
-	int pcie_reg;
-
-	strcpy(str, "PCIe (");
-	pcie_reg = pci_find_capability(skdev->pdev, PCI_CAP_ID_EXP);
-
-	if (pcie_reg) {
-
-		char lwstr[6];
-		uint16_t pcie_lstat, lspeed, lwidth;
-
-		pcie_reg += 0x12;
-		pci_read_config_word(skdev->pdev, pcie_reg, &pcie_lstat);
-		lspeed = pcie_lstat & (0xF);
-		lwidth = (pcie_lstat & 0x3F0) >> 4;
-
-		if (lspeed == 1)
-			strcat(str, "2.5GT/s ");
-		else if (lspeed == 2)
-			strcat(str, "5.0GT/s ");
-		else
-			strcat(str, "<unknown> ");
-		snprintf(lwstr, sizeof(lwstr), "%dX)", lwidth);
-		strcat(str, lwstr);
-	}
-	return str;
-}
-
 static int skd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	int i;
 	int rc = 0;
-	char pci_str[32];
 	struct skd_device *skdev;
 
 	dev_dbg(&pdev->dev, "vendor=%04X device=%04x\n", pdev->vendor,
@@ -3201,8 +3171,7 @@ static int skd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_out_regions;
 	}
 
-	skd_pci_info(skdev, pci_str);
-	dev_info(&pdev->dev, "%s 64bit\n", pci_str);
+	pcie_print_link_status(pdev);
 
 	pci_set_master(pdev);
 	rc = pci_enable_pcie_error_reporting(pdev);
-- 
2.27.0

