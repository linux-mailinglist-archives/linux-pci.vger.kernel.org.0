Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 948B244781E
	for <lists+linux-pci@lfdr.de>; Mon,  8 Nov 2021 02:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbhKHA7R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 7 Nov 2021 19:59:17 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:52753 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbhKHA7R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 7 Nov 2021 19:59:17 -0500
Received: by mail-wm1-f49.google.com with SMTP id o29so7915227wms.2;
        Sun, 07 Nov 2021 16:56:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uzZdeX9n4CyJZmzyZ7xBIA2ZTAOzXaTvEy5MtTKwtCk=;
        b=pUpTP480PzSdsbPGCurbIvVPxGZfEq15NSQiu7/xr93CtkidE7KfjCbI5HQANQn/VI
         QUr3yTPaUs5OJa2mqUajy8WcsLcZxfFcBucPnEiB/QSTxX98s1GI/V2s+b0xdQ9YAxYY
         fl9sQdAprH89torSmdcstiuWkP0Pvncmm3yHCQkzvWcQDTWBAMgfMjeFHl5f96vUGa6z
         QPJkKT/i9acu6Wq8HLmI1pqhJRHZbJy7uqpuzgfVxTnGOzbHrLK7wJJWA0R4SLNNQnF1
         5y4WRjO4YAoctzd9U1uEaYKsCEr1Cw+HOFcv08+95VvTpSFsE38hIDJpq6l6fJ0NJXmT
         Brbw==
X-Gm-Message-State: AOAM5335v4TrzKV31fVlsEbEs/8PR2bX9oFTEMeDSy7Z9ZReSckUM/74
        cQrCakumZwkGTg8aRxXV1uI=
X-Google-Smtp-Source: ABdhPJzvGlgcAB4R6vHxU2waeO6Km3+TvSGbBM/R5GL2WDQXGpiCGlkjzQ9ug/rsiryjPPV44mmX0Q==
X-Received: by 2002:a05:600c:ac2:: with SMTP id c2mr48557417wmr.118.1636332992660;
        Sun, 07 Nov 2021 16:56:32 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id g13sm13634578wmk.37.2021.11.07.16.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 16:56:32 -0800 (PST)
Date:   Mon, 8 Nov 2021 01:56:30 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     toan@os.amperecomputing.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] PCI: xgene-msi: Use bitmap_zalloc() when applicable
Message-ID: <YYh1vrNCavFKuskW@rocinante>
References: <32f3bc1fbfbd6ee0815e565012904758ca9eff7e.1635019243.git.christophe.jaillet@wanadoo.fr>
 <YYb1RXjnXSV8xF/0@rocinante>
 <bd57f9db-e1a5-c2a6-3523-b3c0ad086759@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bd57f9db-e1a5-c2a6-3523-b3c0ad086759@wanadoo.fr>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Christophe!

