Return-Path: <linux-pci+bounces-7703-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1AB8CA904
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2024 09:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53E7E1F21CD5
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2024 07:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C56950267;
	Tue, 21 May 2024 07:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="haNj1TsH"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742764AEEA
	for <linux-pci@vger.kernel.org>; Tue, 21 May 2024 07:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716276969; cv=none; b=tVeWIuMFIn0I75APy+S6469r4WjhUXqe9TjjQeqYOPbfqtNbK7NH5ZEqdHpEtRiQwU4jsAFSVIFcp8m5eAV2JFlxN5F8XBDeFLnOnxqnP3dGrWsYoZx0e//WMVRZBqqW36h+sJ0dHyGSXABNnaHupo7Ww7swrBoj+waDcOIIpRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716276969; c=relaxed/simple;
	bh=XdN+2zttHQ0MjCqkV/rL3F/G1MvLNe2WB7xdOgF7Tr0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C5TcxfR9IDjmQDmz3pTxOMY+cBPZ9LOp9FvF1/czG2eTdbk0YX2ubLOCuWQkbNLmc1o8kdW9CRPu7kVNPBA+aIXlaHs2CIQyCJiXSP23G+piFObKRuHJV85Oq2MQZbmLvwdqBvOgQezjeAbUJmNZs/0yjhMD3OsRiOst22VWqf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=haNj1TsH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716276967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XdN+2zttHQ0MjCqkV/rL3F/G1MvLNe2WB7xdOgF7Tr0=;
	b=haNj1TsHJxeqbSvX/zr1v+Fjirkmj2KgyV/eg5aCSkxjZKfhH6RSeo1K1itY5vDalDSaKe
	uB5fVvb1i6FpYqfAnu5T1f9s/cYH4nAWpMIIHtEGTe33P+8OSrnIQEMW2xUBr+gXA9RDsU
	SBoES5bzCnxPKgBA9C9kqenoMAtOzT8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-dI3umFsxOAChhaOBNcmaBA-1; Tue, 21 May 2024 03:36:05 -0400
X-MC-Unique: dI3umFsxOAChhaOBNcmaBA-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-574ec74fb6bso685922a12.2
        for <linux-pci@vger.kernel.org>; Tue, 21 May 2024 00:36:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716276964; x=1716881764;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XdN+2zttHQ0MjCqkV/rL3F/G1MvLNe2WB7xdOgF7Tr0=;
        b=oyiQoi7yHH8+nfPd7b3C8Dz7L6wzPX5yXLqsBYVrb4jE8y8E9nMxjzsZVNQktW+PaV
         m1BWwaSCw+7Cr8oNI0w2rMGRX/fU96RjANJ5LUtdi4oKTaQ6ZEChf6Kp69/HMpAbSSk4
         zkoanA1jZ9tTW//sK3ZB5cH0Ypw+VWQNfVzY0nhgdF4BftPSQWBNBwGnfcKbKoaJonPT
         AvD80NZ/d2RynQOExmS7lfhulEEbYskKHHtvO/BYyW/qhVttF0mrNS90MVUiapPMonPm
         VCyYWEULLCmfe6jibgHJhNb6p4ScwwxiN8GKXZkdLNiW02amdFjC7g0GPOKX3Nnr6u6G
         E8FA==
X-Forwarded-Encrypted: i=1; AJvYcCUk8gPWM5hkLUUNiqirpKE7eDiv+KjQI+qjKqnTLCMjHfKsporGdp4Cd/e0qMsLBovLSCIHxiYRDvfzy5aWlo+7+AL+vR6iQ7GI
X-Gm-Message-State: AOJu0YwKF2ylgfZCI5GaNhMjXvgnS0hVNWN3h9iPgdDsG9Mohyt3WeAU
	zgD/tp1pCdzYQfC7HqNWaMnw9sq02u32w5sfHcxK7UzeKmSyuSELDZX80lmJnRPTh3RAGm2Znbz
	cH/RFDc3gKAKBVe98klSAO38x1PsBylzOzrYqcFXRAfnQtkqLC7KRBsU8Bg==
X-Received: by 2002:a17:907:986:b0:a59:bce9:8454 with SMTP id a640c23a62f3a-a5a2d55347bmr2891345966b.1.1716276964231;
        Tue, 21 May 2024 00:36:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6X/1XcE2E6yjKqIiqCpzGiiQ6iBNuEwXlVNXHnfjn+aSwnJU50wIIah1qpk9DeBlBs9Y+Mg==
