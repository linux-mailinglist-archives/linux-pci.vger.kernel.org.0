Return-Path: <linux-pci+bounces-45230-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE11D3BD7F
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 03:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4627C3004284
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 02:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AE31CAA68;
	Tue, 20 Jan 2026 02:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hGQwiigy"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012036.outbound.protection.outlook.com [52.101.66.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03601A238F;
	Tue, 20 Jan 2026 02:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768875769; cv=fail; b=I003v+vIneVV8JOC9nDKHMvsReC5pPVHrgowBmXKyapRwZlzsOpN+i8jbeD/A/aqOpB6fAKPUIi47zo6W1V8Av5oKg3/xN0GDQtuOgxTheGEKUIl9ICcGvIuDVnpOHSU1CPuNJzeytLOq+tT8tpouNW7LX/SRqljIbA26kz8fnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768875769; c=relaxed/simple;
	bh=KYPze9iOOACX10vtqFEiB6241n0DkR9tIf4vGL7QGVo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aYqo7OeH94Q/Z4dDx0Zdr7m5KEgP3haZzBMSrAjWCtXRqOYye3Wui17pEy5/TCE3c8eh2wJ1kVlBtdHXiWLWvln/xJwpFTdwOF7Rtq6px7UY+wKtRlSoxNZ1gT3oabuUCD0fEwyOvtOdYtacsFDJoBDqEUKZ0oO4p8ibND0lQk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hGQwiigy; arc=fail smtp.client-ip=52.101.66.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s5ANR79hfwgdx/Lrs08IfsyxsUSH4qzWAnMM8QZ1McKm+Da90JljgMx4pqAI3FVzVZMfBAWbhweWgLqYLkZbxj7GHVjnQD8PLovo72/U7Vtd9TnxZRYIjNl9UcOfrCeha11ZNapdOCSOjSGg35aV/b128caU9NtiQ2+rTuQCz0SiHl4dP9FUDRYQgUfnINhm8ICoJuONzSpkp09xIKY4VrDwVp3Debvibw5H33m4s/b234D/6hAd+72/rnOEKwtO9GSrjoRzq0gDrzo3H6GhxSmn8EQXzlde35dYCMaqXsAEDDwVZhpUATqslhzz54v4KpnPv2rn3zianX4eQF72Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cH7Abm51qQxV5PHM1iN+x12BF82jgQ3vJyP9rj/MBkM=;
 b=cXJcHpSGZ5r197zx96pRGhmCbhUmwJHDWAnRcS03c3+tkATRvhzRpPf6qMojfosHbNKMdy5WKZPe0KEMU/WYgiMAZomobcEIIlkNYVrHkzTqVRFYuNXrV38+kh8EsHKsk1LAKdAGb0aRHKGuZzg+/JMfmI5ho3eJ1mBr/AcJ8QUP/k/Qz4XIvMvXbMbApFjlKA3vHZ+Ue7rlxKHINVRw1ZFqn9QJWAZPzPH6YsINNwZTYQStihhd/LjB0gMsD6ooVtJLw9yAWpebBM3EVLQvl429e4N8qshXWcAxOOHGJ0FB1RgaNAqepyKrKhHVdDv9ZUHS+CVcxtG5KXo4oAL41Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cH7Abm51qQxV5PHM1iN+x12BF82jgQ3vJyP9rj/MBkM=;
 b=hGQwiigy7/NcedYO0QXsTNQUnTkbKSkLm9XVgltUlt969SSPlTrCgCnNtXGd6QqVVJUUD1hEryW/7+4dpxPRi6Px8k2z+k3Mt5gKEIGP3FfD1qZEGV2U8a8fvmoMZc1PGaVhG38fH69NF7vWbgyqJagetEqlaP67GxqedzW/a/sogb1hINuivCk9C/iI5+S+WAkOsHICesa4WtdSoDzspw/HE5c5LuVzhJfko7M8y2E5lyXLd2Yoj4QHio9Dl2pEVBkhOvVdZjNLVxVDfHosNcPoz2j6fFXMyOqpM7CfENgNkJqkI30d6UpdqOZPDJM31EmhUDP2aOzaqrQjBoJdAw==
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by DBBPR04MB7834.eurprd04.prod.outlook.com
 (2603:10a6:10:1ee::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 02:22:44 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::2943:c36f:6a8c:81f7]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::2943:c36f:6a8c:81f7%5]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 02:22:44 +0000
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
Subject: RE: [PATCH 01/10] dt-bindings: PCI: fsl,imx6q-pcie: Add reset GPIO in
 Root Port node
