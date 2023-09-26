Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32EA97AEB83
	for <lists+linux-pci@lfdr.de>; Tue, 26 Sep 2023 13:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbjIZLcf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Sep 2023 07:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjIZLcf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Sep 2023 07:32:35 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2090.outbound.protection.outlook.com [40.107.114.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26E4E5;
        Tue, 26 Sep 2023 04:32:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lexoKWUAChKj1TlVBM2Uf00lYyF2LxizwLCKqJyHINe+9gJ3/0OX+ik4zkpm4Tma4ULzaHCoRcFCFq/Etlq3N0nCXepXQjMIIaf4oRJP0i0GlcvETuMZ0imE9VDO5HooLSeW09DTKT5IKAVXJ09mpXSJuJ9uF5/bzTY7M2kiuAy8r6WEyAjfkUV2oYQK+av1cW+L1TIlLvBYuOmdMxCXB3zOB3QwtmmR1vz/CSn6bD1eOALgcyf+rSL3nk13DVZ4iFk7GP9WC+15UCjjHFJVPgGVHpiBjQlEUFFcXDxos0cy9yg915VOkMtQyYsUnTfSon6lnz5vZZWtxfcUcZHwZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wXGIbL8D6d6HQi3CQ+CihW1qjwxgb4WxzcYn68QQhXQ=;
 b=QobGSskhfbD+r9Jb9rIdGKsNRZMd6H8b8X6NyX+2IX+k+UtiRD6k22ZdbineWucHEOdZNMOyl11fk8VaPK6QN31wVNLdHLQ8W6xd1E2HDkWWnptslvG0fssSw3k9uEbfkanZQaxjlVEcI/4D4x+qlCHH1cTlGdmBk9Z6g8cEG8OX4QnQLkkrbB150gGii+4yZf8C+2kAL4TW+dhQ+va+moraBznuRAQAQrP4XffsG0ceTlYqMyI2MFB4b0r2YIo0Z9X99Ble4w6BKmrZLpLkrJKNiFo0zKfSVF5822Vct1QpUH9i9uJggxUWMyGm45H8NGdsHr255bUQrxdTPNP1iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wXGIbL8D6d6HQi3CQ+CihW1qjwxgb4WxzcYn68QQhXQ=;
 b=oH98Y/LipdbSULPZMSjx3a9vbWIRDUufqYNt0tUliiAqXu3olXnoyQhhOYC3Drjotc7uVG6p3w/R+aqXKF/MybBS7j2N5gz97qg9CY1NYohUmm4GMNIXSDm/XOj4cOa0jQnVOjuximjxdmHv/K05nmcXoa+04b4rVE9gFLm1z9k=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TY3PR01MB10046.jpnprd01.prod.outlook.com
 (2603:1096:400:1dd::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 11:32:23 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::1dc4:e923:9916:c0f7]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::1dc4:e923:9916:c0f7%6]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 11:32:23 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Serge Semin <fancer.lancer@gmail.com>
CC:     "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "mani@kernel.org" <mani@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v22 13/16] PCI: dwc: rcar-gen4: Add R-Car Gen4 PCIe
 controller support
Thread-Topic: [PATCH v22 13/16] PCI: dwc: rcar-gen4: Add R-Car Gen4 PCIe
 controller support
Thread-Index: AQHZ74Dtl/R/Vdl0Q0i2iUmev6tMFbArVZmAgAGlX7A=
Date:   Tue, 26 Sep 2023 11:32:22 +0000
Message-ID: <TYBPR01MB53411ADB6F5B2F484F463C89D8C3A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230925072130.3901087-1-yoshihiro.shimoda.uh@renesas.com>
 <20230925072130.3901087-14-yoshihiro.shimoda.uh@renesas.com>
 <hosrzwdlkedp6sddia465a27b5mdncjxmhof5jpa2b5senobhf@5c5ldtmjbzee>
