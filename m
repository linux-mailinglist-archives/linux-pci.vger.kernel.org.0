Return-Path: <linux-pci+bounces-44493-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD20CD123BB
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 12:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2E0A303B7C0
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 11:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F297B3563CF;
	Mon, 12 Jan 2026 11:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YOkrzxTX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEF43559EC;
	Mon, 12 Jan 2026 11:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768216524; cv=none; b=c8rMDLtPueqGW9wI9mGOKj4ZuksOlW9PfxXp1RubRj/bDeB0pRnYmx5IP8uuBDUv37CZsHmzZ7DJ+VotuH0PFDmR8hEOkwUlC8fL6EUd8OhQMy9VO33Gu2QXuM5eHOSVG5es+kMn0ATM8HHHmgIFlwGPe2cYbxyQST6dZ3v8/7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768216524; c=relaxed/simple;
	bh=zUSCP1wlBfzuXE8NqisF5E9uyqPXe+GBaVIHFJQsuQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jmvvzTjjddG82PALPYM4KCK16MtIuQ55s0P1qFHhQK/Q0L3sMe2uayMSo335YHg98M8Uofj1OyzrVJ6ihrjfpykrfkHdr9mrDA9ptecarGkxiiA+0dDsCKR7XjtdG4EWyVn4ii/LPGCr6sXZMCNOdjBli4Au8tAHuHVq/HQH18U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YOkrzxTX; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768216523; x=1799752523;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zUSCP1wlBfzuXE8NqisF5E9uyqPXe+GBaVIHFJQsuQc=;
  b=YOkrzxTXzeOUMoQWA6cTprZC+zpGF4q2qS7RvU4ksZ0BaY7xo/OsgtpF
   jSI74vpQZYGnBYathDznmX344Rg5BIOKRTYb1NA/LfWslfgoWqM51VTYJ
   sR96ncLH5ygzLWfavGmV/x1RLIXuCMMZiZZSuGlBQZ9fIFgzGyeO/hxsH
   wObdUl6QsMr6lB8smFJDt9fdRNOFLaqgv847xfXsE4SIDfmjvrEdfqeZa
   nUTJkpzdPN7OD/fQQ0OnYs3uBf6KmvkDc+Csrvv4vBasNGlvaDx6mHdMc
   xgsqBN/3bQZbQQWc/l9Iu8qoiHq9yVKvkgvyWCgTd4U9+bA5+18F7pwZJ
   w==;
X-CSE-ConnectionGUID: 6WVsrkR+TdCu6VvYTahNDQ==
X-CSE-MsgGUID: AD7rNmHrQHiNetTiLDouwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="80209602"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="80209602"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 03:15:22 -0800
X-CSE-ConnectionGUID: kUR6ig1/RUKJYBcy/p3hfQ==
X-CSE-MsgGUID: OAg+gLOMQVGuS3+zfM3y2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="203977233"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.245.37])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 03:15:16 -0800
Date: Mon, 12 Jan 2026 13:15:13 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@kernel.org>
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
	Danilo Krummrich <dakr@kernel.org>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	linux-acpi@vger.kernel.org, manivannan.sadhasivam@oss.qualcomm.com
Subject: Re: [PATCH v3 04/14] software node: Add software_node_match_device()
 API
Message-ID: <aWTXwSaNEVZsNxip@smile.fi.intel.com>
References: <20260110-pci-m2-e-v3-0-4faee7d0d5ae@oss.qualcomm.com>
 <20260110-pci-m2-e-v3-4-4faee7d0d5ae@oss.qualcomm.com>
 <aWSxcJTLzBFbMGad@smile.fi.intel.com>
 <CAMRc=Md6+hhLMOmmDejKW+_jbWu3_XB4qNobyi27pezfXsVLFw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=Md6+hhLMOmmDejKW+_jbWu3_XB4qNobyi27pezfXsVLFw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jan 12, 2026 at 06:03:34AM -0500, Bartosz Golaszewski wrote:
> On Mon, 12 Jan 2026 09:31:44 +0100, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> said:
> > On Sat, Jan 10, 2026 at 12:26:22PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> >
> >> Add software_node_match_device() API to match the swnode device with the
> >> swnode driver. The matching is based on the compatible property in the
> >> device and the driver's of_match_table.
> >
> > NAK. swnodes != real firmware nodes.
> 
> While I'm not arguing that this is *the* solution, I think it warrants
> a discussion on proper matching of devices that are only backed by a software
> node - for instance a serdev device on the auxiliary bus. I understand what
> software nodes were historically but perhaps it's time to extend their role as
> a full-blown firmware node allowing matching with drivers.
> 
> Reusing existing OF IDs is just one way, we could potentially think about a
> high-level fwnode-based device to driver matching?

There is already proposed and agree way to do that via DT overlays.
If one needs to describe the (PnP or hotpluggable) hardware, it's
the way to go as the HW maybe much complex than the just one small UART
appendix.

As per auxdevice, this should not be enumerable by compatible. The auxdevice
usually are created by other devices (from real ones) that _know_ the topology.
I don't see why we need to open the can of worms with the software nodes
to enumerate them as real ones.

P.S. Collect others' opinions (esp. device property reviewers and maintainers)
and we will see. But I do not see any even looking good justification for that.
It might be that I didn't get fully the use case and the other means can not
be used. But taking into account history of the rejection of the matching against
OF compatible string in swnodes suggests that this will stay the way it's now.

-- 
With Best Regards,
Andy Shevchenko