Thread-Topic: [PATCH 01/10] dt-bindings: PCI: fsl,imx6q-pcie: Add reset GPIO
 in Root Port node
Thread-Index: AQHciSrkYtB9tLTqMki47vkTAR4KwbVZqzCAgACpbFA=
Date: Tue, 20 Jan 2026 02:22:44 +0000
Message-ID:
 <VI0PR04MB12114BBB33DD944C2175868329289A@VI0PR04MB12114.eurprd04.prod.outlook.com>
References: <20260119100235.1173839-1-sherry.sun@nxp.com>
 <20260119100235.1173839-2-sherry.sun@nxp.com>
 <aW5YhTaclPKB9s14@lizhi-Precision-Tower-5810>
In-Reply-To: <aW5YhTaclPKB9s14@lizhi-Precision-Tower-5810>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR04MB12114:EE_|DBBPR04MB7834:EE_
x-ms-office365-filtering-correlation-id: aaad6c15-44b7-4b64-0e98-08de57cacbeb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|19092799006|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?DlneMMJoXDsYz7bcfx8w22br4hf1PXhizoXMPjLGKyBsiPCcU0hgqpTjtLG6?=
 =?us-ascii?Q?/PVtxzF5U891CG6ZMjLnD9ky4NNY4UcWTeQq1OS4Jop4LyiibMLXw9S1NoeE?=
 =?us-ascii?Q?W56WyX1KaTY2Poutqr1eSF3Ims2hiYLtmogIgJ5rbl/YIvD3YsKvcf3wXgSP?=
 =?us-ascii?Q?sGj8mx8cR8xpl2PYWQVr81IchVufaZpuzDFJF9LUq0aO1dyekR1PeTrnNJSB?=
 =?us-ascii?Q?PUU8p4loIBO9iHK4922/rpwZ15puoAQD0nYMcrDtQbG0I6LU5ipmX7BKD66A?=
 =?us-ascii?Q?ua0gaYcmwh3RYhB4ehQKR66OCnSFcJghrwBrZmSu7ehOvqOxUbXTs5FL37H0?=
 =?us-ascii?Q?98Td3BzOv3D5lmBGjddQT+We2DlxLg02nUO3njUgvwvPee40W+GX7JZOV+HC?=
 =?us-ascii?Q?Nnq1nCH0NKVbqRdtTmwVXcSVxo2mwGPB7mf9QNZumoQCwymVxxaPg9zO/AhS?=
 =?us-ascii?Q?fRByxpS8TkmMxyhbu7NJuguH7ITCbrxCOkYB3zFDedGhKBgJNUrEEfTjR+hV?=
 =?us-ascii?Q?fEZuMw/dwlgvDBRn7dZ3951XZlkiM0aAt+ex6Yy07830ycpw5TSvDuZlANu8?=
 =?us-ascii?Q?q5XdKUDjtfcrnZ1ueNHLQRU/0OXpAYyT8Y8eluDANThU0vGUHrIRT/Pu7Mwe?=
 =?us-ascii?Q?u2EltsHtMKGGtuYlcPeLYUsGeY4QcJm4n6/GbiZdsDgFwY0d6U7PBa3krdvj?=
 =?us-ascii?Q?qX8EAXnX5CKrlzYlqRfYiHmH8yvcgj27XuQ5vOPt9uTgqYBMJovKllie0G8D?=
 =?us-ascii?Q?/q0j0Y/sWObua6dIgDWmLTliZgZQeFj30djBlYqeEsyt2GMOqBq79hg8QrUo?=
 =?us-ascii?Q?dMePS6b5lACl+7WNIKX9/0KyKtGINZ9E8WhDyiGnm1cP/7OIrj7um2ZVaj/E?=
 =?us-ascii?Q?IT4Qg4rwQfFQHSD9bSCxQkPJyQoV/PDtT4/bzjYPrH5n0mfvxYH5Jge9UDsD?=
 =?us-ascii?Q?XaSilWX6bNIqMZ8KKNz+TPKHwMgyH1jtjNDOG6b9/OxDUs/HkzXu38XvUV45?=
 =?us-ascii?Q?n0hCWpjKXcQ4HIMx5jqoZFhZQH/f3EYzEsBmrS5SFub2jSdm7pchVSEzVuff?=
 =?us-ascii?Q?LzZX1BcfFkW7Gyuhh+XSxFs/vaJdIRrnQiCSeuJvEoLJvGU8FHsSDOvMGLFO?=
 =?us-ascii?Q?lmGZbJLvN8kuTKT9ET/dhMcRy+fYSc9HUQvnqO9fH+5yrQkuWvvR/tenAeml?=
 =?us-ascii?Q?Jm2oyMyzP37JkhRkf4TFnrpTfMquFxjOa5LoUl95RlwPZZKLGF9feN0osc6p?=
 =?us-ascii?Q?lEviU6g48mCt1Z+SImkLwJ/5uX/qRQyCu+1/u2AsCMeHusNJIZEYL6UK1RqI?=
 =?us-ascii?Q?KT6yiH+CW/teiH7DwN+1yn/uu9m487CHUJzdFnctKHBHZ8ooVxCQGw5mU/dP?=
 =?us-ascii?Q?DOTHAVwa6o5cFjlKgUlG7yBaGKvqc39A6SoSYX0Y5LcO0Fj/oxqoEo0J7Mpz?=
 =?us-ascii?Q?YHfglWLEQAbGKoJ/+vjVHGigMjEFIyAN2RxjBbNmcko64KN3qwq5hVNg3M7O?=
 =?us-ascii?Q?ETMevsk7iTMXtvEp83ncgR4vSkR8Tdiy/FGRQfYOQp0WmxFan65IE86zVlFW?=
 =?us-ascii?Q?ueYfH19KzrqxViUMDjMjmoMJnUaOdzWH9yLOiR9Ua4n78ZDqAD2g5rOCq4qX?=
 =?us-ascii?Q?41/syL50WDDECLOu4blEGsk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(19092799006)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?d6B9v/Qn+rC5kR9nYMfeOalPUPdxjpGDxeTCd39EOPSH0Gl2fN0L8fZ2ceEv?=
 =?us-ascii?Q?6pcxWVk82MEaWM/2Eg2OX8SxA+TBSIVuPlKNfuHwFEchTcjtwlQnKGFq9VqM?=
 =?us-ascii?Q?XGVRg/uDFwry040mHZQcC8AVRtE44frzrYXVWiitucjXBXkQzfRPI4dlEooZ?=
 =?us-ascii?Q?/3OXsbLO/nSFAKfnf6b2cpwcPfsn84T5MH5NCqNndn0I+jhU2XvDxGJ0XTrT?=
 =?us-ascii?Q?MQYVRH4wRb846G1V+sC+p46eeqz7L66aePvEm3fL3cKqgRADBHjp3wNv4Vmj?=
 =?us-ascii?Q?ZFCFu0tiMg4Ejk1gp8v2et837zQFtItaXjAb9P4emq2jCUohDMzzY2inj/wu?=
 =?us-ascii?Q?Jjaf2eNNaoCnS3hUEbIPa368QPLifiVs5GbT/ytE403UAnAsbGzCId5RB2T1?=
 =?us-ascii?Q?v43K8ydRQHEk51X+GpmElZ7/UOl+0CriXxbQFCmWiYC+cM13XXgsxYIwqldx?=
 =?us-ascii?Q?QdxGoeNIr3PHK0CJq+iwha774CjVoUjL2OA9ib/IjYXmZe7+UhuHsCtnIJT6?=
 =?us-ascii?Q?fk5gjg8zvV95tLpwiiVxEZi3ZpeOJKq8bArF3LkK2oBI9AOFmvLhwWdd/Kyn?=
 =?us-ascii?Q?jbLKp0CmxYeqcGqlQLqbuL5pyfbu+WQbI9qY61l7gSZEWfJTVaMFTpTp1ca7?=
 =?us-ascii?Q?JH8/Ob+EIjT2BPO/mRth/MivsMcK006btk5XB06FlwKIXFSDaC1qs8y6JQIw?=
 =?us-ascii?Q?Scm2EV6tnZJrFzfSC+sEhD3cMVbIHrW+9jaX/TMQ5JBfuqnD6Haq57sLcySo?=
 =?us-ascii?Q?Ov9xrZAvzsCUQXcpDb2MyqmQMeehf5ME53kD7pBkGjQiMKRTr/0Fvh1PQt3z?=
 =?us-ascii?Q?2bTVFAy879eAt5OLPrRkPE3AI7fX3Uz0UKz7yDl50Te7ZAzIq3QhvOFCzowu?=
 =?us-ascii?Q?AdYcoIYfjl6HeYO6yVkcQNd9Qytu5QtTfHZTZslQnslacL7Bw7zmN/NRaGnj?=
 =?us-ascii?Q?rGoOWOa6Xkm0E31uCpLcTb+TNHbKSEG6nLwJ9GTqZSCcApPPs5+eV0pXWNpV?=
 =?us-ascii?Q?4TFVNt/tdQZO971jR7nrrYP09V7rNc8hXHqoD4Y+6+ym+ODvT6ISCC/2+01d?=
 =?us-ascii?Q?kYs3SzDtKouVfXK61HJnlHGSWf4vb1iPAGRtrDI9NSyutgFbSFkOzQMNexiR?=
 =?us-ascii?Q?7gjohsHibpvgN1yrvcuWgxz/MylfjGeAF5tMFK6pjLq0Vf48BZ0QsGwDJXSc?=
 =?us-ascii?Q?xYIluBhD9WuwjMDKsKXX8toRiRg71zQojAoZ+G6nKYI6ttv5I1RsHPMIy+ej?=
 =?us-ascii?Q?6rtb9azm/JxG/xLMH4NqvT5x3+jiL+tbkq6iSVokfEXYSNpIcMhUNbrTMn5B?=
 =?us-ascii?Q?B/oLDCY0CV8mL4PhyT7EE5R5YJHOhdi3BpCALtWTmB80xR4VvGNC4qPuBTSW?=
 =?us-ascii?Q?JixsrJyw8DIc3y2S3t7rSTbzFqXojJKPqmPxQNcd/1YyQ2vTR6xhhCpXrjoj?=
 =?us-ascii?Q?UizrDJywUzixa2xEVL44Svx10tq96vQob7pZR8WpY/l7LFMxOFO4PWnaITjB?=
 =?us-ascii?Q?rUZShXZJuaE2eolB4Lm1SdYNAjn2RGMbXShMisCsHAzrWDqLIwIYNUCbR42y?=
 =?us-ascii?Q?NcftXAsASz5PLHxsgqkjIp+vo+VEsV/bVWBe/P/xI04bFJCjTijh82KUrS44?=
 =?us-ascii?Q?vAGyIPFYGAxM7fHHX1s6q/mc8FOuuk/g6dknWDOJy5LJzhj+K2+1vEhDEdKn?=
 =?us-ascii?Q?BTcUeUMPm5wCTTZiLx32XqkEEwaIkfE3RjhxEC2w/AoB9GcQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: aaad6c15-44b7-4b64-0e98-08de57cacbeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2026 02:22:44.8905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rC3/EvkDAIWvFksHh7oRV0lALHw4JRE8E4i+sYg11qpGVnS3+7EEyEXbrAYw3EWwntvwLxNxKqsTxfS/NdRsag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7834