In-Reply-To: <hosrzwdlkedp6sddia465a27b5mdncjxmhof5jpa2b5senobhf@5c5ldtmjbzee>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TY3PR01MB10046:EE_
x-ms-office365-filtering-correlation-id: c3657979-1920-4ce4-c15a-08dbbe84407b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2RMMi6LlOrFEGuu+wdp/DL0S96w7Ld0e37LUMsDbKqkjJ/J65Es35KakAZ5Z1Wgh3MZYQ6GoPWMP1kMZsELv4YOk3k3RsmO+wWMI1jzw7HvvI9IjmFYLlJg+LT+tn6iohDtKAPecwiS47HTeISneLN33yySCQz8/Cta99BNwHh1xtG6FyEXJSqo71NSKXCAdDTKEuFCV94q+GuZYLcK/QNL38B8VaCBr4d+aHufyq9ntDNCs6naOMrQjX25cbCaS90nqiL8VyfeV5ZNavCrcCIgdnxP3IdxFfCSAW1wj1Cp/GvCqstKCZRtserI3cuaAaeGcwLraGMTBf5OFjRSs2AWyKD6HtS3Ehk7KjIXsWWj03PaUsk4s/xLUoQbqA9rk0dZ7Zb5Mig6LfpQOGc1WplpXhbycmTdefAR7iM7Xt4hMMJnsgIFi7+nSENwd0+/1f1/DQD7WjCQSb/4rn3wa3UcKrF31/4iBJhYxB9Bd6CURfsb//XZvjW5LW1HTW9x3vGSdVaEZxVvU0kb4vOVeF5JS6HVxHckvcFRB7PI2JRPor53bT+X6xIKSgbi6Q/PfjVZurMXEzCaJpRrj0NmBV3VaWPHL4p8tWxC0oXCBJZMDD10YyVN5YpQRp/iAmi5O
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(39860400002)(346002)(136003)(230922051799003)(186009)(451199024)(1800799009)(55016003)(83380400001)(66574015)(5660300002)(66899024)(8936002)(8676002)(4326008)(9686003)(52536014)(316002)(478600001)(41300700001)(66946007)(66446008)(64756008)(54906003)(76116006)(66476007)(2906002)(6916009)(7416002)(71200400001)(6506007)(66556008)(30864003)(7696005)(86362001)(33656002)(38070700005)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?PN0GSyidgDwBonaFx8311AFGLc+whANrNrz7tinr/SgJcaIXiGbzIdxQpV?=
 =?iso-8859-2?Q?tAf7ceN4KTPaXkqelzWtA/0yKTYePfU9IZPN3i1Chx8Eve8B+W9DIsPcTp?=
 =?iso-8859-2?Q?2y4VQBgbmaLRZrpRyICZzF7cI+Pov+JsRE+XoiNceyExd4VTamGJ/ji2i2?=
 =?iso-8859-2?Q?1gZdkd3TJEiUR1SQ+2s676GHcghDVPYDbNh0mWqGQRNSa8LG1nMvvfNx6T?=
 =?iso-8859-2?Q?5G/6AviXpyuYnScOrDQPgGCO0JjuUy37Bgow+ExT0ccfbS+GoYfl6U1WC3?=
 =?iso-8859-2?Q?jPgZ0FuUtcwk/KRADDjGisWc6EoXtqWUg7mnl3oiPENBiMqn2h4VeL0INM?=
 =?iso-8859-2?Q?4hLSQrC5jvyUaEpTOJm5vlxFqhHZ3Hr4r7kRZGQm9Ju3ix06HlC7XKfv9S?=
 =?iso-8859-2?Q?8XWHLwdGKR3d9BUpW7cVRFf9z1m4MKkHrveRjXqiOKpeKOyKA8Q5EpP6Uj?=
 =?iso-8859-2?Q?NkreskuwtFLN5kUsdQbEn9ZO+poudZl274uvYhT9TMW198rG12+akXt0HA?=
 =?iso-8859-2?Q?GFfPZm5YZwZh6UEDY3QguGLfhVuqrdLqz8SPgzC29QANdG4V906wuUIl50?=
 =?iso-8859-2?Q?q39VAu46EOzYg0ejXWDTkWfApwl6fCuAs/Qu590h42va9ZubV98njfRdSk?=
 =?iso-8859-2?Q?TXpGA+b3Zue3Cb6l0fdqsktlLSIJ82tppVYa3xyiOD8KyxBBMdPMsvHQ5R?=
 =?iso-8859-2?Q?VIMjubW3RwnARaAWwGLpH3CBwtJs3VPoqcdzvchZxcxoyhc4vGaIP3iwS8?=
 =?iso-8859-2?Q?wdU1TCHI2on0tY/dGB8FBcqYqeXpVtqUw6HgVLD8+fD7LPjmocLO1aEyIV?=
 =?iso-8859-2?Q?Ewo7jQm8/oBI+y+I2EOKEZM+5w1OWS9KjSChgj3Fb5E6EyF/35z8GFSTlq?=
 =?iso-8859-2?Q?0MhebuWF/47Dy4ypjWefAbR7igGEjtN3gFFuv7sIQqvM35nHpPlRAEZzQ6?=
 =?iso-8859-2?Q?Y3YJzlx5ZAynepYpQLJiJg3+5hdZDL4v/+CuTcsVsTrrJG66RHLpcg9pKs?=
 =?iso-8859-2?Q?YQZarb/vvl4QhuB2ckCHZDeLp2ZLaSVWf9zDA3A35Ht0QH3J/tuu4DgVjK?=
 =?iso-8859-2?Q?/kFwaSmVrgNfZ0RwJrDBRSlTbR9Ax6upE4h/WpgorVfOnYzkEzvZ/w5wwh?=
 =?iso-8859-2?Q?TUNFrgxBCGlXNDYKt/XqlX6ufwFTKEzXOwUUZYerzYnGMHBHpLfZLlyw48?=
 =?iso-8859-2?Q?al0C0hqL13A96fNWIb4KHwtQe6kSCRA2FSqwRf5XoXaSIIvxK7iWXWMmeZ?=
 =?iso-8859-2?Q?0n8JgeO7jNOceaZa6Mc7ZWzXOz/w5VXH3xvyjqbFglPZQVlr4i517HFjrQ?=
 =?iso-8859-2?Q?F0VeFgHeWs6dLQh790/gU4hH89XmS+3SUFcvS7nxGo9yjyncoPs/RcW2jS?=
 =?iso-8859-2?Q?UDFWX7j5ggfbW+5XebyJKwxor+afzCo4r+BZqbz3DSBShxA0z6gPRJURBH?=
 =?iso-8859-2?Q?tAC/og13kP1mFVM4VvTmfSb6lrJGeLfTnbeyKVGKM8jULlyb2AM1d62L4A?=
 =?iso-8859-2?Q?kCQyzKhC/pK6O3eBwaP3jafJPg9+hlMFAB03Jxte55yZeWayyx7XTBKOjN?=
 =?iso-8859-2?Q?mEONHeryHCvHnAZyWA5GsPtei9Xa9EuZwDnf7qZUE+0ouqA/2Zcnw+YFix?=
 =?iso-8859-2?Q?1Jfr6dO7PLOE/RFljjUD6IsxB+rZgoL5SNnXMp/F91fyfDXaQi5KPO397J?=
 =?iso-8859-2?Q?H0p4tWudWY706sJdtsEjLQTo13hjA4nCgovKElC0hUgCYtoFwvL2vYLtb7?=
 =?iso-8859-2?Q?3ssw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3657979-1920-4ce4-c15a-08dbbe84407b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 11:32:22.9597
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qpTPop0llwTD0bwqfrYlj0MoAr4n+1UQ5hgPa325t09Rn2rGPXWV+Dyg+6mPcCmoNetxzEaH9Llz78BGbCsTBBne7clTXyI4SqGMz87aMLtxUETQMQ8IQice/qCNnLap
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10046
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Serge,

