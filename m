Return-Path: <linux-pci+bounces-6989-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA19E8B977C
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 11:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D1FD1F24D5D
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 09:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D6C537F6;
	Thu,  2 May 2024 09:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B4zw7Czz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7E756B73;
	Thu,  2 May 2024 09:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714641618; cv=none; b=f9UBauuf0hXwPwduQOh3rtALEIWMaKuF0+EmG+MQX37uH4Gx+t7A7mo4ivqcCBdIdVuCysCxm9UOsvZmoRhr8VyGt9DMXV2QnAxSBsqFoMqESBBXnWuH+UefQmDxmg9QGiUaM7kLJvIJh9NcH6GyiLn5SRVmpam8DdL4jC+qnCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714641618; c=relaxed/simple;
	bh=2ELzIZ73e2akUHQJpgdE0zMt86IGlmi1Bdva3N+17hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/68ldO1KvVrFB+sGjqG+Za9Zv7cP4n3D2rZPUlD84WO46nvk/F33LP99Bb03bQixU7oz7Yhsp7pb3MyQzVKLiQnxxQ3r/1CmMsxJxvRVrxT1Mb9vOMgwOM8C74t+943tVskQ7uRnbOwfctIkYEfw9cltBENYpZ/cygYA4ZTK3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B4zw7Czz; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714641617; x=1746177617;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2ELzIZ73e2akUHQJpgdE0zMt86IGlmi1Bdva3N+17hw=;
  b=B4zw7CzzHSC8ETZDjRajNp/4oiLBsbclgg+7fybgK/jNDA7HHSBmmyZ5
   VvAnig4TwIhgLgIRWXs17aNBoVE7brbbO0mGF8QQVpfAClI9G9nITiU7F
   o7JVHOkAW1Se+8kaCuh74iKdYBo9qoSVymKOwE5gmdIgfDVxg6SxedZEK
   buJURjrmG20D+PxdMAgB0sZ8CrSrbHQQtZ1Myj4VR2Kfr2FXSILKQWYH1
   Q9X3FKfaJs14+0H2HEMs2RcdXX+13KPDpBuIsSs8Bg9347peN94J76JRy
   80m6UdO9/eIc1mT/4O8l2SxxaPK7ZoFBOKMcfNbJfZHuR6stfwuMN2njO
   w==;
X-CSE-ConnectionGUID: o9+FBA1CRG6DV9t5OBLZdQ==
X-CSE-MsgGUID: THzNy5pxT9eJ/QDC3ejvFg==
X-IronPort-AV: E=McAfee;i="6600,9927,11061"; a="14205199"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="14205199"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 02:20:16 -0700
X-CSE-ConnectionGUID: P6lk84EsQEGlm9RlHsRk/g==
X-CSE-MsgGUID: mTWM/FTNSfil7mVmwM/XnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="64501407"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 02:20:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s2Sbm-00000003GEk-2Bl0;
	Thu, 02 May 2024 12:20:06 +0300
Date: Thu, 2 May 2024 12:20:06 +0300
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
Subject: Re: [PATCH v5 04/17] ACPI: scan: Refactor dependency creation
Message-ID: <ZjNaxvh2ZSfDcTa8@smile.fi.intel.com>
References: <20240501121742.1215792-1-sunilvl@ventanamicro.com>
 <20240501121742.1215792-5-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501121742.1215792-5-sunilvl@ventanamicro.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, May 01, 2024 at 05:47:29PM +0530, Sunil V L wrote:
> Some architectures like RISC-V will use implicit dependencies like GSI
> map to create dependencies between interrupt controller and devices. To
> support doing that, the function which creates the dependency, is
> refactored bit and made public so that dependency can be added from
> outside of scan.c as well.

Side note: If you haven't used --histogram diff algo when preparing
the patches, do it from now on.

-- 
With Best Regards,
Andy Shevchenko



