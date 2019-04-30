Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66B46F417
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2019 12:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfD3KTx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Apr 2019 06:19:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42712 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbfD3KTx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Apr 2019 06:19:53 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 678E185360;
        Tue, 30 Apr 2019 10:19:52 +0000 (UTC)
Received: from [10.36.116.17] (ovpn-116-17.ams2.redhat.com [10.36.116.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A57386152B;
        Tue, 30 Apr 2019 10:19:48 +0000 (UTC)
Subject: Re: [PATCH v4 3/3] PCI: iproc: Add sorted dma ranges resource entries
 to host bridge
To:     Srinath Mannam <srinath.mannam@broadcom.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        poza@codeaurora.org, Ray Jui <rjui@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <1555038815-31916-1-git-send-email-srinath.mannam@broadcom.com>
 <1555038815-31916-4-git-send-email-srinath.mannam@broadcom.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <53a7463f-0b31-42ad-96a1-a3f40f02b119@redhat.com>
Date:   Tue, 30 Apr 2019 12:19:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1555038815-31916-4-git-send-email-srinath.mannam@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Tue, 30 Apr 2019 10:19:52 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Srinath,

On 4/12/19 5:13 AM, Srinath Mannam wrote:
> IPROC host has the limitation that it can use only those address ranges
> given by dma-ranges property as inbound address. So that the memory
> address holes in dma-ranges should be reserved to allocate as DMA address.
> 
> Inbound address of host accessed by PCIe devices will not be translated
> before it comes to IOMMU or directly to PE. But the limitation of this
> host is, access to few address ranges are ignored. So that IOVA ranges
> for these address ranges have to be reserved.
> 
> All allowed address ranges are listed in dma-ranges DT parameter. These
> address ranges are converted as resource entries and listed in sorted
> order add added to dma_ranges list of PCI host bridge structure.
s/add added/and added
> 
> Ex:
> dma-ranges = < \
>   0x43000000 0x00 0x80000000 0x00 0x80000000 0x00 0x80000000 \
>   0x43000000 0x08 0x00000000 0x08 0x00000000 0x08 0x00000000 \
>   0x43000000 0x80 0x00000000 0x80 0x00000000 0x40 0x00000000>
> 
> In the above example of dma-ranges, memory address from
> 0x0 - 0x80000000,
> 0x100000000 - 0x800000000,
> 0x1000000000 - 0x8000000000 and
> 0x10000000000 - 0xffffffffffffffff.
> are not allowed to use as inbound addresses.
s/to use/to be used
> 
> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> Based-on-patch-by: Oza Pawandeep <oza.oza@broadcom.com>
> Reviewed-by: Oza Pawandeep <poza@codeaurora.org>


> ---
>  drivers/pci/controller/pcie-iproc.c | 44 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 43 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
> index c20fd6b..94ba5c0 100644
> --- a/drivers/pci/controller/pcie-iproc.c
> +++ b/drivers/pci/controller/pcie-iproc.c
> @@ -1146,11 +1146,43 @@ static int iproc_pcie_setup_ib(struct iproc_pcie *pcie,
>  	return ret;
>  }
>  
> +static int
> +iproc_pcie_add_dma_range(struct device *dev, struct list_head *resources,
> +			 struct of_pci_range *range)
> +{
> +	struct resource *res;
> +	struct resource_entry *entry, *tmp;
> +	struct list_head *head = resources;
> +
> +	res = devm_kzalloc(dev, sizeof(struct resource), GFP_KERNEL);
> +	if (!res)
> +		return -ENOMEM;
> +
> +	resource_list_for_each_entry(tmp, resources) {
> +		if (tmp->res->start < range->cpu_addr)
> +			head = &tmp->node;
> +	}
> +
> +	res->start = range->cpu_addr;
> +	res->end = res->start + range->size - 1;
> +
> +	entry = resource_list_create_entry(res, 0);
> +	if (!entry)
> +		return -ENOMEM;
> +
> +	entry->offset = res->start - range->cpu_addr;
> +	resource_list_add(entry, head);
> +
> +	return 0;
> +}
> +
>  static int iproc_pcie_map_dma_ranges(struct iproc_pcie *pcie)
>  {
> +	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
>  	struct of_pci_range range;
>  	struct of_pci_range_parser parser;
>  	int ret;
> +	LIST_HEAD(resources);
>  
>  	/* Get the dma-ranges from DT */
>  	ret = of_pci_dma_range_parser_init(&parser, pcie->dev->of_node);
> @@ -1158,13 +1190,23 @@ static int iproc_pcie_map_dma_ranges(struct iproc_pcie *pcie)
>  		return ret;
>  
>  	for_each_of_pci_range(&parser, &range) {
> +		ret = iproc_pcie_add_dma_range(pcie->dev,
> +					       &resources,
> +					       &range);
> +		if (ret)
> +			goto out;
>  		/* Each range entry corresponds to an inbound mapping region */
>  		ret = iproc_pcie_setup_ib(pcie, &range, IPROC_PCIE_IB_MAP_MEM);
>  		if (ret)
> -			return ret;
> +			goto out;
>  	}
>  
> +	list_splice_init(&resources, &host->dma_ranges);
> +
>  	return 0;
> +out:
> +	pci_free_resource_list(&resources);
> +	return ret;
>  }
>  
>  static int iproce_pcie_get_msi(struct iproc_pcie *pcie,
> 
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
