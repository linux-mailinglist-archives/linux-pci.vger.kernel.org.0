Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B557B5B68B3
	for <lists+linux-pci@lfdr.de>; Tue, 13 Sep 2022 09:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbiIMHcC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Sep 2022 03:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbiIMHcB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Sep 2022 03:32:01 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A92558B63;
        Tue, 13 Sep 2022 00:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xglz0vjqr0RitGgMnGnkfLMxC6SCl6nGd91QSpoaNaI=; b=o7TxC+At2Mo+ZS3vjfpbAZySLL
        +4QjSd4wUUiVK0sp0IUeOKe/F7SKWYJl0wtwOsWlzf9kOkgMkN9OEfLRabuDwIvtMDWDGJbp+yZGq
        5M2h0hXUUwvM1PsGhGpFnG3bk128hVOfsJ+Z6MRt+K+nBJpojyHhDEpXEPGkx4o+nNzrK0N3gmgHh
        BtjAAedwtM/bPGovll4HLeWpGCqpeDdDlKl1/c6l/YFuMIVrbZ3vrsdheTrPXExgOS6YsPkaAojLX
        EKXhG7F8MkXpdaCyOUGEGb6VKpn76YrNKwO6tM5v541igx3D2BITIn+t9XuHmTs1zX59ZcltfzONA
        ndAr3sfA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34278)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1oY0OU-0002Y5-FU; Tue, 13 Sep 2022 08:31:42 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1oY0ON-0000UN-4W; Tue, 13 Sep 2022 08:31:35 +0100
Date:   Tue, 13 Sep 2022 08:31:35 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     hongxing.zhu@nxp.com, l.stach@pengutronix.de,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        shawnguo@kernel.org, bhelgaas@google.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: imx6: Fix wrong check in imx6_pcie_attach_pd()
Message-ID: <YyAx17VNvDMyvgBV@shell.armlinux.org.uk>
References: <20220913065910.15348-1-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913065910.15348-1-tangbin@cmss.chinamobile.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 13, 2022 at 02:59:10PM +0800, Tang Bin wrote:
> In the function imx6_pcie_attach_pd(),
> dev_pm_domain_attach_by_name() may return NULL in some cases,
> so IS_ERR() doesn't meet the requirements. Thus fix it.

NAK. You are clearly doing a mechanical search and replace, and then
throwing out patches without a care in the world for other people to
then decide whether the changes are in fact appropriate or not.

Please don't do that. Please read and understand the code before you
waste reviewers and developers time - otherwise you will educate
reviews and developers to ignore your efforts.

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

Your change is incorrect, as can be seen by the following if()
statement, which checks for NULL here. Clearly, the explicit
intention is that if dev_pm_domain_attach_by_name() returns NULL,
imx6_pcie_attach_pd() does _not_ fail.

So you are likely creating a regression by your change. You are
likely introducing a bug rather than fixing something. This is
why you must always carefully review any mechanical change.

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

This change is unnecessary. If dev_pm_domain_attach_by_name() returns
Null, then device_link_add() will also return NULL, and the check for
a NULL link will then succeed. So the NULL case is already cleanly
handled.

So overall, your patch is unnecessary and introduces a bug rather than
fixing it. Therefore, you can discard the patch in its entirety.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
