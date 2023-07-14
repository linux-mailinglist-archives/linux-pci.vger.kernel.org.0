Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA176752F52
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jul 2023 04:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233484AbjGNCWA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jul 2023 22:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbjGNCV7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jul 2023 22:21:59 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2111.outbound.protection.outlook.com [40.107.113.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E4E270B;
        Thu, 13 Jul 2023 19:21:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E2Md3sz6juOKx2n/Y/AFwOs2wtPfCIj9xT6U6y9Dq+0HX1G0/XdjdXVKghDP+AjelzSRqfBFrwZB4y38JGsJ+UrCAAIbgUUO1PHBPLxNx6lkRNtWktvlCT98HDoPjpbxJgTcLY1sreALa2pUoGjSiHVsXz0m/+PoHM6zdVeditujVWFfAIZUmeWW1I84yURH9W3gFjsXAqMRAMM+xVnVRyQMXk28Rf5fX2nwLCvBZ2YenQZQyQSniCxHGlZVuys0dmw0k2Xx/cU7+oUy4L+bjy504hYASvpyX7iBNqCw5TzFZC+mTEJEb5H1bLWC2TeO3UxcOus5dvaDWHxuOV6UcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ILisSXfLkX769se+/oU3qPWzIXWbUcXcMzUTfMbacM=;
 b=mhgH3y6hkfnoEzQ195i4bBZko+ydF69y9iVOUm8friPIkM6uqXRn3Foy/Temgc73Ju799C/op1OIUD6zCshd+l7BVjODTMETOkjfk/z1kFyEDTB9cKtbVzCSEt3VYEptxS5SKpyAt4Rn3QMwEwq44kf8v4A4AjhVw1zxRn1e0YBMs8HcR1wqKnbHJf6LGgrKvrgb+/nvofL47GoxQkjEyzpqdednRs4r71cb1/+uhhWojUr9hzHVxdDCnBNyYrmY8NVZH3/A3qrogw+FHN6ZfCN/VO604hAnijgGrnecpY6p1e/Ofc1Wh/WxPnN3pEL21aXAyGCpbiU8iwQ4PDfA0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ILisSXfLkX769se+/oU3qPWzIXWbUcXcMzUTfMbacM=;
 b=WDeFLFgyHYRAOadSp3CpNBoO4gb8QYQ53fhZBfx5bf+ODs2hf0VZl8yu/hBiWoR+FxakRvEK8YN38nt8IgAFxvKmmhZLJIUgHAFbkyxzi7ArI+RGTBHNeqcCg7ID+rqt0W3/qW9i3dfbDokqSACrvoxoynDQdTVQWbh7zqJZFNQ=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TY3PR01MB10956.jpnprd01.prod.outlook.com
 (2603:1096:400:3b0::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.26; Fri, 14 Jul
 2023 02:21:53 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::4aa4:531b:e63:3d61]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::4aa4:531b:e63:3d61%2]) with mapi id 15.20.6588.017; Fri, 14 Jul 2023
 02:21:53 +0000
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
Subject: RE: [PATCH v17 17/20] PCI: rcar-gen4: Add R-Car Gen4 PCIe Host
 support
Thread-Topic: [PATCH v17 17/20] PCI: rcar-gen4: Add R-Car Gen4 PCIe Host
 support
Thread-Index: AQHZrzZOyJvJjvMNPUaddw2awLuRRq+2C3KAgAKHu2A=
Date:   Fri, 14 Jul 2023 02:21:52 +0000
Message-ID: <TYBPR01MB53416364686C6437CE85A97CD834A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230705114206.3585188-1-yoshihiro.shimoda.uh@renesas.com>
 <20230705114206.3585188-18-yoshihiro.shimoda.uh@renesas.com>
 <knx6kir3ulvc25u6qcxoyxwwpbtcnjfpuigjnsjhtwe47q245m@gdce3voh73k5>
