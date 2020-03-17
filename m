Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62E93187B2C
	for <lists+linux-pci@lfdr.de>; Tue, 17 Mar 2020 09:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgCQI1B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Mar 2020 04:27:01 -0400
Received: from mail-eopbgr1410103.outbound.protection.outlook.com ([40.107.141.103]:9400
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726272AbgCQI1A (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Mar 2020 04:27:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yz1OXHwff72d8k9ZbgwHr5/KDy7ODmaW66wLZjrXxClulS+Q8BNt/FryCHjCuhIFPTM4oW2Q/lI26qYJp9doGzrDNq8Oe1OpKh1ScF7BmFqO8zxNe/bFwjyHimw4rOcLgOki9DA9hPLJw5/c8UjCXdmv+XpklFmzT9lZxog4u2KxrneUAc5jBxJTVJreJM6HfCnrnL1JKTHBxC0tMu5zq/1dBF9Ub+V+F6J1SHEqESStWdyiDScfQFkNqMULuKGdj3lJ4ntzDX/3iS47xw0RfJGNQB594Cacky4zISe03Guu7LUG8UBwv/X11u/t04m5VmxFdSol1siL9SLkMiVNIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1gEkCI98zl7L29eWbZ6rnF8Wmpwo2CBJXV5ctD3dag=;
 b=A1C05eeVHTADb4bF8zmNgrZX4syM6o9GlsP6JYNbLZCWq0M0MQIzKG8KyphjpmoVuE2L6BF5qEFi1OhvQmujmWyrPL+DoiLMJmBNBikYeMc1UPDfZaqSnZnLiLV4tz0szgUsENVWSdvyY8E1ER25pyMzTBUt71tGj9ZJG7ew0afDqIb6zaoAE6Ozn0fbOIboLCu07iIAKuT52NKQopiQaeFBcA5o66awOYHQNACZag5yIcECcE0ERdKV67PwM4kYACQJ7NZuM7w5+sSWCaF95tSNYxbcl9mAZRMUtcs7p+DCk7RAoYZnS4pHWrMOObhVJ4udQSJJvchd5ddQrToQfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1gEkCI98zl7L29eWbZ6rnF8Wmpwo2CBJXV5ctD3dag=;
 b=NY3l3S9giVoUIyHtzxoYjTYXZbVQebKZ3/BkDG2ROTukwK5v4/9mBTA8wIB9N26QaAlwGYsW64NGkLU1MGyJneku8JqxFr9NHSF5r+PIoHBcpf5V0jIwzvddUgf12dVhibBGjoTt5WpgLwQDvY7QvTpSfydEpMXHIucLV+AI7Kk=
Received: from OSBPR01MB3590.jpnprd01.prod.outlook.com (20.178.97.80) by
 OSBPR01MB4744.jpnprd01.prod.outlook.com (20.179.182.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.16; Tue, 17 Mar 2020 08:26:54 +0000
Received: from OSBPR01MB3590.jpnprd01.prod.outlook.com
 ([fe80::490:aa83:2d09:3a0b]) by OSBPR01MB3590.jpnprd01.prod.outlook.com
 ([fe80::490:aa83:2d09:3a0b%5]) with mapi id 15.20.2814.021; Tue, 17 Mar 2020
 08:26:53 +0000
From:   Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lad Prabhakar <prabhakar.csengg@gmail.com>
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
        Heiko Stuebner <heiko@sntech.de>
Subject: RE: [PATCH v5 1/7] PCI: rcar: Rename pcie-rcar.c to pcie-rcar-host.c
Thread-Topic: [PATCH v5 1/7] PCI: rcar: Rename pcie-rcar.c to pcie-rcar-host.c
Thread-Index: AQHV7k2X6mltGGzBFUuO7BIKhB4Qs6hMdpUAgAAWhjA=
Date:   Tue, 17 Mar 2020 08:26:53 +0000
Message-ID: <OSBPR01MB359098590FC973A243BBCE2CAAF60@OSBPR01MB3590.jpnprd01.prod.outlook.com>
References: <20200228154122.14164-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200228154122.14164-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <TYAPR01MB4544CBB9CD07CAF55D7D3845D8F60@TYAPR01MB4544.jpnprd01.prod.outlook.com>
In-Reply-To: <TYAPR01MB4544CBB9CD07CAF55D7D3845D8F60@TYAPR01MB4544.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=prabhakar.mahadev-lad.rj@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 123a1227-f313-4ab3-f199-08d7ca4cf2f9
x-ms-traffictypediagnostic: OSBPR01MB4744:|OSBPR01MB4744:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSBPR01MB4744A7CA52266C3E3C9684F3AAF60@OSBPR01MB4744.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0345CFD558
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(366004)(136003)(376002)(346002)(39860400002)(199004)(4326008)(186003)(26005)(66476007)(2906002)(76116006)(66946007)(64756008)(66556008)(86362001)(8936002)(33656002)(66446008)(5660300002)(55016002)(52536014)(81166006)(478600001)(81156014)(8676002)(9686003)(6506007)(53546011)(316002)(110136005)(54906003)(7696005)(71200400001)(7416002);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB4744;H:OSBPR01MB3590.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nZaUnogw+52S0Jmrz8XQIVZggbPsB6dlny7Sr+ZljnoP58cnLopiYhWW0TY+zjX+8MnLOmA3V0xJ1i17jR3jMUPQbCAj6TI6Q+FdWCfNbpaksXO8WKYjmCTHdOyPggFHjsQhEpEwWvAEjclBLIp+4EL8zQjPrBWUoJMs/kamocSo+SOiCddUAdWA4TWLo8VyAz8J2LRMw2WS9YPTLl5TyfWf4zR62cSAwg3MXDh7hv/lNs64rPPnWEW9cSte/VlUFD/9bHUbIKJzTiYXbnzi59Ggo8x+ECpiirzAMFFjLrcksqEoC98jcjdXfdH9Xp9eMWWULiu+TrgL3GEIuVO2E8jjbL0FC7xRHad/LqEnJkPMVKCYjRyRygqxXqWC2MfC5X2f98IIKctVrcGE07cbpTrFv/ntByaWxiq8N/ykLLnW+PCRCzzDn89qQHXehh0i
x-ms-exchange-antispam-messagedata: L4QyeWQSvUPAxUtnFux0fHubp3vlCRynXNp1P4X9KXzcZLJ9bKlyGi7FbWjP6vr8j/jCPEhdMrtWV9Lhn8NZ/jhRiu7OpAV2qiV5PIOyBhSbwAK+IPiTMGyb5eoL26uC1+vjMcoOj8ghyWKeKf9MHw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 123a1227-f313-4ab3-f199-08d7ca4cf2f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2020 08:26:53.6587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e7kQp1PvJHYyXmeZ8zzeJ3hEdEH746Luc2EMESIvAbspBE61ttHYD8wJj9kYOI8q8HQKWY2la0f7b6NM/oZ4iSStm8BB44zOQZ/ITitbDW0OjBNKIw4psIzDtZJIPqiJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4744
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Yoshihiro-San,

Thank you for the review.

> -----Original Message-----
> From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Sent: 17 March 2020 06:59
> To: Lad Prabhakar <prabhakar.csengg@gmail.com>
> Cc: Andrew Murray <andrew.murray@arm.com>; linux-pci@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; linux-renesas-soc@vger.kernel.org;
> linux-rockchip@lists.infradead.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; Bjorn Helgaas <bhelgaas@google.com>; Rob
> Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>;
> Catalin Marinas <catalin.marinas@arm.com>; Will Deacon <will@kernel.org>;
> Kishon Vijay Abraham I <kishon@ti.com>; Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com>; Arnd Bergmann <arnd@arndb.de>; Greg
> Kroah-Hartman <gregkh@linuxfoundation.org>; Jingoo Han
> <jingoohan1@gmail.com>; Gustavo Pimentel
> <gustavo.pimentel@synopsys.com>; Marek Vasut
> <marek.vasut+renesas@gmail.com>; Shawn Lin <shawn.lin@rock-
> chips.com>; Heiko Stuebner <heiko@sntech.de>; Prabhakar Mahadev Lad
> <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: RE: [PATCH v5 1/7] PCI: rcar: Rename pcie-rcar.c to pcie-rcar-ho=
st.c
>
> Hi Prabhakar-san,
>
> Thank you for the patch!
>
> > From: Lad Prabhakar, Sent: Saturday, February 29, 2020 12:41 AM
>
> Since your email account is different with the Singed-off-by, I think you
> should add your From: tag here like your v2 patch series.
>
> > This commit renames pcie-rcar.c to pcie-rcar-host.c in preparation for
> > adding support for endpoint mode. CONFIG_PCIE_RCAR is also renamed to
> > CONFIG_PCIE_RCAR_HOST to match the driver name accordingly.
> >
> > In addition to this defconfig file has also been updated to match the
> > new config option.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-
> lad.rj@bp.renesas.com>
> > ---
> >  arch/arm64/configs/defconfig                             | 2 +-
> >  drivers/pci/controller/Kconfig                           | 7 ++++---
> >  drivers/pci/controller/Makefile                          | 2 +-
> >  drivers/pci/controller/{pcie-rcar.c =3D> pcie-rcar-host.c} | 0
> >  4 files changed, 6 insertions(+), 5 deletions(-)  rename
> > drivers/pci/controller/{pcie-rcar.c =3D> pcie-rcar-host.c} (100%)
> >
> > diff --git a/arch/arm64/configs/defconfig
> > b/arch/arm64/configs/defconfig index 0f21288..7a34fce 100644
> > --- a/arch/arm64/configs/defconfig
> > +++ b/arch/arm64/configs/defconfig
> > @@ -185,7 +185,7 @@ CONFIG_HOTPLUG_PCI=3Dy
> CONFIG_HOTPLUG_PCI_ACPI=3Dy
> > CONFIG_PCI_AARDVARK=3Dy  CONFIG_PCI_TEGRA=3Dy -
> CONFIG_PCIE_RCAR=3Dy
> > +CONFIG_PCIE_RCAR_HOST=3Dy
>
> I think you should separate this change.
> To avoid this, I have an idea in the Kconfig like below:
>  - adding PCIE_RCAR_HOST.
>  - keeping PCIE_RCAR and select PCIE_RCAR_HOST here.
>  - adding a description in the help of PCIE_RCAR like "This will be remov=
ed
> after defconfig is updated" is better.
>
> The following is a sample. What do you think?
Sound like a plan will do that, I will just append the description "This wi=
ll be removed
after defconfig is updated" to PCIE_RCAR config option.

Cheers,
--Prabhakar

> ---
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -58,8 +58,18 @@ config PCIE_RCAR
>  bool "Renesas R-Car PCIe controller"
>  depends on ARCH_RENESAS || COMPILE_TEST
>  depends on PCI_MSI_IRQ_DOMAIN
> +select PCIE_RCAR_HOST
>  help
>    Say Y here if you want PCIe controller support on R-Car SoCs.
> +  This will be removed after defconfig is updated.
> +
> +config PCIE_RCAR_HOST
> +bool "Renesas R-Car PCIe host controller"
> +depends on ARCH_RENESAS || COMPILE_TEST
> +depends on PCI_MSI_IRQ_DOMAIN
> +help
> +  Say Y here if you want PCIe controller support on R-Car SoCs in host
> +  mode.
>
>  config PCI_HOST_COMMON
>  bool
> ---
>
> Best regards,
> Yoshihiro Shimoda
>
> >  CONFIG_PCI_HOST_GENERIC=3Dy
> >  CONFIG_PCI_XGENE=3Dy
> >  CONFIG_PCIE_ALTERA=3Dy
> > diff --git a/drivers/pci/controller/Kconfig
> > b/drivers/pci/controller/Kconfig index f84e5ff..37e0ea7 100644
> > --- a/drivers/pci/controller/Kconfig
> > +++ b/drivers/pci/controller/Kconfig
> > @@ -54,12 +54,13 @@ config PCI_RCAR_GEN2
> >    There are 3 internal PCI controllers available with a single
> >    built-in EHCI/OHCI host controller present on each one.
> >
> > -config PCIE_RCAR
> > -bool "Renesas R-Car PCIe controller"
> > +config PCIE_RCAR_HOST
> > +bool "Renesas R-Car PCIe host controller"
> >  depends on ARCH_RENESAS || COMPILE_TEST
> >  depends on PCI_MSI_IRQ_DOMAIN
> >  help
> > -  Say Y here if you want PCIe controller support on R-Car SoCs.
> > +  Say Y here if you want PCIe controller support on R-Car SoCs in host
> > +  mode.
> >
> >  config PCI_HOST_COMMON
> >  bool
> > diff --git a/drivers/pci/controller/Makefile
> > b/drivers/pci/controller/Makefile index 01b2502..4ca2da6 100644
> > --- a/drivers/pci/controller/Makefile
> > +++ b/drivers/pci/controller/Makefile
> > @@ -7,7 +7,7 @@ obj-$(CONFIG_PCI_MVEBU) +=3D pci-mvebu.o
> >  obj-$(CONFIG_PCI_AARDVARK) +=3D pci-aardvark.o
> >  obj-$(CONFIG_PCI_TEGRA) +=3D pci-tegra.o
> >  obj-$(CONFIG_PCI_RCAR_GEN2) +=3D pci-rcar-gen2.o
> > -obj-$(CONFIG_PCIE_RCAR) +=3D pcie-rcar.o
> > +obj-$(CONFIG_PCIE_RCAR_HOST) +=3D pcie-rcar-host.o
> >  obj-$(CONFIG_PCI_HOST_COMMON) +=3D pci-host-common.o
> >  obj-$(CONFIG_PCI_HOST_GENERIC) +=3D pci-host-generic.o
> >  obj-$(CONFIG_PCIE_XILINX) +=3D pcie-xilinx.o diff --git
> > a/drivers/pci/controller/pcie-rcar.c
> > b/drivers/pci/controller/pcie-rcar-host.c
> > similarity index 100%
> > rename from drivers/pci/controller/pcie-rcar.c
> > rename to drivers/pci/controller/pcie-rcar-host.c
> > --
> > 2.7.4



Renesas Electronics Europe GmbH, Geschaeftsfuehrer/President: Carsten Jauch=
, Sitz der Gesellschaft/Registered office: Duesseldorf, Arcadiastrasse 10, =
40472 Duesseldorf, Germany, Handelsregister/Commercial Register: Duesseldor=
f, HRB 3708 USt-IDNr./Tax identification no.: DE 119353406 WEEE-Reg.-Nr./WE=
EE reg. no.: DE 14978647
