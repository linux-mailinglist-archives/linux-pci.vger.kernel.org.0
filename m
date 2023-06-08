Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241DD727A52
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jun 2023 10:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjFHIr1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Jun 2023 04:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234052AbjFHIrY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Jun 2023 04:47:24 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2116.outbound.protection.outlook.com [40.107.114.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9689E;
        Thu,  8 Jun 2023 01:47:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cRttRBgIRFm+x5VqlaghBVOp6DKb59lGDQOAuajR2OL8+FXzSA5HA2llXoMebdJnMK+OZAO5ZjxPmdqTYkCGlvPsn5GkqEwwa38kIXpkonS8lUHwYfq6r6VLc2XV5mQIfRG8VcYu8Oa0T9NiCVEvWsIYVzswNVokJZTUQ/dD6wevzIVTTL1zwv8V10PErjDRuocfp01yCVU/O867Qh7k8u3vPoWQaQzNH2X33MKH3NHztE52XDRLjjKifqSyhzJrOuIvRvOJyjm0QtbOut5jcw3xLup51hYDwxJbwsYIuZifNY16w4tWVO2/hFBV+7TBnXUBzYB0wzmYqZGKoPUzzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qkYJUdboK1ipDPM8bJIyFin92p0ZKRq/WLm0CND9qcQ=;
 b=OTb0qNZIR1gF9F1GjzHfgodVEI69eD4x7XDDudY19p33xlcC0fqmwVrEmhglp5jzKup7FsSveOumdT8HReGJXo6pcBMWAhYnO35OhQiemBjyXis3zfRTdQ/qsf47zCr43f3OMKlitQA6xGJx+7Sc4Sds1fSsJhly0dzQmm0Inn927rXqt7jIV9+D6wGii0dBGA5+nkczmeT/L00f8rcGteU4WQrvSEdkeEvLa4X7agVMa2H5RZy3r//10/OVr7JTH/F+YC7sMspkGYw6Ue3vvb+us536er0gGIveflRPMH5m939kSuRxC6oqXPPLGUuB0GXIqiOC6z56T6LCyDzH6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qkYJUdboK1ipDPM8bJIyFin92p0ZKRq/WLm0CND9qcQ=;
 b=jqGkqxgrAATTxgOsLfgXkgS0lPToTqJ9lJ7a8d9u9Z91vnKfsuqxPSJKDX4Q63/a+68oKCCY6lN+l/jmDyTeP+Ttwb64G67hwFsIRpMAIjDw6Y93fLp+Jb3zAIY6umcZyRcStt0LGjr9sdsTgN0ThHBgqmSR93Ut8c2yWmR4pCo=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by OS3PR01MB9482.jpnprd01.prod.outlook.com
 (2603:1096:604:1c9::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19; Thu, 8 Jun
 2023 08:47:16 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::711d:f870:2e08:b6e1]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::711d:f870:2e08:b6e1%3]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 08:47:17 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Serge Semin <fancer.lancer@gmail.com>
CC:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "mani@kernel.org" <mani@kernel.org>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v16 19/22] PCI: rcar-gen4: Add R-Car Gen4 PCIe Host
 support
Thread-Topic: [PATCH v16 19/22] PCI: rcar-gen4: Add R-Car Gen4 PCIe Host
 support
Thread-Index: AQHZgwfSD1pv8+kZFEalYK7OljPo8698cOgAgAEOU0CAAe45gIABPKpg
Date:   Thu, 8 Jun 2023 08:47:16 +0000
Message-ID: <TYBPR01MB53417E55F5F9E667D679901CD850A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230510062234.201499-1-yoshihiro.shimoda.uh@renesas.com>
 <20230510062234.201499-20-yoshihiro.shimoda.uh@renesas.com>
 <20230605143908.fcgqzedp7oiarbyu@mobilestation>
 <TYBPR01MB5341A67CF6DFFCB396F13195D853A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <20230607121533.cxvidvdqat5h2tqu@mobilestation>
