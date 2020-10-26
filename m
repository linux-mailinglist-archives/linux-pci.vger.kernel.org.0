Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF39F2992E5
	for <lists+linux-pci@lfdr.de>; Mon, 26 Oct 2020 17:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1781082AbgJZQuT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Oct 2020 12:50:19 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:19934 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1786410AbgJZQtr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Oct 2020 12:49:47 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f96fe160000>; Mon, 26 Oct 2020 09:49:26 -0700
Received: from [10.40.203.191] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 26 Oct
 2020 16:49:41 +0000
Subject: Re: [PATCH] PCI: dwc: Restore ATU memory resource setup to use last
 entry
To:     Rob Herring <robh@kernel.org>, <linux-pci@vger.kernel.org>
CC:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20201026154852.221483-1-robh@kernel.org>
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <b68c285e-3991-2577-30d5-a5b0bef80752@nvidia.com>
Date:   Mon, 26 Oct 2020 22:19:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201026154852.221483-1-robh@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603730966; bh=uDBlNzPO/ZuD1IM+acD5nCND1MNOtD9WEIdG6TpyGPE=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=OWzDAcJRzgdK9n3PUQgHV7D3N69YsNtaawhFGFuDV+z2HeJP4WfNWRcdVmSNHoGc9
         RxJuaUmSLL5/fcIOylBfvA2uR1zU7qdvcv4BPj0tg/kUBsulNZ7BB2ndMocnR3sHau
         WApx3lgbG0rn7cCME7WIn4+uclMgI1XJpYIBhXEDh2tNPRYMoMkKn3bx46TZWiQvKg
         QfFK/+43AIFsJdsjTg9EWxicb3l3v70XO/B8nuvKY1aw34HyFpwnVA0iqL5niCF4Ag
         7uPu73n/0+HlEZo/DkSrEh0eppKvxuKodsNMOX9H/eFgJbKkQT+1ONvwEHSz9x3WkD
         1LXjeVMAQXHRg==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 10/26/2020 9:18 PM, Rob Herring wrote:
> External email: Use caution opening links or attachments
> 
> 
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
>   drivers/pci/controller/dwc/pcie-designware-host.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 674f32db85ca..44c2a6572199 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -586,8 +586,12 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>           * ATU, so we should not program the ATU here.
>           */
>          if (pp->bridge->child_ops == &dw_child_pcie_ops) {
> -               struct resource_entry *entry =
> -                       resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
> +               struct resource_entry *tmp, *entry = NULL;
> +
> +               /* Get last memory resource entry */
> +               resource_list_for_each_entry(tmp, &pp->bridge->windows)
> +                       if (resource_type(tmp->res) == IORESOURCE_MEM)
> +                               entry = tmp;
This patch works for Tegra194 with its 'ranges' property in its current 
shape. But, this still doesn't work if ATU mapping needs to be set for 
both prefetchable and non-prefetchable regions. The series I pushed at 
http://patchwork.ozlabs.org/project/linux-pci/list/?series=209764 works 
for this condition as well.
When it comes to configuring the ATU to handle multiple memory apertures 
(which is the ultimate goal), I think we need to understand the side 
effects of removing I/O mapping in platforms where the number of view 
ports available are not enough to have I/O mapping.

> 
>                  dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX0,
>                                            PCIE_ATU_TYPE_MEM, entry->res->start,
> --
> 2.25.1
> 
