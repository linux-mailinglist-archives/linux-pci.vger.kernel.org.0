Return-Path: <linux-pci+bounces-38690-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D06A7BEED49
	for <lists+linux-pci@lfdr.de>; Sun, 19 Oct 2025 23:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA2F118907B9
	for <lists+linux-pci@lfdr.de>; Sun, 19 Oct 2025 21:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731612222D8;
	Sun, 19 Oct 2025 21:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDq7Fqvo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6043A221FCF
	for <linux-pci@vger.kernel.org>; Sun, 19 Oct 2025 21:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760909170; cv=none; b=KFQTYnuMLwhopacdcnJpbQa89mVFrHi7l0pa74rHFMYWmBlPegXHDdqt14lW05uf9ZFnoo3MwlEiRWSfGfRXRSPmjsq8RL+UB81BiV8jyOeFYn3RmJtBK7WrgQFMQVhsHXIF1JxNg+fjkBzwrUXJpO6l5mVREuVqGxqUaVFLs0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760909170; c=relaxed/simple;
	bh=i+LGfQKWIvVBT05pMeCKog85n15IAvxhMtSIzthF5hw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q8a/2Gq/KTf+2fo87Sk2nh34W/wSTGEZYXFNjkeg6Y28JaFwo+Nmo1rPA4sJZIRPtPcvHsuWe7cMZuvTTjfRFO2hJ8j+U/8h+F9WG0EryHUEgMGDd+ipDkOAWYviuWKp3xCTV+sqQ2DK52gC17Acqx5Xupd1NiVq3jz32ii4mM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDq7Fqvo; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-339a0b9ed6cso816697a91.3
        for <linux-pci@vger.kernel.org>; Sun, 19 Oct 2025 14:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760909168; x=1761513968; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i+LGfQKWIvVBT05pMeCKog85n15IAvxhMtSIzthF5hw=;
        b=PDq7Fqvoti6jPtW18JV8zNYCD4MF+/+5YXqFhSF40rJQ2ZFet8SRtKsBsR97WCothn
         qASGpWu/s+Pi6zMEJX0BTA4qKHPIeIb9rrBMjXogOlE6D6FwEub6lA33lq6V50E40sS+
         sC+6jjHrEVnxy2466yLZHos/VGNYN4QtGHXPPJvUjY93p5TydGBDeDzWMG+Xrsj2F1u+
         Nf7+jAOmXHe5o8D70M9FfWLfPQXkD6KmyR59HiYceSduOwnxZ3KKCwkfRgDsU+DQT6wo
         HC/pKRdC0Paci7gbI9oIUOxQPXfKmxajfD65UJyql4eobfugI+a+6j/sSpxPVJxrK4xO
         f4qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760909168; x=1761513968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i+LGfQKWIvVBT05pMeCKog85n15IAvxhMtSIzthF5hw=;
        b=v/M5OyKUp6halQxwigRIKV/XzBR1pSmV2ATZJ51TrH1nwdowjZtMCGVjHNYpAPhaJE
         efFqtioL+bx1mfav1CuA/ZUZu7SOAOcdsxFdy88/vZlQBBh0vdWL1bulRVqJoED2Y7rA
         XrVEZLSw00q9rGsv8d7Z5eYqL3JzQ/UM8bW9XVxFav4VaA1mqu0BNMFWxXJ1q/vIdhA5
         8/CHZ7MFNH9Vgr2IoPauLUdszFxqgTf3FkWKtmRdgFBFj3QLPQMzjDiYaq0HSEF/t5Bq
         o3SCukycZ/oVfDCYGCI3Gehj53vJpFroGR05b7d0atlZr1qfOt62xSp3qKslbg6C6T/8
         EXGA==
X-Forwarded-Encrypted: i=1; AJvYcCUdpFcaLlS72H3sllTn8monPLjR0ElcQqJdXaVJItUnQwKpl+FlrA0pIavug9uJBfb+bjC+y/nIoYE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo0u6PMJ1eqcGV8QrFmlXux0dbuPjm8c8SOyA8vOJ5MlQJjpM9
	24xT49b4yTyUW5pXBvBMCwa3qrUEK+4kxZHhIgx5VvvlTmRAPgWUmQHo1iekRSnV7Y1P42Y2Jm0
	BbLXk5gyQclZPhEMWNcfzx2rn7ZsSsWg=
X-Gm-Gg: ASbGncvnD1B9VGmLk5wfWrtWCzJCOwUt6NNvxs8YA3jgeiGTlzUk3oQpZdTnHz2LMVz
	yfCeR8ReSN7BJ+1i9+pHRolsWKLRJbaO09JFUTEPt9GvzOcD5npVjLtb0+X4dJYGNopKh8tFaWd
	LIYtUkfDXqQOSUhL229/RbartXxKhVNBA0II5mlBcdRxK3/v6gQ2KUJ9cN4Lmf0/eY6kXRb4L/V
	L2HfnwHUbG+CKvgV7f7/2ZxdKIkSl2oTU+/OBzba67/2AfGL42rZ95KlOUVUQl6M48TucZ9FQHT
	sagJUdSDBtURgTonT3p4/ifq9pRAR7te/3ij6hHapD4RDWScCwYs3hJKd2URelSYKzJFU8GbWuA
	m0wg=
X-Google-Smtp-Source: AGHT+IEwx4nwwBhH/hNxoUVwvTs3X2bARut2TDi7HRPmGCV4tokc0LBHgVVevC+PQZA8tTr6XyTnNa7XyeNocxVrSx4=
X-Received: by 2002:a17:903:b8b:b0:290:c5c5:57eb with SMTP id
 d9443c01a7336-290c9d2dd08mr73269955ad.3.1760909167598; Sun, 19 Oct 2025
 14:26:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251018-cstr-core-v18-0-9378a54385f8@gmail.com> <20251018-cstr-core-v18-11-9378a54385f8@gmail.com>
In-Reply-To: <20251018-cstr-core-v18-11-9378a54385f8@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 19 Oct 2025 23:25:55 +0200
X-Gm-Features: AS18NWDjBjMG5pR4bntjwqt3T7EHDFAllndAmj435I7b4c65f3XvqG9PcKa-Qb8
Message-ID: <CANiq72==SKsYkogrQhKTzCXwxeYfbL3V5jOiQKiunwzLta5=Pw@mail.gmail.com>
Subject: Re: [RESEND PATCH v18 11/16] rust: opp: fix broken rustdoc link
To: Tamir Duberstein <tamird@kernel.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-fsdevel@vger.kernel.org, llvm@lists.linux.dev, 
	Tamir Duberstein <tamird@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 18, 2025 at 9:17=E2=80=AFPM Tamir Duberstein <tamird@kernel.org=
> wrote:
>
> From: Tamir Duberstein <tamird@gmail.com>
>
> Correct the spelling of "CString" to make the link work.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

It is private, but it is good to have this done so that eventually we
can potentially enable a runtime toggle for private docs.

However, this is independent of the series, so I would suggest that
Viresh et al. apply it independently.

Fixes: ce32e2d47ce6 ("rust: opp: Add abstractions for the
configuration options")

Cheers,
Miguel

