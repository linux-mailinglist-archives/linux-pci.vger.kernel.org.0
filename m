Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4E634B02F
	for <lists+linux-pci@lfdr.de>; Fri, 26 Mar 2021 21:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbhCZUbT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Mar 2021 16:31:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:43692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230174AbhCZUbH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 26 Mar 2021 16:31:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B69E61A0D;
        Fri, 26 Mar 2021 20:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616790666;
        bh=4sFgh402bJa1V+KKITowOoaqjf68udlldNqx7lLArHw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=IFtqc0uvWV/YIYVDlZkMUetISgaDx0kNW2DHdO77M5yEfR0uKdmwSHI9uc6QaWXF1
         8s2Dggbm40/8A7Cttp/pK6ZrscFSBQnMwc86o9QxV2m4xEjgd5SOAbVdsf19ER4d+o
         xtrCRavMZ9YfinYRCdd7lp9hKWh3ICBF91Ot4oz9rNIeYJcKSD90q0ovAYrWOeAS0u
         gvP+XTxaYzwF+5JBz78xc6hMpE4G0i1guLqSlPfDkQ76wETk6gV5QPf3TUvKEuXK+q
         skpNbaD7e0PqhjP+VLDDvFlAugH/Tpmqi8YXUoclwmEqDKW7PUyQeb5Fa1pnIWC2+j
         QCUeOyRPz9byQ==
Date:   Fri, 26 Mar 2021 15:31:05 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>, '@bjorn-Precision-5520
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jim Quinlan <jquinlan@broadcom.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 6/6] PCI: brcmstb: Check return value of
 clk_prepare_enable()
Message-ID: <20210326203105.GA906530@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210326191906.43567-7-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 26, 2021 at 03:19:04PM -0400, Jim Quinlan wrote:
> The check was missing on PCIe resume.

"PCIe resume" isn't really a thing, per se.  PCI/PCIe gives us device
power states (D0, D3hot, etc), and Linux power management builds
suspend/resume on top of those.  Maybe:

  Check for failure of clk_prepare_enable() on device resume.

> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> Fixes: 8195b7417018 ("PCI: brcmstb: Add suspend and resume pm_ops")
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 2d9288399014..f6d9d785b301 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -1396,7 +1396,9 @@ static int brcm_pcie_resume(struct device *dev)
>  	int ret;
>  
>  	base = pcie->base;
> -	clk_prepare_enable(pcie->clk);
> +	ret = clk_prepare_enable(pcie->clk);
> +	if (ret)
> +		return ret;

This fix doesn't look like it depends on the EP regulator support.
Maybe it should be a preparatory patch before patch 1/6?  It could
then easily be backported to kernels that contain 8195b7417018 but not
EP regulator support.

>  	ret = brcm_set_regulators(pcie, TURN_ON);
>  	if (ret)
> @@ -1535,7 +1537,9 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>  
>  	ret = brcm_pcie_get_regulators(pcie);
>  	if (ret) {
> -		dev_err(pcie->dev, "failed to get regulators (err=%d)\n", ret);
> +		pcie->num_supplies = 0;
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(pcie->dev, "failed to get regulators (err=%d)\n", ret);

Looks like this hunk might belong somewhere else, e.g., in patch 2/6?
The "Fixes:" line suggests that this patch could/should be backported to
every kernel that contains 8195b7417018, but 8195b7417018 doesn't have
pcie->num_supplies.

>  		goto fail;
>  	}
>  
> -- 
> 2.17.1
> 
