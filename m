Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57D7CD67AE
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2019 18:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730823AbfJNQua (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Oct 2019 12:50:30 -0400
Received: from foss.arm.com ([217.140.110.172]:48892 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730192AbfJNQua (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Oct 2019 12:50:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E53E728;
        Mon, 14 Oct 2019 09:50:29 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E14FA3F718;
        Mon, 14 Oct 2019 09:50:28 -0700 (PDT)
Date:   Mon, 14 Oct 2019 17:50:26 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Remi Pommarel <repk@triplefau.lt>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ellie Reeves <ellierevves@gmail.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: aardvark: Use LTSSM state to build link training
 flag
Message-ID: <20191014165026.GC2928@e121166-lin.cambridge.arm.com>
References: <20190522213351.21366-3-repk@triplefau.lt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522213351.21366-3-repk@triplefau.lt>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 22, 2019 at 11:33:51PM +0200, Remi Pommarel wrote:
> Aardvark's PCI_EXP_LNKSTA_LT flag in its link status register is not
> implemented and does not reflect the actual link training state (the
> flag is always set to 0). In order to support link re-training feature
> this flag has to be emulated. The Link Training and Status State
> Machine (LTSSM) flag in Aardvark LMI config register could be used as
> a link training indicator. Indeed if the LTSSM is in L0 or upper state
> then link training has completed (see [1]).
> 
> Unfortunately because after asking a link retraining it takes a while
> for the LTSSM state to become less than 0x10 (due to L0s to recovery
> state transition delays), LTSSM can still be in L0 while link training
> has not finished yet. So this waits for link to be in recovery or lesser
> state before returning after asking for a link retrain.
> 
> [1] "PCI Express Base Specification", REV. 4.0
>     PCI Express, February 19 2014, Table 4-14
> 
> Signed-off-by: Remi Pommarel <repk@triplefau.lt>
> ---
> Changes since v1:
>   - Rename retraining flag field
>   - Fix DEVCTL register writing
> 
> Changes since v2:
>   - Rewrite patch logic so it is more legible
> 
> Please note that I will unlikely be able to answer any comments from May
> 24th to June 10th.
> ---
>  drivers/pci/controller/pci-aardvark.c | 29 ++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)

Merged in pci/aardvark, to be decided if we target one of the
upcoming -rc* or v5.5.

Thanks and apologies for the delay.

Lorenzo

> 
> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> index 134e0306ff00..8803083b2174 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@ -180,6 +180,8 @@
>  #define LINK_WAIT_MAX_RETRIES		10
>  #define LINK_WAIT_USLEEP_MIN		90000
>  #define LINK_WAIT_USLEEP_MAX		100000
> +#define RETRAIN_WAIT_MAX_RETRIES	10
> +#define RETRAIN_WAIT_USLEEP_US		2000
>  
>  #define MSI_IRQ_NUM			32
>  
> @@ -239,6 +241,17 @@ static int advk_pcie_wait_for_link(struct advk_pcie *pcie)
>  	return -ETIMEDOUT;
>  }
>  
> +static void advk_pcie_wait_for_retrain(struct advk_pcie *pcie)
> +{
> +	size_t retries;
> +
> +	for (retries = 0; retries < RETRAIN_WAIT_MAX_RETRIES; ++retries) {
> +		if (!advk_pcie_link_up(pcie))
> +			break;
> +		udelay(RETRAIN_WAIT_USLEEP_US);
> +	}
> +}
> +
>  static void advk_pcie_setup_hw(struct advk_pcie *pcie)
>  {
>  	u32 reg;
> @@ -426,11 +439,20 @@ advk_pci_bridge_emul_pcie_conf_read(struct pci_bridge_emul *bridge,
>  		return PCI_BRIDGE_EMUL_HANDLED;
>  	}
>  
> +	case PCI_EXP_LNKCTL: {
> +		/* u32 contains both PCI_EXP_LNKCTL and PCI_EXP_LNKSTA */
> +		u32 val = advk_readl(pcie, PCIE_CORE_PCIEXP_CAP + reg) &
> +			~(PCI_EXP_LNKSTA_LT << 16);
> +		if (!advk_pcie_link_up(pcie))
> +			val |= (PCI_EXP_LNKSTA_LT << 16);
> +		*value = val;
> +		return PCI_BRIDGE_EMUL_HANDLED;
> +	}
> +
>  	case PCI_CAP_LIST_ID:
>  	case PCI_EXP_DEVCAP:
>  	case PCI_EXP_DEVCTL:
>  	case PCI_EXP_LNKCAP:
> -	case PCI_EXP_LNKCTL:
>  		*value = advk_readl(pcie, PCIE_CORE_PCIEXP_CAP + reg);
>  		return PCI_BRIDGE_EMUL_HANDLED;
>  	default:
> @@ -447,8 +469,13 @@ advk_pci_bridge_emul_pcie_conf_write(struct pci_bridge_emul *bridge,
>  
>  	switch (reg) {
>  	case PCI_EXP_DEVCTL:
> +		advk_writel(pcie, new, PCIE_CORE_PCIEXP_CAP + reg);
> +		break;
> +
>  	case PCI_EXP_LNKCTL:
>  		advk_writel(pcie, new, PCIE_CORE_PCIEXP_CAP + reg);
> +		if (new & PCI_EXP_LNKCTL_RL)
> +			advk_pcie_wait_for_retrain(pcie);
>  		break;
>  
>  	case PCI_EXP_RTCTL:
> -- 
> 2.20.1
> 
