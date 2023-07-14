Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1E17752F62
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jul 2023 04:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjGNCaH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jul 2023 22:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjGNCaG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jul 2023 22:30:06 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2099.outbound.protection.outlook.com [40.107.113.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C39A2D40;
        Thu, 13 Jul 2023 19:30:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lLsbYA82/QCyRy8QpoPcr9Wq6ndUYicdsNAcqLd2z6+dy/NauAOwDH+YQLsLBiqmb/b++J7+G6Y4yrvIaPc/wIjVQUa+pJPyYA5vWqwTwkeUJR1UnDY05ObYagP57hYD0VXrE7hSclV8KKtekysMm2PiYrLmfZYyXv1cqRZpIWibIUnJ/qeZ902zCSQCEUGF0cyOcTloRtMigxYv8t4BNdgVqNjkWb6XLXQVCMqtB+4DyqSUlWWTx8/hEaDgFPCVgi10gBsEeNCnVU8wSHFqDxcoTlDI6Hh5jhZShEXogchZ/Vzdz3xbpq+Pjusd+9IbXLjzvn1JplUwx6+Iu562fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xclVDCKcV+MaVrzItzgCTnEPIIN1hhwBQpYdTrhlYFY=;
 b=nwJaVPybE0VoueXndod3Fo0KMy4hi1OL+AgWUDsub+f/omu2FWjekKJpX4tbdgcaEPseojsa+i7R2Ahc8VxCG46TdSoOaAvkLeut/ox6WaCYD57x0CwHJ9h3BY6awXmb0iV4UipdJ7/Gb4SnGhdVFDZSvRm+nCHSHqsB8jDvdzRaAHeHu/L/87PGSZistAIICWCrhLJl24DZnks1LudQki84P8DgCdaQxpuwT1wSMkkUM1ngP+6bW43PADwuLoXYgc0b8OdK3R1iaTDNFvo/Y6RaD/f8NtkDpZsdEWWnBSkGdEXt1kGxNuNJlYiGZJCKRlLnKdDsHvtZF7gR0v2LrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xclVDCKcV+MaVrzItzgCTnEPIIN1hhwBQpYdTrhlYFY=;
 b=m8GYgkHah0Zig01csxKU4T5g/Mc4XbtHXnOVmTtYtgKkPon9Xh2h930BMAr5uWR2wjZRxWydq4bnTJYINXPMlm/8eRlz/MQvZeN7RJgt+EGN2Uj74bVeLEM+VkDW0JU1gbjL97ythCCzGRuFGKeo3nc9zdcZ1vfYrGQPFTTkmqo=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYCPR01MB5742.jpnprd01.prod.outlook.com
 (2603:1096:400:46::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Fri, 14 Jul
 2023 02:29:59 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::4aa4:531b:e63:3d61]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::4aa4:531b:e63:3d61%2]) with mapi id 15.20.6588.017; Fri, 14 Jul 2023
 02:29:58 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Serge Semin <fancer.lancer@gmail.com>
CC:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
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
Subject: RE: [PATCH v17 18/20] PCI: rcar-gen4-ep: Add R-Car Gen4 PCIe Endpoint
 support
Thread-Topic: [PATCH v17 18/20] PCI: rcar-gen4-ep: Add R-Car Gen4 PCIe
 Endpoint support
Thread-Index: AQHZrzZP2VhkILrzCUu/rCYd8wmD6a+2D48AgAKHEIA=
Date:   Fri, 14 Jul 2023 02:29:58 +0000
Message-ID: <TYBPR01MB53414F2C3821984F43A06713D834A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230705114206.3585188-1-yoshihiro.shimoda.uh@renesas.com>
 <20230705114206.3585188-19-yoshihiro.shimoda.uh@renesas.com>
 <yzcrldzywq42am2f6wswgnospmp4bxe4uui7jsrr53ivtfj6ac@epajljzbduxl>
