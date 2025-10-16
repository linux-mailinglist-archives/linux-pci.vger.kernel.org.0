Return-Path: <linux-pci+bounces-38298-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07260BE1CC3
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 08:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F73919A39D5
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 06:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1342F1FE8;
	Thu, 16 Oct 2025 06:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Xx92apqP"
X-Original-To: linux-pci@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011035.outbound.protection.outlook.com [40.107.130.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BFB2EDD49;
	Thu, 16 Oct 2025 06:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760597193; cv=fail; b=mIwO9GOEAAKOTkjfLmyCZ0WWLCN3oI1GUSORas25sRVlZTwO/sHcchHzz6sMfli3+qCyRap2u/sd01VDQ62l8UqltVI0EbPhGFbr/dpIu4gBlZCcPHraGB6pWSBETd87HMwZ3PaEte88xwVOfq8GVA2JYA260FXg0oGfOnsajjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760597193; c=relaxed/simple;
	bh=5Iy1jHUAff1eFhXD71bVLTOix/9yA2IEnGiVgP95GuE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ARnZGEX24tqtQ0xKTrSCuYSXR7To/tWLvhcsVeaO+uAVWKkW6FDqg8sc4eXMWnW4U095AMmsoVhNAP1MNQRiZPWJlVuuqAOpS58E+7fo06MERG5IVDhB7bSXqBkch/F0bRxUdqikNi/OSi3eRbQP3yrCZzOI4WhsXJYoly0tGc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Xx92apqP; arc=fail smtp.client-ip=40.107.130.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TZjwQAtnMJqJ4NGxQwacCNp5SCbQKTqLoaTwPWG+2ULMObPAx1ZfhGZKCxy2Luh1lnXcDVKbKLV+7Bxy3fAvNZhJB8mqMr6e72s0+gul5fUCjw8SGG+2Nn8wQIF/T64HUd5rwemxvxWWZD+oH8CG19uSdkM2u+04RIhyZlzdEQe7wpfwqOf4mcEWi63Yx56EwBXO+uh/mIXCULihm4/MDSgJ6oZvVQSIhCvorvfV+Padwc34EjbTgK6oXTpaj55AsYM3aJj9MLYSTzU1sEx5BzrqDUkRDeUJyD7vfEKNJzazDRbnULnEOPZ5BIQ03oQBfulEPGWlX0atCe4980YSHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Iy1jHUAff1eFhXD71bVLTOix/9yA2IEnGiVgP95GuE=;
 b=F4dFEwGHqcXvE7mEOQO9EAq1SrTZuz2NXMNQEOCA0tMKVEzQxVO5BvLadV8XFQ+dl4iueJaNDu6cSQZvBrS1h/SHVeSZa2B7gxhsa8BMnvAnSPNQuUy9u33A6Cy1DKKJnjawMAOZqV+hUjBr/zmOYnBJncYfj9QkHODRJC1qoCBkMlW2FT6B3Ds2Bum7xNE7w/fIgkjhquurC/JWB1i97B1eRiel7ep9k9YsClCUCbZyo3h9AxH9yBFyTsnZj68vHHoJsnLmPKmKlDACaOaZrjhuKNbjfa8kLrrlx84NrEoMNgcUF5K9RTm2CUwYuSoTTD3vfz+SrhnczSZSAC3Zbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Iy1jHUAff1eFhXD71bVLTOix/9yA2IEnGiVgP95GuE=;
 b=Xx92apqPJKk07m+ShPLLau2zPuZlc2TMHLecg3BuQ5jh6odtQHXy/YR41DV7+oYpXpj+uqjcGtG/wN3bgaXh15uDytlRgTm/V4Jqs4/7OPRuMxHu3UG1oKEWS+VlRzDm+B/LRS0o5BbIE87/HMzNVKe8DpWaSOhGBYt2NSnzXKIvqznhbZjZEaI7kzysCA41HZccSW9w2dfk5mi39KIih674AGBivbjsIePkniRftfhGfjMzX8WzX3nC9l4S/s3aspbohceAVMoedlDnJdZ2Jk4aG/dr81wnJWHx6c18XfJ1AIIDuSmVNujcgQeEEI9cqOnrF+SBZfCkTJ5CJZlPUg==
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by PAXPR04MB8783.eurprd04.prod.outlook.com (2603:10a6:102:20e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 06:46:26 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%3]) with mapi id 15.20.9228.012; Thu, 16 Oct 2025
 06:46:26 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>
