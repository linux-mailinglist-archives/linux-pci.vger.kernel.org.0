Return-Path: <linux-pci+bounces-40931-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 236E7C4F2EB
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 18:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 241DF4EBE7E
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 17:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA487274B3A;
	Tue, 11 Nov 2025 17:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MxxxTUf+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937EC258CD7
	for <linux-pci@vger.kernel.org>; Tue, 11 Nov 2025 17:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762880653; cv=none; b=i14gp41W2ytdDQ8RdukHZsCLt8BfUO1Qrdc1JYCFtGW9S6vygM9OcurZIplFIJLP5QWaKwrwOzN5mx9mjdWA79ZGKwugq9a7+iLWp0y5K3HEa/w0Zx6jLX9xl+2FLxf/5Dk5TiCEjqVd8j4Co2u8W9YqMu2NurIPO/PGmo6MCl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762880653; c=relaxed/simple;
	bh=1DTH9rciYt5dJwtW91HBDQ0Kb7uq1dZOuGmWFAVM17M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=I34KOlv+4lxu7acwRDIXkCL9o64fLTe17NTWpXPR1O8Fex8nHw7HblWL8jL8QGEluHOZOWtI5kjvBhtyVAY9fL4VnJkyTXhydfgD7dBKExDGoPHRBu6Q/jN6ssl/EdM1incOXLZ0R6ZOCECvYHiU66S6wUVyVsxYHuOCzmHaSQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MxxxTUf+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7FB3C19421;
	Tue, 11 Nov 2025 17:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762880653;
	bh=1DTH9rciYt5dJwtW91HBDQ0Kb7uq1dZOuGmWFAVM17M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=MxxxTUf+ZynYIvTuMfUoOzUWDg6ZXrJ9iwLGMLQaxUnm0c/cAeKZq5H+wzsNMAWdR
	 rPhPpc0J8LunKVa6MxUW6ZqfSI5Vk8+mj3a2NUJaVXmt93ay8csZceh/VGOgHPTQFr
	 jmFyQyDUMlIOu6dGIKOxONAZNsJtH7Y2E54yKWXRM8ranYzm3KgZ8QxhRHB0xLj04S
	 QfyYUKDTxKT0UChbSD7Jn6HM+GBFkh3R2PL+lYnCAJmPhGzORMos/IzqG3Va2KsCm1
	 xLmxixwIjFBYVudI8vbYW8vVV9QMwofhHCBb4NS6ytEb4+873FEoo/KrV/254YFs4k
	 YfyGiqilEznpw==
Date: Tue, 11 Nov 2025 11:04:11 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v4] PCI/PTM: Enable PTM only if it advertises a role
Message-ID: <20251111170411.GA2187471@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111154653.GV2912318@black.igk.intel.com>

