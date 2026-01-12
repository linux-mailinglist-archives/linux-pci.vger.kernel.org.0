Return-Path: <linux-pci+bounces-44550-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B45F8D150BE
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 20:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3D2E9300E401
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 19:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F9D3254B1;
	Mon, 12 Jan 2026 19:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kdvJL9d3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9442031AF3B;
	Mon, 12 Jan 2026 19:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768245848; cv=none; b=tcmKjTtVJjtG43JVbZHSMGabTHVXHIBDS/fdonpFUXnbNjlu9VFpdBZSm5UL1uliILonCzKI2FARu7Urx6vOAX1aNEJApsEnVznUTGUL+DF4sEN123gc3bx6wz7PDGO3G/n+fQqG+wO/SU4s4xa8ZrzU2ZsCjizsld7gCvoNA5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768245848; c=relaxed/simple;
	bh=bN4bwbhi28MS5T5tqSJFkZ4v6/AwJ2FsMFp7ZiU6cpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xw/ulPsA+UbN+OWs3TOsXIdrPynllCKH7nuVX6nmT+LXakSTAQnWEcNkwShoYCq9cl37i+ohFVncRXjOfcN61scfAbxI3lc9ZcO47ZNPRZaLrNcAObAhtlalpTclrpKhE/yszFYBBhZwJwJLOadaN2fklvNginltJV18hmHwyw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kdvJL9d3; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768245847; x=1799781847;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bN4bwbhi28MS5T5tqSJFkZ4v6/AwJ2FsMFp7ZiU6cpI=;
  b=kdvJL9d3g9q/hNzigYNANvfKsaUYeFbxZ7j4iek+ib0oskwC2bvVsw+w
   BTBGapFXggBypQ1vH2KRaBujKOHnzILasj/s9lZKI0t6Tw/Qg1+KwYk4k
   mAMstt157dywkBlG2SBojHiYT/8hHbVLwyq3yiPFARjVdYq8/f2ds47Vx
   3zHBoAbH3vo3+18a/R6aW8T0oY2rGHClYMUW7TVBH3xApuGLNM+PTCRit
   AFAAAWLYtaJ+lNbC7dZ8aREQrXA62WaV3vJooYwTW9O13rg3egGOJsEu+
   HYG7P/RhcP9+ihKobkwYg98Ky7uiZcHlufIEtVPZce5eWS2W3GXQysfmS
   Q==;
X-CSE-ConnectionGUID: XORkK+O+QXqjI5RW3J+3VQ==
X-CSE-MsgGUID: vsILTBKsTXSMsS5B72CgTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11669"; a="69439915"
X-IronPort-AV: E=Sophos;i="6.21,221,1763452800"; 
   d="scan'208";a="69439915"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 11:24:07 -0800
X-CSE-ConnectionGUID: GN4ckk2rS9Gb0aREb5A5MQ==
X-CSE-MsgGUID: 1qR7g9R6RKu4bTod1HIBBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,221,1763452800"; 
   d="scan'208";a="203332012"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.245.37])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 11:24:00 -0800
Date: Mon, 12 Jan 2026 21:23:58 +0200
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
	Bartosz Golaszewski <brgl@kernel.org>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	linux-acpi@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v4 3/9] serdev: Do not return -ENODEV from
 of_serdev_register_devices() if external connector is used
Message-ID: <aWVKTnatLTGwmNVh@smile.fi.intel.com>
References: <20260112-pci-m2-e-v4-0-eff84d2c6d26@oss.qualcomm.com>
 <20260112-pci-m2-e-v4-3-eff84d2c6d26@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112-pci-m2-e-v4-3-eff84d2c6d26@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jan 12, 2026 at 09:56:02PM +0530, Manivannan Sadhasivam via B4 Relay wrote:

> If an external connector like M.2 is connected to the serdev controller
> in DT, then the serdev devices may be created dynamically by the connector
> driver. So do not return -ENODEV from of_serdev_register_devices() if the
> static nodes are not found and the graph node is used.

...

> +	if (!found && !of_graph_is_present(ctrl->dev.of_node))

dev_of_node()

>  		return -ENODEV;

-- 
With Best Regards,
Andy Shevchenko



