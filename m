Return-Path: <linux-pci+bounces-32272-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F0BB07877
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 16:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E66CF167938
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 14:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723BC2C326B;
	Wed, 16 Jul 2025 14:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zgMaAmSK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9763A264A90
	for <linux-pci@vger.kernel.org>; Wed, 16 Jul 2025 14:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752677170; cv=none; b=FZ0cZpYs5sWUXlUyOxiH3J54DFXOBmzuVDUjFfsFCBTA/+sTwLNZoUylBEnhidrpU//4zQMgA12xggYfSwW7GfX8axV79hxSb1uQxBFq1SVrRDuDFFrUZgs9l8m3boyJlHCR5mdWqFl6rhNVyskSBnXFZzmenVSuLHCXJkEXrBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752677170; c=relaxed/simple;
	bh=n9/z3fF/0C01CrHoIFHDdD5Sh4DiNFnhLvxjo7maOh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OiR4S+6mfGHnxN1Xo7KN8SNYe0iQMSNKI4khAmNRCzsCNbRJrKHJgQQa9ucPKbwxmFkiY0TpH0097sTiCZjUwmfflCrEinEI44tzZ1iU+rctvvnp6Om9YfKrOelstrpdXrwA7VClqozgKIgsA29ZQ4Fmz5hOKsGWNB28UYbir+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zgMaAmSK; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a54700a46eso4243798f8f.1
        for <linux-pci@vger.kernel.org>; Wed, 16 Jul 2025 07:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752677167; x=1753281967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KEGvPpVqb+Fvi+UqK3fdVHqFf016XV/901kj1g7cqLs=;
        b=zgMaAmSK94g2I8c8PpcPcsLxjXsmgEKqYQsKxqI3sTM/1hHqJjAlYU23bY4t+GghCy
         xcP0xn6a9GWCCEH81azOjJPcT/+Epw0Zjj2S18m8qBqN+999GAqSWP/imrxQ74s+tofu
         HvFpi2yXXWKypD4w0bSBgeJZXTWVjdxz2eUoUHdzUqIyJ+Y06BFCosI9A0qJhhbPfMrK
         QaMeR34/xbwet7QBKss8K27+7gP5drJZ2itHjmmE8YIZ9b4/0jUTsuRfi0yAStEwa7St
         pWkifvAWIe63Vw9THEU6kXt/ab+NNx4LVdEo2PoiKuThtUz95ucTeMWxW2MEu5F+t4ce
         +RRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752677167; x=1753281967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KEGvPpVqb+Fvi+UqK3fdVHqFf016XV/901kj1g7cqLs=;
        b=kF2TLHrN/hiGhuLMe17NEzFVQveuiYjWjAgYaU8UNT3uYM/sdyrYaY/wdAgOuksZvE
         DKFYaLXu+TiObqsF98qUpesr66heb5FQ3xrQYAaheb9V5YkzVihNqk5M8DX1TBv2kJGO
         urRY2ftcEbKt+PGapdSOQkWGba7WEyUFs/b/WYvAeBXYVmU5VkewkQu37/LBgZ/R0WQD
         ee1mKwD0Wzn7iHV/tm8fEcwS9QjDE6H+y9X3Arm8eTTBrkB1F9H5azqfGxn7wMEQhwIm
         IKBeX+SdEmsk/mDbyMK2vkYFrYH54NsHQee3/KJCAXb6peGUhyEanluM5oP+82xHTMOm
         VPXA==
X-Forwarded-Encrypted: i=1; AJvYcCVEuhlp0XGck1o35eXUvLBGC4B3zxoZSnq9a7Vc+oF5K1mHiz83BRjebLtOw4rieTgY2msY0Bszzzk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye8uQDQzaxr40/Mr+VKBhWvTRHqwZNrZZ4iwfliziyASKuYbSL
	9x7Q3HGv78OsIvHtZEkztrtFLaz7WHXLu9p8oEIR3UFaDpvdm6wi8kx91mRNOK76qm6RQJ60ps5
	ruVpzdIwieemPOcd+teBK29PJNzAncX7XOxEROU8D
X-Gm-Gg: ASbGncs31LxeDiYZ0zbMSZzj0AkRf9C/DcuW5xBIlAov52pk67DI54UAzAaHRIw/pWQ
	yeEB64G+w1XIEk2LM3JAhrl7EBI5E7EV2SrFM2r22DPz25YhjMGhoIygE9GmhTcygdKm7zFp9Wk
	95qz8gWmzpnpxHIYWEsbZBWScySgFOjqX+O+JeAH7z62FESV/hgwJSmegfYgpxGbI4XdzI6wZ9b
	ali5UoG
X-Google-Smtp-Source: AGHT+IFAHBnZHLNrYyKfSBfa3jy+sfO8JJ+g2wXjd/pOkO9jRLTgL6WfpFC+NoeQ+/d/j4coTHY1LmnzbgyS/z9vVPM=
X-Received: by 2002:adf:cf0b:0:b0:3a4:dbdf:7154 with SMTP id
 ffacd0b85a97d-3b60dd8e5c4mr3015978f8f.54.1752677166930; Wed, 16 Jul 2025
 07:46:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250715-topics-tyr-request_irq2-v7-0-d469c0f37c07@collabora.com>
 <20250715-topics-tyr-request_irq2-v7-2-d469c0f37c07@collabora.com> <31EA1044-AA9F-41F1-97E7-D3C582C32167@collabora.com>
In-Reply-To: <31EA1044-AA9F-41F1-97E7-D3C582C32167@collabora.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 16 Jul 2025 16:45:54 +0200
X-Gm-Features: Ac12FXw4o_IZHo511I22hzkAseLhPcYg2xUkAXmB7tIIzyMTFWEK49V4bjcBMlM
Message-ID: <CAH5fLgjYcw4tX_CLKQYvR8j=aG0b0n_VYXOYVhGUUB_5s3A1AQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/6] rust: irq: add flags module
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Benno Lossin <lossin@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 4:20=E2=80=AFPM Daniel Almeida
<daniel.almeida@collabora.com> wrote:
>
> Alice,
>
> [=E2=80=A6]
>
> > +
> > +    const fn new(value: u32) -> Self {
> > +        build_assert!(value as u64 <=3D c_ulong::MAX as u64);
> > +        Self(value as c_ulong)
> > +    }
> > +}
>
> Sanity check here, is this what you meant?

That's fine.

