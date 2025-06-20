Return-Path: <linux-pci+bounces-30241-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D585AE15DF
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jun 2025 10:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DEA73B9C05
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jun 2025 08:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF272367AF;
	Fri, 20 Jun 2025 08:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WUFrWBw1"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011017.outbound.protection.outlook.com [52.101.70.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACF12367B6;
	Fri, 20 Jun 2025 08:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750408024; cv=fail; b=FBlpAuJ53TVBSIzAxUhYeVnvUxA6Vna4i0r5yGzBlB7czLRAk1rZnYkJxukCTdg/SkTwGIJzwJ0EGASfNHyOrMWWsPsQhqA0tJ0/CtnBN0gFb6vWFL6NzGE0IBD54LF+Dq/Kqiw9CFmTx2Riao9g+n2ZyU56ruPD4hE4xuGGnXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750408024; c=relaxed/simple;
	bh=HNSjJ7KMPkqTvdfCe0WAjpXQMOKB6xHQpWTx6/VpWo0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gT+jTEJvTclkR8UgY8CDZHrLe2olMiSZ5FJjcN0R7haslPlku5NPqicWnxZwaYvCve6y/Y6eijUdYfkWve5T/kSUR2Wh4WBopB1tis9MZvy7eloip5CZkXYn6GujcSE25jaBhYeOB9URfa65ZAN1IJKjtrt44J7sJioG29RgU5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WUFrWBw1; arc=fail smtp.client-ip=52.101.70.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DdRlf+vKWOVJmpWQ2U5IbZSuVDW8H3hdhsYWqob/B9gdcy1likPIgJkPeB+DVSOudDG6FFdOXIOVaAXpHtm42BeTgkiInZbPTwRcRn+h8FYCd98HJy6njrMZ9vbjnIwt88YR8QThtX3cPJ6BNbN6lroBS1MgYH+omgCGmhqe7IhHcQ8WX4vyWW0NEv1aT4bm9NB/tegscXRsXwcfWjWEB+sxMSrXXSqWDsTluOwEXJ/gpQKDQsIiyr8bLsenRmDj967908qj8pV5YThVvKd09ef7ssyACt3lp/Lrwgw8csYeIIsndhxc/epUBmIrPRGdBxjT5IBiLRcbRoW0WfjySA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HNSjJ7KMPkqTvdfCe0WAjpXQMOKB6xHQpWTx6/VpWo0=;
 b=HCPAzfvL1H4GZj3JlLxdzt0gOqiB0FJTJFbqkr5wvIhctkJL/2hquOhFOkNBo6sNWfceMXzhmS8imtxJki77Nh/86tSu3Aw8N0qqQWtU3kqdPiI7mMw/iC26hliV/IIbUD5A3MpuK9gGdx9yMFdzfTDwd4kyisc5sBENWk7gI7FMYWyByxK9YiYsD6CqKzGVlGOA6vvioctEGUQzQxeqUNZbvb7CPaWIGMbWomn5S37IXM5in0PfHEpoucnnMnX85/ZRzbBB0/uiO5Xl7ti9LsnEgxYMGlXXmw2Nb6GiT2xGvX8l2ss+5XWy0YhZP0n3eutxqZQXmLrpl38UyAcitQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNSjJ7KMPkqTvdfCe0WAjpXQMOKB6xHQpWTx6/VpWo0=;
 b=WUFrWBw1YuUCPJi49c/xkqiJh9QxPvYOanU/h7C7Jc155Ri7+uew6bBbCqtLXDalhhDGUCZyoZDIsbnOl46frqnb/g2EYNhWHKzTF4PKusf+yt1lF34K56J9TFn1cqeyCx2GkK5RT8OR1sfJGQW09+UrhkTLXIKPeXaI+yGA33VMy7C82wF7qflhFyYZGVLofyqpo6BmxsPw2+vwRZecy6FYCaGRi36n2GCmvTHgu6jq6B0zyX8SR30huYVve1aZmO3gPoIf06U+OgQnlaGycOm3LRvJNzwe9VKcgrQEDGpLJHhspwJyFqVnKwv+/f8wYIrCkykjanTVx/QLIydkCQ==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by DB9PR04MB9939.eurprd04.prod.outlook.com (2603:10a6:10:4c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Fri, 20 Jun
 2025 08:26:58 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8857.022; Fri, 20 Jun 2025
 08:26:58 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Frank Li <frank.li@nxp.com>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "mani@kernel.org"
	<mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/2] dt-binding: pci-imx6: Add external reference clock
 mode support
