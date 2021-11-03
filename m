Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5639E444A1D
	for <lists+linux-pci@lfdr.de>; Wed,  3 Nov 2021 22:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbhKCVTd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Nov 2021 17:19:33 -0400
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:64526 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbhKCVTd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Nov 2021 17:19:33 -0400
Received: from pop-os.home ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id iNcsmLYXlBazoiNcsmwyh5; Wed, 03 Nov 2021 22:16:55 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Wed, 03 Nov 2021 22:16:55 +0100
X-ME-IP: 86.243.171.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] PCI/P2PDMA: Save a few cycles in 'pci_alloc_p2pmem()'
Date:   Wed,  3 Nov 2021 22:16:53 +0100
Message-Id: <ab80164f4d5b32f9e6240aa4863c3a147ff9c89f.1635974126.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use 'percpu_ref_tryget_live_rcu()' instead of 'percpu_ref_tryget_live()' to
save a few cycles when it is known that the rcu lock is already
taken/released.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/pci/p2pdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 8d47cb7218d1..081c391690d4 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -710,7 +710,7 @@ void *pci_alloc_p2pmem(struct pci_dev *pdev, size_t size)
 	if (!ret)
 		goto out;
 
-	if (unlikely(!percpu_ref_tryget_live(ref))) {
+	if (unlikely(!percpu_ref_tryget_live_rcu(ref))) {
 		gen_pool_free(p2pdma->pool, (unsigned long) ret, size);
 		ret = NULL;
 		goto out;
-- 
2.30.2

