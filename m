Return-Path: <linux-pci+bounces-42861-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 028ABCB0D44
	for <lists+linux-pci@lfdr.de>; Tue, 09 Dec 2025 19:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 037973008D71
	for <lists+linux-pci@lfdr.de>; Tue,  9 Dec 2025 18:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379552F6173;
	Tue,  9 Dec 2025 18:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b+znwH6x";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RhUHERv5"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C2D2F3C1F
	for <linux-pci@vger.kernel.org>; Tue,  9 Dec 2025 18:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765304668; cv=none; b=b3+IzXbtjqXkTpgeZvSi0HTy3zBgdizVFWlDG1NWCxELNqYd8c9VZ4FPBzsrR2Feuy1GZaHul2vdapcUAczvmdDYL5YgWZSMuzXDSq4XKQjM013t3DExhOpuKUCANXQ1Kvj8kDrzko5AyFhX70nj/1U+wcW6xzQzOK6lUQH1m74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765304668; c=relaxed/simple;
	bh=hAn/Z5Df5IfuEg5YxLgjH2jmnTaDG3wqcDn0Zcz6LNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZRLUgi7NLst+68xFbhyKbdKBL5/dGkXWUMuLJ/HzioPnsPiwGr7Epuoq+Nho7qgtf2/LmzZEzYSL+VtO2UDu48oE1b5jmmFgYi1nCjJG0f/QWhrluSH4liiWASWrmHbZ9+Tqw27OgI2S5dbh393kepVZTu+ePmderryK901TKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b+znwH6x; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RhUHERv5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765304665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dnmWADxON+YmdpGHvTe/CcMuyEKp/5Q83Q83DsKz/iw=;
	b=b+znwH6x5wY4ZFL8D9VkPO/lH7E5ktzQQBAveo1J8LFRy30cU1wX7oXe1X4IVIVDb7efHV
	YTY4sxzABi5jH5SamgdFdEkuuPDvBeHKMiLvAn7+KDjaqevpcpT2kxI5rJa+Oz0uW2SgYQ
	Zy9Vt26uGWV+vtpAnoAhEL5VSR2PQO0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-xXPFRaNTNKKBBJvwylGAcA-1; Tue, 09 Dec 2025 13:24:21 -0500
X-MC-Unique: xXPFRaNTNKKBBJvwylGAcA-1
X-Mimecast-MFC-AGG-ID: xXPFRaNTNKKBBJvwylGAcA_1765304660
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8824d5b11easo123755266d6.3
        for <linux-pci@vger.kernel.org>; Tue, 09 Dec 2025 10:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765304660; x=1765909460; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dnmWADxON+YmdpGHvTe/CcMuyEKp/5Q83Q83DsKz/iw=;
        b=RhUHERv5aCV1g94Al3drDXugVOU2KCXVCug/Lt9w9uoMCCMkrXFGh/teicLlb+HZYM
         dxT2crzLXky46ZKLWYXpOM0xGRqkAkZgk96Sh9bdv2mRLibNkWbYabW8UNWYeYMqyt9V
         yPVK2H28MpCUm8Z3g6g+oKGeBraN7417fbCRKEhmH84Xb5EaU1UqXyU3wW0gsx3KRt/y
         TRz6R8T8Jitkbvsl6NOc1lOVnVhd1O5AJ/cwzLX3F+Hgm+Hv2C3TFhEX/JtvczDfJ+uz
         pfaTDoUx5DEI+3np7Xp1iDRwx0sl1ibTla0SuGGgwVAvw7tkoxKNd0obUT/T6gprAmxJ
         FWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765304660; x=1765909460;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dnmWADxON+YmdpGHvTe/CcMuyEKp/5Q83Q83DsKz/iw=;
        b=n8j4LrJ8mflI072h7rKhY/VIg3FFKQTvlp2Uz+COtPXX86uDHBSijZyRXc6zwjVrwf
         8mx/wjlpi00ZgYDDY2Kl+McL/AB6GYw0wsptwe1VKOJvQcWSrgINwBdOrXv95fFDQxpp
         pagZoGdqGYuOTrWQygzbquTAES7qaTYkVYvkRTzfFFbDH18EuArjoY+nyXvIeTI/AN7e
         grAAAr12PlXfsypvSfjCqSJztX4kILD5nRceLq+fxbp0LDg6Z9zNYruJiw3twH8ObWsG
         8GLAt3RWSNh3yDcRTa5SB99X3ga/VnkcMNsOR4TV1JoasmA1uO9j2llRxTq9tmXYgt4V
         pmeg==
