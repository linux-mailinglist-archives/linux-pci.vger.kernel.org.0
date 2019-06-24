Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6881551898
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2019 18:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbfFXQ0K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jun 2019 12:26:10 -0400
Received: from ale.deltatee.com ([207.54.116.67]:37280 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbfFXQ0J (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 Jun 2019 12:26:09 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hfRnE-0007se-EI; Mon, 24 Jun 2019 10:26:09 -0600
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
References: <20190622210310.180905-1-helgaas@kernel.org>
 <20190622210310.180905-3-helgaas@kernel.org>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <13911af4-66f5-ece8-378b-6af8eba98381@deltatee.com>
Date:   Mon, 24 Jun 2019 10:26:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190622210310.180905-3-helgaas@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: bhelgaas@google.com, linux-pci@vger.kernel.org, benh@kernel.crashing.org, nicholas.johnson-opensource@outlook.com.au, mika.westerberg@linux.intel.com, helgaas@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH 2/2] PCI: Skip resource distribution when no hotplug
 bridges
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019-06-22 3:03 p.m., Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> If "hotplug_bridges == 0", "!dev->is_hotplug_bridge" is always true, so the
> loop that divides the remaining resources among hotplug-capable bridges
> does nothing.
> 
> Check for "hotplug_bridges == 0" earlier, so we don't even have to compute
> the amount of remaining resources.  No functional change intended.

Makes sense.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

> ---
> 
> I'm pretty sure this patch preserves the previous behavior of
> pci_bus_distribute_available_resources(), but I'm not sure that
> behavior is what we want.
> 
> For example, in the following topology, when we process bus 10, we
> find two non-hotplug bridges and no hotplug bridges, so IIUC we return
> without distributing any resources to them.  But I would think we
> should try to give 10:1c.0 more space if possible because it has a
> hotplug bridge below it.
> 
>   00:1c.0: hotplug bridge to [bus 10-2f]
>     10:1c.0: non-hotplug bridge to [bus 11-2e]
>       11:00.0: hotplug bridge to [bus 12-2e]
>     10:1c.1: non-hotplug bridge to [bus 2f]
> ---
>  drivers/pci/setup-bus.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index af28af898e42..04adeebe8866 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1887,6 +1887,9 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
>  		return;
>  	}
>  
> +	if (hotplug_bridges == 0)
> +		return;
> +
>  	/*
>  	 * Calculate the total amount of extra resource space we can
>  	 * pass to bridges below this one.  This is basically the
> @@ -1936,8 +1939,6 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
>  		 * Distribute available extra resources equally between
>  		 * hotplug-capable downstream ports taking alignment into
>  		 * account.
> -		 *
> -		 * Here hotplug_bridges is always != 0.
>  		 */
>  		align = pci_resource_alignment(bridge, io_res);
>  		io = div64_ul(available_io, hotplug_bridges);
> 
