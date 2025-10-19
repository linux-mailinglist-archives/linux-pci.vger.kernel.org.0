Return-Path: <linux-pci+bounces-38691-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AB4BEED6D
	for <lists+linux-pci@lfdr.de>; Sun, 19 Oct 2025 23:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3A8B04E4EC2
	for <lists+linux-pci@lfdr.de>; Sun, 19 Oct 2025 21:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAC4238C07;
	Sun, 19 Oct 2025 21:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MakeTJ5q"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1122192F5
	for <linux-pci@vger.kernel.org>; Sun, 19 Oct 2025 21:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760909238; cv=none; b=P40+C/aKyJy5EeO3Xe8xGliEM29BBJuRCii+RaEj7kHKDEXsKuuKnfRKzeSgA8BM+dCwTl0h4xSrPbHVll9/15E+Vg11dVngQRfnSyy5pDwaYJwPvRpPj9srI1SqGO+YarDI3uMxoY1jfRKSpg1lwXssRFa8S8HBj3S1VmGngaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760909238; c=relaxed/simple;
	bh=7QXi4ECa31zhkm3BeJtv7O0uJSmHaXRwVyarc11pYYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rn2GfBvrnFpkA25RjEXgh/dOQlnVSsu5vTj/pRQUY+Wdlx4Ad6fccqgvqKafIyuLvmIdStKXQpQrSatNwIAeBDNCekNpIfDKw287wlV5jt+8D6lq8XLiZ9rk7wbGbLqxG49Vz5skrlKgPQpnFIYZlfG60O1siyD+2E8hsDFMDco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MakeTJ5q; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-339d7c401d8so955105a91.2
        for <linux-pci@vger.kernel.org>; Sun, 19 Oct 2025 14:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760909235; x=1761514035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7QXi4ECa31zhkm3BeJtv7O0uJSmHaXRwVyarc11pYYg=;
        b=MakeTJ5qrrPKcgCYb4kljtxVYayNEHC9ohDVC6sRKzIR590wtT8j27F7wvBDpr0uGe
         +7kGYnIhUlLJH85sA8MFDbuywJMLHbMW4I6Jhbhr9s0OlhdAGfXc2o/f2+8tIpBot8GY
         LUrGhSgXfy+IWTsnfDSspFp6MtIDfmcJjRXu/AcSriGxl22rDXBOaJv8q2WpjRYSky1j
         /umsUztBvYfqts7hgDh3OgnDmGbFZDz4kSbGHAplpXU5tMPfeDtkHF4dgQwdsuCfTzd7
         WxblaTLzUPszcWkiWdzu4D6+Nr42lUAsdAqGbiZ9iiwsScElTqLc0J1fMJqXsgucOAeg
         iqeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760909235; x=1761514035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7QXi4ECa31zhkm3BeJtv7O0uJSmHaXRwVyarc11pYYg=;
        b=KD0AtLa2Hfp0oZ6Udmf3xuVpDlf91dGJx5d05yNjEYFlJLVs02gR5Ci64kpSUW97ld
         WTI3NS8TTwOzyyKm80IErXhsfFBA46zx4Lilowc6KEdGSsMMGGyILwD1YIynA9I+5HEc
         0HCizKTrwRJJyo8ANkMnEXSBTzuWgTxvQp/JkeWB1i9taD6KxR8RcSnrd0WfnCGj6O7q
         /DavtBee6fW9dBV79EmYJ/Bhs707N20pnMlDi4wSSdRul/T9xu4DPrkmDJ3rqlonrz3f
         MnM8DCvZ12pbdEvOIwx3TpWzNU8R8kYuCSEoxwWTvVQ9ukXXqFiB4U4lSwfVNsHusPPX
         ZVbg==
X-Forwarded-Encrypted: i=1; AJvYcCW39/MsH7MqYkbIWutwxV+wgGIsaHoW/tkkYUD6v14pjri94HizsqAgolTmSg7psfBUU5SrlpKFRO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSbpMoOrgL4oo4ZNk9/t2PnYHSmcRG0D6MSTFk6RlCpBfH3TXo
	KnqAcga583CkI+pTcSCPcVsiWQPKO7uPd9TfAtib0VeZhICj11nTauJ6Lh9KWOmnEWclVPpXiyl
	fQzjwMxzJYv4Ha9ewgDMIiR7ci867Gu0=
X-Gm-Gg: ASbGncuu/bleJZxt5n8gRZuaU1zm8XefsCFo0xGPMPrnlJeIVPddJQedDdieePHNfh9
	J4sZqKuZN2AzQGqOgFRvF5bTUR+fQCG/LK7xdyc7Ucj/a6Q74vGJsm6GYQLNTAvfm19rzZYQcRr
	Ecx0bru1elg1mSKLYMTYhtFSbgS4SfHPws5DsOM5UcsTMfQJLep5NQSUnFxuK0MwNF6d/qT99oE
	F6ICkPajAHrxkwZRel7Ep28vCBO9uuX5in+sQQhOu6tsvkqZG4YO1laYwdj87tpegyPN9UIAR2Y
	2iByzBh4umvfECJA+UJDJCEWGiryPzh+oe8hDyed2PO3YU7NElFzPvvWzOTORUDXChm32GomznX
	UOvLfyGb9pQb2ew==
X-Google-Smtp-Source: AGHT+IF1VFFJwy8ygSX6eoBXAmkQpi5ZSm3xG9mAwnAEV9eBFnYF+NCv7z0G4tbtRrIxdCU8CTeu9qRXC9i913/SiXw=
X-Received: by 2002:a17:903:2f87:b0:290:af0d:9381 with SMTP id
 d9443c01a7336-290cba4effcmr71823605ad.7.1760909234948; Sun, 19 Oct 2025
 14:27:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251018-cstr-core-v18-0-9378a54385f8@gmail.com> <20251018-cstr-core-v18-10-9378a54385f8@gmail.com>
In-Reply-To: <20251018-cstr-core-v18-10-9378a54385f8@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 19 Oct 2025 23:27:02 +0200
X-Gm-Features: AS18NWD3K-E_pn_Z0H-XvvQwoMFJQoy6QnxlKg55_WYP1vw1bB7QYmn04Fruiws
Message-ID: <CANiq72nTRAW17RRKHjdfmy-HQk+31vEHyksOs8XGZZKBY=54EQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v18 10/16] rust: opp: use `CStr::as_char_ptr`
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
> Replace the use of `as_ptr` which works through `<CStr as
> Deref<Target=3D&[u8]>::deref()` in preparation for replacing
> `kernel::str::CStr` with `core::ffi::CStr` as the latter does not
> implement `Deref<Target=3D&[u8]>`.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Viresh, Nishanth, Stephen: I will apply this since it would be nice to
try to get the flag day patch in this series finally done -- please
shout if you have a problem with this.

An Acked-by would be very appreciated, thanks!

Cheers,
Miguel

