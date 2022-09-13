Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347955B68BE
	for <lists+linux-pci@lfdr.de>; Tue, 13 Sep 2022 09:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbiIMHgR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Sep 2022 03:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiIMHgN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Sep 2022 03:36:13 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623EF57E25;
        Tue, 13 Sep 2022 00:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=oRpmSruXXDfHHV5+EC0Xg5Uv67nyeQ6QmShePHfU9+0=; b=IF4akWGVqP4IVED+nVq/W/GkTw
        m+f7J/3Z23ZFI1haNEvCDTQRepUmS7JDXVbdKrxkBsQ+IaewIYHz+VTa/Uva9J+PDaL3ZMt7v58g1
        MwruXci7fOuKOOgiRU1uAFTaY6CoS4VrJU3FgQPrBEwzwtW72MJRVQkkhtuhXgApWb/+mB3//HazK
        ZcTDJ3+GjRN7K7rLO+/QyhpJ8qtQsPOUTxlI21UtqwGjxlQk7OofmoPVg1ZOBCDd4APbMyp6GbBc2
        0NHqojWwFTK+HZ9rfPus8ecj4WLFvj+j46ExUv542VGFBEjIYCb01HaHFZUifreDl+HeBNbPoADMc
        6T36UCww==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34280)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1oY0Si-0002Yj-0Q; Tue, 13 Sep 2022 08:36:04 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1oY0Sg-0000UY-BY; Tue, 13 Sep 2022 08:36:02 +0100
Date:   Tue, 13 Sep 2022 08:36:02 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     hongxing.zhu@nxp.com, l.stach@pengutronix.de,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        shawnguo@kernel.org, bhelgaas@google.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: imx6: Fix wrong check in imx6_pcie_attach_pd()
Message-ID: <YyAy4iBUa5kByPwu@shell.armlinux.org.uk>
References: <20220913065910.15348-1-tangbin@cmss.chinamobile.com>
 <YyAx17VNvDMyvgBV@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyAx17VNvDMyvgBV@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 13, 2022 at 08:31:35AM +0100, Russell King (Oracle) wrote:
> On Tue, Sep 13, 2022 at 02:59:10PM +0800, Tang Bin wrote:
> > In the function imx6_pcie_attach_pd(),
> > dev_pm_domain_attach_by_name() may return NULL in some cases,
> > so IS_ERR() doesn't meet the requirements. Thus fix it.
> 
> NAK. You are clearly doing a mechanical search and replace, and then
> throwing out patches without a care in the world for other people to
> then decide whether the changes are in fact appropriate or not.
> 
> Please don't do that. Please read and understand the code before you
> waste reviewers and developers time - otherwise you will educate
> reviews and developers to ignore your efforts.

It is also highly likely that many of these changes are just plain
broken.

If you read the documentation for this function and the referred
to function:

 * Returns the created virtual device if successfully attached PM domain, NULL
 * when the device don't need a PM domain, else an ERR_PTR() in case of
 * failures. If a power-domain exists for the device, but cannot be found or
 * turned on, then ERR_PTR(-EPROBE_DEFER) is returned to ensure that the device
 * is not probed and to re-try again later.

So, NULL is *not* an error condition. It means that the device does not
need a power domain, which is *not* a failure.

You are probably causing more harm than good by trying to do this
mechanical change all over the kernel.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
