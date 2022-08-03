Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15464588F0F
	for <lists+linux-pci@lfdr.de>; Wed,  3 Aug 2022 17:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236105AbiHCPEz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Aug 2022 11:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiHCPEy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Aug 2022 11:04:54 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9818033A16;
        Wed,  3 Aug 2022 08:04:53 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-3238de26fb1so155867907b3.8;
        Wed, 03 Aug 2022 08:04:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ouan4Svxron6vwUQD0UpAc3rvidEPjwBels5eMrK9DQ=;
        b=Ln2W2AUEhLjy/MER6Gns0nuuMT7+dG7z33AxpT0p8Bchf2UZcmxCLD4zBTiGY6Cphx
         KdnfjHdaXZy5Y2S1LJPBIbZM1zDUPAfhALCJGQmrJwg0XoGL1zfoDsjXs2p8J0ppBQ3o
         17ReNgLPqXRJe5m95s90HjdtMZjhQOx0+rUrAhd6o3fuAErvw+lKzjBtX8ucIITd+rm3
         py7fjsiQYcZDFVPJL13gfIbB4qRq/LutTfT3dA2FasDFXO+kmo4ukv2qD/qbS/JQdTu5
         1tP2AaeP/u8HWzvDmHi4a9QsaqE9Gdt2DhQ15vTPgCCn0qAg+ztMbTUlE6tBFpZoNeWD
         cj+w==
X-Gm-Message-State: ACgBeo3ZteScBRL1Zw5eBCgmQJs0IsRc25SVCLliC+VJ0O+ZpyNxLq4l
        loumjDkBughbU3n4XCRH87Mqy2qV1cMlCtCJh50=
X-Google-Smtp-Source: AA6agR42p5rkbE8sCWpMYfdup41Al1EYl3FCyQRWucakWGKFoLkxTabC0VIDOG3BRuaGnSFEoT8sO0fgCIdyYebzfIk=
X-Received: by 2002:a0d:d694:0:b0:325:1881:6a52 with SMTP id
 y142-20020a0dd694000000b0032518816a52mr12643988ywd.149.1659539092812; Wed, 03
 Aug 2022 08:04:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220518175002.GA1148748@bhelgaas> <20220802213511.GA738995@bhelgaas>
