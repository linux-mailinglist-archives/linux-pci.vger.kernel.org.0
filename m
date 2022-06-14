Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C2C54AFAD
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jun 2022 13:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243561AbiFNL6J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jun 2022 07:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242172AbiFNL6A (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jun 2022 07:58:00 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2104.outbound.protection.outlook.com [40.107.114.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A087734666;
        Tue, 14 Jun 2022 04:57:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STrrxJQu7RLoUXh5+S5cLhRSeyftfo62PwjYavPloopTNB+MHFwd5/f+LciNg6Pwchs6UaCR1dHUl+zLdoyqCiuD4hNKDQEcCwxQxIgieIdxCFNiAUgEO8N26HEeD+AYRUGPueuciFdb8h9r+YSWgXbF3NHLXrq7UDTpte2VHfgMztJPlRqmmEaONQs7UfxFKEqEXGnwmS0n5GmKY1MFiG/UQJWqOmNrNoelYDzTzGPAlFyz4c01XkuXMG8iTP1FVUhx0c6Se4kzW9RxdiZa3bVbjz0km9Zm9J7MIsNGL/4k6BMP5tce/GQ+1Tk5cmcS1eVwMw1IDB1lnKzqlBJEyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cAcR3PuwEf0+twD7VRaHXskQUQL2z31S1XIzC+qqaM8=;
 b=KMIZU68CRIAHTCRJXH4nxtq83PFckLkHAuE3TYqWclJ3E9cSmTTRIbHfyFqvvKapEqbSUk451qd3DHRICMutmG9HzCc3CSGYVUDRL4eIURemK8JZqkf/O9LJFrkNyrQoQuZe33hcoZNq+IJlKciz8vTLO7C8WkrQq3F6cmuqb9hFAMkIGl6x5LXCKPEqdVJdnW6B/CoftyvpIpz/IOFUgpM9orU4Mb4+QN2SSysp0Xnt4bENupydQ9gWdn88UMFF/S9zmeOm/YLkaciHBrjBtyoS07Q56ZYADkw22G1ndPzotJo9/jMoXb4CZS9C8V+r+PlvWzx0PAhHmhM3CYfixg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cAcR3PuwEf0+twD7VRaHXskQUQL2z31S1XIzC+qqaM8=;
 b=HFQXLxWtL0vIH/qmLwOGI8CGI9CxtudpvkngG6wum6nGfENv8ACnUn1VRmavecXsq2IhDDePyJ9Em32/xg0ya3XgCdBMeCdh/+K3qpKekAVJ6Dr8rgkHH6qhTyMKWlVTWrzm24SJh7NDBQTufr3yQS+vN1p/uoBVetVAUZvlALE=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by OSBPR01MB2535.jpnprd01.prod.outlook.com
 (2603:1096:604:22::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15; Tue, 14 Jun
 2022 11:57:56 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::b596:754d:e595:bb2d]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::b596:754d:e595:bb2d%5]) with mapi id 15.20.5332.022; Tue, 14 Jun 2022
 11:57:56 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "magnus.damm@gmail.com" <magnus.damm@gmail.com>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 3/7] PCI: renesas: Add R-Car Gen4 PCIe Host support
Thread-Topic: [PATCH 3/7] PCI: renesas: Add R-Car Gen4 PCIe Host support
Thread-Index: AQHYfxy+YRgxwjcK00+n4YJvypnQfK1Ny6AAgAD37IA=
Date:   Tue, 14 Jun 2022 11:57:56 +0000
Message-ID: <TYBPR01MB5341C143D0522857B890E70CD8AA9@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20220613115712.2831386-4-yoshihiro.shimoda.uh@renesas.com>
 <20220613203406.GA714216@bhelgaas>
