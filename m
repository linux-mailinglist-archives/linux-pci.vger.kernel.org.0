Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 804FF351149
	for <lists+linux-pci@lfdr.de>; Thu,  1 Apr 2021 10:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233863AbhDAIyS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Apr 2021 04:54:18 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:56586 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234011AbhDAIyK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Apr 2021 04:54:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1617267275; x=1648803275;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=wgjZQtRHIQ90PgYH5pgmaoZowg6Xz4++KCSz9IX7RiU=;
  b=IPp21BWnQkerzRTMU7OrWqlqc/qOzP5VwFvlbeeQ1U2w07OWEhH3so17
   8MEGDdyOa7oEbe67eWdtEiPrKSibtltH0TVG+h4BoWawheY+vAKTFH6+y
   4id1p9+0DNEL9hSg7ryt6Ra8exMzItjJwwDmn6iJnUoDoo8RbFxzmPg8P
   OnMuwhf53unT3Hti5HSx/ogewLvfWmOHQ3uQa7Y/wYFaqtNtqD55cSyZB
   JYHrkGx7nT2pf3z5qOhxBv1nZ03Ov31XwX+vPj4lSA9sy5oz9TM1mp4yY
   jWFqm6CUyUxrKy4oU3EcH0QcWAiDUm92tYtc0vMbyl92Qdb+i6v1EItOx
   w==;
IronPort-SDR: gKlwEDsGmSo+at/HAdkGsAvaTgN5s2SvhyRbxKZP7Z5g5VAvGCAKo1719o7+gJ4ar5JZV/H5WC
 NWge8TBDzk4DyX8dFsBnNQBjlc13U09wxY819KEEx68KbCEda7AzAieD2BKWbUVqxctx5Wlt4F
 q60O7TGNr7/Tag05rkf85oGwOWOZt6cz9XrjGvdQOisfrqMLFpDyNs6tEuaiQkkWBrk8YIxBQH
 jhzqhya2YTGSWSIJJMDmlK865O6bstsOD8R1ZFmEgNwOhBzDiUQbmSM8exeAvnSNmS2LLs7Whp
 1UE=
X-IronPort-AV: E=Sophos;i="5.81,296,1610380800"; 
   d="scan'208";a="267949969"
Received: from mail-bn8nam12lp2174.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.174])
  by ob1.hgst.iphmx.com with ESMTP; 01 Apr 2021 16:50:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hwM8J6cdkGrhWsk8QdeH6sNqHc/vVBxmwpQGZ23KmWd2ra+eqIg96S10scypvMCuLcmOz50HX4teuhVHJ/Rr9RFwN4pBGIH260ilj+vOewugbWr7CUb2sDY5mx7s2BMyY5rrPp1H3f67VlXk5mcn/2/hRqVq7CSXBCGs/URY5hbQ/Ops0dFtn2VP0/k43QdWSt9AuGvWHglZ9t4YpY6AH7K7KpfGxqQaKWqIY4HGYb04Ow6D0vOd3BHe1o3qJn6Ik0HzYGUj3iX/g9S1AvuMAs1ciNiBhKo56Z9Bk87EQiM0AZEjemIAsK5tENguNRv0Qj2soy8DRLfEyA537kIMiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PbShSv/r3BiVflw4Dv7elU7+NfmyITITjavesL6I684=;
 b=VqP+Nf3MHwelSeW2pFlcWf5/aMumQm6DJBR1xB8pdqzj9upj7n/tO2mERZFpb/M0YnkvfaNnbsRdgSsDy2347gkPkoOQitREuUC7Yew4ho8kWWiFJQgLMt3OG31yuhLPQ2yS1wOLVocJF4DPFI9FoQrUHj/o1v0ejDTHlLM/x9ZGOLXNWaZN0SiOL+YEyjysHVB+kElY/Z0Qu70KuGJjUtIJ6vkgKCOdhY83rxQUITc4mHcDtGgFWW4SG5/g8Cg7tASz/N9bc+aUKlv55B2fGobfoId4md2CArB0DKQ7DXl840U19cnNG/Y1Gmv3mQPHfG1BeQw2kTBTxDUpUnEa0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PbShSv/r3BiVflw4Dv7elU7+NfmyITITjavesL6I684=;
 b=OpJwSu4ydCRTbKSYP6T1pSeB0de2kWgRkx1YIukBb9aKMR22X2pZ70HZekrhHhSDct6tRLrkE3lPnbvScjHhH8RF0NMQKqogaiJHaw48aSIq22xXyb7R4KukVr2WleshrXXu2+ekz/HCX4CBwf7uN2V+DmgVjdsAz+jJFBLxA4k=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB6894.namprd04.prod.outlook.com (2603:10b6:208:1ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Thu, 1 Apr
 2021 08:51:14 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887%3]) with mapi id 15.20.3999.029; Thu, 1 Apr 2021
 08:51:14 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Greentime Hu <greentime.hu@sifive.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "hes@sifive.com" <hes@sifive.com>,
        "erik.danie@sifive.com" <erik.danie@sifive.com>,
        "zong.li@sifive.com" <zong.li@sifive.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "alex.dewar90@gmail.com" <alex.dewar90@gmail.com>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "hayashi.kunihiko@socionext.com" <hayashi.kunihiko@socionext.com>,
        "vidyas@nvidia.com" <vidyas@nvidia.com>,
        "jh80.chung@samsung.com" <jh80.chung@samsung.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>
