Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A606FAC8E
	for <lists+linux-pci@lfdr.de>; Mon,  8 May 2023 13:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235729AbjEHLZ5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 May 2023 07:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235691AbjEHLZm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 May 2023 07:25:42 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on20720.outbound.protection.outlook.com [IPv6:2a01:111:f403:7010::720])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462A03B7B0;
        Mon,  8 May 2023 04:25:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PddOBAjM62uPHwCZiaHtayoJydWBgp60xuz01Pyjg5FCRayngWPQLF3L5hZiRL5CxFVxy4OY0vUPGX7w2GpQm8eCzGKy/cQffq8qt5oS5WoT/1wQGZi6CXL4DSQoMaJWEMIFb4r3T/2+28UAzFgHUPp8tsIMrPJ7BZWFVvCAFJTTMSt4v2JfTuwSrdRCq4MhX9qV5SgyTUBqeo43zP3vjAYNJ2Kt490LmIi1syHzjZGCsHq3POicHA2kANsQdJRPH/jpjDgpbuWGCVdGs/xSU+Wpxe/VFVsFJG8hsTworWwtJUOskiZxCAnG8ijKleyONxxsYOMpYG+i7FaTV2teHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oylbcjUJeIL2oQx8g293XNgpjKacJEGLlYhpDKR0jeI=;
 b=LU4Om88cG1tfuoGPL3vck8vS2/lOf51VJ87JqzT1M+RPb8RggEdoN0VYmT2MjSnmAORgRbHYAG32B431llwI/XnojQDvSN24AdclqhouChFbGmSUwvfA6B+CvSAZPR3gZogp+ikNdS4ySnLiOYCpn3wB5zOIroiwRTmQHjoQhBxrgsaCr4h2fWNPxPwZ2edbPlfKOYyS3Sfru4cXNyzGTBIXwEyfxoNMcwI0Ny3IVIXTox4kX0e7cv1NPWQ85QbkoDLTWDgndV5kkwyTltzItvFoIFfamd1ybTqSOnZIP2t6C1wFcCGDFoye0/W4X1IPlfX91/9cKjuEGFCe7Luzug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oylbcjUJeIL2oQx8g293XNgpjKacJEGLlYhpDKR0jeI=;
 b=c79bg1N24X0IA/nWc6Mis3DFacxUiKxBcHkZIVLeSbMQtsrLVwrtKxtWzAZtKdQaxnPvc48XzjSeU+hEB5xC5vYxsKwlxfZGTAW7gLZcMRxsfNPPdnAcEv+khOLrTgNGZwRnKZUgL2glbBhQAoONZj5dBPFVHObK9UHjl78SaYQ=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYCPR01MB6077.jpnprd01.prod.outlook.com
 (2603:1096:400:61::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 11:25:10 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003%7]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 11:25:10 +0000
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
Subject: RE: [PATCH v14 18/21] PCI: rcar-gen4: Add R-Car Gen4 PCIe Host
 support
Thread-Topic: [PATCH v14 18/21] PCI: rcar-gen4: Add R-Car Gen4 PCIe Host
 support
Thread-Index: AQHZd/treJGhNoW7mkW9kwLw0aDIKq9F+ReAgApRDHA=
Date:   Mon, 8 May 2023 11:25:10 +0000
Message-ID: <TYBPR01MB534134BE71A7EDE328E0EBBED8719@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230426045557.3613826-1-yoshihiro.shimoda.uh@renesas.com>
 <20230426045557.3613826-19-yoshihiro.shimoda.uh@renesas.com>
 <20230501213311.fw62qymnxkdbbk4r@mobilestation>
