Return-Path: <linux-pci+bounces-28720-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA59AC917B
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 16:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5985D1C06A34
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 14:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFDB233D9C;
	Fri, 30 May 2025 14:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C2ElfzL8"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AABB23371E
	for <linux-pci@vger.kernel.org>; Fri, 30 May 2025 14:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748615110; cv=none; b=O0O3RTbgupdABOp5lFc3cfSg8JFKa3oZqIqQYMNGdPaKOfmRxxMKPhqecMIxCFc6P7JSJqKsea257e/VQu9nEblHPWxs/s51EyqIWSDDRpyZUQT7k10iBB8B1PwYcYk/5wsXfquOHpN8h4jXeOqSjVUlRh4MfQeyUYXkIM51O28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748615110; c=relaxed/simple;
	bh=+YMJVsO7WiZIkwJBNsX6uMDf2z1BAhOPh+FFi54wReo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F8KAfY3z3WANLWR3ew+uYmFfkOOIYV+V76vD1Jz9/PL9gVRDXfYS1AZ3WASLDbITXtBA111/r/5XmLnWLu70R/e4xXk+ncMGmmV7RLQuzwD5wILfiX/5uNkH+FvlxFfuxYCTJ24gigk7D6NJ5dIbv9MbzFVQdLfiy7E8Eirzx8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C2ElfzL8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748615107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bOYqdeSVVHHCBrZDdW1OJnbvgA1dHMuohxeMIrVMI3U=;
	b=C2ElfzL8UPrAdMqCMODjA7HNvVZZdaXP/P+ycf0r4BxbrZIyxBV/rWYsog3bz/JFg4rBA7
	tx6d0ynsrYNcX99u8ecKwQHhqSOB8I8ICZQo7uRJqjpWCoT7usC9RkXkS456PAeeIk/nvW
	gbfPn5p2gWnfo1IJOxXEEjT/L3HY1v8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-3s2glm43N0q_J0vU3F0haA-1; Fri, 30 May 2025 10:25:06 -0400
X-MC-Unique: 3s2glm43N0q_J0vU3F0haA-1
X-Mimecast-MFC-AGG-ID: 3s2glm43N0q_J0vU3F0haA_1748615105
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6face35aad6so11238556d6.0
        for <linux-pci@vger.kernel.org>; Fri, 30 May 2025 07:25:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748615105; x=1749219905;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bOYqdeSVVHHCBrZDdW1OJnbvgA1dHMuohxeMIrVMI3U=;
        b=WD/0k5BED23nE7h67O82ioifoQFgOTOvZhc7hZbCtHe6MZisI7cZpzxktMvvNmyGHj
         YdDS87k+x/+yTYXW3t/5suTSHTgwer6YwPt2v3flpEVm1hyqgoChaV2gxY2zVKpexlAP
         qxFD7E1Mrg0KAikbto77zuhpTYSro1EiueqNqkU9BRFJA6wOWe5BekoDF6GU/tqXp0A1
         lrkzfyzPuyEzUgWT88Kpow9ZKVDEbulnnr6gDcJLW2BK5ifoL9GDn3mpFIsgUT9/h6lL
         TJIyzxQ7v8QdLzndczFbhBXh9LoHpmGzejv/F0T3vEl0aZwJY9nsKXJRWD6zLNnQ2RFI
         7png==
X-Forwarded-Encrypted: i=1; AJvYcCUjVsu5jlGuzAzfossiD6wRr33GCVHT6cORff66SwgwHH5TaUbmAUUlcbZ/FIhgI3APdjXIY7u/1xU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQPF00GrGNMqpi/4YnB544Xql6dYh4dXheZjUI71CMbPizdc3B
	3lh4nwJa/6gkD6X916CSXftjze/XB1fsQ7Avy8vD83+rMVHkDSu0Zc8LyIhmbr/MsnnoAy2qev7
	7ygA0xAPEbcvSvSBp+y3pXUo7GOsTCGTB6wDyTQcYthPgfS8y6lbkdVWXnHpmj45VNUYKoA==