X-Forwarded-Encrypted: i=1; AJvYcCVzw6qqekjiQ9YOi5U9xmioLKfUW0PFJN8J7TnzNcNwl/IyOGgxyB0WSUyTJhli95gTTqhcT+pPTNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5rLDugSAlQHorecR5b3Fj6md/rsbS7rPSyI8Is5Kt+JMOtMp+
	X3DiQYtGPFYZN0NRm6Xnwqb4ED2Z87TZY3TFSYMfYeZ7XlBJRJ3jhThR9aIqfHSwjxcaCsYHdEX
	8NPICXKJFDFTa8FpAyy944IjnrOQWUMCfk3RPm/2QRbJqV6ykUZbvktvivYdJcA==
X-Gm-Gg: AY/fxX71W/KkMdVYVs8mXGnc6JxFPG1VrD2Ot5EC5/zHgly2Xqr7mkbwM5mGwTrOh5Y
	mRR6pSCSje+4HL25nAuiwcKXYsN6X7hoUoNGGPt6sleRCSWEZ+nZRmUeCzimpXXDaCb8LtW9Egj
	XbI+Rx8Exvpl3CtT3Nxa9lTNqmBhiCE9HQHtahOSkZFqtg5sJgiRKkkCgSB7SHvCisANNsfxztj
	jSTBWHFJO9sVLydzw2wfDkMgpHyIHvWqGXKTFK/tLUm6XpxYKBl5WpzdsZIHjVvoP8yoNvckRwF
	c4g9XQHWy6yg30/rTba7qOurZw9+6z1hUwDiRLkcbUGakRn0O3suEYqzPqkuH3gaNkyGgPj2P+8
	0CwGRXR//oA==
X-Received: by 2002:a05:6214:ca4:b0:880:5a6d:acdd with SMTP id 6a1803df08f44-8883db2a6b2mr191692816d6.20.1765304660183;
        Tue, 09 Dec 2025 10:24:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJ8wAtHimvFzUwt+2wodU61BXEoK2Jlph6a1B6dGPRD3NMrmeZ11TpnWCcFApbeYhstxlBjw==
X-Received: by 2002:a05:6214:ca4:b0:880:5a6d:acdd with SMTP id 6a1803df08f44-8883db2a6b2mr191692316d6.20.1765304659571;
        Tue, 09 Dec 2025 10:24:19 -0800 (PST)
Received: from localhost ([2607:f2c0:b021:e700:1a3d:b7ef:5d4d:bee5])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-888287d5f9csm131225306d6.46.2025.12.09.10.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 10:24:19 -0800 (PST)
Date: Tue, 9 Dec 2025 13:24:18 -0500
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
Subject: Re: [PATCH 2/8] rust: pci: add is_physfn(), to check for PFs
Message-ID: <aThpUqJDqa_7VYtx@earendel>
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
 <20251119-rust-pci-sriov-v1-2-883a94599a97@redhat.com>
 <20251207063529.GA213398@joelbox2>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251207063529.GA213398@joelbox2>

On Sun, Dec 07, 2025 at 01:35:29AM -0500, Joel Fernandes wrote:
> On Wed, Nov 19, 2025 at 05:19:06PM -0500, Peter Colberg wrote:
> > Add a method to check if a PCI device is a Physical Function (PF).
> > 
> > Signed-off-by: Peter Colberg <pcolberg@redhat.com>
> > ---
> >  rust/kernel/pci.rs | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> > index c20b8daeb7aadbef9f6ecfc48c972436efac9a08..814990d386708fe2ac652ccaa674c10a6cf390cb 100644
> > --- a/rust/kernel/pci.rs
> > +++ b/rust/kernel/pci.rs
> > @@ -409,6 +409,12 @@ pub fn resource_start(&self, bar: u32) -> Result<bindings::resource_size_t> {
> >          Ok(unsafe { bindings::pci_resource_start(self.as_raw(), bar.try_into()?) })
> >      }
> >  
> > +    /// Returns `true` if this device is a Physical Function (VF).
> 
> nit:  s/VF/PF/
> 
> also, add #[inline].
> 
> With that,
> 
> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>

Thanks, done.

Peter

> 
> thanks,
> 
>  - Joel
> 
> 
> 
> > +    pub fn is_physfn(&self) -> bool {
> > +        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
> > +        unsafe { (*self.as_raw()).is_physfn() != 0 }
> > +    }
> > +
> >      /// Returns `true` if this device is a Virtual Function (VF).
> >      pub fn is_virtfn(&self) -> bool {
> >          // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
> > 
> > -- 
> > 2.51.1
> > 
> 


