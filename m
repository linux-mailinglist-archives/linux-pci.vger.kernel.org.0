Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2677B9CC34
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2019 11:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730507AbfHZJII (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Aug 2019 05:08:08 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:57730 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730398AbfHZJII (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Aug 2019 05:08:08 -0400
Received: from 79.184.255.249.ipv4.supernova.orange.pl (79.184.255.249) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.275)
 id d8ba70a02171e7a4; Mon, 26 Aug 2019 11:08:06 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Krzysztof Wilczynski <kw@linux.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Len Brown <lenb@kernel.org>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI/PCI: Remove surplus parentheses from a return statement
Date:   Mon, 26 Aug 2019 11:08:05 +0200
Message-ID: <7668317.L8HZQqbgEq@kreacher>
In-Reply-To: <20190819135324.29504-1-kw@linux.com>
References: <20190819135324.29504-1-kw@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Monday, August 19, 2019 3:53:24 PM CEST Krzysztof Wilczynski wrote:
> Remove unnecessary parentheses enclosing the value in a return
> statement in the drivers/acpi/pci_link.c.
> 
> Signed-off-by: Krzysztof Wilczynski <kw@linux.com>
> ---
>  drivers/acpi/pci_link.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
> index db11f7771ef1..00a6da2121be 100644
> --- a/drivers/acpi/pci_link.c
> +++ b/drivers/acpi/pci_link.c
> @@ -661,7 +661,7 @@ int acpi_pci_link_allocate_irq(acpi_handle handle, int index, int *triggering,
>  	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
>  			  "Link %s is referenced\n",
>  			  acpi_device_bid(link->device)));
> -	return (link->irq.active);
> +	return link->irq.active;
>  }
>  
>  /*
> @@ -712,7 +712,7 @@ int acpi_pci_link_free_irq(acpi_handle handle)
>  		acpi_evaluate_object(link->device->handle, "_DIS", NULL, NULL);
>  
>  	mutex_unlock(&acpi_link_lock);
> -	return (link->irq.active);
> +	return link->irq.active;
>  }
>  
>  /* --------------------------------------------------------------------------
> 

Applied, thanks!




