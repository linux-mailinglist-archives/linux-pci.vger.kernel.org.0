Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF49881C9
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2019 19:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436928AbfHIR6M (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Aug 2019 13:58:12 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34985 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfHIR6L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Aug 2019 13:58:11 -0400
Received: by mail-wr1-f67.google.com with SMTP id k2so13161379wrq.2;
        Fri, 09 Aug 2019 10:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tUZWuc1WhcjzBsiR4EKC4YEhfzXYVanXFSYVyIayfbs=;
        b=e8UitYY0PXOWAO8UGePPUxI2EvvYBfJ2yGdXi3D5+3htjZKD/ou0ZhTJR0259vo7+M
         HSBqKcbRRV0brb8Zssl7yiABHpfnW3LGFl67QSMcC4YCTpez7BO5fYh4R4dw9UGHtjjA
         9y9ZaR7zov1TMZwKf8Bbj5SPERFN8gLdFSInO7gudsCCWpzfqDsiMH7rXbk9dyz1e7UN
         K/h7/0BdUlMjHpDy6HG3B/9FS3ZywXP2euM06OsvshGto3mxF2PgGUJnslXQkYcyn+4l
         HffwqATnuKqkJbpQtSmRL+QxGD9tnwzjgx7Pola6JgaKqxQjGW5WKtozKKaqO47DKL8I
         AmQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tUZWuc1WhcjzBsiR4EKC4YEhfzXYVanXFSYVyIayfbs=;
        b=lKtnEsyavsqD1UTLTNDOkhvnHnx1LHxxB5Ytz4wlXRsY6LNpMvivpGr7rUm+cjhFzX
         Y/vW6UIMJ9MPyTTc6wbjnqSCbS2+4EBfnu4p2CqM47vC4UdRNDMlJAMMsmQ6XQSqhqwi
         pE6c6TT9r2J0eQhG8lGnIM5wVxoDXbl05v/st+INA0ru2QRCKR/K8CeCfgcGJOFx9YA8
         /at+qNMsEY4Q0IrjZsPh/7jTgxgbiChLhIXSJlu6tFy80G0KM3gCJYyfoEU0oQweYXYi
         fpPuL9GtQ5NT3Fl0q4XCXMKog1Z/Cl+/oMUie9q4yiskHTFJIsZzMWbRiEQP4+LFjxYm
         odoQ==
X-Gm-Message-State: APjAAAWi0hD9xrMs6txvQCPfw7pD+xETpUotLH1kw7ewsAdcz5dAPw0t
        bmzmsWjYXkLs8MrHnhi2bzUs7SBL
X-Google-Smtp-Source: APXvYqzm/ed/27C6KnmquFScFATPGI9e5ZZfh1xd6v4c05S4CeSP+9fAJzNNbQo6CGC1t69Swj56ww==
X-Received: by 2002:adf:eac5:: with SMTP id o5mr12778849wrn.140.1565373489148;
        Fri, 09 Aug 2019 10:58:09 -0700 (PDT)
Received: from chi.lan (ip-86-49-35-8.net.upcbroadband.cz. [86.49.35.8])
        by smtp.gmail.com with ESMTPSA id z6sm4078920wre.76.2019.08.09.10.58.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 09 Aug 2019 10:58:08 -0700 (PDT)
From:   marek.vasut@gmail.com
To:     linux-pci@vger.kernel.org
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH V3 1/3] PCI: rcar: Move the inbound index check
Date:   Fri,  9 Aug 2019 19:57:39 +0200
Message-Id: <20190809175741.7066-1-marek.vasut@gmail.com>
X-Mailer: git-send-email 2.20.1
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
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-renesas-soc@vger.kernel.org
To: linux-pci@vger.kernel.org
---
V2: New patch
V3: Adjust the check to idx >= MAX_NR_INBOUND_MAPS - 1
---
 drivers/pci/controller/pcie-rcar.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
index f6a669a9af41..56a6433eb70b 100644
--- a/drivers/pci/controller/pcie-rcar.c
+++ b/drivers/pci/controller/pcie-rcar.c
@@ -1048,6 +1048,10 @@ static int rcar_pcie_inbound_ranges(struct rcar_pcie *pcie,
 	mask &= ~0xf;
 
 	while (cpu_addr < cpu_end) {
+		if (idx >= MAX_NR_INBOUND_MAPS - 1) {
+			dev_err(pcie->dev, "Failed to map inbound regions!\n");
+			return -EINVAL;
+		}
 		/*
 		 * Set up 64-bit inbound regions as the range parser doesn't
 		 * distinguish between 32 and 64-bit types.
@@ -1067,11 +1071,6 @@ static int rcar_pcie_inbound_ranges(struct rcar_pcie *pcie,
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
2.20.1

