Return-Path: <linux-pci+bounces-38827-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B6CBF40F9
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 01:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CB4B18C4F16
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 23:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3122673AA;
	Mon, 20 Oct 2025 23:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qTcy0VQ/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC3822259B
	for <linux-pci@vger.kernel.org>; Mon, 20 Oct 2025 23:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761004182; cv=none; b=WrHpKvnO+e+bVF0aQfp+NoaPpoISBtHbNOhqH3xvodGPCxHvI6SaBOD4XHcEoCacY6kKRbA4eZt7UDTbNYAPM7AWOfJBiNtgD7Y1MT2gETeDIn7rDAdXSHRBPDf3mrHB7YcEBCGI6CCJUgoE+iZP2uB2OwhrSC/zkCNobkvi8Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761004182; c=relaxed/simple;
	bh=zSYtD3HhQ97XH9Wrf3mufknJ6+YNLu4weydbXr6znmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ShKEwRBTUdEjjGFpsrkzjkEbivdXGPuTiql/GcmQMm7AvketdmSHS5YfMPa1dsE1eWtk493llfYefnHIZit7Aq5An2Na7Ken5xqWjP1HbRUENIp7+5j9DnCp+5/yQPq6hUG8j0QzszyKN2uADIoHsRNjGwW0agJUq1sgKB59v8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qTcy0VQ/; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-290d48e9f1fso59165ad.1
        for <linux-pci@vger.kernel.org>; Mon, 20 Oct 2025 16:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761004180; x=1761608980; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=APIPLhdONSvh2oNS2Jy31QMeW+iB8sQZx3emBmCMWyc=;
        b=qTcy0VQ/z0E7mEUSLKIdL+3CDTQ/KdAahs0xyc5r4uRdFEF7+bHMkJeToVMgOCNVf3
         w1fRqM2WX0QWgUCfsIQ86dAxoy0TESqclnRJlQeAGNMG99OfDQ8B70EKJ4k7fZEY+5dI
         LZHLfUMy0DqnA960XGkhGdiNPgDSB/wwoTbHOl3qRxrwzp+sUKaKuHcFL8f/uTWs2Odp
         gRUrxicYx23g3Pn4pt+jSeGvydtwSorYtpMhwjxp5sh9xaQjS+N86ipmkEYaZmTfRumz
         9hiwfCpDLO885/HtgaFnQgJUJVfGWyhP+kxVfFB9CJEN7MRgs1ykXnZIql9HaW47KxvB
         x2HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761004180; x=1761608980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=APIPLhdONSvh2oNS2Jy31QMeW+iB8sQZx3emBmCMWyc=;
        b=kM0Dou7oTQVTxXgwWzedEwaH/wtA0BM5bjkAjhr7CI/FCtrg7yucXfjJ0jKmSxIf7y
         TCJwmsd+okd8t0Nbpgfg/L6g6SZBZMlK93ChOU14zcAUwWhIxOwd+gNP9Tu0faqVv1j1
         43tM5fiqlQsj+jP1RefWNL+yNY1ALauyOFficSkF8J1bgApcFOAYCDEc8UNrQF119XBA
         2NfX2H0H36jftWF/XUYzaHwIxyiJGcTrNN8MScSiQvbiQJ+iWPxz0UzXmYSKR3suL0w5
         kQmBr5Jmtz7xBJI6AoZNhbGFkC+E7acyzmyEeTALDarPaTpZ2z4k12ZoXdI/N7APqufo
         0aYA==
X-Forwarded-Encrypted: i=1; AJvYcCU/J7ZK7kB5pjcpP/uTE8wFNvcsfJrikqSPvxocWU5be3KMqyGinwh3pEKkxS9prtRHiWhAux9IaI4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5hCjpNKb+0ASL/XWH0BN8e3qhz3vn9MSw3kHmeLWCYpFM0R8u
	DkiF+zWcVsErhGC8syoJtVeJciNkknZsVNDzhODY35ZnxMrZYAr9C5NSc/vyR8wpKQ==
