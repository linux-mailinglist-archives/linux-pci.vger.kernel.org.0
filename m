Return-Path: <linux-pci+bounces-36325-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FA9B7DD8B
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 14:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB6C15281E9
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 07:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D7E2D063E;
	Wed, 17 Sep 2025 07:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2bA9PIi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9498C27A468
	for <linux-pci@vger.kernel.org>; Wed, 17 Sep 2025 07:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758095158; cv=none; b=mYOaSDpdvpI3xrHAs1zr8N4qb22fZ3UxssauExNpsQY/v/f1ZTZzcOlF7c1jJmL1c4IhsTJ/dn1VNZ/bHMKIwN/KHw1GCpmNEOWnY67LJaWS+67XJmqVSsdr9RQokntDz4rD+LZC7JIrS+LfLCBZDMijXLsrDpqwI3QhFHpqvO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758095158; c=relaxed/simple;
	bh=SlDlinNGQSd4RKi+Cnb+PiszIRO+bkn3SZ1hom0FQ/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EIN14Dndlz+puKNq0pmrTExU1JM/ZgTbeyIShCHtCJgQEQEB4p/dqROafRmIeWW2/K9T72LiiyDEr9SLNRezoVyN8peIxAHd02px1VAP+1Qwc88EeWKHUTEvRrI+NJ4PVDNw+KkQ1L0JLsoCngnCiTyQT9Otht99l4diY6oXv9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z2bA9PIi; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b04ba3de760so791537366b.0
        for <linux-pci@vger.kernel.org>; Wed, 17 Sep 2025 00:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758095155; x=1758699955; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w/PV3sQX3P2aZwX4RWrb0glEbtXd1xtTrstBqiLxQHM=;
        b=Z2bA9PIiL8GrdzEus/SWx08BwSEjAJQIN+1c3/BShmtv3WbO/mh3elFr+i9ZolKs+i
         alsLMzd6uiwNUUHhNQTb5plrpj/nB/AmuD86O5+CDYO+rW4CIKAcFksGUZsf2BQgMwFp
         c3kRy2R9GZnoYg1tfREdg4tMET3ZebNkiDylvHmSrGBtcxwHJVGbOr851GX37GFt0vGw
         NMv1QIdARyPCzZhdOFtckwB0Vm/DDOq/+y7kqNs0VI8by5CGNRAqL9SGl+ke83ndq6Kf
         W/xWszcYOAzZktXImJCNZvN48P3mdcJTH0hKI2fHcoX0tTEzAm0ibelI/kH27JlIRsKm
         ElzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758095155; x=1758699955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w/PV3sQX3P2aZwX4RWrb0glEbtXd1xtTrstBqiLxQHM=;
        b=NlKJpm7LZ53wxvjYr/9HfYfp9fjfT4bZe4/Jg76JrVtgEN8F+Mrada06aiGApad2OP
         pIC81INRMQsMJ+oj82+r6l/VrpU224yvPduKOWfel21kn0NzFeu/d9tp1sM4Bz+AHt7i
         55MwYHTPzIQ0C6kxt2ZHaxZRiwrGEEhu2CxhoUWZzJdJ3Qwd/yLQdrOasbm2nFN5kmXA
         L++LOIenDdaILpBPrVbfPUrq16qSV65xx6vNfcdy4ssOO1bbPq0u4L66gj2tUN2tMwTo
         fLi8uWVVKhUb2pG5DvXsD86Yzdvrl29IfgMNhUm4nnLDDIieVqcY8M+z7ARoqUhY2kdA
         WyEA==
X-Forwarded-Encrypted: i=1; AJvYcCWUyKDcL7P+hWxdr39v3zLMNbk2MBLjDluIre3tTwhymtSj7Vz0Q56EVv4/CpIHIMF5R9Mjczo3ZiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG0aWYS6S0YcaFoPabcN3+DCm9IGFJRTNfcN528ytqKCFe1A3w
	kqEIaaaxPM8Ax6HjmwxBOmeAFEij8Bz+ZQcCVWEkOLs6PGI6eDgSs3mB7XQZ2GZCuC77tJhSYsv
	7EdBXCogpFibK8V9Ni58j3eX6jdDLrco=
X-Gm-Gg: ASbGncv/Jd0A2eCSDj3UfSnPBn06pE00IA/Uu5nbD+BqlBx52/nWQ7RzB1vPpTZNWTg
	sSbXYV5zbRuW77oJwbiAW1BFkyU9pveZVl9d8FQAeMpArnoGO3AiI9hT2I4qVmsg3Gc6xDPjjWM
	molcAHfUX7XmYwvIvTekfv2kdyMrXxCC7paTeqYIBoK5qakZhGP0XHm5DMy//yF/91DyGjF/Gm+
	Qzfnw==
