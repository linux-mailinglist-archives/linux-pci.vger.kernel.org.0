Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84AD96145E6
	for <lists+linux-pci@lfdr.de>; Tue,  1 Nov 2022 09:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiKAIpE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Nov 2022 04:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiKAIpC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Nov 2022 04:45:02 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E50514D2C
        for <linux-pci@vger.kernel.org>; Tue,  1 Nov 2022 01:45:02 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1opmt4-000898-5T; Tue, 01 Nov 2022 09:44:46 +0100
Message-ID: <ae0fd778eb31416eedb248e2cd4faef576174937.camel@pengutronix.de>
Subject: Re: [PATCH v1] soc: imx: imx8mp-blk-ctrl: Add PCIe SYSPLL
 configurations
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Shawn Guo <shawnguo@kernel.org>, Richard Zhu <hongxing.zhu@nxp.com>
Cc:     marex@denx.de, tharvey@gateworks.com, vkoul@kernel.org,
        bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        alexander.stein@ew.tq-group.com, richard.leitner@linux.dev,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Date:   Tue, 01 Nov 2022 09:44:41 +0100
In-Reply-To: <20221029084514.GT125525@dragon>
References: <1666590189-1364-1-git-send-email-hongxing.zhu@nxp.com>
         <20221029084514.GT125525@dragon>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Shawn, Richard,

Am Samstag, dem 29.10.2022 um 16:45 +0800 schrieb Shawn Guo:
> On Mon, Oct 24, 2022 at 01:43:09PM +0800, Richard Zhu wrote:
> > Add PCIe SYSPLL configurations, thus the internal SYSPLL can be used as
> > i.MX8MP PCIe reference clock.
> > 
> > The following properties of PHY dts node should be changed accordingly.
> >   - Set 'fsl,refclk-pad-mode' as '<IMX8_PCIE_REFCLK_PAD_OUTPUT>'.
> >   - Change 'clocks' to '<&clk IMX8MP_CLK_HSIO_ROOT>'.
> > 
> > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> 
> Applied, thanks!

Sorry for the late reply, but I'm not really happy with the fact that
the PLL is now unconditionally enabled, even though it is only needed
when there is no external reference clock source.
I fear that this will be hard to correct later on as the DT abstraction
is wrong, as IMX8MP_CLK_HSIO_ROOT is NOT the reference clock for the
PHY, but the PLL generated clock, which isn't properly exposed with
this series.

I'm not happy to see this going in in the current state and if not too
late would like to ask Shawn to remove it from the tree again.

Regards,
Lucas

