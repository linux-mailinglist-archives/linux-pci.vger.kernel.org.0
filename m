Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 749B61C5DCC
	for <lists+linux-pci@lfdr.de>; Tue,  5 May 2020 18:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729885AbgEEQpI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 May 2020 12:45:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:52744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729541AbgEEQpI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 May 2020 12:45:08 -0400
Received: from localhost (mobile-166-175-56-67.mycingular.net [166.175.56.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C76F20746;
        Tue,  5 May 2020 16:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588697107;
        bh=+igWX9Bk88XIswSYeGW+x3/UppcDxT+gwnYJcjP87oI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=CxSj5RjExHqxxc0TCveV6jZ7RQSSjX7RtyLcDJ5NPHustCiFZQBf4UlspwmGhhCJf
         sA3nCM8rLp9VgtzgKshaUcLQ/8u52sRFttc3gPZdG/jGCfDS3JwI1vz/hvAiQISqUH
         6kYTu4ppBsTa7zg9ywttrrU4if1yFfooIZLueN3E=
Date:   Tue, 5 May 2020 11:45:06 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH 2/3] ACPI / hotplug / PCI: Use the new
 acpi_evaluate_reg() helper
Message-ID: <20200505164506.GA365569@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505132128.19476-3-hdegoede@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 05, 2020 at 03:21:27PM +0200, Hans de Goede wrote:
> Use the new acpi_evaluate_reg() helper in the acpiphp_glue.c code.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

OK by me if this is merged with the first.

> ---
>  drivers/pci/hotplug/acpiphp_glue.c | 17 ++++-------------
>  1 file changed, 4 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> index b3869951c0eb..fd77eb1d460c 100644
> --- a/drivers/pci/hotplug/acpiphp_glue.c
> +++ b/drivers/pci/hotplug/acpiphp_glue.c
> @@ -385,20 +385,11 @@ static unsigned char acpiphp_max_busnr(struct pci_bus *bus)
>  static void acpiphp_set_acpi_region(struct acpiphp_slot *slot)
>  {
>  	struct acpiphp_func *func;
> -	union acpi_object params[2];
> -	struct acpi_object_list arg_list;
>  
> -	list_for_each_entry(func, &slot->funcs, sibling) {
> -		arg_list.count = 2;
> -		arg_list.pointer = params;
> -		params[0].type = ACPI_TYPE_INTEGER;
> -		params[0].integer.value = ACPI_ADR_SPACE_PCI_CONFIG;
> -		params[1].type = ACPI_TYPE_INTEGER;
> -		params[1].integer.value = 1;
> -		/* _REG is optional, we don't care about if there is failure */
> -		acpi_evaluate_object(func_to_handle(func), "_REG", &arg_list,
> -				     NULL);
> -	}
> +	list_for_each_entry(func, &slot->funcs, sibling)
> +		acpi_evaluate_reg(func_to_handle(func),
> +				  ACPI_ADR_SPACE_PCI_CONFIG,
> +				  ACPI_REG_CONNECT);
>  }
>  
>  static void check_hotplug_bridge(struct acpiphp_slot *slot, struct pci_dev *dev)
> -- 
> 2.26.0
> 
