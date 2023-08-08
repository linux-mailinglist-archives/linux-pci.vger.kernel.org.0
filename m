Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31CC6774A63
	for <lists+linux-pci@lfdr.de>; Tue,  8 Aug 2023 22:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjHHU0f convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 8 Aug 2023 16:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjHHU0T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Aug 2023 16:26:19 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77001222E7;
        Tue,  8 Aug 2023 12:39:34 -0700 (PDT)
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6bcde3d8657so338632a34.0;
        Tue, 08 Aug 2023 12:39:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691523574; x=1692128374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c58ks/9Dr1zfmu2zS+3clcM4+/iOwxmZoLK5TyGbzOA=;
        b=KjWNRRrDvLJVFG/WPtWQrgIe+2J3lMSHdk7DQPU0u2i/GiLspYK3VrZqZ4q3m5CBrA
         gwTxHNn1ZpYfTtp/dNwQPDgivO9PNzSSbzh9UdyO4qP9FDf5RkoYKOt+vBRmtoAKSTwf
         /tvo27UY0QusBrOPZo1QaCG9Iso1i0zboccH6b3FpRJ6+sdeoPr7Hl/T69wgpPTkRLtQ
         12+CWaX8lj8lk3I5lXAQsb7MlGVVZSgSfx216v60LD04n9rxvtO4y8m3xyUoEI3AmwTc
         A5Qei6rq73DDk2JNrj+Vtcj4Qi/Pn+StHb0DlR/QDIl2pMt9gCMMoI2NZrm6N/Vu6Pxe
         inEQ==
X-Gm-Message-State: AOJu0YypN3cZGe8CEfpUvVH/bk8AqdZU64GPdUnd14hnqOkvMsUxmsBI
        eROwG4f60p7b9EWTXbE4D8FiUdboR7TgSxw9i58=
X-Google-Smtp-Source: AGHT+IGqqLxXoaFah+KuxrNf99luNlzlovc9mCHxcHPECaaaLauzdCLB9tuj6JZkAHUTjO61utQXwNJuomt3rbEABi4=
X-Received: by 2002:a4a:a64a:0:b0:56c:484a:923d with SMTP id
 j10-20020a4aa64a000000b0056c484a923dmr786914oom.1.1691523573721; Tue, 08 Aug
 2023 12:39:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230808192713.329414-1-helgaas@kernel.org>
In-Reply-To: <20230808192713.329414-1-helgaas@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 8 Aug 2023 21:39:22 +0200
Message-ID: <CAJZ5v0jc5dn+6WtH6O30EeJfGDLewiLaAY9YJEAO6d_n+Uv7ig@mail.gmail.com>
Subject: Re: [PATCH] PCI: acpiphp: Log more slot and notification details
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Igor Mammedov <imammedo@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Woody Suwalski <terraluna977@gmail.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
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

