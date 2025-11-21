Return-Path: <linux-pci+bounces-41890-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AE0C7B067
	for <lists+linux-pci@lfdr.de>; Fri, 21 Nov 2025 18:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3ECF74F4B94
	for <lists+linux-pci@lfdr.de>; Fri, 21 Nov 2025 17:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C03A3502B1;
	Fri, 21 Nov 2025 17:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fYoh/0Sm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BXPi5SIh"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC15734E74B
	for <linux-pci@vger.kernel.org>; Fri, 21 Nov 2025 17:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763744762; cv=none; b=m9GJmtA7e6YdArihJwyYgKVZ9B24x779cV2P0ZfjDn5ck4oBYuYyD6Z3cfdCDU83XJJ0+l8fL0CPFCjIRg9/Q7AYcKIbU3bDbwSqBr+xeNwEoJEQWdgPXJGrRd9a+jDryuHY5LBjbyNpjT9NnluN6O8nxju4qD/oj0dYJ1XSDd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763744762; c=relaxed/simple;
	bh=tmekbxR8wc1I7t6Q6VZZ1XIp/NWvYZvJ1hM4SKb77K0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=miriF77X2DsSdD32tJhNqs/elaRNCz5zXXSfXhv0Y54m1YO5+bJmi5+z3KlTFeQT/Dsl/DKKvoWJz8/WKNV1P55wjjau0SyyT8jTOCUwFQ26zEtYiV/ZbfSBDyCRvJM8FZuRFdoNWSl5PXO8rortxsa/aL06+5RoLF7/qwOkQFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fYoh/0Sm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BXPi5SIh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763744742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pcee4/A8vRRbWn/DfexDhknhgtkMbBICYwtyayyfJMY=;
	b=fYoh/0Smgu+8FbluM5V5uvvNta+pCxNjApmIwkmGvXak7+e70jjAxRM0BvOK5+52RpuitA
	kMItzbqC4hvjEcwBeW3DNZpHOMwlAUDnSO6RSeoaFr84ocwNIrMkuhSynxwTmpcCO+V5lT
	Wn4R4BvT2M+wHJOLP53wrtC/fbuAp/g=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-ARSfAVuPObCnfbzpwOeOcQ-1; Fri, 21 Nov 2025 12:05:13 -0500
X-MC-Unique: ARSfAVuPObCnfbzpwOeOcQ-1
X-Mimecast-MFC-AGG-ID: ARSfAVuPObCnfbzpwOeOcQ_1763744713
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8826a2b2d9aso67331566d6.1
        for <linux-pci@vger.kernel.org>; Fri, 21 Nov 2025 09:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763744713; x=1764349513; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pcee4/A8vRRbWn/DfexDhknhgtkMbBICYwtyayyfJMY=;
        b=BXPi5SIhUDHMl9uA/4qvsmhZ/PPEHjwxBTvyyCwngiTOlCOpUCivgMOWF1zvDA1P+r
         eb+JYu3rMiiDSEhxU2cUA2lBFe1hooNf1DqdupgMIDvS7MckWvDfRPwhnzK9NxPjoYFF
         gfy3Mlwmbtj4Ln6KwSxObZGyyaRBjge5NbLPTqt7Q92pKHfQV58PCO63QSFoZzW+ouIz
         UokFxynGobwrvgwLqSH0BmHM9sPQlQoKnwN2N9l53TkysFGo1jt6TcMnTcJsBNdt0MBT
         xG4OWnhU+at7o48lOBHt9mWksheFFo9x6oS9pUwdSW3YMvRrwRQCNyei4u/y+JxyVc77
         siSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763744713; x=1764349513;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pcee4/A8vRRbWn/DfexDhknhgtkMbBICYwtyayyfJMY=;
        b=d0ea5no1XMIrTsVlakJbjM/rC6vSX5Ehc7ZPl9FsqTpz/2LIFN0Rll2+DvTKGiaift
         Cby1DMKrqFaGyl5QbLLuKgo4gfDmnkivLDPGnubT98tv4nx1m8UFneuuJyLFpI2pRZih
         Ny1oo2RNyapKqA41EYLanqopBYNc4Sev9P4+t+x1WmCRVotMCYNVyLTCzuRiANjHVvhC
         7wyLECfKw5sxkxt65GOq9UofozJW26TztAibYBs/CIxvs7F08nvbe3+2iEkYVITQ5Co/
         AX+WdqahHgXmi3ymaT/YQacdptHl5lr6tNxlM1gbhV5mZJ7AnPhfCQAazqNlZgOEs69R
         NiyA==
