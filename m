Return-Path: <linux-pci+bounces-6992-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B69D8B97AB
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 11:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0C811F24D4A
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 09:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9225755783;
	Thu,  2 May 2024 09:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V6dnYg4B"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314BD44374;
	Thu,  2 May 2024 09:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714641948; cv=none; b=QRP3VqI0HRa0in+S486691EH6rp0MSBS//Vurhlf8QqL9MpgLcfXGexv7vz5f7+U/sicF2dVz+CTDWojmeAekIAWx0iGQmM1TVf01NLf6/HZAibC7ZBZ747SicnCS0+EhfVIanxFyeJLjmUeuC4fvzIZPqAoasxsgo5iZyEHSew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714641948; c=relaxed/simple;
	bh=orCRNPEGAfKwIw6UvvJyK2arZHKNDah7xC0rf7Z7J6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwVF7J6U4Gp2594kDucLKJGSVv4ONQaNWGmS5xVNn66RAzyPE9EtrXQgw2y6kgtEY8HO+ZnQvrd8tKzNXFf3iNhs2Rk+g90RiJMAjjcguMDwgpiwnTXjRPMiZ5R08qEqu1+XTLhYMjRwfYw+XbaZ5lQzSKVDniO3rj+JLsdSxro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V6dnYg4B; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714641947; x=1746177947;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=orCRNPEGAfKwIw6UvvJyK2arZHKNDah7xC0rf7Z7J6s=;
  b=V6dnYg4B9UEz6gdTQ/uKhWauHh9BtDAznDSvrU3J17Pft1BpfI/2KmOH
   pApUte/7Ztl1v8W/W3xgNzMBRGrYGNiO0djHYy3+PcYyISn1U+uGoMtuH
   zWIfwWx9JFdSqVz6Q+TcVTZ9B7QxnMijb55BFDX7/V5vUwpUyrhK92cS2
   mx/mZ1MjZQD6CzCc2jLtGugo5NhhfHv/wXs+6krxTAKOj8BzCjdGWFH5Y
   hg7BaX0T830cHU8PGFihyVvKY0fBz+3LDamXWnStttAOgw+zy3T9WJwVa
   QxBMV8YuqPTz7+q6zQ9gk4fvd4F6QpZY9COIVmqqSWOZwckkDQXpGRl/j
   Q==;
X-CSE-ConnectionGUID: JGFFjM++ScW3Lsc7GC25lw==
X-CSE-MsgGUID: SfQibMlUQaOo6YAk52UzOw==
X-IronPort-AV: E=McAfee;i="6600,9927,11061"; a="10259498"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="10259498"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 02:25:46 -0700
X-CSE-ConnectionGUID: yWLUxasgQhKC0pOq8PsOKA==
X-CSE-MsgGUID: kfSrOKcPQKK7QxLmkg/vWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="58264038"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 02:25:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s2Sh6-00000003GJd-0vLh;
	Thu, 02 May 2024 12:25:36 +0300
Date: Thu, 2 May 2024 12:25:35 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Sunil V L <sunilvl@ventanamicro.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
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
Subject: Re: [PATCH v5 08/17] ACPI: pci_link: Clear the dependencies after
 probe
Message-ID: <ZjNcDyLRm9c7BAi3@smile.fi.intel.com>
References: <20240501121742.1215792-9-sunilvl@ventanamicro.com>
 <20240501165615.GA758227@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501165615.GA758227@bhelgaas>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, May 01, 2024 at 11:56:15AM -0500, Bjorn Helgaas wrote:
> On Wed, May 01, 2024 at 05:47:33PM +0530, Sunil V L wrote:
> > RISC-V platforms need to use dependencies between PCI host bridge, Link
> > devices and the interrupt controllers to ensure probe order. The
> > dependency is like below.
> > 
> > Interrupt controller <-- Link Device <-- PCI Host bridge.
> > 
> > If there is no dependency added between Link device and PCI Host Bridge,
> > then the PCI end points can get probed prior to link device, unable to
> > get mapping for INTx.
> > 
> > So, add the link device's HID to dependency honor list and also clear it
> > after its probe.
> > 
> > Since this is required only for architectures like RISC-V, enable this
> > code under a new config option and set this only in RISC-V.

...

> > +	if (IS_ENABLED(CONFIG_ARCH_ACPI_DEFERRED_GSI))
> > +		acpi_dev_clear_dependencies(device);
> 
> This is really a question for Rafael, but it doesn't seem right that
> this completely depends on a config option.

+1 here, fells like a hack and looks like a hack.

> Is there a reason this wouldn't work for all architectures, i.e., what
> would happen if you just called acpi_dev_clear_dependencies()
> unconditionally?

-- 
With Best Regards,
Andy Shevchenko



