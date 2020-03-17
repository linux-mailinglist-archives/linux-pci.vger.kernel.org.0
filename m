Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34B16187A15
	for <lists+linux-pci@lfdr.de>; Tue, 17 Mar 2020 07:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725872AbgCQG7b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Mar 2020 02:59:31 -0400
Received: from mail-eopbgr1400139.outbound.protection.outlook.com ([40.107.140.139]:20762
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725794AbgCQG7b (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Mar 2020 02:59:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S+f+WDnSpMXdh2HyiGWGsfj+RocSy08aznAMfXJHZTae/qme0sugB2gFljGghtAvkvopGBnw+UZLpUntbb0zmM1ortreDmBvCN69TfmUKMe6ThkFCcn3QASrARSjHd2Mg7R1mEM7MTkFn1GSIVLNozyBlNUiwYAFKonoCihsN1vpQvyrsVRtjH0Ce0GXaMqk8AatoxP5PbR6bbhN3BUyVe1L8iAJC5SVlmhIrbs5A1bGxl4mMRQ7wAtbX+t2t+VRUP3mJD1hJIeBOrmuWAM292TBvCqPv9S0B0loo7sG6h5cenlRLs+apjFCvAjqS9lmCsjhtDR3BU6nmjLdKuYtuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bvgBaiYMFl65vwB9pUqq2lPz6PHp29Rl9ZCxeQoChxU=;
 b=f7kITLagq1uEE4O4kI805DCcWDT4bPUCj7GxMLG1VpXqLla3a3SpwHjg5t4nm9bYbNWKBI5iTdJonA3a4xAzrj3Z30YNfrZeZp9OsNHJATFj0s9cvyPpKyYxVpQNvbiajc0LlU+po5u2xPac2rCjb5SiTUiw5BOii8dTH4Vt4eQG+FS5hSvnP55gNfkG3lV71UwW5azyROtVtwMug7vbslG+kZ6VNEmwi2Ld+2FlO3nqLavOAEAjel5g6AhYpxyknR+JXYkS9UwEmWvLyqG0UaZGMHgIApX/V/WX6xAlTz0lUaQ4qPDcvRY1+yTq7WXyDsmnl33IFcxrcpc29jXWYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bvgBaiYMFl65vwB9pUqq2lPz6PHp29Rl9ZCxeQoChxU=;
 b=rf0qVzXBJJTkrMcLzSMyVKslXcC+/VTMQhcXj0/l3UyU3znzQ6m0rwsyVMp3R0/M6OXeKcpsFUa+3hv5tOvk9hE9EZKskDUthSe1zelOkY2LKiRYj448I4dpJOyim9Ysm7iZN6Zj2+jYurKUwRF+29w9gDKeR5oPJPHy3ZqyjAI=
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.175.203) by
 TYAPR01MB2271.jpnprd01.prod.outlook.com (52.133.177.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.22; Tue, 17 Mar 2020 06:59:27 +0000
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::ed7f:1268:55a9:fc06]) by TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::ed7f:1268:55a9:fc06%4]) with mapi id 15.20.2814.021; Tue, 17 Mar 2020
 06:59:26 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Lad Prabhakar <prabhakar.csengg@gmail.com>
