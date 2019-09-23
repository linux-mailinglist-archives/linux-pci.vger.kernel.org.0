Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48A88BB3DE
	for <lists+linux-pci@lfdr.de>; Mon, 23 Sep 2019 14:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394414AbfIWMfq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Sep 2019 08:35:46 -0400
Received: from foss.arm.com ([217.140.110.172]:41358 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392367AbfIWMfq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 23 Sep 2019 08:35:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C23E142F;
        Mon, 23 Sep 2019 05:35:46 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B939C3F694;
        Mon, 23 Sep 2019 05:35:45 -0700 (PDT)
Date:   Mon, 23 Sep 2019 13:35:44 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     sundeep.lkml@gmail.com
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, sean.stalley@intel.com,
        bhelgaas@google.com, sgoutham@marvell.com,
        Subbaraya Sundeep <sbhatta@marvell.com>
Subject: Re: [PATCH] PCI: Do not use bus number zero from EA capability
Message-ID: <20190923123543.GL9720@e119886-lin.cambridge.arm.com>
References: <1567438203-8405-1-git-send-email-sundeep.lkml@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567438203-8405-1-git-send-email-sundeep.lkml@gmail.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 02, 2019 at 09:00:03PM +0530, sundeep.lkml@gmail.com wrote:
> From: Subbaraya Sundeep <sbhatta@marvell.com>
> 
> As per the spec, "Enhanced Allocation (EA) for Memory
> and I/O Resources" ECN, approved 23 October 2014,
> sec 6.9.1.2, fixed bus numbers of a bridge can be zero

s/can/must/

The spec uses the term *must*. "Can" implies that this is optional.

> when no function that uses EA is located behind it.
> Hence assign bus numbers sequentially when fixed bus
> numbers are zero.

Perhaps s/sequentially/as per normal/ or similar. As we're not doing
anything different here.

> 
> Fixes: 2dbce590117981196fe355efc0569bc6f949ae9b

Is it worth describing what actually goes wrong without this patch - and
when this occurs? I guess it's possible for a bridge to have an EA
capability, but no devices using EA behind it - and thus in this suitation
the downstream devices have unnecessary bus number constraints?

> 
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>

Does this need to be CC'd to stable?

> ---
>  drivers/pci/probe.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index a3c7338..c06ca4c 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1095,27 +1095,28 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
>   * @sub: updated with subordinate bus number from EA
>   *
>   * If @dev is a bridge with EA capability, update @sec and @sub with
> - * fixed bus numbers from the capability and return true.  Otherwise,
> - * return false.
> + * fixed bus numbers from the capability. Otherwise @sec and @sub
> + * will be zeroed.
>   */
> -static bool pci_ea_fixed_busnrs(struct pci_dev *dev, u8 *sec, u8 *sub)
> +static void pci_ea_fixed_busnrs(struct pci_dev *dev, u8 *sec, u8 *sub)
>  {
>  	int ea, offset;
>  	u32 dw;
>  
> +	*sec = *sub = 0;
> +
>  	if (dev->hdr_type != PCI_HEADER_TYPE_BRIDGE)
> -		return false;
> +		return;
>  
>  	/* find PCI EA capability in list */
>  	ea = pci_find_capability(dev, PCI_CAP_ID_EA);
>  	if (!ea)
> -		return false;
> +		return;
>  
>  	offset = ea + PCI_EA_FIRST_ENT;
>  	pci_read_config_dword(dev, offset, &dw);
>  	*sec =  dw & PCI_EA_SEC_BUS_MASK;
>  	*sub = (dw & PCI_EA_SUB_BUS_MASK) >> PCI_EA_SUB_BUS_SHIFT;

Is there any value in doing any sanity checking here? E.g. sub !=0, sub > sec?

> -	return true;
>  }
>  
>  /*
> @@ -1151,7 +1152,6 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>  	u16 bctl;
>  	u8 primary, secondary, subordinate;
>  	int broken = 0;
> -	bool fixed_buses;
>  	u8 fixed_sec, fixed_sub;
>  	int next_busnr;
>  
> @@ -1254,11 +1254,12 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>  		pci_write_config_word(dev, PCI_STATUS, 0xffff);
>  
>  		/* Read bus numbers from EA Capability (if present) */
> -		fixed_buses = pci_ea_fixed_busnrs(dev, &fixed_sec, &fixed_sub);
> -		if (fixed_buses)
> +		pci_ea_fixed_busnrs(dev, &fixed_sec, &fixed_sub);
> +
> +		next_busnr = max + 1;
> +		/* Use secondary bus number in EA */
> +		if (fixed_sec)
>  			next_busnr = fixed_sec;
> -		else
> -			next_busnr = max + 1;

There is a subtle style change here (assigning and then potentially reassigning
with a new value vs assigning once using both if/else). No idea if this matters
but I thought I'd point it out in case it wasn't intentional.

Thanks,

Andrew Murray

>  
>  		/*
>  		 * Prevent assigning a bus number that already exists.
> @@ -1336,7 +1337,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>  		 * If fixed subordinate bus number exists from EA
>  		 * capability then use it.
>  		 */
> -		if (fixed_buses)
> +		if (fixed_sub)
>  			max = fixed_sub;
>  		pci_bus_update_busn_res_end(child, max);
>  		pci_write_config_byte(dev, PCI_SUBORDINATE_BUS, max);
> -- 
> 2.7.4
> 
