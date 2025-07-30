Return-Path: <linux-pci+bounces-33159-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC296B15B32
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 11:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A44E18A5D13
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 09:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237631DF738;
	Wed, 30 Jul 2025 09:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Js3erVtJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B5D224FA;
	Wed, 30 Jul 2025 09:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753866331; cv=none; b=cWjeqQuhqBEItW1lQlTuvFkclEDDBeN47UNW1YOPCYr1fvXQ1biL8cBMzxcQv4bzSa1ksnTwMqzF8iwDuI6M+g+smyM2UawetfzXULs9MsTFMN/pkVz+q5WjXsHp8HSoSmn67NPVLrA+nQM7YAeJnJUQook/6nxy0KNkC1SAWAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753866331; c=relaxed/simple;
	bh=/EsMy17JElruVccra2rJNhXuxYY654TvWWIqnzkBzaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QZeGHQdnwkNmmguGPW9HDx5GGFV0mF4zsVHZYYvZN36dePM++VWtmSWUISNlU8xyA3zeqy7pEGL9N/z8iry51WPRiw8nvjWVEkRoEL4dHVeyV2nv0vR5OWp2iP0EGz/0w3Dl42NeIFIlQDIq21T1HhgZ7wfarH7zjAN+byC0dYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Js3erVtJ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2400b3008e8so3704125ad.3;
        Wed, 30 Jul 2025 02:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753866329; x=1754471129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/EsMy17JElruVccra2rJNhXuxYY654TvWWIqnzkBzaM=;
        b=Js3erVtJzMWenl7RkMfEez/mJAlc710TMaO6Tp8FVMyaskKb+HQ8NUQIsbRQwjbZGu
         nVt/vWVBIQSA1LbCm3p+vfenj40mR+kXbnGwtEwMpNbcoS8w4RAitsJdD5MS8rVRYV17
         fyGsGZ0w8Xm03vyPF7oijm3Ru6JuPSY9QAuLf/+yNVhgXGKnGCec2zaIyTTpABePo/mb
         hnJEqQYFhA5W3CBRdEB+HSwYxZ3ua8MA4jgrZ/IOeJ5NzDqkTVvhWY0b4o52YbvhiRyL
         vB60o7o3xOT8LahsheDYFmg2ke7kWyja2ikWq7Zclfe0fs4lXvd4bov/BvlOSUE/Z+NI
         MONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753866329; x=1754471129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/EsMy17JElruVccra2rJNhXuxYY654TvWWIqnzkBzaM=;
        b=O/mF1Fjn6AZFFdHZGeEdPXmnYoadE/bEpNb9s5fFeVF/darVFkZLsiwX8pIPdIhNIW
         MW7kATxOZBWMJKlsmmzxhuDgn3jOoanIK34LWhm5aY6VapskSBad+djrLgQIws50Q4HZ
         WMjUoR4RdetJrgMbuiKaAfZcutVcUg1R6+zxOKHOhFSRwjntdW84xvfSMC3/DE//sRfI
         dQ2Z+qmyfTlk5yxglzwwWNUCnXjI6tNjBvvAQjgvvoK6QwK7kZ7LCPoWg08qicAk+rVp
         DJzlcYlhdI9XCpHbBs3cT3QeJgtQCqkj+1cExkVqimOBg+E9CBwz7fqqMbBOqJWXLjhj
         o3wA==
X-Forwarded-Encrypted: i=1; AJvYcCVNK1p4hRqOrf4gqUYLCQwjI31dCp+Tr5qiejH6xmIx70wvux7lceZVYPfm2UNEzxRIj4X9odiVIeIMtiQ=@vger.kernel.org, AJvYcCXy5z2IzB2Sl5ZvA46gqkQB1oacrfGhaVeBHvwdQGt6qZ/I6OWKZCeAdZ70BbD/ahur1NfWYncT211s@vger.kernel.org
X-Gm-Message-State: AOJu0YxUjbHNV8OY3KtZy6/f1ZnMKWjKy9Emu40Hk3XywKPYAPiOZQXr
	N1Ikk2JhbKzDgV+/+sFvFkcnf++GYo0FsBIwCxnHX2JQxE8+7fpi9z8N+UJIG5hX3p/95oCa556
	iqWBNxWRkgL4ZXjy8RaGA6Kqyoae8uyxTK+cm
X-Gm-Gg: ASbGnctMGWFeHptNS+G6gEMI8M5Y6pfwng2Pz3+aewNexm+XeWillL4celFyKulsOQO
	VQxPx4bQliqBc+mK5VDc7uJiN6AKN5UJczci+aDZNQxls6nsiCj77+D2VPSJ26L2iNRFxCM80RF
	PrdEdl+HPVna4EWsbs8R4qnw9hEpMMCLV3AULpHN2xqROFFIzlp1/72L092Q6GYLZJn3jvZpYYh
	Pikbgdx
X-Google-Smtp-Source: AGHT+IGySRAOV+djesXDaPR4TJ3aHBZNppgospN11oNLqL5TYtRHOtJyQQTzANoECnSbt+2wN+anMAN9utsfht0XdN0=
X-Received: by 2002:a17:902:d50d:b0:22e:62c3:8c5d with SMTP id
 d9443c01a7336-24096b0c531mr19943065ad.8.1753866328704; Wed, 30 Jul 2025
 02:05:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730013417.640593-1-apopple@nvidia.com>
In-Reply-To: <20250730013417.640593-1-apopple@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 30 Jul 2025 11:05:15 +0200
X-Gm-Features: Ac12FXwbXvIMu5qIoQekmsCAUtlTUoCMVOFLDM1LV1SLDgQ3ZVljXgRFPwoAfMA
Message-ID: <CANiq72mt3xaDCiGs30XG6VkEJrEj8KnHfjDFdhrj5qgW-dTgdw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] rust: Update PCI binding safety comments and add
 inline compiler hint
To: Alistair Popple <apopple@nvidia.com>
Cc: rust-for-linux@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	John Hubbard <jhubbard@nvidia.com>, Alexandre Courbot <acourbot@nvidia.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 3:34=E2=80=AFAM Alistair Popple <apopple@nvidia.com=
> wrote:
>
> Cc: linux-kernel@vger.kernel.org

I think this list of Ccs is automated, given even the LKML is
included, but the Cc: tag inside the commit message is not meant to be
used to mention every maintainer/reviewer, i.e. it is normally used
when you want to document that someone was contacted (i.e. for a
particular reason, not in general).

Otherwise, all commits would have very long lists of Ccs and the value
of the tag is diminished.

Cheers,
Miguel

