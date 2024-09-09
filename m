Return-Path: <linux-pci+bounces-12937-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2AA970B6F
	for <lists+linux-pci@lfdr.de>; Mon,  9 Sep 2024 03:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 908FE281670
	for <lists+linux-pci@lfdr.de>; Mon,  9 Sep 2024 01:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60BD1173F;
	Mon,  9 Sep 2024 01:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AOXvRJnS"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011048.outbound.protection.outlook.com [52.101.70.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9181101F7;
	Mon,  9 Sep 2024 01:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725846227; cv=fail; b=rEPz4a2L3YtfnB9o8dXrcGlQAb1Z/UrAxniiX1RCow3yYhYK2dA0AvdPXXXM2ZpxWNDbXoH7hpxLJMUxqB0hqfFtXFvLcDN5myL2M0L09SMAXiWLqNyncEMpI3VIdpu6mznymKFxJvvGYDXsWT4Ot1zOglQl2NeekIhaBKffIb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725846227; c=relaxed/simple;
	bh=ItBKqVSFWZ227otjxLSfGMwTy5UhL9lRNoQbryK5b1k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FBfwpuVLIfu6r9wfpX5b/zRZtjiP9VGC21abTyWWshrqR/nRnwmSmbRqTTmO7wtIPHxj1JFeNakXNq+gdWGbGr7U5Ucwxz7XWGYVyz0Lw8aJk5eNAYQSmTW8PFO4Itv9LdMmKMpptfg8Xf5MMmtXsYMI6Rh9JxHfvvsU1w3Quo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AOXvRJnS; arc=fail smtp.client-ip=52.101.70.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TWp4B/GP2MuYVARu1PLyLHxXeVU8MIKV7lOXh3x+cqBq1yyTU3rUwCMYg25kXJ/DwlnsdwqCsSfVZkTdiPUypBu0Xbu/2DZozy4ussdv/+JVHC8ik4h9/gdfD7zYVOUlfpAyLMx/4yGAynlBwbZd8EiHhBDF6FBOTrAo0c1vK1QwagWorggTiHEc+4NvRO+Y0WJR74+eT+eFI2KMIGCNKEAvIN/8PKw+Y9ZDXtPEjo0HQIJE/RQ+lB6xEi78ASZjYA4yIgxIRyUt4ucLGbKtdrvT3kXRwUY1e0ohEexafQmMbi8B+fRXV95TDDcNxhNRffqA1T88gmUx3C+WzB/Orw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ItBKqVSFWZ227otjxLSfGMwTy5UhL9lRNoQbryK5b1k=;
 b=CMkbXIOQrEuoCZ725GdU50krASQn2q5eS1JJChB9PZR8tqmXRqiUxyzzMGhhdORvHP3SAQYmVtlkUb6ri/oByC/7coTv3MDrbFcrGZRImazsu95UjW56U9O2RAfN8RRYKqfs/YUYzxRWn1WE1oz+16XNaJo3RHZ+Ouba90niVe4IISOiUdh6DbQgdEJJdZZkrslOvXlsflNI9ppcPCZpiwU1Fh3eCA3y6QhGLki/ZT4uumoXtl/goTSA7Uk4VzTphJO5YiUlKXSQO9kOy65ugYD3RyJGgkknXilQw9Fve80qlenf7KATKfEU0EGRidoNlyeaLJ/zCsaQ8/afQgZAaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ItBKqVSFWZ227otjxLSfGMwTy5UhL9lRNoQbryK5b1k=;
 b=AOXvRJnSCTQiZaCLcCGEYKry85IQSuRy4p1zziBwUzwK1lyGckgjvjjxXlfdzF0nd5VAhs+k5slJs/4XJHw6A8YDLOwM2nMKxnuam4LH8XFfQT++QNiCRD4WVpzpaZvizisKcy151LicPiERo4PenCrFJ5YF3c9O/OaScWkLsbBhgdYEaFqwfp7qolYWS5f6cCs3B4uz/KWARuFwm4THjdrArMNuehxSEf9MwP2fR77mjQUvi56dLWEl43+CioC6/qaIN6jb9rxSIo9B1Ce4fTWCimObF+eV51GjV/4dZXgZY2gR1nZgDzRd7VgrGJd/wYyiW28kQtbQv+4fh4JsFg==
