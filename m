Return-Path: <linux-pci+bounces-2510-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0751783A3DB
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jan 2024 09:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF81F1F21ECF
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jan 2024 08:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD761754D;
	Wed, 24 Jan 2024 08:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G4OMdyWO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C001754B;
	Wed, 24 Jan 2024 08:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706084187; cv=none; b=TL+asDi4yyf7u+4yHj5Dh6wEq8vva+tN3pc7TbLmmn4tHut3sIFP/u4jkPkQtAuZ38QG6zkJBzem6dARCDzShJRmaidFIpxCVYsiltgdotfgfEoeWUedbb8blx96P+JJUpumv+N0avsxEJxef9az6fvUXJk0tE8eEQsSC/zdNn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706084187; c=relaxed/simple;
	bh=yPHZyzsk8WzbI7ldL7fVLGbYXwS6Sgp6n83vgEDFIks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nX9ycsdwJTpYWAwgaWR4dDHxMFmVUjlselGU0pWUzKs+1IjxYOrory53nVMUTSD9QdpXuEVicaTtD2abuZijP/Gbwvzc0XNFjuwTpvPgZS/pFldcKxVKX4IGE6VGwwmh7ic0PhAdhWNQqaERvANZQCzxKpkP3QZO+dfGYABNJyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G4OMdyWO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0360C43390;
	Wed, 24 Jan 2024 08:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706084186;
	bh=yPHZyzsk8WzbI7ldL7fVLGbYXwS6Sgp6n83vgEDFIks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G4OMdyWO4KloRWY9yuRP7AYNTnjQgo7yui/V0wAVzm76Zmg4xC1shujvBIUYdkbbx
	 ElGZlOT0mwppT8NqOQHVKWECY87aCEF3vxSoRFHZ+ktHCOoW6zmg2mrmygqtF/9Asw
	 llO/GqUWTNm38OOLYGV8CRbsp31Pz/1S7uihnR/PBhO+GOqaSarSRVcQleF5LnoaZH
	 HeHX6Son2PnyQKaxoEJVW1MEP9x1J9RsqKq/BD0PYyDq8bsh3XLAxIlR+Xd9e+9yKt
	 AOwnN8nePJhkTErWKuPwjF0Ix6pUOf1uzSGTHJ9K2GeWpozmeItdMPUUZFVD6q6DaN
	 FPKRU/SznEaOg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rSYR4-000000001Zb-0U3f;
	Wed, 24 Jan 2024 09:16:38 +0100
Date: Wed, 24 Jan 2024 09:16:38 +0100
From: Johan Hovold <johan@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
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
Message-ID: <ZbDHZtR8Tg1hWAzc@hovoldconsulting.com>
References: <Za_2oKTUksw8Di5E@hovoldconsulting.com>
 <20240123223648.GA331671@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123223648.GA331671@bhelgaas>

On Tue, Jan 23, 2024 at 04:36:48PM -0600, Bjorn Helgaas wrote:
> On Tue, Jan 23, 2024 at 06:25:52PM +0100, Johan Hovold wrote:
> > On Mon, Jan 22, 2024 at 12:26:15PM -0600, Bjorn Helgaas wrote:
> > > On Mon, Jan 22, 2024 at 11:53:35AM +0100, Johan Hovold wrote:

> > > 08d0cc5f3426 ("PCI/ASPM: Remove pcie_aspm_pm_state_change()") was a
> > > start at fixing other problems and also improving the ASPM style, so I
> > > hope somebody steps up to fix both it and the lockdep issue.  I
> > > haven't looked at it enough to have a preference for *how* to fix it.
> > 
> > Ok, but since you were the one introducing the locking regression in
> > 6.7-final shouldn't you look into fixing it?
> > 
> > Especially if there were alternatives to restoring the offending commit
> > which would solve the underlying issue for the resume failure without
> > breaking other platforms.
> 
> Did somebody propose an alternate patch?  If so, I missed it, but we
> could look at it now.

I've only skimmed the discussion leading up to the revert, but I got the
impression that other alternatives were looked at as it was still not
clear what the underlying issue actually was.

As Michael and Thorsten pointed out before the revert, it may have been
better not to do a last minute revert of a 16 month old commit which
risks introducing regressions (and brought back another sysfs issue
IIUC) before fully understanding what is really going on here.

> > I don't want to spend more time on this if the offending commit could
> > simply be reverted.
> 
> I don't quite follow.  By simply reverting, do you mean to revert
> f93e71aea6c6 ("Revert "PCI/ASPM: Remove
> pcie_aspm_pm_state_change()"")?  IIUC that would break Michael's
> machine again.

Right, at least until that issue is fully understood and alternative
fixes have been considered.

If that's not an option, we need to rework core to pass a flag through
more than one layer to indicate whether pcie_aspm_pm_state_change()
should take the bus semaphore or not. I'd rather not do that if it can
be avoided.

Johan

