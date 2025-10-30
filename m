Return-Path: <linux-pci+bounces-39800-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDE9C1FB4A
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 12:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 838813B6519
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 11:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6558716F288;
	Thu, 30 Oct 2025 11:07:42 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F3521B1BC
	for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2025 11:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761822462; cv=none; b=JLRvAwqLTjHRVBMua6lCl0v+PwjoiurVCt3ntg7Eznki8o15IA5Jsw6VEVud+xM5w+zyjZY8QSetBON4eNS0dYlQjuBz2TwjzBJ5TX7BAjMR7mExEZYsB430vvC27E5Ta93g9+asXtwTkh/fKXix/UCA9yl+9fFc75I8G0TODR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761822462; c=relaxed/simple;
	bh=N0YReuMxONND+LJciwzRT1TXb+Uijo5vpLMrGXSUkIw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M63sklc9BZ6kR1s3slU+FPjN5anKYgSy5dshOrnf21bdWIrSCzYagnWesTWSCsktkJIdvC31iu29qi/n/gH8SBHJrgDECYcpJO1O4+oGqqIEP5r7tQZ1ujsdfWAqapWah+OHtLQggaia0p6NYnBcEmZw8QbCqx0mQBg2g1PrlQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4cy1X36H94zHnHBj;
	Thu, 30 Oct 2025 11:06:43 +0000 (UTC)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 3E7D8140370;
	Thu, 30 Oct 2025 19:07:38 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 30 Oct
 2025 11:07:37 +0000
Date: Thu, 30 Oct 2025 11:07:36 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<xin@zytor.com>, <chao.gao@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>
Subject: Re: [RFC PATCH 15/27] x86/virt/tdx: Extend tdx_page_array to
 support IOMMU_MT
Message-ID: <20251030110736.00000251@huawei.com>
In-Reply-To: <20250919142237.418648-16-dan.j.williams@intel.com>
References: <20250919142237.418648-1-dan.j.williams@intel.com>
	<20250919142237.418648-16-dan.j.williams@intel.com>
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

On Fri, 19 Sep 2025 07:22:24 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> From: Xu Yilun <yilun.xu@linux.intel.com>
> 
> IOMMU_MT is another TDX Module defined structure similar to HPA_ARRAY_T
> and HPA_LIST_INFO. The difference is it supports multi-order contiguous
> pages. It adds an additional NUM_PAGES field for every multi-order page
> entry [1].
> 
> Add an dedicated allocation helper for IOMMU_MT. Maybe a general
> allocation helper for multi-order is better but could postpond until

postponed

> another user appears.
> 
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>


> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 1ae97a0b8ec7..719cc479f9e7 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1360,6 +1360,8 @@ static inline void folio_put(struct folio *folio)
>  		__folio_put(folio);
>  }
>  
> +DEFINE_FREE(folio_put, struct folio *, if (_T) folio_put(_T))

Another case of buried mm stuff that maybe could go ahead of this series
so this doesn't stall on any controversy around that.

> +
>  /**
>   * folio_put_refs - Reduce the reference count on a folio.
>   * @folio: The folio.


