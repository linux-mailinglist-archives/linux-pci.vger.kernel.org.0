Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5415E4E6172
	for <lists+linux-pci@lfdr.de>; Thu, 24 Mar 2022 11:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349383AbiCXKGQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Mar 2022 06:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349384AbiCXKGP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Mar 2022 06:06:15 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4CB9F6CB;
        Thu, 24 Mar 2022 03:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1648116282; x=1679652282;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R5km6m5qxMi3kYpL1LtzFCVr9pY6aeOZnR3nPxQD+cg=;
  b=KT6JwhFT+NhhZgNLEfDZBRmfbCQeJgORG5iA9ckmDCsWwRzBr0tlre0N
   YdahXRW3ysnSGN2vboKDiweOHxt02prASfxyKFqykPT38uNNZyb4U5jg/
   cbuBxijPdxWE4xO9wsvuMBQSo8oHximDH0N0JoOaeeG+xLdJ/g+L7shT1
   BsBA4Ceq+xMrqBJoN9lggtZnqXdQ+qh3QrdkwJsTtW4D19cSSdmMa+QDg
   dpIKmr3NC4zYbkcqZWnjoZcOz9TWMchvkES6F8DbFotbVdHy0d3orAFhp
   WYoEH6ivmd3avWd8PKAGeXZoys28aExctUWL5Nr6KM3gCnAl1SKVasdzQ
   w==;
X-IronPort-AV: E=Sophos;i="5.90,207,1643670000"; 
   d="scan'208";a="22868150"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 24 Mar 2022 11:04:38 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Thu, 24 Mar 2022 11:04:38 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Thu, 24 Mar 2022 11:04:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1648116278; x=1679652278;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R5km6m5qxMi3kYpL1LtzFCVr9pY6aeOZnR3nPxQD+cg=;
  b=W7dPd/dlg79l/gk40VZZGpnKiAL7mp7PguVh6vZf+490e6CNhZV1iltX
   0Ko9TsPQeBJvPvJ4oUk0kDr48IXEEOFRFSx0hGiAvtvJl95lGRaDSwLyC
   r2JOv2CT70/qFC8s6hMLbc+H7ybu6hZJqBFcPQ0Zhuqb2h9ZCBmd+UYrc
   5iuISbm9q4qZa6fc69PsgY4gtdyeaXfQOZlZd2ZGDKMa2Gc/Nml2+fo9p
   GpQ6jE0e57+0dIwjfxvp1/OHseVPzCDMOOa6Q094sFMX2QI2tdN/YXdTG
   AT0oB5wfkHGwK/+8wM/RGo0spi6TpnY2Ha3rEJRQodIwn4Y1dsfdLdUSK
   g==;
X-IronPort-AV: E=Sophos;i="5.90,207,1643670000"; 
   d="scan'208";a="22868149"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 24 Mar 2022 11:04:38 +0100
