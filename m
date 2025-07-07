Return-Path: <linux-pci+bounces-31607-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF2DAFAE76
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 10:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 342DB188E7A0
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 08:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799E928B3F3;
	Mon,  7 Jul 2025 08:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="JTjpSK1t"
X-Original-To: linux-pci@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010060.outbound.protection.outlook.com [52.101.228.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7840E21D3EF;
	Mon,  7 Jul 2025 08:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751876350; cv=fail; b=eoZYbQWsBcCqhXld8ovPjHJi7cyHOYi/h5QK+sVom8opdoikIX2c37Ul8JQER1AEtlXpbLmsfyECFKF4VZVdcFXXwDT8+Fr0SgVihaEVHLDKCuwxshjHkDz3ILvCYjpQ80Jfghss7694fFl4ILO2XIhm2eXNJTOgAG5VsnPOhvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751876350; c=relaxed/simple;
	bh=jwfIU5fdeFBmbeOE8FQsq4F9D0uIYnzmtMA2h3uKmzI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j+HG7eoN70UWvxsBs8sTYKJUA3PT8+EUB5nxSYCO1W2sYb4Ig11wSGWPRxax3ZnQCCW962ap2uu1rKy2xtTeb9GDY404/1uIFXBhS6/oTjtnrt0XKrN/lMWXMiDbDAuWqCxnftoq2s8ueZ+84bwRyxc658W+ab5pbssg+s+r3Y0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=JTjpSK1t; arc=fail smtp.client-ip=52.101.228.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GSUyozsUzUOJqV8uFHczC5yCBSxqn14z+spuhn9kg7WdcPS5J51f6T3F0cWOSzn0fW0vmsups6f6cqd+p9MG9zXlnjVCMrI3sM1CQQqpW5TZgt8YslyqYCm3RynsMiQS0wEEuQYKwythT4wcZ0vamHEpoJ332mwNtoPQv4Wbl4ScX4sdoqJTCcWo5BxYWGtTlLmJVPM80HgIWqtcoLVI4gLF6vehonAF2BtemtktTtQavz0rQyPRJrQGO/M1yXM5meoDtOXVwnxapWp7djthvdRDFpn/EmMtrQOJaf6itSRuOPOG/IAWfmfUdkZgp2HZ5YoTjtUjv1T3HAWa4EqjPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FvjUdTQQjv7uLK9DobOWGrKfOZv6veIKjSuffiORI90=;
 b=uAPK5J5BJLH7CKMK802wZRj583nm4WNq1B0Oe3rk9C+oCbheQj+LR7vLVtG1LvalVz/mvZa2Se4Tn2e8q1HfKD0Rr38VlQhojKH1n9Imu1BmTW5D/i9mauFzsIAdJ1Zn53O8xWtzTSQkL+EEM4HtCp2ztS/RILXZcAtgX1kXej25KpZNQ1mzqSmx1h5RW9kGI5jM5xXRNNRtjoy6yUppKMC01yppdZbA0ldgcqYBn7jv+RudsFEt8zq24jE1AIRy8ycTdt6HvzFXmleIPgHaVVJiZWa8pFqFzaplFTxl3zRVV0ORmAgqbi/+l6f34BVEg+DzDqFHDYPdM5280lwnsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FvjUdTQQjv7uLK9DobOWGrKfOZv6veIKjSuffiORI90=;
 b=JTjpSK1t+qhFPKWrHKCcodi+Hlxej4emcYXuqGI2ULmeM0FN9hAKED1o/D6LY7x1HHniD3oi72IS7rgRDkNEDz67s1hONJKQW7Qr8xtvOkQXcJpO0idd5vzokOvI8bfRyCHwmGVFV/z6zs1hNeMn8ZddLwko+FANuxhjAHOSwzw=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS3PR01MB5990.jpnprd01.prod.outlook.com (2603:1096:604:d3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Mon, 7 Jul
 2025 08:18:58 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%3]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 08:18:58 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Claudiu.Beznea <claudiu.beznea@tuxon.dev>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "mani@kernel.org"
	<mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"geert+renesas@glider.be" <geert+renesas@glider.be>, "magnus.damm@gmail.com"
	<magnus.damm@gmail.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"will@kernel.org" <will@kernel.org>, "mturquette@baylibre.com"
	<mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "lizhi.hou@amd.com"
	<lizhi.hou@amd.com>
CC: Claudiu.Beznea <claudiu.beznea@tuxon.dev>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>, Wolfram Sang
	<wsa+renesas@sang-engineering.com>
Subject: RE: [PATCH v3 7/9] arm64: dts: renesas: rzg3s-smarc-som: Update
 dma-ranges for PCIe
Thread-Topic: [PATCH v3 7/9] arm64: dts: renesas: rzg3s-smarc-som: Update
 dma-ranges for PCIe
Thread-Index: AQHb7P8PBMpfnLgFvkWQvju7tLKMl7QmU8ew
Date: Mon, 7 Jul 2025 08:18:58 +0000
Message-ID:
 <TY3PR01MB113464920ECAC2C3CB89DE2D5864FA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250704161410.3931884-1-claudiu.beznea.uj@bp.renesas.com>
 <20250704161410.3931884-8-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20250704161410.3931884-8-claudiu.beznea.uj@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS3PR01MB5990:EE_
x-ms-office365-filtering-correlation-id: 60b17bcb-603b-4010-7806-08ddbd2eec5c
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|7416014|1800799024|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?mZnl6W+CQlqmEauptIU30x209/ekb41HH+lAq8oW2ksc3X9q7/c8zUEt5LQv?=
 =?us-ascii?Q?MUIFzpMzT93KmZCa9lo2JsnK7kjblz2ogLs/QR2fXYEawmgnqQ3mQ1d2uBw9?=
 =?us-ascii?Q?73XHWRQmXvC3+sVcd3NWH3M9loNKZOM5NlByhDfn+7iy3LWaqIT4ttc52wW8?=
 =?us-ascii?Q?T09J7rOuFAexKEzzfNOILjhai+Dz7h5tO1ipI39z+nH7DIPe7d4gpg8M9HZN?=
 =?us-ascii?Q?32DuUe7fhtVYWVQwF+Juj2rYY1sSoa4Jg4F+Y455U3aFEFy+u0jtoIwJvuL9?=
 =?us-ascii?Q?DY5t2FC5ZDHRyW0FLeyTP6wYxuTNaGKfErryoH5zJfsiOiktnYGhxRzCFCmt?=
 =?us-ascii?Q?jdXYwmRBiI51abbf8wNSbnFTODntayKb+ltSQZ+fVksJQ6r3bVq0k3FNMxYs?=
 =?us-ascii?Q?dx5U9Enjy3zfBJrW3CHtXH7Hxbx1TuGxhDaEc5KeY5lkKT8jZXX1bOci5cBT?=
 =?us-ascii?Q?I5QeMXWjzDjTZ/6D7KLS8V1+N0T+rP4Pvh2nk8evmbFhbx3mrmP86BYIzxKc?=
 =?us-ascii?Q?Q/Bps2uiIkz6lCYMr5vykyCu4rEyjELGqQCSag5k3zbY98XR0SMLz7VONK6i?=
 =?us-ascii?Q?Zco3aupVS00HI0X7dDxQ4cTpCc3BbXIEY6joILKrEiBAt/g6JZP7Rh9G3DIj?=
 =?us-ascii?Q?FFfGnQ/9muoH7b8UW9vVD5W9Rvi+tpMBbLjmj9hxomDw5sKo5LCh61iYjv+1?=
 =?us-ascii?Q?DkCVIIQ4w9A3Ax2aXvgMNsUAxSvzY84cstrsrp7VDHCxVHGaDeReQiIh/sRA?=
 =?us-ascii?Q?k+RRmbz19/8B7zz++mcu2d2Zi5AAWXwQHvpL01cUrXqtRo87lN7F7CJ6+bY/?=
 =?us-ascii?Q?0GKxSrsMD6ep+Niuegn2Gd9k9w3yFrB2J2O1plGbDuWPPPwo9r/gTpaEXJow?=
 =?us-ascii?Q?z54Jj4GwczZTQ7n951tE7hAJDBnvgCv4la2tbWDcUHLpIfbAN+G6SnJdzhzs?=
 =?us-ascii?Q?rROpMRCmcZ0ofL0zqY/ySPnTzaOZ2GxjEsHZ+8pf9+xgtB1cADNvYKE9x9+w?=
 =?us-ascii?Q?vNf7wwFy11xMyu4/srdTa9x9yimOGbdMMtf43GGyzKu9m3gx3AG/Vrq27NgU?=
 =?us-ascii?Q?Rrv2Lg+FwJTYYfyfzU9qMz2qVQFVYAj+A/8I70e1d82vpGrjdF1aK1YGU1xg?=
 =?us-ascii?Q?PrU/gISZVe5ytipnmOfCHTCjd9vJOiB81FSTl326uZ0oPzTwJFQSfoiekrQo?=
 =?us-ascii?Q?Zq6QMJOeu7rWc19rA35FQiNUJIKOhAmhHXqdyzyuY1fDT7QytOR5fclKm4Ao?=
 =?us-ascii?Q?n9ahyCNbPu7oiKFIa3c5uYIjcgLesgKCArAoIV6lZ2WWYX5ECHeje09mcKWI?=
 =?us-ascii?Q?xaGQTg5YTU0rokKYWKGUl+JyMza5QTjnIZyG+zyob2SM+K1ylxH5NW6K5h11?=
 =?us-ascii?Q?9Cuo4Muv//f6aPyMu00T1jAUKfgFK/aJVDH6lua0rPgu15JUNniERjBFGgWX?=
 =?us-ascii?Q?V2eLU7cgKFgz1NZrs0jl03eq1K4T72GU?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Vc+oHzMLaIrsufioxum8GTaU/76kyK5Brv0lzE8q9xb0ZX/OSlwxVrj9dKFs?=
 =?us-ascii?Q?+rw+ouP628BhmoVGwL1nu1CHd4O8TondcRipGx5PnSRM84laKcuFwpdjB4bC?=
 =?us-ascii?Q?8arV144nbhnHFwyuLZkbdGkdaTUzqDSpS8G9VNSOIwoj7z/H7xTHRIhQRfkO?=
 =?us-ascii?Q?2iFyvUY+ZWIweJFHuvQRoEsAiTw8DAKc+/58cMkZn5l1x6xl0R646Tw/dOJq?=
 =?us-ascii?Q?NOmnd2vriKhuepXX5VogjKv8AOBwAGnvLR2it9VqIUvjajMoCzz7CzBwWIlJ?=
 =?us-ascii?Q?nNvBj4/MaO8opSEAm6N8pejxb0emuVmFv1VXveTtcl13yItNw84ZJF1yEKrA?=
 =?us-ascii?Q?PuTLccJfxv6UECfBwQpw2Rac9IPWcdQkaaJZAcO7Y2zGo2Z3D7+YQ+XT9F4L?=
 =?us-ascii?Q?x9pZy8Q5Jod7+qKZ6nnH3MQna2+FJ+ihkTnDBNkj0TciWzSXsZAitz2SaUgK?=
 =?us-ascii?Q?IISsN8tBLDdw7HqSPpj4vCXaEo6lPRYLYISQeYITJlEfPzL5Q4i3CQihsvUn?=
 =?us-ascii?Q?j550tZRgpg+x30QC/jd5IVJaQ6aClmmrFj1kEeKAX7xaokG4acHJEKguEYU5?=
 =?us-ascii?Q?YtvYJ4jYYKesM6C7/q/A4f7Br0Qd1DNNr8wCroncMFTLcL9E9WC0k8fsLmwH?=
 =?us-ascii?Q?6lOykn+dJhybshg3LHA4vaqQkilcS9ZXBTLcmAQsnEFpyxWzlVVYlLS0HuSR?=
 =?us-ascii?Q?cwSi/4ah1FZYXZg7opL1lAtMOBORZSZd0OpvQPwHSsKNkyoM6pYhQym89RQ4?=
 =?us-ascii?Q?TtFVSSWoCMlk/nRmUWVA7xLTdaKDjAyPS4eRs72OKqoSw1NEtSRp+Fkoo/uU?=
 =?us-ascii?Q?gKOoRuJSxJmjKXi1UnlnRu4pYuVkCHvty65OVS2HOa8dXgXBBK4fiv3KadI6?=
 =?us-ascii?Q?zqqsH1WreTkdZ5ilJZgpka3dFCjmt5OVpEKRkwQUIR3UfvOeagNJ4pOnHgNy?=
 =?us-ascii?Q?N/8SYetBpzrM6NHU6clOSIVdamRExcBLEFTGy/HDLv5R0UyvQXtApSHgQrrj?=
 =?us-ascii?Q?GJJR2nzoIOe0Om/GbC+K4hM9YnOed4zW2FCx9MOahEsL+JrCjF6xItsorF9M?=
 =?us-ascii?Q?HkrJhMRJWdNRZex0ED2jUZt4YpAM/W2ZVtV0ft/b5JRadieatbjnIQ32y/sE?=
 =?us-ascii?Q?lFDZwQzBrQiYw4y/FeMMlov4OBIsvVC2YJEMNCxobJgbdOtpObAIUfwLcQlm?=
 =?us-ascii?Q?dohWLZ7/tWWkd9BHWG2ANh3VKhSFqwbB1PiSqVkzXYaxohUA7D8QMCwLi12o?=
 =?us-ascii?Q?9fz/XrSTwz/A/n5I4wvI9LMASaXLNjT8v+KuhGFQi1e59yBAYFrsTwvUcdzD?=
 =?us-ascii?Q?lMydo9ZApIzjUaK+3uDzz5Db1yRRnRnoH01NAzNT2Cl/UEglpH6zyMU00WPt?=
 =?us-ascii?Q?vforiH2eBhQNJgBN4jsuiPEwNgAYUmCU14YSBtCqYH8/81gxQ6iIUIAqs+MJ?=
 =?us-ascii?Q?gXozX7No5lU6FzeWdOE7hvgUi+bCDiV8Gf44YKX2SzMO/jhaXUciBm6/vohH?=
 =?us-ascii?Q?1HFwdehF8M+GIe1eEW6+vtA5gh9Fa6lfHCQyn/PfGZkV/7Cug/UvGAs/SgaV?=
 =?us-ascii?Q?61yhfbLIT2MTIilKqWsb6dKtOwlK2fb123Z2H47+5VDxxjYa66/3xb0qHANA?=
 =?us-ascii?Q?vg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60b17bcb-603b-4010-7806-08ddbd2eec5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2025 08:18:58.7815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mcx+dKyH3pdpwgIDXPhO4UKEox9cH+9nLNVHH5YFUST1H7Fqb0xsp4kTkLDhMc7l2cDp9o1xNOnoJ44+DZ0QHrCyqQ+8sKzlVrjo2zd9O0c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5990

Hi Claudiu,

> -----Original Message-----
> From: Claudiu <claudiu.beznea@tuxon.dev>
> Sent: 04 July 2025 17:14
> Subject: [PATCH v3 7/9] arm64: dts: renesas: rzg3s-smarc-som: Update dma-=
ranges for PCIe
>=20
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> The first 128MB of memory is reserved on this board for secure area.
> Update the PCIe dma-ranges property to reflect this.

I see R-Car PCIe dma-ranges[1] and [2] maps all possible DDR area supported=
 by the SoC?
Do we need to make board specific as well there?

[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tre=
e/arch/arm64/boot/dts/renesas/r8a774e1.dtsi?h=3Dnext-20250704#n2487
[2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tre=
e/arch/arm64/boot/dts/renesas/salvator-common.dtsi?h=3Dnext-20250704

Cheers,
Biju

>=20
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>=20
> Changes in v3:
> - collected tags
>=20
> Changes in v2:
> - none, this patch is new
>=20
>  arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi b/arch/arm6=
4/boot/dts/renesas/rzg3s-
> smarc-som.dtsi
> index 39845faec894..1b03820a6f02 100644
> --- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
> +++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
> @@ -214,6 +214,11 @@ &sdhi2 {
>  };
>  #endif
>=20
> +&pcie {
> +	/* First 128MB is reserved for secure area. */
> +	dma-ranges =3D <0x42000000 0 0x48000000 0 0x48000000 0x0 0x38000000>; }=
;
> +
>  &pinctrl {
>  #if SW_CONFIG3 =3D=3D SW_ON
>  	eth0-phy-irq-hog {
> --
> 2.43.0
>=20


