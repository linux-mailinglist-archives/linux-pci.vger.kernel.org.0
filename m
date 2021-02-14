Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C02831B02B
	for <lists+linux-pci@lfdr.de>; Sun, 14 Feb 2021 12:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhBNLH1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 14 Feb 2021 06:07:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhBNLH0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 14 Feb 2021 06:07:26 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8288FC061574
        for <linux-pci@vger.kernel.org>; Sun, 14 Feb 2021 03:06:46 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id b145so2468795pfb.4
        for <linux-pci@vger.kernel.org>; Sun, 14 Feb 2021 03:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TNphVy+2s+ASMBG2f7Fme+hNiy4bqLHhpRWCdIIxmtM=;
        b=IGzFmmYziZk0dcCHfKV4KTw+oQ2GC+s71u+mXrJFwowG1/n7DFrfTNLKFBz6Qwysxz
         mqlXqqWw1WTan28Pa+iRfNai0vtDm3ZIqrPXL6Y9zHlANaB8Oq/CveNtoN13y13bSRYR
         47Wc4G2pZeCjMxeCCi79DrOHLt30Sb+NnNP7HIZauhxB8dMaId+ZuFIK0Hg1rzxFiGWM
         MUmJaNKMMRkrtQN7mS2ZtvXnyKDpTIWKQ7UdSpVnj2Yno4cuFeSSHQ0wMEDrTQ5jXEJt
         LYXJJkQFD8hTTPWz9bIwt5QMfBmYlrZqBnC6a/wBoTizgIBPz47LaMuBSaIfzv2/gWBp
         YVpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TNphVy+2s+ASMBG2f7Fme+hNiy4bqLHhpRWCdIIxmtM=;
        b=XBc0YnyOe60ZIuIVmPyJfboIQzvx+wS+diiqY8EWOS4zImvYCc41lyhs0xg/KuKS66
         zoLEWVss9+kUQazZ1GjggNESDFq5cCtCWXkG7YXkgbWuZm+ndDt5fj9eJGVuDfqRN27d
         4FhZcR8waX5eZltuFdyaLnJjUXZP9OS3y2eelR27ZejH0vNximI4Ex1Zz4R9qTNnU31Q
         mRyCiHPLDHbph/gzQDJvIk3reC530JLm5YBC486P1vO0XkwHgfeuIYHq5O6+8JHCKWiW
         bpBOMFF7dKCQZLqKOLx0AjtGWm7w7fZHPg+936QbzkwAU4v+lr+4D30UPy4qBbEmmwoi
         pgIw==
X-Gm-Message-State: AOAM533V2tFSGHVaN2GBOUQ+aPuC2xMUqSxZCSgOJdW0t57yWAcD8I5N
        QRoUUEPRLZA+9EwCYLS5HqwQJYbm4QkUgw==
X-Google-Smtp-Source: ABdhPJwGgpGst6PZDRDmLR3Nq6bjQxgAhWr4eUfLQjrBmOSKuRgESJyN5pRykj/1bilyVMvYIfWWAg==
X-Received: by 2002:a63:dd42:: with SMTP id g2mr11075617pgj.285.1613300805824;
        Sun, 14 Feb 2021 03:06:45 -0800 (PST)
Received: from localhost.localdomain ([211.108.35.36])
        by smtp.gmail.com with ESMTPSA id w188sm13027624pfw.177.2021.02.14.03.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Feb 2021 03:06:45 -0800 (PST)
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: [PATCH] PCI: Take __pci_set_master in do_pci_disable_device
Date:   Sun, 14 Feb 2021 20:06:37 +0900
Message-Id: <20210214110637.24750-1-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

__pci_set_mater() has debug log in there so that it would be better to
take this function.  So take __pci_set_master() function rather than
open coding it.  This patch didn't move __pci_set_master() to above to
avoid churns.

Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
---
 drivers/pci/pci.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b9fecc25d213..b2778f475ce3 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2101,15 +2101,10 @@ void __weak pcibios_disable_device(struct pci_dev *dev) {}
  */
 void __weak pcibios_penalize_isa_irq(int irq, int active) {}
 
+static void __pci_set_master(struct pci_dev *dev, bool enable);
 static void do_pci_disable_device(struct pci_dev *dev)
 {
-	u16 pci_command;
-
-	pci_read_config_word(dev, PCI_COMMAND, &pci_command);
-	if (pci_command & PCI_COMMAND_MASTER) {
-		pci_command &= ~PCI_COMMAND_MASTER;
-		pci_write_config_word(dev, PCI_COMMAND, pci_command);
-	}
+	__pci_set_master(dev, false);
 
 	pcibios_disable_device(dev);
 }
-- 
2.17.1

