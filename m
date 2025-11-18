Return-Path: <linux-pci+bounces-41498-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D39F9C69729
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 13:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id CA3FE2AB53
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 12:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA43C324B09;
	Tue, 18 Nov 2025 12:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="er5T6IQh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33D7347BA3;
	Tue, 18 Nov 2025 12:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763469751; cv=none; b=mwPG01MEE1hMVnPtXoYh5Zq1FOAMLptmJCc9c1C+aw9aN4eU4OGHuA3Vae1hRc/lYmsgfgHtHXOcI8hPmUXGYY+/kXqkRM1cI46SBPj50edQlaC/SYPs9E02tWQmooj2vk75aGgkmd54YfioPkviTWgERI2jYNdXKfSbWf79NpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763469751; c=relaxed/simple;
	bh=omW4v+Tc3Le2QAQshFJbpuP+L60KdBKt3nR18RcALXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EAtZhO6UKX7unXP5pUf/QGcjOcXs74L0b4CuZngYCyQLkTwRBDYK9WbcmbKFofeW9Vn0ot3rEa44/Hljt2EqknUJons/ihhBEfFn8R7jKSaKPw59py8i60evsV9qm+V1cdZ6dkOtudaW/NCow3tuucvAf+qNAE40KYqxqm4InWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=er5T6IQh; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763469750; x=1795005750;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=omW4v+Tc3Le2QAQshFJbpuP+L60KdBKt3nR18RcALXs=;
  b=er5T6IQheD8bv4BMG5u1bH5Qp8IfQToj3zLapMDp+McOBBH277Pe/Phu
   cgjLUQfPaV2t9CZNeY+c+23gXr76kdrgemvhmQUnygMasEzUvW3I0vi2w
   GDzv2MuIGhOZai+BhXZ/PnzqtQK+OdKc17nD0bG3O9uKzutB20SKF924c
   Qj911MKDVMhloWikitkVHfPsCSAXElraGrBx+r28m5y25yXoQi4cfDxwe
   5uD2SCphLn+/Wh+iu4EqpgdWTI4A2wNYFbR5S3+Ga+oAnZy++igj/HPtw
   ipUNgSj4F0P+uSC34sNn4m0WeR1KxAWNixZTRvn2sPePZVTKmkEMc/Rcn
   w==;
X-CSE-ConnectionGUID: P5SQNxeWSiuqLgkw6aR6yw==
X-CSE-MsgGUID: U3xHq0ToTDG1QFpiCqSbPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="65369814"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="65369814"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 04:42:29 -0800
X-CSE-ConnectionGUID: O+PKAPd1TESN5U62SXzP0A==
X-CSE-MsgGUID: EmcXUBzwSMyUDkqlVl+y7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="221655749"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa001.fm.intel.com with ESMTP; 18 Nov 2025 04:42:26 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 78E0098; Tue, 18 Nov 2025 13:42:25 +0100 (CET)
Date: Tue, 18 Nov 2025 13:42:25 +0100
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Jonathan Cameron <jic23@kernel.org>
Cc: Christian Bruel <christian.bruel@foss.st.com>,
	linux-pci@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Subject: Re: [PATCH v2 1/1] PCI: stm32: Don't use "proxy" headers
Message-ID: <aRxpsc02hGW1w_hu@black.igk.intel.com>
References: <20251114185534.3287497-1-andriy.shevchenko@linux.intel.com>
 <20251117204348.GA2522408@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251117204348.GA2522408@bhelgaas>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Nov 17, 2025 at 02:43:48PM -0600, Bjorn Helgaas wrote:
> On Fri, Nov 14, 2025 at 07:52:01PM +0100, Andy Shevchenko wrote:
> > Update header inclusions to follow IWYU (Include What You Use)
> > principle.
> > 
> > In particular, replace of_gpio.h, which is subject to remove by the GPIOLIB
> > subsystem, with the respective headers that are being used by the driver.
> 
> Thanks, Andy!  It looks like a lot of work to figure this out by hand.

True.

> Is there a tool to figure this out?  Maybe something I could run when
> reviewing patches?

I have a déjà vu answering this question. Was it you last time who asked
the same?

The tool is iwyu which is heavily tuned for the kernel use by Jonathan (Cc'ed).
But I do it manually.

> IWYU seems like a nice principle but I couldn't find any mention in
> Documentation/.  Should it be covered there somehow?

Perhaps. Maybe we can start with IIO, where it's a highly recommended thing
for the new code submissions.

-- 
With Best Regards,
Andy Shevchenko



