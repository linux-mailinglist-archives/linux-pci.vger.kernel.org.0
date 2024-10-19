Return-Path: <linux-pci+bounces-14901-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EBA9A4CBC
	for <lists+linux-pci@lfdr.de>; Sat, 19 Oct 2024 11:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 079471C21C1D
	for <lists+linux-pci@lfdr.de>; Sat, 19 Oct 2024 09:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1681F1DE8A8;
	Sat, 19 Oct 2024 09:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="csxs1ul3"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2070.outbound.protection.outlook.com [40.107.21.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FD818E361;
	Sat, 19 Oct 2024 09:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729331936; cv=fail; b=X5YKr4tP9YWL4EpAWTMBX2gCCvT03RVKFqF4Own7kJecxLFhChaT8TEUmM5k5wDMLnLHNpaGfr+l4U6X7Jmi6oMuDKHvI6wJE+tMmf7FvO8JuytPpoTVSCE3PaELRr925LiWBE4c92o0uozWAykIaxAdKR7RZ/PEbDeQuGhRS7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729331936; c=relaxed/simple;
	bh=+zJUd1k+z0MTdwV/16E4L8ZlyQechreESliNcQFuySQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rP9y1YdGCTYunB9R4Qv6/+gA0rabdC3FD9ako6LXy+QlSlUWELNVQJgPG+KaiAePP2StzEkyAZRh0SB8WIqjiAguF0N/3p631JzL9hBPP3DvG8MVbJdSDDAyWLlGkixJuqAsDOhAuBCbso87s0Q1JtQHliWU/qF5k5zuahJ6rZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=csxs1ul3; arc=fail smtp.client-ip=40.107.21.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EZ7CTHcv9xH73k5DS0AUD6bc+vZzyXwbP0wmCdkSU5OcjYGE775JKkoNea6w9vD3whTIG0Dou77368AMMtj+JlNr7e2phhdGQz0uEgjFH5uQ2yBHyxkaYLyWWCjw4F1+GoVSGQyhahyTmA/VLvAYIV9MvAIcTaWU8yoQYE/QBP5Mho1XSr8ewCXWAjHUM7jBGP9KV/B8dgpO/7tNZs0exEX9YttYZEa4IXl61xlZZ8Ew+OjMAzB4dCCzmQHeIdAaUJaMDkvmUqrV+FbKZ/D8rJr5TFGFkhMtdfD9kC5UjlWfa/U533HUSA/v6sWI8k8t10HY6CAx5jz1XOZkIs0GVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+zJUd1k+z0MTdwV/16E4L8ZlyQechreESliNcQFuySQ=;
 b=sMLydaLcOk8OpBLoQ234dUXJ20i4ISsW7JlccNH0VtZ6fxEwxo8G1awYTBVhvw52+VKRggX6eFSU4mWfPLvrDxLvimmYzPDLsuHmqdRODL9HL+l12fgRJwRTs8f0MLT0tRzT8d2irogyJwW4XJOaRF+yTROEB70DgRU67Cuafm3aULpVrHuVNGouQJKmWYAWErGq90/4Yw5yn6k/vMcyD3u4l/O7x/ZcUpMtEHujI4m9YPNBQ723Uq6Pz5MW0Gt3p8NmcqQ8paSM/Ez4ec3tc+SaYgxPRIOwF4Pm/EN3frnge9vfcAm6webj8PKWhjaG068+Z0YWA1xkcjMADBuUdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+zJUd1k+z0MTdwV/16E4L8ZlyQechreESliNcQFuySQ=;
 b=csxs1ul3w0LWjV/gk9+x3M9sKCiTsOu5tYJ8ED/yPGalU6hhF/kkFPujj3eMP1+415ndVZMGyt20oLgtFps/bH6th5R9QGANXNaICgQEdlRULZFT7x9bZx1m105Z8OhZ9yGs6TKB98Jn7a4kYN+MWheH0wMM3r6zV6HwO0QybVXxW7nhSZqpIqRBJGpv9CB2ivD/fwmFsy7JVackZGMY0kQjj+3095ue4EOhBGubLulFtUSDGZdJrxKsJ9l/KCfdNmYNcDxYtT8rm2TFZfTTTIvVbQQlToPMoHbeKo+oEvh48Y8+Z/uWwtiDJKDh9JHoiuwXkelXsfv6G0bk86EJxQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU2PR04MB8887.eurprd04.prod.outlook.com (2603:10a6:10:2e2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.26; Sat, 19 Oct
 2024 09:58:50 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8069.016; Sat, 19 Oct 2024
 09:58:50 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Rob Herring <robh@kernel.org>, Frank Li <frank.li@nxp.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Claudiu Manoil <claudiu.manoil@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>, "christophe.leroy@csgroup.eu"
	<christophe.leroy@csgroup.eu>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"horms@kernel.org" <horms@kernel.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH v3 net-next 02/13] dt-bindings: net: add i.MX95 ENETC
 support
Thread-Topic: [PATCH v3 net-next 02/13] dt-bindings: net: add i.MX95 ENETC
 support
Thread-Index: AQHbIGrTTA2gJ/XR3Uu/G3eAF75QCLKLINqAgAFcOgCAAVzekA==
Date: Sat, 19 Oct 2024 09:58:50 +0000
Message-ID:
 <PAXPR04MB85102D0CDA35B2D8E09F8F8E88412@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241017074637.1265584-1-wei.fang@nxp.com>
 <20241017074637.1265584-3-wei.fang@nxp.com>
 <ZxE56eMyN791RsgK@lizhi-Precision-Tower-5810>
 <20241018130926.GA45536-robh@kernel.org>
In-Reply-To: <20241018130926.GA45536-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DU2PR04MB8887:EE_
x-ms-office365-filtering-correlation-id: 5fad890b-fb0f-4ace-843d-08dcf024a1cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?Q1ZpQUhqN2dnOHZGbTFBUkhRVUpNVmMzUUorZjVIcE0rQ2Y1MDY3UDROUFJP?=
 =?gb2312?B?NzUzVmNFODVYNVQ3aVZwWVc1M2VMQ0JKckZzenJLVHJML2txakRHaVc5L3V5?=
 =?gb2312?B?aU11OHJlWjZ5V0R4WCtNWDBlSzI3aGJUdlBWYURUNG1aOEtjZldUUXZLVm1T?=
 =?gb2312?B?L1BtR0JkYllvNlE5aWhrRFRodG5UVU1RZXhPZWszSHcrbkMwdmVBT1Q5MFhV?=
 =?gb2312?B?LzcybHVibnZrd2hHT3lPQkJmTVZ4bXM4b09rU0pRWnN2V0g2dzFqSkczSEE2?=
 =?gb2312?B?Vmg3N3g0ZGRMS01QcVd1VUczbmxPV3lmYlU0T29zdDlXQkt1MkgxYkVXVTQv?=
 =?gb2312?B?clRTMUlQMUpQUTYxam1OOC9hOXJnSlZVVk5PS0VLUGlVczMrWEVVeTluczZY?=
 =?gb2312?B?ejA4YmFna3Z2WVk0WnFSRkVITDdzSGJaV2loVytJVDVnMENGWkN6WDl3QzF4?=
 =?gb2312?B?Q1NaUmVaMWRSZU5JUmhXUHlOMWVrQngyY1VsQ3FmZlkvblFQMHVMRWhoUkYv?=
 =?gb2312?B?ZFAvZ05ITUlnWGY3SlJWV3VhZjRrTkw2ZG9sZUIwKytoZEg4VndmTW5Vemxa?=
 =?gb2312?B?eGlUTDVDdUdRNlZxaXNGcEc4Y2FUamQ1QVdPWVd0eno3UHE3dnBxeTZPd0xu?=
 =?gb2312?B?RnJnTlJSZUtacERqalZ4cURkdHJhRGZVT0tvTkNjaTRKQUVLWkxmMVJERVVh?=
 =?gb2312?B?WDR6Uko4THVGMlZYRDNib2tPMGNEWmphOWhORW9ETkF0K3MrMFFsWUhwWjdw?=
 =?gb2312?B?TUxqQVBZZkVuS0pMdUFnME83UkZnNGMzNER0SjdQaGw2NmNaMmxnVTNwRHBB?=
 =?gb2312?B?OGs4TVZDOGl0b3EvRlVRQlIveHZ0cXFITDVWKzFMcWdPemYreFhzMkpWRXZu?=
 =?gb2312?B?TmtXTzJJZ0FXQWh0Z2o1dXIxejlLM2IvYS9VUm9hRnI3ODdjZjE2UVhYcWpM?=
 =?gb2312?B?ODMyU0d4a2dwZmNlQjFWbnlhSWFKOG1VZWJrS1E5bm10Sy9UT0NMM084TjB1?=
 =?gb2312?B?a0hiRlR4S1c0Nk5uRWRLNDY0UVI3bldCMmo0cXRwRDhiTWRvQzVXL3o4NWFp?=
 =?gb2312?B?a0F3VzRxeUtZOThQZ0RiYWRrN3hBMjR4bEJaR1lCeDFnODBwcTdLTGRFN0FI?=
 =?gb2312?B?NXVQdnNoVnk3ZkE1dWlabnNvTnViZGZCcVB3MUJjUHJLOHA3R0RQbVl3MEZp?=
 =?gb2312?B?a0tHRUFhc3FzU3Zrb0ZhTndha05MZ1pKSFdDTTcrRlg4K0UzWVhGZmRzVmtJ?=
 =?gb2312?B?U3lab3ViMkU0SGU4amVGVjcwTE5rZ29ZblhtWTV1N2NqRm1FYmpSS1ZQeFkv?=
 =?gb2312?B?OXNueHJCSVdxQ0NOdmJPaGp1d1pUa1dEbUZabzNLSUwxRmVGU1o5VllLRGRv?=
 =?gb2312?B?Z0FWZklsWU4vaWNVVEFmaFhKcXFudzl4QWYzeE5aS2FyZTlDaDllUHRKMVdz?=
 =?gb2312?B?aGZZeFFDQWRaNXVadlQwZko1V2p2NzVRcUhJQkdYaXZFa1haQ084OGtmQ1VE?=
 =?gb2312?B?NVlUQml6T2xxQXAxSUNFTzNINEpFZDcwTCsySVNyZll0TE53azVvNU40VkVH?=
 =?gb2312?B?UkxnTlIralpXbFpIKzc3eUVwTk5tSjdSRHMwbUtiVjBJTXBGTE9sVFZVbU9X?=
 =?gb2312?B?MkhMWkZUajQ1OWVBT0ljVFRuckJXcy9vN09UQmdrdkcxVVNnRm5tbXdac1Vm?=
 =?gb2312?B?UHhLUW0wR2V4K2VRSUowQ1NyUm00RHYvL1VHclNkUHNHTDN4SWlyb0xibGVn?=
 =?gb2312?B?dG0zVUdKSjRLMzZlejRmMjdhL2VKSHl2bjE4MjZXb000dEZteFZ3NDFlN2VH?=
 =?gb2312?Q?zZ7mYuZ6d79JI+YTBIt2FpuxBvMCgm8DLPd+c=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?VkZFcWMxMjNXS1NnRFczUEtJbjNZUXNiVnRYUzdRM3NZTjgxNDNXSi8wV01L?=
 =?gb2312?B?LytHaXBpSStkZm5uZVM2TUUzdng0alRIOThqc0VYdUNHd2tuTFQzd1lwcW1t?=
 =?gb2312?B?K01qUHovYVZYVS9GeDdhb0p1MmdTUzhyVDE2SGRYT1MwcWprT2NGTFF3SUdq?=
 =?gb2312?B?RU9GaWc2bmtFb3l4cWFGdXZLcWVIVTBpeEV2SjFEdjE5d1d1OWozS1c3SEM4?=
 =?gb2312?B?TkFOR1NieHRwWXBLWVVYcHppcys0aTZ6YlFvT1RtN0xlY0NZV28rbnc4SFdm?=
 =?gb2312?B?Q2hxTHdrUkVQT25tQm9IajBIamxVc253OWg0UlovZHBydWxTS2pOUGU4Ykhu?=
 =?gb2312?B?TE9takROY0xEQWs2dndqVWZrTm1tSWttN0w5aFhiMWtEY3dlUzl3OExSS01q?=
 =?gb2312?B?Sk1JN3NyVldYdWZlS1hVV1hCK1FIU21BeTBTdE9yaWtaTkowN0xLZUNVRjhj?=
 =?gb2312?B?QllJekpaSTJjNWRZNXpQR0x6MmcvUGNZeWJOMC9WYzhwcUtiL2F4OTBQYWl1?=
 =?gb2312?B?QmJKUklZZ2N1T0NxSVUxVjVSaFhsWEgyeEk4SVRiQ2pKSnRuem9LdnF5WU9o?=
 =?gb2312?B?akdSL1lPMThaak1LeVo3b3A3V08rZmRuamhpTmY3RFJQZFlrYVFVSWgxWEhm?=
 =?gb2312?B?RW9FWnZEcnlueklxMkR0enhHcnFrM1oxREgrTWkwdVdwa3Y0YkNMVnovdHRa?=
 =?gb2312?B?d21TcU9oTWtQSkdSQzhNOXR2OEZEV0t2TjhEb0lzSk4yQkpjSkNRSlhYTmZr?=
 =?gb2312?B?bUljQU9jampJMkZzR1hoMU1keURCTEJDekZQYnpHcTVzalBtV1BlcUlMWU10?=
 =?gb2312?B?TENVMkpnNFMwenJVU2pkeUllMUxxWk1BRitrV3JOR0pRa2F0SEVPTE1nUGhM?=
 =?gb2312?B?eGpPZE1RWHhTVUNSM2Qvc0g5dHhFUzFjNkxvaTJqMWU4MllMQTlxTklCY1FV?=
 =?gb2312?B?aUJZZjBPVFBMZ01FdHZxOFFEeEtDemZKb01kWlV6aFRjZVpSekhRbWFWOUtp?=
 =?gb2312?B?bm9aVEd6d1RwZ3lZNkxmelRmblNhR3dKSUJ2UDFnVXZKRjUwVmJHYW0rK0RO?=
 =?gb2312?B?NzFSUDFXSjl6ZVJKRGlScnUrNDVpZmNERmk5OUR3ZGkvYTVycTRWbUhZZGo0?=
 =?gb2312?B?dDJaTlhDTmZNVHJ0ZmY0MWZLY2RtMHc4SHBFMEoyL3pvVDlNMUNucXhFb1NB?=
 =?gb2312?B?d2VUdG4yMUVXd1BUNG1vNkJvT2ZMSklUTWNCeTFhYWRDbXo1UWN3ZDBVSWFH?=
 =?gb2312?B?VUdwOFlyVGhRVzdJTTByNTVsTzNvS0hxMlhOaHZTQUtxQkN2ZWFFRFhUaFJi?=
 =?gb2312?B?ZkRNZGZDNlZjUWkxYUtyanZQK3JiYjVrZlVWNzZST0dkdTJQMHZ0M2ZTYUZa?=
 =?gb2312?B?aW9sLzNEVXRqVmdhUWxaYmtiMFlKRS9GU3drWS85M2RVUGMxNFZoR1g3Ukl1?=
 =?gb2312?B?UnJDVjRnS3BnaVJ2YWUzM0NLNGtqT09xRDFxdk1PQldsSU15dnF2czFqZEp4?=
 =?gb2312?B?K3NSZ0dmMDc0akhNSW1qTzNjWnR1Yk1VSnZobGtDOXJ0Nk5sMStucS9UKzZ3?=
 =?gb2312?B?YTB0bkRUbG56enhUTnoyK0lTSDVWRkRFNHRobUtTN3ZGeTgrSWl4SnR1akJt?=
 =?gb2312?B?WVQvcVlTdjJNYndWQ0tMNFZJVkFVN1Bta3M3ZURQSmN2ZVN2RS9OV25kWVZh?=
 =?gb2312?B?Ymd2b1RiM0xaazIydzFjL0IzMGJicWYzOThOb2JhRFlXeHlvek1lRWlZc3hZ?=
 =?gb2312?B?c2FRbWlXZ2RjQzQzOSs5aXNYN0tHZWxkWXBaQ1BtaWpuZUJtSzZzQ0VwZ2c1?=
 =?gb2312?B?L2pWRHFjeGtJVmlqbG9MOTNzWGhpRGU5VTI3aDd6UFJScko4Uzk2YjlOTW45?=
 =?gb2312?B?VTM1cGxHTUk4c1Uya0VqR2pZU1JTb3pjM2IrTVJYelE3OVZHQ3E0b1dWZGpL?=
 =?gb2312?B?bXQvVzRKZDV2c3g5ZVFhbEZSd2NDRjROU3M2N042UlJ5RG9sd2JqcXA0YnNz?=
 =?gb2312?B?NnFSenBUZzZ6blE4U1Zwb0FNZm9sMmwxMHRyQ1hsTW16aXlqWFhUM21kZGtl?=
 =?gb2312?B?aTRFYytIR1FrUEFHeDRyMVdnWmFkK0JNamcvdGhOR2VBOXZkS1NGbnRuRTVt?=
 =?gb2312?Q?xj8k=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fad890b-fb0f-4ace-843d-08dcf024a1cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2024 09:58:50.3926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K9hbA6o0Zbm4ouQ6LXS0EBO1E9Uek/6ZNCgPN6mGQcWg+fwoz7N0/22JFRAaWByZXtNwx+nlpIxtnushLITxQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8887

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSb2IgSGVycmluZyA8cm9iaEBr
ZXJuZWwub3JnPg0KPiBTZW50OiAyMDI0xOoxMNTCMTjI1SAyMTowOQ0KPiBUbzogRnJhbmsgTGkg
PGZyYW5rLmxpQG54cC5jb20+DQo+IENjOiBXZWkgRmFuZyA8d2VpLmZhbmdAbnhwLmNvbT47IGRh
dmVtQGRhdmVtbG9mdC5uZXQ7DQo+IGVkdW1hemV0QGdvb2dsZS5jb207IGt1YmFAa2VybmVsLm9y
ZzsgcGFiZW5pQHJlZGhhdC5jb207DQo+IGtyemsrZHRAa2VybmVsLm9yZzsgY29ub3IrZHRAa2Vy
bmVsLm9yZzsgVmxhZGltaXIgT2x0ZWFuDQo+IDx2bGFkaW1pci5vbHRlYW5AbnhwLmNvbT47IENs
YXVkaXUgTWFub2lsIDxjbGF1ZGl1Lm1hbm9pbEBueHAuY29tPjsNCj4gQ2xhcmsgV2FuZyA8eGlh
b25pbmcud2FuZ0BueHAuY29tPjsgY2hyaXN0b3BoZS5sZXJveUBjc2dyb3VwLmV1Ow0KPiBsaW51
eEBhcm1saW51eC5vcmcudWs7IGJoZWxnYWFzQGdvb2dsZS5jb207IGhvcm1zQGtlcm5lbC5vcmc7
DQo+IGlteEBsaXN0cy5saW51eC5kZXY7IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRy
ZWVAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51
eC1wY2lAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgbmV0LW5leHQg
MDIvMTNdIGR0LWJpbmRpbmdzOiBuZXQ6IGFkZCBpLk1YOTUgRU5FVEMNCj4gc3VwcG9ydA0KPiAN
Cj4gT24gVGh1LCBPY3QgMTcsIDIwMjQgYXQgMTI6MjM6MDVQTSAtMDQwMCwgRnJhbmsgTGkgd3Jv
dGU6DQo+ID4gT24gVGh1LCBPY3QgMTcsIDIwMjQgYXQgMDM6NDY6MjZQTSArMDgwMCwgV2VpIEZh
bmcgd3JvdGU6DQo+ID4gPiBUaGUgRU5FVEMgb2YgaS5NWDk1IGhhcyBiZWVuIHVwZ3JhZGVkIHRv
IHJldmlzaW9uIDQuMSwgYW5kIHRoZQ0KPiA+ID4gdmVuZG9yIElEIGFuZCBkZXZpY2UgSUQgaGF2
ZSBhbHNvIGNoYW5nZWQsIHNvIGFkZCB0aGUgbmV3IGNvbXBhdGlibGUNCj4gPiA+IHN0cmluZ3Mg
Zm9yIGkuTVg5NSBFTkVUQy4gSW4gYWRkaXRpb24sIGkuTVg5NSBzdXBwb3J0cyBjb25maWd1cmF0
aW9uDQo+ID4gPiBvZiBSR01JSSBvciBSTUlJIHJlZmVyZW5jZSBjbG9jay4NCj4gPiA+DQo+ID4g
PiBTaWduZWQtb2ZmLWJ5OiBXZWkgRmFuZyA8d2VpLmZhbmdAbnhwLmNvbT4NCj4gPiA+IC0tLQ0K
PiA+ID4gdjI6IFJlbW92ZSAibnhwLGlteDk1LWVuZXRjIiBjb21wYXRpYmxlIHN0cmluZy4NCj4g
PiA+IHYzOg0KPiA+ID4gMS4gQWRkIHJlc3RyaWN0aW9uIHRvICJjbGNva3MiIGFuZCAiY2xvY2st
bmFtZXMiIHByb3BlcnRpZXMgYW5kDQo+ID4gPiByZW5hbWUgdGhlIGNsb2NrLCBhbHNvIHJlbW92
ZSB0aGUgaXRlbXMgZnJvbSB0aGVzZSB0d28gcHJvcGVydGllcy4NCj4gPiA+IDIuIFJlbW92ZSB1
bm5lY2Vzc2FyeSBpdGVtcyBmb3IgInBjaTExMzEsZTEwMSIgY29tcGF0aWJsZSBzdHJpbmcuDQo+
ID4gPiAtLS0NCj4gPiA+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvZnNsLGVuZXRjLnlh
bWwgICAgfCAyMiArKysrKysrKysrKysrKysrLS0tDQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDE5
IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBh
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvZnNsLGVuZXRjLnlhbWwNCj4g
PiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9mc2wsZW5ldGMueWFt
bA0KPiA+ID4gaW5kZXggZTE1MmM5Mzk5OGZlLi5lNDE4YzNlNmU2YjEgMTAwNjQ0DQo+ID4gPiAt
LS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L2ZzbCxlbmV0Yy55YW1s
DQo+ID4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L2ZzbCxl
bmV0Yy55YW1sDQo+ID4gPiBAQCAtMjAsMTAgKzIwLDEzIEBAIG1haW50YWluZXJzOg0KPiA+ID4N
Cj4gPiA+ICBwcm9wZXJ0aWVzOg0KPiA+ID4gICAgY29tcGF0aWJsZToNCj4gPiA+IC0gICAgaXRl
bXM6DQo+ID4gPiArICAgIG9uZU9mOg0KPiA+ID4gKyAgICAgIC0gaXRlbXM6DQo+ID4gPiArICAg
ICAgICAgIC0gZW51bToNCj4gPiA+ICsgICAgICAgICAgICAgIC0gcGNpMTk1NyxlMTAwDQo+ID4g
PiArICAgICAgICAgIC0gY29uc3Q6IGZzbCxlbmV0Yw0KPiA+ID4gICAgICAgIC0gZW51bToNCj4g
PiA+IC0gICAgICAgICAgLSBwY2kxOTU3LGUxMDANCj4gPiA+IC0gICAgICAtIGNvbnN0OiBmc2ws
ZW5ldGMNCj4gPiA+ICsgICAgICAgICAgLSBwY2kxMTMxLGUxMDENCj4gPiA+DQo+ID4gPiAgICBy
ZWc6DQo+ID4gPiAgICAgIG1heEl0ZW1zOiAxDQo+ID4gPiBAQCAtNDAsNiArNDMsMTkgQEAgcmVx
dWlyZWQ6DQo+ID4gPiAgYWxsT2Y6DQo+ID4gPiAgICAtICRyZWY6IC9zY2hlbWFzL3BjaS9wY2kt
ZGV2aWNlLnlhbWwNCj4gPiA+ICAgIC0gJHJlZjogZXRoZXJuZXQtY29udHJvbGxlci55YW1sDQo+
ID4gPiArICAtIGlmOg0KPiA+ID4gKyAgICAgIHByb3BlcnRpZXM6DQo+ID4gPiArICAgICAgICBj
b21wYXRpYmxlOg0KPiA+ID4gKyAgICAgICAgICBjb250YWluczoNCj4gPiA+ICsgICAgICAgICAg
ICBlbnVtOg0KPiA+ID4gKyAgICAgICAgICAgICAgLSBwY2kxMTMxLGUxMDENCj4gPiA+ICsgICAg
dGhlbjoNCj4gPiA+ICsgICAgICBwcm9wZXJ0aWVzOg0KPiA+ID4gKyAgICAgICAgY2xvY2tzOg0K
PiA+ID4gKyAgICAgICAgICBtYXhJdGVtczogMQ0KPiA+ID4gKyAgICAgICAgICBkZXNjcmlwdGlv
bjogTUFDIHRyYW5zbWl0L3JlY2VpdmVyIHJlZmVyZW5jZSBjbG9jaw0KPiA+ID4gKyAgICAgICAg
Y2xvY2stbmFtZXM6DQo+ID4gPiArICAgICAgICAgIGNvbnN0OiByZWYNCj4gPg0KPiA+IERpZCB5
b3UgcnVuIENIRUNLX0RUQlMgZm9yIHlvdXIgZHRzIGZpbGU/IGNsb2Nrc1xjbG9jay1uYW1lcyBz
aG91bGQgYmUNCj4gPiB1bmRlciB0b3AgJ3Byb3BlcnRpZXMiIGZpcnN0bHkuIFRoZW4gdXNlICdp
ZicgcmVzdHJpY3QgaXQuIEJ1dCBJIGFtDQo+ID4gbm90IHN1cmUgZm9yIHRoYXQuIG9ubHkgZHRf
YmluZGluZ19jaGVjayBpcyBub3QgZW5vdWdoIGJlY2F1c2UgeW91cg0KPiA+IGV4YW1wbGUgaGF2
ZSBub3QgdXNlIGNsb2NrcyBhbmQgY2xvay1uYW1lcy4NCj4gDQo+IFRoYXQncyBhIG1hbnVhbCBj
aGVjaywgYnV0IHllcy4gRGVmaW5lIGFsbCBwcm9wZXJ0aWVzIGF0IHRvcCBsZXZlbC4NCj4gDQoN
Ck9rYXksIEkgd2lsbCBtb3ZlIHRoZW0gdG8gdG9wIGxldmVsLCB0aGFua3MuDQo=

