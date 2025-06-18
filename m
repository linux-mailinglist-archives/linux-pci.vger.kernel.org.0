Return-Path: <linux-pci+bounces-30015-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B275BADE506
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 09:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8209A3BCEB4
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 07:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32DD1D5CEA;
	Wed, 18 Jun 2025 07:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ej9vC9oQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76F227C175
	for <linux-pci@vger.kernel.org>; Wed, 18 Jun 2025 07:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750233401; cv=none; b=aq+V7bGLQbm8zlDiIFEL31DVB/8L4aPESP0QSKtRJrBQWuio2gaTmg8KcNNgFJF7y7TgtBJ6FpR4IGRxJ2R5knVsC/hCsGrDmNagEeEjQkfugRP3U9HuoHoqCyROtDZgRa+66d2w/XRztaxfTcMKaPVbQlzAq2I2sqcM2mdwE6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750233401; c=relaxed/simple;
	bh=B725ObtQfopboWhV89KAmKWEgh99Un+X+ST1WY74ubs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iZrD7NI98e7agI0BTwgIgsEW/4Xdkq1r6HZkohpNtaNb8JxNC/vfnFZsKrt64nsxjREzorKRwSh7FkwW0dZywS0uLVVTNH+cXihoc9IkFi+q6Nw9uiCM3szQ3Wb5vi3b7NIpcl3SS0KarsAWeWo3vVQiR78WQoPCw+oi2OXoyoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ej9vC9oQ; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-553bcba4ff8so3610285e87.2
        for <linux-pci@vger.kernel.org>; Wed, 18 Jun 2025 00:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1750233398; x=1750838198; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TJ0GqfXFkwy2lsXPToSFORUxwHaztFRgNFLsON7VOMg=;
        b=ej9vC9oQnhqmVLWPRW04Quv4XT3JKiCTMF9GFs61BbMQos5s5iDSUwdwsfrwtqzj3z
         vx3O187mtH3BqzNPoW/Qsac3NBxc6dCQyIlAHYw9pVPiqV5AWjQpf3AVgY4Tnq7DdUzH
         BHDghgJ9nEg5Q+MWKbwTNOXxDktekGDkMW5mrbSTdsbVp5mWFnw41fHs/CF6lIheJLhX
         D40sOk+tsNa89UnrT5sRYSUlGa1UC6PS5oBr+69lf1B+aEVfm0vT6YBAPmxZZHW5ArSd
         pZYRYnbvs+uC0lbQubkpOAAOkYXnyYYGGeymFiWW0ZQhm3PF6Mdi7yJxmu7GG6ikIK8l
         mN8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750233398; x=1750838198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TJ0GqfXFkwy2lsXPToSFORUxwHaztFRgNFLsON7VOMg=;
        b=lJMdLnt6w2KkCYtM6KyWLGAk5okB7A6PI1bwYA4BoFh/G8jbqNHuH9k+F4iuG/5ViN
         Jsg6zOSC3AKgv2AuG2USzECwb9xlgx7Baum4BJrMb722fpbQ8x5r3PApGdfjdPg0Hpdx
         KDVp/oBJ4AcVP8+ErlMVcolZ1jzOw0BfQsVykWfaopGvGHR6t8oLq2zM7rgi8nRdz6yz
         XegRi+Ly/Vmqi8X/ifx5zYFU29EW9q7TCXp15wOS+FFBUArg7UNXTbu0mhp2s61Lwmg2
         vaQo8hEpEZpAeDvF5Ei+uRaDaLOsYLdXABcrz11BViXnhysgH/tNswtGVKuSf3eb3Idu
         aNSg==
X-Forwarded-Encrypted: i=1; AJvYcCV8JAma8sZMUU15JtbMoC53uWhM+QqQie1vvxUEvhvjgCPfyv/hllT/0/9hHp5gZmEq3S13ljnsxuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQNK15Ppigp6E5/XLNZyY0Xf0Um8eGiz7G8k9JHiMLQErgRLCy
	13p9m06VLIw3CrD4Rz77lyWuHHQj3kg24Lxk/LSBOdxloA9ZEX98njEE2BN/RM3bFI2DENH3ll+
	O24BNzM1IWhlE76iYTuS40e+gOGg25bNreAj5FhSdx+ui80ZuRrplt/QCQg==
X-Gm-Gg: ASbGnctM6Qac7Gf5RNUM7SVOPIDYw/acf+ttzq5rAfBW+fe45W+zlvJ4TMZEQfcVmrq
	BXggOh2pttPEetF9fs67RDVTQ1EY2Lg+aov6ZXDVzJvxg3SQUT/SIBCeszVYfw6mFkt1FuKI+xm
	XP380uCFJyTpt1f3T0RQFZr3kw5NGNVDoFSkWk1j0U7/FKAmyrGE8ohhpfkgejx+DRyyz/Xv1w6
	w==
X-Google-Smtp-Source: AGHT+IE695IdkbI0XaFitv8pj0RWUPD02k49e73uDCAYKNdE+Er9d4BDgEqRq3VwoZJvHMQj3QGfbfx0tg3NN2LZjpM=
X-Received: by 2002:a05:6512:1050:b0:553:3486:1d9b with SMTP id
 2adb3069b0e04-553b6f20ademr4250186e87.30.1750233397768; Wed, 18 Jun 2025
 00:56:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612082019.19161-5-brgl@bgdev.pl> <20250617233539.GA1177120@bhelgaas>
In-Reply-To: <20250617233539.GA1177120@bhelgaas>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 18 Jun 2025 09:56:26 +0200
X-Gm-Features: AX0GCFte5APiTF5pvx6EYjGuNuCbnNBT7QTZx8AlXbjqtbSDs9YTuBKoXyu0R7Q
Message-ID: <CAMRc=MfbZAz_7PomZirQzY2Hq1i=uvpO3wH74nYq-ohjTavjMg@mail.gmail.com>
Subject: Re: [PATCH v9 4/5] PCI/pwrctl: Add PCI power control core code
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Amit Pundir <amit.pundir@linaro.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Caleb Connolly <caleb.connolly@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 1:35=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Wed, Jun 12, 2024 at 10:20:17AM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Some PCI devices must be powered-on before they can be detected on the
> > bus. Introduce a simple framework reusing the existing PCI OF
> > infrastructure.
>
> > +/**
> > + * struct pci_pwrctl - PCI device power control context.
> > + * @dev: Address of the power controlling device.
> > + *
> > + * An object of this type must be allocated by the PCI power control d=
evice and
> > + * passed to the pwrctl subsystem to trigger a bus rescan and setup a =
device
> > + * link with the device once it's up.
> > + */
> > +struct pci_pwrctl {
> > +     struct device *dev;
> > +
> > +     /* Private: don't use. */
> > +     struct notifier_block nb;
> > +     struct device_link *link;
> > +};
>
> This is old and I should have noticed before, but we have partial
> kernel-doc for this struct:
>
>   $ find include -name \*pci\* | xargs scripts/kernel-doc -none
>   Warning: include/linux/pci-pwrctrl.h:45 struct member 'nb' not describe=
d in 'pci_pwrctrl'
>   Warning: include/linux/pci-pwrctrl.h:45 struct member 'link' not descri=
bed in 'pci_pwrctrl'
>   Warning: include/linux/pci-pwrctrl.h:45 struct member 'work' not descri=
bed in 'pci_pwrctrl'
>

I didn't want to document these as they're not part of the API.
Probably should have been "/* private: internal use only */". I will
check and send a patch.

Bart

