Return-Path: <linux-pci+bounces-15741-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DC69B8173
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 18:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B691C1F2114B
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 17:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355A91C2DB7;
	Thu, 31 Oct 2024 17:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="dZqBiU8D"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239541BE852
	for <linux-pci@vger.kernel.org>; Thu, 31 Oct 2024 17:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730396636; cv=none; b=M2XV1I/XhWWfz+woO897UXAT8nodIH+eB47fAypRp3X81wZpM+rZuz1KcY44D+uvH4qW/FCQ/iK74QPGgNaMoBxgIEvGp2bKdINDh92m6AW7rRQD1aghY4vtgOqri1hx1GwI2SG2/C2oGYBqZNIw+6VXsRI7U7YNctyVTrrvEZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730396636; c=relaxed/simple;
	bh=mhTsv1ygiWFnjDiVQe/E1G0vEfNsEKPKJTElZp6SXYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JwIJZqjY86TR/GfuHVWINlERooNKGzENwl7T0RD2DfJgDO63lz7NutnFjW372cxH4nKDAkkKRrxCdn5rMcJwEZu1spFJtPKIJ0vBprmoNhYmfE0ezyKulWL4kF6BFhJPf0nKdvpt9xxOllxHjR/7BFTCjzW2uc9KGA+fHXxVFoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=dZqBiU8D; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-8377fd760b0so44243539f.2
        for <linux-pci@vger.kernel.org>; Thu, 31 Oct 2024 10:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1730396633; x=1731001433; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cJN1S3OA8zjlhqH9iA1Z8bsg9GoFf4IOEEdKUROgci0=;
        b=dZqBiU8DXpQWfL+3eDl4LNW0W8j+Gz/J02RI+YIltmvo+mXJ8sK+GXmVmFZki7saWo
         EiOfNKfrdJx3cH16jzNPC4J1UW6Znf3Fl/LOGauWgtG+nlV9MvRTmmWSW6AdlRhGm/jV
         PruJ2QGCXMvZiFufP41oXDueGWmKZx5GRxOMoWb0ks7naLXT2NhNcFb42vJMO6j/oPYs
         sF3gAAC6PSuY+vA3Fy9x0bAH+9iJjo/A832nbSe1ZHD2UM/UnGW26frMvAhMmeuGc11m
         XpHb/8EJldScXIeKUKhsgBZlD+JolvOaJA8QEP8jb3Jlp4Rr0giiK4Jb9loOapjHOiFD
         oB+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730396633; x=1731001433;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cJN1S3OA8zjlhqH9iA1Z8bsg9GoFf4IOEEdKUROgci0=;
        b=poWEteQn4xCvHACCzSRTSd9n0ArfTsRmz9AM1p0gje1aQCsPayyOjr0bK5D/EXbYDZ
         VEsi8Cp/o6pXCVs8vJhQ1Yk2m9aiYA7UmWZoJ5Qh09nbkrpT+hhqd1K2NqY33NWXusB/
         lPoUAElIPDldD2XfP+3Pa4geK81jL49P1EWzseD3lqKl53rsfWilRCKJTqcC5XgkV3M/
         hvKRiM+lRwXTjI1vGnrrnkLKNgJKWNx/IOEPBwWAMh8K7LQkFgN6QdRm1ErAIDBoxDOP
         Hly52lgXWgY3j1pN/tH/Pxa/dYOyAgJYfV2Doa/Yk1LXcAkpYsrdo726rZl3VUhpS/fg
         Puiw==
X-Forwarded-Encrypted: i=1; AJvYcCV4i+JpHAYzZHj6WgAnMonNjLYLoBhAJmuE9o0csEZR9E+wie60WK08Kt91LKs0tzJhNCOjUextGrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAzW5rEK6LwooCZXpxQwKvtTTEstUz1Kiu1mZRfEbqpuXSEX4u
	+kc0TRanybHsMKhJKxD1VhFYjNnbJHTHI6YBQuAjtb2XOkcad+GO7Y+xClHTB0o=
X-Google-Smtp-Source: AGHT+IGqvDPac4jMToI9PP3ppL4bi2ob+amIyOKddZ0fGQ56qF7607m8ktK4Ur1sfUjByGfZ1fMmYA==
X-Received: by 2002:a05:6602:6d0b:b0:83a:a9e9:6dc9 with SMTP id ca18e2360f4ac-83b1c4c27eemr2156317139f.12.1730396633080;
        Thu, 31 Oct 2024 10:43:53 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de048e3736sm379375173.81.2024.10.31.10.43.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 10:43:52 -0700 (PDT)
Message-ID: <8b4500da-4ed8-4cd2-ba3b-0c2d0b5b4551@kernel.dk>
Date: Thu, 31 Oct 2024 11:43:50 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/17] Provide a new two step DMA mapping API
To: Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 Yishai Hadas <yishaih@nvidia.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
 iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-pci@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org
References: <cover.1730298502.git.leon@kernel.org>
 <3144b6e7-5c80-46d2-8ddc-a71af3c23072@kernel.dk>
 <20241031083450.GA30625@lst.de> <20241031090530.GC7473@unreal>
 <20241031092113.GA1791@lst.de> <20241031093746.GA88858@unreal>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241031093746.GA88858@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/31/24 3:37 AM, Leon Romanovsky wrote:
> On Thu, Oct 31, 2024 at 10:21:13AM +0100, Christoph Hellwig wrote:
>> On Thu, Oct 31, 2024 at 11:05:30AM +0200, Leon Romanovsky wrote:
>>> This series is a subset of the series you tested and doesn't include the
>>> block layer changes which most likely were the cause of the performance
>>> regression.
>>>
>>> This is why I separated the block layer changes from the rest of the series
>>> and marked them as RFC.
>>>
>>> The current patch set is viable for HMM and VFIO. Can you please retest
>>> only this series and leave the block layer changes for later till Christoph
>>> finds the answer for the performance regression?
>>
>> As the subset doesn't touch block code or code called by block I don't
>> think we need Jens to benchmark it, unless he really wants to.
> 
> He wrote this sentence in his email, while responding on subset which
> doesn't change anything in block layer: "just want to make sure
> something like this doesn't get merged until that is both fully
> understood and sorted out."
> 
> This series works like a charm for RDMA (HMM) and VFIO.

I don't care about rdma/vfio, nor do I test it, so you guys can do
whatever you want there, as long as it doesn't regress the iommu side.
The block series is separate, so we'll deal with that when we get there.

I don't know why you CC'ed linux-block on the series.

-- 
Jens Axboe

