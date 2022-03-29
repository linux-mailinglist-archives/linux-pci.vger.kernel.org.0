Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD17C4EA419
	for <lists+linux-pci@lfdr.de>; Tue, 29 Mar 2022 02:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbiC2AVa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Mar 2022 20:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbiC2AV3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Mar 2022 20:21:29 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0EC1A8446;
        Mon, 28 Mar 2022 17:19:47 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id b17so3567640qvf.12;
        Mon, 28 Mar 2022 17:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J4KWyw+cBk0gVXSu6o+Qb1G52uK0CGpmkgICaiSVqZs=;
        b=Qk858fVefCwfKCcCvuirzO8bJ3QEwDEAfm3XTiLYVS2FLCILT82FPyoy0htIbrMnjl
         mfN5YSilnRArHiQSunYS8crTFlFs9Ky4qPptKklEunn2UFJaTlj29f44qLFaZh1BzTst
         ecokfV7WxIKiWif0kiedmSTT8qvQVO7f8j5K8k/nOeivXtzyvtW5TSQ+qrAe3+fCp+Ei
         WqE5HEFKXIlgTunCPHBinajoalBYS4GzfB+fGUVTJCLSahTPb9i9/UiNo1sqNrdYpFz1
         Uh2rNQgCSUiNhrqGedcD3ySUd0hrtiPbRAAaf7mX8QunxNAJ5SyZLtYLtru67kVwxoRA
         3ESw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J4KWyw+cBk0gVXSu6o+Qb1G52uK0CGpmkgICaiSVqZs=;
        b=va3ZebGlDT5yJEt/1GiPtemErlece8reFcC2lJSMx8QYr8/3hBZO9xbIpPMBdEMzXw
         nma8S/RZOZ6xgsKSaeR0YNqLs5dQqD5XB7AckpVLOVeugXkxDwUbO6Ih5ynxyOYTrgTi
         m0GkZrmb7Y4UQQN65/yuKZrDm6mdgOO8RsvXx6G2qXHvPFdlo9/Im4xIbBI14hvQ6icN
         hlak52URaIAiBscyjooH9sHFocxBiH5BfLR5dBtNRhrwfxNx7G4zyxegVAmxtG2dR4ER
         u21HYsOP57R5+lOrTFR/wFR6+3DxT/y7/5xbAMK9E8oTuereOPlk/rWYlmMAA5ojf5YN
         gwlQ==
X-Gm-Message-State: AOAM532twfOAy0T1h72yVXmfTzGkzoS8FNOE/aMWT9YrpDb5Esw5YEtI
        JYR12QQ2FLNwwhRDI76SEQu3Tv60wX8OvGiGObqpnVcNxSQre7Sv
X-Google-Smtp-Source: ABdhPJzY7Spohg7KN8yaF7RFjnYSwUWMIYI/+E9RRCjsD7lKw1zcdkgUYs4iRHD/pWxInEtfi4Kax4tFZCZdvAqSAkc=
X-Received: by 2002:a05:6214:1043:b0:441:1a79:12a5 with SMTP id
 l3-20020a056214104300b004411a7912a5mr23595610qvr.42.1648513186553; Mon, 28
 Mar 2022 17:19:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220328230008.3587975-1-tansuresh@google.com> <20220328230008.3587975-2-tansuresh@google.com>
In-Reply-To: <20220328230008.3587975-2-tansuresh@google.com>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Tue, 29 Mar 2022 11:19:35 +1100
Message-ID: <CAOSf1CHnaKrSH0XwKMBuUmMAuc2q6MaHaZPqVoUia9MYqMjgGg@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] driver core: Support asynchronous driver shutdown
To:     Tanjore Suresh <tansuresh@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 29, 2022 at 10:35 AM Tanjore Suresh <tansuresh@google.com> wrote:
>
> This changes the bus driver interface with additional entry points
> to enable devices to implement asynchronous shutdown. The existing
> synchronous interface to shutdown is unmodified and retained for
> backward compatibility.
>
> This changes the common device shutdown code to enable devices to
> participate in asynchronous shutdown implementation.

nice to see someone looking at improving the shutdown path

> Signed-off-by: Tanjore Suresh <tansuresh@google.com>
> ---
>  drivers/base/core.c        | 39 +++++++++++++++++++++++++++++++++++++-
>  include/linux/device/bus.h | 10 ++++++++++
>  2 files changed, 48 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 3d6430eb0c6a..359e7067e8b8 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -4479,6 +4479,7 @@ EXPORT_SYMBOL_GPL(device_change_owner);
> *snip*

This all seems a bit dangerous and I'm wondering what systems you've
tested these changes with. I had a look at implementing something
similar a few years ago and one case that always concerned me was
embedded systems where the PCIe root complex also has a driver bound.
Say you've got the following PCIe topology:

00:00.0 - root port
01:00.0 - nvme drive

With the current implementation of device_shutdown() we can guarantee
that the child device (the nvme) is shut down before we start trying
to shut down the parent device (the root complex) so there's no
possibility of deadlocks and other dependency headaches. With this
implementation of async shutdown we lose that guarantee and I'm not
sure what the consequences are. Personally I was never able to
convince myself it was safe, but maybe you're braver than I am :)

That all said, there's probably only a few kinds of device that will
really want to implement async shutdown support so maybe you can
restrict it to leaf devices and flip the ordering around to something
like:

for_each_device(dev) {
   if (can_async(dev) && has_no_children(dev))
      start_async_shutdown(dev)
}
wait_for_all_async_shutdowns_to_finish()

// tear down the remaining system devices synchronously
for_each_device(dev)
   do_sync_shutdown(dev)

>  /*
> diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
> index a039ab809753..e261819601e9 100644
> --- a/include/linux/device/bus.h
> +++ b/include/linux/device/bus.h
> @@ -93,6 +101,8 @@ struct bus_type {
>         void (*sync_state)(struct device *dev);
>         void (*remove)(struct device *dev);
>         void (*shutdown)(struct device *dev);
> +       void (*shutdown_pre)(struct device *dev);
> +       void (*shutdown_post)(struct device *dev);

Call them shutdown_async_start() / shutdown_async_end() or something
IMO. These names are not at all helpful and they're easy to mix up
their role with the class based shutdown_pre / _post