Received: from PAXPR04MB8688.eurprd04.prod.outlook.com (2603:10a6:102:21f::10)
 by AM8PR04MB7235.eurprd04.prod.outlook.com (2603:10a6:20b:1d1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Mon, 9 Sep
 2024 01:43:42 +0000
Received: from PAXPR04MB8688.eurprd04.prod.outlook.com
 ([fe80::39fe:cdef:c64:987]) by PAXPR04MB8688.eurprd04.prod.outlook.com
 ([fe80::39fe:cdef:c64:987%6]) with mapi id 15.20.7918.019; Mon, 9 Sep 2024
 01:43:41 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Shawn Guo <shawnguo2@yeah.net>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v5 0/4] Add dbi2 and atu for i.MX8M PCIe EP
Thread-Topic: [PATCH v5 0/4] Add dbi2 and atu for i.MX8M PCIe EP
Thread-Index: AQHa7VchMMLSKbpmfky4pqFpd8TS8LJBcW0AgAYQTQCAB1ZI8A==
Date: Mon, 9 Sep 2024 01:43:41 +0000
Message-ID:
 <PAXPR04MB86884911B9D2B379246C00278C992@PAXPR04MB8688.eurprd04.prod.outlook.com>
References: <1723534943-28499-1-git-send-email-hongxing.zhu@nxp.com>
 <ZtMUbpBJscWlgkhW@dragon> <ZtgqmCbkD1ruZr4U@dragon>