In-Reply-To: <knx6kir3ulvc25u6qcxoyxwwpbtcnjfpuigjnsjhtwe47q245m@gdce3voh73k5>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TY3PR01MB10956:EE_
x-ms-office365-filtering-correlation-id: 261466be-c9d4-4b12-d53c-08db8411168e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pHXdnV5DhzTAWN+WC2urseE1XRn6ddUTeRsxDFj8jg2+9OLauufo1fv8pNBVHWWBK1Gjnfci1tNIGuecsH6QBXDjHfhA4kNWus5AyBwyu4+fATRLwo7JFo0TKnXlZJiJFqyHqNHXGMAaLW0655d8mF1tMyDvqfuKOWW/fgH3AqOcEwFiCjkkvBibTxGdce9UmK+5NX7zZ5NKi0W0h45JcJ3X7wolrrDWzR6o5PKthNyjrRZtQnYjJLB6Y0GirB2RXhECwwNsrWUNOzjNCYq8In9CU/1ecnkLmjyi+lI+wvpASlOq/ngHy5s0O3PlVge8lwOexCuh5mgTj4Z7eQiXPxPT6TrES/cobqlZhBeCURNGp8c9dkmaDyyNsaBtuFtwuay3otn8C7rtTu58AeLY2Qp0bqY8GO+dpvgUj3P0LGnRj5QfkVaDh9Zdb2GjNxScaDRvQDW8Iy8UCnDCCQyMJFUPEd/+d5rbFdOQFMnc/uF5J+QU8CSaS/BaAUqtsu05BmvDxPQyp1sbjs/7PNTSwN7jUigKv1u+tys2St99JzJRnZp1CaflEz3kXBIpH4OVO2YvzYg/IbqQEsElP+EC5Su8vQ2j650c4oXRGT4ZG572hjhfkxVag4Zvtsr6VXkX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(366004)(39860400002)(396003)(346002)(451199021)(478600001)(6506007)(9686003)(55016003)(7696005)(71200400001)(8676002)(8936002)(33656002)(83380400001)(38070700005)(7416002)(5660300002)(52536014)(316002)(41300700001)(66556008)(86362001)(30864003)(2906002)(122000001)(186003)(38100700002)(64756008)(66446008)(66476007)(66946007)(4326008)(6916009)(76116006)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vJJREDB1lH1HX1HbrrR4NXHQ+TOXhJo2dgm3r8a85UxTYxAeASOCe6AnaAY7?=
 =?us-ascii?Q?sxIkKcHBrGjJ9pHv8hnYqzRt4IJHyjPbFiTa/ngwzLb8VumgqG12Ed1iwR9o?=
 =?us-ascii?Q?QhPE1Qr92wOPOdhPvPsEAj33YY4ivBnnmIdYkXdspeC8PBmrXg2RTtZfjHAm?=
 =?us-ascii?Q?2c7NiO5Af89O2PyIXW2pXlTBxKUpNC+qGR71nA4QDj63CmWoAjXXd97rNGAf?=
 =?us-ascii?Q?Qxe6seCOR7HzdLiAEMGVykq2XSWjXiwPu4PCSDhIza5FErE2PYaqtyoIKgYv?=
 =?us-ascii?Q?Op5hFbTDpd266ndA3WsCAv9Fyc9AdkRjHTI3CBQ7A76YcI+/kmo18kOcJiGR?=
 =?us-ascii?Q?6XRxQxh7fWuWut6zzH6hvIDcsfc9vXsukjAYkbq3ouedKgn5x3+vijuMV/VV?=
 =?us-ascii?Q?3Q85k1t+SXZ2Lw5i7oZluo9mxVyxbZ8iQ6p7r8HZDdk4u+mEd5y77Hk5NHuI?=
 =?us-ascii?Q?9OV+Uco4L1qwEuya/mCR56DnagLtBSKsnNPdDP/YOzJPHy3Udc8iDbOrP8Ml?=
 =?us-ascii?Q?R1Ag6Rvw7h72y3AIVe0Wt7pCUdfVIoixYgnes6j3yp0ftUFxKjP80BmtqGLj?=
 =?us-ascii?Q?+sUPnq4/vlr65VA0Oshi8KKZ0/OWP541RwrylyKjk80aS8W/oOsgyZwqeydk?=
 =?us-ascii?Q?+4Wm5vmJfIMBfzpgt3BKZL+4ZuPijM/OkPfrXQa75YvqeQyWdREVr629bz74?=
 =?us-ascii?Q?I5/iqvgh0Xc/HgsTviaowUB8F88l55wRcDZVFpBHhl+0FPrE3ur9NBB/UEtQ?=
 =?us-ascii?Q?yBcmoqsFk0wfLoYU0inGPh/XJltJzJhQdrwP73ZNSxkjoW/kPhyIpKst37PV?=
 =?us-ascii?Q?aMr42P5OMTzfuxX1364AlXDaVsgVhnncrUzUzBIuub2EqV07/Pl6bBi2yBz3?=
 =?us-ascii?Q?g2boDHBv6UYPwuGkXB1aX/cmFXqfYP3T0vfVj3oxd/AUqz0GTcznkoq91uWz?=
 =?us-ascii?Q?l9bTZeatKXO0ayYjMBW+5nNH93/EfImnz9yi6w4wi7z6Ci8NShKGmlWwRvzi?=
 =?us-ascii?Q?7JdLMd2krmjS4jSsmX1zSB5a6g5sbCE8NANe6oE9TYjL/jBK7j14XlhxdyUe?=
 =?us-ascii?Q?tVES9XkkY6xIS+q5QBCL4JuCHdwL5kR6yn5b/S/zjVkNOmvDbTXpKL19dgcZ?=
 =?us-ascii?Q?+CR2RA6gSN3sGlbDLLGAWewCLZoya8qcNz7gXxUr4/9Oop4cOdds8aXYsxHi?=
 =?us-ascii?Q?8eEKf2Xmglmjj3W/YTFwO9MJW8ZhrhkMmpzsOfqy73sIyqw8kiNeyefFXtYh?=
 =?us-ascii?Q?l/2/9qL3Xuvu46gMICQ/eN6GcApI5B8zD9XrWikkAFgFgwKIo+A5Gji5IXdR?=
 =?us-ascii?Q?c7kM1Mg4YTRe+WmyixxG+Eod70o4a1xBgWsnHjJQM3AjXSJeoKk5P28Nl5Ol?=
 =?us-ascii?Q?tHoOnu3FvlcGYNDY/calsNFumbaCWaGB1+SCfrwFwKZ0zst9pP/ssVGOIwCI?=
 =?us-ascii?Q?KOBVyf62oif5Bj0hfu3veh+bQoO0AfuUIds0NKa8j79f8sNo6GiOu/0b6h5n?=
 =?us-ascii?Q?hEOIL8Gwm5AT2Nsan1Nqdj1lbuPeei9wbI+NVxO43NBDrk5aRTMm+8/6cPHT?=
 =?us-ascii?Q?hkchLtzU5jC/2+jOXimJj+03gGMm/c/Ga0hpqJoRdqZCdLW6F4tPscdgaoTo?=
 =?us-ascii?Q?Tf8KGIah8sDWVIt0BiNiBgThMtn8oUZNNY3uxIO404vnJexH3nLRkQTc6A4O?=
 =?us-ascii?Q?9gjqDg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 261466be-c9d4-4b12-d53c-08db8411168e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2023 02:21:53.0283
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UtjIAKtD+es8L+xVU+8jRj2I7SmiZFir7U6zlbKcsjHeaV/WHWWZMYVg77JHXh+0N82MwsVoOY5hAF3vW9uSqIh2sS3t6CL1++URvo1ASxlg1BWjD1sZY6yNBSHFN7r5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10956
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

