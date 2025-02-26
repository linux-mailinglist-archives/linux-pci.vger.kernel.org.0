Return-Path: <linux-pci+bounces-22438-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C36E2A4603A
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 14:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEB733A843C
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 13:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631EB207640;
	Wed, 26 Feb 2025 13:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="T/QbiIKv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57C52CAB
	for <linux-pci@vger.kernel.org>; Wed, 26 Feb 2025 13:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740575288; cv=none; b=u4Tf1OYal4LD3n+YiIuocD+yRV5c+AjtZshde4Iz9LDYi1tcneKDcUQcKkhoC2D9MZJe5aHG4Nq3JV451ul0p/sgVov18WdiZi910yWNgFDSjk8f0tSYF9V6XaIhbp3QoWUPPO4nYsrB73WkVRnTgd+uGTuIucaQZ8nQcQ+ZpdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740575288; c=relaxed/simple;
	bh=gZlf2V4DZl06PCel9kKPigzKNxKnfgpO2YLnb7fz6Tg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mgLrExG4RD7ZeWH3HZ4cQoAraeHGTNgDXw1pSMqb6EvkObw0viDx6HOw2WETfmqNaJGkiPD1z+kdXEG3GH+p0iJLgbUefebGjoCtnBW9n9gYG3TS3rPdsSp6iIO8d432CzkRDP18mGsAWZxodCdhfDDCZgiQldgRw2Ofj3tpwYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=T/QbiIKv; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c0a4b030f2so873261185a.0
        for <linux-pci@vger.kernel.org>; Wed, 26 Feb 2025 05:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1740575285; x=1741180085; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9ECSFx2fiYRGYbPUPOKEj5uQjkNpa71sMCoCExCmYew=;
        b=T/QbiIKvtcqcqQSWAzZogMWpsvqW+MI/HTEr2rnGR+RwQZ9gmuTns4FjikIKYrcMze
         4FJMlwQCBDA+2A++4l1iyFsZYKWksJ55MgCltjETpB4KXpMP2UB+UUdUr4JoNrxVpNt/
         ELA1o4PGTsQmKZgR77zNp8cVXLbpRGexH2ALUw/bkZ+arvQw+JoETdEeUG2bLQ/wIITc
         fiLAcA65IEtHSJ/NA0jKRPWwTHgQyPhNVJ9V1BZTXxvoMn2S6pN4DaauGRgO8LlqJGVm
         a77QBoeHa0ihVuzWgR0h+w8mUy7w83ixeRqFPZaVUu8Oe4/BkxuzBv2ZajAEDbYKcmzo
         OBUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740575285; x=1741180085;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ECSFx2fiYRGYbPUPOKEj5uQjkNpa71sMCoCExCmYew=;
        b=AvoCpDlyYuFb7HZPbeG6a/wUtjRcYriht/mAubDbOAwsb0x8QqWtgeJQBC+S3fFB+U
         QDrgUkh6U7MisaUHxgEFTfFnZLHP7+XIQjz9siBCNiGTcoOAUvX7L6iSQeCt2c8hf911
         5O8/ny2dOcpmBTcGHrTQZ1O1RydJ8OaEg9B4kNSI0ZN3EBA6TAA6KuNhCqy1f8NfGH6w
         9RnlzdyaD1X3hzSIGM4GV/BDvTCk6vcMGD1Vek4kWKC/O6leFnknqUsT23T0mUg3J7Dg
         s+ReWz8jpG0fXA4YUmy21zoBHXms9evgzoHsag5EtSyA0y6kzHSAJXEpzdrHQt4KNkdA
         5dFg==
X-Forwarded-Encrypted: i=1; AJvYcCV6AZeu0pghZiVW8bHbPHYitFuxONMqEN1keIeZ5UIP2YwP6XbAAdxI/fZpZ2D/ycwvjEhTplXw1Rc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdkUV/jFFvYm9Du9Wj9ZU9jSHO9vxaMdb6XJU94ogTqZG23JKK
	pL4XFw7HOi7+/t9prXn+sDQ06z//Hk4ujkEFk9wQUZCzt6AxyQkygkIAzHu3bLY=
X-Gm-Gg: ASbGncv77rCz7CmtzUf/oRdfsnSmHcAK2MBFSPGM85NgrIcywKC2c7HXO+40BOPjb3g
	7ELUan5pV2QhATZC0wXtvfDrSNbj9cBm6tqsIIjfDAfMsPd3B1PGtERELsy68E5qUMXLYN96noQ
	5DG9xSUx7dZ/CYwuWMDRN0jvVra/VDbNMDAIbtzo7Gl+r0yOy3AA6XDz4CrLoMcEt/T9W6UYKvC
	+KbZV33nfVRfSub6YOr1VHA2c1rlyCFlBzyKVylZMclpLgvV1lFIbX1NVRASP7vx2P+1eOvtjhp
	OT2tzrSRmTwTrBdi+9pNpIT/Jjr0jKepsKRsm5U7agDu1ZR09mSCgllBZTu4ZuzrX8jnj+tf8qc
	=
X-Google-Smtp-Source: AGHT+IHSaPI2di23wd/r7DmUcJvEuSIfSDJiLalxe/seFWwJNz69RZ6l150d7LgWyVVQcH9URorRQA==
X-Received: by 2002:a05:620a:44c1:b0:7c0:c650:e243 with SMTP id af79cd13be357-7c0cf8ea459mr3058987685a.30.1740575285615;
        Wed, 26 Feb 2025 05:08:05 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c23c2c0fb4sm237968885a.56.2025.02.26.05.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 05:08:04 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tnH8u-000000007Mk-0RRT;
	Wed, 26 Feb 2025 09:08:04 -0400
Date: Wed, 26 Feb 2025 09:08:04 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: Xu Yilun <yilun.xu@linux.intel.com>, x86@kernel.org,
	kvm@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
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
	Zhi Wang <zhiw@nvidia.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>
Subject: Re: [RFC PATCH v2 14/22] iommufd: Add TIO calls
Message-ID: <20250226130804.GG5011@ziepe.ca>
References: <20250218111017.491719-1-aik@amd.com>
 <20250218111017.491719-15-aik@amd.com>
 <Z72GmixR6NkzXAl7@yilunxu-OptiPlex-7050>
 <2fe6b3c6-3eed-424d-87f0-34c4e7e1c906@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fe6b3c6-3eed-424d-87f0-34c4e7e1c906@amd.com>

On Wed, Feb 26, 2025 at 11:12:32AM +1100, Alexey Kardashevskiy wrote:
> > I still have concern about the vdevice interface for bind. Bind put the
> > device to LOCKED state, so is more of a device configuration rather
> > than an iommu configuration. So seems more reasonable put the API in VFIO?
> 
> IOMMUFD means pretty much VFIO (in the same way "VFIO means KVM" as 95+% of
> VFIO users use it from KVM, although VFIO works fine without KVM) so not
> much difference where to put this API and can be done either way. VFIO is
> reasonable, the immediate problem is that IOMMUFD's vIOMMU knows the guest
> BDFn (well, for AMD) and VFIO PCI does not.

I would re-enforce what I said before, VFIO & iommufd alone should be
able to operate a TDISP device and get device encrpytion without
requiring KVM.

It makes sense that if the secure firmware object handles (like the
viommu, vdevice, vBDF) are accessed through iommufd then iommufd will
relay operations against those handles.

Jason

