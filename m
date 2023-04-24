Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85D56ECA8B
	for <lists+linux-pci@lfdr.de>; Mon, 24 Apr 2023 12:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjDXKql (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Apr 2023 06:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjDXKqk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Apr 2023 06:46:40 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2114.outbound.protection.outlook.com [40.107.113.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E276E55;
        Mon, 24 Apr 2023 03:46:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=exc066oI0OuScDz/bjuquLMZlU1jp/Us0aiytpI0gJEy4LDnWyl6I/BmuogRufi42xi1zgmnCoJ+byC9uY/tQvtYTPj0bdX9GaLVzzJoLjPhl6buq5Hm26ElSvxRWPDgo8zIUI4bQor/YNctsugigGhrIFWv0cX9/fBWEdxXBXoF2fVM9cHNT/mbeWgPtTpXOJPOeO8+A3aALBZLhnHpA0dHRHIEVlLJQid7y0/b/9caaP8sbLbjBcMFNdwVssSMxnDiJmDvyG+koRQMkvCcAsHHzDyeE3rKq5VadTJf2TkX3R2J1RFUa8OMFV85GwpOphp1Z+abyiN3bgLz/dx/Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w768EFQVtyO6Xu7t2gtVMrVvkssXEpWeudHC60jt1Uc=;
 b=Bd01rZ6lz6aWB44is3y7J05F9Kh6cggrQq2oG7bfpXonNhjwlBiPUIQ1tHP5pX0ZpKZx9nwDUIIRkDNk4t383oI+gngq2KkmaFL834pFhZMStWrP12Zm+tfqfzYj09mZZmiEpVwr/4IfLPPM6LZsVhSzUwgmRa9k6adJYxh6InIDcl9gJDWu/U7nEY6hprvB2608WSHRASQz82UUP+PB05Z/pxa18UkOJbZ4f3axDYgdx6pjN/Cidp4IMZVfrS4f2+QnMS75AyHKwJHEvQ59nnhsuxniZIqUtMlZcuP1+Wo6TwEDz+svOxArE+oGJxuHPCIGD8zL1OWrtV3IbEcy5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w768EFQVtyO6Xu7t2gtVMrVvkssXEpWeudHC60jt1Uc=;
 b=gpgT1AwD14rY5UQ+qjIwHjGPZZ5ypzHB/xSKFBOK/6t/ZWf5N9ca0wlnAQxlfURb9NxuFaWiyR9W5TmKr8gX1VziWHcMVPxVn00fJTdJ4pVqBSJNMw0VUUVZucz1XbUWBQfdzaIXYSZBlW8/XeSRlGnrGPqZINKVtYeIe0YK00M=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TY3PR01MB10943.jpnprd01.prod.outlook.com
 (2603:1096:400:3b3::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 10:46:34 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003%5]) with mapi id 15.20.6319.033; Mon, 24 Apr 2023
 10:46:34 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "fancer.lancer@gmail.com" <fancer.lancer@gmail.com>,
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
Subject: RE: [PATCH v13 19/22] PCI: rcar-gen4: Add R-Car Gen4 PCIe Host
 support
Thread-Topic: [PATCH v13 19/22] PCI: rcar-gen4: Add R-Car Gen4 PCIe Host
 support
Thread-Index: AQHZcfCxo7TT9DodmkGOf0ufH8x9Ea83bD0AgALN72A=
Date:   Mon, 24 Apr 2023 10:46:34 +0000
Message-ID: <TYBPR01MB5341ECD1B54BE8DBFECAA616D8679@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230418122403.3178462-1-yoshihiro.shimoda.uh@renesas.com>
 <20230418122403.3178462-20-yoshihiro.shimoda.uh@renesas.com>
 <20230422143810.GP4769@thinkpad>
In-Reply-To: <20230422143810.GP4769@thinkpad>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TY3PR01MB10943:EE_
x-ms-office365-filtering-correlation-id: 7eaad600-e23f-4e20-18b0-08db44b12c68
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5giebOXz5KJFPo+ojZ3d0kKZhyPEiSL09vUqGdKDFIQJEF5H67pjFcXxsrpmTfHGJBYnFKus6XzYZQq9vyi/53E4IoKRoNvVb4E6wFwu25WZw14uRs5nhNUa9OkBXvy4t+vZNoEcYph6nzxMhIHD5uIYdOVaIoGkBCCwVjLlGJoNRMUVjV3/k4OD+KJ58ob833HgEzYolGokktC0QBCgRDHqBR1+1wTbqbbIKQzxq6HJA7SMn7BP2oZqI70SAm6DTkM9yWRfiNpQHyyPgRGHDQpH5xZjZyLHWUq1qtVndEnxQ66Uun/NAX5m0MkXACscJiMxjaYrH6kI0/aufyqXDBFQ/xE1Ngm0gouvnRPQ5LZbS2+MwHQcs+ZfS6XTnwiSzs3Upb9eGGHYnCh2pPB6l5hRb+5KBOmPvcaGKCbLf3IMx/vsVZPzjqt10Qoz1jqk0aSZc90loBE0vccBqxyu8Pk8k4kn2xtHwu2qSpruNWSmtrQ2yYRiwZKwQqvmyJw0XivRJuOHyW+cRYXyVP0herk70ALdiUvHFLDGEjfK7A9JtepKMyv8rISny5hOalZbDn2SL0fyz2uUYaAfeCgdnYrj4Wz8oqihhjbEgaO2kwB3EBZPa2OeLr28A/Tx1jN4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(451199021)(2906002)(30864003)(7696005)(71200400001)(55016003)(9686003)(6506007)(186003)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(8676002)(8936002)(316002)(41300700001)(6916009)(4326008)(478600001)(5660300002)(52536014)(7416002)(54906003)(38070700005)(38100700002)(122000001)(86362001)(33656002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6G0VAcihYhv6m30xTJn8aCdtd3G27KYAWloiZ4Pz77yU5MlHLwp7YlzfTobX?=
 =?us-ascii?Q?vRix0qMps9df/yj9CnqwAqQfkX8Whdso3DnDFBnmNE1DRmWC/auhiKGCjc14?=
 =?us-ascii?Q?7wsHyIcEVu1qZMltWeVmNF3pAec66iiQuD3LRMe3Zmb+9miIGykzBXczz/zC?=
 =?us-ascii?Q?pdwBomRcLvjQB7DD6Asg4HG36E1V5ueiF93jJccsO27WXuVsmMw9bo6wTCYs?=
 =?us-ascii?Q?lcl2aZ2iVtE1RaO2AfjoISpAVE7iVzi2KZVAjFModS6GDXp5qskIuUIz9M83?=
 =?us-ascii?Q?Hp+5lKVyea8bTNlnN9u0dIYMH53j3XkIf9049b8D3oNljN65wnC7bFy63pbm?=
 =?us-ascii?Q?I7rfAKzLEJsoS4+N8JdBlZWhgCtU4xLCuzQVC71RCYNdr0P5YbHf5JMFx2ya?=
 =?us-ascii?Q?4Fwdt41v5Dz819FR/f0C2jb4tthIW2vfFlGnWFhGuur7j2KdQTdPo0cWG5iT?=
 =?us-ascii?Q?fJvbgD1EEqPymEeyENtb9a0tIhs+sQCucj+xKSWoezNxPnMRfb3fszSgwK0D?=
 =?us-ascii?Q?mDlBrTJjbq9roUQTjK17YXybwa6OhkqcLLfyjSUvd7TGv64aDmp7xfEB81eW?=
 =?us-ascii?Q?IcildiC6xZpGXqKXk46dr5N18nfCvptkFb6ULVeCGjUgwQYuMNX0c14lzrJf?=
 =?us-ascii?Q?1AlS/69CJQxVcttpdSdqJ+FbH3Dfmg2TuGz+WxUS0J4cc1br/LzCeWZS4Zyy?=
 =?us-ascii?Q?WAttcHucnBQ5unnOlC/T6G1IH+tUTqId4Ch6/g7v/45EnBcK698W/Ulh1U8i?=
 =?us-ascii?Q?FY6mLGMZx104O+d0IjJL93kPHYFJH166pTfQqnU9a+Lm5i80BfUeu6IDetTX?=
 =?us-ascii?Q?MGGK+ra76LGz795sADfI8r11vny5jYauvkRM/K1jd+9KQHBY7YEbJqh2BsQ9?=
 =?us-ascii?Q?tu27gpoE0ZhIeCyk9zU9ziu695lVANCtkvpdoVt7v8s9Rf1ZStwN/h6HYgtB?=
 =?us-ascii?Q?LVAnZjqjkGSLOHIpD2zhwrLrKyyLsShHomnRurnBvuOL52xwkc1tvyqdyVh3?=
 =?us-ascii?Q?ZVUtqMAoRAUUGboz//jPslycGlC0CQty9Fh1aPM0ykVy1Y3E5eWa6T4rvVSb?=
 =?us-ascii?Q?mj2bVRuHTETyTUGzTVJQ/sJpaVCz+T2lhOGin0wcrAJaVS8zt2grBoRimPsP?=
 =?us-ascii?Q?Dv9QP2pzTDEexlbqArVbn9WJ+ttPeYcDb3SaRb4FhpvCpzZAWLmNYv1mr5iR?=
 =?us-ascii?Q?9QAw6pOODbhCi6RzOM8j4x2hsR0pfFQVrwKpiNl19BUh7S3pqB5Ikhi8fT25?=
 =?us-ascii?Q?E7Oen0gd3x7s+7JHnZQWfYc8+cC3b7Cz9T37fCP0KZaCuSuoKiMRx+26xMXj?=
 =?us-ascii?Q?6fDtP/WqKLFabyde5Tlx4JLDAEUO7YffzO21q9fCW6wZ/+NJTchxe4nnIPWx?=
 =?us-ascii?Q?+Jd2EVoNQ8ddRD2GJirnb3QmjPthH37j/ZGtmtNq6a+EfWJbDW2ULsi1WK6Z?=
 =?us-ascii?Q?TleDW/yg5ghX757V+3Lo3AGQSFFKiGnY86ij9bDb1+1BRIjF+4Ce+N2zBO8k?=
 =?us-ascii?Q?D6Rh4aVbQWZEsh0/+uQlR6njRJgLCSRK6sgqAhGYICM0kIMCDbR+rDWe0yr2?=
 =?us-ascii?Q?7kLHrkXfYGC/R/91YWjoUp+rdUk4ukGWOkQqrroljX4MQu/RscZJo1FZHWDG?=
 =?us-ascii?Q?gmVXzzZsettILr46TVBxAxgK7QLweeCQQY2lk5CtNtnqmyM0ndsFqqKA3PFJ?=
 =?us-ascii?Q?KY7XDw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eaad600-e23f-4e20-18b0-08db44b12c68
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2023 10:46:34.7694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VyDG77/c0XBYc8Gs1spZa6A7YBIo3VT1bzSo37VUoVbXsTPPtqPwx2Feo6lRXN5XllWiEvhhuhQ1fIDmxeiP9GJN98l4RGEl/F4Wtj+bmzXxIB0uzUMXf8/z/uZgS+AE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10943
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Manivannan,

> From: Manivannan Sadhasivam, Sent: Saturday, April 22, 2023 11:38 PM
>=20
> On Tue, Apr 18, 2023 at 09:24:00PM +0900, Yoshihiro Shimoda wrote:
> > Add R-Car Gen4 PCIe Host support. This controller is based on
> > Synopsys DesignWare PCIe.
> >
>=20
> It is good to add more details about the controller here like retraining =
etc...

I got it. I'll add such description.

> Also, please justify why you have added some helpers in a separate file. =
If
> those helpers are going to be used in other drivers now, then it should b=
e
> mentioned here.
>=20
> NOTE: It may be used in future is not a valid justification.

I'll add such description too.

> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> >  drivers/pci/controller/dwc/Kconfig            |   9 +
> >  drivers/pci/controller/dwc/Makefile           |   2 +
> >  .../pci/controller/dwc/pcie-rcar-gen4-host.c  | 134 +++++++++++++
> >  drivers/pci/controller/dwc/pcie-rcar-gen4.c   | 187 ++++++++++++++++++
> >  drivers/pci/controller/dwc/pcie-rcar-gen4.h   |  49 +++++
> >  5 files changed, 381 insertions(+)
> >  create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4-host.c
> >  create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4.c
> >  create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4.h
> >
> > diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controlle=
r/dwc/Kconfig
> > index d29551261e80..eb90e2116e59 100644
> > --- a/drivers/pci/controller/dwc/Kconfig
> > +++ b/drivers/pci/controller/dwc/Kconfig
> > @@ -415,4 +415,13 @@ config PCIE_FU740
> >  	  Say Y here if you want PCIe controller support for the SiFive
> >  	  FU740.
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
> > index 000000000000..067fbd2a8d50
> > --- /dev/null
> > +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4-host.c
> > @@ -0,0 +1,134 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * PCIe host controller driver for Renesas R-Car Gen4 Series SoCs
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
> > +static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
> > +{
> > +	struct dw_pcie *dw =3D to_dw_pcie_from_pp(pp);
> > +	struct rcar_gen4_pcie *rcar =3D to_rcar_gen4_pcie(dw);
> > +	int ret;
> > +	u32 val;
> > +
>=20
> Don't you need to assert perst before starting controller config?

You're correct. Without assert perst, a PCIe device is possible to work,
but this driver should assert it with msleep(100) interval here.

> > +	ret =3D rcar_gen4_pcie_set_device_type(rcar, true, dw->num_lanes);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	dw_pcie_dbi_ro_wr_en(dw);
> > +
> > +	/*
> > +	 * According to the databook, we should disable two BARs to avoid
>=20
> Which databook? Synopsys DWC?

Yes, it's Synopsys DWC. I referred the section 3.5.7.2 "RC Mode" in DWC PCI=
e Dual Mode Rev.5.20a.

> > +	 * unnecessary memory assignment during device enumeration.
> > +	 */
> > +	rcar_gen4_pcie_disable_bar(dw, PCI_BASE_ADDRESS_0);
> > +	rcar_gen4_pcie_disable_bar(dw, PCI_BASE_ADDRESS_1);
>=20
> I don't see a need for this function. With dbi_ro_wr_{en/dis}, it's bette=
r to
> directly use the dbi accessors here.

I got it. I'll fix them.

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
> > +	gpiod_set_value_cansleep(dw->pe_rst, 0);
>=20
> If you end up adding perst assert above, add a 100ms delay before deasser=
t.

I got it.

> > +
> > +	return 0;
> > +}
> > +
>=20
> [...]
>=20
> > +
> > +static struct platform_driver rcar_gen4_pcie_driver =3D {
> > +	.driver =3D {
> > +		.name =3D "pcie-rcar-gen4",
> > +		.of_match_table =3D rcar_gen4_pcie_of_match,
> > +	},
> > +	.probe =3D rcar_gen4_pcie_probe,
> > +	.remove =3D rcar_gen4_pcie_remove,
>=20
> You should consider adding PROBE_PREFER_ASYNCHRONOUS here to avoid blocki=
ng
> other drivers while waiting for link_up during boot.

I see. This controller can add PROBE_PREFER_ASYNCHRONOUS without any proble=
m.
So, I'll add it on v13.

> > +};
> > +module_platform_driver(rcar_gen4_pcie_driver);
> > +
> > +MODULE_DESCRIPTION("Renesas R-Car Gen4 PCIe host controller driver");
> > +MODULE_LICENSE("GPL");
> > diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/=
controller/dwc/pcie-rcar-gen4.c
> > new file mode 100644
> > index 000000000000..89cec76a41ab
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
> > +	/* Require retraining here. Otherwise RDLH_LINK_UP may not be set */
>=20
> Any other platform expected to not require retrain?

I'm afraid but I don't know other platforms' requirement... But,
the RDLH_LINK_UP of PCIEINTSTS0 register is this controller specific,
so that retrain is required here.

> > +	if (rcar->needs_retrain && !rcar_gen4_pcie_check_retrain_link(dw))
> > +		return 0;
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
> > +	/* Note: Assume the reset is asserted here */
>=20
> What about this assumption?

Oops. "the reset" means that this controller's one in the SoC which
is controlled by a reset_control driver.. I should have revised this
description after I added pe_rst handling. I'll revise this comment on v13.

> > +	val =3D readl(rcar->base + PCIEMSR0);
> > +	if (rc)
> > +		val |=3D DEVICE_TYPE_RC;
> > +	else
> > +		val |=3D DEVICE_TYPE_EP;
>=20
> newline

I got it.

> > +	if (num_lanes < 4)
> > +		val |=3D BIFUR_MOD_SET_ON;
>=20
> newline

I got it.

> > +	writel(val, rcar->base + PCIEMSR0);
> > +
> > +	return reset_control_deassert(rcar->rst);
> > +}
> > +
> > +void rcar_gen4_pcie_disable_bar(struct dw_pcie *dw, u32 bar_mask_reg)
> > +{
> > +	dw_pcie_writel_dbi2(dw, bar_mask_reg, 0x0);
> > +}
> > +
> > +int rcar_gen4_pcie_prepare(struct rcar_gen4_pcie *rcar)
> > +{
> > +	struct device *dev =3D rcar->dw.dev;
> > +	int err;
> > +
> > +	pm_runtime_enable(dev);
> > +	err =3D pm_runtime_resume_and_get(dev);
>=20
> Why do you need do runtime_resume here? You don't have the runtime PM cal=
lbacks
> implemented. Even if you did, it may end up with a crash as you have't ca=
lled
> dw_pcie_host_init().

The runtime PM APIs can handle power-domain and common clock framework.
Especially, I intended to handle common clock framework by runtime PM witho=
ut
any runtime PM callbacks. In other words, runtime_resume is required before
dw_pcie_host_init() is called. Otherwise, any registers of this PCIe contro=
ller
cannot be accessed.

> Overall, I think you don't need to call any of the pm_runtime APIs now.
>=20
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
> > +static int rcar_gen4_pcie_devm_reset_get(struct rcar_gen4_pcie *rcar,
> > +				  struct device *dev)
> > +{
> > +	rcar->rst =3D devm_reset_control_get(dev, NULL);
> > +	if (IS_ERR(rcar->rst)) {
> > +		dev_err(dev, "Failed to get Cold-reset\n");
>=20
> Is this cold-reset or core-reset?

This is cold-reset.

Best regards,
Yoshihiro Shimoda

> - Mani
