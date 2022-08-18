Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E375990F1
	for <lists+linux-pci@lfdr.de>; Fri, 19 Aug 2022 01:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237537AbiHRXIB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Aug 2022 19:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbiHRXIA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Aug 2022 19:08:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE532CD7A9;
        Thu, 18 Aug 2022 16:07:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A2780B82472;
        Thu, 18 Aug 2022 23:07:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4349FC433D7;
        Thu, 18 Aug 2022 23:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660864077;
        bh=6a7m0YcpcUjPYa023sAzFGjFlzfOCLmKb81a52hZzLI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=R8UtnXDQmBNoIHnSSvtlAOJtUF9gTge98e02X7I9RU79zMaanJcp+okZaz5e90gCT
         MnvVDFbb1uuHf5IiS1UtPIvkf1K3tx0nEyy+4kRposUGDa6OcAhZkDKcry5hpBGyIQ
         EuCrwa/gi6xwePqHACtusMcqkPHlnl+VNO3BfZYXaa5n5KM3/GBYKwAZT4H4kktQGV
         YA1VVlovIZJ1XzmMTTQ5/HbfEi86Jxnny9yDvu2e1I7lgA9zLQ/n08mQS1IpcN9HTR
         izGvu8UVsKcjTkVWmqCHMTOyNxbqCSzdR5evT9EyARTKtf/Bn8+kn7qf0MK/4U0eKM
         7P9mAgifYj6ZA==
Date:   Thu, 18 Aug 2022 18:07:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
Cc:     bhelgaas@google.com, kw@linux.com, os.vaslot@gmail.com,
        makvihas@gmail.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: ibmphp: Adjusting the parameter list of a function
Message-ID: <20220818230755.GA2403414@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220814151956.16950-1-abd.masalkhi@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Aug 14, 2022 at 05:19:56PM +0200, Abd-Alrhman Masalkhi wrote:
> ibmphp_init_devno() takes a struct slot **, and it should be changed
> to take struct slot * instead.

The commit log needs to explain *why* it should be changed from
"struct slot **" to "struct slot *".

And the subject line should give a clue about that, too.

Both subject and commit log should be "imperative," e.g., they should
read as if you were giving a command.  "PCI: ibmphp: Convert ..."

This commit log says what *should* happen.  It should read as though
it's a command carried out by the commit: "Convert 'struct slot **' to
'struct slot *' because ..."

