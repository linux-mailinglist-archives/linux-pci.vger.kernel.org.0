Return-Path: <linux-pci+bounces-26624-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A68A99C04
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 01:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 659397A63CD
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 23:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303D822F775;
	Wed, 23 Apr 2025 23:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="V9t8UuGX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A99722F771
	for <linux-pci@vger.kernel.org>; Wed, 23 Apr 2025 23:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745450913; cv=none; b=evEae7H87c9fbXaJJdvoTzZdjGK7Rl4yCQcwH0yKl1S+oNhw/kMi00G7QWxEAU9DkJEzJPrqux6y2r6XJFKPrlvBTvE4RB28J8KIhO0jWZFxO9Uxh8zSmoOnxfbKN5xTzWV5B8Cne74Dlkts3G0UszW+Zm89aIUeM4WrqPzQCHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745450913; c=relaxed/simple;
	bh=a/m1kWZ0mMaRN3QIj2DGTgl1rk+XNi+SIx+XcpVWSeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=allkhwKxv4wAIXGZtPZpuui//C9/eQAKjXV6RzuqWGnafZrkYE0n5qHXXy0XgEcaKteEV895KnvP0G8dtz4ONT42XXxlsGz7E2wWRIRojKDV5TpmeJUcPYUXeKNyxKEfFTJbqdVVD9DuhGYzPsFvoE4Vu4dPRmEX2L9qgLBNrO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=V9t8UuGX; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c54f67db99so179528585a.1
        for <linux-pci@vger.kernel.org>; Wed, 23 Apr 2025 16:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745450910; x=1746055710; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0Go7qZaXvLQqCMqWTP9/Yf9f9Qu/B9pFeocBe+GrV9o=;
        b=V9t8UuGXDFmTJrX2GuNBpF+35WEPvkVNvWY8r1L9hjJapeb+jb7Ce88japOM3vnENz
         3RwZrf657MtShlvVnMrGuC7cZcKU8ofbe7YGWOVvN91vUualRrIH/gRseGCvdGkj9NG/
         Ouh4B3Kf/ageHGydKSIQu5E4Ne4rxYQgQmsW8gojTKaxUbHSyTUGCmhEj1Or+XTQhcN4
         cxLKHyHSpA42e+eoUA+JjP0yQSOGnfyrqmBZZumfsndKzCQ6HbTG3ahQv812gpJDwreu
         eB5QSugKVOAWTM+tZ6x30M9o8jgtjt8moswwujXVwmrrloZkzEmh5UCv+a0Y8CpCAvud
         VkTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745450910; x=1746055710;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Go7qZaXvLQqCMqWTP9/Yf9f9Qu/B9pFeocBe+GrV9o=;
        b=o9ZQaWuuJuJxRE5ZmtD8kfe/xUO/NuYG7jt/gjGPrxDfIqqtQsd8XqlhMtIMNsCtBC
         l8zmGTz0NNKyFsgm5giReCyfWxfSHP/Od9FPM0Mqd0KfWkVIvntZ7fTiarKLhFdQO3t7
         7cOTlFa86PsT5UI4k7kNBp5I37HzTWop3xNSTQT1KD1vdlls9EmRG94YJuLAY8QwC1ZP
         +pSWqXMzrfLmQc02mAU0bzFp6QqCTVwxlQnZ8cQPe777JA1l5TtBwccoymSIuE6g4/Xz
         DqH2TjvxFaMiG09mEpaDfcto8fl8fkz/dTCNgIeaKLNc4NDoJ2m3b+S0DCFoRTwrfyWh
         W0Zw==
X-Forwarded-Encrypted: i=1; AJvYcCVoPNJqAeSKo+Lv/WWgFYePg1p9F+N1F4C4DHJtZSgfeeO29Zyy5vo6OR61LlAAj9TNwAGFMbJzlKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYIPJJwYm7vOc8yKMhPI5L8Cd8X7wfMmhnB4/zCmKs38ukZNS1
	wxmIDT1UN9IZiaiQ+owHzBzSb+D0kXILlknSy76IJmm8Wi+ppZbmBfSD4IS7ZOsUQS69eTdFwv6
	O
X-Gm-Gg: ASbGncs1igCHRj/Nx3SgbDPX3duQX3A98lhrA4h2BURtntaCOB+ZNNSHXPOj/elegoI
	stIfsvKZ82/MK1Hi/JrB3XO+8juz/A14A5/4rgwGzgpYCa8GagUqGA+MqHPZk604Sh3gh8wsGDC
	h5OO7WeJTvsnfEaymA/1+Z71qc5R1af3rK7pAFlpe5gOLAJLRI/SWTuxMTfuyoH81ThkygTonHR
	L6PxD6Rw1R6U8xGUOioNmJS4a60AT0r6COovyzILxptRRLkUyFj9qbChf3svaO/+RqIzuKDvIiy
	quATNqLlz14MCtD0VGW2c8OyirkWm1+rkKJZX5LdXg3fu6qOtyyaLGHubMyFe0ji2bOWPvjzsoI
	e7A0f+a7AxzOTGh5sZAw=
X-Google-Smtp-Source: AGHT+IHQwoUGFyqXOFOgVitrB4+AxVC8d+UTNu2w6OYf0KswkT4EXsvYxHqs0LgYSSaBSDPbedDu/w==
X-Received: by 2002:a05:620a:2887:b0:7c0:a1c8:1db3 with SMTP id af79cd13be357-7c9585c5877mr36268185a.11.1745450909829;
        Wed, 23 Apr 2025 16:28:29 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c958e7f154sm2581385a.76.2025.04.23.16.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 16:28:29 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u7jW0-00000007PIX-0JOv;
	Wed, 23 Apr 2025 20:28:28 -0300
Date: Wed, 23 Apr 2025 20:28:28 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: jane.chu@oracle.com
Cc: logane@deltatee.com, hch@lst.de, gregkh@linuxfoundation.org,
	willy@infradead.org, kch@nvidia.com, axboe@kernel.dk,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: Report: Performance regression from ib_umem_get on zone device
 pages
Message-ID: <20250423232828.GV1213339@ziepe.ca>
References: <fe761ea8-650a-4118-bd53-e1e4408fea9c@oracle.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe761ea8-650a-4118-bd53-e1e4408fea9c@oracle.com>

On Wed, Apr 23, 2025 at 12:21:15PM -0700, jane.chu@oracle.com wrote:

> So this looks like a case of CPU cache thrashing, but I don't know to fix
> it. Could someone help address the issue?  I'd be happy to help verifying.

I don't know that we can even really fix it if that is the cause.. But
it seems suspect, if you are only doing 2M at a time per CPU core then
that is only 512 struct pages or 32k of data. The GUP process will
have touched all of that if device-dax is not creating folios. So why
did it fall out of the cache?

If it is creating folios then maybe we can improve things by
recovering the folios before adding the pages.

Or is something weird going on like the device-dax is using 1G folios
and all of these pins and checks are sharing and bouncing the same
struct page cache lines?

Can the device-dax implement memfd_pin_folios()?

> The flow of a single test run:
>   1. reserve virtual address space for (61440 * 2MB) via mmap with PROT_NONE
> and MAP_ANONYMOUS | MAP_NORESERVE| MAP_PRIVATE
>   2. mmap ((61440 * 2MB) / 12) from each of the 12 device-dax to the
> reserved virtual address space sequentially to form a continual VA
> space

Like is there any chance that each of these 61440 VMA's is a single
2MB folio from device-dax, or could it be?

IIRC device-dax does could not use folios until 6.15 so I'm assuming
it is not folios even if it is a pmd mapping?

Jason

