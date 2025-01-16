Return-Path: <linux-pci+bounces-19932-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE59A130C9
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 02:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D780A161FC8
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 01:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F3136AF5;
	Thu, 16 Jan 2025 01:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="enNDxAIF"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2051.outbound.protection.outlook.com [40.107.103.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A4824A7ED;
	Thu, 16 Jan 2025 01:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736990991; cv=fail; b=rg8U4Tnc3U8WXX4eU01+C99rPKq2LiQhyP7Wf2xfGQlhW+d96KY826ihuR/IDTSzAYAxl6p2EFaaQlGy3JxXXCwgx2d3idLOwulpeoEptzlQibEYKZBpfMrROOkAohvnSovfmKEjLFUUuDoj0hs8zMQaXoVg4quIFcHHPIubUbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736990991; c=relaxed/simple;
	bh=WD5Y/v0d0xAT9HtnH5CPNA7HNyMt8JSzNtsL8PvlyZQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rWdWkeyojtgK08NMP9GSPlLt8v4sNNGbMgzV2LT5N8kVrus8OI/ezhRGlQ6L6cANSbTiDaLOG7YhrrGjam+hivZ65geBTZcBQGv037I3rqZLUXLIQ3EunbnskvHPXVEV4WXrsXT9SKN25Gd7RDrtNHFy+Rn0Qk6FT9FsU92rP4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=enNDxAIF; arc=fail smtp.client-ip=40.107.103.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cgL2JxJC5DaXpT3qfaE1uB1Bns0YoIS2e2qlDTlF/xDxctFFjb0hlVC3Zdee8dFkRumfGGegL5Duoz47H2C5RnXu5TEuQrsoX6E4MVKaNImg97mwWEI85lmAUSnqhymVLGs6UsNbZXrTSWOPJqTPK4NiIOAMMLCFL3HMxarTyxsRfZx7IVqjEADK5naWkYHhata+mpAz0l9SG73KGb7onQIc8rsjytZNBHbEAHfILWTPvMjI6Ejn4+Xa0Txt0n5X+gNtw5MVkSwLt8FYXKR75rIngZKeF6DrrtZuMLVgXRYuoaO6ag0YPCPpnpHX0AUga5c5NPPq6o39eFv8M9SA8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WD5Y/v0d0xAT9HtnH5CPNA7HNyMt8JSzNtsL8PvlyZQ=;
 b=H2vAPplgs8CUFVSpYvlMBS/4pCYd/vWya1bpYd3ckyz5JhrkUYtg2yuI6e8DFGn8n199vHBEci+I6OArKsQV4wSfIXq5vproJQ1p22buhoqTRyZsUX9wPOBSZ4M+ihUdwAi38Fhpdty/fizuzyOP7oTPHZ+8M+IHE1NMjGFfbZuKV6W91+y/f8Wx+BkYCMRXEhxkTKn1yzS8XHwvgOmR2zVH2lQiA9TAVJ6TF1198WvgHW7VLWGNC9+uweMy2uNhB6I7kgFcGgyIJOjKM7KynKRbD1WcXdKIZIgH27U0YCEXWXZHVI5LjBvEpe9GkowUCIeLexHHAaa2IlFhm7c3tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WD5Y/v0d0xAT9HtnH5CPNA7HNyMt8JSzNtsL8PvlyZQ=;
 b=enNDxAIF4RK77puUrYtTzHqUx0+VXJz3fC7NSzAbE2Ak6wRSKCd0nOFZQ+ZbG/CWE7n98eUwMUqYWxHr1+F5U0wmvz7xD3KqmV2bRHM4Kkf9LbWsiHiYILKGsUtYjq1MyXR8g4eLslaMTSdHLT+wVj+SUdzGXWMqs5Ahi/09OBLs/saAOvh/MMWBgMDLadGdiR0MgCaSXAhdG3swYuZsv3QLPRN8K3XthhhGwQccja1KkHKwTAIRKf3puFal/CXVyOMWS3OGQke6eJ3jbMMpJJzLJQBnvzGrsZV/f42mAn+eN0n25bNG6E7g91Lqr7q65lYrof/rdXe4gcYdLCFtIA==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by VI1PR04MB10051.eurprd04.prod.outlook.com (2603:10a6:800:1db::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Thu, 16 Jan
 2025 01:29:46 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%7]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 01:29:46 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: =?gb2312?B?S3J6eXN6dG9mIFdpbGN6eai9c2tp?= <kw@linux.com>
CC: "l.stach@pengutronix.de" <l.stach@pengutronix.de>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, Frank Li <frank.li@nxp.com>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v7 0/10] A bunch of changes to refine i.MX PCIe driver
Thread-Topic: [PATCH v7 0/10] A bunch of changes to refine i.MX PCIe driver
Thread-Index: AQHbP9jXnZyijDiwZ0KRW94pfUZFC7MYHDgAgAAAk4CAAM5w0A==
Date: Thu, 16 Jan 2025 01:29:46 +0000
Message-ID:
 <AS8PR04MB8676BD2E443B72DFECAEFEE18C1A2@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20241126075702.4099164-1-hongxing.zhu@nxp.com>
 <20250115130406.GS4176564@rocinante> <20250115130609.GT4176564@rocinante>