> On Mon, Jan 19, 2026 at 06:02:26PM +0800, Sherry Sun wrote:
> > Update the fsl,imx6q-pcie.yaml to include the reset-gpios property in
> > the Root Port node.
> >
> > There is already 'reset-gpios' property defined for PERST# in
> > pci-bus-common.yaml, so use that property instead of 'reset-gpio' in
> > this file, for backward compatibility, do not remove the existing
> > property in the bridge node, but mark them as 'deprecated' instead.
>=20
>=20
> Update fsl,imx6q-pcie.yaml to include the standard reset-gpios property f=
or
> the Root Port node.
>=20
> The reset-gpios property is already defined in pci-bus-common.yaml for
> PERST#, so use it instead of the local reset-gpio property. Keep the exis=
ting
> reset-gpio property in the bridge node for backward compatibility, but ma=
rk it
> as deprecated.
>=20

Hi Frank, ok, will improve the commit message in V2, thanks!

Best Regards
Sherry

>=20
> Frank
> >
> > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > ---
> >  .../bindings/pci/fsl,imx6q-pcie.yaml          | 29 +++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > index 12a01f7a5744..74156b42e7a2 100644
> > --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > @@ -59,9 +59,12 @@ properties:
> >        - const: dma
> >
> >    reset-gpio:
> > +    deprecated: true
> >      description: Should specify the GPIO for controlling the PCI bus d=
evice
> >        reset signal. It's not polarity aware and defaults to active-low=
 reset
