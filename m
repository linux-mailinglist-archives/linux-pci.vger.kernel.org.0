Return-Path: <linux-pci+bounces-39804-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1EDC1FCB8
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 12:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D359188CF42
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 11:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D9A33DEC2;
	Thu, 30 Oct 2025 11:24:17 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43DA343D6A
	for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2025 11:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761823457; cv=none; b=rw47DQp6prWi54z9siyPvFqdmiQo9G3RTgsLQG1C5cRKALPf1SARndMHISBg9nR/omAb2nGCxU/Vt47JgDDdmf/atA4FnHZKzyulDJNPViotraUX3Xiz1RkM1u4Lp+pISCbIHc8CI1vknYGQERPK1pPk+I5PIq9O54UQ2uI7BOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761823457; c=relaxed/simple;
	bh=ukwMcntN0LuV3yanWGLDzg2dlglQ7COnhGe7PLZG2qk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vcp/USj9Xyi/OwZznQlVuqK2pfJFIiuDXZX2jJUvb04akQL/D/18z1JtariOOzMmkgWdYMGxVj3IDuNZ1CIXL6CZSNC+4YyPA0HpHB4f9hHf+NxthH494gN7DRWoWmrRXYqCYwYEdfd5MlGf8pqFtlji/vlBDpFAhyGTImvmEo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cy1r6496kz6L4wc;
	Thu, 30 Oct 2025 19:20:38 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id CD55F14038F;
	Thu, 30 Oct 2025 19:24:13 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 30 Oct
 2025 11:24:12 +0000
Date: Thu, 30 Oct 2025 11:24:11 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<xin@zytor.com>, <chao.gao@intel.com>, Zhenzhong Duan
	<zhenzhong.duan@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>
Subject: Re: [RFC PATCH 21/27] x86/virt/tdx: Add SEAMCALL wrappers for SPDM
 management
Message-ID: <20251030112411.00006734@huawei.com>
In-Reply-To: <20250919142237.418648-22-dan.j.williams@intel.com>
References: <20250919142237.418648-1-dan.j.williams@intel.com>
	<20250919142237.418648-22-dan.j.williams@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Fri, 19 Sep 2025 07:22:30 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> From: Zhenzhong Duan <zhenzhong.duan@intel.com>
> 
> Add several SEAMCALL wrappers for SPDM management. TDX Module requires
> HPA_ARRAY_T structure as input/output parameters for these SEAMCALLs.
> So use tdx_page_array as for these wrappers.
> 
> - TDH.SPDM.CREATE creates SPDM session metadata buffers for TDX Module.
> - TDH.SPDM.DELETE destroys SPDM session metadata and returns these
>   buffers to host, after checking no reference attached to the metadata.
> - TDH.SPDM.CONNECT establishes a new SPDM session with the device.
> - TDH.SPDM.DISCONNECT tears down the SPDM session with the device.
> - TDH.SPDM.MNG supports three SPDM runtime operations: HEARTBEAT,
>   KEY_UPDATE and DEV_INFO_RECOLLECTION.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> index 0f34009411fb..86dd855d7361 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c
> @@ -2390,3 +2390,136 @@ u64 tdh_iommu_clear(u64 iommu_id, struct tdx_page_array *iommu_mt)
>  	return seamcall_ret(TDH_IOMMU_CLEAR, &args);
>  }
>  EXPORT_SYMBOL_GPL(tdh_iommu_clear);
> +
> +union hpa_array_t {
> +	struct {
> +		u64 rsvd0:12;
> +		u64 pfn:40;
> +		u64 rsvd1:3;
> +		u64 array_size:9;
> +	};
> +	u64 raw;
> +};
> +
> +static u64 hpa_array_t_assign_raw(struct tdx_page_array *array)
> +{
> +	union hpa_array_t hat;
> +
> +	if (array->root) {
> +		hat.raw = page_to_phys(array->root);

This is confusing me. I'd be inclined to set hat.pfn with appropriate masks
shifts etc.  Or just do it with field masks and FIELD_PREP() etc


> +		hat.array_size = array->nents - 1;
> +	} else {
> +		hat.raw = page_to_phys(array->pages[0]);
> +	}
> +
> +	return hat.raw;
> +}


