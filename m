Return-Path: <linux-pci+bounces-11336-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7F894834B
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 22:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E45AB212F9
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 20:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B4215F403;
	Mon,  5 Aug 2024 20:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eai9rHgG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8D013C809;
	Mon,  5 Aug 2024 20:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722889298; cv=none; b=lyxwLWU64U9vmwwkxu/ecH2IeaYUWZQI5D5+WwSF755JP8t40eOpreWKbDPJ2KODZFtj9QpxudQlzu+BnFfpXHsaw2FysLE2do5CsqQjS0n50GQ5oDavxZFgavF4DtODKoLJ01Ho0tK6m/4sziG8IpknuEjjFcKlU+em34DE1U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722889298; c=relaxed/simple;
	bh=vP3FK92WBvMVFvLWJ9EoNqbuwJzuuSW+73AudaBh6JI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=freNJrG8TmyLqPIcogbBUdN+Uw1u6I0k2N43RmaCvoI1yguyLwb/PgRkcTeVHVdNDrX9YRhsfbW+FFU7/CQGk1qGqHxeqbU0M4THVWGrrTmMRKI3AfF68R4pxZSzNbsMEXzpRVUjNE8xW5r0PHzmqsTdzpYdFN5kxXSL7TmorDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eai9rHgG; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f15e48f35bso40568401fa.0;
        Mon, 05 Aug 2024 13:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722889294; x=1723494094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9YZTNlYZkSOf691YFbblsEz2CrukPGWuU5oz6luCKSI=;
        b=Eai9rHgGFFIq9rdXOBjltWU5LMuYRrJHzcdgxE7b2/oyYbrP/AAGeHT6g+6RbNbtcP
         g4cgXfD2bmViWzlbll/aWwZa4RvM5hrGbHYGkJ2cTzj/wHAzfXXi/eQccvyI7nUlGUbN
         5qEDoWkTL9+CkCk708Nsn89cRUp6HAGPO2RT63+j4VVUgDNYEOhlJOSOVUjw/4lHSYZJ
         Gu1rKmc7qYpBJzJV3u5o0Ln2Flv0+BsaWSRdaHyZiDB6XSoUHUTpnBTZlZqdxAsVwc6N
         mLzNTwkUt4LlRw0Cr5DilX3a/UORPHW5GPFhDEtaYUyvjpW8QoKtxSZdHdjmJrnKwxOS
         Z3jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722889294; x=1723494094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9YZTNlYZkSOf691YFbblsEz2CrukPGWuU5oz6luCKSI=;
        b=MFhNMfHBzrG/2BtzW0qga2UH3iB4EI9cBcTX35p+k430FOzmyVsQxWHzRg8901yZ7r
         0YE0yqDmom5/J/9egHT3A/zdPY/4wv93ZieDnQ178Oe9tvCB28OnebKnSrir0x89tzVZ
         jRH8Xa4A/WwrIU61BWd1F5ebA7kjprDChduM3r0TO3m1WmO6y953jXoqU52HPIEpP+fN
         W/uVtUdptCJP1pyIs+ZZxJ9ACaWuIG/Rf9k6N9nfCQgYuSxnEUVA571+A/fVzS0QJNZa
         DVqNyp26w0ScR4riDTbJ2bmOun59+R73g8IlB7awwNBOlWFqQ79MyHKl2QNuzOd9GRro
         J6pw==
X-Forwarded-Encrypted: i=1; AJvYcCXUv75aLxSSi90z7DJYoZOhgpCpbsbgIEZi+rnJ2TlzAqX84pHm6O6YviZhYtojS1uf3AL8udTw4uemYwogPybZ/rpIatiw21CL4Z3kL2nzgTIMyYJQ8QP1wyOnd0Xmm/qe5wM0x7/GnLyv7v99TFHPwKrehSAtdqrL+G8Rk09+9N2y7UFANRARf9JNR2zEBj0uHQuNtXvpKDXm/g==
X-Gm-Message-State: AOJu0YxlHgP1ZMx6uKLbHC461bYLn6FSrasHX2J4f8RKa+gTBqA2vTFc
	RPr/7nVuTnlt85wnk/PcSQ2BvzGvBB1kwUVB1PWqpUQ6UOcsTRnAeTnYJfz6mp2nEXvPgxDSoHg
	Q7xz9WZWuzaXzYkF1WQYiTeV5MWM=
