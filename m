Return-Path: <linux-pci+bounces-25089-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 720A4A78022
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 18:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C99C16E71C
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 16:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD4B210184;
	Tue,  1 Apr 2025 16:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="OkF337pt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B50F20D4EF
	for <linux-pci@vger.kernel.org>; Tue,  1 Apr 2025 16:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743523984; cv=none; b=iUsUleAhtxxiY800yG5DQ8PcoOZ3MY80Isa9HOtaqAee07dNGXwMEf9BvwJrMLfn41uXWHnC45Teo+Q1iQ73QaLpbRAkqBfG7oFLS/nhj2x8hplRKU7oyGA4iF9EuTv4GmJdSSDPsFVDoU1eYbHc3w6JU4HcECTf+lyW9pavjS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743523984; c=relaxed/simple;
	bh=jsPocqxTm3Tk/n85dNMIT20KutkK5Grt6C4lCnIAUO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a49eOB5xPzfMIyseLa3SlJWLaQYj0tA4lZ/ql2Viz4aMIVb3mLfNZBAoRqXc52yF0xGBfvMpXTJy/DPRCPknMmePRO6yKBh7vMUf2JHWciZ9JpDU+rmKxkOcTg5R6/yYrgLIP6P0MLeFbe+B3u/KdI4Z+nXnl/kIWUBAjjsAh6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=OkF337pt; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6ecf99dd567so66466026d6.0
        for <linux-pci@vger.kernel.org>; Tue, 01 Apr 2025 09:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1743523982; x=1744128782; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=poENEUfmFrThnex6gEytUaMxRROeOKxTbEdDijAo1Do=;
        b=OkF337ptmaSGSO/Fb51bNIyjF3oykWekyVj9KV9e4URhEbQhhUxxr4Vvl0fZBY9KBY
         E/l7XCOzlH3X6+82dkWtPWqYgLfzsya4SYo5QPxtNpas4f8ED7bBW1Q2jKf/u57oOVfi
         z7xU0v25T1yw/fndHJTu+hIXPIvh5BIAB70ybmGeVoGzpwWa+ZwCGDzjDKr5LYtkexLp
         ik5AE92RKT0nDjd5RNVX2z3QVMMJsthQBPs66dX9AgM0AkGiMFvzKvb91eila9ujdgyN
         9tKezltSQS8PXyz3somM3Q7A+Z9uErccCoxsh0PkA3W1+s5eqCOpwOJmDTfDDv47n2+f
         odFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743523982; x=1744128782;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=poENEUfmFrThnex6gEytUaMxRROeOKxTbEdDijAo1Do=;
        b=iA8+0KHjQSU8Bt4E/qYG7oRVH4SXnxlcNGk4HDgxJio7fiZIBJNucST8bAcT6TCY7g
         Ch91XFU0PM/B4FwR/Cihkq0B3rUbH5ixSjqupAyFWPjoGMBLLZbW8uxtmQ8ormFQhJ+K
         PQ0nOyygmC3T9btxxOzZgmExYdI38ygeKDWO7TknIo+7BrI9OhI7bMREODEMypjULvNj
         DPrRSIxxoy9a6L8tcCBdflwC/ricf91SO1DUzXrsfyXAd0B7UpP/wbXT289wplUmzS0i
         AG6v4oMjRD9/128O+bB+9vbLyOHzx0DxYNaTqM6gNZ+WmMpOCJgr0BaE61IDtDFgE+k8
         /rYA==
X-Forwarded-Encrypted: i=1; AJvYcCULXw1t6578Vjc5EodZjqc5SOMkhVRFLXuQdRLq30lFjJM9gHhxgUFW1ZrX1lpfsibBgSGhVHgbxjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJHmg+vmXWNmDRvqi1EQAO3X85JkB7l872ZrSe3gkn48CspkEC
	7mAO83N3vqJa2J/BV9zz5KQI1zj1/ISLVWWucKcuTrPEAdHC1/3ZhRb4lHmog/jwIjMGNPed6Yf
	0
X-Gm-Gg: ASbGncuU0vFMzWluIeFEnz+uHvpxneo91j/Rcjt6KD7ci++fWGrcG4wjAzL5ySKSy6Y
	gy3BAl5RZnJz6Ql2r2TsFINkRwHC8xAtHafXZ/5WDGfZ1niJ0UjH0DU1WMWCYk/6+YVUdF8pXPd
	74QFWbleKIBdkt8rS2ZMQ220LAiBOklsOJYiaet63xdc4wsETjCxEQDSRcpEUNTCjJ8N3uQzXwF
	f08vSh742juJx9+eJKUYFqFRq4zUUFLyTeVes2zrL1d5o2dElrnHbeAVyXViM1CuKfR9xgMaPpn
	nbck/3hWhrtPs5U3j8+UkPsR2YGsDFNMJEHDaohl+0PVzYL3+6Hufpcn+KuxL0omLGyVg+Vz2dA
	ln9lsX6Or9pihxUY/e8U+mpY=
X-Google-Smtp-Source: AGHT+IFgqnXSN6fOa8wvReuysgLZpbCK1HhkdqcE+Mm2zYjIPC+dt/OEL3eUy9xyw3HgFZ9lLvi7Ow==
X-Received: by 2002:a05:6214:226c:b0:6e8:f905:aff0 with SMTP id 6a1803df08f44-6eed62a0be1mr227091686d6.35.1743523980713;
        Tue, 01 Apr 2025 09:13:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eec97718e1sm63039286d6.70.2025.04.01.09.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 09:13:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tzeEV-00000001MLv-35Gu;
	Tue, 01 Apr 2025 13:12:59 -0300
Date: Tue, 1 Apr 2025 13:12:59 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: x86@kernel.org, kvm@vger.kernel.org, linux-crypto@vger.kernel.org,
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
	Zhi Wang <zhiw@nvidia.com>, AXu Yilun <yilun.xu@linux.intel.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>
Subject: Re: [RFC PATCH v2 14/22] iommufd: Add TIO calls
Message-ID: <20250401161259.GM186258@ziepe.ca>
References: <20250218111017.491719-1-aik@amd.com>
 <20250218111017.491719-15-aik@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218111017.491719-15-aik@amd.com>

On Tue, Feb 18, 2025 at 10:10:01PM +1100, Alexey Kardashevskiy wrote:
> When a TDISP-capable device is passed through, it is configured as
> a shared device to begin with. Later on when a VM probes the device,
> detects its TDISP capability (reported via the PCIe ExtCap bit
> called "TEE-IO"), performs the device attestation and transitions it
> to a secure state when the device can run encrypted DMA and respond
> to encrypted MMIO accesses.
> 
> Since KVM is out of the TCB, secure enablement is done in the secure
> firmware. The API requires PCI host/guest BDFns, a KVM id hence such
> calls are routed via IOMMUFD, primarily because allowing secure DMA
> is the major performance bottleneck and it is a function of IOMMU.
> 
> Add TDI bind to do the initial binding of a passed through PCI
> function to a VM. Add a forwarder for TIO GUEST REQUEST. These two
> call into the TSM which forwards the calls to the PSP.

Can you list here what the basic flow of iommufd calls is to create a
CC VM, with no vIOMMU, and a CC capable vPCI device?

I'd like the other arches to review this list and see how their arches
fit

Thanks
Jason

