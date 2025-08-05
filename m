Return-Path: <linux-pci+bounces-33433-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB777B1B7C7
	for <lists+linux-pci@lfdr.de>; Tue,  5 Aug 2025 17:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C8C03B6218
	for <lists+linux-pci@lfdr.de>; Tue,  5 Aug 2025 15:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F4C27A121;
	Tue,  5 Aug 2025 15:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mwgl7qJ6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E41C17E0
	for <linux-pci@vger.kernel.org>; Tue,  5 Aug 2025 15:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754408936; cv=none; b=AsdUkUWrF09pAG/oPxp5C65ZTIxMqkuBFAPxpmv2g06IJfAFX9otczhGy8dhjK3L3R16mMp/a/GJYfsHXNAxaIyUP//QeY9Ce0qatj8tFEXti37bkL+EOJhvsF7o+QmcaVxzAOCPKEOFy2cJED/JSwFhOp6wpP2lIyKqa+LTTig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754408936; c=relaxed/simple;
	bh=vK/izEOcqRroDKEjuurkSpJYsxNQb8UJ35ZS/H8ApXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rdASyLWePa/vCJlBWVU2XvFlZ0N8TrNEQF5haeRq1aGgHOloVzF+21WfNHvDNkLBQge+zT6ZgBEIWpDYdo2+hfYtgHbgXRATG+Y86C1C0qgMj+t7mjFACClQKDGZyBQR/AgA+I18DgmI7AwnssHlu2ElI2Pzz++einII8FWLT7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=mwgl7qJ6; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7e7f9bba93fso303228985a.3
        for <linux-pci@vger.kernel.org>; Tue, 05 Aug 2025 08:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1754408933; x=1755013733; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PvWDI0NE7eWO/Fmxnrgsva4q0z87yVrAZ5bf0Zwi6vs=;
        b=mwgl7qJ6p/ao3J4JZxrHo/YRlJYtkuRXA0mxewJPMc5JNGt0QbFbbUr7DlMQ1qIT8/
         geBnk5VR8Q+b0gjBT22pq9faGwm0MF57Xic33ONgGx7EimVCcaSSfmNAD8u1iXubXhQG
         PKg6cJ8uKMuQrg1yooKcxAnhaAeC9UKrtGcfWB9ZMirXqTBTjCIFutAJcOwUInqHgH/l
         Bwg7nw5PQY2OQulTPNPbQuEuGm2kXwcIrQkUBLkrcrEB/6PigtgdbdyxRnsdhmZOJNTQ
         6oxBt7Atvni7Ez08E3ekakz4ocD7D2c9hIsV5TZUGNkzKf8pS9Myyt2ckkrnHa4ZjNDV
         tfyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754408933; x=1755013733;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PvWDI0NE7eWO/Fmxnrgsva4q0z87yVrAZ5bf0Zwi6vs=;
        b=E9CllIpSmSlUvR+nqAs8m6ONQsLRkTr8qL9nYKO0PftDZpvFQxLiJsbEfDvg8vmcg6
         qT9vYu1vkVmjp+KtSU0CiuWK+1rcaVCJifcvse9Ak1nLVYeyXDd60pdB7EAZfO4kaQil
         6czA827DkpF6PFs6bwpw0+wW1MVRHQQfD0GFz/nEy0NkB8evOIm89dkHhfRoJxP3xyIw
         YIH1X7v5/iN5kgs3my9IwDi+YIPgU8vSphHqikyjuPaPOkC5xshwtwQUqs+bK8bo563b
         KKzgrXIXV9u7Rq1LS7mOCZzXKkQTPw8uZ5BTwtj3kl0d6OlueApg88kn59QJsTsmgMng
         0AdQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3rrP6V9LNr4nx7NIV2+HNVXzkyrgRe5K9qp4EXF7+NDe9XyQzCKQbIHed61vakfAxuBg4W1Hejj8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCj/Su7ut6yP0+nddid2ZRk1Z2kGgDCHH8s9DSgXr+fqzpkPcf
	X98+boo6XtUBl319rJT2SU2zwC7+3a1bl1cCADn3ax4m/g04+YbKdrnhm7mYAfOszs8=
