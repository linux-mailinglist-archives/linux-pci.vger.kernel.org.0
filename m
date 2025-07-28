Return-Path: <linux-pci+bounces-33074-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8701B13CC8
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 16:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90C537AA023
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 14:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED9026CE3E;
	Mon, 28 Jul 2025 14:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="cL6oxSQ1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673F126E149
	for <linux-pci@vger.kernel.org>; Mon, 28 Jul 2025 14:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753712226; cv=none; b=nLtixs5mNKWTb3xCF6ZfGYeZ20WkGdZBQRsiA3ldCPNua89YjKAnxezCNCZE4SJtPt4g7QBkGVS2inV29I03LSq9MqkVTETgDPgOz7vkeCB8a3rEmtl4U2r9Na7cToPTFVM0CfSF2fGvENF/YKpIKVFtQoEr97YbTb2v9AVkj90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753712226; c=relaxed/simple;
	bh=+sQ9t0gn5L4GrZDYwNd4uW4hApI7Q8x2B8KZ36bnLW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lqFtcpH6K+H/SRQ+fVeqRfBSk/MCHsfqKkgcNPi676A3WYtiB5dv1Tcau4rAhkQCDhdoxdLtwR8ZkJzMYZ8NA+sWFLDATSmgRvbVSHhmP6DKpzMNGw7EJG8ywdelUaK5F8Zj6LlPCV/jA5+JS2F/H2oj4AvS/pVg513OuCSvO/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=cL6oxSQ1; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4ab5e2ae630so56261181cf.3
        for <linux-pci@vger.kernel.org>; Mon, 28 Jul 2025 07:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1753712223; x=1754317023; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+sQ9t0gn5L4GrZDYwNd4uW4hApI7Q8x2B8KZ36bnLW8=;
        b=cL6oxSQ1t5M7yyjEyaWjV5UluyYz8UMb+Ee4Qwnc1mp66J1AJVVkXz5ln/RePsbsqp
         s6CKiA32rQlfVpiYxbJouXIBX3Nw02LLiy+FTnYX1povSoBu/o58YSGMYVh/cioK+eVl
         x69oeEg3T9askYPiqTf7S1RyUj+bN25GPgpzD5E9H53CDk50uE6Qtb7M8qGo59aKJxmj
         0s8qtLznK7/QOddMrfV3YuayKhahQoHqIqQ/1VjvQPcfp0up/zuFE8d5Wqc5pb6ozco4
         NU7CbMDVt/c2NQnveC9UEt+aPf7hA/m6QHTFNpduWHmZdwabYqML1lLPsGBWuiK5RKs7
         ajUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753712223; x=1754317023;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+sQ9t0gn5L4GrZDYwNd4uW4hApI7Q8x2B8KZ36bnLW8=;
        b=eYIRXDBkK7q9LKt9lLPaLNtv3wOsI6A50pyXsFGRCMUZCcWpT37GcYrLgec+Vu0ejf
         /rPhcm0KDxOQnp7r0vhVEzeKnbyHIBI49utFjHviyOSSyVUabbJkk4i3qH/A2IUERItW
         wf41pteICEG8GefbHAmRSAnLg7Yr333FXHvj1NZbiHI2xnQWdBJOTeMIO1zEux4XQhjC
         g8E64BzxZ7oSTKDfxS1cm9ovxfRtCZbSChnZh7eTHxjlUtcMskTSqY1K9ZXatDZLlzIm
         +RB2Pb1dpCNPOcvLMcylqiJK0yKo0LgM6ocQFBNgMuQ8DUEoT12CSiUPwMKGiWa7Sp4d
         AiZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkChBIB9awzKSebrIfK+3XPHM6vOxorf6OUHSKyhB6PSVXPhmj16sdgwR85b4+VLvYMhe+Y8qTuiU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIxLenhzEOCwHx610ncFJ62YP+LENmlkwg/h3w6Kgm1GJSAHSb
	pooBccrG9XwdYWJezq2QBG8VcsXjj5upvjkQ7IFsqFv/+ipK+pmQDSm5N/AVb6hviaHy3aOmm7p
	ISF72
X-Gm-Gg: ASbGncuz6Yb1D/PncGIB90kwRRuSypRqFSwPVQnzArX529AulCEd/pRq4c8/ad1b8+7
	d8K+oLO5CWeZ7Lg2cQcOgEo+hLc+YDm7SL/9Q+F9KmBdD5cErzOTbKM709InlNsunpkZBPensrr
	8YhxkL7AIVMjjHtd1kEJDJGhSPplTfKead3VKLHcKGoz42yRRK34jFu8vBELrDq/jyZVPEPRw+G
	t0pBttRTjN/DiahphbjAkFNGFUcE1sC7o5FWrEkGrjDZeVNwK56JJSAB1lLM0qZthvsU0NnkCvQ
	z0knFYZCXvpXK2ZBQCWOg6UUnx0H/gjY9o8Rxdf9zNV95hypfWI4D2zcGUa0wxgjezoQzR1Mfan
	XFVuLFg95LO1gK6TxD3mViUNiSY6+RCy1ewbfaQBH+D5vjahoHYWkz2iaFCz4Cm4VZsjc
X-Google-Smtp-Source: AGHT+IGJsSVbXjLNIqrlIEbk/gUzNYQYHSbjL32ASxGtiy6zgoFXF/rrvq7tro5LsCceIcXyRKliEg==
X-Received: by 2002:a05:622a:1104:b0:4a3:fcc7:c72e with SMTP id d75a77b69052e-4ae8ef5c18emr158029941cf.9.1753712222972;
        Mon, 28 Jul 2025 07:17:02 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ae99516fcesm35769401cf.9.2025.07.28.07.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 07:17:02 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1ugOez-00000000ATD-3mT3;
	Mon, 28 Jul 2025 11:17:01 -0300
Date: Mon, 28 Jul 2025 11:17:01 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	aik@amd.com, lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 10/38] iommufd/vdevice: Add TSM map ioctl
Message-ID: <20250728141701.GC26511@ziepe.ca>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-11-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728135216.48084-11-aneesh.kumar@kernel.org>

On Mon, Jul 28, 2025 at 07:21:47PM +0530, Aneesh Kumar K.V (Arm) wrote:
> With passthrough devices, we need to make sure private memory is
> allocated and assigned to the secure guest before we can issue the DMA.
> For ARM RMM, we only need to map and the secure SMMU management is
> internal to RMM. For shared IPA, vfio/iommufd DMA MAP/UNMAP interface
> does the equivalent

I'm not really sure what this is about? It is about getting KVM to pin
all the memory and commit it to the RMM so it can be used for DMA?

But it looks really strange to have an iommufd ioctl that just calls a
KVM function. Feeling this should be a KVM function, or a guestmfd
behavior??

I was kind of thinking it would be nice to have a guestmemfd mode that
was "pinned", meaning the memory is allocated and remains almost
always mapped into the TSM's page tables automatically. VFIO using
guests would set things this way.

Jason

