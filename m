Return-Path: <linux-pci+bounces-24841-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0303A73063
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 12:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09DC217BE25
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 11:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4622135C2;
	Thu, 27 Mar 2025 11:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oE4vReb+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EFF2135B3;
	Thu, 27 Mar 2025 11:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743075782; cv=none; b=J1QX+LuVs0GOD0fWLwTgMXlBzWwoA9KuXKj1745pwoQZCmnUTjqEWbKLALdNakyvLhgmvOZXQGPvDAVa5wvG3+0w9bPtK9nExcB4drpHw2VA+E1ooLtQcSaOw51SMJETliw6Pal02ImBclW8KjK29mOe6ZS5+s5iYVT/PRlWrL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743075782; c=relaxed/simple;
	bh=VCLUDpdbtwekbJxTmpwBa3iXtRAsiaJOSlL8AoOO+oM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KpW+R+6gfgKUWG4pUo8x+q5zod4+K33RycrmedeJ5ZXqYLzRYfQlPEzk1rA7PZRPYtvzP8nWtQSZHccecK0U5rvFsEXlgJAK0Zi4bLRoGkMb6a3U6KCreNcf9p95dFODaiFE/p9yOJWKM7DIRpJKNKNrQ6gVNOouVBWBFX33r1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oE4vReb+; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743075781; x=1774611781;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VCLUDpdbtwekbJxTmpwBa3iXtRAsiaJOSlL8AoOO+oM=;
  b=oE4vReb+CCgPTXNWE49HLqYyzodPN0pVhxfrcuvdvfGH55yul2zQ63+P
   YALQYK4Whz4nZeMxq48IUEsQ8LB1lF7IkvcadV8/ZfOtc29PrhPwvt8V1
   mbn3ya+uOwN1BwOzPRzgk0txN7bGJefr6TC/RJbENBPwthqG+v1xlClBT
   SFqJnCv+WjNU7g1IYjsdsiW5H612aUlFUvunWqAmi3STido/wwvCIkcb/
   VR03HgndI882a4oV0MDyTXbuebf34IcebVwTtmHLnja7F12+JcYFyH8vP
   Tm+J7BtJTBEzSumHS8o8z01zWQWrNUcDa24ffmkgT+007WZkBToll7U5o
   w==;
X-CSE-ConnectionGUID: gDJWJ1YJSIiTsrSzoGsh3w==
X-CSE-MsgGUID: NiO5vfizT8mxarYxKEdy/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="69765449"
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; 
   d="scan'208";a="69765449"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 04:43:00 -0700
X-CSE-ConnectionGUID: 4b7knrmyQRCxDSae82fy4g==
X-CSE-MsgGUID: MbSA80+HTk6llZlVf7p1bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; 
   d="scan'208";a="126048114"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 04:42:55 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1txldM-00000006QO5-1Mcw;
	Thu, 27 Mar 2025 13:42:52 +0200
Date: Thu, 27 Mar 2025 13:42:52 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Philipp Stanner <phasta@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mark Brown <broonie@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Yang Yingliang <yangyingliang@huawei.com>,
	Zijun Hu <quic_zijuhu@quicinc.com>, Hannes Reinecke <hare@suse.de>,
	Al Viro <viro@zeniv.linux.org.uk>, Li Zetao <lizetao1@huawei.com>,
	Anuj Gupta <anuj20.g@samsung.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/2] PCI: Remove pcim_iounmap_regions()
Message-ID: <Z-U5vIbVDZLe9QnM@smile.fi.intel.com>
References: <20250327110707.20025-2-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250327110707.20025-2-phasta@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Mar 27, 2025 at 12:07:06PM +0100, Philipp Stanner wrote:
> The last remaining user of pcim_iounmap_regions() is mtip32 (in Linus's
> current master)
> 
> So we could finally remove this deprecated API. I suggest that this gets
> merged through the PCI tree.

Good god! One API less, +1 to support this move.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> (I also suggest we watch with an eagle's
> eyes for folks who want to re-add calls to that function before the next
> merge window opens).

Instead of this I suggest that PCI can take this before merge window finishes
and cooks the (second) PR with it. In such a case we wouldn't need to care,
the developers will got broken builds.

-- 
With Best Regards,
Andy Shevchenko



