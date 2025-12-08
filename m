Return-Path: <linux-pci+bounces-42789-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3243CCAE0F5
	for <lists+linux-pci@lfdr.de>; Mon, 08 Dec 2025 20:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03F4230A957C
	for <lists+linux-pci@lfdr.de>; Mon,  8 Dec 2025 19:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A5F20A5C4;
	Mon,  8 Dec 2025 19:20:53 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2096.outbound.protection.partner.outlook.cn [139.219.17.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E64A1F3BA2;
	Mon,  8 Dec 2025 19:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765221653; cv=fail; b=nZ+n+QbaDTLMD1acsu1mr/9Mr/uQ+X51UZnLtqSOiJA24v+nDDPAJ94Pdhfi7SiNjQr9ZSSdt/WNWmknMufqqzlapM2sfbUpnA3ITclEks81/Iq0OFIzB36bZ+uN9konS/aPO5LGy4HZsBSdgVw8Q2QY7vPCNCu24jNP34a/vw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765221653; c=relaxed/simple;
	bh=jATWi9rXvZ0cQ2V2zHz+ol25bdEwTe3ApXeDjyesgxs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D6XBwvfdlTgyrnM4Y7jbevHiLKzLS286gSD8jrR2UE2F85f5lBs7z2mv0Uyq1gtf8ebEMEjAE6ABz3aXms4yUdD7uCylkkxbNKwvceHAbqtbhsqLLThhDHRSqRMTCX7iNqxYQo9IxCjrAUo6Mty8sgbrtqS3W2gziD8EkYH8HM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GFSQHqr0m3ZtRziY4Xem1Mu9zLzFoqfLI7h2jJbCFETroxIybzjV/QfFQca4PxtfvdHpAXTjxfuyou4sqp6W/dUxcVLKNMnQSYpjHzPKWcw6ljQh2fdcHpAFWUKz5bHB4ROy0Dc04P7k8WuCeU55VJFSmWf29qCyMN0w3D3RJ5VSRwpT1JAGIi11x/PImkB+f73WtUMoACfvtyOVYEqQMBGAc/FgB1mgEKJQFXBisJY1t1DLgvSZZuKDWfj+LRHMI5/E5XoVLCWHp1AR5ybEtXlRXbqb5i9unhWI2SUpit0Bgp6BpHznaVAsuGV8C+t/NUG+5M9tI6GR/bVBD65S2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q1UiJ9mEm5EbYIaUMzHEoOzIxnu7gRcL/qN4HTtuDkg=;
 b=N9p1F/XvUTAyDTH+BCfXt2JLKf1kXyN1u7HzoRtkFmaQNKbE6dC5jNXbwipr81j5Lk9uoVEBYPdZ9gL45JNVQb+fo126MIy5PbPvLgc3R8qVNepTbG/bLtEdQY8FYMk9xfiaeeWNIyCCpoO3a99bIIQrjQpumVpuhL7HMvpJctRfFa+aT9kvOlIxLNwOqKW1ESJxSfdkFmbgzCsO9YGlpP0yiv4Ew9+A1SLrzSxXwTrRsjME08JByxjL6HyW9tzgj4g9R+TB4lnFGGxQpLEGUNoBg21GReR/OYgZ/8a0bVfwTK3gtUzChkZw5ComKWic56DYZKJ53v8xliIblfdTvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1292.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 13:47:43 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%4]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 13:47:43 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Kevin Xie <kevin.xie@starfivetech.com>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?=
	<kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Bjorn
 Helgaas <bhelgaas@google.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Emil Renner
 Berthing <emil.renner.berthing@canonical.com>, Heinrich Schuchardt
	<heinrich.schuchardt@canonical.com>, E Shattow <e@freeshell.de>, Bjorn
 Helgaas <helgaas@kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1] PCI: starfive: Use regulator APIs instead of GPIO APIs
 to control the 3V3 power supply of PCIe slots
Thread-Topic: [PATCH v1] PCI: starfive: Use regulator APIs instead of GPIO
 APIs to control the 3V3 power supply of PCIe slots
Thread-Index: AQHcZOo44Tf6DvT2HE6+dAB7NzR28bUXhI/Q
Date: Mon, 8 Dec 2025 13:47:43 +0000
Message-ID:
 <ZQ2PR01MB13076269AF954AF603B347D9E6A22@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20251204064956.118747-1-hal.feng@starfivetech.com>