CC: Niklas Cassel <cassel@kernel.org>, Manivannan Sadhasivam
	<mani@kernel.org>, "manivannan.sadhasivam@oss.qualcomm.com"
	<manivannan.sadhasivam@oss.qualcomm.com>, Bjorn Helgaas
	<bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?gb2312?B?S3J6eXN6dG9mIFdpbGN6eai9c2tp?= <kwilczynski@kernel.org>, Rob
 Herring <robh@kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org"
	<linux-arm-msm@vger.kernel.org>, "David E. Box"
	<david.e.box@linux.intel.com>, Kai-Heng Feng <kai.heng.feng@canonical.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Heiner Kallweit
	<hkallweit1@gmail.com>, Chia-Lin Kao <acelan.kao@canonical.com>, Dragan Simic
	<dsimic@manjaro.org>, "linux-rockchip@lists.infradead.org"
	<linux-rockchip@lists.infradead.org>, "regressions@lists.linux.dev"
	<regressions@lists.linux.dev>, FUKAUMI Naoki <naoki@radxa.com>
Subject: RE: [PATCH v2 1/2] PCI/ASPM: Override the ASPM and Clock PM states
 set by BIOS for devicetree platforms
Thread-Topic: [PATCH v2 1/2] PCI/ASPM: Override the ASPM and Clock PM states
 set by BIOS for devicetree platforms
Thread-Index:
 AQHcK9xhxzimniyQpkSoQgPdMNpXP7TB9+wAgAAmyYCAAMLmgIAADSSAgAAKOoCAABa7gIAACZwAgAANXoCAABz3gIAADA2AgACwFQCAAHVIAA==
Date: Thu, 16 Oct 2025 06:46:26 +0000
Message-ID:
 <AS8PR04MB8833D3C0BF9A55BCE28A96428CE9A@AS8PR04MB8833.eurprd04.prod.outlook.com>
References: <7df0bf91-8ab1-4e76-83fa-841a4059c634@rock-chips.com>
 <20251015233054.GA961172@bhelgaas>
