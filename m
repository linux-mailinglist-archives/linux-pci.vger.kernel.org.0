Return-Path: <linux-pci+bounces-7509-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9288C69ED
	for <lists+linux-pci@lfdr.de>; Wed, 15 May 2024 17:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DDCBB20A86
	for <lists+linux-pci@lfdr.de>; Wed, 15 May 2024 15:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E8C156227;
	Wed, 15 May 2024 15:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZNb+2fq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0C0156226
	for <linux-pci@vger.kernel.org>; Wed, 15 May 2024 15:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715787907; cv=none; b=eiMlYNj8Gk7UpjTYDLkcIazdeAovEIEnlda7SUUyvqLFJkfVeifS3rcNV8kCmNVKu9GFSQlbOzMo8Pvo5781R2xZ7SlrE1FEkA/7uactu6/H6+2zvG+eyjKWQqXuUvmapKSuBLoAcDTkkRci5vR/q6cTrDbhA1Fa/+fEC+LOMBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715787907; c=relaxed/simple;
	bh=4ud7NJAGwVzhTrQjn+6j6cRtsWsiEuyTC+HyuiOxDkc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Ja+Iodk5Ke2O07Xcjk5tiDD8Sw8UnTinZ4woCNeQ45ws6uGSynCr3JjiWUVAJaG2f3d3j2cy/QTWdf6WYj7zQN7oNVFS1cq3alkCN3++AifvlFDrDbNCMoSWBD8Dan6XGkQPAzazrjKG2VxeGU69QTlcz7bnXjRT93R5Y4x/1Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZNb+2fq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B8D0C116B1;
	Wed, 15 May 2024 15:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715787907;
	bh=4ud7NJAGwVzhTrQjn+6j6cRtsWsiEuyTC+HyuiOxDkc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=HZNb+2fqIN7V4MplDSnap5fCu+Fb2WJlzsx1FC2mONFAP2dz4zuLw0orp1GNRXsa1
	 1enOEQkWUn9/Cgo6Zj1Q8+efOJIkOvAC5hCkhyuQ+CrxpyCQTUu2ezUA5p2G5DhKQY
	 TPcKerGncP3lEAUPi6vYevTbt22iZlWEm0IzjKqwent15PJ7VCiRso2PfX8wnertPc
	 XmO3mDea2KhTzravHQUC/9pRSNi4f/CW4GYGtQXBkauYsA93CaSTwyOKK4MXaupXa1
	 410yD7btQjS6SmvO8hoZUcG+hUXayJv5e2Bdr1R7sABiiEf5NsMYlLso+9KFcPJK/Y
	 gU/YCGh5rvLLw==
Date: Wed, 15 May 2024 10:45:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jani Nikula <jani.nikula@intel.com>
Cc: intel-gfx@lists.freedesktop.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/8] drm/i915/pciids: PCI ID macro cleanups
Message-ID: <20240515154505.GA2123614@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ikzlhiv8.fsf@intel.com>

On Fri, May 10, 2024 at 04:55:07PM +0300, Jani Nikula wrote:
> On Fri, 10 May 2024, Jani Nikula <jani.nikula@intel.com> wrote:
> > This is a spin-off from [1], including just the PCI ID macro cleanups,
> > as well as adding a bunch more cleanups.
> >
> > BR,
> > Jani.
> >
> > [1] https://lore.kernel.org/all/cover.1715086509.git.jani.nikula@intel.com/
> >
> >
> > Jani Nikula (8):
> >   drm/i915/pciids: add INTEL_PNV_IDS(), use acronym
> >   drm/i915/pciids: add INTEL_ILK_IDS(), use acronym
> >   drm/i915/pciids: add INTEL_SNB_IDS()
> >   drm/i915/pciids: add INTEL_IVB_IDS()
> >   drm/i915/pciids: don't include WHL/CML PCI IDs in CFL
> >   drm/i915/pciids: remove 11 from INTEL_ICL_IDS()
> >   drm/i915/pciids: remove 12 from INTEL_TGL_IDS()
> >   drm/i915/pciids: don't include RPL-U PCI IDs in RPL-P
> >
> >  arch/x86/kernel/early-quirks.c                | 19 +++---
> 
> Bjorn, ack for merging this via drm-intel-next?

Sorry, I had ignored this because I didn't think it affected any PCI
stuff.  This is fine with me:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

But since you asked :), I'll gripe again about the fact that this
intel_early_ids[] list needs continual maintenance, which is not the
way things are supposed to work.  Long thread about it here:

https://lore.kernel.org/linux-pci/20201104120506.172447-1-tejaskumarx.surendrakumar.upadhyay@intel.com/t/#u

> >  .../drm/i915/display/intel_display_device.c   | 20 +++---
> >  drivers/gpu/drm/i915/i915_pci.c               | 13 ++--
> >  drivers/gpu/drm/i915/intel_device_info.c      |  3 +-
> >  include/drm/i915_pciids.h                     | 67 ++++++++++++-------
> >  5 files changed, 71 insertions(+), 51 deletions(-)
> 
> -- 
> Jani Nikula, Intel

