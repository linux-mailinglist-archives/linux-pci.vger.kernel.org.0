Return-Path: <linux-pci+bounces-35810-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA3CB51926
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 16:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ED431883C33
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 14:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7251684A4;
	Wed, 10 Sep 2025 14:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="grNxo9uf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650DA202C5D
	for <linux-pci@vger.kernel.org>; Wed, 10 Sep 2025 14:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757514075; cv=none; b=VRWGh7qOpoC/loAC7h6ZzQ71KuyswISJGQ0//l9mVjgw3U0P0fZGxuEOBW8yOvDvdzXkrta7KZigjfWKqaRUntDl31HLIt0Ygvpadt6LHfu1feTR/s952Q/s1BWtwWXMkZwpMvmmnSjDCLNmAawMM+wNiy9f4hLaU5DAjpYgLqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757514075; c=relaxed/simple;
	bh=LNKhKhA6C3nXEhiScX2h3yeOP0cYoVecRbWOHC2eAUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VyYZxlPrpJSFKC2rqDNS0dqxd0dJFO8xUughoHn5iIwZ0fjD+iDCrtCdqSK+41OUrdACywIVrYH2qTIICaLDEJOFuF2buys2+A28c+h0poBo11P37QEP4ECsL/xKOrbg01lUDCxQGg2sONsXdbfoq0raE/1n+DbgaugiebDJiyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=grNxo9uf; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b5f3e06ba9so8790831cf.1
        for <linux-pci@vger.kernel.org>; Wed, 10 Sep 2025 07:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1757514072; x=1758118872; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LNKhKhA6C3nXEhiScX2h3yeOP0cYoVecRbWOHC2eAUU=;
        b=grNxo9ufehAhRM21/3rKfugBp1loIxWsplX3mJwKGeH/6mXW1Pb/F5wW/uQIlZKUsS
         dm7/pp9eo7XEMslQyRdNb/H0r5Mlade3+0EIh60jIjtvvGOp1rc6Rdtv53MtAhCuPBRL
         E/5jjvn51wwQc69OyTjGcbDboAHiDpJXowFLiGaVYs1Lqvq8+7faFUy6qxQULUj8jtOI
         yAJr0UdHfS1qPBzCV3kw+tGue8MP/zQ4btnveecyWACi57qfyx1LrzbC042t5jlhbDjS
         dZaiiqkZbAy10GDaKv2z23Zqp+ugiqJDuLRmMmwKidQRwPMj3Oi0opM+ivGpONnBToGU
         XpSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757514072; x=1758118872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LNKhKhA6C3nXEhiScX2h3yeOP0cYoVecRbWOHC2eAUU=;
        b=UOJpQgcc80p958ihElqucDj81rgOcwdonbNbP6p3UnFY7teaYoOEiLY/COmnytD0j2
         kWptFnogltE4cHJv1ALLEom0KRiR7mMr+3NW9I46voFCxkmWM7/uKCT7lBYyJiJOEM+p
         wcD9KjcALoCk9Ve45tknM9w0sa0vPGdG/3/mCJ5dj3j9XPxHlW6ZR1RAiyoRrJM+BiZf
         L0uQB/xnD2JFrADuGrUDtCZJsBIROwqfrB+sQ+NXTgsKM5UzPgtmAQpZ0MTbwhafflO6
         zLx2XcK1ggSDUG3KJAFkY4qqkl4i0hnHW9EuQF3YpIPLs8UfYUqLaTnTzOFPjmMzoNdV
         jpdA==
X-Forwarded-Encrypted: i=1; AJvYcCUgianWZ39tvQZ+54Hz0jIg85lF5X4gdu7Qbvk3u9TRb8WSE+Q5vQ38ixiPVgaGc/dpjU3OJiiqbu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPlIz59LkT9x0rcgb8ppAofz/dP3cYSRHFd0kaQdw43Pm5sJQi
	Mfz0BPCob3Y4/VzDjqpFkVj99iNjbYiWpdFDRuSBAbgKgqXby+Q1jl9JuPxGogkVkxvAAhwBnhz
	l4kwC
X-Gm-Gg: ASbGncs7OUo4hG1+Wvyl4v1SGqI5TfY59JH/oB6gdiUf7G4FCQvcJF9SmmTnnwuUJA3
	BG2jl+27tpAuLVLpAXHDGQL8ASOOMIcmgqHApmdbeRDwCeQPOc5T8nnjYRXN7gH70kquyZEKV0M
	dcHY2GoIUsySgrCH8lBl+OSPrYwC9LPo6+bMxFqkiTPMurXQmrcKZZqesjrYWJl1gKP5WyJbec1
	OSbU2XwgFsNqiuu1eB14Bi8utXz2SGuPhYi4Z+vt2tUT3w+r+/UE+QCZIW/9uW/amluzCI5Rs72
	jqoaMuxwSA+uw6tQxFZ9vqWM4Lsq+OwEuw5mZGDrcpXZJpRMH8AqiLeyDdT4mEFn3C3EZNCXv0p
	0p+zUR9Hs90TTkocBsj/6E569BJpnvjXw7Gc13w6ZjIibFGa/gsoaM/HUhGWvqxFosCA1
X-Google-Smtp-Source: AGHT+IFQUqXdlLFuZHw73Bg4VN3PcnM2gIuoqeeTT9gq8x5We6/aliAOx3fJNb9QKgrD/fgUoao2tw==
X-Received: by 2002:a05:620a:4054:b0:7f2:8bef:93c8 with SMTP id af79cd13be357-813c443dcbdmr1375146585a.40.1757514072083;
        Wed, 10 Sep 2025 07:21:12 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-81b5ed732f1sm299020385a.49.2025.09.10.07.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 07:21:11 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uwLh8-00000003roy-2q61;
	Wed, 10 Sep 2025 11:21:10 -0300
Date: Wed, 10 Sep 2025 11:21:10 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Arto Merilainen <amerilainen@nvidia.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	aik@amd.com, lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>, kvmarm@lists.linux.dev,
	linux-coco@lists.linux.dev
Subject: Re: [RFC PATCH v1 34/38] coco: guest: arm64: Validate mmio range
 found in the interface report
Message-ID: <20250910142110.GE882933@ziepe.ca>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-35-aneesh.kumar@kernel.org>
 <d57d12ce-78c6-4381-80eb-03e9e94f9903@nvidia.com>
 <c3291a06-1154-4c89-a77b-73e2a3ef61ee@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3291a06-1154-4c89-a77b-73e2a3ef61ee@nvidia.com>

On Wed, Sep 10, 2025 at 08:47:43AM +0300, Arto Merilainen wrote:
> This creates a tricky problem given that RSI_VDEV_VALIDATE_MAPPING requires
> both the ipa_base and pa_base which should correspond to the same location.
> In above scenario, the PA of the first range would correspond to the BAR
> base whereas the second range would correspond to a location residing after
> the MSI-X table.

This seems like a defect in the RSI_VDEV_VALIDATE_MAPPING - it should
be able to consume the same format of data that the tdisp report emits
to validate it.

From a kernel side we also should be careful that the driver isn't
tricked into mapping MMIO that is not secure when it should
be. Presumably all the default io access functions should demand
secure memory in T=1 mode, and special ones like the MSI-X code would
have some special version to accept either?

Jason

