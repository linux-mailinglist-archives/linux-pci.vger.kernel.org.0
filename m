Return-Path: <linux-pci+bounces-7209-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C11B48BF43A
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 03:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2EB21C22292
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 01:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA7C8F5D;
	Wed,  8 May 2024 01:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IepalcJM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3803B8F55
	for <linux-pci@vger.kernel.org>; Wed,  8 May 2024 01:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715132783; cv=none; b=imHhGTREQRfFf7flpWrWnhbidRdSpo8Bkc8MYz9Q7qZb8wPe5s55zcmPRLlLeEaTt8xZm5azDeYymKjKR2Ux+pko2+UnufdlRoTsdEnfgz7hA9qWc1mf1q4ODESwOrXYhQ5xfKhqvLtVAZ5MGr7JqAU8x5YsRMUTOgMMjkdQt2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715132783; c=relaxed/simple;
	bh=IsoBP1NBJ49gFlpPzbsr0T4Uo2NuiBLfDdHz3RadSf8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Rzt97kNl/gGsfTYixwMSqeLT/Hd68cJqOkaA1ooWPNFbPfd69zx2NPEP9dSImxL3d7WOSwsH8L2+oo/9IgGW6NhyX0dAOrzHl6Ek+r9GD0Z4hF91PZp3xt6JUYjo/bXTCRUdV1a5+ZWh+8bYuyAiLJ/g5Na8LepgoPQ7T/UM4ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IepalcJM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94CFCC2BBFC;
	Wed,  8 May 2024 01:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715132782;
	bh=IsoBP1NBJ49gFlpPzbsr0T4Uo2NuiBLfDdHz3RadSf8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=IepalcJMG/IzIaBfrgw7bfyeqNJ7nru37JmoC4hsxd6difHwL6b4evvsZTEGsqlVY
	 LhYFgSsrRPfsDzaQygybePnncffemx9iDlpy2sxdPOSCjjzye9R0PogRJMnR41r3HV
	 BxpWJhTNS9apYYkivE6afHU2yVfZpMWaFMAzPFyqIqa5H0dmL/6ncON+auf4ajR7xV
	 aCd9bTaP+px7aB+mjOK6QNMSqN1I+jcPjbpTLJMup5AU45FvIxfg0A84ljZJAS+aEE
	 /J2WqN4KJYKzXnIn7rUHZv5ljoRhoxKiai7vFhlXwjQZecZneSNkfjky+vonSRZo42
	 4zsO2bm2mdJFw==
Date: Tue, 7 May 2024 20:46:21 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Nirmal Patel <nirmal.patel@linux.intel.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH v4] PCI: vmd: Disable MSI remap only for low MSI count
Message-ID: <20240508014621.GA1745464@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506173901.00003ec4@linux.intel.com>

On Mon, May 06, 2024 at 05:39:01PM -0700, Nirmal Patel wrote:
> On Fri, 26 Apr 2024 17:39:57 -0500
> Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Thu, Apr 18, 2024 at 11:31:21AM -0400, Nirmal Patel wrote:
> ...

> > A reference to ee81ee84f873 ("PCI: vmd: Disable MSI-X remapping when
> > possible"), which added VMD_FEAT_CAN_BYPASS_MSI_REMAP, might be
> > useful because it has nice context.
> > 
> > IIUC this will keep MSI-X remapping enabled in more cases, e.g., on
> > new devices that support more vectors.  What is the benefit of keeping
> > it enabled?
> 
> VMD MSI-X remapping was a performance bottleneck in certain
> situations. Starting from 28c0, VMD has a capability to disable MSI-X
> remapping and improve the I/O performance. The first iteration of 28c0
> VMD HW had only 64 MSI-X vectors support while the newer iterations can
> support up to 128 and VMD is no longer a bottleneck. So I thought it
> would be a good idea to change it to MSI-X remapping default ON.
> 
> Also upon further testings, I noticed huge boost in performance because
> of this CID patch:
> https://lore.kernel.org/kvm/20240423174114.526704-5-jacob.jun.pan@linux.intel.com/T/ 
> 
> The performance boost we get from the CID patch as follow:
> Kernel 6.8.8 : 1Drive: 2000, 4Drives: 2300
> 6.9.0-rc6 + CID + MSI-X remap Disable: 1Drive: 2700, 4Drives: 6010
> 6.9.0-rc6 + CID + MSI-X remap Enabled: 1Drive: 2700, 4Drives: 6100
> 
> Since there is no significant performance difference between MSI-X
> enable and disable after addition of CID patch, I think we can drop this
> patch for now until we see significant change in I/O performance due to
> VMD's MSI-X remapping policy.

OK, great, thanks for the background and the performance testing!

Bjorn

