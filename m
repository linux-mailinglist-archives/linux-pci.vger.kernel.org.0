Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191D1340C09
	for <lists+linux-pci@lfdr.de>; Thu, 18 Mar 2021 18:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbhCRRoc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Mar 2021 13:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbhCRRo3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Mar 2021 13:44:29 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752EFC06175F;
        Thu, 18 Mar 2021 10:44:29 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id k4so1668609plk.5;
        Thu, 18 Mar 2021 10:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=silYB0ReWesGT2gy/SuDL9rDUPXG+HkXO/MQkv5g2jM=;
        b=YxJy+2UgFvhSJ5sTGc0AonW0IZ31y/JHYc5PyZwE49qDmVAEEQ9+U/DGwEZ6jcM9fT
         d0wM0A4wLR82s+Dj4vfSKOnU65Aq3EU+Mx5lkuFMTye1/4jwFGr1vKqGYHZf+NDhO/ii
         ToUw1j51g717tBLanTwR6ESRQXPnNd5aw6Qsqyphail9J2gKNh5vEg2lTCT69KYh96Cs
         fppNOCZ0ZUHrtfq16NQsTtEIVfXEQ7YcZAMNidIeKniAARkWn/Jhet3dNZqFbekIqRk4
         NvlkXdcgRSkM/tJJMkUlB0PN5sT60k+Y2dJUL7KhJpoCHn5ahOwpQ88RzhVDJC/2aX5m
         5WnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=silYB0ReWesGT2gy/SuDL9rDUPXG+HkXO/MQkv5g2jM=;
        b=GseHYUTUTUUunao6GYgjL6zUCZ0NCp9/hhpQDTklMQGWWWvXlAfIZMk+Yo0od7vlSb
         E9J63PmYM7WN0IBPKghC5FX7zYi4C++brYXX1FAVNBDy68LI3LJsDeqGUFGmm0EmxhYZ
         0evGa7W1hcwza934FeTYNSNh0ouiUOSv5ihTFNcPvabu/RS8k3SmIMvk0SnThlEv1umQ
         NdIAPBrv+NZ/95F8wZ2UtGDwj07dS75kifjeZTBNTPNmWYTAKxWTZrrF5ATZ86voGMUa
         gb+WHawYvYMnleRFi96ezdjciGs7PLm/1XY8yKWrs54HW7i8fGhA6YMPcUkUrwZRT0pF
         4yFQ==
X-Gm-Message-State: AOAM531ICYYEcbc5fC1cJhHTgu6PrKmryW/Edmqe0YJMyww3b4U+P5wb
        EtweXS76nKBjOl2x3qz3c3s=
X-Google-Smtp-Source: ABdhPJxuSldlAiWbBW+PuJ6B4npIGUgS2l3D+DC6H4/WS6Uxgd7pNyalUYjxERzIB65Y7cuWxdD90w==
X-Received: by 2002:a17:90b:100a:: with SMTP id gm10mr5487372pjb.0.1616089468752;
        Thu, 18 Mar 2021 10:44:28 -0700 (PDT)
Received: from localhost ([103.248.31.158])
        by smtp.gmail.com with ESMTPSA id w22sm2884164pfi.133.2021.03.18.10.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 10:44:28 -0700 (PDT)
Date:   Thu, 18 Mar 2021 23:13:44 +0530
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     raphael.norwitz@nutanix.com, linux-pci@vger.kernel.org,
        bhelgaas@google.com, linux-kernel@vger.kernel.org,
        alay.shah@nutanix.com, suresh.gumpula@nutanix.com,
        shyam.rajendran@nutanix.com, felipe@nutanix.com,
        alex.williamson@redhat.com
Subject: Re: [PATCH 4/4] PCI/sysfs: Allow userspace to query and set device
 reset mechanism
