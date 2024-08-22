Return-Path: <linux-pci+bounces-11989-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 979BB95B139
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 11:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ED531F22D32
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 09:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B57917084F;
	Thu, 22 Aug 2024 09:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V7caCqqM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1061C6B5;
	Thu, 22 Aug 2024 09:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724318040; cv=none; b=gEYr6d2NvHbSB3BKr3qEyjrzYnyLlIrsIMduWL7nNv2s6HqrNpjS6ePcFerH3PYeCRj63uhjX4laNg2navusq6Bt29K6+9sBCBwVfxwY7nfSiP89S5UTI9xPegmBmKa1JjQlwl/gEi3aPhRDSKZMyG7vbfCdJOt57JUeJyPJPEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724318040; c=relaxed/simple;
	bh=rXJDC/w4XjnwLzyRijLVTTmhmJ4yQ3CslilWco2rv6k=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Tz45pqbFWFoIbndxt6qAWkPo9AjIiewm/wquwaUjLZH2rOPV62o9xmNQFLYehdYr0aMc9bnbZu8zZsKgUTw2bkBuGIKTQtfOFO71XM9+I2ROfmhqzLf9Qmtzf7lvZ5MQ0z/b/wJkxwcY+1jeBlfqA6zQOvZE1jILgWe1HtyknFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V7caCqqM; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724318038; x=1755854038;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=rXJDC/w4XjnwLzyRijLVTTmhmJ4yQ3CslilWco2rv6k=;
  b=V7caCqqMxlkANDQ1xUYyiDNGL1ZDPvcH9xUar9m9yos+kgLomzZkrAAh
   j9dO1TN0M0XPmiGK/V1Bmlk3bobFq33EllfvWKIPJHJmpPupl3WtRkKGP
   2Z/Jnqs+KkZflaiP/woC7e83Vh76WiHkwASwpgh/a3NQbB/IBnAvJBqvK
   NfrGtDzU9VWMZ4S08Rs9QyoYaPkmuIN16vXraqrUtZLA7kdVQdCuH/yxI
   lATt4DaR/fhhNsT05TS5zzCT/eJnH/ae4VqmUztSmaPqUMMNLkpCI9eg0
   o6fC7UkN4RB78cFI9uQT28z4tOygY6nIaVclqHD79GbiOLM/kDj1AYBYW
   g==;
X-CSE-ConnectionGUID: zoWFvNXYR06DQH0HXJOtuA==
X-CSE-MsgGUID: Bw2F8JzyTaOpzIAjgna9dg==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="33873346"
X-IronPort-AV: E=Sophos;i="6.10,166,1719903600"; 
   d="scan'208";a="33873346"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 02:13:52 -0700
X-CSE-ConnectionGUID: S+E1D7ZnRjW/IPV7cEyJNQ==
X-CSE-MsgGUID: RJkoOjyvRU+QjwiXZzaeEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,166,1719903600"; 
   d="scan'208";a="61702096"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.82])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 02:13:49 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 22 Aug 2024 12:13:45 +0300 (EEST)
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
cc: Matthew W Carlis <mattc@purestorage.com>, 
    Bjorn Helgaas <bhelgaas@google.com>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    Oliver O'Halloran <oohall@gmail.com>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] PCI: Revert to the original speed after PCIe
 failed link retraining
In-Reply-To: <alpine.DEB.2.21.2408091204580.61955@angie.orcam.me.uk>
Message-ID: <58809d75-34c1-fc4f-3884-76301a8b5976@linux.intel.com>
References: <alpine.DEB.2.21.2408091017050.61955@angie.orcam.me.uk> <alpine.DEB.2.21.2408091204580.61955@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 9 Aug 2024, Maciej W. Rozycki wrote:

> When `pcie_failed_link_retrain' has failed to retrain the link by hand 
> it leaves the link speed restricted to 2.5GT/s, which will then affect 
> any device that has been plugged in later on, which may not suffer from 
> the problem that caused the speed restriction to have been attempted.  
> Consequently such a downstream device will suffer from an unnecessary 
> communication throughput limitation and therefore performance loss.
> 
> Remove the speed restriction then and revert the Link Control 2 register 
> to its original state if link retraining with the speed restriction in 
> place has failed.  Retrain the link again afterwards to remove any 
> residual state, ignoring the result as it's supposed to fail anyway.
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
>  drivers/pci/quirks.c |   11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> linux-pcie-failed-link-retrain-fail-unclamp.diff
> Index: linux-macro/drivers/pci/quirks.c
> ===================================================================
> --- linux-macro.orig/drivers/pci/quirks.c
> +++ linux-macro/drivers/pci/quirks.c
> @@ -66,7 +66,7 @@
>   * apply this erratum workaround to any downstream ports as long as they
>   * support Link Active reporting and have the Link Control 2 register.
>   * Restrict the speed to 2.5GT/s then with the Target Link Speed field,
> - * request a retrain and wait 200ms for the data link to go up.
> + * request a retrain and check the result.
>   *
>   * If this turns out successful and we know by the Vendor:Device ID it is
>   * safe to do so, then lift the restriction, letting the devices negotiate
> @@ -74,6 +74,10 @@
>   * firmware may have already arranged and lift it with ports that already
>   * report their data link being up.
>   *
> + * Otherwise revert the speed to the original setting and request a retrain
> + * again to remove any residual state, ignoring the result as it's supposed
> + * to fail anyway.
> + *
>   * Return TRUE if the link has been successfully retrained, otherwise FALSE.
>   */
>  bool pcie_failed_link_retrain(struct pci_dev *dev)
> @@ -92,6 +96,8 @@ bool pcie_failed_link_retrain(struct pci
>  	pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
>  	if ((lnksta & (PCI_EXP_LNKSTA_LBMS | PCI_EXP_LNKSTA_DLLLA)) ==
>  	    PCI_EXP_LNKSTA_LBMS) {
> +		u16 oldlnkctl2 = lnkctl2;
> +
>  		pci_info(dev, "broken device, retraining non-functional downstream link at 2.5GT/s\n");
>  
>  		lnkctl2 &= ~PCI_EXP_LNKCTL2_TLS;
> @@ -100,6 +106,9 @@ bool pcie_failed_link_retrain(struct pci
>  
>  		if (pcie_retrain_link(dev, false)) {
>  			pci_info(dev, "retraining failed\n");
> +			pcie_capability_write_word(dev, PCI_EXP_LNKCTL2,
> +						   oldlnkctl2);
> +			pcie_retrain_link(dev, false);

Hi again all,

While rebasing the bandwidth controller patches, I revisited this line and 
realized using false for use_lt is not optimal here.

It would definitely seem better to use LT (true) in this case because it 
likely results in much shorter wait. In hotplug cases w/o a peer device, 
DLLLA will just make the wait last until the timeout, whereas LT would 
short-circuit the training almost right away I think (mostly guessing with 
limited knowledge about LTSSM). We are no longer even expecting the link 
to come up at this point so using DLLLA seems illogical.

Do you agree?

-- 
 i.


