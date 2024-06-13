Return-Path: <linux-pci+bounces-8760-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C23907E04
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 23:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32F0C1F23F18
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 21:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA7E13D250;
	Thu, 13 Jun 2024 21:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HLhHhgo7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D3113B7BD;
	Thu, 13 Jun 2024 21:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718313588; cv=none; b=TJgKq33eFA6aRX/1TNC9OnuWU+Q8dGddUMCHipJq63Mh0r1UGsfDwjz8IiLLvyf57ClryPys7A0pAAjLRrPBKaDBUFkK/Nb/dIqfLUfEIt7mIvU9x/WO+XNRRYXAZdlN6IE+YKaCE50ePFuw6jwMF33RvAnh1Edk3tmXipLREXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718313588; c=relaxed/simple;
	bh=TzIfeQElLeC1iCsomI6qo1dQv7VLHdFCJPC7CXZC8H0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rUh5FofDDhCHttRFPpmjrCjdhhND/B1Lj5JzRTLVdQdQLjllWSq06iuCR/t3bHXuz09OgsEYQLNwfNBatvvoyT1C2e0brmgMYLjyU08ZzsnHac6GVzgMqGI+qoHRz3RJc94JiC8ioP7DSQoPyzZ0wCrJYeJGy+OBqUS4YadQRKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HLhHhgo7; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718313586; x=1749849586;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TzIfeQElLeC1iCsomI6qo1dQv7VLHdFCJPC7CXZC8H0=;
  b=HLhHhgo7tdZ5QkZRuM1RqxpZgaRZWLCAojmYzRbmc9x825AQQ7oc7Ast
   P/w1Zif25TslR2172IYeZoXEHjpGqASBoNHA4EQ/Bwl4aWKPlcbJrq6rA
   17P2ZwpPorlnDuqPgCeANHGkyiUD6jytyX+w7nkhIMGGmhXbM69oqkM9n
   Yrj866DpNSaLPr33W6i8jmQyCvgE0p7V7pyGEGQ4N5XJbu3koOpcMy/Mm
   xd6CshEYEzDoLv75E26j/OimQ5SbmGUhLAqI6Kpr4zjs6+kqrtDoPpoNX
   NovX6TJwpnCwhIjdGC7FtiCYe7H6Wbtyvj/APpTpKZbEJcLLohFNJa1k6
   w==;
X-CSE-ConnectionGUID: oZ7eAmQBQhOWyT7DY45d7w==
X-CSE-MsgGUID: GPLqgeCgS5CPFjV1k6zx/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="18958381"
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="18958381"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 14:19:45 -0700
X-CSE-ConnectionGUID: hHqzUJMmSaqHzTm8Qxa8Zw==
X-CSE-MsgGUID: R6xbkzjvStmUisn2kMKNbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="40408987"
Received: from patelni-desk.amr.corp.intel.com (HELO localhost) ([10.2.132.135])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 14:19:45 -0700
Date: Thu, 13 Jun 2024 14:19:43 -0700
From: Nirmal Patel <nirmal.patel@linux.intel.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
 <kw@linux.com>, Rob Herring <robh@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar
 <alim.akhtar@samsung.com>, Will Deacon <will@kernel.org>, Joyce Ooi
 <joyce.ooi@intel.com>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, Marc
 Zyngier <maz@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Jianjun Wang
 <jianjun.wang@mediatek.com>, Sergio Paracuellos
 <sergio.paracuellos@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Jonathan Derrick <jonathan.derrick@linux.dev>, <linux-pci@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-mediatek@lists.infradead.org>, <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] PCI: controller: add missing MODULE_DESCRIPTION()
 macros
Message-ID: <20240613141943.00006cf5@linux.intel.com>
In-Reply-To: <20240610-md-drivers-pci-controller-v1-1-b998c242df55@quicinc.com>
References: <20240610-md-drivers-pci-controller-v1-1-b998c242df55@quicinc.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Jun 2024 18:04:34 -0700
Jeff Johnson <quic_jjohnson@quicinc.com> wrote:

