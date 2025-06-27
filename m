Return-Path: <linux-pci+bounces-30969-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63362AEC071
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 21:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEA55642985
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 19:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620722E1C7A;
	Fri, 27 Jun 2025 19:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cT6U09K/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AD82D5417;
	Fri, 27 Jun 2025 19:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751054028; cv=none; b=RRyqiP78g+gevrsgeainuKIIeNEfgqGn3xDWNcfgKW3ibRYS/H8gJA5ocIXZYjmqquUSvqO+G3i6zPMf+a58XQFb+h9z90u4xSQNIzI0p988IvcgUYY8xgjATxANWar/hcqLtgCT83/NtdHdFxjsgL6xhnNhNSHNR29o09gEjZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751054028; c=relaxed/simple;
	bh=JjUThF5ZQTfv/AEI/zs1Z+o5JLmzXbgbQ/Gdu69ejmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tv9oYzlrCEXrBG0fQIAW+3wXDKVAtN1QtxaG/JAqboPQN/zDufCu8r3eXiAzfevJnAhoFC6DnyaiJe6jbi4uTUPLLvodq8DCEt0piiJkEMjWwqjsYSjPUHFVJug6wC93lCADUTER4kUuleIHQMsLdvGqix4dWrHF8luFdFvwNYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cT6U09K/; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b26fabda6d9so448194a12.1;
        Fri, 27 Jun 2025 12:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751054025; x=1751658825; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xr0BO9QywiuHN32eONoiXxJrZpSme5V2xFuH56QCf0c=;
        b=cT6U09K/rz8rW9TkEXZbtQ+wM3FzwIbuG83RAlNa83sgBV1wZUj28TImbYUK28buaN
         E4wtHVHEo1lKzvkgLsylsazXtZl4UQHOi4B/DazG5jV76f0lOt+Lb3hEXeU6Vx0bnnaZ
         2gfdjW+c5NkBvkXabtlAASI07subyG0aeS2LIuFlfiFv9RUL9zLhmf2eMd1vkkF2Bl6g
         3e1tLMrT1Gunx2qhD26bbZ+mg1KeSuW9QBO4mPIzv3qTC/+fwphKthELOLX8Emnp+6JO
         DmOcQqFhD7bliueq82jUogon5fHDlXGFMN6pKhrlyCWN+G2qesHrehTqESc7pIorTwbC
         6YmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751054025; x=1751658825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xr0BO9QywiuHN32eONoiXxJrZpSme5V2xFuH56QCf0c=;
        b=meZt28/VVEpI8pZml24VhfYON6DiW7CgRQYMvIwsMIE0E3EZlNetngll092MqP6C/g
         mrN5wrD8+ZD0IbsT9Fj9kzznZlXxWN/qSlwymTd1jPthT7x4huaV5Y2y7qknCA+l77+O
         QnbE+cs6vbWlCZhw4Nm9zNjn53YWcy7Qe4Shj9YuIj1wFiNFaKJ23NwPOgbSvFKpQJ4P
         yNx3MB0E1PZIneNKdZpt3PJXh9srZbFI9nU762q6RwZrDUfzxaDyRU17fQv6UHwGLhSL
         de9wkoyW1M1dG0nfYsx63VmjYnzoSuV8CiqHZ26xz/LjAWSg1WHb73MNixnztoGAl45P
         7KVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUISvlCrXm6yHaMXyiDbD5TGpCgT1fZsoc8vRpo4eluwT4/YH30R4XIpdzbekcUFdjNW0aDn5r8LLokLIY=@vger.kernel.org, AJvYcCUUKmwafc2QisWYNVQi9JoPdGte/uK3rnWVkbx2SbbsuxwabZVrUTksxMbJQgQltVGCy6+0e8N921ReeaysO/E=@vger.kernel.org, AJvYcCUhG6Rc4zSH9vm8NxE+Q0FDgx9y6y2F0oTDWNybQ4cSmWigwFNpy1QCm2Yk2yKr5aAH5CN2BrpkfXBQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yyojzj1dxkCzZj8Vs5czi4a+MBlvsstYaYtpBxp+kw9f3nIF9Zj
	N0o9aTMHNWknnxwZ82tNIEPel5QbC8Ubl0aeyFdu7i9uMYnIg1aayG1srqWKfZaY5mpN502Q9q7
	vM71WGjIUHMkJNpOXze9fefiWAlEuCuk=
X-Gm-Gg: ASbGnctzuRJHFk4y4Oqs0U/ZgphJLzzd+D92WN9CDV/JHb2RlJ9B84X/ZD0fbUAfyMJ
	JlDPVBz2tS5cjrJAwfiH990iCv/1VsTzJCr76UH4f1D5l3EqecMdckueKzH9g4TgC3Yb/Om3A/I
	K6sW+lImt+asaG3/M1UDk5DNWXvOZ6+vou2agr4Og7qvo=
X-Google-Smtp-Source: AGHT+IFgjOJpBuZMAn1BpIJk2Cbq8kKjuri14W4yCTDgIsm5/OIedAZzpCwPeCqq1xc5N7cQ/0fOZqqMcRPoQbaFOE0=
X-Received: by 2002:a17:90b:278a:b0:311:9c9a:58e8 with SMTP id
 98e67ed59e1d1-318edfc8a36mr105426a91.7.1751054024995; Fri, 27 Jun 2025
 12:53:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626200054.243480-1-dakr@kernel.org> <20250626200054.243480-5-dakr@kernel.org>
In-Reply-To: <20250626200054.243480-5-dakr@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 27 Jun 2025 21:53:31 +0200
X-Gm-Features: Ac12FXwai0sVwr62cXVR0JjJ9DIxLq1qMe3Vk4wyEnweblVHFcv_GlUWuR3Rs_Q
Message-ID: <CANiq72=JdNo7VON=PBM9iFWnXF-rWh_WTmDyqWb7uqh6q_JfMw@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] rust: types: ForeignOwnable: Add type Target
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	aliceryhl@google.com, tmgross@umich.edu, david.m.ertman@intel.com, 
	ira.weiny@intel.com, leon@kernel.org, kwilczynski@kernel.org, 
	bhelgaas@google.com, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 10:01=E2=80=AFPM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>
> ForeignOwnable::Target defines the payload data of a ForeignOwnable. For
> Arc<T> for instance, ForeignOwnable::Target would just be T.
>
> This is useful for cases where a trait bound is required on the target
> type of the ForeignOwnable. For instance:
>
>         fn example<P>(data: P)
>            where
>               P: ForeignOwnable,
>               P::Target: MyTrait,
>         {}
>
> Suggested-by: Benno Lossin <lossin@kernel.org>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel

