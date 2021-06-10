Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCD723A3021
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jun 2021 18:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbhFJQIU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Jun 2021 12:08:20 -0400
Received: from ale.deltatee.com ([204.191.154.188]:60186 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbhFJQIR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Jun 2021 12:08:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=QeMDlTK6S7rVNcdHO1iGH78RGAnpL8RDeAFDcSCpHHg=; b=XrSLkbPI2G3LBEDiqZW6cM4HtU
        R44bH+nZDfJABLhQ+SEQPH9MB2l/2KgjG3CzWglXqHILUL9fD+z0wyFbpJkeXe4JnCa1TLjC7WbQm
        GDLb+4X106ViW3DRNfnjepTIuEOnj0IwR8pIbjpFD+vmel1jKasORiNygjmOhztQ2F1CTFsuO5qPK
        6pn9KgHLH6yV89uRwk/OHSPY3KLT7g9h+oXEAgyb1nUP7MDJbGGD1/eeZ/wB0GyORXI41AFvQRPhG
        ov7mvzwBZUDruT+zrlyH+48sDTqA+4gIIHnqrZQdn4V8G6FPjiXy0nv+eKbvqTsRop7zjuyBX+MZe
        kIJT2y4Q==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1lrNCA-0000Jk-Kn; Thu, 10 Jun 2021 10:06:21 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1lrNC8-0007Pp-Qy; Thu, 10 Jun 2021 10:06:12 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu, 10 Jun 2021 10:06:07 -0600
Message-Id: <20210610160609.28447-5-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210610160609.28447-1-logang@deltatee.com>
References: <20210610160609.28447-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, helgaas@kernel.org, sbates@raithlin.com, hch@lst.de, dan.j.williams@intel.com, jgg@ziepe.ca, christian.koenig@amd.com, jhubbard@nvidia.com, ddutile@redhat.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        MYRULES_NO_TEXT autolearn=no autolearn_force=no version=3.4.2
Subject: [PATCH v1 4/6] PCI/P2PDMA: Print a warning if the host bridge is not in the whitelist
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
index 09c864f193d2..2de4a9e2da58 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -309,7 +309,7 @@ static const struct pci_p2pdma_whitelist_entry {
 };
 
 static bool __host_bridge_whitelist(struct pci_host_bridge *host,
-				    bool same_host_bridge)
+				    bool same_host_bridge, bool warn)
 {
 	struct pci_dev *root = pci_get_slot(host->bus, PCI_DEVFN(0, 0));
 	const struct pci_p2pdma_whitelist_entry *entry;
@@ -331,6 +331,10 @@ static bool __host_bridge_whitelist(struct pci_host_bridge *host,
 		return true;
 	}
 
+	if (warn)
+		pci_warn(root, "Host bridge not in P2PDMA whitelist: %04x:%04x\n",
+			 vendor, device);
+
 	return false;
 }
 
@@ -338,16 +342,17 @@ static bool __host_bridge_whitelist(struct pci_host_bridge *host,
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
@@ -483,7 +488,7 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 
 	if (map_type == PCI_P2PDMA_MAP_THRU_HOST_BRIDGE) {
 		if (!cpu_supports_p2pdma() &&
-		    !host_bridge_whitelist(provider, client))
+		    !host_bridge_whitelist(provider, client, acs_redirects))
 			map_type = PCI_P2PDMA_MAP_NOT_SUPPORTED;
 	}
 
-- 
2.20.1

