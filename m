Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B14F3139585
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2020 17:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbgAMQND (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jan 2020 11:13:03 -0500
Received: from mga17.intel.com ([192.55.52.151]:2540 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726943AbgAMQND (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Jan 2020 11:13:03 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jan 2020 08:13:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,429,1571727600"; 
   d="scan'208";a="244694989"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 13 Jan 2020 08:13:00 -0800
Received: by lahna (sSMTP sendmail emulation); Mon, 13 Jan 2020 18:12:59 +0200
Date:   Mon, 13 Jan 2020 18:12:59 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v1 3/4] PCI: Change extend_bridge_window() to set
 resource size directly
Message-ID: <20200113161259.GN2838@lahna.fi.intel.com>
References: <PSXP216MB04386BA48874B56BC5CB0292803C0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PSXP216MB04386BA48874B56BC5CB0292803C0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 06, 2020 at 03:47:46PM +0000, Nicholas Johnson wrote:
> Change extend_bridge_window() to set resource size directly instead of
> using additional resource lists.
> 
> Because additional resource lists are optional resources, any algorithm
> that requires guaranteed allocation that uses them cannot be guaranteed
> to work.
> 
> Remove the resource from add_list, as a zero-sized additional resource
> is redundant.
> 
> Update comment in pci_bus_distribute_available_resources() to reflect
> the above changes.
> 
> Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
> ---
>  drivers/pci/setup-bus.c | 25 ++++++++-----------------
>  1 file changed, 8 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index de43815be..0c51f4937 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1836,7 +1836,7 @@ static void adjust_bridge_window(struct pci_dev *bridge, struct resource *res,
>  				 struct list_head *add_list,
>  				 resource_size_t new_size)
>  {
> -	struct pci_dev_resource *dev_res;
> +	resource_size_t add_size;
>  
>  	if (res->parent)
>  		return;
> @@ -1844,17 +1844,10 @@ static void adjust_bridge_window(struct pci_dev *bridge, struct resource *res,
>  	if (resource_size(res) >= new_size)
>  		return;
>  
> -	dev_res = res_to_dev_res(add_list, res);
> -	if (!dev_res)
> -		return;
> -
> -	/* Is there room to extend the window? */
> -	if (new_size - resource_size(res) <= dev_res->add_size)
> -		return;
> -
> -	dev_res->add_size = new_size - resource_size(res);
> -	pci_dbg(bridge, "bridge window %pR extended by %pa\n", res,
> -		&dev_res->add_size);
> +	add_size = new_size - resource_size(res);
> +	pci_dbg(bridge, "bridge window %pR extended by %pa\n", res, &add_size);
> +	res->end = res->start + new_size - 1;
> +	remove_from_list(add_list, res);
>  }
>  
>  static void pci_bus_distribute_available_resources(struct pci_bus *bus,
> @@ -1889,11 +1882,9 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
>  		mmio_pref.start = min(ALIGN(mmio_pref.start, align),
>  			mmio_pref.end + 1);
>  
> -	/*
> -	 * Update additional resource list (add_list) to fill all the
> -	 * extra resource space available for this port except the space
> -	 * calculated in __pci_bus_size_bridges() which covers all the
> -	 * devices currently connected to the port and below.
> +        /*

Indentation is wrong here.

> +	 * Now that we have adjusted for alignment, update the bridge window
> +	 * resources to fill as much remaining resource space as possible.
>  	 */
>  	adjust_bridge_window(bridge, io_res, add_list, resource_size(&io));
>  	adjust_bridge_window(bridge, mmio_res, add_list, resource_size(&mmio));
> -- 
> 2.24.1
