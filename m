Return-Path: <linux-pci+bounces-33117-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E7CB14F37
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 16:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00A7A189CEF0
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 14:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32A21D88D7;
	Tue, 29 Jul 2025 14:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jwPlEigt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149161C5D57
	for <linux-pci@vger.kernel.org>; Tue, 29 Jul 2025 14:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753799361; cv=none; b=fnikaFdGM51MUiqiFchia9/urFwfFnD85FsAA4xditp5cU3jYPpT9AzecIWkY5k+bFuooC4jK37etsFUBHLUchiIpuWn9JeHJwQvSdbX8L+2flA9pQ/H+wawnSdv7R9Bz+QxyQkFvvJdID3gjvhas2F1vTOLNhi6Bb7ajWGFcgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753799361; c=relaxed/simple;
	bh=xOGcPk1h5mkQlFHPfT4qZPTUZq5yx18xGEjyCFHAQpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CvcyNoCb/pW1Ho3EgoQ/PB6FNxqWmwMm3JbNw5tDcniujmHwdHVxJCxW3tvlBlLPhrP6NHAQVl+nIh/ei5dQuqOc5o9WmFJmaC52q0X4lagAdMuHuHucDV+NTvKEexeFQljXgmsYhbMVgufCwMzkh/zB2sdgFbkeemd1sR+lDOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=jwPlEigt; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7e346ab52e9so713502885a.2
        for <linux-pci@vger.kernel.org>; Tue, 29 Jul 2025 07:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1753799359; x=1754404159; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Qz67H2QziopzvIbpAdOwNF/pBaaQ95fyoFVZsRKl+KE=;
        b=jwPlEigt//r2d3gQdsBkbsY+yHq0n3yoJfUccwhFYje9huE5DTUDak7lolZPef31E6
         dYrLaaNGzFtk1opOKFbUb5rUWJe4F/dJzjy3ltOp3/u8T68di154kyqZMsopWYxQbtHT
         /g3ablFTd6tCDlQy9bI9+uZodFTy6oWdB9jE28SRQpDHpjEqYez9jpg07OZX4VNPqV1U
         6T3r17JaW7WJphJuNzj+Kfo4oVm+aHZTo/YY1wVPTLMUoH7JDjm9wj50OT0I9akf9/yW
         KPwaY7+Z6CKrD2lCMUbtfFbaq/Xib6EyQYLvCrA2Mj8nqIyIIurQboTY5Icz+QmqUjby
         UruA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753799359; x=1754404159;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qz67H2QziopzvIbpAdOwNF/pBaaQ95fyoFVZsRKl+KE=;
        b=hEnZXQAK5eR6PC9q6excW5kBv87jCtTBJZkg1lsFlG4SiGW0aONJTVCAvA5cEy9NAl
         HOc8+dgZpsSbk4P20EvWzGp0G9YqS5IPnIds03tOn4bMJNEsRIvz++BGcQLNoJy5171o
         kfOZib226BCWYVdDiUsJ+ELr4TT1lxOn25a0RXRNQ3Rb+vFrZ3rFtk2rL9w9eADuABwh
         N0GIoaJrU5igGIM0GbtP9UK7GLNehUbTPdfRqT71EOGDVIHcf6vVmoNvN2z3HBboUNlS
         sk2gud3sczpE05d878KVaXZk3Teke4tvHSdBYS7xY4X5Bjh6CR70LhdXrD74vIIKcb1o
         BdNg==
X-Forwarded-Encrypted: i=1; AJvYcCXeoYQAbSczk4iiz5iJpUJ+kQX+dGAgvTQgnP43tGc6LGtnO0NE6Thffj6y2ImMRMKbixeDNVjXIG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxjYa17muyqI4600zDJJjsWNw5axLhaEZlo9i9Ori0XuHy4nO6
	i6xn+1Si/el5caRpwwtGxJ/cIWbr794kGr7jOvTPVEXbrlZZOtN+ujvY2pzG9IJJIqQ=
X-Gm-Gg: ASbGncvCuXhPnYL+ooUDjX1dHfEsklJopSs5ICLewk4tUJII3NFgHY/zzHCkJ1KNh64
	gg5kP6KU4LUen3k/tD/+LBHbCQQXTLpINK9FXKO6Gc13WBV/bPF1JFVlU4qOX8e1BlzcNmffIVc
	vCNtqdb40Nu53YQebhZZNlcuyFq+E5TtNqPyuslh34J8tV7W0sImNo7CnuedaT+0jw3EQQswVzF
	zJVMmmy9F2E4oxQanRNyUNxus1lMKI0Rw4EhjRdgonX9/fmcMnG1D2WEAJ7ojL+ABpDT86nXpG1
	VA+cPum3sFv6ixixyYWYF9EGvNupog6HqZ+F9uTWucG6zI75yh4n1SKPIqdxDuI79pJd62Hj9Nf
	qyWOvL5KVv0iX7Hk7q+GmNuRteWl/9+U2TT8FJ5QKndRPMtsrr+cDP8wrKJODWXXzLlCt
X-Google-Smtp-Source: AGHT+IHYkw6eFpxfaIRVF1srsJ9FJ19UlQqBR6yhpID34uYqJijJ/A3tTeVFt7I+4cQKncFmezcccg==
X-Received: by 2002:a05:620a:8386:b0:7e6:65ce:2bb5 with SMTP id af79cd13be357-7e665ce2c46mr224992185a.47.1753799358715;
        Tue, 29 Jul 2025 07:29:18 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e643897b24sm431209085a.75.2025.07.29.07.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 07:29:18 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uglKP-00000000JGf-22cn;
	Tue, 29 Jul 2025 11:29:17 -0300
Date: Tue, 29 Jul 2025 11:29:17 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
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
Message-ID: <20250729142917.GF26511@ziepe.ca>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-7-aneesh.kumar@kernel.org>
 <20250728140841.GA26511@ziepe.ca>
 <yq5a34afbdtl.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yq5a34afbdtl.fsf@kernel.org>

On Tue, Jul 29, 2025 at 01:58:54PM +0530, Aneesh Kumar K.V wrote:
> Jason Gunthorpe <jgg@ziepe.ca> writes:
> 
> > On Mon, Jul 28, 2025 at 07:21:43PM +0530, Aneesh Kumar K.V (Arm) wrote:
> >> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> >
> > Why would we need this?
> >
> > I can sort of understand why Intel would need it due to their issues
> > with MCE, but ARM shouldn't care either way, should it?
> >
> > But also why is it an iommufd option? That doesn't seem right..
> >
> > Jason
> 
> This is based on our previous discussion https://lore.kernel.org/all/20250606120919.GH19710@nvidia.com

I suggested a global option, this is a per-device option, and that
especially seems wrong for iommufd. If it is per-device that is vfio,
if it is global then vfio can pick it up during the early phases of
opening the device.

> IIUC, we intend to request the resource in exclusive mode for secure
> guests—regardless of whether the platform is Intel or ARM. Could you
> help clarify the MCE issue observed on Intel platforms in this context?

As I understand it Intel MCEs if the non-secure side ever reads from
secure'd address space. So there is alot of emphasis there to ensure
there are no CPU mappings.

Jason

