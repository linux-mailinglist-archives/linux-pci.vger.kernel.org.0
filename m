Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA2397C0A
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2019 16:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbfHUOF1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Aug 2019 10:05:27 -0400
Received: from foss.arm.com ([217.140.110.172]:58410 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727949AbfHUOF1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 21 Aug 2019 10:05:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF763337;
        Wed, 21 Aug 2019 07:05:26 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 960F63F706;
        Wed, 21 Aug 2019 07:05:25 -0700 (PDT)
Date:   Wed, 21 Aug 2019 15:05:20 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Vidya Sagar <vidyas@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] PCI: tegra: tegra194: fix phy_count less than zero
 check
Message-ID: <20190821140520.GA691@e121166-lin.cambridge.arm.com>
References: <20190821120123.14223-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821120123.14223-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 21, 2019 at 01:01:23PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The check for pcie->phy_count < 0 is always false because phy_count
> is an unsigned int and can never be less than zero. Fix this by
> assigning ret to the return from of_property_count_strings and
> checking if this is less than zero instead.
> 
> Addresses-Coverity: ("Dead code")
> Fixes: 6404441c8e13 ("PCI: tegra: Add Tegra194 PCIe support")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/pci/controller/dwc/pcie-tegra194.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Squashed in the original commit (it is not merged yet), thanks
for reporting it.

Lorenzo

> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index fc0dbeb31d78..b47ea3e68303 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -969,12 +969,13 @@ static int tegra_pcie_dw_parse_dt(struct tegra_pcie_dw *pcie)
>  		return ret;
>  	}
>  
> -	pcie->phy_count = of_property_count_strings(np, "phy-names");
> -	if (pcie->phy_count < 0) {
> +	ret = of_property_count_strings(np, "phy-names");
> +	if (ret < 0) {
>  		dev_err(pcie->dev, "Failed to find PHY entries: %d\n",
> -			pcie->phy_count);
> -		return pcie->phy_count;
> +			ret);
> +		return ret;
>  	}
> +	pcie->phy_count = ret;
>  
>  	if (of_property_read_bool(np, "nvidia,update-fc-fixup"))
>  		pcie->update_fc_fixup = true;
> -- 
> 2.20.1
> 