In-Reply-To: <20251204064956.118747-1-hal.feng@starfivetech.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1292:EE_
x-ms-office365-filtering-correlation-id: 0a232aba-c11b-46c8-2de9-08de36605cc4
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|1800799024|921020|38070700021;
x-microsoft-antispam-message-info:
 2ffpMZaS5/MFpwGCrFL9jAZYFgofuJ6/LZGR3SYJ8mU6J3ewsf+35FAi9irVQksSlLnD6C8CU6iFaWINYiQhOJ8yme6IVg8SPdtkaBc0zdVG5E4EXxfGFsnq22fFs7/sZTR7E/HhMWAoMX7nw3xyQ6dSybL0UUu/wbwLYuQ62b7mGl1EkscunpzQoOy6kQYw6cdTMZBlCPs9NzPUaLQrmBMcn3Exuwi/eRSgA1h4Dg7/0N596/Mesl0E4yDWMA/rMXow+b6mg2gjq8m/kNjNHUdwJWj7gnM4dpPu5AjucfZyRz/ZT96ORJVggb5lPDmQQowiZgHRmJj6r2W92xVszr5W0d3Ml0oUt4/2Sc7sUUnTHpOobpljzCba1t6fqAEvshJtXH96kFAXfySKTBO1JQ+N1W+4cc4oN0t3RXh0MKNArYPhIRI0stwxERpW56BUavD6ggeSRDvF9vUVQvHV16qD0qqJzTaoa5hdT+wRR7HmgZFmYFVUgYAL9at84/eV837oJcqssuTxGaMIzmrGOvSA6th6XO/kNYGR7G04vRd921xHmq9C+XfFwjhqKXKvl76FeMUEoAr9j2A1ZSP8bzNlKqSX3r9LGXFxzzkU49s=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(921020)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?s7lrSp42wXFUrwgEBmPeHU66xF9uIE71t3Z2InJxxj/Imt6+pE/nTnIx8N?=
 =?iso-8859-2?Q?GEFzCdaSwW6U9LkB6mEJ8RBDSdr5nWOL+EzCmDSkAkgkMIdcXO7dqG5/AI?=
 =?iso-8859-2?Q?tfHvbuNWHK8EYJilnhtvdclxqhnlJp5LIci0l4z4mqgiCzaK0G1X/03DKj?=
 =?iso-8859-2?Q?LGJTIwsdpiEaaO18sKzdoSYr8aKaysJrfo5Xx1S4mVIrB0rtI9fdHPMr7r?=
 =?iso-8859-2?Q?9iT+DeBI9qmb1ysTPOyjbBJKM71wGzwoGuO/GTtd178RNPVH5tHK49Dq1o?=
 =?iso-8859-2?Q?CDpS/3nCvw6Z72bigxHl+J71VlKmBz8g/6+jBoZ9g0YMoXptpBX0CKpP2c?=
 =?iso-8859-2?Q?DxKsqR9IUVp2aso+6+t3iu5P3VKg+vGVuaCUxBbXUAeN8AIDKX8ZpWiHp8?=
 =?iso-8859-2?Q?eiKJvui/bH/t2JK/Kub0OsbAnySMtB7ctq1qXlW0beipbFrK6zyegwOs7A?=
 =?iso-8859-2?Q?PcTzgzgw8NAnAPRe06ud5/6ut+puZ4MOU+g5JZZRmO5RUrPcyOu4jJoSUO?=
 =?iso-8859-2?Q?jbekMH1ijUZOb1oaS+8L/0cjjtOSFanvfoiNUGLTKAQFSj1rWZmQbk8o7j?=
 =?iso-8859-2?Q?HUihwUJEwXtFV59+EPGt6BUJfXcUiPVJGdTZ3eiQpQKgd/LyLZQAd3M8u/?=
 =?iso-8859-2?Q?qUkw3dk/f+VRa/Uv3ZU2p7XS7wGYhPRaTld6FG0qFoYvtvjadoLTGQBo/C?=
 =?iso-8859-2?Q?1HfgIK5YxMb66psTj3yGT8Y6YYr1PReDzJBoYUhF5qWokIylvCCC/fBEDT?=
 =?iso-8859-2?Q?kW5y7b5LV3Fsfl+FJSVcTk+4q9c3DbGMJ+cD/yb84MkTpEbDtwazSDsQjj?=
 =?iso-8859-2?Q?1iiNdfO/C4Qg0Qvm1iI9nR2cIEZ4SQ2163RLpb3FxS/klHnrqbJKj7vfyO?=
 =?iso-8859-2?Q?fqaWqIYlV5YLCHmgOqlf5kYTur6k8HSk+HOSk40/PgQW9nEzuX91LaEHDk?=
 =?iso-8859-2?Q?wUX3qi5Bh3ulL0TjrB2YTr8vI3rIZD6hFSCYhsfYS+TmS9Tg5nFrxS3lnr?=
 =?iso-8859-2?Q?vXdLrWgxUemjjkU3J05icPEOYU458NT1sGYJhc1uHMZT4hhUkBxH9uAAyx?=
 =?iso-8859-2?Q?PfBJxuzX0LQJZ+Y1nQWhs0SCndpBtkierSP/UwKVr4ksGs4oemAQgaajZq?=
 =?iso-8859-2?Q?FcezC30Dd1KiJqfJmXUvrtvXpw6K00GtqxoyTDzXRcdbgIfaxbdJ4Bo76A?=
 =?iso-8859-2?Q?x7J+ITR6Jmt1Pjebd4TOF7pjW7PaIiYGQ6gybBYJP6LIKF+BKzXSV+qSKL?=
 =?iso-8859-2?Q?Gof+movxknSJ6i8JEhNCnEQIKi2dKyKYnHiiz3islCyDItaDEmYX47wh+u?=
 =?iso-8859-2?Q?ivsXtkOrHF83akYKGyNXZDggK+AHguPcCEFGcuCpeRrZvJhE0ER8CxUmTZ?=
 =?iso-8859-2?Q?xdpmQ/2K8i2RHWUrVi41qmyysggitXIoRh9T2GQcY+dFut0AZ/314KlSz3?=
 =?iso-8859-2?Q?cMFvjC1liJEeoUIWr7o+/DGqSInn3WzdGk0NZKUYKxkc+9LgVqmvogeXA9?=
 =?iso-8859-2?Q?+YgR+S1Wc8tzm5aj85/srI0phbiKZW+MhxNEVnx1QNXQTZbXpU/RQ57bBC?=
 =?iso-8859-2?Q?F8O4832aVOpcn/nczc3Es2aclSpf8o2n+F5Oz3pf5ebBmHwepejI1Fqaek?=
 =?iso-8859-2?Q?41+xmA3J9mNFCCe5J2GDk4MUKElOomFael?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a232aba-c11b-46c8-2de9-08de36605cc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2025 13:47:43.4069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dPjsaSZ3xH/1oZs4DWpUUebozDSnKi9161P7yAxE7oMkS2E7mR23NwZQaGyxsOMvpS9ph9mbSND2zd5v5QAn8GWFxQ4kO6vfWaJ6rnpxGGI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1292

