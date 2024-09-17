Return-Path: <linux-pci+bounces-13270-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D271E97B2D5
	for <lists+linux-pci@lfdr.de>; Tue, 17 Sep 2024 18:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 292B3B21486
	for <lists+linux-pci@lfdr.de>; Tue, 17 Sep 2024 16:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D68517A5B5;
	Tue, 17 Sep 2024 16:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g/ZBGjsh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A719B176FD3
	for <linux-pci@vger.kernel.org>; Tue, 17 Sep 2024 16:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726589769; cv=none; b=UnSRc1/i2tSBLR7u3DNuphgJRiUlB+IHGaVJZu7coDjOD6HqnjUegA1lPwCfUMm1QSxE/QLUzshIi3r5OBPOxB7j27rrxyUfsZRmXrp+KODydqdh4XHTUCtBQl3pdqixQZ0L3PVZ4ftQXzr5tUR3efjUtN4B6HzNiCsTYrLozXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726589769; c=relaxed/simple;
	bh=i1UAWJv6Xi4RGLWV+uu/+pYa8bLqiViv1zHjRG7It8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o/bu1X9wXdITvKjin3axV6bmhlLl0upFvLPH7bKYD/bw7vjf5FrRarOmuoOho4Y12Yf7xHVfuC+2jx7ppb0RtUtP5xKbI0cVRTfgkV5Zb8Bq+YL8jplQ4yvKVZle0F5VkRVujho4ekTy5woiywn5N5r0ho7J4DNDRG3mdR+v5UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=g/ZBGjsh; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-710dad96bf7so1093904a34.0
        for <linux-pci@vger.kernel.org>; Tue, 17 Sep 2024 09:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726589766; x=1727194566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOViShtMlEZDSnvKkZ21snYzhKVQ7eVObFNfJXc64zE=;
        b=g/ZBGjshKleAmI8gYuGAQHoonMsSbsRxZG06vJRc0XFNMTbydH1CY/c1xom5f22wiA
         8OmXkKBzzBsgLVQdUQsxb9VmXg4mSsoPkjdBE8or3293tcPAhKnOBLaFKh8eChGc4Fwl
         bqiepyqY0JCjfytmUwLxovBg7qf3MWY6CYzKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726589766; x=1727194566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZOViShtMlEZDSnvKkZ21snYzhKVQ7eVObFNfJXc64zE=;
        b=L7wFRg0cD4wNvCgEMhtkn1eW4be9GwGki04RNltbbAWmtk0ZsfKO7pDVRQOI120bOt
         3EAyC+AtC4zWAP0PAxwn8hdyDsJaKWuV+5NhA3xDVa4xQmyd2OMOxIOSahwJxYzzECii
         PRmV0Tv2rpe303TlCCaV6FNgMFqyTfySkBqi3rDLoXQYzSLZ6hEzY3TqSR0w4sx3jTQG
         uPT7qFEPfqpL9xsmwdTwZEGQ21L0Z1+yhN4Doi/ptqTzHhZP+QP3FQIgfeQni1Y9injp
         Csa0Va1XVo4wCvNUD8SZr6n99wKR6Mgpqwz/WdWb44qpBgsBd4HY+PARYQFwMlyj846T
         uj0A==
X-Gm-Message-State: AOJu0Yy7JdKFaLgVghzQLGq1cj/Jz8+sBhyp/SraPN8kzXMvmRiBBIcC
	ka2AYYY70dmoLQIKbvepK1NDUopqAUiX8iWO5DGzLdA09z+cTFEXzJosJs5DBCA8Idnmec89k8U
	=
X-Google-Smtp-Source: AGHT+IEE0qnYosnF8dyvRLFuMXx6DMfSleXESJUajjvgFx+MFy1RQgw9V04WuFgV+29frRrhfM+2vA==
X-Received: by 2002:a05:6808:6545:b0:3e0:3504:e7f5 with SMTP id 5614622812f47-3e07a0ebf2amr9080249b6e.4.1726589765720;
        Tue, 17 Sep 2024 09:16:05 -0700 (PDT)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com. [209.85.210.48])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e166d151besm1444592b6e.25.2024.09.17.09.16.04
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2024 09:16:05 -0700 (PDT)
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7092dd03223so860017a34.1
        for <linux-pci@vger.kernel.org>; Tue, 17 Sep 2024 09:16:04 -0700 (PDT)
