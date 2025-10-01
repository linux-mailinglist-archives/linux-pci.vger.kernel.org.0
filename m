Return-Path: <linux-pci+bounces-37360-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBAA1BB1316
	for <lists+linux-pci@lfdr.de>; Wed, 01 Oct 2025 17:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 721831942573
	for <lists+linux-pci@lfdr.de>; Wed,  1 Oct 2025 15:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E89259CA0;
	Wed,  1 Oct 2025 15:58:52 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B010C27FD43;
	Wed,  1 Oct 2025 15:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759334332; cv=none; b=pA8VxMF0yV8a3kF7MQ9+K0q0PVVlLIK2T+AmCNDWrvM81XLmgJP8FdHMhzZO55+7msHn/qS8vaKTAj5NbbP6qq1afnJtmokY+hYjbyW5jhrHKCJm4D2wntDfrfYOt9LXG8h8RmqZLMvdLyQXYjenES+BtmnkwMvCEc6hfKPQsJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759334332; c=relaxed/simple;
	bh=9iXkA7Hb7umjY+DYrImBDguUqZV9CGperOpBzoBALnU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PWBcGI2x6dbdG10HdzWMHu4MVwN+Y620YcTg7kKwrYaGt+ZN+c0RQj1AOcSeU0L9u+8PRnAGhRazOgNfY1wsSdwJeibUbdI+uqzKmZVIXYfwLCEPROscIaHNC7LtXNbSBq65f3RGuADjnCRrV88xw4xaGRiATNKJQWvoWHMPLAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ccKJn416nz6K8pH;
	Wed,  1 Oct 2025 23:55:37 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 1EA641402EB;
	Wed,  1 Oct 2025 23:58:46 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 1 Oct
 2025 16:58:44 +0100
Date: Wed, 1 Oct 2025 16:58:43 +0100
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
Subject: Re: [PATCH v12 07/25] CXL/PCI: Move CXL DVSEC definitions into
 uapi/linux/pci_regs.h
Message-ID: <20251001165843.0000321e@huawei.com>
In-Reply-To: <20250925223440.3539069-8-terry.bowman@amd.com>
References: <20250925223440.3539069-1-terry.bowman@amd.com>
	<20250925223440.3539069-8-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Thu, 25 Sep 2025 17:34:22 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> The CXL DVSECs are currently defined in cxl/core/cxlpci.h. These are not
> accessible to other subsystems.
> 
> Change DVSEC name formatting to follow the existing PCI format in
> pci_regs.h. The current format uses CXL_DVSEC_XYZ. Change to be PCI_DVSEC_CXL_XYZ.
> Reuse the existing formatting.
> 
> Update existing occurrences to match the name change.
> 
> Update the inline documentation to refer to latest CXL spec version.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Maybe we discussed it in earlier versions and I've forgotten but generally renaming
uapi defines is a non starter.

I was kind of assuming lspci used these, but nope, it uses hard coded
value of 3 and it's own defines for the fields. (A younger me even reviewed
the patch adding those :) )

https://github.com/pciutils/pciutils/blob/master/ls-ecaps.c#L1279

However, that doesn't mean other code isn't already using those defines.

Minimum I think would be to state here why you think we can get away with
this change. 

Personally I'd just not bother changing that one.

Jonathan



> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index f5b17745de60..bd03799612d3 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1234,9 +1234,64 @@
>  /* Deprecated old name, replaced with PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE */
>  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE
>  
> -/* Compute Express Link (CXL r3.1, sec 8.1.5) */
> -#define PCI_DVSEC_CXL_PORT				3

This is a userspace header. We can't rename existing definitions
as we have no idea who is using them.   Only option would be to
add a comment making the old ones deprecated and adding new ones alongside.


> -#define PCI_DVSEC_CXL_PORT_CTL				0x0c
> -#define PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001

....

> +/* CXL 3.2 8.1.5: Extensions DVSEC for Ports */
> +#define PCI_DVSEC_CXL_PORT_EXT					3
> +#define   PCI_DVSEC_CXL_PORT_EXT_CTL_OFFSET			0x0c
> +#define    PCI_DVSEC_CXL_PORT_EXT_CTL_UNMASK_SBR		0x00000001


