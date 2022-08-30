Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323C05A66DB
	for <lists+linux-pci@lfdr.de>; Tue, 30 Aug 2022 17:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiH3PFk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Aug 2022 11:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiH3PFk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Aug 2022 11:05:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5267B7A3;
        Tue, 30 Aug 2022 08:05:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9EAF1B81C54;
        Tue, 30 Aug 2022 15:05:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A785C433D6;
        Tue, 30 Aug 2022 15:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661871936;
        bh=yMaVy0x6QqxmuF5Wk/jBZfLlTnvPKV2GkJFqUxfyPTQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=oj29NzCyRA3Onq0evlTicdnxULUjjD0s/EeZsq/WWy45JIzUgYar//6rwD9lalFDN
         yqUVcMYXdW26CF2dFOn/yQ4wPRz5ZrNOlktJCFs3Lr6ydX73ALmZSpwXx8fsNaGZGh
         /sBoIH7B4kHFt0LpNGHSQOMQookU2FuPV0d6vwwUZZD4G26yplQDE9a38YnuGXLI0B
         fMnEGxGO1dHDHdU5FWrMhhUt/2JCtNFt8+m8iBm+TDit5PDnVOmfFjLuTBvVLcw/JF
         RNh5AYyCvP+THZn32FqOeLD1XH4UD72CUOLydtnPkY3F7B51bom6aslz87wG+Ty+vb
         BFOKuhKJg0zRw==
Date:   Tue, 30 Aug 2022 10:05:34 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Hongxing Zhu <hongxing.zhu@nxp.com>
Cc:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v1 0/2] Fix the wrong order of phy callbacks
Message-ID: <20220830150534.GA97821@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS8PR04MB86763A2187AED57CFD55625E8C799@AS8PR04MB8676.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 30, 2022 at 07:50:55AM +0000, Hongxing Zhu wrote:
> > -----Original Message-----
> > From: Ahmad Fatoum <a.fatoum@pengutronix.de>
> > Sent: 2022年8月30日 15:16
> > To: Hongxing Zhu <hongxing.zhu@nxp.com>; l.stach@pengutronix.de;
> > bhelgaas@google.com; lorenzo.pieralisi@arm.com; vkoul@kernel.org; Marcel
> > Ziswiler <marcel.ziswiler@toradex.com>; kishon@ti.com
> > Cc: linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org; dl-linux-imx
> > <linux-imx@nxp.com>; kernel@pengutronix.de; linux-phy@lists.infradead.org;
> > linux-arm-kernel@lists.infradead.org
> > Subject: Re: [PATCH v1 0/2] Fix the wrong order of phy callbacks

The above quoting style makes it harder than necessary to follow
conversation.  See hints at:

  https://en.wikipedia.org/wiki/Posting_style#Interleaved_style
  https://people.kernel.org/tglx/notes-about-netiquette

The ideal thing would be something like this, where there's a single
line for each sender:

On Tue, Aug 30, 2022 at 07:50:55AM +0000, Hongxing Zhu wrote:
> On Tue, Aug 30, 2022, at 03:16PM, Ahmad Fatoum wrote:
> > On 30.08.22 05:47, Hongxing Zhu wrote:
> > > Do you mean to squash this fix to the preview series?
> > > I'm afraid that it's not easy to do that.
> > > Because there are a lot of pci-imx6 code changes after
> > > commit: 1aa97b002258 ("phy: freescale: pcie: Initialize the imx8 pcie
> > > standalone phy driver").
> >
> > The way I understand it, if a bisect ends up between your two
> > patches, i.MX8M PCIe will be broken, whereas it worked before. I
> > thus wonder if we shouldn't instead squash this series here into a
> > single patch.
>
> Yes, it's a possible case when do the bisect.
> Since these changes are belong to different git repo.

I don't understand the point about different git repos.  Patch 1/2
touches drivers/pci/controller/dwc/pci-imx6.c, patch 2/2 touches
drivers/phy/freescale/phy-fsl-imx8m-pcie.c.  They're in different
directories, of course, but are in the same Linux kernel source repo.

They're maintained by different people, but we can easily deal with
that by getting an ack from one and merging via the other.

> It will bring maintain difficulties if these two patches are squashed into a
>  single one.
> It's difficult to make a choice.

What maintenance difficulty do you see here?  I think it looks
*easier* if these are squashed -- that would avoid the possibility of
backporting one without the other, which would certainly be a problem.

If a bisect lands after patch 1/2 but before 2/2, it looks like i.MX8M
will break unnecessarily.

I think Ahmad is right that patches 1/2 and 2/2 should be squashed
into a single patch to avoid this bisection hole.

Bjorn
