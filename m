Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1C6245FB40
	for <lists+linux-pci@lfdr.de>; Sat, 27 Nov 2021 02:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhK0BhV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Nov 2021 20:37:21 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40750 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239833AbhK0BfU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Nov 2021 20:35:20 -0500
Message-ID: <20211127000918.723637256@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637976304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=wAZLS4DVWG/31wPrjnVkWgrCpcsyPlNJgofX29BhKpw=;
        b=US7UNPS+NXprP3fC+BqxW5rKcXZSUWRgYEei1kp1cCjbCMj3u+ySTjRvZnXM2ceKo4onbi
        DdeUZvv7ATkP7ocNNn103LksVWfjm5uN9xsMKNKUkJ5r7sAXBwyi3mWHJUGAYCIKsxFF8W
        zeL8yJWHe6fOAHY3g1/48EOhvZlfjNp/xG9NYWpzEZ3rn98/Ofvp3DTasIjXlw2cK2wMds
        TqzUkjIiplaZtF10uMqyFnaMhAQOSsF6MZzpiHysW2poqTq6yZnmBnI89SRY6U/PvhxBa9
        +2GTvPrB5USmFIGIwqM5iNn3fQxU8Z4UCD6VIYJcstNKx8rpJV4CIsc0NRThdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637976304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=wAZLS4DVWG/31wPrjnVkWgrCpcsyPlNJgofX29BhKpw=;
        b=5hog39uj/8+DNtMBKVJ45GPgya8dS0p++jg39/Ye2fIq1TOglsCWtkpKvp9KVSipqhlIKT
        vEZHhZd84iLgrSBQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Cooper <amc96@cam.ac.uk>,
        Juergen Gross <jgross@suse.com>, linux-pci@vger.kernel.org,
        xen-devel@lists.xenproject.org
Subject: [patch 04/10] genirq/msi: Prepare MSI domain alloc/free for range irq
 allocation
References: <20211126233124.618283684@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Nov 2021 02:25:03 +0100 (CET)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Make the iterators in the allocation and free functions range based.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/msi.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -877,6 +877,7 @@ int __msi_domain_alloc_irqs(struct irq_d
 	msi_alloc_info_t arg = { };
 	unsigned int vflags = 0;
 	struct msi_desc *desc;
+	unsigned long idx;
 	int allocated = 0;
 	int i, ret, virq;
 
@@ -906,7 +907,10 @@ int __msi_domain_alloc_irqs(struct irq_d
 			vflags |= VIRQ_NOMASK_QUIRK;
 	}
 
-	msi_for_each_desc(desc, dev, MSI_DESC_NOTASSOCIATED) {
+	xa_for_each_range(&dev->msi.data->store, idx, desc, range->first, range->last) {
+		if (!msi_desc_match(desc, MSI_DESC_NOTASSOCIATED))
+			continue;
+
 		ops->set_desc(&arg, desc);
 
 		virq = __irq_domain_alloc_irqs(domain, -1, desc->nvec_used,
@@ -999,10 +1003,14 @@ void __msi_domain_free_irqs(struct irq_d
 	struct msi_domain_info *info = domain->host_data;
 	struct irq_data *irqd;
 	struct msi_desc *desc;
+	unsigned long idx;
 	int i;
 
 	/* Only handle MSI entries which have an interrupt associated */
-	msi_for_each_desc(desc, dev, MSI_DESC_ASSOCIATED) {
+	xa_for_each_range(&dev->msi.data->store, idx, desc, range->first, range->last) {
+		if (!msi_desc_match(desc, MSI_DESC_ASSOCIATED))
+			continue;
+
 		/* Make sure all interrupts are deactivated */
 		for (i = 0; i < desc->nvec_used; i++) {
 			irqd = irq_domain_get_irq_data(domain, desc->irq + i);