In-Reply-To: <20250115130609.GT4176564@rocinante>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|VI1PR04MB10051:EE_
x-ms-office365-filtering-correlation-id: 08ed13ff-bd72-4645-af54-08dd35cd42cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?SXR1QjFBVUpKNVdnY0hnZXEydWFleEZuVXNGYnZmN2FwOG1UWUlFeU1hT2Yy?=
 =?gb2312?B?YncyMzVucEc0MVBvUk5hY2ZGMFdDY2hEZnpmd241NnJoNHZFek1IKzE4Qm5p?=
 =?gb2312?B?ZnY3R0tiZk9aK1gvSlFORThHeVd5SHhUYnhYUDh1aWxHa2w0eG5ISWsyUnVx?=
 =?gb2312?B?Z2NqdlJLZ1FHR3lZN0ZQZnZzUzBvS2QrOExtZUJxenQ2OERjYzhYTGptL2hY?=
 =?gb2312?B?VHI0eGRlSW9YMmhzcVhxTTViZUN6Vkd0Z3g4bEppNDg0Sk9oY0t6VExWa0gr?=
 =?gb2312?B?MXNTczB6Z1Q5UjRtNkxnbU1WeUdjaGtVZWZQeEpRd2RXZ3pXRXFxcVJOOVNG?=
 =?gb2312?B?ZWkwaUZRalJSeUxWVk5rdWNyT2JPRG44MUZjZ0p2UXphdkZkb2Q3a1c0V21r?=
 =?gb2312?B?RWdHZDdsUENSWnVpM013bkJPbUFyZlVZejFubVhEUW9UZ1YyeG1VaVlDMkpM?=
 =?gb2312?B?WG5oYXY2QURMaGdpbzc2SGhLMEFZV2lNUUpIY0s2OU1pazI4NWFqa1BzeUsy?=
 =?gb2312?B?cUcwTlVQVEEvUlJ0aFM3VEdYMytDQkwyYitEczVPYk1GVlJxNkE0NGMzU1hv?=
 =?gb2312?B?SWErc1cvd0hCa255b2dpeWVWZEowa3B0Vk81dS9WMzM2ZnlsWU5SVzZ4czNT?=
 =?gb2312?B?WHFkTHU1S3pBOVFEK29UY042dkZjck5BYVgxcmMxTitoRVpjdi9lTmhvKytP?=
 =?gb2312?B?RnpuZEx4S2luMW54TThkSFZiMmt0eGVaSGlhR0llSUhnSDVvb09NbHkwYXVJ?=
 =?gb2312?B?eVNja1Z6RWRQRWZQb2g5L0d1c3JqSk1ZOTMwRnhDcUN6VXpVbHhkTmdQbHJB?=
 =?gb2312?B?VTFyUFB2anQ1MlVOQzNOWHpBWmlPYlZiUzF0Y1A4c0s1cFE5Z3ZJdHZrR0lt?=
 =?gb2312?B?bmFlbkhqaWtxeGhib2lZK0V1QndkSC9aWjh4SGZaMkMvZytTU0pvRzNhcTRO?=
 =?gb2312?B?OE51NFRkdG5VaWJpeTVzd1hjdDM2YWpKTGtGdktabXdsdUlWZ2FZd0RMTGh6?=
 =?gb2312?B?UzB4ZysvTjVkTkllZ1VWNEZ5NEJzQm85TVMzdDdwd2U3NkV4RjVOOFBMWlZ4?=
 =?gb2312?B?OVpQeHJGeDBCd3VDMmRGcGZuN2ZTZDBWUjJhNTdOdjllZnYwNkxzUGdSbURj?=
 =?gb2312?B?NW82c2tOWGsxT1gzYk16VGFUMS9VelBOMWJDNExzOEVmN1dVUGFBT2dPK3hX?=
 =?gb2312?B?L09IbTlGcGVMRFVpdENGclh5R2h4M0UrUlBRcmVsbHBGTHRtVkJJdVJaTytU?=
 =?gb2312?B?NlZaRzhlQmRYYUY4dm81djQ4UEZPbjhZTklFR216RWtweTZOZjRWTlh5OUJX?=
 =?gb2312?B?OUtZZGFGMmlDbmQ3OGtkb0RYMDhGM1JLemw3Y1ZIVU5SRklMRkI0ZGEyd2Jn?=
 =?gb2312?B?Vm9TM0ZNK0lMcUJYRkx4YWZuOTVKcnAxS2U1N01XTkxDdUdMY1FINDdtVmpj?=
 =?gb2312?B?akJRekp2c0N2d3Nkd0lBNlhLbTkyaE16cS82S2pjMG9zbU5XZnRWdGRIV2ps?=
 =?gb2312?B?ZkFweDFydGtsWXJRa0NzK3d2d01tbi9XMG9PRUlkQkVOb1Y5clY3cnpzZWxl?=
 =?gb2312?B?aHhqclgwSjJ6VTgzTUxKOEo4aTN3QytLaE96NlY3Z1lPN0F3cUp5MUNicmw2?=
 =?gb2312?B?T0tnLzFqdXk4bk4yWU16ZGpoaFgvSWk3QzQ2NHlrNzJPUDV0dDJFaHJkdnhH?=
 =?gb2312?B?b1Y3ZzBXdDRQOUcyNXBjUU42TmNjK1RSUHJmcWJORWFWUW9VdlNYQnFIc09a?=
 =?gb2312?B?VG51bkJFN3o0cmxleGFlcWF4QjZuMldZWUVNOVZJRExudE5GS1B1RzduTUcw?=
 =?gb2312?B?T0xJeWN6TTQ1SXlITmsvaXZTZzNQOHZLWTBrT3hKMFRSWFpwbDJTWHNua2Qx?=
 =?gb2312?B?SldabUI4QitZSnBZM3dBQThDTy9KUTVDSUtTNFA0RGtVdGlFZk5EQngweEpE?=
 =?gb2312?Q?0c8MiJOZv9YaYttym7/qEUmfk+jt/is/?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?aCt1ZTU2SG1zUFVWT2lMeTZ2MVJrdG1TcjYvQXhZQ2FjRmJkZEZReUZlN0VV?=
 =?gb2312?B?RGxPcXh2anZ5ODVTWGd6V2dIN2taeG9lKzkyQUxNdExSRk1KTStteWhPNUts?=
 =?gb2312?B?bU5wOWZFanROQUxLNHlWYjdldXhIT3lWQ1c1NmU4Y3NCUTBMVTg0cmxwWlJY?=
 =?gb2312?B?VUdFdE03eXFxNXhrL2hETjRqMjlwZzMwRmdNV2ZYVTRDWGwyQ3NKYVViUFFH?=
 =?gb2312?B?MTBibnlzN1REd21ldjNEN09TNGJNSzlDRThNcnJKWmFzb3RrQ3Bsc0h0WXli?=
 =?gb2312?B?Z0lGSWdLaTVBdW9rMkxNeVVyelNGclFDcGVqZmpkcFJHRjNIKzNPekVHdExO?=
 =?gb2312?B?NlIxUklObXp5c2kvVThNam5QVmk2ZTloQWFHR1JJODdHTUhKSmVDWnVMVGpL?=
 =?gb2312?B?ZTMxa3JiR2hpeW1KVll4V0duaHVlakUxeDFxVXNWNHBTbi9RaW9MVjNmZk9Y?=
 =?gb2312?B?QTJ3bUcvS0ZUa1BTN2FTdlBDZ2hOUEFWTkU0dXFnUzVSTkNlOTByblNjWDNx?=
 =?gb2312?B?TmZVallBZXFRQ1NTVSt6T2h4Smo0SHp3anZFV0NiQnh4d2ZEemlOeUE3YWpr?=
 =?gb2312?B?dUMrakpLMnNNQWx5aG1hbWkrUmxhMnZaTjRLWWhNc1ZiQ1RwQUcrSC9lMEI3?=
 =?gb2312?B?UUlTdUdSMDhPcUROMlNaNzJMMCt4bWx5bXNac0dFWFlUUjJza0RpcHFySms0?=
 =?gb2312?B?dGdFN2RxSEh0OE9YTHBnYzJTbVFHUld3MmhDUGxoUk9SaWJJVTdWdW45Y042?=
 =?gb2312?B?THdKQVllcEVYelJYemg5eTVaV010M3gwalVSbUlwV2lObmJzQXJ6eDFaQWNO?=
 =?gb2312?B?SnRnNk56Qm5nUDdMRDQwY05tYU0wbEpLdXFvdzY1OEZjb2RyY2NwZVRYejNn?=
 =?gb2312?B?ZHZybjQxU1lvVHRDUUNIYVc4STJVTVlQU2lpK1hCT1B1RGNGYys5MTd6NGJt?=
 =?gb2312?B?NmVZenRNVlh3M3lsSjJUbGhnK0gxYlZjTmV1b0Qzdk5XVm1sZXlZOEE4b3d0?=
 =?gb2312?B?TWFhVWhkU3lpOUFvRC9UTXExTHFXdTJ3NmdObTgwb0k1bjFrVm9jS0RpME9Z?=
 =?gb2312?B?a05Yak5aMDNiNU5EWi9BUFBFZ25MQzBHNHZNU3l3VlBmV1dPcGlJOVFERlBJ?=
 =?gb2312?B?aDNrK1BSSEFIMXB2Zjd0K2Y2REd1Q1JTOW9uV0Jib09hbVdqMk50b0xsWmdJ?=
 =?gb2312?B?TGpwY0hmZ1B5YTRxazBHcFJRc2JMT3BISnBJNmFnQkY2NjYzMiszMGdaRkw2?=
 =?gb2312?B?SUM1TVptK3Q3Tlhrc3piTFNKSTN0UUhPemtoQUZwSGZEWVdLZyt6bWZjYWZz?=
 =?gb2312?B?L1pydUNCblZteWNEejNaSnppYkJiWGZ0OVdVU1luY0M3S0hBQjMyeU1Md2U5?=
 =?gb2312?B?NTcwUUI5WUp4L1p1WU93WGVIT1pZK21FeldMVi9TNGJrcHVicVZWV1pIdUk0?=
 =?gb2312?B?SWh2b2lPOFA0VEVpYnFEaTRnMXhvRWxDSlVLajFYZVp3c0tUODl6Wm80NU5C?=
 =?gb2312?B?ZE9CZGRUSVZOU0g5a1kzbW0wdnkyVlM2c3VCYnVOcG9iaEpjckdoU3NOVlF4?=
 =?gb2312?B?RU8yazlGRUlka1hUTjFGWTlpUkt3OWhGSmpHTTZHZGU5Q3FXUlk2QjI3N2J1?=
 =?gb2312?B?SEd1ekFLM3ZIbmhiQS9TZmxrNDJjQ003Vkpvblh5Tno5OUxveVBzRGtCTG1N?=
 =?gb2312?B?VWZxaVhXMEhURzNMVVljUVNuTTBlQS9kamZId2JNanlla0I3a1kvUXRTUUc2?=
 =?gb2312?B?NlUxcDUyT0VZeWM2Mldlek94aXNUZTdza3lMSUhwUzVoWS9BZ1F1VEk0ZnZV?=
 =?gb2312?B?Y3JjTmFSVjNyZkdEZXBaUzJyc1UyZ3JCYVJXMHBnaEZxeDc2VVFrZ3FIaUZm?=
 =?gb2312?B?M1lVWWxDWGd3Z1FySEN5L20xTGRxRnMyazByVkhtWTVndGJaVVlXZXVnZXJw?=
 =?gb2312?B?QUd1QmtvOC9wNmFTREtTQ3VXY3NTRHZ2bElWQmZwY05PbG9helI2N0tNQVhJ?=
 =?gb2312?B?SE1xajFOeXVWdzRwSE10WTF3ektQY0FoK0hSL0xMeERDNnhZcSswNlI1czF5?=
 =?gb2312?B?UjVyOXBYU3p6USt3ZFlFcFhSa2svVk5QenlRK2l5Q0phTEMzNURLSHZuRldx?=
 =?gb2312?Q?dk8dTe8k9FrSxGCf3NUHZKZOZ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 08ed13ff-bd72-4645-af54-08dd35cd42cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2025 01:29:46.1436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1RmDQjkSoQpaIVfVCqUx38uh8rmteGGmyER6rJarVFEUbJjdcRcj2vc2aVovxVX30u8gVjRyK/3hVWrjhDcLFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10051

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgV2lsY3p5qL1z
a2kgPGt3QGxpbnV4LmNvbT4NCj4gU2VudDogMjAyNcTqMdTCMTXI1SAyMTowNg0KPiBUbzogSG9u
Z3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IGwuc3RhY2hAcGVuZ3V0cm9u
aXguZGU7IGJoZWxnYWFzQGdvb2dsZS5jb207IGxwaWVyYWxpc2lAa2VybmVsLm9yZzsNCj4gbWFu
aXZhbm5hbi5zYWRoYXNpdmFtQGxpbmFyby5vcmc7IHJvYmhAa2VybmVsLm9yZzsga3J6aytkdEBr
ZXJuZWwub3JnOw0KPiBjb25vcitkdEBrZXJuZWwub3JnOyBzaGF3bmd1b0BrZXJuZWwub3JnOyBG
cmFuayBMaSA8ZnJhbmsubGlAbnhwLmNvbT47DQo+IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGZl
c3RldmFtQGdtYWlsLmNvbTsgaW14QGxpc3RzLmxpbnV4LmRldjsNCj4ga2VybmVsQHBlbmd1dHJv
bml4LmRlOyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjcgMC8xMF0gQSBi
dW5jaCBvZiBjaGFuZ2VzIHRvIHJlZmluZSBpLk1YIFBDSWUgZHJpdmVyDQo+IA0KPiBIZWxsbywN
Cj4gDQo+ID4gPiBBIGJ1bmNoIG9mIGNoYW5nZXMgdG8gcmVmaW5lIGkuTVggUENJZSBkcml2ZXIu
DQo+ID4gPiAtIEFkZCByZWYgY2xvY2sgZ2F0ZSBmb3IgaS5NWDk1IFBDSWUuDQo+ID4gPiAgIFRo
ZSBjaGFuZ2VzIG9mIGNsb2NrIHBhcnQgYXJlIGhlcmUgWzFdLCBhbmQgaGFkIGJlZW4gYXBwbGll
ZCBieSBBYmVsLg0KPiA+ID4gICBbMV0NCj4gPiA+IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnBy
b3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxrDQo+ID4gPg0KPiBtbC5v
cmclMkZsa21sJTJGMjAyNCUyRjEwJTJGMTUlMkYzOTAmZGF0YT0wNSU3QzAyJTdDaG9uZ3hpbmcu
emgNCj4gdSU0MG4NCj4gPiA+DQo+IHhwLmNvbSU3Q2JmOGI5MDI1ZThmZDRkYTI2YzlhMDhkZDM1
NjU2NDI0JTdDNjg2ZWExZDNiYzJiNGM2ZmE5MmMNCj4gZDk5Yw0KPiA+ID4NCj4gNWMzMDE2MzUl
N0MwJTdDMCU3QzYzODcyNTQzMTc4NzM0MjIxNCU3Q1Vua25vd24lN0NUV0ZwYkdac2INCj4gM2Q4
ZXlKRmJYDQo+ID4gPg0KPiBCMGVVMWhjR2tpT25SeWRXVXNJbFlpT2lJd0xqQXVNREF3TUNJc0ls
QWlPaUpYYVc0ek1pSXNJa0ZPSWpvaVRXRnBiDQo+IEMNCj4gPiA+DQo+IElzSWxkVUlqb3lmUSUz
RCUzRCU3QzAlN0MlN0MlN0Mmc2RhdGE9NmpZaUdKVWpReU05T0E4amduJTJCNk9HDQo+ICUyRnZS
JQ0KPiA+ID4gMkZRVDV1dmxLbmZPM3ZZakViOCUzRCZyZXNlcnZlZD0wDQo+ID4gPiAtIENsZWFu
IGkuTVggUENJZSBkcml2ZXIgYnkgcmVtb3ZpbmcgdXNlbGVzcyBjb2Rlcy4NCj4gPiA+ICAgUGF0
Y2ggIzMgZGVwZW5kcyBvbiBkdHMgY2hhbmdlcy4gQW5kIHRoZSBkdHMgY2hhbmdlcyBoYWQgYmVl
biBhcHBsaWVkDQo+ID4gPiAgIGJ5IFNoYXduLCB0aGVyZSBpcyBubyBkZXBlbmRlY3kgbm93Lg0K
PiA+ID4gLSBNYWtlIGNvcmUgcmVzZXQgYW5kIGVuYWJsZV9yZWZfY2xrIHN5bW1ldHJpYyBmb3Ig
aS5NWCBQQ0llIGRyaXZlci4NCj4gPiA+IC0gVXNlIGR3YyBjb21tb24gc3VzcGVuZCByZXN1bWUg
bWV0aG9kLCBhbmQgZW5hYmxlIGkuTVg4TVEsIGkuTVg4UQ0KPiBhbmQNCj4gPiA+ICAgaS5NWDk1
IFBDSWUgUE0gc3VwcG9ydHMuDQo+ID4NCj4gPiBBcHBsaWVkIHRvIGNvbnRyb2xsZXIvaW14NiBm
b3IgdjYuMTQsIHRoYW5rIHlvdSENCj4gDQo+IFJpY2hhcmQgYW5kIEZyYW5rLCBwbGVhc2UgaGF2
ZSBhIGxvb2sgYXQgdGhlIGNvZGUgdG8gbWFrZSBzdXJlIHRoYXQgZXZlcnl0aGluZw0KPiBsb29r
cyBmaW5lIHRvIHlvdS4gIFRoZXJlIHdlcmUgc29tZSBjb25mbGljdHMgd2hpbGUgSSBhcHBsaWVk
IHRoZSBzZXJpZXMsIGFuZCBJDQo+IHdhbnQgdG8gbWFrZSBzdXJlIHRoYXQgbm90aGluZyBpcyBi
cm9rZW4uDQpIaSBLcnp5c3p0b2Y6DQpUaGFua3MgZm9yIHlvdXIga2luZGx5IGhlbHAgdG8gcGlj
ayB1cCB0aGlzIHNlcmllcy4NCkkgY2hlY2tlZCB0aGUgcGF0Y2hlcywgdGhleSBhcmUgZmluZSB0
byBtZS4NCkJUVywgSSBzYXcgdGhlIGR0cyBwYXRjaCBoYWQgYmVlbiBxdWV1ZWQgaW50byBwY2ll
L25leHQgdG9vLg0KSXQncyBiZXR0ZXIgbGV0IFNoYXduIG1lcmdlIHRoZSBkdHMgY2hhbmdlcyBh
ZnRlciB0aGUgZHJpdmVyIHBhdGNoZXMgYXJlIG1lcmdlZC4NCg0KQmVzdCBSZWdhcmRzDQpSaWNo
YXJkIFpodQ0KPiANCj4gVGhhbmsgeW91IQ0KPiANCj4gCUtyenlzenRvZg0K

