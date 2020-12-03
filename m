Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96AB62CD637
	for <lists+linux-pci@lfdr.de>; Thu,  3 Dec 2020 13:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730580AbgLCM5l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Dec 2020 07:57:41 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:16395 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730563AbgLCM5l (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Dec 2020 07:57:41 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fc8e09c0001>; Thu, 03 Dec 2020 04:57:00 -0800
Received: from [10.25.75.116] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 3 Dec
 2020 12:56:50 +0000
Subject: Re: [PATCH V4 2/6] PCI: tegra: Map configuration space as nGnRnE
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "amanharitsh123@gmail.com" <amanharitsh123@gmail.com>,
        "dinghao.liu@zju.edu.cn" <dinghao.liu@zju.edu.cn>,
        "kw@linux.com" <kw@linux.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Krishna Thota <kthota@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        "sagar.tv@gmail.com" <sagar.tv@gmail.com>
References: <20201109171937.28326-1-vidyas@nvidia.com>
 <20201109171937.28326-3-vidyas@nvidia.com> <X7+SmtN+8T4HQb/M@ulmo>
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <c36d8e4b-cdd4-e42e-9424-0a244a3c20c8@nvidia.com>
Date:   Thu, 3 Dec 2020 18:26:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <X7+SmtN+8T4HQb/M@ulmo>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607000220; bh=n6Q1Iq8q+gYcIzMJQwIa1nPLvmmTFkNyl7Hkc2iQziY=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=U0O6Uf4HWJsHuzsN2bV/Dfgn1Q1qYeAYGeT/zWqDXH5Cn37wg0C0XQ0jELSYILpnN
         FU0loNp9T7lKlDPwcrvTsWzHGLL7IJDPz9gVeHOGplPj7jlS75FPWFhMNDHDT21kz3
         fXF22JQgBa2kD3gZSl9GjegNFZj1zGnbhoXWmSPLhnrH90QBGF6jR22T6GN9UGSRG2
         By+8AFmR/HgpHyGuri6Oq5C0JVl8Y1IMWRF1mEQvEbOhvJA1rI+vuvQrrDbQDbLueZ
         eyou36V1ZFOhnLFE1FpoGNYTtRWN6TwmmPMEoEtOdzFmKvjUrGO8N2NSFwVZGXu/oA
         zRUo9+TAFjy6A==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Thierry Reding <thierry.reding@gmail.com>
> Sent: Thursday, November 26, 2020 5:04 PM
> To: Vidya Sagar <vidyas@nvidia.com>
> Cc: lorenzo.pieralisi@arm.com; robh+dt@kernel.org; bhelgaas@google.com;
> Jonathan Hunter <jonathanh@nvidia.com>; amanharitsh123@gmail.com;
> dinghao.liu@zju.edu.cn; kw@linux.com; linux-pci@vger.kernel.org; linux-
> tegra@vger.kernel.org; linux-kernel@vger.kernel.org; Krishna Thota
> <kthota@nvidia.com>; Manikanta Maddireddy <mmaddireddy@nvidia.com>;
> sagar.tv@gmail.com
> Subject: Re: [PATCH V4 2/6] PCI: tegra: Map configuration space as nGnRnE
> 
> On Mon, Nov 09, 2020 at 10:49:33PM +0530, Vidya Sagar wrote:
> > As specified in the comment for pci_remap_cfgspace() define in
> > arch/arm64/include/asm/io.h file, PCIe configuration space should be
> > mapped as nGnRnE. Hence changing to dev_pci_remap_cfgspace() from
> > devm_ioremap_resource() for mapping DBI space as that is nothing but
> > the root port's own configuration space.
> >
> > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > ---
> > V4:
> > * None
> >
> > V3:
> > * None
> >
> > V2:
> > * Changed 'Strongly Ordered' to 'nGnRnE'
> >
> >  drivers/pci/controller/dwc/pcie-tegra194.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c
> > b/drivers/pci/controller/dwc/pcie-tegra194.c
> > index b172b1d49713..7a0c64436861 100644
> > --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> > +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> > @@ -2108,7 +2108,9 @@ static int tegra_pcie_dw_probe(struct
> platform_device *pdev)
> >  	}
> >  	pcie->dbi_res = dbi_res;
> >
> > -	pci->dbi_base = devm_ioremap_resource(dev, dbi_res);
> > +	pci->dbi_base = devm_pci_remap_cfgspace(dev,
> > +						dbi_res->start,
> > +						resource_size(dbi_res));
> >  	if (IS_ERR(pci->dbi_base))
> >  		return PTR_ERR(pci->dbi_base);
> >
> 
> Similarly to patch 1/6, this is no longer required because it's already part of one
> of Rob's earlier patches, so this, too, can be dropped.
Yes. This patch is not required now. I'll drop it from the next patch 
series.

Thanks,
Vidya Sagar
> 
> Thierry
