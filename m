Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC45536736
	for <lists+linux-pci@lfdr.de>; Fri, 27 May 2022 20:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243537AbiE0Szu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 May 2022 14:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351455AbiE0Szk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 May 2022 14:55:40 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACE64D251;
        Fri, 27 May 2022 11:55:39 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-2ff7b90e635so56537067b3.5;
        Fri, 27 May 2022 11:55:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AiXxBvT5jxe4DGf49rxfmcwLST9ROwPRMdTz8X7oj7c=;
        b=jtGiyF1yLiWYPFajExqePQ0LWM1I2ZnKhOJoXUyjkVDih1q3aaxLViB3rnhbvoBK3w
         Pu32Zq46APQO/5bU32Buz7C7YojuwPAzjT65jvIXbBy04ySrVRVaglA2Kzhz+No2NvcL
         3DwZuWM2pfC1m9uUIdj+hSm7lZyo0//aLCmUdAQM/ojvb9S0eKVOXuIGmq0HFrKD4Kug
         1Dw2s2YNCGzcrvlYsYZjYYNDpSfQq5AXN0fiEHVa9GLMacaOglH5XAcvEzOzFxSAnAqj
         EdoCO8cM8a5wgl1yD7ob/HwyTWZn6LdZVwQBgPOc8Ksb64bHoLZae/KWFaAswqV7ek+b
         k2eQ==
X-Gm-Message-State: AOAM530K/WFbUh5ZJKX/VA0rlBJmuj9IuNihleDj6/6D1xXA8zRi58ad
        rY7r7JUB6oXUsvcLYddusW4cwd/wFWlgYzKpjUw=
X-Google-Smtp-Source: ABdhPJyzekDhy/kwQrCFpa2Go5HoqkV1wJDHQV2O8qnmcW16Da65NIQ459mws4JqQV+oLgovjeqwVECMRQv9j5VeeNQ=
X-Received: by 2002:a81:4ed6:0:b0:307:224f:eed3 with SMTP id
 c205-20020a814ed6000000b00307224feed3mr3825315ywb.301.1653677739110; Fri, 27
 May 2022 11:55:39 -0700 (PDT)
MIME-Version: 1.0
References: <11980172.O9o76ZdvQC@kreacher> <20220526221258.GA409855@bhelgaas>
In-Reply-To: <20220526221258.GA409855@bhelgaas>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 27 May 2022 20:55:28 +0200
Message-ID: <CAJZ5v0gSxvg7USAvc2UrsrAdFs+UKBw8PGQapey3zuyrQRb4tA@mail.gmail.com>
Subject: Re: [PATCH] PCI: PM: Quirk bridge D3 on Elo i2
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Stefan Gottwald <gottwald@igel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Fri, May 27, 2022 at 12:13 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Thu, Mar 31, 2022 at 07:38:51PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > If one of the PCIe root ports on Elo i2 is put into D3cold and then
> > back into D0, the downstream device becomes permanently inaccessible,
> > so add a bridge D3 DMI quirk for that system.
> >
> > This was exposed by commit 14858dcc3b35 ("PCI: Use
> > pci_update_current_state() in pci_enable_device_flags()"), but before
> > that commit the root port in question had never been put into D3cold
> > for real due to a mismatch between its power state retrieved from the
> > PCI_PM_CTRL register (which was accessible even though the platform
> > firmware indicated that the port was in D3cold) and the state of an
> > ACPI power resource involved in its power management.
> >
> > BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=215715
> > Reported-by: Stefan Gottwald <gottwald@igel.com>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/pci/pci.c |   10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > Index: linux-pm/drivers/pci/pci.c
> > ===================================================================
> > --- linux-pm.orig/drivers/pci/pci.c
> > +++ linux-pm/drivers/pci/pci.c
> > @@ -2920,6 +2920,16 @@ static const struct dmi_system_id bridge
> >                       DMI_MATCH(DMI_BOARD_VENDOR, "Gigabyte Technology Co., Ltd."),
> >                       DMI_MATCH(DMI_BOARD_NAME, "X299 DESIGNARE EX-CF"),
> >               },
> > +             /*
> > +              * Downstream device is not accessible after putting a root port
> > +              * into D3cold and back into D0 on Elo i2.
> > +              */
> > +             .ident = "Elo i2",
> > +             .matches = {
> > +                     DMI_MATCH(DMI_SYS_VENDOR, "Elo Touch Solutions"),
> > +                     DMI_MATCH(DMI_PRODUCT_NAME, "Elo i2"),
> > +                     DMI_MATCH(DMI_PRODUCT_VERSION, "RevB"),
> > +             },
> >       },
>
> This has already made it to Linus' and some stable trees, but I think
> we need the following touchup.  I plan to send it right after my v5.19
> pull request.

Ouch, sorry.

> commit a99f6bb133df ("PCI/PM: Fix bridge_d3_blacklist[] Elo i2 overwrite of Gigabyte X299")
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Thu May 26 16:52:23 2022 -0500
>
>     PCI/PM: Fix bridge_d3_blacklist[] Elo i2 overwrite of Gigabyte X299
>
>     92597f97a40b ("PCI/PM: Avoid putting Elo i2 PCIe Ports in D3cold") omitted
>     braces around the new Elo i2 entry, so it overwrote the existing Gigabyte
>     X299 entry.
>
>     Found by:
>
>       $ make W=1 drivers/pci/pci.o
>         CC      drivers/pci/pci.o
>       drivers/pci/pci.c:2974:12: error: initialized field overwritten [-Werror=override-init]
>        2974 |   .ident = "Elo i2",
>             |            ^~~~~~~~
>
>     Fixes: 92597f97a40b ("PCI/PM: Avoid putting Elo i2 PCIe Ports in D3cold")
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     Cc: stable@vger.kernel.org  # v5.15+
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index d25122fbe98a..5b400a742621 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2920,6 +2920,8 @@ static const struct dmi_system_id bridge_d3_blacklist[] = {
>                         DMI_MATCH(DMI_BOARD_VENDOR, "Gigabyte Technology Co., Ltd."),
>                         DMI_MATCH(DMI_BOARD_NAME, "X299 DESIGNARE EX-CF"),
>                 },
> +       },
> +       {
>                 /*
>                  * Downstream device is not accessible after putting a root port
>                  * into D3cold and back into D0 on Elo i2.
