Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9286450B630
	for <lists+linux-pci@lfdr.de>; Fri, 22 Apr 2022 13:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447073AbiDVLfD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Apr 2022 07:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbiDVLfD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Apr 2022 07:35:03 -0400
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7065522E;
        Fri, 22 Apr 2022 04:32:09 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-2f7b815ac06so6033637b3.3;
        Fri, 22 Apr 2022 04:32:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w+N4ZWpI0+PQOfLRjSNdx0PsiQia2QU6bx7J+BbT/zk=;
        b=lfsNhW4PDKf6BcH/hEM7rRAbiSVnY6Mn6VcWf8U4R8Iv0Jl1I6JSUFdiu0OKi3rrid
         ugx/1hCPm4vNLUU7fn7/RYZMDSQ9Xfj8pFrPqi7zNHBU7yTiD23y7z/PmZKC++Xeo+/k
         Ir7dQds8D4OOrEpF8XtYnqcCocO5STLh5+YQqQ3RQbWO9fZdDbJJJBhNIBxINntOF3T4
         /Xz+gvOVA+eIeJ5iw+wXbUUrmxc5SLbiYlS+SjXQyXfNeEeYoLY9EEBBwrfNNc7ZDYxn
         n7oY1rFlNlA8AGgXTDDupBKaAfMAgZU6Okp0es+fghHy/hbJ90qItlkIazPq6CB0AEI7
         c8pw==
X-Gm-Message-State: AOAM533U2oTl/yCCa4Ua68gESPkVE/m8inv/j+WiiIkfkcAjwR8DiV0f
        k0sCjvaGeqXftTWyjoGesQ3xlJekRlkDWNpouKc=
X-Google-Smtp-Source: ABdhPJzhcfd5/sMJ5Hx7nUCRnhMQ1D+lKwdLXzcaE+X5qIcAiNtBqdVjCkuSjmzCcvuBib7Y7rrJT9Xfqt+pbsGl0fA=
X-Received: by 2002:a81:8843:0:b0:2f1:502c:def2 with SMTP id
 y64-20020a818843000000b002f1502cdef2mr4192351ywf.515.1650627128910; Fri, 22
 Apr 2022 04:32:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220422080404.27724-1-yangyicong@hisilicon.com>
In-Reply-To: <20220422080404.27724-1-yangyicong@hisilicon.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 22 Apr 2022 13:31:56 +0200
Message-ID: <CAJZ5v0hMxaVPsy9=w1nKhw1PbN0_8FnpJr5wPM24YZKy=--j9Q@mail.gmail.com>
Subject: Re: [PATCH v4] PCI: Make sure the bus bridge powered on when scanning bus
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
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

On Fri, Apr 22, 2022 at 10:06 AM Yicong Yang <yangyicong@hisilicon.com> wrote:
>
> When the bus bridge is runtime suspended, we'll fail to rescan
> the devices through sysfs as we cannot access the configuration
> space correctly when the bridge is in D3hot.
> It can be reproduced like:
>
> $ echo 1 > /sys/bus/pci/devices/0000:80:00.0/0000:81:00.1/remove
> $ echo 1 > /sys/bus/pci/devices/0000:80:00.0/pci_bus/0000:81/rescan
>
> 0000:80:00.0 is root port and is runtime suspended and we cannot
> get 0000:81:00.1 after rescan.

I would rephrase this in the following way:

0000:80:00.0 is a Root Port and it is runtime-suspended, so
0000:81:00.1 is unreachable after a rescan.

>
> Make bridge powered on when scanning the child bus, by adding

"Power up the bridge when scanning the child bus and allow it to
suspend again by adding ..."

> pm_runtime_get_sync()/pm_runtime_put() in pci_scan_child_bus_extend().
>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>

With the above addressed, please feel free to add

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
> Change since v3:
> - retain the pm_runtime_*() calls in pci_scan_bridge_extend() as Rafael points
>   out that it's necessary when the brigde is in D3cold
> Link: https://lore.kernel.org/linux-pci/20220414123736.34150-1-yangyicong@hisilicon.com/
>
> Change since v2:
> - just rebase it on v5.18-rc2
> Link: https://lore.kernel.org/linux-pci/1601029386-4928-1-git-send-email-yangyicong@hisilicon.com/
>
> Change since v1:
> - use an intermediate variable *bridge as suggested
> - remove the pm_runtime_*() calls in pci_scan_bridge_extend()
> Link: https://lore.kernel.org/linux-pci/1596022223-4765-1-git-send-email-yangyicong@hisilicon.com/
>
>  drivers/pci/probe.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 17a969942d37..b108e72b6586 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2859,11 +2859,20 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
>         unsigned int used_buses, normal_bridges = 0, hotplug_bridges = 0;
>         unsigned int start = bus->busn_res.start;
>         unsigned int devfn, fn, cmax, max = start;
> +       struct pci_dev *bridge = bus->self;
>         struct pci_dev *dev;
>         int nr_devs;
>
>         dev_dbg(&bus->dev, "scanning bus\n");
>
> +       /*
> +        * Make sure the bus bridge is powered on, otherwise we may not be
> +        * able to scan the devices as we may fail to access the configuration
> +        * space of subordinates.
> +        */
> +       if (bridge)
> +               pm_runtime_get_sync(&bridge->dev);
> +
>         /* Go find them, Rover! */
>         for (devfn = 0; devfn < 256; devfn += 8) {
>                 nr_devs = pci_scan_slot(bus, devfn);
> @@ -2976,6 +2985,9 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
>                 }
>         }
>
> +       if (bridge)
> +               pm_runtime_put(&bridge->dev);
> +
>         /*
>          * We've scanned the bus and so we know all about what's on
>          * the other side of any bridges that may be on this bus plus
> --
> 2.24.0
>