X-Gm-Gg: ASbGncsKIybA3LZjNK3nrJV1SwDE6o85850hHBda32F33X0FzDEVvtra4kbWHJqGQSz
	JliMxUce2i0wVAxwhNccDUWzgab4jgDarza/rjqGt96ppkl/Ax1Fo3mUlpVAxKiVOH7bpb6v3sJ
	Z0RFt+4uMPOe6WjWaWc3RvP/j/vKywCW0hRVtk7mrIGkcyN9fvyEHPEkazsO2wBg42Sa0aE7Rwa
	/zk35uT2/wWsOA0jln1pRUAaKsPIOBeGI4GAhvOfGc2kTX/FptixGctQrrv3EJUvxkGpLDKJOR9
	GMM=
X-Received: by 2002:a05:6214:2524:b0:6fa:cc39:9f with SMTP id 6a1803df08f44-6facebe24e7mr63185446d6.32.1748615105016;
        Fri, 30 May 2025 07:25:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHm9OBph7eo8hVyCeG0tgAA+iOUtABp2JLodq1KoZQqWU0Q1fuwR2uKkDV3RhT/uCvdYKTowQ==
X-Received: by 2002:a05:6214:2524:b0:6fa:cc39:9f with SMTP id 6a1803df08f44-6facebe24e7mr63184806d6.32.1748615104496;
        Fri, 30 May 2025 07:25:04 -0700 (PDT)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fac6e1a73bsm23367036d6.107.2025.05.30.07.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 07:25:04 -0700 (PDT)
Date: Fri, 30 May 2025 10:25:01 -0400
From: Peter Xu <peterx@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Mastro <amastro@fb.com>, linux-pci@vger.kernel.org,
	alex.williamson@redhat.com, kbusch@kernel.org, linux-mm@kvack.org
Subject: Re: [BUG?] vfio/pci: VA alignment sensitivity of VFIO_IOMMU_MAP_DMA
 which target MMIO
Message-ID: <aDm_vaQUnrVbuvxO@x1.local>
References: <20250529214414.1508155-1-amastro@fb.com>
 <20250530131050.GA233377@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250530131050.GA233377@nvidia.com>

On Fri, May 30, 2025 at 10:10:50AM -0300, Jason Gunthorpe wrote:
> On Thu, May 29, 2025 at 02:44:14PM -0700, Alex Mastro wrote:
> 
> > We are wondering the following:
> > - Is all of the above expected behavior, and usage of VFIO?
> > - Is there an expected minimum alignment greater than 4K (our system page size)
> >   for non-MAP_FIXED mmap on a VFIO device fd?
> > - Was there an unintended regression to our use-case in between 6.9 and 6.13?

Probably due to aac6db75a9fc vfio/pci: Use unmap_mapping_range().  IIUC the
plan was huge fault could bring back the lost perf, but indeed the
alignment is still a challenge to at least always make right.

> 
> I think this is something we have missed. VFIO should automatically
> align the VMA's address if not MAP_FIXED, otherwise it can't use the
> efficient huge page sizes anymore. qemu uses MAP_FIXED so we've left
> out the non-qemu users from this performance optimization.
> 
> To fix it, the flow from the mm side is something like what
> shmem_get_unmapped_area() does. VFIO would probably want to align all
> BAR's to their size.

Good point!  I overlooked the VA hints when QEMU doesn't need it.  I can
have a closer look if nobody else will.

> 
> Which seems to me probably wants some refactoring and a core helper
> 'mm_get_aligned_unmapped_area()'..
> 
> I think if you are mmaping a huge huge BAR it is not surprising that
> it will take a huge amount of time to write out all of the 4K
> PTEs. The stalls on old kernels should probably be addressed by having
> cond_resched() inside the remap_pfnmap().

Right, but then that'll be a stable-only fix.

If VFIO can provide a valid get_unmapped_area(), then with huge faults
maybe we don't even need it, and such change can copy stable too.

Meanwhile, just to mention there's one more commit that vfio huge_fault
stable branches would like to have soon, that Alex fixed yet another
alignment related issue to do reliable huge faults:

commit c1d9dac0db168198b6f63f460665256dedad9b6e
Author: Alex Williamson <alex.williamson@redhat.com>
Date:   Fri May 2 16:40:31 2025 -0600

    vfio/pci: Align huge faults to order

I think if your trace shows correct huge faults when you did correct
alignment, it should mean it doesn't affect your case (likely your app
sequentially fault in the bar region.. meanwhile likely there's no
concurrent, especially unaligned, faults when pre-fault everything).  But
just something FYI and IIUC that commit will land 6.13.z soon.

Thanks,

-- 
Peter Xu


