Return-Path: <linux-pci+bounces-42858-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA46CB0C89
	for <lists+linux-pci@lfdr.de>; Tue, 09 Dec 2025 18:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F5D6306902E
	for <lists+linux-pci@lfdr.de>; Tue,  9 Dec 2025 17:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968962FFFAC;
	Tue,  9 Dec 2025 17:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N4xS3nke";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kBalvsA8"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9145946C
	for <linux-pci@vger.kernel.org>; Tue,  9 Dec 2025 17:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765303159; cv=none; b=rK0cFOOO0U4tmoPMfMfYlqidRO9KBFdCWXiupk0WIfG8g90eEgx5YcGGE2IZyqHiR3CkZOKKO7Azb0H+cbH8OBC+pp62zx/Z2oPTbwzm4RJbQPV6TIu+yYBo9W72m3fkNImfWmU7Y1V1x/CJEk0lFAGjRbAZVakTKMH5oRDESb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765303159; c=relaxed/simple;
	bh=bA0wuiy1d/JjgUyW5FUV9b+iMg8924V36lmVig/owYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fHKsCAjCKKL9xELjKl69fWcmVcyo9dyg5WeCe6VqlOilr2uFCr62nmMk0osOLQ9gFWQDk7khuQt9Ryzsa9uJmY4oDySMlaU0ZUcVTOZZP2tbcg08LD04e7i2v7b7ekz0QzvUwFbiWXMwLrxkcke9vGsYasw3OgPAHdu2kACoYeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N4xS3nke; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kBalvsA8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765303156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d40vUR++1qaOFZuFdSMGSKMwO2iDcXUS86cXZ2oik34=;
	b=N4xS3nkeOYxWFL363Q8T5QJ8KIrPwkwcxF2n72iN21K+HZu6NV+J0GC2+TOHQOW5CJ5NJr
	LpgN0GnbS3597d+kuLBNmIbnvWaKB3Il2/DnCntxWsZ14w74LY62FN4K9Rl8+TLoqNOmpA
	hWNuPqnFNTwP1t8nX48RghPvpUiEXm0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-GhSM7d1kPdupMIduBQdUng-1; Tue, 09 Dec 2025 12:59:15 -0500
X-MC-Unique: GhSM7d1kPdupMIduBQdUng-1
X-Mimecast-MFC-AGG-ID: GhSM7d1kPdupMIduBQdUng_1765303155
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-88051c72070so116931466d6.1
        for <linux-pci@vger.kernel.org>; Tue, 09 Dec 2025 09:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765303155; x=1765907955; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d40vUR++1qaOFZuFdSMGSKMwO2iDcXUS86cXZ2oik34=;
        b=kBalvsA8FDW2zVLLAmQZE/R3/buxGOiu8hX/LQUZNSeIcTUqXgooqDOIPSV/H8b8rF
         etXJjOl7xSj8EOgvt/0aECHClCeGZn/xGnNvkIbNHb4nZo94MV8XP2tZvOEyvJz+E5FF
         /0FlPOf5t+jJhE84H6NuLSEplgZKpBruQ8HJ2lWHnHyGQuhBfNHXM5BRnex2ZJFajWWQ
         /PeBoepYxaNo6w17pUarzYANVXZ7QhrUgS7FZK3riw//KLiBQjtKmw8af4wD28hkIjp1
         +7Le+Qz0f70kW/Mny6b57+uPrToOaV52LALTQc5Y2JB3t3c2OAtXMnsIUbKTfQ5bE4LB
         5QsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765303155; x=1765907955;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d40vUR++1qaOFZuFdSMGSKMwO2iDcXUS86cXZ2oik34=;
        b=mSqc8xBPYIQLGaynYFE6f32K2KoPlAbEgAdJzlOIbGO0FFrGin9svL4hmictQHgtJr
         sl6GpXfPILZtwGKHbQSesOSNje5PH2mpCD7szIqHxLyRItTcU+OrRHEpnp0fwrxRBV74
         rsTjNSKe+oqMAWGxoybVdUzy1GO+JTFGrUC8NI+IGzNglDGQ9gCkfOHh22MQ8ijbQZq9
         nto8XUlFqoct/bwJLrFmXXw/REx/6xkmygm4OGMNBY6rSe4DHcKjJjejH+GuZp3KUUaM
         uQ0WZdOu+7Jj9G2I6tzfD6+Vk4qoeStJ3o6yzM4EUqX38TaTAis38a+zyunUzkMZIc6x
         QSfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgNoqTYiCEN9+Y81VvtBrRWlzBgv+p8ZcDY4skfZDvJe/LZ5l5TJo70q2sf3H/RpT05qbRdNksMPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE+kBtJZjVqQPQQEu3TobRemkgeMpnmFNjIHCjNNHFK042VgUe
	0pnj1ytZCP/Qhp0hzOQ4hQga8sj3zjw5o5Of3mrqz8Ei8BsI4ckImbXZyapIz9AURL+tVLkgE32
	GScQjGXYYdTZkMO+FgobB6Yu3aeU0uuOQ80TpLx3mldgKv5iTy6L1ytOYzSERpw==
