Return-Path: <linux-pci+bounces-39865-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D290C228E1
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 23:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CDE854E2A5C
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 22:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD49329E65;
	Thu, 30 Oct 2025 22:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tCmY+pZl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7735C324B3F;
	Thu, 30 Oct 2025 22:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761863229; cv=none; b=VvejzidzWk5uUqQRxqUeSO20vMLk3jefbFSGVIXZXJyb3zBtIFbcoH3r4mus4WQFLb81wX+8KnAMdgkoAAzCmkDCmmQbwbtzkktg9Y/vqEuk6vmcQr0ZQclBgb/E8NRjB2EPfWhWYmtRHAG01ve6qWIR9RDbcYOGl0A/1uaGFf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761863229; c=relaxed/simple;
	bh=7o4EaCQ3TnXfyYP07SLDrDw7LwaNG7p+R80Pcj96IKc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=sa5WfcL7eOWABIDGYwTIQ7MKQijiHoJS69gpGdiCsd7+k67YYz9hJJCEFi0YhRZKs6/aT+5HVKv1ZDTH4e2hbK/tar4GJ6mLnr4bhZt4EJd3qm+0o4xFSKfqlGPeIut+KuEn912+sSXnqHjBwyV/wQBhEc6sGRbSPiq86s4iZa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tCmY+pZl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAD48C4CEF8;
	Thu, 30 Oct 2025 22:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761863226;
	bh=7o4EaCQ3TnXfyYP07SLDrDw7LwaNG7p+R80Pcj96IKc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=tCmY+pZlK+hy/GQg2sPj7AJN7lEowqaCM3fdOzzcD3TeoQrTlacAzc7efNkT6WzNb
	 4hypDQCIy46O4pAIYFYPk+wuWgsVg+5gaoEToqgBaEEiBJbtXos3IXmVBci1q8LGLi
	 SHRR52ZA1ektUWXPmUQkSdAUMLWZ9hcyiRfwC0Y9WSQUJRFfLSYPyI/7DivC7awB/e
	 NHOyBB0i1IWdv1AlMWRB5B9zOJQPNILitN/bd85z6IZFzCgOIYXggbOMFiYB++XPWE
	 8JFPkzsfoqUIE4x3PfR0zdnvRfUOwp/XSIx8OUjr4dy2fYPiXEdm4Ok2KY3GKK41Ma
	 E/eXq7ZQ0RzIQ==
Date: Thu, 30 Oct 2025 17:27:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kenneth Crudup <kenny@panix.com>
Cc: inochiama@gmail.com, tglx@linutronix.de, bhelgaas@google.com,
	unicorn_wang@outlook.com, linux-pci@vger.kernel.org,
	Genes Lists <lists@sapience.com>, Jens Axboe <axboe@kernel.dk>,
	Todd Brandt <todd.e.brandt@intel.com>, regressions@lists.linux.dev
Subject: Re: commit 54f45a30c0 ("PCI/MSI: Add startup/shutdown for per device
 domains") causing boot hangs on my laptop
Message-ID: <20251030222705.GA1657140@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028225237.GA1539571@bhelgaas>

On Tue, Oct 28, 2025 at 05:52:37PM -0500, Bjorn Helgaas wrote:
> On Mon, Oct 13, 2025 at 04:19:39PM -0500, Bjorn Helgaas wrote:
> > On Mon, Oct 13, 2025 at 04:18:16PM -0500, Bjorn Helgaas wrote:
> > > On Thu, Oct 02, 2025 at 10:04:17AM -0700, Kenneth Crudup wrote:
> > > > 
> > > > I'm running Linus' master (as of 7f7072574).
> > > > 
> > > > I bisected it to the above named commit (but had to back out ba9d484ed3
> > > > (""PCI/MSI: Remove the conditional parent [un]mask logic") and then
> > > > 727e914bbfbbd ("PCI/MSI: Check MSI_FLAG_PCI_MSI_MASK_PARENT in
> > > > cond_[startup|shutdown]_parent()") first for a clean revert.)
> ...

> > #regzbot introduced: 54f45a30c0 ("PCI/MSI: Add startup/shutdown for per device domains")
> > #regzbot link: https://lore.kernel.org/all/3152ca947e89ee37264b90c422e77bb0e3d575b9.camel@sapience.com/
> > #regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=220658
> 
> #regzbot fix: e433110eb5bf ("PCI: vmd: Override irq_startup()/irq_shutdown() in vmd_init_dev_msi_info()")

#regzbot report: https://lore.kernel.org/r/af5f1790-c3b3-4f43-97d5-759d43e09c7b@panix.com
#regzbot introduced: 54f45a30c0d0
#regzbot fix: e433110eb5bf

54f45a30c0d0 ("PCI/MSI: Add startup/shutdown for per device domains")
e433110eb5bf ("PCI: vmd: Override irq_startup()/irq_shutdown() in vmd_init_dev_msi_info()") (appeared in v6.18-rc2)

