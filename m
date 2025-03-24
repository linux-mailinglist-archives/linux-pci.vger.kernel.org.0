Return-Path: <linux-pci+bounces-24599-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9681A6E718
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 00:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB66C3A8AC1
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 23:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4AE14EC46;
	Mon, 24 Mar 2025 23:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHitfKLM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C774A0C;
	Mon, 24 Mar 2025 23:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742857328; cv=none; b=c/Q+GyJ9N+M5spWMbU7w/tWrh1lfk2zoi7VxWwsXdL43aHMSGJNhOVT3OpC+xaVENLVgEgI5mCu+hxfUqlFeiIEdG3jYRSHXw579j4DLJqA3iJAh+f0z36vWfz9rWDtpoTQbbbc8iZqd0+D9eR72F0DOIDekFkbz2z6v8rQIt08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742857328; c=relaxed/simple;
	bh=Sm/shJ53dQVUaek3eh5J6vClMZ+mhRTsX2hjr08eZAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ccOvhTolSGLk5I5v3Id0g2A1GrfGNtkigck0mauU5cjETwp+phsKr4ofPf6mr8I6um6wrTuZv5KNjrn8EXWM6aQsBaYKEqVkDW3WrVWQ6kNFR/un0GonjjoCvksMz5aYG5C7K2b15JCXOwZgB6h6s8zVJmT/BHtpMDkGloHjyOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nHitfKLM; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-301b4f97cc1so1529025a91.2;
        Mon, 24 Mar 2025 16:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742857326; x=1743462126; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sm/shJ53dQVUaek3eh5J6vClMZ+mhRTsX2hjr08eZAo=;
        b=nHitfKLMBT/ce7wg4xDeBwxjmfITI4fs1wSdi6WQhjbM2smaL7MXilBpPRIWWURaon
         5xfm2CnjbDC2U/KJVktyfkgH6eb9f/Fpr1V0OajzbqlMmmKR/JEv0t/hHl+GkmETLLCj
         Mnlbs1+39eyXIkYYdgEbA+WZLR3GTP+ShFXxZGXnZTzdv5b5nBLUZyRrckL6TlXS64qY
         O4p3Iq/US7IzYbCgmioMQOsjqZD1aPNTm3ZLoRVP9oBhVL6i+rel4SSGdX9m2FoS132Q
         0fEQ2sxx6Mg5dj8y8UsA+Awdn1YruzLIHfMJkdwSHa77VKmmYufgWY0XFvCDxndQva+Y
         CN5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742857326; x=1743462126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sm/shJ53dQVUaek3eh5J6vClMZ+mhRTsX2hjr08eZAo=;
        b=ICBLHAzuoQ8iLFj1hDfb9e00VTImkAMnGyipBkBtV4CVx38Pv0OBdQ1ZRdkOnqXfgf
         jJhpMj3iDhu3Bc6gFpeUZCEbqzB7yWrZWyoW8pSju0qVrMNXJdG5toZHQvpJDyySSaT9
         kD8FxD6LUXZ0RxCYQTzI9sZsakaM3Q/6y+cUx/WuSvS0qHIlovVjTXGl19iReH9APVSg
         9kxgjA8+OnfrhnT3bgiT5wiG1Cm9W1A2Hoi/vBx9h7fpk54BXIOWdGRYzqB99GlVl0fb
         M8krYD78D0PO9BKmzeHUMSpV3X5kLicjVfWI4hvdOCz8BkDAySVTrdL1z05C5MP9LRoJ
         fi3g==
X-Forwarded-Encrypted: i=1; AJvYcCUm5uTDtYG+eYNmrXPThhkkxeQ5NND7dgRsPgpqaCnpJrtSPoS6DnEI5Y+nzG+yykv5zZcYFrC1CJL0VkhsdGM=@vger.kernel.org, AJvYcCWbvFoFNXe/gJDdqacmM5luCtwlebjRIKk6cQtf1PZeIKPNPXXyMhWgbicRcWGklvhMFmkBhvj/sZhrSCc=@vger.kernel.org, AJvYcCXhAhzgxcqaHCGFpepilSefRyOJ/l/zc009VWpqaKL7wBVP4PxdAoO/pzff//XydusI0TRugNSjxlPA@vger.kernel.org
X-Gm-Message-State: AOJu0YyOjpr5Tz2pjdq4oP5CPgvc16GOB3VIWs3QAb77AU/nJZQuRUNc
	C5+bx23E5Y90JENg2l8BUC0KNVCsr6ifYFyA/VYJ8BpjvUJB7I+tqGIGAyOZ/pJkLMnNaFJOCKu
	pUcb15gk82mB2vBjgls1fmU1Cj2U=
X-Gm-Gg: ASbGnctSimxiS0SmrYblTj1UkbWap/biZYdcm8GGNCq8FCfSH6yM0DPSE+OpMuytnlB
	bleoq5ndY65vGXH8R6y2pq7V3W2kECi9+QC/1v/KjfY6UJCo7599+8teSPBHvI38iC1lPUQ/5sx
	BwRJAeCucJLFdVqQQUpp0/7tqJfg==
X-Google-Smtp-Source: AGHT+IF0N3IVoZm41r+EPPfeHaAlJgTDOk4ghAT1O/mKxGfrCPY/HsBSeXWetofbrS+dczLITSUjUfjwMphj7YT+nAY=
X-Received: by 2002:a17:90b:33d2:b0:2fe:91d0:f781 with SMTP id
 98e67ed59e1d1-3030fe534b9mr8779881a91.2.1742857326284; Mon, 24 Mar 2025
 16:02:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324210359.1199574-1-ojeda@kernel.org> <20250324210359.1199574-8-ojeda@kernel.org>
 <D8OV6JF1S63H.NG5CXUZDQQP6@proton.me>
In-Reply-To: <D8OV6JF1S63H.NG5CXUZDQQP6@proton.me>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 25 Mar 2025 00:01:54 +0100
X-Gm-Features: AQ5f1Jp-b9ijstGk-lJRPks97YVdRTn8tjg1pmMJXHRdMAlOigQ_u0TkE93n4J0
Message-ID: <CANiq72kMGLYP9RzraKy8wSSYJ2e3PmBLyoSPjUbkhTT308Yr5w@mail.gmail.com>
Subject: Re: [PATCH 07/10] rust: pci: fix docs related to missing Markdown
 code spans
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	Bjorn Helgaas <bhelgaas@google.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 11:54=E2=80=AFPM Benno Lossin <benno.lossin@proton.=
me> wrote:
>
> Wouldn't "([`struct pci_device_id`])" make more sense?

Yeah, definitely, it should have the `struct` to be consistent with
our usual style.

Cheers,
Miguel