[...]
> > I believe, after having a brief look, that we might have a few other
> > candidates that we could also update:
> > 
> >    drivers/pci/controller/dwc/pcie-designware-ep.c
> >    717:	ep->ib_window_map = devm_kcalloc(dev,
> >    724:	ep->ob_window_map = devm_kcalloc(dev,
> >    drivers/pci/controller/pcie-iproc-msi.c
> >    592:	msi->bitmap = devm_kcalloc(pcie->dev, BITS_TO_LONGS(msi->nr_msi_vecs),
> >    drivers/pci/controller/pcie-xilinx-nwl.c
> >    470:	bit = bitmap_find_free_region(msi->bitmap, INT_PCI_MSI_NR,
> >    567:	msi->bitmap = kzalloc(size, GFP_KERNEL);
> >    637:	msi->bitmap = NULL;
> >    drivers/pci/controller/pcie-iproc-msi.c
> >    262:	hwirq = bitmap_find_free_region(msi->bitmap, msi->nr_msi_vecs,
> >    290:	bitmap_release_region(msi->bitmap, hwirq,
> >    drivers/pci/controller/pcie-xilinx-nwl.c
> >    470:	bit = bitmap_find_free_region(msi->bitmap, INT_PCI_MSI_NR,
> >    494:	bitmap_release_region(msi->bitmap, data->hwirq,
> >    drivers/pci/controller/pcie-brcmstb.c
> >    537:	hwirq = bitmap_find_free_region(&msi->used, msi->nr, 0);
> >    546:	bitmap_release_region(&msi->used, hwirq, 0);
> >    drivers/pci/controller/pcie-xilinx.c
> >    240:	hwirq = bitmap_find_free_region(port->msi_map, XILINX_NUM_MSI_IRQS, order_base_2(nr_irqs));
> >    263:	bitmap_release_region(port->msi_map, d->hwirq, order_base_2(nr_irqs));
> > 
> > Some of the above could also potentially benefit from being converted to
> > use the DECLARE_BITMAP() macro to create the bitmap that is then being
> > embedded into some struct used to capture details and state, rather than
> > store a pointer to later allocate memory dynamically.  Some controller
> > drivers already do this, so we could convert rest where appropriate.
> > 
> > What do you think?
> 
> Hi,
> 
> my first goal was to simplify code that was not already spotted by a cocci
> script proposed by Joe Perches (see [1]).

Ahh, OK.  I didn't know that Joe worked on adding new Coccinelle script to
deal with the bitmap allocations and such.  I assumed you did some code
review and found some issues.

I had a quick look at what the Coccinelle script found, and it seems I have
missed when I did some search on my own:

  drivers/pci/controller/pcie-rcar-ep.c

> I'll give a closer look at the opportunities spotted by Joe if they have not
> already been fixed in the meantime.

As per the thread you linked to, I can see that neither the new Coccinelle
script nor the changes from Joe were accepted yet, or I couldn't see
anything yet (at least not in the PCI tree).

> Concerning the use of DECLARE_BITMAP instead of alloc/free memory, it can be
> more tricky to spot it. Will try to give a look at it.

A lot more code to read, indeed.  However, the benefits are quite nice:
simpler code, easier error handling and reducing probability of leaking
memory.

I think, a lot of the drivers we have in our tree could (and a lot already
do) leverage the DECLARE_BITMAP() macro reserving space during build time
over dealing with memory allocations and such.

> > We also have this nudge from Coverity that we could fix, as per:
> > 
> >    532 static int brcm_msi_alloc(struct brcm_msi *msi)
> >    533 {
> >    534         int hwirq;
> >    535
> >    536         mutex_lock(&msi->lock);
> >        1. address_of: Taking address with &msi->used yields a singleton pointer.
> >        CID 1468487 (#1 of 1): Out-of-bounds access (ARRAY_VS_SINGLETON)2. callee_ptr_arith: Passing &msi->used to function bitmap_find_free_region which uses it as an array. This might corrupt or misinterpret adjacent memory locations. [show details]
> >    537         hwirq = bitmap_find_free_region(&msi->used, msi->nr, 0);
> >    538         mutex_unlock(&msi->lock);
> >    539
> >    540         return hwirq;
> >    541 }
> >    543 static void brcm_msi_free(struct brcm_msi *msi, unsigned long hwirq)
> >    544 {
> >    545         mutex_lock(&msi->lock);
> >        1. address_of: Taking address with &msi->used yields a singleton pointer.
> >        CID 1468424 (#1 of 1): Out-of-bounds access (ARRAY_VS_SINGLETON)2. callee_ptr_arith: Passing &msi->used to function bitmap_release_region which uses it as an array. This might corrupt or misinterpret adjacent memory locations. [show details]
> >    546         bitmap_release_region(&msi->used, hwirq, 0);
> >    547         mutex_unlock(&msi->lock);
> >    548 }
> > 
> > We could look at addressing this too at the same time.
> 
> I'll give it a look.

Thank you!

	Krzysztof
