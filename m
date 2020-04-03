Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6DB519D180
	for <lists+linux-pci@lfdr.de>; Fri,  3 Apr 2020 09:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389688AbgDCHwh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Apr 2020 03:52:37 -0400
Received: from mail-eopbgr1410128.outbound.protection.outlook.com ([40.107.141.128]:25728
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387655AbgDCHwg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 3 Apr 2020 03:52:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iPRIrJJM6DxIZWlrxX25J6inykH3kNU1OqnkZswOovcXKjUbzh88VLHzsBlYEM1z4E0Jdsz1uNIgkrDovJXGMi/ztGUQl40lP9RNAEvoslGn0VH8Lm5IzI+d9RKOTYrDmYLK7GdaaprXM+VBrFTfkUn/IhCOK+9Z1YeNEuRbKSQt1rYBLWb4NSFc8XBZIAOq518gW5Uk0tWoLAMKGBFErDkL87OOUAQq3Gk9qR8qL2tPiRK6DCXRcndvAlsCuzUgOZfPQvqo3wYkYuaowXGrNZGKaWm82urMFLzJn6UT6USzFNPmMm4nkAl7LABlfLHe6kdYh4aZyrCvS3bRidgbkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0p2YS2jzhjkQFt0D189Yj1uzwU6BrprkwNoIo/IMRQ=;
 b=LqOXBhxSCjJS5SgRDYh6jdJmQgu+cbdGyZYXjnB4yzYZARJqfVeO0j5LTU1vU8Anyed4F6Hp/2s85lBWlev83AP77J+wWOX+Y1Rni4jiaXlExr9lSFTnO9LaZGAtqFevfQb4QSQK+Sya9xNSzbYzmXRc0QbwlDh2/VwicQ8A3MtS1jTSKIkYP9+5dW+YTc2F/7ezqMtdrCwYbL5H/25IEMWhhQMCqE/m4c5Mxz8jf+nT+mf1KitfKXZj7BpRwu6JwZY2b0z8FZyvE9+4FMWwPOXwZSVLA9WCjJr7Uo722m+x3EP/kfAEjySb0oETf46+a6kRzIYpEuklfdst4rF8wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0p2YS2jzhjkQFt0D189Yj1uzwU6BrprkwNoIo/IMRQ=;
 b=YNSyhomkhNDNGy6WwrQv/xgQO4HXcSuMQws2WG8pAVE6i1pPhCI22LZMOKgPqjuX9evOj6gqSqAhxt+IrExBdXuksWaQCxFxG9qfHS3AvUjyU1sABIKzNHKEsiHreOe95Lco8C6KQcYgSuqeGvhoIomjX9mjF6rr95b8231wFZE=
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.175.203) by
 TYAPR01MB2831.jpnprd01.prod.outlook.com (20.177.105.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.16; Fri, 3 Apr 2020 07:52:30 +0000
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::ed7f:1268:55a9:fc06]) by TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::ed7f:1268:55a9:fc06%4]) with mapi id 15.20.2878.017; Fri, 3 Apr 2020
 07:52:30 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Murray <andrew.murray@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Simon Horman <horms@verge.net.au>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Heiko Stuebner <heiko@sntech.de>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        Lad Prabhakar <prabhakar.csengg@gmail.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v6 01/11] PCI: rcar: Rename pcie-rcar.c to
 pcie-rcar-host.c
Thread-Topic: [PATCH v6 01/11] PCI: rcar: Rename pcie-rcar.c to
 pcie-rcar-host.c
