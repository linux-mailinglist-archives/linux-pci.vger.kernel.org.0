Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80E754AFB4
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jun 2022 13:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242960AbiFNL64 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jun 2022 07:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242172AbiFNL64 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jun 2022 07:58:56 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2118.outbound.protection.outlook.com [40.107.114.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884E241339;
        Tue, 14 Jun 2022 04:58:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X6oJQTWyM+e71NqeMZpUMlR6EvNKcW4dW2wDflxwA/+0SDJwI3T037bnxlRJNEcgsOofAdP7RcS1kkigeldXBYTNKSuhAxr4FFzHJ+EeJumy/Fwzeyt3Ka8kGzLv8ETlsvcOVRBT6UMAk70t45CuvxpAfe+FkDB7uZmzIv6NsL7IJL4v68mvI12XdygXzRjKpfSRcZL68RA4JhvEQodXWCrK+LpuDiGhXrIxtKVYF9dPqFjs5q9lqF4o91cfv7vJVHtNNh2o9LeacNlmnCDImmOSWLB7x9MrEa1CsSMWT9yhOcjG6WJteVHy8/Uows5CvZmqnP58T+PGXeChQUXp5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8HubjVFl5C+SMBleRV4uf4cX2piSnJ1/waBoXqm7x7Q=;
 b=ARrbxWR+olHZR6JBLcN1N6dngEso/6/KYNc0TP6mIm5MBTEkl8nkZgFiJJ0n3TVb3ld1Jpb9WKDU58JdZXnRPce6/9LjKnB3ExQ+Prb03VTtcIFbIXvR65Z3Jgv+ZGK+U2utCY7KDA/Rtz22GXkMsSv3ABQyf2WAJwjtpmt0WraRUISNmOYAcGz5mCgGpl33qn1XpeIF3IXvGnH5bweyymq4Iw1P7IP3tJ0TqsYmrsAplIw8HIHUoAUkpTjN9WqeovPKWiPlYX/JpH3Vkjv3L3lbR6NftcGkjpNimF6jp/KeMU7JIuyiiYIQee1T9p8PrfucFnp80M2I9Giz01lEug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HubjVFl5C+SMBleRV4uf4cX2piSnJ1/waBoXqm7x7Q=;
 b=TAnPxaHpO8OPRxSokScQGjYszosJEJgwVwynRo0z5xfrJjZOhZqRqTE2KLZ8j2aMQf1kU0+egyPwpC2YHoLn6tLBGh+vgekjRNcpj2tbezgxNjrM5lWwYI1WycDHjkTv/g+88x3DTv6T+PeykI9+GyRQFU3qJGKNChC3MgBy9jo=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by OSBPR01MB2535.jpnprd01.prod.outlook.com
 (2603:1096:604:22::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15; Tue, 14 Jun
 2022 11:58:47 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::b596:754d:e595:bb2d]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::b596:754d:e595:bb2d%5]) with mapi id 15.20.5332.022; Tue, 14 Jun 2022
 11:58:47 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Rob Herring <robh@kernel.org>
CC:     "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
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
Subject: RE: [PATCH 4/7] PCI: renesas: Add R-Car Gen4 PCIe Endpoint support
Thread-Topic: [PATCH 4/7] PCI: renesas: Add R-Car Gen4 PCIe Endpoint support
Thread-Index: AQHYfxy+kAG60IrpCEyuzD/Dk9T4Fa1N4QiAgADjo1A=
Date:   Tue, 14 Jun 2022 11:58:46 +0000
Message-ID: <TYBPR01MB5341FFE04E29E43772683A90D8AA9@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20220613115712.2831386-1-yoshihiro.shimoda.uh@renesas.com>
 <20220613115712.2831386-5-yoshihiro.shimoda.uh@renesas.com>
 <20220613215043.GB87830-robh@kernel.org>
