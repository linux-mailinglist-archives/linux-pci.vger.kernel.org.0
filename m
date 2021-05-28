Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27496393E37
	for <lists+linux-pci@lfdr.de>; Fri, 28 May 2021 09:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbhE1Hzq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 May 2021 03:55:46 -0400
Received: from mail-am6eur05on2077.outbound.protection.outlook.com ([40.107.22.77]:7774
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230099AbhE1Hzn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 28 May 2021 03:55:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HMULHIzoeZaDd7Pc6uwQyEb6vyk1YzflXVuhL22aKwbJEjEaOGQob4xjigZmchjxIo/j9mV2rYY0rntX4e0Ai/l2bBUx2DCveolqUMD5091ACnFREtsBprLcrKgFx/jDZ/S5BSjMWka2o+aLugR1QzTxVkPnR4Ao0r/hasNp8PNa0Ka0rngAg7vD2gH4YUcgaRz+ErYmyJRx6tPBPhq2YeeEthwVl0ri5uViYV45VgfEy/Gufa/HkHU/Ron1eOZEkoJLZWTnkzo+d/TTUMjt0A9455Db2fxJZPORN/1YJ9AzkdMRadPyO6DJV4kdMWbagoOnYFhLaK4cEFu93I46Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IyWrE1H5sky7kXwh3yqCKUB4wUao6uMV7yjJnC1mi7I=;
 b=YqvRBgRE8TrXpl70JWwjqFwYFI9SfHJIu3FfYOYit554koTvz5hhW8UF19mDqnjJOt5eYewJUjLOpgx8Os7DwGIQ68VOzu4Lz9gm96rJQKCa7e/1onNPbtrDHInf0ae1gdYXezpptBA/HIPx7byte15p3lV+GBeK4/UqyNgkpWrC+EXrkSVxrIXIeFTtfNkf75H8PKbGV3KuEX0767HtwP0Y3H61ncR5vxV8VUq9H8pJYO2b2voceRm6r1fnGqSPwQOG+6Swqb8m4vi6m7LfLcW7ikcBbiH/TnlMMY19p8FpVgE9+JFwCvZ+K9sJdpi9HbT8mdQ5mrwoSG4eQ6MprQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IyWrE1H5sky7kXwh3yqCKUB4wUao6uMV7yjJnC1mi7I=;
 b=ZXmnqcWzGErxr1g1FhzIICQzpNwv5MEeweW+zuOo9hZKfLQxrK7jQ6PdDNTSL/lkVzbrixpcgL9s2NFb1H0p9qUKHtPt4j9y2bMQYEEt3kOYpLpd15v2he6n536g+zN9g6UA+FOlDFKuXxQpFMEdAkAo0oIZEfj6q1GkDGhJXlQ=
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com (2603:10a6:803:e3::25)
 by VI1PR04MB5504.eurprd04.prod.outlook.com (2603:10a6:803:d8::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Fri, 28 May
 2021 07:54:07 +0000
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::c830:a7cb:c125:2fb7]) by VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::c830:a7cb:c125:2fb7%6]) with mapi id 15.20.4173.026; Fri, 28 May 2021
 07:54:07 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 1/1] PCI: dwc/imx6: Remove redundant error printing in
 imx6_pcie_probe()
Thread-Topic: [PATCH 1/1] PCI: dwc/imx6: Remove redundant error printing in
 imx6_pcie_probe()
