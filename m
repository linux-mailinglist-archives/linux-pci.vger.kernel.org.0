Return-Path: <linux-pci+bounces-29285-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DA9AD3083
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 10:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87C1616CCE4
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 08:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E382725EF86;
	Tue, 10 Jun 2025 08:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WM5yE3KD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCA922157B;
	Tue, 10 Jun 2025 08:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749544501; cv=none; b=C9PA6tex5tnTsk0YMf+L+wiFQSwzWRIsdV8JK/UtJCElsHjUpA16LTBsW1PCLwnzo4vHoZX7jx3b9DvvYNTT8uvldfGfFXVCZpnydbWTDs36qfmriuiVw4/R+3HXQS8YeL90I6Dy4UO46JCzIUlMqKk/UYU17KRplZ/w8hD5ti4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749544501; c=relaxed/simple;
	bh=AKMt5bOqhnoUm7/yUiDXZGax3MVDPIxJL5bYGkHzERI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=irPZuhaq1RxOVZRNo4vUEh/x7LOkBjqkyjviVdoFQ4/bVDFh+TmpYC1Y0Ke8GB9jevyX90wFY2Sj3cvMnrLNnKW4IlfV1J4immTaJP/xwRuefSHEgkCoLrmMSvn1BpK7mUNeURwHePkaRRpjgiQyjAMG0LJO3BEcnWWl52rwywc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WM5yE3KD; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3138e64fc73so188094a91.2;
        Tue, 10 Jun 2025 01:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749544500; x=1750149300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AKMt5bOqhnoUm7/yUiDXZGax3MVDPIxJL5bYGkHzERI=;
        b=WM5yE3KDuMTi0aRvwuFycTaclSzCED0mbjoPQsD22AgrNpMSBd5kd6b0TwxpbS6AaA
         x6S3LU3NCB4lY0eNsU+dKMFkBZIRgTOCS0RDmOkTlGT3ReRh/BxwZ62o5VS8arc+Tevo
         0d+upa62AD3RaVRM2JW4ZEfFHfAEFj6A9tJHYnhAu0T0h2M1mZe+ptKXhGHQWDJrfm9D
         dpNFuxEyyiDyn4xw60m4Tj50Kgy7z9tj/gsxQi+J0b1Lwyw/p+WZcD7CgOB7od9L6771
         jix6+pJVAAYT8vWeJX5/6OCDVR2lED2HcogWm4+TX0rVOnhwTleyfflDLoDag372O72E
         WXzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749544500; x=1750149300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AKMt5bOqhnoUm7/yUiDXZGax3MVDPIxJL5bYGkHzERI=;
        b=pnx08ExgWNS2Vnph4jZQOYSfG6AHQEKpblM8hOorNxVno5EcegC8qiJiOesv8hMeH7
         yFiZ8dhg2KMv5CGu02ueIW9Ta5jwr3cPh399KY5nJ8VD30M4pWqmNwJFZxujvjuZT5Q/
         5/vztv5dcQr2lDrCw/VwDHfznt7ISW8mtUTzvBTCXpBZKb60iWobRp3f4Q+fHCUMtXeD
         pNxtoYhVr4ljyPkFwq+WoJHcfRhjTyRIyDFX1m4lRGeZrmasZWYriDCk21XILyDxmS14
         78tS+O/qTt3AqfSDHjwW8IouUzRr1pUSBV/+6+O3oClFK9NCYmse00CZXqNIq5dWaZ56
         lxpA==
