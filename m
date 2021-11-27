Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D16E45FAAC
	for <lists+linux-pci@lfdr.de>; Sat, 27 Nov 2021 02:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350291AbhK0Bds (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Nov 2021 20:33:48 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40454 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349742AbhK0BbK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Nov 2021 20:31:10 -0500
Message-ID: <20211126232735.249206271@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637976172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=doaEN4PngPF6b3Ms4+nCLub9WRL+cYqg2iUonunceVg=;
        b=wH479YSOMpAe/CjxokGeVj+z1I7pp7OeGHgxcAKyXB54wWhhOhd+/o1a/4IWS/UnNd5LHk
        ZBHytw6r7nkUPlCbtVcz4/VJiDfplKN6ZDwVemt8qh5LVXXl52ma0ZGLxn22fQAOhSMOuo
        ZMoYq+S42c3xb/c9cc6zs9BqzL9xQDjYDg01TBCCRErmWnhxkDcCzq2BQND6KV3fkO1Eg/
        NWlgJjgckJPAQ6bvt9M4Eca49pQbHbNtyy8d7F+vf54jWT+Mte3fKrbgGLOK4WTb7VsqC6
        8HOPrOPXsepIn5sTL3rCI/ABRNeoxu3Lnbs8zQQV24Wryi+IpR0GMW5yMyxsbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637976172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=doaEN4PngPF6b3Ms4+nCLub9WRL+cYqg2iUonunceVg=;
        b=oVmm1uq/IJW5lAq4u6IXEHKdUzJnmPi/CN2mq/4h39oviKTxzM6irWLT7LO6ehwIuO9MtO
        gRsYTO50zOxwqoCw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
Subject: [patch 16/32] powerpc/cell/axon_msi: Convert to msi_on_each_desc()
References: <20211126230957.239391799@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Nov 2021 02:22:52 +0100 (CET)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Replace the about to vanish iterators and make use of the filtering.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/powerpc/platforms/cell/axon_msi.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

--- a/arch/powerpc/platforms/cell/axon_msi.c
+++ b/arch/powerpc/platforms/cell/axon_msi.c
@@ -265,7 +265,7 @@ static int axon_msi_setup_msi_irqs(struc
 	if (rc)
 		return rc;
 
-	for_each_pci_msi_entry(entry, dev) {
+	msi_for_each_desc(entry, &dev->dev, MSI_DESC_NOTASSOCIATED) {
 		virq = irq_create_direct_mapping(msic->irq_domain);
 		if (!virq) {
 			dev_warn(&dev->dev,
@@ -288,10 +288,7 @@ static void axon_msi_teardown_msi_irqs(s
 
 	dev_dbg(&dev->dev, "axon_msi: tearing down msi irqs\n");
 
-	for_each_pci_msi_entry(entry, dev) {
-		if (!entry->irq)
-			continue;
-
+	msi_for_each_desc(entry, &dev->dev, MSI_DESC_ASSOCIATED) {
 		irq_set_msi_desc(entry->irq, NULL);
 		irq_dispose_mapping(entry->irq);
 	}

