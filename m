Return-Path: <linux-pci+bounces-22095-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F680A408D5
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 14:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4099217FA55
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 13:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF91139CE3;
	Sat, 22 Feb 2025 13:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LlK1Y+Cj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440AF126C05;
	Sat, 22 Feb 2025 13:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740232482; cv=none; b=o0AhpM3Dtkyl9kTuRRE7f1c8qrgeg2S6NGWvg+DQJ/geJ9HGmExymV/5VpsvgY6133hpOEXhVDC+BfxJOcfiCLQ/9UX5b9nYTrRIdhozgUktC11b+763mPsUaXW05iLV3FoFhYE/UuQk2wuNWjpPLUR65szg68YffZY4IagCkAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740232482; c=relaxed/simple;
	bh=VweE6tS4QeR472TULvZT7bEsIw1ivQkAGZ7DzKeVTOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rVfpzUkH0SHfWbLl5pUdva6+J/umH30lOxd6d4NDLGXnGwrHQG90Rlv/Qxs5ADgJwr/rCxzUSyQnWmAsQtUFZeJw39xAWgLgOs27y/RfphWXVcL3OdUnuSMedpOaEmvF2Zu8duzZNE9Vv8yzIQnIHIrxA1iXxan5N8lnAtKHlt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LlK1Y+Cj; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-54529583c39so460755e87.1;
        Sat, 22 Feb 2025 05:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740232479; x=1740837279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VweE6tS4QeR472TULvZT7bEsIw1ivQkAGZ7DzKeVTOY=;
        b=LlK1Y+CjYrtoCMnfUUDfnnyBZzIFYQgy9lxUfUy0MkLgizv5dTc+9q+6aa6QIYBhfo
         KNjTlDRnHUgYQLyniDovQB7d7GIKq2m3UEfAOhWaq+VSgTkVWoPIQFhT6TX3+adznLcA
         54RU9KwTzsmNfQksbKOR88J+scksCU1RlExTDQUdRXsrwcAjFIb1JGcIECE3mS1sGGH/
         WGcnYobwdfMBQDzpWuvoyUX/B+IpWZdA5TxnVgkLGH45tfi4aQFpNfA/1tOhcnVuV7eq
         eAzNRzx8XjdzqvnwBSqv5ydTUbiZGPqwhV+Yn6gwPfuOjJcW/Y/qFKtvHZ7ZVWglJA7U
         bfPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740232479; x=1740837279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VweE6tS4QeR472TULvZT7bEsIw1ivQkAGZ7DzKeVTOY=;
        b=WthcKwKbb3mvgS+jWppeSF/h/mZocTcE0hWvBOhI9U+Ia+bMSctlL9rrl8hwkUduNn
         KD4GkLeezyh0DpytX2AdY3CCL/LuAgRHg1xiiKDYInGAh7qPUdouBYRBqOffkJXq+v8h
         fUs3dM9ibTViNzCpSCIblaprKCDgoUsGzkPqpJ/qu7OFODyjDpH7uuD+ffDP7Wpg2WnV
         MDZM5SZ4fE55OKi2K6//vlD7sAZTjx0AWcM25J/HDY4c3OaAxH7P/M4YJvqPmXqvBcqJ
         EPWvHC1HN5IcZyUfYLvBZgWdRGKwltDl7rK9OAIynkaNAVVwPbbTVug6WCH8RzmTfanL
         CH7g==
X-Forwarded-Encrypted: i=1; AJvYcCVDc2Zajo7YLn2YHLOd5I/X27YMJe00wdj5jUQ5kOC6uaDZ4geZnFUKrOSv/U5lPm3YvLAOndZaw/oD5q0=@vger.kernel.org, AJvYcCXU9co62OVWIdU1Bb4qrUJjsmc4wRB3LuOPXAfGyp3etXHLS/yV42DJ0tDtDULKCZH6RIyqMYF+/RPf@vger.kernel.org, AJvYcCXtUymFaxnhjpT8ESn+eBMFT0h+sUjSvWuIV9SXyo0qmE2RpIJNUwBahB3Q9URRNkBEhFjycGyku7uVF+MQ3Y4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaaJifSsCIzuC8a2VncPAj5ugsmpTYPS9qGXlghVP15cxV/RQl
	KMaGeNVLAMqbAuu/LirxUVmfq8gfrxc4wrZdJISA/vn5DgHnGCujLmrcptKTNKTQd7y3OL66jp3
	XB955XTZAZncw/yZffWcaAMqDsAk=
X-Gm-Gg: ASbGncsEAbmChc/KFN7vW7TsCt0TorVpq3YPW+J91xII0IgxTB6mY4/2XAjGW8jfX9M
	AfWm3HZVs1eFV/fkR/TN0nK4qRtqALm0+HTOUmUOZVaPilsrGlc1VsdxLsa/ocOwgWaSxf1TB+8
	hzMgTv/K8=
X-Google-Smtp-Source: AGHT+IHAbhfIomZjI7CPGUcwHAIlJKeobEzwTsXiVQ/Lp45cLpV8JVRBlaMa+HIJ9lvixKOZsueu2rYFHzgtS/uKrJ8=
X-Received: by 2002:a05:6512:110d:b0:545:60b:f387 with SMTP id
 2adb3069b0e04-54838edd25emr918688e87.3.1740232479166; Sat, 22 Feb 2025
 05:54:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217-io-generic-rename-v1-1-06d97a9e3179@kloenk.dev> <2025021817-chirping-fencing-d991@gregkh>
In-Reply-To: <2025021817-chirping-fencing-d991@gregkh>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 22 Feb 2025 14:54:25 +0100
X-Gm-Features: AWEUYZnYVLorTgwzThDBUoami7P8oPoQ8xqFPisrXxR0sWEuZ3sWkzPXy71DQM0
Message-ID: <CANiq72kTcceaCEv0ETdN_zninTwJKAoPDvzz0Eorb5udGgTkDg@mail.gmail.com>
Subject: Re: [PATCH] rust: io: rename `io::Io` accessors
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Fiona Behrens <me@kloenk.dev>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Bjorn Helgaas <bhelgaas@google.com>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 8:57=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> Want me to take this through my tree?

Sure, as you prefer! Happy either way. Thanks!

(The alias thing can be improved later)

Cheers,
Miguel

