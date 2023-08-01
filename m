Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDAE76BE93
	for <lists+linux-pci@lfdr.de>; Tue,  1 Aug 2023 22:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbjHAUkU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Aug 2023 16:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjHAUkT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Aug 2023 16:40:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A8418D;
        Tue,  1 Aug 2023 13:40:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26730616CA;
        Tue,  1 Aug 2023 20:40:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CF66C433C8;
        Tue,  1 Aug 2023 20:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690922417;
        bh=Qk0jErerHl/harcMzMcc3VfUky6x5Mflzj5HbZTXslI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=o5Qh/RHEjFsOWShDVGHcoBOiJVuHpYrrKGo3SS3qIUy0d3CX6scMm8DELo3na94Iq
         XEuthhBca/Ah3Y3ppAMrkgX/2SLQIIylvi+p3DeiI7qulQbVmeqfgn6dcFb1ZkX6PQ
         zTcIuQfrGIxvquZYngmzIdF/Zidwluc1xhquzR+2f74ZndojtdsQ74Smp3RZT6pdP9
         ulA7IwBpwpBsXHlrsD0326qvsvn041Bk1mi4ewwbu21Pp+CnA3kY7YYMgQhf3dDzR8
         PuUzXcLc6zqUxE3FBGF7F2BUAFgvg/4YFkVl5fL0/FFfZ/z+kOpLCR2MPQD88JQ4tw
         SxWE5Uq/7e3EA==
Date:   Tue, 1 Aug 2023 15:40:15 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, Sergey.Semin@baikalelectronics.ru,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V4] Revert "PCI: tegra194: Enable support for 256 Byte
 payload"
Message-ID: <20230801204015.GA49719@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718025221.4001329-1-vidyas@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 18, 2023 at 08:22:21AM +0530, Vidya Sagar wrote:
> After commit 4fb8e46c1bc4 ("PCI: tegra194: Enable support for 256 Byte
> payload"), we set MPS=256 for tegra194 Root Ports.
> 
> By default (CONFIG_PCIE_BUS_DEFAULT set and no "pci=pcie_bus_*"
> parameter), Linux configures the MPS of every device to match the
> upstream bridge, which is impossible if the Root Port has MPS=256
> and a device only supports MPS=128.

Thanks for pointing out that I broke this log by omitting the mention
of a switch.  Is the rewording below better?  If so, Krzysztof can
amend the commit.

  After commit 4fb8e46c1bc4 ("PCI: tegra194: Enable support for 256 Byte
  payload"), we initialize MPS=256 for tegra194 Root Ports before enumerating
  the hierarchy.

  Consider an Endpoint that supports only MPS=128.  In the default situation
  (CONFIG_PCIE_BUS_DEFAULT set and no "pci=pcie_bus_*" parameter), Linux
  tries to configure the MPS of every device to match the upstream bridge.
  If the Endpoint is directly below the Root Port, Linux can reduce the Root
  Port MPS to 128 to match the Endpoint.  But if there's a switch in the
  middle, Linux doesn't reduce the Root Port MPS because other devices below
  the switch may already be configured with MPS larger than 128.

> This scenario results in uncorrectable Malformed TLP errors if the
> Root Port sends TLPs with payloads larger than 128 bytes.  These
> errors can be avoided by using the "pci=pcie_bus_safe" parameter,
> but it doesn't seem to be a good idea to always have this parameter
> even for basic functionality to work.
> 
> Revert commit 4fb8e46c1bc4 ("PCI: tegra194: Enable support for 256 Byte
> payload") so the Root Ports default to MPS=128, which all devices
> support.
> 
> If peer-to-peer DMA is not required, one can use "pci=pcie_bus_perf"
> to get the benefit of larger MPS settings.
> 
> [ rewrote commit message based on Bjorn's suggestion ]
> 
> Fixes: 4fb8e46c1bc4 ("PCI: tegra194: Enable support for 256 Byte payload")

4fb8e46c1bc4 appeared in v6.0-rc1, so this wouldn't be a candidate for
v6.5, but it does sound like it should be tagged for stable?  If so,
Krzysztof can probably add that as well.

> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> V4:
> * Rewrote commit message based on Bjorn's suggestion
> 
> V3:
> * Fixed a build issue
> 
> V2:
> * Addressed review comments from Bjorn
> 
>  drivers/pci/controller/dwc/pcie-tegra194.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 4fdadc7b045f..a772faff14b5 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -900,11 +900,6 @@ static int tegra_pcie_dw_host_init(struct dw_pcie_rp *pp)
>  		pcie->pcie_cap_base = dw_pcie_find_capability(&pcie->pci,
>  							      PCI_CAP_ID_EXP);
>  
> -	val_16 = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_DEVCTL);
> -	val_16 &= ~PCI_EXP_DEVCTL_PAYLOAD;
> -	val_16 |= PCI_EXP_DEVCTL_PAYLOAD_256B;
> -	dw_pcie_writew_dbi(pci, pcie->pcie_cap_base + PCI_EXP_DEVCTL, val_16);
> -
>  	val = dw_pcie_readl_dbi(pci, PCI_IO_BASE);
>  	val &= ~(IO_BASE_IO_DECODE | IO_BASE_IO_DECODE_BIT8);
>  	dw_pcie_writel_dbi(pci, PCI_IO_BASE, val);
> @@ -1756,7 +1751,6 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
>  	struct device *dev = pcie->dev;
>  	u32 val;
>  	int ret;
> -	u16 val_16;
>  
>  	if (pcie->ep_state == EP_STATE_ENABLED)
>  		return;
> @@ -1887,20 +1881,16 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
>  	pcie->pcie_cap_base = dw_pcie_find_capability(&pcie->pci,
>  						      PCI_CAP_ID_EXP);
>  
> -	val_16 = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_DEVCTL);
> -	val_16 &= ~PCI_EXP_DEVCTL_PAYLOAD;
> -	val_16 |= PCI_EXP_DEVCTL_PAYLOAD_256B;
> -	dw_pcie_writew_dbi(pci, pcie->pcie_cap_base + PCI_EXP_DEVCTL, val_16);
> -
>  	/* Clear Slot Clock Configuration bit if SRNS configuration */
>  	if (pcie->enable_srns) {
> +		u16 val_16;
> +
>  		val_16 = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base +
>  					   PCI_EXP_LNKSTA);
>  		val_16 &= ~PCI_EXP_LNKSTA_SLC;
>  		dw_pcie_writew_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA,
>  				   val_16);
>  	}
> -
>  	clk_set_rate(pcie->core_clk, GEN4_CORE_CLK_FREQ);
>  
>  	val = (ep->msi_mem_phys & MSIX_ADDR_MATCH_LOW_OFF_MASK);
> -- 
> 2.25.1
> 
