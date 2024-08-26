Return-Path: <linux-pci+bounces-12209-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD49295F797
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2024 19:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83E231F22F27
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2024 17:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522B1198A27;
	Mon, 26 Aug 2024 17:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJ+oJ34T"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0BA191473;
	Mon, 26 Aug 2024 17:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724692381; cv=none; b=ErBHm4UA0I/e2PV3WZmY2RNmmHiSpAQEzHrQoXrHvWboTR1uQY3N0L50Cn+hXZWLFCW5ugcIt5SA8OhrOeUNO4P4Os1SZWmDMe5H7K8LSPdfgyiCJWkiXsIi6VcGND/u63ZK2sPIj99lgB77uNxt2OsAgErfue/fqb+y/K7Kaj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724692381; c=relaxed/simple;
	bh=C5FXLuFC4tgnhX12okZbEegr8EajQMblPAiafgd65pE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lvVW3EJh9AFVenujsjMaLT0iWubRsSPTACEQaWTKrNXaxlDqvIDol2Fgj+anLUb559lK18PQKXIw/D/lBCeD4bt57+Ix6JCAbNse7liH15B/wihdzwqsDxZcDPmNuhwMXLwkjDJX7Y8eNliKgjgtF9UDoHFO5tS0QruGerUMceY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJ+oJ34T; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5a10835487fso6801640a12.1;
        Mon, 26 Aug 2024 10:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724692378; x=1725297178; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C5FXLuFC4tgnhX12okZbEegr8EajQMblPAiafgd65pE=;
        b=VJ+oJ34T84+Qg+dfbrtnErfLqSka99a+8XwJwBrbYanOEjQdfuyScMY0w53zs7yxva
         AAZDJWWWGInbG8Hx6Beu3s3jbX3cj6utxCCf25k/WP5ET8Wx/J56O7bWb2qokaUfjWm8
         PUkAJ+5+6nxD/7Hdkspum+BGpDi/FzTLbhglgMS6BptajY625TEt9+VtIs7GOOa2+3Gr
         TmNf7AD/7xhONf8L2vOTyYzDPr3smmsF68Jx1FgiGqsaxqemph1JbMPmVXx+vDThe18P
         njEQ1L+YHck8hfYE5ksQ6Bqz7UleSOpB+WVPefvMGhdAfWmte6HbPEqVvuHUDcEkK6W0
         AgWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724692378; x=1725297178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C5FXLuFC4tgnhX12okZbEegr8EajQMblPAiafgd65pE=;
        b=ZGMXdNavQq0Nt3wZ5WUU5zGvbVe6G6mcrfCud/vzx8Rs5S/40fDwB7nf/WW0g55Euy
         UOcelhhGKxOKqzSGfL1Qx4HOIM7GSwyS17Bz5H1tfQ4oJYZfuPUJ+8GEaVocWoC2VZ7R
         3/SZZNkyMMXyvL4Du8pUqIPH1D2nOoVgR/TnUBMEpEXMyIQVrH+4gIxeZClGNycbCcQs
         BsoW1f+OFe8jo/sxR7vlt0p5mRcqtqJcwJga4jyrtt9BKCSpW7Puf/DQtya2Udc4oAjg
         17gh4Ythf4GjjhS+qFeB31xoYNms0eJ149Tg8qsLPGhH+MKTuL+diGAxf58bgGK7cQ0O
         acMg==
