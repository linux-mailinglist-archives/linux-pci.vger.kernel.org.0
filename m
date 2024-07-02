Return-Path: <linux-pci+bounces-9603-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B9B9246D3
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 20:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA1B71F26057
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 18:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387EE16B394;
	Tue,  2 Jul 2024 18:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="aY/czv/6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9731C0DC9
	for <linux-pci@vger.kernel.org>; Tue,  2 Jul 2024 18:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719943265; cv=none; b=FvVSVew7dk7FKWaqBqQ4f2efjyyI5eb7ZTtiWf8ZB8cUSoV08g9BRKcQYnwrcYy0qweIpG/b0Tgdggbj8EmQivDoeqVmg2gU4ljby/ZLFsFW29aJMlE0CT5t5hPQyqTjME2Uit7/+B1EQL3fy5ZSmzR2HjAu//GsZ9aWc4oSfAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719943265; c=relaxed/simple;
	bh=kkk+18D6HhFB3odNtIldrjiYxcFuE4z8q+l57h14CsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ak3H005MegrPkgnrokrJwWzg+v1CGmZXZI62UDp2LaQ+/tcU53C9Ez6zR6JUulKQg88AaMk/1hZW7djRN4fDdgkDDtmAJGhlcSQSoVVN87iANgFvl2xnm8POTN05avYDb/vlaQXHSetBplsISmnNAG0gY6v2aZfKV1URmhGZPfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=aY/czv/6; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52e7145c63cso4838645e87.0
        for <linux-pci@vger.kernel.org>; Tue, 02 Jul 2024 11:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1719943261; x=1720548061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sKnWasz019XWbKpY8JDNjxDoiZJi0JBpRkDvY6AW8TU=;
        b=aY/czv/61EnxXtMlJceXV+wDGDTN1kmhZ+V2IwbsxrqgKHq/C4vOmtoCUKF8buhNNI
         X3yjApMPMFtTaHPylY8cYDjDQVK/Fvt4/D6wjiyoFvQcBHgjPU05i7JzwFJSshDNYAO2
         UgbAVjiTwvAKWqbHpJNIDlebNnTGaMXYsM3pw/Xpdx8bdahFbsnKEJaOw3JCUrez43Nh
         ZSdqs5cNhIJmlbg+TpjXt0o/jdxPS2vLMWaD7G+hUoKTJMSNuGLsjNSOi8MuD2hU6gnd
         1N9f4OYP04L9+LzLryThfv7KQ1EbWBgoepOeoickqbB3Gn90XkCpNUgFjMhbL2yDq0bn
         cO7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719943261; x=1720548061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sKnWasz019XWbKpY8JDNjxDoiZJi0JBpRkDvY6AW8TU=;
        b=HQeN4h3RG883CnAXk/1fIwSJWgSFT8LyxWf0udSkBtl7LCqiK1Qn2YNDZhOLWyPyvH
         Uf7AbVzoZMelx1l+okXlvj63u+y4FVH3kB6ln7oJDS1gOFNCcHIu8rHWr7vMfFGro+ec
         yxlPSo94BH0bIa7mWuMpGaUtx8EYPS3BL2fdF2vUA6HlWCUMWAR16Z6i2OcpFZn8kWX/
         eDPVLoDYr9xM7SK2RYKSrS6ELqXbRnP6Zb31DnQ37n+WH1DF+oumASFnStI6axcRat6H
         7y1V/1hUDlC0UXBxKHauH2V+ev/y0EjvxL5Y3UWzdOjNbtx+vNOB3C9DRjViI9McoZ8Y
         8OQA==
X-Forwarded-Encrypted: i=1; AJvYcCXH0fhu+0317Zi4SHyMXdAQSDPJWWIyoHAkdPvwbap3uHMumKvZ5AI1AC+tweiCsY/rowItnNrKjofdsXbDEGt3H1G38the4uY8
X-Gm-Message-State: AOJu0YwWA8cvXzpD7HB+ympCQZAB/POuhvDMSeD7z5MvayAQ6xJah0Sj
	Gjtj6yc0PlD8aEgM2GY53Kil/vFdhFPPB1IFSUjhxgGPkPIxr9S/MB6MpaoCuzpSUiqCfuKvo8u
	CovAW1Ie0NFE5Sdl9wLowI9vWCxYoGSqzDpJaJQ==
X-Google-Smtp-Source: AGHT+IGj6gnbb3k6BOFN8B1zCkyv+bXntzux6J3q7+mN1aD56dPlbThJPM72pIoJryrNFkZyrexSAN/Zmu9KJEVHVTI=
X-Received: by 2002:a05:6512:31c9:b0:52b:faa1:7c74 with SMTP id
 2adb3069b0e04-52e7b8dedb3mr4684885e87.5.1719943260686; Tue, 02 Jul 2024
 11:01:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702173255.39932-1-superm1@kernel.org>
In-Reply-To: <20240702173255.39932-1-superm1@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 2 Jul 2024 20:00:49 +0200
Message-ID: <CAMRc=MfBJi2BGZxfLHgbu2AgRyZ9Z_smWMCy_hD6HuW3HxrNsw@mail.gmail.com>
Subject: Re: [PATCH] PCI/pwrctl: Decrease message about child OF nodes to debug
To: superm1@kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mario Limonciello <mario.limonciello@amd.com>, 
	Amit Pundir <amit.pundir@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Caleb Connolly <caleb.connolly@linaro.org>, Praveenkumar Patil <PraveenKumar.Patil@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 7:33=E2=80=AFPM <superm1@kernel.org> wrote:
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> commit 8fb18619d910 ("PCI/pwrctl: Create platform devices for child OF
> nodes of the port node") introduced a new error message about populating
> OF nodes. This message isn't relevant on non-OF platforms, so downgrade
> it to debug instead.
>
> Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Cc: Amit Pundir <amit.pundir@linaro.org>
> Cc: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD, SM8650-QR=
D & SM8650-HDK
> Cc: Caleb Connolly <caleb.connolly@linaro.org> # OnePlus 8T
> Reported-by: Praveenkumar Patil <PraveenKumar.Patil@amd.com>
> Fixes: 8fb18619d910 ("PCI/pwrctl: Create platform devices for child OF no=
des of the port node")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/pci/bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index e4735428814d..f21c4ec979b5 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -354,7 +354,7 @@ void pci_bus_add_device(struct pci_dev *dev)
>                 retval =3D of_platform_populate(dev->dev.of_node, NULL, N=
ULL,
>                                               &dev->dev);
>                 if (retval)
> -                       pci_err(dev, "failed to populate child OF nodes (=
%d)\n",
> +                       pci_dbg(dev, "failed to populate child OF nodes (=
%d)\n",
>                                 retval);
>         }
>  }
> --
> 2.43.0
>
>

Ah! I was under the impression that of_platform_populate() would
return 0 with !OF but it returns -ENODEV instead...

Maybe do:

if (retval && retval !=3D -ENODEV) and keep pci_err() here?

Bart

