Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 937BCEDC9E
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2019 11:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfKDKdU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Nov 2019 05:33:20 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33787 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbfKDKdT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Nov 2019 05:33:19 -0500
Received: by mail-oi1-f194.google.com with SMTP id m193so13651323oig.0;
        Mon, 04 Nov 2019 02:33:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eUYgEek/cRm6eq9bDy7izPNUN1OCMTXdnE7hSkLe8eo=;
        b=dmksKEM7trHth5/5bHV9mAWPcdvneqQk+M6S1N7JD5MD1QaGDLebUOOeIBlzOGmVu9
         oWvn0H1gcPCEBoyE8u1+QxBkp8dN4FhzQQGvpwkfZisXEBQEFjXgXMVe8d4Y3fUdabVm
         FL14T5ywYDfkBncO+aU7xtCDaAVsa56ExBZ27SKE+lgDfEBfljfHx/gOoO9n3RxVI4r8
         eKfYB+QT+A74gz8cD5wbcvkdIBPiQfLBGPmarEKdzA1shd41NceE4qBzx2Y6WIu9acOy
         grkjPRswG+TmpYyYA/Co924S9HWQFD/v7bbSUGVAfQ+DJo6EAQJfuCmsnVEeUADOZhB1
         Qz0w==
X-Gm-Message-State: APjAAAUed5vn7De+LZRxg0LuqhS+856fTyiz50gcW5F8ffPfUseqAttl
        keGFjo6V70utIzVkEoNAhVj2/x30glwITN1+67o=
X-Google-Smtp-Source: APXvYqxwOv2oSSP7G4VFlxkKUpUbS5TG5WkPHeZA+6F1JlC6v4Pz1D3tRYYexQ4/sKcrolXXNL8lNaRuq4lsmSQfIQI=
X-Received: by 2002:aca:1b05:: with SMTP id b5mr16084441oib.103.1572863598712;
 Mon, 04 Nov 2019 02:33:18 -0800 (PST)
