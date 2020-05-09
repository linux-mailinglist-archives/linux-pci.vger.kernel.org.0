Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73F091CC000
	for <lists+linux-pci@lfdr.de>; Sat,  9 May 2020 11:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbgEIJlN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 9 May 2020 05:41:13 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:50948 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgEIJlN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 9 May 2020 05:41:13 -0400
Received: from 89-77-60-66.dynamic.chello.pl (89.77.60.66) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 27d721ed7a9161ea; Sat, 9 May 2020 11:41:10 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ACPI / hotplug / PCI: Use the new acpi_evaluate_reg() helper
Date:   Sat, 09 May 2020 11:41:10 +0200
Message-ID: <1840051.TrPhkc76kE@kreacher>
In-Reply-To: <20200507104917.116589-2-hdegoede@redhat.com>
References: <20200507104917.116589-1-hdegoede@redhat.com> <20200507104917.116589-2-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday, May 7, 2020 12:49:17 PM CEST Hans de Goede wrote:
> Use the new acpi_evaluate_reg() helper in the acpiphp_glue.c code.
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> - Leave comment about not caring about _REG errors in place
> - Add Bjorn's Acked-by
> - Add Andy's Reviewed-by
> ---
>  drivers/pci/hotplug/acpiphp_glue.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> index b3869951c0eb..b4c92cee13f8 100644
> --- a/drivers/pci/hotplug/acpiphp_glue.c
> +++ b/drivers/pci/hotplug/acpiphp_glue.c
> @@ -385,19 +385,12 @@ static unsigned char acpiphp_max_busnr(struct pci_bus *bus)
>  static void acpiphp_set_acpi_region(struct acpiphp_slot *slot)
>  {
>  	struct acpiphp_func *func;
> -	union acpi_object params[2];
> -	struct acpi_object_list arg_list;
>  
>  	list_for_each_entry(func, &slot->funcs, sibling) {
> -		arg_list.count = 2;
> -		arg_list.pointer = params;
> -		params[0].type = ACPI_TYPE_INTEGER;
> -		params[0].integer.value = ACPI_ADR_SPACE_PCI_CONFIG;
> -		params[1].type = ACPI_TYPE_INTEGER;
> -		params[1].integer.value = 1;
>  		/* _REG is optional, we don't care about if there is failure */
> -		acpi_evaluate_object(func_to_handle(func), "_REG", &arg_list,
> -				     NULL);
> +		acpi_evaluate_reg(func_to_handle(func),
> +				  ACPI_ADR_SPACE_PCI_CONFIG,
> +				  ACPI_REG_CONNECT);
>  	}
>  }
>  
> 

Applied as 5.8 material along with the [1/2], thanks!



