Return-Path: <linux-pci+bounces-5615-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C915E896E86
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 13:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E883AB24C6B
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 11:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619E1143865;
	Wed,  3 Apr 2024 11:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CXZTGGnh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849AF17583;
	Wed,  3 Apr 2024 11:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712145286; cv=none; b=M3ucYeIEW8Ai/oc1JAq2oZSczIiW0SdrUSEVP9qwPtNvDS/yYd5X6YxBDAlzsUhXNB+RAymhmc7RxgzlEeD2rOF0TzQlav9BY8toHKJlmEHxYQc1F48CAnOSfgh4cXcdES16H75N3S/KZHZilSe3ZrMYcLTK/sGs5f+R3QCpKYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712145286; c=relaxed/simple;
	bh=9tkB/8QWUwpob8rZeoLBTyMQ2NwjSXLE0solJkAxskw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b+cQiyiiSsc6dVMSXlXJ2KyADUfFBfuPlVbBD8WXhUiUNjEy9b/DtD24W0YMuKNvdgQlVniLTKGJZ7aU87w9YX9f9d8f7ChsgXMeCJ2TsEEoQXgA+aw5rLN92muxVPhUVlL79BcvtpG8+cHmcWsskdfp/0rBY4UjYQuA5hWBFwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CXZTGGnh; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-ddaad2aeab1so5201644276.3;
        Wed, 03 Apr 2024 04:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712145283; x=1712750083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z3OMqqHc20XH2HsRVb93SWbt27U70ABLovLC1aJbLMA=;
        b=CXZTGGnhgD2anMhsYtlBgeaDdu6Q0Kfe9rMN3akN/iPCyDfzpnGxeM6Sp2HNSgD+q6
         SduF0+TJ7xvEycrsNkuU4C/VCrNtN3KwT6jcMfdpZf6dFVszYjgm7oFaMNVXotl2NW3d
         BASGyvFP2OAvwGzin4Qg4fxhCyKMLbzJPuYnL8euf2lr4sHvBBzoSJwQAJBbuTUEqi0u
         htGc5QPFoLnKyC59NPxczxpMhsMZG/SdHQEGKsCgKeXmGOVIskqkTYXxEr2mPsTHZYVW
         XP1ywNnN/qzWhbbycasCi94NnKOqqaOkQlatAXrUQ1XUhLIIqGmat8KJpapd8Eb857uC
         ahbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712145283; x=1712750083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z3OMqqHc20XH2HsRVb93SWbt27U70ABLovLC1aJbLMA=;
        b=vUK13xnDro54te/yR+3Nu/3r4GmnVbH2cnFseYVx35xKyyi1668pyObx57TUHapcmq
         WHyWuU4wl9GCxkLfnKRe6Fy/amXogNqCxu8n7vkXDkGc9bPpKAruFNEv4TTGrIZR1dpM
         I7a152VdHJpXpZkzKJLvwJ1L3IktERMSQ0aksxXCv9fJQE52u8LMSMx/aqdsWTDl8Vvg
         o+1p30LfCdOPokeONSSbzFxsgYxPDUiiiEfIJFdHd2fr4UdskMZElB5oJRzj6Fprlere
         8ggiNo8fupMljY8wrswXIPSrfLGML9hfaHMZsSGAlbJlazZCqfjACT7K+X5KHa7JLqNU
         pCsA==
X-Forwarded-Encrypted: i=1; AJvYcCWtPhnckOS8xP14fk69JT5AnmA5vfMrs6aMHp8WZoHEXHf9jiRG+1nmqQgwl9uoFIIFaSyntUSqjv9xeDnhYjHYyhtBl52gtDAaIUOTC3o/cVHZzlv1oYKJw30S2K9CllinO/byIA==
X-Gm-Message-State: AOJu0YwD9xGl7UclEp+jE52Xwd67ZqMthheZITAgnkRysatlFi6uAS4e
	VNsDuFTF5kxlRVmZhSnOB1SD/nP0bpoxJReT2FtglsdDjGaKRG9moG8aTS20DF9RdG+mOE6oZHt
	3pHun0Do+zB+ITdB9sb3t8N8OTlE=
X-Google-Smtp-Source: AGHT+IEILTPe7mFJEwRJujc3oIZAHLgSGGg1VcuWXbGgibtwvJMedN/dQArliawCeis1beZnNOr20qVSxmbrnCneal8=
X-Received: by 2002:a05:6902:20c4:b0:dcc:d3ab:2fc0 with SMTP id
 dj4-20020a05690220c400b00dccd3ab2fc0mr741170ybb.23.1712145283378; Wed, 03 Apr
 2024 04:54:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240330041928.1555578-1-dlemoal@kernel.org> <20240330041928.1555578-17-dlemoal@kernel.org>
