Return-Path: <linux-pci+bounces-29321-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D95AD362E
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 14:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFE791749A9
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 12:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508732918E8;
	Tue, 10 Jun 2025 12:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqXFtLY7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C718828F503;
	Tue, 10 Jun 2025 12:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749558544; cv=none; b=i4FAmXUIevhjQCKMrs0wPsTvMxvuxc1bs2MeSb7ZF6ohCl4qBjI26d1DDol8Qi/mLQgHzJ50tQj0tGxl8BrPLWfbNt8lMsoUirIqVRxTKlK49QcA/26Gdf8LNvM/I79xt/usS9vqwGTsWkClbhaMjtltvIG4a36ztz3Cbsqjd40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749558544; c=relaxed/simple;
	bh=2UbnsN/0HzJVFD9xlg8jO4RD2i/2zdrcJP360HZf1sg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BpERMqeefHJ9OHHHssrTmmAT0dls984l8JE8Wy8udoY6L6UMDOJNomXe8wbqFtdSlnzvm/FkbyAOAK9mOynI+p7lOiC5EX6148GIbG1FSC46ewvRkXe6JOaKyOc++FC+1xw3L2SJnAbR8OqWJa5rHoGvXLDwtqVjuodKorhxXKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fqXFtLY7; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-313290ea247so796561a91.3;
        Tue, 10 Jun 2025 05:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749558542; x=1750163342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2UbnsN/0HzJVFD9xlg8jO4RD2i/2zdrcJP360HZf1sg=;
        b=fqXFtLY74Fe3HLxwrSUeUv1xQdLX8JoFsCoj2qXezKhexfg2pVcPGcLrGXtgD8l980
         FvqLxvPPQ8W/A7Ped3TklzHRAWoiocGC4zpE7Irih56I9SKEpBdq9Y4u0/WvUhWKI2xU
         tJiH6d4fdUPfQA7xTg/qUiDeKvGmOO5AbtrimJ3J/SuQgM7ylN9uuj/tcjasuP2bvf7K
         ci4uDT0dE4sNAaj0jGUydWDErvL0viF6hq334JQNubUQOCPnlQoDBkVDmt1bO4rAx0P6
         Dy5P2bsvUfyX3lpeYBRIA7r0SzSIk+aPA0DzJ0Ut7E/Otttg2oDNNGkffgnqNN4/G+su
         ubpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749558542; x=1750163342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2UbnsN/0HzJVFD9xlg8jO4RD2i/2zdrcJP360HZf1sg=;
        b=mXvWEq8Gcj8fV7Z0xvXxO1AGbzvTs1fWZg3Ji+j/gm36XKo9h1OdQ2G4FbwR4uD3+a
         SwdlQRU3t+BYFM5E7zugMj1WD83UPTM9Mwhpym6GPmmR6Typm9MZP2gtMp40VRkBBmk9
         aSZe1uuYw3aIZ76CzGtiywnCJhq0YUsDPYPwbHuBo8cHMDdJr+7EEnhr4Yr3FtiMRLEp
         Uk+fGgmXHrkRxSBsxlttJiZ0n4zQKSbUC5MD1HJN3raxjZtKDCsrwhSvx/KwniKXHeRe
         enQ1FuGFa9Nk2TB2SrhkDT9iaBUBZUp82UYtyn0BYekLblD4vm+Cs1A/6Sfc+xJ+0tHJ
         WGIA==
X-Forwarded-Encrypted: i=1; AJvYcCU4/He7tT2vND9UWu4Gx5Zu7s+tFWtxpoVFssGxonsgLgMYXpW/cMQjr1UUYw9CRSSmmEe5cx7TSFj0VEwcO24=@vger.kernel.org, AJvYcCV+Mz1r6wvTWuD+/i5vxBWAVqJ8tnR9MCPYiKnli4MM4cc7Hkjh2sv+iWAopT6tJaAcFk1XhY93xjky@vger.kernel.org, AJvYcCXKXxTRKCimEnM8ZI5pKK1Dy+aOFKIFOSG5o3yWAt4/8H8MbVX0mgIFzd7ZQiOTMNP856Daw5NNJD35DVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNglMIfelzUGtPuzKvAuujtkg7jeOI67lVACzIXi8x7zMgibg8
	z6iTyUQ8pnIEwf/4YoMS7vG4lnpBG3JqNs2w5AA84Oe7x/oinRbqtAg5sVW2R7YyVpSyjG69oBV
	jurrShsAkj6GGVN+jJAmLB4xcCC0gRo8=
X-Gm-Gg: ASbGnctZgVAhD1vehpXpAMZO0raMhYNYmT1TGWu2Oo9nfy1U02LhD8jnnb9XQr4U5wZ
	TJBtLMWPas77g3o54go0qy25UvE4lf3/tvjp4eOtgC33qgPQhg9dA1rfEIE1CHg/4wW3Rf/SfcI
	rgRlLyiYFYnApkcMSknS5fp6SFHy4EVKqNqX+EJC2izAI=
X-Google-Smtp-Source: AGHT+IGKJQK2v6FM0o5IGKEscQY3VpiTZYOi6jXZ0deKyklBQPXuPdbcZh/CoYwKmI+Zc2LZCYY1j8Z4rnonUI10r5A=
X-Received: by 2002:a17:90b:53cf:b0:312:e9d:3fff with SMTP id
 98e67ed59e1d1-3134e2da3c9mr8566788a91.1.1749558541925; Tue, 10 Jun 2025
 05:29:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610-pointed-to-v2-1-fad8f92cf1e5@kernel.org>
 <ABpacmV2zqpdR5tk6NDHTg9kbssxZOay4JLvHJWs6pS0swz_krftwuUN8k_SABP04TF1k1Z4uW4IH29D2Qb5OA==@protonmail.internalid>
 <CANiq72kYdtozcN1U1yGhi_orh-OVO2xp3=wQPAhwgx=wTi-neA@mail.gmail.com> <871prr24he.fsf@kernel.org>
In-Reply-To: <871prr24he.fsf@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 10 Jun 2025 14:28:48 +0200
X-Gm-Features: AX0GCFsUeLNISdH1VBrQM4vnuNs7e3EdSLQvU8l0WJ9OFeQ0M33QThRkcxjaYO4
Message-ID: <CANiq72kxN45+U9VA8mrPtzYG0xdomehO5A==CX+79iJFJ0edeg@mail.gmail.com>
Subject: Re: [PATCH v2] rust: types: add FOREIGN_ALIGN to ForeignOwnable
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Tamir Duberstein <tamird@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 1:58=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> Yea, sorry. I just changed the kbox file where Benno pointed this out. I
> can change the rest of the places as well.

No worries!

If they are new cases, then I would use the unqualified ones (which
are also in the prelude now), since we are trying to more towards that
(commit 3d5bef5d47c3 ("rust: add C FFI types to the prelude")).

That way we have fewer to clean later on.

Thanks!

Cheers,
Miguel

