Return-Path: <linux-pci+bounces-14674-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CAE9A1070
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 19:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C961EB20A24
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 17:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80F7188580;
	Wed, 16 Oct 2024 17:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="To0ZPTgM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCDE3C0B;
	Wed, 16 Oct 2024 17:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729099040; cv=none; b=kPwIYtCW9qQg2iQ4iuJZyC+jc1MttCIYH8yzb3ZmsODSEDjmc2Dpb6INjsH7OT44jHSnnmQU6DU1yDTiynvODEujtXPeJ2pwQNUwNuIah302Cg48fpBALvdtQhgo0JZiI1b5bKUusg2KuF6dwmGbvVD4kkHgcg4sNAV1icAjgkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729099040; c=relaxed/simple;
	bh=6xN9mrHAFH71QE+R8FhQpzBYbRgEL9iIqCoauPI+488=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uYi39/t45U2jETLFmP5neQ0d3ibcXwde6fRknVwDmKbbJ2wrduiIXO5ypzdd07Rmnd9V7dFd2WajlavfrEWp7i5NQO01SNK8cIaxSN//xBwCtvVAW04bwmq0xTheW5Q6ZHBHYvexmzy2Jp78RHFzE3bpRSbN+m/oviaxpB2Xshs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=To0ZPTgM; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7180dc76075so3027a34.3;
        Wed, 16 Oct 2024 10:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729099037; x=1729703837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9GgyHpdZ+36DvFjYWHsuCAjZF/LYKLV9OPIzXu6Nmy8=;
        b=To0ZPTgM/AWUD9Obn3kPV+TVc/ut1ARkKIgSQQuryNcxP+N4uwPFmcaPrd5aWYSOwY
         1b+dTYbFQqYvdscUrnefqjBb41Ybn7ZJRQd4Qu4/uUIBlA4Omzy5Qpb9jNL4kY1DhT14
         uvIEpauMMLqHDAEfyjwDX2l0hzPvov0l6bk2Be2i2Skpd+jf7XImP6QKMpOEnrSi23p3
         oWvz9YKGiQ9ayiVWEi309yOTMVm1S3bgcJpScbeX6lmza+4Hmw9rVnuN6VsgRkMf80/T
         3zDSv1Ley3sUm7DuL0JSNBYbwIptHbxPd/a7rvRybq2eDROuBoIrIbR7strhTsYfp66L
         DkRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729099037; x=1729703837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9GgyHpdZ+36DvFjYWHsuCAjZF/LYKLV9OPIzXu6Nmy8=;
        b=m66OHUE1khpHeOfwtk8w8ZGGwuA3meK2a+hAd3R/+0MN1hKndaLOrPZXfO8mTyt9MN
         ksFKlPbeuQ9iX1jMr9Bj0EG8T2Z1nv9j0zQ5lx7zHCO7PtcoX1WeU3vDb8UwROz8QnDn
         PfluIJJJRnmBzCOlQCH66Q4y04ZFRtWgEeioYNaUZqSAXzG/I7Mlat00EzQZ1nu7TEro
         6+rjI1dIrmrQY199EDV6csi2/DDehP5sxsKYsjEDldo2KhjkySs9qXbb2gvkdgj3Ywq6
         J4s059M/E0XohWrwEBzhoywXMwSoEZG5u040llSEfC7vIgai//5zDrjvH3GaPmKMv/WZ
         5NqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjPHsqRiXtwHwaOSOeB+j5H51UHzczbbQrTksAmXaK2ms3OV4hhRrG1UUFzDj8rxyndUthWmFA+uWR@vger.kernel.org, AJvYcCW+iPMSCgOmbK1p4OM/khQQo+3BCjXwPcDY6RLkv6sCGGzS6mejEOl2O61G18JjYpiC8XlL9TAKnXy3@vger.kernel.org
