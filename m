Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3015725B88
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jun 2023 12:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239354AbjFGKXf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Jun 2023 06:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233837AbjFGKXd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Jun 2023 06:23:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3944A1BD7;
        Wed,  7 Jun 2023 03:23:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA7D363D54;
        Wed,  7 Jun 2023 10:23:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 692A0C433D2;
        Wed,  7 Jun 2023 10:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686133411;
        bh=TNIgjcq56ZRDkdSGzMWMs6K5wEwgg10X47XgM2HsqZU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eEhM7wFquqbYVy9hJvmw6p/m8vmK3oiK0QX71oZ1jF4DzN91SwoiQhiVHL76lgj8J
         FufTiPtOr5VeHU0ltMKxaQ9RcNivLi0jEq1szZpcxqc8oNKYhZISk2YU7ABzVDGLhx
         16cAM0mA9RSeV4Y0I+zvK/Atmt4sWftFCu6f8oXjk+OQ+gw0F+pxbJPW8zsuoku1tf
         IXB/w1/9n1yRkl4/lcB2G/cAdPC6wwGt1I0nbtUr20hTzG+c+S8HKndhx9VUljFa4S
         Qv0CzK/na9L+dCKb8njZriyslS7BE5NzaY9DowafFWESdoAZJ/kzoduZ0n8WG/MddV
         ApxCWSXg6xnFw==
Date:   Wed, 7 Jun 2023 12:23:25 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Siddharth Vadapalli <s-vadapalli@ti.com>
Cc:     tjoseph@cadence.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, nadeem@cadence.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        vigneshr@ti.com, srk@ti.com, nm@ti.com
Subject: Re: [PATCH v3] PCI: cadence: Fix Gen2 Link Retraining process
Message-ID: <ZIBanRGGPeFw90NZ@lpieralisi>
References: <20230607091427.852473-1-s-vadapalli@ti.com>
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

You can use a bool variable eg link_trained and use that below.

> +		usleep_range(0, 1000);
> +	} while (time_before(jiffies, end_jiffies));
> +
> +	if (!(link_status & PCI_EXP_LNKSTA_LT)) {
> +		dev_info(dev, "Link training complete\n");
> +	} else {
> +		dev_err(dev, "Fatal! Link training incomplete\n");
> +		return -ETIMEDOUT;
> +	}

I don't necessarily see the reason why you are adding additional
logging, more so given that this now does not affect just the
workaround but all cadence controllers.

Actually, is that something you have tested and considered ?

Thanks,
Lorenzo

> +
>  	/* Check if the link is up or not */
>  	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
>  		if (cdns_pcie_link_up(pcie)) {
> -- 
> 2.25.1
> 
