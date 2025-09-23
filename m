Return-Path: <linux-pci+bounces-36769-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EEBB95E8C
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 14:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB4973B1A69
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 12:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FE9322DCC;
	Tue, 23 Sep 2025 12:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RunkEksx"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53233323F5A
	for <linux-pci@vger.kernel.org>; Tue, 23 Sep 2025 12:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758632290; cv=none; b=u2ICmGrOUWUJ/syEDIFqkHsMGrnrrd/VrvCli4qXXw4cm+x41TquJK+aXtkBDSH1L3gcQHs3gf3VPT8AEvJjGywFSFyJJqOoHrHOBs2HzExnWtpnhtUpFsPPSnrCiy0A8Pdf9bHkpQqY2bjr5MtV9PrPJXS4vBCnIwrtPPg7HyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758632290; c=relaxed/simple;
	bh=A2IMMdRVOaoGx4CmZT7VA864qaSMJOoHUZNtkeMI/VU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fR3J9PQCIsxhniQsH/zbL0eo+AHo4dYuDgF95L6rWQXJulc2dB1ScJpAwc6FcpTx9v4dzObyMFd4rjSWDOOn4BN9JpCESd+c/9PLc5EuM5HiguY6f75GMwZ7PWywVXV+gusrQQMoHu4a9ut0LfOIiGGxObiuKKdy2pyVduey2hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RunkEksx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758632287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Tq8eV1TAeYiGLz8ruZSC4SaM9je4JKLFfQxF5hcnMA=;
	b=RunkEksxs9/0cxA3/8usOFHtRjhv0+aYpxdKUYNRRG+JD1AF0yYkHfeZgZqsTtdy2SUchT
	C4z2fLRvhtHig/s8zVK3wVyYA/cb6s5i1Pu306Tf8GDa4zVSRDSK96rcSU3kpTNA8qRRm/
	uvCsqLQGQHRiOwwqTccaIcYUtCSTvBg=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-IN4ComJ-NHS9IX5WLOAqnw-1; Tue, 23 Sep 2025 08:58:06 -0400
X-MC-Unique: IN4ComJ-NHS9IX5WLOAqnw-1
X-Mimecast-MFC-AGG-ID: IN4ComJ-NHS9IX5WLOAqnw_1758632285
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-4257e2f44e9so3702975ab.3
        for <linux-pci@vger.kernel.org>; Tue, 23 Sep 2025 05:58:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758632285; x=1759237085;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Tq8eV1TAeYiGLz8ruZSC4SaM9je4JKLFfQxF5hcnMA=;
        b=crumX4MYzxRgnxlX9dCrS7xbzhpZ619FivMq6TfpdQ0GUsfJ6kL9DZLU68XuLOMZNW
         mXokDBncYx8DWr04FVa/V4Kyyw0+Yj6i5xCCLrd/BiFB6CubQSQMFdWmDJCzQE9zjFbE
         gk7NqNF+2La/hNYdWgNGpQqIsDKiFDNaNt8p2kpaZ9dPJkBQzejoXbrVyFfqprYwWPgc
         FU43JYWXr1psD+9vQA7JWuTDHL+iGCgB2r/sQE1i1HBSBzUUziKb1HAtgHyESJ221Jhl
         aRHPoC5qiLIuY82GrCRhqXXEIX7w4hvFgLO7kwaVrN/yRrnBf6BMgtmCnHVk9zY9HgDY
         Ebow==
X-Forwarded-Encrypted: i=1; AJvYcCXcEhdfhrBT6uh4l6b/GYOKDbXjOlXNyy0+UDdHZnAPdR6XfVkx2vPPuMqve/E5BAZIxKb+3Rkm0TA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFvxKeV4ej+MxN1hqVtqJjJzfR23vkR9XuBL2IcAe9PO4CkE7L
	BXleLo5mq20RURfwqfLQTXWAMdCrUqzoFHFdGqJY08/sYlw0ZMzNdZs+yCVvagjrM042z5RylpQ
	vpV9M9Pg1fH3Pv+W0ZqMRBOIsfugq5Oi80AQMAPxNpH0S+i8MOC4w2uqfebLf7w==
X-Gm-Gg: ASbGncu5E5jRsSCNIRx4kebJ7JHUiEqkKC4YW6Yl3uDpIiXqMLOCDOhnKXmacCBhUHU
	2hwy4fFVM0g3axQ8//Qa1ALZIvHr3DrxR6izTo2xgUCKYY/lu5w7QbEp/ajAV5jn2vHS4awoj6E
	x+PKqZ0zgf7IZ5P113LwMiGaS/RB8CwRtdaA644oVgcRzDcAADCF0CaLoznm5FI33HicKHKla3p
	xfJ5kXZuRDUSG/kPm2pMWb2Xwe+INRpemTu05wICIZQ3HWyVoEvOP5xLTCC0cxJiA3RmuT+8HKF
	FnWdHmVi5N93sCDh/B+zMwhr8WjJRdEj3Jxy35bZg9k=
