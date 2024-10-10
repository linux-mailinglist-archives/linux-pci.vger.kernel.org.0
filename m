Return-Path: <linux-pci+bounces-14216-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF65998FB0
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 20:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54C1EB22524
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 18:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231471CEAD0;
	Thu, 10 Oct 2024 18:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fZFeLxxX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903911CEAA7;
	Thu, 10 Oct 2024 18:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728584418; cv=none; b=UpxLUDeYt5/fVGuGC0YDYAnsBz/y0Q9fckwx86CW/kGaCKmSkIa6/EZcBVQEFJpdzIhucxPguCxhi5SB4JMURmHjV/iWLBX7JcH8mfB0lazgVL/qmdbVBx42n8omTLLi5SyaPc2xpcOTRqeSLIGq2AIWGcSqGWkr05HHsdY1NGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728584418; c=relaxed/simple;
	bh=FicUtrc9ldvt8iypHNOSymiyr8AWJnh+K9cgdxhR6JQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j7IaDafYE2SCo5qiZRGVbdA4XRE0eqE+/qGXLNiEZIP8gLLICyd0+exN4cRbyWJzFaECUCgqQdKlAOrBh/DZwBjv8UHp/0IaxsE/N6cR28YmlhdI5H6Fky07HM6mp6uAkEBntOwzcSi2SpTpjsRgOfsn4SBRVSxtcjxstj1VmGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fZFeLxxX; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728584417; x=1760120417;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FicUtrc9ldvt8iypHNOSymiyr8AWJnh+K9cgdxhR6JQ=;
  b=fZFeLxxX7RDNCoK1rNPuZUeh1/jQEwT3c+yGgPkMwGY1J5OymL3JzrqW
   MZBH4ZT+aXacxUWw8kZE+QzoBPpu11XWCM7u8lGKK3OFRerX3QO49ZrYy
   OTVcTAsKlYmigwY6BdgDtZ+ZYdNb0BTf171Y+bfYr2rcrmov81WCRJTt/
   5raunTNxOYZ+w+lJm1L1IvhCqMW+AWN8Yr3kFQduBR5VKLd4K/tYVEMLI
   lct7O2Uzvqk5EG2LeyggmpFItxsgXzJfZfJNDxoy58xkkY2cCpacx8qXi
   i/3U7hPNUQdbKJghswIWrUoQkYDmQes3eesHdA/us9OHs2d2bYgOqeVsg
   w==;
X-CSE-ConnectionGUID: xlAZHX6lSgKCON92EiXzwA==
X-CSE-MsgGUID: W1gZKbh7RTKulZyyfjIzCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="15589027"
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="15589027"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 11:20:16 -0700
X-CSE-ConnectionGUID: DEWjVGkjSfaRjtnCgEDsvg==
X-CSE-MsgGUID: QvoCv6CASpqIbYmpJlguHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="100009260"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 11:20:14 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1syxlk-00000001dJl-0D95;
	Thu, 10 Oct 2024 21:20:12 +0300
Date: Thu, 10 Oct 2024 21:20:11 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Dejin Zheng <zhengdejin5@gmail.com>,
	Philipp Stanner <pstanner@redhat.com>
Cc: helgaas@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/4] Introduce pcim_alloc_irq_vectors()
Message-ID: <Zwga201ezmC75Qyi@smile.fi.intel.com>
References: <20210607153916.1021016-1-zhengdejin5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607153916.1021016-1-zhengdejin5@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

+Cc: Philipp (JFYI)

On Mon, Jun 07, 2021 at 11:39:12PM +0800, Dejin Zheng wrote:
> Introduce pcim_alloc_irq_vectors(), a device-managed version of
> pci_alloc_irq_vectors(), In some i2c drivers, If pcim_enable_device()
> has been called before, then pci_alloc_irq_vectors() is actually a
> device-managed function. It is used as a device-managed function, So
> replace it with pcim_alloc_irq_vectors().
> 
> Changelog
> ---------
> v6 -> v7:
> 	- rebase to PCI next branch
> 	- add a stub for pci_is_managed() when disable PCI for
> 	  fix build error in sparc architecture.
> v5 -> v6:
> 	- rebase to 5.13-rc4
> v4 -> v5:
> 	- Remove the check of enable device in pcim_alloc_irq_vectors()
> 	  and make it as a static line function.
> 	- Modify the subject name in patch 3 and patch 4.
> v3 -> v4:
> 	- add some commit comments for patch 3
> v2 -> v3:
> 	- Add some commit comments for replace some codes in
> 	  pcim_release() by pci_free_irq_vectors().
> 	- Simplify the error handling path in i2c designware
> 	  driver.
> v1 -> v2:
> 	- Use pci_free_irq_vectors() to replace some code in
> 	  pcim_release().
> 	- Modify some commit messages.

-- 
With Best Regards,
Andy Shevchenko