Subject: Re: [PATCH v4 5/6] PCI: fu740: Add SiFive FU740 PCIe host controller
 driver
Thread-Topic: [PATCH v4 5/6] PCI: fu740: Add SiFive FU740 PCIe host controller
 driver
Thread-Index: AQHXJryVLlFTcA0IMUCQSslO/VnpAQ==
Date:   Thu, 1 Apr 2021 08:51:14 +0000
Message-ID: <BL0PR04MB65147AFB577E2087BB36414BE77B9@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210401060054.40788-1-greentime.hu@sifive.com>
 <20210401060054.40788-6-greentime.hu@sifive.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: sifive.com; dkim=none (message not signed)
 header.d=none;sifive.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:c833:f159:51bd:bd52]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bca90344-e5e1-49b9-0ee9-08d8f4eb4ea0
x-ms-traffictypediagnostic: MN2PR04MB6894:
x-microsoft-antispam-prvs: <MN2PR04MB6894F1455F28DDD8FE8B1C94E77B9@MN2PR04MB6894.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xSpGR/bmdG+Jk3t5J3IGgjJjajMPOxCnlnBWWAgrO4eA6lb1i548Q1Wh/d4Dj6JROFiStOwGC6PiLT5Sp2WW1seNVlKzBd2aXZF2SJu9Z8VQdqskkqFC7aIEvXgytmivRnWq05Cf7po8FnIXTbXRUgK6qTUrEjwT+FiONImHxdAg9fCfxl19e0HcRJ+HDOhUwqyoAIjB+6p5y3CIBr49PW4mU1z1osdzxVlU2yEGe4Bz+MGI8JMU5aHPT2C6S0UqXhasBLWEOxKWkCIGTf3DgAEpc4v+hH8gGxjNtTuAUx9CzQrBDxu6NbbqIKs4zHsJejOSK84PAuBtugJOpXMIkdD95G69OpuLMgVmBMKXevS79DWqNVBqWOooczDfsCQBtmIu+Qg0Ji9IXksKHW6s52DKY4MuygoQusfYa7NtU640U7BHXKzA0ZnpwjdqlAiOzH08z9GwuUmL8K5cTZWUXoFIemwjpEwAv1OG/k3egyfjN0QGUdvex6LrvgZweOtGnuxqQcWL1kt010qhF4bTtgX+4rjShmhJxXwGSQYuUz0kF/oYR+R6Odiq1+DTuQihqJijpWu+DlzaFnoLFW+DUibuC9ywlbIOqFPM4jz3xBCguMD87M2odZ6rn7KsfaVxgTY/dWdpehSkeKG+q6ADqOy2wFIs9+kpkA5W5tpBAHCIs2lSo+pNTU/+34xC4B4qZ+xFjkj0u4Lqh2LqnDBW+e/QUMTQ+JiiXYkV6r5iYXcRW7gbCfX75iBMxvph5ya9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(6029001)(4636009)(136003)(346002)(376002)(396003)(366004)(39860400002)(186003)(110136005)(76116006)(8676002)(86362001)(66556008)(8936002)(7416002)(478600001)(66476007)(66946007)(7696005)(91956017)(66446008)(30864003)(64756008)(52536014)(316002)(53546011)(9686003)(71200400001)(6506007)(38100700001)(33656002)(55016002)(921005)(2906002)(5660300002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?usIJvPeXyAX2irWqKZu4r0l2IeJmYYPvwIav57+7fHsezA8N8JP7eZmform6?=
 =?us-ascii?Q?pdXsoGAdtx7iDJn2Czv/rOj5+IkijHyV7CbWl4alUH0p3cRgt31l76N7+QXH?=
 =?us-ascii?Q?yNV4G/JxeH9HQCBiw0PkwRxxlRut0GeVYXmCS+oIku0PlBPeNzTOOfmuAAu+?=
 =?us-ascii?Q?l+QX/e4/CARaF/t62S9+I5Vc2bvVPzcLSthilJQGgKdqJQ13MUKH056WxOYf?=
 =?us-ascii?Q?DGQxqEu5lEL5RvAyXJP6fyune/aL9LJyINZue4DybhIzoXdOvOspfXaVsgJP?=
 =?us-ascii?Q?r440+3KxNb2y/f1TNLkpWgvA0Wiuw2c88M8UHV6dEEdNTmOdAsKStC+Zvnn2?=
 =?us-ascii?Q?oIC/+/zYRWEyIjtt0/CCD5I+dnn9/WeOdFuf/8CSe2YnFAZYTSEwjGj2A296?=
 =?us-ascii?Q?rHzkh5+fQg1siwYl74AWWkKlk1GQIazWwGXbsraH+3k+4xO1BCMUJp/uS3q7?=
 =?us-ascii?Q?nbgk14Tz3AcDRszG6HPurxlBLQd4dlKOm6tWQSgl+9nWbwobSpd9O9Ppf109?=
 =?us-ascii?Q?Rq42GqWniw6x6Q6F+UBIJWX8EH0PHh4ckKPEuBgePKuQJAKR5afF8vGu47sg?=
 =?us-ascii?Q?Jp0iQ1WRhbE9RaBOGtR3/J2Y/eww5VPeuP4eQY001y/HLAijIwSeW48GT3jp?=
 =?us-ascii?Q?A26FnkTdw10JF9LAJRLx34/xxJ1Idz0jlQqsuvooQYqKlahRfgpSqCPa8G33?=
 =?us-ascii?Q?5GiQ0fjlfSRRbWGlOT+NCOPBJtp80Vexrzb54/kDCkuI0baY+riweBbVQdfy?=
 =?us-ascii?Q?ORswmHKwQAugb/+1ha2BKJ3c7YxNJcD5C4lBtVU6CrB2A2t+tNpdbq9ymwjw?=
 =?us-ascii?Q?fAYloNK1Fje9l6BQh6cHhrBfzD8s448IYlp4ArM0zLvQdyVtyJVyVF28vQlN?=
 =?us-ascii?Q?/3KcOFwPb2FMjIA9Mg/3lS3IlvBTJ5dTT3qxKXZWmVqpb+Pc+2lOJau/X2WV?=
 =?us-ascii?Q?1urwqy+T229q/6SnwiKmWDarNmedvzSaSyFhQWVlKCQAiQQX5FwxB+hN55DA?=
 =?us-ascii?Q?sh1ZHuNJPLT7V1HJboqWdejkgURuNISCD2IHR7aSsdt+Gz64d50MdSRYcvkl?=
 =?us-ascii?Q?D8jeI/QmgyIFDEJonpQjXFnLDORCZl29g4/0qmb6Hg6g719T7ozXURgmUoJ/?=
 =?us-ascii?Q?31iS9sdPxVgH0g9Quu8NlRW04sUSGyIOeCKSEKqpz5frlQmc0bSYTpZvImo1?=
 =?us-ascii?Q?tgOg3HZ7D1znn0N51Unxz6VjCejOhvfvDzcjjXsE+LDJvwrDNHVYZieb5i1G?=
 =?us-ascii?Q?Ngm9WkqeHz4W55z5tLHZDbPj9zKRErf3use/E5bWuGaFef2K0JMLPZce+nl7?=
 =?us-ascii?Q?0cNPq37lIMbmCFGTY/nU+FsD4vpR2C4vA3iLqtv9oXEZIWbLv5tSdxvl9zqZ?=
 =?us-ascii?Q?vgHkZuQsGNhIq2trpRLpAH2XJ/8kt5gLBcNqlfGSvlc9P54uMA=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bca90344-e5e1-49b9-0ee9-08d8f4eb4ea0
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2021 08:51:14.5723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wokpHxf31FKtdaKDH/XAqmm31ipdrh6XByRCGER+Y52myqkEshLTXDJDJpbzNn6Y42ANmRQfFvGaC5qQjRQVxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6894
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021/04/01 15:02, Greentime Hu wrote:=0A=
> From: Paul Walmsley <paul.walmsley@sifive.com>=0A=
> =0A=
> Add driver for the SiFive FU740 PCIe host controller.=0A=
> This controller is based on the DesignWare PCIe core.=0A=
> =0A=
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>=0A=
> Co-developed-by: Henry Styles <hes@sifive.com>=0A=
> Signed-off-by: Henry Styles <hes@sifive.com>=0A=
> Co-developed-by: Erik Danie <erik.danie@sifive.com>=0A=
> Signed-off-by: Erik Danie <erik.danie@sifive.com>=0A=
> Co-developed-by: Greentime Hu <greentime.hu@sifive.com>=0A=
> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>=0A=
> ---=0A=
>  drivers/pci/controller/dwc/Kconfig      |   9 +=0A=
>  drivers/pci/controller/dwc/Makefile     |   1 +=0A=
>  drivers/pci/controller/dwc/pcie-fu740.c | 324 ++++++++++++++++++++++++=
=0A=
>  3 files changed, 334 insertions(+)=0A=
>  create mode 100644 drivers/pci/controller/dwc/pcie-fu740.c=0A=
> =0A=
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/=
dwc/Kconfig=0A=
> index 22c5529e9a65..0a37d21ed64e 100644=0A=
> --- a/drivers/pci/controller/dwc/Kconfig=0A=
> +++ b/drivers/pci/controller/dwc/Kconfig=0A=
> @@ -318,4 +318,13 @@ config PCIE_AL=0A=
>  	  required only for DT-based platforms. ACPI platforms with the=0A=
>  	  Annapurna Labs PCIe controller don't need to enable this.=0A=
>  =0A=
> +config PCIE_FU740=0A=
> +	bool "SiFive FU740 PCIe host controller"=0A=
> +	depends on PCI_MSI_IRQ_DOMAIN=0A=
> +	depends on SOC_SIFIVE || COMPILE_TEST=0A=
> +	select PCIE_DW_HOST=0A=
> +	help=0A=
> +	  Say Y here if you want PCIe controller support for the SiFive=0A=
> +	  FU740.=0A=
> +=0A=
>  endmenu=0A=
> diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller=
/dwc/Makefile=0A=
> index a751553fa0db..625f6aaeb5b8 100644=0A=
> --- a/drivers/pci/controller/dwc/Makefile=0A=
> +++ b/drivers/pci/controller/dwc/Makefile=0A=
> @@ -5,6 +5,7 @@ obj-$(CONFIG_PCIE_DW_EP) +=3D pcie-designware-ep.o=0A=
>  obj-$(CONFIG_PCIE_DW_PLAT) +=3D pcie-designware-plat.o=0A=
>  obj-$(CONFIG_PCI_DRA7XX) +=3D pci-dra7xx.o=0A=
>  obj-$(CONFIG_PCI_EXYNOS) +=3D pci-exynos.o=0A=
> +obj-$(CONFIG_PCIE_FU740) +=3D pcie-fu740.o=0A=
>  obj-$(CONFIG_PCI_IMX6) +=3D pci-imx6.o=0A=
>  obj-$(CONFIG_PCIE_SPEAR13XX) +=3D pcie-spear13xx.o=0A=
>  obj-$(CONFIG_PCI_KEYSTONE) +=3D pci-keystone.o=0A=
> diff --git a/drivers/pci/controller/dwc/pcie-fu740.c b/drivers/pci/contro=
ller/dwc/pcie-fu740.c=0A=
> new file mode 100644=0A=
> index 000000000000..ebbcbda97490=0A=
> --- /dev/null=0A=
> +++ b/drivers/pci/controller/dwc/pcie-fu740.c=0A=
> @@ -0,0 +1,324 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
> +/*=0A=
> + * FU740 DesignWare PCIe Controller integration=0A=
> + * Copyright (C) 2019-2021 SiFive, Inc.=0A=
> + * Paul Walmsley=0A=
> + * Greentime Hu=0A=
> + *=0A=
> + * Based in part on the i.MX6 PCIe host controller shim which is:=0A=
> + *=0A=
> + * Copyright (C) 2013 Kosagi=0A=
> + *		https://www.kosagi.com=0A=
> + */=0A=
> +=0A=
> +#include <linux/clk.h>=0A=
> +#include <linux/delay.h>=0A=
> +#include <linux/gpio.h>=0A=
> +#include <linux/kernel.h>=0A=
> +#include <linux/mfd/syscon.h>=0A=
> +#include <linux/module.h>=0A=
> +#include <linux/of_gpio.h>=0A=
> +#include <linux/of_device.h>=0A=
> +#include <linux/pci.h>=0A=
> +#include <linux/platform_device.h>=0A=
> +#include <linux/regulator/consumer.h>=0A=
> +#include <linux/resource.h>=0A=
> +#include <linux/signal.h>=0A=
> +#include <linux/types.h>=0A=
> +#include <linux/interrupt.h>=0A=
> +#include <linux/iopoll.h>=0A=
> +#include <linux/reset.h>=0A=
> +#include <linux/pm_domain.h>=0A=
> +#include <linux/pm_runtime.h>=0A=
> +=0A=
> +#include "pcie-designware.h"=0A=
> +=0A=
> +#define to_fu740_pcie(x)	dev_get_drvdata((x)->dev)=0A=
> +=0A=
> +struct fu740_pcie {=0A=
> +	struct dw_pcie pci;=0A=
> +	void __iomem *mgmt_base;=0A=
> +	struct gpio_desc *reset;=0A=
> +	struct gpio_desc *pwren;=0A=
> +	struct clk *pcie_aux;=0A=
> +	struct reset_control *rst;=0A=
> +};=0A=
> +=0A=
> +#define SIFIVE_DEVICESRESETREG		0x28=0A=
> +=0A=
> +#define PCIEX8MGMT_PERST_N		0x0=0A=
> +#define PCIEX8MGMT_APP_LTSSM_ENABLE	0x10=0A=
> +#define PCIEX8MGMT_APP_HOLD_PHY_RST	0x18=0A=
> +#define PCIEX8MGMT_DEVICE_TYPE		0x708=0A=
> +#define PCIEX8MGMT_PHY0_CR_PARA_ADDR	0x860=0A=
> +#define PCIEX8MGMT_PHY0_CR_PARA_RD_EN	0x870=0A=
> +#define PCIEX8MGMT_PHY0_CR_PARA_RD_DATA	0x878=0A=
> +#define PCIEX8MGMT_PHY0_CR_PARA_SEL	0x880=0A=
> +#define PCIEX8MGMT_PHY0_CR_PARA_WR_DATA	0x888=0A=
> +#define PCIEX8MGMT_PHY0_CR_PARA_WR_EN	0x890=0A=
> +#define PCIEX8MGMT_PHY0_CR_PARA_ACK	0x898=0A=
> +#define PCIEX8MGMT_PHY1_CR_PARA_ADDR	0x8a0=0A=
> +#define PCIEX8MGMT_PHY1_CR_PARA_RD_EN	0x8b0=0A=
> +#define PCIEX8MGMT_PHY1_CR_PARA_RD_DATA	0x8b8=0A=
> +#define PCIEX8MGMT_PHY1_CR_PARA_SEL	0x8c0=0A=
> +#define PCIEX8MGMT_PHY1_CR_PARA_WR_DATA	0x8c8=0A=
> +#define PCIEX8MGMT_PHY1_CR_PARA_WR_EN	0x8d0=0A=
> +#define PCIEX8MGMT_PHY1_CR_PARA_ACK	0x8d8=0A=
> +=0A=
> +#define PCIEX8MGMT_PHY_CDR_TRACK_EN	BIT(0)=0A=
> +#define PCIEX8MGMT_PHY_LOS_THRSHLD	BIT(5)=0A=
> +#define PCIEX8MGMT_PHY_TERM_EN		BIT(9)=0A=
> +#define PCIEX8MGMT_PHY_TERM_ACDC	BIT(10)=0A=
> +#define PCIEX8MGMT_PHY_EN		BIT(11)=0A=
> +#define PCIEX8MGMT_PHY_INIT_VAL		(PCIEX8MGMT_PHY_CDR_TRACK_EN|\=0A=
> +					 PCIEX8MGMT_PHY_LOS_THRSHLD|\=0A=
> +					 PCIEX8MGMT_PHY_TERM_EN|\=0A=
> +					 PCIEX8MGMT_PHY_TERM_ACDC|\=0A=
> +					 PCIEX8MGMT_PHY_EN)=0A=
> +=0A=
> +#define PCIEX8MGMT_PHY_LANEN_DIG_ASIC_RX_OVRD_IN_3	0x1008=0A=
> +#define PCIEX8MGMT_PHY_LANE_OFF		0x100=0A=
> +#define PCIEX8MGMT_PHY_LANE0_BASE	(PCIEX8MGMT_PHY_LANEN_DIG_ASIC_RX_OVRD=
_IN_3 + 0x100 * 0)=0A=
> +#define PCIEX8MGMT_PHY_LANE1_BASE	(PCIEX8MGMT_PHY_LANEN_DIG_ASIC_RX_OVRD=
_IN_3 + 0x100 * 1)=0A=
> +#define PCIEX8MGMT_PHY_LANE2_BASE	(PCIEX8MGMT_PHY_LANEN_DIG_ASIC_RX_OVRD=
_IN_3 + 0x100 * 2)=0A=
> +#define PCIEX8MGMT_PHY_LANE3_BASE	(PCIEX8MGMT_PHY_LANEN_DIG_ASIC_RX_OVRD=
_IN_3 + 0x100 * 3)=0A=
> +=0A=
> +static void fu740_pcie_assert_reset(struct fu740_pcie *afp)=0A=
> +{=0A=
> +	/* Assert PERST_N GPIO */=0A=
> +	gpiod_set_value_cansleep(afp->reset, 0);=0A=
> +	/* Assert controller PERST_N */=0A=
> +	writel_relaxed(0x0, afp->mgmt_base + PCIEX8MGMT_PERST_N);=0A=
> +}=0A=
> +=0A=
> +static void fu740_pcie_deassert_reset(struct fu740_pcie *afp)=0A=
> +{=0A=
> +	/* Deassert controller PERST_N */=0A=
> +	writel_relaxed(0x1, afp->mgmt_base + PCIEX8MGMT_PERST_N);=0A=
> +	/* Deassert PERST_N GPIO */=0A=
> +	gpiod_set_value_cansleep(afp->reset, 1);=0A=
> +}=0A=
> +=0A=
> +static void fu740_pcie_power_on(struct fu740_pcie *afp)=0A=
> +{=0A=
> +	gpiod_set_value_cansleep(afp->pwren, 1);=0A=
> +	/*=0A=
> +	 * Ensure that PERST has been asserted for at least 100 ms.=0A=
> +	 * Section 2.2 of PCI Express Card Electromechanical Specification=0A=
> +	 * Revision 3.0=0A=
> +	 */=0A=
> +	msleep(100);=0A=
> +}=0A=
> +=0A=
> +static void fu740_pcie_drive_reset(struct fu740_pcie *afp)=0A=
> +{=0A=
> +	fu740_pcie_assert_reset(afp);=0A=
> +	fu740_pcie_power_on(afp);=0A=
> +	fu740_pcie_deassert_reset(afp);=0A=
> +}=0A=
> +=0A=
> +static void fu740_phyregwrite(const uint8_t phy, const uint16_t addr,=0A=
> +			      const uint16_t wrdata, struct fu740_pcie *afp)=0A=
> +{=0A=
> +	struct device *dev =3D afp->pci.dev;=0A=
> +	void __iomem *phy_cr_para_addr;=0A=
> +	void __iomem *phy_cr_para_wr_data;=0A=
> +	void __iomem *phy_cr_para_wr_en;=0A=
> +	void __iomem *phy_cr_para_ack;=0A=
> +	int ret, val;=0A=
> +=0A=
> +	/* Setup */=0A=
> +	if (phy) {=0A=
> +		phy_cr_para_addr =3D afp->mgmt_base + PCIEX8MGMT_PHY1_CR_PARA_ADDR;=0A=
> +		phy_cr_para_wr_data =3D afp->mgmt_base + PCIEX8MGMT_PHY1_CR_PARA_WR_DA=
TA;=0A=
> +		phy_cr_para_wr_en =3D afp->mgmt_base + PCIEX8MGMT_PHY1_CR_PARA_WR_EN;=
=0A=
> +		phy_cr_para_ack =3D afp->mgmt_base + PCIEX8MGMT_PHY1_CR_PARA_ACK;=0A=
> +	} else {=0A=
> +		phy_cr_para_addr =3D afp->mgmt_base + PCIEX8MGMT_PHY0_CR_PARA_ADDR;=0A=
> +		phy_cr_para_wr_data =3D afp->mgmt_base + PCIEX8MGMT_PHY0_CR_PARA_WR_DA=
TA;=0A=
> +		phy_cr_para_wr_en =3D afp->mgmt_base + PCIEX8MGMT_PHY0_CR_PARA_WR_EN;=
=0A=
> +		phy_cr_para_ack =3D afp->mgmt_base + PCIEX8MGMT_PHY0_CR_PARA_ACK;=0A=
> +	}=0A=
> +=0A=
> +	writel_relaxed(addr, phy_cr_para_addr);=0A=
> +	writel_relaxed(wrdata, phy_cr_para_wr_data);=0A=
> +	writel_relaxed(1, phy_cr_para_wr_en);=0A=
> +=0A=
> +	/* Wait for wait_idle */=0A=
> +	ret =3D readl_poll_timeout(phy_cr_para_ack, val, val, 10, 5000);=0A=
> +	if (ret)=0A=
> +		dev_err(dev, "Wait for wait_ilde state failed!\n");=0A=
=0A=
This is a void function. What is the point of these dev_err() if you do not=
=0A=
return an error or process the failure in any way ? Change this to dev_warn=
()=0A=
may be ?=0A=
=0A=
> +=0A=
> +	/* Clear */=0A=
> +	writel_relaxed(0, phy_cr_para_wr_en);=0A=
> +=0A=
> +	/* Wait for ~wait_idle */=0A=
> +	ret =3D readl_poll_timeout(phy_cr_para_ack, val, !val, 10, 5000);=0A=
> +	if (ret)=0A=
> +		dev_err(dev, "Wait for !wait_ilde state failed!\n");=0A=
=0A=
Same as above.=0A=
=0A=
> +}=0A=
> +=0A=
> +static void fu740_pcie_init_phy(struct fu740_pcie *afp)=0A=
> +{=0A=
> +	/* Enable phy cr_para_sel interfaces */=0A=
> +	writel_relaxed(0x1, afp->mgmt_base + PCIEX8MGMT_PHY0_CR_PARA_SEL);=0A=
> +	writel_relaxed(0x1, afp->mgmt_base + PCIEX8MGMT_PHY1_CR_PARA_SEL);=0A=
> +=0A=
> +	/*=0A=
> +	 * Wait 10 cr_para cycles to guarantee that the registers are ready=0A=
> +	 * to be edited.=0A=
> +	 */=0A=
> +	ndelay(10);=0A=
> +=0A=
> +	/* Set PHY AC termination mode */=0A=
> +	fu740_phyregwrite(0, PCIEX8MGMT_PHY_LANE0_BASE, PCIEX8MGMT_PHY_INIT_VAL=
, afp);=0A=
> +	fu740_phyregwrite(0, PCIEX8MGMT_PHY_LANE1_BASE, PCIEX8MGMT_PHY_INIT_VAL=
, afp);=0A=
> +	fu740_phyregwrite(0, PCIEX8MGMT_PHY_LANE2_BASE, PCIEX8MGMT_PHY_INIT_VAL=
, afp);=0A=
> +	fu740_phyregwrite(0, PCIEX8MGMT_PHY_LANE3_BASE, PCIEX8MGMT_PHY_INIT_VAL=
, afp);=0A=
> +	fu740_phyregwrite(1, PCIEX8MGMT_PHY_LANE0_BASE, PCIEX8MGMT_PHY_INIT_VAL=
, afp);=0A=
> +	fu740_phyregwrite(1, PCIEX8MGMT_PHY_LANE1_BASE, PCIEX8MGMT_PHY_INIT_VAL=
, afp);=0A=
> +	fu740_phyregwrite(1, PCIEX8MGMT_PHY_LANE2_BASE, PCIEX8MGMT_PHY_INIT_VAL=
, afp);=0A=
> +	fu740_phyregwrite(1, PCIEX8MGMT_PHY_LANE3_BASE, PCIEX8MGMT_PHY_INIT_VAL=
, afp);=0A=
> +}=0A=
> +=0A=
> +static void fu740_pcie_ltssm_enable(struct device *dev)=0A=
> +{=0A=
> +	struct fu740_pcie *afp =3D dev_get_drvdata(dev);=0A=
> +=0A=
> +	/* Enable LTSSM */=0A=
> +	writel_relaxed(0x1, afp->mgmt_base + PCIEX8MGMT_APP_LTSSM_ENABLE);=0A=
> +}=0A=
> +=0A=
> +static int fu740_pcie_start_link(struct dw_pcie *pci)=0A=
> +{=0A=
> +	struct device *dev =3D pci->dev;=0A=
=0A=
No need for this variable.=0A=
=0A=
> +=0A=
> +	/* Start LTSSM. */=0A=
> +	fu740_pcie_ltssm_enable(dev);=0A=
> +	return 0;=0A=
> +}=0A=
> +=0A=
> +static int fu740_pcie_host_init(struct pcie_port *pp)=0A=
> +{=0A=
> +	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);=0A=
> +	struct fu740_pcie *afp =3D to_fu740_pcie(pci);=0A=
> +	struct device *dev =3D pci->dev;=0A=
> +	int ret;=0A=
> +=0A=
> +	/* Power on reset */=0A=
> +	fu740_pcie_drive_reset(afp);=0A=
> +=0A=
> +	/* Enable pcieauxclk */=0A=
> +	ret =3D clk_prepare_enable(afp->pcie_aux);=0A=
> +	if (ret)=0A=
> +		dev_err(dev, "unable to enable pcie_aux clock\n");=0A=
=0A=
No bailing out ? Without a clock, is this going to work ?=0A=
If that is not a problem, then I would suggest a dev_warn() here.=0A=
=0A=
> +=0A=
> +	/*=0A=
> +	 * Assert hold_phy_rst (hold the controller LTSSM in reset after=0A=
> +	 * power_up_rst_n for register programming with cr_para)=0A=
> +	 */=0A=
> +	writel_relaxed(0x1, afp->mgmt_base + PCIEX8MGMT_APP_HOLD_PHY_RST);=0A=
> +=0A=
> +	/* Deassert power_up_rst_n */=0A=
> +	ret =3D reset_control_deassert(afp->rst);=0A=
> +	if (ret)=0A=
> +		dev_err(dev, "unable to deassert pcie_power_up_rst_n\n");=0A=
=0A=
Same as above.=0A=
=0A=
> +=0A=
> +	fu740_pcie_init_phy(afp);=0A=
> +=0A=
> +	/* Disable pcieauxclk */=0A=
> +	clk_disable_unprepare(afp->pcie_aux);=0A=
> +	/* Clear hold_phy_rst */=0A=
> +	writel_relaxed(0x0, afp->mgmt_base + PCIEX8MGMT_APP_HOLD_PHY_RST);=0A=
> +	/* Enable pcieauxclk */=0A=
> +	ret =3D clk_prepare_enable(afp->pcie_aux);=0A=
> +	/* Set RC mode */=0A=
> +	writel_relaxed(0x4, afp->mgmt_base + PCIEX8MGMT_DEVICE_TYPE);=0A=
> +=0A=
> +	return 0;=0A=
> +}=0A=
> +=0A=
> +static const struct dw_pcie_host_ops fu740_pcie_host_ops =3D {=0A=
> +	.host_init =3D fu740_pcie_host_init,=0A=
> +};=0A=
> +=0A=
> +static const struct dw_pcie_ops dw_pcie_ops =3D {=0A=
> +	.start_link =3D fu740_pcie_start_link,=0A=
> +};=0A=
> +=0A=
> +static int fu740_pcie_probe(struct platform_device *pdev)=0A=
> +{=0A=
> +	struct device *dev =3D &pdev->dev;=0A=
> +	struct dw_pcie *pci;=0A=
> +	struct fu740_pcie *afp;=0A=
> +	int ret;=0A=
> +=0A=
> +	afp =3D devm_kzalloc(dev, sizeof(*afp), GFP_KERNEL);=0A=
> +	if (!afp)=0A=
> +		return -ENOMEM;=0A=
> +	pci =3D &afp->pci;=0A=
> +	pci->dev =3D dev;=0A=
> +	pci->ops =3D &dw_pcie_ops;=0A=
> +	pci->pp.ops =3D &fu740_pcie_host_ops;=0A=
> +=0A=
> +	/* SiFive specific region: mgmt */=0A=
> +	afp->mgmt_base =3D devm_platform_ioremap_resource_byname(pdev, "mgmt");=
=0A=
> +	if (IS_ERR(afp->mgmt_base))=0A=
> +		return PTR_ERR(afp->mgmt_base);=0A=
> +=0A=
> +	/* Fetch GPIOs */=0A=
> +	afp->reset =3D devm_gpiod_get_optional(dev, "reset-gpios", GPIOD_OUT_LO=
W);=0A=
> +	if (IS_ERR(afp->reset)) {=0A=
> +		dev_err(dev, "unable to get reset-gpios\n");=0A=
> +		return ret;=0A=
> +	}=0A=
> +	afp->pwren =3D devm_gpiod_get_optional(dev, "pwren-gpios", GPIOD_OUT_LO=
W);=0A=
> +	if (IS_ERR(afp->pwren)) {=0A=
> +		dev_err(dev, "unable to get pwren-gpios\n");=0A=
> +		return ret;=0A=
=0A=
Why not return dev_err_probe(...); ? Same for the returns above.=0A=
=0A=
> +	}=0A=
> +=0A=
> +	/* Fetch clocks */=0A=
> +	afp->pcie_aux =3D devm_clk_get(dev, "pcie_aux");=0A=
> +	if (IS_ERR(afp->pcie_aux))=0A=
> +		return dev_err_probe(dev, PTR_ERR(afp->pcie_aux),=0A=
> +					     "pcie_aux clock source missing or invalid\n");=0A=
> +=0A=
> +	/* Fetch reset */=0A=
> +	afp->rst =3D devm_reset_control_get_exclusive(dev, NULL);=0A=
> +	if (IS_ERR(afp->rst))=0A=
> +		return dev_err_probe(dev, PTR_ERR(afp->rst), "unable to get reset\n");=
=0A=
> +=0A=
> +	platform_set_drvdata(pdev, afp);=0A=
> +=0A=
> +	ret =3D dw_pcie_host_init(&pci->pp);=0A=
> +	if (ret < 0)=0A=
> +		return ret;=0A=
=0A=
You can simplify this with a simple:=0A=
=0A=
	return dw_pcie_host_init(&pci->pp);=0A=
=0A=
> +=0A=
> +	return 0;=0A=
> +}=0A=
> +=0A=
> +static void fu740_pcie_shutdown(struct platform_device *pdev)=0A=
> +{=0A=
> +	struct fu740_pcie *afp =3D platform_get_drvdata(pdev);=0A=
> +=0A=
> +	/* Bring down link, so bootloader gets clean state in case of reboot */=
=0A=
> +	fu740_pcie_assert_reset(afp);=0A=
> +}=0A=
> +=0A=
> +static const struct of_device_id fu740_pcie_of_match[] =3D {=0A=
> +	{ .compatible =3D "sifive,fu740-pcie", },=0A=
> +	{},=0A=
> +};=0A=
> +=0A=
> +static struct platform_driver fu740_pcie_driver =3D {=0A=
> +	.driver =3D {=0A=
> +		   .name =3D "fu740-pcie",=0A=
> +		   .of_match_table =3D fu740_pcie_of_match,=0A=
> +		   .suppress_bind_attrs =3D true,=0A=
> +	},=0A=
> +	.probe =3D fu740_pcie_probe,=0A=
> +	.shutdown =3D fu740_pcie_shutdown,=0A=
> +};=0A=
> +=0A=
> +builtin_platform_driver(fu740_pcie_driver);=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