> From: Serge Semin, Sent: Wednesday, July 12, 2023 8:35 PM
>=20
> On Wed, Jul 05, 2023 at 08:42:03PM +0900, Yoshihiro Shimoda wrote:
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
> >  drivers/pci/controller/dwc/Kconfig            |   9 +
> >  drivers/pci/controller/dwc/Makefile           |   2 +
> >  .../pci/controller/dwc/pcie-rcar-gen4-host.c  | 144 +++++++++++++
> >  drivers/pci/controller/dwc/pcie-rcar-gen4.c   | 197 ++++++++++++++++++
> >  drivers/pci/controller/dwc/pcie-rcar-gen4.h   |  43 ++++
> >  5 files changed, 395 insertions(+)
> >  create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4-host.c
> >  create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4.c
> >  create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4.h
> >
> > diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controlle=
r/dwc/Kconfig
> > index ab96da43e0c2..64d4d37bc891 100644
> > --- a/drivers/pci/controller/dwc/Kconfig
> > +++ b/drivers/pci/controller/dwc/Kconfig
> > @@ -415,4 +415,13 @@ config PCIE_VISCONTI_HOST
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
> > +	  This uses the DesignWare core.
> > +
> >  endmenu
> > diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controll=
er/dwc/Makefile
> > index bf5c311875a1..486cf706b53d 100644
> > --- a/drivers/pci/controller/dwc/Makefile
> > +++ b/drivers/pci/controller/dwc/Makefile
> > @@ -26,6 +26,8 @@ obj-$(CONFIG_PCIE_TEGRA194) +=3D pcie-tegra194.o
> >  obj-$(CONFIG_PCIE_UNIPHIER) +=3D pcie-uniphier.o
> >  obj-$(CONFIG_PCIE_UNIPHIER_EP) +=3D pcie-uniphier-ep.o
> >  obj-$(CONFIG_PCIE_VISCONTI_HOST) +=3D pcie-visconti.o
> > +pcie-rcar-gen4-host-drv-objs :=3D pcie-rcar-gen4.o pcie-rcar-gen4-host=
.o
> > +obj-$(CONFIG_PCIE_RCAR_GEN4) +=3D pcie-rcar-gen4-host-drv.o
> >
> >  # The following drivers are for devices that use the generic ACPI
> >  # pci_root.c driver but don't support standard ECAM config access.
> > diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4-host.c b/drivers=
/pci/controller/dwc/pcie-rcar-gen4-host.c
> > new file mode 100644
> > index 000000000000..e7c1eef792ec
> > --- /dev/null
> > +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4-host.c
> > @@ -0,0 +1,144 @@
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
> > +	ret =3D clk_bulk_prepare_enable(DW_PCIE_NUM_CORE_CLKS, dw->core_clks)=
;
> > +	if (ret) {
> > +		dev_err(dw->dev, "Failed to enable ref clocks\n");
> > +		return ret;
> > +	}
> > +
> > +	ret =3D rcar_gen4_pcie_basic_init(rcar);
> > +	if (ret < 0) {
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
> > +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> > +		/* Enable MSI interrupt signal */
> > +		val =3D readl(rcar->base + PCIEINTSTS0EN);
> > +		val |=3D MSI_CTRL_INT;
> > +		writel(val, rcar->base + PCIEINTSTS0EN);
> > +	}
> > +
> > +	msleep(100);	/* pe_rst requires 100msec delay */
> > +
> > +	gpiod_set_value_cansleep(dw->pe_rst, 0);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct dw_pcie_host_ops rcar_gen4_pcie_host_ops =3D {
> > +	.host_init =3D rcar_gen4_pcie_host_init,
> > +};
> > +
> > +static int rcar_gen4_add_dw_pcie_rp(struct rcar_gen4_pcie *rcar,
>=20
> > +				   struct platform_device *pdev)
>=20
> The argument is unused. What about dropping it?

