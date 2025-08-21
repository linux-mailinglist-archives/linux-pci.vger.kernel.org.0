Return-Path: <linux-pci+bounces-34430-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4D5B2EDA6
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 07:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 461E33B2392
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 05:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DD82BEC30;
	Thu, 21 Aug 2025 05:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SsGePoCd"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013011.outbound.protection.outlook.com [52.101.72.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37F926A0A7;
	Thu, 21 Aug 2025 05:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755755048; cv=fail; b=ghAO6qNcij1E29q/kUn7z/4csySCvxFTOtHWifzuUlDmee3k36sCx7C6Dmv28gWl6VEHeFWVHZa/2VotT+SyfzihcuiyjulukuBMfKV5oBtMrPP1KWZVs4d2FYzFFHcvfGm5sSuSpV4osvLtMcoiNfKZdnpup0BMnNJhooBOstA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755755048; c=relaxed/simple;
	bh=fihsi2yDNPD1y2XzB2EPrMV18A9xYUZt6dP3tGSboeA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Fy+UY8bv7ihPwQh230VXaFV1BFSBOF3HjaPN0IkSHi6x9KmEDCZBGsmml0JALYEQCDQlxD5nmOXPT7ZeBEEOXAFBw6j7s2b8QDJ1+xk6UArJkBs9FCWfyG5DnUS7rHykRonLj87S6f/JwY7VfQYzBAH94KbHFpTEfE9Yc/hd7co=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SsGePoCd; arc=fail smtp.client-ip=52.101.72.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cswnc9G4G4bv2wqWrZMXt+53axce713WAcPWhV4WD9g6W3S/ZU/JT9AnPQg4cJZQTyMSTJV6+mqnxWg/QC7nY8t54v3lbGx7uanWqtpznnos8eR2u7iZL2Efvx3OcL5/WOH2ou0h2MS7Usm8cN8hAtBg55GqFpYia+3c2sWq+0vrhmC2os647ZKwuJhMSdhGZCueiAfUzoLa8793Gxcjeu3nsioc+ZClaNl4khtA48FYfS5qS8g66isz3ya67/f0kHWck80qBMkHxp4CGUoc5BGzewYTSkiUnW8O2vSB672iaYj4jpnikJ2tNfq8NP7oEVQZVf3J6JLurFVu3sixsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fihsi2yDNPD1y2XzB2EPrMV18A9xYUZt6dP3tGSboeA=;
 b=tzql6Fk9IYKrupRRi8obAdmCz/eb60ZTxE6oi7pM3yT+QjGy5eD1PcO105NrxWtKoTLjNqnC0XR7a/jti2Knu/Sdr6/0mI3GgG8t0bbhRKcqIyuz8Wgqwxh0qNF2eyCBYwZ7uwqCo0heAvfiv5R2umHukzX6reM3l/EYjAj/2+GnZJHFgf7E0/xqJDaJ6D4HoVJnW4YTPrVCUpKlocMjvEplNMXxQLbOFpfCShUXwriZu3xaLRXOokL/vx5JIcv8ANC98qfZ5MYdie8moEqYRGt4YhzGQ48bxXoycR/5La9rEuRIRqIogn7tRHri09L62pY1m2SkTHBZMW2LaWrSFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fihsi2yDNPD1y2XzB2EPrMV18A9xYUZt6dP3tGSboeA=;
 b=SsGePoCdAxG1pFPK19YD6PbonpwIAqk06AjLzBS1jWngOXLKKtmVgllcbp05vAkQkxaxFSreSzEAhmT2wLpwf8+M6SUYX8wev9vDlLimcPZ8pbeKzEf1DEcEcExZiDuRNCUvsPNsX7qHlG8hhxnkx+38Hfcscizs/C6ea7kCeHY6hWTPv1W3UM+ctu/2GCP9dNIWbBRSZfp9YHsMx0jllTxKUKp/viRB2YAvMNk9+QgaOkv0A9qOxiVdG9AsBgYRLng2YYm77HegvRdP6qmTP4maSvVEOrGI1trWGwsiLR4CBg3FqFRKigqPBJEStMu/+vGJnnoBdzQ6t6GYjYOdAQ==
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by GV1PR04MB10582.eurprd04.prod.outlook.com (2603:10a6:150:211::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Thu, 21 Aug
 2025 05:44:00 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%4]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 05:44:00 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Frank Li <frank.li@nxp.com>, "jingoohan1@gmail.com"
	<jingoohan1@gmail.com>, "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org"
	<kwilczynski@kernel.org>, "mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [RESEND v3 4/5] PCI: dwc: Skip PME_Turn_Off message if there is
 no endpoint connected
