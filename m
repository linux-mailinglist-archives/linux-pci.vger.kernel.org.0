Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDD6857262C
	for <lists+linux-pci@lfdr.de>; Tue, 12 Jul 2022 21:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbiGLToD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Jul 2022 15:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234952AbiGLTni (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jul 2022 15:43:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05022E7;
        Tue, 12 Jul 2022 12:26:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D8EF617D6;
        Tue, 12 Jul 2022 19:26:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DE05C3411C;
        Tue, 12 Jul 2022 19:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657653977;
        bh=Dl1Pbbf4nopDVy3CXbIsWo5vkYq+vL0gOkvpMdkCOqU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Oe28BriMJpstGaTaoz77v1U25xR+k9/ve4jnVrdEpfHETLLa5zBNvfNYq5Pby5O16
         Hk+ejdhPOpiPtAFq+xIcEsQNZ5VVbu0Vi7YRtF6FDaMrSP7y7qVZjY8clqahlprYU6
         uOlc/KfwV/1iU4u3/uPb74DcRfUxvPQ6u2keImFS3IZjbQ1Xl4DldVyQ7WngPS1Dmg
         YLc82jHu9HnlcC0ckRn2MAgfGLGjJj6fvr03akEu1qi2oKkrNwnECfr+/8hROhLhap
         +rEmSV5eG961/JNVg7fEgm9zzsrH02yRNHxM0a5gcZbOc3kOzv5s++KSphM+5UV+aN
         jZDNB7tAm5Z8Q==
Date:   Tue, 12 Jul 2022 14:26:16 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Hongxing Zhu <hongxing.zhu@nxp.com>
Cc:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [RFC 1/2] PCI: imx6: Make sure the DBI register can be changed
Message-ID: <20220712192616.GA787788@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS8PR04MB8676FA05BEEE264A9FE1F6538C869@AS8PR04MB8676.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 12, 2022 at 01:30:02AM +0000, Hongxing Zhu wrote:
> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > Sent: 2022年7月12日 6:17
> > To: Hongxing Zhu <hongxing.zhu@nxp.com>
> > Cc: l.stach@pengutronix.de; bhelgaas@google.com;
> > lorenzo.pieralisi@arm.com; festevam@gmail.com; linux-pci@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> > kernel@pengutronix.de; dl-linux-imx <linux-imx@nxp.com>
> > Subject: Re: [RFC 1/2] PCI: imx6: Make sure the DBI register can be changed
> > 
> > Hi Richard,
> > 
> > On Wed, May 18, 2022 at 05:35:27PM +0800, Richard Zhu wrote:
> > > The PCIE_DBI_RO_WR_EN bit should be set when write some DBI registers.
> > > To make sure that the DBI registers are writable, set the
> > > PCIE_DBI_RO_WR_EN properly when touch the DBI registers.
> > >
> > > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > ---
> > >  drivers/pci/controller/dwc/pci-imx6.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> > > b/drivers/pci/controller/dwc/pci-imx6.c
> > > index 6619e3caffe2..30641d2dda14 100644
> > > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > > @@ -797,10 +797,12 @@ static int imx6_pcie_start_link(struct dw_pcie
> > *pci)
> > >  	 * started in Gen2 mode, there is a possibility the devices on the
> > >  	 * bus will not be detected at all.  This happens with PCIe switches.
> > >  	 */
> > > +	dw_pcie_dbi_ro_wr_en(pci);
> > 
> > What's the status of this patch?  I don't see this change included in your v14
> > series [1].  That series has a lot of imx6 updates, so I would have thought
> > you'd include this change in it.  Or maybe this change turned out not to be
> > needed?
> Hi Bjorn:
> Thanks for your kindly help.
> The v14 series[1] had been reviewing for a quite time. I'm afraid that
>  this series might miss the L5.20 merge window if I add new patch
>  into it from time to time.
> If you don't think so, I can merge the first one, and re-issue the v15 a
> moment later.
> > 
> > What about the 2/2 patch?
> i.MX8MP PCIe supports the PCIe GEN3 speed, the second patch is used to extend
>  the link speed support capability, and prepared for i.MX8MP PCIe support.
> I assumed that these two patches can be contained in i.MX8MP PCIe support
> patch-set before.

I applied both these patches on pci/ctrl/imx6 for v5.20, thanks!

Bjorn
