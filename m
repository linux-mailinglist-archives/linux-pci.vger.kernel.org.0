Return-Path: <linux-pci+bounces-45231-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A99DED3BD8A
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 03:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C071A30324B6
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 02:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE88927055D;
	Tue, 20 Jan 2026 02:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kqJosMwn"
X-Original-To: linux-pci@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011004.outbound.protection.outlook.com [40.107.130.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268E91DE8AD;
	Tue, 20 Jan 2026 02:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768876432; cv=fail; b=OqHQJyHkGkbHcN6aQPlFoW1etjTGggo4FpN8UZIkONzHnzlkq5W5LyDpOdkPwi7dA+2vgLf8CoOrxi8xwxeR0G4nWquwNfkq6HULhwEzAI9h8Q7MSWX9h5KJoEWtbi0RF18/EG6rAGYT4ESm1bwOGmDqtQ4kY6mrjxYGphbqBgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768876432; c=relaxed/simple;
	bh=eQXx8nyUbE0dp9kpjZ+IR2JF13+EFD7qetzxBrCxaKY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YL+FmFxkcpclY7toBtZ/FwUVOqZwna4ew7gRxRJv3w4APgiW9ypwQqVxXX6PqQP65N4G5Sj6jXBCGUNXBHe2aUeB4+boUzvNzmeOPItuQMFybMtZuWuQphm9jRlpDldubh/hLIHxCQ1HoVHGPpFBilt6mJwRB9D7geqJNdF0KtM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kqJosMwn; arc=fail smtp.client-ip=40.107.130.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FfaFyGTSciTe5PdroZTvZJJQ5r/EN7uXNVbOnMzqJun6cdUqx2BbF2uynqGT39kXz1i9RRXxku+q3wL7ogCSeIxBaK/9CZyN905bSKriszTCjcY4wwaaVeQRSCqSllqoZADjIX73/tZPHTg6VcTnXUai5lz3WcZbmAe7ErzTgeCxAsDcMf3I9lIn0tbMLgfJqbU0X+hObrPX59yjxmIztGDHw2jOoIxv5QeJfeL4+39vCKAWbmgIVgF5plWYDVCNsHV9c0w6KUlgKP5aLsTvq6l9HLwB2zaPZcazravSdzuVrBHMLXVJOTKiMPK04EfnM128LVoOrrb7qiI/nxJn5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ZV9LlNjHnrA+QUIo45lAKQVHwsjflS4oNwIfP+VMFA=;
 b=t1PRqgunzCIwXSXYrQhERCUotVvFavU4Ymi7J3PxkfnZKooFrCN57hSLd1miXCjGe/i6HbSmotk4YvyGCeukCPPjyq8tHLbqeybEeyseKP5+Rxng2GAglpv9xLEe8UdbeVjsaYTjpy/xGDbGrpln5ZEhL2y1BykaEK7RHDDHlD20Kg8Jl19ZHGcc7SZyXryUAyYuCfxP1H4FxK213iTjk9LOcFiaUE15OLMv+CYjb++tPxZ12U1PKpVpGSJmCWNlLezW8jTeaPy8ISAx3v2d20jnvzVBR8bJ4qxmaEhHe4VWLpNHGIhRndx7kvyJWpnknZ+pCMm7yOJlFCBnlkfwcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ZV9LlNjHnrA+QUIo45lAKQVHwsjflS4oNwIfP+VMFA=;
 b=kqJosMwni/WK9eJrSURr0AXk/c6ZjyYZ5motRhPb3014KdsK4EeetBQEFgZHnjpHjowHBd13tTHcjUr8SHn41u1VZ66E1NFeMfZrSMb4XCFy1QymPqVJRj9a4jVn6EPVEk6Z10xtZaVE1Xi2j2KkY3GmZDPxDoj+DfT3cU/5nfYVcCLUVIjEj8V7odf1stv1WFyrWnFw4/JlMA8vcS+dCA2cwDAn37Tt6/JL6uyEtzMr6HtD1hxFfOS7qvbnEpp1nce/WNvOOqJuBOvyOQPLK8OF8HSVAUMRPr5TZZtnVciOoBc9QrBoZ4Rn63WiBW4cAcHLRdOj79oOyy//yuH6VQ==
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by DBBPR04MB7834.eurprd04.prod.outlook.com
 (2603:10a6:10:1ee::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 02:33:48 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::2943:c36f:6a8c:81f7]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::2943:c36f:6a8c:81f7%5]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 02:33:48 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: Hongxing Zhu <hongxing.zhu@nxp.com>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org"
	<kwilczynski@kernel.org>, "mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 02/10] PCI: imx6: Add support for parsing the reset
 property in new Root Port binding
