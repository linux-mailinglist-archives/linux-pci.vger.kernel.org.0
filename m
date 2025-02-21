Return-Path: <linux-pci+bounces-21960-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F05A3EB8D
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 04:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B32316B151
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 03:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA041D63F5;
	Fri, 21 Feb 2025 03:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYnnX1xp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2022862AC;
	Fri, 21 Feb 2025 03:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740110353; cv=none; b=LOtLt5UJkX1h9k8VN7KLtBtHfgsEslE3+vRrIRJtUuBaaM88tUgjqYnAItgJTfrNnS1vfWYltAJB0TPlRA6UD2ojiTkolNLuaWV6b8XqtC3m2bOr3XZtuJ3Q/sEcOdxvmtSRO6bNoWNtaEoCp4V+B7eOEsPxR0QURF2XHz8KkRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740110353; c=relaxed/simple;
	bh=XZ2RM16Az6uz92GdxRvDu5nPmKE66mfQnEP/WoRbzlQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QRrPh0Puo2r9pu04604o+t5Uw1BRjDVFNAWh75aZtNFU+6fmkHoyoDIb1iewUYT0rcJQbWyVg5QufJqbMAD1nuaJlyyDtE2BhdvrYtS7VQZ+ikwKMrdb/SXLxeu8Ix1YZJIH5BI8KyI9Xdio0cw97biX1NIKeKXIE2fiJAKuP7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QYnnX1xp; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2fc383a11cdso381797a91.2;
        Thu, 20 Feb 2025 19:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740110352; x=1740715152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VND56wFi3Kn3v77IS87WtpNyey62fEJlfCeDgLZ0JRI=;
        b=QYnnX1xpn/4r3nxRKhPvLYHFFi9v/5uvmLU6V28YlKNzXAUvpz90e49643xCzLXymt
         lqTIE/UDj27OL2ZGUz7lYUeRfZBnG8zrEqYMIN62KjqQefIOnlr7s0OW78vNNgMeGxsq
         T4q5hukV+dNBUEHNvSnKhpfNgGngeK9dcDMFTkP06s/VKgIBXNZEMmpRbN5LNxdLVfxw
         I7U+OKtqBwGE1hEkQxcuMlqSDKIAiAjY2L/NO8F0URkjRNbc7GtQR0snw655Y5R8p2MP
         ics8faEz7oqCBJ9zcUluEgOejUYTla1Rh1f9OgwH3Rm6iB5ZfY4wuGzPuRKqRQeFbKsr
         7Yvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740110352; x=1740715152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VND56wFi3Kn3v77IS87WtpNyey62fEJlfCeDgLZ0JRI=;
        b=fi6ob1YreajkmTmspziTAmVBP4OjQCmvhS2AltJQTLBAgSofNzU6Tp5EWHp0jGnrpa
         WC94sohDd/NgSIseMBksiT0RuLlobplrQQWACBbNX1ZMeGT1fB46DSFp/3O03sbnnHJO
         Zhf5duzrEj9eX/OQfmUQuB1mcs0NWyhT0Nq8bnll6VBkH5MMNuVnk/r+VZCMsG9p+MF2
         p2msdfAvoqGCLiEGvj8VZ/ZcDlaWAJh9UMDZJNO2mV43yfHzqWr0XRxi/D/aS/WcI7oO
         Ubd8HliQ17ihWffc1G6JSXjCX/Qb2zOXe4wZZ2qoq64huNhMZFC05/bOza+SE6si/FDh
         zx5A==
