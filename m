Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 558F745FBDD
	for <lists+linux-pci@lfdr.de>; Sat, 27 Nov 2021 03:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350870AbhK0CSS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Nov 2021 21:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350169AbhK0CQO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Nov 2021 21:16:14 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84ECC08EB4A;
        Fri, 26 Nov 2021 17:31:21 -0800 (PST)
Message-ID: <20211126232735.667572131@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637976245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=GUR2OxklGtF7nIOBqOyJrqx9CLAOqYt69MVFmzr2xdI=;
        b=cKgLO4a4W2aRQzVAo934uEapjOhZn8Bj4kyxmCwL0rMlASi1ooEg6rmu3nyE7dHBGYoyNa
        i173vH1Eo1GewdgOYE+5E/W3j2uaSVYubyfFtoB1BPa7/6pjVC8WQKs4/Wf8oOfwdcdw1p
        VdeU12XsNOtqaEfFbvX8B85l8AclW9HB2j7BfX0rMsy+k3vifIa5HObV6XJ6wKxuBw9dfH
        cZe0jscPJSDRc1gsnbUqvCM91uYXSLq0Kqt1YRdMJsUBxiwxzkh/G6Hifb4V1EIfFzyOEY
        tePkrt7hebc9ltcWRMuye8bgChL23xauqToDnBRUyGqGuFha4BFwBeoFrXF7Lw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637976245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=GUR2OxklGtF7nIOBqOyJrqx9CLAOqYt69MVFmzr2xdI=;
        b=KcVsOI1Fqy2xfuGKU2EcrntMCNHAJfGFyFTx84bzVgU3yQVaYRV/8r0a9dKwQUu/tdz1GU
        AY7NlwifFYLsNIAQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
Subject: [patch 23/32] soc: ti: ti_sci_inta_msi: Remove
 ti_sci_inta_msi_domain_free_irqs()
References: <20211126230957.239391799@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Nov 2021 02:24:04 +0100 (CET)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The function has no users and is pointless now that the core frees the MSI
descriptors, which means potential users can just use msi_domain_free_irqs().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/soc/ti/ti_sci_inta_msi.c       |    6 ------
 include/linux/soc/ti/ti_sci_inta_msi.h |    1 -
 2 files changed, 7 deletions(-)

--- a/drivers/soc/ti/ti_sci_inta_msi.c
+++ b/drivers/soc/ti/ti_sci_inta_msi.c
@@ -121,9 +121,3 @@ int ti_sci_inta_msi_domain_alloc_irqs(st
 	return ret;
 }
 EXPORT_SYMBOL_GPL(ti_sci_inta_msi_domain_alloc_irqs);
-
-void ti_sci_inta_msi_domain_free_irqs(struct device *dev)
-{
-	msi_domain_free_irqs(dev->msi.domain, dev);
-}
-EXPORT_SYMBOL_GPL(ti_sci_inta_msi_domain_free_irqs);
--- a/include/linux/soc/ti/ti_sci_inta_msi.h
+++ b/include/linux/soc/ti/ti_sci_inta_msi.h
@@ -18,5 +18,4 @@ struct irq_domain
 				   struct irq_domain *parent);
 int ti_sci_inta_msi_domain_alloc_irqs(struct device *dev,
 				      struct ti_sci_resource *res);
-void ti_sci_inta_msi_domain_free_irqs(struct device *dev);
 #endif /* __INCLUDE_LINUX_IRQCHIP_TI_SCI_INTA_H */

