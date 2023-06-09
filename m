Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5768728FF1
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jun 2023 08:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237720AbjFIG34 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Jun 2023 02:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238015AbjFIG3s (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Jun 2023 02:29:48 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2109.outbound.protection.outlook.com [40.107.114.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1771FE6;
        Thu,  8 Jun 2023 23:29:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yk61sMoK4nw78NWQ4vlCn6Al7x8sSW8Wadh2eO4u7WbL4K4Pznn9bojsPVOwPSfWYX6+rrYZEsBo0EkreqXgw3NtDLL/IwJg5aH7hOG+O0kGW0ViW64IBg+ygMvV2QdhKxSw9RPZXJhO4xjD/Hgz5JLa3NmLRxKuR/5Ayhb6DenMKsST9tCEEDul+K1kRE8SKiBjaQAYs/85Wm9JB0WwUMsAsnbCjlVys5AYDLaMCWAQOjXfRVIo7oSIqATp4snBwaOt8ikMGlZqWX+x4ioQ9GDnJaM0z4B3GcE7d2tFzIR+ZjPv9vzgAQ29uMKDYywcD52B4p+m+TrCRvMyG1RcPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9NaSnwFv2fsF8IU/m25L5F6twHUS+4rqm0Mgvi+BD8Y=;
 b=ilnjEYiE7wzzGo0MQJXaKFBbde6yfyAPu4nZAxQUbLSyT5X7QGtCD18GZEq50bdUoaOimGhvJUcfdXaIKHN7QC1tMEzTzGNQBWUyI7FZPhcNOdbNAjpVrHQ5hd08PhKpomJBVyT4DelSfW+c0MARC0N4vpqh3AxlzuquXtvHSYdgh7UQhKv5i4Xrw5MixOdZ9MgcQilmChndR78ovF9gMfIqkTT6ReDF+YdvTCZj6PVVhJpd42x3SpyN2v04RSRS8+dI32V5RFKQYGpj7SZ6nVeNSCRR1mpuxBi2F2Cu/tihdUIHAd7NPaL5PtjyO3STrxLG5vNtm4TKdo5aD0lhlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NaSnwFv2fsF8IU/m25L5F6twHUS+4rqm0Mgvi+BD8Y=;
 b=JDkOtKuuvytku8SqwPcSao8Of9X2Ud0H0uJVUpBq9HJbHpag3AyaK96eg5PXM5eDBM3hzTQXg6P1F9kv8IvwMIL7fM/F5p0lzinZ6T3UO9ldTJF1tSsCo0rTnUwFLF5QWojfGCZZs1IJXfJSEAT1njT5x7RFCXNyCJS/8VT//6Y=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYCPR01MB7798.jpnprd01.prod.outlook.com
 (2603:1096:400:180::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Fri, 9 Jun
 2023 06:29:40 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::711d:f870:2e08:b6e1]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::711d:f870:2e08:b6e1%3]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 06:29:39 +0000
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
Thread-Index: AQHZgwfSD1pv8+kZFEalYK7OljPo8698cOgAgAEOU0CAAe45gIABPKpggABUd4CAANbBAA==
Date:   Fri, 9 Jun 2023 06:29:39 +0000
Message-ID: <TYBPR01MB5341AD39983D6B39034AF01BD851A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230510062234.201499-1-yoshihiro.shimoda.uh@renesas.com>
 <20230510062234.201499-20-yoshihiro.shimoda.uh@renesas.com>
 <20230605143908.fcgqzedp7oiarbyu@mobilestation>
 <TYBPR01MB5341A67CF6DFFCB396F13195D853A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <20230607121533.cxvidvdqat5h2tqu@mobilestation>
 <TYBPR01MB53417E55F5F9E667D679901CD850A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <20230608121115.qnilmougdfd6fdyq@mobilestation>
In-Reply-To: <20230608121115.qnilmougdfd6fdyq@mobilestation>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYCPR01MB7798:EE_
x-ms-office365-filtering-correlation-id: 03c0e0b9-894d-4dcd-f534-08db68b2e760
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g/3nV3NlEpyx6eohb+fZuf7xYZqFpoQ022uiCywWrxaFm63tsvd3oJYYJsqVteESDte35wgdWusD9rVoaIl+EvCGM0hBC6FdlKjyAbVSC+SwboktE5xkF2+H/6iXZS+Lw08eoyqNdC0kZFL7DnEt0a6OZ+PhzAbUJdajtdzpLlGRMvcSjrMUrABzlPLi6Ph3osMxJDHCt97STfsRllGcDHYccb6876e86gkHkR+cWlh6ZHo9jWZDXJ8mLHB9z8HMgvpqTE74W1HfiKQib40tPr0suqRa7yZWtab/ghg+Si+noPFOJb0EeZhcuszo1qWSonyCwK3CzFMicay4IBgW6oFiPBXz6SmXI15SoaZgz8ZPzXYq5LQ2R5ibQTVW6SYHqOK6v3KVj9Jb2ta8SbYwgTlyk8YfBMAJmfxS7ai9d77niwgamsBJz7WHUdqCuM31ZwwtRd9UJ8uLifbXozDJJqPPPhQPisazxVmVcmd/arViQyGqlFIL72jxxoBCUmLMKINGKm0ykzkcVS7ywvH2u3vs8nekvCHBu4D2SXSLosP3cMDG2rPL2qaoO2s9WldsJzo2TWwCyR4hiLn11HdXTUSoLXuWqZ3/CmLnlB5mYDRtkViz1PVCITtmzozOL0EQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(346002)(39860400002)(366004)(451199021)(2906002)(38070700005)(30864003)(33656002)(86362001)(52536014)(7416002)(5660300002)(55016003)(83380400001)(7696005)(71200400001)(9686003)(186003)(6506007)(478600001)(54906003)(66446008)(66476007)(76116006)(4326008)(122000001)(66556008)(66946007)(38100700002)(316002)(41300700001)(8936002)(64756008)(8676002)(6916009)(579004)(559001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MUr269xBAiSGfWmqMBIM5mKYbdd3a7dsnlPOB5QWsGwpLk+B74N3IJpXYzG9?=
 =?us-ascii?Q?ys+acm22nNxeb2EU5ROTFzIOFZ2jgSG79IVGnaOQIRo+AU4W8+q587pVrdOR?=
 =?us-ascii?Q?XqYmx4lmUo12ELlF3B7BsBylZdewaZw8DoR0hJf4hl1NMTmthfHFNNwjBSFa?=
 =?us-ascii?Q?fkVlo9Jr6ZG7KPjpMKfeaJ27c0KtO3jlUZwTPar9R4FiNy3dNjrw2VwSjJc8?=
 =?us-ascii?Q?5b+CsUeOQFDv7jGIDLTqtBVhNZL6yPZ+YUiiYIUC7taNVUH91cXPHT2Zdxn8?=
 =?us-ascii?Q?LMkNFVe+6Q+ckg9MuFUXX+c8TtJ8tZ1axHh2ipzhBKojKsAJy7j+fmitMLQ6?=
 =?us-ascii?Q?IjfS2e9CBk/JRrRJcevPvfeoPMrKPbzaN36gNkDHh4bE6BFdr/ooNMqtmfes?=
 =?us-ascii?Q?PKQRuz23TnXuM7VGOEhXDjYp1GYOZJR9VctaEIAbAMhk4mrIGXSqfmozukoG?=
 =?us-ascii?Q?JylZBxv/yWLyJHzZA7Bwc1GBBgr8IoRuIzRp1RSsQKRXoIU9vI9fc1cm98un?=
 =?us-ascii?Q?Glc+FcNdugSymrC3tTP9rlAjCMbD/9Lg+DXHzvfnytBn0DD57AlE2469k2Dx?=
 =?us-ascii?Q?tfbe6qwz0k4+7L149uo8KowchDf27awCV8rsg/pjDr8EuVB70dSpyGKzGtet?=
 =?us-ascii?Q?+pczyWq8VdDXCNfu2PzwhQO99ERC8AUHglpN72vvUjpnGgD8CwKt0+noT6CG?=
 =?us-ascii?Q?UwuKaB1rS9o+0kJnyQHr9DPo7UIupdHMByXq7USYBF70w0+hdybYqBkykPuD?=
 =?us-ascii?Q?RA1AYPiTDK157KXlgEz6TNqycYXeaHFNt+TgG8+QZ44bAu+TP1EMKmtsz687?=
 =?us-ascii?Q?MToK22QoniVL5I7WBrkG1f9Tjru9kARHSd4EUTtfBPAbimm+oqQeagbH7uhM?=
 =?us-ascii?Q?3Nd8HF5QyXFzDwJ/jVc7AzvXgp9j9kidADaOoiVKNEJd3FpHH4FKPDC+ig53?=
 =?us-ascii?Q?imENx8r5RXboOoyC7KwoQIcSfNohv4AigHxxNSVRLwYljkuqEXdJ4dkC2z3A?=
 =?us-ascii?Q?o4uhNZMybqRR/s6qr2SsgW7fIettYJEBdlcS2wws+my2Kwxqvs9xB6OQYR33?=
 =?us-ascii?Q?12ZCREhxR1J6RVoygs5GKHY2FD20Vea4/s7aHHOFtJzf4YkCARRTQqEu4+Yh?=
 =?us-ascii?Q?P9jvJwRgcE/d7A+eq6KqHWMcO7mjfZ51H4sLBKyKI+ahXS9K41vO5u41toPO?=
 =?us-ascii?Q?SyDI6r46/pyDwCjjdh7/qxVU0FDCGka6V24vntQpdsHm2SClGmuog65SRnn9?=
 =?us-ascii?Q?T8nJcLRY/Bz5XgADNJaPa4jwlt92fHgiIg26CTGp+hRYS8DFjEeGt7WeFZ25?=
 =?us-ascii?Q?ptd6VMOziCXpve9b0AoZMAskpJeQWWdKrDd/TkviOCBilmvLjDFzWJrpHrx7?=
 =?us-ascii?Q?mdwhJKEtDwKt2lBhGDWkVY5UWAz+2EVoJDcRzkN9bS6Cdkf+FyIvJY9eLBhm?=
 =?us-ascii?Q?9FSmhwbttEHiQSITlSDUwFpfOrC07ZVY30VHcF5RfTA50TYrC0R3vV2brtrc?=
 =?us-ascii?Q?CYPSCAjyCaiHPbyBLFezl/eVkEDd/iJ/jGCviry0ZQfsT6EqT1DEU5gfJRvN?=
 =?us-ascii?Q?LDvGzDJunXLLF31Et46FP7n4xO0fEMoK+E+kuZSpMJJJmbCuo/b6f3BjZ6mU?=
 =?us-ascii?Q?s5xgoIYiXBqwpcGbYsOKGnOVBeutDVNTsuUS/l4woRaZchMup8cexglernC2?=
 =?us-ascii?Q?17LQmg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03c0e0b9-894d-4dcd-f534-08db68b2e760
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2023 06:29:39.8098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GP8ndZW8sytbVkZz10MvGfN+OMzVfHwS1mGTHOv8BtGtFSBsy+A8rHne3Vs9Uv4SijhS0ha5PJjnuSLA0PS69HSogomA9kF5M17yH7FCOM7y3eaEvHYXNbxmWp0lYqzN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7798
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Serge,

> From: Serge Semin, Sent: Thursday, June 8, 2023 9:11 PM
>=20
> On Thu, Jun 08, 2023 at 08:47:16AM +0000, Yoshihiro Shimoda wrote:
> > Hello Serge,
> >
> > > From: Serge Semin, Sent: Wednesday, June 7, 2023 9:16 PM
> > >
> > > On Wed, Jun 07, 2023 at 02:59:20AM +0000, Yoshihiro Shimoda wrote:
> > > > Hello Serge,
> > > >
> > > > > From: Serge Semin, Sent: Monday, June 5, 2023 11:39 PM
> > > > >
> > > > > On Wed, May 10, 2023 at 03:22:31PM +0900, Yoshihiro Shimoda wrote=
:
> > > > > > Add R-Car Gen4 PCIe Host support. This controller is based on
> > > > > > Synopsys DesignWare PCIe, but this controller has vendor-specif=
ic
> > > > > > registers so that requires initialization code like mode settin=
g
> > > > > > and retraining and so on.
> > > > > >
> > > > > > To reduce code delta, adds some helper functions which are used=
 by
> > > > > > both the host driver and the endpoint driver (which is added
> > > > > > immediately afterwards) into a separate file.
> > > > > >
> > > > > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.=
com>
> > > > > > ---
> > > > > >  drivers/pci/controller/dwc/Kconfig            |   9 +
> > > > > >  drivers/pci/controller/dwc/Makefile           |   2 +
> > > > > >  .../pci/controller/dwc/pcie-rcar-gen4-host.c  | 141 ++++++++++=
+++
> > > > > >  drivers/pci/controller/dwc/pcie-rcar-gen4.c   | 190 ++++++++++=
++++++++
> > > > > >  drivers/pci/controller/dwc/pcie-rcar-gen4.h   |  46 +++++
> > > > > >  5 files changed, 388 insertions(+)
> > > > > >  create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4-h=
ost.c
> > > > > >  create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4.c
> > > > > >  create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4.h
> > > > > >
> > > > > > diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/c=
ontroller/dwc/Kconfig
> > > > > > index ab96da43e0c2..64d4d37bc891 100644
> > > > > > --- a/drivers/pci/controller/dwc/Kconfig
> > > > > > +++ b/drivers/pci/controller/dwc/Kconfig
> > > > > > @@ -415,4 +415,13 @@ config PCIE_VISCONTI_HOST
> > > > > >  	  Say Y here if you want PCIe controller support on Toshiba V=
isconti SoC.
> > > > > >  	  This driver supports TMPV7708 SoC.
> > > > > >
> > > > > > +config PCIE_RCAR_GEN4
> > > > > > +	tristate "Renesas R-Car Gen4 PCIe Host controller"
> > > > > > +	depends on ARCH_RENESAS || COMPILE_TEST
> > > > > > +	depends on PCI_MSI
> > > > > > +	select PCIE_DW_HOST
> > > > > > +	help
> > > > > > +	  Say Y here if you want PCIe host controller support on R-Ca=
r Gen4 SoCs.
> > > > > > +	  This uses the DesignWare core.
> > > > > > +
> > > > > >  endmenu
> > > > > > diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/=
controller/dwc/Makefile
> > > > > > index bf5c311875a1..486cf706b53d 100644
> > > > > > --- a/drivers/pci/controller/dwc/Makefile
> > > > > > +++ b/drivers/pci/controller/dwc/Makefile
> > > > > > @@ -26,6 +26,8 @@ obj-$(CONFIG_PCIE_TEGRA194) +=3D pcie-tegra19=
4.o
> > > > > >  obj-$(CONFIG_PCIE_UNIPHIER) +=3D pcie-uniphier.o
> > > > > >  obj-$(CONFIG_PCIE_UNIPHIER_EP) +=3D pcie-uniphier-ep.o
> > > > > >  obj-$(CONFIG_PCIE_VISCONTI_HOST) +=3D pcie-visconti.o
> > > > > > +pcie-rcar-gen4-host-drv-objs :=3D pcie-rcar-gen4.o pcie-rcar-g=
en4-host.o
> > > > > > +obj-$(CONFIG_PCIE_RCAR_GEN4) +=3D pcie-rcar-gen4-host-drv.o
> > > > > >
> > > > > >  # The following drivers are for devices that use the generic A=
CPI
> > > > > >  # pci_root.c driver but don't support standard ECAM config acc=
ess.
> > > > > > diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4-host.c
> b/drivers/pci/controller/dwc/pcie-rcar-gen4-host.c
> > > > > > new file mode 100644
> > > > > > index 000000000000..df7d80f1874f
> > > > > > --- /dev/null
> > > > > > +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4-host.c
> > > > > > @@ -0,0 +1,141 @@
> > > > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > > > +/*
> > > > > > + * PCIe host controller driver for Renesas R-Car Gen4 Series S=
oCs
> > > > > > + * Copyright (C) 2022-2023 Renesas Electronics Corporation
> > > > > > + */
> > > > > > +
> > > > > > +#include <linux/delay.h>
> > > > > > +#include <linux/interrupt.h>
> > > > > > +#include <linux/module.h>
> > > > > > +#include <linux/of_device.h>
> > > > > > +#include <linux/pci.h>
> > > > > > +#include <linux/platform_device.h>
> > > > > > +
> > > > > > +#include "pcie-rcar-gen4.h"
> > > > > > +#include "pcie-designware.h"
> > > > > > +
> > > > > > +static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
> > > > > > +{
> > > > > > +	struct dw_pcie *dw =3D to_dw_pcie_from_pp(pp);
> > > > > > +	struct rcar_gen4_pcie *rcar =3D to_rcar_gen4_pcie(dw);
> > > > > > +	int ret;
> > > > > > +	u32 val;
> > > > > > +
> > > > > > +	gpiod_set_value_cansleep(dw->pe_rst, 1);
> > > > > > +
> > > > > > +	ret =3D rcar_gen4_pcie_set_device_type(rcar, true, dw->num_la=
nes);
> > > > > > +	if (ret < 0)
> > > > > > +		return ret;
> > > > > > +
> > > > >
> > > > > > +	dw_pcie_dbi_ro_wr_en(dw);
> > > > >
> > > > > Are you sure dw_pcie_dbi_ro_wr_en() and dw_pcie_dbi_ro_wr_dis() a=
re
> > > > > needed? In accordance with the DW PCIe Dual-mode HW manual the BA=
Rx
> > > > > registers are W-only over the DBI2 map with no need in setting th=
e
> > > > > DBI_RO_WR_EN flag.
> > > > >
> > > > > Please check that on your hardware.
> > > >
> > > > You're correct. They are not needed. So, I'll drop this on v17.
> > > >
> > > > > > +
> > > > > > +	/*
> > > > > > +	 * According to the section 3.5.7.2 "RC Mode" in DWC PCIe Dua=
l Mode
> > > > > > +	 * Rev.5.20a, we should disable two BARs to avoid unnecessary=
 memory
> > > > > > +	 * assignment during device enumeration.
> > > > > > +	 */
> > > > > > +	dw_pcie_writel_dbi2(dw, PCI_BASE_ADDRESS_0, 0x0);
> > > > > > +	dw_pcie_writel_dbi2(dw, PCI_BASE_ADDRESS_1, 0x0);
> > > > > > +
> > > > >
> > > > > > +	dw_pcie_dbi_ro_wr_dis(dw);
> > > > >
> > > > > ditto
> > > >
> > > > I'll drop this too.
> > > >
> > > > > > +
> > > > > > +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> > > > > > +		/* Enable MSI interrupt signal */
> > > > > > +		val =3D readl(rcar->base + PCIEINTSTS0EN);
> > > > > > +		val |=3D MSI_CTRL_INT;
> > > > > > +		writel(val, rcar->base + PCIEINTSTS0EN);
> > > > > > +	}
> > > > > > +
> > > > > > +	msleep(100);	/* pe_rst requires 100msec delay */
> > > > > > +
> > > > > > +	gpiod_set_value_cansleep(dw->pe_rst, 0);
> > > > > > +
> > > > > > +	return 0;
> > > > > > +}
> > > > > > +
> > > > > > +static const struct dw_pcie_host_ops rcar_gen4_pcie_host_ops =
=3D {
> > > > > > +	.host_init =3D rcar_gen4_pcie_host_init,
> > > > > > +};
> > > > > > +
> > > > > > +static int rcar_gen4_add_dw_pcie_rp(struct rcar_gen4_pcie *rca=
r,
> > > > > > +				   struct platform_device *pdev)
> > > > > > +{
> > > > > > +	struct dw_pcie *dw =3D &rcar->dw;
> > > > > > +	struct dw_pcie_rp *pp =3D &dw->pp;
> > > > > > +
> > > > > > +	pp->num_vectors =3D MAX_MSI_IRQS;
> > > > > > +	pp->ops =3D &rcar_gen4_pcie_host_ops;
> > > > > > +	dw_pcie_cap_set(dw, REQ_RES);
> > > > > > +
> > > > > > +	return dw_pcie_host_init(pp);
> > > > > > +}
> > > > > > +
> > > > > > +static void rcar_gen4_remove_dw_pcie_rp(struct rcar_gen4_pcie =
*rcar)
> > > > > > +{
> > > > > > +	dw_pcie_host_deinit(&rcar->dw.pp);
> > > > > > +	gpiod_set_value_cansleep(rcar->dw.pe_rst, 1);
> > > > > > +}
> > > > > > +
> > > > > > +static int rcar_gen4_pcie_probe(struct platform_device *pdev)
> > > > > > +{
> > > > > > +	struct device *dev =3D &pdev->dev;
> > > > > > +	struct rcar_gen4_pcie *rcar;
> > > > > > +	int err;
> > > > > > +
> > > > > > +	rcar =3D rcar_gen4_pcie_devm_alloc(dev);
> > > > > > +	if (!rcar)
> > > > > > +		return -ENOMEM;
> > > > > > +
> > > > > > +	err =3D rcar_gen4_pcie_get_resources(rcar, pdev);
> > > > > > +	if (err < 0) {
> > > > > > +		dev_err(dev, "Failed to request resource: %d\n", err);
> > > > > > +		return err;
> > > > > > +	}
> > > > > > +
> > > > > > +	platform_set_drvdata(pdev, rcar);
> > > > > > +
> > > > > > +	err =3D rcar_gen4_pcie_prepare(rcar);
> > > > > > +	if (err < 0)
> > > > > > +		return err;
> > > > > > +
> > > > > > +	rcar->needs_retrain =3D true;
> > > > > > +	err =3D rcar_gen4_add_dw_pcie_rp(rcar, pdev);
> > > > > > +	if (err < 0)
> > > > > > +		goto err_add;
> > > > > > +
> > > > > > +	return 0;
> > > > > > +
> > > > > > +err_add:
> > > > > > +	rcar_gen4_pcie_unprepare(rcar);
> > > > > > +
> > > > > > +	return err;
> > > > > > +}
> > > > > > +
> > > > > > +static int rcar_gen4_pcie_remove(struct platform_device *pdev)
> > > > > > +{
> > > > > > +	struct rcar_gen4_pcie *rcar =3D platform_get_drvdata(pdev);
> > > > > > +
> > > > > > +	rcar_gen4_remove_dw_pcie_rp(rcar);
> > > > > > +	rcar_gen4_pcie_unprepare(rcar);
> > > > > > +
> > > > > > +	return 0;
> > > > > > +}
> > > > > > +
> > > > > > +static const struct of_device_id rcar_gen4_pcie_of_match[] =3D=
 {
> > > > > > +	{ .compatible =3D "renesas,rcar-gen4-pcie", },
> > > > > > +	{},
> > > > > > +};
> > > > > > +
> > > > > > +static struct platform_driver rcar_gen4_pcie_driver =3D {
> > > > > > +	.driver =3D {
> > > > > > +		.name =3D "pcie-rcar-gen4",
> > > > > > +		.of_match_table =3D rcar_gen4_pcie_of_match,
> > > > > > +		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> > > > > > +	},
> > > > > > +	.probe =3D rcar_gen4_pcie_probe,
> > > > > > +	.remove =3D rcar_gen4_pcie_remove,
> > > > > > +};
> > > > > > +module_platform_driver(rcar_gen4_pcie_driver);
> > > > > > +
> > > > > > +MODULE_DESCRIPTION("Renesas R-Car Gen4 PCIe host controller dr=
iver");
> > > > > > +MODULE_LICENSE("GPL");
> > > > > > diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/driv=
ers/pci/controller/dwc/pcie-rcar-gen4.c
> > > > > > new file mode 100644
> > > > > > index 000000000000..35923fda8ed5
> > > > > > --- /dev/null
> > > > > > +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> > > > > > @@ -0,0 +1,190 @@
> > > > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > > > +/*
> > > > > > + * PCIe host/endpoint controller driver for Renesas R-Car Gen4=
 Series SoCs
> > > > > > + * Copyright (C) 2022-2023 Renesas Electronics Corporation
> > > > > > + */
> > > > > > +
> > > > > > +#include <linux/delay.h>
> > > > > > +#include <linux/io.h>
> > > > > > +#include <linux/of_device.h>
> > > > > > +#include <linux/pci.h>
> > > > > > +#include <linux/pm_runtime.h>
> > > > > > +#include <linux/reset.h>
> > > > > > +
> > > > > > +#include "pcie-rcar-gen4.h"
> > > > > > +#include "pcie-designware.h"
> > > > > > +
> > > > > > +/* Renesas-specific */
> > > > > > +#define PCIERSTCTRL1		0x0014
> > > > > > +#define  APP_HOLD_PHY_RST	BIT(16)
> > > > > > +#define  APP_LTSSM_ENABLE	BIT(0)
> > > > > > +
> > > > > > +#define RETRAIN_MAX_CHECK	10
> > > > > > +#define RETRAIN_MAX_RETRIES	10
> > > > > > +
> > > > > > +static void rcar_gen4_pcie_ltssm_enable(struct rcar_gen4_pcie =
*rcar,
> > > > > > +					bool enable)
> > > > > > +{
> > > > > > +	u32 val;
> > > > > > +
> > > > > > +	val =3D readl(rcar->base + PCIERSTCTRL1);
> > > > > > +	if (enable) {
> > > > > > +		val |=3D APP_LTSSM_ENABLE;
> > > > >
> > > > > > +		val &=3D ~APP_HOLD_PHY_RST;
> > > > >
> > > > > What about moving the APP_HOLD_PHY_RST de-assertion to the
> > > > > rcar_gen4_pcie_set_device_type() method? In accordance with the
> > > > > "3.1 Initialization" chapter it's supposed to be done before
> > > > > performing the DBI programming and activating the link training.
> > > >
> > >
> > > > IIUC, the "3.1 Initialization" said app_hold_phy_rst =3D 1 before
> > > > performing the DBI programming. So, it is assertion. Also, the SoC
> > > > documentation described the initializing procedure as the follows:
> > > >  app_ltssm_enable =3D 1
> > > >  app_hold_phy_rst =3D 0
> > > > So, I would like to keep them in the function.
> > >
> > > Indeed. I was wrong. Sorry for the misleading comment.
> >
> > No problem. Thank you for the confirmation!
> >
> > > >
> > > > > > +	} else {
> > > > > > +		val &=3D ~APP_LTSSM_ENABLE;
> > > > > > +		val |=3D APP_HOLD_PHY_RST;
> > > > > > +	}
> > > > > > +	writel(val, rcar->base + PCIERSTCTRL1);
> > > > > > +}
> > > > > > +
> > > > > > +static bool rcar_gen4_pcie_check_retrain_link(struct dw_pcie *=
dw)
> > > > > > +{
> > > > > > +	u8 offset =3D dw_pcie_find_capability(dw, PCI_CAP_ID_EXP);
> > > > > > +	u32 lnkcap =3D dw_pcie_readl_dbi(dw, offset + PCI_EXP_LNKCAP)=
;
> > > > > > +	u32 lnkctl =3D dw_pcie_readl_dbi(dw, offset + PCI_EXP_LNKCTL)=
;
> > > > > > +	u16 lnksta =3D dw_pcie_readw_dbi(dw, offset + PCI_EXP_LNKSTA)=
;
> > > > > > +	int i;
> > > > > > +
> > > > >
> > > > > > +	if ((lnksta & PCI_EXP_LNKSTA_CLS) =3D=3D (lnkcap & PCI_EXP_LN=
KCAP_SLS))
> > > > > > +		return true;
> > > > > > +
> > > > > > +	lnkctl |=3D PCI_EXP_LNKCTL_RL;
> > > > > > +	dw_pcie_writel_dbi(dw, offset + PCI_EXP_LNKCTL, lnkctl);
> > > > > > +
> > > > > > +	for (i =3D 0; i < RETRAIN_MAX_CHECK; i++) {
> > > > > > +		lnksta =3D dw_pcie_readw_dbi(dw, offset + PCI_EXP_LNKSTA);
> > > > > > +		if (lnksta & PCI_EXP_LNKSTA_LT)
> > > > > > +			return true;
> > > > > > +		usleep_range(1000, 1100);
> > > > > > +	}
> > > > >
> > > > > I'll ask one more time because you didn't respond to my previous =
note
> > > > > about this.
> > > >
> > > > I'm sorry. I completely overlooked the previous note.
> > > >
> > > > > Are you sure that this is needed? Did you try
> > > > > the approach described in "3.13 Gen2/3/4/5 Speed Modes" with
> > > > > de-asserting/asserting the GEN2_CTRL_OFF.DIRECT_SPEED_CHANGE flag=
?
> > > >
> > > > I tried this setting, but it doesn't work. I'll investigate this se=
tting more.
> > > >
> > > > > I keep asking because the same problem we used to have on our har=
dware
> > > > > until we found out that the DIRECT_SPEED_CHANGE flag helped to tr=
ain
> > > > > the link right to the speed specified in the capabilities.
> > > > >
> > > > > So here is what presumably you'll need to do (based on the
> > > > > "3.1 Initialization" and "3.13 Gen2/3/4/5 Speed Modes" chapters o=
f
> > > > > the DW PCIe DM hw-manual):
> > > > > 1. Make sure the controller is in the power-down/reset state.
> > > > > 2. Select device_type (EP or RP).
> > > > > 3. De-assert the controller reset.
> > > > > 4. Clear PHY-reset flag in the app registers.
> > > > > 5. Perform some controller initializations.
> > > > > 6. Enable LTSSM to start link training.
> > > > > 7. Set GEN2_CTRL_OFF.DIRECT_SPEED_CHANGE flag one more time.
> > > > >
> > > > > 1-4 are supposed to be done in rcar_gen4_pcie_host_init().
> > > > > 5 is performed in the framework of the DW PCIe core driver.
> > > > > 6-7 should be done in rcar_gen4_pcie_start_link().
> > > > >
> > > > > Note 1. GEN2_CTRL_OFF.DIRECT_SPEED_CHANGE flag is already set on =
stage
> > > > > 5 in the framework of the dw_pcie_setup_rc() method. But in our c=
ase
> > > > > it only caused having the Gen.2 link speed. Adding stage 7 helped=
 to
> > > > > get stable Gen.3 link. So please try the denoted approach. If it =
works
> > > > > what about adding stage 7 twice in order to get Gen.4 speed?
> > > > > (waiting for the DIRECT_SPEED_CHANGE flag being auto-cleared and =
then
> > > > > set it up again?)
> > > > >
> > > > > Note 2. GEN2_CTRL_OFF.DIRECT_SPEED_CHANGE flag is defined as
> > > > > PCIE_LINK_WIDTH_SPEED_CONTROL.PORT_LOGIC_SPEED_CHANGE macros in t=
he DW
> > > > > PCIe core driver.
> > > > >
> > > > > Note 3. If what is suggested above works well then you won't need=
 to
> > > > > have the heavy rcar_gen4_pcie_check_retrain_link() method in the =
way
> > > > > you have it defined.
> > > >
> > > > Thank you very much for your comments!
> > >
> > > Please see the GEN2_CTRL_OFF.DIRECT_SPEED_CHANGE description for deta=
ils
> > > of how the flag is supposed to be de-asserted and asserted in order t=
o
> > > initiate the direct speed change.
> >
> > After I modified the start_link() like below, it also works. Is the cod=
e
> > acceptable? (Sorry all tabs are replaced to spaces...)
>=20
> Looks good, but still there are some questions.
>=20
> > -----------------------------------------------------------------------=
-----
> > static bool rcar_gen4_pcie_check_current_link(struct dw_pcie *dw)
> > {
> >         u8 offset =3D dw_pcie_find_capability(dw, PCI_CAP_ID_EXP);
> >         u32 lnkcap =3D dw_pcie_readl_dbi(dw, offset + PCI_EXP_LNKCAP);
> >         u16 lnksta =3D dw_pcie_readw_dbi(dw, offset + PCI_EXP_LNKSTA);
> >
>=20
> >         if ((lnksta & PCI_EXP_LNKSTA_CLS) =3D=3D (lnkcap & PCI_EXP_LNKC=
AP_SLS))
> >                 return true;
>=20
> AFAICS depending on the link partner speed capabilities this may never
> happen.
>=20
> PCI_EXP_LNKCAP_SLS - Max Link Speed. This field indicates the maximum Lin=
k
> speed of the associated Port.
> PCI_EXP_LNKSTA_CLS - Current Link Speed. This field indicates the negotia=
ted
> Link speed of the given PCI Express Link
>=20
> What if a link partner has the speed capability weaker than the link
> speed of the Root Port? If so then the current link speed will never
> reach the max link speed value.

Thank you very much for your comments! You're correct. This code cannot
work correctly if a link partner has the speed capability weaker than the l=
ink speed...

> Of course this can be fixed by specifying a correct "max-link-speed"
> property, but what if a platform has a cold-swappable port connected to
> the root port? Since any device can be attached you'll never be able
> to predict its capabilities beforahead.

You're correct. So, I'll fix the code somehow.

> >
> >         return false;
> > }
> >
> > static void rcar_gen4_pcie_speed_change(struct dw_pcie *dw)
> > {
> >         u32 val;
> >
> >         val =3D dw_pcie_readl_dbi(dw, PCIE_LINK_WIDTH_SPEED_CONTROL);
> >         val &=3D ~PORT_LOGIC_SPEED_CHANGE;
> >         dw_pcie_writel_dbi(dw, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
> >
> >         val =3D dw_pcie_readl_dbi(dw, PCIE_LINK_WIDTH_SPEED_CONTROL);
> >         val |=3D PORT_LOGIC_SPEED_CHANGE;
> >         dw_pcie_writel_dbi(dw, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
> > }
> >
> > static int rcar_gen4_pcie_start_link(struct dw_pcie *dw)
> > {
> >         struct rcar_gen4_pcie *rcar =3D to_rcar_gen4_pcie(dw);
> >         int i;
> >
> >         rcar_gen4_pcie_ltssm_enable(rcar, true);
> >
> >         /*
> >          * Require direct speed change here. Otherwise RDLH_LINK_UP of
> >          * PCIEINTSTS0 which is this controller specific register may n=
ot
> >          * be set.
> >          */
>=20
> >         if (rcar->needs_speed_change) {
>=20
> Seeing this is specified for the root port only what about
> replacing the statement with just test whether the rcar_gen4_pcie.mode =
=3D=3D
> DW_PCIE_RC_TYPE? Thus you'll be ablt to drop the needs_speed_change field=
.

Thank you for the comment. I'll fix it.

> BTW Just curious. Why is the loop below enabled for the Root Port
> only? What about the end-point controller? It's the same hardware
> after all..

This is reused from v16 and then it used "link retraining" which is only fo=
r
the Root Port. As you mentioned, it seems endpoint controller is also neede=
d
if we use direct speed change.

> >                 for (i =3D 0; i < SPEED_CHANGE_MAX_RETRIES; i++) {
> >                         rcar_gen4_pcie_speed_change(dw);
> >                         msleep(100);
> >                         if (rcar_gen4_pcie_check_current_link(dw))
> >                                 return 0;
> >                 }
>=20
> Did you trace how many iterations this loop normally takes?

i =3D 0 or 1 (if the max-link-speed is suitable for a connected device.)

> Is it
> constant or varies for the same platform setup and a connected link
> partner? Does the number of iterations depend on the target link speed
> specified via the "max-link-speed" property?

This is not related to the "max-link-speed". It seems to related to
a link partner.
		LinkCap	max-link-speed	loop
Device A		4	4		1
Device A		4	3		1
Device B		3	3		0

> I am just trying to understand whether we can completely get rid from
> the rcar_gen4_pcie_check_current_link() method and have it replaced
> with several rcar_gen4_pcie_speed_change() calls. The current link
> state would have been checked in the framework of the
> dw_pcie_wait_for_link() method which calls dw_pcie_link_up() and your
> rcar_gen4_pcie_link_up() in order to make sure the link is actually up.

Thank you for your comment! I'll investigate it.

Best regards,
Yoshihiro Shimoda

> -Serge(y)
>=20
> >
> >                 return -ETIMEDOUT;      /* Failed */
> >         }
> > ------------------------------------------------------------------
> >
> > > >
> > > > > > +
> > > > > > +	return false;
> > > > > > +}
> > > > > > +
> > > > > > +static int rcar_gen4_pcie_link_up(struct dw_pcie *dw)
> > > > > > +{
> > > > > > +	struct rcar_gen4_pcie *rcar =3D to_rcar_gen4_pcie(dw);
> > > > > > +	u32 val, mask;
> > > > > > +
> > > > > > +	val =3D readl(rcar->base + PCIEINTSTS0);
> > > > > > +	mask =3D RDLH_LINK_UP | SMLH_LINK_UP;
> > > > > > +
> > > > > > +	return (val & mask) =3D=3D mask;
> > > > > > +}
> > > > > > +
> > > > > > +static int rcar_gen4_pcie_start_link(struct dw_pcie *dw)
> > > > > > +{
> > > > > > +	struct rcar_gen4_pcie *rcar =3D to_rcar_gen4_pcie(dw);
> > > > > > +	int i;
> > > > > > +
> > > > > > +	rcar_gen4_pcie_ltssm_enable(rcar, true);
> > > > > > +
> > > > > > +	/*
> > > > > > +	 * Require retraining here. Otherwise RDLH_LINK_UP of PCIEINT=
STS0 which
> > > > > > +	 * is this controller specific register may not be set.
> > > > > > +	 */
> > > > > > +	if (rcar->needs_retrain) {
> > > > > > +		for (i =3D 0; i < RETRAIN_MAX_RETRIES; i++) {
> > > > > > +			if (rcar_gen4_pcie_check_retrain_link(dw))
> > > > > > +				return 0;
> > > > > > +			msleep(100);
> > > > > > +		}
> > > > > > +
> > > > > > +		return -ETIMEDOUT;	/* Failed */
> > > > > > +	}
> > > > > > +
> > > > > > +	return 0;
> > > > > > +}
> > > > > > +
> > > > > > +static void rcar_gen4_pcie_stop_link(struct dw_pcie *dw)
> > > > > > +{
> > > > > > +	struct rcar_gen4_pcie *rcar =3D to_rcar_gen4_pcie(dw);
> > > > > > +
> > > > > > +	rcar_gen4_pcie_ltssm_enable(rcar, false);
> > > > > > +}
> > > > > > +
> > > > >
> > > > > > +int rcar_gen4_pcie_set_device_type(struct rcar_gen4_pcie *rcar=
, bool rc,
> > > > > > +				   int num_lanes)
> > > > >
> > > > > 1. Number of lanes is already defined in the rcar_gen4_pcie.dw.nu=
m_lanes field.
> > > > > What about using it from there instead of passing it as an argume=
nt?
> > > > > 2. DW PCIe core driver has a very handy enum defined:
> > > > > dw_pcie_device_mode. It describes the controller modes (End-point=
,
> > > > > Root port, etc). What about adding the mode field right to the
> > > > > rcar_gen4_pcie structure and initializing it in someplace in prob=
e() ?
> > > > > 3. Based on the function semantic it's better to be named as some=
thing
> > > > > like rcar_gen4_pcie_init_device() or even rcar_gen4_pcie_basic_in=
it().
> > > >
> > > > Thank you for your comments! I'll modify the function.
> > > >
> > > > >
> > > > > > +{
> > > > > > +	u32 val;
> > > > > > +
> > > > >
> > > > > > +	/* Note: Assume the rcar->rst which is Cold-reset is asserted=
 here */
> > > > >
> > > > > What about directly asserting it here then? In accordance with th=
e DW
> > > > > PCIe DM manual the "device_type" input must be set before the DM
> > > > > controller is powered up (basically un-reset). What if the contro=
ller
> > > > > reset is already de-asserted, but you are going to changes its mo=
de?
> > > > > In that case the mode won't be changed and you'll end up with
> > > > > unpredictable results.
> > > >
> > > > Thank you for your comment. We should add asserting it here as you =
mentioned.
> > > >
> > > > > > +	val =3D readl(rcar->base + PCIEMSR0);
> > > > > > +	if (rc)
> > > > > > +		val |=3D DEVICE_TYPE_RC;
> > > > > > +	else
> > > > > > +		val |=3D DEVICE_TYPE_EP;
> > > > > > +
> > > > > > +	if (num_lanes < 4)
> > > > > > +		val |=3D BIFUR_MOD_SET_ON;
> > > > > > +
> > > > > > +	writel(val, rcar->base + PCIEMSR0);
> > > > > > +
> > > > > > +	return reset_control_deassert(rcar->rst);
> > > > > > +}
> > > > > > +
> > > > > > +int rcar_gen4_pcie_prepare(struct rcar_gen4_pcie *rcar)
> > > > > > +{
> > > > > > +	struct device *dev =3D rcar->dw.dev;
> > > > > > +	int err;
> > > > > > +
> > > > > > +	pm_runtime_enable(dev);
> > > > > > +	err =3D pm_runtime_resume_and_get(dev);
> > > > > > +	if (err < 0) {
> > > > > > +		dev_err(dev, "Failed to resume/get Runtime PM\n");
> > > > > > +		pm_runtime_disable(dev);
> > > > > > +	}
> > > > > > +
> > > > > > +	return err;
> > > > > > +}
> > > > > > +
> > > > > > +void rcar_gen4_pcie_unprepare(struct rcar_gen4_pcie *rcar)
> > > > > > +{
> > > > > > +	struct device *dev =3D rcar->dw.dev;
> > > > > > +
> > > > > > +	if (!reset_control_status(rcar->rst))
> > > > > > +		reset_control_assert(rcar->rst);
> > > > > > +	pm_runtime_put(dev);
> > > > > > +	pm_runtime_disable(dev);
> > > > > > +}
> > > > > > +
> > > > > > +int rcar_gen4_pcie_get_resources(struct rcar_gen4_pcie *rcar,
> > > > > > +				 struct platform_device *pdev)
> > > > > > +{
> > > > > > +	struct device *dev =3D rcar->dw.dev;
> > > > > > +
> > > > > > +	/* Renesas-specific registers */
> > > > > > +	rcar->base =3D devm_platform_ioremap_resource_byname(pdev, "a=
pp");
> > > > > > +	if (IS_ERR(rcar->base))
> > > > > > +		return PTR_ERR(rcar->base);
> > > > > > +
> > > > >
> > > > > > +	rcar->rst =3D devm_reset_control_get(dev, NULL);
> > > > > > +	if (IS_ERR(rcar->rst)) {
> > > > > > +		dev_err(dev, "Failed to get Cold-reset\n");
> > > > >
> > > > > So AFAICS your platform is equipped with the DWC_pcie_clkrst.v mo=
dule.
> > > > > Thus all the resets are appropriately cleared by a single flag:
> > > > > power_up_rst_n. What about using the named reset in this case wit=
h the
> > > > > "pwr" name? Thus you'll be able to drop the manual
> > > > > devm_reset_control_get() invocation and instead use the reset-res=
ources
> > > > > requested in the framework of the generic dw_pcie_get_resources()
> > > > > method? Note you'll need to move the dw_pcie_cap_set(dw, REQ_RES)=
;
> > > > > statement to rcar_gen4_pcie_devm_alloc() then and drop the
> > > > > rcar_gen4_pcie.rst field afterwords.
> > > >
> > > > Thank you for your suggestion! Using "pwr" can work on my environme=
nt.
> > > >
> > > > > By the way I don't see you requesting and enabling the reference
> > > > > clock in your driver but the bindings imply the clock source. How
> > > > > come?
> > > >
> > >
> > > > For now, I used gpio-hog to enable the reference clock. But, it see=
m
> > > > I should use "ref" clock for it. So, I'll fix it too.
> > >
> > > Not sure what gpio-hog you are talking about. Do you mean the pe_rst
> > > signal or some another gpio? I failed to see of how pe_rst is
> > > connected to the clock source. In anyway directly handling the clock
> > > source would be more portable choice.
> >
> > Sorry for lacking information. I described a gpio node like below
> > and then the gpio will be high automatically, and the reference clock
> > will be output. But, this is completely independent from pci.
> > ---
> > &gpio2 {
> >         pci-clkreq0-hog {
> >                 gpio-hog;
> >                 gpios =3D <15 GPIO_ACTIVE_LOW>;
> >                 output-high;
> >         };
> > };
> > ---
> >
> > Now I could implement the clock handling by using "gpio-gate-clock".
> > So, I'll drop the gpio-hog for the reference clock.
> >
> > Best regards,
> > Yoshihiro Shimoda
> >
> > > -Serge(y)
> > >
> > > >
> > > > > > +		return PTR_ERR(rcar->rst);
> > > > > > +	}
> > > > > > +
> > > > > > +	return 0;
> > > > > > +}
> > > > > > +
> > > > > > +static const struct dw_pcie_ops dw_pcie_ops =3D {
> > > > > > +	.start_link =3D rcar_gen4_pcie_start_link,
> > > > > > +	.stop_link =3D rcar_gen4_pcie_stop_link,
> > > > > > +	.link_up =3D rcar_gen4_pcie_link_up,
> > > > > > +};
> > > > > > +
> > > > > > +struct rcar_gen4_pcie *rcar_gen4_pcie_devm_alloc(struct device=
 *dev)
> > > > > > +{
> > > > > > +	struct rcar_gen4_pcie *rcar;
> > > > > > +
> > > > > > +	rcar =3D devm_kzalloc(dev, sizeof(*rcar), GFP_KERNEL);
> > > > > > +	if (!rcar)
> > > > > > +		return NULL;
> > > > > > +
> > > > > > +	rcar->dw.dev =3D dev;
> > > > > > +	rcar->dw.ops =3D &dw_pcie_ops;
> > > > > > +	dw_pcie_cap_set(&rcar->dw, EDMA_UNROLL);
> > > > > > +
> > > > > > +	return rcar;
> > > > > > +}
> > > > > > diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.h b/driv=
ers/pci/controller/dwc/pcie-rcar-gen4.h
> > > > > > new file mode 100644
> > > > > > index 000000000000..fec3f18609f4
> > > > > > --- /dev/null
> > > > > > +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.h
> > > > > > @@ -0,0 +1,46 @@
> > > > > > +/* SPDX-License-Identifier: GPL-2.0-only */
> > > > > > +/*
> > > > > > + * PCIe host/endpoint controller driver for Renesas R-Car Gen4=
 Series SoCs
> > > > > > + * Copyright (C) 2022-2023 Renesas Electronics Corporation
> > > > > > + */
> > > > > > +
> > > > > > +#ifndef _PCIE_RCAR_GEN4_H_
> > > > > > +#define _PCIE_RCAR_GEN4_H_
> > > > > > +
> > > > > > +#include <linux/io.h>
> > > > > > +#include <linux/pci.h>
> > > > > > +#include <linux/reset.h>
> > > > > > +
> > > > > > +#include "pcie-designware.h"
> > > > > > +
> > > > > > +/* Renesas-specific */
> > > > > > +#define PCIEMSR0		0x0000
> > > > > > +#define  BIFUR_MOD_SET_ON	BIT(0)
> > > > > > +#define  DEVICE_TYPE_EP		0
> > > > > > +#define  DEVICE_TYPE_RC		BIT(4)
> > > > > > +
> > > > > > +#define PCIEINTSTS0		0x0084
> > > > > > +#define PCIEINTSTS0EN		0x0310
> > > > > > +#define  MSI_CTRL_INT		BIT(26)
> > > > > > +#define  SMLH_LINK_UP		BIT(7)
> > > > > > +#define  RDLH_LINK_UP		BIT(6)
> > > > > > +#define PCIEDMAINTSTSEN		0x0314
> > > > > > +#define  PCIEDMAINTSTSEN_INIT	GENMASK(15, 0)
> > > > > > +
> > > > >
> > > > > > +struct rcar_gen4_pcie {
> > > > >
> > > > > As I mentioned above this structure can be extended with the enum
> > > > > dw_pcie_device_mode field thus dropping the boolean argument from=
 the
> > > > > rcar_gen4_pcie_set_device_type() method.
> > > >
> > > > I got it. I'll fix this.
> > > >
> > > > > > +	struct dw_pcie		dw;
> > > > >
> > > > > As I already mentioned above the dw.num_lanes could be used inste=
ad of
> > > > > passing it as the rcar_gen4_pcie_set_device_type() argument.
> > > >
> > > > I'll fix this too.
> > > >
> > > > Best regards,
> > > > Yoshihiro Shimoda
> > > >
> > > > > -Serge(y)
> > > > >
> > > > > > +	void __iomem		*base;
> > > > > > +	struct reset_control	*rst;
> > > > > > +	bool			needs_retrain;
> > > > > > +};
> > > > > > +#define to_rcar_gen4_pcie(x)	dev_get_drvdata((x)->dev)
> > > > > > +
> > > > > > +int rcar_gen4_pcie_set_device_type(struct rcar_gen4_pcie *rcar=
, bool rc,
> > > > > > +				   int num_lanes);
> > > > > > +int rcar_gen4_pcie_prepare(struct rcar_gen4_pcie *pcie);
> > > > > > +void rcar_gen4_pcie_unprepare(struct rcar_gen4_pcie *pcie);
> > > > > > +int rcar_gen4_pcie_get_resources(struct rcar_gen4_pcie *rcar,
> > > > > > +				 struct platform_device *pdev);
> > > > > > +struct rcar_gen4_pcie *rcar_gen4_pcie_devm_alloc(struct device=
 *dev);
> > > > > > +
> > > > > > +#endif /* _PCIE_RCAR_GEN4_H_ */
> > > > > > --
> > > > > > 2.25.1
> > > > > >