X-Forwarded-Encrypted: i=1; AJvYcCUCQHKPweuj6C7NLJOB6xcZ1sypNr2y5Nr20J1BzUNy4LQ6Th34CFf/Ljgz5w9Zjph6C6z8/HIkpkXqAKKhdGQ=@vger.kernel.org, AJvYcCUpP6opduF96IToPhuBADoiYNWe9T/s1QFlyUXGPDZ1q1+qdxqd+2dQ+1Ueyi46HAcGCBbp7egRYugn@vger.kernel.org, AJvYcCVmMO0Sh6HFmGG1nk3nnBUbC+XtpQFPL/4DGyfeiw8pFsOBcGEI1Dgj5MD6I1gtNAS0+KUzS4Kq+2fwFsME@vger.kernel.org, AJvYcCXDyM4ZbM9I6G3+BtCWaa+ZtLVfs4trGE53+iYNOmr2SGDbgX4CBp6dF0fUizzPBaAF0dtd@vger.kernel.org, AJvYcCXyZ6kpzUIMQaPfmcL2AUos2DO8wfVsTv5lc37PRHWAFnw99BqnY5fkFnrDv3m+4DylSDVFz+24sCug@vger.kernel.org
X-Gm-Message-State: AOJu0YzARDEuWrEH+ElySGbo3cTcLS4Y7ScZQaOg3zEoXHGkNoHS6X2j
	JCC1x2UmuwkYq8aJFmxALsiTX7b89nX8I3hJTDYeQl5MkwYM3PSVJrELRD2IkiJSTIGnFZqGdXB
	h5h3gYu+LEWMjc2HD/Aq3v4adZc4=
X-Gm-Gg: ASbGncvl3JUSZMlU9rbWAY9/UCLRHk5vBXnhTDi0OJqiYorZ/Tkj3RRbceSS4AyB6Ov
	iS6V9YFK5vJDK21UTEgumCnTf8DSelmCJb2nO6Uf4FlwWLpxWi4TI3fbZEZNEM7/htZ0Lukduyi
	W2CDCkZws=
X-Google-Smtp-Source: AGHT+IG/p3FXeTyrAAqDE1FrvSFfCyLSjW6tz4Gy4+kr+TxE6tY3gEvqPTJfJGL9UcELpQzeYJ728itJafYL886LXvI=
X-Received: by 2002:a17:90b:4c04:b0:2ee:f59a:94d3 with SMTP id
 98e67ed59e1d1-2fce75eed74mr1150380a91.0.1740110351760; Thu, 20 Feb 2025
 19:59:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241219170425.12036-1-dakr@kernel.org> <20241219170425.12036-8-dakr@kernel.org>
 <g63h5f3zowy375yutftautqhurflahq3o5nmujbr274c5d7u7u@j5cbqi5aba6k>
In-Reply-To: <g63h5f3zowy375yutftautqhurflahq3o5nmujbr274c5d7u7u@j5cbqi5aba6k>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 21 Feb 2025 04:58:59 +0100
X-Gm-Features: AWEUYZlzKjop4fZ8volzu6pW1ujhScrt60C60cL2W8m76ir8T5HPKhxKjw-6XfY
Message-ID: <CANiq72=gZhG8MOCqPi8F0yp3WR1oW77V+MXdLP=RK_R2Jzg-cw@mail.gmail.com>
Subject: Re: [PATCH v7 07/16] rust: add `io::{Io, IoRaw}` base types
To: Alistair Popple <apopple@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, gregkh@linuxfoundation.org, rafael@kernel.org, 
	bhelgaas@google.com, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, tmgross@umich.edu, a.hindborg@samsung.com, 
	aliceryhl@google.com, airlied@gmail.com, fujita.tomonori@gmail.com, 
	lina@asahilina.net, pstanner@redhat.com, ajanulgu@redhat.com, 
	lyude@redhat.com, robh@kernel.org, daniel.almeida@collabora.com, 
	saravanak@google.com, dirk.behme@de.bosch.com, j@jannau.net, 
	fabien.parent@linaro.org, chrisi.schrefl@gmail.com, paulmck@kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alistair,

On Fri, Feb 21, 2025 at 2:20=E2=80=AFAM Alistair Popple <apopple@nvidia.com=
> wrote:
>
> Is this a known issue or limitation? Or is this a bug/rough edge that sti=
ll
> needs fixing? Or alternatively am I just doing something wrong? Would app=
reciate
> any insights as figuring out what I'd done wrong here was a bit of a roug=
h
> introduction!

Yeah, it is a result of our `build_assert!` machinery:

    https://rust.docs.kernel.org/kernel/macro.build_assert.html

which works by producing a build (link) error rather than the usual
compiler error and thus the bad error message.

`build_assert!` is really the biggest hammer we have to assert
something is true at build time, since it may rely on the optimizer.
For instance, if `static_assert!` is usable in that context, it should
be instead of `build_assert!`.

Ideally we would have a way to get the message propagated somehow,
because it is indeed confusing.

I hope that helps.

Cheers,
Miguel

