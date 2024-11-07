Return-Path: <linux-pci+bounces-16210-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B43249C0061
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 09:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FF2F1F2194D
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 08:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D74F19992B;
	Thu,  7 Nov 2024 08:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dUobK3a7"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011014.outbound.protection.outlook.com [52.101.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94699195B18;
	Thu,  7 Nov 2024 08:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730969279; cv=fail; b=UTyuYsVxvBDpHnzOWvQFZwrWPMTEge7bBManvvSKRkHAD4AQfM/sEPVRp6HVe5xOGZB+Jk0vzeobUrDQZV7kFpkjerFhHYG3hM4s7GndzpvX/SmpCRBLrdilc2Kah1W5jGDT/98IV16GQecRvhDuLjrjd8gFLLDk+KWlg1+c/LI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730969279; c=relaxed/simple;
	bh=ugsclbuuKnq3L65xb+/Kym9PH/GRIWF+1WlHr/77Rfc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ds9VPxcpSPVS788Tb6YxBju8qDXWJCEYWyBRcgqnXRSPKZNid4SLxKaup5+dCbFpWwqyxL/rqQentU3ccYf52Udm5osjosX0kMeFnHGwf6MLmWV38dPG9wCYnCzSg2lSrlaIuOA1eZkqkDu/7c5vK3ItNTVWce2aVBZLoJMRieU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dUobK3a7; arc=fail smtp.client-ip=52.101.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oGujPZgaMt2SdgfkZPclGASR2z1j0W5MXQrwcqchRsPQwcAokQKh0ieUhIJ6QWie00GuzdNwDxq/5gKg8ZnX2fGmF8rUTquHpq6S57hQICDp4S+nvcmQ4XhObfxguOxjVFw2rjsPUyPpv3T+sJ0xkUjSer9m5WRd+qxorrL+gA3yMfiETUe+XmDbakq2M0BmXmx4REjbL2R0nAWuVZ/3BmpGZFb8j4RDlvWZNksTgnXZ5huTxer+17dg73YKzTAXM+eGUjgeKbV/ApqV/EYuVb8j3jhXAyag2WHOmn9Up55B2NgUSN/Fm1H2c7w2yvKV6wO56sdZSCx1UvhzZioMGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ugsclbuuKnq3L65xb+/Kym9PH/GRIWF+1WlHr/77Rfc=;
 b=F6UBPzlILm0kd3Rzd4g4+oSohG/fcRPUj/y5rfvKff/KyEyGaMyq0GrjlblnZ25/SgOuUSePqRFdLPVkmejRkGkw6FVEwvRIJxItNcAfM9DDonEQjy6v2Ep9uqxudyeJsmG92w4Bv/52psa6SzJbGwy1PSP2BEoevRCMRqwgCpGgM/BB9jA8juvD00NBr9WObtHNjEJ/zBrxa+Q5huj8FnV+ea8UkjWDpkfyZlSa/p6RkeJyhvoNYg/iCAkfwGUMTSIEnSCwBUXkXF/9UrRwMF6JXhbdqXSdOZ20j5C+jTwPaTaXqVHKoZyveFzgS4W6G2a203T0ozv47X1gOH9ILg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ugsclbuuKnq3L65xb+/Kym9PH/GRIWF+1WlHr/77Rfc=;
 b=dUobK3a7kEUa4RAOPg1jEEoiB8u5X59BRetS35BPjEQLaxCnbMfX8pfNtptfGL7IBlSUvBBTBok3JpVP3Lboour780epzVu5pCgq7AO17NZOcooVzsvzhGcxsvjbuaoDF9lAbM1FVTnkui0q+AJ0NZqxrNgeuGBwYcEiPzh+LsAOtYeTxzQwNHqxnHCFVVHXiX4BdVQp3LYxKjGAvkQ/wLK+KaDPKrYkAtD/qclpZRROggyBx2F5KHUPvxBqrdf/v09jirl4cfCgf3bufqp7oteWNnEtkXt7xwxYWWdNuYThzomIkCTlOJoXDk0VU/NjMfSY/xSE9FyU+qRja1KFpA==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by PAXPR04MB8704.eurprd04.prod.outlook.com (2603:10a6:102:21f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 08:47:54 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%7]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 08:47:54 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: =?gb2312?B?S3J6eXN6dG9mIFdpbGN6eai9c2tp?= <kw@linux.com>
