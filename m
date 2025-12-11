Return-Path: <linux-pci+bounces-42938-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D87ACB55C9
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 10:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7D2E830012C4
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 09:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137C527280B;
	Thu, 11 Dec 2025 09:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RnHbxTbQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EED239567
	for <linux-pci@vger.kernel.org>; Thu, 11 Dec 2025 09:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765445594; cv=none; b=asz6BqPbuIpM0W/iEqIjj6paO8GkPQYIyFxx+8yA3Ew4WhayofmLeRYZkS2TTPwfpG59WApU34itDhG7d9rT4bX87U8qsek6wo3xq2JXHCsxptbVzZrwjChAlYEWbyd8PwUESsY5tBW77Gk+BSMEMW4kYsyVeGjtKLefY/hFAU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765445594; c=relaxed/simple;
	bh=PUHbxRLf0viMdVl0mLJLPxK+OrrSAzwaTxXnRQMHz+U=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VCLIxlKGQcJIX1+GQppCR87RIn53emcpiQC7PBQhOYsSF6F5l2xj6zhSlhj4DXKMK3SkWGWYIJEAOQkdEPeSpxfrtHXlJtuSnStvVvdSZIZ62Mor7uDYQ17aygobL1qt2zOGmYa59hkuJzHnZvacbkwdQuPf4umstr7zibvR/Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RnHbxTbQ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765445592; x=1796981592;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=PUHbxRLf0viMdVl0mLJLPxK+OrrSAzwaTxXnRQMHz+U=;
  b=RnHbxTbQl+hQbgwrSMCjykD0eOvdt0Vt7yB8yQ0fME3BlQbdPE5iVdUi
   Lw4os/KdUPWJDza1pGURB2kfgHMjuUntTetBtLG9sk392Ye7oaNXnASqM
   uenZ8uhHB2Lss3lYKOy4WEJaUjwXPZYndWsJHa/3qlLIxNQwwjXw/Y/PD
   KVU/MQVSRqf5WRS9uegrysByUBFIzAxPSdDJQaQObNTEoa44TeZ8rpzc+
   FOFXf7KTrxI1Y10OSsF5nmVe3APJS4mD58CMDHQ9ZyVA9V4ueFCk1wFAI
   sRZQ7YsrUnhQVVI9+GNCaOFCvlIE4JSLKpXt/lDE69+F/T9WxtR7j2ptE
   g==;
X-CSE-ConnectionGUID: R40QBzdkQlq3vwizp8NdpQ==
X-CSE-MsgGUID: supBeSeERvmFUIkLbnBjbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="90071446"
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; 
   d="scan'208";a="90071446"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 01:33:11 -0800
X-CSE-ConnectionGUID: xckijqieSPWemdATEy0URQ==
X-CSE-MsgGUID: Fs1ZO0IXQGyrHBMKrwZEZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; 
   d="scan'208";a="201175400"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.219])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 01:33:10 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 11 Dec 2025 11:33:07 +0200 (EET)
To: Guixin Liu <kanie@linux.alibaba.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, 
    Andy Shevchenko <andriy.shevchenko@intel.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v7 1/2] PCI: Introduce named defines for pci rom
In-Reply-To: <20251211033741.53072-2-kanie@linux.alibaba.com>
Message-ID: <a0f0fead-ee26-943a-53b3-873e8652811f@linux.intel.com>
References: <20251211033741.53072-1-kanie@linux.alibaba.com> <20251211033741.53072-2-kanie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 11 Dec 2025, Guixin Liu wrote:

> This is a preparation patch for the next fix patch.
> Convert some magic numbers to named defines.
> 
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
>  drivers/pci/rom.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/pci/rom.c b/drivers/pci/rom.c
> index e18d3a4383ba..3e00611fa76b 100644
> --- a/drivers/pci/rom.c
> +++ b/drivers/pci/rom.c
> @@ -9,9 +9,20 @@
>  #include <linux/export.h>
>  #include <linux/pci.h>
>  #include <linux/slab.h>
> +#include <linux/bits.h>

Includes should always be ordered alphabetically when they already are so.

Even in to other cases it's better try to place them close to the 
right place wrt. other headers when it comes to alphabetical order, even 
if some pre-existing headers would violate it still.

>  #include "pci.h"
>  
> +#define PCI_ROM_HEADER_SIZE			0x1A
> +#define PCI_ROM_POINTER_TO_DATA_STRUCT		0x18
> +#define PCI_ROM_LAST_IMAGE_INDICATOR		0x15
> +#define PCI_ROM_LAST_IMAGE_INDICATOR_BIT	BIT(7)
> +#define PCI_ROM_IMAGE_LEN			0x10
> +#define PCI_ROM_IMAGE_LEN_UNIT_SZ_512		512
> +#define PCI_ROM_IMAGE_SIGNATURE			0xAA55
> +#define PCI_ROM_DATA_STRUCT_SIGNATURE		0x52494350
> +#define PCI_ROM_DATA_STRUCT_LEN			0x0A
> +
>  /**
>   * pci_enable_rom - enable ROM decoding for a PCI device
>   * @pdev: PCI device to enable

You should convert the literals in the code too in this patch already.

I know it's a bit work to rebase the second patch on top of this, but you 
actually don't need to do it that way (you can just make changes to this 
patch and then use git diff to produce the very same end result so you 
don't need to resolve any rebase conflicts).

-- 
 i.


