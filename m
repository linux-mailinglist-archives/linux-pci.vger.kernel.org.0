Return-Path: <linux-pci+bounces-44474-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6D5D10FF7
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 08:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEB0D3032112
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 07:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C761339B30;
	Mon, 12 Jan 2026 07:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DChkeAXD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB1D339878;
	Mon, 12 Jan 2026 07:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768204577; cv=none; b=HXpOYpTgmD2VPJqcKcDIJEizLd4px8x51/xfOJI80LoQkmfDFGHEWRICjxqhQhMYoNh6dACKCOj7uw24QsLXtY2mvOWD7Pr/rBPalE8aUxe721hYc/2V89ROVmKF/szEeIDOllswsYKMP0RrBGhYiyIYWpefXA68t2oKZTmdyaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768204577; c=relaxed/simple;
	bh=aucdtIlfUEGPYC2FoDFyRT9nZudmUN6PptQvFCOe7/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EVgQK+wIPVn+bdH+GUC/VzXTd6M1dFF0XlxX0i12ITD7SEkcF+lSF38TiVrsTlxunY7Me/jkiwhEevXoEgPnChCVz91ppD4G3u/9wd2JOkMj/df26P8GkTaa41Q4NmxuoUPf9XUeob2LwfXJh+qVMnxMw0R2if0v6GCFUwafgM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DChkeAXD; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768204577; x=1799740577;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aucdtIlfUEGPYC2FoDFyRT9nZudmUN6PptQvFCOe7/s=;
  b=DChkeAXDI4gwl9IF5eCIlmS+ksbPXSnZmW5NttFGUqiyhCIdH5Te/iiI
   t3GR5ttMEfKuvxnHws+mfw8oDr/WdAPk7JqQyj8VmfSMI2fN254FkdfR4
   2G7gVa2eazj7Q45IjwzSmcrrF9b4L5LbiROg5vYjufORW/3jjqy5zMzpY
   87ZemzfcVp8LphiB9XOyLWvk9uTldzFsEtb8wXfS/Zl+39OEgf+1H2djX
   IraY572x5EaVminMefPx8PLo5TECCpdc0hC7q0gA2NxQ4kJ0hjKSepyGP
   F2/hkj5O9u5c1fP9RXI7TVvxGQcc4IrCwJpn2L08bXpBpt2QuviOCPDz2
   w==;
X-CSE-ConnectionGUID: eb8KIlGyTC24tKfJsiYZdA==
X-CSE-MsgGUID: +W32EXieQmGxa/ypDYpe3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="80195917"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="80195917"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 23:56:16 -0800
X-CSE-ConnectionGUID: 3Y+NqyHcSW2DmuxXKsVr3w==
X-CSE-MsgGUID: vYYtp5HLTaGm6EZYZ0y/JA==
X-ExtLoop1: 1
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.245.37])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 23:56:09 -0800
Date: Mon, 12 Jan 2026 09:56:06 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Rob Herring <robh@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
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
	linux-acpi@vger.kernel.org, Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: Re: [PATCH v3 03/14] software node: Implement device_get_match_data
 fwnode callback
Message-ID: <aWSpFk9z0zpyKjr6@smile.fi.intel.com>
References: <20260110-pci-m2-e-v3-0-4faee7d0d5ae@oss.qualcomm.com>
 <20260110-pci-m2-e-v3-3-4faee7d0d5ae@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260110-pci-m2-e-v3-3-4faee7d0d5ae@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Jan 10, 2026 at 12:26:21PM +0530, Manivannan Sadhasivam via B4 Relay wrote:

> Because the software node backend of the fwnode API framework lacks an
> implementation for the .device_get_match_data function callback.

Maybe this is done on purpose. Have you thought about this aspect?

> This makes it difficult to use(and/or test) a few drivers that originates
> from DT world on the non-DT platform.

How difficult? DSA implementation went to the way of taking DT overlay
approach. Why that one can't be applied here?

> Implement the .device_get_match_data fwnode callback, which helps to keep
> the three backends of the fwnode API aligned as much as possible. This is
> also a fundamental step to make a few drivers OF-independent truely
> possible.
> 
> Device drivers or platform setup codes are expected to provide a software
> node string property, named as "compatible". At this moment, the value of
> this string property is being used to match against the compatible entries
> in the of_device_id table. It can be extended in the future though.

I really do not want to see this patch without very good justification
(note, there were at least two attempts in the past to add this stuff
 and no-one was merged, have you studied those cases?).

-- 
With Best Regards,
Andy Shevchenko



