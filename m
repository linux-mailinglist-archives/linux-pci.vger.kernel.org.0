Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9D857BF77
	for <lists+linux-pci@lfdr.de>; Wed, 20 Jul 2022 23:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiGTVPq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Jul 2022 17:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiGTVPq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jul 2022 17:15:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF6CF9;
        Wed, 20 Jul 2022 14:15:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5627DB82212;
        Wed, 20 Jul 2022 21:15:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9400C3411E;
        Wed, 20 Jul 2022 21:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658351742;
        bh=ZpNkOSMPAfkKEWZACJr/Tkb3FVhA3U+BTFn0qmGbIRg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=alDqw4kBG5nEBs0dMlkhwRXCfJNIpUUjxFmniRZHlMWYL95Nt/JKxGcvOBDxigVjV
         Ffh+wYmsB0cpd2Q1uqp0wDsWfQJenmVYo8CfZCw4L1al53HjZ/tMC9iR13v98HJCeY
         5hfm6ai6bGjbX6UTIKiEZACCy7K3U+8DyENlvdataU3Zm0Zlo0iR0k8FHFspQo7tAS
         ZGKfQ7+1IytzT+by+vRBDWEG8Ru2WLDVEdF19ucbc/15lk0byfAsl5XmDAnBINvBSR
         CIPhD+qr6nDw9Kxjp+xlYCTnn62+y6jNFX8VlUtgsLEQPidIVF8SexReWVujZWd8C8
         g6v9ndb+qhZQA==
Date:   Wed, 20 Jul 2022 16:15:41 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     l.stach@pengutronix.de, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, tharvey@gateworks.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: Re: [PATCH v2] PCI: imx6: Support more than Gen2 speed link mode
Message-ID: <20220720211541.GA1658730@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1658287576-26908-1-git-send-email-hongxing.zhu@nxp.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 20, 2022 at 11:26:16AM +0800, Richard Zhu wrote:
> Support more than Gen2 speed link mode, since i.MX8MP PCIe supports up to
> Gen3 link speed.
> 
> Link: https://lore.kernel.org/r/1652866528-13220-2-git-send-email-hongxing.zhu@nxp.com
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

You should not post patches with my signed-off-by.

I add my signed-off-by to patches when I merge them.

I applied this to pci/ctrl/imx6, replacing the v1 patch, thanks!

> ---
> Changes from v1:
> - The Supported Link Speeds of the PCI_EXP_LNKCAP should be re-configured too.
> - When only Gen1 is enabled, refine the dev_info accordingly.
> 
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index e1ba11dabaa8..b66876f7efe0 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -844,12 +844,12 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
>  	if (ret)
>  		goto err_reset_phy;
>  
> -	if (pci->link_gen == 2) {
> -		/* Allow Gen2 mode after the link is up. */
> +	if (pci->link_gen > 1) {
> +		/* Allow faster modes after the link is up */
>  		dw_pcie_dbi_ro_wr_en(pci);
>  		tmp = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
>  		tmp &= ~PCI_EXP_LNKCAP_SLS;
> -		tmp |= PCI_EXP_LNKCAP_SLS_5_0GB;
> +		tmp |= pci->link_gen;
>  		dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, tmp);
>  
>  		/*
> @@ -884,7 +884,7 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
>  		if (ret)
>  			goto err_reset_phy;
>  	} else {
> -		dev_info(dev, "Link: Gen2 disabled\n");
> +		dev_info(dev, "Link: Only Gen1 is enabled\n");
>  	}
>  
>  	imx6_pcie->link_is_up = true;
> -- 
> 2.25.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