CC: Bjorn Helgaas <helgaas@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "lorenzo.pieralisi@arm.com"
	<lorenzo.pieralisi@arm.com>, Frank Li <frank.li@nxp.com>, "mani@kernel.org"
	<mani@kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v2] PCI: dwc: Fix resume failure if no EP is connected at
 some platforms
Thread-Topic: [PATCH v2] PCI: dwc: Fix resume failure if no EP is connected at
 some platforms
Thread-Index:
 AQHa3AEqv5bRdDxqKkSUwsC4eegPdrKp/GuAgAAjY0CAAV7kgIAAfShQgAAXEoCAABUTEIAAA0CA
Date: Thu, 7 Nov 2024 08:47:54 +0000
Message-ID:
 <AS8PR04MB86765B904FEC1AA88F6F83468C5C2@AS8PR04MB8676.eurprd04.prod.outlook.com>
References:
 <AS8PR04MB8676998092241543AEABFAAB8C532@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <20241106222933.GA1543549@bhelgaas>
 <AS8PR04MB8676C98C4001DDC4851035B18C5C2@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <20241107072005.GA378841@rocinante>
 <AS8PR04MB8676F00E8F76B695772EB3B18C5C2@AS8PR04MB8676.eurprd04.prod.outlook.com>
In-Reply-To:
 <AS8PR04MB8676F00E8F76B695772EB3B18C5C2@AS8PR04MB8676.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|PAXPR04MB8704:EE_
