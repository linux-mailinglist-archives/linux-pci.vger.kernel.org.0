Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44981583376
	for <lists+linux-pci@lfdr.de>; Wed, 27 Jul 2022 21:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbiG0TXp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Jul 2022 15:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbiG0TXb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Jul 2022 15:23:31 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0962CF4;
        Wed, 27 Jul 2022 12:23:29 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-31bf3656517so185726947b3.12;
        Wed, 27 Jul 2022 12:23:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=sEnlyoC25xZp79Oxbxg2zz3T7BmCB2iT+0H37naV68w=;
        b=fvi5Z5TZ//lq1DodYERK2ecMOj+EEO4W1z3PablxPnoOpuRj4a0yaoSPCUPiAmskrN
         itE6GwTTu9UvXvbZA8KwxeIICzCq7urhv1Xs/O+TDX4jlwOl2xUBLjIgacaaYkJuhMLB
         CQUQdQQoA3g+RUSJKeo6XzgTHq/KGI1ihLW+LCTVFG58bX2o/c5tSuRy5qoNqhh/mptB
         OsaBLIyQG6ILHmvut+WNXUJ8SjOfciq4qi9gMpn48LLcbW10ibdf4Ta0W1zNRk4mHeye
         88e9BUzIkw38YczYMrvqS9mnqeTFU3kJiDqVi+YB75loHdouECrx4YjeO4BBY53cHARI
         Z9fg==
X-Gm-Message-State: AJIora+iXXGWz3vgL1NV5yfAVrAiWK0UcsVkdOCLQVySHrd0Mt3y1S4F
        wsML1YlvSOtPlHOmdNxEd53qLE5cGd3gXeWe1jI=
X-Google-Smtp-Source: AGRyM1v2Kc4FfidF9kWyltddcLRo2c274/DbYtapozJAZcZVXtdncUw45DpXSeiD6SxHxlvOaNWFxMiESu0r5AeVynM=
X-Received: by 2002:a81:89c3:0:b0:31e:6908:f857 with SMTP id
 z186-20020a8189c3000000b0031e6908f857mr21517364ywf.149.1658949808955; Wed, 27
 Jul 2022 12:23:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220721141133.1431117-1-strochuk@ispras.ru>
In-Reply-To: <20220721141133.1431117-1-strochuk@ispras.ru>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 27 Jul 2022 21:23:18 +0200
Message-ID: <CAJZ5v0gC1e81tAs4QdHfsALm821zbZ45+9AStYNnA_0wci2X1g@mail.gmail.com>
Subject: Re: [PATCH v3] ACPI/PCI: Remove useless NULL pointer checks
To:     Andrey Strachuk <strochuk@ispras.ru>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ldv-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 21, 2022 at 4:12 PM Andrey Strachuk <strochuk@ispras.ru> wrote:
>
> Local variable 'p' is initialized by an address of field of acpi_resource,
> so it does not make sense to compare 'p' with NULL.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Signed-off-by: Andrey Strachuk <strochuk@ispras.ru>
> ---
>  drivers/acpi/pci_link.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
> index 58647051c948..aa1038b8aec4 100644
> --- a/drivers/acpi/pci_link.c
> +++ b/drivers/acpi/pci_link.c
> @@ -95,7 +95,7 @@ static acpi_status acpi_pci_link_check_possible(struct acpi_resource *resource,
>         case ACPI_RESOURCE_TYPE_IRQ:
>                 {
>                         struct acpi_resource_irq *p = &resource->data.irq;
> -                       if (!p || !p->interrupt_count) {
> +                       if (!p->interrupt_count) {
>                                 acpi_handle_debug(handle,
>                                                   "Blank _PRS IRQ resource\n");
>                                 return AE_OK;
> @@ -121,7 +121,7 @@ static acpi_status acpi_pci_link_check_possible(struct acpi_resource *resource,
>                 {
>                         struct acpi_resource_extended_irq *p =
>                             &resource->data.extended_irq;
> -                       if (!p || !p->interrupt_count) {
> +                       if (!p->interrupt_count) {
>                                 acpi_handle_debug(handle,
>                                                   "Blank _PRS EXT IRQ resource\n");
>                                 return AE_OK;
> @@ -182,7 +182,7 @@ static acpi_status acpi_pci_link_check_current(struct acpi_resource *resource,
>         case ACPI_RESOURCE_TYPE_IRQ:
>                 {
>                         struct acpi_resource_irq *p = &resource->data.irq;
> -                       if (!p || !p->interrupt_count) {
> +                       if (!p->interrupt_count) {
>                                 /*
>                                  * IRQ descriptors may have no IRQ# bits set,
>                                  * particularly those w/ _STA disabled
> @@ -197,7 +197,7 @@ static acpi_status acpi_pci_link_check_current(struct acpi_resource *resource,
>                 {
>                         struct acpi_resource_extended_irq *p =
>                             &resource->data.extended_irq;
> -                       if (!p || !p->interrupt_count) {
> +                       if (!p->interrupt_count) {
>                                 /*
>                                  * extended IRQ descriptors must
>                                  * return at least 1 IRQ
> --

Applied as 5.20 material with the R-by tag from Bjorn which is still
applicable AFAICS.

Thanks!
