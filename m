Return-Path: <linux-pci+bounces-22440-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8067A46104
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 14:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B68E23AEAB6
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 13:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF90218CC10;
	Wed, 26 Feb 2025 13:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K3HOIt5R"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE72154C00;
	Wed, 26 Feb 2025 13:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740577072; cv=none; b=d95t1cVLdMDYOgf07b07eYO6GUqqrHoRIqPrniN7RFAKYTkMmKwgXsdDo6lMWgthuxDDq6bFhxJrC6WS0Z++BPw8m5xvU2Et6WUV9wMnTUaCyIGOivt5WY1DM+9vbXznlGSc8sueBpnx5o9nVm8aAPCCcBA6W9pDDWD4Uy3DOTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740577072; c=relaxed/simple;
	bh=e7ksaBgVZM/n3+KRkzsb8JIum6nQW0z0INzIBzxLwFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iq+x3Wh6u2yb28Umw9HWibwAFiNBzkyMTvMApfDsXkmDGKpmKpQ5qXT0vLgvdxG/bqf6VJ5/BiLNwGtaqLUdSpg46z2FQ5eDptkUiLEotxtLEeMpNMR2684BvnSe6jmfRSI/9ey6I7H8to4dF3+RjBfjPo3ePHrLCGQ5r0/caGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K3HOIt5R; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740577071; x=1772113071;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=e7ksaBgVZM/n3+KRkzsb8JIum6nQW0z0INzIBzxLwFM=;
  b=K3HOIt5RZrR7peYJP6soUi12hpykDgW356qIcWqNrsm7xvLMivQ3clsG
   phWPb5Bl5++MZwN/FdAcJkJ+BeJZNjgrQZRRnPmSO157Iq40atwTHIpFD
   PEJD1LaXXN5L2yQIYcUyJ8Wcydw0TdZJcRbrR2cYfIcB8bBUFK4fLeZ49
   Sj101DbpPREG52ySgUKkHuOhDtB9MqynwIYoF3xhO0+gL481XfUm/f0BN
   OvIB1Mza5oI853x0eiw1j4W4rHYjhRYYaGcwdeV6N+cnmlZfRIJfTVa1G
   w7SRs8UCZSL3WPc/1P1nQDyl2D9UZlhOfVrOqjM51a1jB4zUHaTkoZVNl
   Q==;
X-CSE-ConnectionGUID: +yER9GoXQGW1vfyyPSzhCg==
X-CSE-MsgGUID: gJvLnvBCTru/OvotLTY/Yg==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="52811469"
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="52811469"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 05:37:51 -0800
X-CSE-ConnectionGUID: eQSqF4AvSzmI9Z1mI7/vVQ==
X-CSE-MsgGUID: 4th0tnM9TamQqQ7t3N9YMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="116488206"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa009.jf.intel.com with ESMTP; 26 Feb 2025 05:37:49 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 425DF2FB; Wed, 26 Feb 2025 15:37:47 +0200 (EET)
Date: Wed, 26 Feb 2025 15:37:47 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: brgl@bgdev.pl, Paul Menzel <pmenzel@molgen.mpg.de>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	linux-pci@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: Linux logs new warning `gpio gpiochip0:
 gpiochip_add_data_with_key: get_direction failed: -22`
Message-ID: <Z78ZK8Sh0cOhMEsH@black.fi.intel.com>
References: <9ded85ef-46f1-4682-aabd-531401b511e5@molgen.mpg.de>
 <CAMRc=McJpGMgaUDM2fHZUD7YMi2PBMcWhDWN8dU0MAr911BvXw@mail.gmail.com>
 <36cace3b-7419-409d-95a9-e7c45d335bef@molgen.mpg.de>
 <CAMRc=Mf-ObnFzau9OO1RvsdJ-pj4Tq2BSjVvCXkHgkK2t5DECQ@mail.gmail.com>
 <a8c9b81c-bc0d-4ed5-845e-ecbf5e341064@molgen.mpg.de>
 <CAMRc=MdNnJZBd=eCa5ggATmqH4EwsGW3K6OgcF=oQrkEj_5S_g@mail.gmail.com>
 <CACRpkdZbu=ii_Aq1rdNN_z+T0SBRpLEm-aoc-QnWW9OnA83+Vw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdZbu=ii_Aq1rdNN_z+T0SBRpLEm-aoc-QnWW9OnA83+Vw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 25, 2025 at 10:25:00PM +0100, Linus Walleij wrote:
> On Mon, Feb 24, 2025 at 9:51 AM <brgl@bgdev.pl> wrote:
> 
> > In any case: Linus: what should be our policy here? There are some pinctrl
> > drivers which return EINVAL if the pin in question is not in GPIO mode. I don't
> > think this is an error. Returning errors should be reserved for read failures
> > and so on. Are you fine with changing the logic here to explicitly default to
> > INPUT as until recently all errors would be interpreted as such anyway?
> 
> Oh hm I guess. There was no defined semantic until now anyway. Maybe
> Andy has something to say about it though, it's very much his pin controller.

Driver is doing correct things. If you want to be pedantic, we need to return
all possible pin states (which are currently absent from GPIO get_direction()
perspective) and even though it's not possible to tell from the pin muxer
p.o.v. If function is I2C, it's open-drain, if some other, it may be completely
different, but pin muxer might only guesstimate the state of the particular
function is and I do not think guesstimation is a right approach.

We may use the specific error code, though. and document that semantics.

-- 
With Best Regards,
Andy Shevchenko



