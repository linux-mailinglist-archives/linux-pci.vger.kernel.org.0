Return-Path: <linux-pci+bounces-8542-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF119024B7
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 16:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1D6328A977
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 14:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1654B136671;
	Mon, 10 Jun 2024 14:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="VxCsn6ks"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65080132138
	for <linux-pci@vger.kernel.org>; Mon, 10 Jun 2024 14:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718031356; cv=none; b=WTi/Lx4OhSr2Jdn0ICHh/7hBW8XJ6nmLkISZoOCPL4oWZVnBgfBmRN3Lju/z+B4RnpSemKCuelhU1PjpAAiUoijBm7+ouNKLDJ5Ar/OidUxScG3WvJCPdEFXg81vC3XASt1u3Hdymw8KRQV+K4EX4p3LNY9YEyfMnaJomvdeBFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718031356; c=relaxed/simple;
	bh=a4rkfc4GzPGRris6Z1ZP+m4vNqg11DajU8g7jZ/ttxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NTnYqfrtTJ0Z/ip8l1URjJxC8j20QdWthgYcViBMoRbb9cPFcyHlcL1wko5eP4UFJwuXmhKX+RnmSRp3FU0mbATgfqehoVoPqdNixiEaIf2C5TLlzCGQK+nwgnb6ECZaxGtqM/lWA9EFXOvPpKMOUDzWsr7YoFR7R5DkZZOQ7UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=VxCsn6ks; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2e724bc466fso80381fa.3
        for <linux-pci@vger.kernel.org>; Mon, 10 Jun 2024 07:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1718031352; x=1718636152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pab8FcNXevJ4REaLQwWHgCYLaa+BjiZObbSjcyCPEP4=;
        b=VxCsn6ksdmR5u60V+7DKgu3Yf0QI0y0CG/vHv9102vhtnNzTlVZegB7kQOrP3miirK
         q1tCqbQ3y+jf+8w5kMcFgLSW6I02vhA0+vaGY+J1BLF9+aBS6/gKVm2nMuwjaqi+SDm2
         JP8ZLiUXPLXh1nDUd0itT01jGTO8e7BdcLZ+9MGRf64mjk103zrFFgNDPqIxhzUK/NDo
         NZ3sJTysoLQq9UT4xYYAbK91ODYq3dafKnzIgs/MmO2z70vlj0Y1CTfw+RRUz0QA5jPe
         NIBE+x/6UELyIVTz2HG7zmD76dFj3ruLeBBuahUgasc/nosfI9qc4WjigjNT9BfMBNDi
         pzVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718031352; x=1718636152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pab8FcNXevJ4REaLQwWHgCYLaa+BjiZObbSjcyCPEP4=;
        b=v/ufHu8PGJ3uSwUBEQhubXVPA1i+APIFFKIHgTCg0ma2Cz4p7bfwEWzMg8+UKbTm46
         6FawHFcGcr1oppKxA20rdnMhf/p260j/euuVxNX+lRKD9GouiSIJX11Zlnw6v23MRkiO
         M62ApRMyfeJofzaJZcfKqVVNaioHN3IeMgLVE5vIXiot7fj8yN5T0msE1CgJhicY2PW6
         wU7VsDEcLunhKg8y8r4iV7o5vsFXwV4Y3JpwgyhR/Y6w1yX8KRWjGo+iT1AvpmWgNjMe
         URLXFQEJYG326CjZPGazh0jnIZB36MlTPYZ5uD8aVn9vFY6nIy3g/qpPC1AKtgzsSev0
         7ClA==
X-Forwarded-Encrypted: i=1; AJvYcCWkik0P9//Mb93YY56e5BUSDz52vaxX8dzGr2BvYM0pA7J6ICDQL8+stYiU+J1ELnk8qO19LsOjqnVwOyetO6y7jwsVU6Gvl9Vr
X-Gm-Message-State: AOJu0YzDMlER8VBUujhUJvCeTKc/4CYAsCE59snDY8V32ZoyvFcXmpAz
	L7Nr/9BADn0Ag+R8PZBcTIDEkVhOxc7Y8JSqxRv6gVrTHZdwq809139EMyUBO6fX7+6di1mSltR
	fz74y4NQl1F0Y2uez358xcBZvXRH/PlvqCekurg==
X-Google-Smtp-Source: AGHT+IHQqDdunRflP8brqOuTqf25grUIHylgVkDhDOCw39EO5L8ro6nE5HZbJanReJDrk7FV5UpKKyPc3vxi73s7M2k=
X-Received: by 2002:a2e:a584:0:b0:2ea:e2d0:dbbd with SMTP id
 38308e7fff4ca-2eae2d0e036mr82961801fa.51.1718031352486; Mon, 10 Jun 2024
 07:55:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605123850.24857-1-brgl@bgdev.pl> <20240605123850.24857-3-brgl@bgdev.pl>
 <d19e49f9-7f3c-42cd-a0fd-f9cdb07d0e35@linaro.org>
In-Reply-To: <d19e49f9-7f3c-42cd-a0fd-f9cdb07d0e35@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 10 Jun 2024 16:55:41 +0200
Message-ID: <CAMRc=Mdma1WJ_VAyNsWVO66m5qo1xf+RP0A+ABXuHmsuOvKWgg@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] power: pwrseq: add a driver for the PMU module on
 the QCom WCN chipsets
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kalle Valo <kvalo@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Saravana Kannan <saravanak@google.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Arnd Bergmann <arnd@arndb.de>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Alex Elder <elder@linaro.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Abel Vesa <abel.vesa@linaro.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lukas Wunner <lukas@wunner.de>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Amit Pundir <amit.pundir@linaro.org>, 
	Xilin Wu <wuxilin123@gmail.com>, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Caleb Connolly <caleb.connolly@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 4:54=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 05/06/2024 14:38, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > This adds the power sequencing driver for the PMU modules present on th=
e
> > Qualcomm WCN Bluetooth and Wifi chipsets. It uses the pwrseq subsystem
> > and knows how to match the sequencer to the consumer device by verifyin=
g
> > the relevant properties and DT layout. Using this driver will allow the
> > BT and WLAN drivers to respect the required delays between enabling the
> > two modules.
>
> ...
>
> > +
> > +static const struct of_device_id pwrseq_qcom_wcn_of_match[] =3D {
> > +     {
> > +             .compatible =3D "qcom,qca6390-pmu",
> > +             .data =3D &pwrseq_qca6390_of_data,
>
> Bindings *must* be part of this patchset. I missed the moment this was
> split into such chunks.
>
> Best regards,
> Krzysztof
>

The bindings are already in next via Mark Brown's tree.

Bart

