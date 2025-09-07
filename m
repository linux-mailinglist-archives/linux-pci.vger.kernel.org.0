Return-Path: <linux-pci+bounces-35620-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D1250B4815B
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 01:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 936A44E0109
	for <lists+linux-pci@lfdr.de>; Sun,  7 Sep 2025 23:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB7F221F12;
	Sun,  7 Sep 2025 23:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJ7fRlJJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D902AF0A;
	Sun,  7 Sep 2025 23:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757288431; cv=none; b=oDF54JGXTXA7WfB6Q8i2sNoYZ/Ye1oU2U+rjIyLF75ZaMCcw62eUsm0bJYhGUZA2nONKhJBwfWRwdbdK27nyjMDsJ0FecefiJbvsm6e22heJ3gwZGirA25ysHqw7slo3TTshIC8Yysh20Nn3LHUCjE3JM9Xm4vyRl2S5azlKUTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757288431; c=relaxed/simple;
	bh=IJYF8OYAAsB2xjTjpswA3MlqOI5BOFF9G8x6jmMlKW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VSmOIZslDcQNObW49Go3OUSoa8JTShoFdZE0VOJt8iDlaGgUQPMDacyaZ22DrEcf4dHuXWkPKKVW8N78f2v8iXvkbMaj3NFJGItbjTFRb/BmdrkdhSoc4qF3YP3D9teBQDmzkiWbMAA+D6JAa4dfuxUTq7Gm6f1kNKRA1yZPAjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PJ7fRlJJ; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6188b5ad681so5232325a12.0;
        Sun, 07 Sep 2025 16:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757288428; x=1757893228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KIfk6frd70J09D632jkKiJEAKatZHG4CbE7Z7DikGFw=;
        b=PJ7fRlJJdxn4x0UdmttxWPtdxWf5Onwsie/6cxmDj4RqDe6pS/+drwFFt9MNsuvWA9
         3uygqmRhjccewUES2BCXSLUF7kI88U2FCuedzqmqzECqSuPgEXoBaCRthd9tJwhR1rM+
         HVKjDjubaoy/wRVu1Yk+y0Rs21lOxF4rRYybK6H701pzpniaRGFnORaB+N7nNMZXai7U
         Rx4kmyVIwfmEGg1bE3UZMvPeT3DWHFavK21AJTiO7IjfgktV0moXSh5YpphxqpfLBFSU
         EBGaXC2NbtPdfuLG6Ua4ACSKGmHM+VjRcZiAXUq9pNFVtkRe83ymfVIG5EP/TVB1fZIZ
         29bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757288428; x=1757893228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KIfk6frd70J09D632jkKiJEAKatZHG4CbE7Z7DikGFw=;
        b=ZPOlgm2cKIFunlM2Vw62ZaMpG5Xw0+LVmYn1N32WHKVLX/9Z6ByPU2S7L1J9yxCse+
         WU2xkBMJegFFGIUhnLzYLUFBbShOjxpIEgQUIk4+q+A+2WIRtnzBXBCOTLEvOzyMn3IW
         /4X+i38Be8kfKJANGrjoPzV1z5otk6uVlRgX/6weO2aPlGoyXA+u+1QWLVil2FOVqx4o
         2TVxyTqvODHoK9zpUfDn9AZ+HbOhl4XFNGO1Pdb5N3smewxM0eJV96GATs5Tox70cHgc
         sS5mkpyUp9FKUuXcWYguf4ff85R6WcZgJsv+7zaC1m8iT/PMlYqrC/WHZcEttPK1mxVQ
         FkBg==
X-Forwarded-Encrypted: i=1; AJvYcCVVfZeVaSsO6+9UrT0iSBW4uIlJc8gkAD8EF/HMgWCkrrltZhJx4MpcQXAkI/hlUQLfZojFPVDGM4/V@vger.kernel.org, AJvYcCWgk1HJspQIZvaRt58Yt8hssm7hbO0F+tEkbU13Z47LTKDF2ZOXqZJJ/OJ0ZaLCx3RKXM0+1Cmow0go8S4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxryWTuEwX59GB0tittwZkTq5TF/5LKSh5GYTaRc/kL1EJ2HD4q
	1SerzKjJNnvaoC78BY5XEcEXDdIDMGOKLgPRG7sDJNc/Ubr0QB5DNiolVxf5zBX1MNVg3Y8IHkQ
	7210IuqFEjUNKZXQb8AocuL70rcAKx48=
X-Gm-Gg: ASbGnctz/KdLwXpp0tp9ACbBLdO+M6vJRg2dj+0aDbDtJ4ZXTi/dV6xyGvA3+Soc9CG
	7CmiS9up93iI+Ba4JxVJgtyu92xEmnqdfdid8PzwFntNs/z0D3Bi8vyBLyL+MXFmqIs2Hltm3h1
	eF7MRwrlbGyCP2q4TMedhFWD+PQtvh+IppL0UEWjAmGw79EmhaSTZtUO1/Sdh+ZSGIyUTyLns2h
	9G10feSqbFilLGsREg=
X-Google-Smtp-Source: AGHT+IEv+pfin2n2WVdDiraQ3MNCakbx7vGl4DkVZg1HBnMeIk2bI+gUQVWL5GKYVfsbA9kVROtbcfuFdcnsXhQHcEs=
X-Received: by 2002:a05:6402:35c9:b0:628:4ae6:3a4b with SMTP id
 4fb4d7f45d1cf-6284ae63f4amr2072920a12.1.1757288428117; Sun, 07 Sep 2025
 16:40:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250907102303.29735-1-klaus.kudielka@gmail.com>
