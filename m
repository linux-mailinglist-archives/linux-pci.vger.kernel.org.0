Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C148B690F44
	for <lists+linux-pci@lfdr.de>; Thu,  9 Feb 2023 18:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjBIRaS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Feb 2023 12:30:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjBIRaP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Feb 2023 12:30:15 -0500
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01BE5A9C9;
        Thu,  9 Feb 2023 09:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:Message-Id:Date:Cc:To:From
        :references:content-disposition:in-reply-to;
        bh=Az7+QZv/Q6BfDETdStFd1P0DYpVrNoMvXgOsAN0HHxo=; b=ao2WlnmCr3gplQ1r7gmiDKWNFt
        j7LNeSPZAPDk8QXDlv8GtVm8iVl3adX1RqL9RHR48XoTJtQ9ojvf6qsYBXlTWxswPay7KgZWd5Dhu
        Q7yGfnO42ZQzjxic3Ev1hRRhESRmUUZwP/WvHPT2NFXVSIkkLL4RhuPCpVsmmf6VYObf/LUwlLWGX
        a7deA+PxTb/jYhI+deDsFPj3hqgIxfVGXAfoxo0b2xAnEVsTRP6SC++Jajy85XmvbxA7jdQ7awOUu
        FHXiQeDBHhtMGhNPc43TCBJ8tnpIKYcgukxz6jre5eK7Dbou5ffSQO229oPbYOk3pCYG16LZc0FE9
        4trRTPzw==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1pQAk9-007xrg-5N; Thu, 09 Feb 2023 10:29:57 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1pQAk7-0001Cw-Fn; Thu, 09 Feb 2023 10:29:55 -0700
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        kernel test robot <lkp@intel.com>
Date:   Thu,  9 Feb 2023 10:29:53 -0700
Message-Id: <20230209172953.4597-1-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, bhelgaas@google.com, chaitanyak@nvidia.com, logang@deltatee.com, lkp@intel.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH] PCI/P2PDMA: Annotate RCU dereference
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

A dereference of the __rcu pointer was noticed by sparse:

  drivers/pci/p2pdma.c:199:44: sparse: sparse: dereference of noderef expression

The __rcu pointer should be dereferenced using
rcu_dereference_protected() instead of accessed directly. Its safe
to use rcu_derference_protected() seeing a reference is held on
the pgmap's percpu reference counter and thus it cannot disappear.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---

Based on v6.2-rc7

 drivers/pci/p2pdma.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 86812d2073ea..9e8205572830 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -194,11 +194,13 @@ static const struct attribute_group p2pmem_group = {
 static void p2pdma_page_free(struct page *page)
 {
 	struct pci_p2pdma_pagemap *pgmap = to_p2p_pgmap(page->pgmap);
+	/* safe to dereference while a reference is held to the percpu ref */
+	struct pci_p2pdma *p2pdma =
+		rcu_dereference_protected(pgmap->provider->p2pdma, 1);
 	struct percpu_ref *ref;

-	gen_pool_free_owner(pgmap->provider->p2pdma->pool,
-			    (uintptr_t)page_to_virt(page), PAGE_SIZE,
-			    (void **)&ref);
+	gen_pool_free_owner(p2pdma->pool, (uintptr_t)page_to_virt(page),
+			    PAGE_SIZE, (void **)&ref);
 	percpu_ref_put(ref);
 }


base-commit: 4ec5183ec48656cec489c49f989c508b68b518e3
--
2.30.2
