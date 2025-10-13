Return-Path: <linux-pci+bounces-37981-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A2CBD64A8
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 22:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BB6114F342F
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 20:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF18523373D;
	Mon, 13 Oct 2025 20:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T5G5vHFP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EB634BA34;
	Mon, 13 Oct 2025 20:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760388932; cv=none; b=X7qalSSv16kYak2apv/GKQbxKQbSolcQrRfbY1TpH2XRkfTKoYSkogMn+Brfda3qzbzV2VA5+bpDQW6H6yAH8Fdst7uYh0tRBDVHBAtU4mHWL4ONDTUWqYmddUHsN5yjh5OLUX1K7+U+lvATOoqrktHxKFaCSSWrTo1umE5V6bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760388932; c=relaxed/simple;
	bh=IvZ5qPiJg4nsDInLimGBW6RVw9VdP4KCLc7lgSkyw10=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=lNTj+8d8qGXGqm/q23KfBGYZanv2l6dDqyBQQc6o+ey8GPAtijHiYWBIJnnxhdg2jOL7WWezgIO2NKUIEQ/KjQo/lyqDhVrfvxzNL8iWZUzdQ82fr2K1gEfydnvTvfQM9qamIBiindX9sQxcO7rPInq/y0SOQfbJXUNougB6zUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T5G5vHFP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F502C4CEF8;
	Mon, 13 Oct 2025 20:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760388932;
	bh=IvZ5qPiJg4nsDInLimGBW6RVw9VdP4KCLc7lgSkyw10=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=T5G5vHFPwfAcHGzeDU91/NjU01oUDsKPTDIGWz+CamLMXtBTA5Iq/VDCzC86z8O5G
	 79eKJ6WSDySyqA8FnEkp2QPNZr7rAiG7sbf74nRlQJ5IplElaiw5Q0NsA/uaYME0vr
	 h6NW3fvu/dXA20Ydzib4rccOLFEHYe84IsaxZaqmMNzrkeW1+YZ/oKcsUbIpJ5zJEE
	 xMdeP7LroxWj7ZUKYcplqw2BTHjfY6HEkSu9khTaioRfgwN379LKCoKsUa+hsdlxYS
	 0S98arvkgF7hwNRckqPnF49sJlU/u8Ah7tQAqz4nWY5EsbF2hGH7RAxyh7fLJkNhdr
	 ozG+/vvFuNj1w==
Date: Mon, 13 Oct 2025 15:55:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	Daniel Dadap <ddadap@nvidia.com>, regressions@lists.linux.dev
Subject: Re: [PATCH v10 2/4] PCI/VGA: Replace vga_is_firmware_default() with
 a screen info check
Message-ID: <20251013205531.GA863704@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251012182302.GA3412@sol>

[+cc regressions]

On Sun, Oct 12, 2025 at 11:23:02AM -0700, Eric Biggers wrote:
> On Mon, Aug 11, 2025 at 11:26:04AM -0500, Mario Limonciello (AMD) wrote:
> > vga_is_firmware_default() checks firmware resources to find the owner
> > framebuffer resources to find the firmware PCI device.  This is an
> > open coded implementation of screen_info_pci_dev().  Switch to using
> > screen_info_pci_dev() instead.
> > 
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
> > Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> 
> I'm getting a black screen on boot on mainline, and it bisected to this
> commit.  Reverting this commit fixed it.

#regzbot introduced: 337bf13aa9dd ("PCI/VGA: Replace vga_is_firmware_default() with a screen info check")
#regzbot link: https://lore.kernel.org/r/20251013154441.1000875-1-superm1@kernel.org

