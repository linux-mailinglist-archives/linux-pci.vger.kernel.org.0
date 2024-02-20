Return-Path: <linux-pci+bounces-3767-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6875A85BD54
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 14:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20C1B28327F
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 13:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077986A352;
	Tue, 20 Feb 2024 13:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="OewB+TF4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5B66A33C
	for <linux-pci@vger.kernel.org>; Tue, 20 Feb 2024 13:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708436327; cv=none; b=Kftk/3P9uCeAj1xSTdkskSzAVCW/BsU8RZc2xrOCOCxQywpNEKgv8/+xHc7mDEfj3G/mr0ta2oDP71uGtvC/49ez8huHFlY5v16hIYH6KgzDiWFQ4O956SBwfbUsWWGAh7U8NbF7TZZIaOklqZgvBP5u3v7ZGsAJs6Dudn1eFbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708436327; c=relaxed/simple;
	bh=4WZOopDoEYKpAtwPm5C0A71TU5vL9M5eFHgg+NZQj4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SKqzDGI5PJY76vXwjdUnWV2zwEuAiOrV0xKsCb48pdbC1F6Pszdl+ZcYniDGwRluTJ3WaS18Vv41nHnWoMiGY4KH8aatG1+BLSlcqI3D3MH1SLfcZJXEACkiuKiqkqCQ9RTQSedDbJVv0AVZ2IoCjA0hfW8iHzB4V8uwL8j2O5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=OewB+TF4; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-7d5cbc4a585so1379684241.3
        for <linux-pci@vger.kernel.org>; Tue, 20 Feb 2024 05:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708436325; x=1709041125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jYWyO9WtNhHDsuk1E/qE9QTBsr5s/M0F3rpI0kzs3Ro=;
        b=OewB+TF498dZFsT/KuZm7ufWPtOwybPSt3hEHvRNDqzwE7m9wAi8x+gaS0uUgHnfud
         8/SW6nylrrsqUBhU0ZtsB6TOqazdzg62hNqvxA2aDSVb+b77OgymP+ZBePaiu/lQf7U7
         CwM0Tv81mVdcqbZyXnn918TFP5SeE5NjqsvlqSPxxPVcyfd9MCVU07zWyaKebJnBfi+r
         3XjsPR6g4dCr8qTZVwmFGb2k1W6EqgX9wFpMpydW/d1Ctd6HSMfKItoj+uOqE7WpE3pA
         gerrJlMLDgdfzRCMVtKLS8OUfDTGb7H9E+JgXoL9v/qxxi4fb/zZQ394shf/+HJurLEU
         Yrag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708436325; x=1709041125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jYWyO9WtNhHDsuk1E/qE9QTBsr5s/M0F3rpI0kzs3Ro=;
        b=OFD+FZQi0fSODZ7Emv2PXyIZDPPMCsqJVIJ/PuXgH/a1jkyRQAU/BqEvjjgszPctt8
         GMUVLxsKoJfUtiJS9nvCZnc556PjkRN/LEcXS1qE3ULd/XJCT7Sw2wDDT1T2d41SBkYx
         oTPPz10ma1Ff05iD7KtLEqtvXRfiXg15Hy+m5cLd5foaW6TI32p0Pl4m3RrKsDlN1BLw
         GiMs7REg1oS0tF0S4FgsJ8Wm3hZlrAs4v27wS8vgA9nG3goZO5+jaFXsemK03dU4RXeG
         Wga6cfgK9GyTldXTFOohiqWZ8AVRTgsgvPXzB0g83A0oN5ghcFzhUJFgPXPbs1c7LJr3
         3eGg==
X-Forwarded-Encrypted: i=1; AJvYcCV+VXEsjDOgYO8gtDcAt3dCWHEVGKMIOmTQ678ZSmgNc/49OqVWSUNQnrZ53v3DOxe81XjGzDtdy1qoBztj+3bkEZEDB3QiMGLX
X-Gm-Message-State: AOJu0Yxk6zmsmv2cnf+X68/VS76ExgY7O3DzMM8IHYLYVcHSDfVjx8tb
	8P5IRzW6kTWIXqO/sCG7ysh7citMXCup4lsaxNXqn809nMcRNPZ7ebHvofKqKw0MuBdrykLEbbr
	LIoXZAsxi3yEoyNZeiwZOw1I6Y8LomhLUC70TfA==
