Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B943A36BFC5
	for <lists+linux-pci@lfdr.de>; Tue, 27 Apr 2021 09:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbhD0HIb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Apr 2021 03:08:31 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:6146 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229547AbhD0HIa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Apr 2021 03:08:30 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13R770Di023926;
        Tue, 27 Apr 2021 00:07:25 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by mx0b-0016f401.pphosted.com with ESMTP id 385tvvkby2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Apr 2021 00:07:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f8KY6h7F+7i6U0Y2JYBMC4VZrR1qFXyeYz8Iskc7ElBq4dSztQezeT9/MYrHb+9HjCeY4GWkvfpyni2hhAc/2TTUKXH9uwReYah7IHB1pNdG81Yi3YdQmn78WvRQpvVB5nYw9HtBMedVkHqF//2eUch6cScZ3ozlNG/sJbgbAH0hVbHRf+7+fwo7rdQmwlywOeBGRw3Zwp5MbAC+oTL9QSqsB/3b2c6j9f2Rit7/sCyBbC48IsL7rKhR6oD11bjlWo6n6QhnESvnAZ3z7yKvp8iFnNZp8K0DZsVAT4qAykCeGgbjtumHyrqlPPRF6KeoTZHck8VI0DpWwp4tsI/g0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S22nnT+5FpFE2zyYZ801HvBF2BL/foB/jy6MFrDLbLs=;
 b=mZm6F+MNd1/Xeq9NCyh14IYFeHSdXuTcKs03mgH5VfPO/jHxQh9oDo/JG1Vp9P3E5CgA2HOG3eTmo7T1Odjsv9kuqMtjBvVUuXIvpLUAjpL2c+gv1RL76epRnZBGVHO8HL6hiOA5uyz8n6IpxX8RUW6ri82S+XEV9LX4SHlJQgo5keFHswDRzv2hiVxTZ6xzqzDfj4uhM9b6uup3KANm++cxm2YiRUA/UJe20Au2+lcE7QrNKszK2Qz6k3TJsF501qBCboNGw19UrdKFV99JE2U1FBKNBGajavwo2Ethq97WhkMhZw8xOahxFoBpB530N+06q20Cda2jnfMRq3gg1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S22nnT+5FpFE2zyYZ801HvBF2BL/foB/jy6MFrDLbLs=;
 b=Kov5PiBPTBPomQZZYy1Yjw/nFAWlk3YVe6WP4XftIAKykkvZRYXZGVCRU8bsYOEFVCCfRCPxpKDLZO0Ek2fnlcHRjnakxbyHw5PRp/FCyXD5zBG6XNvgXy45enMPm6ieh4JeLJ3+SY8YLJgH1BoBq9zffd14BKmW/X73EUVsZ+c=
