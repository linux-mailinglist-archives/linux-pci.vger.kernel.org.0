Return-Path: <linux-pci+bounces-27911-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2EDABAB29
	for <lists+linux-pci@lfdr.de>; Sat, 17 May 2025 18:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16F23189FC71
	for <lists+linux-pci@lfdr.de>; Sat, 17 May 2025 16:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45292116FB;
	Sat, 17 May 2025 16:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lZIE8dcM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D30D210F4D;
	Sat, 17 May 2025 16:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747499566; cv=none; b=UG93aVCE8aJd3ipjoOOud3skAcGDYcwdciE/3Yn7bUznFPwuO4BVMgN2pVe1PtC/ZjJzMU00o+nY2Az5FvSiklBAl8Bx7eQE84BXewSExD25YZT5/3y+th0lwh/ryhr90InMU+AwFm9MBkxP6UU/jYf8yGIw1CI0LCy6/Q4kubU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747499566; c=relaxed/simple;
	bh=jiU6fKogEnB2KRfyvkptRXP4LM/NoQwweDs9RAUuC/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fApBUWWl2k0/yZ1OksBmZopn+BB32h+13LwHgQnsNXNdNaEblmPyVSh8emAK5lI5JPPkHMbPgBVijxZvXnaMAQBIdQZ0+jzuvf41MsiBr+ir8ZquGju9AecJDwPZIExCf6SxnZ6NHI9NCE8d25EhMfOFE6+pnW3+FrxFjqLaaYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lZIE8dcM; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747499565; x=1779035565;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=jiU6fKogEnB2KRfyvkptRXP4LM/NoQwweDs9RAUuC/E=;
  b=lZIE8dcMw9IZ1rciiXA4jTAJYRWtFkw5JNjLqwuLwNDS5RBSw7tSOUe4
   1zU2PrG67oTvFRRlHUzBjOX7w11M6wSMfodRBy9pvyXPRsLNM0N/KS/fl
   lDZLOmIdJtHdOJe1Jwkgqmz0Z8+ys6fPHPwettNturM1NapbwOKdcFCRW
   xa9WZ8dsHLGZQFE5zyc8EcE9PnhHRZvIjTMxOIWK9tEV/s2T80TYGvbB8
   noVAn9t/pAmxvm5pI6QLCRV+iWy3vE43GO3+R3xgv++7wrUkV7a2hKlCK
   9nqSP4hPTxZ5DN2g1bu5pEVsfwyMg1rzb2R63zLtyQXGiHpLw1dQoqsRY
   Q==;
X-CSE-ConnectionGUID: orcJ99b3TTqEPCtFnqHHPw==
X-CSE-MsgGUID: +/yVzFGcQBa8RGD4U6kljg==
X-IronPort-AV: E=McAfee;i="6700,10204,11436"; a="37070412"
X-IronPort-AV: E=Sophos;i="6.15,297,1739865600"; 
   d="scan'208";a="37070412"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2025 09:32:43 -0700
X-CSE-ConnectionGUID: rI4RBh/VQXeMmugKSp9TYA==
X-CSE-MsgGUID: 9w+JebZKRuKF18fyDX/7xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,297,1739865600"; 
   d="scan'208";a="143755308"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2025 09:32:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uGKSj-00000002TiM-1mVd;
	Sat, 17 May 2025 19:32:37 +0300
Date: Sat, 17 May 2025 19:32:37 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc: phasta@kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mark Brown <broonie@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	Yang Yingliang <yangyingliang@huawei.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/7] Docu: PCI: Update pcim_enable_device()
Message-ID: <aCi6Jf-A2gO1WQ_u@smile.fi.intel.com>
References: <20250515124604.184313-2-phasta@kernel.org>
 <20250515124604.184313-4-phasta@kernel.org>
 <aCXk2eDUJF2UbQ47@smile.fi.intel.com>
 <e44d880e842440d51c14f38df1d20176694e0d57.camel@mailbox.org>
 <20250516132811.GB2390647@rocinante>
 <2e80298be4bcb6b17f5b38302d6945306928c6b0.camel@mailbox.org>
 <20250516134839.GA3308019@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250516134839.GA3308019@rocinante>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, May 16, 2025 at 10:48:39PM +0900, Krzysztof Wilczyński wrote:

[...]

> > > Has Andy been sending his review off-list?  Or something is broken on
> > > my side...
> > 
> > Nope, it's on-list. Andy's a veteran ;-)
> > 
> > https://lore.kernel.org/linux-pci/aCXnPHy5heHCKVd_@smile.fi.intel.com/
> 
> Thank you!
> 
> I should have checked on lore, too.  Time to move to lei, I suppose...

I need to setup DKIM, that's might be the reason you got it in the SPAM folder.

-- 
With Best Regards,
Andy Shevchenko



