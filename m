Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31EA52C1C7
	for <lists+linux-pci@lfdr.de>; Wed, 18 May 2022 20:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbiERSBs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 May 2022 14:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241289AbiERSBq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 May 2022 14:01:46 -0400
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87581939E6;
        Wed, 18 May 2022 11:01:44 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-2ef5380669cso32882947b3.9;
        Wed, 18 May 2022 11:01:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zDk6NauKjwb7+dYP97FBqP2+KL4BRIGaXu5bFlWZM28=;
        b=fXJzYZbuTU6jQlXNJbJNx1/rjrrMJRQ5Z2wshrwALdZ9Z/NF9PEYQxa1ain4l6Z9WN
         KO3GM2kLR1/gmPy+c6cADqvDPnh7Yi8wPLkQvLUiEdwdHRky1ktz+qAxk0fWy2K9i46c
         n0q58s9L4noK9HybcZJUEFJAcUeDFdwcqkzQFOvrTRdykwy4WJtNqo6ZhgoV4Wk41QPq
         XdyuVoEIPUOBVDbTo5XmQxELy9VqKJlHu8abnVn8K1UceRWA+X2TQisBaK+a4CzJU3Br
         wUpqhhh75y+DQvEdSfBtpe2+kBuIPhTEQM5ybzq0GePDIZA8r3/vX7mZurY8Ivs2++xH
         /7RA==
X-Gm-Message-State: AOAM531eBEPGDc5Hk0WAAOkXvbM8Cxaf3ZdGTKCzGCvrEtL/NsEy2Qzq
        EeVGuuHcj+VKT3p8Y3s7j5rWVwccHzuKVQqyT4Y=
X-Google-Smtp-Source: ABdhPJyNOE954oLPigE6w4SJ6IDRiedh5CklwdoQTcyCIuUS0q6iJR2b06bfZ2x3H0zFGahwRipvTYsJ2u30Nm2EGr0=
X-Received: by 2002:a0d:c8c3:0:b0:2fe:e9eb:664 with SMTP id
 k186-20020a0dc8c3000000b002fee9eb0664mr625308ywd.301.1652896903562; Wed, 18
 May 2022 11:01:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0ibBw41YSfSWF1CtY7w9oLO+8bKNK2AK0grE0qabJ6QQA@mail.gmail.com>
 <20220518175002.GA1148748@bhelgaas>