Received: from steina-w.localnet (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 0242D280065;
        Thu, 24 Mar 2022 11:04:37 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     p.zabel@pengutronix.de, l.stach@pengutronix.de,
        bhelgaas@google.com, lorenzo.pieralisi@arm.com, robh@kernel.org,
        shawnguo@kernel.org, vkoul@kernel.org,
        Richard Zhu <hongxing.zhu@nxp.com>
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com, Richard Zhu <hongxing.zhu@nxp.com>
Subject: Re: (EXT) [PATCH v2 6/7] arm64: dts: imx8mp-evk: Add PCIe support
Date:   Thu, 24 Mar 2022 11:04:35 +0100
Message-ID: <2236205.ElGaqSPkdT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <1646644054-24421-7-git-send-email-hongxing.zhu@nxp.com>
References: <1646644054-24421-1-git-send-email-hongxing.zhu@nxp.com> <1646644054-24421-7-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Richard,

thanks for providing PCIe support for iMX8MP.

Am Montag, 7. M=E4rz 2022, 10:07:33 CET schrieb Richard Zhu:
> Add PCIe support on i.MX8MP EVK board.
>=20
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 55 ++++++++++++++++++++
>  1 file changed, 55 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts index
> 2eb943210678..ed77455a3f73 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> @@ -5,6 +5,7 @@
>=20
>  /dts-v1/;
>=20
> +#include <dt-bindings/phy/phy-imx8-pcie.h>
>  #include "imx8mp.dtsi"
>=20
>  / {
> @@ -33,6 +34,12 @@ memory@40000000 {
>  		      <0x1 0x00000000 0 0xc0000000>;
>  	};
>=20
> +	pcie0_refclk: pcie0-refclk {
> +		compatible =3D "fixed-clock";
> +			#clock-cells =3D <0>;
> +			clock-frequency =3D <100000000>;
> +	};
> +
>  	reg_can1_stby: regulator-can1-stby {
>  		compatible =3D "regulator-fixed";
>  		regulator-name =3D "can1-stby";
> @@ -55,6 +62,17 @@ reg_can2_stby: regulator-can2-stby {
>  		enable-active-high;
>  	};
>=20
> +	reg_pcie0: regulator-pcie {
> +		compatible =3D "regulator-fixed";
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&pinctrl_pcie0_reg>;
> +		regulator-name =3D "MPCIE_3V3";
> +		regulator-min-microvolt =3D <3300000>;
> +		regulator-max-microvolt =3D <3300000>;
> +		gpio =3D <&gpio2 6 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
>  	reg_usdhc2_vmmc: regulator-usdhc2 {
>  		compatible =3D "regulator-fixed";
>  		pinctrl-names =3D "default";
> @@ -297,6 +315,30 @@ pca6416: gpio@20 {
>  	};
>  };
>=20
> +&pcie_phy {
> +	fsl,refclk-pad-mode =3D <IMX8_PCIE_REFCLK_PAD_INPUT>;
> +	clocks =3D <&pcie0_refclk>;
> +	clock-names =3D "ref";
> +	status =3D "okay";
> +};
> +
> +&pcie{
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_pcie0>;
> +	reset-gpio =3D <&gpio2 7 GPIO_ACTIVE_LOW>;
> +	clocks =3D <&clk IMX8MP_CLK_HSIO_ROOT>,
> +		 <&clk IMX8MP_CLK_PCIE_ROOT>,
> +		 <&clk IMX8MP_CLK_HSIO_AXI>;
> +	clock-names =3D "pcie", "pcie_aux", "pcie_bus";

This causes the following warnings in dtbs_check (paths stripped):
imx8mp-evk.dtb: pcie@33800000: clock-names:1: 'pcie_bus' was expected
        From schema: Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.y=
aml
imx8mp-evk.dtb: pcie@33800000: clock-names:2: 'pcie_phy' was expected
        From schema: Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.y=
aml

The bindings want 4 clocks for imx8mq (and imx8mp which seems similar):
* pcie
* pcie_bus
* pcie_phy
* pcie_aux

Ignoring the order there is no pcie_phy clock anymore, it was removed in=20
commit 1840518ae7de ("clk: imx8mp: Remove the none exist pcie clocks"). I w=
as=20
wondering why, because the PCIE_PHY_CLK_ROOT at register 0xa380 inside CCM =
is=20
listed in RM.
So there is a clock missing for 'pcie_phy' or the binding needs some update=
=20
for imx8mp, no?

Regards,
Alexander

> +	assigned-clocks =3D <&clk IMX8MP_CLK_HSIO_AXI>,
> +			  <&clk IMX8MP_CLK_PCIE_AUX>;
> +	assigned-clock-rates =3D <500000000>, <10000000>;
> +	assigned-clock-parents =3D <&clk IMX8MP_SYS_PLL2_500M>,
> +				 <&clk IMX8MP_SYS_PLL2_50M>;
> +	vpcie-supply =3D <&reg_pcie0>;
> +	status =3D "okay";
> +};
> +
>  &snvs_pwrkey {
>  	status =3D "okay";
>  };
> @@ -442,6 +484,19 @@ MX8MP_IOMUXC_I2C3_SDA__I2C3_SDA		0x400001c3
>=20
>  		>;
>=20
>  	};
>=20
> +	pinctrl_pcie0: pcie0grp {
> +		fsl,pins =3D <
> +			MX8MP_IOMUXC_I2C4_SCL__PCIE_CLKREQ_B=09
0x61 /* open drain, pull up */
> +			MX8MP_IOMUXC_SD1_DATA5__GPIO2_IO07=09
0x41
> +		>;
> +	};
> +
> +	pinctrl_pcie0_reg: pcie0reggrp {
> +		fsl,pins =3D <
> +			MX8MP_IOMUXC_SD1_DATA4__GPIO2_IO06=09
0x41
> +		>;
> +	};
> +
>  	pinctrl_pmic: pmicgrp {
>  		fsl,pins =3D <
>  			MX8MP_IOMUXC_GPIO1_IO03__GPIO1_IO03=09
0x000001c0