Thread-Topic: [PATCH v3 1/2] dt-binding: pci-imx6: Add external reference
 clock mode support
Thread-Index: AQHb4ZGnnK0+mhMxB0CmqHMoIIKW/LQLrY4AgAAFt2A=
Date: Fri, 20 Jun 2025 08:26:58 +0000
Message-ID:
 <AS8PR04MB8676FBE47C2ECE074E5B14768C7CA@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20250620031350.674442-1-hongxing.zhu@nxp.com>
 <20250620031350.674442-2-hongxing.zhu@nxp.com>
 <20250620-honored-versed-donkey-6d7ef4@kuoka>
In-Reply-To: <20250620-honored-versed-donkey-6d7ef4@kuoka>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|DB9PR04MB9939:EE_
x-ms-office365-filtering-correlation-id: 3324e7ee-f3d0-424e-9ff6-08ddafd4392a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UFRvSkNiR1JwUlQ1Q2FuUlM2Z3NoejZ2dGxiVUxMVkFrUzRRUktBZjgrM1Ja?=
 =?utf-8?B?Yys3anpoNjJRbTE4R2ZZc3BzMUlnMlVqaTk1WXpCYUkrYlQrVnIwTWRzTmZv?=
 =?utf-8?B?c3llYU56M1hiUXVtWGFkSW8ybnc3cG9haXNLME1uTmtmeUE2S3dCMmJ1OEdC?=
 =?utf-8?B?cTkxKzJrRW5VMHJXNzRNa3U0bEFua2JCeDUvTVJqMExYaUlIdjAzOGR6OUtz?=
 =?utf-8?B?Nk1JUG84UmhjNkVMR2hoVDFLUkVBY2QvUUxHNWgxNVNTTkhGUHgvUGxHNWVL?=
 =?utf-8?B?L0YrWDd1c1VHUVVhUXpHWlVkZUlSMVh1bWlpd2plV0s0WFczU1BJZVBkVk8r?=
 =?utf-8?B?ckdKekQ1ODZrcGpoV2E0TGkyTGZDMHh4a3BjMG40MmVnZ29lSzhSbW01Smkr?=
 =?utf-8?B?M3F0d2hnekM1SEsrcDdtKzVvb2lxcGFQOTZORk50enMxVVZwb05UUEFjUnZH?=
 =?utf-8?B?UHBqZnlWUmtUd3JxeGsvQlZQMUNYZDdYSXdrS2NKejNzeVgvZzhEZXRYSTNK?=
 =?utf-8?B?TFZjZkw1UXFheGtwRmZydTAwMjNpWlh0RnBQbUFsazhabDNoN0NienJ0QkNn?=
 =?utf-8?B?N1lkazRqRlFnNGNHU1ppT1BielJzckNqQTk5ZG5pd293elBtbEhZVHhuMkx3?=
 =?utf-8?B?NXRBemJnM1hnWUxwekhKdlk4M3owMFZuMXVFdlRYc1dOTWdjaXlNUWx6Unhi?=
 =?utf-8?B?RHdKdVNYanptRkxtdmhURE5kR2J2RXBkQi9NYjNhTEFYMnp3Y1JBZWY1N1J6?=
 =?utf-8?B?Qys2VFhGM3VNKzZreW9YRGd3dG9DRGtncEVGTnhzZm1MdjhLcjY0MTFVdUZ4?=
 =?utf-8?B?cnJJUFBYcVFjWmtxTUpyaVBiZ08xYi90RDdFWThGejBsZk9GTEpYMmJWUnlw?=
 =?utf-8?B?VjBwc0twVFJoTVNZK0x0eEFrZXIxZDBONkJyOHFtdzUxaGdSbFdRL0dpaGcr?=
 =?utf-8?B?MFl2RHlGREhDSk9RN3h3Qk5namNIZ3lSUTBhWDBEcmdLUi9kV0xJUDA5b3ZL?=
 =?utf-8?B?UnlzQlMveGUyK0J1QjVBWTJKWGZ1cnNJNDlqRjlRck9BMWo2SzV5WjYyYzNM?=
 =?utf-8?B?Z2xSUW5uT0VleWU5bXhSRTVGekEwUnJwNDdxL1dZYVFxOGxwbkJSNzFOczRv?=
 =?utf-8?B?UEhqSDR3RlhUSEV1MHdtcmg5Z0g4REYybFBadFgxOEoxb3c5TnJDSGl5ajFn?=
 =?utf-8?B?MkJrcG1CTmFCR2crcTA2QUlacmlKZHNablVrb0s0WFgzZ0dmU2pEaGJQOUdO?=
 =?utf-8?B?WWpReHhGRjJ5Z0w3SVc3U0t2NFVyN2V2TTlWQWR6Yll0MUFFNjFkTTM3RzBO?=
 =?utf-8?B?eVBBeUVRcDNGOXRiTEptMXExWUpRZUVQb2NVM0kzZFhaVjB5Z1hWajFWUHVU?=
 =?utf-8?B?djVyS0RRMWdyaDZZOEd1dGxqdjNZcVh0WHhteVFVZFB0bjJsYkZRSUVjVk9U?=
 =?utf-8?B?NzdhZDZlbWVSRDd1V0hOOFhrM0xsLy9FWkE5eTR1Wjl5cFAxSlVGV2VmUVk3?=
 =?utf-8?B?cFNJMjlybGZhK0tlM21qWlg2Z2V5QVZlTUJZMnZZU3NhT0J2YkNMTTRBd2xv?=
 =?utf-8?B?V0s3Q0NURzJYZ0VTaGQ3RVRXUVdsUlFERUhSSkZNUk93L0ltMC82N0pWNlNv?=
 =?utf-8?B?ay9VT0VZUjBsbWx6UXM3c1UzRG5HUk1UbjNGUlI1RWhDMWovZ0tvUTFJUFox?=
 =?utf-8?B?aTlySGIyY2R0OUlmTHlsZmVWREVDOW5Ma3pDS1k5WVNmemMwT1BDOHNEYjND?=
 =?utf-8?B?N1lZeWdYVzZOeURhS3pPZlpHQkZjamNkYlBVSmJGemQyTzc4Ry9HeHQ5TS93?=
 =?utf-8?B?cktmbXZ6eGhKc0hXdm93dENEdDNiNjNLZ0YwUU1rY25BODExdzF4ZVVpMWQ4?=
 =?utf-8?B?KzkyRXczMEFHVk9ZOHY2MGExNFlIRkVYU1NnQTU1UDhoWlNybnJmMDlMUnFv?=
 =?utf-8?B?MWdrOVRLcng0c2NxeDRXUkxKbTczS1hQL2VqZzJlSWs4VTZMRE04NVpXdGxW?=
 =?utf-8?Q?djHSMlFaGy5/0V0ZRr1u1CN14pvtXA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bHBkMjRQVjF2RENLZ1RIUmRNOE9sMDhwQXNiTVdNNWRTR2NoQU9GaVFqTFVn?=
 =?utf-8?B?U2JYUndBUDIwclFpV2lLUWZqTTlteWtjbEpvMWYvNmNXWmN2a3hBQk9INW41?=
 =?utf-8?B?Y1ptWXFRNGpTWE5YRzEwVTJkOHlOZWNITUN3ZVYzTzV3TnVlYjErWU5nVjFX?=
 =?utf-8?B?WFoxTjNBcURHUGlPV1FNRXRmckFkWmFmT1g4N0VlWGQ3ZjRFYnVBdHcySnNW?=
 =?utf-8?B?TjFxTUdmTy9HTTdQODBCTUJMcTlsQ1R0TTB0K3ZkT0NNWi8xNXRMbGw4WHZZ?=
 =?utf-8?B?aWU4UjIxVlpvaVpiNlZZaVhhRDJpUy9KM3pJdUZQSmQ0bHBwekJlQ2FTQVUw?=
 =?utf-8?B?SHNEZnJLN1k3ZzhKRlJ4aUZzaGhHNmFwcE4yQTVjbFZGaWsvVDFPSWE2UWxE?=
 =?utf-8?B?QlR1eG90N1NUc0VMQm9sbHRWQm9OaEhDTjVEaHdUZmtmb0REWFpBV01UUS9w?=
 =?utf-8?B?SkF4dHhZT0ZieFl0VUphbFcxOFlBZFVHaWp1ZzdoRW9XUU5JZjdReVRudjNu?=
 =?utf-8?B?cXFYam8zbHN3MTBFbUorYkhQdjZWM0tSY2l5Y1gydC85djVWUHd4US80aktq?=
 =?utf-8?B?VjVOOG1GSnJFd2t1UDUwWU1ESzdudENwOWxPWDJGR1dCUjUwU1RKRjNLS0Jl?=
 =?utf-8?B?WWpTNWhQM2tUY2hRbSt3dzlxQ3hOZEZuUG5nQ3pVU25MUlJXWFBSV0diblJM?=
 =?utf-8?B?MmxHdHlXQzFGenRyNUpLSUNHT1dPR2NrM095czNMV2d2aUxYd3RSZkZUVSsz?=
 =?utf-8?B?VG1NK2VvODY0cFRwalh6M0FxSlp3Q21ES09UdVVqc3k5RkcyTm5ZSXdoVTJm?=
 =?utf-8?B?T1JhQVk3ZnpoMHFRMW9sdlNYMDY2M054TFUxaFNCRld5Z0lhVFZyeG9EQUtO?=
 =?utf-8?B?RzhRNmJqRk93emc4YXEzQU1peSt0V3EzYURYUDhUM1R2V3dRbm85QnVmYy9t?=
 =?utf-8?B?YUs3NW9uTElOUnN5S3VnK1R2VmxVRUVMa0lhU2VBK1V0T0hjazAwdUNvYUVs?=
 =?utf-8?B?ZHhMTEloTHd1alRkZ1JOVmY5MVBEVG1tTGZEbEh5RDJFVzhNb3NGNHNNb3Vo?=
 =?utf-8?B?SEJCeFZzR2Z6MzlaeGtBZVJzT2oyaHg0UW82OEplWUcxV2FvVUZyRzA1TWNt?=
 =?utf-8?B?K3REV2pTUGswelh0QmlYb1JFcm1ibVFsbEF4Sjd6VTFzWFBiYzRkcWMyb0tU?=
 =?utf-8?B?Z1QyQ3hHdDFSamdmYWxTRWRvY3Y3ZXpQSElJb04zWjl1SEdtNnNpaC9BWW9I?=
 =?utf-8?B?VkhyK2NtN3h1SHd1VkZYd0c1S1U5ZHlmTXNIcytKeE5CdFQxMkdjYnNmdVli?=
 =?utf-8?B?ZEtEVlZwNktZTFdndGEyMmNoODh2aXdhTW00WmJ4WThLQ1RaMm5iRFFPUU9o?=
 =?utf-8?B?VHhvbnhWMktoZW9WNkxkejE0bThxYVZhaGk4MndHcW5EVG1FeExNSXpNcjht?=
 =?utf-8?B?OFpjMEo1NVUvR2tMVHFpbUFxZ0NtYU4xalJjRjN0K2NLOTB5bm0zMm8yTXMr?=
 =?utf-8?B?cFRMeW9WdWMwNGxmM2tIR2dibnNkdmhXQXdlUXQxWk85c1NIM2Y1dVNoeTFi?=
 =?utf-8?B?TUtlZGVwVnhleGZXenZwdFlQR3VQRkdRc050cnZzdjJjYi9UaEFZYnArMTl0?=
 =?utf-8?B?cEw5RnN0UFVUdWxxckRRTXR5ZGg0U1pSeG93cWlCUDFaSUdmVjFXRlVVWk9y?=
 =?utf-8?B?QXJZUHJ5bkcvSjQ4WGM3cDJGM3lWUVo0RWJ5UFVqekNFdWhlQU81TmNsQ1dH?=
 =?utf-8?B?eE1vajdBZ2hnWjMvemppZzV4ckFDZGN4KzVCSjdEc2xrbGN0UkJzcWQxS3Ay?=
 =?utf-8?B?cFNpeVhHK0FRLzZpdFJoWnYwZk5pMnRONnJOZHpxVTBnNys0VmMrT050VkRi?=
 =?utf-8?B?ZVE4bVMrdDNDL25IeW5DVzdXeTNYcHE2TWxaSFh6ZU1JVUdrb0Z5VDJ6ZEpQ?=
 =?utf-8?B?K3YvUXE0bEgzdnVneDNqYmNGSkhNczArVzFySlVpY0cvcEdINHdvZFltbHov?=
 =?utf-8?B?ZzRiZitYTHhTRXlRWkVCWU1XNXdhM1Evc3BVaCtNRU4ycFltaXl3WVJ0a0gx?=
 =?utf-8?B?SFVYYWF2K0FQSURRRnpsYkdpQkhmTFk2T1Z6SHljNk4xQWpqVjVwQm5xZUx6?=
 =?utf-8?Q?2N507V1MInvQwSKWiscFoWoMH?=
