Return-Path: <linux-pci+bounces-7038-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCBA8BAA13
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2024 11:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93529B209A9
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2024 09:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D93E14A601;
	Fri,  3 May 2024 09:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CO+KsKW7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C7D14F134;
	Fri,  3 May 2024 09:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714729372; cv=none; b=n1do83+l/KmUqPk5HRBXl8xWj2/62BvmGE0es2iVG0xWDg2SOPcNi9l/+yQk9CV6KJMmXbMbzwiuB15r3gtFwuRlCbSw9DlZJKkBvWYrhOaVq00immp22rKW2CkijHW50aqu9MKNLv80lbghhhrKp3OYHbLI8UeQXZO1V3Aic2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714729372; c=relaxed/simple;
	bh=vAkeSvwTfuryQcOcS4QPlGjT1AW22DjrKxga/xC2nPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vBTreP5XUGXqzcUVZfUT3XjQ1CETVwBTdAsH4nmFBmdYCOxgjHLr2MGMqfD4RE3bvwRUZF/KMESiuzSwBqPHxMGiH7mZCBBhddpYFS4X6f2s8riq5G14+ZuvR/pN9XlAmwgyXSlsQB7Mve0PnGksE4pe0szd+nvZ0XOPtPCokyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CO+KsKW7; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-238e171b118so3938543fac.3;
        Fri, 03 May 2024 02:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714729370; x=1715334170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GNvNnv7fLkPCXzKFOmKReFLq3t6eZIeRklyaC85DyKA=;
        b=CO+KsKW7c9NzcpO4T4LJjUvh/c3Kz04cgDAYgMhSIwZEeK4XysFd/q4Ua+39s/9fgD
         UR2OCocMtsU+EbPWfJni/l11rG82IiwxWmquAEJzbbJjh7bMLd/HcA3vWYheNR2zXCUp
         NAk3Naiv79zXES0Ipp1wZIoWUS46/RTTHx1sWJZlmySww1JHUaz/lBRbLT8Tc1N+PJkL
         6NaWlxHZ3vZeHZo+PuOsrXmf1UC/sQ1MbMG0h9FpenG3+v1Srz67+0qeKxUmHhh9ZGkt
         AfuBH6KFTlJuh2FOmLnla6dIQ805ImsYnTeoMKgFwuFB3qoGsYZfI7XX6x7YLoTeWwcY
         Zl7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714729370; x=1715334170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GNvNnv7fLkPCXzKFOmKReFLq3t6eZIeRklyaC85DyKA=;
        b=kdofIqFXxckTkwK/T6j6PSJXO14ZftuIVOzpDNFR4C5EemXk53En1fvfnv6tkRxAPv
         UHf0gLs1nS/fW6mjAhlJqnKh+810xEcdC4aMC34vM0nkzVUln7A47ovd8EzNw3wqBxgb
         7uxbYY8tyRkTCl70Da55h3YvNTu+MJoBRtzZL6DGHtao1EFXoGAsTqn2WM3DmbckLv7l
         OPRgf6cF9ypz80Pv4kLUeie5MskXPiuO+D493ZRSVkpdfDkGKwU23oUZXa7OEcoyr3VF
         lDsHdizjeV6ENqv2mfVuq+2iAfs7O8o4Yhyj3MEbroEJpIUG3jjGwfmQzhBtWAugwgXf
         MvwA==
X-Forwarded-Encrypted: i=1; AJvYcCVgqmwR5bFxQZKxRw2o9P5c8uRumGL3FZP03MHn4L9v9u4B2WDC+WM/09dV/Xjhv8yPY8+YaTNcO7v5EDQXx335yTh1ePe9m5OX163T
X-Gm-Message-State: AOJu0YwNLwh1XJplw/IyPOAYmqNX3P+BHhMOEHaR7nZrqt+DhmC1pB/t
	IWwitb47GmTljgfls0ONVebtxN7BWKK+DE2S8npX4mZT/89yIv+0qnW43bS1vmDLV49eXdcYRIp
	Q9i8yJD6vEJOqdHQ7IE1CmrltY64=
X-Google-Smtp-Source: AGHT+IGQcWXxd+BM5x+nAd/5x4yuwDSrpPyFyTdrKfaxLe3etJovQ+UiyQUFC9RN9OY08oq5WERdzlNMzq8Vdb6sLIo=
X-Received: by 2002:a05:6870:fba1:b0:23c:ca10:cc23 with SMTP id
 kv33-20020a056870fba100b0023cca10cc23mr2524346oab.51.1714729369911; Fri, 03
 May 2024 02:42:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429104633.11060-1-ilpo.jarvinen@linux.intel.com> <20240429104633.11060-8-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20240429104633.11060-8-ilpo.jarvinen@linux.intel.com>
