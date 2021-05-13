Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7318B380010
	for <lists+linux-pci@lfdr.de>; Fri, 14 May 2021 00:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbhEMWda (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 May 2021 18:33:30 -0400
Received: from ale.deltatee.com ([204.191.154.188]:58980 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233552AbhEMWdZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 May 2021 18:33:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=RHKX0JViuXrszDPT9ENKjwACXQHnqdf/mlZV6OtxZMk=; b=suRMeNmUAK4D1LCjGjVPlBd7EG
        Uo0gPsu2BtUSYYWXhwNC5F5Rbe17tCB/jkhL6RSKRPfEbCcKxlvpJCsnMT7LhniM6WqF3OORunboL
        puYGUBidipQZtVozVDY/b2nIAZvAwBo+d84tQ8pWse1lWxTktrjC6V8bhEDjljeYLdHqQzEt4TBy+
        cFX7fRYRi7vBwhdMcl0EdpPDnIpiNqEeiAGsdc5nvVPnsPigJZ0QOQBGQeincxBOjawQNOY+I4GEU
        zfivxltZK8E3rcV7kTeK0e5HZSy5UY9q7EJ/41o7kQ7CmB0bc1LV1UJNaRK6FfxwWB3xmtELpqLqg
        sGCfBXyQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1lhJsL-0000nE-QQ; Thu, 13 May 2021 16:32:14 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1lhJsG-0001Sb-2K; Thu, 13 May 2021 16:32:08 -0600
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
Date:   Thu, 13 May 2021 16:31:44 -0600
Message-Id: <20210513223203.5542-4-logang@deltatee.com>
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
X-Spam-Status: No, score=-6.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        MYRULES_NO_TEXT autolearn=no autolearn_force=no version=3.4.2
Subject: [PATCH v2 03/22] PCI/P2PDMA: Cleanup type for return value of calc_map_type_and_dist()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Instead of using an int for the return value of this function use the
correct enum pci_p2pdma_map_type.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/p2pdma.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 3a5fb63c5f2c..09c864f193d2 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -544,11 +544,11 @@ calc_map_type_and_dist_warn(struct pci_dev *provider, struct pci_dev *client,
 int pci_p2pdma_distance_many(struct pci_dev *provider, struct device **clients,
 			     int num_clients, bool verbose)
 {
+	enum pci_p2pdma_map_type map;
 	bool not_supported = false;
 	struct pci_dev *pci_client;
 	int total_dist = 0;
-	int distance;
-	int i, ret;
+	int i, distance;
 
 	if (num_clients == 0)
 		return -1;
@@ -563,15 +563,15 @@ int pci_p2pdma_distance_many(struct pci_dev *provider, struct device **clients,
 		}
 
 		if (verbose)
-			ret = calc_map_type_and_dist_warn(provider, pci_client,
+			map = calc_map_type_and_dist_warn(provider, pci_client,
 							  &distance);
 		else
-			ret = calc_map_type_and_dist(provider, pci_client,
+			map = calc_map_type_and_dist(provider, pci_client,
 						     &distance, NULL, NULL);
 
 		pci_dev_put(pci_client);
 
-		if (ret == PCI_P2PDMA_MAP_NOT_SUPPORTED)
+		if (map == PCI_P2PDMA_MAP_NOT_SUPPORTED)
 			not_supported = true;
 
 		if (not_supported && !verbose)
-- 
2.20.1

