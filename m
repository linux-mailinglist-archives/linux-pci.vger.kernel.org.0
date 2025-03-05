Return-Path: <linux-pci+bounces-23010-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5C3A50B52
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 20:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5C993AD0A5
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 19:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42257252919;
	Wed,  5 Mar 2025 19:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Ri5MkLza"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D9A253B70
	for <linux-pci@vger.kernel.org>; Wed,  5 Mar 2025 19:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741202313; cv=none; b=LnJU3FpNHrbGmWwLsO8Pm4LX+u3lvlih5UPIDPUc9ZnPfydoO1StjZqf8TLzLmM+9E1Gu2A9khdeeOqUswYHd/TSjuprxnBs/zwPIP9ntU0tBFsH9feqN38nSSWCk5j89jH3IRAhvzxk91bE7G8iwHeXFryv3L2JlxeXFqcqzlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741202313; c=relaxed/simple;
	bh=3SzijABCo7L0oRCqEvdXZEB88jTL2x7bJ6AOPFFhYh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M/D/VXwuoYPGJmi+TrOIyS7e8MeYY/hXSI4ttu7vLIRoGsL68CON5PRoYbFwA5yD3qWgFxAia5tJCUqHNrDhIZQsSFU68JOR5IPrBB4t/Twfc8M7bZ4AFe316X1a9VeYSJvYqoa6yziPhhb93e4HeVHVTEQnakrbDkjCSHVkYEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Ri5MkLza; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c3d591e50aso209956985a.0
        for <linux-pci@vger.kernel.org>; Wed, 05 Mar 2025 11:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1741202310; x=1741807110; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C7y/oLdinpDpvBC2aTZl0N56MEM+KgeXEJqvXNG5yTE=;
        b=Ri5MkLzaGreAbObP73Bg0DUXzSzTK6q/AiY/Qa6v6PeP7iAXQpiD8TsWAceA6vex1W
         ZBne8M5S7QeyS1lAJrLeL/NHUiLL2cbx2ytZc02wOOxFm5jtxDwmpNXnjMEw5RTBAYwH
         HU7E6CDaRtRYNyEJI2naFRsz0LoDyP3H37eS+JFqTcjNbBrYcyyl5CbnakIT/l/oyZwQ
         bbYNBDepJcuWmmx6z06u4SrMjCXnZUHqIsw21E/W+YRUHy3IR8aXhbE4Vr9pXf+NEHO7
         6rTGw9W3SpnjoO5kIhkjo6sAWEWCzWU5Nbvy5iKrLHt8blHyqJ6NPT/96U81+MqS8I5B
         Rnag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741202310; x=1741807110;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C7y/oLdinpDpvBC2aTZl0N56MEM+KgeXEJqvXNG5yTE=;
        b=XRhGL5hlsVnXW7ywqviblpVxzV3Pw1ZapasFQb0nkv0P7t5eY+A0Hr66/tb9DaJM/w
         iLvn6/Z55OLTpWEAGvyIDiTGsET9Sfwf4Xadn/mckSxP5M7F8aFYLfcYNZEfL3uyJmso
         0Bx7709doEwax44nXDabBecvu06N21qSvGRV9zdhuBrMJYid9QktwXgMg6A0ozB8EYFA
         E054XDYaaINt9X3Dd4wUQuTGapCv+u0EQG+u8vcC6kAHGptQbRyDmh6gxAhP1QUoBhMJ
         hcmnEUXSfeMZy3aFj1GcAlgW8QpC1chzhQUNvftFSaXNamOtwifknZhfEtGUy5msshH6
         3Udw==
X-Forwarded-Encrypted: i=1; AJvYcCX0udWJvhjO7pUS/D91UZV0W3Rl1Tn3FQ8ckq5doKFnaQAKcpcmnrQl4g1ZIXdpphpIVjyyTyxylwo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyik57JUzIFfrkfxrzS/IPTwTR0/3c0pdsytk7/pQANqT6L0o5B
	LMV/WfRBST2SO3uxN7dJwHT04DE6Xy6djHr8noc2XZrEmcI3I4lBEPgZ+UNKZSk=
