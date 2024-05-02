Return-Path: <linux-pci+bounces-7002-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECA98B989B
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 12:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92F12B24481
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 10:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D4D5731E;
	Thu,  2 May 2024 10:12:52 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DAAF56440;
	Thu,  2 May 2024 10:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714644772; cv=none; b=gG6xMiBnnuL1uvZaml2RtKVU4IMqZFNbKm/ffSoT3jcTrPv4yc2l12GkXBs/dvuGaeyFZ+srS11kLYEKN4MEmAa7j8OLyx+X2sPphjJyEXIkC7FnZ2ht36O5tvOsakI4XwBGYQWPq3ucOi40NhQExFHrJB9vqZgpgeuGcZys6L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714644772; c=relaxed/simple;
	bh=IJLO7lK4MuUZ4lhoA53IDhYlXK4mZYX5Rc8GQjN3+24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ubIYNkTy4zK26p6WpEXeOKsOzYzYtLZA3nxjBFBEX+js7+3GVH5Em3UAEvO7nfxmcxHJEy4+R5NBLRJ6sx9p1JO2AZ5PygTQmVvnKYO1WEzji3gTMGg/2pp9Pe68WpDuqYk1EI2ed/zjaMkuNFQt7xRD4LdCcvG/vw3cjDxyY5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 073A62F4;
	Thu,  2 May 2024 03:13:15 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F12A53F793;
	Thu,  2 May 2024 03:12:45 -0700 (PDT)
Date: Thu, 2 May 2024 11:12:43 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Sunil V L <sunilvl@ventanamicro.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-serial@vger.kernel.org,
	acpica-devel@lists.linux.dev, Sudeep Holla <sudeep.holla@arm.com>,
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
Message-ID: <ZjNnG6JqFCZGj1qv@bogus>
References: <20240501121742.1215792-1-sunilvl@ventanamicro.com>
 <20240501121742.1215792-4-sunilvl@ventanamicro.com>
 <ZjNbvlUoCfa5UUHF@smile.fi.intel.com>
 <ZjNksbTQF1lMQ0k0@sunil-laptop>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjNksbTQF1lMQ0k0@sunil-laptop>

On Thu, May 02, 2024 at 03:32:25PM +0530, Sunil V L wrote:
> On Thu, May 02, 2024 at 12:24:14PM +0300, Andy Shevchenko wrote:
> > On Wed, May 01, 2024 at 05:47:28PM +0530, Sunil V L wrote:
> > > Add a new function for RISC-V to do any architecture specific
> > > initialization. This function will be used to create platform devices
> > > like APLIC, PLIC, RISC-V IOMMU etc. This is similar to acpi_arm_init().
> >
> > What is the special about this architecture that it requires a separate
> > initialization that is _not_ going to be in other cases?
> > Please, elaborate.
> >
> This init function will be used to create GSI mapping structures and in
> future may be others like iommu. Like I mentioned, ARM already has
> similar function acpi_arm_init(). So, it is not new right?
>

Just to add:

This is to initialise everything around all the arch specific tables
which you will not have on any other architectures. We could execute
on all architectures but the tables will never be found. The main point
is why do we want to do that if we can optimise and skip on all other
archs.

--
Regards,
Sudeep

