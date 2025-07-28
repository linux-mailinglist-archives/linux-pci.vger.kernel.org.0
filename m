Return-Path: <linux-pci+bounces-32995-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9AA7B1350D
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 08:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 048343AEA43
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 06:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBA520DD75;
	Mon, 28 Jul 2025 06:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="alEEZ1ZH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2981319DF4F;
	Mon, 28 Jul 2025 06:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753685269; cv=none; b=sZALhzEffk9eBRUJgXHkbu4W0gFQZtcLIuKK4vSm6HBNfQyCVhv8KWpkTUMOeVhJKBex4dwPHI4/8UgYtwBz/5Rf7klXvpVWKHSTsfH3WO2N7LuA1OPubXEX4Thna6S0K0NAxqvHOHZvrWdP1igLAW/qlSrmO1dT36QcqmaxA/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753685269; c=relaxed/simple;
	bh=NtnAIodCAbS4lQs1QJHpfh7DPZrQSeYeJgR/jK4M5IE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SsGnzhJlPKm4IvRolNHwY30xHD+5fmPWcUfM40xZ7RcVyUpFNSGqkoeRymPGjTB3DLgTwnook5lj1qkiqL29CZ5ljdUkuuFIPxRnMaOJXBuW0B+sC8rmZ7TfVb1W7wvh7UwOutpg5tmI7tcgvA3FzRauJmHc0LoIIdkjgzs8Ndg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=alEEZ1ZH; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753685269; x=1785221269;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NtnAIodCAbS4lQs1QJHpfh7DPZrQSeYeJgR/jK4M5IE=;
  b=alEEZ1ZHJbgRPwkgHN1hFzbV/pkvEjbt5xug9JqKOqgVWDgVpHasG1TK
   pAz4Et/HqmCvbCZ3e4vTV1lFTDfK9eEwIH3AupayNJ4KiaPh2gzFeQc2j
   Btdl+xp1LTYkex/RU0CJOAYOGFYX8v9nOZuyITaMtyODUZwFBFg06PqG5
   1Q3AH8KCU4xSSfbq4Rtq+ujfeEtBTPgDGXDqGF6iZUs9TswWEWAp64ctN
   FSS/epN8131Y6NUrcWoVDK8o6FYE3klB2/wMo71oNNHfxOBVL2TFKnnzP
   5NXCC3WXsDzfRdcNaZD5Y/Q+cuoDG44bE0QsqSDgXgOUNp7etO/iOK7ys
   g==;
X-CSE-ConnectionGUID: JMrDWLqaTx6ydUuRnt1A7g==
X-CSE-MsgGUID: Z3Rwr3+CS2CUvXJ/2iJQXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11504"; a="55807649"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="55807649"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2025 23:47:48 -0700
X-CSE-ConnectionGUID: BgUcHTbOR3OvHrRhDJMOzw==
X-CSE-MsgGUID: 3aYCwf63S4urbzrr+hMDDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="161620194"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 27 Jul 2025 23:47:45 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 8308F15B; Mon, 28 Jul 2025 09:47:43 +0300 (EEST)
Date: Mon, 28 Jul 2025 09:47:43 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, andreas.noever@gmail.com,
	michael.jamet@intel.com, westeri@kernel.org, YehezkelShB@gmail.com,
	bhelgaas@google.com, Sanath.S@amd.com
Subject: Re: [PATCH 0/3] thunderbolt: Update XDomain vendor properties
 dynamically
Message-ID: <20250728064743.GS2824380@black.fi.intel.com>
References: <20250722175026.1994846-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250722175026.1994846-1-Raju.Rangoju@amd.com>

Hi,

On Tue, Jul 22, 2025 at 11:20:23PM +0530, Raju Rangoju wrote:
> This patch series aims to update vendor properties for XDomain
> dynamically for vendors like AMD, Intel and ASMedia.

The XDomain properties pretty much describe "software" not the underlying
hardware so I don't understand why this is needed? We could have some USB
IF registered Linux specific ID there but I don't see why this matters at
all.

> Raju Rangoju (3):
>   thunderbolt: Dynamically populate vendor properties for XDomain
>   PCI: Add PCI vendor ID for ASMedia USB4 devices
>   thunderbolt: Add vendor ASMedia in update_property_block for XDomain
> 
>  drivers/thunderbolt/nvm.c     |  2 +-
>  drivers/thunderbolt/xdomain.c | 32 +++++++++++++++++++++-----------
>  include/linux/pci_ids.h       |  1 +
>  3 files changed, 23 insertions(+), 12 deletions(-)
> 
> -- 
> 2.34.1

