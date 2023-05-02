Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967C96F48C9
	for <lists+linux-pci@lfdr.de>; Tue,  2 May 2023 19:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbjEBREO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 May 2023 13:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbjEBREN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 May 2023 13:04:13 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2063.outbound.protection.outlook.com [40.107.247.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02E5E4B;
        Tue,  2 May 2023 10:04:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fw0TXqzXB3up7WZRERmnfGUvboa81OUf3b3nqvtxpc/u4h8W0g+ZnXxp1Hm2WCCtOVGELZ6lziK5Uxy9IVApgh1t8yx5lbo058jfArrPpy8ep/UwTbIR1Y79oplIeA+AsKv97BHFmHps370P6PzHw57WzOHLAUhqnqpAgO7SG6C9/y5q+6qJCxSHvtJNxBbDUdah+6nPz52xnIX8bFCNeZnfnB1tvi0d4uNFnIZv+pck8FQJdZcz+iWC4MpMJdQAFqAWincqLA2IsSfRasRDerf9hPaIZQe4uonquvXd3dnKuZLN4pbwwNObD8eXvUrRo8NcptJqTjvDF2WLn9oWPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VxAOiezCU1ZuycAwDiHfIG9+rbKZiiZiulL9MUr0blU=;
 b=Z3KUAQgAHTzXR9sZaOFBQJfjFu2D9ZfbuU5sCQp9sCjLsR7coN+dMXSqmZlUBubIJzKwCZOWkC6BBoyno3aaKACEWtYVff+Jf5n0XqrgJSEZaUtKqAEKSGrMYegiAg2kl/jmvkCYjUou1oCOIkRnKYJtZtN2smwgtxDspdWDG5UcbAHNmxTlKgOLxFiT/pNF9qge4Qf1QJQ+LvzplAk7Qa8YCcpYUzuaw+qW1M+FdTeV0Qf2dHEEfjNIdgEhh7zd9SilePPJCI17trbV1YQyTe12zjih6uY2JxHtcrXklveNjcYu/9vfdgT7q/99VLYrvAjLn2F9wNoyzDfKScatjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VxAOiezCU1ZuycAwDiHfIG9+rbKZiiZiulL9MUr0blU=;
 b=XVVO38+8x82yRz1DJExJy0IEy3AVvF6Ztu5ZBEAiIJXgGviJZbc/9LlblM7sjnrcJV3asyHw277cVRFlwy6P04ScQLlqCVr7A6SJudjgxgi46DSMu76a3Yr/uYaanNgwR8Rgd5Kk76szpCID6vxYtXxUaPklJzV02uOJ5LF7YPs=
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB8PR04MB7081.eurprd04.prod.outlook.com (2603:10a6:10:fe::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Tue, 2 May
 2023 17:04:08 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::bcdd:75c9:176c:39ed]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::bcdd:75c9:176c:39ed%4]) with mapi id 15.20.6340.031; Tue, 2 May 2023
 17:04:07 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
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
Subject: RE: [EXT] Re: [PATCH v14 08/21] PCI: dwc: Add support for triggering
 INTx IRQs from endpoint drivers
Thread-Topic: [EXT] Re: [PATCH v14 08/21] PCI: dwc: Add support for triggering
 INTx IRQs from endpoint drivers
Thread-Index: AQHZfGKW6+vAwYirXk6DHkPCWlgfta9HNW7g
Date:   Tue, 2 May 2023 17:04:07 +0000
Message-ID: <AM6PR04MB4838C160989D8BF56C7012B5886F9@AM6PR04MB4838.eurprd04.prod.outlook.com>
References: <20230426045557.3613826-1-yoshihiro.shimoda.uh@renesas.com>
 <20230426045557.3613826-9-yoshihiro.shimoda.uh@renesas.com>
 <20230501192435.hn6j4ihiejcm5lzp@mobilestation>
