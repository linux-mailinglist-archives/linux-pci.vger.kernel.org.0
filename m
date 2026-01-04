Return-Path: <linux-pci+bounces-43974-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2219CCF1103
	for <lists+linux-pci@lfdr.de>; Sun, 04 Jan 2026 15:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BB45B3004F05
	for <lists+linux-pci@lfdr.de>; Sun,  4 Jan 2026 14:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF24C219A8A;
	Sun,  4 Jan 2026 14:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WyTCZa0g"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284E6225413
	for <linux-pci@vger.kernel.org>; Sun,  4 Jan 2026 14:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767536642; cv=none; b=RPCPgLLR00Hp2/TA7rpTlRAhfeVMy0bZMMG789qOvHfy49DhMsUnbvTtLVZ4xGUsHDVwTYza+pvPbsEUFCSrw/Bg6x7mSkrqqr5fVQFevhsJC/4ptm4xqQaarffC3HEJ30WCkIXTVlc2FYf2CyLHk5ooj6hw7uqV8YxxZ18CLUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767536642; c=relaxed/simple;
	bh=SHcPaN26m7tnkGXNQr+MqluXAtXVdm6nBqdxWF9tneM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oyn5aBOnBNKGdBx0grpTdqakdMg94dI8TDKDM1JUNsnUMfYK+yUyUoJs6rCAzPQDOqUOUk4SPoAusvP+Yrt3T1jSCfTBwXV5CiValdb7tfjwTxw5tkny6BcMKBrZVVo//gnJ5Pd0wsIR4fhW1sF5MtWSNuLsUpEYD+Fa3RKdGM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WyTCZa0g; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-459a516592eso4563222b6e.1
        for <linux-pci@vger.kernel.org>; Sun, 04 Jan 2026 06:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767536640; x=1768141440; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SHcPaN26m7tnkGXNQr+MqluXAtXVdm6nBqdxWF9tneM=;
        b=WyTCZa0gr2GVpQpBtaTcsCKMQvjh5oXONXqnJZQKawm5PjQlHF8721jkBY1u0MYUJz
         qgfy9E3wJzRTP2uL3PpXhdYht6YXGFBRDk1JoYLCbRgfS0B77LS4khm9wyN17l4jcCuD
         MoShlv1TfVcuVWlYBPfwFbiGObsP54HvBvy+qcpxbRn3IWFvT+xCo6LfD7roKZYTbT95
         p1foDogH0m0HvvhIC2deV61obxy0kL6ClgQdb5kKYQnXW066KWu+Cnyg01H2Nyn7XHjt
         2yL2LrAzJO1thVMk0q94GGoSHVBJgV+w2GZVwqbuZlr5SgkLFVWyClkq90dTyPR8+9v4
         qeog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767536640; x=1768141440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SHcPaN26m7tnkGXNQr+MqluXAtXVdm6nBqdxWF9tneM=;
        b=sGQIIAxLUkeivKO44PYboCCFZekNPeCdDIGEZIdE0G7ytwS6n58ghBr1peylPRgb7x
         hAOUEAiyuajAZaOzi1GgBtq+xuy3AfHEjH9+C7akJ+rBg1apM1CvjJf4FvyHxkEpGeik
         68A3Zf+kQ3GqHcHXhL7Nh28D/veBB0w6Yg0iX8lSeFW+7guW5xxyLE+GGeFRFkF+jzp1
         XpbS6FyA35YoCDAhz+/M2ocLf1whVvNvcvBjkBFLTV7AotnMaqFHu7BIntIyktk3uI/k
         g5w6Jsi+4EsYFDiXHxQmGbqKxDH09n/7Tbi3rx0GjHxKJRZ7+cxhc1jtXa4ufWiFbwtG
         H85Q==
X-Forwarded-Encrypted: i=1; AJvYcCVftfN7gIDKMpCYzFiKKO5AyOlWD3PXvT4pdh+hr5ZY9lvjQg2+NQLlP0Cq/R6CEWXmgWbrFVXnIrw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+h0LyoKiY+7SZv/mQnaTI+OidItrAQmaQUobAaXn7sp58OjCN
	HXeo9Vqgbb4o99cwjPu5dTsO1ve3P6FNCCqRENhbYfIxtvVkDX1+7EAEI7GYgIvkTP92Cvrvk0b
	6GEeF4dw0ktQodPkYhtcI/HjElVuXnMA=
