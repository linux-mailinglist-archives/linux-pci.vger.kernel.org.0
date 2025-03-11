Return-Path: <linux-pci+bounces-23396-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 496E6A5B59B
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 02:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E756D3AAEE6
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 01:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05141DE4C5;
	Tue, 11 Mar 2025 01:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iQt3pdQ5"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011011.outbound.protection.outlook.com [52.101.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECDF4207F;
	Tue, 11 Mar 2025 01:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741655471; cv=fail; b=bCrcnhNeVS8w366iGnA4B0VVxpMuffF3TdUNxIYXouxU+Rro+GwNHwDahN8RqdLkv4swUc1C40nfwmF7Ts4sRQR9PFyLIhR271gWpEMzhNUOvKYND4N/XV1jQVK7kH5nob5RVgeJj1382FRWUj4FPVQTxZdiTpQ9nRENr3u7Ft4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741655471; c=relaxed/simple;
	bh=DmFB/cvotzcff+byXAI9FYlCaqMWfYuUZSJqCHphTQk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eG5GlLl85RjocbDVMNVb3VbjLmxmiAwCJyPIt2CwGFf2IsyZ+Ff68456h5//6wf2iVjX9c6jY6LS6L5SMjmCB/GRWAvdbtC4ltpqdsWLhFC1yHPfVcQY/mbh2ZnN6XdadlLR4JOgC8495k8WyU1OUshiGekIW30iHD8mxDLwZwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iQt3pdQ5; arc=fail smtp.client-ip=52.101.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EmVXSPNiJ4HU/wrdTMnxQGniZ+9AM3OOsG45WY12YxlojAeGrwERICdLmP+XBzMruJfmFqjP/umF1gmRlNf3xcYUtVxktIr58GhTpValkAEPI3Ucu0Yx7/PCniNg2G3/OBoaP8o82dBtwOvGzorZPrSty5IfewcifIL95SZZx1K/VyMA3ox+yrwqVxYnF0SceeK4wob1clbS3cdVGVsdCiw6+Kd9i7m49bwSEY1KINPRWVwrzBlPTJeIbYql0Erx+uskrjPyOwRnPmXLX5t7IE4q4qHSPA8hyEoHNGNXAZKOvY0Xq0cKddEg4Zrtf/InytlkdG6r4BN4C0TQYzvRRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DmFB/cvotzcff+byXAI9FYlCaqMWfYuUZSJqCHphTQk=;
 b=syDfjBLV5rpKSc9bxmDPhu46vL/kBzNp5A1jT1zUV+KKJiKq6atIvfy6XGD20kwxHp117+DEZxGs7xfFN4lF2MLDd/qi/LafSsAwRrrP0/dg9ws2dKatefqW6nsJ1L23XMZiYbKq2hOMLynUCtbfAxHjO+3zexnU5mwBiEla6P7ydV6plWgZ3VTpYcmvciGPG19a/O6G6PB4a9h/HvmCHE+rthmbLkV9lWcePIVZqDxHfqNfkKakfzVhuKqTQqD+0oj1xM5qmZHEO3iNY0uG7i5CG8xTIB027qKchvUxe9Ho8+EkWmvQJHv+2cGR1D3vrSO2Bkps4Ksu2j7kFv0Yjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DmFB/cvotzcff+byXAI9FYlCaqMWfYuUZSJqCHphTQk=;
 b=iQt3pdQ5T7Ems1Oho03Kk05OGySjqki160SkGYRPk7mLK7QBZW/n+SCC4pRVsL1BadMGQ+LXPPWQVh9tcEVve7jIWjsvdeklJ7xCEd9J6rpacAn5zPCPnT29zkqzTirSucOlZUzZ7+ZlCByxdshtYSjVebBAiazGQQAMhke6FsoeiYej9Oh9JgeDMOB0fg/i9x6DUxmO5HNpMQcKkK6LkXGgHN4iddvLyYgP47Hi4NJsRVjS4BafY9r073nGRxwwR6xQcTNOvGdAFYoc4tEHwgBXfGmRO4SGQVArRLee4pCDrLuxZluQ+EoUxyemYAvVaDIx78fYMY1rR8elM/Fapw==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by VI1PR04MB6990.eurprd04.prod.outlook.com (2603:10a6:803:138::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 01:11:05 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%5]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 01:11:04 +0000
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
Thread-Index: AQHbh/hQ+lMRWdlcb0ifZRKBhtO67bNsjV2AgACiisA=
Date: Tue, 11 Mar 2025 01:11:04 +0000
Message-ID:
 <AS8PR04MB8676E66BD40C37B2A7E390178CD12@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20250226024256.1678103-3-hongxing.zhu@nxp.com>
 <20250310151109.GA540579@bhelgaas>
