Return-Path: <linux-pci+bounces-25827-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE4FA88033
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 14:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A7F73A6DC8
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 12:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D64290088;
	Mon, 14 Apr 2025 12:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="OaO9G+Rg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-10628.protonmail.ch (mail-10628.protonmail.ch [79.135.106.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B8628FFDB;
	Mon, 14 Apr 2025 12:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744632919; cv=none; b=cLVGkoorEmamNPtRgKQbLFN8cGrVRW0MFp1Bcdkk+fcls27JTRHNxE1bYNjkau04FCWEpCMYwaxxYiHPCXwZDZBVNOr6EDRrQndcHpGfPU++KjxYLr5bA8o0XKdYw+qp+HS3s6hMgf8lwG4wNtjpBv5KFI7+3M30LLye9cgmZ90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744632919; c=relaxed/simple;
	bh=oca2unmatHku3o5dirlH4WdUgZRNMvMi6TJwThtLpxw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BWINPx9ytD3ob9R7wAhtA0mTB2x9MM79YR/yzr/SK/kcJfcjoiziAGDACevVYdehKk0nUxeNCXIMv+9SBN7SSOKddOZVw5YSYc/b5tZFxfeumsfRhF6f5Q3MOYlmu3AGlfDPvDNwhl1q3laljvXXIn3mk5AWOtVEQM6mtq9YGog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=OaO9G+Rg; arc=none smtp.client-ip=79.135.106.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1744632914; x=1744892114;
	bh=jaNDriKc/gf2w9ZI3JU8uqBPkII9SsT+iiGZ/PuIi54=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=OaO9G+RgZTAQYgNrq7F4ploS0Hfo9LBWVfxnosvoFvhEYwMRPoPpGqndZAdccBuHi
	 ucRiWU00sbe035HloTkcYv3p4J19PnqJP+2d+QgZVS+J+ITsn/YeoFHRpRKUKULqqf
	 lmU+B+wIVTYKW8QrJFVPyEvTlLF+OqXJCkxHhV5EZFn3M9TiyjNMjGCjJQMt9P5t02
	 kknmyLr5XEaFGrJTs9VsCeM9nRhXxtCUuarOQQxmxbL+qqM4niJjNm6UMxBuRWZ2nw
	 nNU2CZu2TSBOAKSHPl+eWeQCEnXO9Q5du9hyDX1Nxx3lroAfcsP3xBpkUFonjjCckA
	 nUMc+xzl3tjyw==
Date: Mon, 14 Apr 2025 12:15:08 +0000
To: Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: bhelgaas@google.com, kwilczynski@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org, abdiel.janulgue@gmail.com, ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, daniel.almeida@collabora.com, robin.murphy@arm.com, linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/9] rust: device: implement Bound device context
Message-ID: <D96CQYSHOQBQ.2NSE5QZNGG0JB@proton.me>
In-Reply-To: <Z_zt4Cfmn_gWnMot@pollux>
References: <20250413173758.12068-1-dakr@kernel.org> <20250413173758.12068-7-dakr@kernel.org> <D96ATODOGB6O.2JAJOWXMJG3VC@proton.me> <Z_zt4Cfmn_gWnMot@pollux>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 38b383cca383a845f034fc982a1b448e72685755
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon Apr 14, 2025 at 1:13 PM CEST, Danilo Krummrich wrote:
> On Mon, Apr 14, 2025 at 10:44:35AM +0000, Benno Lossin wrote:
>> On Sun Apr 13, 2025 at 7:37 PM CEST, Danilo Krummrich wrote:
>>=20
>> > +            $device,
>> > +            $crate::device::Bound =3D> $crate::device::Normal
>>=20
>> IIUC, all "devices" (so eg `pci::Device`) will use this macro, right? In
>> that case, I think we can document this behavior a bit better, possibly
>> on the `DeviceContext` context trait and/or on the different type
>> states. So on `Core` we could say "The `Core` context is a supercontext
>> of the [`Bound`] context and devices also expose operations available in
>> that context while in `Core`." and similarly on `Bound` with `Normal`.
>
> Fully agree, I absolutely want to have this documented. I wasn't yet sure=
 where
> I want to document this though. device::DeviceContext seems to be a reaso=
nable
> place.
>
> Besides that, I think I also want to rename it to device::Context, not su=
re if
> it's worth though.

Sounds reasonable to me.

---
Cheers,
Benno


