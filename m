Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA9FB42F485
	for <lists+linux-pci@lfdr.de>; Fri, 15 Oct 2021 15:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240114AbhJOOAE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Oct 2021 10:00:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:54372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236490AbhJOOAE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 15 Oct 2021 10:00:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 65CC661181;
        Fri, 15 Oct 2021 13:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634306277;
        bh=XZBGWtk/gDQlBRTl34x7ls7aM2LqB8QK8leU5F5ALhk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=VJ52AT4q+8IF1vnQ9Q7/uHqgqeSz/JiCP0egUgOPIueoJY51SW51wg0LZU2mTMJZd
         XA/D0M/ejjyXHfAP6y0rIfEZ1OF8mRgoIni35YWJeGWMYtLVh5TEDEJYsamcRw5kGF
         JBxO6BhQZZOcqZLWAliVjorDdYvDdy6lqQL+xHiwXGNks3tVNbyhJopj7mxFrlr0qM
         2dQmINMDjWhicgPOmmZxnh8h7t/5YfKXj27W6HAiVP73M19d6vF3JFmLlLJ1y2i97H
         5XzRt5N2dJF6Af79rsFSqDsbRrXWaD8k4fePAvux66F/J3gcppNl9fxfFn1XPq9s2Y
         yp5ZQds8QZzcw==
Date:   Fri, 15 Oct 2021 08:57:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Prasad Malisetty <pmaliset@codeaurora.org>
Cc:     svarbanov@mm-sol.com, agross@kernel.org,
        bjorn.andersson@linaro.org, lorenzo.pieralisi@arm.com,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, vbadigan@codeaurora.org,
        kw@linux.com, bhelgaas@google.com, manivannan.sadhasivam@linaro.org
Subject: Re: [PATCH v1] PCI: qcom: Fix incorrect register offset in pcie init
Message-ID: <20211015135755.GA2098274@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1634237929-25459-1-git-send-email-pmaliset@codeaurora.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This looks specific to SDM845, so the subject line should mention
SDM845, e.g.,

  PCI: qcom: Fix SDM845 incorrect register offset

On Fri, Oct 15, 2021 at 12:28:49AM +0530, Prasad Malisetty wrote:
> In pcie_init_2_7_0 one of the register writes using incorrect offset
> as per the platform register definitions (PCIE_PARF_AXI_MSTR_WR_ADDR_HALT
> offset value should be 0x1A8 instead 0x178).
> Update the correct offset value for SDM845 platform.

Add "()" after function name.  Add blank line between paragraphs.

It'd be nice to have a clue about what fails because of the incorrect
register offset.  ed8cc3b1fc84 is almost two years old, so I guess
it's not an obvious issue.

> fixes: ed8cc3b1 ("PCI: qcom: Add support for SDM845 PCIe controller")

Capitalize "Fixes:", use 12-char SHA1, remove blank line after.  Look
at previous git history and copy the style there.

> 
> Signed-off-by: Prasad Malisetty <pmaliset@codeaurora.org>

It looks like ed8cc3b1fc84 appeared in v5.6, so this should probably
have a "Cc: stable@vger.kernel.org" tag as well.

> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 8a7a300..5bce152 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1230,9 +1230,9 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
>  	writel(val, pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
>  
>  	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> -		val = readl(pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT);
> +		val = readl(pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2);
>  		val |= BIT(31);
> -		writel(val, pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT);
> +		writel(val, pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2);
>  	}
>  
>  	return 0;
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
