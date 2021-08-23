Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC3D3F4BD4
	for <lists+linux-pci@lfdr.de>; Mon, 23 Aug 2021 15:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbhHWNpo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Aug 2021 09:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbhHWNpn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Aug 2021 09:45:43 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55CEC061575
        for <linux-pci@vger.kernel.org>; Mon, 23 Aug 2021 06:45:00 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id u16so26388742wrn.5
        for <linux-pci@vger.kernel.org>; Mon, 23 Aug 2021 06:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CecmHunP+JlYq6XO1xnJLwuFXu4uBjEWOVY2DfF8w9U=;
        b=GvlkeXt+3MOJPmchjWZcteLyQCj/I++3mB/nrkoyCmPyq4eIsBd2fZhaASrI6dppMx
         1nYpNsXn5f0IqwjroKpDu4fwXegMbIZ05TUPf80UFMHj/KouKVUeWPXYaU77JaHYKTk1
         GhcscboVfwfpv2mE10al6ah+HsOhPtDo8tD5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CecmHunP+JlYq6XO1xnJLwuFXu4uBjEWOVY2DfF8w9U=;
        b=Y607bSpPyoEjd+9cwK3K/H2Q+w5pVNMtXDog8xLuniGVOsTQBxubE1KrcOG37YXGfY
         qsudIIR7fC1imZ1dPY60fSmrp2MRlUfK6Z3NvZKTAtQ6O0pe5LRwXxuTs9UxMwAwuwER
         eSSsv+XS8sZMLS6Go1ORVutnc+osDVVyqy+8C8kEN1FLlE6dRZpFUAZ+Hh04ntPftcds
         uyTffdP61QjJlXyObvHRfth19/wF1VQvVoJHbN9JFLoqOchGBO0egaxOiuapsnwxEB5Q
         xQbYU/fAawJt9ovrtMkOim7r+9wO65Xs3ovDXA/6rdDjat2rd6s3X7v4iOYLofvgF7rE
         2dhg==
X-Gm-Message-State: AOAM530wsrUkWL1w/8ytjZ0I1Z5axUz/pebXtXfjzPimaLq515lKjtlp
        2pD+K2y70o96Dyp2bhpacYF2NRiZI8lpPNImP5PLfA==
X-Google-Smtp-Source: ABdhPJwkLk1/YTsHq3pAx+vtNG9zfQ0ZGqAdD3lpdZ+/jEsK6eXp8+cS5V4BjOofPrOgO1346W6C/jtPjLAjkd3Iqoo=
X-Received: by 2002:a05:6000:1081:: with SMTP id y1mr12620353wrw.415.1629726299079;
 Mon, 23 Aug 2021 06:44:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210816125029.16879-1-zajec5@gmail.com>
In-Reply-To: <20210816125029.16879-1-zajec5@gmail.com>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Mon, 23 Aug 2021 09:44:47 -0400
Message-ID: <CA+-6iNxOa0uGSwoySWgfVn3wZw5jh6d3R2oHgVGs5NsQmt+=qA@mail.gmail.com>
Subject: Re: [PATCH] PCI: brcmstb: implement BCM4908 support
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000028d5b505ca3a397e"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--00000000000028d5b505ca3a397e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,
Some comments below...


On Mon, Aug 16, 2021 at 8:51 AM Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com> =
wrote:
>
> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>
> BCM4908 is Broadcom's 64-bit platform with Broadcom's own Brahma-B53
> CPU(s). It uses the same PCIe hardware block as STB (Set-Top-Box) family
> but in a slightly different revision & setup.
>
> Registers in BCM4908 variant are mostly the same but controller setup
> differs a bit. It requires setting few extra registers and takes
> slightly different bars setup.
>
> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 137 +++++++++++++++++++++++---
>  1 file changed, 123 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controll=
er/pcie-brcmstb.c
> index cc30215f5a43..24bc7efcfdd5 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -51,15 +51,20 @@
>  #define PCIE_RC_DL_MDIO_RD_DATA                                0x1108
>
>  #define PCIE_MISC_MISC_CTRL                            0x4008
> +#define  PCIE_MISC_MISC_CTRL_PCIE_RCB_64B_MODE         0x00000080
> +#define  PCIE_MISC_MISC_CTRL_PCIE_RCB_MPS_MODE         0x00000400
> +#define  PCIE_MISC_MISC_CTRL_PCIE_IN_WR_COMBINE                0x0000080=
0
>  #define  PCIE_MISC_MISC_CTRL_SCB_ACCESS_EN_MASK                0x1000
>  #define  PCIE_MISC_MISC_CTRL_CFG_READ_UR_MODE_MASK     0x2000
>  #define  PCIE_MISC_MISC_CTRL_MAX_BURST_SIZE_MASK       0x300000
> +#define  PCIE_MISC_MISC_CTRL_BURST_ALIGN_MASK          0x00080000
>
>  #define  PCIE_MISC_MISC_CTRL_SCB0_SIZE_MASK            0xf8000000
>  #define  PCIE_MISC_MISC_CTRL_SCB1_SIZE_MASK            0x07c00000
>  #define  PCIE_MISC_MISC_CTRL_SCB2_SIZE_MASK            0x0000001f
>  #define  SCB_SIZE_MASK(x) PCIE_MISC_MISC_CTRL_SCB ## x ## _SIZE_MASK
>
> +
Extra WS

