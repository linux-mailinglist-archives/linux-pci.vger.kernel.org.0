Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98989786C79
	for <lists+linux-pci@lfdr.de>; Thu, 24 Aug 2023 12:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236667AbjHXJ7w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Aug 2023 05:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240829AbjHXJ7g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Aug 2023 05:59:36 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2095.outbound.protection.outlook.com [40.107.113.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9171C1984;
        Thu, 24 Aug 2023 02:59:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ThX7BILnHwM0qn5FO+7MQWyLzqqRcLZ2lbbyUuniyLyGQZRHkjP7KcvQmAUIfIR643JzfCV5/99F3wCAlzUpxpgnSWBuAYtnddwKPgA8GPz6Hn0Z6Wcb0NUBYOc2s2tQYGpJAJmCDTKYjQeljoZNo6kszXZ7MypcEldn7SzHtygb8N3TObs2izyTCec37v1oTbbOynUFIlqdL5ICLQ5GKc6Xy6QhllJLp+hOE8y6DIYKKI8t4DPWfTvJAxq8Ivv5DA/ahugoB7PQXu0TnLEF1JWMWPciT8pcfuVUxXYNJvF/tTqY4ha4wK/mkY+wh/ppO6cJQ1MixoVAcFeQ6k+2PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1qiOOhodBYI+8EW2ITwbh65t0HOBCrl/i3Zp7CaJFI0=;
 b=iLNgAejtrdj0E0ctksA6wd7dP4qn5+dL3sF9/nPK5c/I1ANzIi+9y96QHpgiH8m1tc46yU2aejdqRLqFjf/8pi0pWokzrhohGxlBLI7dueUimN44VEQ3YHXyRRUNMOCrnN/Ghw5x+xfcQn57fLcUcM2YdaAcoXDVaVnH38nlIG6+tEJM5RQ5a13KKLD71p0eYsH4Svfw+CVdlPmCeV8ZRRxom5t2HL1RlJaCsN5RpBT7BJZ0Ul5z8cZLZBY3vz+a9uAeKdJUl6YEYptOGS7ftc1+v6e6jVnlJuKb+w9bLWCmSNX0A9U2FRPYTvuIVnpPBufj4Ae6CbOVwLBBR6iXHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1qiOOhodBYI+8EW2ITwbh65t0HOBCrl/i3Zp7CaJFI0=;
 b=ppxXi7cQfVF54r3W8PSp5TS8kI6Wu+4nc/KY9+eBNvn9CDdc52/H027HQ7HsDpFocjXxuRXSKo2kKCuFKwLMQwIxbUrMMVGDcdVGiF+yOBDi7tJkRx7yOVP7jG1B/4CTkGmwqUgDClIJk7VfcBzvGOKgaHJ1Wu/k6LzKWklh53I=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYCPR01MB10494.jpnprd01.prod.outlook.com
 (2603:1096:400:306::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 09:59:30 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::e5cd:66a0:248f:1d30]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::e5cd:66a0:248f:1d30%4]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 09:59:30 +0000
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
Subject: RE: [PATCH v19 17/19] PCI: rcar-gen4-ep: Add R-Car Gen4 PCIe Endpoint
 support
Thread-Topic: [PATCH v19 17/19] PCI: rcar-gen4-ep: Add R-Car Gen4 PCIe
 Endpoint support
Thread-Index: AQHZ1aHja3fL6wd8w0qlLZS7XbKlsa/3yB4AgAFvv/A=
Date:   Thu, 24 Aug 2023 09:59:30 +0000
Message-ID: <TYBPR01MB5341C69DA05F0341A0D4B78DD81DA@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230823091153.2578417-1-yoshihiro.shimoda.uh@renesas.com>
 <20230823091153.2578417-18-yoshihiro.shimoda.uh@renesas.com>
 <agtnd477is7pphizfdoyltbak5pdjpvcx34lwvtnch5zbi7rfd@75ndc53djrgv>
