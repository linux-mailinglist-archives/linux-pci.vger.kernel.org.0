Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1BB664011
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jan 2023 13:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbjAJMPu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Jan 2023 07:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233237AbjAJMPX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Jan 2023 07:15:23 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719432009;
        Tue, 10 Jan 2023 04:14:02 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673352841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X2y9vD/h9xsyVCCbYvsCOwthcc+ZcX9CU02bbo8R6CQ=;
        b=PUOkQzoUAGGJ4BpHkJjmDf07TJY/lmgnLXhHyJAks6BCusPHr1YB6/l3Q2EglShcExeYGe
        UjK3eXjfcy+GHfOyK26R3U+2mGvtPdTxMhuyYgQf1zSZdcxs69HIknLbq9etp+iyyTU8kF
        bnBf1FwMnEsYGnL+bVTR54Uxky7VunE9KyN79pSn7UiFcsrumtK7IbOPzVeAf60CtpBbF/
        FEI6ZN00/sACv8Iq/Uz+8Q/u2LxVpII/mCwzuexnbBvEtfj7s5r+GFpgYqSmwA904BBsMi
        76BrikmeiQwTE+BzDbRxm1lQfTwE6p21SRTulzDwLDf7XQ4ZFRYLS5i6MBx5JA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673352841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X2y9vD/h9xsyVCCbYvsCOwthcc+ZcX9CU02bbo8R6CQ=;
        b=OMgBgUG7u5Pt/4nPkHDS1N7iBV2Aa2YurZvaMgpVFEazX91Hjqij9da/dHRwRylC9easFY
        PFWkhWLhADrH7QCQ==
To:     Jason Gunthorpe <jgg@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>,
        Shay Drory <shayd@nvidia.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>
Subject: Re: [patch V3 13/33] x86/apic/vector: Provide MSI parent domain
In-Reply-To: <Y7VyXNbWMdWWAC6d@nvidia.com>
References: <20221124230505.073418677@linutronix.de>
 <20221124232326.034672592@linutronix.de> <Y7VyXNbWMdWWAC6d@nvidia.com>
Date:   Tue, 10 Jan 2023 13:14:00 +0100
Message-ID: <87eds2k2nr.ffs@tglx>
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

Jason,

On Wed, Jan 04 2023 at 08:34, Jason Gunthorpe wrote:
> Our test team has discovered some kmem leak complaints on rc1 and
> bisected it to this patch.
>
> I don't see an obvious way that fwnode gets destroyed here. So maybe
> it should be like this?
>
> diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
> index 955267bbc2be63..cbbcb7fd2bd00d 100644
> --- a/kernel/irq/msi.c
> +++ b/kernel/irq/msi.c
> @@ -1000,7 +1000,7 @@ bool msi_create_device_irq_domain(struct device *dev, unsigned int domid,
>  fail:
>  	msi_unlock_descs(dev);
>  free_fwnode:
> -	kfree(fwnode);
> +	irq_domain_free_fwnode(fwnode); // ???

That's correct. kfree(fwnode) leaks fwnode->name

>  free_bundle:
>  	kfree(bundle);
>  	return false;
> @@ -1013,6 +1013,7 @@ bool msi_create_device_irq_domain(struct device *dev, unsigned int domid,
>   */
>  void msi_remove_device_irq_domain(struct device *dev, unsigned int domid)
>  {
> +	struct fwnode_handle *fwnode = NULL;
>  	struct msi_domain_info *info;
>  	struct irq_domain *domain;
>  
> @@ -1025,7 +1026,10 @@ void msi_remove_device_irq_domain(struct device *dev, unsigned int domid)
>  
>  	dev->msi.data->__domains[domid].domain = NULL;
>  	info = domain->host_data;
> +	if (domain->flags & IRQ_DOMAIN_FLAG_MSI_DEVICE)
> +		fwnode = domain->fwnode;

irq_domain_is_msi_device() ?

>  	irq_domain_remove(domain);
> +	irq_domain_free_fwnode(fwnode);

For some reason I thought the fwnode would be handled by
irq_domain_remove() but fwnode_handle_put() is a NOP for the named
fwnodes.

Care to send a proper patch with changelog?

Thanks,

        tglx