In-Reply-To: <20220613215043.GB87830-robh@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6e3f8600-ca3f-4c94-4649-08da4dfd3cea
x-ms-traffictypediagnostic: OSBPR01MB2535:EE_
x-microsoft-antispam-prvs: <OSBPR01MB2535A6B35FB3F776D22E4BAAD8AA9@OSBPR01MB2535.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tncwWil1oomeWOuwTWiTaqpBrKarFMRcogLYi3ohA59zPpbmCypcPFDPIhxOmqW5c2pKh72TiwmEPGL1eCJEQs/zMYuphvtF+c5b6chg7jxx16dA4haQ8Z2INd1vmjFtqaysv3Jcn6BoKs5eWz12cpQDk8FY30hAFisFLmOz4Auqe4BaKKAFbn2UVHfkLZh5C0kxbXFXKCv1LcVk0qocTti3V92jHJsR8AKZt9NgbEQqv2xX9SWYAcX64m9Uo8R6NnxlmZONnv6YH4T/JnWUYW5U6UmszB8si6gJTiDIcr5n4eEHODeDg+T6ACOs/A+8Hyswt8uy5sprZAjtfI/L2D7zYMRFTCJJ627d4MyndNuZVa8rAZ4AEqZxb2itQSD4FK0xonG48crTZu8dB/TCLcaH+ORZ+00Hu277UIvvOOVTc6Kl/EJdqNLfKywuh+mOVY48eCaj3639jV0xAh37+YWOBAsJZxHhu5Vnr2/mS/3U65IO8AO0TmcqkGyRkQ5X67+s8yFnAS+7TxQ1RMJCaZo6lANE4Bn/uCKM529WNhBJmF3gGEv9KLZxFZ//F81DkYzosHfhWIWOSGJgX7geHVVY8wUSH9xPeuVW/rgZDX17DTbDeM0lLHi2VLxr/YzWoeOjdBxsnncyMhR11ONhHRdqEi8drhQatncrZlQfjz0RLNAaNn1TPNZHI6by37HPNQHyIcgUjNznfiKj+Rg77Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(38070700005)(122000001)(71200400001)(2906002)(8676002)(86362001)(8936002)(186003)(66476007)(66446008)(508600001)(4326008)(55016003)(6916009)(76116006)(66556008)(64756008)(66946007)(9686003)(316002)(6506007)(7696005)(38100700002)(54906003)(52536014)(5660300002)(7416002)(83380400001)(33656002)(30864003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bS14RzzlYHJUUbyyhji4v8bv8k5Pe1X2QbclxpnfvKmFD3ZU5CLRjhxjHp6e?=
 =?us-ascii?Q?7YenlGNlvnnfZzErGdbCsryOIgTtiGfeFDO3BOjTieTfbxbatM2PrwNlW1HG?=
 =?us-ascii?Q?rKpCw0snl7DoRZEoMBkwUOwQRrX5x7/BTbN2oNS2JP9T2K3l4L2XNla2q2vo?=
 =?us-ascii?Q?20Gc4PleSQ/zvU/2LrivlqmRjwWrI40UbQpgBIjc88CBOnaDnMpauBzoB1wF?=
 =?us-ascii?Q?SLFHb05Gu77qTQ+OPtBqMUQU5m4UfXirv0eeWiCXeEp+lPXP5jf6HZ+TZCnR?=
 =?us-ascii?Q?lrgbAGFCOSXFI0lZv/eHkGn+hmpZDJpzDsklMcU9egtqVDN95+wJX7No7djU?=
 =?us-ascii?Q?PwcL5OOUIEjA26TQ9MSnfZ4ZwUHM3d4r3WZ3wMX30/Akl73yqkCGKi8reaPt?=
 =?us-ascii?Q?3u+8DsV9eiIPRVC5VN+LX2WIAX6ufae+zmzzTRyyd1Jd9vna8anR/i2OLJ0r?=
 =?us-ascii?Q?+7piM1ykbwQgciDcxYVTMFyXQvDREEMC/ysK81Ihzx6vPym/2Wp3xcP+Pjm7?=
 =?us-ascii?Q?TbONzTaBCzHsm/byo9im51DX9qYk8LKPGhs6hDZtPlx1pW+JoxCzspk9e+UU?=
 =?us-ascii?Q?7AGRKeM8FbqV+GG6WpUx4HTVewt3K+Zfe6Y6Y7AUlHgG8DMQVQ5PKFvNxEON?=
 =?us-ascii?Q?2qni50yd7pkP8FVgYQkV2brH3ffdVc/2lt5kv+gy2eXfNhiq/bIRkeNy8F21?=
 =?us-ascii?Q?fGxxlvpn5jyRX4Rl3mCq4UTHgtx3gHJiHOtXoczu0jBYpzBgqGfzSEPssuza?=
 =?us-ascii?Q?1Lt+x6grrnY+BnO79A8VwbMnSIdrmiIRbdw+5LsJAcJVa+3ZHj1SSb03Fgzt?=
 =?us-ascii?Q?DnTM++UQb/cSWL8NkCO6C/YzDff7r71pyv7zO2s3RMjubySXfzBBD3HSWy0M?=
 =?us-ascii?Q?Irp6lz7ZdX1mw2RtjLDUQAHnvQ6a+ivbCuO65g2bA3R1FzjqfRfb8giJBYbu?=
 =?us-ascii?Q?jgfmbdiKupV7LoBW9rxROA0vcPJ9d4Jyy4Zxe2YmvUEz+dVTNezL3mEswsfc?=
 =?us-ascii?Q?yn4CHBOyRBv9akTO+XWGnwFY1EyEZxGWpQQ4CtRU8C9cblr71+qTriOJRhpd?=
 =?us-ascii?Q?Oa1ZohULLtyrsXEvh6S7T1cOgwYPZNMFNvcZZkRXypfRk4ZUya5WZnAwAQFp?=
 =?us-ascii?Q?NsIss3cvw0Y1ngYiQCfYNm7h2CoqLbNROllEY0fVEV4b+pTtCzVuCAelUF3T?=
 =?us-ascii?Q?y2TCPGHBqVgpThf1IpBFuispAqUBrdnUaIdsL5OVRBWB3k9aeIivMEN78+pe?=
 =?us-ascii?Q?fP1JJBMuJ6C0abWdxCx21ICQEixHc03FPPiN3E7vFLPlrfJzcMlHWKqwbML1?=
 =?us-ascii?Q?54VJQkN63RereasgM3z5IiOa8r7pJ7ZYOsf+ZWhba/QOhOrAoWntD47+umbX?=
 =?us-ascii?Q?t6ns+TYa+d2dB9v94ABMDhMQQN8JOjazfwL7jBq9MqnwWifkQruTGhmMnuc0?=
 =?us-ascii?Q?4AwRcUXk8k9vC8c3y01D4pDElVkauySPkkW4uTsRxWPLqAMJy70NupfyxSDK?=
 =?us-ascii?Q?8OknWcBT4oOSzjLWmtJF112UdmVEKf7O2bNC7Kto/eha4Io9zsrZNLAoo2Gj?=
 =?us-ascii?Q?YtrfQ6ciCZFcav4J8+HAg7/ESSPbuErebLYTW51TK80JS9dcWRW99TyTV3RL?=
 =?us-ascii?Q?GG3njI+k8wDGISKabM03F8xSj/X+01XMlWxd08VlkiTSIcXDUHL0NvSnFwH6?=
 =?us-ascii?Q?xsOpC1Rx6II/8F8GOJmELu/mW9R6WXTAmJAq1VitY5PWofUChuNIYJ7i8FSS?=
 =?us-ascii?Q?IzVte3oG5FIyl67wr+5KsQpDkSgquFjLSwx/IK8ZSd2hr7yUBdQhLr6eVk9D?=
