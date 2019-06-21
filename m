Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB0F4E38D
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2019 11:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbfFUJ2y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jun 2019 05:28:54 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:51264 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbfFUJ2y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jun 2019 05:28:54 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5L9ShGD052119;
        Fri, 21 Jun 2019 04:28:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1561109323;
        bh=hXYs9Tgh/MCqVjZYAsTAfOm1NcAJO5FtGUR6Y+0g89g=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=aVtcCmBwkEqjFApb0qhvUMPAQ1gOgOuAPCn5fDJL+c1VoPsS33HbE/3yF5altuUbA
         9o5lPXnsGGp2jlw5E4oLV/PWIKxX+CuMzUpgYGXdei9H0gALDv7EmTwKux378TV3gu
         0EQ1kmHe3z/YSJEppIqQ6p8Xuk3zNWfRMDLQ4qFU=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5L9Shk1105743
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 21 Jun 2019 04:28:43 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 21
 Jun 2019 04:28:43 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 21 Jun 2019 04:28:43 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5L9SdDc130391;
        Fri, 21 Jun 2019 04:28:40 -0500
Subject: Re: [PATCH V5 2/3] PCI: dwc: Cleanup DBI read and write APIs
To:     Vidya Sagar <vidyas@nvidia.com>, <jingoohan1@gmail.com>,
        <gustavo.pimentel@synopsys.com>, <lorenzo.pieralisi@arm.com>,
        <bhelgaas@google.com>, <Jisheng.Zhang@synaptics.com>,
        <thierry.reding@gmail.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20190621092127.17930-1-vidyas@nvidia.com>
 <20190621092127.17930-2-vidyas@nvidia.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <63b59d6b-f6d7-fe4f-f319-6459a146ef36@ti.com>
Date:   Fri, 21 Jun 2019 14:57:13 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190621092127.17930-2-vidyas@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Vidya,

On 21/06/19 2:51 PM, Vidya Sagar wrote:
> Cleanup DBI read and write APIs by removing "__" (underscore) from their
> names as there are no no-underscore versions and the underscore versions
> are already doing what no-underscore versions typically do.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> Changes from v4:
> * This is a new patch in this series
> 
>  drivers/pci/controller/dwc/pcie-designware.c | 16 ++++-----
>  drivers/pci/controller/dwc/pcie-designware.h | 36 ++++++++++----------
>  2 files changed, 26 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 9d7c51c32b3b..5d22028d854e 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -52,8 +52,8 @@ int dw_pcie_write(void __iomem *addr, int size, u32 val)
>  	return PCIBIOS_SUCCESSFUL;
>  }
>  
> -u32 __dw_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg,
> -		       size_t size)
> +u32 dw_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg,
> +		     size_t size)

The "base" here was added when we used the same API for both dbi_base and
dbi_base2. Now that we have separate APIs, we should be able to remove that.

Thanks
Kishon
