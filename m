Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5291C44FC4A
	for <lists+linux-pci@lfdr.de>; Sun, 14 Nov 2021 23:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbhKNWkU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 14 Nov 2021 17:40:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:32565 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231496AbhKNWkT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 14 Nov 2021 17:40:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636929442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x4YT30S8B3Cq0sBg53RRKKFsT3rjgCYg2jd6C8drWHE=;
        b=GEjgYX+Qn1ojKy58njT5p6xuwS3NXvyOEFYxMjDjyR11tmrGQsUpTJy3DFMr0UC4WXSs78
        UTEH1Xk/nwrUFeu1mH0NwjwWWcEAt1jIUek5RszAzWfwSB3/NBBKjZUzHJqFe/x+elATmL
        d9QsaV/xlSmyFVsdR0zr61EwEiernIk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-Fqj__IIoOcSoF9LUIWAqaQ-1; Sun, 14 Nov 2021 17:37:21 -0500
X-MC-Unique: Fqj__IIoOcSoF9LUIWAqaQ-1
Received: by mail-wr1-f71.google.com with SMTP id w14-20020adfbace000000b001884bf6e902so2831717wrg.3
        for <linux-pci@vger.kernel.org>; Sun, 14 Nov 2021 14:37:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x4YT30S8B3Cq0sBg53RRKKFsT3rjgCYg2jd6C8drWHE=;
        b=kZlA1FWyRx4CjwBFK/RluwkgMZV/uxNZt4jgoasHe1a3hj/s7+DHSwjsDt/e/JEKFI
         f/YzsxaJ2LW7x5FMe64W+ibfs/5kjKoaoWPDI0oaWJPq2WYKAXTnXh1iljtOoMjE5Yeq
         a67SK6NhC5OdsxZU2RSU5lbT1sKD312AmwrnFoHWS56a0BUD96zCdrsZ+/lDLH5h8T4H
         ohunirG0ZHiuBFef0qvIRaJleETvO1zcy2D02u31mYnc/7jK3AxQZdPAmOzUk+6ltiqY
         a64KUIL/LJcM5Ry4rkbHvU9zeH/V5yF4NZmI0NDQz/fXODTsQYpKx8wXgzgTyaXoOQkm
         +0Vg==
X-Gm-Message-State: AOAM531nLZ1brMndFYNtgNUAWxG6KEgtianqKIDiiyr3fwJqSZkeG6z7
        r/jq2++zEARsFHEz+xmk0+ZgRpMg+ivCz1/uLQlkyOG5P5OIdGsknCRqN0tHJw/NjgLH9uSxp76
        Wf2G2U0iLeJcdEFj1DIcx
X-Received: by 2002:a05:600c:500d:: with SMTP id n13mr23666470wmr.174.1636929440185;
        Sun, 14 Nov 2021 14:37:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxTdPCucF4deLdPv8e0iTIatgJZaRpLkkEqy+Aw1oSxfylMhpeTSFRvKeVkjK9aJjXcpriCuQ==
X-Received: by 2002:a05:600c:500d:: with SMTP id n13mr23666459wmr.174.1636929440033;
        Sun, 14 Nov 2021 14:37:20 -0800 (PST)
Received: from redhat.com ([2.55.156.154])
        by smtp.gmail.com with ESMTPSA id z11sm12223014wrt.58.2021.11.14.14.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 14:37:19 -0800 (PST)
Date:   Sun, 14 Nov 2021 17:37:15 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Gerd Hoffmann <kraxel@redhat.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pciehp: fast unplug for virtual machines
Message-ID: <20211114173550-mutt-send-email-mst@kernel.org>
References: <20211111090225.946381-1-kraxel@redhat.com>
 <20211114163958.GA7211@wunner.de>
 <20211114122249-mutt-send-email-mst@kernel.org>
 <20211114180604.GA23907@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211114180604.GA23907@wunner.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Nov 14, 2021 at 07:06:04PM +0100, Lukas Wunner wrote:
> On Sun, Nov 14, 2021 at 12:24:43PM -0500, Michael S. Tsirkin wrote:
> > On Sun, Nov 14, 2021 at 05:39:58PM +0100, Lukas Wunner wrote:
> > > Why does virtual hardware implement the Attention Button if it's
> > > perceived as annoying?  Just amend qemu so that it doesn't advertise
> > > presence of an Attention Button to get rid of the delay.  (Clear the
> > > Attention Button Present bit in the Slot Capabilities register.)
> > 
> > Because we want ability to request device removal from outside the
> > guest.
> 
> Please elaborate.  Does "outside the guest" mean on the host?
> How do you represent the Attention Button outside the guest
> and route events through to the guest?

The usual way, using kvm ioctls.

> 
> > > An Attention Button doesn't make any sense for virtual hardware
> > > except to test or debug support for it in the kernel.  Just make
> > > presence of the Attention Button optional and be done with it.
> > > 
> > > You'll still be able to bring down the slot in software via the
> > > "remove" attribute in sysfs.
> > 
> > This requires guest specific code though. Emulating the attention button
> > works in a guest independent way.
> 
> It sounds like you're using the Attention Button because it does
> almost, but not quite what you want for your specific use case.
> Now you're trying to change its behavior in a way that deviates
> from the spec to align it with your use case.
> 
> Why don't you just trigger surprise-removal from outside the guest?
> 
> Thanks,
> 
> Lukas

Because linux does not handle it well for all devices.  Fixing that
requires fixing all drivers.

-- 
MST