Received: from MW2PR18MB2217.namprd18.prod.outlook.com (2603:10b6:907:7::33)
 by CO6PR18MB4033.namprd18.prod.outlook.com (2603:10b6:5:34d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Tue, 27 Apr
 2021 07:07:21 +0000
Received: from MW2PR18MB2217.namprd18.prod.outlook.com
 ([fe80::3811:5dde:7523:bb7d]) by MW2PR18MB2217.namprd18.prod.outlook.com
 ([fe80::3811:5dde:7523:bb7d%3]) with mapi id 15.20.4065.027; Tue, 27 Apr 2021
 07:07:21 +0000
From:   Ben Peled <bpeled@marvell.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     "thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mw@semihalf.com" <mw@semihalf.com>,
        "jaz@semihalf.com" <jaz@semihalf.com>,
        Kostya Porotchkin <kostap@marvell.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Stefan Chulski <stefanc@marvell.com>,
        Ofer Heifetz <oferh@marvell.com>
Subject: =?Windows-1252?Q?RE:_[EXT]_Re:_[=94PATCH=94_2/5]_PCI:_armada8k:_Add_link-?=
 =?Windows-1252?Q?down_handle?=
Thread-Topic: =?Windows-1252?Q?[EXT]_Re:_[=94PATCH=94_2/5]_PCI:_armada8k:_Add_link-down?=
 =?Windows-1252?Q?_handle?=
Thread-Index: AQHXL7Dz+S99QhJ6zUeoX2ZX7SJU4aqz9+0AgBMS6gA=
Date:   Tue, 27 Apr 2021 07:07:20 +0000
Message-ID: <MW2PR18MB2217E007583257709A026553C2419@MW2PR18MB2217.namprd18.prod.outlook.com>
References: <1618241456-27200-1-git-send-email-bpeled@marvell.com>
        <1618241456-27200-3-git-send-email-bpeled@marvell.com>
 <20210414134240.000057b4@Huawei.com>
In-Reply-To: <20210414134240.000057b4@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: Huawei.com; dkim=none (message not signed)
 header.d=none;Huawei.com; dmarc=none action=none header.from=marvell.com;
x-originating-ip: [93.173.98.221]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e24b211a-36af-4655-980b-08d9094b19df
x-ms-traffictypediagnostic: CO6PR18MB4033:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO6PR18MB4033C187B85A9FA5175AE24FC2419@CO6PR18MB4033.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +Ol/7J/NMy5G7NI6CRuGK4DMZxDSmMtuxmwAhIGhHRIhPsC4SiLl+VgvGwQO64t1b9IG9cnCJ/KrUHlSIu8nD0INfZWqxlIyx5W/TcsQ/CEllUSJ68xfbdWoXTBUlDuPGqmM7jghGji5XB86SUMXn46x5lxIcI6Skv8hBEShIYmVNaidenkmbOXx4X2NYxJ2Si2lsPEZE6J4G8Q4mw70s2R8mjtVxiu6aRTSB2H9XBG6/dND3lZGAGMBf+45mc04D3ccQruMV6DCU2BmMpAlo4T9J3kndOFF6W1LLssGfjpwpcUuz5YJwVkTYdwYDwDh7SkokpvjT4xZ6U0uAa40YBXBIQa1JgqHOIuj1EoZl2r8/FA/9RD04HbZO2/89yu7BvVU0gHNWshbPThb1F20pC+vXoFQ5uqIwNrBzmQFvwvJmk6W+qzz4aldaypKtGLUz82DsXDr318YHlpLkFL6ITQ0XsGs1KeSH0hcvWfXyvWkxKU9Iv4aQJDHdWBsU+Jl2ndsdWvPGU3v4qbqyOu40SscmWQvgChK7T7m0dxWiXxfrjihMkIi+gvOjCkVRJ/bWTs4wrSsjxXHiWTSI9YE1/f0IgnWBaJxJ59xwix3tzeNbpah/J/0gmluQpTo64mvY/GiPTacM8LDlY93v0ZbpQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR18MB2217.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(478600001)(64756008)(122000001)(26005)(66556008)(316002)(76116006)(66446008)(71200400001)(7416002)(5660300002)(52536014)(107886003)(66476007)(54906003)(83380400001)(4326008)(8936002)(9686003)(7696005)(186003)(2906002)(6916009)(33656002)(55016002)(66946007)(38100700002)(6506007)(86362001)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?Windows-1252?Q?u8gRh1kI2TvDq6AY9axeKcGF7dXAwcOFPoRVyGtZ1FG4i2RLD71kzd0d?=
 =?Windows-1252?Q?shLG2nsZIXtpIgaXh5ivXTEg8Z54NyWSU7F43MfBZq6hyiKhRis2qy9N?=
 =?Windows-1252?Q?tADuOJQhxGF5hRa710xbvw1oNNncoWovZwvgjBF9pbTPZ+IDfnNDWgzd?=
 =?Windows-1252?Q?abTk9znHU8WJXVm1UZ2vLTlBz1vTJ3BTtNjv0ZPN6cuTq5TkxqlRoaR0?=
 =?Windows-1252?Q?Et5nXmAZ/NJJodcPwCnr6iUDridc4U7HtoK3wkdjpamjocgQnXDwX2vb?=
 =?Windows-1252?Q?UHgR2FKJQds3m04dib4XnFA6xLB2XnIpVqjTC7pZip7uwIrNSriUp2oV?=
 =?Windows-1252?Q?zJEe9Zxh4rmX6rGTSB4vtoGyLuElbr2cbco+Buut2pe8CiN7haILI32Y?=
 =?Windows-1252?Q?xpGUJGzyelsOluFXuYmnYRWo5kKb9+fDEo2dZflwtHW0zA79dejAP5Vl?=
 =?Windows-1252?Q?NGXWUwtCbNKmTjIM0n2Jxc1bq632i2oL2p8cSgcAQFgP9gMZ8zv1pxtO?=
 =?Windows-1252?Q?eIpN9DTPRssk91F0KkX2PxdeKokMeXySnScu3Tfd7jeruz6X2JVXKJ22?=
 =?Windows-1252?Q?vuCwqV04Lhpf1HRViqMd2qm07QWnd4crZfBSKMsqwH1tm4/n74Wvig9M?=
 =?Windows-1252?Q?AODGRjRqxO1xnucmRMSnnBs1uZN+dlql14+NRDRU8XtoQtyVI/zvFMNy?=
 =?Windows-1252?Q?MJxLpHAEVPuQp3DTithRkBa+J8QQN0Xl0q/bE3/Ws4CQxrNy7Ep55Lag?=
 =?Windows-1252?Q?KjrBwKmK7voHgMSzVKY6adCuNW1DlpGjkr5EU/YlV/7+IoKcOLQo42wb?=
 =?Windows-1252?Q?HH8IBzr1CX+Nc+1Mog22PMaXB9x9ddlEge2GudgBxDtdDy+cP3rQSTAC?=
 =?Windows-1252?Q?F2QJV0UAnoF9Iw3/R/YoMv1tTTcU7IrKW0XfflLxNkFE3IhtAsU7k/2H?=
 =?Windows-1252?Q?j+PcsBr7phfHAl2w+rqdIp/YBrIx1e0ebbPyljLQ1WyosbEn38Crgn4/?=
 =?Windows-1252?Q?ZWIt2iaJMAa7nU5G/LNQq/byLUtr55jYI8Kc2NJU/Do2zACvfWhFRZ13?=
 =?Windows-1252?Q?Xc6ofOQGgzr1bG8CVUaz+JZVF882eUgo+7lR/VvKmaosaIvjgwn1ArGc?=
 =?Windows-1252?Q?YC8R2mfidKY4E0x0bjL+A73LEx8OT+pl4YGdke4Qb/PttJIo97DHZ5H+?=
 =?Windows-1252?Q?UCSsd1De6bh6LZyGxfpxTMYroZ78iwtrdM+Et+iS0p5RQ84tQeqMY6VG?=
 =?Windows-1252?Q?OIF25FHn8IVdWwHDip6Ks1++afYuTpMgf0UzrdzkfK++mVwLkLD0OQA/?=
 =?Windows-1252?Q?wiNKky5ytOtS9N4ckb81BwPP+VcebZ6nyK4ucn0gykHX/M0SOb+W+tym?=
 =?Windows-1252?Q?tA3FP6UhYKs9XRJV9ZxB/iUpO3+gyqon6JnPfxmqD7Fu65cYRMOhGyB5?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR18MB2217.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e24b211a-36af-4655-980b-08d9094b19df
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2021 07:07:20.8328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VzrfKdW6jyvC0EHvztMWO5/xQa/RKxExR8KWvl/o28MvKhBdcyEAbaOu6ju+p0yDrIwOCOtIUF/p9+s2i/r7sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR18MB4033
X-Proofpoint-GUID: TQnYQ9MAHeyI7OKZ59zdyxRKsIEqvbrG
X-Proofpoint-ORIG-GUID: TQnYQ9MAHeyI7OKZ59zdyxRKsIEqvbrG
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-27_02:2021-04-27,2021-04-27 signatures=0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jonathan,


> > In PCIE ISR routine caused by RST_LINK_DOWN we schedule work to handle
> > the link-down procedure.
> > Link-down procedure will:
> > 1. Remove PCIe bus
> > 2. Reset the MAC
> > 3. Reconfigure link back up
> > 4. Rescan PCIe bus
> >
> > Signed-off-by: Ben Peled <bpeled@marvell.com>
>=20
> Trivial comment inline.
>=20
> Also, something odd with quotes around PATCH in the title you probably
> want to clean up.
>=20

I'll change the comment to more informative comments

> > ---
> >  drivers/pci/controller/dwc/pcie-armada8k.c | 68 ++++++++++++++++++++
> >  1 file changed, 68 insertions(+)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-armada8k.c
> > b/drivers/pci/controller/dwc/pcie-armada8k.c
> > index b2278b1..4eb8607 100644
> > --- a/drivers/pci/controller/dwc/pcie-armada8k.c
> > +++ b/drivers/pci/controller/dwc/pcie-armada8k.c
> > @@ -22,6 +22,8 @@
> >  #include <linux/resource.h>
> >  #include <linux/of_pci.h>
> >  #include <linux/of_irq.h>
> > +#include <linux/mfd/syscon.h>
> > +#include <linux/regmap.h>
> >
> >  #include "pcie-designware.h"
> >
> > @@ -33,6 +35,9 @@ struct armada8k_pcie {
> >  	struct clk *clk_reg;
> >  	struct phy *phy[ARMADA8K_PCIE_MAX_LANES];
> >  	unsigned int phy_count;
> > +	struct regmap *sysctrl_base;
> > +	u32 mac_rest_bitmask;
> > +	struct work_struct recover_link_work;
> >  };
> >
> >  #define PCIE_VENDOR_REGS_OFFSET		0x8000
> > @@ -73,6 +78,8 @@ struct armada8k_pcie {
> >  #define AX_USER_DOMAIN_MASK		0x3
> >  #define AX_USER_DOMAIN_SHIFT		4
> >
> > +#define UNIT_SOFT_RESET_CONFIG_REG	0x268
> > +
> >  #define to_armada8k_pcie(x)	dev_get_drvdata((x)->dev)
> >
> >  static void armada8k_pcie_disable_phys(struct armada8k_pcie *pcie) @@
> > -224,6 +231,49 @@ static int armada8k_pcie_host_init(struct pcie_port
> > *pp)
> >
> >  	return 0;
> >  }
> > +static void armada8k_pcie_recover_link(struct work_struct *ws) {
> > +	struct armada8k_pcie *pcie =3D container_of(ws, struct
> armada8k_pcie, recover_link_work);
> > +	struct pcie_port *pp =3D &pcie->pci->pp;
> > +	struct pci_bus *bus =3D pp->bridge->bus;
> > +	struct pci_dev *root_port;
> > +	int ret;
> > +
> > +	root_port =3D pci_get_slot(bus, 0);
> > +	if (!root_port) {
> > +		dev_err(pcie->pci->dev, "failed to get root port\n");
> > +		return;
> > +	}
> > +	pci_lock_rescan_remove();
> > +	pci_stop_and_remove_bus_device(root_port);
> > +	/*
> > +	 * Sleep needed to make sure all pcie transactions and access
> > +	 * are flushed before resetting the mac
> > +	 */
> > +	msleep(100);
> > +
> > +	/* Reset mac */
> > +	regmap_update_bits_base(pcie->sysctrl_base,
> UNIT_SOFT_RESET_CONFIG_REG,
> > +				pcie->mac_rest_bitmask, 0, NULL, false, true);
> > +	udelay(1);
> > +	regmap_update_bits_base(pcie->sysctrl_base,
> UNIT_SOFT_RESET_CONFIG_REG,
> > +				pcie->mac_rest_bitmask, pcie-
> >mac_rest_bitmask,
> > +				NULL, false, true);
> > +	udelay(1);
> > +	ret =3D armada8k_pcie_host_init(pp);
> > +	if (ret) {
> > +		dev_err(pcie->pci->dev, "failed to initialize host: %d\n", ret);
> > +		pci_unlock_rescan_remove();
> > +		pci_dev_put(root_port);
> > +		return;
> > +	}
> > +
> > +	bus =3D NULL;
> > +	while ((bus =3D pci_find_next_bus(bus)) !=3D NULL)
> > +		pci_rescan_bus(bus);
> > +	pci_unlock_rescan_remove();
> > +	pci_dev_put(root_port);
> > +}
> >
> >  static irqreturn_t armada8k_pcie_irq_handler(int irq, void *arg)  {
> > @@ -262,6 +312,9 @@ static irqreturn_t armada8k_pcie_irq_handler(int
> irq, void *arg)
> >  		 * initiate a link retrain. If link retrains were
> >  		 * possible, that is.
> >  		 */
> > +		if (pcie->sysctrl_base && pcie->mac_rest_bitmask)
> > +			schedule_work(&pcie->recover_link_work);
> > +
> >  		dev_dbg(pci->dev, "%s: link went down\n", __func__);
> >  	}
> >
> > @@ -330,6 +383,8 @@ static int armada8k_pcie_probe(struct
> > platform_device *pdev)
> >
> >  	pcie->pci =3D pci;
> >
> > +	INIT_WORK(&pcie->recover_link_work,
> armada8k_pcie_recover_link);
> > +
> >  	pcie->clk =3D devm_clk_get(dev, NULL);
> >  	if (IS_ERR(pcie->clk))
> >  		return PTR_ERR(pcie->clk);
> > @@ -357,6 +412,19 @@ static int armada8k_pcie_probe(struct
> platform_device *pdev)
> >  		goto fail_clkreg;
> >  	}
> >
> > +	pcie->sysctrl_base =3D syscon_regmap_lookup_by_phandle(pdev-
> >dev.of_node,
> > +						       "marvell,system-
> controller");
> > +	if (IS_ERR(pcie->sysctrl_base)) {
> > +		dev_warn(dev, "failed to find marvell,system-controller\n");
> > +		pcie->sysctrl_base =3D 0x0;
>=20
> =3D NULL; ?
>=20
I will change this to NULL in v3
> > +	}
> > +
> > +	ret =3D of_property_read_u32(pdev->dev.of_node, "marvell,mac-reset-
> bit-mask",
> > +				   &pcie->mac_rest_bitmask);
> > +	if (ret < 0) {
> > +		dev_warn(dev, "couldn't find mac reset bit mask: %d\n", ret);
> > +		pcie->mac_rest_bitmask =3D 0x0;
> > +	}
> >  	ret =3D armada8k_pcie_setup_phys(pcie);
> >  	if (ret)
> >  		goto fail_clkreg;

Thanks,
Ben



