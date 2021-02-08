Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0AFE313D9A
	for <lists+linux-pci@lfdr.de>; Mon,  8 Feb 2021 19:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbhBHSdF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Feb 2021 13:33:05 -0500
Received: from foss.arm.com ([217.140.110.172]:39996 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235654AbhBHSck (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 8 Feb 2021 13:32:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3FEA11042;
        Mon,  8 Feb 2021 10:31:54 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD1503F73D;
        Mon,  8 Feb 2021 10:31:52 -0800 (PST)
Date:   Mon, 8 Feb 2021 18:31:47 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Nadeem Athani <nadeem@cadence.com>
Cc:     tjoseph@cadence.com, robh@kernel.org, bhelgaas@google.com,
        kishon@ti.com, linux-omap@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, mparab@cadence.com,
        sjakhade@cadence.com, pthombar@cadence.com
Subject: Re: [PATCH v7 2/2] PCI: cadence: Retrain Link to work around Gen2
 training defect.
Message-ID: <20210208183147.GA12258@e121166-lin.cambridge.arm.com>
References: <20201230120515.2348-1-nadeem@cadence.com>
 <20201230120515.2348-3-nadeem@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201230120515.2348-3-nadeem@cadence.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 30, 2020 at 01:05:15PM +0100, Nadeem Athani wrote:
> Cadence controller will not initiate autonomous speed change if strapped
> as Gen2. The Retrain Link bit is set as quirk to enable this speed change.
> 
> Signed-off-by: Nadeem Athani <nadeem@cadence.com>
> ---
>  drivers/pci/controller/cadence/pci-j721e.c         |  3 ++
>  drivers/pci/controller/cadence/pcie-cadence-host.c | 37 +++++++++++++++++++++-
>  drivers/pci/controller/cadence/pcie-cadence.h      | 11 ++++++-
>  3 files changed, 49 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
> index dac1ac8a7615..849f1e416ea5 100644
> --- a/drivers/pci/controller/cadence/pci-j721e.c
> +++ b/drivers/pci/controller/cadence/pci-j721e.c
> @@ -64,6 +64,7 @@ enum j721e_pcie_mode {
>  
>  struct j721e_pcie_data {
>  	enum j721e_pcie_mode	mode;
> +	bool quirk_retrain_flag;
>  };
>  
>  static inline u32 j721e_pcie_user_readl(struct j721e_pcie *pcie, u32 offset)
> @@ -280,6 +281,7 @@ static struct pci_ops cdns_ti_pcie_host_ops = {
>  
>  static const struct j721e_pcie_data j721e_pcie_rc_data = {
>  	.mode = PCI_MODE_RC,
> +	.quirk_retrain_flag = true,
>  };
>  
>  static const struct j721e_pcie_data j721e_pcie_ep_data = {
> @@ -388,6 +390,7 @@ static int j721e_pcie_probe(struct platform_device *pdev)
>  
>  		bridge->ops = &cdns_ti_pcie_host_ops;
>  		rc = pci_host_bridge_priv(bridge);
> +		rc->quirk_retrain_flag = data->quirk_retrain_flag;
>  
>  		cdns_pcie = &rc->pcie;
>  		cdns_pcie->dev = dev;
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
> index 9f7aa718c8d4..f3496588862d 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
> @@ -94,6 +94,35 @@ static int cdns_pcie_host_wait_for_link(struct cdns_pcie *pcie)
>  	return -ETIMEDOUT;
>  }
>  
> +static int cdns_pcie_retrain(struct cdns_pcie *pcie)
> +{
> +	u32 lnk_cap_sls, pcie_cap_off = CDNS_PCIE_RP_CAP_OFFSET;
> +	u16 lnk_stat, lnk_ctl;
> +	int ret = 0;
> +
> +	/*
> +	 * Set retrain bit if current speed is 2.5 GB/s,
> +	 * but the PCIe root port support is > 2.5 GB/s.
> +	 */
> +
> +	lnk_cap_sls = cdns_pcie_readl(pcie, (CDNS_PCIE_RP_BASE + pcie_cap_off +
> +					     PCI_EXP_LNKCAP));
> +	if ((lnk_cap_sls & PCI_EXP_LNKCAP_SLS) <= PCI_EXP_LNKCAP_SLS_2_5GB)
> +		return ret;
> +
> +	lnk_stat = cdns_pcie_rp_readw(pcie, pcie_cap_off + PCI_EXP_LNKSTA);
> +	if ((lnk_stat & PCI_EXP_LNKSTA_CLS) == PCI_EXP_LNKSTA_CLS_2_5GB) {
> +		lnk_ctl = cdns_pcie_rp_readw(pcie,
> +					     pcie_cap_off + PCI_EXP_LNKCTL);
> +		lnk_ctl |= PCI_EXP_LNKCTL_RL;
> +		cdns_pcie_rp_writew(pcie, pcie_cap_off + PCI_EXP_LNKCTL,
> +				    lnk_ctl);
> +
> +		ret = cdns_pcie_host_wait_for_link(pcie);
> +	}
> +	return ret;
> +}
> +
>  static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
>  {
>  	struct cdns_pcie *pcie = &rc->pcie;
> @@ -457,8 +486,14 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
>  	}
>  
>  	ret = cdns_pcie_host_wait_for_link(pcie);
> -	if (ret)
> +	if (ret) {
>  		dev_dbg(dev, "PCIe link never came up\n");
> +	} else {
> +		if (rc->quirk_retrain_flag) {
> +			if (cdns_pcie_retrain(pcie))
> +				dev_dbg(dev, "PCIe link never came up\n");

I'd move this whole if/else in a function cdns_pcie_host_start_link(),
IMO that's cleaner.

static int cdns_pcie_host_start_link(struct cdns_pcie_rc *rc)
{
	struct cdns_pcie *pcie = &rc->pcie;
	int ret;

	ret = cdns_pcie_host_wait_for_link(pcie);
	/*
	 * PLS ADD A COMMENT HERE
	 */
	if (!ret && rc->quirk_retrain_flag)
		ret = cdns_pcie_retrain(pcie);

	return ret;
}
