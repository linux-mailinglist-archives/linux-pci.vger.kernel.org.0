Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1A1625BCA
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 14:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233888AbiKKN5G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 08:57:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233799AbiKKN4H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 08:56:07 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5902D7F563;
        Fri, 11 Nov 2022 05:55:03 -0800 (PST)
Message-ID: <20221111122015.271447896@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668174902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=uSFXy88Ws6eNkV/cYwDRULmA+6GRqcWIzt5ADLcbTDw=;
        b=qtOLrPfLAgkAZVy6NU1Qu4bTgTB43Bj44kvSwwsRH2ZnPNV8dgX7HwnPsn22qu8w9m7yL2
        A97svlVBbgwk1Kouj39B9/00uFrvjnNmfsSosW6KlZXHE8ipZjQ0zh2qu2h4JEOniktLvM
        DdJLcXVpW+4EUh71Wah1RWNgffLHTJmi70jycylYYTUnXe5mTgu11BanYjAsDqbjHjh5Cj
        jNVdIefLpB/Et84Tmy/wCrmUO2sDcrVo8lhj8nIcgrZW5QGFV0eKkEMimQbvvAjsRl/0w+
        VdXkapfyi/PEEHMzxyAKo9mdYdwp3K4g/p7Prgjc0/kxGJjy/daFCUOg+YK/3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668174902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=uSFXy88Ws6eNkV/cYwDRULmA+6GRqcWIzt5ADLcbTDw=;
        b=9t/bFWqCfq8f0C3vQmoP3/db8s/pcp6OGrpaut5YexKKU5gS1ZtJ1Y4TbyTmvAad70QZt8
        pyB9AsmnH5FIAdCA==
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
Subject: [patch 29/39] PCI/MSI: Move pci_msi_enabled() to api.c
References: <20221111120501.026511281@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 14:55:01 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ahmed S. Darwish <darwi@linutronix.de>

To distangle the maze in msi.c, all exported device-driver MSI APIs are
now to be grouped in one file, api.c.

Move pci_msi_enabled() and make its kernel-doc comprehensive.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 drivers/pci/msi/api.c | 12 ++++++++++++
 drivers/pci/msi/msi.c | 14 +-------------
 drivers/pci/msi/msi.h |  3 +++
 3 files changed, 16 insertions(+), 13 deletions(-)
---
diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
index 473df7ba0584..ee9ed5ccd94d 100644
--- a/drivers/pci/msi/api.c
+++ b/drivers/pci/msi/api.c
@@ -307,3 +307,15 @@ void pci_free_irq_vectors(struct pci_dev *dev)
 	pci_disable_msi(dev);
 }
 EXPORT_SYMBOL(pci_free_irq_vectors);
+
+/**
+ * pci_msi_enabled() - Are MSI(-X) interrupts enabled system-wide?
+ *
+ * Return: true if MSI has not been globally disabled through ACPI FADT,
+ * PCI bridge quirks, or the "pci=nomsi" kernel command-line option.
+ */
+int pci_msi_enabled(void)
+{
+	return pci_msi_enable;
+}
+EXPORT_SYMBOL(pci_msi_enabled);
diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index d78646d1c116..59c33bc7fe81 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -13,7 +13,7 @@
 #include "../pci.h"
 #include "msi.h"
 
-static int pci_msi_enable = 1;
+int pci_msi_enable = 1;
 int pci_msi_ignore_mask;
 
 void pci_msi_update_mask(struct msi_desc *desc, u32 clear, u32 set)
@@ -864,15 +864,3 @@ void pci_no_msi(void)
 {
 	pci_msi_enable = 0;
 }
-
-/**
- * pci_msi_enabled - is MSI enabled?
- *
- * Returns true if MSI has not been disabled by the command-line option
- * pci=nomsi.
- **/
-int pci_msi_enabled(void)
-{
-	return pci_msi_enable;
-}
-EXPORT_SYMBOL(pci_msi_enabled);
diff --git a/drivers/pci/msi/msi.h b/drivers/pci/msi/msi.h
index 77e2587f7e4f..f3f4ede53171 100644
--- a/drivers/pci/msi/msi.h
+++ b/drivers/pci/msi/msi.h
@@ -84,6 +84,9 @@ static inline __attribute_const__ u32 msi_multi_mask(struct msi_desc *desc)
 	return (1 << (1 << desc->pci.msi_attrib.multi_cap)) - 1;
 }
 
+/* Subsystem variables */
+extern int pci_msi_enable;
+
 /* MSI internal functions invoked from the public APIs */
 void pci_msi_shutdown(struct pci_dev *dev);
 void pci_msix_shutdown(struct pci_dev *dev);