On Tue, Aug 8, 2023 at 9:27 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> When registering an acpiphp slot, log the slot name in the same style as
> pciehp and include the PCI bus/device and whether a device is present or
> the slot is empty.
>
> When handling an ACPI notification, log the PCI bus/device and notification
> type.
>
> Sample dmesg log diff:
>
>     ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
>   - acpiphp: Slot [3] registered
>   - acpiphp: Slot [4] registered
>     PCI host bridge to bus 0000:00
>     pci 0000:00:03.0: [8086:100e] type 00 class 0x020000
>     <ACPI Device Check notification>
>     pci 0000:00:04.0: [8086:100e] type 00 class 0x020000
>
>     ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
>   + acpiphp: pci 0000:00:03 Slot(3) registered (enabled)
>   + acpiphp: pci 0000:00:04 Slot(4) registered (empty)
>     PCI host bridge to bus 0000:00
>     pci 0000:00:03.0: [8086:100e] type 00 class 0x020000
>     <ACPI Device Check notification>
>   + acpiphp: pci 0000:00:04 Slot(4) Device Check
>     pci 0000:00:04.0: [8086:100e] type 00 class 0x020000
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/hotplug/acpiphp_core.c |  4 ----
>  drivers/pci/hotplug/acpiphp_glue.c | 23 +++++++++++++++++++++--
>  2 files changed, 21 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/pci/hotplug/acpiphp_core.c b/drivers/pci/hotplug/acpiphp_core.c
> index c02257f4b61c..19d47607d009 100644
> --- a/drivers/pci/hotplug/acpiphp_core.c
> +++ b/drivers/pci/hotplug/acpiphp_core.c
> @@ -282,8 +282,6 @@ int acpiphp_register_hotplug_slot(struct acpiphp_slot *acpiphp_slot,
>                 goto error_slot;
>         }
>
> -       pr_info("Slot [%s] registered\n", slot_name(slot));
> -
>         return 0;
>  error_slot:
>         kfree(slot);
> @@ -296,8 +294,6 @@ void acpiphp_unregister_hotplug_slot(struct acpiphp_slot *acpiphp_slot)
>  {
>         struct slot *slot = acpiphp_slot->slot;
>
> -       pr_info("Slot [%s] unregistered\n", slot_name(slot));
> -
>         pci_hp_deregister(&slot->hotplug_slot);
>         kfree(slot);
>  }
> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> index 328d1e416014..eeca2753a5c7 100644
> --- a/drivers/pci/hotplug/acpiphp_glue.c
> +++ b/drivers/pci/hotplug/acpiphp_glue.c
> @@ -25,7 +25,7 @@
>   *    bus. It loses the refcount when the driver unloads.
>   */
>
> -#define pr_fmt(fmt) "acpiphp_glue: " fmt
> +#define pr_fmt(fmt) "acpiphp: " fmt
>
>  #include <linux/module.h>
>
> @@ -333,6 +333,12 @@ static acpi_status acpiphp_add_context(acpi_handle handle, u32 lvl, void *data,
>                                        &val, 60*1000))
>                 slot->flags |= SLOT_ENABLED;
>
> +       if (slot->slot)
> +               pr_info("pci %04x:%02x:%02x Slot(%s) registered (%s)\n",
> +                       pci_domain_nr(slot->bus), slot->bus->number,
> +                       slot->device, slot_name(slot->slot),
> +                       slot->flags & SLOT_ENABLED ? "enabled" : "empty");
> +
>         return AE_OK;
>  }
>
> @@ -351,8 +357,13 @@ static void cleanup_bridge(struct acpiphp_bridge *bridge)
>                         acpi_unlock_hp_context();
>                 }
>                 slot->flags |= SLOT_IS_GOING_AWAY;
> -               if (slot->slot)
> +               if (slot->slot) {
> +                       pr_info("pci %04x:%02x:%02x Slot(%s) unregistered\n",
> +                               pci_domain_nr(slot->bus), slot->bus->number,
> +                               slot->device, slot_name(slot->slot));
> +
>                         acpiphp_unregister_hotplug_slot(slot);
> +               }
>         }
>
>         mutex_lock(&bridge_mutex);
> @@ -793,6 +804,14 @@ static void hotplug_event(u32 type, struct acpiphp_context *context)
>
>         pci_lock_rescan_remove();
>
> +       pr_info("pci %04x:%02x:%02x Slot(%s) %s\n",
> +               pci_domain_nr(slot->bus), slot->bus->number,
> +               slot->device, slot_name(slot->slot),
> +               type == ACPI_NOTIFY_BUS_CHECK ? "Bus Check" :
> +               type == ACPI_NOTIFY_DEVICE_CHECK ? "Device Check" :
> +               type == ACPI_NOTIFY_EJECT_REQUEST ? "Eject Request" :
> +               "Notification");
> +

pr_debug() perhaps?

On systems that don't have any hotplug problems these messages will
just be filling the kernel log unnecessarily.

>         switch (type) {
>         case ACPI_NOTIFY_BUS_CHECK:
>                 /* bus re-enumerate */
> --
