Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F22A5B2089
	for <lists+linux-pci@lfdr.de>; Thu,  8 Sep 2022 16:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbiIHO1H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Sep 2022 10:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbiIHO07 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Sep 2022 10:26:59 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80043.outbound.protection.outlook.com [40.107.8.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7136FB8E4;
        Thu,  8 Sep 2022 07:26:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aSlam4MWtB6f3AlU2ns1e4yGFik4Z3qIsH4VRmYxjdTU1j+ZbNiDnX6JH9y/zwRCEw/M+vDhioJpK5QTyobVOCbDLpSFyeNGOIE0DLm/8cEnx01vMDiE6p4lHhze4RBLlpSqrwwHs0uO8e2mBkgK4TBt+QcGNApgRUIKcFWTerRkzrI0FPuHe+DINXrHMwVuhk3sQ6L6NzPC6yX8D5djs9IT5sTj6AiPFvPBs/p+jw6NfvOmcdwpAwCqtytnqD2nlEKc+BQStNNRLD+Wxvf9BwWMsKwcBt/wQwEwwzEbNu57IMgwS2sOBf7tgQbila0GKab3XLYlsNuhT06vRG1PIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hnSQX9mC1VFUdm8WVHpaK6kPpl2+h66UxcavC3mNYqI=;
 b=Qgevb2ayIifG3ozKjvrRE+352nI+AosBj2e5bNExKzw4XeOtRK5j9GQxIWaWmHQXExKwkke2OTqXboR26hDTNm9XL97G7ynwoomUeZb0kFfu0Q2FfNXTpWG6zdcZ2azztxHGDD5Bv8F9dfKYxfqBdbcUgFMxl3imMJto8kMSTNkgZkzYq5RxLTi7GSMyukQfq57TGWvGyOGmRIUifLOX3WmMkwYJXSjFtHpyK/KzOPjrlcvx5jqPP/NwdXGVlPaJvobFpK0kxT5NLmljdJsrJn8CEYw8TzsKVx38JBONevL7ZizSLLBSWuXrm1nmdmbUYIDXmz0yXm+i+zjShx+sSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hnSQX9mC1VFUdm8WVHpaK6kPpl2+h66UxcavC3mNYqI=;
 b=oZQQQ5Qt7rj04sUCvIlOJtqUrE6WVwRmiMi9QPttWoJLjRY5oXJHtomy1A44cjby55HRTOpAtD/vdzNUAPx3xBXr9quFvzTNEy4KYMIOfDCIjN+Be0MAZ0yZ8i/sMKXlJM/1oBrEUzl3Nt9BPCEBnw8+dDHCip7tb6Rfgne+f3k=
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com (2603:10a6:20b:408::22)
 by AM7PR04MB6775.eurprd04.prod.outlook.com (2603:10a6:20b:102::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Thu, 8 Sep
 2022 14:26:50 +0000
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::1c3e:36a0:1adc:beb]) by AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::1c3e:36a0:1adc:beb%9]) with mapi id 15.20.5612.012; Thu, 8 Sep 2022
 14:26:50 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Marc Zyngier <maz@kernel.org>, kernel test robot <lkp@intel.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "jdmason@kudzu.us" <jdmason@kudzu.us>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "ntb@lists.linux.dev" <ntb@lists.linux.dev>,
        "lznuaa@gmail.com" <lznuaa@gmail.com>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>
Subject: RE: [EXT] Re: [PATCH v9 2/4] irqchip: Add IMX MU MSI controller
 driver
Thread-Topic: [EXT] Re: [PATCH v9 2/4] irqchip: Add IMX MU MSI controller
 driver
Thread-Index: AQHYwmzT0d5rWoxlpEiRJzxdVpfwVa3Up/2AgAB1DYCAAHtnkA==
Date:   Thu, 8 Sep 2022 14:26:50 +0000
Message-ID: <AM9PR04MB87938383F2FB0299CE228B4C88409@AM9PR04MB8793.eurprd04.prod.outlook.com>
References: <20220907034856.3101570-3-Frank.Li@nxp.com>
        <202209080757.hQMfrrfm-lkp@intel.com> <87h71iqrgg.wl-maz@kernel.org>