x-ms-office365-filtering-correlation-id: f6b721c5-a9a7-4bbb-cb2a-08dcff08def8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?RjlMSVpQVDlZRmViSklZUndQK1llTlU0eWJHOHVDeVFqL1Q4RDhDUXpNT3A5?=
 =?gb2312?B?TnAvQ0N3QkFwd2w4ZUxIbDJwQkVrZjh0ZXVReElEN3FpUjU3eDlQVWFGVzV2?=
 =?gb2312?B?NDJ6dHRtRGxTQlNqTEdFVnZra3NTV0g4enNDcTJYdUUvRVd5cUJzRGdXNUFH?=
 =?gb2312?B?OHZRZy9sblo3UE93aHdCVWViUEk3bXBZcU5pUFBSdzg1c01oTFo4Q1FEcW9M?=
 =?gb2312?B?WU96RzdEa3AxdzRHN1BxeGZXTVVIQWhsZU95ZUcwUG1RbjdGZklIUDJzTG05?=
 =?gb2312?B?ck1abGNqV1hjWjNiSGV3a0dYbCtwR21ybmpEYVpYY2dtank1S1J0TFlMMTRu?=
 =?gb2312?B?T3ZHanpkbElDUGlISlhXblp5eG11V0FxcGpxN3JYQnkzemlpeTNrOStaTDYr?=
 =?gb2312?B?UzFhbmUzempiOEVSUFlXYnd3d0JlUDRRaThjN0x2SjMxNlVEZEpGRFp1a1Yv?=
 =?gb2312?B?bVVtS1RQZkNabjA5VnpUMEtGSEJleUNBbFZYdXRLc0ttaHdOUjRRMmZUbUxN?=
 =?gb2312?B?VlF6QVZVTVZMeWt0YjBFQ2tIM045cnZuNzE3R0VpMlpPMk42WFlrZ2Jvd1BJ?=
 =?gb2312?B?SlIyRENKSnV4QWxKamNiY1JkOFFZempIZE0vRzZLOU9KcTg1MGQ0YkZxcUtn?=
 =?gb2312?B?ei8ramhyVk8rQWNvQ3BzNnpmaWJJR2FydEIrb1lMMk1oTFhaZjd3MFFqZGNI?=
 =?gb2312?B?ZXpsdGRtYXVHeFVsVWkwdmdnVHVKTHIreUlrTnhJUkVXZ0kraHYrcElEak5H?=
 =?gb2312?B?V29LTnNUUjJHeWszemRRajJuRDR0dlV0eVQ3cmFaLzZoak5WUXR0MW5CQS96?=
 =?gb2312?B?TWJ1RGt3M1JnalV1NDVHNzBjTmRKaXROY1AzR3g2WlMvZ2ZtVjlqbXNIR1NV?=
 =?gb2312?B?eStVZ3ZhamY1UWZZekxHVXkxOU0yNFk5SVFzNjY0NkFEYmZoSUcwQXd1MzV3?=
 =?gb2312?B?ZUxvOVdXa3FHU1VzL0FQYXRBa0d1RmlJUnEranR2ZEJtT09uNDRwVDdZWGZa?=
 =?gb2312?B?eVFkVVpIeFJ1WnNyb0lMUVZzR0NmQ2laNHVyVXlyYS8zRDNCbmtRcmptSHRs?=
 =?gb2312?B?Qm5xMFJvQWpNWE9wbFdqVjJGeXB5MDJKYWdPRXhaSDl0b1RIcXhaL2tZb0Vp?=
 =?gb2312?B?MXkzWnhTSWlaeTJYQkhjTEpmaGVRRjlpaVF4c3NnVGJqbW9HUVVWa1JwbVgz?=
 =?gb2312?B?SW9Kbk9ud050L1MvcXhYdVNoNnlvVlprdk8wNVVGMTlLVk1Kck00UUVQaW1h?=
 =?gb2312?B?c0VrWit4THVkT0Y0STRDUDFTdVZqV252NG5RdHFQVW51UWg2WDRLc2lmUTlQ?=
 =?gb2312?B?RzZUQXJaTXJZbXJxQjJPWXo2V29YNXJhbVBBQ0NLWXgyV2xIYzRqQTh3VWdy?=
 =?gb2312?B?dlRhWXdGTGQyaGh5K0MwQW0vb0ZWUGp5MWxoSVdpZDVCOENYaVl5Q2pvaTVy?=
 =?gb2312?B?TWx4UFZnVEo3bm12cTNzYnZ0OTBwcWs5a2YyZWZMTndWVXJmZ0txZ0ZIMWRQ?=
 =?gb2312?B?VzBYbDVUTS9JNnJ4ckRtZFNjdWltMnpVR3FxRkFoU0hNT3NpdnpHVmhTTXAv?=
 =?gb2312?B?WVNhWEZxMXFwck5pd0I3U2RpSkhYMlg1QlRUcEFxUGZ4WTA3Ymg5aTRMRFpa?=
 =?gb2312?B?Qk1HT0JuUUUxUVJXckUwMGlHQzVtM3hMcytJT0lsNzBTdEFJajF3TGZKUGVI?=
 =?gb2312?B?S0hMUlY2RSt0TUFpUWw2NURzTHlURElvbkJXTjIrbzEvNitEdHlyNWRBZ2gy?=
 =?gb2312?B?ODlBUUhBdXZVNCtONFVvVVpoWEhBWXQ3eWg3QW81YTVyWWsyTy93dVd6d3J2?=
 =?gb2312?B?elpmcm4zL0ZXNXh5TzZCcXpsc2RMUkovazkvaDVvcjlBWEQvNlN3RTJaby9r?=
 =?gb2312?Q?dz9CC+qlw7Em5?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?VldPSE1GZk5KM0hNb3FmNkNvWU1nazNzWDQ1YjZ3VXpBWC9hTCtiNWFCOU9k?=
 =?gb2312?B?VlVWUmt3Q21ybiszWllnRktZNGQxc1VUSkpYUGxKT1Jnamg0dnR6OGV2THN5?=
 =?gb2312?B?T0tYVGNzd2lIbXpoME1GbW8rb0xzdE5OSzFUV3h1b25vSlB2YUhIQ09MSlJa?=
 =?gb2312?B?T0tNOVl1Vk5tZ2tZSC9PNGY1VzZRQTR3MFlrcDlDTG9QSy9rNDZNZlM1OUg1?=
 =?gb2312?B?WUZEWUVVemw4YmsxOFlISFNhY0JHNU9GVTRaZ0lLSk9SUjVWTmc2WGxzdjl3?=
 =?gb2312?B?UVZ4UXFDT1VJcVBtd0tqaWNDQ3dhUTJ1RFhaSDYzWUppU3BHWnZPem84MUFP?=
 =?gb2312?B?cHRqcDZxWUNrMlVJY0FqTytKa2w5UTVIUVdZa3FPZjcydW14WG9nK0pId09j?=
 =?gb2312?B?aDhFNjFxd25wWUtlQlVOU2N6MHpnTnNleDJCaldpUDR3U2d1Y1ppUHRXMEdM?=
 =?gb2312?B?NzU5Q2tBWi84VnpwVmhxbnpyMEx1ZmhpSWhhQXhvMUk0YVV4MUZ6NE1NcHhi?=
 =?gb2312?B?VVdwbksrbURRcUVoZ1YwY3Q0VnJxVDJzM25hN0tmYS9SSEYvOGtoNnczTTFq?=
 =?gb2312?B?OGNiOGVhSDZCQjlSbjlCWWJ2TjFjTFAzZW54ZFlsVlUxWGQzRXBqUmJlMUNG?=
 =?gb2312?B?NFBFa3plWGNwZGIweFlrMytkUVFEZ0lLUHg4WlJmWEtyWU52S2hONU4zbk9m?=
 =?gb2312?B?K1ptTDEreVJVU3hSUW90R0NQNUhrYUg1ZkYvYnZUL2R5YWNvVDZKT25jMlZT?=
 =?gb2312?B?WkVpTEprYUxGdVVrTnVCbm9DRzAyUkxobnozc2QrYldxM01ORHpFazBwMWZs?=
 =?gb2312?B?UDErc0pWVHpoc3g4bFhjcFZMVHFBaS83ZnZZR0Z3THlNekExOW1pb2ZtSjBR?=
 =?gb2312?B?RENzdTRlV2FLMWNzdUo5NEQxVHhBSEdrR2pzQzBlOHJ5cEFTMElzUUtaRTlw?=
 =?gb2312?B?YU5nVnVEdVVJbGczcXBZeE1YV29Wci95dTBGeGVDbzF0NFpOY2xZWlFMR1V3?=
 =?gb2312?B?b3hRZS9zWnZwaE5BeCtUSWVobVYzVm8rY0F2ZC8yVmprNTNiY2FwY01STlR6?=
 =?gb2312?B?Yzh1blV6S3ppeWo5QzBzajBOTjdEV0ZVNGtoSGpmVmNNV0ZFazJqUWNML1Yy?=
 =?gb2312?B?UWl5bEhKMlpsb0UvREd2MDR4dVlRN3gxamZDcjZrWEFleWMxUnhId0lRU3pW?=
 =?gb2312?B?V3Q3cGFmbGdVVk8xcmhHeW5GVnZUMVVFS2YzQ3JseDNVNlM5N1NhRUoxYUo2?=
 =?gb2312?B?VldYZGRxellEWXowL3IxdzVXeHlGUWxZempjaWhyOGpFalJ5aDJ5WEJ6dHFz?=
 =?gb2312?B?K0N1c2FqbnZkLzVCZjNrWXFmbldIblRrZW1TNFUyb1lOS3FSNzduV1JadER1?=
 =?gb2312?B?UmtMc05pbG9WTjliaklBSUk3OHZvOVhoeXkwdjhpcmNCMkQySnkxaHRlaWtu?=
 =?gb2312?B?K00ydUtiaVUwM3kwL2s4WkNEMWNxSGJDWTI5Z0RrQzdUaVVRcy9mWGgwLzV3?=
 =?gb2312?B?Q3JPY0FvQ1NtUk5rSHNHdk1jVm96Y2lIY3BLZkRIV3F2blhZT1N5K3JNQ1FL?=
 =?gb2312?B?eVRRc0llSXB4eUZkZXMxVXhzS2lLWXR1ZkJEVFN5YlRpcFhsSjMzSHAwNVlJ?=
 =?gb2312?B?dlVuSFlGeFE4M1RzbWYzWHBHUEpCd1BZSDhjdm5OY1o5TDY2ODlFMy9saVYz?=
 =?gb2312?B?Z01aUXVBYVVGQVJtajMzWkVXUzFkUHgybHJkVjdFSUNUUzEwYVcwRXYyemYw?=
 =?gb2312?B?VVAyeitFRW1Xb3J2YXNNaDYwbm90Z1hhQXEzcFlhOWFIdXhkWmtlQWY4WHhi?=
 =?gb2312?B?SHFYa1RYemVwMHRKdXdJSm82L3MvUDdpQ0s5empiWTdpWmZNaHEzeDhRT013?=
 =?gb2312?B?UU8wZ0tkSW1CQm1OQ2Z2dEo2bElHR1Mwdnoxa1V5emRTL3JQWWJTb3g2TXdY?=
 =?gb2312?B?ME81YWlJMlNIdkMvNUhJdVJtUXpJTkJsY2gvWEtJcVRsK3JNSnhuNmpiVWpi?=
 =?gb2312?B?OW5lR3JndkJKaVBFb2xYSnBHSTZibFkyMjhkRG1xa3R2TEdNM2ZUUW1zRXNr?=
 =?gb2312?B?T1d1K0M1cDkvNURZenRaVlYyR015aGJMLzNZRlNLaE5hUFI0Nkg3eWt0QnE2?=
 =?gb2312?Q?wLYVNpeX8dV/cr7Bl+q/SAczm?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6b721c5-a9a7-4bbb-cb2a-08dcff08def8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2024 08:47:54.5091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 88nXmNBm4WPplseio4SAKepHwjIOqN3emDf82l4X/f3zgxeq7oNz2WNPDd57DBSDNPH82r1TY+e+9SnQDC7Y2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8704

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBIb25neGluZyBaaHUNCj4gU2Vu
dDogMjAyNMTqMTHUwjfI1SAxNjo0MQ0KPiBUbzogS3J6eXN6dG9mIFdpbGN6eai9c2tpIDxrd0Bs
aW51eC5jb20+DQo+IENjOiBCam9ybiBIZWxnYWFzIDxoZWxnYWFzQGtlcm5lbC5vcmc+OyBiaGVs
Z2Fhc0Bnb29nbGUuY29tOw0KPiBsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tOyBGcmFuayBMaSA8
ZnJhbmsubGlAbnhwLmNvbT47IG1hbmlAa2VybmVsLm9yZzsNCj4gbGludXgtcGNpQHZnZXIua2Vy
bmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGlteEBsaXN0cy5s
aW51eC5kZXYNCj4gU3ViamVjdDogUkU6IFtQQVRDSCB2Ml0gUENJOiBkd2M6IEZpeCByZXN1bWUg
ZmFpbHVyZSBpZiBubyBFUCBpcyBjb25uZWN0ZWQgYXQNCj4gc29tZSBwbGF0Zm9ybXMNCj4gDQo+
ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBLcnp5c3p0b2YgV2lsY3p5
qL1za2kgPGt3QGxpbnV4LmNvbT4NCj4gPiBTZW50OiAyMDI0xOoxMdTCN8jVIDE1OjIwDQo+ID4g
VG86IEhvbmd4aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+ID4gQ2M6IEJqb3JuIEhl
bGdhYXMgPGhlbGdhYXNAa2VybmVsLm9yZz47IGJoZWxnYWFzQGdvb2dsZS5jb207DQo+ID4gbG9y
ZW56by5waWVyYWxpc2lAYXJtLmNvbTsgRnJhbmsgTGkgPGZyYW5rLmxpQG54cC5jb20+Ow0KPiA+
IG1hbmlAa2VybmVsLm9yZzsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsNCj4gPiBsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+ID4gbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsga2VybmVsQHBlbmd1dHJvbml4LmRlOw0KPiA+IGlteEBsaXN0cy5saW51eC5kZXYN
Cj4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyXSBQQ0k6IGR3YzogRml4IHJlc3VtZSBmYWlsdXJl
IGlmIG5vIEVQIGlzDQo+ID4gY29ubmVjdGVkIGF0IHNvbWUgcGxhdGZvcm1zDQo+ID4NCj4gPiBI
ZWxsbywNCj4gPg0KPiA+ID4gPiBCdXQgSSBkb24ndCB0aGluayB5b3UgcmVzcG9uZGVkIHRvIHRo
ZSByYWNlIHF1ZXN0aW9uLiAgV2hhdA0KPiA+ID4gPiBoYXBwZW5zDQo+ID4gaGVyZT8NCj4gPiA+
ID4NCj4gPiA+ID4gICBpZiAoZHdfcGNpZV9nZXRfbHRzc20ocGNpKSA+IERXX1BDSUVfTFRTU01f
REVURUNUX0FDVCkgew0KPiA+ID4gPiAgICAgLS0+IGxpbmsgZ29lcyBkb3duIGhlcmUgPC0tDQo+
ID4gPiA+ICAgICBwY2ktPnBwLm9wcy0+cG1lX3R1cm5fb2ZmKCZwY2ktPnBwKTsNCj4gPiA+ID4N
Cj4gPiA+ID4gWW91IGRlY2lkZSB0aGUgTFRTU00gaXMgYWN0aXZlIGFuZCB0aGUgbGluayBpcyB1
cC4gIFRoZW4gdGhlIGxpbmsNCj4gPiA+ID4gZ29lcw0KPiA+IGRvd24uDQo+ID4gPiA+IFRoZW4g
eW91IHNlbmQgUE1FX1R1cm5fb2ZmLiAgTm93IHdoYXQ/DQo+ID4gPiA+DQo+ID4gPiA+IElmIGl0
J3Mgc2FmZSB0byB0cnkgdG8gc2VuZCBQTUVfVHVybl9vZmYgcmVnYXJkbGVzcyBvZiB3aGV0aGVy
IHRoZQ0KPiA+ID4gPiBsaW5rIGlzIHVwIG9yIGRvd24sIHRoZXJlIHdvdWxkIGJlIG5vIG5lZWQg
dG8gdGVzdCB0aGUgTFRTU00gc3RhdGUuDQo+ID4gPiBJIG1hZGUgYSBsb2NhbCB0ZXN0cyBvbiBp
Lk1YOTUvaS5NWDhRTS9pLk1YOE1QL2kuTVg4TU0vaS5NWDhNUSwNCj4gPiBhbmQNCj4gPiA+IGNv
bmZpcm0gdGhhdCBpdCdzIHNhZmUgdG8gc2VuZCBQTUVfVFVSTl9PRkYgYWx0aG91Z2ggdGhlIGxp
bmsgaXMgZG93bi4NCj4gPiA+IFlvdSdyZSByaWdodC4gSXQncyBubyBuZWVkIHRvIHRlc3QgTFRT
U00gc3RhdGUgaGVyZS4NCj4gPiA+IFNvIGRvIHRoZSBMMiBwb2xsIGxpc3RlZCBhYm92ZSBhZnRl
ciBQTUVfVFVSTl9PRkYgaXMgc2VudC4NCj4gPiA+DQo+ID4gPiBTaW5jZSB0aGUgNi4xMyBtZXJn
ZSB3aW5kb3cgaXMgYWxtb3N0IGNsb3NlZC4NCj4gPiA+IEhvdyBhYm91dCBJIHByZXBhcmUgYW5v
dGhlciBGaXggcGF0Y2ggdG8gZG8gdGhlIGZvbGxvd2luZyBpdGVtcyBmb3INCj4gPiA+IGluY29t
aW5nIDYuMTQ/DQo+ID4gPiAtIEJlZm9yZSBzZW5kaW5nIFBNRV9UVVJOX09GRiwgZG9uJ3QgdGVz
dCB0aGUgTFRTU00gc3RhdC4NCj4gPiA+IC0gUmVtb3ZlIHRoZSBMMiBzdGF0IHBvbGwsIGFmdGVy
IHNlbmRpbmcgUE1FX1RVUk5fT0ZGLg0KPiA+DQo+ID4gSWYgdGhlIGNoYW5nZXMgYXJlbid0IHRv
byBpbnZvbHZlZCwgdGhlbiBJIHdvdWxkIHJhdGhlciBmaXggaXQgb3IgZHJvcA0KPiA+IHRoZSBu
b3QgbmVlZGVkIGNvZGUgbm93LCBiZWZvcmUgd2Ugc2VudCB0aGUgUHVsbCBSZXF1ZXN0Lg0KPiA+
DQo+ID4gU28sIGZlZWwgZnJlZSB0byBzZW50IGEgc21hbGwgcGF0Y2ggYWdhaW5zdCB0aGUgY3Vy
cmVudCBicmFuY2gsIG9yDQo+ID4gc2ltcGx5IGxldCBtZSBrbm93IGhvdyBkbyB5b3Ugd2lzaCB0
aGUgY3VycmVudCBjb2RlIHRvIGJlIGNoYW5nZWQsIHNvDQo+ID4gSSBjYW4gZG8gaXQgYWdhaW5z
dCB0aGUgY3VycmVudCBicmFuY2guDQo+IFRoYW5rcyBmb3IgeW91ciBraW5kbHkgcmVtaW5kZXIu
DQo+IFRoaXMgY2xlYW4gdXAgc21hbGwgcGF0Y2ggaXMgb24gdGhlIHdheS4NCkhlcmUgaXQgaXMu
DQpodHRwczovL2xrbWwub3JnL2xrbWwvMjAyNC8xMS83LzQwOQ0KDQpUaGFua3MuDQpCZXN0IFJl
Z2FyZHMNClJpY2hhcmQgWmh1DQo+IA0KPiBCZXN0IFJlZ2FyZHMNCj4gUmljaGFyZCBaaHUNCj4g
Pg0KPiA+IFRoYW5rIHlvdSENCj4gPg0KPiA+IAlLcnp5c3p0b2YNCg==