Thread-Index: AQHWCSZbXsVurzSitUKuta8LtwfZKahnBwTg
Date:   Fri, 3 Apr 2020 07:52:29 +0000
Message-ID: <TYAPR01MB4544C0756D781BB6545423E3D8C70@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <1585856319-4380-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1585856319-4380-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1585856319-4380-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [124.210.22.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a8c5ebf7-f909-45ba-fdc8-08d7d7a3f603
x-ms-traffictypediagnostic: TYAPR01MB2831:|TYAPR01MB2831:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB2831E7DE898E43584BAC8BC0D8C70@TYAPR01MB2831.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:546;
x-forefront-prvs: 0362BF9FDB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB4544.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(366004)(376002)(396003)(136003)(39860400002)(346002)(66946007)(66556008)(33656002)(6506007)(55236004)(76116006)(66446008)(64756008)(66476007)(26005)(9686003)(86362001)(2906002)(55016002)(316002)(81156014)(4326008)(478600001)(107886003)(7416002)(5660300002)(71200400001)(81166006)(52536014)(7696005)(110136005)(54906003)(8936002)(186003)(8676002)(921003)(1121003);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FlZ5e1W1Jwwgk49Rb23U/0VpPtLkeYYl0KWEmoEpk9ybnZbu9iefQuRWDvQvPfNLbvJCLnW3HnPZ3M9Jg2/XaNDoltlQvqeL/K0wn8nlF795mkA2Hk9x8f884EfWPo+i+Vr6Twa+iKwnH7Ct1+OS8GB70aQhMIKN9epgJx6hRwE0pH6iajZ/ykvGO3az93AcnHu1+5LGuYh5hPY9q9sONpCIHdhqCTlu5j9YI0K/u3IcF9707Ha+9ZpgRO/s0yMk8HFmbpeE0l6YEKaACEnlZbi3i91jk1FUm2fXh4tzk/HAw7uT2tGkC1Q+HsKZ77Zbn29hOt+a/VKlNuBkLEwHhFvg+ut8R8GpxkcYrgsw99iSOctLlKuWcUoqm8PMiFfZJ6OSaTxhkTzFroF4M/FXG4YfbrdSjsNdeHORtMncmkGpR5VO0P1FIZ9b1kDqpq4qbo7PXF2gui63LQ/XObH8WjqX+ui92ELHo+KNevmbTyq6qCdUJaWedvJddfYMlQD/
x-ms-exchange-antispam-messagedata: Tzqtdux/9zhTLulNPXfem+wGmP7LUwT0uW3Y88WAQh+tLZ8SMzZib8/54MBQjWt6uOfl46oJxieUHfFv6H+3kqHHyo5JN4Q/koDF5Pu/yyr7ClVxeCLBnX1heZWE+XHkbEQU8GS7Rv1wezFrb3vZrw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8c5ebf7-f909-45ba-fdc8-08d7d7a3f603
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2020 07:52:30.0643
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yK2ovDTL3eAh1QKVQz46ROnMd4OaToFC4Mtx7LUEav6Vz102LRr02wL0n0p/MtEsSE8axKXdoYKH6CoGdRUv6AL/DTlHdrHCGRzyGFL4WzZkABPgS0cVo2XmP+PaN9eM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2831
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Prabhakar-san,

> From: Lad Prabhakar, Sent: Friday, April 3, 2020 4:38 AM
>=20
> This commit renames pcie-rcar.c to pcie-rcar-host.c in preparation for
> adding support for endpoint mode. CONFIG_PCIE_RCAR is kept so that arm64
> defconfig change can be a separate patch.
>=20
> With this patch both config options PCIE_RCAR and PCIE_RCAR_HOST will be
> available but PCIE_RCAR internally selects PCIE_RCAR_HOST so that bisect
> builds wont be affected.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thank you for the patch!

Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda

> ---
>  drivers/pci/controller/Kconfig                         | 10 ++++++++++
>  drivers/pci/controller/Makefile                        |  2 +-
>  .../pci/controller/{pcie-rcar.c =3D> pcie-rcar-host.c}   |  0
>  3 files changed, 11 insertions(+), 1 deletion(-)
>  rename drivers/pci/controller/{pcie-rcar.c =3D> pcie-rcar-host.c} (100%)
>=20
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kcon=
fig
> index af0f0bc11917..cfdc898450d0 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -58,8 +58,18 @@ config PCIE_RCAR
>  	bool "Renesas R-Car PCIe controller"
>  	depends on ARCH_RENESAS || COMPILE_TEST
>  	depends on PCI_MSI_IRQ_DOMAIN
> +	select PCIE_RCAR_HOST
>  	help
>  	  Say Y here if you want PCIe controller support on R-Car SoCs.
> +	  This option will be removed after arm64 defconfig is updated.
> +
> +config PCIE_RCAR_HOST
> +	bool "Renesas R-Car PCIe host controller"
> +	depends on ARCH_RENESAS || COMPILE_TEST
> +	depends on PCI_MSI_IRQ_DOMAIN
> +	help
> +	  Say Y here if you want PCIe controller support on R-Car SoCs in host
> +	  mode.
>=20
>  config PCI_HOST_COMMON
>  	bool
> diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Mak=
efile
> index 158c59771824..9dbccb5b24e1 100644
> --- a/drivers/pci/controller/Makefile
> +++ b/drivers/pci/controller/Makefile
> @@ -7,7 +7,7 @@ obj-$(CONFIG_PCI_MVEBU) +=3D pci-mvebu.o
>  obj-$(CONFIG_PCI_AARDVARK) +=3D pci-aardvark.o
>  obj-$(CONFIG_PCI_TEGRA) +=3D pci-tegra.o
>  obj-$(CONFIG_PCI_RCAR_GEN2) +=3D pci-rcar-gen2.o
> -obj-$(CONFIG_PCIE_RCAR) +=3D pcie-rcar.o
> +obj-$(CONFIG_PCIE_RCAR_HOST) +=3D pcie-rcar-host.o
>  obj-$(CONFIG_PCI_HOST_COMMON) +=3D pci-host-common.o
>  obj-$(CONFIG_PCI_HOST_GENERIC) +=3D pci-host-generic.o
>  obj-$(CONFIG_PCIE_XILINX) +=3D pcie-xilinx.o
> diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/=
pcie-rcar-host.c
> similarity index 100%
> rename from drivers/pci/controller/pcie-rcar.c
> rename to drivers/pci/controller/pcie-rcar-host.c
> --
> 2.20.1

