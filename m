Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F016E650E
	for <lists+linux-pci@lfdr.de>; Tue, 18 Apr 2023 14:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbjDRMzq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 18 Apr 2023 08:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbjDRMzp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Apr 2023 08:55:45 -0400
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF636CC25;
        Tue, 18 Apr 2023 05:55:42 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-95227e5164dso15161166b.1;
        Tue, 18 Apr 2023 05:55:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681822541; x=1684414541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jdb0w+jEfZkSk+3SmG8wtFklZfay3JZ0XkSQ6zMoTbs=;
        b=X/gZFai55uFeiF9bEbYoxncxzKgJUlmwQNw5ag7MzPRjAGkT/xlNfYvhy4AshsbIZi
         MQUL+fE9UM7dmKLET/nTZtMzglC3yIPwW3r5ux/0rjATNJb3ZRsKIFDf9LlJNkmJOFef
         f2Q6rQPLB5uCEy7ShW+iKvXLrOSPqDeGpr/PPQfc8Spx+dyqbAmtcnBxJVM6fqUPqLZQ
         44qrSpbYrzGh6sWJs33Ndk0wvy8DwR3KLqX60j6zN4YnXcG2nxWYFrruQD9+QckeIAaK
         JFvsDrE8FDCEuY3ezDoYmMpiKDgR92kTMouFp/Xgkm5KMQwUKes1v2n/rAccTdcvovtQ
         6H/w==
X-Gm-Message-State: AAQBX9e7z12sTtRm1Y5OcKh/4binTifT7sl1863L6NnceTXyZ9VJRspI
        HQ1FvHsq5MYojLwewEgR1lk5Z2SbMEDXANlIb/GQ+4yE
X-Google-Smtp-Source: AKy350bLfOyZ9Ie3U225HmWjoFoX38ib+ugrt8e5BtaILw2UAjlpIwX2quIGIFifup4AhjRGOqyfFVD/0daX42HkUNs=
X-Received: by 2002:a17:906:535d:b0:94f:4ec3:f0e8 with SMTP id
 j29-20020a170906535d00b0094f4ec3f0e8mr6553646ejo.4.1681822541141; Tue, 18 Apr
 2023 05:55:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230418085030.2154918-1-imammedo@redhat.com>
In-Reply-To: <20230418085030.2154918-1-imammedo@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 18 Apr 2023 14:55:29 +0200
Message-ID: <CAJZ5v0geYujyXKv9mG_i+2rjcdrMVh+jmE1ffJ79_oFr8GNoMg@mail.gmail.com>
Subject: Re: [PATCH] pci: acpiphp: try to reassign resources on bridge if necessary
To:     Igor Mammedov <imammedo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, mst@redhat.com, rafael@kernel.org,
        lenb@kernel.org, bhelgaas@google.com, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org
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

On Tue, Apr 18, 2023 at 10:50 AM Igor Mammedov <imammedo@redhat.com> wrote:
>
> When using ACPI PCI hotplug, hotplugging a device with
> large BARs may fail if bridge windows programmed by
> firmware are not large enough.
>
> Reproducer:
>   $ qemu-kvm -monitor stdio -M q35  -m 4G \
>       -global ICH9-LPC.acpi-pci-hotplug-with-bridge-support=on \
>       -device id=rp1,pcie-root-port,bus=pcie.0,chassis=4 \
>       disk_image
>
>  wait till linux guest boots, then hotplug device
>    (qemu) device_add qxl,bus=rp1
>
>  hotplug on guest side fails with:
>    pci 0000:01:00.0: [1b36:0100] type 00 class 0x038000
>    pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x03ffffff]
>    pci 0000:01:00.0: reg 0x14: [mem 0x00000000-0x03ffffff]
>    pci 0000:01:00.0: reg 0x18: [mem 0x00000000-0x00001fff]
>    pci 0000:01:00.0: reg 0x1c: [io  0x0000-0x001f]
>    pci 0000:01:00.0: BAR 0: no space for [mem size 0x04000000]
>    pci 0000:01:00.0: BAR 0: failed to assign [mem size 0x04000000]
>    pci 0000:01:00.0: BAR 1: no space for [mem size 0x04000000]
>    pci 0000:01:00.0: BAR 1: failed to assign [mem size 0x04000000]
>    pci 0000:01:00.0: BAR 2: assigned [mem 0xfe800000-0xfe801fff]
>    pci 0000:01:00.0: BAR 3: assigned [io  0x1000-0x101f]
>    qxl 0000:01:00.0: enabling device (0000 -> 0003)
>    Unable to create vram_mapping
>    qxl: probe of 0000:01:00.0 failed with error -12
>
> However when using native PCIe hotplug
>   '-global ICH9-LPC.acpi-pci-hotplug-with-bridge-support=off'
> it works fine, since kernel attempts to reassign unused resources.
> Use the same machinery as native PCIe hotplug to (re)assign resources.
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

or please let me know if you want me to pick this up.

> ---
> tested in QEMU with Q35 machine on PCIE root port and also
> with nested conventional bridge attached to root port.
> ---
>  drivers/pci/hotplug/acpiphp_glue.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> index 5b1f271c6034..9aebde28a92f 100644
> --- a/drivers/pci/hotplug/acpiphp_glue.c
> +++ b/drivers/pci/hotplug/acpiphp_glue.c
> @@ -517,7 +517,7 @@ static void enable_slot(struct acpiphp_slot *slot, bool bridge)
>                                 }
>                         }
>                 }
> -               __pci_bus_assign_resources(bus, &add_list, NULL);
> +               pci_assign_unassigned_bridge_resources(bus->self);
>         }
>
>         acpiphp_sanitize_bus(bus);
> --
> 2.39.1
>