> Signed-off-by: Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
> ---
>  drivers/pci/hotplug/TODO          |  3 ---
>  drivers/pci/hotplug/ibmphp.h      |  3 ++-
>  drivers/pci/hotplug/ibmphp_core.c | 30 +++++++++++++++---------------
>  drivers/pci/hotplug/ibmphp_ebda.c |  2 +-
>  4 files changed, 18 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/TODO b/drivers/pci/hotplug/TODO
> index 88f217c82b4f..63a9fed407ed 100644
> --- a/drivers/pci/hotplug/TODO
> +++ b/drivers/pci/hotplug/TODO
> @@ -30,9 +30,6 @@ ibmphp:
>    or ibmphp should store a pointer to its bus in struct slot.  Probably the
>    former.
>  
> -* ibmphp_init_devno() takes a struct slot **, it could instead take a
> -  struct slot *.
> -
>  * The return value of pci_hp_register() is not checked.
>  
>  * The various slot data structures are difficult to follow and need to be
> diff --git a/drivers/pci/hotplug/ibmphp.h b/drivers/pci/hotplug/ibmphp.h
> index 0399c60d2ec1..148a421eb262 100644
> --- a/drivers/pci/hotplug/ibmphp.h
> +++ b/drivers/pci/hotplug/ibmphp.h
> @@ -734,7 +734,8 @@ struct controller {
>  
>  /* Functions */
>  
> -int ibmphp_init_devno(struct slot **);	/* This function is called from EBDA, so we need it not be static */
> +/* ibmphp_init_devno() is called from EBDA, so we need it not be static */
> +int ibmphp_init_devno(struct slot *cur_slot);
>  int ibmphp_do_disable_slot(struct slot *slot_cur);
>  int ibmphp_update_slot_info(struct slot *);	/* This function is called from HPC, so we need it to not be static */
>  int ibmphp_configure_card(struct pci_func *, u8);
> diff --git a/drivers/pci/hotplug/ibmphp_core.c b/drivers/pci/hotplug/ibmphp_core.c
> index 197997e264a2..107752b11f2c 100644
> --- a/drivers/pci/hotplug/ibmphp_core.c
> +++ b/drivers/pci/hotplug/ibmphp_core.c
> @@ -109,7 +109,7 @@ static int __init get_max_slots(void)
>   * Parameters: struct slot
>   * Returns 0 or errors
>   */
> -int ibmphp_init_devno(struct slot **cur_slot)
> +int ibmphp_init_devno(struct slot *cur_slot)
>  {
>  	struct irq_routing_table *rtable;
>  	int len;
> @@ -130,21 +130,21 @@ int ibmphp_init_devno(struct slot **cur_slot)
>  		return -1;
>  	}
>  	for (loop = 0; loop < len; loop++) {
> -		if ((*cur_slot)->number == rtable->slots[loop].slot &&
> -		    (*cur_slot)->bus == rtable->slots[loop].bus) {
> -			(*cur_slot)->device = PCI_SLOT(rtable->slots[loop].devfn);
> +		if (cur_slot->number == rtable->slots[loop].slot &&
> +		    cur_slot->bus == rtable->slots[loop].bus) {
> +			cur_slot->device = PCI_SLOT(rtable->slots[loop].devfn);
>  			for (i = 0; i < 4; i++)
> -				(*cur_slot)->irq[i] = IO_APIC_get_PCI_irq_vector((int) (*cur_slot)->bus,
> -						(int) (*cur_slot)->device, i);
> -
> -			debug("(*cur_slot)->irq[0] = %x\n",
> -					(*cur_slot)->irq[0]);
> -			debug("(*cur_slot)->irq[1] = %x\n",
> -					(*cur_slot)->irq[1]);
> -			debug("(*cur_slot)->irq[2] = %x\n",
> -					(*cur_slot)->irq[2]);
> -			debug("(*cur_slot)->irq[3] = %x\n",
> -					(*cur_slot)->irq[3]);
> +				cur_slot->irq[i] = IO_APIC_get_PCI_irq_vector((int) cur_slot->bus,
> +						(int) cur_slot->device, i);
> +
> +			debug("cur_slot->irq[0] = %x\n",
> +					cur_slot->irq[0]);
> +			debug("cur_slot->irq[1] = %x\n",
> +					cur_slot->irq[1]);
> +			debug("cur_slot->irq[2] = %x\n",
> +					cur_slot->irq[2]);
> +			debug("cur_slot->irq[3] = %x\n",
> +					cur_slot->irq[3]);
>  
>  			debug("rtable->exclusive_irqs = %x\n",
>  					rtable->exclusive_irqs);
> diff --git a/drivers/pci/hotplug/ibmphp_ebda.c b/drivers/pci/hotplug/ibmphp_ebda.c
> index 7fb75401ad8a..5c7821ad9c2c 100644
> --- a/drivers/pci/hotplug/ibmphp_ebda.c
> +++ b/drivers/pci/hotplug/ibmphp_ebda.c
> @@ -880,7 +880,7 @@ static int __init ebda_rsrc_controller(void)
>  			if (rc)
>  				goto error;
>  
> -			rc = ibmphp_init_devno(&tmp_slot);
> +			rc = ibmphp_init_devno(tmp_slot);
>  			if (rc)
>  				goto error;
>  			tmp_slot->hotplug_slot.ops = &ibmphp_hotplug_slot_ops;
> -- 
> 2.29.0.rc1.dirty
> 