Thread-Topic: [PATCH 02/10] PCI: imx6: Add support for parsing the reset
 property in new Root Port binding
Thread-Index: AQHciSroxmdJRjlrYUmXXxXkw2R9yLVZrUAAgACqjiA=
Date: Tue, 20 Jan 2026 02:33:48 +0000
Message-ID:
 <VI0PR04MB12114D934321FBE66469775DF9289A@VI0PR04MB12114.eurprd04.prod.outlook.com>
References: <20260119100235.1173839-1-sherry.sun@nxp.com>
 <20260119100235.1173839-3-sherry.sun@nxp.com>
 <aW5aQK2z92tBxIIV@lizhi-Precision-Tower-5810>
In-Reply-To: <aW5aQK2z92tBxIIV@lizhi-Precision-Tower-5810>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR04MB12114:EE_|DBBPR04MB7834:EE_
x-ms-office365-filtering-correlation-id: 9fc9d700-eb1d-496a-ed1b-08de57cc5739
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|19092799006|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?/Q/Wy/kcyNJsqmxFpAyjkO7GXnpOHOKr47jbPi53/rlxaNZuo0ipqO9TQPsu?=
 =?us-ascii?Q?mjyBaVBnjWCcRIB2PoFKIbtTHePUqffC+TNk6Va1dbyFhNx+YJkGFsxWRnh+?=
 =?us-ascii?Q?euiVSqGZqPBROpZUpQPYtWutGFYOvQyNMhvPtziiefA6c23GuZqFxYBJgDnF?=
 =?us-ascii?Q?NwCGShHLzJVg1FvaiscllP9TixWGklVlhi1NgRBqr3vjesS9cxpS8e8SNmMB?=
 =?us-ascii?Q?KkaySnM/d/VrnoNdyo6m4k83wxt+k2KCVQt+CgZDv8jAGBEhEP5uJJ9ty/Fw?=
 =?us-ascii?Q?0CAvmBy/fSpMhmSlExWBmEmqFJD4Pq39857dyiLkFnAEPhz/r5BXKyNebLxG?=
 =?us-ascii?Q?p44ic8N4xMAd6Pq/p2Hjgs/kdXivS2m0gKi2FPhNyvdCH+VX64gTICXY9QOZ?=
 =?us-ascii?Q?4TYI5ITxMV9IrJhZXDwNz6NnLYKL6K71NE/uqYRSqUfe9eVdvpzBfXaUqrkx?=
 =?us-ascii?Q?7m8IhcQBo0eaU2Qu3m/g4GvmyPIJgk0wnypV5KA0fJwSUvVKkTEp8w79pO4f?=
 =?us-ascii?Q?GJTCJ87nW2WvfuiSSye95F3HYtHmtYqW+y/qBvJDdGqAcFXjsKTgDvudSi9w?=
 =?us-ascii?Q?5YYVRcdPX84FaC3rbhbC/8NCatQLojmlwUr4ZLrMMfx8JVwTGjTtNhGqyyBj?=
 =?us-ascii?Q?pybHMET9ab0Z9ERnSHQ0Oq+C+I4DKmwkoWnKquw8TxEsNBfLXyscIOL69Kqp?=
 =?us-ascii?Q?STopmDdrAeExH5zzicAP/bCgM+FvRhDDCGeUxkuMPeunnD6ZIFsnSqPs3vDB?=
 =?us-ascii?Q?0XUQM8LLV4GKWdNncpPXK8J6Y0RIdMbg6Vpb8QcpMRY8xoSuz2jrms0OefGr?=
 =?us-ascii?Q?32aJdOaZngm33fVI9MojkDbQzwD7t2tygGFcLoSvcA9VWWIoWDsSopCW3RzY?=
 =?us-ascii?Q?Am0xMniduno9vATBwzx6anwG0zMZxzOAYpyBFbD09YmSG2+Px1UhG4g8LLS4?=
 =?us-ascii?Q?6An9hYrdt3/us02QAhZQKQI+gvGLGpxzBy4IyjU6GNp4PwVMddsOLzhzRXPg?=
 =?us-ascii?Q?oFmGM3JFDxyVQT6yEOxr3wTgW85sPb9LmLX7HPF110VQNUcYiWufzcY4B3vf?=
 =?us-ascii?Q?4BTeyNFOoa9zPf2UTyMrxX4hFmH+2/odypatLUvHingRPtTzLrsnHgb8FQ5g?=
 =?us-ascii?Q?64twPSGPSc9LmSAd1pb6t8r9vt9tRRTBgbNuJbClo6MMop5v/QeeJuaZdYRq?=
 =?us-ascii?Q?V6YsmlC97jsQWjo+ZCnrIA3MMqdkm2viagaF+PYpHzSBNmoEJTqQt2w+ww7z?=
 =?us-ascii?Q?pOGR1HHfmZF9jUAgDSkmFTGDU/SBNHyUsfoYg6rBtFf1/ZsmPJRRAvHzAJR0?=
 =?us-ascii?Q?U0C/vzN5drdzGPQI5jM134dpW8fYepRtqUHoOatgv88QE9/l2VZRDhbombkG?=
 =?us-ascii?Q?JkzGSnNNdXFoCRmHEGnaDhm7PCqovyNhiXc/+1AMfk37wpVOQssar27LdOJc?=
 =?us-ascii?Q?e2FZPlrHO75tOIFytsF+g1patwnRCrxfPpZNtsSbW7xzVkyRbK6M1f0NV5U7?=
 =?us-ascii?Q?e/q5c4jePQsFhKwsUfUf++A4QLqNMnr979oi/ZkAjgPna+VGE8ojuEVtbmKl?=
 =?us-ascii?Q?WLHoa9Ng5embz6alCwJKCMESijIlkU79x+TI2MDlXpYGJy8HMqrvAXa9EYYu?=
 =?us-ascii?Q?jlX7y9bVb893UP8xQxBiXyU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(19092799006)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Y6SYlgs+O3+AlUvctvN9JV9qWYvWdqgZ5NcH6wlNxXtRTWEkEDNcKKTrTeo0?=
 =?us-ascii?Q?jD+edHZ2UO1uYRgzYYicaLhlAuxaHpJv5xaPX65L5ytslb37OpwjeBYJupcq?=
 =?us-ascii?Q?BJqktYCgROJafZ3MsvCshMBBjaB42J/yBngfnbOOdPSqIjtdfY4VHosfOGoc?=
 =?us-ascii?Q?y+o+5kwu8gx6DY7NCJthEtqkpOtjidzSl31e/2s+3W+eDhMHM94W4xcqJDlL?=
 =?us-ascii?Q?+EPw3ApbqqH53XEd4nuh9d4IvmyR99o+Be8Jj3Rdkp5KkyQ7/L0qnI60ViIb?=
 =?us-ascii?Q?ypLQ+yGd5SzlFjzPNz+4yx1VJvzc0aLfEg2mGY96cDoi/ni+3TcR19EiwqK/?=
 =?us-ascii?Q?Rr8B439Tlg8xgLg0UR4e3ClVmPput9ZqwDJmjZ+Wj45gBNCt+QmLG8dQOrtE?=
 =?us-ascii?Q?E1pe6OxNMUZrcVdXLAdMeTldvsFifxLAopyMGaCTrIdk/NND/VUlbIIWPR3H?=
 =?us-ascii?Q?GxZm9u4v5JwmE4QDWqlWcHFtxmN6gTcMuaLJ8JuBbTrE4VMPHxn4hO4LeQ1z?=
 =?us-ascii?Q?pErMfkJ8hOKYwUGp3t60hW83fAH9fA6jGnbiuSdl3OZp9NP4q5xaKuWBNV7Q?=
 =?us-ascii?Q?QNzep0LoReEIdPdkFQeXupDHbG3vo7LTeUNjE8t4sxwWEuprEj9vLpRjtYUi?=
 =?us-ascii?Q?el17abeIlx0YxxCnh9rC57S4yZlvSR28E7cuLtt2hnVzK/mqhoAtsKBmom3c?=
 =?us-ascii?Q?1dznK5M2ec7pZ1pTrrT1v2ZXZXcdoFKq9UJJZStg6xyORPBdfb6aHx1gXfxK?=
 =?us-ascii?Q?d8Qv5YqhWKzN0FLQ8/Xf2tuTPzE82nvqNLK69/82sx6KGOHuEUHOyrW3+eVk?=
 =?us-ascii?Q?fHOIjL/FP+/BMftnvhbpCC8dBNquTDGb81bGz+OVmt4OZbF5sypInbNP2RQS?=
 =?us-ascii?Q?w1cekEgpfPMkwmWUsv2rydlL/wVw1f0sVjl8FDs357qJme6PPxG0wud4Dfoe?=
 =?us-ascii?Q?vh3BgOOMrDKxDbsnfYsvZYUoD+vJID5ZjMFJpj2z66p1goMmYdMvGkb9yl+e?=
 =?us-ascii?Q?5/6tKPmWj2sfCALqD+rqzAsSaAD5bD1jsOmVMtbmJ1TqGZJa3Z/DJ5HI70Lz?=
 =?us-ascii?Q?dpOACBlRbB1wmNARRvpKsUbY8Xi20NhiRL8V9TrZr28fvCmYZsITy71/dO7t?=
 =?us-ascii?Q?YM/Mj4ZZ+EnZ7eqjXbnsalre14sqJXm/Qh2fAWbuwagBNxj5v/J3Fu07w9wN?=
 =?us-ascii?Q?YV2o9gg41dcH9b9eAZWhStnS1DNIrV0073aCBh/Cf/2fCfm1JKioIJdYOLRe?=
 =?us-ascii?Q?uqZMMDBR6d4lVmjPvhnU2vzsKb4af25goJQ64r2BfO82XFUsNEg++txX1Znk?=
 =?us-ascii?Q?Bh+oaOd/hMTHW9Ov0fRMLEF5UkdohlJzIzteFZtR7bpLyDeCBalahwIERQVi?=
 =?us-ascii?Q?F1l5SB2U+CCudhze0Ik03bBavzXQwEy2LZpkFJIDUYL80BGv+lM18Sm7aLTt?=
 =?us-ascii?Q?3t7habmOj9P6r9/trMzLHdcJ2mXXDhI4o4qjpOBOK5MnAdPnebfqM/JLkZJG?=
 =?us-ascii?Q?mydcO8tLSMFnHq2xlsYxEmf29Z6fTPVLOteUjjj70yv+sG45ubLpUuD4z1Wu?=
 =?us-ascii?Q?elqeo6tjdJNi39wj5H3Jrt0pMcm0wxYwFWOUsHDcVuNUjYGVAovwcO+ckT78?=
 =?us-ascii?Q?UWpxZ6C+KMMuLfoxu75tLpbo9FJpKt/eRtm1ORJr351TtbRmugd+pnkKrJH1?=
 =?us-ascii?Q?96aN/NOnc5alUuCfOSqhCMRyFZWBk6rs18CyhU4/WWOuFVy8?=
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
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fc9d700-eb1d-496a-ed1b-08de57cc5739
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2026 02:33:48.1130
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 07q2ULqbKVMYReo9tmmp8pPdakIjZzI72Bf2N7o2dFpMq15rMVHMR/zXnKGLizkrXd/lfo2G0JChTPgm5yhKRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7834



