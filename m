Return-Path: <linux-pci+bounces-42355-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F938C969D3
	for <lists+linux-pci@lfdr.de>; Mon, 01 Dec 2025 11:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3BC33A24A9
	for <lists+linux-pci@lfdr.de>; Mon,  1 Dec 2025 10:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA873302CC6;
	Mon,  1 Dec 2025 10:19:34 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2101.outbound.protection.partner.outlook.cn [139.219.17.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311303019BF;
	Mon,  1 Dec 2025 10:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764584374; cv=fail; b=gTuQFt4xavQma3ibnEqiElcBcBrbZmml4pY/Ri/IMxyThiXEdovsy+1oFDe+5Q0ibwH2XcY5CfIOWqDGaU7AtKwEVpeV8BpuHPjtrelxtSgyYgTIgnZTOAA95s0mjZociHEHQ/fuod6DBR4mbId/iRvOTmZzyKmhoZwvVPmZs0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764584374; c=relaxed/simple;
	bh=qBQtX73rNnUGjKSdKjQEMpvQdrLyMWyo6Yv48F5hMLY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kzMlb+Rj8tdxFSup1c5Finv2LaOoUzMN1iQ4OMUmargLaR4X7VICSgDYA+87YefmWoES8HR/iooa00iibjr4Z8cAXChTM0dy4W1tuwcyhXpVfMJHmugdb3dTh5/lBXJmmtO25HQBukEwvSb2k0ktUOQT2FtWKCdjRhSHqpTFQIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YOIX7Bbf81aBE9egnYjcUovv4nsFGGAMPSoAgafUBVGldYqHobiG8qFUJbnbV0B0UUlhA6pYi+Oy6FvITEMCmeFIBGmAYMfMLMl/b+h9/EZKf8K+/ThAlTNNP9ox3mCpiiU1K6U3HwKLlRw4rapPlNP4/GaqxVd9qvQfJ20xLb18Kh3ZprTzwhZkGcEwzSpncCK+ZUCZRnH30NCExQipxPVJWoIm3yH5SjCJ3KL9LpMVR5aiYzp3aenzZOSs1SqRHd47/lENh6tBnoOCeZRciL8mIVAMp8wJ5vHotGVt6rQl08Cz2jecJwU5JKymHigt5CUvZtB8tS+9e8g4SdvLjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NXA3AGNyQwQenYzaQ29cGfb4Da98rvs/9NircOm28ho=;
 b=THU7trq70jLzqhxtggY09h/EAq2FcNSdyweHHaywko7pFX5xBroBhxJYTMkieCaPWA1wKkE1UPHfV/vNrtfAk6kvK+d6Pe8vWLJculYqrhemgakYwRqyYPaWgk7+tKIUM+lKJfL8zs3u2eXUfL+0fzUEIfSh2T2iX9CgidSiRPOz9Mx6Rt2YR+ASnvoZMpC/Y+ddUDgdwpfcB/zMHYulXBQRLeFH7YpvlmkHRM/mD2zShLv5bDeTxa4zwOmxGeHs42ThY9jryreuNFLZBSKvykLECGMfHfUYlkgPlCxxY06YNz89Q7fcwhKMED3AYrKe1V/wtKoB3bYdYfBnG0Y3Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1257.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:11::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.26; Mon, 1 Dec
 2025 06:45:15 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%4]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 06:45:15 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Palmer Dabbelt
	<palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>, Albert Ou
	<aou@eecs.berkeley.edu>, "Rafael J . Wysocki" <rafael@kernel.org>, Viresh
 Kumar <viresh.kumar@linaro.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kwilczynski@kernel.org>, Manivannan
 Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Emil Renner
 Berthing <emil.renner.berthing@canonical.com>, Heinrich Schuchardt
	<heinrich.schuchardt@canonical.com>, E Shattow <e@freeshell.de>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 1/6] PCI: starfive: Use regulator APIs instead of GPIO
 APIs to enable the 3V3 power supply of PCIe slots
