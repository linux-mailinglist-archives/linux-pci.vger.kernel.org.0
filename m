Return-Path: <linux-pci+bounces-8391-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6818FE163
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2024 10:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12360284C8C
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2024 08:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EA6137C37;
	Thu,  6 Jun 2024 08:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJ7KkhfO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962DF19D8B5;
	Thu,  6 Jun 2024 08:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717663626; cv=none; b=TKn16ojcQDkQV7Sx6dfxvFYsmtmnOLN6h87BxpksKk88yFly3vseFWCB9dZhdWg4uHBqzwMd7Q7bmJYfB2bLqw63+uj6mWgwRECR6JmqSZurY1d2HTvpfQM5hfjdSz9DFzQ/WWw/LLPAg2xBhbx6BLDxrMaaZuWRRTfOEqKUoUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717663626; c=relaxed/simple;
	bh=3Z8Us2nSlYTKmCcmp9/IYqU2ynqeFuKwkzczHr5v/dw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jaGgwdQuNCe279KCnVQsF1G5Cmpa2URozT6saoF/4Ky7+G4s7ToeEL2qZkT8RcvjsVE1PoQeLPnfg1EdNw7Y5owEUUJTqvWVt39Fg6F3DHrkVjdTx7UbYMXDmUlo7tZmCXzq/2jPthXAEr+VGR1UbDRxyGbyvJg+ecGSr8TsZH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJ7KkhfO; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57a2406f951so717358a12.1;
        Thu, 06 Jun 2024 01:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717663623; x=1718268423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Z8Us2nSlYTKmCcmp9/IYqU2ynqeFuKwkzczHr5v/dw=;
        b=MJ7KkhfOjfP4Dkhgtd0l28xYDrIO/K1d8LCOrch8QsMEsmWN9vbZ6InY7e1pH6IWcB
         D6XfnSORsEgPIEakoulzblOqYz5p6iREuDMLFKaULI+GiI91x6XKWQ0mARnDf0kckQC6
         2me+Dx7zYQKxvKG8hj4I9lBLpzgeevW+k0AX9RP3zRqwSti4kdqfhdDJ/DnDK2QUKFeT
         GKxRoqm9RXgh7ardTxXbndNwSRT8L+mDkshv+LFL/qGPrZKUVfEM/Toee3HvwB2MvFOq
         N0ChQ8YQ1/rOig7mVjXaVexk67RwQ0zMurooTVObcHHmV0D1LEUuOXYLAm+Dc+cr3kq+
         RCpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717663623; x=1718268423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Z8Us2nSlYTKmCcmp9/IYqU2ynqeFuKwkzczHr5v/dw=;
        b=lPLtgRlnw2nRTx2HvNwMyKbH3AgTnaaGsjBVkUqVSZEb6gLWezU6+/ZbeSRYL+IgLD
         wrBs5XDFTmpgzhufJe0a9ZA5W04oBt9Mqs75cLPXwFM7bYHOhAQrs8kxXGr+2OQ9RJGy
         tDN1D2rzqi/j/3tp5AFVVMTOkIYNst8JY9qhBgJt8zG/No7sI2Ad7rMEUZyZFFMCYGCA
         xKie7HhRQFGBT5toR/HpvJONaLhAJA/U7oJxUI6WcKp3PtpR/fCQb+/Ng15OkLy7zTPO
         8WVzIojT/T0rSgw8GHdzy3abDeD9jW9VsHthrFaCeKxPpluBUZfDxRbRqP1rG2SQ+y0r
         VxTQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6UWlIYCGgt3smucxb9puItgRxehMZ21qqgjKejkAnEv6HQ/GSb700PGmMJncOj+KDuSDx7V0Z+8Q9Agu4uozPohhncUO4GaUNiP7zuYUeoWL9D6eUlqoS6NOdesTBMpvU7o9i1izB9eOItVkHXiiaTUoH03ZMj6G/Wh8ekrTQTE1NjjKIaF/V4+R7Cqgx7fzEng/IKQNRQsVphA==
X-Gm-Message-State: AOJu0YyID4QVFXxAldkBjMynRaAO8SgGCErolDVBCzoX3okj4aSvEoai
	I1Y+nmfio9DCewUMswCBfdhta3C62ym54Qx+GyoL0m8XXs62dXLeE7PAPakyBbT87U5mLw1+yx0
	iog1BLfXFEjp6wGTiiS8yuF6lBtQ=
X-Google-Smtp-Source: AGHT+IGdVYuwX6uA4TvJlilcYuuO/VA69P7h3+MlIEcZkfM3mPZGkSv1vh38t8Zdpu59VKYRGWXpx5Vfrnq/qoT+4dU=
X-Received: by 2002:a17:906:65c5:b0:a6c:702f:7a1b with SMTP id
 a640c23a62f3a-a6c702f7b0cmr196870666b.23.1717663622692; Thu, 06 Jun 2024
 01:47:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527161450.326615-1-herve.codina@bootlin.com>
 <20240527161450.326615-10-herve.codina@bootlin.com> <ZmDEVoC9NUh7Gg7k@surfacebook.localdomain>
 <20240606091446.03f262fa@bootlin.com>
In-Reply-To: <20240606091446.03f262fa@bootlin.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 6 Jun 2024 11:46:25 +0300
Message-ID: <CAHp75Vex7M0htYQiALN3SVy4XHv8bQ-6QQaX21vS_BFF7Sn_Gw@mail.gmail.com>
Subject: Re: [PATCH v2 09/19] irqdomain: Add missing parameter descriptions in docs
To: Herve Codina <herve.codina@bootlin.com>
Cc: Simon Horman <horms@kernel.org>, Sai Krishna Gajula <saikrishnag@marvell.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Lee Jones <lee@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Horatiu Vultur <horatiu.vultur@microchip.com>, 
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Saravana Kannan <saravanak@google.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Lars Povlsen <lars.povlsen@microchip.com>, 
	Steen Hegelund <Steen.Hegelund@microchip.com>, Daniel Machon <daniel.machon@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, netdev@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	Allan Nielsen <allan.nielsen@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 10:14=E2=80=AFAM Herve Codina <herve.codina@bootlin.=
com> wrote:
> On Wed, 5 Jun 2024 23:02:30 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

...

> Yes indeed, I missed the return values.
> Will be updated in the next iteration.

Note, Thomas already applied this version, so it should be just a follow up=
.

--=20
With Best Regards,
Andy Shevchenko

