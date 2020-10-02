Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 279522811A5
	for <lists+linux-pci@lfdr.de>; Fri,  2 Oct 2020 13:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387833AbgJBLyg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Oct 2020 07:54:36 -0400
Received: from foss.arm.com ([217.140.110.172]:33658 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbgJBLye (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Oct 2020 07:54:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 37C9A1063;
        Fri,  2 Oct 2020 04:54:34 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4FF793F70D;
        Fri,  2 Oct 2020 04:54:33 -0700 (PDT)
Date:   Fri, 2 Oct 2020 12:54:31 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Qinglang Miao <miaoqinglang@huawei.com>
Cc:     Tom Joseph <tjoseph@cadence.com>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] PCI: cadence: simplify the return expression of
 cdns_pcie_host_init_address_translation()
Message-ID: <20201002115430.GC23640@e121166-lin.cambridge.arm.com>
References: <20200921131053.92752-1-miaoqinglang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921131053.92752-1-miaoqinglang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 21, 2020 at 09:10:53PM +0800, Qinglang Miao wrote:
> Simplify the return expression.
> 
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
> ---
>  drivers/pci/controller/cadence/pcie-cadence-host.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)

Applied to pci/cadence, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
> index 4550e0d46..811c1cb2e 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
> @@ -337,7 +337,7 @@ static int cdns_pcie_host_init_address_translation(struct cdns_pcie_rc *rc)
>  	struct resource_entry *entry;
>  	u64 cpu_addr = cfg_res->start;
>  	u32 addr0, addr1, desc1;
> -	int r, err, busnr = 0;
> +	int r, busnr = 0;
>  
>  	entry = resource_list_first_type(&bridge->windows, IORESOURCE_BUS);
>  	if (entry)
> @@ -383,11 +383,7 @@ static int cdns_pcie_host_init_address_translation(struct cdns_pcie_rc *rc)
>  		r++;
>  	}
>  
> -	err = cdns_pcie_host_map_dma_ranges(rc);
> -	if (err)
> -		return err;
> -
> -	return 0;
> +	return cdns_pcie_host_map_dma_ranges(rc);
>  }
>  
>  static int cdns_pcie_host_init(struct device *dev,
> -- 
> 2.23.0
> 
