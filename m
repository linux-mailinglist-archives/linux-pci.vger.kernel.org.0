Return-Path: <linux-pci+bounces-24149-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5EAA696B6
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 18:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 692B34226F0
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 17:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CE31F8730;
	Wed, 19 Mar 2025 17:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="nV/VpToK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768C11F4C88
	for <linux-pci@vger.kernel.org>; Wed, 19 Mar 2025 17:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742406062; cv=none; b=YYZyy7/xlf9eMa9WeW3IO3OvrBa5PqkXfGFDFZ0AkcO/7gFUUAvJ6wduB9473vVSCMQon4UYMTN8e7LhBMsTHjP03k2itbZTnxq3dYb/YwxBfYPEr9vP+uEK+NgWDvNDGLYOcH0ByJ3CNtbpoRHF/Xzk8DcRjSdbiIUjJJBKbW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742406062; c=relaxed/simple;
	bh=Uup4ij0e3QxR7P+2AXE6ojI6gZ035al5TOyCCZJD8FY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QYbyoeCmcFgrcqmNVGS10k7LMYVWz3pJNfbN1QNoXgoyh7uHPGoXf0aRFdSBpb5MJhFnLaYIgWrqcxFHPL7uzqJ0Nrv/gKPOsyxo5sanPdKp1ep5nEe/ehryfQYnX/Vc1vH1RQf9tvuXLM6UQ9ZC5j1UVyfKVkgrzYi2bJvCQ+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=nV/VpToK; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c542ffec37so705335085a.2
        for <linux-pci@vger.kernel.org>; Wed, 19 Mar 2025 10:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1742406059; x=1743010859; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=leCUW9KEkZQcVeVok9ACFyeDj4RZoftXqhcJPMWCJYU=;
        b=nV/VpToKK1Aoc35hYasv8EBUTMZK3YWljurPD2RE8K95jFcoCmONYbBpbib1QPyFbd
         zSv/Fnk+PNhWJ/yPZHfQrWxfNZCut2KGrxd3hZas9X5TZ7EXb7a/dokHKpxOytAT4pQ9
         gfeyNgK4YiJtjD06hxgzxo38t1AVC0Vdkwe+i1EL1u+f4qzlchDtmyVqmWb5xb9CtAnf
         CMt/PYJWppWD+Yuqh6qT9h2143TT+qM7QypYtCpfyJf8bTECAWu3m0vRYjgL+whCaBCP
         +g+MkRpdKaz0uAvhepSHNFG2+jIm5/kc50U3IlZji0KHpX/QBJGLS8rOlfY0KbgUMJAR
         wnZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742406059; x=1743010859;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=leCUW9KEkZQcVeVok9ACFyeDj4RZoftXqhcJPMWCJYU=;
        b=bq3kcNtNVDDB78EQ4IuVK+iFIJLPTnCAmXPV14zB3HSLDzkXIuO4wBoya7Ngo/X7ol
         ep3LgxpO/VKPODZ8QD8aMvSI2fovd13xbpY0PTSYPjuxvjoSMu3S7wwfFihTyYYg5Gp4
         vvikQsLtAE8rr49hiVkbsgo6oSFOWH8wl4aKoEl5VqchCo9RryXketfzlEd8aQgLGr3s
         iwP903Mys3UZpVCjGG9xI4mTh735+QIANRA7Kx/j++pNs3WSJ6tcbSzvWC6tdhDIvpKH
         TsEqRWU140n2Go3chpwd7o9y72jMWQT//2gd2gIicKD45NIKznf9FhVcaZ7URAM+VuXT
         eRHw==
X-Forwarded-Encrypted: i=1; AJvYcCUvQUqPdMT/SVsxN3Az/Jz0ZZ1S0JP79Ga5wDJm9kuTk1aNjYkQozYOXecaemLZ8KshRZYOFcmb+Pc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5nrPRqmKTvQ3Cif/9I/cBxz0oQY21WivEXJuGY+X7zLAFX9T8
	/hCdKvkOjAYF46xjJURfOFz6yFzVBKQyuFKtDmaN1yXpg0I5sfy9zPyizUSGxE0=