You're correct. I'll drop it on v18.

> > +{
> > +	struct dw_pcie *dw =3D &rcar->dw;
> > +	struct dw_pcie_rp *pp =3D &dw->pp;
> > +
> > +	pp->num_vectors =3D MAX_MSI_IRQS;
> > +	pp->ops =3D &rcar_gen4_pcie_host_ops;
> > +
> > +	return dw_pcie_host_init(pp);
> > +}
> > +
> > +static void rcar_gen4_remove_dw_pcie_rp(struct rcar_gen4_pcie *rcar)
> > +{
> > +	dw_pcie_host_deinit(&rcar->dw.pp);
> > +	gpiod_set_value_cansleep(rcar->dw.pe_rst, 1);
> > +}
> > +
> > +static int rcar_gen4_pcie_probe(struct platform_device *pdev)
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
>=20
> > +	platform_set_drvdata(pdev, rcar);
>=20
> This could have been moved to rcar_gen4_pcie_devm_alloc(). But see my
> last comment first.

I think so.

> > +
> > +	err =3D rcar_gen4_pcie_prepare(rcar);
> > +	if (err < 0)
> > +		return err;
> > +
>=20
> > +	rcar->mode =3D DW_PCIE_RC_TYPE;
>=20
> What about moving this to the rcar_gen4_add_dw_pcie_rp() method? Thus
> it will look similar to the rcar_gen4_add_pcie_ep() method you
> implemented in the Rcar Gen4 EP driver.

Yes. I'll move this to the rcar_gen4_add_dw_pcie_rp().

