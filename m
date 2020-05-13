Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7C8E1D2214
	for <lists+linux-pci@lfdr.de>; Thu, 14 May 2020 00:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbgEMWfL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 May 2020 18:35:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:55942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726061AbgEMWfL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 May 2020 18:35:11 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94BB620575;
        Wed, 13 May 2020 22:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589409310;
        bh=mrbPmsNhBtoUUBd48De5ocAkqUWjAVb9HrbYpjWkuQs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bXxoE/ZNaO3xLoNSqvNYdspXoGxfFkbOImgKMZXdbhSXUnENKB9Re9cP2PvYr0OKc
         iUPZ7fMGpRqcBo1eHmtHpVJ+HC2CLKIJzyC+eOhFW04NqoUP0+pwQem/38+fcA8ho4
         wcMOdozFNcz85a1IPi2/BS+texWlCMPhWOeWI5bs=
Date:   Wed, 13 May 2020 17:35:08 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lorenzo.pieralisi@arm.com,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        bhelgaas@google.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com,
        Alan Mikhak <alan.mikhak@sifive.com>
Subject: Re: [PATCH] PCI: dwc: Warn only for non-prefetchable memory resource
 size >4GB
Message-ID: <20200513223508.GA352288@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513190855.23318-1-vidyas@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Alan; please cc authors of relevant commits,
updated Andrew's email address]

On Thu, May 14, 2020 at 12:38:55AM +0530, Vidya Sagar wrote:
> commit 9e73fa02aa009 ("PCI: dwc: Warn if MEM resource size exceeds max for
> 32-bits") enables warning for MEM resources of size >4GB but prefetchable
>  memory resources also come under this category where sizes can go beyond
> 4GB. Avoid logging a warning for prefetchable memory resources.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 42fbfe2a1b8f..a29396529ea4 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -366,7 +366,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  			pp->mem = win->res;
>  			pp->mem->name = "MEM";
>  			mem_size = resource_size(pp->mem);
> -			if (upper_32_bits(mem_size))
> +			if (upper_32_bits(mem_size) &&
> +			    !(win->res->flags & IORESOURCE_PREFETCH))
>  				dev_warn(dev, "MEM resource size exceeds max for 32 bits\n");
>  			pp->mem_size = mem_size;
>  			pp->mem_bus_addr = pp->mem->start - win->offset;
> -- 
> 2.17.1
> 
