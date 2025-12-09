Return-Path: <linux-pci+bounces-42821-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54220CAF080
	for <lists+linux-pci@lfdr.de>; Tue, 09 Dec 2025 07:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 51449300BA18
	for <lists+linux-pci@lfdr.de>; Tue,  9 Dec 2025 06:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4390335959;
	Tue,  9 Dec 2025 06:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2xC+ia2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F6E1ACED5
	for <linux-pci@vger.kernel.org>; Tue,  9 Dec 2025 06:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765261769; cv=none; b=LZsYTHQYb4GriUP4wIyrjMrOf/0vM/h+f/1l5/zc1jH6RTnLALfAAUsSIg52AgXJ2M5LImnHqJsgxvDdOr1055VlpbJHb7/3nQ39GG6xWRUDeplzwAxmOmvdQGRlh2593kCddK/hor+TrDxB6+uunC4p1CEUjTX3UGvnWUmMETo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765261769; c=relaxed/simple;
	bh=4wu4HghV9eutcXZg9QykpHAVBOCpOEqzmk05aTWPYjQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fe8eogSaszbTXuS5ym1dCGa5/VNPrZn64TKK8DORXh7qSxFFMu2zdGbZPjJ+yAyivVA8J9Z9BlbxN7Z0yZacp6O66+h2ZL9wP/m60uTsOSBzRF2xS4ECXPzHbSZ2PJxScniWeqIlJhVR3/ZnuZ8HM0jQaAAQMe1pVCJonTn/svg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2xC+ia2; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-bd2decde440so376481a12.0
        for <linux-pci@vger.kernel.org>; Mon, 08 Dec 2025 22:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765261767; x=1765866567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/okAXkk7BGFghBjc5ApOsP8AJT8qAM3/hNVNZVYhOY=;
        b=P2xC+ia2QdKG4/JMXldylEDcpdI3/9YQiXVJVmqb3n4WuwICF0A2HkLASzkuJO9dzL
         8Dz1s1kFHk37A8C3U5VtGoht3RK2hgtHQX3CcYpv7eJOA7r/AQhizjzpdEVldhMA3tMm
         9hxC6BXBsw3ZrTvlEHO0EeL+n6quZPMCo8iYF+oRuT9q/bWW10d26VQ7p8riClwqbAiy
         zPpt6nvOdmRVYTijHkcswAlNeGJIm7WlESlrFQgWAwfAvhlYTxNVk+T8Nngl4iiqbZNK
         TO2oWraRZB1Dfm2k9o21/kZ+ec4waz2B2onlqlfNsJz89vtooXY0VC0BmQx2LL0MI0Lt
         ZQGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765261767; x=1765866567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F/okAXkk7BGFghBjc5ApOsP8AJT8qAM3/hNVNZVYhOY=;
        b=iK5KQu1jNcOqQetCWwROfh2zIUNnjkQVW7PCauEgyaOKdToLUtIgkDI0KTbspLBpN5
         lRS5BUG7wB7npGyWcb/fishs0jwPbIyGhMbe5aYZ73Afepm0jRCvisDFZu7zxsfA07zV
         KqKgM49DpLh9Cw98dktXWCEKNPaWTXspW5ZC27yYKxiW/Nmv9nFR/L34KF8zrP+kAcew
         l/hDQFZ/KzJFfHgeRhNgDL1FH3kzKlGeojmEcaBfgn/hlxzUBbUgv4M03aUfU36qn5rT
         nVDjFOWTZxMbLRjGiHumKIA8y7WAuDwJqHOCTZx5XzoU2q0sXZHIxgFxgBrT7w6NbG2Z
         LcWw==
X-Forwarded-Encrypted: i=1; AJvYcCVsKCOcTtgd3F9O/NL2AMdfJytkHarSS5E4iJvWDKtnCuLtfKHvtiYevO9wnofNiurmmroMtCvpMA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFi05EA2BJIO5cDQD2ilsxmHglGWKfJaKSm0n4ETvCA8JHPzdf
	0HzHmJ2aVYWDe7HUlcnZhl2sfSEQJP6r7fc6Cu+YmYc5m9HXawVGpt1UBr2XlUsf2WUOVQAdC7V
	y7kr3U54LdijVaZF67IkoymV599MTyLY=
