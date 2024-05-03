Return-Path: <linux-pci+bounces-7047-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A978BAFDA
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2024 17:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEEA51F23073
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2024 15:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E88A15356D;
	Fri,  3 May 2024 15:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BsRENZ7u"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FCA1514E5;
	Fri,  3 May 2024 15:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714750343; cv=none; b=TtwCo6USa1nGBfA+5jCs9GnKOOBSFNFMDHdiw8EtM2WshkCKcTpiKv3WU0cJuCwpFP44N5SM4uZZ0kp1KOx1b1wpue9ZJUtJ6OqfPSev+avRJAjAhJ/FkAeroyOHq9+EAgRXuES53EysI1dSBKV+2Nuh8OjTjF/MMk3bzdEXneY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714750343; c=relaxed/simple;
	bh=yxFVHXgO+anV8vLASPVvYb2Vlv6942qfs+GdKOTjrw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OLuIOJWJP51SEF9wj8OXVvfih1mvZLIJ2F92EHREXKJVlqQF+O4gNQrKKO8lx4Ofd8TmfP6WLMKLC0Ui9IozVre/pkrMruR0+D3URG5tBRlWkuNTGH2ERI7QZCLcevpKw6uLTvaAgRJ3yL6FDvOM125BM0h1/EXaYguX7c2g2/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BsRENZ7u; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714750341; x=1746286341;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yxFVHXgO+anV8vLASPVvYb2Vlv6942qfs+GdKOTjrw4=;
  b=BsRENZ7ukJo8Qnmr4DEsX+1ZtJbgsHRVRaArPZYAnv0Ue0/SITPsHLte
   Teb/GCWW1nVwWYTFfQ5aizD5gv3FBxcndlc9k8nQtMW3V/HgCROLWO31D
   IQLlC6Is60D4iyZt0JLrOOAY5YbdBh2/YHWqOx36M1ohaPXq6I0/AN7nt
   VpuZ1G+GGfcDAWfLj4u2ta30KfvmnbsW5h+CfdshEf73In0kWuAtqxCQ4
   pWLCd49MicS/qhWZFVQOJ/EM1s8P/4ViFV8l6H5Y0CjWv9UKyulqQVx/l
   7G4ry+3ZE00bjAeDpOd65rI8m3gDEYe6cvb7/ekyrQZ26qy5q1QSkFBzu
   Q==;
X-CSE-ConnectionGUID: uI+qh72/RFCU5sdhG255Nw==
X-CSE-MsgGUID: UpGh5VboTrWuniVMwWU+Fg==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="10488958"
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="10488958"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 08:32:21 -0700
X-CSE-ConnectionGUID: 2M/Q9VVTTQOObdpg6it7mw==
X-CSE-MsgGUID: PPYkXuJ2SFy8qL2n0L+0bA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="28070781"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 08:32:14 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s2utO-00000003gli-2OHk;
	Fri, 03 May 2024 18:32:10 +0300
Date: Fri, 3 May 2024 18:32:10 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-serial@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Marc Zyngier <maz@kernel.org>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Andrei Warkentin <andrei.warkentin@intel.com>,
	Haibo1 Xu <haibo1.xu@intel.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Subject: Re: [PATCH v5 17/17] serial: 8250: Add 8250_acpi driver
Message-ID: <ZjUDeuCQNCuYgATA@smile.fi.intel.com>
References: <20240501121742.1215792-1-sunilvl@ventanamicro.com>
 <20240501121742.1215792-18-sunilvl@ventanamicro.com>
 <ZjNaR-YtVTm4pbP7@smile.fi.intel.com>
 <ZjNh0Llcx+0VHevy@sunil-laptop>
 <ZjNmdfR2J6hNnYle@smile.fi.intel.com>
 <ZjN3GQI3gegYOIgS@sunil-laptop>
 <ZjOy2G0qN5G076i0@smile.fi.intel.com>
 <ZjTtx88zk4GvCImk@sunil-laptop>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjTtx88zk4GvCImk@sunil-laptop>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, May 03, 2024 at 07:29:35PM +0530, Sunil V L wrote:
> On Thu, May 02, 2024 at 06:35:52PM +0300, Andy Shevchenko wrote:
> > On Thu, May 02, 2024 at 04:50:57PM +0530, Sunil V L wrote:
> > > On Thu, May 02, 2024 at 01:09:57PM +0300, Andy Shevchenko wrote:
> > > > On Thu, May 02, 2024 at 03:20:08PM +0530, Sunil V L wrote:
> > > > > On Thu, May 02, 2024 at 12:17:59PM +0300, Andy Shevchenko wrote:

...

> > > > > This driver is not a duplicate of 8250_pnp. It just relies on UART
> > > > > enumerated as platform device instead of using PNP interfaces.
> > > > > Isn't it better and simple to have an option to enumerate as platform
> > > > > device instead of PNP? 
> > > > 
> > > > Ah, then extract platform driver first from 8250_core.c.
> > > > 
> > > Let me know if I understand your suggestion correctly. Do you mean call
> > > something like serial8250_acpi_init() from serial8250_init() and
> > > register the driver directly in serial8250_acpi_init()?
> > 
> > Extract the code to be 8250_platform.c and update that file.
> > I have locally the extraction of RSA code, I will see if I can help you
> > with the rest.
> > 
> Thanks!. That will be helpful. TBH, I don't understand what to do for
> extracting the platform driver code. There are already several vendor
> specific UART drivers (ex: 8250_fsl.c) which are enumerated as platform
> devices. 8250_core.c looks cleanly supporting such drivers which can
> register themselves with the core. For generic UART, DT has 8250_of.c
> and ACPI has 8250_pnp.c. But 8250_pnp.c comes with baggage of PNP
> contract. So, the driver in this patch is similar to vendor specific
> drivers to support generic uart devices which are enumerated as platform
> device.

> I can rename 8250_acpi.c to 8250_platform.c if that is better.

No, that's not what I meant. We _already_ have a generic platform driver,
it's just inline in the 8250_core.c and needs to be extracted. When it's done,
you may simply add an ACPI table to it.

> Could you please help with a patch even if not compiled so that I can
> understand your suggestion better? 

-- 
With Best Regards,
Andy Shevchenko



