Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794AE623C7C
	for <lists+linux-pci@lfdr.de>; Thu, 10 Nov 2022 08:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbiKJHQA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Nov 2022 02:16:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232793AbiKJHPb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Nov 2022 02:15:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FE2326DB;
        Wed,  9 Nov 2022 23:15:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 71C67B82089;
        Thu, 10 Nov 2022 07:15:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE5F7C433C1;
        Thu, 10 Nov 2022 07:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668064524;
        bh=FMlXsITEC3snOIBttDp0EAQyetj/yxbZhJt/Rk5EDxY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tz23sUAjvevM4LmlgxcCobtWnG1sYGF509oU8KAWaRIaF73/7BRuex1Cf+rAQ5CTv
         ec52UF4vz4vd8xkY/PV+2HQCoxK4bjDrqGbllylaVZMbDE1H0S7kVCjn7MRzxKOqg0
         TgKbn3abQiXdKTIZzq0YMwbkJkYLbONPLrsnGqyzhNkldpecdyTJXu8O5HX+S29OoO
         mSYO1FZOmAWv3TxxfmNThq7gIwbIEvF81UOXyUP1UODWGdqh68mHsXuIdbMWqm6mUG
         77r9EGIlbztS/ib+Veym3EuVr5jR5jCQYhk/omC/6Hyq964iy14tnWe5lnZsypKdl8
         iPMlyYbqKzr/w==
Date:   Thu, 10 Nov 2022 15:15:15 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Richard Zhu <hongxing.zhu@nxp.com>, marex@denx.de,
        tharvey@gateworks.com, vkoul@kernel.org, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, alexander.stein@ew.tq-group.com,
        richard.leitner@linux.dev, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: Re: [PATCH v1] soc: imx: imx8mp-blk-ctrl: Add PCIe SYSPLL
 configurations
Message-ID: <20221110071515.GC125525@dragon>
References: <1666590189-1364-1-git-send-email-hongxing.zhu@nxp.com>
 <20221029084514.GT125525@dragon>
 <ae0fd778eb31416eedb248e2cd4faef576174937.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae0fd778eb31416eedb248e2cd4faef576174937.camel@pengutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 01, 2022 at 09:44:41AM +0100, Lucas Stach wrote:
> Hi Shawn, Richard,
> 
> Am Samstag, dem 29.10.2022 um 16:45 +0800 schrieb Shawn Guo:
> > On Mon, Oct 24, 2022 at 01:43:09PM +0800, Richard Zhu wrote:
> > > Add PCIe SYSPLL configurations, thus the internal SYSPLL can be used as
> > > i.MX8MP PCIe reference clock.
> > > 
> > > The following properties of PHY dts node should be changed accordingly.
> > >   - Set 'fsl,refclk-pad-mode' as '<IMX8_PCIE_REFCLK_PAD_OUTPUT>'.
> > >   - Change 'clocks' to '<&clk IMX8MP_CLK_HSIO_ROOT>'.
> > > 
> > > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > 
> > Applied, thanks!
> 
> Sorry for the late reply, but I'm not really happy with the fact that
> the PLL is now unconditionally enabled, even though it is only needed
> when there is no external reference clock source.
> I fear that this will be hard to correct later on as the DT abstraction
> is wrong, as IMX8MP_CLK_HSIO_ROOT is NOT the reference clock for the
> PHY, but the PLL generated clock, which isn't properly exposed with
> this series.
> 
> I'm not happy to see this going in in the current state and if not too
> late would like to ask Shawn to remove it from the tree again.

Removed.

Shawn