X-Gm-Gg: ASbGncvB93GSNCTPOFAlhsmsAUobliFvLLQC/h5hKbtvSwREwXvCgJRwA/B0VPcq9Xv
	stzSzENeZx9o2qs6QMEdB4Xkf0D2Vg7mhPG/UsA1O3GK4btuIUOEh1AvVVDyxOEL1FhY7hMCCAE
	4S2huVMJ3RyEnW6Vfl3sSdJn0CYcyNYheMi0xRQxnhV5bP060VVXDc8CnADE3swO/SyRZVgBffN
	IZ6/3t1Eie5vG/kxvf3+We1/Ya2I/mE92XWJ19eLgDADSt33nlimwLIlKlm/Jmdz7A2ksjOAAC7
	9ez/Jg/5VbNpuegNhRu1sKCnmMlGIVPbhk9u9Z4E1MubksNy9dcUyCc3Iv1JHO3f/LnZFGxuoCt
	tfTwklkVbcq1p+Q==
X-Google-Smtp-Source: AGHT+IGRuNySzZFg7LnxO0DUBwmTDE2SGnhd2Hq7klfkMjK1ebsVPO1rSgGRAy0b6w6lmNPUlHQbLRmAlrxzvF6MMX8=
X-Received: by 2002:a05:7300:b919:b0:2a4:3592:cf89 with SMTP id
 5a478bee46e88-2abc6f5253fmr3734203eec.0.1765261766948; Mon, 08 Dec 2025
 22:29:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251209014312.575940-1-fujita.tomonori@gmail.com> <20251209.151817.744108529426448097.fujita.tomonori@gmail.com>
In-Reply-To: <20251209.151817.744108529426448097.fujita.tomonori@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 9 Dec 2025 07:29:14 +0100
X-Gm-Features: AQt7F2r_TvGDcpVIBygy_ezYL0Tnw2PmcofnZL97AP3BScTrwyy9ndPCst7m11o
Message-ID: <CANiq72m=XqGpkJt2-KrbaHMAJ2bMLEk0k-EyDX5iX+XmeE+cUg@mail.gmail.com>
Subject: Re: [PATCH v1] rust: helpers: Fix pci_free_irq_vectors() build with
 CONFIG_PCI disabled
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: rust-for-linux@vger.kernel.org, dakr@kernel.org, ojeda@kernel.org, 
	a.hindborg@kernel.org, aliceryhl@google.com, bhelgaas@google.com, 
	bjorn3_gh@protonmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	kwilczynski@kernel.org, lossin@kernel.org, tmgross@umich.edu, 
	linux-pci@vger.kernel.org, Guillaume Gomez <guillaume1.gomez@gmail.com>, 
	Alona Enraght-Moony <contact@alona.page>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 9, 2025 at 7:18=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> +#[cfg_attr(CONFIG_PCI =3D "y", doc =3D "[`pci::Device`](kernel::pci::Dev=
ice).")]
> +#[cfg_attr(not(CONFIG_PCI =3D "y"), doc =3D "`pci::Device`.")]

Yeah... these become fairly messy and we may have quite some of these :(

Hmm... This is tangentially related to the "references map" proposal I
have due to the custom intra-doc links syntax we discussed with
upstream `rustdoc`: we could perhaps have a syntax for "tentative
intra-doc links", i.e. ones where it is not an error if they do not
resolve (sadly that makes them harder to know if they are correct),
e.g.

    [~`pci::Device`]

Or, ideally, a short-hand to specify the condition. That would not
have that disadvantage, e.g.

    [`pci::Device`~CONFIG_PCI]

Or, even better, both: the former for complex cases, and the latter
for those that only depend on a single `cfg`.

Cc'ing Guillaume and Alona so that they are aware / in the loop.

Cheers,
Miguel