In-Reply-To: <20230501192435.hn6j4ihiejcm5lzp@mobilestation>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB4838:EE_|DB8PR04MB7081:EE_
x-ms-office365-filtering-correlation-id: d6da5211-0676-4f55-0a59-08db4b2f3dd8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ctFRNfinkqVz1Y/ni5PmJmZhWfBAuZbrKVKef5J6zKMMwEIAsjJ48Anep8VZimS03ZTYdUysjwM1yWEec4ay28wqnPm6qd9IBHtGU4idlzcwJnmFrvle4xBcetBO3WKX/eCdLFRz5UOQ12vcWprIHtbJeUnWoDl551P+H2puE69Jx0SEWd2EDnM7uLQe1ACxpsoJ8+N1aMm90lmMhD/8fB/VOYpwJNkmRW9UVzri9+Hp5cncAfStOjdsfdAo5l1bEOJdzrf58ZyXL4zOwyPRTySQdpNOmK2tIWZi5M39hY+lStlOSCvU7phHk58S2LuQevEuyxwU29W5Xsc6fSiugGfeg+5iH02/iw5MU6VgRkED2hS+p9S8k2mTt/ynpVSUKkJgLvikVAvjuNhpv+aI6QFjhN9snXq1X49TYyprjUmCElgZthmHCesDOBjvXGd33zo3oLl9jUi13bZQxG5cQv15oohaNY+IXQ/iMAA87Cmc9sL/O5XuOO0CpTscGVTOzsIrgWWKOCngj9emXMoNeqeB8TelnDh5ErBMlYCFrSJ3hXHYTAdMnoMagB6jS08WbfVGioVMZNHp9kbXJNChAzliL11z8Jd7109xoQIvBoYIiGuWAU1hIdc6id6RKIGF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(366004)(346002)(39860400002)(451199021)(33656002)(8676002)(8936002)(38100700002)(7416002)(5660300002)(52536014)(44832011)(316002)(2906002)(66446008)(66946007)(66556008)(76116006)(64756008)(66476007)(4326008)(41300700001)(122000001)(38070700005)(55016003)(86362001)(71200400001)(7696005)(478600001)(6506007)(9686003)(53546011)(55236004)(26005)(186003)(110136005)(83380400001)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?G06MPyAVOA4LWMQl1d6k4k8K14867X97ZTTFh478ohgcMAciZhLrC+MvBHSI?=
 =?us-ascii?Q?OZD2oBxmKOkY8ZYjvhHMbxaG7SLkF5I+gKQZaUcScIk9DyI19OE+xIaqBqs9?=
 =?us-ascii?Q?wn/2RMJT2OxE7C0WPncoU0LldH8vpDpawzXCpiphqpfgNeicQqFGBfZDNS7Q?=
 =?us-ascii?Q?Ws6kqX1ePn7ISeTfP2AICAfLXXl2eyPducym0yCSh4OKjPbz259rLgxR1Dre?=
 =?us-ascii?Q?5dGgB+JqGtfgPdz0QIIImRhrOTWqx8Kt14faNbnKWQydcXzrBRhjiqfebllH?=
 =?us-ascii?Q?Shxnjh6iZbrteB3rNNyw7CH8C8lwFgwPYP1EZL1fiV/VNC37v83u9XRVHabp?=
 =?us-ascii?Q?+ubBr6zw7RqXDGJK+8t6VyokT1SqUUbDd+f0vM9sUomkqJ4DOSG+QkFYcvq3?=
 =?us-ascii?Q?hbt1MEHihmRvDzOaFEbLBrsZq7T+Ze/qoeaAo9BzOeZHsj6LZAzYtfcGOMDj?=
 =?us-ascii?Q?xAlNI7Hh6G7ze3SXRTAPlGqcSjuX3Enn6NIrOEEPM00Q4uZDWrWDmgYz28yK?=
 =?us-ascii?Q?LEzQQv1llIdOokUJGWOHWPPWPb/HcatouvAhcqQ/pMojK9csclwPp0mAOcAb?=
 =?us-ascii?Q?rjFG0DZ173wDRe2QNil8gkRJaLF5NrUfdTkHaI61L3clCsdk6p8Vz2HgWzY+?=
 =?us-ascii?Q?mdG9y3p6+0hvKpdPrNX6JG5tNbEjq1A/rjLQNd0raqkal0zwOb0uZSXU8Knx?=
 =?us-ascii?Q?79cNuNF0a9hQ9062r7x6dvG0JShhJQXLv/Pc31KyKTJZO+Z+8P8gOr/nZ/mK?=
 =?us-ascii?Q?8LGP7tHtmDUO1Hr+AwX4ZWuN0yy39SL0AZfxh0Cq/5Ch63keNLc2YO5wPNkg?=
 =?us-ascii?Q?S7nGlqxPfud/DTPWyqeXnfs/tAMd94IiARcnGCD6xzTxBCxaPLi8AmvAosyV?=
 =?us-ascii?Q?NskfxDXp6vrVU8JKIkwQjB3mRoyUmIiEqo4L2DrA9tds9DD1JUWJV737SGfr?=
 =?us-ascii?Q?rjJM+gxuPxMWdCNIkmXHw2PsPOxPa3C9XVWq5K+gOAXT1b/h36l3teMTZDxo?=
 =?us-ascii?Q?t6cXz5bLcmndaxR11n3AzxoXJ11Ug68uF2SThOnQ2ib9ovE+OK4PQvGoYhwu?=
 =?us-ascii?Q?yB0quSGJ78V1PsSjnlz4Cagw3zM6q66UhL1t+uQZfzWo0LNeWFxpMMhlOSAb?=
 =?us-ascii?Q?EOHxNalR19O7U9emHacogTf3LmlJ0MQ7YC8F9t8t7hmaQXmyMcz/Mvep5xVB?=
 =?us-ascii?Q?WR7As2BAAPnjd4lxCpuLwxWVq49K1IyH8myiaF4bOca4F5PW6EbFCuEqF1wU?=
 =?us-ascii?Q?2q5afO6pbAqNZi/9HLzgusfyA5P39mwxilWZyWkCIA3cwW9QhgdXysG4jHp/?=
 =?us-ascii?Q?z1/3hJoKi3f7PRszzA3T9w8qdXubKJ5+/kZFp/wUAsGQOrlLOnzyWXR4IFgv?=
 =?us-ascii?Q?O/YTkxOqPhaQsHCaILyvBUQVOcSz4qw3xTo/ptaHjhWoCM8pQAqeBb1Uc0V1?=
 =?us-ascii?Q?uneaonHZXNsGuJWjTNpUQKeQmzlGMk1etfhkewOlDd6tjmOsShLTQaALAz8U?=
 =?us-ascii?Q?CwgtjGE3mGUQAtfgLU6lSZFJHulNKfKY/q0D9B4xLdI5PhzU86jOq4vhfQEb?=
 =?us-ascii?Q?0LG8E/C4oYvqLOqCx04=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6da5211-0676-4f55-0a59-08db4b2f3dd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2023 17:04:07.6140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fV6V8UOg4i0V5w+Aw6jLSjBlAoQm9qg405vjJdU26W19a1nrw9BVpAtQaZF5ioHE69wh116InYxkDnLq3J8UoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7081
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Serge Semin <fancer.lancer@gmail.com>
> Sent: Monday, May 1, 2023 2:25 PM
> To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: jingoohan1@gmail.com; mani@kernel.org;
> gustavo.pimentel@synopsys.com; lpieralisi@kernel.org;
> robh+dt@kernel.org; kw@linux.com; bhelgaas@google.com;
> kishon@kernel.org; marek.vasut+renesas@gmail.com; linux-
> pci@vger.kernel.org; devicetree@vger.kernel.org; linux-renesas-
> soc@vger.kernel.org
> Subject: [EXT] Re: [PATCH v14 08/21] PCI: dwc: Add support for triggering
> INTx IRQs from endpoint drivers
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> On Wed, Apr 26, 2023 at 01:55:44PM +0900, Yoshihiro Shimoda wrote:
> > Add support for triggering INTx IRQs by using outbound iATU.
> > Outbound iATU is utilized to send assert and de-assert INTx TLPs.
> > The message is generated based on the payloadless Msg TLP with type
> > 0x14, where 0x4 is the routing code implying the Terminate at
> > Receiver message. The message code is specified as b1000xx for
> > the INTx assertion and b1001xx for the INTx de-assertion.
>=20
> [PATCH v14 08/21] PCI: dwc: Add support for triggering INTx IRQs from
> endpoint drivers
>=20
> What about shortening the subject out a bit:
> "PCI: designware-ep: Add INTx IRQs support"
> ?
>=20
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> >  .../pci/controller/dwc/pcie-designware-ep.c   | 71 +++++++++++++++++--
> >  drivers/pci/controller/dwc/pcie-designware.h  |  2 +
> >  2 files changed, 69 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c
> b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > index 96375b0aba82..b35ed2b06193 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > @@ -6,6 +6,7 @@
> >   * Author: Kishon Vijay Abraham I <kishon@ti.com>
> >   */
> >
> > +#include <linux/delay.h>
> >  #include <linux/of.h>
> >  #include <linux/platform_device.h>
> >
> > @@ -485,14 +486,63 @@ static const struct pci_epc_ops epc_ops =3D {
> >       .get_features           =3D dw_pcie_ep_get_features,
> >  };
> >
> > +static int dw_pcie_ep_send_msg(struct dw_pcie_ep *ep, u8 func_no, u8
> code,
> > +                            u8 routing)
> > +{
> > +     struct dw_pcie_outbound_atu atu =3D { 0 };
> > +     struct pci_epc *epc =3D ep->epc;
> > +     int ret;
> > +
> > +     atu.func_no =3D func_no;
> > +     atu.code =3D code;
> > +     atu.routing =3D routing;
> > +     atu.type =3D PCIE_ATU_TYPE_MSG;
> > +     atu.cpu_addr =3D ep->intx_mem_phys;
> > +     atu.size =3D epc->mem->window.page_size;
> > +
> > +     ret =3D dw_pcie_ep_outbound_atu(ep, &atu);
> > +     if (ret)
> > +             return ret;
> > +
> > +     writel(0, ep->intx_mem);
> > +
> > +     dw_pcie_ep_unmap_addr(epc, func_no, 0, ep->intx_mem_phys);
> > +
> > +     return 0;
> > +}
> > +
>=20
> > +static int __dw_pcie_ep_raise_intx_irq(struct dw_pcie_ep *ep, u8
> func_no,
> > +                                      int intx)
> > +{
> > +     int ret;
> > +
> > +     ret =3D dw_pcie_ep_send_msg(ep, func_no, PCI_CODE_ASSERT_INTA +
> intx,
> > +                               PCI_MSG_ROUTING_LOCAL);
> > +     if (ret)
> > +             return ret;
> > +
> > +     /*
> > +      * The documents of PCIe and the controller don't mention how lon=
g
> > +      * the INTx should be asserted. If 10 usec, sometimes it failed.
> > +      * So, asserted for 50 usec.
> > +      */
> > +     usleep_range(50, 100);

It is good method to implement legacy irq support. But there is problem whi=
ch need be considered.=20

According to PCI spec, section 6.2.1 PCI-compatible INTx Emulation

PCI Express emulates the PCI interrupt mechanism including the Interrupt Pi=
n and Interrupt Line registers of the PCI
Configuration Space for PCI device Functions. PCI Express non-Switch device=
s may optionally support these registers for
backwards compatibility. Switch devices are required to support them. Actua=
l interrupt signaling uses in-band Messages
rather than being signaled using physical pins.
Two types of Messages are defined, Assert_INTx and Deassert_INTx, for emula=
tion of PCI INTx signaling, where x is A, B,
C, and D for respective PCI interrupt signals. These Messages are used to p=
rovide "virtual wires" for signaling interrupts
across a Link. Switches collect these virtual wires and present a combined =
set at the Switch's Upstream Port. Ultimately,
the virtual wires are routed to the Root Complex which maps the virtual wir=
es to system interrupt resources. Devices
must use assert/deassert Messages in pairs to emulate PCI interrupt **level=
-triggered** signaling. Actual mapping of PCI
Express INTx emulation to system interrupts is implementation specific as i=
s mapping of physical interrupt signals in
conventional PCI.

It should be level triggered.   When call __dw_pcie_ep_raise_intx_irq, shou=
ld be just assert INTx, then after PCI
Host driver's  irq handler to clear irq,  EP side can desert INTx.=20

So it should be two functions, one function raise INTx,  and another one de=
sert INTx.   But I don't know
How to avoid host side possible flood irq happen if EP can't desert INTx in=
 time. =20


> > +
> > +     return dw_pcie_ep_send_msg(ep, func_no,
> PCI_CODE_DEASSERT_INTA + intx,
> > +                                PCI_MSG_ROUTING_LOCAL);
> > +}
>=20
> Why do you need the underscored version of the method? I don't see it
> being utilized anywhere but in the dw_pcie_ep_raise_intx_irq()
> function. Thus its body can be completely moved to
> dw_pcie_ep_raise_intx_irq().
>=20
> -Serge(y)
>=20
> > +
> >  int dw_pcie_ep_raise_intx_irq(struct dw_pcie_ep *ep, u8 func_no)
> >  {
> >       struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> >       struct device *dev =3D pci->dev;
> >
> > -     dev_err(dev, "EP cannot trigger INTx IRQs\n");
> > +     if (!ep->intx_mem) {
> > +             dev_err(dev, "INTx not supported\n");
> > +             return -EOPNOTSUPP;
> > +     }
> >
> > -     return -EINVAL;
> > +     return __dw_pcie_ep_raise_intx_irq(ep, func_no, 0);
> >  }
> >  EXPORT_SYMBOL_GPL(dw_pcie_ep_raise_intx_irq);
> >
> > @@ -623,6 +673,10 @@ void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
> >
> >       dw_pcie_edma_remove(pci);
> >
> > +     if (ep->intx_mem)
> > +             pci_epc_mem_free_addr(epc, ep->intx_mem_phys, ep-
> >intx_mem,
> > +                                   epc->mem->window.page_size);
> > +
> >       pci_epc_mem_free_addr(epc, ep->msi_mem_phys, ep->msi_mem,
> >                             epc->mem->window.page_size);
> >
> > @@ -794,9 +848,14 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> >               goto err_exit_epc_mem;
> >       }
> >
> > +     ep->intx_mem =3D pci_epc_mem_alloc_addr(epc, &ep-
> >intx_mem_phys,
> > +                                           epc->mem->window.page_size)=
;
> > +     if (!ep->intx_mem)
> > +             dev_warn(dev, "Failed to reserve memory for INTx\n");
> > +
> >       ret =3D dw_pcie_edma_detect(pci);
> >       if (ret)
> > -             goto err_free_epc_mem;
> > +             goto err_free_epc_mem_intx;
> >
> >       if (ep->ops->get_features) {
> >               epc_features =3D ep->ops->get_features(ep);
> > @@ -813,7 +872,11 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> >  err_remove_edma:
> >       dw_pcie_edma_remove(pci);
> >
> > -err_free_epc_mem:
> > +err_free_epc_mem_intx:
> > +     if (ep->intx_mem)
> > +             pci_epc_mem_free_addr(epc, ep->intx_mem_phys, ep-
> >intx_mem,
> > +                                   epc->mem->window.page_size);
> > +
> >       pci_epc_mem_free_addr(epc, ep->msi_mem_phys, ep->msi_mem,
> >                             epc->mem->window.page_size);
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h
> b/drivers/pci/controller/dwc/pcie-designware.h
> > index 954d504890a1..8c08159ea08e 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -369,6 +369,8 @@ struct dw_pcie_ep {
> >       unsigned long           *ob_window_map;
> >       void __iomem            *msi_mem;
> >       phys_addr_t             msi_mem_phys;
> > +     void __iomem            *intx_mem;
> > +     phys_addr_t             intx_mem_phys;
> >       struct pci_epf_bar      *epf_bar[PCI_STD_NUM_BARS];
> >  };
> >
> > --
> > 2.25.1
> >
