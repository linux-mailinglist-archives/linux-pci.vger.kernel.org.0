Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBADF4FC1C3
	for <lists+linux-pci@lfdr.de>; Mon, 11 Apr 2022 18:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348372AbiDKQGS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Apr 2022 12:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347950AbiDKQGR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Apr 2022 12:06:17 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4802C4
        for <linux-pci@vger.kernel.org>; Mon, 11 Apr 2022 09:04:03 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1ndwWA-000055-BS; Mon, 11 Apr 2022 18:03:54 +0200
Message-ID: <c8d3ed7196d09f5f6a61d605a94613f792ab501b.camel@pengutronix.de>
Subject: Re: [PATCH v3] PCI: imx6: Replace legacy gpio interface for gpiod
 interface
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        =?ISO-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     hongxing.zhu@nxp.com, robh@kernel.org, bhelgaas@google.com,
        helgaas@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 11 Apr 2022 18:03:51 +0200
In-Reply-To: <20220411115926.GA20890@francesco-nb.int.toradex.com>
References: <YYCOTx68LXu1Tn1i@fedora> <YlBFa46v5NtWxGLt@lpieralisi>
         <YlBKyBtbxMpvauLv@fedora>
         <20220411115926.GA20890@francesco-nb.int.toradex.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Maíra, hi Lorenzo,

Am Montag, dem 11.04.2022 um 13:59 +0200 schrieb Francesco Dolcini:
> On Fri, Apr 08, 2022 at 11:46:32AM -0300, Maíra Canal wrote:
> > On Fri, Apr 08, 2022 at 03:23:39PM +0100, Lorenzo Pieralisi wrote:
> > > On Mon, Nov 01, 2021 at 10:03:11PM -0300, Maíra Canal wrote:
> > > > Considering the current transition of the GPIO subsystem, remove all
> > > > dependencies of the legacy GPIO interface (linux/gpio.h and linux
> > > > /of_gpio.h) and replace it with the descriptor-based GPIO approach.
> > > > 
> > > > Signed-off-by: Maíra Canal <maira.canal@usp.br>
> > > > ---
> > > > V1 -> V2: Rewrite commit log and subject line to match PCI subsystem standard
> > > > V2 -> v3: Change gpiod_set_value_cansleep for gpiod_set_raw_value_cansleep
> > > > ---
> > > >  drivers/pci/controller/dwc/pci-imx6.c | 30 +++++++++------------------
> > > >  1 file changed, 10 insertions(+), 20 deletions(-)
> > > 
> > > Maira, Lucas,
> > > 
> > > what's this patch status ? Please let me know.

The patch looks fine to me now, however...

> > 
> > Thank you for the feedback. Since I sent v3, I didn't get any feedback from the community.
> > 
> > If you have any feedback, I would gladly work on it.
> 
> Just for you to know that it will likely conflict with
> 'PCI: imx6: Fix PERST# start-up sequence' [0] that is also still waiting
> for some additional feedback.

... they do conflict and I guess the functional fix for the reset
sequence should have priority over this cleanup. Maíra, may I ask you
to respin your patch as soon as Francescos fix is in? I promise to not
let it fall through the cracks again.

Regards,
Lucas

