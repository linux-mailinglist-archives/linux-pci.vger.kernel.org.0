Return-Path: <linux-pci+bounces-36902-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0ABB9C533
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 00:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31A807A8EF4
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 22:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48BA1286D5C;
	Wed, 24 Sep 2025 22:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9+U0Tcg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18332189;
	Wed, 24 Sep 2025 22:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758751567; cv=none; b=hqkiZVU6UoSrga+Cc98QBIE80DKc3kORHlmgaFiClLET0FPVXCL/3L64fDhNRiw/ptmS46MmZHuiPdJpFrn5szJJ+wSPgkTsPzVStzLcxtdIzTXnjo1S/YpxoWmLWbRpdEsjBN9cgCB+K22Zfx8m2ueC0zll0P8ygyLWTs38Kn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758751567; c=relaxed/simple;
	bh=WtHYzeoqqVSA7DSNSyTBNjNmYwn+bmve6GHaOnB6vKk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=E5kUdMvCYjYBNT6KPnE/ft89webrHQl0+KWFCNfnsK5UVsBpeP7bVQvjnOfZCyhjKYYg85iVWrepzQbWWt4xlEfnUEfAZSfLs0+nxrmAv90veP9D6AcCVTqbLbgwh2Tj8ye2Y7DDLaYFFOY7cv7CfIRSl6r03d5uflJeM4MM/Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9+U0Tcg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79B3DC4CEE7;
	Wed, 24 Sep 2025 22:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758751566;
	bh=WtHYzeoqqVSA7DSNSyTBNjNmYwn+bmve6GHaOnB6vKk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=L9+U0TcgZa4VR23ZVWjm1oxhQhn6R8G99Q0sQ6YDxOAIo8iJpWv6XhgvgMSjlsq/x
	 Pt3qRCWx2Y/lDrwVUnOyGQO0x6IeNm6H/Rvog5uKtclpyXTrhe++udIBc6H0uJ+OAa
	 RPzWB476Wk0uCZ32cHKSgyDVyH0bgkTnQLsur4X/obLzAtD1seFcJO1KxfjwauBie6
	 YB9AfUe6NpxBYniC2nRRY0iOFfdbw7e0VVm4yN/PHcZ9Dz1O1jZMbQpV6SiGWP2ZEg
	 nmG0dDexSJfoUC9993DzFmDjSAtmFrOy3GC5ToBXz2c9EjWCMC+AfK7lXyvZscD5pO
	 i1q3F19f0sKdQ==
Date: Wed, 24 Sep 2025 17:06:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>, jingoohan1@gmail.com,
	l.stach@pengutronix.de, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	bhelgaas@google.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v6 1/4] PCI: dwc: Remove the L1SS check before putting
 the link into L2
Message-ID: <20250924220605.GA2136377@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNRbn+bZ8MP77sdh@lizhi-Precision-Tower-5810>

On Wed, Sep 24, 2025 at 04:59:11PM -0400, Frank Li wrote:
> On Wed, Sep 24, 2025 at 02:44:57PM -0500, Bjorn Helgaas wrote:
> > On Wed, Sep 24, 2025 at 03:23:21PM +0800, Richard Zhu wrote:
> > > The ASPM configuration shouldn't leak out here. Remove the L1SS check
> > > during L2 entry.
> >
> > I'm all in favor of removing this code if possible, but we need to
> > explain why this is safe.  The L1SS check was added for some reason,
> > and we need to explain why that reason doesn't apply.
> 
> That's original discussion
> https://lore.kernel.org/linux-pci/20230720160738.GC48270@thinkpad/
> 
> "To be precise, NVMe driver will shutdown the device if there is no
> ASPM support and keep it in low power mode otherwise (there are
> other cases as well but we do not need to worry).
> 
> But here you are not checking for ASPM state in the suspend path,
> and just forcing the link to be in L2/L3 (thereby D3Cold) even
> though NVMe driver may expect it to be in low power state like
> ASPM/APST.
> 
> So you should only put the link to L2/L3 if there is no ASPM
> support. Otherwise, you'll ending up with bug reports when users
> connect NVMe to it.
> 
> - Mani"

Whatever the reasoning is, it needs to be in the commit log.  The
above might be leading to the reasoning, but it would need a lot more
dots to be connected to be persuasive.

If NVMe is making assumptions about the ASPM configuration, there
needs to be some generic way to keep track of that.  E.g., if NVMe
doesn't work correctly with some ASPM states, maybe it shouldn't
advertise support for those states.  Hacking up every host controller
driver doesn't seem like a viable approach.

> > > Cc: stable@vger.kernel.org
> > > Fixes: 4774faf854f5 ("PCI: dwc: Implement generic suspend/resume functionality")
> > > Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> > > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-designware-host.c | 8 --------
> > >  1 file changed, 8 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > index 952f8594b501..9d46d1f0334b 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > @@ -1005,17 +1005,9 @@ static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
> > >
> > >  int dw_pcie_suspend_noirq(struct dw_pcie *pci)
> > >  {
> > > -	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> > >  	u32 val;
> > >  	int ret;
> > >
> > > -	/*
> > > -	 * If L1SS is supported, then do not put the link into L2 as some
> > > -	 * devices such as NVMe expect low resume latency.
> > > -	 */
> > > -	if (dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL) & PCI_EXP_LNKCTL_ASPM_L1)
> > > -		return 0;
> > > -
> > >  	if (pci->pp.ops->pme_turn_off) {
> > >  		pci->pp.ops->pme_turn_off(&pci->pp);
> > >  	} else {
> > > --
> > > 2.37.1
> > >

