Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF145B68C6
	for <lists+linux-pci@lfdr.de>; Tue, 13 Sep 2022 09:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiIMHj1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Sep 2022 03:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiIMHj1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Sep 2022 03:39:27 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF1F58097
        for <linux-pci@vger.kernel.org>; Tue, 13 Sep 2022 00:39:24 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1oY0Vc-00046v-Sy; Tue, 13 Sep 2022 09:39:04 +0200
Message-ID: <0660fff6d29c5f8251ac4f28d4badcfea91e6833.camel@pengutronix.de>
Subject: Re: [PATCH] PCI: imx6: Fix wrong check in imx6_pcie_attach_pd()
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Tang Bin <tangbin@cmss.chinamobile.com>, hongxing.zhu@nxp.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        shawnguo@kernel.org, bhelgaas@google.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 13 Sep 2022 09:39:03 +0200
In-Reply-To: <20220913065910.15348-1-tangbin@cmss.chinamobile.com>
References: <20220913065910.15348-1-tangbin@cmss.chinamobile.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am Dienstag, dem 13.09.2022 um 14:59 +0800 schrieb Tang Bin:
> In the function imx6_pcie_attach_pd(),
> dev_pm_domain_attach_by_name() may return NULL in some cases,
> so IS_ERR() doesn't meet the requirements. Thus fix it.
> 
I don't like this added complexity in the driver. IHMO if there is a
real issue, dev_pm_domain_attach_by_name() should just return a error
code, instead of NULL. The fact that you need to pull a error code out
of thin air in the driver is a big hint that this should be fixed in
the called function, not in the return handling in the driver.

A bit down the callstack genpd_dev_pm_attach_by_id() is called, which
is documented like this "Returns the created virtual device if
successfully attached PM domain, NULL when the device don't need a PM
domain [...]". NULL is a valid return code, where the driver should
_not_ stop probing, as the device should work without the power domain
attached.

Regards,
Lucas

> Fixes: 3f7cceeab895 ("PCI: imx: Add multi-pd support")
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 6619e3caf..65d6ebbba 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -337,8 +337,8 @@ static int imx6_pcie_attach_pd(struct device *dev)
>  		return 0;
>  
>  	imx6_pcie->pd_pcie = dev_pm_domain_attach_by_name(dev, "pcie");
> -	if (IS_ERR(imx6_pcie->pd_pcie))
> -		return PTR_ERR(imx6_pcie->pd_pcie);
> +	if (IS_ERR_OR_NULL(imx6_pcie->pd_pcie))
> +		return PTR_ERR(imx6_pcie->pd_pcie) ? : -ENODATA;
>  	/* Do nothing when power domain missing */
>  	if (!imx6_pcie->pd_pcie)
>  		return 0;
> @@ -352,8 +352,8 @@ static int imx6_pcie_attach_pd(struct device *dev)
>  	}
>  
>  	imx6_pcie->pd_pcie_phy = dev_pm_domain_attach_by_name(dev, "pcie_phy");
> -	if (IS_ERR(imx6_pcie->pd_pcie_phy))
> -		return PTR_ERR(imx6_pcie->pd_pcie_phy);
> +	if (IS_ERR_OR_NULL(imx6_pcie->pd_pcie_phy))
> +		return PTR_ERR(imx6_pcie->pd_pcie_phy) ? : -ENODATA;
>  
>  	link = device_link_add(dev, imx6_pcie->pd_pcie_phy,
>  			DL_FLAG_STATELESS |


