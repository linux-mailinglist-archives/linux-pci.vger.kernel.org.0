Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52FD75EA83
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2019 19:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfGCRcn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Jul 2019 13:32:43 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:11351 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfGCRcn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Jul 2019 13:32:43 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d1ce6b90000>; Wed, 03 Jul 2019 10:32:41 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 03 Jul 2019 10:32:42 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 03 Jul 2019 10:32:42 -0700
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 3 Jul
 2019 17:32:40 +0000
Subject: Re: [PATCH 19/22] mm: always return EBUSY for invalid ranges in
 hmm_range_{fault,snapshot}
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
 <20190701062020.19239-20-hch@lst.de>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <85c88d71-2c25-38ff-a4a3-bfd66fff72b7@nvidia.com>
Date:   Wed, 3 Jul 2019 10:32:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190701062020.19239-20-hch@lst.de>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1562175161; bh=h5APIAGCLtc3sbvDunYYsjAxWo0bLP7WU/0gBEeeI0w=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=jFQPczeoa9GgO31iCc1i+leEDWlzjjir863TTILBB/y92fjmJ/f1sRLtX+VAJ+7kT
         w92vvah6B8huA4GwU+UVeQT0gcXzN2h0pOn1OhPiqQgIiYhz+alEB4KdiyBILqdNjF
         iPKpJwcfB8ejE/ycfI+hpo2hU5HhQCvtjkyBzaQyOAlSWgEb0SBv3a75TxnJ6bQu96
         N0rQy1PEp6S5xBst7hP92U8L+tvob0E2tubrjAKpvUgVgwpry+THodovSht9UYcLga
         YagJXvoKcVLlFOE7Nc+UP4wF3Mu6pxJqPDNSCJG6taQO+xhoGrUVb+lnZnXTS7ATQt
         SJRIeqmOivyvQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 6/30/19 11:20 PM, Christoph Hellwig wrote:
> We should not have two different error codes for the same condition.  In
> addition this really complicates the code due to the special handling of
> EAGAIN that drops the mmap_sem due to the FAULT_FLAG_ALLOW_RETRY logic
> in the core vm.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>

Probably should update the "Return:" comment above
hmm_range_snapshot() too.

> ---
>   mm/hmm.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/hmm.c b/mm/hmm.c
> index c85ed7d4e2ce..d125df698e2b 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -974,7 +974,7 @@ long hmm_range_snapshot(struct hmm_range *range)
>   	do {
>   		/* If range is no longer valid force retry. */
>   		if (!range->valid)
> -			return -EAGAIN;
> +			return -EBUSY;
>   
>   		vma = find_vma(hmm->mm, start);
>   		if (vma == NULL || (vma->vm_flags & device_vma))
> @@ -1069,10 +1069,8 @@ long hmm_range_fault(struct hmm_range *range, bool block)
>   
>   	do {
>   		/* If range is no longer valid force retry. */
> -		if (!range->valid) {
> -			up_read(&hmm->mm->mmap_sem);
> -			return -EAGAIN;
> -		}
> +		if (!range->valid)
> +			return -EBUSY;
>   
>   		vma = find_vma(hmm->mm, start);
>   		if (vma == NULL || (vma->vm_flags & device_vma))
> 
