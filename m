Return-Path: <linux-pci+bounces-38672-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD5CBEE2CB
	for <lists+linux-pci@lfdr.de>; Sun, 19 Oct 2025 12:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A89D01890536
	for <lists+linux-pci@lfdr.de>; Sun, 19 Oct 2025 10:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC672E427C;
	Sun, 19 Oct 2025 10:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RORhZ9RV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BD52E2DDE
	for <linux-pci@vger.kernel.org>; Sun, 19 Oct 2025 10:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760868976; cv=none; b=lq0bInDVjOLrAs5iNietO5CVQLQWKwD2Vcp4N2qGYYneYh6EZ4RpcC/pUusL0/pzp0Xbn+bAdwl37ExY7IsBjiCCZkt7kclLwZ6kM8Klw2Ajh8A1WVyT6F5FZka1tlHGEt5CYyYI8HfEZxaILGR+dgLG+nZt8Jzv60dEQsRwsTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760868976; c=relaxed/simple;
	bh=Y08tXfyNPYZyI02pzti3KblHd6VvVvbdphmuQCznqJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cd+9294G14t2c5g+ShE7dalobWUzvdUvoF/VFxC1EBXFQoe5LH73j2ywRjXhCxHFTDOrgQYCFw3rpwS40BOKWfgzoInFcWsgxvFHT8RMxNaVqGB7CVXyi2KWSuJYJVIIYZ313kiSH63PiCGjoPRSQ+X1hHfpZ0m2ZWGL5Z0w80Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RORhZ9RV; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-62fca01f0d9so6994684a12.3
        for <linux-pci@vger.kernel.org>; Sun, 19 Oct 2025 03:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760868973; x=1761473773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d9u83kC+rt7nZCWulip1b6xtkpKKymTmDmInRZDupgQ=;
        b=RORhZ9RVQjE/eG+e8iqUd1Nz4wVVxWisUfjM1Amqx130yHRgfY0VC/r98RDcMMLjDt
         i1eAO10C5GhNXRG/qAZt8hPjKQP65u6TqH/JuU6RoWu762mM2PeP2eWJHjkoCJBD+l1B
         f8Rl27M8YQoJc7J9BadURA9utXknvLaOIOxYhe0yu5/oFRm5/w0blknUnj1F75GLE+zm
         hlG+yjO3MZIQjTGhe0swuUGsKQ6feF5HVhKYXXaLD93RoBiBprOHFG3Sc3IGD/RqsucR
         1wmc6ACTaxNdIuVvdAu0vWjzgM9t+zEiGY5QdUj2FUjyUaY+syKM0u+teJLznhFdK4Xk
         ItNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760868973; x=1761473773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d9u83kC+rt7nZCWulip1b6xtkpKKymTmDmInRZDupgQ=;
        b=syJ5++j1QhhjA67BRH/hu+9A9HkQqCsYZVZ+EscUYSUg1MMBp9A0vnPw6xv2gk918M
         6WDShr9THJrSIxP3NssSMt0L4/P18O+pWFO3mJig+PPkPRUAsIPWjpZxF+zU2m7nK92Z
         +/CWmwvi3LiolJEIThWyirUc6sMD/LLcI3wyQbTBH7OMcXnk24bGtl68jYt2LJ41M7kr
         h0V5nSxhBiJZyQrr6LM1CImoM2esLBhX3ok6bKEMRRg8BbwTU/UW9ruUUDIwDMlLfONE
         1D5Ml4QKt0SIUnQI7Yl7/ZrsOaTf+mNibdh7clOpZHFTnPlDiQ3CJV8Izg25bldj+/u5
         LvXQ==
X-Gm-Message-State: AOJu0Yz3HfK6Hef2B5aie1VosVtbSCTRPS4hcZtu8kZWmAth6hTj19me
	MSsbYrWlVbytfbKKDU5BTLp85P8ub52XlMt4SvQNY15R5vrWSbjZDequb3aV+xMgx38ZRYP4wNj
	UL6Usz1twKGP4vikTlB8Cz4xgP3JCT08=
