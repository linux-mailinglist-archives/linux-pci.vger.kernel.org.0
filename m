Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B56791AF66D
	for <lists+linux-pci@lfdr.de>; Sun, 19 Apr 2020 05:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbgDSDXo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 18 Apr 2020 23:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725879AbgDSDXn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 18 Apr 2020 23:23:43 -0400
Received: from mail.nic.cz (mail.nic.cz [IPv6:2001:1488:800:400::400])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C35EC061A0C;
        Sat, 18 Apr 2020 20:23:43 -0700 (PDT)
Received: from localhost (unknown [172.20.6.135])
        by mail.nic.cz (Postfix) with ESMTPSA id 93A2F140B79;
        Sun, 19 Apr 2020 05:17:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1587266231; bh=2SMeV527Nbyadf6AEvVhwsFqxTEiceDhuMGSBDI9NC0=;
        h=Date:From:To;
        b=DkRiHgjmGQjO7ATQ4kFjd44Ck4jVQwXzL6BbYkulfC80rjPunjE7oROVEK/Atn63N
         i5AKW47UQ3E7O7nTQmI9LpFDbfgcEJlSNT7+bsuyutGZLdsR7+tT+H9FTBPpWl8IdM
         +zricET13s6nTdS6htbH6C1Kl5h9/WwDay9ZUI+o=
Date:   Sun, 19 Apr 2020 05:17:11 +0200
From:   Marek Behun <marek.behun@nic.cz>
To:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Remi Pommarel <repk@triplefau.lt>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 5/8] PCI: aardvark: Set final controller speed based on
 negotiated link speed
Message-ID: <20200419051711.74114791@nic.cz>
In-Reply-To: <20200415160348.1146-1-pali@kernel.org>
References: <20200415160054.951-1-pali@kernel.org>
        <20200415160348.1146-1-pali@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-100.0 required=5.9 tests=SHORTCIRCUIT,
        USER_IN_WHITELIST shortcircuit=ham autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.nic.cz
X-Virus-Scanned: clamav-milter 0.101.4 at mail
X-Virus-Status: Clean
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 15 Apr 2020 18:03:45 +0200
Pali Roh=C3=A1r <pali@kernel.org> wrote:

> Some Compex WLE900VX gen1 cards are unstable or even not detected when
> aardvark PCI controller speed is set to gen2. Moreover when ASPM code tri=
es
> to retrain link second time then these cards stop responding and link goes
> down. If aardvark PCI controller is set to gen1 then these cards work fine
> without any problem.
>=20
> Unconditionally forcing aardvark controller to gen1 speed (either via DT
> property max-link-speed or hardcoded value in driver itself) is not a
> solution as it would have performance impact for fast gen2 sata cards.
>=20
> To overcome this problem, try all 3 possible speeds (gen3, gen2, gen1)
> supported by aardvark PCI controller with respect to max-link-speed setti=
ng
> and after successful link training choose final controller speed based on
> Negotiated Link Speed from Link Status register, which should match card
> speed.
>=20
> I tested this change with Compex cards WLE200NX (pcie 1.0, gen1, ath9k),
> WLE900VX (pcie 1.1, gen1, ath10k) and WLE1216V5-20 (pcie 2.0, gen2, ath10=
k)
> on Turris MOX. Tomasz Maciej Nowak tested JJPlus JWX6051 (ath9k), Intel
> 622ANHMW, MT76 U7612E-H1 and Compex WLE1216V2-20 cards on Espressobin.
>=20
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> ---
>  drivers/pci/controller/pci-aardvark.c | 35 +++++++++++++++++++++++++--
>  1 file changed, 33 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controll=
er/pci-aardvark.c
> index 02c69fc9aadf..a83bbc86e428 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@ -40,6 +40,7 @@
>  #define PCIE_CORE_LINK_CTRL_STAT_REG				0xd0
>  #define     PCIE_CORE_LINK_L0S_ENTRY				BIT(0)
>  #define     PCIE_CORE_LINK_TRAINING				BIT(5)
> +#define     PCIE_CORE_LINK_SPEED_SHIFT				16
>  #define     PCIE_CORE_LINK_WIDTH_SHIFT				20
>  #define PCIE_CORE_ERR_CAPCTL_REG				0x118
>  #define     PCIE_CORE_ERR_CAPCTL_ECRC_CHK_TX			BIT(5)
> @@ -276,7 +277,7 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
>  {
>  	struct device *dev =3D &pcie->pdev->dev;
>  	struct device_node *node =3D dev->of_node;
> -	int max_link_speed;
> +	int max_link_speed, neg_link_speed;
>  	u32 reg;
> =20
>  	/* Set to Direct mode */
> @@ -378,7 +379,37 @@ static void advk_pcie_setup_hw(struct advk_pcie *pci=
e)
>  	reg |=3D PCIE_CORE_LINK_TRAINING;
>  	advk_writel(pcie, reg, PCIE_CORE_LINK_CTRL_STAT_REG);
> =20
> -	advk_pcie_wait_for_link(pcie);
> +	do {
> +		if (advk_pcie_wait_for_link(pcie) < 0) {
> +			max_link_speed--;
> +		} else {
> +			reg =3D advk_readl(pcie, PCIE_CORE_LINK_CTRL_STAT_REG);
> +
> +			neg_link_speed =3D
> +				(reg >> PCIE_CORE_LINK_SPEED_SHIFT) & 0xf;
> +			dev_info(dev, "negotiated link speed %d\n",
> +				neg_link_speed);
> +
> +			if (neg_link_speed =3D=3D max_link_speed)
> +				break;
> +
> +			if (neg_link_speed > 0 && neg_link_speed <=3D 3)
> +				max_link_speed =3D neg_link_speed;
> +			else
> +				max_link_speed--;
> +		}
> +
> +		if (max_link_speed =3D=3D 0)
> +			break;
> +
> +		/* Set new decreased max link speed */
> +		advk_pcie_setup_link_speed(pcie, max_link_speed);
> +
> +		/* And start link training again */
> +		reg =3D advk_readl(pcie, PCIE_CORE_LINK_CTRL_STAT_REG);
> +		reg |=3D PCIE_CORE_LINK_TRAINING;
> +		advk_writel(pcie, reg, PCIE_CORE_LINK_CTRL_STAT_REG);
> +	} while (1);
> =20

This do {} while(1) should be a for cycle iterating the max_link_speed
variable, and probably in a separate function
advk_pcie_negotiate_link_speed.

A3700, which is the only SOC to use this driver, does not support PCIe
gen 3, so this shouldn't be tried, at least if
.compatible =3D=3D "marvell,armada-3700-pcie".

Marek
