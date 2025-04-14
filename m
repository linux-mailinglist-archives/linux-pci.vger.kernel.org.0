Return-Path: <linux-pci+bounces-25804-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC6AA87D05
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 12:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41BCA188C38F
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 10:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC1126B0A0;
	Mon, 14 Apr 2025 10:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K3cfMpvF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9A426B08A;
	Mon, 14 Apr 2025 10:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744625147; cv=none; b=GcvRmY9Y1LuoXoOFR9uY6eeZeiDun+DP08BDv3oX5YKkEOjHqGdVs6OhpaPQ1A1/hSUXWOUdn5rhcUKmyaTdJa3OKJo+DOSrrpwG05ReNv6JhdfWIei7Ci2n3teFO+dEgVGSBMHToaPZrHi7oTH055O05RxKvNbhZgf/hLd6dYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744625147; c=relaxed/simple;
	bh=F1AlJoHjOHPtKPHcI1/WRpTs95CH1wV1k4+PVrQlr2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FgJ/T5F+7eHOSUMusKGXEI2Z3sO6XIAAEbPNPdtY6q9pThdBcpV/ZmgEt7H9OiKlpVD+npqgHavZJQ55eJZYtYfm2e4Iah7Jf9/CLaZbsVqDN7jZlid5DQtHublJo+TeBrLegP3OSAEACJ0s4FNUVMzpL1qLp63C0n29nYMwK5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K3cfMpvF; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744625145; x=1776161145;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F1AlJoHjOHPtKPHcI1/WRpTs95CH1wV1k4+PVrQlr2o=;
  b=K3cfMpvFcKHjO8mdAAcugaYkeLpPKbZ8jhr2Cf/CXgmwWcs9XeBLgONp
   0A8VUGhnWkePA8t6TI2hdXE77d2K4q2rlWw5fmjMt1RmjzNsr0t0Z9Pr7
   BgsorqJHn9KCy56ohDWCVYLJarPK5YWqDkYPE+s5+xh6G9F49z/+zhfvZ
   uqY11kHPlipKL1M8gd1zD7RSZw+yjheF04efqsWdgo0kSkrKN1gINYUPx
   FPo2NnP4PWMg+qaZAp2sfFFXFI98497iQRVrtj7Bmoua5MxFM+AMEPTVD
   Ob17UP304KDzCWzb+byHfumN0kmjJdgTplOenTZTVBDg/UF+PeRzYcQC5
   w==;
X-CSE-ConnectionGUID: e7DNuFipSv6BkpQXkKM35g==
X-CSE-MsgGUID: bV5/Xli9TVO1N8DFzsEAlA==
X-IronPort-AV: E=McAfee;i="6700,10204,11402"; a="45973024"
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="45973024"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 03:05:45 -0700
X-CSE-ConnectionGUID: SfouxUGlT2SZEPwGuXFLfw==
X-CSE-MsgGUID: /VoKRjlJQMqY1B8ddPrbmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="152957247"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 03:05:43 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1u4Gh9-0000000CCb3-3buo;
	Mon, 14 Apr 2025 13:05:39 +0300
Date: Mon, 14 Apr 2025 13:05:39 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v1 1/1] x86/PCI: Drop 'pci' suffix from intel_mid_pci.c
Message-ID: <Z_zd88_-lqFFvtnP@smile.fi.intel.com>
References: <20250407070321.3761063-1-andriy.shevchenko@linux.intel.com>
 <Z_QOAPXsacHI6TZz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_QOAPXsacHI6TZz@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Apr 07, 2025 at 07:40:16PM +0200, Ingo Molnar wrote:
> 
> * Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > CE4100 PCI specific code has no 'pci' suffix in the filename,
> > intel_mid_pci.c is the only one that duplicates the folder
> > name in its filename, drop that redundancy.
> > 
> > While at it, group the respective modules in the Makefile.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  MAINTAINERS                                   | 2 +-
> >  arch/x86/pci/Makefile                         | 6 +++---
> >  arch/x86/pci/{intel_mid_pci.c => intel_mid.c} | 0
> >  3 files changed, 4 insertions(+), 4 deletions(-)
> >  rename arch/x86/pci/{intel_mid_pci.c => intel_mid.c} (100%)
> 
> Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks!
I believe it's Bjorn who is going to apply?

-- 
With Best Regards,
Andy Shevchenko