X-Google-Smtp-Source: AGHT+IE9zwmB6T7HEwi/+2ayzNjx1SmehnWY6rCgBsjF2Nwg90YsxIP+l4GYaGbvKGpfrd7ZhTKSZ48vhQWnDoaNQa8=
X-Received: by 2002:a17:906:f59b:b0:b07:c6ad:9e4a with SMTP id
 a640c23a62f3a-b1bb216c252mr145352066b.15.1758095154712; Wed, 17 Sep 2025
 00:45:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250831190055.7952-1-linux.amoon@gmail.com> <20250831190055.7952-3-linux.amoon@gmail.com>
 <23013855.EfDdHjke4D@senjougahara>
In-Reply-To: <23013855.EfDdHjke4D@senjougahara>
From: Anand Moon <linux.amoon@gmail.com>
Date: Wed, 17 Sep 2025 13:15:38 +0530
X-Gm-Features: AS18NWCJA1J4Xmz0s7LUPixHFdxkhk-KMYeQL9MPiR3KsxNtmZnw_0SMpEnwE18
Message-ID: <CANAwSgT615R32WTBzi2-8FYntmaxbmVRLmA3yi+=4ryH43aaWQ@mail.gmail.com>
Subject: Re: [RFC v1 2/2] PCI: tegra: Use readl_poll_timeout() for link status polling
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, 
	"open list:PCI DRIVER FOR NVIDIA TEGRA" <linux-tegra@vger.kernel.org>, 
	"open list:PCI DRIVER FOR NVIDIA TEGRA" <linux-pci@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mikko,

Thanks for your review comments.

On Wed, 17 Sept 2025 at 08:51, Mikko Perttunen <mperttunen@nvidia.com> wrot=
e:
>
> On Monday, September 1, 2025 4:00=E2=80=AFAM Anand Moon wrote:
> > Replace the manual `do-while` polling loops with the readl_poll_timeout=
()
> > helper when checking the link DL_UP and DL_LINK_ACTIVE status bits
> > during link bring-up. This simplifies the code by removing the open-cod=
ed
> > timeout logic in favor of the standard, more robust iopoll framework.
> > The change improves readability and reduces code duplication.
> >
> > Cc: Thierry Reding <thierry.reding@gmail.com>
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> >  drivers/pci/controller/pci-tegra.c | 38 ++++++++++++------------------
> >  1 file changed, 15 insertions(+), 23 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controlle=
r/pci-tegra.c
> > index 3841489198b64..8e850f7c84e40 100644
> > --- a/drivers/pci/controller/pci-tegra.c
> > +++ b/drivers/pci/controller/pci-tegra.c
> > @@ -24,6 +24,7 @@
> >  #include <linux/irqchip/chained_irq.h>
> >  #include <linux/irqchip/irq-msi-lib.h>
> >  #include <linux/irqdomain.h>
> > +#include <linux/iopoll.h>
>
> There is already an iopoll.h include in this file, so this adds a duplica=
te.
>
Opps, I missed this in rebasing my code.

> >  #include <linux/kernel.h>
> >  #include <linux/init.h>
> >  #include <linux/module.h>
> > @@ -2157,37 +2158,28 @@ static bool tegra_pcie_port_check_link(struct t=
egra_pcie_port *port)
> >       value |=3D RP_PRIV_MISC_PRSNT_MAP_EP_PRSNT;
> >       writel(value, port->base + RP_PRIV_MISC);
> >
> > -     do {
> > -             unsigned int timeout =3D TEGRA_PCIE_LINKUP_TIMEOUT;
> > -
> > -             do {
> > -                     value =3D readl(port->base + RP_VEND_XP);
> > -
> > -                     if (value & RP_VEND_XP_DL_UP)
> > -                             break;
> > -
> > -                     usleep_range(1000, 2000);
> > -             } while (--timeout);
> > +     while (retries--) {
> > +             int err;
> >
> > -             if (!timeout) {
> > +             err =3D readl_poll_timeout(port->base + RP_VEND_XP, value=
,
> > +                                      value & RP_VEND_XP_DL_UP,
> > +                                      1000,
> > +                                      TEGRA_PCIE_LINKUP_TIMEOUT * 1000=
);
>
> The logic change here looks OK to me. This makes the timeout 200ms (TEGRA=
_PCIE_LINKUP_TIMEOUT is 200). Previously, the code looped 200 times with a =
1 to 2ms sleep on each iteration. So the timeout could have been longer tha=
n 200ms previously, but not in a way that could be relied on.

You're right; the original usleep_range(1000, 2000) had a variable sleep ti=
me.
To replicate the worst-case behavior of the old loop, the
readl_poll_timeout should
use a delay_us of 1000 and a timeout_us that matches the original
maximum duration.
Since the previous code looped 200 times with a maximum 2ms sleep,
the correct timeout is 400ms, so update (TEGRA_PCIE_LINKUP_TIMEOUT * 2000).
or increase TEGRA_PCIE_LINKUP_TIMEOUT to 400.

Are these changes ok with you?

Thank
-Anand

