Return-Path: <linux-pci+bounces-20599-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3847EA24004
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jan 2025 17:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67D4E166BFE
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jan 2025 16:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731CE1E1C3A;
	Fri, 31 Jan 2025 16:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZe9s3P0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43821AAC4;
	Fri, 31 Jan 2025 16:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738339529; cv=none; b=GAVc8v55MMsz18KKE8bZ/6I2KDGolcpuFgNEv4ZVJgsA3e9fQEm3EykgKZejVhWWkjC83YHF6S2qmqEu21NEKOxX1w48+sfu2x5S/m1X3xrQwUcrD8n3L/GKFp9GYVmli+LMdMW5G1xrmFhiVmKYy/2fnbhCMOSaWy9xPNy0BC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738339529; c=relaxed/simple;
	bh=gX4ag1AlV9dTSBogEeBHGkTAgAH/pVoq+dkZLcj3U0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cyGeWBfsDH2j88OozG+ZFS9BxoxyVkcs6RUv8xayZ2NPE8dFSSq9BiaVJ14m9IXuhZO2jZ6GEdKEt7NiD6O2px6DGnNCOTOLv070tXDi4ql3R9xP0FETe9G7IxKmoZ1SamQNAW60/uMJgD9gAsJQ9axNLioSs+z99h+c53gJRIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nZe9s3P0; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-518954032b2so636131e0c.0;
        Fri, 31 Jan 2025 08:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738339526; x=1738944326; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yinOq3BvFm8pbS0HIBonp/WO0nQAo4BYehd8oFIVqaA=;
        b=nZe9s3P0Cpc0anllRk8SkWHEpImBoTC8fwprmxJC16eEStO7AH2/q+JlP+BhcdE3SC
         rjds7buD3Ns6/JFCtuqlLELfu096rKYLTo6xyA5nSVylew+spgICd5yBnk8dZKMQSD7l
         pemgZH2Jh85seuG1S9AlH+/0Ndcvyym7IzTRc7BXbef9IEMF69pQ58J17brRMD2BpstZ
         lz2zQhCig3xa/oPmRoA9fkg+IH/89SdBdNXdu7UFjiX5oxSPq/avb8v1vZncXdT8rgyk
         SvMYSKuq9dAKcY5Eb33QaHcZzxdBqHKx3SRPaoeChSrw3pWSszRpdiJHERXz4Ka7NyXX
         2YPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738339526; x=1738944326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yinOq3BvFm8pbS0HIBonp/WO0nQAo4BYehd8oFIVqaA=;
        b=ATd9e+lrb9DJAjJQ+w1MghVq0MpV+1b63HXDtYN+mif2CuW1mHMo+MLKv5sd2b4cx8
         HfOzsfueytGAjQ30N0SOnWdTakzxi46a01m5Uh0te6QbxNx7KNm5c1vAS9+PZTPJ6V/v
         ha/jDQ4fwwUGt8GFsWXxxfkgKCdlBkzVpsoXrh7RNVO+DQ5C2lEFUvbfm+iJnWMDeb3V
         GGOuQoNq2wkZxzgYmh4oKv1saNo2XpqcuEFIcjxOs3Zn7brIfTTY9jvsac5gAAROWz4w
         AgwYGsNJPBKG/XswHKOUwAfcvFaHMo1wIKjy20lUnBAa2jN/dleWYVPPblytu+4S2af0
         MMdA==
X-Forwarded-Encrypted: i=1; AJvYcCUPZ6bSd9C9PNYM6QEu6k6v1Y3GooQhosAsVKKbLYiIuD6dj4BQSRowWYio3DR4C2ckbzf4yRPZ0WpW@vger.kernel.org, AJvYcCXpiqLKgOexQkiVBC5hukjyEPV4bhO9tcw4wFDiMZNJ1ycuLCdoi922Td0Rgm2OuCYpZftHeAAgLW+Q@vger.kernel.org
X-Gm-Message-State: AOJu0YwGYBk/0H7FddKFp3Abgpu/280SG2hl4XhOPKe4gYlixfVmgoIW
	6JOuBBOpu2BpU0GH7zy84m9K0SHZuV2nGkjIjH76Ydd6pjjTcBjPFFd7G2Jm72ARUb8VFy4yAaW
	8dZSrrYoC7AOA9CNPAlMltTf2dR0=
X-Gm-Gg: ASbGncsI5J1vMossPzQCnFP05FdciUgasi46QY0UsteXKaVe7m/EgQ8NUbnF8VJiPHM
	QIZpejXnYQJa/62Kx0mypwz5v2PkxBF7aABY+/GluaC3o7vT3DtX1J2Ajq/NfBG6AEtfr1NBf2w
	==
X-Google-Smtp-Source: AGHT+IEp7MtYTu6aLHmfoRZMuQIhdDIIlMcvFCUzckw2uCT/3cjD28n2Uuo9tiMWgYBKq7vRQxgRKyFa2i4Ck0/Q8yw=
X-Received: by 2002:a05:6122:1826:b0:515:daa7:ed07 with SMTP id
 71dfb90a1353d-51e9e28a51amr9180667e0c.0.1738339526468; Fri, 31 Jan 2025
 08:05:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250120130119.671119-1-svarbanov@suse.de> <20250120130119.671119-7-svarbanov@suse.de>