X-Gm-Gg: AY/fxX5ttxpxHDaKZNrK+W/6TvyCHksQim2S2Vfy7Km60HqJLX4cny1iOwCoRNkQXMU
	hkldQ7xvZgICd7l1aHjJ8cJA2UIbi2+vfU7JO2NE/C4NNOxVw+sKqfYDHf8yKrXzs8M+vkE07ol
	PTYA60bawZskMWCYqpNneLn5N60K/MsdOSeS3uUEDgD6TBf+RTJ+oS40p8xIXfgw+AX2Mn1T4ok
	yIbz3fD7QgK46zUGh8YAgnVpdNBS1GdvNJpH6kQZjwW/+i6nuZ7lNa0OtJCh8nbJ8z3EXt0rSXI
	drn3LdKIvI1CxEFSIzOdhpw2+8oT+jyIfm7cLe/DCiIq6y3VADaehspF2r9C8bmn4169reA6F3K
	RxsLP715lvQ==
X-Received: by 2002:a05:6214:2422:b0:87f:b2d8:6020 with SMTP id 6a1803df08f44-8883dbf6cb3mr214779376d6.38.1765303154859;
        Tue, 09 Dec 2025 09:59:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGW59vhBVoyXlKa64sg3W6fFSnkL9S5Jg3icr+p7GG1on3Wtf7TpWh8CqQWJvDh6TJDBZ4C/Q==
X-Received: by 2002:a05:6214:2422:b0:87f:b2d8:6020 with SMTP id 6a1803df08f44-8883dbf6cb3mr214778486d6.38.1765303154269;
        Tue, 09 Dec 2025 09:59:14 -0800 (PST)
Received: from localhost ([2607:f2c0:b021:e700:1a3d:b7ef:5d4d:bee5])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-888287a5518sm127224716d6.31.2025.12.09.09.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 09:59:13 -0800 (PST)
Date: Tue, 9 Dec 2025 12:59:13 -0500
From: Peter Colberg <pcolberg@redhat.com>
To: Joel Fernandes <joelagnelf@nvidia.com>
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
	John Hubbard <jhubbard@nvidia.com>, Zhi Wang <zhiw@nvidia.com>,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 3/8] rust: pci: add {enable,disable}_sriov(), to control
 SR-IOV capability
Message-ID: <aThjcZrhbe8Ysgab@earendel>
Mail-Followup-To: Joel Fernandes <joelagnelf@nvidia.com>,
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
	John Hubbard <jhubbard@nvidia.com>, Zhi Wang <zhiw@nvidia.com>,
	Jason Gunthorpe <jgg@ziepe.ca>
References: <20251119-rust-pci-sriov-v1-0-883a94599a97@redhat.com>
 <20251119-rust-pci-sriov-v1-3-883a94599a97@redhat.com>
 <20251207063355.GA213195@joelbox2>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251207063355.GA213195@joelbox2>

On Sun, Dec 07, 2025 at 01:33:55AM -0500, Joel Fernandes wrote:
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
> 
> nit: Why not use `to_result()` here?

Thanks! I queued `to_result()` for v2, from an unrelated review [1].

Peter

[1] https://lore.kernel.org/rust-for-linux/b8234f181d35b21a3319b95a54b21bdba11b8001.camel@redhat.com/

> 
> thanks,
> 
>  - Joel
> 
> 
> 
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
> >  }
> >  
> >  // SAFETY: `pci::Device` is a transparent wrapper of `struct pci_dev`.
> > 
> > -- 
> > 2.51.1
> > 
> 


