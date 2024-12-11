Return-Path: <linux-pci+bounces-18126-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 568789ECCD4
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 14:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 842D418880D0
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 13:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38F61F193D;
	Wed, 11 Dec 2024 13:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZfEPN/mP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EBA23FD18
	for <linux-pci@vger.kernel.org>; Wed, 11 Dec 2024 13:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733922427; cv=none; b=KvW50Y98EuyNAGsqP3rnpbNxkQha/5aaFwdye12yupGIr+ogoNBMsmSQLC1mOVFbwYu7RYNHrX/HiFpxxLBGBMhG4Ab31qu4eMqZ1yHX18oXZJWsMU7UWozjH5KkcqgnjN97jnZ7PXh4XpReMNTC7oGOJ1HOLL6n2JNe5RPCsLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733922427; c=relaxed/simple;
	bh=ajO8SVZT8o+VVLVONrOdRF9uwx4v4EetGOEOYG8GxoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aUKRl+uXJ738yFUUY8Y7QUhOu/kHbPWmKwb/LvQOkpRLb5uQ3nD1Jojd4Syyix7mGZoQ0ZBaLMUSaAjvdZ6nNXgqonyqWR6ovPJuqQ4Dvc1jAtn1yHK7YDZEP7hRzyHJdEig4BSTFBZTCRS9rwubbK7FrLZqfBv/Yk058IK/cDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZfEPN/mP; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3862b364538so398693f8f.1
        for <linux-pci@vger.kernel.org>; Wed, 11 Dec 2024 05:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733922424; x=1734527224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ajO8SVZT8o+VVLVONrOdRF9uwx4v4EetGOEOYG8GxoI=;
        b=ZfEPN/mPBNmw57A+NVw5OFh9ZtYrYeJ6U9k22+uWK673ddPy53R5OzHdqdMOXOpMRn
         Mch0DEAsNUCVTSr3Li3jFDIwe9XFPgF+qUDt3ZQ4fg8NWrET/kU1/4IdKDDkCL0sa1Ma
         skbII5XKmFi/Te9LkVb5OmB4MtZ9RZ0jW/qZv56+RhAgysb6hS2mN991+jmq1fExDCby
         zPCN+jOOUc/aoYpOmVaoYTCE2oU335xItwT7y1InlLzdYX+IgU0cSRtHbLC+oLxGB3EJ
         wz6MJUrozwrCuL4akoR/8IPWdnyRlO981LBRRM9V2jtz3AX661IQQdwHJzKNisw4o+5g
         gkdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733922424; x=1734527224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ajO8SVZT8o+VVLVONrOdRF9uwx4v4EetGOEOYG8GxoI=;
        b=fU6SqYkPJJx0QNnZr37S5j0/nHOQkxQsXdJQwTeXXdqOI1HGpk5BhixCM43EWw8LG+
         13JQVhrqjLg1C3/rU7axibEdUVbvm3Bbs6rOodqJbg4KEIjOH8mmghxJ0iH2qvefrwr/
         UmAbJfvxL1AO+gAG4ivSK3Ygg3FJ/YpmgOAoOBJUKV4Qid+OCpGdLlP87r+enzT4yzKl
         veC1RIx89vuq0d5WvLvapvi8NFXBQAIozkanKTwupOwu+ZctNwShYf2xo0X6lUIY/2Vg
         eetN/K41eFraDMN/DFuOXv/ESbUMDABpBljaw/rx35ormSHexwoCl4U7hh/n4hhjwlDV
         GHNA==
X-Forwarded-Encrypted: i=1; AJvYcCW1yHxnKp7rDO9EeqxRho7I1/aCkiw/TeYmMrwianCyFzyCHqX/xSKq9Snu5LEeJrxQjwR8oWyMyNI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs48lgnuleQhsKZLKz9tZo93IsnR/O0hH+Qf6qfetvwrVrze0K
	qZo4xnb9MolRshcRIhDgNCNTwzQFXqok32gG1WROOPguJkyjNeergqDASXR6D7bhAgwK+BwpPyU
	eLqflUnRAjyveklxzQ/zb2sizNs2DEkJpZ4q/
X-Gm-Gg: ASbGnctxayedlwHVCpvqFdQWf4+5o6+45Sb6/fvOHtPXx0cMvKb99zLU5ZbKWs6V2Oa
	6rBkc6hXS21y+Al65dLIxBQ5H1eAPdu/8DIF7tlbg2kZBXEb0BjdGksEGoL+yXxsqyQ==
