Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52AEE29224C
	for <lists+linux-pci@lfdr.de>; Mon, 19 Oct 2020 07:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbgJSFwJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Oct 2020 01:52:09 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:4169 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgJSFwI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Oct 2020 01:52:08 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f8d292c0003>; Sun, 18 Oct 2020 22:50:36 -0700
Received: from [10.25.74.150] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 19 Oct
 2020 05:51:59 +0000
Subject: Re: [PATCH] PCI: dwc: Use ATU regions to map memory regions
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <amurray@thegoodpenguin.co.uk>, <robh@kernel.org>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20201005121351.32516-1-vidyas@nvidia.com>
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <e633d496-0c4b-f6f5-00a9-c98fb3ed9f61@nvidia.com>
Date:   Mon, 19 Oct 2020 11:21:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <20201005121351.32516-1-vidyas@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603086636; bh=BOi9WCfxZ4k5McRgjNtAT6GoHI8CxT1IMJrjpSGkH78=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=MAfYThzARHDtLyT+Dst+jC0qD99exLsoxfwMwul1I8hRGyjRmRyAGcOT38wszlRvx
         elAQwLPnc/ZLk6mpaQtLmB1Y1yr6nwWd7XHqJtsbseO4UJM91gx7viEpeHlVhVoNWD
         3x3JkBh+VXPreEKm6Fez2psXyL5ZpFYShbpGwmCv6IBalvohGJKwCp518fSj7q9nlF
         TyNtCaL21DPXiZB8iI2uL1hGk8xyocjpbx12hLh6AqR+NYqmMVYarh+JIMoM/R0b44
         B0hPHv21wbdH/fpFz5DSbiWF4lCaC/xZtQ87QeIsY1ifjJie7cUSAMIUmEPfwk/1zj
         MLPq85mvUPUPA==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo, Rob, Gustavo,
Could you please review this change?

Thanks,
Vidya Sagar

