Return-Path: <linux-pci+bounces-35912-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCFEB53424
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 15:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1A205A5289
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 13:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B77341AA3;
	Thu, 11 Sep 2025 13:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="knPWJyWP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936B0341661
	for <linux-pci@vger.kernel.org>; Thu, 11 Sep 2025 13:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757598073; cv=none; b=YNqOz+VbFr5AoUDALm3kNGtzahGq864n1U1bEIUfuHsHZE1bfzPfCjd8+FmZZSGj/l86c4iUHbbHWefI7oq7ptgOD0BDvPHHYcp+AxOAzKdXDpecBhzYk8f5hI1767c4ctwCZaBorPxsGHBy6+pVz9CA0GVPuBsohALot5gOi9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757598073; c=relaxed/simple;
	bh=eLNCihb73AkP7eUzkZCYHE7Hj0pppLXFYhZ9Vl1IUQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RHb8Nn1dlh3zYxkSjex+Q7OsLM1G2GbmcaiXZCnDb3nM0a4SIyoaGFSiYIYxkeGPwtp1mR3VXNn75ZXFNyk61b+gpqvIu8M4FcIH1+0EJLtfT8LtyO6OJ7GpESlqGbmec6y8qz8RXimuCZQ59vPdUdEn8f1RVUTSd+JRCm0YTOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=knPWJyWP; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4b5fb2f7295so7370521cf.1
        for <linux-pci@vger.kernel.org>; Thu, 11 Sep 2025 06:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1757598070; x=1758202870; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b9qmtOM7dk27TAU4OyKZ0knJ4KFcYKzonTZZzmEGOvc=;
        b=knPWJyWPr0WFntWs6KShTFUbzrHAFhZbbSVbKcX8R6/tHIj8xdWJmAiN0Ow2pK4omx
         aZVX0Crvad5169nekNpnqzU9q0ccOWjzLPRpXSA6vdUdtZ/FC/DguEvKdD2l7WaJ72Nx
         x1mS1ay5rFmU7kBnllh4JRVRowGnBo+SELguVgZxHx+O1mUbzk5rStsMLcADVEcKMAkl
         97h3ryGzVSvwvHdde/OAdmg73dHI0fVN0aQ85/AahAI4ioBnii+oTckyphjDVjiv3eWF
         2+P+Hj0YyS54wYWpcrpXMwW68vobI6Jc5eZM0Pa7USJEn/WEG+/j99PUG+oka9JAOz1y
         zIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757598070; x=1758202870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b9qmtOM7dk27TAU4OyKZ0knJ4KFcYKzonTZZzmEGOvc=;
        b=W7swSUcRRtOA5vhbdv8XQYRY4GWGBZoxVQceT2Y4JFc01MrTM2NSmRjj1hbMI+YOgz
         Er1+flKbCCJ9TkEuZ4k0J0roEhhTCuNrzlIM++Kg7A1FnpgKDyp5+xbQk5T3HfHB968f
         MvLSB2NKQnXiMN4+okGmZcobpi+R8dAVFMgywWsbV1+GCIZjkr84iTF9/kRpAoBsWJ7G
         7tMKhiBFQrBHJllI7GNn/3+J+p3CpuoTtQi8xX0Uh0s+M/k5FIuv+7l9H5Yie2SSrN1G
         blOGnYihdYJ25KNc8EfxFiKdYgfZD3UTzP6XLkoWY759uRM/AHSs1vFtBmwSQUVXTmbR
         KehQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8mH0xXEm+Y+oBtfFWggNq+GoPEyXkXhuabg6q3s+fAFGnU0L9Xis+Sl4tnxAMEguBO6MrKVNxJjE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2FZh7pIw849vIuRdPPwPr35Km9EC1qNbdzAYrDfro1tDSGz1Q
	1gUZPlFv9+LNebA6idvP/+wMT9/6GL1UVS8XtEjBaDdiSdcTtZyiMZmYG0xwqDClZDc=
