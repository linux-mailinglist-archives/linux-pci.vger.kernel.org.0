Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE53E393327
	for <lists+linux-pci@lfdr.de>; Thu, 27 May 2021 18:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234920AbhE0QHp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 May 2021 12:07:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:54028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234504AbhE0QHo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 May 2021 12:07:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0E6666100A;
        Thu, 27 May 2021 16:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622131571;
        bh=vqPlEi+k8FKHa/wZ6C7jWBQ7Xe+r7OWX8AUIx1IvgWI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=RkOpmWWeptig8/+4q2OhLLy7Q0y/L+G1z3zmpazjNvoHI843AGona0A9EG1KCW7Ss
         FPvp2MIHkk6e3URWVv2jV0ZKddPxIAWvu9FNOdZXUb0s2jXaTJJBRC8FhsrS6h/QZf
         L9DPeikJzviAV4ft4Vba1UmTiuG+GN++bs5n6um6DTAO9T/+Yz99imHpzJWm0Ag8/k
         Y00UL8y8zcc5JzUvCs5gTuXX8pmXHOFAxcMYQ7SJKwR3QSmHkgKIdpdGUpPE1vXY0f
         /XBkS1+VXNedIbL/yf3DKBKxYc1XMobzc2wunb0fqus6Vq0sEoY6jBJ5b9aVxGRqJD
         xKn1+bHBlBt8A==
Date:   Thu, 27 May 2021 11:06:09 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Om Prakash Singh <omp@nvidia.com>
Cc:     vidyas@nvidia.com, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com
Subject: Re: [RESEND PATCH V1 1/5] PCI: tegra: Fix handling BME_CHGED event
Message-ID: <20210527160609.GA1400341@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210527115246.20509-2-omp@nvidia.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 27, 2021 at 05:22:42PM +0530, Om Prakash Singh wrote:
> In tegra_pcie_ep_hard_irq(), APPL_INTR_STATUS_L0 is stored in val and again
> APPL_INTR_STATUS_L1_0_0 is also stored in val. So when execution reaches
> "if (val & APPL_INTR_STATUS_L0_PCI_CMD_EN_INT)", val is not correct.
> 
> Signed-off-by: Om Prakash Singh <omp@nvidia.com>
> ---
>  drivers/pci/controller/dwc/pcie-tegra194.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index bafd2c6ab3c2..c51d666c9d87 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -615,10 +615,10 @@ static irqreturn_t tegra_pcie_ep_hard_irq(int irq, void *arg)
>  	struct tegra_pcie_dw *pcie = arg;
>  	struct dw_pcie_ep *ep = &pcie->pci.ep;
>  	int spurious = 1;
> -	u32 val, tmp;
> +	u32 val_l0, val, tmp;

Too bad this uses such bad variable names.  Names like "status_l0",
"status_l1", "link_status" would have avoided this in the first place.

"val" makes sense in places like config accessors where we're reading
or writing unspecified registers.  But when we're accessing specific
named registers?  Not so much.
