Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA9B124EDFD
	for <lists+linux-pci@lfdr.de>; Sun, 23 Aug 2020 17:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgHWPrC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 23 Aug 2020 11:47:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:53212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726734AbgHWPrB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 23 Aug 2020 11:47:01 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F0E22067C;
        Sun, 23 Aug 2020 15:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598197620;
        bh=HkdswJgTO5R0eA2Zz1KPvY3RMkBSsu4ixMf6ik3sDvI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KkoqwEVBF3bEG1VRsww/ahrRXWdQmyYotNGk4duNJxPH//kULVygK6d7BY47taIYG
         8d96zYyIITRN+0Lfelfmj3nWdK23rdC+cZLU2XM7dh5NYMyKlSMlFq258YWBKWMzDe
         OoVGq980ChGrKLWTMzFzPKW2O5fpCOII78Hw7DBU=
Date:   Sun, 23 Aug 2020 21:16:56 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sivaprakash Murugesan <sivaprak@codeaurora.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, bhelgaas@google.com,
        robh+dt@kernel.org, kishon@ti.com, svarbanov@mm-sol.com,
        lorenzo.pieralisi@arm.com, p.zabel@pengutronix.de,
        mgautam@codeaurora.org, smuthayy@codeaurora.org,
        varada@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
Subject: Re: [PATCH V2 5/7] PCI: qcom: Do PHY power on before PCIe init
Message-ID: <20200823154656.GU2639@vkoul-mobl>
References: <1596036607-11877-1-git-send-email-sivaprak@codeaurora.org>
 <1596036607-11877-6-git-send-email-sivaprak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596036607-11877-6-git-send-email-sivaprak@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 29-07-20, 21:00, Sivaprakash Murugesan wrote:
> Commit cc1e06f033af ("phy: qcom: qmp: Use power_on/off ops for PCIe")
> changed phy ops from init/deinit to power on/off, due to this phy enable
> is getting called after PCIe init.
> 
> On some platforms like ipq8074 phy should be inited before accessing the
> PCIe register space, otherwise the system would hang.

Have you verified that this causes no regression on sdm845 and other
platforms?

> So move phy_power_on API before PCIe init.
> 
> Fixes: commit cc1e06f033af ("phy: qcom: qmp: Use power_on/off ops for PCIe")

Is this a fix..? You are updating sequencing for a new platform

> Co-developed-by: Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
> Signed-off-by: Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
> Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 3aac77a..e1b5651 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1265,18 +1265,18 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
>  
>  	qcom_ep_reset_assert(pcie);
>  
> -	ret = pcie->ops->init(pcie);
> +	ret = phy_power_on(pcie->phy);
>  	if (ret)
>  		return ret;
>  
> -	ret = phy_power_on(pcie->phy);
> +	ret = pcie->ops->init(pcie);
>  	if (ret)
> -		goto err_deinit;
> +		goto err_disable_phy;
>  
>  	if (pcie->ops->post_init) {
>  		ret = pcie->ops->post_init(pcie);
>  		if (ret)
> -			goto err_disable_phy;
> +			goto err_deinit;
>  	}
>  
>  	dw_pcie_setup_rc(pp);
> @@ -1295,10 +1295,10 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
>  	qcom_ep_reset_assert(pcie);
>  	if (pcie->ops->post_deinit)
>  		pcie->ops->post_deinit(pcie);
> -err_disable_phy:
> -	phy_power_off(pcie->phy);
>  err_deinit:
>  	pcie->ops->deinit(pcie);
> +err_disable_phy:
> +	phy_power_off(pcie->phy);
>  
>  	return ret;
>  }
> -- 
> 2.7.4

-- 
~Vinod
