Return-Path: <linux-pci+bounces-7727-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8EC18CB390
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2024 20:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65F24B20E38
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2024 18:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF2C14885B;
	Tue, 21 May 2024 18:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KbTMT+Og"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0E41487C0
	for <linux-pci@vger.kernel.org>; Tue, 21 May 2024 18:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716316604; cv=none; b=HrXBK7t3+xYoZkKQUlfquy/ZvVYWGgFhVi2D3Ewcmk1wvvf5QYPeOiAsMhO0dyBQ7zlzJ7JYfRWOTlBSrSNTIThyRzbSEZPaqSfX/gYQcMGa9HRGx3KTUN4wwRckibH8cZlxp4O9ipo0HIoNM87Bx7jnVodvHBjmuz0/P6n8ACM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716316604; c=relaxed/simple;
	bh=qvsdQhZ7BuP31Y2XO01pfGuDmUVoBr18WPXViDhgp8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K3z//+pXQrYGZIS5OcFAuedJBnf2pd0Myk2+Vspohwam/BpI9u9VSia94sj8FljVFr68P1lYzZzpp2Q53tT56jygvuCQZKeEecbG4zBBVIpO783/TqCg0MgXxuBQRyJczQAz8mtAvhIzN/LpX3UoM8+jEbhSqXztWyuXCdbzUXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KbTMT+Og; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716316602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jevMKRBxb/R55R0RVyGAIvU9KnGm8nwwPq1TksVQuy8=;
	b=KbTMT+OgWmLbk4u4eqg4guPrkctNTkv3j2vGbq3mIkuo1yIlgBXa2XHSZaoMeSRFLzIAbm
	FGcJgTgg3/2HYqpuQDBM7s6hU3C4+q8WVXXrn6LyzskOc4zDC72HlgmeXRSKbdXoVNnDOa
	wYaFB8mcKX61lGvCXsE8vwB7lgIzTT4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-cnK2l1mbPwq0j2vIgENxWg-1; Tue, 21 May 2024 14:36:40 -0400
X-MC-Unique: cnK2l1mbPwq0j2vIgENxWg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-420eed123a2so13968995e9.1
        for <linux-pci@vger.kernel.org>; Tue, 21 May 2024 11:36:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716316599; x=1716921399;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jevMKRBxb/R55R0RVyGAIvU9KnGm8nwwPq1TksVQuy8=;
        b=uhQSjB3uBIh+LLFtG8W4wt7eAYE3MdSDJubGDnsn3dEiALH7+elGcmOBWeTXYvAYp8
         TMiylNq/kgSSMckEhWhsPt/cVDC++H9+s88Mn7TsSXJoiyrf/BMvqML3uFIZYIq6pv5W
         Kqr5P5bP7yhL1LLdnJlPzxsouA9kLdZNMrci/fmt+FV7JQUvAmO/9NMMocgbzSzTmqYm
         pfDV8Gc9kFkCXA/RAczpgSdaGvVjnLHbbwL85yYKsVH1fMDwgz4Ps7KQao5ZLt6IJaBu
         nmipQ0inYei9XWLxWa+6zjVtw5iGc+d/0RcK9izzYkpwlI6Vo45HftQ1Cr80ao/wNERk
         59zg==
X-Forwarded-Encrypted: i=1; AJvYcCUwGapqf/KmPyuzoI4iIbQAzXyEApMu2//Yrw0XacXRDK6kY7OTdhPAljXCU40VGf1F3x/XPQySiVeXWRV4j6eCfbAGYOe7ZC8Z
X-Gm-Message-State: AOJu0YyT1KQlGOMr04EGz6Cfr2IPUBLEGThQ54ucmrmbkkvhrxcnv6Xq
	uPW/TZLbVmp4rrjQSp2pZRMomVd4WWW7w6dppx01Ac78gaIgNcT/NLLJKRwtyc24pCgq+6/dFfi
	u1S8+2R89ndhuPdw0epUtL+sIRjR/1eoiuWcL9DlfvFK/xY0HgqnolbVN+A==
X-Received: by 2002:a05:600c:3b23:b0:41b:f3b6:e5da with SMTP id 5b1f17b1804b1-41fead61b59mr287566415e9.36.1716316599631;
        Tue, 21 May 2024 11:36:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGk76L37vIpOA5Y58eTWTGFIjiFF33BBGgA3nqwWyu66vAzg2d7meVl0CY1IrJMA1aWEsUH5A==
X-Received: by 2002:a05:600c:3b23:b0:41b:f3b6:e5da with SMTP id 5b1f17b1804b1-41fead61b59mr287566195e9.36.1716316599179;
        Tue, 21 May 2024 11:36:39 -0700 (PDT)
Received: from pollux ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-351b4af0b0asm25792883f8f.100.2024.05.21.11.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 11:36:38 -0700 (PDT)
Date: Tue, 21 May 2024 20:36:36 +0200
From: Danilo Krummrich <dakr@redhat.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Philipp Stanner <pstanner@redhat.com>, wedsonaf@gmail.com
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com, airlied@gmail.com,
	fujita.tomonori@gmail.com, lina@asahilina.net, ajanulgu@redhat.com,
	lyude@redhat.com, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [RFC PATCH 10/11] rust: add basic abstractions for iomem
 operations
Message-ID: <ZkzptG6fJx-MJ_6s@pollux>
References: <20240520172554.182094-1-dakr@redhat.com>
 <20240520172554.182094-11-dakr@redhat.com>
 <CANiq72kHrgOVrdw7rB9KpHvOMy244TgmEzAcL=v5O9rchs8T1g@mail.gmail.com>
 <cf89c02d45545b67272aba933fbc8a8a0df83358.camel@redhat.com>
 <CANiq72k7H3Y0ksdquVsrAbRtj_5CqMCYfo79UrhSVcK5VwfG5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72k7H3Y0ksdquVsrAbRtj_5CqMCYfo79UrhSVcK5VwfG5Q@mail.gmail.com>

On Tue, May 21, 2024 at 11:18:04AM +0200, Miguel Ojeda wrote:
> On Tue, May 21, 2024 at 9:36 AM Philipp Stanner <pstanner@redhat.com> wrote:
> >
> > Justified questions – it is public because the Drop implementation for
> > pci::Bar requires the ioptr to pass it to pci_iounmap().
> >
> > The alternative would be to give pci::Bar a copy of ioptr (it's just an
> > integer after all), but that would also not be exactly beautiful.
> 
> If by copy you mean keeping an actual copy elsewhere, then you could
> provide an access method instead.

As mentioned earlier, given the context how we use IoMem, I think IoMem should
just be a trait. And given that, maybe we'd want to name this trait differently
then, something like `trait IoOps` maybe?

pub trait IoOps {
   // INVARIANT: The implementation must ensure that the returned value is
   // either an error code or a non-null and valid address suitable for  I/O
   // operations of the given offset and length.
   fn io_addr(&self, offset: usize, len: usize) -> Result<usize>;

   fn readb(&self, offset: usize) -> Result<u8> {
      let addr = self.io_addr(offset, 1)?;

      // SAFETY: `addr` is guaranteed to be valid as by the invariant required
      // by `io_addr`.
      Ok(unsafe { bindings::readb(addr as _) })
   }

   [...]
}

We can let the resource type (e.g. `pci::Bar`) track the base address and limit
instead and just let pci::Bar implement `IoMem::io_addr`.

As for the compile time size, this would be up the the actual resource then.
`pci::Bar` can't make use of this optimization, while others might be able to.

Does that sound reasonable?

- Danilo