In-Reply-To: <yzcrldzywq42am2f6wswgnospmp4bxe4uui7jsrr53ivtfj6ac@epajljzbduxl>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYCPR01MB5742:EE_
x-ms-office365-filtering-correlation-id: cf21c137-1cce-4364-f2cc-08db84123829
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jHFSGr8a2UgAXxpgXg32mYknTWS48HDfGSqdx0Ta86j3WjF2Au/PXDwuve6OxF27bGJlUQMjZVth9MvHh1rXLKEJLgEJSmLY1S1D/jeIJU6zCVgUbBGtIJZkhekqsATRlJp6Y7UYGzBFap+eF9p+e56DqcjNJS6zR3wZySiRt1FnnMp9UrZYfw7mwBHejRrD1ex6YWZsoqGy7e+kOkfYPwZyBJa1rQeWIxz/QpgxASut6pxKBWYDso0shKVW1je4DZgcuAf3udF4BEN2Y8QgupgJiO0lHS53x2MP7Tdq0I2O99oK2a1TOVl9gkj2rQueidYZo4OrI1BuwujfN1iWYakK2JTnjlbKt2LMqXklcju5M+g61vzBqiBDrrjy6dQiSP7hxvPlMsUyTeDfyZ/5PaW9yR9Y4IlF31AhkR51Bcv/zTJexupqWkUk1J3JclDqFAS3mbMWFfzVeSlajdVz5zP8JFzv3m6p8OI1TXRePl5791Guq66vxWW8Kw8adZ03oz6rwBf5q7WKNw+L8eHpf8VEI/PrDP8aiwkLfOoUNlg6po6TvkFIJdVVJPfdOdUL6IMKdsSCmylDxjEWDtRFxKqYmddzJhTu3JPLVUN/VGpv0ZHCPFdEzA+OFMqwjHwr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(366004)(396003)(346002)(451199021)(54906003)(316002)(71200400001)(186003)(64756008)(478600001)(41300700001)(7696005)(6916009)(4326008)(76116006)(66556008)(66946007)(66476007)(66446008)(9686003)(8936002)(8676002)(7416002)(6506007)(86362001)(52536014)(55016003)(5660300002)(33656002)(83380400001)(38070700005)(122000001)(2906002)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SQeLRCHb/1t/KpYF8ZDXyD9L2R/aOeXe2ERgOTZ1H6MYgxgVZ4IaXUXwjyyu?=
 =?us-ascii?Q?DdO65dUEKzr1XwjHan2UT9p8uODrXDhjQ7NkKK56tfBMnrXf3YCM+O53n8hw?=
 =?us-ascii?Q?grkqy5E+ZT5kqB9THshIlPj7wg6CL4UamP5swr90emvVRPImNXuQ61fem5Yc?=
 =?us-ascii?Q?9XoICy9eKjQYRzpvhVH3ZUEDUqtyl6R5U6aCRNtw62yFYVxzhT/yer74Chea?=
 =?us-ascii?Q?QLE22nVZd4OBMkALwWgh/IbUPi0ea6YqInXIFTEvWogQN+Zhldx+M5tmtMv8?=
 =?us-ascii?Q?5lXmtrOG47LO+DgmqxJRPMP72oThlz2CRNXCLdX/3zoh2z0eNyG7H5CXmzc2?=
 =?us-ascii?Q?JbCRZdFj90Oy5CrSm8m3DrxOXiRoT9SUV400btYT094OnRPT7hY0YDDT49cZ?=
 =?us-ascii?Q?L9fp3MmPQPpbZTUlKVH53O4Tr0TKm3/1vh7A3JsR1+U3TpGzknFJLc7tKDOP?=
 =?us-ascii?Q?4XV12mmCfhTE/wHS0zUF7pq+wpu/qYK7uIyIAm2ceXKEhtyi90qTAyTW21iI?=
 =?us-ascii?Q?oInuWOYNknoPsiQowxVmpsdY1kJuRAjjQFKOKKHFKmIerfOynhNzeBH1eBUO?=
 =?us-ascii?Q?2SnmnDzDCXmEqIdOpPbzxHMob0yR8aCL7KdbCC1m4OFwFZAQglAipjFTRDBT?=
 =?us-ascii?Q?PDtvWfM2/XLC8LIFJNqinpDSeyWaWyOo9h/+W4yY3vMNu+IV1wffJAWZM4S1?=
 =?us-ascii?Q?EKXssGfEyFyFQ6p+R/TTlw2XW/G2yTEcyCrMFTLEjS4YyvAlAgxxdxC85vbW?=
 =?us-ascii?Q?GdII2Kf48yh9ieE0JjsdODiO+RDucvUwlSkCrAT91BWLrHKlIVx/oyHmjQa9?=
 =?us-ascii?Q?cfl32KytEEbLXKZIQ7hjQhCmp8Zs6Nvt8hPzKNYXZzt1cnLxa7aMWVwvNEvv?=
 =?us-ascii?Q?LkSr/jnq2SF8d7X90wHG5lET7sJfWVTywuNJm8CoNR8UotEuC2mckgrTFpq9?=
 =?us-ascii?Q?q3hy0sJpdaWTzuxyU3pSkkSQC2QTR30lHxbv/6aGx21FS1rCXNkvmmAAZlfJ?=
 =?us-ascii?Q?S8CgJAk3CmkPNEMdvPA8seQ6pmf3yMaKOtEH6AUiG8dITomvRLPllPHtXGjF?=
 =?us-ascii?Q?ZzBBvzmXLSIKEuI/g5LwPlMbmhNMojpO6UEz8H+2EEoyJDDn0b94lmhpWxMK?=
 =?us-ascii?Q?X1DBme1g6nZI8a0xjUMW7F8bctgwX+IgJoKeIvX4AMmM6UXfRNinF+5PdXWt?=
 =?us-ascii?Q?TmoLKEXdcafGijqbEiBpTrMLPWwmt1KcKBL3JW6KaxnDkcd2qxUKtABLM2cW?=
 =?us-ascii?Q?4eQ2G5WwGtgS5Q5ZN6WIjqEcH0y2De0BrHTqvjv+rJ6OLOZiYCDLxNQ4eGAD?=
 =?us-ascii?Q?4qZOLevkFuJ9p18zjBPqgzRuTU7LMYzFx4ZImZhwNJGeGEJI5fAiLQyA6Py9?=
 =?us-ascii?Q?oBsHTfOsGC4VHtVtYzUA4VfAZj6v7M+Tl1QBz0phA9LBG1kPuXoeNBiL9WXt?=
 =?us-ascii?Q?k9MpkQxTXp1D92P8jRyYJvvSPKTiTzBiuRzRBbSa2kGJ8zKHzX+kDDaKV9CP?=
 =?us-ascii?Q?RXJb4fyskbEm7+fYujQy2pwwzgMiOO38Yzha+cxC+TyGeOU1nrWMi15JRRCt?=
 =?us-ascii?Q?mL4gwo138s3IcJi9VORrcbhPJ542nSYz1ag/q9Lwh3dvDJfdGpu6P6CW+Dzs?=
 =?us-ascii?Q?eVkJwiy5wyZ7NdmNZHslkyXCA6uHOA0fNnX/9PnLAOpNQIaVGW2zlZ9IKo5d?=
 =?us-ascii?Q?5WLlFg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf21c137-1cce-4364-f2cc-08db84123829
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2023 02:29:58.9408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e340yVDSvj984WsINNuv5WFGQFoX6HK2WhG47D1zgxjM/572PAMUisvVPOTCfvy9/bVTxRzvZluRG90AZibtzKEMZLcb79eUuT00Lw/BOhqoVRntFpNh3wqajAy7KMzf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5742
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Serge,