X-Google-Smtp-Source: AGHT+IHez508i8rKwFXJLq+MmlnYcRFhCJXklYpkOKtPALfYGVznxIgsQEekDscIKGhR2FGP8107Do5jDZq7aOpexmY=
X-Received: by 2002:a67:fbcb:0:b0:470:3ece:b431 with SMTP id
 o11-20020a67fbcb000000b004703eceb431mr5233751vsr.4.1708436324939; Tue, 20 Feb
 2024 05:38:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216203215.40870-1-brgl@bgdev.pl> <20240216203215.40870-10-brgl@bgdev.pl>
 <48164f18-34d0-4053-a416-2bb63aaae74b@sirena.org.uk> <CAMRc=Md7ymMTmF1OkydewF5C32jDNy0V+su7pcJPHKto6VLjLg@mail.gmail.com>
 <8e392aed-b5f7-486b-b5c0-5568e13796ec@sirena.org.uk> <CAMRc=MeAXEyV47nDO_WPQqEQxSYFWTrwVPAtLghkfONj56FGVA@mail.gmail.com>
 <5a3f5e1b-8162-4619-a10b-d4711afe533b@sirena.org.uk>
In-Reply-To: <5a3f5e1b-8162-4619-a10b-d4711afe533b@sirena.org.uk>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 20 Feb 2024 14:38:33 +0100
Message-ID: <CAMRc=MdTub4u0dm5PgTQPnYPuR=SRnh=ympEZqo_UyrQDrQw6w@mail.gmail.com>
Subject: Re: [PATCH v5 09/18] arm64: dts: qcom: qrb5165-rb5: model the PMU of
 the QCA6391
To: Mark Brown <broonie@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kalle Valo <kvalo@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Saravana Kannan <saravanak@google.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Arnd Bergmann <arnd@arndb.de>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Alex Elder <elder@linaro.org>, Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Abel Vesa <abel.vesa@linaro.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lukas Wunner <lukas@wunner.de>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 2:31=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Tue, Feb 20, 2024 at 12:16:10PM +0100, Bartosz Golaszewski wrote:
> > On Mon, Feb 19, 2024 at 8:59=E2=80=AFPM Mark Brown <broonie@kernel.org>=
 wrote:
> > > On Mon, Feb 19, 2024 at 07:48:20PM +0100, Bartosz Golaszewski wrote:
>
> > > > No, the users don't request any regulators (or rather: software
> > > > representations thereof) because - as per the cover letter - no
> > > > regulators are created by the PMU driver. This is what is physicall=
y
> > > > on the board - as the schematics and the datasheet define it. I too=
k
>
> > > The above makes no sense.  How can constraints be "what is physically=
 on
> > > the board", particularly variable constrants when there isn't even a
> > > consumer?  What values are you taking from which documentation?
>
> > The operating conditions for PMU outputs. I took them from a
> > confidential datasheet. There's a table for input constraints and
> > possible output values.
>
> That sounds like you're just putting the maximum range of voltages that
> the PMU can output in there.  This is a fundamental misunderstanding of
> what the constraints are for, the constraints exist to specify what is
> safe on a specific board which will in essentially all cases be much
> more restricted.  The regulator driver should describe whatever the PMU
> can support by itself, the constraints whatever is actually safe and
> functional on the specific board.
>

Ok, got it. Yeah I misunderstood that, but I think it's maybe the
second or third time I'm adding a regulators node myself to DT. I'll
change that.

> > And what do you mean by there not being any consumers? The WLAN and BT
> > *are* the consumers.
>
> There are no drivers that bind to the regulators and vary the voltages
> at runtime.
>

Even with the above misunderstanding clarified: so what? DT is the
representation of hardware. There's nothing that obligates us to model
DT sources in drivers 1:1.

> > > > the values from the docs verbatim. In C, we create a power sequenci=
ng
> > > > provider which doesn't use the regulator framework at all.
>
> > > For something that doesn't use the regulator framework at all what
> > > appears to be a provider in patch 16 ("power: pwrseq: add a driver fo=
r
> > > the QCA6390 PMU module") seems to have a lot of regualtor API calls?
>
> > This driver is a power sequencing *provider* but also a regulator
> > *consumer*. It gets regulators from the host and exposes a power
> > sequencer to *its* consumers (WLAN and BT). On DT it exposes
> > regulators (LDO outputs of the PMU) but we don't instantiate them in
> > C.
>
> Right, which sounds a lot like being a user of the regualtor framework.

Ok, I meant "user" as a regulator provider but maybe I wasn't clear enough.

Bart