> When ARCH=x86, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in
> drivers/pci/controller/dwc/pci-exynos.o WARNING: modpost: missing
> MODULE_DESCRIPTION() in drivers/pci/controller/pci-host-generic.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in
> drivers/pci/controller/pcie-altera.o WARNING: modpost: missing
> MODULE_DESCRIPTION() in drivers/pci/controller/pcie-altera-msi.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in
> drivers/pci/controller/pcie-mediatek.o WARNING: modpost: missing
> MODULE_DESCRIPTION() in drivers/pci/controller/pcie-mediatek-gen3.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in
> drivers/pci/controller/vmd.o WARNING: modpost: missing
> MODULE_DESCRIPTION() in drivers/pci/controller/pcie-apple.o WARNING:
> modpost: missing MODULE_DESCRIPTION() in
> drivers/pci/controller/pcie-mt7621.o
> 
> Add the missing invocations of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
> Corrections to these descriptions are welcomed. I'm not an expert in
> this code so in most cases I've taken these descriptions directly from
> code comments, Kconfig descriptions, or git logs.  History has shown
> that in some cases these are originally wrong due to cut-n-paste
> errors, and in other cases the drivers have evolved such that the
> original information is no longer accurate.
> 
> Also let me know if any individual changes need to be split into a
> separate patch to go through a separate maintainer tree.
> ---
>  drivers/pci/controller/dwc/pci-exynos.c     | 1 +
>  drivers/pci/controller/pci-host-common.c    | 1 +
>  drivers/pci/controller/pci-host-generic.c   | 1 +
>  drivers/pci/controller/pcie-altera-msi.c    | 1 +
>  drivers/pci/controller/pcie-altera.c        | 1 +
>  drivers/pci/controller/pcie-apple.c         | 1 +
>  drivers/pci/controller/pcie-mediatek-gen3.c | 1 +
>  drivers/pci/controller/pcie-mediatek.c      | 1 +
>  drivers/pci/controller/pcie-mt7621.c        | 1 +
>  drivers/pci/controller/vmd.c                | 1 +
>  10 files changed, 10 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-exynos.c
> b/drivers/pci/controller/dwc/pci-exynos.c index
> a33fa98a252e..79d83fe85d3b 100644 ---
> a/drivers/pci/controller/dwc/pci-exynos.c +++
> b/drivers/pci/controller/dwc/pci-exynos.c @@ -437,5 +437,6 @@ static
> struct platform_driver exynos_pcie_driver = { },
>  };
>  module_platform_driver(exynos_pcie_driver);
> +MODULE_DESCRIPTION("PCIe host controller driver for Samsung Exynos
> SoCs"); MODULE_LICENSE("GPL v2");
>  MODULE_DEVICE_TABLE(of, exynos_pcie_of_match);
> diff --git a/drivers/pci/controller/pci-host-common.c
> b/drivers/pci/controller/pci-host-common.c index
> 45b71806182d..60f5e328314e 100644 ---
> a/drivers/pci/controller/pci-host-common.c +++
> b/drivers/pci/controller/pci-host-common.c @@ -96,4 +96,5 @@ void
> pci_host_common_remove(struct platform_device *pdev) }
>  EXPORT_SYMBOL_GPL(pci_host_common_remove);
>  
> +MODULE_DESCRIPTION("Generic PCI host driver common code");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/pci/controller/pci-host-generic.c
> b/drivers/pci/controller/pci-host-generic.c index
> 41cb6a057f6e..cb911863a3cb 100644 ---
> a/drivers/pci/controller/pci-host-generic.c +++
> b/drivers/pci/controller/pci-host-generic.c @@ -86,4 +86,5 @@ static
> struct platform_driver gen_pci_driver = { };
>  module_platform_driver(gen_pci_driver);
>  
> +MODULE_DESCRIPTION("Simple, generic PCI host controller driver");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/pci/controller/pcie-altera-msi.c
> b/drivers/pci/controller/pcie-altera-msi.c index
> 6ad5427490b5..25ad1717f1d8 100644 ---
> a/drivers/pci/controller/pcie-altera-msi.c +++
> b/drivers/pci/controller/pcie-altera-msi.c @@ -290,4 +290,5 @@ static
> void __exit altera_msi_exit(void) subsys_initcall(altera_msi_init);
>  MODULE_DEVICE_TABLE(of, altera_msi_of_match);
>  module_exit(altera_msi_exit);
> +MODULE_DESCRIPTION("Altera PCIe MSI support");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/pci/controller/pcie-altera.c
> b/drivers/pci/controller/pcie-altera.c index
> a9536dc4bf96..ef73baefaeb9 100644 ---
> a/drivers/pci/controller/pcie-altera.c +++
> b/drivers/pci/controller/pcie-altera.c @@ -826,4 +826,5 @@ static
> struct platform_driver altera_pcie_driver = { 
>  MODULE_DEVICE_TABLE(of, altera_pcie_of_match);
>  module_platform_driver(altera_pcie_driver);
> +MODULE_DESCRIPTION("Altera PCIe host controller driver");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/pci/controller/pcie-apple.c
> b/drivers/pci/controller/pcie-apple.c index
> f7a248393a8f..5850bc84d58d 100644 ---
> a/drivers/pci/controller/pcie-apple.c +++
> b/drivers/pci/controller/pcie-apple.c @@ -839,4 +839,5 @@ static
> struct platform_driver apple_pcie_driver = { };
>  module_platform_driver(apple_pcie_driver);
>  
> +MODULE_DESCRIPTION("PCIe host bridge driver for Apple
> system-on-chips"); MODULE_LICENSE("GPL v2");
> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c
> b/drivers/pci/controller/pcie-mediatek-gen3.c index
> 975b3024fb08..b7e8e24f6a40 100644 ---
> a/drivers/pci/controller/pcie-mediatek-gen3.c +++
> b/drivers/pci/controller/pcie-mediatek-gen3.c @@ -1091,4 +1091,5 @@
> static struct platform_driver mtk_pcie_driver = { };
>  
>  module_platform_driver(mtk_pcie_driver);
> +MODULE_DESCRIPTION("MediaTek Gen3 PCIe host controller driver");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/pci/controller/pcie-mediatek.c
> b/drivers/pci/controller/pcie-mediatek.c index
> 48372013f26d..7fc0d7709b7f 100644 ---
> a/drivers/pci/controller/pcie-mediatek.c +++
> b/drivers/pci/controller/pcie-mediatek.c @@ -1252,4 +1252,5 @@ static
> struct platform_driver mtk_pcie_driver = { },
>  };
>  module_platform_driver(mtk_pcie_driver);
> +MODULE_DESCRIPTION("MediaTek PCIe host controller driver");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/pci/controller/pcie-mt7621.c
> b/drivers/pci/controller/pcie-mt7621.c index
> d97b956e6e57..9989e5e614b9 100644 ---
> a/drivers/pci/controller/pcie-mt7621.c +++
> b/drivers/pci/controller/pcie-mt7621.c @@ -549,4 +549,5 @@ static
> struct platform_driver mt7621_pcie_driver = { };
>  builtin_platform_driver(mt7621_pcie_driver);
>  
> +MODULE_DESCRIPTION("MediaTek MT7621 PCIe controller");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/pci/controller/vmd.c
> b/drivers/pci/controller/vmd.c index 87b7856f375a..e4d6ae7241fe 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -1128,5 +1128,6 @@ static struct pci_driver vmd_drv = {
>  module_pci_driver(vmd_drv);
>  
>  MODULE_AUTHOR("Intel Corporation");
> +MODULE_DESCRIPTION("Volume Management Device driver");
>  MODULE_LICENSE("GPL v2");
>  MODULE_VERSION("0.6");
> 
> ---
> base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
> change-id: 20240610-md-drivers-pci-controller-8de8948a2b92
> 

For VMD

Acked-by: Nirmal Patel <nirmal.patel@linux.intel.com>