> From: Serge Semin, Sent: Wednesday, July 12, 2023 8:50 PM
>=20
> On Wed, Jul 05, 2023 at 08:42:04PM +0900, Yoshihiro Shimoda wrote:
> > Add R-Car Gen4 PCIe Endpoint support. This controller is based on
> > Synopsys DesignWare PCIe.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> >  drivers/pci/controller/dwc/Kconfig            |   9 +
> >  drivers/pci/controller/dwc/Makefile           |   2 +
> >  .../pci/controller/dwc/pcie-rcar-gen4-ep.c    | 191 ++++++++++++++++++
> >  3 files changed, 202 insertions(+)
> >  create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4-ep.c
> >
> > diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controlle=
r/dwc/Kconfig
> > index 64d4d37bc891..4d877cd18374 100644
> > --- a/drivers/pci/controller/dwc/Kconfig
> > +++ b/drivers/pci/controller/dwc/Kconfig
> > @@ -424,4 +424,13 @@ config PCIE_RCAR_GEN4
> >  	  Say Y here if you want PCIe host controller support on R-Car Gen4 S=
oCs.
> >  	  This uses the DesignWare core.
> >
> > +config PCIE_RCAR_GEN4_EP
> > +	tristate "Renesas R-Car Gen4 PCIe Endpoint controller"
> > +	depends on ARCH_RENESAS || COMPILE_TEST
> > +	depends on PCI_ENDPOINT
> > +	select PCIE_DW_EP
> > +	help
> > +	  Say Y here if you want PCIe endpoint controller support on R-Car Ge=
n4
> > +	  SoCs. This uses the DesignWare core.
> > +
> >  endmenu
> > diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controll=
er/dwc/Makefile
> > index 486cf706b53d..0fb0bde26ac4 100644
> > --- a/drivers/pci/controller/dwc/Makefile
> > +++ b/drivers/pci/controller/dwc/Makefile
> > @@ -28,6 +28,8 @@ obj-$(CONFIG_PCIE_UNIPHIER_EP) +=3D pcie-uniphier-ep.=
o
> >  obj-$(CONFIG_PCIE_VISCONTI_HOST) +=3D pcie-visconti.o
> >  pcie-rcar-gen4-host-drv-objs :=3D pcie-rcar-gen4.o pcie-rcar-gen4-host=
.o
> >  obj-$(CONFIG_PCIE_RCAR_GEN4) +=3D pcie-rcar-gen4-host-drv.o
> > +pcie-rcar-gen4-ep-drv-objs :=3D pcie-rcar-gen4.o pcie-rcar-gen4-ep.o
> > +obj-$(CONFIG_PCIE_RCAR_GEN4_EP) +=3D pcie-rcar-gen4-ep-drv.o
> >
> >  # The following drivers are for devices that use the generic ACPI
> >  # pci_root.c driver but don't support standard ECAM config access.
> > diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4-ep.c b/drivers/p=
ci/controller/dwc/pcie-rcar-gen4-ep.c
> > new file mode 100644
> > index 000000000000..1de33a9529bd
> > --- /dev/null
> > +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4-ep.c
> > @@ -0,0 +1,191 @@
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
>=20
> I don't see you disabling the clocks. It should be done in a
> respective antagonistic method (like ep_deinit()?).
> * The same concerns the Rcar Gen4 RP driver submitted in the previous
> * patch.

