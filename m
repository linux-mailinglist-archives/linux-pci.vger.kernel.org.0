Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41437638158
	for <lists+linux-pci@lfdr.de>; Fri, 25 Nov 2022 00:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiKXXYP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 18:24:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiKXXYO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 18:24:14 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7E0827E2;
        Thu, 24 Nov 2022 15:24:12 -0800 (PST)
Message-ID: <20221124230313.514944367@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669332250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=E6KtSq0yDLolu/6n+fAhU+2bN1LDYJtV3H1STAwY1WQ=;
        b=KJJP4jXO3RasUS8renS6GVmVmQ0MB5FfbXPd8ZWPRiDL3ULsUmPGFHuKXiHpfhuoCG1m60
        qoWcuPvcoKAVEGBwyeRMNu9GMFOHGpzSISSi5lVjuTVvj9nbIAgj8jwSZXf1dSCIePSnjs
        ZSPNTb1qo4bIMXpFOY1n7YYUC/Yw2egyVybXIMRSgKmWyTw4MKTuVr+ZFyDbCjvDVzdkqX
        UjSxGZNZ3/8PXP6FbOCxVogPZZ+a34VyGpU/jeQJDcy2QAT8Az9ovDGtbhzPHwunrGzBNE
        ZfGhdlLvYKnw8AgZJBRpqnevU8GGTqje684EvYBtSZUkR50Feusp9nfvN/E8bw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669332250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=E6KtSq0yDLolu/6n+fAhU+2bN1LDYJtV3H1STAwY1WQ=;
        b=qV8kqaMKeFqZjy0WvnWdhBesY63o7uofR1MPkDLTnzigkD3bRwqKlgYSYmu7gXQQWhKDRL
        wYuJ96fWRuBRxVDw==
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
Subject: [patch V3 02/22] genirq/irqdomain: Make struct irqdomain readable
References: <20221124225331.464480443@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 25 Nov 2022 00:24:10 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Tabular alignment of both kernel-doc and the actual struct declaration make
visual parsing way more conveniant.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Split out from the irqdomain::dev rename patch (Jason)
---
 include/linux/irqdomain.h |   74 +++++++++++++++++++++++-----------------------
 1 file changed, 37 insertions(+), 37 deletions(-)

--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -117,53 +117,53 @@ struct irq_domain_chip_generic;
 
 /**
  * struct irq_domain - Hardware interrupt number translation object
- * @link: Element in global irq_domain list.
- * @name: Name of interrupt domain
- * @ops: pointer to irq_domain methods
- * @host_data: private data pointer for use by owner.  Not touched by irq_domain
- *             core code.
- * @flags: host per irq_domain flags
- * @mapcount: The number of mapped interrupts
+ * @link:	Element in global irq_domain list.
+ * @name:	Name of interrupt domain
+ * @ops:	Pointer to irq_domain methods
+ * @host_data:	Private data pointer for use by owner.  Not touched by irq_domain
+ *		core code.
+ * @flags:	Per irq_domain flags
+ * @mapcount:	The number of mapped interrupts
  *
- * Optional elements
- * @fwnode: Pointer to firmware node associated with the irq_domain. Pretty easy
- *          to swap it for the of_node via the irq_domain_get_of_node accessor
- * @gc: Pointer to a list of generic chips. There is a helper function for
- *      setting up one or more generic chips for interrupt controllers
- *      drivers using the generic chip library which uses this pointer.
- * @dev: Pointer to a device that the domain represent, and that will be
- *       used for power management purposes.
- * @parent: Pointer to parent irq_domain to support hierarchy irq_domains
+ * Optional elements:
+ * @fwnode:	Pointer to firmware node associated with the irq_domain. Pretty easy
+ *		to swap it for the of_node via the irq_domain_get_of_node accessor
+ * @gc:		Pointer to a list of generic chips. There is a helper function for
+ *		setting up one or more generic chips for interrupt controllers
+ *		drivers using the generic chip library which uses this pointer.
+ * @dev:	Pointer to a device that can be utilized for power management
+ *		purposes related to the irq domain.
+ * @parent:	Pointer to parent irq_domain to support hierarchy irq_domains
  *
- * Revmap data, used internally by irq_domain
- * @revmap_size: Size of the linear map table @revmap[]
- * @revmap_tree: Radix map tree for hwirqs that don't fit in the linear map
- * @revmap_mutex: Lock for the revmap
- * @revmap: Linear table of irq_data pointers
+ * Revmap data, used internally by the irq domain code:
+ * @revmap_size:	Size of the linear map table @revmap[]
+ * @revmap_tree:	Radix map tree for hwirqs that don't fit in the linear map
+ * @revmap_mutex:	Lock for the revmap
+ * @revmap:		Linear table of irq_data pointers
  */
 struct irq_domain {
-	struct list_head link;
-	const char *name;
-	const struct irq_domain_ops *ops;
-	void *host_data;
-	unsigned int flags;
-	unsigned int mapcount;
+	struct list_head		link;
+	const char			*name;
+	const struct irq_domain_ops	*ops;
+	void				*host_data;
+	unsigned int			flags;
+	unsigned int			mapcount;
 
 	/* Optional data */
-	struct fwnode_handle *fwnode;
-	enum irq_domain_bus_token bus_token;
-	struct irq_domain_chip_generic *gc;
-	struct device *dev;
+	struct fwnode_handle		*fwnode;
+	enum irq_domain_bus_token	bus_token;
+	struct irq_domain_chip_generic	*gc;
+	struct device			*dev;
 #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
-	struct irq_domain *parent;
+	struct irq_domain		*parent;
 #endif
 
 	/* reverse map data. The linear map gets appended to the irq_domain */
-	irq_hw_number_t hwirq_max;
-	unsigned int revmap_size;
-	struct radix_tree_root revmap_tree;
-	struct mutex revmap_mutex;
-	struct irq_data __rcu *revmap[];
+	irq_hw_number_t			hwirq_max;
+	unsigned int			revmap_size;
+	struct radix_tree_root		revmap_tree;
+	struct mutex			revmap_mutex;
+	struct irq_data __rcu		*revmap[];
 };
 
 /* Irq domain flags */

