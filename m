Return-Path: <linux-pci+bounces-42962-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B32C3CB624E
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 15:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2C1083001812
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 14:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4EA280325;
	Thu, 11 Dec 2025 14:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DZjz270Z"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0432C15A8
	for <linux-pci@vger.kernel.org>; Thu, 11 Dec 2025 14:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765462061; cv=none; b=PH8isbrjLsxyXFMCcK2/EwkDxzmPtTN2UC/D8dWTxJUoNy5BBhtbmpMaj3z5jbc7ISRTpfZv+0QJ4IGFQO4IFPHuULUmtI7wm6ILxWEt+UowiQrN6Ce4yBKnxrBmMvfHUWYmNIqrlUqH1/YAALMX2lZ898Mp8c5QgPwBQzPNM5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765462061; c=relaxed/simple;
	bh=zrC8SpJrdpWF+F76wXVYETiUP/VUFBCWdbvu//4h4Wo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+F5qssMLNuKvTJmQYiJ99ayWCNODwSkerTUnbG/SplVLlNIw62NPcRzXc2Q/Dq/bjRX3N+cX7HWZRUE/DUleAzbKh0EasjdTwTNnIA1j7FoLhztPlFX2E6QwTT2xXK0zhyYoromg/xJpfEs4WJEx6YkPQ+GZtf+sOoxeDNh10I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DZjz270Z; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765462060; x=1796998060;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zrC8SpJrdpWF+F76wXVYETiUP/VUFBCWdbvu//4h4Wo=;
  b=DZjz270ZaJPGNrhCVpIVYqQbAYCnUQginFzDFmXcPRjVhNMYgzdM08ZI
   F6YUEzCbpWggqXmFsPEsYCuZJ8IIg00b4I38bPgR2zIe2TYIs7w/4cF3w
   WbrZC05TCLogMxaKW5g490tzccxsL5kcRclHSz6/xVvcV9uoIau07pNHc
   W77UJTeO8cZsrAVnDEaujNQF5eVKEtoS0p242zzboU9KUPAmjIg1DTcVo
   G3nx9SivYUSLim9YLekL+ely9VcY6M9tQulBQ/YW/z0R/eNJG+gtffg0t
   QJINMZzOZnVWcuCzKntA5NXkhoeeEFhwAU0nuTmiQNyMX/lxmal9/m7at
   w==;
X-CSE-ConnectionGUID: n+6vh0VlQ52hMWXQEFK4BQ==
X-CSE-MsgGUID: FuXMZco9Sl+FQYMJPbIDhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="90090914"
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; 
   d="scan'208";a="90090914"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 06:07:39 -0800
X-CSE-ConnectionGUID: 0OQFD5AySN2rUS2/KF0RDg==
X-CSE-MsgGUID: BT29SZpdR/q5iVaEZVF1zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; 
   d="scan'208";a="220178269"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.250])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 06:07:37 -0800
Date: Thu, 11 Dec 2025 16:07:35 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v9 2/2] PCI: Check rom header and data structure addr
 before accessing
Message-ID: <aTrQJ3HuTIlpRwmO@smile.fi.intel.com>
References: <20251211125906.57027-1-kanie@linux.alibaba.com>
 <20251211125906.57027-3-kanie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251211125906.57027-3-kanie@linux.alibaba.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Dec 11, 2025 at 08:59:06PM +0800, Guixin Liu wrote:
> We meet a crash when running stress-ng on x86_64 machine:
> 
>   BUG: unable to handle page fault for address: ffa0000007f40000
>   RIP: 0010:pci_get_rom_size+0x52/0x220
>   Call Trace:
>   <TASK>
>     pci_map_rom+0x80/0x130
>     pci_read_rom+0x4b/0xe0
>     kernfs_file_read_iter+0x96/0x180
>     vfs_read+0x1b1/0x300
> 
> Our analysis reveals that the rom space's start address is
> 0xffa0000007f30000, and size is 0x10000. Because of broken rom
> space, before calling readl(pds), the pds's value is
> 0xffa0000007f3ffff, which is already pointed to the rom space
> end, invoking readl() would read 4 bytes therefore cause an
> out-of-bounds access and trigger a crash.
> Fix this by adding image header and data structure checking.
> 
> We also found another crash on arm64 machine:
> 
>   Unable to handle kernel paging request at virtual address
> ffff8000dd1393ff
>   Mem abort info:
>   ESR = 0x0000000096000021
>   EC = 0x25: DABT (current EL), IL = 32 bits
>   SET = 0, FnV = 0
>   EA = 0, S1PTW = 0
>   FSC = 0x21: alignment fault
> 
> The call trace is the same with x86_64, but the crash reason is
> that the data structure addr is not aligned with 4, and arm64
> machine report "alignment fault". Fix this by adding alignment
> checking.

...

> +#include <linux/align.h>
>  #include <linux/bits.h>
> -#include <linux/kernel.h>
>  #include <linux/export.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/overflow.h>
>  #include <linux/pci.h>
>  #include <linux/slab.h>
>  #include <linux/sizes.h>

I would not touch kernel.h position in this patch. The real change (a third one
if you wish to make that) should replace kernel.h with real includes, making it
disappear. Now this move is unneeded churn.

-- 
With Best Regards,
Andy Shevchenko



