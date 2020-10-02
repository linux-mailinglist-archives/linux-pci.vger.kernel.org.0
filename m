Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D24A12814D2
	for <lists+linux-pci@lfdr.de>; Fri,  2 Oct 2020 16:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388044AbgJBOR3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Oct 2020 10:17:29 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36383 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387688AbgJBOR2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Oct 2020 10:17:28 -0400
Received: by mail-ot1-f65.google.com with SMTP id 60so1491651otw.3;
        Fri, 02 Oct 2020 07:17:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2xfW2r+5F5TUfquNrBpvFl+fZupXfBEeJ3aS3h1+V9U=;
        b=KxHyd+Cpn8my+XDksA+kge3Q4E/DA6mseVh9Qss5SyWMacbSiOWAc4M1Wfso8jqcgo
         ZLBVFvRLMpyZeIMb1IKQp747uRCeBt0PrZ3X1yka49t+47NCPwEwDLEVbmr1zioNEnVN
         uaYpg2PAselQOd2ur9rvcyXQjYfPADlU4rPgHx3i/KY6NLJU6anrS1gC9tw0GxK20YQg
         Xf5tdyFpkLuEDJMl+DRbFQEo0YgBeWcASDh8IBQJWBk0Et3HieUHJdemjMlAzD8u73cv
         bj161AlKWBDMVc29W0GjOa83xx9lUuB1H4SedgO4IsbhjKEyE/pqtNaISlQ05qSOmYCd
         1t1w==
X-Gm-Message-State: AOAM533wzup4ZIpMdGHNtd69vnPpBKx9D4k2EcZwTVeJQMBmNbYIfkWa
        1+KqYdA78kbGAVv2DVRsn1kgH2hJ4LK35T1+ttM=
X-Google-Smtp-Source: ABdhPJzXm554JtWA/ocFLcb2CIIiiUOnto9zamZpCzFCyUU6KYxt5wXGwLT9IKo1P4fJiendlJDRKnxDcdkSXViCSjg=
X-Received: by 2002:a9d:718a:: with SMTP id o10mr1888736otj.262.1601648247890;
 Fri, 02 Oct 2020 07:17:27 -0700 (PDT)
MIME-Version: 1.0
References: <cea9071dc46025f0d89cdfcec0642b7bfa45968a.1601614985.git.lukas@wunner.de>
In-Reply-To: <cea9071dc46025f0d89cdfcec0642b7bfa45968a.1601614985.git.lukas@wunner.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 2 Oct 2020 16:17:15 +0200
Message-ID: <CAJZ5v0h5dHp6C8rx-B-hS=6hJOvTHuY1K4590qkNzCAkoivK4g@mail.gmail.com>
Subject: Re: [PATCH] PCI/ACPI: Whitelist hotplug ports for D3 if power managed
 by ACPI
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Arthur Borsboom <arthurborsboom@gmail.com>,
        matoro <matoro@airmail.cc>,
        Aaron Zakhrov <aaron.zakhrov@gmail.com>,
        Michal Rostecki <mrostecki@suse.com>,
        Shai Coleman <git@shaicoleman.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 2, 2020 at 7:17 AM Lukas Wunner <lukas@wunner.de> wrote:
>
> Recent laptops with dual AMD GPUs fail to suspend the discrete GPU, thus
> causing lockups on system sleep and high power consumption at runtime.
> The discrete GPU would normally be suspended to D3cold by turning off
> ACPI _PR3 Power Resources of the Root Port above the GPU.
>
> However on affected systems, the Root Port is hotplug-capable and
> pci_bridge_d3_possible() only allows hotplug ports to go to D3 if they
> belong to a Thunderbolt device or if the Root Port possesses a
> "HotPlugSupportInD3" ACPI property.  Neither is the case on affected
> laptops.  The reason for whitelisting only specific, known to work
> hotplug ports for D3 is that there have been reports of SkyLake Xeon-SP
> systems raising Hardware Error NMIs upon suspending their hotplug ports:
> https://lore.kernel.org/linux-pci/20170503180426.GA4058@otc-nc-03/
>
> But if a hotplug port is power manageable by ACPI (as can be detected
> through presence of Power Resources and corresponding _PS0 and _PS3
> methods) then it ought to be safe to suspend it to D3.  To this end,
> amend acpi_pci_bridge_d3() to whitelist such ports for D3.
>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1222
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1252
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1304
> Reported-and-tested-by: Arthur Borsboom <arthurborsboom@gmail.com>
> Reported-and-tested-by: matoro <matoro@airmail.cc>
> Reported-by: Aaron Zakhrov <aaron.zakhrov@gmail.com>
> Reported-by: Michal Rostecki <mrostecki@suse.com>
> Reported-by: Shai Coleman <git@shaicoleman.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/pci/pci-acpi.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index d5869a0..d9aa551 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -944,6 +944,16 @@ static bool acpi_pci_bridge_d3(struct pci_dev *dev)
>         if (!dev->is_hotplug_bridge)
>                 return false;
>
> +       /* Assume D3 support if the bridge is power-manageable by ACPI. */
> +       adev = ACPI_COMPANION(&dev->dev);
> +       if (!adev && !pci_dev_is_added(dev)) {
> +               adev = acpi_pci_find_companion(&dev->dev);
> +               ACPI_COMPANION_SET(&dev->dev, adev);
> +       }
> +
> +       if (adev && acpi_device_power_manageable(adev))
> +               return true;
> +
>         /*
>          * Look for a special _DSD property for the root port and if it
>          * is set we know the hierarchy behind it supports D3 just fine.
> --

I'm going to apply this patch for 5.10 unless Bjorn would rather route
it through the PCI tree.

Thanks!
