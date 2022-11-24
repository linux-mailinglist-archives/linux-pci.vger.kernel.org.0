Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E66E63819C
	for <lists+linux-pci@lfdr.de>; Fri, 25 Nov 2022 00:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiKXX3T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 18:29:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiKXX2q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 18:28:46 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89117A659B;
        Thu, 24 Nov 2022 15:27:11 -0800 (PST)
Message-ID: <20221124232326.444560717@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669332377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=SwZQXuxaOnLugPp7faog3c8WnwPvQUn41gyOKCZSnRg=;
        b=z/qUj+0ZX580lDfONL6nr+qyUfMMm+bqwfYDl3W0KqLSqd1NP4i6neAwJybpfqu8swNAXn
        VHPxTVfg/R0+HDZ5NeoOaAogMPL7LGi96EnA1kTIEn/QgHPP0ljuHKtyQXcat2Gb+VNdl7
        pzBncxrUqou4blZzJ0sNFSUwbn0xGDORcf8GGwppOxsGp0Q+f51bLNQlI4mHTMOwnZNtOG
        tGhKSbUmH/pEn40O4efPSXEMRFJqz2HqplLt6FWKCfPTDs2ODY2qMzo0fam+ofvhpj3Ucn
        QJCX3Gwm+xNkwWI94KR0oDF0ym7Wr6Wwj2TqVsWqrAJmavVuj48GBBAhzUssFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669332377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=SwZQXuxaOnLugPp7faog3c8WnwPvQUn41gyOKCZSnRg=;
        b=VVq7nShsZR+BBAI9DISoLr6eYJjlRI40UorrLD+fHB21R+wkHEydKh7dWrYS+rrFOYOZDr
        bPtALm88nUIlFtAQ==
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
Subject: [patch V3 20/33] genirq/msi: Provide msi_domain_ops::prepare_desc()
References: <20221124230505.073418677@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 25 Nov 2022 00:26:16 +0100 (CET)
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
@@ -410,6 +410,8 @@ struct msi_domain_info;
  * @msi_init:		Domain specific init function for MSI interrupts
  * @msi_free:		Domain specific function to free a MSI interrupts
  * @msi_prepare:	Prepare the allocation of the interrupts in the domain
+ * @prepare_desc:	Optional function to prepare the allocated MSI descriptor
+ *			in the domain
  * @set_desc:		Set the msi descriptor for an interrupt
  * @domain_alloc_irqs:	Optional function to override the default allocation
  *			function.
@@ -421,7 +423,7 @@ struct msi_domain_info;
  * @get_hwirq, @msi_init and @msi_free are callbacks used by the underlying
  * irqdomain.
  *
- * @msi_check, @msi_prepare and @set_desc are callbacks used by the
+ * @msi_check, @msi_prepare, @prepare_desc and @set_desc are callbacks used by the
  * msi_domain_alloc/free_irqs*() variants.
  *
  * @domain_alloc_irqs, @domain_free_irqs can be used to override the
@@ -444,6 +446,8 @@ struct msi_domain_ops {
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
@@ -1260,6 +1260,9 @@ static int __msi_domain_alloc_irqs(struc
 		if (WARN_ON_ONCE(allocated >= ctrl->nirqs))
 			return -EINVAL;
 
+		if (ops->prepare_desc)
+			ops->prepare_desc(domain, &arg, desc);
+
 		ops->set_desc(&arg, desc);
 
 		virq = __irq_domain_alloc_irqs(domain, -1, desc->nvec_used,

