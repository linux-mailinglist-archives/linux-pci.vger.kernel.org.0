Return-Path: <linux-pci+bounces-32718-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D2AB0D84D
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 13:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92F18560E97
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 11:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B382E4259;
	Tue, 22 Jul 2025 11:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MYB34a/z"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D40F2E3AF7
	for <linux-pci@vger.kernel.org>; Tue, 22 Jul 2025 11:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753184151; cv=none; b=M72VSGgDKWz+HBbX2xUYNbAHFCRVZ7uU3Ru/5WwXsChpl8lhGDKYoOZDVxMNbH7B3nLdXO8OLiWcZbK5u/2VFrBpTCEpmklqEHXjL/xowTt8m+ytgewGbmKCw+vzRQy+w7WrBAAwZBAr8ChomnhXGIZIIst/ftUcAOXzH4Gp/w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753184151; c=relaxed/simple;
	bh=VJr8/zUYv42eURdRwV2GrHdHUy83vsFYT/2gR1d526c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uX+ZElizXh+7ef9ytXMB1qB98cgXTLkcwFNMzgHCwMQoB/KZSu4tU0G8PzuwbObPgrwv1UG2RBfIBnJZjgSsutQFw2EtbJ4xMoXwQIIzRs4PAFxOClJcXjou8a23inC98b8FAv9rkKrOIF6qIatwlWJR30DoXM/vFzfnXcYv9bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MYB34a/z; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-455ecacfc32so24649265e9.3
        for <linux-pci@vger.kernel.org>; Tue, 22 Jul 2025 04:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753184148; x=1753788948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zZTJ7kO5Udqug/M4tQcu+r5w0N3LOfdbzdUXVIngOwM=;
        b=MYB34a/zgNPt4h5DHqd5KrOaTkHt/q7mdISnF8UgWigIfrdrn4OILf56IiDQw0m5pq
         u+0VSx3PvanPWzSFY5sZ7t5BQC2GSFhL5/Gfq5rZuLN5bP6Ll59Domqbq6UC9sed+Bsr
         nvKj3nd9QR//xVa7H0cbZKRNH7fujGNUcrcSQs5LBKdak3fv7AqleYMTSLtUiMWdCHDn
         0pe9vrKU9yywU3jHKVM8xcLY77U3wPy9ABJ4y72IP4mOC5e6Kdbo8K1xwIndbiQEE5jk
         CkCbPydk12d+qC2VhcmulpmoZPXnrzRbpHOmZpAjE9farkyf2cdJrJvFDQPJlwRivplo
         eWxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753184148; x=1753788948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zZTJ7kO5Udqug/M4tQcu+r5w0N3LOfdbzdUXVIngOwM=;
        b=o7c9jko5IVLF9tG6XBK7bU9nMX31E/UTs/9Boi/EnkMSl5QQy03AkDU3CWAldAXfc7
         HN+p77z4FMESE0AiHegQuRLn+dLIOucUlaHv5U7s1YxGQioRSQXEePomvOrE3TIHmkNo
         DAPJ+gqNVP5WygL1sH4Dh9S/mPLsQry9ESbhgBI5ce3sdDlUb5JduUFGA2X5EpFISWfd
         iVK172jfiqpAYyS4qlf6p7GdKyYLZ4nmrZcPwVATvXHt9rsYSdIw8Y9U4/oDtpHakD2r
         mMXHxauoQ7Tz4gANE2yuVrw4wKb9xeJbP+3rFJtdXcGUU49pQXC068qf2mASxYV8d7Yd
         wwow==
X-Forwarded-Encrypted: i=1; AJvYcCX0uYRXXKBbM6PQ3D+mudjqc7fxCrP0FFSYIXk28oFwxF77oQFowv/rf2tKwy6o8HJh6OZVFCmpHh8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6Uu/07lNB59Sco4g+BnETptRojCJiTAXiA2c9cavxOfsMaVkK
	CWjOT6zi0PfxEmcVrT6FW0HAO5mOlyo9Hx1DOkfggMYFTJS6UYBKOPbRbzGTH6BALQFAwPlYWmF
	6eg53M/cVB/R+PDiAKnKq9EopLKoDcdf7/LgXFS6q
