Return-Path: <linux-pci+bounces-23320-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9E9A596C6
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 14:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECC483A853E
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 13:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0090522A4EA;
	Mon, 10 Mar 2025 13:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Osrq3WrQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BDA224252;
	Mon, 10 Mar 2025 13:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741614898; cv=none; b=lyplYvDlrwGlDi7/FIH35dmrcLFUnTqyhiwdha7Rjf3J3DAF2RORO9MrBr8+6C0o5MLEBnlbw3XtnspNNHkYGie5hlbzPhw/lPRRgVszqf5nP3UsMyZhtDNcqjwcEVvsOVSYPvQM0rR96slxeVlGII9bnnW9r2E5Z+hTqWY7ub4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741614898; c=relaxed/simple;
	bh=Qfk5uLS2oDl3kGJq3IrKIjKContvqjOCnHIknUaQRtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ISwCfB8vUJS6UfPglaAyOHUzUp9n7/xQWLzOwbhNuMNFawBD5xVejqsIvcYfxYcd26QVEM30U41vwgnDIhRpuPzk0lja9n5CHZv2QiXW99/g1IwdmfTG0fSEscmbKQIN7MQEd+NhCX4aNrL29fCCEE/dq0Xd7sejCLmj0FnFNDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Osrq3WrQ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741614898; x=1773150898;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Qfk5uLS2oDl3kGJq3IrKIjKContvqjOCnHIknUaQRtw=;
  b=Osrq3WrQaGBSwDBsdeifUF3wn4bWJvCYlJCejk4NVL0bMSvb51SmraUK
   rkCRcrJKFIVRSnZIRklT0DoFLtv450rANa7ixjS3vKpXlxDe6B+tBAagY
   g3YLrfpKoQrbAbSRNmjBOFUWH7oxgpJKKboX4oRas15eZuKHsnvl0Y36B
   krfAnmOWwWkjaA06XKNyuYJTt6KkeGCUn3nqAZdrcr5WWteFNsb5LxmaN
   qpLljTHeNfZabRNG3YHWkc4YrfSG3S/Y7J/Luw6UGgBSmO5yCD+iwGtJF
   q6F8091E3dEtQIqPyYiZuzneo+tMHTxIIXFBbe1c4V8UZAwZajKPgBhEj
   w==;
X-CSE-ConnectionGUID: mbhZwl0zSN+7awr0g0/DJw==
X-CSE-MsgGUID: Ej1JXtjpShOn5V9GB4vsGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="42824372"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="42824372"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 06:54:57 -0700
X-CSE-ConnectionGUID: Zyumlb35RFiFTMzcAl2G7Q==
X-CSE-MsgGUID: WW8DP6CaQoOvEYtRjqLu7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="125221639"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 06:54:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1trdak-00000001GpQ-13y8;
	Mon, 10 Mar 2025 15:54:50 +0200
Date: Mon, 10 Mar 2025 15:54:50 +0200
From: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Aditya Garg <gargaditya08@live.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>,
	"linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Aun-Ali Zaidi <admin@kodeit.net>, "paul@mrarm.io" <paul@mrarm.io>,
	Orlando Chamberlain <orlandoch.dev@gmail.com>
Subject: Re: [PATCH RFC] staging: Add driver to communicate with the T2
 Security Chip
Message-ID: <Z87vKltfijzRtlpL@smile.fi.intel.com>
References: <1A12CB39-B4FD-4859-9CD7-115314D97C75@live.com>
 <ef8dcf7a-34ed-4b27-a154-e01bc167d4e6@arm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ef8dcf7a-34ed-4b27-a154-e01bc167d4e6@arm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 10, 2025 at 01:49:13PM +0000, Robin Murphy wrote:
> On 2025-03-09 8:40 am, Aditya Garg wrote:
> > From: Paul Pawlowski <paul@mrarm.io>
> > 
> > This patch adds a driver named apple-bce, to add support for the T2
> > Security Chip found on certain Macs.
> > 
> > The driver has 3 main components:
> > 
> > BCE (Buffer Copy Engine) - this is what the files in the root directory
> > are for. This estabilishes a basic communication channel with the T2.
> > VHCI and Audio both require this component.
> > 
> > VHCI - this is a virtual USB host controller; keyboard, mouse and
> > other system components are provided by this component (other
> > drivers use this host controller to provide more functionality).
> > 
> > Audio - a driver for the T2 audio interface, currently only audio
> > output is supported.
> > 
> > Currently, suspend and resume for VHCI is broken after a firmware
> > update in iBridge since macOS Sonoma.

> I'm slightly puzzled why this was sent to the IOMMU maintainers when it
> doesn't touch any IOMMU code, nor even contain any reference to the IOMMU
> API at all...

People like to put a random people to a random contributions :-)

Aditya, you can utilise my "smart" script [1] to send the series
to more-or-less relevant people (but definitely to the right ones
± potentially interested, it has a heuristics inside).

[1]: https://github.com/andy-shev/home-bin-tools/blob/master/ge2maintainer.sh

-- 
With Best Regards,
Andy Shevchenko



