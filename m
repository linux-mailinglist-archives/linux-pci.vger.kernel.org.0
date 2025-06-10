Return-Path: <linux-pci+bounces-29339-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 971D4AD3CFA
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 17:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DFEF17D5B5
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 15:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B0B242D88;
	Tue, 10 Jun 2025 15:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ELSNAJq9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD19923A9AE
	for <linux-pci@vger.kernel.org>; Tue, 10 Jun 2025 15:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749568783; cv=none; b=Ev1mCn7VXCjr+LUG4pDXJUQ3ehnV+FM93GLRc2O6CW/a35759LwoKAAte2XjdSby+fL9HJ82lV77ACPWVzfMCVWVPyRKdfzmWPFbmka3WyPN3e6PO3yEQ4a+2omnZTXPgNfUupNGoiDtvHBBizKs46w8TREZdutgAttPNKreUJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749568783; c=relaxed/simple;
	bh=KNTwNJojHFp5A5rIHcOYYIryWECnrSG2W6CYmT9Fd0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pm/JB9QRUH4LO1Of0/GONS/+J6l086zVxtvS3RKZS58eS6jOMBEXld7iywryXdFXvweKnuLAizw4ShXrZ/jXiuN3s78P2lpvWLln/gNeSgx3/F3mKOHspzRjWuJXM1CmXqAeF/F32tsrjdEfVqbHUsMPsnKEgvTVsy0897KjTvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ELSNAJq9; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-451e2f0d9c2so43911985e9.1
        for <linux-pci@vger.kernel.org>; Tue, 10 Jun 2025 08:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749568780; x=1750173580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YW0nieYmsQXBJolx1s5UXdIQlKcolKiAvG7fZthRcUw=;
        b=ELSNAJq9msr3C2HcHQeJtkPo9oyxbAeoIZwdpIChfbrXLYMsNHC73ijV4wAlP578ZF
         GZCwTySz0zRuqUeRBQw8RPCmNWpinIQXFL+92J1Mws9x97nEv0zHhmVPhVRP8w+xldI+
         lyS+oE50xzq6znL2iGXcpldL8odWnUJAFHEH6YmFDbWzYIitlHqVXvuJ6kHO97/nCI7M
         CcO8ZJP2lLckjy3IO+1csJsEIA31L4GaTaK9bVlbhsgw7WReCd7M3vpoYGSEXllhGHle
         AAwyhAQh09/Z7SG8ilQJgDg4HX4pdqbKkv+eHY/hjWai7XGD0mJPBOm2u+ikWrtryauO
         wM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749568780; x=1750173580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YW0nieYmsQXBJolx1s5UXdIQlKcolKiAvG7fZthRcUw=;
        b=lvDeFjXJH6mFKSHozDiM6+douvt5VOr/33FjR+AWYhs/osAOon1LsNWHneUioNc9EF
         Jzq155h1kUDBkph6iUNWBTHGRAfBdS9JNi/EG/vGE8IGaAchoYDQGSE8BENrumFR8jbM
         rFssBALCSYnaiGwrpqU0zoOHxRravNyXeYjsgRt02axZ9BPFJlOX2Ln37GWUr5QjbCGJ
         7axZHyZJFPMKOXoqD2Yk9rPmpngMejxWf6v1R7cFWwglIk35VLZSOmE0t5bVN9FsBFfZ
         c3PplA6LGmjjJ1Avl3uCi9aFuRnIneaVRdL5s99YGNGMdVEu8Ko9Xv+cfz5LP+yLlaqr
         Cztw==
X-Forwarded-Encrypted: i=1; AJvYcCWH4bxv01dzL+JouOdzwq+NSml+cKWgjrMKO32c8Tv80Tb3FIS88xmRGkVrI5hfQP9oAa03NetrgTU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyj7vu14q91AKA08vnQrSgxtxcMZp2hc5I39XgoXNTVQEkDAtm
	V6JYMuj39e1EbulKcKegy2brYE4DyvHOA/Ltr3V56vmUK7xufqo0FYLNqVtZMPaSZZjNtJoiBYq
	Vm6Gc9qJJu+9IQZaIu7dsZLCHrEuuACOKJIRuHMO7
X-Gm-Gg: ASbGncv3+PaARqY/h27uUjocrQ+M5AMYFsumvP74APmwQfau6IyRGUm/DAwks/8MdHo
	9RO2Haz5a4LvjYyFtqC5wqnGYiQZBwTiRiXPMRMocBQTz8w2uCWfmNbP4tLjUuXMQHmWRC+lkr6
	pOo8KOw5hntCByi7JufzBu8pJAuQfGxr0sRfa0qYklt0vqm8lUmQSlRVA=
X-Google-Smtp-Source: AGHT+IFqGxKvYzEDcfYdT/8Vzy9FGlaa7n2tG2xFHxGeuwx+nr4DrKPv7MAiiXUDiWkmUEyc+5fF/UA1OqkjuA0VaTY=
X-Received: by 2002:a05:600c:8b6f:b0:439:4b23:9e8e with SMTP id
 5b1f17b1804b1-4531ceb5dffmr42177575e9.3.1749568780013; Tue, 10 Jun 2025
 08:19:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250605-pointed-to-v1-1-ee1e262912cc@kernel.org>
In-Reply-To: <20250605-pointed-to-v1-1-ee1e262912cc@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 10 Jun 2025 17:19:28 +0200
X-Gm-Features: AX0GCFtMwZY3Rr1XgWSXhrl7W6naEtd1_FQhRlmJt3qwR55UCc9vpUuFbY5gFKs
Message-ID: <CAH5fLggzYQcMhcscuODR7cu__LLKAXhZ0A-tsBGc7gGyAA6Ofg@mail.gmail.com>
Subject: Re: [PATCH] rust: types: add FOREIGN_ALIGN to ForeignOwnable
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Tamir Duberstein <tamird@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025 at 10:00=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> The current implementation of `ForeignOwnable` is leaking the type of the
> opaque pointer to consumers of the API. This allows consumers of the opaq=
ue
> pointer to rely on the information that can be extracted from the pointer
> type.
>
> To prevent this, change the API to the version suggested by Maira
> Canal (link below): Remove `ForeignOwnable::PointedTo` in favor of a
> constant, which specifies the alignment of the pointers returned by
> `into_foreign`.
>
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Suggested-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> Link: https://lore.kernel.org/r/20240309235927.168915-3-mcanal@igalia.com
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

One nit below. With that and things other folks mentioned fixed, you may ad=
d:

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index 22985b6f6982..025c619a2195 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -21,15 +21,11 @@
>  ///
>  /// # Safety
>  ///
> -/// Implementers must ensure that [`into_foreign`] returns a pointer whi=
ch meets the alignment
> -/// requirements of [`PointedTo`].
> -///
> -/// [`into_foreign`]: Self::into_foreign
> -/// [`PointedTo`]: Self::PointedTo
> +/// Implementers must ensure that [`Self::into_foreign`] return pointers=
 with alignment that is an
> +/// integer multiple of [`Self::FOREIGN_ALIGN`].

We should require non-null:

Implementers must ensure that [`Self::into_foreign`] returns pointers
that are non-null and with alignment that is an integer multiple of
[`Self::FOREIGN_ALIGN`].

Alice

