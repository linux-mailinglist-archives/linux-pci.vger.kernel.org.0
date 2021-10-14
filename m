Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3778342DEAA
	for <lists+linux-pci@lfdr.de>; Thu, 14 Oct 2021 17:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbhJNPym (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Oct 2021 11:54:42 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:40842 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbhJNPyl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Oct 2021 11:54:41 -0400
Received: by mail-ot1-f53.google.com with SMTP id s18-20020a0568301e1200b0054e77a16651so8819288otr.7;
        Thu, 14 Oct 2021 08:52:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L3rG/sRTtXDYgB+/nt2HYaRogTaK4bb2teXa+vrJeCk=;
        b=1U4gQnSjyXikAwF6St5sEY7rY3VoZssNKdKr60gsRio7pvyE4m7lUMmDKirrys/6ms
         oTgSvaAGxzK5AnzpiYMAcVULs1o/LYMAN+vxA8r0BqD4txnOn31z4i/7VU0W0vBkJGuW
         Ksn+gn+CmsweZs1WQOWxyRThvPwyH4RWG2rU+09ex4VbtMCcU7khVYpGOovohomdOpAb
         TPLahM0+hCAcjP180+bqR7JAHcdY93l+P0zXPfkn/Gx1p8y4+nvq1xy467N9padaZuq0
         tM82662/2FU5gKv/Rvem8nCZX8IL+3/7swsJ3i4PCQIgt5fty2JR76x2m8Lh7Sd6+YZt
         Ol8Q==
X-Gm-Message-State: AOAM531oP9W2lEFLBj17CmbKqsC8P1B6FV/avUH1tJzxTLCgcWyo4sQp
        wdW3ivnUvAiwGKDG0fTWUzBshnZ3/H3L5yjcN/Y=
X-Google-Smtp-Source: ABdhPJwjOXgFIhpcI73SW02/rOAteIjJr4A/dFdiwl27Gcv3lP7zXtVVYf72HnSCixHn+W5xnhKPRrBYo5UirazXCug=
X-Received: by 2002:a05:6830:1af0:: with SMTP id c16mr3145511otd.16.1634226756303;
 Thu, 14 Oct 2021 08:52:36 -0700 (PDT)
MIME-Version: 1.0
References: <20211014154032.10103-1-hdegoede@redhat.com>
In-Reply-To: <20211014154032.10103-1-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 14 Oct 2021 17:52:25 +0200
Message-ID: <CAJZ5v0j1xgq1SS5wE6sRgB394ppJ97-vreDU1RZsucpEQxbp9Q@mail.gmail.com>
Subject: Re: [PATCH] x86/PCI/ACPI: Replace printk calls with pr_info/pr_warn calls
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 14, 2021 at 5:40 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> The direct use of printk is deprecated, replace the printk calls
> in arch/x86/pci/acpi.c with pr_info/pr_warn calls.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
> Note this applies on top of my:
> "x86/PCI: Ignore E820 reservations for bridge windows on newer systems"
> patch and was requested by several people during review of that patch.

I would send it as a [2/2] in the same series then, but ...

> ---
>  arch/x86/pci/acpi.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
>
> diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
> index 4537e3561c91..98fbdf4fa698 100644
> --- a/arch/x86/pci/acpi.c
> +++ b/arch/x86/pci/acpi.c
> @@ -1,4 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
> +
> +#define pr_fmt(fmt) "PCI: " fmt
> +
>  #include <linux/pci.h>
>  #include <linux/acpi.h>
>  #include <linux/init.h>
> @@ -38,7 +41,7 @@ static int __init set_nouse_crs(const struct dmi_system_id *id)
>
>  static int __init set_ignore_seg(const struct dmi_system_id *id)
>  {
> -       printk(KERN_INFO "PCI: %s detected: ignoring ACPI _SEG\n", id->ident);
> +       pr_info("%s detected: ignoring ACPI _SEG\n", id->ident);
>         pci_ignore_seg = true;
>         return 0;
>  }
> @@ -158,10 +161,9 @@ void __init pci_acpi_crs_quirks(void)
>         else if (pci_probe & PCI_USE__CRS)
>                 pci_use_crs = true;
>
> -       printk(KERN_INFO "PCI: %s host bridge windows from ACPI; "
> -              "if necessary, use \"pci=%s\" and report a bug\n",
> -              pci_use_crs ? "Using" : "Ignoring",
> -              pci_use_crs ? "nocrs" : "use_crs");
> +       pr_info("%s host bridge windows from ACPI; if necessary, use \"pci=%s\" and report a bug\n",
> +               pci_use_crs ? "Using" : "Ignoring",
> +               pci_use_crs ? "nocrs" : "use_crs");
>
>         /*
>          * Some BIOS-es contain a bug where they add addresses which map to
> @@ -189,8 +191,8 @@ void __init pci_acpi_crs_quirks(void)
>         else if (pci_probe & PCI_USE_E820)
>                 pci_use_e820 = true;
>
> -       printk(KERN_INFO "PCI: %s E820 reservations for host bridge windows\n",
> -              pci_use_e820 ? "Honoring" : "Ignoring");
> +       pr_info("%s E820 reservations for host bridge windows\n",
> +               pci_use_e820 ? "Honoring" : "Ignoring");
>  }
>
>  #ifdef CONFIG_PCI_MMCONFIG
> @@ -365,9 +367,8 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
>                 root->segment = domain = 0;
>
>         if (domain && !pci_domains_supported) {
> -               printk(KERN_WARNING "pci_bus %04x:%02x: "
> -                      "ignored (multiple domains not supported)\n",
> -                      domain, busnum);
> +               pr_warn("pci_bus %04x:%02x: ignored (multiple domains not supported)\n",
> +                       domain, busnum);
>                 return NULL;
>         }
>
> @@ -435,7 +436,7 @@ int __init pci_acpi_init(void)
>         if (acpi_noirq)
>                 return -ENODEV;
>
> -       printk(KERN_INFO "PCI: Using ACPI for IRQ routing\n");
> +       pr_info("Using ACPI for IRQ routing\n");
>         acpi_irq_penalty_init();
>         pcibios_enable_irq = acpi_pci_irq_enable;
>         pcibios_disable_irq = acpi_pci_irq_disable;
> @@ -447,7 +448,7 @@ int __init pci_acpi_init(void)
>                  * also do it here in case there are still broken drivers that
>                  * don't use pci_enable_device().
>                  */
> -               printk(KERN_INFO "PCI: Routing PCI interrupts for all devices because \"pci=routeirq\" specified\n");
> +               pr_info("Routing PCI interrupts for all devices because \"pci=routeirq\" specified\n");
>                 for_each_pci_dev(dev)
>                         acpi_pci_irq_enable(dev);
>         }
> --
> 2.31.1
>
