Return-Path: <linux-pci+bounces-23498-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2B0A5DF44
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 15:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 014FD3BB3FE
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 14:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E8F24EA87;
	Wed, 12 Mar 2025 14:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="b1oZhEt1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A40124E019;
	Wed, 12 Mar 2025 14:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741790470; cv=none; b=f2p9Y4YfId0WZ4T/Fug6PTabxgxXIN5GvKu+fI6B+LdLZstswjygADqG/2NQcr4LvevpCYh32bkp/esVZWk+J8Nl00SO4bKWRS2ELUpK4EUZ1tFZsmqybrgSqTxaMbjFA5j8Nbu+qmLQHhx4ZrBQAJxY6WOJgE0qA0xKbmbAfkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741790470; c=relaxed/simple;
	bh=8Z3f9St12qWcetrZIU5ZBX91BsZDoV5+6V34IbAU8/Q=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T53twsuPurMMToB6p69kCH91CjFJMK25vmNGLfYm/yIazjbQy3EnzPvHSChrw0ESztMDm3vOL3fUdun02EZfnAGNuWeZxgcgmQHJO4dSwUY6FWNeXSTOmxhegg0R1XBpu2YuTBRcpxtX1ppIxEHe+sAcQCmxJx2zi4JbYT9zkok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=b1oZhEt1; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741790465; x=1742049665;
	bh=D0FqqFXulxUsSxG/gB+0KynGvQTpgX0dOCuKKLUrQKA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=b1oZhEt1yfUJ61lbRrCyKeLedycU0anqAzq5qmFwT43G7bfsqd3jxepIuDJIgxOvG
	 FMq66nJtyptjBHahmEmYRMVv1tvUJJUmG8m5wuhxpCjP4iHmLH5s0fwtH6wiXKQsE7
	 v3AAMWJjkj7BGNqY+M2zRAutYn42y0AfFxJ7awi43zrXxtsx5bE6PmX9ZINbqnRtwS
	 T6prNkA/GYscjtlDBezLcdNYtU8ajsbs2Ms2uwX+TrO557riSF+v8i7mdAyFeuUbh1
	 +KHrPIQbTVTLTpD7gRuOT33ufFi8v2njzC4wQgJpKAWHuzCJ1MMI9PdYZqJTffs2Kd
	 yRnFsYvQ+cRzQ==
Date: Wed, 12 Mar 2025 14:40:58 +0000
To: Tamir Duberstein <tamird@gmail.com>, Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/5] rust: enable `clippy::ptr_cast_constness` lint
Message-ID: <D8ED6OB8UFD3.2O2SXDLJO5TUI@proton.me>
In-Reply-To: <20250309-ptr-as-ptr-v2-3-25d60ad922b7@gmail.com>
References: <20250309-ptr-as-ptr-v2-0-25d60ad922b7@gmail.com> <20250309-ptr-as-ptr-v2-3-25d60ad922b7@gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: e6f6237cc903833d4125e44bdcd40b2e67b08589
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun Mar 9, 2025 at 5:00 PM CET, Tamir Duberstein wrote:
> In Rust 1.72.0, Clippy introduced the `ptr_cast_constness` lint [1]:
>
>> Though `as` casts between raw pointers are not terrible,
>> `pointer::cast_mut` and `pointer::cast_const` are safer because they
>> cannot accidentally cast the pointer to another type.
>
> There are only 2 affected sites:
> - `*mut T as *const U as *mut U` becomes `(*mut T).cast()`
> - `&self as *const Self as *mut Self` becomes a reference-to-pointer
>   coercion + `(*const Self).cast()`.
>
> Apply these changes and enable the lint -- no functional change
> intended.
>
> Link: https://rust-lang.github.io/rust-clippy/master/index.html#ptr_cast_=
constness [1]
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno

> ---
>  Makefile                        | 1 +
>  rust/kernel/block/mq/request.rs | 5 +++--
>  2 files changed, 4 insertions(+), 2 deletions(-)


