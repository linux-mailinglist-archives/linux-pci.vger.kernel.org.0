Return-Path: <linux-pci+bounces-39795-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 513AEC1FA25
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 11:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0EF244E0709
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 10:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700723002B3;
	Thu, 30 Oct 2025 10:49:33 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBCA2DC791
	for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2025 10:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761821373; cv=none; b=Qayuwi/evMuu2hjNhDcI8A6hRASPJ5b5hZkkqcrGS0aDXKZx8PepmJMptA9dQ9Y2hw2Jxgx3VsNbYeZPdyvQpS/+FgaY+gC1jYDMwQYzG062jKPpupHo9ctzrdOhx1WgloWzizSYi6eck4IuVugaRWmQxJPlhgtcBdyTJbcEjnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761821373; c=relaxed/simple;
	bh=AXFYvrAG1l1zzLnLOoY5lPMX2+huQyn3aPau7P+xyM8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fYziCYImvQktcEr6DkfYReD9PgF9ZODDkBAY4OW9coHn/VVGG0WL8TiS0xKGtYkJslY1FxDt8hRxksDgMXMo4N2wnHMVXI2jE+cFw8JYlPQ2LQuKuekULBWl+w/8Qv+diussgbmK8252BIYqDhXcZGvZauMb69Gdcg5Tb4EwdTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cy13g5x8rz6M4WJ;
	Thu, 30 Oct 2025 18:45:35 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id EA779140427;
	Thu, 30 Oct 2025 18:49:27 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 30 Oct
 2025 10:49:27 +0000
Date: Thu, 30 Oct 2025 10:49:26 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<xin@zytor.com>, <chao.gao@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>,
	Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: Re: [RFC PATCH 05/27] x86/virt/tdx: Add tdx_page_array helpers for
 new TDX Module objects
Message-ID: <20251030104926.000066c3@huawei.com>
In-Reply-To: <20250919142237.418648-6-dan.j.williams@intel.com>
References: <20250919142237.418648-1-dan.j.williams@intel.com>
	<20250919142237.418648-6-dan.j.williams@intel.com>
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

On Fri, 19 Sep 2025 07:22:14 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> From: Xu Yilun <yilun.xu@linux.intel.com>
> 
> Add struct tdx_page_array definition for new TDX Module object
> types - HPA_ARRAY_T and HPA_LIST_INFO. They are used as input/output
> parameters in newly defined SEAMCALLs. Also define some helpers to
> allocate, setup and free tdx_page_array.
> 
> HPA_ARRAY_T and HPA_LIST_INFO are similar in most aspects. They both
> represent a list of pages for TDX Module accessing. There are several
> use cases for these 2 structures:
> 
>  - As SEAMCALL inputs. They are claimed by TDX Module as control pages.
>  - As SEAMCALL outputs. They were TDX Module control pages and now are
>    released.
>  - As SEAMCALL inputs. They are just medium for exchanging data blobs
>    in one SEAMCALL. TDX Module will not hold them as control pages.
> 
> The 2 structures both need a 'root page' which contains a list of HPAs.
> They compress the HPA of the root page and the number of valid HPAs into
> a 64 bit raw value for SEAMCALL parameters. The root page is always a
> medium for passing data pages, TDX Module never keeps the root page.
> 
> A main difference is HPA_ARRAY_T requires singleton mode when
> containing just 1 functional page (page0). In this mode the root page is
> not needed and the HPA field of the raw value directly points to the
> page0.
> 
> Another small difference is HPA_LIST_INFO contains a 'first entry' field
> which could be filled by TDX Module. This simplifies host by providing
> the same structure when re-invoke the interrupted SEAMCALL. No need for
> host to touch this field.
> 
> Typical usages of the tdx_page_array:
> 
> 1. Add control pages:
>  - struct tdx_page_array *array = tdx_page_array_create(nr_pages, ...);
>  - seamcall(TDH_XXX_CREATE, array, ...);
> 
> 2. Release control pages:
>  - seamcall(TDX_XXX_DELETE, array, &nr_released, &released_hpa);
>  - tdx_page_array_ctrl_release(array, nr_released, released_hpa);
> 
> 3. Exchange data blobs:
>  - struct tdx_page_array *array = tdx_page_array_create(nr_pages, ...);
>  - seamcall(TDX_XXX, array, ...);
>  - Read data from array.
>  - tdx_page_array_free(array);
> 
> 4. Note the root page contains 512 HPAs at most, if more pages are
>    required, refilling the tdx_page_array is needed.
> 
>  - struct tdx_page_array *array = tdx_page_array_alloc(nr_pages, ...);
>  - for each 512-page bulk
>    - tdx_page_array_fill_root(array, offset);
>    - seamcall(TDH_XXX_ADD, array, ...);
> 
> In case 2, SEAMCALLs output the released page array in the form of
> HPA_ARRAY_T or PAGE_LIST_INFO. tdx_page_array_ctrl_release() is
> responsible for checking if the output pages match the original input
> pages. If failed to match, the safer way is to leak the control pages,
> tdx_page_array_ctrl_leak() should be called.
> 
> The usage of tdx_page_array will be in following patches.
> 
> Co-developed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

