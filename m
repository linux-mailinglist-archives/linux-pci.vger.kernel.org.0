Return-Path: <linux-pci+bounces-18604-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 760A99F4B64
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 14:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB34E1615FD
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 13:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095B61F3D29;
	Tue, 17 Dec 2024 13:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oDshkeoo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5421DFE8
	for <linux-pci@vger.kernel.org>; Tue, 17 Dec 2024 13:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734440449; cv=none; b=m/pD+IwrGP+esZEohoYM/qrRRU/RW+gMEZvkkb3Acra7uHCr2bBGF2X8Y8tTX/rtceNtGsIPj3kjzIq5uoIs+F2xfHhX1nu5EAePwodgfFQ9N0p43jlaHssshVVy6XCIE07q+XCpsMUW7Y6DilN2g/YjhgRoKrbzCtqs53MvXkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734440449; c=relaxed/simple;
	bh=GQIWeq5N/1+/+kDvpSpnt8IVUMXNOzsNCXvdUhT2KmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T3qLlSXy2WDfVszj6mI94lkY9eKzbokL7qJ0mhLDmAKbhchMBlaFo9sVarAUQCiSDgecIiCXYUC8OmS2ODdCvB1MVSQCYw/hyspWgvN9iBLGyasXYVmVujkpSWZ46PGvf9lh8znxNxcdG2DRee1ChFvkHtacoHlTX3AijuMj42s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oDshkeoo; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53f757134cdso5943140e87.2
        for <linux-pci@vger.kernel.org>; Tue, 17 Dec 2024 05:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734440446; x=1735045246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQIWeq5N/1+/+kDvpSpnt8IVUMXNOzsNCXvdUhT2KmU=;
        b=oDshkeoomomkIWzWQtd40b2V5rwgwFkhB7Eu7YBZGDvIYVgrDvlPqAjvxUdLBWF9uu
         2eSFlFRSUmS3lgz62kRmWj+Fway0aioruT2H4RepwD0PYuC+KOO67uBEYJ1b420tKwyX
         SzPj/DWyPya0fN1WIQP7kluPUlE/7mpclvMFDagnOQp+RTL9iepc57XYBCISnMeDeRlJ
         ey5hJ4amtgEWvmvw8ebabxfDkQdp5xB3O+4ZeLIVHkDbNDlE/2HNVsS1StdG73epPkrX
         zwawVFoq/IDIcv+gE8TCRFc31FGfhttkRGDvdPHSItlFlhNPBYqBZoG6gpgOl2sb9ZEz
         Yovg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734440446; x=1735045246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GQIWeq5N/1+/+kDvpSpnt8IVUMXNOzsNCXvdUhT2KmU=;
        b=Y0vZNHE2bjaVb1KyK59zD4Ooesqq2dwSJhXd4GaBB98Cl1sp1V56rLL8doiL9xZsdM
         00Sh3fxfG/JJ0y9v/k2tQtR38rKrgXNvWd5prvtDTJqTEGcKweajvkdMoE8VnHjgoLMl
         e+CnEudhcWcBvkh5hxdKoQVSiOg8eEUZt0jG8ydSUb5MtVdeIw9nWjrUhjNHDDwIgmdr
         A2gO3NPa6Qmgl4joHZ+BhB4o4hN0+MrZTJ6ShHRUVWf9aIFw2GYOXUtvBnz3oL0mfNNA
         Lxvev9+JaqiFEDTuJQh833QbOn9ftweQpHd6rGzHWcVcESXaDRmuuQ8bxNPSsEBpCxk2
         ju2w==
X-Forwarded-Encrypted: i=1; AJvYcCWw9X626L27mPmGSOrvcDsJ/z+HGScj9lBvpP5PlOBGmzpzLvJ0agpOjoEZ0VwhXtFsTisLQ9MM7MY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7p7orPo/gYv5dSq3FiX+2eivZyeCgx9bEUegrkUCODQG+tEOw
	AIjazRpTox9C8g/4kjj4qJXMTLe5tPneATtAPj6kRMSDpn0O23aGrPUr7vXyLeHENJeRjkInCwx
	rtf1xKGaEXNI+20pc1eyE0Lk3Pb40NxbNiyIhHA==
X-Gm-Gg: ASbGncu0zZXCKWf2y7GSVwB3Eo10nCL2PW0Uttm8aEVZ3XIRZOGCRt7+nmKqbL9Qrci
	GXbjiG9PHoKTI98T3kYIimwCmpbEalaPyj1bHKw==
X-Google-Smtp-Source: AGHT+IE11omUaJ4WXf3M872hwf4LKHvl3NeeSE6hV/ORlMdadi+NJj5MwYpomF9yj0vKXlTRigYPF4Zh1hB/AzSqds8=
X-Received: by 2002:a05:6512:220c:b0:540:3566:5760 with SMTP id
 2adb3069b0e04-541310a37fbmr1037395e87.35.1734440446299; Tue, 17 Dec 2024
 05:00:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1733136811.git.andrea.porta@suse.com> <42e09506979d878547d1140d7f6bf68ace76549b.1733136811.git.andrea.porta@suse.com>
In-Reply-To: <42e09506979d878547d1140d7f6bf68ace76549b.1733136811.git.andrea.porta@suse.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 17 Dec 2024 14:00:35 +0100
Message-ID: <CACRpkdY+6QPRH-Pd9SwXV6dsdah-otMa8bkt=-avzF6Aiaz7gA@mail.gmail.com>
Subject: Re: [PATCH v5 02/10] dt-bindings: pinctrl: Add RaspberryPi RP1
 gpio/pinctrl/pinmux bindings
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof Wilczynski <kw@linux.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Derek Kiernan <derek.kiernan@amd.com>, 
	Dragan Cvetic <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Saravana Kannan <saravanak@google.com>, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-gpio@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>, 
	Stefan Wahren <wahrenst@gmx.net>, Herve Codina <herve.codina@bootlin.com>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Andrew Lunn <andrew@lunn.ch>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 12:19=E2=80=AFPM Andrea della Porta
<andrea.porta@suse.com> wrote:

> Add device tree bindings for the gpio/pin/mux controller that is part of
> the RP1 multi function device, and relative entries in MAINTAINERS file.
>
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I can also just merge this patch to the pin control tree if you like,
tell me what
you desire.

Yours,
Linus Walleij

