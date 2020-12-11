Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 659402D7B2D
	for <lists+linux-pci@lfdr.de>; Fri, 11 Dec 2020 17:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389284AbgLKQmt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Dec 2020 11:42:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389066AbgLKQm2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Dec 2020 11:42:28 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9360FC0613CF;
        Fri, 11 Dec 2020 08:41:48 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id n7so7499160pgg.2;
        Fri, 11 Dec 2020 08:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=56syKNuOJ90gHZSy+DseY7QqbtNVXxsXzReMPurvgco=;
        b=nvCFTmQz3OwUdgoGK0ko6g6K3bNYPz4aC4e1cPt04OJBjcCgw+43hqSGV2drGLVlXD
         KbMJfgtkIIoA/4PSZZPztt8valYndCn+NRc1rMw6emKQ7c0EPdTIat2espvMgXnmugkZ
         4GNK7q+vMpUKJD2PkPRNPDp2MtLv+QzjgVbL22X5Dk5QzptBxsyhkhodwtN8HmPtYGvW
         /CBWK6+zAtpmrrWxzPNFUr3PWGzZhy+v0CjAaIStMYDhOizwulJyq7VscJmWk4C7MmKV
         q+QbQSysmg6AOtvpLO1TXwvE8OEjx69/XNyQVVP/SgDHGcvNl6X/7td/Nsi5Gyay/jXk
         enKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=56syKNuOJ90gHZSy+DseY7QqbtNVXxsXzReMPurvgco=;
        b=LAqb5KnRyn8O8g/7XIM+e0MQoxeUSdO2Gk09FVrzAkb3Orrl2qmfWUzcwguw+4yJdo
         OgxgYXx6ur9QwNrIRT/aDV2S9jfHGLW/u09OMlJc3iJIUKQlB4ehigCsIj9/BquySKbS
         ZXLJNOloH8vvokrzQNo3EY9l1ieE0yEJrNHiYBxfyBN1e9ODWcosn2e4KQvdTku0nbOz
         c0feJomkJS7XPJx5DPE2KZDO/wSZcrjYDPLLOYB+D5Q5unBAIqeaEL/yRStZ+N0Ozea4
         zg08u4xBx8XnKyt0r1iy+Q6V10XlAhGB0eV5jzGVkZp+C+Amm3AWQBf6bRndkSxJyzob
         URdQ==
X-Gm-Message-State: AOAM5334gq4ewhwX8YCTOqyQ+cAaoOILxeo5Hd47mFe8hgp6EUOmvcP1
        2vNh68duZbNgQU3pCq4z/M0=
X-Google-Smtp-Source: ABdhPJwYZsHve+cDy/trtVG6Ug9cEkP0hyWJehscUiGZ7dT+lalXVKBp/xyjBk/tJTpWgognV5O88Q==
X-Received: by 2002:a63:3247:: with SMTP id y68mr12668991pgy.10.1607704907988;
        Fri, 11 Dec 2020 08:41:47 -0800 (PST)
Received: from localhost.localdomain ([27.255.173.238])
        by smtp.googlemail.com with ESMTPSA id bg20sm10383183pjb.6.2020.12.11.08.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 08:41:47 -0800 (PST)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     bjorn@helgaas.com, linux-pci@vger.kernel.org,
        Damien.LeMoal@wdc.com, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH] drivers: block: skd: remove skd_pci_info()
Date:   Fri, 11 Dec 2020 22:11:37 +0530
Message-Id: <20201211164137.8605-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI core calls __pcie_print_link_status() for every device, it prints
both the link width and the link speed. skd_pci_info() does the same
thing again, hence it can be removed.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 drivers/block/skd_main.c | 31 -------------------------------
 1 file changed, 31 deletions(-)

diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
index a962b4551bed..da7aac5335d9 100644
--- a/drivers/block/skd_main.c
+++ b/drivers/block/skd_main.c
@@ -3134,40 +3134,11 @@ static const struct pci_device_id skd_pci_tbl[] = {
 
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
 
 static int skd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	int i;
 	int rc = 0;
-	char pci_str[32];
 	struct skd_device *skdev;
 
 	dev_dbg(&pdev->dev, "vendor=%04X device=%04x\n", pdev->vendor,
@@ -3201,8 +3172,6 @@ static int skd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_out_regions;
 	}
 
-	skd_pci_info(skdev, pci_str);
-	dev_info(&pdev->dev, "%s 64bit\n", pci_str);
 
 	pci_set_master(pdev);
 	rc = pci_enable_pcie_error_reporting(pdev);
-- 
2.27.0

