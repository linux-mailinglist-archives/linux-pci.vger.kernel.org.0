Return-Path: <linux-pci+bounces-15521-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A69A59B4A02
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 13:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 456C41F2339F
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 12:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C647F18871A;
	Tue, 29 Oct 2024 12:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wr6DQDzV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FC81E2301
	for <linux-pci@vger.kernel.org>; Tue, 29 Oct 2024 12:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730205952; cv=none; b=YDMDYE/CYwljTWhhgnBINCFMBmCefpnGL4hdu+V+O4SGVDWurrTuO90C+R1fkkUTUt5CxZs2uH8ycyT0A1kh486AVHGs1Zka1Vxav2RpyLPPwCNLZXy/Is3wbW4N4s45gKSipBtocPrQKOu5tV2MTbUyGHi09W3eaq8837w1g0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730205952; c=relaxed/simple;
	bh=GtzJ47n0bMGIC3fQwXJAU5Hmzy0ocBZhCDRYOCRmxZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pxXzDEp7qjI400f8hkAG1MSM0iDXcUyIpTrj9SirwchkzbluU9UnV+UMsMmtofHiFI0d8CbSKuAiG15sBbZd7PVA1MhppMGiSR7Psd6R5Kjcm/XPuSarnpGscjLbNtkhvM3QzM7jzD12RgZhz0n09+9iHxIqUIaGpLpU8neLqHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wr6DQDzV; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4314f38d274so71091985e9.1
        for <linux-pci@vger.kernel.org>; Tue, 29 Oct 2024 05:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730205949; x=1730810749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GtzJ47n0bMGIC3fQwXJAU5Hmzy0ocBZhCDRYOCRmxZU=;
        b=wr6DQDzVgsxzoBfN0tOEWhKrDMMy2lq+MYC5dZCB9175P8C/HW975PcOeeAOB9/Oep
         WhwYf//UYIuPF+YWVT/Zsi3xHElNMHr3AaatzUdRw5npggTaV2CUpXVy2W8La1FzWn25
         gJ4L372teJDi8wISFxQKpBjxM8PUmwl42/i2tplU0Upi8HkqDy4iwOWb+bIYcT1EarQK
         0uiaYjSc7+zHFbD9JIbfA76MiYu6SR9J/hYzukeo9h1QzZ0xls4hSlPUBUVoaps4YxOy
         HVuVUPg6iX0hFqsTXbZDNG7aEQ2uvjF9jebQRZ9OfPe90ZLENK048af0b8ioNal40vW3
         2oKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730205949; x=1730810749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GtzJ47n0bMGIC3fQwXJAU5Hmzy0ocBZhCDRYOCRmxZU=;
        b=JA9h0Ykhw7msS2LsCAAwBPPpAjkwY8LRoe+ZK3T6eVdm3qfXBNP3HoqNDvr24cWDoq
         8sQ4Rc651D9+NA5SstGlOVyRUmaIDCNyGUmgTcOlPaU1Z+hPksZaQQvDSqFuiZMCeKeT
         b5Qz9h+z4X/gRc9rdwLpnYdb9p3z3WP2Ubs2jpvzah/x6+dj8Wvv0kNQ9Kub7BMLfzVl
         A/6ekviLRp8OdnKYszZvExkTmg/1ZhPg22PfbYlHQZ+BFUe5q9z6UYY1T1/9RemCPoev
         Ji9qr87F411D9+Mb948QHPIv4bkXLGf38LYxL1NzNJat08hhtNO5D/Bd9lejE83V8mjm
         xEAg==
X-Forwarded-Encrypted: i=1; AJvYcCXJ1bja/9/oGILSdlx6YLVgF1wuxQ23eskW+h5UJF97ZR+YP4DDDSEF67+zxCP/Kf1BhjlWw2TwwV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkGuYms5xZAYuwn2u0h64Nw7OzYcEFQqv92i3a5IedDQCrAom5
	hIEfawza9LdlZzRSH+eRDkuBOEInXhYxTn9CEVDErahC9HAL+MsA05xTXshXqSE95t1cgBowY3j
	YryZ8SRI2Notd9qYXMHjjJhBoWV7O7L2J5B/G
X-Google-Smtp-Source: AGHT+IGeiowj3zMHJ3YR03nzzPGzLm/Rxvr4HwKwchMRBnozZXVzhVD6hnCcZcIEs7fKbrQEswkrjJ+oz3BaJydpoLA=
X-Received: by 2002:a05:600c:1ca1:b0:431:518a:6826 with SMTP id
 5b1f17b1804b1-4319acadb66mr124917775e9.19.1730205949075; Tue, 29 Oct 2024
 05:45:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022213221.2383-1-dakr@kernel.org> <20241022213221.2383-3-dakr@kernel.org>
In-Reply-To: <20241022213221.2383-3-dakr@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 29 Oct 2024 13:45:36 +0100
Message-ID: <CAH5fLghQ3Rdgk+xzz9RzNzTs4vYLMO0q-SkDOrnb1u4TkPQVUA@mail.gmail.com>
Subject: Re: [PATCH v3 02/16] rust: introduce `InPlaceModule`
To: Danilo Krummrich <dakr@kernel.org>, ojeda@kernel.org
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, tmgross@umich.edu, 
	a.hindborg@samsung.com, airlied@gmail.com, fujita.tomonori@gmail.com, 
	lina@asahilina.net, pstanner@redhat.com, ajanulgu@redhat.com, 
	lyude@redhat.com, robh@kernel.org, daniel.almeida@collabora.com, 
	saravanak@google.com, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, Wedson Almeida Filho <walmeida@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 11:32=E2=80=AFPM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>
> From: Wedson Almeida Filho <walmeida@microsoft.com>
>
> This allows modules to be initialised in-place in pinned memory, which
> enables the usage of pinned types (e.g., mutexes, spinlocks, driver
> registrations, etc.) in modules without any extra allocations.
>
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Miguel: I think this patch would be good to land in 6.13. I'd like to
submit a miscdevice sample once 6.14 comes around, and having this
already in will make the miscdevice sample nicer.

Alice