In-Reply-To: <20230607121533.cxvidvdqat5h2tqu@mobilestation>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|OS3PR01MB9482:EE_
x-ms-office365-filtering-correlation-id: 42da5dd8-36b5-4c16-4ad1-08db67fcf6a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BFJp+SJxKM7npG4LkzDthVWpRnOltMQDi6RtMWz7HI2rdUGTZIvLrZFSbK3vKGrnvz81fimpq8s1e0oSarBbsmT7qp9KdblnSMB7lBj2VaIAuCMG56E+LzbCnSyLwIkOJ91qgtBF4r8pYlyeMrhR7jKjWPzf95eeWHkexy+O0U7ZmqAz27HMyaGq2Wv+kLUJyolk1a6MwKq9TKUEY0/KtL/4Cdpc7f6ecB7i/WdK01qnYd29UrgHwxS6uurj2/dhMN3NrfcNUbqGllUAfU6R9wl7/GAjsnCddw1aVU6oNtNkYT2evZOheB734r4dyowjCm+VA87Us2bPaVnrFgJnH7Ujlv9zXQEILHM+aNAICvdRaj6/nny8CQcB1seBu5IA4hz9UTc4kVnuLFQHFo9OdE8ZyP9CnhHB43TmUOqEoVdK3iCs8UA3+XI2ozC8uWcVHrESS/5kVeWNWTFH9QLv2j+yWkoc12pqk4n5U+kWrvtO+b9rNyEbcItbDwta0IQMaHOFygZIcEXsGT9LL9Dt23F4qr6xVpl3xO08IxVCqnTgkkNHs5Jiit7WlTkmkl+G4mEhUkUnAqQ7/MX+yyib8PHXl2r5UTyAd21DqcNj2DkG/+W86VXGZOBTSxZVMPF4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(366004)(136003)(346002)(451199021)(9686003)(6506007)(66476007)(38100700002)(6916009)(66446008)(64756008)(186003)(86362001)(83380400001)(55016003)(33656002)(7416002)(30864003)(2906002)(8676002)(4326008)(8936002)(5660300002)(52536014)(66946007)(66556008)(76116006)(316002)(41300700001)(122000001)(7696005)(71200400001)(38070700005)(54906003)(478600001)(579004)(559001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9kA3iMa1Q+lne4jDtGwnuM8s7z5jMGBEppUfd04Ngn9RoIhwEtvwEwt7ErB0?=
 =?us-ascii?Q?VdR8uFpkSJongfAsQtmbiNk1DRD8ZOH5rC5q6Tky3ruB28rhGq+6TLCevmgG?=
 =?us-ascii?Q?QqDIR61kOF7UFmdadivDTZ9peeG8MPJpSzKfBNlujC+wOiZajAApMzqiMWXt?=
 =?us-ascii?Q?RnF4BCNWFKSMmMBsPvOYZEZJIJReDIYKkeBBszzX0m2Y6HZK8RN4p8VsBeDG?=
 =?us-ascii?Q?HHi+LtQ0A9xde103fvPJoh4gZv0e++kurGADaNvKcVgJmH2Ex8aTvHBH33nN?=
 =?us-ascii?Q?qCq3BYjzBdwXvbm+tBk2DxxY6E6CpplXL2upJ3pmQikueSexxu9RCSJhT3TU?=
 =?us-ascii?Q?T5HG9noJ6LA+ZgqXQiSVYxEMq19wXpYyIlhH0fs0xAM0asI7hq7g79WfP9Lg?=
 =?us-ascii?Q?88B5xp7EWQZhLDTMzbqL+RBcNJV+3gFdjlwQ1BELkKWQGJtsZHISlrVoR3Gq?=
 =?us-ascii?Q?3zOH3yKe58qvgZJxVh+DX0nakTJpbrq8JK8iP8biw8uuQisSDIRtviT3V7Ku?=
 =?us-ascii?Q?Kqwnx8N2J4X4tq6r5+onuKvisJVbo2kk+IkZXfIeBTAQqtraVpqfdN9aL9QQ?=
 =?us-ascii?Q?np3zg74UkxngTo4stEdHmHBo29IY4kEYiLZPQVpX2YwUCGZf0WVZY3lreOy5?=
 =?us-ascii?Q?wWTqstp7qAQ9qvfnvHmRbUQT9AwLGrkXx/RaYRqw2dpONy84tvCgUuLnwaC/?=
 =?us-ascii?Q?Utf8yyudNJ7jEPAs73uf2IfACZWtJllBqa4QXO8L0yc3S6KPyK23uZUjUgY7?=
 =?us-ascii?Q?t8roUvWrOKYtJgwHXsh8WrojKs8KWBk5fYbO/s0bdmcHFY8YoL6697h+5B1U?=
 =?us-ascii?Q?V6OZTYsakXY+B9TLBYFb1vzmq4uPL83tUjDC1xVOOwT5EeBX5KKnBywYVOI2?=
 =?us-ascii?Q?PR8uJXQXL9JNR7UYVEAWJdhHOAZrbAytk5jlDGEZ5gtCv8px8Rhxwa82DD9p?=
 =?us-ascii?Q?p7faeasII5p4wZY5wTKwftwelDjJ6PNBuzgoSkYzd9yMkNfVqxlCs9SOlYu2?=
 =?us-ascii?Q?VNJUZHQoBQM0SQ0VnSrFj9ejOXkGlGOaHDe0Q46yrM1HYUQV4LDaGzroxerg?=
 =?us-ascii?Q?4s5s0IiCbRxd2zKrpAWgd6uWTnFwGBr+mjG/7CACZkZmLfAGBpzv2EDIOwJu?=
 =?us-ascii?Q?C+NjgWyZMINIx1RHA5pX7gG1Tipck63snY4IFjgFaDj7g/WUEj2QYzwOWoB4?=
 =?us-ascii?Q?XIkcBWO5zIflGIVzq77knFde6KfSlWW/A8OjUITE+Bw8XTj9SrHYTjFmAlY7?=
 =?us-ascii?Q?ney8i3ZJIr8yy0GWDoULirzAN6nQXXSZexgCT4/hHla+5CZMJEkjs5KaxJud?=
 =?us-ascii?Q?TxTULlUlvUu0pv0Mvq+1GhjAptnXz+VZc3CNYZCmsn6/y8x91q02veuT2C34?=
 =?us-ascii?Q?YTLv9bF+e+jgJkrj8o2OHVmflRZJQcYTwfnZvyLGrOqUpAJmGrD8cvAPkR6b?=
 =?us-ascii?Q?elVnC97tzVwpVCEpeXFDSG12J1bdImrMJsdolfesunVMi38S94a7VC8iHfof?=
 =?us-ascii?Q?U5+NOu1/4GMHABKq/NtBddwQjWp7D3oc5hSYQd9/7eAVFFUMwHuiEj5LwweM?=
 =?us-ascii?Q?lV5T8nEKvShiBdyqiPNlaTdbnwx4Z794tEfB+woZEu3lcH8dQVeSYk9PCaev?=
 =?us-ascii?Q?mU7QEEzRmK1daVEaYra9iH4r6SJciYz/5ItT79jqUk+KP4zv44laDvT6gzUC?=
 =?us-ascii?Q?x+fJUw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42da5dd8-36b5-4c16-4ad1-08db67fcf6a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 08:47:17.0113
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t7oCickWdo8XTN8AQWQQ22F8BfcenW+hYFftAV41bR1qEgIKdwWfY1/pObz++cK6MELgdvgBiYFFb2GJ2ytZhY25iF2nNkm7pRaQ27HW989tvcI2hoYdrPBKQ1rtepS2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9482
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Serge,

> From: Serge Semin, Sent: Wednesday, June 7, 2023 9:16 PM
>=20
> On Wed, Jun 07, 2023 at 02:59:20AM +0000, Yoshihiro Shimoda wrote:
> > Hello Serge,
> >
> > > From: Serge Semin, Sent: Monday, June 5, 2023 11:39 PM
> > >
> > > On Wed, May 10, 2023 at 03:22:31PM +0900, Yoshihiro Shimoda wrote:
> > > > Add R-Car Gen4 PCIe Host support. This controller is based on
> > > > Synopsys DesignWare PCIe, but this controller has vendor-specific
> > > > registers so that requires initialization code like mode setting
> > > > and retraining and so on.
> > > >
> > > > To reduce code delta, adds some helper functions which are used by
> > > > both the host driver and the endpoint driver (which is added
> > > > immediately afterwards) into a separate file.
> > > >
> > > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > > ---
> > > >  drivers/pci/controller/dwc/Kconfig            |   9 +
> > > >  drivers/pci/controller/dwc/Makefile           |   2 +
> > > >  .../pci/controller/dwc/pcie-rcar-gen4-host.c  | 141 +++++++++++++
> > > >  drivers/pci/controller/dwc/pcie-rcar-gen4.c   | 190 ++++++++++++++=
++++
> > > >  drivers/pci/controller/dwc/pcie-rcar-gen4.h   |  46 +++++
> > > >  5 files changed, 388 insertions(+)
> > > >  create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4-host.=
c
> > > >  create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4.c
> > > >  create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4.h
> > > >
> > > > diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/contr=
oller/dwc/Kconfig
> > > > index ab96da43e0c2..64d4d37bc891 100644
> > > > --- a/drivers/pci/controller/dwc/Kconfig
> > > > +++ b/drivers/pci/controller/dwc/Kconfig
> > > > @@ -415,4 +415,13 @@ config PCIE_VISCONTI_HOST
> > > >  	  Say Y here if you want PCIe controller support on Toshiba Visco=
nti SoC.
> > > >  	  This driver supports TMPV7708 SoC.
> > > >
> > > > +config PCIE_RCAR_GEN4
> > > > +	tristate "Renesas R-Car Gen4 PCIe Host controller"
> > > > +	depends on ARCH_RENESAS || COMPILE_TEST
> > > > +	depends on PCI_MSI
> > > > +	select PCIE_DW_HOST
> > > > +	help
> > > > +	  Say Y here if you want PCIe host controller support on R-Car Ge=
n4 SoCs.
> > > > +	  This uses the DesignWare core.
> > > > +
> > > >  endmenu
> > > > diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/cont=
roller/dwc/Makefile
> > > > index bf5c311875a1..486cf706b53d 100644
> > > > --- a/drivers/pci/controller/dwc/Makefile
> > > > +++ b/drivers/pci/controller/dwc/Makefile
> > > > @@ -26,6 +26,8 @@ obj-$(CONFIG_PCIE_TEGRA194) +=3D pcie-tegra194.o
> > > >  obj-$(CONFIG_PCIE_UNIPHIER) +=3D pcie-uniphier.o
> > > >  obj-$(CONFIG_PCIE_UNIPHIER_EP) +=3D pcie-uniphier-ep.o
> > > >  obj-$(CONFIG_PCIE_VISCONTI_HOST) +=3D pcie-visconti.o
> > > > +pcie-rcar-gen4-host-drv-objs :=3D pcie-rcar-gen4.o pcie-rcar-gen4-=
host.o
> > > > +obj-$(CONFIG_PCIE_RCAR_GEN4) +=3D pcie-rcar-gen4-host-drv.o
> > > >
> > > >  # The following drivers are for devices that use the generic ACPI
> > > >  # pci_root.c driver but don't support standard ECAM config access.
> > > > diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4-host.c b/dri=
vers/pci/controller/dwc/pcie-rcar-gen4-host.c
> > > > new file mode 100644
> > > > index 000000000000..df7d80f1874f
> > > > --- /dev/null
> > > > +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4-host.c
> > > > @@ -0,0 +1,141 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > +/*
> > > > + * PCIe host controller driver for Renesas R-Car Gen4 Series SoCs
> > > > + * Copyright (C) 2022-2023 Renesas Electronics Corporation
> > > > + */
> > > > +
> > > > +#include <linux/delay.h>
> > > > +#include <linux/interrupt.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/of_device.h>
> > > > +#include <linux/pci.h>
> > > > +#include <linux/platform_device.h>
> > > > +
> > > > +#include "pcie-rcar-gen4.h"
> > > > +#include "pcie-designware.h"
> > > > +
> > > > +static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
> > > > +{
> > > > +	struct dw_pcie *dw =3D to_dw_pcie_from_pp(pp);
> > > > +	struct rcar_gen4_pcie *rcar =3D to_rcar_gen4_pcie(dw);
> > > > +	int ret;
> > > > +	u32 val;
> > > > +
> > > > +	gpiod_set_value_cansleep(dw->pe_rst, 1);
> > > > +
> > > > +	ret =3D rcar_gen4_pcie_set_device_type(rcar, true, dw->num_lanes)=
;
> > > > +	if (ret < 0)
> > > > +		return ret;
> > > > +
> > >
> > > > +	dw_pcie_dbi_ro_wr_en(dw);
> > >
> > > Are you sure dw_pcie_dbi_ro_wr_en() and dw_pcie_dbi_ro_wr_dis() are
> > > needed? In accordance with the DW PCIe Dual-mode HW manual the BARx
> > > registers are W-only over the DBI2 map with no need in setting the
> > > DBI_RO_WR_EN flag.
> > >
> > > Please check that on your hardware.
> >
> > You're correct. They are not needed. So, I'll drop this on v17.
> >
> > > > +
> > > > +	/*
> > > > +	 * According to the section 3.5.7.2 "RC Mode" in DWC PCIe Dual Mo=
de
> > > > +	 * Rev.5.20a, we should disable two BARs to avoid unnecessary mem=
ory
> > > > +	 * assignment during device enumeration.
> > > > +	 */
> > > > +	dw_pcie_writel_dbi2(dw, PCI_BASE_ADDRESS_0, 0x0);
> > > > +	dw_pcie_writel_dbi2(dw, PCI_BASE_ADDRESS_1, 0x0);
> > > > +
> > >
> > > > +	dw_pcie_dbi_ro_wr_dis(dw);
> > >
> > > ditto
> >
> > I'll drop this too.
> >
> > > > +
> > > > +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> > > > +		/* Enable MSI interrupt signal */
> > > > +		val =3D readl(rcar->base + PCIEINTSTS0EN);
> > > > +		val |=3D MSI_CTRL_INT;
> > > > +		writel(val, rcar->base + PCIEINTSTS0EN);
> > > > +	}
> > > > +
> > > > +	msleep(100);	/* pe_rst requires 100msec delay */
> > > > +
> > > > +	gpiod_set_value_cansleep(dw->pe_rst, 0);
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static const struct dw_pcie_host_ops rcar_gen4_pcie_host_ops =3D {
> > > > +	.host_init =3D rcar_gen4_pcie_host_init,
> > > > +};
> > > > +
> > > > +static int rcar_gen4_add_dw_pcie_rp(struct rcar_gen4_pcie *rcar,
> > > > +				   struct platform_device *pdev)
> > > > +{
> > > > +	struct dw_pcie *dw =3D &rcar->dw;
> > > > +	struct dw_pcie_rp *pp =3D &dw->pp;
> > > > +
> > > > +	pp->num_vectors =3D MAX_MSI_IRQS;
> > > > +	pp->ops =3D &rcar_gen4_pcie_host_ops;
> > > > +	dw_pcie_cap_set(dw, REQ_RES);
> > > > +
> > > > +	return dw_pcie_host_init(pp);
> > > > +}
> > > > +
> > > > +static void rcar_gen4_remove_dw_pcie_rp(struct rcar_gen4_pcie *rca=
r)
> > > > +{
> > > > +	dw_pcie_host_deinit(&rcar->dw.pp);
> > > > +	gpiod_set_value_cansleep(rcar->dw.pe_rst, 1);
> > > > +}
> > > > +
> > > > +static int rcar_gen4_pcie_probe(struct platform_device *pdev)
> > > > +{
> > > > +	struct device *dev =3D &pdev->dev;
> > > > +	struct rcar_gen4_pcie *rcar;
> > > > +	int err;
> > > > +
> > > > +	rcar =3D rcar_gen4_pcie_devm_alloc(dev);
> > > > +	if (!rcar)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	err =3D rcar_gen4_pcie_get_resources(rcar, pdev);
> > > > +	if (err < 0) {
> > > > +		dev_err(dev, "Failed to request resource: %d\n", err);
> > > > +		return err;
> > > > +	}
> > > > +
> > > > +	platform_set_drvdata(pdev, rcar);
> > > > +
> > > > +	err =3D rcar_gen4_pcie_prepare(rcar);
> > > > +	if (err < 0)
> > > > +		return err;
> > > > +
> > > > +	rcar->needs_retrain =3D true;
> > > > +	err =3D rcar_gen4_add_dw_pcie_rp(rcar, pdev);
> > > > +	if (err < 0)
> > > > +		goto err_add;
> > > > +
> > > > +	return 0;
> > > > +
> > > > +err_add:
> > > > +	rcar_gen4_pcie_unprepare(rcar);
> > > > +
> > > > +	return err;
> > > > +}
> > > > +
> > > > +static int rcar_gen4_pcie_remove(struct platform_device *pdev)
> > > > +{
> > > > +	struct rcar_gen4_pcie *rcar =3D platform_get_drvdata(pdev);
> > > > +
> > > > +	rcar_gen4_remove_dw_pcie_rp(rcar);
> > > > +	rcar_gen4_pcie_unprepare(rcar);
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static const struct of_device_id rcar_gen4_pcie_of_match[] =3D {
> > > > +	{ .compatible =3D "renesas,rcar-gen4-pcie", },
> > > > +	{},
> > > > +};
> > > > +
> > > > +static struct platform_driver rcar_gen4_pcie_driver =3D {
> > > > +	.driver =3D {
> > > > +		.name =3D "pcie-rcar-gen4",
> > > > +		.of_match_table =3D rcar_gen4_pcie_of_match,
> > > > +		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> > > > +	},
> > > > +	.probe =3D rcar_gen4_pcie_probe,
> > > > +	.remove =3D rcar_gen4_pcie_remove,
> > > > +};
> > > > +module_platform_driver(rcar_gen4_pcie_driver);
> > > > +
> > > > +MODULE_DESCRIPTION("Renesas R-Car Gen4 PCIe host controller driver=
");
> > > > +MODULE_LICENSE("GPL");
> > > > diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/=
pci/controller/dwc/pcie-rcar-gen4.c
> > > > new file mode 100644
> > > > index 000000000000..35923fda8ed5
> > > > --- /dev/null
> > > > +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> > > > @@ -0,0 +1,190 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > +/*
> > > > + * PCIe host/endpoint controller driver for Renesas R-Car Gen4 Ser=
ies SoCs
> > > > + * Copyright (C) 2022-2023 Renesas Electronics Corporation
> > > > + */
> > > > +
> > > > +#include <linux/delay.h>
> > > > +#include <linux/io.h>
> > > > +#include <linux/of_device.h>
> > > > +#include <linux/pci.h>
> > > > +#include <linux/pm_runtime.h>
> > > > +#include <linux/reset.h>
> > > > +
> > > > +#include "pcie-rcar-gen4.h"
> > > > +#include "pcie-designware.h"
> > > > +
> > > > +/* Renesas-specific */
> > > > +#define PCIERSTCTRL1		0x0014
> > > > +#define  APP_HOLD_PHY_RST	BIT(16)
> > > > +#define  APP_LTSSM_ENABLE	BIT(0)
> > > > +
> > > > +#define RETRAIN_MAX_CHECK	10
> > > > +#define RETRAIN_MAX_RETRIES	10
> > > > +
> > > > +static void rcar_gen4_pcie_ltssm_enable(struct rcar_gen4_pcie *rca=
r,
> > > > +					bool enable)
> > > > +{
> > > > +	u32 val;
> > > > +
> > > > +	val =3D readl(rcar->base + PCIERSTCTRL1);
> > > > +	if (enable) {
> > > > +		val |=3D APP_LTSSM_ENABLE;
> > >
> > > > +		val &=3D ~APP_HOLD_PHY_RST;
> > >
> > > What about moving the APP_HOLD_PHY_RST de-assertion to the
> > > rcar_gen4_pcie_set_device_type() method? In accordance with the
> > > "3.1 Initialization" chapter it's supposed to be done before
> > > performing the DBI programming and activating the link training.
> >
>=20
> > IIUC, the "3.1 Initialization" said app_hold_phy_rst =3D 1 before
> > performing the DBI programming. So, it is assertion. Also, the SoC
> > documentation described the initializing procedure as the follows:
> >  app_ltssm_enable =3D 1
> >  app_hold_phy_rst =3D 0
> > So, I would like to keep them in the function.
>=20
> Indeed. I was wrong. Sorry for the misleading comment.

No problem. Thank you for the confirmation!

> >
> > > > +	} else {
> > > > +		val &=3D ~APP_LTSSM_ENABLE;
> > > > +		val |=3D APP_HOLD_PHY_RST;
> > > > +	}
> > > > +	writel(val, rcar->base + PCIERSTCTRL1);
> > > > +}
> > > > +
> > > > +static bool rcar_gen4_pcie_check_retrain_link(struct dw_pcie *dw)
> > > > +{
> > > > +	u8 offset =3D dw_pcie_find_capability(dw, PCI_CAP_ID_EXP);
> > > > +	u32 lnkcap =3D dw_pcie_readl_dbi(dw, offset + PCI_EXP_LNKCAP);
> > > > +	u32 lnkctl =3D dw_pcie_readl_dbi(dw, offset + PCI_EXP_LNKCTL);
> > > > +	u16 lnksta =3D dw_pcie_readw_dbi(dw, offset + PCI_EXP_LNKSTA);
> > > > +	int i;
> > > > +
> > >
> > > > +	if ((lnksta & PCI_EXP_LNKSTA_CLS) =3D=3D (lnkcap & PCI_EXP_LNKCAP=
_SLS))
> > > > +		return true;
> > > > +
> > > > +	lnkctl |=3D PCI_EXP_LNKCTL_RL;
> > > > +	dw_pcie_writel_dbi(dw, offset + PCI_EXP_LNKCTL, lnkctl);
> > > > +
> > > > +	for (i =3D 0; i < RETRAIN_MAX_CHECK; i++) {
> > > > +		lnksta =3D dw_pcie_readw_dbi(dw, offset + PCI_EXP_LNKSTA);
> > > > +		if (lnksta & PCI_EXP_LNKSTA_LT)
> > > > +			return true;
> > > > +		usleep_range(1000, 1100);
> > > > +	}
> > >
> > > I'll ask one more time because you didn't respond to my previous note
> > > about this.
> >
> > I'm sorry. I completely overlooked the previous note.
> >
> > > Are you sure that this is needed? Did you try
> > > the approach described in "3.13 Gen2/3/4/5 Speed Modes" with
> > > de-asserting/asserting the GEN2_CTRL_OFF.DIRECT_SPEED_CHANGE flag?
> >
> > I tried this setting, but it doesn't work. I'll investigate this settin=
g more.
> >
> > > I keep asking because the same problem we used to have on our hardwar=
e
> > > until we found out that the DIRECT_SPEED_CHANGE flag helped to train
> > > the link right to the speed specified in the capabilities.
> > >
> > > So here is what presumably you'll need to do (based on the
> > > "3.1 Initialization" and "3.13 Gen2/3/4/5 Speed Modes" chapters of
> > > the DW PCIe DM hw-manual):
> > > 1. Make sure the controller is in the power-down/reset state.
> > > 2. Select device_type (EP or RP).
> > > 3. De-assert the controller reset.
> > > 4. Clear PHY-reset flag in the app registers.
> > > 5. Perform some controller initializations.
> > > 6. Enable LTSSM to start link training.
> > > 7. Set GEN2_CTRL_OFF.DIRECT_SPEED_CHANGE flag one more time.
> > >
> > > 1-4 are supposed to be done in rcar_gen4_pcie_host_init().
> > > 5 is performed in the framework of the DW PCIe core driver.
> > > 6-7 should be done in rcar_gen4_pcie_start_link().
> > >
> > > Note 1. GEN2_CTRL_OFF.DIRECT_SPEED_CHANGE flag is already set on stag=
e
> > > 5 in the framework of the dw_pcie_setup_rc() method. But in our case
> > > it only caused having the Gen.2 link speed. Adding stage 7 helped to
> > > get stable Gen.3 link. So please try the denoted approach. If it work=
s
> > > what about adding stage 7 twice in order to get Gen.4 speed?
> > > (waiting for the DIRECT_SPEED_CHANGE flag being auto-cleared and then
> > > set it up again?)
> > >
> > > Note 2. GEN2_CTRL_OFF.DIRECT_SPEED_CHANGE flag is defined as
> > > PCIE_LINK_WIDTH_SPEED_CONTROL.PORT_LOGIC_SPEED_CHANGE macros in the D=
W
> > > PCIe core driver.
> > >
> > > Note 3. If what is suggested above works well then you won't need to
> > > have the heavy rcar_gen4_pcie_check_retrain_link() method in the way
> > > you have it defined.
> >
> > Thank you very much for your comments!
>=20
> Please see the GEN2_CTRL_OFF.DIRECT_SPEED_CHANGE description for details
> of how the flag is supposed to be de-asserted and asserted in order to
> initiate the direct speed change.

After I modified the start_link() like below, it also works. Is the code
acceptable? (Sorry all tabs are replaced to spaces...)
---------------------------------------------------------------------------=
-
static bool rcar_gen4_pcie_check_current_link(struct dw_pcie *dw)
{
        u8 offset =3D dw_pcie_find_capability(dw, PCI_CAP_ID_EXP);
        u32 lnkcap =3D dw_pcie_readl_dbi(dw, offset + PCI_EXP_LNKCAP);
        u16 lnksta =3D dw_pcie_readw_dbi(dw, offset + PCI_EXP_LNKSTA);

        if ((lnksta & PCI_EXP_LNKSTA_CLS) =3D=3D (lnkcap & PCI_EXP_LNKCAP_S=
LS))
                return true;

        return false;
}

static void rcar_gen4_pcie_speed_change(struct dw_pcie *dw)
{
        u32 val;

        val =3D dw_pcie_readl_dbi(dw, PCIE_LINK_WIDTH_SPEED_CONTROL);
        val &=3D ~PORT_LOGIC_SPEED_CHANGE;
        dw_pcie_writel_dbi(dw, PCIE_LINK_WIDTH_SPEED_CONTROL, val);

        val =3D dw_pcie_readl_dbi(dw, PCIE_LINK_WIDTH_SPEED_CONTROL);
        val |=3D PORT_LOGIC_SPEED_CHANGE;
        dw_pcie_writel_dbi(dw, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
}

static int rcar_gen4_pcie_start_link(struct dw_pcie *dw)
{
        struct rcar_gen4_pcie *rcar =3D to_rcar_gen4_pcie(dw);
        int i;

        rcar_gen4_pcie_ltssm_enable(rcar, true);

        /*
         * Require direct speed change here. Otherwise RDLH_LINK_UP of
         * PCIEINTSTS0 which is this controller specific register may not
         * be set.
         */
        if (rcar->needs_speed_change) {
                for (i =3D 0; i < SPEED_CHANGE_MAX_RETRIES; i++) {
                        rcar_gen4_pcie_speed_change(dw);
                        msleep(100);
                        if (rcar_gen4_pcie_check_current_link(dw))
                                return 0;
                }

                return -ETIMEDOUT;      /* Failed */
        }
------------------------------------------------------------------

> >
> > > > +
> > > > +	return false;
> > > > +}
> > > > +
> > > > +static int rcar_gen4_pcie_link_up(struct dw_pcie *dw)
> > > > +{
> > > > +	struct rcar_gen4_pcie *rcar =3D to_rcar_gen4_pcie(dw);
> > > > +	u32 val, mask;
> > > > +
> > > > +	val =3D readl(rcar->base + PCIEINTSTS0);
> > > > +	mask =3D RDLH_LINK_UP | SMLH_LINK_UP;
> > > > +
> > > > +	return (val & mask) =3D=3D mask;
> > > > +}
> > > > +
> > > > +static int rcar_gen4_pcie_start_link(struct dw_pcie *dw)
> > > > +{
> > > > +	struct rcar_gen4_pcie *rcar =3D to_rcar_gen4_pcie(dw);
> > > > +	int i;
> > > > +
> > > > +	rcar_gen4_pcie_ltssm_enable(rcar, true);
> > > > +
> > > > +	/*
> > > > +	 * Require retraining here. Otherwise RDLH_LINK_UP of PCIEINTSTS0=
 which
> > > > +	 * is this controller specific register may not be set.
> > > > +	 */
> > > > +	if (rcar->needs_retrain) {
> > > > +		for (i =3D 0; i < RETRAIN_MAX_RETRIES; i++) {
> > > > +			if (rcar_gen4_pcie_check_retrain_link(dw))
> > > > +				return 0;
> > > > +			msleep(100);
> > > > +		}
> > > > +
> > > > +		return -ETIMEDOUT;	/* Failed */
> > > > +	}
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static void rcar_gen4_pcie_stop_link(struct dw_pcie *dw)
> > > > +{
> > > > +	struct rcar_gen4_pcie *rcar =3D to_rcar_gen4_pcie(dw);
> > > > +
> > > > +	rcar_gen4_pcie_ltssm_enable(rcar, false);
> > > > +}
> > > > +
> > >
> > > > +int rcar_gen4_pcie_set_device_type(struct rcar_gen4_pcie *rcar, bo=
ol rc,
> > > > +				   int num_lanes)
> > >
> > > 1. Number of lanes is already defined in the rcar_gen4_pcie.dw.num_la=
nes field.
> > > What about using it from there instead of passing it as an argument?
> > > 2. DW PCIe core driver has a very handy enum defined:
> > > dw_pcie_device_mode. It describes the controller modes (End-point,
> > > Root port, etc). What about adding the mode field right to the
> > > rcar_gen4_pcie structure and initializing it in someplace in probe() =
?
> > > 3. Based on the function semantic it's better to be named as somethin=
g
> > > like rcar_gen4_pcie_init_device() or even rcar_gen4_pcie_basic_init()=
.
> >
> > Thank you for your comments! I'll modify the function.
> >
> > >
> > > > +{
> > > > +	u32 val;
> > > > +
> > >
> > > > +	/* Note: Assume the rcar->rst which is Cold-reset is asserted her=
e */
> > >
> > > What about directly asserting it here then? In accordance with the DW
> > > PCIe DM manual the "device_type" input must be set before the DM
> > > controller is powered up (basically un-reset). What if the controller
> > > reset is already de-asserted, but you are going to changes its mode?
> > > In that case the mode won't be changed and you'll end up with
> > > unpredictable results.
> >
> > Thank you for your comment. We should add asserting it here as you ment=
ioned.
> >
> > > > +	val =3D readl(rcar->base + PCIEMSR0);
> > > > +	if (rc)
> > > > +		val |=3D DEVICE_TYPE_RC;
> > > > +	else
> > > > +		val |=3D DEVICE_TYPE_EP;
> > > > +
> > > > +	if (num_lanes < 4)
> > > > +		val |=3D BIFUR_MOD_SET_ON;
> > > > +
> > > > +	writel(val, rcar->base + PCIEMSR0);
> > > > +
> > > > +	return reset_control_deassert(rcar->rst);
> > > > +}
> > > > +
> > > > +int rcar_gen4_pcie_prepare(struct rcar_gen4_pcie *rcar)
> > > > +{
> > > > +	struct device *dev =3D rcar->dw.dev;
> > > > +	int err;
> > > > +
> > > > +	pm_runtime_enable(dev);
> > > > +	err =3D pm_runtime_resume_and_get(dev);
> > > > +	if (err < 0) {
> > > > +		dev_err(dev, "Failed to resume/get Runtime PM\n");
> > > > +		pm_runtime_disable(dev);
> > > > +	}
> > > > +
> > > > +	return err;
> > > > +}
> > > > +
> > > > +void rcar_gen4_pcie_unprepare(struct rcar_gen4_pcie *rcar)
> > > > +{
> > > > +	struct device *dev =3D rcar->dw.dev;
> > > > +
> > > > +	if (!reset_control_status(rcar->rst))
> > > > +		reset_control_assert(rcar->rst);
> > > > +	pm_runtime_put(dev);
> > > > +	pm_runtime_disable(dev);
> > > > +}
> > > > +
> > > > +int rcar_gen4_pcie_get_resources(struct rcar_gen4_pcie *rcar,
> > > > +				 struct platform_device *pdev)
> > > > +{
> > > > +	struct device *dev =3D rcar->dw.dev;
> > > > +
> > > > +	/* Renesas-specific registers */
> > > > +	rcar->base =3D devm_platform_ioremap_resource_byname(pdev, "app")=
;
> > > > +	if (IS_ERR(rcar->base))
> > > > +		return PTR_ERR(rcar->base);
> > > > +
> > >
> > > > +	rcar->rst =3D devm_reset_control_get(dev, NULL);
> > > > +	if (IS_ERR(rcar->rst)) {
> > > > +		dev_err(dev, "Failed to get Cold-reset\n");
> > >
> > > So AFAICS your platform is equipped with the DWC_pcie_clkrst.v module=
.
> > > Thus all the resets are appropriately cleared by a single flag:
> > > power_up_rst_n. What about using the named reset in this case with th=
e
> > > "pwr" name? Thus you'll be able to drop the manual
> > > devm_reset_control_get() invocation and instead use the reset-resourc=
es
> > > requested in the framework of the generic dw_pcie_get_resources()
> > > method? Note you'll need to move the dw_pcie_cap_set(dw, REQ_RES);
> > > statement to rcar_gen4_pcie_devm_alloc() then and drop the
> > > rcar_gen4_pcie.rst field afterwords.
> >
> > Thank you for your suggestion! Using "pwr" can work on my environment.
> >
> > > By the way I don't see you requesting and enabling the reference
> > > clock in your driver but the bindings imply the clock source. How
> > > come?
> >
>=20
> > For now, I used gpio-hog to enable the reference clock. But, it seem
> > I should use "ref" clock for it. So, I'll fix it too.
>=20
> Not sure what gpio-hog you are talking about. Do you mean the pe_rst
> signal or some another gpio? I failed to see of how pe_rst is
> connected to the clock source. In anyway directly handling the clock
> source would be more portable choice.

Sorry for lacking information. I described a gpio node like below
and then the gpio will be high automatically, and the reference clock
will be output. But, this is completely independent from pci.
---
&gpio2 {
        pci-clkreq0-hog {
                gpio-hog;
                gpios =3D <15 GPIO_ACTIVE_LOW>;
                output-high;
        };
};
---

Now I could implement the clock handling by using "gpio-gate-clock".
So, I'll drop the gpio-hog for the reference clock.

Best regards,
Yoshihiro Shimoda

> -Serge(y)
>=20
> >
> > > > +		return PTR_ERR(rcar->rst);
> > > > +	}
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static const struct dw_pcie_ops dw_pcie_ops =3D {
> > > > +	.start_link =3D rcar_gen4_pcie_start_link,
> > > > +	.stop_link =3D rcar_gen4_pcie_stop_link,
> > > > +	.link_up =3D rcar_gen4_pcie_link_up,
> > > > +};
> > > > +
> > > > +struct rcar_gen4_pcie *rcar_gen4_pcie_devm_alloc(struct device *de=
v)
> > > > +{
> > > > +	struct rcar_gen4_pcie *rcar;
> > > > +
> > > > +	rcar =3D devm_kzalloc(dev, sizeof(*rcar), GFP_KERNEL);
> > > > +	if (!rcar)
> > > > +		return NULL;
> > > > +
> > > > +	rcar->dw.dev =3D dev;
> > > > +	rcar->dw.ops =3D &dw_pcie_ops;
> > > > +	dw_pcie_cap_set(&rcar->dw, EDMA_UNROLL);
> > > > +
> > > > +	return rcar;
> > > > +}
> > > > diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.h b/drivers/=
pci/controller/dwc/pcie-rcar-gen4.h
> > > > new file mode 100644
> > > > index 000000000000..fec3f18609f4
> > > > --- /dev/null
> > > > +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.h
> > > > @@ -0,0 +1,46 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0-only */
> > > > +/*
> > > > + * PCIe host/endpoint controller driver for Renesas R-Car Gen4 Ser=
ies SoCs
> > > > + * Copyright (C) 2022-2023 Renesas Electronics Corporation
> > > > + */
> > > > +
> > > > +#ifndef _PCIE_RCAR_GEN4_H_
> > > > +#define _PCIE_RCAR_GEN4_H_
> > > > +
> > > > +#include <linux/io.h>
> > > > +#include <linux/pci.h>
> > > > +#include <linux/reset.h>
> > > > +
> > > > +#include "pcie-designware.h"
> > > > +
> > > > +/* Renesas-specific */
> > > > +#define PCIEMSR0		0x0000
> > > > +#define  BIFUR_MOD_SET_ON	BIT(0)
> > > > +#define  DEVICE_TYPE_EP		0
> > > > +#define  DEVICE_TYPE_RC		BIT(4)
> > > > +
> > > > +#define PCIEINTSTS0		0x0084
> > > > +#define PCIEINTSTS0EN		0x0310
> > > > +#define  MSI_CTRL_INT		BIT(26)
> > > > +#define  SMLH_LINK_UP		BIT(7)
> > > > +#define  RDLH_LINK_UP		BIT(6)
> > > > +#define PCIEDMAINTSTSEN		0x0314
> > > > +#define  PCIEDMAINTSTSEN_INIT	GENMASK(15, 0)
> > > > +
> > >
> > > > +struct rcar_gen4_pcie {
> > >
> > > As I mentioned above this structure can be extended with the enum
> > > dw_pcie_device_mode field thus dropping the boolean argument from the
> > > rcar_gen4_pcie_set_device_type() method.
> >
> > I got it. I'll fix this.
> >
> > > > +	struct dw_pcie		dw;
> > >
> > > As I already mentioned above the dw.num_lanes could be used instead o=
f
> > > passing it as the rcar_gen4_pcie_set_device_type() argument.
> >
> > I'll fix this too.
> >
> > Best regards,
> > Yoshihiro Shimoda
> >
> > > -Serge(y)
> > >
> > > > +	void __iomem		*base;
> > > > +	struct reset_control	*rst;
> > > > +	bool			needs_retrain;
> > > > +};
> > > > +#define to_rcar_gen4_pcie(x)	dev_get_drvdata((x)->dev)
> > > > +
> > > > +int rcar_gen4_pcie_set_device_type(struct rcar_gen4_pcie *rcar, bo=
ol rc,
> > > > +				   int num_lanes);
> > > > +int rcar_gen4_pcie_prepare(struct rcar_gen4_pcie *pcie);
> > > > +void rcar_gen4_pcie_unprepare(struct rcar_gen4_pcie *pcie);
> > > > +int rcar_gen4_pcie_get_resources(struct rcar_gen4_pcie *rcar,
> > > > +				 struct platform_device *pdev);
> > > > +struct rcar_gen4_pcie *rcar_gen4_pcie_devm_alloc(struct device *de=
v);
> > > > +
> > > > +#endif /* _PCIE_RCAR_GEN4_H_ */
> > > > --
> > > > 2.25.1
> > > >
