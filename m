Return-Path: <linux-pci+bounces-37362-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD96BB1392
	for <lists+linux-pci@lfdr.de>; Wed, 01 Oct 2025 18:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E08367B0FCC
	for <lists+linux-pci@lfdr.de>; Wed,  1 Oct 2025 16:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAAEB2848AC;
	Wed,  1 Oct 2025 16:12:25 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D16C34BA28;
	Wed,  1 Oct 2025 16:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759335145; cv=none; b=PVuMVIAOmyGx/vGGiOf/ULjy3igYFzS5jF8yugIIvX3ldVSKgERnRR/eZ2IkH8bJhqMShyHul3s/bE37js3CyK7AJlOZcuok39n92v72HTs4v+V8IXJDkJM2e8hzQM1wgQhydKAobvyExmNgCFzt+yEyGvlhNcqF6cnh2JddLpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759335145; c=relaxed/simple;
	bh=9AKfBEaF4yzTvDwYTJVSbIKmdGVfNtriXroo62Fl6vw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oj9UjDuXMPyqhNNGzdeVrkPy3s46gSA3A1/Bd2sThVOt0/mntt3WTdwrZtln1oKU4JmS/h99m8V2BnXX8kLy0GJ9Kca5Zroy0HE4Ugl2F/96jNSByWQw5P0rkS+3T7IqV1SKWhonxllRpTPlbwOLy8Q2mQ2PUX6g8FMcb0De938=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ccKdT2sKbz6L52D;
	Thu,  2 Oct 2025 00:10:05 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id E3E19140142;
	Thu,  2 Oct 2025 00:12:18 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 1 Oct
 2025 17:12:17 +0100
Date: Wed, 1 Oct 2025 17:12:16 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <alucerop@amd.com>, <ira.weiny@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v12 10/25] CXL/AER: Update PCI class code check to use
 FIELD_GET()
Message-ID: <20251001171216.00005fa0@huawei.com>
In-Reply-To: <20250925223440.3539069-11-terry.bowman@amd.com>
References: <20250925223440.3539069-1-terry.bowman@amd.com>
	<20250925223440.3539069-11-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Thu, 25 Sep 2025 17:34:25 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> Update the AER driver's is_cxl_mem_dev() to use FIELD_GET() while checking
> for a CXL Endpoint class code.
> 
> Introduce a genmask bitmask for checking PCI class codes and locate in
> include/uapi/linux/pci_regs.h.
> 
> Update the function documentation to reference the latest CXL
> specification.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> 

The way that class code definitions work in pci_ids.h is somewhat odd
in my opinion, so I'd like input from Bjorn, Lukas etc on whether a
generic mask definition is a good idea or more likely to cause problems.

See for example. 
#define PCI_BASE_CLASS_STORAGE		0x01
...

#define PCI_CLASS_STORAGE_SATA		0x0106
#define PCI_CLASS_STORAGE_SATA_AHCI	0x010601


This variability in what is called CLASS_* leads to fun
situations like in drivers/ata/ahci.c where we have some
PCI_CLASS_* shifted and some not...

> ---
> 
> Changes in v11->v12:
> 
> Changes in v10->v11:
> - Add #include <linux/bitfield.h> to cxl_ras.c
> - Removed line wrapping at "(CXL 3.2, 8.1.12.1)".
> ---
>  drivers/pci/pcie/aer.c         | 1 +
>  drivers/pci/pcie/aer_cxl_rch.c | 6 +++---
>  include/uapi/linux/pci_regs.h  | 2 ++
>  3 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index befa73ace9bb..6ba8f84add70 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -30,6 +30,7 @@
>  #include <linux/kfifo.h>
>  #include <linux/ratelimit.h>
>  #include <linux/slab.h>
> +#include <linux/bitfield.h>
>  #include <acpi/apei.h>
>  #include <acpi/ghes.h>
>  #include <ras/ras_event.h>
> diff --git a/drivers/pci/pcie/aer_cxl_rch.c b/drivers/pci/pcie/aer_cxl_rch.c
> index bfe071eebf67..c3e2d4cbe8cc 100644
> --- a/drivers/pci/pcie/aer_cxl_rch.c
> +++ b/drivers/pci/pcie/aer_cxl_rch.c
> @@ -17,10 +17,10 @@ static bool is_cxl_mem_dev(struct pci_dev *dev)
>  		return false;
>  
>  	/*
> -	 * CXL Memory Devices must have the 502h class code set (CXL
> -	 * 3.0, 8.1.12.1).
> +	 * CXL Memory Devices must have the 502h class code set
> +	 * (CXL 3.2, 8.1.12.1).
>  	 */
> -	if ((dev->class >> 8) != PCI_CLASS_MEMORY_CXL)
> +	if (FIELD_GET(PCI_CLASS_CODE_MASK, dev->class) != PCI_CLASS_MEMORY_CXL)
>  		return false;
>  
>  	return true;
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index bd03799612d3..802a7384f99a 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -73,6 +73,8 @@
>  #define PCI_CLASS_PROG		0x09	/* Reg. Level Programming Interface */
>  #define PCI_CLASS_DEVICE	0x0a	/* Device class */
>  
> +#define PCI_CLASS_CODE_MASK     __GENMASK(23, 8)
> +
>  #define PCI_CACHE_LINE_SIZE	0x0c	/* 8 bits */
>  #define PCI_LATENCY_TIMER	0x0d	/* 8 bits */
>  #define PCI_HEADER_TYPE		0x0e	/* 8 bits */


