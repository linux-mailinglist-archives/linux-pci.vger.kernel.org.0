Return-Path: <linux-pci+bounces-3446-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B5A8549EB
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 14:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F21A1F25061
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 13:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA95052F9F;
	Wed, 14 Feb 2024 13:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WgiA1xJc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3183352F6E;
	Wed, 14 Feb 2024 13:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707915698; cv=none; b=gERNn1oOqm/EiDoVoE6m8PXiHv5VkdTjzsbbXwwp0UrPUiguUx1XXDsmkCbPbmwBxMPYNUSbeCMq616AhOtjTvSCo0O7iIXIE8TwVe80ey3YerNIBQS/EuvwdcXN9HHsNyMirDZpRMyVisZEbNywdUD10V53X08xIE58SKX8pVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707915698; c=relaxed/simple;
	bh=UTA/0dr5RgWO2sHiI40Q/d9Q5m5+NjUgM/xZY5lfqcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AJJ+X/6AgClrTPVxll1rZobgee2iGzlYhDybnBbl0yJnNt82v+4Goo9QSH8auJxHlf85ldOFSG2jvXnqn5XuyoW02MUhVhNIKtnsYoff04V8qN3f/i+cSy/wZ+EqPYp56PaBmhe5Oe5JjdsnBTGfJddjx1ZJ5GvR+CiiIHYBSWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WgiA1xJc; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707915697; x=1739451697;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UTA/0dr5RgWO2sHiI40Q/d9Q5m5+NjUgM/xZY5lfqcA=;
  b=WgiA1xJcU1VtS51r8hAt2p84H4fEbCz+8FwtheEKCttQPNXpm3kCXXft
   UQ2wmcndvZGdHyRB1GjpNtVL8GddFzPTCj6U5W6+GRSODpsxVfmlXEOze
   sEV9CJU2uinr5zopiK0Zgpo+gRB42XGHZiM38kwRlCw71/gCEqI7YbDFS
   VcRvvsRwVCEbo0JMf6Y1tTU7Jjql6ct2ll/lvqaqyGXS9pbDDyxoAgCiB
   /Lngyft+pKmNbdnmuGhIXHmmoJ4bwlYkAw4M/CoebxR/+yPJH4X09VEeX
   Wd82loC61qEA0fh0YY1hJ33mWrt8kwOCSrjD+e759JCoQB0QAV139N/aK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="1810745"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="1810745"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 05:01:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="912084251"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="912084251"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 05:01:32 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1raEtG-00000004Ui2-0nGZ;
	Wed, 14 Feb 2024 15:01:30 +0200
Date: Wed, 14 Feb 2024 15:01:29 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, bhelgaas@google.com,
	jarkko.nikula@linux.intel.com, mika.westerberg@linux.intel.com,
	stanislaw.gruszka@linux.intel.com, lukas@wunner.de,
	rafael@kernel.org, ilpo.jarvinen@linux.intel.com,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
	sashal@kernel.org
Subject: Re: [PATCH v1] PCI / PM: Really allow runtime PM without callback
 functions
Message-ID: <Zcy5qZ4rEbpY7ouC@smile.fi.intel.com>
References: <20240212063233.5599-1-raag.jadav@intel.com>
 <20240213200648.GA1219964@bhelgaas>
 <ZcyZV2q1_QoK43vz@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcyZV2q1_QoK43vz@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 14, 2024 at 12:43:35PM +0200, Raag Jadav wrote:
> On Tue, Feb 13, 2024 at 02:06:48PM -0600, Bjorn Helgaas wrote:
> > On Mon, Feb 12, 2024 at 12:02:33PM +0530, Raag Jadav wrote:

...

> > >  0)               |  pm_runtime_work() {
> > >  0)               |    rpm_idle() {
> > >  0)               |      rpm_check_suspend_allowed() {
> > >  0)   1.500 us    |        __dev_pm_qos_resume_latency(); /* = 0x7fffffff */
> > >  0)   4.840 us    |      } /* rpm_check_suspend_allowed = 0x0 */
> > >  0)   1.550 us    |      __rpm_get_callback(); /* = 0xffffffffb4bc84f0 */
> > >  0)   1.800 us    |      pci_pm_runtime_idle(); /* = -38 */
> > >  0) + 17.070 us   |    } /* rpm_idle = -38 */
> > >  0) + 22.450 us   |  } /* pm_runtime_work = -38 */
> > 
> > What is this timing information telling me?
> 
> It's a raw ftrace dump.

(Told ya that people would be surprised with this without seeing how you get
 this and what fields mean)

-- 
With Best Regards,
Andy Shevchenko