In-Reply-To: <20220802213511.GA738995@bhelgaas>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 3 Aug 2022 17:04:40 +0200
Message-ID: <CAJZ5v0hrrHvBwXThEjiWAxUcM3=NgsfYw+nTyXjdiTmNug_PbQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] driver core: Support asynchronous driver shutdown
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Tanjore Suresh <tansuresh@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 2, 2022 at 11:35 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [Beginning of thread: https://lore.kernel.org/r/20220517220816.1635044-2-tansuresh@google.com]
> On Wed, May 18, 2022 at 12:50:02PM -0500, Bjorn Helgaas wrote:
>
> > Devices have this async_suspend bit:
> >
> >   struct device {
> >     struct dev_pm_info {
> >       unsigned int async_suspend:1;
> >
> > Drivers call device_enable_async_suspend() to set async_suspend if
> > they want it.  The system suspend path is something like this:
> >
> >   suspend_enter
> >     dpm_suspend_noirq(PMSG_SUSPEND)
> >       dpm_noirq_suspend_devices(PMSG_SUSPEND)
> >         pm_transition = PMSG_SUSPEND
> >         while (!list_empty(&dpm_late_early_list))
> >           device_suspend_noirq(dev)
> >             dpm_async_fn(dev, async_suspend_noirq)
> >               if (is_async(dev))
> >                 async_schedule_dev(async_suspend_noirq)       # async path
> >
> >                   async_suspend_noirq               # called asynchronously
> >                   __device_suspend_noirq(dev, PMSG_SUSPEND, true)
> >                     callback = pm_noirq_op(PMSG_SUSPEND) # .suspend_noirq()
> >                     dpm_run_callback(callback)      # async call
> >
> >             __device_suspend_noirq(dev, pm_transition, false) # sync path
> >               callback = pm_noirq_op(PMSG_SUSPEND)  # .suspend_noirq()
> >               dpm_run_callback(callback)            # sync call
> >
> >         async_synchronize_full                                # wait
> >
> > If a driver has called device_enable_async_suspend(), we'll use the
> > async_schedule_dev() path to schedule the appropriate .suspend_noirq()
> > method.  After scheduling it via the async path or directly calling it
> > via the sync path, the async_synchronize_full() waits for completion
> > of all the async methods.
>
> Correct me if I'm wrong: in the suspend scenario, there are several
> phases, and async_synchronize_full() ensures that one phase finishes
> before the next phase starts.  For example:
>
>   dpm_suspend_end
>     dpm_suspend_late                             # phase 1
>       while (!list_empty(&dpm_suspended_list))
>         device_suspend_late
>       async_synchronize_full                     # finish phase 1
>     dpm_suspend_noirq                            # phase 2
>       dpm_noirq_suspend_devices
>         while (!list_empty(&dpm_late_early_list))
>           device_suspend_noirq
>       async_synchronize_full
>
> The device .suspend_late() and .suspend_noirq() methods may all be
> started asynchronously.  So far there's nothing to order them within
> the phase, but async_synchronize_full() ensures that all the
> .suspend_late() methods finish before the .suspend_noirq() methods
> start.
>
> Obviously we do want a child's method to complete before we run the
> parent's method.  If I understand correctly, that parent/child
> synchronization is done by a different method: __device_suspend_late()
> and __device_suspend_noirq() call dpm_wait_for_subordinate(), which
> waits for &dev->power.completion for all children:
>
>   __device_suspend_late
>     dpm_wait_for_subordinate
>       dpm_wait_for_children   # wait for children .suspend_late()
>         device_for_each_child(dev, &async, dpm_wait_fn)
>           dpm_wait_fn
>             dpm_wait
>               wait_for_completion(&dev->power.completion)
>     dpm_run_callback          # run parent method, e.g., ops->suspend_late
>     complete_all(&dev->power.completion)  # note completion of parent
>
> > I assume your suggestion is to do something like this:
> >
> >   struct device {
> >     struct dev_pm_info {
> >       unsigned int async_suspend:1;
> >  +    unsigned int async_shutdown:1;
> >
> >  + void device_enable_async_shutdown(struct device *dev)
> >  +   dev->power.async_shutdown = true;
> >
> >     device_shutdown
> >       while (!list_empty(&devices_kset->list))
> >  -      dev->...->shutdown()
> >  +      if (is_async_shutdown(dev))
> >  +        async_schedule_dev(async_shutdown)   # async path
> >  +
> >  +         async_shutdown               # called asynchronously
> >  +           dev->...->shutdown()
> >  +
> >  +      else
> >  +        dev->...->shutdown()                 # sync path
> >  +
> >  +    async_synchronize_full                   # wait
>
> In the shutdown case, I think we still probably need the
> async_synchronize_full() to ensure that all the .shutdown() methods
> complete before we turn the power off, reboot, or kexec.
>
> But I think we also need a mechanism like dev->power.completion to
> make sure all the child .shutdown() methods complete before we run a
> parent's .shutdown().
>
> There's not much overlap between the suspend path and the shutdown
> path (probably none at all), so it's tempting to use the existing
> dev->power.completion for shutdown as well.
>
> But I don't think that's feasible because dev->power.completion is
> tied up with dev->power.async_suspend, which is set by
> device_enable_async_suspend().  That's a different concept than async
> shutdown, and drivers will want one without the other.
>
> Does this make sense?

Well, why don't we change the code so that dev->power.completion is
not tied to dev->power.async_suspend, but can be also used
(analogously) if something like dev->async_shutdown is set?

My point is that we know how to suspend devices asynchronously (the
fact that there are multiple phases is not that important IMV), so why
don't we design the async shutdown analogously?
