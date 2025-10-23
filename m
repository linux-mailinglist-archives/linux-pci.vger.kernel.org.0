Return-Path: <linux-pci+bounces-39125-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D05D5C0037C
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 11:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 946F01A649F9
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 09:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545C92FE58C;
	Thu, 23 Oct 2025 09:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Wo2xU9lB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC5F2ED14B
	for <linux-pci@vger.kernel.org>; Thu, 23 Oct 2025 09:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761211222; cv=none; b=XXnE25qaVDc5VDIVOpC7qrWRCBSTUxPl3vWMk7JemBNrOHFt2bagptOgO2th5NfVxR2UBXAs7K45Sv+pYMwoIEG7SJggCVj/ZfF05tIk66TN0ebU8dElpudamu7u6SHupxt+7+jBg2L/4qffbpIORYdi500HaZ7iBIKsbfzP5oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761211222; c=relaxed/simple;
	bh=8p7EDMuJU8RfJbOjxp6oUbrn0l41E1Xl2hTyV8hz3Mk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GePhrEmc05DtGVzaoIYnISIbj0wHW6FPqJ3Il6A1GA5qkMPRdObFkqhnGjB9pvAos1qldpeSUe0RqP7rsEkXO5ufpVU/Gr/2QOZ5/YcgQkeEmy3HpU+hBjqW0NmtWsqWvyhRbpfp9igKTiCzaB733+MHO8QTP+ijJw53c5ieHdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Wo2xU9lB; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 76B7D1A1619;
	Thu, 23 Oct 2025 09:20:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 435186062C;
	Thu, 23 Oct 2025 09:20:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 380AE102F2461;
	Thu, 23 Oct 2025 11:19:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761211211; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=7iEQ8Hi8YDiUH5n8pt36cUx2rV4zMT41Lo5e4XDnYiY=;
	b=Wo2xU9lBz8Jw4UJwCyntVY7xyccvqn7f1+wuWv5YaV2fAdkDhA47yH76qdNdTSuVHgCu03
	XX3o75P1rdEfETnXTdyp8/U7e8uEiCDbseFwXrp5CvxLFxfxcoRIP2tj+F/W2uunnDM8bZ
	R3yDEYbUNzTyNSBVO2fgk5IsBcu05e9g3q8CX4blVX81HCW6h6MrFaCD3ZRmckv4S4h+s6
	jka7guD/tLqD/DQNNLdjQXmXOO1l13BgR/gUIOh5eRA6Vt5d/C/qcugJ/MfpK7SRqEtU9H
	Rrpd+KGt2a+hK1rDiDuGm4mDfZUnSG/6ou7GbepX20xKHGr5jA3zrhyIfdUoYQ==
Date: Thu, 23 Oct 2025 11:19:47 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Christian Zigotzky <chzigotzky@xenosoft.de>, Bjorn Helgaas
 <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>, Manivannan Sadhasivam
 <manivannan.sadhasivam@oss.qualcomm.com>, Ilpo =?UTF-8?B?SsOkcnZpbmVu?=
 <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org, mad skateman
 <madskateman@gmail.com>, "R.T.Dickinson" <rtd2@xtra.co.nz>, Christian
 Zigotzky <info@xenosoft.de>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 hypexed@yahoo.com.au, Darren Stevens <darren@stevens-zone.net>,
 debian-powerpc@lists.debian.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PPC] Boot problems after the pci-v6.18-changes
Message-ID: <20251023111947.6e960216@bootlin.com>
In-Reply-To: <vc7ehnmr6tjkkag3j543zwprwqdjyttovav2moo5ravpzzkmbi@qe4tds4e7nc6>
References: <20251015101304.3ec03e6b@bootlin.com>
	<A11312DD-8A5A-4456-B0E3-BC8EF37B21A7@xenosoft.de>
	<20251015135811.58b22331@bootlin.com>
	<4rtktpyqgvmpyvars3w3gvbny56y4bayw52vwjc3my3q2hw3ew@onz4v2p2uh5i>
	<20251023093813.3fbcd0ce@bootlin.com>
	<vc7ehnmr6tjkkag3j543zwprwqdjyttovav2moo5ravpzzkmbi@qe4tds4e7nc6>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Manivannan,

On Thu, 23 Oct 2025 14:19:46 +0530
Manivannan Sadhasivam <mani@kernel.org> wrote:

