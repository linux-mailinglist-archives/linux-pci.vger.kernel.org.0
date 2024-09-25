Return-Path: <linux-pci+bounces-13472-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F48985189
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 05:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1283F1F212E1
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 03:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE3814A0AE;
	Wed, 25 Sep 2024 03:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lVMmQbBg"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012070.outbound.protection.outlook.com [52.101.66.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9437314900F;
	Wed, 25 Sep 2024 03:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727235596; cv=fail; b=nJqtqpICi1zAWuJZ1dkNDUiuN3gUoAPzJFQIeyb3jR1c6SJF5RGMubxLaS6g+bbxDD7W/6w01LwaytOoAy7HaPcNljsRxfnBC/8M0WRsKCoedwqEHrU9lmZjN1c5L7r5YqyhNGzRY5s4J27qQX/gBtIMHZ48oiW484CDggItf+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727235596; c=relaxed/simple;
	bh=4MaGhbvl7Zb+EwvpPVaALd/S1oOxwTPxXtkymmgAdOk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=quUvoHN5YYjW7Al30mkyEbrzFVTDOdNsXhkg6pA5Y1bx61mqiLh93sPGNCOQdq9mHzYuiXL6/B+TCrCwSit9nlT8vF5dOgxXgUUceytLfJ/YwHO9Y79vuDrzUIanwSR7g1aAraONwINYGva3EEBsR2askBvA6uDwkEAzWKOEmGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lVMmQbBg; arc=fail smtp.client-ip=52.101.66.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PpbHTi2ZkkwxXiTT7LIL60V/dyAl/3lYfSsr6cD8Tkm8FB/D3ToSC4A6xz9wsHAa4dZLpwoYEL24YX9Sp/4YFAu2KYjrK8tSUR2WAgAjHOHPQp5PJT96frueJJ05/QITg6S91sZ/JgO64mi3uS2dbdPMU0YPunZHPzBOHsnNBheCgzYmpQGlMK1GxyXcrPxpredrN0/Hh3MvxMA2/FpOtuB3m9vPUzHxOMvDu2D3d27xk6W5qhWAjVIoYtmpsNVmZSW7ZWAKgnuMuZ5FHlMB7k9l5zclV0rJrw8PA9bCDo5L0YQYRIGvQh5TGxotrSIzfcuFy6KLzfXPBOvpOfFCyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4MaGhbvl7Zb+EwvpPVaALd/S1oOxwTPxXtkymmgAdOk=;
 b=oNFN/4diBpG3YqWh1uYqTfh69XY6IXfcvVPf+d0v+IDYT5ykvL9xl7ixuvI/R6LnbIEp2Urou0o58cA9kmPnwoqnv8QA9AVfYZDHxvCN5BrZgaxQSr7T0NjOd/+0RPQIr0lNZkEaC0jgEZ884dj+iWWdBwQUIURK3L8EiM+ClXcgvmC7xwezCcVd/H4NtqgF7hYosxuq/6dwFUhTUxlepWnsvdy2zOhnZmY8/lT0g9gpurJjMPkdLdcF90yHXyVpCUnKBDFM7KtkiZ88L0pzoh/n/N9KH1Vu14LL0hIPURuStt8McOmg6P1NBWQEsCQB4jsGYMjiBLtVJbEIWaWcRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4MaGhbvl7Zb+EwvpPVaALd/S1oOxwTPxXtkymmgAdOk=;
 b=lVMmQbBg6Wcswv/CUrd1qoyNqpKGvkmh2mYfV9DWj7K6UK4U+OsilQB5Hql6sCsjdxZ1IBVbMVQp2ekaFX0wdL+sel3wxRp3ZJeb7eNYUqSKZLkGfu11XovwGFaUGZkXzaKCuYSVNweg3apWHXgJhnkAsxgwz6Msff/u/uxgbWr7Je8H5r52LhbNa30OVOQ7vqMYn/6vjJVSvWAaAlUuk5mkTDgqdmF9GXD6LD43NLHMsvQcnFQrDV8BxJtD+YHPl6yMykvn/KPkyHD+yt/VwHuk6HI4dlB3OUxwYERwZRVazKCEOvw5ZiibTUSqB8b6AawvoZB1LlJtftwB2JtUDg==
