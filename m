Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69A5B23BE08
	for <lists+linux-pci@lfdr.de>; Tue,  4 Aug 2020 18:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbgHDQWe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Aug 2020 12:22:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:35124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729784AbgHDQW0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 Aug 2020 12:22:26 -0400
Received: from localhost (mobile-166-175-186-42.mycingular.net [166.175.186.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 005462070A;
        Tue,  4 Aug 2020 16:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596558145;
        bh=QPah22Jpf1mxNKlgumRygQ+6pg3gt/DjX6c+YL5SJfc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=phX5p8kTYUiPjBezb0Ti6tRvIsmv3KLgGOP6IdfLAU4ZQmDakl7Vvhxxj4scJ6KnC
         2gY90fRDAzUWLx07WNy8MMMoMGnleoIR6//dB+kHu7u1/+R7Eejh7rxm8vCOUktprP
         1IJB4TRLbureddgFq3oi6uO+LcPsHxBhv1lCIC+4=
Date:   Tue, 4 Aug 2020 11:22:23 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: rcar-gen2: Fix crash in resource_list_first_type()
Message-ID: <20200804162223.GA420993@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804161325.GA11104@e121166-lin.cambridge.arm.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 04, 2020 at 05:13:25PM +0100, Lorenzo Pieralisi wrote:
> On Tue, Aug 04, 2020 at 02:04:30PM +0200, Geert Uytterhoeven wrote:
> > The conversion to modern host bridge probing made the driver allocate
> > its private data using devm_pci_alloc_host_bridge(), but forgot to
> > remove the old allocation.  Hence part of the driver initialization is
> > done using the new instance, while another part is done using the old
> > instance, leading to a crash due to uninitialized bridge DMA ranges:
> > 
> >     Unable to handle kernel NULL pointer dereference at virtual address 00000008
> >     pgd = (ptrval)
> >     [00000008] *pgd=00000000
> >     Internal error: Oops: 5 [#1] SMP ARM
> >     CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.8.0-rc1-shmobile-00035-g92d69cc6275845a7 #645
> >     Hardware name: Generic R-Car Gen2 (Flattened Device Tree)
> >     PC is at rcar_pci_probe+0x154/0x340
> >     LR is at _raw_spin_unlock_irqrestore+0x18/0x20
> > 
> > Fix this by dropping the old allocation.
> > 
> > Fixes: 92d69cc6275845a7 ("PCI: rcar-gen2: Convert to use modern host bridge probe functions")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> >  drivers/pci/controller/pci-rcar-gen2.c | 4 ----
> >  1 file changed, 4 deletions(-)
> 
> Squashed in the initial commit, pushed out on pci/misc.

I updated my 'next' branch with this.

Rob, are there any similar issues in other drivers that we should fix
before asking Linus to pull this?

> > diff --git a/drivers/pci/controller/pci-rcar-gen2.c b/drivers/pci/controller/pci-rcar-gen2.c
> > index 046965d284a6d54e..c9530038ca9a53fc 100644
> > --- a/drivers/pci/controller/pci-rcar-gen2.c
> > +++ b/drivers/pci/controller/pci-rcar-gen2.c
> > @@ -302,10 +302,6 @@ static int rcar_pci_probe(struct platform_device *pdev)
> >  	if (mem_res->start & 0xFFFF)
> >  		return -EINVAL;
> >  
> > -	priv = devm_kzalloc(dev, sizeof(struct rcar_pci_priv), GFP_KERNEL);
> > -	if (!priv)
> > -		return -ENOMEM;
> > -
> >  	priv->mem_res = *mem_res;
> >  	priv->cfg_res = cfg_res;
> >  
> > -- 
> > 2.17.1
> > 
