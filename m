Return-Path: <linux-pci+bounces-34325-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D2CB2CD00
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 21:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 350554E04A2
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 19:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560A8326D65;
	Tue, 19 Aug 2025 19:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rY5G6YqM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EE6285CBB;
	Tue, 19 Aug 2025 19:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755632018; cv=none; b=RCRMbBo7mYxB6n1pOz6HtDBCyT0NK3RUD0VVH7NeciB0iRhPQfsw2SsqNd8LY1gpq/mt1aPsF8/I/VnC4/qB5la4iZ5pNfy66Fq2EVJcAaDSBVaOyyyqkkL9GDe8oelnk73ndGBGQcM+Ua7jlfrvnZfnPLnNPZtB6nxhtT5ebIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755632018; c=relaxed/simple;
	bh=AHSmGNb1muH/++bYQyHtCOXRefIvHL5FtP/WnzUyhyI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=djDSr8xlrA8DVlcw5ZlhnMSgvnIjMS0wxS8CUyDCyKb5s8Bzq3NNh9Yv2tA4Y8Dnd//6dgG9/d1nv5zMKlifQ0PGGr5Ru1lMm7pXgzOOAcHXJK5uFxpvmb6oQZ6NInBk/1DQEdgV0JGCYri1Wkeq+Mp9Xvk6Utz6mnij7UIWsy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rY5G6YqM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC91C4CEF1;
	Tue, 19 Aug 2025 19:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755632017;
	bh=AHSmGNb1muH/++bYQyHtCOXRefIvHL5FtP/WnzUyhyI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=rY5G6YqMNHBJ7g1+ElR0XGhrZUvig859ScN/e8vVUOQM22d4lWMcUNr4LTFo1yrEG
	 OL21YfyTG1UOyK5ZYVAiBpIpkE1vVI0cm9nigxVjY/CfUBovzp8twUUx0EG5nNysoK
	 6w2uiyobZ94hkUdfuy7FisKTg88JkZWIQ8D6BscREKg9ECJbnGRKDAC8fs0Yj9yx1e
	 /tWHRCw+e324DCI6q5PbKgkPQ7BvUWlEbmrZx8sr6miFJIi9LHTt4uCYWJNpuQo09y
	 eGqHeVgzMZKZR7eROhDJnybc4baDZ/T3srjub3K1LUJrveDVgvg7BDwcrSyFR2Vv/v
	 s9WAl4aKwAEGg==
Date: Tue, 19 Aug 2025 14:33:36 -0500
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
Subject: Re: [RESEND v3 1/5] PCI: dwc: Don't poll L2 if QUIRK_NOL2POLL_IN_PM
 is existing in suspend
Message-ID: <20250819193336.GA588734@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR04MB88338A64A256C92CE64A02018C30A@AS8PR04MB8833.eurprd04.prod.outlook.com>

On Tue, Aug 19, 2025 at 05:51:41AM +0000, Hongxing Zhu wrote:
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > On Mon, Aug 18, 2025 at 03:32:01PM +0800, Richard Zhu wrote:
> > > Refer to PCIe r6.0, sec 5.2, fig 5-1 Link Power Management State Flow
> > > Diagram. Both L0 and L2/L3 Ready can be transferred to LDn directly.
> ...

> > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > @@ -1007,7 +1007,7 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
> > > {
> > >  	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> > >  	u32 val;
> > > -	int ret;
> > > +	int ret = 0;
> > >
> > >       /*
> > >        * If L1SS is supported, then do not put the link into L2 as
> > > some
> >          * devices such as NVMe expect low resume latency.
> >          */
> >          if (dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL) &
> > PCI_EXP_LNKCTL_ASPM_L1)
> >                 return 0;
> > 
> > You didn't change it in this patch (the L1SS test was added by
> > 4774faf854f5 ("PCI: dwc: Implement generic suspend/resume
> > functionality")), but this L1SS check is an encapsulation problem.
> > The ASPM configuration shouldn't leak out here in such an ad hoc
> > way.

> Should I created another commit to get ride of the L1SS check codes?

If we remove that check, I guess we would put the link into L2 when
ASPM L1 is enabled (not when "L1SS is supported" as the comment
claims).

Obviously this check was added for a reason, so I assume something bad
would happen if we removed it.  But at the same time, AFAICS this
check only applies to imx6 and layerscape because none of the other
drivers use dw_pcie_suspend_noirq().

So yes, I do think it should be removed because it's only a partial
band-aid for whatever the problem is.  It would probably break
something, but it looks to me like it's already broken on most
platforms, and we need to figure out a real solution that fixes
everybody.

> > *All* drivers, not just NVMe, would prefer low resume latency.
> > 
> > How do we deal with this in other host controller drivers?  If any
> > other driver puts links in L2, I suppose they would have the same
> > issue?  Maybe DWC is the only one that puts the link in L2?
> > 
> > What happens when we add a new driver that puts links in L2?  I
> > guess we'll be debugging some NVMe issue again?
>
> Up to now, this is the first one routine to do the L1SS check in L2
> entry.

