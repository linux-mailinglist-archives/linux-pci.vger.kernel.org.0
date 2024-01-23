Return-Path: <linux-pci+bounces-2507-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E06839C5D
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 23:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 914F7282A4F
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 22:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD5A524B9;
	Tue, 23 Jan 2024 22:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dNLkpDN4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C846ADE;
	Tue, 23 Jan 2024 22:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706049411; cv=none; b=V09aFliwMFz6RtyUDhPBODM0oRIEV0+E0nDuqDRv0mkBHuLNc7m0p4fXSd7HW84gCnmTn+A+HnAl4kShlbjSbzubtm4o8DuYQImLjg1wMd9U8sfLqRIVIUz4qsCgtQYelkWloAfmQ4212j4JrAz+ZSJJ3APeoo8j1MdQtMCjm8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706049411; c=relaxed/simple;
	bh=i3m70T+5zzUlf58J0B9B0D1OflXZeDncmnHWK4wEutg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=BvjWNXSLPvA76SvJo21+SEeue7vz95MuV37hGAlWySwA1IyUlrMYYxLPJ5dYDj7bysgiUtVATu0FAa4jUbBtkhfth0kHl0nK/FIPVOBjLpp0lPS0kQTLXpgNJCn3I2mdZ3REopUGYeyFVxWXd4YdVoA7kMxYG+sOT81GihY0xJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dNLkpDN4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43FC1C433C7;
	Tue, 23 Jan 2024 22:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706049410;
	bh=i3m70T+5zzUlf58J0B9B0D1OflXZeDncmnHWK4wEutg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=dNLkpDN4H52ijtCLMWY2NA6XJSHRlAjeRammwO5Rm8QwmskNN21hKO/5tx9+lK34W
	 kOmk6rkQUwb3MseYXDOzyskrEUIYN2Kdkl6+L/dHW8Bi6W6kmfPtKDrkRQjW7aWVxU
	 zh/4js6IAEy6R31SrT5nMi++OHZcglvHJVUDsTy+Ex4cLxNE+nLC1532YEV/Ng7zvY
	 bBOmENC4l7GTfh6QhncACTf5lzIlnd/AKDRlO/S4K0cEj7KvU4nd5z0aX0S6Eafafn
	 QmEkV3OMLWUsjRuqAOHd/Jnpdn74/nlvpsCxMoO5bnVUWRb6+28YHQrHrIFJWvVzyT
	 cHApnliKCa7Bg==
Date: Tue, 23 Jan 2024 16:36:48 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Michael Schaller <michael@5challer.de>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	"Maciej W . Rozycki" <macro@orcam.me.uk>,
	Ajay Agarwal <ajayagarwal@google.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, stable@vger.kernel.org,
	regressions@leemhuis.info
Subject: Re: PCI/ASPM locking regression in 6.7-final (was: Re: [PATCH]
 Revert "PCI/ASPM: Remove pcie_aspm_pm_state_change()")
Message-ID: <20240123223648.GA331671@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Za_2oKTUksw8Di5E@hovoldconsulting.com>

On Tue, Jan 23, 2024 at 06:25:52PM +0100, Johan Hovold wrote:
> On Mon, Jan 22, 2024 at 12:26:15PM -0600, Bjorn Helgaas wrote:
> > On Mon, Jan 22, 2024 at 11:53:35AM +0100, Johan Hovold wrote:
> > > I never got a reply to this one so resending with updated Subject in
> > > case it got buried in your inbox.
> > 
> > I did see it but decided it was better to fix the problem with resume
> > causing an unintended reboot, even though fixing that meant breaking
> > lockdep again, since I don't think we have user reports of the
> > potential deadlock lockdep finds.
> 
> That may be because I fixed the previous regression in 6.7-rc1 before
> any users had a chance to hit the deadlock on Qualcomm platforms.
> 
> I can easily trigger a deadlock on the X13s by instrumenting 6.7-final
> with a delay to increase the race window.
> 
> And any user hitting this occasionally is likely not going to be able to
> track it down to this lock inversion (unless they have lockdep enabled).

I agree, it's a problem we need to fix.

> > 08d0cc5f3426 ("PCI/ASPM: Remove pcie_aspm_pm_state_change()") was a
> > start at fixing other problems and also improving the ASPM style, so I
> > hope somebody steps up to fix both it and the lockdep issue.  I
> > haven't looked at it enough to have a preference for *how* to fix it.
> 
> Ok, but since you were the one introducing the locking regression in
> 6.7-final shouldn't you look into fixing it?
> 
> Especially if there were alternatives to restoring the offending commit
> which would solve the underlying issue for the resume failure without
> breaking other platforms.

Did somebody propose an alternate patch?  If so, I missed it, but we
could look at it now.

> I don't want to spend more time on this if the offending commit could
> simply be reverted.

I don't quite follow.  By simply reverting, do you mean to revert
f93e71aea6c6 ("Revert "PCI/ASPM: Remove
pcie_aspm_pm_state_change()"")?  IIUC that would break Michael's
machine again.

Bjorn

