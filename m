Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0102CCE36
	for <lists+linux-pci@lfdr.de>; Thu,  3 Dec 2020 06:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgLCFDb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Dec 2020 00:03:31 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:1064 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbgLCFDb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Dec 2020 00:03:31 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fc8717b0001>; Wed, 02 Dec 2020 21:02:51 -0800
Received: from [10.25.75.116] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 3 Dec
 2020 05:02:41 +0000
Subject: Re: [PATCH] PCI: dwc: Set 32-bit DMA mask for MSI target address
 allocation
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>,
        <sagar.tv@gmail.com>, <treding@nvidia.com>, <jonathanh@nvidia.com>
References: <20201117165312.25847-1-vidyas@nvidia.com>
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <2fa71e3d-3edc-2667-e4f0-1db62b25f7bc@nvidia.com>
Date:   Thu, 3 Dec 2020 10:32:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20201117165312.25847-1-vidyas@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606971771; bh=IBpexQHquDkxvVxlw7AZ4HhXqUc/hX1C6dECYmrKJpM=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=K5RZXJASv2lbf5l9y9GL6cxFpbRbe0kzsk9n7QfW47BBHaW5/Ui5uc0zhL09dKmeS
         zJ7xcwvEdnl8d1jLv1Dl1dAWNr2qLhaOGVCB6ikz/iy0USYqm/mSQTfiBgw+MNUrC2
         bBdJbqyVxeJcEsJGlco+TIZLq9Ngm0vITvHGOgvbiOBlljf3I06XIwfBBlEBFrv7sv
         p/a4YuWkP0dTx5F2gisIsBrfd2onxURMByDFhqbD1kGD3tBFU1HLSMXiRDNJZT0GWZ
         b0i6hmxylzwA7S79jdHn7C1zTXghUl+FP24n6e1c2IswWNzxWoHOFLvPIH1H+MH0Ix
         d+B0kkqz925Rg==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,
Could you please review this patch in the context of the following patch?
http://patchwork.ozlabs.org/project/linux-pci/patch/20201124105035.24573-1-vidyas@nvidia.com/

Thanks,
Vidya Sagar

On 11/17/2020 10:23 PM, Vidya Sagar wrote:
> Set DMA mask to 32-bit while allocating the MSI target address so that
> the address is usable for both 32-bit and 64-bit MSI capable devices.
> Throw a warning if it fails to set the mask to 32-bit to alert that
> devices that are only 32-bit MSI capable may not work properly.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> Given the other patch that I've pushed to the MSI sub-system
> http://patchwork.ozlabs.org/project/linux-pci/patch/20201117145728.4516-1-vidyas@nvidia.com/
> which is going to catch any mismatch between MSI capability (32-bit) of the
> device and system's inability to allocate the required MSI target address,
> I'm not sure how much sense is this patch going to be make. But, I can
> certainly say that if the memory allocation mechanism gives the addresses
> from 64-bit pool by default, this patch at least makes sure that MSI target
> address is allocated from 32-bit pool.
> 
>   drivers/pci/controller/dwc/pcie-designware-host.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 44c2a6572199..e6a230eddf66 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -388,6 +388,14 @@ int dw_pcie_host_init(struct pcie_port *pp)
>   							    dw_chained_msi_isr,
>   							    pp);
>   
> +			ret = dma_set_mask(pci->dev, DMA_BIT_MASK(32));
> +			if (!ret) {
> +				dev_warn(pci->dev,
> +					 "Failed to set DMA mask to 32-bit. "
> +					 "Devices with only 32-bit MSI support"
> +					 " may not work properly\n");
> +			}
> +
>   			pp->msi_data = dma_map_single_attrs(pci->dev, &pp->msi_msg,
>   						      sizeof(pp->msi_msg),
>   						      DMA_FROM_DEVICE,
> 