X-Gm-Gg: ASbGncvQBO3aTXsYEPwsFKyZ1oUhcchBYNgPotFcVlqCu812fvp49PAtKUX5j7h+qSh
	lXiLMN9uMSh+MGjOl92MJUwULMKNSXjAS2CtHStXtJF1/T5X6P5WpGOh9aX/ryMyPYOf73ky+CF
	aqzYNGeVQ2XHtLalt1UKfamXRlr1fnOko465tcHNH8YEESHKReuucNIonkIiBXVAKjTsmpRen6S
	4/F3eAw4cIopNzxG3YjisRbX+zqCD4dZlph9S/aRHpOLrvAVQd/emdAFZLkNfz+EekRDTuRfJ5B
	wHSFiF+z7RZYtENZZxzhXs+xl5RfF3QrPvoVcEO3IsWi58fq5FvV3dmcAzQ72GZ7SOrxLhUkWvL
	vGNpl0qmR1+zmsU0pbg==
X-Google-Smtp-Source: AGHT+IFwvrtrBNb8MOcl/UiqO1Z26YCuhB0icUQG2aJEfrzqQ/D1xCWD+/mL64bShsE0pSsh+4l3sg==
X-Received: by 2002:a05:620a:6285:b0:7c3:cd78:df38 with SMTP id af79cd13be357-7c3d8e465a9mr663299885a.10.1741202310279;
        Wed, 05 Mar 2025 11:18:30 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c378d9f917sm915979885a.78.2025.03.05.11.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 11:18:29 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tpuGC-00000001V2T-3xgf;
	Wed, 05 Mar 2025 15:18:28 -0400
Date: Wed, 5 Mar 2025 15:18:28 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: Xu Yilun <yilun.xu@linux.intel.com>, x86@kernel.org,
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
	Michael Roth <michael.roth@amd.com>,
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
	Zhi Wang <zhiw@nvidia.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>
Subject: Re: [RFC PATCH v2 14/22] iommufd: Add TIO calls
Message-ID: <20250305191828.GD354403@ziepe.ca>
References: <20250218111017.491719-1-aik@amd.com>
 <20250218111017.491719-15-aik@amd.com>
 <Z72GmixR6NkzXAl7@yilunxu-OptiPlex-7050>
 <2fe6b3c6-3eed-424d-87f0-34c4e7e1c906@amd.com>
 <Z77xrqLtJfB84dJF@yilunxu-OptiPlex-7050>
 <20250226131202.GH5011@ziepe.ca>
 <433217be-55e3-477b-bc10-cf81f02ab21e@amd.com>
 <20250301003200.GQ5011@ziepe.ca>
 <4ae5eda3-824a-4bb5-b763-19083c085575@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ae5eda3-824a-4bb5-b763-19083c085575@amd.com>

On Wed, Mar 05, 2025 at 02:09:09PM +1100, Alexey Kardashevskiy wrote:
> 
> 
> On 1/3/25 11:32, Jason Gunthorpe wrote:
> > On Thu, Feb 27, 2025 at 11:33:31AM +1100, Alexey Kardashevskiy wrote:
> > > 
> > > 
> > > On 27/2/25 00:12, Jason Gunthorpe wrote:
> > > > On Wed, Feb 26, 2025 at 06:49:18PM +0800, Xu Yilun wrote:
> > > > 
> > > > > E.g. I don't think VFIO driver would expect its MMIO access suddenly
> > > > > failed without knowing what happened.
> > > > 
> > > > What do people expect to happen here anyhow? Do you still intend to
> > > > mmap any of the MMIO into the hypervisor? No, right? It is all locked
> > > > down?
> > > 
> > > This patchset expects it to be mmap'able as this is how MMIO gets mapped in
> > > the NPT and SEV-SNP still works with that (and updates the RMPs on top), the
> > > host os is not expected to access these though. TDX will handle this somehow
> > > different. Thanks,
> > 
> > I'm expecting you'll wrap that in a FD,
> 
> A KVM memslot from VFIO's fd similar to gmemfd's fd, and skip VMA? Doable
> but 1) creates a KVM->VFIO dependency to do gpa->hpa translation 2) is not
> necessary in the AMD case (although host-mmap of guest-assigned private BAR
> is way too easy way of shooting yourself in the foot).

But since it is necessary in other cases, the code will be there and
everyone should just use it..

> > since iommufd will not be accessing MMIO through mmaps.
> 
> here I do not follow, why would iommufd care about MMIO? or it is about p2p
> DMA? Thanks,

Yes, p2p dma

Jason

