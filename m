Return-Path: <linux-pci+bounces-7171-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE57D8BE508
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 16:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BAFD1C2381F
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 14:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41E915F323;
	Tue,  7 May 2024 14:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aMtXC7D8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C62158D9A;
	Tue,  7 May 2024 14:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715090475; cv=none; b=r9a4Ah+CH9GphiA4QxFUPh44AgZbSWTP9B50phhAvuDkgPilMJNr00A/zcSRk1NCLPLi1FAZZWnB4fsADi1hl+LDKwR53wCc9PD/NemndfkqOUSv+xYBn9nGn1BEZ2v5gMtG2B8uN3k18SnrS0Dq/QZmZk/LDdGhvlZLTBj+RME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715090475; c=relaxed/simple;
	bh=CBN7WFnHjroGrqYIJUTMdqFB6hXdom40CUM7ClZ40rU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RoWB2NxTOsd2eqm+/gdYPyZqO/WCHEUyenFF3X0PhK5MODW+FAKxhgEVnTcrilIuGIVrxmSwvFrp+jdP7sSSXK6eJg+oHhxwhfFZnnmM1gczUfU/GJ8OkVxIDdwqFTh3VQO2I+E8cPUQuuci+ZjTs11VVHxGha5Y2ZiGicKGC9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aMtXC7D8; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715090475; x=1746626475;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=CBN7WFnHjroGrqYIJUTMdqFB6hXdom40CUM7ClZ40rU=;
  b=aMtXC7D8zzUjSbm0iSPWejH2udij6krEBiMBDgPI3DiNHNlty548ZhwS
   os+Stx0JYXNF4p7zBSg6esVe69GwjSg5/vCc52doxvN3JPOeMqY4nwZuI
   ilRBBLN/bNJupjQTdlN/BUYdoISMT29QdXVkvSUDCZlH52J3vTea1s7wH
   tLmMnSP2GXUbLdA+YNfIwbyOnWny6zVSDtorrf4Ud+QYXvGQ/9+5ncQbj
   Hq00gZ+SVDET74ucWBP9og5h5vtS2AUhvxQF8+fkZPWxLGaPNbsv3pXrU
   5xvMSVUVbJd3VYDT1FMJSkhJyW4fUkw0IrkZ/CsRtznLrSU60OdTtRaz7
   w==;
X-CSE-ConnectionGUID: vxR/wuW1Q42vH7jaFJjm2w==
X-CSE-MsgGUID: /MwvqJh1Qdm2YHZykF/Aog==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="11008225"
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="11008225"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 07:01:07 -0700
X-CSE-ConnectionGUID: 4KJVLTPET86GrEghmEec2g==
X-CSE-MsgGUID: YUGGLjv9RQij8Y0ohHBbhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="65966854"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 07:01:05 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1s4LNM-000000053bq-3pUZ;
	Tue, 07 May 2024 17:01:00 +0300
Date: Tue, 7 May 2024 17:01:00 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Yury Norov <yury.norov@gmail.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/8] PCI: Make minimum bridge window alignment
 reference more obvious
Message-ID: <Zjo0HJDBVr-FPFfn@smile.fi.intel.com>
References: <20240507102523.57320-1-ilpo.jarvinen@linux.intel.com>
 <20240507102523.57320-8-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240507102523.57320-8-ilpo.jarvinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, May 07, 2024 at 01:25:22PM +0300, Ilpo Järvinen wrote:
> Calculations related to bridge window size contain literal 20 that is
> the minimum alignment for a bridge window. Make the code more obvious
> by converting the literal 20 to __ffs(SZ_1MB).

...

> -		align1 <<= (order + 20);
> +		align1 <<= (order + __ffs(SZ_1M));

No need for outer parentheses.

...

> +			order = __ffs(align) - __ffs(SZ_1M);

Yeah, would be nice to have something like

#define bit_distance(a, b)	(ffs(a) - fls(b))

in bitops.h as we have a few users and I have heard about one more coming,
but this is topic to another discussion. (Yuri, just FYI.)

-- 
With Best Regards,
Andy Shevchenko



