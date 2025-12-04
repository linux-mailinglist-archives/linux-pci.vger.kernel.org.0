Return-Path: <linux-pci+bounces-42660-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D81CA56EA
	for <lists+linux-pci@lfdr.de>; Thu, 04 Dec 2025 22:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1736931351CC
	for <lists+linux-pci@lfdr.de>; Thu,  4 Dec 2025 21:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71D82FB978;
	Thu,  4 Dec 2025 21:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S0TOghw2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NY6C1llK"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BFB1DE89A
	for <linux-pci@vger.kernel.org>; Thu,  4 Dec 2025 21:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764882472; cv=none; b=upq2vTjKOd1h4QsaIVmmS61S+OftulpUPEZP6s8vI9FcPlv0HPzUFq4Pa0jSgWbFKNt/EmcYDnS/Pk5Uj3tJE3BCPq1SWx/5QdBsIQY0nNqm9oeLi409NObcj3PV0+wopNlQxhW8uKXwa70xJSeUZGg7Nxhi5sc7V3lY7u7mRcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764882472; c=relaxed/simple;
	bh=NW9cQQoEAaaq3AA9nc6mb/b5UPvD+lPeMPRsPYxJB4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DrDnlo8PjD5sagi8WJt1n3/5k4YserhdFNDwmSRmZ4d9xraNHEwgFHPFBXcKYc+EUbX+0DoF0249gy2kegnCGanX8plmQN4Gj8aCxnNVz38OoOhAlmwHsHdcltvGGQKAVgTYYjwjiiHP7MA8RnQwb/nDwMFRZRhTRZ4nWQFImRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S0TOghw2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NY6C1llK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764882466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Utloqd78xIty0AP3e9N1+0oedDpwpptC21lH5x2/t7g=;
	b=S0TOghw2s7GXjQTgb4HjaZKJzmM6eJnrQ8h39y5+KcGWz+sqgFI+Z18LV1UbLeltQ7XClS
	Yl1xxPoHSASL0p6TjEW3ws2h28QAIJ3kuYhL2NSc9LCgT8zsEFLrdWVyVJVtybopzHqeLg
	eOUgkKgYsA36kt06RPtkH2oJFH/47ls=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-J4WND92pMXOA_pvu4Gvb8A-1; Thu, 04 Dec 2025 16:07:45 -0500
X-MC-Unique: J4WND92pMXOA_pvu4Gvb8A-1
X-Mimecast-MFC-AGG-ID: J4WND92pMXOA_pvu4Gvb8A_1764882464
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-787fdf1b574so18129457b3.1
        for <linux-pci@vger.kernel.org>; Thu, 04 Dec 2025 13:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764882464; x=1765487264; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Utloqd78xIty0AP3e9N1+0oedDpwpptC21lH5x2/t7g=;
        b=NY6C1llKcFZU4lpB7Ky26vProTmAssitVaxaRYty7JGkBpyvIlbLeWGlwv3aYxzeb3
         Wa+3HLbiXSdYRCrl6mDzh59YPmV4nHJje2NJ+g5X+LG+x3KR3eqq/ZnevjVpMishaWX+
         gj1HNYKCNTMsyVEfdCAhrZsF3eNzaOWKsac0gEuw7McJkFtrk50ws4CgmnhQpuhesDNt
         iCzZNfel5lRGE81pibVyYV01LSEx1bWYGS8KDGBpY3mt5RO0tFJIFOAfp0XULI1Fto20
         4LKE233AmeGU8rzoEyPDf8QIz9RI8HVPak+ak7r/9KTNrXTpUB9HFn52u2c6cd11B/Cj
         XhaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764882464; x=1765487264;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Utloqd78xIty0AP3e9N1+0oedDpwpptC21lH5x2/t7g=;
        b=PdeZzZaTbZYbJ2YZpb+nl5vJ73ltI6j88/nkbbLdK5xeC25scP9bgBf91vdcZidaR6
         zBcJdXyfCskTpk759HqL9WyLOngyuVi2tWPBrBCtbPjYqlHVu0rasULm2njIMTyzgBAD
         3DovlLUo+vzO83RhAcoEX+sp3QoTr3e6XkTt7/jTGEkejsTbJWjHiiKXj8qVT4OZCNPK
         jeDzq+nRLh7sS3r/u5/tmPIUPR7fbsABXicczJZTQzQ05d5IkMXGUSFffK9xHcwJTsho
         0F1hm2o8bvQN9NJzLm0CN3dmp4fO2h3pSd2KIOkEzyVOUTfNmeOVlnNmTDFYBGcgus7u
         bggQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0s7Dk7kDHBpCEV8nXFcfmNT3UwuiWpUqC6EobrwMZAKqMuCXResizGbBQp0u/LGCmX+6VoS3ALsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKAhI6fXo9wIkVTnlTNqEDG+GtfxqW25kMb1YTI6QD7Y11Rtsw
	ifanfi6I8prErdZwNBBostXg6mr2BZ5Fsgl4gMYb4nODPgHon9uS5QB9UQZtK7KyTmxA8GxuQPD
	J1fxpUpimyKd+Q2oNtyvmQOI+Uyop/wvtAfmHMOCX+xkx12hHSdASQ/kcpsRWNA==
