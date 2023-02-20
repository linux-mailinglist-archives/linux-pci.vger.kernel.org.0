Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDE969D2E6
	for <lists+linux-pci@lfdr.de>; Mon, 20 Feb 2023 19:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbjBTSn3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Feb 2023 13:43:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbjBTSn2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Feb 2023 13:43:28 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92607B46F;
        Mon, 20 Feb 2023 10:43:26 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676918604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3GJstKrfvyA8WSRqNcmXOcPWiJSvltdM7jv/QCmpHbw=;
        b=VjjnGWGPUBl95Lnj89MykR1iV1NreRdrDL/fhxObaIELpKbzcsTfLaXeqOiQmoIo6YBv6y
        FIPlHN1WG2MkJ2Jd/2HIQF+9jFwmFF7MnXzZp9rYC8Jz6wcGAcpG1Coo0fNHS2oS0v9ulY
        F+fujCgCr6fIYB5Jl4Zg6ENr91LT+q2DtJyNWWjnJU0vUlnOhpzW+BByoB2Iqm1AjmwWE9
        PCvi2B7YZvGt72LtShbr5zDbLRPzMr/GMjutYbc9dgCF4EQonywUsKKIdtPNCw902L2wLE
        5+XUcHEqHTISkNEtJp78XV3kA7a2JGgvKrjajwlFLa9aXTWsIt0sbg/4Jobo8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676918604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3GJstKrfvyA8WSRqNcmXOcPWiJSvltdM7jv/QCmpHbw=;
        b=JGM0MYFczgf1SKnkK9ja49sEmUJsbM2LXLGpCj5DvKOYxXYWpGeRBuwnrwYHlNTJ88RQuE
        Gnfwd0T2kL0TwjAQ==
To:     Marc Zyngier <maz@kernel.org>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>
Subject: Re: [REGRESSION] Re: [patch V3 09/33] genirq/msi: Add range
 checking to msi_insert_desc()
In-Reply-To: <86fsb0xkaa.wl-maz@kernel.org>
References: <20221124230505.073418677@linutronix.de>
 <20221124232325.798556374@linutronix.de>
 <Y/Opu6ETe3ZzZ/8E@shell.armlinux.org.uk> <86fsb0xkaa.wl-maz@kernel.org>
Date:   Mon, 20 Feb 2023 19:43:24 +0100
Message-ID: <87y1osp48j.ffs@tglx>
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

On Mon, Feb 20 2023 at 18:29, Marc Zyngier wrote:
> diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
> index 783a3e6a0b10..13d96495e6d0 100644
> --- a/kernel/irq/msi.c
> +++ b/kernel/irq/msi.c
> @@ -1084,10 +1084,13 @@ int msi_domain_populate_irqs(struct irq_domain *domain, struct device *dev,
>  	struct xarray *xa;
>  	int ret, virq;
>  
> -	if (!msi_ctrl_valid(dev, &ctrl))
> -		return -EINVAL;
> -
>  	msi_lock_descs(dev);
> +
> +	if (!msi_ctrl_valid(dev, &ctrl)) {
> +		ret = -EINVAL;
> +		goto unlock;
> +	}
> +
>  	ret = msi_domain_add_simple_msi_descs(dev, &ctrl);
>  	if (ret)
>  		goto unlock;

Yup, you beat me by a minute :)