X-Forwarded-Encrypted: i=1; AJvYcCVih8oeqD02KbKo1LUCC5DVozv59S6gZtLSjrvlPXHOklU7EqMN24UR5W17g+QoiP71tKol1Hm3IFo9jA==@vger.kernel.org, AJvYcCWE2Nt9C6DkikSZKJtVKeE4bHXySHhaaQOXPBBz7pKwHR9szMyNh6hD5K1LHWk8XHiZJzzTxKUSr6XAHuL8PMQ=@vger.kernel.org, AJvYcCWPs7/w3WndJelDmKiSTdiv89huZ9a491HQZLSXsK6myYm+MTU8p2W6TN0KVkQOgKwFiNBS1vw540Qm8KLl@vger.kernel.org, AJvYcCWyaJe4P59BGBX2F4wM1kY1rTQVI0zLcXIUASuSL1keWLdvJyVMEL2gpwKhbcjkM6hIu3hUBsXv7p8=@vger.kernel.org, AJvYcCXCUYE15Ib2OQ54vdber+dtRehdi9wTV+CdH1yMbz+v4pYOmdlpsgltu+CIccP2JrvkmNXA4mPXI1JG@vger.kernel.org, AJvYcCXxwU9a5nKb+VrPSuUzO15IFgQcRmQFrS4AcV8zv32AqwWuECxflHvh5c/3X3Yv4AjEjbZ3UrYecHR9@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu5rmambIqMuCVa6Ho/VkJONQZz7A+R0Fr0OlHvCy6D2vCR3PB
	zHFTf3X/Zw38Okkgs9D9auSPXtDtPxFAMvo6SFItbhT5pxXy/JznTnFZwqe2CeW7w9eCK00vCQw
	1L7QvSjb0aoRSzLsT6gx0FKGm5/JAn3I=
X-Gm-Gg: ASbGncuvKEvveuClKrwIwnoa3kTdhD+iHDQx/u1RLKr72uSAlLJNM2TTap6GnVG+GWy
	I298fbW/cOsYVPbByW4cZglko8xkJJUiWzOhZ+Kf2aozjYzwbXqI/7mPD40JHFOfuMXz/DoZKRL
	JEeYBZBXvRBK0TFEdUeJ3wye1Az01FgmEEP9CAtnJBjH4=
X-Google-Smtp-Source: AGHT+IG9o8l5nJqI45FrwDH7Khv7XoEw96OrQqnf6E/rj5r8N91+BEKWod7OyjPnRZjArPU77UU87Z94T1+rv+17SlU=
X-Received: by 2002:a17:90a:d006:b0:311:e9a6:332e with SMTP id
 98e67ed59e1d1-3134ded1839mr9033972a91.0.1749544499647; Tue, 10 Jun 2025
 01:34:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <70994d1b172b998aa83c9a87b81858806ddfa1bb.1749530212.git.viresh.kumar@linaro.org>
In-Reply-To: <70994d1b172b998aa83c9a87b81858806ddfa1bb.1749530212.git.viresh.kumar@linaro.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 10 Jun 2025 10:34:47 +0200
X-Gm-Features: AX0GCFuW4nKJxDOyQjzaKLJqfQBe7ZqYmgxa6VoP-kHbDElCPzAeYxEw-DuKrag
Message-ID: <CANiq72mhyBOjzmvmUDfgFBoRqO_aaS-CL-ct3vmJ56HoJAsV4A@mail.gmail.com>
Subject: Re: [PATCH] rust: Use consistent "# Examples" heading style in rustdoc
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Breno Leitao <leitao@debian.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Yury Norov <yury.norov@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Russ Weight <russ.weight@linux.dev>, Nishanth Menon <nm@ti.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Vincent Guittot <vincent.guittot@linaro.org>, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 6:38=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> Some modules previously used `## Examples` or `# Example`, which deviates
> from the preferred `# Examples` style.

Note that `##` is not necessarily wrong, it depends on the intended
header level. Top-level headers use `#`, second level is `##`, and so
on.

(In particular, it shouldn't be used as a hack to get smaller font
size in the rendered form).

So, for instance, in the `workqueue.rs` one in this patch, the example
is likely intended to be a subsection of the "safe API" section, not
an example of everything, so I don't think that one should change.

Thanks!

Cheers,
Miguel