x-ms-exchange-antispam-messagedata-1: xbiG3hBhi9LAPEJeSCBmSakyjIgYkdTEGSI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e3f8600-ca3f-4c94-4649-08da4dfd3cea
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2022 11:58:47.0085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u4hzEqIeLOpzoAUbloWdq22GyfmpeshMd9SUqZ04KOiOsrZ25Q61ucC9UecQcpqD2I5wAJZ8BqCWUFhmm0JBUgIoDaNe/4SkdBqXUCZRGK7AtI9CkAI/tEvU4crcXI91
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

Hi Rob,

Thank you for your review!

> From: Rob Herring, Sent: Tuesday, June 14, 2022 6:51 AM
>=20
> On Mon, Jun 13, 2022 at 08:57:09PM +0900, Yoshihiro Shimoda wrote:
> > Add R-Car Gen4 PCIe Endpoint support. This controller is based on
> > Synopsys Designware PCIe.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> >  drivers/pci/controller/dwc/Kconfig            |   9 +
> >  drivers/pci/controller/dwc/Makefile           |   1 +
> >  .../pci/controller/dwc/pcie-rcar-gen4-ep.c    | 253 ++++++++++++++++++
> >  drivers/pci/controller/dwc/pcie-rcar-gen4.h   |   1 +
> >  4 files changed, 264 insertions(+)
> >  create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4-ep.c
> >
> > diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controlle=
r/dwc/Kconfig
> > index 3ddccc9c38c5..503ead1a4358 100644
> > --- a/drivers/pci/controller/dwc/Kconfig
> > +++ b/drivers/pci/controller/dwc/Kconfig
> > @@ -393,4 +393,13 @@ config PCIE_RCAR_GEN4
> >  	  Say Y here if you want PCIe host controller support on R-Car Gen4 S=
oCs.
> >  	  This uses the DesignWare core.
> >
> > +config PCIE_RCAR_GEN4_EP
> > +	bool "Renesas R-Car Gen4 PCIe Endpoint controller"
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
> > index b3f285e685f9..3d40346efd27 100644
> > --- a/drivers/pci/controller/dwc/Makefile
> > +++ b/drivers/pci/controller/dwc/Makefile
> > @@ -26,6 +26,7 @@ obj-$(CONFIG_PCIE_UNIPHIER) +=3D pcie-uniphier.o
> >  obj-$(CONFIG_PCIE_UNIPHIER_EP) +=3D pcie-uniphier-ep.o
> >  obj-$(CONFIG_PCIE_VISCONTI_HOST) +=3D pcie-visconti.o
> >  obj-$(CONFIG_PCIE_RCAR_GEN4) +=3D pcie-rcar-gen4.o pcie-rcar-gen4-host=
.o
> > +obj-$(CONFIG_PCIE_RCAR_GEN4_EP) +=3D pcie-rcar-gen4.o pcie-rcar-gen4-e=
p.o
> >
> >  # The following drivers are for devices that use the generic ACPI
> >  # pci_root.c driver but don't support standard ECAM config access.
> > diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4-ep.c b/drivers/p=
ci/controller/dwc/pcie-rcar-gen4-ep.c
> > new file mode 100644
> > index 000000000000..622e32c7a410
> > --- /dev/null
> > +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4-ep.c
> > @@ -0,0 +1,253 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * PCIe Endpoint driver for Renesas R-Car Gen4 Series SoCs
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
> > +/* Configuration */
> > +#define PCICONF3		0x000c
> > +#define  MULTI_FUNC		BIT(23)
> > +
> > +struct rcar_gen4_pcie_ep {
> > +	struct rcar_gen4_pcie	*pcie;
> > +	struct dw_pcie		*pci;
>=20
> Would be better if these are embedded structs rather than pointers. Then
> it is 1 alloc. Also, 'pci' and 'pcie' aren't very clear. rcar_pcie and
> pcie perhaps. Or rcar and dw.

I got it. I'll fix them.

> > +	u32			num_lanes;
>=20
> What's wrong with dw_pcie.num_lanes?

The dw_pcie.num_lanes is set after dw_pcie_ep_init() succeeded.
However, this driver would like to refer the num_lanes before dw_pcie_ep_in=
it()
to initialize vendor-specific registers. In other words, this value is only
needed at that timing. So, we can remove this from struct rcar_gen4_pcie_ep=
,
and just get the num_lanes as a local variable.

> > +};
> > +
> > +static void rcar_gen4_pcie_ep_init(struct dw_pcie_ep *ep)
> > +{
> > +	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> > +	enum pci_barno bar;
> > +
> > +	for (bar =3D BAR_0; bar <=3D BAR_5; bar++)
> > +		dw_pcie_ep_reset_bar(pci, bar);
>=20
> Seems like the core code should be doing this.

I think so. I'll add such a function into the core core.

> > +}
> > +
> > +static int rcar_gen4_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_=
no,
> > +				       enum pci_epc_irq_type type,
> > +				       u16 interrupt_num)
> > +{
> > +	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> > +
> > +	switch (type) {
> > +	case PCI_EPC_IRQ_LEGACY:
> > +		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
> > +	case PCI_EPC_IRQ_MSI:
> > +		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
> > +	case PCI_EPC_IRQ_MSIX:
> > +		return dw_pcie_ep_raise_msix_irq(ep, func_no, interrupt_num);
> > +	default:
> > +		dev_err(pci->dev, "UNKNOWN IRQ type\n");
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
>=20
> If this is false, why do you call dw_pcie_ep_raise_msix_irq?

Oops. I'll remove dw_pcie_ep_raise_msix_irq() calling.

> > +	.align =3D SZ_1M,
> > +};
> > +
> > +static const struct pci_epc_features*
> > +rcar_gen4_pcie_ep_get_features(struct dw_pcie_ep *ep)
> > +{
> > +	return &rcar_gen4_pcie_epc_features;
> > +}
> > +
> > +static const struct dw_pcie_ep_ops pcie_ep_ops =3D {
> > +	.ep_init =3D rcar_gen4_pcie_ep_init,
> > +	.raise_irq =3D rcar_gen4_pcie_ep_raise_irq,
> > +	.get_features =3D rcar_gen4_pcie_ep_get_features,
> > +};
> > +
> > +static int rcar_gen4_add_pcie_ep(struct rcar_gen4_pcie_ep *pcie_ep,
> > +			       struct platform_device *pdev)
> > +{
> > +	struct rcar_gen4_pcie *pcie =3D pcie_ep->pcie;
> > +	struct dw_pcie *pci =3D pcie->pci;
> > +	struct dw_pcie_ep *ep;
> > +	struct resource *res;
> > +	int ret;
> > +
> > +	ep =3D &pci->ep;
> > +	ep->ops =3D &pcie_ep_ops;
> > +
> > +	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "addr_spac=
e");
> > +	if (!res)
> > +		return -EINVAL;
>=20
> Common code handles this.

Yes. I think this driver should use common code somehow.

> > +
> > +	ep->addr_size =3D resource_size(res);
> > +
> > +	ret =3D dw_pcie_ep_init(ep);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "failed to initialize endpoint\n");
> > +		return ret;
> > +	}
> > +
> > +	pci->ops->start_link(pci);
> > +
> > +	return 0;
> > +}
> > +
> > +static void rcar_gen4_remove_pcie_ep(struct rcar_gen4_pcie_ep *pcie_ep=
)
> > +{
> > +	dw_pcie_ep_exit(&pcie_ep->pcie->pci->ep);
> > +}
> > +
> > +static void rcar_gen4_pcie_init_ep(struct rcar_gen4_pcie_ep *pcie_ep)
> > +{
> > +	struct rcar_gen4_pcie *pcie =3D pcie_ep->pcie;
> > +	struct dw_pcie *pci =3D pcie->pci;
> > +	int val;
> > +
> > +	/* Device type selection - Endpoint */
> > +	val =3D rcar_gen4_pcie_readl(pcie, PCIEMSR0);
> > +	val |=3D DEVICE_TYPE_EP;
> > +	if (pcie_ep->num_lanes < 4)
> > +		val |=3D BIFUR_MOD_SET_ON;
> > +	rcar_gen4_pcie_writel(pcie, PCIEMSR0, val);
> > +
> > +	dw_pcie_dbi_ro_wr_en(pci);
> > +
> > +	/* Single function */
> > +	val =3D dw_pcie_readl_dbi(pci, PCICONF3);
> > +	val &=3D ~MULTI_FUNC;
> > +	dw_pcie_writel_dbi(pci, PCICONF3, val);
>=20
> Common DWC reg/bit? If so, belongs in common header.

This seems PCIe specific register/bit. However, according
to the datasheet of this controller, the register/bit is a
read-only register. So, I'll drop this if it's true.

> > +
> > +	/* Disable unused BARs */
> > +	dw_pcie_writel_dbi(pci, SHADOW_REG(BAR2MASKF), 0x0);
> > +	dw_pcie_writel_dbi(pci, SHADOW_REG(BAR3MASKF), 0x0);
>=20
> Seems like something the common code should do.

I got it.

> > +
> > +	/* Set Max Link Width */
> > +	rcar_gen4_pcie_set_max_link_width(pci, pcie_ep->num_lanes);
> > +
> > +	dw_pcie_dbi_ro_wr_dis(pci);
> > +}
> > +
> > +static int rcar_gen4_pcie_ep_get_resources(struct rcar_gen4_pcie_ep *p=
cie_ep,
> > +					   struct platform_device *pdev)
> > +{
> > +	struct rcar_gen4_pcie *pcie =3D pcie_ep->pcie;
> > +	struct dw_pcie *pci =3D pcie->pci;
> > +	struct device *dev =3D pci->dev;
> > +	struct device_node *np =3D dev->of_node;
> > +	struct resource *res;
> > +	int err;
> > +
> > +	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
> > +	pci->dbi_base =3D devm_pci_remap_cfg_resource(dev, res);
> > +	if (IS_ERR(pci->dbi_base))
> > +		return PTR_ERR(pci->dbi_base);
> > +
> > +	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "atu");
> > +	pci->atu_base =3D devm_ioremap_resource(dev, res);
> > +	if (IS_ERR(pci->atu_base))
> > +		return PTR_ERR(pci->atu_base);
>=20
> The common code handles these resources.

