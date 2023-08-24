Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40DF786C68
	for <lists+linux-pci@lfdr.de>; Thu, 24 Aug 2023 11:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234882AbjHXJ6r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Aug 2023 05:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240592AbjHXJ6f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Aug 2023 05:58:35 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2103.outbound.protection.outlook.com [40.107.113.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F26E1984;
        Thu, 24 Aug 2023 02:58:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g6hPt8YkLYWZY2fzNQCjX6Dhqjgb87mi7OnEnXcKnbL0SZTipY/0jZK4ouuQ6ICK+/oAxJtlfzaU5tLMXURTA+hDVfZTre76lcCtPxytywVXDm1TJ35+9tJZEngQOYr2YmDQKdaKMlwbP5nmXn4qf67Kjuh1ajycbracuOh0PF4QDHMD4L1X/xjv2WLX5lDOsBfFTW7lzM21rs1i1Ehj8dc1DT3Vn+HwzWRa8NB23pOlwYd7cJZ2tKOsn+uvMqf8YcS12dIQgHcSskisIWVCyEiwWQgZijhb3kxPM79g0EehJA1OIQBKCOFJ4F7+aQUWWXKdrVvyzNwdCivzEYFEIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dXX3uFvNVJAx1LndFndgvWXTqZwblxYIlhhcp9iSlo4=;
 b=YAC3yT6g9lK6y7Ohupgd/WymASYVrrOs4lFR1Sq2N9IC3f+x+y4Mx7r9ud7CoVdtyRcYsCu4YGwZNVQCWN+ocavPbkxHPAPGUk928/Voj/kNZQZV9k7desVfs/QPcnETGONrJBZIU89gQJohsUi0ALUneHjcQR822FjMBaAHjeq/Nu+qAYm3+AOMWXieaU3hTCU5EWb5tGrymCJlXKJCR4jxfS4/MB10QCrp2ZC2/NgWMfYHXHll+VotQI6PU1ksKoJvp2oNuYhUmarA/Nm++0gCOA+RFz0tfBC5Tz3S88ExlS0vqA5UR70HAEn3Un7hzuuqjck9k5m/yf6f26HwJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXX3uFvNVJAx1LndFndgvWXTqZwblxYIlhhcp9iSlo4=;
 b=gtCJ+NX1w0iZhZJHhfA5BCCHZhRE41rjHQ72p488Q/Ivk1c5CDWcpPHODpEYT9HLT+mK9ANkSBI8YKxB24BbAMWud76I4wdSv7SlSLtlXx32UjOcYNavw/y2AN/PUX3tHrPB73sqpBKuC8fXfYpHDjYSTSXB7Nzow/HgT+DTcYw=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYCPR01MB10494.jpnprd01.prod.outlook.com
 (2603:1096:400:306::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 09:58:29 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::e5cd:66a0:248f:1d30]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::e5cd:66a0:248f:1d30%4]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 09:58:29 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Serge Semin <fancer.lancer@gmail.com>
CC:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v19 16/19] PCI: rcar-gen4: Add R-Car Gen4 PCIe Host
 support
Thread-Topic: [PATCH v19 16/19] PCI: rcar-gen4: Add R-Car Gen4 PCIe Host
 support
Thread-Index: AQHZ1aHjcT93abOypUypBa5R+xiMeK/3xj8AgAFw6dA=
Date:   Thu, 24 Aug 2023 09:58:29 +0000
Message-ID: <TYBPR01MB53419F0B16CE91023C9DB95ED81DA@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230823091153.2578417-1-yoshihiro.shimoda.uh@renesas.com>
 <20230823091153.2578417-17-yoshihiro.shimoda.uh@renesas.com>
 <isnfx6wjlgi4u7qos4owuswbtdzcp4tzm6wcqp2qu7dui53vuj@nbf7wgnenkyy>
