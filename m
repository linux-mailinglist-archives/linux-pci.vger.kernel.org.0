Return-Path: <linux-pci+bounces-7001-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CE98B9885
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 12:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CD1A2864CE
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 10:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0407956B8C;
	Thu,  2 May 2024 10:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n/UkU6cg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D8155C3A;
	Thu,  2 May 2024 10:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714644609; cv=none; b=opwlIE51JLQNzr5sV/hm5UC9CCKC/A/Kf2/FR3UunhDXf969pUkSyzsY1nPbz6XTO4Bs+cm3n6iaV+DKwkVALqa6RqYl9VTUF+CmfEF65q/u0C/Khf6m8FFvFkEN4QSa9afl3noatupOxuuwfp3HNGxzsXFc5ltzcZGoUb9xydQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714644609; c=relaxed/simple;
	bh=87FHMmdpw7b1gNaTVQbqStrtd0TI+1EIp0z248aiwBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rL8LvZcJvl/Tw+uTPV3T7UauSzEMXRD6W5RY7TWEmil2HeuGfEHMvlCwepD7WWeAWoD0b3JM8JL/28MxzIG5z2rgM2luoKO9rwHb/B+8WX5hSYyBERngBirqmKPR4SXvnd7o5C7yQvaKeQLPhVjQSioPJg6XoxEif1NnqzrHKBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n/UkU6cg; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714644608; x=1746180608;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=87FHMmdpw7b1gNaTVQbqStrtd0TI+1EIp0z248aiwBY=;
  b=n/UkU6cgDKch9lFCzQnb9VSQGA6dMmldbWv0jpFsjE22AWNlk2wG7Q+j
   eCb4nA9QUYkEk2XpnsJFDS4V9MHHu187f88oWYQG8zJBS+OpSDGvbaGiR
   VqmhDvYrqgIubZUUcRmbBes4C2jTK5jLUexdDwrDj3i0uTaFWYL3VKXkc
   IjeImfg0FlEGhGo72YbUn3PmvHwDkOQ6dXJ6CjmweyXP4ZbSPOPo5tmIl
   EK09yX3JucOJvF/n8V+F3s4SD/2V2JOU92BrcXqiu50VCo4iUMjEf5TQY
   eO2+ftiRuY8oQWYJOr/q1NMeqtNyDE0JTd6oJ3WluMYCrAPkcNkFtLRv3
   A==;
X-CSE-ConnectionGUID: PH8pmPUPRX6v4FrN6k+lhw==
X-CSE-MsgGUID: 3wGzZGl/RIy9AB1bdqOIEA==
X-IronPort-AV: E=McAfee;i="6600,9927,11061"; a="10561138"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="10561138"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 03:10:07 -0700
X-CSE-ConnectionGUID: 0RR7KSU8Tby1qIbwmggvCQ==
X-CSE-MsgGUID: Rj5lDDuMQi2fWogM38doFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="31743098"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 03:10:01 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s2TO1-00000003HAt-11R5;
	Thu, 02 May 2024 13:09:57 +0300
Date: Thu, 2 May 2024 13:09:57 +0300
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
Message-ID: <ZjNmdfR2J6hNnYle@smile.fi.intel.com>
References: <20240501121742.1215792-1-sunilvl@ventanamicro.com>
 <20240501121742.1215792-18-sunilvl@ventanamicro.com>
 <ZjNaR-YtVTm4pbP7@smile.fi.intel.com>
 <ZjNh0Llcx+0VHevy@sunil-laptop>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjNh0Llcx+0VHevy@sunil-laptop>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, May 02, 2024 at 03:20:08PM +0530, Sunil V L wrote:
> On Thu, May 02, 2024 at 12:17:59PM +0300, Andy Shevchenko wrote:
> > On Wed, May 01, 2024 at 05:47:42PM +0530, Sunil V L wrote:

...

> > > + * This driver is for generic 16550 compatible UART enumerated via ACPI
> > > + * platform bus instead of PNP bus like PNP0501. This is not a full
> > 
> > This has to be told in the commit message. Anyway, we don't need a duplication
> > code, please use 8250_pnp.
> 
> Thank you for the review!. Major issue with PNP0501 is, it gets enumerated
> in a different way which causes issue to get _DEP to work.
> pnpacpi_init() creates PNP data structures which gets skipped if the
> UART puts _DEP on the GSI provider (interrupt controller). In that case,
> we need to somehow reinitialize such PNP devices after interrupt
> controller gets probed.

Then fix that code, we don't want a hack driver on top of the existing one for
the same.

What I might think out of head is that used IRQ core for your case should
return a deferred probe error code when it's not ready, then 8250_pnp will
get reprobed.

> I tried a solution [1] but it required several
> functions to be moved out of __init. 

> This driver is not a duplicate of 8250_pnp. It just relies on UART
> enumerated as platform device instead of using PNP interfaces.
> Isn't it better and simple to have an option to enumerate as platform
> device instead of PNP? 

Ah, then extract platform driver first from 8250_core.c.

> [1] - https://patchwork.kernel.org/project/linux-pci/patch/20240415170113.662318-14-sunilvl@ventanamicro.com/

-- 
With Best Regards,
Andy Shevchenko



