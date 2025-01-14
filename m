Return-Path: <linux-pci+bounces-19763-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C41DA1125B
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 21:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F374416B371
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 20:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B00020C46E;
	Tue, 14 Jan 2025 20:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvTvJaMf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C66C20C033;
	Tue, 14 Jan 2025 20:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736887390; cv=none; b=OObUmo/d/yhxlcQ175zmkEZ6srnz8S5qTX799spqgS6JxhdG2qNgTaUV7Z6S9r9uGeTJODNAfYf603UNSiEA42RBb06G6zgXPvZht6h2UHimc5rMtAycFk9U9J/OQPOSmaewO3dXc8BvAhBx4Gf0XaTUPHrAFTZwb/fa+9pxwk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736887390; c=relaxed/simple;
	bh=5naPrUPLbxOci8cRt6E7sbCrTb/uthSYLIIodI0L0DY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=gFm5tTqivbfOkW8XU2S0zvbhJHQBnNWjYMoAJt90A+Pg/fplciCU0qq1TvnVDcvEautzkmwGz/NQv+RQua04F8nLilmOuMx/XgvmnrV1IUxNVjEIvs84VddtKGPj7Tk50yQhD2U7qQ2MIaKsDrQ3km9etixEcC5Ne5zlp2sk3AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvTvJaMf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA3DDC4CEDD;
	Tue, 14 Jan 2025 20:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736887389;
	bh=5naPrUPLbxOci8cRt6E7sbCrTb/uthSYLIIodI0L0DY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=mvTvJaMfuz4yz1QXa5ogoibM3cSDwychVjUYZAfG1VaN9Hly9rBvWL8dvzmwyXTuG
	 GEbvKRAWcNFu+rw2P1IDE9cwqz7353suMLlc1lQEVynkau74URracDE4xF4hZPIFYt
	 dLSATmXYuxLwmRiNwSLmQ19SuHF7UtKjV5JjhPA7tan1o5lnN+3c8gLV21bAhcC6Ff
	 z2uHCcwP8HhJqFVDHFuqb/8TqZh5ptQMD6TUP90a1aIxHxXgwEAYkmo4wg7AC8Qtp3
	 d7B9tnOgAigf5MklJW+/1AGU2X4nKVLIntGTnGKRyI60yBdhhLlA1bT6ZzxxKi+9JK
	 7UrdqN+MvDsIw==
Date: Tue, 14 Jan 2025 14:43:07 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>, dlemoal@kernel.org,
	jingoohan1@gmail.com, bhelgaas@google.com, lpieralisi@kernel.org,
	kw@linux.com, manivannan.sadhasivam@linaro.org, robh@kernel.org,
	quic_krichai@quicinc.com, imx@lists.linux.dev,
	kernel@pengutronix.de, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] PCI: dwc: Always stop link in the
 dw_pcie_suspend_noirq
Message-ID: <20250114204307.GA484338@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114202622.GA483044@bhelgaas>

On Tue, Jan 14, 2025 at 02:26:25PM -0600, Bjorn Helgaas wrote:
> On Tue, Jan 14, 2025 at 02:32:38PM -0500, Frank Li wrote:
> > On Tue, Jan 14, 2025 at 12:15:18PM -0600, Bjorn Helgaas wrote:
> > > On Tue, Dec 10, 2024 at 04:15:56PM +0800, Richard Zhu wrote:
> > > > On i.MX8QM, PCIe link can't be re-established again in
> > > > dw_pcie_resume_noirq(), if the LTSSM_EN bit is not cleared properly in
> > > > dw_pcie_suspend_noirq().
> > > >
> > > > Add dw_pcie_stop_link() into dw_pcie_suspend_noirq() to fix this issue and
> > > > keep symmetric in suspend/resume function since there is
> > > > dw_pcie_start_link() in dw_pcie_resume_noirq().
> > > >
> > > > Fixes: 4774faf854f5 ("PCI: dwc: Implement generic suspend/resume functionality")
> > > > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > ---
> > > >  drivers/pci/controller/dwc/pcie-designware-host.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > index f882b11fd7b94..f56cb7b9e6f99 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > @@ -1001,6 +1001,7 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
> > > >  		return ret;
> > > >  	}
> > > >
> > > > +	dw_pcie_stop_link(pci);
> > >
> > > We should try to avoid changes to the generic DWC path just to
> > > accommodate one controller.  Since other DWC-based controllers
> > > apparently don't need dw_pcie_stop_link() here, this seems like it
> > > might be the wrong place for this change.
> > >
> > > If doing dw_pcie_stop_link() here is really helpful for all DWC
> > > controllers, this would be fine, but the commit log should then explain
> > > why it helps everybody, not why one particular controller benefits.
> > 
> > It should be for all dwc controllers although find such problem at i.MX8QM
> > platfrom. It should keep symmetric between suspend/resume function.
> > 
> > So far only layerscape and i.MX platform use these common functions. Other
> > dwc platform still have not switched to this common function yet.
> 
> I see that layerscape uses dw_pcie_suspend_noirq():
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/dwc/pci-layerscape.c?id=v6.13-rc7#n379
> 
> But I don't see where imx6 does:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/dwc/pci-imx6.c?id=v6.13-rc7#n1236
> 
> We don't currently have anything queued that touches pci-imx6.c; am I
> missing a patch that converts pci-imx6.c to use
> dw_pcie_suspend_noirq()?

I guess it's this series:

  https://lore.kernel.org/all/20241126075702.4099164-1-hongxing.zhu@nxp.com/

where "[PATCH v7 08/10] PCI: imx6: Use dwc common suspend resume
method" does this conversion.

I see some review of v6
(https://lore.kernel.org/r/20241101070610.1267391-1-hongxing.zhu@nxp.com),
but no comments for v7, although Mani has already reviewed six of the
ten.

> This doesn't feel urgent yet since the commit log talks about i.MX8QM,
> but I can't make a connection between i.MX8QM and this patch.
> 
> Bjorn

