Return-Path: <linux-pci+bounces-43802-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61238CE6F43
	for <lists+linux-pci@lfdr.de>; Mon, 29 Dec 2025 15:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62EB130141E7
	for <lists+linux-pci@lfdr.de>; Mon, 29 Dec 2025 13:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CC031961F;
	Mon, 29 Dec 2025 13:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b7tW8joq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF5822A4EB;
	Mon, 29 Dec 2025 13:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767016783; cv=none; b=fg5UELrrQhNuyVH7GfX2c054NYipMIturvjB5Aqc5cz2q5gu4uz09HcY6xT5mHKnf9iZ5dXdR7iPEqQzHH/3FdguLK4hkOul2xjxHMsurnG22pIMyhNewrv3R0+1HQszQEiZNHlz68BIdaADYwiM72vGOWkWIxrZT6DsU5dxPQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767016783; c=relaxed/simple;
	bh=YgeKsqSmq+b3p5O+F/5daCRKQroduLfvCONtedqFWvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d5XIlcBw1RO4dJSmMKXtby57hQ5KmH1eehHMhMpkEK8TTrk4cxiQPMjf8r2GtVNl8FGifV4p+3QnkbTnqlKo9oJhhKDty3Iu1oH2+dX3TgGIUN2+V8t9GxRMot4AYVaNzsR21MI60THqINbHogeOucLdj8d5p3u/1PDtLUq5mG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b7tW8joq; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767016782; x=1798552782;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=YgeKsqSmq+b3p5O+F/5daCRKQroduLfvCONtedqFWvs=;
  b=b7tW8joqMqpQvfH+nHFlsOeVYaSC6aKDmKrEBKERcQpLTvZa4vDr0f3G
   RE/LoAA6VARapQjrl8TOHSsE3jW8OJ3MOGJOWyguY+zypdfR0fDoT0RNC
   2vfN8aL2N44h7g4rqtGMYe6vvmkhP54L7EZ+unzgFvxVE9f/v6LFnlI56
   ZhK/7F1NLdVr7aRe+b+BNmmm0bnWWDZV+EgdCUTCt0Os5TE+NC9z8+mHi
   c//TbRzpDCLObp30XR8+M3cwGaMpBg8l4qz0lf7qaYIuJncJMvtrR/69m
   TQabYvhb0D0WzNd0NjMzsAcBep0nIZFdpb0ZWE/mtGJFWg7sI55fi1mRz
   Q==;
X-CSE-ConnectionGUID: CKUhoaBbSPebrDIY85VNng==
X-CSE-MsgGUID: Hfqn28XVTK20au0bdVJjtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11656"; a="79256732"
X-IronPort-AV: E=Sophos;i="6.21,186,1763452800"; 
   d="scan'208";a="79256732"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2025 05:59:41 -0800
X-CSE-ConnectionGUID: X4wh6Y99Q4WOhY5DMMfHJA==
X-CSE-MsgGUID: pwrvkKiRREKv1c6rewuDHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,186,1763452800"; 
   d="scan'208";a="205450092"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.31])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2025 05:59:38 -0800
Date: Mon, 29 Dec 2025 15:59:35 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
	Chen Yu <yu.c.chen@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Alex Hung <alexhung@gmail.com>, Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org,
	AceLan Kao <acelan.kao@canonical.com>
Subject: Re: [PATCH v1 2/4] platform/x86/intel/hid: Stop creating a platform
 device
Message-ID: <aVKJR2jZf7JAEuIv@smile.fi.intel.com>
References: <7888874.EvYhyI6sBW@rafael.j.wysocki>
 <6115868.MhkbZ0Pkbq@rafael.j.wysocki>
 <aVGBW4UcRAaxtbCX@smile.fi.intel.com>
 <CAJZ5v0gyhVFA65YCqrz7WiY=4H+dhKb6FYMo06sU-hF=4fLS4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gyhVFA65YCqrz7WiY=4H+dhKb6FYMo06sU-hF=4fLS4Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Dec 29, 2025 at 02:07:23PM +0100, Rafael J. Wysocki wrote:
> On Sun, Dec 28, 2025 at 8:13 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, Dec 15, 2025 at 02:35:05PM +0100, Rafael J. Wysocki wrote:

...

> > >       .remove = intel_hid_remove,
> > >  };
> >
> > This blank line now can also be removed as the module_platform_driver() coupled
> > with the above structure initialiser.

> Feel free to send a patch to remove it then, perhaps along with the
> one in the other driver.

If it's already applied the mention change would be just a churn, no need to
bother with it.

-- 
With Best Regards,
Andy Shevchenko



