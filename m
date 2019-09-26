Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB55ABED8E
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2019 10:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfIZIj2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Sep 2019 04:39:28 -0400
Received: from foss.arm.com ([217.140.110.172]:42332 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726925AbfIZIj2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 26 Sep 2019 04:39:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC6B51576;
        Thu, 26 Sep 2019 01:39:27 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4BBBE3F836;
        Thu, 26 Sep 2019 01:39:27 -0700 (PDT)
Date:   Thu, 26 Sep 2019 09:39:25 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 08/11] PCI: v3-semi: Use inbound resources for setup
Message-ID: <20190926083925.GX9720@e119886-lin.cambridge.arm.com>
References: <20190924214630.12817-1-robh@kernel.org>
 <20190924214630.12817-9-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924214630.12817-9-robh@kernel.org>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 24, 2019 at 04:46:27PM -0500, Rob Herring wrote:
> Now that the helpers provide the inbound resources in the host bridge
> 'dma_ranges' resource list, convert the v3-semi host bridge to use
> the resource list to setup the inbound addresses.
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Andrew Murray <andrew.murray@arm.com>

> ---
>  drivers/pci/controller/pci-v3-semi.c | 38 ++++++++++++----------------
>  1 file changed, 16 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-v3-semi.c b/drivers/pci/controller/pci-v3-semi.c
> index 090df766faf9..122b695da591 100644
> --- a/drivers/pci/controller/pci-v3-semi.c
> +++ b/drivers/pci/controller/pci-v3-semi.c
> @@ -613,28 +613,30 @@ static int v3_pci_setup_resource(struct v3_pci *v3,
>  }
>  
>  static int v3_get_dma_range_config(struct v3_pci *v3,
> -				   struct of_pci_range *range,
> +				   struct resource_entry *entry,
>  				   u32 *pci_base, u32 *pci_map)
>  {
>  	struct device *dev = v3->dev;
> -	u64 cpu_end = range->cpu_addr + range->size - 1;
> -	u64 pci_end = range->pci_addr + range->size - 1;
> +	u64 cpu_addr = entry->res->start;
> +	u64 cpu_end = entry->res->end;
> +	u64 pci_end = cpu_end - entry->offset;
> +	u64 pci_addr = entry->res->start - entry->offset;
>  	u32 val;
>  
> -	if (range->pci_addr & ~V3_PCI_BASE_M_ADR_BASE) {
> +	if (pci_addr & ~V3_PCI_BASE_M_ADR_BASE) {
>  		dev_err(dev, "illegal range, only PCI bits 31..20 allowed\n");
>  		return -EINVAL;
>  	}
> -	val = ((u32)range->pci_addr) & V3_PCI_BASE_M_ADR_BASE;
> +	val = ((u32)pci_addr) & V3_PCI_BASE_M_ADR_BASE;
>  	*pci_base = val;
>  
> -	if (range->cpu_addr & ~V3_PCI_MAP_M_MAP_ADR) {
> +	if (cpu_addr & ~V3_PCI_MAP_M_MAP_ADR) {
>  		dev_err(dev, "illegal range, only CPU bits 31..20 allowed\n");
>  		return -EINVAL;
>  	}
> -	val = ((u32)range->cpu_addr) & V3_PCI_MAP_M_MAP_ADR;
> +	val = ((u32)cpu_addr) & V3_PCI_MAP_M_MAP_ADR;
>  
> -	switch (range->size) {
> +	switch (resource_size(entry->res)) {
>  	case SZ_1M:
>  		val |= V3_LB_BASE_ADR_SIZE_1MB;
>  		break;
> @@ -682,8 +684,8 @@ static int v3_get_dma_range_config(struct v3_pci *v3,
>  	dev_dbg(dev,
>  		"DMA MEM CPU: 0x%016llx -> 0x%016llx => "
>  		"PCI: 0x%016llx -> 0x%016llx base %08x map %08x\n",
> -		range->cpu_addr, cpu_end,
> -		range->pci_addr, pci_end,
> +		cpu_addr, cpu_end,
> +		pci_addr, pci_end,
>  		*pci_base, *pci_map);
>  
>  	return 0;
> @@ -692,24 +694,16 @@ static int v3_get_dma_range_config(struct v3_pci *v3,
>  static int v3_pci_parse_map_dma_ranges(struct v3_pci *v3,
>  				       struct device_node *np)
>  {
> -	struct of_pci_range range;
> -	struct of_pci_range_parser parser;
> +	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(v3);
>  	struct device *dev = v3->dev;
> +	struct resource_entry *entry;
>  	int i = 0;
>  
> -	if (of_pci_dma_range_parser_init(&parser, np)) {
> -		dev_err(dev, "missing dma-ranges property\n");
> -		return -EINVAL;
> -	}
> -
> -	/*
> -	 * Get the dma-ranges from the device tree
> -	 */
> -	for_each_of_pci_range(&parser, &range) {
> +	resource_list_for_each_entry(entry, &bridge->dma_ranges) {
>  		int ret;
>  		u32 pci_base, pci_map;
>  
> -		ret = v3_get_dma_range_config(v3, &range, &pci_base, &pci_map);
> +		ret = v3_get_dma_range_config(v3, entry, &pci_base, &pci_map);
>  		if (ret)
>  			return ret;
>  
> -- 
> 2.20.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
