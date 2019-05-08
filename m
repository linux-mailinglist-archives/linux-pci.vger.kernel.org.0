Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D81A316F3B
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2019 04:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfEHCvB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 May 2019 22:51:01 -0400
Received: from alpha.anastas.io ([104.248.188.109]:45161 "EHLO
        alpha.anastas.io" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbfEHCvB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 May 2019 22:51:01 -0400
Received: from authenticated-user (alpha.anastas.io [104.248.188.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by alpha.anastas.io (Postfix) with ESMTPSA id B77C17F8E4;
        Tue,  7 May 2019 21:41:55 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=anastas.io; s=mail;
        t=1557283316; bh=nf95epbdL+CZevupMmf9m+9w2BZaXHsLR33tgT+SYxc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OF63QBueAqOwtfAoiXSBbjeG7B5TmhwbsNMnKCj1TKUYXr7GJV23+H9/Yb0/4aGUm
         pqWHa214o+SHJ9Wc9tp2zvAicAqM3LsBHOxpurwQmpwi5RQO3Zq2Iq28yX+58uf3Oo
         V4BOLqUQ4+bPfhRZ7MD5M5C0/xmxBCDmdNsF6N6DtmLNDwWhgJW2MNz5tMB3bjwRfJ
         inJ7Kfn8bsfU2pFx+l7F0Dj6BxG/95XTNed/b2GCD06Lt7ffhFdlb1ZtTiu/OKY7K6
         ZGClKHNy0w0krc5h/eu0iHygkCfo1kzyouvMEwSLqocIL3jTz6a25c1hmN+7+35W0t
         1RvK3UPtB7GVA==
From:   Shawn Anastasio <shawn@anastas.io>
To:     bhelgaas@google.com
Cc:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        sbobroff@linux.ibm.com, xyjxie@linux.vnet.ibm.com,
        rppt@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/3] PCI: Introduce pcibios_ignore_alignment_request
Date:   Tue,  7 May 2019 21:41:49 -0500
Message-Id: <20190508024151.5690-2-shawn@anastas.io>
In-Reply-To: <20190508024151.5690-1-shawn@anastas.io>
References: <20190508024151.5690-1-shawn@anastas.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Introduce a new pcibios function pcibios_ignore_alignment_request
which allows the PCI core to defer to platform-specific code to
determine whether or not to ignore alignment requests for PCI resources.

The existing behavior is to simply ignore alignment requests when
PCI_PROBE_ONLY is set. This is behavior is maintained by the
default implementation of pcibios_ignore_alignment_request.

Signed-off-by: Shawn Anastasio <shawn@anastas.io>
---
 drivers/pci/pci.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 766f5779db92..e7a925f2188e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5896,6 +5896,11 @@ resource_size_t __weak pcibios_default_alignment(void)
 	return 0;
 }
 
+int __weak pcibios_ignore_alignment_request(void)
+{
+	return pci_has_flag(PCI_PROBE_ONLY);
+}
+
 #define RESOURCE_ALIGNMENT_PARAM_SIZE COMMAND_LINE_SIZE
 static char resource_alignment_param[RESOURCE_ALIGNMENT_PARAM_SIZE] = {0};
 static DEFINE_SPINLOCK(resource_alignment_lock);
@@ -5920,9 +5925,9 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
 	p = resource_alignment_param;
 	if (!*p && !align)
 		goto out;
-	if (pci_has_flag(PCI_PROBE_ONLY)) {
+	if (pcibios_ignore_alignment_request()) {
 		align = 0;
-		pr_info_once("PCI: Ignoring requested alignments (PCI_PROBE_ONLY)\n");
+		pr_info_once("PCI: Ignoring requested alignments\n");
 		goto out;
 	}
 
-- 
2.20.1