One trivial thing + I think that introduction of a DEFINE_FREE() needs
to be more obvious to MM folk that it will be buried in here.

Looks fine but needs an Ack.

> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> index ada2fd4c2d54..bc5b8e288546 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c



> +static bool tdx_page_array_ctrl_match(struct tdx_page_array *array,
> +				      unsigned int offset,
> +				      unsigned int nr_released,
> +				      u64 released_hpa)
> +{
> +	unsigned int nents;
> +	u64 *entries;
> +	int i;
> +
> +	if (offset >= array->nr_pages)
> +		return 0;
> +
> +	nents = umin(array->nr_pages - offset, TDX_PAGE_ARRAY_MAX_NENTS);
> +
> +	if (nents != nr_released) {
> +		pr_err("%s nr_released [%d] doesn't match page array nents [%d]\n",
> +		       __func__, nr_released, nents);
> +		return false;
> +	}
> +
> +	if (!array->root) {
> +		if (page_to_phys(array->pages[0]) != released_hpa) {
> +			pr_err("%s released_hpa [0x%llx] doesn't match page0 hpa [0x%llx]\n",
> +			       __func__, released_hpa,
> +			       page_to_phys(array->pages[0]));
> +			return false;
> +		}
> +
> +		return true;
> +	}
> +
> +	if (page_to_phys(array->root) != released_hpa) {
> +		pr_err("%s released_hpa [0x%llx] doesn't match root page hpa [0x%llx]\n",
> +		       __func__, released_hpa, page_to_phys(array->root));
> +		return 0;
return false

> +	}
> +
> +	entries = (u64 *)page_address(array->root);
> +	for (i = 0; i < nents; i++) {
> +		if (page_to_phys(array->pages[offset + i]) != entries[i]) {
> +			pr_err("%s entry[%d] [0x%llx] doesn't match page hpa [0x%llx]\n",
> +			       __func__, i, entries[i],
> +			       page_to_phys(array->pages[offset + i]));
> +			return false;
> +		}
> +	}
> +
> +	return true;
> +}
> +
> +/* For releasing control pages which are created by tdx_page_array_create() */
> +int tdx_page_array_ctrl_release(struct tdx_page_array *array,
> +				unsigned int nr_released,
> +				u64 released_hpa)
> +{
> +	int i;
> +	u64 r;
> +
> +	if (WARN_ON(array->nr_pages > TDX_PAGE_ARRAY_MAX_NENTS))
> +		return -EINVAL;
> +
> +	if (WARN_ON(!tdx_page_array_ctrl_match(array, 0, nr_released,
> +					       released_hpa)))
> +		return -EFAULT;
> +
> +	for (i = 0; i < array->nr_pages; i++) {
> +		r = tdh_phymem_page_wbinvd_hkid(tdx_global_keyid,
> +						array->pages[i]);
> +		if (WARN_ON(r))
> +			return -EFAULT;
> +	}
> +
> +	tdx_page_array_free(array);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(tdx_page_array_ctrl_release);

> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index 5ebf26fcdcfa..f0a651155872 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -385,6 +385,8 @@ extern void free_pages(unsigned long addr, unsigned int order);
>  #define __free_page(page) __free_pages((page), 0)
>  #define free_page(addr) free_pages((addr), 0)
>  
> +DEFINE_FREE(__free_page, struct page *, if (_T) __free_page(_T))

This is at least more 'normal' than the CCA set one for free_page.
Burying it down here means getting an MM review. I'd be tempted to find
an alternative use somewhere else and post this stand alone to get that
review done.
 
> +
>  void page_alloc_init_cpuhp(void);
>  int decay_pcp_high(struct zone *zone, struct per_cpu_pages *pcp);
>  void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp);


