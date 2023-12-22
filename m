Return-Path: <linux-pci+bounces-1304-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD2D81CAC5
	for <lists+linux-pci@lfdr.de>; Fri, 22 Dec 2023 14:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7AC41C20995
	for <lists+linux-pci@lfdr.de>; Fri, 22 Dec 2023 13:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891E418B00;
	Fri, 22 Dec 2023 13:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QGr5HO6W"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9691A707;
	Fri, 22 Dec 2023 13:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703252076; x=1734788076;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=iFFLsoxvmNfG3KJ8KzOw6UsU8Flpb7G6GpT6JO9Kf2Y=;
  b=QGr5HO6WqFLOixAxXYNs6FPXeg1QwInNUvop/kNDlJIxq9jjFLH6/0tt
   A7GOAp8gDcHLA19GrFRExG4A9/wwru1p0qleIzyquLcEkMe5RnobNj33l
   nqJ+wttK0k87qX7Hq5zTsLZZbvjaFpIFwQcEeniqc1VSdgY6tNhagqX8Q
   AiN2baFlCcDgqvxp8ew5M30gjjrRmwvQ273WY655fapAOZRGcliaJWE0f
   wgEZeoYMq7YsrFD9Gh+FvhHlSg4B9z34DHUyJ40ky8Wx9HtFSlD/byMUl
   JWG3qcj0Ez6NY3m9xCZvzCJyGxol1/XSEkpVfw7bj4uXc7LwwrTANcLon
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="2961789"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="2961789"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 05:34:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="805943900"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="805943900"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 05:34:27 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rGffU-00000008A4a-2XgD;
	Fri, 22 Dec 2023 15:34:24 +0200
Date: Fri, 22 Dec 2023 15:34:24 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Igor Mammedov <imammedo@redhat.com>, Lukas Wunner <lukas@wunner.de>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] resource: Handle simple alignment inside
 __find_empty_resource_slot()
Message-ID: <ZYWQYNlYynPRdecK@smile.fi.intel.com>
References: <20231222122901.49538-1-ilpo.jarvinen@linux.intel.com>
 <20231222122901.49538-6-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231222122901.49538-6-ilpo.jarvinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Dec 22, 2023 at 02:28:59PM +0200, Ilpo Järvinen wrote:
> allocate_resource() accepts alignf callback to perform custom alignment

s/alignf callback/->alignf() callback/

?

> beyond constraint->align. If alignf is NULL, simple_align_resource() is
> used which only returns avail->start (no change).
> 
> Using avail->start directly is natural and can be done with a
> conditional in __find_empty_resource_slot() instead which avoids
> unnecessarily using callback. It makes the code inside
> __find_empty_resource_slot() more obvious and removes the need for the
> caller to provide constraint->alignf unnecessarily.
> 
> This is preparation for exporting find_empty_resource_slot().

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

...

>  		if (avail.start >= tmp.start) {
>  			alloc.flags = avail.flags;
> -			alloc.start = constraint->alignf(constraint->alignf_data, &avail,
> -					size, constraint->align);
> +			if (alignf) {
> +				alloc.start = alignf(constraint->alignf_data,

> +						     &avail, size,
> +						     constraint->align);

Maybe one line? It used to be a longer line in the old code.

> +			} else {
> +				alloc.start = avail.start;
> +			}

-- 
With Best Regards,
Andy Shevchenko



