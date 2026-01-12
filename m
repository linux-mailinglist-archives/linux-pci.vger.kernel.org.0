Return-Path: <linux-pci+bounces-44471-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A832AD10F73
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 08:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EFA133034925
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 07:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537FA3382DB;
	Mon, 12 Jan 2026 07:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FQQIFhJm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F863382C7;
	Mon, 12 Jan 2026 07:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768204245; cv=none; b=WQ564TbDtIdfXbwbnddQ2TP6GrcNwbqngfODXOKAX3pYHsDLDmi2nVLTGAwjbvAz3UxeL5rXfO1TCht2K5y0eHd2cPokvl+x0JJ26UPYj+Cw7kr+AeOgxtQXlzd+JJiUYCmYanTez0/509UQrM+IGL8Tw8MjCDITR2sbPKjb+iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768204245; c=relaxed/simple;
	bh=53DML+O9wLCsLD9KygC2k2RcGp7erugQrQ/jauBngGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C1mRDuzJ7yrOPbuzzBa9U+qKSyimgoglYMLCOuV5Woi98KIPr5PldoqvzkRQIQztWRRF3pvcmBRLTKH10XOxdUXpwTExl2TKPp+gXDlBBQ8TvPTYH3D2ellbxqWn6XA+WDNi/pcNfUgTTFFb9XaGGW8twP+GfdRzsYc3+W9xOUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FQQIFhJm; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768204244; x=1799740244;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=53DML+O9wLCsLD9KygC2k2RcGp7erugQrQ/jauBngGo=;
  b=FQQIFhJm/N7TTId6kSQflx7ayspKlTQyKrZaXWGF1C4KaxSMK7zQ3jkx
   buTX/HE/7klxWeeeKSDOjk2ywNlRsO7bzxT/kMYv2CN0Hn+4fMxzYRtkQ
   hLOl/ElEf3HgGCHjG3dGazoLa6zsnMUpp5SYzlO/F/FZNEXmQpLFb1zEi
   IfSPTTYGVxc3/mz7PvKd2xBvGKVa+bnpnuIWCMMKcasIOV1ZYK20nwQ+Y
   j/rNn9iK7g0FtKmmRbfzCC6cnejkvBGwVnd2LU9GmL9zsnGjR5sOXHArj
   CPtrjKTEem1YhUk2MgtBEMGVgZKw6pU+k4XsCgVQ23BUsQ/2U5yE2nONF
   Q==;
X-CSE-ConnectionGUID: Bb+65xQWQga0msTWag1U0g==
X-CSE-MsgGUID: SedXBILnR2u18LHRpya5og==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="73106859"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="73106859"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 23:50:43 -0800
X-CSE-ConnectionGUID: oOt9DnTJRGeA/gjnS4jsyg==
X-CSE-MsgGUID: x01Uom+QSTSGrpav6bnpFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="203826903"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.245.37])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 23:50:35 -0800
Date: Mon, 12 Jan 2026 09:50:33 +0200
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
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 02/14] serdev: Add an API to find the serdev
 controller associated with the devicetree node
Message-ID: <aWSnyc8Eiq56ckXB@smile.fi.intel.com>
References: <20260110-pci-m2-e-v3-0-4faee7d0d5ae@oss.qualcomm.com>
 <20260110-pci-m2-e-v3-2-4faee7d0d5ae@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260110-pci-m2-e-v3-2-4faee7d0d5ae@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Jan 10, 2026 at 12:26:20PM +0530, Manivannan Sadhasivam via B4 Relay wrote:

> Add of_find_serdev_controller_by_node() API to find the serdev controller
> device associated with the devicetree node.

Why OF-centric code? No, please do it fwnode-based.

-- 
With Best Regards,
Andy Shevchenko