In-Reply-To: <20250310151109.GA540579@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|VI1PR04MB6990:EE_
x-ms-office365-filtering-correlation-id: 43e7e80c-e831-405b-a931-08dd603998b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?SU52MTZ6WUFrMWZjVjRZODE2b3RldzA5OEd3MmtQOWcvUjQ1MGxuOERJT0do?=
 =?gb2312?B?dHNTUURwWjJjajBMRGtPV3lORmlYU25VVU9NQ2ZxVTFTcngwVTJUVGlrTjJQ?=
 =?gb2312?B?UWFPaE5rSjVIdC9ZZEVBVE5iOGpvMm5IeW9nMkl3RXpIcE1Ta0ZJbWJRRm92?=
 =?gb2312?B?ZllsRUFac2hzSi9BOWltZ2d4V3J5dSs5dmhCVVhRTGtheG9sekltVkhFaFU1?=
 =?gb2312?B?cUpzSkpYTHllcG5wdklPR3hFWVo1WmkveTZrNHNlQmh3eFczUkIyVUV4aVJE?=
 =?gb2312?B?TCt6RHUwL2V0c1VJTGRzTkR6R255cFU0cy81bkhMa0lxSW1KUmw2aFNpcmxC?=
 =?gb2312?B?N0RxZjR0S0dveGtCVGtkUXRtRmhOT3VZVHY0cEsvS1NrTEVON2lNeHFwandM?=
 =?gb2312?B?b0VXeWtVSVZmUnRMYTgzc29tUUJzbjBYT3AyZHlJTHhZai9VU21tR1lIQnhD?=
 =?gb2312?B?amRsdHJvTjlqTkdzdEFrTjYrSnN1bWNXVGYrOHZnMG9xUGpsUUdOZWJHN00z?=
 =?gb2312?B?cFpTeEtzaWxPZnNsSXNvUkJpYUd0WjEvRDl4TjQ2c2ZSOUtFemNGdUQwRzlH?=
 =?gb2312?B?TERha1Zma1hYcFpFbTVDSm1KQXdwWk5sdkdyU0xXN0V4TGFHSWxtS3h1VTE2?=
 =?gb2312?B?dXpSZ3lsd3Q1ajVtTWw1Vk1oNXAwYTkwOG55UlByZk5YTWdwRUk5UE9MUjly?=
 =?gb2312?B?Nk1PU1plWHVsV3dTL1oxQ3IzRXdWdjV1S05PdmpaMVViRVY2TUlDOXVPVUxZ?=
 =?gb2312?B?M0wva3BhRUYzWWlSaXByZlZwQWlDU2ZkVUc1NXhqb1BJVU5yOXJreFluU0pH?=
 =?gb2312?B?c1MrMXFmMy8vSFpFSldhclZBUFQ1dkhvci8zM1hTSjRPVmhMYlJxU1poWTJx?=
 =?gb2312?B?blYwZGdWUmd6RkVmQ0t4akZFK09jZ1lkYlZPVTdXWEFNam1rMFEvRUhkY2Qv?=
 =?gb2312?B?L05Qb0J6UldaNlBQdUdDNnE1Tzg3RHZhWWVrSHJ0QjZ6VEhJZWM0T0krdGJF?=
 =?gb2312?B?UCtWS3lGV0ZpSjVXN0kwZkFGQk1oeThDd1k3WEh3b2FyMDE4TVdJMTFRaTIy?=
 =?gb2312?B?K2N2NFE3Z3U5L1VKYTE4M0tPclRvS0Uxc1ZoeU9aaUlvU29Ja3YrZWJzNFRv?=
 =?gb2312?B?N3FKbkUrQitPTjZkTUJLR3NtSys0K2lrZnh0RTQ5eDhzNlBwYzkydlVSQVoy?=
 =?gb2312?B?dGtYbjRsd0Exa1RDb2FVeUNjUkFBMnBiNkRGSk5GcUMya1I2UzNpcFZPRTFa?=
 =?gb2312?B?VzIyVzdiOTR4RWJjR0hIYjVRdzRjQk0wempLdDBYZ3VnMmVzTGY4aG9KRzdz?=
 =?gb2312?B?MVVHekVBRkllay9POFlUSVNvUUZKcHQzd0dFQUQ4ZUxiNEUxd3J2dmR0cUU5?=
 =?gb2312?B?K0lsdm5pTVJwdnRUNzNEVDY2NnV2YUZWaFJMdGxqMUxCejNaK0VMUGJiVS9l?=
 =?gb2312?B?aDJIMnRza1JKMktVN29jeG5wYmtJOWxuRThrU0FtbTd0QVZpSUswMzhuOU81?=
 =?gb2312?B?WFdrM2NwLzFrR3BlazREVXdlVXo5Qmhwc1FvdnRCS0ppREU3N1pOMGw5S3NM?=
 =?gb2312?B?SDIwUzQ4UTU0d3BGSkUyWjRWM0NLTXlxMmJZcjdUcmx6djJYQ1U0cUI2dmY4?=
 =?gb2312?B?eG9tQkJCTHE2SUxFT3VVN0ZDWTlld3kydjNnbWE3S3UyV2hBZUt4eVdiTngz?=
 =?gb2312?B?YTNGR2JRUWo0aStxSDhyY0F6RUwvc0ZnNThKaTB5NFJ6NmIyOXo3bXdQeEo4?=
 =?gb2312?B?VE4zVWFHMGVkREtYQmkxVjFpdDBXQ2Rlb3VUeUdzRGg2RG8xNDJXaGNBWDJk?=
 =?gb2312?B?N2RrOThLY1JzcStIdjA2Q2JDZDJRbVRhN29kQTI3TW9SampOeHBMQzdsM3Zh?=
 =?gb2312?B?azNqRDNNb0c0YVo1ak1BYzJWWFR3OUxOcFVXRDQ5TktDUytXaVc1eXFXSFN6?=
 =?gb2312?Q?0vCJ0GCcjsmonf2EKpZbegqwwNEEa1dF?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?VDlKcTU1VDh0QXFJUGlXZVlydGhWMEZxYy9wR0dTTGUxZlB3SHJISXZ1ay9Y?=
 =?gb2312?B?cHZheG9VOTdYQ3Flb3NWR3E2cjNqMTVvM3E5RzhmTjBqU05MaEtRa2lyMXJm?=
 =?gb2312?B?N0NtZWxOUFh1UmJVTkR2VU5BamdXMjlFYkRkdk93ajZIVUVrc0FGazVueDdN?=
 =?gb2312?B?WnJoVWVlNXJsODhsVkNZSk0rU2dCcU04dWc3aTYwUHpjYlJYMjdMOWFsUlR0?=
 =?gb2312?B?cU1JUkE4Z0tXREQ5b2UvV1ArQ2pEcnU1NmNZK0pDMER2L1lmT09uRTViaHc4?=
 =?gb2312?B?YVZ5U3EzdFZjRkQydm95eUt0dmdNMk5jbkRBQVU3aDh0bzVBbFN2VStlTmRN?=
 =?gb2312?B?YkVWdUt6WGhWL0ZhbDh0TzhDbEhVbUdOQ2FOV3B6bmNWa2tiWkVxT0FxUW9O?=
 =?gb2312?B?Y24vSjVSYU5aOTZGYXA4bytnUTRWMm11WmpsKzhvR05jenVlWGtBc3NFM0s4?=
 =?gb2312?B?NnFiSURTbU1sUjRUOUJCWGhYY0xiSU9TUysyZWJpcHRRNldKVm41NjBzVElj?=
 =?gb2312?B?bFdSWUlxdEtqcUZQeVVtTGdVRU93RkErc0xaMHhGZjFlYjBDcmpFQUhtRU53?=
 =?gb2312?B?VE9JeWtUY1prMWgyL3pHd3ZqOUFsdjNNWWZOTThZZDc4WENVOEQ2OGpFdm9U?=
 =?gb2312?B?aVpyQVZuZkkwSFhMR0xZRkpWWndYS3M1ZkQ5VTJhYTVxVlE2WTV2WHpzcFJT?=
 =?gb2312?B?NDFLKzZFTVlHSFBDYk5CRi9TUU9TRU1WanBYZVpQem1WUnhDanhMNWIyQ0p0?=
 =?gb2312?B?RTVBK2RLZmxEZUdGbHNhTzFZdkdVZVA4UmNjSFZ4ME84TTZjMGlXRFBWMFN3?=
 =?gb2312?B?SjZIem5BOERjUi9SbGRtMWtlMTg5NFlQQi93OG50VHFJd2FqNXgyVTkyazFx?=
 =?gb2312?B?eWZNTVh4VXRHU1FBSDdPbkJ2T2pUT0VJWWR2Qm1EUC9ZWUhxSS9jdmMrcGxx?=
 =?gb2312?B?c21CMkVIMzMzdHQ4NGVZaU8yY3JsUU8xOExVZjhmY0JlOTFtUGV0ekxxdlQz?=
 =?gb2312?B?Y2NWeTZXT1FvNlp4MjY0VzhmVjdqbHZROEpNQUo2cU0vRXZRRnl4ZFluU2Zo?=
 =?gb2312?B?WEpzSm5YVnZQYnV1M2JLdU1vT0l6T0M2Sy9XYUk3b2piZHJPMXkveTY4WHhu?=
 =?gb2312?B?M2U0bWtZdHM1V3M5U0NXQ29xZ1FZUzlORnVOQVdKcUl0Q3NPNkU2b3RDQytO?=
 =?gb2312?B?ZmY1RU9SMEErajEraXZtS015dS95SHRyMUZOOUpaNndYTFp3UTJ5WnNpN1Vn?=
 =?gb2312?B?SHBaSXlrQTEzRjA3VkQ3U2JqSFBINi9PN284R0ZqOGJvYTlpOFJoZ0MvSFBB?=
 =?gb2312?B?S1ViVWpCa0JudUQ2ZFdubEJCcm55Q1l0SElrb09IMWFGRVY5bkNnM25MZmtZ?=
 =?gb2312?B?cVdQSTM3T1BHNG0rNjVidEcrbCtld1BPOUxiN29PdjF2TVl6SzBST0M5dmtj?=
 =?gb2312?B?RVN3MzBqZWoyVGFDbzg1RW0zTkx1bExzeHhNTFljNUlhMGwxM3o2YVBnVFVn?=
 =?gb2312?B?RTAvOVRkbzFLYzh0UXlFVlFkRmJDKzQ4eGJSUHprOVFCU0liVm1CTHA4cXd0?=
 =?gb2312?B?UCtiYWJISDlKQWY1dDN2OTFGVHBpbXMzejdCai9TbC9GYWlaNmk3cGJXRTRJ?=
 =?gb2312?B?ZGJoTDZwYXZVRVExZUROYWdPb2N0L0ZSb2FMT3ZOVnMyZks5eVovaFJuR2NB?=
 =?gb2312?B?L3lYZjdrV0l1bWs5UHc1L3VXaWxZc1RZeFMzOStjRm5wZjF4L0plWXZPL090?=
 =?gb2312?B?LzNab3R5VTY1b3VmT2VveUhRUmNhM3hUblM0T0ZGMWJIc2RoWFRXQ3lKL1NF?=
 =?gb2312?B?cnJlUVp4VStISXN1b2JiMDJlZzlzM3FMeEcvZ1AwSDR6RUN1eUNJVlhNRGE0?=
 =?gb2312?B?S2FZY2lDOHBTZHRuU0QwT2gxTG4wbTU1NTdVSVRoQnVjVGtDTVpYbk5OTU5Z?=
 =?gb2312?B?TDBjK21hSlpZaTNCaWxFcFVhSmg5bWNicnBaWW5NeTdzaytRK2Jxb2h5L0Zh?=
 =?gb2312?B?RTdSbG5GVjJNODBnWXVJVmlSRDYrWmhKeXo1Wm4wUDA2c2MwTlUwbFNnVFIx?=
 =?gb2312?B?UnBCR1RycFFhQWtndHQrMjJPeStwZHJoTjZCL2lFU2pQNjZETm9XTGRqWDN3?=
 =?gb2312?Q?BJVcunx4kKMbcD/eaFDHkF4pu?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 43e7e80c-e831-405b-a931-08dd603998b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2025 01:11:04.7577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cpwTgJsCu3Vt84AF5zqBL509+txLVYpvhFj5nlsTe5cvA2P3UQQwhWR8Vt25DNJY31PpK93MyZ5jMMYRP6aYaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6990

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCam9ybiBIZWxnYWFzIDxoZWxn
YWFzQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjXE6jPUwjEwyNUgMjM6MTENCj4gVG86IEhvbmd4
aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+IENjOiByb2JoQGtlcm5lbC5vcmc7IGty
emsrZHRAa2VybmVsLm9yZzsgY29ub3IrZHRAa2VybmVsLm9yZzsNCj4gc2hhd25ndW9Aa2VybmVs
Lm9yZzsgbC5zdGFjaEBwZW5ndXRyb25peC5kZTsgbHBpZXJhbGlzaUBrZXJuZWwub3JnOw0KPiBr
d0BsaW51eC5jb207IG1hbml2YW5uYW4uc2FkaGFzaXZhbUBsaW5hcm8ub3JnOyBiaGVsZ2Fhc0Bn
b29nbGUuY29tOw0KPiBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207
IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3Jn
OyBpbXhAbGlzdHMubGludXguZGV2OyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7DQo+IGxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
Zw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDIvMl0gUENJOiBpbXg2OiBVc2UgZG9tYWluIG51
bWJlciByZXBsYWNlIHRoZQ0KPiBoYXJkY29kZXMNCj4gDQo+IE9uIFdlZCwgRmViIDI2LCAyMDI1
IGF0IDEwOjQyOjU2QU0gKzA4MDAsIFJpY2hhcmQgWmh1IHdyb3RlOg0KPiA+IFVzZSB0aGUgZG9t
YWluIG51bWJlciByZXBsYWNlIHRoZSBoYXJkY29kZXMgdG8gdW5pcXVlbHkgaWRlbnRpZnkNCj4g
PiBkaWZmZXJlbnQgY29udHJvbGxlciBvbiBpLk1YOE1RIHBsYXRmb3Jtcy4gTm8gZnVuY3Rpb24g
Y2hhbmdlcy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFJpY2hhcmQgWmh1IDxob25neGluZy56
aHVAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNp
LWlteDYuYyB8IDE0ICsrKysrKy0tLS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2Vy
dGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9w
Y2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiA+IGIvZHJpdmVycy9wY2kvY29udHJvbGxl
ci9kd2MvcGNpLWlteDYuYw0KPiA+IGluZGV4IDkwYWNlOTQxMDkwZi4uYWI5ZWJiNzgzNTkzIDEw
MDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4g
PiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gQEAgLTQx
LDcgKzQxLDYgQEANCj4gPiAgI2RlZmluZSBJTVg4TVFfR1BSX1BDSUVfQ0xLX1JFUV9PVkVSUklE
RQlCSVQoMTEpDQo+ID4gICNkZWZpbmUgSU1YOE1RX0dQUl9QQ0lFX1ZSRUdfQllQQVNTCQlCSVQo
MTIpDQo+ID4gICNkZWZpbmUgSU1YOE1RX0dQUjEyX1BDSUUyX0NUUkxfREVWSUNFX1RZUEUJR0VO
TUFTSygxMSwgOCkNCj4gPiAtI2RlZmluZSBJTVg4TVFfUENJRTJfQkFTRV9BRERSCQkJMHgzM2Mw
MDAwMA0KPiA+DQo+ID4gICNkZWZpbmUgSU1YOTVfUENJRV9QSFlfR0VOX0NUUkwJCQkweDANCj4g
PiAgI2RlZmluZSBJTVg5NV9QQ0lFX1JFRl9VU0VfUEFECQkJQklUKDE3KQ0KPiA+IEBAIC0xNDc0
LDcgKzE0NzMsNiBAQCBzdGF0aWMgaW50IGlteF9wY2llX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9k
ZXZpY2UNCj4gKnBkZXYpDQo+ID4gIAlzdHJ1Y3QgZHdfcGNpZSAqcGNpOw0KPiA+ICAJc3RydWN0
IGlteF9wY2llICppbXhfcGNpZTsNCj4gPiAgCXN0cnVjdCBkZXZpY2Vfbm9kZSAqbnA7DQo+ID4g
LQlzdHJ1Y3QgcmVzb3VyY2UgKmRiaV9iYXNlOw0KPiA+ICAJc3RydWN0IGRldmljZV9ub2RlICpu
b2RlID0gZGV2LT5vZl9ub2RlOw0KPiA+ICAJaW50IGksIHJldCwgcmVxX2NudDsNCj4gPiAgCXUx
NiB2YWw7DQo+ID4gQEAgLTE1MTUsMTAgKzE1MTMsNiBAQCBzdGF0aWMgaW50IGlteF9wY2llX3By
b2JlKHN0cnVjdA0KPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gIAkJCXJldHVybiBQVFJf
RVJSKGlteF9wY2llLT5waHlfYmFzZSk7DQo+ID4gIAl9DQo+ID4NCj4gPiAtCXBjaS0+ZGJpX2Jh
c2UgPSBkZXZtX3BsYXRmb3JtX2dldF9hbmRfaW9yZW1hcF9yZXNvdXJjZShwZGV2LCAwLA0KPiAm
ZGJpX2Jhc2UpOw0KPiA+IC0JaWYgKElTX0VSUihwY2ktPmRiaV9iYXNlKSkNCj4gPiAtCQlyZXR1
cm4gUFRSX0VSUihwY2ktPmRiaV9iYXNlKTsNCj4gDQo+IFRoaXMgbWFrZXMgbWUgd29uZGVyLg0K
PiANCj4gSUlVQyB0aGlzIG1lYW5zIHRoYXQgcHJldmlvdXNseSB3ZSBzZXQgY29udHJvbGxlcl9p
ZCB0byAxIGlmIHRoZSBmaXJzdCBpdGVtIGluDQo+IGRldmljZXRyZWUgInJlZyIgd2FzIDB4MzNj
MDAwMDAsIGFuZCBub3cgd2Ugd2lsbCBzZXQgY29udHJvbGxlcl9pZCB0byAxIGlmDQo+IHRoZSBk
ZXZpY2V0cmVlICJsaW51eCxwY2ktZG9tYWluIiBwcm9wZXJ0eSBpcyAxLg0KPiBUaGlzIGlzIGdv
b2QsIGJ1dCBJIHRoaW5rIHRoaXMgbmV3IGRlcGVuZGVuY3kgb24gdGhlIGNvcnJlY3QNCj4gImxp
bnV4LHBjaS1kb21haW4iIGluIGRldmljZXRyZWUgc2hvdWxkIGJlIG1lbnRpb25lZCBpbiB0aGUg
Y29tbWl0IGxvZy4NCj4gDQo+IE15IGJpZ2dlciB3b3JyeSBpcyB0aGF0IHdlIG5vIGxvbmdlciBz
ZXQgcGNpLT5kYmlfYmFzZSBhdCBhbGwuICBJIHNlZSB0aGF0IHRoZQ0KPiBvbmx5IHVzZSBvZiBw
Y2ktPmRiaV9iYXNlIGluIHBjaS1pbXg2LmMgd2FzIHRvIGRldGVybWluZSB0aGUgY29udHJvbGxl
cl9pZCwNCj4gYnV0IHRoaXMgaXMgYSBEV0MtYmFzZWQgZHJpdmVyLCBhbmQgdGhlIERXQyBjb3Jl
IGNlcnRhaW5seSB1c2VzDQo+IHBjaS0+ZGJpX2Jhc2UuICBBcmUgd2Ugc3VyZSB0aGF0IG5vbmUg
b2YgdGhvc2UgRFdDIGNvcmUgcGF0aHMgYXJlDQo+IGltcG9ydGFudCB0byBwY2ktaW14Ni5jPw0K
SGkgQmpvcm46DQpUaGFua3MgZm9yIHlvdXIgY29uY2VybnMuDQpEb24ndCB3b3JyeSBhYm91dCB0
aGUgYXNzaWdubWVudCBvZiBwY2ktPmRiaV9iYXNlLg0KSWYgcGNpLWlteDYuYyBkcml2ZXIgZG9l
c24ndCBzZXQgaXQuIERXQyBjb3JlIGRyaXZlciB3b3VsZCBzZXQgaXQgd2hlbg0KIGR3X3BjaWVf
Z2V0X3Jlc291cmNlcygpIGlzIGludm9rZWQuDQoNCmR3X3BjaWVfaG9zdF9pbml0KCkvZHdfcGNp
ZV9lcF9pbml0KCkNCiAgLT5kd19wY2llX2dldF9yZXNvdXJjZXMoKQ0KDQouLi4NCiAgICAgICAg
aWYgKCFwY2ktPmRiaV9iYXNlKSB7DQogICAgICAgICAgICAgICAgcmVzID0gcGxhdGZvcm1fZ2V0
X3Jlc291cmNlX2J5bmFtZShwZGV2LCBJT1JFU09VUkNFX01FTSwgImRiaSIpOw0KICAgICAgICAg
ICAgICAgIHBjaS0+ZGJpX2Jhc2UgPSBkZXZtX3BjaV9yZW1hcF9jZmdfcmVzb3VyY2UocGNpLT5k
ZXYsIHJlcyk7DQogICAgICAgICAgICAgICAgaWYgKElTX0VSUihwY2ktPmRiaV9iYXNlKSkNCiAg
ICAgICAgICAgICAgICAgICAgICAgIHJldHVybiBQVFJfRVJSKHBjaS0+ZGJpX2Jhc2UpOw0KICAg
ICAgICAgICAgICAgIHBjaS0+ZGJpX3BoeXNfYWRkciA9IHJlcy0+c3RhcnQ7DQogICAgICAgIH0N
Ci4uLg0KDQoNCkJlc3QgUmVnYXJkcw0KUmljaGFyZCBaaHUNCj4gDQo+ID4gIAkvKiBGZXRjaCBH
UElPcyAqLw0KPiA+ICAJaW14X3BjaWUtPnJlc2V0X2dwaW9kID0gZGV2bV9ncGlvZF9nZXRfb3B0
aW9uYWwoZGV2LCAicmVzZXQiLA0KPiBHUElPRF9PVVRfSElHSCk7DQo+ID4gIAlpZiAoSVNfRVJS
KGlteF9wY2llLT5yZXNldF9ncGlvZCkpDQo+ID4gQEAgLTE1NjUsOCArMTU1OSwxMiBAQCBzdGF0
aWMgaW50IGlteF9wY2llX3Byb2JlKHN0cnVjdA0KPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+
ID4gIAlzd2l0Y2ggKGlteF9wY2llLT5kcnZkYXRhLT52YXJpYW50KSB7DQo+ID4gIAljYXNlIElN
WDhNUToNCj4gPiAgCWNhc2UgSU1YOE1RX0VQOg0KPiA+IC0JCWlmIChkYmlfYmFzZS0+c3RhcnQg
PT0gSU1YOE1RX1BDSUUyX0JBU0VfQUREUikNCj4gPiAtCQkJaW14X3BjaWUtPmNvbnRyb2xsZXJf
aWQgPSAxOw0KPiA+ICsJCXJldCA9IG9mX2dldF9wY2lfZG9tYWluX25yKG5vZGUpOw0KPiA+ICsJ
CWlmIChyZXQgPCAwIHx8IHJldCA+IDEpDQo+ID4gKwkJCXJldHVybiBkZXZfZXJyX3Byb2JlKGRl
diwgLUVOT0RFViwNCj4gPiArCQkJCQkgICAgICJmYWlsZWQgdG8gZ2V0IHZhbGlkIHBjaWUgZG9t
YWluXG4iKTsNCj4gPiArCQllbHNlDQo+ID4gKwkJCWlteF9wY2llLT5jb250cm9sbGVyX2lkID0g
cmV0Ow0KPiA+ICAJCWJyZWFrOw0KPiA+ICAJZGVmYXVsdDoNCj4gPiAgCQlicmVhazsNCj4gPiAt
LQ0KPiA+IDIuMzcuMQ0KPiA+DQo=

