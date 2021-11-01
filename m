Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64DE7441CFE
	for <lists+linux-pci@lfdr.de>; Mon,  1 Nov 2021 15:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbhKAPBR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Nov 2021 11:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbhKAPBQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Nov 2021 11:01:16 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D76AC061714
        for <linux-pci@vger.kernel.org>; Mon,  1 Nov 2021 07:58:43 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1mhYle-0005LQ-1T; Mon, 01 Nov 2021 15:58:34 +0100
Message-ID: <557e68ad15634ddb65c98ebf80cd7ef962ac2608.camel@pengutronix.de>
Subject: Re: [PATCH v2 RESEND] PCI: imx6: Replace legacy gpio interface for
 gpiod interface
From:   Lucas Stach <l.stach@pengutronix.de>
To:     =?ISO-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>
Cc:     hongxing.zhu@nxp.com, lorenzo.pieralisi@arm.com, robh@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <helgaas@kernel.org>, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 01 Nov 2021 15:58:31 +0100
In-Reply-To: <CAH7FV3nyyLndqTdJYN8HDxU4C7pW0-DLu6ZSOLof2=tEEHbHxQ@mail.gmail.com>
References: <YX/zlRqmxbLRnTqT@fedora>
         <4f1b60bab451b219c7139e2204eb5b9f462ee4e0.camel@pengutronix.de>
         <CAH7FV3nyyLndqTdJYN8HDxU4C7pW0-DLu6ZSOLof2=tEEHbHxQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am Montag, dem 01.11.2021 um 11:44 -0300 schrieb Maíra Canal:
> ?
> > >       /* Some boards don't have PCIe reset GPIO. */
> > > -     if (gpio_is_valid(imx6_pcie->reset_gpio)) {
> > > -             gpio_set_value_cansleep(imx6_pcie->reset_gpio,
> > > +     if (imx6_pcie->reset_gpio) {
> > > +             gpiod_set_value_cansleep(imx6_pcie->reset_gpio,
> > >                                       imx6_pcie->gpio_active_high);
> > >               msleep(100);
> > > -             gpio_set_value_cansleep(imx6_pcie->reset_gpio,
> > > +             gpiod_set_value_cansleep(imx6_pcie->reset_gpio,
> > >                                       !imx6_pcie->gpio_active_high);
> > 
> > I don't think this is correct. gpiod_set_value sets the logical line
> > state, so if the GPIO is specified as active-low in the DT, the real
> > line state will be negated. The only reason why the reset-gpio-active-
> > high property even exists is that old DTs might specify the wrong GPIO
> > polarity in the reset-gpio DT description. I think you need to use to
> > gpiod_set_raw_value API here to get the expected real line state even
> > with a broken DT description.
> > 
> > Regards,
> > Lucas
> > 
> 
> I'm a beginner in kernel development, so I'm sorry for the question.
> If I change gpiod_set_value_cansleep for gpiod_set_raw_value, wouldn't
> I change the behavior of the driver? I replaced
> gpio_set_value_cansleep for gpiod_set_value_cansleep because they have
> the same behavior and I didn't change the logic states. Thank you for
> the feedback!

Yes, you need to use the _cansleep variant of the API to keep the
context information. The point I was trying to make was that you
probably (please double check, that's just an assumption on my side)
need to use the _raw variant of the gpiod API to keep the current
behavior of the driver, as we are setting the physical line state
purely depending on the reset-gpio-active-high property presence, not
the logical line state, which would take into account the polarity
specified in the DT gpio descriptor.

I guess the right API call here would be
gpiod_set_raw_value_cansleep().

Regards,
Lucas

