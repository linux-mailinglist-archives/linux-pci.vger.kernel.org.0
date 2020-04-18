Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D91C31AF44C
	for <lists+linux-pci@lfdr.de>; Sat, 18 Apr 2020 21:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbgDRTjZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 18 Apr 2020 15:39:25 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:52425 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727927AbgDRTjZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 18 Apr 2020 15:39:25 -0400
Received: from 185.80.35.16 (185.80.35.16) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 4b7184154c6e0ddc; Sat, 18 Apr 2020 21:39:23 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] ACPI/PCI: pci_link: use extended_irq union member when setting ext-irq shareable
Date:   Sat, 18 Apr 2020 21:39:23 +0200
Message-ID: <5152885.VTvHoEJcxH@kreacher>
In-Reply-To: <20200413130949.302829-1-hdegoede@redhat.com>
References: <20200413130949.302829-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Monday, April 13, 2020 3:09:49 PM CEST Hans de Goede wrote:
> The case ACPI_RESOURCE_TYPE_EXTENDED_IRQ inside acpi_pci_link_set()
> is correctly using resource->res.data.extended_irq.foo for most settings,
> but for the shareable setting it so far has accidentally been using
> resource->res.data.irq.shareable instead of
> resource->res.data.extended_irq.shareable.
> 
> Note that the old code happens to also work because the shareable field
> offset is the same for both the acpi_resource_irq and
> acpi_resource_extended_irq structs.
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> - Fix some spelling errors in the commit message pointed out by Bjorn
> - Add Bjorn's Acked-by
> ---
>  drivers/acpi/pci_link.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
> index 00a6da2121be..ed3d2182cf2c 100644
> --- a/drivers/acpi/pci_link.c
> +++ b/drivers/acpi/pci_link.c
> @@ -322,10 +322,10 @@ static int acpi_pci_link_set(struct acpi_pci_link *link, int irq)
>  		resource->res.data.extended_irq.polarity =
>  		    link->irq.polarity;
>  		if (link->irq.triggering == ACPI_EDGE_SENSITIVE)
> -			resource->res.data.irq.shareable =
> +			resource->res.data.extended_irq.shareable =
>  			    ACPI_EXCLUSIVE;
>  		else
> -			resource->res.data.irq.shareable = ACPI_SHARED;
> +			resource->res.data.extended_irq.shareable = ACPI_SHARED;
>  		resource->res.data.extended_irq.interrupt_count = 1;
>  		resource->res.data.extended_irq.interrupts[0] = irq;
>  		/* ignore resource_source, it's optional */
> 

Applied as 5.7-rc material, thanks!




