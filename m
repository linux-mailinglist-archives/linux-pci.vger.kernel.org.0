Return-Path: <linux-pci+bounces-4853-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 775C087CF21
	for <lists+linux-pci@lfdr.de>; Fri, 15 Mar 2024 15:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF852283E40
	for <lists+linux-pci@lfdr.de>; Fri, 15 Mar 2024 14:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80F425750;
	Fri, 15 Mar 2024 14:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e1fOkATB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF2037155;
	Fri, 15 Mar 2024 14:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710513580; cv=none; b=rzXbM0dZMDN3T0E1E2JyGLkvSmADEYgw3u66EYFwkxH7YHgsvPvM8ssG24gM/lY6UenYw24IysXCHIQRW77M5+78cVgyDWP/nfgZ1PFAIp1UtEjgpLVJR6OHR8SeiAhfIpZWjq9/ZqyUKRbYFH8k+3qjt2Z5/6SR2n4Fmh3MC1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710513580; c=relaxed/simple;
	bh=aiAi4ls92WaX60pEZcqvPwA308DhNMckx9sVb6cDSIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZKSpuAlxSDdl2DTWA5XI4TbNvGz46JL+ihWGbBl2o/ilbl51gGSSR4YfCTLJXiNz+Md8RZb7qrLwaPMindnl8yUC/U3wrqZYhRvT0KQkQvugisbTnMrFaR8/I/sHTnbup2yGtjhav1FvmNbM7Db1VtTzLfCGsjhNT0fzsffEWHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e1fOkATB; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710513579; x=1742049579;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=aiAi4ls92WaX60pEZcqvPwA308DhNMckx9sVb6cDSIg=;
  b=e1fOkATBgvJWmBx6YU7fw+1lTivfNgRcYEkftv7dVRvYSJSZtq5xnvVh
   /DmBL9Q9qku5wc62qzSgj/L0Yqp5WaJPFFJ+4cVnSoLgyC3XAOw+/LSIH
   PZBSwSdBnOsSz3K+cWUUknwEUKmayTeGntaI7GiqDibHNZ32HNBmoshBU
   7n3drwONECDwRC9mPdp54AoeQ4GB+v3IjvjDHDj832B7a7O51WEgzHWJx
   vPa3Sf4JIh/Zpnh8UoMKs9zPA3Q0GY3z2KJTAePcCvWSNdwjLinf27+dN
   7hSlcEUycNsSu5phr5Pt+PPgcKVBc077dlLXeO/FwbABwPqPFFWMS4u+M
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="16031210"
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="16031210"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 07:39:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="914498869"
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="914498869"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 07:39:35 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rl8ia-0000000DBh3-3W43;
	Fri, 15 Mar 2024 16:39:32 +0200
Date: Fri, 15 Mar 2024 16:39:32 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Igor Mammedov <imammedo@redhat.com>, Lukas Wunner <lukas@wunner.de>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/7] PCI: Solve two bridge window sizing issues
Message-ID: <ZfRdpHMZjiTnpgGn@smile.fi.intel.com>
References: <20231228165707.3447-1-ilpo.jarvinen@linux.intel.com>
 <453df04f-45ee-7619-1731-511b9cac26f4@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <453df04f-45ee-7619-1731-511b9cac26f4@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Mar 15, 2024 at 12:33:43PM +0200, Ilpo Järvinen wrote:
> On Thu, 28 Dec 2023, Ilpo Järvinen wrote:

...

> (If needed, I can send v3 with that tag).

Dunno what's Bjorn's workflow, but `b4 am` has parameter to accept tags given
against a cover letter and propagate them to all patches in the series. I.o.w.
no need to send a new version in such cases.

-- 
With Best Regards,
Andy Shevchenko



