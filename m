Return-Path: <linux-pci+bounces-22578-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05425A4846F
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 17:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 178907A1AB0
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 16:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A2B26FDAE;
	Thu, 27 Feb 2025 16:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1yXLbDV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860C826FDB7;
	Thu, 27 Feb 2025 16:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740672403; cv=none; b=ntG45iO5WTLmGmXcmxcoytMC/irZiBJTlsYyd8sAhFq/S1KFm7tnmwqoA2MpL4Njjp+y8KQQpQT9vIZZhg+pQeSTelQHYP0pY6Cp82rY8h0sjK1xcOp+PNzqxa0PC3HwOLaXot1jTqfJ6KmFVJaZCn8pg9aYLcuBl9qz7KMb9GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740672403; c=relaxed/simple;
	bh=PJfgPnKJ89sswz05HEjeGzyw+HZGCWBZpjHbZs0nHMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VZtQzlOJWwYIuOKkTnFo2tgVXz0phz3Kqs5TslY32ihGLC2vRXn0uxq8DCE5WnHrG76OPjmraxGKoL+stxEHzPXNu9O0foNMdSHsPgW7RyRAe0eUrJ6mByQHjoa5hUVhoXvpCEsVweUaPvKhoo2+fW+JwMVkDvFUr1Pp1ZcIOkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I1yXLbDV; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2fe8f6a4bfaso305367a91.0;
        Thu, 27 Feb 2025 08:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740672402; x=1741277202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJfgPnKJ89sswz05HEjeGzyw+HZGCWBZpjHbZs0nHMA=;
        b=I1yXLbDVK0AarkOV01ID3SFH86PTImcP6Rl0LikMc15i/7wNVUHSkjsYFyJWWpbngR
         nUM0blQpCdHjHzq/l76H7FSG5RDcIbdzsO1kGxqwoMKHINCGJpID3jvlGx4S8pA/eCZs
         v9QQb1yqKbj3puS77N0S1MimkGdEhtYY5vZvx7JFgZ7JGI0KvZlNCvd6xkBHK/Uv/XUK
         L11bu4bMI2CONMMQlmgHmYvFbNYl9mULHHRLZw3Gy0pZw0+j6tmlL1hOEgWxS2869uzX
         K2Ie1RgQ0+IRtQyPi80lWyTzX3mofmfjO4k1rEeNB4IosQHCEOINzzWclg88Hj3v0Bfo
         gotQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740672402; x=1741277202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PJfgPnKJ89sswz05HEjeGzyw+HZGCWBZpjHbZs0nHMA=;
        b=o0hZBXoG2XhVoTBPchcMM7KsA1Pkm4I9ZpeJuvX43r94pWACFek4JkoWqunfMMcovQ
         f0+b/shb8sGvvsG2nk4Y3+OyVgaek4kxDTDif+aCuAageCbcI8ZM2/SiChJ/feJFFYlu
         3ajxYg6cZbDYzrimh7e+Pop1pp+9bEJGRulDznohjkk873LyfdI/3PKabooqKus7AjtM
         mvxk8gRVPA6dzMio7PiqLAmmXOGMmEwZb9EPQtQBKFvUh/BspnpU4LuzfHhmO8lFDiYs
         Y2SPWXtQ1dR4hFnYYCTB0xeMEU9PYv7UraCsGuqmqFpif9LDPxnFkbsUTP+YhUe5I3bp
         jIng==
