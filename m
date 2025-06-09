Return-Path: <linux-pci+bounces-29255-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1542CAD259D
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 20:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD09616EF6B
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 18:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E919421B9F0;
	Mon,  9 Jun 2025 18:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fsYlizaZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A1E18DB1E;
	Mon,  9 Jun 2025 18:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749493849; cv=none; b=BF27SNzEZnIfXJGXrxbCU7Fhey/G1hGnxiNp4sjpG6ZUd70gSneT4VggxXRsi9FP+eIy5Am5nA8+XUnXImr+QtavS6zjXKaDwpmPQDhMB5BGE+wnEZu6iGwCHm+gFcMk/vbhQo3uxV/VJtwsNaHPxnMZBHZw7QD8525jiFeU9dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749493849; c=relaxed/simple;
	bh=kSqp7xdGiH9obmGvICN2dilw+ZNLNFHGLUyAcwrnVF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PuOlL4V7q5kswNYJgvJvFR3qiM6f39ZMLuvMnsZna50RxeYKXyezfyx3IWqRY3bQBIaH0qDVfjkHlpx7RWrRHwztcEpBtZ/c7LpZCnEInC/3NsqDkFVcc4CiQ3DyVuORmaWx4LFFRL/IpF704HhoAau8XIiQWtZPLSt+F+Vi5KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fsYlizaZ; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-313336f8438so805215a91.0;
        Mon, 09 Jun 2025 11:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749493848; x=1750098648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kSqp7xdGiH9obmGvICN2dilw+ZNLNFHGLUyAcwrnVF0=;
        b=fsYlizaZDKrzAvLdj4HlwGTbr6wCCOimehzPDdZjs4Sks4tErI4Gh6y2cdmqu6g0Ya
         4l2JKlwczlRh7D5Vkq04mpIi3jTb3IwcHR5nJTsmqTsTHyZD02fq6kCNwiQ5jsnWwuII
         J15rprIGoVCu4EakUzFAZWjxEp1LGmHL0d9CJ/BQtXdMG0gcjNc0Oaq6qjtfaJ1/wrx2
         Mig+Qand+jZPkM2vZW/dTrKEC3NYA7G9wTZWOetC1EXc8EnXwTSIiGeGGn7RIhuawghO
         esdisoCmsD7VM/OHcTUmE3eYwF7SeWFfO4pKiOs/kt3ZghUYQWqqIgk3MpKhLAOvkbO1
         lMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749493848; x=1750098648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kSqp7xdGiH9obmGvICN2dilw+ZNLNFHGLUyAcwrnVF0=;
        b=PFgcIUQJx//xf+dKhDNdBgFmbPhaJ5P+Tl6o9omw14I7azz7du22wtk5XIeOhX8xw7
         l3eZAe5Zz66lcuf8QxhTxo3ErYO/Flf6VdLCpO9P91nfJa6BYsVPkR8gvAYxDvBlQelc
         tDBNo+VUNdZQBQLwZXvxqKXvftLWXI8DkbNbCLgpGBZxVkL9mtUNcFCTu+fMlQK2lVCJ
         mTnnFQMUy7WzzoLH/PP2nS1KweE2vho984FYG8iWx9jQIwfHNUiLH9TdZG1Q9qj5uABT
         ghjjfutB8mNEoILft45HxjSOGnqpuaDlz7ypMotN0sM1JJ95CtXBG8qihRqhJwGJudyp
         LraQ==
X-Forwarded-Encrypted: i=1; AJvYcCUt+TnoJH24yjDhNr3o6wrmpPHwC1idmKLSabnlRmHjL0f0+ASC1slHRKbq02LN5epNXNOjacxV4LPb@vger.kernel.org, AJvYcCV38lOykGhgL7Tq4+/1HJ+BcDMvl937HAXlkQwsDePe3b20nqE4jJFqeix3Zi/th41S71SXjBh+ALWnqik=@vger.kernel.org, AJvYcCWjEtwBU1wgTAIM+hyA7NThRhwpms8KHkIQeC/w/CrXGHNF1Z0RNYw/clZooxLX7XkcCh9UpIkS/tqQuQY6kqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/VTcfbAV4N0JFAdDAXyt2HAosCqfWDgR0OZObsfuaKZmglUH4
	0vvCPP/aX/8wzisMQno7FbbaZ9G9nxXr+Wq75oDFoQcL5uzB/AzqUtE4rd0PtC8GkzL3VwWEsqL
	Oo4YkptryTfEXFeD0jqfCRSCEPw8PUThpbUsesAQ=
X-Gm-Gg: ASbGncvHP44f7DrX7p92u0D7l8cRV51u6fri2nV0DVothl5CzA2WhZJRqWUk2Qiaze/
	C2nI3kuvu2R/ZRglcgHK7uJmqb6MiwwWzJjRYlA7EhdbnQJTADHICb6BzfjQnj01GjMQChdcsMM
	sl0IJrCDyAspJLLXY43OuGxYNreWxpdoSkI34U0cKyKF4=
X-Google-Smtp-Source: AGHT+IG8O6dJD6YenGjKBAaB7Xp6ElZJ/t3q7SEEUy4RXr1SdRmbG0mytNXzQLPWJwZViCVdjJo9ZmcDn7+rjM8guew=
X-Received: by 2002:a17:90b:268e:b0:311:e8cc:4250 with SMTP id
 98e67ed59e1d1-3134e3e4268mr6383005a91.3.1749493847851; Mon, 09 Jun 2025
 11:30:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250608-topics-tyr-request_irq-v4-0-81cb81fb8073@collabora.com>
 <20250608-topics-tyr-request_irq-v4-4-81cb81fb8073@collabora.com>
 <aEbTOhdfmYmhPiiS@pollux> <5B3865E5-E343-4B5D-9BF7-7B9086AA9857@collabora.com>
 <aEckTQ2F-s1YfUdu@pollux.localdomain>
In-Reply-To: <aEckTQ2F-s1YfUdu@pollux.localdomain>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 9 Jun 2025 20:30:35 +0200
X-Gm-Features: AX0GCFskVq8r2u558pBKMmbRLwweW4kkEdVpW6cWfF4ZluivSv1U_fzfgaAvmts
Message-ID: <CANiq72keAJxDQHHa5gAoFyV1rXpdf_r_vY1R5bFyRC4ph3BRUA@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] rust: irq: add support for threaded IRQs and handlers
To: Danilo Krummrich <dakr@kernel.org>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Benno Lossin <lossin@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 8:13=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> w=
rote:
>
> On Mon, Jun 09, 2025 at 01:24:40PM -0300, Daniel Almeida wrote:
> >
> > This iteration converted register() from pub to pub(crate). The idea wa=
s to
> > force drivers to use the accessors. I assumed this was enough to make t=
he API
> > safe, as the few users in the kernel crate (i.e.: so far platform and p=
ci)
> > could be manually checked for correctness.
> >
> > To summarize my point, there is still the possibility of misusing this =
from the
> > kernel crate itself, but that is no longer possible from a driver's
> > perspective.
>
> Correct, you made Registration::new() crate private, such that drivers ca=
n't
> access it anymore. But that doesn't make the function safe by itself. It'=
s still
> unsafe to be used from platform::Device and pci::Device.

Yeah.

Even if a function is fully private (i.e. not even `pub(crate)`), then
it should still be marked as unsafe if it is so.

Cheers,
Miguel