X-Gm-Gg: ASbGncttfqDDod9aUhxfP68JHJHTow5zHZiDXJhwMJTP9WFMiSWa9geIVogHPHmpqCS
	yTWku70sSYsSE8s71GC696dUSVIbGNGz3+iK023zkw6nhMryHD2FrhmrR3D874bleTqlGVunnO6
	exhiQHWct3qZkJAxzGl22/dBwjc0CEqPgz9zqot/dOOy71Phm8esFjDSgBHXdI+A6D0cjZVCoUu
	dRAox5Q4iw+fFNg3wFXVSpKiLwbaE9BJOy2qO43JDTsxlAurG85r3f71962VGKsQl/VUd8aMCFD
	GTIlVnmfmzTTeiLW4f4AIkiag33BuCldGG4XGsH0sLAY9WL1NGxeWHSyInHRBuVtKeksGrX7h4k
	QiK/WDxRUnfH3EkxAxfhh+RDfx8JP+fG0bprPim2DSxirTWnlwiTsDd4GrNxMe0jfgjzIBw7SYG
	aGLYw=
X-Google-Smtp-Source: AGHT+IG5BULuh1Ix3dTKx0dMR7o7+0XiARxVmRkjj0WGgmMyJMRjiHF7nh7Zr7cWchr7UEHaWH/u8g==
X-Received: by 2002:a05:622a:1214:b0:4b5:d932:15c6 with SMTP id d75a77b69052e-4b5f847fd1emr220313931cf.34.1757598070182;
        Thu, 11 Sep 2025 06:41:10 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-820cd703f54sm102730285a.37.2025.09.11.06.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 06:41:08 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uwhXv-00000003zwM-3lhP;
	Thu, 11 Sep 2025 10:41:07 -0300
Date: Thu, 11 Sep 2025 10:41:07 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Arto Merilainen <amerilainen@nvidia.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, aik@amd.com, lukas@wunner.de,
	Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>, kvmarm@lists.linux.dev,
	linux-coco@lists.linux.dev
Subject: Re: [RFC PATCH v1 34/38] coco: guest: arm64: Validate mmio range
 found in the interface report
Message-ID: <20250911134107.GG882933@ziepe.ca>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-35-aneesh.kumar@kernel.org>
 <d57d12ce-78c6-4381-80eb-03e9e94f9903@nvidia.com>
 <c3291a06-1154-4c89-a77b-73e2a3ef61ee@nvidia.com>
 <yq5ay0ql364h.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5ay0ql364h.fsf@kernel.org>

On Thu, Sep 11, 2025 at 11:03:50AM +0530, Aneesh Kumar K.V wrote:

> But we need to validate the interface report before accepting the device,
> and the device driver is only loaded after the device has been accepted.

+1

This must work from the generic OS code.

So I'd say add a new TSM op:
 int validate_pci_bar_range(struct pci_dev *pdev,
                            unsigned int bar_index, u64 tdisp_pa,
			    u64 size,phys_addr_t *bar_offset_out);

TSM has broadly two options to compute bar_offset_out:

1) Require the TDISP MMIO Offset is aligned to the BAR size and use
   something like:

    *bar_offset_out = (tdisp_pa) % pci_resource_len(pdev, bar_index);
    ipa = pci_resource_start(pdev, bar_index) + *bar_offset_out;
    if (size + *bar_offset_out > pci_resource_len(pdev, bar_index))
        return -EINVAL;
    tsm_call_to_validate(pdev, ipa, pa, size)

2) Require the TSM to convert the offest'd PA to the IPA:

    tsm_call_to_convert(pdev, pa, size, &ipa);

    if (ipa < pci_resource_start(pdev, bar_index) ||
        ipa >= pci_resource_end(pdev, bar_index) ||
        (ipa + size) > pci_resource_end(pdev, bar_index))
	return -EINVAL;

    *bar_offset_out = ipa -  pci_resource_start(pdev, bar_index);

Then the generic code builds a map of what parts of the BAR are secure
and what are not.

If it can't do either the TSM is unusable by Linux.

Jason

