Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634806221D9
	for <lists+linux-pci@lfdr.de>; Wed,  9 Nov 2022 03:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiKICRv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Nov 2022 21:17:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKICRu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Nov 2022 21:17:50 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2098.outbound.protection.outlook.com [40.107.113.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7451568C43;
        Tue,  8 Nov 2022 18:17:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ixejYV/ymzTkO7LSZOiUS89Gw6NRqFuNLn4yUygY9RA8FHNd2No5yAY58XofYs/ghRWyEYhWEHLI8OiXBqFlU5AqZ3+XGiAfZQw0iaksv2KXl8gyTfGSGwjso3vH2W48qqPohrDYFemUkhlOROzZdfEOjYPSna7UTchTtbWd8est4BuiYFhwKtonnpiRX7ezcvrr6c19rG1G3dj3+hlf2zPOCFyN3Px31BtnkXH2TIH1YBdyCyNOeKPfTltGBZvdtZmDNyXzytSvP088rO+kkQ+rIZl7vKfDPeAm1f/F1iHJdpibDK+vffLQLbWqHqVMGKagJ+RuNvFKVDFjllU35Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BjfoeW6WTRWvS/pELj/l5FsNdDP9K2INR41BH3avPg4=;
 b=JNebguiYeNR3Yu57TaDrwsEQfqkHX/eC6NVNTLg7ooXoL2/5V4z1bHWi7ZqOFeM4AAplNh1wu13r0+dJy0sOVbVtiijKduOXpvoYoi5Omtl3+MXHJQLVbFWlXoT5neUswxMAmq6XDINUP1iwOzjQKgZbvTIVvRIvWvgFoc6h10R4/VflgBfPYPmehBQgc9lvXBRadhObvF1SYsGbXthQzi/e0lrC7BGDO37djgSAgSxTeLXUo0EkpyqoS+ne7jDlUUzbXnU3P+NO5PpOhssi14PNdab1AfqIJhrfyc1/Q3Had56Hu0eH0UUbm3qwZujzLxd+Ij1T7DgEOhLNpJX1+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BjfoeW6WTRWvS/pELj/l5FsNdDP9K2INR41BH3avPg4=;
 b=WrkqfOFysiafbK0DKFfn9yvLyhDjZSEk3PwiaTrVdYIGHdMznI+5gmUsKNdnCWtoCO4eFzpSiHbzvMpvBt4tOyxIL0HY5ESquDCCskRz1ZsciFGiki9dzQrieMdycZ1eBuMbhLBA7iZmT273l4QyiKSlJHNufbhpGTVEPppqYHg=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by OS3PR01MB5767.jpnprd01.prod.outlook.com
 (2603:1096:604:b5::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 02:17:45 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::cd89:4a4b:161e:b78d]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::cd89:4a4b:161e:b78d%9]) with mapi id 15.20.5791.027; Wed, 9 Nov 2022
 02:17:45 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Robin Murphy <robin.murphy@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        caihuoqing <caihuoqing@baidu.com>, Vinod Koul <vkoul@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 17/20] PCI: dwc: Introduce generic resources getter
Thread-Topic: [PATCH v6 17/20] PCI: dwc: Introduce generic resources getter
Thread-Index: AQHY8vD0ArOnmyVAxke/JMPI7hs1ua412tJQ
Date:   Wed, 9 Nov 2022 02:17:45 +0000
Message-ID: <TYBPR01MB534178751E369DA4C031AE77D83E9@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20221107204934.32655-1-Sergey.Semin@baikalelectronics.ru>
 <20221107204934.32655-18-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20221107204934.32655-18-Sergey.Semin@baikalelectronics.ru>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|OS3PR01MB5767:EE_
