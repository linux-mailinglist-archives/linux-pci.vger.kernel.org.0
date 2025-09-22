Return-Path: <linux-pci+bounces-36611-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CA8B8ED96
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 05:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 110E53AE5C9
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 03:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825BD2EC0BF;
	Mon, 22 Sep 2025 03:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AEYfnikM"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010047.outbound.protection.outlook.com [52.101.84.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B402572613;
	Mon, 22 Sep 2025 03:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758511235; cv=fail; b=qQM5YuC/uNoWB4UcVeh1YnkIQEYzzITEtHggN2Bc49Oyx45TYaqqsoHlOvrfzMRMpr9T+donZ9mX7q61J6XQMd0bC0VPQc2xnMPePBCIf/Vafk2n0z8lpnx9pv+n0aO0JAsIPHO7AZx4NzSWQR5eUc+K58heQw6+uMkE/lp4C/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758511235; c=relaxed/simple;
	bh=cccq+6adbk9p11WIc2bih3a2J9SY0kQouYA+3vU/KL4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q5jjbe/VsaPm1w/mmkH/qqM2ABUQY3HCw8lvTQ/u6IoMecpYzuQBzsby06xKaU/KLEn3WoPqXMgbWRfqHByk/CT4g9GAhICFjYKhI+gCzt5y9oDf19FZmuV18euCaCgG8//q/xr7EVFxDcsLoAw4SzGS+Os7oonYYUI9/vwFQt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AEYfnikM; arc=fail smtp.client-ip=52.101.84.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SYp9FPRpu6JATCBgKLGk8Lg9J3U3o7ytSR5X3CFUDUF/+sIzFJTvVBVUCiF4atJh5qWfmWQhTtiANHZIQPRleM3+jFbAQ3nu5H4vf5OcRGkzzAdqZvoR2Njus59mxnHUouHjnQXJiStpIILf3Rfl7fzCGrUykK0XFNxuPZpzBWiMfkgF1aTjv4V6EjDZu7eyuA/RA9jGA5n9DmFsrtNIe3Q6qOtw/KeYjBu675aXu8QlIcllLVwBwQxpwhQcnH0SDZccRpv0l1TbHPu8R6HE69GxP7ii691gvcqlZPmkYdjUq/Un6ogqRtAkVGGsimkQE2N3KaDzl6kiTxXSgJrS0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cccq+6adbk9p11WIc2bih3a2J9SY0kQouYA+3vU/KL4=;
 b=DwkDHY9bcog/QvOFcLCXejs+mz8Ddv9kJaP+WfajgGKaKFFWn5CPK/nk0+q4auxazQGjsHhvrl0nxUkhjWVva2LUQMG7RH93KzMjeqA8uF5zEa0gXo/6PyVhsi7vaEawtZ7mJrLk2Z/RkxBI5KxSxxWNTDcdQc/kPVTe3vPKy8UNvH0iTtgtkI5wgcwpkJzqnqAm6O2zPnSl3CHFJv6UC9a3Z7C0t/M788/i+HTyso9DaDOTeb3wudC8mm6pcfKwmYd84ZbqM5LldwseN1wpCwCOxcmprTKG6Y0PkXYLAFOL6ss5WqELVnV5Q2QMGGmGoCEs+07jWXnedaB+4WG3hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cccq+6adbk9p11WIc2bih3a2J9SY0kQouYA+3vU/KL4=;
 b=AEYfnikMi2rDUmJ8onmvEcDcC4ylFEXipBZcSwWkFveMSB4Duhcnb8g6ZnDNC4n97KPWapL7u25ROKEEkyLr5MoCLA10Pc2+2GAnruouFUwSWYpbkM9P4tiHTjEiliGg2pBdc00sFfm2OTzwttWgmwBH93ypz5gmcWsTBfJMkFbFpkgqRzdgGWLPtcClrmQKVOwGFF/p4S4JOFtiGFmWEIQraW2AI9JAbD5tDBSZS6AwFl91WYg5Do7fPZYvRvGe96IMacBHxWxtrl+2ZDL0rgu0uf0rkV+9XTcnghgvIG50eq5hxfw4mnz8VRKkvfVXvEn+pUxD8fzP30XKK0OfKA==
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by GV4PR04MB11354.eurprd04.prod.outlook.com (2603:10a6:150:29d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Mon, 22 Sep
 2025 03:20:25 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%3]) with mapi id 15.20.9160.008; Mon, 22 Sep 2025
 03:20:25 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>
