Return-Path: <linux-pci+bounces-25366-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0F5A7D9DB
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 11:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B453E188D4E5
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 09:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02450227BA5;
	Mon,  7 Apr 2025 09:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Jhu1QqBK"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012062.outbound.protection.outlook.com [52.101.71.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCFD156230;
	Mon,  7 Apr 2025 09:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744018742; cv=fail; b=reuw/6Ej2C0XnWsJ1bOOnmCaFpwbF/EcEUegMW3SEkHtg4sgsMgTrHGkYmVNeXbULd/TqMSfnZ8Q5qtWYLrxjaEfFeYGZvy4zfJp5zaoVoyFcsCE1TBTJm5WhnNRV1y6L2cycQsCaJ/67AhHGYtxUpeTjZbq604/5IG5ogHgV18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744018742; c=relaxed/simple;
	bh=lXAtiGTvKo3GBdXFmfPp2R607NFAw6GqvwopRV3M0eA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y3lOUAb9IMDGaFfcWBfUnvXn+BU4HcvUM1TrBfQre3HntMmxnIZ2qM/wKOawAJiTk1nYkTbJy+hWY2cHfjo1cKScnwklkmEQkk1gDOe632gDGX50VZidxKvFVUjN+1ijKsY/dSBX0oZLbBx5B363GzkQkkJZfCfusdkjKtuBa/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Jhu1QqBK; arc=fail smtp.client-ip=52.101.71.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DiYsCI9Ct8qsXnEPnvzOh/5LlUPxjPWSxTxh8x6zUdS/anC+aUoqUx//sUIjY3wIAhFkYMy1U7lnUyOxsRTlaIU315UveIwc0RMzez05hkOtSwM82EC5VibbiZ3myrvnEvVwbnpJcTHjApLRnjnRs3c0+FtxI4UZ7rnvBddmV0h5+KwrJls9rJT7BUzEm9UOo+oMrzALNBeZVQZn6t/OlHKDvwZfBZhKGP73qdQ9p5cieuVyzJGcCNQs+i0WaPxeQLcvA0LBYAUkN7HTAqE7oRbr9vzTjUDZd8OtZ348B5Z63DbVJYKDr4yOtomqMtUD5t+V14rSN3vrFfBEOcHpAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pYVrZ/LKT23EGAPlyxyawMRqc4dMa3w514Ce/QtC5Qo=;
 b=Y7XZPLyCkvk7NJDq0QFrWARxoDzeE4CbIS70w/4LSJoNAQ1loiNJDcLnkBQeWEOfayRl9nzSm3fNEBjaXzRhbVFBxCJ2a73WKwmllLOyoy0A89jQs7ZGes3sqxTFW92FpvBN72sMAqt5h4fry/60kOjqg5/hRl4utP2XHX7XRXG1xTShrvWbIh8UWu0ir7PcTere2wMFVYzR+qMeh2jmlgF07GwBOKUKnXJK/wO7NMXiliBqnXwTy2wopq+SAk1flBl1pO23/6IcH72zaS7ZUz+PPg9jW6DLytexIbRP0qJ5Xn3bR4IPkwF+vOzYv8tIuFLRkpebe+piv+n9YH7BwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYVrZ/LKT23EGAPlyxyawMRqc4dMa3w514Ce/QtC5Qo=;
 b=Jhu1QqBKJXgtY6qJGhmn4ouB6IS30IHuew5I6BE1OB9InLbKEKkDCd3YM6mO9IeGfnYApLhMWuA48iYMmHc4RfiTTJZDuxKVwyAF0lomrz9XyS/Ya+qbHr0Qqp1RsblVbAcUjmSeOTTE6oqWetenGvMleuqtFy5EZGrLRHw1aAkEVRnaCtlsFehrVavJDMoG022ze1D08ILfMlRx3aLFdwQj1pqS5UnhjS0jW6GSIwsZj9msi8TqSOUbSBdJMYxR+yeW25AoKg6NxMJll/bKKxRdBMxEsfQRc0OogVPSAXT9eVCRvGQb4129IAqEuFRgpu1uuGKrFpatSescjvleZA==
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by PA1PR04MB10098.eurprd04.prod.outlook.com (2603:10a6:102:45b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Mon, 7 Apr
 2025 09:38:57 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%5]) with mapi id 15.20.8583.041; Mon, 7 Apr 2025
 09:38:56 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>
CC: Hongxing Zhu <hongxing.zhu@nxp.com>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, dl-linux-imx <linux-imx@nxp.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2 2/4] dt-bindings: imx6q-pcie: Add wake-gpios property
Thread-Topic: [PATCH V2 2/4] dt-bindings: imx6q-pcie: Add wake-gpios property
Thread-Index: AQHaLabE+/mqsANsskSLK4N2coNpALOWMC4AgASMryCAAAO/AIAAJLrA
Date: Mon, 7 Apr 2025 09:38:56 +0000
Message-ID:
 <DB9PR04MB8429618213357F5CE918C68292AA2@DB9PR04MB8429.eurprd04.prod.outlook.com>
