Return-Path: <linux-pci+bounces-12674-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE7496A360
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 17:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56C70B231F3
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 15:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA14188921;
	Tue,  3 Sep 2024 15:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LupR32Qm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A79188A22
	for <linux-pci@vger.kernel.org>; Tue,  3 Sep 2024 15:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725378980; cv=none; b=clmzHwomkj5wBs4s4N2ul++sUt7vxCvA61Dv9KEN32KUN6FaTx8X8yTVuDUsz4THv30MHfqdyrJ2tzqMA2LsVR3qe2HEDKAUFwL3mLhgXSI+G3++BVLPuiiBWcRZ03iLKLN5AWjzc6qJVN9XONkHA1f8+KBXoU+1ugFks2sYrYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725378980; c=relaxed/simple;
	bh=Mzgy4Zfk7DBRAXkLZqlzskQY/R1zzzcOZXHvCA6PQXE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZQwDYpDxkAnGzvcaLjMkfVg7QeUOKrq+As4tK4I+Bk/jUZoiB/+JptwQnkfswNMckTTtNqiEAqlR5vHugBNPVcww5KcyqsijGVqcE6QQ6Du1FG3mcL3Q93ShnlzvSZ7Xpb4QmI4TZHcAcyptpEM844nCQS8XAKDQJGA/+jaXX2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LupR32Qm; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2d876431c4aso3716518a91.0
        for <linux-pci@vger.kernel.org>; Tue, 03 Sep 2024 08:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725378978; x=1725983778; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GWzaB2zVBiJq7ajI0wtzRO85aFP0qg9gF2s4BJREzmU=;
        b=LupR32Qmhp4ZTKzF0A9Jtkk+cev1huxoz6Sq3m6GPawLCgDcZgrr3/on9vxtBQTc/+
         iOZ0uLdDIwa9SrLZATfeu4zYeTFMEjQBwjm+xk/9IqsSSWvfZWqJSZFQVGOZjFLJ38qQ
         ul9kvMoAHJJXOi2jJSc9ISVyjeR/CTkHdfqLwK22HU0cPPfclmAWkLKiEYR4mahFkg1L
         HIsBZJSyECEorXER+jqTn3c45Kyl0oLk/NAb3bXRMZoKIywFPw/bquNJCz6WgXtF6ecc
         I0vbAY515fAyGXSPKk/jjZCHrGsr+o+6hbe1/qTkXPjVguvaN7E+xZwlQwhRbOVLyu1F
         2Mnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725378978; x=1725983778;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GWzaB2zVBiJq7ajI0wtzRO85aFP0qg9gF2s4BJREzmU=;
        b=XYrzBbheML1fOjZ7eyXsHN18ofx60U2WLKvEiafVHbfhyAq37zGK15wKkF89jaB3x0
         ika/gkv4q/DB+9Q/uMnadzLyhye89GrIsePH0htvg2Y+YUK0yqlKLvMJDNYEwUsG6FnG
         S26XFPIa/xZFrZVWhLNDmwpE0WOb7IqXcoA5DZgRHRCxrCCwes0fOXsN9uS5Ser+4cjA
         VGk+2A16Z6Q+5VSj2QJxaUN53zzcQlJcv2r7xjrqose/pBj0CJu9PMuXDGPf9X2hrsIJ
         BHAHDXg3RBUozYsScFEj/dNl3/Ezj9xy3psjVK0rDExXToni2twK2h/ohx3324CfGnBZ
         rzlw==
X-Forwarded-Encrypted: i=1; AJvYcCWfQqSMUpj/65tSrN87W9C9g+R82p3xy77Y13G48fr+k3LilDUxmubKgk/bx84eGZPHCCpYLHaZ8nI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnznNdZIO9ZkNJRYVpOzTZIIyMntt2OaLT0EK9SeM+92DRTU6D
	ShkPVV9XOxZ+MQ2G3TDapbeYM5a7qYoidAf4LQv3GyqTU5zt5HC8DNc6me3C145cgHNA4RpIFxu
	bsw==
X-Google-Smtp-Source: AGHT+IEU1849ih3tqcS05odvzRPeJyVpF9Fkthp9R0njzfPmkPWPuM+m0PM+Icyr5mRhgGWG26r/jNAQht0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:3013:b0:2d8:9dd1:d9aa with SMTP id
 98e67ed59e1d1-2d89dd1da1emr23806a91.8.1725378977841; Tue, 03 Sep 2024
 08:56:17 -0700 (PDT)
Date: Tue, 3 Sep 2024 08:56:16 -0700
In-Reply-To: <20240823132137.336874-1-aik@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240823132137.336874-1-aik@amd.com>
Message-ID: <ZtcxoPl302h77pb9@google.com>
Subject: Re: [RFC PATCH 00/21] Secure VFIO, TDISP, SEV TIO
From: Sean Christopherson <seanjc@google.com>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-coco@lists.linux.dev, 
	linux-pci@vger.kernel.org, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Alex Williamson <alex.williamson@redhat.com>, Dan Williams <dan.j.williams@intel.com>, 
	pratikrajesh.sampat@amd.com, michael.day@amd.com, david.kaplan@amd.com, 
	dhaval.giani@amd.com, Santosh Shukla <santosh.shukla@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, 
	Alexander Graf <agraf@suse.de>, Nikunj A Dadhania <nikunj@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Lukas Wunner <lukas@wunner.de>
Content-Type: text/plain; charset="us-ascii"

On Fri, Aug 23, 2024, Alexey Kardashevskiy wrote:
> Hi everyone,
> 
> Here are some patches to enable SEV-TIO (aka TDISP, aka secure VFIO)
> on AMD Turin.
> 
> The basic idea is to allow DMA to/from encrypted memory of SNP VMs and
> secure MMIO in SNP VMs (i.e. with Cbit set) as well.
> 
> These include both guest and host support. QEMU also requires
> some patches, links below.
> 
> The patches are organized as:
> 01..06 - preparing the host OS;
> 07 - new TSM module;
> 08 - add PSP SEV TIO ABI (IDE should start working at this point);
> 09..14 - add KVM support (TDI binding, MMIO faulting, etc);
> 15..19 - guest changes (the rest of SEV TIO ABI, DMA, secure MMIO).
> 20, 21 - some helpers for guest OS to use encrypted MMIO
> 
> This is based on a merge of
> ee3248f9f8d6 Lukas Wunner spdm: Allow control of next requester nonce
> through sysfs
> 85ef1ac03941 (AMDESE/snp-host-latest) 4 days ago Michael Roth [TEMP] KVM: guest_memfd: Update gmem_prep are hook to handle partially-allocated folios
> 
> 
> Please comment. Thanks.

1. Use scripts/get_maintainer.pl
2. Fix your MUA to wrap closer to 80 chars
3. Explain the core design, e.g. roles and responsibilities, coordination between
   KVM, VFIO/IOMMUFD, userspace, etc.

