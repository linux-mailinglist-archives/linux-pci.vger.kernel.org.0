Return-Path: <linux-pci+bounces-44478-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FD9D111A4
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 09:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7745C301ABAB
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 08:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C7C338904;
	Mon, 12 Jan 2026 08:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m9Xn5W04"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4F53128BD;
	Mon, 12 Jan 2026 08:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768205394; cv=none; b=Z0aTGSUf4nU8vsLBLuIKQ8MxyWJzt4shSXZGnlQ+H8NlrSTGCeJTu7oP5TTRsj82gUSM/6QqIMn9Q8uGMDky2c4OAA5frCc0ypNAeyz3gjFjMMzXQWbBVontP3MYio0nNs1LAVov4SLedFM6aNvNzgXHwXT3tdRHzlh+vfNxD8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768205394; c=relaxed/simple;
	bh=TykjM8VKjCSa2Ir2V28ejSCtFZhOX0kUSeF9MY/eGz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hoF4iATE3sLBmY+vY468qKKVMbpuat59VnhpxCmceREtYTu6ZTB+FfglHpPuVuGftB+7hl7G4U/sFTe2edCkq4XjvL/9JviHc+i9Bme2Ltd2x42sDwvQlVmkqaHEUtCb+hvCliqutDKQiskE1E5//rXo7VruXGXx+faEw5hSd2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m9Xn5W04; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768205393; x=1799741393;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TykjM8VKjCSa2Ir2V28ejSCtFZhOX0kUSeF9MY/eGz4=;
  b=m9Xn5W04Ul+LDFfheRSavAZEc+gVnfnUZgMtRHcbO/NzhkbGuTjU95iQ
   br+kdRVSGU5IjdZKa4ULroK4wlMAjzjKg+mO/WBJSLO+gsa5uuM1VaoiE
   MwjWA5rvfwQIO8IVVZJOGWfLAnmiXyUa/XRO0oCcm6z6leI70gvo5cIvb
   tSDeFu7Mp7JUuxwkz6h8rbJ9L1UjT4NRCZdCq/pUzy/4gQaFX8hZeSSI8
   bqaQPdCf14B/oy7q8RgLC9rh3JQd0Fh7nZtFlkaYGYPBm0PvFLL75QM6R
   UYpTU0l3M/8mEizMkLVf9dTlNu0Q2rcbEGakBeTUh6GgiAwYGgV8/db1/
   A==;
X-CSE-ConnectionGUID: zq+BrRklSMexbwYZvjAuMA==
X-CSE-MsgGUID: wdRAwR+uR3WhWsyTh+eE/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="80197439"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="80197439"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 00:09:52 -0800
X-CSE-ConnectionGUID: Z8st7ihITbemjnREM595xw==
X-CSE-MsgGUID: OD1oYWlsQpuyd5fbCismQA==
X-ExtLoop1: 1
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.245.37])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 00:09:45 -0800
Date: Mon, 12 Jan 2026 10:09:43 +0200
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
Subject: Re: [PATCH v3 05/14] software node: Add
 software_node_device_uevent() API
Message-ID: <aWSsR81HZkwm78bj@smile.fi.intel.com>
References: <20260110-pci-m2-e-v3-0-4faee7d0d5ae@oss.qualcomm.com>
 <20260110-pci-m2-e-v3-5-4faee7d0d5ae@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260110-pci-m2-e-v3-5-4faee7d0d5ae@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Jan 10, 2026 at 12:26:23PM +0530, Manivannan Sadhasivam via B4 Relay wrote:

> Add software_node_device_uevent() API to return the uevent variable for
> swnode using the DT compatible property. The uevent will have the DT prefix
> of "of:N*T*C" to match the DT's module device table.

This even sounds wrong.
NAK.

-- 
With Best Regards,
Andy Shevchenko



