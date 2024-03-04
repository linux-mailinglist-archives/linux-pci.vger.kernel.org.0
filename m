Return-Path: <linux-pci+bounces-4428-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E648870444
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 15:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B08521C21171
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 14:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E52B3B29A;
	Mon,  4 Mar 2024 14:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PEWi9V6Z"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B762A26AE7;
	Mon,  4 Mar 2024 14:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709562925; cv=none; b=SUjzqoDJB69LthCPDJU9/n2+grWU/FXY+ruriJn/5aDtQAif+eDxd5kC3YBIrffnW6GqBJtJ9BU8dZUSYcfMnj1WrQYLaZngiTx1SYFE/i01kpVcdgq+0aJsy7pbe31QqVBUHzebwV/lc/7cBpxOSeu5VeYosfeiEB+nXf+C9wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709562925; c=relaxed/simple;
	bh=YYQV6yMvfxqmNzU/rw12ugXTBcvGhlJFcPq0AihGMfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=etGR2E7Y4KjN9ruHdzhr1xlZh2MilskrdX2xBkt2bkEbh/LXTsslT2Uj7SQ3ik1ocevbskzy0xb6gpkxM5K5T07378P1muuVXDjzCmNZaFdBbN0MlzdHqtBfT8rVo+/dREkjKa4ArEhC92E5xJ9XkFg3zKKQVzRPIJKRsqwbFP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PEWi9V6Z; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709562924; x=1741098924;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YYQV6yMvfxqmNzU/rw12ugXTBcvGhlJFcPq0AihGMfU=;
  b=PEWi9V6ZNIHfJXVIqet83Yz63n5M+J5Z6hGIj+CMX5xtKz4xVpSuV8hw
   7ZKUneNXJ48gJmTT2dw71gQtiP9qOEL8Ergy9ErY7WUEMn2E8oSG8lO7a
   rbXerpYvYLcY8rDv673d1UlEJp3bah4NHtJhsPGWsR0dhS5MrKl2MuFAh
   MB3tROKlwsGGm/V9e91SzAt0tOS4PkG24ydywM5KM38lx9cE+xOkbcX8J
   1j3MxJkq8RyM2uLoLLfaH59n7D1T3JcZQSwwpTQcQPDs8c14v57CMVp/n
   pyLoCSEMhRidQLbAgJ38Muihr0DW+hSZBK/1eQyk/hCvv91cpo7w0+SlW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="3911252"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="3911252"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 06:35:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="914107480"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="914107480"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 06:35:20 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rh9PS-00000009k3S-0xNm;
	Mon, 04 Mar 2024 16:35:18 +0200
Date: Mon, 4 Mar 2024 16:35:17 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"danilrybakov249@gmail.com" <danilrybakov249@gmail.com>,
	Lukas Wunner <lukas@wunner.de>, Klara Modin <klarasmodin@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2] platform/x86: p2sb: Defer P2SB device scan when P2SB
 device has func 0
Message-ID: <ZeXcJfXnhkPQ6M8J@smile.fi.intel.com>
References: <r6ezdjqb5hz5jvvaj2beyulr2adwht2sonxw3bhcjdvwduyt66@2hlsmnppfsk2>
 <7935add6-a643-43dd-82a8-b7bcfb94d297@redhat.com>
 <6sbllfapnclmu5sjdtjcs4tyzkkr76ipg3i3rtqyyj7syhtkwd@d2l6zq2co7zt>
 <a5dac02b-c16a-45d1-8157-0dae1b034418@redhat.com>
 <d6a95bd9-dac2-4464-af84-9394a36b7090@redhat.com>
 <2c3gyhvwncqgfa6t3tb6fj3fk3nkbzpmlgfyzwjgwmmlnhxssu@d25ihdnpwado>
 <8afa1f78-8b89-4bbc-95e5-35eea76356e4@redhat.com>
 <ZeXWLVHxOAZCHoJZ@smile.fi.intel.com>
 <ZeXX37B1xT4bt018@smile.fi.intel.com>
 <3cb6a678-e1e6-4849-927c-5157e269b9c0@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3cb6a678-e1e6-4849-927c-5157e269b9c0@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 04, 2024 at 03:24:58PM +0100, Hans de Goede wrote:
> On 3/4/24 3:17 PM, Andy Shevchenko wrote:
> > On Mon, Mar 04, 2024 at 04:09:49PM +0200, Andy Shevchenko wrote:
> >> On Mon, Mar 04, 2024 at 02:59:57PM +0100, Hans de Goede wrote:
> >>> On 3/4/24 1:13 PM, Shinichiro Kawasaki wrote:
> >>>> On Mar 04, 2024 / 12:04, Hans de Goede wrote:

...

> >>>> Thanks for sharing the insights.
> >>>
> >>> Looking closer at the actual unhiding I don't think accessing func 0
> >>> is the problem. The unhiding is always done on function 0 even when
> >>> retreiving the bar for function 2 (the SPI function).
> >>>
> >>> So taking that into account, as mentioned in the bugzilla, I think
> >>> the problem is probing the other functions (1, 3-7) by calling
> >>> pci_scan_single_device() on them.
> >>
> >> So, why we can't simply call pci_dev_present() on the function in a loop?
> > 
> > pci_device_is_present()
> 
> That takes a pci_dev as argument which we only have after calling
> pci_scan_single_device() and the calling of pci_scan_single_device()
> on some of the other functions is what is suspected of maybe causing
> the issue.
> 
> Also it is likely that if pci_scan_single_device() is actually
> a problem that then what is a problem is running it on an actual
> present device.

Which is weird. But okay, let's work around first the real issue, then
if I have time I will look into datasheet to see if there is anything
special about P2SB device(s).

> Devices which are not there also should not get confused
> by trying to probe them ...

-- 
With Best Regards,
Andy Shevchenko