X-Gm-Gg: ASbGncs+xg8NqCQhkmSW+b+evS0vU/gGbL1swHKJgSjvRdFp+/UlxhRqSwJ/s+4rAkl
	Mx2kRxNwE7CsP3c6PPqm6nMzyEIwJiw3FLEWUhZUgBkY5dbupj7XfiMoPcNuBfXPne7CIeAqoM1
	abdb13H8CdPZuylsern51v8rbUZooMMLTKkz3xLd8lppJpe2AMbATiJkL/7JtHmvt4sDN5QuVj/
	LBD5PyFLeOVYSiFNlHxe0h/mzKJFoVYWWcnEobEKYnFlwQD84FygNzQ7H9vgWJNwU7d/g==
X-Google-Smtp-Source: AGHT+IHF5j3FxHGqGSMc6gTJFWS25mlgIJJ+B9ZAQH84yMytfrS9hAu85pLm9QkNmBBzhedGsITk+O2Ty5GQr/NWr/Y=
X-Received: by 2002:a05:6402:3492:b0:633:7017:fcc1 with SMTP id
 4fb4d7f45d1cf-63c1f6458b6mr9014013a12.14.1760868972724; Sun, 19 Oct 2025
 03:16:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014113234.44418-2-linux.amoon@gmail.com> <a2cefc72-de44-4a23-92d2-44b58c8c13fe@web.de>
 <CANAwSgTtaAtCxtF+DGS-Ay4O3_9JMwk-fJ27yoijhWWbF2URrg@mail.gmail.com> <cf656a57-bb2f-447e-ac6c-0ab118606dc9@web.de>
In-Reply-To: <cf656a57-bb2f-447e-ac6c-0ab118606dc9@web.de>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sun, 19 Oct 2025 15:45:58 +0530
X-Gm-Features: AS18NWDvRsVHc0V4iNWmDuNrhP4ZScJhRSS4H0sOBjz9i6y50fgIVE5YKoNz78A
Message-ID: <CANAwSgT0jSQ3pFR3MQo-ENziqrm=yn-rFBTdHegmknMeFd44OQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] PCI: j721e: Propagate dev_err_probe return value
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-pci@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Siddharth Vadapalli <s-vadapalli@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Markus, Vignesh,

On Sat, 18 Oct 2025 at 16:12, Markus Elfring <Markus.Elfring@web.de> wrote:
>
> >> I propose to take another source code transformation approach better i=
nto account.
> >> https://elixir.bootlin.com/linux/v6.17.1/source/drivers/base/core.c#L5=
031-L5075
> >>
> >> Example:
> >> https://elixir.bootlin.com/linux/v6.17.1/source/drivers/pci/controller=
/cadence/pci-j721e.c#L444-L636
> >>
> >>         ret =3D dev_err_probe(dev, cdns_pcie_init_phy(dev, cdns_pcie),=
 "Failed to init phy\n");
> >>         if (ret)
> >>                 goto err_get_sync;
> >>
> > No, the correct code ensures that dev_err_probe() is only called when
> > an actual error
> > has occurred, providing a clear and accurate log entry. =E2=80=A6
>
> Where do you see undesirable technical differences?

The primary issue I wanted to confirm was the function execution order.
since cdns_pcie_init_phy within dev_err_probe function

If other developers agree with the approach, I will modify this in a
separate patch

As Dan Carpenter pointed out - " Wait, no, this doesn't make sense.
It's just assigning ret to itself."

This patch seems irrelevant to me as the return value gets propagated
to the error path.
Sorry for the noise. Let's drop these changes.

Since I don't have this hardware for testing, I will verify it on
another available device.
>
> Regards,
> Markus

Thanks
-Anand

