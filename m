Return-Path: <linux-pci+bounces-39672-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E96DDC1C0CC
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 17:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18CCF188B7DF
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 16:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6042ED870;
	Wed, 29 Oct 2025 16:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="hBPH8QFx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8043E2E92A3
	for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 16:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761754876; cv=none; b=VUuWPASZvSNRIMmax/UUOH5jJZ2h15kBeLj57e7YgALVqVdl1u5CjCg7N/aM0gL/t7LhQvXEF8m660a+r1tEfkV9SSmt2Sy9N145sDJ4OkrsOj9iD+zprzNk/Py9qt4rfbRLccpr74nyxAzZXm+BRz3DAJ7hD8v1zFw+Vlbhqxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761754876; c=relaxed/simple;
	bh=tutHpDERpk2grTdSQkF8arln6wjfSewQh6BuPKWPSpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kelqyHHmAzaONugQDn++YjL6X1/zYHwMMvIRNEFbi2uYL1pFL7cm7wZPDhi7zCWfm8D3gFQalXzYKa+GpUN3KIP1cKNZK72MpPFZ5rQzW7NtCF2xGHLBudb0AAgkv0VCuJix3x7m2Wn48IbS2awVOsH08w2KPkZhu9qaaEMQeL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=hBPH8QFx; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-89ed2ee36b0so529660285a.2
        for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 09:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1761754873; x=1762359673; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3aZqVH3f6Ms1xWvoULJF1KIgdQvKJ2oeCT0jMy+sgwI=;
        b=hBPH8QFxDaOuHB3ajgnQ0BdO5WWZImIllkLNypfWT7qiMZjdhaD0RluiGTrAZcF5nE
         6VN4QEu+cjXP+huJGxnZ0QF78ftK4Phhi1JxDjiggKmAhJoaWx+NR6F2eElH1KwqrC9Y
         Q4Dx/kTmq6VbFYKdnI+4n2fENFfWLLh+71uY+ro/Ghut8pblOScCRG5AEyuoxD138+IE
         MfNsJz3m91YtTCyAft1S8Y47PjGxHBS8xjEaOOzsYfcz7jJBbWBHjTePyY3lNmaI2d2o
         eSsaxWUuVgyXrsj75w0n4LS6bBH6TiNUK4lPr8rbIIEMW01rk33OsI0mVBhn3pvdMxsl
         es7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761754873; x=1762359673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3aZqVH3f6Ms1xWvoULJF1KIgdQvKJ2oeCT0jMy+sgwI=;
        b=sv5FyHN3R+Qkg1JWKKMn4XiV8lxFY+bj+SU1JzVa1F0JaC5tkZ4axuDJK2lY1ie08W
         bkHyhUKHqodYvjSudRDmoSEozLPgsFl4tw0sibbCzUiJQ/dJ6N5+LuLYZNVkOtQEcrYq
         wiAZwRjqohEjSfgXYN9cWCmY0v6BFQ8axnXouQ6j6Jn19OSHatxA0vcA1ihz/Nhv12Yy
         uXZj1jnm/O7bF+KUV1Mhr83Btp+7axMSB5XGdNAmkNW7mFswp/IT2rHyoooRlq1Js+LS
         Tvw1LBvrcDjSsBvVv/zdSF7/FBcjdpjN3aD0ke7qS4bcU+N3vMZDoMfzIO7OS1sBLBYu
         KYHw==
X-Forwarded-Encrypted: i=1; AJvYcCWcwJkD6KC0o3FObuAVBkVAW4kYtG3RP55bTyJQU675gPloWf28wK/EYkk/vGZYavdzMxBlwwRzSuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YycJKQtZFKTDA9I8kJLqi+heP26XzCtXRvD7+sBbI2II1WFlj0i
	Jq76Wt+3/k6LEGJOFzu7pxwegqe+ygqo4LFQPTekWVAMeHWtMXp5Lmhw6zn0FnIXG8I=
X-Gm-Gg: ASbGncsMV3Qu1fC5yIjlmLdhmqYB6A9VsowNuEEC4VHIkddOHj01zmuD4PdF5VTGq3y
	2q5NH63VqUVx+zatGpxqclvxeWvQ8IH8S8RY47dzmoT65uU/dhdT6yEOrXvgohHz5hKhRTxagQF
	Waf8EBVZvzFqGFXBJwa8MQgzPLdxD/fmv5jt1EBmEg6DMyg7A+CH3bRpNnU4kxVCGbxKEdNS6yO
	AhNIoerOx7gy6fr5oiQLsDQMRzM8r8fzmnFzK7AND6wL8aWlzlCVe4SGHOZO93fp706fk745ZJk
	gvVohsUQSJJKIrxBaI1nPdF9zuJYZYHe6RZgJShNg11uqUral1PsFFbMSoMGa6A1F/rfqXUTvqg
	P6z1VfOv4SwCihDFdF5v9hKSng6N9N9ChntDYP/Syakk3e5p+p1bec7vlsdqsxxtgD9zqd2N57q
	2RImtxOT/2gCYUMfik8h8LFfXDsfllEUufhsSZHzayxJUt4g==
