Return-Path: <linux-pci+bounces-41794-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EDAC74E08
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 16:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2A03C34BD7A
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 15:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B104734DB40;
	Thu, 20 Nov 2025 15:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FCNkk9Zi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="E5tGr66J"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DD22F261C
	for <linux-pci@vger.kernel.org>; Thu, 20 Nov 2025 15:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763651045; cv=none; b=S2Y6q9L7ZYew54Lx+/SgDGjDgfHFw/nmMELFb6xIhXfM19qT8tBnfakiW2gVf/EkBpU9a2ZHkqBea4RxCcJ0WdD3UoD9vTTG4tAzOyU+fBgQ8nWfDALzpIVqdyZUWLIgP0NR+Ulr15OfNaFnENNHq2p6HU0CVrjLJyVmaG2DT1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763651045; c=relaxed/simple;
	bh=NQUtKdB99qdvTUHW7TfJaCBvDQOzecNF+71V0RM1t14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HPkR3/R9sdgIGBPZfnU7cPkgOjOGtLrx+jfjegHoTpgP7N3XOhjNUWx9JvMcwMEkT14SDr+5MdQDoKYPIP5HGreOnOLgJ5ocXm0RyLjDuYqg6Pn6Mxv6XaQBqQPTuugBeCsSXxN4vJxdWdjffdGmypD63RHeLMTqAbBYF1cfE7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FCNkk9Zi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=E5tGr66J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763651034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9DPCqHD/YaWcGoC8V0FZZxIZ6OMyIBB16RRDodVfkWQ=;
	b=FCNkk9ZizzMDTTPWHOPTJNVfkyisGfp0KBZiEjQmDH644oSLOsABUuRjSD31YVK4H83kC2
	TVXdwN6y2HW9+qjIMfoVMCs0KxISOx08rjJhqUmmNVzMOC/aT44lDMyaiGo2cvn62BFa3p
	oa2B0BiOs00KjkiTUf1kBPgITslNdcQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-xDHuoOKOPaqzwava3JSMUg-1; Thu, 20 Nov 2025 10:03:52 -0500
X-MC-Unique: xDHuoOKOPaqzwava3JSMUg-1
X-Mimecast-MFC-AGG-ID: xDHuoOKOPaqzwava3JSMUg_1763651031
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b234bae2a7so292347485a.3
        for <linux-pci@vger.kernel.org>; Thu, 20 Nov 2025 07:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763651031; x=1764255831; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9DPCqHD/YaWcGoC8V0FZZxIZ6OMyIBB16RRDodVfkWQ=;
        b=E5tGr66JjH+4D8kZjI2Oiu5vZWtp4mydMmkLsAbTjAsYD9FIZETbvpPy8ZyIoYIehu
         Hjxr/TwNdh+6mGm5ZIGp6j5TUAVyZiGZdU9CV2H+Ria7PDEo5K0Pf17tEVV5dsIu98zF
         Y/MtqBEbyQ7smk/vhVP0WBlXrx5Wz18MUWLlfXYydOwTY52EUedtABF3jNih4YKy9fQA
         HVTicIzb4Gv/2zrjPgfAS25uOchacLd+1FWnByf30ma2nnyWkB0nRicyEtheVn4NwSWq
         lvbs6gyMcyKAqin+Zb/pKUFaZsHbgIQXU9YpQQGLtEdREnk0Z7Ql7IsPskQUQKNic7Z9
         +YKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763651031; x=1764255831;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9DPCqHD/YaWcGoC8V0FZZxIZ6OMyIBB16RRDodVfkWQ=;
        b=DedaKUnfZhnwffa/OwWfQHVGPa2md8kvDeptVzHuRlZeozkKJ/mPYF+H61yedlldWD
         KOWFfjVNKCCm+WqCpggFBZjN18ybUW4iJxof75HR5fzuSMgf5IQWY5egP48oq4eyneVN
         enhFiRCyIhVUq9U1+Do8wdiJHOGDKa7uUSfu+p1GFLJlR5lc4JeQYmue5vL+EEZHaHd1
         2Dgf0nWicVdXrrNzlDvR+pqRCsIOgl3RMaRi0r81gt3u/ZEwYLysm6+yt2rds4qna9Vz
         gpi+tfEqdFK6ozQyFfRtZvyg7Aw4dCdx4HfKMotVeN1HVvcwPYpM7idi/kSpkCarotnM
         uPXw==