On Tue, Nov 11, 2025 at 04:46:53PM +0100, Mika Westerberg wrote:
> Hi,
> 
> On Tue, Nov 11, 2025 at 09:39:42AM -0600, Bjorn Helgaas wrote:
> > On Tue, Nov 11, 2025 at 07:10:48AM +0100, Mika Westerberg wrote:
> > > We have a Upstream Port (2b:00.0) that has following in the PTM capability:
> > > 
> > >   Capabilities: [220 v1] Precision Time Measurement
> > > 		PTMCap: Requester- Responder- Root-
> > > 
> > > Linux enables PTM for this without looking into what roles it actually
> > > supports. Immediately after enabling PTM we start getting these:
> > > 
> > >   pci 0000:2b:00.0: [8086:5786] type 01 class 0x060400 PCIe Switch Upstream Port
> > >   ...
> > >   pci 0000:2b:00.0: PTM enabled, 4ns granularity
> > >   ...
> > >   pcieport 0000:00:07.1: AER: Multiple Uncorrectable (Non-Fatal) error message received from 0000:00:07.1
> > >   pcieport 0000:00:07.1: PCIe Bus Error: severity=Uncorrectable (Non-Fatal), type=Transaction Layer, (Receiver ID)
> > >   pcieport 0000:00:07.1:   device [8086:e44f] error status/mask=00200000/00000000
> > >   pcieport 0000:00:07.1:    [21] ACSViol                (First)
> > >   pcieport 0000:00:07.1: AER:   TLP Header: 0x34000000 0x00000052 0x00000000 0x00000000
> > > 
> > > Fix this by enabling PTM only if any of the following conditions are
> > > true (see more in PCIe r7.0 sec 6.21.1 figure 6-21):
> > > 
> > >   - PCIe Endpoint that has PTM capability must to declare requester
> > >     capable
> > >   - PCIe Switch Upstream Port that has PTM capability must declare
> > >     at least responder capable
> > >   - PCIe Root Port must declare root port capable.
> > > 
> > > While there make the enabling happen for all in __pci_enable_ptm() instead
> > > of enabling some in pci_ptm_init() and some in __pci_enable_ptm().
> > > 
> > > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > ---
> > > Previous versions can be seen:
> > > 
> > >   v3: https://lore.kernel.org/linux-pci/20251030134606.3782352-1-mika.westerberg@linux.intel.com/
> > >   v2: https://lore.kernel.org/linux-pci/20251028060427.2163115-1-mika.westerberg@linux.intel.com/
> > >   v1: https://lore.kernel.org/linux-pci/20251021104833.3729120-1-mika.westerberg@linux.intel.com/
> > > 
> > > Changes from v3:
> > > 
> > >   - Cache the responder and requester capability bits.
> > >   - Enable PTM only in __pci_enable_ptm().
> > >   - Update $subject and commit message.
> > >   - Since this is changed quite a lot, I dropped the Reviewed-by from Lukas
> > >     and also stable tag.
> > > 
> > > Changes from v2:
> > > 
> > >   - Limit the check in __pci_enable_ptm() to Endpoints and Legacy
> > >     Endpoints.
> > >   - Added stable tags suggested by Lukas, and PCIe spec reference.
> > >   - Added Reviewed-by tag from Lukas (hope it is okay to keep).
> > > 
> > > Changes from v1:
> > > 
> > >   - Limit Switch Upstream Port only to Responder, not both Requester and
> > >     Responder.
> > > 
> > >  drivers/pci/pcie/ptm.c | 41 ++++++++++++++++++++++++++++++++++++++---
> > >  include/linux/pci.h    |  2 ++
> > >  2 files changed, 40 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
> > > index 65e4b008be00..30e25f1ad28e 100644
> > > --- a/drivers/pci/pcie/ptm.c
> > > +++ b/drivers/pci/pcie/ptm.c
> > > @@ -81,9 +81,12 @@ void pci_ptm_init(struct pci_dev *dev)
> > >  		dev->ptm_granularity = 0;
> > >  	}
> > >  
> > > -	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> > > -	    pci_pcie_type(dev) == PCI_EXP_TYPE_UPSTREAM)
> > > -		pci_enable_ptm(dev, NULL);
> > > +	if (cap & PCI_PTM_CAP_RES)
> > > +		dev->ptm_responder = 1;
> > > +	if (cap & PCI_PTM_CAP_REQ)
> > > +		dev->ptm_requester = 1;
> > > +
> > > +	pci_enable_ptm(dev, NULL);
> > 
> > This seems nice and clean overall.
> > 
> > I do wonder about the fact that previously we automatically enabled
> > PTM only for Root Ports and Switch Upstream Ports, but we didn't
> > enable it for Endpoints until a driver called pci_enable_ptm().
> 
> Oh, that's good point actually.
> 
> Yeah it should be like this still:
> 
> if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
>     pci_pcie_type(dev) == PCI_EXP_TYPE_UPSTREAM)
> 	pci_enable_ptm(dev, NULL);
> 
> To keep the behaviour same.

Makes sense.  We can consider whether and how to avoid enabling it for
Switches later.

> > With this change, it looks like we automatically enable PTM for every
> > device that supports it.  Worth a mention in the commit log, and we
> > might also want to revisit the drivers (ice, idpf, igc, mlx5) that
> > explicitly enable it to remove the enable and disable calls there.
> > 
> > PTM consumes some link bandwidth, so the idea was to avoid paying that
> > cost unless a driver actually wanted to use PTM.  PTM Messages are
> > local, so they terminate at the Switch Downstream Port or Root Port
> > that receives them.  I assumed that Switches would only send PTM
> > Requests upstream if they received a PTM Request from a downstream
> > device, so I thought it would be free to enable PTM on the Switch.
> > 
> > But apparently that isn't true; these errors happen immediately when
> > enabling PTM on the Switch, before it's enabled on any downstream
> > device.  And it makes sense that a Switch could provide better service
> > if it kept its local Time Source updated so it could generate PTM
> > Responses directly instead of sending a request upstream, waiting for
> > a response, and passing it along downstream.
> > 
> > I still feel like it's worth avoiding the bandwidth cost by leaving
> > PTM disabled unless a driver wants it.  The cost is probably small,
> > but why pay it if we're not using PTM?  What are your thoughts?
> 
> Fully agree. It was my mistake. If no objections I'll submit v5 with the
> above added back (+ the newline inconsistency thing Lukas mentioned).

Sounds good.