X-Gm-Gg: ASbGncu1o7riiLAkg7/v9zobJL5159lwrJ7Ge7VB8KCWUFfWIx3z5Bt8sfEmC8ebzOg
	WtdMEmq52tDx7KLJQpaNiHyzQeHyP2qIfzulbUwKikgGVTJAiu4TBZdbMHPM9qVmAFZQdnyiTeB
	t8Jxc60e/AgPSk+sDBgH3ppZWG9ROsB9mh29lqU3moVU2RIA0+k64LrDmHPI0hmwRXJq2Jk0j8M
	tpfE4p6w4HChbXAb90iv+nmds6kx8dA99uVwEJLXo2Fqdj4NQh8t68giHgLalhaexrt+JOfVTil
	SuV0J4uGgsdCZhe3Z8AT9wi+iVBjmCc7VMjlVLbRfEmZmji7V3+UDqs2fpkkaNNTnZ99aAXhmVl
	aosGYExBwgamZ0XA8FYVme34RUH+m
X-Google-Smtp-Source: AGHT+IFoJAQ9bGba/Z0yZg+D8yG6xp2ytZSUuDU+bbhNp9w3ofz/kSX0XQcOY4VVJjVXQ+26hrcvHQ==
X-Received: by 2002:a05:620a:57b:b0:7c5:6ba5:dd65 with SMTP id af79cd13be357-7c5a84a3654mr479964285a.55.1742406059344;
        Wed, 19 Mar 2025 10:40:59 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c4dd2bsm884915085a.14.2025.03.19.10.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 10:40:58 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tuxPW-00000000WcK-0irF;
	Wed, 19 Mar 2025 14:40:58 -0300
Date: Wed, 19 Mar 2025 14:40:58 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: Michael Roth <michael.roth@amd.com>, x86@kernel.org,
	kvm@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Christoph Hellwig <hch@lst.de>, Nikunj A Dadhania <nikunj@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Steve Sistare <steven.sistare@oracle.com>,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Dionna Glaze <dionnaglaze@google.com>, Yi Liu <yi.l.liu@intel.com>,
	iommu@lists.linux.dev, linux-coco@lists.linux.dev,
	Zhi Wang <zhiw@nvidia.com>, AXu Yilun <yilun.xu@linux.intel.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>
Subject: Re: [RFC PATCH v2 12/22] iommufd: Allow mapping from guest_memfd
Message-ID: <20250319174058.GF10600@ziepe.ca>
References: <20250218111017.491719-1-aik@amd.com>
 <20250218111017.491719-13-aik@amd.com>
 <20250218141634.GI3696814@ziepe.ca>
 <340d8dba-1b09-4875-8604-cd9f66ca1407@amd.com>
 <20250218235105.GK3696814@ziepe.ca>
 <06b850ab-5321-4134-9b24-a83aaab704bf@amd.com>
 <20250219133516.GL3696814@ziepe.ca>
 <20250219202324.uq2kq27kmpmptbwx@amd.com>
 <20250219203708.GO3696814@ziepe.ca>
 <604c0d0e-048f-402a-893a-62e1ce8d24ba@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <604c0d0e-048f-402a-893a-62e1ce8d24ba@amd.com>

On Thu, Mar 13, 2025 at 03:51:13PM +1100, Alexey Kardashevskiy wrote:

> About this atomical restructure - I looked at yours iommu-pt branch on
> github but  __cut_mapping()->pt_table_install64() only atomically swaps the
> PDE but it does not do IOMMU TLB invalidate, have I missed it? 

That branch doesn't have the invalidation wired in, there is another
branch that has invalidation but not cut yet.. It is a journey

> And if it did so, that would not be atomic but it won't matter as
> long as we do not destroy the old PDE before invalidating IOMMU TLB,
> is this the idea? Thanks,

When splitting the change in the PDE->PTE doesn't change the
translation in effect.

So if the IOTLB has cached the PDE, the SW will update it to an array
of PTEs of same address, any concurrent DMA will continue to hit the
same address, then when we invalidate the IOTLB the PDE will get
dropped from cache and the next DMA will load PTEs.

When I say atomic I mean from the perspective of the DMA initator
there is no visible alteration. Perhaps I should say hitless.

Jason

