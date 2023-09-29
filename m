Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532827B3A62
	for <lists+linux-pci@lfdr.de>; Fri, 29 Sep 2023 21:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbjI2TGR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Fri, 29 Sep 2023 15:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233365AbjI2TGR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Sep 2023 15:06:17 -0400
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA61C195;
        Fri, 29 Sep 2023 12:06:14 -0700 (PDT)
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-57bc11c197aso1279582eaf.1;
        Fri, 29 Sep 2023 12:06:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696014374; x=1696619174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xVer6uvPHCtf/HTMUWD6KTJ1ltbk7x4bE84VkT63hEQ=;
        b=YMlso6DTv1jv1UNJvjSHifDgc6rfJ2cmmv3Ti+NElRPMLgHYXzdT18JfNQlNC1kFKS
         08lPSNb4yMEiBKy5j4I1e4CvrtdDy1fCb3JIKlndtiI27rgFgfQL/xC5nVYUnwX4S3ws
         OTChLYM7Cd1PBGDDS2NFeGQeMJb3LPsicAzBNCED8KGmxsJvUm8j4PPZuN9ThaqQ8UJP
         W0HOg4BVjBijpx7aTJy17uBy/agm0SaCtOHP5IryI86zlPbE+7mOYUAm230q+oPGtcHx
         YxvY27T1zMjzK7nP2pn9PSYgnTrgyxjFGdC25IyxkQD7TZ9sF0hdyb99VJSnmWNoSMLx
         SFuw==
X-Gm-Message-State: AOJu0YwRB64q5RORgRxoBAYeFKNtodwysO6ZgIrmOZVshExtNYjhWyLa
        WSJ9rQsJL3YdfKT1AMZwI723B1GpRTXYgY0bdqM=
X-Google-Smtp-Source: AGHT+IFAE7exkSvkEz769ZW360a8v7ReoFJMsoE/IfxftUeB0GmO+2TM0PqbKJx6ZFE+ijkVcHKoana+guEGrgnZlkM=
X-Received: by 2002:a4a:ee1a:0:b0:56e:94ed:c098 with SMTP id
 bd26-20020a4aee1a000000b0056e94edc098mr5644121oob.0.1696014374101; Fri, 29
 Sep 2023 12:06:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230927202347.2795170-1-scott@os.amperecomputing.com> <20230928154720.GA462358@bhelgaas>
In-Reply-To: <20230928154720.GA462358@bhelgaas>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 29 Sep 2023 21:06:02 +0200
Message-ID: <CAJZ5v0j9hvhboyfmgs1CXkUqpmrMryNjwWGV+kJB-FCMfXaM_g@mail.gmail.com>
Subject: Re: [PATCH] PCI: hotplug: Add extension driver for Ampere Altra
 hotplug LED control
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     D Scott Phillips <scott@os.amperecomputing.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
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

