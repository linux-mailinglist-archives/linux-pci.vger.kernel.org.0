Return-Path: <linux-pci+bounces-37986-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C67BD6587
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 23:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0E4DF4ED75B
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 21:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE33E2D7397;
	Mon, 13 Oct 2025 21:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fACKrjqG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BF71A9F9B;
	Mon, 13 Oct 2025 21:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760390380; cv=none; b=FxgEKD3dlTItYWRBPh07qXoZCneLEZTnV+baQUnXdX2Nyc8cBhG9STsz+Rgs2EZt9coJRIZJ227GP+ORixuMtDdQRYDY7i0CeoSM6beRZpb8U6Bc8p3wE2OqwFbIXYR0e+uyt1jxeK7hcam7FBh2imoaccjOqS2rMgA9hIgVyog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760390380; c=relaxed/simple;
	bh=EHxxQD8og20F9+fhPoBt6CNX+siyDlnUuz0TQTdudXg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Nzst2+5CNFSXkT3Z1pRoyF4mpheTmi718xwssBm38xJ1MuLzvpDT2O30DpUBrjSwv2NmKpyju64j+85bYdG267SCTNRPguiPCe0Ym0w40O1VMxRQaCevRHSUA/oESEaxtTkscji+TEaOvR40IJ2UCqoZZSIyZK0izYJJB1j8owg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fACKrjqG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41E22C4CEE7;
	Mon, 13 Oct 2025 21:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760390380;
	bh=EHxxQD8og20F9+fhPoBt6CNX+siyDlnUuz0TQTdudXg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=fACKrjqGKL2ovU/hV7m1N7RHvCE9PFpOcx20JFMgHDxO251tiiQCgxM0mBo2F2ANa
	 6vqXUl3tUE5k0y3NM6ihlpFAIcuol7PVROnpAYkOgp7M0ndd7WTA9iOmrqaELmRj45
	 vFxHQQGqXtZYKYcEO7Qkzvkw29Ve8RDUnbjcN6MRyuMzjyk6GyViz/8tlbx5kTvSvB
	 G7qZDCuizhMyJjF3F8WqmPOtMlI0xV1SRHidU95Y31J4LkbTjUVUMIorCbuGRshQ2a
	 QWnCwIYzAXee2TLSbwgFjmwCwjy2DsMIqVseqjI20Xi9z+lQWL5ZBDvjVhIhUhyDM9
	 xRFxvwSZPBUKw==
Date: Mon, 13 Oct 2025 16:19:39 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kenneth Crudup <kenny@panix.com>
Cc: inochiama@gmail.com, tglx@linutronix.de, bhelgaas@google.com,
	unicorn_wang@outlook.com, linux-pci@vger.kernel.org,
	Genes Lists <lists@sapience.com>, Jens Axboe <axboe@kernel.dk>,
	Todd Brandt <todd.e.brandt@intel.com>, regressions@lists.linux.dev
Subject: Re: commit 54f45a30c0 ("PCI/MSI: Add startup/shutdown for per device
 domains") causing boot hangs on my laptop
Message-ID: <20251013211939.GA865451@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013211815.GA864904@bhelgaas>

[+cc regressions like I meant to do the first time]

On Mon, Oct 13, 2025 at 04:18:16PM -0500, Bjorn Helgaas wrote:
> [+cc Gene, Jens, Todd]
> 
> On Thu, Oct 02, 2025 at 10:04:17AM -0700, Kenneth Crudup wrote:
> > 
> > I'm running Linus' master (as of 7f7072574).
> > 
> > I bisected it to the above named commit (but had to back out ba9d484ed3
> > (""PCI/MSI: Remove the conditional parent [un]mask logic") and then
> > 727e914bbfbbd ("PCI/MSI: Check MSI_FLAG_PCI_MSI_MASK_PARENT in
> > cond_[startup|shutdown]_parent()") first for a clean revert.)
> > 
> > I have a Dell XPS-9320 laptop, and booting would hang before it switched to
> > the xe video driver from the EFI FB driver (not sure if this is a symptom or
> > partial cause) and I'd see a message akin to "not being able to set up DP
> > tunnels, destroying" as the last thing printed before it hangs. (If it's
> > important to see those messages I believe I can force a pstore crash to get
> > them where they can be saved off, let me know).

#regzbot introduced: 54f45a30c0 ("PCI/MSI: Add startup/shutdown for per device domains")
#regzbot link: https://lore.kernel.org/all/3152ca947e89ee37264b90c422e77bb0e3d575b9.camel@sapience.com/
#regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=220658

