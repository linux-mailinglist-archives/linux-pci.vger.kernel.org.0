Return-Path: <linux-pci+bounces-43616-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB87CDA548
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 20:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C9DC2300163C
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 19:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56752EC0A7;
	Tue, 23 Dec 2025 19:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aZTexvGc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qdKIvB1I"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B5A2D6E40
	for <linux-pci@vger.kernel.org>; Tue, 23 Dec 2025 19:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766517442; cv=none; b=etykxS7/THjidvdsjVJkSmc6MWuuWDcajJMCQ+GCerq957sIrSVQ0PcbClHTdTH/rHdqJrwH+7LdAoJwIXfgFqaowIZ/0miWaByXeNAM9jrmAfXlbbRD4BYeKA1+vwlKRuy1cCA2FgcvphI4rdj0F7y8ohDQulv3NQOZf0JawV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766517442; c=relaxed/simple;
	bh=poOoKvcO3Us3c4TUKHnMQxB/eLRcmFk1ClRZt9EbPKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OHK7uFLbG4ReJT0rVNh8FQKZhsUNINyHJmW6OiyrLzhzmwfvxZIOwVxz/iJOzc6K14LvV9fxkAYju9HI1C52sw7FqXM1iYlKLvT0wtV8k1OPAbQwMfGUUa/dAmfsiYO9A8rrkKuepJjG60yzxLmuK0NxVLn9qp4w168Q9aSobYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aZTexvGc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qdKIvB1I; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766517439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BPaf7cvMeUb+WR/4ptWdXDyfo9zJ3Ha3IyxL3hD0Trc=;
	b=aZTexvGcmjFuOi98jPIYS3XHAOboQaDH+B7VCmh5mEaRNOVm9DHVs1FXVCcVCPfBDH1ZHQ
	ucVh+8WN77le7TGU54bbf478ovLUqCb8MrXWyie3M6Lqh9XwjcByvgY3M++VKyRP6vV0h7
	cYPKby3k8hu1nJWT9zETfKR4srjnM7s=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-uob9OYsJMEWRjZyguEJuTA-1; Tue, 23 Dec 2025 14:17:18 -0500
X-MC-Unique: uob9OYsJMEWRjZyguEJuTA-1
X-Mimecast-MFC-AGG-ID: uob9OYsJMEWRjZyguEJuTA_1766517437
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a0d59f0198so70088735ad.1
        for <linux-pci@vger.kernel.org>; Tue, 23 Dec 2025 11:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766517437; x=1767122237; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BPaf7cvMeUb+WR/4ptWdXDyfo9zJ3Ha3IyxL3hD0Trc=;
        b=qdKIvB1ITZj+I41PiDRQhgxTarJQd+ryZFHlMOHuUWEztk8+nYuNdRdoTmU7mUsHcY
         VcPjkruMVlXnsXs7Zqh3EtyEYDQHBs1oJMv2mwYhmJWSV4/dRum4bzNlAqz6IectL216
         mPOFyslIx160A3uNLEZfxSwOEAg35CFwX4o6oj59q4Sf1QcSnudGallSP58fNJcoDnbD
         XZ2ZHxf9ATD14EX9vGGJiDmUOkVjzCQH4ZT9L8+E32vRJdvefLGaGSyU1bQ2R1RtJztr
         uMIbiEM5IpofyjwhRGRKxO78MrX2GyBdM+F9Ag6XK1fjWqxXm7NVD2TzWd74fNSY344Y
         IhAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766517437; x=1767122237;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BPaf7cvMeUb+WR/4ptWdXDyfo9zJ3Ha3IyxL3hD0Trc=;
        b=an+Vb0DGO4k1rCKVHn6FWuyHVcxz955grbKG//uM5RWCYdV8NNwSS7WcT4QGushX05
         zeNJ2X5pBcZC9QvjcqmHUWK4lM1IB3dd/4pHke2JNvIaK/tQ1DWqn9DXUAHIHP1c7mKn
         GGXIGhSWoZHVVYjoMu5K4NT+inH9SsWZmxjWLU7NIPqmJLeq5MhNPcWTpey/dkvS5muE
         pSAG2BjwDbBYFw+3RnTnwmf9IZ7w7x96Aar8eCHU/u2YOL4fQsg7q2uPZwwrkd8CPCYT
         1lSlROZ55mQOAx6IPd9tYpeMyIwWLbEbIb1zccx9hZYnlW9Hr8WwCrQRLjgYbrd9WH0A
         uUFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXW4iFwj0WZDQf4fZjcZso6dCYGmFMAh0d/7F9OyWZknENxIxu/NUUQMhEQRLnW6Vksg/VDVi8QaNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFOzzBnfqxLu36p0P7cfR3e7+xzSIt5eeIt4/2Z3s8Cpy1jrGW
	4/nnK2gQUbQQIjj3zQntJ6RWLgClQeKYoHPCU2cSkrT/9swuvE7juJXWxhSLaqFz1JbThHZFrXZ
	/TvZI97udP5zZrsNVP13whOATJZk0xd3xVQ6knJYIkc7UnVo1Hf7LRbP5r3n1sg==