X-Forwarded-Encrypted: i=1; AJvYcCU4kj4dQ7LSxWe8XKZIQ2yxZ4jmhtDAS82Wy2UUHE2lPg57p2+zGUHpnjSV9IrUP2lCwKfKywRpcdjKQw==@vger.kernel.org, AJvYcCUg7DpW+t8G2XLv6ReC9BymcP93GhDBoLNFb2lBDJgKTs6mLb7VDFKe/3pshsthA2vsZwMu9HBz@vger.kernel.org, AJvYcCUgSjY///4dtFb/afg6s+s1Pza7K/0k7Wu5KpcBjzPCu4IzA7McSQXvp3lmWM7zOez66y/vWS9Tr9xFew==@vger.kernel.org, AJvYcCV1QYQpbw89IEcIYDqMNn+Vcy3XVT7y4tEU9K8V/pU+xivXZ5A3U+Gk4xNi1TkT1x+TSMXELDtwkxYY@vger.kernel.org, AJvYcCWTLKyT4jmGyLUkF3wZswDgQY4donSLj2+ihU7qW6nud6avnqio1nJI61rF+s28BY72DFWIAQPlmyoWejG4@vger.kernel.org, AJvYcCX77FdcU73NEJQwPbqpY7XqE7HVu9pUTV8eoYfVGJgGKrFFY6v/Txw1k6/q3vYrhuuOb/dh3EcoTXTS6w==@vger.kernel.org, AJvYcCXR1QACemjxcqAtD1HfD74ZndayA3/lvIjbqd+5tQhn+k0g3MvxAWQfgLkHo8ggn2CPjm/1ZdBOPhIT@vger.kernel.org
X-Gm-Message-State: AOJu0YyevUVfgVlUgORDQ+RQ17iFetpj8mTWT57EX1ayQKuTSN6rUT7c
	IejTJpfiv7SYSqv7TfEgRPkPSnhjhYw5z3F3F4d6c595O0pjFRJTFxiIAkr3Cqv5oDsfzogHzif
	jYiJq/v5DwDjFct1u3JePg86eJbY=
X-Google-Smtp-Source: AGHT+IHOnow3s0g1qCPDF0qgfwkSpamrc3MZdI/hWzuSVu2jgy51rNUKPxKvH0/02EJM/ysKZeVBGzzN4FAWZd6sxPU=
X-Received: by 2002:a17:906:c105:b0:a86:9644:2a60 with SMTP id
 a640c23a62f3a-a86a5162f4fmr872581066b.6.1724692377440; Mon, 26 Aug 2024
 10:12:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822134744.44919-1-pstanner@redhat.com> <20240822134744.44919-6-pstanner@redhat.com>
 <ZsdO2q8uD829hP-X@smile.fi.intel.com> <ad6af1c4194873e803df65dc4d595f8e4b26cb33.camel@redhat.com>
 <CAHp75VfKS_PWer2hEH8x0qgBUEPx05p8BA=c0UirAWjg0SaLeA@mail.gmail.com> <f2d6345a8a684f62035108d74938ec0b2e162019.camel@redhat.com>
In-Reply-To: <f2d6345a8a684f62035108d74938ec0b2e162019.camel@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 26 Aug 2024 20:12:20 +0300
Message-ID: <CAHp75VcgWdCOs0b51pqReLAMArno7FekYxiJmNnBTcdgGAyJMw@mail.gmail.com>
Subject: Re: [PATCH v3 5/9] ethernet: cavium: Replace deprecated PCI functions
To: Philipp Stanner <pstanner@redhat.com>
Cc: Andy Shevchenko <andy@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>, 
	Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>, 
	Xu Yilun <yilun.xu@intel.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Alvaro Karsz <alvaro.karsz@solid-run.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, Mark Brown <broonie@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-fpga@vger.kernel.org, 
	linux-gpio@vger.kernel.org, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 6:52=E2=80=AFPM Philipp Stanner <pstanner@redhat.co=
m> wrote:
> On Mon, 2024-08-26 at 18:41 +0300, Andy Shevchenko wrote:

...

> Though if it has 0 disadvantages I'd propose proposing to the git-devs
> to make it the default.

It's slower. so the people from https://occ.deadnet.se/about/ won't be happ=
y.
And more power consuming, so maybe not so environment friendly after all :-=
P

--=20
With Best Regards,
Andy Shevchenko

