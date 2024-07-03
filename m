Return-Path: <linux-pci+bounces-9706-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B49949256D0
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 11:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E0A5281650
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 09:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFE3136E3A;
	Wed,  3 Jul 2024 09:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="vmt1uvqK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96511755B
	for <linux-pci@vger.kernel.org>; Wed,  3 Jul 2024 09:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719999140; cv=none; b=XbYLRqB5fRDb3eY+cD/NPW3QxvcGoSMO9JTTtj6Go4nSN3GcuA2JBqW+mga9dWlSmZbVgdhVIwYgcke9aiEWI5bl6LMVnEABwyvywyxPzmRMtsiJCveULBqx4CSC0l8EYSdwvQjcVXkpw63wu2pOohzdW2cdRRG+9ZoJ1uBtnG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719999140; c=relaxed/simple;
	bh=wxNTZ9QPmv/pOHH5Udq9kaG7vGTr4w1mp6WoX2yWyRo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sZoF7CCP83nrhLIT+GYHGVNN1Zfm/2R+w6AQWFaWPuA48TOKRe/2CyU0ifNPA7NgBAjxNzan3/p0dekKVKH9DpY4tnRMkMKCFyJ4M4/B/okJTCMmvpgMdLVMWjKEt7Rwa1az68tGZd/ZrwsXZS0oTKLp/g7kELj5DiAOnT0L120=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=vmt1uvqK; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ec1ac1aed2so60972981fa.3
        for <linux-pci@vger.kernel.org>; Wed, 03 Jul 2024 02:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1719999137; x=1720603937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RZAn7gmriISgeIoJJsOcj52E6C/GbJNEpwWf2THjDNo=;
        b=vmt1uvqKCg6aw4oUA0C+i2JpAChj2UPu8860Ye/iyo8CXKVCU82AxC5gTzbo44E6KW
         cxZwSeUl+e6EKI5MWF15S7d4gmEOS1tnLuosvIkjbj1qa2/bbo+O35DMQfqUFWfQ36m+
         Zg++/qyV2eQCy1DeBJ2mpLKrzuEjAQampW1AHVkXA0500s7Jcd2oa4DqR4YW24Acy3gz
         FnWXaH8Jku5u2ynBJq0lGP5E0+zeU7ar9EKGbbFMnZ8AUteUGqya70ozKcKnA69e9wub
         NxisPSPyv9aCAupn9yCT2FrBwMGqHJP8GYAfhGC+C5Nnhnx2RKjUQo+38g7qMoFS/s5T
         lJgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719999137; x=1720603937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RZAn7gmriISgeIoJJsOcj52E6C/GbJNEpwWf2THjDNo=;
        b=lBiwozSZA0xFPVMQV2rJVv0NwJ+K3QBv3E/RBWNn4GEYYxl7VXXibqytFmno73SUbq
         q66RGdlkyT7W3vnESlN2AaBA8eL+ExK0dxOY+Lxn5Wnlc+l4Yn4/M6bWO0KahXYhYyPo
         WRDBtvwrOZGHjFiogDjtEk5pMnHnVkO9G8G3MFANhkdDlaqzcm4hFRqmdV/TrusZV+b+
         QzH19K/ka14gwLSV5ZeTSLEJa/vHk4Hq7fRRa3qtwNBHdbrV/qSEeSZ+arNxo9Y2DdLf
         dC7F/QAqGQ+ITO134gtdh42aQAqhVKU6/IATvVCTfsw2Vvpk+pHf8BzQMUuSpCKYsUZu
         B9yw==
X-Forwarded-Encrypted: i=1; AJvYcCWXnaiLiFqME4nKW4jDEpcSgAdJH064OysdXL7ThRt0zlv/mrYlysDiXKKk2vYzXLkKnAb/1PfrDOB2B8758SVKEJK8Y/9NmYZB
X-Gm-Message-State: AOJu0Yz0Uet5PqjDeERNTOGa2e/UvwuXkrdjam7hcMVTf87R1e95Wa2b
	0LzXxcUECnPJ9rJGbMadKN9zq7KEBgosLhG5SkNtP83StifVZ5nQP5jyWH3krVszv290Xs7tcy5
	dZMLauuqA2bLtJmWo4e1kQ0JjRC/d+DH84Vqt9A==
X-Google-Smtp-Source: AGHT+IHP41wi4C+FB8VM4BV/A8lqsduH/pzzkvBBD5gkvGC7yWBrX1owIGvGiTiPL5Irzwb3wJnVgKJK7S7IeZ1QTNo=
X-Received: by 2002:a2e:a5cb:0:b0:2eb:e258:717f with SMTP id
 38308e7fff4ca-2ee5e6e01b1mr75953791fa.42.1719999136936; Wed, 03 Jul 2024
 02:32:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703091535.3531-1-spasswolf@web.de>
In-Reply-To: <20240703091535.3531-1-spasswolf@web.de>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 3 Jul 2024 11:32:05 +0200
Message-ID: <CAMRc=Md=PnpHVGGO6Nb_efVZ0a3cMxWbLvYmkka5Wznks70drw@mail.gmail.com>
Subject: Re: [PATCH] pci: bus: only call of_platform_populate() if CONFIG_OF
 is defined
To: Bert Karwatzki <spasswolf@web.de>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, caleb.connolly@linaro.org, 
	bhelgaas@google.com, amit.pundir@linaro.org, neil.armstrong@linaro.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 11:15=E2=80=AFAM Bert Karwatzki <spasswolf@web.de> w=
rote:
>
> If of_platform_populate() is called when CONFIG_OF is not defined this
> leads to spurious error messages of the following type:
>  pci 0000:00:01.1: failed to populate child OF nodes (-19)
>  pci 0000:00:02.1: failed to populate child OF nodes (-19)
>
> Fixes: 8fb18619d910 ("PCI/pwrctl: Create platform devices for child OF no=
des of the port node")
> Signed-off-by: Bert Karwatzki <spasswolf@web.de>
> ---
>  drivers/pci/bus.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index e4735428814d..b363010664cd 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -350,6 +350,7 @@ void pci_bus_add_device(struct pci_dev *dev)
>
>         pci_dev_assign_added(dev, true);
>
> +#ifdef CONFIG_OF
>         if (pci_is_bridge(dev)) {
>                 retval =3D of_platform_populate(dev->dev.of_node, NULL, N=
ULL,
>                                               &dev->dev);
> @@ -357,6 +358,7 @@ void pci_bus_add_device(struct pci_dev *dev)
>                         pci_err(dev, "failed to populate child OF nodes (=
%d)\n",
>                                 retval);
>         }
> +#endif
>  }
>  EXPORT_SYMBOL_GPL(pci_bus_add_device);
>
> --
> 2.45.2
>
> The mentioned error message occur on systems without CONFIG_OF, i.e.
> x86_64. The call to of_platform_depopulate() in drivers/pci/remove.c
> does not need #ifdef CONFIG_OF as the return value is not checked (it
> will most likely be optimized away on platforms witout OF where the
> of_platform_{de,}populate() functions just return -ENODEV)
>
> Please CC me when replying, I'm not subscribed to the lists.
>
> Bert Karwatzki

There's a better (less ifdeffery) fix on the list that I'll pick up
later today[1].

Bart

[1] https://lore.kernel.org/lkml/20240702180839.71491-1-superm1@kernel.org/=
T/

