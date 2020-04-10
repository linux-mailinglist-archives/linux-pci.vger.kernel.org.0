Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6671A4AC9
	for <lists+linux-pci@lfdr.de>; Fri, 10 Apr 2020 21:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgDJTpt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Apr 2020 15:45:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:54504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726142AbgDJTpt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 Apr 2020 15:45:49 -0400
Received: from localhost (mobile-166-170-220-109.mycingular.net [166.170.220.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B18E720801;
        Fri, 10 Apr 2020 19:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586547949;
        bh=c9U8OrXPzk6frqhLN2HldS4XFESUo13MLKIaOOx0aJk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=oKeHSPEtbSVJZMuOzAFicZXHe70ZNxXjWWd+pgHYft6o+6ixfKi7WzlNUJNyq/AZU
         xl4Qqa98YTjfELxi0UUbol11KixUPBpbmi+Ueg0VviCuESZJ9H+rHaTZFRl9SFwCUm
         ZhD7/CkXxcQKvF0N1TjYzg5kfQWPTqQSHtdLrJxM=
Date:   Fri, 10 Apr 2020 14:45:47 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] ACPI/PCI: pci_link: use extended_irq union member when
 setting ext-irq shareable
Message-ID: <20200410194547.GA7293@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200410131442.22842-1-hdegoede@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 10, 2020 at 03:14:42PM +0200, Hans de Goede wrote:
> The case ACPI_RESOURCE_TYPE_EXTENDED_IRQ inside acpi_pci_link_set()
> is correctly using resource->res.data.extended_irq.foo for most settings,
> but for the sharable setting it sofar has accidentally been using
> resource->res.data.irq.shareable instead of
> resource->res.data.extended_irq.shareable.
> 
> Note that the old code happens to also work because the sharable field
> offset is the same for both the acpi_resource_irq and
> acpi_resource_extended_irq structs.

s/sharable/shareable/ several times above
s/sofar/so far/

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

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

Ouch, looks like that copy/paste error has been there since the
beginning of git.  Nice catch!

>  		resource->res.data.extended_irq.interrupt_count = 1;
>  		resource->res.data.extended_irq.interrupts[0] = irq;
>  		/* ignore resource_source, it's optional */
> -- 
> 2.26.0
> 
