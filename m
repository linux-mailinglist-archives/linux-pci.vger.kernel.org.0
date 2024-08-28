Return-Path: <linux-pci+bounces-12393-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01621963410
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 23:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E3731C2192B
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 21:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD861A76B5;
	Wed, 28 Aug 2024 21:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/fpZj+h"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE4815ADB3;
	Wed, 28 Aug 2024 21:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724881341; cv=none; b=rsuclyD2CA1COPYw9HPZBdxVc5Ai4SPKHZ4O0c+gpRPGGGE2CEl3/FsMTVNrnUlW5MmWIMqms41cPMof8USIo5UQ7XrKi1p95fdqFomph4OasXdULuyK9tFTK12XaiMNC6UYnt3uLz7jJC2YsJh2Fuo3k7IBdJ+vp+6XAwFIdbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724881341; c=relaxed/simple;
	bh=vNMzbmDzy/pexcwW1pIxaw1NKxWmwSdKEbK+fN5vVpE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=aSPNLoNnXw54jve8cbcCS5vjSf7JXGq2uJ+9WyfAEyPAcLH7i+R41J8/In91qYDMBC92giLl4hdFwIAkn2wJKed1xuEo4DPz7UJz5ETx2OySwZOdSPh+PqZDcMeMx2x/CwST3anKlz4VYBnGg5B+JcO5kHJyV3tiurb7+RqOBKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s/fpZj+h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 813D8C4CEC0;
	Wed, 28 Aug 2024 21:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724881340;
	bh=vNMzbmDzy/pexcwW1pIxaw1NKxWmwSdKEbK+fN5vVpE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=s/fpZj+hT3CgYNBAWlmDIX1Y3GeLs40GI1ns9kixtBCs5nmqkrJtlj2Eit/XGB520
	 S71Z5MAE2lDM2fwCLNv+V9uxRHKGuj+gDC2m6uDrvnD/K71JAApEAR3NzvkLjTCqhR
	 qsXbdwvFZKdKqm+ap7VG39yF3e1h6zYoQWNsaRnvcloWwiv/1ptCH/g5HhYsHW8pd9
	 uZNmaH48viyLTBxB2fBerL+ETsrFJaPoRyXJSF5gprxz7amXzjDYRtfwYePpZO8/OC
	 lJBa24+iM9KzFoWBX4mHc1s1AUHQEo1JNrrbCR64lFqfLgU71pQfKRgAw9yz1fxAzd
	 cMx5l69+DKcDA==
Date: Wed, 28 Aug 2024 16:42:18 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: linux-pci@vger.kernel.org,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	"Maciej W . Rozycki" <macro@orcam.me.uk>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Duc Dang <ducdang@google.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	"Li, Gary" <Gary.Li@amd.com>
Subject: Re: [RFC PATCH 0/3] PCI: Use Configuration RRS to wait for device
 ready
Message-ID: <20240828214218.GA40398@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30d9589a-8050-421b-a9a5-ad3422feadad@amd.com>

On Wed, Aug 28, 2024 at 04:24:01PM -0500, Mario Limonciello wrote:
> On 8/27/2024 18:48, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > After a device reset, pci_dev_wait() waits for a device to become
> > completely ready by polling the PCI_COMMAND register.  The spec envisions
> > that software would instead poll for the device to stop responding to
> > config reads with Completions with Request Retry Status (RRS).
> > 
> > Polling PCI_COMMAND leads to hardware retries that are invisible to
> > software and the backoff between software retries doesn't work correctly.
> > 
> > Root Ports are not required to support the Configuration RRS Software
> > Visibility feature that prevents hardware retries and makes the RRS
> > Completions visible to software, so this series only uses it when available
> > and falls back to PCI_COMMAND polling when it's not.
> > 
> > This is completely untested and posted for comments.
> > 
> > Bjorn Helgaas (3):
> >    PCI: Wait for device readiness with Configuration RRS
> >    PCI: aardvark: Correct Configuration RRS checking
> >    PCI: Rename CRS Completion Status to RRS
> > 
> >   drivers/bcma/driver_pci_host.c             | 10 ++--
> >   drivers/pci/controller/dwc/pcie-tegra194.c | 18 +++---
> >   drivers/pci/controller/pci-aardvark.c      | 64 +++++++++++-----------
> >   drivers/pci/controller/pci-xgene.c         |  6 +-
> >   drivers/pci/controller/pcie-iproc.c        | 18 +++---
> >   drivers/pci/pci-bridge-emul.c              |  4 +-
> >   drivers/pci/pci.c                          | 41 +++++++++-----
> >   drivers/pci/pci.h                          | 11 +++-
> >   drivers/pci/probe.c                        | 33 +++++------
> >   include/linux/bcma/bcma_driver_pci.h       |  2 +-
> >   include/linux/pci.h                        |  1 +
> >   include/uapi/linux/pci_regs.h              |  6 +-
> >   12 files changed, 117 insertions(+), 97 deletions(-)
> 
> Although this looks like a useful series, I'm sorry to say but this doesn't
> solve the issue that Gary and I raised.  We double checked today and found
> that reading the vendor ID works just fine at this time.

Thanks for testing that.

> I think that we're still better off polling PCI_PM_CTRL to "wait" for D0
> after the state change from D3cold.

Is there some spec justification for polling PCI_PM_CTRL?  I'm dubious
about doing that just because "it works" in this situation, unless we
have some better understanding about *why* it works and whether all
devices are supposed to work that way.

Bjorn