>  #define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LO               0x400c
>  #define PCIE_MEM_WIN0_LO(win)  \
>                 PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LO + ((win) * 8)
> @@ -115,6 +120,9 @@
>  #define PCIE_MEM_WIN0_LIMIT_HI(win)    \
>                 PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LIMIT_HI + ((win) * 8)
>
> +#define PCIE_MISC_UBUS_BAR1_CONFIG_REMAP_OFFSET                0x40ac
> +#define  PCIE_MISC_UBUS_BAR_CONFIG_ACCESS_EN           0x00000001
> +
>  #define PCIE_MISC_HARD_PCIE_HARD_DEBUG                                 0=
x4204
>  #define  PCIE_MISC_HARD_PCIE_HARD_DEBUG_CLKREQ_DEBUG_ENABLE_MASK       0=
x2
>  #define  PCIE_MISC_HARD_PCIE_HARD_DEBUG_SERDES_IDDQ_MASK               0=
x08000000
> @@ -131,6 +139,13 @@
>  #define PCIE_EXT_CFG_DATA                              0x8000
>  #define PCIE_EXT_CFG_INDEX                             0x9000
>
> +#define PCIE_CPU_INTR1_INTR_MASK_CLEAR_OFFSET          0x940c
> +#define  PCIE_CPU_INTR1_PCIE_INTA_CPU_INTR             0x00000002
> +#define  PCIE_CPU_INTR1_PCIE_INTB_CPU_INTR             0x00000004
> +#define  PCIE_CPU_INTR1_PCIE_INTC_CPU_INTR             0x00000008
> +#define  PCIE_CPU_INTR1_PCIE_INTD_CPU_INTR             0x00000010
> +#define  PCIE_CPU_INTR1_PCIE_INTR_CPU_INTR             0x00000020
> +
>  #define  PCIE_RGR1_SW_INIT_1_PERST_MASK                        0x1
>  #define  PCIE_RGR1_SW_INIT_1_PERST_SHIFT               0x0
>
> @@ -746,13 +761,19 @@ static inline void brcm_pcie_bridge_sw_init_set_727=
8(struct brcm_pcie *pcie, u32
>
>  static inline void brcm_pcie_perst_set_4908(struct brcm_pcie *pcie, u32 =
val)
>  {
> -       if (WARN_ONCE(!pcie->perst_reset, "missing PERST# reset controlle=
r\n"))
> -               return;
> +       if (pcie->hw_rev >=3D BRCM_PCIE_HW_REV_3_20) {
> +               brcm_pcie_perst_set_7278(pcie, val);
> +       } else {
> +               if (WARN_ONCE(!pcie->perst_reset, "missing PERST# reset c=
ontroller\n"))
> +                       return;
Is this necessary?  Better to just assume it is there and call the
assert/deassrt routines always as they work on NULL.
>
> -       if (val)
> -               reset_control_assert(pcie->perst_reset);
> -       else
> -               reset_control_deassert(pcie->perst_reset);
> +               if (val)
> +                       reset_control_assert(pcie->perst_reset);
> +               else
> +                       reset_control_deassert(pcie->perst_reset);
> +       }
> +
> +       usleep_range(10000, 20000);
Why so long?  And does it need to be long for both directions (assert/deass=
ert)?

>  }
>
>  static inline void brcm_pcie_perst_set_7278(struct brcm_pcie *pcie, u32 =
val)
> @@ -861,6 +882,86 @@ static inline int brcm_pcie_get_rc_bar2_size_and_off=
set(struct brcm_pcie *pcie,
>         return 0;
>  }
>
> +static int brcm_pcie_setup_bcm4908(struct brcm_pcie *pcie)
> +{
> +       struct pci_host_bridge *bridge =3D pci_host_bridge_from_priv(pcie=
);
> +       void __iomem *base =3D pcie->base;
> +       struct device *dev =3D pcie->dev;
> +       struct resource_entry *entry;
> +       u32 burst_align;
> +       u32 burst;
> +       u32 tmp;
> +       int win;
> +
> +       pcie->perst_set(pcie, 0);
> +
> +       msleep(500);
> +
> +       if (!brcm_pcie_link_up(pcie)) {
> +               dev_err(dev, "link down\n");
> +               return -ENODEV;
> +       }
> +
> +       /* setup lgacy outband interrupts */
> +       tmp =3D PCIE_CPU_INTR1_PCIE_INTA_CPU_INTR |
> +             PCIE_CPU_INTR1_PCIE_INTB_CPU_INTR |
> +             PCIE_CPU_INTR1_PCIE_INTC_CPU_INTR |
> +             PCIE_CPU_INTR1_PCIE_INTD_CPU_INTR;
> +       writel(tmp, base + PCIE_CPU_INTR1_INTR_MASK_CLEAR_OFFSET);
Shouldn't this be taken care of by the interrupt-map and interrupt-map
mask properties of the PCIe DT node?  For example, most of our STB
chips use something like this:

interrupt-map-mask =3D <0x0 0x0 0x0 0x7>;
interrupt-map =3D <
0 0 0 1 &intc 0 44 4
0 0 0 2 &intc 0 45 4
0 0 0 3 &intc 0 46 4
0 0 0 4 &intc 0 47 4>;

If you  don't have an interrupt controller DT node/driver, try looking
at the existing BRCM ones or you  may have to craft your own.

> +
> +       win =3D 0;
> +       resource_list_for_each_entry(entry, &bridge->windows) {
> +               struct resource *res =3D entry->res;
> +               u64 pcie_addr;
> +
> +               if (resource_type(res) !=3D IORESOURCE_MEM)
> +                       continue;
> +
> +               if (win >=3D BRCM_NUM_PCIE_OUT_WINS) {
> +                       dev_err(pcie->dev, "too many outbound wins\n");
> +                       return -EINVAL;
> +               }
> +
> +               tmp =3D 0;
> +               u32p_replace_bits(&tmp, res->start / SZ_1M,
> +                                 PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMI=
T_BASE_MASK);
> +               u32p_replace_bits(&tmp, res->end / SZ_1M,
> +                                 PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMI=
T_LIMIT_MASK);
> +               writel(tmp, base + PCIE_MEM_WIN0_BASE_LIMIT(win));
> +
> +               pcie_addr =3D res->start - entry->offset;
> +               writel(lower_32_bits(pcie_addr), pcie->base + PCIE_MEM_WI=
N0_LO(win));
> +               writel(upper_32_bits(pcie_addr), pcie->base + PCIE_MEM_WI=
N0_HI(win));
Again, can you try using the PCIe DT ranges/dma-ranges node properties
instead?

> +
> +               win++;
> +       }
> +
> +       writel(0xf, base + PCIE_MISC_RC_BAR1_CONFIG_LO);
> +
> +       tmp =3D PCIE_MISC_UBUS_BAR_CONFIG_ACCESS_EN;
> +       writel(tmp, base + PCIE_MISC_UBUS_BAR1_CONFIG_REMAP_OFFSET);
> +
> +       tmp =3D readl(base + PCIE_RC_CFG_PRIV1_ID_VAL3);
> +       u32p_replace_bits(&tmp, PCI_CLASS_BRIDGE_PCI << 8,
> +                         PCIE_RC_CFG_PRIV1_ID_VAL3_CLASS_CODE_MASK);
> +       writel(tmp, base + PCIE_RC_CFG_PRIV1_ID_VAL3);
Isn't this already in the driver?  If it is, you should at least make
it a function and call it -- the same code should not exist in
multiple places.

> +
> +       /* Burst */
> +       burst =3D 0x1; /* 128 B */
> +       burst_align =3D 1;
> +
> +       tmp =3D readl(base + PCIE_MISC_MISC_CTRL);if (
> +       u32p_replace_bits(&tmp, burst_align, PCIE_MISC_MISC_CTRL_BURST_AL=
IGN_MASK);
> +       u32p_replace_bits(&tmp, burst, PCIE_MISC_MISC_CTRL_MAX_BURST_SIZE=
_MASK);
> +       u32p_replace_bits(&tmp, 1, PCIE_MISC_MISC_CTRL_CFG_READ_UR_MODE_M=
ASK);
> +       u32p_replace_bits(&tmp, 1, PCIE_MISC_MISC_CTRL_PCIE_IN_WR_COMBINE=
);
> +       u32p_replace_bits(&tmp, 1, PCIE_MISC_MISC_CTRL_PCIE_RCB_MPS_MODE)=
;
> +       u32p_replace_bits(&tmp, 1, PCIE_MISC_MISC_CTRL_PCIE_RCB_64B_MODE)=
;
It would be better if you could use the vanilla brcm_pcie_setup()
function and do something like
if (pcie->type =3D=3D BCM4908)
    do_this();
else
    /* ... */

> +       writel(tmp, base + PCIE_MISC_MISC_CTRL);
> +
> +       return 0;
> +}
> +
>  static int brcm_pcie_setup(struct brcm_pcie *pcie)
>  {
>         struct pci_host_bridge *bridge =3D pci_host_bridge_from_priv(pcie=
);
> @@ -1284,6 +1385,13 @@ static int brcm_pcie_probe(struct platform_device =
*pdev)
>                 return PTR_ERR(pcie->perst_reset);
>         }
>
> +       if (pcie->type =3D=3D BCM4908) {
> +               /* On BCM4908 we can read rev early and perst_set needs i=
t */
> +               pcie->hw_rev =3D readl(pcie->base + PCIE_MISC_REVISION);
We might as well do this in all cases, no need for the 4908 qualifier.

> +
> +               pcie->perst_set(pcie, 1); +               writel(lower_32=
_bits(pcie_addr), pcie->base + PCIE_MEM_WIN0_LO(win));
> +               writel(upper_32_bits(pcie_addr), pcie->base + PCIE_MEM_WI=
N0_HI(win));
Again, can you try using the PCIe DT ranges/dma-ranges node properties inst=
ead?

> +
> +               win++;
> +       }
> +
> +       writel(0xf, base + PCIE_MISC_RC_BAR1_CONFIG_LO);
> +
> +       tmp =3D PCIE_MISC_UBUS_BAR_CONFIG_ACCESS_EN;
> +       writel(tmp, base + PCIE_MISC_UBUS_BAR1_CONFIG_REMAP_OFFSET);
> +
> +       tmp =3D readl(base + PCIE_RC_CFG_PRIV1_ID_VAL3);
> +       u32p_replace_bits(&tmp, PCI_CLASS_BRIDGE_PCI << 8,
> +                         PCIE_RC_CFG_PRIV1_ID_VAL3_CLASS_CODE_MASK);
> +       writel(tmp, base + PCIE_RC_CFG_PRIV1_ID_VAL3);
Isn't this already in the driver?  If it is, it you should at least
make it a function and call it -- the same code should not exist in
multiple places.

> +
> +       /* Burst */
> +       burst =3D 0x1; /* 128 B */
> +       burst_align =3D 1;
> +
> +       tmp =3D readl(base + PCIE_MISC_MISC_CTRL);if (
> +       u32p_replace_bits(&tmp, burst_align, PCIE_MISC_MISC_CTRL_BURST_AL=
IGN_MASK);
> +       u32p_replace_bits(&tmp, burst, PCIE_MISC_MISC_CTRL_MAX_BURST_SIZE=
_MASK);
> +       u32p_replace_bits(&tmp, 1, PCIE_MISC_MISC_CTRL_CFG_READ_UR_MODE_M=
ASK);
> +       u32p_replace_bits(&tmp, 1, PCIE_MISC_MISC_CTRL_PCIE_IN_WR_COMBINE=
);
> +       u32p_replace_bits(&tmp, 1, PCIE_MISC_MISC_CTRL_PCIE_RCB_MPS_MODE)=
;
> +       u32p_replace_bits(&tmp, 1, PCIE_MISC_MISC_CTRL_PCIE_RCB_64B_MODE)=
;
It would be better if you could use the vanilla brcm_pcie_setup()
function and do something like
if (pcie->type =3D=3D BCM4908)
    do_this();
else
    /* ... */

> +       writel(tmp, base + PCIE_MISC_MISC_CTRL);
> +
b
> +       }
> +
>         ret =3D reset_control_reset(pcie->rescal);
>         if (ret)
>                 dev_err(&pdev->dev, "failed to deassert 'rescal'\n");
> @@ -1295,16 +1403,17 @@ static int brcm_pcie_probe(struct platform_device=
 *pdev)
>                 return ret;
>         }
>
> -       ret =3D brcm_pcie_setup(pcie);
> -       if (ret)
> -               goto fail;
> +       if (pcie->type =3D=3D BCM4908) {
> +               ret =3D brcm_pcie_setup_bcm4908(pcie);
> +               if (ret)
> +                       goto fail;
> +       } else {
> +               ret =3D brcm_pcie_setup(pcie);
> +               if (ret)
> +                       goto fail;
> +       }
As Florian said, try to use the existing routine with clauses for
4908-specific code.

Regards,
Jim Quinlan, Broadcom STB
>
>         pcie->hw_rev =3D readl(pcie->base + PCIE_MISC_REVISION);
> -       if (pcie->type =3D=3D BCM4908 && pcie->hw_rev >=3D BRCM_PCIE_HW_R=
EV_3_20) {
> -               dev_err(pcie->dev, "hardware revision with unsupported PE=
RST# setup\n");
> -               ret =3D -ENODEV;
> -               goto fail;
> -       }
>
>         msi_np =3D of_parse_phandle(pcie->np, "msi-parent", 0);
>         if (pci_msi_enabled() && msi_np =3D=3D pcie->np) {
> --
> 2.26.2
>

--00000000000028d5b505ca3a397e
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
LeylbuEJGL9I80yqq8e6Z+Q6ulLxa6SopzpoysJe/vEVHgp9jPNppZzwKngVd2iDBRqpKlCngIAM
DXgVGyEojXnuEbRs3NlB7wq1kJGlYysrnDug55ncJM8CAwEAAaOCAdswggHXMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJQYDVR0R
BB4wHIEaamFtZXMucXVpbmxhbkBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYBBQUHAwQwHwYD
VR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFCeTeUYv84Mo3T1V+OyDdxib
DDLvMA0GCSqGSIb3DQEBCwUAA4IBAQCCqR1PBVtHPvQHuG8bjMFQ94ZB7jmFEGhgfAsFJMaSMLov
qyt8DKr8suCYF4dKGzqalbxo5QU9mmZXdLifqceHdt/Satxb+iGJjBhZg4E0cDds24ofYq+Lbww2
YlIKC2HHxIN+JX2mFpavSXkshR5GT29B9EIJ8hgSjbs61XXeAcrmVIDfYbXQEmGbsnwqxdq+DJpQ
S2kM2wvSlgSWDb6pL7myuKR5lCkQhj7piGSgrVLJRDRrMPw1L4MvnV9DjUFMlGCB40Hm6xqn/jm0
8FCLlWhxve5mj+hgUOPETiKbjhCxJhhAPDdCvDRkZtJlQ8oxUVvXHugG8jm1YqB5AWx7MYICbTCC
AmkCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UE
AxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMI+Aj9XRk/wFexb9/
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCTNzHBpQXW5AcMuyG1/vlIsuuTcuV9
zoDSiDdwT9E3dDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMTA4
MjMxMzQ0NTlaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEADkra/3u4fzxRxxiQN2KfOmHwIW9MDUiOtIT5On/2FOZgixtc
H6IYf5CgKX8cun93EmunYkBqNa9t8LLx1RmKxzBHI+MSBSyKmKpihtmuhXT+fEncz48qxJfREVgO
r5UNTCK2EqgHy5em54VUFvwx9ky2QGXas3AuesBiT5J9NuY5YITCYOy3lmVTaMux6tlAz2laZQth
MjhE+vzmKghyiaGLWlTbGxraL6+1+4Y3Wq8eHjlwHJD7NsdQB3Pb7p/m4AF53RAGsDy2Ws8UOUqe
ycRt6Nk8CCn42jeXSASTs5Bnw983imll7zrv/zFB75Coz41ZWCJXDoLuyBJIEvZ5iw==
--00000000000028d5b505ca3a397e--
