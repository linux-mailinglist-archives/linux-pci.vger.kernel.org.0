Return-Path: <linux-pci+bounces-32085-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 017AEB0483B
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 22:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45C6816E471
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 20:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8558C230BEE;
	Mon, 14 Jul 2025 20:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XtsjOh5A"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B81A204098;
	Mon, 14 Jul 2025 20:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752523556; cv=none; b=Uh5G7ob3rnvLVArb2iGQ4hGwBiZgMscEPmMHMMhr45s+WHhK68GMLHU9Oq1z3gE0gl+mKOvuDRHMlxdSDHpjvjIRgaxEuzfgxbrESp5yqPmWwvTcmztEARCEirqL8Rw/fcrY+AfTa2/OxxarnpN5/iu9Gw4O9CXm28eTT+n1Alg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752523556; c=relaxed/simple;
	bh=774extu3EbE/at8bK2G6NRtny1ot7XOThjOCbB2Kxg0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ehbatLxXt7aC4b3bkJN0ntyEEvrEmCVf8vCsF8fUoj9q0tssY12/+kQMnLilJKg+0K1ve1IhEEK/FimCidjcFRTPYcHIoDj6bxBDbu/5SPelpWZv2y1MGGoJZcmTsqqKC8RoJPV6UfLUHXPKQuEHv5QQT6HYsgyOaLgfj731N2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XtsjOh5A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01BDCC4CEED;
	Mon, 14 Jul 2025 20:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752523556;
	bh=774extu3EbE/at8bK2G6NRtny1ot7XOThjOCbB2Kxg0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=XtsjOh5A/oNMyG9gybPrSrluKoNLS4F3kMIxBh5hZ18lBYSAZyrMnn3VGv0bBrv3K
	 D9GWZbtpDL/WgrRFK/F87PnIcVxHgzQPHeaYjojl0/InlHcnEXd8MXKhdPz5NZsl/y
	 WvukWT+hIA9kxDV2+2+fgyPFwVdhF0aevYMqsvIlHScJjergwK+efgotQPiBTcb6zI
	 /mBPd8ZKiXlZQSArZ3Io85SjBTEdCqu2pXfEQ8XQVz47nj2BNDz00+ZcZMwLwdEBiM
	 pBj64wGJoEXt5LkDntSOxVqieuGYzh7zu75bjiUB7+dD+wF8BFVuIKMH8XSFHJhZhz
	 xHWtBVvWxovmA==
Date: Mon, 14 Jul 2025 15:05:53 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: =?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Matt Roper <matthew.d.roper@intel.com>
Subject: Re: [PATCH v10 0/5] PCI: VF resizable BAR
Message-ID: <20250714200553.GA2418827@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250702093522.518099-1-michal.winiarski@intel.com>

On Wed, Jul 02, 2025 at 11:35:17AM +0200, Michał Winiarski wrote:
> Hi,
> 
> The series is now reviewed, and it looks like there's no further
> feedback.
> To limit it to PCI subsystem, I removed the last patch in the series, as
> it contained changes in drm/xe driver (it can still be found in v9 for
> reference, and I expect that this single patch will go through DRM tree
> anyways).
> 
> v9 can be found here:
> https://lore.kernel.org/linux-pci/20250527120637.665506-1-michal.winiarski@intel.com/
> 
> For regular BAR, drivers can use pci_resize_resource to resize it to the
> desired size provided that it is supported by the hardware, which the
> driver can query using pci_rebar_get_possible_sizes.
> This series expands the API to work with IOV BAR as well.
> It also adds the additional API for drivers to change the VF BAR size
> without resizing the entire underlying reservation (within the original
> resource boundary).
> 
> Thanks,
> -Michał
> 
> v9 -> v10:
> - Remove last patch with drm/xe changes
> 
> v8 -> v9:
> - Use u64 as do_div() dividend (LKP)
> - Introduce a helper to access cached vf_rebar_cap (LKP)
> 
> v7 -> v8:
> - Update variable ordering and missing includes (Ilpo)
> 
> v6 -> v7:
> - Eliminate the loop in pci_iov_vf_bar_get_sizes() (Ilpo)
> - Use helper variable for indexes (Ilpo)
> - Kerneldoc formatting (Ilpo)
> - Refer to latest PCI spec (Ilpo)
> - Commit message wording (Ilpo)
> 
> v5 -> v6:
> - Rebased on latest pci/next
> - Cache the VF resizable BAR capability position to avoid multiple
>   lookups (Ilpo)
> - Use pci_resource_n helper (Ilpo)
> 
> v4 -> v5:
> - Rename pci_resource_to/from_iov helpers and add WARN if called without
>   CONFIG_PCI_IOV (Ilpo)
> - Reword kerneldoc for pci_iov_vf_bar_get_sizes (Bjorn)
> - Reword commit message for VF BAR size check, extract the additional
>   size check to separate conditional (Bjorn)
> 
> v3 -> v4:
> - Change the approach to extending the BAR (Christian)
> - Tidy the commit messages, use 80 line limit where necessary (Bjorn)
> - Add kerneldocs to exported functions (Bjorn)
> - Add pci_resource_to_iov() / pci_resource_from_iov() helpers (Ilpo)
> - Use FIELD_GET(), tidy whitespace (Ilpo)
> 
> v2 -> v3:
> - Extract introducing pci_resource_is_iov to separate commit and
>   use it elsewhere in PCI subsystem (Christian)
> - Extract restoring VF rebar state to separate commit (Christian)
> - Reorganize memory decoding check (Christian)
> - Don't use dev_WARN (Ilpo)
> - Fix build without CONFIG_PCI_IOV (CI)
> 
> v1 -> v2:
> - Add pci_iov_resource_extend() and usage in Xe driver
> - Reduce the number of ifdefs (Christian)
> - Drop patch 2/2 from v1 (Christian)
> - Add a helper to avoid upsetting static analysis tools (Krzysztof)
> 
> Michał Winiarski (5):
>   PCI/IOV: Restore VF resizable BAR state after reset
>   PCI: Add a helper to convert between VF BAR number and IOV resource
>   PCI: Allow IOV resources to be resized in pci_resize_resource()
>   PCI/IOV: Check that VF BAR fits within the reservation
>   PCI: Allow drivers to control VF BAR size
> 
>  drivers/pci/iov.c             | 153 +++++++++++++++++++++++++++++++---
>  drivers/pci/pci.c             |   8 +-
>  drivers/pci/pci.h             |  39 +++++++++
>  drivers/pci/setup-bus.c       |   3 +-
>  drivers/pci/setup-res.c       |  35 ++++++--
>  include/linux/pci.h           |   6 ++
>  include/uapi/linux/pci_regs.h |   9 ++
>  7 files changed, 235 insertions(+), 18 deletions(-)

Applied to pci/resources for v6.17, thanks for the reminder!