X-Forwarded-Encrypted: i=1; AJvYcCVDE2vE79YqyRaIUIGJacdp3OiVCQ4BtZyJoO8vUg6K7bIMS7XM38op3mNYhikvR6L70ZpQnuxIoXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpNf0Y0CCk8R1F7Qcvm/qxrdW0SwKPgWF9AOnFRgCTqKdMD5sh
	7Vy/UsZIxEvCrMgQf7eWBCguv0bKonpn+ftkXB2L0nOBtSdkvjSThPuwjzu6HvpYY9Fxw/5G+jE
	Fy5j/p0zj4QsTeieGA74pSehlipGLoaiY9lNNxx5W2rqJ65oU6YZtaSZyCb38XA==
X-Gm-Gg: ASbGnctu9tp4CdQVqI6CtbZMfzaDPAxK+KNT2aVqZAauaD0DzAuLB0qJO1ry64DeHLE
	MzabLtiHoSlZyOaGNJcyhNMMfBhIkaLVdhiKiGRqrCQwErGXWCPNSSxSz/6zwmd1gWC/MgjMxCD
	XSqTLLIGqLeE8XVHAkr6KR8aOTxjN6HQntXmBTvhIywrZsZmfgN3Wvd2WzMvWC8bReMdJF1VrHN
	hE8l/nUYtml5PcmwCurBsLOo/kKoKBY524i9WNc9c8+swQJspJjXfbt+h53cWik6qB9z3kpsXri
	zmguocBXngxB8tUNLzBF/tTIFq8+9vSBhTqOHA86SqY19nk9DQfC2nZLsa+6nP6IUAAETdYltpx
	TsRu9pmqRuA==
X-Received: by 2002:ad4:5aae:0:b0:882:6cd3:7f64 with SMTP id 6a1803df08f44-8847c525dbemr42276046d6.44.1763744712756;
        Fri, 21 Nov 2025 09:05:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGLRcV7K0Bhq8TE5Bm7cm2cdZ/VYsJmCfeBsteGuVKLE0o2xsrM2bCCmTKOW8kK51KJ84vQ/g==
X-Received: by 2002:ad4:5aae:0:b0:882:6cd3:7f64 with SMTP id 6a1803df08f44-8847c525dbemr42275096d6.44.1763744712063;
        Fri, 21 Nov 2025 09:05:12 -0800 (PST)
Received: from localhost ([2607:f2c0:b141:ac00:2fb1:d1df:b122:3b2c])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-8846e446a06sm43506306d6.2.2025.11.21.09.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 09:05:11 -0800 (PST)
Date: Fri, 21 Nov 2025 12:05:10 -0500
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
Message-ID: <aSCbxjbNJPPy2NVd@earendel>
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
 <aR8t0XdZVyN-0mak@earendel>
 <20251120203444.321378c2.zhiw@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120203444.321378c2.zhiw@nvidia.com>

