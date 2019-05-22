Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F24B270A0
	for <lists+linux-pci@lfdr.de>; Wed, 22 May 2019 22:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729794AbfEVUM5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 May 2019 16:12:57 -0400
Received: from ale.deltatee.com ([207.54.116.67]:52224 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728958AbfEVUM4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 22 May 2019 16:12:56 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hTXba-0003SS-O7; Wed, 22 May 2019 14:12:55 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hTXba-0000n6-3Y; Wed, 22 May 2019 14:12:54 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-pci@vger.kernel.org
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Date:   Wed, 22 May 2019 14:12:52 -0600
Message-Id: <20190522201252.2997-1-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-pci@vger.kernel.org, logang@deltatee.com, christian.koenig@amd.com, bhelgaas@google.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH] PCI/P2PDMA: Root complex whitelist should not apply when an IOMMU is present
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Presently, there is no path to DMA map P2PDMA memory, so if a TLP
targeting this memory hits the root complex and an IOMMU is present,
the IOMMU will reject the transaction, even if the RC would support
P2PDMA.

So until the kernel knows to map these DMA addresses in the IOMMU,
we should not enable the whitelist when an IOMMU is present.

While we are at it, remove the comment mentioning future work
to add a white list.

Fixes: 0f97da831026 ("PCI/P2PDMA: Allow P2P DMA between any devices under AMD ZEN Root Complex")
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/p2pdma.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

Hey,

I realized recently that I missed this issue between the IOMMU and
the whitelist when reviewing Christian's patch.

Unless there are any objections, I think this should be squashed
with the commit marked in the Fixes tag (from pci-v5.2-changes).

Thanks,

Logan

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 742928d0053e..4d2f6a44cba3 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -18,6 +18,7 @@
 #include <linux/percpu-refcount.h>
 #include <linux/random.h>
 #include <linux/seq_buf.h>
+#include <linux/iommu.h>

 struct pci_p2pdma {
 	struct percpu_ref devmap_ref;
@@ -284,6 +285,9 @@ static bool root_complex_whitelist(struct pci_dev *dev)
 	struct pci_dev *root = pci_get_slot(host->bus, PCI_DEVFN(0, 0));
 	unsigned short vendor, device;

+	if (iommu_present(dev->dev.bus))
+		return false;
+
 	if (!root)
 		return false;

@@ -453,8 +457,7 @@ static int upstream_bridge_distance_warn(struct pci_dev *provider,
  *
  * For now, "compatible" means the provider and the clients are all behind
  * the same PCI root port. This cuts out cases that may work but is safest
- * for the user. Future work can expand this to white-list root complexes that
- * can safely forward between each ports.
+ * for the user.
  */
 int pci_p2pdma_distance_many(struct pci_dev *provider, struct device **clients,
 			     int num_clients, bool verbose)
--
2.20.1
