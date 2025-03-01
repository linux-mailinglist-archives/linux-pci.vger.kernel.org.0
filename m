Return-Path: <linux-pci+bounces-22688-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78035A4A6FE
	for <lists+linux-pci@lfdr.de>; Sat,  1 Mar 2025 01:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88BB8172305
	for <lists+linux-pci@lfdr.de>; Sat,  1 Mar 2025 00:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA88A29;
	Sat,  1 Mar 2025 00:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mFC1B1ap"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF113594A
	for <linux-pci@vger.kernel.org>; Sat,  1 Mar 2025 00:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740789124; cv=none; b=U9vgi0bR3pXXHpx0TzMwNz9Bbpfl1KudiJHclRi6hm+Ry/XM79XZGbrceDZNJElEQ+4+iNO/QvnwpWwvgSFMU4tcLb18IDUo+Hucrh8TqNncTmFA1baWEdhnrmQtIinj73AntMrIY8PYymVDA2gY/72BtXstNJ9g0aeLRfkx9nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740789124; c=relaxed/simple;
	bh=IJ/uAZ1nD5RItLsU4XWErABvAF+S58BRfovN898A/9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PQK3SlIOp6uov7MxQ1fcSF1fLJhPfu7nLf7RaVtcO3OE7pNrvYyfGrYlFQNAX7+h+sL1oPv2aROySOUaHw9A5j9wTLKGjCiuASpsp4ao0bVu2K1xjAvR/zMJwSobfcjqDYFrlLemeZL+yXhUYhk06R7t+DR4FS6l1t5wafNnOa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=mFC1B1ap; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6e895f3365aso20692506d6.0
        for <linux-pci@vger.kernel.org>; Fri, 28 Feb 2025 16:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1740789122; x=1741393922; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UGmZpux3eW+jxhKZP1ofv0c4XveJW25IwmZp9EBvmdU=;
        b=mFC1B1apIrNCT3CEaWOaZfF897Bwkk91NcFrXzphWUUjDCnqun+uvkpQFsbIpfhh7x
         T37YvUVFipOnx7mADpt9lRYYd0wDcKsNYbbT8BArnl9PDN1xFPcA5iDUPdqZW72H2Wb8
         IZdspFVXT2eCxubp/t3zh/EfQHx0oI32EDDn8piS2H99QusRurSm2irfuQzIqLq1r56h
         qpWyoTRv4WgwMnEnZ4l3k8iV9z49jZLsXw7hnxhX2O4npR74xVsnUnCOBnCHxnMh2uNC
         m0CgQ8RsrrlPJwLH0B3Lz2gMZayQxGS5PnuZH0GX4KErifVzQGyhlUp9OXDj88E93NDD
         9rrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740789122; x=1741393922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UGmZpux3eW+jxhKZP1ofv0c4XveJW25IwmZp9EBvmdU=;
        b=Gk4UsU2h1V+b6DTawa7JfAVBy1fb6g09pRbuT6Gutxk7XaP6Log7YtRHyfw7ZGNmZ9
         7+FgBhMJmPpPJddp+ex96z+AY2OelkrXMAxLo6PlhDz7Kj8PClfLD4O83l8nwa9UDjMX
         isxcvzZ/dlUiQTq2agMM7TXheJto3TmyeuOORP+5/NORe6GX2AS9osOm0G3nlce/gvIR
         Hp3mJpk+gRH6B+NpoNvRZ5vY6MqFrTlkOoalWcpGf3tSGg62q9FgTyJW+3How9NpLdp1
         DCU8S7nAx6fAnoP31+lHjmzFCsUnNzckxVp44AqhJHRmApXmv9brvHyxd4u0r5AV/ajP
         fHXA==
X-Forwarded-Encrypted: i=1; AJvYcCU80KHc5ovKQs+kYsWDjHbwbfIDS8UDb7z3sUXSl4pUxEhSZ9v05vYMd2hiUOXSHC1KNGcoC1RsDt8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhn10Bj9JPN9sGzwKUZEBSlIvKQ/sYedo7zIgCxFkrQQDthL74
	Zg/RP9TLLrwLg0yP+jAiCJiNN5QlewGu2e8Bdf8Qp8m9X6j1qNTcuFB+mS0uNCA=
X-Gm-Gg: ASbGnctn+3WwxbLZO7W5H9NfPxbkthyNzyqJlEh4N7stGiPPDBlGYGLIPYG+I2uoJ/F
	ASBQjTE4Mm/lWrhhBTgnZPGmeIG8VxnDtVFdfvfARTJ322AiJhnVQKiMDDfd24ytfDaZvsZbRbA
	M6iGcO6jXSoB4YfUzwb4z1G+56/G69k5gz3KbFh25F4gto77/LbnwfsvlumtdFBjmvaWMDR3NzW
	WO8WAPpA9+AEyodScdnjCh440a0LGqMJ5xjQCWVe1zNhGxpLajLSznh5NgyQ8G8IABbmp1O/XXg
	l9q7buG9xpgPxSvLLreQLydFNYvRgacrVyVKuLG0xes2md7kYbo1R/+4ln6ilmhdo9qDfZBG+Fn
	KzuWos2JfggH7fXZ19w==
X-Google-Smtp-Source: AGHT+IGisC/6wMYSFfGCwksz3Hqk310E6+QHChS9Lt2rzSb1IaRmOie8VRdlWltqdIKsz9jGOQcrlw==
X-Received: by 2002:a05:6214:2586:b0:6e6:617c:abb6 with SMTP id 6a1803df08f44-6e8a0cd3b06mr68816196d6.6.1740789122305;
        Fri, 28 Feb 2025 16:32:02 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e897652066sm27657806d6.30.2025.02.28.16.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 16:32:01 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1toAls-00000000VPg-3Ini;
	Fri, 28 Feb 2025 20:32:00 -0400
Date: Fri, 28 Feb 2025 20:32:00 -0400
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
Message-ID: <20250301003200.GQ5011@ziepe.ca>
References: <20250218111017.491719-1-aik@amd.com>
 <20250218111017.491719-15-aik@amd.com>
 <Z72GmixR6NkzXAl7@yilunxu-OptiPlex-7050>
 <2fe6b3c6-3eed-424d-87f0-34c4e7e1c906@amd.com>
 <Z77xrqLtJfB84dJF@yilunxu-OptiPlex-7050>
 <20250226131202.GH5011@ziepe.ca>
 <433217be-55e3-477b-bc10-cf81f02ab21e@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <433217be-55e3-477b-bc10-cf81f02ab21e@amd.com>

On Thu, Feb 27, 2025 at 11:33:31AM +1100, Alexey Kardashevskiy wrote:
> 
> 
> On 27/2/25 00:12, Jason Gunthorpe wrote:
> > On Wed, Feb 26, 2025 at 06:49:18PM +0800, Xu Yilun wrote:
> > 
> > > E.g. I don't think VFIO driver would expect its MMIO access suddenly
> > > failed without knowing what happened.
> > 
> > What do people expect to happen here anyhow? Do you still intend to
> > mmap any of the MMIO into the hypervisor? No, right? It is all locked
> > down?
> 
> This patchset expects it to be mmap'able as this is how MMIO gets mapped in
> the NPT and SEV-SNP still works with that (and updates the RMPs on top), the
> host os is not expected to access these though. TDX will handle this somehow
> different. Thanks,

I'm expecting you'll wrap that in a FD, since iommufd will not be
accessing MMIO through mmaps.

Jason

