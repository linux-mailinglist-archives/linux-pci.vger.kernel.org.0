Return-Path: <linux-pci+bounces-7003-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2D88B98AF
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 12:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81CEF1F2125B
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 10:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CEE58100;
	Thu,  2 May 2024 10:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eR8KkMxA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F253356B73;
	Thu,  2 May 2024 10:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714645207; cv=none; b=EYxOtFqeqfAG43P369zAg/5gMFWsPg3QCthUZsL2apHNdq6MPzRrp1rVbRISnGOAyb5WVrDkuArde+gWggfiFh3XsxU9oMhJkmpm4HKwR7IDi+uToN9JDx+M/G92G65uxEdCs09+6lD6Sf64SOIJkyIvwv0y3KFa7/7+ej/coB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714645207; c=relaxed/simple;
	bh=UBlJgz5xG7D/qPa02aoxxcu20LLe8O6olWTsYyH24Fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Us1dGavvep9YLzW52aPyud78wvTcI4/KRiacFr1OWMjgSiA+oyuU0soRLVNLTUpmQfMV19DIKTj4T4TKXZyXQ0EbMc4UETUTxFEG103d5qaFap+Qc2lLLAcxtU4vzspV6zbUrm33sd/HBGBN8EYHgzZdPp2a3pcPl5YLJVRSfRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eR8KkMxA; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714645206; x=1746181206;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UBlJgz5xG7D/qPa02aoxxcu20LLe8O6olWTsYyH24Fs=;
  b=eR8KkMxAtUNk6oNpSb+R2gKKPNp1+VrqSKx+kVed7+dMqBgW3q9dGvM5
   2OKN75juDi7EV7ABiBU0ur8esTG3OlE3ivdzehkZX6ksvnYmQtHqflHet
   TksBoF57soSkcZC4qslTkn1v6HzFd3OqQS4RfIqLEh9rcLfcNFjaMywJJ
   7ywasKlEOpl2S16+ZaG8sbPg75Jp6ZJp4pWaC4wFxEGdhC6t9b4VSd6wW
   TBBSKsGXHV+0HiZTXAsR5ub8RDzbQcuIwadTj0IeNENHqVXi6Ov7W2TvP
   XT3fgoGZtDoEvHacexiT8KsBLT6UCIEnLpcIKwPq2hPL+fUQZaIoKbJSO
   A==;
X-CSE-ConnectionGUID: ZjVvLZInTRO6plmMaaq+eg==
X-CSE-MsgGUID: mryL4ml3RtaO2nDKvqsxKQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11061"; a="10278806"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="10278806"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 03:20:05 -0700
X-CSE-ConnectionGUID: aiX0mY4vQSeFpVaHn0EPsg==
X-CSE-MsgGUID: Z4pRODJ+R8ebvjkfa5L59g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="27156971"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 03:20:00 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s2TXf-00000003HNp-2W6n;
	Thu, 02 May 2024 13:19:55 +0300
Date: Thu, 2 May 2024 13:19:55 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sudeep Holla <sudeep.holla@arm.com>
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
Subject: Re: [PATCH v5 03/17] ACPI: bus: Add acpi_riscv_init function
Message-ID: <ZjNoy6KLtOCTe52q@smile.fi.intel.com>
References: <20240501121742.1215792-1-sunilvl@ventanamicro.com>
 <20240501121742.1215792-4-sunilvl@ventanamicro.com>
 <ZjNbvlUoCfa5UUHF@smile.fi.intel.com>
 <ZjNksbTQF1lMQ0k0@sunil-laptop>
 <ZjNnG6JqFCZGj1qv@bogus>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjNnG6JqFCZGj1qv@bogus>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, May 02, 2024 at 11:12:43AM +0100, Sudeep Holla wrote:
> On Thu, May 02, 2024 at 03:32:25PM +0530, Sunil V L wrote:
> > On Thu, May 02, 2024 at 12:24:14PM +0300, Andy Shevchenko wrote:
> > > On Wed, May 01, 2024 at 05:47:28PM +0530, Sunil V L wrote:
> > > > Add a new function for RISC-V to do any architecture specific
> > > > initialization. This function will be used to create platform devices
> > > > like APLIC, PLIC, RISC-V IOMMU etc. This is similar to acpi_arm_init().
> > >
> > > What is the special about this architecture that it requires a separate
> > > initialization that is _not_ going to be in other cases?
> > > Please, elaborate.
> > >
> > This init function will be used to create GSI mapping structures and in
> > future may be others like iommu. Like I mentioned, ARM already has
> > similar function acpi_arm_init(). So, it is not new right?
> 
> Just to add:
> 
> This is to initialise everything around all the arch specific tables
> which you will not have on any other architectures. We could execute
> on all architectures but the tables will never be found. The main point
> is why do we want to do that if we can optimise and skip on all other
> archs.

You need to carefully write the commit messages. Some kind of the above
paragraphs has to be in there.

-- 
With Best Regards,
Andy Shevchenko



