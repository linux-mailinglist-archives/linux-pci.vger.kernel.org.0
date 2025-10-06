Return-Path: <linux-pci+bounces-37646-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A42BBFC0D
	for <lists+linux-pci@lfdr.de>; Tue, 07 Oct 2025 01:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1527E4E298E
	for <lists+linux-pci@lfdr.de>; Mon,  6 Oct 2025 23:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00351D61BC;
	Mon,  6 Oct 2025 23:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="onCPadsc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9AB15667D;
	Mon,  6 Oct 2025 23:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759792408; cv=none; b=WOCd3MMyCKBlKpV2ykNYbEJWRp4egSdsMU6CLOjZQT9eoKWdBChnY8Frw1q9oOW42fZudVBPowuWhVXNOmsyCVpXyDrnPLssMBlH/DdfG4OEOZh7k0jp+QnO095Rgh+zX+OXv2Kf1C5D1hqd1BfEw8ciphFd+evKv5uVNnisIzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759792408; c=relaxed/simple;
	bh=bLiJ06jMARRE5CuLlJkwHNZ7cvjQTnOD4kHGO/M63F4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ud67I+A2s88HWLexp+XwoIRIVqyDeBtdKilzAP2J17Ea2RylN3A+E/6duU20qQRO6Ypb6EzOzWhWW991ZLSkbnT+FQcg7i2fQWJNDws+VVSwhbXpoJEZM1Pj2v4LN7xtJhudkDZedRHYHh5AW5xjoJSnHr5FzYyjXaDnLU1R05g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=onCPadsc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD8D9C4CEF5;
	Mon,  6 Oct 2025 23:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759792408;
	bh=bLiJ06jMARRE5CuLlJkwHNZ7cvjQTnOD4kHGO/M63F4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=onCPadscgHwmiNX6VAuSG58AVoDmwbuGqHAzguiMVkr1EbFUjVjW0Hr6GvQQOJqen
	 2jqe3qeYfhuoq3abM9AdkKe5OU8kzk8016AXv4IOocS4lfhqJJly/pvGgq/vyaRJEB
	 LfTUF6PaohM37Ex0Q2/dquHQEsGVTEEEAreWt8GX56w7dS8RVVbmPuDeLCFzWPas+Y
	 RyNz2LzTCG2vDE43oHrgoNGsAWXPLrdiSl05tPOAe+KgtyFM+KZ39QucKZJGzUJoWe
	 3v+0kiiQkB6v8l7jhTl6W1vEDH/rPgpjboFae1arODiem8LSgrKi77JzP7mKHQPDyS
	 NKLCnaZNFZLbg==
Date: Mon, 6 Oct 2025 16:13:26 -0700
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Brian Norris <briannorris@chromium.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] PCI/PM: Avoid redundant delays on D3hot->D3cold
Message-ID: <v7ynntv43urqjfdfzzbai2btsohaxpprni2pix2wnjfoazlfcl@xdbhvnpmoebt>
References: <aOQLRhot8-MtXeE3@google.com>
 <20251006193333.GA537409@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251006193333.GA537409@bhelgaas>

On Mon, Oct 06, 2025 at 02:33:33PM -0500, Bjorn Helgaas wrote:
> On Mon, Oct 06, 2025 at 11:32:38AM -0700, Brian Norris wrote:
> > On Mon, Oct 06, 2025 at 03:52:22PM +0200, Mika Westerberg wrote:
> > > On Fri, Oct 03, 2025 at 03:40:09PM -0700, Brian Norris wrote:
> > > > From: Brian Norris <briannorris@google.com>
> > > > 
> > > > When transitioning to D3cold, __pci_set_power_state() will first
> > > > transition a device to D3hot. If the device was already in D3hot, this
> > > > will add excess work:
> > > > (a) read/modify/write PMCSR; and
> > > > (b) excess delay (pci_dev_d3_sleep()).
> > > 
> > > How come the device is already in D3hot when __pci_set_power_state() is
> > > called? IIRC PCI core will transition the device to low power state so that
> > > it passes there the deepest possible state, and at that point the device is
> > > still in D0. Then __pci_set_power_state() puts it into D3hot and then turns
> > > if the power resource -> D3cold.
> > > 
> > > What I'm missing here?
> > 
> > Some PCI drivers call pci_set_power_state(..., PCI_D3hot) on their own
> > when preparing for runtime or system suspend, so by the time they hit
> > pci_finish_runtime_suspend(), they're in D3hot. Then, pci_target_state()
> > may still pick a lower state (D3cold).
> 
> We might need this change, but maybe this is also an opportunity to
> remove some of those pci_set_power_state(..., PCI_D3hot) calls from
> drivers.
> 

Agree. The PCI client drivers should have no business in opting for D3Hot in the
suspend path. It should be the other way around, they should opt-out if they
want by calling pci_save_state(), but that is also subject to discussion.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

