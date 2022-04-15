Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E60502B89
	for <lists+linux-pci@lfdr.de>; Fri, 15 Apr 2022 16:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354309AbiDOOO7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Apr 2022 10:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354298AbiDOOO5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Apr 2022 10:14:57 -0400
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A175CD325;
        Fri, 15 Apr 2022 07:12:29 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id x200so14622208ybe.13;
        Fri, 15 Apr 2022 07:12:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FNIfqj+FilLpI5MusateXTGV7hcgO7NoCnl8abYi8Lc=;
        b=ORty+iZ8hGnRFb/jlvblwpHBARd5zBDkzWRYEhhDmyznyQPac6c9lyQ+t8FbwSwAJH
         4B4PN59031qzWy2daYTwSBn78NNbj/sL4eb6xvuolRJ8+u1iRmfpknbfODg6Mdi2BKBw
         0G+X+3vaV/Tf7ykjnSZeTKjyOfPkRl+HBoEkR8ub2BkZrBO2OL9YFlHNoV+wjk46idaU
         KdmgxTsm0ghkPzQP6v10ewa36B0bt/75fNDXS0LJ9v0PKS6Af8VKWwYnpFCffVwWdPjI
         0PRNRuI4UYqim6AJbo7Xtzj13P03K/+kItpWs2xOIqYOOhU/y3oF1jdqGoSch+DYx8ax
         kQOw==
X-Gm-Message-State: AOAM530MCV4nKkPhqtapzzMoXpztoywKABZ+iOwtZaDxS5w4b0Q1+ZfF
        chaRgPXkveCrVmOsvZGJY3DgQE+TeG9tWFmbC70=
X-Google-Smtp-Source: ABdhPJxUDZllKNP2WGWaTxv78JEwkLokI+kxAekGI2O+K6/T4FYQiu5n3+sYsE2W5s5+yvogSspzvVPXYTs+JmWcqtA=
X-Received: by 2002:a25:ac9b:0:b0:641:3c32:bee7 with SMTP id
 x27-20020a25ac9b000000b006413c32bee7mr5123897ybi.633.1650031948177; Fri, 15
 Apr 2022 07:12:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220414182252.758742-1-helgaas@kernel.org> <20220414182252.758742-3-helgaas@kernel.org>
In-Reply-To: <20220414182252.758742-3-helgaas@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 15 Apr 2022 16:12:17 +0200
Message-ID: <CAJZ5v0jZBOnwr2DoyzVbtucQu0_4+SDqG949gdzX+7LR5SuFKw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] x86: Log resource clipping for E820 regions
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        =?UTF-8?Q?Benoit_Gr=C3=A9goire?= <benoitg@coeus.ca>,
        Hui Wang <hui.wang@canonical.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
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

On Thu, Apr 14, 2022 at 8:23 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> When remove_e820_regions() clips a resource because an E820 region overlaps
> it, log a note in dmesg to add in debugging.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  arch/x86/kernel/resource.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/x86/kernel/resource.c b/arch/x86/kernel/resource.c
> index 8ffe68437744..30d524adb012 100644
> --- a/arch/x86/kernel/resource.c
> +++ b/arch/x86/kernel/resource.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <linux/ioport.h>
> +#include <linux/printk.h>
>  #include <asm/e820/api.h>
>
>  static void resource_clip(struct resource *res, resource_size_t start,
> @@ -28,6 +29,7 @@ static void remove_e820_regions(struct resource *avail)
>         int i;
>         struct e820_entry *entry;
>         u64 e820_start, e820_end;
> +       struct resource orig = *avail;
>
>         for (i = 0; i < e820_table->nr_entries; i++) {
>                 entry = &e820_table->entries[i];
> @@ -35,6 +37,11 @@ static void remove_e820_regions(struct resource *avail)
>                 e820_end = entry->addr + entry->size - 1;
>
>                 resource_clip(avail, e820_start, e820_end);
> +               if (orig.start != avail->start || orig.end != avail->end) {
> +                       pr_info("clipped %pR to %pR for e820 entry [mem %#010Lx-%#010Lx]\n",
> +                                &orig, avail, e820_start, e820_end);
> +                       orig = *avail;
> +               }
>         }
>  }
>
> --
> 2.25.1
>