> >        sequence (L=3Dreset state, H=3Doperation state) (optional requir=
ed).
> > +      This property is deprecated, instead of referencing this propert=
y from
> the
> > +      host bridge node, use the reset-gpios property from the root por=
t
> node.
> >
> >    reset-gpio-active-high:
> >      description: If present then the reset sequence using the GPIO @@
> > -69,6 +72,18 @@ properties:
> >        L=3Doperation state) (optional required).
> >      type: boolean
> >
> > +  pcie@0:
> > +    description:
> > +      Describe the i.MX6 PCIe Root Port.
> > +    type: object
> > +    $ref: /schemas/pci/pci-pci-bridge.yaml#
> > +
> > +    properties:
> > +      reg:
> > +        maxItems: 1
> > +
> > +    unevaluatedProperties: false
> > +
> >  required:
> >    - compatible
> >    - reg
> > @@ -229,6 +244,7 @@ unevaluatedProperties: false
> >  examples:
> >    - |
> >      #include <dt-bindings/clock/imx6qdl-clock.h>
> > +    #include <dt-bindings/gpio/gpio.h>
> >      #include <dt-bindings/interrupt-controller/arm-gic.h>
> >
> >      pcie: pcie@1ffc000 {
> > @@ -255,5 +271,18 @@ examples:
> >                  <&clks IMX6QDL_CLK_LVDS1_GATE>,
> >                  <&clks IMX6QDL_CLK_PCIE_REF_125M>;
> >          clock-names =3D "pcie", "pcie_bus", "pcie_phy";
> > +
> > +        pcie_port0: pcie@0 {
> > +            compatible =3D "pciclass,0604";
> > +            device_type =3D "pci";
> > +            reg =3D <0x0 0x0 0x0 0x0 0x0>;
> > +            bus-range =3D <0x01 0xff>;
> > +
> > +            #address-cells =3D <3>;
> > +            #size-cells =3D <2>;
> > +            ranges;
> > +
> > +            reset-gpios =3D <&gpio7 12 GPIO_ACTIVE_LOW>;
> > +        };
> >      };
> >  ...
> > --
> > 2.37.1
> >

