Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F24F632655
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 15:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbiKUOjQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 09:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbiKUOiN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 09:38:13 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A209FC7687;
        Mon, 21 Nov 2022 06:38:12 -0800 (PST)
Message-ID: <20221121091327.604532862@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=1Ia7eZriEUpBkiV/NLqg7niZ6fMKSxoDJkKbYDvtHyI=;
        b=4ALiouWmVkPRnT0vTcSPsOaIdfz4pn6W50xbL45ycypOo/a78qwl3e4jYa9vI28IfBmqlD
        FDnvxoiuLyiB9PmRDyjIKiLV8pvbWdhvgwD0p/bSalOqrXyEs2OoXTWzXgAr4fdrshc4Gu
        g7e49ttJnijI06uYdFUELqJb6GFnAitKSHuT8tYoe3tt1nAdhJ/uRUqgQytgH2qkSBf5W1
        R+r+4+uvLWXIkylOfnDsRadgug9ShopI1nm54EloqDXQW/crZdZNZ7BpOPFQy9LDpYXiRV
        xreGFARzGdap8ROM1ZHuk1FQIm1MjhX/0/GOuCRkDhn/mCSEgPYOd6wRK9V9lQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=1Ia7eZriEUpBkiV/NLqg7niZ6fMKSxoDJkKbYDvtHyI=;
        b=AxaLkvG0WXuwHg5a829R4zwLLIr7zTby4dzJQ5g4oyZ1A/gtehkDNr3C+ECAXdMfwXzlIT
        YSlZB34oKn7fdsCA==
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
Subject: [patch V2 20/33] genirq/msi: Provide msi_domain_ops::prepare_desc()
References: <20221121083657.157152924@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 21 Nov 2022 15:38:11 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The existing MSI domain ops msi_prepare() and set_desc() turned out to be
unsuitable for implementing IMS support.

msi_prepare() does not operate on the MSI descriptors. set_desc() lacks
an irq_domain pointer and has a completely different purpose.

Introduce a prepare_desc() op which allows IMS implementations to amend an
MSI descriptor which was allocated by the core code, e.g. by adjusting the
iomem base or adding some data based on the allocated index. This is way
better than requiring that all IMS domain implementations preallocate the
MSI descriptor and then allocate the interrupt.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/msi.h |    6 +++++-
 kernel/irq/msi.c    |    3 +++
 2 files changed, 8 insertions(+), 1 deletion(-)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -402,6 +402,8 @@ struct msi_domain_info;
  * @msi_init:		Domain specific init function for MSI interrupts
  * @msi_free:		Domain specific function to free a MSI interrupts
  * @msi_prepare:	Prepare the allocation of the interrupts in the domain
+ * @prepare_desc:	Optional function to prepare the allocated MSI descriptor
+ *			in the domain
  * @set_desc:		Set the msi descriptor for an interrupt
  * @domain_alloc_irqs:	Optional function to override the default allocation
  *			function.
@@ -413,7 +415,7 @@ struct msi_domain_info;
  * @get_hwirq, @msi_init and @msi_free are callbacks used by the underlying
  * irqdomain.
  *
- * @msi_check, @msi_prepare and @set_desc are callbacks used by the
+ * @msi_check, @msi_prepare, @prepare_desc and @set_desc are callbacks used by the
  * msi_domain_alloc/free_irqs*() variants.
  *
  * @domain_alloc_irqs, @domain_free_irqs can be used to override the
@@ -436,6 +438,8 @@ struct msi_domain_ops {
 	int		(*msi_prepare)(struct irq_domain *domain,
 				       struct device *dev, int nvec,
 				       msi_alloc_info_t *arg);
+	void		(*prepare_desc)(struct irq_domain *domain, msi_alloc_info_t *arg,
+					struct msi_desc *desc);
 	void		(*set_desc)(msi_alloc_info_t *arg,
 				    struct msi_desc *desc);
 	int		(*domain_alloc_irqs)(struct irq_domain *domain,
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -1285,6 +1285,9 @@ static int __msi_domain_alloc_irqs(struc
 		if (WARN_ON_ONCE(allocated >= ctrl->nirqs))
 			return -EINVAL;
 
+		if (ops->prepare_desc)
+			ops->prepare_desc(domain, &arg, desc);
+
 		ops->set_desc(&arg, desc);
 
 		virq = __irq_domain_alloc_irqs(domain, -1, desc->nvec_used,

