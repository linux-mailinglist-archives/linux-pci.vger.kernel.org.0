Return-Path: <linux-pci+bounces-33297-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0A1B1843F
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 16:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D600170447
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 14:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CCD26CE2B;
	Fri,  1 Aug 2025 14:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Dn/Y37Ho"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158E826E6E3
	for <linux-pci@vger.kernel.org>; Fri,  1 Aug 2025 14:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754059989; cv=none; b=Nt673wj29zUYl9qjD9WIL48vJ0iKvMP0rn3rdHBuLXyEHbFrmFv7kTbKabdXTbErDvwFq/mJcc/8aul+xiE04OZqii4xJdWwYL5FTh3ZCrXVk/jadzuwg73D+Yl4R35Tac0B3Ww6dm9dw6JHEWE/hJE20YJLNVR4Tp9c70986rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754059989; c=relaxed/simple;
	bh=9z8sFr7OTh7x/5XSMissRsaGqrEIK0lYaVRNZPtOZxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bo0Ho0SKzceN9SkDoTieBVTDnyd144XHgCEI1GPokBXwjT/3bYfqJIsnypA4uD08uBa3NfrZvg8h7LSEPe24gzH8lvfMrJf/AONWYuxdQhBdVRomzAbrtOtC5SKaNyu66O4xiUlQMFQOf+FtttjIkmkzJAPf2eaYvBCnsyjRAUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Dn/Y37Ho; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-7072ed7094aso8873586d6.1
        for <linux-pci@vger.kernel.org>; Fri, 01 Aug 2025 07:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1754059987; x=1754664787; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MNtgboVqwh20Ney7adiU0cV/UXdxsSM54P/Vl6XgEls=;
        b=Dn/Y37HoXSu62uJZVaZ+ppaylMB6lTopRZEXRk18f90m24VjgevhGZI6Z+7AhsfL/g
         /GbRF7TDfxqRFwLfh+xlyEscv5PRdiw8fyIk4nh/h9O7i4/Ex0J7a9L4o6IZ+wlCoFCo
         7GxeyvQZkI8/69FakaX5W1ABs9vkb0X8h/n3MraINGqoDb3EV/o8zERIZ1nOOIKqJCS+
         vpDCL0yKic5QJTf6/eMWQb1fVEiwYJI4K/Xfo5+dlePqlXT7lEyUe5uDtozUAGIM6HWF
         PkXXfiSavwQsCimTDyMNXXsGgZpO//FOdaRKQEOiwkCjCtIRaKY4QAa5KeLx7vTURS0x
         trYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754059987; x=1754664787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNtgboVqwh20Ney7adiU0cV/UXdxsSM54P/Vl6XgEls=;
        b=TDqsMaK1FNhUcPqKBjEOBtr6LaAnVDfrpHOmUdLdoIUxxtNKPTl0731RxE+jAoMNc8
         fBlVZQXFhbKxDPOoOl28kayN+MFXb61pWtAh4ldnZwCiKs6SGqAn4gtvB8UL6P+lO06v
         dhWz3KjztmCp59+dqumPBS9dxI9OCfhO25Cnnv/8qFucwKv+eoN2Se3pFnTOBBxZUsDW
         jNRYIdd6Bq6OAGcwWINHCkkcNyz9PcnOXG+md4ryhf3c9YlbzsAciQLCqt3o0iAr2Xu/
         qe9IxejCZIB3iEeEh+7vhbdyx6Rb1df+xAFgq6AJULzcjACjcBfQ3ZqYBGy8zsW7VrjK
         yoAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKlWwAqySpguF1uqdtuJN8MZzpgmanEZsPzfZzR/GiKLZwdD/CxB4L4uJQUIIjEXh8UoU/S7JHbSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMnyt4RTabcemssqNgzac6rAbZQgLGNvhhWTJHYSRF+k5YW7/P
	jYyyIBsNoMRazUTNX8sbzg5kz9Kze1B497M6AL/+8a69asksVYTjqCtB2I1gGRuHvlA=
X-Gm-Gg: ASbGncuSosKzHJb2LeQBpDhQ0mJuR2oppyEqmVIJ/nBUACXSe3kfDakkvvWqD4kKiZD
	mnVKSCl01UNSD2sAAbBjxT/AO2khkGJNgnalBS2X6mMebvHocGwBiOuRHwOaPJm6YcQL8JtU/IV
	iWfslmm0tj7/ddYFu4yUJmF9k8FZTuHVZskXjSNTPsPZcjrQYZzMu9NXwQsCoCgNU3Aklc9YYj0
	aNAk6G795dXuhPr2o/8pgR9C0/WYFMpKjdjV3S2r6hmrKFqKFS4xKzSZbmJkQiizDmAo1Hwk1hI
	L7iD097qyxJoPbfI4za0oQ3iOme3AaSM6CWRUPHgc4nM6/+l1cHynDDeLxSx1yZfYSkldS3hOVs
	Oq8ZCBj+jJoNMURmVN/OUdm+6RWTIClacu+bBrpb/3dYuXS8PBw0ELp1vfg8WV/2udz0D
X-Google-Smtp-Source: AGHT+IFhLzfh/tN6NcfbFOiHT6YBGOLWjYR19Ez0qlLrCLeR+IMa26shu3X/pz9tHfJr845QNLQ7TA==
X-Received: by 2002:a05:6214:495:b0:707:56dc:178d with SMTP id 6a1803df08f44-70767185894mr176316596d6.37.1754059986819;
        Fri, 01 Aug 2025 07:53:06 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077c9dfbbfsm22005316d6.13.2025.08.01.07.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 07:53:06 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uhr85-000000012WJ-2mLW;
	Fri, 01 Aug 2025 11:53:05 -0300
Date: Fri, 1 Aug 2025 11:53:05 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	aik@amd.com, lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 04/38] tsm: Support DMA Allocation from private
 memory
Message-ID: <20250801145305.GB26511@ziepe.ca>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-5-aneesh.kumar@kernel.org>
 <20250728143318.GD26511@ziepe.ca>
 <yq5a5xfbbe35.fsf@kernel.org>
 <20250729143339.GH26511@ziepe.ca>
 <bbe2a41a-8f72-4224-a0bc-225c1e35a180@arm.com>
 <20250731121740.GQ26511@ziepe.ca>
 <1388fb70-3d2d-4c41-9526-521cb75eb422@arm.com>
 <20250731164420.GW26511@ziepe.ca>
 <791e259b-3a57-487d-81ca-9d83f83ad685@arm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <791e259b-3a57-487d-81ca-9d83f83ad685@arm.com>

On Fri, Aug 01, 2025 at 10:30:35AM +0100, Suzuki K Poulose wrote:
> > Is there a reason not to just dump that into the T=0 SMMU using 1G
> > huge pages and never touch it again? The GPT provides protection?
> 
> That is possible, once we get guest_memfd mmap support merged upstream.
> GPT does provide protection. The only caveat is, does the guest_memfd
> support this at all ? i.e., shared->private transitions with a shared
> mapping in place (Though this is in SMMU only, not the Host CPU
> pagetables)

I don't know, we haven't got to the guestmemfd/IOMMU integration yet,
which is why I ask the questions.

I think AMD and ARM would both be interested in guestmemfd <-> iommu
working this way, at least.

> I think we can go ahead with VMM pre-populating the entire DRAM
> and keeping it pinned for DA. Rather than doing this from the
> vfio kernel, it could be done by the VMM as it has better knowledge
> of the populated contents and map the rest as "unmeasured" 0s.

Yes, if done it should be done by the VMM and run through
guestmemfd/kvm however that is agreed to.

Jason

