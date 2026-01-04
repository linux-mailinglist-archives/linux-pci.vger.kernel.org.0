Return-Path: <linux-pci+bounces-43976-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F370CF131A
	for <lists+linux-pci@lfdr.de>; Sun, 04 Jan 2026 19:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2604F300C5F6
	for <lists+linux-pci@lfdr.de>; Sun,  4 Jan 2026 18:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBC32D7DF6;
	Sun,  4 Jan 2026 18:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEuqlHrv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C61E2D660E
	for <linux-pci@vger.kernel.org>; Sun,  4 Jan 2026 18:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767551437; cv=none; b=oaj90jMlJSo9422hOyMrsZQeXuUkOKIgZZo4F3eXOYAmqaRbjlcTn3+Pqo8JTXlYNQ6Sy5AzemcyOzNpDFto42nq16DvBX/qsmK/Hn1ouexLGdRd2BjRWRPNOqv9o5rErGSG6BUOseUVRjEHo9erjEjrDppjBJI8lfI34dvmCTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767551437; c=relaxed/simple;
	bh=2FMf9qZWkndgIdfX4lTJCzcI5l8G0uyat9bQRXb33QE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o15bBCoY/jAhKOdXcQU4ttcTC/8mLrPM1n2LKnB+MTlyY/H3zg81h6PcqgY1rJkS+UysyQ57fx0YGheV9dVbZmUAHt3e0vk6Wn1gKGK17u7cAwBRW2RyUrK8g0GgQRw+mfNvMhWErs/Kk68IIjW05lYgnHagSng0FWxMK+4/oNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dEuqlHrv; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-34ab8682357so1626984a91.2
        for <linux-pci@vger.kernel.org>; Sun, 04 Jan 2026 10:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767551435; x=1768156235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2FMf9qZWkndgIdfX4lTJCzcI5l8G0uyat9bQRXb33QE=;
        b=dEuqlHrv9XK4/Gsrv5670oGsNlMPeqeT+5l5lNDFwG0f7TZw/NyZ7MBqF6uRt/7MRt
         +ovD3OKGSU50Pk7mV/7LGII4zAkbRlJ/49Pg+Xo1iwtHyY5M/ya0D6mEd9GLCYJdGkAI
         q0kAS4S8EZoCboReGac0uRZCwHWL0NbhB43EX5UcZCexGD6IcIygn7lYvnVCxnWQKItB
         sNNPD5+D0A5pq2L9+JkaUp+eSWvBA8h2FF724lATjpLyPAiJyaiqcsyccTiEfior1Vmi
         h/1ICqEUnoNm3Z74AyRG07Z+v4imw+SxF9J3effMrLaDJUo+ptxfzfSVXPwUsPRVBuuO
         2EIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767551435; x=1768156235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2FMf9qZWkndgIdfX4lTJCzcI5l8G0uyat9bQRXb33QE=;
        b=dg7uAQQgyJqW+xH0URbYJf/1uPqkf4GoxB+HZmw2TB+F5LDZ43LSFssZv0JjM7qWMB
         Y4ndeEG0zhlPvAFlzVleifL/+5RS1Ujpr9GRMhp1lsUnp4XU1fTblAizwCnG3gWXwAAT
         vmSs1r4WwJgKsRevTrd7JYpdRDZAgZBrEQ1LaB4ZIR9QzhGMzX7yYCg+/0T9SW/mWcey
         8VKTdQQEI8LVYh3fi8SJ6PPGqzPA1h2k480/vZgpd5fqrK6NR5UsN8SEE2z8ZH7JUkF6
         +AdHkE0mEJMP0naiVi/Wmx24bQKnQ+ggHbOtOCpQTPxAwyq71dQzvBH4KpWaqyNza6bW
         f5ug==
