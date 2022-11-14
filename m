Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1380627648
	for <lists+linux-pci@lfdr.de>; Mon, 14 Nov 2022 08:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235782AbiKNHPY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Nov 2022 02:15:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235493AbiKNHPX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2022 02:15:23 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107DCDE9E
        for <linux-pci@vger.kernel.org>; Sun, 13 Nov 2022 23:15:22 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1ouTge-0002HU-Qr; Mon, 14 Nov 2022 08:15:20 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1ouTgd-0008T2-Qy; Mon, 14 Nov 2022 08:15:19 +0100
Date:   Mon, 14 Nov 2022 08:15:19 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2] PCI: imx6: Initialize PHY before deasserting core
 reset
Message-ID: <20221114071519.GF3143@pengutronix.de>
References: <166818222626.230065.5220320291788502712.b4-ty@kernel.org>
 <20221111215301.GA749191@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111215301.GA749191@bhelgaas>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 11, 2022 at 03:53:01PM -0600, Bjorn Helgaas wrote:
> On Fri, Nov 11, 2022 at 04:57:46PM +0100, Lorenzo Pieralisi wrote:
> > On Tue, 1 Nov 2022 10:57:14 +0100, Sascha Hauer wrote:
> > > When the PHY is the reference clock provider then it must be initialized
> > > and powered on before the reset on the client is deasserted, otherwise
> > > the link will never come up. The order was changed in cf236e0c0d59.
> > > Restore the correct order to make the driver work again on boards where
> > > the PHY provides the reference clock. This also changes the order for
> > > boards where the Soc is the PHY reference clock divider, but this
> > > shouldn't do any harm.
> > > 
> > > [...]
> > 
> > Applied to pci/dwc, thanks!
> > 
> > [1/1] PCI: imx6: Initialize PHY before deasserting core reset
> >       https://git.kernel.org/lpieralisi/pci/c/ae6b9a65af48
> 
> cf236e0c0d59 appeared in v6.0; should we add a stable tag to this?

Good idea, yes.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
