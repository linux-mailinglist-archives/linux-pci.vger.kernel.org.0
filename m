Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF817B70E8
	for <lists+linux-pci@lfdr.de>; Tue,  3 Oct 2023 20:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbjJCSdL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 3 Oct 2023 14:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbjJCSdK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Oct 2023 14:33:10 -0400
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A877683;
        Tue,  3 Oct 2023 11:33:07 -0700 (PDT)
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-57c0775d4fcso236489eaf.0;
        Tue, 03 Oct 2023 11:33:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696357987; x=1696962787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eEV1DyG9Qc64Bv5Nj/cVJ3Nlaofe0o2A5B76dhvJOR0=;
        b=fyvx1VIyKJPzMNqtEWFxn+sceSxEeoNKH09rLT7l4oOeM9kc27ZGnPLJfylUgLCx24
         RVvzlp9+j2V+lk5b3bXkHLRoJg2/Wl+jj/NqGO1Dh8APilEtIUxCkbRkzEW/XLnFfs5x
         9peIPWQdRdGx71mkSUxTGxJvhYJkZ1c77L4zD1IHTdnxQWxz7+JQCdeziKI6kkMu8bcp
         QHrhCKgY7ijGq0bvjtGXpQSKGrz+pFnVGoGNvR0tXfbm7p8QgAzhu516drrAmqd4BURV
         P4Lxc5mWpFMj2L1UX3I+Wj44oH/ZW/rqSF3l6m0Odpdhr9VUvB/AZbaDfgF0y9UlB9jD
         11Ew==
X-Gm-Message-State: AOJu0Yzg+nnmjGplGr70SNVblUwFykZWQ+uUNzQmT2K7dxCKPX7XifSN
        S9nWK7wHuDFx1nrpygEhixgunBlimPEU8yRmZBxLgtep
X-Google-Smtp-Source: AGHT+IGgXGqt1HA2YNsmay2fzB7axy43vTxCwdNlq/iCy9H9wp+Amb6dGvxlkRaebr5vYEXXId6F5LasarxZdTLL/m8=
X-Received: by 2002:a4a:de08:0:b0:56e:94ed:c098 with SMTP id
 y8-20020a4ade08000000b0056e94edc098mr219991oot.0.1696357986930; Tue, 03 Oct
 2023 11:33:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230930002036.6491-1-scott@os.amperecomputing.com> <20230930002036.6491-2-scott@os.amperecomputing.com>
In-Reply-To: <20230930002036.6491-2-scott@os.amperecomputing.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 3 Oct 2023 20:32:55 +0200
Message-ID: <CAJZ5v0ggY7r2u26vBARy=WGxh0p_72fa7=mbxz1jJAH9dkDBpg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] PCI: hotplug: Add extension driver for Ampere
 Altra hotplug LED control
To:     D Scott Phillips <scott@os.amperecomputing.com>
Cc:     linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>,
        Darren Hart <darren@os.amperecomputing.com>,
        patches@amperecomputing.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Sep 30, 2023 at 2:20 AM D Scott Phillips
<scott@os.amperecomputing.com> wrote:
>
> On Ampere Altra, PCIe hotplug is handled through ACPI. A side interface is
> also present to request system firmware control of attention LEDs. Add an
> ACPI PCI Hotplug companion driver to support attention LED control.
>
> Signed-off-by: D Scott Phillips <scott@os.amperecomputing.com>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

for the probing part.

