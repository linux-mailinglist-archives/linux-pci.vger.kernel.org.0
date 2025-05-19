Return-Path: <linux-pci+bounces-27966-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69575ABBCB1
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 13:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF5241893D97
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 11:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F91275103;
	Mon, 19 May 2025 11:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NAu76rHm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB85245037;
	Mon, 19 May 2025 11:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747654715; cv=none; b=hYslOJ1NkIImqO0xaNAFb+e0jQ+C1bcOYUKzsgjcbr/KrPGCafwntLDI6SWe8QK3wbF5ajjsJcGRmsB7apL5165inWjTUMfeZbZkBJHRqmYxlv0NQXffBWnlGy9Elgy/N//VqZ+w8402d2Dlwi/NCTISLSG1UZ/qeJiJSk/VKz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747654715; c=relaxed/simple;
	bh=o/lm+VZOypRUlEm/5/CgUttywrWrG+hYImr/DbWxDQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fQx4myObieg3Bhy73Lhq0kNaVQM71omiMIzOG0HdDURuZHUiYQ5uzwNOa0qGKCCc9ZHEmZCc42dEV/02KauLU0L4emFKjEpjrkFF/1vr0I3L0tMh7C3GwMNUyRwUkeIAyeZoLOxB6MBg+j3rXen6vccpJo9R23EcrpFCvxQUcrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NAu76rHm; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747654714; x=1779190714;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o/lm+VZOypRUlEm/5/CgUttywrWrG+hYImr/DbWxDQM=;
  b=NAu76rHm11ZoN/qa9heTyq8EBew2yrMhipfHPWgGPqPJn7gOB7IqBxgZ
   FyVvDlOWrjWmaECUXsvrGfavX8UUiutH0Qwq3bnCOovSQ83xCrvWtO1Dp
   CGcR4m3baD6aCVU+Gi+LuayXcWxa5AipqwMe99tBwQZ3Q0g44iHrdRIwH
   ypoZEijhdKGPYkkcw7L8NGysPOPuPRjMPVvAoSRNYHZXqyhIb0mp9M7W1
   A7BIGskGkeDipusuHV6z/B1QbCVixUMvistez7vIdVzrxfvV7Z4cmFgZ6
   Ee8kzVhXrOvvM8hI8Q+IgjfVVFBcP1wbMq7IqnaUaUW39phfln32FzOOg
   w==;
X-CSE-ConnectionGUID: 9+p+xgzDRVqemJdWXyl5mQ==
X-CSE-MsgGUID: rEak/GP1S4uBB4lrvfzfcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11437"; a="49479940"
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="49479940"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 04:38:33 -0700
X-CSE-ConnectionGUID: 3nYxEmY7RQChBg5qPRVnwA==
X-CSE-MsgGUID: Sik00Sy3QvS6PUdMoJQ5hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="144222927"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 04:38:30 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uGyp9-000000031IF-1OwW;
	Mon, 19 May 2025 14:38:27 +0300
Date: Mon, 19 May 2025 14:38:27 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Philipp Stanner <phasta@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas <bhelgaas@google.com>,
	Mark Brown <broonie@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Yang Yingliang <yangyingliang@huawei.com>,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 0/6]
Message-ID: <aCsYMzWrV3bGpMWb@smile.fi.intel.com>
References: <20250519112959.25487-2-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519112959.25487-2-phasta@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, May 19, 2025 at 01:29:54PM +0200, Philipp Stanner wrote:

Just for your info: Subject is clean. Forgot?

-- 
With Best Regards,
Andy Shevchenko



