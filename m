Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFBA744F9C6
	for <lists+linux-pci@lfdr.de>; Sun, 14 Nov 2021 18:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbhKNR1r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 14 Nov 2021 12:27:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59073 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229725AbhKNR1r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 14 Nov 2021 12:27:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636910692;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0eTbrRxjbA64Zx9WNO2uiMv5Y0nrApNayM9DZmVQeYc=;
        b=BpZY6tqm6SgzyDLy25UscSDFnAtPw4q1GZYFzejg3FIxYu+mLTg/EUNsfZP3rhO85BAAVG
        ab4akOlSyJV+jDGacUTT0bSchh265IGdzV4W4DDVHqGuFx/12KW6jJnCO4ExvaJFp1RxLH
        GFCutqTmaE/UAwnX47wZ602rtutbB5I=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-epdOmwFVOF-ccXARQxrZ_g-1; Sun, 14 Nov 2021 12:24:51 -0500
X-MC-Unique: epdOmwFVOF-ccXARQxrZ_g-1
Received: by mail-ed1-f70.google.com with SMTP id z1-20020a05640235c100b003e28c89743bso12000016edc.22
        for <linux-pci@vger.kernel.org>; Sun, 14 Nov 2021 09:24:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0eTbrRxjbA64Zx9WNO2uiMv5Y0nrApNayM9DZmVQeYc=;
        b=slqyWRBno9hSSkFEI7LQ+tTQep83oUTNtw10i+I14MrUkUIbPqz0iC05W7kUbWDm6R
         SiC1+VBLN+jL2m7BYSi7ax+AKCpGPSGClI44MaAB+jIWNilU9EezZhV8EsgavSFHbmj4
         EzXuW7OukJwt69chvopPfJHdtV8olLy4v618Yk5/QPQ9+nRU2Lgn5y2Rl7UBAKQsM8N1
         J6rLKARpaFcVU367K+38slI54Swg1eM1w5sucvWbvweI6AR9Q8/pJi5ubly2fnxRlhrl
         arvAeM/mOlo3qogH4zFPL5UQC6exFQi7y8d2nEeNYr4piLuAIh3ibD7NS14O+lNThJco
         Z+Yg==
X-Gm-Message-State: AOAM531iBu3h2EdtV4JdPsKxRJLX/5ohfXzyggn4K+dkifnMWQpV9exG
        9V1118ZT6xtTs/OQ8sUj2HJ5NORH8SV029ptNL+fOM4kGsaJ6B/BtxcrltXraz0XdO87ljXULo0
        1XauL9IlakH6UiANRpZtW
X-Received: by 2002:a05:6402:289e:: with SMTP id eg30mr5168452edb.253.1636910690114;
        Sun, 14 Nov 2021 09:24:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyVDFEImH81X2cJ5JKDajX5WCtDc9Yo8LEOO+Q0ESb8jkLBlA+9W3/Uz1RiCiP17b7tpdn71w==
X-Received: by 2002:a05:6402:289e:: with SMTP id eg30mr5168434edb.253.1636910689962;
        Sun, 14 Nov 2021 09:24:49 -0800 (PST)
Received: from redhat.com ([2.55.156.154])
        by smtp.gmail.com with ESMTPSA id h7sm310118ede.40.2021.11.14.09.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 09:24:49 -0800 (PST)
Date:   Sun, 14 Nov 2021 12:24:43 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Gerd Hoffmann <kraxel@redhat.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pciehp: fast unplug for virtual machines
Message-ID: <20211114122249-mutt-send-email-mst@kernel.org>
References: <20211111090225.946381-1-kraxel@redhat.com>
 <20211114163958.GA7211@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211114163958.GA7211@wunner.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Nov 14, 2021 at 05:39:58PM +0100, Lukas Wunner wrote:
> On Thu, Nov 11, 2021 at 10:02:24AM +0100, Gerd Hoffmann wrote:
> > The PCIe specification asks the OS to wait five seconds after the
> 
> The spec reference Bjorn asked for is: PCIe r5.0, sec. 6.7.1.5
> 
> > attention button has been pressed before actually un-plugging the
> > device.  This gives the operator the chance to cancel the operation
> > by pressing the attention button again within those five seconds.
> > 
> > For physical hardware this makes sense.  Picking the wrong button
> > by accident can easily happen and it can be corrected that way.
> > 
> > For virtual hardware the benefits are questionable.  Typically
> > users find the five second delay annoying.
> 
> Why does virtual hardware implement the Attention Button if it's
> perceived as annoying?  Just amend qemu so that it doesn't advertise
> presence of an Attention Button to get rid of the delay.  (Clear the
> Attention Button Present bit in the Slot Capabilities register.)

Because we want ability to request device removal from outside the
guest.

> An Attention Button doesn't make any sense for virtual hardware
> except to test or debug support for it in the kernel.  Just make
> presence of the Attention Button optional and be done with it.
> 
> You'll still be able to bring down the slot in software via the
> "remove" attribute in sysfs.

This requires guest specific code though. Emulating the attention button
works in a guest independent way.

> Same for the 1 second delay in remove_board().  That's mandated by
> PCIe r5.0, sec. 6.7.1.8, but it's only observed if a Power Controller
> is present.  So just clear the Power Controller Present bit in the
> Slot Capabilities register and the delay is gone.
> 
> 
> > @@ -109,6 +110,8 @@ struct controller {
> >  	unsigned int ist_running;
> >  	int request_result;
> >  	wait_queue_head_t requester;
> > +
> > +	bool is_virtual;
> >  };
> 
> This is a quirk for a specific device, so please move it further up to the
> /* capabilities and quirks */ section of struct controller.
> 
> 
> > @@ -227,6 +227,11 @@ static int pciehp_probe(struct pcie_device *dev)
> >  		goto err_out_shutdown_notification;
> >  	}
> >  
> > +	if (dev->port->vendor == PCI_VENDOR_ID_REDHAT &&
> > +	    dev->port->device == 0x000c)
> > +		/* qemu pcie root port */
> > +		ctrl->is_virtual = true;
> > +
> 
> Move this to pcie_init() in pciehp_hpc.c below the existing quirks for
> hotplug_user_indicators and is_thunderbolt.
> 
> 
> > +static bool fast_virtual_unplug = true;
> > +module_param(fast_virtual_unplug, bool, 0644);
> 
> An integer parameter to configure a custom delay would be nicer IMO.
> Of course, anything else than 5 sec deviates from the spec.
> 
> Thanks,
> 
> Lukas