> ---
> Changes since v1:
> - remove build-as-module restriction
> - add some more description
> - don't open code PCI_SLOT()
> - convert to a platform driver
>
>  drivers/pci/hotplug/Kconfig                |  12 ++
>  drivers/pci/hotplug/Makefile               |   1 +
>  drivers/pci/hotplug/acpiphp_ampere_altra.c | 127 +++++++++++++++++++++
>  3 files changed, 140 insertions(+)
>  create mode 100644 drivers/pci/hotplug/acpiphp_ampere_altra.c
>
> diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
> index 48113b210cf93..1472aef0fb812 100644
> --- a/drivers/pci/hotplug/Kconfig
> +++ b/drivers/pci/hotplug/Kconfig
> @@ -61,6 +61,18 @@ config HOTPLUG_PCI_ACPI
>
>           When in doubt, say N.
>
> +config HOTPLUG_PCI_ACPI_AMPERE_ALTRA
> +       tristate "ACPI PCI Hotplug driver Ampere Altra extensions"
> +       depends on HOTPLUG_PCI_ACPI
> +       depends on HAVE_ARM_SMCCC_DISCOVERY
> +       help
> +         Say Y here if you have an Ampere Altra system.
> +
> +         To compile this driver as a module, choose M here: the
> +         module will be called acpiphp_ampere_altra.
> +
> +         When in doubt, say N.
> +
>  config HOTPLUG_PCI_ACPI_IBM
>         tristate "ACPI PCI Hotplug driver IBM extensions"
>         depends on HOTPLUG_PCI_ACPI
> diff --git a/drivers/pci/hotplug/Makefile b/drivers/pci/hotplug/Makefile
> index 5196983220df6..240c99517d5e9 100644
> --- a/drivers/pci/hotplug/Makefile
> +++ b/drivers/pci/hotplug/Makefile
> @@ -23,6 +23,7 @@ obj-$(CONFIG_HOTPLUG_PCI_S390)                += s390_pci_hpc.o
>
>  # acpiphp_ibm extends acpiphp, so should be linked afterwards.
>
> +obj-$(CONFIG_HOTPLUG_PCI_ACPI_AMPERE_ALTRA)    += acpiphp_ampere_altra.o
>  obj-$(CONFIG_HOTPLUG_PCI_ACPI_IBM)     += acpiphp_ibm.o
>
>  pci_hotplug-objs       :=      pci_hotplug_core.o
> diff --git a/drivers/pci/hotplug/acpiphp_ampere_altra.c b/drivers/pci/hotplug/acpiphp_ampere_altra.c
> new file mode 100644
> index 0000000000000..1b1fe5d6a3fbf
> --- /dev/null
> +++ b/drivers/pci/hotplug/acpiphp_ampere_altra.c
> @@ -0,0 +1,127 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ACPI PCI Hot Plug Extension for Ampere Altra. Allows control of
> + * attention LEDs via requests to system firmware.
> + *
> + * Copyright (C) 2023 Ampere Computing LLC
> + */
> +
> +#define pr_fmt(fmt) "acpiphp_ampere_altra: " fmt
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/pci_hotplug.h>
> +#include <linux/platform_device.h>
> +
> +#include "acpiphp.h"
> +
> +#define HANDLE_OPEN    0xb0200000
> +#define HANDLE_CLOSE   0xb0300000
> +#define REQUEST                0xf0700000
> +#define LED_CMD                0x00000004
> +#define LED_ATTENTION  0x00000002
> +#define LED_SET_ON     0x00000001
> +#define LED_SET_OFF    0x00000002
> +#define LED_SET_BLINK  0x00000003
> +
> +static u32 led_service_id[4];
> +
> +static int led_status(u8 status)
> +{
> +       switch (status) {
> +       case 1: return LED_SET_ON;
> +       case 2: return LED_SET_BLINK;
> +       default: return LED_SET_OFF;
> +       }
> +}
> +
> +static int set_attention_status(struct hotplug_slot *slot, u8 status)
> +{
> +       struct arm_smccc_res res;
> +       struct pci_bus *bus;
> +       struct pci_dev *root_port;
> +       unsigned long flags;
> +       u32 handle;
> +       int ret = 0;
> +
> +       bus = slot->pci_slot->bus;
> +       root_port = pcie_find_root_port(bus->self);
> +       if (!root_port)
> +               return -ENODEV;
> +
> +       local_irq_save(flags);
> +       arm_smccc_smc(HANDLE_OPEN, led_service_id[0], led_service_id[1],
> +                     led_service_id[2], led_service_id[3], 0, 0, 0, &res);
> +       if (res.a0) {
> +               ret = -ENODEV;
> +               goto out;
> +       }
> +       handle = res.a1 & 0xffff0000;
> +
> +       arm_smccc_smc(REQUEST, LED_CMD, led_status(status), LED_ATTENTION,
> +                     pci_domain_nr(bus) | (PCI_SLOT(root_port->devfn) << 4), 0, 0,
> +                     handle, &res);
> +       if (res.a0)
> +               ret = -ENODEV;
> +
> +       arm_smccc_smc(HANDLE_CLOSE, handle, 0, 0, 0, 0, 0, 0, &res);
> +
> + out:
> +       local_irq_restore(flags);
> +       return ret;
> +}
> +
> +static int get_attention_status(struct hotplug_slot *slot, u8 *status)
> +{
> +       return -EINVAL;
> +}
> +
> +static struct acpiphp_attention_info ampere_altra_attn = {
> +       .set_attn = set_attention_status,
> +       .get_attn = get_attention_status,
> +       .owner = THIS_MODULE,
> +};
> +
> +static int altra_led_probe(struct platform_device *pdev)
> +{
> +       struct fwnode_handle *fwnode = dev_fwnode(&pdev->dev);
> +       int ret;
> +
> +       ret = fwnode_property_read_u32_array(fwnode, "uuid", led_service_id, 4);
> +       if (ret) {
> +               dev_err(&pdev->dev, "can't find uuid\n");
> +               return ret;
> +       }
> +
> +       ret = acpiphp_register_attention(&ampere_altra_attn);
> +       if (ret) {
> +               dev_err(&pdev->dev, "can't register driver\n");
> +               return ret;
> +       }
> +       return 0;
> +}
> +
> +static void altra_led_remove(struct platform_device *pdev)
> +{
> +       acpiphp_unregister_attention(&ampere_altra_attn);
> +}
> +
> +static const struct acpi_device_id altra_led_ids[] = {
> +       { "AMPC0008", 0 },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(acpi, altra_led_ids);
> +
> +static struct platform_driver altra_led_driver = {
> +       .driver = {
> +               .name = "ampere-altra-leds",
> +               .acpi_match_table = altra_led_ids,
> +       },
> +       .probe = altra_led_probe,
> +       .remove_new = altra_led_remove,
> +};
> +module_platform_driver(altra_led_driver);
> +
> +MODULE_AUTHOR("D Scott Phillips <scott@os.amperecomputing.com>");
> +MODULE_LICENSE("GPL");
> --
> 2.41.0
>
