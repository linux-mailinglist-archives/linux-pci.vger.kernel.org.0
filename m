Return-Path: <linux-pci+bounces-37128-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A3FBA50E5
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 22:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C9D1383DC5
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 20:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C94E284669;
	Fri, 26 Sep 2025 20:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cvLnz60z"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7027260A;
	Fri, 26 Sep 2025 20:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758918273; cv=none; b=BC/LGDzC6usBsmsj+pAcTIm3+ZwxImuHdJa7v4V9lQo9zIfoAsCavs6YzXgqwwOEoMRHxBZhcg9lDmeFJIuOtYGdBTiC7bSqmhNUUlEciI2lyspMDLErAqbezyox2M3WGgzvkkOfHs7PISIuyc5EQ6dgjp3vjQSsWoYtX4Sq37A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758918273; c=relaxed/simple;
	bh=/MPD/u4t2P88SZ2+0r0a12nQc9p4Xw3KAEkXXioGITQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KOh11EExoDgKQU1Ur+BUQsT9fcdsHRsE2LVazwhFntxqouSt3yPzmuTE+MLtpXZQnHonDBcbm2oSDEhfYRtlcZ7JTJ8NMV0nnETOTzBJp3VP01ToA9VgUHPWXVL12tO7i6MX58las8du/t9Gdt3d+rfv9a9QYlE2tU/Mo+bmWA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cvLnz60z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A293AC4CEF4;
	Fri, 26 Sep 2025 20:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758918272;
	bh=/MPD/u4t2P88SZ2+0r0a12nQc9p4Xw3KAEkXXioGITQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=cvLnz60zbKZb2fagJbMrNIq5h1vEz+TsG3+VLKWlS+EkGFq9lSd+y5NzIKBRInoJH
	 GRksN1MO0P61n+VCf0HLJObhdgc4SAcvL7Vs/WMDdZoKDZpCln+WXpm2HbbueDUDcf
	 8F43oTrr4HwXk0a7qfhLhWLzx8KMe9gSuPcOMidSmtXT4ShZrXOsXgGWERt9WKDOLd
	 duBN12/yE6HX5kGbc2bv0HsWRschDz/H2L4JPsbjt/995NiCaP4zVwRdMSTrKl28gH
	 /NqWmg/Mg5XwkljYXlovgzg6M64J47OzsIAofLz5qMLEs843Nx5rCMCyFza99aGwpp
	 iSw4JaArBXwKQ==
Date: Fri, 26 Sep 2025 15:24:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hongxing Zhu <hongxing.zhu@nxp.com>
Cc: Frank Li <frank.li@nxp.com>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/2] PCI: imx6: Add a method to handle CLKREQ#
 override active low
Message-ID: <20250926202431.GA2264754@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR04MB88335EEF20BA7FCF723F81208C1EA@AS8PR04MB8833.eurprd04.prod.outlook.com>

On Fri, Sep 26, 2025 at 03:23:43AM +0000, Hongxing Zhu wrote:
> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>

> > On Fri, Sep 26, 2025 at 02:19:37AM +0000, Hongxing Zhu wrote:
> > > > -----Original Message-----
> > > > From: Bjorn Helgaas <helgaas@kernel.org> On Tue, Sep 23, 2025 at
> > > > 03:39:13PM +0800, Richard Zhu wrote:
> > > > > The CLKREQ# is an open drain, active low signal that is driven low
> > > > > by the card to request reference clock. It's an optional signal
> > > > > added in PCIe CEM r4.0, sec 2. Thus, this signal wouldn't be
> > > > > driven low if it's reserved.
> > > > >
> > > > > Since the reference clock controlled by CLKREQ# may be required by
> > > > > i.MX PCIe host too. To make sure this clock is ready even when the
> > > > > CLKREQ# isn't driven low by the card(e.x the scenario described
> > > > > above), force CLKREQ# override active low for i.MX PCIe host
> > > > > during initialization.
> > > > >
> > > > > The CLKREQ# override can be cleared safely when supports-clkreq is
> > > > > present and PCIe link is up later. Because the CLKREQ# would be
> > > > > driven low by the card at this time.
> > > >
> > > > What happens if we clear the CLKREQ# override (so the host doesn't
> > > > assert it), and the link is up but the card never asserts CLKREQ#
> > > > (since it's an optional signal)?
> > > >
> > > > Does the i.MX host still work?
> > >
> > > The CLKREQ# override active low only be cleared when link is up
> > > and supports-clkreq is present. In the other words, there is a
> > > remote endpoint  device, and the CLKREQ# would be driven active
> > > low by this endpoint device.
> > 
> > Assume an endpoint designed to CEM r2.0.  CLKREQ# doesn't exist in
> > CEM r2.0, so even if the endpoint is present and the link is up,
> > the endpoint will not assert CLKREQ#.
> > 
> > Will the i.MX host still work?
> > 
> > IIUC, CLKREQ# is required for ASPM L1 PM Substates.  Maybe the
> > CLKREQ# override should only be cleared if the endpoint advertises
> > L1 PM Substates support?
>
> CLKREQ# override active low only be cleared when the endpoint
> advertises that it has L1 PM Substates support or it always drives
> CLKREQ# low.

What?  That's not what the patch does.  It calls .clr_clkreq_override()
whenever the link is up and devicetree contains 'support-clkreq'.

A device advertises L1 PM Substates support by putting the L1 PM
Substates Capability in its config space.

> > > > > static void imx_pcie_host_post_init(struct dw_pcie_rp *pp)
> > > > >  		dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
> > > > >  		dw_pcie_dbi_ro_wr_dis(pci);
> > > > >  	}
> > > > > +
> > > > > +	/* Clear CLKREQ# override if supports_clkreq is true and link is up */
> > > > > +	if (dw_pcie_link_up(pci) && imx_pcie->supports_clkreq) {
> > > > > +		if (imx_pcie->drvdata->clr_clkreq_override)
> > > > > +			imx_pcie->drvdata->clr_clkreq_override(imx_pcie);
> > > > > +	}