You're correct. I'll fix it on both root complex and endpoint drivers.

> > +	if (ret) {
> > +		dev_err(dw->dev, "Failed to enable ref clocks\n");
> > +		return;
> > +	}
> > +
>=20
> > +	rcar_gen4_pcie_basic_init(rcar);
>=20
> Please, see my note sent to the previous patch regarding having
> rcar_gen4_pcie_basic_deinit().

I'll add such a function.

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
> > +}
> > +
> > +static int rcar_gen4_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_=
no,
> > +				       enum pci_epc_irq_type type,
> > +				       u16 interrupt_num)
> > +{
> > +	struct dw_pcie *dw =3D to_dw_pcie_from_ep(ep);
> > +
> > +	switch (type) {
> > +	case PCI_EPC_IRQ_INTX:
> > +		return dw_pcie_ep_raise_intx_irq(ep, func_no);
> > +	case PCI_EPC_IRQ_MSI:
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
> > +static unsigned int rcar_gen4_pcie_ep_func_conf_select2(struct dw_pcie=
_ep *ep,
> > +							u8 func_no)
> > +{
> > +	return func_no * RCAR_GEN4_PCIE_EP_FUNC_DBI2_OFFSET;
> > +}
> > +
> > +static const struct dw_pcie_ep_ops pcie_ep_ops =3D {
> > +	.ep_pre_init =3D rcar_gen4_pcie_ep_pre_init,
> > +	.ep_init =3D rcar_gen4_pcie_ep_init,
> > +	.ep_deinit =3D rcar_gen4_pcie_ep_deinit,
> > +	.raise_irq =3D rcar_gen4_pcie_ep_raise_irq,
> > +	.get_features =3D rcar_gen4_pcie_ep_get_features,
> > +	.func_conf_select =3D rcar_gen4_pcie_ep_func_conf_select,
> > +	.func_conf_select2 =3D rcar_gen4_pcie_ep_func_conf_select2,
> > +};
> > +
> > +static int rcar_gen4_add_pcie_ep(struct rcar_gen4_pcie *rcar,
> > +				 struct platform_device *pdev)
> > +{
> > +	struct dw_pcie_ep *ep =3D &rcar->dw.ep;
> > +	int ret;
> > +
> > +	rcar->mode =3D DW_PCIE_EP_TYPE;
> > +	ep->ops =3D &pcie_ep_ops;
> > +
> > +	ret =3D dw_pcie_ep_init(ep);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "Failed to initialize endpoint\n");
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static void rcar_gen4_remove_pcie_ep(struct rcar_gen4_pcie *rcar)
> > +{
> > +	dw_pcie_ep_exit(&rcar->dw.ep);
> > +}
> > +
> > +static int rcar_gen4_pcie_ep_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev =3D &pdev->dev;
> > +	struct rcar_gen4_pcie *rcar;
> > +	int err;
> > +
> > +	rcar =3D rcar_gen4_pcie_devm_alloc(dev);
> > +	if (!rcar)
> > +		return -ENOMEM;
> > +
> > +	err =3D rcar_gen4_pcie_get_resources(rcar, pdev);
> > +	if (err < 0) {
> > +		dev_err(dev, "Failed to request resource: %d\n", err);
> > +		return err;
> > +	}
> > +
> > +	platform_set_drvdata(pdev, rcar);
> > +
> > +	err =3D rcar_gen4_pcie_prepare(rcar);
> > +	if (err < 0)
> > +		return err;
> > +
> > +	err =3D rcar_gen4_add_pcie_ep(rcar, pdev);
> > +	if (err < 0)
> > +		goto err_add;
> > +
> > +	return 0;
> > +
> > +err_add:
> > +	rcar_gen4_pcie_unprepare(rcar);
> > +
> > +	return err;
> > +}
> > +
>=20
> > +static int rcar_gen4_pcie_ep_remove(struct platform_device *pdev)
> > +{
> > +	struct rcar_gen4_pcie *rcar =3D platform_get_drvdata(pdev);
> > +
> > +	rcar_gen4_remove_pcie_ep(rcar);
> > +	rcar_gen4_pcie_unprepare(rcar);
> > +
> > +	return 0;
> > +}
>=20
> Please convert this function to returning void and assign to the
> platform_driver.remove_new pointer instead.

I got it.

> > +
> > +static const struct of_device_id rcar_gen4_pcie_of_match[] =3D {
> > +	{ .compatible =3D "renesas,rcar-gen4-pcie-ep", },
> > +	{},
> > +};
> > +
> > +static struct platform_driver rcar_gen4_pcie_ep_driver =3D {
> > +	.driver =3D {
> > +		.name =3D "pcie-rcar-gen4-ep",
> > +		.of_match_table =3D rcar_gen4_pcie_of_match,
> > +	},
> > +	.probe =3D rcar_gen4_pcie_ep_probe,
>=20
> > +	.remove =3D rcar_gen4_pcie_ep_remove,
>=20
> ditto

I got it.

Best regards,
Yoshihiro Shimoda

> -Serge(y)
>=20
> > +};
> > +module_platform_driver(rcar_gen4_pcie_ep_driver);
> > +
> > +MODULE_DESCRIPTION("Renesas R-Car Gen4 PCIe endpoint controller driver=
");
> > +MODULE_LICENSE("GPL");
> > --
> > 2.25.1
> >
