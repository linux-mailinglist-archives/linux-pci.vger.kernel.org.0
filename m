Return-Path: <linux-pci+bounces-22444-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B205A46294
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 15:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B81AA170013
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 14:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2686222332E;
	Wed, 26 Feb 2025 14:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iaBdazfQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909F8221F26;
	Wed, 26 Feb 2025 14:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740579733; cv=none; b=IvJSWaKWYKuP9kz1rP/HHkx+AXy6wj0rgjQgnghSVIaJw/SDcA2o+N2Ar1Pvf/uvGuQAsgmZp2i8UEGjxTnOgOtuWYiKXk3Ry1MqR7P8WTGKhhIvecoeU7T48C/9OiGnhD68yTeEovIRchDK5w/BQPySeW8UHdj59J9zVoAZOq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740579733; c=relaxed/simple;
	bh=8/W/lJJ/gLSuYwCP2oFJ++JHvBoSQIUyBFBXlUK8rGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oWCiUobAHOP8U5I2aYgSoAN/Qf3/0zyzuPeVjt26avf6t2poXlbIzxUR4rTlDmb87aCuHrQbcFRc8oevYH2XPinmkDaUIPN+EmgVvWPCTeBlGUf0Lp5s0RtoY0ry/7BI3/HOhl3oD6To57ZHkkQclGEZ15j91nu64RschEZOWZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iaBdazfQ; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740579731; x=1772115731;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=8/W/lJJ/gLSuYwCP2oFJ++JHvBoSQIUyBFBXlUK8rGI=;
  b=iaBdazfQrVP3L0fogk7hGhYJpanw9wdVGeK2kjRt1ZiSk0xJPDPF0Mvn
   RYnseuibjhxyG7a+F+7DQNQFtqamNHiZBIb+ygVBcwdSQ3LfFMVl0cqi3
   TITvknXzr8u2XureumnTO0/qxycsUPWbS61CyDjt33hKKZ0JPQg8vzOZ4
   KE23ZaCbQ3Qm0TVl+TWovHR3AWAxT/MCekQ2lXgBobN+F15rC3uv88SRc
   bF8J3w49QQnEFucd5qJmOfDWGJ4+ZiVmi0WtRECIp8k3b/ICOFdiE8dWi
   vlHAMzG9bdj1OwKNbvurhn/aYk4aGCjvhcwQCGejTYJcTAACGgE2ti9Cb
   A==;
X-CSE-ConnectionGUID: 36Rl/KfNQkCLAD8byX6cZQ==
X-CSE-MsgGUID: 6uzzcpaaQziGXy6ncKkskg==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="41270267"
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="41270267"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 06:22:11 -0800
X-CSE-ConnectionGUID: FwMG1d/BRkOOt7lXFVI5bA==
X-CSE-MsgGUID: M7D6XjDwTQCun3VwDLRArg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120822893"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 06:22:09 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tnIIY-0000000FLUD-2Ze9;
	Wed, 26 Feb 2025 16:22:06 +0200
Date: Wed, 26 Feb 2025 16:22:06 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, brgl@bgdev.pl,
	Paul Menzel <pmenzel@molgen.mpg.de>, linux-gpio@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: Linux logs new warning `gpio gpiochip0:
 gpiochip_add_data_with_key: get_direction failed: -22`
Message-ID: <Z78jjr8LMa165CZP@smile.fi.intel.com>
References: <9ded85ef-46f1-4682-aabd-531401b511e5@molgen.mpg.de>
 <CAMRc=McJpGMgaUDM2fHZUD7YMi2PBMcWhDWN8dU0MAr911BvXw@mail.gmail.com>
 <36cace3b-7419-409d-95a9-e7c45d335bef@molgen.mpg.de>
 <CAMRc=Mf-ObnFzau9OO1RvsdJ-pj4Tq2BSjVvCXkHgkK2t5DECQ@mail.gmail.com>
 <a8c9b81c-bc0d-4ed5-845e-ecbf5e341064@molgen.mpg.de>
 <CAMRc=MdNnJZBd=eCa5ggATmqH4EwsGW3K6OgcF=oQrkEj_5S_g@mail.gmail.com>
 <CACRpkdZbu=ii_Aq1rdNN_z+T0SBRpLEm-aoc-QnWW9OnA83+Vw@mail.gmail.com>
 <Z78ZK8Sh0cOhMEsH@black.fi.intel.com>
 <Z78bUPN7kdSnbIjW@black.fi.intel.com>
 <CACMJSevxA8pC2NTQq3jcKCog+o02Y07gVgQydo19YjC9+5Gs6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACMJSevxA8pC2NTQq3jcKCog+o02Y07gVgQydo19YjC9+5Gs6Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 26, 2025 at 03:14:24PM +0100, Bartosz Golaszewski wrote:
> On Wed, 26 Feb 2025 at 14:47, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Wed, Feb 26, 2025 at 03:37:47PM +0200, Andy Shevchenko wrote:
> > > On Tue, Feb 25, 2025 at 10:25:00PM +0100, Linus Walleij wrote:
> > > > On Mon, Feb 24, 2025 at 9:51 AM <brgl@bgdev.pl> wrote:
> > > >
> > > > > In any case: Linus: what should be our policy here? There are some pinctrl
> > > > > drivers which return EINVAL if the pin in question is not in GPIO mode. I don't
> > > > > think this is an error. Returning errors should be reserved for read failures
> > > > > and so on. Are you fine with changing the logic here to explicitly default to
> > > > > INPUT as until recently all errors would be interpreted as such anyway?
> > > >
> > > > Oh hm I guess. There was no defined semantic until now anyway. Maybe
> > > > Andy has something to say about it though, it's very much his pin controller.
> > >
> > > Driver is doing correct things. If you want to be pedantic, we need to return
> > > all possible pin states (which are currently absent from GPIO get_direction()
> > > perspective) and even though it's not possible to tell from the pin muxer
> > > p.o.v. If function is I2C, it's open-drain, if some other, it may be completely
> > > different, but pin muxer might only guesstimate the state of the particular
> > > function is and I do not think guesstimation is a right approach.
> > >
> > > We may use the specific error code, though. and document that semantics.
> >
> > Brief looking at the error descriptions and the practical use the best (and
> > unique enough) choice may be EBADSLT.
> 
> In any case, I proposed to revert to the previous behavior in
> gpiochip_add_data() in my follow-up series so the issue should soon go
> away.

Yes, I noted. The above is a material to discuss. We can make that semantics
documented and strict and then one may filter out those errors if/when
required.

-- 
With Best Regards,
Andy Shevchenko



