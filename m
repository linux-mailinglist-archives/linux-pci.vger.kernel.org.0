Return-Path: <linux-pci+bounces-33142-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C37BB155D1
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 01:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 785A618A7D34
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 23:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB0B28506E;
	Tue, 29 Jul 2025 23:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="N2Etk7G4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CFE281531
	for <linux-pci@vger.kernel.org>; Tue, 29 Jul 2025 23:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753830995; cv=none; b=d1yA9c/0AzhOeyG9JtdYjrWo58NjBpjZ8oclLTj8M1Gzs06HrEfqmdKzWJB9NuiKvx4A2FiZyh+m4lRKh5f+WVd1Hhwkfto2efyFNAxMWjk65uFk1Ca/8Fb8p+taqs51DHVR8ghsGBT5MGtlk1/khYWGCevA/QiMULITOMB2pC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753830995; c=relaxed/simple;
	bh=bq2RlWHsFjj3W7R7JIUlOjH7x9ItqrAb031ifSmshcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q/4sIi7jGK8LvXc9/gIIBUTHAomUDAmFUMHdjrE3xpNvhh5xnpd+0ls8p4zFofnTggqRxEXDaXA70CHGJMup3vZJ4RgC4UdfC9wa5O7TF6vAC9y+VuXExIDvREk244NIOrJXDs1DpJzGF+xQ09j0ID1ZgV01FReEaWu/dHFqOSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=N2Etk7G4; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ab9ba884c6so5225141cf.0
        for <linux-pci@vger.kernel.org>; Tue, 29 Jul 2025 16:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1753830992; x=1754435792; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8wQLLnlIOT2tj87satzYfNp/smzLn3IXRBaMhgwLr/E=;
        b=N2Etk7G4Xi8hSlqlf89KDSnUG2poyLfgf+GT19Utfp7E9xQQIKf7SDwmWUGpNMAf63
         4FVmff2yAYU0qMxgXNkt4G3yQ841Q/Hu8wrk2ukqb2h5RiW/HH2djbrBBVg4h4NfYs3X
         Fj8JArGKdu96S5HjS6uHaBoMdr/aaXRQnvnKLTmyY6kUFsVmnW/AC3COA7iLAqkY8QVh
         7wWcqRvbWVMICrwfHS+nj9vF6rnyDAJFGm/fTLfDA18t6sGV8FnFIV2bYfsobF2npCqs
         hvVjq9I9gAufg5GYmpsheT1UIGoNeoHK6mmgaJ1Q73pFU9MUy/4zBbbMvkrnvGhkl1zc
         3MLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753830992; x=1754435792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8wQLLnlIOT2tj87satzYfNp/smzLn3IXRBaMhgwLr/E=;
        b=c+cQIoQqt7DDDMVL/RTgKK7+Hw3F2oiiQIbA5JiPr+WdIdQ7govH7ZDZmjpAHfE71B
         51auocUAC31SGG7ddD4fuMTaud8sZevuV5ssUAjI3vdm3ntmEz6gqMvSr4OwhhO/e3W4
         tuRp696HouDyRfEsoI8Ueo1PuQzqyjMisT3/3/SHdTfytwXH+cSLwgEh4Zu+KiemOuro
         UXGubjNpCnZvqPDA0LZnHa+pFMybXVw2FVL9ECVdJZ252ws4jusKlvBSL+10AePZoTYf
         /6oLV7x8J8zhWy1EQgexBV/nQiW6EiW5kVK0ezX9XOhMx4yjDpZrjsapPDbvQLDi+wlY
         yUBg==
X-Forwarded-Encrypted: i=1; AJvYcCUGRDP2obHcJhpwqR/GRdJvrGnHjJjbxRXU6eXAAwfoHf4j6rRr6wNBbf6TieFcJ9jx3hUYIkxoDsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXxKogP9qvThZLitNq4ktUtydGvkPsYkQ7jtXSFPLdtYxbPUGS
	RMRs5YqwqWGL05ExC4eOs9dqS4b0sOxvU8rMrfsK4P9cled10WntMljUc5jCghp3O68=
