Return-Path: <linux-pci+bounces-39124-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E40C00012
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 10:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C46583A2E17
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 08:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93E72F6563;
	Thu, 23 Oct 2025 08:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t8Cp2tIv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55372D5A0C
	for <linux-pci@vger.kernel.org>; Thu, 23 Oct 2025 08:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761209400; cv=none; b=RvqDLNXthet8Kp6JEi9hfySkrpZr/wrNxyaI+Q7ZrNtNLoc6Of0wCuLX47nRsVJ1P2s4vzPOMr34pXoq0E0lD9zGtaS0Wv2ryOFwvlww/P03dNgSYO0u2YMM7A0rQ92XFsSZE6y0s78JhvJzoidbIA+9Gxn3ieBeRUOjOioW8KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761209400; c=relaxed/simple;
	bh=Rymmgz0MI2cU8e23Kuu7od6akkRLKSxB0BZixqR/sNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mz8cKvw3r4c5gn1G/B5kgng5+kA+eXfNx5XZMLoNFKs/6Hd/xaMDf5Ghg307CwUNeKiMi6sDv6PE9kv3rN49YWg+IScKymwYkvTR/CgCDbSxCPP71WCAh2jriQgI06rk2DeWUzTQpK6XsqylnqcTbGIV9CmTiZvRdxZBb8m/IDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t8Cp2tIv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9B67C4CEFD;
	Thu, 23 Oct 2025 08:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761209399;
	bh=Rymmgz0MI2cU8e23Kuu7od6akkRLKSxB0BZixqR/sNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t8Cp2tIvt6DoX+HRWQCu7PTbGMw16ZnpnXX/qDPQDmdMqppnvE6P9ZoHnXf8ZOR0o
	 xWYKbVWRfeCjdl4GhGoYtTcsuSCiVGZFiMx+TpayVSZ6EyNuEM78rEdX810OO5Rrrr
	 YWkAEJ+vVxTnlhaurKvq64n668O8xlmlTjDFYoJW7+uVf7xdXRUEAOIdNGwWan0psI
	 JWS7CHzpSwldKknEu7KKvcnUJ4RYHGzGBQHC7n3+VisF5WbMOGwyhRN/XsXdOumtg1
	 Mz57gOlTCxzZ3PrSP1URSuVlc9rMZMBvcLtAoEdLmS9JytaPW19lksE2ZnKAjN4r+i
	 pJ4vyRDxpnREw==
Date: Thu, 23 Oct 2025 14:19:46 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Christian Zigotzky <chzigotzky@xenosoft.de>, 
	Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	linux-pci@vger.kernel.org, mad skateman <madskateman@gmail.com>, 
	"R.T.Dickinson" <rtd2@xtra.co.nz>, Christian Zigotzky <info@xenosoft.de>, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, hypexed@yahoo.com.au, Darren Stevens <darren@stevens-zone.net>, 
	debian-powerpc@lists.debian.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PPC] Boot problems after the pci-v6.18-changes
Message-ID: <vc7ehnmr6tjkkag3j543zwprwqdjyttovav2moo5ravpzzkmbi@qe4tds4e7nc6>
References: <20251015101304.3ec03e6b@bootlin.com>
 <A11312DD-8A5A-4456-B0E3-BC8EF37B21A7@xenosoft.de>
 <20251015135811.58b22331@bootlin.com>
 <4rtktpyqgvmpyvars3w3gvbny56y4bayw52vwjc3my3q2hw3ew@onz4v2p2uh5i>
 <20251023093813.3fbcd0ce@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251023093813.3fbcd0ce@bootlin.com>