In-Reply-To: <20240330041928.1555578-17-dlemoal@kernel.org>
From: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Date: Wed, 3 Apr 2024 13:54:07 +0200
Message-ID: <CAAEEuhrbx2NfKP2L4A4Rxyxk05hN2VwoRG6CBOZFUufsQasH7w@mail.gmail.com>
Subject: Re: [PATCH v2 16/18] PCI: rockchip-ep: Improve link training
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Shawn Lin <shawn.lin@rock-chips.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	Wilfred Mallawa <wilfred.mallawa@wdc.com>, Niklas Cassel <cassel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 30, 2024 at 5:20=E2=80=AFAM Damien Le Moal <dlemoal@kernel.org>=
 wrote:
>
> The Rockchip rk339 technical reference manual describe the endpoint mode
> link training process clearly and states that:
>   Insure link training completion and success by observing link_st field
>   in PCIe Client BASIC_STATUS1 register change to 2'b11. If both side
>   support PCIe Gen2 speed, re-train can be Initiated by asserting the
>   Retrain Link field in Link Control and Status Register. The software
>   should insure the BASIC_STATUS0[negotiated_speed] changes to "1", that
>   indicates re-train to Gen2 successfully.
> This procedure is very similar to what is done for the root-port mode in
> rockchip_pcie_host_init_port().
>
> Implement this link training procedure for the endpoint mode as well.
> Given that the rk3399 SoC does not have an interrupt signaling link
> status changes, training is implemented as a delayed work which is
> rescheduled until the link training completes or the endpoint controller
> is stopped. The link training work is first scheduled in
> rockchip_pcie_ep_start() when the endpoint function is started. Link
> training completion is signaled to the function using pci_epc_linkup().
> Accordingly, the linkup_notifier field of the rockchip pci_epc_features
> structure is changed to true.
>
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/pci/controller/pcie-rockchip-ep.c | 79 ++++++++++++++++++++++-
>  drivers/pci/controller/pcie-rockchip.h    | 11 ++++
>  2 files changed, 89 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/cont=
roller/pcie-rockchip-ep.c
> index 2767e8f1771d..4006e7dee71a 100644
> --- a/drivers/pci/controller/pcie-rockchip-ep.c
> +++ b/drivers/pci/controller/pcie-rockchip-ep.c
> @@ -16,6 +16,8 @@
>  #include <linux/platform_device.h>
>  #include <linux/pci-epf.h>
>  #include <linux/sizes.h>
> +#include <linux/workqueue.h>
> +#include <linux/iopoll.h>
>
>  #include "pcie-rockchip.h"
>
> @@ -48,6 +50,7 @@ struct rockchip_pcie_ep {
>         u64                     irq_pci_addr;
>         u8                      irq_pci_fn;
>         u8                      irq_pending;
> +       struct delayed_work     link_training;
>  };
>
>  static void rockchip_pcie_clear_ep_ob_atu(struct rockchip_pcie *rockchip=
,
> @@ -467,6 +470,8 @@ static int rockchip_pcie_ep_start(struct pci_epc *epc=
)
>                             PCIE_CLIENT_CONF_ENABLE,
>                             PCIE_CLIENT_CONFIG);
>
> +       schedule_delayed_work(&ep->link_training, 0);
> +
>         return 0;
>  }
>
> @@ -475,6 +480,8 @@ static void rockchip_pcie_ep_stop(struct pci_epc *epc=
)
>         struct rockchip_pcie_ep *ep =3D epc_get_drvdata(epc);
>         struct rockchip_pcie *rockchip =3D &ep->rockchip;
>
> +       cancel_delayed_work_sync(&ep->link_training);
> +
>         /* Stop link training and disable configuration */
>         rockchip_pcie_write(rockchip,
>                             PCIE_CLIENT_CONF_DISABLE |
> @@ -482,8 +489,77 @@ static void rockchip_pcie_ep_stop(struct pci_epc *ep=
c)
>                             PCIE_CLIENT_CONFIG);
>  }
>
> +static void rockchip_pcie_ep_retrain_link(struct rockchip_pcie *rockchip=
)
> +{
> +       u32 status;
> +
> +       status =3D rockchip_pcie_read(rockchip, PCIE_EP_CONFIG_LCS);
> +       status |=3D PCI_EXP_LNKCTL_RL;
> +       rockchip_pcie_write(rockchip, status, PCIE_EP_CONFIG_LCS);
> +}
> +
> +static bool rockchip_pcie_ep_link_up(struct rockchip_pcie *rockchip)
> +{
> +       u32 val =3D rockchip_pcie_read(rockchip, PCIE_CLIENT_BASIC_STATUS=
1);
> +
> +       return PCIE_LINK_UP(val);
> +}
> +
> +static void rockchip_pcie_ep_link_training(struct work_struct *work)
> +{
> +       struct rockchip_pcie_ep *ep =3D
> +               container_of(work, struct rockchip_pcie_ep, link_training=
.work);
> +       struct rockchip_pcie *rockchip =3D &ep->rockchip;
> +       struct device *dev =3D rockchip->dev;
> +       u32 val;
> +       int ret;
> +
> +       /* Enable Gen1 training and wait for its completion */
> +       ret =3D readl_poll_timeout(rockchip->apb_base + PCIE_CORE_CTRL,
> +                                val, PCIE_LINK_TRAINING_DONE(val), 50,
> +                                LINK_TRAIN_TIMEOUT);
> +       if (ret)
> +               goto again;
> +
> +       /* Make sure that the link is up */
> +       ret =3D readl_poll_timeout(rockchip->apb_base + PCIE_CLIENT_BASIC=
_STATUS1,
> +                                val, PCIE_LINK_UP(val), 50,
> +                                LINK_TRAIN_TIMEOUT);
> +       if (ret)
> +               goto again;
> +
> +       /* Check the current speed */
> +       val =3D rockchip_pcie_read(rockchip, PCIE_CORE_CTRL);
> +       if (!PCIE_LINK_IS_GEN2(val) && rockchip->link_gen =3D=3D 2) {
> +               /* Enable retrain for gen2 */
> +               rockchip_pcie_ep_retrain_link(rockchip);
> +               readl_poll_timeout(rockchip->apb_base + PCIE_CORE_CTRL,
> +                                  val, PCIE_LINK_IS_GEN2(val), 50,
> +                                  LINK_TRAIN_TIMEOUT);
> +       }
> +
> +       /* Check again that the link is up */
> +       if (!rockchip_pcie_ep_link_up(rockchip))
> +               goto again;
> +
> +       val =3D rockchip_pcie_read(rockchip, PCIE_CLIENT_BASIC_STATUS0);
> +       dev_info(dev,
> +                "Link UP (Negociated speed: %sGT/s, width: x%lu)\n",
> +                (val & PCIE_CLIENT_NEG_LINK_SPEED) ? "5" : "2.5",
> +                ((val & PCIE_CLIENT_NEG_LINK_WIDTH_MASK) >>
> +                 PCIE_CLIENT_NEG_LINK_WIDTH_SHIFT) << 1);
> +

This does not print the correct link width for x1 :

# [   60.518339] rockchip-pcie-ep fd000000.pcie-ep: Link UP
(Negociated speed: 5GT/s, width: x0)

This is because :

((val & PCIE_CLIENT_NEG_LINK_WIDTH_MASK) >>
 PCIE_CLIENT_NEG_LINK_WIDTH_SHIFT) << 1
will print 0 if the link width is 1, because bits 7:6 are 0b00, and
0b00 << 1 is still 0. (0b00 =3D> x0, 0b01 =3D> x2, 0b10 =3D> x4)

Therefore the formula should be :
1 << ((val & PCIE_CLIENT_NEG_LINK_WIDTH_MASK) >>
 PCIE_CLIENT_NEG_LINK_WIDTH_SHIFT)
This shows the correct link width for all cases (0b00 =3D> x1, 0b01 =3D>
x2, 0b10 =3D> x4).

Reference : RK3399 TRM V1.3 pages 768-769 PCIE_CLIENT_BASIC_STATUS0
register description


> +       /* Notify the function */
> +       pci_epc_linkup(ep->epc);
> +
> +       return;
> +
> +again:
> +       schedule_delayed_work(&ep->link_training, msecs_to_jiffies(5));
> +}
> +
>  static const struct pci_epc_features rockchip_pcie_epc_features =3D {
> -       .linkup_notifier =3D false,
> +       .linkup_notifier =3D true,
>         .msi_capable =3D true,
>         .msix_capable =3D false,
>         .align =3D ROCKCHIP_PCIE_AT_SIZE_ALIGN,
> @@ -644,6 +720,7 @@ static int rockchip_pcie_ep_probe(struct platform_dev=
ice *pdev)
>         rockchip =3D &ep->rockchip;
>         rockchip->is_rc =3D false;
>         rockchip->dev =3D dev;
> +       INIT_DELAYED_WORK(&ep->link_training, rockchip_pcie_ep_link_train=
ing);
>
>         epc =3D devm_pci_epc_create(dev, &rockchip_pcie_epc_ops);
>         if (IS_ERR(epc)) {
> diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/control=
ler/pcie-rockchip.h
> index 0263f158ee8d..3963b7097a91 100644
> --- a/drivers/pci/controller/pcie-rockchip.h
> +++ b/drivers/pci/controller/pcie-rockchip.h
> @@ -26,6 +26,7 @@
>  #define MAX_LANE_NUM                   4
>  #define MAX_REGION_LIMIT               32
>  #define MIN_EP_APERTURE                        28
> +#define LINK_TRAIN_TIMEOUT             (5000 * USEC_PER_MSEC)
>
>  #define PCIE_CLIENT_BASE               0x0
>  #define PCIE_CLIENT_CONFIG             (PCIE_CLIENT_BASE + 0x00)
> @@ -50,6 +51,10 @@
>  #define   PCIE_CLIENT_DEBUG_LTSSM_MASK         GENMASK(5, 0)
>  #define   PCIE_CLIENT_DEBUG_LTSSM_L1           0x18
>  #define   PCIE_CLIENT_DEBUG_LTSSM_L2           0x19
> +#define PCIE_CLIENT_BASIC_STATUS0      (PCIE_CLIENT_BASE + 0x44)
> +#define   PCIE_CLIENT_NEG_LINK_WIDTH_MASK      GENMASK(7, 6)
> +#define   PCIE_CLIENT_NEG_LINK_WIDTH_SHIFT     6
> +#define   PCIE_CLIENT_NEG_LINK_SPEED           BIT(5)
>  #define PCIE_CLIENT_BASIC_STATUS1      (PCIE_CLIENT_BASE + 0x48)
>  #define   PCIE_CLIENT_LINK_STATUS_UP           0x00300000
>  #define   PCIE_CLIENT_LINK_STATUS_MASK         0x00300000
> @@ -87,6 +92,8 @@
>
>  #define PCIE_CORE_CTRL_MGMT_BASE       0x900000
>  #define PCIE_CORE_CTRL                 (PCIE_CORE_CTRL_MGMT_BASE + 0x000=
)
> +#define   PCIE_CORE_PL_CONF_LS_MASK            0x00000001
> +#define   PCIE_CORE_PL_CONF_LS_READY           0x00000001
>  #define   PCIE_CORE_PL_CONF_SPEED_5G           0x00000008
>  #define   PCIE_CORE_PL_CONF_SPEED_MASK         0x00000018
>  #define   PCIE_CORE_PL_CONF_LANE_MASK          0x00000006
> @@ -144,6 +151,7 @@
>  #define PCIE_RC_CONFIG_BASE            0xa00000
>  #define PCIE_EP_CONFIG_BASE            0xa00000
>  #define PCIE_EP_CONFIG_DID_VID         (PCIE_EP_CONFIG_BASE + 0x00)
> +#define PCIE_EP_CONFIG_LCS             (PCIE_EP_CONFIG_BASE + 0xd0)
>  #define PCIE_RC_CONFIG_RID_CCR         (PCIE_RC_CONFIG_BASE + 0x08)
>  #define PCIE_RC_CONFIG_DCR             (PCIE_RC_CONFIG_BASE + 0xc4)
>  #define   PCIE_RC_CONFIG_DCR_CSPL_SHIFT                18
> @@ -155,6 +163,7 @@
>  #define PCIE_RC_CONFIG_LINK_CAP                (PCIE_RC_CONFIG_BASE + 0x=
cc)
>  #define   PCIE_RC_CONFIG_LINK_CAP_L0S          BIT(10)
>  #define PCIE_RC_CONFIG_LCS             (PCIE_RC_CONFIG_BASE + 0xd0)
> +#define PCIE_EP_CONFIG_LCS             (PCIE_EP_CONFIG_BASE + 0xd0)
>  #define PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2 (PCIE_RC_CONFIG_BASE + 0x90c)
>  #define PCIE_RC_CONFIG_THP_CAP         (PCIE_RC_CONFIG_BASE + 0x274)
>  #define   PCIE_RC_CONFIG_THP_CAP_NEXT_MASK     GENMASK(31, 20)
> @@ -192,6 +201,8 @@
>  #define ROCKCHIP_VENDOR_ID                     0x1d87
>  #define PCIE_LINK_IS_L2(x) \
>         (((x) & PCIE_CLIENT_DEBUG_LTSSM_MASK) =3D=3D PCIE_CLIENT_DEBUG_LT=
SSM_L2)
> +#define PCIE_LINK_TRAINING_DONE(x) \
> +       (((x) & PCIE_CORE_PL_CONF_LS_MASK) =3D=3D PCIE_CORE_PL_CONF_LS_RE=
ADY)
>  #define PCIE_LINK_UP(x) \
>         (((x) & PCIE_CLIENT_LINK_STATUS_MASK) =3D=3D PCIE_CLIENT_LINK_STA=
TUS_UP)
>  #define PCIE_LINK_IS_GEN2(x) \
> --
> 2.44.0
>

Tested-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>

Best regards,
Rick

