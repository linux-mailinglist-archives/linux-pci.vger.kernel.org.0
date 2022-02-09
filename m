Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 636D14AFD05
	for <lists+linux-pci@lfdr.de>; Wed,  9 Feb 2022 20:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiBITM5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Feb 2022 14:12:57 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:59938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbiBITMr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Feb 2022 14:12:47 -0500
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A320C008645;
        Wed,  9 Feb 2022 11:12:40 -0800 (PST)
Received: by mail-yb1-f172.google.com with SMTP id y6so8882929ybc.5;
        Wed, 09 Feb 2022 11:12:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Hqo9jmascljYsohX3+dNe11LfZ+a8ceLYfy+hC5e8w=;
        b=qF/OxivWqyhjJvOgW19M5yH2R7A4WVih7QOwv19ibSsFFKP1NFgx9rRxtsKyIpTl3a
         Nu+lO7vv64ssFVrRtVsk0z2MwofZ9U5JX5JI/XWOSbSzD8EXSHx0FlScIm8Wld63qrg3
         85B6gbXoES7bxGs3YIV3ZvssYc8jzzyT9AaG7c3RN9lyGlKrSWPQvxGWfds/jEiDQw0N
         wt6tMOD6VUt3D0Qshq2ZSLuUnWP7dQXeuluk/3DP9oc1+f+do2GaLXrROQYIEio6YDih
         82ddT8GL8mlW9RrGHALdsg2LUiOHqiDjdjaZyNdj5+nb5yZNUiiNdUZdHQkRUfIA1rAO
         oHqA==
X-Gm-Message-State: AOAM530yePtzicNW12BM91S4q6JsL7PMORRz8JkjmO2REAlgM/0NHqoW
        W/1A8PVddacYV9QFlWJu5NnVVCIsbwTJkhNK9pE=
X-Google-Smtp-Source: ABdhPJwFI0nBunPk2Hh+mAYbQl/h/UKP2zjuR5qjVOf3IYJg606/j6/NtuQ7B/NYITZXRoWRQ2EgtJVc/uVRoZmNGyQ=
X-Received: by 2002:a25:3410:: with SMTP id b16mr3539165yba.78.1644433875451;
 Wed, 09 Feb 2022 11:11:15 -0800 (PST)
MIME-Version: 1.0
References: <20220202020103.2149130-1-rajatja@google.com>
In-Reply-To: <20220202020103.2149130-1-rajatja@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 9 Feb 2022 20:11:04 +0100
Message-ID: <CAJZ5v0gngVxoe88rNAXXK_F34rHAKuxokiuZ6kpg6FhbnyMn0Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] PCI: Allow internal devices to be marked as untrusted
To:     Rajat Jain <rajatja@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatxjain@gmail.com>,
        Dmitry Torokhov <dtor@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Pavel Machek <pavel@denx.de>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Joerg Roedel <joro@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 2, 2022 at 3:01 AM Rajat Jain <rajatja@google.com> wrote:
>
> Today the pci_dev->untrusted is set for any devices sitting downstream
> an external facing port (determined via "ExternalFacingPort" or the
> "external-facing" properties).
>
> However, currently there is no way for internal devices to be marked as
> untrusted.
>
> There are use-cases though, where a platform would like to treat an
> internal device as untrusted (perhaps because it runs untrusted firmware
> or offers an attack surface by handling untrusted network data etc).
>
> Introduce a new "UntrustedDevice" property that can be used by the
> firmware to mark any device as untrusted.
>
> Signed-off-by: Rajat Jain <rajatja@google.com>
> ---
> v2: * Also use the same property for device tree based systems.
>     * Add documentation (next patch)
>
>  drivers/pci/of.c       | 2 ++
>  drivers/pci/pci-acpi.c | 1 +
>  drivers/pci/pci.c      | 9 +++++++++
>  drivers/pci/pci.h      | 2 ++
>  4 files changed, 14 insertions(+)
>
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index cb2e8351c2cc..e8b804664b69 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -24,6 +24,8 @@ void pci_set_of_node(struct pci_dev *dev)
>                                                     dev->devfn);
>         if (dev->dev.of_node)
>                 dev->dev.fwnode = &dev->dev.of_node->fwnode;
> +
> +       pci_set_untrusted(dev);
>  }
>
>  void pci_release_of_node(struct pci_dev *dev)
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index a42dbf448860..2bffbd5c6114 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -1356,6 +1356,7 @@ void pci_acpi_setup(struct device *dev, struct acpi_device *adev)
>
>         pci_acpi_optimize_delay(pci_dev, adev->handle);
>         pci_acpi_set_external_facing(pci_dev);
> +       pci_set_untrusted(pci_dev);
>         pci_acpi_add_edr_notifier(pci_dev);
>
>         pci_acpi_add_pm_notifier(adev, pci_dev);
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 9ecce435fb3f..41e887c27004 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6869,3 +6869,12 @@ static int __init pci_realloc_setup_params(void)
>         return 0;
>  }
>  pure_initcall(pci_realloc_setup_params);
> +
> +void pci_set_untrusted(struct pci_dev *pdev)
> +{
> +       u8 val;
> +
> +       if (!device_property_read_u8(&pdev->dev, "UntrustedDevice", &val)
> +           && val)
> +               pdev->untrusted = 1;

I'm not sure why you ignore val = 0.  Is it not a valid value?

The property is not particularly well defined here.  It is not clear
from its name that it only applies to PCI devices and how.

AFAICS, the "untrusted" bit affected by it is only used by the ATS
code and in one PCH ACS quirk, but I'm not sure if this is all you
have in mind.

> +}
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 3d60cabde1a1..6c273ce5e0ba 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -761,4 +761,6 @@ static inline pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
>  }
>  #endif
>
> +void pci_set_untrusted(struct pci_dev *pdev);
> +
>  #endif /* DRIVERS_PCI_H */
> --
> 2.35.0.rc2.247.g8bbb082509-goog
>
