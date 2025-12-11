Return-Path: <linux-pci+bounces-42961-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6C5CB6272
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 15:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0174C303D327
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 14:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7BF280325;
	Thu, 11 Dec 2025 14:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n3hTlYh7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31AA2C3261
	for <linux-pci@vger.kernel.org>; Thu, 11 Dec 2025 14:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765461951; cv=none; b=Fuu4u823REkcT0/G+QTCJp3zi6Wx4vtP/Qs6pZW6JmAUKogCpgCLMGIGInuWw/2g1M7ehcLaoQItML9eMDi4xDm8tH7oLFCJUJtYGDqGMD6pQ/c4vwp2GZPZr6GKMKF/zHwvZdWrF5XA7EmkK9XcP3X5ypg78tX6iCH6fRPHMF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765461951; c=relaxed/simple;
	bh=4fS47JypX5dAuv3VwLEKtpMcG2cXiDzEZ+p+tONSO54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oek42+5r6dCEDmy3QSNWjac+ZqbqVVKTSQM/GqOi3kqkjlEsRfdx217KnOajvd6gdQ6AZwHADb2abbY6OlwGp/auc7cZKiB/TMaFrzsE/pNp+6CVTvYTiGubvS3vrPJlVxbeYnDO7cIRSI8xuT0jVaOBik1AY5XrFinTKepBfcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n3hTlYh7; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765461949; x=1796997949;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4fS47JypX5dAuv3VwLEKtpMcG2cXiDzEZ+p+tONSO54=;
  b=n3hTlYh7XqUdE7FYIQDCRhPP49TYM6Fj2V4+IepwlE1nddZbhZdbHn6d
   PPxghkCyKaO0P7gebSyVHgdPfJZAuV4Q4j5ykQiyO5mmKl80Q1q6MuDqS
   wy6CZZwNSjdZyZaWM4z352XA91gwVYcHPwj1HzPur48Rbg/HfWk/O1rDh
   P0y1HNRYiSAjJYxXGx1jGJdX7Pr8pfMCv1dnhx/V22INkAjTuhtwrIASb
   3y2Ma2Ie/e62mQELKOAlJ+gSFqp1+ZfdHzq+8INbTCXu6HkD6eLzrb8xY
   8GicYhkVKsPeJS1VgB+ODbMaBJKKMHhaAUB+j+xS+ZgJ2RSv6XF9AAqXi
   w==;
X-CSE-ConnectionGUID: yAR1v2edSqWS9MbcULtGng==
X-CSE-MsgGUID: 9s3fkHC9QO2yIYhFpnGW6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="77757461"
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; 
   d="scan'208";a="77757461"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 06:05:47 -0800
X-CSE-ConnectionGUID: pQwZLG9JR7SmjaAQE4Kccw==
X-CSE-MsgGUID: WAyXuV4ySxi+xSZKuF9LJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; 
   d="scan'208";a="197625853"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.250])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 06:05:46 -0800
Date: Thu, 11 Dec 2025 16:05:43 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v9 1/2] PCI: Introduce named defines for pci rom
Message-ID: <aTrPtxDdg__tabSE@smile.fi.intel.com>
References: <20251211125906.57027-1-kanie@linux.alibaba.com>
 <20251211125906.57027-2-kanie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251211125906.57027-2-kanie@linux.alibaba.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Dec 11, 2025 at 08:59:05PM +0800, Guixin Liu wrote:
> Convert the magic numbers associated with PCI ROM into named
> definitions. Some of these definitions will be used in the second
> fix patch.

Please, give at least 24h between the versions in order other being able (quick
enough) to review the changes.

...

> +#include <linux/bits.h>
>  #include <linux/kernel.h>
>  #include <linux/export.h>
>  #include <linux/pci.h>
>  #include <linux/slab.h>

> +#include <linux/sizes.h>

'i' goes before 'l', yeah it's hard to see in small monospace fonts.

...


> +#define PCI_ROM_HEADER_SIZE			0x1A
> +#define PCI_ROM_POINTER_TO_DATA_STRUCT		0x18
> +#define PCI_ROM_LAST_IMAGE_INDICATOR		0x15
> +#define PCI_ROM_LAST_IMAGE_INDICATOR_BIT	BIT(7)

> +#define PCI_ROM_IMAGE_LEN			0x10
> +#define PCI_ROM_IMAGE_LEN_UNIT_BYTES		SZ_512

I'm a bit confused by the naming here.

There are two definitions that end with _LEN, but the meaning of them is
the offset where the respective "len" can be read from.

Now, there is a _LEN_UNIT_BYTES, which seems related to _LEN, but in unclear
way.

With all the AA55 signature it pretty much sounds to me like a sector division
(legacy from the era of floppies).

That said, I would name the size of the "unit" as

#define PCI_ROM_IMAGE_SECTOR_SIZE		SZ_512

(without or with _BYTES on your choice, usually we don't use unit for bytes
 when there is no room for misinterpretation).

> +#define PCI_ROM_IMAGE_SIGNATURE			0xAA55

Despite the below comment explains this, I would explicitly state it here

/* Data structure signature is "PCIR" in ASCII representation */

> +#define PCI_ROM_DATA_STRUCT_SIGNATURE		0x52494350
> +#define PCI_ROM_DATA_STRUCT_LEN			0x0A

-- 
With Best Regards,
Andy Shevchenko



