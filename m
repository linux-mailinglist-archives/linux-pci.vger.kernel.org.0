Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF0792C28EA
	for <lists+linux-pci@lfdr.de>; Tue, 24 Nov 2020 15:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbgKXOB1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Nov 2020 09:01:27 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37602 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727161AbgKXOAy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Nov 2020 09:00:54 -0500
Received: by mail-oi1-f193.google.com with SMTP id j15so18536072oih.4;
        Tue, 24 Nov 2020 06:00:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MMxyaPdI5i63a9I9pY9fTE+BbPQuigoaoOJPLNSYJ2s=;
        b=r9DZAJNjWR07M8ZzEueuffHZZw86lPP5fZ/RhtKHHktB8PF+eWNBvVHUD7XkDxqKVv
         EjblOXGhGUQ9yU7cAR0qJBX9fFYwfc2gN16RC352V6DsSV7nfnn+niwMQeSBSZE8Ys1v
         hwCveN0VLWNqYFBrc18Kl/BpjrM+gybwAaD5FuG8YKn0cbgfpYry/NCVs6qDP8LDgInr
         b7MpAf5PnMIMzGzuNXH69exJlrrRek2i5rEcZgkyaNpS/j1fphdEdaxqS3HwkEagwnv8
         BReqLZDzceA7+wXK/jEa2SyVjp2haNW10tYg8h8G3pJpzC4Ap4POSirpZM5y1mlIZiIZ
         U1aA==
X-Gm-Message-State: AOAM530WxwyMQ92QprmD/qHZXanMjdEnTMXeKtMQudUfUBcKNrHdGNXi
        mXdEacZDjJMyrtVeKeCuIsL7xbNcObKYT/43RmNv7ZzgWyU=
X-Google-Smtp-Source: ABdhPJw+ybHJH61zUKzHZFG6zHwAKsK1g7zJuox9jKv1ibbKo8nJt3lqKI9LJt2PJtbi4zSUuqZma0bWsSidJ8pPupo=
X-Received: by 2002:aca:5a42:: with SMTP id o63mr2758594oib.69.1606226452885;
 Tue, 24 Nov 2020 06:00:52 -0800 (PST)
MIME-Version: 1.0
References: <20201124073619.771940-1-kai.heng.feng@canonical.com>
In-Reply-To: <20201124073619.771940-1-kai.heng.feng@canonical.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 24 Nov 2020 15:00:41 +0100
Message-ID: <CAJZ5v0iJ_x5oXL9gG_TvCriNnPwzZYvGkkEK6_HWrH4fmCqBxQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: PM: Re-enable ACPI GPE if it's already enabled
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 24, 2020 at 8:36 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> Dell Precision 5550 fails to detect Thunderbolt device hotplug events,
> once the Thunderbolt device and its root port are runtime-suspended to
> D3cold.
>
> While putting the entire hierarchy to D3cold, the root port ACPI GPE is
> enabled via acpi_pci_propagate_wakeup() when suspending Thunderbolt
> bridges/switches. So when putting the root port to D3cold as last step,
> ACPI GPE is untouched as it's already enabled.
>
> However, platform may need PCI devices to be in D3hot or PME enabled
> prior enabling GPE to make it work.

What platforms and why.

> So re-enable ACPI GPE to address this.
>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/acpi/device_pm.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> index 94d91c67aeae..dc25d9d204ae 100644
> --- a/drivers/acpi/device_pm.c
> +++ b/drivers/acpi/device_pm.c
> @@ -757,11 +757,10 @@ static int __acpi_device_wakeup_enable(struct acpi_device *adev,
>
>         mutex_lock(&acpi_wakeup_lock);
>
> -       if (wakeup->enable_count >= max_count)
> -               goto out;
> -
> -       if (wakeup->enable_count > 0)
> -               goto inc;
> +       if (wakeup->enable_count > 0) {
> +               acpi_disable_gpe(wakeup->gpe_device, wakeup->gpe_number);
> +               acpi_disable_wakeup_device_power(adev);
> +       }

An event occurring at this point may be lost after this patch.

It looks like you are trying to work around a hardware issue.  Can you
please describe that issue in detail?

>
>         error = acpi_enable_wakeup_device_power(adev, target_state);
>         if (error)
> @@ -777,8 +776,8 @@ static int __acpi_device_wakeup_enable(struct acpi_device *adev,
>         acpi_handle_debug(adev->handle, "GPE%2X enabled for wakeup\n",
>                           (unsigned int)wakeup->gpe_number);
>
> -inc:
> -       wakeup->enable_count++;
> +       if (wakeup->enable_count < max_count)
> +               wakeup->enable_count++;
>
>  out:
>         mutex_unlock(&acpi_wakeup_lock);
> --
> 2.29.2
>
