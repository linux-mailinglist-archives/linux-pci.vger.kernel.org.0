Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E05934475C
	for <lists+linux-pci@lfdr.de>; Mon, 22 Mar 2021 15:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbhCVOdS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Mar 2021 10:33:18 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:45707 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbhCVOdN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Mar 2021 10:33:13 -0400
Received: by mail-ot1-f45.google.com with SMTP id f73-20020a9d03cf0000b02901b4d889bce0so16099029otf.12;
        Mon, 22 Mar 2021 07:33:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tdNjLAFkKExyySktCu7V5Bpz2cnyF7BEvssvzh+7BTo=;
        b=cx7fy9+H1Y4XBo0UIHXufE+9Znzedi5tZRFBVZ+VltucEbGIHDrsenB4E+SDvyRL2y
         K9GyKeAPSFB5IIfaQEd+MRAU4b71JCHIWp6YmIBs/P/aG9OpwXObsmVEhuKVY/84GwtG
         qtYXrWdvhUAqNUglIwApUMhR67NY8vVZQXyeJVJSK4C+IdmQ2a7sEp0TQkXfIG4XNOXI
         7oqZVEWhW7w1kyLPYqg2WijKL2+Lw3gY5X8zXqqMIdwaKZlbZfk/k4dNV8ozOswJQ3w0
         e10qkWmCNiRJ+ztSXWye5F8M1BVTE3V2VpKXfp3taxpxORaUHwP5QsLWnVUdNQhZJbhG
         xG7g==
X-Gm-Message-State: AOAM532uiv+bW9VobhArHgxu73MHhpDICKpDbiTLAdLNZkZfVfA7wdxU
        MOPouJWn51iEq89R6/VxdtlEGQA0s18PMbMuHhw=
X-Google-Smtp-Source: ABdhPJzkJoMaAR9z6HBKHF/TbDPxYzvAs7IoZZ69mFl3/xeSpEaCq/3dEr0P7DpmqDnhQnVarA9hGPOVdV3gBE4ynSA=
X-Received: by 2002:a9d:4811:: with SMTP id c17mr233186otf.206.1616423593071;
 Mon, 22 Mar 2021 07:33:13 -0700 (PDT)
MIME-Version: 1.0
References: <3219454.74lMxhSOWB@kreacher>
In-Reply-To: <3219454.74lMxhSOWB@kreacher>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 22 Mar 2021 15:32:58 +0100
Message-ID: <CAJZ5v0gkhfRRGLpqLN555O7RG3jmScfxTTAzz6AgFrOoh42e=g@mail.gmail.com>
Subject: Re: [PATCH] PCI: PM: Do not read power state in pci_enable_device_flags()
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 16, 2021 at 4:52 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> It should not be necessary to update the current_state field of
> struct pci_dev in pci_enable_device_flags() before calling
> do_pci_enable_device() for the device, because none of the
> code between that point and the pci_set_power_state() call in
> do_pci_enable_device() invoked later depends on it.
>
> Moreover, doing that is actively harmful in some cases.  For example,
> if the given PCI device depends on an ACPI power resource whose _STA
> method initially returns 0 ("off"), but the config space of the PCI
> device is accessible and the power state retrieved from the
> PCI_PM_CTRL register is D0, the current_state field in the struct
> pci_dev representing that device will get out of sync with the
> power.state of its ACPI companion object and that will lead to
> power management issues going forward.
>
> To avoid such issues it is better to leave the current_state value
> as is until it is changed to PCI_D0 by do_pci_enable_device() as
> appropriate.  However, the power state of the device is not changed
> to PCI_D0 if it is already enabled when pci_enable_device_flags()
> gets called for it, so update its current_state in that case, but
> use pci_update_current_state() covering platform PM too for that.
>
> Link: https://lore.kernel.org/lkml/20210314000439.3138941-1-luzmaximilian@gmail.com/
> Reported-by: Maximilian Luz <luzmaximilian@gmail.com>
> Tested-by: Maximilian Luz <luzmaximilian@gmail.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Bjorn, can I take this, or do you want to take care of it yourself?

> ---
>
> Max, I've added a T-by from you even though the patch is slightly different
> from what you have tested, but the difference shouldn't matter for your case.
>
> ---
>  drivers/pci/pci.c |   16 +++-------------
>  1 file changed, 3 insertions(+), 13 deletions(-)
>
> Index: linux-pm/drivers/pci/pci.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/pci.c
> +++ linux-pm/drivers/pci/pci.c
> @@ -1870,20 +1870,10 @@ static int pci_enable_device_flags(struc
>         int err;
>         int i, bars = 0;
>
> -       /*
> -        * Power state could be unknown at this point, either due to a fresh
> -        * boot or a device removal call.  So get the current power state
> -        * so that things like MSI message writing will behave as expected
> -        * (e.g. if the device really is in D0 at enable time).
> -        */
> -       if (dev->pm_cap) {
> -               u16 pmcsr;
> -               pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> -               dev->current_state = (pmcsr & PCI_PM_CTRL_STATE_MASK);
> -       }
> -
> -       if (atomic_inc_return(&dev->enable_cnt) > 1)
> +       if (atomic_inc_return(&dev->enable_cnt) > 1) {
> +               pci_update_current_state(dev, dev->current_state);
>                 return 0;               /* already enabled */
> +       }
>
>         bridge = pci_upstream_bridge(dev);
>         if (bridge)
>
>
>
