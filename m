Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C26672464
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jan 2023 18:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjARRFC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Jan 2023 12:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjARRFB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Jan 2023 12:05:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFFFA5D3;
        Wed, 18 Jan 2023 09:05:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C3266B81DE3;
        Wed, 18 Jan 2023 17:04:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FEFFC433D2;
        Wed, 18 Jan 2023 17:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674061497;
        bh=rR4Df/erjWsP9GOk0L3bcywVdAHQZXw0SV5ORmLxzZ0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=aDzcpyZdaG3x7s6fAheRNzA6NiffEhz4slQEgEBhwtaleCVPKAyDxuN43JBXRKp9v
         2//s1Z8HnYz4bKzNnHp+g8a9OFfyWXACYmcFkFkY+R1nHmYz3eLHcmScnrlJovyd7j
         TwzMooDaHeKyyC7+GuQa63Xq0kE19j9kdcWfnXL+01j0M72DdzNvV4Y+7Cvbwy0gnw
         i7I6BEC2EMxY3och7sMWC1a/8ZUYiQhmRzpLzbTzYqrN8t+O92Mz4bWpv0JCPiFhnO
         nIiLxWK9gJLsEvjqT7lXYHRt6/sUERm7oGtVTKLRHnBdOpfkCYoyRIzrrG6vS9YKoI
         cSO25hKk7dl4A==
Date:   Wed, 18 Jan 2023 11:04:54 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Achal Verma <a-verma1@ti.com>
Cc:     Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Wilczy_ski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Milind Parab <mparab@cadence.com>, Jian Wang <jian-wang@ti.com>
Subject: Re: [PATCH] PCI: cadence: Fix next function value in case of ARI
Message-ID: <20230118170454.GA225634@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118072035.3381993-1-a-verma1@ti.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 18, 2023 at 12:50:35PM +0530, Achal Verma wrote:
> From: Jasko-EXT Wojciech <wojciech.jasko-EXT@continental-corporation.com>
> 
> Next function field in ARI_CAP_AND_CTR field register for last
> function should be zero but thats not the case, so this patch
> programs the next function field for last function as zero.

s/thats/that's/

When you fix the comment formatting, also update the commit log to be
imperative style and use the terms from the spec, e.g.,

  Clear the ARI Capability Next Function Number of the last function.

ARI_CAP_AND_CTR is a Cadence-specific name (and doesn't seem to appear
even in that driver).  The commit log should use the PCIe term.

See https://chris.beams.io/posts/git-commit/

> Signed-off-by: Jasko-EXT Wojciech <wojciech.jasko-EXT@continental-corporation.com>
> Signed-off-by: Achal Verma <a-verma1@ti.com>
> ---
>  drivers/pci/controller/cadence/pcie-cadence-ep.c | 15 ++++++++++++++-
>  drivers/pci/controller/cadence/pcie-cadence.h    |  6 ++++++
>  2 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> index b8b655d4047e..6b6904cf0123 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> @@ -565,7 +565,8 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
>  	struct cdns_pcie *pcie = &ep->pcie;
>  	struct device *dev = pcie->dev;
>  	int max_epfs = sizeof(epc->function_num_map) * 8;
> -	int ret, value, epf;
> +	int ret, epf, last_fn;
> +	u32 reg, value;
>  
>  	/*
>  	 * BIT(0) is hardwired to 1, hence function 0 is always enabled
> @@ -573,6 +574,18 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
>  	 */
>  	cdns_pcie_writel(pcie, CDNS_PCIE_LM_EP_FUNC_CFG, epc->function_num_map);
>  
> +	/* Setup ARI Next Function Number.
> +	 * This field should point to the next physical Function and 0 for
> +	 * last Function.
> +	 */
> +	last_fn = find_last_bit(&epc->function_num_map, BITS_PER_LONG);
> +	reg     = CDNS_PCIE_CORE_PF_I_ARI_CAP_AND_CTRL(last_fn);
> +
> +	// Clear Next Function Number for the last function used.
> +	value  = cdns_pcie_readl(pcie, reg);
> +	value &= ~CDNS_PCIE_ARI_CAP_NFN_MASK;
> +	cdns_pcie_writel(pcie, reg, value);
> +
>  	if (ep->quirk_disable_flr) {
>  		for (epf = 0; epf < max_epfs; epf++) {
>  			if (!(epc->function_num_map & BIT(epf)))
> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
> index 190786e47df9..68c4c7878111 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence.h
> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
> @@ -130,6 +130,12 @@
>  #define CDNS_PCIE_EP_FUNC_DEV_CAP_OFFSET	0xc0
>  #define CDNS_PCIE_EP_FUNC_SRIOV_CAP_OFFSET	0x200
>  
> +/*
> + * Endpoint PF Registers
> + */
> +#define CDNS_PCIE_CORE_PF_I_ARI_CAP_AND_CTRL(fn)	(0x144 + (fn) * 0x1000)
> +#define CDNS_PCIE_ARI_CAP_NFN_MASK	GENMASK(15, 8)
> +
>  /*
>   * Root Port Registers (PCI configuration space for the root port function)
>   */
> -- 
> 2.25.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
