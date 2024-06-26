Return-Path: <linux-pci+bounces-9315-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F7991856E
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 17:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BF6F1F28A9D
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 15:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F31218A928;
	Wed, 26 Jun 2024 15:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="V+Kq4D3L"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5851918A921
	for <linux-pci@vger.kernel.org>; Wed, 26 Jun 2024 15:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719414769; cv=none; b=M++qfiQEDLOMJUStxQ7lrrjL8D3cab4A1yEHvzD9XNn+RDBRH+r4Se0bp4g/ib3AjiSkvl+njQGu/CEMpGteEHKbl9oPdiFgl1pWKqGKZc9jeJuiSwB4agVceVH84uRYXFWO1G4rAu1XZqV3gHIoTZNpYGcMzNs0Qq5fJHaC2FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719414769; c=relaxed/simple;
	bh=ji9wlxtKwMxWXq1BEzbpjW+SobuU0R+NcWHJDJAG8YY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bPhAJO2yulZibcq0PYW0UlOszjatWwzHgMvMmtNSirYScv0lYqhhtlh05s6EYwnZbfRAVvuwjfQVISMUZJSrxyPNytMUssMs8ksa+WQ1N1y206sZ2Oycus1yUvgUNc+laWG5kQqGQUxBayJl/Fn7ig6/kJ31IXo1ayi3oEqYLSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=V+Kq4D3L; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ec1620a956so81898011fa.1
        for <linux-pci@vger.kernel.org>; Wed, 26 Jun 2024 08:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1719414765; x=1720019565; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3C1oLQ+aqDrn6tGBImihLzkMhOaXEA1cLdKh4bi3OtE=;
        b=V+Kq4D3LY6luvWLoHBWiw1tMYoCPk+xPMLUVtZryNou4j5Y9mQgnck4pgdcadMuZmH
         9ueJKRuCnGjbYhP1Fw4VJGML5gJteALYwpuiY1NBbEsfkhVncRMlrQWa6PCW7m1BD9mG
         T9MC5KFgSw7BY2V9bMDQn7XYHJDEvH/2Xfig/sfeVdln71ZNrQv4vrBCNJ9rP/2T1WE7
         J/kzilDDEpQ+9qjAkT9hEPQjbJIfj8BzV704uA/KSayFpstwt154jWvdRrQD7bFe0Bwu
         MUSCx42yZ+tdNh26wtVPkOzLW0/L8cpZsGFgeHTJz3YYz5a/79iX1Nk0euIU44bpzQJJ
         AhZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719414765; x=1720019565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3C1oLQ+aqDrn6tGBImihLzkMhOaXEA1cLdKh4bi3OtE=;
        b=T2fvjo+cG+Fu/GeXRlP755XFW2S9QINjVb18OIVI93Mo2sfIoGi7RJDSnicdqkLANf
         fh/hutPRCr+s1R52z2ZzwjLZEqB0O3sNimzFLo1NxAz+l7n55Vn8yylZASS7QaNxPlmP
         ZYZ10PuDB9qtNsMT7Vg67arASDBThwkGP5YMuDMCISlzWrPADaxkjGkVu7IuqeFvElAZ
         BYQQCa27TKVpXbbf20eLoLU8inRKbrlwRetvIoqHRl6qC7fKK85I5GjNCdpnpPmeKOSm
         fBTA/JRU3UGSdbQRV1kqlud7dmqmZSUH5BcfbNjW9RvE5RR/8uRwEDhHYCarZazZM15E
         KiIA==
X-Forwarded-Encrypted: i=1; AJvYcCVb8mY8xvv/9404/6KE4n65OWc4tZlSH3RF1vvH8/r6hPoQDnnZhzgQWKNLzI0jNCHZ+oRPEQlgKnlbPiyG/3O6pLGXuFgeDYae
X-Gm-Message-State: AOJu0YxfHho4WCwYrmbpBvaOSLOv+BSujHLeb8659Q+huWuOdIkFkdG8
	KxRDdazsCr04D3HtbQ7YBg5AMMov2/ZltKYu+AFPVua85XsD+MxnaJrAXOzaZfd0E2cUBYkU7pq
	fzCtiYYxcvP0YPmmwi6ypARD6Xwoxnlp/7/GM+g==
