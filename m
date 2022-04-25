Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320CF50DFAF
	for <lists+linux-pci@lfdr.de>; Mon, 25 Apr 2022 14:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbiDYMLZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Apr 2022 08:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240126AbiDYMLS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Apr 2022 08:11:18 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE255AA52
        for <linux-pci@vger.kernel.org>; Mon, 25 Apr 2022 05:08:07 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1nixVU-0000PM-KI; Mon, 25 Apr 2022 14:07:56 +0200
Message-ID: <56052bc6e3b6cab6bfdfc5f706ec9984bea16bba.camel@pengutronix.de>
Subject: Re: [PATCH v3] PCI: imx6: Replace legacy gpio interface for gpiod
 interface
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Linus Walleij <linus.walleij@linaro.org>,
        =?ISO-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>
Cc:     hongxing.zhu@nxp.com, lorenzo.pieralisi@arm.com, robh@kernel.org,
        bhelgaas@google.com, helgaas@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 25 Apr 2022 14:07:53 +0200
In-Reply-To: <CACRpkdYmw4yBm3Y1P42TcRs4fFNEiy3LXxmO_j=zeTv_usDR+g@mail.gmail.com>
References: <YYCOTx68LXu1Tn1i@fedora>
         <CACRpkdYmw4yBm3Y1P42TcRs4fFNEiy3LXxmO_j=zeTv_usDR+g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Linus,

Am Donnerstag, dem 21.04.2022 um 01:24 +0200 schrieb Linus Walleij:
> Hi Maira and sorry for being slow on reviews.
> 
> On Tue, Nov 2, 2021 at 2:04 AM Maíra Canal <maira.canal@usp.br> wrote:
> 
> > -               gpio_set_value_cansleep(imx6_pcie->reset_gpio,
> > +               gpiod_set_raw_value_cansleep(imx6_pcie->reset_gpio,
> >                                         !imx6_pcie->gpio_active_high);
> 
> Hm I see you got advised to use the raw api. I'm not so sure about
> that I like v1 better.
> 
> > +       imx6_pcie->reset_gpio = devm_gpiod_get_optional(dev, "reset",
> > +                       imx6_pcie->gpio_active_high ?  GPIOD_OUT_HIGH : GPIOD_OUT_LOW);
> > +       if (IS_ERR(imx6_pcie->reset_gpio))
> > +               return dev_err_probe(dev, PTR_ERR(imx6_pcie->reset_gpio),
> > +                               "unable to get reset gpio\n");
> 
> Where is this descriptor coming from? Device trees? Can't we just fix the
> DTS file(s) in that case given how wrong they are if they don't set
> GPIO_ACTIVE_LOW flag on this IRQ.

The binding explicitly describes the GPIO as not polarity aware and has
a separate property "reset-gpio-active-high" to avoid breaking old
DTBs. I don't think it's helpful to dismiss this explicit backward
compat just because the driver code looks nicer that way.

Regards,
Lucas