> > +	err =3D rcar_gen4_add_dw_pcie_rp(rcar, pdev);
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
> > +static int rcar_gen4_pcie_remove(struct platform_device *pdev)
> > +{
> > +	struct rcar_gen4_pcie *rcar =3D platform_get_drvdata(pdev);
> > +
> > +	rcar_gen4_remove_dw_pcie_rp(rcar);
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
> > +	{ .compatible =3D "renesas,rcar-gen4-pcie", },
> > +	{},
> > +};
> > +
> > +static struct platform_driver rcar_gen4_pcie_driver =3D {
> > +	.driver =3D {
> > +		.name =3D "pcie-rcar-gen4",
> > +		.of_match_table =3D rcar_gen4_pcie_of_match,
> > +		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> > +	},
> > +	.probe =3D rcar_gen4_pcie_probe,
>=20
> > +	.remove =3D rcar_gen4_pcie_remove,
>=20
> ditto

I'll fix this.

> > +};
> > +module_platform_driver(rcar_gen4_pcie_driver);
> > +
> > +MODULE_DESCRIPTION("Renesas R-Car Gen4 PCIe host controller driver");
> > +MODULE_LICENSE("GPL");
> > diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/=
controller/dwc/pcie-rcar-gen4.c
> > new file mode 100644
> > index 000000000000..2cd5c17c1695
> > --- /dev/null
> > +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> > @@ -0,0 +1,197 @@
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
> > +#define  APP_HOLD_PHY_RST	BIT(16)
> > +#define  APP_LTSSM_ENABLE	BIT(0)
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
> > +static int rcar_gen4_pcie_start_link(struct dw_pcie *dw)
> > +{
> > +	struct rcar_gen4_pcie *rcar =3D to_rcar_gen4_pcie(dw);
> > +	int i, changes;
> > +
> > +	rcar_gen4_pcie_ltssm_enable(rcar, true);
> > +
> > +	/*
> > +	 * Require direct speed change with retrying here if the link_gen is
>=20
> > +	 * PCIe Gen2 or later.
>=20
> s/later/higher

I'll fix this.

> > +	 */
> > +	changes =3D min_not_zero(dw->link_gen, RCAR_MAX_LINK_SPEED) - 1;
> > +
> > +	/*
> > +	 * Since dw_pcie_setup_rc() sets it once, PCIe Gen2 will be trained.
>=20
> > +	 * So, this needs remaining times for PCIe Gen4 if RC mode.
>=20
> For "_up to_ PCIe Gen4", isn't it? Because AFAIR PCIe Gen3 will need
> to have one changes-iteration for RC mode.

You're correct. I'll fix it.

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
> > +int rcar_gen4_pcie_basic_init(struct rcar_gen4_pcie *rcar)
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
>=20
> > +	dw_pcie_cap_set(&rcar->dw, REQ_RES);
>=20
> Hmm, why is this here? Isn't it more appropriate to have it in
> rcar_gen4_pcie_devm_alloc() together with the EDMA_UNROLL flag
> setting? REQ_RES flag indicates a request for the driver core to get
> the generic DW PCIe RP/EP resources. It doesn't look as being
> suitable to be set in a prepare()-like method.

I don't have a special reason.. So, I'll move this to
the rcar_gen4_pcie_devm_alloc().

> > +
> > +	return err;
> > +}
> > +
> > +void rcar_gen4_pcie_unprepare(struct rcar_gen4_pcie *rcar)
> > +{
> > +	struct device *dev =3D rcar->dw.dev;
> > +	struct dw_pcie *dw =3D &rcar->dw;
> > +
>=20
> > +	if (!reset_control_status(dw->core_rsts[DW_PCIE_PWR_RST].rstc))
> > +		reset_control_assert(dw->core_rsts[DW_PCIE_PWR_RST].rstc);
>=20
> The de-assertion is performed in rcar_gen4_pcie_basic_init() which is
> called from the host_init() method. The respective antagonist is
> supposed to be performed in the host_deinit() in order to revert the
> changes on any error spotted in the host_init() and have a fully
> cleaned up device on the remove() procedure. Having something like
> rcar_gen4_pcie_basic_deinit() for it seems suitable.
>=20
> BTW I would have added dw->pe_rst assertion to
> dw_pcie_host_ops.host_deinit() too.

I understood it. I'll fix it.

> > +	pm_runtime_put(dev);
> > +	pm_runtime_disable(dev);
> > +}
> > +
> > +int rcar_gen4_pcie_get_resources(struct rcar_gen4_pcie *rcar,
> > +				 struct platform_device *pdev)
> > +{
> > +	/* Renesas-specific registers */
> > +	rcar->base =3D devm_platform_ioremap_resource_byname(pdev, "app");
> > +	if (IS_ERR(rcar->base))
> > +		return PTR_ERR(rcar->base);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct dw_pcie_ops dw_pcie_ops =3D {
> > +	.start_link =3D rcar_gen4_pcie_start_link,
> > +	.stop_link =3D rcar_gen4_pcie_stop_link,
> > +	.link_up =3D rcar_gen4_pcie_link_up,
> > +};
> > +
> > +struct rcar_gen4_pcie *rcar_gen4_pcie_devm_alloc(struct device *dev)
> > +{
> > +	struct rcar_gen4_pcie *rcar;
> > +
> > +	rcar =3D devm_kzalloc(dev, sizeof(*rcar), GFP_KERNEL);
> > +	if (!rcar)
> > +		return NULL;
> > +
> > +	rcar->dw.dev =3D dev;
> > +	rcar->dw.ops =3D &dw_pcie_ops;
> > +	dw_pcie_cap_set(&rcar->dw, EDMA_UNROLL);
> > +
> > +	return rcar;
> > +}
> > diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.h b/drivers/pci/=
controller/dwc/pcie-rcar-gen4.h
> > new file mode 100644
> > index 000000000000..e9cb816b33fa
> > --- /dev/null
> > +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.h
> > @@ -0,0 +1,43 @@
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
> > +#define  BIFUR_MOD_SET_ON	BIT(0)
> > +#define  DEVICE_TYPE_EP		0
> > +#define  DEVICE_TYPE_RC		BIT(4)
> > +
> > +#define PCIEINTSTS0		0x0084
> > +#define PCIEINTSTS0EN		0x0310
> > +#define  MSI_CTRL_INT		BIT(26)
> > +#define  SMLH_LINK_UP		BIT(7)
> > +#define  RDLH_LINK_UP		BIT(6)
> > +#define PCIEDMAINTSTSEN		0x0314
> > +#define  PCIEDMAINTSTSEN_INIT	GENMASK(15, 0)
> > +
> > +struct rcar_gen4_pcie {
> > +	enum dw_pcie_device_mode mode;
>=20
> > +	struct dw_pcie dw;
>=20
> By moving this field to the head of the structure you'll have a
> zero offset dw field with respect to the base-address of the
> container. This will convert the container_of() macro to the just
> type-cast.

I'll move it.

> > +	void __iomem *base;
> > +};
>=20
> > +#define to_rcar_gen4_pcie(x)	dev_get_drvdata((x)->dev)
>=20
> Why? You have dw_pcie instance embedded into the rcar_gen4_pcie
> structure. What about using the container_of() pattern then?
> +#define to_rcar_gen4_pcie(_dw) container_of(_dw, struct rcar_gen4_pcie, =
dw)

