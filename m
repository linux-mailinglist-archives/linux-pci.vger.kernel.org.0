Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE3D2649AD
	for <lists+linux-pci@lfdr.de>; Thu, 10 Sep 2020 18:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgIJQ0T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Sep 2020 12:26:19 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:56935 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726515AbgIJQWV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Sep 2020 12:22:21 -0400
X-Greylist: delayed 523 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Sep 2020 12:21:22 EDT
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id DEEB75804EB;
        Thu, 10 Sep 2020 12:12:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 10 Sep 2020 12:12:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=ddCQbhjVBkl6UT3ElTu0s85KbX9
        mRPCmsqjShRybr0o=; b=Vi/OvJeyKtEzr5Sj5JBFj8NJeJJrOTzt/N+lIK9fixb
        u92kkSmR6AhNp3L9kacYP5yBtepWESQBjeqqV0Di4ONy3ZzUVRahN8j9whCQnMjp
        HvKr+iv6572tLVTmqsZ+8Dq2mzw1tpGvZQA3ELum28+KTrBr331a10p5fEN2FKSa
        3LPxaF1Bn2gxhfV2sP6sWSHEXRat5YuVNuoihMdyNOJwhADbYNBNRE5zxfMKO+KR
        Mhw5OhrOMfOUf+HJBIUeYFd0Wh6A1y9ti90YgxTg1GkiOXyqEmyH4It8DQwDOImG
        FiTHMVLmScf7n7HxyRF5TuAeemY7D6vsy0rvgP6rsYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=ddCQbh
        jVBkl6UT3ElTu0s85KbX9mRPCmsqjShRybr0o=; b=XrDuY3hH3udTKgGXtmg53n
        UHaVNYgKGc1EYk5uXkCQeQHadZ4IKNRUJeFomJVkkd5JJ3aJ+2/K9yU/ftkLmZRw
        y/JKF34dPhOWW/xIfeSjqO9/5Rh+jB1COLpUmudzESzJg8k+yawjgTvok7VIJZwB
        LP/eKkqibbuvf1MNKe0KnVjRyIWNE0MgDGu7TLYESpD8ZDDiDuJzUVLgYWp6j3ti
        bSR1B2CvXaE0joEuOVzE2/yA/EPQenxEF0hZWWwvofHqjue70UufyWvWf5K4VA/f
        ypxu7n1Ifllw6P2vTLA4jLWi6EQbeK/7p+0aOlhdw2KzN92wA9EW/F9NdW6bzTAA
        ==
X-ME-Sender: <xms:YFBaX9Kxld07E3KCj3VKRTDJcaG98PAIPsyt_rMmnVD_i4XaYx9WGg>
    <xme:YFBaX5J-DSg5ojj5Dx81fvsHdEI8cscYaMOonv-3llSKauaKQlbuD4cj8Hvzy76Q4
    cUBddGldPvyJg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudehjedgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeevueehje
    fgfffgiedvudekvdektdelleelgefhleejieeugeegveeuuddukedvteenucfkphepkeef
    rdekiedrjeegrdeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:YFBaX1tobm8DWJZJ1nxeLKSLS2kZGZ8C-QdquIIFBQHJgGMDpRNBXw>
    <xmx:YFBaX-aciwbr1RNJ-s6HnWDzBfYIfLD4yw-a6dTi0Y1XH8lg1fLxuA>
    <xmx:YFBaX0Y2tIxe2nuzU3IHZU4zgd85FGy2ALAMCm_nDcVYtCCrE_2-iQ>
    <xmx:YVBaX6xWH2rheFB58DBBXf9XZmPQn4LKAF_bXQTCSDi6cgPDmH-hZg>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 371383280066;
        Thu, 10 Sep 2020 12:12:16 -0400 (EDT)
Date:   Thu, 10 Sep 2020 18:12:24 +0200
From:   Greg KH <greg@kroah.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org,
        Russell King <linux@armlinux.org.uk>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 3/3] dma-mapping: introduce DMA range map, supplanting
 dma_pfn_offset
Message-ID: <20200910161224.GB1158578@kroah.com>
References: <20200910054038.324517-1-hch@lst.de>
 <20200910054038.324517-4-hch@lst.de>
 <20200910075351.GA1092435@kroah.com>
 <20200910091351.GA25883@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910091351.GA25883@lst.de>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 10, 2020 at 11:13:51AM +0200, Christoph Hellwig wrote:
