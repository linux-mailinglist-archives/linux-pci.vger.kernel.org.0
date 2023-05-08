Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718C36FB932
	for <lists+linux-pci@lfdr.de>; Mon,  8 May 2023 23:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjEHVOl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 May 2023 17:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEHVOl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 May 2023 17:14:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CC72D6D;
        Mon,  8 May 2023 14:14:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9314961291;
        Mon,  8 May 2023 21:14:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C491C433D2;
        Mon,  8 May 2023 21:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683580472;
        bh=jWub4IWG48Gsaolm6fXmh1ycf1a/5Scdx+4yFPZcW00=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=GF6W51HhTHWiSIE7AHwtk++3WSenLosbSXa3jXGt/quP7gw5o/gap1bBCkZT+11eL
         UPVYayUqW75s0c4mUNWSvr6pQ0w8qT7/Rk8pU9nVZv3LgcUZ1/GQNil6tupGrWXhaj
         +TJbS3H1jkCEt93+yFsQZr9J0dqiK28Cfup4dhSN1Wdu0uqxCckWU6x4LuG9XWDxbG
         lLOXZoHQUq2Ismy/hEyHQiO8lgiTtMnKNVo92ogja2C6+Hq0p2hXBZi8ktNHhAeg/m
         eUsSXtfVIya6QO+eFkrbt6MqcyaQdVYBq29Z5Rf3wxmUujRTFj4DVpgPilGtnRnfki
         KFydTMNZZwNKg==
Date:   Mon, 8 May 2023 16:14:30 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Siddharth Vadapalli <s-vadapalli@ti.com>
Cc:     tjoseph@cadence.com, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com, nadeem@cadence.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, vigneshr@ti.com, srk@ti.com,
        nm@ti.com
Subject: Re: [PATCH v2] PCI: cadence: Fix Gen2 Link Retraining process
Message-ID: <20230508211430.GA1185556@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315070800.1615527-1-s-vadapalli@ti.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 15, 2023 at 12:38:00PM +0530, Siddharth Vadapalli wrote:
> The Link Retraining process is initiated to account for the Gen2 defect in
> the Cadence PCIe controller in J721E SoC. The errata corresponding to this
> is i2085, documented at:
> https://www.ti.com/lit/er/sprz455c/sprz455c.pdf
> 
> The existing workaround implemented for the errata waits for the Data Link
> initialization to complete and assumes that the link retraining process
> at the Physical Layer has completed. However, it is possible that the
> Physical Layer training might be ongoing as indicated by the
> PCI_EXP_LNKSTA_LT bit in the PCI_EXP_LNKSTA register.
> 
> Fix the existing workaround, to ensure that the Physical Layer training
> has also completed, in addition to the Data Link initialization.
> 
> Fixes: 4740b969aaf5 ("PCI: cadence: Retrain Link to work around Gen2 training defect")
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
> Changes from v1:
> 1. Collect Reviewed-by tag from Vignesh Raghavendra.
> 2. Rebase on next-20230315.
> 
> v1:
> https://lore.kernel.org/r/20230102075656.260333-1-s-vadapalli@ti.com
> 
>  .../controller/cadence/pcie-cadence-host.c    | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
> index 940c7dd701d6..5b14f7ee3c79 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
> @@ -12,6 +12,8 @@
>  
>  #include "pcie-cadence.h"
>  
> +#define LINK_RETRAIN_TIMEOUT HZ
> +
>  static u64 bar_max_size[] = {
>  	[RP_BAR0] = _ULL(128 * SZ_2G),
>  	[RP_BAR1] = SZ_2G,
> @@ -77,6 +79,27 @@ static struct pci_ops cdns_pcie_host_ops = {
>  	.write		= pci_generic_config_write,
>  };
>  
> +static int cdns_pcie_host_training_complete(struct cdns_pcie *pcie)

This is kind of weird because it's named like a predicate, i.e., "this
function tells me whether link training is complete", but it returns
*zero* for success.

This is the opposite of j721e_pcie_link_up(), which returns "true"
when the link is up, so code like this reads naturally:

  if (pcie->ops->link_up(pcie))
    /* do something if the link is up */

> +{
> +	u32 pcie_cap_off = CDNS_PCIE_RP_CAP_OFFSET;
> +	unsigned long end_jiffies;
> +	u16 lnk_stat;
> +
> +	/* Wait for link training to complete. Exit after timeout. */
> +	end_jiffies = jiffies + LINK_RETRAIN_TIMEOUT;
> +	do {
> +		lnk_stat = cdns_pcie_rp_readw(pcie, pcie_cap_off + PCI_EXP_LNKSTA);
> +		if (!(lnk_stat & PCI_EXP_LNKSTA_LT))
> +			break;
> +		usleep_range(0, 1000);
> +	} while (time_before(jiffies, end_jiffies));
> +
> +	if (!(lnk_stat & PCI_EXP_LNKSTA_LT))
> +		return 0;
> +
> +	return -ETIMEDOUT;
> +}
> +
>  static int cdns_pcie_host_wait_for_link(struct cdns_pcie *pcie)
>  {
>  	struct device *dev = pcie->dev;
> @@ -118,6 +141,10 @@ static int cdns_pcie_retrain(struct cdns_pcie *pcie)
>  		cdns_pcie_rp_writew(pcie, pcie_cap_off + PCI_EXP_LNKCTL,
>  				    lnk_ctl);
>  
> +		ret = cdns_pcie_host_training_complete(pcie);
> +		if (ret)
> +			return ret;
> +
>  		ret = cdns_pcie_host_wait_for_link(pcie);

It seems a little clumsy that we wait for two things in succession:

  - cdns_pcie_host_training_complete() waits up to 1s for
    PCI_EXP_LNKSTA_LT to be cleared

  - cdns_pcie_host_wait_for_link() waits between .9s and 1s for
    LINK_UP_DL_COMPLETED on j721e (and not at all for other platforms)

dw_pcie_wait_for_link() is basically similar but has a single wait
loop around the dw_pcie_link_up() callback.  Several of those
callbacks check multiple things.  Can we do the same here?

Is the "host" in the cdns_pcie_host_wait_for_link() name necessary?
Maybe it could be cdns_pcie_wait_for_link() to be similar to
dw_pcie_wait_for_link()?  Or, if "host" is necessary, it could be
cdns_host_pcie_wait_for_link() so it matches the same
"pcie_wait_for_link" grep pattern as most of the others?

>  	}
>  	return ret;