In-Reply-To: <20230501213311.fw62qymnxkdbbk4r@mobilestation>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYCPR01MB6077:EE_
x-ms-office365-filtering-correlation-id: 3e017aa6-6b1f-42eb-d464-08db4fb6e29d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ox0NaZTjx0bEzZLNMky1cNU1/nl21QcZJfqM+vA4SKNCW/Ngpl+3T2hpQzpqGvjgTh0rub72ESPaD6ZAjlXKrJISrVJmYWEQqNXJcM2Hz9Pu/MV1sdMp/6nTSWeQ0+0rYN8MJs2FixczjUHe4572tOyPQa+FGpaqeX4qyHV4RutKpf5/TfSZg4pxn6fxEok/5w44XhuUp+Q8p6hnggXnPZLFHHhy5+NWQiwVuPrOlob5zCCQUnl7LWuHOwOmhKfWr/Dwfd0p5KT7SbCotKbERi56aA2Aou5/zh0HLLdHgCDjB5BmZAqeGKyJIkUDN2R58QOPIhmRIeswdMrZwKt0ytvJZjkG9/f24CIHssMiico9VcwCGzEOqA1OLq1gSqta/3BEWpOvnF9yXl+/GPEzbFh8UXkZlFstSewZcsIJqBebgUoUFwea9nJlztk64VzTDJliPT1mJnGHTbw4qYneGUV6g3nFVFGSqdUOtzLMoWOA4ZFNDCfgCvHphKTg7Q4uYifNw7pGz8EqK1/oWtGseCEbRc96QyoQaCOznqg68pvNPd6u/nTAzc5AoyzIuHw7MkxD8GXXNQugBqNFYqL1FCR3Q0BymNB608XtJ1T9BSpKNHGsoVFbdVLPNNZ8fybYQfXewLWN2NnG+iPZhdK4POO0Sxzn4yIG9HMe3RCQEzM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(39860400002)(376002)(136003)(396003)(451199021)(6506007)(9686003)(7696005)(83380400001)(55016003)(38100700002)(33656002)(122000001)(86362001)(38070700005)(186003)(6916009)(5660300002)(66446008)(4326008)(66476007)(54906003)(66946007)(30864003)(2906002)(478600001)(8676002)(8936002)(66556008)(64756008)(7416002)(76116006)(41300700001)(52536014)(71200400001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IN02LWCgDD60ObkpsUYknPqHJu3Ph+cpvrS/Irqh5pl/LFyI2Lr3BTSsd2FM?=
 =?us-ascii?Q?16dvknpAjJOj9bA9KsLw2R/VL31xyp/KjLEQbM/Suzw+JJuW14skeUFbnKcr?=
 =?us-ascii?Q?aWibHLhEW3kUZBRO/rQj2X+pj1ZHtC/CW6ZfDUl5CLpw5Z7PMQxDPh/2C2NN?=
 =?us-ascii?Q?PbvJpWm41c6oMb4DU0swoxcRJZghYnsMu04fiewUsjscqLJcwQEd7ZX/7BR4?=
 =?us-ascii?Q?TaxwUOv6u2IZ9WTyULBJ9rJ6/SRM49jrt/qOdv9kEQIzRdkp4ECd7cCm8fwi?=
 =?us-ascii?Q?vGXheudaw1V+j1MKYdAlBxuGJRXaAgJ0csCpIUQrMyYhrnLFCrTgi4P/ibJT?=
 =?us-ascii?Q?chNCvr/2AJsBJ4K6ZN2ppYSRrQOsuJMnt/CXSK6yNAXpM++nbdUeSBMRuVwr?=
 =?us-ascii?Q?aNB3jhb6GQX8TnaxPtANNPr2tCtqzJcLj2us3Uq35d0yxPmIbQPGf++ffakV?=
 =?us-ascii?Q?EMMdJqXP+4WPW8betTWqmA+Q7QgGtrffCBasNAUWy3qHxw1yEvQiT5XwzIFZ?=
 =?us-ascii?Q?xJp6RBQjUANzyKWI5kjckegZbR+DNS830zKAwEFTHc//2mrWtJPAtViM0pcx?=
 =?us-ascii?Q?Zm5YUTWVDnyxoCzsuljeP++EPwz3lz1ekZbsZ2a7msDIwuxFl/mPq4ElBPtQ?=
 =?us-ascii?Q?/bzqZJq18Wkd/GeQSBiDfpVi4zlAB1EmJK9nz+BzjKSzq114JNKF/SukrKW/?=
 =?us-ascii?Q?7jt/QY2eOzfPHM7cpn/9UlQh2aYvivaFqvoDTvkn5KBAV7HmROkUZk0+tbBk?=
 =?us-ascii?Q?N0OGhnQ9IPbjFBeljfyEAtga7zegl2WOL/QT/Jl1Ou2jZe/sCg5nOniyce8D?=
 =?us-ascii?Q?0bOfCAo39BXLWRJ9IYirJ9sV9u7HXexLZhavbo3XgfDha8BM/W+pjCFxPXX0?=
 =?us-ascii?Q?2mKOZQSIiS4sv2PwVelIZpuR6qRKuNqEkFiTmIFO0yS5MUVmfCKx8o9FL2Pw?=
 =?us-ascii?Q?C3EqYDWgEvNzegMpC0Gvu/HLyjVzkMRzITNR6g5q6eDMzkzZlJTtbyH2VXcR?=
 =?us-ascii?Q?McBmwdofcKAReJyzAz95lTZQYIPKAsKyofxFQ75Lm9He8UOZYhCv+OfyLgt3?=
 =?us-ascii?Q?7fPqlHf63xU+1pcL8f1w2rAkejAXoHBLmkFIMTatSiWE2Z5BWetPeCRArjk3?=
 =?us-ascii?Q?6yz5CjIKofeUxI1hz5ZFtZdCRSaOs/NcoJ+lLEY+64miIkzsn7D9Tz7oNBY+?=
 =?us-ascii?Q?VmOYKf9G5D8MsLMsFLezYIzI0AZ9MsOsw2lKeViGmdSco2wmOOMGEe4uXYo1?=
 =?us-ascii?Q?Q8+SvluO10QsU2+Ogpl04peWpGp3S3Q+B7VvlgQ8EZahWYfL+ksghp0tPbBK?=
 =?us-ascii?Q?0efVDmaePqwblPmQh8dIiDy5xFPybC731Kjdy0Xcwq5BL4VHFqWkZ4Q4PvOb?=
 =?us-ascii?Q?dyiJR2hejEyRSUJ6/+XbJyuJAt6nzqMc+u5k4Ud3sXhR1H48h6sGUotBC5aq?=
 =?us-ascii?Q?vb4dIuwmUaHlcTJ1DIgilYm8sh7xPNfhInqk6EFQa8e5eP858EQOWeBe/CBb?=
 =?us-ascii?Q?NYaqDwu9C4WxsaYR4ULhQfnGses9NJdIzvj/TJ2fa7kROAkniaKSEDsXch7B?=
 =?us-ascii?Q?M8+xAY0tHCoJilKnTLYjGm5lYht44zPzwUEmxIIchEEx5yC+pBvScMPKggYL?=
 =?us-ascii?Q?00yryJM5MlpNjdtXvJR0xL1BdbSNi+CUtjDGbCXezXgkw7cel5B3Ffz1rW6d?=
 =?us-ascii?Q?ZibKHQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e017aa6-6b1f-42eb-d464-08db4fb6e29d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2023 11:25:10.7663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HxEgORHQ8QLamfJFULXYEID4kc0O5AjmXozhVb6eZ4gp5gBd4KtXGSF/HiJyH2zXtkXEhgx1TEerC2OaE4439FuKZ8vF5u60IblGT/9qTR59HGlkVLk+B7LCdd20oOtj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6077
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Serge,

> From: Serge Semin, Sent: Tuesday, May 2, 2023 6:33 AM
>=20
> On Wed, Apr 26, 2023 at 01:55:54PM +0900, Yoshihiro Shimoda wrote:
> > Add R-Car Gen4 PCIe Host support. This controller is based on
> > Synopsys DesignWare PCIe, but this controller has vendor-specific
> > registers so that requires initialization code like mode setting
> > and retraining and so on.
> >
> > To reduce code delta, adds some helper functions which are used by
> > both the host driver and the endpoint driver (whitch is added
>=20
> s/whitch/which

Oops. I'll revise it on v15.

> > immediately afterwards) into a separate file.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> >  drivers/pci/controller/dwc/Kconfig            |   9 +
> >  drivers/pci/controller/dwc/Makefile           |   2 +
> >  .../pci/controller/dwc/pcie-rcar-gen4-host.c  | 141 +++++++++++++
> >  drivers/pci/controller/dwc/pcie-rcar-gen4.c   | 187 ++++++++++++++++++
> >  drivers/pci/controller/dwc/pcie-rcar-gen4.h   |  48 +++++
> >  5 files changed, 387 insertions(+)
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
> > index 000000000000..df7d80f1874f
> > --- /dev/null
> > +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4-host.c
> > @@ -0,0 +1,141 @@
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
> > +	ret =3D rcar_gen4_pcie_set_device_type(rcar, true, dw->num_lanes);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	dw_pcie_dbi_ro_wr_en(dw);
> > +
> > +	/*
> > +	 * According to the section 3.5.7.2 "RC Mode" in DWC PCIe Dual Mode
> > +	 * Rev.5.20a, we should disable two BARs to avoid unnecessary memory
> > +	 * assignment during device enumeration.
> > +	 */
> > +	dw_pcie_writel_dbi2(dw, PCI_BASE_ADDRESS_0, 0x0);
> > +	dw_pcie_writel_dbi2(dw, PCI_BASE_ADDRESS_1, 0x0);
> > +
> > +	dw_pcie_dbi_ro_wr_dis(dw);
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
> > +				   struct platform_device *pdev)
> > +{
> > +	struct dw_pcie *dw =3D &rcar->dw;
> > +	struct dw_pcie_rp *pp =3D &dw->pp;
> > +
> > +	pp->num_vectors =3D MAX_MSI_IRQS;
> > +	pp->ops =3D &rcar_gen4_pcie_host_ops;
> > +	dw_pcie_cap_set(dw, REQ_RES);
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
> > +	platform_set_drvdata(pdev, rcar);
> > +
> > +	err =3D rcar_gen4_pcie_prepare(rcar);
> > +	if (err < 0)
> > +		return err;
> > +
> > +	rcar->needs_retrain =3D true;
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
> > +static int rcar_gen4_pcie_remove(struct platform_device *pdev)
> > +{
> > +	struct rcar_gen4_pcie *rcar =3D platform_get_drvdata(pdev);
> > +
> > +	rcar_gen4_remove_dw_pcie_rp(rcar);
> > +	rcar_gen4_pcie_unprepare(rcar);
> > +
> > +	return 0;
> > +}
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
> > +	.remove =3D rcar_gen4_pcie_remove,
> > +};
> > +module_platform_driver(rcar_gen4_pcie_driver);
> > +
> > +MODULE_DESCRIPTION("Renesas R-Car Gen4 PCIe host controller driver");
> > +MODULE_LICENSE("GPL");
> > diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/=
controller/dwc/pcie-rcar-gen4.c
> > new file mode 100644
> > index 000000000000..ee916a149708
> > --- /dev/null
> > +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> > @@ -0,0 +1,187 @@
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
> > +#define RETRAIN_MAX_RETRY	10
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
> > +		val &=3D ~APP_LTSSM_ENABLE;
> > +		val |=3D APP_HOLD_PHY_RST;
> > +	}
> > +	writel(val, rcar->base + PCIERSTCTRL1);
> > +}
> > +
> > +static bool rcar_gen4_pcie_check_retrain_link(struct dw_pcie *dw)
> > +{
> > +	u8 offset =3D dw_pcie_find_capability(dw, PCI_CAP_ID_EXP);
> > +	u32 lnkcap =3D dw_pcie_readl_dbi(dw, offset + PCI_EXP_LNKCAP);
> > +	u32 lnkctl =3D dw_pcie_readl_dbi(dw, offset + PCI_EXP_LNKCTL);
> > +	u16 lnksta =3D dw_pcie_readw_dbi(dw, offset + PCI_EXP_LNKSTA);
> > +	int i;
> > +
> > +	if ((lnksta & PCI_EXP_LNKSTA_CLS) =3D=3D (lnkcap & PCI_EXP_LNKCAP_SLS=
))
> > +		return true;
> > +
> > +	lnkctl |=3D PCI_EXP_LNKCTL_RL;
> > +	dw_pcie_writel_dbi(dw, offset + PCI_EXP_LNKCTL, lnkctl);
> > +
> > +	for (i =3D 0; i < RETRAIN_MAX_RETRY; i++) {
> > +		lnksta =3D dw_pcie_readw_dbi(dw, offset + PCI_EXP_LNKSTA);
> > +		if (lnksta & PCI_EXP_LNKSTA_LT)
> > +			return true;
> > +		usleep_range(1000, 1100);
> > +	}
> > +
> > +	return false;
> > +}
> > +
> > +static int rcar_gen4_pcie_link_up(struct dw_pcie *dw)
> > +{
> > +	struct rcar_gen4_pcie *rcar =3D to_rcar_gen4_pcie(dw);
> > +	u32 val, mask;
> > +
>=20
> > +	/*
> > +	 * Require retraining here. Otherwise RDLH_LINK_UP of PCIEINTSTS0 whi=
ch
> > +	 * is this controller specific register may not be set.
> > +	 */
> > +	if (rcar->needs_retrain && !rcar_gen4_pcie_check_retrain_link(dw))
> > +		return 0;
>=20
> Retraining the link on each link-up test doesn't seem right. What
> about moving the PCI_EXP_LNKCTL.PCI_EXP_LNKCTL_RL field update to the
> start_link() callback? Will that be enough to make sure that the link
> will be established afterwards?
> * Note on Baikal-T1 PCIe we also have had a problem with establishing
> * the higher gen link. (It's Gen3 in our case.) But instead of
> * re-training the link all over we get to set the
> * GEN2_CTRL_OFF.DIRECT_SPEED_CHANGE flag which causes the higher gen
> * link establishment right away. Please see
> * pcie-bt1.c:bt1_pcie_start_link() function for reference.

Thank you for your suggestion. I'll check whether this controller can
work on such implementation too.

> > +
> > +	val =3D readl(rcar->base + PCIEINTSTS0);
> > +	mask =3D RDLH_LINK_UP | SMLH_LINK_UP;
> > +
> > +	return (val & mask) =3D=3D mask;
> > +}
> > +
> > +static int rcar_gen4_pcie_start_link(struct dw_pcie *dw)
> > +{
> > +	struct rcar_gen4_pcie *rcar =3D to_rcar_gen4_pcie(dw);
> > +
> > +	rcar_gen4_pcie_ltssm_enable(rcar, true);
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
> > +int rcar_gen4_pcie_set_device_type(struct rcar_gen4_pcie *rcar, bool r=
c,
> > +				   int num_lanes)
> > +{
> > +	u32 val;
> > +
> > +	/* Note: Assume the rcar->rst which is Cold-reset is asserted here */
> > +	val =3D readl(rcar->base + PCIEMSR0);
> > +	if (rc)
> > +		val |=3D DEVICE_TYPE_RC;
> > +	else
> > +		val |=3D DEVICE_TYPE_EP;
> > +
> > +	if (num_lanes < 4)
> > +		val |=3D BIFUR_MOD_SET_ON;
> > +
> > +	writel(val, rcar->base + PCIEMSR0);
> > +
> > +	return reset_control_deassert(rcar->rst);
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
> > +	if (!reset_control_status(rcar->rst))
> > +		reset_control_assert(rcar->rst);
> > +	pm_runtime_put(dev);
> > +	pm_runtime_disable(dev);
> > +}
> > +
>=20
> > +static int rcar_gen4_pcie_devm_reset_get(struct rcar_gen4_pcie *rcar,
> > +				  struct device *dev)
> > +{
> > +	rcar->rst =3D devm_reset_control_get(dev, NULL);
> > +	if (IS_ERR(rcar->rst)) {
> > +		dev_err(dev, "Failed to get Cold-reset\n");
> > +		return PTR_ERR(rcar->rst);
> > +	}
> > +
> > +	return 0;
> > +}
>=20
> Since v9 this method has been no longer globally defined. What about
> moving its content to rcar_gen4_pcie_get_resources()? Thus the later
> will still look coherent meanwhile we'll be able to drop an
> excessive function definition with no harm to the code readability.

Thank you for pointed it out. I'll move it to rcar_gen4_pcie_get_resources(=
).

> > +
> > +int rcar_gen4_pcie_get_resources(struct rcar_gen4_pcie *rcar,
> > +				 struct platform_device *pdev)
> > +{
> > +	struct dw_pcie *dw =3D &rcar->dw;
> > +
> > +	/* Renesas-specific registers */
> > +	rcar->base =3D devm_platform_ioremap_resource_byname(pdev, "app");
> > +	if (IS_ERR(rcar->base))
> > +		return PTR_ERR(rcar->base);
> > +
> > +	return rcar_gen4_pcie_devm_reset_get(rcar, dw->dev);
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
> > index 000000000000..7c765c2d79b9
> > --- /dev/null
> > +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.h
> > @@ -0,0 +1,48 @@
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
> > +#include <linux/reset.h>
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
> > +	struct dw_pcie		dw;
> > +	void __iomem		*base;
> > +	struct reset_control	*rst;
> > +	bool			needs_retrain;
> > +};
> > +#define to_rcar_gen4_pcie(x)	dev_get_drvdata((x)->dev)
> > +
>=20
> > +u32 rcar_gen4_pcie_readl(struct rcar_gen4_pcie *pcie, u32 reg);
> > +void rcar_gen4_pcie_writel(struct rcar_gen4_pcie *pcie, u32 reg, u32 v=
al);
>=20
> I don't see these methods being defined here.

Oops. I'll drop them.

Best regards,
Yoshihiro Shimoda

> -Serge(y)
>=20
> > +int rcar_gen4_pcie_set_device_type(struct rcar_gen4_pcie *rcar, bool r=
c,
> > +				   int num_lanes);
> > +int rcar_gen4_pcie_prepare(struct rcar_gen4_pcie *pcie);
> > +void rcar_gen4_pcie_unprepare(struct rcar_gen4_pcie *pcie);
> > +int rcar_gen4_pcie_get_resources(struct rcar_gen4_pcie *rcar,
> > +				 struct platform_device *pdev);
> > +struct rcar_gen4_pcie *rcar_gen4_pcie_devm_alloc(struct device *dev);
> > +
> > +#endif /* _PCIE_RCAR_GEN4_H_ */
> > --
> > 2.25.1
> >