On Thu, Nov 20, 2025 at 08:34:44PM +0200, Zhi Wang wrote:
> On Thu, 20 Nov 2025 10:03:45 -0500
> Peter Colberg <pcolberg@redhat.com> wrote:
> 
> Hi Peter:
> 
> I met some errors when compiling on driver-core-next branch, you can
> fix those in the next spin.
> 
> Fixes:
> 
> diff --git a/drivers/gpu/nova-core/driver.rs
> b/drivers/gpu/nova-core/driver.rs index ca0d5f8ad54b..730e745cad63
> 100644 --- a/drivers/gpu/nova-core/driver.rs
> +++ b/drivers/gpu/nova-core/driver.rs
> @@ -49,6 +49,7 @@ pub(crate) struct NovaCore {
>      ]
>  );
>  
> +#[vtable]
>  impl pci::Driver for NovaCore {
>      type IdInfo = ();
>      const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
> 
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index d6cc5d7e7cd7..2d68db076f92 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -292,6 +292,7 @@ macro_rules! pci_device_table {
>  ///     ]
>  /// );
>  ///
> +/// #[vtable]
>  /// impl pci::Driver for MyDriver {
>  ///     type IdInfo = ();
>  ///     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
> 
> The code in the examples should be able to compile.
> 
> You can enable doctest by:
> 
> CONFIG_RUST_KERNEL_DOCTESTS=y
> 
> Then:
> 
> impl Device<device::Bound> {
>     /// Returns the Physical Function (PF) device for a Virtual
> Function (VF) device. ///
>     /// # Examples
>     ///
> 
> snip
> 
>     /// ```
>     /// let pf_pdev = vf_pdev.physfn()?;
>     /// let pf_drvdata = pf_pdev.as_ref().drvdata::<MyDriver>()?;
> 
> I saw this part is not able to be compiled.^

Thanks Zhi, I applied all fixes.

Peter

> 
> Z.
> 
> > On Thu, Nov 20, 2025 at 08:32:13AM +0200, Zhi Wang wrote:
> > > On Wed, 19 Nov 2025 17:19:04 -0500
> > > Peter Colberg <pcolberg@redhat.com> wrote:
> > > 
> > > Hi Peter:
> > > 
> > > Thanks for the patches. :) I will test them with nova-core and come
> > > back with Tested-bys.
> > 
> > Perfect, thanks Zhi.
> > 
> > > Nit: Let's use "kernel vertical" styles on imports. [1]
> > > 
> > > [1]
> > > https://lore.kernel.org/all/20251105120352.77603-1-dakr@kernel.org/
> > 
> > Thanks, done for patch "samples: rust: add SR-IOV driver sample".
> > 
> > Peter
> > 
> > > 
> > > > Add Rust abstractions for the Single Root I/O Virtualization
> > > > (SR-IOV) capability of a PCI device. Provide a minimal set of
> > > > wrappers for the SR-IOV C API to enable and disable SR-IOV for a
> > > > device, and query if a PCI device is a Physical Function (PF) or
> > > > Virtual Function (VF).
> > > > 
> > > > Using the #[vtable] attribute, extend the pci::Driver trait with
> > > > an optional bus callback sriov_configure() that is invoked when a
> > > > user-space application writes the number of VFs to the sysfs file
> > > > `sriov_numvfs` to enable SR-IOV, or zero to disable SR-IOV [1].
> > > > 
> > > > Add a method physfn() to return the Physical Function (PF) device
> > > > for a Virtual Function (VF) device in the bound device context.
> > > > Unlike for a PCI driver written in C, guarantee that when a VF
> > > > device is bound to a driver, the underlying PF device is bound to
> > > > a driver, too.
> > > > 
> > > > When a device with enabled VFs is unbound from a driver, invoke
> > > > the sriov_configure() callback to disable SR-IOV before the
> > > > unbind() callback. To ensure the guarantee is upheld, call
> > > > disable_sriov() to remove all VF devices if the driver has not
> > > > done so already.
> > > > 
> > > > This series is based on Danilo Krummrich's series
> > > > "Device::drvdata() and driver/driver interaction (auxiliary)"
> > > > applied to driver-core-next, which similarly guarantees that when
> > > > an auxiliary bus device is bound to a driver, the underlying
> > > > parent device is bound to a driver, too [2].
> > > > 
> > > > Add an SR-IOV driver sample that exercises the SR-IOV capability
> > > > using QEMU's 82576 (igb) emulation and was used to test the
> > > > abstractions [3].
> > > > 
> > > > [1] https://docs.kernel.org/PCI/pci-iov-howto.html
> > > > [2]
> > > > https://lore.kernel.org/rust-for-linux/20251020223516.241050-1-dakr@kernel.org/
> > > > [3] https://www.qemu.org/docs/master/system/devices/igb.html
> > > > 
> > > > Signed-off-by: Peter Colberg <pcolberg@redhat.com>
> > > > ---
> > > > John Hubbard (1):
> > > >       rust: pci: add is_virtfn(), to check for VFs
> > > > 
> > > > Peter Colberg (7):
> > > >       rust: pci: add is_physfn(), to check for PFs
> > > >       rust: pci: add {enable,disable}_sriov(), to control SR-IOV
> > > > capability rust: pci: add num_vf(), to return number of VFs
> > > >       rust: pci: add vtable attribute to pci::Driver trait
> > > >       rust: pci: add bus callback sriov_configure(), to control
> > > > SR-IOV from sysfs rust: pci: add physfn(), to return PF device
> > > > for VF device samples: rust: add SR-IOV driver sample
> > > > 
> > > >  MAINTAINERS                           |   1 +
> > > >  rust/kernel/pci.rs                    | 148
> > > > ++++++++++++++++++++++++++++++++++ samples/rust/Kconfig
> > > >    |  11 +++ samples/rust/Makefile                 |   1 +
> > > >  samples/rust/rust_dma.rs              |   1 +
> > > >  samples/rust/rust_driver_auxiliary.rs |   1 +
> > > >  samples/rust/rust_driver_pci.rs       |   1 +
> > > >  samples/rust/rust_driver_sriov.rs     | 107
> > > > ++++++++++++++++++++++++ 8 files changed, 271 insertions(+)
> > > > ---
> > > > base-commit: e4addc7cc2dfcc19f1c8c8e47f3834b22cb21559
> > > > change-id: 20251026-rust-pci-sriov-ca8f501b2ae3
> > > > 
> > > > Best regards,
> > > 
> > 
> > 
> 