MIME-Version: 1.0
References: <20191101204558.210235-1-helgaas@kernel.org> <20191101204558.210235-6-helgaas@kernel.org>
In-Reply-To: <20191101204558.210235-6-helgaas@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 4 Nov 2019 11:33:07 +0100
Message-ID: <CAJZ5v0j__XPd53Z6phesoRSVnYcHWpU9p69+UFsGHReWyKEUcA@mail.gmail.com>
Subject: Re: [PATCH 5/6] PCI/PM: Remove unused pci_driver.resume_early() hook
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 1, 2019 at 9:47 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> The struct pci_driver.resume_early() hook is one of the legacy PCI power
> management callbacks, and there are no remaining users of it.  Remove it.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  Documentation/power/pci.rst |  2 +-
>  drivers/pci/pci-driver.c    | 23 ++++++-----------------
>  include/linux/pci.h         |  2 --
>  3 files changed, 7 insertions(+), 20 deletions(-)
>
> diff --git a/Documentation/power/pci.rst b/Documentation/power/pci.rst
> index a90e82c70a3b..ff7029b94068 100644
> --- a/Documentation/power/pci.rst
> +++ b/Documentation/power/pci.rst
> @@ -692,7 +692,7 @@ controlling the runtime power management of their devices.
>  At the time of this writing there are two ways to define power management
>  callbacks for a PCI device driver, the recommended one, based on using a
>  dev_pm_ops structure described in Documentation/driver-api/pm/devices.rst, and
> -the "legacy" one, in which the .suspend(), .suspend_late(), .resume_early(), and
> +the "legacy" one, in which the .suspend(), .suspend_late(), and
>  .resume() callbacks from struct pci_driver are used.  The legacy approach,
>  however, doesn't allow one to define runtime power management callbacks and is
>  not really suitable for any new drivers.  Therefore it is not covered by this
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 5337cbbd69de..fc372c2d529a 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -630,15 +630,6 @@ static int pci_legacy_suspend_late(struct device *dev, pm_message_t state)
>         return 0;
>  }
>
> -static int pci_legacy_resume_early(struct device *dev)
> -{
> -       struct pci_dev *pci_dev = to_pci_dev(dev);
> -       struct pci_driver *drv = pci_dev->driver;
> -
> -       return drv && drv->resume_early ?
> -                       drv->resume_early(pci_dev) : 0;
> -}
> -
>  static int pci_legacy_resume(struct device *dev)
>  {
>         struct pci_dev *pci_dev = to_pci_dev(dev);
> @@ -662,8 +653,7 @@ static void pci_pm_default_suspend(struct pci_dev *pci_dev)
>  static bool pci_has_legacy_pm_support(struct pci_dev *pci_dev)
>  {
>         struct pci_driver *drv = pci_dev->driver;
> -       bool ret = drv && (drv->suspend || drv->suspend_late || drv->resume
> -               || drv->resume_early);
> +       bool ret = drv && (drv->suspend || drv->suspend_late || drv->resume);
>
>         /*
>          * Legacy PM support is used by default, so warn if the new framework is
> @@ -944,7 +934,7 @@ static int pci_pm_resume_noirq(struct device *dev)
>         pcie_pme_root_status_cleanup(pci_dev);
>
>         if (pci_has_legacy_pm_support(pci_dev))
> -               return pci_legacy_resume_early(dev);
> +               return 0;
>
>         if (pm && pm->resume_noirq)
>                 return pm->resume_noirq(dev);
> @@ -1074,9 +1064,8 @@ static int pci_pm_thaw_noirq(struct device *dev)
>         }
>
>         /*
> -        * Both the legacy ->resume_early() and the new pm->thaw_noirq()
> -        * callbacks assume the device has been returned to D0 and its
> -        * config state has been restored.
> +        * The pm->thaw_noirq() callback assumes the device has been
> +        * returned to D0 and its config state has been restored.
>          *
>          * In addition, pci_restore_state() restores MSI-X state in MMIO
>          * space, which requires the device to be in D0, so return it to D0
> @@ -1087,7 +1076,7 @@ static int pci_pm_thaw_noirq(struct device *dev)
>         pci_restore_state(pci_dev);
>
>         if (pci_has_legacy_pm_support(pci_dev))
> -               return pci_legacy_resume_early(dev);
> +               return 0;
>
>         if (pm && pm->thaw_noirq)
>                 return pm->thaw_noirq(dev);
> @@ -1219,7 +1208,7 @@ static int pci_pm_restore_noirq(struct device *dev)
>         pci_fixup_device(pci_fixup_resume_early, pci_dev);
>
>         if (pci_has_legacy_pm_support(pci_dev))
> -               return pci_legacy_resume_early(dev);
> +               return 0;
>
>         if (pm && pm->restore_noirq)
>                 return pm->restore_noirq(dev);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 4846306d521c..dd4596fc1208 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -806,7 +806,6 @@ struct module;
>   *             context, so it can sleep.
>   * @suspend:   Put device into low power state.
>   * @suspend_late: Put device into low power state.
> - * @resume_early: Wake device from low power state.
>   * @resume:    Wake device from low power state.
>   *             (Please see Documentation/power/pci.rst for descriptions
>   *             of PCI Power Management and the related functions.)
> @@ -830,7 +829,6 @@ struct pci_driver {
>         void (*remove)(struct pci_dev *dev);    /* Device removed (NULL if not a hot-plug capable driver) */
>         int  (*suspend)(struct pci_dev *dev, pm_message_t state);       /* Device suspended */
>         int  (*suspend_late)(struct pci_dev *dev, pm_message_t state);
> -       int  (*resume_early)(struct pci_dev *dev);
>         int  (*resume)(struct pci_dev *dev);    /* Device woken up */
>         void (*shutdown)(struct pci_dev *dev);
>         int  (*sriov_configure)(struct pci_dev *dev, int num_vfs); /* On PF */
> --
> 2.24.0.rc1.363.gb1bccd3e3d-goog
>
