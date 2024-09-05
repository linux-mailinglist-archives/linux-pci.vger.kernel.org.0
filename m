Return-Path: <linux-pci+bounces-12824-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A23C96D259
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 10:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 484F32845A7
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 08:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCBA15531A;
	Thu,  5 Sep 2024 08:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LQ6MlztX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463101898E4;
	Thu,  5 Sep 2024 08:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725525511; cv=none; b=PLPjsomzmk3DSQW8xlwzj2PHUXxJo1wMmCJabFaSWFmqqYeEAUGRo233KQk+8pc16D9JAYL/MmyzqSaPL0bJWp4iqqwZJfGj4zTFggMpN9BiSuvhHoG8mERb1pqi5pD66y/w5fDN54UpCisgk6Kgb/vFP2XXkD83AJ3vHFhuQCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725525511; c=relaxed/simple;
	bh=ApFEG/8hgSP79AC1OQrIN2gy7kHgGP8XJqjnCL21jr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MvjQ4fUs8KRw0XB58wjIc71oznmkUZpqS26Q+1/O6igwdMnypZ1k0gHEzVSfp8SEgFOnhqZgFIIINlrvfRIVB0myuy1QOOVJg52lEv8xpT+4sbg7sa1ACTeJS/HLzGwHU8GuJqSUct4rgeCoSWCeT3NHYvJpA3QHyLkO7VCr4XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LQ6MlztX; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725525510; x=1757061510;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ApFEG/8hgSP79AC1OQrIN2gy7kHgGP8XJqjnCL21jr0=;
  b=LQ6MlztXCKVuDsjL9Zv0cHrRjoQQ3XSBJxIkXmV2J4FnhxSNj+MhVv3q
   S5wJ6imn7kUwSxhA7CSGq+ri1XYQ5CUW89A4p4cT7ddgimgHF8dZDuca4
   ztACL3DNs5WRxAR3XNHcry86GKmtaSp4UuJAH5orFidRGoh7S29zBQURC
   MOp5Ks1nhBSNGa5+PTs9ySSIjDSP/T8dOaIzst2XSc1d52Q3wWomuWD1k
   1DWY7sIUjjTm+LB/MciBBVsTzR9HFfuQem9eepAgNB4tgxpj68m/c5+/f
   y6qAOhBODrMmO/M9wgJT0tnpiMRyL3349WnCDQS+V6Lsgetia+SHkbXeh
   g==;
X-CSE-ConnectionGUID: HVR79ASGTJyd/Kja6kHKVQ==
X-CSE-MsgGUID: 2k4+ZCZOSYCwnS5pVU6JmA==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="24102266"
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="24102266"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 01:38:29 -0700
X-CSE-ConnectionGUID: XcWnu0czRBG19CXaT9wKdg==
X-CSE-MsgGUID: w3Ccck5hTmWQzvhu0as6Rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="65532989"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 01:38:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sm80T-00000005Knk-48yp;
	Thu, 05 Sep 2024 11:38:21 +0300
Date: Thu, 5 Sep 2024 11:38:21 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-leds@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Stuart Hayes <stuart.w.hayes@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lee Jones <lee@kernel.org>, Keith Busch <kbusch@kernel.org>,
	Marek Behun <marek.behun@nic.cz>, Pavel Machek <pavel@ucw.cz>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v7 0/3] PCIe Enclosure LED Management
Message-ID: <Ztlt_ZUy1EH1VQgC@smile.fi.intel.com>
References: <20240904104848.23480-1-mariusz.tkaczyk@linux.intel.com>
 <20240904222732.GA359748@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904222732.GA359748@bhelgaas>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Sep 04, 2024 at 05:27:32PM -0500, Bjorn Helgaas wrote:
> On Wed, Sep 04, 2024 at 12:48:45PM +0200, Mariusz Tkaczyk wrote:

> I noticed that b4 didn't pick up Stuart's Tested-by from the cover
> letter.  I assume it covers the whole series, so I added it to each
> patch.  Let me know if that's not what you intended.

You forgot to add -t IIRC which does spread the tags against cover letter to
all of the patches.

-- 
With Best Regards,
Andy Shevchenko