Content-Type: text/plain; charset="utf-8"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3324e7ee-f3d0-424e-9ff6-08ddafd4392a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2025 08:26:58.2918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4jZ82V2u1GGDH0r6qWxSTdRpFrzIM3cPJjynbcspvLqrIkfqsLAXt9n+JWHOuFdH03BPvLcW8TnTvexz3gB33g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9939

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tp
IDxrcnprQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjXlubQ25pyIMjDml6UgMTU6NTMNCj4gVG86
IEhvbmd4aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+IENjOiBGcmFuayBMaSA8ZnJh
bmsubGlAbnhwLmNvbT47IGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU7DQo+IGxwaWVyYWxpc2lAa2Vy
bmVsLm9yZzsga3dpbGN6eW5za2lAa2VybmVsLm9yZzsgbWFuaUBrZXJuZWwub3JnOw0KPiByb2Jo
QGtlcm5lbC5vcmc7IGtyemsrZHRAa2VybmVsLm9yZzsgY29ub3IrZHRAa2VybmVsLm9yZzsNCj4g
YmhlbGdhYXNAZ29vZ2xlLmNvbTsgc2hhd25ndW9Aa2VybmVsLm9yZzsgcy5oYXVlckBwZW5ndXRy
b25peC5kZTsNCj4ga2VybmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207IGxp
bnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGlteEBsaXN0cy5saW51eC5k
ZXY7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2
MyAxLzJdIGR0LWJpbmRpbmc6IHBjaS1pbXg2OiBBZGQgZXh0ZXJuYWwgcmVmZXJlbmNlIGNsb2Nr
DQo+IG1vZGUgc3VwcG9ydA0KPiANCj4gT24gRnJpLCBKdW4gMjAsIDIwMjUgYXQgMTE6MTM6NDlB
TSBHTVQsIFJpY2hhcmQgWmh1IHdyb3RlOg0KPiA+IE9uIGkuTVgsIHRoZSBQQ0llIHJlZmVyZW5j
ZSBjbG9jayBtaWdodCBjb21lIGZyb20gZWl0aGVyIGludGVybmFsDQo+ID4gc3lzdGVtIFBMTCBv
ciBleHRlcm5hbCBjbG9jayBzb3VyY2UuDQo+ID4gQWRkIHRoZSBleHRlcm5hbCByZWZlcmVuY2Ug
Y2xvY2sgc291cmNlIGZvciByZWZlcmVuY2UgY2xvY2suDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IEZy
YW5rIExpIDxGcmFuay5MaUBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBEb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvcGNpL2ZzbCxpbXg2cS1wY2llLnlhbWwgfCA3ICsrKysrKy0NCj4g
PiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+
ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvZnNs
LGlteDZxLXBjaWUueWFtbA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3BjaS9mc2wsaW14NnEtcGNpZS55YW1sDQo+ID4gaW5kZXggY2E1ZjI5NzBmMjE3Li5jNDcyYTVk
YWFlNmUgMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3BjaS9mc2wsaW14NnEtcGNpZS55YW1sDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3BjaS9mc2wsaW14NnEtcGNpZS55YW1sDQo+ID4gQEAgLTIxOSw3ICsyMTks
MTIgQEAgYWxsT2Y6DQo+ID4gICAgICAgICAgICAgIC0gY29uc3Q6IHBjaWVfYnVzDQo+ID4gICAg
ICAgICAgICAgIC0gY29uc3Q6IHBjaWVfcGh5DQo+ID4gICAgICAgICAgICAgIC0gY29uc3Q6IHBj
aWVfYXV4DQo+ID4gLSAgICAgICAgICAgIC0gY29uc3Q6IHJlZg0KPiA+ICsgICAgICAgICAgICAt
IGRlc2NyaXB0aW9uOiBQQ0llIHJlZmVyZW5jZSBjbG9jay4NCj4gPiArICAgICAgICAgICAgICBv
bmVPZjoNCj4gPiArICAgICAgICAgICAgICAgIC0gZGVzY3JpcHRpb246IFRoZSBjb250cm9sbGVy
IG1pZ2h0IGJlIGNvbmZpZ3VyZWQNCj4gY2xvY2tpbmcNCj4gPiArICAgICAgICAgICAgICAgICAg
ICBjb21pbmcgaW4gZnJvbSBlaXRoZXIgYW4gaW50ZXJuYWwgc3lzdGVtIFBMTCBvcg0KPiBhbg0K
PiA+ICsgICAgICAgICAgICAgICAgICAgIGV4dGVybmFsIGNsb2NrIHNvdXJjZS4NCj4gPiArICAg
ICAgICAgICAgICAgICAgZW51bTogW3JlZiwgZ2lvXQ0KPiANCj4gSW50ZXJuYWwgbGlrZSB3aXRo
aW4gUENJZSBvciBjb21pbmcgZnJvbSBvdGhlciBTb0MgYmxvY2s/IFdoYXQgZG9lcyAiZ2lvIg0K
PiBtZWFuPw0KSW50ZXJuYWwgbWVhbnMgdGhhdCB0aGUgUENJZSByZWZlcmVuY2UgY2xvY2sgaXMg
Y29taW5nIGZyb20gb3RoZXINCiBpbnRlcm5hbCBTb0MgYmxvY2ssIHN1Y2ggYXMgc3lzdGVtIFBM
TC4gImdpbyIgaXMgb24gYmVoYWxmIHRoYXQgdGhlDQpyZWZlcmVuY2UgY2xvY2sgY29tZXMgZm9y
bSBleHRlcm5hbCBjcnlzdGFsIG9zY2lsbGF0b3IuDQoNCkJlc3QgUmVnYXJkcw0KUmljaGFyZCBa
aHUNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNCg==