From: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date: Fri, 3 May 2024 11:42:37 +0200
Message-ID: <CAMhs-H_x85BXw0z+gRpS84UT3OCcaewtP7cDq4SVD4YWyeUcRw@mail.gmail.com>
Subject: Re: [PATCH 07/10] PCI: Replace PCI_CONF1{,_EXT}_ADDRESS() with the
 new helpers
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring <robh@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 29, 2024 at 12:47=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> Replace the old PCI_CONF1{,_EXT}_ADDRESS() helpers used to calculate
> PCI Configuration Space Type 1 addresses with the new
> pci_conf1{,_ext}_offset() helpers that are more generic and more widely
> available.
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/pci/controller/pci-ftpci100.c | 6 ++----
>  drivers/pci/controller/pci-ixp4xx.c   | 5 ++---
>  drivers/pci/controller/pcie-mt7621.c  | 7 +++----
>  drivers/pci/pci.h                     | 8 --------
>  4 files changed, 7 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/pci/controller/pci-ftpci100.c b/drivers/pci/controll=
er/pci-ftpci100.c
> index ffdeed25e961..a8d0217a0b94 100644
> --- a/drivers/pci/controller/pci-ftpci100.c
> +++ b/drivers/pci/controller/pci-ftpci100.c
> @@ -182,8 +182,7 @@ static int faraday_raw_pci_read_config(struct faraday=
_pci *p, int bus_number,
>                                        unsigned int fn, int config, int s=
ize,
>                                        u32 *value)
>  {
> -       writel(PCI_CONF1_ADDRESS(bus_number, PCI_SLOT(fn),
> -                                PCI_FUNC(fn), config),
> +       writel(pci_conf1_addr(bus_number, fn, config, true),
>                         p->base + FTPCI_CONFIG);
>
>         *value =3D readl(p->base + FTPCI_DATA);
> @@ -214,8 +213,7 @@ static int faraday_raw_pci_write_config(struct farada=
y_pci *p, int bus_number,
>  {
>         int ret =3D PCIBIOS_SUCCESSFUL;
>
> -       writel(PCI_CONF1_ADDRESS(bus_number, PCI_SLOT(fn),
> -                                PCI_FUNC(fn), config),
> +       writel(pci_conf1_addr(bus_number, fn, config, true),
>                         p->base + FTPCI_CONFIG);
>
>         switch (size) {
> diff --git a/drivers/pci/controller/pci-ixp4xx.c b/drivers/pci/controller=
/pci-ixp4xx.c
> index ec0125344ca1..fd52f4a3ef31 100644
> --- a/drivers/pci/controller/pci-ixp4xx.c
> +++ b/drivers/pci/controller/pci-ixp4xx.c
> @@ -192,9 +192,8 @@ static u32 ixp4xx_config_addr(u8 bus_num, u16 devfn, =
int where)
>                        BIT(32 - PCI_SLOT(devfn));
>         } else {
>                 /* type 1 */
> -               return (PCI_CONF1_ADDRESS(bus_num, PCI_SLOT(devfn),
> -                                         PCI_FUNC(devfn), where) &
> -                       ~PCI_CONF1_ENABLE) | PCI_CONF1_TRANSACTION;
> +               return pci_conf1_addr(bus_num, devfn, where, false) |
> +                      PCI_CONF1_TRANSACTION;
>         }
>  }
>
> diff --git a/drivers/pci/controller/pcie-mt7621.c b/drivers/pci/controlle=
r/pcie-mt7621.c
> index 79e225edb42a..2b2d9828a910 100644
> --- a/drivers/pci/controller/pcie-mt7621.c
> +++ b/drivers/pci/controller/pcie-mt7621.c
> @@ -127,8 +127,7 @@ static void __iomem *mt7621_pcie_map_bus(struct pci_b=
us *bus,
>                                          unsigned int devfn, int where)
>  {
>         struct mt7621_pcie *pcie =3D bus->sysdata;
> -       u32 address =3D PCI_CONF1_EXT_ADDRESS(bus->number, PCI_SLOT(devfn=
),
> -                                           PCI_FUNC(devfn), where);
> +       u32 address =3D pci_conf1_ext_addr(bus->number, devfn, where, tru=
e);
>
>         writel_relaxed(address, pcie->base + RALINK_PCI_CONFIG_ADDR);
>
> @@ -143,7 +142,7 @@ static struct pci_ops mt7621_pcie_ops =3D {
>
>  static u32 read_config(struct mt7621_pcie *pcie, unsigned int dev, u32 r=
eg)
>  {
> -       u32 address =3D PCI_CONF1_EXT_ADDRESS(0, dev, 0, reg);
> +       u32 address =3D pci_conf1_ext_addr(0, PCI_DEVFN(dev, 0), reg, tru=
e);
>
>         pcie_write(pcie, address, RALINK_PCI_CONFIG_ADDR);
>         return pcie_read(pcie, RALINK_PCI_CONFIG_DATA);
> @@ -152,7 +151,7 @@ static u32 read_config(struct mt7621_pcie *pcie, unsi=
gned int dev, u32 reg)
>  static void write_config(struct mt7621_pcie *pcie, unsigned int dev,
>                          u32 reg, u32 val)
>  {
> -       u32 address =3D PCI_CONF1_EXT_ADDRESS(0, dev, 0, reg);
> +       u32 address =3D pci_conf1_ext_addr(0, PCI_DEVFN(dev, 0), reg, tru=
e);
>
>         pcie_write(pcie, address, RALINK_PCI_CONFIG_ADDR);
>         pcie_write(pcie, val, RALINK_PCI_CONFIG_DATA);
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index cf0530a60105..fdf9624b0b12 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -833,12 +833,4 @@ struct pci_devres {
>
>  struct pci_devres *find_pci_dr(struct pci_dev *pdev);
>
> -#define PCI_CONF1_ADDRESS(bus, dev, func, reg) \
> -       (PCI_CONF1_ENABLE | \
> -        pci_conf1_addr(bus, PCI_DEVFN(dev, func), reg & ~0x3U))
> -
> -#define PCI_CONF1_EXT_ADDRESS(bus, dev, func, reg) \
> -       (PCI_CONF1_ENABLE | \
> -        pci_conf1_ext_addr(bus, PCI_DEVFN(dev, func), reg & ~0x3U))
> -
>  #endif /* DRIVERS_PCI_H */
> --
> 2.39.2
>

I have tested in a GnuBee v1 board based on mt7621 and all PCI
enumeration and so on is working properly. Hence, for MT7621:

Acked-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Tested-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Thanks,
    Sergio Paracuellos

