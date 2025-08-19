Return-Path: <linux-pci+bounces-34262-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE043B2BC0C
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 10:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02ADE7AE6AD
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 08:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A54311970;
	Tue, 19 Aug 2025 08:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OdINBdyy"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011052.outbound.protection.outlook.com [52.101.65.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB9E311944;
	Tue, 19 Aug 2025 08:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755592878; cv=fail; b=QX2Jr9NrIe3u7w1rEXVo0Y68jrJBbnX5POp6F1qgl0uCwbTtpNsAcoCblHrPiCyXF7xxFKH9wdzhY0gZxsOTvWM/997FXcCe68ffvorua60AtD1BpAoluOywFuwIfanfr6EeQ0H7vDRMzWjmsD+kS1/92IupvAaoM8tQ+/zehsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755592878; c=relaxed/simple;
	bh=STJlPyCur85iRjT00f+MzKeLhuv55IG160xYvtKpf6g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WvR0yXrTW6VhrRUtLMIAfrIcX0/rwd8RmRegqjg7+lr/qrsVnj2WqSi/mTJzKCv/z57bp7xysmevPEOslHuppIvHSYnLEa67dC61rhy4WT2/n51/Mz5gnwk7mTFY3YgLN9Uk/xFZ9eEqjOU7hK0XgAR7vShmirzvzJG3L/mRflE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OdINBdyy; arc=fail smtp.client-ip=52.101.65.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yVrDwP5zsu4lU+g3C0oR8NCGOfEHLLwsqhCv6kv1kKpahx0gt9W/kz8G6wUo8ApJqr4CPmBlTW3rbisbU128eTSKzgKMmRT85OH3Jx+Q4bkKWiuF2ZjGR5RhOphsM3x4bnJOu+R4ItCoDqrGd1ak4/JGlGUrNs4q40YVfJXc4n9r0CotPq+3dEv2xPEz30CVfA4v+L76obDp3utgZxBgltvKamow0uJtzt6wE+28why5c9ud3HW7u2GD1A6NIkxU4MURo6ZlgIim5MnQPx4ZFjqTE9bK/9rmqBLEH/EKYXk8yEk4veR890SOXk8PkfsacNkG2X6l7b5+0aSc+Z35Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=59asLHKQ+xu3XKyQjujvBSK0hdl5CiYz5sKxkOB9JSg=;
 b=RA/lDbnNnqRNXv+mnNY62ppxdCOkcxSpEdJj2hmg0xw+c4KQv3MSO8o2dYOnC1V7bEZ/iYt2ZCB9ezUOC//+o8NUzfQXQEcr6G4CbQ4IyjO18sslvan5pzgS9oTJVkXB9tnHiE+YQXBcKxp4iTFs75BwX9VGIeiY9pgyMavjUX47Ngs5D0pocvmXkyTV8xm5Dpkr362lCw+8X2MHV2UzCvnqKjOPKfE8Pp41PkmhfLzw2VXeMppibwnuV8Ehu6PdwlxtmbNDDQcOdHiActCOEgV0aJoKQA+Qb6W/AF6vddNEbJ/bkLn+TCCszm9mzk9NHZThKnyuWCDpWKgrNzxXAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=59asLHKQ+xu3XKyQjujvBSK0hdl5CiYz5sKxkOB9JSg=;
 b=OdINBdyyoPzHVnoNjNJ/4WuF7aOzjqZ/lMml0h43VXKEdCz6CK02f1ugsnS0xEc3Hf4X+fEVntLgfpx74M9GaoJWu6WLQSQjfu+9siNMfQhB1oZ4y8mdfw7XBqfu3OuFrp+UxtgJnpJNz6XerC4RFl/jj/84UyqjOUBvT5faoRiYRNGXzP6KwZxbXGkAG+WcH8cJHMlFeAPNxX4BsAe61hBzq2yFKDEXbzQAMmomyLaE9oUZEYjNRID96pF9M0KMIprfkP3EpAyF0vmvCKGS+ZKVdhyan0CK35UAzEMEo/sK5wsmRuCZecNdK2N415SxP4xuqX9RdXDI+Fn2Lfus+A==
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by MRWPR04MB11517.eurprd04.prod.outlook.com (2603:10a6:501:77::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Tue, 19 Aug
 2025 08:41:14 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%4]) with mapi id 15.20.9052.011; Tue, 19 Aug 2025
 08:41:14 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: Hongxing Zhu <hongxing.zhu@nxp.com>, Frank Li <frank.li@nxp.com>,
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Hongxing Zhu
	<hongxing.zhu@nxp.com>
