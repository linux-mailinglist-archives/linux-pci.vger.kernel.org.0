Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5728D5B68DD
	for <lists+linux-pci@lfdr.de>; Tue, 13 Sep 2022 09:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbiIMHqS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Sep 2022 03:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbiIMHqR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Sep 2022 03:46:17 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAD82B279;
        Tue, 13 Sep 2022 00:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7R46dL5v/qAAceuZ423ZSM42+lTG5q+jzS8a0ZHd/yA=; b=G4HJswNfkvqvbqgOKeKi5WXj8O
        JuEpK1sh7BVrm90ZMiDMwiCB3P2tVsIpxr0G2uo2fEOIkWmF+gBR61FBIk9kMY/nhTgANroSLAZsK
        vwmMWfq1z1Wvd3Q//G3gSYr0U6Cm7ri+g/6VvKjJZCK8fI9g4+KSMZaet8hsr9/e7omVcehR5HIIk
        OmUBpkhdCurtJjVThQDsEWjdLMnU9GZGEq7OyHdvC/8epR6czzdq5OAvYuMjD0TCJ81jIjEEOGMz+
        YR4zt9V9DqxzeNwaIRLgIM/Iz6PObghcRWAxaXUqPYFBjGdNgZKgmQnLpuK8NexrTkw4AjL8whuZu
        HnN+b4mw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34286)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1oY0cS-0002aM-4j; Tue, 13 Sep 2022 08:46:08 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1oY0cQ-0000Vo-RI; Tue, 13 Sep 2022 08:46:06 +0100
Date:   Tue, 13 Sep 2022 08:46:06 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Tang Bin <tangbin@cmss.chinamobile.com>, hongxing.zhu@nxp.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        shawnguo@kernel.org, bhelgaas@google.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: imx6: Fix wrong check in imx6_pcie_attach_pd()
Message-ID: <YyA1PgoZLgRsbOkQ@shell.armlinux.org.uk>
References: <20220913065910.15348-1-tangbin@cmss.chinamobile.com>
 <0660fff6d29c5f8251ac4f28d4badcfea91e6833.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0660fff6d29c5f8251ac4f28d4badcfea91e6833.camel@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 13, 2022 at 09:39:03AM +0200, Lucas Stach wrote:
> Am Dienstag, dem 13.09.2022 um 14:59 +0800 schrieb Tang Bin:
> > In the function imx6_pcie_attach_pd(),
> > dev_pm_domain_attach_by_name() may return NULL in some cases,
> > so IS_ERR() doesn't meet the requirements. Thus fix it.
> > 
> I don't like this added complexity in the driver. IHMO if there is a
> real issue, dev_pm_domain_attach_by_name() should just return a error
> code, instead of NULL.

You've fallen into the trap that Tang Bin laid. It returns an error
code for all cases where an error has happened. It returns NULL only
when the device does not require a power domain. So, a NULL return is
*not* an error condition, but merely an indication that "this device
does not require this power domain".

Mechanical changes like this are really quite harmful to the kernel.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
