Return-Path: <linux-pci+bounces-15670-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0D09B74DD
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 08:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A9542814EE
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 07:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4724437C;
	Thu, 31 Oct 2024 07:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TPgJziui"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C286C1BD9CD;
	Thu, 31 Oct 2024 07:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730358082; cv=none; b=JU+u6Zn9xJfuX2c0mnvaP+/itlpeJCwXPgKrcVUBk3NdPllFimDn0J+/vC6x+iT6k5yN5EV3jO6nM+X6obF4fB6qQ4OXU17m8mUy1lFul+b1YiPS0AEX5qPiMs7hz5laXke0YpLzYpqWpNMQ0DCdzph0nmPU8yBqpx0SzAfpM+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730358082; c=relaxed/simple;
	bh=mw/CVeH1bJqcKVGmf9Wt2wHHjGxU3/XLceEQbbhM24w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OKHiJAlS7bDCyrzqhjraPHDabcM1nPcHrhK/W3jKGsUoKsy4Zsn7PVkjSIvxU/uk4wW6aJStHLTXHeMfGL7/M1Skhs485JKdGkfspWz5VO/m89gN/DOxjnLUkkh+dN1ByXpQpm63milNTat71dql5rtSM71DKa49ErfSRglejyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TPgJziui; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730358081; x=1761894081;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mw/CVeH1bJqcKVGmf9Wt2wHHjGxU3/XLceEQbbhM24w=;
  b=TPgJziuiXALFKMdG1I5QwUaWeE3R6VlQwwqJFokzTL/daOOoByvMr+U7
   y5huoVnkcCG0VbcMzPy/Dls7bsTUUesPAsC1RQKYcdTX14+A8pAiCc6kq
   hBdfJnRdLn+lIpg01rLgGNOZmMQyqo5VtxdPyy4qvv3khIzs2zunvtIC8
   FHjmNskcspa0/qT4eNBXjGXIm05H8gHPFhVnAWboxUu4ZVqO3DRZBXqa2
   8E0HmZJFZQaqXpwRh0RCrVttjWmgbKovmvr1I8tFLiISovUn71oojyRq6
   BULkImtCH1y2AmuC0H/+edad4xC4u0OWXsn2dddnklkny6Vm4r/iIQiG7
   g==;
X-CSE-ConnectionGUID: v/2yIZwGRoSuvcLA6UZ6OA==
X-CSE-MsgGUID: xeMLVBvUS4+s0IRNBXtMfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="47557665"
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="47557665"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 00:01:19 -0700
X-CSE-ConnectionGUID: ln9AkFECS1iRbu1TNAp59Q==
X-CSE-MsgGUID: c8VoGqh7Q6SO2xwMRJ1+uA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="113337501"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 00:01:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t6PBD-00000009KHH-0rMC;
	Thu, 31 Oct 2024 09:01:15 +0200
Date: Thu, 31 Oct 2024 09:01:14 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] PCI/bwctrl: Check for error code from
 devm_mutex_init() call
Message-ID: <ZyMrOiW82OKcBMEi@smile.fi.intel.com>
References: <20241030163139.2111689-1-andriy.shevchenko@linux.intel.com>
 <20241030180921.GA1210204@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030180921.GA1210204@bhelgaas>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Oct 30, 2024 at 01:09:21PM -0500, Bjorn Helgaas wrote:
> On Wed, Oct 30, 2024 at 06:31:39PM +0200, Andy Shevchenko wrote:
> > Even if it's not critical, the avoidance of checking the error code
> > from devm_mutex_init() call today diminishes the point of using devm
> > variant of it. Tomorrow it may even leak something. Add the missed
> > check.
> > 
> > Fixes: 9b3da6e19e4d ("PCI/bwctrl: Add pcie_set_target_speed() to set PCIe Link Speed")
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Squashed into 399ba413fa23 ("PCI/bwctrl: Add pcie_set_target_speed()
> to set PCIe Link Speed"), thanks, Andy.

Thanks, that works for me!

-- 
With Best Regards,
Andy Shevchenko



