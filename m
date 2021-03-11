Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 494233381D4
	for <lists+linux-pci@lfdr.de>; Fri, 12 Mar 2021 00:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbhCKXtD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Mar 2021 18:49:03 -0500
Received: from ale.deltatee.com ([204.191.154.188]:55760 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbhCKXsx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Mar 2021 18:48:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=p6LSuxLxIXhW56xVX60ERoOIubTQKg0kFsUTFXBJO+A=; b=KvuTM+MB3gjvIolcULjFn23dNB
        3UTcV/MdnfIXaNhLXS0a6rZH29zcNJFPH69erQKmEMF5Us9dBYKvKT+cwUnXcVVfkHmoSfRX8WPai
        K8M6TbmudsvF4nPi214vAODKBReiwl70HbEUINS//9CLpBrmWytPjko8FzX0jH0oKXnKz6JIpHCnG
        MDZ3uAQYYiD3i8bG4wDYOe1PrAaOL2kYOIuUOoONKVRQOznvCE2vkBlTujANvlJn5HAvzkEV7v7EY
        DAdA+NzNmhMoK6wFXyvdDV9raMZtrodSamhEKKTgZxJGwGLXqT+iYTFkagT3nR+ql1sjAqryz+oId
        4O7xEzbA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1lKUmZ-0003er-Rv; Thu, 11 Mar 2021 16:32:15 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1lKUmV-00024M-T0; Thu, 11 Mar 2021 16:31:51 -0700
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org
Cc:     Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Ira Weiny <iweiny@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jakowski Andrzej <andrzej.jakowski@intel.com>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu, 11 Mar 2021 16:31:31 -0700
Message-Id: <20210311233142.7900-2-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210311233142.7900-1-logang@deltatee.com>
References: <20210311233142.7900-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de, jgg@ziepe.ca, christian.koenig@amd.com, jhubbard@nvidia.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, jason@jlekstrand.net, dave.hansen@linux.intel.com, dan.j.williams@intel.com, iweiny@intel.com, andrzej.jakowski@intel.com, dave.b.minturn@intel.com, jianxin.xiong@intel.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        MYRULES_NO_TEXT autolearn=no autolearn_force=no version=3.4.2
Subject: [RFC PATCH v2 01/11] PCI/P2PDMA: Pass gfp_mask flags to upstream_bridge_distance_warn()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In order to call this function from a dma_map function, it must not sleep.
The only reason it does sleep so to allocate the seqbuf to print
which devices are within the ACS path.

Switch the kmalloc call to use a passed in gfp_mask  and don't print that
message if the buffer fails to be allocated.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/p2pdma.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 196382630363..bd89437faf06 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -267,7 +267,7 @@ static int pci_bridge_has_acs_redir(struct pci_dev *pdev)
 
 static void seq_buf_print_bus_devfn(struct seq_buf *buf, struct pci_dev *pdev)
 {
-	if (!buf)
+	if (!buf || !buf->buffer)
 		return;
 
 	seq_buf_printf(buf, "%s;", pci_name(pdev));
@@ -495,25 +495,26 @@ upstream_bridge_distance(struct pci_dev *provider, struct pci_dev *client,
 
 static enum pci_p2pdma_map_type
 upstream_bridge_distance_warn(struct pci_dev *provider, struct pci_dev *client,
-			      int *dist)
+			      int *dist, gfp_t gfp_mask)
 {
 	struct seq_buf acs_list;
 	bool acs_redirects;
 	int ret;
 
-	seq_buf_init(&acs_list, kmalloc(PAGE_SIZE, GFP_KERNEL), PAGE_SIZE);
-	if (!acs_list.buffer)
-		return -ENOMEM;
+	seq_buf_init(&acs_list, kmalloc(PAGE_SIZE, gfp_mask), PAGE_SIZE);
 
 	ret = upstream_bridge_distance(provider, client, dist, &acs_redirects,
 				       &acs_list);
 	if (acs_redirects) {
 		pci_warn(client, "ACS redirect is set between the client and provider (%s)\n",
 			 pci_name(provider));
-		/* Drop final semicolon */
-		acs_list.buffer[acs_list.len-1] = 0;
-		pci_warn(client, "to disable ACS redirect for this path, add the kernel parameter: pci=disable_acs_redir=%s\n",
-			 acs_list.buffer);
+
+		if (acs_list.buffer) {
+			/* Drop final semicolon */
+			acs_list.buffer[acs_list.len - 1] = 0;
+			pci_warn(client, "to disable ACS redirect for this path, add the kernel parameter: pci=disable_acs_redir=%s\n",
+				 acs_list.buffer);
+		}
 	}
 
 	if (ret == PCI_P2PDMA_MAP_NOT_SUPPORTED) {
@@ -566,7 +567,7 @@ int pci_p2pdma_distance_many(struct pci_dev *provider, struct device **clients,
 
 		if (verbose)
 			ret = upstream_bridge_distance_warn(provider,
-					pci_client, &distance);
+					pci_client, &distance, GFP_KERNEL);
 		else
 			ret = upstream_bridge_distance(provider, pci_client,
 						       &distance, NULL, NULL);
-- 
2.20.1

