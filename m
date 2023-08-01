Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E17076A996
	for <lists+linux-pci@lfdr.de>; Tue,  1 Aug 2023 08:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjHAG7v (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Aug 2023 02:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjHAG7t (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Aug 2023 02:59:49 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2095.outbound.protection.outlook.com [40.107.113.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5ED1728;
        Mon, 31 Jul 2023 23:59:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ziwe/5WnhOHDdc4tlPlfv69x5OX7ud1Nr5AwhdD/b17D8Z+o4s4iAZMMi6E8JngjdYcexSYFeEKOQ7D6u8PZ4jiZvtKuvNZJiwsMrnT4YJOGa03LSH5qbnLehjrfEqjeXwt63VD5bRkDVUH1rJ1G8ZU1GUs+d8AL+2HSmZLRBe0nW7KF2sq4dyiROToIDRYYaXxw+Q1O00cQLIT786dVISOGXxuwHV4aPlxj9hnYQjhUaVHNNwHlDBpuSwjm2b9Z/xtQN8OkNaCBByFqFjxtEKT/8FKRZfl2p/z1jAIJRN2oO+3ElJEr6Me1lYBwP7kYmDurqbgFwOijkVorGv7IUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z1ZnKA508/0IRiJIxYEcr7/KxLVO7ssdk7RfIw6kMi8=;
 b=RCEv0IvKr8wf1jcYb0Ax1q0cw/k7U3t94sC8pOILnoZUlE3BQMlcOsb/qRw1GUHpPyV3QNmDOmpgtiWxUaOn2QjbQJ7dUFWpulbHRvhUvkvCzGhcniYVkXU3Rb/Ic7BpUIwWVLm/cQxq+yE5O9CUJ9XX109nztqiTnnRu7+fHrhB++E2FVicYeTCP/U22HLfXh1N5pxNVP26KnKWvO64k3PplrPUC0rMBbBjcqjtKszUDPl1LyKI2rSIDImE+ZKUoWxUqZNFtweuVpytj7SJPL9NQv4eWZxYvVvf58+a9cDQaru/OCqfxiHc4OaSyV4Im7+XBTrjAByIiGWKJiMLmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z1ZnKA508/0IRiJIxYEcr7/KxLVO7ssdk7RfIw6kMi8=;
 b=Ak0LRn5VenZFh1SGDFAQCxejFdXBY8FfiIJrmU3lrO8ocbKh3Y0MmHnBLDko2ZXfFieAnVM8h5idhSBPfc3Wa5IeBfhIXyx3deqP8YF44A9umDP3cnjQv5okLGHliCcrCHRhrZiEcdFv7vF0H/XwmHDq5aK4cdDPhjwB6GJYBpM=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYCPR01MB8111.jpnprd01.prod.outlook.com
 (2603:1096:400:100::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 06:59:43 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::e5cd:66a0:248f:1d30]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::e5cd:66a0:248f:1d30%4]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 06:59:43 +0000
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
Subject: RE: [PATCH v18 18/20] PCI: rcar-gen4-ep: Add R-Car Gen4 PCIe Endpoint
 support
Thread-Topic: [PATCH v18 18/20] PCI: rcar-gen4-ep: Add R-Car Gen4 PCIe
 Endpoint support
Thread-Index: AQHZu6dEoTO4Ou4tfUOs3XdEXJs4ia/UucaAgABWugA=
Date:   Tue, 1 Aug 2023 06:59:43 +0000
Message-ID: <TYBPR01MB534113305CD3BC7EEDE1F062D80AA@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230721074452.65545-1-yoshihiro.shimoda.uh@renesas.com>
 <20230721074452.65545-19-yoshihiro.shimoda.uh@renesas.com>
 <3gwpjq4dhensrxjhb2cfd6q7c6tcaayfokn3bebnauryzgayhz@ogkp3cf255o4>
In-Reply-To: <3gwpjq4dhensrxjhb2cfd6q7c6tcaayfokn3bebnauryzgayhz@ogkp3cf255o4>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYCPR01MB8111:EE_
x-ms-office365-filtering-correlation-id: eacf5db5-b4e9-4416-da84-08db925ce234
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iv1p/7tMdZU5C65rRhapVCn6+rbkpLP62AF/aunv0fGmU7EfBeRHfKLelsmGlvGBvSA3UrcwILzdBIJ8QdSPpmtAJYWo5AKmgy+1douCEA7em+DktkD2fIQFyLwS8MNnJ+nYYjESk8isUhHwltRbua1Zn83oLzNcPeGWvQOJOliczHQufUq6KpiD/x/P6NuAJqZit8ilnikkCFTG/Qkb66eEECFbJ0PYE9gWqTZpqxAlkUCnM+3aoo00HTUfPtpaDeyouPnQ3IzUXo4UQnIQcMKCW1f0BeXuawYrkTCN+xdVHZNC5jwWBzNJA4lx2EqauRucpIUesggccfw/ETml2X7943DIzoRcpazZMlkaPm2ZB3e7TvCswVw+xPG090I8N693H1geG6ncEkOdtBGpejv1EGJb3doXhhdbwHWobW/2D5uIhA/Rf8QoeeBxgriWly6bLwyo3xaJ8cn2O42hxMGDOKNIEMD6k++1npDV0OskjrlwLQ/naZHKbTI6WvZRz0rZ0fyPG7dgmUTDaMkPM6CF8GM6Up6/W4Q+BMqB2p+jas8uRA670VwZg1Ur7Ev59RoIYMfy9tFSzOBZgO2sx8BlmrmfH3QeMvURmqypZoWg34gbCfxjkeEYIYg/hJeU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(451199021)(41300700001)(5660300002)(8676002)(66946007)(76116006)(8936002)(4326008)(52536014)(54906003)(478600001)(66476007)(316002)(7416002)(64756008)(66556008)(6916009)(66446008)(2906002)(122000001)(9686003)(86362001)(71200400001)(7696005)(38070700005)(38100700002)(83380400001)(6506007)(26005)(53546011)(33656002)(55016003)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?B7tSfAQqB/4BMiEttsu+xnaORanaK7wwlvjpMgfxz0/pCIGAyWX41Q7RbXTS?=
 =?us-ascii?Q?73L9O1D5I5QHxSKagPoaWDhiZ9FHGF2uhktPUky7e9jLLqU0NpYbXRI2cT7o?=
 =?us-ascii?Q?zt6N6k01kMxv9Bl1A6bWGIqy+GA1gzZePh+vXwAmh+ayBc7NkrB6kMThyHMY?=
 =?us-ascii?Q?eaE2H7R3bnVWfGQkooTMa3+6n+tjrXRKeGN79l66NU0dR1bDDnfUgTMgz3ka?=
 =?us-ascii?Q?qfcV9YdZUtsJL2kP2d0MnWg+KddQ65AJP2Wav19pWTuObM6OslvypE5qDpha?=
 =?us-ascii?Q?3xYO6ijdrpJlD/npXEAyyJkM2qIjiqCwfHhZGL0GFyyBregQ5if8d5eTVn9r?=
 =?us-ascii?Q?/4CIJNxCp8UwtK+L1Wn52OZWMyjlxoaAsyTB4xpAjiogD4j4/MJH/d0LPwnw?=
 =?us-ascii?Q?l1GwBZYlZ7Ul/W9CSIp4HdFV/2m+pazREFsoVhxvUDf+3/ldXb+GEwmDuV6p?=
 =?us-ascii?Q?RZ4Y+pS/TaiIIw6LStEGdz3X6nHtcIJs5z8WukxUU+xpDgTKw1a3RA+qDHfR?=
 =?us-ascii?Q?/POVry54OEfQsR+h8uY0Z39u3UMlKZvCVmCDBDr4v/Rg6ouSEJFW4LRj6ZKg?=
 =?us-ascii?Q?rOlrdxTwu9j2Uqxf7go+npi5NnGNeGZAFt1kEHsxH4cwBmA/lVyEfSq9B6WL?=
 =?us-ascii?Q?DR/LzlpKik8vgMUgYvde48y3zkODfMaNl5Cb5yWDjoo6qkjixmEltOcakNAG?=
 =?us-ascii?Q?y2m0o7719WEYuLtBXZF+5TkHIgFnZulZzmwHXSg6msXMuiyUG1Evd+uI5Kzm?=
 =?us-ascii?Q?FupveB9eD/TRDXp8T5vGANGSa+SWv4kXmm7WNUHzw8QL9lBT0XKBUjfQ446l?=
 =?us-ascii?Q?2hNU2w8O7U5Z5Osp5NNnV40jtOrHpiV4ZpNlJR2Cuo/9kn/TKoGDsVusviUB?=
 =?us-ascii?Q?I+7Eufead9ArUuvWY6r39wVEpS1VjVLUIIlJEPbEePx176HJsFyDJVLgB+eS?=
 =?us-ascii?Q?RbJCsjugwPYQmIqu46eKsHTHHsJgCl+qcYhjq/pDSsaEKjhIzp08LdwkB32t?=
 =?us-ascii?Q?wU/EXLpBv8T+W/gT2296fslJ4m5ejtoN0cpJ1cKgOqbEGEeQabWjG+IWEMX8?=
 =?us-ascii?Q?KXVyZzTrbMsRUvbBY5lK4MYFEJrBHFCLWoxQR1lWtaI3MVeGu2jQfjRbODqh?=
 =?us-ascii?Q?3lQtpjGrBGDSGtvr5s2E8ikqX0h0kpa4d1E9woNL4KG23MNrS+E5iZdxCzQC?=
 =?us-ascii?Q?+JRzEjKjw2bkTddp5HUG1v0H1s5OBvGXiGrQDFu/vf17v6hF3DSwS7Y0QW8h?=
 =?us-ascii?Q?dG1Fckgr4JDJogVyEltNnn4X5RbjmmSd6iC9jGDL6W5W9t17Q2M3vpX4YA3E?=
 =?us-ascii?Q?rWDOHw1txrZCXxCKxyKGtpjJtRrgIgM43GSh8DxWPCn5I92Ywm3N6RkkJBlE?=
 =?us-ascii?Q?rOEje5p/C6PHPOhHBgewVCF0lTlBMr4DLUSzAG1Shfzt13NYDiifRdz6tlP+?=
 =?us-ascii?Q?NvihRtVkZuVwzL+VqWtdd4DyatyEF2PdccNNiUcaBuOawpEf+W8UswpLLju2?=
 =?us-ascii?Q?lMo4eLpHmLlCg5kvYSX+a4S/Uwe1HAHLOl8NmcoEC72DOfEM2ya7Mz0Ne2+g?=
 =?us-ascii?Q?zj3V/yeBJd7zw7Od+uqCcZUrfVfa9dAjywJA5wBhfm8ZhiPyF1E756sVRt53?=
 =?us-ascii?Q?6g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eacf5db5-b4e9-4416-da84-08db925ce234
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2023 06:59:43.2532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Flup1hKKH+CtLD0ujrE9O256U9VdAo9wkuaU95ejZG9WvRPY6hKL7WC8mCOZFqRCHXlSghJfHkl36uSeAqpmBsZNjxj0ypH5NJOEJlHkRw+hl4WdGvbV+IgDciRdJP/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8111
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

> From: Serge Semin, Sent: Tuesday, August 1, 2023 10:36 AM
> To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: jingoohan1@gmail.com; gustavo.pimentel@synopsys.com; lpieralisi@kerne=
l.org; robh+dt@kernel.org; kw@linux.com;
> manivannan.sadhasivam@linaro.org; bhelgaas@google.com; kishon@kernel.org;=
 krzysztof.kozlowski+dt@linaro.org;
> conor+dt@kernel.org; marek.vasut+renesas@gmail.com; linux-pci@vger.kernel=
.org; devicetree@vger.kernel.org;
> linux-renesas-soc@vger.kernel.org
> Subject: Re: [PATCH v18 18/20] PCI: rcar-gen4-ep: Add R-Car Gen4 PCIe End=
point support
>=20
> On Fri, Jul 21, 2023 at 04:44:50PM +0900, Yoshihiro Shimoda wrote:
> > Add R-Car Gen4 PCIe Endpoint support. This controller is based on
> > Synopsys DesignWare PCIe.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> >  drivers/pci/controller/dwc/Kconfig            |   9 +
> >  drivers/pci/controller/dwc/Makefile           |   2 +
> >  .../pci/controller/dwc/pcie-rcar-gen4-ep.c    | 189 ++++++++++++++++++
> >  3 files changed, 200 insertions(+)
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
> > index 000000000000..3970a920f3fe
> > --- /dev/null
> > +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4-ep.c
> > @@ -0,0 +1,189 @@
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
> > +	ret =3D clk_bulk_prepare_enable(DW_PCIE_NUM_CORE_CLKS, dw->core_clks)=
;
> > +	if (ret) {
> > +		dev_err(dw->dev, "Failed to enable ref clocks\n");
> > +		return;
> > +	}
> > +
> > +	rcar_gen4_pcie_basic_init(rcar);
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
> > +	rcar_gen4_pcie_basic_deinit(rcar);
> > +	clk_bulk_disable_unprepare(DW_PCIE_NUM_CORE_CLKS, dw->core_clks);
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
>=20
> > +				 struct platform_device *pdev)
>=20
> Drop this argument. rcar already has the pdev pointer.

Oops. I'll fix it.

> > +{
> > +	struct dw_pcie_ep *ep =3D &rcar->dw.ep;
> > +	int ret;
> > +
> > +	rcar->mode =3D DW_PCIE_EP_TYPE;
> > +	ep->ops =3D &pcie_ep_ops;
> > +
> > +	ret =3D dw_pcie_ep_init(ep);
> > +	if (ret) {
>=20
> > +		dev_err(&pdev->dev, "Failed to initialize endpoint\n");
>=20
> Even though half the DW PCIe EP LLDDs are doing the same I would have
> either dropped the error printed here or converted it to
> dev_err_probe(). First option is more preferable because thus your RP
> and EP adding methods will turn to look similar.

I prefer keeping dev_err_probe() here because it's possible to fail without
any error message, IIUC.

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
> > +	rcar =3D rcar_gen4_pcie_devm_alloc(pdev);
> > +	if (!rcar)
> > +		return -ENOMEM;
> > +
> > +	err =3D rcar_gen4_pcie_get_resources(rcar);
>=20
> > +	if (err < 0) {
>=20
> As Mani correctly noticed the checks should be converted to "if (err)..."=
.

I got it.

> > +		dev_err(dev, "Failed to request resource: %d\n", err);
>=20
> I would have moved this error printed to the
> rcar_gen4_pcie_get_resources() method (similar fix should be in the
> Root Port patch too). Thus the probe method will turn to look neat and
> you'll be able to drop the dev pointer from here.

I got it. I'll fix them.

> > +		return err;
> > +	}
> > +
> > +	err =3D rcar_gen4_pcie_prepare(rcar);
>=20
> > +	if (err < 0)
>=20
> if (err) ?
>=20
> > +		return err;
> > +
> > +	err =3D rcar_gen4_add_pcie_ep(rcar, pdev);
>=20
> > +	if (err < 0)
>=20
> ditto

I'll fix them as "if(err)"

> > +		goto err_add;
> > +
> > +	return 0;
> > +
>=20
> > +err_add:
>=20
> See the comments in the patch 17/20 regarding the label name.

I'll rename the label to "err_unprepare".

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
>=20
> As Mani noted: missing MODULE_DEVICE_TABLE().

I got it.

Best regards,
Yoshihiro Shimoda

> -Serge(y)
>=20
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