In-Reply-To: <20250907102303.29735-1-klaus.kudielka@gmail.com>
From: Tony Dinh <mibodhi@gmail.com>
Date: Sun, 7 Sep 2025 16:40:16 -0700
X-Gm-Features: AS18NWDpPNk77PgRKeHvncLRxtTlmHzoOk26pQIt8CrbvhfVuOfOvCiOdgLhc0Q
Message-ID: <CAJaLiFyuKdkEg4yqqv2-_ZgBKqhZNU_mZL9nuELrmNYaDz-SaA@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: mvebu: Fix use of for_each_of_range() iterator
To: Klaus Kudielka <klaus.kudielka@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, 
	Jan Palus <jpalus@fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 7, 2025 at 3:24=E2=80=AFAM Klaus Kudielka <klaus.kudielka@gmail=
.com> wrote:
>
> The blamed commit simplifies code, by using the for_each_of_range()
> iterator. But it results in no pci devices being detected anymore on
> Turris Omnia (and probably other mvebu targets).
>
> Issue #1:
>
> To determine range.flags, of_pci_range_parser_one() uses bus->get_flags()=
,
> which resolves to of_bus_pci_get_flags(). That function already returns a=
n
> IORESOURCE bit field, and NOT the original flags from the "ranges"
> resource.
>
> Then mvebu_get_tgt_attr() attempts the very same conversion again.
> But this is a misinterpretation of range.flags.
>
> Remove the misinterpretation of range.flags in mvebu_get_tgt_attr(),
> to restore the intended behavior.
>
> Issue #2:
>
> The driver needs target and attributes, which are encoded in the raw
> address values of the "/soc/pcie/ranges" resource. According to
> of_pci_range_parser_one(), the raw values are stored in range.bus_addr
> and range.parent_bus_addr, respectively. range.cpu_addr is a translated
> version of range.parent_bus_addr, and not relevant here.
>
> Use the correct range structure member, to extract target and attributes.
> This restores the intended behavior.
>
> Signed-off-by: Klaus Kudielka <klaus.kudielka@gmail.com>
> Fixes: 5da3d94a23c6 ("PCI: mvebu: Use for_each_of_range() iterator for pa=
rsing "ranges"")
> Reported-by: Bjorn Helgaas <helgaas@kernel.org>
> Closes: https://lore.kernel.org/r/20250820184603.GA633069@bhelgaas/
> Reported-by: Jan Palus <jpalus@fastmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D220479
> ---
> v2: Fix issue #2, as well.
>
>  drivers/pci/controller/pci-mvebu.c | 21 ++++-----------------
>  1 file changed, 4 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/=
pci-mvebu.c
> index 755651f338..a72aa57591 100644
> --- a/drivers/pci/controller/pci-mvebu.c
> +++ b/drivers/pci/controller/pci-mvebu.c
> @@ -1168,12 +1168,6 @@ static void __iomem *mvebu_pcie_map_registers(stru=
ct platform_device *pdev,
>         return devm_ioremap_resource(&pdev->dev, &port->regs);
>  }
>
> -#define DT_FLAGS_TO_TYPE(flags)       (((flags) >> 24) & 0x03)
> -#define    DT_TYPE_IO                 0x1
> -#define    DT_TYPE_MEM32              0x2
> -#define DT_CPUADDR_TO_TARGET(cpuaddr) (((cpuaddr) >> 56) & 0xFF)
> -#define DT_CPUADDR_TO_ATTR(cpuaddr)   (((cpuaddr) >> 48) & 0xFF)
> -
>  static int mvebu_get_tgt_attr(struct device_node *np, int devfn,
>                               unsigned long type,
>                               unsigned int *tgt,
> @@ -1189,19 +1183,12 @@ static int mvebu_get_tgt_attr(struct device_node =
*np, int devfn,
>                 return -EINVAL;
>
>         for_each_of_range(&parser, &range) {
> -               unsigned long rtype;
>                 u32 slot =3D upper_32_bits(range.bus_addr);
>
> -               if (DT_FLAGS_TO_TYPE(range.flags) =3D=3D DT_TYPE_IO)
> -                       rtype =3D IORESOURCE_IO;
> -               else if (DT_FLAGS_TO_TYPE(range.flags) =3D=3D DT_TYPE_MEM=
32)
> -                       rtype =3D IORESOURCE_MEM;
> -               else
> -                       continue;
> -
> -               if (slot =3D=3D PCI_SLOT(devfn) && type =3D=3D rtype) {
> -                       *tgt =3D DT_CPUADDR_TO_TARGET(range.cpu_addr);
> -                       *attr =3D DT_CPUADDR_TO_ATTR(range.cpu_addr);
> +               if (slot =3D=3D PCI_SLOT(devfn) &&
> +                   type =3D=3D (range.flags & IORESOURCE_TYPE_BITS)) {
> +                       *tgt =3D (range.parent_bus_addr >> 56) & 0xFF;
> +                       *attr =3D (range.parent_bus_addr >> 48) & 0xFF;
>                         return 0;
>                 }
>         }
> --
> 2.50.1
>
>
Tested on these Marvell Kirkwood SoC boards: Cloudengine Pogoplug
Series 4 (88F6192), ZyXEL NAS325 (88F6282), and Synology DS112
(88F6282).

Tested-by: Tony Dinh <mibodhi@gmail.com>

All the best,
Tony

