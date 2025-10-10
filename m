Return-Path: <linux-pci+bounces-37818-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45DF0BCDCE6
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 17:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31F293A5373
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 15:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AE22F99AE;
	Fri, 10 Oct 2025 15:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="DXAUFiAa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A6023FC66
	for <linux-pci@vger.kernel.org>; Fri, 10 Oct 2025 15:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760110256; cv=none; b=dc0oif7+eRWW5m9rUy4kVe1RXQGNdNY4Md2IOpBJLHp9H9d1wjrAnGpdtLJ2AH0hxs9Rht8V7ePRX3eABhzZEtnMMHBkfZLwo3hfsI0XZ/9CM/lDatB/nJpNA8jbUwQ89IgepZVh+BmJ1rmfbWFeewy9xZDjNG1GxaUcPd1lbQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760110256; c=relaxed/simple;
	bh=YweDjybfnRXAUjAFM2cXyTvz7RwWQP0buSdnlIEIdyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u0Ld4wm6pKDDOsLZTIQDdpJjzAII9YVywrCv01R7P4uM4O2dP0cxD45upRVTMD+tX90MeH6AfqsNZgPRqXLHGPlVsoDEe3H2ONfsj5YupstKaHFrYILIE533UrxfT12XHZhb8fUVUzJh4xNuN5ApaKHmdGiaRkt3ys9K1JKEX/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=DXAUFiAa; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-70ba7aa131fso24146466d6.2
        for <linux-pci@vger.kernel.org>; Fri, 10 Oct 2025 08:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1760110253; x=1760715053; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e6cOfIK7qdN8qKLRMhM71lR4Nf+xbZ2+eVm4l2+34ic=;
        b=DXAUFiAaDqqCC3+EGPzuTEpjDPpj8TDL6f7/wTX64ElUquDD3fp/hbRxJWl8zAES+j
         +dnCNkHQplC9wAAKmgxpSmQbvK1W3l0d6pcCSq++3xLlrDG3xBD0z+MBSs7B+lPfBr2e
         l1b26laUQRZIYyja9N804pvrD3shemyxPsUCsgTZ6G32QXpa0OSVge6fW51lGfultT96
         IrSsZkYxbnA14n6CqWaAaRM6YSev8Doda2pH6/bEjAM/CKYqaRvpd0Omt9vmbYOd+IjR
         4oE077WohG5cUdFp9gg+ElT6orI4tDRIR5hbzTcsty2mXYEkqL4+4CE5NdzzT1IdtUeW
         KmxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760110253; x=1760715053;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e6cOfIK7qdN8qKLRMhM71lR4Nf+xbZ2+eVm4l2+34ic=;
        b=ZpwKEdEKlGE50ByUCd38Asq3d3M8ifDxwc94Cab3qqXOivHWj/D9SgrvLWjweR1LSk
         8eUiemoomqennMOGInlDo4sKHxjwfa8zN7CR5dLADlUOZMujnBTKJjeuPzgFFllEC0R4
         KmLaCrtJMPL+o/1TR/VlqULPEt+u+4ylR4SsLH07+ZSutsYz7ECrIedxfE/PnAXPHMlN
         w8tlOf2yVpRpr/h5N0cA4RgiUHSNyHimfKPJsaVzZX7s/eGP3pBkIlniXzTUkLR43o/g
         rujJO5VCwaJxJQZVUqEfuDg3pw0PbVt9+O6Y4VFANBgJEBIPRz3Euinmw4rX/ePymu/B
         q6+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWCZ2JgbExXNYMDlpmWt/B6OR2DyWzLkIV9oOVHjCb552C8RMbTsUxucp64kgbq56Og4rHHm91CXII=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjo55aLvYA9NkeIlfPFz2qGMmjS3kG+CaB32Mm11nwIbw1pslQ
	L3ZxvjI/cmiAKBjE+PhYacdOnG5Qg91yEyT7Mk/nitrT5pnDSSNTMBmfKN1LSx9A3to=
X-Gm-Gg: ASbGncu+tUvgdsKya1Egl+gSK8XMtlk7IJnDuw2nkHfqaWqPBxgDe2yl9pL72cSsiRC
	YcCFoE0DXHBvd0nytHjz5bNC1PNLxI1CvKONWRvKUpJm5HMco25qTm4nbEKAbMiQ/vh8CMzD5vZ
	g4UlXlxW1mb5VEkYlrSgFsRT7JpMxMUm0IDLwexx+uK+IJBrDtgrnAR5BDo5V1Gat3RqXJE9i5B
	vzABUlXUJqX7tiiTTVxCPt9cAUCRtJ7p1it4A2feuqmv29tdDuMzrJVuaKbHSYliTPxMn7fdjtU
	apbk/IcWYaXt107D+F09yIjA/xyp6uxL5xsJcPl+ifNT5kjuruWYBuF3pboYImOF29678lJIHp0
	CoY+uujp5T1sSfxq9rcBRZBnWpnGR4vVOFhaDY45XT13/H3+I16xY4kLTp3EmbjHuMfB35vb34d
	5WOntlnTOxPgc=
X-Google-Smtp-Source: AGHT+IGgKhRm3oNF4ALMXNjdHTaNK2zfI9rzl46bTecy6J4CNJ6lSFvDvqcPlarS77J3/CcjSy9rWQ==
X-Received: by 2002:a05:6214:c64:b0:830:5c6d:419 with SMTP id 6a1803df08f44-87b210728c4mr182061246d6.4.1760110247638;
        Fri, 10 Oct 2025 08:30:47 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87bc3570c1esm18187826d6.40.2025.10.10.08.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 08:30:47 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v7F4w-0000000GWAu-2XWh;
	Fri, 10 Oct 2025 12:30:46 -0300
Date: Fri, 10 Oct 2025 12:30:46 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	kvmarm@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, aik@amd.com, lukas@wunner.de,
	Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 11/38] KVM: arm64: CCA: register host tsm platform
 device
Message-ID: <20251010153046.GF3833649@ziepe.ca>
References: <20250728135216.48084-12-aneesh.kumar@kernel.org>
 <20250729181045.0000100b@huawei.com>
 <20250729231948.GJ26511@ziepe.ca>
 <yq5aqzxy9ij1.fsf@kernel.org>
 <20250730113827.000032b8@huawei.com>
 <20250730132333.00006fbf@huawei.com>
 <2025073035-bulginess-rematch-b92e@gregkh>
 <b3ec55da-822a-4098-b030-4d76825f358e@arm.com>
 <20251010135922.GC3833649@ziepe.ca>
 <4a7d84b2-2ec4-4773-a2d5-7b63d5c683cf@arm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a7d84b2-2ec4-4773-a2d5-7b63d5c683cf@arm.com>

On Fri, Oct 10, 2025 at 10:28:36AM -0500, Jeremy Linton wrote:

> > So you could use auxiliary_device, you'd consider SMC itself to be the
> > shared HW block and all the auxiliary drivers are per-subsystem
> > aspects of that shared SMC interface. It is not a terrible fit for
> > what it was intended for at least.
> 
> Turns out that changing any of this, will at the moment break systemd's
> confidential vm detection, because they wanted the earliest indicator the
> guest was capable and that turned out to be this platform device.

Having systemd detect a software created platform device sounds
compltely crazy, don't do that. Make a proper sysfs uapi for such a
general idea please.

Jason