Thread-Topic: [RESEND v3 4/5] PCI: dwc: Skip PME_Turn_Off message if there is
 no endpoint connected
Thread-Index: AQHcEBJOdRzYnkNlTEaxDSta+t8f+rRqWNOAgAI/DMA=
Date: Thu, 21 Aug 2025 05:44:00 +0000
Message-ID:
 <AS8PR04MB88334A22726CF287D41775DC8C32A@AS8PR04MB8833.eurprd04.prod.outlook.com>
References: <20250818073205.1412507-5-hongxing.zhu@nxp.com>
 <20250819190719.GA553003@bhelgaas>
In-Reply-To: <20250819190719.GA553003@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8833:EE_|GV1PR04MB10582:EE_
x-ms-office365-filtering-correlation-id: 3d411e3e-3e39-42fa-f16c-08dde075bae3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|19092799006|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?VmhaOUE0QTR4bng2Y2o5aTNRVitFaDY5ODcvdjZHRmRYVzZ1REJhUG16OWor?=
 =?gb2312?B?Q29ablEwanBxdnF3ZFNtcDRQZTBISXQxc25KZ0xnUThnUW9OT28zeThtclMw?=
 =?gb2312?B?OTVaRzF0aGdCdi9LZk1mZWhHU1QyYnE0UktlZmVTbktINWxIb3FPZEVkeERI?=
 =?gb2312?B?a3hWcWNmZlF4TldtZm94eFpvZVlScE40YWtaRkFDUE1SR3Q4akhoa29XTTR3?=
 =?gb2312?B?cnVTQ1JMNGJtT2ZJTmFhRlBuaUdjUU1mSm13elRxNUZIYW83aWtZSllOOCtl?=
 =?gb2312?B?T3VtTExHdmZML1VtbEFvL2s5bDg5bTdBRHNFNWRldW5LbiszSkV1QkMrUmx3?=
 =?gb2312?B?bVlFdjVuTGlzTEVZbmpYb01ZY24yOVZmbjB3RjloeGFsaTU2d3AwU3VyWDNK?=
 =?gb2312?B?S0JaQzlvUVEvTDRwUFh1ZHRCWnM5ZmJLOTJkNVJoV2w0bkV1bkVyWERDbzJP?=
 =?gb2312?B?R3p4Vy9xcnRLa1VORFlFTGlQei94aWZrbUs0RjVSTGlNQS94WjYzODNUWVBV?=
 =?gb2312?B?RVRRTkZhaElQN3V0Zm1LRnJ2VDVScmhIZlU0KzhMaDU3RFZHMEppRElNWlJ6?=
 =?gb2312?B?RDBXdVlFVVRTUWJoV0pYQXVybnkzbnVTaGJGSWdaT1pvcGkva1RiQUEwZEhO?=
 =?gb2312?B?NXZ3ZFcvZDJDMVJnWmR3M0VVUUkwR2Jhbk1aL1E5SDFyZXRvTmtrcFF0SGZr?=
 =?gb2312?B?YndGdnp1YWpwYThkNnRpek5rVUFwRlVxOXcvU3R3MG9rSVhjeHR0dktYSmtJ?=
 =?gb2312?B?TTVFNjdyNlArTG9Ic01KRHBPQmllSG96Y3ZTN3FrV3gxRzJsWllTS2RXMERT?=
 =?gb2312?B?R3JzU2dleURkNmVKVzJCbUllMnlXaTFaVy9iS3lkTEFSV3U1WjZadTJHRStD?=
 =?gb2312?B?RHl4UWMrb3kvTXh4L1B0YjBETU53L2tIYldhUnp5Z0FET1RCUkx0T2l0SStY?=
 =?gb2312?B?N1BQMGpEUkllOForOUZaT1lPMXQ1OXBMNHljNVplTWFZVkJLc3dzT2s1MTlz?=
 =?gb2312?B?ZTJWd1UxRVloenU2cEthRlQvak5YelRKeVZmenNaMzhUVkJoV05rOGorRldS?=
 =?gb2312?B?UnloRGozRCsxa3k0Z1c4YnhoWEJ0aEs0TU1TNms2Mkh5a081RUI0bkZWeWxr?=
 =?gb2312?B?SGhJdnVZQ09NU2VOQWkreTQ3ZnNkWEl1dkpFcE1FOXlBQWZHZFRsSjBPdjVn?=
 =?gb2312?B?WldYZ3Fjb0pJTFhETkcxRzd5bE10ZVFWTUdPL0locDU1YVN2VUdZaGduSE1l?=
 =?gb2312?B?VnRVMzYvNFNyTjZEa2lvZ3lpT3RTZ2Vqbm5RL0l1cEVGNHVSRVNnZHdYQ1N5?=
 =?gb2312?B?OUtTMGd0azBBODJPdGo3LzFndG1pNHZ2WXVyNXJpWFdoTnkzT3BwbXBOWmN1?=
 =?gb2312?B?VFZ0T21IQVpKa0xGNFYrem9sb29DU09uTGJLMTlDcXZiZ1VzZG9WbUViVXds?=
 =?gb2312?B?NkJrTXkrZUh3eDl4UUp4ZzFBSCswYk9adytlc2IydmtlYTZtWEVQeUpBTDZu?=
 =?gb2312?B?dGtPVmt5WjBqeTIxTll6UUVqUStvN1BDKzNRT081NHNGcXYxZ3dScG5aTzA3?=
 =?gb2312?B?UDJHMDJITlFqVkZYSHByWHhrRFdvb2hIajh1VWlDOE1lOXgwNlpQaWxmZUZv?=
 =?gb2312?B?NWRSSlAvVGxaUDJmWVpmbDkyRlJLa2tPU2g5dW8rUXBldFdTSXFZS3ZHanQ1?=
 =?gb2312?B?a0YvMFlvdSsvUU54RTZhWEpqY1g3cVdoK0Rra2NQdWZYMHBPUXQvbitSd0Jx?=
 =?gb2312?B?RDJUWFByek01SERNZHZ3OVhlZWU0RUlwUGxRZkY0Uk1lSURHdXNYaUZ4V3ZR?=
 =?gb2312?B?dHNpSkhOdVZrM3ltdGVVdXpQRzUzVHhoa2tBYWlnQmxPMzdtblRicXNBUVBY?=
 =?gb2312?B?UGpaWVcvc0FWYjBNSncxNll0YUZrdW4vMDBVS1RNM3NPcDF0aTIrUjFtVzcr?=
 =?gb2312?Q?r7tt3gqXl6g=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?dVJleWw2bDg2VXBYMkVjZTYzaTFsWHdKRGV4ekExa1BFa2Zsa2VZWC9lNU9k?=
 =?gb2312?B?WEEzUnJRUVQwSVdlR3FNdEJuMmkwSHRkNkpYSldSYzl2VVRyVTNzNHc3dGtP?=
 =?gb2312?B?WlZMU3JVeko2c1I4bGt3UkV0R1A1Y01FdzJQR0pqUzFMMzdKMnRHMVp2RVN5?=
 =?gb2312?B?Ujliby9zZ0JMKzdWdHhUbm96V0d3bXZoTjNRdEFMMGQ3YUlwdStNSE9Qa1cy?=
 =?gb2312?B?ditVMEhHdzRhTjZEME9Cb0JrNGRleHAwMkVqTXNWamJEd25DVFJTeHk2RjJz?=
 =?gb2312?B?ZFdTYndFRTJPbVF2ckJyeEx3Q2MzT1BvclpuaHo3RGQ1c2wxVmtyc1htc0pV?=
 =?gb2312?B?ZXdkeTlpMzNHNzRKWTcyc1BXVXRUU2hHTUNkc0RFM3dsNGczRDdOTVRFMTRz?=
 =?gb2312?B?UVVxcHVFUHNDTGtZOHRQTjRnckx5MHp0TzYvRWdqZ3p4ell1eXI4ZFBod3pQ?=
 =?gb2312?B?S3czS3pjRmhjbGZXUlFaNEZCZHlSQitvZE1IQkJWNm92WWhwZ3RmR3JqZ3Fu?=
 =?gb2312?B?aHhjbTdLdHZkVGhkVEhnTmVtcUpBbjJEK21aT1hWUSs3WmNZWTU3dXowRWh5?=
 =?gb2312?B?Q01iamY4VWZkNXNuaUkxZlFGRCt3Ykhxa09rQlFjTy8xcDJySDZmb3ZaS3cr?=
 =?gb2312?B?c1c2QlZiYTYwd3FTSFJwemNVZm4rQW95NFc2bmRpd2dFUDdzdWdaVUFEUjVy?=
 =?gb2312?B?ZDlsM2UwYTIvN2Vkc3AyTGtNV2pBSlg0aE82SktjZUQ1NFpyOWc3QzZUNTF2?=
 =?gb2312?B?djAzcy9KMEo4NzIrZ1NYY2FiVmpEUHZrRWZqNk9GYWZab3k3UmN3eTRVc2o1?=
 =?gb2312?B?N0FZYzVqNHZTRGJSaU5PbnZUd0ZyYkZhQWl6TVJ3VnpTTDY4YXdKNU9BelNK?=
 =?gb2312?B?cmJGVWdpTkMwYk5jcStnUXNpVEtSdVpsaUpsN2NaVEJYRzYzOXFzWHVyYlBj?=
 =?gb2312?B?eVhWcEV2bzlLZEVwOWdkTyt4d25OcC9GQ2RaV1V1OTJOZGdEWlhySEFQTGNY?=
 =?gb2312?B?V3VzWXZwa2YvUnJycUI1cmNtU0tLTHRsR2tYalN5RGU4NVEzdi91T0gzSmVB?=
 =?gb2312?B?azZjWlRpNkFHMnkxZlVraEwwekpsZzlTSHB2ZEp3L2VnWjduTnRQOStkdzIy?=
 =?gb2312?B?OXZBM1hFVUV2VDFVajhRdzhXQVRicndHK1k5eHk5bG1MRy9ZVHg5dW55Wkd3?=
 =?gb2312?B?eGZ3ek5ZWWFCTmpWelEzcGh1ZCtPWW9DY1Z4VlZhREhHZjFvYUhTYy9VRW9m?=
 =?gb2312?B?RU1zR0lrbXc4RHNpUUpaN3ExMkVBUXh0TGRXNU84MXFyUUdxK1BISUsvSkhG?=
 =?gb2312?B?VTZ3eUE1K1E1NXJ2eWpHZFE0bTR2M2JqckhHNnE1WndvcHhBNXBpeEx6Y1R2?=
 =?gb2312?B?bTNjTllzYlBhVUFNcTBOSW8wRU9BVXRKaG1QZGxWSXpieVlsZmVoSHhNNUJQ?=
 =?gb2312?B?aTZXN25hU1dqdFJtSVUvOHFvQU8yZGRPcWF6ZmphQ09HaE52M3N3WFB2T3p1?=
 =?gb2312?B?OVFyMEFmai9Yc0ZuWTYvVUIxT1o4VkVqbmJDNHdJYU5zZUNLNGNpR3dpU1cv?=
 =?gb2312?B?Vkl2eUUvdUEvbXIzcDNtbFhlSTBpa2N2OFRyYWpaZkZEMG5MTlhqRktUOFZU?=
 =?gb2312?B?M0lwRHBCSjVpeHdjVldzSGQwaS8xK3lYU0FuZ2s1VGtaUGpaUnlLMXRIM2Zs?=
 =?gb2312?B?QnNiL2RmNW0rWDV5UnlDNWY3WjlZaERha3JsZnk4M25OSFIrQ1Y0c1lyQ0l5?=
 =?gb2312?B?ZzZ2Q3B2TFVNM01Hb2dFamJHNjF1UjkvWnI5WS9mMXp4d2RjTk5XbUdVRTAw?=
 =?gb2312?B?Y2NkdTJSakxnOWorU2lEY0ZNeFdQbHlFbXZiMUdIQjAveEdyTjJaa0pTd3NF?=
 =?gb2312?B?SXYyUS9nZEh4Wm52Vi9maWVWMGRHZlJhcXYvOFBJdVU4NE1BT1FxQ0NFZnNT?=
 =?gb2312?B?WklzM04zdllNUWNsWTdhVHJJYXFLQnMvcDJQSWViU3pPR0NFSndHYTVnYWcy?=
 =?gb2312?B?TDVlcTdPa2U1R3c0TWU2ZzJOSjB4SG5iQitSMHdjbzErV00vVkRJSzZhVlQz?=
 =?gb2312?B?UnNHVjlBb05EcWNHdDNFSU9hUTFTR05hdFVOVXRhNW5BNk5FRUV4OUR4OG52?=
 =?gb2312?Q?AjlY=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d411e3e-3e39-42fa-f16c-08dde075bae3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2025 05:44:00.7215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NRafZ6H7SoFBs0FI8POCNL/YR7zLhvziDotmM2UiWYOx/oOl6bXIf7QYrjZ/46Hh9F4Nl8D7n/yL0MULej0QeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10582

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCam9ybiBIZWxnYWFzIDxoZWxn
YWFzQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjXE6jjUwjIwyNUgMzowNw0KPiBUbzogSG9uZ3hp
bmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IEZyYW5rIExpIDxmcmFuay5saUBu
eHAuY29tPjsgamluZ29vaGFuMUBnbWFpbC5jb207DQo+IGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU7
IGxwaWVyYWxpc2lAa2VybmVsLm9yZzsga3dpbGN6eW5za2lAa2VybmVsLm9yZzsNCj4gbWFuaUBr
ZXJuZWwub3JnOyByb2JoQGtlcm5lbC5vcmc7IGJoZWxnYWFzQGdvb2dsZS5jb207DQo+IHNoYXdu
Z3VvQGtlcm5lbC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRyb25p
eC5kZTsNCj4gZmVzdGV2YW1AZ21haWwuY29tOyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOw0K
PiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGlteEBsaXN0cy5saW51eC5k
ZXY7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtSRVNF
TkQgdjMgNC81XSBQQ0k6IGR3YzogU2tpcCBQTUVfVHVybl9PZmYgbWVzc2FnZSBpZiB0aGVyZSBp
cw0KPiBubyBlbmRwb2ludCBjb25uZWN0ZWQNCj4NCj4gT24gTW9uLCBBdWcgMTgsIDIwMjUgYXQg
MDM6MzI6MDRQTSArMDgwMCwgUmljaGFyZCBaaHUgd3JvdGU6DQo+ID4gU2tpcCBQTUVfVHVybl9P
ZmYgbWVzc2FnZSBpZiB0aGVyZSBpcyBubyBlbmRwb2ludCBjb25uZWN0ZWQuDQo+DQo+IFdoYXQn
cyB0aGUgdmFsdWUgb2YgZG9pbmcgdGhpcz8gIElzIHRoaXMgdG8gbWFrZSBzb21ldGhpbmcgZmFz
dGVyPyAgSWYgc28sDQo+IHdoYXQgYW5kIGJ5IGhvdyBtdWNoPw0KPg0KPiBPciBkb2VzIGl0IGZp
eCBzb21ldGhpbmcgdGhhdCdzIGN1cnJlbnRseSBicm9rZW4/DQo+DQo+IFNlZW1zIGxpa2UgdGhl
IGRpc2N1c3Npb24gYXQNCj4gaHR0cHM6Ly9sb3JlLmtlcm4vDQo+IGVsLm9yZyUyRmxpbnV4LXBj
aSUyRjIwMjQxMTA3MDg0NDU1LjM2MjM1NzYtMS1ob25neGluZy56aHUlNDBueHAuY29tJQ0KPiAy
RnQlMkYlMjN1JmRhdGE9MDUlN0MwMiU3Q2hvbmd4aW5nLnpodSU0MG54cC5jb20lN0NlZDQ2ZmUx
MGFlYjc0DQo+IDIxYzg4YTUwOGRkZGY1M2EyNGYlN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1
YzMwMTYzNSU3QzAlN0MwJTcNCj4gQzYzODkxMjI3MjQ5Mzc1NTIwMyU3Q1Vua25vd24lN0NUV0Zw
Ykdac2IzZDhleUpGYlhCMGVVMWhjR2tpT24NCj4gUnlkV1VzSWxZaU9pSXdMakF1TURBd01DSXNJ
bEFpT2lKWGFXNHpNaUlzSWtGT0lqb2lUV0ZwYkNJc0lsZFVJam95ZlElDQo+IDNEJTNEJTdDMCU3
QyU3QyU3QyZzZGF0YT1sSUU3JTJGbFM1amlHeEdQR1ZtNUhyNWVmcE1iVDE5Q0xxcnd1DQo+IFlO
dkFFZExZJTNEJnJlc2VydmVkPTANCj4gbWlnaHQgYmUgcmVsZXZhbnQuDQo+DQo+IFRoaXMgY29t
bWl0IGxvZyBvbmx5IHJlc3RhdGVzIHdoYXQgdGhlIGNvZGUgZG9lcy4gIEluIG15IG9waW5pb24g
d2UgbmVlZA0KPiBhY3R1YWwganVzdGlmaWNhdGlvbiBmb3IgbWFraW5nIHRoaXMgY2hhbmdlLg0K
SGkgQmpvcm46DQpUaGFua3MgZm9yIHlvdXIgY29tbWVudHMuDQpUaGlzIGNvbW1pdCBpcyBtYWlu
bHkgdXNlZCB0byBmaXggc3VzcGVuZC9yZXN1bWUgYnJva2VuIG9uIGkuTVg3RCBQQ0llLg0KQSBj
aGlwIGZyZWV6ZSBpcyBvYnNlcnZlZCBvbiBpLk1YN0Qgd2hlbiBQQ0llIFJDIGtpY2tzIG9mZiB0
aGUgUE1fUE1FIG1lc3NhZ2UNCmFuZCBubyBhbnkgZGV2aWNlcyBhcmUgY29ubmVjdGVkIG9uIHRo
ZSBwb3J0Lg0KDQpCZWNhdXNlIGkuTVg3RCBpcyBhIHZlcnkgb2xkIGRlc2lnbiwgYW5kIG91dCBv
ZiBJUCBkZXNpZ24gdGVjaG5pY2FsIHN1cHBvcnQuDQogSSBkb24ndCBrbm93IHdoYXQncyBnb2lu
ZyBvbiBpbnNpZGUgdGhlIFBDSWUgSVAgZGVzaWduIHdoZW4ga2ljayBvZmYgdGhlDQogUE1fUE1F
IG1lc3NhZ2UuDQoNCkZyb20gU1cgcGVyc3BlY3RpdmUgdmlldywgd2hhdCBJIGNhbiBkbyBpcyB0
byBmaW5kIG91dCBhIHF1aXJrIG1ldGhvZCB0bw0KIHdvcmthcm91bmQgdGhpcyBicm9rZW4uIEhv
cGUgdGhpcyBjYW4gY2xlYXIgdXAgeW91ciBjb25mdXNpb25zLg0KDQpCZXN0IFJlZ2FyZHMNClJp
Y2hhcmQgWmh1DQo+DQo+ID4gU2lnbmVkLW9mZi1ieTogUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpo
dUBueHAuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBGcmFuayBMaSA8RnJhbmsuTGlAbnhwLmNvbT4N
Cj4gPiAtLS0NCj4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJl
LWhvc3QuYyB8IDE1DQo+ID4gKysrKysrKysrLS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA5
IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWhvc3QuYw0KPiA+IGIvZHJp
dmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWhvc3QuYw0KPiA+IGluZGV4
IDIwYTdmODI3YmFiYmYuLjg2OGU3ZGI0ZTMzODEgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9w
Y2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWhvc3QuYw0KPiA+ICsrKyBiL2RyaXZl
cnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS1ob3N0LmMNCj4gPiBAQCAtMTAx
NiwxMiArMTAxNiwxNSBAQCBpbnQgZHdfcGNpZV9zdXNwZW5kX25vaXJxKHN0cnVjdCBkd19wY2ll
ICpwY2kpDQo+ID4gICAgIGlmIChkd19wY2llX3JlYWR3X2RiaShwY2ksIG9mZnNldCArIFBDSV9F
WFBfTE5LQ1RMKSAmDQo+IFBDSV9FWFBfTE5LQ1RMX0FTUE1fTDEpDQo+ID4gICAgICAgICAgICAg
cmV0dXJuIDA7DQo+ID4NCj4gPiAtICAgaWYgKHBjaS0+cHAub3BzLT5wbWVfdHVybl9vZmYpIHsN
Cj4gPiAtICAgICAgICAgICBwY2ktPnBwLm9wcy0+cG1lX3R1cm5fb2ZmKCZwY2ktPnBwKTsNCj4g
PiAtICAgfSBlbHNlIHsNCj4gPiAtICAgICAgICAgICByZXQgPSBkd19wY2llX3BtZV90dXJuX29m
ZihwY2kpOw0KPiA+IC0gICAgICAgICAgIGlmIChyZXQpDQo+ID4gLSAgICAgICAgICAgICAgICAg
ICByZXR1cm4gcmV0Ow0KPiA+ICsgICAvKiBTa2lwIFBNRV9UdXJuX09mZiBtZXNzYWdlIGlmIHRo
ZXJlIGlzIG5vIGVuZHBvaW50IGNvbm5lY3RlZCAqLw0KPiA+ICsgICBpZiAoZHdfcGNpZV9nZXRf
bHRzc20ocGNpKSA+IERXX1BDSUVfTFRTU01fREVURUNUX1dBSVQpIHsNCj4gPiArICAgICAgICAg
ICBpZiAocGNpLT5wcC5vcHMtPnBtZV90dXJuX29mZikgew0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgcGNpLT5wcC5vcHMtPnBtZV90dXJuX29mZigmcGNpLT5wcCk7DQo+ID4gKyAgICAgICAgICAg
fSBlbHNlIHsNCj4gPiArICAgICAgICAgICAgICAgICAgIHJldCA9IGR3X3BjaWVfcG1lX3R1cm5f
b2ZmKHBjaSk7DQo+ID4gKyAgICAgICAgICAgICAgICAgICBpZiAocmV0KQ0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiA+ICsgICAgICAgICAgIH0NCj4gPiAg
ICAgfQ0KPiA+DQo+ID4gICAgIGlmIChkd2NfcXVpcmsocGNpLCBRVUlSS19OT0wyUE9MTF9JTl9Q
TSkpIHsNCj4gPiAtLQ0KPiA+IDIuMzcuMQ0KPiA+DQo=

