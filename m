Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 633DBE5430
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2019 21:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfJYTSS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Oct 2019 15:18:18 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46491 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfJYTSS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Oct 2019 15:18:18 -0400
Received: by mail-pf1-f196.google.com with SMTP id b25so2195165pfi.13;
        Fri, 25 Oct 2019 12:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uru6k+OjlYmJbujCOonx7cGAPN2UZ1Lm9GwnmdSDJb0=;
        b=sMlwueiVMLIsHjaW604qfRIhcVkLKqoksBZrT1/1eqfUwOBtPsJXeSz3d3Xav0bCMM
         XC09KT0L3EfOA688bHzDcBPBU8X2NhYkut67KskS+Qn5RWj+dxcBV5QOiVQQdg3hWkhC
         uoKFEpr+4EoS+cEXQ1fn/ZOiSD3npr6x0pH+YPpyZDoK56ZU2IhETACFy/7FfzYCXSxd
         3dJbxxL3kzG9XV5dpGZeYHJSnQ94x/DT9qjJjo7POoI2MUruQ4rcnNrsueTL80QQQ3gQ
         Xt5SlzJNA9LJSesy/Yoec4qHF+T28s8O6s/Vb9J4QINTli9FDvhLg2YN1mBXRo2XVswA
         2PQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uru6k+OjlYmJbujCOonx7cGAPN2UZ1Lm9GwnmdSDJb0=;
        b=ZREzqcx0rMZIo4ZoAXLob5HF6IeLKcSwshtLDCrcF70Uzj8JR7vNJz0k9tAQ6ntOfI
         XHhgqBo1Ue86XoXrdObc7zJWQpVi39+4Rxefb1mJq027+dQPYrR6d6TbnuoAG4E5LBUJ
         1Mq8bVH4zmmQRcIgueylD+eYN6ba3CtJ/p8qooQ7UOxobCLCE9leFXnVkMeelKv2RYS7
         YGzkP5pEqQLG0TT7HFsyptAePkF/wgYR1GeozdG2QrwMG6mnVyW9+ppntxWIVFmk71Zq
         Uxui7t4oynZjeyM0ev30iI64dmztjEK0n9IaeaepnhDV+qznr50fOqJOAk3j9uyiSBPW
         E+qw==
X-Gm-Message-State: APjAAAWAcQZzbIIJtlxJ6MKb1s5dY07dDEw0on3eMu7Z0zaQYVBwC7tl
        WDI2kiPH8qw7rk7dQ4KQtSkDz5JKBIIwZ5fqc5Q=
X-Google-Smtp-Source: APXvYqxpmjXD5aFXMRnIUlwG0h5TP5ZxbIf+MMr0efM6zFEgffYmS1974Nb+Pg8BigmdDrnbkI730ezs9XECGVZmwe8=
X-Received: by 2002:a17:90a:f991:: with SMTP id cq17mr5758724pjb.30.1572031097244;
 Fri, 25 Oct 2019 12:18:17 -0700 (PDT)
MIME-Version: 1.0
References: <20191025190047.38130-1-stuart.w.hayes@gmail.com> <20191025190047.38130-4-stuart.w.hayes@gmail.com>
In-Reply-To: <20191025190047.38130-4-stuart.w.hayes@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 25 Oct 2019 22:18:06 +0300
Message-ID: <CAHp75Vdx9xVzgjPAxdMoSB=ZZx+Kc6yE4Ko3fn-gC6_+JtmT4g@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] PCI: pciehp: Add dmi table for in-band presence disabled
To:     Stuart Hayes <stuart.w.hayes@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Austin Bolen <austin_bolen@dell.com>,
        Keith Busch <keith.busch@intel.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 25, 2019 at 10:01 PM Stuart Hayes <stuart.w.hayes@gmail.com> wrote:
>
> Some systems have in-band presence detection disabled for hot-plug PCI
> slots, but do not report this in the slot capabilities 2 (SLTCAP2) register.
> On these systems, presence detect can become active well after the link is
> reported to be active, which can cause the slots to be disabled after a
> device is connected.
>
> Add a dmi table to flag these systems as having in-band presence disabled.
>

FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> ---
> v4
>   add comment to dmi table
>
>  drivers/pci/hotplug/pciehp_hpc.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 02d95ab27a12..9541735bd0aa 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -14,6 +14,7 @@
>
>  #define dev_fmt(fmt) "pciehp: " fmt
>
> +#include <linux/dmi.h>
>  #include <linux/kernel.h>
>  #include <linux/types.h>
>  #include <linux/jiffies.h>
> @@ -26,6 +27,24 @@
>  #include "../pci.h"
>  #include "pciehp.h"
>
> +static const struct dmi_system_id inband_presence_disabled_dmi_table[] = {
> +       /*
> +        * Match all Dell systems, as some Dell systems have inband
> +        * presence disabled on NVMe slots (but don't support the bit to
> +        * report it). Setting inband presence disabled should have no
> +        * negative effect, except on broken hotplug slots that never
> +        * assert presence detect--and those will still work, they will
> +        * just have a bit of extra delay before being probed.
> +        */
> +       {
> +               .ident = "Dell System",
> +               .matches = {
> +                       DMI_MATCH(DMI_OEM_STRING, "Dell System"),
> +               },
> +       },
> +       {}
> +};
> +
>  static inline struct pci_dev *ctrl_dev(struct controller *ctrl)
>  {
>         return ctrl->pcie->port;
> @@ -895,6 +914,9 @@ struct controller *pcie_init(struct pcie_device *dev)
>                 ctrl->inband_presence_disabled = 1;
>         }
>
> +       if (dmi_first_match(inband_presence_disabled_dmi_table))
> +               ctrl->inband_presence_disabled = 1;
> +
>         /*
>          * If empty slot's power status is on, turn power off.  The IRQ isn't
>          * requested yet, so avoid triggering a notification with this command.
> --
> 2.18.1
>


-- 
With Best Regards,
Andy Shevchenko