X-Google-Smtp-Source: AGHT+IF7K0l0JsbiL1lnNvI23XhXRQnpGWo9AInbW4qVFGSgWv4PK7ZiOprT8LQB7YB/2/M48jW8XO/yHYdX50ukbyo=
X-Received: by 2002:a2e:95c1:0:b0:2ef:1edc:3b6a with SMTP id
 38308e7fff4ca-2f15aab0a32mr83082461fa.21.1722889294018; Mon, 05 Aug 2024
 13:21:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805101725.93947-1-herve.codina@bootlin.com> <20240805101725.93947-4-herve.codina@bootlin.com>
In-Reply-To: <20240805101725.93947-4-herve.codina@bootlin.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 5 Aug 2024 22:20:56 +0200
Message-ID: <CAHp75VfKXEyHF25xRq8EDp5SeBdyPHLgzw=4s1xkjer=sNu7aw@mail.gmail.com>
Subject: Re: [PATCH v4 3/8] mfd: syscon: Add reference counting and device
 managed support
To: Herve Codina <herve.codina@bootlin.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms@kernel.org>, Lee Jones <lee@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Derek Kiernan <derek.kiernan@amd.com>, 
	Dragan Cvetic <dragan.cvetic@amd.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Lars Povlsen <lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>, 
	Daniel Machon <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Horatiu Vultur <horatiu.vultur@microchip.com>, Andrew Lunn <andrew@lunn.ch>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, Allan Nielsen <allan.nielsen@microchip.com>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 12:19=E2=80=AFPM Herve Codina <herve.codina@bootlin.=
com> wrote:
>
> From: Cl=C3=A9ment L=C3=A9ger <clement.leger@bootlin.com>
>
> Syscon releasing is not supported.
> Without release function, unbinding a driver that uses syscon whether
> explicitly or due to a module removal left the used syscon in a in-use
> state.
>
> For instance a syscon_node_to_regmap() call from a consumer retrieve a

retrieves?

> syscon regmap instance. Internally, syscon_node_to_regmap() can create
> syscon instance and add it to the existing syscon list. No API is
> available to release this syscon instance, remove it from the list and
> free it when it is not used anymore.
>
> Introduce reference counting in syscon in order to keep track of syscon
> usage using syscon_{get,put}() and add a device managed version of
> syscon_regmap_lookup_by_phandle(), to automatically release the syscon
> instance on the consumer removal.

...

> -       if (!syscon)
> +       if (!syscon) {
>                 syscon =3D of_syscon_register(np, check_res);
> +               if (IS_ERR(syscon))
> +                       return ERR_CAST(syscon);
> +       } else {
> +               syscon_get(syscon);
> +       }

  if (syscon)
    return syscon_get();

?

> +       return syscon;

...

> +static struct regmap *__devm_syscon_get(struct device *dev,
> +                                       struct syscon *syscon)
> +{
> +       struct syscon **ptr;
> +
> +       if (IS_ERR(syscon))
> +               return ERR_CAST(syscon);
> +
> +       ptr =3D devres_alloc(devm_syscon_release, sizeof(struct syscon *)=
, GFP_KERNEL);
> +       if (!ptr) {
> +               syscon_put(syscon);
> +               return ERR_PTR(-ENOMEM);
> +       }
> +
> +       *ptr =3D syscon;
> +       devres_add(dev, ptr);
> +
> +       return syscon->regmap;

Can't the devm_add_action_or_reset() be used in this case? If so,
perhaps a comment to explain why?

> +}

--=20
With Best Regards,
Andy Shevchenko

