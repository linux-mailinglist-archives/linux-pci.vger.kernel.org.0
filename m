Return-Path: <linux-pci+bounces-1303-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2F981CABE
	for <lists+linux-pci@lfdr.de>; Fri, 22 Dec 2023 14:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DBD61C218AA
	for <lists+linux-pci@lfdr.de>; Fri, 22 Dec 2023 13:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE09019465;
	Fri, 22 Dec 2023 13:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bMMobn4V"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A832E199D1;
	Fri, 22 Dec 2023 13:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703251825; x=1734787825;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=66jG3KLM63fqdjOBuHt9UBQww/p3VqmTjIk5EsQrJ8Q=;
  b=bMMobn4VOOAp2Gk1+U9V9HlCoQb2gWiPvtjy7pyT+mVQiktD9RE5UaYZ
   6lTH/qfouPRxh+9PdrhyJ353x3vdefcDSnF3HyD0cVF5ZXhADWtxOF0QE
   ieRuN3kTx6uWCCWX4hea/9PBpFkKsDxR9L/lRT8sUT9SNmBK/X7vffsKg
   erRJXiHtPqDAQ6l22J0HxmP2mCpINPBMBWvRYX+4MzQt4KohZ3v3EW2Px
   K3/ELX6Za1c+gTwYnVHTaHLlBmyMiDjsdtb2fNENrJCZHubUDgKqrZyV2
   ylq3+AenZWYsFvVwYRSvEKHmL6AotlzezEZ3jrGjJ3fe8Bmld7ZI1fzi3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="2961458"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="2961458"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 05:30:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="805943677"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="805943677"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 05:30:20 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rGfbV-00000008A1N-0Bci;
	Fri, 22 Dec 2023 15:30:17 +0200
Date: Fri, 22 Dec 2023 15:30:16 +0200
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
Subject: Re: [PATCH 4/7] resource: Use typedef for alignf callback
Message-ID: <ZYWPaGc4rjymcm75@smile.fi.intel.com>
References: <20231222122901.49538-1-ilpo.jarvinen@linux.intel.com>
 <20231222122901.49538-5-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231222122901.49538-5-ilpo.jarvinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Dec 22, 2023 at 02:28:58PM +0200, Ilpo Järvinen wrote:
> To make it simpler to declare resource constraint alignf callbacks, add
> typedef for it and document it.

Suggested-by?

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

...

> +/**
> + * resource_alignf - Resource alignment callback
> + * @data:	Private data used by the callback
> + * @res:	Resource candidate range (an empty resource slot)
> + * @size:	The minimum size of the empty slot
> + * @align:	Alignment from the constraints
> + *
> + * Callback allows calculating resource placement and alignment beyond min,
> + * max, and align fields in the struct resource_constraint.
> + *
> + * Return: Start address for the resource.
> + */
> +typedef resource_size_t (*resource_alignf)(void *data,
> +					   const struct resource *res,
> +					   resource_size_t size,
> +					   resource_size_t align);

Never saw typedef kernel-doc before, so hopefully this will be rendered
just fine.

-- 
With Best Regards,
Andy Shevchenko



