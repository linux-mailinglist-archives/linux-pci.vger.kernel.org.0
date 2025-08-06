Return-Path: <linux-pci+bounces-33458-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB07B1C279
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 10:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FA2D18A34E7
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 08:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E72123C519;
	Wed,  6 Aug 2025 08:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FS68EhgM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61F5211489;
	Wed,  6 Aug 2025 08:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754470284; cv=none; b=BY77uS4x+wgPHeB7PKNh/P4MRrb7P2Atm40aB/gHZoFFLgQ1OsWEtIgjRCEZHTex8eHN7OkdlhXn6Q2+aB8ZlV/IgkzuHCdiHkpWiiDClwEMw+oRgX9VO9QhfLUJk+mrc/2x3DOq4U24ggRAg3bUSPPDW0rXZmVA8s2xd5Fp8f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754470284; c=relaxed/simple;
	bh=v3RA7DLYKR7JcFq16sULHb+VwUGGch8VmfdjUcvhFqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bg5cdF2iKGxnCl511vM2O0OdJ/jGsfNuVBJukYdudu180jEGY1+GlQwyWrmcbp7VGOxTrAElUyXO3Q3XydWtTi9SU8UgVqBwsbf88KoWx2S27dopO4AuPBOyy8LeJj4RBN1uqnoRemc8uHs7m2F9y9NXX6V1cyEn5nU2QDaXGVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FS68EhgM; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754470283; x=1786006283;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v3RA7DLYKR7JcFq16sULHb+VwUGGch8VmfdjUcvhFqw=;
  b=FS68EhgMlXqV3D66zJRHumKD1KVVG2TDHjTumFX24WvFhqQKHxFlGaB2
   ikQd49tq49PJRIwARBVWbQZMCzBeTMnuJQRXDkUetcHf47H6o1W8y2FlM
   7J4Q/m1zq8EhiYWBY0S/mLnb8LXKWOmWHUQYZJQ/h743ypezK5qRk4I9v
   /YQuMY2LBmioyaTFC3g1TnZUO/1iUtJegGWcUz2C1ZVtIvw5xFzsTYt46
   k5k985wUm6IOOlns0M5cKzpdd4hbFB6kejy8t5M37fpt5oEI6yDXGwJ1v
   BoD1imM/+GkWuUtmkazjA/YeDUbGZW2WiDWRN8m739ccCvURlPbPrW9ep
   A==;
X-CSE-ConnectionGUID: 1LEnVZwLQbGbaFpVfgciKw==
X-CSE-MsgGUID: 09wi4JQETPKQwsexYzGawg==
X-IronPort-AV: E=McAfee;i="6800,10657,11513"; a="67477203"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="67477203"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 01:51:22 -0700
X-CSE-ConnectionGUID: oMHJmHuzR4G3kL09IoUw3g==
X-CSE-MsgGUID: BPvJt1EWQxSsm+CuA9GZkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="170101747"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa005.jf.intel.com with ESMTP; 06 Aug 2025 01:51:20 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id C330093; Wed, 06 Aug 2025 10:51:18 +0200 (CEST)
Date: Wed, 6 Aug 2025 10:51:18 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "Rangoju, Raju" <raju.rangoju@amd.com>
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, andreas.noever@gmail.com,
	michael.jamet@intel.com, westeri@kernel.org, YehezkelShB@gmail.com,
	bhelgaas@google.com, Sanath.S@amd.com
Subject: Re: [PATCH 0/3] thunderbolt: Update XDomain vendor properties
 dynamically
Message-ID: <20250806085118.GE476609@black.igk.intel.com>
References: <20250722175026.1994846-1-Raju.Rangoju@amd.com>
 <20250728064743.GS2824380@black.fi.intel.com>
 <59cd3694-c6e5-42c4-a757-594b11b69525@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <59cd3694-c6e5-42c4-a757-594b11b69525@amd.com>

On Wed, Aug 06, 2025 at 11:46:04AM +0530, Rangoju, Raju wrote:
> 
> 
> On 7/28/2025 12:17 PM, Mika Westerberg wrote:
> > Hi,
> > 
> > On Tue, Jul 22, 2025 at 11:20:23PM +0530, Raju Rangoju wrote:
> > > This patch series aims to update vendor properties for XDomain
> > > dynamically for vendors like AMD, Intel and ASMedia.
> > 
> > The XDomain properties pretty much describe "software" not the underlying
> > hardware so I don't understand why this is needed? We could have some USB
> > IF registered Linux specific ID there but I don't see why this matters at
> > all.
> 
> Currently, it is showing up as "Intel" on AMD host controllers during
> inter-domain connection. I suppose an alternative is to just call it "Linux"
> or "Linux Connection Manager" to ensure we accurately represent the
> connections across different systems.
> 
> I appreciate your guidance on this and suggestions you might have.

Yeah, something like that (I prefer "Linux"). The "ID" still is 0x8086
though but I don't think that matters. AFAIK we have other "donated" IDs in
use in Linux. Let me check on our side if that's okay.

> 
> > 
> > > Raju Rangoju (3):
> > >    thunderbolt: Dynamically populate vendor properties for XDomain
> > >    PCI: Add PCI vendor ID for ASMedia USB4 devices
> > >    thunderbolt: Add vendor ASMedia in update_property_block for XDomain
> > > 
> > >   drivers/thunderbolt/nvm.c     |  2 +-
> > >   drivers/thunderbolt/xdomain.c | 32 +++++++++++++++++++++-----------
> > >   include/linux/pci_ids.h       |  1 +
> > >   3 files changed, 23 insertions(+), 12 deletions(-)
> > > 
> > > -- 
> > > 2.34.1

