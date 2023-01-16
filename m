Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C9566CEB8
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jan 2023 19:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbjAPSYs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Jan 2023 13:24:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbjAPSYX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Jan 2023 13:24:23 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BED2202D;
        Mon, 16 Jan 2023 10:11:36 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673892694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AanC++QDp2/X9tKXMo/J9VwlKZ5d4eXbHEb+Q9Hnt7o=;
        b=y1ss6IxNbaBwoK/nSkiLVMK4xhBf4eEI4RJ2YAzKPab3tb+jXZIoYMhsoO1NxUetPzCoON
        jZturUXmt9NPLQChCJa8JGbKCOEVkmoE06aITmvClYb/XxbCvmNX/5/GTelHascVot5VUa
        e6eHDsSGQlWscVdYEtzQmJwBSr0VVDGXDIDN3MmFK9shs26olpIog+nrDAfiwQMKfbOM+g
        VzIx24GxtcwRguX46n7TBbG3r0k666yT+H/aOaYlG0AJbAuEtW/kMNaTCZe+g8L0XBNjOl
        UR+pytkgpLdn5NbDl5lAm6MaZhTW6Y5+gVWQ5jTbDh8UMpjdyNic6bN7tJhEvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673892694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AanC++QDp2/X9tKXMo/J9VwlKZ5d4eXbHEb+Q9Hnt7o=;
        b=HIExVyuSu/+qg+7fM4/RkuaqgVgj503pGwc+sZraedRyuaXA+hHMtu78thc97w5zv8R+Bf
        XUhFu5GGulLb5lBw==
To:     David Woodhouse <dwmw2@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Juergen Gross <jgross@suse.com>,
        xen-devel <xen-devel@lists.xen.org>
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
Subject: Re: [patch V3 16/22] genirq/msi: Provide new domain id based
 interfaces for freeing interrupts
In-Reply-To: <875yd6o2t7.ffs@tglx>
References: <20221124225331.464480443@linutronix.de>
 <20221124230314.337844751@linutronix.de>
 <1901d84f8f999ac6b2f067360f098828cb8c17cf.camel@infradead.org>
 <875yd6o2t7.ffs@tglx>
Date:   Mon, 16 Jan 2023 19:11:32 +0100
Message-ID: <871qnunycr.ffs@tglx>
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

David!

On Mon, Jan 16 2023 at 17:35, Thomas Gleixner wrote:
> On Mon, Jan 16 2023 at 09:56, David Woodhouse wrote:
>
> This is just wrong. I need to taxi my grandson. Will have a look
> afterwards.

There are three 'tglx missed to fixup XEN' problems:

 - b2bdda205c0c ("PCI/MSI: Let the MSI core free descriptors")

   This requires the MSI_FLAG_FREE_MSI_DESCS flag to be set in the XEN
   MSI domain info


 - 2f2940d16823 ("genirq/msi: Remove filter from msi_free_descs_free_range()")

   This requires the 'desc->irq = 0' disassociation on teardown.


 - ffd84485e6be ("PCI/MSI: Let the irq code handle sysfs groups")

   Lacks a flag in the XEN MSI domain info as well.

Combo patch below.

Thanks,

        tglx
---
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -392,6 +392,7 @@ static void xen_teardown_msi_irqs(struct
 	msi_for_each_desc(msidesc, &dev->dev, MSI_DESC_ASSOCIATED) {
 		for (i = 0; i < msidesc->nvec_used; i++)
 			xen_destroy_irq(msidesc->irq + i);
+		msidesc->irq = 0;
 	}
 }
 
@@ -434,6 +435,7 @@ static struct msi_domain_ops xen_pci_msi
 
 static struct msi_domain_info xen_pci_msi_domain_info = {
 	.ops			= &xen_pci_msi_domain_ops,
+	.flags			= MSI_FLAG_FREE_MSI_DESCS | MSI_FLAG_DEV_SYSFS,
 };
 
 /*
