Return-Path: <linux-pci+bounces-39589-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E77A5C173B4
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 23:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04CDC3A5F8B
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 22:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995CE369977;
	Tue, 28 Oct 2025 22:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYvPmfuF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AF228D8E8;
	Tue, 28 Oct 2025 22:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761691853; cv=none; b=fRQlikLbrYm6z9AWxNR4fBg8QLwq3ezIn+s6SA0DN4bwgLeeCZzZg71xSAcgoyYRjz07brr5S7qLCTtr0rkc9ceyjTKujpB/3HW3aNn+NVePjWq+a+v9nOUt+mmLKPpAG46m6VA69KrdyZNemE3tI+SBCwQo4Poxs1UwlDtHYHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761691853; c=relaxed/simple;
	bh=L4JGtdU/PjFb6Mg5UZQwW4ZifK4zb8fU7qiihyPidzU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=uqI0uTY978s2M4jKiUzlLvZca2TGF6s382JnSzMpkhyrUp53Y7T+JvCQYXzfzLkbxpbRi7rG3juir74hQsGYwyriCH/b2tB776sT1gXgJfKWwHIoVREgn/NUeuBNzcLWtlcBc6+HRvPXNQvf16AhL3BfjqRlJGkc3RAxLUV0K+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYvPmfuF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC911C4CEE7;
	Tue, 28 Oct 2025 22:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761691852;
	bh=L4JGtdU/PjFb6Mg5UZQwW4ZifK4zb8fU7qiihyPidzU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=VYvPmfuFIwFFKG0xW/1zwOngMDq86wzK9/tYYY0jF6socm+7UDjazsfo+RKrQGNj3
	 bqQpVnsv7SPg53gOiJ97C5sHiV1B0REEuPmCZ4a5VBdkKMMxWvcfX1PAp1GX9xe8XW
	 +o9xN6ly3PCh9M458Y4kwg8QF/0/88xgcB9TEJPr7tv1G8lz+WZIuv5abkqjtY1oWR
	 zOmdQ0vAw5S+OHOrbf1wVoZkZu3uPgYaIRJUWMlyy/ElBgvwO+PTjMtbx1oA8zps/9
	 EN5SWWq9Jm7qAFEqxrjkawtNtnwHW1LpDTkx/EVmIp5qwJlhpu69jDv/RDZ3rKqgpg
	 ISO2lDrXKNKGQ==
Date: Tue, 28 Oct 2025 17:50:51 -0500
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
Message-ID: <20251028225051.GA1539380@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013205531.GA863704@bhelgaas>

On Mon, Oct 13, 2025 at 03:55:31PM -0500, Bjorn Helgaas wrote:
> On Sun, Oct 12, 2025 at 11:23:02AM -0700, Eric Biggers wrote:
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
> 
> #regzbot introduced: 337bf13aa9dd ("PCI/VGA: Replace vga_is_firmware_default() with a screen info check")
> #regzbot link: https://lore.kernel.org/r/20251013154441.1000875-1-superm1@kernel.org

#regzbot fix: a78835b86a44 ("PCI/VGA: Select SCREEN_INFO on X86")

