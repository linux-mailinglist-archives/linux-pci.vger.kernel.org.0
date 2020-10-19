Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA0DD292963
	for <lists+linux-pci@lfdr.de>; Mon, 19 Oct 2020 16:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbgJSOcV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Oct 2020 10:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728877AbgJSOcV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Oct 2020 10:32:21 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19B7C0613CE;
        Mon, 19 Oct 2020 07:32:19 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id w7so2830251oow.7;
        Mon, 19 Oct 2020 07:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zPS3FVsTO33207hcva+hc27ibn1TTf2qpiS8Pe5UWu8=;
        b=Vho/La487lc2tSDXs9azUXYErbs/jWmRBgfHSfPpodJnmqdhTy8lG4Gn99GIUDijAB
         nInscWRHrO72LJZJOUfFEggpCJzLOQD5cnLwQyZkK670ykz3+RLp4tlmyKVMBWqGiSA/
         AuxuOtznvZuJu7t4IvAaBvHgGK6WF7PDs/bt4Wmw29WORJ+7TK8nKXm7Y5M9mk5S+GpU
         brxh6Iom73s7ZRojGX4TvzAwsM1qQrUvB0Yy4d2ONGnHpIyTJPkAtrA9e7T6S8t5VkN0
         pyadl7Stg4hqQJz2slAkxRaaKvyym1FsJ3+6on7ioKRxLVke2Hp4tUX8H/X59pxQyNb+
         AHOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zPS3FVsTO33207hcva+hc27ibn1TTf2qpiS8Pe5UWu8=;
        b=DQZfjsUG4w+yqmX60qjIDOdKhpt/q4OH0Q1wXrSK/DklICyj3DL9e1EiqPx2ov9YOJ
         Oxup5pl077jO5ZS5gfMKnwTYb96G7nsz+HM0u3yi1XiIXYrjsC5rZbJ3uwFOLooHpIVb
         qtoSAiAvZIEMD0pRtTVEdwpAFg9yAROJdhRUTrdKjH0tMWEKDTDWYtSH5xggGzjx7dZL
         JuhUh6G2V5+y3izE7AYGuuPEr6xSrs7XnYrd2ijdjO172nXdIhp7KsGftc1N5mX/bsM9
         5NCTyZVXjkkTUNHnAy3IxWy1G4FcJSUM4meTwn2nQ30TANv2T8wrKRjuAFBdPqbJD52U
         UpFQ==
X-Gm-Message-State: AOAM533Jphdhwq11L0xlwoARQlZnZmRts3CgHO547EQhnEEzEVwoMBGb
        1OG1AbMMEr6O1ycNd+t7JSUARw6dpTKCEcvuK3o=
X-Google-Smtp-Source: ABdhPJz2DdA22E5xFATZ1Fdf4AXs1zeJnUuilEEczn+rPrHYY5PzZT1rtAVar9pD1rgvgWUs9hQXdMI2oDXBF4iZBPE=
X-Received: by 2002:a4a:c3ca:: with SMTP id e10mr181026ooq.41.1603117939077;
 Mon, 19 Oct 2020 07:32:19 -0700 (PDT)
MIME-Version: 1.0
References: <20201016055235.440159-1-allen.lkml@gmail.com> <20201016062027.GB569795@kroah.com>
 <CAOMdWSJDJ-uXpis1WbG3LnOG7bMiif5Q4Maafv_a=55Y_qypfQ@mail.gmail.com>
 <20201019131613.GA3254417@kroah.com> <CAOMdWS+F=cCK=Rgy-0xk4_mqUFMn1PQBWR8u3JwqTP2AVifxsA@mail.gmail.com>
 <20201019134729.GA3259788@kroah.com>
In-Reply-To: <20201019134729.GA3259788@kroah.com>
From:   Allen <allen.lkml@gmail.com>
Date:   Mon, 19 Oct 2020 20:02:07 +0530
Message-ID: <CAOMdWSLs0mdzcjmyBtbAhTxr3ETOSC_4V7v5XPWGRnb5BJUJ+w@mail.gmail.com>
Subject: Re: [RFC] PCI: allow sysfs file owner to read the config space with CAP_SYS_RAWIO
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        ast@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Allen Pais <apais@linux.microsoft.com>,
        Allen Pais <allen.pais@lkml.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> > > > > >  Access to pci config space is explictly checked with CAP_SYS_ADMIN
> > > > > > in order to read configuration space past the frist 64B.
> > > > > >
> > > > > >  Since the path is only for reading, could we use CAP_SYS_RAWIO?
> > > > >
> > > > > Why?  What needs this reduced capability?
> > > >
> > > > Thanks for the review.
> > > >
> > > > We need read access to /sys/bus/pci/devices/,  We need write access to config,
> > > > remove, rescan & enable files under the device directory for each PCIe
> > > > functions & the downstream PCIe port.
> > > >
> > > > We need r/w access to sysfs to unbind and rebind the root complex.
> > >
> > > That didn't answer my question at all.
> >
> > Sorry about that, breaking it down:
> >
> > When the machine first boots, the VFIO device bindings under /dev/vfio
> > are not present.
> >
> > root@localhost:/tmp# ls -l /dev/vfio/
> > total 0
> > crw-rw-rw-. 1 root root 10, 196 Jan  5 01:47 vfio
> >
> > We have an agent which needs to run the following commands (We get
> > access denied here and need permissions to do this).
> > echo -n xxxx yyyy > /sys/module/vfio_pci/drivers/pci:vfio-pci/new_id
> > echo -n xxxx yyyy > /sys/module/vfio_pci/drivers/pci:vfio-pci/new_id
> >
> > And we want to avoid handing CAP_SYS_ADMIN here. Which is why the
> > thought about CAP_SYS_RAWIO.
>
> But that is not what you were asking this patch to do at all.  So why
> bring it up?
>
> new_id is NOT for "raw io" control, that should be only for admin
> priviliges.

Okay. Thanks for the explanation.
>
> And just because the vfio driver "abuses" this
> traditionally-debug-functionality doesn't mean you get to abuse the
> permission levels either.

 This makes sense now. I will drop the patch.
Thank you very much for the review.

>
> > > Why can't you have the process that wants to do all of the above, have
> > > admin rights as well?  Doing all of that is _very_ low-level and can
> > > cause all sorts of horrible things to happen to your machine, and is not
> > > really "raw io" in the traditional sense at all, right?
> >
> >
> > If the above approach is going to cause the system to do horrible things,
> > then I'll drop the idea.
>
> Of course it can cause the system to do horrible things, try it yourself
> and see!
>
> greg k-h



-- 
       - Allen
