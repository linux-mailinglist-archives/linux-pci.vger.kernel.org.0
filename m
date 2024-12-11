Return-Path: <linux-pci+bounces-18108-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 086919EC8C2
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 10:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5676188CAD3
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 09:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E93C233685;
	Wed, 11 Dec 2024 09:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ap6NNcZV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C9823369F
	for <linux-pci@vger.kernel.org>; Wed, 11 Dec 2024 09:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733908715; cv=none; b=Xzmuk+4Uo+7yfnqeJwdaPybO9559zmsDMzET3hYneVB/bb9/49njP9oN351LB1NPSah7U8NEz7KYno3QfECfNDa+Mw6MkmIv/9fh9WNPPYyr46mDfmmwHPvRh+X/yKLDB59l9AGVWgWsHUovyjCsmSaKLHPAZDHRBj4KFCNCkPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733908715; c=relaxed/simple;
	bh=3vHYlP+vndcNXuZOI6XprGkQpKc6n1GhE/RqwAQGt1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=poXEgD/ki4Jzh0vwbUhQaQu9m6o/XPbf+QaKkQzOS7v7+FTL+Cjp/baA5GBwEOy3wn+bEYSqfi8kB0GDbalO56TmN7bpT8iuwVYqRhqq/7pEvu7jGpDZ+dVeLyMoPZDxR+aghrGH40PBrFefZt+e8fdltc9wZy8MEVoNiIXUOyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ap6NNcZV; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3862b40a6e0so2882377f8f.0
        for <linux-pci@vger.kernel.org>; Wed, 11 Dec 2024 01:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733908702; x=1734513502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3vHYlP+vndcNXuZOI6XprGkQpKc6n1GhE/RqwAQGt1M=;
        b=ap6NNcZVR9tEdDFafFXVp8tZwW1IbPCjW6gAJOCL8T2Yeu/XM7u5+iMinmN9oD5r2L
         0JNFgDECbdlm/XEY5pAJoB9z4mqPISbUVMQKv/9DVRX7eDN1PSHbQv7ukZCGhwVrme5U
         qwDjtLamHKHP9xUVzThABInaLbgV+AEeDJ/4W5w32lD/9Sa6O/JFwBy1PvRWdoymYbhj
         mhF6yt2jvO7nY0lBqA62zvDTUS4EGXyMIcXpNwEMmkr7h6q2iIuHoUgq5xvdj2pTUJiX
         QkKEbmjFe8ilJ3apuPAu1lH7zLbnyi9ZTiIaSZD0D+F9Q6cxpmlfgGfe9rGdTyGgzR3H
         7UuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733908702; x=1734513502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3vHYlP+vndcNXuZOI6XprGkQpKc6n1GhE/RqwAQGt1M=;
        b=PGVTokGf/OQldKuo571P2gA73xAPL+i01tdQ8eMLhgxURlyo+d0NnN6u+a2HUHn/qn
         nqiSCkZt6wRFc+ISU2tMyvCh10+9CPwX2mHjWv38qCwKa35ZRqVeyDzPQt61iOT7m+0N
         iv1PZIWJPbxG7ENSOFrthvKuBX03a48vD2u6FmgpLW7WepmgSDC6d/eO9YU+T3Mxa9Dq
         uuAqIT2aQyRP7sx/bweuJMPxqpDIiJgfym3A9WYyOC3jTtd29J9WmEd/C1n9iTiaM3l/
         Lj1SZhhlUNtBhanVcCfBK3Uetl/vXagWh7GwpQVvEUL+6ryotSXhuewQhU+24q7gcYlV
         qeyA==
X-Forwarded-Encrypted: i=1; AJvYcCUUGhOe8deOxwgn2KYDnRCBhpFkTle2hHs+fMaqWpC9aC7UJ4Qv+mdRoshTZIn675KcN6911dbBVqA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww1862djmkhEyh+fm23Q2ehXBQnugT4dyNPNdh+MZhH4naXB9s
	bLbxGrUZc9aF9bDFSFVyiuOKPSkvqxlssrIy2/uBfu9Cpsyr7EGApVLS23o0rphk91aJEASw59l
	lxTm2iaaDmE7AhC1h77nmY1331BWBbHu11Arl
X-Gm-Gg: ASbGncvtyzRczFBiqWNOiGFTi9jh0UZ5rg/3928ybRXZ+iMr52g48QWTbEfWsKV0XD0
	fOg3/0N8KNnJgCUw45OwyHD1fWP9aNFRR5fxxf2HHKcgbRP2rM0sQdzfKUjCcKufCig==
X-Google-Smtp-Source: AGHT+IGXlwylyC3zJtiNHL0Jm3c9KPPDvqnLEc6f8/awzTY/st7wW/grsH5pHA1x0LnLhySjtkPO/7zB4NO4hs7+tfc=
X-Received: by 2002:a05:6000:18ae:b0:385:e961:6589 with SMTP id
 ffacd0b85a97d-3864ce96d45mr1556644f8f.20.1733908701835; Wed, 11 Dec 2024
 01:18:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210224947.23804-1-dakr@kernel.org> <20241210224947.23804-6-dakr@kernel.org>
In-Reply-To: <20241210224947.23804-6-dakr@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 11 Dec 2024 10:18:08 +0100
Message-ID: <CAH5fLgjWGRCzy9WXVd=ggi5=R6e8Z12bq8yYwAQLxLMH-uObMQ@mail.gmail.com>
Subject: Re: [PATCH v5 05/16] rust: types: add `Opaque::pin_init`
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me, 
	tmgross@umich.edu, a.hindborg@samsung.com, airlied@gmail.com, 
	fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com, 
	ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org, 
	daniel.almeida@collabora.com, saravanak@google.com, dirk.behme@de.bosch.com, 
	j@jannau.net, fabien.parent@linaro.org, chrisi.schrefl@gmail.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 11:50=E2=80=AFPM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>
> Analogous to `Opaque::new` add `Opaque::pin_init`, which instead of a
> value `T` takes a `PinInit<T>` and returns a `PinInit<Opaque<T>>`.
>
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