In-Reply-To: <isnfx6wjlgi4u7qos4owuswbtdzcp4tzm6wcqp2qu7dui53vuj@nbf7wgnenkyy>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYCPR01MB10494:EE_
x-ms-office365-filtering-correlation-id: d30e41b0-17ab-47f6-01b5-08dba488aae3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DE+OUX7elHxFCisIhTqDL4H0nIfgUahcc1AP+ahEiBrwS13jV6aTFmkLuJ/YjupABqx+IS7QUp11zIyxf9FCKRmTwemvwOyz6C+VAP2oI1C8XJhwOAKeuO9NHo1jCXCx0Lpuwab0UTGuGbOD+3xKVuusWhJMLHDATjfxa47wwMjUlZNj9MsZb3wFTbYU2ZJxqIHarJ9EoMT3TkU2jb8bpY1UQ07veA2KdCooW8wiUoMWfP4ueQfcodgvrXImfXJIZFyVPwK66G1hKyZNB1v8v/j1E6nS9na603/aI1xtNxaEzHNPrgQlmAgNxcrAENxZMmq0viBoOjDa1xb/VfRDHzPNK/mPgz4VDycIEzRuGzE8gUCAoY2n3TtvvKDRBRChWLo+9ZDBzHVppAL3bj1vZ3nOGNMSNRGyJy4hJcUmtUz4MZI3uveW2s1qVGONl90FBLcr8xIxSbfLT7SVMLf2U88H1FUKwJliyxNZPKL68kuTmHPcBzB0znqH+2h+PDheLRdmzqFA26/rB+LCVJU/EYXUhxTcZsZ42MMEm+vXG6FKZE83Q6iPIJkKdXVZegOfSyi9UYPZdZFXuxnlXYkfKwvl4qPeCThPdDjk2iPLgZ26RvV6ISmE88MyzA0rQivE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(39860400002)(376002)(346002)(451199024)(186009)(1800799009)(54906003)(64756008)(66446008)(66946007)(76116006)(66476007)(66556008)(6916009)(316002)(122000001)(478600001)(55016003)(26005)(38070700005)(38100700002)(71200400001)(41300700001)(86362001)(2906002)(6506007)(9686003)(7696005)(4326008)(8676002)(8936002)(52536014)(5660300002)(7416002)(83380400001)(33656002)(30864003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yBntc1ALwtRbfM8FTIK/YGr3yEE4pQtDuqEOE/iQ93jK/OQhY+HZ6c5zU6Na?=
 =?us-ascii?Q?isJrzKzalAhpkcx3zbWEUH61ZC+ammRgJb3nca9RFm8tXLyIzV4dKgfgF2xj?=
 =?us-ascii?Q?+UgIe//fqWM1fvNdFz3woGKfTmqA8EUOChW5VtR+Fmq8kqFHddGjI7fvvlFO?=
 =?us-ascii?Q?9o4zwN8B2DGh9tAJ8oXRZI+fUS/alaWLqLAJtMBeX0pKsiTALO/0a+4Uao4C?=
 =?us-ascii?Q?E9ourPnLSmIZs8lZbsVnkCgc85m/Erp5q4t7r9Brn/1QK20rHJAc5g3frVUL?=
 =?us-ascii?Q?GzTUJW3lGwEb3SZuzDdR3gC9vwTExhWM11fupzMQxj7lr1qZ++u5K/ci2TTO?=
 =?us-ascii?Q?66TjB7iS5rObfaYs/gQYjNHsLN68Q8idSuxSwbqxycb/01sZwORBj3p+PIgF?=
 =?us-ascii?Q?4yeHxIXcSUxswEEjcLat/Stxe4FHZDlYd4z9Z+OdYmH3guw06XnK2KjnxEDa?=
 =?us-ascii?Q?MtFhweQsDu+vDxq1XWDWauZvHqXvi4lubKAHj2mnPfYAQKDR4m524WpXGPWx?=
 =?us-ascii?Q?xv9L2tyeHd+3U7S5o7qcXjFSlyqTlMRUO0KmLD4Fx4lzhdBVlh3nZj1xKpmu?=
 =?us-ascii?Q?Ex8yQQYqe86W6IiQ+q6qLb6ntfliPgIEVPYDVbLhPDWvneDjRL9mqdG3YfiB?=
 =?us-ascii?Q?+eZVOcwH49vL8ZQhxnbL3Pz/Cz530UlsrF4BKnk58sH2snUTkVnn5ITFaLpT?=
 =?us-ascii?Q?344TKkJIXSQUFcr4nFuaaFvQqKDpkuQURhCCxLOhH0WbpmwjTn9gKvo4d2KF?=
 =?us-ascii?Q?NiekPSEOkQo+mYIPf5xhp+pR2u/vREaRssDn68zOAUiFa6tTLgEfxMHDv2z/?=
 =?us-ascii?Q?MTym7PlNUsLboBVRboaKwgByO+GzaV12WvAmqyQoUByL8zOi+W4xcb0bCViA?=
 =?us-ascii?Q?lEiyoKKoM1e3Gzxcx5qfSjXU6f0oB+WnKp/5JTU7F4MAQUHg0TAvmV780oBU?=
 =?us-ascii?Q?xJmE7CqU0AGvArCmoYhx13d0gA4b+0dUnaOivjFUbrJpdlKpyNtZyOEPMaSD?=
 =?us-ascii?Q?U3sfhktJ1Cn83hKxpYsB88D6siHe/KzLsOXLOIwBuM6I1cB/iUzI00F2+cfs?=
 =?us-ascii?Q?G6B9bJNQ4luSfQ7LiDnAjj3dt+6DLinzahk4iveS9E+TfO7T2TyDJizk5oPb?=
 =?us-ascii?Q?WuVofra3tlUXFRMDooocoRVuBeiWzsq14m2VIt/XRXwhT1EYb/N56Td+Lcym?=
 =?us-ascii?Q?V/ulbAGS34ZelkoBOPnTF8R+knuKaVhCH1Q7BENQUlSU2boyQ5BO301dMxgr?=
 =?us-ascii?Q?/40hu5ihWa5zSQcMq+l0L/zpiBkHTyshupcnO09D3rPh75JEUkcM+MkQ1eH4?=
 =?us-ascii?Q?UHRm8GsUosETNFKpqXI6EHL+gDB2noUAyZcPJg5NB3Ac+r+DKVlBh/LEpeRv?=
 =?us-ascii?Q?ZrfdgsK1OAs6duacorw2BxcqBtNyidg0ltHc6FSlgf6ez8S9aBW1e+2yrI0x?=
 =?us-ascii?Q?GU6GSRmcey8ltWeS9Tbu4bfN8izQ9XLUzEY19jCHk9QeDLPCuiN9B55uSWpa?=
 =?us-ascii?Q?cpE2TOSisCxZeHuR61ANwi/GB1yBqSFL6xKUCwiz/5pDQcrgi70c4dDczae8?=
 =?us-ascii?Q?3m21WJ6Oh80Pdz4cBQ8RHUl5ArSFr//g5R1tl16yeZfGS32rHplGG4IbpkOk?=
 =?us-ascii?Q?AQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d30e41b0-17ab-47f6-01b5-08dba488aae3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2023 09:58:29.2317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NfjAF4lLrW26/kNj7P+bDcpaqV1b17GrJws2CBPmDB1UyaP4j1wB7+W0rK2xGrdBv0f0XiAWWXPmv1cH2hjRF8Vt7z4GkWvtsqiYrdfisSse1uQWUkeLR+NIqXNhC9Iy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10494
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Serge,

> From: Serge Semin, Sent: Wednesday, August 23, 2023 8:56 PM
>=20
> On Wed, Aug 23, 2023 at 06:11:50PM +0900, Yoshihiro Shimoda wrote:
> > Add R-Car Gen4 PCIe Host support. This controller is based on
> > Synopsys DesignWare PCIe, but this controller has vendor-specific
> > registers so that requires initialization code like mode setting
> > and retraining and so on.
> >
> > To reduce code delta, adds some helper functions which are used by
> > both the host driver and the endpoint driver (which is added
> > immediately afterwards) into a separate file.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> >  drivers/pci/controller/dwc/Kconfig            |  10 +
> >  drivers/pci/controller/dwc/Makefile           |   2 +
> >  .../controller/dwc/pcie-rcar-gen4-host-drv.c  | 145 ++++++++++++
> >  drivers/pci/controller/dwc/pcie-rcar-gen4.c   | 208 ++++++++++++++++++
> >  drivers/pci/controller/dwc/pcie-rcar-gen4.h   |  44 ++++
> >  5 files changed, 409 insertions(+)
> >  create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4-host-drv.=
c
> >  create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4.c
> >  create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4.h
> >
> > diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controlle=
r/dwc/Kconfig
> > index ab96da43e0c2..3884a67e4d56 100644
> > --- a/drivers/pci/controller/dwc/Kconfig
> > +++ b/drivers/pci/controller/dwc/Kconfig
> > @@ -415,4 +415,14 @@ config PCIE_VISCONTI_HOST
> >  	  Say Y here if you want PCIe controller support on Toshiba Visconti =
SoC.
> >  	  This driver supports TMPV7708 SoC.
> >
> > +config PCIE_RCAR_GEN4
> > +	tristate "Renesas R-Car Gen4 PCIe Host controller"
> > +	depends on ARCH_RENESAS || COMPILE_TEST
> > +	depends on PCI_MSI
> > +	select PCIE_DW_HOST
> > +	help
> > +	  Say Y here if you want PCIe host controller support on R-Car Gen4 S=
oCs.
> > +	  To compile this driver as a module, choose M here: the module will =
be
> > +	  called pcie-rcar-gen4-host.ko. This uses the DesignWare core.
> > +
> >  endmenu
> > diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controll=
er/dwc/Makefile
> > index bf5c311875a1..ab2c6bc16216 100644
> > --- a/drivers/pci/controller/dwc/Makefile
> > +++ b/drivers/pci/controller/dwc/Makefile
> > @@ -26,6 +26,8 @@ obj-$(CONFIG_PCIE_TEGRA194) +=3D pcie-tegra194.o
> >  obj-$(CONFIG_PCIE_UNIPHIER) +=3D pcie-uniphier.o
> >  obj-$(CONFIG_PCIE_UNIPHIER_EP) +=3D pcie-uniphier-ep.o
> >  obj-$(CONFIG_PCIE_VISCONTI_HOST) +=3D pcie-visconti.o
> > +pcie-rcar-gen4-host-objs :=3D pcie-rcar-gen4.o pcie-rcar-gen4-host-drv=
.o
> > +obj-$(CONFIG_PCIE_RCAR_GEN4) +=3D pcie-rcar-gen4-host.o
> >
> >  # The following drivers are for devices that use the generic ACPI
> >  # pci_root.c driver but don't support standard ECAM config access.
> > diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4-host-drv.c
> b/drivers/pci/controller/dwc/pcie-rcar-gen4-host-drv.c
> > new file mode 100644
> > index 000000000000..8acce1ee5efc
> > --- /dev/null
> > +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4-host-drv.c
> > @@ -0,0 +1,145 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * PCIe host controller driver for Renesas R-Car Gen4 Series SoCs
> > + * Copyright (C) 2022-2023 Renesas Electronics Corporation
> > + */
> > +
> > +#include <linux/delay.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/module.h>
> > +#include <linux/of_device.h>
> > +#include <linux/pci.h>
> > +#include <linux/platform_device.h>
> > +
> > +#include "pcie-rcar-gen4.h"
> > +#include "pcie-designware.h"
> > +
> > +static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
> > +{
> > +	struct dw_pcie *dw =3D to_dw_pcie_from_pp(pp);
> > +	struct rcar_gen4_pcie *rcar =3D to_rcar_gen4_pcie(dw);
> > +	int ret;
> > +	u32 val;
> > +
> > +	gpiod_set_value_cansleep(dw->pe_rst, 1);
> > +
>=20
> > +	ret =3D clk_bulk_prepare_enable(DW_PCIE_NUM_CORE_CLKS, dw->core_clks)=
;
> > +	if (ret) {
> > +		dev_err(dw->dev, "Failed to enable ref clocks\n");
> > +		return ret;
> > +	}
>=20
> This is called in both the Host and End-point init function right
> above the rcar_gen4_pcie_common_init() method invocation. It can be moved
> there then.

I got it.

> > +
> > +	ret =3D rcar_gen4_pcie_common_init(rcar);
> > +	if (ret) {
> > +		clk_bulk_disable_unprepare(DW_PCIE_NUM_CORE_CLKS, dw->core_clks);
> > +		return ret;
> > +	}
> > +
> > +	/*
> > +	 * According to the section 3.5.7.2 "RC Mode" in DWC PCIe Dual Mode
> > +	 * Rev.5.20a, we should disable two BARs to avoid unnecessary memory
> > +	 * assignment during device enumeration.
> > +	 */
> > +	dw_pcie_writel_dbi2(dw, PCI_BASE_ADDRESS_0, 0x0);
> > +	dw_pcie_writel_dbi2(dw, PCI_BASE_ADDRESS_1, 0x0);
> > +
> > +	/* Enable MSI interrupt signal */
> > +	val =3D readl(rcar->base + PCIEINTSTS0EN);
> > +	val |=3D MSI_CTRL_INT;
> > +	writel(val, rcar->base + PCIEINTSTS0EN);
> > +
> > +	msleep(100);	/* pe_rst requires 100msec delay */
> > +
> > +	gpiod_set_value_cansleep(dw->pe_rst, 0);
> > +
> > +	return 0;
> > +}
> > +
> > +static void rcar_gen4_pcie_host_deinit(struct dw_pcie_rp *pp)
> > +{
> > +	struct dw_pcie *dw =3D to_dw_pcie_from_pp(pp);
> > +	struct rcar_gen4_pcie *rcar =3D to_rcar_gen4_pcie(dw);
> > +
> > +	gpiod_set_value_cansleep(dw->pe_rst, 1);
> > +	rcar_gen4_pcie_common_deinit(rcar);
>=20
> > +	clk_bulk_disable_unprepare(DW_PCIE_NUM_CORE_CLKS, dw->core_clks);
>=20
> and this can be moved to rcar_gen4_pcie_common_deinit() too for
> the same reason as denoted in the previous comment.

I got it.

> > +}
> > +
> > +static const struct dw_pcie_host_ops rcar_gen4_pcie_host_ops =3D {
> > +	.host_init =3D rcar_gen4_pcie_host_init,
> > +	.host_deinit =3D rcar_gen4_pcie_host_deinit,
> > +};
> > +
> > +static int rcar_gen4_add_dw_pcie_rp(struct rcar_gen4_pcie *rcar)
> > +{
> > +	struct dw_pcie_rp *pp =3D &rcar->dw.pp;
> > +
> > +	pp->num_vectors =3D MAX_MSI_IRQS;
> > +	pp->ops =3D &rcar_gen4_pcie_host_ops;
> > +	rcar->mode =3D DW_PCIE_RC_TYPE;
> > +
> > +	return dw_pcie_host_init(pp);
> > +}
> > +
> > +static void rcar_gen4_remove_dw_pcie_rp(struct rcar_gen4_pcie *rcar)
> > +{
>=20
> > +	dw_pcie_host_deinit(&rcar->dw.pp);
> > +	gpiod_set_value_cansleep(rcar->dw.pe_rst, 1);
>=20
> gpiod_set_value_cansleep() seems redundant here because
> dw_pcie_host_deinit() calls host_deinit() which is
> rcar_gen4_pcie_host_deinit() and which already asserts the PE_RST
> GPIO.

I got it. I'll drop this on v20.

> BTW even though after dropping the gpiod_set_value_cansleep() function
> call from rcar_gen4_remove_dw_pcie_rp(), the later will be left with
> only a single function invocation I would have left it defined anyway
> for the internal driver interface consistency and maintainability:
> you'll have a protagonist and respective antagonist defined in a way
> it's done for host_init()/host_deinit(),
> common_init()/common_deinit(), prepare()/unprepare(), etc. In addition
> such design would simplify possible updates should you need to
> extend rcar_gen4_add_dw_pcie_rp() functionality and add new cleanups
> afterwards.

I think so.

> > +}
> > +
> > +static int rcar_gen4_pcie_probe(struct platform_device *pdev)
> > +{
> > +	struct rcar_gen4_pcie *rcar;
> > +	int err;
> > +
> > +	rcar =3D rcar_gen4_pcie_devm_alloc(pdev);
> > +	if (IS_ERR(rcar))
> > +		return PTR_ERR(rcar);
> > +
> > +	err =3D rcar_gen4_pcie_get_resources(rcar);
> > +	if (err)
> > +		return err;
> > +
> > +	err =3D rcar_gen4_pcie_prepare(rcar);
> > +	if (err)
> > +		return err;
> > +
> > +	err =3D rcar_gen4_add_dw_pcie_rp(rcar);
> > +	if (err)
> > +		goto err_unprepare;
> > +
> > +	return 0;
> > +
> > +err_unprepare:
> > +	rcar_gen4_pcie_unprepare(rcar);
> > +
> > +	return err;
> > +}
>=20
> Look how neat and beautiful the probe() method is now. So is the rest
> of the driver.) So to speak with the previous notes fixed feel free to
> add:

Thank you very much for your support!

> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

Thank you for your review!

Best regards,
Yoshihiro Shimoda

> -Serge(y)
>=20
> > +
> > +static void rcar_gen4_pcie_remove(struct platform_device *pdev)
> > +{
> > +	struct rcar_gen4_pcie *rcar =3D platform_get_drvdata(pdev);
> > +
> > +	rcar_gen4_remove_dw_pcie_rp(rcar);
> > +	rcar_gen4_pcie_unprepare(rcar);
> > +}
> > +
> > +static const struct of_device_id rcar_gen4_pcie_of_match[] =3D {
> > +	{ .compatible =3D "renesas,rcar-gen4-pcie", },
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(of, rcar_gen4_pcie_of_match);
> > +
> > +static struct platform_driver rcar_gen4_pcie_driver =3D {
> > +	.driver =3D {
> > +		.name =3D "pcie-rcar-gen4",
> > +		.of_match_table =3D rcar_gen4_pcie_of_match,
> > +		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> > +	},
> > +	.probe =3D rcar_gen4_pcie_probe,
> > +	.remove_new =3D rcar_gen4_pcie_remove,
> > +};
> > +module_platform_driver(rcar_gen4_pcie_driver);
> > +
> > +MODULE_DESCRIPTION("Renesas R-Car Gen4 PCIe host controller driver");
> > +MODULE_LICENSE("GPL");
> > diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/=
controller/dwc/pcie-rcar-gen4.c
> > new file mode 100644
> > index 000000000000..2a8bbf928d5f
> > --- /dev/null
> > +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> > @@ -0,0 +1,208 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * PCIe host/endpoint controller driver for Renesas R-Car Gen4 Series =
SoCs
> > + * Copyright (C) 2022-2023 Renesas Electronics Corporation
> > + */
> > +
> > +#include <linux/delay.h>
> > +#include <linux/io.h>
> > +#include <linux/of_device.h>
> > +#include <linux/pci.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/reset.h>
> > +
> > +#include "pcie-rcar-gen4.h"
> > +#include "pcie-designware.h"
> > +
> > +/* Renesas-specific */
> > +#define PCIERSTCTRL1		0x0014
> > +#define APP_HOLD_PHY_RST	BIT(16)
> > +#define APP_LTSSM_ENABLE	BIT(0)
> > +
> > +#define RCAR_NUM_SPEED_CHANGE_RETRIES	10
> > +#define RCAR_MAX_LINK_SPEED		4
> > +
> > +static void rcar_gen4_pcie_ltssm_enable(struct rcar_gen4_pcie *rcar,
> > +					bool enable)
> > +{
> > +	u32 val;
> > +
> > +	val =3D readl(rcar->base + PCIERSTCTRL1);
> > +	if (enable) {
> > +		val |=3D APP_LTSSM_ENABLE;
> > +		val &=3D ~APP_HOLD_PHY_RST;
> > +	} else {
> > +		/*
> > +		 * Since the datasheet of R-Car doesn't mention how to assert
> > +		 * the APP_HOLD_PHY_RST, don't assert it again. Otherwise,
> > +		 * hang-up issue happened in the dw_edma_core_off() when
> > +		 * the controller didn't detect a PCI device.
> > +		 */
> > +		val &=3D ~APP_LTSSM_ENABLE;
> > +	}
> > +	writel(val, rcar->base + PCIERSTCTRL1);
> > +}
> > +
> > +static int rcar_gen4_pcie_link_up(struct dw_pcie *dw)
> > +{
> > +	struct rcar_gen4_pcie *rcar =3D to_rcar_gen4_pcie(dw);
> > +	u32 val, mask;
> > +
> > +	val =3D readl(rcar->base + PCIEINTSTS0);
> > +	mask =3D RDLH_LINK_UP | SMLH_LINK_UP;
> > +
> > +	return (val & mask) =3D=3D mask;
> > +}
> > +
> > +/*
> > + * Manually initiate the speed change. Return true if the change succe=
eded,
> > + * false if the change didn't finish within certain periods.
> > + */
> > +static bool rcar_gen4_pcie_speed_change(struct dw_pcie *dw)
> > +{
> > +	u32 val;
> > +	int i;
> > +
> > +	val =3D dw_pcie_readl_dbi(dw, PCIE_LINK_WIDTH_SPEED_CONTROL);
> > +	val &=3D ~PORT_LOGIC_SPEED_CHANGE;
> > +	dw_pcie_writel_dbi(dw, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
> > +
> > +	val =3D dw_pcie_readl_dbi(dw, PCIE_LINK_WIDTH_SPEED_CONTROL);
> > +	val |=3D PORT_LOGIC_SPEED_CHANGE;
> > +	dw_pcie_writel_dbi(dw, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
> > +
> > +	for (i =3D 0; i < RCAR_NUM_SPEED_CHANGE_RETRIES; i++) {
> > +		val =3D dw_pcie_readl_dbi(dw, PCIE_LINK_WIDTH_SPEED_CONTROL);
> > +		if (!(val & PORT_LOGIC_SPEED_CHANGE))
> > +			return true;
> > +		usleep_range(10000, 11000);
> > +	}
> > +
> > +	return false;
> > +}
> > +
> > +/*
> > + * Enable LTSSM of this controller and manually initiate the speed cha=
nge.
> > + * Always return true.
> > + */
> > +static int rcar_gen4_pcie_start_link(struct dw_pcie *dw)
> > +{
> > +	struct rcar_gen4_pcie *rcar =3D to_rcar_gen4_pcie(dw);
> > +	int i, changes;
> > +
> > +	rcar_gen4_pcie_ltssm_enable(rcar, true);
> > +
> > +	/*
> > +	 * Require direct speed change with retrying here if the link_gen is
> > +	 * PCIe Gen2 or higher.
> > +	 */
> > +	changes =3D min_not_zero(dw->link_gen, RCAR_MAX_LINK_SPEED) - 1;
> > +
> > +	/*
> > +	 * Since dw_pcie_setup_rc() sets it once, PCIe Gen2 will be trained.
> > +	 * So, this needs remaining times for up to PCIe Gen4 if RC mode.
> > +	 */
> > +	if (changes && rcar->mode =3D=3D DW_PCIE_RC_TYPE)
> > +		changes--;
> > +
> > +	for (i =3D 0; i < changes; i++) {
> > +		if (!rcar_gen4_pcie_speed_change(dw))
> > +			break;	/* No error because possible disconnected here if EP mode */
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static void rcar_gen4_pcie_stop_link(struct dw_pcie *dw)
> > +{
> > +	struct rcar_gen4_pcie *rcar =3D to_rcar_gen4_pcie(dw);
> > +
> > +	rcar_gen4_pcie_ltssm_enable(rcar, false);
> > +}
> > +
> > +int rcar_gen4_pcie_common_init(struct rcar_gen4_pcie *rcar)
> > +{
> > +	struct dw_pcie *dw =3D &rcar->dw;
> > +	u32 val;
> > +
> > +	if (!reset_control_status(dw->core_rsts[DW_PCIE_PWR_RST].rstc))
> > +		reset_control_assert(dw->core_rsts[DW_PCIE_PWR_RST].rstc);
> > +
> > +	val =3D readl(rcar->base + PCIEMSR0);
> > +	if (rcar->mode =3D=3D DW_PCIE_RC_TYPE)
> > +		val |=3D DEVICE_TYPE_RC;
> > +	else if (rcar->mode =3D=3D DW_PCIE_EP_TYPE)
> > +		val |=3D DEVICE_TYPE_EP;
> > +	else
> > +		return -EINVAL;
> > +
> > +	if (dw->num_lanes < 4)
> > +		val |=3D BIFUR_MOD_SET_ON;
> > +
> > +	writel(val, rcar->base + PCIEMSR0);
> > +
> > +	return reset_control_deassert(dw->core_rsts[DW_PCIE_PWR_RST].rstc);
> > +}
> > +
> > +void rcar_gen4_pcie_common_deinit(struct rcar_gen4_pcie *rcar)
> > +{
> > +	struct dw_pcie *dw =3D &rcar->dw;
> > +
> > +	reset_control_assert(dw->core_rsts[DW_PCIE_PWR_RST].rstc);
> > +}
> > +
> > +int rcar_gen4_pcie_prepare(struct rcar_gen4_pcie *rcar)
> > +{
> > +	struct device *dev =3D rcar->dw.dev;
> > +	int err;
> > +
> > +	pm_runtime_enable(dev);
> > +	err =3D pm_runtime_resume_and_get(dev);
> > +	if (err < 0) {
> > +		dev_err(dev, "Failed to resume/get Runtime PM\n");
> > +		pm_runtime_disable(dev);
> > +	}
> > +
> > +	return err;
> > +}
> > +
> > +void rcar_gen4_pcie_unprepare(struct rcar_gen4_pcie *rcar)
> > +{
> > +	struct device *dev =3D rcar->dw.dev;
> > +
> > +	pm_runtime_put(dev);
> > +	pm_runtime_disable(dev);
> > +}
> > +
> > +int rcar_gen4_pcie_get_resources(struct rcar_gen4_pcie *rcar)
> > +{
> > +	/* Renesas-specific registers */
> > +	rcar->base =3D devm_platform_ioremap_resource_byname(rcar->pdev, "app=
");
> > +
> > +	return PTR_ERR_OR_ZERO(rcar->base);
> > +}
> > +
> > +static const struct dw_pcie_ops dw_pcie_ops =3D {
> > +	.start_link =3D rcar_gen4_pcie_start_link,
> > +	.stop_link =3D rcar_gen4_pcie_stop_link,
> > +	.link_up =3D rcar_gen4_pcie_link_up,
> > +};
> > +
> > +struct rcar_gen4_pcie *rcar_gen4_pcie_devm_alloc(struct platform_devic=
e *pdev)
> > +{
> > +	struct device *dev =3D &pdev->dev;
> > +	struct rcar_gen4_pcie *rcar;
> > +
> > +	rcar =3D devm_kzalloc(dev, sizeof(*rcar), GFP_KERNEL);
> > +	if (!rcar)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	rcar->dw.ops =3D &dw_pcie_ops;
> > +	rcar->dw.dev =3D dev;
> > +	rcar->pdev =3D pdev;
> > +	dw_pcie_cap_set(&rcar->dw, EDMA_UNROLL);
> > +	dw_pcie_cap_set(&rcar->dw, REQ_RES);
> > +	platform_set_drvdata(pdev, rcar);
> > +
> > +	return rcar;
> > +}
> > diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.h b/drivers/pci/=
controller/dwc/pcie-rcar-gen4.h
> > new file mode 100644
> > index 000000000000..7cbb3767c2d4
> > --- /dev/null
> > +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.h
> > @@ -0,0 +1,44 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * PCIe host/endpoint controller driver for Renesas R-Car Gen4 Series =
SoCs
> > + * Copyright (C) 2022-2023 Renesas Electronics Corporation
> > + */
> > +
> > +#ifndef _PCIE_RCAR_GEN4_H_
> > +#define _PCIE_RCAR_GEN4_H_
> > +
> > +#include <linux/io.h>
> > +#include <linux/pci.h>
> > +
> > +#include "pcie-designware.h"
> > +
> > +/* Renesas-specific */
> > +#define PCIEMSR0		0x0000
> > +#define BIFUR_MOD_SET_ON	BIT(0)
> > +#define DEVICE_TYPE_EP		0
> > +#define DEVICE_TYPE_RC		BIT(4)
> > +
> > +#define PCIEINTSTS0		0x0084
> > +#define PCIEINTSTS0EN		0x0310
> > +#define MSI_CTRL_INT		BIT(26)
> > +#define SMLH_LINK_UP		BIT(7)
> > +#define RDLH_LINK_UP		BIT(6)
> > +#define PCIEDMAINTSTSEN		0x0314
> > +#define PCIEDMAINTSTSEN_INIT	GENMASK(15, 0)
> > +
> > +struct rcar_gen4_pcie {
> > +	struct dw_pcie dw;
> > +	void __iomem *base;
> > +	struct platform_device *pdev;
> > +	enum dw_pcie_device_mode mode;
> > +};
> > +#define to_rcar_gen4_pcie(_dw)	container_of(_dw, struct rcar_gen4_pcie=
, dw)
> > +
> > +int rcar_gen4_pcie_common_init(struct rcar_gen4_pcie *rcar);
> > +void rcar_gen4_pcie_common_deinit(struct rcar_gen4_pcie *rcar);
> > +int rcar_gen4_pcie_prepare(struct rcar_gen4_pcie *rcar);
> > +void rcar_gen4_pcie_unprepare(struct rcar_gen4_pcie *rcar);
> > +int rcar_gen4_pcie_get_resources(struct rcar_gen4_pcie *rcar);
> > +struct rcar_gen4_pcie *rcar_gen4_pcie_devm_alloc(struct platform_devic=
e *pdev);
> > +
> > +#endif /* _PCIE_RCAR_GEN4_H_ */
> > --
> > 2.25.1
> >
