Return-Path: <linux-pci+bounces-3914-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F12861048
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 12:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 536A7B21968
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 11:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50932633E9;
	Fri, 23 Feb 2024 11:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VM8g6I7J"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CCF627FC;
	Fri, 23 Feb 2024 11:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708687509; cv=none; b=l/pBwv8YD1hhh59SiX3Hh/m8tKADfExOfCw6hfzTwk8bQFrFKbLbc8lCgpxTWS8OqiPqec9uVVC4UjTFx1NPBmGDy+Fip5PnscQmqDzrGlzP54kOqxF2aug+K5oD53pL4US/7TRcpT2wJkAv7Hde4QmIreLUbeMpFdLyXv6vfFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708687509; c=relaxed/simple;
	bh=kwlnWMKwqe/VZS7s01t/VjKri9FYL6WtJGJRcybmxJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kT/CPXZS+eWg56sxb4Njg8L3F+tncLI18llNVhB7p7JU+fQ/a/Nyc0qil3qRvkpXbBZXD+KooHG5bhKWK6F0+dOQoQ43ccO9ZtQxz94/F+k9Pl1vCBSKsGS8Z3FZDhEbaXBfIKwnPAFXq9W4y69gFvUC9XMzXAvpESCKndgIwH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VM8g6I7J; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-21eea6aab5eso100679fac.0;
        Fri, 23 Feb 2024 03:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708687506; x=1709292306; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HXq9gtaixlPPlxeYNVBBekla+96XUpC/xgFnv8Gi6Og=;
        b=VM8g6I7JvJzg5W34BdjQ2DAxwWdBkPoKqP+uPbr+sajjJr3jIEcdonTGxCuPldPjN6
         Hs41rfWQUpl15eUpMdj6i4rW2BA4LGEKScO8+beEqhFQSamHY1X/8MjRVPhx76OXrLvF
         lBaW+5++zXproFXyURxePF4v3OVcid0t9MqMoNvV71jGzA7bAVW5OKmdLx78MM1uddLZ
         RD9bKATIznKYgKjQSKG7CIvOJ/Cx7ZyvRGS1/N479XQPAcH7c7FmKlhruLkVXjk0VxOZ
         MvNwGjPfnw1UiIjXcnjvvV5KIqhQJGwL5Mg8WxZWsb0x0WCW7CgJ4Omn8d8hqh5aPFKE
         zMhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708687506; x=1709292306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HXq9gtaixlPPlxeYNVBBekla+96XUpC/xgFnv8Gi6Og=;
        b=CZtmoHlr+v4R7zcQtEQaheDC/qsQSVIIiewHnx+VynFEd9MZdkPUsrgHXyvM90kQO5
         KFFSW4Ztb91quQbk7LDE5BzMfOPQ494jhtDUDUwB52h+s93r/jM52iKmKp0aN/v80R+2
         2ephtJvxzBiMZvsX5WbwAwdw2QTUxlHDdldh/IsohQ96UWAiB6rJGP2cub18/n1sZ9Bg
         1ccBscTBoFFeL9v0uU5RMVGZQwnxySRxJLu+6r3l17kUZIOsIVkyLsGwebqw1COkiUwG
         rIQwK7iW7S/D9Gg8yIS7CNhKG8pkyTT3ECnoYJaqR3lC6/rUaMvmJI3kXksEHia2XOw/
         kJYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXG3eUZrqFKXsx1gyC1kXVvJNTjlbTasa87inmUp+3QJJ1Or+GduXb/pPG8CzQGCTcvcazbpAbBQJpCYFFSTidvya6QK6lSKJIg1qZ5
X-Gm-Message-State: AOJu0YzyRq3bMqNqRHDud3UmBBtORyHqmyJPHGyeV+bZnOWjkMlhu2X2
	l3wdHrTbk9SySQrnEwieKA0w7Xe4TatHFJmuBr4SXmzaxFAVeCiL1cr0aMeoAToEg99gwyQdveh
	RuLiMP55s4RKjJ4G4GXzD4BFyaSfyBEL7
X-Google-Smtp-Source: AGHT+IELKXL4lOnAECyKeuiwWmv2laqK/6mYRv/GITMbekabCwned9k99ADdDnL7P79u0FjEkWClvyPmjwEwJSjFZJc=
X-Received: by 2002:a05:6870:8087:b0:21e:673f:96cc with SMTP id
 q7-20020a056870808700b0021e673f96ccmr1747204oab.51.1708687506353; Fri, 23 Feb
 2024 03:25:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111082704.2259450-1-sergio.paracuellos@gmail.com>
In-Reply-To: <20240111082704.2259450-1-sergio.paracuellos@gmail.com>
From: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date: Fri, 23 Feb 2024 12:24:54 +0100
Message-ID: <CAMhs-H-Nab+NAcdZ4+VoiikzXgDH55USREhYA6=6xd6ac_OCww@mail.gmail.com>
Subject: Re: [PATCH] PCI: mt7621: Fix possible string truncation in snprintf
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, 
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Bjorn Helgaas <helgaas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jan 11, 2024 at 9:27=E2=80=AFAM Sergio Paracuellos
<sergio.paracuellos@gmail.com> wrote:
>
> The following warning appears when driver is compiled with W=3D1.
>
> CC      drivers/pci/controller/pcie-mt7621.o
> drivers/pci/controller/pcie-mt7621.c: In function =E2=80=98mt7621_pcie_pr=
obe=E2=80=99:
> drivers/pci/controller/pcie-mt7621.c:228:49: error: =E2=80=98snprintf=E2=
=80=99 output may
> be truncated before the last format character [-Werror=3Dformat-truncatio=
n=3D]
> 228 |         snprintf(name, sizeof(name), "pcie-phy%d", slot);
>     |                                                 ^
> drivers/pci/controller/pcie-mt7621.c:228:9: note: =E2=80=98snprintf=E2=80=
=99 output between
> 10 and 11 bytes into a destination of size 10
> 228 |         snprintf(name, sizeof(name), "pcie-phy%d", slot);
>     |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Clean this up increasing destination buffer one byte.
>
> Reported-by: Bjorn Helgaas <helgaas@kernel.org>
> Closes: https://lore.kernel.org/linux-pci/20240110212302.GA2123146@bhelga=
as/T/#t
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---
>  drivers/pci/controller/pcie-mt7621.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/pcie-mt7621.c b/drivers/pci/controlle=
r/pcie-mt7621.c
> index 79e225edb42a..d97b956e6e57 100644
> --- a/drivers/pci/controller/pcie-mt7621.c
> +++ b/drivers/pci/controller/pcie-mt7621.c
> @@ -202,7 +202,7 @@ static int mt7621_pcie_parse_port(struct mt7621_pcie =
*pcie,
>         struct mt7621_pcie_port *port;
>         struct device *dev =3D pcie->dev;
>         struct platform_device *pdev =3D to_platform_device(dev);
> -       char name[10];
> +       char name[11];
>         int err;
>
>         port =3D devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
> --
> 2.25.1
>

Gentle ping on this patch :)

Thanks,
    Sergio Paracuellos