In-Reply-To: <20220613203406.GA714216@bhelgaas>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 71feef61-64e7-4eb1-40ea-08da4dfd1e9b
x-ms-traffictypediagnostic: OSBPR01MB2535:EE_
x-microsoft-antispam-prvs: <OSBPR01MB253566BF067951ED58E74AF9D8AA9@OSBPR01MB2535.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: te51LfvO83zOJSCq/oekHgfiwGEA3Blp9R2XgjTHsPt4V4EuRK4f7k7YrtjRPeQtxuxnOP7KlrwAk0g/wcgpNWC0LHWVSiKS6hO21ks2u1kALXbc4MHiktKnb53BXYY3ajdV71i4CsCQSebvsky+yoJl6UBjI4ja4DT4m5lrEePyLVLml38FfSDfUbNYAFPdAEuGYuxCm9J6V9K3RU7q5vQOLWXkN2KL+p4lDavwW4ZRkDGVzoBe/BnNdQizVbMJKxcXJHDnGE8n8Mpck4z5eLwdk1yRvgsVxeNQhz9v57zXiRn6mLts+J3JAgQORPVrZSPbSL7VhM3SIa+E3930DNaiYoHXW4l+WXJZwAMYw7yJJFxriCl1jCjp39m+F/WqWv8rP1Ph3kILb76pmiCqy0tqrK11oT/yy/z2zcIq2TNMXtY4PxuJ9wOjk3LWTTBrbq4cYKLMrsAl04k5InMCy62FsiRUUoLa9Ps7n0/ux4zkEkDDuQ7S+lZEd1QLUVrMI7Y+GDpHDEsUNC+8eVwFq9prRIMZkG74Aj4aIQeUdBKqAvuJkxbyHhA7C8eFvuDSOkhiTMMJTN5WAeJuNawmfVfG/pelm30uxheF9sFZER6P8nw+pEx1hwJsSWC7+uw7vfA2U61RBIhOZMhZ2lSkZxQqnygTBkx2k6nOzZv6jze/LDwTKvmF1ylIQ/C7VhmFqQghTA8mxlN2IuHRkgTmZA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(38070700005)(122000001)(71200400001)(2906002)(8676002)(86362001)(8936002)(186003)(66476007)(66446008)(508600001)(4326008)(55016003)(6916009)(76116006)(66556008)(64756008)(66946007)(9686003)(316002)(6506007)(7696005)(38100700002)(54906003)(52536014)(5660300002)(7416002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yZovoZmAHsE3q3SLpSru3xiTvPIiBQSaDzeXJJl1o5iB1hmNQF3Z9I0VLpSp?=
 =?us-ascii?Q?bGGdDvdVedmOl6eYBR6x58+azPI3ZCvZN5oingbx/UADP26k8u+T52+7ki0Z?=
 =?us-ascii?Q?eD5fajIgWQlDwx4LF7YqrQ7Djdspg0M8Tfr4EewYgcOM0cCKYV+2UrhdOMZY?=
 =?us-ascii?Q?TUXBKQwK8sjyC2xO97D9nM1vqK2D22SBLpQWYMQth37dCDjrhY4ng/LprkoN?=
 =?us-ascii?Q?Su0tZnonO1XAw2nhhHxpx8zk+eBUuwfa8YRiclZW8OFs/mGTieFEJ0T0oshN?=
 =?us-ascii?Q?QTFDyfuXJBYoazZGfEQjuu5hqARVI24RlHiuj4JgyTHYZJLHEBDfEvVIpGB+?=
 =?us-ascii?Q?bLKV94bdMCp324Y1lopR+rcgtBUKxXeX5abEiEiCDUzJxZyOLzTwIw8W28nD?=
 =?us-ascii?Q?xo+UUC8rSAEUtVXnMH2x9YCWgMbJHxY291FnXoOCYH9xOsA/luqBvX+nKFMH?=
 =?us-ascii?Q?m3aHFLQNQLPYqENS3g7M85ed0D7N3TJrb4qnjBy8WyLqJpW01+LHOr+3A9hj?=
 =?us-ascii?Q?6gz51JW9vLm9ivXjMHR4Nq6Fkzj6Fj4QqUrv4lKL3gR1zJMYrUjcbGrlObQT?=
 =?us-ascii?Q?3wwTWOSuFXA08SPjUa6LOwBF4yK168ZiLhSW+h21kMhkWapsbkwBrXOd6JEX?=
 =?us-ascii?Q?G3sQu8oq/T9+ZSjFMnJNbahFaTMq2YIDVXjz44bRmv47Fd7eFelM7Mmff0OK?=
 =?us-ascii?Q?jsFlSw1sGhzjQzbS+iseJtE/apljscHIPoa3pg6seFnZjfmD7eNa/ZT8RHjc?=
 =?us-ascii?Q?42HBpl0znnUaHmecXezMwnoNf7Q5MevSNgvaotgF9ixr2fyf/L3xnHBadjLQ?=
 =?us-ascii?Q?005up2FTcRINNGwgbBJuhU9ymoE3fJrXr/y69ZlCZe2z/gAXVXmNK63By5qf?=
 =?us-ascii?Q?+xlQ0S0PyE+MqyIv76xGiQLp3cVZR0iomf44hWB62p6ZIFyjeSkFhMwOHDbN?=
 =?us-ascii?Q?Zzh38ICVS7y/oITd3MRIH4jRoWFbtqGguCvsfhrkZG5JdVE2APMi6FzI8W/b?=
 =?us-ascii?Q?zmPCA5iuoDoePeDpofvXVlRN8djy/RobCRX3rZmpfEQAqGm+jMPYzBsTrMwC?=
 =?us-ascii?Q?88rvwDMlpT9kXdtYoYrVeIjCLY7AEf4GyOPAtsCSLt7ou8aplwvtbkTZqNS9?=
 =?us-ascii?Q?4Y07MIsOAgd0k2WLbwrERiCagHl1FbCX8ITcZphXlpeX0Ra8mNLtMWvGshuk?=
 =?us-ascii?Q?EwKlh+Ao/Lfe11BAUcTJgDaubQnNanAePPf7gcAwem701X/XGha22JSSqztk?=
 =?us-ascii?Q?XO3ewSM4UXbeKEkGcPUs/O42d0E2Zm7PApYcPFlI2WQlMHspYlntPjqb1Nd1?=
 =?us-ascii?Q?4f4iW1epVO5+BTVIJ7kYcU8A8H1bMvmkm81oRjX2TGFHK9O3Imzf2lVDaJ7G?=
 =?us-ascii?Q?cB2WGTFWjcCI/Etc1vKvWXOMOgUY7xKZzX93Jzt31KLRhNa9g+DkHwfbW0Ix?=
 =?us-ascii?Q?us1tvJc1XTBof1DXuaPUEJ0JyOwui0+ujtJPG7vEJpNoMzeipBP3aU52svx1?=
 =?us-ascii?Q?GfEIORa/gWzvV1M6YpMrRp1uHC/frqxYq4fhFhUnS9CmPrOMVb4w3pRJqE2H?=
 =?us-ascii?Q?XzbKJ6R2OJzUPs6oirWt/EUxh9SSP9yeylFI//gguzehKHHYCa4jELdd329f?=
 =?us-ascii?Q?pupIAcc5a7XFes/cIUoh/YOqpyCWAe3Ee2pJVrmTC2OyRQ9nw8nUe+khEPkU?=
 =?us-ascii?Q?VLLkhC/bnN8uBrNbR4t84lbgIwuRo3DIhLmDRjthT3UjMEsjG1qi2eL+DgOS?=
 =?us-ascii?Q?lRuED4tvZ+Rc2I7ylIHdQE77e9sJ/cKVyPIvsJuk6iraol/umXM2UMP5l7e/?=
x-ms-exchange-antispam-messagedata-1: KiA0n1JM7cllFCopwqB0+I9WGh8zTLgLq68=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71feef61-64e7-4eb1-40ea-08da4dfd1e9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2022 11:57:56.1589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JNSi8jIOkHX1ph0yiQGDMt8BmZ5dDHRFv6oAzOa1ljmqyhb+wIQ9uyPMeyRbodxuIVbAzTTJyuk3IVOXprBDto/btbsuwahNZWM/kAAuBDzuZuLDz9j364nlzrHLS+72
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2535
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Thank you for your review!

> From: Bjorn Helgaas, Sent: Tuesday, June 14, 2022 5:34 AM
>=20
> On Mon, Jun 13, 2022 at 08:57:08PM +0900, Yoshihiro Shimoda wrote:
> > Add R-Car Gen4 PCIe Host support. This controller is based on
> > Synopsys Designware PCIe.
>=20
> You used "DesignWare" below, which I think is what Synopsys uses.

Yes. So, I'll rename "Designware" with "DesignWare" in this description.

> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> >  drivers/pci/controller/dwc/Kconfig            |   9 +
> >  drivers/pci/controller/dwc/Makefile           |   1 +
> >  .../pci/controller/dwc/pcie-rcar-gen4-host.c  | 235 ++++++++++++++++++
> >  drivers/pci/controller/dwc/pcie-rcar-gen4.c   | 198 +++++++++++++++
> >  drivers/pci/controller/dwc/pcie-rcar-gen4.h   |  59 +++++
> >  5 files changed, 502 insertions(+)
> >  create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4-host.c
> >  create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4.c
> >  create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4.h
> >
> > diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controlle=
r/dwc/Kconfig
> > index 62ce3abf0f19..3ddccc9c38c5 100644
> > --- a/drivers/pci/controller/dwc/Kconfig
> > +++ b/drivers/pci/controller/dwc/Kconfig
> > @@ -384,4 +384,13 @@ config PCIE_FU740
> >  	  Say Y here if you want PCIe controller support for the SiFive
> >  	  FU740.
> >
> > +config PCIE_RCAR_GEN4
> > +	bool "Renesas R-Car Gen4 PCIe Host controller"
> > +	depends on ARCH_RENESAS || COMPILE_TEST
> > +	depends on PCI_MSI_IRQ_DOMAIN
> > +	select PCIE_DW_HOST
> > +	help
> > +	  Say Y here if you want PCIe host controller support on R-Car Gen4 S=
oCs.
> > +	  This uses the DesignWare core.
>=20
> > +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4-host.c
> > @@ -0,0 +1,235 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * PCIe host controller driver for Renesas R-Car Gen4 Series SoCs
> > + * Copyright (C) 2022 Renesas Electronics Corporation
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
> > +/* ASPM L1 PM Substates */
> > +#define L1PSCAP(x)		(0x01bc + (x))
>=20
> Looks like the stuff in pcie-rcar-gen4.h.  Should this go there?

Yes. I'll move it.

> > +	/* Set Max Link Width */
>=20
> Superfluous comment, since the function name says the same thing.

I got it. I'll drop it.

> > +	rcar_gen4_pcie_set_max_link_width(pci, pci->num_lanes);
>=20
> > +/* Link Capabilities - Maximum Link Width */
> > +#define  PCI_EXP_LNKCAP_MLW_X1	BIT(4)
> > +#define  PCI_EXP_LNKCAP_MLW_X2	BIT(5)
> > +#define  PCI_EXP_LNKCAP_MLW_X4	BIT(6)
>=20
> I think we should define these in include/uapi/linux/pci_regs.h.
> Use the same style as the other #defines there, i.e.,
>=20
>   #define  PCI_EXP_LNKCAP_MLW_X1  0x00000010
>   #define  PCI_EXP_LNKCAP_MLW_X2  0x00000020
>   #define  PCI_EXP_LNKCAP_MLW_X4  0x00000040

I got it. I'll add macros from x1 to x32.

> > +/* Renesas-specific */
> > +#define PCIEMSR0		0x0000
> > +#define  BIFUR_MOD_SET_ON	(0x1 << 0)
> > +#define  DEVICE_TYPE_EP		(0x0 << 2)
> > +#define  DEVICE_TYPE_RC		(0x4 << 2)
> > +
> > +#define PCIEINTSTS0		0x0084
> > +#define PCIEINTSTS0EN		0x0310
> > +#define  MSI_CTRL_INT		BIT(26)
> > +#define  SMLH_LINK_UP		BIT(7)
> > +#define  RDLH_LINK_UP		BIT(6)
>=20
> Is there a reason to mix the "(0x1 << 0)" style and the "BIT(26)"
> styles?

No, this should be fixed. I'll use "BIT()" instead.

> > +extern u32 rcar_gen4_pcie_readl(struct rcar_gen4_pcie *pcie, u32 reg);
> > +extern void rcar_gen4_pcie_writel(struct rcar_gen4_pcie *pcie, u32 reg=
, u32 val);
> > +extern void rcar_gen4_pcie_set_max_link_width(struct dw_pcie *pci, int=
 num_lanes);
> > +extern int rcar_gen4_pcie_prepare(struct rcar_gen4_pcie *pcie);
> > +extern void rcar_gen4_pcie_unprepare(struct rcar_gen4_pcie *pcie);
> > +extern int rcar_gen4_pcie_pm_runtime_enable(struct device *dev);
> > +extern void rcar_gen4_pcie_pm_runtime_disable(struct device *dev);
> > +extern int rcar_gen4_pcie_devm_clk_and_reset_get(struct rcar_gen4_pcie=
 *pcie,
> > +						 struct device *dev);
> > +extern struct rcar_gen4_pcie *rcar_gen4_pcie_devm_alloc(struct device =
*dev);
>=20
> Don't bother with "extern" on function declarations; this would be the
> only instance in drivers/pci/.

I got it. I'll drop "extern".

Best regards,
Yoshihiro Shimoda