X-Received: by 2002:a05:6602:3fc4:b0:897:42c1:bcd3 with SMTP id ca18e2360f4ac-8e20e8ff164mr163410139f.5.1758632284961;
        Tue, 23 Sep 2025 05:58:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWbkj/uISty5Vh6ighMEa8imB4zODbgJ/1fX320gi/1h2UE0ETTQaM30bBEliykOTPs5/KCA==
X-Received: by 2002:a05:6602:3fc4:b0:897:42c1:bcd3 with SMTP id ca18e2360f4ac-8e20e8ff164mr163408639f.5.1758632284492;
        Tue, 23 Sep 2025 05:58:04 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8d7f8f481bfsm138390739f.24.2025.09.23.05.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 05:58:03 -0700 (PDT)
Date: Tue, 23 Sep 2025 06:58:01 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Donald Dutile <ddutile@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>,
 iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
 linux-pci@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>, Will Deacon
 <will@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 galshalom@nvidia.com, Joerg Roedel <jroedel@suse.de>, Kevin Tian
 <kevin.tian@intel.com>, kvm@vger.kernel.org, maorg@nvidia.com,
 patches@lists.linux.dev, tdave@nvidia.com, Tony Zhu <tony.zhu@intel.com>
Subject: Re: [PATCH 03/11] iommu: Compute iommu_groups properly for PCIe
 switches
Message-ID: <20250923065801.3c6a23e4.alex.williamson@redhat.com>
In-Reply-To: <20250923123218.GI1391379@nvidia.com>
References: <20250702010407.GB1051729@nvidia.com>
	<c05104a1-7c8e-4ce9-bfa3-bcbc8c9e0ef5@redhat.com>
	<20250717202744.GA2250220@nvidia.com>
	<2cb00715-bfa8-427a-a785-fa36667f91f9@redhat.com>
	<20250718133259.GD2250220@nvidia.com>
	<20250922163200.14025a41.alex.williamson@redhat.com>
	<20250922231541.GF1391379@nvidia.com>
	<20250922191029.7a000d64.alex.williamson@redhat.com>
	<066e288e-8421-4daf-ae62-f24e54f8be68@redhat.com>
	<20250922205027.229614fa.alex.williamson@redhat.com>
	<20250923123218.GI1391379@nvidia.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Sep 2025 09:32:18 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Mon, Sep 22, 2025 at 08:50:27PM -0600, Alex Williamson wrote:
> > That's not what the spec is doing.  We're misinterpreting it.  The
> > sections of the spec you're quoting are saying that if a MFD function
> > supports ACS it must support this specific p2p set of capability and
> > control bits unless the device does not support internal p2p.  
> 
> Bjorn raised that too, but it doesn't actually say that. The wording
> is meaningfully different from the preceeding section that does
> explicitly say the language only applies if the ACS cap is present.

What then is a "Multi-Function Device ACS Function".  I think we need
to take context from the parent and previous sections to understand
this applies to functions implementing the ACS extended capability.

> IMHO, from a spec perspective, prior to this language, internal MFD
> loopback was *undefined*.
> 
> You are advocating for a very pessimistic position that undefined must
> mean the worst interpretation for everyone. It doesn't, undefined
> means we don't know.

Right, we don't know if p2p is implemented, we're implementing a
security related feature, therefore we assume the worst case and allow
for quirks in instances where the vendor can vouch that p2p is not
possible.

> A big part of the argument here is that in the modern world the HW
> community has aligned that MFDs should not have internal loopback
> because it harms virtualization.
> 
> We are here a decade later and we can choose to require quirks on
> devices that choose to implement internal loopback, because they are
> certainly now the minority of HW.

This seems like optimistic speculation.

> > We've had NIC vendors implement an empty ACS capability to convey the
> > fact that the device does not support internal p2p.  There is precedent
> > for the interpretation I'm describing.  
> 
> IMHO it just shows Linux has the power to convince device vendors to
> do things.

And now we're effectively punishing vendors that have gone to this
effort to expose isolation by hand waving that it should exist by now...
 
> > Are we going to expect users to opt-in to securing their system?  
> 
> Since the grouping isn't working right today we are already
> effectively doing this.
> 
> All this is arguing that the burden shifts from people with modern
> systems to people with ancient systems.

AIUI there's a narrow case of downstream switch ports implemented as
separate slots that is misrepresented.  This should be fixed.  There's
also an effort here to consider both egress traffic (as done today) as
well as ingress traffic (new).  IMO this will inevitably cause
regressions and users may need to opt-in to make their grouping less
secure for previous compatibility.

Requiring users to opt-in to secure their system is fundamentally
different from requiring users to opt-in to a reduced isolation
paradigm.  Thanks,

Alex


