Return-Path: <linux-pci+bounces-22634-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0922DA4971B
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 11:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01F2A1883901
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 10:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B143925B68B;
	Fri, 28 Feb 2025 10:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ywooo/Qw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37492157A55;
	Fri, 28 Feb 2025 10:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740738167; cv=none; b=nj2NjRajig+LWIRJBDiiTXxUurDi16H8d9tUc3btSspnC7mn90orfNvTwSsVxojct+Nb9Dbcw1d1vzAeV0V6QVfvcRjFv/SC59s2+Xh8oyyJhryQwcCWSLbXfSFmddhxA1n8jptagTbTUh/oWX5MYLuNXhU4+PN8JD89L/zbS64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740738167; c=relaxed/simple;
	bh=zQMkQAtj6vzSQBpImtNQZFAAzOJ67Rs10PHBe6Pdo/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aOkC60npJ5IfJlSZEHokHYP1EJpm9RJY4UOK7P+xZLE0HASWvOGvUibYd+ZhI7thT+Ul4N6RXOIdOTbjuGLa3fWRpppXc6NrphmHKPjxOWxdMy+aCW2LMGl0MPAmu1O9iN3AgqWYnSVDP93FH7uoPYFW2YDcUGTPGP4PTushF98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ywooo/Qw; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2fe9596a582so475770a91.3;
        Fri, 28 Feb 2025 02:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740738165; x=1741342965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zQMkQAtj6vzSQBpImtNQZFAAzOJ67Rs10PHBe6Pdo/Y=;
        b=Ywooo/QwziEi+rLbWHW9j2XP2SValmUxDlR7gsMikRgjHSH9StwxTZiTmiJjlfK+gm
         lkLeS2RUVA61KPIacQHjx90ozvovkmc0XaPwejjYAum8RKvDQhIS881gpE/gojJWUHcc
         EJeQYhITGlcB0o/Zh45jBuNVHd3JMR54TzmxkC9t6dzOL+0Xx2mU/fyFa+qU4+8stK9a
         KwiKqJzQGoP2leFGamqDMChXojWMCF1QdghuHo8BXauxi2IHhcJ53heLwL3CCJ1ooQSs
         xe+CKy4GkcyUrXPIatgY+tgh3xxVZlL3vVKjTpb9yZpdxfrnAop4AftuYs+mVYWz+h/5
         v4cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740738165; x=1741342965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zQMkQAtj6vzSQBpImtNQZFAAzOJ67Rs10PHBe6Pdo/Y=;
        b=MgyZJEnjyMUws1Vnb9jBHuQ7D9GNCNRoREBGRcosIPoTZjF+cHvaG+eM5yF2zSCUTe
         Qket5+ZSr/hLCd6xcJm03U0Bqb0No36T7BjugosuRQSNRwv5Dn+3DV5SmASbj67NVzp2
         UBQOoMEVL0YiiM1l4sOgSnAa1Y8AtOQaJw7w7f4vPsKMBiUEgRZwLGUjtgffruVThIPM
         YbFg67yE3/lbvtnRvvKEnQQMa1La0ICMDUSv+NL6ZLbSh1uiN//EZWYjkIW9hvrvLKAx
         V/geGtMqeVN1X4QvrbB4nZRLEFXnyPKwJxxTtLHteSbNEfhWRpAVkTEehxClVyu4Ms9Q
         PGzg==
X-Forwarded-Encrypted: i=1; AJvYcCVBprYe94Q92qwjGOlHjqeqrZ0IQSVDrhBsis7UjW/peDyMv/bBpTJx+jW130xxZfKYh/92@vger.kernel.org, AJvYcCVknXTQo1o0ApWkS9DZxLAGjtnoP2uiBxNgn7aOcRHc+78g+69CDlxQu+0FLJ1Czm2hOdMLIZS8Kkn6@vger.kernel.org, AJvYcCVqXCiTn/k0u0WIU7+d1FCGFW8ZKDLeRmF78poN4Harj+D4elI0POChb9OQvHip28UawabMCC64y+EY@vger.kernel.org, AJvYcCXGDYvro+L6qve4bFWLo/c1AxPTpvg/s4EtwU0qiECHISDN/LXEWaHpmL5pD6o4uA+RU4ifcXiShVXXu+Yswjw=@vger.kernel.org, AJvYcCXwLdAVn9et3qhMT7lFzIE0G0fECMQoszgkNaTi7bgAFVe7t/VKsKazKuU3so7+88MJp7Os3K8B43N/RYfh@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxn71jxs6OzWagodT/liUt0NKeXPyeLxvjcqUukOAiWWlI8NhJ
	PhpfnqBa5NjaiWA4jiYJt4G7omtcqN4O4xzCgpECUqCJBicst95KANQuABjxgu1IDnO51UDhqWO
	YQ262G3afKeSo+0WD5pGuYjwv3U8=
