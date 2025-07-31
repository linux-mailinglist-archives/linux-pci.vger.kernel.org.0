Return-Path: <linux-pci+bounces-33250-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BDFB1754D
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 18:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99F6B3B7FD3
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 16:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6547025BF00;
	Thu, 31 Jul 2025 16:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Zs9UvslR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832E4262FD0
	for <linux-pci@vger.kernel.org>; Thu, 31 Jul 2025 16:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753980785; cv=none; b=N2ubcYE515kP0paTTIvciRkc3udt/Jsstm/H312z1OCej/7AYJeDk4GyScFTtFqHxZsLHS3RsaBS/hcEtUUnHTSkDlrHCCSZRvQpT5ymHqjzhlA2kRYAtAGkR5Sr0wD1W/aBrdneUD1nAq6XVC+P5mC1/KfLIyt/Ty2QXpnMP/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753980785; c=relaxed/simple;
	bh=pZ8JW4BupERaCqn+7ehMHUhgMaXIyZtrBvv8TKORWvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+twxJi6RN7dH16Wi820uOy3FCyp0SKd8oTRL0dW3efXY03dbcnKFJT5WSiFBHwGUZraZ6J/0hmZZ4/2v77+z/ET+po8dRLUa6T0Xagcldh7SZ9Aq9YEqbGbnEzucAY9H54QkgrEIB+C33wqvfrbhitCJ1WIEkMc/DtnRT7RXSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Zs9UvslR; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7e62773cab8so126816885a.1
        for <linux-pci@vger.kernel.org>; Thu, 31 Jul 2025 09:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1753980782; x=1754585582; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ge8sFkdUD5dsmHZi6nhZDTs93Pw2wZ3dkBFapdPEw0U=;
        b=Zs9UvslRTgz6E55v8B7c2Jadpo09wvghL4NqoXx9WmGhULRAJntAGfFZiCo3SoyNge
         BbuWQbgthZ59HyrQMZJ5TXr7/zsovLi8hlsIeDy+ERKJrpOydsNIgfnCLBEqggKhGAWc
         V7F9yzToWc4KjSTgotmjRO+W/lGqOs55jSyk5OLkhJTsVH97PUAaXhTy3jH+iZHiH1Kn
         liYvCM2TDHmZToa04HFTyLrWTWPhkvhQC1j38+4lgcyL9+Xg1ISCG3nM5SNE8Z+0tHbL
         +5+Uq2/is0dmDULstCDnfW/Ce9oINBLnEfM2J2FdEbA35xe2rF3CX92GkA41lFHQpOPE
         If2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753980782; x=1754585582;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ge8sFkdUD5dsmHZi6nhZDTs93Pw2wZ3dkBFapdPEw0U=;
        b=WLQVvJ7WkrKSxROkZuf9h2bmTUop9vilenOHOFpc4buYbQb9i0A3hVS0HwvkFsQMzG
         bh/u0G35vJ4bSqfvDYM5V5CyMqWIiSEViMfVHMPABhJyr8fyL7fEc57mt5YSG6gaWV5w
         rkp0c5vGkkqafU/Dbiu/2f6jsmUG/jYlIP/psLkHV2JHO8iWFwPiAfXg3EDd0681HkoI
         3MEZrovEvfEQIReRmrmkiX63OfUbSIDGjGUyR4wWtPQqQPd6ObszSGn22mw+nRQeTvCV
         IBrvSJtdGpaw8T0fNBAcGEYWosNs2A03YJZzBR035LKLPfcdlFJSwclxoQLf0uCHNcMG
         70sA==
X-Forwarded-Encrypted: i=1; AJvYcCWUr5tc+tgnWE/DszPUrAfiJ0nojh+uJ0KA/GUL3x0snry5HafQAEvkZh/ftzLBRzAQmPtW/pmoye4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx7ox0IQRzB5k9Bk9ir/44oH/v+qsjZ4rxePviGHQrFua38685
	0F2IMlhoPbE1padr7pEesMScu2PysWItsp+89qE7yqQgryO9dsSUbLzliOclrpJClrc=
