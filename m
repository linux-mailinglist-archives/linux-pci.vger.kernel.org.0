Return-Path: <linux-pci+bounces-28842-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7002CACC2AA
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 11:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B737A18913AA
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 09:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA91271461;
	Tue,  3 Jun 2025 09:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ITlbR5yU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF61F2AEF1;
	Tue,  3 Jun 2025 09:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748941712; cv=none; b=SLT6XsgNoJzSoy1VEn/OzceLu6R6jfHAlS1TUG9VGb9a3doXhn6Qogg5lg8E7KiKt3Qjl6a1CCXeyjWTX5iB45pQIx7yCoasQfaxUA9mMV/1PcjPWMmi3Ge2kzIGfUd20sh4Alh0M5reo/kUMlIrHLMIcIEZjjAk5dqa8bcD5Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748941712; c=relaxed/simple;
	bh=IswifkJ14b6Qj/KMAySJWElie407gnu73HSYulfH4kM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FiRN/Nf03jbdNUPF4z7LzDJIMlz6kr8ol3vWswSZZwzmISnT6rgTVot6kGk43ZoUVHQC+27/hdVKXzOw+Vj9mvbFv7Y9IIOKcEYbwssugNMQl3q32yksvi9Tz3kLFwP93k41YhiGDeSdHT4w9dfJ9mGPCRj/TQ716EReP+Nf2Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ITlbR5yU; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748941711; x=1780477711;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=IswifkJ14b6Qj/KMAySJWElie407gnu73HSYulfH4kM=;
  b=ITlbR5yUaX1/wTKrvrM1sMynaFe+dQLDGDWDXJBq0EeFAlkgGlc3wSGy
   YLAdwGuxf5gJi+Llu7V6moxWM5llfKu6GkcYwzO/5rhZ8pCLdRBVIXvxF
   0IhB1ENZH0FzeaUheIg70bGoMUOLB2+Sjjmb1qfLQ0i3KUzVYjhibXUAv
   c+Y0OcNsFzq2N6G5HYhy0t80Fu9tvPFQNyDZ9UGV5TvtBYQZ9bNlrOZnq
   +FMWAUjZhdej7DA00EHssu+MWcwGNb9ogfSnJjM1/jY54swgaLFVp2miX
   4U56XEDfHfWev/deYVc13CtGnm5TuwH9nhD9V/mULRIdFSHJnb2dHfIUF
   w==;
X-CSE-ConnectionGUID: T0WgC+HSTqeKlcRfgHqW4g==
X-CSE-MsgGUID: mjS6cPlFTSmT6xPayl1/Ww==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="62029074"
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; 
   d="scan'208";a="62029074"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 02:08:29 -0700
X-CSE-ConnectionGUID: QtfAGtGwRh6h3icI3bvXTg==
X-CSE-MsgGUID: vgUXOCIfT2Kpiwo/W0UnbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; 
   d="scan'208";a="145757589"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.141])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 02:08:25 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 3 Jun 2025 12:08:22 +0300 (EEST)
To: Hans Zhang <18255117159@163.com>
cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
    krzk+dt@kernel.org, manivannan.sadhasivam@linaro.org, jingoohan1@gmail.com, 
    robh@kernel.org, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] PCI: Add PCIE_SPEED2LNKCTL2_TLS_ENC conversion
 macro
In-Reply-To: <20250519163156.217567-2-18255117159@163.com>
Message-ID: <9bc475b4-4924-1b0f-af3e-ec4fa8140765@linux.intel.com>
References: <20250519163156.217567-1-18255117159@163.com> <20250519163156.217567-2-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 20 May 2025, Hans Zhang wrote:

> Introduce PCIE_SPEED2LNKCTL2_TLS_ENC macro to standardize the conversion

Use () parenthesis like you'd use them in C so functions and macros in 
changelog should have them appended.

> between PCIe speed enumerations and LNKCTL2_TLS register values. This
> centralizes speed-to-register mapping logic, eliminating duplicated
> conversion code across multiple drivers.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
>  drivers/pci/pci.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index f92928dadc6a..b7e2d08825c6 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -415,6 +415,15 @@ void pci_bus_put(struct pci_bus *bus);
>  	 (lnkctl2) == PCI_EXP_LNKCTL2_TLS_2_5GT ? PCIE_SPEED_2_5GT : \
>  	 PCI_SPEED_UNKNOWN)
>  
> +#define PCIE_SPEED2LNKCTL2_TLS_ENC(speed) \

I'm not a big fan of including that _ENC there, it just makes the long 
name even longer and doesn't really provide added value, IMO.

Other than those, this change logs fine.

> +	((speed) == PCIE_SPEED_2_5GT ? PCI_EXP_LNKCTL2_TLS_2_5GT : \
> +	 (speed) == PCIE_SPEED_5_0GT ? PCI_EXP_LNKCTL2_TLS_5_0GT : \
> +	 (speed) == PCIE_SPEED_8_0GT ? PCI_EXP_LNKCTL2_TLS_8_0GT : \
> +	 (speed) == PCIE_SPEED_16_0GT ? PCI_EXP_LNKCTL2_TLS_16_0GT : \
> +	 (speed) == PCIE_SPEED_32_0GT ? PCI_EXP_LNKCTL2_TLS_32_0GT : \
> +	 (speed) == PCIE_SPEED_64_0GT ? PCI_EXP_LNKCTL2_TLS_64_0GT : \
> +	 0)
> +
>  /* PCIe speed to Mb/s reduced by encoding overhead */
>  #define PCIE_SPEED2MBS_ENC(speed) \
>  	((speed) == PCIE_SPEED_64_0GT ? 64000*1/1 : \
> 

-- 
 i.


