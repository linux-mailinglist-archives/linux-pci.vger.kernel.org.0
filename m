Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED2B3207439
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jun 2020 15:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387853AbgFXNQA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Jun 2020 09:16:00 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33293 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387687AbgFXNP7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Jun 2020 09:15:59 -0400
Received: by mail-oi1-f193.google.com with SMTP id i74so1801322oib.0;
        Wed, 24 Jun 2020 06:15:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zjK0dPHLhm19DBHlVxNA0U4i4q8aYKhrg6kBmBz0N3k=;
        b=lYlHzqwaUOXJOBLRN4vDWcUZLIrbxIMdlkLFbUjti9MIlO/NGos75ignDTtYvIZyL5
         OUc9jJM41aJRCWHkjSmz9veHkasmUCqjk2ftstapQxJM8w2sa1Q3E/G+Ax3oOFWmc7z9
         zZcctIXyiUt0yHGzSuYlY8i1XvFg36GZW+XzFc4SEvydEO6scj5QMKCdGNlCWPxs/r2a
         tlBLRYnnULaZvQEzD+Nq4Ahfq1IrZy3ugrPBwNeYRj1knK+gHkH+67vAa0dRWeR957IQ
         7FaWLLxPrqjYi3R5274rj0n6eCwrbFWDNIGM2eeY1PsgqmoHnq45o1A5/4wuXXkF692p
         Q2Xg==
X-Gm-Message-State: AOAM531EkCqBEB8ylV0SIJDIR2SaPTz+1qQB0OqKT1fUC2kp9M1ftpzs
        CeTaSJhPq6prTvHtpZM/Io5vebPe7CZj4hZnIng=
X-Google-Smtp-Source: ABdhPJzCTqdFOKgNYByBg4NJMvTMxVSB+bJyIxixLFXDTrbG1cz3410wy7PxwoccYbOMi3ceCDTEo/HzjkeeKa4B0+U=
X-Received: by 2002:a54:4585:: with SMTP id z5mr2238800oib.110.1593004558583;
 Wed, 24 Jun 2020 06:15:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0gQD_T9WmoF4gv-eDpmKto4_c0pJGiy_7FPiipSGOTrQQ@mail.gmail.com>
 <d41ead67-f66d-43fd-7a4c-e4d92adb52f2@virtuozzo.com> <7280140.ndZnX9ZZJL@kreacher>
 <5c06169c-295d-040b-07e1-823880584bb9@virtuozzo.com>
In-Reply-To: <5c06169c-295d-040b-07e1-823880584bb9@virtuozzo.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 24 Jun 2020 15:15:47 +0200
Message-ID: <CAJZ5v0jWDLbv_oyzOY5p-5bPLxD5aommXLDjE1eUkACOWwYpSw@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI / hotplug / PCI: lost acpiphp_put_context in acpiphp_grab_context()
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 23, 2020 at 9:01 PM Vasily Averin <vvs@virtuozzo.com> wrote:
>
> On 6/23/20 7:29 PM, Rafael J. Wysocki wrote:
> > On Tuesday, June 23, 2020 1:17:43 AM CEST Vasily Averin wrote:
> >> v2: followed to rafael@'s proposal
> >> Fixes: edf5bf34d408 ("ACPI / dock: Use callback pointers from devices' ACPI hotplug contexts")
> >> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> > Thanks for following my suggestion, but it occurred to me that it could still be
> > done in a better way.
> >
> > So instead of the above I'd prefer to apply the following change (added PCI and Bjorn
> > for visibility):
>
> Thank you,
> however could you please tell me what do you think about following variant?
>
>  drivers/pci/hotplug/acpiphp_glue.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> index b4c92cee13f8..5875c3654b52 100644
> --- a/drivers/pci/hotplug/acpiphp_glue.c
> +++ b/drivers/pci/hotplug/acpiphp_glue.c
> @@ -119,16 +119,17 @@ static inline void put_bridge(struct acpiphp_bridge *bridge)
>
>  static struct acpiphp_context *acpiphp_grab_context(struct acpi_device *adev)
>  {
> -       struct acpiphp_context *context;
> +       struct acpiphp_context *c, *context = NULL;
>
>         acpi_lock_hp_context();
> -       context = acpiphp_get_context(adev);
> -       if (!context || context->func.parent->is_going_away) {
> -               acpi_unlock_hp_context();
> -               return NULL;
> +       c = acpiphp_get_context(adev);
> +       if (c) {
> +               if (c->func.parent->is_going_away == false) {
> +                       get_bridge(c->func.parent);
> +                       context = c;
> +               }
> +               acpiphp_put_context(c);
>         }
> -       get_bridge(context->func.parent);
> -       acpiphp_put_context(context);
>         acpi_unlock_hp_context();
>         return context;
>  }

There are reasons to do it the way I want:
- The indentation level is minimum.
- The real purpose of this function is to get a parent bridge
reference, so that needs to be the central piece of it rather than the
checks for exceptional cases.
- The second local var is not necessary.

Thanks!