On 10/5/2020 5:43 PM, Vidya Sagar wrote:
> Use ATU region-3 and region-0 to setup mapping for prefetchable and
> non-prefetchable memory regions respectively only if their respective CPU
> and bus addresses are different.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
>   .../pci/controller/dwc/pcie-designware-host.c | 44 ++++++++++++++++---
>   drivers/pci/controller/dwc/pcie-designware.c  | 12 ++---
>   drivers/pci/controller/dwc/pcie-designware.h  |  4 +-
>   3 files changed, 48 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 317ff512f8df..cefde8e813e9 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -515,9 +515,40 @@ static struct pci_ops dw_pcie_ops = {
>   	.write = pci_generic_config_write,
>   };
>   
> +static void dw_pcie_setup_mem_atu(struct pcie_port *pp,
> +				  struct resource_entry *win)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +
> +	if (win->res->flags & IORESOURCE_PREFETCH && pci->num_viewport >= 4 &&
> +	    win->offset) {
> +		dw_pcie_prog_outbound_atu(pci,
> +					  PCIE_ATU_REGION_INDEX3,
> +					  PCIE_ATU_TYPE_MEM,
> +					  win->res->start,
> +					  win->res->start - win->offset,
> +					  resource_size(win->res));
> +	} else if (win->res->flags & IORESOURCE_PREFETCH &&
> +		   pci->num_viewport < 4) {
> +		dev_warn(pci->dev,
> +			 "Insufficient ATU regions to map Prefetchable memory\n");
> +	} else if (win->offset) {
> +		if (upper_32_bits(resource_size(win->res)))
> +			dev_warn(pci->dev,
> +				 "Memory resource size exceeds max for 32 bits\n");
> +		dw_pcie_prog_outbound_atu(pci,
> +					  PCIE_ATU_REGION_INDEX0,
> +					  PCIE_ATU_TYPE_MEM,
> +					  win->res->start,
> +					  win->res->start - win->offset,
> +					  resource_size(win->res));
> +	}
> +}
> +
>   void dw_pcie_setup_rc(struct pcie_port *pp)
>   {
>   	u32 val, ctrl, num_ctrls;
> +	struct resource_entry *win;
>   	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>   
>   	/*
> @@ -572,13 +603,14 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>   	 * ATU, so we should not program the ATU here.
>   	 */
>   	if (pp->bridge->child_ops == &dw_child_pcie_ops) {
> -		struct resource_entry *entry =
> -			resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
> +		resource_list_for_each_entry(win, &pp->bridge->windows) {
> +			switch (resource_type(win->res)) {
> +			case IORESOURCE_MEM:
> +				dw_pcie_setup_mem_atu(pp, win);
> +				break;
> +			}
> +		}
>   
> -		dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX0,
> -					  PCIE_ATU_TYPE_MEM, entry->res->start,
> -					  entry->res->start - entry->offset,
> -					  resource_size(entry->res));
>   		if (pci->num_viewport > 2)
>   			dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX2,
>   						  PCIE_ATU_TYPE_IO, pp->io_base,
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 3c1f17c78241..6033689abb15 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -227,7 +227,7 @@ static void dw_pcie_writel_ob_unroll(struct dw_pcie *pci, u32 index, u32 reg,
>   static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, u8 func_no,
>   					     int index, int type,
>   					     u64 cpu_addr, u64 pci_addr,
> -					     u32 size)
> +					     u64 size)
>   {
>   	u32 retries, val;
>   	u64 limit_addr = cpu_addr + size - 1;
> @@ -244,8 +244,10 @@ static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, u8 func_no,
>   				 lower_32_bits(pci_addr));
>   	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_UPPER_TARGET,
>   				 upper_32_bits(pci_addr));
> -	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1,
> -				 type | PCIE_ATU_FUNC_NUM(func_no));
> +	val = type | PCIE_ATU_FUNC_NUM(func_no);
> +	val = upper_32_bits(size - 1) ?
> +		val | PCIE_ATU_INCREASE_REGION_SIZE : val;
> +	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1, val);
>   	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL2,
>   				 PCIE_ATU_ENABLE);
>   
> @@ -266,7 +268,7 @@ static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, u8 func_no,
>   
>   static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
>   					int index, int type, u64 cpu_addr,
> -					u64 pci_addr, u32 size)
> +					u64 pci_addr, u64 size)
>   {
>   	u32 retries, val;
>   
> @@ -310,7 +312,7 @@ static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
>   }
>   
>   void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
> -			       u64 cpu_addr, u64 pci_addr, u32 size)
> +			       u64 cpu_addr, u64 pci_addr, u64 size)
>   {
>   	__dw_pcie_prog_outbound_atu(pci, 0, index, type,
>   				    cpu_addr, pci_addr, size);
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 97c7063b9e89..b81a1813cf9e 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -80,10 +80,12 @@
>   #define PCIE_ATU_VIEWPORT		0x900
>   #define PCIE_ATU_REGION_INBOUND		BIT(31)
>   #define PCIE_ATU_REGION_OUTBOUND	0
> +#define PCIE_ATU_REGION_INDEX3		0x3
>   #define PCIE_ATU_REGION_INDEX2		0x2
>   #define PCIE_ATU_REGION_INDEX1		0x1
>   #define PCIE_ATU_REGION_INDEX0		0x0
>   #define PCIE_ATU_CR1			0x904
> +#define PCIE_ATU_INCREASE_REGION_SIZE	BIT(13)
>   #define PCIE_ATU_TYPE_MEM		0x0
>   #define PCIE_ATU_TYPE_IO		0x2
>   #define PCIE_ATU_TYPE_CFG0		0x4
> @@ -295,7 +297,7 @@ void dw_pcie_upconfig_setup(struct dw_pcie *pci);
>   int dw_pcie_wait_for_link(struct dw_pcie *pci);
>   void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index,
>   			       int type, u64 cpu_addr, u64 pci_addr,
> -			       u32 size);
> +			       u64 size);
>   void dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int index,
>   				  int type, u64 cpu_addr, u64 pci_addr,
>   				  u32 size);
> 
