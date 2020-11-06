Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3E132A9A2B
	for <lists+linux-pci@lfdr.de>; Fri,  6 Nov 2020 18:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgKFRA7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Nov 2020 12:00:59 -0500
Received: from ale.deltatee.com ([204.191.154.188]:57644 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727757AbgKFRA5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Nov 2020 12:00:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=70pLG2mtaM/qAjlvPwrCa6hi8Pb+2Avuax5NOW5ft8g=; b=e3fXrM2b1kZsOVGk71a7haq0Yp
        7RG4YrCC2Cvne+bpsEC97u/0eFwdO7jlz9n5RCpfzP00QkdA8tz+Sloo98K3ADKY31zjKlZYoH2Fe
        4KqIHoNPukgrMVovpVHxYynxmcjscoqsrc14DFp4ohfXt8/9zZNoUyliKyDpXULTWoJvcAheeNtjq
        s0jOQhPKtk2DJWT0QpFILMwfSdUfaK60IWJbF3zy02TVs1fQx1DzC9F0qZE75jj4T9Kba4o4iO+w6
        aGIgLGzkcsqi3VQQ2B/8rQHVeaxTNjjUSfVoEmeMpabF91WiheXZI+COO/yn48YuiyVSaKonNITku
        skfhLijA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1kb56Z-0002PW-5k; Fri, 06 Nov 2020 10:00:56 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1kb56U-0004sq-64; Fri, 06 Nov 2020 10:00:46 -0700
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
        Logan Gunthorpe <logang@deltatee.com>
Date:   Fri,  6 Nov 2020 10:00:22 -0700
Message-Id: <20201106170036.18713-2-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201106170036.18713-1-logang@deltatee.com>
References: <20201106170036.18713-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de, jgg@ziepe.ca, christian.koenig@amd.com, dan.j.williams@intel.com, iweiny@intel.com, jhubbard@nvidia.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_NO_TEXT autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [RFC PATCH 01/15] PCI/P2PDMA: Don't sleep in upstream_bridge_distance_warn()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In order to call this function from a dma_map function, it must not sleep.
The only reason it does sleep so to allocate the seqbuf to print
which devices are within the ACS path.

Switch the kmalloc call to use GFP_NOWAIT and simply not print that
message if the buffer fails to be allocated.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/p2pdma.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index de1c331dbed4..94583779c36e 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -267,7 +267,7 @@ static int pci_bridge_has_acs_redir(struct pci_dev *pdev)
 
 static void seq_buf_print_bus_devfn(struct seq_buf *buf, struct pci_dev *pdev)
 {
-	if (!buf)
+	if (!buf || !buf->buffer)
 		return;
 
 	seq_buf_printf(buf, "%s;", pci_name(pdev));
@@ -501,19 +501,20 @@ upstream_bridge_distance_warn(struct pci_dev *provider, struct pci_dev *client,
 	bool acs_redirects;
 	int ret;
 
-	seq_buf_init(&acs_list, kmalloc(PAGE_SIZE, GFP_KERNEL), PAGE_SIZE);
-	if (!acs_list.buffer)
-		return -ENOMEM;
+	seq_buf_init(&acs_list, kmalloc(PAGE_SIZE, GFP_NOWAIT), PAGE_SIZE);
 
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
-- 
2.20.1