X-Forwarded-Encrypted: i=1; AJvYcCX3v+93+q/zOutU5lVczYBETuNcJJYO4S1wBwOQlfP5E3Kxi70LiiAYppDq+cGAWm73PH58KYKNmCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgDeSc0MOiwALVuzmUWG98Ony77kc65wYabsAEFvp6supskg7d
	vr74y/ryJd63t9hfZcgWnBKQXWTDHXKfB4V3O+QzTrICYU+2KI5y60Zo4zWd15rEea2BLxJbaBr
	IZtDiW3kcRtpuwEMLx4YicmB1nqOgW3ko44jZ9Xtvxdjtz+rCqU1GKa9VV5GUfg==
X-Gm-Gg: ASbGncsGlwC5ZN0ymAaltzARpODflDKG757gU1ZCBczjCDjxMiwtAD9UMDsGzj43FlC
	zZdjRxHkK5kyXxG37FmpdKBPZjKK78k8YegZu14qaI20VYbG2An5OvNb+o0iI1MxaqeuctkdvOE
	MXWMvFSW07XjADfBPIARxMOG73G6GfYc34UugcWHan+p8OjibIvVqhE/uXKeVyGPmmBawIEGwJ/
	ah8rfDqR0Amr4PmT3hHxdjr9K77apZdtdPuj/X6QexHho1+xFTS+Z4kjWlF4j5QNo+TO2rBMVJm
	5h53G4vd2tiHzLzA93sQVfFobY47s6up5Ao21AK+kQ+TUYz8qY0uvYVH0JeffSQ0Wmwmo7CE64M
	VpIG7MFjC
X-Received: by 2002:a05:620a:191f:b0:893:1c7:4b with SMTP id af79cd13be357-8b32f316197mr256303685a.31.1763651029916;
        Thu, 20 Nov 2025 07:03:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGLS/dDFaSkMeWvvtf+oTu95OUr5fOT6MEqwh1eGpLFf0HLa3O3DKfWPSVqAmZHgEJfPkn3Iw==
X-Received: by 2002:a05:620a:191f:b0:893:1c7:4b with SMTP id af79cd13be357-8b32f316197mr256279885a.31.1763651027897;
        Thu, 20 Nov 2025 07:03:47 -0800 (PST)
Received: from localhost ([2607:f2c0:b141:ac00:5cae:3da9:9913:ff7])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-8b3295db58fsm165531085a.37.2025.11.20.07.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 07:03:47 -0800 (PST)
Date: Thu, 20 Nov 2025 10:03:45 -0500
From: Peter Colberg <pcolberg@redhat.com>
To: Zhi Wang <zhiw@nvidia.com>
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
	John Hubbard <jhubbard@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 0/8] rust: pci: add abstractions for SR-IOV capability
Message-ID: <aR8t0XdZVyN-0mak@earendel>
Mail-Followup-To: Zhi Wang <zhiw@nvidia.com>,
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
	John Hubbard <jhubbard@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>
References: <20251119-rust-pci-sriov-v1-0-883a94599a97@redhat.com>
 <20251120083213.6c5c01a5.zhiw@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120083213.6c5c01a5.zhiw@nvidia.com>

On Thu, Nov 20, 2025 at 08:32:13AM +0200, Zhi Wang wrote:
> On Wed, 19 Nov 2025 17:19:04 -0500
> Peter Colberg <pcolberg@redhat.com> wrote:
> 
> Hi Peter:
> 
> Thanks for the patches. :) I will test them with nova-core and come back
> with Tested-bys.

