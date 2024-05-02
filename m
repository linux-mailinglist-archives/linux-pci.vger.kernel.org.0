Return-Path: <linux-pci+bounces-6991-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C868B979E
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 11:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FDE0289767
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 09:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2909554FAE;
	Thu,  2 May 2024 09:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cSA76uxS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B922535BF;
	Thu,  2 May 2024 09:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714641867; cv=none; b=a+UsxLWtY067WzHfSTZMmWeAHPr+4yCkab9jN+U7KES6nomG/l1veG6rjFEvn2fxpUSQLwyEYevAKt1t5U7JuKZyZYTu0uZslM/hTh/D/55h7py4MsGUWcaHj6tCHKk8YKoOQEM+hiHz1IoynchNZAFcGgKC/Oh/eGQZgbBnN4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714641867; c=relaxed/simple;
	bh=Vob8HwvNIBqShNlkC5WdH3AbXBzht4hKUtEPIm9WJPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EBmHJShCQVwmPS3saHTpmuuxc1DQyp2o6Z0D3UbUC3WuxPg5bMhZmTfcyb3/V2lmBMJ2j2WlZyiMWbszKispS6w57hnMUQciRd3WG3dB5/xn1JbT0etXX1KTqtm3w2KUtObx6KnCg8J9vu0wYDAkOWcPsZUvezgN/o7Y0KBmr8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cSA76uxS; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714641866; x=1746177866;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Vob8HwvNIBqShNlkC5WdH3AbXBzht4hKUtEPIm9WJPo=;
  b=cSA76uxSr2TNyH5be6ZCAMY4i7jf0HB/FmRv7uzthWP+9KsA9I8Hp4pM
   9UmVugW3+Hv/MlapLKRsuC6sTa28TslJHYQTfF8EjNfDgdfMxQ/qI45OO
   uyFlscYBIKuhLkhsU1X3KfBjf0e7+AILpfjWk2iZXgKbtQCuwhRBl70NH
   CxNPRxBUjQEvqA+5w+4jRRyk/4PSMigwKr5znSGHQM/3DEKhNfBrsXXmj
   A3FtaHg7s7ZbE2mWT2Z6BG51hhYR/HDYn0GRNdtq8BQgUs/hBxtBXfk0d
   g5ZC3FAL1VWSvxrkP8qgAF0ocYTuSCFZFuHmVjyEettowu22Sr4dzLAZo
   A==;
X-CSE-ConnectionGUID: +loGE1mCQCaOVKe375xkCw==
X-CSE-MsgGUID: sniRQSk4TAW8sXoLAEiYLg==
X-IronPort-AV: E=McAfee;i="6600,9927,11061"; a="21090211"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="21090211"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 02:24:25 -0700
X-CSE-ConnectionGUID: FEKRVKUMRuKOBCq34jlVbQ==
X-CSE-MsgGUID: dEi7c3UlRCKUTgL7Jf9ogQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="27466047"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 02:24:19 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s2Sfm-00000003GIa-3iCp;
	Thu, 02 May 2024 12:24:14 +0300
Date: Thu, 2 May 2024 12:24:14 +0300
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
Subject: Re: [PATCH v5 03/17] ACPI: bus: Add acpi_riscv_init function
Message-ID: <ZjNbvlUoCfa5UUHF@smile.fi.intel.com>
References: <20240501121742.1215792-1-sunilvl@ventanamicro.com>
 <20240501121742.1215792-4-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501121742.1215792-4-sunilvl@ventanamicro.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, May 01, 2024 at 05:47:28PM +0530, Sunil V L wrote:
> Add a new function for RISC-V to do any architecture specific
> initialization. This function will be used to create platform devices
> like APLIC, PLIC, RISC-V IOMMU etc. This is similar to acpi_arm_init().

What is the special about this architecture that it requires a separate
initialization that is _not_ going to be in other cases?
Please, elaborate.


-- 
With Best Regards,
Andy Shevchenko



