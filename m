Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6290F2DB756
	for <lists+linux-pci@lfdr.de>; Wed, 16 Dec 2020 01:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbgLPABa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Dec 2020 19:01:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:35166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725850AbgLOXbL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Dec 2020 18:31:11 -0500
Date:   Tue, 15 Dec 2020 17:30:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608075030;
        bh=G4W+JOW70+nhdR5jB10BduQ3Oi8mabagk8z9ckwebGU=;
        h=From:To:Cc:Subject:In-Reply-To:From;
        b=mtKceyn6b2eHbktRbWzKjS/6cyF9pUzW7ZlfheuX4mKS/3K0iVp4Fo5GXObuIqNk7
         znMb2I7vpO9r9wyvisEF/6kt7FazkDUsKQI73UWeLdAQJYcioiGChQViMD991ie5pY
         0rphB9CT8NrO05jvpD7V1uISvt9/Vu9rr7VZ77tn3NS8vLg0eSbjTc3rCG5Zb192Lz
         ZJrZg1oJzU16+mwuCDq1BNPKAQKt9PsIcvE8KFYnA88Imi8Kep1kFE68w/BTVD4Cfz
         eL4bD5DNu76ltavi4L91n3AYoUwHBgNPJjAwrs5c2LDj51t/N4DGyWZzuOxZGtUcNL
         W331xVqJkdmug==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Tom Joseph <tjoseph@cadence.com>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Nadeem Athani <nadeem@cadence.com>, linux-omap@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, mparab@cadence.com,
        sjakhade@cadence.com, pthombar@cadence.com
Subject: Re: [PATCH v5] PCI: cadence: Retrain Link to work around Gen2
 training defect.