In-Reply-To: <ZtgqmCbkD1ruZr4U@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8688:EE_|AM8PR04MB7235:EE_
x-ms-office365-filtering-correlation-id: 2b38f8f2-e878-4115-a943-08dcd070d5a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?RVZtNk5nL1RpUkxOOHNBdkJDdk8xeTkxUjdCaVpSamN2UCtoa29JTUNlY2tC?=
 =?gb2312?B?TUllbzloS3Zaa0NYQnVLUjJhN3FCcG5nUXUvdm00bzgvdXhIR0pLVVdIK1Uy?=
 =?gb2312?B?YWYzMElFVGxMWFcrRlhHWERZbWlhcmZhaE4rME1jaWxIQzVsQldVMHM4amZN?=
 =?gb2312?B?bktSZFBydjQ0TU5qa1A0bnNwbUxGOWxMcVNLYXM4cXI5UVVOUUJ2ZjRYSWY4?=
 =?gb2312?B?V3MzZU9jeDZtNnpXSERLSFR4UkpoNHFFak5kQ2VOdTFWMXZIYXgwSjZWd0R3?=
 =?gb2312?B?MDBUQjdXbzFxUmVKQStvNmswdzd5OWkydEtYb0I4RCtyNFU5TFRXZVJ5b1Y3?=
 =?gb2312?B?enl3Ky80WGxiQmx2WFBoTHhrTjAzdGhCR1NsZHo5R2c0cWo0SFBXVHhHdUdC?=
 =?gb2312?B?NmhWTTBPbGdkbXQ0cUF0Smp3WEZ2cG1CVWhlOFRCNVFFclNxT2FxQVJZakVz?=
 =?gb2312?B?OG53TzFHaE42YkFwcUt4WDViT2dDZHBTZ0FUdGxtS0xGeTIzRzluYXRqREMy?=
 =?gb2312?B?L1YzUzJIQ1FrS2piZlQ5dk5uYmhFTEtlc0ZHZmFKcGlKYUg3NUdQQW5uaDRs?=
 =?gb2312?B?VGFuaGtEc28zcmRXNFk3NVNzTEZYeHlEUjZsNkdBNzJtWTBUWFhzbWVjZFlU?=
 =?gb2312?B?aDFhcnhpWGxBTHowU2pmUU9uSyswYkU0MlhMdUduV093d1RwR0d5dVk3RmZF?=
 =?gb2312?B?T0EzMGIyd0prTUZFc3ZidkdjdUFXbVJXNHA1SW5ZTUhOQVU1RFVHa2VXZUM2?=
 =?gb2312?B?UXhBdUhZTEdiTFdiT0RLK1JPaWtpL00wbXg3NmlpYU5MUEhPQUFET2ZDREJ1?=
 =?gb2312?B?TkNRZWZ5ekIxRzd1Z0ExSE9LMlJOVzJLcFFvbXlSOFBrS0t3VkRycllEQ1V2?=
 =?gb2312?B?UkxYQ1QrNVNoYzU5R21uZGNXTTJ1MVN4T0Y4ZGR5dlcwNHp4OStJaGFMN1Ey?=
 =?gb2312?B?WlF2cHo5SnJJdE1MOE1GTmlFTE0zMGxEMkxVRktxSi9BZC9wMUJYYnpZNGZy?=
 =?gb2312?B?VTFpRUtST2hObTFiVVRIK2txU0VGdXlXbDZwcDd4aUUrZWxkcTUxRlpqR3lT?=
 =?gb2312?B?c1B2eUlTZThsWGJjZzFsVTdmTWl3YWt2TFZ0dkdNNDVpYmg5b3lFOFhkTUta?=
 =?gb2312?B?ZjJQWGY2emJ6RVc1TDUzZ2NmcVRtcEhsdTh0Q21mU1FHdm1hTnFYODdDT2Qz?=
 =?gb2312?B?bEVHb2J2UEhkMzArbnZQdllVTGxmcjltT2h4aGIvcFJ5WXRaNGJqSXVQcUdX?=
 =?gb2312?B?OU0xWXpXU3p2UzhKUnJocW94OFlHbVZWcmRON01sSmRoaU5kNXZ5K0RiREMy?=
 =?gb2312?B?b0VSazlCbTY3UlFFdXJHMXpNelJSK08xV29MNEw5TnhXS3dqeC9MOUN3WFVw?=
 =?gb2312?B?MjYvS0FlUThQTUZVMGpGTDdCcnkvcU9jcDNoQVREazJUY1VkQmUvY0xtU0FC?=
 =?gb2312?B?NUtLeWdHVHpLT0VJTU93ZG54VWh0YVVhMy8xOS9ReUFNL2N5aGpzOHhGV0xR?=
 =?gb2312?B?d1dEa3hOMGNRcnY5VzE1QnNCeENGMU9jaXY3c0hIb0R4MVlMd3UzZkovQWs3?=
 =?gb2312?B?UHQ1T2pDemRIRWNMbmpRTWdJc3R6N3ZTSS9JTEgyb0FvczFiNXFXekUwNkdm?=
 =?gb2312?B?OTBESUhhVFh4dEVLaGhmUjRiaGsxakNDdHJXb25Va1RFdDlFNFlCYmV1L1Bq?=
 =?gb2312?B?dEpZSlR2S0lqNlRmUmwyMGZ3cklSZHA4bUY2U0tlMnRobXFmUVlBaE5RSUh3?=
 =?gb2312?B?Z24wbHdLUk96cHZ3VklGamdzcVRGK2xyZ3d4NndpYnYwdWh4ZTVkTDZtS0dp?=
 =?gb2312?B?R3FyK0VSVlhvSGg3T292REtDb1RCaXNVaTBKNEgvczh3SDZJRC9scVExSG5E?=
 =?gb2312?B?b1NQWlJIN1hBVCtvSWMxS1ZRczB2QnA3L2hPLzBYeXVUNHc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?aUprYkJNbGQ3MHNzUDlNYk5WWU1IODM1YU5ZRnM5d0FzUWNCbTd1U2JhcmlV?=
 =?gb2312?B?d2M0RFZBQlFwNDkvWkw1Z05Dcm9jYVkrTVF3KzArV2NORlNIdkxxOENDT29s?=
 =?gb2312?B?enlEREkwL0wzdzdtWkFhNkRWcW1KUzFraUFVcGN4L1ZoSFVrbklVSnpnRlJj?=
 =?gb2312?B?V0ZrS1VqWUZkOGhucldtdEhRVE9zeWhtVmhjaTZsUGJpMkRxSDNabVBBQWZT?=
 =?gb2312?B?cXhXU1FVcVlzUC9IYzN2NWsvZzk2dm1Cc01LYVF4Q0VzUWtYeEJZOGJVNzJX?=
 =?gb2312?B?Qmd1NTBRQjFQekhURkZ2VURzaExqM3FRRXdsVFFrMjlSVitRYXlPUExodDVm?=
 =?gb2312?B?bmRISUg1QlczMTR0ZTR1b2FaRnl0cDRqd0M0RTEzRUgzWVdydG8wL1VTWWlU?=
 =?gb2312?B?MldxYVZUdGVpOHZRV1R4V1d6ZEFBMFRIV0RhZVpjZ0NhblB5R2gyNGtLNzlD?=
 =?gb2312?B?d1QreEozUUFacDJXSU92Yk8ySnAwSU0zYU1pWU9UZEhLQ0pLaHNhbktEQmxr?=
 =?gb2312?B?a0xyUUcvOE1ZQ0dpS2lmTnR5WDZIT0ZpcDkyNFhuVHd5d1ErMGRRajlhYkdh?=
 =?gb2312?B?L25GbkpTcjBMV3ZJSVJ5V3JDZTk2bFdCRlpGSEJYRXZuMFlpcEJEcDNwajRl?=
 =?gb2312?B?VWRlRjFOWU1vbGg0d0xNaE54RGVGRitQSi9jeUd1SGdRci9CRzVhL1NGa0Jr?=
 =?gb2312?B?bTBkYnQwMkJrOWNLK3pmc1RvanRzSTVtVHk5MXZMRCt1RC9Tc2ZxQWJnTnFD?=
 =?gb2312?B?Ump2LzlLY2NQNjVOMDV3cTdyS3BHSEx2NENYQXNMSjkvTFJteVQySm11Mmcz?=
 =?gb2312?B?VVJpZjUwV1dXRkY3VFk2L1picCtDaUVEUUxqM0FuLy94R0daUVlrQStHOVRq?=
 =?gb2312?B?RmszN1lLd1cvbGpIMmtNUFNNUDJCRW9xNEh2c0NaenlkYmRqaEN1encyc1do?=
 =?gb2312?B?YVJEcGhsNTFZSnlBRnZOU2ducjFhMElOY0xwbENBNzVhZDQwTmZwSlBOWGdO?=
 =?gb2312?B?N3RueFBrc0VtVHhlOVlOL2ZEY1F4VTdOckYyVFJrQ3locE9XQ25XOGgvcWlJ?=
 =?gb2312?B?d1FtUGxYK0Z0VmJtRlpvamw0VnAxYVpoZGptSFRjWVJQcnBhbFRwNXg1ejY1?=
 =?gb2312?B?NlJUbWFpZGtJdHpldE42ajloOXMyWGtFRWVwWFNocVRNM1pUN284NHR1bXBL?=
 =?gb2312?B?ODB4QnFYb1hOejB6RDdaQ1F4Vm5xQkE0YW54UzZJczhwTW9US0tkM3hQQWdZ?=
 =?gb2312?B?TTRjbTIrVEd5VmxtNHhOYW9ManNZQ2ZZajJFZzh6NDdrbDRIRmFoN3p3NlVz?=
 =?gb2312?B?aDRQdlNiR210QzMvYTBvcnFXSEhYZFoxQ1BjaWV5NEg1NDcxV1Zaa3IvRTFv?=
 =?gb2312?B?NlNnU2lxMzZrVCtSU004TzdSSWdjS0x3dW05dUdPVU9BMXdUZWk3L3pPejd2?=
 =?gb2312?B?dE1xSjhYVjBlQ1VuYjh0cWtxdXcyVE5oR1FaUXBUQUxwRkZBT3NkK0phaEI4?=
 =?gb2312?B?Wi9CWmdDcHhHTGV3MlFoNmxxVU1KTjlkWHhHQzRmYlJjdGVHaUxHb3Jrb2Zp?=
 =?gb2312?B?SjVPUnJqWXV1OVNBeGxqbEV5dDRkUGxFQnlCUENNWGVpT3JLT2E0bnhxVWEz?=
 =?gb2312?B?dGQyQlhkaGoyKzgxVzNOTkZpODZ6MGExYWxxNlVPaTdTdkJDaW12Vno3dkdq?=
 =?gb2312?B?MnJMdEwxSDluV01va2UyTEtuRFVPUk9pbkFSb01YRURGc2R5eU85VEtnQVlz?=
 =?gb2312?B?Qm1ETnNIem5ScHJoV0ZmWnArL0xtUTB1WG9Xck1iZU43YlNua0FqNU5qdUpU?=
 =?gb2312?B?WUVTQUdCaHh2Rkt6bG14d1ZId2V1SS9YUXFpM1hWUkRsTi9QTTdoZ2ZvRWxx?=
 =?gb2312?B?YzN3bk5TUkN3ZTN1ZStlekdKZmJMclp3ZEtEd2pETUNoWC8xdTUyVlVtM2xv?=
 =?gb2312?B?Q3pGTXVwOXhXR2pNUXJXU0NrZ3d2dndvMHdLdUx0Z2VOM2hGd1hHbnA0bG9x?=
 =?gb2312?B?TE1xbTJmMTIybTgxRytzSU5PUnM1YnVwYVcwb2V3ZHE5YTZhWStISnVBWEdY?=
 =?gb2312?B?MkpQc1crbFp0MFZ0TXZiempTZjgzdDhDbkx5d01GT3B1ZlVuVEZkdjNoUVFu?=
 =?gb2312?Q?WjMPNuVZV9gduh9wK+abwNwJe?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b38f8f2-e878-4115-a943-08dcd070d5a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2024 01:43:41.9104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z46mru2rYzfiUKkRyOhWB8VoVxtHPgzS62UW3fQJ3sU9Zdq9EjbbB5b/TbszydOvohB4+6hOAm4/Asx5aJ1cyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7235

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTaGF3biBHdW8gPHNoYXduZ3Vv
MkB5ZWFoLm5ldD4NCj4gU2VudDogMjAyNMTqOdTCNMjVIDE3OjM5DQo+IFRvOiBIb25neGluZyBa
aHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiBDYzogcm9iaEBrZXJuZWwub3JnOyBrcnprK2R0
QGtlcm5lbC5vcmc7IGNvbm9yK2R0QGtlcm5lbC5vcmc7DQo+IHNoYXduZ3VvQGtlcm5lbC5vcmc7
IGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiBs
aW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGtlcm5lbEBwZW5ndXRyb25p
eC5kZTsgaW14QGxpc3RzLmxpbnV4LmRldg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDAvNF0g
QWRkIGRiaTIgYW5kIGF0dSBmb3IgaS5NWDhNIFBDSWUgRVANCj4NCj4gT24gU2F0LCBBdWcgMzEs
IDIwMjQgYXQgMDk6MDI6MzhQTSArMDgwMCwgU2hhd24gR3VvIHdyb3RlOg0KPiA+IE9uIFR1ZSwg
QXVnIDEzLCAyMDI0IGF0IDAzOjQyOjE5UE0gKzA4MDAsIFJpY2hhcmQgWmh1IHdyb3RlOg0KPiA+
ID4gdjUgY2hhbmdlczoNCj4gPiA+IC0gQ29ycmVjdCBzdWJqZWN0IHByZWZpeC4NCj4gPiA+DQo+
ID4gPiB2NCBjaGFuZ2VzOg0KPiA+ID4gLSBBZGQgRnJhbmsncyByZXZpZXdlZCB0YWcsIGFuZCBy
ZS1mb3JtYXQgdGhlIGNvbW1pdCBtZXNzYWdlLg0KPiA+ID4NCj4gPiA+IHYzIGNoYW5nZXM6DQo+
ID4gPiAtIFJlZmluZSB0aGUgY29tbWl0IGRlc2NyaXB0aW9ucy4NCj4gPiA+DQo+ID4gPiB2MiBj
aGFuZ2VzOg0KPiA+ID4gVGhhbmtzIGZvciBDb25vcidzIGNvbW1lbnRzLg0KPiA+ID4gLSBQbGFj
ZSB0aGUgbmV3IGFkZGVkIHByb3BlcnRpZXMgYXQgdGhlIGVuZC4NCj4gPiA+DQo+ID4gPiBJZGVh
bGx5LCBkYmkyIGFuZCBhdHUgYmFzZSBhZGRyZXNzZXMgc2hvdWxkIGJlIGZldGNoZWQgZnJvbSBE
VC4NCj4gPiA+IEFkZCBkYmkyIGFuZCBhdHUgYmFzZSBhZGRyZXNzZXMgZm9yIGkuTVg4TSBQQ0ll
IEVQIGhlcmUuDQo+ID4gPg0KPiA+ID4gW1BBVENIIHY1IDEvNF0gZHQtYmluZGluZ3M6IGlteDZx
LXBjaWU6IEFkZCByZWctbmFtZSAiZGJpMiIgYW5kICJhdHUiDQo+ID4gPiBbUEFUQ0ggdjUgMi80
XSBhcm02NDogZHRzOiBpbXg4bXE6IEFkZCBkYmkyIGFuZCBhdHUgcmVnIGZvciBpLk1YOE1RDQo+
ID4gPiBbUEFUQ0ggdjUgMy80XSBhcm02NDogZHRzOiBpbXg4bXA6IEFkZCBkYmkyIGFuZCBhdHUg
cmVnIGZvciBpLk1YOE1QDQo+ID4gPiBbUEFUQ0ggdjUgNC80XSBhcm02NDogZHRzOiBpbXg4bW06
IEFkZCBkYmkyIGFuZCBhdHUgcmVnIGZvciBpLk1YOE1NDQo+ID4NCj4gPiBBcHBsaWVkIDMgRFRT
IHBhdGNoZXMsIHRoYW5rcyENCj4NCj4gSSBoYXZlIHRvIHRha2UgdGhlbSBvdXQgZnJvbSBteSBi
cmFuY2ggZm9yIG5vdy4gIFBpbmcgbWUgd2hlbiBiaW5kaW5ncw0KPiBjaGFuZ2UgZ2V0cyBhcHBs
aWVkLg0KDQpIaSBTaGF3bjoNClRoZSBkdHMgYmluZGluZ3MgY2hhbmdlIGhhZCBiZWVuIG1lcmdl
ZCBieSBLcnp5c3p0b2YgV2lsY3p5qL1za2kuDQpDYW4geW91IGhlbHAgdG8gbWVyZ2UgdGhlIG90
aGVycz8NClRoYW5rcyBpbiBhZHZhbmNlZC4NCg0KWzEvMV0gZHQtYmluZGluZ3M6IFBDSTogaW14
NnEtcGNpZTogQWRkIHJlZy1uYW1lICJkYmkyIiBhbmQgImF0dSIgZm9yIGkuTVg4TSBQQ0llIEVu
ZHBvaW50DQogICAgICBodHRwczovL2dpdC5rZXJuZWwub3JnL3BjaS9wY2kvYy8yZjMwOWM5ODhi
N2MNCg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0KPg0KPiBTaGF3bg0KDQo=

