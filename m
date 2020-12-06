Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBE5F2D06F7
	for <lists+linux-pci@lfdr.de>; Sun,  6 Dec 2020 20:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbgLFTnx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 6 Dec 2020 14:43:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgLFTnx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 6 Dec 2020 14:43:53 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CBF7C0613D1;
        Sun,  6 Dec 2020 11:43:13 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id lb18so3578395pjb.5;
        Sun, 06 Dec 2020 11:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=afZwwcHhODhEELbSogSIEDzs2XPcSL3i8voMpfmKBek=;
        b=tRbaPDXRnBV7LdMI2Sow36OGyhLx5mHSlWyqUd6qSQhWk2TTiISI+udo+cemnqQ9NY
         SjoWLjY1wYCnhcyqo3F6EQdiUHwqju0lG6qp09T61qi7njyaofz7IRyA4Cadm+cGnVKm
         wrX/kz3Mg/SfQx2rtp9eFP5dobHbckVjhaeaRY2lVbC9+23ONoqdSaiI6pfsPCKv32S4
         3jFk9dkD3d+qajtTglHgTzECREZDHM/8XLTUAYmwXFX+KT1S0Azd58/s8kfTp6U+SfBX
         1H/4C1hfY2UeC0pHxw/fbcs9tTRTZZHJfsGgUq03r7XGaAImZKSxpAy7wvN15IfasGYg
         xR1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=afZwwcHhODhEELbSogSIEDzs2XPcSL3i8voMpfmKBek=;
        b=IPCxMHK7keOuKMGarHhqhT2275pPDiycMSW0HeGnOygrBCHLG15eND/Ziuld1QKGr5
         DO1N/iFhsujSldQ9FqsqDY2UuYG0d+0A2S+vOn3HaOFVbak1XBoSCZ3ecc1KUvbGgqAA
         iYtP2y3te5yiF4ucqUs66iVk8zaMhbRCjUtH5KoMec2hhiT1KpxJ92qIElZkgGm7Y6tF
         iFi4n0Wt3BT423xYONNou5j6EhOIoCN8jNV929+76/mwF12HZStxINLmcWe0lfmh+0MF
         ydA8UXU5XutFZUMsYBQFW8H6hBf1GFX9mkk7FT5OzPaYRiX7VLkXDFKxHL5ikEEy5zDy
         AokA==
X-Gm-Message-State: AOAM531/czBL3PF+HgCDF8bBIMQLF8il6QsxDZl12xXfazM7ELDVB9G3
        DygM7iIDV8LEYzc3/YJh27g=
X-Google-Smtp-Source: ABdhPJzlRdP2+zLopwV9THTotrdB2IPM6ImH2yk+RsnD8LVd3bbzPjS4+lSmQuCxVu0d1Uz6UboU7w==
X-Received: by 2002:a17:90b:4a81:: with SMTP id lp1mr13705677pjb.55.1607283792720;
        Sun, 06 Dec 2020 11:43:12 -0800 (PST)
Received: from localhost.localdomain ([124.253.53.149])
        by smtp.googlemail.com with ESMTPSA id o2sm9765125pgi.60.2020.12.06.11.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Dec 2020 11:43:12 -0800 (PST)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     Damien.LeMoal@wdc.com, linux-block@vger.kernel.org,
        bjorn@helgaas.com, linux-pci@vger.kernel.org
Cc:     Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH] drivers: block: save return value of pci_find_capability() in u8
Date:   Mon,  7 Dec 2020 01:13:00 +0530
Message-Id: <20201206194300.14221-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Callers of pci_find_capability should save the return value in u8.
change type of variables from int to u8 to match the specification.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 drivers/block/mtip32xx/mtip32xx.c | 2 +-
 drivers/block/skd_main.c          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 153e2cdecb4d..da57d37c6d20 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -3936,7 +3936,7 @@ static DEFINE_HANDLER(7);
 
 static void mtip_disable_link_opts(struct driver_data *dd, struct pci_dev *pdev)
 {
-	int pos;
+	u8 pos;
 	unsigned short pcie_dev_ctrl;
 
 	pos = pci_find_capability(pdev, PCI_CAP_ID_EXP);
diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
index a962b4551bed..16d59569129b 100644
--- a/drivers/block/skd_main.c
+++ b/drivers/block/skd_main.c
@@ -3136,7 +3136,7 @@ MODULE_DEVICE_TABLE(pci, skd_pci_tbl);
 
 static char *skd_pci_info(struct skd_device *skdev, char *str)
 {
-	int pcie_reg;
+	u8 pcie_reg;
 
 	strcpy(str, "PCIe (");
 	pcie_reg = pci_find_capability(skdev->pdev, PCI_CAP_ID_EXP);
-- 
2.27.0