In-Reply-To: <agtnd477is7pphizfdoyltbak5pdjpvcx34lwvtnch5zbi7rfd@75ndc53djrgv>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYCPR01MB10494:EE_
x-ms-office365-filtering-correlation-id: e05a9ee0-85a8-4e1e-aee7-08dba488cf78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U72vzXiFbYuJO4Y0motda7xqYMl5Xkmv1chbH8Tv2c23fy4MrO+taN9W3ohKbuz4TgvffH61WTnlTjqdKvsAyC05ZoGZWBQfs/vPP4e5dvys8NlvLl2cLm0vWYd/PJUayx2lHvUMrpRxSUyBiouTPp7tGcOFXwdgX4P5EKuI1qls3FuUyoAv9wMpiTyHjwYR/XJlCllccWj0NPcZo1MFnK9WvJE0lURu5MJy1mG3jKoFcZNRS4gmqL+/qlVXndzmZat7PngulSKEZLZk5ALL6X7zkRP0IfTF2/49WTTwpg1yhZ5d1d4iFz+xE4hEvKaK1F7/KZ1H2DDy97VkiY2CkPPqVAS1G1/DhvzkWhIgkqd23nS6EbuFN+T57naTfom3IlwwcuBLky/oX15iTg9UAbChCTstu/a44sivIjkeauNi9jtxpbh03LvuH/I/yY+opjAhu47P67UClnXbSPQESCfAhCEDXCOsStPCTuVlN5e08wP+Ce+AUxuSPuy0jMXUlDkswJ5LN4F5jEsDBVZnuJN927Vi1rUR5j4JXoO/9isO/yhVQJmRdHKfUJeDZwLgwD2iHTAI3a90aNfKoU0d0kAZHTO6wIjb0ZtDpPKkqOTLpIQAKPvvucAeX27/Dk45
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(39860400002)(376002)(346002)(451199024)(186009)(1800799009)(54906003)(64756008)(66446008)(66946007)(76116006)(66476007)(66556008)(6916009)(316002)(122000001)(478600001)(55016003)(26005)(38070700005)(38100700002)(71200400001)(41300700001)(86362001)(2906002)(6506007)(9686003)(7696005)(4326008)(8676002)(8936002)(52536014)(5660300002)(7416002)(83380400001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oEeGh9UrageDC+JZ5YmsUKQnun5IJgadyBG2lp4KGTW+es7zyBNqfS5FmxvJ?=
 =?us-ascii?Q?COx9mLgWdZO9ZYT6Ad5GvUeXcL6DAAIoyp8Tdjmj2aEvRYShIlU4F2htU8c2?=
 =?us-ascii?Q?BWcr5PvRkyv/YMemV4TmlqMW/QxAbI240oTj4Hxfoycse+94GoWarxncDbCT?=
 =?us-ascii?Q?CiE7B0tuwPNSTkm1PIcszKpG7aLzY1F0gSnT2SQtjnBaOHGOb2jDOvFCcEva?=
 =?us-ascii?Q?xYiYNYcZ77o83jg6VKFoU/nDS7NM7o8jpLd6ww/CBciVVehk3Bundn8dLQ/i?=
 =?us-ascii?Q?fE53gQQqjfpOCPzCpsohhMWoYxD6w+r+HNyUuWfjVMKFeOGYSGeW5hjeQA8T?=
 =?us-ascii?Q?V3dvP/qvaoE9wnQ+qmEe2GtS/HdHmCwup5xZ9Qt7eQZkUZEGkpUW0e+I667M?=
 =?us-ascii?Q?K0uDMhrQgzgQ8iUDEp1baUOyLZVSYeIlUUdHP+nHRof27ynoKsiLMFWanQEj?=
 =?us-ascii?Q?GOZbHEqLZNsrxVwpUNMmD1n4hNCydqZD5OaODsSfvZlnzh4pYasaS3nD1Lid?=
 =?us-ascii?Q?MMoUtIeAjAd31G9EMoNgHKOujXbevvJswdHb0ZoV12uWJvLnNevY34t70PtB?=
 =?us-ascii?Q?4Aagm4j3ztyClDPFUc8JAkjPJiCGrD4CqrKVMRwsBVoasFfgAomid3nTFikf?=
 =?us-ascii?Q?yg1IEBYUa6jmiVzzN4I1N9Ubx5xISaJtYu/8AdSHiztHKRgoQiYIQ29yyCH7?=
 =?us-ascii?Q?9nc5RM+bslGrYnQZkUMimjFBNEQm6Q8D1fVm3QY4Gm2e+3scVTLqR9L3bCPC?=
 =?us-ascii?Q?/6GZLmlgJD+i0VOgZQk7wKK+fc8UrmdNGWqEQUEOCyQzUBM78dBOjODFJjKA?=
 =?us-ascii?Q?bERo0SczP0qKVi1a7RATThq9tJgMjX0OR4eGKKqQEuKCoyI12t6huG12VeTq?=
 =?us-ascii?Q?oTV+oMUCLO9tSPzw/zbg3UbUHsYl+ddOe+7PDk1a88V/DBWrprXEUxJhSyFr?=
 =?us-ascii?Q?81UdpWA97+/9NAa4WSmy3pte7lIqtpUx7kviHUEo4fXw8nXKp/A8gyAI/5Rf?=
 =?us-ascii?Q?jH5UMs7SmyEtR0shBokGRt6RwctYbWxKDYenIf5+umjQshn0M+VyB1zdNbGE?=
 =?us-ascii?Q?/Kar4+ePYH6sCWsSYZmkZyleDkGgzNePzvKKNABYPX1WF8eLE5BEqmtf5XjG?=
 =?us-ascii?Q?Wd2fYpDyCJ1oei4hzM34bUFKlDpQ2EbG2roeXgKkjonrxp7Qq8eCFLkyNcIX?=
 =?us-ascii?Q?cYrEif1lqNAejz+cKFi+S2enwE8kAhy67OBfuouRfKvmzbKoKuoMA85qLC1G?=
 =?us-ascii?Q?07WPHljqQILJx7SQQ85qaHm5NgZ03eSAzz4RK+x4R7VwVG6+ltBhutR6iucS?=
 =?us-ascii?Q?lHXF/GhfrFnkD6Ju4CPU60LbCQ8aqQV0t4uh0llATX5ubF1SPGOQj1vHCjHS?=
 =?us-ascii?Q?O3/8kglUiuxCfl1JVvjJY00RrwTZEZsr/LMHBQtDfQ4+JWdUCZg4znYD3tSp?=
 =?us-ascii?Q?hy108VDACu1YRRRI8caevO6t1ozkpvr/X+b1p5V8I4zx3uMMv3XQFeSrbu2o?=
 =?us-ascii?Q?5X8m26No5+yHwwOAVajJDoV5iUtMo0+AFojKI+upnYAevivdpXLmzOA7umDi?=
 =?us-ascii?Q?GbWD96ssscwpU5370r2S0zHYgaUMzlR5T/kdOFsY6cL13Ocdx+8R5vmAP7d/?=
 =?us-ascii?Q?BA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e05a9ee0-85a8-4e1e-aee7-08dba488cf78
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2023 09:59:30.6233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kVM0KGnzMxH0qwnop0DQtxBzFYNv7mTW/Vi0ohJMVbl2PD+p6B9fPitnZSYXoemjHynYiwsqX760SzyCgmo2TCZyTCudxU2hUjPBKcS8xQGcecnDN7X7pwHD2zDwDf1E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10494
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Serge,

> From: Serge Semin, Sent: Wednesday, August 23, 2023 9:03 PM
>=20
> On Wed, Aug 23, 2023 at 06:11:51PM +0900, Yoshihiro Shimoda wrote:
> > Add R-Car Gen4 PCIe Endpoint support. This controller is based on
> > Synopsys DesignWare PCIe.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> >  drivers/pci/controller/dwc/Kconfig            |  10 +
> >  drivers/pci/controller/dwc/Makefile           |   2 +
> >  .../controller/dwc/pcie-rcar-gen4-ep-drv.c    | 178 ++++++++++++++++++
> >  3 files changed, 190 insertions(+)
> >  create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4-ep-drv.c
> >
> > diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controlle=
r/dwc/Kconfig
> > index 3884a67e4d56..65a7c56e64bd 100644
> > --- a/drivers/pci/controller/dwc/Kconfig
> > +++ b/drivers/pci/controller/dwc/Kconfig
> > @@ -425,4 +425,14 @@ config PCIE_RCAR_GEN4
> >  	  To compile this driver as a module, choose M here: the module will =
be
> >  	  called pcie-rcar-gen4-host.ko. This uses the DesignWare core.
> >
> > +config PCIE_RCAR_GEN4_EP
> > +	tristate "Renesas R-Car Gen4 PCIe Endpoint controller"
> > +	depends on ARCH_RENESAS || COMPILE_TEST
> > +	depends on PCI_ENDPOINT
> > +	select PCIE_DW_EP
> > +	help
> > +	  Say Y here if you want PCIe endpoint controller support on R-Car Ge=
n4
> > +	  SoCs. To compile this driver as a module, choose M here: the module
> > +	  will be called pcie-rcar-gen4-ep.ko. This uses the DesignWare core.
> > +
> >  endmenu
> > diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controll=
er/dwc/Makefile
> > index ab2c6bc16216..4d53d660e4fe 100644
> > --- a/drivers/pci/controller/dwc/Makefile
> > +++ b/drivers/pci/controller/dwc/Makefile
> > @@ -28,6 +28,8 @@ obj-$(CONFIG_PCIE_UNIPHIER_EP) +=3D pcie-uniphier-ep.=
o
> >  obj-$(CONFIG_PCIE_VISCONTI_HOST) +=3D pcie-visconti.o
> >  pcie-rcar-gen4-host-objs :=3D pcie-rcar-gen4.o pcie-rcar-gen4-host-drv=
.o
> >  obj-$(CONFIG_PCIE_RCAR_GEN4) +=3D pcie-rcar-gen4-host.o
> > +pcie-rcar-gen4-ep-objs :=3D pcie-rcar-gen4.o pcie-rcar-gen4-ep-drv.o
> > +obj-$(CONFIG_PCIE_RCAR_GEN4_EP) +=3D pcie-rcar-gen4-ep.o
> >
> >  # The following drivers are for devices that use the generic ACPI
> >  # pci_root.c driver but don't support standard ECAM config access.
> > diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4-ep-drv.c b/drive=
rs/pci/controller/dwc/pcie-rcar-gen4-ep-drv.c
> > new file mode 100644
> > index 000000000000..71f496ba0eeb
> > --- /dev/null
> > +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4-ep-drv.c
> > @@ -0,0 +1,178 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * PCIe Endpoint driver for Renesas R-Car Gen4 Series SoCs
> > + * Copyright (C) 2022-2023 Renesas Electronics Corporation
> > + */
> > +
> > +#include <linux/interrupt.h>
> > +#include <linux/module.h>
> > +#include <linux/of_device.h>
> > +#include <linux/pci.h>
> > +#include <linux/platform_device.h>
> > +
> > +#include "pcie-rcar-gen4.h"
> > +#include "pcie-designware.h"
> > +
> > +#define RCAR_GEN4_PCIE_EP_FUNC_DBI_OFFSET	0x1000
> > +#define RCAR_GEN4_PCIE_EP_FUNC_DBI2_OFFSET	0x800
> > +
> > +static void rcar_gen4_pcie_ep_pre_init(struct dw_pcie_ep *ep)
> > +{
> > +	struct dw_pcie *dw =3D to_dw_pcie_from_ep(ep);
> > +	struct rcar_gen4_pcie *rcar =3D to_rcar_gen4_pcie(dw);
> > +	int ret;
> > +
>=20
> > +	ret =3D clk_bulk_prepare_enable(DW_PCIE_NUM_CORE_CLKS, dw->core_clks)=
;
> > +	if (ret) {
> > +		dev_err(dw->dev, "Failed to enable ref clocks\n");
> > +		return;
> > +	}
> > +
> > +	rcar_gen4_pcie_common_init(rcar);
>=20
> The same note as to the previous patch. The clk_bulk_prepare_enable()
> method invocation can be moved to rcar_gen4_pcie_common_init().

I got it.

> > +
> > +	writel(PCIEDMAINTSTSEN_INIT, rcar->base + PCIEDMAINTSTSEN);
> > +}
> > +
> > +static void rcar_gen4_pcie_ep_init(struct dw_pcie_ep *ep)
> > +{
> > +	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> > +	enum pci_barno bar;
> > +
> > +	for (bar =3D 0; bar < PCI_STD_NUM_BARS; bar++)
> > +		dw_pcie_ep_reset_bar(pci, bar);
> > +}
> > +
> > +static void rcar_gen4_pcie_ep_deinit(struct dw_pcie_ep *ep)
> > +{
> > +	struct dw_pcie *dw =3D to_dw_pcie_from_ep(ep);
> > +	struct rcar_gen4_pcie *rcar =3D to_rcar_gen4_pcie(dw);
> > +
> > +	writel(0, rcar->base + PCIEDMAINTSTSEN);
>=20
> > +	rcar_gen4_pcie_common_deinit(rcar);
> > +	clk_bulk_disable_unprepare(DW_PCIE_NUM_CORE_CLKS, dw->core_clks);
>=20
> and clk_bulk_disable_unprepare() - to rcar_gen4_pcie_common_deinit().
>=20
> With the above notes fixed feel free to add:
>=20
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

Thank you very much for your review!

Best regards,
Yoshihiro Shimoda

> -Serge(y)
>=20
> > +}
> > +
> > +static int rcar_gen4_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_=
no,
> > +				       unsigned int type, u16 interrupt_num)
> > +{
> > +	struct dw_pcie *dw =3D to_dw_pcie_from_ep(ep);
> > +
> > +	switch (type) {
> > +	case PCI_IRQ_LEGACY:
> > +		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
> > +	case PCI_IRQ_MSI:
> > +		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
> > +	default:
> > +		dev_err(dw->dev, "Unknown IRQ type\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct pci_epc_features rcar_gen4_pcie_epc_features =3D {
> > +	.linkup_notifier =3D false,
> > +	.msi_capable =3D true,
> > +	.msix_capable =3D false,
> > +	.reserved_bar =3D 1 << BAR_1 | 1 << BAR_3 | 1 << BAR_5,
> > +	.align =3D SZ_1M,
> > +};
> > +
> > +static const struct pci_epc_features*
> > +rcar_gen4_pcie_ep_get_features(struct dw_pcie_ep *ep)
> > +{
> > +	return &rcar_gen4_pcie_epc_features;
> > +}
> > +
> > +static unsigned int rcar_gen4_pcie_ep_func_conf_select(struct dw_pcie_=
ep *ep,
> > +						       u8 func_no)
> > +{
> > +	return func_no * RCAR_GEN4_PCIE_EP_FUNC_DBI_OFFSET;
> > +}
> > +
> > +static unsigned int rcar_gen4_pcie_ep_get_dbi2_offset(struct dw_pcie_e=
p *ep,
> > +						      u8 func_no)
> > +{
> > +	return func_no * RCAR_GEN4_PCIE_EP_FUNC_DBI2_OFFSET;
> > +}
> > +
> > +static const struct dw_pcie_ep_ops pcie_ep_ops =3D {
> > +	.pre_init =3D rcar_gen4_pcie_ep_pre_init,
> > +	.ep_init =3D rcar_gen4_pcie_ep_init,
> > +	.deinit =3D rcar_gen4_pcie_ep_deinit,
> > +	.raise_irq =3D rcar_gen4_pcie_ep_raise_irq,
> > +	.get_features =3D rcar_gen4_pcie_ep_get_features,
> > +	.func_conf_select =3D rcar_gen4_pcie_ep_func_conf_select,
> > +	.get_dbi2_offset =3D rcar_gen4_pcie_ep_get_dbi2_offset,
> > +};
> > +
> > +static int rcar_gen4_add_pcie_ep(struct rcar_gen4_pcie *rcar)
> > +{
> > +	struct dw_pcie_ep *ep =3D &rcar->dw.ep;
> > +
> > +	rcar->mode =3D DW_PCIE_EP_TYPE;
> > +	ep->ops =3D &pcie_ep_ops;
> > +
> > +	return dw_pcie_ep_init(ep);
> > +}
> > +
> > +static void rcar_gen4_remove_pcie_ep(struct rcar_gen4_pcie *rcar)
> > +{
> > +	dw_pcie_ep_exit(&rcar->dw.ep);
> > +}
> > +
> > +static int rcar_gen4_pcie_ep_probe(struct platform_device *pdev)
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
> > +	err =3D rcar_gen4_add_pcie_ep(rcar);
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
> > +
> > +static void rcar_gen4_pcie_ep_remove(struct platform_device *pdev)
> > +{
> > +	struct rcar_gen4_pcie *rcar =3D platform_get_drvdata(pdev);
> > +
> > +	rcar_gen4_remove_pcie_ep(rcar);
> > +	rcar_gen4_pcie_unprepare(rcar);
> > +}
> > +
> > +static const struct of_device_id rcar_gen4_pcie_of_match[] =3D {
> > +	{ .compatible =3D "renesas,rcar-gen4-pcie-ep", },
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(of, rcar_gen4_pcie_of_match);
> > +
> > +static struct platform_driver rcar_gen4_pcie_ep_driver =3D {
> > +	.driver =3D {
> > +		.name =3D "pcie-rcar-gen4-ep",
> > +		.of_match_table =3D rcar_gen4_pcie_of_match,
> > +	},
> > +	.probe =3D rcar_gen4_pcie_ep_probe,
> > +	.remove_new =3D rcar_gen4_pcie_ep_remove,
> > +};
> > +module_platform_driver(rcar_gen4_pcie_ep_driver);
> > +
> > +MODULE_DESCRIPTION("Renesas R-Car Gen4 PCIe endpoint controller driver=
");
> > +MODULE_LICENSE("GPL");
> > --
> > 2.25.1
> >
