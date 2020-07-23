Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 361F722B555
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jul 2020 20:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbgGWSBu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jul 2020 14:01:50 -0400
Received: from ale.deltatee.com ([204.191.154.188]:40976 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbgGWSBu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jul 2020 14:01:50 -0400
X-Greylist: delayed 1108 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Jul 2020 14:01:49 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WYB90zp+5qCLQyIuM5+N5//x7Syxs5n6QTMugsNXCVY=; b=mejkwrLJr/cA/wcxqQfUnMvJ1N
        XfQWZVphHajP2ssHNIitBvy6szpeJdGhPOtmOp3mDoXbYGINfRmg3S/8nluReyZp7nLos3qPJeDM/
        F4BVorrQrKZ4++32EKHNRPOaX+IiEeIreKcfbyfucSR/GQwStOAs0Ep64+Mcv1tEszRgUnMYa/V5Y
        TfP7F4tW5drgsHzWpp4cQKyZbI4wn9hKDsnsmgr9p9hZpCd/X13VFCHpWDmCqV2dxyvu003UQwmSb
        GyNTEfKqHDYZSowGy5wDTfKn9gnKzOBFJJw40rBh4/I44J6F3Gmi5mTDAbxAEOAqhZpEGUx1x5iYH
        WWjRVtuQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1jyfFW-00087e-SG; Thu, 23 Jul 2020 11:43:20 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1jyfFW-0000jd-9X; Thu, 23 Jul 2020 11:43:18 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 23 Jul 2020 11:43:17 -0600
Message-Id: <20200723174317.2783-1-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, logang@deltatee.com, bhelgaas@google.com, christian.koenig@amd.com, ray.huang@amd.com, alexdeucher@gmail.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH] PCI/P2PDMA: Add AMD Zen 2 root complex to the list of allowed bridges
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The AMD Zen 2 root complex (Starship/Matisse) was tested for P2PDMA
transactions between root ports and found to work. Therefore add it
to the list.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Huang Rui <ray.huang@amd.com>
Cc: Alex Deucher <alexdeucher@gmail.com>
---
 drivers/pci/p2pdma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index e8e444eeb1cd..3d67a1ee083e 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -284,6 +284,8 @@ static const struct pci_p2pdma_whitelist_entry {
 	{PCI_VENDOR_ID_AMD,	0x1450,	0},
 	{PCI_VENDOR_ID_AMD,	0x15d0,	0},
 	{PCI_VENDOR_ID_AMD,	0x1630,	0},
+	/* AMD ZEN 2 */
+	{PCI_VENDOR_ID_AMD,	0x1480,	0},
 
 	/* Intel Xeon E5/Core i7 */
 	{PCI_VENDOR_ID_INTEL,	0x3c00, REQ_SAME_HOST_BRIDGE},

base-commit: ba47d845d715a010f7b51f6f89bae32845e6acb7
-- 
2.20.1

