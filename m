Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2B2B27144D
	for <lists+linux-pci@lfdr.de>; Sun, 20 Sep 2020 14:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgITMQk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 20 Sep 2020 08:16:40 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:34010 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726436AbgITMQi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 20 Sep 2020 08:16:38 -0400
X-IronPort-AV: E=Sophos;i="5.77,282,1596492000"; 
   d="scan'208";a="468612200"
Received: from palace.lip6.fr ([132.227.105.202])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES256-SHA256; 20 Sep 2020 14:08:58 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     kernel-janitors@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 14/14] PCI/P2PDMA: drop double zeroing
Date:   Sun, 20 Sep 2020 13:26:26 +0200
Message-Id: <1600601186-7420-15-git-send-email-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1600601186-7420-1-git-send-email-Julia.Lawall@inria.fr>
References: <1600601186-7420-1-git-send-email-Julia.Lawall@inria.fr>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

sg_init_table zeroes its first argument, so the allocation of that argument
doesn't have to.

the semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
expression x;
@@

x =
- kzalloc
+ kmalloc
 (...)
...
sg_init_table(x,...)
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/pci/p2pdma.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -u -p a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -762,7 +762,7 @@ struct scatterlist *pci_p2pmem_alloc_sgl
 	struct scatterlist *sg;
 	void *addr;
 
-	sg = kzalloc(sizeof(*sg), GFP_KERNEL);
+	sg = kmalloc(sizeof(*sg), GFP_KERNEL);
 	if (!sg)
 		return NULL;
 

