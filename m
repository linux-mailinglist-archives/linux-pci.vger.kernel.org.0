Return-Path: <linux-pci+bounces-41142-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 656B4C5958E
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 19:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5ECF4503C53
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 17:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C99C3624AC;
	Thu, 13 Nov 2025 16:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+qg4lkz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2507C346FA4;
	Thu, 13 Nov 2025 16:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763053063; cv=none; b=hN5XekQrTgyYdZcSz+8VOiRKjr2HtBdb7SW5verWx2J8+Gm9zU6wwDgePC9R4wgesBcQ5XFSHd8OaumJKW7luGMzSSlCEm92OCKQfvNQUPwy/5aDwhHhqY/fD7/RoGIWS4KsZmDF0aqKf1JuCRz5mNxD+lpq1hwGJCzDfjnJdGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763053063; c=relaxed/simple;
	bh=GYMl84uOyw1qOLVxM8g1QeRFBc0QP2rjuLETvSvGF+8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=V6B7gCMYuarQDhNLQJxVbpNoomgu8Pxp6MUAYq2u5bpSSsmdnCtQHo6sjkDqLq0mA0/sGXU2pY3OOdWxrhIh1pfiWGzWsn1U61CgJGQZrbfZRSZ7Ir8b1GB7Un6R6qc2Jxq24/T2Std6LIEg9VEOXZk8okJJu0UUXCe+I/YWj1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+qg4lkz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85372C4CEFB;
	Thu, 13 Nov 2025 16:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763053062;
	bh=GYMl84uOyw1qOLVxM8g1QeRFBc0QP2rjuLETvSvGF+8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=e+qg4lkzb8JVZPmAq8f+RZNKCKx7PBOXzfdHxJ9AoAazhEv+USLriQCChCv3RE3s4
	 r3mUFdHjD6xH5Rf3gK/6vPhvw0gdiRDUe5CfpKd5jFdCkIlNDcYnuDYVbSW4MTURa5
	 oVMn9fmO1taFYFp9e9AGrE8jHBUS0hORyHyOOItLgIBFiecHbsPAT7CzCT81NNIDR1
	 5GnznoD7VSdmm/DBWDXyBaQHTzzx5kUTNK2Nj2EYc4E4LLe5zzg3iOIZv6ADwhYZh0
	 EgzSZcipbUZtZbFM7etNYGxkiP0r0hwZybkvUEmj7b3CXEDuqeaLVSTGxy3Edd+gUl
	 8OiupaqeLTIBA==
Date: Thu, 13 Nov 2025 10:57:41 -0600
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
Message-ID: <20251113165741.GA2288786@bhelgaas>
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
> > On Tue, Oct 28, 2025 at 07:35:44PM +0200, Ilpo Järvinen wrote:
> > > pci_rebar_set_size() adjusts BAR size for both normal and IOV BARs. The
> > > struct pci_srvio keeps a cached copy of BAR size in unit of
> > > resource_size_t in ->barsz[] ...
> > 
> > Nit: s/pci_srvio/pci/sriov/  (fixed locally, FYI in case you post a v2)
> 
> I just posted v2 without seeing this first. :-(

Perfect, we crossed in the mail!  I'll tweak this locally.