X-Gm-Gg: ASbGncvJHIn+TsUP8Z23dkm0Qs+Qur4J53CU7KCJyGHq6/19TlbgWMzBsK3LTKUVz64
	y5lN/zH13DfPbloXEo3WhCVgdPFHboORUP4Qt4MlHD8nDmmxw3Zz360msB9h81ZJqDZtROEkOPG
	NMz0cvF2hJQ2D7EG4qITSY6JiOFPIwKSumwRCVL3Gq1cUkuRRsP3XODJ+A7KOSCfNGbgDKOciM0
	pkYUvjox3nrcM4H8HypuEcvrYrUHggX+SaYZA==
X-Google-Smtp-Source: AGHT+IGgqbkCPuVbYPe+sB1xchcaAFlfb8rg+95dWf0lrVkAlbZIRkWKL6fzRgYKEH+kd9BAu/NP52Ff/2p+uKE1T24=
X-Received: by 2002:a05:600c:b86:b0:456:1560:7c5f with SMTP id
 5b1f17b1804b1-4562e03e710mr253355155e9.14.1753184148237; Tue, 22 Jul 2025
 04:35:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710022415.923972-1-apopple@nvidia.com> <DB87TX9Y5018.N1WDM8XRN74K@kernel.org>
 <DB9BF6WK8KMH.1RQOOMYBL6UAO@kernel.org> <DB9FUEJUOH3L.14CYPZ8YQT52E@kernel.org>
 <DB9H6HEF9CKG.2SAPXM8F9KOO3@kernel.org> <DB9IQAU4WPSP.XZL4ZDPT59KU@kernel.org>
 <bwbern2t7k5fcj6zxze6bjpasu3t26n6dmfptlmhbhd7qmligs@3fgwifsw7qai>
 <DBIHP8IP3OHA.8Y1S9ZV1Y1SZ@kernel.org> <DBIJ3POBANNM.KSO1I5557PFV@kernel.org>
In-Reply-To: <DBIJ3POBANNM.KSO1I5557PFV@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 22 Jul 2025 13:35:36 +0200
X-Gm-Features: Ac12FXzTL3fGKYzXEGiHiezw2fRDCeNwa0F97jFN7jJcBA3qdOvmZ51updJGOtw
Message-ID: <CAH5fLghic7MZd-BO=Z-ostGLgWmBciQmZp9VjQpLGWskFK_gyQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] rust: Update PCI binding safety comments and add
 inline compiler hint
To: Benno Lossin <lossin@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Alistair Popple <apopple@nvidia.com>, rust-for-linux@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	John Hubbard <jhubbard@nvidia.com>, Alexandre Courbot <acourbot@nvidia.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 12:57=E2=80=AFPM Benno Lossin <lossin@kernel.org> w=
rote:
>
> On Tue Jul 22, 2025 at 11:51 AM CEST, Danilo Krummrich wrote:
> > I think they're good, but we're pretty late in the cycle now. That shou=
ld be
> > fine though, we can probably take them through the nova tree, or in the=
 worst
> > case share a tag, if needed.
> >
> > Given that, it would probably be good to add the Guarantee section on a=
s_raw(),
> > as proposed by Benno, right away.
> >
> > @Benno: Any proposal on what this section should say?
>
> At a minimum I'd say "The returned pointer is valid.", but that doesn't
> really say for what it's valid... AFAIK you're mostly using this pointer
> to pass it to the C side, in that case, how about:
>
>     /// # Guarantees
>     ///
>     /// The returned pointer is valid for reads and writes from the C sid=
e for as long as `self` exists.
>
> Maybe we need to change it a bit more, but let's just start with this.
>
> (If you're also using the pointer from Rust, then we need to make
> changes)

Honestly I think this is a bit over the top. I wouldn't bother adding
a section like that to every single as_raw() method out there.

Alice

