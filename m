Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB49E5EA4
	for <lists+linux-pci@lfdr.de>; Sat, 26 Oct 2019 20:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfJZS1K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 26 Oct 2019 14:27:10 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53900 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbfJZS1K (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 26 Oct 2019 14:27:10 -0400
Received: by mail-wm1-f66.google.com with SMTP id n7so5393683wmc.3;
        Sat, 26 Oct 2019 11:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1BLn9xY3zopegpqlJ+Le7S9nDpFtrNOK6VhjDwTH/aE=;
        b=Wm+PfrpBmZHuEOGN4h9SnC1jqvpzNhwdNXMD76LZqQo+5SxU9b6C5ubw1cgndAiIz4
         nNZNz8epigXyN9PT8XL/wZp7/h1ihVH+PNZbLPQI2f//oHRAREUndPOxGr2fyoTc1qYx
         1TGIyHxpJwLX9TdNFiATiLqwaIv9f0z5te9VEZOfwr/Wk17FkqI64YqnmP2qy+oReB0Y
         6Ib0xwbVJu5/YxarZjOEXzWjaXXua8zF6aJwUes04jOt+V1DivWuZZuQxUuW5fk7QXOr
         TLx0lGHNmb5x3ZXaJ9tYUM2RPzr7J/6+BNOsHWRupALQFEaJO5LGiFStMdZ6suZemZ+V
         WC7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1BLn9xY3zopegpqlJ+Le7S9nDpFtrNOK6VhjDwTH/aE=;
        b=X3bbmm8aMdDSvZuiNN+sQtgTEAjVs156COJWAVXt9N9pK6vrk+wQqUZa/JW5ouMkJT
         ORQvKOaVsxFe3/2iaKk0nxgqyp1wpjeK7gUtPMrACQpp+yCWPdAWoo/kyFd9GxYac1R3
         doR0s5lc4xItd5+eayTvAMmK5lR4+SCkE6Zpe+UACtsQW40sx+QQa17YtHVBNr+Ye5Ig
         o6jlGp5C+bAMGFGQ0Ajmj82D5XX9ntQLZjo0H8gprSLtVzx0LKYXWxNRezLRMLHgk6Lw
         iF3X6jX29G36wSoUaIbhDmtsIDUI3NgWWzpeG+y19aVo7+4xl17AUbKZAnfTqrwnHjnR
         tX8A==
X-Gm-Message-State: APjAAAWfzf70umFo0wwYgDdP7G4WTSRqPRr4wCBLYiv8vetWf0ad66dS
        cq2B4FSfqPnvnA8e3CoLReXKMHRS
X-Google-Smtp-Source: APXvYqy4etM7aStWOGraD3uOSYtn+taq/XKf0WbBOkGs0UuF3+8zLWhh836QYafuTTJK1EkDZQEV8g==
X-Received: by 2002:a1c:c90c:: with SMTP id f12mr8359480wmb.97.1572114426443;
        Sat, 26 Oct 2019 11:27:06 -0700 (PDT)
Received: from desktop.lan (ip-86-49-35-8.net.upcbroadband.cz. [86.49.35.8])
        by smtp.gmail.com with ESMTPSA id p17sm7637982wrn.4.2019.10.26.11.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2019 11:27:05 -0700 (PDT)
From:   marek.vasut@gmail.com
To:     linux-pci@vger.kernel.org
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH V4 1/2] PCI: rcar: Move the inbound index check
Date:   Sat, 26 Oct 2019 20:26:58 +0200
Message-Id: <20191026182659.2390-1-marek.vasut@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Marek Vasut <marek.vasut+renesas@gmail.com>

Since the $idx variable value is stored across multiple calls to
rcar_pcie_inbound_ranges() function, and the $idx value is used to
index registers which are written, subsequent calls might cause
the $idx value to be high enough to trigger writes into nonexistent
registers.

Fix this by moving the $idx value check to the beginning of the loop.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Reviewed-by: Andrew Murray <andrew.murray@arm.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-renesas-soc@vger.kernel.org
To: linux-pci@vger.kernel.org
---
V2: New patch
V3: Adjust the check to idx >= MAX_NR_INBOUND_MAPS - 1
V4: Rebase on next/master
---
 drivers/pci/controller/pcie-rcar.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
index e45bb2a7bfa5..b2a5c3e94245 100644
--- a/drivers/pci/controller/pcie-rcar.c
+++ b/drivers/pci/controller/pcie-rcar.c
@@ -1049,6 +1049,10 @@ static int rcar_pcie_inbound_ranges(struct rcar_pcie *pcie,
 	mask &= ~0xf;
 
 	while (cpu_addr < cpu_end) {
+		if (idx >= MAX_NR_INBOUND_MAPS - 1) {
+			dev_err(pcie->dev, "Failed to map inbound regions!\n");
+			return -EINVAL;
+		}
 		/*
 		 * Set up 64-bit inbound regions as the range parser doesn't
 		 * distinguish between 32 and 64-bit types.
@@ -1068,11 +1072,6 @@ static int rcar_pcie_inbound_ranges(struct rcar_pcie *pcie,
 		pci_addr += size;
 		cpu_addr += size;
 		idx += 2;
-
-		if (idx > MAX_NR_INBOUND_MAPS) {
-			dev_err(pcie->dev, "Failed to map inbound regions!\n");
-			return -EINVAL;
-		}
 	}
 	*index = idx;
 
-- 
2.23.0

