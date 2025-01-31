Return-Path: <linux-pci+bounces-20601-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 885AEA24017
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jan 2025 17:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 057181883B97
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jan 2025 16:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9711E47A6;
	Fri, 31 Jan 2025 16:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRMav1Rp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6881D5CE8;
	Fri, 31 Jan 2025 16:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738339846; cv=none; b=P+hCWXOH67K5jAma260WrWHC9mujpyCYIH6p8PsU5ZfKuUxmcf37FCrk1o7AJhYlWdRvMF9V5ucC8EYRCp/oczcKzorgu/ZU7+DvNVaRTnj7IF73SubumshNlI9iixRMuPWVrTOO0nUKyWCjOb7H8qz7Lx5b1qV9EyioAeDleLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738339846; c=relaxed/simple;
	bh=lEYFlp7D9vOgmh6FxPmIK07KVLiaJwrcf09kd3RM4h8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rV+li6PdjimZasfPu7ElsxYNewr2rmUDO+ih89E2XPE5NDcZseqZZ5El/DV9uEuyKEQb47AL+SoTeSfbXmivETkrY/E9xoFzn6AUGPCR3yLpT+T+zPhEvpCyQwzS2HjmeOiGqp+KKQLyVOMuTLpQAVnQx9OZl+rno6Xk8FW/3kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LRMav1Rp; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-518ae5060d4so691969e0c.0;
        Fri, 31 Jan 2025 08:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738339843; x=1738944643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eu+XMQ47bXlXPYQHl43GAXbMYSPEg4jafNJwlAkmt70=;
        b=LRMav1Rp/pwZ1WIARB9RK0r6YfDy6xErbrbyEVKMbjTaJXlEKu/akDawLUzvAvOG5C
         wRre1ouHn0b1C7HqoJRv0TW+gbW8x20gfq7PYHqgKp6HzTK2yLbMz2+GRq4K6qoSbFEl
         YoEDRMPeuJn67VcW+wlHmB9GPl+Fjx8ZMnTMDzcLmA6OHDSEgV7HPml0bMUePvw6jGIs
         kFBcZ6ok7OBbzU1NdL0umtxdDc66lQgD/Cgys7Y5iHV5F/bOdw+GW+8qwtV0mRS2cfFg
         1LZRFdQUlfUmUMQE6NeD4C2qgl4vmOOn7acQmmvwaPMUSCTde997S1pwEwX54cZNx7TZ
         MxcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738339843; x=1738944643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eu+XMQ47bXlXPYQHl43GAXbMYSPEg4jafNJwlAkmt70=;
        b=O3rrKhzTuPe6zMcqCjfb7W5Ew6fEfBRSacf7cjZCPLexKQjUz6Kk7eQMqlSeDMLdHW
         1D18Ez8w5xx+Ft1OeoOUBQI/gnq0QYKaJKKnUgAPutMFRsTw+1gEDi40XyX/wa52375r
         w/ciAYc3qKFNeKujUp5z/l03srmDhtOY4Bv4uXzXCTERTfmUxkZrK8EY4nwszlhBhBnq
         9V/slYDNMMIQ+/WtnlPmyyHW0VWsoy1QA/xW+WEzZPkjTm5X/6VBK//7F3rnUWxp3sFo
         PB84NbuYRSEHd0qv05gRQkQYGik9MSrtwBYu5yYh76KrN8DeoUT1VD0wjrmF1rJHpg/5
         F/Gg==
X-Forwarded-Encrypted: i=1; AJvYcCUkm665AXCsY/iZ8tie3Qnze4/BpAUs5Q5U6KzDe/t79OTtE3LZTSFxCJXDyaadtQPkv54/q5XiAyDp@vger.kernel.org, AJvYcCVUmUjgYdiIiVNGrUXqT4CeT+CvrOKQgIyee59ADbBKKFjihPscwUo3qY5wrvyew05fTkptpSn1mkFd@vger.kernel.org
X-Gm-Message-State: AOJu0YzqkTHdOLN0AxXBAXsU5Mj2OoJLef+KjRXm7AFthWn60MSa+WcG
	Su1ZzPDvKKvg6Jxy29CK64dn7V613dzHnSdQ/10W9efyu4r8/A/yaKUrKEv3voQiXwhRhP/gRVq
	I/oQgVhlfd8ES/C1nLA3Rs3ft1JlyfCbP
X-Gm-Gg: ASbGnctNB8Rsi1LSSNgVTlJDErMCVwQ/K+ztVqkESUtCodnHaCSeQAWtO7YRY0vud0q
	kkabrUHWoPerr6aiMYTaZ4guD8POlQlQqi56cZbJ1/8ODLQpQu4XIZpPNxpdpNnvpghwx4nQ1Qw
	==
