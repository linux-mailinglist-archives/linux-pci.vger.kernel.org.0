Return-Path: <linux-pci+bounces-33236-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C1AB1712A
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 14:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E04ECA82F20
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 12:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67A22C08AD;
	Thu, 31 Jul 2025 12:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ELYgUIZw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157CD2C327D
	for <linux-pci@vger.kernel.org>; Thu, 31 Jul 2025 12:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753964780; cv=none; b=CSDkTgfn2tyLy8SfryRwBBw6K6gRD2HEx31OvhJZ3gHfm11vODSZOeRjL3VxwEbDpg0zZp0RhkwQvAzzIaVc2Y1HgvJhGpFxMndKVtCofHotCqUTU9NrEhPkxSc4iv4Xee7SrO90o5CSdkeFXXQSou/ZkLXNOsgmOfve9K7CMT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753964780; c=relaxed/simple;
	bh=DdxvPDAw0mc8/2mcJ0LEU5pxZezLf4CuYkBruMEyp5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fCa1fsAiYRe+FquCL/ei34CLOPOdJuYUjjtmJMt0s0fqv+3bo3M4XITYmoP3Muj0MC7mpuIeH9ptNwusvpvYh3HnrM67By9jAIvkeOMpNoWWIPD2z+qDpQ4CRhtI1vilWIihml9NUFOKexTSm4psvQOMkpgF2QBhJph/0kZyd1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ELYgUIZw; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7e62a1cbf82so63607385a.2
        for <linux-pci@vger.kernel.org>; Thu, 31 Jul 2025 05:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1753964778; x=1754569578; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I0UTzXjMbQLF812F/cBlHHlhQP11knn9ieRgsIR0U4g=;
        b=ELYgUIZwQIAsqNJXhbwDMJCt9f6I/9ay7kMdcYgEIjyOqdd69Q19PwR/ZLGDCPbTuK
         Xu8O3YHl0OTsJqyYE/U6mlbRY0hIu5rg0npaN5qXpF+CN4nuAM1kob7ZPC3ynU5dSanW
         m85S/26N9/v6OyltlLIZPa5n0n/Xji5coPmGmruVwsgRueDAq23UKW4tcYbZL+KUSpqb
         kyXeuNZB2Wv7Z2miCRlqIB5hRgxg9fbR/9ZfJMyoQx1iWR+BdIXnxIrO7QBLnXP6K+e2
         e7/3v6lMVFPJkZ7W/YKmXN0JvQBKrZMvkULZynYcPhRYTSH+u2YKjXZggfe4vCKy1xP/
         qKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753964778; x=1754569578;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0UTzXjMbQLF812F/cBlHHlhQP11knn9ieRgsIR0U4g=;
        b=S8ammLjIcYs9UVLvjbhTOplDKD8K5Z4NfyW1iKNqe3SS8O8rwuZnMbhgzxcBTfOap5
         spqzKKgPx4evuO7Gegp1wWU7CpljSnOa8clQstW572OAFhdBejOUfdnkd3sfmziRvfJJ
         Mh3ff8AECd3uWM8L085tOrNkfKINvyI6iVsHo4GK24/uGVH0x9GixnDBKIO90qW303f9
         Yn22olUTHvxKwZoiZ8ujpS0pzxj1hACVTBSsyVl6M/+dDsjUurjNPBYxPTPAgPfxVMZF
         YsxCWP02vwOKMINScOnFRo9xl1hf5rBBGBxwpenl2y+EeShGdnykdSZwBUDnCSZOLSju
         OePA==
X-Forwarded-Encrypted: i=1; AJvYcCVO5eCeMFmwo51oxZvKsnodBwn8hyySXOYO+43UCWakbtYAHs6HJ/pTCyvR0c70hZOWAtzOFkp2ExE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUOYESLAkh9mPWauqwAQRoHks4ZfgyqawXLKljI2JvEOHuDTDy
	1+O68cMlli6V9U31xmrneMT6NZqMi7BRZT4B8S0Ld3ZVklXQAWTMu2+JnAKSPw+k+uY=
X-Gm-Gg: ASbGncvHnhzWLBt2UMJsT2eJ44ZGKMc+HHBg5vQVL1jppr1ejvIh9L5typjsv3FTXhk
	+2CHYUAhMDo2LdAW8jMgjkQUXsvb/PXNgzGiqi31F1+JKjpZ8axCpNIJTqrLAuKCKCwrRj79rsM
	KCi6jmq158+dxFAqOHVvcQ9K3m8gyO8iMxOu1ykboJ9BE2pPoTiWIukN48V24YIrmq96lb2ej5i
	/hDdOc/EHflu33LN6CqKF5kuVW9/TStNuSvisPiFDRXfBRdqVu3pkn1y6kJcW8pW4wnYJdiDa4X
	J+E2m81SxwN8HwVHVI/G8dj7l+VJcvBU6d/8zAiZVzMot4i7z6DlU95vo9v1rtePbFLVkt7uVQC
	DEmLdsjGYaalQVBmkSmhr2ZVdf7WvP52yMHYi2dHqnxg8+myFwrPgXTJlsXsgqG0pFB9Z
X-Google-Smtp-Source: AGHT+IEV8Gmvc00o50P6OQKANpqFcknIb1Fql8SzhfROvZ160cWgmtvbR5AnJBSI+9ww0K1Z9AZwLQ==
X-Received: by 2002:a05:6214:21e4:b0:707:4daf:62d with SMTP id 6a1803df08f44-70766f89168mr126988486d6.21.1753964777814;
        Thu, 31 Jul 2025 05:26:17 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077c9da870sm6583536d6.1.2025.07.31.05.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 05:26:17 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uhSMS-00000000oZ9-3Vfz;
	Thu, 31 Jul 2025 09:26:16 -0300
Date: Thu, 31 Jul 2025 09:26:16 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	aik@amd.com, lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 12/38] coco: host: arm64: CCA host platform device
 driver
Message-ID: <20250731122616.GS26511@ziepe.ca>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-13-aneesh.kumar@kernel.org>
 <20250729182244.00002f4f@huawei.com>
 <20250729232243.GK26511@ziepe.ca>
 <20250730112804.00002629@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730112804.00002629@huawei.com>

On Wed, Jul 30, 2025 at 11:28:04AM +0100, Jonathan Cameron wrote:
> > devm is useful to solve complex things, these trivial things should be
> > done normally..
> 
> Sure, that would be fine for now.  If we end up with a large complex flow that
> happens to have a tsm_register() in amongst various managed resources
> we can revisit.  If they all end up looking like this then a manual call
> in remove is fine.

IMHO just don't use devm, it is so easy to use devm wrong and get out
of order clean up. It works well for extremely simple case where 100%
of cleanup is in devm (but then it is questionable if the overhead is
worthwehile), and it is necessary for extremely hard cases where
writing a manual unwind is too hard. But the middle ground it tends to
just make ordering bugs and not provide alot of value, IMHO.

Jason