x-ms-office365-filtering-correlation-id: f1c28314-6357-470f-430e-08dac1f89720
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GFegrc8iG+MlXV9NCOJ3zZIG+Q7V4eO53Pl2k2XHS7rK5t8eAFlrLwzmUUS/q/KIIjD6yA6fbiAgl4W+kbDjINMp12/GXnEPtLrA3AdnClPdZ2up6TPK8qAMN3KETS1xMDEk2DyinbkMz8ekteYdlJyrBSWk9lNSDu/eadiAu7JzvyFgExljYM2m0NhoOFQfYKqdFnFyYJVYeWXTfu/a/7DnmQEX9WNDfNSqVbOvJeWWR5VGJkVzcdgqPUJnLd7Qb6J8XFuX72g4gqNZ5QOe2jKLzhAW7sf7Zj+7afeJvuZMlL/FFeaqnv/ZQ2YZ0atz5yx2LFGImR+s8N00xNw54WzxN76YlApZzz3+yT6p7DWjHIf/a7TAQLIYangVY1cDkXdrjFETVBTNJYUm0METVWXWwAxkDg2ZsqM5Y9aBwEAyKna24CQ/NaNIa8+qNUUEI7blvua9lnUXckBt6zQbAQQz7Nb9b9Mc1EOqSkvYWHolAZZBmhIWfhSOM3ytcprk4JgHmZQfZXwYWQCrfibKuj0pwtd8HtfP5qnAXiP1y3qG5tMVoLj1gvIJUZ5imXJO5D7oCpW07yLBasqsgAH3L/GnbhSB8KMfIuuJZ3GVnR7UdaJKc7ThPHwjqDo4gH4N5Jp+NH1o3+0lB5VXuVieB43S9CRnf18cHkmNA6OjnqnwWj1hFq1MQ24VQnTaWLWxW2XbNjP+y/XA46tGN6K/I979eNrcXYgCJngbXVx4a59Keg/f5oLCfwtHZ/VFoLtRtyZ2oOVtmp3yJtI8EGmKuO0Ur5JSkFBD5Okmgw6Pskr9gqFTxoptJRSQ8uDysl2w
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(451199015)(83380400001)(86362001)(33656002)(122000001)(38100700002)(921005)(38070700005)(478600001)(55016003)(5660300002)(76116006)(66946007)(41300700001)(8936002)(7416002)(71200400001)(52536014)(8676002)(66446008)(66556008)(110136005)(54906003)(4326008)(64756008)(66476007)(316002)(186003)(9686003)(2906002)(6506007)(7696005)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?X0c9IW8JmyM5SJmheG0XME3IcPZWneUpEvKhDp2SmG3I0Ki+2bZOldsQDy?=
 =?iso-8859-2?Q?QZBEcZ/st0a9pttT3Pg29JksmLJ7x16+8wm4N1Zf59pM+hZI4qAGFMxPrY?=
 =?iso-8859-2?Q?Jyg/NwfmZFVF7CuzZYlLIiqJXP073lTD/1SIDBwMRjPhLMwIpa+rKDHo5c?=
 =?iso-8859-2?Q?L22WtuNYxvNkXlOmM7uk/tQKPBe7fhVqibW5+GuByoQz4dhE0gkzriyXbW?=
 =?iso-8859-2?Q?7hqZkrOSMPmzQAc6n3TTQ5+9jIp6Fr0i+D05c2ylOqlXuL4hUxtazHE092?=
 =?iso-8859-2?Q?EUndSx4yg4sci8NVBVwDpb5JFSc3h15tRx4C0GUJH7Y8FTflIpm6+0y96e?=
 =?iso-8859-2?Q?j7ILx2En3QeapwSxAlGcblPT7V2SGH311SJogYIAjCrbu5YTACQQH77OsA?=
 =?iso-8859-2?Q?W8ct1ftlQD1PyL+m/KielKSwzX5vMSn9h1u3om0n2C8/AaQrzWffM2q4q3?=
 =?iso-8859-2?Q?DDud/NCC5zuGcjIhTNcmo6r+OspJa2v+2D/YCdtVh2s/aMCapUlfdhUdYC?=
 =?iso-8859-2?Q?0sMDpmhZJ5NmbCujO7Fxlar7N0Wyzy4EfoCJZl3irvwilAf/9K+TRkLrTF?=
 =?iso-8859-2?Q?gdg4ExIu4lcc1DGNNV2aGtJIUeZpJVD3NtGVPvHBWrJOjTHVGRwKGudJVM?=
 =?iso-8859-2?Q?Vq/iyiSvuNuq/OJ+DafB6OMQJhO1g9I//1a8R8LaBFmGn6i1I81sil+Y2Y?=
 =?iso-8859-2?Q?Wx5ioBNB5YmlFV919tBsgPDh9BOp1qgab+1RA5m06kRYKMRuo+dpCWR/Bm?=
 =?iso-8859-2?Q?0BCEPsAJSmH8kysbQ453YFQIIBByunHBKWiP8/4qiZV62H+qQ3M579UCVv?=
 =?iso-8859-2?Q?AdZsrz9+jismVU6fZVBT7S9/3N3mfIpDiWPAMciv9ngOniP+StS3dvONaP?=
 =?iso-8859-2?Q?rDf0RGBeBlMddxOeTCB57qSZErCHfo0wHJhreU+QJfgIkPy04DJZBQI7XA?=
 =?iso-8859-2?Q?7XYacgzymAzLxQ/9BfVPG+gmxFL5FxC4LguqUk5kkUT9eZsaWxGniKo21G?=
 =?iso-8859-2?Q?SI/4v8bqnJ0011Dl3qCVwdSRVUCzBnMcJS1+7OuzarjAuDoL6Dd+YTGKRW?=
 =?iso-8859-2?Q?SYCjscJ1UEK/2MvQ8o7bUFo+IFKVCCtaNXd11mJ4+SuTEIxDHSqCCnl4kF?=
 =?iso-8859-2?Q?GyHht7RS0Mqfz3ZJ/ttIa5b2TmcSOKTOQ+lNBfIe5BsXb0XPNnpEvNQ2fk?=
 =?iso-8859-2?Q?HQURfFL8w9E/SGbUF5M4XMP1wtyA7pRm76bfXHBnYDf8uj9EP3mnMxylbn?=
 =?iso-8859-2?Q?8p/tv5YejO87wsiId05Zer/a7JXzl7LacOw2v+n6cQtKlsgS0xewVwY7nK?=
 =?iso-8859-2?Q?L6MhSojD46nbn/QFtLIgnZwI3Bm+n7dhhF2hKqvw6hQAE5ef7vcdUGOFY5?=
 =?iso-8859-2?Q?6LnKpiBccBinnx8eqdwQePqyxSfI8calEAUY/S9rUsLF6SeHR06/viCea6?=
 =?iso-8859-2?Q?ydGjm+hmQN0v7uZsC/r9RNcCnebdd6KXXIydU2IrvDsg4YBhzLpuICAV6v?=
 =?iso-8859-2?Q?Ivph8CQ1bxpmC1tNQ87d3E9GBOGFhuTLJ8jh84NRVupNEkY+cF/k+bvIcd?=
 =?iso-8859-2?Q?KVpO0Ki5v1RjpfNoYHIN/iYSZfzzMMlN4xX3zM7UTHZxIqmc8l2ipuaj+6?=
 =?iso-8859-2?Q?hz6QR8D0kHNeDobIWo6vKMZ5aFqiuwsdbusGhHRUaijU4owSxPxI076on+?=
 =?iso-8859-2?Q?EVyWnm6TL+aqZkEP5OYSdryR4VXIZTuhYiHORfsnYDAp5JHxzwTNiL7KO+?=
 =?iso-8859-2?Q?W5Xw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1c28314-6357-470f-430e-08dac1f89720
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2022 02:17:45.7245
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +H+At0/8imdgMD7duhnrRybDsK3s3wke7WMkpD2sVGT9uMZuRp1QNDHxT+Wf4/+KL2Ou5FpEXnS/OpKz1jPZRjiGNeZZrsSQcoe8yY69HhW89m24DczhiGoNXHCOepiP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5767
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Serge,

