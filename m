Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACC70116BAE
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2019 12:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbfLILDS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Dec 2019 06:03:18 -0500
Received: from foss.arm.com ([217.140.110.172]:56290 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726297AbfLILDS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Dec 2019 06:03:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 965571FB;
        Mon,  9 Dec 2019 03:03:17 -0800 (PST)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D6EF3F6CF;
        Mon,  9 Dec 2019 03:03:16 -0800 (PST)
Date:   Mon, 9 Dec 2019 11:03:15 +0000
From:   Andrew Murray <andrew.murray@arm.com>
To:     Remi Pommarel <repk@triplefau.lt>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Yue Wang <yue.wang@Amlogic.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: amlogic: Use PCIe pll gate when available
Message-ID: <20191209110314.GQ18399@e119886-lin.cambridge.arm.com>
References: <20191208210320.15539-1-repk@triplefau.lt>
 <20191208210320.15539-3-repk@triplefau.lt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191208210320.15539-3-repk@triplefau.lt>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Dec 08, 2019 at 10:03:20PM +0100, Remi Pommarel wrote:
> In order to get PCIe working reliably on some AXG platforms, PCIe pll
> cml needs to be enabled. This is done by using the PCIE_PLL_CML_ENABLE
> clock gate.

s/cml/CML/

In addition to Jerome's feedback - it would also be helpful to explain
when CML outputs should be enabled, i.e. which platforms and why those
ones?

> 
> This clock gate is optional, so do not fail if it is missing in the
> devicetree.

If certain platforms require PCIE_PLL_CML_ENABLE to work reliably and
thus the clock is specified in the device tree - then surely if there
is an error in enabling the clock we should fail? I.e. should you only
ignore -ENOENT here?

Thanks,

Andrew Murray

> 
> Signed-off-by: Remi Pommarel <repk@triplefau.lt>
> ---
>  drivers/pci/controller/dwc/pci-meson.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
> index 3772b02a5c55..32b70ea9a426 100644
> --- a/drivers/pci/controller/dwc/pci-meson.c
> +++ b/drivers/pci/controller/dwc/pci-meson.c
> @@ -89,6 +89,7 @@ struct meson_pcie_clk_res {
>  	struct clk *mipi_gate;
>  	struct clk *port_clk;
>  	struct clk *general_clk;
> +	struct clk *pll_cml_gate;
>  };
>  
>  struct meson_pcie_rc_reset {
> @@ -300,6 +301,10 @@ static int meson_pcie_probe_clocks(struct meson_pcie *mp)
>  	if (IS_ERR(res->clk))
>  		return PTR_ERR(res->clk);
>  
> +	res->pll_cml_gate = meson_pcie_probe_clock(dev, "pll_cml_en", 0);
> +	if (IS_ERR(res->pll_cml_gate))
> +		res->pll_cml_gate = NULL;
> +
>  	return 0;
>  }
>  
> -- 
> 2.24.0
> 
