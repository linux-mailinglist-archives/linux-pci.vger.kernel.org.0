Return-Path: <linux-pci+bounces-4423-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2298703B3
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 15:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92B591F2710B
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 14:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19A13F9EC;
	Mon,  4 Mar 2024 14:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E57bvW4D"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080DC3D9E;
	Mon,  4 Mar 2024 14:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709561396; cv=none; b=mqTqbz55yQL2t4H2HqWBxb+jLmQtHwVxVYbZ8Q/zdreYIBR0sNPA8a1XYyIzRXuX6yjcP397s7GfVuAqhIpdt9qmVJqci7ZlWSaLu732GYarGRHkAuLt9HHsllrFsDvUcnDLsMbkW8lKwf4ddDTJ7CgttNw9tJ+qHbcNoCbosJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709561396; c=relaxed/simple;
	bh=fbg+cmnylxojk44dcZJAvkli2428pi5TFmKhre+Fp6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+QlXj5JKb0feW2JKRsOLpsQ1mES3jy/A/K29W499t7kZR2h3WPcJUsh9QEp5MDESbFs+GEOJlOW0a1iCzZ6wOs44DxcU+ijp7lLmAy3ev5eRuXBDyRfzaT03/U+c3NHxslm60fC83dAcDa4tFrHqLxupKYa0PZR5hcVoTev3sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E57bvW4D; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709561395; x=1741097395;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fbg+cmnylxojk44dcZJAvkli2428pi5TFmKhre+Fp6M=;
  b=E57bvW4D7VpwAQSiV7DtQNH2sihgnHWYWzclTB1LptJppbfFnKfMOq76
   wMifhDrs3sRp/ZmlSY1hhfiuzthD+Ckzaw3WQUm7ClZoct2Kuomng9qYS
   3HUJVG9ihIgIhiLHyAmdO43u0+Wl0fuiY2L583GGXvsYY2KiZP14PVF/4
   PomYclVSyPQX1b4teCvulfCq+LIb1+ArrjnrXhyP3S8B8Aef3RQFsmNmN
   K5gSXbsrPDrD/MaCvldCvb6HLzqg2YqpIzK0r2Yyn/vJqU8MC9/cjX4A8
   VjCwjp1/u6XhzHsPTMtVdG7hxzTl8eYm6UYsGjmmxZYbDxiXB0EQELe4P
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="15461178"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="15461178"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 06:09:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="914106781"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="914106781"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 06:09:52 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rh90n-00000009jXd-1MbT;
	Mon, 04 Mar 2024 16:09:49 +0200
Date: Mon, 4 Mar 2024 16:09:49 +0200
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
Message-ID: <ZeXWLVHxOAZCHoJZ@smile.fi.intel.com>
References: <20240302012813.2011111-1-shinichiro.kawasaki@wdc.com>
 <gl7rsalwdwdo4rdes6akcnd7llrz75jjje2hchy5cdvzse6vei@367ddi3u6n2e>
 <a26554d3-bee9-4030-a06c-f886ba2fffb0@redhat.com>
 <r6ezdjqb5hz5jvvaj2beyulr2adwht2sonxw3bhcjdvwduyt66@2hlsmnppfsk2>
 <7935add6-a643-43dd-82a8-b7bcfb94d297@redhat.com>
 <6sbllfapnclmu5sjdtjcs4tyzkkr76ipg3i3rtqyyj7syhtkwd@d2l6zq2co7zt>
 <a5dac02b-c16a-45d1-8157-0dae1b034418@redhat.com>
 <d6a95bd9-dac2-4464-af84-9394a36b7090@redhat.com>
 <2c3gyhvwncqgfa6t3tb6fj3fk3nkbzpmlgfyzwjgwmmlnhxssu@d25ihdnpwado>
 <8afa1f78-8b89-4bbc-95e5-35eea76356e4@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8afa1f78-8b89-4bbc-95e5-35eea76356e4@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 04, 2024 at 02:59:57PM +0100, Hans de Goede wrote:
> On 3/4/24 1:13 PM, Shinichiro Kawasaki wrote:
> > On Mar 04, 2024 / 12:04, Hans de Goede wrote:

...

> > Thanks for sharing the insights.
> 
> Looking closer at the actual unhiding I don't think accessing func 0
> is the problem. The unhiding is always done on function 0 even when
> retreiving the bar for function 2 (the SPI function).
> 
> So taking that into account, as mentioned in the bugzilla, I think
> the problem is probing the other functions (1, 3-7) by calling
> pci_scan_single_device() on them.

So, why we can't simply call pci_dev_present() on the function in a loop?

Will be even simpler fix, no?

-- 
With Best Regards,
Andy Shevchenko



