Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4C0EDCA2
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2019 11:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbfKDKeN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Nov 2019 05:34:13 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38078 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfKDKeN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Nov 2019 05:34:13 -0500
Received: by mail-ot1-f66.google.com with SMTP id v24so8659828otp.5;
        Mon, 04 Nov 2019 02:34:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O+0oqqGGuaOdZfsdrgOYDVdivyaqLZpWEZ5xgvYtJsE=;
        b=hNrkJqk2Yw1Bf5b+7u9/tmznK0TfAqtdY57QS+IVFd54eMxTPlyySV8SEId7IzuzTk
         5ZPutQLb07JGj3jyWXaN3MqazzOCTZxF+cO9+LrVayfocwYcDuECCD/GMZLGI+t7f9EQ
         2T3V9WZYdy+xa0xElJbWbVqk4ZvA2wE+PjXuVxwuKDzFIuQTDdyFbg8Bb8jC1SDAl2zz
         ObK9Zwrjbg0orYjTn6yYRdtE78se06H746s9TgBVpfygt3Z2qWpNW0v7DtLSQz6FMUlX
         UtBX5v00VsQBs0kaXviBZ6SQT5LWKAM+j+X+kd8++eumApMwLPmKcPYlWBrkpPIcTKoV
         +ObA==
X-Gm-Message-State: APjAAAXcq6obWuJQ2278r+OtWV23RPhihv77SsiS8z2LPBBZTuyTro0d
        N70WUOOqsHEhHhmYSb54ZXsSoo6Xnl22za31ZJo=
X-Google-Smtp-Source: APXvYqxvZULv2Vb1H7AcVVKmv/Nur283RO1s/mXHXqryJkiLTwJyQ5r5FTOTjtvsqBNorWe/D72yBZhM49NthNsHMvM=
X-Received: by 2002:a9d:5907:: with SMTP id t7mr7521976oth.118.1572863652336;
 Mon, 04 Nov 2019 02:34:12 -0800 (PST)
MIME-Version: 1.0
References: <20191101204558.210235-1-helgaas@kernel.org> <20191101204558.210235-7-helgaas@kernel.org>
In-Reply-To: <20191101204558.210235-7-helgaas@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 4 Nov 2019 11:34:01 +0100
Message-ID: <CAJZ5v0j_WscfyZcXA=iC+VVK2Oo0gvWB=5j5FbvPr9=xmQSCxA@mail.gmail.com>
Subject: Re: [PATCH 6/6] PCI/PM: Remove unused pci_driver.suspend_late() hook
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
> The struct pci_driver.suspend_late() hook is one of the legacy PCI power
> management callbacks, and there are no remaining users of it.  Remove it.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  Documentation/power/pci.rst | 10 +++++-----
>  drivers/pci/pci-driver.c    | 22 +---------------------
>  include/linux/pci.h         |  2 --
>  3 files changed, 6 insertions(+), 28 deletions(-)
>
> diff --git a/Documentation/power/pci.rst b/Documentation/power/pci.rst
> index ff7029b94068..0924d29636ad 100644
> --- a/Documentation/power/pci.rst
> +++ b/Documentation/power/pci.rst
> @@ -692,11 +692,11 @@ controlling the runtime power management of their devices.
>  At the time of this writing there are two ways to define power management
>  callbacks for a PCI device driver, the recommended one, based on using a
>  dev_pm_ops structure described in Documentation/driver-api/pm/devices.rst, and
> -the "legacy" one, in which the .suspend(), .suspend_late(), and
> -.resume() callbacks from struct pci_driver are used.  The legacy approach,
> -however, doesn't allow one to define runtime power management callbacks and is
> -not really suitable for any new drivers.  Therefore it is not covered by this
> -document (refer to the source code to learn more about it).
> +the "legacy" one, in which the .suspend() and .resume() callbacks from struct
> +pci_driver are used.  The legacy approach, however, doesn't allow one to define
> +runtime power management callbacks and is not really suitable for any new
> +drivers.  Therefore it is not covered by this document (refer to the source code
> +to learn more about it).
>
>  It is recommended that all PCI device drivers define a struct dev_pm_ops object
>  containing pointers to power management (PM) callbacks that will be executed by
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index fc372c2d529a..e89fd90eaa93 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -599,32 +599,12 @@ static int pci_legacy_suspend(struct device *dev, pm_message_t state)
>  static int pci_legacy_suspend_late(struct device *dev, pm_message_t state)
>  {
>         struct pci_dev *pci_dev = to_pci_dev(dev);
> -       struct pci_driver *drv = pci_dev->driver;
> -
> -       if (drv && drv->suspend_late) {
> -               pci_power_t prev = pci_dev->current_state;
> -               int error;
> -
> -               error = drv->suspend_late(pci_dev, state);
> -               suspend_report_result(drv->suspend_late, error);
> -               if (error)
> -                       return error;
> -
> -               if (!pci_dev->state_saved && pci_dev->current_state != PCI_D0
> -                   && pci_dev->current_state != PCI_UNKNOWN) {
> -                       pci_WARN_ONCE(pci_dev, pci_dev->current_state != prev,
> -                                     "PCI PM: Device state not saved by %pS\n",
> -                                     drv->suspend_late);
> -                       goto Fixup;
> -               }
> -       }
>
>         if (!pci_dev->state_saved)
>                 pci_save_state(pci_dev);
>
>         pci_pm_set_unknown_state(pci_dev);
>
> -Fixup:
>         pci_fixup_device(pci_fixup_suspend_late, pci_dev);
>
>         return 0;
> @@ -653,7 +633,7 @@ static void pci_pm_default_suspend(struct pci_dev *pci_dev)
>  static bool pci_has_legacy_pm_support(struct pci_dev *pci_dev)
>  {
>         struct pci_driver *drv = pci_dev->driver;
> -       bool ret = drv && (drv->suspend || drv->suspend_late || drv->resume);
> +       bool ret = drv && (drv->suspend || drv->resume);
>
>         /*
>          * Legacy PM support is used by default, so warn if the new framework is
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index dd4596fc1208..9b0e35e09874 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -805,7 +805,6 @@ struct module;
>   *             The remove function always gets called from process
>   *             context, so it can sleep.
>   * @suspend:   Put device into low power state.
> - * @suspend_late: Put device into low power state.
>   * @resume:    Wake device from low power state.
>   *             (Please see Documentation/power/pci.rst for descriptions
>   *             of PCI Power Management and the related functions.)
> @@ -828,7 +827,6 @@ struct pci_driver {
>         int  (*probe)(struct pci_dev *dev, const struct pci_device_id *id);     /* New device inserted */
>         void (*remove)(struct pci_dev *dev);    /* Device removed (NULL if not a hot-plug capable driver) */
>         int  (*suspend)(struct pci_dev *dev, pm_message_t state);       /* Device suspended */
> -       int  (*suspend_late)(struct pci_dev *dev, pm_message_t state);
>         int  (*resume)(struct pci_dev *dev);    /* Device woken up */
>         void (*shutdown)(struct pci_dev *dev);
>         int  (*sriov_configure)(struct pci_dev *dev, int num_vfs); /* On PF */
> --
> 2.24.0.rc1.363.gb1bccd3e3d-goog
>
