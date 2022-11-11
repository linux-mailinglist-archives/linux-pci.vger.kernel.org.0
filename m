Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84755625BA4
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 14:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbiKKNz2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 08:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233678AbiKKNzN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 08:55:13 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B03A7299D;
        Fri, 11 Nov 2022 05:54:34 -0800 (PST)
Message-ID: <20221111122014.237221143@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668174872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=i6lv85ZNUn8jbTiqiaOVEezDOQ2OYDxW2lkZxbSQfPs=;
        b=43XNu7V6lxNjeSplgzaxAS44tgV1Hxus/MQ0Rod85yoWEU9uzoUV0/Gvo4MbkhRTwi9Tzn
        K+wX7sK78xcXVDD899/v4pK5j+RLz0Ao3nSp2UCpEepJa70aoQnMHmpP19VhP2+pwR4qww
        0tGVylR7vtiM38R3uV3EvetHi2nC3skf1+FL3cNo1DnnGoJtSoTvvwyivArsgTeJicRErs
        l1UHy/+fO39St2quL4Q1Hy4tm4W1uszLlCgDZRMWKSkBfgmRsWXid7/6U9QZn+s1br0VHF
        drP8Q36KtsFNrJNa9PZHRRkcIy1K7rYVmLVVutyERWy8ViXgAtWWWRTnnNlHgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668174872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=i6lv85ZNUn8jbTiqiaOVEezDOQ2OYDxW2lkZxbSQfPs=;
        b=r6FLcQ/XkDdVENpg6jrJnxOUENgvyAqRux+b2LWEAUoE54RxJtQQhVavaj2vznzl/JqrCy
        KnNE4MphZHlzBvCQ==
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
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [patch 11/39] genirq/irqdomain: Move bus token enum into a seperate header
References: <20221111120501.026511281@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 14:54:32 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Split the bus token defines out into a seperate header file to avoid
inclusion of irqdomain.h in msi.h.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/irqdomain.h      |   22 +---------------------
 include/linux/irqdomain_defs.h |   26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 21 deletions(-)

--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -31,6 +31,7 @@
 #define _LINUX_IRQDOMAIN_H
 
 #include <linux/types.h>
+#include <linux/irqdomain_defs.h>
 #include <linux/irqhandler.h>
 #include <linux/of.h>
 #include <linux/mutex.h>
@@ -68,27 +69,6 @@ struct irq_fwspec {
 void of_phandle_args_to_fwspec(struct device_node *np, const u32 *args,
 			       unsigned int count, struct irq_fwspec *fwspec);
 
-/*
- * Should several domains have the same device node, but serve
- * different purposes (for example one domain is for PCI/MSI, and the
- * other for wired IRQs), they can be distinguished using a
- * bus-specific token. Most domains are expected to only carry
- * DOMAIN_BUS_ANY.
- */
-enum irq_domain_bus_token {
-	DOMAIN_BUS_ANY		= 0,
-	DOMAIN_BUS_WIRED,
-	DOMAIN_BUS_GENERIC_MSI,
-	DOMAIN_BUS_PCI_MSI,
-	DOMAIN_BUS_PLATFORM_MSI,
-	DOMAIN_BUS_NEXUS,
-	DOMAIN_BUS_IPI,
-	DOMAIN_BUS_FSL_MC_MSI,
-	DOMAIN_BUS_TI_SCI_INTA_MSI,
-	DOMAIN_BUS_WAKEUP,
-	DOMAIN_BUS_VMD_MSI,
-};
-
 /**
  * struct irq_domain_ops - Methods for irq_domain objects
  * @match: Match an interrupt controller device node to a host, returns
--- /dev/null
+++ b/include/linux/irqdomain_defs.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_IRQDOMAIN_DEFS_H
+#define _LINUX_IRQDOMAIN_DEFS_H
+
+/*
+ * Should several domains have the same device node, but serve
+ * different purposes (for example one domain is for PCI/MSI, and the
+ * other for wired IRQs), they can be distinguished using a
+ * bus-specific token. Most domains are expected to only carry
+ * DOMAIN_BUS_ANY.
+ */
+enum irq_domain_bus_token {
+	DOMAIN_BUS_ANY		= 0,
+	DOMAIN_BUS_WIRED,
+	DOMAIN_BUS_GENERIC_MSI,
+	DOMAIN_BUS_PCI_MSI,
+	DOMAIN_BUS_PLATFORM_MSI,
+	DOMAIN_BUS_NEXUS,
+	DOMAIN_BUS_IPI,
+	DOMAIN_BUS_FSL_MC_MSI,
+	DOMAIN_BUS_TI_SCI_INTA_MSI,
+	DOMAIN_BUS_WAKEUP,
+	DOMAIN_BUS_VMD_MSI,
+};
+
+#endif /* _LINUX_IRQDOMAIN_DEFS_H */

