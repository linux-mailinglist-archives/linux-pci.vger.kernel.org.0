Return-Path: <linux-pci+bounces-27967-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1111ABBCC0
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 13:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05B2F1666AE
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 11:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D561A2749F2;
	Mon, 19 May 2025 11:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eFUpHu8l"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E934C92;
	Mon, 19 May 2025 11:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747654769; cv=none; b=EJZQj2+pKmg/w+jyuMgSWTr5mD/wnnun2Ah/4jCf9vR1pgex3sCtYtpdG4lbGUX4hES038AV+Ilw2ijun3/xCHYUoski1k7H+gc8BRhcXsNPK6ZLRce+z/MkOVA3FYSXtVghs0WECpQ3B88fmrS8vAMX4JJmzkCOQs8ob03lrNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747654769; c=relaxed/simple;
	bh=Nm8ntM84CxS98HCEArpFwYHrOEC9x+FN+Hfat16T864=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oIzFEb4r0vHbMxO2aSj8G2SOSceQ+M8oiw1cr2WfBzNFVWi8+/zpSoN1vcrKZhhTXpwLJlqYLVZjqOrySPopYAzyBLdGYCj2uHW2qD11AalTHdGvpa10Ypadqoa79xTTmLqXel/Gqt3d2E53WIeOsNdSr/gJ+R/GThfuTWukNPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eFUpHu8l; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747654768; x=1779190768;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Nm8ntM84CxS98HCEArpFwYHrOEC9x+FN+Hfat16T864=;
  b=eFUpHu8lOxH6yu8QUVsX6u14GSoOtHEc8xu5iP6Wr8upsRoETW63WBBC
   4ZL3Ag0hHs1/+4PnoBI2NT6C2Ik1Jt4NPIfqYLCyuGEa2M2jDYL8XIH18
   DHoXwrwzZQx3MH+qNk/25L2H+4zXdAhsxjErTZOHunGHK7Z1Wegn8kIES
   NaH7zc3ee3+E9UFSpDh3EHquu6UxpsqkAZ6vhXlvb19DOhA9j3RdhoE9l
   pLHGPr03VhFNMqYFO7ys81v7cZ56/fISIvBdDAIc0H/Rh5oivhU2XxOqD
   LIfFos2r2D9+sbeIrhjMrKQ9Vusrtxf47i0NwcnLvgcCejs4xoN3y6mgZ
   g==;
X-CSE-ConnectionGUID: VcW36jOLQ5eWJYC+jlTItA==
X-CSE-MsgGUID: wPDU5AnZScyVgBUr00lf3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11437"; a="53348251"
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="53348251"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 04:39:28 -0700
X-CSE-ConnectionGUID: 46SeiPiIRFKHjEiBh9gSvg==
X-CSE-MsgGUID: vmo9kMy6Q5K9zfvcWYpCPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="139388788"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 04:39:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uGyq1-000000031J0-3vAn;
	Mon, 19 May 2025 14:39:21 +0300
Date: Mon, 19 May 2025 14:39:21 +0300
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
Subject: Re: [PATCH v3 4/6] PCI: Remove request_flags relict from devres
Message-ID: <aCsYaRE65M1H1jiy@smile.fi.intel.com>
References: <20250519112959.25487-2-phasta@kernel.org>
 <20250519112959.25487-6-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519112959.25487-6-phasta@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, May 19, 2025 at 01:29:58PM +0200, Philipp Stanner wrote:
> pcim_request_region_exclusive(), the only user in PCI devres that needed
> exclusive region requests, has been removed.
> 
> All features related to exclusive requests can, therefore, be removed,
> too. Remove them.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



