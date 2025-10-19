Return-Path: <linux-pci+bounces-38689-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B67BEED58
	for <lists+linux-pci@lfdr.de>; Sun, 19 Oct 2025 23:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99E123E5326
	for <lists+linux-pci@lfdr.de>; Sun, 19 Oct 2025 21:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDB215278E;
	Sun, 19 Oct 2025 21:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFVKCsLj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C6F2253EB
	for <linux-pci@vger.kernel.org>; Sun, 19 Oct 2025 21:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760909146; cv=none; b=Re3jXBeH5hRfoNjAWbsdWOgxhyYVIHXlfWz4oosDMuYVxQjxr1U1n4pdMTW5rgc1QIAU60PClQSLO/SVdjt5CGLhrCTCueLQSmf/lZX1D3A306fVLEna0ZicwJVlrNwPMg0IVnPFNO+o1DJdTG4A/70Kgf/kGuBQMYm2bwCuTX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760909146; c=relaxed/simple;
	bh=uA5vTOIALbcdwmrJpSZvDL4908AXryA4bzuPW04xPwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e+alj/gypfH46D4JaQ5JSHcZ0BYWFFo6H/zuN5XkExLR8GopJyAK1ab49XziZYpJs3Gis26fQ4e2ihT6KaL8bj412xSkShAOHwFzLZ2OH0x2HpcduNL1wbXwoyFW+oY8X/WpwvKMmC6SYQm/dKvSWk++l1lw4rS4tkqmNhdTicQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iFVKCsLj; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-269640c2d4bso6569765ad.2
        for <linux-pci@vger.kernel.org>; Sun, 19 Oct 2025 14:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760909143; x=1761513943; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uA5vTOIALbcdwmrJpSZvDL4908AXryA4bzuPW04xPwI=;
        b=iFVKCsLjZ9ItLLugnc3NOyWgR6LdhMQj/lhUoAGx54ScPjkNeKQ2UAHsHjOHAamQ2/
         xDrS4i3MmZ7dAf4jogvQ02XjPPAkf7FBRZUEFrnlDrNc1OceGpdauhfN3WWMOffyFOsn
         cW1K4sWbbT3wXOvP2fMOi73RSK4EW28qGP3jA4JYKg2Iaa3pJSk4L/CktLp3YJW7Gf5G
         fiorgLY3lsDB+31e2mVDFbj582klczwsIdfO0ZH7AD/vCsTqeOB2KpwBHq+RgR1GDo6z
         ya5WTV98cFuVNieBV2HztSxbHvIKViXB7T0g3CN1L9Hn9vf3NGmZUNBGqagWjha9IEZc
         UrVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760909143; x=1761513943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uA5vTOIALbcdwmrJpSZvDL4908AXryA4bzuPW04xPwI=;
        b=dl0JthYRgVhHhJpEPdAUXUGWZTrk28sHGKO6SPGQ2CihvZY3ak7cvjiBS4F7wLbpl+
         IZ+aZcBTk1NiL6itPtFazlYWaTSIQpE+8kIUHu32kr4lQBHHp0KJy5zSly+uQRrYOtYR
         OTxUlh+9htl1/QNE7QaHH+1BIaP6Pt1WESFSUpPjQyLbq/XqJ7C+o7Pj60XF5IHWKB+5
         zSio8fO4qaMmmxvzrTd8oOpwC4eeEiwzKJEXkx+7vDSGMotfIQwEPkOEloYq0HYsjNgG
         vZGv9xkMfaGyBStVrWudQBiobc1Y3pUR7hjk9qukN2xMIzkWW9o1ZShyblIfXwDkJYI9
         dlAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdVN50pqP5PC03AjEA/BG3EHy06R+Cd6CJWhpHi2K70NXTJisV92gQSLWrNooHQWoVXGtXfWZO52I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrpuTKHiIsxZfJFgQo0jPhU68kg8IsFoKURfnhCgePc8gQOb+F
	x3EdiiYgs1L68aoN47+ouRPDEuLC/Zv7CMMk9PAvsSGNcpcQ2HiWvgIIqy8UbovzE1fqPeTOB0P
	aepN9yBuSeKIC3nzSEysudLF5/PH6Fk8=
X-Gm-Gg: ASbGncvdi+1FQoog+NfrrfT2M2dr4B4SUzV30WXlpg+9uL0OvczqgfO+EhgBoAjVvrj
	XJyx56OVp7apm6baS/cVX7Ge5vznFxYfe3UiupgFAhaK0rrc1HEvJbwV5RMG0Hw+UMXd1jVNYSx
	GVlyBrG4IZ/A4tns6eZLjA+YM7SF7jUZeQwoEDQuWmWShK72E+HnEdQzlV6GlMm+Lfkqyxx0E3D
	FPQzkNdrfk5143ViQn3eNDhyR2+EPhtK2N1pYQ+7qTvByQUUzRMt5A0DgT0zviI5s9vNoqa2hEf
	OmGHP6a6mRjKElmeE+c8uZSOkOOo2Wx7E+h8qswORjkhjeMvOxoJB4exLPChjZaoxEGdV2zRP05
	YiX8b60IGuqowLw==
X-Google-Smtp-Source: AGHT+IG+Xq8GXKfGoMwbFFQSVjc1IKmL7pMM4P5v7DRrKR2eAYMxLjwbrDpo8D26g74EqZuNpH1jVIwhs5ozgrDthtg=
X-Received: by 2002:a17:903:3d0f:b0:274:944f:9d84 with SMTP id
 d9443c01a7336-290ccaccc47mr70983905ad.11.1760909143546; Sun, 19 Oct 2025
 14:25:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251018-cstr-core-v18-0-9378a54385f8@gmail.com> <20251018-cstr-core-v18-12-9378a54385f8@gmail.com>
In-Reply-To: <20251018-cstr-core-v18-12-9378a54385f8@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 19 Oct 2025 23:25:28 +0200
X-Gm-Features: AS18NWD0bEVrj3eqcMBbtrKdDrdonGG9WGD9YJjG46fNVzfrXtIBr4GqiIVIqEs
Message-ID: <CANiq72=c3Zs+mecvDVJ=cyeinzezhGz7yqC9r6FG=Q4HAdb98Q@mail.gmail.com>
Subject: Re: [RESEND PATCH v18 12/16] rust: configfs: use `CStr::as_char_ptr`
To: Tamir Duberstein <tamird@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
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

Andreas et al.: I will apply this since it would be nice to try to get
the flag day patch in this series finally done -- please shout if you
have a problem with this.

An Acked-by would be very appreciated, thanks!

Cheers,
Miguel