You're correct. I'll use common code somehow.

> > +
> > +	/* Renesas-specific registers */
> > +	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "appl");
> > +	pcie->base =3D devm_ioremap_resource(dev, res);
> > +	if (IS_ERR(pcie->base))
> > +		return PTR_ERR(pcie->base);
> > +
> > +	err =3D of_property_read_u32(np, "num-lanes", &pcie_ep->num_lanes);
>=20
> Common code does this too. Lots of duplication! Please check. If it's
> something every DW controller has or might have, then the code for it
> belongs in the common code.

My headache point is common code will handle both 1) getting resources
and 2) DWC common part registers initialization, but this controller
requires vendor specification at first. So, I'll modify the common code
somehow.

> > +	if (err < 0) {
> > +		dev_err(dev, "num-lanes not found %d\n", err);
> > +		return err;
> > +	}
> > +
> > +	return rcar_gen4_pcie_devm_clk_and_reset_get(pcie, dev);
> > +}
> > +
> > +static int rcar_gen4_pcie_ep_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev =3D &pdev->dev;
> > +	struct rcar_gen4_pcie_ep *pcie_ep;
> > +	struct rcar_gen4_pcie *pcie;
> > +	int err;
> > +
> > +	pcie_ep =3D devm_kzalloc(dev, sizeof(*pcie_ep), GFP_KERNEL);
> > +	if (!pcie_ep)
> > +		return -ENOMEM;
> > +
> > +	pcie =3D rcar_gen4_pcie_devm_alloc(dev);
> > +	if (!pcie)
> > +		return -ENOMEM;
> > +	pcie_ep->pcie =3D pcie;
> > +
> > +	err =3D rcar_gen4_pcie_pm_runtime_enable(dev);
> > +	if (err < 0) {
> > +		dev_err(dev, "pm_runtime_get_sync failed\n");
> > +		return err;
> > +	}
> > +
> > +	err =3D rcar_gen4_pcie_ep_get_resources(pcie_ep, pdev);
> > +	if (err < 0) {
> > +		dev_err(dev, "failed to request resource: %d\n", err);
> > +		goto err_pm_put;
> > +	}
> > +
> > +	pcie->priv =3D pcie_ep;
> > +	platform_set_drvdata(pdev, pcie);
> > +
> > +	err =3D rcar_gen4_pcie_prepare(pcie);
> > +	if (err < 0)
> > +		goto err_pm_put;
> > +	rcar_gen4_pcie_init_ep(pcie_ep);
> > +
> > +	err =3D rcar_gen4_add_pcie_ep(pcie_ep, pdev);
> > +	if (err < 0)
> > +		goto err_ep_disable;
> > +
> > +	return 0;
> > +
> > +err_ep_disable:
> > +	rcar_gen4_pcie_unprepare(pcie);
> > +
> > +err_pm_put:
> > +	rcar_gen4_pcie_pm_runtime_disable(dev);
> > +
> > +	return err;
> > +}
> > +
> > +static int rcar_gen4_pcie_ep_remove(struct platform_device *pdev)
> > +{
> > +	struct rcar_gen4_pcie *pcie =3D platform_get_drvdata(pdev);
> > +	struct rcar_gen4_pcie_ep *pcie_ep =3D pcie->priv;
> > +
> > +	rcar_gen4_remove_pcie_ep(pcie_ep);
> > +	rcar_gen4_pcie_unprepare(pcie_ep->pcie);
> > +	rcar_gen4_pcie_pm_runtime_disable(&pdev->dev);
> > +
> > +	return 0;
> > +}
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
> > +	.remove =3D rcar_gen4_pcie_ep_remove,
> > +};
> > +builtin_platform_driver(rcar_gen4_pcie_ep_driver);
>=20
> Not a module or...
>=20
> > +
> > +MODULE_DESCRIPTION("Renesas R-Car Gen4 PCIe endpoint controller driver=
");
> > +MODULE_LICENSE("GPL v2");
>=20
> A module? Should be a module if possible.

Oops. I'll drop these MODULE_*.

Best regards,
Yoshihiro Shimoda

> > diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.h b/drivers/pci/=
controller/dwc/pcie-rcar-gen4.h
> > index bd01d0ffcac9..b6e285d8ebc0 100644
> > --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.h
> > +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.h
> > @@ -43,6 +43,7 @@ struct rcar_gen4_pcie {
> >  	void __iomem		*base;
> >  	struct clk		*bus_clk;
> >  	struct reset_control	*rst;
> > +	void			*priv;
> >  };
> >
> >  extern u32 rcar_gen4_pcie_readl(struct rcar_gen4_pcie *pcie, u32 reg);
> > --
> > 2.25.1
> >
