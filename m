Return-Path: <linux-pci+bounces-42958-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31291CB6092
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 14:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F68E3045A76
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 13:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAAB313537;
	Thu, 11 Dec 2025 13:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KA7o499f"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4402FD7D5;
	Thu, 11 Dec 2025 13:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765459933; cv=none; b=lCNoKXiH4pQVBfnE8ZE0+Ug7mFkOuCJN0nk4cfGAOnN+EAuzciqL5ayxJiscAPHbfEjV/nHWM8ifLHXVMz5YKbbNqrKvXgQCoFntbogpX9uz5EHBVBQ/wtjRklN/oEWO0MGF6bpe840Kar9I/w/inSAuu6PPwOVPBfNtN3J2A+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765459933; c=relaxed/simple;
	bh=4Kl5caZ4+AMnQcEDyOlthQs+6DsrPGeFwcZXzDc+w5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PCKXMHY/s2A0T17atWyWMVpdA9rl3qO0mR1Xs72NLTbHcjfPeI3jL9lUCav0hKXfg0pg7x5+0ZKVXOGS19ma8XZFUGDzPdWaSZIbyeGLW+qux106fveuo75ZKjHhZwf/FXcEIV8ynFpJ/k6x4taFvt8GilnRA+6wNZoHCIuBlPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KA7o499f; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765459932; x=1796995932;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4Kl5caZ4+AMnQcEDyOlthQs+6DsrPGeFwcZXzDc+w5U=;
  b=KA7o499fbjdPpsoVmVD6M+HEv1eQneGK+h/NgM8HbNexqNrO61XggHXh
   XyjI75UgiG+nlYMqX7jKcXRxmsrCVZ06BKmaTEEoMAhfsn+/S2qQfBrpe
   LctdF6wN6Z722XasJJOzIL7ZGqIwUfCFYJ2l2+mUzxR5MQtXt75vmcBOM
   qnoFFV6eNDSa9rSfSB2jp22ULh2c1V0OqFhGvR5AkaZp8iQCVlVSTC7dL
   7HvnKfHO4KkhdYyYJFfBUx/2AdCDX9XLBg+Z1al0orRHTg72QR6XTILp5
   qbpKDSSXT52sFkqsMrPAWk16ASqJnzOvCaatST3sDdhcaymU6Dzb9z0Ob
   g==;
X-CSE-ConnectionGUID: b3YgipotQQCdaacxNzp13A==
X-CSE-MsgGUID: wd3zx8VkRbKYtjNlTwtXDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="71064144"
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; 
   d="scan'208";a="71064144"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 05:32:12 -0800
X-CSE-ConnectionGUID: BXtI3yRlSHqhvgFGmUsgeQ==
X-CSE-MsgGUID: D+xGoUtERk+s+Q/nlumuPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; 
   d="scan'208";a="227452347"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.250])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 05:32:08 -0800
Date: Thu, 11 Dec 2025 15:32:04 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Liam Girdwood <liam.r.girdwood@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Daniel Baluta <daniel.baluta@nxp.com>, Takashi Iwai <tiwai@suse.de>,
	Mark Brown <broonie@kernel.org>,
	Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= <amadeuszx.slawinski@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org, sound-open-firmware@alsa-project.org
Subject: Re: [PATCH v1 1/1] ASoC: Fix acronym for Intel Gemini Lake
Message-ID: <aTrH1H4otA-cQyXa@smile.fi.intel.com>
References: <20251210115545.3028551-1-andriy.shevchenko@linux.intel.com>
 <2b05635f-560b-45a2-87fb-670c144b6be2@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b05635f-560b-45a2-87fb-670c144b6be2@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Dec 11, 2025 at 09:45:54AM +0100, Cezary Rojewski wrote:
> On 2025-12-10 12:55 PM, Andy Shevchenko wrote:
> > While the used GML is consistent with the pattern for other Intel * Lake
> > SoCs, the de facto use is GLK. Update the acronym and users accordingly.
> > 
> > Note, a handful of the drivers for Gemini Lake in the Linux kernel use
> > GLK already (LPC, MEI, pin control, SDHCI, ...) and even some in ASoC.
> > The only ones in this patch used the inconsistent one.
> 
> A number of times I've fought for the 'GLK' to disappear from the Intel's
> audio subsystem as clearly the "right" shortcut is 'GML'.

Probably you were late as that boat sailed and we have the only your
driver (and SOF which was put into position to reuse the existing ID)
use the correct acronym.

> However, I do understand where are you coming from - the corrections came
> late and the "mistake" has been widely spread.

Yeah... With all understanding and support for the correctness, the easiest
way to get rid of inconsistency is to change only these couple of drivers
and not the entire world.

...

> > -#define PCI_DEVICE_ID_INTEL_HDA_GML	0x3198
> > +#define PCI_DEVICE_ID_INTEL_HDA_GLK	0x3198
> 
> If two #defines are no-go (PCI_DEVICE_ID_INTEL_HDA_GLK and _GML), then
> perhaps at least a comment to the right of the ID mentioning the "GML" would
> help.

Bjorn, are you agree on adding a comment to PCI IDs to point out that in a
couple of Intel documents the machine's acronym is GML?

...

> > --- a/sound/soc/intel/avs/board_selection.c
> > +++ b/sound/soc/intel/avs/board_selection.c

> > -	AVS_MACH_ENTRY(HDA_GML,		avs_gml_i2s_machines),
> > +	AVS_MACH_ENTRY(HDA_GLK,		avs_glk_i2s_machines),
> 
> To be honest, I'd leave 'avs_gml_i2s_machines' as is.

Sure, your driver your rules :), I will not touch that in v2.

-- 
With Best Regards,
Andy Shevchenko