X-Received: by 2002:a17:907:986:b0:a59:bce9:8454 with SMTP id a640c23a62f3a-a5a2d55347bmr2891343466b.1.1716276963771;
        Tue, 21 May 2024 00:36:03 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a3c65d06fsm1409594266b.52.2024.05.21.00.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 00:36:03 -0700 (PDT)
Message-ID: <cf89c02d45545b67272aba933fbc8a8a0df83358.camel@redhat.com>
Subject: Re: [RFC PATCH 10/11] rust: add basic abstractions for iomem
 operations
From: Philipp Stanner <pstanner@redhat.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Danilo Krummrich
	 <dakr@redhat.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com, 
 ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
 boqun.feng@gmail.com,  gary@garyguo.net, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me,  a.hindborg@samsung.com, aliceryhl@google.com,
 airlied@gmail.com,  fujita.tomonori@gmail.com, lina@asahilina.net,
 ajanulgu@redhat.com,  lyude@redhat.com, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-pci@vger.kernel.org
Date: Tue, 21 May 2024 09:36:02 +0200
In-Reply-To: <CANiq72kHrgOVrdw7rB9KpHvOMy244TgmEzAcL=v5O9rchs8T1g@mail.gmail.com>
References: <20240520172554.182094-1-dakr@redhat.com>
	 <20240520172554.182094-11-dakr@redhat.com>
	 <CANiq72kHrgOVrdw7rB9KpHvOMy244TgmEzAcL=v5O9rchs8T1g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-05-21 at 00:32 +0200, Miguel Ojeda wrote:
> On Mon, May 20, 2024 at 7:27=E2=80=AFPM Danilo Krummrich <dakr@redhat.com=
>
> wrote:
> >=20
> > through its Drop() implementation.
>=20
> Nit: `Drop`, `Deref` and so on are traits -- what do the `()` mean
> here? I guess you may be referring to their method, but those are
> lowercase.

ACK

>=20
> > +/// IO-mapped memory, starting at the base pointer @ioptr and
> > spanning @malxen bytes.
>=20
> Please use Markdown code spans instead (and intra-doc links where
> possible) -- we don't use the `@` notation. There is a typo on the
> variable name too.
>=20
> > +pub struct IoMem {
> > +=C2=A0=C2=A0=C2=A0 pub ioptr: usize,
>=20
> This field is public, which raises some questions...

Justified questions =E2=80=93 it is public because the Drop implementation =
for
pci::Bar requires the ioptr to pass it to pci_iounmap().

The alternative would be to give pci::Bar a copy of ioptr (it's just an
integer after all), but that would also not be exactly beautiful.

The subsystem (as PCI does here) shall not make an instance of IoMem
mutable, so the driver programmer couldn't modify ioptr.

I'm very open for ideas for alternatives, though. See also the other
mail where Danilo brainstorms about making IoMem a trait.

>=20
> > +=C2=A0=C2=A0=C2=A0 pub fn readb(&self, offset: usize) -> Result<u8> {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let ioptr: usize =3D self.g=
et_io_addr(offset, 1)?;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Ok(unsafe { bindings::readb=
(ioptr as _) })
> > +=C2=A0=C2=A0=C2=A0 }
>=20
> These methods are unsound, since `ioptr` may end up being anything
> here, given `self.ioptr` it is controlled by the caller.=C2=A0

Only if IoMem is mutable, correct?

The commit message states (btw this file would get more extensive
comments soonish) that with this design its the subsystem that is
responsible for creating IoMem validly, because the subsystem is the
one who knows about the memory regions and lengths and stuff.

The driver should only ever take an IoMem through a subsystem, so that
would be safe.

> One could
> also trigger an overflow in `get_io_addr`.

Yes, if the addition violates the capacity of a usize. But that would
then be a bug we really want to notice, wouldn't we?

Only alternative I can think of would be to do a wrapping_add(), but
that would be even worse UB.

Ideas?

>=20
> Wedson wrote a similar abstraction in the past
> (`rust/kernel/io_mem.rs` in the old `rust` branch), with a
> compile-time `SIZE` -- it is probably worth taking a look.

Yes, we're aware of that one. We also did some experiments with it.
Will discuss it in the other thread where Dave and Wedson mention it.

>=20
> Also, there are missing `// SAFETY:` comments here. Documentation and
> examples would also be nice to have.

Oh yes, ACK, will do


Thx for the review!


>=20
> Thanks!
>=20
> Cheers,
> Miguel
>=20


