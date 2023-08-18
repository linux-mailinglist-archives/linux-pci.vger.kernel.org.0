Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA356780FF0
	for <lists+linux-pci@lfdr.de>; Fri, 18 Aug 2023 18:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347615AbjHRQKa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Fri, 18 Aug 2023 12:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378416AbjHRQKC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Aug 2023 12:10:02 -0400
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8223ABB;
        Fri, 18 Aug 2023 09:10:01 -0700 (PDT)
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-56d26137095so185676eaf.1;
        Fri, 18 Aug 2023 09:10:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692375000; x=1692979800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QiQQj5CYx+kSDZsPEEViaZQITU/buPkOLZzOGA2nSKk=;
        b=DTUTpw0JC9WpqnSpjHOOR07ZAHZHipEP2Yk5mJj1amqTVQfu1ZxN+iY/9lsFI71rxF
         CA2tamdIGhbbKX5pO+q6NH8IgpUMG6TTzOlOK7Qtpxpboh6w70qILtly9DcOK4vhTqIc
         a7iI9xLtIRk0L5vwANTGOfqKT6o8FBbbeK5qv7/ZW5vkM23r7mBBjgvt8My+ko1dubZ6
         LCtNki2KLsyBh2c43dvwv3Q62fNEVkrZ99r4wu7kiSb4YsoJVekM9y76l6I4u1swJ9Fk
         +EhUSYtLxGlLAjhWMuMtHiN9RqnfysC46T/XDL5Btup3J+e0X8q/yoeukIGrgglknMmQ
         kfvg==
X-Gm-Message-State: AOJu0YxGOEbkwLHlbp1PBMeXZmKty0aEcm1PGJeuRW3G5b5wkFqnp8lx
        IDDZnhE4DKZywr4Ko5wAdksWPe7cwuWSkUxJNICMeOjySW4=
X-Google-Smtp-Source: AGHT+IFpRdIKAAG0EKgHSMI7feuutbtE2eJBbVs0sOmccS8A/nUsOfp0HLu2AqdcxcB0QFYqWgumrRqcJju5la6udiY=
X-Received: by 2002:a4a:d581:0:b0:56e:487f:8caa with SMTP id
 z1-20020a4ad581000000b0056e487f8caamr3299193oos.1.1692375000294; Fri, 18 Aug
 2023 09:10:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230818051319.551-1-mario.limonciello@amd.com> <20230818051319.551-13-mario.limonciello@amd.com>
In-Reply-To: <20230818051319.551-13-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 18 Aug 2023 18:09:49 +0200
Message-ID: <CAJZ5v0h+uJtr-98SMXH4P2K2yzXw6g8bpndyJHLHvYRLg9ciEw@mail.gmail.com>
Subject: Re: [PATCH v13 12/12] PCI: ACPI: Limit the Intel specific opt-in to
 D3 to 2024
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Iain Lane <iain@orangesquash.org.uk>,
        Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>
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

On Fri, Aug 18, 2023 at 7:15 AM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Intel systems that need to have PCIe ports in D3 for low power idle
> specify this by constraints on the ACPI PNP0D80 device. As this information
> is queried, limit the DMI BIOS year check to stop at 2024. This will
> allow future systems to rely on the constraints check to set up policy
> like non-Intel systems do.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v12->v13:
>  * New patch
> ---
>  drivers/pci/pci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 0fc8d35154f97..5b9e11e254f34 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3049,10 +3049,11 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
>                         return true;
>
>                 /*
> -                * It is safe to put Intel PCIe ports from 2015 or newer
> +                * It is safe to put Intel PCIe ports from 2015 to 2024
>                  * to D3.
>                  */
>                 if (bridge->vendor == PCI_VENDOR_ID_INTEL &&
> +                   dmi_get_bios_year() <= 2024 &&
>                     dmi_get_bios_year() >= 2015)

A minor nit: The above would be somewhat easier to follow if it is
written in a reverse order, that is

dmi_get_bios_year() >= 2015 && dmi_get_bios_year() <= 2024

and maybe call dmi_get_bios_year() once to avoid the redundant string parsing?

>                         return true;
>                 break;
> --
