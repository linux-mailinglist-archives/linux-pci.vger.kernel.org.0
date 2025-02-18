Return-Path: <linux-pci+bounces-21778-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2111AA3ACDB
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 00:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 328EB3A50C8
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 23:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164511DE4FA;
	Tue, 18 Feb 2025 23:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gyCO2oxs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058C11DE2C2
	for <linux-pci@vger.kernel.org>; Tue, 18 Feb 2025 23:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739922671; cv=none; b=lYctWlLC7Nmyf14SEQA+WnZfCFYyWRXgBnDkfG+Xx4VGkc0mG6TbwYcWqZG5kD9TwtRuXUXL+RQqyzhjx7uLbsFtXnxRhcwz62/ge7FXnFWoq/JqmKQfScyesaPaKXk19hM0t1TvTkoO9dZvDumnQn4Hq+WGf1IVlrLEJzASVeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739922671; c=relaxed/simple;
	bh=iKT5gRHJFTk24cvpT8KmAyPqwcHjrkHc67AQuv3guHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLTQ5qNqqHMo45mTzbVeL8/BxRlINiip1POb7OXV8Ggcxz4lXptRZxZsoYZ8UD8kJWH1XvfcLoAokkNOKpkX/rm6KTFkm28dbkmMhrsNzjc2OHWkgAhyMlPiDLRfQ6edqm2pAGACVF0k0J+dtA3hRHdmUkeGH5QyMi2VA+/qT8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=gyCO2oxs; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6dd43aa1558so55801476d6.0
        for <linux-pci@vger.kernel.org>; Tue, 18 Feb 2025 15:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1739922668; x=1740527468; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iKT5gRHJFTk24cvpT8KmAyPqwcHjrkHc67AQuv3guHc=;
        b=gyCO2oxspS7/wo6nKrTP+PvPC3WHPNTT6/JmRriOfZhLiACAnYCQEFSI25NC0zC/bF
         qsqrC37zkhXUI/9OmKKjpIkhjLKCHctLj335ADwtwMIBl1hIncXGBVtv5/nxRpL8ejbX
         LHz+b9Vz/nMApEUQDq9Lc5nBJyHsPBK7k1DyN33LgalFNLN0UL1+RbukmuC4ysEwj0qh
         wgCE/wPcuCDwaNsLdoAk7Eoi6GPSmFhhQDxSHDe5yQpmi9qqG1KNX8rJaDxWtRjwzTh3
         d0tAgD7OX+mSpXFQ6cw+c7BSzWiMhmu1TvZF45FwzBYu7VwPqmD7oEa3C2DbfCbikDIT
         6lug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739922668; x=1740527468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iKT5gRHJFTk24cvpT8KmAyPqwcHjrkHc67AQuv3guHc=;
        b=klRCBCfyULEcuXsoDFG/wS0ejSqpbK6/lrmknSBpf06K9o7x9jfNP/reh5fmt35K9a
         neCpfV9O9GyayJZaNJgn0EFVwq6BFSLSZkhexVn7wH6j8na7l7YiItDMkL9pThG7yr/O
         MvPQ7L72o1U9QPmrCOzUl/f0nXJpWaNU4wQ9Ltx7d2nTTEZGIouB+qEjAXF47bSD7jz5
         wBK9W3Dza3/OtsSN/ygauk33rlP9uv0JSBaBR4V2y3iMZK3EELyVNlqC/VS5ZKDSeGlK
         W5QagX1lhQY/9VhLSllhHrAheecWIxIx9njmAmx1pMys3sf03SN5S4Ml1RK3CuYq+lLU
         vDmw==
X-Forwarded-Encrypted: i=1; AJvYcCVz4r3n1ThN6IlhAIW7bbRgsq5hfItrmc+ytYOakSQpYoVNmBo2uturtMwq4xd5cLgeVBo+1F4gG3k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy19HaIBR00Ucnl9I2+dzkXLaTq+x4uLDs4B8LesVcuHN7J7BuC
	wVHKDKd45D9u0tKTtVlRS4HJNeuFLtCjXCM4XCsdz7pWbZq48rGyXf8uFfQTV2A=
X-Gm-Gg: ASbGncuznzxyKqG7q1Uh8A1p2nDR41dqXnU23TYG50KQ7BKbmv6RGyOCMOogy7YX5EJ
	j4nqJ7KfcpMdMC0WYNYmw8fjhiilVy5ZqUurSU7ku48KtoPfNq8Wodcw2p3qlyPlnmZ4Z8pRyBX
	ZjODywJgNT3N4PTbTT8511CQsLPH9Q6a1d00sENYkvHcRVmbXX6iSKuBqwJrUL/bGgfgStYjPoy
	u4oP8qywd2qVQQujWeiZdsufG/HLtBMFKFbBi2lnx8qPnlDPvpq0prmlA82hWugpm0mRXUPQMaR
	ycd7dax1Dmiy2r70AxwxEVPdakjGaLhT6MHl9Mwzf69YaU2nly1vDqv1ngHwMWVi
X-Google-Smtp-Source: AGHT+IFO1/6l3OUxeVa8mqeoAIRJldW9bBpco9S18W39RUG+1rvPlDolxLvoJK10Ea2Dnll0//ehxQ==
X-Received: by 2002:a05:6214:1d09:b0:6d4:3593:2def with SMTP id 6a1803df08f44-6e66cc8aba1mr253639746d6.5.1739922667835;
        Tue, 18 Feb 2025 15:51:07 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d9f325fsm68981726d6.76.2025.02.18.15.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 15:51:06 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tkXMn-0000000020v-3I9I;
	Tue, 18 Feb 2025 19:51:05 -0400
Date: Tue, 18 Feb 2025 19:51:05 -0400
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
Subject: Re: [RFC PATCH v2 12/22] iommufd: Allow mapping from guest_memfd
Message-ID: <20250218235105.GK3696814@ziepe.ca>
References: <20250218111017.491719-1-aik@amd.com>
 <20250218111017.491719-13-aik@amd.com>
 <20250218141634.GI3696814@ziepe.ca>
 <340d8dba-1b09-4875-8604-cd9f66ca1407@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <340d8dba-1b09-4875-8604-cd9f66ca1407@amd.com>

On Wed, Feb 19, 2025 at 10:35:28AM +1100, Alexey Kardashevskiy wrote:

> With in-place conversion, we could map the entire guest once in the HV IOMMU
> and control the Cbit via the guest's IOMMU table (when available). Thanks,

Isn't it more complicated than that? I understood you need to have a
IOPTE boundary in the hypervisor at any point where the guest Cbit
changes - so you can't just dump 1G hypervisor pages to cover the
whole VM, you have to actively resize ioptes?

This was the whole motivation to adding the page size override kernel
command line.

Jason

