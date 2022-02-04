Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F05D24AA294
	for <lists+linux-pci@lfdr.de>; Fri,  4 Feb 2022 22:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241199AbiBDVtF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Feb 2022 16:49:05 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43262 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238679AbiBDVtF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Feb 2022 16:49:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B67FC618C9;
        Fri,  4 Feb 2022 21:49:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D176AC004E1;
        Fri,  4 Feb 2022 21:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644011344;
        bh=/3nBBGtXDUFpmYyi9xKAAR9eD/NSPwOIkW8AaplcThs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=FsnUQU7Nos2g8hyiAj3+JCW3KEC8mePVfp7WSxnhmaFn/elfu0rpwo0sPHPDa2VR0
         UG6OIKZiZ6a8XVHzu+mNGtPfARtK5jaTUrLb7pW+ahxegP+H31Qb8gC3XTVLXwAhY1
         8sdz7AZUBUDGaFnIaopTl9o2rk6ysbiFPt36/C7QIj3mpLdBXdpXg0gqYZuu1mh4W9
         9gOySzq8q1Lw8tfg8nS/DBS74q4U5t9auvMchIv6xCM9s1ZUwz2kt3rVjf6bCwNODj
         W3nmH3ngYynRQxVi3T2/CiIsNg3k4p8NaWhVJSAbnTt7UqagnAqHqLo3I62gq2xkrP
         dYsqOXZodVzGw==
Date:   Fri, 4 Feb 2022 15:49:02 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     ira.weiny@intel.com
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH V6 02/10] PCI: Replace magic constant for PCI Sig Vendor
 ID
Message-ID: <20220204214902.GA220669@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201071952.900068-3-ira.weiny@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 31, 2022 at 11:19:44PM -0800, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Based on Bjorn's suggestion[1], now that the PCI Sig Vendor ID is
> defined the define should be used in pci_bus_crs_vendor_id() rather than
> the hard coded magic value.
> 
> Replace the magic value in pci_bus_crs_vendor_id() with
> PCI_VENDOR_ID_PCI_SIG.
 
This sentence is plenty; no attribution or link needed.  I appreciate
the acknowledgement, but replacing a magic value isn't a better idea
simply because *I* suggested it ;)

> [1] https://lore.kernel.org/linux-cxl/20211117215044.GA1777828@bhelgaas/
> 
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/probe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 087d3658f75c..d92dbb136fc9 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2318,7 +2318,7 @@ EXPORT_SYMBOL(pci_alloc_dev);
>  
>  static bool pci_bus_crs_vendor_id(u32 l)
>  {
> -	return (l & 0xffff) == 0x0001;
> +	return (l & 0xffff) == PCI_VENDOR_ID_PCI_SIG;
>  }
>  
>  static bool pci_bus_wait_crs(struct pci_bus *bus, int devfn, u32 *l,
> -- 
> 2.31.1
> 
