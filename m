Return-Path: <linux-pci+bounces-41267-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 92379C5EE7C
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 19:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 75BB74EBC0C
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 18:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDBD2DF710;
	Fri, 14 Nov 2025 18:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUj8JeRA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87822DF703
	for <linux-pci@vger.kernel.org>; Fri, 14 Nov 2025 18:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763145358; cv=none; b=unAvaaNxeTbnQGArIxBgCfFSliEBUpW9ZKjUyUjU4QUm8SIvDVg1sdlivyNM6bm307T3Hpjg6Zsit4gj5+V4snHUWP+D5W5PuRArMBTH3BRHW2es4GJQx30YEj2sc28QQTuWwdyuXGyhR56nW6/njJiyx3oonfhykcaJKOJErWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763145358; c=relaxed/simple;
	bh=oWD8GTV+Nt3ZDSChcU4v7mGij5MGJoOoxHwMCFXuXA8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=f+eI8f300eaK90JelAw+ULn8WRvNSFKh/07XzPWSXRPei1rkJN0XtFXSp31HpZvHO9lBnPlpmIIyFGCCsddFPeJG7uRIIwxY2gYIyTkPlJ8JXtBLvJ8JECalaHMKu037cXc45chK2A7zP0gEIMpXyDp0MbunShVU4Kz3+sGamio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NUj8JeRA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14213C19425;
	Fri, 14 Nov 2025 18:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763145358;
	bh=oWD8GTV+Nt3ZDSChcU4v7mGij5MGJoOoxHwMCFXuXA8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=NUj8JeRAJvue2hVfQfL1xMquhbeBz8n0pg9EV+VKjv2aEJkcKPkdyJiHVQjZFgpLP
	 qbGqUddaPYUzwwjZ5wNCpe9+o98YW5GodaXsW/JhBz+8SZfkDS7tpcqaVy9XEtSmgV
	 jwiYPdmUgPuOR92HVdp9pYc/B/kW8cNSx5Sb+7OFU66kjWHNcEb37kZ2ybylyT6Xle
	 QbchwTEsD0Flp9RCXEPuscrMweq2nJrqVYlJ3bfKBr+s3HPuFjyS9NZl3LOlzmcrBx
	 Uj9FbktzRB+9LAdFIP4btjaFBfmbi5PB+YgKIKIooxYJxJozM8uUMEV/ha+VjF8D0I
	 2vgnnISFAVVjA==
Date: Fri, 14 Nov 2025 12:35:56 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Simon Richter <Simon.Richter@hogyros.de>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	amd-gfx@lists.freedesktop.org, Bjorn Helgaas <bhelgaas@google.com>,
	David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	linux-pci@vger.kernel.org, Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Simona Vetter <simona@ffwll.ch>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>
Subject: Re: [PATCH v2 00/11] PCI: BAR resizing fix/rework
Message-ID: <20251114183556.GA2334513@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87jyzsq0nr.fsf@draig.linaro.org>

On Fri, Nov 14, 2025 at 12:06:00PM +0000, Alex Bennée wrote:
> Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> writes:
> 
> > Hi all,
> >
> > Thanks to issue reports from Simon Richter and Alex Bennée, I
> > discovered BAR resize rollback can corrupt the resource tree. As fixing
> > corruption requires avoiding overlapping resource assignments, the
> > correct fix can unfortunately results in worse user experience, what
> > appeared to be "working" previously might no longer do so. Thus, I had
> > to do a larger rework to pci_resize_resource() in order to properly
> > restore resource states as it was prior to BAR resize.
> <snip>
> >
> > base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
> 
> Ahh I have applied to 6.18-rc5 with minor conflicts and can verify that
> on my AVA the AMD GPU shows up again and I can run inference jobs
> against it. So for that case:
> 
> Tested-by: Alex Bennée <alex.bennee@linaro.org>

Thanks, Alex!  I added your Tested-by to this series, except for these
which I don't think are relevant for you:

  drm/xe: Remove driver side BAR release before resize
  drm/i915: Remove driver side BAR release before resize


