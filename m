Return-Path: <linux-pci+bounces-29838-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA495ADAA30
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 10:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BBF8188785A
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 08:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59032204F8C;
	Mon, 16 Jun 2025 08:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z56rYfB/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9895E1FFC74
	for <linux-pci@vger.kernel.org>; Mon, 16 Jun 2025 08:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750061049; cv=none; b=C/nKw1FzY6SvctSppQoQ/xSO8B6YItkB5Zx+pcU59HSs2gspaRAr8vd7iZJra5gM8IUDwRjpZ17PAA67BLOlOdkY6EHMUxnXkwKGhNRMUxdVGeRl7wMZSXp5xfjugUYGrHJfrZh7K9/iZyy0qxah63cjY0RfweYRZaOZNWg7t6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750061049; c=relaxed/simple;
	bh=f1PYGjMBDRYf08ilo6nO6r65U87ulrrDAGAp9xwJARk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WDc+x6mCWLSScDkdNEHewBvviP/4HMuzYvb+1qG8wbl4X6VcLIMdThS9rgEA1TBVtIxB0yWXAcXihXn0R3MHuD2FyDD0skoetbOfhVKMXwp5GU37Pbs86c2jENpB8HBV2Znn9RgEUAEcwQNhKUXDPyMWp9rYxMEimHVEXsTABvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z56rYfB/; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-451d54214adso32293945e9.3
        for <linux-pci@vger.kernel.org>; Mon, 16 Jun 2025 01:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750061046; x=1750665846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f1PYGjMBDRYf08ilo6nO6r65U87ulrrDAGAp9xwJARk=;
        b=Z56rYfB/6DT74qaitagzv+993Q7uW7YWuqJ3iBr36WuY0NU+vutvNNc8Z6Mptbt5Th
         6Q7n9WEuxpJ7vs+DvI66CwGFvYiUFLNhdhDxI1fY0H7jzjB66KHO6h/1mx25/XrYULrm
         7NgvLqjxQx3hPxg4dlMS85JgljMIIPXZeHC8hDUHh9G9jazgHPAkioikTVh1FBnfSiV9
         4BkPWMHF8wPlWKhRRP/C0Bkp/6RytYTB4I59QI0MD9msz37BtNQOuP+kwo5yjTHAHBBq
         17tSItj17hu/Agc3XSrAUdc+8Q3mWv3y1RU6g1F2Le9fCkyOpEJ93rSZx4oD6W6gaGnD
         L5+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750061046; x=1750665846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f1PYGjMBDRYf08ilo6nO6r65U87ulrrDAGAp9xwJARk=;
        b=OCslT2GZKgj+ZGgiQkbgGF4ssM3cSWCXoxXwzhEYHw4pTTLH8BU2R3vVLhmVzHbmBj
         8HI5IdFyr/5rSYtssm4wEYBdsGoUwtMsmD+CMDqHTPHPw5xNppX2lE2V1AlZHyFQVyAo
         RIEaYy60kJxzTJ8fA/IoBS8VrZ6+nUVwA5hu1XC3XLMYxY6b4C2/f4gTM9u3PwWIsxI/
         IC15lVfnoL0OgVQf+mkv5ZLogMwM713rGj4XZYHVVHWU6k2nl+LDSvTZEwR26lp7UthK
         rP5uUJWbTpFg2AeNMW4Zufi4JXSjs14hfaYTiSQn2JJbg+js6R9cPjMJwGaraCuaJAfA
         ClDw==
X-Forwarded-Encrypted: i=1; AJvYcCWTZQ+m/Uvw+qdp7BAbZFL7OYj7rXzDSwceRxfUModtgFzCqTE/YUqxawZ8YFWX/nD7Q3sgbJcIL/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTpSUfEa5HPndWV9NusSARdO0typTNq261vxAIToHR/DjR6vp5
	diHIlxbA71Q5WhuYvj3k/EIRnqI+qMRYpFqPSGlWAC4HesCNGM1Ruh91Vx0l2Nu0YW7/PtdTsLF
	BHKefAntJ1/EvcjuK9IwvI6cRggEKbVd1rSVxycxo
X-Gm-Gg: ASbGncvECf6jJ/OWs2lSD8lKXSbHlDHJvdCb8kXQd7JuPO5X2TwScgd5hL7MdP0Cxbb
	BUQjBLv97235eW6/m68zoyUWzo2g+/UTiFLeBj6PXn9T6eV4oob6s8Dhxne/X9SsQ030vQ5OgE8
	NPCzjUyUSW6XvGIuJCC/CMg04XM1m7qJmpz70tKgOqNfCd7QsQO5A7NAA=
X-Google-Smtp-Source: AGHT+IFJNYnGY++zKK9ezz4GBc7LrhfZRQuFSNzgJFJ9/LkEAc06KUhMt33Oo5LPfwTK3+h2aideyFG6HmImWi9Q2XQ=
X-Received: by 2002:a5d:5846:0:b0:3a4:eef5:dece with SMTP id
 ffacd0b85a97d-3a5723a3729mr6989355f8f.35.1750061045848; Mon, 16 Jun 2025
 01:04:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250514105734.3898411-1-andrewjballance@gmail.com>
In-Reply-To: <20250514105734.3898411-1-andrewjballance@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 16 Jun 2025 10:03:53 +0200
X-Gm-Features: AX0GCFuzgZ7WEl16NbBTVWyiSxMdvM6mQ36bWXoU4zjT-XrCROgztLnIerofDY4
Message-ID: <CAH5fLgjgtLQMaAZxufttzoVCJpAfTifn6VWwKZ7Q6vAOOvG+ug@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] rust: add support for port io
To: Andrew Ballance <andrewjballance@gmail.com>
Cc: dakr@kernel.org, a.hindborg@kernel.org, airlied@gmail.com, 
	akpm@linux-foundation.org, alex.gaynor@gmail.com, 
	andriy.shevchenko@linux.intel.com, arnd@arndb.de, benno.lossin@proton.me, 
	bhelgaas@google.com, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, 
	daniel.almeida@collabora.com, fujita.tomonori@gmail.com, gary@garyguo.net, 
	gregkh@linuxfoundation.org, kwilczynski@kernel.org, me@kloenk.dev, 
	ojeda@kernel.org, raag.jadav@intel.com, rafael@kernel.org, simona@ffwll.ch, 
	tmgross@umich.edu, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	nouveau@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2025 at 12:58=E2=80=AFPM Andrew Ballance
<andrewjballance@gmail.com> wrote:
>
> currently the rust `Io` type maps to the c read{b, w, l, q}/write{b, w, l=
, q}
> functions and have no support for port io. this can be a problem for pci:=
:Bar
> because the pointer returned by pci_iomap can be either PIO or MMIO [0].
>
> this patch series splits the `Io` type into `Io`, and `MMIo`. `Io` can be
> used to access PIO or MMIO. `MMIo` can only access memory mapped IO but
> might, depending on the arch, be faster than `Io`. and updates pci::Bar,
> so that it is generic over Io and, a user can optionally give a compile
> time hint about the type of io.
>
> Link: https://docs.kernel.org/6.11/driver-api/pci/pci.html#c.pci_iomap [0=
]

This series seems to try and solve parts of the same problems as
Daniel's patchset:
https://lore.kernel.org/rust-for-linux/20250603-topics-tyr-platform_iomem-v=
9-0-a27e04157e3e@collabora.com/#r

We should probably align these two patchsets so that they do not add
incompatible abstractions for the same thing.

Alice

