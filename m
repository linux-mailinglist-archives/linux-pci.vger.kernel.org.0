Return-Path: <linux-pci+bounces-37630-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC45BBF1A2
	for <lists+linux-pci@lfdr.de>; Mon, 06 Oct 2025 21:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C8CC634B1E7
	for <lists+linux-pci@lfdr.de>; Mon,  6 Oct 2025 19:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA301D54FA;
	Mon,  6 Oct 2025 19:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2T1oOda"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F4478F43;
	Mon,  6 Oct 2025 19:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759779215; cv=none; b=rYIzduZ47rxWlp8QWR5i260MmFmJm1r1gLXI2lBNTCxAJd6sxlyTOCHj3RFJJalD3MV3AePKnYXoIgNLhZLKG3xDhZzbrM3FlGHxldh7P9SKAS9qzlSs6yMRTL26IIitzeCixwtQuIh64AdNB+lYjfVh6YFOREbYnTQOm5ZsBVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759779215; c=relaxed/simple;
	bh=8cCOiOCy0xsEJL2nKdqfeYkc4B6AdYbPHDiHhRIGpj4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=M/Kax9YQUtvZbplH9496fKJvKBqFYHUyw0PqhzgejNbTI21TRXju8ekK1/uWCJpnHdRR2ipAetH8uL2NyrTUvpI2Eb2MdJAZBr3IQdGA9fFKd0ZhTwiS5N0joSq22vvfYEoqLN5jMK1o6VHNYUQa+sGMLYcATSi6gTOJlGK16tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e2T1oOda; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 068EFC4CEF5;
	Mon,  6 Oct 2025 19:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759779215;
	bh=8cCOiOCy0xsEJL2nKdqfeYkc4B6AdYbPHDiHhRIGpj4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=e2T1oOdaGpUvqnuT8g8UoNM7nklUUIReD8DRtOulZXhe8Hq1YPVXIC42jahFXWVfh
	 blZ7UJXRMvWXG9cqkFj0p1nm+mPSvcJ4ejGQ5ZMDdPdOk6XhZczoQ1X/SsDZXLaA/L
	 2pW5T/H6nCgqDyWN6hO2T7rWoQOavd14N7PeSWTCIc+CmkMvvC7aMoseD71TgU2+Se
	 ETA4yKGpPKYRB0tr4SmDRhftP72tB+E+HHM8uLBjSIrfJYdarGSnSttMrxzCsQk0ak
	 VnCQ6Em76/aRwPq2QYm3zGZWstPdWM2PQB5A7iBFN79FeBEpB2DJU/0NscgH34NhwW
	 H65ewjZkj4O7Q==
Date: Mon, 6 Oct 2025 14:33:33 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] PCI/PM: Avoid redundant delays on D3hot->D3cold
Message-ID: <20251006193333.GA537409@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOQLRhot8-MtXeE3@google.com>

On Mon, Oct 06, 2025 at 11:32:38AM -0700, Brian Norris wrote:
> On Mon, Oct 06, 2025 at 03:52:22PM +0200, Mika Westerberg wrote:
> > On Fri, Oct 03, 2025 at 03:40:09PM -0700, Brian Norris wrote:
> > > From: Brian Norris <briannorris@google.com>
> > > 
> > > When transitioning to D3cold, __pci_set_power_state() will first
> > > transition a device to D3hot. If the device was already in D3hot, this
> > > will add excess work:
> > > (a) read/modify/write PMCSR; and
> > > (b) excess delay (pci_dev_d3_sleep()).
> > 
> > How come the device is already in D3hot when __pci_set_power_state() is
> > called? IIRC PCI core will transition the device to low power state so that
> > it passes there the deepest possible state, and at that point the device is
> > still in D0. Then __pci_set_power_state() puts it into D3hot and then turns
> > if the power resource -> D3cold.
> > 
> > What I'm missing here?
> 
> Some PCI drivers call pci_set_power_state(..., PCI_D3hot) on their own
> when preparing for runtime or system suspend, so by the time they hit
> pci_finish_runtime_suspend(), they're in D3hot. Then, pci_target_state()
> may still pick a lower state (D3cold).

We might need this change, but maybe this is also an opportunity to
remove some of those pci_set_power_state(..., PCI_D3hot) calls from
drivers.

I didn't look into any of them in detail, but I would jump at any
chance to remove PCI details from driver suspend paths.  There are
only ~20 calls from suspend functions, ~25 from shutdown, and a few
from poweroff.  The fact that there are so few makes me think they
might be leftovers that could be more fully converted to generic PM.

