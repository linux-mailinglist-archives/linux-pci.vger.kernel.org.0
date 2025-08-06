Return-Path: <linux-pci+bounces-33464-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B53B1C80E
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 17:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F16B23A6D11
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 15:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75DB18024;
	Wed,  6 Aug 2025 15:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cfZ6uI0N"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BF219E992;
	Wed,  6 Aug 2025 15:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754492430; cv=none; b=RWtLkmEEbmEZo5lsxDFhh3OD2HhJz9KKC/WQi7pwn/GbB+CexGU7YQVvZkiGshibcyUAUCdVv7BIjw36/TuFK52V40j+l96Ygz9bn/bHicFACelQROgoCoudSd77IbjHQ8fSv6ONZrNKe5EAhVUTkWzvrTJ0XuC3zyWyvlLPDjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754492430; c=relaxed/simple;
	bh=NZYlaG8r3EDBWq6FZCA9fbeaAN0MEU/bf8kd/Nrn8Jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UiOVxaWOpa0Sb7wvBOOGPUIRUsXzFhoo6ozoZOcv2W/T3ihhLpbUu26BTvnIuQsuVKUNCjlCrBCMTj9/mrqCoG3nVf/Y2m4ZnKkT+Iiy0mtX7u8VQmYlblPoed0Oh+HpHh8JEOjnnxiswGQlQDyhYw3HdarFnDgoudEwCUiz47Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cfZ6uI0N; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754492429; x=1786028429;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NZYlaG8r3EDBWq6FZCA9fbeaAN0MEU/bf8kd/Nrn8Jo=;
  b=cfZ6uI0NucCy4Ukzf+CEuea+05x8WpOjgkDJSKc7kiJOAipqLvT9bmwc
   0dgWiCWpRtkdH2ZeR/8Y1Y1HgbL37jfAdV3aLt3r9UucTQ6uMUd7rDyZZ
   umm6wYnb2k08DrhTEAZJP/Bq3scR6hn/Pe3SB/vhLJLH6/zY1y4r3Kp3O
   2+DoP5eAF3dgXpIb1yi78Gkp064mN4ADivnM8u1Ot6Jo+Zwrx9Os3EH5/
   9kIj9aj7T7hXl+8p2F54wgrdNaMWcGElhHjScR9HpDm2E/Dm/UUlxGOSV
   yEhRCCNSL3yGuZJ4Z9OCILuhCnX8QJOv8bC5Kukt3chdzDLC92NxejzJ+
   Q==;
X-CSE-ConnectionGUID: tOLrWuXJSXu4U44GQQ4EWw==
X-CSE-MsgGUID: Rao2NrYHQNKrg5KcVNCYaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="56777527"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="56777527"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 08:00:28 -0700
X-CSE-ConnectionGUID: EFG0lXBJRwGYYfFXh00xUQ==
X-CSE-MsgGUID: OtciXMZiSfSxMhaLID6L1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="170168899"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa005.jf.intel.com with ESMTP; 06 Aug 2025 08:00:26 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id D0CB493; Wed, 06 Aug 2025 17:00:24 +0200 (CEST)
Date: Wed, 6 Aug 2025 17:00:24 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: "Rangoju, Raju" <raju.rangoju@amd.com>, linux-usb@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	andreas.noever@gmail.com, michael.jamet@intel.com,
	westeri@kernel.org, YehezkelShB@gmail.com, bhelgaas@google.com,
	Sanath.S@amd.com
Subject: Re: [PATCH 0/3] thunderbolt: Update XDomain vendor properties
 dynamically
Message-ID: <20250806150024.GF476609@black.igk.intel.com>
References: <20250722175026.1994846-1-Raju.Rangoju@amd.com>
 <20250728064743.GS2824380@black.fi.intel.com>
 <59cd3694-c6e5-42c4-a757-594b11b69525@amd.com>
 <20250806085118.GE476609@black.igk.intel.com>
 <9a757d21-a6e0-4022-b844-57c91323af5e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9a757d21-a6e0-4022-b844-57c91323af5e@kernel.org>

On Wed, Aug 06, 2025 at 09:06:30AM -0500, Mario Limonciello wrote:
> On 8/6/2025 3:51 AM, Mika Westerberg wrote:
> > On Wed, Aug 06, 2025 at 11:46:04AM +0530, Rangoju, Raju wrote:
> > > 
> > > 
> > > On 7/28/2025 12:17 PM, Mika Westerberg wrote:
> > > > Hi,
> > > > 
> > > > On Tue, Jul 22, 2025 at 11:20:23PM +0530, Raju Rangoju wrote:
> > > > > This patch series aims to update vendor properties for XDomain
> > > > > dynamically for vendors like AMD, Intel and ASMedia.
> > > > 
> > > > The XDomain properties pretty much describe "software" not the underlying
> > > > hardware so I don't understand why this is needed? We could have some USB
> > > > IF registered Linux specific ID there but I don't see why this matters at
> > > > all.
> > > 
> > > Currently, it is showing up as "Intel" on AMD host controllers during
> > > inter-domain connection. I suppose an alternative is to just call it "Linux"
> > > or "Linux Connection Manager" to ensure we accurately represent the
> > > connections across different systems.
> > > 
> > > I appreciate your guidance on this and suggestions you might have.
> > 
> > Yeah, something like that (I prefer "Linux"). The "ID" still is 0x8086
> > though but I don't think that matters. AFAIK we have other "donated" IDs in
> > use in Linux. Let me check on our side if that's okay.
> 
> Having looked through this discussion I personally like "Linux" for this
> string too.
> 
> As for the vendor ID doesn't the LF have an ID assigned already of 0x1d6b?
> Would it make sense to use that?

AFAIK that's PCI ID, right? It should be USB IF assigned ID and LF is not
here at least:

  https://www.usb.org/members

If it really matters we can sure register one.

> I was also thinking about the device ID, should we consider encoding the
> VERSION, PATCHLEVEL, and SUBLEVEL into the ID?  The reason I'm thinking
> about that is let's say there is some bug found in the CM on Linux and
> another implementation decides to work around it.  We get wind of it and fix
> the bug but in Linux but now what about the other end?  If we give them a
> hint on the version by putting it in the device ID they can potentially key
> off that to decide to tear out the workaround.

I'm not sure that's a good idea. Then we expose also all the known
vulnerabilities.

