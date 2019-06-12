Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB4E42A5D
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2019 17:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439912AbfFLPIZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jun 2019 11:08:25 -0400
Received: from foss.arm.com ([217.140.110.172]:55422 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439910AbfFLPIZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Jun 2019 11:08:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79E1A2B;
        Wed, 12 Jun 2019 08:08:24 -0700 (PDT)
Received: from redmoon (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B4443F557;
        Wed, 12 Jun 2019 08:08:22 -0700 (PDT)
Date:   Wed, 12 Jun 2019 16:08:20 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: Re: [PATCHv5 10/20] PCI: mobiveil: Fix the INTx process errors
Message-ID: <20190612150819.GD15747@redmoon>
References: <20190412083635.33626-1-Zhiqiang.Hou@nxp.com>
 <20190412083635.33626-11-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190412083635.33626-11-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 12, 2019 at 08:36:12AM +0000, Z.q. Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> In the loop block, there is not code to update the loop key,
> this patch updates the loop key by re-read the INTx status
> register.
> 
> This patch also add the clearing of the handled INTx status.
> 
> Note: Need MV to test this fix.

This means INTX were never tested and current code handling them is,
AFAICS, an infinite loop which is very very bad.

This is a gross bug and must be fixed as soon as possible.

I want Karthikeyan ACK and Tested-by on this patch.

Lorenzo

> Fixes: 9af6bcb11e12 ("PCI: mobiveil: Add Mobiveil PCIe Host Bridge IP driver")
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
> ---
> V5:
>  - Corrected and retouched the subject and changelog.
> 
>  drivers/pci/controller/pcie-mobiveil.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
> index 4ba458474e42..78e575e71f4d 100644
> --- a/drivers/pci/controller/pcie-mobiveil.c
> +++ b/drivers/pci/controller/pcie-mobiveil.c
> @@ -361,6 +361,7 @@ static void mobiveil_pcie_isr(struct irq_desc *desc)
>  	/* Handle INTx */
>  	if (intr_status & PAB_INTP_INTX_MASK) {
>  		shifted_status = csr_readl(pcie, PAB_INTP_AMBA_MISC_STAT);
> +		shifted_status &= PAB_INTP_INTX_MASK;
>  		shifted_status >>= PAB_INTX_START;
>  		do {
>  			for_each_set_bit(bit, &shifted_status, PCI_NUM_INTX) {
> @@ -372,12 +373,16 @@ static void mobiveil_pcie_isr(struct irq_desc *desc)
>  					dev_err_ratelimited(dev, "unexpected IRQ, INT%d\n",
>  							    bit);
>  
> -				/* clear interrupt */
> -				csr_writel(pcie,
> -					   shifted_status << PAB_INTX_START,
> +				/* clear interrupt handled */
> +				csr_writel(pcie, 1 << (PAB_INTX_START + bit),
>  					   PAB_INTP_AMBA_MISC_STAT);
>  			}
> -		} while ((shifted_status >> PAB_INTX_START) != 0);
> +
> +			shifted_status = csr_readl(pcie,
> +						   PAB_INTP_AMBA_MISC_STAT);
> +			shifted_status &= PAB_INTP_INTX_MASK;
> +			shifted_status >>= PAB_INTX_START;
> +		} while (shifted_status != 0);
>  	}
>  
>  	/* read extra MSI status register */
> -- 
> 2.17.1
> 
