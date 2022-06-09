Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E091D5452D5
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jun 2022 19:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239147AbiFIRUN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jun 2022 13:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237908AbiFIRUL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jun 2022 13:20:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F8510A626;
        Thu,  9 Jun 2022 10:20:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D3DF2B82CF1;
        Thu,  9 Jun 2022 17:20:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A294C34114;
        Thu,  9 Jun 2022 17:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654795207;
        bh=4NBmqBaLVY+yEmiNx4pjhS4d00HTDgx39QqkUmgT31Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=hX5PbRpEXk03UpYoLoF3BSzu2mTvSdWIS2Gtshh1PrRcCxQbELdYJnLUugLyF2GkH
         kZgNxJ/29o/0r79EIUvzKXv/hIN/FQB1ef+v6M7yEHREzK80bqS/PczhbaYWEcbJ/I
         v2EXX0d37HVcN7M1opZzMOadRxlBQjO/Zun4KGa6cQ7M0WcyXkg4RyT0xeZ4+HidTs
         lcOUN/HEKjGmk0cly2IGUSdbu7x3p7DGoEpa61PuJBRaWA6qQHdRcx86aTQS3a96Y3
         Pxz6eS821Q8/bcHVOq5wkADwMwoj/zeGbygiuTTXV4uHGLXkIQc13bPKqA8nZWF3Ov
         jq1HQ5szGRpPg==
Date:   Thu, 9 Jun 2022 12:20:05 -0500
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
Subject: Re: [PATCH v9 5/8] PCI: imx6: Refine the regulator usage
Message-ID: <20220609172005.GA514802@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS8PR04MB8676EFCB2BA9C1DD0F33C4FA8CA79@AS8PR04MB8676.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 09, 2022 at 06:19:47AM +0000, Hongxing Zhu wrote:
> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > Sent: 2022年6月9日 2:55
> > To: Hongxing Zhu <hongxing.zhu@nxp.com>
> > Cc: l.stach@pengutronix.de; bhelgaas@google.com; robh+dt@kernel.org;
> > broonie@kernel.org; lorenzo.pieralisi@arm.com; jingoohan1@gmail.com;
> > festevam@gmail.com; francesco.dolcini@toradex.com;
> > linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > linux-kernel@vger.kernel.org; kernel@pengutronix.de; dl-linux-imx
> > <linux-imx@nxp.com>
> > Subject: Re: [PATCH v9 5/8] PCI: imx6: Refine the regulator usage
> > 
> > On Fri, May 06, 2022 at 09:47:06AM +0800, Richard Zhu wrote:
> > > The driver should undo any enables it did itself. The regulator
> > > disable shouldn't be basing decisions on regulator_is_enabled().

The driver should disable things if an error occurs after it has
enabled something, or if it enabled something during probe and we're
now detaching the driver.  That doesn't look like the case here.

> > > To keep the balance of the regulator usage counter, disable the
> > > regulator just behind of imx6_pcie_assert_core_reset() in resume and
> > > shutdown.
> > 
> > In subject, "Refine" doesn't tell me anything about what's happening here.
>
> Thanks for your comments.
> How about the following one?
> PCI: imx6: Do regulator disable without the regulator_is_enabled check

That's too low-level, like describing the C code line by line.
I'm hoping for something about the purpose for the patch so
"git log --oneline" can tell a coherent story.

Apparently this is about disabling the power regulator when the slot
isn't being used, so maybe it could say something about that.

  $ git grep -Ep "regulator_(en|dis)able" drivers/pci/controller/

shows that in other drivers, this being done in
probe/remove/suspend/resume-type paths.  imx6 should be similar.

Bjorn
