Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48DC5451D1
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jun 2022 18:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234159AbiFIQ0C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jun 2022 12:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239526AbiFIQZ6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jun 2022 12:25:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F34196;
        Thu,  9 Jun 2022 09:25:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5213360BD3;
        Thu,  9 Jun 2022 16:25:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D961C34114;
        Thu,  9 Jun 2022 16:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654791953;
        bh=GUCfjj07MT21bODoY17PnMWnqynvpsdI6YTnfv/B07o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=SZyyFGAm1zl4BW7SYoFMufNROhh/TWjXza+m9Cb/8LVsrN2baONmnwuYXzFnJsDde
         0mP0h1dGYQVtmXVyEqDtXaKGlOUOZ1k/EgTu/WfB2+edgj4Jh03pGJec8wO5kaBTfD
         +wAkMVSBYZRRM/p+hF1BkfN87wDzJHFrRTkzMAUnAx6q18rHUgnfDEc6XviyPOR0Su
         G9IKS45WM6owg29rxC228tyuGO54WQ6N4ElJzxhHwQ1rTvbKiTC9Pe4JvSy7FbdgWP
         Hj3wHj9+8Utuh8LSeMmpKpKWQ88p5P8Ngw7+BVx7wSaZtKvxlx7GCuK+/OA1WmT1BJ
         Bwo0YL/VTFXeQ==
Date:   Thu, 9 Jun 2022 11:25:52 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Hongxing Zhu <hongxing.zhu@nxp.com>
Cc:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "francesco.dolcini@toradex.com" <francesco.dolcini@toradex.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH v9 7/8] PCI: imx6: Move the phy driver callbacks to the
 proper places
Message-ID: <20220609162552.GA514635@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS8PR04MB86768DB1E04AAE3D63E8BE618CA79@AS8PR04MB8676.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 09, 2022 at 06:20:16AM +0000, Hongxing Zhu wrote:
> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > Sent: 2022年6月9日 2:58
> > To: Hongxing Zhu <hongxing.zhu@nxp.com>
> > Cc: l.stach@pengutronix.de; bhelgaas@google.com; robh+dt@kernel.org;
> > broonie@kernel.org; lorenzo.pieralisi@arm.com; jingoohan1@gmail.com;
> > festevam@gmail.com; francesco.dolcini@toradex.com;
> > linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > linux-kernel@vger.kernel.org; kernel@pengutronix.de; dl-linux-imx
> > <linux-imx@nxp.com>
> > Subject: Re: [PATCH v9 7/8] PCI: imx6: Move the phy driver callbacks to the
> > proper places
> > 
> > On Fri, May 06, 2022 at 09:47:08AM +0800, Richard Zhu wrote:
> > > To make it more reasonable, move the phy_power_on/phy_init callbacks
> > > to the proper places.
> > > - move the phy_power_on() out of imx6_pcie_clk_enable().
> > > - move the phy_init() out of imx6_pcie_deassert_core_reset().
> > 
> > I'm not sure what "make it more reasonable" is telling me.  In
> > subject line and commit log, please say something more specific
> > than "the proper places."
> > 
> > It's probably more important to say where they are moving *to*
> > than where they're moving *out of*.

> Thanks for your comments.
> In another review loop listed below, Lucas used said that it's not
> good to hide PHY init in imx6_pcie_assert_core_reset() So, I make a
> try to move the phy_init() out of imx6_pcie_assert_core_reset().
> And move phy_power_on() out of imx6_pcie_clk_enable() accordingly.
> https://patchwork.kernel.org/project/linux-pci/patch/1646289275-17813-1-git-send-email-hongxing.zhu@nxp.com/
> Okay, I would specific that they are moving *to* later.
> 
> > > In order to save power consumption, turn off the clocks and
> > > regulators when the imx6_pcie_host_init() return error.
> > 
> > Is the power savings the *reason* for this change?  I can't tell
> > from the commit log.
>
> The error handling of the imx6_pcie_host_init() is not mentioned in
> the subject.  Should I split these changes into two patches?

If they can be split, they probably should be split.
