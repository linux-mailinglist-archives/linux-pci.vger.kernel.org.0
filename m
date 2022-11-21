Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A47632654
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 15:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbiKUOjO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 09:39:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbiKUOiM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 09:38:12 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F86293737;
        Mon, 21 Nov 2022 06:38:11 -0800 (PST)
Message-ID: <20221121091327.546352933@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=TpR1wEbG/Wo0WW0drKjzPBv3GD8sCJ8ij4dxCieYEi4=;
        b=boEzxceGwga/4l4WI3M49ixM1qKuf902SAk5l7XjmXIUhMmHwHtoGn6S+cNno7lthH6f49
        FY0+6f0rhfZShW12K2hC6TDzMY8lOJt3KHWL7Cu0Te2OutLLD1a8iSCYWabqzTcnI8VkhI
        8VOGweAyq0indNR8ij7aveLxew6fiQkD4FgGWgY9K4if7FAgjI5g9tbBkptfOtznFHyS0u
        YnB9GPyenUjubrLD4hKPRfPM7RXkZbztGSo2X3xTZOgCU4W20NwnnKyL24WOeQ7fyLkRej
        D3Se01bEPRyunajWqPxzq++nZqP0watcRmuzsg853sY0mv+0GfFrkVflGH6D9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=TpR1wEbG/Wo0WW0drKjzPBv3GD8sCJ8ij4dxCieYEi4=;
        b=8SxTnGwUpnz/eHpEzw+XHQcUvf4J25tXxaf20pnh5OyYxflN/m2nfUssZYiI3+XzN9sLR3
        lpOhY2E5q68YH8Cw==
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
Subject: [patch V2 19/33] genirq/msi: Provide msi_desc::msi_data
References: <20221121083657.157152924@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 21 Nov 2022 15:38:09 +0100 (CET)
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

It contains a iomem pointer for device memory based IMS and a union of a
u64 and a void pointer which allows the device specific IMS implementations
to store the necessary information.

The iomem pointer is set up by the domain allocation functions.

The data union msi_dev_cookie is going to be handed in when allocating an
interrupt on an IMS domain so the irq chip callbacks of the IMS domain have
the necessary per vector information available. It also comes in handy when
cleaning up the platform MSI code for wire to MSI bridges which need to
hand down the type information to the underlying interrupt domain.

For the core code the cookie is opaque and meaningless. It just stores it
during an allocation through the upcoming interfaces for IMS and wire to
MSI brigdes.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
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