X-Gm-Gg: ASbGncuxk6edgX00UBLWAvm9vN4tIxRpuvn/VDJ59GWykZzXHAhMYMOcfldKKsPAk8d
	WgxROB3v2uTdZCx7IQXs6NVVaLrwnQ7zmBQaw335WPPeYiCruK+phwmPCK0mzppTMIjLPXDQJB9
	xZQ0U8TenD2T2rQNJBRqaB3UIpA+gGbuADXEQPml2SgfJ7pozxvsz0Z2pUo6sjjdyuo4hY3OUAu
	nG4RxQbSbe7lw4LLIgeYWAPXby6TT/W5Dl+usx/RjgvOu6tbRQns30Uc9vfCqWqKVoJYwTmcIvv
	HpzcnufCs+CDbjWPp2/wfh2yk9FotAFijcR0X6BYixlAJP+l+/Fg1cNobuV7QVUwITOj/3pCakA
	zB7MD7SRn5vL09qHOotML+jRLJrRoUzcBi6jkslrMiMG0UQFYG5uai2qQtetOWcbmg5ezpbAM1x
	MVTWYdtxvSVTvC9e+klNNqzGWDn7U8MEszFg==
X-Google-Smtp-Source: AGHT+IHpL+PTPx5cLpK4SolM4pA26Uh3D3RVyUZIGeMHX90GD8vWXwavzy2Wzm8Nw3ukyKcc1LWkjA==
X-Received: by 2002:a17:902:ef08:b0:292:b6a0:80df with SMTP id d9443c01a7336-292d429a794mr2192795ad.10.1761004179616;
        Mon, 20 Oct 2025 16:49:39 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246ffef8esm91310515ad.51.2025.10.20.16.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 16:49:39 -0700 (PDT)
Date: Mon, 20 Oct 2025 16:49:34 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Lukas Wunner <lukas@wunner.de>, bhelgaas@google.com,
	alex.williamson@redhat.com, pasha.tatashin@soleen.com,
	dmatlack@google.com, graf@amazon.com, pratyush@kernel.org,
	gregkh@linuxfoundation.org, chrisl@kernel.org, rppt@kernel.org,
	skhawaja@google.com, parav@nvidia.com, saeedm@nvidia.com,
	kevin.tian@intel.com, jrhilke@google.com, david@redhat.com,
	jgowans@amazon.com, dwmw2@infradead.org, epetron@amazon.de,
	junaids@google.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 15/21] PCI: Make PCI saved state and capability
 structs public
Message-ID: <20251020234934.GB648579.vipinsh@google.com>
References: <20251018000713.677779-1-vipinsh@google.com>
 <20251018000713.677779-16-vipinsh@google.com>
 <aPM_DUyyH1KaOerU@wunner.de>
 <20251018223620.GD1034710.vipinsh@google.com>
 <20251018231126.GS3938986@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018231126.GS3938986@ziepe.ca>

On 2025-10-18 20:11:26, Jason Gunthorpe wrote:
> On Sat, Oct 18, 2025 at 03:36:20PM -0700, Vipin Sharma wrote:
> 
> > Having __packed in my version of struct, I can build validation like
> > hardcoded offset of members. I can add version number (not added in this
> > series) for checking compatbility in the struct for serialization and
> > deserialization. Overall, it is providing some freedom to how to pass
> > data to next kernel without changing or modifying the PCI state
> > structs.
> 
> I keep saying this, and this series really strongly shows why, we need
> to have a dedicated header directroy for LUO "ABI" structs. Putting
> this random struct in some random header and then declaring it is part
> of the luo ABI is really bad.

Now that we have PCI, IOMMU, and VFIO series out. What should be the
strategy for LUO "ABI" structs? I would like some more clarity on how
you are visioning this.

Are you suggesting that each subsystem create a separate header file for
their serialization structs or we can have one common header file used
by all subsystems as dumping ground for their structs?


> 
> All the information in the abi headers needs to have detailed comments
> explaining what it is and so on so people can evaluate if it is
> suitable or not.

I agree. I should have at least written comments in my *_ser structs on
why that particular field is there and what it is enabling. I will do
that in next version.

> 
> But, it is also not clear why pci serialization structs should leak
> out of the PCI layer.
> 

When PCI device is opened for the first time, VFIO driver asks for this state
from PCI and saves it in struct vfio_pci_core_device{.pci_saved_state}
field. It loads this value back to pci device after last device FD is
closed. 

PCI layer will not have access to this value as it can be changed once
VFIO has start using this device. Therefore, I thought this should be
saved.

May be serialization and deserialization logic can be put in PCI and
that way it can stay in PCI?

> The design of luo was to allow each layer to contribute its own
> tags/etc to the serialization so there is no reason to have vfio
> piggback on pci structs or something.
> 
> Jason

