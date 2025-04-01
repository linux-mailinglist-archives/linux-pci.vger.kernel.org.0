Return-Path: <linux-pci+bounces-25087-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9BBA77FC6
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 18:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 008FA7A2D06
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 16:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B78D205ADA;
	Tue,  1 Apr 2025 16:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="VAWPmv2v"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEC91FC0F3
	for <linux-pci@vger.kernel.org>; Tue,  1 Apr 2025 16:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743523425; cv=none; b=aZQ5HaTqYgdOMixU6zF5IRv5hCxwrmDP/beCxx86Cg6dyfFaS7v9ySPCIgmhxWXG4bEMaf4c4OooTirjCfxJLEqqfkPO5yyYfpa7YQlZgvDZgU/U/s3rPxtDg408Mtpal8dDROmjSD8u3txvIuN/107D0FNpuy4A2xy6rnaolik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743523425; c=relaxed/simple;
	bh=xnUsRAnCTM6iow/f/UCejEdDYoiWEl5F6w3kOCDrBoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cFt/JWTEJrqCLR9eXwqAklRaNQzo37WsWPGfBwNuv7gBemRuLmHK/gCtVUltCeUA2XMB639ESvrSTk206+b0s5xSwSlY+EA2qIVRbYlXxTET3unutR2F6DfLPBsS+Q5ECdZifwcLAC97VYqlVXt7nTAzn97ZVhwgfTmkk0ryPh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=VAWPmv2v; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c55500cf80so453392685a.1
        for <linux-pci@vger.kernel.org>; Tue, 01 Apr 2025 09:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1743523422; x=1744128222; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HUIWAEN6Qyb8+Hz58OV+4wJouq5dad93BnZ8Do0foZI=;
        b=VAWPmv2vgdrgIZYQ+IyU5bPlsVeKFD8gZ1OyyuWhpXZg+GVLGzCoZV+rpDPC9KYwsj
         eG8Hkgj+vKSC4Efpo6oLrgBcs06tFYEYGMYoGFzyiVCyuYJAZzloRsYqtWUFAVRoiu5p
         UvBkkCsBPfX2zfz0UdP+0+h/GaNkbPSupRBY3gFWf1/dnmVx28rTHPb9+l4KcuKiyxab
         s5amtKNg8muf/FpVkWwJifWQa4cpZybl1Z6l/mZih1fZ8eX2h5O/le7dfsytwOl3IVBN
         Zl4WI5kg/nStRH9f9pPMlPtUiLi6IhA5iuHYC+49a3UlL/gervngmrw2l00kT77FmqYP
         MbeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743523422; x=1744128222;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUIWAEN6Qyb8+Hz58OV+4wJouq5dad93BnZ8Do0foZI=;
        b=cvnZpUgiKqkPW4UvOe7z4+7INEe6HCSBfoenv6/d/t66gmvV/b/+Ju3cLW/5aqVg8V
         TrvNMlj+uOKOVIsuk/MyLSEfrsnuCnpBO9qHut+Dk43hn9NeqQlwjCkzR68Lm5odrxk6
         wXGBUVD3rZo1fDC5X/Jl3J3DP2Iv1hvji4wDPdEOshvBzAZVKoH/RLZPYrs5+Ru/hXOa
         bVs5PZ3gy4iokTRFUolML5H1TW/EIwA54bRrN11o0IgdGJ0f/RPywomwRcwK3H376RDK
         IWGrOwco5sF0acGkAY8imf0HJrx1P9xOeFQkp7B/vwLxZm8W6b4+TlW+5noBM2mSfMw7
         nSvg==
X-Forwarded-Encrypted: i=1; AJvYcCXsqyYIkLdoFPcq4blgvo5QqrDvg/WsFXSLFxBRqvPP94iKJn9qwi9epqeM3ncW2Ecc9XUfiCCNLKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbPS+b3MZx/4uWitTTEfO8AcI2HoJa2X6NViiZAlGB4IrTod97
	RN3DH76LN/NSe6sqAM36x7AmQ7y++H2/SOBCzWhf7riyWZ370XLB7Xxb6AvqujU=
