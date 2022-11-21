Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00AC363261D
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 15:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbiKUOhU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 09:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbiKUOgl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 09:36:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9362C6D11;
        Mon, 21 Nov 2022 06:36:27 -0800 (PST)
Message-ID: <20221121083325.846660254@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=+CkTPHTMXOvRSl4YB673TzHqsVFLjHUDowE8deLkwuw=;
        b=zV8w1tsStuX6XpptBJYxfR/+top3jj9uLazwOM4LRF4mOE0WH71cTpcWF13zcM9azFKYGG
        n/NlPSy3li4+/81QJ7uLjbotwoeDCCkqcKocTWCJCZj8wCvqAfvFrFR3Ebo46e4tmuN5M9
        coCDxseOpxTiaFZaPqh1yomqRBzLa9bk4GZiP6E3hRq3BlGNMkCYMhbUc5Q8S92nf8Ioka
        1U2niNxlRISp2fhx/2JbGRCxyq+JdehVWrc2aBpNTspddQZvlGLgEgFuthyIAjH9kHqp/e
        //M9aKh3z2LcrtbCvHWpw/U/a18yIoikzOq6omMcr41tPkURgtyEEFeCoYMFKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=+CkTPHTMXOvRSl4YB673TzHqsVFLjHUDowE8deLkwuw=;
        b=Dy8ze2Ov2RrLoLEbR8EjWXrxDOY3VkF3/JAWrN7RTBPFmdy+I9uhjCYlI5C59VeO8E1J1u
        t71IP+PC25I8S5Dg==
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
Subject: [patch V2 06/21] genirq/irqdomain: Provide IRQ_DOMAIN_FLAG_MSI_DEVICE
References: <20221121083210.309161925@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 21 Nov 2022 15:36:25 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Similar to marking parent MSI domains it's required to identify per device
domains. Add flag and helpers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/irqdomain.h |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -192,6 +192,9 @@ enum {
 	/* Irq domain is a MSI parent domain */
 	IRQ_DOMAIN_FLAG_MSI_PARENT	= (1 << 8),
 
+	/* Irq domain is a MSI device domain */
+	IRQ_DOMAIN_FLAG_MSI_DEVICE	= (1 << 9),
+
 	/*
 	 * Flags starting from IRQ_DOMAIN_FLAG_NONCORE are reserved
 	 * for implementation specific purposes and ignored by the
@@ -559,6 +562,11 @@ static inline bool irq_domain_is_msi_par
 	return domain->flags & IRQ_DOMAIN_FLAG_MSI_PARENT;
 }
 
+static inline bool irq_domain_is_msi_device(struct irq_domain *domain)
+{
+	return domain->flags & IRQ_DOMAIN_FLAG_MSI_DEVICE;
+}
+
 #else	/* CONFIG_IRQ_DOMAIN_HIERARCHY */
 static inline int irq_domain_alloc_irqs(struct irq_domain *domain,
 			unsigned int nr_irqs, int node, void *arg)
@@ -609,6 +617,11 @@ static inline bool irq_domain_is_msi_par
 {
 	return false;
 }
+
+static inline bool irq_domain_is_msi_device(struct irq_domain *domain)
+{
+	return false;
+}
 
 #endif	/* CONFIG_IRQ_DOMAIN_HIERARCHY */
 

