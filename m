Return-Path: <linux-pci+bounces-31659-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C00AFC462
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 09:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00B40179077
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 07:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CBC29993D;
	Tue,  8 Jul 2025 07:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QiizzGcu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5A71FFC41;
	Tue,  8 Jul 2025 07:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751960530; cv=none; b=bcsBG9tZ+uVrWBNhBfRUDQgkkFTrgCcRMshSaqWyf28KvJTCP50f8W22nAij6VrXXAUf39xrcOA6gktt8z7ildGUrGC4FY/algYsaDU7yKzA2JRSA7qbV3GMPpEWhRzqnA0j7+F2KytGbRoadz/+sz8ZBtFex7aqRcQZ4zUIJEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751960530; c=relaxed/simple;
	bh=cu8tPtnIUR3fiQLsu8sRQhSmqshZhYdBxyLo1WB3PBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4CuN88dj3Q/7dP3dOyM0OCtDNA7nf48U6F7ngTtA6bslJUcTzWIOTfRUGbGTPvXMCRYc5wyZ3ZWkieaGQuS2RHltbpYwR6Z4ROQPeT5F7vur1/7Qk3HLwwtJehg8zy+cdpYIE/R/P/rA6Qnf2afT1TbxuXS8myf2zSoSyGmMbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QiizzGcu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27334C4CEED;
	Tue,  8 Jul 2025 07:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751960529;
	bh=cu8tPtnIUR3fiQLsu8sRQhSmqshZhYdBxyLo1WB3PBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QiizzGcu3oRSNRBv2aXILXXI1jg/Hc9yWXALIH5umhNyhCXU4T26Edl4g/GJM58CG
	 ujpBuIVs0g4usaLKSn2uI8/JFIkS9F72TnBwAO4uzliU8HW7+Q+4D1s2rHMDXc1jov
	 SP8z9v8nUn5uZY205/ZM2aSHwc/lkkqpepGaRNVyI7RJdbKlbMYR5W7+YbzndanibP
	 i90De+r0ey0cfLKrt02T2SG6pjMujzQqnB128lrSkEVDiUrR6D0x3yEtPT3ooRh5Ml
	 DJwJINdjIuIQ6syHiFKJMa7OKU8yMupCzT11l2q7f6CejvPGwW3gf5zxama9IeVNPu
	 WC1wzom8PBMIA==
Date: Tue, 8 Jul 2025 13:11:59 +0530
From: "mani@kernel.org" <mani@kernel.org>
To: Hongxing Zhu <hongxing.zhu@nxp.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Frank Li <frank.li@nxp.com>, 
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>, 
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "robh@kernel.org" <robh@kernel.org>, 
	"bhelgaas@google.com" <bhelgaas@google.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, 
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, 
	"festevam@gmail.com" <festevam@gmail.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] PCI: imx6: Correct the epc_features of i.MX8M chips
Message-ID: <pxxwlm6su6ugfo4m7borpgvvlczfrhdarzcy45fipqwvxaxban@u223udsukdwc>
References: <20250617073441.3228400-1-hongxing.zhu@nxp.com>
 <20250707193415.GA2095765@bhelgaas>
 <AS8PR04MB8676B8D14A5C54E8C32025BD8C4EA@AS8PR04MB8676.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS8PR04MB8676B8D14A5C54E8C32025BD8C4EA@AS8PR04MB8676.eurprd04.prod.outlook.com>

On Tue, Jul 08, 2025 at 07:34:57AM GMT, Hongxing Zhu wrote:
> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > Sent: 2025年7月8日 3:34
> > To: Hongxing Zhu <hongxing.zhu@nxp.com>
> > Cc: Frank Li <frank.li@nxp.com>; l.stach@pengutronix.de;
> > lpieralisi@kernel.org; kwilczynski@kernel.org; mani@kernel.org;
> > robh@kernel.org; bhelgaas@google.com; shawnguo@kernel.org;
> > s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com;
> > linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > imx@lists.linux.dev; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v2] PCI: imx6: Correct the epc_features of i.MX8M chips
> > 
> > On Tue, Jun 17, 2025 at 03:34:41PM +0800, Richard Zhu wrote:
> > > i.MX8MQ PCIes have three 64-bit BAR0/2/4 capable and programmable
> > BARs.
> > > But i.MX8MM and i.MX8MP PCIes only have BAR0/BAR2 64bit
> > programmable
> > > BARs, and one 256 bytes size fixed BAR4.
> > >
> > > Correct the epc_features for i.MX8MM and i.MX8MP PCIes here. i.MX8MQ
> > > is the same as i.MX8QXP, so set i.MX8MQ's epc_features to
> > > imx8q_pcie_epc_features.
> > >
> > > Fixes: 75c2f26da03f ("PCI: imx6: Add i.MX PCIe EP mode support")
> > > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > 
> > "Correct the epc_features" doesn't include any specific information, and it's
> > hard to extract the changes for a device from the commit log.
> > 
> > This is really two fixes that should be separated so the commit logs can be
> > specific:
> Yes, it's right.
> Since it's just one line change for i.MX8MQ. So, I combine the changes into
> this commit for i.MX8M chips.
> 
> Hi Mani:
> Since it had been applied, I don't know how to proceed.
> Should I separate this commit into two patches, and re-send them again?
> Thanks.
> 

I've now dropped the patch from controller/imx6. Please resend them. Also, CC
the stable list with relevant Fixes tag.

- Mani

> Best Regards
> Richard Zhu
> > 
> >   - For IMX8MQ_EP, use imx8q_pcie_epc_features (64-bit BARs 0, 2, 4)
> >     instead of imx8m_pcie_epc_features (64-bit BARs 0, 2).
> > 
> >   - For IMX8MM_EP and IMX8MP_EP, add fixed 256-byte BAR 4 in
> >     imx8m_pcie_epc_features.
> > 
> > > ---
> > >  drivers/pci/controller/dwc/pci-imx6.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> > > b/drivers/pci/controller/dwc/pci-imx6.c
> > > index 5a38cfaf989b..9754cc6e09b9 100644
> > > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > > @@ -1385,6 +1385,8 @@ static const struct pci_epc_features
> > imx8m_pcie_epc_features = {
> > >  	.msix_capable = false,
> > >  	.bar[BAR_1] = { .type = BAR_RESERVED, },
> > >  	.bar[BAR_3] = { .type = BAR_RESERVED, },
> > > +	.bar[BAR_4] = { .type = BAR_FIXED, .fixed_size = SZ_256, },
> > > +	.bar[BAR_5] = { .type = BAR_RESERVED, },
> > >  	.align = SZ_64K,
> > >  };
> > >
> > > @@ -1912,7 +1914,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
> > >  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
> > >  		.mode_off[1] = IOMUXC_GPR12,
> > >  		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
> > > -		.epc_features = &imx8m_pcie_epc_features,
> > > +		.epc_features = &imx8q_pcie_epc_features,
> > >  		.init_phy = imx8mq_pcie_init_phy,
> > >  		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
> > >  	},
> > > --
> > > 2.37.1
> > >

-- 
மணிவண்ணன் சதாசிவம்

