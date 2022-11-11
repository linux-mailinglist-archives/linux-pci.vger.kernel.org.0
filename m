Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F391625BB2
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 14:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233938AbiKKN4F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 08:56:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233779AbiKKNzb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 08:55:31 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3DF787B4;
        Fri, 11 Nov 2022 05:54:44 -0800 (PST)
Message-ID: <20221111122014.582175082@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668174882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ZVOHAcQR6Ck8rZV367QnK3ufgoDh454h+k8+8chi22c=;
        b=bh65FM3Wv1jgNy8JX9L/1h1sGC4JvcUj61n/CAa1/GaCVxHMEPoCPnVUHAszASJJtm3aaS
        3x6eK0/psnmrUrulQRoR5ceAXqPNIu5rg86zlhB9eMwtawFq4LqR95vhHRBEGkpP1ZUhLI
        nx+/v0r5xer11C1uLUi6/+zJz7nVSZOxDdgzI5tBPppvRovDqei+NkoMPwRggvR7n4XCqt
        9qLbz9iXA2wI612maBZ+ywD0003Dp8VskJPB1CdTnzmeLisdjUb1V+0D+cbhpDSUo4BMF8
        Ouy3gyMODMFyV9HGrxTx1HaFzMxnwY7YjVbWPP6ycv/4SosoyJug988nOd5IvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668174882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ZVOHAcQR6Ck8rZV367QnK3ufgoDh454h+k8+8chi22c=;
        b=fjsDWHhhpyTkJ9A+o8h8oPspQFyMSpDqgwLBYxxiAcwxwbku+4D8UnAXoP0KekhsWD5xFC
        fd6YzUcVRwgcIGDg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org
Subject: [patch 17/39] PCI/MSI: Get rid of externs in msi.h
References: <20221111120501.026511281@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 14:54:42 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ahmed S. Darwish <darwi@linutronix.de>

Follow the style of <linux/pci.h>

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/pci/msi/msi.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/pci/msi/msi.h
+++ b/drivers/pci/msi/msi.h
@@ -5,12 +5,12 @@
 
 #define msix_table_size(flags)	((flags & PCI_MSIX_FLAGS_QSIZE) + 1)
 
-extern int pci_msi_setup_msi_irqs(struct pci_dev *dev, int nvec, int type);
-extern void pci_msi_teardown_msi_irqs(struct pci_dev *dev);
+int pci_msi_setup_msi_irqs(struct pci_dev *dev, int nvec, int type);
+void pci_msi_teardown_msi_irqs(struct pci_dev *dev);
 
 #ifdef CONFIG_PCI_MSI_ARCH_FALLBACKS
-extern int pci_msi_legacy_setup_msi_irqs(struct pci_dev *dev, int nvec, int type);
-extern void pci_msi_legacy_teardown_msi_irqs(struct pci_dev *dev);
+int pci_msi_legacy_setup_msi_irqs(struct pci_dev *dev, int nvec, int type);
+void pci_msi_legacy_teardown_msi_irqs(struct pci_dev *dev);
 #else
 static inline int pci_msi_legacy_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 {

