Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73871752C48
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jul 2023 23:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbjGMVj6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jul 2023 17:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjGMVj5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jul 2023 17:39:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE691FC0;
        Thu, 13 Jul 2023 14:39:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6795361B6C;
        Thu, 13 Jul 2023 21:39:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AC2EC433C7;
        Thu, 13 Jul 2023 21:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689284395;
        bh=fJgb0wn8cM5E3LZjSiMmJS/ati1UElaHXC724dGS2pA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=HIWRKduB/7c1UiEq4oBIcRWc4NvMCDFYMLfNvcdRy+kMqwMVH9YcNAkuQTCHzd3h9
         g5CmzktmSrO1iQ9qYYHC5NceVQQTrdp2T5JcjnrcyzEbQRJbRGhUtQaJFhBr9INqXD
         TF43nE0Qps0DEH+ulexMu7W07KLV85vM+GGG+SMAu/nAWUUt2WXpsG+PJTXL8PrNLa
         DZnQ/4a34qYMgAfnjyntrPoXJMuku9E1kFCeB7bPlaqar9VOwlw5ZWNYDPTsVv9VY1
         SVuKGmb4o/9YTpzs5cw9nBJ0GzrmMfKosdiMBIPvqYH8ctFkwhL9Yo7VDd7EgXXC1J
         DlOdT4tB3Inrg==
Date:   Thu, 13 Jul 2023 16:39:53 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, Sergey.Semin@baikalelectronics.ru,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V3] Revert "PCI: tegra194: Enable support for 256 Byte
 payload"
Message-ID: <20230713213953.GA331829@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619102604.3735001-1-vidyas@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 19, 2023 at 03:56:04PM +0530, Vidya Sagar wrote:
> This reverts commit 4fb8e46c1bc4 ("PCI: tegra194: Enable
> support for 256 Byte payload").
> 
> Consider a PCIe hierarchy with a PCIe switch and a device connected
> downstream of the switch that has support for MPS which is the minimum in
> the hierarchy, and root port programmed with an MPS in its DevCtl register
> that is greater than the minimum. In this scenario, the default bus
> configuration of the kernel i.e. "PCIE_BUS_DEFAULT" doesn't configure the
> MPS settings in the hierarchy correctly resulting in the device with
> support for minimum MPS in the hierarchy receiving the TLPs of size more
> than that. Although this can be addressed by appending "pci=pcie_bus_safe"
> to the kernel command line, it doesn't seem to be a good idea to always
> have this commandline argument even for the basic functionality to work.

I think this has some irrelevant detail (IIUC the problem should
happen even without a switch) and could be more specific (I think the
problem case is RP MPS=256, EP only supports MPS=128).

> Reverting commit 4fb8e46c1bc4 ("PCI: tegra194: Enable support for 256
> Byte payload") avoids this requirement and ensures that the basic
> functionality of the devices irrespective of the hierarchy and the MPS of
> the devices in the hierarchy.

"Ensure" is a transitive verb, so "... ensures that the basic
functionality ..." is missing whatever the object should be.

Maybe something like the following?

  After 4fb8e46c1bc4 ("PCI: tegra194: Enable support for 256 Byte
  payload"), we set MPS=256 for tegra194 Root Ports.

  By default (CONFIG_PCIE_BUS_DEFAULT set and no "pci=pcie_bus_*"
  parameter), Linux configures the MPS of every device to match the
  upstream bridge, which is impossible if the Root Port has MPS=256
  and a device only supports MPS=128.

  This scenario results in uncorrectable Malformed TLP errors if the
  Root Port sends TLPs with payloads larger than 128 bytes.  These
  errors can be avoided by using the "pci=pcie_bus_safe" parameter,
  but it doesn't seem to be a good idea to always have this parameter
  even for basic functionality to work.

  Revert 4fb8e46c1bc4 ("PCI: tegra194: Enable support for 256 Byte
  payload") so the Root Ports default to MPS=128, which all devices
  support.

  If peer-to-peer DMA is not required, one can use "pci=pcie_bus_perf" 
  to get the benefit of larger MPS settings.

> To reap the benefits of having support for higher MPS, optionally, one can
> always append the kernel command line with "pci=pcie_bus_perf".
> 
> Fixes: 4fb8e46c1bc4 ("PCI: tegra194: Enable support for 256 Byte payload")
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
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