X-Gm-Gg: ASbGncuxhK5WwdWGrTcYfocPjgVHLz0AGuCyveM4HnLFwrfEIY7Q0mGkJCgLzA9D7zG
	bw9Ed6ODQhhjbyu4iWNwnWHcxxVsrZdVZxryOTyJjwYJ6PAd7OrIRsbL5WgGzBkWfYOBuvJbsy+
	vUX8Jj4bQRNukvlUerAHl+kLW5267z6PusrCAXe3vPGyUZA+u/EkMJJLXzrKOkQhUjFvt6K5mfA
	iK4BVIRu9wW1j7gpl5ie80FT/iyey11xzPvwUyfVXzVMzSf4PAE3z6Tk5SFm9C5QbxveLkqq8QC
	8qquDeQaDrzmadkpM4i7h+lZdvikgwt7dRmuHnHIspqNefT9CTky36sa8RlX+oCAvtm2fGs5xxs
	8oIlnY5LX/jR81RGIug4gBYFk7x9+2fRYG3s6lFAc/8gzg8tVXwfmhLjNa1F5p/EI+6G9
X-Google-Smtp-Source: AGHT+IHt6aPFR2Bw0HlJGSa/mOk3c8+BRcWZQsYV0g4OgyGhD3tGZLbn6be+rsoLdw/XIZZFhDjoag==
X-Received: by 2002:a05:620a:2541:b0:7e6:3030:e480 with SMTP id af79cd13be357-7e6963a6eedmr1890516185a.57.1754408933141;
        Tue, 05 Aug 2025 08:48:53 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e8040a9154sm214850385a.70.2025.08.05.08.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 08:48:52 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1ujJuF-00000001Ydr-4AIQ;
	Tue, 05 Aug 2025 12:48:52 -0300
Date: Tue, 5 Aug 2025 12:48:51 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 10/38] iommufd/vdevice: Add TSM map ioctl
Message-ID: <20250805154851.GT26511@ziepe.ca>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-11-aneesh.kumar@kernel.org>
 <20250728141701.GC26511@ziepe.ca>
 <bfac9ab6-9115-44d5-90c8-e22c3dbdb607@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfac9ab6-9115-44d5-90c8-e22c3dbdb607@amd.com>

On Mon, Aug 04, 2025 at 08:02:23AM +0530, Alexey Kardashevskiy wrote:
> I ended up exporting the guestmemfd's kvm_gmem_get_folio() for gfn->pfn and its fd a bit differently in iommufd - "no extra referencing":
> https://github.com/AMDESE/linux-kvm/commit/f1ebd358327f026f413f8d3d64d46decfd6ab7f6

This patch needs to explain how the lifecylce works and why the IOMMU
can't UAF the memory. I think it cannot really work as shown without
more things like an invalidation callback.

IOW you need to define for how long the return result of
guest_memfd_get_pfn() is valid for.

> > I was kind of thinking it would be nice to have a guestmemfd mode that
> > was "pinned", meaning the memory is allocated and remains almost
> > always mapped into the TSM's page tables automatically. VFIO using
> > guests would set things this way.
> 
> Yeah while doing the above, I was wondering if I want to pass the fd
> type when DMA-mapping from an fd or "detect" it as I do in the above
> commit or have some iommufd_fdmap_ops in this fd saying "(no)
> pinning needed" (or make this a flag of IOMMU_IOAS_MAP_FILE).

It should be autodetected.

Since this is unique behavior for guestmemfd it is fine to start
there..

> btw in the AMD case, here it does not matter as much if it is
> private or shared, I map everything and let RMP and the VM deal with
> the permissions. Thanks,

I think ARM would like to do this as well.

Hence my suggestion that guestmemfd could just have unchanging 1G PFNs
and all shared/private changes have no impact on iommufd.

If so likely all this needs is an invalidation callback from
guestmemfd to iommufd to revoke on ftruncate.

Jason

