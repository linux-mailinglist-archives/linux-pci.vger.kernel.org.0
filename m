Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7EB5A44A6
	for <lists+linux-pci@lfdr.de>; Mon, 29 Aug 2022 10:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiH2IKu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Aug 2022 04:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiH2IKs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Aug 2022 04:10:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DC13F1C6;
        Mon, 29 Aug 2022 01:10:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D28B260B4A;
        Mon, 29 Aug 2022 08:10:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 450C1C433C1;
        Mon, 29 Aug 2022 08:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661760611;
        bh=ghn7+0lbp5TnGMDV+RA4jLLC7eiUFlyQ9hTLHez9pJw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rbO9/u5UUBaOsqvim3f+1Aqomcquo6sV4EGA/3by6gGygz0l0JAvicMAr5e54PM7+
         bBxFeP4uesJ+ZsvUG6ZCbSgEbrIJRxUYEXcItUh0Ur7EHotBO/yrb4zqn0cWt+Mxd0
         3qAPqk1NEXIyjYCTa6hknc6R2G1PeEOvNFnSuBU/B73VIlatVXzZh4zIg7qOc+xKh7
         45ME4vlZAbbU97XIHvxtNh89gSmM/Ezk+f+hiXNZnCg2GFL+T2iZoCuadDnTyWFCPr
         UUQISYJasVOKFUKF97pJLaF4Bk+W1X44/o1uaJQMtiQT1Es7pd/431eOQ1XaQB8rEr
         LPArsZwfLkN3w==
Date:   Mon, 29 Aug 2022 10:10:02 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Hongxing Zhu <hongxing.zhu@nxp.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
        "marex@denx.de" <marex@denx.de>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH v3 1/6] reset: imx7: Add the iMX8MP PCIe PHY PERST support
Message-ID: <Ywx0WorLvPrXGVt9@lpieralisi>
References: <1660806153-29001-1-git-send-email-hongxing.zhu@nxp.com>
 <1660806153-29001-2-git-send-email-hongxing.zhu@nxp.com>
 <ddbcd90419e9bb4ce7c5b7b3055ee3227c179321.camel@pengutronix.de>
 <AS8PR04MB867626BC5C32AA75466BB9E78C6D9@AS8PR04MB8676.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS8PR04MB867626BC5C32AA75466BB9E78C6D9@AS8PR04MB8676.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 18, 2022 at 10:53:24AM +0000, Hongxing Zhu wrote:
> > -----Original Message-----
> > From: Philipp Zabel <p.zabel@pengutronix.de>
> > Sent: 2022年8月18日 16:51
> > To: Hongxing Zhu <hongxing.zhu@nxp.com>; l.stach@pengutronix.de;
> > bhelgaas@google.com; lorenzo.pieralisi@arm.com; robh@kernel.org;
> > shawnguo@kernel.org; vkoul@kernel.org; alexander.stein@ew.tq-group.com;
> > marex@denx.de
> > Cc: linux-phy@lists.infradead.org; devicetree@vger.kernel.org;
> > linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > linux-kernel@vger.kernel.org; kernel@pengutronix.de; dl-linux-imx
> > <linux-imx@nxp.com>
> > Subject: Re: [PATCH v3 1/6] reset: imx7: Add the iMX8MP PCIe PHY PERST
> > support
> > 
> > Hi Richard,
> > 
> > On Do, 2022-08-18 at 15:02 +0800, Richard Zhu wrote:
> > > On i.MX7/iMX8MM/iMX8MQ, the initialized default value of PERST
> > > bit(BIT3) of SRC_PCIEPHY_RCR is 1b'1.
> > > But i.MX8MP has one inversed default value 1b'0 of PERST bit.
> > >
> > > And the PERST bit should be kept 1b'1 after power and clocks are stable.
> > > So add the i.MX8MP PCIe PHY PERST support here.
> > 
> > the description is good now. It would be nice if this could also be mentioned in
> > the Reference Manual.
> > 
> > Please replace "add" with "fix" in the subject, as I requested earlier:
> > "reset: imx7: Fix i.MX8MP PCIe PHY PERST support".
> > 
> > And add a fixes line:
> > 
> > Fixes: e08672c03981 ("reset: imx7: Add support for i.MX8MP SoC")
> > 
> > With those two changes,
> > Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> > 
> Hi Philipp:
> Okay, would be changed in next version.

AFAICS there is still a pending comment on patch (2) but I will
mark this as "Changes requested" and wait for the next version.

Lorenzo

> Thanks for your review.
> 
> Best Regards
> Richard Zhu
> 
> > regards
> > Philipp
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
