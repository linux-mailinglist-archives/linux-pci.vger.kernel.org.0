Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73781455D57
	for <lists+linux-pci@lfdr.de>; Thu, 18 Nov 2021 15:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbhKROIT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Nov 2021 09:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbhKROIH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Nov 2021 09:08:07 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23C7C061200;
        Thu, 18 Nov 2021 06:05:07 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id r5so5412285pgi.6;
        Thu, 18 Nov 2021 06:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zxXrUZht15oO1Xjz6QWdqaAcujYVEC+9jBLeu7+7g0c=;
        b=HbXpWZrZFoaUh8ToyYcOr4IeJCt9Wtb/Ii4qTWagMTuHX7bBJ408OnaIHcxI6Aydah
         JcN5EhV7L+2xpGF7TR51D0VZb585s/LREfwS14xSPHw2V/jvXmopFLGnbqor/FNbm8DY
         Jf/IDZK+dS22PSV9/J4C5iuyEPNNVEkZVb8S+eueWHOek3vTdeiBGsN+6NhdGO4ZcoLF
         GJtCPA5N2xZQ165JR+wTN72S8dX21PRK+X6tlSksm0DWdb3ajFZkrNYdbqpc5kgjKvhT
         XPqraYIqNUphptmr1sD7LurQPDjPHlIaXrUBAvmJcZ30mG1iQFLMn54+fGN4mG8m5IkB
         Tj8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zxXrUZht15oO1Xjz6QWdqaAcujYVEC+9jBLeu7+7g0c=;
        b=0lbyUm02hy9hOb8mR4Z7YZ+D/4siFPaF+h0KVSxnQ2ibbZZ+SQgj7F110agsmvwgIc
         oglBGkqyaa7ns83h6xiCQ4xdX8OokpfSBq/5oPGAq96ZhEFSG2FCqnwS/y1+Z4vSmf9C
         +4o8cNZ+21WxzBIrYTc7BBz87qayy/5OQ2+rJH0XPMNU3/+OL6wkgql7PLg2YsjgTBgN
         irea1WypTgEzdCsG49bnsmNz9068dBkEOzkt1jK7tqTKSCTJdBkVfR9+cHt6d7yrhkSc
         zX0GRGP+5PFF5uTcQ+pTgjpx+GNgaxCC3abPzpGfENsV6tm/CdcXphfysILNyvqAdp3C
         Layw==
X-Gm-Message-State: AOAM531VM+HYOUyWUKP35b6onOJ1SEL10Vh/39fBuY2sbUUQpEzpHEwx
        1Nl63GUf3z/dbskSOkX8+CI=
X-Google-Smtp-Source: ABdhPJwOXyE6HEQbNhPVgekg9gPYV7L5WppEDsCgRjqxmDA8X9Db0i/xJwXn6bbQv5oaIkUB7CnPhw==
X-Received: by 2002:a63:2c53:: with SMTP id s80mr11543263pgs.6.1637244307202;
        Thu, 18 Nov 2021 06:05:07 -0800 (PST)
Received: from localhost.localdomain ([2406:7400:63:2c47:5ffe:fc34:61f0:f1ea])
        by smtp.gmail.com with ESMTPSA id x14sm2822878pjl.27.2021.11.18.06.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 06:05:06 -0800 (PST)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v4 04/25] PCI: Remove redundant error fabrication when device read fails
Date:   Thu, 18 Nov 2021 19:33:14 +0530
Message-Id: <1b2edb060cf19b45f70645b331e6c08c9ba798c0.1637243717.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1637243717.git.naveennaidu479@gmail.com>
References: <cover.1637243717.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

An MMIO read from a PCI device that doesn't exist or doesn't respond
causes a PCI error. There's no real data to return to satisfy the
CPU read, so most hardware fabricates ~0 data.

The host controller drivers sets the error response values (~0) and
returns an error when faulty hardware read occurs. But the error
response value (~0) is already being set in PCI_OP_READ and
PCI_USER_READ_CONFIG whenever a read by host controller driver fails.

Thus, it's no longer necessary for the host controller drivers to
fabricate any error response.

This helps unify PCI error response checking and make error check
consistent and easier to find.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/access.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index e1add90494ec..a92637627845 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -83,10 +83,8 @@ int pci_generic_config_read(struct pci_bus *bus, unsigned int devfn,
 	void __iomem *addr;
 
 	addr = bus->ops->map_bus(bus, devfn, where);
-	if (!addr) {
-		*val = ~0;
+	if (!addr)
 		return PCIBIOS_DEVICE_NOT_FOUND;
-	}
 
 	if (size == 1)
 		*val = readb(addr);
@@ -125,10 +123,8 @@ int pci_generic_config_read32(struct pci_bus *bus, unsigned int devfn,
 	void __iomem *addr;
 
 	addr = bus->ops->map_bus(bus, devfn, where & ~0x3);
-	if (!addr) {
-		*val = ~0;
+	if (!addr)
 		return PCIBIOS_DEVICE_NOT_FOUND;
-	}
 
 	*val = readl(addr);
 
-- 
2.25.1