References: <20231213092850.1706042-1-sherry.sun@nxp.com>
 <20231213092850.1706042-3-sherry.sun@nxp.com>
 <20250404094130.GA35433@francesco-nb>
 <DB9PR04MB8429588E7CF00BDC9CDA863F92AA2@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <Z_N9cO64FZwONcK9@gaggiata.pivistrello.it>
In-Reply-To: <Z_N9cO64FZwONcK9@gaggiata.pivistrello.it>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8429:EE_|PA1PR04MB10098:EE_
x-ms-office365-filtering-correlation-id: 90350a73-8bb2-42ce-8325-08dd75b80475
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?jWiSnjvWmqxKvUWflhfSNcSCsVh1p3tkDn8ABDayGDRI0KUZAbg1MdA3vrRo?=
 =?us-ascii?Q?pCdC781QERgcB/vz77BbuH0NQBkq+BsAFklmXXsU+GEAkFFXFIeNvZFbPSC3?=
 =?us-ascii?Q?JFQAsww9Gm62vs6/4CimVgP5JsQfTMrMYWVvEY0pVR1f6k8ceKpaJEVUvgcZ?=
 =?us-ascii?Q?a2Sc97QAax5Gfm8bilY3gffOaLjsf+Dp9s8/uXVqIyMy9wAHafCBlb+Skn2v?=
 =?us-ascii?Q?TJk3k4KmRJ4nzfGzB01C1sG9fW+zMJsGHS5iFcyJisy8pIA5WlsWDC1O0urp?=
 =?us-ascii?Q?vq63H09VEp3WfbCJNGI7yLvSQKzoQncFMnW7pomUKxGqMqiENYwV9D6E2ygg?=
 =?us-ascii?Q?WROFtToV/GCs3ojSRUDkD8FljpIrvnpiHGstS33AO0zcc95FhAq1F+G6tYwM?=
 =?us-ascii?Q?pts9beh215p8fXuDovJHBV0pOK4+sTytkNqOLxI3tOw9x0la+d80mSDPyaKf?=
 =?us-ascii?Q?W8VkRsR/spZAtkwQJaJLcKiStAk6MPbOq4LACSrz9OI/0jI/iFcvqa2okt/y?=
 =?us-ascii?Q?W30xPJm+5z9Ihslh1GdIHCnsRJDPPdRms+z5FUKP7qNsftzuIecTN7mjcSPn?=
 =?us-ascii?Q?jZgTkpYYOzoD6kPQlLlyi2EFM1HZ+VV5kFCOSyvbB3AJWbsML62UrVwVXeNW?=
 =?us-ascii?Q?AagCO/nA+X966NIcZOlMmTmvQxgNYJj6v5mXsZ2sUrJFc+rvxtqKG9V6LP8D?=
 =?us-ascii?Q?dyTrJvyn2Wpfc4Rm72PQI1F/AMOWmYxxkjned+29nPHVxz92skbuPNTYFXE0?=
 =?us-ascii?Q?ueQzU+B4uRt1d5fkfOOOnLBXEI1GJzrWUIGTo5etfzRK09MsDncSw7nudW8d?=
 =?us-ascii?Q?zTPeTtC/4r5Q54m2DECru5xzXvqAX0tJaOnZKox3QOpxVe9ayliHkhBapeAv?=
 =?us-ascii?Q?neZhKSD8+MWqjC+/x2thlskcexUdFEc/VPZSQ6mRTwgf7tVNr7dFLC0AQ0AD?=
 =?us-ascii?Q?Z+PQIY/0tlaXUhW91ZE6BtMlMGmKwB42VFi4Yoe7HJZFnYOejGo1CgARK/Bj?=
 =?us-ascii?Q?zH9PEAnH+GCWBbO5jMtbZP3QY95Le9HbWgKDl5bWHv7/xVb6EqBtUwcK6vw/?=
 =?us-ascii?Q?Fo0Kwk275WFtJVKF0QYw+/MeMsuZXJhbFgAVGRlROPxcwh/WHgKiLkQA0hln?=
 =?us-ascii?Q?NdxZnYVxSoFBLsGeCSlDoUYlj6YiahWhoYFT+9DSht3yvp4a/wI1fxkyiJ+/?=
 =?us-ascii?Q?QZ6ZcI6RCGJEetJkG8VV0jP4GVhhC7AS0j8FxFVseIOOCTXhRa59B18JU1gh?=
 =?us-ascii?Q?mUWFs7mNDmM93yPQpyA34WkH/95CEpyq1ngn2f824DVAStdG/0UUPxtH4Itd?=
 =?us-ascii?Q?4WOY9RvCfXze5WkldgsKZ0zGFeLV3Yy1MVseSA6l3sjyzcV7k53XxHuri1gn?=
 =?us-ascii?Q?gf5XyUOckD6v6penP4ClznIqQk+ZFqxcSmSWVUKyZnktoQQGX3aXkN9jLBDn?=
 =?us-ascii?Q?qkEYRlmjeaQIolBaaQL3pfa+9YGqMzh5?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?row+HwUe/epL29ZOp+CBgGiIfJGQxcezHy41AKm0Q0yuFhToz4Y3D7oYS6KS?=
 =?us-ascii?Q?38R+oclEUY2ZSpUXzyTuLhWC9xVJN3MzDzp6TlNsMc7COGR7Cv9Mj4hDP/R0?=
 =?us-ascii?Q?ZUVIA8homl/sw3fIBQFVgWWyYPSx9N7nAGSABbJ5pwn0whPCOgnhM6f3GR9u?=
 =?us-ascii?Q?BxV/9hrCJX1hvX2oI1U3r2zYIfQx36GAP5Jqkr9xTPXdOTa5Z1SF3hV2GPD7?=
 =?us-ascii?Q?9yClPF3D0kRPoEPlAscntSNqQyl5HtNs8zkEhtQdfG0JFOvnJCCoLTfskOSX?=
 =?us-ascii?Q?JMLfkEcFmAKxOjx4LbaD2rA6Q6JB7HA772dERj5OtKJOd+OWf6Rzd9SQr0xa?=
 =?us-ascii?Q?yYBa3kOcjpsg4n4is51F5nD+iL/Xx2kq/gECJ1JXA9YcqHkttpoqrFxugZxX?=
 =?us-ascii?Q?XJZVIJj7W//ksiGkqgMdKGQ+D/b/zd+khOoWLBATL5UMGvyi5dFrZD5jRnWb?=
 =?us-ascii?Q?4uuk0d+iPdXNujVXi/3rGfBca2QE/x4qDzprDnPH25votn/pN0RNj4jPOrTM?=
 =?us-ascii?Q?9PD38gUmW8vhH8+t3z7eeORmwGG0KX/ghgKWoKlZk2+/5/YsWnyCchn+xZx9?=
 =?us-ascii?Q?q6+MeX8viL0ehy00NDvSgoJvPSveZdofu01kzEcPbqdPI8Oo7qiYflfEuiOY?=
 =?us-ascii?Q?tjTbbFB3oanKFyBga1fj4meZBj1rnpN1UtEDtDF8/Qp1o+pF4CQSpHaSSGTf?=
 =?us-ascii?Q?xa9DmBeKBLgHsq73NQaZGRWU3INfNhDGicyTSr2HWiZ+UW/i8EWZo17TCuWM?=
 =?us-ascii?Q?KUu02nlNRYMh6lJN2+kPCjET3GJUlxLLYjoz+lYho3osLdAFvqjwGvf2oOZe?=
 =?us-ascii?Q?2ZXKeNTTDM0HXKzmNAuaDnLbwHmtxqbXOzJIE/CFyG+Ui4UnbCZN2puRgT2x?=
 =?us-ascii?Q?sM/ftpfmiKUTzA4bAkRc6SBvqLBMzxVRW1m0fsKCijJW3HyS34lstaWgm875?=
 =?us-ascii?Q?JC9slF4WrZSilITVAJhXOCn+tZjQfyqDeostBqB1C8557xlO/VywjzBxcd1S?=
 =?us-ascii?Q?3ICMY33Zj681WZ7GyVt7/f677iBzGKWdrQxPHH0sAtmajBUV+n/epI4Q2z3m?=
 =?us-ascii?Q?rT+E2arjfAJMxYkrukodvAQ7ewFgC050+aSVhpNCyPu7x3OwA3+c7kVGRsyu?=
 =?us-ascii?Q?V4O3NtT+cYy9DLdiRIgamJ4dOVISo7TkbJXGqikNos3PBxXzCNum0AVaRuDD?=
 =?us-ascii?Q?iX/ukjjVP030vZmzAaQYUqP6HzBssR+bQzpGK2IiNvevnhANBUGdbMAkKFNf?=
 =?us-ascii?Q?uRSAvJef/izAxohDRdZovu9dhPh6paXC5gusamVdzjgPxvkL9SOPiWY6Uf1Q?=
 =?us-ascii?Q?JYI2HRUhnrYFC2S0tAvzIKBiDj+XiYnN730Zn+zcvExX6wGc0mwtFyhyUtLC?=
 =?us-ascii?Q?eG/Ku5zNBAAcrASm8e0SxgzkhqhGDztjKy89hpnxLExyFIVsnnEEwIM61RHy?=
 =?us-ascii?Q?wkh54S3qLRTsl41wvDIAf9GUbKdCSiOtqGE8ZBr1qxY5PO3vZ5IHeYTkJY+i?=
 =?us-ascii?Q?0hpUTzcwJec//Z6fFzNUvyWT6iilqK6ksEvihIIxDhOClcU22QGhRqzpekD0?=
 =?us-ascii?Q?xKwYa0llXfWRmZmh/io=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8429.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90350a73-8bb2-42ce-8325-08dd75b80475
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2025 09:38:56.5425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2OuJRtATHa+0eSoGTHsyNqThQQOfywWqMjxOSPhQcJM8fodfqnYTwoJ/ipW7YS1jqlZQwED8opmpJy6rwk7SZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10098