X-Gm-Gg: AY/fxX7Rk/I8Orl7bQjtT6d1/k+cGUQ6IlhuGXXtIynmipnP/Gj7gCy4zpOgBCHXGNO
	iuDys3Q+YRCQsRIl/KdUzGcmUMUOyoeVJtFPDVr4EEMFthTtW9QgpYp2Axot+4W8c1XsF9Gey94
	Fod+BEyOog93UbZOWvqQKWcx1El4oWfUiQO5H1/VhNUUpZqhZcbhNRTJyytJlAiT0ZnuF3GlSYx
	zvn8nv+qUG2FM/QVzX8wOsb8SecvgkJBefzObcOW0Sji7iZV6O0s0lK9Tz228clOD7asDd9djTH
	8uVW/O5oUPFvSm9ix46AhSH4/U9eT30FEI2ZyDS60DyL0mSyKB3oVyDAutkSZaDjgWb0VEGD2Za
	Mz9sp7rLpWw==
X-Received: by 2002:a17:902:e748:b0:295:738f:73fe with SMTP id d9443c01a7336-2a2f2732287mr152444635ad.30.1766517437277;
        Tue, 23 Dec 2025 11:17:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWcWm65pg63KuHNSK7FvILIyANZhLme9Kp0jYEf3fR0k1Qze2WHIz7yDWuBwgWdMwAF/9U/g==
X-Received: by 2002:a17:902:e748:b0:295:738f:73fe with SMTP id d9443c01a7336-2a2f2732287mr152444145ad.30.1766517436635;
        Tue, 23 Dec 2025 11:17:16 -0800 (PST)
Received: from localhost ([2607:f2c0:b1e4:8e00:640b:e13f:5257:9d78])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2a2f3c666casm132973425ad.3.2025.12.23.11.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 11:17:16 -0800 (PST)
Date: Tue, 23 Dec 2025 14:17:12 -0500
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
Subject: Re: [PATCH 3/8] rust: pci: add {enable,disable}_sriov(), to control
 SR-IOV capability
Message-ID: <aUrquI3X68Ilmebh@earendel>
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
 <20251119-rust-pci-sriov-v1-3-883a94599a97@redhat.com>
 <20251121232833.GH233636@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121232833.GH233636@ziepe.ca>

On Fri, Nov 21, 2025 at 07:28:33PM -0400, Jason Gunthorpe wrote:
> On Wed, Nov 19, 2025 at 05:19:07PM -0500, Peter Colberg wrote:
> > Add methods to enable and disable the Single Root I/O Virtualization
> > (SR-IOV) capability for a PCI device. The wrapped C methods take care
> > of validating whether the device is a Physical Function (PF), whether
> > SR-IOV is currently disabled (or enabled), and whether the number of
> > requested VFs does not exceed the total number of supported VFs.
> > 
> > Suggested-by: Danilo Krummrich <dakr@kernel.org>
> > Signed-off-by: Peter Colberg <pcolberg@redhat.com>
> > ---
> >  rust/kernel/pci.rs | 30 ++++++++++++++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> > 
> > diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> > index 814990d386708fe2ac652ccaa674c10a6cf390cb..556a01ed9bc3b1300a3340a3d2383e08ceacbfe5 100644
> > --- a/rust/kernel/pci.rs
> > +++ b/rust/kernel/pci.rs
> > @@ -454,6 +454,36 @@ pub fn set_master(&self) {
> >          // SAFETY: `self.as_raw` is guaranteed to be a pointer to a valid `struct pci_dev`.
> >          unsafe { bindings::pci_set_master(self.as_raw()) };
> >      }
> > +
> > +    /// Enable the Single Root I/O Virtualization (SR-IOV) capability for this device,
> > +    /// where `nr_virtfn` is number of Virtual Functions (VF) to enable.
> > +    #[cfg(CONFIG_PCI_IOV)]
> > +    pub fn enable_sriov(&self, nr_virtfn: i32) -> Result {
> > +        // SAFETY:
> > +        // `self.as_raw` returns a valid pointer to a `struct pci_dev`.
> > +        //
> > +        // `pci_enable_sriov()` checks that the enable operation is valid:
> > +        // - the device is a Physical Function (PF),
> > +        // - SR-IOV is currently disabled, and
> > +        // - `nr_virtfn` does not exceed the total number of supported VFs.
> > +        let ret = unsafe { bindings::pci_enable_sriov(self.as_raw(), nr_virtfn) };
> > +        if ret != 0 {
> > +            return Err(crate::error::Error::from_errno(ret));
> > +        }
> > +        Ok(())
> > +    }
> > +
> > +    /// Disable the Single Root I/O Virtualization (SR-IOV) capability for this device.
> > +    #[cfg(CONFIG_PCI_IOV)]
> > +    pub fn disable_sriov(&self) {
> > +        // SAFETY:
> > +        // `self.as_raw` returns a valid pointer to a `struct pci_dev`.
> > +        //
> > +        // `pci_disable_sriov()` checks that the disable operation is valid:
> > +        // - the device is a Physical Function (PF), and
> > +        // - SR-IOV is currently enabled.
> > +        unsafe { bindings::pci_disable_sriov(self.as_raw()) };
> > +    }
> 
> Both these functions should only be called on bound devices - the
> safety statement should call it out, does the code require it?

Yes, these functions are in the Core device context that inherits from
the Bound device context, which guarantees that the PF device is bound
to a driver. I have added a note to the SAFETY comments.

> 
> Also per my other email SRIOV should be disabled before a driver can
> be unbound, this patch should take care of it to not introduce an
> dangerous enable_sriov().

Thanks for your review. This has been addressed in v2, which disables
SR-IOV before remove() when a PF driver opts in using a new flag
sriov_disable_on_remove, which is set by default for a Rust driver.

Further, enable_sriov() is prevented during remove() using a new
flag inhibit_enable in the pci_sriov structure that is set before
and cleared after the PF driver is unbound from the device.

Thanks,
Peter

> 
> Jason
> 