> From: Serge Semin, Sent: Tuesday, November 8, 2022 5:50 AM
>=20
> Currently the DW PCIe Root Port and Endpoint CSR spaces are retrieved in
> the separate parts of the DW PCIe core driver. It doesn't really make
> sense since the both controller types have identical set of the core CSR
> regions: DBI, DBI CS2 and iATU/eDMA. Thus we can simplify the DW PCIe Hos=
t
> and EP initialization methods by moving the platform-specific registers
> space getting and mapping into a common method. It gets to be even more
> justified seeing the CSRs base address pointers are preserved in the
> common DW PCIe descriptor. Note all the OF-based common DW PCIe settings
> initialization will be moved to the new method too in order to have a
> single function for all the generic platform properties handling in singl=
e
> place.
>=20
> A nice side-effect of this change is that the pcie-designware-host.c and
> pcie-designware-ep.c drivers are cleaned up from all the direct dw_pcie
> storage modification, which makes the DW PCIe core, Root Port and Endpoin=
t
> modules more coherent.
>=20
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Reviewed-by: Rob Herring <robh@kernel.org>
>=20
> ---
>=20
> Changelog v3:
> - This is a new patch created on v3 lap of the series.
>=20
> Changelog v4:
> - Convert the method name from dw_pcie_get_res() to
>   dw_pcie_get_resources(). (@Bjorn)
> ---
>  .../pci/controller/dwc/pcie-designware-ep.c   | 26 +------
>  .../pci/controller/dwc/pcie-designware-host.c | 15 +---
>  drivers/pci/controller/dwc/pcie-designware.c  | 75 ++++++++++++++-----
>  drivers/pci/controller/dwc/pcie-designware.h  |  3 +
>  4 files changed, 65 insertions(+), 54 deletions(-)
>=20
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pc=
i/controller/dwc/pcie-designware-ep.c
> index 237bb01d7852..80a64b63c055 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -13,8 +13,6 @@
>  #include <linux/pci-epc.h>
>  #include <linux/pci-epf.h>
>=20
> -#include "../../pci.h"
> -
>  void dw_pcie_ep_linkup(struct dw_pcie_ep *ep)
>  {
>  	struct pci_epc *epc =3D ep->epc;
> @@ -688,29 +686,14 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
>  	struct device *dev =3D pci->dev;
>  	struct platform_device *pdev =3D to_platform_device(dev);
> -	struct device_node *np =3D dev->of_node;

Removing this np causes the following build error if CONFIG_PCIE_DW_EP is e=
nabled:
---
  CC      drivers/pci/controller/dwc/pcie-designware-ep.o
drivers/pci/controller/dwc/pcie-designware-ep.c: In function 'dw_pcie_ep_in=
it':
drivers/pci/controller/dwc/pcie-designware-ep.c:751:35: error: 'np' undecla=
red (first use in this function); did you mean 'ep'?
  751 |         ret =3D of_property_read_u8(np, "max-functions", &epc->max_=
functions);
      |                                   ^~
      |                                   ep
drivers/pci/controller/dwc/pcie-designware-ep.c:751:35: note: each undeclar=
ed identifier is reported only once for each function it appears in
---

So, we should keep the np or use "dev->of_node" to the of_property_read_u8(=
).

Best regards,
Yoshihiro Shimoda