Message-ID: <20210318174344.yslqpfyct6ziwypd@archlinux>
References: <20210317112309.nborigwfd26px2mj@archlinux>
 <YFHsW/1MF6ZSm8I2@unreal>
 <20210317131718.3uz7zxnvoofpunng@archlinux>
 <YFILEOQBOLgOy3cy@unreal>
 <20210317113140.3de56d6c@omen.home.shazbot.org>
 <YFMYzkg101isRXIM@unreal>
 <20210318142252.fqi3das3mtct4yje@archlinux>
 <YFNqbJZo3wqhMc1S@unreal>
 <20210318170143.ustrbjaqdl644ozj@archlinux>
 <YFOPYs3IGaemTLMj@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFOPYs3IGaemTLMj@unreal>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21/03/18 07:35PM, Leon Romanovsky wrote:
> On Thu, Mar 18, 2021 at 10:31:43PM +0530, Amey Narkhede wrote:
> > On 21/03/18 04:57PM, Leon Romanovsky wrote:
> > > On Thu, Mar 18, 2021 at 07:52:52PM +0530, Amey Narkhede wrote:
> > > > On 21/03/18 11:09AM, Leon Romanovsky wrote:
> > > > > On Wed, Mar 17, 2021 at 11:31:40AM -0600, Alex Williamson wrote:
> > > > > > On Wed, 17 Mar 2021 15:58:40 +0200
> > > > > > Leon Romanovsky <leon@kernel.org> wrote:
>
> <...>
>
> > > > > I'm lost here, does vfio-pci use sysfs interface or internal to the kernel API?
> > > > >
> > > > > If it is latter then we don't really need sysfs, if not, we still need
> > > > > some sort of DB to create second policy, because "supported != working".
> > > > > What am I missing?
> > > > >
> > > > > Thanks
> > > > >
> > > > Can you explain bit more about why supported != working?
> > >
> > > It is written in the commit message of this patch.
> > > https://lore.kernel.org/lkml/20210312173452.3855-1-ameynarkhede03@gmail.com/
> > > "This feature aims to allow greater control of a device for use cases
> > > as device assignment, where specific device or platform issues may
> > > interact poorly with a given reset method, and for which device specific
> > > quirks have not been developed."
> > >
> > > You wrote it and also repeated it a couple of times during the discussion.
> > >
> > > If device can understand that specific reset doesn't work, it won't
> > > perform it in first place.
> > >
> > > Thanks
> > Is it possible for device to understand whether or not specific reset
> > will work or not prior to performing reset and after it indicates
> > support for that reset method? Maybe theres problem with that particular
> > piece of hardware in that machine.
> > How can database be maintained if a particular machines have
> > particular piece of faulty HW?
>
> It was exactly the reason why I think that VM usecase presented by
> you is not viable.
>
Well I didn't present it as new use case. I just gave existing
usecase based on existing reset attribute. Nothing new here.
Nothing really changes wrt that use case.
> > If for some reason reset doesn't work it will just give -ENOTTY.
> > This isn't any different from existing behavior.Actually it informs user
> > that the reset method didn't reset the device and user can use different
> > reset method instead of implicitly using different reset method.
> > If user doesn't explicitly set preferred reset method then
> > we go ahead with existing implicit fall through behavior which will try all
> > available reset methods until any one of them works.
> > If you have device that doesn't support reset at all then you have
> > option to completely disable it unlike existing reset attribute where
> > you cannot disable reset. So it gives greater control where you can
> > disable the reset altogether when quirk isn't developed yet.
>
> I explicitly asked to hear usecase, right now, I got an explanation from
> Alex for policy decision (which doesn't need sysfs) and from you about
> overcoming HW bugs with expectation that user will be guru of PCI reset
> methods.
>
> >
> > We can't expect to develop quirk for every device in existence.
>
> It doesn't give us an excuse do not try.
>
> > For example on my laptop elantech touchpad still doesn't work in 2021
> > with vanilla kernel, arch linux applies the patch which was reverted in
> > mainline kernel for some reason.
>
> I see it as a good example of cheap solution. Vendor won't fix your
> touchpad because distros provide workaround. The same will be with reset.
>
> Thanks
>
As mentioned earlier not all vendors care about Linux and not
all of the population can afford to buy new HW just to run Linux.

Thanks,
Amey
