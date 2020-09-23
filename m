Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76B7B27623A
	for <lists+linux-pci@lfdr.de>; Wed, 23 Sep 2020 22:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgIWUiL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Sep 2020 16:38:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:36016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726419AbgIWUiL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Sep 2020 16:38:11 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C589220725;
        Wed, 23 Sep 2020 20:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600893491;
        bh=AskTKIC0gVf9+eudy7V2ZFeIHmr9SERPbmozivXSEaQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=BuDzCXnwneiQEBijijm9OgF/t4EVX12j+56co+NLwWejFSek19RliEPne7vUBU8AV
         DdU2YzX7tm6v52Y6F6fSdEinqudN3rDVWx7q+Q6Mn9j8mHPIr2b0dtIWooiEHJIy/X
         IHHdXtaiVkyZvSiz5zAfr2rEsweAw2olm40Hk1Sg=
Date:   Wed, 23 Sep 2020 15:38:09 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nadeem Athani <nadeem@cadence.com>
Cc:     tjoseph@cadence.com, lorenzo.pieralisi@arm.com, robh@kernel.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kishon@ti.com, mparab@cadence.com,
        sjakhade@cadence.com
Subject: Re: [PATCH v2] PCI: Cadence: Add quirk for Gen2 controller to do
 autonomous speed change.
Message-ID: <20200923203809.GA2289779@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923183427.9258-1-nadeem@cadence.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Something like:

  PCI: cadence: Retrain Link to work around Gen2 training defect

to match history (see "git log --oneline
drivers/pci/controller/cadence/pcie-cadence-host.c").

On Wed, Sep 23, 2020 at 08:34:27PM +0200, Nadeem Athani wrote:
> Cadence controller will not initiate autonomous speed change if
> strapped as Gen2. The Retrain bit is set as a quirk to trigger
> this speed change.

To match the spec terminology:

  Set the Retrain Link bit ...

Obviously I don't know the details of your device or even how PCIe
works at this level.  But IIUC a link always comes up at 2.5 GT/s
first and then the upstream and downstream components negotiate the
highest speed they both support.  It sounds like your controller
doesn't actually do this negotiation unless you set the Retrain Link
bit?

Is cdns_pcie_host_init_root_port() the only time this needs to be
done?  We don't have to worry about doing this again after a reset,
hot-add event, etc?

> Signed-off-by: Nadeem Athani <nadeem@cadence.com>
> ---
>  drivers/pci/controller/cadence/pcie-cadence-host.c | 14 ++++++++++++++
>  drivers/pci/controller/cadence/pcie-cadence.h      | 15 +++++++++++++++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
> index 4550e0d469ca..a2317614268d 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
> @@ -83,6 +83,9 @@ static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
>  	struct cdns_pcie *pcie = &rc->pcie;
>  	u32 value, ctrl;
>  	u32 id;
> +	u32 link_cap = CDNS_PCIE_LINK_CAP_OFFSET;

This is not actually the link cap offset.  Based on the usage, this
appears to be the offset of the PCIe Capability.

> +	u8 sls;
> +	u16 lnk_ctl;
>  
>  	/*
>  	 * Set the root complex BAR configuration register:
> @@ -111,6 +114,17 @@ static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
>  	if (rc->device_id != 0xffff)
>  		cdns_pcie_rp_writew(pcie, PCI_DEVICE_ID, rc->device_id);
>  
> +	/* Quirk to enable autonomous speed change for GEN2 controller */
> +	/* Reading Supported Link Speed value */
> +	sls = PCI_EXP_LNKCAP_SLS &
> +		cdns_pcie_rp_readb(pcie, link_cap + PCI_EXP_LNKCAP);

The conventional way to write this would be

  sls = cdns_pcie_rp_readb(pcie, link_cap + PCI_EXP_LNKCAP) &
    PCI_EXP_LNKCAP_SLS;

> +	if (sls == PCI_EXP_LNKCAP_SLS_5_0GB) {
> +		/* Since this a Gen2 controller, set Retrain Link(RL) bit */
> +		lnk_ctl = cdns_pcie_rp_readw(pcie, link_cap + PCI_EXP_LNKCTL);
> +		lnk_ctl |= PCI_EXP_LNKCTL_RL;
> +		cdns_pcie_rp_writew(pcie, link_cap + PCI_EXP_LNKCTL, lnk_ctl);
> +	}
> +
>  	cdns_pcie_rp_writeb(pcie, PCI_CLASS_REVISION, 0);
>  	cdns_pcie_rp_writeb(pcie, PCI_CLASS_PROG, 0);
>  	cdns_pcie_rp_writew(pcie, PCI_CLASS_DEVICE, PCI_CLASS_BRIDGE_PCI);
> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
> index feed1e3038f4..fe560480c573 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence.h
> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
> @@ -120,6 +120,7 @@
>   */
>  #define CDNS_PCIE_RP_BASE	0x00200000
>  
> +#define CDNS_PCIE_LINK_CAP_OFFSET 0xC0

Use lower-case in hex as the rest of the file does.

>  /*
>   * Address Translation Registers
> @@ -413,6 +414,20 @@ static inline void cdns_pcie_rp_writew(struct cdns_pcie *pcie,
>  	cdns_pcie_write_sz(addr, 0x2, value);
>  }
>  
> +static inline u8 cdns_pcie_rp_readb(struct cdns_pcie *pcie, u32 reg)
> +{
> +	void __iomem *addr = pcie->reg_base + CDNS_PCIE_RP_BASE + reg;
> +
> +	return cdns_pcie_read_sz(addr, 0x1);
> +}
> +
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
> 2.15.0
> 
