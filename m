Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C662A5025
	for <lists+linux-pci@lfdr.de>; Tue,  3 Nov 2020 20:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgKCTaF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Nov 2020 14:30:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:59408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbgKCTaF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Nov 2020 14:30:05 -0500
Received: from localhost (230.sub-72-107-127.myvzw.com [72.107.127.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AF5C20780;
        Tue,  3 Nov 2020 19:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604431804;
        bh=grK2q6oiVGZaixKgcppxuMLeWglZ3sIF8r9InnQHp2s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Snof0ZVlx721zv5dXxRe1TvaTZOV0s/frGBRV0qsUNRZETFfd0RjatkIEq6M0h7HD
         LxBq/cxLq2MmPkWnlQsnjqUPlThZSyPQULddiSR2qZH/1KsZtRBAX3Jv/qx5nYuf7i
         jFItiquI/DAnTdynpySXl9d3KWQM2xCvI0WzduTQ=
Date:   Tue, 3 Nov 2020 13:30:02 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-pci@vger.kernel.org, Vidya Sagar <vidyas@nvidia.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: dwc: Restore ATU memory resource setup to use last
 entry
Message-ID: <20201103193002.GA258037@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026154852.221483-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 26, 2020 at 10:48:52AM -0500, Rob Herring wrote:
> Prior to commit 0f71c60ffd26 ("PCI: dwc: Remove storing of PCI
> resources"), the DWC driver was setting up the last memory resource
> rather than the first memory resource. This doesn't matter for most
> platforms which only have 1 memory resource, but it broke Tegra194 which
> has a 2nd (prefetchable) memory region which requires an ATU entry. The
> first region on Tegra194 relies on the default 1:1 pass-thru of outbound
> transactions which doesn't need an ATU entry.
> 
> Fixes: 0f71c60ffd26 ("PCI: dwc: Remove storing of PCI resources")
> Reported-by: Vidya Sagar <vidyas@nvidia.com>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied with acks from Lorenzo and Jingoo to for-linus for v5.10,
thanks!

> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 674f32db85ca..44c2a6572199 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -586,8 +586,12 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>  	 * ATU, so we should not program the ATU here.
>  	 */
>  	if (pp->bridge->child_ops == &dw_child_pcie_ops) {
> -		struct resource_entry *entry =
> -			resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
> +		struct resource_entry *tmp, *entry = NULL;
> +
> +		/* Get last memory resource entry */
> +		resource_list_for_each_entry(tmp, &pp->bridge->windows)
> +			if (resource_type(tmp->res) == IORESOURCE_MEM)
> +				entry = tmp;
>  
>  		dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX0,
>  					  PCIE_ATU_TYPE_MEM, entry->res->start,
> -- 
> 2.25.1
> 
