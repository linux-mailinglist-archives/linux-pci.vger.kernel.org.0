Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49FF32A4B43
	for <lists+linux-pci@lfdr.de>; Tue,  3 Nov 2020 17:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbgKCQY5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Nov 2020 11:24:57 -0500
Received: from foss.arm.com ([217.140.110.172]:51642 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728508AbgKCQY5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Nov 2020 11:24:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B3A8139F;
        Tue,  3 Nov 2020 08:24:56 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 66EB63F66E;
        Tue,  3 Nov 2020 08:24:55 -0800 (PST)
Date:   Tue, 3 Nov 2020 16:24:41 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, Vidya Sagar <vidyas@nvidia.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: Re: [PATCH] PCI: dwc: Restore ATU memory resource setup to use last
 entry
Message-ID: <20201103162441.GA2415@e121166-lin.cambridge.arm.com>
References: <20201026154852.221483-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026154852.221483-1-robh@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Bjorn, this is v5.10 material please pick it up for one of the
upcoming -rc*:

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

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
