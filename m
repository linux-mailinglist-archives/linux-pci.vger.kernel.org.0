Return-Path: <linux-pci+bounces-25641-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 318A0A84F94
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 00:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 200B94C20C9
	for <lists+linux-pci@lfdr.de>; Thu, 10 Apr 2025 22:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF77120C48E;
	Thu, 10 Apr 2025 22:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QGvMFau0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A561EB9F9;
	Thu, 10 Apr 2025 22:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744323570; cv=none; b=GYfErS91XxrWqZin4xJpWsgPrVPNo+9S1dkQ8UMYaTe/BAhzVZz8p9G2yw/bufhXN27azrkIaOBIPV7jf2vCKii1XC10yUILr6b7+5XDHz0p4qgL7Etw31BXYewkovZ48UiBAKG2hN6W1elbN4hXiSgKS3CfW0ytIyk8FS0t/As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744323570; c=relaxed/simple;
	bh=X1dwmXuAbfor+7JFgNyIpBi3NXIWU1i8lpUX6lqNLJI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=eVxvpx/CHpyYXwB5x2wx+mnsxzBOjKFOAOHbfdbSXiWbm8ZKp6meZsrcH8hkisC3ywwgGN/RLiDc+eKxDS50BTZ09KQXBp/5M5SUK7tYBOzPDin/Cz/EasOGW6939dzytPRG7ryZQlu7kpVFcdbrLS6Rfx99V6pUyS1c+ue8l+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QGvMFau0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4A2CC4CEE7;
	Thu, 10 Apr 2025 22:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744323569;
	bh=X1dwmXuAbfor+7JFgNyIpBi3NXIWU1i8lpUX6lqNLJI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=QGvMFau0drRmx7INm9T1F9HyBXLgCBh8qV224QAgH3Tcaj5avNiDeoiitiPWdC8A+
	 zGgV0PgyMZF4DfcwpJN1CE37v0ZIcwE8YjFdxRp8dZ1h1eOOwEjBzoKS+xEdWvwMRx
	 VwNUliivlpkpRZS7DMf/r2h2gQW+iHFe60mjU8loFhBN7VtK0Jj5/evDnSauOEOqPV
	 a7+sXfZpEKYF66B/yrNCdARAlzsgTgqnaqro3zpamo/ez5b7WTX5NkE+ExJQByuzXr
	 tjxZ25cBbw0T30X0FWbe5F7YSbnHKEsOdUSW/TSvigI5zQtc8Cmk8lX9o1YNtzm/Pb
	 f6973qElJtmuA==
Date: Thu, 10 Apr 2025 17:19:28 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Keith Busch <kbusch@kernel.org>,
	Yicong Yang <yangyicong@hisilicon.com>, linux-pci@vger.kernel.org,
	Stuart Hayes <stuart.w.hayes@gmail.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Joel Mathew Thomas <proxy0@tutamail.com>,
	Russ Weight <russ.weight@linux.dev>,
	Matthew Gerlach <matthew.gerlach@altera.com>,
	Yilun Xu <yilun.xu@intel.com>, linux-fpga@vger.kernel.org,
	Moshe Shemesh <moshe@nvidia.com>, Shay Drory <shayd@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 0/2] Ignore spurious PCIe hotplug events
Message-ID: <20250410221928.GA342293@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1744298239.git.lukas@wunner.de>

On Thu, Apr 10, 2025 at 05:27:10PM +0200, Lukas Wunner wrote:
> Trying to kill several birds with one stone here:
> 
> First of all, PCIe hotplug is deliberately ignoring link events occurring
> as a side effect of Downstream Port Containment.  But it's not yet ignoring
> Presence Detect Changed events.  These can happen if a hotplug bridge uses
> in-band presence detect.  Reported by Keith Busch, patch [1/2] seeks to
> fix it.
> 
> Second, PCIe hotplug is deliberately ignoring link events and Presence
> Detect Changed events occurring as a side effect of a Secondary Bus Reset.
> But that's no longer working properly since the introduction of bandwidth
> control in v6.13-rc1.  Actually it never worked properly, but bandwidth
> control is now mercilessly exposing the issue.  VFIO is thus broken,
> it resets the device on passthrough.  Reported by Joel Mathew Thomas.
> 
> Third, link or presence events can not only occur as a side effect of DPC
> or SBR, but also because of suspend to D3cold, a firmware update or FPGA
> reconfiguration.  In particular, Altera engineers report that the link
> goes down as a side effect of FPGA reconfiguration and the PCIe hotplug
> driver responds by disabling slot power.  Obviously not what you'd want
> while the FPGA is being reconfigured!
> 
> This leads me to believe that we need a generic mechanism to tell hotplug
> drivers that spurious link changes are ongoing which need to be ignored.
> Patch [2/2] introduces an API for it and the first user is SBR handling
> in PCIe hotplug.  This fixes the issue exposed by bandwidth control.
> It also aligns DPC and SBR handling in the PCIe hotplug driver such that
> they use the same code path.
> 
> The API pci_hp_ignore_link_change() / pci_hp_unignore_link_change() is
> initially not exported.  It can be once the first modular user shows up.
> 
> Although these are technically fixes, they're slightly intrusive, so it
> would be good to let them simmer in linux-next for a while.  One option
> would be to apply for v6.16 and let Greg & Sasha do the backporting.
> Another would be to apply to the for-linus branch for v6.15 but wait
> maybe 4 weeks before a pull request is sent.
> 
> Please review and test.  Thanks!
> 
> Lukas Wunner (2):
>   PCI: pciehp: Ignore Presence Detect Changed caused by DPC
>   PCI: pciehp: Ignore Link Down/Up caused by Secondary Bus Reset
> 
>  drivers/pci/hotplug/pci_hotplug_core.c | 69 ++++++++++++++++++++++++++++++
>  drivers/pci/hotplug/pciehp.h           |  1 +
>  drivers/pci/hotplug/pciehp_core.c      | 29 -------------
>  drivers/pci/hotplug/pciehp_hpc.c       | 78 ++++++++++++++++++++++------------
>  drivers/pci/pci.h                      |  3 ++
>  include/linux/pci.h                    |  8 ++++
>  6 files changed, 132 insertions(+), 56 deletions(-)

Applied to pci/hotplug for now, thanks!  We can get it into -next and
if all goes well easily move to for-linus for v6.15 if that's the
right thing.