> On 04.12.25 14:50, Hal Feng wrote:
> The "enable-gpio" property is obtained to control the 3V3 power supply of
> PCIe slots but it is not documented in the dt-bindings and using GPIO API=
s is
> not a standard method to control PCIe slot power, so use "vpcie3v3-supply=
"
> property and regulator APIs to replace them.
>=20
> This change will break the DTs which add "enable-gpio" or "enable-gpios"
> property under the node with compatible "starfive,jh7110-pcie".
> Fortunately, there are no such DTs in the upstream mainline, so this chan=
ge
> has no impact on the upstream mainline.
> If you have used "enable-gpio" or "enable-gpios" property in your
> downstream DTs, please update it with "vpcie3v3-supply" after applying th=
is
> commit.
>=20
> Acked-by: Kevin Xie <kevin.xie@starfivetech.com>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>

Hi, Bjorn, Manivannan and the other PCI maintainers,

Could you please pick up this patch for the coming v6.19rc? So the VisionFi=
ve 2 Lite board
can be fully supported in v6.19. If anything needed to change, please let m=
e know and I am
willing to send v2 in time. Thanks.

Best regards,
Hal

> ---
>=20
> This patch is derived from the reply of Manivannan [1].
> And the previous version is [2].
>=20
> Changes since [2]:
> - Improve the commit messages. Add description to explain the impact of
>   this patch.
> - Remove the Fixes tag and the Tested-by tag.
>=20
> [1]
> https://lore.kernel.org/all/xxswzi4v6gpuqbe3cczj2yjmprhvln26fl5ligsp5vkio=
g
> rnwk@hpifxivaps6j/
> [2] https://lore.kernel.org/all/20251125075604.69370-2-
> hal.feng@starfivetech.com/
>=20
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
>=20
> base-commit: b2c27842ba853508b0da00187a7508eb3a96c8f7
> --
> 2.43.2


