Return-Path: <linux-pci+bounces-25905-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D90A89382
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 07:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 150401891DD0
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 05:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1334E1F4C84;
	Tue, 15 Apr 2025 05:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="T61dxK40"
X-Original-To: linux-pci@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011022.outbound.protection.outlook.com [40.107.130.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0D32DFA3B
	for <linux-pci@vger.kernel.org>; Tue, 15 Apr 2025 05:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744696285; cv=fail; b=bR/EopZWL0nxMhhGNQcBsm3Dxzzlyg7cLlU/lHnpQiIgluc2BnNYUHM9q3EKqHFlAjDvxxUOISrz5dNqZqxscz8XGmWsvjSQTTEU5y9pKxTdRWJ2H1SlWxruj3oz4tcViyEcoQMoLr/6HOeoX6F6u9OShIsLrJLDauRx6H8WFgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744696285; c=relaxed/simple;
	bh=r/8/UfMOJ6L6xp0vB5V/RngiMZ+jt85LB2Edm8RHr9c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cHMauYX94GUumSADBZLcHRgkR0RWr4uRVz3m9AE9PORP6rpm4lmDf6Ajonwz3HaBeW3+ayKyyJ3FFmFtLyCE1I3VSCf7AsZSnHABASB9OM30fVQiCvyWaBI+vDsDX+rITSigd3jtpTWNKTKvFip8JR2RytT/PI7/ZDSf9L05OkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=T61dxK40; arc=fail smtp.client-ip=40.107.130.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vcl3RHoSm1WXnC14bMNEWVIYwk8fgv5Dd+UeEtF0bo5SAujIItQfPVuL27HeDg6h1e6Hm1bhQlHkp/huL/Iio67UzBcoZbAaOcbvpQ7amcL4VVo5TZwZCWn5ogvBCJmBAFyPr9L8wc2U+D2FaUKHuEslfEIdOQkBay9xsAsVhTH26z1c7qaMEKliOeDZgT9izJcej5QDxeL5SxtGY0PpH63PpyL2PTbbD+turKt+GZk75Hb2PPkoDawu7VWnaBoRfBeNQgP7MXPRZq/jCOf4K1nH0P/1RrlN01sosRg8X9wSL8j4uMdooqfa+0LEbAjehHEpkvzq3zU6dpRHbk9lgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/8/UfMOJ6L6xp0vB5V/RngiMZ+jt85LB2Edm8RHr9c=;
 b=utNsL9afEBuMzQQk6Ly2vUVx/U6I2PLCBYVNaeKYx3tBehNzsGDcI69Rn3VYr96VIq/pbgf3aWhL9fzzcP8SbaPT4EpcCGL0SWeFdhvkw6zdcfTXTBYJ4Qy6cWY8lspfHrqVhtb/DIflXQYZA+aXLoOoLwJrw5Nmz2087/zgQEA71dYnppeviBqFHmRICz+GDhSTXaVBLm9p4KKHG2qfr1daT+KvbJ2kgvu+FmJn3Pwrn+LdPrU+QBAb7nqVanc6f2VZXGhRo8XIxkjehP5/SG6NQFmuxyQpo45DbkFusvybkWkXWcGeML5gQaOodH2I1YcGUTqZ2zNQlJU4jQyu/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/8/UfMOJ6L6xp0vB5V/RngiMZ+jt85LB2Edm8RHr9c=;
 b=T61dxK40O0y3cTxj6svCGcApNtP2raI3iKPWUvS0qZCvPgAFHFTgUlF0kx3lvwg0756QAckEF568m9EF73fjrn8Yj9uNRIME20QorkKQpl978FW2nzvyLiYj7ibOPZMNa9EZYa1NQgg8NHRjW6wcmiokbSqAEritFcK7x/VPxkAHeNW8wLbzdkG1d/446HePWVe7nHU4nYnJ1FRRfwTVeBk8arCMc3gRun52UzVl5fXly705A+6mn7wPDWhKVkZ3xQ01VUHrtNGsotBg6wYD8ZKt0V1sH5nRFOMvlyN9LhxG0c1cD2zzPVtJmu1XUYIxtwhLU0rEE3Y2Em945bkapg==
Received: from AS8PR10MB6993.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5a4::10)
 by AM9PR10MB4133.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Tue, 15 Apr
 2025 05:51:17 +0000
Received: from AS8PR10MB6993.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::380b:e782:af48:75d4]) by AS8PR10MB6993.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::380b:e782:af48:75d4%7]) with mapi id 15.20.8632.025; Tue, 15 Apr 2025
 05:51:17 +0000
