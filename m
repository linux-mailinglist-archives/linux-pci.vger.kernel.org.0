Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFA81F1129
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jun 2020 03:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbgFHBtJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 7 Jun 2020 21:49:09 -0400
Received: from mail-eopbgr1310098.outbound.protection.outlook.com ([40.107.131.98]:2117
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728106AbgFHBtJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 7 Jun 2020 21:49:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ObHdg+ERru0vw/uy3WZg+6d9Yx2mYd9w58GdjvE4jcCwJMKNrt5iuQrpUJz396aOisDZPTd3nqTxXPNQn82/wp4hkgY6ETwXMQucOaXrUFPafV7gP/IDKyTWyFIcoZ1XuZA7jFobey7rJvYBERJ15IGf3hAnXuaRqxmtDet57jnW3cei9FZ0bw+eSXhX1G7sgauV9pOpFb0A3Aw46TfT5puZ98OryGsru4Ef4PIPyYydj1J9q7NPWgxfqVQEyYvnCj05fuIiljnRs4DX3TDa5mvAYaibJVu9DB7fzM2BEPJdfkRX/C3BAZ+y1zeogbcbsZ8VlEg630ol8PB3qQ3wyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XaGzB4IfuEA47m+wIkfxPqgtDStoBtC8hqFWlrsge0=;
 b=Br08GEKbBB4HTpU4d9Lnprkg4G8evuaEyhMi3inhw35ghVFfqpKDyKy/nfw0/R+xDcw4jxU3PNh5nRjaQV1nWbG5txW6lALiH4q7lZHAKayjoTOsMMZ8t5wfnY3AAxKLtWQQYSvapDKCINb9fWiM+SYqZOAY79t2dhwQi1hz0bfV1To0SBZWh49id0ZhYEjji5Vgb13FZIcoFrP7dxcfE4OQj/hiT9IIuA5mIFSB5rhEEf9XG7o08sULaFjrFIBiU1t4WNixK4Z2bg3tokOLPG2nZaMstHzpTDlzaIutToqLVBjppKEaAliMDcYRXXpmmTP9fmKiuPRAH1br/AFaaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XaGzB4IfuEA47m+wIkfxPqgtDStoBtC8hqFWlrsge0=;
 b=ar+tXOUHX4pV/KW4yLbSEEuXOfTp5FsS91nYZE1zj2+RdiryJdD4s1iSVFLgg8P+v/2XJNY54sQGNOMV6T9Y9TWSmL0mNDfKIivA7SizG35plIn4ku1/NstvbBU6V+Tk1yohYiPrF2sUtTAbVO/k6UxxiYUp3MfSZF28utAQHd4=
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com (2603:1096:404:d5::22)
 by TY2PR01MB2890.jpnprd01.prod.outlook.com (2603:1096:404:7a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.23; Mon, 8 Jun
 2020 01:49:04 +0000
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::2da1:bdb7:9089:7f43]) by TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::2da1:bdb7:9089:7f43%3]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 01:49:04 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>, "kjlu@umn.edu" <kjlu@umn.edu>
CC:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] [v2] PCI: rcar: Fix runtime PM imbalance on error
Thread-Topic: [PATCH] [v2] PCI: rcar: Fix runtime PM imbalance on error
Thread-Index: AQHWPK55A5hD61SJZES1zQODpY1sK6jN8Qxw
Date:   Mon, 8 Jun 2020 01:49:04 +0000
Message-ID: <TY2PR01MB36925A93AA081BF478CA8DB8D8850@TY2PR01MB3692.jpnprd01.prod.outlook.com>
References: <20200607093134.6393-1-dinghao.liu@zju.edu.cn>
In-Reply-To: <20200607093134.6393-1-dinghao.liu@zju.edu.cn>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: zju.edu.cn; dkim=none (message not signed)
 header.d=none;zju.edu.cn; dmarc=none action=none header.from=renesas.com;