X-Google-Smtp-Source: AGHT+IHAqxsruoFSNH8r92pXByJZXpbC02cmDf8hvWhdyEsqMsjleZyGXnYBqpX9aTWrKNVK1bjXog==
X-Received: by 2002:a05:620a:2909:b0:827:1bda:ca68 with SMTP id af79cd13be357-8a8e628734dmr448036185a.46.1761754873236;
        Wed, 29 Oct 2025 09:21:13 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f25b89e39sm1089184285a.44.2025.10.29.09.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 09:21:11 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vE8v8-00000004zxA-1YYS;
	Wed, 29 Oct 2025 13:21:10 -0300
Date: Wed, 29 Oct 2025 13:21:10 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: Vipin Sharma <vipinsh@google.com>, bhelgaas@google.com,
	alex.williamson@redhat.com, pasha.tatashin@soleen.com,
	dmatlack@google.com, graf@amazon.com, pratyush@kernel.org,
	gregkh@linuxfoundation.org, chrisl@kernel.org, rppt@kernel.org,
	skhawaja@google.com, parav@nvidia.com, saeedm@nvidia.com,
	kevin.tian@intel.com, jrhilke@google.com, david@redhat.com,
	jgowans@amazon.com, dwmw2@infradead.org, epetron@amazon.de,
	junaids@google.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 06/21] vfio/pci: Accept live update preservation
 request for VFIO cdev
Message-ID: <20251029162110.GQ760669@ziepe.ca>
References: <20251018000713.677779-1-vipinsh@google.com>
 <20251018000713.677779-7-vipinsh@google.com>
 <20251027134430.00007e46@linux.microsoft.com>
 <20251028132855.GJ760669@ziepe.ca>
 <20251028103945.0000716e@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028103945.0000716e@linux.microsoft.com>

On Tue, Oct 28, 2025 at 10:39:45AM -0700, Jacob Pan wrote:

> My current approach is that I have a special noiommu driver that handles
> the special iommu_domain. It seems much cleaner though some extra code
> overhead. I have a working prototype that has:

Oh interesting, maybe that is OK and reasonable.. My first worry is
that we don't well support iommu driver hot unplug, but if it is very
carefully controlled I think we can make it safe. iommufd selftests is
already doing this and I've been trying to make sure it stays safe
without races or memory leaks..

Binding is going to also need some fiddling because we don't want to
mess with the fwspec on a real struct device..

But maybe we can have some kind of direct 'bind iommu driver to struct
device' call?

> The following user test can pass:
> 1. __iommufd = open("/dev/iommu", O_RDWR);
> 2. devfd = open a noiommu cdev
> 3. ioas_id = ioas_alloc(__iommufd)
> 4. iommufd_bind(__iommufd, devfd)
> 5. successfully do an ioas map, e.g.
> ioctl(iommufd, IOMMU_IOAS_MAP, &map) 
> This will call pfn_reader_user_pin() but the noiommu driver does
> nothing for mapping.

Make sense.

So you can't have a paging iommu_domain that doesn't have a map
function - that just won't work for iommufd. What you should do is use
the iommu pt stuff and have the noiommu driver implement its paging
domain using the amdv1 format.

That will give you map/unmap/iova_to_phys and then iommufd will
immediately full work.

Look at how that series handles the selftest, the simple selftest
iommu_domain is very close to what you need. It is pretty small code
wise.

> > After writing the generic pt self test it occured to me we now have
> > enough infrastructure for iommufd to internally create its own
> > iommu_domain with a AMDv1 page table for the noiommu devices. It would
> > then be so easy to feed that through the existing machinery and have
> > all the pinning/etc work.
>
> Could you elaborate a little more? noiommu devices don't have page
> tables. Are you saying iommufd can create its own iommu_domain w/o a
> vendor iommu driver? Let me catch up with your v7 :)

That was my suggestion, but it seems you tried that and decided it was
too hard with groups/etc. OK.

Adding a dummy iommu driver solves that and you still get to the same
place where there is a paging iommu domain that implements an actual
page table with map/unmap/iova_to_phys. From this perspective iommufd
will be entirely happy and will do all the required pinning and
unpinning.

> > Then only an ioctl to read back the physical addresses from this
> > special domain would be needed
>
> Yes, that was part of your original suggestion to avoid /proc pagemap.
> I have not added that yet. Do you think this warrant a new ioctl or
> just return it in

I think a new ioctl is probably the right idea..

Jason

