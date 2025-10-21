Return-Path: <linux-pci+bounces-38919-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A1ABF77F5
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 17:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E134819C075A
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 15:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF33C345731;
	Tue, 21 Oct 2025 15:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O8ob5zPF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8F13451C1;
	Tue, 21 Oct 2025 15:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761061756; cv=none; b=Jk7olvlIBJ2t9psNLdvhZB29A8yXOjE4xyNX4XpcvqBLHiUWGY/7zwUNTxBkNexO9g7U3z3GJkeW/UQyQUhlBIuQgta3ScCtGknY53T1GuY2EX9yp15v9+V3fiA+YAY3+FIn5aLiMTGz9FLTX1KgKtV/BTEhAf/ph240LZ8aDHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761061756; c=relaxed/simple;
	bh=mHhFCYFocr+dCFDykT+y2zWggmj42wEC+1dQea38glQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W7lOB5WR6Cq2XdzVUxuGecWQU9m0DWCpKIY+FV8k8yQIKOGD5RS61E7Ww2sbPPwX5tgzyyRcSukAvcTOxoDImSFkb1XfIpQ2+ZPtqOMo6Q+S3wZL5zVWx6if+IG8Lp3Rt8WE+dJjU2NJCuUq4fTAkk1wTbX9nJxj2Fy22DQkyag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O8ob5zPF; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761061755; x=1792597755;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=mHhFCYFocr+dCFDykT+y2zWggmj42wEC+1dQea38glQ=;
  b=O8ob5zPFtZC+I3ZB+PTqeqsy97+di/W6UNjnyEgwrUh9vZRNsoAUPj3X
   TIpXwOwT0M6b9sLM+Uh20s6faI7Yf2lz2TLPlRLhYdKkYwWhTO9nYd6DG
   qGF5OIK5ypDRAngWwYOvZrnpQwes/Xjfp7UixfXA0doxc0HkahaxnbwaI
   tuks8Kr+DzKFUa1mVarVy1+igW4go+TuEFit0QeZqvHC8GJx+oGZt5AqO
   yQUu+C4tfdaFgWkv9oPuGVvxP+aJrcyaviactjzxqeGXBg2y+DP2C1slb
   mjjVC6I0Eo9DRfTvluCib/mkMsvkQ8MrHEr63DUlDTPp4WbyxWeZ+6qSM
   A==;
X-CSE-ConnectionGUID: 0g8k7xB/SyOmcawCtKuAFA==
X-CSE-MsgGUID: o93dCX2iTxmt84niowzjqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="88659475"
X-IronPort-AV: E=Sophos;i="6.19,245,1754982000"; 
   d="scan'208";a="88659475"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 08:49:14 -0700
X-CSE-ConnectionGUID: OxZFyNKdRZ+Nybx76W3mmg==
X-CSE-MsgGUID: mhaXEPUiSDOqEh84c3xYcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,245,1754982000"; 
   d="scan'208";a="187889819"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.148])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 08:49:12 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vBEbl-00000001XBs-08tG;
	Tue, 21 Oct 2025 18:49:09 +0300
Date: Tue, 21 Oct 2025 18:49:08 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>, Rob Herring <robh@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH 0/3] PCI & resource: Make coalescing host bridge windows
 safer
Message-ID: <aPerdPErjXANiBOl@smile.fi.intel.com>
References: <20251010144231.15773-1-ilpo.jarvinen@linux.intel.com>
 <CAMuHMdVwAkC0XOU_SZ0HeH0+oT-j5SvKyRcFcJbbes624Yu9uQ@mail.gmail.com>
 <89a20c14-dd0f-22ae-d998-da511a94664a@linux.intel.com>
 <CAMuHMdUbseFEY8AGOxm2T8W-64qT9OSvfmvu+hyTJUT+WE2cVw@mail.gmail.com>
 <20844374-d3df-cc39-a265-44a3008a3bcb@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20844374-d3df-cc39-a265-44a3008a3bcb@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 21, 2025 at 02:54:03PM +0300, Ilpo Järvinen wrote:
> On Tue, 21 Oct 2025, Geert Uytterhoeven wrote:

...

> I'm sorry, it's indeed a bit confusing as some of these patches never 
> have been in Linus' tree.
> 
> So I'm interested on what's the result with these changes/series together:
> 
> [PATCH 1/2] PCI: Setup bridge resources earlier 
> [PATCH 2/2] PCI: Resources outside their window must set IORESOURCE_UNSET 
> [PATCH 1/1] PCI: rcar-gen2: Add BAR0 into host bridge resources
> [PATCH 1/3] PCI: Refactor host bridge window coalescing loop to use prev 
> [PATCH 2/3] PCI: Do not coalesce host bridge resource structs in place
> [PATCH 3/3] resource, kunit: add test case for resource_coalesce()
> 
> You might also want to change that pci_dbg() in the IORESOURCE_UNSET patch 
> to pci_info() (as otherwise dyndbg is necessary to make it visible).
> 
> Lore links to these series/patches:
> 
> https://lore.kernel.org/linux-pci/20250924134228.1663-1-ilpo.jarvinen@linux.intel.com/
> https://lore.kernel.org/linux-pci/7640a03e-dfea-db9c-80f5-d80fa2c505b7@linux.intel.com/
> https://lore.kernel.org/linux-pci/20251010144231.15773-1-ilpo.jarvinen@linux.intel.com/
> 
> The expected result is that those usb resources are properly parented and 
> the ee080000-ee08ffff and ee090000-ee090bff are not coalesced together (as 
> that would destroy information). So something along the lines of:
> 
>     ee080000-ee08ffff : pci@ee090000

For my pedantic eye, the naming is a bit confusing here. Is this a mistake in
the code or in the example?

>       ee080000-ee080fff : 0000:00:01.0
>         ee080000-ee080fff : ohci_hcd
>       ee081000-ee0810ff : 0000:00:02.0
>         ee081000-ee0810ff : ehci_hcd
>     ee090000-ee090bff : ee090000.pci pci@ee090000


-- 
With Best Regards,
Andy Shevchenko