Subject: RE: [PATCH v4 2/2] PCI: imx6: Enable the vaux regulator when fetch it
Thread-Topic: [PATCH v4 2/2] PCI: imx6: Enable the vaux regulator when fetch
 it
Thread-Index: AQHcENnY8No0OpFLykiOlzSNqvA2QbRpqARw
Date: Tue, 19 Aug 2025 08:41:13 +0000
Message-ID:
 <DB9PR04MB8429F4EF7F195825C7004AB59230A@DB9PR04MB8429.eurprd04.prod.outlook.com>
References: <20250819071630.1813134-1-hongxing.zhu@nxp.com>
 <20250819071630.1813134-3-hongxing.zhu@nxp.com>
In-Reply-To: <20250819071630.1813134-3-hongxing.zhu@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8429:EE_|MRWPR04MB11517:EE_
x-ms-office365-filtering-correlation-id: e5d6804f-af0b-49ce-f370-08dddefc27f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|19092799006|366016|7053199007|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?2NAsBKwaWnWM0wO60ex+W9Jyq7dSPu1oCqlzYukTKAh8DuUdGq52utigXlt5?=
 =?us-ascii?Q?MZYnAEm0q9FJFgVqjGIFakWJ/XWHBJwfL03HwAJckqCXX59+Dqciie69Zaf4?=
 =?us-ascii?Q?yUz9KRu3wO5SYEwZaMwaXFs7kybK62oUY2f3a95kHeuIFs80RtVqGJmJuEyo?=
 =?us-ascii?Q?HrbiCsxurotLNDxtQ8W2nN2e1V9kBhtSa/bFgaLrWpC8H/SQ7WKi/YDnqha1?=
 =?us-ascii?Q?AVQT2AGVzCEPi8qKkfBvECjukvbMByphoB9rfEGu7mx861aj5NnDBaBB0mOg?=
 =?us-ascii?Q?fnjQYzd4B/NpN546dzhdFjPFkGT35qW/rAPWdbYiG/y3STr/5EWrWBnfB0yu?=
 =?us-ascii?Q?i4RXRrbKqOPNrDOGEXiwDa83wMpGXepUfYhb8laeoFm0AWijrOBPAAbQHc8v?=
 =?us-ascii?Q?yXU+hKMeKO7ge00N2b1u4mbMh3gffrJhtQEC8PFS9Bt+i4f0pzNuTrj0sOd0?=
 =?us-ascii?Q?d/jNI/xwnAcxttjn6HL8ulQ3WQqOPYVjIuQ1j71ee4spVz7l7FuRB1kjXfw5?=
 =?us-ascii?Q?+0IPd+iMiPzBeUomWLg/Bm4faJpZGTpxFh83MmN1cm50DNk3+kYzmipf7eOd?=
 =?us-ascii?Q?ob8GTx057gvgnSfIoSi8Mgfcclq5Pmvn+qPouao/QrWuSR7hQWk66Zz5/wci?=
 =?us-ascii?Q?OdJujNTmfq5XDyrOW6+FVDZnRqwt4iN/c/7yXBbWAwKgveObOkcbuOzWva5L?=
 =?us-ascii?Q?+use9zhh/D23aUYCtzifzEWMOdojozG2lURbzhsGsjS+eCFsrT5nWI1/6ru7?=
 =?us-ascii?Q?bEKX7afJe7fQdIC6ZsGro62mrOWRun1rWV1pT5GLjGHoZ+SfbTT6Z+x0WQDW?=
 =?us-ascii?Q?Hm+xPQazvJ4LP173r+lO+nIQCLWmsdnafPn3kxAuK05ILJUoD+5wWHdg7cz9?=
 =?us-ascii?Q?mD75N9nx9MHgsoVCla70YhOj0V1CUIpB8TGuZGSlaUlQthRnMqncf/wRQ2OY?=
 =?us-ascii?Q?QKav5AdLH16gU/fmG/xR98i2v2SZZCafL4eDQnoxcypzZcNcsLakpFr8DJ5i?=
 =?us-ascii?Q?9IlMXwsazcu9j6L3HxcyP5tkllLeJQJmtu1/PnvLZIpTTfcNfmDnC5mwA4OR?=
 =?us-ascii?Q?vKquJz0JtTidd1nqG/RPhZomsM8LH8wX5uM2YK02As8sjkLn3M2kWUTKQbhE?=
 =?us-ascii?Q?q5o6ChlV1dMNEBEQufTkjmBIKXJAT0YOIy+QwScdngoalmbGM/hAzpwt/Zw3?=
 =?us-ascii?Q?qnktv5mfTM196QzNFIvDr/7IC73Uxt7xnzCuSZ42NlnOKemwqSqdb177Pb5g?=
 =?us-ascii?Q?ggqQVjf9vl8i9Nps+LIniBVx/lOM1IP/ZXN00NkkQSeie5aOFA4FXcrhUCe1?=
 =?us-ascii?Q?RE7gCqAaHoiPBYNKda08llWdcFRLqdcVi58E3qPldo8DF+6/56V3XYHRPJ0T?=
 =?us-ascii?Q?9XyrW/ZGDzq30DvwB2xCLzmSVRFev0btoOtW6PRUMn/ZER1lDg405+E0JmHf?=
 =?us-ascii?Q?QNj2D/6ol495SOXXBjWVj/sJuSK5iwFELCJD5DrBwilpt3+iD2xakUvKIJG6?=
 =?us-ascii?Q?+qNhNsWtK3OyhoE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(19092799006)(366016)(7053199007)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?5Ev0VoWa/ioHP4Q36t3+SLDZ0TR91eyFgh/m7tjPVN2XPsfn4S+JvpgeRjIC?=
 =?us-ascii?Q?/UfRAFoDqGYUm+dKmogepOYVpsegQdxWhe5scu5JEp2bytQfmgnk83pM1Kxj?=
 =?us-ascii?Q?r37xOPLigPdXQ2xexRGybkOnL2DJ+m4kHrJgbqUQXkOuHCYxzEqFydE/yGNj?=
 =?us-ascii?Q?fBpYIr2NbURwj5kLafR/5LQTMhYSFhPvqbJS7H4WJcBToHDPPhry+SSyA6/4?=
 =?us-ascii?Q?/hrXyom95mIJuEdz2vnd3wPTrWu5jo7fHZAO0o6KXsbHo/p2f+N49607o5Yp?=
 =?us-ascii?Q?P+CZam49o/Wu+5YA5Fes9r6ElzjeYiKFn/bzaQSV7Mt01qPSF8FF+hVF3R6f?=
 =?us-ascii?Q?dszQqQ0y6YqCTUn5gobD3v0kZsmcmdvHBXMvrgQCQ/cKEMLAv6E84sjoxfd7?=
 =?us-ascii?Q?5damZZrd1mFv0j6ZslxZXtxmz3OB9FtCxHRZOFkyd7pQWCVWJW+m6IMSvYpC?=
 =?us-ascii?Q?ikjUMSsPlHT+kstaPrvwG3KJe3oCFI5ECWPTySsY5sdMlF9wKcalOweBmdz1?=
 =?us-ascii?Q?UaBGprX/cmr3HGoMMuAdo+yoP9pjh8Dse2atmo2+qto0ykgIXZlkCwBXXS9c?=
 =?us-ascii?Q?oJ7skgXkpljS8AArlyyCdNtgHO4w4ZsS9CezJN2+/U9n2BeEzKEu2VatoKSv?=
 =?us-ascii?Q?RmYGdr3V7B+0dr8za79xe2JYYK3TmztgkNZonNKfYd/bsGOVAj1DjLOZhlRH?=
 =?us-ascii?Q?b5IzmypDbd81UPaXUwTLsXS/pXVeU7sijkWrk8Ag4dgugNdIUsKMnpfoeh2/?=
 =?us-ascii?Q?UNvXfgz1S0M+c5EOsQ8DfAarAXgOZfRCBLm7wMQfAF1xn2aDmE5W57APC8V5?=
 =?us-ascii?Q?d23Zb5hPGCeNJ0R2+9jO9vefAxKQJJQP7gM7cyOyrekUAA3orSlxYJg0yMEe?=
 =?us-ascii?Q?8fuci074L4H/djQxvGRViPO15XaXIcQggdEj48hDtoRgBP/jW6Ch2KVVrDVl?=
 =?us-ascii?Q?ukPqBEiXpT15SqWgnsdZyR0K+fXfSyco4F9oWZhTNSFQsxywp/EZwKftCThf?=
 =?us-ascii?Q?wa2PcQIQmMkAPc7mGYzNMSKr5LqkTZiuI3gQsDIVQOwjyu44mEMCSsInu5p/?=
 =?us-ascii?Q?SjcY2O1SlSii4JDoQggapUXaycIf9oYuyc2edpuyOEnBgI1xCpefvkkJnnMC?=
 =?us-ascii?Q?/5liCLErimzfVGBPKA5x5hNK98yTqw5YwvruiCJzbxVDUEkcAYGsV2fCPYPJ?=
 =?us-ascii?Q?jHriW0qsFphKlZkzSVchO5vsGgxHfptqtF1qEcWyyZJeD1A8z4YT0f6KUiJQ?=
 =?us-ascii?Q?rBIRMHtjfxah2PPW8VHDk72MyMH56HzxCUBIZF8dx9nXYkoHkM5oB6OqLj8X?=
 =?us-ascii?Q?n84XRDdHGPziXvcm8SiEEUHxVE2/vTu0eciNIAiFRKSlS4lZJB7ksk78xNS+?=
 =?us-ascii?Q?PLZt2SruuJqTl5tyKd1t68XwUFOYDyxBN0zBltRDyDw1Q3BHYOBqz8WBd3GW?=
 =?us-ascii?Q?wke9biF/BUP4SjS2OLLj7niZuBMtEto90CzNyYp/RhOFa5+erfY3v09WpUy3?=
 =?us-ascii?Q?umUicddk98UyQBSiS+b4C84TGigsRmxobFx+FC8XOrpdKa8/rF9/vsRI5u2d?=
 =?us-ascii?Q?Vuj73eHXZ7JWWcTuAKfnO1Y9C4PsCo0ZdP1+n3kz?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e5d6804f-af0b-49ce-f370-08dddefc27f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2025 08:41:13.9549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hHK6K5mizzJdj8OohTC27R3cduR3dpExOf06Dr9NthDKwhgiq4RMGinUTY6liE388uCzrwRtBoUtvvwV9NPI+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB11517



