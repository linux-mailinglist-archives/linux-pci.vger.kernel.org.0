Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6950D4B4D36
	for <lists+linux-pci@lfdr.de>; Mon, 14 Feb 2022 12:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349097AbiBNKqs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Feb 2022 05:46:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349022AbiBNKpc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Feb 2022 05:45:32 -0500
Received: from office.oderland.com (office.oderland.com [91.201.60.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F07574DC1
        for <linux-pci@vger.kernel.org>; Mon, 14 Feb 2022 02:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=oderland.se
        ; s=default; h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:From:
        MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=DBcZFOZFOzAo0487ORwdyo67faVNaoS7BuODPg0NpSc=; b=G2iBx9UAIY7r4NBbcXyTDLChbw
        Zgw1vyY89SDtdMDHqsdCOLiyD0ju+cpr2blUyln1I+Lq8jk+Pugfx0BpX9MHsjvZGwlvDOY8EdrcN
        jGT5YBha3W4hhznMoEJ4ehSglNSQ0Mbplhw5Ws2ylCjociLp6FRMi3kOkO3pHh8eBlAtoVvEMFKlT
        pNH6WgHV7uuMd1VUyrROPx8wiCaTbNyzotCCp5sYdwznYq0yp4Q6OceiB1Nb56b5Uk+DtayFC/NpD
        uSpOYKz3sPZBukIkgAMdmvd7rCyiCiXWueogd/tWwZjkfgr3VCdmLV1E7dsuX3F10b7HqVqhgSNZj
        uBVcE0Wg==;
Received: from [193.180.18.160] (port=46784 helo=[10.137.0.14])
        by office.oderland.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <josef@oderland.se>)
        id 1nJYGq-00FJ2L-Q4; Mon, 14 Feb 2022 11:07:48 +0100
Message-ID: <d818f9c9-a432-213e-4152-eaff3b7da52e@oderland.se>
Date:   Mon, 14 Feb 2022 11:07:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:97.0) Gecko/20100101
 Thunderbird/97.0
From:   Josef Johansson <josef@oderland.se>
Subject: [PATCH v2] PCI/MSI: Correct use of can_mask in msi_add_msi_desc()
To:     Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     xen-devel <xen-devel@lists.xenproject.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - office.oderland.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oderland.se
X-Get-Message-Sender-Via: office.oderland.com: authenticated_id: josjoh@oderland.se
X-Authenticated-Sender: office.oderland.com: josjoh@oderland.se
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Josef Johansson <josef@oderland.se>

PCI/MSI: Correct use of can_mask in msi_add_msi_desc()
    
Commit 71020a3c0dff4 ("PCI/MSI: Use msi_add_msi_desc()") modifies
the logic of checking msi_attrib.can_mask, without any reason.
    
This commits restores that logic.

Fixes: 71020a3c0dff4 ("PCI/MSI: Use msi_add_msi_desc()")
Signed-off-by: Josef Johansson <josef@oderland.se>

---
v2: Changing subject line to fit earlier commits.

Trying to fix a NULL BUG in the NVMe MSIX implementation I stumbled upon this code,
which ironically was what my last MSI patch resulted into.

I don't see any reason why this logic was change, and it did not break anything
correcting the logic.

CC xen-devel since it very much relates to Xen kernel (via pci_msi_ignore_mask).
---

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index c19c7ca58186..146e7b9a01cc 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -526,7 +526,7 @@ static int msix_setup_msi_descs(struct pci_dev *dev, void __iomem *base,
 		desc.pci.msi_attrib.can_mask = !pci_msi_ignore_mask &&
 					       !desc.pci.msi_attrib.is_virtual;
 
-		if (!desc.pci.msi_attrib.can_mask) {
+		if (desc.pci.msi_attrib.can_mask) {
 			addr = pci_msix_desc_addr(&desc);
 			desc.pci.msix_ctrl = readl(addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
 		}

--
2.31.1