From: "Li, Hua Qian" <HuaQian.Li@siemens.com>
To: "huaqianlee@outlook.com" <huaqianlee@outlook.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	=?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kw@linux.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>
Subject: RE: [PATCH v7 0/7] soc: ti: Add and use PVU on K3-AM65 for DMA
Thread-Topic: [PATCH v7 0/7] soc: ti: Add and use PVU on K3-AM65 for DMA
Thread-Index: AQHbrcmy7DNFcXxP5U6NYNB72AiNNLOkOFZQ
Date: Tue, 15 Apr 2025 05:51:17 +0000
Message-ID:
 <AS8PR10MB6993E1EAC425CA97D768431E9FB22@AS8PR10MB6993.EURPRD10.PROD.OUTLOOK.COM>
References: <20250415054549.611747-1-huaqian.li@siemens.com>
In-Reply-To: <20250415054549.611747-1-huaqian.li@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=8b587485-4a9c-4052-af10-8423c84cb202;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2025-04-15T05:48:05Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
x-dg-rorf: true
x-dg-ref:
 PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcejAwNHJoNGRcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy1hM2NjMDViNy0xOWJkLTExZjAtOTExNi03YzU3NThkNzNiNDFcYW1lLXRlc3RcYTNjYzA1YjktMTliZC0xMWYwLTkxMTYtN2M1NzU4ZDczYjQxYm9keS50eHQiIHN6PSIxMDkxOCIgdD0iMTMzODkxNjk4NzQ2MTkwMDQ3IiBoPSI4VkEwanVUeWZ1eXhZMUNIenpLWWxhYUpEZzA9IiBpZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFIQUFBQURmNkNObXlxM2JBWHdNaTZ0OXkyc2JmQXlMcTMzTGF4c0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFCQUFBQVZQNlpCUUFBQUFBQUFBQUFBQUFBQUE9PSIvPjwvbWV0YT4=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6993:EE_|AM9PR10MB4133:EE_
