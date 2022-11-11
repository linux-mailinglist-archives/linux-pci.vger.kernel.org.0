Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1BF6625B9E
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 14:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233708AbiKKNzU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 08:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233592AbiKKNyy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 08:54:54 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6610270183;
        Fri, 11 Nov 2022 05:54:30 -0800 (PST)
Message-ID: <20221111122014.120489922@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668174869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=uAK7e6YKYfE3NKk9044qCaJfhx6qFWH6i8PscALcCkU=;
        b=bhdG0eo2d5cR5NUOFj3Ienrsw5VPaTNHp3Q9tmXe+N2uBx5Zp/1epSUs7hD/C0G7eLrHaV
        +C8SctVO+X4BrGfCIZMTE0ojXzDO8B42XGVZas3NbDPd0Q/HPETWT9XKnO9F2VmwX6OV9S
        V668vy8p1CUipfcobFboZ4vTtAxDWK63IStDKwrOKRaBdhZFOak3Blp+nwAEE7pjT3xpcw
        ZLBLGCh74g5FftekR3u7YTxhlQ16TIYo++JJjAD0y7eaEOF/5GUbQq9RCpuQSBLyXzaAzV
        C/+4MDauiberZ+DV2mcdIIvqMMOnfOqSzRFvFsw2nuyv9tz7FHZ0r4CKPbYqkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668174869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=uAK7e6YKYfE3NKk9044qCaJfhx6qFWH6i8PscALcCkU=;
        b=CdnfXWBvUOFJUQvenC/sG/RoCl0EBsTovXNlHbcYl5w55OTi8OHqj96pgDXVqDNddziMC5
        Q0FyhLFGFQVlnUCw==
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
Subject: [patch 09/39] powerpc/pseries/msi: Use msi_domain_ops::msi_post_free()
References: <20221111120501.026511281@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 14:54:28 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use the new msi_post_free() callback which is invoked after the interrupts
have been freed to tell the hypervisor about the shutdown.

This allows to remove the exposure of __msi_domain_free_irqs().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/platforms/pseries/msi.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

--- a/arch/powerpc/platforms/pseries/msi.c
+++ b/arch/powerpc/platforms/pseries/msi.c
@@ -447,21 +447,18 @@ static void pseries_msi_ops_msi_free(str
  * RTAS can not disable one MSI at a time. It's all or nothing. Do it
  * at the end after all IRQs have been freed.
  */
-static void pseries_msi_domain_free_irqs(struct irq_domain *domain,
-					 struct device *dev)
+static void pseries_msi_post_free(struct irq_domain *domain, struct device *dev)
 {
 	if (WARN_ON_ONCE(!dev_is_pci(dev)))
 		return;
 
-	__msi_domain_free_irqs(domain, dev);
-
 	rtas_disable_msi(to_pci_dev(dev));
 }
 
 static struct msi_domain_ops pseries_pci_msi_domain_ops = {
 	.msi_prepare	= pseries_msi_ops_prepare,
 	.msi_free	= pseries_msi_ops_msi_free,
-	.domain_free_irqs = pseries_msi_domain_free_irqs,
+	.msi_post_free	= pseries_msi_post_free,
 };
 
 static void pseries_msi_shutdown(struct irq_data *d)

