Return-Path: <linux-pci+bounces-39932-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6383BC25394
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 14:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F92E1A28728
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 13:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAA9346FCC;
	Fri, 31 Oct 2025 13:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/emK1o9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF8F2405E7
	for <linux-pci@vger.kernel.org>; Fri, 31 Oct 2025 13:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761916728; cv=none; b=qI/8xHG8r90W6qzTyo4T7vJ1pThp+UKDv/6kR6Xwl19LjuaZHQcXRTzK7pva+EqwYn6QXhOAGc0Zjbuffg5rdQirSIjvfFXB7QAnAKMLMsnJ8qWvod3iLwjoThGyt3Sb2v2z16AhjY/xZz+B6tNh6v+I/QkxYGUh3PWMXS8MZrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761916728; c=relaxed/simple;
	bh=hwPwg21PUNDY7bWS1a5ZPuPQ7556dJiTKUQ/Cmgyxw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AmQzefWFnXdGPEtSGawuFkTiWhOcE0bD68ZC72J3jEQLNBT15XPOUajc3SGdY2TSMHTDK6oByNM87UmBz0w6jvrOpMT6HQgmO2x4RGDkTT+Qjj2f5WUFahuId8khCpEWbWs+fUfNwmUtd2vSNIYLvn1lMQ07tMQ/LvUyhhIH2zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/emK1o9; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b6a42604093so115768a12.3
        for <linux-pci@vger.kernel.org>; Fri, 31 Oct 2025 06:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761916726; x=1762521526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hwPwg21PUNDY7bWS1a5ZPuPQ7556dJiTKUQ/Cmgyxw0=;
        b=Q/emK1o9WweUKP/TM0qnDGBni2rJZHQZAp0oWvw1UfE1vFfICbOMC7CNzNuj2OPwXf
         eDc7fXGb0fUGWFWhr+qY1PvacuFs8uAmaqVaFztMiJwKaCOO71Gew+NJKrocVJ42YwL0
         k8iAMw3VSMxt0qsULEAmRrjraycqOUHZX+k/7CjOad2SH+HH3p6rUfScc/Hsl+QALrBL
         dbcV5kFINAPQ0lk6Gz95M01d1NHyCbjZuWXvu8d6gRtjIjPqiuNXzOz+Xqw3jTKBpL+V
         pQjcPzQZl1haXGQ9SGNvC0+zUYy3jrJojqPuPZLm1RLQcCN6caBqcDwlE0RZb2RNw618
         X8NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761916726; x=1762521526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hwPwg21PUNDY7bWS1a5ZPuPQ7556dJiTKUQ/Cmgyxw0=;
        b=tDJvLREDLd1upB1qBVQ3BTTMunhO/A2aIW/ZHwSvivLE6WlJJHIHi0e9Q6ZluFfKwo
         VSMcRnb1t4g3SyRHzsro5pWbByj7rXMZArIAZtOixPgsszTc8pJ1D2ndYqwlfzZFdlqz
         oUz9A4ZOSJel8YF6hrAb8AR9oayIMemQ/2e+XdSJcY7yRXfahPic3IEjEZbF0cm2KnJl
         yD2julkd0DvARFpyZaepELRuba5qPPLpU8mDIx8LEerc6ZTImYufP/N2+XWOyV6M+9UF
         SNHUeRrxPoKEP5aUqBPz+BIsBzyhXVvJ2wpzN5wJ/3tg8ugzrMEdi9OxX2rEjosBjxu1
         ZiJw==
X-Forwarded-Encrypted: i=1; AJvYcCXSVJSHzU45vQV5DzXl0LRZohyGzNUAiLojmX5bOljQEV7Y0XyhWRJ/DRzQhHpT6AmCMg8EvzpdzRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzChoSbfzJd/5j5fBmMeiBsjqBAbMlD7Itk98C1MrVaxYfz5Taa
	scavZc+WPW/RkfqsjUtYlnwL2Yixq0Im/0J2rrAnnq5vymENbmta3+ZwyPEgyg5nfQm/YG7Z832
	OMF82IdnEJI9P+6fYGgL2MznyPgA8r4E=
X-Gm-Gg: ASbGncttLntuuk/QK0POu7WJtS7vp8Hu/hHhchwmqNfMPL3ZL05iYfUbnL3sC+MnR2G
	8UtiGuIY48x5yM43J+qsszfgGaDShlDnwEoNrIskSU57D4Hpjup1zSmwN3PaUnx32QdIC1IjnXy
	t2pxgS8nhYnc/60VUdKqXJEJVK3TUE3BdeUkeNwiW1vNWW0nGqdVZoBjdQArj7b4vLolh9xZ5Hw
	Aqt4LzJ3bZPSfDjKshhFORhMCBvCzt4roa+p5/pI3JOeFpBlO48gRVj8+zn8iA7fGLT+1THTbyO
	IkS7iQtD/kcBWSo17mIXXPjd3E/rfMG9uAi+HSwoS9llRvF1RPfAjEfSBR0nRj6ZVO9+e0DjASA
	On44iSFJuIyWcMA==
X-Google-Smtp-Source: AGHT+IEJ49gwJ5mRxtZtv0b41URKbZUBJLIt2VoQe30SlwO+FAYpwSB5aWCZX5jYTBZ0NgbiTYvlaN89VXh+FK/gXxA=
X-Received: by 2002:a17:902:f684:b0:294:ec58:1d23 with SMTP id
 d9443c01a7336-2951a3a3eecmr24614175ad.3.1761916725522; Fri, 31 Oct 2025
 06:18:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027200547.1038967-1-markus.probst@posteo.de>
 <DDVLMBC40199.2BVFYHDGQP4Q4@kernel.org> <cf50c6db2106a900f2b9b3e11e477617d8cbb04a.camel@posteo.de>
In-Reply-To: <cf50c6db2106a900f2b9b3e11e477617d8cbb04a.camel@posteo.de>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 31 Oct 2025 14:18:33 +0100
X-Gm-Features: AWmQ_bmiIa3swbTRNRoyyzvdTz1VncSekR2-DDUNMdwP2E3BLG71zRyd1NoCFP4
Message-ID: <CANiq72nhhji-cz2T2Cg9y5AwUwcc9q1Hd=-6J=6TafaxcHZHeA@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] rust: leds: add led classdev abstractions
To: Markus Probst <markus.probst@posteo.de>, Lee Jones <lee@kernel.org>, 
	Pavel Machek <pavel@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Dave Ertman <david.m.ertman@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, bjorn3_gh@protonmail.com, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 7:09=E2=80=AFPM Markus Probst <markus.probst@posteo=
.de> wrote:
>
> No there is no MAINTAINERS entry for it, therefore it will covered by
> the "RUST" entry in the file. I have added the led maintainers and the
> "linux-leds" mailing list to every patch sent regarding the led
> bindings and none of the maintainers have commented on it so far.

The global "RUST" entry is generally meant for core abstractions and
infrastructure. The best way forward is to get the C side maintainers
involved, since they are the experts on the subsystem.

Depending on what they want to do (e.g. they may want to maintain the
Rust side themselves, or they may be looking for a co-maintainer, or
they may not want Rust code for the time being, or they may prefer to
leave this to another entry, etc.), we can see what to do.

The first version was posted, I think, earlier this month (please
correct me if I am wrong), so let's give them one kernel cycle at
least to think about it.

Of course, it also depends on what you want to do. For instance, would
you be willing to maintain this code if the maintainers want to have a
"LED SUBSYSTEM [RUST]" subentry?

Thanks!

Cheers,
Miguel

