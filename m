Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9329C9C4CF
	for <lists+linux-pci@lfdr.de>; Sun, 25 Aug 2019 18:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbfHYQNe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 25 Aug 2019 12:13:34 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:17679 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbfHYQNe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 25 Aug 2019 12:13:34 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d62b3ad0004>; Sun, 25 Aug 2019 09:13:33 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Sun, 25 Aug 2019 09:13:33 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Sun, 25 Aug 2019 09:13:33 -0700
Received: from [10.2.164.53] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 25 Aug
 2019 15:26:23 +0000
Subject: Re: [PATCH] PCI: dwc: Use dev_info() instead of dev_err()
To:     Vidya Sagar <vidyas@nvidia.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <thierry.reding@gmail.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20190823151618.13904-1-vidyas@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <ef770fde-ea5b-9553-fce3-cf4f3a5bf841@nvidia.com>
Date:   Sun, 25 Aug 2019 16:26:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190823151618.13904-1-vidyas@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1566749613; bh=oXMiuQnz2h7Emz7FPC/+hKXfzblmBf7gymRe8lDqJYs=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=NC9TBOrrd1ITpVXqnv3EP1yE7NCKQrwYil5CMRqyc92JbGDCgHxF33X5rEcHUZ+9K
         sqxn3uOCF/XNLyGVOCqyOGpgTZ3J06oX0x0vuhFpPCFjmeXNuQN8OF+PIt66hHIz9s
         wHIa5sj4TS0tYGSSIBIqQnTAjW+JdvJLEvQWIRZqMiV19aZ1SR2/XLqD+qDAq6pfO1
         /Lf0E2AQrY59RFSRRX6csYV0hlz9PJOjb5k8bJtiT8qlNI0HrQ/FEoedrtyfyUZsxa
         4F8Ekj+jRW4O7kH5aS/jRgqh4Vvb1GfsPx7pOuhzLmaW7T1y374eWp00fAG87Mv1Bl
         SOHQuDWplOVQg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 23/08/2019 16:16, Vidya Sagar wrote:
> When a platform has an open PCIe slot, not having a device connected to
> it doesn't have to result in a dev_err() print saying that the link is
> not up but a dev_info() would suffice.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 59eaeeb21dbe..4d6690b6ca36 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -456,7 +456,7 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
>  		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
>  	}
>  
> -	dev_err(pci->dev, "Phy link never came up\n");
> +	dev_info(pci->dev, "Phy link never came up\n");

IMO this message is not very descriptive. Why not just say 'no device
connected'? From the changelog it is clear what this means but the
message itself could be clearer. Or should it even be a dev_dbg?

Cheers
Jon

-- 
nvpublic
