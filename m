Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A145D38004E
	for <lists+linux-pci@lfdr.de>; Fri, 14 May 2021 00:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233861AbhEMWdu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 May 2021 18:33:50 -0400
Received: from ale.deltatee.com ([204.191.154.188]:59386 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbhEMWdi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 May 2021 18:33:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=hPXhcihXAoH8RGaPYoi+qDN3LVubyQfJAgOHoQY58UM=; b=AJLAGCyL3f4e5xzFbUQ1yVN3cU
        cfpilAC8VhbDKR/rU1qGZpfArLVz5bmlSiNDtkd9Rd8yH0+gfwKMVE80p9zm5420S5vX4IJvKZ6j/
        T2TwuNQpSwbVaD8vI4CePH2nNGQsM0SbEeTBtaU9GwmpHvDHRX3pug4qLd3rpAdbY5agFTV1UO9Iq
        8xOs+p+PX8CFAJ8wtQnJ5SXl0GGWAh+NQiysec3JJ0JzBppU3VYYCchvsyhROMI4sovCFKTEL2biO
        29H9YJoEh5bn7UTnpiUzssbA/UMM9v1OeaKmCk90ULINe+TO62pIjvtvLHXrnmcB2t2q+61rYbfzD
        8MUkVIkw==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1lhJsZ-0000nF-AO; Thu, 13 May 2021 16:32:27 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1lhJsG-0001Sh-AJ; Thu, 13 May 2021 16:32:08 -0600
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
Date:   Thu, 13 May 2021 16:31:46 -0600
Message-Id: <20210513223203.5542-6-logang@deltatee.com>
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
Subject: [PATCH v2 05/22] PCI/P2PDMA: Print a warning if the host bridge is not in the whitelist
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If the host bridge is not in the whitelist print a warning in the
calc_map_type_and_dist_warn() path detailing the vendor and device IDs
that would need to be added to the whitelist.

Suggested-by: Don Dutile <ddutile@redhat.com>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/p2pdma.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 175da3a9c8fb..0e0b2218eacd 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -340,7 +340,7 @@ static struct pci_dev *pci_host_bridge_dev(struct pci_host_bridge *host)
 }
 
 static bool __host_bridge_whitelist(struct pci_host_bridge *host,
-				    bool same_host_bridge)
+				    bool same_host_bridge, bool warn)
 {
 	struct pci_dev *root = pci_host_bridge_dev(host);
 	const struct pci_p2pdma_whitelist_entry *entry;
@@ -361,6 +361,10 @@ static bool __host_bridge_whitelist(struct pci_host_bridge *host,
 		return true;
 	}
 
+	if (warn)
+		pci_warn(root, "Host bridge not in P2PDMA whitelist: %04x:%04x\n",
+			 vendor, device);
+
 	return false;
 }
 
@@ -368,16 +372,17 @@ static bool __host_bridge_whitelist(struct pci_host_bridge *host,
  * If we can't find a common upstream bridge take a look at the root
  * complex and compare it to a whitelist of known good hardware.
  */
-static bool host_bridge_whitelist(struct pci_dev *a, struct pci_dev *b)
+static bool host_bridge_whitelist(struct pci_dev *a, struct pci_dev *b,
+				  bool warn)
 {
 	struct pci_host_bridge *host_a = pci_find_host_bridge(a->bus);
 	struct pci_host_bridge *host_b = pci_find_host_bridge(b->bus);
 
 	if (host_a == host_b)
-		return __host_bridge_whitelist(host_a, true);
+		return __host_bridge_whitelist(host_a, true, warn);
 
-	if (__host_bridge_whitelist(host_a, false) &&
-	    __host_bridge_whitelist(host_b, false))
+	if (__host_bridge_whitelist(host_a, false, warn) &&
+	    __host_bridge_whitelist(host_b, false, warn))
 		return true;
 
 	return false;
@@ -513,7 +518,7 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 
 	if (map_type == PCI_P2PDMA_MAP_THRU_HOST_BRIDGE) {
 		if (!cpu_supports_p2pdma() &&
-		    !host_bridge_whitelist(provider, client))
+		    !host_bridge_whitelist(provider, client, acs_redirects))
 			map_type = PCI_P2PDMA_MAP_NOT_SUPPORTED;
 	}
 
-- 
2.20.1

