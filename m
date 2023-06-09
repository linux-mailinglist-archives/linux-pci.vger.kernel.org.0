Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7985072A163
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jun 2023 19:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjFIRjp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Jun 2023 13:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjFIRjp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Jun 2023 13:39:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17331B5;
        Fri,  9 Jun 2023 10:39:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A041665A69;
        Fri,  9 Jun 2023 17:39:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC02C433D2;
        Fri,  9 Jun 2023 17:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686332383;
        bh=BjBmi5dvVDfL4eANifiLaJ+b0e1ynq0rCl7TNY5H4N0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Z8kWRYHlLhrnNe4Jk1duaUAYu2RvNE9vnJfWWl7S84jq3lSfVChTV8WfIhWZXAa4h
         B5xcBvwP9ZGSnznI8aU4SoG69k5uK92JLJSHujMBLukkKgYPbQ226cX70cYHwhJc5c
         fjlmJtrZBknwi53/WPaDSS6Ov3npJs0WK9+v5bYwiuXvJvBuayYUuTmAcRNmsxOkUu
         FGyKGiDt7+abWdUlQmtBSTHdthAgwMUG8ENTr6WN0xeRMYlXSsj+QcuFYlrxw0cyEj
         HnHRCZmZypsbQ1trGqquC8cdK0XDtCoRbaDTA+dW+/9Y7WZYFNqnBevXv5DaXaO33C
         FzL4nvCknUHiw==
Date:   Fri, 9 Jun 2023 12:39:40 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Siddharth Vadapalli <s-vadapalli@ti.com>
Cc:     tjoseph@cadence.com, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com, nadeem@cadence.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, vigneshr@ti.com, srk@ti.com,
        nm@ti.com
Subject: Re: [PATCH v3] PCI: cadence: Fix Gen2 Link Retraining process
Message-ID: <20230609173940.GA1252506@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607091427.852473-1-s-vadapalli@ti.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 07, 2023 at 02:44:27PM +0530, Siddharth Vadapalli wrote:
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
> 
> Hello,
> 
> This patch is based on linux-next tagged next-20230606.
> 
> v2:
> https://lore.kernel.org/r/20230315070800.1615527-1-s-vadapalli@ti.com/
> Changes since v2:
> - Merge the cdns_pcie_host_training_complete() function with the
>   cdns_pcie_host_wait_for_link() function, as suggested by Bjorn
>   for the v2 patch.
> - Add dev_err() to notify when Link Training fails, since this is a
>   fatal error and proceeding from this point will almost always crash
>   the kernel.
> 
> v1:
> https://lore.kernel.org/r/20230102075656.260333-1-s-vadapalli@ti.com/
> Changes since v1:
> - Collect Reviewed-by tag from Vignesh Raghavendra.
> - Rebase on next-20230315.
> 
> Regards,
> Siddharth.
> 
>  .../controller/cadence/pcie-cadence-host.c    | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
> index 940c7dd701d6..70a5f581ff4f 100644
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
> @@ -80,8 +82,26 @@ static struct pci_ops cdns_pcie_host_ops = {
>  static int cdns_pcie_host_wait_for_link(struct cdns_pcie *pcie)
>  {
>  	struct device *dev = pcie->dev;
> +	unsigned long end_jiffies;
> +	u16 link_status;
>  	int retries;
>  
> +	/* Wait for link training to complete */
> +	end_jiffies = jiffies + LINK_RETRAIN_TIMEOUT;
> +	do {
> +		link_status = cdns_pcie_rp_readw(pcie, CDNS_PCIE_RP_CAP_OFFSET + PCI_EXP_LNKSTA);
> +		if (!(link_status & PCI_EXP_LNKSTA_LT))
> +			break;
> +		usleep_range(0, 1000);
> +	} while (time_before(jiffies, end_jiffies));
> +
> +	if (!(link_status & PCI_EXP_LNKSTA_LT)) {
> +		dev_info(dev, "Link training complete\n");
> +	} else {
> +		dev_err(dev, "Fatal! Link training incomplete\n");
> +		return -ETIMEDOUT;
> +	}

Can I have a brown paper bag, please?  I totally blew it here, and I'm
sorry.

You took my advice by combining this with the existing
cdns_pcie_host_wait_for_link(), but I think my advice was poor because
(a) now this additional wait is not clearly connected with the
erratum, and (b) it affects devices that don't have the erratum.

IIUC, this is all part of a workaround for the i2085 erratum.  The
original workaround, 4740b969aaf5 ("PCI: cadence: Retrain Link to work
around Gen2 training defect"), added this:

  if (!ret && rc->quirk_retrain_flag)
    ret = cdns_pcie_retrain(pcie);

I think the wait for link train to complete should also be in
cdns_pcie_retrain() so it's clearly connected with the quirk, which
also means we'd only do the wait for devices with the erratum.

Which is EXACTLY what your first patch did, and I missed it.  I am
very sorry.  I guess maybe I thought cdns_pcie_retrain() was a
general-purpose thing, but in fact it's only used for this quirk.

Bjorn
