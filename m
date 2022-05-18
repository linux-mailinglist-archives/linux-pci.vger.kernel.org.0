Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F9552B8FD
	for <lists+linux-pci@lfdr.de>; Wed, 18 May 2022 13:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235814AbiERLjE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 May 2022 07:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235714AbiERLjD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 May 2022 07:39:03 -0400
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626791737FD;
        Wed, 18 May 2022 04:39:02 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id i11so3136958ybq.9;
        Wed, 18 May 2022 04:39:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zrwlit81NOfQDl1MFOpzqvUONSVA1zEjJ5vK5GKa7Pw=;
        b=5LAwZ/0aXU/TFm/3rmx7Bf7k7eNA7YPfYllc6rr80HyF64df52Kt6fmFBY4mcu9wF5
         L1Dbtq/nAi+r6KYY59ToEvz2ebQ1CFeS0mZikArLI1Sw+rwBBWC6dbxGjnn7EqvFt3vD
         7E+z9pe0yboQpZmJhvKjYLFvDBtLJl3e7Ewf0VaG4g4mfocw1iy+ZVYx9pmWGR/iZGMV
         a74TqR+aj5XoeQppTEWgpIipxY+Orh2nU3AV+nT8DQivRqIk+PdlYL6FxhzxTgMkLe4Z
         YDc7CXzbzhmNwiwBRhQWf3dI1PNwjtEGTr53gLMnoTyO0yjFA+AUGJodeEqF/q2/Qcwo
         y8TQ==
X-Gm-Message-State: AOAM533QJ2hMTDMbEa7mL8cRCMfCm1BzR+ObtE6JPyFhHhMlfaw7tIrK
        Qviwv3zPBhYU/XNquwlGc5ZX9XFbzEFlBGAzU3g=
X-Google-Smtp-Source: ABdhPJz1ujxrXfeaULJzzClaVci8qVX8qcy5AEI2vEsdX5a/9cHfhru7x3l9WTnfZuXXpfw8ZlAJM4f1hmEGjaIPrJY=
X-Received: by 2002:a25:7717:0:b0:64d:854f:2da4 with SMTP id
 s23-20020a257717000000b0064d854f2da4mr15356551ybc.633.1652873941589; Wed, 18
 May 2022 04:39:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220517220816.1635044-1-tansuresh@google.com> <20220517220816.1635044-2-tansuresh@google.com>
In-Reply-To: <20220517220816.1635044-2-tansuresh@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 18 May 2022 13:38:49 +0200
Message-ID: <CAJZ5v0ibBw41YSfSWF1CtY7w9oLO+8bKNK2AK0grE0qabJ6QQA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] driver core: Support asynchronous driver shutdown
To:     Tanjore Suresh <tansuresh@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
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

On Wed, May 18, 2022 at 12:08 AM Tanjore Suresh <tansuresh@google.com> wrote:
>
> This changes the bus driver interface with additional entry points
> to enable devices to implement asynchronous shutdown. The existing
> synchronous interface to shutdown is unmodified and retained for
> backward compatibility.
>
> This changes the common device shutdown code to enable devices to
> participate in asynchronous shutdown implementation.
>
> Signed-off-by: Tanjore Suresh <tansuresh@google.com>
> ---
>  drivers/base/core.c        | 38 +++++++++++++++++++++++++++++++++++++-
>  include/linux/device/bus.h | 12 ++++++++++++
>  2 files changed, 49 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 3d6430eb0c6a..ba267ae70a22 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -4479,6 +4479,7 @@ EXPORT_SYMBOL_GPL(device_change_owner);
>  void device_shutdown(void)
>  {
>         struct device *dev, *parent;
> +       LIST_HEAD(async_shutdown_list);
>
>         wait_for_device_probe();
>         device_block_probing();
> @@ -4523,7 +4524,13 @@ void device_shutdown(void)
>                                 dev_info(dev, "shutdown_pre\n");
>                         dev->class->shutdown_pre(dev);
>                 }
> -               if (dev->bus && dev->bus->shutdown) {
> +               if (dev->bus && dev->bus->async_shutdown_start) {
> +                       if (initcall_debug)
> +                               dev_info(dev, "async_shutdown_start\n");
> +                       dev->bus->async_shutdown_start(dev);
> +                       list_add_tail(&dev->kobj.entry,
> +                               &async_shutdown_list);
> +               } else if (dev->bus && dev->bus->shutdown) {
>                         if (initcall_debug)
>                                 dev_info(dev, "shutdown\n");
>                         dev->bus->shutdown(dev);
> @@ -4543,6 +4550,35 @@ void device_shutdown(void)
>                 spin_lock(&devices_kset->list_lock);
>         }
>         spin_unlock(&devices_kset->list_lock);
> +
> +       /*
> +        * Second pass spin for only devices, that have configured
> +        * Asynchronous shutdown.
> +        */
> +       while (!list_empty(&async_shutdown_list)) {
> +               dev = list_entry(async_shutdown_list.next, struct device,
> +                               kobj.entry);
> +               parent = get_device(dev->parent);
> +               get_device(dev);
> +               /*
> +                * Make sure the device is off the  list
> +                */
> +               list_del_init(&dev->kobj.entry);
> +               if (parent)
> +                       device_lock(parent);
> +               device_lock(dev);
> +               if (dev->bus && dev->bus->async_shutdown_end) {
> +                       if (initcall_debug)
> +                               dev_info(dev,
> +                               "async_shutdown_end called\n");
> +                       dev->bus->async_shutdown_end(dev);
> +               }
> +               device_unlock(dev);
> +               if (parent)
> +                       device_unlock(parent);
> +               put_device(dev);
> +               put_device(parent);
> +       }
>  }
>
>  /*
> diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
> index a039ab809753..f582c9d21515 100644
> --- a/include/linux/device/bus.h
> +++ b/include/linux/device/bus.h
> @@ -49,6 +49,16 @@ struct fwnode_handle;
>   *             will never get called until they do.
>   * @remove:    Called when a device removed from this bus.
>   * @shutdown:  Called at shut-down time to quiesce the device.
> + * @async_shutdown_start:      Called at the shutdown-time to start
> + *                             the shutdown process on the device.
> + *                             This entry point will be called only
> + *                             when the bus driver has indicated it would
> + *                             like to participate in asynchronous shutdown
> + *                             completion.
> + * @async_shutdown_end:        Called at shutdown-time  to complete the shutdown
> + *                     process of the device. This entry point will be called
> + *                     only when the bus drive has indicated it would like to
> + *                     participate in the asynchronous shutdown completion.

I'm going to repeat my point here, but only once.

I see no reason to do async shutdown this way, instead of adding a
flag for drivers to opt in for calling their existing shutdown
callbacks asynchronously, in analogy with the async suspend and resume
implementation.

Is there any reason why this is not viable?

>   *
>   * @online:    Called to put the device back online (after offlining it).
>   * @offline:   Called to put the device offline for hot-removal. May fail.
> @@ -93,6 +103,8 @@ struct bus_type {
>         void (*sync_state)(struct device *dev);
>         void (*remove)(struct device *dev);
>         void (*shutdown)(struct device *dev);
> +       void (*async_shutdown_start)(struct device *dev);
> +       void (*async_shutdown_end)(struct device *dev);
>
>         int (*online)(struct device *dev);
>         int (*offline)(struct device *dev);
> --
> 2.36.0.550.gb090851708-goog
>
