Return-Path: <linux-pci+bounces-8575-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E9390376F
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 11:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C03B1C219E8
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 09:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1A117622E;
	Tue, 11 Jun 2024 09:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="n2+EhWRk"
X-Original-To: linux-pci@vger.kernel.org
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2086.outbound.protection.outlook.com [40.107.113.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309C479C8;
	Tue, 11 Jun 2024 09:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.113.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718096784; cv=fail; b=gb/IohqwaZ2hLG0hQW9XfY9LoFIOWYgHLIY3bdQegfkhxuZvErQ6qpqa8hFqpJKqU10mX4PMwhriDxzgFrggEOPANJPM8jwQLdxjZkHV9+aEaXKRjKB9/X7nR2Jy5NT3Gv848unzzmaWSv9PIBFuDgxwifTnqC71EbGWx1aELMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718096784; c=relaxed/simple;
	bh=9ScAw0WsCUKhNcVwgPUWqAjEqVi7yhJtNI3trvAsW5w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OM6/PFtBn5coc7so9lK5dmvQznvP5yUze7TVJcjH6ocantSFL8W2i65jwkH9dDvixEBkka8MR7E9hyXh4AhYR7QMS4w+cJVf7hv2yQitcwMHDvuQrGcvMkrmGmZw17kRrIEE3L3LBX8xzoElU8fCw6iC3KdcI7ZUToAfSOut+YE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=n2+EhWRk; arc=fail smtp.client-ip=40.107.113.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a51Yyhpom15BOBn/xW6BPZGlG4f+xzoGYiQcRKcWsL7QirPbU/XI8ImigkE+mFt22JGM50nhyCARVjC3arTZWmusR2HufWF73h+OkfijYHsu/vO70kcuLjKzfSwOKNZLX1fWf/GNrIpJxn3/gMi6RvHontH76cVYapaHWxx608mfs3kQu3NTwLB7g24+rn2JpthkzHSE+7uSiKg7UgFfaY8aBGgo4qPmNHMCQyG0s4a+sUMmiODVC3g9HTHXmHtlcZqSr6zbpv+FgFeSnHIU62C0+76cS1Gj1SX1AqsiaaAXhenp1WbfqJdF6E3stH6L31xluvvcrbo3hsU5M5DXUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rpRI0hx3mpR5yWxKfXVFMU99r3HxZF/JLuCsUYgR6i8=;
 b=Cf1YeeyUZXQ7gvLxf3xtC4RCWEsXSSAKqkpSIAwWSvuT7Wpq/HUpeWwlqrGH5Db6/o640+MhzYfD/swka/SrrtreSxao0Yp7OvkfO2UTU3ZdXl4/G5ii4sYetf0lmqKJXtyInmsBwEXzOCjS5wbQwDNF8TMl1+8nmaD8xWX9WBQMz00DUu+31cp3nlDr5d7ilkSNb+C+yfZhx0R8rulxbxCBpYuNZLaepfEZHEnL3QG5YifHOIhAe4+6fkAE5upoRhmsk6KBws/ZlFWB+qOExT6+gVDZV0D5ZKzl5prWd0h7HCbipiUBB+198iKT1oAisEekPhxuJ94eIJxGFU3k9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpRI0hx3mpR5yWxKfXVFMU99r3HxZF/JLuCsUYgR6i8=;
 b=n2+EhWRk6Z0HwcPOZlxg7F4onQ+NOU4raYXqnYchRwvMM1r9awIWIp5o9opbtatRj5rIpOkKkfsxoGB28WQ02uqWtA4jroxsSZ1UO9Lydb2bRI4jwcdwA7iNnL91ozKHgwFR3PcM8epurpZsxbNx7L8pQJ00SStrGqzaOBR4sd4=
Received: from TYCPR01MB11040.jpnprd01.prod.outlook.com (2603:1096:400:3a7::6)
 by TYCPR01MB11787.jpnprd01.prod.outlook.com (2603:1096:400:38c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 09:06:17 +0000
Received: from TYCPR01MB11040.jpnprd01.prod.outlook.com
 ([fe80::b183:a30f:c95f:a155]) by TYCPR01MB11040.jpnprd01.prod.outlook.com
 ([fe80::b183:a30f:c95f:a155%4]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 09:06:17 +0000
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com"
	<kw@linux.com>, "robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"mani@kernel.org" <mani@kernel.org>, "marek.vasut+renesas@gmail.com"
	<marek.vasut+renesas@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>, Frank Li <Frank.Li@nxp.com>
Subject: RE: [PATCH v8 5/5] misc: pci_endpoint_test: Document a policy about
 adding pci_device_id
Thread-Topic: [PATCH v8 5/5] misc: pci_endpoint_test: Document a policy about
 adding pci_device_id
Thread-Index: AQHaqolaUZI8fEBh9ki8NwmNOflRprG5hl2AgAjhhJA=
Date: Tue, 11 Jun 2024 09:06:17 +0000
Message-ID:
 <TYCPR01MB11040921AE68844725D81E0FCD8C72@TYCPR01MB11040.jpnprd01.prod.outlook.com>
References: <20240520074300.125969-6-yoshihiro.shimoda.uh@renesas.com>
 <20240605172803.GA766828@bhelgaas>
In-Reply-To: <20240605172803.GA766828@bhelgaas>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11040:EE_|TYCPR01MB11787:EE_
x-ms-office365-filtering-correlation-id: ecd905c2-fb0c-4335-da45-08dc89f5c0f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|7416005|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?NGaHcpPgNKzbKzjbZpmW5MAh+NLx5js27dXjdtYSRaZovPIqobvQsr6aLxlK?=
 =?us-ascii?Q?zddwBxd6nqnMgPFmntlrhxbNKGeckhECxQkArTDYgtk79FAyRaJqGzn8jZZc?=
 =?us-ascii?Q?LXzxIqUyGsXVja+CZws5+2CpopLdpPElnJibax1C7DyVzj39y6vgknHIZXWN?=
 =?us-ascii?Q?gDrvf3UGVm/RXKt3+G8jxPKN9z5n+zwJGcJW3gI7o+7p0RpoXvShuPFlXp1c?=
 =?us-ascii?Q?Lc/WCXTcUiNmBa+0pmzbNhujpv+y1uZUopPyBjfGR6FxWuplCM12rtUtco2V?=
 =?us-ascii?Q?Ztso7kOEGLL7ThZKgs+gzutEuJbYfaYsGoSxcLF7t84hOwK/Xky+obuC9WCq?=
 =?us-ascii?Q?AS+pNA5+Hluliz+1m4zuSsSxG7xvwBq9G1pU/hcqshw53Xub8W3CRXeat6tr?=
 =?us-ascii?Q?0qcvLOnd1C+Sf8xWx0QA//w5HJvh8e5pUf8odhOZ9SR/XI6TJYVkvHRl0Xn4?=
 =?us-ascii?Q?sYRvVz+uNclxYp+mBGjIyNh8sPcFZ5hfEPhrTPbs8eYXIMovT4odXv13MJmM?=
 =?us-ascii?Q?nBXfouQLH9mBuwCdJrvPen/EEahASEUNAcC77jd2veDXZl/BZHM3jl8cY1cU?=
 =?us-ascii?Q?MxQZi1Iq+iI5W+XUtb6laFzshynQQNmnl6yWyNZYkvmwzwE0chniVp8xbZT+?=
 =?us-ascii?Q?Yi9HEgKm1JvW5Tb//KKZ4gO4qayISNRbtbdFFNYo3NhNP7RxoyxHU2c0Lfen?=
 =?us-ascii?Q?gC/XsBqi7qc4mRtx5XRkDb0JnINwP1oEfDFA38Z5J+OgiAl1Fah29pdQCtTt?=
 =?us-ascii?Q?kDnW9rnnExZlUHXmkMIXRxj3pBDLSFwIU+FeGqkhp1w/Fqh5Ql/oN5mvGSEX?=
 =?us-ascii?Q?hbVyXu+CGHqKpBWID9GLpidnQcpX8oJ9kyDjlOWJnbrwnHQb9H2GwmR3d2jZ?=
 =?us-ascii?Q?hjlLvxbjHt//jkptdv/+MB7rKmM6WfMWEAnS9NzI6P0gcYcHv0xUzunv53eM?=
 =?us-ascii?Q?1z2EzrgZ5PgVF37KKKu6aITViZgaKqCik1c0OV82ksDVkYPmZgAHd1BHE6oB?=
 =?us-ascii?Q?wRd4ghGm6IP6bZMvCqEyZ1d9PntC0AM6dneaToNRlRSHu2RkKxL18xqs9B2R?=
 =?us-ascii?Q?MH1T1xgZEczfRk6UtIKxZi+AaAelS1Rn4SZJ8TrDZqCIQDGjgkWB7hIAmGBA?=
 =?us-ascii?Q?yCRi/PS919gvz09ck5nBA3o5Tyc+JO84jO5NpMJxDPSjcZiArt2nZTVxtwv0?=
 =?us-ascii?Q?hFufo6Efoic33vRribkff4r4Sw2Ut0kHVOrkgGrNiHSrXXhFsLyXjt5kpC+O?=
 =?us-ascii?Q?XP+pW3vnGhNgW0/zS3GPhos2YHCXVLTUGkqlElokF5fSArrWCEIp2ep89MaH?=
 =?us-ascii?Q?/ZvN/IFZvvVV/xeAefHB+GPIsx347XoN0c1Qc/NCAz7VsbmdCE6Eb+1FZOq6?=
 =?us-ascii?Q?zEKf+F4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11040.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?wZIN8cCyhVbvd+3UAm9D1hgunZutiwt3djZtzxdGu4mjZO2/0cEbZipGEUQ1?=
 =?us-ascii?Q?mMyi7wELJJcKk7+FlvBsaFjVR2qFwwBqeto0hqVo+29uuBn/+amNPR5Cn8Xf?=
 =?us-ascii?Q?M0g/4cWLRw33Vr1tFcMm8Hx+Hk4MQC2yzx4SXDQqt37o0UKgDXReF61BzhUE?=
 =?us-ascii?Q?hZXs98ZjeBIeROFLxjYS50UxVPKloyhpyoWe7r54BTojwlupW7MhSzFngD6T?=
 =?us-ascii?Q?9eA7pNnitX0gT2L29YfOvnYXIAxhqwycYqrpETPOAd28yb0zKJ2X4wo1Fk0Z?=
 =?us-ascii?Q?Hon82vDs3SM4zbHTCcHMItRBmxguDDdkPlSvkmFjkiCPjKY2D1+69V3LTeeV?=
 =?us-ascii?Q?QHSvur/xkFBN+aGZO7DtaibJ27/iwD4hyHHHKq08HRQz/u8S/lN12johID7p?=
 =?us-ascii?Q?bEc78id4BekXRGGhjUT5+BjTDBHY+e7Sk5bfyk3HYza+oHmGoiPnNVCnJxiR?=
 =?us-ascii?Q?Wh97Ds03baDuX0VzwDXrXZBMwHsNNhz7pJgXkHfsqmdrQH5KxOZC9cgN/yde?=
 =?us-ascii?Q?brgYu7qsZd+6R/TYJAgK3UGpy9CcM/g2+tLXYI2VdHeSQU+zGj+chnuz/yQN?=
 =?us-ascii?Q?WBonNRdxMhCOQPHaFhLH/PAQnmM2pKd8gPB/QZMyKUByqk7BZu1Lya/SSluy?=
 =?us-ascii?Q?Rz5s0OXuYHwJxQwLgrrxD8VOk1d7N0OiV6AcKIsMM3NKBMn5V8AzV0NCCjya?=
 =?us-ascii?Q?FLnOHoevXjF51TMvOIKRA6MohuAkYtc1ZhvGAgBOV9Z2MbhmyGDtLIi14T4u?=
 =?us-ascii?Q?IqPkNt63ETqoVV4rQJoTYDbPW0y9Df2be5AH5EIB/hTVbrdSN8GOobsh8iRp?=
 =?us-ascii?Q?+eu95GS+v6WwZ/mg72Qwyu7EwiQ2OuVBiaz4ScV4jbgUjWiQ/37H1/ZG+k3W?=
 =?us-ascii?Q?Ex02iE3bVb9RWdRlwBFf5rknTJCl5U0PSyqyr9+Q1qhlPBw9bwWdqKx9tFTd?=
 =?us-ascii?Q?lcCiRuumNRc7CWF4Dr1EAMVAeLkZTLAayYNXP9jPcECDmKsdgXZvaDKOvbH5?=
 =?us-ascii?Q?sM33Fgni+1QIYqTP4TknpTsvmwOg4eGxwcdlugNk4QHIOWRbKXu6RpjaY6uf?=
 =?us-ascii?Q?NIGUDBk7APMtZgTWMApA43zlTceqHvv4btTQs0pD4wHcQwWapNjZfEXejqiP?=
 =?us-ascii?Q?WKJv8z+mmwv3v1trjpwhzNA5e2d3vkBYBHYwEFnFpqAAiDeAMXzZ1LDExqxI?=
 =?us-ascii?Q?r+38h8xesnH4ljwdt7BM5XiCi3O09DP/4p68E3SZizAFMTOhj57OaIplbgVl?=
 =?us-ascii?Q?+80NmucrhZE/jthHKWxoVC2GgwLq5f8WeWVRiNJa488GMRRY7NUxUiYkmk9t?=
 =?us-ascii?Q?YhqC4Be+waqg1TqQ1I1+ZNEo3+PWZrbGRnbQh73M3d4p+SOw4l5eNfHzgkDW?=
 =?us-ascii?Q?C/TYKp9p4SI6RsL0CpSbppPkLhsh0GwT5Q6bIrH/7uf/FQ+kuF2a0BgG1Ewk?=
 =?us-ascii?Q?0CVI6oahNp1ZbcJU1ZnBJTSYVuFA33Wc5lQijBwBEJnLocCXdtu4+lN2mifk?=
 =?us-ascii?Q?v1nAy4IASRkBfmgNwxVl4CJzXfnDcihhAfDTQPykWdvDAW8AgEnsSZy8lHUv?=
 =?us-ascii?Q?KwDWPJ1Z9JZNt/tl+dAkz+qz8mut7ZdBzjFVilJSdqc2C67QIZhamQtV0gaj?=
 =?us-ascii?Q?z4V7YWkgm1hUOOPlAPDiz7CWPxnncPycvSteq9+tvRKMuf5q4GMQhLumWHlB?=
 =?us-ascii?Q?9F4KFA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11040.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd905c2-fb0c-4335-da45-08dc89f5c0f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2024 09:06:17.6788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7R2852pzd4PXujhGDiWW7yEwlJP8wZua8RMrgoeT3xpXKlLEhUx2p4F8lpjAU88y6rAzAtKt+3DGqFYgQdLELlq6kCpXpeKjW6/rpgfl05Z3FuREeWKt54P7ZjtF99ED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11787

Hi Bjorn,

> From: Bjorn Helgaas, Sent: Thursday, June 6, 2024 2:28 AM
>=20
> On Mon, May 20, 2024 at 04:43:00PM +0900, Yoshihiro Shimoda wrote:
> > To avoid becoming struct pci_device_id pci_endpoint_test_tbl longer
> > and longer, document a policy. For example, if PCIe endpoint controller
> > can configure vendor id and/or product id, you can reuse one of
> > existing entries to test.
>=20
> Possible text:
>=20
>   Add a comment suggesting that if the endpoint controller Vendor and
>   Device ID are programmable, an existing entry might be usable for
>   testing without having to add an entry to pci_endpoint_test_tbl[].

Thank you for the suggestion. I'll fix the description.

> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  drivers/misc/pci_endpoint_test.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoi=
nt_test.c
> > index c38a6083f0a7..727db13b6450 100644
> > --- a/drivers/misc/pci_endpoint_test.c
> > +++ b/drivers/misc/pci_endpoint_test.c
> > @@ -980,6 +980,7 @@ static const struct pci_endpoint_test_data j721e_da=
ta =3D {
> >  	.irq_type =3D IRQ_TYPE_MSI,
> >  };
> >
> > +/* Do not add a new entry if the controller can use existing VID:PID c=
ombinations */
>=20
>   /*
>    * If the controller's Vendor/Device ID are programmable, you may be
>    * able to use one of the existing entries for testing instead of
>    * adding a new one.
>    */

I'll write this on v9.

Best regards,
Yoshihiro Shimoda

> >  static const struct pci_device_id pci_endpoint_test_tbl[] =3D {
> >  	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_DRA74x),
> >  	  .driver_data =3D (kernel_ulong_t)&default_data,
> > --
> > 2.25.1
> >