X-Received: by 2002:a05:6830:65c1:b0:710:fbce:8b5e with SMTP id
 46e09a7af769-71116bd1b24mr10727787a34.11.1726589763706; Tue, 17 Sep 2024
 09:16:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240917091132.286582-1-angelogioacchino.delregno@collabora.com> <20240917091132.286582-2-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240917091132.286582-2-angelogioacchino.delregno@collabora.com>
From: Fei Shao <fshao@chromium.org>
Date: Wed, 18 Sep 2024 00:15:26 +0800
X-Gmail-Original-Message-ID: <CAC=S1nhp_3EfG7g7GyLHQGPk_2mrfzj3Kqgi4u_gsA7-Wq8Zgg@mail.gmail.com>
Message-ID: <CAC=S1nhp_3EfG7g7GyLHQGPk_2mrfzj3Kqgi4u_gsA7-Wq8Zgg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] PCI: mediatek-gen3: Add support for setting
 max-link-speed limit
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pci@vger.kernel.org, ryder.lee@mediatek.com, 
	jianjun.wang@mediatek.com, lpieralisi@kernel.org, kw@linux.com, 
	robh@kernel.org, bhelgaas@google.com, matthias.bgg@gmail.com, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 17, 2024 at 5:13=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Add support for respecting the max-link-speed devicetree property,
> forcing a maximum speed (Gen) for a PCI-Express port.
>
> Since the MediaTek PCIe Gen3 controllers also expose the maximum
> supported link speed in the PCIE_BASE_CFG register, if property
> max-link-speed is specified in devicetree, validate it against the
> controller capabilities and proceed setting the limitations only
> if the wanted Gen is lower than the maximum one that is supported
> by the controller itself (otherwise it makes no sense!).
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  drivers/pci/controller/pcie-mediatek-gen3.c | 55 ++++++++++++++++++++-
>  1 file changed, 53 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/co=
ntroller/pcie-mediatek-gen3.c
> index 66ce4b5d309b..e1d1fb39d5c6 100644
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> @@ -28,7 +28,11 @@
>
>  #include "../pci.h"
>
> +#define PCIE_BASE_CFG_REG              0x14
> +#define PCIE_BASE_CFG_SPEED_MASK       GENMASK(15, 8)
> +
>  #define PCIE_SETTING_REG               0x80
> +#define PCIE_SETTING_GEN_SUPPORT_MASK  GENMASK(14, 12)
>  #define PCIE_PCI_IDS_1                 0x9c
>  #define PCI_CLASS(class)               (class << 8)
>  #define PCIE_RC_MODE                   BIT(0)
> @@ -125,6 +129,9 @@
>
>  struct mtk_gen3_pcie;
>
> +#define PCIE_CONF_LINK2_CTL_STS                0x10b0
> +#define PCIE_CONF_LINK2_LCR2_LINK_SPEED        GENMASK(3, 0)
> +
>  /**
>   * struct mtk_gen3_pcie_pdata - differentiate between host generations
>   * @power_up: pcie power_up callback
> @@ -160,6 +167,7 @@ struct mtk_msi_set {
>   * @phy: PHY controller block
>   * @clks: PCIe clocks
>   * @num_clks: PCIe clocks count for this port
> + * @max_link_speed: Maximum link speed (PCIe Gen) for this port
>   * @irq: PCIe controller interrupt number
>   * @saved_irq_state: IRQ enable state saved at suspend time
>   * @irq_lock: lock protecting IRQ register access
> @@ -180,6 +188,7 @@ struct mtk_gen3_pcie {
>         struct phy *phy;
>         struct clk_bulk_data *clks;
>         int num_clks;
> +       u8 max_link_speed;
>
>         int irq;
>         u32 saved_irq_state;
> @@ -381,11 +390,27 @@ static int mtk_pcie_startup_port(struct mtk_gen3_pc=
ie *pcie)
>         int err;
>         u32 val;
>
> -       /* Set as RC mode */
> +       /* Set as RC mode and set controller PCIe Gen speed restriction, =
if any*/