> On Thu, Oct 23, 2025 at 09:38:13AM +0200, Herve Codina wrote:
> > Hi Manivannan,
> > 
> > On Wed, 15 Oct 2025 18:20:22 +0530
> > Manivannan Sadhasivam <mani@kernel.org> wrote:
> >   
> > > Hi Herve,
> > > 
> > > On Wed, Oct 15, 2025 at 01:58:11PM +0200, Herve Codina wrote:  
> > > > Hi Christian,
> > > > 
> > > > On Wed, 15 Oct 2025 13:30:44 +0200
> > > > Christian Zigotzky <chzigotzky@xenosoft.de> wrote:
> > > >     
> > > > > Hello Herve,
> > > > >     
> > > > > > On 15 October 2025 at 10:39 am, Herve Codina <herve.codina@bootlin.com> wrote:
> > > > > > 
> > > > > > ﻿Hi All,
> > > > > > 
> > > > > > I also observed issues with the commit f3ac2ff14834 ("PCI/ASPM: Enable all
> > > > > > ClockPM and ASPM states for devicetree platforms")      
> > > > > 
> > > > > Thanks for reporting.
> > > > >     
> > > > > > 
> > > > > > Also tried the quirk proposed in this discussion (quirk_disable_aspm_all)
> > > > > > an the quirk also fixes the timing issue.      
> > > > > 
> > > > > Where have you added quirk_disable_aspm_all?    
> > > > 
> > > > --- 8< ---
> > > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > > > index 214ed060ca1b..a3808ab6e92e 100644
> > > > --- a/drivers/pci/quirks.c
> > > > +++ b/drivers/pci/quirks.c
> > > > @@ -2525,6 +2525,17 @@ static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
> > > >   */
> > > >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm_l0s_l1);
> > > >  
> > > > +static void quirk_disable_aspm_all(struct pci_dev *dev)
> > > > +{
> > > > +       pci_info(dev, "Disabling ASPM\n");
> > > > +       pci_disable_link_state(dev, PCIE_LINK_STATE_ALL);    
> > > 
> > > Could you please try disabling L1SS and L0s separately to see which one is
> > > causing the issue? Like,
> > > 
> > > 	pci_disable_link_state(dev, PCIE_LINK_STATE_L1_1 | PCIE_LINK_STATE_L1_2);
> > > 
> > > 	pci_disable_link_state(dev, PCIE_LINK_STATE_L0S);
> > >   
> > 
> > I did tests and here are the results:
> > 
> >   - quirk pci_disable_link_state(dev, PCIE_LINK_STATE_ALL)
> >     Issue not present
> > 
> >   - quirk pci_disable_link_state(dev, PCIE_LINK_STATE_L1_1 | PCIE_LINK_STATE_L1_2)
> >     Issue present, timings similar to timings already reported
> >     (hundreds of ms).
> > 
> >   - quirk pci_disable_link_state(dev, PCIE_LINK_STATE_L0S);
> >     Issue present, timings still incorrect but lower
> >       64 bytes from 192.168.32.100: seq=10 ttl=64 time=16.738 ms
> >       64 bytes from 192.168.32.100: seq=11 ttl=64 time=39.500 ms
> >       64 bytes from 192.168.32.100: seq=12 ttl=64 time=62.178 ms
> >       64 bytes from 192.168.32.100: seq=13 ttl=64 time=84.709 ms
> >       64 bytes from 192.168.32.100: seq=14 ttl=64 time=107.484 ms
> >   
> 
> This is weird. Looks like all ASPM states (L0s, L1ss) are contributing to the
> increased latency, which is more than what should occur. This makes me ignore
> inspecting the L0s/L1 exit latency fields :/
> 
> Bjorn sent out a patch [1] that enables only L0s and L1 by default. But it
> might not help you. I don't honestly know how you are seeing this much of the
> latency. This could the due to an issue in the PCI component (host or endpoint),
> or even the board routing. Identifying which one is causing the issue is going
> to be tricky as it would require some experimentation.

I've just tested the patch from Bjorn and I confirm that it doesn't fix my issue.

> 
> If you are motivated, we can start to isolate this issue to the endpoint first.
> Is it possible for you to connect a different PCI card to your host and check
> whether you are seeing the increased latency? If the different PCI card is not
> exhibiting the same behavior, then the current device is the culprit and we
> should be able to quirk it.

Will see what I can do.

Best regards,
Hervé