X-Google-Smtp-Source: AGHT+IEhJRaYQ4zkD7C+J3qgfzqAwlKnMz5e40Q9S/qFEUiItjuVap1ArMXQypELUhyl4+1hMnvhfMslCQu9H3QwsGo=
X-Received: by 2002:a05:6000:144a:b0:386:3958:2ec5 with SMTP id
 ffacd0b85a97d-3864df10676mr1897567f8f.28.1733922424214; Wed, 11 Dec 2024
 05:07:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205141533.111830-1-dakr@kernel.org> <20241205141533.111830-9-dakr@kernel.org>
 <CAH5fLgh6qgQ=SBn17biSRbqO8pNtSEq=5fDY3iuGzbuf2Aqjeg@mail.gmail.com>
 <Z1bKA5efDYxd8sTC@pollux.localdomain> <CAH5fLgixvBWSf-3WDRj=Mxtn4ArQLqdKqMF0aSxyC6xVNPfTFQ@mail.gmail.com>
 <Z1jC7NnmwidLPT9Z@pollux>
In-Reply-To: <Z1jC7NnmwidLPT9Z@pollux>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 11 Dec 2024 14:06:50 +0100
Message-ID: <CAH5fLgg=fvQOVL-FH72BFtv-5r_e35=esNir9itG_29am_5Sng@mail.gmail.com>
Subject: Re: [PATCH v4 08/13] rust: pci: add basic PCI device / driver abstractions
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me, 
	tmgross@umich.edu, a.hindborg@samsung.com, airlied@gmail.com, 
	fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com, 
	ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org, 
	daniel.almeida@collabora.com, saravanak@google.com, dirk.behme@de.bosch.com, 
	j@jannau.net, fabien.parent@linaro.org, chrisi.schrefl@gmail.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 11:38=E2=80=AFPM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>
> On Tue, Dec 10, 2024 at 11:55:33AM +0100, Alice Ryhl wrote:
> > On Mon, Dec 9, 2024 at 11:44=E2=80=AFAM Danilo Krummrich <dakr@kernel.o=
rg> wrote:
> > >
> > > On Fri, Dec 06, 2024 at 03:01:18PM +0100, Alice Ryhl wrote:
> > > > On Thu, Dec 5, 2024 at 3:16=E2=80=AFPM Danilo Krummrich <dakr@kerne=
l.org> wrote:
> > > > >
> > > > > Implement the basic PCI abstractions required to write a basic PC=
I
> > > > > driver. This includes the following data structures:
> > > > >
> > > > > The `pci::Driver` trait represents the interface to the driver an=
d
> > > > > provides `pci::Driver::probe` for the driver to implement.
> > > > >
> > > > > The `pci::Device` abstraction represents a `struct pci_dev` and p=
rovides
> > > > > abstractions for common functions, such as `pci::Device::set_mast=
er`.
> > > > >
> > > > > In order to provide the PCI specific parts to a generic
> > > > > `driver::Registration` the `driver::RegistrationOps` trait is imp=
lemented
> > > > > by `pci::Adapter`.
> > > > >
> > > > > `pci::DeviceId` implements PCI device IDs based on the generic
> > > > > `device_id::RawDevceId` abstraction.
> > > > >
> > > > > Co-developed-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> > > > > Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> > > > > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > > >
> > > > > +/// The PCI device representation.
> > > > > +///
> > > > > +/// A PCI device is based on an always reference counted `device=
:Device` instance. Cloning a PCI
> > > > > +/// device, hence, also increments the base device' reference co=
unt.
> > > > > +#[derive(Clone)]
> > > > > +pub struct Device(ARef<device::Device>);
> > > >
> > > > It seems more natural for this to be a wrapper around
> > > > `Opaque<bindings::pci_dev>`. Then you can have both &Device and
> > > > ARef<Device> depending on whether you want to hold a refcount or no=
t.
> > >
> > > Yeah, but then every bus device has to re-implement the refcount danc=
e we
> > > already have in `device::Device` for the underlying base `struct devi=
ce`.
> > >
> > > I forgot to mention this in my previous reply to Boqun, but we even d=
ocumented
> > > it this way in `device::Device` [1].
> > >
> > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/tree/rust/kernel/device.rs#n28
> >
> > We could perhaps write a derive macro for AlwaysRefCounted that
> > delegates to the inner type? That way, we can have the best of both
> > worlds.
>
> Sounds interesting, how exactly would this work?
>
> (I'll already send out a v5, but let's keep discussing this.)

Well, the derive macro could assume that the refcount is manipulated
in the same way as the inner type does it. I admit that the idea is
not fully formed, but if we can avoid wrapping ARef, that would be
ideal. It sounds like the only reason you don't do that is that it's
more unsafe, which the macro could reduce.


Alice

