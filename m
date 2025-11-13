Return-Path: <linux-pci+bounces-41184-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F94C5A0A7
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 22:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 572424E3452
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 21:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12831323416;
	Thu, 13 Nov 2025 21:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QznaqxTr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E22323406;
	Thu, 13 Nov 2025 21:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763067776; cv=none; b=DNR3c+HVhSOvTDvPNiALrLA7Qm2X7UL3Bm02i+xPUZBwvCit/M3P4OXEhN/MfxQMl+iTA/uxzgQY+M6kTzU7UmJPG8FR5FP5AQ3C6BdNUEfcX/4jdf6SUsciGCHmD0wdSh7eE37jNfyK+1Xt6xFKOOBc265nvglgUmf15wC6gpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763067776; c=relaxed/simple;
	bh=XCYM0PneB34dkgpd6HhddZ4DMk4Wy8BVlu694U3Kv0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=gQBB4qeJrc1lnYLU0bj1JTkCoeh0OYumA5Z7F26+6mvLaHs4CwXAs1JuKCweeeQwb3MI57GBBgjw9fBjG3P6oZfA7D51hXNAicUsdzvb82DiZ16HpHRgkCi996rilFBxjkCZ60hdIDZAU34EV8nSVpiOV+o99LWRc7bPpzByZ6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QznaqxTr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4783EC2BC87;
	Thu, 13 Nov 2025 21:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763067776;
	bh=XCYM0PneB34dkgpd6HhddZ4DMk4Wy8BVlu694U3Kv0Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=QznaqxTrVF703q5hHIzrRmdgY0vvHnkqScL9EikZSt9aUswzTtKYeHNyxsjApN+nk
	 LsHIMNcCDMzDiqpEDxhWZ3SIgliY3izOazQBD5Q91bUiJRXVnwm5YIOvfKegmzkpgf
	 3J2UtCp6HaFjHHpX96rGcezc1GOSoEMSon59+jxz1MR0Y8HejVjzL4F6ne3FXRWbC8
	 GL5Bb3KRnsScrv8kKx6fqKoCjoW7GMT8yhEbnGdZ154mS8okDPLSAA9yoxMyMYoYKf
	 4kW4O0+KFTSGT7XIR2mohWJIAjhZ60NmIES0hoUUHBFbOxH9ORwk+BPjSNG7UUXPl+
	 /9+eOQz9kOKkw==
Date: Thu, 13 Nov 2025 15:02:54 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
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
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/9] PCI/IOV: Adjust ->barsz[] when changing BAR size
Message-ID: <20251113210254.GA2314858@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fe9bd3af-51f6-c1af-9cdc-c78aee7aaef9@linux.intel.com>

On Thu, Nov 13, 2025 at 06:35:26PM +0200, Ilpo Järvinen wrote:
> On Thu, 13 Nov 2025, Bjorn Helgaas wrote:
> 
> > On Tue, Oct 28, 2025 at 07:35:44PM +0200, Ilpo Järvinen wrote:
> > > pci_rebar_set_size() adjusts BAR size for both normal and IOV BARs. The
> > > struct pci_srvio keeps a cached copy of BAR size in unit of
> > > resource_size_t in ->barsz[] ...

> > I'm not sure what "unit of resource_size_t" adds here, maybe could be
> > removed to just say this?
> > 
> >   struct pci_srvio keeps a cached copy of BAR size in ->barsz[] ...
> 
> Seems okay with me. I just had it there to differentiate from "BAR size" 
> which happens to often be the format directly compatible with field in the 
> capability.

Ah, I see now, "size" used to be in bytes, but now it's the encoded
size.

