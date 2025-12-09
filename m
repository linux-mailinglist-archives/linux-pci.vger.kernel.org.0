Return-Path: <linux-pci+bounces-42860-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7D7CB0D41
	for <lists+linux-pci@lfdr.de>; Tue, 09 Dec 2025 19:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9082A30C9230
	for <lists+linux-pci@lfdr.de>; Tue,  9 Dec 2025 18:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338822FFFBC;
	Tue,  9 Dec 2025 18:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c8pe1A1n";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mBHvIHnd"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F5D2EE262
	for <linux-pci@vger.kernel.org>; Tue,  9 Dec 2025 18:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765304574; cv=none; b=lI1vOLev8jP9UKS/1SEutbmsGh0/6gKZpqbK+uaOkbjXOsXBQS4FUJL6pgUAgadGYAM4UMT9nrk87RJQqPbCeNBoH7/VtR3pQxk6L70DoG5oWDL+3iJmJxLdlO0jgsljd3jTs4Sq2dVSoBeuwaHFvBYkHtm6xeYLqO70LkSX3J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765304574; c=relaxed/simple;
	bh=EE7wXtjs9EBC1pz96zdtJaDICazZ+qtIBI35mNOiwXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aNmXMnVJxV2fHFyglCy7HqUzZuZrkSb3MOcFEGgXOEKYq4eCA2QWzFpGYj9BErn1XX/jO2x+viGBRM1PVdfxtbn0us76HKan7vx2sfan8WEbfnO3ie14BTSeaxlbwwIrCWXUccPCrfXV6sEBTfhrt9fCEgNSiyxXn6XJ+Myrnlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c8pe1A1n; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mBHvIHnd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765304570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WMOszaFVk9dmDMFq0LvRTh2fbh1Zhs/4RFuYjDJSUZI=;
	b=c8pe1A1nGwyCqWBct88u5gpCknUn5KBS7APJZvdQ1cNSXZwlWx90eq0FSj7uLmPOdSnHhh
	vQdL50GBroeZF1byrVnybJWELaaVGUj0Diw8b0fINNL1rd6/g9SQOILLybH/B2I+odgAwR
	Yhh54vrvzX+N5VKOgEYktpgLV+XgZlg=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-Wm6hq5RRP3KTlcr6SCHOPw-1; Tue, 09 Dec 2025 13:22:49 -0500
X-MC-Unique: Wm6hq5RRP3KTlcr6SCHOPw-1
X-Mimecast-MFC-AGG-ID: Wm6hq5RRP3KTlcr6SCHOPw_1765304568
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7b80de683efso9296384b3a.3
        for <linux-pci@vger.kernel.org>; Tue, 09 Dec 2025 10:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765304568; x=1765909368; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WMOszaFVk9dmDMFq0LvRTh2fbh1Zhs/4RFuYjDJSUZI=;
        b=mBHvIHndRo2/RD1R/K80w3VY8OW8pZr1pNhw/LamSbINatqTKmSOJlVS7/0IUaUJvj
         gwy2vhXefWLxeKdTZsWhHrW+M5yWb4KLyS8BV9IPDzIOsyXk1vOhnUrIcLXp1PYF1rIS
         DQnkTu8ZzPK1PH4Z7/D50zw4k+f3a5yQZhS+EWBzlle8Nc/8vNp+NiocH9s13ngllybI
         1M0uVgDbZErT51mtK7WzZeSfSpuX0KbFt15CIVVHVeJ1VxbvrLMpxXC3Dxg2sc+vnz97
         /QFe1bm5+QDCmN23VHDPpE+FXP9EKPMQWzf/urbXYfNWYaJTNuQrIK9O4qTmb/rTFmEa
         BWvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765304568; x=1765909368;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WMOszaFVk9dmDMFq0LvRTh2fbh1Zhs/4RFuYjDJSUZI=;
        b=dy3hcJ3IDmq91G3oFXlj++hpqTcMIbwb7rZKIuQItVCqlGzvuqijWToJ536DvKEWBL
         nGAaMyFlJUMJz3WKHTZzeR1j2MJ6xXNem4iqbd+2ronUybUsRUZMjQzFm3iuZ30BbrNf
         y9inkK7bJxepuZyiN0svgNAyM+NuLSsNPaUC/H/xNo+0jSva1wcXBBcPZpYcdI9w3+pg
         KA+EIxujZXyw0NO2nhB0IrR4Yw9jeYqxF20k1nfQc7ENjVxBXjkUGasfKfB2nmvOa4V0
         7r8T9Evz4s/vjGLbbUg7ooUpraDPDZDcic8gXhc4SS8kas+bydGPJ7uy+uW5tvUwUeN9
         7a9w==
X-Forwarded-Encrypted: i=1; AJvYcCWAIS9BMGTmCqKcj26fTRiPP2Jmu20HMCrmdM1+UubwVVLhre3Q+O/sb/hq/EgW1VWqKmagb1g2QMk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9ysx9kH/c8rfFCxhE+X5SFoRRyG7vLApD6ZaszlndpN11ayg9
	JW610w55pgeZSFSZCr+orcbaKh9eHMZnkCD2kivBCakDMK7bTbs+f/cCs7b/+nO7j+dOdoDWUbd
	QTQb2pcO4jwgqEhJ12CUPp/zMi6ZgHiVTVNrFoiWuW1GAJW5aoy8oiVgSr6oA1Q==