In-Reply-To: <20251015233054.GA961172@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8833:EE_|PAXPR04MB8783:EE_
x-ms-office365-filtering-correlation-id: c63441d8-6797-41e8-7609-08de0c7fbabc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|376014|7416014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?gb2312?B?c3l0c1pFMGhvRHNzODR2ZS9IdmhwU1dtVFNpUERleFk1cGhyQkFjMHNwVUxv?=
 =?gb2312?B?ZVVpL3NJaGhldzIydmhNcmhJcFRlUFQ4d3FhQnJGeEozVGxTT2VKSmtDd1V0?=
 =?gb2312?B?aHU3TTgzSG85Ti82U2dLNmNIL01VeHF2eWg3L0EwNUcrenIzbzdHN0pvRUsv?=
 =?gb2312?B?OFlyM0d2ZWVTcFg0MXRPR09EUmZLY2xWQUd0dEhKeFhFcGJoYTZRSzJLVlhq?=
 =?gb2312?B?SUFjQ0d0Q2JpZTd3RkJPVUwvTVExczUzcUM2THUzMEx6Ylo0aWxoRzZxVVFu?=
 =?gb2312?B?elUvN3hqeWlFVDZ3L3JCRkV4WWxrL2pmWlJwYWo4QjBWdjlhRUFxWms0dHhV?=
 =?gb2312?B?aVR0SmE1YVpYbGZBQVNPVTBDMFRrNW5qN3VCeXdaRXhYRVNTalN3QzZEdjBE?=
 =?gb2312?B?Y1ppQnFHR09KMkpOakkvRXplblUrOGluTkoxTEQ0MURZTTZjUVRGMyt6U3I1?=
 =?gb2312?B?NW1MQXk5Y05RSmZyTisxREJtVWpwRjFObHJWVDAyL3JIOVhhbXRwMTFGeTRD?=
 =?gb2312?B?Ni80RXZRdmlNN0x4UlVNQS9hZW1xQmtiNmRWM0padWtGSnl2MS9mZGJKWUd1?=
 =?gb2312?B?K1NKTlFmZGsrOHJlTUswNWlRbWk4bEJsZS9WdzFnQUltUVU3Y3M5eUoyMEgx?=
 =?gb2312?B?cVcyaHEycG1EQjQrUjhYWG5PY2pZaGhlSjVhN1hxRHBJeFpLT1U2L3ZaZ0xN?=
 =?gb2312?B?ZjB1RWpYT1NROTNXNlZUbDBYMWMzcWdaSFVUSDlnMTVGaEFySjV1Skh4cDR6?=
 =?gb2312?B?b1FTbFBiUWVKRERvREhDeWp0L1A5NE9iZElDOU95Y2V3SlI1Rmo0dllyLzRO?=
 =?gb2312?B?N24rOFkvT1pkelplZXo4OW01dkNPeVcxaTFUdjNjRFpuUDZnc3VvQ1NwWlo5?=
 =?gb2312?B?TW96cVJhWGFQZVJvK1Rxb2V2VXRIay8vSVZYd3YzOUY5eTFFQUR4RG9Fc0R5?=
 =?gb2312?B?NWpqbks1R2Y1Q3U3bXlRRFJSczFuRWJIVGNTY0lYL0pkVFN6ZkhyYW5iUlEz?=
 =?gb2312?B?bTdtd0QrQUlJZXNRQ1RaK3cyQnpVTlp1VFFmY1ZXNXpWYXlMeWt6QlNlSWNG?=
 =?gb2312?B?UW5zbzhuM2lXaDhIVG4xcjV4MDlBckRlT1ptbTgzN0FGUWVmdk1qQUZuaFJC?=
 =?gb2312?B?bWpZTzdFNTNkQTYrOW93eTFKTU02TnFxR2ppRG1qTEFNSkhwTHVCK0VpOUEz?=
 =?gb2312?B?UXNscDR3eXl6L0todGMxamhORzU2ZkVQWTRzcW84UWtJMVdBWkRpN3FweG5L?=
 =?gb2312?B?d01UbTUzOWpLVEVIampRVXozMFRTcmNLZGowdjNRS3lvZ0hURFFnMk1EV1J2?=
 =?gb2312?B?QytmMlJZQ2JxQksvZFNOeVRyY3JGQnJBdm1kYUp6N2IrUWltUUg5RmtSUlly?=
 =?gb2312?B?RmNlcDhiR2VxVGVSb1docDJXRUg4VytqeFVSOHpMbVI3dTlBS1FhSmphQVpu?=
 =?gb2312?B?VFBhTmxtaFFVa1U4K3NHL1llMG9vYjdhcjBhMzR6NmlmOThOTUNpSkRxV2s4?=
 =?gb2312?B?VWZSSnUyUUhQUmlhbHFZT3M5Umo0RFlxNkFDU00vcFZhVkxVbEg4bWxvK0hv?=
 =?gb2312?B?cmxvRkh1SFhzVzdpNnRCQVp0VkFsWU9ZZEFhajVBRmF1NFkzRXRVTWFDeC9F?=
 =?gb2312?B?Q0d4clc3OEtYbk5JNFR2SUI3b2VOaG5rZUJyVEdNUC9QNTFUaW51M2YrZG9L?=
 =?gb2312?B?Snh3MFdrWURibnAwNjN3Y0pGc3c2dGR1cE5tdG5QMzQ0dEl2Y1pxT3pPeUdM?=
 =?gb2312?B?SGdLMG1mRmVBelZuUEZPZCtxSVc2dXdTejRzS29HSW4vYlgwN0dvY3lmYll6?=
 =?gb2312?B?OGxXNE5qMUdiSVdQdUhISnN2aW1jcVhWd1Q0VkZvSVRycVpKQ0xSVE85dFJ2?=
 =?gb2312?B?eE9PcVExb1JKQS9mY3MrZ3FLQkhGZnU5QU1Xc1BTbnJWc1RqMXpidmJaZ2Jr?=
 =?gb2312?B?dHFRcC9CYm11N1FJT3F3ekdzUkJ0WDd4S3l3MW9rdG9jN2lDenBuMy9XcDJB?=
 =?gb2312?B?RU00SktBMDhXc2FqbHhKTXJBYWh1akNpS0JaekU3S0x4b29MRjNlYVQ4Zk83?=
 =?gb2312?Q?RyebPj?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(7416014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?RmpXekhlMTRYUXJSNHNZcW9ReFFKTXlGdDRPN1pKTEFKb1BhdkFDZS96THVh?=
 =?gb2312?B?SllXOHpnc25FRUt2OVpFajdFbnpYZjVrN2dHcHBzVEhleFdsUWdvcDJnejhL?=
 =?gb2312?B?YkFCUEVLTUVQd1pTbWZ4Yy96aTJXaGN2OFVuc0dxNmpDNjRXd2ducVdBUkVQ?=
 =?gb2312?B?bFR1aTRzN2FJRW5rVkpWRDloK0RCN1FrcFQ4a3Z1RnVSalJibHhXZmxFTmdu?=
 =?gb2312?B?MnFwVmV4S3VEcVhOY1k4T3hIYjVvSVVKWmwzMlJUU2VzZjVtT0p0b2RCTGgr?=
 =?gb2312?B?b2ZWRnBKYUxobmFQMzRKcllQQlpRV2QyZUlicXFwaUpzVE1DTmxYNVZjL0dD?=
 =?gb2312?B?aGZtN2JxbW8vWUdSMVpzZHBqUEdzNHFHLzFIekt2QW5WQTN1VUJwNzlKbnJR?=
 =?gb2312?B?UFBkTFY0OGxwYlFQM0ZHNGU0ODg1citRUDR4T2xtVlQrdFB2N2FQaFkxQ3V2?=
 =?gb2312?B?L1o3cVJkbVVzMlEwR3YrTHQvb0ZhM3dzSTBSV1JGVnJnNUhjWERwWjVibnBo?=
 =?gb2312?B?YklVdDRVY0FLRWJXbzh3cGthZ2wvVmtVVjU4SE0zcDc3djBZOWpjUGVtWDF3?=
 =?gb2312?B?U3IyNjA3Z0l2RlBUbzNkd2RiU3k4MEFmNDlrRDliMUxaSHg2RFZGNDJURFMy?=
 =?gb2312?B?dVlPU2ZCZDZEcktQOEVuL3c3bVFRSnhPNUkzTGxENkZaZkI0RDJ4OXJEV3E3?=
 =?gb2312?B?RGtrL0U1VjZySTNqNUJJa3lSeXlFclROcVRqSEx1RTgrcXQ2aFREdHE5N2w5?=
 =?gb2312?B?Mngrc00xV1pSVUVwMWg4dll6ZzZOQ0VRS05kek9VOHBaSXk0dld6YWNaVkJQ?=
 =?gb2312?B?dkUyNHVTbzg0K1hBTzBTYUl0VDlnNjZ3SnUvMkNmcmRnMysxb0pwOFRjMmtr?=
 =?gb2312?B?ZWttV1NMU0RnWEtyTXJJVGhIZUJkVkNNeDFNZDRuY2ZCcTFkTVRDenQzaG5J?=
 =?gb2312?B?ZzU4eUVpK3BuSnVQM3dVNmRmUGw3U1BxaEh4WnRJa2lLVm9mTW40WGNsNExB?=
 =?gb2312?B?dnhKNm1mNk4wNjE0NEdHSCtOSHV5L0crN1pLb05OUUNLUitpdkNFdHcvTUph?=
 =?gb2312?B?NHBmdnppb1V6YjhzM1Q5dGt6dlVCdnk2VGN0NDN5eVg0bERRQk12UGFPRS9q?=
 =?gb2312?B?YmkwK0pTb0dlTll0UVpnTFIrbzdsL1hSc2o4RjhFd2E2R0NaUmUvQmlzWkFF?=
 =?gb2312?B?ZWpKaC9NSHh4YnNFRzFyUEY1OUcwMDlkUWVtbkc0MFJFVjN5bkZWbCtIcHND?=
 =?gb2312?B?KzVmanpEc2Y2VEp2U1ZNSEd5OVdvSGlseFZRWmx2TVhtVENnNFdodkdHTTlu?=
 =?gb2312?B?RytyNkRIUFdseUl0UzM4bGNXc1Znc0IvVXhOMkI0TFRVL0IxWUxvd1QzZVVJ?=
 =?gb2312?B?eDVLVTRaaEoxYkRmaEI1TEJDT3hSNnovemN5Ni9jbUVKYXpjWnRHVkpxYnJw?=
 =?gb2312?B?RWhXdkk2eGVyMkdzcUw4ME5jZ201NnlPTU1nMGpTdFpGeHp6a21JRkNZRXBj?=
 =?gb2312?B?TTJjbm5iQ2d4MFhVd0psd0JHQ3ZvVUFRblE1TjlMbi9CZUVEZy8yUGduZ2t6?=
 =?gb2312?B?OUhuTlVnTjVwMGNYSVB2YUp0WFUweDE4bmQrSlczWFdZRlZKbC95K0ZMQU01?=
 =?gb2312?B?aThsY0NXWHkzYm1VKyt5R3VzUDV3aEI1S3N6dTJoQ05pb3pLNkJCS2k5N3Zm?=
 =?gb2312?B?ZFFFRW1PdVczZzhRTW9pYVVEb3pWc3NRM2cyQVZVTTVBYm1VVVhsUFNOVUhp?=
 =?gb2312?B?QlhYenBZUjdMclFYL01VN2dqS1YwMm8zaUFUYXhlVGhlWkpWZmVJSWo4RWlj?=
 =?gb2312?B?OE9HK3grc0c5Rk5UcUZ6M1JTRnR1eFRxVEZ2YzRRS1F0Vmp2OStYZ28zYU95?=
 =?gb2312?B?WFBZRU81YlJSK3pDNDdlaHliblBjTEtkQnZUVlBXSUpQdk1EWTBMNndoUU1V?=
 =?gb2312?B?bjNvSXZwZHl2YnJzVHZTSWxjYXhWSlh1d3dvZi92LzJxNEpPWlUzRDdtSi9C?=
 =?gb2312?B?NlB0b0k0UDBJUXlsVWw0RlZJcXJVZ09Wdnd6eEhnN0RZKzVUeE1FRlRXWU5x?=
 =?gb2312?B?TU1YNE5nZWVGaEh3TSttNnIvM0ljTlNGU3psZ2Qzdk1OMHZNQm02TUgyRlY4?=
 =?gb2312?Q?43aU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c63441d8-6797-41e8-7609-08de0c7fbabc
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2025 06:46:26.6282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n9xrvLrwcQf1AZPFtyV280DRGNqvQtyYDMkbyRTNEoJCiLwdqi0obFSujWw/gpMgJqH7VZapzGfU0BCgV/1k9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8783

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCam9ybiBIZWxnYWFzIDxoZWxn
YWFzQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjXE6jEw1MIxNsjVIDc6MzENCj4gVG86IFNoYXdu
IExpbiA8c2hhd24ubGluQHJvY2stY2hpcHMuY29tPg0KPiBDYzogTmlrbGFzIENhc3NlbCA8Y2Fz
c2VsQGtlcm5lbC5vcmc+OyBNYW5pdmFubmFuIFNhZGhhc2l2YW0NCj4gPG1hbmlAa2VybmVsLm9y
Zz47IG1hbml2YW5uYW4uc2FkaGFzaXZhbUBvc3MucXVhbGNvbW0uY29tOyBCam9ybg0KPiBIZWxn
YWFzIDxiaGVsZ2Fhc0Bnb29nbGUuY29tPjsgTG9yZW56byBQaWVyYWxpc2kgPGxwaWVyYWxpc2lA
a2VybmVsLm9yZz47DQo+IEtyenlzenRvZiBXaWxjenmovXNraSA8a3dpbGN6eW5za2lAa2VybmVs
Lm9yZz47IFJvYiBIZXJyaW5nDQo+IDxyb2JoQGtlcm5lbC5vcmc+OyBsaW51eC1wY2lAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1hcm0tbXNt
QHZnZXIua2VybmVsLm9yZzsgRGF2aWQgRS4gQm94IDxkYXZpZC5lLmJveEBsaW51eC5pbnRlbC5j
b20+Ow0KPiBLYWktSGVuZyBGZW5nIDxrYWkuaGVuZy5mZW5nQGNhbm9uaWNhbC5jb20+OyBSYWZh
ZWwgSi4gV3lzb2NraQ0KPiA8cmFmYWVsQGtlcm5lbC5vcmc+OyBIZWluZXIgS2FsbHdlaXQgPGhr
YWxsd2VpdDFAZ21haWwuY29tPjsgQ2hpYS1MaW4gS2FvDQo+IDxhY2VsYW4ua2FvQGNhbm9uaWNh
bC5jb20+OyBEcmFnYW4gU2ltaWMgPGRzaW1pY0BtYW5qYXJvLm9yZz47DQo+IGxpbnV4LXJvY2tj
aGlwQGxpc3RzLmluZnJhZGVhZC5vcmc7IHJlZ3Jlc3Npb25zQGxpc3RzLmxpbnV4LmRldjsgRlVL
QVVNSSBOYW9raQ0KPiA8bmFva2lAcmFkeGEuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYy
IDEvMl0gUENJL0FTUE06IE92ZXJyaWRlIHRoZSBBU1BNIGFuZCBDbG9jayBQTSBzdGF0ZXMNCj4g
c2V0IGJ5IEJJT1MgZm9yIGRldmljZXRyZWUgcGxhdGZvcm1zDQo+IA0KPiBPbiBXZWQsIE9jdCAx
NSwgMjAyNSBhdCAwOTowMDo0MVBNICswODAwLCBTaGF3biBMaW4gd3JvdGU6DQo+ID4gLi4uDQo+
IA0KPiA+IEZvciBub3csIHRoaXMgaXMgYSBhY2NlcHRhYmxlIG9wdGlvbiBpZiBkZWZhdWx0IEFT
UE0gcG9saWN5IGVuYWJsZQ0KPiA+IEwxc3Mgdy9vIGNoZWNraW5nIGlmIHRoZSBIVyBjb3VsZCBz
dXBwb3J0cyBpdC4uLiBCdXQgaG93IGFib3V0IGFkZGluZw0KPiA+IHN1cHBvcnRzLWNsa3JlcSBz
dHVmZiB0byB1cHN0cmVhbSBob3N0IGRyaXZlciBkaXJlY3RseT8gVGhhdCB3b3VsZA0KPiA+IGhl
bHAgZm9sa3MgZW5hYmxlIEwxc3MgaWYgdGhlIEhXIGlzIHJlYWR5IGFuZCB0aGV5IGp1c3QgbmVl
ZCBhZGRpbmcNCj4gPiBwcm9wZXJ0eSB0byB0aGUgRFQuDQo+ID4gLi4uDQo+IA0KPiA+IFRoZSBM
MXNzIHN1cHBvcnQgaXMgcXVpdGUgc3RyaWN0IGFuZCBuZWVkIHNldmVyYWwgc3RlcHMgdG8gY2hl
Y2ssIHNvDQo+ID4gd2UgZGlkbid0IGFkZCBzdXBwb3J0cy1jbGtyZXEgZm9yIHRoZW0gdW5sZXNz
IHRoZSBIVyBpcyByZWFkeSB0byBnby4uLg0KPiA+DQo+ID4gRm9yIGFkZGluZyBzdXBwb3J0cyBv
ZiBMMXNzLA0KPiA+IFsxXSB0aGUgSFcgc2hvdWxkIHN1cHBvcnQgQ0xLUkVRIywgZXhwZWNpYWxs
eSBmb3IgUENJZTMuMCBjYXNlIG9uDQo+ID4gUm9ja2NoaXAgU29DcyAsIHNpbmNlIGJvdGggIENM
S1JFUSMgb2YgUkMgYW5kIEVQIHNob3VsZCBjb25uZWN0IHRvIHRoZQ0KPiA+IDEwME1IeiBjcnlz
dGFsIGdlbmVyYXRvcidzIGVuYWJsZSBwaW4sIGFzIEwxLjIgbmVlZCB0byBkaXNhYmxlIHJlZmNs
aw0KPiA+IGFzIHdlbGwuIElmIHRoZSBlbmFibGUgcGluIGlzIGhpZ2ggYWN0aXZlLCB0aGUgSFcg
ZXZlbiBuZWVkIGEgaW52ZXJ0b3IuLi4uDQo+ID4NCj4gPiBbMl0gZGVmaW5lIHByb3BlciBjbGty
ZXEgaW9tdXggdG8gcGluY3RybCBvZiBwY2llIG5vZGUgWzNdIG1ha2Ugc3VyZQ0KPiA+IHRoZSBk
ZXZpY2VzIHdvcmsgZmluZSB3aXRoIEwxc3MuKEl0J3MgaGFyZCB0byBjaGVjayB0aGUgc2xvdCBj
YXNlIHdpdGgNCj4gPiByYW5kb20gZGV2aWNlcyBpbiB0aGUgd2lsZCApIFs0XSBhZGQgc3VwcG9y
dHMtY2xrcmVxIHRvIHRoZSBEVCBhbmQNCj4gPiBlbmFibGUgQ09ORklHX1BDSUVBU1BNX1BPV0VS
X1NVUEVSU0FWRQ0KPiANCj4gSSBkb24ndCB1bmRlcnN0YW5kIHRoZSBkZXRhaWxzIG9mIHRoZSBz
dXBwb3J0cy1jbGtyZXEgaXNzdWUuDQo+IA0KPiBJZiB3ZSBuZWVkIHRvIGFkZCBzdXBwb3J0cy1j
bGtyZXEgdG8gZGV2aWNldHJlZSwgSSB3YW50IHRvIHVuZGVyc3RhbmQgd2h5IHdlDQo+IG5lZWQg
aXQgdGhlcmUgd2hlbiB3ZSBkb24ndCBzZWVtIHRvIG5lZWQgaXQgZm9yIEFDUEkgc3lzdGVtcy4N
Cj4gDQo+IEdlbmVyYWxseSB0aGUgT1MgcmVsaWVzIG9uIHdoYXQgdGhlIGhhcmR3YXJlIGFkdmVy
dGlzZXMsIGUuZy4sIGluIExpbmsNCj4gQ2FwYWJpbGl0aWVzIGFuZCB0aGUgTDEgUE0gU3Vic3Rh
dGVzIENhcGFiaWxpdHksIGFuZCB3aGF0IGlzIGF2YWlsYWJsZSBmcm9tDQo+IGZpcm13YXJlLCBl
LmcuLCB0aGUgQUNQSSBfRFNNIGZvciBMYXRlbmN5IFRvbGVyYW5jZSBSZXBvcnRpbmcuDQpIaSBC
am9ybjoNClllcywgaXQgaXMuIFRoZSBMMSBQTSBTdWJzdGF0ZXMgc3VwcG9ydCBjYW4gYmUgYnJv
YWRjYXN0ZWQgYnkgdGhlIGFjY29yZGluZw0KIENhcGFiaWxpdGllcyBvZiBQQ0llIGNvbnRyb2xs
ZXIuDQpCdXQsIHRoaXMgZmVhdHVyZSBpcyBzdGlsbCByZWxpZWQgb24gdGhlIENMS1JFUSMgc2ln
bmFsIGNvbm5lY3Rpb24gb24gdGhlDQogYm9hcmQvZGV2aWNlIGhhcmR3YXJlIGRlc2lnbnMgdG9v
Lg0KTWF5YmUgdGhlICJzdXBwb3J0cy1jbGtyZXEiIHByb3BlcnR5IGlzIHVzZWQgdG8gZ3VhcmFu
dGVlIHRoYXQgdGhlIGhhcmR3YXJlDQogZGVzaWducyBvZiBDTEtSRVEjIG9uIGJvYXJkL2Rldmlj
ZSBtZWV0IHRoZSByZXF1aXJlbWVudHMgb2YgTDEgUE0gU3Vic3RhdGVzLg0KDQpodHRwczovL2xv
cmUua2VybmVsLm9yZy9pbXgvMjAyNTEwMTUwMzA0MjguMjk4MDQyNy0xLWhvbmd4aW5nLnpodUBu
eHAuY29tLw0KVGhpcyBpcyB0aGUgamFtIEkgZW5jb3VudGVyZWQsIGVzcGVjaWFsbHkgb24gdGhl
IHNlY29uZCBzbG90IG9mIGkuTVg5NQ0KIDE5eDE5IEVWSyBib2FyZC4NCg0KQmVzdCBSZWdhcmRz
DQpSaWNoYXJkIFpodQ0KPiANCj4gT24gdGhlIEFDUEkgc2lkZSwgSSBkb24ndCB0aGluayB3ZSBn
ZXQgYW55IHNwZWNpZmljIGluZm9ybWF0aW9uIGFib3V0IENMS1JFUSMuDQo+IENhbiBzb21lYm9k
eSBleHBsYWluIHdoeSB3ZSBkbyBuZWVkIGl0IG9uIHRoZSBkZXZpY2V0cmVlIHNpZGU/DQo+IA0K
PiBCam9ybg0KDQo=

