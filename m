Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75F893420DC
	for <lists+linux-pci@lfdr.de>; Fri, 19 Mar 2021 16:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbhCSPYX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Mar 2021 11:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbhCSPYO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Mar 2021 11:24:14 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF35C06174A;
        Fri, 19 Mar 2021 08:24:13 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id u19so3905031pgh.10;
        Fri, 19 Mar 2021 08:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=THGzijCSAtw2Sfc/SFksw159rmrxn7PqSfIjNYn5Oao=;
        b=itzuDSQscbh+gffpWo4zzyv7vtJ5H/39tyMb91CpqzJXRABMNDdCGPHlyZQurtzpsx
         G5xq1khDqhyIapyLM/isZ834sstUTUAvB6kbt64/Tbylkf4eu4tuvEogX3wR5fGT9pX4
         xUzdLBjqJkqmHZd95mFltj5NtaAniY3m5lzXPkV0db6MnSFMuTVIeGkNz/6vImWM6LH6
         JUJBeyC6SPL9I6Q4UFMhqucfXjK+mMEsxwPFZst2crUsuo+rorOBeW+LJfdhmc2FfDFN
         nQOTwA+CeZoFSMAhwmcLY88zcDAB7QMbek5/pm1HQ3IZFl9kECFfNSIqrZp92BrmZIiY
         QvEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=THGzijCSAtw2Sfc/SFksw159rmrxn7PqSfIjNYn5Oao=;
        b=RStqhJ4LS6yHIv2kt94sOJJ/KuBmh+t1i7CUgJ2ht+bigxmuFrQ0T5UJyWrmb0yRBC
         0ao712RmKm0iLv9xAiTwR56rR8auMjRE2h7y1IRAHCvQEtQ39c4rqzUctX35FDaWY/zh
         XLScywlSS6YtGWhBqzEmN736eyCrWOmpZqNYfASJU4uSnw2vyQKWuAmXSd07BkW4VTin
         01I+jw4gskDQh/P/EbLB8Y3dKT4aaUc/Y68sS5TBHP+GwKBuywkibe5rF2qOcHfAU8Zp
         gFlqhBWuwAHPpK70mOqUEZen52PPloutrKkZK/ZsHKHQErzNMF+/voBuAXVdTdXx8WCG
         daRA==
X-Gm-Message-State: AOAM531MBFDnpqVFjjSVIljEjDqSWpQn7AP9lp/JxCWwmzaLUwdC4nqx
        8nMxnGOqDULvUEr3T4uuh1qXEJslcvKo+w==
X-Google-Smtp-Source: ABdhPJzRSgFAJLCYWpUInPAyHDrJGnDeRKcHG0YZ9x7SudoRmzOrftxaLvwm6a8NXOEhpbb8Qtz9yw==
X-Received: by 2002:a05:6a00:1504:b029:203:6bc9:3f14 with SMTP id q4-20020a056a001504b02902036bc93f14mr9788120pfu.22.1616167442439;
        Fri, 19 Mar 2021 08:24:02 -0700 (PDT)
Received: from localhost ([103.248.31.158])
        by smtp.gmail.com with ESMTPSA id y7sm5079409pgp.23.2021.03.19.08.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 08:24:01 -0700 (PDT)
Date:   Fri, 19 Mar 2021 20:53:17 +0530
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     raphael.norwitz@nutanix.com, linux-pci@vger.kernel.org,
        bhelgaas@google.com, linux-kernel@vger.kernel.org,
        alay.shah@nutanix.com, suresh.gumpula@nutanix.com,
        shyam.rajendran@nutanix.com, felipe@nutanix.com,
        alex.williamson@redhat.com
Subject: Re: [PATCH 4/4] PCI/sysfs: Allow userspace to query and set device
 reset mechanism
Message-ID: <20210319152317.babevldyslat2gqa@archlinux>
References: <20210317131718.3uz7zxnvoofpunng@archlinux>
 <YFILEOQBOLgOy3cy@unreal>
 <20210317113140.3de56d6c@omen.home.shazbot.org>
 <YFMYzkg101isRXIM@unreal>
 <20210318142252.fqi3das3mtct4yje@archlinux>
 <YFNqbJZo3wqhMc1S@unreal>
 <20210318170143.ustrbjaqdl644ozj@archlinux>
 <YFOPYs3IGaemTLMj@unreal>
 <20210318174344.yslqpfyct6ziwypd@archlinux>
 <YFShlUgePr1BNnRI@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFShlUgePr1BNnRI@unreal>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21/03/19 03:05PM, Leon Romanovsky wrote:
> On Thu, Mar 18, 2021 at 11:13:44PM +0530, Amey Narkhede wrote:
> > On 21/03/18 07:35PM, Leon Romanovsky wrote:
> > > On Thu, Mar 18, 2021 at 10:31:43PM +0530, Amey Narkhede wrote:
> > > > On 21/03/18 04:57PM, Leon Romanovsky wrote:
> > > > > On Thu, Mar 18, 2021 at 07:52:52PM +0530, Amey Narkhede wrote:
> > > > > > On 21/03/18 11:09AM, Leon Romanovsky wrote:
> > > > > > > On Wed, Mar 17, 2021 at 11:31:40AM -0600, Alex Williamson wrote:
> > > > > > > > On Wed, 17 Mar 2021 15:58:40 +0200
> > > > > > > > Leon Romanovsky <leon@kernel.org> wrote:
> > >
> > > <...>
> > >
> > > > > > > I'm lost here, does vfio-pci use sysfs interface or internal to the kernel API?
> > > > > > >
> > > > > > > If it is latter then we don't really need sysfs, if not, we still need
> > > > > > > some sort of DB to create second policy, because "supported != working".
> > > > > > > What am I missing?
> > > > > > >
> > > > > > > Thanks
> > > > > > >
> > > > > > Can you explain bit more about why supported != working?
> > > > >
> > > > > It is written in the commit message of this patch.
> > > > > https://lore.kernel.org/lkml/20210312173452.3855-1-ameynarkhede03@gmail.com/
> > > > > "This feature aims to allow greater control of a device for use cases
> > > > > as device assignment, where specific device or platform issues may
> > > > > interact poorly with a given reset method, and for which device specific
> > > > > quirks have not been developed."
> > > > >
> > > > > You wrote it and also repeated it a couple of times during the discussion.
> > > > >
> > > > > If device can understand that specific reset doesn't work, it won't
> > > > > perform it in first place.
> > > > >
> > > > > Thanks
> > > > Is it possible for device to understand whether or not specific reset
> > > > will work or not prior to performing reset and after it indicates
> > > > support for that reset method? Maybe theres problem with that particular
> > > > piece of hardware in that machine.
> > > > How can database be maintained if a particular machines have
> > > > particular piece of faulty HW?
> > >
> > > It was exactly the reason why I think that VM usecase presented by
> > > you is not viable.
> > >
> > Well I didn't present it as new use case. I just gave existing
> > usecase based on existing reset attribute. Nothing new here.
> > Nothing really changes wrt that use case.
>
> Of course it is new, please see Alex's response, he said that vfio uses
> in-kernel API and not sysfs.
>
Still it doesn't change in-kernel API either.
> > > > If for some reason reset doesn't work it will just give -ENOTTY.
> > > > This isn't any different from existing behavior.Actually it informs user
> > > > that the reset method didn't reset the device and user can use different
> > > > reset method instead of implicitly using different reset method.
> > > > If user doesn't explicitly set preferred reset method then
> > > > we go ahead with existing implicit fall through behavior which will try all
> > > > available reset methods until any one of them works.
> > > > If you have device that doesn't support reset at all then you have
> > > > option to completely disable it unlike existing reset attribute where
> > > > you cannot disable reset. So it gives greater control where you can
> > > > disable the reset altogether when quirk isn't developed yet.
> > >
> > > I explicitly asked to hear usecase, right now, I got an explanation from
> > > Alex for policy decision (which doesn't need sysfs) and from you about
> > > overcoming HW bugs with expectation that user will be guru of PCI reset
> > > methods.
> > >
> > > >
> > > > We can't expect to develop quirk for every device in existence.
> > >
> > > It doesn't give us an excuse do not try.
> > >
> > > > For example on my laptop elantech touchpad still doesn't work in 2021
> > > > with vanilla kernel, arch linux applies the patch which was reverted in
> > > > mainline kernel for some reason.
> > >
> > > I see it as a good example of cheap solution. Vendor won't fix your
> > > touchpad because distros provide workaround. The same will be with reset.
> > >
> > > Thanks
> > >
> > As mentioned earlier not all vendors care about Linux and not
> > all of the population can afford to buy new HW just to run Linux.
>
> Sorry, but you are not consistent. At the beginning, we talked about new HW
> that has bugs but don't have quirks yet. Here we are talking about old HW
> that still doesn't have quirks.
>
> Thanks
>
Does it really matter whether HW is old or new?
If old HW doesn't have quirks yet how can we expect
new one to have quirks? What if new HW is made by same vendors
who don't have any interest in Linux?

Thanks,
Amey
