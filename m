Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB23625C54
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 15:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234408AbiKKOFD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 09:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234024AbiKKOEo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 09:04:44 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6BF86D7D;
        Fri, 11 Nov 2022 05:58:53 -0800 (PST)
Message-ID: <20221111135205.427665748@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668175096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=/GP5ZfhesXV4jkE3W+IUGaBn9TdtWzm6Yg+gBfFIDQM=;
        b=T9GnH5Wxg6y5adVcI9HYbFSasOntQpqN7EM4Ju8aS+Hp62qxyuj5npMIuVBzZ1HCgw6JES
        XYLaSo+SsgO4NZ3gfROtO2WFKm1reRAzZ/bd0NNkrOcvlMYWCfNJFg5thHN+zzfLWKGzfD
        uxY4HOhHU7INrUHvN4pZpoHvJ2uuEm1he0Z310uRoHCLV4qSs7uniTK4hWNZHmIgch0bzv
        iYiaZ+6ttdVqK8+CTQVnzMpEpASenL8b5oN8mRDUKoFc/XVfQD/tQihxP0K1vTonGxKRx3
        fMtUQ5z8qAj+mSGwKGX9mP1oQYspNs+Ro3CBlyZqvRrfDshKUR1rdD7+2iEKhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668175096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=/GP5ZfhesXV4jkE3W+IUGaBn9TdtWzm6Yg+gBfFIDQM=;
        b=QjNe8fnlTswrfFOfkjUSFhg8xeO8gQDG/CNErx383a8OQ6oKUGU0syWSQs7LYOCdcl6LJI
        dr5oNw7EczlrTSDw==
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
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [patch 03/33] genirq/msi: Provide data structs for per device domains
References: <20221111133158.196269823@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 14:58:15 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Provide struct msi_domain_template which contains a bundle of struct
irq_chip, struct msi_domain_ops and struct msi_domain_info and a name
field.

This template is used by MSI device domain implementations to provide the
domain specific functionality, feature bits etc.

When a MSI domain is created the template is duplicated in the core code
so that it can be modified per instance. That means templates can be
marked const at the MSI device domain code.

The template is a bundle to avoid several allocations and duplications
of the involved structures.

The name field is used to construct the final domain and chip name via:

    $PREFIX-$NAME-$DEVNAME

where prefix is the optional prefix of the MSI parent domain, $NAME is the
provided name in template::chip and the device name so that the domain
is properly identified. On x86 this results for PCI/MSI in:

   PCI-MSI-0000:3d:00.1 or IR-PCI-MSIX-0000:3d:00.1

depending on the domain type and the availability of remapping.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/msi.h |   16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -24,6 +24,7 @@
 #include <linux/xarray.h>
 #include <linux/mutex.h>
 #include <linux/list.h>
+#include <linux/irq.h>
 #include <linux/bits.h>
 
 #include <asm/msi.h>
@@ -74,7 +75,6 @@ struct msi_msg {
 
 extern int pci_msi_ignore_mask;
 /* Helper functions */
-struct irq_data;
 struct msi_desc;
 struct pci_dev;
 struct platform_msi_priv_data;
@@ -430,6 +430,20 @@ struct msi_domain_info {
 	void				*data;
 };
 
+/**
+ * struct msi_domain_template - Template for MSI device domains
+ * @name:	Storage for the resulting name. Filled in by the core.
+ * @chip:	Interrupt chip for this domain
+ * @ops:	MSI domain ops
+ * @info:	MSI domain info data
+ */
+struct msi_domain_template {
+	char			name[48];
+	struct irq_chip		chip;
+	struct msi_domain_ops	ops;
+	struct msi_domain_info	info;
+};
+
 /*
  * Flags for msi_domain_info
  *

