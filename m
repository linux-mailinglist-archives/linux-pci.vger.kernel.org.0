Return-Path: <linux-pci+bounces-27799-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C58AB8741
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 15:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8CB24E5781
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 13:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B166B296D3B;
	Thu, 15 May 2025 13:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="egglMXRD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF8220E002;
	Thu, 15 May 2025 13:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747314177; cv=none; b=UwkPtwZn47tQgcP3a2ezxDqA8AXhf5teKySlIo+4h+Ci0KOeFxUtFC+8h9Jlwj92sACqeCpoQltxwTqMxG7YwlpYZ6XtWGvWHzf48ekJI/HQEhg/nKwmD01HlYCcAL6Qc6lEt+prz094dnmpppBtcxOzuJjb6wIfrEmIrZ22cic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747314177; c=relaxed/simple;
	bh=5DNzLBseax3dtAMizakBt5fSjkXj0bGw45fhxEH1+3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hcKxKpBX1sq/r8SLHFPP2+5bvu+QEawG5AZQnnbUS4uRdriIIX+MtZP02oGdbeIsdERwiAsIjlb/cIiVfy/0Ce/h3oeXEuZOkm1pfYh3TnswrlbOEcXb6/XLW5qmFW8mTWh81hzsiN4YiFQG5rBSu/n0spfKO16Mb4oKfFHxFng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=egglMXRD; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747314176; x=1778850176;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5DNzLBseax3dtAMizakBt5fSjkXj0bGw45fhxEH1+3g=;
  b=egglMXRDSfbhCX0dO1cjctISts0UXHSa0Z7hipsX7qM24rdLI+CQc5jt
   7+DemdWw86jCr63LnVgC5aJaf36teywg3scpK7M92AbB/J3155eu/6J/r
   QwEKWM4pIWagp6mER3S9PZT0Juk0Rja4uidd9VUo1SvtjN1UOTKZn6fTM
   lQyOd/Q/c9VLHlZt6tb0agYX8LPwuEBMdSsozOBeJ/BLYyVk51ujRPWeP
   OXA1PFdDkHArL2X+OxilqDNaweILjM0jRN7lgNKkj3yHWbWbG1B5Dv7kr
   kWSCLiuk1CpvhaLSorEm4jeigqrnPGNDRJwmSHVZ9o+Ve6EjUITclAOnP
   g==;
X-CSE-ConnectionGUID: rYZVf8fZQ8OzS+tt3Vd7vw==
X-CSE-MsgGUID: Ekl7yNOYSv6A8xIb0rBQAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="48364748"
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; 
   d="scan'208";a="48364748"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 06:02:55 -0700
X-CSE-ConnectionGUID: 6pivCcEDQSCTSo5sm2c16Q==
X-CSE-MsgGUID: FWV2RKM7TiSjEXz2MNBjNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; 
   d="scan'208";a="175476541"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 06:02:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uFYEb-00000001qjz-3at8;
	Thu, 15 May 2025 16:02:49 +0300
Date: Thu, 15 May 2025 16:02:49 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Philipp Stanner <phasta@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas <bhelgaas@google.com>,
	Mark Brown <broonie@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	Yang Yingliang <yangyingliang@huawei.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 6/7] PCI: Remove unnecessary prototype from pci.h
Message-ID: <aCXl-U5Dsv3hdCWa@smile.fi.intel.com>
References: <20250515124604.184313-2-phasta@kernel.org>
 <20250515124604.184313-8-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515124604.184313-8-phasta@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, May 15, 2025 at 02:46:04PM +0200, Philipp Stanner wrote:
> pcim_intx() once was an internal PCI function, but since then has been
> published and is used by drivers, and, therefore, available in
> include/linux/pci.h. The function is not used within PCI anymore.
> 
> Remove pcim_intx()'s prototype from drivers/pci/pci.h

Can this be moved up in the series? Or is there other dependencies? I.o.w. this
looks like a leftover from something of the previous work.

-- 
With Best Regards,
Andy Shevchenko



