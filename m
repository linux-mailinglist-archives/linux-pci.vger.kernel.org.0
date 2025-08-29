Return-Path: <linux-pci+bounces-35131-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A693B3C034
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 18:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 796DE188416F
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 16:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86539322DAA;
	Fri, 29 Aug 2025 16:03:30 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E087420010A;
	Fri, 29 Aug 2025 16:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756483410; cv=none; b=nE4ij8PLKdB/gmU9zALwWscKVadB3OJfUaPQr8w0SR084A1Wm+CROZvrWOIS7GV7hlKJ9wejmzw3HvrtiaYbS8/BM7souhvKQgALhercnAwApfz0SiL8csJi/lktLMhKN50oKIyiDYHfFq4CazQ1TEgi+CB6ibARcDt0fG2yCMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756483410; c=relaxed/simple;
	bh=yxTcW0CA76O8bK4vcedj9D8CH0QMmmkuQNHxiPKbik8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cAFeoc3lYPLp7xVTWRo1selF1MdRg8NBOXB2xbFMNq7lSGdASTug/jbangf/b0T7HzhSXlYoVye6GItCfMwB7k/yMn2mUBZVtddKClUAInCU/mNpb0IPv7Sngq4oZXFTjSJDwdjxN5lMLsjH/ZUwsMdy+RD9p8/4PZeIs06dw1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cD30G2GFbz6GFNP;
	Sat, 30 Aug 2025 00:01:02 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id F2E5E140370;
	Sat, 30 Aug 2025 00:03:22 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 29 Aug
 2025 18:03:22 +0200
Date: Fri, 29 Aug 2025 17:03:20 +0100
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
Subject: Re: [PATCH v11 10/23] CXL/AER: Update PCI class code check to use
 FIELD_GET()
Message-ID: <20250829170320.000010a3@huawei.com>
In-Reply-To: <20250827013539.903682-11-terry.bowman@amd.com>
References: <20250827013539.903682-1-terry.bowman@amd.com>
	<20250827013539.903682-11-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 26 Aug 2025 20:35:25 -0500
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

In general I like this change, but maybe we should make a broader use of
it even in this introductory patch.  E.g. use FIELD_PREP()
in cxl_mem_pci_tbl() and perhaps add a define for the mask
of the programming interface as well?

Maybe use it in pci_ids.h (which raises the question of whether
it's in the right place) for PCI_CLASS_BRIDGE_PCI_NORMAL / SUBTRACTIVE
and the various USB definitions that include the programming interface.

Perhaps wider use is something for a follow up, but nice to at least
use it everywhere relevant in the CXL code to make the justification stronger
from the start.

> 
> ---
> Changes in v10->v11:
> - Add #include <linux/bitfield.h> to cxl_ras.c

I think you missed and hit wrong file!

> - Removed line wrapping at "(CXL 3.2, 8.1.12.1)".
> ---
>  drivers/pci/pcie/aer.c        | 1 +
>  drivers/pci/pcie/rch_aer.c    | 6 +++---
>  include/uapi/linux/pci_regs.h | 2 ++
>  3 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 1b5f5b0cdc4f..ed1de9256898 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -30,6 +30,7 @@
>  #include <linux/kfifo.h>
>  #include <linux/ratelimit.h>
>  #include <linux/slab.h>
> +#include <linux/bitfield.h>

This seems unrelated as no use of new stuff in here.
Also, looks from what I can see here to be alphabetical order.


>  #include <acpi/apei.h>
>  #include <acpi/ghes.h>
>  #include <ras/ras_event.h>
> diff --git a/drivers/pci/pcie/rch_aer.c b/drivers/pci/pcie/rch_aer.c
> index bfe071eebf67..c3e2d4cbe8cc 100644
> --- a/drivers/pci/pcie/rch_aer.c
> +++ b/drivers/pci/pcie/rch_aer.c
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
> index 252c06402b13..c7b635f6cf36 100644
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


