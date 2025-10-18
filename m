Return-Path: <linux-pci+bounces-38630-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 546E8BEDA38
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 21:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EB91F4EB91E
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 19:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA2129D265;
	Sat, 18 Oct 2025 19:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWwYi6s3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A509256C89
	for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 19:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760815507; cv=none; b=LAUdj+4BVmr97ipX/0pHZHbeIAN6KKi6J9IGXPspyOCXPL/t5xHCjvIJD6YhPgKeREXDnRuNwovp1gEY2Ef9M9+7eEoMX59I0EE5LtYr49K/8N9dbKik8UDY559wchedA46KdtfVZxhOvJIyYKV1KnDEMuozo9ZFiblVfnUrnlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760815507; c=relaxed/simple;
	bh=rnUc1sSIJcJcXtlU0rQc91rWE99Qu6t+C8m+svSvM9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=puK3vkZthAPFs88T77zN6n0luLYTYratSVQEPvxcVkE9DlL+UvvNoK0bzCJTWk/LVqAypzelTkPh+SNK57jN3HoruoMnCi2retB9oDADFYGmwbf+b5hFzQRps8ButufirdfGSrhJhqr0FrKGZGLkDhtFoGvoIJZu8t5lVzUYvMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWwYi6s3; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-29245cb814cso2284575ad.1
        for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 12:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760815505; x=1761420305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PXwxLtFHklVqMldstrW5nXmaQWoQkEu+q+HBHCmmMZA=;
        b=IWwYi6s3kuZG/HtWI4MzpdPGLv4d8Bfcn+qXg3YsCAJEr1QKzKvTGjiRQOdS/DQ6DP
         Y8fr4SVEQM6tnr35g77FE8TRgg5K2PYEEdg9HIONLygZlMDawxU3NigbPW3k+OP+wdAX
         p+RL+AdNcPN++TuGYbszNv8guqVo3p+IJHzSFOheikGp+wvxHC9YGodWGWMCuNiFQyF0
         lrFKjCEXeBB56WnBrAiqRo+TEE4IlNb0HSwwcDRdBld7LAccjJwp6Gt9TETzQOBw8cBJ
         mXKIEF0M0odkj1R/YCfAK98yUptWeiaPIRZWw7LLzFnaqdaEvwU0L50N+CZJqNyHJ4EX
         3h6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760815505; x=1761420305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PXwxLtFHklVqMldstrW5nXmaQWoQkEu+q+HBHCmmMZA=;
        b=fsfP9/QK/mfRL+BtZnEOoWWhuEPylCu+fSbsNOgZWFJHq+d1EIY3FOZDWqxlllTX+l
         ipVHLEUtnwvkJnkeeAxKmA1VzltJriP1ehqlY7jgOsqcdJRy5U4pXYvxypcW5Z2x0bBD
         1ndrrnxBlPa7H5zEaK/Xy5M0EfT2j0bN4bveSo92FntujnZV9D104NSgNXITztLOL6Aj
         WdK568L5htXOGyWQDBLMAp/hTcxGd4/Dv37U5yhz9Apxe622tm3WIgUKy5miJb7IxcFE
         ApGmaMVMLc7BeTcfeZ1ekv2qzOu1fFVVXMyhRia8Xq1jWOiTKj8W+VZ5IFC6wZRTa0YK
         TmoA==
X-Forwarded-Encrypted: i=1; AJvYcCW5M0JgA53e/pYt7iAdBzng+TdFkJuKRHnXxKbqEyLt4H9d0/+0iXjj/WT+SwqcN3tkmRb1Lxa5+I0=@vger.kernel.org
X-Gm-Message-State: AOJu0YykGq7dx39rE98a5cqvnliD0dWyJYQ/WBrS43TA/P/U+ZukqbRL
	33h9JmnBh74cBxIjVQ1RZZlWKqRq9gJtyBB6Sv1Tc9ygLowrSei+7JDJ310HBOSumEB19gUxJ52
	DF+ZrEg1CEn+yps8iJLkRlz3GZZ+h9/M=
X-Gm-Gg: ASbGncsLyd4cgFecMF4v8W9Yw198PJzWKtkO/1KIiIdSk5cDul8XH+NkOC6chdffywm
	fY3LxRrSJyGIjhbAanhdf0PHRQ/0ajL8UsxNDdWwjPiHzsDwJNn+plSmAUjr3lkRsUDDLtcldcm
	YG1EL2VeQBI9MmkHh8OoSx/84hr0+FmcSPKJb/akv/GhpfbvQAqiHF9ghaHAF+73guemtfP6tFP
	DdzeNpcEnEjNrOfN4q7KAKYbWZIHqftOwhIYCn84AacotrGPjJUCmVWt8XvNxTwDQFkC64CneJv
	y29AFkSiNcBUn7CAtJhgPYGOqJGMV+/In1XiS/bSOORmF84GvsP01kkQAsrYFFp7PpXj+aGW+gl
	PAig=
X-Google-Smtp-Source: AGHT+IFynbxdq4PbDoeu2y7E7pruyAv8MSoOFKgcS5qR5uKUe2l/9/1aikoejnUdjk1VE9ieyNLSjxDynifGmomPS5w=
X-Received: by 2002:a17:902:f550:b0:274:506d:7fe5 with SMTP id
 d9443c01a7336-290c9cfec04mr58829965ad.4.1760815505098; Sat, 18 Oct 2025
 12:25:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251018-cstr-core-v18-0-9378a54385f8@gmail.com>
In-Reply-To: <20251018-cstr-core-v18-0-9378a54385f8@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 18 Oct 2025 21:24:52 +0200
X-Gm-Features: AS18NWDWZ6CTzqAcsRkSpKjdzes4UGFhB9PPk5gEXsERGZ6zM8JBbanNnhdHiYY
Message-ID: <CANiq72n8m0JKjJMZ8Nk8B=GG5kcsSuc2YKp4=r2XJJgREoZZkw@mail.gmail.com>
Subject: Re: [RESEND PATCH v18 00/16] rust: replace kernel::str::CStr w/ core::ffi::CStr
To: Tamir Duberstein <tamird@kernel.org>
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
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
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
	Tamir Duberstein <tamird@gmail.com>, Matthew Maurer <mmaurer@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 18, 2025 at 9:16=E2=80=AFPM Tamir Duberstein <tamird@kernel.org=
> wrote:
>
> This picks up from Michal Rostecki's work[0]. Per Michal's guidance I
> have omitted Co-authored tags, as the end result is quite different.
>
> This series is intended to be taken through rust-next. The final patch
> in the series requires some other subsystems' `Acked-by`s:
> - drivers/android/binder/stats.rs: rust_binder. Alice, could you take a
>   look?
> - rust/kernel/device.rs: driver-core. Already acked by gregkh.
> - rust/kernel/firmware.rs: driver-core. Danilo, could you take a look?
> - rust/kernel/seq_file.rs: vfs. Christian, could you take a look?
> - rust/kernel/sync/*: locking-core. Boqun, could you take a look?
>
> Link: https://lore.kernel.org/rust-for-linux/20240819153656.28807-2-vador=
ovsky@protonmail.com/t/#u [0]
> Closes: https://github.com/Rust-for-Linux/linux/issues/1075
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Thanks for trying the kernel.org account -- it seems it worked!

No more throttling to deal with anymore :)

Cheers,
Miguel

