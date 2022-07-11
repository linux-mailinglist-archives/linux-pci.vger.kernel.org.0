Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F5C570D3E
	for <lists+linux-pci@lfdr.de>; Tue, 12 Jul 2022 00:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbiGKWRK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Jul 2022 18:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbiGKWRH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jul 2022 18:17:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE984D808;
        Mon, 11 Jul 2022 15:17:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D24F0B815F2;
        Mon, 11 Jul 2022 22:17:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59DB9C34115;
        Mon, 11 Jul 2022 22:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657577823;
        bh=LeMBiK6cSKCyTxJXU5WNEF5uHlSrAnSLkUJ0VLW77JE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=eYfecfVE1/sXQNinaPOVLZRF3uMgkmyk0zOpvB/CwfoNblY6YXlT8CVq0QHMp2qQ9
         5fcEJACMt/rq7ZNOhtj1Yb7lWEDp+lu/R2l3QaKTNkeya26TFGfb0dMu3kuuwHLg9e
         4ico52S1bRqUCmsPSAXNMkuunVL6zCq/5UkDkP0fxvCRX+Pdiz7JgeXQorZyqw6jH/
         d1Xp/cqc5DdnOoA/U6VVG8h1KXaeTiev1YsEJtMPwcmMu9FlThl6h4TmcjweZoaUfA
         WKW3+0LRJMf5p1owpa1TUOSpXd4e/jiIgM65mswKIVq0nFC1PgfZdt6uwudrNtdFZS
         uxDkYKD1ib7Fg==
Date:   Mon, 11 Jul 2022 17:17:01 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     l.stach@pengutronix.de, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, festevam@gmail.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: Re: [RFC 1/2] PCI: imx6: Make sure the DBI register can be changed
Message-ID: <20220711221701.GA697090@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1652866528-13220-1-git-send-email-hongxing.zhu@nxp.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Richard,

On Wed, May 18, 2022 at 05:35:27PM +0800, Richard Zhu wrote:
> The PCIE_DBI_RO_WR_EN bit should be set when write some DBI registers.
> To make sure that the DBI registers are writable, set the
> PCIE_DBI_RO_WR_EN properly when touch the DBI registers.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 6619e3caffe2..30641d2dda14 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -797,10 +797,12 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
>  	 * started in Gen2 mode, there is a possibility the devices on the
>  	 * bus will not be detected at all.  This happens with PCIe switches.
>  	 */
> +	dw_pcie_dbi_ro_wr_en(pci);

What's the status of this patch?  I don't see this change included in
your v14 series [1].  That series has a lot of imx6 updates, so I
would have thought you'd include this change in it.  Or maybe this
change turned out not to be needed?

What about the 2/2 patch?

They're both marked "RFC" which is sometimes a hint that the author
isn't really committed to the patch, so sometimes they don't get the
attention they deserve.

Bjorn

[1] https://lore.kernel.org/r/1656645935-1370-1-git-send-email-hongxing.zhu@nxp.com

>  	tmp = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
>  	tmp &= ~PCI_EXP_LNKCAP_SLS;
>  	tmp |= PCI_EXP_LNKCAP_SLS_2_5GB;
>  	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, tmp);
> +	dw_pcie_dbi_ro_wr_dis(pci);
>  
>  	/* Start LTSSM. */
>  	imx6_pcie_ltssm_enable(dev);
> @@ -809,6 +811,7 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
>  
>  	if (pci->link_gen == 2) {
>  		/* Allow Gen2 mode after the link is up. */
> +		dw_pcie_dbi_ro_wr_en(pci);
>  		tmp = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
>  		tmp &= ~PCI_EXP_LNKCAP_SLS;
>  		tmp |= PCI_EXP_LNKCAP_SLS_5_0GB;
> @@ -821,6 +824,7 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
>  		tmp = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
>  		tmp |= PORT_LOGIC_SPEED_CHANGE;
>  		dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, tmp);
> +		dw_pcie_dbi_ro_wr_dis(pci);
>  
>  		if (imx6_pcie->drvdata->flags &
>  		    IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE) {
> -- 
> 2.25.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