X-Forwarded-Encrypted: i=1; AJvYcCUH2Bg/mHSw8Pm3zNvFvk8z80M1NwChqeC+dqX0XCBQwTTx76a8keSCOhGnlK4uYgK0MZiT9Ntisj6p@vger.kernel.org, AJvYcCVwYljQoJmwa3pbxplPYkm7/z9c0n8B+BX9aYLepEdzB39R9aWdkyZetCLlwzjojcPp2aQ7s71Wy/Wz@vger.kernel.org, AJvYcCWuDQ9kzkbj9NAgFPAoUwx0DwmDP96ermbDoxajHNgBmWnDKvYwXqTZvmSOUulEWiNw05vd27ipOg/URfNj6Io=@vger.kernel.org, AJvYcCXikuNVkGmgswLLCDIdgiVLnYZ7aP7giEF4XA3VxmqAwHu6XxGC9Gol6flhXT2Ytf1aYzt1@vger.kernel.org, AJvYcCXwE39QtVtPZRZ4Z8xWqyf82sgeHp/vQyf/W5vriy3OFwdMlLj94bsoYUNKhGRnxryIH2arTKEFOWwA2bCg@vger.kernel.org
X-Gm-Message-State: AOJu0YzjQGhAEWz7jaU4f2e4T+lydk6WHY5TORk2NRX0M6h39/+xPJqW
	YctZdc1QRlj8sALnVXFqkdOEV0V7zVOZ84d/SXVvqUesCUympsVb7S6dt/R/SYUUafjFYSnPkUj
	ALMNJQBy2b4bPlnXUOiu8vhnmQmw=
X-Gm-Gg: ASbGnctcF3POyyvaBSUY/0As05pB8fFGUpCwz11535HESlgbv/AJSJgvtq8y2XDWsNS
	NbK6uWhHEl6G/mDvTGQA0PZQkVd7MYT+FA9bzHp6Xs/cF87nRHdQeC0lIHPzmnUDHkbnK30DqyZ
	xkl/s2lM8=
X-Google-Smtp-Source: AGHT+IErgJSlzMKoFDBnkaE7/t4p7pkyKYyZBw7RJv2MRmTY5RNYgYWmYi0oEf6W6z4sa2855ARS13/cWfLtygNaRCM=
X-Received: by 2002:a17:90b:3a8b:b0:2fe:a8b1:7cd with SMTP id
 98e67ed59e1d1-2fea8b1093cmr1569044a91.2.1740672401702; Thu, 27 Feb 2025
 08:06:41 -0800 (PST)
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
In-Reply-To: <nlngenb6udempavyevw62qvdzuo7jr4m5mt4fwvznza347vicl@ynn4c5lojoub>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 27 Feb 2025 17:06:28 +0100
X-Gm-Features: AQ5f1JqLW2JqfenVRPiw0Bw5DJ2q63fM_hLXAaW41V4GKj_UYjrOy-DoLwS8j8U
Message-ID: <CANiq72n7gi=BJr72P1z_MKaOTRV5p2R3EoP_dUZ6C02xf2WA=g@mail.gmail.com>
Subject: Re: [PATCH v7 07/16] rust: add `io::{Io, IoRaw}` base types
To: Alistair Popple <apopple@nvidia.com>, Gary Guo <gary@garyguo.net>
Cc: Danilo Krummrich <dakr@kernel.org>, gregkh@linuxfoundation.org, rafael@kernel.org, 
	bhelgaas@google.com, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, bjorn3_gh@protonmail.com, benno.lossin@proton.me, 
	tmgross@umich.edu, a.hindborg@samsung.com, aliceryhl@google.com, 
	airlied@gmail.com, fujita.tomonori@gmail.com, lina@asahilina.net, 
	pstanner@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org, 
	daniel.almeida@collabora.com, saravanak@google.com, dirk.behme@de.bosch.com, 
	j@jannau.net, fabien.parent@linaro.org, chrisi.schrefl@gmail.com, 
	paulmck@kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 1:26=E2=80=AFAM Alistair Popple <apopple@nvidia.com=
> wrote:
>
> I've asked a few times, but are there any plans/ideas on how to improve t=
he
> situation? I'm kind of suprised we're building things on top of a fairly =
broken
> feature without an idea of how we might make that feature work. I'd love =
to
> help, but being new to R4L no immediately useful ideas come to mind.

It is not "broken" -- after all, it works as it was intended/designed
when it was introduced, though it is definitely a hack and thus indeed
the message could be improved greatly. :)

As for how to improve it, e.g. Gary suggested the other day to use the
DWARF information to locate the call site.

I guess another way would be to generate different symbol names per
call site, so that we can embed the path and line number into it (more
or less), so that the user at least has a hint, though that may have
disadvantages.

Cheers,
Miguel

