Return-Path: <linux-pci+bounces-29675-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E436AD8982
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 12:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6689C189BD3B
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 10:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B9C2139B0;
	Fri, 13 Jun 2025 10:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U+Is76Ax"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EB579E1;
	Fri, 13 Jun 2025 10:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749810696; cv=none; b=OERvJ/qm94qHGs94YPEsBebCokB1VfHFzx9iuQdWTav2zPbBUHu/g00UxMjwdXVjPacTugVA4cT7lnKods47SO7024JuBjnrsWBdOdyKskXt20I3kqHsG3PPAduV3wDbrbXCo3ekmiusQEbIURCAO/oVMgZki9COE+Gf90rzunI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749810696; c=relaxed/simple;
	bh=7PfB+D/P+RJF9hYw926xnWuIqsnAnuyUdeN7XwIXwMA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ganA/UVA69rq8Fa9ScTKTK9cPvZUBXP9WGeZq8j9LDtHckjbkj73G7pfpljDUljNKv/8+nZWqynOi38uSfSVSdwKHtuIOQTWz7SZUGzbBwhoJq4rzdX3bBiI67dP0O4qV/9BE7r+J73FIjclo0s3ePVFA0HH0FEvJbXMnsp1k8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U+Is76Ax; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749810695; x=1781346695;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=7PfB+D/P+RJF9hYw926xnWuIqsnAnuyUdeN7XwIXwMA=;
  b=U+Is76AxzwLWlajoo+1v2xnAShmwrudJ2yz/2RDBw+Wz4w6Gynvhu1wn
   lG4KL7wi4i9rHj9muZ9jqkZ2F2XlRuGWX+A3x9KaeUP5qdQggTKiJru2E
   aueWAzB0H3TnbkjKigvtLjn8RlBBWnGOKlCMjfy+blEN0h1jBcJyGPEHf
   jtPWjvgm0DhF3u+ZwugYoF2nICjhft9S8ZC1cKIKBMdlO6cAnivvhzCJ2
   8Iul77L+ovUS7PLgprS2YGfslw5dSdppZjosAq8mceDmqveJbpfBQm+DC
   GIKe0jT2fmdM51Q15xM1iwLYc8K3IjWCxE7xN+QBvPMm6m1CaGORxpmjU
   w==;
X-CSE-ConnectionGUID: JaNMXm3OQnWk45VrFKbwTg==
X-CSE-MsgGUID: yMx0JQbYR9mwII0PE1S7EQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="51898032"
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; 
   d="scan'208";a="51898032"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 03:31:34 -0700
X-CSE-ConnectionGUID: ZHA8esmISNCPCD0TZjeaWA==
X-CSE-MsgGUID: TiQwpTxbTRyex/kwIZCVzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; 
   d="scan'208";a="148686963"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.102])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 03:31:30 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 13 Jun 2025 13:31:27 +0300 (EEST)
To: grwhyte@linux.microsoft.com
cc: linux-pci@vger.kernel.org, shyamsaini@linux.microsoft.com, 
    code@tyhicks.com, Okaya@kernel.org, bhelgaas@google.com, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] PCI: Reduce FLR delay to 10ms for MSFT devices
In-Reply-To: <20250611000552.1989795-3-grwhyte@linux.microsoft.com>
Message-ID: <eb9199fa-1a2a-910c-35f8-ea316a57c55d@linux.intel.com>
References: <20250611000552.1989795-1-grwhyte@linux.microsoft.com> <20250611000552.1989795-3-grwhyte@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 11 Jun 2025, grwhyte@linux.microsoft.com wrote:

> From: Graham Whyte <grwhyte@linux.microsoft.com>
> 
> Add a new quirk to reduce the delay after a FLR to 10ms
> for MSFT devices. These devices complete the FLR well within the default
> 100ms timeframe and this path can be optimized for VF removal during

What is "this path" in this context? Try to avoid vague references like 
that.

> runtime repairs and driver updates. These devices do not support immediate
> readiness or readiness time reporting

When talking about something that relates to PCIe spec, please also refer 
to PCIe spec and use the terminology matching to the spec (+ capitalization).

Missing .

Please also reflow the paragraph as the first line is clearly not full.


This probably belongs more to the previous patch changelog than this one, 
as the justification: I suggest you start by stating the problem. So state 
the spec defined wait (+ spec reference), and why that is problem. Then 
explain the solution in another paragraph.

> Signed-off-by: Graham Whyte <grwhyte@linux.microsoft.com>
> ---
>  drivers/pci/quirks.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index d7f4ee634263..d704606330bd 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -6335,3 +6335,23 @@ static void pci_mask_replay_timer_timeout(struct pci_dev *pdev)
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9750, pci_mask_replay_timer_timeout);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9755, pci_mask_replay_timer_timeout);
>  #endif
> +
> +#define MICROSOFT_2051_SVC 0xb210
> +#define MICROSOFT_2051_MANA_MGMT 0x00b8
> +#define MICROSOFT_2051_MANA_MGMT_GFT 0xb290
> +
> +/*
> + * For devices that don't require the full 100ms sleep
> + * after FLR and do not support immediate readiness or readiness
> + * time reporting
> + */
> +static void pci_fixup_pci_flr_10msec(struct pci_dev *pdev)
> +{
> +	pdev->flr_delay = 10000;

10 * USEC_PER_MSEC

> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSOFT, MICROSOFT_2051_SVC,
> +	pci_fixup_pci_flr_10msec);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSOFT, MICROSOFT_2051_MANA_MGMT,
> +	pci_fixup_pci_flr_10msec);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSOFT, MICROSOFT_2051_MANA_MGMT_GFT,
> +	pci_fixup_pci_flr_10msec);
> 

-- 
 i.


