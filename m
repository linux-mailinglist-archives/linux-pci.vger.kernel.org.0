Return-Path: <linux-pci+bounces-42960-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0C8CB61A6
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 14:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F40AD3017F2E
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 13:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685C22765F8;
	Thu, 11 Dec 2025 13:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iBHhNWj9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CE12741BC
	for <linux-pci@vger.kernel.org>; Thu, 11 Dec 2025 13:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765461235; cv=none; b=O2iwHkbEIRAoMYyCP00BJD11ZjJtQ2l6pwaK621Vu3EjWLsuRNunLrqonaoEjEEEHQVecMZw1hobbR6qTK+H9mSVbFfbVVh/JtNxWhkIYr4q1+CqHC2J3yH7VkFFeMFMnE26wgFXCO+oz0VV4i3xQVWAHC2wPB9fpmKqpk1gUN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765461235; c=relaxed/simple;
	bh=LYD2rfspP100IOI672sCnFvj6NXG/HTHolcClNEFKeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y6CVGM3ebDmHpw9NhI0hVrD1lSaSgLYgMpBfiLbY67/u+VO7HUt0PWwatsjwuifzaFPJi0rMnyA+Sgay7cO8MLTi0yBnxVb3h4gh+86itRgSDm8QMkZGFu/PM4Df7xAxOZJr6kdnH6MSiy090jwpN9kK1BCwp1WGlT3qkgHeFww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iBHhNWj9; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765461234; x=1796997234;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=LYD2rfspP100IOI672sCnFvj6NXG/HTHolcClNEFKeU=;
  b=iBHhNWj91RDWlLV1ratja7qswvdzYaeUORZdu82eYHaFfdIqENK9dCpt
   f4t2guY3x7CFwFQ6rHc+VbT3C1Dpc3gXmePkPntKDetlpNMeCIAIKiMiL
   WBS0VyvGIA+NwnITHYXl+pv83/90WPfrNLFSUN0U3NuT55wPGxgDzMETf
   GKZArFsmP5+C1hryB3tetsCNCn9JT5tkBJQICZ0KS4JZ5LJJNX+ZGpSpp
   zC9MaP0TRiq4TCVijb6cIm+/6N+h7cYFSbWbmQ7CjqqYxQ8Nrm7wc5RZK
   WZ45Yg8U3HfyGl1Yke9eHD17o3TqKmVzCPs2BroKO9P2CIGhwaKVLcsqC
   Q==;
X-CSE-ConnectionGUID: APpjd+iGQ1y0A12BD5G/7g==
X-CSE-MsgGUID: 1M+e0HxZR7CinEPkwlVkrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="67490796"
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; 
   d="scan'208";a="67490796"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 05:53:54 -0800
X-CSE-ConnectionGUID: mAL+d2woSDW9yL8wnmlw6Q==
X-CSE-MsgGUID: Sp2uWTIjR4aKISyN/BCprQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; 
   d="scan'208";a="201230289"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.250])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 05:53:52 -0800
Date: Thu, 11 Dec 2025 15:53:50 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Guixin Liu <kanie@linux.alibaba.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v7 1/2] PCI: Introduce named defines for pci rom
Message-ID: <aTrM7mJV-5Xa2IbB@smile.fi.intel.com>
References: <20251211033741.53072-1-kanie@linux.alibaba.com>
 <20251211033741.53072-2-kanie@linux.alibaba.com>
 <a0f0fead-ee26-943a-53b3-873e8652811f@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a0f0fead-ee26-943a-53b3-873e8652811f@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Dec 11, 2025 at 11:33:07AM +0200, Ilpo Järvinen wrote:
> On Thu, 11 Dec 2025, Guixin Liu wrote:

...

> I know it's a bit work to rebase the second patch on top of this, but you 
> actually don't need to do it that way (you can just make changes to this 
> patch and then use git diff to produce the very same end result so you 
> don't need to resolve any rebase conflicts).

Usually it is even easier than that with help of revert and interactive rebase.
At least that's how I reshuffle changes between patches.

-- 
With Best Regards,
Andy Shevchenko



