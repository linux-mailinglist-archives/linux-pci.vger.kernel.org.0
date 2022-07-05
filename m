Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F36D567602
	for <lists+linux-pci@lfdr.de>; Tue,  5 Jul 2022 19:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiGERxA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Jul 2022 13:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiGERw7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Jul 2022 13:52:59 -0400
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761F519C12;
        Tue,  5 Jul 2022 10:52:58 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id b85so9928823yba.8;
        Tue, 05 Jul 2022 10:52:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rtZW43uaFGJ9zjjYWIL3hR7D7c7iNZ58RuAJEx8JrUs=;
        b=E8KmgTIVCZ8YuVVsrTCc4lS9u0Ji1eDJZ7RORRnbMpJkIJsQ/W9sMOuF4DP8DfmgpG
         ZaaY652sS0qGhmrzMJBOaakc10tOKiQmKZ1ZlXVAkYWfqlgEM9l56R8/Am2g6JPdacKK
         Xi/jwmo6pZOtCbzUHymqY7v3E6LUhUei9Fkqrme3F4HaAr84U5uKTKUPcSLKki+zxVUh
         lMKCX9zm4uMmz2yFp0dq8HXFmtMMeSEW2g00NuWjgmZw80Giwo5c12brwlbg8QFyPRSa
         DHLaq9KNw3ozTPD7VeKWcUjcbRGsVtmYmDRA5uXIaKeXedjAgdNCV0SzPDAdepC4/0+s
         aw9Q==
X-Gm-Message-State: AJIora8Iq8MGU+bfj8WWQHIEc2V+/hufyAQggNOAE80YXzvOVEAbyqhu
        7NScIdxz5kt1hYXBtfj38OTxWhGeqVcW+4mJVV8Fcb3DOLM=
X-Google-Smtp-Source: AGRyM1tUkRK6ivdZVYz6eLSLc6jRDky8LL2tfELYNeYotqiIcRDlZFHwuORrn6n29m2di+W4XP3C8c4zym3FIyRXPjY=
X-Received: by 2002:a25:664f:0:b0:66c:d0f4:36cc with SMTP id
 z15-20020a25664f000000b0066cd0f436ccmr37116337ybm.482.1657043577315; Tue, 05
 Jul 2022 10:52:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220701161624.2844305-1-pierre.gondois@arm.com> <20220701161624.2844305-2-pierre.gondois@arm.com>
In-Reply-To: <20220701161624.2844305-2-pierre.gondois@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 5 Jul 2022 19:52:46 +0200
Message-ID: <CAJZ5v0hWm5_zwY9z10dTg4K0Skz-bGc8ABH7C0j_=Vu+Z8zqpQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v1 1/2] ACPI/PCI: Make _SRS optional for link device
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
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

On Fri, Jul 1, 2022 at 6:17 PM Pierre Gondois <pierre.gondois@arm.com> wrote:
>
> From: Pierre Gondois <Pierre.Gondois@arm.com>
>
> In ACPI 6.4, s6.2.13 "_PRT (PCI Routing Table)", PCI legacy
> interrupts can be described though a link device (first model).
> From s6.2.16 "_SRS (Set Resource Settings)":
> "This optional control method [...]"
>
> Make it optional to have a _SRS method for link devices.

Note that if _DIS is present, _SRS is necessary to enable the link and
acpi_pci_link_add() evaluates _DIS for all links.  So you need to
check both, not just one.

Moreover, it doesn't make much sense to provide _PRS without _SRS and
arguably _PRS is needed if _SRS is present, so this needs to be taken
into account too.

AFAICS, the only valid configuration in which _SRS and _PRS are not
present is when _DIS is not present too, so only _CRS is present and
the IRQ listed by it is actually in use.  However, in that case it is
hardly necessary to add a device object for the PCI link device at
all.

> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=215560
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  drivers/acpi/pci_link.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
> index 58647051c948..129e3e7e80ee 100644
> --- a/drivers/acpi/pci_link.c
> +++ b/drivers/acpi/pci_link.c
> @@ -288,6 +288,13 @@ static int acpi_pci_link_set(struct acpi_pci_link *link, int irq)
>         if (!irq)
>                 return -EINVAL;
>
> +       if (!acpi_has_method(handle, METHOD_NAME__SRS)) {
> +               if (link->irq.active == irq)
> +                       return 0;
> +               acpi_handle_err(handle, "Unable to set IRQ %d: No _SRS.\n", irq);
> +               return -ENODEV;
> +       }
> +
>         resource = kzalloc(sizeof(*resource) + 1, irqs_disabled() ? GFP_ATOMIC: GFP_KERNEL);
>         if (!resource)
>                 return -ENOMEM;
> --
> 2.25.1
>