Thread-Topic: [PATCH v4 1/6] PCI: starfive: Use regulator APIs instead of GPIO
 APIs to enable the 3V3 power supply of PCIe slots
Thread-Index: AQHcXeD4WDMn2zfogkuoU7yPusoik7UMXCgQ
Date: Mon, 1 Dec 2025 06:45:14 +0000
Message-ID:
 <ZQ2PR01MB13073F4D8A360402E3C55013E6DB2@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20251125075604.69370-1-hal.feng@starfivetech.com>
 <20251125075604.69370-2-hal.feng@starfivetech.com>
In-Reply-To: <20251125075604.69370-2-hal.feng@starfivetech.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1257:EE_
x-ms-office365-filtering-correlation-id: 3812b704-c8e9-4759-5c62-08de30a52f15
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|41320700013|7416014|366016|921020|38070700021;
x-microsoft-antispam-message-info:
 rvqV4wvlgJGTDXuQIrNTsHIdn7FVFx3k4O4c/l8iXQOXLGpUTWKRrj1SDqKwUqVb60QVeexvIU1d8/ENt6vI2P9W3rIugbpmPANL9YmbjLVMbw0GW0bhJE4X4LFHEidiFKOVpZCodJ/G+OhAR/BoSboeaodMIs8i6n1tQB9xGDZV2Lv7RLvgccHoAjYsWvRnTkBttr4yj4ubusyB2mje39NAWDPsFs3mTDveKloHJPiBYYvRcViw/2ij7dYp8b/pQop+/7upANWOz5kQqcS7fqAsZw9LRH2p/ev/kPfKOpGGKV+JvCycsKkZpnVAK8GBFJddWQ0hEYbEVonQ91oKK9Kpy9RlQrOJLnC5Yy5XcES9bERVOs9TS3XmFxU5GRFXVd1MzKIJAcJt0iQGLoSjWC4RmxTzUnxBpkgdhrZ/0vOnYjKo6HO806Bv8qa4zUdwAo81BBnqB4HZaYdvGlegZJl64PVac5xozP9eVYwDHeEozZB8mbuU0UxErnuXpq7fnmbVJo79uHAy1mWn+iVgLxLhXuJsDerff1GIwtLwCQeR3S4/OZcT6JMfbbr6WYMoAUIeez1sftfvAnYCMk8+ulfFq5yM/51xETRIarwWkAM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(41320700013)(7416014)(366016)(921020)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?Z+7anuIo9PHtsVsMv1k9bk1HfWN9yA4vgJk7bTEekglYocwtqRhRHGEc4M?=
 =?iso-8859-2?Q?Df81iJgaHo6CWH1rJOGcGvpNA1eaG0m+MtNqJmMA1cuA1HoapKfNVwzxNa?=
 =?iso-8859-2?Q?oklFB2gZ/r8ht4Sd/dhObxnfVEP9/wK9Wy+7NoW6Qr2uLwfm3dV8rd+y/C?=
 =?iso-8859-2?Q?EShRIbLYpXdMD4aBy7QfaduniylFmOnAlP+JfeZeqaXq3LdXjhxzxhmo5W?=
 =?iso-8859-2?Q?56qvC+3K/EFiMBJdR+SfPYPLwCcZQc6nXBHmUXBCmC5cIIUP4rBcuK8ErU?=
 =?iso-8859-2?Q?JTQh3UHxtyRN3dpq5sD8s8yLPxjmwRTsu34XeH53FIXj7frpcXHDXUmRwm?=
 =?iso-8859-2?Q?r4ysiveCrc9QQQlufha9n5W6+JZBgto6Nm9cZqkqhVD3viT636m0GBUb+R?=
 =?iso-8859-2?Q?RGNr/kQDDfH6p17g6Lf/pbwzz7BwirIwOYmtPlst37IPv2j8MuKBb6vdiX?=
 =?iso-8859-2?Q?ueQ7VHMan9uy4DarlFIUBAS7pR5WJ8JiCJxMcPWYkVPjBoF0GFdrmRCoFY?=
 =?iso-8859-2?Q?3OAMH8OsvVcEtZpWSgSibKRJfTnhEHNNH2HOch6IU6Gz/kj/UNl8WdLX8f?=
 =?iso-8859-2?Q?AypgIMDdNqFDe15lgAvVXSQGa7aiacWZDrybKwEktcbhev9AsWwysg8SKT?=
 =?iso-8859-2?Q?u+z7QuDyueq6PS9XHWGgPdpJIQoJVsV9xpOmT5MpRwdbwNEKRs3uy/kDA3?=
 =?iso-8859-2?Q?aYzLVo5X5cx0YA1IZh6qtkD5AOiqUlSJS9lQSjGkARmkvV52IpDjsuTRRR?=
 =?iso-8859-2?Q?yBPsO4MpWHzHNT5Nbx1O3pdhsWAGUOy9MUWE649+iZ9Q7e9GCHpodhSHSF?=
 =?iso-8859-2?Q?y/04WNrORY5YhE1SEaVMw1GTBUMcJ08hxV49P0IAGtGVg1iU8V5/lBucZb?=
 =?iso-8859-2?Q?GZAY/uktjC+QILC2hfFZE7SyHRYdK5Amx8I/k6rZLikk5GTTz12zKZK2Fb?=
 =?iso-8859-2?Q?7EaTP5MFl5YMYzGxNBjJBO12xFL/1TyswFoGMTNfOAdbAMyvXOr2BhMb2J?=
 =?iso-8859-2?Q?cFJuhFoDS+Av3+pZ6s2f4sAs8N7mZ0IKALHZh4ATJyXk3GfXduAXGcLvG3?=
 =?iso-8859-2?Q?6AqD/Hj30MwduiSa1VpdE3t3OL/CspypoZHE/MPO7rHsUUN+7gqa767azr?=
 =?iso-8859-2?Q?Ul8wFLtTWLaCpCJta63jdHSEAIVcHAkEbMbdafUlYENxXALxlTKIQmm96c?=
 =?iso-8859-2?Q?kLCoP/kgfH+nZ5aiIjeywqEDcK9VusPvTZvlFpOmQbv4QxcJhe5MvfwYAE?=
 =?iso-8859-2?Q?fh1zGqr8O/uoyzYPGqpfJ3Ylb2rZZYKJUYX/evcOWNBoWwqiznjvaSQTYE?=
 =?iso-8859-2?Q?fVTr+rE+EuIbqyU9VyT5Uq0xSu5aICgPJhcE0OWYaBbNjTdMTllC9cPohr?=
 =?iso-8859-2?Q?u2cmmikRxGuQtgYUI//DPeYPqwjWngwt+hFjJWyDIg51GRQSUPBzD9dY7Y?=
 =?iso-8859-2?Q?dTU8B5ErRXW0MGgb6hDLUczYJuuJwgaYkvTUuI2agRk3w5JDYTATJlFD/g?=
 =?iso-8859-2?Q?W45IcFz0aaXOLjA/P5xHaXZ/6oRRsrRyK3htQiMObPjFpMsbpwQXL/CQh5?=
 =?iso-8859-2?Q?j2olXSv3XGYEetmy0faOtEP9+goXha5o9nKXm5aMJ+iAbC5fkDUiHJkWRM?=
 =?iso-8859-2?Q?QKrio1opgLsFUHsVb6HauTlo7B9ghRBD6s?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 3812b704-c8e9-4759-5c62-08de30a52f15
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2025 06:45:15.0360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xRcDhN9OrRKh6Re8rrXKikXpHhgIe8bJgc1IVj6KgjQ8Iex4kwOYCTY2dZ547Lb59yANtFt8HqSsURfqaHoO9E1FlHEx4Kx+VOtufcDcLl8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1257

