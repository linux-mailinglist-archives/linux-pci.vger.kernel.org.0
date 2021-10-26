Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C171643BD21
	for <lists+linux-pci@lfdr.de>; Wed, 27 Oct 2021 00:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239905AbhJZWYO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Oct 2021 18:24:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:43722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235758AbhJZWYN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Oct 2021 18:24:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E2BAD60F02;
        Tue, 26 Oct 2021 22:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635286909;
        bh=Ti9ROmEWB++H0DVAD/4QLbK3bMpQv6DTgwhjoKZgM3Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=PcI2FaCRlJY+KWzLUhYhOcAar43cbCPaiPFaGHtK9GQiTU5oUu5Cg99gBUjLkKFDY
         tsN2yWVZsuWG3Ldj/Eqxztu7tqHfh7OuGgEb9ljzY1EB3AiFARjrB2lR/PhwkmxHaY
         istohXv3cDHFL4Oz43TW05RJHlKH4+npN5TIF+kxSxOwART2KIjH3FajjF63TN3Iq5
         7pIc3qIGTRh/KW7iiKIHsUTid1qRNbfxJJbd5S8tasOWHQ5fLcLUvwQp0l/7lM9KTV
         uxMaXqC+YxKabTJKA8IM7Q9sguYdy/4/br4qcOeCjOKvp2Tu/6EIjzwfrUpOtrvaV7
         ghfJpn4scpUdg==
Date:   Tue, 26 Oct 2021 17:21:47 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [RESEND v2 4/5] PCI: imx6: Fix the clock reference handling
 unbalance when link never came up
Message-ID: <20211026222147.GA173173@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS8PR04MB867639048E1F4F0AAC2347048C839@AS8PR04MB8676.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 25, 2021 at 02:35:36AM +0000, Richard Zhu wrote:
> > -----Original Message-----
> > From: Krzysztof Wilczyński <kw@linux.com>
> > Sent: Saturday, October 23, 2021 5:54 PM
> > To: Richard Zhu <hongxing.zhu@nxp.com>
> > Cc: Bjorn Helgaas <helgaas@kernel.org>; l.stach@pengutronix.de;
> > bhelgaas@google.com; lorenzo.pieralisi@arm.com; linux-pci@vger.kernel.org;
> > dl-linux-imx <linux-imx@nxp.com>; linux-arm-kernel@lists.infradead.org;
> > linux-kernel@vger.kernel.org; kernel@pengutronix.de
> > Subject: Re: [RESEND v2 4/5] PCI: imx6: Fix the clock reference handling
> > unbalance when link never came up

> > I hope you don't mind me asking, but how is an empty default case in the
> > switch statement helping IMX6Q and IMX6QP?  What does it achieve for
> > these two controllers specifically?
> > 
> [Richard Zhu] Never mind. 😊.
> There might be following building warning if the "default:break" is removed.
> "  CC      drivers/pci/controller/dwc/pci-imx6.o
> drivers/pci/controller/dwc/pci-imx6.c: In function ‘imx6_pcie_clk_disable’:
> drivers/pci/controller/dwc/pci-imx6.c:527:2: warning: enumeration value ‘IMX6Q’ not handled in switch [-Wswitch]
>   527 |  switch (imx6_pcie->drvdata->variant) {
>       |  ^~~~~~
> drivers/pci/controller/dwc/pci-imx6.c:527:2: warning: enumeration value ‘IMX6QP’ not handled in switch [-Wswitch]"

Sorry, I didn't see this until after asking the same question as
Krzysztof.

Sigh.  That's a really annoying gcc warning, but I guess I won't fight
it ;)

Bjorn