x-ms-office365-filtering-correlation-id: 110aef80-b655-40ec-b0fc-08dd7be18a82
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?utf-8?B?cVlIZUN2R1FHN0tkRmhBNUMrZXkralRrc3hYeVRUSUdNNVBFMW16RVA5ZXhN?=
 =?utf-8?B?YmJUWVB3TUhEY0pNTzkvTU1ZY1MzZWhrSWVlcXpQdHdRQ0c4VFVRNUpzaHdL?=
 =?utf-8?B?bW00RVdoeUJVWWpGZlpaZElYYk9WbnJQZkx0YTJpOHRwa3doK1ZTdDQ2VWg4?=
 =?utf-8?B?cFpJMmpubkYveitEa0JpRmFBVWhYK1dEWUE0dVdIa0V3eWh2cXptMVBYa3Ji?=
 =?utf-8?B?NnRtRlhSL0tQUFZIU2Zna3NEL0w0akRUOUJ3RE5ncE14MDZpRUpKRVpYNFA4?=
 =?utf-8?B?ZFpyNTgyVnJzV3E4T00xZDdVN1JIb1d3TVVtaHpKa0xVTUtZU0h4OUZTNmZ2?=
 =?utf-8?B?WW9mOEY1RzRkTDZmOTBnbHFRTDBac2Y1QksrSHR5eUNKUFE4WGVSaWtEY1Yr?=
 =?utf-8?B?V3Zoc3BJM2pmNE9QVW0xOTJkZm9CMVBDeis3MUJBOWN2RmRBRE1Oa296czl6?=
 =?utf-8?B?K2Y3WjVqaGpYNkNWL3NJdU4zNExUMVhLajlqTzA2WWRRQjZtYmZwdUZRV0pp?=
 =?utf-8?B?M3ExdGloMnZJcnlXNUZLRlJFMEg1ZVJ5a2JhVGplR2tzRVhVOFExWU1LcmI0?=
 =?utf-8?B?dkU1V2hGcFV2b0R6dEFxNS9jRmg5MHNPSUNYUks0WGJnVllheWNuZEU2SGhu?=
 =?utf-8?B?UHBOR2gvaHZZSUZUZ2NuSy9SL2Zac0t5UXRxb214eEVYWE5qeUVzdEhTSHM4?=
 =?utf-8?B?NS81cDF1Q1VDczNnVUk4alVEc2Q0VkZ4bnZ2NDdLdCtwZ0tYZWhobit2KzdM?=
 =?utf-8?B?SnB2cXd6TDBQNHpmcEpRendabzh2THVyREFRRVpJdWFFNTQvbEhndmdGZ25j?=
 =?utf-8?B?RXN4Y3RQN1dQRGl3RjhPVlVOb09QZmN1OGhMT0loVndFaHVJWHRGb3dzSUdi?=
 =?utf-8?B?M3FOWElvSHdyVWJ2eC9BT1JFMUlOZkk1d2E3aWRPVUwyMmtwSmFiWEhybHVF?=
 =?utf-8?B?TkFTUG0vZTdxaWJxN21aZCtHbktTeEFBQUwxUnYzVktUR3BxZ1l0bHdseVh4?=
 =?utf-8?B?MXNsajRqbXU2V0s1SHFnd3h1VkpiL1YwWkJyZHRMbGQ0eDhZZjJjeW85ZHlr?=
 =?utf-8?B?TTNwZldNNUd1cFM2Z3FxTngvQ1d3eTdmWWxJZVNnWVJNamhMQkREWmRXUXNV?=
 =?utf-8?B?RjJLUmFiRUIvZUp0aFZEKzJ2djFyQURjR3N1bWJ2VytRRlIxOFhGRW9wK2tL?=
 =?utf-8?B?ODJkRG5NREhqcnZURFVUSkhBTkdnN1hzYTBDU3FBWVBaVE9jMzFUQ1MwN3Rt?=
 =?utf-8?B?K29EV1ZVcUJPZDB6MU9jL084d1VWMFEvUmZLWGFzMkliQnQxQzBqdHljQWsy?=
 =?utf-8?B?QWVRSVJaWkpnQW1hUEZveGZuZ1BzZWNSV1RubHhmYkZpV2UyOXZnbjVJN212?=
 =?utf-8?B?M0UybGc0VlNOVGNTM1g2VVVtK0pHYnFhVXA3WGl3QkczZ0dOZFZqRnpHVndM?=
 =?utf-8?B?RU90YzJqcXVtdXVKZjJXS1RwUSt4NWJVZDZ0ZzZQZkZtN0grclgvWDMvNFow?=
 =?utf-8?B?cjNMZ2FDYmVSNXovbnZWVzZaSXoyeWdwVmU0Q3lEVXdlaE9EYU1RQkRSaGRp?=
 =?utf-8?B?U0NHSlVncmlwYjIvM3NCT1RhVXdtMFZOS2JKNytGYjhCSUFEeGI5bERGN1po?=
 =?utf-8?B?ZXlrVWVheXg2SnhMNlBxZkJMaFFxZzUvRG4rUmZZN2U2YTcwOEI3Zk9rWjJr?=
 =?utf-8?B?cHRmWTVkejZpUlZnZjlVR091OGVpekxXQXd2M3JSb2J5SXd1ZmdjOGtrRHlL?=
 =?utf-8?B?YS9Qa0t5SElZODNvZ2RPNjFvUUtUMWtRSkJvZEhtTkltbERrR3V1OWxIaFdR?=
 =?utf-8?B?YXVJQ2VNRExDVHY5MXFQQmF0Q1dRVmZ1MFQ2ZUNLZHhvUEkzUzlFWmh2eXor?=
 =?utf-8?B?eStxV2NqSXlRZG5GR3dXTEVxMk1PaE45YVJzTUtzaC9jSU9EZ3drdUpHRjJS?=
 =?utf-8?B?WWo4bDVsUzByWnJlcCtPczNyZFFOQTZJTWRPa2VUWW9vUkJtZHRMc0NPbXE0?=
 =?utf-8?B?eitoZDcra2RRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6993.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bmZCbTJ4RVBnM0tERXlxcEVTRXpTeXpXTWhJWHRuZWZyanFueTBmSjIyWk5D?=
 =?utf-8?B?VncvQWRnL1U1a3REcThGZmlQNEJiSzdmc2o1a0l6ZXhPRzA0cU5wODZidjZP?=
 =?utf-8?B?WmM0VkhDZWtsUWV4a3V6bGtBUk5JQmNPY201cmc5cCtEY2Z0bVM5eVVRYnJa?=
 =?utf-8?B?OHRRMjRhVFhvcVJCemd5S0owOHQxMmM5amhsVUN6TTloY09HSnVaNGJLakNX?=
 =?utf-8?B?cURSNmRLOGFTRVpUQnJubSsrSmxJbm1RQ0JZS09ueE1ESkIvR1phNTBzZTRp?=
 =?utf-8?B?TWxpc1pGMDZNZXJyWW8wWS93eklSejZ1ZUIvSlNUcEs0VzcvQlEvZCtPSGkx?=
 =?utf-8?B?YWt2RzN4b2N4RTJzRTdObmNsaHNBcFIrbk5ESzBFbkpkeWN0WUJlK1VPRzlJ?=
 =?utf-8?B?SjJPYU16cmFtR1lxaXI3ck1iUGFPRHNoa0U0ZVVpWllKeHBJUFl2dGJ2N09N?=
 =?utf-8?B?K2FhV2NYbk1sUG5Zb2NBNlkrUkxYVTZ6cEx4ZWVtSExEREpFaDdQck94QkZ5?=
 =?utf-8?B?bERSeWprT1NrV1dTSjAwRUduQXIwL0JaczM4TmhMVngxUldZR2hvMktMMFNX?=
 =?utf-8?B?OHBVZnhOM2ZVcFpmTzZPTURGTFZJU2FyT3ZwMWNVY3ViUGwwT01rYjFyc09j?=
 =?utf-8?B?U0VUc21Ua3V2c1ZsK1VXcVlBZUFMZnNPcU9HZE8zUjRNanFUaTcybmVCdHh1?=
 =?utf-8?B?ei9paGtBYk1qUjVjdmxJeW02ekg4TGhuU0tlNTJKOC9VTStQejQ1QlRKTDBm?=
 =?utf-8?B?K3BEcEl0Z2hCbmxBbEtZbzV4L0dDeGpnMVY1RCtwbEcySDRoVmFqQjZ3RkVh?=
 =?utf-8?B?OEJIMGxab3lFRlIydGZyZGROc1A2dFRJY1VMUHpHRWFUYy8rTUw5cHNLL2xC?=
 =?utf-8?B?aHJERmJBUGhUNVQrcS9EaytjSWZBK2hBN0FGY3V2Y0dFZDRGL2NjSWRSL01j?=
 =?utf-8?B?bGV0SmF1QTVXbFl2N20rOFlOY2h2by9YaENld1ozd1p2VHc4eVN0dDRXa05Y?=
 =?utf-8?B?TUdlRUZSWFpKS0FBSXdnOElIbmRpRTZtb1B6UmdZdkJVaE0xc294Q0htZ0ww?=
 =?utf-8?B?RndxZUVLdTF2bjdjMEpLcGlqNTZ6Ynl1YU5iOVdJSFpWZ3RwdXRSTXJtSEhF?=
 =?utf-8?B?TjU5S2d6d293eUt1WnVDejZaWGtlVzNDbGZsRWN4TWZnU2RCTUpSenRYRFhW?=
 =?utf-8?B?UFBOcmF0RWdBR09Vb2YxazlRNGJPVE9wS0VIYW9vSVU2TVlWSWdMdTNIMXRZ?=
 =?utf-8?B?bjFobVVBeHN5RE9JZUQ3SHR4Z1lEYjFjL25mcmtOZVpta2RJSncxMnJ2WVQy?=
 =?utf-8?B?NU5WaHZBU2ZKMDQ0MUlhWENZS2NyNmZTWEpXazB2amRMWVo4RFZTTmNSMkkw?=
 =?utf-8?B?VHorQ3J4V0JXY3VWZC9DTXhCbU1rZklibWN3aHVXSHB3RDh6UnhWLzJPZFBI?=
 =?utf-8?B?cHBrV0Zlc1NRd1FadVZvaTRqSWVITWFHVnZ6enlEL0p2MnlRajY0VzIyb1Jn?=
 =?utf-8?B?dHEyaFhtUUZ4c2VPVWo5ZkwrZjBsSEJPN2hHRFJQVFE0aS9HdEdkbzNJNGl2?=
 =?utf-8?B?bTloUWtyd2xrdVRIc2gvWkxXQXlraXBSSjVoa21YOG1SU3JBeUVDSEY3U1Jl?=
 =?utf-8?B?VWlESnRkWWQvZUlhV0JNTHJIcTZFem5pV3F1UTdTQVFPeVU4UnRFdEFKMlFV?=
 =?utf-8?B?MWhxclNlOFgwSWN2dGFyNTBZeFlXSWtkU2hUa20xdU9CLzQ5U0wxejMwRWxI?=
 =?utf-8?B?WVdzY3F4WmJmVGNPSXJYcGd0SkdCUWt0ejFuM3JMTzdWakh4WEt2TG1LQXVr?=
 =?utf-8?B?c044d2J0U1ZGYklzR1BrRUM3OFBsUGIxL1lwVEZzVjIrU1Y5eGJBOFFNNVJW?=
 =?utf-8?B?MFVXTUJydFFXcnUwRm81NXF0bDVobXFJMjFveXBVS0NhaE5GSWJVQnRwYzln?=
 =?utf-8?B?SVd0WXFGQ01UTk1HY0EzSzdZK1Z5L3BwV25SSkhuUmRybWJXaldsWk1aOEw3?=
 =?utf-8?B?MEwxMS9rakFHb2ZYbm9CUEEyMzY1SElaQkM2eUE4bE04dm5JWlY5RDdQallx?=
 =?utf-8?B?SWV0TUFoS0oxWkwxWG8yYUtKYUVkSXFkWmNoRXUwSnVSN1J6ME5nbFk5OGJa?=
 =?utf-8?Q?fSG3ZzNJDIvJjffpFavMSsD2Y?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6993.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 110aef80-b655-40ec-b0fc-08dd7be18a82
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2025 05:51:17.7534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E1IdO++m9/mAcuJgxIkReJqsJRanYkmDqx6btliD7Tyzd6VZRe2S319Y+Mmwufvpk3k2YFsvjuOPpcpfTnnuWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4133