X-Gm-Gg: ASbGncuLhFfhMABnklgkT+5hHh6+mzGzaiaeWwZL+xuzIqHckaLDHfPqoGYAHGGHcow
	faSlIs1+unmA5ZWcm4YAmbqBhJHw7tPIE/W2NhmKBBuVbPIsg9z/aJgNcRsjQpbmYWItVoqmsmn
	dOoU0FPMg8P753k3/OAm7P+Rml1oQIM4aF6qFoSlClowliB3HpXK/m73tnLChhREd7s6pjwWqdR
	h76IW72JJXJKhK8fW8wADWbqFkgBbDFy5jKj6noUN4kXLjUcYr9D3dnBHZBTUachK3Ks+FO2zot
	9oMAcNWFdpDOkPn8uBCvnVTKEe4AYjRNyQSEAWm1obYPhq1jZ/5bHRYV4VuMUiWLFLV+LWN81mn
	UYuo+TalAzQ==
X-Received: by 2002:a05:690c:1e:b0:786:5789:57ce with SMTP id 00721157ae682-78c0bffa67bmr64181327b3.43.1764882464273;
        Thu, 04 Dec 2025 13:07:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHm82XKkqw4kfk5U49CAGJ/i+43HgaWocHH822ewl7ru2nz49+bzl9Zv11OSszH0Ut14YtklA==
X-Received: by 2002:a05:690c:1e:b0:786:5789:57ce with SMTP id 00721157ae682-78c0bffa67bmr64180817b3.43.1764882463673;
        Thu, 04 Dec 2025 13:07:43 -0800 (PST)
Received: from localhost ([2607:f2c0:b021:e700:58e4:f7ce:31b9:7841])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78c1b7a72dcsm9479027b3.52.2025.12.04.13.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 13:07:43 -0800 (PST)
Date: Thu, 4 Dec 2025 16:07:42 -0500
From: Peter Colberg <pcolberg@redhat.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dave Ertman <david.m.ertman@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>,
	linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexandre Courbot <acourbot@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>, Zhi Wang <zhiw@nvidia.com>
Subject: Re: [PATCH 7/8] rust: pci: add physfn(), to return PF device for VF
 device
Message-ID: <aTH4HifpRnqWA6X8@earendel>
Mail-Followup-To: Jason Gunthorpe <jgg@ziepe.ca>,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dave Ertman <david.m.ertman@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>,
	linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexandre Courbot <acourbot@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>, Zhi Wang <zhiw@nvidia.com>
References: <20251119-rust-pci-sriov-v1-0-883a94599a97@redhat.com>
 <20251119-rust-pci-sriov-v1-7-883a94599a97@redhat.com>
 <20251121232642.GG233636@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121232642.GG233636@ziepe.ca>

On Fri, Nov 21, 2025 at 07:26:42PM -0400, Jason Gunthorpe wrote:
> On Wed, Nov 19, 2025 at 05:19:11PM -0500, Peter Colberg wrote:
> > Add a method to return the Physical Function (PF) device for a Virtual
> > Function (VF) device in the bound device context.
> > 
> > Unlike for a PCI driver written in C, guarantee that when a VF device is
> > bound to a driver, the underlying PF device is bound to a driver, too.
> 
> You can't do this as an absolutely statement from rust code alone,
> this statement is confused.
> 
> > When a device with enabled VFs is unbound from a driver, invoke the
> > sriov_configure() callback to disable SR-IOV before the unbind()
> > callback. To ensure the guarantee is upheld, call disable_sriov()
> > to remove all VF devices if the driver has not done so already.
> 
> This doesn't seem like it should be in this patch.
> 
> Good drivers using the PCI APIs should be calling pci_disable_sriov()
> during their unbind. 
> 
> The prior patch #3 should not have added "safe" bindings for
> enable_sriov that allow this lifetime rule to be violated.
> 
> > +    #[cfg(CONFIG_PCI_IOV)]
> > +    pub fn physfn(&self) -> Result<&Device<device::Bound>> {
> > +        if !self.is_virtfn() {
> > +            return Err(EINVAL);
> > +        }
> > +        // SAFETY:
> > +        // `self.as_raw` returns a valid pointer to a `struct pci_dev`.
> > +        //
> > +        // `physfn` is a valid pointer to a `struct pci_dev` since self.is_virtfn() is `true`.
> > +        //
> > +        // `physfn` may be cast to a `Device<device::Bound>` since `pci::Driver::remove()` calls
> > +        // `disable_sriov()` to remove all VF devices, which guarantees that the underlying
> > +        // PF device is always bound to a driver when the VF device is bound to a driver.
> 
> Wrong safety statement. There are drivers that don't call
> disable_sriov(). You need to also check that the driver attached to
> the PF is actually working properly.

Thank you for the review. I missed the obvious case where the
PF driver is a C driver that does not disable SR-IOV on unbind
and the VF driver is a Rust driver that invokes physfn().

> I do not like to see this attempt to open code the tricky login of
> pci_iov_get_pf_drvdata() in rust without understanding the issues :(

I will work on a proper solution based on Danilo's proposal [1].

[1] https://lore.kernel.org/all/DEFL4TG0WX1C.2GLH4417EPU3V@kernel.org/

Thanks,
Peter


