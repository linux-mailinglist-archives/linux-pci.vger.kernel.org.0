Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5DC547B0BB
	for <lists+linux-pci@lfdr.de>; Mon, 20 Dec 2021 16:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237503AbhLTPzT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Dec 2021 10:55:19 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:45210 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237502AbhLTPzT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Dec 2021 10:55:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC602611DF
        for <linux-pci@vger.kernel.org>; Mon, 20 Dec 2021 15:55:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00140C36AE5;
        Mon, 20 Dec 2021 15:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640015718;
        bh=HF3h4z3qkbQ4eaFsuVo4AJ/cKjp2Rsn5kvqg2b92TQI=;
        h=From:To:Subject:Date:From;
        b=iSUqvoIdVRkkw7axdM7h3LLWw8e83sGu61beAmbNmTSQj681vIqwtg5F+/GH4a48y
         4U+Jlxzng4FNxNnBvIwkInrzPkGij2waCjnQWkp+FVHszOyVX/wVFb+dQWSd1Jq2Ll
         qN6fYs0zJ2Y4PXLCE2DHoGwfmkAF5AkBGDZcbAq0OWlHrblFxH9Sje8r/OvJsSH5/j
         vGpod5WdyUTTIxYY0qCjjIEhEbn/3+ugEhnNYJJA8XjhcXgo2KiZJb0eWhmIf0J9wT
         SnG6GMFprWyiiV4yxWmBKq9vwj8jH17HY4TwxhgJtF/T8aOjoI6H1DoBkUchmF9Nca
         0/JKVB94CCgBA==
Received: by pali.im (Postfix)
        id 0B69287B; Mon, 20 Dec 2021 16:55:15 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Martin Mares <mj@ucw.cz>, Bjorn Helgaas <helgaas@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Matthew Wilcox <willy@infradead.org>, linux-pci@vger.kernel.org
Subject: [PATCH pciutils 1/4] lspci: Show 16/32/64 bit width for address ranges behind bridge
Date:   Mon, 20 Dec 2021 16:54:45 +0100
Message-Id: <20211220155448.1233-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Type of address range is encoded in lower bits.
---
 lspci.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/lspci.c b/lspci.c
index aba2745a9192..17649a0540fa 100644
--- a/lspci.c
+++ b/lspci.c
@@ -374,12 +374,12 @@ show_size(u64 x)
 }
 
 static void
-show_range(char *prefix, u64 base, u64 limit, int is_64bit)
+show_range(char *prefix, u64 base, u64 limit, int bits)
 {
   printf("%s:", prefix);
   if (base <= limit || verbose > 2)
     {
-      if (is_64bit)
+      if (bits > 32)
         printf(" %016" PCI_U64_FMT_X "-%016" PCI_U64_FMT_X, base, limit);
       else
         printf(" %08x-%08x", (unsigned) base, (unsigned) limit);
@@ -388,6 +388,7 @@ show_range(char *prefix, u64 base, u64 limit, int is_64bit)
     show_size(limit - base + 1);
   else
     printf(" [disabled]");
+  printf(" [%d-bit]", bits);
   putchar('\n');
 }
 
@@ -578,7 +579,7 @@ show_htype1(struct device *d)
 	  io_base |= (get_conf_word(d, PCI_IO_BASE_UPPER16) << 16);
 	  io_limit |= (get_conf_word(d, PCI_IO_LIMIT_UPPER16) << 16);
 	}
-      show_range("\tI/O behind bridge", io_base, io_limit+0xfff, 0);
+      show_range("\tI/O behind bridge", io_base, io_limit+0xfff, (io_type == PCI_IO_RANGE_TYPE_32) ? 32 : 16);
     }
 
   if (mem_type != (mem_limit & PCI_MEMORY_RANGE_TYPE_MASK) ||
@@ -588,7 +589,7 @@ show_htype1(struct device *d)
     {
       mem_base = (mem_base & PCI_MEMORY_RANGE_MASK) << 16;
       mem_limit = (mem_limit & PCI_MEMORY_RANGE_MASK) << 16;
-      show_range("\tMemory behind bridge", mem_base, mem_limit + 0xfffff, 0);
+      show_range("\tMemory behind bridge", mem_base, mem_limit + 0xfffff, 32);
     }
 
   if (pref_type != (pref_limit & PCI_PREF_RANGE_TYPE_MASK) ||
@@ -603,7 +604,7 @@ show_htype1(struct device *d)
 	  pref_base_64 |= (u64) get_conf_long(d, PCI_PREF_BASE_UPPER32) << 32;
 	  pref_limit_64 |= (u64) get_conf_long(d, PCI_PREF_LIMIT_UPPER32) << 32;
 	}
-      show_range("\tPrefetchable memory behind bridge", pref_base_64, pref_limit_64 + 0xfffff, (pref_type == PCI_PREF_RANGE_TYPE_64));
+      show_range("\tPrefetchable memory behind bridge", pref_base_64, pref_limit_64 + 0xfffff, (pref_type == PCI_PREF_RANGE_TYPE_64) ? 64 : 32);
     }
 
   if (verbose > 1)
-- 
2.20.1