In-Reply-To: <20220518175002.GA1148748@bhelgaas>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 18 May 2022 20:01:32 +0200
Message-ID: <CAJZ5v0hOp0UuUjRL3AYS_WW+2BxZOaGwURrrSMGQvjpPe+sOmg@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 18, 2022 at 7:50 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, May 18, 2022 at 01:38:49PM +0200, Rafael J. Wysocki wrote:
> > On Wed, May 18, 2022 at 12:08 AM Tanjore Suresh <tansuresh@google.com> wrote:
> > >
> > > This changes the bus driver interface with additional entry points
> > > to enable devices to implement asynchronous shutdown. The existing
> > > synchronous interface to shutdown is unmodified and retained for
> > > backward compatibility.
> > >
> > > This changes the common device shutdown code to enable devices to
> > > participate in asynchronous shutdown implementation.
> > >
> > > Signed-off-by: Tanjore Suresh <tansuresh@google.com>
> > > ---
> > >  drivers/base/core.c        | 38 +++++++++++++++++++++++++++++++++++++-
> > >  include/linux/device/bus.h | 12 ++++++++++++
> > >  2 files changed, 49 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > > index 3d6430eb0c6a..ba267ae70a22 100644
> > > --- a/drivers/base/core.c
> > > +++ b/drivers/base/core.c
> > > @@ -4479,6 +4479,7 @@ EXPORT_SYMBOL_GPL(device_change_owner);
> > >  void device_shutdown(void)
> > >  {
> > >         struct device *dev, *parent;
> > > +       LIST_HEAD(async_shutdown_list);
> > >
> > >         wait_for_device_probe();
> > >         device_block_probing();
> > > @@ -4523,7 +4524,13 @@ void device_shutdown(void)
> > >                                 dev_info(dev, "shutdown_pre\n");
> > >                         dev->class->shutdown_pre(dev);
> > >                 }
> > > -               if (dev->bus && dev->bus->shutdown) {
> > > +               if (dev->bus && dev->bus->async_shutdown_start) {
> > > +                       if (initcall_debug)
> > > +                               dev_info(dev, "async_shutdown_start\n");
> > > +                       dev->bus->async_shutdown_start(dev);
> > > +                       list_add_tail(&dev->kobj.entry,
> > > +                               &async_shutdown_list);
> > > +               } else if (dev->bus && dev->bus->shutdown) {
> > >                         if (initcall_debug)
> > >                                 dev_info(dev, "shutdown\n");
> > >                         dev->bus->shutdown(dev);
> > > @@ -4543,6 +4550,35 @@ void device_shutdown(void)
> > >                 spin_lock(&devices_kset->list_lock);
> > >         }
> > >         spin_unlock(&devices_kset->list_lock);
> > > +
> > > +       /*
> > > +        * Second pass spin for only devices, that have configured
> > > +        * Asynchronous shutdown.
> > > +        */
> > > +       while (!list_empty(&async_shutdown_list)) {
> > > +               dev = list_entry(async_shutdown_list.next, struct device,
> > > +                               kobj.entry);
> > > +               parent = get_device(dev->parent);
> > > +               get_device(dev);
> > > +               /*
> > > +                * Make sure the device is off the  list
> > > +                */
> > > +               list_del_init(&dev->kobj.entry);
> > > +               if (parent)
> > > +                       device_lock(parent);
> > > +               device_lock(dev);
> > > +               if (dev->bus && dev->bus->async_shutdown_end) {
> > > +                       if (initcall_debug)
> > > +                               dev_info(dev,
> > > +                               "async_shutdown_end called\n");
> > > +                       dev->bus->async_shutdown_end(dev);
> > > +               }
> > > +               device_unlock(dev);
> > > +               if (parent)
> > > +                       device_unlock(parent);
> > > +               put_device(dev);
> > > +               put_device(parent);
> > > +       }
> > >  }
> > >
> > >  /*
> > > diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
> > > index a039ab809753..f582c9d21515 100644
> > > --- a/include/linux/device/bus.h
> > > +++ b/include/linux/device/bus.h
> > > @@ -49,6 +49,16 @@ struct fwnode_handle;
> > >   *             will never get called until they do.
> > >   * @remove:    Called when a device removed from this bus.
> > >   * @shutdown:  Called at shut-down time to quiesce the device.
> > > + * @async_shutdown_start:      Called at the shutdown-time to start
> > > + *                             the shutdown process on the device.
> > > + *                             This entry point will be called only
> > > + *                             when the bus driver has indicated it would
> > > + *                             like to participate in asynchronous shutdown
> > > + *                             completion.
> > > + * @async_shutdown_end:        Called at shutdown-time  to complete the shutdown
> > > + *                     process of the device. This entry point will be called
> > > + *                     only when the bus drive has indicated it would like to
> > > + *                     participate in the asynchronous shutdown completion.
> >
> > I'm going to repeat my point here, but only once.
> >
> > I see no reason to do async shutdown this way, instead of adding a
> > flag for drivers to opt in for calling their existing shutdown
> > callbacks asynchronously, in analogy with the async suspend and resume
> > implementation.
>
> There's a lot of code here that mere mortals like myself don't
> understand very well, so here's my meager understanding of how
> async suspend works and what you're suggesting to make this a
> little more concrete.
>
> Devices have this async_suspend bit:
>
>   struct device {
>     struct dev_pm_info {
>       unsigned int async_suspend:1;
>
> Drivers call device_enable_async_suspend() to set async_suspend if
> they want it.  The system suspend path is something like this:
>
>   suspend_enter
>     dpm_suspend_noirq(PMSG_SUSPEND)
>       dpm_noirq_suspend_devices(PMSG_SUSPEND)
>         pm_transition = PMSG_SUSPEND
>         while (!list_empty(&dpm_late_early_list))
>           device_suspend_noirq(dev)
>             dpm_async_fn(dev, async_suspend_noirq)
>               if (is_async(dev))
>                 async_schedule_dev(async_suspend_noirq)       # async path
>
>                   async_suspend_noirq               # called asynchronously
>                   __device_suspend_noirq(dev, PMSG_SUSPEND, true)
>                     callback = pm_noirq_op(PMSG_SUSPEND) # .suspend_noirq()
>                     dpm_run_callback(callback)      # async call
>
>             __device_suspend_noirq(dev, pm_transition, false) # sync path
>               callback = pm_noirq_op(PMSG_SUSPEND)  # .suspend_noirq()
>               dpm_run_callback(callback)            # sync call
>
>         async_synchronize_full                                # wait
>
> If a driver has called device_enable_async_suspend(), we'll use the
> async_schedule_dev() path to schedule the appropriate .suspend_noirq()
> method.  After scheduling it via the async path or directly calling it
> via the sync path, the async_synchronize_full() waits for completion
> of all the async methods.
>
> I assume your suggestion is to do something like this:
>
>   struct device {
>     struct dev_pm_info {
>       unsigned int async_suspend:1;
>  +    unsigned int async_shutdown:1;
>
>  + void device_enable_async_shutdown(struct device *dev)
>  +   dev->power.async_shutdown = true;
>
>     device_shutdown
>       while (!list_empty(&devices_kset->list))
>  -      dev->...->shutdown()
>  +      if (is_async_shutdown(dev))
>  +        async_schedule_dev(async_shutdown)   # async path
>  +
>  +         async_shutdown               # called asynchronously
>  +           dev->...->shutdown()
>  +
>  +      else
>  +        dev->...->shutdown()                 # sync path
>  +
>  +    async_synchronize_full                   # wait

Yes, that's the idea IIUC.
