Return-Path: <linux-pci+bounces-33629-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B5AB1E797
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 13:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 712FA188363C
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 11:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A173265CD8;
	Fri,  8 Aug 2025 11:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="wLmBQ/lu"
X-Original-To: linux-pci@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011030.outbound.protection.outlook.com [40.107.74.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736D9274676;
	Fri,  8 Aug 2025 11:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754653475; cv=fail; b=WPCuqGdx2Ra3XSxeEAL3k9SMQa+T0J8uMvyeo+fmpz2sxKg7bgPhMQjUtRoODWe/8hyMOUE/FIF5sy9iDt/Z4VE0p+w85AxjOuR9GvihnOuNOL28xeNCsrxnz8nY6xuhB+uol0ldOln/ceTA6zw+teePpevuuhwTdzUWGWu+7N4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754653475; c=relaxed/simple;
	bh=v2eXMui8Pb7joUMgOgB6cj1L4JD2MiQxWHXzugCY4kk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VBV+E1H3gNCuwXJNLtu21THY8uiOy2p6jqwd9YTwzxl4TWJ1B0jTDBbKiYof2MREFtVEc6KjjqWePGH8OmVYOAKELk90Vfu1EIa8SQ0H+m7SsIvBSrG6hT/EzpFbM9C+ua+hayfwqZ1lJu6v2lIXfg8r/7czVS1J1aubRkVR5HY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=wLmBQ/lu; arc=fail smtp.client-ip=40.107.74.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z89gNk4BbnTAxIE4ibvtHSQOkAdjKiZ5If2KpM9X2zKcoYeW9W07Y0LsOLhBdyDN7Gql+sjbBkoGFM8qa1o0XAvYBsj+auuu4KSgrDjS+8hU7aTJImiMfY+o7X2Ib6t7/0TMgSomZYsk+Y5DJQJ+Df40ZJIc6utfPOHumGSDXxTM/HTWSUG66GaRM7KFSoY4Y0WcGmYtKASnKbCvMi1A7ozNbFeo3A2PiVXBX6tzN2Ovx2nOxnmdYCJ+3TRZV3ogdu7OpA3r5uXgOITdtqNcfaD5LlhjeG27vkdTtau7DnG9EOvMbEM9cUuY4Q2AU9wSlzsJCM2eSA8yUBLWXmpmrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v2eXMui8Pb7joUMgOgB6cj1L4JD2MiQxWHXzugCY4kk=;
 b=vW9wz8fCCsgXKasdITWl1tr1XCAWOwCRbvOT+dQHA/e74LUcl+id/VlGQYUEfWTTrc/6bTzbI2RW5RJD1x64D5I7Wog/gMDQ4ZTi8Q81n/49BItnzrnwj5oQxBynW5j/Nyyx4jBeWEYvR7RqjRmattMGGPSqgnONA6w0PJEIN6My93bX5Kd11kzljW4oOjm4nnOTN7jnjAtg5+CCsHWyldXP6iR4Jpt3/VbT5N3G3qy4n9KkRQDp/HQynYfUov44JgPvPIqjb7Ar/p788TQ5xnL7gdH3O1QrHuT1pqa36yHdg6S4jFhie0vdhh9lK0uStmbSyCodSqo20aXMDfIkiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2eXMui8Pb7joUMgOgB6cj1L4JD2MiQxWHXzugCY4kk=;
 b=wLmBQ/lukP+irI+yY/G7ojywH8L6/reHpXO3shYV5WExKn3mJC1gen47Zw42no9BMojpCUwQpQyC4PUu19+XnRjMYWcuDt9MF8UsfgEr1d49f0Fc4AgKbB3a4mrHBkIRndMESMfaN/50QaUlESjknNyF+Dfm0SWdHgQTI1gYD1I=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYTPR01MB11033.jpnprd01.prod.outlook.com (2603:1096:400:3a0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 11:44:28 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%7]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 11:44:22 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Claudiu.Beznea <claudiu.beznea@tuxon.dev>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "mani@kernel.org"
	<mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"geert+renesas@glider.be" <geert+renesas@glider.be>, magnus.damm
	<magnus.damm@gmail.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"will@kernel.org" <will@kernel.org>, "mturquette@baylibre.com"
	<mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "lizhi.hou@amd.com"
	<lizhi.hou@amd.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>, wsa+renesas
	<wsa+renesas@sang-engineering.com>
Subject: RE: [PATCH v3 7/9] arm64: dts: renesas: rzg3s-smarc-som: Update
 dma-ranges for PCIe
Thread-Topic: [PATCH v3 7/9] arm64: dts: renesas: rzg3s-smarc-som: Update
 dma-ranges for PCIe
Thread-Index: AQHb7P8PBMpfnLgFvkWQvju7tLKMl7QmU8ewgAGzIoCAATrXgIAvk0+AgAADyMA=
Date: Fri, 8 Aug 2025 11:44:22 +0000
Message-ID:
 <TY3PR01MB11346340ACB78394E131503B3862FA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250704161410.3931884-1-claudiu.beznea.uj@bp.renesas.com>
 <20250704161410.3931884-8-claudiu.beznea.uj@bp.renesas.com>
 <TY3PR01MB113464920ECAC2C3CB89DE2D5864FA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <7c8c7a25-c373-452a-9fe8-8b2d92ddd885@tuxon.dev>
 <TY3PR01MB113467C09DF7D3D0D7833A6598649A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <fa0da331-273a-414b-b0d8-229c6772692d@tuxon.dev>
In-Reply-To: <fa0da331-273a-414b-b0d8-229c6772692d@tuxon.dev>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYTPR01MB11033:EE_
x-ms-office365-filtering-correlation-id: 5550bd33-cc3b-43b1-cdb1-08ddd670ead4
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?SmtYVlhHTFJjdzZqclRDM21yUVN3M0dsNUhSdnorbmk1M2xKRkc3aVByZExQ?=
 =?utf-8?B?N2tFNjlZVjNoZXJrNkNVbEg3MVIzcWpMSVhBdC9Pc2xYZmVqUm1taTl2bHRy?=
 =?utf-8?B?Z1RiMnVlWXFMYWRQUmtleWdQWGQzTDl5Z1BDbHpNSXlOWUZpZ2w1M2tELzVC?=
 =?utf-8?B?RVNJYmNwbGN6U2RaWjdqaWNmU1B4VkhRdXJuNWZPRjVmTG1hNTJQeGxQakh0?=
 =?utf-8?B?UFRGNENsWWhUZFJlTVpYZkxDQlQzRUsxck01RnZNKzZtMXpCQTJXNksrQVV2?=
 =?utf-8?B?YXhyV0RqVmpFaFhaMUJpOGgwWjZOUEptY2lzSWQ0bnN3S1RFRTVFOGUzZmFo?=
 =?utf-8?B?WDBGcHFTWWlBRVpoRVJCVGJKZitvb0NMU0pmdVFXV3F3M3AxcDRSbXlyMk8z?=
 =?utf-8?B?ODJxM1FheTZ5NHFiZ3Vmd0ZJZHB3MHdtMnhsb0JPQUk3NjY0TnF5K2pxUERn?=
 =?utf-8?B?LzVFbFdnL3RYQStUUEZmbW9qVHB6QnhsYTVTNml3elJLSFR5Vzhlb044TkRu?=
 =?utf-8?B?UkdFbHJFakcvS094Uk85VXlySmU4SWltMVlQZGlzOXFxTzl1anR2UmdSdm1J?=
 =?utf-8?B?ZGEzRWtwOUluSnZMMmdNZVhHWHhhc3FrNmRHNFI5UFFBSXRrc3g5UVFQR0Z5?=
 =?utf-8?B?d3NDZFh0TTdTWUc2VkpTMFNFcDRQNE1TSTdQZmluTFdHazN5TzdvVWw5N29o?=
 =?utf-8?B?YmkzWW5vd3l3UjlMdlZVRTJQdjRkd0kvaC9kWUhwQy83T1RUdTFpbVFQUkFt?=
 =?utf-8?B?ODVKT20xclpaQm1QZzR2M25QN3RreXp1VjJlQUZFWE9adHVFN0ZKQlA3ZXRQ?=
 =?utf-8?B?ME10YlF2VlNtVjBObG1keVB6MVcvYkN6S3phc0w4N3VOcVZab0dWNmJCQjRu?=
 =?utf-8?B?d0RYTVlCRElpSmVlWlh6S21Qc2ZhS1k4enV1dHV2aktDdmw4U0tRcHI0Nmh6?=
 =?utf-8?B?ZjFCQkwrQjNYd3F6ZjZseHljSFZHYzg4cGN6Z0l3bWRiWm5vc20rODYvS1Vi?=
 =?utf-8?B?K2N0NmRLN3pTc2hUM1hjL1IvUzNFWU4yM0REalhMZUpxd1VhTzYzRVJsbUpF?=
 =?utf-8?B?VUFhTm5OK3FHWWlITGhjWXdJdURVbU9oYTltVlJsVlY1cDJCN3NidjZxdC9m?=
 =?utf-8?B?Vi81dDdIMlJMY3VaelQ4WnJkTStRVFo4ellLQjNhellTeS93OERwWFFid1Vu?=
 =?utf-8?B?a1h4cXlJb1ExcmhOTDF4ZFcrdlVvbDFoOVpubFkxQ21hN3JBTTNER0VHd3NO?=
 =?utf-8?B?QXpZTHE4ZkdvYkhzckQ2NzZqMGVMZkc1bmppS3hFOExtV2JBZThCR3hPTWlG?=
 =?utf-8?B?ejhjUXJmdlBHSDlrSHpUOGhoMnh4YWhqT2dGakUwLzZZTFljc3M5bWtkd2hH?=
 =?utf-8?B?U0IwRjJmWElOV0d5eWUydHlSRUtuWTB3WEM5d09lNnZsRHpRRWg3ZnpYUk9w?=
 =?utf-8?B?SEJIeGdoSVdwQjl4K1J4ZURyS0prRDdDMFZUVHJDYkhNZm9ycHR4Y09JK3Z0?=
 =?utf-8?B?aU9SMEptZ1hsVlM1L3d1MmFBR3JyVGRHU2VZNTJ5cVZKb2VqaVIxTm1QekJI?=
 =?utf-8?B?bHEwMUN6SDcweTdLdGYxanVodVkrREZOYVFzZFZobDFPcGxyVDUyYVFqZkVW?=
 =?utf-8?B?MHJIQ3pKYzlVbHlTV2p2d250RVNrdHhzendlVjNIVllmM0hBRjNFL0ZCMmFP?=
 =?utf-8?B?eDk5RHR5a0R1ZW9TeElUamJOaTY3SXlsand0YjJoSWQydUJacmtHdDNtS0Ja?=
 =?utf-8?B?MlFScUpXa1ROa01OK2xRS3czM3oyOXJubTAyUjJHS1Q1blZmdTRJZzFNd3FR?=
 =?utf-8?B?QzhWTkswdHJLcG1YUGVjL0hscGU4QlJ2b3dDY2UzQjBpaFJOV25EaVRqS1ln?=
 =?utf-8?B?RWM4MFN0ZjB3SVh0NWV1UElnTFRtem5yNVBwaFZ6VDdpRk5NMmpDZGY0b1Rq?=
 =?utf-8?B?Vk41b1h0OHpCeDNKc1JPSkpVM1pVRnFJUXhzKzVyNGJPVVhWTkExaFB1a3Rl?=
 =?utf-8?Q?6h9qbFlGXGYF+ez8e1wp4BTmgJqywI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M1FGTkVUY2tZazB6bjdvbnYzZ3JGaGFNN09XaHpVRWY3bTFNNm1wL2p4bWFh?=
 =?utf-8?B?alpvY3JjL1FJQjhlV29mN0s5bUlWZ0VuUEVwaC9SZkRMUkJJN1N6ZHdqY3lK?=
 =?utf-8?B?b0drOGtkNkpQVkxUSzUxclpsRlh6TnhxeU82R25FeHhqY2JMUVI1MERoV2po?=
 =?utf-8?B?Yko2WGMwRGNIeGIrR3Y5MTVLTE53VGcwYlRpOHBKOGU0ZGJzbHZLamFwZkN0?=
 =?utf-8?B?cE9WODdlK0VsdU5IS3pMcjFGMHBod0JXeGdZSFo1a0pxMzJXMHREUVNMWXBa?=
 =?utf-8?B?MDdleFExb1FhWnlMYS9QMkRrd3ZjblFPT285K29wcXF5L2VTa0NuWDh5bFVJ?=
 =?utf-8?B?d1FTazFMcHp6d3BhNWFXZGx2dzU4anlHZjhuN2VOZEdLTnpwSDk5S2UwT0Yr?=
 =?utf-8?B?VG55UkhWY3FTWjhoNGJvVi9McTNBMEF0ZjZ3Z2t1RGl2WWpYWTJmYWpWd2RQ?=
 =?utf-8?B?MkhiajJSK1pIaXdEVkc5UWtHZFZBN0MzQlpYZUxpU2FJTmdscUZEcWd0d253?=
 =?utf-8?B?alN2MFpsd09BSzRmT2dwVHJ5dlIxczRnOHprd2lXcGJ6ajVPUU54RDZJTExK?=
 =?utf-8?B?dHdPVnBUWGQzYUJoSS9SZlc2RU5Oa0pyKzY2RGhmVG9SeVBRclZJanZma0Vs?=
 =?utf-8?B?NTRaZUYxa3ltYzl6b0JjZzE4aUxQQjJlM01jdWp6QktndVNaQm1xT3Q2UkMr?=
 =?utf-8?B?Y2o1WEE2UXVBRTNSSmtJY2R5bFc3WUMxVXFRVjJzcmxJbXZhMXQvODVqZXh3?=
 =?utf-8?B?WVp6cG8zSkF5Q2xFRTVSWmpuOGxzMXlSWEd2Y3dGSUlXeWo0Q1RMd2xOTllj?=
 =?utf-8?B?SGlGdHh1UlN3NVk0UE1lLzJ6OE5zUFRyeGhqNjNSMmxuUDNJMUcrUnArVCt4?=
 =?utf-8?B?VlVmenlkS21yMm1TdVQrNEQvVi9vVHZuSEVZTTJYckUzMVk4b0JyNVkzZW5y?=
 =?utf-8?B?ZWlZckVjZkQyQ2QzN01hby9qb3RrOThvQm5zZk93bTcxaDI3ZDF2N0xpdFFI?=
 =?utf-8?B?Qy9NcDJ6dkttT1V4WWxBUVJsS0dHNE5GSGVoaG1BWWFrVkJRaXJCd05LTFh0?=
 =?utf-8?B?NjZaT0x0cm16ZTFVZnhzK1JkeGtpdHJ2QjRPNUdZWmovOFIyU1VadE9XVW1K?=
 =?utf-8?B?YW1FUHJPczFsVW1tWFVYYlZFbS9Ia08vZnRMTUVNWnJuVE1jMEFkNzRoMkVK?=
 =?utf-8?B?VStaN0dMdDVKRjVOOXVHcDJEUmMwOWJEVWZic2oxUi9QbCt0STlveUtpVTlH?=
 =?utf-8?B?WWErQkJ0SG5ZNCt3V0RaYlBSWVVqQXE4YUNoU1p3WEErcllxUlR1b2loUGY5?=
 =?utf-8?B?MEE1c0d4Z1BqWjJsYllGWDVmTUU2Zzl0L3NPK0t4di9laG5Bd0FjcWs1cmFH?=
 =?utf-8?B?Q3Z0ajJOZG5xaDgwTlJQQy9HS1U3Y1dQYVhMQ2xGUURRYjBLZndram5yQU5m?=
 =?utf-8?B?elBIR3hnbG94bEhIbVdhWVJrT0NmZTNOUXNmb1lVbU51TDdPRnZWZFpGbkJ2?=
 =?utf-8?B?aVJ5c0hzMmxlZW05YXJHbGJLQkV3clNiSHRKYkdTQlcrakF2QzRaUCtLM2tG?=
 =?utf-8?B?eWd6KzR5OXRycTZHc1JrTm1YWEF0SVR1aXN2YSsvRytWM2NRdWNaNS9HSHRm?=
 =?utf-8?B?a2VnSnFzaThZY3MvZEVnNVhZU1JNNVlzb2l0R0RpdTA2Zzl2amg2S1gvT0g1?=
 =?utf-8?B?UWxOdCtUY3hrK2VTclJWLzVBcytDdEdqSDFidzJXL3lhLzA4QWV0YSthMFZa?=
 =?utf-8?B?VUtQdk05Q3BubTJYRS91dzNmTTlTdHlqMHFHM0hJY2MwZWxzSlBZeUNzTnQ5?=
 =?utf-8?B?QlVaLzRmeUtaWWx0anlJbDllazlaN2g5Ym4yNUNrQTNmd0V3S0JyRlZpOHhx?=
 =?utf-8?B?N1VVVTVGOXNvalZNRzZKeXpxODQyaHJqRTZma1RLTmo5Sy9RRlJvdTNDYkV5?=
 =?utf-8?B?Yk84UGxwNjRkdkp2WUplZkVvcUNqZ2FpbWJQTkt5UlFNWnBHTVlVNW5ZWDR0?=
 =?utf-8?B?SnJDZXRxOFRjbUtibkhLeWhFWlRwSmVUd0dhVy9vTDBDODZUZWVCOXJCaUFx?=
 =?utf-8?B?Ny8xbDQ4VWFwWkFTejliVU1remMrUXR3bU84QkhSS0xHdThCUHg0YzBneHov?=
 =?utf-8?B?NldaOElsK2t5K3drRUhFZUFRdEpOOHdvTTNCaWlMZlZmTkFqU3lJN0JIc0lM?=
 =?utf-8?B?bWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5550bd33-cc3b-43b1-cdb1-08ddd670ead4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2025 11:44:22.0837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +XmlrXrMB/EN0FZP0Y/DQRa9CriXyJTfrOuwfd9qAM+OFHfSzD6G4ylaBLgWlArQBtOXTtlwjdNKxEXWRxWSK0r8fUSYhGOVNnB0ZnH8e5Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYTPR01MB11033

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2xhdWRpdSBCZXpuZWEg
PGNsYXVkaXUuYmV6bmVhQHR1eG9uLmRldj4NCj4gU2VudDogMDggQXVndXN0IDIwMjUgMTI6MjgN
Ci5vcmc7IENsYXVkaXUgQmV6bmVhDQo+IDxjbGF1ZGl1LmJlem5lYS51akBicC5yZW5lc2FzLmNv
bT47IHdzYStyZW5lc2FzIDx3c2ErcmVuZXNhc0BzYW5nLWVuZ2luZWVyaW5nLmNvbT4NCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCB2MyA3LzldIGFybTY0OiBkdHM6IHJlbmVzYXM6IHJ6ZzNzLXNtYXJj
LXNvbTogVXBkYXRlIGRtYS1yYW5nZXMgZm9yIFBDSWUNCj4gDQo+IEhpLCBCaWp1LA0KPiANCj4g
T24gMDkuMDcuMjAyNSAwODowNSwgQmlqdSBEYXMgd3JvdGU6DQo+ID4gSGkgQ2xhdWRpdSBCZXpu
ZWEsDQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogQ2xh
dWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQHR1eG9uLmRldj4NCj4gPj4gU2VudDogMDggSnVs
eSAyMDI1IDExOjEwDQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgNy85XSBhcm02NDogZHRz
OiByZW5lc2FzOiByemczcy1zbWFyYy1zb206DQo+ID4+IFVwZGF0ZSBkbWEtcmFuZ2VzIGZvciBQ
Q0llDQo+ID4+DQo+ID4+IEhpLCBCaWp1LA0KPiA+Pg0KPiA+PiBPbiAwNy4wNy4yMDI1IDExOjE4
LCBCaWp1IERhcyB3cm90ZToNCj4gPj4+IEhpIENsYXVkaXUsDQo+ID4+Pg0KPiA+Pj4+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+Pj4gRnJvbTogQ2xhdWRpdSA8Y2xhdWRpdS5iZXpu
ZWFAdHV4b24uZGV2Pg0KPiA+Pj4+IFNlbnQ6IDA0IEp1bHkgMjAyNSAxNzoxNA0KPiA+Pj4+IFN1
YmplY3Q6IFtQQVRDSCB2MyA3LzldIGFybTY0OiBkdHM6IHJlbmVzYXM6IHJ6ZzNzLXNtYXJjLXNv
bToNCj4gPj4+PiBVcGRhdGUgZG1hLXJhbmdlcyBmb3IgUENJZQ0KPiA+Pj4+DQo+ID4+Pj4gRnJv
bTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhLnVqQGJwLnJlbmVzYXMuY29tPg0KPiA+
Pj4+DQo+ID4+Pj4gVGhlIGZpcnN0IDEyOE1CIG9mIG1lbW9yeSBpcyByZXNlcnZlZCBvbiB0aGlz
IGJvYXJkIGZvciBzZWN1cmUgYXJlYS4NCj4gPj4+PiBVcGRhdGUgdGhlIFBDSWUgZG1hLXJhbmdl
cyBwcm9wZXJ0eSB0byByZWZsZWN0IHRoaXMuDQo+ID4+Pg0KPiA+Pj4gSSBzZWUgUi1DYXIgUENJ
ZSBkbWEtcmFuZ2VzWzFdIGFuZCBbMl0gbWFwcyBhbGwgcG9zc2libGUgRERSIGFyZWEgc3VwcG9y
dGVkIGJ5IHRoZSBTb0M/DQo+ID4+PiBEbyB3ZSBuZWVkIHRvIG1ha2UgYm9hcmQgc3BlY2lmaWMg
YXMgd2VsbCB0aGVyZT8NCj4gPj4NCj4gPj4gSSdtIG5vdCBmYW1pbGlhciB3aXRoIFItQ2FyLCBi
dXQgaWYgdGhlcmUgYXJlIHJhbmdlcyByZXNlcnZlZCBmb3INCj4gPj4gb3RoZXIgcHVycG9zZXMs
IEkgdGhpbmsgd2Ugc2hvdWxkIHJlZmxlY3QgaXQgaW4gYm9hcmQgc3BlY2lmaWMgZGV2aWNlIHRy
ZWVzLg0KPiA+DQo+ID4NCj4gPiBBbHJlYWR5IExpbnV4IGhhcyB0aGlzIEREUiBpbmZvWzFdLiBM
aW51eCBwcm92aWRlcyBETUEgbWVtb3J5IG9ubHkgZnJvbSB0aGlzIHJlZ2lvbi4NCj4gDQo+IFdo
YXQgd2UgcHJvdmlkZSB0aG91Z2ggZG1hLXJhbmdlcyBEVCBwcm9wZXJ0eSBpcyBzZXR1cCBpbiB0
aGUgUENJIGNvbnRyb2xsZXIgcmVnaXN0ZXIgY29ycmVzcG9uZGluZyB0bw0KPiB0aGUgQVhJIHdp
bmRvd3MuIEl0IGlzIHRoZSBzYW1lIGluIGNhc2Ugb2YgUi1DYXIgKGFzIG9mIG15IGludmVzdGln
YXRpb24gb24gZHJpdmVyKS4NCj4gDQo+ID4NCj4gPiBJbiB5b3VyIHRlc3RpbmcsIGhhdmUgeW91
IGZhY2VkIGFueSBpc3N1ZSBsaWtlIHN5c3RlbSBhbGxvY2F0ZWQgRE1BDQo+ID4gcmVnaW9uIG90
aGVyIHRoYW4gWzFdIGFuZCB5b3UgZG9uJ3Qgd2FudCB0byB1c2UgaXQsIHRoZW4gdGhlIGNoYW5n
ZXMgYXJlIG9rPz8NCj4gDQo+IEkgaGF2ZW4ndCBjdXJyZW50bHkgZW5jb3VudGVyIGFueSBpc3N1
ZXMuDQo+IA0KPiBBcyB0aGUgdmFsdWVzIHBhc3NlZCB0aG91Z2ggdGhlIGRtYS1yYW5nZXMgRFQg
cHJvcGVydHkgYXJlIHNldHVwIGluIHRoZSBjb250cm9sbGVyIHJlZ2lzdGVyIGZvciBBWEkNCj4g
d2luZG93cywgYW5kIHRoZSBETUEgZW5kcG9pbnRzIGNhbiBhY3QgYXMgYnVzIG1hc3RlcnMsIHRv
IGF2b2lkIGFueSBpc3N1ZSB3aGVyZSB0aGUgRE1BIGVuZHBvaW50cyBtYXkNCj4gY29ycnVwdCBt
ZW1vcnkgc3BlY2lmaWMgdG8gdGhlIHNlY3VyZSBhcmVhLCBJIGNob3NlIHRvIHVwZGF0ZSB0aGUg
ImRtYS1yYW5nZXMiIHRob3VnaCBib2FyZCBzcGVjaWZpYw0KPiBiaW5kaW5ncyAodG8gcmVmbGVj
dCB0aGUgcHJlc2VuY2Ugb2YgdGhlIHNlY3VyZSBhcmVhIGFuZCB0ZWxsIHRoZSBQQ0llIGNvbnRy
b2xsZXIgdG8gbm90IHVzZSBpdCkuDQo+IA0KPiA+DQo+ID4gTm90IHN1cmUsIFBDSWUgY2FuIHdv
cmsgb24gaW50ZXJuYWwgbWVtb3J5IHN1Y2ggYXMgU1JBTT8NCj4gDQo+IEluYm91bmQgd2luZG93
IGlzIFJBTSwgb3V0Ym91bmQgd2luZG93IGlzIGEgUENJZSBzcGVjaWZpYyBtZW1vcnkgZGVzY3Jp
YmVkIHRob3VnaCAicmFuZ2VzIiBEVCBwcm9wZXJ0eS4NCg0KWW91IG1lYW4gU1JBTSBjYW5ub3Qg
d29yayBvbiBQQ0llIHN1YnN5c3RlbSBhbmQgd29yayBvbmx5IGZvciBEUkFNDQp0aGF0IGlzIHRo
ZSByZWFzb24geW91IGFyZSBub3QgZGVmaW5pbmcgU1JBTSByZWdpb24gaW4gImRtYS1yYW5nZXMi
LiBBbSBJIGNvcnJlY3Q/DQoNCkNoZWVycywNCkJpanUNCg==

