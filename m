Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B748363819D
	for <lists+linux-pci@lfdr.de>; Fri, 25 Nov 2022 00:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiKXX3U (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 18:29:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiKXX2p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 18:28:45 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7812A6A0F;
        Thu, 24 Nov 2022 15:27:11 -0800 (PST)
Message-ID: <20221124232326.385036043@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669332375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=EqT6Jp+en7WSY8cSjz97kH8nOGu2P/AZ035PFV/I8FU=;
        b=ybChU8/XTp45uEtLOm0cjM7PJqC8y1syCV4cmMLPZ+y78SQu+5s4SbJ/zBrNJmpEUwA2z2
        1WhtRA+LNHl6snqrjQ6wCYxf/i8VK5e73gcJBIhfnfqxvWuTafny+bBBcWBZAtx8PlUyva
        ZtpCLUGgwm9J16LlP6jijqVkJTo25t6sHInznYWmlE+Xn71fYLIxQ+QQoLBHSbHgntaoxP
        v+C1gBEfs/b3f6JWSZzki8Moz5CjxNeMKgT30DaS/60F83khY0/VKs9ZHQMZ00VClcBSw3
        qYSySUtQWKWhDupHDI9MU+2RhtO22xucbaoDG7BYO+o5ZOYlhx+TzJ3kHBtOpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669332375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=EqT6Jp+en7WSY8cSjz97kH8nOGu2P/AZ035PFV/I8FU=;
        b=qRfykJijzo2B6VS+E4Lf1XhFh+X+lVExfqwUIw718z9n6snR4ObIQuwz3/vIaqnvJZWKgE
        R0q9vJjmTY7Gu1CQ==
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
        Allen Hubbe <allenbh@gmail.com>
Subject: [patch V3 19/33] genirq/msi: Provide msi_desc::msi_data
References: <20221124230505.073418677@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 25 Nov 2022 00:26:15 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The upcoming support for PCI/IMS requires to store some information related
to the message handling in the MSI descriptor, e.g. PASID or a pointer to a
queue.

Provide a generic storage struct which maps over the existing PCI specific
storage which means the size of struct msi_desc is not getting bigger.

This storage struct has two elements:

  1) msi_domain_cookie
  2) msi_instance_cookie

The domain cookie is going to be used to store domain specific information,
e.g. iobase pointer, data pointer.

The instance cookie is going to be handed in when allocating an interrupt
on an IMS domain so the irq chip callbacks of the IMS domain have the
necessary per vector information available. It also comes in handy when
cleaning up the platform MSI code for wire to MSI bridges which need to
hand down the type information to the underlying interrupt domain.

For the core code the cookies are opaque and meaningless. It just stores
the instance cookie during an allocation through the upcoming interfaces
for IMS and wire to MSI brigdes.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Rename and split into domain/instance
V3: Update stale changelog (Kevin)
---
 include/linux/msi.h     |   38 +++++++++++++++++++++++++++++++++++++-
 include/linux/msi_api.h |   17 +++++++++++++++++
 2 files changed, 54 insertions(+), 1 deletion(-)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -125,6 +125,38 @@ struct pci_msi_desc {
 	};
 };
 
+/**
+ * union msi_domain_cookie - Opaque MSI domain specific data
+ * @value:	u64 value store
+ * @ptr:	Pointer to domain specific data
+ * @iobase:	Domain specific IOmem pointer
+ *
+ * The content of this data is implementation defined and used by the MSI
+ * domain to store domain specific information which is requried for
+ * interrupt chip callbacks.
+ */
+union msi_domain_cookie {
+	u64	value;
+	void	*ptr;
+	void	__iomem *iobase;
+};
+
+/**
+ * struct msi_desc_data - Generic MSI descriptor data
+ * @dcookie:	Cookie for MSI domain specific data which is required
+ *		for irq_chip callbacks
+ * @icookie:	Cookie for the MSI interrupt instance provided by
+ *		the usage site to the allocation function
+ *
+ * The content of this data is implementation defined, e.g. PCI/IMS
+ * implementations define the meaning of the data. The MSI core ignores
+ * this data completely.
+ */
+struct msi_desc_data {
+	union msi_domain_cookie		dcookie;
+	union msi_instance_cookie	icookie;
+};
+
 #define MSI_MAX_INDEX		((unsigned int)USHRT_MAX)
 
 /**
@@ -142,6 +174,7 @@ struct pci_msi_desc {
  *
  * @msi_index:	Index of the msi descriptor
  * @pci:	PCI specific msi descriptor data
+ * @data:	Generic MSI descriptor data
  */
 struct msi_desc {
 	/* Shared device/bus type independent data */
@@ -161,7 +194,10 @@ struct msi_desc {
 	void *write_msi_msg_data;
 
 	u16				msi_index;
-	struct pci_msi_desc		pci;
+	union {
+		struct pci_msi_desc	pci;
+		struct msi_desc_data	data;
+	};
 };
 
 /*
--- a/include/linux/msi_api.h
+++ b/include/linux/msi_api.h
@@ -19,6 +19,23 @@ enum msi_domain_ids {
 };
 
 /**
+ * union msi_instance_cookie - MSI instance cookie
+ * @value:	u64 value store
+ * @ptr:	Pointer to usage site specific data
+ *
+ * This cookie is handed to the IMS allocation function and stored in the
+ * MSI descriptor for the interrupt chip callbacks.
+ *
+ * The content of this cookie is MSI domain implementation defined.  For
+ * PCI/IMS implementations this could be a PASID or a pointer to queue
+ * memory.
+ */
+union msi_instance_cookie {
+	u64	value;
+	void	*ptr;
+};
+
+/**
  * msi_map - Mapping between MSI index and Linux interrupt number
  * @index:	The MSI index, e.g. slot in the MSI-X table or
  *		a software managed index if >= 0. If negative

