Return-Path: <linux-pci+bounces-23528-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 806EAA5E4AB
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 20:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51B4F189F46D
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 19:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE72258CE6;
	Wed, 12 Mar 2025 19:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="DxXCHqgd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8822566DA;
	Wed, 12 Mar 2025 19:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741808611; cv=none; b=L8HyiIYSd5Pt/6ZqFf6FXGATtXwTtXM5KBxIJn1jM3hj4rbUixlbjrCAsO/T9PQWCcRr8oRE2QO0Bm6A2qNehtiqfPwWNOW0R6x7dD/8WcHadCjJ+sBCdO6RkW1S90jaPM0mxK84cCq4xCbBi6ePBDdBlm8frcLNQVj+Az8hfr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741808611; c=relaxed/simple;
	bh=MQpsvFjJVmn++42KDeejIYF6zbqUpGV1N2HykXJ9TvA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=olGqBlRP0h0UOEvd4DUfPxv1E8IoIsW/qa4Azz4+fWsSJASO16TMdIOCTpA/hiAyTMllPJjc0hFozICYz0j4Y4Oi1/7bzC1+zghE+liok4PzvZ716/1TitsaqpGKoE+AejK/qpcuyyK1FNx/Bt3WCp3gIGHVB8kZTeyOs+1cLHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=DxXCHqgd; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741808605; x=1742067805;
	bh=k2L8+T93x3C/emjGMuwyW/R5I8BeyS+0TxpevstosCY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=DxXCHqgd37hI1t1+mSl0RVRBwA13vQ/XVaB09BZ/O0VCttgrhLU0EjhZZiQkCK+I/
	 xirIOJ/C5+SaHokD1EEAq/798EGmTZaCDP/VR1350NPEJyWWqg2agQGAFYNisnikAK
	 pM9X/nXhCDpQzQLkpQKvirBihIDT0xyDlbu3pMqI9N59zX67RsIrN1lLmVuQ2JhfD5
	 tttJlaqwfmONRscNeiyAYqg3X1dlR/mn1+fT8HAYPfdkmzf8BEuLcsIshVhhMOvVoK
	 daXB5Xif7XB4RWcKuUs9smRkdiuD3NrsMernT3k90UVinCE/TWl7PwwxHM3UYlCPvY
	 l68ZcyT+sgJ4w==
Date: Wed, 12 Mar 2025 19:43:19 +0000
To: Tamir Duberstein <tamird@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-pci@vger.kernel.org, linux-block@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 5/5] rust: enable `clippy::as_underscore` lint
Message-ID: <D8EJM4CJ4HAN.1PB2YV8DB77V7@proton.me>
In-Reply-To: <CAJ-ks9=zWAuPUM_61EA6i5QkUpwtNtsN8oF_MUerWGn39MRHhw@mail.gmail.com>
References: <20250309-ptr-as-ptr-v2-0-25d60ad922b7@gmail.com> <20250309-ptr-as-ptr-v2-5-25d60ad922b7@gmail.com> <D8EDP4SMQG2M.3HUNZGX8X0IL7@proton.me> <CAJ-ks9=K06OT6cutUABj2QDHJHJ70719c-eJ=F3n-_bhkYbZ3w@mail.gmail.com> <D8EG9EM9UU0B.2GLHXRU2XROZ3@proton.me> <CAJ-ks9=+3MQb-tp8TAwYvVj=GOFFFVKJxRMprc8YXZHKhqnDrg@mail.gmail.com> <D8EIXDMRXMJP.36TFCGWZBRS3Y@proton.me> <CAJ-ks9=zWAuPUM_61EA6i5QkUpwtNtsN8oF_MUerWGn39MRHhw@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: bbd40c62717ae5f9397b8b9c9ae87ff25634c232
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed Mar 12, 2025 at 8:19 PM CET, Tamir Duberstein wrote:
> I tried using the strict provenance lints locally and I think we can't
> until we properly bump MSRV due to `clippy::incompatible_msrv`:
>
> warning: current MSRV (Minimum Supported Rust Version) is `1.78.0` but
> this item is stable since `1.84.0`
>    --> ../rust/kernel/str.rs:696:22
>     |
> 696 |             pos: pos.expose_provenance(),
>     |                      ^^^^^^^^^^^^^^^^^^^
>     |
>     =3D help: for further information visit
> https://rust-lang.github.io/rust-clippy/master/index.html#incompatible_ms=
rv

Oh this is annoying...

> This is with `#![feature(strict_provenance)]`. I can file the issue
> but I think it's blocked on MSRV >=3D 1.84.0. But maybe you know of a
> path forward :)

I think we should be able to just `allow(clippy::incompatible_msrv)`,
since Miguel & other maintainers will test with 1.78 (or at least are
supposed to :).

---
Cheers,
Benno


