Return-Path: <linux-pci+bounces-37857-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AAFBD0A18
	for <lists+linux-pci@lfdr.de>; Sun, 12 Oct 2025 20:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6677C4E6A85
	for <lists+linux-pci@lfdr.de>; Sun, 12 Oct 2025 18:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8783D2D6E43;
	Sun, 12 Oct 2025 18:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZGpI1Ua"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8F11F03C5;
	Sun, 12 Oct 2025 18:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760294928; cv=none; b=lYIQR42sa5vbJa2spFTVyZixyUfY2l59sv+fmySTwfLyna/vwNroY9zZpzdmaf7sEGTwuadnbGdtY1C5UdUQe5lIMX1EWt8xb4gLvWljLUH33JaSkFcjfEmhNMDfQb/TyQ7KVGQYDy/vnIvgRQL4owc/7uh3+bRUGT47A/T8DWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760294928; c=relaxed/simple;
	bh=cOrnDFV6qXfyhpfWj33oRaJEz5ZnXGKRMOEeTOdcbJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fmmrH3K1hZF69JfLtNvDgxM8oapD4NQPGny05Nm5HObhiFrWW2qHOGvZumHd/T86Dt1U+/6RPPzbdWFi1RZ5dKE526dEOIf8pslAK99Y2yLw/EhZyBqp3m1Ycq/M6NHBNIoqoUjMh+yBx+nhNhWP4EqMt8TgGOHyzF9Woaf1K/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZGpI1Ua; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79030C4CEE7;
	Sun, 12 Oct 2025 18:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760294926;
	bh=cOrnDFV6qXfyhpfWj33oRaJEz5ZnXGKRMOEeTOdcbJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DZGpI1Ua20DglBkzdZw0jkZorNwQdurfq3abfesjQLx+DUOtFLU9nHsdqtk4x3VHm
	 h5m6t8yG6fIU7lUFfik+e2NaaReTTa16vWJF8FRQjcRc4vqNfOdd5as5h/6CwouLKb
	 rik2chimNBNkdo4MG1gtuHzMXpJjb9qrhJnHakYG9mNr6PmO8kFnxJfM29jyp+Cswg
	 E5WMl68ooxhV7G3gEcmWZ80fzKwi1XabH5n0YkrJmCpZ2FhrzVuJJJzlfoxd2RAZVM
	 FtM6g/j7/uAzogOqHWJGuDSUfbcy6R+o2UazDy4XVBmh+dYe+u3Vd0CLJFjuk7+T/a
	 fUeY5U2vV2a/g==
Date: Sun, 12 Oct 2025 11:47:17 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Mario Limonciello <superm1@kernel.org>
Cc: David Airlie <airlied@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	Daniel Dadap <ddadap@nvidia.com>
Subject: Re: [PATCH v10 2/4] PCI/VGA: Replace vga_is_firmware_default() with
 a screen info check
Message-ID: <20251012184717.GB3412@sol>
References: <20250811162606.587759-1-superm1@kernel.org>
 <20250811162606.587759-3-superm1@kernel.org>
 <20251012182302.GA3412@sol>
 <1be1a119-1fbd-435f-bb27-70f48d677ebf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1be1a119-1fbd-435f-bb27-70f48d677ebf@kernel.org>

On Sun, Oct 12, 2025 at 01:37:33PM -0500, Mario Limonciello wrote:
> 
> 
> On 10/12/25 1:23 PM, Eric Biggers wrote:
> > Hi,
> > 
> > On Mon, Aug 11, 2025 at 11:26:04AM -0500, Mario Limonciello (AMD) wrote:
> > > vga_is_firmware_default() checks firmware resources to find the owner
> > > framebuffer resources to find the firmware PCI device.  This is an
> > > open coded implementation of screen_info_pci_dev().  Switch to using
> > > screen_info_pci_dev() instead.
> > > 
> > > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > > Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
> > > Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> > 
> > I'm getting a black screen on boot on mainline, and it bisected to this
> > commit.  Reverting this commit fixed it.
> > 
> > Please revert.
> > 
> > - Eric
> 
> Can you please share more information about your issue before we jump
> straight into a revert?  What kind of hardware do you have?  Perhaps a
> kernel log from mainline and another from mainline with the revert could
> help identify what's going on?
> 
> A revert might be the right solution, but I would rather fix the issue if
> it's plausible to do so.

Relevant hardware is:
    AMD Ryzen 9 9950X 16-Core Processor
    Radeon RX 9070

The following message appears in the good log but not the bad log:

    fbcon: amdgpudrmfb (fb0) is primary device

I don't have CONFIG_SCREEN_INFO enabled, so the commit changed
vga_is_firmware_default() to always return false.

If DRM_AMDGPU depends on SCREEN_INFO now, it needs to select it.

- Eric