CC:     Andrew Murray <andrew.murray@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v5 1/7] PCI: rcar: Rename pcie-rcar.c to pcie-rcar-host.c
Thread-Topic: [PATCH v5 1/7] PCI: rcar: Rename pcie-rcar.c to pcie-rcar-host.c
Thread-Index: AQHV7k2WVIVkhQSkg0uFpKD+VtIGFahMctrQ
Date:   Tue, 17 Mar 2020 06:59:26 +0000
Message-ID: <TYAPR01MB4544CBB9CD07CAF55D7D3845D8F60@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <20200228154122.14164-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200228154122.14164-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20200228154122.14164-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [124.210.22.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 67a28bf4-cb8a-4cc7-c1e4-08d7ca40bb89
x-ms-traffictypediagnostic: TYAPR01MB2271:|TYAPR01MB2271:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB22715B73A1D612DC16835B5BD8F60@TYAPR01MB2271.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0345CFD558
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(396003)(136003)(39860400002)(366004)(376002)(199004)(8936002)(81166006)(8676002)(81156014)(33656002)(2906002)(86362001)(7416002)(478600001)(6916009)(55236004)(5660300002)(316002)(6506007)(54906003)(7696005)(66946007)(52536014)(71200400001)(66446008)(66556008)(64756008)(66476007)(76116006)(186003)(4326008)(107886003)(26005)(9686003)(55016002);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB2271;H:TYAPR01MB4544.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rbGSTNjEH0FVbOC7gK8csi0H0+rctePEOQAAJcOkLbYyQNdlTsvHhbouYb+FXCXeLDTJetCFqdD4mwsP32lZ3mlpP+0UiERdR28pQ4iONdOazgdzAhc6smaUeq2t8vdh0/Fj2TJzIvJ+H4uh9yzrPYJPkSEt32a918qWYIUAnpMpDM1ICP+kNMS1J5O7yuGuQ1+BcpzOc0Ou3AL3oUO+Oa43PGXIvDQ6tV3MWSRtKZRFWCzdzh72bU9trLRqVCXwO1V3y1/uoZKNtY94AlDVmpvwpks+Yq0+e0GkW8FFSmm0U8yllTFVp3jgBiG4Ob/+6rO1SRtiQzITpHC0cl1XTJCs2apwkc35o0lKkiyY7EljyCPbnktWSpxO41b5TBwPULgAm7fVq6Ma3gadlzitokLIewdr/cr9ClbVDUOI78UjbPfdoCfQxzGMLsDYuari
x-ms-exchange-antispam-messagedata: tK/Ev2ARZR9LoKUufpPKieQM4f7zRapAXzfdqzbzU8mf4X6kNPWxn0o9zLXCgZTNoT43lu9ZijxYXcBRCj+DCYt+CIXQ9G1QBd4xgbQdkeoGPiu5bS6LaiRVmqlzW7zYIw9o0OQ5RoPddCyIiYYk+A==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67a28bf4-cb8a-4cc7-c1e4-08d7ca40bb89
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2020 06:59:26.7500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UDbEkOriX71qBSGDakZGlMIrNusMpgrTvwm/M2+uBfPV1NrCQ48n+qk3j6J4dmgnjK+EweteNHojyx3SlCIc1Wv3xIasjnlmAzL+6K9bsyWns4zcZ3jhr/dJ7F0jDFz6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2271
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Prabhakar-san,

Thank you for the patch!

> From: Lad Prabhakar, Sent: Saturday, February 29, 2020 12:41 AM

Since your email account is different with the Singed-off-by,
I think you should add your From: tag here like your v2 patch series.

> This commit renames pcie-rcar.c to pcie-rcar-host.c in preparation for
> adding support for endpoint mode. CONFIG_PCIE_RCAR is also renamed to
> CONFIG_PCIE_RCAR_HOST to match the driver name accordingly.
>=20
> In addition to this defconfig file has also been updated to match the new
> config option.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  arch/arm64/configs/defconfig                             | 2 +-
>  drivers/pci/controller/Kconfig                           | 7 ++++---
>  drivers/pci/controller/Makefile                          | 2 +-
>  drivers/pci/controller/{pcie-rcar.c =3D> pcie-rcar-host.c} | 0
>  4 files changed, 6 insertions(+), 5 deletions(-)
>  rename drivers/pci/controller/{pcie-rcar.c =3D> pcie-rcar-host.c} (100%)
>=20
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 0f21288..7a34fce 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -185,7 +185,7 @@ CONFIG_HOTPLUG_PCI=3Dy
>  CONFIG_HOTPLUG_PCI_ACPI=3Dy
>  CONFIG_PCI_AARDVARK=3Dy
>  CONFIG_PCI_TEGRA=3Dy
> -CONFIG_PCIE_RCAR=3Dy
> +CONFIG_PCIE_RCAR_HOST=3Dy

I think you should separate this change.
To avoid this, I have an idea in the Kconfig like below:
 - adding PCIE_RCAR_HOST.
 - keeping PCIE_RCAR and select PCIE_RCAR_HOST here.
 - adding a description in the help of PCIE_RCAR like "This will be removed=
 after defconfig is updated" is better.

The following is a sample. What do you think?
---
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -58,8 +58,18 @@ config PCIE_RCAR
 	bool "Renesas R-Car PCIe controller"
 	depends on ARCH_RENESAS || COMPILE_TEST
 	depends on PCI_MSI_IRQ_DOMAIN
+	select PCIE_RCAR_HOST
 	help
 	  Say Y here if you want PCIe controller support on R-Car SoCs.
+	  This will be removed after defconfig is updated.
+
+config PCIE_RCAR_HOST
+	bool "Renesas R-Car PCIe host controller"
+	depends on ARCH_RENESAS || COMPILE_TEST
+	depends on PCI_MSI_IRQ_DOMAIN
+	help
+	  Say Y here if you want PCIe controller support on R-Car SoCs in host
+	  mode.
=20
 config PCI_HOST_COMMON
 	bool
---

Best regards,
Yoshihiro Shimoda

>  CONFIG_PCI_HOST_GENERIC=3Dy
>  CONFIG_PCI_XGENE=3Dy
>  CONFIG_PCIE_ALTERA=3Dy
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kcon=
fig
> index f84e5ff..37e0ea7 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -54,12 +54,13 @@ config PCI_RCAR_GEN2
>  	  There are 3 internal PCI controllers available with a single
>  	  built-in EHCI/OHCI host controller present on each one.
>=20
> -config PCIE_RCAR
> -	bool "Renesas R-Car PCIe controller"
> +config PCIE_RCAR_HOST
> +	bool "Renesas R-Car PCIe host controller"
>  	depends on ARCH_RENESAS || COMPILE_TEST
>  	depends on PCI_MSI_IRQ_DOMAIN
>  	help
> -	  Say Y here if you want PCIe controller support on R-Car SoCs.
> +	  Say Y here if you want PCIe controller support on R-Car SoCs in host
> +	  mode.
>=20
>  config PCI_HOST_COMMON
>  	bool
> diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Mak=
efile
> index 01b2502..4ca2da6 100644
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
> 2.7.4