> Subject: Re: [PATCH 02/10] PCI: imx6: Add support for parsing the reset
> property in new Root Port binding
>=20
> On Mon, Jan 19, 2026 at 06:02:27PM +0800, Sherry Sun wrote:
> > DT binding allows specifying 'reset' property in both host bridge and
> > Root Port nodes, but specifying in the host bridge node is marked as
> > deprecated. So add support for parsing the new binding that uses
> > 'reset-gpios' property for PERST#.
> >
> > To maintain DT backwards compatibility, fallback to the legacy method
> > of parsing the host bridge node if the reset property is not present
> > in the Root Port node.
> >
> > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > ---
> >  drivers/pci/controller/dwc/pci-imx6.c | 128
> > +++++++++++++++++++++++---
> >  1 file changed, 114 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> > b/drivers/pci/controller/dwc/pci-imx6.c
> > index 1d8677d7de04..0592b24071bc 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -147,10 +147,15 @@ struct imx_lut_data {
> >  	u32 data2;
> >  };
> >
> > +
> > +static int imx_pcie_parse_ports(struct imx_pcie *pcie) {
> > +	struct device *dev =3D pcie->pci->dev;
> > +	struct imx_pcie_port *port, *tmp;
> > +	int ret =3D -ENOENT;
> > +
> > +	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
> > +		if (!of_node_is_type(of_port, "pci"))
> > +			continue;
> > +		ret =3D imx_pcie_parse_port(pcie, of_port);
> > +		if (ret)
> > +			goto err_port_del;
> > +	}
> > +
> > +	return ret;
> > +
> > +err_port_del:
> > +	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
> > +		list_del(&port->list);
>=20
> you can call helper imx_pcie_delete_ports()

