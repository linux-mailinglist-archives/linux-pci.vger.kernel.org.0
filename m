Return-Path: <linux-pci+bounces-30331-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96215AE32CD
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 00:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58A0818908F0
	for <lists+linux-pci@lfdr.de>; Sun, 22 Jun 2025 22:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBCD21ADB5;
	Sun, 22 Jun 2025 22:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="coGzih47"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDDB183CA6;
	Sun, 22 Jun 2025 22:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750631398; cv=none; b=QLPLZCLoq3xysulMRnwqNoUYuPQ618dY9g2aKXgg7cExelMitrixFoGVgK9xX7Z5uKzYArzMjfDzyPy71G3tYOMbUhNRSSx1cWUGdE5FeM0gpVn4bbStoe8GL9HK5kMVOlRQfKv8yDqvc1SyGnmG1h7QrHDssTPDsmapLHIfvfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750631398; c=relaxed/simple;
	bh=OYu+AAgQhYC87NCbElQfdkmObnYbtApn+25dtMrUN0U=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=rmmJ6TClMM/QzVVEmRt7wwgW7qqIMiizBNwcTxb9EeclO1FWsu7LvVAPEPFbUyPUqfR2TGDfEMbAiZsd8QeR1V9NyYaHQWPIQQPzJUVAH0BT+1m3+bXBgb2c092npeCfVIDzBbd5Q2MBue3vKNAj2D9LlL5oPD1+yLKyVC8/bVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=coGzih47; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82A84C4CEE3;
	Sun, 22 Jun 2025 22:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750631398;
	bh=OYu+AAgQhYC87NCbElQfdkmObnYbtApn+25dtMrUN0U=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=coGzih47BfetxAdLNbHQqy1DJXPtnmoVvGRkqITYjWychHIFjmPRbjc2dYVjxMpEP
	 ld1gurh4xqFu/SCFBY11uiNNLXipApZK0ZZqIkQkr3dfXAZcDcR4fm0O8VM6pSymSC
	 F/pyeoddxP0JYuzvOqn7f121WNLQJlhwdJ1OsuLtloclCRwId3VyJTtAwky46AXJPw
	 TLDD4JkGRtqg8VM6Z9Cg7Lizc38IfXDLyHWqkTeTVtbrwHX34fnUriqvgZXvMtWFBj
	 h/Ek9QR1nVjl/SyEOb/fxtQvvxp7l/L4M+Nw4juWXydoVxxrSSra+MUlQFD6jSeguP
	 jGm04KNrW+5pg==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Jun 2025 00:29:52 +0200
Message-Id: <DATF1BEX3XN4.LCZYZASKZA9P@kernel.org>
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
 <aFh0p5p_89025kcg@pollux>
In-Reply-To: <aFh0p5p_89025kcg@pollux>

On Sun Jun 22, 2025 at 11:24 PM CEST, Danilo Krummrich wrote:
> On Sun, Jun 22, 2025 at 11:12:28PM +0200, Danilo Krummrich wrote:
>> On Sun, Jun 22, 2025 at 10:47:55PM +0200, Benno Lossin wrote:
>> > And maybe a closure design is better, depending on how much code is
>> > usually run in `release`, if it's a lot, then we should use the trait
>> > design. If it's only 1-5 lines, then a closure would also be fine. I
>> > don't have a strong preference, but if it's mostly one liners, then
>> > closures would be better.
>>=20
>> It should usually be rather short, so probably makes sense.
>
> Quickly tried how it turns out with a closure: The only way I know to cap=
ture
> the closure within the
>
> 	unsafe extern "C" fn callback<P>(ptr: *mut kernel::ffi::c_void)
>
> is with another dynamic allocation, which isn't worth it.
>
> Unless there's another way I'm not aware of, I'd keep the Release trait.

Ah right that makes sens.

---
Cheers,
Benno