x-originating-ip: [124.210.22.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 230b62a2-aea0-4105-ec5e-08d80b4e1fe7
x-ms-traffictypediagnostic: TY2PR01MB2890:
x-microsoft-antispam-prvs: <TY2PR01MB28907402AE1CB312F2BC66B6D8850@TY2PR01MB2890.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1169;
x-forefront-prvs: 042857DBB5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hN8yQa8fTqZoZPXhIKJMiI6X/p2OVeVpQftq3Eh2ndMhgqla0z45/EDOlQstxAhD2oF7zTB9WW0VtVfThN/3n5UUU03GleSinI3t57AKUYWD7xablkbGw9WeibxNHNF/2c1bK/SHBdh636jSp1lPPVRZA6jNtk9+BsRkPxFdrLzg3rA96LE/oTeQgqUuRNMWjzeXIi0LMlaQ2RUl3ZWc/Sea8kgcQSPjtRA+kQYiCdhqyxFzYJihFz/x9TKl0ENNcHg2QPugXuVQ58bfAcr4nrErBhQUHnYMaxnANfI56aZV9rR9mViDN3aIMEwifeqBNaDvXCHW3O2t2wokdOBPoA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3692.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(55016002)(8676002)(9686003)(478600001)(86362001)(2906002)(8936002)(7696005)(110136005)(54906003)(76116006)(316002)(64756008)(71200400001)(66446008)(66556008)(4326008)(66946007)(66476007)(26005)(6506007)(55236004)(52536014)(186003)(33656002)(5660300002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Zb4fCDlCE1W/l2E9Ys6ryqL+dTuOPKvnpe6Zu3BtZZw3pkfcJ4ak7gdtvcUNeZNlU8g6kwiKF4qkKeSj8uHVnsJVB8Il5UP1Pcvjht8bliTdWk1CgIP3bLofMbHkBBwZ92bzWrCV7m4DA+X4DM4HfYJQikFMohyzgK9A9gGb7mZK6xxHK5wEFCqIdD7LtJ26qItx/flwJAPnyFg8l1WoPwt+B7eDL5SlmIIU7+6rvJaDS2dQ4ZKoM/qqMcf6bnoPeqTmFbdy4EPiVpqEFsjscgaqwYAF+Oh8gwUYdyYCmFfJBSQmlX1dy/+5O9/b3ZL9spUXKii4o/ZojRqk4WnhLrQf00/Iq1mxcwqAQatRsInZ8q5C6kzBQ2sJMFGF/gESTqYpzb1hlK81kx46H5bj/cWW9LYE4zVNGMe5RtyoW2q8nXpO88U+0zGJPlL9oCilhh4uReSzHOhyx9wKwnH8i2p0EZb30o++KJ3Zu4nB0UdMt0rzulFWoeTae6eLTKAr
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 230b62a2-aea0-4105-ec5e-08d80b4e1fe7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2020 01:49:04.2213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t9wKaMo0zDUJ+LUox5ur1AkNa9trQRVxx2/nGmg9h2AOwgtz6IpXlxF8858E0JbHiDZ0tXBu+zYsFo50jk9Z2G+sSw0azbM0NtCT2x8pJxD5j/avPvVzWFisQ0qoteWl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2890
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Dinghao,

> From: Dinghao Liu, Sent: Sunday, June 7, 2020 6:32 PM
>=20
> pm_runtime_get_sync() increments the runtime PM usage counter even
> the call returns an error code. Thus a corresponding decrement is
> needed on the error handling path to keep the counter balanced.
>=20
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>

Thank you for your patch! I think we can add Fixes tag like below.

Fixes: 0df6150e7ceb ("PCI: rcar: Use runtime PM to control controller clock=
")

And, I reviewed this patch. So,

Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda

> ---
>=20
> Changelog:
>=20
> v2: - Remove unnecessary 'err_pm_put' label.
>       Refine commit message.
> ---
>  drivers/pci/controller/pcie-rcar.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/=
pcie-rcar.c
> index 759c6542c5c8..f9595ab54bc4 100644
> --- a/drivers/pci/controller/pcie-rcar.c
> +++ b/drivers/pci/controller/pcie-rcar.c
> @@ -1143,7 +1143,7 @@ static int rcar_pcie_probe(struct platform_device *=
pdev)
>  	err =3D rcar_pcie_get_resources(pcie);
>  	if (err < 0) {
>  		dev_err(dev, "failed to request resources: %d\n", err);
> -		goto err_pm_put;
> +		goto err_pm_disable;
>  	}
>=20
>  	err =3D clk_prepare_enable(pcie->bus_clk);
> @@ -1206,10 +1206,8 @@ static int rcar_pcie_probe(struct platform_device =
*pdev)
>  	irq_dispose_mapping(pcie->msi.irq2);
>  	irq_dispose_mapping(pcie->msi.irq1);
>=20
> -err_pm_put:
> -	pm_runtime_put(dev);
> -
>  err_pm_disable:
> +	pm_runtime_put(dev);
>  	pm_runtime_disable(dev);
>  	pci_free_resource_list(&pcie->resources);
>=20
> --
> 2.17.1

