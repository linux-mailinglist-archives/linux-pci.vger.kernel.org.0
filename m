Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77B3938000C
	for <lists+linux-pci@lfdr.de>; Fri, 14 May 2021 00:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbhEMWd3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 May 2021 18:33:29 -0400
Received: from ale.deltatee.com ([204.191.154.188]:58984 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233549AbhEMWdZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 May 2021 18:33:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=kGb8w7OA+VecwjXRg6RAtUZUrHcBmrTzMPMqQqpjkm8=; b=eGbHnD9CNeacCKyZbuiHdS6KFZ
        NNh/EZ5WKODS1Ve6hb1tF/uAsrIqT4gYpJq4dxG0nF2fvIpAi7TpV7+/Y6LNZx1pFlY/hFAgny73W
        YtwZdP5IKdbhnFLh6KOTjJPOyogKxWXzq0K5Uu3ECThupT7cYwnsUUsGUYZBl9Fc4L7bqM9BzM7kp
        WC8F7PvsKKU2uOJ6Z2Fe47S/Ut/YmpU8uQ9Z/nZuPUE3EHFlWo3EHFOsmuSzH7OEgCTdiaglnj5LW
        nloEQgOv8SrxTyCv/NT8SVr0wrClZ2lqYuGBcRUJczrCPrgJ3bbnOLMmFmVp7MYt9Q7mA3ab0Nreo
        FRk7EUkg==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1lhJsL-0000nD-QQ; Thu, 13 May 2021 16:32:15 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1lhJsF-0001SX-Uh; Thu, 13 May 2021 16:32:07 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org
Cc:     Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jakowski Andrzej <andrzej.jakowski@intel.com>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu, 13 May 2021 16:31:43 -0600
Message-Id: <20210513223203.5542-3-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210513223203.5542-1-logang@deltatee.com>
References: <20210513223203.5542-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de, jgg@ziepe.ca, christian.koenig@amd.com, jhubbard@nvidia.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, jason@jlekstrand.net, dave.hansen@linux.intel.com, helgaas@kernel.org, dan.j.williams@intel.com, andrzej.jakowski@intel.com, dave.b.minturn@intel.com, jianxin.xiong@intel.com, ira.weiny@intel.com, robin.murphy@arm.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        MYRULES_FREE,MYRULES_NO_TEXT autolearn=no autolearn_force=no
        version=3.4.2
Subject: [PATCH v2 02/22] PCI/P2PDMA: Use a buffer on the stack for collecting the acs list
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In order to call the calc_map_type_and_dist_warn() function from
a dma_map operation, the function must not sleep. The only reason
it sleeps is to allocate memory for the seq_buf to print a verbose
warning telling the user how to disable ACS for that path.

Instead of allocating the memory with kmalloc, allocate it on
the stack with a smaller buffer. A 128B buffer is enough to print
10 pci device names. A system with 10 bridge ports between two devices
that have ACS enabled would be unusually large, so this should
still be a reasonable limit.

This also allows cleaning up the awkward (and broken) return with
-ENOMEM which contradicts the return type and the caller was
not prepared for.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/p2pdma.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 6f90e9812f6e..3a5fb63c5f2c 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -500,11 +500,10 @@ calc_map_type_and_dist_warn(struct pci_dev *provider, struct pci_dev *client,
 {
 	struct seq_buf acs_list;
 	bool acs_redirects;
+	char buf[128];
 	int ret;
 
-	seq_buf_init(&acs_list, kmalloc(PAGE_SIZE, GFP_KERNEL), PAGE_SIZE);
-	if (!acs_list.buffer)
-		return -ENOMEM;
+	seq_buf_init(&acs_list, buf, sizeof(buf));
 
 	ret = calc_map_type_and_dist(provider, client, dist, &acs_redirects,
 				     &acs_list);
@@ -522,8 +521,6 @@ calc_map_type_and_dist_warn(struct pci_dev *provider, struct pci_dev *client,
 			 pci_name(provider));
 	}
 
-	kfree(acs_list.buffer);
-
 	return ret;
 }
 
-- 
2.20.1

