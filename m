Return-Path: <linux-pci+bounces-17631-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 338849E36F2
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 10:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0360284252
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 09:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805F9199EB7;
	Wed,  4 Dec 2024 09:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hri5/53m"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF39ABE5E;
	Wed,  4 Dec 2024 09:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733306001; cv=none; b=rUjlqGIp3KpYRthGV39rA3kKQR5Cr8wkH7UdriDn2x79llAkkRKknUha5OVroTWubUvWkZHC862VodFwDa2cKaT4paDYW6gW3fBf1DNOAv+ofP3+ST5KIFDdLxCobV7j/+53oHnkjViTiQ8azde3ZPL24tCJlugm22xiYvlZpQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733306001; c=relaxed/simple;
	bh=ikvRGFtWLr4avaowkPIcLkUV2+AZIXQa/xtSbMU/Rxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OEVL0WgwVTYlc3P918/Hw3kZdF2ylMacYEAgNY5hwifg59bHNYTQ15Vl5BGG3dc88L5nJKCipWcBcMkacXTlrjHKLPnw+aDAv9kZ6PeXKFeKTD6DreLKQQdBNMLKB2HelyWJX1nzFj5NrSmcmOxUX597fNHO9Cu5ZKrd4WxOz0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hri5/53m; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733306000; x=1764842000;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ikvRGFtWLr4avaowkPIcLkUV2+AZIXQa/xtSbMU/Rxc=;
  b=Hri5/53mPnbB4ickc6AlcWmc5rduXH5Y3w2bpJ8RFUpeBhXYIU1iAkIR
   65uyg6Fm48djlFC8P4BYtpwWetNasTOldxpKUcxEbLlghyw1rSwotj8zW
   Y38Y2TWNrdDpCZyFrd62ga8kiAKj9UvOf/YNMEIfaxHFqliy7IpzA4y3B
   NoBGiq8t4ijJ4y26YF2TWDeM+OnkWyYndN/5X5+O9XPNO+mt3CM/YOoqZ
   ZeOY4dbB5lKaYLysdH6dzsgedgz1V8tIS74aMdOEiiDihHXoI3YPzKPsj
   y3OI8oXy2BsxccCwIAa+zRgaJHTzmMM//Ck4kiKjPAmummegSYwLQ3RoW
   A==;
X-CSE-ConnectionGUID: G1Ph2sFISUuCd4B5/qra5A==
X-CSE-MsgGUID: RXOSBTexRqybkKnooSOKvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="33693621"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="33693621"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 01:53:19 -0800
X-CSE-ConnectionGUID: D2fcP3wARVat8joSsrPGgQ==
X-CSE-MsgGUID: cSjB88oiSW6FNEc2LT/82Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="93900666"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 01:53:17 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tIm4H-00000003i4V-45v4;
	Wed, 04 Dec 2024 11:53:13 +0200
Date: Wed, 4 Dec 2024 11:53:13 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Cameron Williams <cang1@live.co.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Fenghua Yu <fenghua.yu@intel.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-pci@vger.kernel.org,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v1 2/2] serial: 8250_pci: Share WCH IDs with
 parport_serial driver
Message-ID: <Z1AmiSyKZhzzy8JJ@smile.fi.intel.com>
References: <20241204031114.1029882-1-andriy.shevchenko@linux.intel.com>
 <20241204031114.1029882-3-andriy.shevchenko@linux.intel.com>
 <5ca95d14-84a7-48af-a5e3-cefc558d2e7f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ca95d14-84a7-48af-a5e3-cefc558d2e7f@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Dec 04, 2024 at 08:14:42AM +0100, Jiri Slaby wrote:
> On 04. 12. 24, 4:09, Andy Shevchenko wrote:
> > parport_serial driver uses subset of WCH IDs that are present in 8250_pci.
> > Share them via pci_ids.h and switch parport_serial to use defined constants.

> >   	{ 0x1409, 0x7168, 0x1409, 0xd079, 0, 0, timedia_9079c },
> >   	/* WCH CARDS */
> > -	{ 0x4348, 0x5053, PCI_ANY_ID, PCI_ANY_ID, 0, 0, wch_ch353_1s1p},
> > -	{ 0x4348, 0x7053, 0x4348, 0x3253, 0, 0, wch_ch353_2s1p},
> > -	{ 0x1c00, 0x3050, 0x1c00, 0x3050, 0, 0, wch_ch382_0s1p},
> > -	{ 0x1c00, 0x3250, 0x1c00, 0x3250, 0, 0, wch_ch382_2s1p},
> > +	{ PCI_VENDOR_ID_WCHCN, PCI_DEVICE_ID_WCHCN_CH353_1S1P,
> > +	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, wch_ch353_1s1p },
> > +	{ PCI_VENDOR_ID_WCHCN, PCI_DEVICE_ID_WCHCN_CH353_2S1P,
> > +	  0x4348, 0x3253, 0, 0, wch_ch353_2s1p },
> > +	{ PCI_VENDOR_ID_WCHIC, PCI_DEVICE_ID_WCHIC_CH382_0S1P,
> > +	  0x1c00, 0x3050, 0, 0, wch_ch382_0s1p },
> > +	{ PCI_VENDOR_ID_WCHIC, PCI_DEVICE_ID_WCHIC_CH382_2S1P,
> > +	  0x1c00, 0x3250, 0, 0, wch_ch382_2s1p },
> 
> I know this is the current pattern in the file. But what about using
> PCI_DEVICE_DATA() for the first and PCI_DEVICE_SUB() + .driver_data for the
> rest? Otherwise it occurs as a load of incomprehensible constants.

I can issue an additional patch, I was really thinking about this, but decided
to go the above way as it seems logical and moving to mentioned macros sounds
like unrelated to the point of the change.

-- 
With Best Regards,
Andy Shevchenko



