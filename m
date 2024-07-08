Return-Path: <linux-pci+bounces-9936-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBA692A5C3
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 17:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39740B21506
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 15:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E0E142E8D;
	Mon,  8 Jul 2024 15:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZWwTnUXd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2378613E41D
	for <linux-pci@vger.kernel.org>; Mon,  8 Jul 2024 15:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720452885; cv=none; b=NwXbtcnLrtEg2Vhy2T0PrMEztpGDpxYfU8o15LdXNLmHgkJjAKUujclDcyzHMA3wTjQszks2x7XGxUurWSDt3evcz5BG1IR5s4lRYFu7TsF6jrNHPtqAvl6YOIlyg8eHlPj2xOd2cXG4x++FBvIfUqb9fXdBAkvkkXhqVM0t06I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720452885; c=relaxed/simple;
	bh=M2c6kaFPTPaMPPvGtEfj0+QHFGsFovJZA+6XuUbtpZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kY6nyzJ1DBV+qw6C09hDxPDxjuRHlE0pMCtY72AzOxQ4z0PmpmIlqSu8G1pY6sJgYw4A8AgQnubacFU3EZGSGzUMasXTAKVJjFYPzbkFnRMuuezWkta249fHmE4HKfdiQWU+oRA03t7B0GsgpCyt3REmXL0Lha2VCmFOy2PWk0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZWwTnUXd; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6510c0c8e29so36240177b3.0
        for <linux-pci@vger.kernel.org>; Mon, 08 Jul 2024 08:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720452881; x=1721057681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ACGxkb1vUuB6XgAAm/uE9mAMLh9+1WbqmNZck7dmAw=;
        b=ZWwTnUXdWgiieBZrBHbyLFDXx/FOt0RRxtD6KO6wgLJZxU5Jrna+3F0EppbN+1tVB4
         3vpegO+R0vXfpIojEvQAKYM66GUExysirkKqYuqVazcvA8EqrnI8W7p7DVmuxoGkmXeh
         Yk99TXMf6sQSUWAk+fImIViP26Zb2zY6XlL0qQJQRrBuZKU9qpixyQLNzwh8K+N1iPMw
         8v9Fwf05FFga5nKLvumh0AjNC2vAFYOm0znAEXyzQ7Hub6bF+eg5YG4/EY2MBNKO97CO
         5uaZ51F9Bh4rfKoEe35MmQgM5wn2dee6QSWPvSzOXJbckIFB7/v4bXrWOpUmZwIzOsTC
         nAOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720452881; x=1721057681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ACGxkb1vUuB6XgAAm/uE9mAMLh9+1WbqmNZck7dmAw=;
        b=t82Tbzs0TkcsqJJallSLK6qPDcBKC1G6bUfwRmWM+8xnU/78NjzxEqm7n0aqPqI1Tt
         FyNoO3OsCAy2fwH5Ut3/vvbWBVEb1tUPGAah+ZNvrwqP8GAs0l78C/YhS0lb5zXj5dQX
         7LfbJSICIaDLqmYSgz6CahgnMeIINULyKiBE96knBOIZJC8/efqNTbNhq1IoY7u166IS
         VtgxHUrJYPI1hkGGNGzyK2nyK5NQPP9hWXz0fs8qeZA+V6623GeLh22iezi5+dPTnYKf
         O9EfDffiNl7grYHT8Fmkm3JQKIoaPw4XoTnSkUSX4J/Jz9e88QiZoie0SU84qEa3HEKs
         rA/g==
X-Forwarded-Encrypted: i=1; AJvYcCWoZCV0MuTxxXrmXCx/S2lmJUY7mruRTCka6CXXQ6YH0i/8ldzv3S4Ak8lauTPrWIFlnzVm3a4A+eJhShMNVFYBvZhrbAmi+rip
X-Gm-Message-State: AOJu0Yw4cGbo0MGNk374c0BtnGE3Gf210bJwxf1n/J2039KJafd6Eg91
	HeyO64h6OTVwh9fUSRqutHusWIYdStMP66nndT028T/LiSGfszVprq/lue1puBKa8GFaJYa0Kyi
	6cKk37IIsY4v8GEq5AXrSs4gvGkA5MeKlU80N/Q==
X-Google-Smtp-Source: AGHT+IEPLsPJ9FMmV6mneGwbrbQXd00Du5/i6fgbmGcbD6MSVJhQ0fw5NHZO380ebfaki4e8/nCK4nlXGsVlEsCyQzk=
X-Received: by 2002:a0d:ee81:0:b0:62f:a250:632b with SMTP id
 00721157ae682-658ee79101dmr996077b3.8.1720452881045; Mon, 08 Jul 2024
 08:34:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240707183829.41519-1-spasswolf@web.de> <Zoriz1XDMiGX_Gr5@wunner.de>
 <20240708003730.GA586698@rocinante> <CACMJSevHmnuDk8hpK8W+R7icySmNF8nT1T9+dJDE_KMd4CbGNg@mail.gmail.com>
 <20240708083317.GA3715331@rocinante> <6e57dbc0-f47a-464e-af6b-abd45c450dc6@kernel.org>
In-Reply-To: <6e57dbc0-f47a-464e-af6b-abd45c450dc6@kernel.org>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Mon, 8 Jul 2024 17:34:29 +0200
Message-ID: <CACMJSetAKtPp_Gua2S7m_+aC-f9HSUyfF1YoHUPdtcibLtQxpA@mail.gmail.com>
Subject: Re: [PATCH v2] pci: bus: only call of_platform_populate() if
 CONFIG_OF is enabled
To: Mario Limonciello <superm1@kernel.org>
Cc: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Lukas Wunner <lukas@wunner.de>, Bert Karwatzki <spasswolf@web.de>, caleb.connolly@linaro.org, 
	bhelgaas@google.com, amit.pundir@linaro.org, neil.armstrong@linaro.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	Praveenkumar Patil <PraveenKumar.Patil@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 8 Jul 2024 at 17:29, Mario Limonciello <superm1@kernel.org> wrote:
>
> On 7/8/2024 3:33, Krzysztof Wilczy=C5=84ski wrote:
> > [...]
> >>> If there aren't any objections, I will take this via the PCI tree, an=
d add
> >>> the missing tags.  So, no need to send a new version of this patch.
> >>>
> >>> Thank you for the work here!  Appreciated.
> >>>
> >>>          Krzysztof
> >>
> >> I don't think you can take it via the PCI tree as it depends on the
> >> changes that went via the new pwrseq tree (with Bjorn's blessing).
> >
> > Aye.
> >
> >> Please leave your Ack here and I will take it with the other PCI
> >> pwrctl changes.
> >
> > Sounds good!  With that...
> >
> > Acked-by: Krzysztof Wilczy=C5=84ski <kw@linux.com>
> >
> >> After the upcoming merge window we should go back to normal.
> >
> > Thank you!
> >
> >       Krzysztof
>
> FWIW this other patch makes it quieter too.
>
> https://lore.kernel.org/linux-pci/20240702180839.71491-1-superm1@kernel.o=
rg/

I had applied it previously but backed it out in favor of the new one.

Bart