On Thu, Sep 28, 2023 at 5:47 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Sep 27, 2023 at 01:23:47PM -0700, D Scott Phillips wrote:
> > On Ampere Altra, PCIe hotplug is handled through ACPI. A side interface is
> > also present to request system firmware control of attention LEDs. Add an
> > ACPI PCI Hotplug companion driver to support attention LED control.
> >
> > Signed-off-by: D Scott Phillips <scott@os.amperecomputing.com>
> > ---
> >  drivers/pci/hotplug/Kconfig                |  13 ++
> >  drivers/pci/hotplug/Makefile               |   3 +-
> >  drivers/pci/hotplug/acpiphp_ampere_altra.c | 141 +++++++++++++++++++++
> >  3 files changed, 156 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/pci/hotplug/acpiphp_ampere_altra.c
> >
> > diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
> > index 48113b210cf93..9fde600a9ad3e 100644
> > --- a/drivers/pci/hotplug/Kconfig
> > +++ b/drivers/pci/hotplug/Kconfig
> > @@ -61,6 +61,19 @@ config HOTPLUG_PCI_ACPI
> >
> >         When in doubt, say N.
> >
> > +config HOTPLUG_PCI_ACPI_AMPERE_ALTRA
> > +     tristate "ACPI PCI Hotplug driver Ampere Altra extensions"
> > +     depends on HOTPLUG_PCI_ACPI
> > +     depends on HAVE_ARM_SMCCC_DISCOVERY
> > +     depends on m
>
> Why is this restricted to being a module?  It's not unprecedented, but
> unless this only works as a module for some reason, I would leave that
> choice up to the user.
>
> > +     help
> > +       Say Y here if you have an Ampere Altra system.
> > +
> > +       To compile this driver as a module, choose M here: the
> > +       module will be called acpiphp_ampere_altra.
> > +
> > +       When in doubt, say N.
> > +
> >  config HOTPLUG_PCI_ACPI_IBM
> >       tristate "ACPI PCI Hotplug driver IBM extensions"
> >       depends on HOTPLUG_PCI_ACPI
> > diff --git a/drivers/pci/hotplug/Makefile b/drivers/pci/hotplug/Makefile
> > index 5196983220df6..29d7f6171b305 100644
> > --- a/drivers/pci/hotplug/Makefile
> > +++ b/drivers/pci/hotplug/Makefile
> > @@ -21,8 +21,9 @@ obj-$(CONFIG_HOTPLUG_PCI_RPA_DLPAR) += rpadlpar_io.o
> >  obj-$(CONFIG_HOTPLUG_PCI_ACPI)               += acpiphp.o
> >  obj-$(CONFIG_HOTPLUG_PCI_S390)               += s390_pci_hpc.o
> >
> > -# acpiphp_ibm extends acpiphp, so should be linked afterwards.
> > +# acpiphp_ibm extend acpiphp, so should be linked afterwards.
> >
> > +obj-$(CONFIG_HOTPLUG_PCI_ACPI_AMPERE_ALTRA)  += acpiphp_ampere_altra.o
> >  obj-$(CONFIG_HOTPLUG_PCI_ACPI_IBM)   += acpiphp_ibm.o
> >
> >  pci_hotplug-objs     :=      pci_hotplug_core.o
> > diff --git a/drivers/pci/hotplug/acpiphp_ampere_altra.c b/drivers/pci/hotplug/acpiphp_ampere_altra.c
> > new file mode 100644
> > index 0000000000000..8692b939dea78
> > --- /dev/null
> > +++ b/drivers/pci/hotplug/acpiphp_ampere_altra.c
> > @@ -0,0 +1,141 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * ACPI PCI Hot Plug Ampere Altra Extension
>
> Would be helpful to include a hint about what this module *does*.
> IIUC, it controls the attention indicator.
>
> > + *
> > + * Copyright (C) 2023 Ampere Computing LLC
> > + *
>
> Spurious blank line.
>
> > + */
> > +
> > +#define pr_fmt(fmt) "acpiphp_ampere_altra: " fmt
> > +
> > +#include <linux/init.h>
> > +#include <linux/module.h>
> > +#include <linux/pci.h>
> > +#include <linux/pci_hotplug.h>
> > +
> > +#include "acpiphp.h"
> > +
> > +#define HANDLE_OPEN  0xb0200000
> > +#define HANDLE_CLOSE 0xb0300000
> > +#define REQUEST              0xf0700000
> > +#define LED_CMD              0x00000004
> > +#define LED_ATTENTION        0x00000002
> > +#define LED_SET_ON   0x00000001
> > +#define LED_SET_OFF  0x00000002
> > +#define LED_SET_BLINK        0x00000003
> > +
> > +static const struct acpi_device_id acpi_ids[] = {
> > +     {"AMPC0008", 0}, {}
> > +};
> > +MODULE_DEVICE_TABLE(acpi, acpi_ids);
> > +
> > +static u32 led_service_id[4];
> > +
> > +static int led_status(u8 status)
> > +{
> > +     switch (status) {
> > +     case 1: return LED_SET_ON;
> > +     case 2: return LED_SET_BLINK;
> > +     default: return LED_SET_OFF;
> > +     }
> > +}
> > +
> > +static int set_attention_status(struct hotplug_slot *slot, u8 status)
> > +{
> > +     struct arm_smccc_res res;
> > +     struct pci_bus *bus;
> > +     struct pci_dev *root_port;
> > +     unsigned long flags;
> > +     u32 handle;
> > +     int ret = 0;
> > +
> > +     bus = slot->pci_slot->bus;
> > +     root_port = pcie_find_root_port(bus->self);
> > +     if (!root_port)
> > +             return -ENODEV;
> > +
> > +     local_irq_save(flags);
> > +     arm_smccc_smc(HANDLE_OPEN, led_service_id[0], led_service_id[1],
> > +                   led_service_id[2], led_service_id[3], 0, 0, 0, &res);
> > +     if (res.a0) {
> > +             ret = -ENODEV;
> > +             goto out;
> > +     }
> > +     handle = res.a1 & 0xffff0000;
> > +
> > +     arm_smccc_smc(REQUEST, LED_CMD, led_status(status), LED_ATTENTION,
> > +                   pci_domain_nr(bus) | ((root_port->devfn >> 3) << 4), 0, 0,
>
> PCI_SLOT(root_port->devfn)
>
> > +                   handle, &res);
> > +     if (res.a0)
> > +             ret = -ENODEV;
> > +
> > +     arm_smccc_smc(HANDLE_CLOSE, handle, 0, 0, 0, 0, 0, 0, &res);
> > +
> > + out:
> > +     local_irq_restore(flags);
> > +     return ret;
> > +}
> > +
> > +static int get_attention_status(struct hotplug_slot *slot, u8 *status)
> > +{
> > +     return -EINVAL;
> > +}
> > +
> > +static struct acpiphp_attention_info ampere_altra_attn = {
> > +     .set_attn = set_attention_status,
> > +     .get_attn = get_attention_status,
> > +     .owner = THIS_MODULE,
> > +};
> > +
> > +static acpi_status __init get_acpi_handle(acpi_handle handle, u32 level,
> > +                                       void *context, void **return_value)
> > +{
> > +     *(acpi_handle *)return_value = handle;
> > +     return AE_CTRL_TERMINATE;
> > +}
> > +
> > +static int __init acpiphp_ampere_altra_init(void)
> > +{
> > +     struct fwnode_handle *fwnode;
> > +     acpi_handle leds_handle = NULL;
> > +     struct acpi_device *leds;
> > +     acpi_status status;
> > +     int ret;
> > +
> > +     status = acpi_get_devices("AMPC0008", get_acpi_handle, NULL,
> > +                               &leds_handle);
>
> Rafael, can you comment on whether we should use acpi_get_devices(),
> acpi_bus_register_driver(), acpi_acpi_scan_add_handler(), or something
> else here?

Personally, I would go for a platform driver, because the ACPI core
should create a platform device for this object.

acpi_get_devices() carries out a namespace walk that is costly and
entirely avoidable.

>  I try to avoid pci_get_device() because it subverts the
> driver model (no hotplug support, no driver/device binding).
>
> I see Documentation/driver-api/acpi/scan_handlers.rst, but I'm not
> clear on when to use acpi_bus_register_driver() vs

Never.

> acpi_acpi_scan_add_handler().

When you don't want the ACPI core to create a platform device for your
ACPI device object.  There are cases like that, but they are rare.

> I guess the only ACPI connection here is to retrieve the "uuid"
> property once, and there's no need for any ACPI services after that.

That's in agreement with my understanding.