In-Reply-To: <20250120130119.671119-7-svarbanov@suse.de>
From: Jim Quinlan <jim2101024@gmail.com>
Date: Fri, 31 Jan 2025 11:05:14 -0500
X-Gm-Features: AWEUYZlLglIi2jugpqje-hAPwOESpNgNxOWzCPUmbm1viKS3V0vfFHVWucL5CCE
Message-ID: <CANCKTBtG14B7mqW3vjv557kHLfYkJtJiL+xu8f2siZ9_BuWPHg@mail.gmail.com>
Subject: Re: [PATCH v5 -next 06/11] PCI: brcmstb: Add bcm2712 support
To: Stanimir Varbanov <svarbanov@suse.de>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, 
	linux-pci@vger.kernel.org, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Nicolas Saenz Julienne <nsaenz@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, kw@linux.com, 
	Philipp Zabel <p.zabel@pengutronix.de>, Andrea della Porta <andrea.porta@suse.com>, 
	Phil Elwell <phil@raspberrypi.com>, Jonathan Bell <jonathan@raspberrypi.com>, 
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2025 at 8:01=E2=80=AFAM Stanimir Varbanov <svarbanov@suse.d=
e> wrote:
>
> Add bare minimum amount of changes in order to support PCIe RC hardware
> IP found on RPi5. The PCIe controller on bcm2712 is based on bcm7712 and
> as such it inherits register offsets, perst, bridge_reset ops and inbound
> windows count.
> Although, the implementation for bcm2712 needs a workaround related to th=
e
> control of the bridge_reset where turning off of the root port must not
> shutdown the bridge_reset and this must be avoided. To implement this
> workaround a quirks field is introduced in pcie_cfg_data struct.
>
> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
> v4 -> v5:
>  - No changes.
>
>  drivers/pci/controller/pcie-brcmstb.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controll=
er/pcie-brcmstb.c
> index 59190d8be0fb..50607df34a66 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -234,10 +234,20 @@ struct inbound_win {
>         u64 cpu_addr;
>  };
>
> +/*
> + * The RESCAL block is tied to PCIe controller #1, regardless of the num=
ber of
> + * controllers, and turning off PCIe controller #1 prevents access to th=
e RESCAL
> + * register blocks, therefore no other controller can access this regist=
er
> + * space, and depending upon the bus fabric we may get a timeout (UBUS/G=
ISB),
> + * or a hang (AXI).
> + */
> +#define CFG_QUIRK_AVOID_BRIDGE_SHUTDOWN                BIT(0)
> +
>  struct pcie_cfg_data {
>         const int *offsets;
>         const enum pcie_soc_base soc_base;
>         const bool has_phy;
> +       const u32 quirks;
>         u8 num_inbound_wins;
>         int (*perst_set)(struct brcm_pcie *pcie, u32 val);
>         int (*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
> @@ -1488,8 +1498,9 @@ static int brcm_pcie_turn_off(struct brcm_pcie *pci=
e)
>         u32p_replace_bits(&tmp, 1, PCIE_MISC_HARD_PCIE_HARD_DEBUG_SERDES_=
IDDQ_MASK);
>         writel(tmp, base + HARD_DEBUG(pcie));
>
> -       /* Shutdown PCIe bridge */
> -       ret =3D pcie->bridge_sw_init_set(pcie, 1);
> +       if (!(pcie->cfg->quirks & CFG_QUIRK_AVOID_BRIDGE_SHUTDOWN))
> +               /* Shutdown PCIe bridge */
> +               ret =3D pcie->cfg->bridge_sw_init_set(pcie, 1);
>
>         return ret;
>  }
> @@ -1699,6 +1710,15 @@ static const struct pcie_cfg_data bcm2711_cfg =3D =
{
>         .num_inbound_wins =3D 3,
>  };
>
> +static const struct pcie_cfg_data bcm2712_cfg =3D {
> +       .offsets        =3D pcie_offsets_bcm7712,
> +       .soc_base       =3D BCM7712,
> +       .perst_set      =3D brcm_pcie_perst_set_7278,
> +       .bridge_sw_init_set =3D brcm_pcie_bridge_sw_init_set_generic,
> +       .quirks         =3D CFG_QUIRK_AVOID_BRIDGE_SHUTDOWN,
> +       .num_inbound_wins =3D 10,
> +};
> +
>  static const struct pcie_cfg_data bcm4908_cfg =3D {
>         .offsets        =3D pcie_offsets,
>         .soc_base       =3D BCM4908,
> @@ -1750,6 +1770,7 @@ static const struct pcie_cfg_data bcm7712_cfg =3D {
>
>  static const struct of_device_id brcm_pcie_match[] =3D {
>         { .compatible =3D "brcm,bcm2711-pcie", .data =3D &bcm2711_cfg },
> +       { .compatible =3D "brcm,bcm2712-pcie", .data =3D &bcm2712_cfg },
>         { .compatible =3D "brcm,bcm4908-pcie", .data =3D &bcm4908_cfg },
>         { .compatible =3D "brcm,bcm7211-pcie", .data =3D &generic_cfg },
>         { .compatible =3D "brcm,bcm7216-pcie", .data =3D &bcm7216_cfg },
Reviewed-by: Jim Quinlan <james.quinlan@broadcom.com>
> --
> 2.47.0
>

