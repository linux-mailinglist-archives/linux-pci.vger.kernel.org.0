Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7177E7830C5
	for <lists+linux-pci@lfdr.de>; Mon, 21 Aug 2023 21:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjHUSyZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 21 Aug 2023 14:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjHUSyY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Aug 2023 14:54:24 -0400
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABEB65A5;
        Mon, 21 Aug 2023 11:54:03 -0700 (PDT)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6874a386ec7so460145b3a.1;
        Mon, 21 Aug 2023 11:54:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692644023; x=1693248823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AjNsowUK9gird43ia4GlcF2/+kMuvjQMQyQUr20YgY8=;
        b=amwrs4uh45BMtmtUtzHNXlwhVSjGqBD76zMSECZDaXl+dtPX9a5THloXqYsZv5SSx+
         GhsYMWBuQ//jlDXawrcaTaR4pvALU9H53LVU0L/j8ztAQSfKDYygplHam3MivfZgB6XS
         2utuKvz2ckcnVLjKo1T0AqZaQfFjb0jghYGohaUbokXhdJlAlDxWYHjAwHuav3gH7YG8
         F4RB9IxwgYh/jL9I91ZNAVRjED6f2f8+aV0sjE2m9LSlwhIHgbKmr3VGOJ1QuVX8Yfk1
         j5+fLNLdQ1dqu/OLEwAqz07RoUDU0aZsr/c0OhXYeB3yAz+lR1PXmmwVpU+2pSGwFdFx
         L5xw==
X-Gm-Message-State: AOJu0YyiPbab9WQt6/FqQsKbaK4SBUdCr+9O+PEVndr6rhfR4Ol9Q3aJ
        oOK0/8UpVh8OSMOj5FuCksH0R4FhQTS6tCsFpIh7k8si
X-Google-Smtp-Source: AGHT+IGbkE5EtyoRuBeaQEblim4mO21X78UOxSVlgSlgdlH4DAwReaNaX8x02A4Ls5imOEsvndnFA+E2HFdO+x3TqsA=
X-Received: by 2002:a4a:e882:0:b0:570:d852:f77f with SMTP id
 g2-20020a4ae882000000b00570d852f77fmr3034647ooe.1.1692643588293; Mon, 21 Aug
 2023 11:46:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230818194027.27559-1-mario.limonciello@amd.com> <20230818194027.27559-5-mario.limonciello@amd.com>
In-Reply-To: <20230818194027.27559-5-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 21 Aug 2023 20:46:17 +0200
Message-ID: <CAJZ5v0j_tmW1uWZF7ShK=fwnVGjjy8CSf7DJErJdSaD_dgW8WQ@mail.gmail.com>
Subject: Re: [PATCH v14.c 4/4] PCI: ACPI: Limit the Intel specific opt-in to
 D3 to 2024
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Iain Lane <iain@orangesquash.org.uk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 18, 2023 at 9:40 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Intel systems that need to have PCIe ports in D3 for low power idle
> specify this by constraints on the ACPI PNP0D80 device. As this information
> is queried by acpi_pci_bridge_d3(), limit the DMI BIOS year check to stop
> at 2024. This will allow future systems to rely on the constraints check
> and ACPI checks to set up policy like non-Intel systems do.

So I'm not sure about the value of this change.

The behavior is made Intel-specific in [14a 1/1] and it will be that
way at least for some time.  This change only sets the date after
which it won't be Intel-specific any more, but for what reason
exactly?

And why is 2024 the cut-off year (and not 2025, for example)?

If Intel platforms continue to be OK with putting all PCIe ports into
D3hot beyond 2024, why restrict the kernel from doing so on them?

> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v13->v14:
>  * Use a variable instead
> v12->v13:
>  * New patch
> ---
>  drivers/pci/pci.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index bfdad2eb36d13..c8787d898c377 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3037,16 +3037,22 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
>                         return false;
>
>                 /*
> -                * Allow Intel PCIe ports from 2015 onward to go into D3 to
> +                * Allow Intel PCIe ports from 2015 to 2024 to go into D3 to
>                  * achieve additional energy conservation on some platforms.
>                  *
> +                * Intel systems from 2025 onward that need this are expected
> +                * to specify this in an LPS0 device constraint instead.
> +                *
>                  * This is only set for Intel PCIe ports as it causes problems
>                  * on both AMD Rembrandt and Phoenix platforms where USB keyboards
>                  * can not be used to wake the system from suspend.
>                  */
> -               if (bridge->vendor == PCI_VENDOR_ID_INTEL &&
> -                   dmi_get_bios_year() >= 2015)
> -                       return true;
> +               if (bridge->vendor == PCI_VENDOR_ID_INTEL) {
> +                       int year = dmi_get_bios_year();
> +
> +                       if (year >= 2015 && year <= 2024)
> +                               return true;
> +               }
>                 break;
>         }
>
> --
> 2.34.1
>
