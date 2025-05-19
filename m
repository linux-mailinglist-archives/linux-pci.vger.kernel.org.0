Return-Path: <linux-pci+bounces-27965-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 883CAABBCAF
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 13:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CBF617793B
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 11:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CA1268FC8;
	Mon, 19 May 2025 11:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XfGA/LTY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1F12749FC;
	Mon, 19 May 2025 11:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747654687; cv=none; b=C+6pOdb1KWnZ+rZf/FTTAyIf/PXI0Pwhhaf3wN9bv4vGcdUOy/LrE8HL6QSrvtvaCjPca9KgQ8MDAlKNY86xBPRs9wF8E5wLSXNiJulwwFcYjHvkdSTj6V8Hcr08TmCgVrx6vScimYUNupeWRfxoshd6qGRi+bKwxFv4yqTDjtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747654687; c=relaxed/simple;
	bh=K2WXDcCjenQ4M990QkeKh890F18UFEKYLYMgiEKPM/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQg4RbA5r5QAz0vjojEyBxdMC7NfMX7f4v45AcLKm8uoB/VuMHN5uEb5Xr0RTTnnWeZmCGJPfCgppwXVi40t1dq0LBxaTfkANsiD44HS5TJ2InQlAOJSa+XG9KlPrlTlblaUi18gigpDfLYidUts5oQ8u1q+DPb0gRB557u/GNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XfGA/LTY; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747654685; x=1779190685;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K2WXDcCjenQ4M990QkeKh890F18UFEKYLYMgiEKPM/k=;
  b=XfGA/LTYcOK14l0K5orSHdtRpXKBj+D1qSYCa6DNDtwaR/1h6fH7FZQa
   gJc+Q20FofX0bE3u1/xYu496lLb25dO4K7LTXwgACTLoFGD3FdsdI7Gzm
   /4ZUoBMJ/o+6xptvU3hRloOuKJ59V2NhLj+plfBnY18LLsNugJ8LwSv0u
   sXvmKs3xeExk5Dn5jtkxoCL3FiGxAkACCAJ8LH6kGEzhIIjTs0aJC+WRZ
   ilgiTapezd1eHuB+4XLBS77XtrTwVF5fzoQw5EIRIy0l0Vpyw8XMCvkrl
   vv1kstw5vc3vgq1KwfB+447K5L0dKwRqboyg02fw0/0KvV60rGX7cqzUT
   g==;
X-CSE-ConnectionGUID: u3js8+AdTCa9IfAhU+Uncg==
X-CSE-MsgGUID: Us4/JW0CSw+HeNa+offevg==
X-IronPort-AV: E=McAfee;i="6700,10204,11437"; a="37167822"
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="37167822"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 04:38:04 -0700
X-CSE-ConnectionGUID: 4Kh95vYaQXeq6dcKEkRh2g==
X-CSE-MsgGUID: jI/DbYysTyu4oJvvd/4FYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="144108373"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 04:38:02 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uGyog-000000031Hx-0sz3;
	Mon, 19 May 2025 14:37:58 +0300
Date: Mon, 19 May 2025 14:37:57 +0300
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
Subject: Re: [PATCH v3 2/6] Documentation/driver-api: Update
 pcim_enable_device()
Message-ID: <aCsYFVjZrARrzt2i@smile.fi.intel.com>
References: <20250519112959.25487-2-phasta@kernel.org>
 <20250519112959.25487-4-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519112959.25487-4-phasta@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, May 19, 2025 at 01:29:56PM +0200, Philipp Stanner wrote:
> pcim_enable_device() is not related anymore to switching the mode of
> operation of any functions. It merely sets up a devres callback for
> automatically disabling the PCI device on driver detach.
> 
> Adjust the function's documentation.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