> On Thu, Sep 10, 2020 at 09:53:51AM +0200, Greg KH wrote:
> > >  		/*
> > >  		 * Please refer to usb_alloc_dev() to see why we set
> > > -		 * dma_mask and dma_pfn_offset.
> > > +		 * dma_mask and dma_range_map.
> > >  		 */
> > >  		intf->dev.dma_mask = dev->dev.dma_mask;
> > > -		intf->dev.dma_pfn_offset = dev->dev.dma_pfn_offset;
> > > +		if (dma_direct_copy_range_map(&intf->dev, &dev->dev))
> > > +			dev_err(&dev->dev, "failed to copy DMA map\n");
> > 
> > We tell the user, but then just keep on running?  Is there anything that
> > we can do here?
> > 
> > If not, why not have dma_direct_copy_range_map() print out the error?
> 
> At least for USB I'm pretty sure this isn't required at all.  I've been
> running with the patch below on my desktop for two days now trying all
> the usb toys I have (in addition to grepping for obvious abuses in
> the drivers).  remoteproc is a different story, but the DMA handling
> seems there is sketchy to start with..
> 
> ---
> >From 8bae3e6833f2ca431dcfcbc8f9cced7d5e972a01 Mon Sep 17 00:00:00 2001
> From: Christoph Hellwig <hch@lst.de>
> Date: Wed, 9 Sep 2020 08:28:59 +0200
> Subject: usb: don't inherity DMA properties for USB devices
> 
> As the comment in usb_alloc_dev correctly states, drivers can't use
> the DMA API on usb device, and at least calling dma_set_mask on them
> is highly dangerous.  Unlike what the comment states upper level drivers
> also can't really use the presence of a dma mask to check for DMA
> support, as the dma_mask is set by default for most busses.
> 
> Remove the copying over of DMA information, and remove the now unused
> dma_direct_copy_range_map export.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/usb/core/message.c |  7 -------
>  drivers/usb/core/usb.c     | 13 -------------
>  kernel/dma/direct.c        |  1 -
>  3 files changed, 21 deletions(-)
> 
> diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
> index 935ee98e049f65..9e45732dc1d1d1 100644
> --- a/drivers/usb/core/message.c
> +++ b/drivers/usb/core/message.c
> @@ -1954,13 +1954,6 @@ int usb_set_configuration(struct usb_device *dev, int configuration)
>  		intf->dev.bus = &usb_bus_type;
>  		intf->dev.type = &usb_if_device_type;
>  		intf->dev.groups = usb_interface_groups;
> -		/*
> -		 * Please refer to usb_alloc_dev() to see why we set
> -		 * dma_mask and dma_range_map.
> -		 */
> -		intf->dev.dma_mask = dev->dev.dma_mask;
> -		if (dma_direct_copy_range_map(&intf->dev, &dev->dev))
> -			dev_err(&dev->dev, "failed to copy DMA map\n");
>  		INIT_WORK(&intf->reset_ws, __usb_queue_reset_device);
>  		intf->minor = -1;
>  		device_initialize(&intf->dev);
> diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
> index 23d451f6894d70..9b4ac4415f1a47 100644
> --- a/drivers/usb/core/usb.c
> +++ b/drivers/usb/core/usb.c
> @@ -599,19 +599,6 @@ struct usb_device *usb_alloc_dev(struct usb_device *parent,
>  	dev->dev.bus = &usb_bus_type;
>  	dev->dev.type = &usb_device_type;
>  	dev->dev.groups = usb_device_groups;
> -	/*
> -	 * Fake a dma_mask/offset for the USB device:
> -	 * We cannot really use the dma-mapping API (dma_alloc_* and
> -	 * dma_map_*) for USB devices but instead need to use
> -	 * usb_alloc_coherent and pass data in 'urb's, but some subsystems
> -	 * manually look into the mask/offset pair to determine whether
> -	 * they need bounce buffers.
> -	 * Note: calling dma_set_mask() on a USB device would set the
> -	 * mask for the entire HCD, so don't do that.
> -	 */
> -	dev->dev.dma_mask = bus->sysdev->dma_mask;
> -	if (dma_direct_copy_range_map(&dev->dev, bus->sysdev))
> -		dev_err(&dev->dev, "failed to copy DMA map\n");
>  	set_dev_node(&dev->dev, dev_to_node(bus->sysdev));
>  	dev->state = USB_STATE_ATTACHED;
>  	dev->lpm_disable_count = 1;
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index fc815f7375e282..3af257571a3b42 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -552,4 +552,3 @@ int dma_direct_copy_range_map(struct device *to, struct device *from)
>  	to->dma_range_map = new_map;
>  	return 0;
>  }
> -EXPORT_SYMBOL_GPL(dma_direct_copy_range_map);

If you think this is safe to do, great, but for some reason I thought
host controllers wanted this information, and that the scsi layer was
the offending layer that also wanted this type of thing.  But it's been
a really long time so I don't remember for sure, sorry.

thanks,

greg k-h
