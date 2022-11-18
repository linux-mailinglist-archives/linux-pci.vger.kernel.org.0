Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1014762F33E
	for <lists+linux-pci@lfdr.de>; Fri, 18 Nov 2022 12:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241403AbiKRLGg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Nov 2022 06:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241863AbiKRLGG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2022 06:06:06 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62089A276;
        Fri, 18 Nov 2022 03:05:46 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668769533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EVVAosUWK8z20yBPx1LIGfuF64DUmtj9IiaYKPz+3/M=;
        b=JCv/Rho2DeTZ2qPuNUgbQsms6u8pR3sZmHNqHWV+vn3CjUYUVvT3JwyffUH31dYFngZgqH
        VtW0OsxPNinB9qQqX3NkBOFAIHSFwiEUNDeG75lP+8wZQLT8AIDyhHMYqPfJV1nYUdLfke
        7BKkCnioevmRw35Y/YXDWzxomgZzKByjJfNQU3406ckJU6QUTuX50FiFiZ783WBKW/PNDt
        XlOucyxT99/xnanXI7JpOszwEjyW31jpQQgm2QUD0DeVx2qp8dlVqkoKDdQ/W9Sym1gprq
        gq/RXRdNDb6/hXDCN6cbhsxwQGS3dhGKqinEa4brO8CABGTJj4npXRnWcecriw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668769533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EVVAosUWK8z20yBPx1LIGfuF64DUmtj9IiaYKPz+3/M=;
        b=q4+/YWi0t+KRX5ebYkZ0rqXvEsNCPwvgo2TesyaqrEHHpqOkyBXCTxxqQzebLtO/YzMfj3
        crHGT7OU5SPak9CA==
To:     Reinette Chatre <reinette.chatre@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
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
        "Ahmed S. Darwish" <darwi@linutronix.de>
Subject: Re: [patch 21/33] genirq/msi: Provide msi_domain_alloc_irq_at()
In-Reply-To: <87zgcok4i2.ffs@tglx>
References: <20221111133158.196269823@linutronix.de>
 <20221111135206.463650635@linutronix.de>
 <0cbf645b-b23a-6c85-4389-bb039a677a52@intel.com> <87k03tkrii.ffs@tglx>
 <87zgcok4i2.ffs@tglx>
Date:   Fri, 18 Nov 2022 12:05:33 +0100
Message-ID: <87wn7sjzeq.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 18 2022 at 10:15, Thomas Gleixner wrote:
> On Fri, Nov 18 2022 at 01:58, Thomas Gleixner wrote:
> Of course I "tested" this by flipping default and secondary domain
> around and doing dynamic allocations from PCI/MSI-X but that won't catch
> the bug because PCI/MSI-X does not have the ALLOC_SIMPLE_DESCS flag set.
>
> Let me fix that.

Delta patch against

  git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git devmsi-v1G-part3

below.

Thanks,

        tglx
---
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index d4f26649a185..d243ad3e5489 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -141,7 +141,7 @@ static int msi_insert_desc(struct device *dev, struct msi_desc *desc,
 		if (ret)
 			goto fail;
 
-		desc->msi_index = index;
+		desc->msi_index = index - baseidx;
 		return 0;
 	} else {
 		if (index >= hwsize) {
@@ -1476,9 +1476,10 @@ struct msi_map msi_domain_alloc_irq_at(struct device *dev, unsigned int domid, u
 				       const struct irq_affinity_desc *affdesc,
 				       union msi_dev_cookie *cookie)
 {
+	struct msi_ctrl ctrl = { .domid	= domid, .nirqs = 1, };
+	struct msi_domain_info *info;
 	struct irq_domain *domain;
 	struct msi_map map = { };
-	struct msi_desc *desc;
 	int ret;
 
 	msi_lock_descs(dev);
@@ -1503,12 +1504,16 @@ struct msi_map msi_domain_alloc_irq_at(struct device *dev, unsigned int domid, u
 		goto unlock;
 	}
 
-	map.index = desc->msi_index;
-	ret = msi_domain_alloc_irqs_range_locked(dev, domid, map.index, map.index);
-	if (ret)
+	ctrl.first = ctrl.last = desc->msi_index;
+	info = domain->host_data;
+
+	ret = __msi_domain_alloc_irqs(dev, domain, &ctrl);
+	if (ret) {
 		map.index = ret;
-	else
+		msi_domain_free_locked(dev, &ctrl);
+	} else {
 		map.virq = desc->irq;
+	}
 unlock:
 	msi_unlock_descs(dev);
 	return map;
