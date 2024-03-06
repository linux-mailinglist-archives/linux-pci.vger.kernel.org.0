Return-Path: <linux-pci+bounces-4573-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A9A873634
	for <lists+linux-pci@lfdr.de>; Wed,  6 Mar 2024 13:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 373001C23478
	for <lists+linux-pci@lfdr.de>; Wed,  6 Mar 2024 12:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FFA80020;
	Wed,  6 Mar 2024 12:23:52 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69CE7FBC1;
	Wed,  6 Mar 2024 12:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709727832; cv=none; b=M/Bk/MvDy+ZfUAjQHeqdrlxpFuTrVSB5e+lYm7g3kgy2qNQZpU1euLPWyfcvqsOsrF5VE2+dWn1E642X0stlRCiSZSEpCumSiWRgG1BubC0IhNr85yU1qGoI9gkmhihfhhMEFSPKVZB3uBENQBLgQxo18W9J0cHErtrGWGnFtPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709727832; c=relaxed/simple;
	bh=w/xQsb4EE2OpOV6rKDdcLmA7HecYsHOwM10qF0z6+4A=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=CFpA8kviBzmtA4+dGgRca0cI+UTMrug9I5jRW0UyFe7D2FFzzojBMBY0JSwXJpTw5lxNH0ICkjMWDh9HqiIcVk7GeU0089gU3+dvMOPX+oo/zvjwkCdFQ7mJd1TlT4GDuvd8g6fIb6UuCMpDYjKJd2BssjgNoV7fLYALCwSz+eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 9C62992009C; Wed,  6 Mar 2024 13:23:40 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 9547592009B;
	Wed,  6 Mar 2024 12:23:40 +0000 (GMT)
Date: Wed, 6 Mar 2024 12:23:40 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] PCI: Use the correct bit in Link Training not active
 check
In-Reply-To: <c740c6e4-ca1a-33ad-8437-4a1219c16eb1@linux.intel.com>
Message-ID: <alpine.DEB.2.21.2403060951310.43702@angie.orcam.me.uk>
References: <20240301150641.4037-1-ilpo.jarvinen@linux.intel.com> <alpine.DEB.2.21.2403011622560.42226@angie.orcam.me.uk> <c740c6e4-ca1a-33ad-8437-4a1219c16eb1@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 4 Mar 2024, Ilpo Järvinen wrote:

> > > Since waiting for Data Link Layer Link Active bit is only used for the
> > > Target Speed quirk, this only impacts the case when the quirk attempts
> > > to restore speed to higher than 2.5 GT/s (The link is Up at that point
> > > so pcie_retrain_link() will fail).
> > 
> >  NAK.  It's used for both clamping and unclamping and it will break the 
> > workaround, because the whole point there is to wait until DLLA has been 
> > set.  Using LT is not reliable because it will oscillate in the failure 
> > case and seeing the bit clear does not mean link has been established.  
> 
> In pcie_retrain_link(), there are two calls into 
> pcie_wait_for_link_status() and the second one of them is meant to 
> implement the link-has-been-established check.
> 
> The first wait call comes from e7e39756363a ("PCI/ASPM: Avoid link 
> retraining race") and is just to ensure the link is not ongoing retraining 
> to make sure the latest configuration in captured as required by the 
> implementation note. LT being cleared is exactly what is wanted for that 
> check because it means that any earlier retraining has ended (a new one 
> might be starting but that doesn't matter, we saw it cleared so the new 
> configuration should be in effect for that instance of link retraining).
> 
> So my point is, the first check is not even meant to check that link has 
> been established.

 I see what you mean, and I now remember the note in the spec.  I had 
concerns about it, but did not do anything about it at that point.

 I think we still have no guarantee that LT will be clear at the point we 
set RL, because LT could get reasserted by hardware between our read and 
the setting of RL.  IIUC that doesn't matter really, because the new link 
parameters will be taken into account regardless of whether retraining was
initiated by hardware in an attempt to do link recovery or triggered by 
software via RL.

> >  What are you trying to achieve here and what problem is it to fix?
> 
> Actually, I misthought what it breaks so the problem is not well described 
> above but I still think it is broken:
> 
> In the case of quirk, before 2.5GT/s is attempted DLLLA is not set, 
> right? Then quirk sets 2.5GT/s target speed and calls into 
> pcie_retrain_link().

 Correct.

> The first call into pcie_wait_for_link_status() is made with (..., false, 
> true) which waits until DLLLA is set but this occurs before OS even 
> triggered Link Retraining. Since there's no retraining commanded by the 
> OS, DLLLA will not get set, the wait will fail and error is returned, and 
> the quirk too returns failure.
> 
> It could of course occur that because of the HW retraining loop 
> (independent of OS control), the link retrains itselfs to 2.5GT/s without 
> OS asking for it just by OS setting the target speed alone, which is well 
> possible given the HW behavior in your target speed quirk case is not 
> fully understood. Even if that's the case, it seems not good to rely on 
> the HW originating retraining loop triggering the link retraining that
> is necessary here.

 I think it just confirms what I observed above (and which is surely noted 
somewhere in the spec) that modified link parameters are taken into 
account regardless of how retraining has been initiated and the link gets 
established (at 2.5GT/s) at the first call to `pcie_wait_for_link_status' 
already and returns successfully seeing DLLLA set.

> Maybe this is far fetched thought but perhaps it could explain why you 
> didn't get the link up with your setup when you tried to test it earlier.
> 
> Alternative approach to fix this problem would be to not make the first 
> call into pcie_wait_for_link_status() at all when use_lt = false.
> 
> Of course, I cannot test this with your configuration so I cannot 
> confirm how the target speed quirk behaves, I just found it by reading the 
> code. The current code does not make sense because the first wait is 
> supposed to wait for LT bit, not for DLLLA.

 I think I now understand the problem correctly, and indeed from master 
Linux repo's point of view it's been a defect with the merge referred.  
So I withdraw my objection.  Sorry about the confusion.

 However I think the last paragraph of your commit description:

> Since waiting for Data Link Layer Link Active bit is only used for the
> Target Speed quirk, this only impacts the case when the quirk attempts
> to restore speed to higher than 2.5 GT/s (The link is Up at that point
> so pcie_retrain_link() will fail).

is not accurate enough, which contributed to my confusion.  In particular 
`pcie_retrain_link' succeeds when the link is up, because it calls 
`pcie_wait_for_link_status' such as to succeed when either LT is clear or 
DLLLA is set.  How about:

This only impacts the Target Speed quirk, which is the only case where 
waiting for Data Link Layer Link Active bit is used.  It currently works 
in the problematic case by means of link training getting initiated by 
hardware repeatedly and respecting the new link parameters set by the 
caller, which then make training succeed and bring the link up, setting 
DLLLA and causing pcie_wait_for_link_status() to return success.  We are 
not supposed to rely on luck and need to make sure that LT transitioned
through the inactive state though before we initiate link training by 
hand via RL.

then?

 Also for `pcie_retrain_link' I think it would be clearer if we rephrased 
the note as follows:

	 * Ensure the updated LNKCTL parameters are used during link
	 * training by checking that there is no ongoing link training
	 * that may have started before link parameters were changed, so
	 * as to avoid LTSSM race as recommended in Implementation Note
	 * at the end of PCIe r6.0.1 sec 7.5.3.7.

 NB I am currently away on holiday until the end of next week.  However I 
do have access to my lab and I'll see if I can verify your change tonight
or another evening this week, and overall thank you for your patience.

  Maciej