RGVhciBBbGwsDQoNCkFwb2xvZ2llcyBmb3IgdGhlIGFjY2lkZW50YWwgZW1haWwgc2VudCBlYXJs
aWVyLiBUaGlzIHdhcyBhIHRlc3Qgb2YgcGF0Y2ggc3VibWlzc2lvbiB0b29saW5nIGFuZCBjb250
YWluZWQgbm8gaW50ZW5kZWQgY2hhbmdlcy4NCg0KTm8gYWN0aW9uIGlzIHJlcXVpcmVkIOKAkyBw
bGVhc2UgZGlzcmVnYXJkIHRoZSBtZXNzYWdlLiBJ4oCZdmUgdmVyaWZpZWQgdGhlIHRlc3QgcGF0
Y2hlcyB3ZXJlIG5vdCBhcHBsaWVkIHRvIGFueSB0cmVlcy4NCg0KVGhhbmsgeW91IGZvciB5b3Vy
IHVuZGVyc3RhbmRpbmcsDQpXaXRoIEJlc3QgUmVnYXJkcywNCkxpIEh1YSBRaWFuDQoNCg0KLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IExpLCBIdWEgUWlhbiAoREkgRkEgQ1RSIElQ
QyBDTiBQUkMyKSA8SHVhUWlhbi5MaUBzaWVtZW5zLmNvbT4gDQpTZW50OiBUdWVzZGF5LCBBcHJp
bCAxNSwgMjAyNSAxOjQ2IFBNDQpUbzogaHVhcWlhbmxlZUBvdXRsb29rLmNvbQ0KQ2M6IExpLCBI
dWEgUWlhbiAoREkgRkEgQ1RSIElQQyBDTiBQUkMyKSA8SHVhUWlhbi5MaUBzaWVtZW5zLmNvbT47
IEJqb3JuIEhlbGdhYXMgPGJoZWxnYWFzQGdvb2dsZS5jb20+OyBLcnp5c3p0b2YgV2lsY3p5xYRz
a2kgPGt3QGxpbnV4LmNvbT47IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IExvcmVuem8gUGll
cmFsaXNpIDxscGllcmFsaXNpQGtlcm5lbC5vcmc+DQpTdWJqZWN0OiBbUEFUQ0ggdjcgMC83XSBz
b2M6IHRpOiBBZGQgYW5kIHVzZSBQVlUgb24gSzMtQU02NSBmb3IgRE1BDQoNCkZyb206IExpIEh1
YSBRaWFuIDxodWFxaWFuLmxpQHNpZW1lbnMuY29tPg0KDQpDaGFuZ2VzIGluIHY3Og0KIC0gYWRk
IHNjaGVtYSBleHByZXNzaW5nIGRlcGVuZGVuY3kgYXMgc3VnZ2VzdGVkIG9uIHBjaS1ob3N0IGJp
bmRpbmdzDQogLSByZXNvbHZlIHJldmlldyBjb21tZW50cyBvbiBwY2kta2V5c3RvbmUgZHJpdmVy
DQoNCkNoYW5nZXMgaW4gdjY6DQogLSBtYWtlIHJlc3RyaWN0ZWQgRE1BIG1lbW9yeS1yZWdpb24g
YXZhaWxhYmxlIHRvIGFsbCBwY2kta2V5c3RvbmUNCiAgIGRldmljZXMsIG1vdmluZyBwcm9wZXJ0
eSB0byB1bmNvbmRpdGlvbmFsIHNlY3Rpb24gKHBhdGNoIDIpDQoNCkNoYW5nZXMgaW4gdjU6DQog
LSByZXNvbHZlIHJldmlldyBjb21tZW50cyBvbiBwY2ktaG9zdCBiaW5kaW5ncw0KIC0gcmVkdWNl
IERNQSBtZW1vcnkgcmVnaW9ucyB0byAxIC0gc3dpb3RsYiBkb2VzIG5vdCBzdXBwb3J0IG1vcmUN
CiAtIG1vdmUgYWN0aXZhdGlvbiBpbnRvIG92ZXJsYXkgKGNvbnRyb2xsZWQgdmlhIGZpcm13YXJl
KQ0KIC0gdXNlIGtzX2luaXRfdm1hcCBoZWxwZXIgaW5zdGVhZCBvZiBsb29wIGluDQogICByZXdv
cmsga3NfaW5pdF9yZXN0cmljdGVkX2RtYQ0KIC0gYWRkIG1vcmUgY29tbWVudHMgdG8gcGNpLWtl
eXN0b25lDQogLSB1c2UgMiBjaGFpbmVkIFRMQnMgb2YgUFZVIHRvIHN1cHBvcnQgbWF4aW11bSBv
ZiBzd2lvdGxiICgzMjAgTUIpDQoNCkNoYW5nZXMgaW4gdjQ6DQogLSByZW9yZGVyIHBhdGNoIHF1
ZXVlLCBtb3ZpbmcgYWxsIERUUyBjaGFuZ2VzIHRvIHRoZSBiYWNrDQogLSBsaW1pdCBhY3RpdmF0
aW9uIHRvIElPVDIwNTAgQWR2YW5jZWQgdmFyaWFudHMNCiAtIG1vdmUgRE1BIHBvb2wgdG8gYWxs
b3cgZmlybXdhcmUtYmFzZWQgZXhwYW5zaW9uIGl0IHVwIHRvIDUxMk0NCg0KQ2hhbmdlcyBpbiB2
MzoNCiAtIGZpeCB0aSxhbTY1NC1wdnUueWFtbCBhY2NvcmRpbmcgdG8gcmV2aWV3IGNvbW1lbnRz
DQogLSBhZGRyZXNzIHJldmlldyBjb21tZW50cyBvbiB0aSxhbTY1LXBjaS1ob3N0LnlhbWwNCiAt
IGRpZmZlcmVudGlhdGUgYmV0d2VlbiBkaWZmZXJlbnQgY29tcGF0aWJsZXMgaW4gdGksYW02NS1w
Y2ktaG9zdC55YW1sDQogLSBtb3ZlIHB2dSBub2RlcyB0byBrMy1hbTY1LW1haW4uZHRzaQ0KIC0g
cmVvcmRlciBwYXRjaCBzZXJpZXMsIHB1bGxpbmcgYmluZGluZ3MgYW5kIGdlbmVyaWMgRFQgYml0
cyB0byB0aGUgZnJvbnQNCg0KQ2hhbmdlcyBpbiB2MjoNCiAtIGZpeCBkdF9iaW5kaW5nc19jaGVj
ayBpc3N1ZXMgKHBhdGNoIDEpDQogLSBhZGRyZXNzIGZpcnN0IHJldmlldyBjb21tZW50cyAocGF0
Y2ggMikNCiAtIGV4dGVuZCB0aSxhbTY1LXBjaS1ob3N0IGJpbmRpbmdzIGZvciBQVlUgKG5ldyBw
YXRjaCAzKQ0KDQpPbmx5IGZldyBvZiB0aGUgSzMgU29DcyBoYXZlIGFuIElPTU1VIGFuZCwgdGh1
cywgY2FuIGlzb2xhdGUgdGhlIHN5c3RlbSBhZ2FpbnN0IERNQS1iYXNlZCBhdHRhY2tzIG9mIGV4
dGVybmFsIFBDSSBkZXZpY2VzLiBUaGUgQU02NSBpcyB3aXRob3V0IGFuIElPTU1VLCBidXQgaXQg
Y29tZXMgd2l0aCBzb21ldGhpbmcgY2xvc2UgdG8gaXQ6IHRoZSBQZXJpcGhlcmFsIFZpcnR1YWxp
emF0aW9uIFVuaXQgKFBWVSkuDQoNClRoZSBQVlUgd2FzIG9yaWdpbmFsbHkgZGVzaWduZWQgdG8g
ZXN0YWJsaXNoIHN0YXRpYyBjb21wYXJ0bWVudHMgdmlhIGEgaHlwZXJ2aXNvciwgaXNvbGF0ZSB0
aG9zZSBETUEtd2lzZSBhZ2FpbnN0IGVhY2ggb3RoZXIgYW5kIHRoZSBob3N0IGFuZCBldmVuIGFs
bG93IHJlbWFwcGluZyBvZiBndWVzdC1waHlzaWNhbCBhZGRyZXNzZXMuIEJ1dCBpdCBvbmx5IHBy
b3ZpZGVzIGEgc3RhdGljIHRyYW5zbGF0aW9uIHJlZ2lvbiwgbm90IHBhZ2UtZ3JhbnVsYXIgbWFw
cGluZ3MuIFRodXMsIGl0IGNhbm5vdCBiZSBoYW5kbGVkIHRyYW5zcGFyZW50bHkgbGlrZSBhbiBJ
T01NVS4NCg0KTm93LCB0byB1c2UgdGhlIFBWVSBmb3IgdGhlIHB1cnBvc2Ugb2YgaXNvbGF0ZWQg
UENJIGRldmljZXMgZnJvbSB0aGUgTGludXggaG9zdCwgdGhpcyBzZXJpZXMgdGFrZXMgYSBkaWZm
ZXJlbnQgYXBwcm9hY2guIEl0IGRlZmluZXMgYSByZXN0cmljdGVkLWRtYS1wb29sIGZvciB0aGUg
UENJIGhvc3QsIHVzaW5nIHN3aW90bGIgdG8gbWFwIGFsbCBETUEgYnVmZmVycyBmcm9tIGEgc3Rh
dGljIG1lbW9yeSBjYXJ2ZS1vdXQuIEFuZCB0byBlbmZvcmNlIHRoYXQgdGhlIGRldmljZXMgYWN0
dWFsbHkgZm9sbG93IHRoaXMsIGEgc3BlY2lhbCBQVlUgc29jIGRyaXZlciBpcyBpbnRyb2R1Y2Vk
LiBUaGUgZHJpdmVyIHBlcm1pdHMgYWNjZXNzIHRvIHRoZSBHSUMgSVRTIGFuZCBvdGhlcndpc2Ug
d2FpdHMgZm9yIG90aGVyIGRyaXZlcnMgdGhhdCBkZXRlY3QgZGV2aWNlcyB3aXRoIGNvbnN0cmFp
bmVkIERNQSB0byByZWdpc3RlciBwb29scyB3aXRoIHRoZSBQVlUuDQoNCkZvciB0aGUgQU02NSwg
dGhlIGZpcnN0IChhbmQgcG9zc2libHkgb25seSkgZHJpdmVyIHdoZXJlIHRoaXMgaXMgaW50cm9k
dWNlZCBpcyB0aGUgcGNpLWtleXN0b25lIGhvc3QgY29udHJvbGxlci4gRmluYWxseSwgdGhpcyBz
ZXJpZXMgcHJvdmlkZXMgYSBEVCBvdmVybGF5IGZvciB0aGUgSU9UMjA1MCBBZHZhbmNlZCBkZXZp
Y2VzIChhbGwgaGF2ZSBNaW5pUENJZSBvciBNLjIgZXh0ZW5zaW9uIHNsb3RzKSB0byBtYWtlIHVz
ZSBvZiB0aGlzIHByb3RlY3Rpb24gc2NoZW1lLg0KQXBwbGljYXRpb24gb2YgdGhpcyBvdmVybGF5
IHdpbGwgYmUgaGFuZGxlZCBieSBmaXJtd2FyZS4NCg0KRHVlIHRvIHRoZSBjcm9zcy1jdXR0aW5n
IG5hdHVyZSBvZiB0aGVzZSBjaGFuZ2VzLCBtdWx0aXBsZSBzdWJzeXN0ZW1zIGFyZSBhZmZlY3Rl
ZC4gSG93ZXZlciwgSSB3YW50ZWQgdG8gcHJlc2VudCB0aGUgd2hvbGUgdGhpbmcgaW4gb25lIHNl
cmllcyB0byBhbGxvdyBldmVyeW9uZSB0byByZXZpZXcgd2l0aCB0aGUgY29tcGxldGUgcGljdHVy
ZSBpbiBoYW5kcy4gSWYgcHJlZmVycmVkLCBJIGNhbiBhbHNvIHNwbGl0IHRoZSBzZXJpZXMgdXAs
IG9mIGNvdXJzZS4NCg0KSmFuDQoNCkNDOiBCam9ybiBIZWxnYWFzIDxiaGVsZ2Fhc0Bnb29nbGUu
Y29tPg0KQ0M6ICJLcnp5c3p0b2YgV2lsY3p5xYRza2kiIDxrd0BsaW51eC5jb20+DQpDQzogbGlu
dXgtcGNpQHZnZXIua2VybmVsLm9yZw0KQ0M6IExvcmVuem8gUGllcmFsaXNpIDxscGllcmFsaXNp
QGtlcm5lbC5vcmc+DQoNCkphbiBLaXN6a2EgKDcpOg0KICBkdC1iaW5kaW5nczogc29jOiB0aTog
QWRkIEFNNjUgcGVyaXBoZXJhbCB2aXJ0dWFsaXphdGlvbiB1bml0DQogIGR0LWJpbmRpbmdzOiBQ
Q0k6IHRpLGFtNjU6IEV4dGVuZCBmb3IgdXNlIHdpdGggUFZVDQogIHNvYzogdGk6IEFkZCBJT01N
VS1saWtlIFBWVSBkcml2ZXINCiAgUENJOiBrZXlzdG9uZTogQWRkIHN1cHBvcnQgZm9yIFBWVS1i
YXNlZCBETUEgaXNvbGF0aW9uIG9uIEFNNjU0DQogIGFybTY0OiBkdHM6IHRpOiBrMy1hbTY1LW1h
aW46IEFkZCBQVlUgbm9kZXMNCiAgYXJtNjQ6IGR0czogdGk6IGszLWFtNjUtbWFpbjogQWRkIFZN
QVAgcmVnaXN0ZXJzIHRvIFBDSSByb290IGNvbXBsZXhlcw0KICBhcm02NDogZHRzOiB0aTogaW90
MjA1MDogQWRkIG92ZXJsYXkgZm9yIERNQSBpc29sYXRpb24gZm9yIGRldmljZXMNCiAgICBiZWhp
bmQgUENJIFJDDQoNCiAuLi4vYmluZGluZ3MvcGNpL3RpLGFtNjUtcGNpLWhvc3QueWFtbCAgICAg
ICAgfCAgMzkgKy0NCiAuLi4vYmluZGluZ3Mvc29jL3RpL3RpLGFtNjU0LXB2dS55YW1sICAgICAg
ICAgfCAgNTEgKysNCiBhcmNoL2FybTY0L2Jvb3QvZHRzL3RpL01ha2VmaWxlICAgICAgICAgICAg
ICAgfCAgIDUgKw0KIGFyY2gvYXJtNjQvYm9vdC9kdHMvdGkvazMtYW02NS1tYWluLmR0c2kgICAg
ICB8ICAzOCArLQ0KIC4uLmFtNjU0OC1pb3QyMDUwLWFkdmFuY2VkLWRtYS1pc29sYXRpb24uZHRz
byB8ICAzMyArKw0KIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1rZXlzdG9uZS5jICAg
ICB8IDEwNiArKysrDQogZHJpdmVycy9zb2MvdGkvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAg
ICAgIHwgICA0ICsNCiBkcml2ZXJzL3NvYy90aS9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICAg
ICAgfCAgIDEgKw0KIGRyaXZlcnMvc29jL3RpL3RpLXB2dS5jICAgICAgICAgICAgICAgICAgICAg
ICB8IDUwMCArKysrKysrKysrKysrKysrKysNCiBpbmNsdWRlL2xpbnV4L3RpLXB2dS5oICAgICAg
ICAgICAgICAgICAgICAgICAgfCAgMjggKw0KIDEwIGZpbGVzIGNoYW5nZWQsIDc5OCBpbnNlcnRp
b25zKCspLCA3IGRlbGV0aW9ucygtKSAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9zb2MvdGkvdGksYW02NTQtcHZ1LnlhbWwNCiBjcmVhdGUgbW9k
ZSAxMDA2NDQgYXJjaC9hcm02NC9ib290L2R0cy90aS9rMy1hbTY1NDgtaW90MjA1MC1hZHZhbmNl
ZC1kbWEtaXNvbGF0aW9uLmR0c28NCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9zb2MvdGkv
dGktcHZ1LmMgIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2xpbnV4L3RpLXB2dS5oDQoNCi0t
DQoyLjM0LjENCg0K

