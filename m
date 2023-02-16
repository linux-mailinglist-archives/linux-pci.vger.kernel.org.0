Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476F869A271
	for <lists+linux-pci@lfdr.de>; Fri, 17 Feb 2023 00:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjBPXfv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Feb 2023 18:35:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjBPXfu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Feb 2023 18:35:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F03505D6;
        Thu, 16 Feb 2023 15:35:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCE6360FA1;
        Thu, 16 Feb 2023 23:35:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C889C433D2;
        Thu, 16 Feb 2023 23:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676590548;
        bh=lGszigiE1/T0L/7T41sl5D8a4KkWnL92P8Rg9/npbJo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=sc1chltGPLVMJUKhxXULbOIadvBVnqPikyGD6FWqCDtuRI+SfOhgUKELqLgwmSQPu
         6CN6EQdH+Y1madB7qWTnubzTe0QGffeYZXYfMwKYpW1es478j0PGHni9qaDF3xR7nk
         0jZfydtV/UoGMcwxQ231oRpSCQiUq1usAN2juBTha/38JreP9YV+tzHPzK66Bl6I03
         bxM5/RGu0rpr5UdrexUusr8KMh/JuxwvZXSfW1P8Fne/MpwL5svsy98bS+J2N4gy1D
         rHGKkjE+kk/l/i9Qlvfikf+/mmp8vZXok69rLuFxQ3X9pDkI4AIpznyHJaqsb0hZEe
         6J7JIXjwqnClQ==
Date:   Thu, 16 Feb 2023 17:35:46 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     guo.ziliang@zte.com.cn
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, chen.lin5@zte.com.cn,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIFBDSTog?= =?utf-8?Q?of=3A_War?=
 =?utf-8?Q?n?= if bridge base/limit region overlaps with system ram region
Message-ID: <20230216233546.GA3354802@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202301091635256312056@zte.com.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Joerg, Will, Robin]

On Mon, Jan 09, 2023 at 04:35:25PM +0800, guo.ziliang@zte.com.cn wrote:
> bridge base/limit(memory behind in lspci info, outbound pcie address/size)
> region is used to route outbound mem read/write transaction to ep. This
> base/limit region also may filter out inbound transactions which will
> result in inbound(eg: dma) transaction fail.
> 
> For example, if bridge base/limit is [0x20000000, 0x203fffff], system ram
> is [0x20000000, 0x27ffffff]. The inbound mapping is usually 1:1 equal
> mapping. When allocated system ram for inbound tansaction is 0x20004000
> (any in bridge base/limit), this inbound transactions will be filter out.
> 
> AER may report 'UnsupReq' on inbound mem read/write transactions if address
> is in this base/limit region, but not all pcie AER enabled or work well. We
> warn it also in bridge pci address setting phase.
> 
> Signed-off-by: Chen Lin <chen.lin5@zte.com.cn>

This would need the 0-day warnings cleaned up, of course.

> ---
>  drivers/pci/setup-bus.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index b4096598dbcb..1a9f527d2317 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -608,6 +608,24 @@ static void pci_setup_bridge_io(struct pci_dev *bridge)
>  	pci_write_config_dword(bridge, PCI_IO_BASE_UPPER16, io_upper16);
>  }
> 
> +static void check_bridge_region_overlaps_systemram(struct pci_dev *bridge,
> +							struct pci_bus_region *region)
> +{
> +	int is_ram;
> +
> +	/*
> +	 * bridge base/limit(memory behind) region may filter out inbound
> +	 * transactions which will result in inbound(eg: dma) fail of ep.
> +	 * AER may report it if enabled, we warn it also.
> +	 */
> +	is_ram = region_intersects(region->start, region->end - region->start + 1,
> +				IORESOURCE_SYSTEM_RAM, IORES_DESC_NONE);
> +	if (is_ram == REGION_INTERSECTS) {
> +		pci_warn(bridge, "%#012llx..%#012llx bridge base/limit region overlaps with system ram, may result in inbound fail\n",
> +			region->start, region->end);

This compares PCI bus addresses (from struct pci_bus_region) with CPU
physical addresses (the struct resources used by region_intersects()).

But I don't think you can do that directly because an IOMMU might map
those PCI bus addresses to something different before a DMA gets to
system RAM.

I see that you say "The inbound mapping is usually 1:1 equal mapping"
above, so maybe I'm missing something.  Maybe the IOMMU folks will
clue me in.

> +	}
> +}
> +
>  static void pci_setup_bridge_mmio(struct pci_dev *bridge)
>  {
>  	struct resource *res;
> @@ -621,6 +639,7 @@ static void pci_setup_bridge_mmio(struct pci_dev *bridge)
>  		l = (region.start >> 16) & 0xfff0;
>  		l |= region.end & 0xfff00000;
>  		pci_info(bridge, "  bridge window %pR\n", res);
> +		check_bridge_region_overlaps_systemram(bridge, &region);
>  	} else {
>  		l = 0x0000fff0;
>  	}
> @@ -652,6 +671,7 @@ static void pci_setup_bridge_mmio_pref(struct pci_dev *bridge)
>  			lu = upper_32_bits(region.end);
>  		}
>  		pci_info(bridge, "  bridge window %pR\n", res);
> +		check_bridge_region_overlaps_systemram(bridge, &region);
>  	} else {
>  		l = 0x0000fff0;
>  	}
> -- 
> 2.15.2
