Return-Path: <linux-pci+bounces-27517-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53FC6AB1A54
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 18:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA08A7BC84D
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 16:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AB1212B05;
	Fri,  9 May 2025 16:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="npDu+qte"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43A02356D9;
	Fri,  9 May 2025 16:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746807667; cv=none; b=E9O4kj8zOgTbqFndumuOWNk3gqsI04zaNP4ISzAksQcmtGh4rlgFbp/mhgmVAQYvanZFgUr4y6Ld+rehQeiwpinpJUnsOzAVBQ+rqQPlqIanD4tHopAYGkzB8+fz+LC8861+GV7jq4o8IR0mFiOCsdx1hezmDby4PsEbMsjC+4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746807667; c=relaxed/simple;
	bh=dL7KD/TlJeCv74sI23DpTJADqUEeXDYITiCPLXNsLjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=omV2wCcacX+qtFOHKTsoBW+tFK0KWPHO4iX/PT0U1kh0bdCRh+VYv6OmT9UCyEPPxVSJpsoa1XwC7XNbY9hYC/WpO/tJQ92HFKUGzyAMADbhTNTXrtBkDjQ88GAy+xeTXK5VyigR21qLjhgQwW+DePIBWKZ/FFSX+MSgYExs0oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=npDu+qte; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746807666; x=1778343666;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dL7KD/TlJeCv74sI23DpTJADqUEeXDYITiCPLXNsLjY=;
  b=npDu+qtevgylzG1Rk+3h0Bmq8a1+Cy8UhMcXq5KsfHXTpV3QTCIjvsTb
   59fBwn6v4FnGmOjDA4PIGU2JkHwjRiRjb6cwcFlSSCBsDLmgRQsZE8yz/
   RyjDpzc8zIITSb6LImwSXb4HqDY7Y3Xi8CGhEvRM/I3R4c8KhDwxmH9I6
   UJQ5ajGEd8jGPUeQjqxX/1ngHsDDcgOlnliJbGvkwvrL+x1K8CUK98M4G
   YbWvRuMapi/o6F2TKVQ9CzF5nySRfXDMBTXIqrmqx8tQRGAHTtT8AfueY
   Q+iy2GC4qcfXNswYhV80AhtJgMQdqC0o6d+dfQysbxJviawg932MVcrfa
   w==;
X-CSE-ConnectionGUID: Gyl0z5usTnybaw9ZY1XWDw==
X-CSE-MsgGUID: jbZO14siRFODurXvRM4vjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="48339790"
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="48339790"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 09:21:06 -0700
X-CSE-ConnectionGUID: zXuMQpltQAKA3+Ng8M/phg==
X-CSE-MsgGUID: dUIDlxakSoyMHg85kq6Wrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="140724147"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 09:21:02 -0700
Date: Fri, 9 May 2025 19:20:59 +0300
From: Raag Jadav <raag.jadav@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	x86 Maintainers <x86@kernel.org>, intel-xe@lists.freedesktop.org,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: Re: [PATCH v1 2/3] PM: sleep: Introduce pm_suspend_in_progress()
Message-ID: <aB4ra4BsLu5Rv5ea@black.fi.intel.com>
References: <5903743.DvuYhMxLoT@rjwysocki.net>
 <2020901.PYKUYFuaPT@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2020901.PYKUYFuaPT@rjwysocki.net>

On Fri, May 09, 2025 at 03:02:27PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Introduce pm_suspend_in_progress() to be used for checking if a system-
> wide suspend or resume transition is in progress, instead of comparing
> pm_suspend_target_state directly to PM_SUSPEND_ON, and use it where
> applicable.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Raag Jadav <raag.jadav@intel.com>

