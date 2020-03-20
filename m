Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F235C18C9F6
	for <lists+linux-pci@lfdr.de>; Fri, 20 Mar 2020 10:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbgCTJPz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Mar 2020 05:15:55 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:17961 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbgCTJPz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Mar 2020 05:15:55 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e7489670000>; Fri, 20 Mar 2020 02:14:15 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 20 Mar 2020 02:15:54 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 20 Mar 2020 02:15:54 -0700
Received: from [10.25.97.155] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 20 Mar
 2020 09:15:51 +0000
Subject: Re: [PATCH v2] PCI: dwc: fix compile err for pcie-tagra194
To:     Qiujun Huang <hqjagain@gmail.com>, <lorenzo.pieralisi@arm.com>,
        <anders.roxell@linaro.org>
CC:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <amurray@thegoodpenguin.co.uk>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1584685490-8170-1-git-send-email-hqjagain@gmail.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <b9791f44-b257-3851-fd0c-144fad8e7719@nvidia.com>
Date:   Fri, 20 Mar 2020 14:45:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1584685490-8170-1-git-send-email-hqjagain@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1584695656; bh=5eYk6uqs0lsFxlwS2aeBD3ttXxo/cyziEWdyNA3Zmbk=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=foZhgYpDgKgAotJH952my+MWzCFEQFq9VG+lYZ8kr6KQ68qDM3aZWGUvNledik8uf
         xJv1z7AgeOpZQCKKtCfgNh0bsdMw8/zEZzRL2ln041aBe1wuD3+8NuWWsnD5bdouxB
         ZpVfjhPrLVT/zOLJHq0D1JFhqEvr2gAM4taCyb5Rng89N4nS3eZS/VFC+B5KkowrD9
         94+Dd9Xb886OUwW7mDiBlPNPFLS/xvvBH8/sikNjXR5UskF0V1Vn6/NVctsUJKaMrx
         sO8RQM2t7ObbT+pF/vbe0F06gibe0Fw4DTfNxPl+pZzSArj2BA18jzbcW6IsP+Q19j
         EA/qdJaQVDExw==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 3/20/2020 11:54 AM, Qiujun Huang wrote:
> External email: Use caution opening links or attachments
> 
> 
> make allmodconfig
> ERROR: modpost: "dw_pcie_ep_init" [drivers/pci/controller/dwc/pcie-tegra194.ko] undefined!
> ERROR: modpost: "dw_pcie_ep_init_notify" [drivers/pci/controller/dwc/pcie-tegra194.ko] undefined!
> ERROR: modpost: "dw_pcie_ep_init_complete" [drivers/pci/controller/dwc/pcie-tegra194.ko] undefined!
> ERROR: modpost: "dw_pcie_ep_linkup" [drivers/pci/controller/dwc/pcie-tegra194.ko] undefined!
> make[2]: *** [__modpost] Error 1
> make[1]: *** [modules] Error 2
> make: *** [sub-make] Error 2
> 
> need to export the symbols.
> 
> Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
> ---
>   drivers/pci/controller/dwc/pcie-designware-ep.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 4233c43..1cdcbd1 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -18,6 +18,7 @@ void dw_pcie_ep_linkup(struct dw_pcie_ep *ep)
> 
>          pci_epc_linkup(epc);
>   }
> +EXPORT_SYMBOL_GPL(dw_pcie_ep_linkup);
> 
>   void dw_pcie_ep_init_notify(struct dw_pcie_ep *ep)
>   {
> @@ -25,6 +26,7 @@ void dw_pcie_ep_init_notify(struct dw_pcie_ep *ep)
> 
>          pci_epc_init_notify(epc);
>   }
> +EXPORT_SYMBOL_GPL(dw_pcie_ep_init_notify);
> 
>   static void __dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar,
>                                     int flags)
> @@ -535,6 +537,7 @@ int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
> 
>          return 0;
>   }
> +EXPORT_SYMBOL_GPL(dw_pcie_ep_init_complete);
> 
>   int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>   {
> @@ -629,3 +632,4 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> 
>          return dw_pcie_ep_init_complete(ep);
>   }
> +EXPORT_SYMBOL_GPL(dw_pcie_ep_init);
> --
> 1.8.3.1
> 

Thanks for the change Qiujun.
Reviewed-by: Vidya Sagar <vidyas@nvidia.com>
Tested-by: Vidya Sagar <vidyas@nvidia.com>