In-Reply-To: <87h71iqrgg.wl-maz@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8793:EE_|AM7PR04MB6775:EE_
x-ms-office365-filtering-correlation-id: bc401610-8b86-49e0-7d99-08da91a62b7b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uL3Vo5or+J18RxT2rpEjiz9Ol/axKWyfLpY3A+i9qqeCwEQL21I3oabt2WHIcl3IbRRkmezcAcvEhpcHZGvpLMhZ/Rz70L2xBZt1v80LpOmSDXZ3lUGZ89Ju3ae4oWf67tDsy9e79rDJ28q6/hnlSoFzzLaLWGWRALwNHMJWP2b5SjsYHMBg+wEO+mCQzNrYZwQ2DxiYUeg8/wjh3Yj2PYxx3eW4zt4zhQgJOl1UPxm/XRhNHoaOFr+zr8auMktv2BP8JxfyaiTU+wIdgg2LMakxLrEAKIVD5z3FFt+adaaJ4zJAQ34y+xJGeb/+GgaaFTtDZ9P/te/Io+5x+4EShDi2LASO5C3QZ/yyO2ciaOy+tjHXdiQ9plnMbFwg2B1PuHjkE4J7Vxt6+Wvyzem5P8mgbSLizdLtx5nr6QKDtexDsHNu+OP9a7F/Tb2uyEFIc3MJ+G3Pq6e+GJIqaxUHnxiOLHRmdXZMNyuY/N2SGx4y4zZkNZASeMW0MZ1aakS10Pjwkb9G4gaqwkfW6w6E6PhxhIsvNjKUNYqFnds0xVThxjnifXBSn3xAd4sFQaimlJen1jNV35jLwEjzXknV52tRBwPm2t3VRzN7WSevC7rITMf3W6a9iLR7cIh2H5N0qaCuO5XcM5iOhIRT0uSftkn0O8h5VmeaMw2A7CX+Z35bFSeQC/PQCcrPxrEREWQgSI3I4XlDXBpC+m3jtoglgQYgJqQC+JTpHBLlmjxq8L8EAAj0kbqXGefJw7l6x7ItL83X6Ic0UaIWQgOcOfhS2ls6LcwuwvHAH/BNjBsQp2LGntBgGAK3AXKgcRYs9LyBTfgnqL2ZrL3QfnqVOnBRaQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8793.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(9686003)(55236004)(38100700002)(55016003)(7696005)(478600001)(26005)(966005)(41300700001)(71200400001)(6506007)(53546011)(86362001)(122000001)(38070700005)(83380400001)(66556008)(44832011)(186003)(316002)(2906002)(110136005)(33656002)(5660300002)(64756008)(66446008)(4326008)(76116006)(66476007)(8676002)(7416002)(54906003)(66946007)(52536014)(8936002)(45080400002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6IusSUM+JYZh1iIouS5KF7NygUl8XmJXffmOfuFzzrATa2brRiuOqu2fO0xV?=
 =?us-ascii?Q?DrGCfzhVdWdH5wZEZGgy+gx3PG01PkInJUHOFXvUutEFoGeL3lpfwI566Um1?=
 =?us-ascii?Q?9GdIWYG7fJ8zB5kLwCP7dLRUGpv+coMUZ9FPqqIPFzNkOsX0u0Y3nOXKqEwz?=
 =?us-ascii?Q?8apvusOYO34FPv6F9TZ+fUuJaoyCJEkWA9m7kzGqy6hxXPqUnnYac8N3PiT4?=
 =?us-ascii?Q?uChvZFti+F9+utQt2dkxyJW7LqcsF3H7ltIVo7BmSnF6LWg7tT3skG/aYlWC?=
 =?us-ascii?Q?kU2WiHb3H2mEea4D7FVaGhyyVdQdXnozzc2p1rQD7huhyN1/VFC/bxWd3MuF?=
 =?us-ascii?Q?6Xae74qbsiX4kRnd9hqcmYxZ1sdaVvHJotiX79VsvODqvvl7jfRzyG1LKc4M?=
 =?us-ascii?Q?tbl0ujyzBYu4hG50U5crm9Hg3zHiOFRGJCW4vbOJb61zQDRY/FO7JhbVoN7l?=
 =?us-ascii?Q?660/Ora0UoICsxaaCwxCFosZTk3dT8CEk5ZV9BusRX9LleKgtoUdI8AElZhy?=
 =?us-ascii?Q?1EQFc80ruPw1CExv+32Uv7cyd+GWc7HdbFtEJhXVOazDtj0lj8Y3FdT9lO5J?=
 =?us-ascii?Q?h2rhYkTSd3uBYoi3dmH9E33piTs+qui0hW9eQ+XQSlBs+//S6a5lrucU7FHe?=
 =?us-ascii?Q?IwUokc5HiVlPBzRetkrwJCGRsqp22bEg3s1dgfxK6n+qRLgEIG2X5I/IuNbc?=
 =?us-ascii?Q?MG1P5K5M4hxZ9DNDGqumGHorz+RomjfuszjbBoOQ5EjFovEbKOTcdipL6VT7?=
 =?us-ascii?Q?nKyrYDht0+Y99LrM/+EqAubKDLEgXWAB+F0Y9bJ2yfH9A54HtiyJhvUxc6L/?=
 =?us-ascii?Q?US9LrNVC+WV1YhwhShuIXwnrCjlN41Pmb5Ydjb8MR6DjbpnKlj8RC0PyJ1NL?=
 =?us-ascii?Q?Ewhl1nuxPhmVCcSGWNRyo7tUyJ/WlgtiuGQ0FcvuWhCnen2Opk2L3OeVsFbK?=
 =?us-ascii?Q?DGmJNqrYRfMfDjeoJ7N/6YslIdZ8cABD9Z6Jr8OjJdsOIb1k3YKTfVcF37q0?=
 =?us-ascii?Q?p5/Txd7VfWYxm6owhDhqAVE5vQ5v9XAHjQ2edLHX5NGx+zhtT+HHrkSRL9op?=
 =?us-ascii?Q?w5vPesQlXlYVjKzHHYMOKodU9viC3rcertido2ecmXm/X0Wz5w/rcQ7qkY6i?=
 =?us-ascii?Q?pGzUaTYJ717kikBU0bq6HKoP7FfsARcVHQn1VsMEbASAcHDZ9YqCA00Awdu0?=
 =?us-ascii?Q?wbEOZhBO9tzHhjYZE8jft/1G+3du2wreQMNdY0aLDVzENmKeT0kKIuMI4K6p?=
 =?us-ascii?Q?ID8AcqilKvVgM8f1Qbi5WhKfYKhbOuHc/8HjEfrOGEPw2lKG5bSu92et3PhP?=
 =?us-ascii?Q?aC78fih14q5B8b90GJlspHXkGmeXLpr78aXCEbjwBI+UbKT25abUQXj2fhGx?=
 =?us-ascii?Q?7Z/EFlQJyWcp40q4lXz2y4UDDyS4tyGwKz/NQBL4RzseTAYYB9Q+lCWWKjlt?=
 =?us-ascii?Q?zO8ftgPWtmZqca7yCySY8hYBeLw+4EMkPUVM+GGfLr8x7Vf0g22RmmyRcjhV?=
 =?us-ascii?Q?+xpQ/4Rif1i8l0Ek+SmF7eU0JDxzxxtgUM2FEDKY1yiNLSLX3+MnIW2UEqwW?=
 =?us-ascii?Q?OI28b7DNKSeG4bt//DI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8793.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc401610-8b86-49e0-7d99-08da91a62b7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 14:26:50.6302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lUpb2tScCYN/Re8olZYWgK1j7hZsZdthW/I+ELWeFsQWDBcdSHLe4G/LBTqzARteXlQg/V8hxMfHaA3ZGvEPmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6775
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
> From: Marc Zyngier <maz@kernel.org>
> Sent: Thursday, September 8, 2022 2:02 AM
> To: kernel test robot <lkp@intel.com>; Frank Li <frank.li@nxp.com>
> Cc: tglx@linutronix.de; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; shawnguo@kernel.org;
> s.hauer@pengutronix.de; kw@linux.com; bhelgaas@google.com; kbuild-
> all@lists.01.org; linux-kernel@vger.kernel.org; devicetree@vger.kernel.or=
g;
> linux-arm-kernel@lists.infradead.org; linux-pci@vger.kernel.org; Peng Fan
> <peng.fan@nxp.com>; Aisheng Dong <aisheng.dong@nxp.com>;
> jdmason@kudzu.us; kernel@pengutronix.de; festevam@gmail.com; dl-linux-
> imx <linux-imx@nxp.com>; kishon@ti.com; lorenzo.pieralisi@arm.com;
> ntb@lists.linux.dev; lznuaa@gmail.com; imx@lists.linux.dev;
> manivannan.sadhasivam@linaro.org
> Subject: [EXT] Re: [PATCH v9 2/4] irqchip: Add IMX MU MSI controller driv=
er
>=20
> Caution: EXT Email
>=20
> Frank,
>=20
> On Thu, 08 Sep 2022 01:03:27 +0100,
> kernel test robot <lkp@intel.com> wrote:
> >
> > Hi Frank,
> >
> > I love your patch! Yet something to improve:
> >
> > [auto build test ERROR on jonmason-ntb/ntb-next]
> > [also build test ERROR on robh/for-next linus/master v6.0-rc4 next-
> 20220907]
> > [cannot apply to tip/irq/core]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
-
> scm.com%2Fdocs%2Fgit-format-
> patch%23_base_tree_information&amp;data=3D05%7C01%7CFrank.Li%40nxp.c
> om%7Cc409668bc0994f1df11708da91681c6f%7C686ea1d3bc2b4c6fa92cd99c
> 5c301635%7C0%7C0%7C637982173598672297%7CUnknown%7CTWFpbGZsb
> 3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
> %3D%7C3000%7C%7C%7C&amp;sdata=3DLgRkCWQ%2BX0GLT5qUaLvIS9SuYMB
> 6tX%2FerPNl3KwW7Tc%3D&amp;reserved=3D0]
> >
> > url:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithu=
b
> .com%2Fintel-lab-lkp%2Flinux%2Fcommits%2FFrank-Li%2FPCI-EP-driver-
> support-MSI-doorbell-from-host%2F20220907-
> 115114&amp;data=3D05%7C01%7CFrank.Li%40nxp.com%7Cc409668bc0994f1d
> f11708da91681c6f%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6
> 37982173598672297%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwM
> DAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7
> C&amp;sdata=3DhpU6XQmibxCGo0S8J7VuPuZDhe6OwCzR92ld9UvODYw%3D&
> amp;reserved=3D0
> > base:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithu=
b
> .com%2Fjonmason%2Fntb&amp;data=3D05%7C01%7CFrank.Li%40nxp.com%7C
> c409668bc0994f1df11708da91681c6f%7C686ea1d3bc2b4c6fa92cd99c5c3016
> 35%7C0%7C0%7C637982173598672297%7CUnknown%7CTWFpbGZsb3d8eyJ
> WIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%
> 7C3000%7C%7C%7C&amp;sdata=3D3y7%2BH6wcN%2FxcV8swP3QR0lUihWhqw
> qjlTtgUAVAPVg8%3D&amp;reserved=3D0 ntb-next
> > config: s390-randconfig-s033-20220907
> (https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fdow
> nload.01.org%2F0day-
> ci%2Farchive%2F20220908%2F202209080757.hQMfrrfm-
> lkp%40intel.com%2Fconfig&amp;data=3D05%7C01%7CFrank.Li%40nxp.com%7C
> c409668bc0994f1df11708da91681c6f%7C686ea1d3bc2b4c6fa92cd99c5c3016
> 35%7C0%7C0%7C637982173598672297%7CUnknown%7CTWFpbGZsb3d8eyJ
> WIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%
> 7C3000%7C%7C%7C&amp;sdata=3DlFaWJd2d3ob06d3qNilgFovocFU%2FN4Goz
> 7jBTXLvCss%3D&amp;reserved=3D0)
> > compiler: s390-linux-gcc (GCC) 12.1.0
> > reproduce:
> >         wget
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fraw.g=
i
> thubusercontent.com%2Fintel%2Flkp-
> tests%2Fmaster%2Fsbin%2Fmake.cross&amp;data=3D05%7C01%7CFrank.Li%40
> nxp.com%7Cc409668bc0994f1df11708da91681c6f%7C686ea1d3bc2b4c6fa92
> cd99c5c301635%7C0%7C0%7C637982173598672297%7CUnknown%7CTWFp
> bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI
> 6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3D8C2pQ57ym0gNi0wHXT6KEj8%
> 2BAgMQKph8UhK6GPo%2BNIc%3D&amp;reserved=3D0 -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # apt-get install sparse
> >         # sparse version: v0.6.4-39-gce1a6720-dirty
> >         #
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithu=
b
> .com%2Fintel-lab-
> lkp%2Flinux%2Fcommit%2Fc1f079e633c10b4f2f1f3c8f52e447d13fda8ddb&a
> mp;data=3D05%7C01%7CFrank.Li%40nxp.com%7Cc409668bc0994f1df11708da9
> 1681c6f%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6379821735
> 98672297%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi
> V2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sda
> ta=3DoBYu8TZJ15AxtGO2IdtGJdE80fYIJTwF4RlkBkeO6hA%3D&amp;reserved=3D0
> >         git remote add linux-review
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithu=
b
> .com%2Fintel-lab-
> lkp%2Flinux&amp;data=3D05%7C01%7CFrank.Li%40nxp.com%7Cc409668bc099
> 4f1df11708da91681c6f%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%
> 7C637982173598672297%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjA
> wMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7
> C%7C&amp;sdata=3DAQn3FPjP13rnvvkA7TxRs3gpfd26siSoKM%2B%2Fwzw2J94
> %3D&amp;reserved=3D0
> >         git fetch --no-tags linux-review Frank-Li/PCI-EP-driver-support=
-MSI-
> doorbell-from-host/20220907-115114
> >         git checkout c1f079e633c10b4f2f1f3c8f52e447d13fda8ddb
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-12.1.0
> make.cross C=3D1 CF=3D'-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=3Dbuild_=
dir
> ARCH=3Ds390 SHELL=3D/bin/bash
> >
> > If you fix the issue, kindly add following tag where applicable
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All errors (new ones prefixed by >>):
> >
> >    s390-linux-ld: drivers/irqchip/irq-imx-mu-msi.o: in function
> `imx_mu_of_init':
> > >> drivers/irqchip/irq-imx-mu-msi.c:316: undefined reference to
> `devm_platform_ioremap_resource_byname'
>=20
> This is about the 4th time this breakage gets reported. You keep
> reposting this series without addressing it. What is it going to take
> for you to finally fix it? Clearly, I'm not going to bother taking a
> series that has pending build breakages.

[Frank Li] I also frustrate it now.  Robot use random config and can't=20
Report all problems once.  Recently update to gcc 12.x.  Build broken
Happen at other place at my environment. =20

>=20
>         M.
>=20
> --
> Without deviation from the norm, progress is not possible.
