Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2985883AC
	for <lists+linux-pci@lfdr.de>; Tue,  2 Aug 2022 23:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237102AbiHBVf0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Aug 2022 17:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237022AbiHBVfR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Aug 2022 17:35:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93B8DDD;
        Tue,  2 Aug 2022 14:35:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8F0FCB82103;
        Tue,  2 Aug 2022 21:35:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03521C433D6;
        Tue,  2 Aug 2022 21:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659476113;
        bh=sDdUdwBWvplP7SH3rsAyBZtLq4594pOoiv4EVIrlAgQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Dxr/rmm1wWZkd7LyxAdwLJ5Xz0ToNGAJU5kTpZX6bTdjDKDCsdqOcAvtpmcXZ1JeD
         Avkt6i8d4HbyJorqFqpWLCLiTicbwk3DXBCF+4TYwhXkF+G1xt9b6wkFAhWu8UdvQl
         itWH9BQ5Lt4SxFSg+JCjDq0T93AD79ELcoWl6RhhNTDX2hD51P8H53ab9xTByfH/Vh
         6Lw3fwlbAW1C95yWOgj9XMe9dEFLV6+aEfOGzhiW7TwFQp6tZMkr3FqzItyY2EfDKA
         LL8Ko+0YwJYn73/AN16s4C5sCt2aK7kel4FQ4LblWWD5a3AR0SVrYmHoQoj8nAgZVZ
         s/3enJP+sGhKg==
Date:   Tue, 2 Aug 2022 16:35:11 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Tanjore Suresh <tansuresh@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] driver core: Support asynchronous driver shutdown
Message-ID: <20220802213511.GA738995@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518175002.GA1148748@bhelgaas>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[Beginning of thread: https://lore.kernel.org/r/20220517220816.1635044-2-tansuresh@google.com]
On Wed, May 18, 2022 at 12:50:02PM -0500, Bjorn Helgaas wrote:

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

Correct me if I'm wrong: in the suspend scenario, there are several
phases, and async_synchronize_full() ensures that one phase finishes
before the next phase starts.  For example:

  dpm_suspend_end
    dpm_suspend_late                             # phase 1
      while (!list_empty(&dpm_suspended_list))
        device_suspend_late
      async_synchronize_full                     # finish phase 1
    dpm_suspend_noirq                            # phase 2
      dpm_noirq_suspend_devices
        while (!list_empty(&dpm_late_early_list))
          device_suspend_noirq
      async_synchronize_full

The device .suspend_late() and .suspend_noirq() methods may all be
started asynchronously.  So far there's nothing to order them within
the phase, but async_synchronize_full() ensures that all the
.suspend_late() methods finish before the .suspend_noirq() methods
start.

Obviously we do want a child's method to complete before we run the
parent's method.  If I understand correctly, that parent/child
synchronization is done by a different method: __device_suspend_late()
and __device_suspend_noirq() call dpm_wait_for_subordinate(), which
waits for &dev->power.completion for all children:

  __device_suspend_late
    dpm_wait_for_subordinate
      dpm_wait_for_children   # wait for children .suspend_late()
        device_for_each_child(dev, &async, dpm_wait_fn)
          dpm_wait_fn
            dpm_wait
              wait_for_completion(&dev->power.completion)
    dpm_run_callback          # run parent method, e.g., ops->suspend_late
    complete_all(&dev->power.completion)  # note completion of parent

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

In the shutdown case, I think we still probably need the
async_synchronize_full() to ensure that all the .shutdown() methods
complete before we turn the power off, reboot, or kexec.

But I think we also need a mechanism like dev->power.completion to
make sure all the child .shutdown() methods complete before we run a
parent's .shutdown().

There's not much overlap between the suspend path and the shutdown
path (probably none at all), so it's tempting to use the existing
dev->power.completion for shutdown as well.

But I don't think that's feasible because dev->power.completion is
tied up with dev->power.async_suspend, which is set by
device_enable_async_suspend().  That's a different concept than async
shutdown, and drivers will want one without the other.

Does this make sense?

Bjorn
