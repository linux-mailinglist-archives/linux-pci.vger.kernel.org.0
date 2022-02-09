Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D92274AFBF0
	for <lists+linux-pci@lfdr.de>; Wed,  9 Feb 2022 19:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240961AbiBISv6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Feb 2022 13:51:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241207AbiBISuy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Feb 2022 13:50:54 -0500
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF277C0401F3;
        Wed,  9 Feb 2022 10:46:17 -0800 (PST)
Received: by mail-yb1-f177.google.com with SMTP id o19so8547647ybc.12;
        Wed, 09 Feb 2022 10:46:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FOZOUKLJKTfcXhSl2Frn48yaywqWILrf0FOGMO8s1HA=;
        b=tH6yIwGZrWuCUeSYtAFsvNZ4qfXpPlrbYzeKJegOFOLkz7y9I3chVLFYES/qy9UMjQ
         N3rJRDbOr22jqEL9+QogsXudu4JlsYxcP9gtC4dw1KFXHktdOI9SDpfsMS/RWyUASlKd
         psBKg9K5hnSt3qwuSHrR3YFw7re694antpouKGXRqwOixbsb03pXoMvc6kplv38MzUFv
         LVcQQCOZXvlrr4vl8hdGdKeZr2r9rBbSEDdNZt8X4wBaEo+S6e85KVZYhakCGRZkaSCV
         Gr453zS7cDigHDMg3EvvPBJMZHBWK9dN82TtPe0pP9g0KQxq8GGafSalpICOI7yUj5of
         jADA==
X-Gm-Message-State: AOAM530fBs11exwMSn3jLWDW3rbspw3S15KY4OsjKteJ1B64lnNYXAQV
        7IHTB0dL3wwK5TunEfXO2oNNqiXR4mfiv+4vcKk=
X-Google-Smtp-Source: ABdhPJwJGGD0nJAvFhNDkFGeYRyEdQdP75MnqP3EaVTzMLv3wT5lodwnLAvfEtrY884JKET27CdtDI1tBOtpbtwnJQ8=
X-Received: by 2002:a81:8b4e:: with SMTP id e14mr3633769ywk.301.1644432377048;
 Wed, 09 Feb 2022 10:46:17 -0800 (PST)
MIME-Version: 1.0
References: <20220209161342.91721-1-hdegoede@redhat.com>
In-Reply-To: <20220209161342.91721-1-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 9 Feb 2022 19:46:06 +0100
Message-ID: <CAJZ5v0ihi_jig=HejWo+rivn2Re7=U5VGPOL8gfmmW0UzBp6NA@mail.gmail.com>
Subject: Re: [PATCH] x86/PCI: revert "Ignore E820 reservations for bridge
 windows on newer systems"
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        =?UTF-8?Q?Benoit_Gr=C3=A9goire?= <benoitg@coeus.ca>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hui Wang <hui.wang@canonical.com>
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

On Wed, Feb 9, 2022 at 5:14 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Commit 7f7b4236f204 ("x86/PCI: Ignore E820 reservations for bridge windows
> on newer systems") fixes the touchpad not working on laptops like
> the Lenovo IdeaPad 3 15IIL05 and the Lenovo IdeaPad 5 14IIL05, as well as
> fixing thunderbolt hotplug issues on the Lenovo Yoga C940.
>
> Unfortunately it turns out that this is causing issues with suspend/resume
> on Lenovo ThinkPad X1 Carbon Gen 2 laptops. So, per the no regressions
> policy, rever this. Note I'm looking into another fix for the issues this
> fixed.
>
> Fixes: 7f7b4236f204 ("x86/PCI: Ignore E820 reservations for bridge windows on newer systems")
> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=2029207
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied as 5.17-rc material and pushed out for -next, thanks!

> ---
>  arch/x86/kernel/resource.c | 23 +----------------------
>  1 file changed, 1 insertion(+), 22 deletions(-)
>
> diff --git a/arch/x86/kernel/resource.c b/arch/x86/kernel/resource.c
> index 9ae64f9af956..9b9fb7882c20 100644
> --- a/arch/x86/kernel/resource.c
> +++ b/arch/x86/kernel/resource.c
> @@ -1,5 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#include <linux/dmi.h>
>  #include <linux/ioport.h>
>  #include <asm/e820/api.h>
>
> @@ -24,31 +23,11 @@ static void resource_clip(struct resource *res, resource_size_t start,
>                 res->start = end + 1;
>  }
>
> -/*
> - * Some BIOS-es contain a bug where they add addresses which map to
> - * system RAM in the PCI host bridge window returned by the ACPI _CRS
> - * method, see commit 4dc2287c1805 ("x86: avoid E820 regions when
> - * allocating address space"). To avoid this Linux by default excludes
> - * E820 reservations when allocating addresses since 2010.
> - * In 2019 some systems have shown-up with E820 reservations which cover
> - * the entire _CRS returned PCI host bridge window, causing all attempts
> - * to assign memory to PCI BARs to fail if Linux uses E820 reservations.
> - *
> - * Ideally Linux would fully stop using E820 reservations, but then
> - * the old systems this was added for will regress.
> - * Instead keep the old behavior for old systems, while ignoring the
> - * E820 reservations for any systems from now on.
> - */
>  static void remove_e820_regions(struct resource *avail)
>  {
> -       int i, year = dmi_get_bios_year();
> +       int i;
>         struct e820_entry *entry;
>
> -       if (year >= 2018)
> -               return;
> -
> -       pr_info_once("PCI: Removing E820 reservations from host bridge windows\n");
> -
>         for (i = 0; i < e820_table->nr_entries; i++) {
>                 entry = &e820_table->entries[i];
>
> --
> 2.33.1
>
