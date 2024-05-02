Return-Path: <linux-pci+bounces-6988-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A18698B9768
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 11:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3077B20A8D
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 09:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4573535D2;
	Thu,  2 May 2024 09:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kbmXp/1B"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054C353365;
	Thu,  2 May 2024 09:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714641505; cv=none; b=A73qrNWhkX1TjCvYciFAJoXhhCA0Fud9ZrBwoLJropFr2Z4bvk/kEN5M1Q/ualTlo8sNQixsONeKqevJHmIILKUDe0cxl1M6Cy6mh7RVCavx8kD8/gL3xTUJ/76VgpJrUifBC3w8jqM59U3zLMNnf0CHCfrvMIsT8wK5T/z6kys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714641505; c=relaxed/simple;
	bh=a/QufiF272o3DvR0cKkQMFkYPKhS35DQjuKoUIBYmTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SEKEY2BM4wh8Np0eB9jza57Iv9HdGgCY2grnJRixp5zNox4IRT+j1W1R0gWrphsfD2lfLfdoZsLnJPvSoy5bq/HGgV/ICk75kmBcGNEFxIeHNy7S/1HbD1xWL7XeHke12FTtbKoLM02ey60MfPi5fXKFMT5kY96VPyx8Q12/6/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kbmXp/1B; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714641504; x=1746177504;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a/QufiF272o3DvR0cKkQMFkYPKhS35DQjuKoUIBYmTk=;
  b=kbmXp/1B21yUuwq+qOXE9zjQItJoxrW/2C+eEUrkEy3LQ2lH2jLxIwx+
   AwSJZ/EJQAarnaf0qoNWS1XruUMeZOcD0Hw4/6e3/SmV462wYdArSITZR
   uiKAHHtUJOpAgm+8qVYoRLiKG109tgbtt2vW/YKqxVSZY/OSB/0DjxIki
   ePXmaRk8zCc1diDzeESnQdEb9NqDZx+FEHlC8yL8xX6cKfwAIr2kPzlXG
   /PsqvqsLBIcrSFDDJ5LHdCZjG1d7XyQZGiBevTx1/u3g595JG7K27FVMy
   lx1UZI0cnQlpl/NL3DjqXOr11cEKYayYGO4klvuv29rJgVwayr3lRxD9j
   g==;
X-CSE-ConnectionGUID: qO8Ei41dSN+87NW0pzD3ow==
X-CSE-MsgGUID: srmRrpYlQcKNIfeZHPqxwQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11061"; a="10274161"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="10274161"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 02:18:10 -0700
X-CSE-ConnectionGUID: weq2NrOvSyClDOUB0O6Igw==
X-CSE-MsgGUID: iZzhZm4ZT9S/eDC2HeXt4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="27142469"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 02:18:04 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s2SZk-00000003GCl-0xR0;
	Thu, 02 May 2024 12:18:00 +0300
Date: Thu, 2 May 2024 12:17:59 +0300
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
Message-ID: <ZjNaR-YtVTm4pbP7@smile.fi.intel.com>
References: <20240501121742.1215792-1-sunilvl@ventanamicro.com>
 <20240501121742.1215792-18-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501121742.1215792-18-sunilvl@ventanamicro.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, May 01, 2024 at 05:47:42PM +0530, Sunil V L wrote:
> RISC-V has non-PNP generic 16550A compatible UART which needs to be
> enumerated as ACPI platform device. Add driver support for such devices
> similar to 8250_of.

...

> + * This driver is for generic 16550 compatible UART enumerated via ACPI
> + * platform bus instead of PNP bus like PNP0501. This is not a full

This has to be told in the commit message. Anyway, we don't need a duplication
code, please use 8250_pnp.

...

> +	{ "RSCV0003", 0 },

Does it have _CID to be PNP0501?
If not, add this ID to the 8250_pnp.

...

P.S.
The code you submitted has a lot of small style issues, I can comment on them
if you want, but as I said this code is not needed at all.

-- 
With Best Regards,
Andy Shevchenko



