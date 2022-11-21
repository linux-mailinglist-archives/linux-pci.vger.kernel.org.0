Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBBD86326CC
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 15:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbiKUOtu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 09:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbiKUOsU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 09:48:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A34D39DF;
        Mon, 21 Nov 2022 06:42:15 -0800 (PST)
Message-ID: <20221121140049.428236986@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ZjMS9WKZ8Nf7BBjmdJgqdh2U6M/tG1SOi5dk7E2nC6I=;
        b=MDIYKt3etoFIKinLV4uhdFA14rWeIDqUD4/mRKjbmfM+4Iqd/Px6KJsQQe/7+IWoPySsgz
        0qW5kLK27fgOaV4YCrwZGWOwvmYFgzCMWQHARLfw8HBTGj0IeFkVdsRSdvKZ5GaYTzUt2p
        yRG/oM9ROxMOQM+uTYbveTKZkpE0wBfhPEVssvJLcnG4yvFkDAcsdPyvPKT7s5EdfMuCLJ
        7U57SCDUKTy03LNV3E5Xxr+wQDUNVdVCRznP6UPupga3oC2JHm/WbpdtgnbNhQTkvKhOrY
        Pp1q3SrH0gNVEYvtvpImy2evDpqQS5Q0VZGk1W42qZ/rLsTasvzO3gx68GQ1Fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ZjMS9WKZ8Nf7BBjmdJgqdh2U6M/tG1SOi5dk7E2nC6I=;
        b=I1Ve0rVuhE8WJ3sP02XIi7u8xPj1s7abVf0jjZdXnWbmsX1S0FNA8HTfl0exqssq029R+O
        QJqtB3V/lbjVchDQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Will Deacon <will@kernel.org>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Vinod Koul <vkoul@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Subject: [patch V2 18/40] genirq/msi: Provide optional translation op
References: <20221121135653.208611233@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 21 Nov 2022 15:39:51 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

irq_create_fwspec_mapping() requires translation of the firmware spec to a
hardware interrupt number and the trigger type information.

Wired interrupts which are connected to a wire to MSI bridge, like MBIGEN
are allocated that way. So far MBIGEN provides a regular irqdomain which
then hooks backwards into the MSI infrastructure. That's an unholy mess and
will be replaced with per device MSI domains which are regular MSI domains.

Interrupts on MSI domains are not supported by irq_create_fwspec_mapping(),
but for making the wire to MSI bridges sane it makes sense to provide a
special allocation/free interface in the MSI infrastructure. That avoids
the backdoors into the core MSI allocation code and just shares all the
regular MSI infrastructure.

Provide an optional translation callback in msi_domain_ops which can be
utilized by these wire to MSI bridges. No other MSI domain should provide a
translation callback. The default translation callback of the MSI
irqdomains will warn when it is invoked on a non-prepared MSI domain.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/msi.h |    5 +++++
 kernel/irq/msi.c    |   15 +++++++++++++++
 2 files changed, 20 insertions(+)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -393,6 +393,7 @@ bool arch_restore_msi_irqs(struct pci_de
 struct irq_domain;
 struct irq_domain_ops;
 struct irq_chip;
+struct irq_fwspec;
 struct device_node;
 struct fwnode_handle;
 struct msi_domain_info;
@@ -412,6 +413,8 @@ struct msi_domain_info;
  *			function.
  * @msi_post_free:	Optional function which is invoked after freeing
  *			all interrupts.
+ * @msi_translate:	Optional translate callback to support the odd wire to
+ *			MSI bridges, e.g. MBIGEN
  *
  * @get_hwirq, @msi_init and @msi_free are callbacks used by the underlying
  * irqdomain.
@@ -449,6 +452,8 @@ struct msi_domain_ops {
 					    struct device *dev);
 	void		(*msi_post_free)(struct irq_domain *domain,
 					 struct device *dev);
+	int		(*msi_translate)(struct irq_domain *domain, struct irq_fwspec *fwspec,
+					 irq_hw_number_t *hwirq, unsigned int *type);
 };
 
 /**
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -772,11 +772,26 @@ static void msi_domain_free(struct irq_d
 	irq_domain_free_irqs_top(domain, virq, nr_irqs);
 }
 
+static int msi_domain_translate(struct irq_domain *domain, struct irq_fwspec *fwspec,
+				irq_hw_number_t *hwirq, unsigned int *type)
+{
+	struct msi_domain_info *info = domain->host_data;
+
+	/*
+	 * This will catch allocations through the regular irqdomain path except
+	 * for MSI domains which really support this, e.g. MBIGEN.
+	 */
+	if (!info->ops->msi_translate)
+		return -ENOTSUPP;
+	return info->ops->msi_translate(domain, fwspec, hwirq, type);
+}
+
 static const struct irq_domain_ops msi_domain_ops = {
 	.alloc		= msi_domain_alloc,
 	.free		= msi_domain_free,
 	.activate	= msi_domain_activate,
 	.deactivate	= msi_domain_deactivate,
+	.translate	= msi_domain_translate,
 };
 
 static irq_hw_number_t msi_domain_ops_get_hwirq(struct msi_domain_info *info,