Perfect, thanks Zhi.

> Nit: Let's use "kernel vertical" styles on imports. [1]
> 
> [1] https://lore.kernel.org/all/20251105120352.77603-1-dakr@kernel.org/

Thanks, done for patch "samples: rust: add SR-IOV driver sample".

Peter

> 
> > Add Rust abstractions for the Single Root I/O Virtualization (SR-IOV)
> > capability of a PCI device. Provide a minimal set of wrappers for the
> > SR-IOV C API to enable and disable SR-IOV for a device, and query if
> > a PCI device is a Physical Function (PF) or Virtual Function (VF).
> > 
> > Using the #[vtable] attribute, extend the pci::Driver trait with an
> > optional bus callback sriov_configure() that is invoked when a
> > user-space application writes the number of VFs to the sysfs file
> > `sriov_numvfs` to enable SR-IOV, or zero to disable SR-IOV [1].
> > 
> > Add a method physfn() to return the Physical Function (PF) device for
> > a Virtual Function (VF) device in the bound device context. Unlike
> > for a PCI driver written in C, guarantee that when a VF device is
> > bound to a driver, the underlying PF device is bound to a driver, too.
> > 
> > When a device with enabled VFs is unbound from a driver, invoke the
> > sriov_configure() callback to disable SR-IOV before the unbind()
> > callback. To ensure the guarantee is upheld, call disable_sriov()
> > to remove all VF devices if the driver has not done so already.
> > 
> > This series is based on Danilo Krummrich's series "Device::drvdata()
> > and driver/driver interaction (auxiliary)" applied to
> > driver-core-next, which similarly guarantees that when an auxiliary
> > bus device is bound to a driver, the underlying parent device is
> > bound to a driver, too [2].
> > 
> > Add an SR-IOV driver sample that exercises the SR-IOV capability using
> > QEMU's 82576 (igb) emulation and was used to test the abstractions
> > [3].
> > 
> > [1] https://docs.kernel.org/PCI/pci-iov-howto.html
> > [2]
> > https://lore.kernel.org/rust-for-linux/20251020223516.241050-1-dakr@kernel.org/
> > [3] https://www.qemu.org/docs/master/system/devices/igb.html
> > 
> > Signed-off-by: Peter Colberg <pcolberg@redhat.com>
> > ---
> > John Hubbard (1):
> >       rust: pci: add is_virtfn(), to check for VFs
> > 
> > Peter Colberg (7):
> >       rust: pci: add is_physfn(), to check for PFs
> >       rust: pci: add {enable,disable}_sriov(), to control SR-IOV
> > capability rust: pci: add num_vf(), to return number of VFs
> >       rust: pci: add vtable attribute to pci::Driver trait
> >       rust: pci: add bus callback sriov_configure(), to control
> > SR-IOV from sysfs rust: pci: add physfn(), to return PF device for VF
> > device samples: rust: add SR-IOV driver sample
> > 
> >  MAINTAINERS                           |   1 +
> >  rust/kernel/pci.rs                    | 148
> > ++++++++++++++++++++++++++++++++++ samples/rust/Kconfig
> >    |  11 +++ samples/rust/Makefile                 |   1 +
> >  samples/rust/rust_dma.rs              |   1 +
> >  samples/rust/rust_driver_auxiliary.rs |   1 +
> >  samples/rust/rust_driver_pci.rs       |   1 +
> >  samples/rust/rust_driver_sriov.rs     | 107 ++++++++++++++++++++++++
> >  8 files changed, 271 insertions(+)
> > ---
> > base-commit: e4addc7cc2dfcc19f1c8c8e47f3834b22cb21559
> > change-id: 20251026-rust-pci-sriov-ca8f501b2ae3
> > 
> > Best regards,
> 