Sure, will fix in V2, thanks!

Best Regards
Sherry

>=20
> Frank
> > +
> > +	return ret;
> > +}
> > +
> > +static int imx_pcie_parse_legacy_binding(struct imx_pcie *pcie) {
> > +	struct device *dev =3D pcie->pci->dev;
> > +	struct imx_pcie_port *port;
> > +	struct gpio_desc *reset;
> > +
> > +	reset =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> > +	if (IS_ERR(reset))
> > +		return PTR_ERR(reset);
> > +
> > +	port =3D devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
> > +	if (!port)
> > +		return -ENOMEM;
> > +
> > +	port->reset =3D reset;
> > +	INIT_LIST_HEAD(&port->list);
> > +	list_add_tail(&port->list, &pcie->ports);
> > +
> > +	return 0;
> > +}
> > +
> > +static void imx_pcie_delete_ports(void *data) {
> > +	struct imx_pcie *pcie =3D data;
> > +	struct imx_pcie_port *port, *tmp;
> > +
> > +	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
> > +		list_del(&port->list);
> > +}
> > +
> >  static int imx_pcie_probe(struct platform_device *pdev)  {
> >  	struct device *dev =3D &pdev->dev;
> > @@ -1656,6 +1742,8 @@ static int imx_pcie_probe(struct platform_device
> *pdev)
> >  	if (!pci)
> >  		return -ENOMEM;
> >
> > +	INIT_LIST_HEAD(&imx_pcie->ports);
> > +
> >  	pci->dev =3D dev;
> >  	pci->ops =3D &dw_pcie_ops;
> >
> > @@ -1684,12 +1772,24 @@ static int imx_pcie_probe(struct
> platform_device *pdev)
> >  			return PTR_ERR(imx_pcie->phy_base);
> >  	}
> >
> > -	/* Fetch GPIOs */
> > -	imx_pcie->reset_gpiod =3D devm_gpiod_get_optional(dev, "reset",
> GPIOD_OUT_HIGH);
> > -	if (IS_ERR(imx_pcie->reset_gpiod))
> > -		return dev_err_probe(dev, PTR_ERR(imx_pcie->reset_gpiod),
> > -				     "unable to get reset gpio\n");
> > -	gpiod_set_consumer_name(imx_pcie->reset_gpiod, "PCIe reset");
> > +	ret =3D imx_pcie_parse_ports(imx_pcie);
> > +	if (ret) {
> > +		if (ret !=3D -ENOENT)
> > +			return dev_err_probe(dev, ret, "Failed to parse Root
> Port: %d\n",
> > +ret);
> > +
> > +		/*
> > +		 * In the case of properties not populated in Root Port node,
> > +		 * fallback to the legacy method of parsing the Host Bridge
> > +		 * node. This is to maintain DT backwards compatibility.
> > +		 */
> > +		ret =3D imx_pcie_parse_legacy_binding(imx_pcie);
> > +		if (ret)
> > +			return dev_err_probe(dev, ret, "Unable to get reset
> gpio: %d\n", ret);
> > +	}
> > +
> > +	ret =3D devm_add_action_or_reset(dev, imx_pcie_delete_ports,
> imx_pcie);
> > +	if (ret)
> > +		return ret;
> >
> >  	/* Fetch clocks */
> >  	imx_pcie->num_clks =3D devm_clk_bulk_get_all(dev, &imx_pcie->clks);
> > --
> > 2.37.1
> >