X-Google-Smtp-Source: AGHT+IHRyUNC6ZVXzXSpSRcK72OjcQYnCiP1oY+9P1xuHjKDTBgiszXyrmikiisVy7BQ6tcXwO3JPVl9Xr0Dq8EePVs=
X-Received: by 2002:a2e:97c7:0:b0:2eb:e787:47ea with SMTP id
 38308e7fff4ca-2ec5b333198mr62069821fa.12.1719414765274; Wed, 26 Jun 2024
 08:12:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626-qps615-v1-0-2ade7bd91e02@quicinc.com> <20240626-qps615-v1-3-2ade7bd91e02@quicinc.com>
In-Reply-To: <20240626-qps615-v1-3-2ade7bd91e02@quicinc.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 26 Jun 2024 17:12:34 +0200
Message-ID: <CAMRc=McuQ_UXaSafePSJqqRvDV_bMQfs-P_FeEBX6WzXyTfSSA@mail.gmail.com>
Subject: Re: [PATCH RFC 3/7] pci: Change the parent of the platform devices
 for child OF nodes
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Jingoo Han <jingoohan1@gmail.com>, quic_vbadigan@quicinc.com, quic_skananth@quicinc.com, 
	quic_nitegupt@quicinc.com, linux-arm-msm@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 2:38=E2=80=AFPM Krishna chaitanya chundru
<quic_krichai@quicinc.com> wrote:
>
> Currently the power control driver is child of pci-pci bridge driver,
> this will cause issue when suspend resume is introduced in the pwr
> control driver. If the supply is removed to the endpoint in the
> power control driver then the config space access initaited by the
> pci-pci bridge driver can cause issues like Timeouts.
>
> For this reason change the parent to controller from pci-pci bridge.

Newline before trailers please.

> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  drivers/pci/bus.c         | 5 +++--
>  drivers/pci/pwrctl/core.c | 7 ++++++-
>  2 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 3e3517567721..eedab4aabd81 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -335,6 +335,7 @@ void __weak pcibios_bus_add_device(struct pci_dev *pd=
ev) { }
>  void pci_bus_add_device(struct pci_dev *dev)
>  {
>         struct device_node *dn =3D dev->dev.of_node;
> +       struct pci_host_bridge *host =3D pci_find_host_bridge(dev->bus);
>         int retval;
>
>         /*
> @@ -356,9 +357,9 @@ void pci_bus_add_device(struct pci_dev *dev)
>
>         pci_dev_assign_added(dev, true);
>
> -       if (pci_is_bridge(dev)) {
> +       if (pci_is_bridge(dev) && host) {

I know I told you to check the return value of pci_find_host_bridge()
in private but now after a second look I see it's just a multi-layer
wrapper around container_of() and it looks like it cannot fail so -
correct me if I'm wrong - this can be dropped after all.

>                 retval =3D of_platform_populate(dev->dev.of_node, NULL, N=
ULL,
> -                                             &dev->dev);
> +                                             host->dev.parent);
>                 if (retval)
>                         pci_err(dev, "failed to populate child OF nodes (=
%d)\n",
>                                 retval);
> diff --git a/drivers/pci/pwrctl/core.c b/drivers/pci/pwrctl/core.c
> index feca26ad2f6a..4c0d0f3b15f8 100644
> --- a/drivers/pci/pwrctl/core.c
> +++ b/drivers/pci/pwrctl/core.c
> @@ -10,6 +10,7 @@
>  #include <linux/pci-pwrctl.h>
>  #include <linux/property.h>
>  #include <linux/slab.h>

New line here, please.

> +#include "../pci.h"
>
>  static int pci_pwrctl_notify(struct notifier_block *nb, unsigned long ac=
tion,
>                              void *data)
> @@ -64,18 +65,22 @@ static int pci_pwrctl_notify(struct notifier_block *n=
b, unsigned long action,
>   */
>  int pci_pwrctl_device_set_ready(struct pci_pwrctl *pwrctl)
>  {
> +       struct pci_bus *bus =3D pci_find_bus(of_get_pci_domain_nr(pwrctl-=
>dev->parent->of_node), 0);
>         int ret;
>
>         if (!pwrctl->dev)
>                 return -ENODEV;
>
> +       if (!bus)
> +               return -ENODEV;

This - on the other hand - can fail, so the check if valid. Could you
assign it and then test it in a single spot for better readability?

Bart

> +
>         pwrctl->nb.notifier_call =3D pci_pwrctl_notify;
>         ret =3D bus_register_notifier(&pci_bus_type, &pwrctl->nb);
>         if (ret)
>                 return ret;
>
>         pci_lock_rescan_remove();
> -       pci_rescan_bus(to_pci_dev(pwrctl->dev->parent)->bus);
> +       pci_rescan_bus(bus);
>         pci_unlock_rescan_remove();
>
>         return 0;
>
> --
> 2.42.0
>

