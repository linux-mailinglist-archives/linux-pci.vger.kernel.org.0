Return-Path: <linux-pci+bounces-14843-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8261D9A332B
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 05:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 084A81F23E2E
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 03:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BDC155C8D;
	Fri, 18 Oct 2024 03:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NakxOZeb"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013047.outbound.protection.outlook.com [52.101.67.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3890143888;
	Fri, 18 Oct 2024 03:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729220758; cv=fail; b=O+m0mxkNVUsd2ETEdX3d2zwTweWhF9u88UMpOTSkH6tJ/CrlJi9CNrp4BjEfKPZEwYmflvtiMe8cezBRXhJ5RXiJYEUjuBpdbHQb0zgczD8FKXN258BwRot4n/bi4W3MMnZYnos+MfqaMzS5DfLmiqSdPsk2HEv82xXtwOZdxEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729220758; c=relaxed/simple;
	bh=fI+yDppOVDuL3FCvOwytv+/fLBHnR1Yi4o8EXwZ4z0E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BzZ+/IioIhMvvUWzvyUQr0I9XSZ3WGKANPsJzY0u9ieUq7uYf+iJUDBplFxNyyUTUOc/MHYweg1j7wqipDWEBkrDBTvhlFwPJzl62lQDuA0Q6rKWcbfsJu1VZgAPKUHJConijdttBd4IUoTpoIoagUkF0Y8KIHSDhjtNLEnHRlA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NakxOZeb; arc=fail smtp.client-ip=52.101.67.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rmzR0VYNyexhloMUV/JRp4PCz3eWgiVhkQzFG1Fv2qgOmiXVQLTHSWPQMkGunZY+UxrWb21uafvY3zC7RElRoK4tsfw6ZdT/7XepxXi3lSuWKQwnAv/ZcW+OZytitLk+VtKmxZSabuJxF83bRLEdsPXV8UAKqfSPaKA+fEjUqJfRREwDGlp4zjlr737TWwJCynUzSl//C4gDb9J4m+2ipqe67MlnsY3VuoelKAwOM8tCIAQqAom/W/jR00x+ePHP6ZvlKEPRmndpWLUMrBwM3Pgl58eg7quqpaNMB0lXBSMlK7P+/nNaEV69U2bZDT9MYkMMUZY0qoh+n/FLbWD+MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fI+yDppOVDuL3FCvOwytv+/fLBHnR1Yi4o8EXwZ4z0E=;
 b=hwBa+2OBWRe93UhWVvPkkCXb/TVzjz7cbZOZ/E35kNxkfxwcAUbvYGK6FRVbu5dqaE+NUpdi01v4QDN9RwUmEt7CtLsymvzLUPyGmAksWm6L4xkMn0E9WBwMqkdBqZH/fsNMGt2XGHdMkAHdR3AX3oxTf615c8FkLC0aFlOmaMlWWDrWpNsbfQlIXYiQyRTq7tr5oa01Ynz3+TCRn7bj22HvUOCtOkH07NMcx9Ix4EAZ81QJiu2OiDqd7KdFyI+kPjTAHL2VLkc67yMGvGVEqrqlCHTJedhn0VPzFcZbQvxT+1HLWl67iuCOKoqdVkM2MJnBQER3k7ppEcfm6cb2Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fI+yDppOVDuL3FCvOwytv+/fLBHnR1Yi4o8EXwZ4z0E=;
 b=NakxOZebN4SEpn2E0tUjjyXRWiWWQUqZl/op5nCEgyCFGkXXYpk8e+B8D17HsnW5NrPIYmoTBHuPElXQQsLcHb4c+oBkriSa1RlWmMwHEE4hUcMhw4BAl1CPnX/nIh/FHhuD8SxSHvKgnui71FbUPKXq8x1lq4TYuG+uXIb4v3urBjEiUQBSJgYHN3PP1sYPDwN6EY2RwSctYPvwz6NqMDMIH+q8Oh1NqucBPCzT0FooBa4gl/kFq4MvXxnVn1ITkRLjTd5RXdd4mnRQa6hGQ7kZxDOa+0MbmhOfyZCxLyuQ0rdAkCUB4HT01kFp9iG8nUXad9rZwq1thChW2CGjJg==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB8899.eurprd04.prod.outlook.com (2603:10a6:20b:42e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 03:05:53 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8048.020; Fri, 18 Oct 2024
 03:05:52 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>, Claudiu
 Manoil <claudiu.manoil@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "horms@kernel.org" <horms@kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: RE: [PATCH v3 net-next 12/13] net: enetc: add preliminary support for
 i.MX95 ENETC PF
Thread-Topic: [PATCH v3 net-next 12/13] net: enetc: add preliminary support
 for i.MX95 ENETC PF
Thread-Index: AQHbIGsGfwE9ZCz3ZEi++6XhhsicXLKLKwWAgACQAXCAABj9wA==
Date: Fri, 18 Oct 2024 03:05:52 +0000
Message-ID:
 <PAXPR04MB8510A1664D3CFAACD71872AB88402@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241017074637.1265584-1-wei.fang@nxp.com>
 <20241017074637.1265584-13-wei.fang@nxp.com>
 <ZxFCcbDqXHdkW18c@lizhi-Precision-Tower-5810>
 <PAXPR04MB8510E7AD1EEAFD9332DAE29788402@PAXPR04MB8510.eurprd04.prod.outlook.com>
In-Reply-To:
 <PAXPR04MB8510E7AD1EEAFD9332DAE29788402@PAXPR04MB8510.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AS8PR04MB8899:EE_
x-ms-office365-filtering-correlation-id: 2cc7ac6e-ad87-4ffc-dcd4-08dcef21c6c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?cEE4U0NRcC8wVUdsYk1iZElXYWIzbXpWVk5CVEx6bDFjQWZuTXNrQWpveXFQ?=
 =?gb2312?B?V1pNamJMVU9iZFBUd0RlUHZ5WXNuNllQbGcrbzRzZFVlVWUyWTluNDJGSmhS?=
 =?gb2312?B?YWo4S1JXWGkrOEtIK0pMUmxubWY1bmhNdEkydUFsZVE4MGY1RzJVQ2hBak5L?=
 =?gb2312?B?dVpyWWxkMjJ1MTRqdzdXdW1CTlBqUHZGeHJyWmJCdzRCY1Y3TzRBaDd6SkJI?=
 =?gb2312?B?Y1pzQ3VzbzBXWnY1M2lFQk0vNUgrSTA0V3kxZFlhR3EyTTNlNGFVaHdmVUxC?=
 =?gb2312?B?cmI3Mmpsd2pBSXZUTFhvSzNsaUh4djlZWlJGb3FZOXp1Z3lUdWNhTitUMFNn?=
 =?gb2312?B?SHVKek1yLzBQY09WRzhPZ3diRS9JUTRRN2xmV0U1R24zNUtmNm1zbHVyUU1T?=
 =?gb2312?B?ajBNbmFnbUJrblhvZ0lMVFdSQlQ2d0Vxem1vV2RGeVNPbEk4RHI5TDlBRGpw?=
 =?gb2312?B?aG1LWHJUb0VrWTlnRDZ6K0ZxWXpNNXFWTWlWWVRxcHBRb3NlRkh2azNCemJL?=
 =?gb2312?B?dEgzNUR5cTJXV01zUC94ZHk2YWMvUkZPV1AvekpkRU82Q05PUFMrV2NGMFNQ?=
 =?gb2312?B?K294ZlhqVGkvZlQwb0l6VEVKTzNjQXgvR1lGekZWVXQrZWw5UnBVNnBHVnJH?=
 =?gb2312?B?cUpxaWRtKzdBeW5pMVpubW1OTHVXMHRBdjc5ZElRb1JGSGVTeE1nTEdKcWtk?=
 =?gb2312?B?L08rYUNJWUQ1enhJVUl5TXk5U08vb1NlZFMva2V4WXgyWDg0MjdBaUxSRkdN?=
 =?gb2312?B?Zkw0dkpEdXRVelRHc21mMnJKMWVqenFmTTRXZXU1NWdKMXhmWjdVa0t5UHdH?=
 =?gb2312?B?RFVjTysrekVuOGlyOFdraTE5NnFqbCtNNlpmQ2Y2cnJ6Nm4waHJaOWpGVndK?=
 =?gb2312?B?OFdFN3hQVDAzb2RiQWFwb0FySXZWVHVjVXZ0WW5VbEZPSGZWVHZWN2tMUGRq?=
 =?gb2312?B?V01TbERHaUhLUnFHa1JNc0pNU2RHRzVoQnZIQWZ4UnZPK0o5dEtKYmFFUmNO?=
 =?gb2312?B?ZmdraytGcTlSTktRTHQrcWRCVldOSGl0NVl1ZENwYXl5OWpOV0VwOWF5Yk4x?=
 =?gb2312?B?allqcHo5ZVB5aEkvV1NpNGJxck1EeE01UmNjRGR0SEJ6TWwvTi9haGxHMTNj?=
 =?gb2312?B?ejR2Y3FhS1dTS3NOT1h3T1BzNS9nWDdYRkxaVHdzc0lLbzBmWDZjSUo0cDQ4?=
 =?gb2312?B?MlBkU0hzQkdlNHcrSTlkcjJpdlhsakpFNGlqMDhlZlRiOGR3TmpIdmJPNG1J?=
 =?gb2312?B?YU0xbkZvZTVZTVlpR3c4U2ZEQkMzOHFYbXRKMFJaUVZTWmdZaDAxelNGRC84?=
 =?gb2312?B?aDdvUHF5K2JjYmc4Y2p0L0pUMTd5cHdpK0VCQVZ1dm11emJZbXpqVTZ4U21w?=
 =?gb2312?B?MCt6TWlYdmUvYnR2ckN5TGxTUzRkNWVjbWo1SjhUSTRpblhTcHRldXQyOGEr?=
 =?gb2312?B?V1Q4d0sxdTJiYks4Z0FWdEtJSjFrQ2ZXZ3h3LzVHeHVCdC9lS1RqOUdpY2pz?=
 =?gb2312?B?cHphN3NSSmVRU2RCcnZ2Si9UaXF0NDVudnNadzlNazd3MUljNU5vQW1vSWgr?=
 =?gb2312?B?RjQ3aE0zaTBEVHZFYnFleDl5UXgwd0V3MStSR3M5ZGtaOE85OGJMbFpoS3ln?=
 =?gb2312?B?M1ZyTVd4OU90NG04SmJYTFk3ZlhEcDIyRXpZMmlTRDU1MlU5azFOYlBtV2o5?=
 =?gb2312?B?Y0Flc25zdmVoY2w3SlFXMERyYSs2VVkzTkhiUFZnYmt4V2RkS2xaWEFaN3J3?=
 =?gb2312?B?cklZcFZTQmhNdHI5b1hOV0Y3dG9xcHhRSmVjSUhGUGVxbEQ0ZWl1eUs2QkNY?=
 =?gb2312?Q?29Fvj/Me/AtgYArJd0mZzxglERLx3uNaHxr7Q=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?QmZRZG1JZm0wS1pua2NpMzNXa3pVQ0ZWK0ZnTW1tZFlPZE1lU2FINVlrQ3VN?=
 =?gb2312?B?dnJzeUFGaXlONjVES1BoWE95ODhBZThNOStUNWhFVnBCVGJyN05PdUdmWk5B?=
 =?gb2312?B?dVowZFNsWTFCZVRicXBDRitvdnlidDduL2JYZ2g4alhHaGRLTC96RUZxREhD?=
 =?gb2312?B?N2dpUm51d3c1V0dUckxYTFY0T1ZnRUVQNWtOQVRsN3lITzBsR3hSN0o2clJ5?=
 =?gb2312?B?R2hXbDZVcVV4ZnRqVkIyVEMxMHc3aDRCYjBueG1rbFJ2c2JNeXpzeDNuRXlZ?=
 =?gb2312?B?b0dLSVNPU3VxZDNwaHRPMDF3YkxPNkRFZDRrRnV2Ylh0NFFUZW1lNlozcFpZ?=
 =?gb2312?B?bVpaT2NwbXlsTys4MGN2MWtlelI2bkc3N2E0TzBuaVd5Y1A4L2p1Z25yUkxT?=
 =?gb2312?B?elQvQXNNUDdTWm1QWWNTakdsMThxTWt1aVBMWDhEQSsxc3Q2U092SFd1M1BS?=
 =?gb2312?B?dXNKN1N0Z1k4MWcvY1BvczU5L2UraG44WmtKaGpVajVtcW1mNHo5eDc4ekty?=
 =?gb2312?B?cjJxVGVES1BqZVVnbWxKM2prTXljMFZ3QWg3MVAyQlVGTXdHN0Q4YzJXSTha?=
 =?gb2312?B?Nk01QkVVeDBUNEV4VkNtN1RwQnRFR0lvN3I0YmZ0WTJHendScE1EcDVxbDF0?=
 =?gb2312?B?amJXQlFCRUM1ZG5QaG1LTVpXeU1mZUJqN0M1NlJCQXRaaHUxNzUzNE5QVzdz?=
 =?gb2312?B?N3Q2T3Nhc2dQMmJIL3VaS2QwWGtNVlI0dkxjY0dFWlQrTlVMcWEzRnJmdEIv?=
 =?gb2312?B?c29iZ2kzSkVkRGpxUkx6Vll0ZWo1MGorcDI0a3BKNmZHaUF3QkNCU3lTMFNx?=
 =?gb2312?B?aGF2UFo1SGVlWlE4enMrM0E0L05vcjNLU1hkemk1cG5nNU1PSlg1TmJWOGw1?=
 =?gb2312?B?VEhWbTVBeXZhM3U1Z2xoVWNNTklMOXVRL296Z1BudHI5bXFTak9qOVp2RUJD?=
 =?gb2312?B?Z1VnN3R1dHlicTBIRTlZRUl4Wkh4aXQ4VnA5RnM1Mi8vY2xpemFDT1pQeWZV?=
 =?gb2312?B?WlBURmMrQ1cydDgzczdpdjM3VDhBUERHS2dKTk50REJuMlp1VkszbE9aSUZz?=
 =?gb2312?B?bUpxRGxOK0NFN3dlV0F1bG1pdlRUZm0vRFhCSU9KV1l6NlBxa3laVXk5TWp5?=
 =?gb2312?B?ZUcvY1BrdHQ0dzluaUdkaVZ2c1hZMUhMeTh6SmRCVE5qME1ORWY0YWVkMC9a?=
 =?gb2312?B?M2JrcVlzL0hFOHhvSnlYSnRPR1B4b2NHQ2IzRFFueWJtQjZBT3RWdEREOVVF?=
 =?gb2312?B?c1BPTjc4Y2pNUlNWQ05aR3pHcG1kMXl3M2Z4VkRuZUtDNUVCK0lpZllqQlRK?=
 =?gb2312?B?UyszMUZYUllOc05VYWRYaHkvUEp4MStkb3lib3BUSk9VYmpWd0hZVlM1azVI?=
 =?gb2312?B?UzNXbEhUVFoxc2tIQS83RlJNd0xGL0lCMmNacVNOUTNMUmlYLzhmRXM1VXpV?=
 =?gb2312?B?UFBydTZTb2lJdGh6VVRZWkZ4YktFY2VVZkxQUlUxcEVRckp4WWt2Tm01K2Z1?=
 =?gb2312?B?djVnRWY1cE83aGJBbWR3VnBKTEdSSFQycHJnMTBBc0h2L3loOFQ0Z0loNEkz?=
 =?gb2312?B?RlVsd2ZHalZmQkMyN2UyaDdxUFlDVGNWeDRPK1FxOFAwc0RWSXNsNzBTTEpa?=
 =?gb2312?B?ZXZqWHdTVHZhOVdGdWNoZDllWEQrVVloTU5BdmF2OHBuY3NiazRKTk45SlZ6?=
 =?gb2312?B?b1Q3NDJsUTZMUHBrc2JvL0l5WDdpeWhTakV5TEM5ZVBieDRXdTlVb29HNWJX?=
 =?gb2312?B?NHQvQ1lHQUNYSDVaYm5zREpkREpnMmh6WTdjWHczOFNKWnlVYkVZUG5YNCtl?=
 =?gb2312?B?cDNYdSs4SEpURENZZVNrZnF3bFhyK0ZtZjMyTFB1L0RYSGwyY0pXdXowR2RR?=
 =?gb2312?B?cnB3K0xYb0Z1ZjU5YWYwbmxsNFJwZ28vSVNiYVZjcHI4Y3BGMU4rZFBZMExR?=
 =?gb2312?B?MFVlQU5ncUFqTC90VkpxWk5NcnZFd2xhSzNOYUYzQnZyWTBDaGVoK2oxKysw?=
 =?gb2312?B?dHhnUnFPZ2tLQ3hoYk1ucGZhUjlzNk5WQXZQYkZLdzJoMjFLd3ZYUjZSbzR0?=
 =?gb2312?B?bGdCd1FOM1FaWUkxVTJqVjN2dTRDb1ZnQUFyMWd5WVMxOW13cXVjNmVsT0tO?=
 =?gb2312?Q?Afrw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cc7ac6e-ad87-4ffc-dcd4-08dcef21c6c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2024 03:05:52.7076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1xBWJAPmXgMbqSSxTl1EF4FUiDI8pn9Ou4WQ+YaWd8lnGHrsNNbBEsNYAVr0uY1NHUXYPxalHfUqQG+YDH7ehw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8899

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBXZWkgRmFuZw0KPiBTZW50OiAy
MDI0xOoxMNTCMTjI1SAxMDowNA0KPiBUbzogRnJhbmsgTGkgPGZyYW5rLmxpQG54cC5jb20+DQo+
IENjOiBkYXZlbUBkYXZlbWxvZnQubmV0OyBlZHVtYXpldEBnb29nbGUuY29tOyBrdWJhQGtlcm5l
bC5vcmc7DQo+IHBhYmVuaUByZWRoYXQuY29tOyByb2JoQGtlcm5lbC5vcmc7IGtyemsrZHRAa2Vy
bmVsLm9yZzsNCj4gY29ub3IrZHRAa2VybmVsLm9yZzsgVmxhZGltaXIgT2x0ZWFuIDx2bGFkaW1p
ci5vbHRlYW5AbnhwLmNvbT47IENsYXVkaXUNCj4gTWFub2lsIDxjbGF1ZGl1Lm1hbm9pbEBueHAu
Y29tPjsgQ2xhcmsgV2FuZyA8eGlhb25pbmcud2FuZ0BueHAuY29tPjsNCj4gY2hyaXN0b3BoZS5s
ZXJveUBjc2dyb3VwLmV1OyBsaW51eEBhcm1saW51eC5vcmcudWs7IGJoZWxnYWFzQGdvb2dsZS5j
b207DQo+IGhvcm1zQGtlcm5lbC5vcmc7IGlteEBsaXN0cy5saW51eC5kZXY7IG5ldGRldkB2Z2Vy
Lmtlcm5lbC5vcmc7DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6
IFJFOiBbUEFUQ0ggdjMgbmV0LW5leHQgMTIvMTNdIG5ldDogZW5ldGM6IGFkZCBwcmVsaW1pbmFy
eSBzdXBwb3J0IGZvcg0KPiBpLk1YOTUgRU5FVEMgUEYNCj4gDQo+IFsuLi5dDQo+ID4gPiBAQCAt
MTcyMSwxNCArMTcyNCwyNSBAQCB2b2lkIGVuZXRjX2dldF9zaV9jYXBzKHN0cnVjdCBlbmV0Y19z
aSAqc2kpDQo+ID4gPiAgCXN0cnVjdCBlbmV0Y19odyAqaHcgPSAmc2ktPmh3Ow0KPiA+ID4gIAl1
MzIgdmFsOw0KPiA+ID4NCj4gPiA+ICsJaWYgKGlzX2VuZXRjX3JldjEoc2kpKQ0KPiA+ID4gKwkJ
c2ktPmNsa19mcmVxID0gRU5FVENfQ0xLOw0KPiA+ID4gKwllbHNlDQo+ID4gPiArCQlzaS0+Y2xr
X2ZyZXEgPSBFTkVUQ19DTEtfMzMzTTsNCj4gPg0KPiA+IGNhbiB5b3UgdXNlIGNsa19nYXRlX3Jh
dGUoKSB0byBnZXQgZnJlcXVlbmN5IGluc3RlYWQgb2YgaGFyZGNvZGUgaGVyZS4NCj4gDQo+IGNs
a19nYXRlX3JhdGUoKSBpcyBub3QgcG9zc2libGUgdG8gYmUgdXNlZCBoZXJlLCBlbmV0Y19nZXRf
c2lfY2FwcygpIGlzIHNoYXJlZA0KPiBieSBQRiBhbmQgVkZzLCBidXQgVkYgZG9lcyBub3QgaGF2
ZSBEVCBub2RlLiBTZWNvbmQsIExTMTAyOEEgYW5kIFMzMg0KPiBwbGF0Zm9ybSBkbyBub3QgdXNl
IHRoZSBjbG9ja3MgcHJvcGVydHkuDQo+IA0KPiA+IE9yIHlvdSBzaG91bGQgdXNlIHN0YW5kYXJk
IFBDSWUgdmVyc2lvbiBpbmZvcm1hdGlvbi4NCj4gPg0KPiANCj4gV2hhdCBkbyB5b3UgbWVhbiBz
dGFuZGFyZCBQQ0llIHZlcnNpb24/IGlzX2VuZXRjX3JldjEoKSBnZXRzIHRoZSByZXZpc2lvbg0K
PiBmcm9tIHN0cnVjdCBwY2lfZGV2OjogcmV2aXNpb24sIG15IHVuZGVyc3RhbmRpbmcgaXMgdGhh
dCB0aGlzIGlzIHRoZSByZXZpc2lvbg0KPiBwcm92aWRlZCBieSBQQ0llLg0KPiANCj4gWy4uLl0N
Cj4gPiA+ICsNCj4gPiA+IEBAIC01OTMsNiArNjIwLDkgQEAgc3RhdGljIGludCBlbmV0Y19nZXRf
cnhuZmMoc3RydWN0IG5ldF9kZXZpY2UgKm5kZXYsDQo+ID4gc3RydWN0IGV0aHRvb2xfcnhuZmMg
KnJ4bmZjLA0KPiA+ID4gIAlzdHJ1Y3QgZW5ldGNfbmRldl9wcml2ICpwcml2ID0gbmV0ZGV2X3By
aXYobmRldik7DQo+ID4gPiAgCWludCBpLCBqOw0KPiA+ID4NCj4gPiA+ICsJaWYgKGlzX2VuZXRj
X3JldjQocHJpdi0+c2kpKQ0KPiA+ID4gKwkJcmV0dXJuIC1FT1BOT1RTVVBQOw0KPiA+ID4gKw0K
PiA+ID4gIAlzd2l0Y2ggKHJ4bmZjLT5jbWQpIHsNCj4gPiA+ICAJY2FzZSBFVEhUT09MX0dSWFJJ
TkdTOg0KPiA+ID4gIAkJcnhuZmMtPmRhdGEgPSBwcml2LT5udW1fcnhfcmluZ3M7DQo+ID4gPiBA
QCAtNjQzLDYgKzY3Myw5IEBAIHN0YXRpYyBpbnQgZW5ldGNfc2V0X3J4bmZjKHN0cnVjdCBuZXRf
ZGV2aWNlICpuZGV2LA0KPiA+IHN0cnVjdCBldGh0b29sX3J4bmZjICpyeG5mYykNCj4gPiA+ICAJ
c3RydWN0IGVuZXRjX25kZXZfcHJpdiAqcHJpdiA9IG5ldGRldl9wcml2KG5kZXYpOw0KPiA+ID4g
IAlpbnQgZXJyOw0KPiA+ID4NCj4gPiA+ICsJaWYgKGlzX2VuZXRjX3JldjQocHJpdi0+c2kpKQ0K
PiA+ID4gKwkJcmV0dXJuIC1FT1BOT1RTVVBQOw0KPiA+ID4gKw0KPiA+ID4gIAlzd2l0Y2ggKHJ4
bmZjLT5jbWQpIHsNCj4gPiA+ICAJY2FzZSBFVEhUT09MX1NSWENMU1JMSU5TOg0KPiA+ID4gIAkJ
aWYgKHJ4bmZjLT5mcy5sb2NhdGlvbiA+PSBwcml2LT5zaS0+bnVtX2ZzX2VudHJpZXMpIEBAIC02
NzgsNg0KPiA+ID4gKzcxMSw5IEBAIHN0YXRpYyB1MzIgZW5ldGNfZ2V0X3J4Zmhfa2V5X3NpemUo
c3RydWN0IG5ldF9kZXZpY2UgKm5kZXYpDQo+ID4gPiB7DQo+ID4gPiAgCXN0cnVjdCBlbmV0Y19u
ZGV2X3ByaXYgKnByaXYgPSBuZXRkZXZfcHJpdihuZGV2KTsNCj4gPiA+DQo+ID4gPiBAQCAtODQz
LDggKzg5MCwxMiBAQCBzdGF0aWMgaW50IGVuZXRjX3NldF9jb2FsZXNjZShzdHJ1Y3QgbmV0X2Rl
dmljZQ0KPiA+ID4gKm5kZXYsICBzdGF0aWMgaW50IGVuZXRjX2dldF90c19pbmZvKHN0cnVjdCBu
ZXRfZGV2aWNlICpuZGV2LA0KPiA+ID4gIAkJCSAgICAgc3RydWN0IGtlcm5lbF9ldGh0b29sX3Rz
X2luZm8gKmluZm8pICB7DQo+ID4gPiArCXN0cnVjdCBlbmV0Y19uZGV2X3ByaXYgKnByaXYgPSBu
ZXRkZXZfcHJpdihuZGV2KTsNCj4gPiA+ICAJaW50ICpwaGNfaWR4Ow0KPiA+ID4NCj4gPiA+ICsJ
aWYgKGlzX2VuZXRjX3JldjQocHJpdi0+c2kpKQ0KPiA+ID4gKwkJcmV0dXJuIC1FT1BOT1RTVVBQ
Ow0KPiA+ID4gKw0KPiA+DQo+ID4gQ2FuIHlvdSBqdXN0IG5vdCBzZXQgZW5ldGNfcGZfZXRodG9v
bF9vcHMgaWYgaXQgaXMgaW14OTUgaW5zdGVhZCBvZiBjaGVjayBlYWNoDQo+ID4gZXRodG9vbHMg
ZnVuY3Rpb24/IG9yIHVzZSBkaWZmZXJlbmNlIGVuZXRjX3BmX2V0aHRvb2xfb3BzIGZvciBpbXg5
NT8NCj4gPg0KPiANCj4gRm9yIHRoZSBmaXJzdCBxdWVzdGlvbiwgaW4gdGhlIGN1cnJlbnQgcGF0
Y2gsIGkuTVg5NSBhbHJlYWR5IHN1cHBvcnRzIHNvbWUNCj4gZXRodG9vbCBpbnRlcmZhY2VzLCBz
byB0aGVyZSBpcyBubyBuZWVkIHRvIHJlbW92ZSB0aGVtLg0KPiANCj4gRm9yIHRoZSBzZWNvbmQg
cXVlc3Rpb24sIGZvciBMUzEwMjhBIGFuZCBpLk1YOTUsIHRoZSBsb2dpYyBvZiB0aGVzZSBldGh0
b29sDQo+IGludGVyZmFjZXMgaXMgYmFzaWNhbGx5IHRoZSBzYW1lLCB0aGUgZGlmZmVyZW5jZSBp
cyB0aGUgaGFyZHdhcmUgb3BlcmF0aW9uIHBhcnQuDQo+IEl0J3MganVzdCB0aGF0IHN1cHBvcnQg
Zm9yIGkuTVg5NSBoYXMgbm90IHlldCBiZWVuIGFkZGVkLiBCb3RoIHRoZSBjdXJyZW50DQo+IGFw
cHJvYWNoIGFuZCB0aGUgYXBwcm9hY2ggeW91IHN1Z2dlc3RlZCB3aWxsIGV2ZW50dWFsbHkgbWVy
Z2UgaW50byB1c2luZyB0aGUNCj4gc2FtZSBlbmV0Y19wZl9ldGh0b29sX29wcywgc28gSSBkb24n
dCB0aGluayB0aGVyZSBpcyBtdWNoIHByYWN0aWNhbCBwb2ludCBpbg0KPiBzd2l0Y2hpbmcgdG8g
dGhlIGFwcHJvYWNoIHlvdSBtZW50aW9uZWQuDQoNCkkgdGhvdWdodCBhYm91dCBpdCBhZ2Fpbiwg
eW91ciBzdWdnZXN0aW9uIGlzIG1vcmUgcmVhc29uYWJsZSBhbmQgZWFzaWVyIHRvDQp1bmRlcnN0
YW5kLiBJIHdpbGwgbWVyZ2UgdGhlIHR3byBlbmV0Y19wZl9ldGh0b29sX29wcyBpbnRvIG9uZSBh
ZnRlciBJDQpjb21wbGV0ZSB0aGUgc3VwcG9ydCBvZiBhbGwgZXRodG9vbCBpbnRlcmZhY2VzIG9m
IGkuTVg5NS4gVGhhbmtzLg0K