> From: Serge Semin, Sent: Monday, September 25, 2023 7:23 PM
>=20
> On Mon, Sep 25, 2023 at 04:21:27PM +0900, Yoshihiro Shimoda wrote:
> > Add R-Car Gen4 PCIe controller support for host mode.
> >
> > This controller is based on Synopsys DesignWare PCIe. However, this
> > particular controller has a number of vendor-specific registers, and as
> > such, requires initialization code like mode setting and retraining and
> > so on.
> >
> > [kwilczynski: commit log]
> > Link:
<snip URL>
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > Signed-off-by: Krzysztof Wilczy=F1ski <kwilczynski@kernel.org>
> > Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> > ---
> >  drivers/pci/controller/dwc/Kconfig          |  14 +
> >  drivers/pci/controller/dwc/Makefile         |   1 +
> >  drivers/pci/controller/dwc/pcie-rcar-gen4.c | 381 ++++++++++++++++++++
> >  3 files changed, 396 insertions(+)
> >  create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4.c
> >
> > diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controlle=
r/dwc/Kconfig
> > index ab96da43e0c2..bc69fcab2e2a 100644
> > --- a/drivers/pci/controller/dwc/Kconfig
> > +++ b/drivers/pci/controller/dwc/Kconfig
> > @@ -415,4 +415,18 @@ config PCIE_VISCONTI_HOST
> >  	  Say Y here if you want PCIe controller support on Toshiba Visconti =
SoC.
> >  	  This driver supports TMPV7708 SoC.
> >
> > +config PCIE_RCAR_GEN4
> > +	tristate
> > +
> > +config PCIE_RCAR_GEN4_HOST
> > +	tristate "Renesas R-Car Gen4 PCIe controller (host mode)"
> > +	depends on ARCH_RENESAS || COMPILE_TEST
> > +	depends on PCI_MSI
> > +	select PCIE_DW_HOST
> > +	select PCIE_RCAR_GEN4
> > +	help
> > +	  Say Y here if you want PCIe controller (host mode) on R-Car Gen4 So=
Cs.
> > +	  To compile this driver as a module, choose M here: the module will =
be
> > +	  called pcie-rcar-gen4.ko. This uses the DesignWare core.
> > +
> >  endmenu
> > diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controll=
er/dwc/Makefile
> > index bf5c311875a1..bac103faa523 100644
> > --- a/drivers/pci/controller/dwc/Makefile
> > +++ b/drivers/pci/controller/dwc/Makefile
> > @@ -26,6 +26,7 @@ obj-$(CONFIG_PCIE_TEGRA194) +=3D pcie-tegra194.o
> >  obj-$(CONFIG_PCIE_UNIPHIER) +=3D pcie-uniphier.o
> >  obj-$(CONFIG_PCIE_UNIPHIER_EP) +=3D pcie-uniphier-ep.o
> >  obj-$(CONFIG_PCIE_VISCONTI_HOST) +=3D pcie-visconti.o
> > +obj-$(CONFIG_PCIE_RCAR_GEN4) +=3D pcie-rcar-gen4.o
> >
> >  # The following drivers are for devices that use the generic ACPI
> >  # pci_root.c driver but don't support standard ECAM config access.
> > diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/=
controller/dwc/pcie-rcar-gen4.c
> > new file mode 100644
> > index 000000000000..f6b3c3ef187c
> > --- /dev/null
> > +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> > @@ -0,0 +1,381 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * PCIe controller driver for Renesas R-Car Gen4 Series SoCs
> > + * Copyright (C) 2022-2023 Renesas Electronics Corporation
> > + */
> > +
> > +#include <linux/delay.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/of_device.h>
> > +#include <linux/pci.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/reset.h>
> > +
> > +#include "../../pci.h"
> > +#include "pcie-designware.h"
> > +
> > +/* Renesas-specific */
> > +/* PCIe Mode Setting Register 0 */
> > +#define PCIEMSR0		0x0000
> > +#define BIFUR_MOD_SET_ON	BIT(0)
> > +#define DEVICE_TYPE_EP		0
> > +#define DEVICE_TYPE_RC		BIT(4)
> > +
> > +/* PCIe Interrupt Status 0 */
> > +#define PCIEINTSTS0		0x0084
> > +
> > +/* PCIe Interrupt Status 0 Enable */
> > +#define PCIEINTSTS0EN		0x0310
> > +#define MSI_CTRL_INT		BIT(26)
> > +#define SMLH_LINK_UP		BIT(7)
> > +#define RDLH_LINK_UP		BIT(6)
> > +
> > +/* PCIe DMA Interrupt Status Enable */
> > +#define PCIEDMAINTSTSEN		0x0314
> > +#define PCIEDMAINTSTSEN_INIT	GENMASK(15, 0)
> > +
> > +/* PCIe Reset Control Register 1 */
> > +#define PCIERSTCTRL1		0x0014
> > +#define APP_HOLD_PHY_RST	BIT(16)
> > +#define APP_LTSSM_ENABLE	BIT(0)
> > +
> > +#define RCAR_NUM_SPEED_CHANGE_RETRIES	10
> > +#define RCAR_MAX_LINK_SPEED		4
> > +
> > +struct rcar_gen4_pcie {
> > +	struct dw_pcie dw;
> > +	void __iomem *base;
> > +	struct platform_device *pdev;
> > +	enum dw_pcie_device_mode mode;
> > +};
> > +#define to_rcar_gen4_pcie(_dw)	container_of(_dw, struct rcar_gen4_pcie=
, dw)
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
> > +/*
> > + * Manually initiate the speed change. Return true if the change succe=
eded,
> > + * false if the change didn't finish within certain periods.
> > + */
> > +static int rcar_gen4_pcie_speed_change(struct dw_pcie *dw)
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
> > +			return 0;
> > +		usleep_range(10000, 11000);
> > +	}
> > +
> > +	return -ETIMEDOUT;
> > +}
> > +
> > +/*
> > + * Enable LTSSM of this controller and manually initiate the speed cha=
nge.
> > + * Always return 0.
> > + */
> > +static int rcar_gen4_pcie_start_link(struct dw_pcie *dw)
> > +{
> > +	struct rcar_gen4_pcie *rcar =3D to_rcar_gen4_pcie(dw);
> > +	int i, changes;
> > +
> > +	rcar_gen4_pcie_ltssm_enable(rcar, true);
> > +
> > +	/*
> > +	 * Require direct speed change with retrying here if the link_gen is
> > +	 * PCIe Gen2 or higher.
> > +	 */
> > +	changes =3D min_not_zero(dw->link_gen, RCAR_MAX_LINK_SPEED) - 1;
> > +
> > +	/*
> > +	 * Since dw_pcie_setup_rc() sets it once, PCIe Gen2 will be trained.
> > +	 * So, this needs remaining times for up to PCIe Gen4 if RC mode.
> > +	 */
> > +	if (changes && rcar->mode =3D=3D DW_PCIE_RC_TYPE)
> > +		changes--;
> > +
> > +	for (i =3D 0; i < changes; i++) {
> > +		/* No error because possible disconnected here if EP mode */
> > +		if (rcar_gen4_pcie_speed_change(dw))
> > +			break;
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
> > +static int rcar_gen4_pcie_common_init(struct rcar_gen4_pcie *rcar)
> > +{
> > +	struct dw_pcie *dw =3D &rcar->dw;
> > +	u32 val;
> > +	int ret;
> > +
> > +	ret =3D clk_bulk_prepare_enable(DW_PCIE_NUM_CORE_CLKS, dw->core_clks)=
;
> > +	if (ret) {
> > +		dev_err(dw->dev, "Failed to enable ref clocks\n");
> > +		return ret;
> > +	}
> > +
> > +	if (!reset_control_status(dw->core_rsts[DW_PCIE_PWR_RST].rstc))
> > +		reset_control_assert(dw->core_rsts[DW_PCIE_PWR_RST].rstc);
> > +
> > +	val =3D readl(rcar->base + PCIEMSR0);
> > +	if (rcar->mode =3D=3D DW_PCIE_RC_TYPE) {
> > +		val |=3D DEVICE_TYPE_RC;
>=20
> > +	} else if (rcar->mode =3D=3D DW_PCIE_EP_TYPE) {
> > +		val |=3D DEVICE_TYPE_EP;
>=20
> Ideally this should have been moved to the patch
> [PATCH v22 14/16] PCI: dwc: rcar-gen4: Add R-Car Gen4 PCIe Endpoint suppo=
rt

I got it. I'll move this to the patch 14/16.

Best regards,
Yoshihiro Shimoda

> -Serge(y)
>=20
> > +	} else {
> > +		ret =3D -EINVAL;
> > +		goto err_unprepare;
> > +	}
> > +
> > +	if (dw->num_lanes < 4)
> > +		val |=3D BIFUR_MOD_SET_ON;
> > +
> > +	writel(val, rcar->base + PCIEMSR0);
> > +
> > +	ret =3D reset_control_deassert(dw->core_rsts[DW_PCIE_PWR_RST].rstc);
> > +	if (ret)
> > +		goto err_unprepare;
> > +
> > +	return 0;
> > +
> > +err_unprepare:
> > +	clk_bulk_disable_unprepare(DW_PCIE_NUM_CORE_CLKS, dw->core_clks);
> > +
> > +	return ret;
> > +}
> > +
> > +static void rcar_gen4_pcie_common_deinit(struct rcar_gen4_pcie *rcar)
> > +{
> > +	struct dw_pcie *dw =3D &rcar->dw;
> > +
> > +	reset_control_assert(dw->core_rsts[DW_PCIE_PWR_RST].rstc);
> > +	clk_bulk_disable_unprepare(DW_PCIE_NUM_CORE_CLKS, dw->core_clks);
> > +}
> > +
> > +static int rcar_gen4_pcie_prepare(struct rcar_gen4_pcie *rcar)
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
> > +static void rcar_gen4_pcie_unprepare(struct rcar_gen4_pcie *rcar)
> > +{
> > +	struct device *dev =3D rcar->dw.dev;
> > +
> > +	pm_runtime_put(dev);
> > +	pm_runtime_disable(dev);
> > +}
> > +
> > +static int rcar_gen4_pcie_get_resources(struct rcar_gen4_pcie *rcar)
> > +{
> > +	/* Renesas-specific registers */
> > +	rcar->base =3D devm_platform_ioremap_resource_byname(rcar->pdev, "app=
");
> > +
> > +	return PTR_ERR_OR_ZERO(rcar->base);
> > +}
> > +
> > +static const struct dw_pcie_ops dw_pcie_ops =3D {
> > +	.start_link =3D rcar_gen4_pcie_start_link,
> > +	.stop_link =3D rcar_gen4_pcie_stop_link,
> > +	.link_up =3D rcar_gen4_pcie_link_up,
> > +};
> > +
> > +static struct
> > +rcar_gen4_pcie *rcar_gen4_pcie_devm_alloc(struct platform_device *pdev=
)
> > +{
> > +	struct device *dev =3D &pdev->dev;
> > +	struct rcar_gen4_pcie *rcar;
> > +
> > +	rcar =3D devm_kzalloc(dev, sizeof(*rcar), GFP_KERNEL);
> > +	if (!rcar)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	rcar->dw.ops =3D &dw_pcie_ops;
> > +	rcar->dw.dev =3D dev;
> > +	rcar->pdev =3D pdev;
> > +	dw_pcie_cap_set(&rcar->dw, EDMA_UNROLL);
> > +	dw_pcie_cap_set(&rcar->dw, REQ_RES);
> > +	platform_set_drvdata(pdev, rcar);
> > +
> > +	return rcar;
> > +}
> > +
> > +/* Host mode */
> > +static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
> > +{
> > +	struct dw_pcie *dw =3D to_dw_pcie_from_pp(pp);
> > +	struct rcar_gen4_pcie *rcar =3D to_rcar_gen4_pcie(dw);
> > +	int ret;
> > +	u32 val;
> > +
> > +	gpiod_set_value_cansleep(dw->pe_rst, 1);
> > +
> > +	ret =3D rcar_gen4_pcie_common_init(rcar);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/*
> > +	 * According to the section 3.5.7.2 "RC Mode" in DWC PCIe Dual Mode
> > +	 * Rev.5.20a, we should disable two BARs to avoid unnecessary memory
> > +	 * assignment during device enumeration.
> > +	 */
> > +	dw_pcie_writel_dbi2(dw, PCI_BASE_ADDRESS_0, 0x0);
> > +	dw_pcie_writel_dbi2(dw, PCI_BASE_ADDRESS_1, 0x0);
> > +
> > +	/* Enable MSI interrupt signal */
> > +	val =3D readl(rcar->base + PCIEINTSTS0EN);
> > +	val |=3D MSI_CTRL_INT;
> > +	writel(val, rcar->base + PCIEINTSTS0EN);
> > +
> > +	msleep(PCIE_T_PVPERL_MS);	/* pe_rst requires 100msec delay */
> > +
> > +	gpiod_set_value_cansleep(dw->pe_rst, 0);
> > +
> > +	return 0;
> > +}
> > +
> > +static void rcar_gen4_pcie_host_deinit(struct dw_pcie_rp *pp)
> > +{
> > +	struct dw_pcie *dw =3D to_dw_pcie_from_pp(pp);
> > +	struct rcar_gen4_pcie *rcar =3D to_rcar_gen4_pcie(dw);
> > +
> > +	gpiod_set_value_cansleep(dw->pe_rst, 1);
> > +	rcar_gen4_pcie_common_deinit(rcar);
> > +}
> > +
> > +static const struct dw_pcie_host_ops rcar_gen4_pcie_host_ops =3D {
> > +	.host_init =3D rcar_gen4_pcie_host_init,
> > +	.host_deinit =3D rcar_gen4_pcie_host_deinit,
> > +};
> > +
> > +static int rcar_gen4_add_dw_pcie_rp(struct rcar_gen4_pcie *rcar)
> > +{
> > +	struct dw_pcie_rp *pp =3D &rcar->dw.pp;
> > +
> > +	pp->num_vectors =3D MAX_MSI_IRQS;
> > +	pp->ops =3D &rcar_gen4_pcie_host_ops;
> > +	rcar->mode =3D DW_PCIE_RC_TYPE;
> > +
> > +	return dw_pcie_host_init(pp);
> > +}
> > +
> > +static void rcar_gen4_remove_dw_pcie_rp(struct rcar_gen4_pcie *rcar)
> > +{
> > +	dw_pcie_host_deinit(&rcar->dw.pp);
> > +}
> > +
> > +static int rcar_gen4_pcie_probe(struct platform_device *pdev)
> > +{
> > +	struct rcar_gen4_pcie *rcar;
> > +	int err;
> > +
> > +	rcar =3D rcar_gen4_pcie_devm_alloc(pdev);
> > +	if (IS_ERR(rcar))
> > +		return PTR_ERR(rcar);
> > +
> > +	err =3D rcar_gen4_pcie_get_resources(rcar);
> > +	if (err)
> > +		return err;
> > +
> > +	err =3D rcar_gen4_pcie_prepare(rcar);
> > +	if (err)
> > +		return err;
> > +
> > +	err =3D rcar_gen4_add_dw_pcie_rp(rcar);
> > +	if (err)
> > +		goto err_unprepare;
> > +
> > +	return 0;
> > +
> > +err_unprepare:
> > +	rcar_gen4_pcie_unprepare(rcar);
> > +
> > +	return err;
> > +}
> > +
> > +static void rcar_gen4_pcie_remove(struct platform_device *pdev)
> > +{
> > +	struct rcar_gen4_pcie *rcar =3D platform_get_drvdata(pdev);
> > +
> > +	rcar_gen4_remove_dw_pcie_rp(rcar);
> > +	rcar_gen4_pcie_unprepare(rcar);
> > +}
> > +
> > +static const struct of_device_id rcar_gen4_pcie_of_match[] =3D {
> > +	{ .compatible =3D "renesas,rcar-gen4-pcie", },
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(of, rcar_gen4_pcie_of_match);
> > +
> > +static struct platform_driver rcar_gen4_pcie_driver =3D {
> > +	.driver =3D {
> > +		.name =3D "pcie-rcar-gen4",
> > +		.of_match_table =3D rcar_gen4_pcie_of_match,
> > +		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> > +	},
> > +	.probe =3D rcar_gen4_pcie_probe,
> > +	.remove_new =3D rcar_gen4_pcie_remove,
> > +};
> > +module_platform_driver(rcar_gen4_pcie_driver);
> > +
> > +MODULE_DESCRIPTION("Renesas R-Car Gen4 PCIe controller driver");
> > +MODULE_LICENSE("GPL");
> > --
> > 2.25.1
> >
