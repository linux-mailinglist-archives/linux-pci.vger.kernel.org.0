Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDCD3EEF43
	for <lists+linux-pci@lfdr.de>; Tue, 17 Aug 2021 17:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236651AbhHQPj1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Aug 2021 11:39:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:44294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230369AbhHQPj1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Aug 2021 11:39:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B27D060EE4;
        Tue, 17 Aug 2021 15:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629214734;
        bh=8Dn8xwRrAwdeTSpGsm45Gr/0PhlYpnmOGmb5P59Ujc0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=lTx8o0We4f58KEp0jwZ20xH892smeI6EYqQ0JCAe47jsJc+77ZMSWhHVaDgcnS1FI
         e6RSb5qChsTyNXEU581LeNR1y8yFqYPBnIhpwuFbjhghHMP8MV+7vWXPAcFxIeLLu0
         JIu1yjFm2Ry/fgPsV8feHKX+cjHurBsJjxdPONGDamDxMKUJ38alVKbTMzSFWFoTdo
         nV8EoTBLt44kDCWy+MVrF6p64uCsPSq5MEHO8Fk9KQNe+EEgiGN3NraHXnARaLp6B6
         zkqg9KvU9Lm6x//sl9Qm7iC72pfFxKcUSFgo0D+9OJpLsKbTMXkRqjE4UvogrJl61F
         NHNFS25VACPhg==
Date:   Tue, 17 Aug 2021 10:38:52 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Joseph <tjoseph@cadence.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH v8 6/8] PCI: cadence: Add support to configure virtual
 functions
Message-ID: <20210817153852.GA3016660@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811064656.15399-7-kishon@ti.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 11, 2021 at 12:16:54PM +0530, Kishon Vijay Abraham I wrote:
> Now that support for SR-IOV is added in PCIe endpoint core, add support
> to configure virtual functions in the Cadence PCIe EP driver.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../pci/controller/cadence/pcie-cadence-ep.c  | 136 +++++++++++++++---
>  drivers/pci/controller/cadence/pcie-cadence.h |   9 ++
>  2 files changed, 125 insertions(+), 20 deletions(-)

> @@ -92,21 +118,29 @@ static int cdns_pcie_ep_set_bar(struct pci_epc *epc, u8 fn, u8 vfn,
>  
>  	addr0 = lower_32_bits(bar_phys);
>  	addr1 = upper_32_bits(bar_phys);
> -	cdns_pcie_writel(pcie, CDNS_PCIE_AT_IB_EP_FUNC_BAR_ADDR0(fn, bar),
> -			 addr0);
> -	cdns_pcie_writel(pcie, CDNS_PCIE_AT_IB_EP_FUNC_BAR_ADDR1(fn, bar),
> -			 addr1);
>  
>  	reg = CDNS_PCIE_LM_EP_FUNC_BAR_CFG(bar, fn);
> +	if (vfn == 1)
> +		reg = CDNS_PCIE_LM_EP_VFUNC_BAR_CFG(bar, fn);

Seems sort of weird to compute "reg", then sometimes overwrite it, as
opposed to:

  if (vfn == 1)
    reg = CDNS_PCIE_LM_EP_VFUNC_BAR_CFG(bar, fn);
  else
    reg = CDNS_PCIE_LM_EP_FUNC_BAR_CFG(bar, fn);

Also slightly weird that "vfn" is basically used as a boolean, but
it's actually a u8 virtual function number.  I guess VF 1 is special
and not like the other VFs?

>  	b = (bar < BAR_4) ? bar : bar - BAR_4;
>  
> -	cfg = cdns_pcie_readl(pcie, reg);
> -	cfg &= ~(CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_APERTURE_MASK(b) |
> -		 CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(b));
> -	cfg |= (CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_APERTURE(b, aperture) |
> -		CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_CTRL(b, ctrl));
> -	cdns_pcie_writel(pcie, reg, cfg);
> +	if (vfn == 0 || vfn == 1) {
> +		cfg = cdns_pcie_readl(pcie, reg);
> +		cfg &= ~(CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_APERTURE_MASK(b) |
> +			 CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(b));
> +		cfg |= (CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_APERTURE(b, aperture) |
> +			CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_CTRL(b, ctrl));
> +		cdns_pcie_writel(pcie, reg, cfg);
> +	}
>  
> +	fn = cdns_pcie_get_fn_from_vfn(pcie, fn, vfn);
> +	cdns_pcie_writel(pcie, CDNS_PCIE_AT_IB_EP_FUNC_BAR_ADDR0(fn, bar),
> +			 addr0);
> +	cdns_pcie_writel(pcie, CDNS_PCIE_AT_IB_EP_FUNC_BAR_ADDR1(fn, bar),
> +			 addr1);
> +
> +	if (vfn > 0)
> +		epf = &epf->epf[vfn - 1];
>  	epf->epf_bar[bar] = epf_bar;
>  
>  	return 0;
> @@ -122,18 +156,25 @@ static void cdns_pcie_ep_clear_bar(struct pci_epc *epc, u8 fn, u8 vfn,
>  	u32 reg, cfg, b, ctrl;
>  
>  	reg = CDNS_PCIE_LM_EP_FUNC_BAR_CFG(bar, fn);
> +	if (vfn == 1)
> +		reg = CDNS_PCIE_LM_EP_VFUNC_BAR_CFG(bar, fn);

Similar recomputation of "reg".

>  	b = (bar < BAR_4) ? bar : bar - BAR_4;
>  
> -	ctrl = CDNS_PCIE_LM_BAR_CFG_CTRL_DISABLED;
> -	cfg = cdns_pcie_readl(pcie, reg);
> -	cfg &= ~(CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_APERTURE_MASK(b) |
> -		 CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(b));
> -	cfg |= CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_CTRL(b, ctrl);
> -	cdns_pcie_writel(pcie, reg, cfg);
> +	if (vfn == 0 || vfn == 1) {
> +		ctrl = CDNS_PCIE_LM_BAR_CFG_CTRL_DISABLED;
> +		cfg = cdns_pcie_readl(pcie, reg);
> +		cfg &= ~(CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_APERTURE_MASK(b) |
> +			 CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(b));
> +		cfg |= CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_CTRL(b, ctrl);
> +		cdns_pcie_writel(pcie, reg, cfg);
> +	}
