Return-Path: <linux-pci+bounces-7697-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1A78CA68E
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2024 05:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 542C1B21FA4
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2024 03:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9055118040;
	Tue, 21 May 2024 02:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EPlw2bKd"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA051BF24
	for <linux-pci@vger.kernel.org>; Tue, 21 May 2024 02:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716260366; cv=none; b=Jzc7opVFuX+UyyA95by9u3oOG8cLDZ19wAdCuOFUKmNPZteKEETG6d0RkCSxln1oU8EmTtRH0WH8THbmnQCVOG5QwZU7KKvSZt3IcNlVEIAOt0gmbTg36RP1VaquDGs2SUPwLO396RyPHLjwsYHcWH7FcPOVOlFDPTBK68VKzTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716260366; c=relaxed/simple;
	bh=lS164zVhatoCQzOGw9xfoipYlofiS/EZUfAZNpoXX9I=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=gItZtP2Bcu3WsMegic+417Dhxq+YEgmeyiPfaJf7c/ZWJ4GLo9o+xN+9gXMjjurohpoUUf27togiSnrwR1xQeeU5BrCovH5uU71EtDZXpyKUbmlQ/YoFJAMr14LlKngU9Z4jsb8HYflKzRSwlSNg/zNZSO0m4a8aI3i/4AUHWk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EPlw2bKd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716260363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gpHxUzO7krNIPiV9mgzFqkbtUMxrneNQVP8XN/mttLU=;
	b=EPlw2bKdGoS7GzDOOckHvcksnRis9QcH+uidQl81jx7xFF+ulQvd7rKIH7YRFsi/ZZfL7t
	XyajJzJAKZnUqYz7d3dy8509zsgHCZdcm93hNgqvjTfjOkUX2/W+emBCFk4CcRCp02QY2K
	1gn3RPtN2qk0wIcFT4mRxlD6LBA7ngs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-3AnZlZo1ObSkx7D4AazGeg-1; Mon, 20 May 2024 22:59:21 -0400
X-MC-Unique: 3AnZlZo1ObSkx7D4AazGeg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4169d69ce6bso265905e9.2
        for <linux-pci@vger.kernel.org>; Mon, 20 May 2024 19:59:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716260361; x=1716865161;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gpHxUzO7krNIPiV9mgzFqkbtUMxrneNQVP8XN/mttLU=;
        b=IAhOY+QVieZke5T5+XQzSgenFkJ8fhWiwZc2iAZ22O7GPoERgkeaVCz/Y8bbobxjRc
         TUjK4kv9PUSACYJDqWFE2rPLs4Agpfx63v44xnLLWphmJRY52YlMSN5yI0sIHV9qkhuE
         eXgJsqFslUOn1zxAgSyiSQth/Lg1rCupX8Q/P9qLdu+1tlgMzSZIkDF2r5Nl4E8a1R9F
         pzmYD2d6EjQ+XebHULsumSB34DtCXlBUaNtHJAbp1Y4f1U2MyVjaXRh/W4wPKyS5tHMk
         TcNuNrn8qe/SD+NGtQ6SB784e8hZ20WT20Kk+GUp7XB6hn2dZQdT/Hy2ZaEk0/xQudRc
         lM9A==
X-Forwarded-Encrypted: i=1; AJvYcCXNdknQQuA/QzPBno8WuEeSdehBMWALImYKINyKD1USOzY4WwLraejxKJMuk9p5muD+KTvhr3ZB0k4r4S+UKpDG6veM7m4BzB2q
X-Gm-Message-State: AOJu0Yy4TFG/Bo76APacxv5hEzv65l2RHF16ry5E46qG9FLc1Cs9Bjp/
	jXpaKLQFmUcp/lJxrefJcCLt2COV7zI3TtHJZHYslnKRCLez2mbfcXRT5Ld9E10LSkVSsGI9BHr
	21d8P2s/ePH7TK4cMQSGq79oPHA/6SwfQ5IYcSWf2Sov/cMMa8owINbqSNg==
X-Received: by 2002:a05:600c:35d3:b0:420:14fb:de1f with SMTP id 5b1f17b1804b1-42014fbe1admr189797085e9.14.1716260360795;
        Mon, 20 May 2024 19:59:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGN6LF6zOUxd0TtcyOUp7U9AawDsKqXA8eie9bsey3aMIwKmzga3L4ta6139bGXkj0jSRbreg==
X-Received: by 2002:a05:600c:35d3:b0:420:14fb:de1f with SMTP id 5b1f17b1804b1-42014fbe1admr189796825e9.14.1716260360431;
        Mon, 20 May 2024 19:59:20 -0700 (PDT)
Received: from smtpclient.apple ([2a02:810d:4b3f:ee94:9976:d2a9:2161:854f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccbe8fa6sm445082275e9.2.2024.05.20.19.59.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 May 2024 19:59:19 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Danilo Krummrich <dakr@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH 10/11] rust: add basic abstractions for iomem operations
Date: Tue, 21 May 2024 04:59:08 +0200
Message-Id: <CE78A4CB-F499-4BD8-8E29-28F561B320C1@redhat.com>
References: <CANiq72kHrgOVrdw7rB9KpHvOMy244TgmEzAcL=v5O9rchs8T1g@mail.gmail.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
 ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com,
 airlied@gmail.com, fujita.tomonori@gmail.com, lina@asahilina.net,
 pstanner@redhat.com, ajanulgu@redhat.com, lyude@redhat.com,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
In-Reply-To: <CANiq72kHrgOVrdw7rB9KpHvOMy244TgmEzAcL=v5O9rchs8T1g@mail.gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
X-Mailer: iPhone Mail (21E236)

(quick reply from my phone)

> On 21. May 2024, at 00:32, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> w=
rote:
>=20
> =EF=BB=BFOn Mon, May 20, 2024 at 7:27=E2=80=AFPM Danilo Krummrich <dakr@re=
dhat.com> wrote:
>>=20
>> through its Drop() implementation.
>=20
> Nit: `Drop`, `Deref` and so on are traits -- what do the `()` mean
> here? I guess you may be referring to their method, but those are
> lowercase.
>=20
>> +/// IO-mapped memory, starting at the base pointer @ioptr and spanning @=
malxen bytes.
>=20
> Please use Markdown code spans instead (and intra-doc links where
> possible) -- we don't use the `@` notation. There is a typo on the
> variable name too.
>=20
>> +pub struct IoMem {
>> +    pub ioptr: usize,
>=20
> This field is public, which raises some questions...
>=20
>> +    pub fn readb(&self, offset: usize) -> Result<u8> {
>> +        let ioptr: usize =3D self.get_io_addr(offset, 1)?;
>> +
>> +        Ok(unsafe { bindings::readb(ioptr as _) })
>> +    }
>=20
> These methods are unsound, since `ioptr` may end up being anything
> here, given `self.ioptr` it is controlled by the caller. One could
> also trigger an overflow in `get_io_addr`.
>=20

I think the only thing we really want from IoMem is a generic implementation=
 of the read*() and write*() functions.

Everything else should be up the the resource itself, see e.g. pci::Bar. Hen=
ce I think we should just make IoMem a trait instead and just let the resour=
ce implement a getter for the MMIO pointer, etc.

> Wedson wrote a similar abstraction in the past
> (`rust/kernel/io_mem.rs` in the old `rust` branch), with a
> compile-time `SIZE` -- it is probably worth taking a look.
>=20
> Also, there are missing `// SAFETY:` comments here. Documentation and
> examples would also be nice to have.
>=20
> Thanks!
>=20
> Cheers,
> Miguel
>=20


