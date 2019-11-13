Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74BC4FBB18
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2019 22:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfKMVuh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Nov 2019 16:50:37 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38619 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfKMVug (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Nov 2019 16:50:36 -0500
Received: by mail-ot1-f66.google.com with SMTP id z25so3034847oti.5;
        Wed, 13 Nov 2019 13:50:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dc1AbYFoYLO3C/3U0GXl1ZR0dczJpXZXYD/0wizwRwo=;
        b=PYdcVmy6yjiqzxxoxzLP+GOUFTYK1++LfA38Z3iVNkHi0sbGcvhBl0NWgQX6JngByk
         SelL3fuKC2lDXhgNYArMzbLYpVnWbrT14BHEdFQE+aJYz2SUkH136e/OV5DQ1CE5hSXO
         vROJQYo4FSZWwNUYMLNLTtqR94IjTpOsCL/iNCOWGx0D7eLehwHcaAdkVPhyzHs1NF2A
         Ey44hsEN59/5SvPL4V5m0z0AIfnOI8m2WN2uK75Ma89ItGCFn9KQbWpm3+L/oH1+Yi1n
         RzxBRW8sftBi6LvaLu/xQBcL45MTVZ8rlONRd4Sl2crCOE3LJ9pGLH8tsw2RBWq0eDvg
         HqDw==
X-Gm-Message-State: APjAAAWQYoqMnihuCeA5iljhjK24vqC21EDd9IgXOhIUQeSUsSW35H49
        TfFJhOX/nDvxRuytHiATYREALI68qR4o4JCSeC8=
X-Google-Smtp-Source: APXvYqzR7xkMNSG/PAn3Ei8Xdm6X3JIU59b7AUKWPq5l+uEWlkeJLhfWDT8bUht4O0npIjZzEmai98241T7rn5NVmwc=
X-Received: by 2002:a05:6830:232a:: with SMTP id q10mr5263876otg.262.1573681835291;
 Wed, 13 Nov 2019 13:50:35 -0800 (PST)
MIME-Version: 1.0
References: <20191113154123.75345-1-mika.westerberg@linux.intel.com>
In-Reply-To: <20191113154123.75345-1-mika.westerberg@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 13 Nov 2019 22:50:24 +0100
Message-ID: <CAJZ5v0ifbNdDMOXLttgVq_BrP2-s1NZywu=AutBTPERkt76bnA@mail.gmail.com>
Subject: Re: [PATCH] ACPI / hotplug / PCI: Take runtime PM autosuspend into account
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 13, 2019 at 4:41 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> PCIe ports (the only ones we do runtime PM) are using runtime PM
> autosuspend to keep the port powered on for a while after it becomes
> idle. However, ACPI hotplug does not take this into account so if we get
> multiple hotplug events in a short period of time we may be powering
> ports on and off and then back on unnecessarily.
>
> For this reason call pm_runtime_put_autosuspend() for them (with the
> accompanying pm_runtime_mark_last_busy()).
>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Makes sense:

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/pci/hotplug/acpiphp_glue.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> index b3869951c0eb..c8264af40643 100644
> --- a/drivers/pci/hotplug/acpiphp_glue.c
> +++ b/drivers/pci/hotplug/acpiphp_glue.c
> @@ -672,7 +672,8 @@ static void trim_stale_devices(struct pci_dev *dev)
>                 list_for_each_entry_safe_reverse(child, tmp, &bus->devices, bus_list)
>                         trim_stale_devices(child);
>
> -               pm_runtime_put(&dev->dev);
> +               pm_runtime_mark_last_busy(&dev->dev);
> +               pm_runtime_put_autosuspend(&dev->dev);
>         }
>  }
>
> @@ -714,8 +715,10 @@ static void acpiphp_check_bridge(struct acpiphp_bridge *bridge)
>                 }
>         }
>
> -       if (bridge->pci_dev)
> -               pm_runtime_put(&bridge->pci_dev->dev);
> +       if (bridge->pci_dev) {
> +               pm_runtime_mark_last_busy(&bridge->pci_dev->dev);
> +               pm_runtime_put_autosuspend(&bridge->pci_dev->dev);
> +       }
>  }
>
>  /*
> --
