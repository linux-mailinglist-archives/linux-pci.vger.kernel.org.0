Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7068257BF4E
	for <lists+linux-pci@lfdr.de>; Wed, 20 Jul 2022 22:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiGTUob (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Jul 2022 16:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiGTUoa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jul 2022 16:44:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CB85006A;
        Wed, 20 Jul 2022 13:44:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35A7E61CCC;
        Wed, 20 Jul 2022 20:44:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59BB5C3411E;
        Wed, 20 Jul 2022 20:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658349868;
        bh=zhiyjAW9l4b4itQWhFUg7rsehAAhronWLWWddtiazk8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=QMa3za9JYFJljN29o+DxJwNZ0EoZ97n3e8Ft1Zbg6C07nib+EiOC4UgvoaxdMS7rl
         rVQe0ccnOz1wDC4GJ5KHQVIiMh00YPCDHWUAd7OGScLey1N7PiM7dNgNo79aprNtJC
         2QU5oyJTYVW9ZPhjtEThW+EqhqdAKWIEAi9uKWPMKOkFaQ2VYIgE+CEimV7+FzKuOH
         YthYPg8f3V3/RMWVAR999jtZwgKgTHUJ9dUsDs18JZAAeVzodPCcfr/R0mbYIscjgo
         ZGsnm+RVOLtyyAAoyQGMhDlavK5Uh0cQJLB3YkS2nc8HhzTvmdLBdCNHN+umMBX3td
         1IS41iIE/61Jw==
Date:   Wed, 20 Jul 2022 15:44:26 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andrey Strachuk <strochuk@ispras.ru>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: Re: [PATCH v2] ACPI/PCI: Remove useless NULL pointer checks
Message-ID: <20220720204426.GA1655974@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720094743.471304-1-strochuk@ispras.ru>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 20, 2022 at 12:47:43PM +0300, Andrey Strachuk wrote:
> Local variable 'p' is initialized by an address
> of field of acpi_resource, so it does not make
> sense to compare 'p' with NULL.

Rewrap to fill 75 columns, which is the typical width of commit logs.

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
>  	case ACPI_RESOURCE_TYPE_IRQ:
>  		{
>  			struct acpi_resource_irq *p = &resource->data.irq;
> -			if (!p || !p->interrupt_count) {
> +			if (!p->interrupt_count) {
>  				acpi_handle_debug(handle,
>  						  "Blank _PRS IRQ resource\n");
>  				return AE_OK;
> @@ -121,7 +121,7 @@ static acpi_status acpi_pci_link_check_possible(struct acpi_resource *resource,
>  		{
>  			struct acpi_resource_extended_irq *p =
>  			    &resource->data.extended_irq;
> -			if (!p || !p->interrupt_count) {
> +			if (!p->interrupt_count) {
>  				acpi_handle_debug(handle,
>  						  "Blank _PRS EXT IRQ resource\n");
>  				return AE_OK;
> @@ -182,7 +182,7 @@ static acpi_status acpi_pci_link_check_current(struct acpi_resource *resource,
>  	case ACPI_RESOURCE_TYPE_IRQ:
>  		{
>  			struct acpi_resource_irq *p = &resource->data.irq;
> -			if (!p || !p->interrupt_count) {
> +			if (!p->interrupt_count) {
>  				/*
>  				 * IRQ descriptors may have no IRQ# bits set,
>  				 * particularly those w/ _STA disabled
> @@ -197,7 +197,7 @@ static acpi_status acpi_pci_link_check_current(struct acpi_resource *resource,
>  		{
>  			struct acpi_resource_extended_irq *p =
>  			    &resource->data.extended_irq;
> -			if (!p || !p->interrupt_count) {
> +			if (!p->interrupt_count) {
>  				/*
>  				 * extended IRQ descriptors must
>  				 * return at least 1 IRQ
> -- 
> 2.25.1
> 
