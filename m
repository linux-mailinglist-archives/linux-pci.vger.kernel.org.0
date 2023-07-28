Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140ED766776
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jul 2023 10:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbjG1IoS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Jul 2023 04:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234705AbjG1IoA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Jul 2023 04:44:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8B426A0;
        Fri, 28 Jul 2023 01:44:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7B6862059;
        Fri, 28 Jul 2023 08:43:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD4DC433C7;
        Fri, 28 Jul 2023 08:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690533839;
        bh=DYMtYTNvDKC5KRhCogEBmpaDtd8JRR359LeDXZ9iM48=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QIxRIOr5Z1UDrUiRM512S6uSDlpPhpjbhKOmPnbce0sdsm9kFJEzI/DJCW4YFT/TP
         Wfvo04EQDbW0W7EbK5+OzGv2eccd1yUKsDH4+IWnYZ7j5s+nGMGJKfjE9ym4MVH0wl
         demDedVaiHAVja/xRgwSwJiA5h9tbaokbs2HnmRJMyQfeohFEvgUgT0MAD2lLmG+np
         1XEwCR/eCe9cZk7vLcCUB9LvYJwEy8+um+MLECJ40RnVB3NmFezDrBN8RAY5KD4+Nw
         mwFbVgFlmYb5AE5/G3DBts+hIm/3zl3yjSAAzD2Uzn3V2tEEtj1OROat/hLsKKhrLl
         F4kILnY234dfA==
Date:   Fri, 28 Jul 2023 10:43:51 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jim Quinlan <jim2101024@gmail.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 3/5] PCI: brcmstb: Set higher value for internal bus
 timeout
Message-ID: <ZMN/x+Iuac6qLSnd@lpieralisi>
References: <20230623144100.34196-1-james.quinlan@broadcom.com>
 <20230623144100.34196-4-james.quinlan@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623144100.34196-4-james.quinlan@broadcom.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 23, 2023 at 10:40:56AM -0400, Jim Quinlan wrote:
> During long periods of the PCIe RC HW being in an L1SS sleep state, there
> may be a timeout on an internal bus access, even though there may not be
> any PCIe access involved.  Such a timeout will cause a subsequent CPU
> abort.
> 
> So, when "brcm,enable-l1ss" is observed, we increase the timeout value to
> four seconds instead of using its HW default.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> Tested-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index d30636a725d7..fe0415a98c63 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -1034,6 +1034,21 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
>  	return 0;
>  }
>  
> +/*
> + * This extends the timeout period for an access to an internal bus.  This
> + * access timeout may occur during L1SS sleep periods even without the
> + * presence of a PCIe access.
> + */
> +static void brcm_extend_rbus_timeout(struct brcm_pcie *pcie)
> +{
> +	/* TIMEOUT register is two registers before RGR1_SW_INIT_1 */
> +	const unsigned int REG_OFFSET = PCIE_RGR1_SW_INIT_1(pcie) - 8;

Nit: you could define an offset for the TIMEOUT register, if that makes
it any cleaner, up to you.

> +	u32 timeout_us = 4000000; /* 4 seconds, our setting for L1SS */

It would be useful to describe why this has to be 4 seconds in case
someone in the future will have to change it.

Thanks,
Lorenzo

> +	/* Each unit in timeout register is 1/216,000,000 seconds */
> +	writel(216 * timeout_us, pcie->base + REG_OFFSET);
> +}
> +
>  static void brcm_config_clkreq(struct brcm_pcie *pcie)
>  {
>  	bool l1ss = of_property_read_bool(pcie->np, "brcm,enable-l1ss");
> @@ -1059,6 +1074,7 @@ static void brcm_config_clkreq(struct brcm_pcie *pcie)
>  		 * of 400ns, as specified in 3.2.5.2.2 of the PCI Express
>  		 * Mini CEM 2.0 specification.
>  		 */
> +		brcm_extend_rbus_timeout(pcie);
>  		clkreq_set |= PCIE_MISC_HARD_PCIE_HARD_DEBUG_L1SS_ENABLE_MASK;
>  		dev_info(pcie->dev, "bi-dir CLKREQ# for L1SS power savings");
>  	} else {
> -- 
> 2.17.1
> 


