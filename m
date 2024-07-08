Return-Path: <linux-pci+bounces-9901-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8350929A6C
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 02:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9A601C20A2D
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 00:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8F064B;
	Mon,  8 Jul 2024 00:55:37 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3267B18E;
	Mon,  8 Jul 2024 00:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720400137; cv=none; b=d3KDgyuLM89+ZMdVAR3DBmZujYJnvumm1X3UUkrMcGYGFjEq0Q8uT+sph3FPlqcQ2xFDc0GE67IMh8QfnCAoCXeroIbrcRJpg9ATYvEl0Av5jKmC1rynOZOeJzqGampXKiCaaNDuqTXMTU9c5QcKK5+7lAwSAem2RooXIUsdOwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720400137; c=relaxed/simple;
	bh=ERXbQUuJWEgOsNCx2q78Ud0n+TUu5fUHCLROMqVVCVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7++pCfv43RzybijYjJhmZ61XNuZ1w62SzLaMnu2QDgsbbMoLyvHYtg4rs3PKK2ZFj0KXHHB8aBZvI+p/ooG5/KZd4fNJJ4J+tIgYw4vtZEzrnIwihev+fjZp5GajkhRh5axDncxdUkoRZ0YLg2+pLBLDiaX5mn10vUnPkO/2KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fb0d88fd25so21006105ad.0;
        Sun, 07 Jul 2024 17:55:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720400135; x=1721004935;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RDJcioIgRokoEknQP/HTNblVSt1TW8hmi/54+StFqeE=;
        b=Topt8Rj1ScFqCV0ZlmJe379wQslBkwTlGK/1Ze5eQr35Xf+ygS0FuiJDAaj+/jJkhT
         oJyFd7tpVqFdWudcCPhOQsb+Kb3Y6w2hqRqDFWgyrKdBPSMbqafQw+KN8cNdcERUXg2Q
         HJex0s2v0MkyWoE7AZ1LrbQcE3Areg4+c3IMNH/rHijlfesKdXGS9T9PRoeJOL0kjK0Z
         gcexe6ZExMf2gMs/9BpMbgCMKn5QSqk/vP1kmg9BH/zyYUIwmM0dt/GgoU2ZzcyboY3d
         WNYTzLtFLIcN4rypduKov03RZuEwDgGlP3434OsgDNBo3OCcXEhsa81ojXz+qilfQl+c
         xu6A==
X-Forwarded-Encrypted: i=1; AJvYcCUMDi9u0NOtegXCtJFNiF4/DNOctmNSc1TGTpJc9s26DH6Xb4sC6Doqd4EH/K+1ZXE7X7ND5l4exSCVh1U6n3ENrJ9kVZux2+qagh1uNsTJv1cj1Wv06y4yqRGDzotMDBVJaU4Dz41K
X-Gm-Message-State: AOJu0YxYO+fyVsxvGMMn2ShrQ6TZKehWccRwLCrcDerAE/RwofaezwG9
	i9/erxiF86C5ACAH4G7rNIq9v+9UmnbO7SyxRuaddTm/SSqUKuLP
X-Google-Smtp-Source: AGHT+IEkJcV1nhz6kvCkwOiNdOEu8m3NKshaNXgH6aBbiceLbDy1XIpqsBC01SAiq5mdA67stW12gA==
X-Received: by 2002:a17:902:ea0b:b0:1fb:4985:22e0 with SMTP id d9443c01a7336-1fb498524d9mr114885495ad.23.1720400135325;
        Sun, 07 Jul 2024 17:55:35 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb4e7c31afsm46915785ad.2.2024.07.07.17.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jul 2024 17:55:34 -0700 (PDT)
Date: Mon, 8 Jul 2024 09:55:33 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Alistair Francis <alistair23@gmail.com>, bhelgaas@google.com,
	linux-pci@vger.kernel.org, lukas@wunner.de,
	alex.williamson@redhat.com, christian.koenig@amd.com,
	kch@nvidia.com, gregkh@linuxfoundation.org, logang@deltatee.com,
	linux-kernel@vger.kernel.org, chaitanyak@nvidia.com,
	rdunlap@infradead.org, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v13 3/4] PCI/DOE: Expose the DOE features via sysfs
Message-ID: <20240708005533.GC586698@rocinante>
References: <20240702060418.387500-1-alistair.francis@wdc.com>
 <20240702060418.387500-3-alistair.francis@wdc.com>
 <20240702145806.0000669b@Huawei.com>
 <CAKmqyKPEX632ywm5DiKvVZU=hr-yHNBJ=tcN2DasKpfWdykgZg@mail.gmail.com>
 <20240705112953.00007303@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705112953.00007303@Huawei.com>

Hello,

> > Any input from a PCI maintainer here?

Something that I am curious about: can we make this a single file with a
bitmask inside that denotes what DOE features are enabled?  Would this be
approach be even feasible here?

Thoughts?  Or is it too late to think about this now?

> > There are basically two approaches.
> > 
> >  1. We can have a pci_doe_sysfs_init() function that is called where
> > we dynamically add the entries, like in v12
> >  2. We can go down the dev->groups and device_add() path, like this
> > patch and discussed at
> > https://lore.kernel.org/all/20231019165829.GA1381099@bhelgaas/
> > 
> > For the second we will have to create a global pci_doe_sysfs_group
> > that contains all possible DOE entries on the system and then have the
> > show functions determine if they should be displayed for that device.
> > 
> > Everytime we call pci_doe_init() we can check for any missing entries
> > in pci_doe_sysfs_group.attrs and then realloc
> > pci_doe_sysfs_group.attrs to add them. 
> > Untested, but that should work
> > even for hot-plugged devices. pci_doe_sysfs_group.attrs would just
> > grow forever though as I don't think we have an easy way to deallocate
> > anything as we aren't sure if we are the only entry.
> 
> I think this needs to be per device, not global and you'll have to manually
> do the group visibility magic rather than using the macros.

Lukas proposes a very interesting feature of kernfs recently per:

  https://lore.kernel.org/linux-pci/16490618cbde91b5aac04873c39c8fb7666ff686.1719771133.git.lukas@wunner.de

Would this help with DOE features?

	Krzysztof

