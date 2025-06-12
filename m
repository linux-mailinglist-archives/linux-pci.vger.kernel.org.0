Return-Path: <linux-pci+bounces-29530-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C90CAAD6D83
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 12:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B0183B03B0
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 10:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802BC235044;
	Thu, 12 Jun 2025 10:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AoW26Lmh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0961E232369;
	Thu, 12 Jun 2025 10:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749723740; cv=none; b=BbeEsBCO6kS+OOnBKDdlVjDq58hU33a8Byk8r34bLqbk4U2fDq/YdwFuRUiG1azw5ug2sk8Pk7YvY0RBWuP0yvA5vN4VU6d2le24Wugj7tCdF6mKlkoXhi8yP6xhElSxpRtA7qaCxxwDyNlqiiYfXCv3mocPqQsKSc9oDEAxWmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749723740; c=relaxed/simple;
	bh=SO37R/h1del/1aQpao1BZENt0XTR2Cf547jTkk++7rY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KA3K1kSA1R8K5P9KQN2HEgREMFRDpL8UGNrtdk06pZA2heHO/e3xKxQIelthMNfeMsVofhNL2a5ClLsHN+Bkb8mLwA29eqRZAga+t5YxWDSigr3oLF1bkEDcjETVdiheo0v3IbBYQEht2nJtJSdV685ITbPxxZ8OV8PxO0IkZiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AoW26Lmh; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3138e64fc73so85788a91.2;
        Thu, 12 Jun 2025 03:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749723737; x=1750328537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SO37R/h1del/1aQpao1BZENt0XTR2Cf547jTkk++7rY=;
        b=AoW26LmhJeT0bI/QCmMy0K5zdYGfIVK0KHgO3TedC3Y1bgq3ZS3BVososn2srZRjr4
         1TS3ykdki0NrnwvgKbqUlyuhsbsPrCYwzSxMQ7l8/2c120Wd0AUzrt5M5kvXr5s+Lz+T
         YFRZuLnHUWRrGJloTnFGYsv1daPXEm2iQ8MEzL1GlQJMeteLiV75ZJiNv0gBw6lOkD0i
         49B97KBLQREArPlnhNZFpGVAU3tVghT0y2HVRbizQC2RhPw9NefXDnj0Yd/eSayPGckl
         H4i9K43r9ZwAATU2zp6WXqF0wbWSQmUloMl9Pt2JkQcx6a2GD1fvd/8Hs7yu//sp4YKv
         k2/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749723737; x=1750328537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SO37R/h1del/1aQpao1BZENt0XTR2Cf547jTkk++7rY=;
        b=Ng/w+QT2RI0jwqiQgrwl2LGTHt3OLOxFNP3gUTzMXhg29fqmBzB+vyKb664ElMEONX
         YxXqQ5i00fHB6qpfMX9dRjxMM0qOfhMWf/HnrG2I69pKBmc4wS0WaEKKvB4GvxY4pmOq
         5+DH0VWzoFD6A0/EPfOlZWUQgwlVmbtKRWCGRAVwolDrjdQfP9S9p503Y9/7xciBcn8k
         VJ11mlpxEP367vZyn4J/MpkdKTa7Qt1FWnjWXWwI/IDWnIrXeUNpMVQX4OnrKU5pV50A
         Tce2ffJEQrwY5MsmlsiryxQg1MejCEQkR3tUxK0v5Jar+UxcgY0syJDJky42K6HC0UsP
         goIA==
X-Forwarded-Encrypted: i=1; AJvYcCU+czE17UsLf/lPu3AxhLvJbsFeBwbLrgdRdM4v07UbeDrCdGh/DiOzfsGzDHheMlzGqs06ZZO/JPnc@vger.kernel.org, AJvYcCW010Nmt85OfNKTjSJygPldEtzt3nEz6NrNT8oY5reizCHm8Uesd1RPnVtL9heFMcbDOrrtQdnSGdh7kg==@vger.kernel.org, AJvYcCWxYuCNIl2uZ50FTAXDYFZOIaXNhtVbRHCq5/yt4Dqgl0Fe2ON3l+kPssVRyfA5Wr+EYMi0XrFJ4uA=@vger.kernel.org, AJvYcCXBnZZqDQq8tCoSQTkK+DqFfUrq3S6x6HQPGy2aNOXiAL8fJ1E+jlLYe6hv2PremUl/AqwO7LQtpq0l@vger.kernel.org, AJvYcCXRMmzlgd7tlwmZVbVfprcC39hL9umLlY1VREKlWNYYUbCBIPzkMI3xICQIrBPYF5fSFJrAVPeoEO+s5kb1@vger.kernel.org, AJvYcCXqKmKNEzclJHzUj7EBIai1xPbK4ogBQeYljaBODK7+l5BbXOYuZytxJlVYmf2Mfic2NmikZGjpFHH45PtBWLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBb7JZlBJF2p2AZ2D7tWbsa+UF2YoZ/o8I0h4t2faKplgQnVB0
	y9ByUXq9nEEGICUden4MdD8UvDmSPtTdsMcnTsOaBPATdmGUhGDKb39KmDinrHev+RfRrHJ0IWS
	yS3BulCPhDLj0nlijWUfPYKMAnvuoYWs=
X-Gm-Gg: ASbGncuMA8JVWmBYT8taEn+fgCjAi0AGO4eyLUet4PtiyCK7sCRG7iCNwVQBx6mCPVI
	T8fysoRtuRCem+SP04bF87XDDMc6UqjxTba1ZBEzJ1556vhiz+P+a80W4LqUE1X6DuQkY0sSPtV
	8zsATIymzMKkGJSazahzyJ+MGddkdkHjtZmfAH3L8S5f0=
X-Google-Smtp-Source: AGHT+IH94DNvTVzRRDj3ogVCtR6iefFy1RSOyjadVcC0pwgm1vWym97QPStxMRP0lyaW52odQ/fleX0SckRjUMwc7mI=
X-Received: by 2002:a17:90b:17cd:b0:312:639:a06d with SMTP id
 98e67ed59e1d1-313af136457mr3612530a91.5.1749723737296; Thu, 12 Jun 2025
 03:22:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ddd5ce0ac20c99a72a4f1e4322d3de3911056922.1749545815.git.viresh.kumar@linaro.org>
 <20250612014210.bcp2p6ww5ofvy6zh@vireshk-i7>
In-Reply-To: <20250612014210.bcp2p6ww5ofvy6zh@vireshk-i7>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 12 Jun 2025 12:22:05 +0200
X-Gm-Features: AX0GCFuqCHMJ_ULC48U5582v9ZYgwTQqDBONlu6akMmTosspZ2vQkFio_vWEcxA
Message-ID: <CANiq72=m+O7p==Fte4HA7kmt0DKaKmkeAQ-J1kVtyTKDKibgcA@mail.gmail.com>
Subject: Re: [PATCH V2] rust: Use consistent "# Examples" heading style in rustdoc
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
	linux-pci@vger.kernel.org, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 3:42=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> If you are okay, I can also take this via the PM tree along with my other=
 rust
> fixes for next rc.

Do you need it there? It is trivial, so it probably does not matter,
but mistakes are still possible (like it happened in v1). Since it
touches files from a few maintainers, it would be best to put it
across the "global" Rust tree (ideally with their Acked-by), and Cc
everyone (e.g. Tejun added now).

I also have a fixes PR to send, but I was not planning to take this as
a fix since it is not marked as such.

But I don't want to delay you. If you need the changes, then I would
suggest just applying the parts that modify your files, and we clean
up the rest later.

Thanks!

Cheers,
Miguel

