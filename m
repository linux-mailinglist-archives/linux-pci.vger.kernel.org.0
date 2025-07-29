Return-Path: <linux-pci+bounces-33109-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E21AB14D96
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 14:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A548218A2D26
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 12:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE7329008E;
	Tue, 29 Jul 2025 12:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DWuZ/1XI"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A757C262FF5;
	Tue, 29 Jul 2025 12:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753791802; cv=none; b=an0uk6ufOt3wy65KcWBTxJs6YZsv9u25q6+lUnEpkcapJHnKQbnA4U48qsCvC/vKOB00wbVJWIBUpwJHJHA5tYE3IKQ8kCmYEEF+Jhx39fP10Mx7WobHDVtpAZ9yPbx8U3kJPFwXyJu8PzxnA3NpaKAGTcsWmupk1IPZ646GRNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753791802; c=relaxed/simple;
	bh=c5ql2LwbSyC1j3Y9FvlSg+2VJwZHQ/nuHeE6q7BYeUA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/4zX9Ljp+DUpwu/+liGsU9ye6g6A9Pyos1QHuuE5mMSymcypSTRHLrhBLyH0UFb5zBHl80pvImGWnLkh2s9cRL8uvntR3y4NCPQREuwwzu/5xGMmxEEZrPuIk58EBtWKPLrTz5WA2NM/2yJ96X1K5nQYkDaaGofagQoal1Fcxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DWuZ/1XI; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56TCMl4J2961788;
	Tue, 29 Jul 2025 07:22:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1753791767;
	bh=e3nvlVKCBTyX8mAmnTYnSsQqdWgC+ufyRK3D5Obt8JY=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=DWuZ/1XIfjmPZlUOl94+pdKxZ5J8e0VklOebRtp4dV9VdOR1CGD05BddmBEALqrkE
	 lYjxNdc2sCoVe0VPs287oEBFNlm/3G0VgwRR3CtGHiRA8yvSUGmipwLOtn2M8Y7W/7
	 DsiYjKClx2INZc4J7KZLZZQ1DSL/Pn4L3hhU1ZXA=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56TCMlRP1804735
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 29 Jul 2025 07:22:47 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 29
 Jul 2025 07:22:46 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 29 Jul 2025 07:22:46 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56TCMkDw3701653;
	Tue, 29 Jul 2025 07:22:46 -0500
Date: Tue, 29 Jul 2025 07:22:46 -0500
From: Nishanth Menon <nm@ti.com>
To: <huaqian.li@siemens.com>
CC: <lkp@intel.com>, <baocheng.su@siemens.com>, <bhelgaas@google.com>,
        <christophe.jaillet@wanadoo.fr>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <diogo.ivo@siemens.com>,
        <helgaas@kernel.org>, <jan.kiszka@siemens.com>, <kristo@kernel.org>,
        <krzk+dt@kernel.org>, <kw@linux.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <lpieralisi@kernel.org>,
        <oe-kbuild-all@lists.linux.dev>, <robh@kernel.org>,
        <s-vadapalli@ti.com>, <ssantosh@kernel.org>, <vigneshr@ti.com>
Subject: Re: [PATCH v12 3/7] soc: ti: Add IOMMU-like PVU driver
Message-ID: <20250729122246.o7upnxvqnp7nltdo@harmonize>
References: <20250728023701.116963-1-huaqian.li@siemens.com>
 <20250728023701.116963-4-huaqian.li@siemens.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250728023701.116963-4-huaqian.li@siemens.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 10:36-20250728, huaqian.li@siemens.com wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> The TI Peripheral Virtualization Unit (PVU) permits to define a limited
> set of mappings for DMA requests on the system memory. Unlike with an
> IOMMU, there is no fallback to a memory-backed page table, only a fixed
> set of register-backed TLBs. Emulating an IOMMU behavior appears to be
> the more fragile the more fragmentation of pending requests occur.
> 
> Therefore, this driver does not expose the PVU as an IOMMU. It rather
> introduces a simple, static interface to devices that are under
> restricted-dma-pool constraints. They can register their pools with the
> PVUs, enabling only those pools to work for DMA. As also MSI is issued
> as DMA, the PVU already register the related translator region of the
> AM654 as valid DMA target.
> 
> This driver is the essential building block for limiting DMA from
> untrusted devices to clearly defined memory regions in the absence of a
> real IOMMU (SMMU).
> 
> Co-developed-by: Diogo Ivo <diogo.ivo@siemens.com>
> Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> Signed-off-by: Li Hua Qian <huaqian.li@siemens.com>
> ---
>  drivers/soc/ti/Kconfig  |   4 +
>  drivers/soc/ti/Makefile |   1 +
>  drivers/soc/ti/ti-pvu.c | 500 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/ti-pvu.h  |  32 +++
>  4 files changed, 537 insertions(+)
>  create mode 100644 drivers/soc/ti/ti-pvu.c
>  create mode 100644 include/linux/ti-pvu.h
> 
> diff --git a/drivers/soc/ti/Kconfig b/drivers/soc/ti/Kconfig
> index 1a93001c9e36..af7173ad84de 100644
> --- a/drivers/soc/ti/Kconfig
> +++ b/drivers/soc/ti/Kconfig
> @@ -82,6 +82,10 @@ config TI_PRUSS
>  	  processors on various TI SoCs. It's safe to say N here if you're
>  	  not interested in the PRU or if you are unsure.
>  
> +config TI_PVU
> +	bool "TI Peripheral Virtualization Unit driver"

tristate please? Prefer to make this as a module.


-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource

