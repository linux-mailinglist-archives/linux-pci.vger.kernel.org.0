Return-Path: <linux-pci+bounces-9235-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E98E9168A4
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 15:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E80C1C224AC
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 13:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47519156227;
	Tue, 25 Jun 2024 13:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LNtYKk+k"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952C5158D97
	for <linux-pci@vger.kernel.org>; Tue, 25 Jun 2024 13:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719321140; cv=none; b=U8LxZltLKVn+HELaQvWFGYljy08GXQd42REt/wJLk1o0s/Yffit27LYycYFZhokMZTfpY9/JKSqosZWLELvyLM8iVJF3QY2Tn5d0LUu/EkJeGn+Xiy47EjIXh55e7j18T9B1S0b+HOIMwKvnxOc9r/Q9jkwYwCFZvP7qGi4Z4Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719321140; c=relaxed/simple;
	bh=TFq4HLn3CLeNg6JyyyzAe6Ha+Upr2kIV3iKB8OJpY7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DzWxyIqUOkexBhxlAjenCpRo76TRcOb0RWbi+VmcTPf+mscMVgXJH+iZS1GazeNYI3dbez4fFtCMV4p8KrNJttYIytYMdvFEV4tU5ahowWHdJ3PNYUUAEIUDzgHQYjbHzpal7itQ/WIZzt1xy+kFejSuBMAf8mbXkR+YmqDmRBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LNtYKk+k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719321137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jh/orAWdmX1f20UeUuohMffT1uAlWu31wkSvgtgeopA=;
	b=LNtYKk+kx+sylzte8gL4QXMLFxw0zFmikPeb9yBTqMEpkJVIRWs0nPv0vR9kMXHVKrxsH8
	gf+1h0H8P9da/I1x34ROW5nPNJHrk2UcKH1r+dO/X9d40IrlkE9yq/dIQk2X0QlOI+zp8n
	1ERxHI9e0A7iN2iuNrROGhES/OOAmNE=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-qvX3ObTBPXyNlpD-Kb3BTg-1; Tue, 25 Jun 2024 09:12:16 -0400
X-MC-Unique: qvX3ObTBPXyNlpD-Kb3BTg-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-52ce3a9a2daso1939287e87.1
        for <linux-pci@vger.kernel.org>; Tue, 25 Jun 2024 06:12:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719321135; x=1719925935;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jh/orAWdmX1f20UeUuohMffT1uAlWu31wkSvgtgeopA=;
        b=gPVieguX0NiZdQ0f25eXeL1mkwqGnKYukMV/eWq6omGCF6fK+iO0JJuL1OzTZMoRk8
         KJL4uvwcmEpq4fj0Pboih256bszSp9HOnCoeT27qXDPu/3KjCE89vXq1DZUcG+tr1gIC
         0C97DqKD+kLJQp8nfRMb7Yu/OPGbcBxsXWUS/KQ+AIbRlEgiUZCL13AzKC24lmgEaEsO
         WiUWEMlfOBkW7XO04XxB3i2X9lFJ2pF+tNlPlcJvFc5dYCgktqFZw+gNYdd8vWLNwNCH
         d4llezaw4seK9PDufY3dz9hFRwJwgDnznBCRyjBIRQSKypYfBJ9yozYVslcRDfUDmMz4
         Yqqw==
X-Forwarded-Encrypted: i=1; AJvYcCVa3UQtT2RAd6M6HKXQVQaiZ/qiQqb6dfhYekQvNYHxofhUy9qiGfmKDeJsjDuoNNXMDZJpVi1oA1RpREdWtMpPJK6lG7We0ua4
X-Gm-Message-State: AOJu0Yy1dop6IkAZIG2sQU5XPt2yjCncd4Cog4GH2NHo0KciRVPST6hG
	394tM9TQf0cztt5Yn62GYrpEER1Fa0hAtnUOs5tI5OKrgonSsTj8pn2y95tM1MtrbEuLW2PAzTC
	K4NZcnfVFJ3JcS64VvFEeqUfezyopsnBTfNbZh2TkpHMRf8IcWDq3/kwV1A==
X-Received: by 2002:a05:6512:3285:b0:52c:df9c:5983 with SMTP id 2adb3069b0e04-52ce183b3d6mr3992086e87.40.1719321134542;
        Tue, 25 Jun 2024 06:12:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF35SrdNTXrkT5B2/iGfiGvj53zPOM8OB7zzQf/r/NlUat09myb8xoQxhJ+HmOKZSgeyj5WYA==
X-Received: by 2002:a05:6512:3285:b0:52c:df9c:5983 with SMTP id 2adb3069b0e04-52ce183b3d6mr3991982e87.40.1719321132655;
        Tue, 25 Jun 2024 06:12:12 -0700 (PDT)
Received: from cassiopeiae ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36638f85922sm13038812f8f.63.2024.06.25.06.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 06:12:12 -0700 (PDT)
Date: Tue, 25 Jun 2024 15:12:09 +0200
From: Danilo Krummrich <dakr@redhat.com>
To: Andreas Hindborg <nmi@metaspace.dk>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	aliceryhl@google.com, airlied@gmail.com, fujita.tomonori@gmail.com,
	lina@asahilina.net, pstanner@redhat.com, ajanulgu@redhat.com,
	lyude@redhat.com, robh@kernel.org, daniel.almeida@collabora.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 07/10] rust: add `io::Io` base type
Message-ID: <ZnrCKQBaRUlIs8hp@cassiopeiae>
References: <20240618234025.15036-1-dakr@redhat.com>
 <20240618234025.15036-8-dakr@redhat.com>
 <87zfr9guer.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zfr9guer.fsf@metaspace.dk>

On Tue, Jun 25, 2024 at 12:59:24PM +0200, Andreas Hindborg wrote:
> Hi Danilo,
> 
> Danilo Krummrich <dakr@redhat.com> writes:
> 
> [...]
> 
> > +
> > +macro_rules! define_write {
> > +    ($(#[$attr:meta])* $name:ident, $try_name:ident, $type_name:ty) => {
> > +        /// Write IO data from a given offset known at compile time.
> > +        ///
> > +        /// Bound checks are performed on compile time, hence if the offset is not known at compile
> > +        /// time, the build will fail.
> > +        $(#[$attr])*
> > +        #[inline]
> > +        pub fn $name(&self, value: $type_name, offset: usize) {
> > +            let addr = self.io_addr_assert::<$type_name>(offset);
> > +
> > +            unsafe { bindings::$name(value, addr as _, ) }
> > +        }
> > +
> > +        /// Write IO data from a given offset.
> > +        ///
> > +        /// Bound checks are performed on runtime, it fails if the offset (plus the type size) is
> > +        /// out of bounds.
> > +        $(#[$attr])*
> > +        pub fn $try_name(&self, value: $type_name, offset: usize) -> Result {
> > +            let addr = self.io_addr::<$type_name>(offset)?;
> > +
> > +            unsafe { bindings::$name(value, addr as _) }
> > +            Ok(())
> > +        }
> > +    };
> > +}
> > +
> 
> I am curious why we do not need `&mut self` to write to this memory? Is
> it OK to race on these writes?

Yes, concurrent writes to the same I/O mapped memory region (within the same
driver) should be totally fine.

In the end it's only the driver that can know about (and has to ensure) the
semantics, concurrency and ordering of those writes.

> 
> 
> Best regards,
> Andreas
> 