NIt: one space before ending the comment.

>         val =3D readl_relaxed(pcie->base + PCIE_SETTING_REG);
>         val |=3D PCIE_RC_MODE;
> +       if (pcie->max_link_speed) {
> +               val &=3D ~PCIE_SETTING_GEN_SUPPORT_MASK;
> +
> +               /* Can enable link speed support only from Gen2 onwards *=
/
> +               if (pcie->max_link_speed >=3D 2)
> +                       val |=3D FIELD_PREP(PCIE_SETTING_GEN_SUPPORT_MASK=
,
> +                                         GENMASK(pcie->max_link_speed - =
2, 0));
> +       }
>         writel_relaxed(val, pcie->base + PCIE_SETTING_REG);
>
> +       /* Set Link Control 2 (LNKCTL2) speed restriction, if any */
> +       if (pcie->max_link_speed) {
> +               val =3D readl_relaxed(pcie->base + PCIE_CONF_LINK2_CTL_ST=
S);
> +               val &=3D PCIE_CONF_LINK2_LCR2_LINK_SPEED;

I guess it needs a bitwise NOT operator over the mask.
    val &=3D ~PCIE_CONF_LINK2_LCR2_LINK_SPEED;

Apart from that, I think appending _MASK to the name makes its usage
clearer and consistent with other masks.
(although the name gets even more lengthy...)

> +               val |=3D FIELD_PREP(PCIE_CONF_LINK2_LCR2_LINK_SPEED, pcie=
->max_link_speed);
> +               writel_relaxed(val, pcie->base + PCIE_CONF_LINK2_CTL_STS)=
;
> +       }
> +
>         /* Set class code */
>         val =3D readl_relaxed(pcie->base + PCIE_PCI_IDS_1);
>         val &=3D ~GENMASK(31, 8);
> @@ -1004,9 +1029,21 @@ static void mtk_pcie_power_down(struct mtk_gen3_pc=
ie *pcie)
>         reset_control_bulk_assert(pcie->soc->phy_resets.num_resets, pcie-=
>phy_resets);
>  }
>
> +static int mtk_pcie_get_controller_max_link_speed(struct mtk_gen3_pcie *=
pcie)
> +{
> +       u32 val;
> +       int ret;
> +
> +       val =3D readl_relaxed(pcie->base + PCIE_BASE_CFG_REG);
> +       val =3D FIELD_GET(PCIE_BASE_CFG_SPEED_MASK, val);
> +       ret =3D fls(val);
> +
> +       return ret > 0 ? ret : -EINVAL;
> +}
> +
>  static int mtk_pcie_setup(struct mtk_gen3_pcie *pcie)
>  {
> -       int err;
> +       int max_speed, err;
>
>         err =3D mtk_pcie_parse_port(pcie);
>         if (err)
> @@ -1031,6 +1068,20 @@ static int mtk_pcie_setup(struct mtk_gen3_pcie *pc=
ie)
>         if (err)
>                 return err;
>
> +       err =3D of_pci_get_max_link_speed(pcie->dev->of_node);
> +       if (err > 0) {
> +               /* Get the maximum speed supported by the controller */
> +               max_speed =3D mtk_pcie_get_controller_max_link_speed(pcie=
);
> +
> +               /* Set max_link_speed only if the controller supports it =
*/
> +               if (max_speed >=3D 0 && max_speed <=3D err) {
> +                       pcie->max_link_speed =3D err;
> +                       dev_dbg(pcie->dev,
> +                               "Max controller link speed Gen%u, overrid=
e to Gen%u",
> +                               max_speed, pcie->max_link_speed);

Convert max_speed to an unsigned type to avoid potential typecheck warnings=
?

Regards,
Fei


> +               }
> +       }
> +
>         /* Try link up */
>         err =3D mtk_pcie_startup_port(pcie);
>         if (err)
> --
> 2.46.0
>
>

