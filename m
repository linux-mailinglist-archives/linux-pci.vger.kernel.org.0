Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB7C3EEF18
	for <lists+linux-pci@lfdr.de>; Tue, 17 Aug 2021 17:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbhHQPYr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Aug 2021 11:24:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:35682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230369AbhHQPYr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Aug 2021 11:24:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B26260E09;
        Tue, 17 Aug 2021 15:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629213853;
        bh=boESYlKP6Dzc4kd2waJ3e/ZWnK8Fx6T1LIWvj2HxkX0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=EpWj8XfYMjFSu2H8qmW6GSRSZCbozXwNvPJfpEG4eQ1z9d04wBrDrqXBF8I9GNF2k
         Ta4QvsAOu8r7nRtDyMyIf8L/NVqvWoZ1uVcVBFL0/S0ytfoMnJJ7F76yN7AgufdA0O
         H3RhqE1bxS1sJlexjF1FOD+jdXOGIcqaoo9YmX9hpbSmOws+jkn3KazRNZezn84yre
         t2ftnIQsY0LKW1OKCLR8Q235J6Gr9pLTM78wUHt7KqlktfW/17w/esI6Fbieqg27G7
         jQZseaAs1BJW5iGLCL/64Tmp2chXv2j+xWUIqg83n5wpnf6VIBcP12IEKGPxN5FAFr
         W3SycQVB2gYAw==
Date:   Tue, 17 Aug 2021 10:24:12 -0500
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
Subject: Re: [PATCH v8 5/8] PCI: cadence: Simplify code to get register base
 address for configuring BAR
Message-ID: <20210817152412.GA3016169@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811064656.15399-6-kishon@ti.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 11, 2021 at 12:16:53PM +0530, Kishon Vijay Abraham I wrote:
> No functional change. Simplify code to get register base address for
> configuring PCI BAR.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../pci/controller/cadence/pcie-cadence-ep.c   | 18 ++++--------------
>  drivers/pci/controller/cadence/pcie-cadence.h  |  2 ++
>  2 files changed, 6 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> index 912a15be8bfd..f337f0842400 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> @@ -97,13 +97,8 @@ static int cdns_pcie_ep_set_bar(struct pci_epc *epc, u8 fn, u8 vfn,
>  	cdns_pcie_writel(pcie, CDNS_PCIE_AT_IB_EP_FUNC_BAR_ADDR1(fn, bar),
>  			 addr1);
>  
> -	if (bar < BAR_4) {
> -		reg = CDNS_PCIE_LM_EP_FUNC_BAR_CFG0(fn);
> -		b = bar;
> -	} else {
> -		reg = CDNS_PCIE_LM_EP_FUNC_BAR_CFG1(fn);
> -		b = bar - BAR_4;
> -	}
> +	reg = CDNS_PCIE_LM_EP_FUNC_BAR_CFG(bar, fn);
> +	b = (bar < BAR_4) ? bar : bar - BAR_4;
>  
>  	cfg = cdns_pcie_readl(pcie, reg);
>  	cfg &= ~(CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_APERTURE_MASK(b) |
> @@ -126,13 +121,8 @@ static void cdns_pcie_ep_clear_bar(struct pci_epc *epc, u8 fn, u8 vfn,
>  	enum pci_barno bar = epf_bar->barno;
>  	u32 reg, cfg, b, ctrl;
>  
> -	if (bar < BAR_4) {
> -		reg = CDNS_PCIE_LM_EP_FUNC_BAR_CFG0(fn);
> -		b = bar;
> -	} else {
> -		reg = CDNS_PCIE_LM_EP_FUNC_BAR_CFG1(fn);
> -		b = bar - BAR_4;
> -	}
> +	reg = CDNS_PCIE_LM_EP_FUNC_BAR_CFG(bar, fn);
> +	b = (bar < BAR_4) ? bar : bar - BAR_4;
>  
>  	ctrl = CDNS_PCIE_LM_BAR_CFG_CTRL_DISABLED;
>  	cfg = cdns_pcie_readl(pcie, reg);
> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
> index 30db2d68c17a..d5b1fcf2c39d 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence.h
> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
> @@ -46,6 +46,8 @@
>  #define  CDNS_PCIE_LM_EP_ID_BUS_SHIFT	8
>  
>  /* Endpoint Function f BAR b Configuration Registers */
> +#define CDNS_PCIE_LM_EP_FUNC_BAR_CFG(bar, fn) \
> +	(((bar) < 4) ? CDNS_PCIE_LM_EP_FUNC_BAR_CFG0(fn) : CDNS_PCIE_LM_EP_FUNC_BAR_CFG1(fn))

Why do we use "BAR_4" above and "4" here?  Shouldn't they look the
same?

>  #define CDNS_PCIE_LM_EP_FUNC_BAR_CFG0(fn) \
>  	(CDNS_PCIE_LM_BASE + 0x0240 + (fn) * 0x0008)
>  #define CDNS_PCIE_LM_EP_FUNC_BAR_CFG1(fn) \
> -- 
> 2.17.1
> 