Thread-Index: AQHXRls+yBvBmfzqyUiaDTIg7fEL/ar4n+CA
Date:   Fri, 28 May 2021 07:54:07 +0000
Message-ID: <VI1PR04MB5853D1AB73A5A1C308D3D60A8C229@VI1PR04MB5853.eurprd04.prod.outlook.com>
References: <20210511114547.5601-1-thunder.leizhen@huawei.com>
In-Reply-To: <20210511114547.5601-1-thunder.leizhen@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2bc999a5-f1c3-4776-0427-08d921adc54b
x-ms-traffictypediagnostic: VI1PR04MB5504:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB550491CDA772BAB8D755D81E8C229@VI1PR04MB5504.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NokBKuFATFK3O5syAtkZ7b+EcHyme7IJklDrqALVMBpzYATA7J9ZV3jHF45RQ7lc0d6vC6SfJrCHigHUa/pGn+I+YegtUa7nc65Py/s3wTeLzDkBOqzr3mKwBLTavtyavfcSLWRscqz9Yx8737X3MuRO4/bwRT1tIviB0QLZ62fJj6l0NZJUwniZEB0Er9ewsLbTfVT63jrE0JGGKVh0FGoGEoayM0AqaYDZ+xlAaPEroT+ZRb5ZphS0daea2prfKLALp26eRt6P214dcd5DZ2wFG/frfSGLUhSEUqlD+c0Z9Qinct5o6BMhZDweNKYHZhi17Yv78Wp+6ewqct3WhcUlh9pqnTDUBVNoARnmJ3boaylj9zfRs7nYvM/0pxlEwsBphNfR4kqZKGiFRWqBbCWOwTYgDrsklUoLhj1vd1v1npv+FB0qwwpNcIoixR7EytsA7QPNgxPjgVaQqaH6vAcOfcCjd7lQyy5je+ixkLllKCRTRe3OfO0wjBhpdoJ1AR0JqdwejIlJc+F1a8KdJa3J0mClXg66rhddIOV1PFwIX/rM0wO+hHtCnclGclB9d3IVMug31JV+vlpdYufLF001lWLENl0cV6Lww/JkwjhrVihX3WYXM7iqOtD9ksfAk+yoZOgKff5RouTe/pnU0g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5853.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(396003)(376002)(136003)(366004)(33656002)(316002)(8936002)(921005)(186003)(83380400001)(86362001)(66556008)(66446008)(7696005)(71200400001)(52536014)(478600001)(26005)(66476007)(64756008)(6506007)(66946007)(76116006)(9686003)(5660300002)(2906002)(122000001)(110136005)(38100700002)(8676002)(55016002)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?jM/tkR13FmP2y5rv42vYcScURXqQkL68Ae66yYu4C/atCkCt85DVrhPt8qbP?=
 =?us-ascii?Q?yZD6qq25evjld5paHq+25tg4+pK18XasdQaK8WUJDyuCHitwQkI+2HKwNY6a?=
 =?us-ascii?Q?pO48bfp4VFd70W17k+lHhWw9PMJNhS9I4Aq1bCtdsgoHiTuJxL7bNuBn6nqb?=
 =?us-ascii?Q?nibdgGvBOjr8wupNrxDvqAgX1Go2lKlGIGRF+oRox0bJGHzbPAtrokVkckZe?=
 =?us-ascii?Q?qg5eQEGyvhF5raThgJHEZhwlEi9SzqpWCJtG10CGhDOPNJrcBQhdTJI8k5Lz?=
 =?us-ascii?Q?MwC3p9SrEWAG4RwFg70UImAbAujGvNdc6ZOO407BAyvVN9QRZizs/34MNsna?=
 =?us-ascii?Q?5eY2mLcA57mnn51cr4qhCbNKaY6Kg47HSnJkQCizLt6ndmFavz+K+QmueTqC?=
 =?us-ascii?Q?8+KGRzoFU0Z9ufEiK87d2SOC1ySqPjVLqDdaAEUOh5607eGsuF52LsZNNjid?=
 =?us-ascii?Q?u01wfrJzpIHsOMWtqprhb0zgBhsqbImWxlm+BUhtnTpE3f2iZUHrVEb+j/Yj?=
 =?us-ascii?Q?yXwRUw/OpsjGrJo/Whqjgq/Quxn/sMdpvoeb37bQaeX5dGuUIUicxyc2iDzg?=
 =?us-ascii?Q?QUHICpD80e04pqr3R4IRDssW0+kJT+m0x4LGxSWRbYBU8LZjkk/45CRDutZk?=
 =?us-ascii?Q?QInFFTnkX5nHi6zAofJFSMPjWSPJOUh9oBm4yo1eUS+1fy2j6thJg/rr+8vl?=
 =?us-ascii?Q?6xfp+vEdcJNgvCkl7o9+yWjWKrxWKNopLVZVkZDtFYtR+pc1H2EqI16zP8Ee?=
 =?us-ascii?Q?2wn91xcwe7RzBNY7bEoWwXIksSZF4eJQVj0DmnwKH2yLJZ/f+0RQKaStNJFk?=
 =?us-ascii?Q?dHwd7go6Xeladilz8lwWrdWr6bhCbDu/d4SuX7B2rq/hWkaOdvZ+94R6apjy?=
 =?us-ascii?Q?n6zfd4dorP6YjpD2zQLdgE/tLXEdyfKloVun1bdGxD4ezwyKB8/PEK1O5Bm9?=
 =?us-ascii?Q?WBrQ3J/t+GP6KwR4I66O0jSDRVIa2nOLFzbQ5yrACGFSkTEvpmEnQxK+Rpx7?=
 =?us-ascii?Q?0Pha/YyMO2L2lfzXxVbfCCt3JJ8CRmZErjavrQ03N2xGd8O9tHTX4mDoKKEF?=
 =?us-ascii?Q?55Gu0tEW1FkQOtk2faic2znamFRmBkfXX8RYWF+HjqRs2Pv6Py66wIDl+D/q?=
 =?us-ascii?Q?X7FAONLR11G6fgOg7Pp7eGBDDXqqqcaoq8aUfwovWgH01TfTBGv1T25noRTN?=
 =?us-ascii?Q?yP+MRjIT2Lnl1fhIxNBGpzi0GAufiMme7/hgToakC4ADa9yJ4xOF7NKcZ+9m?=
 =?us-ascii?Q?99zNZAj+uwwfMHJHeKAIrLGf/YpEFzbgJWnod/gjr0U2qZbice0ysHLmMGTE?=
 =?us-ascii?Q?dPBl1n9pgPCTibhuFFIHoLwQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5853.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bc999a5-f1c3-4776-0427-08d921adc54b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2021 07:54:07.0993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xh4EtGLSHreXvBRHxcET8Q1JylbGawLm2hONx8XBlalS1KTc0ALo9kj3n0Sc2BgdopzmGh18yWkBxizNlboWHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5504
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Zhen Lei:
Thanks.

