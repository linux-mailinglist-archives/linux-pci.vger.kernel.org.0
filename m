Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C89F7638FA
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jul 2023 16:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234426AbjGZOYw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 26 Jul 2023 10:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234364AbjGZOYv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Jul 2023 10:24:51 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B079E47;
        Wed, 26 Jul 2023 07:24:49 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-1bb701d39ddso515836fac.0;
        Wed, 26 Jul 2023 07:24:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690381488; x=1690986288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pEgmDiAe0tWX9GxWyAoDrChI5qTftMQ2f732dcdFKW0=;
        b=eKFkvDp9HXTvzkykCCwC5tVwDmQEQDpsYDeLrzonnuhJfpf0yTRTaaSbRjU03H8ZEK
         VcTHXRZ4YOP3Q2TsyeKlso/piZXNeM+8EXBazZ1vOXjC+oc3bvGyE8F7K2j8UGN2db49
         NtxjNtFOiHnXW37vD9kbtDeeES4rS/fbdZxzd8zVvgAwm/WKHAFC/t1SaWaZEKcuqp0k
         pAbdphrhqSl53WzQc24bVhbbnhS25NRKML3vh3X36fy9G8tf+YDEeguZNMcMc/yJB9YL
         yWi52dx7txRpyIbAOINrfxgfdZmDJVQxvA0eaCukpXxeMerO8/ZAChfHjNUTCXOtlihc
         1LNA==
X-Gm-Message-State: ABy/qLYHVg+xG///0NSMuCRFjgeR/wDyV/UkD7aVEl/6yWR6fNmu2hza
        jYxAAEQ95imD4xlMJAURqTb8AZbLp0LYzCH2vB4=
X-Google-Smtp-Source: APBJJlHkrIccG4pncj994mgxhB/i/B+Kb8dr6cxjFPYMBiEgv54qUWOwC26ILRls/bH0WPEsKCuZGQjq6CWipXzNPIQ=
X-Received: by 2002:a4a:d6d1:0:b0:569:a08a:d9c5 with SMTP id
 j17-20020a4ad6d1000000b00569a08ad9c5mr1761805oot.0.1690381488408; Wed, 26 Jul
 2023 07:24:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230726123518.2361181-1-imammedo@redhat.com> <20230726123518.2361181-2-imammedo@redhat.com>
In-Reply-To: <20230726123518.2361181-2-imammedo@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 26 Jul 2023 16:24:36 +0200
Message-ID: <CAJZ5v0jM25BBLgapgUz=VWr6wzv9DME=OQN51ja11THSgW-+YA@mail.gmail.com>
Subject: Re: [PATCH 1/1] PCI: acpiphp:: use pci_assign_unassigned_bridge_resources()
 only if bus->self not NULL
To:     Igor Mammedov <imammedo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, terraluna977@gmail.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org, mst@redhat.com,
        rafael@kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 26, 2023 at 2:35 PM Igor Mammedov <imammedo@redhat.com> wrote:
>
> Commit [1] switched acpiphp hotplug to use
>    pci_assign_unassigned_bridge_resources()
> which depends on bridge being available, however in some cases
> when acpiphp is in use, enable_slot() can get a slot without
> bridge associated.
>   1. legitimate case of hotplug on root bus
>       (likely not exiting on real hw, but widely used in virt world)
>   2. broken firmware, that sends 'Bus check' events to non
>      existing root ports (Dell Inspiron 7352/0W6WV0), which somehow
>      endup at acpiphp:enable_slot(..., bridge = 0) and with bus
>      without bridge assigned to it.
>
> Issue is easy to reproduce with QEMU's 'pc' machine provides
> PCI hotplug on hostbridge slots. to reproduce boot kernel at
> commit [1] in VM started with followin CLI and hotplug a device:
>
> once guest OS is fully booted at qemu prompt:
>
> (qemu) device_add e1000
>
> it will cause NULL pointer dereference at
>
>     void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
>     {
>         struct pci_bus *parent = bridge->subordinate;
>
> [  612.277651] BUG: kernel NULL pointer dereference, address: 0000000000000018
> [...]
> [  612.277798]  ? pci_assign_unassigned_bridge_resources+0x1f/0x260
> [  612.277804]  ? pcibios_allocate_dev_resources+0x3c/0x2a0
> [  612.277809]  enable_slot+0x21f/0x3e0
> [  612.277816]  acpiphp_hotplug_notify+0x13d/0x260
> [  612.277822]  ? __pfx_acpiphp_hotplug_notify+0x10/0x10
> [  612.277827]  acpi_device_hotplug+0xbc/0x540
> [  612.277834]  acpi_hotplug_work_fn+0x15/0x20
> [  612.277839]  process_one_work+0x1f7/0x370
> [  612.277845]  worker_thread+0x45/0x3b0
> [  612.277850]  ? __pfx_worker_thread+0x10/0x10
> [  612.277854]  kthread+0xdc/0x110
> [  612.277860]  ? __pfx_kthread+0x10/0x10
> [  612.277866]  ret_from_fork+0x28/0x40
> [  612.277871]  ? __pfx_kthread+0x10/0x10
> [  612.277876]  ret_from_fork_asm+0x1b/0x30
>
> The issue was discovered on Dell Inspiron 7352/0W6WV0 laptop with
> following sequence:
>    1. suspend to RAM
>    2. wake up with the same backtrace being observed:
>    3. 2nd suspend to RAM attempt makes laptop freeze
>
> Fix it by using __pci_bus_assign_resources() instead of
> pci_assign_unassigned_bridge_resources()as we used to do
> but only in case when bus doesn't have a bridge associated
> with it.
>
> That let us keep hotplug on root bus working like it used to be
> but at the same time keeps resource reassignment usable on
> root ports (and other 1st level bridges) that was fixed by [1].
>
> 1)
> Fixes: 40613da52b13 ("PCI: acpiphp: Reassign resources on bridge if necessary")
> Link: https://lore.kernel.org/r/11fc981c-af49-ce64-6b43-3e282728bd1a@gmail.com
> Reported-by: Woody Suwalski <terraluna977@gmail.com>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  drivers/pci/hotplug/acpiphp_glue.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> index 328d1e416014..3bc4e1f3efee 100644
> --- a/drivers/pci/hotplug/acpiphp_glue.c
> +++ b/drivers/pci/hotplug/acpiphp_glue.c
> @@ -498,6 +498,7 @@ static void enable_slot(struct acpiphp_slot *slot, bool bridge)
>                                 acpiphp_native_scan_bridge(dev);
>                 }
>         } else {
> +               LIST_HEAD(add_list);
>                 int max, pass;
>
>                 acpiphp_rescan_slot(slot);
> @@ -511,10 +512,15 @@ static void enable_slot(struct acpiphp_slot *slot, bool bridge)
>                                 if (pass && dev->subordinate) {
>                                         check_hotplug_bridge(slot, dev);
>                                         pcibios_resource_survey_bus(dev->subordinate);
> +                                       if (!bus->self)
> +                                               __pci_bus_size_bridges(dev->subordinate, &add_list);
>                                 }
>                         }
>                 }
> -               pci_assign_unassigned_bridge_resources(bus->self);
> +               if (bus->self)
> +                       pci_assign_unassigned_bridge_resources(bus->self);
> +               else
> +                       __pci_bus_assign_resources(bus, &add_list, NULL);
>         }
>
>         acpiphp_sanitize_bus(bus);
> --
> 2.39.3
>
