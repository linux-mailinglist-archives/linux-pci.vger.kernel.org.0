Return-Path: <linux-pci+bounces-39590-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 277A0C173BD
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 23:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 87C874F692C
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 22:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F4128D8E8;
	Tue, 28 Oct 2025 22:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHxhyjNy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16A71891AB;
	Tue, 28 Oct 2025 22:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761691959; cv=none; b=agg1ERi2Rtw8aS7GXih6fqNKA9a/L9xGazGJDAcckQ2QZPpZ9IgorcbcmE5AOo4cVnp7U3nWpQ7jUZm3HAoswvFRCY37/MErd1NV2A2bnEaItBGyMKWd2VdGUY2KDgzduceePwsTv40vnJ/Hu016mu9bNrmjdCdn9d8nzxLOjA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761691959; c=relaxed/simple;
	bh=TNnW1dnHBXsXUZ1jykN7QcAKz/sH0V9weWlESLyPygM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hcqQe6SjqPz6TkIcn3/zqs/UsE76RVQgY0HB1MzqsPIczsMLM/6cKJsmIGuzZ9IJwWSZoZCGI2l5nXQUimyY3QjtpslsQKZE7L2y6mxPerkluRnpqjC20p6Y/5+kSwOX59M5q3ca0bNeY0FXKccCMKrXwA+0pg3OTNjB0ctFqw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHxhyjNy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 492F7C4CEE7;
	Tue, 28 Oct 2025 22:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761691958;
	bh=TNnW1dnHBXsXUZ1jykN7QcAKz/sH0V9weWlESLyPygM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=oHxhyjNyr1rkjEm1QLuow6XhjdlOr8aHUBRvxrxbty01SDtmXmHjfn/xyEehrRdee
	 yMOgZTwvFxIOBOmBkU2B3FliAkNdnPpRTszsfiz1SM5gP+fruTwD8dSKATrP2Vzqsz
	 41eXfhuTv7bOlq/CA28iQkA6XmMGJAQROzUVLJ0QWObaMcflOOR1ndSM4oyN8T02qF
	 9vq8h2iY3n0M0QAReo+goNRPl6IgkNM4nrcPT1FBXV8X0fGV1nUEDfEpK9qfRx6FX4
	 jlPHjGn+r9/2B8Xvvo6G2de+J0BcjA9j5ZtXTGr5t81C0o9niOjPLn+Dftun1FLb/7
	 y2VP6ZfDlUXJQ==
Date: Tue, 28 Oct 2025 17:52:37 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kenneth Crudup <kenny@panix.com>
Cc: inochiama@gmail.com, tglx@linutronix.de, bhelgaas@google.com,
	unicorn_wang@outlook.com, linux-pci@vger.kernel.org,
	Genes Lists <lists@sapience.com>, Jens Axboe <axboe@kernel.dk>,
	Todd Brandt <todd.e.brandt@intel.com>, regressions@lists.linux.dev
Subject: Re: commit 54f45a30c0 ("PCI/MSI: Add startup/shutdown for per device
 domains") causing boot hangs on my laptop
Message-ID: <20251028225237.GA1539571@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013211939.GA865451@bhelgaas>

On Mon, Oct 13, 2025 at 04:19:39PM -0500, Bjorn Helgaas wrote:
> [+cc regressions like I meant to do the first time]
> 
> On Mon, Oct 13, 2025 at 04:18:16PM -0500, Bjorn Helgaas wrote:
> > [+cc Gene, Jens, Todd]
> > 
> > On Thu, Oct 02, 2025 at 10:04:17AM -0700, Kenneth Crudup wrote:
> > > 
> > > I'm running Linus' master (as of 7f7072574).
> > > 
> > > I bisected it to the above named commit (but had to back out ba9d484ed3
> > > (""PCI/MSI: Remove the conditional parent [un]mask logic") and then
> > > 727e914bbfbbd ("PCI/MSI: Check MSI_FLAG_PCI_MSI_MASK_PARENT in
> > > cond_[startup|shutdown]_parent()") first for a clean revert.)
> > > 
> > > I have a Dell XPS-9320 laptop, and booting would hang before it switched to
> > > the xe video driver from the EFI FB driver (not sure if this is a symptom or
> > > partial cause) and I'd see a message akin to "not being able to set up DP
> > > tunnels, destroying" as the last thing printed before it hangs. (If it's
> > > important to see those messages I believe I can force a pstore crash to get
> > > them where they can be saved off, let me know).
> 
> #regzbot introduced: 54f45a30c0 ("PCI/MSI: Add startup/shutdown for per device domains")
> #regzbot link: https://lore.kernel.org/all/3152ca947e89ee37264b90c422e77bb0e3d575b9.camel@sapience.com/
> #regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=220658

#regzbot fix: e433110eb5bf ("PCI: vmd: Override irq_startup()/irq_shutdown() in vmd_init_dev_msi_info()")


