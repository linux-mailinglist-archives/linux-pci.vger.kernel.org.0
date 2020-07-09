Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA05F219C0D
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jul 2020 11:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgGIJ00 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jul 2020 05:26:26 -0400
Received: from mail-db8eur05on2045.outbound.protection.outlook.com ([40.107.20.45]:6089
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726211AbgGIJ0Z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Jul 2020 05:26:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l4jy2Zi3pPeSC5uK9TV5ckNTroCl3QpY32T9hyRJroCJPucSL3vjf4aJLnb9m6PAEzSCgLJTkh690/68VuwOi91SjVK3ambpL+MW4iApuoqc+i3jWR9INv0oF4thuCUgI+i0oe/zg1PHTANPVrpBfQK5hmlnnstAPrjT3yqR1GQGN4I/XWlisnAvh9ewsW4puOYLCWeOkJuENj/NPLu1yVnkjQxOe/hhG8ngY7elDIlHVu2b7rCCGD/Zjk5KPcKC62Vf72ReWJmSoImxtn43e+Nu5BA9pssZqtWR0Cgqn8v1uvtu4qubns+JNk9FvS6D77IzUq5j485xhOk7lVoyVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8l8nbZSL3UAqDmMKyMTpMcLvjtrUGQm9atfruccjKic=;
 b=frNJ8PK85RU0VDTYvR8VgyFK8ET2kPAMG5klPf3V2cQGGZKl2P6a/0ScAxu3a2niKLK3brDMlU70j3HHF0e/jGz4nIHCp2sxcuwWjukZCjMf9TRmWK3hdRqOtyikNF8e3hMQWjvSKrb34NhOWxekW4uQANgWvPO1y/q39uqj60hH2N5CZn155uS8ztPxVmMEKAgKVWTkNP1d4e44sF3852+ftjgRt11F4TZ0Sifzh0SeRk2a8vmoVKf7okutHiP/1AuzMt+CjdFDdKAWNaaD9/s0xCOhg9XIroh7kEDIfH7kRgmH+8yjKnWRcBTiAoxwzYlX5I7QqacT+cTyy/Z+AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8l8nbZSL3UAqDmMKyMTpMcLvjtrUGQm9atfruccjKic=;
 b=B4nu28s85iHb5vyRtjA0OdW9qo6rmKqdORLPGX7wcgUGAxKW6j8THK8x9WZqdUWcBk3g9j4wN+qJkYaHs5pjFX8D0Tgl4zRFLaM7XjF0nh97LH1XIAMzYm1fu1mkwSF/EEwDfo3/mIDIjaQkIulYle9cYMeyDq1gw4By5u7GQ7s=
Received: from DB7PR04MB4986.eurprd04.prod.outlook.com (2603:10a6:10:13::25)
 by DB6PR0401MB2616.eurprd04.prod.outlook.com (2603:10a6:4:31::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Thu, 9 Jul
 2020 09:26:20 +0000
Received: from DB7PR04MB4986.eurprd04.prod.outlook.com
 ([fe80::d133:55be:7303:108e]) by DB7PR04MB4986.eurprd04.prod.outlook.com
 ([fe80::d133:55be:7303:108e%6]) with mapi id 15.20.3174.021; Thu, 9 Jul 2020
 09:26:20 +0000
From:   Makarand Pawagi <makarand.pawagi@nxp.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Diana Madalina Craciun (OSS)" <diana.craciun@oss.nxp.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Joerg Roedel <joro@8bytes.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>
Subject: RE: [EXT] Re: [PATCH v2 12/12] bus: fsl-mc: Add ACPI support for
 fsl-mc
Thread-Topic: [EXT] Re: [PATCH v2 12/12] bus: fsl-mc: Add ACPI support for
 fsl-mc
Thread-Index: AQHWT8hvhkZ6PFIXKUip8fS0U4S+lKj/BKAAgAABSiA=
Date:   Thu, 9 Jul 2020 09:26:20 +0000
Message-ID: <DB7PR04MB4986D1A0BB7B685911DF4831EB640@DB7PR04MB4986.eurprd04.prod.outlook.com>
References: <20200521130008.8266-1-lorenzo.pieralisi@arm.com>
 <20200619082013.13661-1-lorenzo.pieralisi@arm.com>
 <20200619082013.13661-13-lorenzo.pieralisi@arm.com>
 <a7845603-9bc9-9099-dfc4-19b7bc4f4e44@nxp.com>
 <20200709091950.GA18149@e121166-lin.cambridge.arm.com>
In-Reply-To: <20200709091950.GA18149@e121166-lin.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [122.169.149.202]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 81974cdc-228b-4021-4993-08d823ea23d8
x-ms-traffictypediagnostic: DB6PR0401MB2616:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0401MB261698D530282BDCC81D8235EB640@DB6PR0401MB2616.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4W/ATzYpvNvnCiYdHUfFUn8Mz5xxsWrofEcrLCWfVKzN7xyxC4TCDDKFTCtrBoRChXA7uYNL2Ul+HjzEvw8VYnQuhB6sg60RS9gAxyO6gJ3VCDBmBvuvHkrjnWhYK+nlOMZfr4zx9CNiuNzxF9T0hN3i2ox+O56I9EZnoEbepmk8mVNqGfKiQzGLcYR6tmmp8HlYb33PfP/lqpEIMf0RomUWuog0tM1Aa3SB/1E+yq6dMApGdU6hBkZXOZNhmnMTJqf4vazTcymOTPj7xVCaGMD6v8ikpjssq8Wvr9s1If6sVlezJzv6GV+Z8Bwz/VLfvq5Jljm8nxcgJbsxM+2XOA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4986.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(66946007)(76116006)(5660300002)(54906003)(7696005)(86362001)(110136005)(52536014)(53546011)(6506007)(44832011)(316002)(66446008)(478600001)(9686003)(83380400001)(8936002)(71200400001)(64756008)(26005)(66556008)(66476007)(55016002)(186003)(2906002)(4326008)(7416002)(6636002)(8676002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Km2Do+H5BuYlJMf6c+P/rRe4FALxaxUk4YjBBZ75oNoz1w+xCC/Jot7WEpk+f+ylITroxWRNtqWh/TBDdkqs1QslvXKh8wLrVX5N3ol7NX5KACMli2YLlNbR+Wv5cQfKuOgmb/JTAxCKj6TafCJYfZPI/5ez9zJeqITCSo2l0l2gan19oMgKJyvToYkEZ3egMjFRBuyYv1wNejI/kaMQfaHJNyaBELSkD0du01TH0HWV+UJbI81l6KyoPFizzSNn1A8MGsBqszFH6f1sGngYo+CnoJuA64X+2hTKZhXlMjeArjCzz7I4EipmbCIxHMgcjB+S+JM8KNy7ChzY2XWmbkVEPCbVB/hSNcj7aNp1iIW1i7/W0540dVLdm1UghEGHNsUMWJ6/iwdkNVb/iFpqTolSZTfBd/7tFY/A4m1Y0gkbkCzjUuayMjCvQwlYtuyUpQ2bB09Lvb6OE8E2E6rUX91KTEP1PZLa8+tjNOUL8QUGo94X/oboPXUVG9S1JUAu
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4986.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81974cdc-228b-4021-4993-08d823ea23d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2020 09:26:20.2472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tnpseSHPgKdDTgUlM6+OOZF1d214gjGgrmRnOPf8eHxGePaXgpS5x0gu/boQrrUpgk3ttoJYF+3luC2BL4A/Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2616
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Sent: Thursday, July 9, 2020 2:50 PM
> To: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> Cc: linux-arm-kernel@lists.infradead.org; Makarand Pawagi
> <makarand.pawagi@nxp.com>; Diana Madalina Craciun (OSS)
> <diana.craciun@oss.nxp.com>; iommu@lists.linux-foundation.org; linux-
> acpi@vger.kernel.org; devicetree@vger.kernel.org; linux-pci@vger.kernel.o=
rg;
> Rob Herring <robh+dt@kernel.org>; Rafael J. Wysocki <rjw@rjwysocki.net>;
> Joerg Roedel <joro@8bytes.org>; Hanjun Guo <guohanjun@huawei.com>; Bjorn
> Helgaas <bhelgaas@google.com>; Sudeep Holla <sudeep.holla@arm.com>;
> Robin Murphy <robin.murphy@arm.com>; Catalin Marinas
> <catalin.marinas@arm.com>; Will Deacon <will@kernel.org>; Marc Zyngier
> <maz@kernel.org>
> Subject: [EXT] Re: [PATCH v2 12/12] bus: fsl-mc: Add ACPI support for fsl=
-mc
>=20
> Caution: EXT Email
>=20
> On Wed, Jul 01, 2020 at 07:55:28PM +0300, Laurentiu Tudor wrote:
> >
> >
> > On 6/19/2020 11:20 AM, Lorenzo Pieralisi wrote:
> > > From: Makarand Pawagi <makarand.pawagi@nxp.com>
> > >
> > > Add ACPI support in the fsl-mc driver. Driver parses MC DSDT table
> > > to extract memory and other resources.
> > >
> > > Interrupt (GIC ITS) information is extracted from the MADT table by
> > > drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c.
> > >
> > > IORT table is parsed to configure DMA.
> > >
> > > Signed-off-by: Makarand Pawagi <makarand.pawagi@nxp.com>
> > > Signed-off-by: Diana Craciun <diana.craciun@oss.nxp.com>
> > > Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> > > ---
> > >  drivers/bus/fsl-mc/fsl-mc-bus.c             | 73 ++++++++++++----
> > >  drivers/bus/fsl-mc/fsl-mc-msi.c             | 37 +++++----
> > >  drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c | 92
> > > ++++++++++++++++-----
> > >  3 files changed, 150 insertions(+), 52 deletions(-)
> > >
> > > diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c
> > > b/drivers/bus/fsl-mc/fsl-mc-bus.c index 824ff77bbe86..324d49d6df89
> > > 100644
> > > --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
> > > +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
> > > @@ -18,6 +18,8 @@
> > >  #include <linux/bitops.h>
> > >  #include <linux/msi.h>
> > >  #include <linux/dma-mapping.h>
> > > +#include <linux/acpi.h>
> > > +#include <linux/iommu.h>
> > >
> > >  #include "fsl-mc-private.h"
> > >
> > > @@ -38,6 +40,7 @@ struct fsl_mc {
> > >     struct fsl_mc_device *root_mc_bus_dev;
> > >     u8 num_translation_ranges;
> > >     struct fsl_mc_addr_translation_range *translation_ranges;
> > > +   void *fsl_mc_regs;
> > >  };
> > >
> > >  /**
> > > @@ -56,6 +59,10 @@ struct fsl_mc_addr_translation_range {
> > >     phys_addr_t start_phys_addr;
> > >  };
> > >
> > > +#define FSL_MC_FAPR        0x28
> > > +#define MC_FAPR_PL BIT(18)
> > > +#define MC_FAPR_BMT        BIT(17)
> > > +
> > >  /**
> > >   * fsl_mc_bus_match - device to driver matching callback
> > >   * @dev: the fsl-mc device to match against @@ -124,7 +131,10 @@
> > > static int fsl_mc_dma_configure(struct device *dev)
> > >     while (dev_is_fsl_mc(dma_dev))
> > >             dma_dev =3D dma_dev->parent;
> > >
> > > -   return of_dma_configure_id(dev, dma_dev->of_node, 0, &input_id);
> > > +   if (dev_of_node(dma_dev))
> > > +           return of_dma_configure_id(dev, dma_dev->of_node, 0,
> > > + &input_id);
> > > +
> > > +   return acpi_dma_configure_id(dev, DEV_DMA_COHERENT, &input_id);
> > >  }
> > >
> > >  static ssize_t modalias_show(struct device *dev, struct
> > > device_attribute *attr, @@ -865,8 +875,11 @@ static int
> fsl_mc_bus_probe(struct platform_device *pdev)
> > >     struct fsl_mc_io *mc_io =3D NULL;
> > >     int container_id;
> > >     phys_addr_t mc_portal_phys_addr;
> > > -   u32 mc_portal_size;
> > > -   struct resource res;
> > > +   u32 mc_portal_size, mc_stream_id;
> > > +   struct resource *plat_res;
> > > +
> > > +   if (!iommu_present(&fsl_mc_bus_type))
> > > +           return -EPROBE_DEFER;
> > >
> > >     mc =3D devm_kzalloc(&pdev->dev, sizeof(*mc), GFP_KERNEL);
> > >     if (!mc)
> > > @@ -874,19 +887,33 @@ static int fsl_mc_bus_probe(struct
> > > platform_device *pdev)
> > >
> > >     platform_set_drvdata(pdev, mc);
> > >
> > > +   plat_res =3D platform_get_resource(pdev, IORESOURCE_MEM, 1);
> > > +   mc->fsl_mc_regs =3D devm_ioremap_resource(&pdev->dev, plat_res);
> > > +   if (IS_ERR(mc->fsl_mc_regs))
> > > +           return PTR_ERR(mc->fsl_mc_regs);
> > > +
> > > +   if (IS_ENABLED(CONFIG_ACPI) && !dev_of_node(&pdev->dev)) {
> > > +           mc_stream_id =3D readl(mc->fsl_mc_regs + FSL_MC_FAPR);
> > > +           /*
> > > +            * HW ORs the PL and BMT bit, places the result in bit 15=
 of
> > > +            * the StreamID and ORs in the ICID. Calculate it accordi=
ngly.
> > > +            */
> > > +           mc_stream_id =3D (mc_stream_id & 0xffff) |
> > > +                           ((mc_stream_id & (MC_FAPR_PL | MC_FAPR_BM=
T)) ?
> > > +                                   0x4000 : 0);
> > > +           error =3D acpi_dma_configure_id(&pdev->dev, DEV_DMA_COHER=
ENT,
> > > +                                         &mc_stream_id);
> > > +           if (error)
> > > +                   dev_warn(&pdev->dev, "failed to configure dma: %d=
.\n",
> > > +                            error);
> > > +   }
> > > +
> > >     /*
> > >      * Get physical address of MC portal for the root DPRC:
> > >      */
> > > -   error =3D of_address_to_resource(pdev->dev.of_node, 0, &res);
> > > -   if (error < 0) {
> > > -           dev_err(&pdev->dev,
> > > -                   "of_address_to_resource() failed for %pOF\n",
> > > -                   pdev->dev.of_node);
> > > -           return error;
> > > -   }
> > > -
> > > -   mc_portal_phys_addr =3D res.start;
> > > -   mc_portal_size =3D resource_size(&res);
> > > +   plat_res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > +   mc_portal_phys_addr =3D plat_res->start;
> > > +   mc_portal_size =3D resource_size(plat_res);
> > >     error =3D fsl_create_mc_io(&pdev->dev, mc_portal_phys_addr,
> > >                              mc_portal_size, NULL,
> > >                              FSL_MC_IO_ATOMIC_CONTEXT_PORTAL,
> > > &mc_io); @@ -903,11 +930,13 @@ static int fsl_mc_bus_probe(struct
> platform_device *pdev)
> > >     dev_info(&pdev->dev, "MC firmware version: %u.%u.%u\n",
> > >              mc_version.major, mc_version.minor,
> > > mc_version.revision);
> > >
> > > -   error =3D get_mc_addr_translation_ranges(&pdev->dev,
> > > -                                          &mc->translation_ranges,
> > > -                                          &mc->num_translation_range=
s);
> > > -   if (error < 0)
> > > -           goto error_cleanup_mc_io;
> > > +   if (dev_of_node(&pdev->dev)) {
> > > +           error =3D get_mc_addr_translation_ranges(&pdev->dev,
> > > +                                           &mc->translation_ranges,
> > > +                                           &mc->num_translation_rang=
es);
> > > +           if (error < 0)
> > > +                   goto error_cleanup_mc_io;
> > > +   }
> > >
> > >     error =3D dprc_get_container_id(mc_io, 0, &container_id);
> > >     if (error < 0) {
> > > @@ -934,6 +963,7 @@ static int fsl_mc_bus_probe(struct platform_devic=
e
> *pdev)
> > >             goto error_cleanup_mc_io;
> > >
> > >     mc->root_mc_bus_dev =3D mc_bus_dev;
> > > +   mc_bus_dev->dev.fwnode =3D pdev->dev.fwnode;
> >
> > Makarand, this looks a bit weird. Is there really a reason for it?
>=20
> Can you clarify please so that we can reach a conclusion on this matter ?
>=20
Laurentiu, can you clarify what exactly is the doubt here? Are you asking a=
bout fwnode assignment from pdev to mc_bus_dev?

> Thanks,
> Lorenzo