On Thu, Oct 23, 2025 at 09:38:13AM +0200, Herve Codina wrote:
> Hi Manivannan,
> 
> On Wed, 15 Oct 2025 18:20:22 +0530
> Manivannan Sadhasivam <mani@kernel.org> wrote:
> 
> > Hi Herve,
> > 
> > On Wed, Oct 15, 2025 at 01:58:11PM +0200, Herve Codina wrote:
> > > Hi Christian,
> > > 
> > > On Wed, 15 Oct 2025 13:30:44 +0200
> > > Christian Zigotzky <chzigotzky@xenosoft.de> wrote:
> > >   
> > > > Hello Herve,
> > > >   
> > > > > On 15 October 2025 at 10:39 am, Herve Codina <herve.codina@bootlin.com> wrote:
> > > > > 
> > > > > ﻿Hi All,
> > > > > 
> > > > > I also observed issues with the commit f3ac2ff14834 ("PCI/ASPM: Enable all
> > > > > ClockPM and ASPM states for devicetree platforms")    
> > > > 
> > > > Thanks for reporting.
> > > >   
> > > > > 
> > > > > Also tried the quirk proposed in this discussion (quirk_disable_aspm_all)
> > > > > an the quirk also fixes the timing issue.    
> > > > 
> > > > Where have you added quirk_disable_aspm_all?  
> > > 
> > > --- 8< ---
> > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > > index 214ed060ca1b..a3808ab6e92e 100644
> > > --- a/drivers/pci/quirks.c
> > > +++ b/drivers/pci/quirks.c
> > > @@ -2525,6 +2525,17 @@ static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
> > >   */
> > >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm_l0s_l1);
> > >  
> > > +static void quirk_disable_aspm_all(struct pci_dev *dev)
> > > +{
> > > +       pci_info(dev, "Disabling ASPM\n");
> > > +       pci_disable_link_state(dev, PCIE_LINK_STATE_ALL);  
> > 
> > Could you please try disabling L1SS and L0s separately to see which one is
> > causing the issue? Like,
> > 
> > 	pci_disable_link_state(dev, PCIE_LINK_STATE_L1_1 | PCIE_LINK_STATE_L1_2);
> > 
> > 	pci_disable_link_state(dev, PCIE_LINK_STATE_L0S);
> > 
> 
> I did tests and here are the results:
> 
>   - quirk pci_disable_link_state(dev, PCIE_LINK_STATE_ALL)
>     Issue not present
> 
>   - quirk pci_disable_link_state(dev, PCIE_LINK_STATE_L1_1 | PCIE_LINK_STATE_L1_2)
>     Issue present, timings similar to timings already reported
>     (hundreds of ms).
> 
>   - quirk pci_disable_link_state(dev, PCIE_LINK_STATE_L0S);
>     Issue present, timings still incorrect but lower
>       64 bytes from 192.168.32.100: seq=10 ttl=64 time=16.738 ms
>       64 bytes from 192.168.32.100: seq=11 ttl=64 time=39.500 ms
>       64 bytes from 192.168.32.100: seq=12 ttl=64 time=62.178 ms
>       64 bytes from 192.168.32.100: seq=13 ttl=64 time=84.709 ms
>       64 bytes from 192.168.32.100: seq=14 ttl=64 time=107.484 ms
> 

This is weird. Looks like all ASPM states (L0s, L1ss) are contributing to the
increased latency, which is more than what should occur. This makes me ignore
inspecting the L0s/L1 exit latency fields :/

Bjorn sent out a patch [1] that enables only L0s and L1 by default. But it
might not help you. I don't honestly know how you are seeing this much of the
latency. This could the due to an issue in the PCI component (host or endpoint),
or even the board routing. Identifying which one is causing the issue is going
to be tricky as it would require some experimentation.

If you are motivated, we can start to isolate this issue to the endpoint first.
Is it possible for you to connect a different PCI card to your host and check
whether you are seeing the increased latency? If the different PCI card is not
exhibiting the same behavior, then the current device is the culprit and we
should be able to quirk it.

- Mani

[1] https://lore.kernel.org/linux-pci/20251020221217.1164153-1-helgaas@kernel.org/

-- 
மணிவண்ணன் சதாசிவம்

