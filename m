Return-Path: <linux-pci+bounces-43108-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF758CC1E8E
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 11:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 870843011767
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 10:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA18C30CDA9;
	Tue, 16 Dec 2025 10:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W1jEsbB5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF1D56B81;
	Tue, 16 Dec 2025 10:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765879738; cv=none; b=KKAXcNJbKRIq1ScJfTLrybNxv/NWHK4YZd9F1Zcv5ez6/82ZH/MctHXKQdrLuBKoTHstSyA7bObzDSPx+LxXXHfQy3CBxnYv0OdbIt4Fz8i38oHKlgaVtFrnYa9quTxOdeoHu2xrYg4mv9T447A8wQ9vk3YVG2rROkREsjr8sWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765879738; c=relaxed/simple;
	bh=f9lktMn2hmftIx9aAqVPfp8+So+x81HfeCQwCl/V8ds=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=N1Xx3KWwgWgb/8O9H3HAkCTdps7qVxM2Qb5NqXO7tKkWwDaMcJLtsvBaZ5PCe7hNtzx3IrZvQclunFxSZ4ZqlrubG0+FlQO85lY7lplBFrsQJlXpBEsqVJjwlZv1pwqWx4kWq0mKypHVoRIj9MBlV2ndMkI8Q/KviYuUxQvZ/UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W1jEsbB5; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765879736; x=1797415736;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=f9lktMn2hmftIx9aAqVPfp8+So+x81HfeCQwCl/V8ds=;
  b=W1jEsbB5mxPBo461kFThfSI5Wu/AFoWBumb8QWPdtcspOdP/lxdqroHL
   aKkSirvudA+7UTudZnYqiWYahwu6dAF/fTWpwiGzE9HhacM7M06BNeAwS
   sadIhD4oNauQ8rAH5PMZn+4pQWgtuTFjf51dKgCjHoXU/vvc1aO/mXrRm
   3ONnTulNwy5nbb/x5iMMgn7/EwMUIPdDKKLwjduQwPZeufXz+t6srnP2H
   WIRY1z2nFuwKUs9pbZQSBPfiKUo7TP9HVx87EHuOrwa/DoiYuXxMpJexA
   E77EZBRH9T9lGMH5Un8Ppvu0rx2qr1WI2e5LG7Z/1KEVN2SSaqw48jPTG
   Q==;
X-CSE-ConnectionGUID: AFSUaXZLQaOxJuuSaLazJg==
X-CSE-MsgGUID: Rq/wdW1iSS2uvFEE2A4dMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="67733428"
X-IronPort-AV: E=Sophos;i="6.20,256,1758610800"; 
   d="scan'208";a="67733428"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2025 02:08:56 -0800
X-CSE-ConnectionGUID: 1g3NbFcASx6Wn08fZ2c28g==
X-CSE-MsgGUID: spWL6yb8S1ajjzjlfZdVPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,152,1763452800"; 
   d="scan'208";a="197873334"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.4])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2025 02:08:51 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 16 Dec 2025 12:08:48 +0200 (EET)
To: Yang Zhang <zhangz@hygon.cn>
cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
    dave.hansen@linux.intel.com, hpa@zytor.com, bhelgaas@google.com, 
    x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-pci@vger.kernel.org
Subject: Re: [PATCH] X86/PCI: Prioritize MMCFG access to hardware registers
In-Reply-To: <20251216100332.6610-1-zhangz@hygon.cn>
Message-ID: <07428f84-5fa3-713f-caac-f69c0e92c779@linux.intel.com>
References: <20251216100332.6610-1-zhangz@hygon.cn>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 16 Dec 2025, Yang Zhang wrote:

