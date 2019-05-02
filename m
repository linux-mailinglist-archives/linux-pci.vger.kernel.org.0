Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9D5113A8
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2019 09:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbfEBHG4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 May 2019 03:06:56 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:16162 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbfEBHGz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 May 2019 03:06:55 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cca970b0000>; Thu, 02 May 2019 00:06:51 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 02 May 2019 00:06:54 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 02 May 2019 00:06:54 -0700
Received: from [10.24.47.93] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 2 May
 2019 07:06:51 +0000
Subject: Re: [PATCH V3 1/2] PCI: dwc: Add API support to de-initialize host
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <Jisheng.Zhang@synaptics.com>, <thierry.reding@gmail.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20190423044920.19663-1-vidyas@nvidia.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <c9084c70-b580-c57f-3f66-f177c819b5fe@nvidia.com>
Date:   Thu, 2 May 2019 12:36:48 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190423044920.19663-1-vidyas@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1556780811; bh=Y4uh7oT7MGNrJWRfdMXdHKz9a+ZKr/tTqay8PTJ3L5Y=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=kMYW9NwpaE0lz79Ugz/dKDLEmutK+jjh5For9f7Ns/CJ+D5bufn8yGnWf19Bej9Mx
         Hg3p56ZrDAHWJeHVRCQy3m1F9CvRLtLY++1RBYqwzfEf1K8yZhWaMs72JK3a924dT5
         QRoSWaNKKCeataHhz2Ddr2qV9NH8bs6X/ilHfCygmv7ywvgUMfeqWR82tZb2odM2o7
         o3+2LThDJea+mn5QeRxL/pJ2hi92jDBqgI4DAdjW9BRk6hGU3Ws8TbGnBlcXaez2TD
         NqEDBhAFWzVGf6Cvu0r2T+OvLWp0CczV4FqErLDZXPjSWM8aB0Dyt1mhEhMjqVfT/M
         BNexZUFqHLYrw==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/23/2019 10:19 AM, Vidya Sagar wrote:
> Add an API to group all the tasks to be done to de-initialize host which
> can then be called by any DesignWare core based driver implementations
> while adding .remove() support in their respective drivers.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
> v3:
> * Rebased on top of linux-next top of the tree branch
> 
> v2:
> * s/Designware/DesignWare
> 
>   drivers/pci/controller/dwc/pcie-designware-host.c | 7 +++++++
>   drivers/pci/controller/dwc/pcie-designware.h      | 5 +++++
>   2 files changed, 12 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 77db32529319..f87c9542eb09 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -496,6 +496,13 @@ int dw_pcie_host_init(struct pcie_port *pp)
>   	return ret;
>   }
>   
> +void dw_pcie_host_deinit(struct pcie_port *pp)
> +{
> +	pci_stop_root_bus(pp->root_bus);
> +	pci_remove_root_bus(pp->root_bus);
> +	dw_pcie_free_msi(pp);
> +}
> +
>   static int dw_pcie_access_other_conf(struct pcie_port *pp, struct pci_bus *bus,
>   				     u32 devfn, int where, int size, u32 *val,
>   				     bool write)
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index deab426affd3..4f48ec78c7b9 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -348,6 +348,7 @@ void dw_pcie_msi_init(struct pcie_port *pp);
>   void dw_pcie_free_msi(struct pcie_port *pp);
>   void dw_pcie_setup_rc(struct pcie_port *pp);
>   int dw_pcie_host_init(struct pcie_port *pp);
> +void dw_pcie_host_deinit(struct pcie_port *pp);
>   int dw_pcie_allocate_domains(struct pcie_port *pp);
>   #else
>   static inline irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
> @@ -372,6 +373,10 @@ static inline int dw_pcie_host_init(struct pcie_port *pp)
>   	return 0;
>   }
>   
> +static inline void dw_pcie_host_deinit(struct pcie_port *pp)
> +{
> +}
> +
>   static inline int dw_pcie_allocate_domains(struct pcie_port *pp)
>   {
>   	return 0;
> 

Hi Lorenzo,
Can you please review this patch series?

Thanks,
Vidya Sagar
