Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAE15EA5D
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2019 19:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfGCRW2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Jul 2019 13:22:28 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:14102 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbfGCRW2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Jul 2019 13:22:28 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d1ce44f0000>; Wed, 03 Jul 2019 10:22:23 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 03 Jul 2019 10:22:27 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 03 Jul 2019 10:22:27 -0700
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 3 Jul
 2019 17:22:23 +0000
Subject: Re: [PATCH 18/22] mm: return valid info from hmm_range_unregister
To:     Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
CC:     Ira Weiny <ira.weiny@intel.com>, <linux-mm@kvack.org>,
        <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-nvdimm@lists.01.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20190701062020.19239-1-hch@lst.de>
 <20190701062020.19239-19-hch@lst.de>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <0cc37cca-4f3a-40bb-0059-bf3880c171b8@nvidia.com>
Date:   Wed, 3 Jul 2019 10:22:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190701062020.19239-19-hch@lst.de>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1562174544; bh=t4iv+JkVQXMDn9U21ZE8onfcueQ7442WkhT3/Dcpa4M=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=o4SEJPOOrRcVRLndEm7Zo7kTSy5FZf0UU7cSYb6tblR8H1EUMVX5E/0FjYzJrSpko
         wz/tUydScQzFM1TJuHIP9tIFH+twnUQBk37KA0HVngw9EftV5QqHG2Tqfjp2J8EPuI
         cOTG6KhoZMk2Kh1KQh0nP3AEh0uE4jVMnBYCBTkXTdSVmN+wIcMvLmh+GM9psOeZBs
         3aY56IDBUR2I0RSrHwqu9wiz9+2bNfCk3CTpCrQB/Pq2QpA4D4k/ASPiYqwdt5SsHr
         E0w4jAe1UNn6ayNyaW96+0ynvEfH+IEp7CDyfnUEVKIhxGZ7F5A0JKPp7wK4+C0AuG
         0J+QqvUEgD4RQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 6/30/19 11:20 PM, Christoph Hellwig wrote:
> Checking range->valid is trivial and has no meaningful cost, but
> nicely simplifies the fastpath in typical callers.  Also remove the
> hmm_vma_range_done function, which now is a trivial wrapper around
> hmm_range_unregister.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>

> ---
>   drivers/gpu/drm/nouveau/nouveau_svm.c |  2 +-
>   include/linux/hmm.h                   | 11 +----------
>   mm/hmm.c                              |  6 +++++-
>   3 files changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
> index 8c92374afcf2..9d40114d7949 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_svm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
> @@ -652,7 +652,7 @@ nouveau_svm_fault(struct nvif_notify *notify)
>   		ret = hmm_vma_fault(&svmm->mirror, &range, true);
>   		if (ret == 0) {
>   			mutex_lock(&svmm->mutex);
> -			if (!hmm_vma_range_done(&range)) {
> +			if (!hmm_range_unregister(&range)) {
>   				mutex_unlock(&svmm->mutex);
>   				goto again;
>   			}
> diff --git a/include/linux/hmm.h b/include/linux/hmm.h
> index 0fa8ea34ccef..4b185d286c3b 100644
> --- a/include/linux/hmm.h
> +++ b/include/linux/hmm.h
> @@ -465,7 +465,7 @@ int hmm_range_register(struct hmm_range *range,
>   		       unsigned long start,
>   		       unsigned long end,
>   		       unsigned page_shift);
> -void hmm_range_unregister(struct hmm_range *range);
> +bool hmm_range_unregister(struct hmm_range *range);
>   long hmm_range_snapshot(struct hmm_range *range);
>   long hmm_range_fault(struct hmm_range *range, bool block);
>   long hmm_range_dma_map(struct hmm_range *range,
> @@ -487,15 +487,6 @@ long hmm_range_dma_unmap(struct hmm_range *range,
>    */
>   #define HMM_RANGE_DEFAULT_TIMEOUT 1000
>   
> -/* This is a temporary helper to avoid merge conflict between trees. */
> -static inline bool hmm_vma_range_done(struct hmm_range *range)
> -{
> -	bool ret = hmm_range_valid(range);
> -
> -	hmm_range_unregister(range);
> -	return ret;
> -}
> -
>   /* This is a temporary helper to avoid merge conflict between trees. */
>   static inline int hmm_vma_fault(struct hmm_mirror *mirror,
>   				struct hmm_range *range, bool block)
> diff --git a/mm/hmm.c b/mm/hmm.c
> index de35289df20d..c85ed7d4e2ce 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -920,11 +920,14 @@ EXPORT_SYMBOL(hmm_range_register);
>    *
>    * Range struct is used to track updates to the CPU page table after a call to
>    * hmm_range_register(). See include/linux/hmm.h for how to use it.
> + *
> + * Returns if the range was still valid at the time of unregistering.

Since this is an exported function, we should have kernel-doc comments.
That is probably a separate patch but at least this line could be:
Return: True if the range was still valid at the time of unregistering.

>    */
> -void hmm_range_unregister(struct hmm_range *range)
> +bool hmm_range_unregister(struct hmm_range *range)
>   {
>   	struct hmm *hmm = range->hmm;
>   	unsigned long flags;
> +	bool ret = range->valid;
>   
>   	spin_lock_irqsave(&hmm->ranges_lock, flags);
>   	list_del_init(&range->list);
> @@ -941,6 +944,7 @@ void hmm_range_unregister(struct hmm_range *range)
>   	 */
>   	range->valid = false;
>   	memset(&range->hmm, POISON_INUSE, sizeof(range->hmm));
> +	return ret;
>   }
>   EXPORT_SYMBOL(hmm_range_unregister);
>   
> 