> On 25.11.25 15:56, Hal Feng wrote:=20
> The "enable-gpio" property is not documented in the dt-bindings and using
> GPIO APIs is not a standard method to enable or disable PCIe slot power, =
so
> use regulator APIs to replace them.
>=20
> Tested-by: Matthias Brugger <mbrugger@suse.com>
> Fixes: 39b91eb40c6a ("PCI: starfive: Add JH7110 PCIe controller")
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  drivers/pci/controller/plda/pcie-starfive.c | 25 ++++++++++++---------
>  1 file changed, 15 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/pci/controller/plda/pcie-starfive.c
> b/drivers/pci/controller/plda/pcie-starfive.c
> index 3caf53c6c082..298036c3e7f9 100644
> --- a/drivers/pci/controller/plda/pcie-starfive.c
> +++ b/drivers/pci/controller/plda/pcie-starfive.c
> @@ -55,7 +55,7 @@ struct starfive_jh7110_pcie {
>  	struct reset_control *resets;
>  	struct clk_bulk_data *clks;
>  	struct regmap *reg_syscon;
> -	struct gpio_desc *power_gpio;
> +	struct regulator *vpcie3v3;
>  	struct gpio_desc *reset_gpio;
>  	struct phy *phy;
>=20
> @@ -153,11 +153,13 @@ static int starfive_pcie_parse_dt(struct
> starfive_jh7110_pcie *pcie,
>  		return dev_err_probe(dev, PTR_ERR(pcie->reset_gpio),
>  				     "failed to get perst-gpio\n");
>=20
> -	pcie->power_gpio =3D devm_gpiod_get_optional(dev, "enable",
> -						   GPIOD_OUT_LOW);
> -	if (IS_ERR(pcie->power_gpio))
> -		return dev_err_probe(dev, PTR_ERR(pcie->power_gpio),
> -				     "failed to get power-gpio\n");
> +	pcie->vpcie3v3 =3D devm_regulator_get_optional(dev, "vpcie3v3");
> +	if (IS_ERR(pcie->vpcie3v3)) {
> +		if (PTR_ERR(pcie->vpcie3v3) !=3D -ENODEV)
> +			return dev_err_probe(dev, PTR_ERR(pcie->vpcie3v3),
> +					     "failed to get vpcie3v3
> regulator\n");
> +		pcie->vpcie3v3 =3D NULL;
> +	}
>=20
>  	return 0;
>  }
> @@ -270,8 +272,8 @@ static void starfive_pcie_host_deinit(struct
> plda_pcie_rp *plda)
>  		container_of(plda, struct starfive_jh7110_pcie, plda);
>=20
>  	starfive_pcie_clk_rst_deinit(pcie);
> -	if (pcie->power_gpio)
> -		gpiod_set_value_cansleep(pcie->power_gpio, 0);
> +	if (pcie->vpcie3v3)
> +		regulator_disable(pcie->vpcie3v3);
>  	starfive_pcie_disable_phy(pcie);
>  }
>=20
> @@ -304,8 +306,11 @@ static int starfive_pcie_host_init(struct plda_pcie_=
rp
> *plda)
>  	if (ret)
>  		return ret;
>=20
> -	if (pcie->power_gpio)
> -		gpiod_set_value_cansleep(pcie->power_gpio, 1);
> +	if (pcie->vpcie3v3) {
> +		ret =3D regulator_enable(pcie->vpcie3v3);
> +		if (ret)
> +			dev_err_probe(dev, ret, "failed to enable vpcie3v3
> regulator\n");
> +	}
>=20
>  	if (pcie->reset_gpio)
>  		gpiod_set_value_cansleep(pcie->reset_gpio, 1);

Hi, Manivannan and the other PCIe maintainers,

Could you please help review and merge this patch? Thanks.

Best regards,
Hal

