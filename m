Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF5E496031
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jan 2022 14:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380779AbiAUN6S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jan 2022 08:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380770AbiAUN6S (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jan 2022 08:58:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFDBC061574
        for <linux-pci@vger.kernel.org>; Fri, 21 Jan 2022 05:58:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9A6DDB81FC5
        for <linux-pci@vger.kernel.org>; Fri, 21 Jan 2022 13:58:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31278C340E3;
        Fri, 21 Jan 2022 13:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642773495;
        bh=BzA91MyN+EGBFQfWvrsnhbePTPNuL0lesT/LXWw9F1A=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=B3qCtUORrhv95udgbKRY8xvy9ffMEEmcYQ7PAK6VwpjuASc6EeBRUc045+wBCJBs8
         PmXqiW76caI5JYkH78//ihmyfiZVdrMh1itZKBnD3QLz8t+lFvfhnoRkv+pYkhhIBR
         7cxKyJTiZmEYSV61pGRPBi0Z485wgIPSDfCqpqnRovClui/A2ZUzqAixK4cLaVQUsO
         zuibFlr1bd6vM9ugdbHfqz2gbfXgtd5xugaB89PV9b9PlCHwaYxRzixVUDpRqqITLt
         e0HQ9M3Mm3Tre/83bOvo5DiztipnLmkSz4m++mnybY9T4m01AKrXcLzHcvg9YlG17v
         ViQAUYRlddb9g==
Received: by pali.im (Postfix)
        id C9CADC83; Fri, 21 Jan 2022 14:58:12 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Martin Mares <mj@ucw.cz>, Bjorn Helgaas <helgaas@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Matthew Wilcox <willy@infradead.org>, linux-pci@vger.kernel.org
Subject: [PATCH pciutils 2/5] libpci: generic: Implement PROGIF, REVID and SUBSYS support
Date:   Fri, 21 Jan 2022 14:57:15 +0100
Message-Id: <20220121135718.27172-3-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220121135718.27172-1-pali@kernel.org>
References: <20220121135718.27172-1-pali@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI_FILL_SUBSYS is implemented only for PCI_HEADER_TYPE_NORMAL and
PCI_HEADER_TYPE_CARDBUS like in lspci.
---
 lib/generic.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/lib/generic.c b/lib/generic.c
index ef9e2a34b4f4..f4b6918cb55b 100644
--- a/lib/generic.c
+++ b/lib/generic.c
@@ -80,7 +80,7 @@ pci_generic_fill_info(struct pci_dev *d, unsigned int flags)
   struct pci_access *a = d->access;
   unsigned int done = 0;
 
-  if ((flags & (PCI_FILL_BASES | PCI_FILL_ROM_BASE)) && d->hdrtype < 0)
+  if ((flags & (PCI_FILL_SUBSYS | PCI_FILL_BASES | PCI_FILL_ROM_BASE)) && d->hdrtype < 0)
     d->hdrtype = pci_read_byte(d, PCI_HEADER_TYPE) & 0x7f;
 
   if (flags & PCI_FILL_IDENT)
@@ -96,6 +96,35 @@ pci_generic_fill_info(struct pci_dev *d, unsigned int flags)
       done |= PCI_FILL_CLASS;
     }
 
+  if (flags & PCI_FILL_PROGIF)
+    {
+      d->prog_if = pci_read_byte(d, PCI_CLASS_PROG);
+      done |= PCI_FILL_PROGIF;
+    }
+
+  if (flags & PCI_FILL_REVID)
+    {
+      d->rev_id = pci_read_byte(d, PCI_REVISION_ID);
+      done |= PCI_FILL_REVID;
+    }
+
+  if (flags & PCI_FILL_SUBSYS)
+    {
+      switch (d->hdrtype)
+        {
+        case PCI_HEADER_TYPE_NORMAL:
+          d->subsys_vendor_id = pci_read_word(d, PCI_SUBSYSTEM_VENDOR_ID);
+          d->subsys_id = pci_read_word(d, PCI_SUBSYSTEM_ID);
+          done |= PCI_FILL_SUBSYS;
+          break;
+        case PCI_HEADER_TYPE_CARDBUS:
+          d->subsys_vendor_id = pci_read_word(d, PCI_CB_SUBSYSTEM_VENDOR_ID);
+          d->subsys_id = pci_read_word(d, PCI_CB_SUBSYSTEM_ID);
+          done |= PCI_FILL_SUBSYS;
+          break;
+        }
+    }
+
   if (flags & PCI_FILL_IRQ)
     {
       d->irq = pci_read_byte(d, PCI_INTERRUPT_LINE);
-- 
2.20.1

