Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2667F9B392
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2019 17:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394117AbfHWPko (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Aug 2019 11:40:44 -0400
Received: from foss.arm.com ([217.140.110.172]:36472 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394079AbfHWPkn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 23 Aug 2019 11:40:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48BB628;
        Fri, 23 Aug 2019 08:40:43 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E88C93F246;
        Fri, 23 Aug 2019 08:40:41 -0700 (PDT)
Date:   Fri, 23 Aug 2019 16:40:37 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     gustavo.pimentel@synopsys.com, bhelgaas@google.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH] PCI: dwc: Use dev_info() instead of dev_err()
Message-ID: <20190823154037.GA28344@e121166-lin.cambridge.arm.com>
References: <20190823151618.13904-1-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823151618.13904-1-vidyas@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 23, 2019 at 08:46:18PM +0530, Vidya Sagar wrote:
> When a platform has an open PCIe slot, not having a device connected to
> it doesn't have to result in a dev_err() print saying that the link is
> not up but a dev_info() would suffice.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Squashed in pci/tegra, thanks.

Lorenzo

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
>  
>  	return -ETIMEDOUT;
>  }
> -- 
> 2.17.1
> 
