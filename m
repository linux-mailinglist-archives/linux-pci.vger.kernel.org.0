Return-Path: <linux-pci+bounces-21519-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 178DAA3665C
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 20:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ED25170D8E
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 19:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0627B1BEF81;
	Fri, 14 Feb 2025 19:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CBiZTzg5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAAC1C84A4
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 19:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739562227; cv=none; b=fApwHXafQ253f0V9byq3iX9T6NLjOlVm0mEAIB1aIs6GezlxQAzoixTwtKvsjAg7UHLGia8YkC29IrZNzomFP2yxT1dwdJn+mnQLVOGg/+Dm4+DuZNLbQyQD10OiaEANzxEjt3CnTR2D2QSz+t8SLipchxhC4eerSLj0VVp4cRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739562227; c=relaxed/simple;
	bh=mhtKeLm5igpgwc6h4fPK4Ajh2FAgScw0xgMCQuun79I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QAZvBKPYvccgyKm3TWuRJkkishisnlmperpfniTikP9wmulzKU0v1i5Z5p7SGLZS5Yzw1++zS4uwvHvADkL5m3jzkpPNNidy8Q6NJ6n+kPzDIg1gY6WWYTgOXN9Ij6Zs9FyWx+iVQB/UG8uQ1qV52gg5lbBhPDS4fOdWYanhyWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=CBiZTzg5; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6e65baef2edso19181406d6.2
        for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 11:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1739562225; x=1740167025; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=buGqXK8/ktUg8RW6l4BfFP62BuolnXWk213EnIe2HCM=;
        b=CBiZTzg5GKUOw30Ap+23iwklRbL66ng3YJfyVAdbawwpmTWgdMIVLSVudrkXbT2t9V
         AUNxZ6oaa6IzKAB5vUxlxm/7vEqHJWCy2Z0VrXyHmFjjVBkWpBzV+zWhACj1MpwPkXA3
         82Iyu6YO6cYWOVlRR+wOTg2ANTejluywnZ6c6ly2SIxoC1iPmrOG33RXHNyC/5d4grN5
         IZfJyLOLwWmbYIx3a+sbuUHeap0fvSkNFiobslWF3O4UqkWFEnu0h7WNB6bK73kwulxg
         wVvuSIuoC/KoiQP2KbroP5G7Wn5huqOwGqIwc6BqTsKG/T7qDrB5+BIP04WmameauOUM
         Lirw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739562225; x=1740167025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=buGqXK8/ktUg8RW6l4BfFP62BuolnXWk213EnIe2HCM=;
        b=s7xCMV8/cBWqfIK9BxZWQ3Cw31ofXKSxhGr2xKdCtxhQxjjdBHc0TtTG+geQ/ZIFgF
         euA3CmqGpclieQYsLZ7bd4AtUESnO69CGHO/sX375jXorUNA5Gig23Bzeo5JSulrHNeZ
         0V65abuO41sGgUeC01eHKj/sEBd8FvcVjh87U78yG66eBScOfo4VdRqp/sUo0oidrxpk
         qMHg1bsYMlc/OIRisZWPUQ23NjZ7v05lh7MVZa568VxDhNBycDS3gY9tApxg/dpScL5u
         k7P82tgTdb4ZwgOzlR/rE5Y72A8KsgPrx9VbxvBe+HfStu8szJzOzdHbOYlRWt/abyEa
         iNdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVnki3tfYS8/Jc9vhmiQ3RmXbFpcmRg3+NmAculhkoN0RHRJTQabUJJDlBp9fuAOxDoN4O0APbpdI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQEySWPZ/Trqquc5ERU6vokEvmIRT1q9Scxw9gWwQjKD3WWt3b
	iibc6uQDAXGEjFxZT4p0Jgzh8I2FdSJK9QC8dp97bojJR05Ef8cfcClSj0UYD+I=
X-Gm-Gg: ASbGnctt8OcZoDhCvq+ppcp5K3SNYMLfarPpCAm530bHU2p7RKdNwJ1V+m1mYGSgaxF
	l5aHY29YKfnOiWXORvW89mlpeICHRI+7n01QVaKh75WAxlRfcUln9Bgumk635x6AwgwZXojUs7k
	3w2A89PZ+8BtVZ+2jo88G332ATibEyJxIguKyaRLsMOylNFSez5El7HXtPRzSW6o5MEsCVWOILO
	fb/lFTW39JQb9+cceef1vsBphWEoknUJZK8oFoRVnvD0+9zcpsRSCQ60XLNdY8cvN+RF5H6QsVw
	kazT3OVpyXSeMbHB72a/sAsM1C/7h+Z7L805wmlm6F/ivJ/ozzt054UEVBna/9Cz
X-Google-Smtp-Source: AGHT+IFaSyYcyF+Ryh1E4s3MGomseXTapLkA1HeMxX8nrM5eJsPF5uZrRKBhBqh/ftWJjIpaJugHyQ==
X-Received: by 2002:ad4:5d6f:0:b0:6e4:4331:aae6 with SMTP id 6a1803df08f44-6e66cf38b4bmr7577546d6.39.1739562224840;
        Fri, 14 Feb 2025 11:43:44 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d7a439esm24231236d6.67.2025.02.14.11.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 11:43:44 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tj1bD-0000000GmVK-3Ena;
	Fri, 14 Feb 2025 15:43:43 -0400
Date: Fri, 14 Feb 2025 15:43:43 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Stuart Yoder <stuyoder@gmail.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Charan Teja Kalla <quic_charante@quicinc.com>
Subject: Re: [PATCH 1/2] iommu: Handle race with default domain setup
Message-ID: <20250214194343.GE3696814@ziepe.ca>
References: <cover.1739486121.git.robin.murphy@arm.com>
 <87bd187fa98a025c9665747fbfe757a8bf249c18.1739486121.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bd187fa98a025c9665747fbfe757a8bf249c18.1739486121.git.robin.murphy@arm.com>

On Thu, Feb 13, 2025 at 11:48:59PM +0000, Robin Murphy wrote:
> It turns out that deferred default domain creation leaves a subtle
> race window during iommu_device_register() wherein a client driver may
> asynchronously probe in parallel and get as far as performing DMA API
> operations with dma-direct, only to be switched to iommu-dma underfoot
> once the default domain attachment finally happens, with obviously
> disastrous consequences. Even the wonky of_iommu_configure() path is at
> risk, since iommu_fwspec_init() will no longer defer client probe as the
> instance ops are (necessarily) already registered, and the "replay"
> iommu_probe_device() call can see dev->iommu_group already set and so
> think there's nothing to do either.
> 
> Fortunately we already have the right tool in the right place in the
> form of iommu_device_use_default_domain(), which just needs to ensure
> that said default domain is actually ready to *be* used. Deferring the
> client probe shouldn't have too much impact, given that this only
> happens while the IOMMU driver is probing, and thus due to kick the
> deferred probe list again once it finishes.
> 
> Reported-by: Charan Teja Kalla <quic_charante@quicinc.com>
> Fixes: 98ac73f99bc4 ("iommu: Require a default_domain for all iommu drivers")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/iommu.c | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