Received: from DU2PR04MB8677.eurprd04.prod.outlook.com (2603:10a6:10:2dc::14)
 by AM9PR04MB8796.eurprd04.prod.outlook.com (2603:10a6:20b:40b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 25 Sep
 2024 03:39:50 +0000
Received: from DU2PR04MB8677.eurprd04.prod.outlook.com
 ([fe80::6b10:a2e8:fdf0:6bdd]) by DU2PR04MB8677.eurprd04.prod.outlook.com
 ([fe80::6b10:a2e8:fdf0:6bdd%4]) with mapi id 15.20.7918.024; Wed, 25 Sep 2024
 03:39:50 +0000
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
Thread-Index: AQHa7VchMMLSKbpmfky4pqFpd8TS8LJBcW0AgAYQTQCAB1ZI8IAZRk+g
Date: Wed, 25 Sep 2024 03:39:50 +0000
Message-ID:
 <DU2PR04MB867718B22942AB676224F56B8C692@DU2PR04MB8677.eurprd04.prod.outlook.com>
References: <1723534943-28499-1-git-send-email-hongxing.zhu@nxp.com>
 <ZtMUbpBJscWlgkhW@dragon> <ZtgqmCbkD1ruZr4U@dragon>
 <PAXPR04MB86884911B9D2B379246C00278C992@PAXPR04MB8688.eurprd04.prod.outlook.com>
In-Reply-To:
 <PAXPR04MB86884911B9D2B379246C00278C992@PAXPR04MB8688.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8677:EE_|AM9PR04MB8796:EE_
x-ms-office365-filtering-correlation-id: 33bb6654-c57f-41c7-12d4-08dcdd13b5c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?SEgrbDlCandRTmhJNS9TdEc4VWFYNjk0ai9iNnZ1TVNMUzNCWFZRLzk1eGcr?=
 =?gb2312?B?MG41eTVKWSttays1SEpidnFVbnVWTmFXRTI3SGt3dy9yczU1ZWZFbCtOblEz?=
 =?gb2312?B?M0d1UDJhSkNPY3ErZHROK1Nac0NWZUVNTW93dmdwcklNVUJuTHNseUZpUy9S?=
 =?gb2312?B?N2pHODBQVEJVZ2MyT3lsZ3JIaFJSSHdjL3Z5NXkydDNsYlNOTy9DbGVSQ3Fu?=
 =?gb2312?B?VTd4ejdpcE93azN3ck1Rejh3KzhWci90NGxZQ2IzMmQ1SEFqTUo1K2xZR2pt?=
 =?gb2312?B?dEhsUzhkR0Vqa2VBVkw1ZmxHZzRUdFVqVXVhdTgwdHQ4WVR4Ymp2N1FvTi9K?=
 =?gb2312?B?R1g3REIzUXFtSTZ5YndYdUpxT1BkM1NRdFVoRzdqZGc0T2tQTWdoMndOdVAy?=
 =?gb2312?B?Y3pXdUMxUy83OWJpRGhEbXZsRDJsQzE1VTdqb1VDTTNQWEc2UUkvUVBua2V4?=
 =?gb2312?B?c015aWVWYWcxTTdqajhPTURFN3pKMmhiWEdDQWJDZGgzc3J3bkk0L1R5YWRr?=
 =?gb2312?B?YWRjMGRZeXdUNU1nRWlJcEdkZ2trd2lVL0RkNm0wNWJsRW1icDV5ZVliQk5P?=
 =?gb2312?B?c0lLVmkyb0g4LzN1ZEgzcnBvWFFkbDVPazU4UXRUOFFuQW9hT0h5cnJGcUVU?=
 =?gb2312?B?SnMxOC9DblBLdEgvMVh4Skt2QU5FZHZRK2ducWxyRmhHRVVyN25xc081cUp5?=
 =?gb2312?B?TEQ5RlNTRWJFRll5Ni8wTWZzdlNoaHFJbTJNMkx5OHA1Z0RhUmdHaW55Zlph?=
 =?gb2312?B?cUxyN0xBRFViMzJhejFCV3pEL0p5dEVMSjFHV3Z3WXVoUFJJQWdQOFBOYklJ?=
 =?gb2312?B?MGpOUVpHSmFQUkJaZG13SS9uTFhHamtZMkhaRitESjQ2ak5yTkk4QkZIVVVw?=
 =?gb2312?B?eWYvbVJ1Tmt3eVFvYmFlMjR4T2p4MDVWUlI3TnpDTGh1WUhzS3A1RXBkYUds?=
 =?gb2312?B?Z3VUY3R6V2k1NElwSXlTYmlNYkRHV1MwSFkyOHdMZUxDYkRhdTBRbVkyY3hN?=
 =?gb2312?B?RUVwcDVZTHI3Wlh4M252cDY2b25ZN3VDRy9pUU1RQ3RjNktlam1ISjR4U0l2?=
 =?gb2312?B?S0NRUnJZY25JZ1N6NHB4ZGcwTjQ5VXRJTEZ1NGo3VzdxeUlVNmViWFZpMTFw?=
 =?gb2312?B?VnIvYkdiMVZrWlp2WXpwbnRrQzZsUU0yTlI0S1creExXR3dSYnB3Ung2cUtk?=
 =?gb2312?B?WXUyd3dpci85R05CTmRiZFNiTXlVOEFmcWNqTDN1Rkxjems4YVZEL1VxL0J0?=
 =?gb2312?B?MmFJRjc1Ly9nNTEvWDNQcDg4LzBaYjhHT0lNNWcyalZsbTI3cXVRZ3dpcElw?=
 =?gb2312?B?cW9SSmtRdUV6NUkvbVRCdHpIcmVuNEphTVJiT2crWHJ2Zmtra1FOemlPUjFt?=
 =?gb2312?B?UXRHMUdOb20vdFBSc1R5dlBNZFBnYmMwR0pmUktxZCtETjRoWEh0bGRJbTM0?=
 =?gb2312?B?MjZrbFdWK1pQSHFIN3RubmZVcWNzc1RwL3hBaXNqZkx1dkdEM21FZHF0R3pS?=
 =?gb2312?B?TmJHRW1HNjRtSWNlMENLb3BuVVUzUUc1czYrTkF2dkJEdzlqV3RjOWNoVHFs?=
 =?gb2312?B?Q21GbUdXN1hUdWJTMVZlVlByQzNNcEdoK0dlOHQrR2hBKzVhQmZVdG5kdHFv?=
 =?gb2312?B?aWxZdkVab3ZDMGtyWlhwenVUcG1CaCtVc3dOK0JBemNrU1JHcTd1MCtrM1M1?=
 =?gb2312?B?cUlxaXpLRjdzVE5TT3d2WGM0L2t3SmtRYjBIMnMxMTBNWitaMmJlbFJBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8677.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?bytoRnJ3R2xtYzJSUHFrWEs2V25XUUhCRlhaSVhWbzc3Sk1pSkJoT2dWSGtj?=
 =?gb2312?B?UjhveXZsWHlvN2Z1YU0zL0xkSVh1L2QycjVKTWg4RC9jQlgwRmVKZVJUMWZQ?=
 =?gb2312?B?emdlNG1XU2phVEhJWkNPT3g1TEE5ZzFRMm1JaHlVNkk1Rjg3bDR5VncvUmFz?=
 =?gb2312?B?ZGU4c2JDVnM0czRPbC9OTWphaWpKNFZYM0RCeVkvbnVnd0VLUHNGUTRvRVh5?=
 =?gb2312?B?enZQNmpzblMyMXpYdTJDSXZkTVVqcjFVV2JFajlVb0pOZ0xCOVoxK2lsUHlY?=
 =?gb2312?B?QkdaQWVFSWRBWUMxOC9YeFRKbnNRQWdvd1JzbEFxYmdxTU8rb0g3TWxzYlJw?=
 =?gb2312?B?WHF4QW1WVUd6T216VFkzNHM5MUFOSHMyS0g3clRRbGRmajcxMDhWK242V2dT?=
 =?gb2312?B?ZktmL2swdllhMWVCTmNkZkhQMkVZNlJFamdQOU83cVd3a2Q2Smd6eVlhMWtB?=
 =?gb2312?B?QVNGZzZ0dzlMenRWOS9RRTRwVkRNWnIwUE9rLysreXNGTGlncXBiczBESXNh?=
 =?gb2312?B?WS92amhqdmh1ZGpaTWNYRGJ6ZHB5dkgwNVEzT1ltUTdaVWU5RHI3blBKVldp?=
 =?gb2312?B?ZmozdmNCVks1ME5raGNwOHhQK0FqN3VMNXJqVEQwNlVHaEo5dHRyOVI4Y3hQ?=
 =?gb2312?B?ZVNMSlpJeEJhYVJGK0wwTHoyVHUzK3BoMjh4UlgxL3VRbm9rZTZKc25WY3A2?=
 =?gb2312?B?OFRKRUxaeVVsQUFsSlZ6SDB6Z0hzK2VOdHA4Q2NVTVNoN3ZWSkxhUHgySWNN?=
 =?gb2312?B?TitZbmNTek1zYWFwaDZ5NjBzY3M5RlRwR0NUWG9YZjBuQUhQQWJkOTV2VXZm?=
 =?gb2312?B?b2dJVmsyZWZCWjdwTERRWlNadWxmNFpCWm9sRWE2ZE5iRCs2OUs0eWlwa3JR?=
 =?gb2312?B?OHZjM1lVWklkTzl2ZFFqNGh5NnVCbW9QNFY3ZG52dXFmckVUaTF5MXJrNE9u?=
 =?gb2312?B?YnFIaE5oMkJwMzN6Sk9ZVnZiMGloZEFYUks0cndxajE1a3ViR0drTWVLWFNE?=
 =?gb2312?B?SVFObHpwSlBBMzViLzNNaUZoUVo3V3NZVnJhb01rV3QrbGg2aHhQVnJwY28w?=
 =?gb2312?B?RjhKZTRjVkNxT09IcllsT1V2Mng3aFhYdVBoeHJnOHNmMzNyUGwyOGRrekc0?=
 =?gb2312?B?cnVsMGRrNVhiVjYrSmk3U0tpM0NydUtuNVpRRFJtOGZPTnFkbHByVGF1VjNm?=
 =?gb2312?B?dFdxNno1alhrOUU4R0FLSjgySnZOcHNhL00xY3h1cEhvYXZOUFRJM3MyK25n?=
 =?gb2312?B?eG1Xbk9IekJ3RUZuVzNvOFpmYW5POUFmaEhmSnBhWVlmeHErOTM1Ty9ZRHNh?=
 =?gb2312?B?UHBXQTRnZG9pWTdMeXdBNmxWb1Y2ODlLU1ZhODZzMHJEQW9QbVFBU3I4RDBJ?=
 =?gb2312?B?WkhiOE42cVdESzBJU0R0U05LbGRPUnFtTTBjc0txZFJGUnEvSWZxeGlXNWhz?=
 =?gb2312?B?VnRVTmZJM2hEZHc1RFJkUXBIcDhuOENEZVh6azc1M1lqck0wR0pqYXZHVktF?=
 =?gb2312?B?QXVwOEtaVXhsWmgyV3RoSk5mTW80blNsRUlxR3RqTElEbmxtL2ppUzhrbkhs?=
 =?gb2312?B?S2NpRzAwTGMvYUhsa0c2cXcwREYza1BCMFdNWjl3eFJMTkVvUldJS2pNNTdF?=
 =?gb2312?B?RjI5M29TalBLSTA3amQ1YjJ5dzRGMVBnT2tZTXNCOTA3M080WlRxQktGc0E2?=
 =?gb2312?B?Q0VPRmNRcCtXSXMvQnd3bWx6RDUyUGlBNWhjVlduNlVzRmxZOCt1WFI4eXRT?=
 =?gb2312?B?K3lzT3pCVHNVbk1ka3d0MmNMM1BWcXl1TDRHbytldEQ5TGljdU8wVDVrSmRa?=
 =?gb2312?B?RDUycmFQOVN2UTBlaXVMbUJkeHhoaWgxWUg5RXNGdnpGUnF6RWk2dXlUYSsr?=
 =?gb2312?B?OTJyb0lqcEswVmhjbFhTUW1qZldtOTFvUUVzNm80SkhObUFQd3ViczFzWG5E?=
 =?gb2312?B?aVpYcml5L3QrdlZsdmkraHEvcXRWSWlkUGtyNTNCQ0EzRWpaNXpmSXJOYmFa?=
 =?gb2312?B?anJGS0pGOTJ0RitwYURCOFB0enFOTVRvK3RWWUtXcG1JMkFmb3dsYnVvdkRq?=
 =?gb2312?B?Rlh0OUFJQkFIN0RlWTBmbnFVYnp5NGxXbHdaTHRPMTJNSnRWaTJMUjZOamJv?=
 =?gb2312?Q?N4ikUSzhuKMo0cLVxNTtITDEg?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8677.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33bb6654-c57f-41c7-12d4-08dcdd13b5c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2024 03:39:50.3635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kPdiGh4R2LrTFWN5zrTR06uT4rn6GzuU4lBdWd+/iOqy/p1DypO9D76tReq7GJLRr//xJ8QH3agVFwn2UJRMLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8796

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBIb25neGluZyBaaHUNCj4gU2Vu
dDogMjAyNMTqOdTCOcjVIDk6NDQNCj4gVG86IFNoYXduIEd1byA8c2hhd25ndW8yQHllYWgubmV0
Pg0KPiBDYzogcm9iaEBrZXJuZWwub3JnOyBrcnprK2R0QGtlcm5lbC5vcmc7IGNvbm9yK2R0QGtl
cm5lbC5vcmc7DQo+IHNoYXduZ3VvQGtlcm5lbC5vcmc7IGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU7
IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgaW14QGxpc3RzLmxpbnV4LmRl
dg0KPiBTdWJqZWN0OiBSRTogW1BBVENIIHY1IDAvNF0gQWRkIGRiaTIgYW5kIGF0dSBmb3IgaS5N
WDhNIFBDSWUgRVANCj4NCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206
IFNoYXduIEd1byA8c2hhd25ndW8yQHllYWgubmV0Pg0KPiA+IFNlbnQ6IDIwMjTE6jnUwjTI1SAx
NzozOQ0KPiA+IFRvOiBIb25neGluZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiA+IENj
OiByb2JoQGtlcm5lbC5vcmc7IGtyemsrZHRAa2VybmVsLm9yZzsgY29ub3IrZHRAa2VybmVsLm9y
ZzsNCj4gPiBzaGF3bmd1b0BrZXJuZWwub3JnOyBsLnN0YWNoQHBlbmd1dHJvbml4LmRlOw0KPiA+
IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOw0K
PiA+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gPiBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7DQo+ID4gaW14QGxpc3Rz
LmxpbnV4LmRldg0KPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMC80XSBBZGQgZGJpMiBhbmQg
YXR1IGZvciBpLk1YOE0gUENJZSBFUA0KPiA+DQo+ID4gT24gU2F0LCBBdWcgMzEsIDIwMjQgYXQg
MDk6MDI6MzhQTSArMDgwMCwgU2hhd24gR3VvIHdyb3RlOg0KPiA+ID4gT24gVHVlLCBBdWcgMTMs
IDIwMjQgYXQgMDM6NDI6MTlQTSArMDgwMCwgUmljaGFyZCBaaHUgd3JvdGU6DQo+ID4gPiA+IHY1
IGNoYW5nZXM6DQo+ID4gPiA+IC0gQ29ycmVjdCBzdWJqZWN0IHByZWZpeC4NCj4gPiA+ID4NCj4g
PiA+ID4gdjQgY2hhbmdlczoNCj4gPiA+ID4gLSBBZGQgRnJhbmsncyByZXZpZXdlZCB0YWcsIGFu
ZCByZS1mb3JtYXQgdGhlIGNvbW1pdCBtZXNzYWdlLg0KPiA+ID4gPg0KPiA+ID4gPiB2MyBjaGFu
Z2VzOg0KPiA+ID4gPiAtIFJlZmluZSB0aGUgY29tbWl0IGRlc2NyaXB0aW9ucy4NCj4gPiA+ID4N
Cj4gPiA+ID4gdjIgY2hhbmdlczoNCj4gPiA+ID4gVGhhbmtzIGZvciBDb25vcidzIGNvbW1lbnRz
Lg0KPiA+ID4gPiAtIFBsYWNlIHRoZSBuZXcgYWRkZWQgcHJvcGVydGllcyBhdCB0aGUgZW5kLg0K
PiA+ID4gPg0KPiA+ID4gPiBJZGVhbGx5LCBkYmkyIGFuZCBhdHUgYmFzZSBhZGRyZXNzZXMgc2hv
dWxkIGJlIGZldGNoZWQgZnJvbSBEVC4NCj4gPiA+ID4gQWRkIGRiaTIgYW5kIGF0dSBiYXNlIGFk
ZHJlc3NlcyBmb3IgaS5NWDhNIFBDSWUgRVAgaGVyZS4NCj4gPiA+ID4NCj4gPiA+ID4gW1BBVENI
IHY1IDEvNF0gZHQtYmluZGluZ3M6IGlteDZxLXBjaWU6IEFkZCByZWctbmFtZSAiZGJpMiIgYW5k
ICJhdHUiDQo+ID4gPiA+IFtQQVRDSCB2NSAyLzRdIGFybTY0OiBkdHM6IGlteDhtcTogQWRkIGRi
aTIgYW5kIGF0dSByZWcgZm9yDQo+ID4gPiA+IGkuTVg4TVEgW1BBVENIIHY1IDMvNF0gYXJtNjQ6
IGR0czogaW14OG1wOiBBZGQgZGJpMiBhbmQgYXR1IHJlZw0KPiA+ID4gPiBmb3IgaS5NWDhNUCBb
UEFUQ0ggdjUgNC80XSBhcm02NDogZHRzOiBpbXg4bW06IEFkZCBkYmkyIGFuZCBhdHUNCj4gPiA+
ID4gcmVnIGZvciBpLk1YOE1NDQo+ID4gPg0KPiA+ID4gQXBwbGllZCAzIERUUyBwYXRjaGVzLCB0
aGFua3MhDQo+ID4NCj4gPiBJIGhhdmUgdG8gdGFrZSB0aGVtIG91dCBmcm9tIG15IGJyYW5jaCBm
b3Igbm93LiAgUGluZyBtZSB3aGVuIGJpbmRpbmdzDQo+ID4gY2hhbmdlIGdldHMgYXBwbGllZC4N
Cj4NCj4gSGkgU2hhd246DQo+IFRoZSBkdHMgYmluZGluZ3MgY2hhbmdlIGhhZCBiZWVuIG1lcmdl
ZCBieSBLcnp5c3p0b2YgV2lsY3p5qL1za2kuDQo+IENhbiB5b3UgaGVscCB0byBtZXJnZSB0aGUg
b3RoZXJzPw0KPiBUaGFua3MgaW4gYWR2YW5jZWQuDQo+DQo+IFsxLzFdIGR0LWJpbmRpbmdzOiBQ
Q0k6IGlteDZxLXBjaWU6IEFkZCByZWctbmFtZSAiZGJpMiIgYW5kICJhdHUiIGZvciBpLk1YOE0N
Cj4gUENJZSBFbmRwb2ludA0KPg0KPiBodHRwczovL2dpdC5rZXJuZWwvDQo+IC5vcmclMkZwY2kl
MkZwY2klMkZjJTJGMmYzMDljOTg4YjdjJmRhdGE9MDUlN0MwMiU3Q2hvbmd4aW5nLnpodSU0DQo+
IDBueHAuY29tJTdDYzNkNjdkNDI0MDIwNGQ3M2YyMGEwOGRjY2UzZDgxZGMlN0M2ODZlYTFkM2Jj
MmI0YzZmYTkyDQo+IGNkOTljNWMzMDE2MzUlN0MwJTdDMCU3QzYzODYxMjAxMDc4OTA1MTIwMyU3
Q1Vua25vd24lN0NUV0ZwYg0KPiBHWnNiM2Q4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYy
bHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TQ0KPiBuMCUzRCU3QzAlN0MlN0MlN0Mmc2Rh
dGE9T1FJd2tad0pRV0RvOVloVkhib1NFa1VJeVZkS1MwVUxHcnoNCj4gZEpIMllHRWMlM0QmcmVz
ZXJ2ZWQ9MA0KDQpIaSBTaGF3bjoNClBpbmcuDQoNCkJlc3QgUmVnYXJkcw0KUmljaGFyZCBaaHUN
Cg0KPg0KPiBCZXN0IFJlZ2FyZHMNCj4gUmljaGFyZCBaaHUNCj4gPg0KPiA+IFNoYXduDQoNCg==

