Return-Path: <linux-pci+bounces-37336-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2834FBAFDAF
	for <lists+linux-pci@lfdr.de>; Wed, 01 Oct 2025 11:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6F21176442
	for <lists+linux-pci@lfdr.de>; Wed,  1 Oct 2025 09:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD88E2D94B6;
	Wed,  1 Oct 2025 09:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TVBaEkyI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20C21865FA
	for <linux-pci@vger.kernel.org>; Wed,  1 Oct 2025 09:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759310964; cv=none; b=ePkXuaGnrMZTmRd8CdX8B03+CxIfIyadol95qYicNbCfIsT1Hak1oJl2E0v9rbZvrpa4d3HNRJ2Kw1iBD8GCl4C2YQlF5cru8uRikxB7Rxky9ESal5iaumSeeAd4SJQsrGH0EZ6XQcjq08r7hufhWL19M4VHqgoslk2Lmw/DRpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759310964; c=relaxed/simple;
	bh=eWhaWIh1Ch5W+HrhvE/7nWxIJ4BqD2s5kUI/3gBmyEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nb48X/aV2FfmR1vpSVXjJPbtZyXyIhPwxLjNIr4xN+D0YYOzMWDAwmEo4ZLaw8CrM7P8VzxUN2y79H6RZkxMdhiNHC3eRLYfPHQyikRB/W6AnlB4A1JH8hyEa/Ri0MMAkZHGQrAEMZAADnDb1PMaxgC4ygkqCQjRD8av3jn7ypI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TVBaEkyI; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3f44000626bso4201838f8f.3
        for <linux-pci@vger.kernel.org>; Wed, 01 Oct 2025 02:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759310961; x=1759915761; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWhaWIh1Ch5W+HrhvE/7nWxIJ4BqD2s5kUI/3gBmyEA=;
        b=TVBaEkyIVsWpPgc25PthN0dgMizQ6ejHVgbgY4cBzyNmtAMFUxALL2/XSvvKJkBJsb
         nDMVrtUeFd3OpEfW3EoEcn7zKGgKwSzKK6TBOSXbDglCX4YaAdh419jxyWs9gSIew1u7
         br3pPtBGPK+11HqzUpIOPf0//hSkV2Qmie5YLPhJ5K/5BYBVZH17YsA1yhe0dQRlNJti
         Rp26I6LcqZUn5saUboAhSALCKrU0y0bvtQl3gk/xIzSlF6laY9r6Y6+h2zODmLkxIDEm
         Yul6SYPIAC96/iUa230+xFVkC1Ne7w6ghfm0lj7XZyxe0v7vCRrHZWnlBDr0k3Plu8Ci
         C4KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759310961; x=1759915761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eWhaWIh1Ch5W+HrhvE/7nWxIJ4BqD2s5kUI/3gBmyEA=;
        b=GVASkDEYrmB0X9QQaBHPhndyaAkH0kEvO/7W77Mam23NDOnsjw2xXMWqvcnzF/Ucza
         By4mVIiBaNC/Yz3v8410KoB0VvODoJlq6l7Vg9TDomiSSY/WBmQkQNohQEkiAIZIama1
         BQ2HJjwDLN9fd0AX1Prp+dFID+8v7oxwxveq2zcX/N2gdn0ltTWHOyhyLr7QB7r8wS7I
         aJhECuwHydmTyN5lnPKLGQID5F+SDb3ICVWP2QMeOZe7PvI6or78UMUSxeNCmGJzUw3X
         BkXOMTTpZtZlr0liU80T72dHpvRDrvNx0eQPYKPzGhw2SMdgrJRalFOe5GV16h5Kh2UU
         TzJw==
X-Forwarded-Encrypted: i=1; AJvYcCV4vR3iny7r0xgfaGXprgs5mhIu08oEGdtGc7nZaDaQUEVuXFsk4tXTUW14/MDTBi3BygRUtOX2Et4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzCXSsT/H5ZqPebadweRPeK+Y8Bhx+nVnPAI3YDkQJOjAH2evi
	sE0oTPT6rXm2b1YB2boBaNa2oOnq25qPZ8XA1p8z55euPIRZ6XZwHrNzaghZzA7A9Kmy86DF/gT
	Bhj/wXdLKTD7cvFXtZQwnaEsfPzZ3CRtJWjWoCFKp
X-Gm-Gg: ASbGncsWsAIVQZvbkEaXyPSNUxW2UMKtqBVClyp88tFwyDFZbmaXJEgjbQkO9LuijGY
	dFWjpyU0g6J0qDhvguuwVyTxfeLRH3JFHCdpcfcca4jezJC5es/zDjUcZYO1+CZ8JeWU85ZumA1
	+UMVecBOn/U5zTKe7o6JE44PZuAMXsQad7F7td4pMTay5pavDa8RmN7SOnWh9bUsk8q7e1PPe/3
	VW6JgyyffZj/lQUw1Vs3SLVZ/5l8bJIw5VdiwBu5Wxio5BIVXVrsfrxqpLjLKhhS+N9
X-Google-Smtp-Source: AGHT+IEGTvzQBJ51h7EDzxRa/Kisf+BfY+7cpvTrlEhl/iMUN4+q2HPEwsb4ysW4cM34kR4mPUadGwVDBMTe2U90ivY=
X-Received: by 2002:a05:6000:610:b0:408:9c48:e27b with SMTP id
 ffacd0b85a97d-42557820c81mr2042096f8f.62.1759310960773; Wed, 01 Oct 2025
 02:29:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925-core-cstr-cstrings-v2-0-78e0aaace1cd@gmail.com> <20250925-core-cstr-cstrings-v2-19-78e0aaace1cd@gmail.com>
In-Reply-To: <20250925-core-cstr-cstrings-v2-19-78e0aaace1cd@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 1 Oct 2025 11:29:08 +0200
X-Gm-Features: AS18NWCOfBcX2Vbfhr-fnk5GPcApSeOL4C5SAm45sMYmzlcHM8gTiQQ5VZSiyfk
Message-ID: <CAH5fLggd09hodiDAdNRy6aXK9ANCP==YSJwy-GMbhNAAMm731A@mail.gmail.com>
Subject: Re: [PATCH v2 19/19] rust: regulator: replace `kernel::c_str!` with C-Strings
To: Tamir Duberstein <tamird@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Alexandre Courbot <acourbot@nvidia.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 3:56=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> C-String literals were added in Rust 1.77. Replace instances of
> `kernel::c_str!` with C-String literals where possible.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

