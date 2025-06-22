Return-Path: <linux-pci+bounces-30329-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3157AE324C
	for <lists+linux-pci@lfdr.de>; Sun, 22 Jun 2025 23:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12D4F3AE881
	for <lists+linux-pci@lfdr.de>; Sun, 22 Jun 2025 21:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F85B1A2390;
	Sun, 22 Jun 2025 21:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FBBw85tE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738BFEAC6;
	Sun, 22 Jun 2025 21:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750627222; cv=none; b=OB7lpaRAtXIUN3QjSMbhNZRjCQVSGL85IES9iIcBXTv+lv9n5DyJA8sNzrY0hZDx9caF4hT3K7286aNe7C85i01l5C8AIWXoefmf5r4G0mpN0oOtQf9mkW4zoCVqqV6+iEUM3mcAZ/QMyr6U0YR7QvyTr7dIAufN57D33h/VB9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750627222; c=relaxed/simple;
	bh=n1un8LAYZ6VeYz6wNJyRD1+u/gnG9pv0/DxIgQjx3Fs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=QAxhtyASvmbi+/oRkgbrrrzLJYmXrktYAPB3tvJFhar40jREZiO19gzgqzSZZpIu0z/D1628F7+xkg4wNQRWerZOcgJtGwSBSp7zCUiD+EiRpCaafcozKHOJa98i7/ntNmaeZA6R7Sn2JxeISbb6UG+8Oe69/W3A7HCRbczgqUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FBBw85tE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FD49C4CEE3;
	Sun, 22 Jun 2025 21:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750627222;
	bh=n1un8LAYZ6VeYz6wNJyRD1+u/gnG9pv0/DxIgQjx3Fs=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=FBBw85tEc8o85lloEK/qjVQthBWpAc8hGQynNvRYx98B1vqCUycAVH2QmzK6iWElx
	 ds19XoZXoWHHMgfY/YqKz4hxP5RzSi2wB/uGdgtVNxP83scx2l0fwagiMzzyrIjUbh
	 Ud1TOcfPrGoQ4ln2Epq1fBqEHIREHPRCkE7PCsTfO1gYiE3wtRutKDcAK8JVG3cIfY
	 Q1j/YlOIPaM0OPnEhPXdekr7J441FyoOEoPV0QPbyuWvbPjPjv4WMLDsDE3zOsqrbp
	 14ATcRYdOz6BdQyZRiTusAe7ZRzvETuG2Xfe29SxxKZATzsWs/70amKPWdbpM0/o2p
	 IIOqgvLrhOHug==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 22 Jun 2025 23:20:17 +0200
Message-Id: <DATDK117JU2W.3QRBUS95CFSAJ@kernel.org>
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <david.m.ertman@intel.com>,
 <ira.weiny@intel.com>, <leon@kernel.org>, <kwilczynski@kernel.org>,
 <bhelgaas@google.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] rust: devres: implement register_release()
From: "Benno Lossin" <lossin@kernel.org>
To: "Danilo Krummrich" <dakr@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250622164050.20358-1-dakr@kernel.org>
 <20250622164050.20358-5-dakr@kernel.org>
 <DATCV8XFK7TO.2MYZKKA28JEQV@kernel.org> <aFhxtv5tOavHP0N-@pollux>
In-Reply-To: <aFhxtv5tOavHP0N-@pollux>

On Sun Jun 22, 2025 at 11:12 PM CEST, Danilo Krummrich wrote:
> On Sun, Jun 22, 2025 at 10:47:55PM +0200, Benno Lossin wrote:
>> On Sun Jun 22, 2025 at 6:40 PM CEST, Danilo Krummrich wrote:
>> > +impl<T: Release> Release for crate::sync::ArcBorrow<'_, T> {
>> > +    fn release(&self) {
>> > +        self.deref().release();
>> > +    }
>> > +}
>> > +
>> > +impl<T: Release> Release for Pin<&'_ T> {
>>=20
>> You don't need the `'_` here.
>>=20
>> > +    fn release(&self) {
>> > +        self.deref().release();
>> > +    }
>> > +}
>>=20
>> I still think we're missing a `impl<T: Release> Release for &T`.
>
> Yeah, I really thought the compile can figure this one out.

To me it makes perfect sense that it doesn't work, since `T: Release`,
but `&T: Release` is not satisfied.

Also a funny note: if you add the impl any number of `&` before the `T`
will implement `Release` :)

---
Cheers,
Benno

