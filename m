Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F4554CDF0
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jun 2022 18:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348837AbiFOQMy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jun 2022 12:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234028AbiFOQMw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jun 2022 12:12:52 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C5121813;
        Wed, 15 Jun 2022 09:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=dDcdCEaWGv/l2098gGlW8wOT/rK8fbKH3lNyefLy2uU=; b=jrRPehtQjnwFT9fc0jh95GHygA
        bdV8reEzaqp9WJZ335mwCqqfi7aKzHcfq44yZsd+aV9wUibpB3xBhAto5o+j6yvnirP4cGWR5S39p
        0XfCIhvUgy9ESkAaN7jtBYdJQNfWBEHDDPdl/8tgme6cpP+30ZChoOIeNm3TjGjCxU6KnwuMf+AIW
        edsKz20JAl61eh+aPomqwRmCKt2oCpdHuAQot81N38CC2l2BwtrnjKP6eBsiZLBKhti56rrEZNJ9R
        v7voaboUX7kQV65eKr7anMUK+TplynbGqVV1EGTf3xAGIrx9t9dWVp/Gjh2UDf62QHfpf5SloTH4v
        ZZm2jk8w==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1o1VdN-0084iR-L8; Wed, 15 Jun 2022 10:12:47 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1o1VdG-0004Zu-Ul; Wed, 15 Jun 2022 10:12:38 -0600
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
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
Date:   Wed, 15 Jun 2022 10:12:14 -0600
Message-Id: <20220615161233.17527-3-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220615161233.17527-1-logang@deltatee.com>
References: <20220615161233.17527-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de, jgg@ziepe.ca, christian.koenig@amd.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, jason@jlekstrand.net, dave.hansen@linux.intel.com, helgaas@kernel.org, dan.j.williams@intel.com, dave.b.minturn@intel.com, jianxin.xiong@intel.com, ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, logang@deltatee.com, bhelgaas@google.com, jhubbard@nvidia.com, rcampbell@nvidia.com, kch@nvidia.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH v7 02/21] PCI/P2PDMA: Attempt to set map_type if it has not been set
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Attempt to find the mapping type for P2PDMA pages on the first
DMA map attempt if it has not been done ahead of time.

Previously, the mapping type was expected to be calculated ahead of
time, but if pages are to come from userspace then there's no
way to ensure the path was checked ahead of time.

This change will calculate the mapping type if it hasn't pre-calculated
so it is no longer invalid to call pci_p2pdma_map_sg() before the mapping
type is calculated, so drop the WARN_ON when that is the case.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/pci/p2pdma.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 462b429ad243..4e8bc457e29a 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -854,6 +854,7 @@ static enum pci_p2pdma_map_type pci_p2pdma_map_type(struct dev_pagemap *pgmap,
 	struct pci_dev *provider = to_p2p_pgmap(pgmap)->provider;
 	struct pci_dev *client;
 	struct pci_p2pdma *p2pdma;
+	int dist;
 
 	if (!provider->p2pdma)
 		return PCI_P2PDMA_MAP_NOT_SUPPORTED;
@@ -870,6 +871,10 @@ static enum pci_p2pdma_map_type pci_p2pdma_map_type(struct dev_pagemap *pgmap,
 		type = xa_to_value(xa_load(&p2pdma->map_types,
 					   map_types_idx(client)));
 	rcu_read_unlock();
+
+	if (type == PCI_P2PDMA_MAP_UNKNOWN)
+		return calc_map_type_and_dist(provider, client, &dist, true);
+
 	return type;
 }
 
@@ -912,7 +917,7 @@ int pci_p2pdma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
 	case PCI_P2PDMA_MAP_BUS_ADDR:
 		return __pci_p2pdma_map_sg(p2p_pgmap, dev, sg, nents);
 	default:
-		WARN_ON_ONCE(1);
+		/* Mapping is not Supported */
 		return 0;
 	}
 }
-- 
2.30.2

