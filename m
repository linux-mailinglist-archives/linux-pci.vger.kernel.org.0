Return-Path: <linux-pci+bounces-43961-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 75428CF022A
	for <lists+linux-pci@lfdr.de>; Sat, 03 Jan 2026 16:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E0193300101D
	for <lists+linux-pci@lfdr.de>; Sat,  3 Jan 2026 15:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED5D276051;
	Sat,  3 Jan 2026 15:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cGCBNALO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08A01E832A
	for <linux-pci@vger.kernel.org>; Sat,  3 Jan 2026 15:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767454778; cv=none; b=GW7s3gMkp5an0ovOAhuDJCMqIGVRNU9NGoyk1ktdXpnhNL+sYupZaFcN2WBsQwbFocMqZ8IsRapnJ+K6DDoAes5Pmo5lcgXUXOEI9Bpg06N+kCFURFzaL168XQEMfCqYu3upjKGGY/gU6RdmtAGjJ9s5eYZ7Yokdcp3emxNSVq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767454778; c=relaxed/simple;
	bh=5DTP51OoE964av4TXHzuXB0250ODYdK6kR4s7+AnK5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VOBEckm7x95LMghYT4fxg+LoVv1h7xKmLt8bVjNz205JBVNOfVcr5hNxBH+OB3YrywiXI781PHJQamA6rWzpvZBdNhY3hMV0ky0yeOjiuY09+pj72rXdAGUd7dNnNKmviBtH3atSyY+M0KdkmaDI7EwBGa/bHIllVxokGWEbxBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cGCBNALO; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-65d1a094185so4493401eaf.1
        for <linux-pci@vger.kernel.org>; Sat, 03 Jan 2026 07:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767454775; x=1768059575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5DTP51OoE964av4TXHzuXB0250ODYdK6kR4s7+AnK5U=;
        b=cGCBNALOKWzIQ4FWOTbDdymwsb83BD2IDCsGDeJBTm7RaKoXSYpwWR5J9fRA1QKpGe
         +ZDMwxCwcV7X4OjwrxeVysj5VSvszi0AWFd82ekt+5cC6IfPueLptsswksh1ph3HEr+h
         5AX0HuwV9OcAMSXdsasv3kH2aXLkKlN4PjdQ3PTeSE8etDaTlHBdH9fICswIPW24QR1o
         7tbS2KEs7A+RFrSfGcJ4oaXOt7f8eXJYfVS75ygEKHvwHwnEI3HnlkHrsQ0kChAocajN
         OkWwXS5NI5YFCU40ow9K2OCl1/yHH5xyemMcl0S52FXTqfmzbgMPBnmYwmNCiaeeVOWr
         /Mdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767454775; x=1768059575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5DTP51OoE964av4TXHzuXB0250ODYdK6kR4s7+AnK5U=;
        b=LBy23WLLjKn5NHh9Ijw0vBQdgkLGek9hR1/fvsCnZiOOc5Yfs0OGhQ0Nng9ymzLv6G
         cchAAyQ8MwEcnhc3ulntMASaOI+97hhuhSdNY+bKwvgtiowMseaaojgbcDwKePf2sXol
         t15oD4yBaJ1Ha0qCGJXA/xlopzGM7XbqwW/y0PwHyETlfhRWadbBbegH/Lovvbhuq7dg
         4MQL0+0lywDOUu03kRYrNG7gubMA5Mh27ESmYz8cjIL3UVFyEaUUsgHRrGLujejB3lTk
         Z0xWsfUWtypfHfKblkgWWYJJLYuPpRVpoTDsbtLyccC+YMh/oFt3luDTKAkVD5T7QKGU
         ewIg==
X-Forwarded-Encrypted: i=1; AJvYcCWOkOVZdn+kekawncci5j/sLaSbQQVIhd6CXcTBEQQYLDh74iDzHL7VghGhfBBtF9YAXBctylxXufo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDA213c467EUiNsjLB2aMWTfQcrYIwd+q6hw+VCs9AQEykMZWN
	GerRgqFMYLQ25oDtbzXyDONF8KHbi+BicLhT9CSBxtVaUZ3/YaK045VOE3pm/OyTfrcCAEdTccr
	JWCJRFWKFCX/zDjciA4Oqmi5ZxA/hGEQ=
X-Gm-Gg: AY/fxX6fIZ+xJtcRM3ZBzogMkWDUiDhgZg5V24t8iBdRN8TW8cZDmcrBA1NL6hCCvvu
	+ML8jHgNgtj9Tytswoio+SDq3Hffn2GY0pCExyRbZX0XT+hnEK72nUnRfhZ52QJPxM2OKvXT/KJ
	HBEmBeXWrxF9BtVaFb83s97SC3qmenJ2ZPSGT5x0ICVBrFBmNaKRblAtMq4pVnHM60usNsBwDtq
	ggzK3UVR2KON1Qa4uZTBNDvSSg0wDV0St4+eCbH9UVAor+fZM2uIAN/HFStDF6+JXSxRDC4PS4b
	lvTljqJx
X-Google-Smtp-Source: AGHT+IFiF5bRlSstcAz55OLiRxMKY7gsIuUB9aJwmCNZSi8KHW8f/P2TP0ncCzwcFhgy2k62TT524m4brRRYvWIBsvs=
X-Received: by 2002:a05:6820:7804:b0:659:9a49:8f64 with SMTP id
 006d021491bc7-65d0ea9a762mr12009833eaf.41.1767454775431; Sat, 03 Jan 2026
 07:39:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260103-add-rust-pci-header-type-v1-1-879b4d74b227@gmail.com> <DFF1Y5LEQ85Q.V2AC0R1EFXNZ@kernel.org>
In-Reply-To: <DFF1Y5LEQ85Q.V2AC0R1EFXNZ@kernel.org>
From: =?UTF-8?B?7ZWY7Iq57KKF?= <engineer.jjhama@gmail.com>
Date: Sun, 4 Jan 2026 00:39:24 +0900
X-Gm-Features: AQt7F2r1h7I5GZG9Kc2q99Qlcmhl5gMhMKine4GGBX6EsdRmhyvaaLHFp0MwWGo
Message-ID: <CAGAB6648kOCF4GZV=wKUxEptzW_91BySPMqFSjE+L-TA3ufH-g@mail.gmail.com>
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

2026=EB=85=84 1=EC=9B=94 4=EC=9D=BC (=EC=9D=BC) AM 12:17, Danilo Krummrich =
<dakr@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Sat Jan 3, 2026 at 3:38 PM CET, SeungJong Ha via B4 Relay wrote:
> > This is my first patch to the Linux kernel, specifically targeting the
> > Rust PCI subsystem.
>
> Thanks for your contribution!
>
> > This patch introduces the HeaderType enum to represent PCI configuratio=
n
> > space header types (Normal and Bridge) and implements the header_type()
> > method in the Device struct.
>
> We usually do not add dead code in the kernel. Do you work on a user for =
this
> API?

Hi Danilo, Thanks for your feedback.

Yes, I am currently developing a Rust-based driver for nvme and ixgbe devic=
es,
which requires identifying the header type to check compatibility on
initialization.
I sent this patch first as it provides a foundational API for the PCI
abstraction.

Best regards, SeungJong Ha