X-Gm-Gg: AY/fxX4eEVqiehebLy/7gMgagu+ogXZEWHQgyn6v52VTZ1OlGOs5imaNaszS3cin56u
	fKALe1+qKlNcBbXDyKYIzQjVfzRDNqr092P995UMvOpw+0ZSlm/IxUF2RXfSkmNL/brPF8u4zN1
	m0JxIKxo3muoWFig4hM+/LgarkEcLutVF1hVGlqH9afaFa+3DoOAMbMXqAttMzSH8SFtycHMLrz
	1QfYySnjblvWN4eqoTdaBn4CCDQHYkP+LNntrDilgLLRG+dSKHu64YrkJYtQH7Hl+t5tI2lQg==
X-Google-Smtp-Source: AGHT+IE80sPzkJouvn6pDvfJR1AYQedhLGjsMIAuzkpaS9EhhohGgzBj072ItCnm5C5B9f/Wvz7i7LuiYuIc1etQi7M=
X-Received: by 2002:a05:6808:218c:b0:44f:dec0:b995 with SMTP id
 5614622812f47-457b229e1b5mr19780191b6e.61.1767536639936; Sun, 04 Jan 2026
 06:23:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260103-add-rust-pci-header-type-v1-1-879b4d74b227@gmail.com>
 <DFF1Y5LEQ85Q.V2AC0R1EFXNZ@kernel.org> <CAGAB6648kOCF4GZV=wKUxEptzW_91BySPMqFSjE+L-TA3ufH-g@mail.gmail.com>
 <DFFUIKLNVQB6.3UDMOX8TB5XDQ@kernel.org>
In-Reply-To: <DFFUIKLNVQB6.3UDMOX8TB5XDQ@kernel.org>
From: =?UTF-8?B?7ZWY7Iq57KKF?= <engineer.jjhama@gmail.com>
Date: Sun, 4 Jan 2026 23:23:48 +0900
X-Gm-Features: AQt7F2q4YN8HutDp9ScdcBA4s-TV0BfqRWNqODHBg_fsVA3Q02F0TpJxOs6iK5s
Message-ID: <CAGAB666VQ764O-d0WoeOpu7uO+y+VV0TMisSfZ0n-7ENjO0BUQ@mail.gmail.com>
Subject: Re: [PATCH] rust: pci: add HeaderType enum and header_type() helper
To: Danilo Krummrich <dakr@kernel.org>
Cc: SeungJong Ha via B4 Relay <devnull+engineer.jjhama.gmail.com@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 1=EC=9B=94 4=EC=9D=BC (=EC=9D=BC) PM 10:40, Danilo Krummrich =
<dakr@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Sat Jan 3, 2026 at 4:39 PM CET, =ED=95=98=EC=8A=B9=EC=A2=85 wrote:
> > 2026=EB=85=84 1=EC=9B=94 4=EC=9D=BC (=EC=9D=BC) AM 12:17, Danilo Krummr=
ich <dakr@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >>
> >> On Sat Jan 3, 2026 at 3:38 PM CET, SeungJong Ha via B4 Relay wrote:
> >> > This is my first patch to the Linux kernel, specifically targeting t=
he
> >> > Rust PCI subsystem.
> >>
> >> Thanks for your contribution!
> >>
> >> > This patch introduces the HeaderType enum to represent PCI configura=
tion
> >> > space header types (Normal and Bridge) and implements the header_typ=
e()
> >> > method in the Device struct.
> >>
> >> We usually do not add dead code in the kernel. Do you work on a user f=
or this
> >> API?
> >
> > Hi Danilo, Thanks for your feedback.
> >
> > Yes, I am currently developing a Rust-based driver for nvme and ixgbe d=
evices,
> > which requires identifying the header type to check compatibility on
> > initialization.
> > I sent this patch first as it provides a foundational API for the PCI
> > abstraction.
>
> As Miguel also pointed out in his reply, I'd like to see a patch series w=
ith the
> driver as an RFC patch.
>
> If it is working, not too far from an "upstreamable" state and the subsys=
tem
> maintainers of the driver's target subsystem are indicating willingness t=
o
> eventually take the driver, I'm happy to go ahead and merge any dependenc=
ies.
>
> - Danilo

Hi Danilo, Muguel!

Thank you for the encouragement and the clear guidance.
Since my current driver implementation is still in a very early stage
and not yet
ready for public review, I will focus on maturing the codebase first.
I will come back with an RFC patch series that includes both the PCI
abstractions
and the driver once it reaches a more stable state.
Thank you again for your kind feedback and for guiding me through my first =
patch
submission.

- SeungJong Ha

