Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6674BEA7D
	for <lists+linux-pci@lfdr.de>; Mon, 21 Feb 2022 20:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbiBUTLr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Feb 2022 14:11:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232744AbiBUTLj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Feb 2022 14:11:39 -0500
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866F819C23;
        Mon, 21 Feb 2022 11:11:15 -0800 (PST)
Received: by mail-yb1-f172.google.com with SMTP id e140so36311807ybh.9;
        Mon, 21 Feb 2022 11:11:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S08h/88nSHlNocSoaXtYaF8UFRglbkaVDETnl7Zh9xc=;
        b=P+9aTl5wDIbcqPe2/dl2+itkyKJ5INfIPgUSH9CiRHpcoEUHTgm6szHxPeu2cGHxWB
         5BVxRfVml5Pg/KE07QYxjk1OhLE5LdoFKut7axh53h90uQKu3yJ3V3iG67Lx15a4nG66
         60XPoRjaWfhJMlq3mfjO9V8kBTeFunNA/A+5hPMzRNSwURGw8O3HUqnFAtd052laYQm/
         XZlM42H+60soy1JgdXnj4LQW6n01watv/XR7Of/MWj0QK+QNqoG1tExGj3/VJW8asYBv
         KtsO5N5WeoGBZEFcEgQn6utGOYFpLOxnT7UkIbB5B50Z4H8kZmx1EqaREHbGhTK06Zwg
         yyog==
X-Gm-Message-State: AOAM531HdwQ5BuD49QygcRWpKjwXKpLPxGfBpkNW5InFPtk6yNCvJX5c
        EMx6qGOeVde2DX8QDX8wHSzqoQMwlqn/o86kstg=
X-Google-Smtp-Source: ABdhPJz+PEGVSIBd6WyeGJr2Fpf6ugsheIp9t7vsRMbtBYLo6USJbXteI126Nvq5C/YO7/BR5pr2IbkbFfbioUzWMKo=
X-Received: by 2002:a25:7785:0:b0:614:c283:2a3d with SMTP id
 s127-20020a257785000000b00614c2832a3dmr20093374ybc.137.1645470674792; Mon, 21
 Feb 2022 11:11:14 -0800 (PST)
MIME-Version: 1.0
References: <20220206145803.2011247-1-trix@redhat.com>
In-Reply-To: <20220206145803.2011247-1-trix@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 21 Feb 2022 20:11:04 +0100
Message-ID: <CAJZ5v0iw=6GN1ynxXh7tAftT03VMbrC1CdyaEDk_w0kXphRKkA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: cleanup double word in comment
To:     Tom Rix <trix@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
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

On Sun, Feb 6, 2022 at 3:58 PM <trix@redhat.com> wrote:
>
> From: Tom Rix <trix@redhat.com>
>
> Remove the second 'on' and 'those'.
>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/acpi/Kconfig    | 2 +-
>  drivers/acpi/pci_link.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index ba45541b1f1f8..9b93d8f328d4a 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -301,7 +301,7 @@ config ACPI_IPMI
>         help
>           This driver enables the ACPI to access the BMC controller. And it
>           uses the IPMI request/response message to communicate with BMC
> -         controller, which can be found on on the server.
> +         controller, which can be found on the server.
>
>           To compile this driver as a module, choose M here:
>           the module will be called as acpi_ipmi.
> diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
> index d54fb8e54671d..58647051c948a 100644
> --- a/drivers/acpi/pci_link.c
> +++ b/drivers/acpi/pci_link.c
> @@ -185,7 +185,7 @@ static acpi_status acpi_pci_link_check_current(struct acpi_resource *resource,
>                         if (!p || !p->interrupt_count) {
>                                 /*
>                                  * IRQ descriptors may have no IRQ# bits set,
> -                                * particularly those those w/ _STA disabled
> +                                * particularly those w/ _STA disabled
>                                  */
>                                 pr_debug("Blank _CRS IRQ resource\n");
>                                 return AE_OK;
> --

Applied as 5.18 material under a slightly adjusted subject.

Thanks!
