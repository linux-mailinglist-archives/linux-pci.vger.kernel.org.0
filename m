Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB854C39EB
	for <lists+linux-pci@lfdr.de>; Fri, 25 Feb 2022 00:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbiBXXyj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Feb 2022 18:54:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234580AbiBXXyi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Feb 2022 18:54:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10311DB8BF;
        Thu, 24 Feb 2022 15:54:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7E57EB82A1B;
        Thu, 24 Feb 2022 23:54:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7D1AC340E9;
        Thu, 24 Feb 2022 23:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645746845;
        bh=8m28xb7jX3rywztpqXC+7Sf7/JfCaAm/fcFHne2Mfy4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=SFUz6Z502Ca7Kj0zNp0wvhF3BdzD+Zk/9kpXhzEoTRH+cCA0Bm7FQGGltf0D5VG6y
         uv8yJchzr9kXT+6aTeqxkewFjyLWf0qvefF/i4VFjr2RIRk4fyhroRerr+/+2kzGQp
         BaXfc73+w2CM3Z4us0WRerwLf+VBBnIxhlwWjxtiF2Z10ky3bsydBkCRJ9uve0l8LP
         y/N6NA+t2aAHik9sHZkQRkP8HEZBIIMpEO8uyrkFTmcFm6Lq4BoJtBtNTLjs/vl/s2
         dvj4uq4oU75qqgn7cda90FtLpZ6Paoh9Tf6K9B7VwvMuTKk7GWGfXF1oCK40lXxgp+
         A6lSA9pQyExVQ==
Date:   Thu, 24 Feb 2022 17:54:03 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Hongxing Zhu <hongxing.zhu@nxp.com>
Cc:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
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
Subject: Re: [PATCH v7 8/8] PCI: imx6: Add the compliance tests mode support
Message-ID: <20220224235403.GA303878@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS8PR04MB8676DCB7CB8D94B0CBC97D0B8C3D9@AS8PR04MB8676.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 24, 2022 at 07:50:09AM +0000, Hongxing Zhu wrote:
> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > Sent: 2022年2月24日 1:40
> > To: Hongxing Zhu <hongxing.zhu@nxp.com>
> > Cc: l.stach@pengutronix.de; bhelgaas@google.com; broonie@kernel.org;
> > lorenzo.pieralisi@arm.com; jingoohan1@gmail.com; festevam@gmail.com;
> > francesco.dolcini@toradex.com; linux-pci@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> > kernel@pengutronix.de; dl-linux-imx <linux-imx@nxp.com>
> > Subject: Re: [PATCH v7 8/8] PCI: imx6: Add the compliance tests mode support

> > Is this a reference to a spec?  If so, I can't tell the name of the spec, the
> > revision, or the section number.
> Yes, it is a reference to a spec. How about change them to the following?
> 
> PCI: imx6: Add compliance tests mode support
> 
> Refer to the Chapter 3.2 System Board Signal Quality of PCI Express
> Architecture PHY Test Specification Revision 2.0.
> 
> Signal quality tests (for example: jitter, differential eye opening and
> so on) can be executed with devices in the polling.compliance state.
> 
> To let the device support polling.compliance state, the clocks and powers
> shouldn't be turned off when the probe of device driver fails.
> 
> Based on CLB (Compliance Load Board) Test Fixture and so on test
> equipments, the PHY link would be down during the compliance tests.
> Refer to this scenario, add the i.MX PCIe compliance tests mode enable
> support, and keep the clocks and powers on, and finish the driver probe
> without error return.
> 
> Use the "pci_imx6.compliance=1" in kernel command line to enable the
> compliance tests mode.

Sounds good, thanks.