X-Gm-Message-State: AOJu0YzCDjouPYqQojKFCR0FI0ZKlhjTDIZhGID3qtpkQw+d+hTE6Rnq
	bkyXyLSoFHnV7/V3gYjU02VY0QI8UV2rgx//YL93Gxfj7NooSfjkzFVv0Ypo1qPss+CSShxVf0p
	JquSv10E1UI67pN3hQQJYTXVMnwU=
X-Google-Smtp-Source: AGHT+IEOnd4EJA4icjeSdKGLv1JGNjowtyVGmj3LsPVzhwA1Gu28AjcMTUJ3UIAX4Bg0nSIjEMgPYI4V4u3hquyRu/s=
X-Received: by 2002:a05:6830:6a86:b0:718:c42:48c3 with SMTP id
 46e09a7af769-7180c424a01mr1434675a34.32.1729099037491; Wed, 16 Oct 2024
 10:17:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014130710.413-1-svarbanov@suse.de> <20241014130710.413-7-svarbanov@suse.de>
In-Reply-To: <20241014130710.413-7-svarbanov@suse.de>
From: Jim Quinlan <jim2101024@gmail.com>
Date: Wed, 16 Oct 2024 13:17:06 -0400
Message-ID: <CANCKTBt-QAOytUSp6=HcS_SiPD7wSOFdFv2U=4c146uzmdinAQ@mail.gmail.com>
Subject: Re: [PATCH v3 06/11] PCI: brcmstb: Avoid turn off of bridge reset
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
	Phil Elwell <phil@raspberrypi.com>, Jonathan Bell <jonathan@raspberrypi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 9:07=E2=80=AFAM Stanimir Varbanov <svarbanov@suse.d=
e> wrote:
>
> On PCIe turn off avoid shutdown of bridge reset,
> by introducing a quirk flag.
>
> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
> ---
> v2 -> v3:
>  - Added more descriptive comment on CFG_QUIRK_AVOID_BRIDGE_SHUTDOWN quir=
k.
>
>  drivers/pci/controller/pcie-brcmstb.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controll=
er/pcie-brcmstb.c
> index b76c16287f37..757a1646d53c 100644
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
> + * register blocks, therefore not other controller can access this regis=
ter

s/no/not/

I assume that the quirks is specific to 2712 as the 7712 does not need
this since it only has PCIe1
(I'll probably seethis as I read more of your commits).

-- Jim

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
> @@ -290,6 +300,7 @@ struct brcm_pcie {
>         struct subdev_regulators *sr;
>         bool                    ep_wakeup_capable;
>         bool                    has_phy;
> +       u32                     quirks;
>         u8                      num_inbound_wins;
>  };
>
> @@ -1539,8 +1550,9 @@ static int brcm_pcie_turn_off(struct brcm_pcie *pci=
e)
>         u32p_replace_bits(&tmp, 1, PCIE_MISC_HARD_PCIE_HARD_DEBUG_SERDES_=
IDDQ_MASK);
>         writel(tmp, base + HARD_DEBUG(pcie));
>
> -       /* Shutdown PCIe bridge */
> -       ret =3D pcie->bridge_sw_init_set(pcie, 1);
> +       if (!(pcie->quirks & CFG_QUIRK_AVOID_BRIDGE_SHUTDOWN))
> +               /* Shutdown PCIe bridge */
> +               ret =3D pcie->bridge_sw_init_set(pcie, 1);
>
>         return ret;
>  }
> @@ -1854,6 +1866,7 @@ static int brcm_pcie_probe(struct platform_device *=
pdev)
>         pcie->perst_set =3D data->perst_set;
>         pcie->bridge_sw_init_set =3D data->bridge_sw_init_set;
>         pcie->has_phy =3D data->has_phy;
> +       pcie->quirks =3D data->quirks;
>         pcie->num_inbound_wins =3D data->num_inbound_wins;
>
>         pcie->base =3D devm_platform_ioremap_resource(pdev, 0);
> --
> 2.43.0
>

