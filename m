Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9189E44AF10
	for <lists+linux-pci@lfdr.de>; Tue,  9 Nov 2021 14:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235802AbhKIN4p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Nov 2021 08:56:45 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36310 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbhKIN4p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Nov 2021 08:56:45 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1636466038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=sZyll560KLUb+apJiZdozn6h/p8K1VyRcQd9fbMYkV4=;
        b=jXSyoXrPWQ05v+EcHbQ7JZjBockKD4VEiroRhGrc0CEOj/6umKMjlVhAIK+9UvRlmovoFR
        C1RdytpWI2aPnqbnNbm1ii17ZopLVQdpNHH7lV1JilPg1ecuDHYoO58gS3lZ7ALXnL7q0P
        fNIoh2c0+ACQEShg+UH8JPIrJQgTFN9R1IwaF6Jtxxrabvulq1XbKS8Bl2xxw737uCJW2m
        Jno8CcWCL8Bs9XQ9HDJ0TuysEkTpVazrchSUCLE/H30zBxMt326cUqCjaSejm0BOiKpQEO
        aisTHwBVdq5+BxoCY0aIqjTw10ud/JPLwlfKJbXCjg5LjsiW+rUMDMZKTWIaxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1636466038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=sZyll560KLUb+apJiZdozn6h/p8K1VyRcQd9fbMYkV4=;
        b=mClu8lrQG6dpgIyEqMf1tnrd72p22DENy7mQu9j6RsmxmxYhsEfa7eABVBF8nFRv11s00y
        JP/sVUmPIfhGZ7DA==
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah Hartmann <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org
Subject: PCI/MSI: Destroy sysfs before freeing entries
Date:   Tue, 09 Nov 2021 14:53:57 +0100
Message-ID: <87sfw5305m.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

free_msi_irqs() frees the MSI entries before destroying the sysfs entries
which are exposing them. Nothing prevents a concurrent free while a sysfs
file is read and accesses the possibly freed entry.

Move the sysfs release ahead of freeing the entries.

Fixes: 1c51b50c2995 ("PCI/MSI: Export MSI mode using attributes, not kobjects")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
---
 drivers/pci/msi.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -370,6 +370,11 @@ static void free_msi_irqs(struct pci_dev
 			for (i = 0; i < entry->nvec_used; i++)
 				BUG_ON(irq_has_action(entry->irq + i));
 
+	if (dev->msi_irq_groups) {
+		msi_destroy_sysfs(&dev->dev, dev->msi_irq_groups);
+		dev->msi_irq_groups = NULL;
+	}
+
 	pci_msi_teardown_msi_irqs(dev);
 
 	list_for_each_entry_safe(entry, tmp, msi_list, list) {
@@ -381,11 +386,6 @@ static void free_msi_irqs(struct pci_dev
 		list_del(&entry->list);
 		free_msi_entry(entry);
 	}
-
-	if (dev->msi_irq_groups) {
-		msi_destroy_sysfs(&dev->dev, dev->msi_irq_groups);
-		dev->msi_irq_groups = NULL;
-	}
 }
 
 static void pci_intx_for_msi(struct pci_dev *dev, int enable)