X-Gm-Gg: ASbGncvEnNZpLlQJKpG30NNQb6JA9WbIRXMYyVjGpJZLqfAt5YBliZxxM9C9l5KjUh5
	itrhuwMBQBQB5RInxGmHDfQl/M9o/3O/jsv8QdUoZjqMksketN2WZ3WIlDac99PKW1jlarRN/WW
	fxQHFrcaoHYugtFRKblxjLKCq7tFD04NcKBke25+25hr9BWGGuMMqP3uI/mOs8l4plIgb3sK/9b
	UyDnwXQS66tadCxFcmB0yY4QycxtiwPd5Ej1TVXIXWRxmCH1M34GKl2swyTXkzVzpTVjCMDoga6
	83fg8Yc075fKyueBktnEylKvDqZhg+vMNyoTIL8g/I2DaA1xoOrlkEYaAz8+mt1N9e/lDT8rdY6
	3jV8CyNvlrssh1ejEUfEILUGQ4JjWdnDyvQ==
X-Google-Smtp-Source: AGHT+IEK38CnaMLkGKnp6wFhyTba4uVPU2YkYY6SqmlutfADek1SIeamjKZM91laT+FptTnOqcHgWw==
X-Received: by 2002:a05:620a:2551:b0:7c5:6045:beb7 with SMTP id af79cd13be357-7c69072c8b5mr2068616685a.32.1743523422038;
        Tue, 01 Apr 2025 09:03:42 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5f77802c0sm673482385a.104.2025.04.01.09.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 09:03:41 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tze5U-00000001MIe-3oUm;
	Tue, 01 Apr 2025 13:03:40 -0300
Date: Tue, 1 Apr 2025 13:03:40 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>, x86@kernel.org, kvm@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org, Sean Christopherson <seanjc@google.com>,
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
	Zhi Wang <zhiw@nvidia.com>, AXu Yilun <yilun.xu@linux.intel.com>
Subject: Re: [RFC PATCH v2 14/22] iommufd: Add TIO calls
Message-ID: <20250401160340.GK186258@ziepe.ca>
References: <20250218111017.491719-1-aik@amd.com>
 <20250218111017.491719-15-aik@amd.com>
 <yq5av7rt7mix.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5av7rt7mix.fsf@kernel.org>

On Fri, Mar 28, 2025 at 10:57:18AM +0530, Aneesh Kumar K.V wrote:
> > +int iommufd_vdevice_tsm_bind_ioctl(struct iommufd_ucmd *ucmd)
> > +{
> > +	struct iommu_vdevice_tsm_bind *cmd = ucmd->cmd;
> > +	struct iommufd_viommu *viommu;
> > +	struct iommufd_vdevice *vdev;
> > +	struct iommufd_device *idev;
> > +	struct tsm_tdi *tdi;
> > +	int rc = 0;
> > +
> > +	viommu = iommufd_get_viommu(ucmd, cmd->viommu_id);
> > +	if (IS_ERR(viommu))
> > +		return PTR_ERR(viommu);
> >
> 
> Would this require an IOMMU_HWPT_ALLOC_NEST_PARENT page table
> allocation?

Probably. That flag is what forces a S2 page table.

> How would this work in cases where there's no need to set up Stage 1
> IOMMU tables?

Either attach the raw HWPT of the IOMMU_HWPT_ALLOC_NEST_PARENT or:

> Alternatively, should we allocate an IOMMU_HWPT_ALLOC_NEST_PARENT with a
> Stage 1 disabled translation config? (In the ARM case, this could mean
> marking STE entries as Stage 1 bypass and Stage 2 translate.)

For arm you mean IOMMU_HWPT_DATA_ARM_SMMUV3.. But yes, this can work
too and is mandatory if you want the various viommu linked features to
work.

> Also, if a particular setup doesn't require creating IOMMU
> entries because the entire guest RAM is identity-mapped in the IOMMU, do
> we still need to make tsm_tdi_bind use this abstraction in iommufd?

Even if the viommu will not be exposed to the guest I'm expecting that
iommufd will have a viommu object, just not use various features. We
are using viommu as the handle for the KVM, vmid and other things that
are likely important here.

Jason

