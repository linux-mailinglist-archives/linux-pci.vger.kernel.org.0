Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 162B1625C6E
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 15:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234402AbiKKOGp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 09:06:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234215AbiKKOGV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 09:06:21 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9091598BB8;
        Fri, 11 Nov 2022 05:59:40 -0800 (PST)
Message-ID: <20221111135206.346985384@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668175121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=UQ8wGaxCGGl6i2FWioqhnvUbaJkzVnC/Tizkv4RadYs=;
        b=InbvRLz2xiE1xSxHfoXRhru+XjEM5gfiGxuSEQ7Lcj/JvYVrWqnuRqCyOQbXgOZP3a+IrX
        afUht5oZxyk+AaXMsRFzV3gSY/hfw8vB9zcjWVluI96CJyotpxAVAo7mMcKjj54m9ID8aq
        muBCRnwtZ+4h/QIWJzK4dJnmMiBw/06/XhL8AxiR/qvLsmXNeHzJn01//ekakzNVQLEW2A
        enPEZxfcPxnxGzRc58QjjccMWsTbjSD3j5FMH6qVY/a4RRpkrBOYYz21mYNHPexZWNmQfo
        JKHFdxdT926RfGjIssN/mFK3I9DtOzBaQjuryH4M8Cvl05TXDLJpa+1WW38zqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668175122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=UQ8wGaxCGGl6i2FWioqhnvUbaJkzVnC/Tizkv4RadYs=;
        b=CZMuJlTc7yrU0Fd0ZAHupzdYF1YUnHqpbn+7nNNm+rX7yFmAGQs8NV5Ytqm12bxK2u1hDq
        ATinmN2jvy4w6rBg==
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
Subject: [patch 19/33] genirq/msi: Provide msi_desc::msi_data
References: <20221111133158.196269823@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 14:58:41 +0100 (CET)
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
 include/linux/msi.h     |   19 ++++++++++++++++++-
 include/linux/msi_api.h |   17 +++++++++++++++++
 2 files changed, 35 insertions(+), 1 deletion(-)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -121,6 +121,19 @@ struct pci_msi_desc {
 	};
 };
 
+/**
+ * struct msi_desc_data - Generic MSI descriptor data
+ * @iobase:     Pointer to the IOMEM base adress for interrupt callbacks
+ * @cookie:	Device cookie provided at allocation time
+ *
+ * The content of this data is implementation defined, e.g. PCI/IMS
+ * implementations will define the meaning of the data.
+ */
+struct msi_desc_data {
+	void			__iomem *iobase;
+	union msi_dev_cookie	cookie;
+};
+
 #define MSI_MAX_INDEX		((unsigned int)USHRT_MAX)
 
 /**
@@ -138,6 +151,7 @@ struct pci_msi_desc {
  *
  * @msi_index:	Index of the msi descriptor
  * @pci:	PCI specific msi descriptor data
+ * @data:	Generic MSI descriptor data
  */
 struct msi_desc {
 	/* Shared device/bus type independent data */
@@ -157,7 +171,10 @@ struct msi_desc {
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
+ * union msi_dev_cookie - MSI device cookie
+ * @value:	u64 value store
+ * @ptr:	Pointer
+ *
+ * This data is handed to the IMS allocation function and stored
+ * in the MSI descriptor for the interrupt chip callbacks.
+ *
+ * The content of this data is implementation defined, e.g. PCI/IMS
+ * implementations will define the meaning of the data, e.g. PASID or a
+ * pointer to queue memory.
+ */
+union msi_dev_cookie {
+	u64	value;
+	void	*ptr;
+};
+
+/**
  * msi_map - Mapping between MSI index and Linux interrupt number
  * @index:	The MSI index, e.g. slot in the MSI-X table or
  *		a software managed index if >= 0. If negative

