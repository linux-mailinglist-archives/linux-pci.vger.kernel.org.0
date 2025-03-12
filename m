Return-Path: <linux-pci+bounces-23471-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B4DA5D4EB
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 05:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD9773B408F
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 04:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFB61D88A6;
	Wed, 12 Mar 2025 04:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="A0upyHYq"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011024.outbound.protection.outlook.com [52.101.70.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F997E107;
	Wed, 12 Mar 2025 04:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741752337; cv=fail; b=VHXf6dEe/sOs3ee7ajo/gi59apLQCT+W4c7e1KCO3c2iFaEXdoU3VGeHz+FlV/rIWFnDl+uf+voHWmV+WNSH+h5rB5T2CCzhXWgBrBGPyUxfaeEjlm25o8NBYRsHlu6qdDf/sCxzRU54hadil7ck19p6zpVxG1grUmozn/hUkOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741752337; c=relaxed/simple;
	bh=IJhlporHttqUZ3yqv00H5kxApvNSkf7Ab9qwaXscE9Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SUEFgNsG1S+g/xoP7jmBcN6vQR6bK0hpjEvjGDnbirpisyrA0GSR1X2TJaX6ww2XgTwOGBio4pNdgaYcB+vnbwzUkHd3nnq0l/9kDtAl7JVuntlbDPA7vC/SeKxWlekh/QCnGgaEkMOV1cf8wtrcKxy+9DSVG3pHQ7bzQDpeYN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=A0upyHYq; arc=fail smtp.client-ip=52.101.70.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C9clCrYN8l4TKLQ9aHyIV5XKkgyfw2at4rAT+SLCM80j79SIxpT4KHC7Ma6XG9v2EGBN7szee7OmwO2ZEqpgOYIvEhwNZoxl1WIpsWiPpq85gV2ijmnhg0Zoa+8dL86TuKHSk4OJsRhV+i+Kt81du7w+vrzTUIJCHeFarxWL4Fnq2rBPFtrWu8rJ9DxwMyO78YZtYNfpeQPAQyrDdY3wepnI2Ge65dyoLVS5zjn65lR4PWB1Z9KUzectdyAsXkBNx+xGxmz6+fgrNTyUkOXNwqdcAdcklPOmuQiB8bH4ptbSG/JslDfRKkbl4GlQEd7y28I67BEs0K/wL/dooREG3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IJhlporHttqUZ3yqv00H5kxApvNSkf7Ab9qwaXscE9Y=;
 b=KQLJpSzdDsy+RHPbAUqa8DW/RkW47teG4C293p0bSPDB4CGT7V4THKKAIYcBeH0OwL/VQDhR3LWKdwdKmFBBiikncWjAG/D/G+7Q+XWM4eeNr0ZMGBj3GdnNKsNJ3b7pMMibxBtGcYEs7a51860ruznVmhfqY/1S0P/1E4DxDNO5R4efgtG/q1WOqi4df+UsoYrXm7g7eaR4SCzhNlJ8xZPQqt+it+1JO92D6LjAQXrVaOYZPaIkve1ru0y/3PGhA/4v4HtJ8qjRKKD6HlW8kYDZSc9FAWh6FqAAHkeCv3fijx2lAWxNBccZw3IQY5HxYITFeTKMUbz5TKDhBLrK4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJhlporHttqUZ3yqv00H5kxApvNSkf7Ab9qwaXscE9Y=;
 b=A0upyHYqKXqW5JQY0KB/ba+rK9ZLVLJB6VQXTuaJXTn4rKXJdLq1ghg9L2O81ktjkSn14E33em5D7ER8bYVHfX5ZAHDu6KbOZIQV0+vqQXTeJggbiAQXxhBuX2jEyZBytKcHCb+3f7S/YET8xasVwjbbEBg9WfDjR+KCmRRR0uaZrnxGBEbZIc/EaTvMwZ05Q+qIhC028j5bjb3Q0FgqOyBR4WmpVz0N4BvWyqgPwX/++gLO0tN/k8svN9lOPlce0fJPuJ1IGZdVF0+DJzAo3ubFRwBQdOqbgtNZRt6vEKgakfbpyYIPTZGBdDpTBpggOkd3yeRcx9RJUQadl0Bhkw==
Received: from DU2PR04MB8677.eurprd04.prod.outlook.com (2603:10a6:10:2dc::14)
 by GV1PR04MB9056.eurprd04.prod.outlook.com (2603:10a6:150:1f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 12 Mar
 2025 04:05:30 +0000
Received: from DU2PR04MB8677.eurprd04.prod.outlook.com
 ([fe80::6b10:a2e8:fdf0:6bdd]) by DU2PR04MB8677.eurprd04.prod.outlook.com
 ([fe80::6b10:a2e8:fdf0:6bdd%6]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 04:05:30 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "manivannan.sadhasivam@linaro.org"
	<manivannan.sadhasivam@linaro.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 2/2] PCI: imx6: Use domain number replace the hardcodes
Thread-Topic: [PATCH v1 2/2] PCI: imx6: Use domain number replace the
 hardcodes
Thread-Index: AQHbh/hQ+lMRWdlcb0ifZRKBhtO67bNsjV2AgACiisCAAPwCAIAAlsSQ
Date: Wed, 12 Mar 2025 04:05:30 +0000
Message-ID:
 <DU2PR04MB8677AC699DF11D847AB768708CD02@DU2PR04MB8677.eurprd04.prod.outlook.com>
References:
 <AS8PR04MB8676E66BD40C37B2A7E390178CD12@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <20250311155452.GA629749@bhelgaas>
In-Reply-To: <20250311155452.GA629749@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8677:EE_|GV1PR04MB9056:EE_
x-ms-office365-filtering-correlation-id: c87e0f58-44c0-4a5e-2e3c-08dd611b20f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?M2hyckYvTXV3Si9ObGoraFFlSUZRTVprb1Zyb2xNblZRclBPejk3YkhIRDMw?=
 =?utf-8?B?dzBQZGJqcEpiajhJcWZZSmEzTjlUSXZXaTV0TElUZ0VNalpNTk1NdXBOOHJx?=
 =?utf-8?B?a0NWQVZyMml1d29pNFBYMUxwVzQ5bUk1RmNBcUVZTU9NZHcrWW9SUVVEWndw?=
 =?utf-8?B?ZmpVUHFpTnozMmZ0eEEvcUFPVEdwbGJMb2JUZmdoOVlQNmxJWnJkYTAvZ3Bx?=
 =?utf-8?B?akN5Qk9pOGFud2J4SEQwWWRmRjh4YUxuU3QrNTVFZEx2cjFnUThWallRR0dQ?=
 =?utf-8?B?MEFnczlLRlRmQ0Z6dHZEUWxxMk16bE1TOERVSXBqYWg4Q0ZGNjVXRmNqWXlI?=
 =?utf-8?B?S3BjbmJ5d2tJS01RTm9Bd0ZvRUxVeUxZSW9MampqbWQ3U2RBZUo4cEVkWDMy?=
 =?utf-8?B?am9OSkVTclNGZW82aU05RTBkVlFlSGladlVHd0dRUTFVYzRYVHVmR2ltajE4?=
 =?utf-8?B?TzV5ZGUyUUVlNURoKzdpY1lsMFFLd2pLc3o5SjZRY1I2VUlkRGZSMzBsTHNj?=
 =?utf-8?B?VFk3SG9STDFYUzNxaVVjSkZ2aDZOcFV5akkvdVlVSzFCejNycnNZeEZhcmdU?=
 =?utf-8?B?YU5CZDRQWXBIQmtHc2FYdFlsc3JOM0lqRGVIc1hHUzJRS2s1TUdiV2NnOWVr?=
 =?utf-8?B?Ym1kYVRrYVh2bGtNQWJFWThXc002bGMxNjgrNHFycUNpY0FlM1p0c0Nlem5k?=
 =?utf-8?B?aDlDNTU2MFhhSWVTd0R0V1RYMWpmZ0JCMnhTOWt5K0lyZGtDUWNWVC9VZXpE?=
 =?utf-8?B?T2Zwc0FuaUNhVzNFVWo2SEl6RzZTV2E1WlpqSk85U0R2K21HcXNNWFg4Rm45?=
 =?utf-8?B?T0xkZVV3SEx0TDAyZWM2RFlrMldkWlA5bGdNclpMdUFHSVhSN2tIdjBvenIr?=
 =?utf-8?B?WDArNXRiQXQrY010UkUzTFFVRnBIZTVFZXlvN1p4dlBqL0FCaUFTZFc3MG8r?=
 =?utf-8?B?TEc2WnQvd0tSZDZlRWdOdkUrd3dTRkVNZmROZG9TcVAxakZ1TUhaM0JzZlBo?=
 =?utf-8?B?V0xqTTgwdzRtRkpIY1Z3RnlsNVhZTWNYaVRMMmNvanpqc3BuZU91b3RPL1pa?=
 =?utf-8?B?NDh1YlkyYXYvSkhuRnpBWlY5R0JTOGxqc0lkYWJLWUdxdzdwRnRpWGlaeWJY?=
 =?utf-8?B?MUFyTFlRSUxiQnpnMHZuQ29jQkpzYVBsd2xIQjdPOXBsZVIrczJYYmtTdWNi?=
 =?utf-8?B?ZTJLejl4SVd1cjBtZ0dXU1llSzRVWFNhVGZPcnVsSWsrbWZWMlVrcXNFMktW?=
 =?utf-8?B?bDY2REdzdmNYNDBVN1laUm4rVjYrdkZ4Sy81TXJUbGxZMXJiK21xdzVhNlIy?=
 =?utf-8?B?ZzlpcGxpVUU2bjNTd3kwRFJ3QTd1cDArRFU0WDY5NW5TL0lnelR3d3NvaVhy?=
 =?utf-8?B?dlpJZ3NkQnB3T0phemtINnA2anpLNEFlREtOYUdVTnd2eU56RkxLNHgzR2lG?=
 =?utf-8?B?S0c3cVh5SzFDTmY3MUJBL2Q3cldSb1dGT1AwVzlCa0FYWFhvMXYvWG8wbVl2?=
 =?utf-8?B?QXFBMXNjSmduemhBWEU1VEZBM3RWSG5DWEIzUURPYW8vUEs5YmF6d2FLd1dm?=
 =?utf-8?B?QTB3OGJTRGUyc2FLTUZHVFYvZnhVVmk3aFJkbDdVYmg5Wkg5R2ZwRStxQ2tW?=
 =?utf-8?B?dUoxampjaThWWDdwZ2pGckErOG9LaEFPTjFRWDJyWGZWYm5jdkc0cDZ0TU9m?=
 =?utf-8?B?WVNRMTF3Y0ppeVNxMTdxa1FpWXJTSWZBYU1rQ2t4TUtYR3B0N2JWa1VLblkv?=
 =?utf-8?B?WndKc1E0Uy9LZWtQdXZKMmE5aWdKQ20xd3FmdlQ0VDIzSlJwMndlbExUMlVD?=
 =?utf-8?B?dDhjMUJwK2d4dGJIcVRCaEVZUWl3dU03elBPQ1I1Ri9QRFpMSGFlV1lDSGlP?=
 =?utf-8?B?UHNpZ0J0RU1SUC9aQUt3bjhxYm4yOHllVW5MT2pJQ2NhNWtQL3dpYjA0WUlG?=
 =?utf-8?Q?9IzSywoL3IWbIQDbLCdeZSFV28qgYbdJ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8677.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RFBzNVp2RUR1cUd2RWNFSXp0Z0QwM2pSUVdnSVc3NzNRcm5aV2NNQkVXNG1y?=
 =?utf-8?B?eUVpM1FuTkdkcWEwbmZkaWtaME1OdkhsSVBIdVFyTEx0ZVdjaCtDV2x0WVdq?=
 =?utf-8?B?WisyRjRidHVlYWhPaUlCMTJEOWRQdWh2R3R0MDZZKzBqNHhzS1FZckVSak5h?=
 =?utf-8?B?bDRGdE9YNWZxMU1KMFBSSUc0V3phWmNGdDBuQTBWaTdiL2p3OUJFVHp0cmJG?=
 =?utf-8?B?YXJYNmRWcnZXa1BqN05nVWJrazdnVXZTSytmaHo0NEJkQWQ0T3VaTVpDK0Nk?=
 =?utf-8?B?dm5MQWVWek1pMnZ6UkQzdUZqQ2U5ck1uMklGem9uR01rTk92R0Q0WXFNSlA4?=
 =?utf-8?B?MEU1ZlZabk12V1BHTlJmOThuY09PSXgrRVF0MnBHdUZtNHhMSXp1SXNOTVlp?=
 =?utf-8?B?OXBacHdnc2FwUHNuWWhMVXhzNUJyWTY3ZmpyQjIrNGNuWWIyLzJWSkVTY3Fq?=
 =?utf-8?B?ZW5PWDE3SnNJVDFPVjAzSnQ2UXhrUGRaYThFckdmQlRoRWtVa3o0c2E1ZGJG?=
 =?utf-8?B?WmIyK2RMRUtsdE1YWmRKSFFxY0drbjVhSlNQa1JNbys1S1lTOHJ6YU80aXJY?=
 =?utf-8?B?OHRhaWU3dkZvTmdWTXdJT1pSczFmZmozdFhSZkpJWGRYM0lEbHNzWmlrdDRs?=
 =?utf-8?B?T2N4YWV0NTdVMXVFZTJMVEVUUHVBbVZRZVZ5WWgwa1BaRUFjbVQrZ3dBUENJ?=
 =?utf-8?B?aVlSaUNsR2N5ZGdSUHloakJKYURPbjdQNXJaOU5FcTh1T0IzVXFIanpvZzl2?=
 =?utf-8?B?R3F1Q0xkcFA2WW5vL2FoRWpQRFlPNWZqNzNITHQ4a1ZLNFMzb2xyZ2Q1Tk9j?=
 =?utf-8?B?MTVVRGtjT21IYVpnSkZiUG0yUDJQT29RazlEWmErZXFadVpqMDF4ZFlwWWhO?=
 =?utf-8?B?eEJOc3g5OXhLcmJreXhVU2VwaThTUnlLeUNKODhnamM1VXk3djE3bE9nMzFW?=
 =?utf-8?B?T0ViY3YwMTVlS1d1ZjNMdnVISUk4WGhjeUdQbmdsZUFoOXFQeW9FTXNlM1VU?=
 =?utf-8?B?NjM5OG5OVkN1NGE0N285QndIZnB2WVFjZk14K2hzZGZ3OVZBT2trWE5wb280?=
 =?utf-8?B?cXZSSEU4b1pTRUxCODhnMkZJYWdRNklvTVl2NjZ4V3NJZ0c4UXQvTm16NDdF?=
 =?utf-8?B?cU8wQ2U4VDM0VDFTQXJlS0FYc1NZbm91bkVOSEJlZDhqQ2NzbThPY0NQaDdU?=
 =?utf-8?B?bGVDeURSVlIydDJUV2Z0ZXphSTltZ2dYTGM2bVdIalhtb0ZYZWx0aG9aaFFU?=
 =?utf-8?B?ZjFpRTVCK21ycUg5c1Zjbjd4bVdMY3JEVUJPOXlTZXlOQWtJek9lZmJTekha?=
 =?utf-8?B?R0hmRUsrYmpxVXpIaUNFL1Rta2dPM1d3NDcydlNPMGpnamNSS1lyK2huUmNF?=
 =?utf-8?B?RzNVYm5oUWZ6M0x0VVdBMnIzMkNSUW83dzBicWxLRms3OTU2UUN2Qmg3YzVB?=
 =?utf-8?B?T2pNbXFJWElnNUVEVTVsbEhXdVg1YnZNR2srT3JIN3ZyVzg2RzNTWjJiSkxE?=
 =?utf-8?B?andCMWdzMVV0TGhPdlE3NE5BeGQzU25vZDdWdVJVQ1JHelZTNDV1Wi80OUV2?=
 =?utf-8?B?dWdRcWg0VUxqajhtTXJPL3JoQk9FbjZUOUNyUkU3ZmtNMnhseU5DWEp4dCtI?=
 =?utf-8?B?VHFnSDFyNW0yOXI3Wi9lTnpMblpTWXNrU3FZOTYxM1RrZU1rSEVFQmkrZ1pD?=
 =?utf-8?B?MjUvL3QvSlprcXByMjNtRmRabVdteWpRdnZhQjJGTVVhd1RlcC84U2JhcnpQ?=
 =?utf-8?B?NXBZWEh0RWFxVjdXVm8vT252KzVCVWZleTBpMEllekxkR2pHdlN4aGFCYmxt?=
 =?utf-8?B?ZHF6OGNITmtndE02b0lFMUl3OU5yY2ZXSnJwTi8vejlWUFBEWDdpUHBFeVU1?=
 =?utf-8?B?TXhzb3V0ekM4Wm54VTBBMTNFejhNRnVERnJZMlEvNkNDbnoyYk9iaUdlVjcv?=
 =?utf-8?B?L2VtcDdwYldHSnFtZWd3K2Y1T0FSTHRRRWtmSFhhbDk3clJ6bGhWeGNnNEpo?=
 =?utf-8?B?N3k4MXRDYjhhM29DUGZRWExXWHlwUm5maDViTkY3aVdEMmt5YmUzaUJkNzVH?=
 =?utf-8?B?Um9RVVI1WWM2WXJodWVWcXpHSW01ZVpqNEViUTlWYzZ5R1VxVVZSVFpvVHg1?=
 =?utf-8?Q?BVypHEz/hQ1Ie3u8bvohuJYOI?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8677.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c87e0f58-44c0-4a5e-2e3c-08dd611b20f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2025 04:05:30.1156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t2wyx4dxEn+MY/MhYxV6VN/qdskpiNYTIrfFV7gx/SLMV6pMWgHwowduCa7cMatWRK/6SAQW532B1tPGKdQchA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9056

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCam9ybiBIZWxnYWFzIDxoZWxn
YWFzQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjXlubQz5pyIMTHml6UgMjM6NTUNCj4gVG86IEhv
bmd4aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+IENjOiByb2JoQGtlcm5lbC5vcmc7
IGtyemsrZHRAa2VybmVsLm9yZzsgY29ub3IrZHRAa2VybmVsLm9yZzsNCj4gc2hhd25ndW9Aa2Vy
bmVsLm9yZzsgbC5zdGFjaEBwZW5ndXRyb25peC5kZTsgbHBpZXJhbGlzaUBrZXJuZWwub3JnOw0K
PiBrd0BsaW51eC5jb207IG1hbml2YW5uYW4uc2FkaGFzaXZhbUBsaW5hcm8ub3JnOyBiaGVsZ2Fh
c0Bnb29nbGUuY29tOw0KPiBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5j
b207IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1wY2lAdmdlci5rZXJuZWwu
b3JnOyBpbXhAbGlzdHMubGludXguZGV2OyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7DQo+IGxpbnV4
LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDIvMl0gUENJOiBpbXg2OiBVc2UgZG9tYWlu
IG51bWJlciByZXBsYWNlIHRoZQ0KPiBoYXJkY29kZXMNCj4gDQo+IE9uIFR1ZSwgTWFyIDExLCAy
MDI1IGF0IDAxOjExOjA0QU0gKzAwMDAsIEhvbmd4aW5nIFpodSB3cm90ZToNCj4gPiA+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBCam9ybiBIZWxnYWFzIDxoZWxnYWFz
QGtlcm5lbC5vcmc+DQo+ID4gPiBTZW50OiAyMDI15bm0M+aciDEw5pelIDIzOjExDQo+ID4gPiBU
bzogSG9uZ3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gPiA+IENjOiByb2JoQGtl
cm5lbC5vcmc7IGtyemsrZHRAa2VybmVsLm9yZzsgY29ub3IrZHRAa2VybmVsLm9yZzsNCj4gPiA+
IHNoYXduZ3VvQGtlcm5lbC5vcmc7IGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU7IGxwaWVyYWxpc2lA
a2VybmVsLm9yZzsNCj4gPiA+IGt3QGxpbnV4LmNvbTsgbWFuaXZhbm5hbi5zYWRoYXNpdmFtQGxp
bmFyby5vcmc7DQo+IGJoZWxnYWFzQGdvb2dsZS5jb207DQo+ID4gPiBzLmhhdWVyQHBlbmd1dHJv
bml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207DQo+ID4gPiBkZXZpY2V0cmVlQHZnZXIua2VybmVs
Lm9yZzsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsNCj4gPiA+IGlteEBsaXN0cy5saW51eC5k
ZXY7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsNCj4gPiA+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiA+ID4gU3ViamVj
dDogUmU6IFtQQVRDSCB2MSAyLzJdIFBDSTogaW14NjogVXNlIGRvbWFpbiBudW1iZXIgcmVwbGFj
ZSB0aGUNCj4gPiA+IGhhcmRjb2Rlcw0KPiA+ID4NCj4gPiA+IE9uIFdlZCwgRmViIDI2LCAyMDI1
IGF0IDEwOjQyOjU2QU0gKzA4MDAsIFJpY2hhcmQgWmh1IHdyb3RlOg0KPiA+ID4gPiBVc2UgdGhl
IGRvbWFpbiBudW1iZXIgcmVwbGFjZSB0aGUgaGFyZGNvZGVzIHRvIHVuaXF1ZWx5IGlkZW50aWZ5
DQo+ID4gPiA+IGRpZmZlcmVudCBjb250cm9sbGVyIG9uIGkuTVg4TVEgcGxhdGZvcm1zLiBObyBm
dW5jdGlvbiBjaGFuZ2VzLg0KPiA+ID4gPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBSaWNoYXJk
IFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAgZHJpdmVy
cy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYyB8IDE0ICsrKysrKy0tLS0tLS0tDQo+ID4g
PiA+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KPiA+
ID4gPg0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNp
LWlteDYuYw0KPiA+ID4gPiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMN
Cj4gPiA+ID4gaW5kZXggOTBhY2U5NDEwOTBmLi5hYjllYmI3ODM1OTMgMTAwNjQ0DQo+ID4gPiA+
IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiA+ID4gKysr
IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiA+ID4gPiBAQCAtNDEs
NyArNDEsNiBAQA0KPiA+ID4gPiAgI2RlZmluZSBJTVg4TVFfR1BSX1BDSUVfQ0xLX1JFUV9PVkVS
UklERQlCSVQoMTEpDQo+ID4gPiA+ICAjZGVmaW5lIElNWDhNUV9HUFJfUENJRV9WUkVHX0JZUEFT
UwkJQklUKDEyKQ0KPiA+ID4gPiAgI2RlZmluZSBJTVg4TVFfR1BSMTJfUENJRTJfQ1RSTF9ERVZJ
Q0VfVFlQRQlHRU5NQVNLKDExLA0KPiA4KQ0KPiA+ID4gPiAtI2RlZmluZSBJTVg4TVFfUENJRTJf
QkFTRV9BRERSCQkJMHgzM2MwMDAwMA0KPiA+ID4gPg0KPiA+ID4gPiAgI2RlZmluZSBJTVg5NV9Q
Q0lFX1BIWV9HRU5fQ1RSTAkJCTB4MA0KPiA+ID4gPiAgI2RlZmluZSBJTVg5NV9QQ0lFX1JFRl9V
U0VfUEFECQkJQklUKDE3KQ0KPiA+ID4gPiBAQCAtMTQ3NCw3ICsxNDczLDYgQEAgc3RhdGljIGlu
dCBpbXhfcGNpZV9wcm9iZShzdHJ1Y3QNCj4gPiA+ID4gcGxhdGZvcm1fZGV2aWNlDQo+ID4gPiAq
cGRldikNCj4gPiA+ID4gIAlzdHJ1Y3QgZHdfcGNpZSAqcGNpOw0KPiA+ID4gPiAgCXN0cnVjdCBp
bXhfcGNpZSAqaW14X3BjaWU7DQo+ID4gPiA+ICAJc3RydWN0IGRldmljZV9ub2RlICpucDsNCj4g
PiA+ID4gLQlzdHJ1Y3QgcmVzb3VyY2UgKmRiaV9iYXNlOw0KPiA+ID4gPiAgCXN0cnVjdCBkZXZp
Y2Vfbm9kZSAqbm9kZSA9IGRldi0+b2Zfbm9kZTsNCj4gPiA+ID4gIAlpbnQgaSwgcmV0LCByZXFf
Y250Ow0KPiA+ID4gPiAgCXUxNiB2YWw7DQo+ID4gPiA+IEBAIC0xNTE1LDEwICsxNTEzLDYgQEAg
c3RhdGljIGludCBpbXhfcGNpZV9wcm9iZShzdHJ1Y3QNCj4gPiA+IHBsYXRmb3JtX2RldmljZSAq
cGRldikNCj4gPiA+ID4gIAkJCXJldHVybiBQVFJfRVJSKGlteF9wY2llLT5waHlfYmFzZSk7DQo+
ID4gPiA+ICAJfQ0KPiA+ID4gPg0KPiA+ID4gPiAtCXBjaS0+ZGJpX2Jhc2UgPSBkZXZtX3BsYXRm
b3JtX2dldF9hbmRfaW9yZW1hcF9yZXNvdXJjZShwZGV2LA0KPiAwLA0KPiA+ID4gJmRiaV9iYXNl
KTsNCj4gPiA+ID4gLQlpZiAoSVNfRVJSKHBjaS0+ZGJpX2Jhc2UpKQ0KPiA+ID4gPiAtCQlyZXR1
cm4gUFRSX0VSUihwY2ktPmRiaV9iYXNlKTsNCj4gPiA+DQo+ID4gPiBUaGlzIG1ha2VzIG1lIHdv
bmRlci4NCj4gPiA+DQo+ID4gPiBJSVVDIHRoaXMgbWVhbnMgdGhhdCBwcmV2aW91c2x5IHdlIHNl
dCBjb250cm9sbGVyX2lkIHRvIDEgaWYgdGhlDQo+ID4gPiBmaXJzdCBpdGVtIGluIGRldmljZXRy
ZWUgInJlZyIgd2FzIDB4MzNjMDAwMDAsIGFuZCBub3cgd2Ugd2lsbCBzZXQNCj4gPiA+IGNvbnRy
b2xsZXJfaWQgdG8gMSBpZiB0aGUgZGV2aWNldHJlZSAibGludXgscGNpLWRvbWFpbiIgcHJvcGVy
dHkgaXMgMS4NCj4gPiA+IFRoaXMgaXMgZ29vZCwgYnV0IEkgdGhpbmsgdGhpcyBuZXcgZGVwZW5k
ZW5jeSBvbiB0aGUgY29ycmVjdA0KPiA+ID4gImxpbnV4LHBjaS1kb21haW4iIGluIGRldmljZXRy
ZWUgc2hvdWxkIGJlIG1lbnRpb25lZCBpbiB0aGUgY29tbWl0IGxvZy4NCj4gPiA+DQo+ID4gPiBN
eSBiaWdnZXIgd29ycnkgaXMgdGhhdCB3ZSBubyBsb25nZXIgc2V0IHBjaS0+ZGJpX2Jhc2UgYXQg
YWxsLiAgSQ0KPiA+ID4gc2VlIHRoYXQgdGhlIG9ubHkgdXNlIG9mIHBjaS0+ZGJpX2Jhc2UgaW4g
cGNpLWlteDYuYyB3YXMgdG8NCj4gPiA+IGRldGVybWluZSB0aGUgY29udHJvbGxlcl9pZCwgYnV0
IHRoaXMgaXMgYSBEV0MtYmFzZWQgZHJpdmVyLCBhbmQgdGhlDQo+ID4gPiBEV0MgY29yZSBjZXJ0
YWlubHkgdXNlcw0KPiA+ID4gcGNpLT5kYmlfYmFzZS4gIEFyZSB3ZSBzdXJlIHRoYXQgbm9uZSBv
ZiB0aG9zZSBEV0MgY29yZSBwYXRocyBhcmUNCj4gPiA+IGltcG9ydGFudCB0byBwY2ktaW14Ni5j
Pw0KPiA+IEhpIEJqb3JuOg0KPiA+IFRoYW5rcyBmb3IgeW91ciBjb25jZXJucy4NCj4gPiBEb24n
dCB3b3JyeSBhYm91dCB0aGUgYXNzaWdubWVudCBvZiBwY2ktPmRiaV9iYXNlLg0KPiA+IElmIHBj
aS1pbXg2LmMgZHJpdmVyIGRvZXNuJ3Qgc2V0IGl0LiBEV0MgY29yZSBkcml2ZXIgd291bGQgc2V0
IGl0IHdoZW4NCj4gPiAgZHdfcGNpZV9nZXRfcmVzb3VyY2VzKCkgaXMgaW52b2tlZC4NCj4gDQo+
IEdyZWF0LCB0aGFua3MhICBNYXliZSB3ZSBjYW4gYW1lbmQgdGhlIGNvbW1pdCBsb2cgdG8gbWVu
dGlvbiB0aGF0IGFuZA0KPiB0aGUgbmV3ICJsaW51eCxwY2ktZG9tYWluIiBkZXBlbmRlbmN5Lg0K
SG93IGFib3V0IHRoZSBmb2xsb3dpbmcgdXBkYXRlcyBvZiB0aGUgY29tbWl0IGxvZz8NCg0KVXNl
IHRoZSBkb21haW4gbnVtYmVyIHJlcGxhY2UgdGhlIGhhcmRjb2RlcyB0byB1bmlxdWVseSBpZGVu
dGlmeQ0KZGlmZmVyZW50IGNvbnRyb2xsZXIgb24gaS5NWDhNUSBwbGF0Zm9ybXMuIE5vIGZ1bmN0
aW9uIGNoYW5nZXMuDQpQbGVhc2UgbWFrZSBzdXJlIHRoZSAiIGxpbnV4LHBjaS1kb21haW4iIGlz
IHNldCBmb3IgaS5NWDhNUSBjb3JyZWN0bHksIHNpbmNlDQogdGhlIGNvbnRyb2xsZXIgaWQgaXMg
cmVsaWVkIG9uIGl0IHRvdGFsbHkuDQoNCkJlc3QgUmVnYXJkcw0KUmljaGFyZCBaaHUNCg0K

