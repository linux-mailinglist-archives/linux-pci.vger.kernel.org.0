Return-Path: <linux-pci+bounces-1305-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9680081CAC7
	for <lists+linux-pci@lfdr.de>; Fri, 22 Dec 2023 14:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A9382825E3
	for <lists+linux-pci@lfdr.de>; Fri, 22 Dec 2023 13:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3737A18B00;
	Fri, 22 Dec 2023 13:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HT+c67PR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5310199A7;
	Fri, 22 Dec 2023 13:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703252164; x=1734788164;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=zWZ1aRWrVqsyieeFsQyCtW19c3VttRD8ZySgrG40IGA=;
  b=HT+c67PRFoTeqmNvTwGtprBGAt8Hmlkr3yuxxQyOTfcKSa/1Dph/Mqs1
   XA2yI5/uWVXv9Jb/qzXPV+M0u+zY7/6mt16esbpEqbzPLoHlvdcopTH28
   c5ofU8FagBT4Sz/iBLH6Oq7I2UbhZcEy8ZmX+M2vhZYJ5S4bwtKPhTtWL
   j+vfEGmBe20ULM2C5FlLMrNXCfUagZFOFPh8c0/v7pE6O8+TKdWp4vjMk
   u/7fjiQJbeFlAzVnFYajY98Cps9UArTbMTbp5+UB/pW6xBg+WPAWSNJrz
   v3Lwcax8ax+DcT3L2y5WNJtFqAxBcxwDvOACmHit75v+oXlu95faW0l18
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="17686354"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="17686354"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 05:36:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="1108471362"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="1108471362"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 05:35:59 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rGfgy-00000008A5W-3w7x;
	Fri, 22 Dec 2023 15:35:56 +0200
Date: Fri, 22 Dec 2023 15:35:56 +0200
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
Subject: Re: [PATCH 6/7] resource: Export find_empty_resource_slot()
Message-ID: <ZYWQvOSqXrp63BV5@smile.fi.intel.com>
References: <20231222122901.49538-1-ilpo.jarvinen@linux.intel.com>
 <20231222122901.49538-7-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231222122901.49538-7-ilpo.jarvinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Dec 22, 2023 at 02:29:00PM +0200, Ilpo Järvinen wrote:
> PCI bridge window logic needs to find out in advance to the actual
> allocation if there is an empty slot big enough to fit the window.
> 
> Export find_empty_resource_slot() for the purpose. Also move the struct
> resource_constraint into generic header to be able to use the new
> interface.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



