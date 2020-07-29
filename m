Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B62172327F6
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jul 2020 01:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgG2XSu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jul 2020 19:18:50 -0400
Received: from ale.deltatee.com ([204.191.154.188]:55744 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbgG2XSu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jul 2020 19:18:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=89S+0e9qaMFizZD+RqQQwt4PtCqG160SQSXRodd2/rg=; b=HVEQ5APHaKvLskI7TAL5CaUC9X
        pGYeq7ZPshVY64Hg8IB+e22hnLINwW/LMYgLoxtfKEYsXRqAZpchZC8TEDgjMBI1R8V66Vk2xwuEQ
        xjFgOsfcv0uck1cZCu8/pyKreXsOHBwwmVc/3tCPrUpoKFuZVHsfBP/eejQ+KUTYfwNgYS1EvgnWj
        BfAl6F78l2XuNaA+AQvNwrtHG1vOVfOgvNEzbG9+Y+Dy5nHgMVum/ITFGiiG9jEul8RIqUm/jNyx+
        XFgO8vglejw+chzGuCfPbPVfQaSPW3WSirDgcE1xvB7mWD33jwhjuGSBM93AG3G3cLJZSjQ2GyAeT
        CWwTtpRA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1k0vLT-0002wJ-GY; Wed, 29 Jul 2020 17:18:49 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1k0vLS-0001Do-Du; Wed, 29 Jul 2020 17:18:46 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alex Deucher <alexdeucher@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>
Date:   Wed, 29 Jul 2020 17:18:44 -0600
Message-Id: <20200729231844.4653-1-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, logang@deltatee.com, bhelgaas@google.com, alexdeucher@gmail.com, christian.koenig@amd.com, ray.huang@amd.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH v2] PCI/P2PDMA: Allow P2PDMA on all AMD CPUs newer than the Zen family
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In order to avoid needing to add every new AMD CPU host bridge to the list
every cycle, allow P2PDMA if the CPUs vendor is AMD and family is
greater than 0x17 (Zen).

This should cut down a bunch of the churn adding to the list of allowed
host bridges.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Alex Deucher <alexdeucher@gmail.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Huang Rui <ray.huang@amd.com>

---

Here's a reworked patch to enable P2PDMA on Zen2 (and in fact all
subsequent Zen platforms).

This should remove all the churn on the list for the AMD side. Still
don't have a good solution for Intel.

 drivers/pci/p2pdma.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index e8e444eeb1cd..f1cab2c50595 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -273,6 +273,24 @@ static void seq_buf_print_bus_devfn(struct seq_buf *buf, struct pci_dev *pdev)
 	seq_buf_printf(buf, "%s;", pci_name(pdev));
 }

+#ifdef CONFIG_X86
+static bool cpu_supports_p2pdma(void)
+{
+	struct cpuinfo_x86 *c = &cpu_data(0);
+
+	/* Any AMD CPU who's family id is newer than Zen will support p2pdma */
+	if (c->x86_vendor == X86_VENDOR_AMD && c->x86 >= 0x17)
+		return true;
+
+	return false;
+}
+#else
+static bool cpu_supports_p2pdma(void)
+{
+	return false;
+}
+#endif
+
 static const struct pci_p2pdma_whitelist_entry {
 	unsigned short vendor;
 	unsigned short device;
@@ -280,11 +298,6 @@ static const struct pci_p2pdma_whitelist_entry {
 		REQ_SAME_HOST_BRIDGE	= 1 << 0,
 	} flags;
 } pci_p2pdma_whitelist[] = {
-	/* AMD ZEN */
-	{PCI_VENDOR_ID_AMD,	0x1450,	0},
-	{PCI_VENDOR_ID_AMD,	0x15d0,	0},
-	{PCI_VENDOR_ID_AMD,	0x1630,	0},
-
 	/* Intel Xeon E5/Core i7 */
 	{PCI_VENDOR_ID_INTEL,	0x3c00, REQ_SAME_HOST_BRIDGE},
 	{PCI_VENDOR_ID_INTEL,	0x3c01, REQ_SAME_HOST_BRIDGE},
@@ -473,7 +486,8 @@ upstream_bridge_distance(struct pci_dev *provider, struct pci_dev *client,
 					      acs_redirects, acs_list);

 	if (map_type == PCI_P2PDMA_MAP_THRU_HOST_BRIDGE) {
-		if (!host_bridge_whitelist(provider, client))
+		if (!cpu_supports_p2pdma() &&
+		    !host_bridge_whitelist(provider, client))
 			map_type = PCI_P2PDMA_MAP_NOT_SUPPORTED;
 	}


base-commit: 92ed301919932f777713b9172e525674157e983d
--
2.20.1