X-Gm-Gg: ASbGncvNf4aWw7vQ23q4ekWl9MeFgeU7/CompNV33aMONaQAUKaRzomZbmZrEQJJHXg
	ArUNO4A0+BBZ21N8kv/pCS+UQZ1dyZCPgL8YXdBjmycrPUvP3OjIpf5VPKw4R1LOWtr2KaB3g2X
	wktvZKGxmsuGL4ypS7I4LJKpUHNvLFgNzZl2npC4rqJDsH6v/aiGuu4dvMiioV433mozPqh1iau
	B9pVC3jk6K6pW84ih+ngcBHw8FUbiEvzV9C0RvXEBXpIAzmVU25SS2CN6PcbaLmTgnie/1eagex
	54BXhwdZ+kEc68i9XF35o0AxMq21Ykr9jhBhdzkmLtfuj/BWbxJgbewAZYN8G8qDoYeVc1vn2nV
	JV543wVCcaOBESNjdMwwBbi57ZdkgfFhod7+PVI63Bf/xb30ylG98Oh9i8nAOECFLWVEW+8uUkK
	ox54Q=
X-Google-Smtp-Source: AGHT+IFxkpl6QnLP1d2Hal87IlMNzkW4ERQZ01Eb9frEOc1Kw3im7nXPwCw8k1/LtI/6s3msgQWswQ==
X-Received: by 2002:a05:620a:2808:b0:7e3:4b7c:40a0 with SMTP id af79cd13be357-7e66f3e29c2mr1060489785a.51.1753980782245;
        Thu, 31 Jul 2025 09:53:02 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e67f5c5537sm108625985a.35.2025.07.31.09.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 09:53:01 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uhWWb-00000000qDo-1Gf4;
	Thu, 31 Jul 2025 13:53:01 -0300
Date: Thu, 31 Jul 2025 13:53:01 -0300
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
Message-ID: <20250731165301.GY26511@ziepe.ca>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-35-aneesh.kumar@kernel.org>
 <d57d12ce-78c6-4381-80eb-03e9e94f9903@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d57d12ce-78c6-4381-80eb-03e9e94f9903@nvidia.com>

On Thu, Jul 31, 2025 at 02:39:09PM +0300, Arto Merilainen wrote:
> On 28.7.2025 16.52, Aneesh Kumar K.V (Arm) wrote:
> 
> > +	for (int i = 0; i < interface_report->mmio_range_count; i++, mmio_range++) {
> > +
> > +		/*FIXME!! units in 4K size*/
> > +		range_id = FIELD_GET(TSM_INTF_REPORT_MMIO_RANGE_ID, mmio_range->range_attributes);
> > +
> > +		/* no secure interrupts */
> > +		if (msix_tbl_bar != -1 && range_id == msix_tbl_bar) {
> > +			pr_info("Skipping misx table\n");
> > +			continue;
> > +		}
> > +
> > +		if (msix_pba_bar != -1 && range_id == msix_pba_bar) {
> > +			pr_info("Skipping misx pba\n");
> > +			continue;
> > +		}
> > +
> 
> 
> MSI-X and PBA can be placed to a BAR that has other registers as well. While
> the PCIe specification recommends BAR-level isolation for MSI-X structures,
> it is not mandated.

Right, there are not enough BARs in most devices to give MSI its own
BAR.

>  It is enough to have sufficient isolation within the
> BAR. Therefore, skipping the MSI-X and PBA BARs altogether may leave
> registers unintentionally mapped via unprotected IPA when they
> should have been mapped via protected IPA.

Right, this sounds bad.

> Instead of skipping the whole BAR, would it make sense to determine
> where the MSI-X related regions reside, and skip validation only from these
> regions?

IMHO this is a mess. The virtualization must end up putting a shared
page(s) covering the MSI space in the middle of the MMIO region.

I think this should be done by fragmenting the layout in the IPA where
the private MMIO is within the protected IPA space with an unmapped
hole covering the MSIX registers. The acceptance process should
validate this.

The MSIX registers would then be located in the shared IPA space.

A normal driver mmaping it's BAR will then crash if it tries to access
the MSIX registers. This is good, we want to catch these non-secure
configurations and block them.

The MSI code will have to know to compute the shared IPA alias and use
that.

Jason

