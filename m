Return-Path: <linux-pci+bounces-7012-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB188B9D98
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 17:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A7A31F247E6
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 15:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C63415B567;
	Thu,  2 May 2024 15:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WSyuE7uS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA4642078;
	Thu,  2 May 2024 15:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714664165; cv=none; b=B9r7PdIo5zajKEwNUkW4NJ9o1wYrfVXo2/8TTp9bRYaQu87kcMFHFlIenNPeVD1+SnzrTwF3+QdApUB/G8u5U6vIUwYfLvtrR05onmUvm+pQ2+c0j6mQsL3yJVWXvt8JpTnCXmxlSOSF1LRppca3YnbESqw0pll6jBic4/oyMw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714664165; c=relaxed/simple;
	bh=E8C2qPCeaHtiAjUVZaWnodtIyl8a3pqbTM+93AmJ71Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eHsS09wZNnrml+C/kCBpxg8Ocm6dMUBcwzfT0jcGM++KG2e5VI6F3hsU9CcXuszjtbIW+tLfUcyGvwZy4Wc3NeJ7ixMflfXZN/iDTeUUuWDHEh8rhKLqjVr1LYrbOsFKhaEi2TwQJEbbe+E1FyWFZO4u/ZGbnitlYI38auzMtPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WSyuE7uS; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714664163; x=1746200163;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E8C2qPCeaHtiAjUVZaWnodtIyl8a3pqbTM+93AmJ71Y=;
  b=WSyuE7uSwU5f/7bYnjCXajYcotet4DvVdtYvisV+WbZlIN+mgLRTKmu0
   U5LrDEAujnZx5TmPTii1ZqJDqVGhqC7uESRMInvsmmtWWOL/hwn7CTauF
   ku9hPAdmlg/j56hOeoJwBElDg9091xB+/Ex0nn+ZTIayzwdFyIc6xIAlc
   YXi6A4qrY7833yA1gvDD5OD9LoHvFJJM2797elqGBMR4++R+jiOWg58bG
   8D6Vmf2khptkDZyK3ck6aaZN133B80CARECS/8GsQ/eCLxY55fVZYKXG3
   S1M+9Dv5kwE3JrfAzQyuZIH8V4VdWnQz16Fh6n8B1/Ne0z/0Mst/jbgxK
   A==;
X-CSE-ConnectionGUID: j/T38Oz4RBaWKUjvoQIXqA==
X-CSE-MsgGUID: XdkusnyqSei3J51cvACd4Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="10570068"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="10570068"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 08:36:03 -0700
X-CSE-ConnectionGUID: b+Q2+7rHQo2NCSK+Z3AvIg==
X-CSE-MsgGUID: qhp105huQHCdu0Ee90JJ7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="27208567"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 08:35:56 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s2YTQ-00000003Mdz-43wp;
	Thu, 02 May 2024 18:35:52 +0300
Date: Thu, 2 May 2024 18:35:52 +0300
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
Message-ID: <ZjOy2G0qN5G076i0@smile.fi.intel.com>
References: <20240501121742.1215792-1-sunilvl@ventanamicro.com>
 <20240501121742.1215792-18-sunilvl@ventanamicro.com>
 <ZjNaR-YtVTm4pbP7@smile.fi.intel.com>
 <ZjNh0Llcx+0VHevy@sunil-laptop>
 <ZjNmdfR2J6hNnYle@smile.fi.intel.com>
 <ZjN3GQI3gegYOIgS@sunil-laptop>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjN3GQI3gegYOIgS@sunil-laptop>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, May 02, 2024 at 04:50:57PM +0530, Sunil V L wrote:
> On Thu, May 02, 2024 at 01:09:57PM +0300, Andy Shevchenko wrote:
> > On Thu, May 02, 2024 at 03:20:08PM +0530, Sunil V L wrote:
> > > On Thu, May 02, 2024 at 12:17:59PM +0300, Andy Shevchenko wrote:

...

> > > This driver is not a duplicate of 8250_pnp. It just relies on UART
> > > enumerated as platform device instead of using PNP interfaces.
> > > Isn't it better and simple to have an option to enumerate as platform
> > > device instead of PNP? 
> > 
> > Ah, then extract platform driver first from 8250_core.c.
> > 
> Let me know if I understand your suggestion correctly. Do you mean call
> something like serial8250_acpi_init() from serial8250_init() and
> register the driver directly in serial8250_acpi_init()?

Extract the code to be 8250_platform.c and update that file.
I have locally the extraction of RSA code, I will see if I can help you
with the rest.

-- 
With Best Regards,
Andy Shevchenko