X-Gm-Gg: ASbGncspADguRiiL2x091JegG+aIzErRLi+HnJXbTS9PpS6R5rRf2s8datufvISkr+s
	+OM+TX1jQkKde/HLM3QcDZNMMfO4SFE8dGZKAvBOgWod5M2Dv832mqZ0c9axKTe77vi3b1U0lRj
	P9mYVg9bc=
X-Google-Smtp-Source: AGHT+IHIittGCPQby1z/CAAucXt5JFtqaN9s/CywTLEe2k/+dixEbEMthbGRpWklymixZ1tzV0vdjHdcEd+cYidEN04=
X-Received: by 2002:a17:90b:1a91:b0:2fe:a747:935a with SMTP id
 98e67ed59e1d1-2febabc3f2amr1758599a91.4.1740738165504; Fri, 28 Feb 2025
 02:22:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241219170425.12036-1-dakr@kernel.org> <20241219170425.12036-8-dakr@kernel.org>
 <g63h5f3zowy375yutftautqhurflahq3o5nmujbr274c5d7u7u@j5cbqi5aba6k>
 <CANiq72=gZhG8MOCqPi8F0yp3WR1oW77V+MXdLP=RK_R2Jzg-cw@mail.gmail.com>
 <wnzq3vlgawjdchjck7nzwlzmm5qbmactwlhtj44ak7s7kefphd@m7emgjnmnkjn>
 <Z72jw3TYJHm7N242@pollux> <nlngenb6udempavyevw62qvdzuo7jr4m5mt4fwvznza347vicl@ynn4c5lojoub>
 <Z8A4E_AyDlSUT5Bq@pollux> <w2udn7qfzcvncghilcwaz4qc6rv2si3dqpjcs2wrbvits3b44k@parw3mnusbuf>
In-Reply-To: <w2udn7qfzcvncghilcwaz4qc6rv2si3dqpjcs2wrbvits3b44k@parw3mnusbuf>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 28 Feb 2025 11:22:33 +0100
X-Gm-Features: AQ5f1JoBAMoLfZEmHB4LoCW7CaOXRtnCBfVtt6Z6is_lk4ig8YbV9oYSmUL7ugI
Message-ID: <CANiq72myNPVD=1jHzFxryvnBuwqdw7-PDbPsQ+FdpCjeYtVzig@mail.gmail.com>
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

On Fri, Feb 28, 2025 at 6:29=E2=80=AFAM Alistair Popple <apopple@nvidia.com=
> wrote:
>
> I'm not sure I agree it works perfectly fine. Developer ergonomics are
> an important aspect of any build environment, and I'd argue the ergonomic
> limitation for (2) means it is at least somewhat broken and needs fixing.
>
> Anyway thanks for your time and detailed explainations, I really just sta=
rted
> this thread as I think reducing friction for existing kernel developers t=
o start
> looking at Rust in the kernel is important.

+1, it is indeed very, very important.

But, just to clarify, we have been caring about ergonomics and
reducing friction for kernel developers since the very beginning,
including asking upstream Rust for features and so on when applicable.

In general, it has been a factor in most topics we have discussed in
the team since 2020, not just for source code or debugging features,
but also docs, KUnit, and so on.

That is why we would like to improve it and why we have it in our
upstream Rust wishlist and so on. In other words, it is not that we do
not see the issue!

I hope that clarifies.

Cheers,
Miguel

