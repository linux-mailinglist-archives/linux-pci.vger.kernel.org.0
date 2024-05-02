Return-Path: <linux-pci+bounces-6990-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B106D8B9793
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 11:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 688D41F259E1
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 09:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3A054FB5;
	Thu,  2 May 2024 09:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bJgPMuqT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEA75466C;
	Thu,  2 May 2024 09:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714641763; cv=none; b=RvyyeeHik9TcfaEFs84tddXohzi4C5ybkLiJrWda4aukecOcO2HroIGpk/x7ZJnIFpZ7gb9bIM4BKt0nD7pQWEx75RJD7b6+tKFFiitvl9sqdhQgGpLmTHykw8fPURoIEx4F91490x8DKdSPXRSc5hfzja3rYUmV5PtJEz5/D6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714641763; c=relaxed/simple;
	bh=2oA8ldgZYHkMjR2V+LxaGdrDpb1xKBe+lL+dxCNsNr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RzeyTI2gkK11EoazGtOeAie/BNjtxiCPdGRQqFpott33wvYYz0LtaC1fyTOxi1ukC+XJNlnWKfRYVYj2B3B1dX681N11B+kXnuh8kGbJehiRWdainG63OkpPJXJbzMv6IVzm7J9lqoXronXPquoyjTqfW8RDVkrILI8gJfs2gmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bJgPMuqT; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714641762; x=1746177762;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2oA8ldgZYHkMjR2V+LxaGdrDpb1xKBe+lL+dxCNsNr8=;
  b=bJgPMuqTAlww/ogzeImMDcuHbM9OaCOwGOKPOkWQN0nD0twOOfdqPKAn
   ML9O1KFUy4b4BK6HjiZGcFLYDmUCyExKcHE5CgsOzxR42tANC00HCyEQD
   ZkdPreh2EEHxFAgM4rq4sPV7BtKRU0tb/U+SRjgwbmOjUUeraDoyuNEp2
   DPCtLFDm/OlSOLA8NabQpOPlUlpzf4skxDzQ3O4MdLInVZUEpwv6WaFK1
   CcosXNP31gA8ZnzZZgg8ie8tYxyAhk7+pCXELwsWBYotuvRfbzMOrlbuL
   4thmbm+O5F/mqtWEG1jsG/XNvi4q12x8vWy2u+pmmH2MeFvp6Rv8qAXLu
   w==;
X-CSE-ConnectionGUID: D0u3vmgOSvyfexR3CkWevg==
X-CSE-MsgGUID: g6sHbP7FQIqfGV5sUUwXWQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11061"; a="10225125"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="10225125"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 02:22:40 -0700
X-CSE-ConnectionGUID: rOlQAAf0R+mpvFFX9nD5Sw==
X-CSE-MsgGUID: hJxq4rkXSQqFppQsZhlRbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="31539169"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 02:22:32 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s2Se4-00000003GHS-2Yz6;
	Thu, 02 May 2024 12:22:28 +0300
Date: Thu, 2 May 2024 12:22:28 +0300
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
Subject: Re: [PATCH v5 01/17] arm64: PCI: Migrate ACPI related functions to
 pci-acpi.c
Message-ID: <ZjNbVPYIjINdk4Fn@smile.fi.intel.com>
References: <20240501121742.1215792-1-sunilvl@ventanamicro.com>
 <20240501121742.1215792-2-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501121742.1215792-2-sunilvl@ventanamicro.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, May 01, 2024 at 05:47:26PM +0530, Sunil V L wrote:
> The functions defined in arm64 for ACPI support are required
> for RISC-V also. To avoid duplication, move these functions
> to common location.

...

There are -M -C parameters to git format-patch. Use them in the next version of
the series. (Note, you may add percentage numbers to each of those parameters
to get prettier result.)

-- 
With Best Regards,
Andy Shevchenko