> -----Original Message-----
> From: Richard Zhu <hongxing.zhu@nxp.com>
> Sent: Tuesday, August 19, 2025 3:17 PM
> To: Frank Li <frank.li@nxp.com>; l.stach@pengutronix.de;
> lpieralisi@kernel.org; kwilczynski@kernel.org; mani@kernel.org;
> robh@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.org;
> bhelgaas@google.com; shawnguo@kernel.org; s.hauer@pengutronix.de;
> kernel@pengutronix.de; festevam@gmail.com
> Cc: linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> devicetree@vger.kernel.org; imx@lists.linux.dev; linux-
> kernel@vger.kernel.org; Hongxing Zhu <hongxing.zhu@nxp.com>
> Subject: [PATCH v4 2/2] PCI: imx6: Enable the vaux regulator when fetch i=
t
>=20
> Enable the vaux regulator at probe time and keep it enabled for the entir=
e
> PCIe controller lifecycle. This ensures support for outbound wake-up
> mechanism such as WAKE# signaling.
>=20
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>=20
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> b/drivers/pci/controller/dwc/pci-imx6.c
> index 5a38cfaf989b1..1c1dce2d87e44 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -159,6 +159,7 @@ struct imx_pcie {
>  	u32			tx_deemph_gen2_6db;
>  	u32			tx_swing_full;
>  	u32			tx_swing_low;
> +	struct regulator	*vaux;

Hi Richard, this seems defined but not used?

Best Regards
Sherry

>  	struct regulator	*vpcie;
>  	struct regulator	*vph;
>  	void __iomem		*phy_base;
> @@ -1739,6 +1740,20 @@ static int imx_pcie_probe(struct platform_device
> *pdev)
>  	pci->max_link_speed =3D 1;
>  	of_property_read_u32(node, "fsl,max-link-speed", &pci-
> >max_link_speed);
>=20
> +	/*
> +	 * Refer to PCIe CEM r6.0, sec 2.3 WAKE# Signal, WAKE# signal is only
> +	 * asserted by the Add-in Card when all its functions are in D3Cold
> +	 * state and at least one of its functions is enabled for wakeup
> +	 * generation. The 3.3V auxiliary power (+3.3Vaux) must be present
> and
> +	 * used for wakeup process. Since the main power supply would be
> gated
> +	 * off to let Add-in Card to be in D3Cold, get the vaux and keep it
> +	 * enabled to power up WAKE# circuit for the entire PCIe controller
> +	 * lifecycle when WAKE# is supported.
> +	 */
> +	ret =3D devm_regulator_get_enable_optional(&pdev->dev, "vaux");
> +	if (ret < 0 && ret !=3D -ENODEV)
> +		return dev_err_probe(dev, ret, "failed to enable vaux");
> +
>  	imx_pcie->vpcie =3D devm_regulator_get_optional(&pdev->dev,
> "vpcie");
>  	if (IS_ERR(imx_pcie->vpcie)) {
>  		if (PTR_ERR(imx_pcie->vpcie) !=3D -ENODEV)
> --
> 2.37.1
>=20