X-Gm-Gg: ASbGncvwaaeubZGOVdxY1qpazHjUvzTUdYBjzs+snwuo8JrCc15f0k9wR6y6+jK3Zzp
	BHeqToRZhkAAgOlx6liOJh4QoBTOgg6aD9Al0nkT1/2Cf+y6fcpv/eLiMP+oX4T40ZamIKglhdx
	Ej4pfE3xEmzsqK7pptzsOOzSuaJgf0Hrr/sf2I0uWr9TupzNdFYUbtpr6CFIbuHwoKqWUM6r3Bt
	foabQagKdZoPQPbMFAqO9xUms5ddFxdIt1PQqWf9HdRGqwgVvDO+TNLLGs7e9Pq4jKmKJa/7KoX
	UERTaRGAWRY4iqSt1u6YVobjZXK6Y0kRruo8tXhjtqRP17iFMyjAbcFcD8Ml3fM5TsIjqpzPofm
	VKT/YfU5eGmraGgMnt96f3q47PEiV0H2zRwm7qsS6OTlUzCqc7b/+7+UakITTd0gJpKqT
X-Google-Smtp-Source: AGHT+IEwE6N4arL2Nfp7kwi5xzmxE5rT1vejHQ7TsbwA2ZmSnSBM/dGl+o0EjInQ6KuJFac70KrvZQ==
X-Received: by 2002:ac8:5846:0:b0:4ab:552a:fac9 with SMTP id d75a77b69052e-4aedc4361f2mr22773811cf.10.1753830992101;
        Tue, 29 Jul 2025 16:16:32 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ae9963b732sm55042891cf.39.2025.07.29.16.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 16:16:31 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1ugtYd-00000000Meu-02WY;
	Tue, 29 Jul 2025 20:16:31 -0300
Date: Tue, 29 Jul 2025 20:16:30 -0300
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
Subject: Re: [RFC PATCH v1 07/38] iommufd/viommu: Add support to associate
 viommu with kvm instance
Message-ID: <20250729231630.GI26511@ziepe.ca>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-8-aneesh.kumar@kernel.org>
 <20250729172621.00006344@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729172621.00006344@huawei.com>

On Tue, Jul 29, 2025 at 05:26:21PM +0100, Jonathan Cameron wrote:
> On Mon, 28 Jul 2025 19:21:44 +0530
> "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:
> 
> > The associated kvm instance will be used in later patch by iommufd to
> > bind a tdi to kvm.
> > 
> > Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> > ---
> >  drivers/iommu/iommufd/viommu.c | 45 +++++++++++++++++++++++++++++++++-
> >  include/linux/iommufd.h        |  3 +++
> >  include/uapi/linux/iommufd.h   | 12 +++++++++
> >  3 files changed, 59 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
> > index 2ca5809b238b..59f1e1176f7f 100644
> > --- a/drivers/iommu/iommufd/viommu.c
> > +++ b/drivers/iommu/iommufd/viommu.c
> > @@ -2,6 +2,36 @@
> >  /* Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES
> >   */
> >  #include "iommufd_private.h"
> > +#include "linux/tsm.h"
> > +
> > +#if IS_ENABLED(CONFIG_KVM)
> > +#include <linux/kvm_host.h>
> > +
> > +static int viommu_get_kvm(struct iommufd_viommu *viommu, int kvm_vm_fd)
> > +{
> > +	int rc = -EBADF;
> > +	struct file *filp;
> > +
> > +	filp = fget(kvm_vm_fd);
> > +
> > +	if (!file_is_kvm(filp))
> > +		goto err_out;
> > +
> > +	/* hold the kvm reference via file descriptor */
> > +	viommu->kvm_filp = filp;
> > +	return 0;
> > +err_out:
> > +	viommu->kvm_filp = NULL;
> 
> Is this to undo side effects from this function on error?
> 
> kvm_filp is only set after all error paths so maybe this isn't
> needed?

Looks like you are right to me

> If this isn't needed then use __free(fput) and no_free_ptr() to
> deal with filp more simply and in teh erorr path can just return -EBADF
> directly rather than the goto.
> 
> Or are we avoiding that stuff in iommufd?

Nope, gentle obvious use is fine :)

Jason