Message-ID: <20201215233028.GA336802@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215070009.27937-1-kishon@ti.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 15, 2020 at 12:30:09PM +0530, Kishon Vijay Abraham I wrote:
> From: Nadeem Athani <nadeem@cadence.com>
> 
> Cadence controller will not initiate autonomous speed change if strapped as
> Gen2. The Retrain Link bit is set as quirk to enable this speed change.
> 
> Signed-off-by: Nadeem Athani <nadeem@cadence.com>
> [kishon@ti.com: Enable the workaround for TI's J721E SoC]
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
> Hi Lorenzo,
> The previous version of the patch can be found at [1].
> I slightly re-worked the patch from Nadeem
> *) Removed additional Link Up Check
> *) Removed quirk from pcie-cadence-plat.c
> *) Also removed additional compatible
>    "cdns,cdns-pcie-host-quirk-retrain" added in that series
> *) Enabled the quirk for J721E
> [1] -> http://lore.kernel.org/r/20201211144236.3825-1-nadeem@cadence.com
> 
>  drivers/pci/controller/cadence/pci-j721e.c    |  3 +
>  .../controller/cadence/pcie-cadence-host.c    | 67 ++++++++++++++-----
>  drivers/pci/controller/cadence/pcie-cadence.h | 11 ++-
>  3 files changed, 62 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
> index dac1ac8a7615..baf729850cb1 100644
> --- a/drivers/pci/controller/cadence/pci-j721e.c
> +++ b/drivers/pci/controller/cadence/pci-j721e.c
> @@ -64,6 +64,7 @@ enum j721e_pcie_mode {
>  
>  struct j721e_pcie_data {
>  	enum j721e_pcie_mode	mode;
> +	bool			quirk_retrain_flag;
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
> index 811c1cb2e8de..773c0d1137ed 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
> @@ -77,6 +77,50 @@ static struct pci_ops cdns_pcie_host_ops = {
>  	.write		= pci_generic_config_write,
>  };
>  
> +static int cdns_pcie_host_wait_for_link(struct cdns_pcie *pcie)
> +{
> +	struct device *dev = pcie->dev;
> +	int retries;
> +
> +	/* Check if the link is up or not */
> +	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
> +		if (cdns_pcie_link_up(pcie)) {

- cdns_pcie_link_up() always returns "true" except for j721e_pcie_ops.
  Is it really true that we can assume the link is up otherwise?

- Where did the LINK_WAIT_* values come from?  Are they derived from
  something in the PCIe spec?

- Is the LINK_WAIT timeout related to LINK_RETRAIN_TIMEOUT?

- If the PCI core does a link retrain, e.g., in pcie_retrain_link(),
  does that work correctly on this device?

[I see now that this patch only *moves* this code without changing it.
But I'm still curious.]

> +			dev_info(dev, "Link up\n");
> +			return 0;
> +		}
> +		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
> +	}
> +
> +	return -ETIMEDOUT;
> +}
> +
> +static void cdns_pcie_retrain(struct cdns_pcie *pcie)
> +{
> +	u32 lnk_cap_sls, pcie_cap_off = CDNS_PCIE_RP_CAP_OFFSET;
> +	u16 lnk_stat, lnk_ctl;
> +
> +	/*
> +	 * Set retrain bit if current speed is 2.5 GB/s,
> +	 * but the PCIe root port support is > 2.5 GB/s.
> +	 */
> +
> +	lnk_cap_sls = cdns_pcie_readl(pcie, (CDNS_PCIE_RP_BASE + pcie_cap_off +
> +					     PCI_EXP_LNKCAP));
> +	if ((lnk_cap_sls & PCI_EXP_LNKCAP_SLS) <= PCI_EXP_LNKCAP_SLS_2_5GB)
> +		return;
> +
> +	lnk_stat = cdns_pcie_rp_readw(pcie, pcie_cap_off + PCI_EXP_LNKSTA);
> +	if ((lnk_stat & PCI_EXP_LNKSTA_CLS) == PCI_EXP_LNKSTA_CLS_2_5GB) {
> +		lnk_ctl = cdns_pcie_rp_readw(pcie,
> +					     pcie_cap_off + PCI_EXP_LNKCTL);
> +		lnk_ctl |= PCI_EXP_LNKCTL_RL;
> +		cdns_pcie_rp_writew(pcie, pcie_cap_off + PCI_EXP_LNKCTL,
> +				    lnk_ctl);
> +
> +		if (cdns_pcie_host_wait_for_link(pcie))
> +			return;
> +	}
> +}
>  
>  static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
>  {
> @@ -398,23 +442,6 @@ static int cdns_pcie_host_init(struct device *dev,
>  	return cdns_pcie_host_init_address_translation(rc);
>  }
>  
> -static int cdns_pcie_host_wait_for_link(struct cdns_pcie *pcie)
> -{
> -	struct device *dev = pcie->dev;
> -	int retries;
> -
> -	/* Check if the link is up or not */
> -	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
> -		if (cdns_pcie_link_up(pcie)) {
> -			dev_info(dev, "Link up\n");
> -			return 0;
> -		}
> -		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
> -	}
> -
> -	return -ETIMEDOUT;
> -}

This piece looks like a pure move of cdns_pcie_host_wait_for_link()
with no other changes.  It would be nicer to split that to a separate
patch so it doesn't obscure what's really happening in this patch.

>  int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
>  {
>  	struct device *dev = rc->pcie.dev;
> @@ -458,8 +485,12 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
>  	}
>  
>  	ret = cdns_pcie_host_wait_for_link(pcie);
> -	if (ret)
> +	if (ret) {
>  		dev_dbg(dev, "PCIe link never came up\n");
> +	} else {
> +		if (rc->quirk_retrain_flag)
> +			cdns_pcie_retrain(pcie);
> +	}
>  
>  	for (bar = RP_BAR0; bar <= RP_NO_BAR; bar++)
>  		rc->avail_ib_bar[bar] = true;
> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
> index 30eba6cafe2c..0f29128a5d0a 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence.h
> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
> @@ -119,7 +119,7 @@
>   * Root Port Registers (PCI configuration space for the root port function)
>   */
>  #define CDNS_PCIE_RP_BASE	0x00200000
> -
> +#define CDNS_PCIE_RP_CAP_OFFSET 0xc0
>  
>  /*
>   * Address Translation Registers
> @@ -291,6 +291,7 @@ struct cdns_pcie {
>   * @device_id: PCI device ID
>   * @avail_ib_bar: Satus of RP_BAR0, RP_BAR1 and	RP_NO_BAR if it's free or
>   *                available
> + * @quirk_retrain_flag: Retrain link as quirk for PCIe Gen2
>   */
>  struct cdns_pcie_rc {
>  	struct cdns_pcie	pcie;
> @@ -299,6 +300,7 @@ struct cdns_pcie_rc {
>  	u32			vendor_id;
>  	u32			device_id;
>  	bool			avail_ib_bar[CDNS_PCIE_RP_MAX_IB];
> +	bool			quirk_retrain_flag;
>  };
>  
>  /**
> @@ -414,6 +416,13 @@ static inline void cdns_pcie_rp_writew(struct cdns_pcie *pcie,
>  	cdns_pcie_write_sz(addr, 0x2, value);
>  }
>  
> +static inline u16 cdns_pcie_rp_readw(struct cdns_pcie *pcie, u32 reg)
> +{
> +	void __iomem *addr = pcie->reg_base + CDNS_PCIE_RP_BASE + reg;
> +
> +	return cdns_pcie_read_sz(addr, 0x2);
> +}
> +
>  /* Endpoint Function register access */
>  static inline void cdns_pcie_ep_fn_writeb(struct cdns_pcie *pcie, u8 fn,
>  					  u32 reg, u8 value)
> -- 
> 2.17.1
> 
