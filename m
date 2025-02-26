Return-Path: <linux-pci+bounces-22441-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96213A4613A
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 14:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A90683AAB3D
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 13:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC9C1DC9BA;
	Wed, 26 Feb 2025 13:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c6tBQvtx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76025DDCD;
	Wed, 26 Feb 2025 13:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740577621; cv=none; b=pgpHuKCwUaczhQUmXYoZxtuBeV24rHRROPwr5yT0B7o3Qg858iAAOAtC9PaqB4dZm3Chv1CVmB9+rMuaX4rNcGjclwp9Lucfmypox49cEZjYlp+9ArCfGs5tlI3Q2SUB6TjHt2TVbXGOU9PoeopjIjooFVnDQGxBqDdG99rZHvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740577621; c=relaxed/simple;
	bh=ghYoPmkesmE/DQEdj+zyBDgNwpAW1ZQ1GHICBwEW7hM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Za0y/mrBzLQonv3WYbyOOaOIp2I9dm9jaK1o3eOLZW6QaovK9SGVuFd71R0rgl2OYkX/SCLOVaF6EtEm3KZuJ8ilSBYE+o/JtCx1Q/SyGoEM/eXZBKWFErvhFE6LXk56u4YPP6FeJEGUaEYs2+PNhHcGcnae9RUnzBor5emo0SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c6tBQvtx; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740577620; x=1772113620;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ghYoPmkesmE/DQEdj+zyBDgNwpAW1ZQ1GHICBwEW7hM=;
  b=c6tBQvtxjF+rPWD2A6yrjdGvEnGkJfmb3XgudjbDDxtMLet63RAL98ws
   CsUwKE2hjZLK1i6ECKVwLCojQ+DR+FNxPsTqUckfg8RhaNsJsXBDnAsTD
   9cHbak6mAD2NCE8nVsjobp1/gBhW67QE9QbRWsm7W2Tv+x3sByqnDPx1c
   K4RNhb3tHogI8GVi7M6Ze7fP5b52nRPEt1BLhNiEzLh4LIXaz7ZlSgUDS
   ZWggx4/pjwekb8QIkqvjusCyLNiC/zD76KLsw+GnfpCdwKl0QLNevQR+e
   UHA9L9wxy77Iwd9+oXexQyCEz0yrHshE6V9VQ+/c2Q2ZQHXu1aXVP8FIX
   A==;
X-CSE-ConnectionGUID: 11BQ+e1eQdW4LNLPAmDH6g==
X-CSE-MsgGUID: XaSWX9BTS7a0+n6hHMm+3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="58840480"
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="58840480"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 05:47:00 -0800
X-CSE-ConnectionGUID: 4yKCyGZwSImGOCOMBTV8JQ==
X-CSE-MsgGUID: c3S/ek64QHmxAkSq+S5Idg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="116895285"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa008.fm.intel.com with ESMTP; 26 Feb 2025 05:46:57 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 61B7E2FB; Wed, 26 Feb 2025 15:46:56 +0200 (EET)
Date: Wed, 26 Feb 2025 15:46:56 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: brgl@bgdev.pl, Paul Menzel <pmenzel@molgen.mpg.de>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	linux-pci@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: Linux logs new warning `gpio gpiochip0:
 gpiochip_add_data_with_key: get_direction failed: -22`
Message-ID: <Z78bUPN7kdSnbIjW@black.fi.intel.com>
References: <9ded85ef-46f1-4682-aabd-531401b511e5@molgen.mpg.de>
 <CAMRc=McJpGMgaUDM2fHZUD7YMi2PBMcWhDWN8dU0MAr911BvXw@mail.gmail.com>
 <36cace3b-7419-409d-95a9-e7c45d335bef@molgen.mpg.de>
 <CAMRc=Mf-ObnFzau9OO1RvsdJ-pj4Tq2BSjVvCXkHgkK2t5DECQ@mail.gmail.com>
 <a8c9b81c-bc0d-4ed5-845e-ecbf5e341064@molgen.mpg.de>
 <CAMRc=MdNnJZBd=eCa5ggATmqH4EwsGW3K6OgcF=oQrkEj_5S_g@mail.gmail.com>
 <CACRpkdZbu=ii_Aq1rdNN_z+T0SBRpLEm-aoc-QnWW9OnA83+Vw@mail.gmail.com>
 <Z78ZK8Sh0cOhMEsH@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z78ZK8Sh0cOhMEsH@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 26, 2025 at 03:37:47PM +0200, Andy Shevchenko wrote:
> On Tue, Feb 25, 2025 at 10:25:00PM +0100, Linus Walleij wrote:
> > On Mon, Feb 24, 2025 at 9:51 AM <brgl@bgdev.pl> wrote:
> > 
> > > In any case: Linus: what should be our policy here? There are some pinctrl
> > > drivers which return EINVAL if the pin in question is not in GPIO mode. I don't
> > > think this is an error. Returning errors should be reserved for read failures
> > > and so on. Are you fine with changing the logic here to explicitly default to
> > > INPUT as until recently all errors would be interpreted as such anyway?
> > 
> > Oh hm I guess. There was no defined semantic until now anyway. Maybe
> > Andy has something to say about it though, it's very much his pin controller.
> 
> Driver is doing correct things. If you want to be pedantic, we need to return
> all possible pin states (which are currently absent from GPIO get_direction()
> perspective) and even though it's not possible to tell from the pin muxer
> p.o.v. If function is I2C, it's open-drain, if some other, it may be completely
> different, but pin muxer might only guesstimate the state of the particular
> function is and I do not think guesstimation is a right approach.
> 
> We may use the specific error code, though. and document that semantics.

Brief looking at the error descriptions and the practical use the best (and
unique enough) choice may be EBADSLT.

-- 
With Best Regards,
Andy Shevchenko



