Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17066438729
	for <lists+linux-pci@lfdr.de>; Sun, 24 Oct 2021 08:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbhJXGyB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 24 Oct 2021 02:54:01 -0400
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:57489 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbhJXGyB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 24 Oct 2021 02:54:01 -0400
Received: from pop-os.home ([92.140.161.106])
        by smtp.orange.fr with ESMTPA
        id eXM2m8BUn65jHeXM2m5OFT; Sun, 24 Oct 2021 08:51:39 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 24 Oct 2021 08:51:39 +0200
X-ME-IP: 92.140.161.106
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     kishon@ti.com, lorenzo.pieralisi@arm.com, kw@linux.com,
        bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] PCI: endpoint: Use 'bitmap_zalloc()' when applicable
Date:   Sun, 24 Oct 2021 08:51:36 +0200
Message-Id: <01eba3c86137eb348f8cce69f500222bd7c72c57.1635058203.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

'mem->bitmap' is a bitmap. So use 'bitmap_zalloc()' to simplify code,
improve the semantic and avoid some open-coded arithmetic in allocator
arguments.

Also change the corresponding 'kfree()' into 'bitmap_free()' to keep
consistency.

Finally, while at it, axe the useless 'bitmap' variable and use
'mem->bitmap' directly.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/pci/endpoint/pci-epc-mem.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epc-mem.c b/drivers/pci/endpoint/pci-epc-mem.c
index a97b56a6d2db..b15a264f19af 100644
--- a/drivers/pci/endpoint/pci-epc-mem.c
+++ b/drivers/pci/endpoint/pci-epc-mem.c
@@ -49,10 +49,8 @@ int pci_epc_multi_mem_init(struct pci_epc *epc,
 			   unsigned int num_windows)
 {
 	struct pci_epc_mem *mem = NULL;
-	unsigned long *bitmap = NULL;
 	unsigned int page_shift;
 	size_t page_size;
-	int bitmap_size;
 	int pages;
 	int ret;
 	int i;
@@ -72,7 +70,6 @@ int pci_epc_multi_mem_init(struct pci_epc *epc,
 			page_size = PAGE_SIZE;
 		page_shift = ilog2(page_size);
 		pages = windows[i].size >> page_shift;
-		bitmap_size = BITS_TO_LONGS(pages) * sizeof(long);
 
 		mem = kzalloc(sizeof(*mem), GFP_KERNEL);
 		if (!mem) {
@@ -81,8 +78,8 @@ int pci_epc_multi_mem_init(struct pci_epc *epc,
 			goto err_mem;
 		}
 
-		bitmap = kzalloc(bitmap_size, GFP_KERNEL);
-		if (!bitmap) {
+		mem->bitmap = bitmap_zalloc(pages, GFP_KERNEL);
+		if (!mem->bitmap) {
 			ret = -ENOMEM;
 			kfree(mem);
 			i--;
@@ -92,7 +89,6 @@ int pci_epc_multi_mem_init(struct pci_epc *epc,
 		mem->window.phys_base = windows[i].phys_base;
 		mem->window.size = windows[i].size;
 		mem->window.page_size = page_size;
-		mem->bitmap = bitmap;
 		mem->pages = pages;
 		mutex_init(&mem->lock);
 		epc->windows[i] = mem;
@@ -106,7 +102,7 @@ int pci_epc_multi_mem_init(struct pci_epc *epc,
 err_mem:
 	for (; i >= 0; i--) {
 		mem = epc->windows[i];
-		kfree(mem->bitmap);
+		bitmap_free(mem->bitmap);
 		kfree(mem);
 	}
 	kfree(epc->windows);
@@ -145,7 +141,7 @@ void pci_epc_mem_exit(struct pci_epc *epc)
 
 	for (i = 0; i < epc->num_windows; i++) {
 		mem = epc->windows[i];
-		kfree(mem->bitmap);
+		bitmap_free(mem->bitmap);
 		kfree(mem);
 	}
 	kfree(epc->windows);
-- 
2.30.2

