Return-Path: <linux-pci+bounces-11588-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE16B94EB41
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2024 12:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 852002805D3
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2024 10:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13710170A04;
	Mon, 12 Aug 2024 10:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UTaqUW0o"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B7216FF5F;
	Mon, 12 Aug 2024 10:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723458908; cv=none; b=D35Q/uY1AXASa5D2bEKKd85HRY0kGtV/aIexIaZ5FOLNY84rFx+En+CeW0ft+/gxPAvMbuHk6kpxfwXbB9rh4SKRnMX4QN1u7nXGpixXtuGsAHweU7cal5zmD9sWWc8da2DcQZR09tjVgYC/vu/WKMMnzP949NNPfO5gfDVpKHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723458908; c=relaxed/simple;
	bh=Q8lXjJUs/uZZaKW5uW3iaBBYrPMoYSSD8SdzFS0UI3E=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=b9foGOXgg9ge7QxNs01n7D8UX9o93QP/QKn+i91lQcLu9nz8xi88aTlUuaPHPQ1wyRZkWsm7RqupPbO6ZemBBweXxFJq6nyKLi2cUi2peCIF/qOTGYi3tlPQZzM1ssf0V39HCKoMXWfJcrFKHxfZJUvrL/Te3Lo3/Fj/SJv/aBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UTaqUW0o; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723458906; x=1754994906;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Q8lXjJUs/uZZaKW5uW3iaBBYrPMoYSSD8SdzFS0UI3E=;
  b=UTaqUW0ocMlg9VGGKzbw4M3EFMzdX79ZrvuVk8pIwVQZ16IAokUQlQ1w
   l3fRc9BD59dKvk5X2Uk+AwadSyUv39wXdKdM3wxR/djAy2yAwq6GTguWE
   KoAXsnpnXVmkcl2rv7szBv60NLiXsl8BvLMCFCo5B4mv/c9byIsP75lhJ
   G1oe1+VwVEKvrfrHTULBjVJ+JzOdiH0RDtOjgVM6RAD1fsj+TSs5HFTLe
   Gwdj8ycpHDQ50p5wV32+u79BKpXM+DGVqVnQVe+gofI0Rx1P73Ky4G6ZN
   UKYRL3M7pez2+37Uhv+hzsa1qFp3a4LVz9NcjphqO81+5OyfFy9Xd4eTG
   Q==;
X-CSE-ConnectionGUID: OU9T1hCtQRWoy1PbyCVg3w==
X-CSE-MsgGUID: 743hZFp2QbamIbzfekBDHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11161"; a="21730666"
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="21730666"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 03:35:05 -0700
X-CSE-ConnectionGUID: JQLSKFUmQn6KUfQwZy2nFQ==
X-CSE-MsgGUID: u+qX6CCzSimYeiDzszwpKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="58934886"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.25])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 03:35:03 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 12 Aug 2024 13:35:00 +0300 (EEST)
To: "Maciej W. Rozycki" <macro@orcam.me.uk>, 
    Bjorn Helgaas <bhelgaas@google.com>
cc: Matthew W Carlis <mattc@purestorage.com>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    Oliver O'Halloran <oohall@gmail.com>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] PCI: Clear the LBMS bit after a link retrain
In-Reply-To: <alpine.DEB.2.21.2408091133140.61955@angie.orcam.me.uk>
Message-ID: <26c94eb5-06b6-8064-acdb-67975bded982@linux.intel.com>
References: <alpine.DEB.2.21.2408091017050.61955@angie.orcam.me.uk> <alpine.DEB.2.21.2408091133140.61955@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 9 Aug 2024, Maciej W. Rozycki wrote:

> The LBMS bit, where implemented, is set by hardware either in response 
> to the completion of retraining caused by writing 1 to the Retrain Link 
> bit or whenever hardware has changed the link speed or width in attempt 
> to correct unreliable link operation.  It is never cleared by hardware 
> other than by software writing 1 to the bit position in the Link Status 
> register and we never do such a write.
> 
> We currently have two places, namely `apply_bad_link_workaround' and 
> `pcie_failed_link_retrain' in drivers/pci/controller/dwc/pcie-tegra194.c 
> and drivers/pci/quirks.c respectively where we check the state of the 
> LBMS bit and neither is interested in the state of the bit resulting 
> from the completion of retraining, both check for a link fault.
> 
> And in particular `pcie_failed_link_retrain' causes issues consequently, 
> by trying to retrain a link where there's no downstream device anymore 
> and the state of 1 in the LBMS bit has been retained from when there was 
> a device downstream that has since been removed.
> 
> Clear the LBMS bit then at the conclusion of `pcie_retrain_link', so 
> that we have a single place that controls it and that our code can track 
> link speed or width changes resulting from unreliable link operation.
> 
> Fixes: a89c82249c37 ("PCI: Work around PCIe link training failures")
> Reported-by: Matthew W Carlis <mattc@purestorage.com>
> Link: https://lore.kernel.org/r/20240806000659.30859-1-mattc@purestorage.com/
> Link: https://lore.kernel.org/r/20240722193407.23255-1-mattc@purestorage.com/
> Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
> Cc: stable@vger.kernel.org # v6.5+
> ---
> New change in v2.
> ---
>  drivers/pci/pci.c |   10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> linux-pcie-retrain-link-lbms-clear.diff
> Index: linux-macro/drivers/pci/pci.c
> ===================================================================
> --- linux-macro.orig/drivers/pci/pci.c
> +++ linux-macro/drivers/pci/pci.c
> @@ -4718,7 +4718,15 @@ int pcie_retrain_link(struct pci_dev *pd
>  		pcie_capability_clear_word(pdev, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_RL);
>  	}
>  
> -	return pcie_wait_for_link_status(pdev, use_lt, !use_lt);
> +	rc = pcie_wait_for_link_status(pdev, use_lt, !use_lt);
> +
> +	/*
> +	 * Clear LBMS after a manual retrain so that the bit can be used
> +	 * to track link speed or width changes made by hardware itself
> +	 * in attempt to correct unreliable link operation.
> +	 */
> +	pcie_capability_write_word(pdev, PCI_EXP_LNKSTA, PCI_EXP_LNKSTA_LBMS);

I see Bjorn already took this series in which is good, it's long overdue 
we finally fix the bugs addressed by this series. :-)

I'm slightly worried this particular change could interfere with the 
intent of pcie_failed_link_retrain() because LBMS is cleared also in the 
failure cases.

In the case of your HW, there's retraining loop by HW so LBMS gets set 
again but if the HW would not retrain in a loop and needs similar gen1 
bootstrap, it's very non-obvious to me how things will end up interacting 
with pcie_retrain_link() call from pcie_aspm_configure_common_clock(). 
That is, this could clear the LBMS indication and another is not going to 
be asserted (and even in case of with the retraining loop, it would be 
racy to get LBMS re-asserted soon enough).

My impression is that things seem to work with the current ordering of the 
code but it seems quite fragile (however, the callchains are quite 
complicated to track so I might have missed something). Perhaps that won't 
matter much in the end with the bandwidth controller coming to rework all 
this anyway but wanted to note this may have caveats.

> +	return rc;
>  }
>  
>  /**
> 

-- 
 i.