This is because almost other drivers in drivers/pci/controller/dwc/ use dev=
_get_drvdata().
I believe either way is fine.

> > +
> > +int rcar_gen4_pcie_basic_init(struct rcar_gen4_pcie *rcar);
>=20
> > +int rcar_gen4_pcie_prepare(struct rcar_gen4_pcie *pcie);
> > +void rcar_gen4_pcie_unprepare(struct rcar_gen4_pcie *pcie);
>=20
> s/pcie/rcar

I'll fix it.

> > +int rcar_gen4_pcie_get_resources(struct rcar_gen4_pcie *rcar,
>=20
> > +				 struct platform_device *pdev);
> > +struct rcar_gen4_pcie *rcar_gen4_pcie_devm_alloc(struct device *dev);
>=20
> Just a general note you may find useful. If I were you I would have
> added struct platform_device *pdev field to struct rcar_gen4_pcie and
> initialized it in the rcar_gen4_pcie_devm_alloc() method (it shall
> accept the platform_device pointer argument instead of just device).
> Thus you'll always have the {platform_}device pointer around as soon
> as you have the rcar_gen4_pcie pointer available which much more
> common case in the most of LLDD. This will greatly simplify any
> possible driver updates in future. Moreover you won't need to pass an
> additional device-pointer to the methods defined in your driver. For
> instance, in that case the rcar_gen4_pcie_get_resources() will need to
> accept just rcar_gen4_pcie pointer. Thus it will look unified aside
> with the rest of the methods in your driver.

Thank you for your suggestion. I think so. So, I'll fix it.

Best regards,
Yoshihiro Shimoda

> -Serge(y)
>=20
> > +
> > +#endif /* _PCIE_RCAR_GEN4_H_ */
> > --
> > 2.25.1
> >