X-Gm-Gg: ASbGnctLUCwVTT0dZkqTSpOoVCbU5TvmRvO0ej1Rz/SKIQLNh+TnYGXlxN2MXzvJyT6
	5Q4DETKqECf12iIwk8a5pGbeNF9sQ+5TjqT2ygAFuQ8QVaZxqftZxgzLoJSQ1Enj+tb5dA1ZjS6
	ww5StRUZKZXKZwJRd8D8kEyjl8OQ8kYcNkTC+qu2mInXPxPXh7tJl/3uwCNRbQVqbzVXiW7dMey
	Dms829ZH98HbF/A3l+MkcIRgzZUxr9j9oTqhg80EiT4KnJ4zlXUT+A09Rn5jd8k4FQEIWAO6D7r
	RnG34edaJI8q7lV1aVq0SjOlVLATFv4n5QjqwKBJymlMBJihkk2hox4ebAlcn3KB/q0jYWqocS/
	WOL8NfBTxAQ==
X-Received: by 2002:a05:7022:401:b0:11d:f464:5c97 with SMTP id a92af1059eb24-11e032d86admr10001670c88.39.1765304567955;
        Tue, 09 Dec 2025 10:22:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFDwilm5GiGAv7e/m6VA+/VyYDDyNis+KEVWPuuPoKnNewKlxbpy5fSUp7p0RlzrwnLtnLoLg==
X-Received: by 2002:a05:7022:401:b0:11d:f464:5c97 with SMTP id a92af1059eb24-11e032d86admr10001629c88.39.1765304567147;
        Tue, 09 Dec 2025 10:22:47 -0800 (PST)
Received: from localhost ([2607:f2c0:b021:e700:1a3d:b7ef:5d4d:bee5])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-11f283d465csm1567525c88.14.2025.12.09.10.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 10:22:46 -0800 (PST)
Date: Tue, 9 Dec 2025 13:22:43 -0500
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
Subject: Re: [PATCH 1/8] rust: pci: add is_virtfn(), to check for VFs
Message-ID: <aTho82cpiQbrrCdd@earendel>
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
 <20251119-rust-pci-sriov-v1-1-883a94599a97@redhat.com>
 <20251207062819.GA212851@joelbox2>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251207062819.GA212851@joelbox2>

On Sun, Dec 07, 2025 at 01:28:19AM -0500, Joel Fernandes wrote:
> On Wed, Nov 19, 2025 at 05:19:05PM -0500, Peter Colberg wrote:
> > From: John Hubbard <jhubbard@nvidia.com>
> > 
> > Add a method to check if a PCI device is a Virtual Function (VF) created
> > through Single Root I/O Virtualization (SR-IOV).
> > 
> > Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> > Reviewed-by: Alistair Popple <apopple@nvidia.com>
> > Signed-off-by: Peter Colberg <pcolberg@redhat.com>
> > ---
> > This patch was originally part of the series "rust: pci: expose
> > is_virtfn() and reject VFs in nova-core" and modified as follows:
> > - Replace true -> `true` in doc comment.
> > - Shorten description and omit justification specific to nova-core.
> > 
> > Link: https://lore.kernel.org/rust-for-linux/20250930220759.288528-2-jhubbard@nvidia.com/
> > ---
> >  rust/kernel/pci.rs | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> > index 82e128431f080fde78a06dc5c284ab12739e747e..c20b8daeb7aadbef9f6ecfc48c972436efac9a08 100644
> > --- a/rust/kernel/pci.rs
> > +++ b/rust/kernel/pci.rs
> > @@ -409,6 +409,12 @@ pub fn resource_start(&self, bar: u32) -> Result<bindings::resource_size_t> {
> >          Ok(unsafe { bindings::pci_resource_start(self.as_raw(), bar.try_into()?) })
> >      }
> >  
> > +    /// Returns `true` if this device is a Virtual Function (VF).
> > +    pub fn is_virtfn(&self) -> bool {
> 
> Add #[inline] here and to `is_physfn()` similar to other methods in this struct?

Thanks for your review! Where should the line be drawn for #[inline]?

Should these be #[inline] as well and why (not)?

- Device::num_vf()
- Device<Core>::enable_sriov()
- Device<Core>::disable_sriov()

Why is Device<Core>::enable_device_mem() not #[inline], while
Device<Core>::set_master() is [1]? Is the former an oversight?

[1] https://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git/tree/rust/kernel/pci.rs?id=67a454e6b1c604555c04501c77b7fedc5d98a779#n433

Thanks,
Peter

> 
> With that,
> 
> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
> 
> thanks,
> 
>  - Joel
> 
> 
> > +        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
> > +        unsafe { (*self.as_raw()).is_virtfn() != 0 }
> > +    }
> > +
> >      /// Returns the size of the given PCI BAR resource.
> >      pub fn resource_len(&self, bar: u32) -> Result<bindings::resource_size_t> {
> >          if !Bar::index_is_valid(bar) {
> > 
> > -- 
> > 2.51.1
> > 
> 


