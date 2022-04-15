Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D401502C16
	for <lists+linux-pci@lfdr.de>; Fri, 15 Apr 2022 16:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354626AbiDOOor (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Apr 2022 10:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354601AbiDOOoq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Apr 2022 10:44:46 -0400
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0C84091B;
        Fri, 15 Apr 2022 07:42:18 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id t67so14843280ybi.2;
        Fri, 15 Apr 2022 07:42:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VQSHKKZVZ0Nt1UyzeBgM0+KthK67tcnYKJdeT0jg73Y=;
        b=woSmk1w0v3r731HOfjLsGuCoC2uJuiiu6qrV6P45CFgQpo1T/NO6JYjp6UZDlNeIqz
         ddRqRtzDx7ao7Tf1f4NmHT4roftQF+7aKknfCVvC7LFUoLM7+16+sC10zZ0u9bB2RGw7
         rIx4oZWzRN6qO+c22GlPJOKTUVuujG26wC5Q62ASnRIV/wLmmk8nuHqZ0Ps7/i8XOcq4
         7jcI3+iwzzTprxqcC9NujB9IsgG6sip3r+k9eJpSCIEyD+Z2rLzEJmwRkkxKX7JpyReM
         wqkJO8PiOOAtDFSBx5wVi33KwSlsJbnUGX+7Khiiu85eVk4Fuqwu461OWtvYv+O+MFlM
         7o3Q==
X-Gm-Message-State: AOAM531e0OhLTWQTB4wPE2n12Udufywa78CA/pc8Tybbdklrl2rh2PTp
        /TeR56wg8W+++qzDdGBApOmWNCCvHi6mXsxsiLc=
X-Google-Smtp-Source: ABdhPJzHImZ6AlstLn7pVijrPVyShFWryTuDK7hJhgtHmoiyUY6jExoXezPsWwLknhi0wsShbmhDkbJ9zA8uv2Zpyuw=
X-Received: by 2002:a25:230d:0:b0:641:375c:b5ad with SMTP id
 j13-20020a25230d000000b00641375cb5admr5695905ybj.137.1650033737467; Fri, 15
 Apr 2022 07:42:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220412224348.1038613-1-tansuresh@google.com> <20220412224348.1038613-2-tansuresh@google.com>
In-Reply-To: <20220412224348.1038613-2-tansuresh@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 15 Apr 2022 16:42:06 +0200
Message-ID: <CAJZ5v0ivNq3aYCEcxPYMosLJCAyWiAnucwOCmRBzkM=sbyPWgQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] driver core: Support asynchronous driver shutdown
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

On Wed, Apr 13, 2022 at 12:44 AM Tanjore Suresh <tansuresh@google.com> wrote:
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

Is there any specific reason why you didn't follow the design of, say,
dpm_suspend(), where the "async" devices only need to have a flag set
and the driver is not required to implement any new callbacks?

IMO having different driver interfaces for asynchronous suspend and
shutdown would be quite confusing for driver developers, wouldn't it?

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
> 2.36.0.rc0.470.gd361397f0d-goog
>