X-Forwarded-Encrypted: i=1; AJvYcCXI8WAlXGaVk99cQ7TNeNCwpE3YC7i9M5ZWmo5Jz3M3erH+MPUuLMAGv6G4wz9ckGnYWAYk800i1s8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPCVFxmgJT4/33GMg4Yjd61HKm32p2xPdtWsbVfTF2pl/DB1vH
	l6B7WraUUWT1kpkC4cr9d6ZqQ5LqaqT6CTCvKnE3bFIkmnCMNj3dFqVDz9NmO29H7QNQ4DiWwxL
	N5AxMKBV7SKrpoYKaUz/dFpVgmZjkdl0=
X-Gm-Gg: AY/fxX4T7SNpB1yWDhOefhhq3nDfhQ68OBJ5YbZMZVaw2D69y+QtxvvcoEQUql2Pw0J
	ttGaACodDgZj073NgzB89nvA5GbMbcqx1cHy1wiozF7xq4PDNsMrXqotkBfZsMmJdk8mJCu5bPv
	VBJ+NrTNQIsjGJquC5a3Ppvw18hbPcWZ1RVj8PcuZOZxfzACP4Bue76pe8SAhzUzGJdF5GDV58z
	M5X4uhzqOCkvRyh3lxGlevl2n9gGptC/zJ+pmL0RDUdDFbBTna6KWz2CcHh2EXNsKoJK94p6uJb
	SSkj/2stzg4JH1ynMt30bTcU3v0M6t5Ee1LwMM8PJpaGmE68FW0ZndGk3pQItiYU+uWGTEl2MYq
	F7BcfXZPnKf2N
X-Google-Smtp-Source: AGHT+IEN2ZV3PmHk0U2hOsgfRRLfJgqnWA5WvTpO/3j7uswcdn3JtlcK4tmqCIPkoBBSPuwlNN0Yrlooa7Bsvz6TIxA=
X-Received: by 2002:a05:7300:478d:b0:2ae:5e96:9d1b with SMTP id
 5a478bee46e88-2b05ec30b31mr23553167eec.5.1767551435363; Sun, 04 Jan 2026
 10:30:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260103143119.96095-1-mt@markoturk.info> <20260103143119.96095-2-mt@markoturk.info>
 <DFF23OTZRIDS.2PZIV7D8AHWFA@kernel.org> <84cc5699-f9ab-42b3-a1ea-15bf9bd80d19@gmail.com>
 <aVmHGBop5OPlVVBa@vps.markoturk.info> <CANiq72=t-U8JTH2JZxkQaW7sbYXjWLpkYkuMd_CuzLoJLbEvgQ@mail.gmail.com>
 <DFFV41VPS2MU.3LHXU4UKITD0U@kernel.org>
In-Reply-To: <DFFV41VPS2MU.3LHXU4UKITD0U@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 4 Jan 2026 19:30:22 +0100
X-Gm-Features: AQt7F2okothj0EUO08sp-m1M34yUfQk5IAvASw86NPhWXjzTsfL5KrZGM1vaSm8
Message-ID: <CANiq72=fFZpWJ9BvHEBqi4chZO3rFo8+-F9=myW1f_JzJ0PNrg@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: pci: fix typo in Bar struct's comment
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, sashal@kernel.org, 
	Marko Turk <mt@markoturk.info>, Dirk Behme <dirk.behme@gmail.com>, dirk.behme@de.bosch.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 4, 2026 at 3:08=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> w=
rote:
>
> In general I prefer to only add a Fixes: tag for the commit that introduc=
ed the
> issue.

If their scripts track moves well, then it is great to avoid it, but I
am not sure how well that works or not or in which cases, i.e. it
could look like two different commits introduced the issue and thus
one backport could be missed. Not sure.

> Again, I could also remember this wrongly, but I think I just recently re=
viewed
> such a commit from Sasha. :)

Hmm... I also had a few cases where Sasha autoapplied, but in most
cases, I had to provide custom patches when they didn't apply cleanly,
even trivial ones.

Cheers,
Miguel