> -----Original Message-----
> From: Francesco Dolcini <francesco@dolcini.it>
> Sent: Monday, April 7, 2025 3:23 PM
> To: Sherry Sun <sherry.sun@nxp.com>
> Cc: Francesco Dolcini <francesco@dolcini.it>; Hongxing Zhu
> <hongxing.zhu@nxp.com>; l.stach@pengutronix.de; lpieralisi@kernel.org;
> kw@linux.com; robh@kernel.org; bhelgaas@google.com;
> krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org;
> shawnguo@kernel.org; s.hauer@pengutronix.de; kernel@pengutronix.de;
> festevam@gmail.com; dl-linux-imx <linux-imx@nxp.com>; linux-
> pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH V2 2/4] dt-bindings: imx6q-pcie: Add wake-gpios prope=
rty
>=20
> On Mon, Apr 07, 2025 at 07:18:32AM +0000, Sherry Sun wrote:
> >
> >
> > > -----Original Message-----
> > > From: Francesco Dolcini <francesco@dolcini.it>
> > > Sent: Friday, April 4, 2025 5:42 PM
> > > To: Sherry Sun <sherry.sun@nxp.com>
> > > Cc: Hongxing Zhu <hongxing.zhu@nxp.com>; l.stach@pengutronix.de;
> > > lpieralisi@kernel.org; kw@linux.com; robh@kernel.org;
> > > bhelgaas@google.com; krzysztof.kozlowski+dt@linaro.org;
> > > conor+dt@kernel.org; shawnguo@kernel.org; s.hauer@pengutronix.de;
> > > kernel@pengutronix.de; festevam@gmail.com; dl-linux-imx <linux-
> > > imx@nxp.com>; linux-pci@vger.kernel.org; linux-arm-
> > > kernel@lists.infradead.org; devicetree@vger.kernel.org; linux-
> > > kernel@vger.kernel.org
> > > Subject: Re: [PATCH V2 2/4] dt-bindings: imx6q-pcie: Add wake-gpios
> > > property
> > >
> > > Hello
> > >
> > > On Wed, Dec 13, 2023 at 05:28:48PM +0800, Sherry Sun wrote:
> > > > Add wake-gpios property that can be used to wakeup the host process=
or.
> > > >
> > > > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > > > Reviewed-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > > ---
> > > >  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml | 6
> > > > ++++++
> > > >  1 file changed, 6 insertions(+)
> > > >
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > > > b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > > > index 81bbb8728f0f..fba757d937e1 100644
> > > > --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > > > +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > > > @@ -72,6 +72,12 @@ properties:
> > > >        L=3Doperation state) (optional required).
> > > >      type: boolean
> > > >
> > > > +  wake-gpios:
> > > > +    description: If present this property specifies WAKE# sideband
> signaling
> > > > +      to implement wakeup functionality. This is an input GPIO
> > > > + pin for the
> > > Root
> > > > +      Port mode here. Host drivers will wakeup the host using the =
IRQ
> > > > +      corresponding to the passed GPIO.
> > > > +
> > >
> > > From what I know it is possible to share the same WAKE# signal for
> > > multiple root ports. Is this going to work fine with this binding?
> > > Same question on the driver.
> > >
> > > We do have design exactly like that, so it's not a theoretical questi=
on.
> > >
> > The current design doesn't support such case, maybe some changes in
> > the driver could achieve that (mark the wake-gpio as
> > GPIOD_FLAGS_BIT_NONEXCLUSIVE and the interrupt as IRQF_SHARED,
> etc.).
>=20
> Can you consider implementing this?
>=20
> > But usually each RC has its own WAKE# pin assigned. We have not come
> > across a case where multiple RC share the same WAKE# pin.
>=20
> We do have such design, with an NXP iMX95 SoC, available now.
>=20

Hi Francesco,

Now the patch set is pending, please check the comment under
https://patchwork.kernel.org/project/linux-pci/cover/20231213092850.1706042=
-1-sherry.sun@nxp.com/ .
Seems this property should be put into the common PCI root port schema,
now it relies on the pci-bus.yaml splitting job Rob is doing.

Best Regards
Sherry

