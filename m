Return-Path: <linux-pci+bounces-28846-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B87C5ACC30C
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 11:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 825E71629E0
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 09:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E10F25D213;
	Tue,  3 Jun 2025 09:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PSzE5wEI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F24C1F4289;
	Tue,  3 Jun 2025 09:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748943054; cv=none; b=ZRhdWLm2mPhEdxnGZl5p/FwFINMmN5qkTw0NLFwmt6+TwuYiLKgcm+0rDqnXidF4oUY6hFxfWkMpSXjq8wBAGoYm/q8F5JDJmOXzc1lvH8dO/Ud5J065mfix7g3rjJuS4wBSjJM8sy/6zhQXEISM80XGcZHQFPyp8gFb2wB0RDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748943054; c=relaxed/simple;
	bh=/1i9ZYWp3klV4pFiYytXoQo5aHEEJ7NwFK1134MFvqU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KkFDnhypZCg2bk/rseo156BjvLE1F31ppNPJrotSig9x49wGQEi7gNWQ9a+ldWVwA2Iczg5dWXfQwcn1UfDJXRw1911Gs4kCcC34PP/syxa1a1xYPWloAKCpeig4q0SW8aSXuEz93HdINZk8lm+medXEKohRfv31GHzj+d3bd3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PSzE5wEI; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748943053; x=1780479053;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=/1i9ZYWp3klV4pFiYytXoQo5aHEEJ7NwFK1134MFvqU=;
  b=PSzE5wEIQk7/H9Xlve7qFHQSFHBxKMKPRe8ilNTi2WD6Al2qZqm27tSK
   5Raom60wcpmhG6AC/VCky9C9JiyFmU/FPIV2iwUJUgTsM7vlAF1aiTOqG
   4b2He6t1MDJWr9wn32SedwKF82Auw93rANAQR6NwoEOaDMn3dsdN+duUM
   rZce5EJGXtObOodNksKFqif50bAHyRpHDlvRa8PLdIipNbn7LNSWkcN4+
   KniZU2a1Pv/ypwXqjw27KqixjAtp6DmpGwuhuM12mtA5M4lRqWrbdAk1c
   0Fdqok76HKa4+wwL7KOCtoGIgXDDNTYzPtGdTL+ml/f7UsKpRQPRSV44F
   A==;
X-CSE-ConnectionGUID: 7WqsUtMNQAeYkvAaSqcGJA==
X-CSE-MsgGUID: cjhf9wbrRBKU0phzKd8QXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="61635809"
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; 
   d="scan'208";a="61635809"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 02:30:53 -0700
X-CSE-ConnectionGUID: dsjSgBcWTKq25N+n8Qbvfw==
X-CSE-MsgGUID: KPzy5toeTCKIcMQy2nGD0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; 
   d="scan'208";a="175668150"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.141])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 02:30:20 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 3 Jun 2025 12:30:16 +0300 (EEST)
To: Hans Zhang <18255117159@163.com>
cc: lpieralisi@kernel.org, bhelgaas@google.com, 
    manivannan.sadhasivam@linaro.org, kw@linux.com, cassel@kernel.org, 
    robh@kernel.org, jingoohan1@gmail.com, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12 2/6] PCI: Clean up __pci_find_next_cap_ttl()
 readability
In-Reply-To: <20250514161258.93844-3-18255117159@163.com>
Message-ID: <987609ec-7a1b-057c-1e3b-8bf564965036@linux.intel.com>
References: <20250514161258.93844-1-18255117159@163.com> <20250514161258.93844-3-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 15 May 2025, Hans Zhang wrote:

> Refactor the __pci_find_next_cap_ttl() to improve code clarity:
> - Replace magic number 0x40 with PCI_STD_HEADER_SIZEOF.
> - Use ALIGN_DOWN() for position alignment instead of manual bitmask.
> - Extract PCI capability fields via FIELD_GET() with standardized masks.
> - Add necessary headers (linux/align.h).
> 
> The changes are purely non-functional cleanups, ensuring behavior remains
> identical to the original implementation.

If you want a simpler wording for this, this is often used:

No functional changes intended.

> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
> Changes since v11:
> - None
> 
> Changes since v10:
> - Remove #include <uapi/linux/pci_regs.h> and add macro definition comments.
> 
> Changes since v9:
> - None
> 
> Changes since v8:
> - Split into patch 1/6, patch 2/6.
> - The
> ---
>  drivers/pci/pci.c             | 9 +++++----
>  include/uapi/linux/pci_regs.h | 2 ++
>  2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e77d5b53c0ce..27d2adb18a30 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -9,6 +9,7 @@
>   */
>  
>  #include <linux/acpi.h>
> +#include <linux/align.h>
>  #include <linux/kernel.h>
>  #include <linux/delay.h>
>  #include <linux/dmi.h>
> @@ -432,17 +433,17 @@ static u8 __pci_find_next_cap_ttl(struct pci_bus *bus, unsigned int devfn,
>  	pci_bus_read_config_byte(bus, devfn, pos, &pos);
>  
>  	while ((*ttl)--) {
> -		if (pos < 0x40)
> +		if (pos < PCI_STD_HEADER_SIZEOF)
>  			break;
> -		pos &= ~3;
> +		pos = ALIGN_DOWN(pos, 4);
>  		pci_bus_read_config_word(bus, devfn, pos, &ent);
>  
> -		id = ent & 0xff;
> +		id = FIELD_GET(PCI_CAP_ID_MASK, ent);
>  		if (id == 0xff)
>  			break;
>  		if (id == cap)
>  			return pos;
> -		pos = (ent >> 8);
> +		pos = FIELD_GET(PCI_CAP_LIST_NEXT_MASK, ent);
>  	}
>  	return 0;
>  }
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index ba326710f9c8..35051f9ac16a 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -206,6 +206,8 @@
>  /* 0x48-0x7f reserved */
>  
>  /* Capability lists */
> +#define PCI_CAP_ID_MASK		0x00ff	/* Capability ID mask */
> +#define PCI_CAP_LIST_NEXT_MASK	0xff00	/* Next Capability Pointer mask */
>  
>  #define PCI_CAP_LIST_ID		0	/* Capability ID */

I'd add those here with the extra space before name and add empty line in 
between them and the capability id list.

>  #define  PCI_CAP_ID_PM		0x01	/* Power Management */
> 

-- 
 i.


