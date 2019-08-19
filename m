Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1CB94B9B
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2019 19:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbfHSRZq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Aug 2019 13:25:46 -0400
Received: from foss.arm.com ([217.140.110.172]:57722 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727524AbfHSRZq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 19 Aug 2019 13:25:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9468C360;
        Mon, 19 Aug 2019 10:25:45 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 155553F246;
        Mon, 19 Aug 2019 10:25:44 -0700 (PDT)
Date:   Mon, 19 Aug 2019 18:25:43 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Krzysztof Wilczynski <kw@linux.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI/PCI: Remove surplus parentheses from a return
 statement
Message-ID: <20190819172543.GA23903@e119886-lin.cambridge.arm.com>
References: <20190819135324.29504-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819135324.29504-1-kw@linux.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 19, 2019 at 03:53:24PM +0200, Krzysztof Wilczynski wrote:
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

It looks like these parentheses were left over after a patch that removed some
macros:

 ad550d98d3317 ("ACPI: delete tracing macros from drivers/acpi/*.c")

I can't see any you've missed so:

Reviewed-by: Andrew Murray <andrew.murray@arm.com>


>  }
>  
>  /* --------------------------------------------------------------------------
> -- 
> 2.22.1
> 
