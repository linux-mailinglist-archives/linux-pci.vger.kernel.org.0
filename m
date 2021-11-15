Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D71A544FEFC
	for <lists+linux-pci@lfdr.de>; Mon, 15 Nov 2021 08:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhKOHII (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Nov 2021 02:08:08 -0500
Received: from mail-db8eur05on2066.outbound.protection.outlook.com ([40.107.20.66]:50560
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229591AbhKOHIF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 Nov 2021 02:08:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WGV0d8AMLzuRREnAFTwNlDpQgIJ+ci84qB1557gNq4bEzXIkUA4SI6B3MKBaTee+8Pn6qQIOiD7Xkb03WT3+NEl4OsBvBHaTw2WWHJ8ttlD5C6YMKVv2sX9j4+zJl7beqyATXFRApU864/fENxWzcaoi7PAAa6PaqUmEBW7c4GlQGlQwwGWodz3UO8LW1UZfZGQykpQjSkvikPe/iQXy8e3uIphpv5jO3SnJ/WSG9jBNyQv7uZwptWSFCT90PmybXo+55Fa9vA3LZi5vszcke01Cs1IGYWnJB6Y1Rlm7WFIExC26Hhq4oCmucuIbvvhv8tikOJZ+JFB0VSBGQ6QliA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L5fMKqpr+fc9u1ImE4yRBclI7fdtK+1eaYBJFrsGzLk=;
 b=oEVjDu90UxBeAqi7j1Xczj92iz4CL7mk0F164LdUx8/8V0SM/8Sho+cef4fv1Sw7cVu9zGmlB8qlBS1B7QGeIYvDXqwwBTGjz5uRHmSPsVGwlMc4YDeh+3E5YJl4hnbCLmQM51jYQNpTh8c4jOxpkYaUq5xgaL8jVktIqRmirvAwhCRkJFKtjbsr8Pnd1fJ+0oBKAf9ZH6CziZtZUvlrgdnA8aDi0RKQe0WYRZHuGwQmmlTtYJPzyD8HDFiouVFAh4Y0WeHF3Im9Uloh0Zg4J7CVmMKmL0OUZDA+EPHPbmTw6SV8UAlr+lyoYRSIePrLs6D9Rv5uL+DKYGQVe6BVEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5fMKqpr+fc9u1ImE4yRBclI7fdtK+1eaYBJFrsGzLk=;
 b=nwBXSX8298XcAauYHTGuvPYfz2Obbr4YlCSoPY0P+7TDHrsR+LDnEBwGLuwuZDSZtHbrcKXlJoW28HNtvNIIezJJFNFJM/NSxO8Qj57gvBw7BD11eNXiQD7dhMFdKBZbJ0tRxSCt90z6Pu4r69vtJmfgFbkEI9jn2ijB1/N0juc=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8610.eurprd04.prod.outlook.com (2603:10a6:20b:425::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15; Mon, 15 Nov
 2021 07:05:08 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc%5]) with mapi id 15.20.4690.027; Mon, 15 Nov 2021
 07:05:08 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [PATCH v4 3/6] PCI: imx6: PCI: imx6: Move imx6_pcie_clk_disable()
 earlier
Thread-Topic: [PATCH v4 3/6] PCI: imx6: PCI: imx6: Move
 imx6_pcie_clk_disable() earlier
Thread-Index: AQHXzuveptb+S1eXbUOKBNhXPiTXJKwEQAcw
Date:   Mon, 15 Nov 2021 07:05:08 +0000
Message-ID: <AS8PR04MB867629EA8ACE2F9FD8C755FB8C989@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1635747478-25562-1-git-send-email-hongxing.zhu@nxp.com>
 <1635747478-25562-4-git-send-email-hongxing.zhu@nxp.com>
In-Reply-To: <1635747478-25562-4-git-send-email-hongxing.zhu@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6636af56-47e6-4bf0-9050-08d9a8064251
x-ms-traffictypediagnostic: AS8PR04MB8610:
x-microsoft-antispam-prvs: <AS8PR04MB8610E5899F21435DDBA39F218C989@AS8PR04MB8610.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g6KUcEGmV5zQawkB4tOuY/Y91NHgP/lKB8VhpsmUlUEoW0QM8QfjCjUDGy40xHrWGryXb8LvJHA+TjajchgmRVGh+7ZoQhOiPHzXziTSA6nScF6Ex7jz6VL4ez3EaayWBoyEPvfB8rkoach7SRAeWPrptostuyn4URjNVY2hmy39RGyivdL0q0rEg6EvbhPlUOl8jBDTi9k3tlgAjeolPI1j2BN7CRVQi5R2Uun6OvmE4ZTP8LyvmjXzls7MVxgBXjRQ1a1BmofjfkBcE8PTwZjDp5IVOGDV01LFIGPX5DJZc0TgU5TDUHsOWNk0vz3FaVbtlp7ELK7J9qBBQAOymfUMFgGobsVQ9Q2doy3fHbSPMbv3vCehiSnnLTJU1evE59YwpPrrPXkydgZ54cTosZypkcwBgGxl6RdViD6V0EYjCKV2qxcYQeGHWKDdgwsvFMA8zXPC4Jqtg3PurvaGLNTQCOiNoeMSR4wifvWfZpLusqDURXvHTaZAGqRk2g37SpCfVLO0RrSbSyT6mZ6mchpOb+2V+ph/F677faB9nIwR/6CLZj3jUPZV93iU2VTJOC35k0AouNXh3HN+eJABjheSAHrFNVHuUo5FH8vQziZqTd7NiCAZMpZcm3vzYm6vPyaWNIZnQPxDRicFO0l+e9GfJsJ1AWHD6lfy7H4VInA7IJpsNVlvtPfY/ZkXjNKYpfQxFfK9BuO7SRvcMBFRaA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(84040400005)(8676002)(83380400001)(8936002)(186003)(508600001)(26005)(66476007)(55016002)(9686003)(52536014)(86362001)(316002)(7696005)(2906002)(6506007)(53546011)(71200400001)(33656002)(122000001)(38100700002)(5660300002)(38070700005)(66946007)(44832011)(54906003)(110136005)(76116006)(66556008)(66446008)(4326008)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8bPRBgxmuwcK3QM+O8EH7vFlk9Sk08WoqGMGdAlVRZtf3VWNuCuxMfo6eisn?=
 =?us-ascii?Q?vqQEBqo3nUx/e18teTHOx5oI7EWmylUd3IQEo2Yqq1jm+wdq/Qvs04EjZtnF?=
 =?us-ascii?Q?tGufUjLh6ZsWRgk5Y1RYFDhvuhXYKyxEISXFR1CBhMDXe0kT1PYLS74DUOT6?=
 =?us-ascii?Q?//1svBHiHy0kYUp4gWArjANvT9fkgeyYhsMbdAChmr2LqdeTYaFiobQcMiEf?=
 =?us-ascii?Q?/K4z+0I7ct1TeUcRbJCnaC7bgNCJhqprZpHBddVI0yuHBBPIGPbxlfXrNt8J?=
 =?us-ascii?Q?AH9bA8iNRz4zJqZAIBVkBzdhI9CcWp2kqiQhYlJ3G4G+30+IG/9oZAWotKoW?=
 =?us-ascii?Q?YIwDqElmiIJatkmrVfXhhf4o3dtiexsFCXp8AmMCWv/rsw/a1jLx9WIu5My9?=
 =?us-ascii?Q?IzGw2qsqi0wahJQ3yO79FRu3LyBmOcSVJxUV1A1xhlOO4aLSaYRXxvlBBRgE?=
 =?us-ascii?Q?qJtNbFmBKbGoPgN3zc/xEff49sp0kDxUKL8mnFl8/C4RjLUlKQ4qvG/54IXx?=
 =?us-ascii?Q?HXPuNUh7B15agPdMRVuD64XzQ2DJ0YG1bx1MDBnJ/k2R4sDLY8APzm1U4iuU?=
 =?us-ascii?Q?8aj6UB/ES+tkPs6PMPO+vy8diA1R7pqMH/DrkjGe6pwLkZb0b25gxq/j1ex/?=
 =?us-ascii?Q?5rx4NrRd8i5lUV7oolq8gtsxd2LBL/0gHzistf90P6/jmu3kG/wLW7V1obuN?=
 =?us-ascii?Q?4UTqSU2xsxGz/bljAKh6ew2PrcPddg4K5aFgnACVspph5Xhd8CaAKfsqO/Ig?=
 =?us-ascii?Q?joZEdU6IolxMD2oC1YMyeSDMjij7gLaBLHWHbWgjid/8xZt6urJm1RwWO+tD?=
 =?us-ascii?Q?YdZM0JujrNK/j4+pc7T2Tc9dS02piWxht6IEb7yKAKAK3Oi7GoNigIdvKnIr?=
 =?us-ascii?Q?wz4sZnXV3Kgw23WK7ZVvYQoYQGJnGGc6Jxrux/JmdmJ63mVlP6zapxN2kRn2?=
 =?us-ascii?Q?qSFHMTHMfQoZloUyy6Uil7jqpdqgogLuF88nTKrYgp6efubp4A53MehGUGxp?=
 =?us-ascii?Q?ryZhyeu91hhoCt/XlNNRp01OmEEMjDHtOZmGotTT+A8IyXCG2hOpxBFGxtvC?=
 =?us-ascii?Q?1z40UpZjKKZq2avctsp7GjORjb5zIrPWVRzmXDnyX7PLnwtYk8zGRMKR1QXA?=
 =?us-ascii?Q?FKL6IveBi1TpChLODIblSRqAjYrAAaMNMU37PpgPtYHQG7TldjqsMdGjvdX2?=
 =?us-ascii?Q?vnZZg4xHopWm/DWqj3myzwxBHkwk56OHFb63ap7dsxgbF0ZIbg+BAfaLxo5P?=
 =?us-ascii?Q?OzYioJ94Qnwo8D/YNmun2iHoGIbs6LksJjYX8xtOen8NsdRnTjsN6nqZlDT5?=
 =?us-ascii?Q?JEEgsjsd16fCY5k8+DmDwqjb2zoLpCMncv8d6TRGjIxldb8q1oXXbVtp4XGU?=
 =?us-ascii?Q?EYd6orzImGFBjv7zGpNnm4eCH+Qk9kHzlggJ4R9LSdE9HY2dwxk8o5nYavUB?=
 =?us-ascii?Q?xDbB8qZRdPTfMveJ0pK+PsDEdHY+nZBv0lhzWbyOjemfE5d1nmz5uVuUlmFZ?=
 =?us-ascii?Q?UKa/y+AtkeunO6ReeljOOgPco4tx7ie5vgA/hNcRHd8t8fPXbOC/JIGwEsnd?=
 =?us-ascii?Q?ofQDRCgm7S6Kj4nBHYJ/z+9pQyKTb8p49huZlldnvw4UqW/0arzmVWO7IeNv?=
 =?us-ascii?Q?aQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6636af56-47e6-4bf0-9050-08d9a8064251
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2021 07:05:08.4233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: igONZ/R9LMZ66Yoj8/pu3U2vyO+WKUbtPdrMAXWKmsqMK14zXlLjItscyx8Yz90q5w/JkUc4oQl5+gzWZkswiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8610
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lucas:
Can you help to take a look at this v4 series, and give your ack for other =
4 patches of this patch-set if you're fine with them?
Thus, I can ping Lorenzo to help merge the v4 set firstly before the merger=
 of the i.MX8MM PCIe support patches.
Thanks in advanced.

Best Regards
Richard Zhu

> -----Original Message-----
> From: Richard Zhu <hongxing.zhu@nxp.com>
> Sent: Monday, November 1, 2021 2:18 PM
> To: l.stach@pengutronix.de; bhelgaas@google.com; broonie@kernel.org;
> lorenzo.pieralisi@arm.com; jingoohan1@gmail.com
> Cc: linux-pci@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> kernel@pengutronix.de; Richard Zhu <hongxing.zhu@nxp.com>
> Subject: [PATCH v4 3/6] PCI: imx6: PCI: imx6: Move
> imx6_pcie_clk_disable() earlier
>=20
> Just move the imx6_pcie_clk_disable() to an earlier place without
> function changes, since it wouldn't be only used in
> imx6_pcie_suspend_noirq() later.
>=20
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 46 +++++++++++++--------------
>  1 file changed, 23 insertions(+), 23 deletions(-)
>=20
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> b/drivers/pci/controller/dwc/pci-imx6.c
> index 65a10b048a8b..11265c5e5782 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -514,6 +514,29 @@ static int imx6_pcie_clk_enable(struct
> imx6_pcie *imx6_pcie)
>  	return ret;
>  }
>=20
> +static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie) {
> +	clk_disable_unprepare(imx6_pcie->pcie);
> +	clk_disable_unprepare(imx6_pcie->pcie_phy);
> +	clk_disable_unprepare(imx6_pcie->pcie_bus);
> +
> +	switch (imx6_pcie->drvdata->variant) {
> +	case IMX6SX:
> +		clk_disable_unprepare(imx6_pcie->pcie_inbound_axi);
> +		break;
> +	case IMX7D:
> +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> +				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
> +				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
> +		break;
> +	case IMX8MQ:
> +		clk_disable_unprepare(imx6_pcie->pcie_aux);
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
>  static void imx7d_pcie_wait_for_phy_pll_lock(struct imx6_pcie
> *imx6_pcie)  {
>  	u32 val;
> @@ -940,29 +963,6 @@ static void imx6_pcie_pm_turnoff(struct
> imx6_pcie *imx6_pcie)
>  	usleep_range(1000, 10000);
>  }
>=20
> -static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie) -{
> -	clk_disable_unprepare(imx6_pcie->pcie);
> -	clk_disable_unprepare(imx6_pcie->pcie_phy);
> -	clk_disable_unprepare(imx6_pcie->pcie_bus);
> -
> -	switch (imx6_pcie->drvdata->variant) {
> -	case IMX6SX:
> -		clk_disable_unprepare(imx6_pcie->pcie_inbound_axi);
> -		break;
> -	case IMX7D:
> -		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> -				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
> -				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
> -		break;
> -	case IMX8MQ:
> -		clk_disable_unprepare(imx6_pcie->pcie_aux);
> -		break;
> -	default:
> -		break;
> -	}
> -}
> -
>  static int imx6_pcie_suspend_noirq(struct device *dev)  {
>  	struct imx6_pcie *imx6_pcie =3D dev_get_drvdata(dev);
> --
> 2.25.1