X-Google-Smtp-Source: AGHT+IHVZBBOfUZy6lCArkdG+XNcvhhnR9mZTBjduA+0tDP3FY7GhtILUSyJnGJ/G0U/HytXRMLHw7xul4q/Yfasvpc=
X-Received: by 2002:a05:6122:1990:b0:51c:aa1a:2b5b with SMTP id
 71dfb90a1353d-51e9e3fdc44mr10810912e0c.4.1738339843188; Fri, 31 Jan 2025
 08:10:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250120130119.671119-1-svarbanov@suse.de> <20250120130119.671119-5-svarbanov@suse.de>
In-Reply-To: <20250120130119.671119-5-svarbanov@suse.de>
From: Jim Quinlan <jim2101024@gmail.com>
Date: Fri, 31 Jan 2025 11:10:32 -0500
X-Gm-Features: AWEUYZltv134yZp54XYoT3tXiFOxfyfElr2Gzrw8XqAsf5Sd26MR-d3mNX9qmME
Message-ID: <CANCKTBsm6o9yaSenj-wft+n0uX-HNRjpJjkZaQcn4t474fXtow@mail.gmail.com>
Subject: Re: [PATCH v5 -next 04/11] PCI: brcmstb: Reuse config structure
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
> Instead of copying fields from pcie_cfg_data structure to
> brcm_pcie reference it directly.
>
> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
> Reviewed-by: Florian Fainelil <florian.fainelli@broadcom.com>
> ---
> v4 -> v5:
>  - No changes.
>
>  drivers/pci/controller/pcie-brcmstb.c | 70 ++++++++++++---------------
>  1 file changed, 31 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controll=
er/pcie-brcmstb.c
> index e733a27dc8df..48b2747d8c98 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -191,11 +191,11 @@
>  #define SSC_STATUS_PLL_LOCK_MASK       0x800
>  #define PCIE_BRCM_MAX_MEMC             3
>
> -#define IDX_ADDR(pcie)                 ((pcie)->reg_offsets[EXT_CFG_INDE=
X])
> -#define DATA_ADDR(pcie)                        ((pcie)->reg_offsets[EXT_=
CFG_DATA])
> -#define PCIE_RGR1_SW_INIT_1(pcie)      ((pcie)->reg_offsets[RGR1_SW_INIT=
_1])
> -#define HARD_DEBUG(pcie)               ((pcie)->reg_offsets[PCIE_HARD_DE=
BUG])
> -#define INTR2_CPU_BASE(pcie)           ((pcie)->reg_offsets[PCIE_INTR2_C=
PU_BASE])
> +#define IDX_ADDR(pcie)                 ((pcie)->cfg->offsets[EXT_CFG_IND=
EX])
> +#define DATA_ADDR(pcie)                        ((pcie)->cfg->offsets[EXT=
_CFG_DATA])
> +#define PCIE_RGR1_SW_INIT_1(pcie)      ((pcie)->cfg->offsets[RGR1_SW_INI=
T_1])
> +#define HARD_DEBUG(pcie)               ((pcie)->cfg->offsets[PCIE_HARD_D=
EBUG])
> +#define INTR2_CPU_BASE(pcie)           ((pcie)->cfg->offsets[PCIE_INTR2_=
CPU_BASE])
>
>  /* Rescal registers */
>  #define PCIE_DVT_PMU_PCIE_PHY_CTRL                             0xc700
> @@ -276,8 +276,6 @@ struct brcm_pcie {
>         int                     gen;
>         u64                     msi_target_addr;
>         struct brcm_msi         *msi;
> -       const int               *reg_offsets;
> -       enum pcie_soc_base      soc_base;
>         struct reset_control    *rescal;
>         struct reset_control    *perst_reset;
>         struct reset_control    *bridge_reset;
> @@ -285,17 +283,14 @@ struct brcm_pcie {
>         int                     num_memc;
>         u64                     memc_size[PCIE_BRCM_MAX_MEMC];
>         u32                     hw_rev;
> -       int                     (*perst_set)(struct brcm_pcie *pcie, u32 =
val);
> -       int                     (*bridge_sw_init_set)(struct brcm_pcie *p=
cie, u32 val);
>         struct subdev_regulators *sr;
>         bool                    ep_wakeup_capable;
> -       bool                    has_phy;
> -       u8                      num_inbound_wins;
> +       const struct pcie_cfg_data      *cfg;
>  };
>
>  static inline bool is_bmips(const struct brcm_pcie *pcie)
>  {
> -       return pcie->soc_base =3D=3D BCM7435 || pcie->soc_base =3D=3D BCM=
7425;
> +       return pcie->cfg->soc_base =3D=3D BCM7435 || pcie->cfg->soc_base =
=3D=3D BCM7425;
>  }
>
>  /*
> @@ -855,7 +850,7 @@ static int brcm_pcie_get_inbound_wins(struct brcm_pci=
e *pcie,
>          * security considerations, and is not implemented in our modern
>          * SoCs.
>          */
> -       if (pcie->soc_base !=3D BCM7712)
> +       if (pcie->cfg->soc_base !=3D BCM7712)
>                 add_inbound_win(b++, &n, 0, 0, 0);
>
>         resource_list_for_each_entry(entry, &bridge->dma_ranges) {
> @@ -872,10 +867,10 @@ static int brcm_pcie_get_inbound_wins(struct brcm_p=
cie *pcie,
>                  * That being said, each BARs size must still be a power =
of
>                  * two.
>                  */
> -               if (pcie->soc_base =3D=3D BCM7712)
> +               if (pcie->cfg->soc_base =3D=3D BCM7712)
>                         add_inbound_win(b++, &n, size, cpu_start, pcie_st=
art);
>
> -               if (n > pcie->num_inbound_wins)
> +               if (n > pcie->cfg->num_inbound_wins)
>                         break;
>         }
>
> @@ -889,7 +884,7 @@ static int brcm_pcie_get_inbound_wins(struct brcm_pci=
e *pcie,
>          * that enables multiple memory controllers.  As such, it can ret=
urn
>          * now w/o doing special configuration.
>          */
> -       if (pcie->soc_base =3D=3D BCM7712)
> +       if (pcie->cfg->soc_base =3D=3D BCM7712)
>                 return n;
>
>         ret =3D of_property_read_variable_u64_array(pcie->np, "brcm,scb-s=
izes", pcie->memc_size, 1,
> @@ -1012,7 +1007,7 @@ static void set_inbound_win_registers(struct brcm_p=
cie *pcie,
>                  * 7712:
>                  *     All of their BARs need to be set.
>                  */
> -               if (pcie->soc_base =3D=3D BCM7712) {
> +               if (pcie->cfg->soc_base =3D=3D BCM7712) {
>                         /* BUS remap register settings */
>                         reg_offset =3D brcm_ubus_reg_offset(i);
>                         tmp =3D lower_32_bits(cpu_addr) & ~0xfff;
> @@ -1036,15 +1031,15 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie=
)
>         int memc, ret;
>
>         /* Reset the bridge */
> -       ret =3D pcie->bridge_sw_init_set(pcie, 1);
> +       ret =3D pcie->cfg->bridge_sw_init_set(pcie, 1);
>         if (ret)
>                 return ret;
>
>         /* Ensure that PERST# is asserted; some bootloaders may deassert =
it. */
> -       if (pcie->soc_base =3D=3D BCM2711) {
> -               ret =3D pcie->perst_set(pcie, 1);
> +       if (pcie->cfg->soc_base =3D=3D BCM2711) {
> +               ret =3D pcie->cfg->perst_set(pcie, 1);
>                 if (ret) {
> -                       pcie->bridge_sw_init_set(pcie, 0);
> +                       pcie->cfg->bridge_sw_init_set(pcie, 0);
>                         return ret;
>                 }
>         }
> @@ -1052,7 +1047,7 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
>         usleep_range(100, 200);
>
>         /* Take the bridge out of reset */
> -       ret =3D pcie->bridge_sw_init_set(pcie, 0);
> +       ret =3D pcie->cfg->bridge_sw_init_set(pcie, 0);
>         if (ret)
>                 return ret;
>
> @@ -1072,9 +1067,9 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
>          */
>         if (is_bmips(pcie))
>                 burst =3D 0x1; /* 256 bytes */
> -       else if (pcie->soc_base =3D=3D BCM2711)
> +       else if (pcie->cfg->soc_base =3D=3D BCM2711)
>                 burst =3D 0x0; /* 128 bytes */
> -       else if (pcie->soc_base =3D=3D BCM7278)
> +       else if (pcie->cfg->soc_base =3D=3D BCM7278)
>                 burst =3D 0x3; /* 512 bytes */
>         else
>                 burst =3D 0x2; /* 512 bytes */
> @@ -1199,7 +1194,7 @@ static void brcm_extend_rbus_timeout(struct brcm_pc=
ie *pcie)
>         u32 timeout_us =3D 4000000; /* 4 seconds, our setting for L1SS */
>
>         /* 7712 does not have this (RGR1) timer */
> -       if (pcie->soc_base =3D=3D BCM7712)
> +       if (pcie->cfg->soc_base =3D=3D BCM7712)
>                 return;
>
>         /* Each unit in timeout register is 1/216,000,000 seconds */
> @@ -1277,7 +1272,7 @@ static int brcm_pcie_start_link(struct brcm_pcie *p=
cie)
>         int ret, i;
>
>         /* Unassert the fundamental reset */
> -       ret =3D pcie->perst_set(pcie, 0);
> +       ret =3D pcie->cfg->perst_set(pcie, 0);
>         if (ret)
>                 return ret;
>
> @@ -1463,12 +1458,12 @@ static int brcm_phy_cntl(struct brcm_pcie *pcie, =
const int start)
>
>  static inline int brcm_phy_start(struct brcm_pcie *pcie)
>  {
> -       return pcie->has_phy ? brcm_phy_cntl(pcie, 1) : 0;
> +       return pcie->cfg->has_phy ? brcm_phy_cntl(pcie, 1) : 0;
>  }
>
>  static inline int brcm_phy_stop(struct brcm_pcie *pcie)
>  {
> -       return pcie->has_phy ? brcm_phy_cntl(pcie, 0) : 0;
> +       return pcie->cfg->has_phy ? brcm_phy_cntl(pcie, 0) : 0;
>  }
>
>  static int brcm_pcie_turn_off(struct brcm_pcie *pcie)
> @@ -1479,7 +1474,7 @@ static int brcm_pcie_turn_off(struct brcm_pcie *pci=
e)
>         if (brcm_pcie_link_up(pcie))
>                 brcm_pcie_enter_l23(pcie);
>         /* Assert fundamental reset */
> -       ret =3D pcie->perst_set(pcie, 1);
> +       ret =3D pcie->cfg->perst_set(pcie, 1);
>         if (ret)
>                 return ret;
>
> @@ -1582,7 +1577,7 @@ static int brcm_pcie_resume_noirq(struct device *de=
v)
>                 goto err_reset;
>
>         /* Take bridge out of reset so we can access the SERDES reg */
> -       pcie->bridge_sw_init_set(pcie, 0);
> +       pcie->cfg->bridge_sw_init_set(pcie, 0);
>
>         /* SERDES_IDDQ =3D 0 */
>         tmp =3D readl(base + HARD_DEBUG(pcie));
> @@ -1803,12 +1798,7 @@ static int brcm_pcie_probe(struct platform_device =
*pdev)
>         pcie =3D pci_host_bridge_priv(bridge);
>         pcie->dev =3D &pdev->dev;
>         pcie->np =3D np;
> -       pcie->reg_offsets =3D data->offsets;
> -       pcie->soc_base =3D data->soc_base;
> -       pcie->perst_set =3D data->perst_set;
> -       pcie->bridge_sw_init_set =3D data->bridge_sw_init_set;
> -       pcie->has_phy =3D data->has_phy;
> -       pcie->num_inbound_wins =3D data->num_inbound_wins;
> +       pcie->cfg =3D data;
>
>         pcie->base =3D devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(pcie->base))
> @@ -1843,7 +1833,7 @@ static int brcm_pcie_probe(struct platform_device *=
pdev)
>         if (ret)
>                 return dev_err_probe(&pdev->dev, ret, "could not enable c=
lock\n");
>
> -       pcie->bridge_sw_init_set(pcie, 0);
> +       pcie->cfg->bridge_sw_init_set(pcie, 0);
>
>         if (pcie->swinit_reset) {
>                 ret =3D reset_control_assert(pcie->swinit_reset);
> @@ -1882,7 +1872,8 @@ static int brcm_pcie_probe(struct platform_device *=
pdev)
>                 goto fail;
>
>         pcie->hw_rev =3D readl(pcie->base + PCIE_MISC_REVISION);
> -       if (pcie->soc_base =3D=3D BCM4908 && pcie->hw_rev >=3D BRCM_PCIE_=
HW_REV_3_20) {
> +       if (pcie->cfg->soc_base =3D=3D BCM4908 &&
> +           pcie->hw_rev >=3D BRCM_PCIE_HW_REV_3_20) {
>                 dev_err(pcie->dev, "hardware revision with unsupported PE=
RST# setup\n");
>                 ret =3D -ENODEV;
>                 goto fail;
> @@ -1897,7 +1888,8 @@ static int brcm_pcie_probe(struct platform_device *=
pdev)
>                 }
>         }
>
> -       bridge->ops =3D pcie->soc_base =3D=3D BCM7425 ? &brcm7425_pcie_op=
s : &brcm_pcie_ops;
> +       bridge->ops =3D pcie->cfg->soc_base =3D=3D BCM7425 ?
> +                               &brcm7425_pcie_ops : &brcm_pcie_ops;
>         bridge->sysdata =3D pcie;
>
>         platform_set_drvdata(pdev, pcie);

Reviewed-by: Jim Quinlan <james.quinlan@broadcom.com>
> --
> 2.47.0
>