> As CPU performance demands increase, the configuration of some internal CPU
> registers needs to be dynamically configured in the program, such as
> configuring memory controller strategies within specific time windows.
> These configurations place high demands on the efficiency of the
> configuration instructions themselves, requiring them to retire and
> take effect as quickly as possible.
> 
> However, the current kernel code forces the use of the IO Port method for
> PCI accesses with domain=0 and offset less than 256. The IO Port method is
> more like a legacy from historical reasons, and its performance is lower
> than that of the MMCFG method. We conducted comparative tests on AMD and
> Hygon CPUs respectively, even without considering the impact of indirect
> access (IO Ports use 0xCF8 and 0xCFC), simply comparing the performance of
> the following two code:
> 
> 1)outl(0x400702,0xCFC);
> 
> 2)mmio_config_writel(data_addr,0x400702);
> 
> while both codes access the same register. The results shows the MMCFG
> (400+ cycle per access) method outperforms the IO Port (1000+ cycle
> per access) by twice.
> 
> Through PMC/PMU event statistics within the AMD/Hygon microarchitecture,
> we found IO Port access causes more stalls within the CPU's internal
> dispatch module, and these stalls are mainly due to the front-end's
> inability to decode the corresponding uops in a timely manner.
> Therefore the main reason for the performance difference between the
> two access methods is that the in/out instructions corresponding to
> the IO Port access belong to microcode, and therefore their decoding
> efficiency is lower than that of mmcfg.
> 
> For CPUs that support both MMCFG and IO Port access methods, if a hardware
> register only supports IO Port access, this configuration may lead to
> illegal access. However, we think registers that support I/O Port access
> have corresponding MMCFG addresses. Even we test several AMD/Hygon CPUs
> with this patch and found no problems, we still cannot rule out the
> possibility that all CPUs are problem-free, especially older CPUs. To
> address this risk, we have created a new macro, PREFER MMCONFIG, allowing
> users to choose whether or not to enable this feature.
> 
> Signed-off-by: Yang Zhang <zhangz@hygon.cn>
> ---
>  arch/x86/Kconfig      | 15 +++++++++++++++
>  arch/x86/pci/common.c | 14 ++++++++++++++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 80527299f..037d56690 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2932,6 +2932,21 @@ config PCI_MMCONFIG
>  
>  	  Say Y otherwise.
>  
> +config PREFER_MMCONFIG
> +        bool "Perfer to use mmconfig over IO Port"

Prefer

-- 
 i.

> +        depends on PCI_MMCONFIG
> +        help
> +          This setting will prioritize the use of mmcfg, which is superior to
> +          io port from a performance perspective, mainly for the following reasons:
> +          1) io port is an indirect access; 2) io port instructions are decoded
> +          by microcode, which is more likely to cause CPU front-end bound compared
> +          to mmcfg using mov instructions.
> +
> +          For CPUs that support both MMCFG and IO Port access methods, if a
> +          hardware register only supports IO Port access, this configuration
> +          may lead to illegal access. Therefore, users must ensure that the
> +          configuration will not cause any exceptions before enabling it.
> +
>  config PCI_OLPC
>  	def_bool y
>  	depends on PCI && OLPC && (PCI_GOOLPC || PCI_GOANY)
> diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
> index ddb798603..8bde5d1df 100644
> --- a/arch/x86/pci/common.c
> +++ b/arch/x86/pci/common.c
> @@ -40,20 +40,34 @@ const struct pci_raw_ops *__read_mostly raw_pci_ext_ops;
>  int raw_pci_read(unsigned int domain, unsigned int bus, unsigned int devfn,
>  						int reg, int len, u32 *val)
>  {
> +#ifdef CONFIG_PREFER_MMCONFIG
> +	if (raw_pci_ext_ops)
> +		return raw_pci_ext_ops->read(domain, bus, devfn, reg, len, val);
> +	if (domain == 0 && reg < 256 && raw_pci_ops)
> +		return raw_pci_ops->read(domain, bus, devfn, reg, len, val);
> +#else
>  	if (domain == 0 && reg < 256 && raw_pci_ops)
>  		return raw_pci_ops->read(domain, bus, devfn, reg, len, val);
>  	if (raw_pci_ext_ops)
>  		return raw_pci_ext_ops->read(domain, bus, devfn, reg, len, val);
> +#endif
>  	return -EINVAL;
>  }
>  
>  int raw_pci_write(unsigned int domain, unsigned int bus, unsigned int devfn,
>  						int reg, int len, u32 val)
>  {
> +#ifdef CONFIG_PREFER_MMCONFIG
> +	if (raw_pci_ext_ops)
> +		return raw_pci_ext_ops->write(domain, bus, devfn, reg, len, val);
> +	if (domain == 0 && reg < 256 && raw_pci_ops)
> +		return raw_pci_ops->write(domain, bus, devfn, reg, len, val);
> +#else
>  	if (domain == 0 && reg < 256 && raw_pci_ops)
>  		return raw_pci_ops->write(domain, bus, devfn, reg, len, val);
>  	if (raw_pci_ext_ops)
>  		return raw_pci_ext_ops->write(domain, bus, devfn, reg, len, val);
> +#endif
>  	return -EINVAL;
>  }
>  
> 