CC: Frank Li <frank.li@nxp.com>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v7 0/3] PCI: imx6: Add external reference clock mode
 support
Thread-Topic: [PATCH v7 0/3] PCI: imx6: Add external reference clock mode
 support
Thread-Index: AQHcKEwPRqWkZQcvLEGtRa12/Ub2LLSbsqIAgALZUAA=
Date: Mon, 22 Sep 2025 03:20:25 +0000
Message-ID:
 <AS8PR04MB8833D7089BF1266786B2A9478C12A@AS8PR04MB8833.eurprd04.prod.outlook.com>
References: <20250918032555.3987157-1-hongxing.zhu@nxp.com>
 <o3pajmedldkgpmqrnnnoz5nrbx6dz7vnodlpuc6tivbxvln6lf@nxuvdtqoixdx>
In-Reply-To: <o3pajmedldkgpmqrnnnoz5nrbx6dz7vnodlpuc6tivbxvln6lf@nxuvdtqoixdx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8833:EE_|GV4PR04MB11354:EE_
x-ms-office365-filtering-correlation-id: 7115de8f-442d-43b9-8fde-08ddf986f8c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|1800799024|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?N0Ewb2k1ZXlQQzFGUndTc2crT0wxM2xCYXU5WStCeWF4anBhWnRGSlF3ZERY?=
 =?utf-8?B?WUQzT3ZJQnlBcStkeHRScHByRjVDQnRWUC9INGx0bWo0R1NPM2ZWaUlNRk5q?=
 =?utf-8?B?eHAzVzc3R0N6M0pRaEdOQU9yR29KM090VGxGK0tRbXZiSllyRDAxSmVxZEw2?=
 =?utf-8?B?QWlzS1FJVGlzVlBLN1B5TmhvVEVIZStpYk9LNW1MMlFWTWswRE9MdDB0V21I?=
 =?utf-8?B?VC8yY2ZXditxZnNmQzRzRzV5Yk40TVdTVUNvRnVtTzBYZUc0NnRlVkJpRzht?=
 =?utf-8?B?MVJOQTlseVdUWEk3T0lURDVMcnh2M2xPWG11SEVrVDRmR212bm9NS3E2clk1?=
 =?utf-8?B?SitpTmNVZytNaEhLTlN4K3pJdTRXYk9xVHBCMHlqcnhiOGNhbnI0TUQ1eXpi?=
 =?utf-8?B?cHVWS3N3dThTTm5vbzByZFExNjk5RUcvVWlFcUk2MmlEMkJ2Vk00bmZTMHYv?=
 =?utf-8?B?N29pRjNJNTFISjM1djdybmg0b1dnZGRFQk5BN25Pb1E3RGhJdVF6bGJvMDJh?=
 =?utf-8?B?cmNYSGdTeFdQbG9QeUw3bGhaS1hOOW5iTlZwQ2haaEFnaEdQcXlEdHlzZlV3?=
 =?utf-8?B?bWxlSTlpUEFGL2lwNFdkUW5McGc4R0FBbU1RNDdxVkZTaTh4bFNLYVVhZlpv?=
 =?utf-8?B?SG1nU2JXMnRFeFJHdFRUV1BBTXlRbzg1VGVsNlNZVTQzYmpzODJCUk1HNHZh?=
 =?utf-8?B?eXhGM2Q0eUcrdlhzTnNKaFk4VHE5L1NmMGNGOFoxbENmcUh4K2FrTlpDWU1j?=
 =?utf-8?B?WUthQ2l1YzlOek1JS3RKbFhuZmVHVjkxcGszc1luaGpBNWE0aHZKbmNKQWpV?=
 =?utf-8?B?aGtxM0hTWDg3blJZT2Qvbm01cUcxUUowbDZZWmpwdmo5UnRGNG82U0lKejZC?=
 =?utf-8?B?cG1BOTFOckJVMXJYRG1EcHZWSFQ4dDhtNitaelNrNzBacW5DbGZvQ29HUzZj?=
 =?utf-8?B?Ry94TFEwTm9YbXcrbnpCTXhqRitjMEdtVVRaYVRRbVBjNm9XVGJ6R3V3MVlu?=
 =?utf-8?B?dU5RMUxySlgrc2tvVE5kNVc1UFdHQWhvYW1RLzZXTW5OdFhGbXFyWFdISllH?=
 =?utf-8?B?cDQ3YmZwc1o2ZFFwUXdMOXhGOXJjQWtFOEl0MXg5RzJGN3BXaytqRXJacXI3?=
 =?utf-8?B?SjZhN3ZLelkvMlM4UGpUeHRHZk1EZzJGcEVRRVlwbHREYnZWdG5VV08vMVkw?=
 =?utf-8?B?VHZ3SEwzbGpYczlIN1UrNUMvTFBpenlxaThlUlJCOUc0b3had2Jzd3lPY0pY?=
 =?utf-8?B?SXlLSHFhZ0F2eEZwNFgyM3BuWjhIVTNsVWdjM1hLTHpRc0F2ZUlBY25SOGs5?=
 =?utf-8?B?T0VJeGpHU3lqWkkxU3lpMnlqVWlhUElYTGpCejY1eDUzYmhZbXB0dTcrRkpF?=
 =?utf-8?B?OU5lMzBSVkt3SG1KKy9aU0xUZ0R4Yi9ycGREQ1MxQ3dzTGxKemN5R1U1ZnN2?=
 =?utf-8?B?RHpVeTU3cy9PRG5BWGRCS1RqTlJ2OUg0bmJVQXErQ2IreE50NDIzMFVHYTNZ?=
 =?utf-8?B?b1l5dWcraHVzaGwrVnhqYi9aNTA1YUhlbDJwMEJYS3NMZ281U2ZtLzJTVE9o?=
 =?utf-8?B?UHhUUk9yeU15cWExTlE4aUg2MjE3bjhYYVBkUTlXaTY0R1pHSlZnTHZCV1Rs?=
 =?utf-8?B?V1VQYmJwUTd1Um9Bamlwd2R4RnhpUU9hVzNNTWxMVnZSTm5YeFBLb2pKWm11?=
 =?utf-8?B?TkxpN01TQUN4NjFlWWdWM1RaYW5YUDI3c21DNFpqUEQ0Wm5FNE5DNUJlUU1x?=
 =?utf-8?B?WnY1Qkc5dE5jNmdXdER2R0VMaEZ0eDhWZDdOTHFkSEczeTFxRnpLQWJ1c3ht?=
 =?utf-8?B?Z2dMWTZKT2NJVzBkS1daUEFMcTMxN1JuQ2tCSkhkdngraE5wSkUwM3FrOUh1?=
 =?utf-8?B?MnZjdnNhTG5WK3dmU1BXMFl3U2ZURHEreFJGQlVnbUd0OTZnUGNRNkczSGZr?=
 =?utf-8?B?cU1pYnoydisvUWtySmQvUG1CQVIrYUJ4R3ZycFFSYnkyT3RTWTBvdzJJeDMw?=
 =?utf-8?B?WXZVc1BNYnNnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N0VYaGhoQ3FXUmo4ZTIvTjlWb2sxTjgzSWgrODVNeSsxRFhWUGw2YjFrWHJT?=
 =?utf-8?B?aCtHVk85dUZyUlIrWWNwbUZ1RjY2clBCRDZEUURMTTFSdmI1T3FwZUdVNlMy?=
 =?utf-8?B?cy9UYzRkNWpYTGdmVEFpUkR3RklFZlFPeWZSUUhHRHMrQk1JNmR1endyQnYr?=
 =?utf-8?B?QmFzVDgvKzVOcGVXUHhzVW5yNDNEZlJMMGp2L3c3TEMxellkMDNVUFlxeU4r?=
 =?utf-8?B?eUQ4cG9QUkVWL01LaFdiREh3VnZUQ1haMXVUSmVmTkNMR3NGWE1xdnNCdlMv?=
 =?utf-8?B?MTFMTTNLUkRwdkRiTHJ1Z3p3TUpoSUoya3ZBRjNPZkdnVFFzdUVScDc1UWxS?=
 =?utf-8?B?Z1Vpa1pSMWx6MUpIYzd3VjhEeDl5SGp3Zi9oeFd1OHRYZ2p0czRvVmNoeWNM?=
 =?utf-8?B?ZjUvTlFQb01uVGppUUpIMVlXS0VyMWQrU2kzblRKQkw0ZnUrajFFbDdkWnVI?=
 =?utf-8?B?c3RldTkycTRwZUNUWHowQnZZM3BsblBEU1oxQlJIT1JEWW1sM3FZOUpCUmxY?=
 =?utf-8?B?Z0NvaEQ3RVUyc2xmWitKWEZaclRFei9GYUVxbkxMWEszbmFnWm9wUlh0TE15?=
 =?utf-8?B?MlhxSTRwREUyT0IyMWJDa1BOOERabmIwMXE2Qk9aeGVKN3cvclpsZnVwZnJY?=
 =?utf-8?B?dlBpZlU2YnNuN0dMNDZ3NWE2KzVUcWZrTlBKSllOZXpQM0NGMmtxcEo5aG92?=
 =?utf-8?B?UmIrbXc1eTc4eDAvNStaVHhzM2lGNTBMSmcySWhyTlNKU2Q2aVF1U3RnM0dB?=
 =?utf-8?B?UmtGSUZ0b1BYZWNZRlVLN3pDYmc2d0tQQ1R1YnZsVzF2MkVyVU1KdVMrdjVF?=
 =?utf-8?B?b25hOUhhWFZOZ1QxNG5ZQ25vME1oZUxuUjRQV2VzVTI3elBKRUp5SlhXc1RH?=
 =?utf-8?B?RHVxcnNZZVplNzdFdjZsTjZhMVZ0QnBnZ1htTjhZeVhKRktRR0RLa0h6ZXpC?=
 =?utf-8?B?VXZmNlg3QWVkTzVuclZ2bEs0TmdrbldudE1NeEhiVllZWHpsTEFRWVZyNVlH?=
 =?utf-8?B?ZDRuN203QWdJSlh3RmtnWWdkWnN2MnQzbGNmWE41RkFCclBBL2hJOVQ1WU5H?=
 =?utf-8?B?b3Q1UjJkOGdndmpUVS85aEZmQ25ieDNXVElaNzNuNERuNmhxWFBNd0FGUWZz?=
 =?utf-8?B?VVVpVVBiZFBxeWNDaE94RG1NbmlUdS9OT0VtSS9MRHViUzZkYmpDbW1pTFk3?=
 =?utf-8?B?RWZ2VFRuUU1IZkpabEwra0dtSGVINTVxU01odEsweGRrck5JV042QXhWckhT?=
 =?utf-8?B?d2R5Y3lSK2lZeklyRk9DNi9KeVBEUWRzVWxMSUY5Tncya2d2TGhoSE55WjU1?=
 =?utf-8?B?RUQ2aUc0MWFHUjZ6V3dGdWFVZzdjSUEyUG5WY2hnZHRNV3hDMFp4WVVzalNS?=
 =?utf-8?B?aXpOU3NQZG5XQkpIS0NmSVBmVWJVS2xkTktUejNQd2IzQ0FFS3JQZ3pWUEtm?=
 =?utf-8?B?ZS9Hd0MzaEd0TjZnK2JtUnFTa3o3eEZTOHlURUVVZFRCUG5McitrSTNENTlj?=
 =?utf-8?B?cFVEVkN3YXF3S0QvQlljYXhoZEQ4elRaMGptTGxldG1qNkNORURrR2ljTFRY?=
 =?utf-8?B?dVdzdzBnVEh5ei9BUTNNQStnSVdwTFZQT3lUU3VhcU9oZllNQUJQVWdXWHR3?=
 =?utf-8?B?T2NleGVUb0YraHk1YUE0eGhNSmxGNVdESEN4cEFmMmkxWktjTVM2K2FidTdJ?=
 =?utf-8?B?RHlYSnlkcDY3RUtRQlVQODlvVyt2TzI1a3lWendEc0x3b1preHF5dXNmVG4z?=
 =?utf-8?B?bVBUVDVJd2hUZXVQTGJQdE1SZjhLcmhGYy8rWUs4V0d2bVdjS3ZRdm1QckRE?=
 =?utf-8?B?aDdoZWtNSmRPTXMzU1p1QmJSY2lETHR1YU1sYUNOWjgvTDNQNkJKVTZpQXhV?=
 =?utf-8?B?VldMQ0J6VDN3SU1aZE42aVR0TGhYNS9vSnV4aXpjMGJxZ05GU0Y1TVVHUTJh?=
 =?utf-8?B?U0h5dHpicmRjbmlJdUZFOWJTZkdPWUxKRy90NmtTbnR6RW9kTS9wdDdrVzFQ?=
 =?utf-8?B?WWFCQW10UTBxU2tFb05ibUZxc1lKOW9PaG4zTmRDWVpybDg5OWdMYnRHOHNq?=
 =?utf-8?B?N21DNWtrN1N1MTVWQU51R0xsdTJ5VFdBYWxsakJ6algwQnpqWmg3Z2p2KzU5?=
 =?utf-8?Q?/wUg=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7115de8f-442d-43b9-8fde-08ddf986f8c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2025 03:20:25.1338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lcw/FZThEo5jNgpQZ4mDeeyFaUMsdFOgC423H2YpZnSOuxN64NmiWyDnJ/YRDVhJWDsyc2fzuu1XkRTGyGp7gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11354

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2
YW0gPG1hbmlAa2VybmVsLm9yZz4NCj4gU2VudDogMjAyNeW5tDnmnIgyMOaXpSAxNTozOQ0KPiBU
bzogSG9uZ3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IEZyYW5rIExpIDxm
cmFuay5saUBueHAuY29tPjsgbC5zdGFjaEBwZW5ndXRyb25peC5kZTsgbHBpZXJhbGlzaUBrZXJu
ZWwub3JnOw0KPiBrd2lsY3p5bnNraUBrZXJuZWwub3JnOyByb2JoQGtlcm5lbC5vcmc7IGtyemsr
ZHRAa2VybmVsLm9yZzsNCj4gY29ub3IrZHRAa2VybmVsLm9yZzsgYmhlbGdhYXNAZ29vZ2xlLmNv
bTsgc2hhd25ndW9Aa2VybmVsLm9yZzsNCj4gcy5oYXVlckBwZW5ndXRyb25peC5kZTsga2VybmVs
QHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207DQo+IGxpbnV4LXBjaUB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gZGV2aWNl
dHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGlteEBsaXN0cy5saW51eC5kZXY7IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NyAwLzNdIFBDSTogaW14Njog
QWRkIGV4dGVybmFsIHJlZmVyZW5jZSBjbG9jayBtb2RlDQo+IHN1cHBvcnQNCj4gDQo+IE9uIFRo
dSwgU2VwIDE4LCAyMDI1IGF0IDExOjI1OjUyQU0gKzA4MDAsIFJpY2hhcmQgWmh1IHdyb3RlOg0K
PiA+IGkuTVg5NSBQQ0llcyBoYXZlIHR3byByZWZlcmVuY2UgY2xvY2sgaW5wdXRzOiBvbmUgZnJv
bSBpbnRlcm5hbCBQTEwsDQo+ID4gdGhlIG90aGVyIGZyb20gb2ZmIGNoaXAgY3J5c3RhbCBvc2Np
bGxhdG9yLiBUaGUgImV4dHJlZiIgY2xvY2sgcmVmZXJzDQo+ID4gdG8gYSByZWZlcmVuY2UgY2xv
Y2sgZnJvbSBhbiBleHRlcm5hbCBjcnlzdGFsIG9zY2lsbGF0b3IuDQo+ID4NCj4gPiBBZGQgZXh0
ZXJuYWwgcmVmZXJlbmNlIGNsb2NrIGlucHV0IG1vZGUgc3VwcG9ydCBmb3IgaS5NWDk1IFBDSWVz
Lg0KPiA+DQo+IA0KPiBEcml2ZXIgY2hhbmdlIGxvb2tzIGdvb2QgdG8gbWUgKGV4Y2VwdCBhIG5p
dHBpY2sgdGhhdCBJIHJlcG9ydGVkLCBidXQgSSBjb3VsZCBmaXgNCj4gaXQgd2hpbGUgYXBwbHlp
bmcpLCBidXQgdGhlIGJpbmRpbmcgcGF0Y2hlcyBuZWVkIHRvIGJlIHJldmlld2VkIGJ5IHRoZSBE
VA0KPiBiaW5kaW5nIG1haW50YWluZXJzLg0KSGkgTWFuaToNClRoYW5rcyBhIGxvdCBmb3IgeW91
ciBraW5kbHkgaGVscC4NCg0KSGkgS3J6eXN6dG9mOg0KQ2FuIHlvdSBoZWxwIHRvIHRha2UgYSBs
b29rIGF0IHRoZSBmaXJzdCB0d28gZHQtYmluZGluZyBwYXRjaGVzPw0KU29ycnkgdG8gc2VuZCBv
dXQgdGhpcyBwYXRjaC1zZXQgbGF0ZSwgYmVjYXVzZSB0aGF0IEkgbWlzLXVuZGVyc3Rvb2QNCiB3
aGF0J3MgeW91ciBtZWFucyBpbiB0aGUgcHJldmlvdXMgcmV2aWV3IGFyb3VuZC4NCg0KQmVzdCBS
ZWdhcmRzDQpSaWNoYXJkIFpodQ0KPiANCj4gLSBNYW5pDQo+IA0KPiA+IE1haW4gY2hhbmdlIGlu
IHY3Og0KPiA+IC0gUmVmaW5lIHRoZSBzdWJqZWN0cyBhbmQgY29tbWl0IG1lc3NhZ2UgcmVmZXIg
dG8gQmpvcm4ncyBjb21tZW50cy4NCj4gPg0KPiA+IE1haW4gY2hhbmdlIGluIHY2Og0KPiA+IC0g
UmVmZXIgdG8gS3J6eXN6dG9mJ3MgY29tbWVudHMsIGxldCBpLk1YOTUgUENJZXMgaGFzIHRoZSAi
cmVmIiBjbG9jaw0KPiA+ICAgc2luY2UgaXQgaXMgd2lyZWQgYWN0dWFsbHksIGFuZCBhZGQgb25l
IG1vcmUgb3B0aW9uYWwgImV4dHJlZiIgY2xvY2sNCj4gPiAgIGZvciBpLk1YOTUgUENJZXMuDQo+
ID4gaHR0cHM6Ly9ldXIwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0
dHBzJTNBJTJGJTJGbG9yZQ0KPiA+IC5rZXJuZWwub3JnJTJGaW14JTJGMjAyNTA5MTcwNDUyMzgu
MTA0ODQ4NC0xLWhvbmd4aW5nLnpodSU0MG54cC5jbw0KPiBtJTJGDQo+ID4NCj4gJmRhdGE9MDUl
N0MwMiU3Q2hvbmd4aW5nLnpodSU0MG54cC5jb20lN0MyOTZmYWE0ZDFmYzE0NDA0NmNlMDA4ZA0K
PiBkZjgxOGMNCj4gPg0KPiA3MDUlN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3
QzAlN0MwJTdDNjM4OTM5NTA3NDk3NDENCj4gMTI2MSU3Qw0KPiA+DQo+IFVua25vd24lN0NUV0Zw
Ykdac2IzZDhleUpGYlhCMGVVMWhjR2tpT25SeWRXVXNJbFlpT2lJd0xqQXVNREF3DQo+IE1DSXNJ
bEFpDQo+ID4NCj4gT2lKWGFXNHpNaUlzSWtGT0lqb2lUV0ZwYkNJc0lsZFVJam95ZlElM0QlM0Ql
N0MwJTdDJTdDJTdDJnNkYXRhPUINCj4gR2p6bTkNCj4gPiAlMkZDbEZYTlc5Y01OWVhJcHM2THd3
eEJ4JTJGWCUyQnpYJTJCMU5qaWp3MjAlM0QmcmVzZXJ2ZWQ9MA0KPiA+DQo+ID4gTWFpbiBjaGFu
Z2UgaW4gdjU6DQo+ID4gLSBVcGRhdGUgdGhlIGNvbW1pdCBtZXNzYWdlIG9mIGZpcnN0IHBhdGNo
IHJlZmVyIHRvIEJlam9ybidzIGNvbW1lbnRzLg0KPiA+IC0gQ29ycmVjdCB0aGUgdHlwbyBlcnJv
ciBhbmQgdXBkYXRlIHRoZSBkZXNjcmlwdGlvbiBvZiBwcm9wZXJ0eSBpbiB0aGUNCj4gPiAgIGZp
cnN0IHBhdGNoLg0KPiA+IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9v
ay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxvcmUNCj4gPiAua2VybmVsLm9yZyUyRmlteCUyRjIw
MjUwOTE1MDM1MzQ4LjMyNTIzNTMtMS1ob25neGluZy56aHUlNDBueHAuY28NCj4gbSUyRg0KPiA+
DQo+ICZkYXRhPTA1JTdDMDIlN0Nob25neGluZy56aHUlNDBueHAuY29tJTdDMjk2ZmFhNGQxZmMx
NDQwNDZjZTAwOGQNCj4gZGY4MThjDQo+ID4NCj4gNzA1JTdDNjg2ZWExZDNiYzJiNGM2ZmE5MmNk
OTljNWMzMDE2MzUlN0MwJTdDMCU3QzYzODkzOTUwNzQ5NzQzDQo+IDY5NTElN0MNCj4gPg0KPiBV
bmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlKRmJYQjBlVTFoY0draU9uUnlkV1VzSWxZaU9pSXdMakF1
TURBdw0KPiBNQ0lzSWxBaQ0KPiA+DQo+IE9pSlhhVzR6TWlJc0lrRk9Jam9pVFdGcGJDSXNJbGRV
SWpveWZRJTNEJTNEJTdDMCU3QyU3QyU3QyZzZGF0YT1TDQo+IE5INWtUDQo+ID4gdUoyUWoxV1dS
RCUyRm9taldTMW5aT3hTamN3MW9mJTJGV0cyTFBheWMlM0QmcmVzZXJ2ZWQ9MA0KPiA+DQo+ID4g
TWFpbiBjaGFuZ2UgaW4gdjQ6DQo+ID4gLSBBZGQgb25lIG1vcmUgcmVmZXJlbmNlIGNsb2NrICJl
eHRyZWYiIHRvIGJlIG9uaGFsZiB0aGUgcmVmZXJlbmNlIGNsb2NrDQo+ID4gICB0aGF0IGNvbWVz
IGZyb20gZXh0ZXJuYWwgY3J5c3RhbCBvc2NpbGxhdG9yLg0KPiA+IGh0dHBzOi8vZXVyMDEuc2Fm
ZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxvcmUNCj4g
PiAua2VybmVsLm9yZyUyRmlteCUyRjIwMjUwNjI2MDczODA0LjMxMTM3NTctMS1ob25neGluZy56
aHUlNDBueHAuY28NCj4gbSUyRg0KPiA+DQo+ICZkYXRhPTA1JTdDMDIlN0Nob25neGluZy56aHUl
NDBueHAuY29tJTdDMjk2ZmFhNGQxZmMxNDQwNDZjZTAwOGQNCj4gZGY4MThjDQo+ID4NCj4gNzA1
JTdDNjg2ZWExZDNiYzJiNGM2ZmE5MmNkOTljNWMzMDE2MzUlN0MwJTdDMCU3QzYzODkzOTUwNzQ5
NzQ1DQo+IDI0MTYlN0MNCj4gPg0KPiBVbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlKRmJYQjBlVTFo
Y0draU9uUnlkV1VzSWxZaU9pSXdMakF1TURBdw0KPiBNQ0lzSWxBaQ0KPiA+DQo+IE9pSlhhVzR6
TWlJc0lrRk9Jam9pVFdGcGJDSXNJbGRVSWpveWZRJTNEJTNEJTdDMCU3QyU3QyU3QyZzZGF0YT04
DQo+IGpkdVBXDQo+ID4gRzJlTmFPMkRIM3lRZklQMkpNJTJGM0dOY1IzSGVYSllEM0ZXWDJJJTNE
JnJlc2VydmVkPTANCj4gPg0KPiA+IE1haW4gY2hhbmdlIGluIHYzOg0KPiA+IC0gVXBkYXRlIHRo
ZSBsb2dpYyBjaGVjayBleHRlcm5hbCByZWZlcmVuY2UgY2xvY2sgbW9kZSBpcyBlbmFibGVkIG9y
DQo+ID4gICBub3QgaW4gdGhlIGRyaXZlciBjb2Rlcy4NCj4gPiBodHRwczovL2V1cjAxLnNhZmVs
aW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsb3JlDQo+ID4g
Lmtlcm5lbC5vcmclMkZpbXglMkYyMDI1MDYyMDAzMTM1MC42NzQ0NDItMS1ob25neGluZy56aHUl
NDBueHAuY29tDQo+ICUyRiYNCj4gPg0KPiBkYXRhPTA1JTdDMDIlN0Nob25neGluZy56aHUlNDBu
eHAuY29tJTdDMjk2ZmFhNGQxZmMxNDQwNDZjZTAwOGRkZg0KPiA4MThjNw0KPiA+DQo+IDA1JTdD
Njg2ZWExZDNiYzJiNGM2ZmE5MmNkOTljNWMzMDE2MzUlN0MwJTdDMCU3QzYzODkzOTUwNzQ5NzQ2
Nw0KPiAxNjklN0NVDQo+ID4NCj4gbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlKRmJYQjBlVTFoY0dr
aU9uUnlkV1VzSWxZaU9pSXdMakF1TURBd00NCj4gQ0lzSWxBaU8NCj4gPg0KPiBpSlhhVzR6TWlJ
c0lrRk9Jam9pVFdGcGJDSXNJbGRVSWpveWZRJTNEJTNEJTdDMCU3QyU3QyU3QyZzZGF0YT1pSw0K
PiB3bGdxeQ0KPiA+IGs5bXRsNm40OEU4bXdQTFh3MWtXTXRhdGMzajA4NFRFcWVQTSUzRCZyZXNl
cnZlZD0wDQo+ID4NCj4gPiBNYWluIGNoYW5nZSBpbiB2MjoNCj4gPiAtIEZpeCB5YW1sbGludCB3
YXJuaW5nLg0KPiA+IC0gUmVmaW5lIHRoZSBkcml2ZXIgY29kZXMuDQo+ID4gaHR0cHM6Ly9ldXIw
MS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbG9y
ZQ0KPiA+IC5rZXJuZWwub3JnJTJGaW14JTJGMjAyNTA2MTkwOTEwMDQuMzM4NDE5LTEtaG9uZ3hp
bmcuemh1JTQwbnhwLmNvbQ0KPiAlMkYmDQo+ID4NCj4gZGF0YT0wNSU3QzAyJTdDaG9uZ3hpbmcu
emh1JTQwbnhwLmNvbSU3QzI5NmZhYTRkMWZjMTQ0MDQ2Y2UwMDhkZGYNCj4gODE4YzcNCj4gPg0K
PiAwNSU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3QzAlN0M2Mzg5Mzk1
MDc0OTc0ODINCj4gNjk4JTdDVQ0KPiA+DQo+IG5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SkZiWEIw
ZVUxaGNHa2lPblJ5ZFdVc0lsWWlPaUl3TGpBdU1EQXdNDQo+IENJc0lsQWlPDQo+ID4NCj4gaUpY
YVc0ek1pSXNJa0ZPSWpvaVRXRnBiQ0lzSWxkVUlqb3lmUSUzRCUzRCU3QzAlN0MlN0MlN0Mmc2Rh
dGE9QVMNCj4gdnk2WCUNCj4gPiAyQllyemV5am9BdnRHQnhIdTNsQndNWG1TdklxZFVFRFNvZklo
YyUzRCZyZXNlcnZlZD0wDQo+ID4NCj4gPiBbUEFUQ0ggdjcgMS8zXSBkdC1iaW5kaW5nczogUENJ
OiBkd2M6IEFkZCBleHRlcm5hbCByZWZlcmVuY2UgY2xvY2sNCj4gPiBbUEFUQ0ggdjcgMi8zXSBk
dC1iaW5kaW5nczogUENJOiBwY2ktaW14NjogQWRkIGV4dGVybmFsIHJlZmVyZW5jZQ0KPiA+IFtQ
QVRDSCB2NyAzLzNdIFBDSTogaW14NjogQWRkIGV4dGVybmFsIHJlZmVyZW5jZSBjbG9jayBpbnB1
dCBtb2RlDQo+ID4NCj4gPiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL2Zz
bCxpbXg2cS1wY2llLnlhbWwgICAgICB8ICAzICsrKw0KPiA+IERvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9wY2kvc25wcyxkdy1wY2llLWNvbW1vbi55YW1sIHwgIDYNCj4gKysrKysr
DQo+ID4gZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYyAgICAgICAgICAgICAg
ICAgICAgICAgICAgfCAyMA0KPiArKysrKysrKysrKysrLS0tLS0tLQ0KPiA+IDMgZmlsZXMgY2hh
bmdlZCwgMjIgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4gPg0KPiANCj4gLS0NCj4g
4K6u4K6j4K6/4K614K6j4K+N4K6j4K6p4K+NIOCumuCupOCuvuCumuCuv+CuteCuruCvjQ0K

