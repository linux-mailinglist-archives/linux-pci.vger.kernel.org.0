Return-Path: <linux-pci+bounces-33072-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF757B13CBC
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 16:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 274A8163EC6
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 14:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B4F265CDD;
	Mon, 28 Jul 2025 14:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="cJqGHCgS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9B41A5B8B
	for <linux-pci@vger.kernel.org>; Mon, 28 Jul 2025 14:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753711726; cv=none; b=UdRpyJkb0c9LpCesw/wUyTzxQYDIKIOHrL1W7woHHXi8QsvPeSrOEVYGmVmWaGJC6AEMXFkEtPJ7NZFTy3xOFiCgGyH5DQfKMKNd0WG3vVVrZH+9YGXA8Jh6ceHTzNHW0YjiGvJfG+Ex7AcT0pppv9CN3oZvubLv+cq4X+eBES0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753711726; c=relaxed/simple;
	bh=4kahnbCUUVK18hvpSBxURKB9raQB46M0iQ5FOKtQghE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q+hniWOQ2rWLAI8Hm06w77eHX6tICqyztl6+bcrx57Cg5d2t7cg3J66PDURWhKv7FeZlxfX69D+5VSzgLQVAoG9EPVEaTBChFDRKwCWRsc7MKOKb4HRfeIToXijdn+jHACFikHDvRriAVC9dO6Rl5q9o7dYatJPd6H4x1qKc5eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=cJqGHCgS; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ab814c4f2dso82771791cf.1
        for <linux-pci@vger.kernel.org>; Mon, 28 Jul 2025 07:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1753711723; x=1754316523; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4kahnbCUUVK18hvpSBxURKB9raQB46M0iQ5FOKtQghE=;
        b=cJqGHCgSRbn6dMh3wcmSonKnTJI91EXt7JAH+J7k1MxjwaoDIz4wMTWJbk1DbodHGF
         5hRUpKISh4MeZhLmDOXndC2wHKnIWOGoLZNwzS1m6CEWcr639wWaBCrwuOm1u1PyU763
         B91qjf4TijsRMp16gJTq3GzUnGhnxSeToAUEzU/dRHwYFyp67e/F45IiBVxS1wSskIu6
         HrEizMDt9zvMDBxGt1ZKrkg1vjbBCN+ZJzrBmc47hcFFlbYPXpGx5aqd3uTAo2ICPV6J
         mPALCbFS1ywzQGhgt5hi8v2yOYiC3Y2eTWVSo4z2xIrWme3Z71Mvi8614tb3IwVslSad
         yTSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753711723; x=1754316523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4kahnbCUUVK18hvpSBxURKB9raQB46M0iQ5FOKtQghE=;
        b=Z2oeHpqeJsZY2IZSPMg91yGDKr7Jum0Eg2HYZMzvyknEeEO4bo/A+qGCgipEK0lv58
         Jc+96f+Y4L43ZXdWevV4y1iB9t8J/7SFlNrxyPxnSPCRkj/x6yu3aaHgPmqRbacWg5RJ
         1/40UYY5SS5xANcH90mkMxPfYxQA33AVetfcGwbWvVKSioxDwF8QQKJNgjxmRhsEsiUP
         zZGwnhLtFhapc9A/3L30fRNljruKUDcQEbLww8r3BVXsJDR/hxM4/UwWYz+UsXJ5zg9H
         ezbWhtigvQVBPe/A96FDi3Wmci4vsH28STU4/f/WoLDioc+R6qt1jnKN5R4MbGMMiPXl
         NXXA==
X-Forwarded-Encrypted: i=1; AJvYcCVq/fouigHi16Zn1jNl2IsI8bOhxU+O+IAIHnj7eh501IBiQrwuxJfSPu0KancvmntdbZ9/Q5ZUReY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw63W3q9HukMdREyKtf2x5Y5D3tBKkGpHW27XBzEueQZSrA7IV8
	3yiCCjzBa7UUJHuR7aNJz2yI/QsddllcXdTUwyNk7n3r8hkhBaPeWaf5YUv4iSyEhdw=
X-Gm-Gg: ASbGncv9EGrWcK/Ah/wYi7Xj95Zgdi4cJHLq0A6ojhsGl3i2djIu8PolSvy0ZHnuoRQ
	mHyyCh28toKli3MSJMwxGiXu2EVoIcBdxj0EeXVdhH8kTaOLSMHnHBrDOLkw2MZ93shzzehLLJd
	i6+iGjYIliIk4fw+l4JsThR21dsUTkms6Fi5rMjRn/AMnJJQ7gEo+eewdl+5W/Gx1s8kwst9Ijz
	RU+ldts5XDXeVMYuXWO3DglfDzaznub8+kc3kK1PWI5weCjTltF+FJTW9FI7AFPJm+dfGrjhAJV
	pd+8wXstRA29ZRfkXjL2L8IAvK76SGTiR9MtNvWwJS0NLyWvBeghIiDMRNWPNRvfsKu1lwWGuR0
	whaeBxMwxZ1yynwwqGf/YWwTr9GmB8f+OCqY1G0JVcz7sHBbkECyw8Z2b28qyiYRwo2HH
X-Google-Smtp-Source: AGHT+IGXQH54g+OEuDAZ//VEsPFOF0VZ1eCHZSsCk3KsPn6dRKNeXLVClWZB7Vwu63ig1wAqfFoyFQ==
X-Received: by 2002:a05:6214:929:b0:707:4509:b6c1 with SMTP id 6a1803df08f44-7074509b794mr50900796d6.11.1753711722526;
        Mon, 28 Jul 2025 07:08:42 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70729c70979sm30626156d6.86.2025.07.28.07.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 07:08:41 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1ugOWv-00000000APv-1G4L;
	Mon, 28 Jul 2025 11:08:41 -0300
Date: Mon, 28 Jul 2025 11:08:41 -0300
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
Subject: Re: [RFC PATCH v1 06/38] iommufd: Add and option to request for bar
 mapping with IORESOURCE_EXCLUSIVE
Message-ID: <20250728140841.GA26511@ziepe.ca>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-7-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728135216.48084-7-aneesh.kumar@kernel.org>

On Mon, Jul 28, 2025 at 07:21:43PM +0530, Aneesh Kumar K.V (Arm) wrote:
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

Why would we need this?

I can sort of understand why Intel would need it due to their issues
with MCE, but ARM shouldn't care either way, should it?

But also why is it an iommufd option? That doesn't seem right..

Jason

