Return-Path: <linux-pci+bounces-2402-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3E58355DE
	for <lists+linux-pci@lfdr.de>; Sun, 21 Jan 2024 13:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C987D28260D
	for <lists+linux-pci@lfdr.de>; Sun, 21 Jan 2024 12:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EDA37160;
	Sun, 21 Jan 2024 12:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ha66Y0t7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8FC374F6;
	Sun, 21 Jan 2024 12:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705841808; cv=none; b=ESCw3V1SwHwG2WcGtLJDfNDbIflqpjElm2m/V6f1ef/Z48+40+R2kwfLFGJNThcIlg1HaWwmXTQVLNzsyKWHi3DujCJnwlw+03U9cf5NEvu+brtgT+lwb/PKuj9r8uhdhPStvul0fnqQHQQYsU03RyF9XGiy7qIeqkIYdqMvY5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705841808; c=relaxed/simple;
	bh=fqnJQd5v7IgutzkZmXKHrUcc2q4SuwDE1rYHm4q5AfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nxkkY3esK3z5iDItd8BdPS56mo3t39fzgNCoalgSOYNBmP/F4wU95Sjz/NIMAzo+Ht3UIOtqF/lzjiXlHeyhr6cCWUX6dL2cL7w8CH2CZbqb0aJdt+UQpmQZFHzD97INhnrq1g1PrNY55LDUCl4mQ9IqqJ2SlhUt/+yaCbnwzmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ha66Y0t7; arc=none smtp.client-ip=192.55.52.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705841806; x=1737377806;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=fqnJQd5v7IgutzkZmXKHrUcc2q4SuwDE1rYHm4q5AfI=;
  b=Ha66Y0t7sDQ/ew5eL3OkXvc07elYDoUDw3nnAoReGgBOacqfSWzac2oB
   itlDwwyNOFHmHH76vgotkLygljvclaG9/gRIwYLL6twRWXqabaro20rTv
   Hl6K9/UkrfuGAfyDQuVBjtAu8MkVfapsa0w4116blQL22yFgwCVm1KgB0
   HyxBrHi7yvswRv8ORmVfFw0R4Ghh8zxmv3yMRdUga+RduKpqHc5oHI0ZX
   ty94XLlYlXd3zPo1RoNZf/5R3rwr5vRHEP1mDixnHUjqjuxLy1RzEjnSV
   R2w+rxPvD5x0/+UchgrQqFw7jAucD1o9lOoJzet63avYYprSstFuZsHEV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10959"; a="398185471"
X-IronPort-AV: E=Sophos;i="6.05,209,1701158400"; 
   d="scan'208";a="398185471"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2024 04:56:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10959"; a="875746382"
X-IronPort-AV: E=Sophos;i="6.05,209,1701158400"; 
   d="scan'208";a="875746382"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2024 04:56:41 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rRXLC-0000000Fcpa-2G6J;
	Sun, 21 Jan 2024 14:54:22 +0200
Date: Sun, 21 Jan 2024 14:54:22 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Woithe <jwoithe@just42.net>
Cc: Igor Mammedov <imammedo@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Lukas Wunner <lukas@wunner.de>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] PCI: Solve two bridge window sizing issues
Message-ID: <Za0T_siv79qz1jkk@smile.fi.intel.com>
References: <20231228165707.3447-1-ilpo.jarvinen@linux.intel.com>
 <20240104131210.71f44d4b@imammedo.users.ipa.redhat.com>
 <ZZaiLOR4aO84CG2S@marvin.atrad.com.au>
 <ZZ+gEmxI/TxdbmyQ@marvin.atrad.com.au>
 <ZajJzcquyvRebAFN@marvin.atrad.com.au>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZajJzcquyvRebAFN@marvin.atrad.com.au>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Jan 18, 2024 at 05:18:45PM +1030, Jonathan Woithe wrote:
> On Thu, Jan 11, 2024 at 06:30:22PM +1030, Jonathan Woithe wrote:
> > On Thu, Jan 04, 2024 at 10:48:53PM +1030, Jonathan Woithe wrote:
> > > On Thu, Jan 04, 2024 at 01:12:10PM +0100, Igor Mammedov wrote:
> > > > On Thu, 28 Dec 2023 18:57:00 +0200
> > > > Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> wrote:
> > > > 
> > > > > Hi all,
> > > > > 
> > > > > Here's a series that contains two fixes to PCI bridge window sizing
> > > > > algorithm. Together, they should enable remove & rescan cycle to work
> > > > > for a PCI bus that has PCI devices with optional resources and/or
> > > > > disparity in BAR sizes.
> > > > > 
> > > > > For the second fix, I chose to expose find_empty_resource_slot() from
> > > > > kernel/resource.c because it should increase accuracy of the cannot-fit
> > > > > decision (currently that function is called find_resource()). In order
> > > > > to do that sensibly, a few improvements seemed in order to make its
> > > > > interface and name of the function sane before exposing it. Thus, the
> > > > > few extra patches on resource side.
> > > > > 
> > > > > Unfortunately I don't have a reason to suspect these would help with
> > > > > the issues related to the currently ongoing resource regression
> > > > > thread [1].
> > > > 
> > > > Jonathan,
> > > > can you test this series on affected machine with broken kernel to see if
> > > > it's of any help in your case?
> > > 
> > > Certainly, but it will have to wait until next Thursday (11 Jan 2024).  I'm
> > > still on leave this week, and when at work I only have physical access to
> > > the machine concerned on Thursdays at present.
> > > 
> > > Which kernel would you prefer I apply the series to?
> > 
> > I was very short of time today but I did apply the above series to the
> > 5.15.y branch (since I had this source available), resulting in version
> > 5.15.141+.  Unfortunately, in the rush I forgot to do a clean after the
> > bisect reset, so the resulting kernel was not correctly built.  It booted
> > but thought it was a different version and therefore none of the modules
> > could be found.  As a result, the test is invalid.
> > 
> > I will try again in a week when I next have physical access to the system. 
> > Apologies for the delay.  In the meantime, if there's a specific kernel I
> > should apply the patch series against please let me know.  As I understand
> > it, you want it applied to one of the kernels which failed, making 5.15.y
> > (for y < 145) a reasonable choice.
> 
> I did a "make clean" to reset the source tree and recompiled.  However, it
> errored out:
> 
>   drivers/pci/setup-bus.c:988:24: error: ‘RESOURCE_SIZE_MAX’ undeclared
>   drivers/pci/setup-bus.c:998:17: error: ‘pci_bus_for_each_resource’ undeclared
> 
> This was with the patch series applied against 5.15.141.  It seems the patch
> targets a kernel that's too far removed from 5.15.x.
> 
> Which kernel would you like me to apply the patch series to and test?

The rule of thumb is to test against latest vanilla (as of today v6.7).
Also makes sense to test against Linux Next. The v5.15 is way too old for
a new code.

-- 
With Best Regards,
Andy Shevchenko



