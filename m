Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8FB57A875
	for <lists+linux-pci@lfdr.de>; Tue, 19 Jul 2022 22:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234669AbiGSUqi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Jul 2022 16:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbiGSUqi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jul 2022 16:46:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355434F1BF;
        Tue, 19 Jul 2022 13:46:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B79B9B81D3C;
        Tue, 19 Jul 2022 20:46:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 456B2C341C6;
        Tue, 19 Jul 2022 20:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658263594;
        bh=WKFGjuXRk6oyteotSlWefi1rk9n4LI3dK/a2vIQpaPQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=eSgXBHQxc39Mb7qbp8RzMRW/S4KAFvTtt1Q7x9YbJ6xpb2nE2MK9Q/pbMbWKChYwe
         OXo6npKiTqswH7YemODJBMfoWF+IDwj8DgYU6IpyHNBzGsxiqU01TJprjmskWlA+le
         TM2NWikCByNMoePPlRzR8a6zLdljiCkJ/DfiJbv1WHjl9vmr8OX8NN7RcfI6Wpd4uY
         HCq/RVd+mSpu54UI1Wre7unHq2neWZzafiRsR6TUkoA9q8irLTzGzGICCXLqdNo8WV
         iPLcBZOvBtHCnZD3KsI2NwlZsmULrE2RA5xdsVeHJjk5xvM+zzYOHxGyK2JnLV3eHm
         UgIR+hqSUNR2w==
Date:   Tue, 19 Jul 2022 15:46:32 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andrey Strachuk <strochuk@ispras.ru>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: Re: [PATCH] ACPI: remove useless comparisons in
 acpi_pci_link_check_possible(), acpi_pci_link_check_current()
Message-ID: <20220719204632.GA1562909@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719095950.5420-1-strochuk@ispras.ru>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since this only affects pci_link.c, I would update the subject to
match the style of previous commits:

  ACPI/PCI: Remove useless NULL pointer checks

On Tue, Jul 19, 2022 at 12:59:50PM +0300, Andrey Strachuk wrote:
> Local variable 'p' is initialized by an address
> of field of acpi_resource, so it does not make
> sense to compare 'p' with NULL.

Rewrap to fill 75 columns, which is the typical width of commit logs.

> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Andrey Strachuk <strochuk@ispras.ru>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

I think you should drop this Fixes: tag because it's not useful.

Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>

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