> Subject: [PATCH 1/1] PCI: dwc/imx6: Remove redundant error printing in
> imx6_pcie_probe()
>=20
> When devm_ioremap_resource() fails, a clear enough error message will be
> printed by its subfunction __devm_ioremap_resource(). The error informati=
on
> contains the device name, failure cause, and possibly resource informatio=
n.
>=20
> Therefore, remove the error printing here to simplify code and reduce the
> binary size.
>=20
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Acked-by: Richard Zhu <hongxing.zhu@nxp.com>

Best Regards
Richard

> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> b/drivers/pci/controller/dwc/pci-imx6.c
> index 0cf1333c044032f..035fb622cafafcd 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1002,10 +1002,8 @@ static int imx6_pcie_probe(struct platform_device
> *pdev)
>  			return ret;
>  		}
>  		imx6_pcie->phy_base =3D devm_ioremap_resource(dev, &res);
> -		if (IS_ERR(imx6_pcie->phy_base)) {
> -			dev_err(dev, "Unable to map PCIe PHY\n");
> +		if (IS_ERR(imx6_pcie->phy_base))
>  			return PTR_ERR(imx6_pcie->phy_base);
> -		}
>  	}
>=20
>  	dbi_base =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> --
> 2.26.0.106.g9fadedd
>=20

