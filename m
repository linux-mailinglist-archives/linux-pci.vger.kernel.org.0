Return-Path: <linux-pci+bounces-44477-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BE83FD11165
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 09:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A31AA30301A5
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 08:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDD1238C03;
	Mon, 12 Jan 2026 08:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AsO18baS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0421D318B95;
	Mon, 12 Jan 2026 08:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768205177; cv=none; b=bzeCYIrmc196tHgZ7jIU8zpY1AH75Dppg1MnqaYWAKUoTIlt3/fmQBGgkvHWfekO4HqGvZIlo32Ffl2gOFIIu4pk/zmn7wJG6zJL+BwoniQHIUu7CuiaXSHDwNJ26fQLd1utDDAkcNZ13KDblG7vy0QZTEe5ZZzNvqOE5czNwro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768205177; c=relaxed/simple;
	bh=dKDM2hnl0XVq59RgBlxLkUn/XciawrFMCxM73s4DuKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o/D7Sw4nvynopFCDyA3wQGvtlpaXAd2ivepE//aV9iVX5BG2aH/n/lhArw7SbPyOlToBSlq/hSKbafL6RpHX3JGcme3qA0OwqoFDuqM9+VMUOXUo9u0J2SCh/cdCJ/azRzDEjlh+r8d5BI3/HQh2UDKvNlykIavnWVaeGC4vDYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AsO18baS; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768205176; x=1799741176;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dKDM2hnl0XVq59RgBlxLkUn/XciawrFMCxM73s4DuKU=;
  b=AsO18baSDg4VE0wBhvETnAJIXApMsGgASnG8qnvb1aYoQoquTX8ddHxQ
   ugg/T/bAe28P9zAAAUifp0VhjmPJhKoHiew+U6iVoOjwTGs9M1eGtgheX
   hiiKYb5QhPpTQgXtX04dWRQyPE+6S3mgVV3ARrye2MEXjdQb9GLMtPMkb
   /m7xhI/MQRo20p8kQt1ljf55Gm3fhvs9Lb/ZzZUj/tZnJjA1nCkOZu/tN
   QHQJCpJ7tI4Fg9QIoT8RgbBgupibXNJ1zOBCRYr/CJxTxyY8gmd0CsPxq
   hqxnkJxGaTl0q8KmcUf6s/rNJoKrEbrC3xZVroMsv3LOWF+RLJEestGa3
   w==;
X-CSE-ConnectionGUID: bRWK9H+EQe2tYnapor9zoQ==
X-CSE-MsgGUID: 6G61nArVQjaK5mY6OZHArg==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="69374340"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="69374340"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 00:06:15 -0800
X-CSE-ConnectionGUID: wcYT5pKJTBWUjEItWr+8WA==
X-CSE-MsgGUID: z97h9jaiSgahVEO1BhV/PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="203657292"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.245.37])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 00:06:08 -0800
Date: Mon, 12 Jan 2026 10:06:06 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com, Rob Herring <robh@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 02/14] serdev: Add an API to find the serdev
 controller associated with the devicetree node
Message-ID: <aWSrbuqi60QQVUJC@smile.fi.intel.com>
References: <20260110-pci-m2-e-v3-0-4faee7d0d5ae@oss.qualcomm.com>
 <20260110-pci-m2-e-v3-2-4faee7d0d5ae@oss.qualcomm.com>
 <aWSnyc8Eiq56ckXB@smile.fi.intel.com>
 <xbzcmhuebjlhsn7zumudeel7dbcmrslxcrxde23rgxrmvoy73h@aj6yxcpuzh46>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xbzcmhuebjlhsn7zumudeel7dbcmrslxcrxde23rgxrmvoy73h@aj6yxcpuzh46>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jan 12, 2026 at 01:25:21PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Jan 12, 2026 at 09:50:33AM +0200, Andy Shevchenko wrote:
> > On Sat, Jan 10, 2026 at 12:26:20PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > 
> > > Add of_find_serdev_controller_by_node() API to find the serdev controller
> > > device associated with the devicetree node.
> > 
> > Why OF-centric code? No, please do it fwnode-based.
> 
> No issues for me. But the existing APIs in serdev are OF based. If uniformity is
> not needed, I can change it to a fwnode based API.

Really? serdev.h has no OF APIs.

-- 
With Best Regards,
Andy Shevchenko



