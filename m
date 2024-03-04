Return-Path: <linux-pci+bounces-4426-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3888703EE
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 15:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20B35B23739
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 14:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7B13FB29;
	Mon,  4 Mar 2024 14:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="muXQzj0N"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF863FB1E;
	Mon,  4 Mar 2024 14:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709562169; cv=none; b=KaT5utrUSCBd3yqLkl2o6Oytvfzglvd0n3bmyZDUWtTxsN5VxbXbEb9sksdSqRfXlYx36VEDVd9ASuJL145ejF33AIxRTQw5PXwNhSogg2bssvV0yProRa2JzIux9v7lXVgZtK1Z8DumvSeuZtTjQLFzyyOTmG05NCRpPw8crRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709562169; c=relaxed/simple;
	bh=5Kdh+ldUQ9mTw9PUC2P67jqWdh8SJoCuGjBOaOyvens=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IDBbYNwzq8/Z2iDq4vGXHTpoAS1ieeigcQZuobqOCD3Igk1nvlRWiNgBeD0VRoLGI5sodf3cHVFOwraX94x0zyjfZPnXIFA0uky9f7404jH7oxWWjggCmj2XHiX39B+0v/FLEWEp04K5emfjW71pkLfuszF/6GWasV42pl7sR88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=muXQzj0N; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709562168; x=1741098168;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5Kdh+ldUQ9mTw9PUC2P67jqWdh8SJoCuGjBOaOyvens=;
  b=muXQzj0N5qYgjgFT32Iw8wBzDC8HStd7oxmZoFjOFDM5eCh4Po3hPC9q
   tEpaHUnYyEmIbDhY5g7VITDppEJg58p51UhrhltBVJwQNXkPpx4mMu16k
   uE7EEoujciKRT3uZuFsn9rnmR5yP1Hw3nFob5oYFQU4IdBXWyJs2hY08H
   GmvEdj7Zggaf2+/OHqR0tOmgMYb7MXDVJwM8r/uCvBbjZ1AqBEGO8iiOW
   UAp8xpUkxzi5MrftsUCHY1ReKGKkTl/BUNUfiFNWbVmkbuNB44a4qgDC9
   D8xaJqqNTIRfxjPeT79qPvcSvjgol8ocidSHNH+50u6m36vp21zcEmpjm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="3909084"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="3909084"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 06:20:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="914107085"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="914107085"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 06:20:48 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rh9BN-00000009jiA-1Y5z;
	Mon, 04 Mar 2024 16:20:45 +0200
Date: Mon, 4 Mar 2024 16:20:45 +0200
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
Message-ID: <ZeXYvew8J5Adw-zp@smile.fi.intel.com>
References: <a26554d3-bee9-4030-a06c-f886ba2fffb0@redhat.com>
 <r6ezdjqb5hz5jvvaj2beyulr2adwht2sonxw3bhcjdvwduyt66@2hlsmnppfsk2>
 <7935add6-a643-43dd-82a8-b7bcfb94d297@redhat.com>
 <6sbllfapnclmu5sjdtjcs4tyzkkr76ipg3i3rtqyyj7syhtkwd@d2l6zq2co7zt>
 <a5dac02b-c16a-45d1-8157-0dae1b034418@redhat.com>
 <d6a95bd9-dac2-4464-af84-9394a36b7090@redhat.com>
 <2c3gyhvwncqgfa6t3tb6fj3fk3nkbzpmlgfyzwjgwmmlnhxssu@d25ihdnpwado>
 <8afa1f78-8b89-4bbc-95e5-35eea76356e4@redhat.com>
 <ZeXWLVHxOAZCHoJZ@smile.fi.intel.com>
 <ZeXX37B1xT4bt018@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeXX37B1xT4bt018@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 04, 2024 at 04:17:04PM +0200, Andy Shevchenko wrote:
> On Mon, Mar 04, 2024 at 04:09:49PM +0200, Andy Shevchenko wrote:
> > On Mon, Mar 04, 2024 at 02:59:57PM +0100, Hans de Goede wrote:
> > > On 3/4/24 1:13 PM, Shinichiro Kawasaki wrote:
> > > > On Mar 04, 2024 / 12:04, Hans de Goede wrote:

...

> > > > Thanks for sharing the insights.
> > > 
> > > Looking closer at the actual unhiding I don't think accessing func 0
> > > is the problem. The unhiding is always done on function 0 even when
> > > retreiving the bar for function 2 (the SPI function).
> > > 
> > > So taking that into account, as mentioned in the bugzilla, I think
> > > the problem is probing the other functions (1, 3-7) by calling
> > > pci_scan_single_device() on them.
> > 
> > So, why we can't simply call pci_dev_present() on the function in a loop?
> 
> pci_device_is_present()
> 
> > Will be even simpler fix, no?

Oh, it requires a PCI device structure which is probably is not there until
we call the pci_scan_single_device()...

-- 
With Best Regards,
Andy Shevchenko



