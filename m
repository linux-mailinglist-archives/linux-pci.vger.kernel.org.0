Return-Path: <linux-pci+bounces-43826-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C15CE8CB3
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 07:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D867F3010FDF
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 06:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159E523BCED;
	Tue, 30 Dec 2025 06:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZVZRV6Dc"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011044.outbound.protection.outlook.com [52.101.65.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29961D86FF;
	Tue, 30 Dec 2025 06:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767076316; cv=fail; b=TgjcXi+YkaUHN1eGBkMhIpk//1qHwjp0Pj5I1amShNZjmikMY+YQx6g3/2Atf39z1C9DgABHFEOEWgXW67Q7WHAO8j7pPoBWA3/lCO9HZkyvRQQzbTYYHTqb+zgAoLJcqA79Ure6XnskBlpx9diT4FdWaxph+gBxYj1my9Y95t4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767076316; c=relaxed/simple;
	bh=tU/EEyG4GeLn1/VrfbmoeHrzp9769TWcVeum8hVZu80=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J7jTY5J6qZDU5KeH0xOrgdYo1St6GBhjOL1dt7N6VirFe03Ff+wUkDAPI7jC0D4KyhqwKYUWb+W42LtcYK0GB07F5m5PsIZ5TVlD9xOJ915X37qOYtiuxS1xPmDdpos3wuuEmhrl+5JEJ0NiwrtYJftLJ5lH6jXF5thedc+yWuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZVZRV6Dc; arc=fail smtp.client-ip=52.101.65.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lmBl7sdpFQri2f4D1RE0G+9fksS5jjvuhQR/+vaZ0CQr77j0LZxYNNriUGt4/13luJoTqKp9Obrg/cS9TCh3zhBShjZ1mlrbhnCkv7DKgCN6XxNQNK0eGd3aeciFD5KRTCkkERnrpRJw99C3WPtr6Hx8pLCqjPsnZyjvg6desKXbIDFkEv9RnRaaYmotS+JWHSgUPyzQRIXrPRbrd0zYTNaK8Ask7m1MoVP4dvm/SbS7cOF7SIpN5YhkZApk9FDtfciH9LLgMHkEOfTAYP3194EFb7nWpoymMAGsW0L9Cmgg8X25Y0tdU526PLjrzARVT8ErGxss4A4+fQufBY5r7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tU/EEyG4GeLn1/VrfbmoeHrzp9769TWcVeum8hVZu80=;
 b=ZAa2DqLo69WBxN8ByTpwdVvyUJM+RjvAVO75tu9497TfxRxuirDxfu/W65H4qmq6gNvlf5W+uv8Pkm5HDmoIPIARLHKxjydaiMfUYlFadsRJUzVlEIaenSgFEoCiH8BGnXOXATWyUzCK9xF4r6s4PAgtxaQbqBor3B8UL6wOtBkeiy8GEQYqkV2yPXj7g76QrZk0g5tPiNRTnRUbQQ0Q4qgcZsEv991RGA4NniHQLIazxRT6oJZtgMfTdGUBdlIkSivvODUit+0skpz4qKYjKm6PyfyHKxjEdmmw8EPXZAN/4DioSuo+S+e77rlUNisqQablh0DXa3KugVGuTi4bbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tU/EEyG4GeLn1/VrfbmoeHrzp9769TWcVeum8hVZu80=;
 b=ZVZRV6DcEt1ixEjytdzbvn72O+V6426H/3NvtElB7dVoV1YviDGHXt+K/GCt9T8m+0k+1oXHNnwMIU6sr/tdYQgDqCAuVid5UVd4QfzxFMZNNyIYKff7Jek2u9AnTmD1V/Ucw9OSKk2jTM9t7ObwfJXd8HSwdE72g454oqsCc3Nc2GFs7qKN9DhxFmv7bt0VEilUvdND5MnwVBqTskViCUdApxFWN8t64BKPQTTXW9DWAkXLOL8vsn772cMFnQwPCyr+OjKSfR6rMe4z6W+JcPwdFj8dVWOYWXKD03LDO12Qj5is+f6MJy0olFfLz9ie7IYS8gLKZhFpfB+0vsK4Dw==
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by GV1PR04MB10871.eurprd04.prod.outlook.com (2603:10a6:150:205::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 30 Dec
 2025 06:31:48 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%7]) with mapi id 15.20.9456.013; Tue, 30 Dec 2025
 06:31:48 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, Frank Li <frank.li@nxp.com>,
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v10 4/4] arm64: dt: imx95: Add the missed ref clock for
 PCIe[0,1]
Thread-Topic: [PATCH v10 4/4] arm64: dt: imx95: Add the missed ref clock for
 PCIe[0,1]
Thread-Index: AQHcampFp3Vkyu7+PEuVstz2a4ALQbU5o9cAgAAytqA=
Date: Tue, 30 Dec 2025 06:31:47 +0000
Message-ID:
 <AS8PR04MB8833950FABA4829299CA3D6E8CBCA@AS8PR04MB8833.eurprd04.prod.outlook.com>
References: <20251211064821.2707001-1-hongxing.zhu@nxp.com>
 <20251211064821.2707001-5-hongxing.zhu@nxp.com> <aVNG0BjbEVHhgNCa@dragon>
In-Reply-To: <aVNG0BjbEVHhgNCa@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8833:EE_|GV1PR04MB10871:EE_
x-ms-office365-filtering-correlation-id: ed98a638-c8e0-47be-ffa8-08de476d1c0b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|7416014|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?gb2312?B?cnhJRWpQbGxPVExxN0ZzWTJ4YmNhMGlPMUZZWDh1NWdINS9zcDN5cU1NNHl6?=
 =?gb2312?B?QzgyRnBXNUNqcnpBSEhZSnRqK0dKTDE1RU0wampYcDE4R3drSE5YWW9oc20v?=
 =?gb2312?B?VTZDS2VFcnV0dGo3V0NIQ3RmOFlqbHBlVXdpemFsTDU0ckZhcWU4b0xKdXR4?=
 =?gb2312?B?d3lQMHovOVRSdVVVdnJ4RkNCbkNpVEE3dDZuZXNLbXlXbElZU0FidDhUeUUw?=
 =?gb2312?B?MUozVFNPT0RCa1ljWkpYcHhDZG1SR0hHVGFlZFVib1Fjd05tUTlRTmRqWWtw?=
 =?gb2312?B?SEM2bjdXS1kxSlpRaWRvekZJNmxpb21XVUMrbVdrdjUzaTNCQzM1aVdQTzV2?=
 =?gb2312?B?ZjFuUHlEOEtMS0xVZGFMcy9XTGtEbE9laE1pSWVYQVlYbzh6aVdpREduOVd3?=
 =?gb2312?B?S2QxZndBMHF0d2F2b09vNHZuVkVIdnZHLzB6cXFHVG4vc09vOVN2bUk5QzNa?=
 =?gb2312?B?MlA0akpLT01DM1M2ZzNJdDRUMzlzbldVdjMrb2I5QjJyZ2xrVFB5SXEwSTdJ?=
 =?gb2312?B?ZGdRNDFaQ0FTSXdMVnEvMk9TdXVaM0k3eFRTb3lMRXVZM0hBbUtGRlZtbVN1?=
 =?gb2312?B?ZDdLN3M1SFI2Q3JsczBkVG1hT1BLNmthMzg2OUMxNVp6dkNSd0NWNjZubHIy?=
 =?gb2312?B?djJGZTMyY2V0VDV0TTRyTDU2ZmNkV0xyN29KRThXQVlINmdTeUczaUJFMVh1?=
 =?gb2312?B?SHR2Z2NmbGJ5S2t5NWZIbUhUUnB4WDZpMllZZjdZUVlCMzROejNTQkZDcW4r?=
 =?gb2312?B?a3E5dFVRazZybExSbmN2YTJjUDk0MWxpU1BEcVlza1JjeTltL2gyQmRrMTFm?=
 =?gb2312?B?eVh4am1WWkpJQlR5TFdxN0JwamNmMmtkUkNSNWdGMWEzNEUrbE8xZzE5MFNI?=
 =?gb2312?B?MXROWVNhYngyVWFWaGlXVSs3OERpTUNPSzVUSVAwMSthclh4UUZRNUdQUlhi?=
 =?gb2312?B?YnNPYlMwRUlZcmVIVmQ1bTBjY3FNQmlxOUNPVzZSa1dCVkpHb3dSVnBicW1y?=
 =?gb2312?B?dFZLQ1F0dTk0TDhGeHI5WDlNZ25LeENRQ2VXaWF2S2ZGOXl5cjZFRjZNUSs2?=
 =?gb2312?B?R091c3ZHV2pENDhmN09GeXllU0FCQVprT2lObEJDN0VTT0tCblFsTmJPeExa?=
 =?gb2312?B?TTZ4MURFMCtjdVZKc3JrRlByUHNzNWJhQ0cwWGljUklnd2YrNmNZQ0k1N09n?=
 =?gb2312?B?OG5JZ2lNUjJ3SFRSUTVibHVPUy96KzlXcC8xZXZmYUhSVTViZnFYVjdmaWYz?=
 =?gb2312?B?YmNNenRnQTVYelJjWWY1QXhXeWFXSDZEZFN1cE9MZHF3S0F6L09IOVE0QUUv?=
 =?gb2312?B?N1pmNW5QYTVyZ05HbmF1RE5tVEtnb0pOSi92SmZNNWpkUWJtaEVZaU8vUWVu?=
 =?gb2312?B?bHJqdVlGbTBYb0lWaXdTaEVQSEl6b2lhM205MUZNaCs4WXgrenZ2NDV5K21G?=
 =?gb2312?B?TGJ1d1pLdzZxSk1kakJ4d3FXOWdXUmx1QlNwSmVJK2NrcllKbGNwMHdEb1V2?=
 =?gb2312?B?UGNISmF1L1hsWlh4RzIwSXZPMkd6d2lIT2F6djhxTWRQUDgwamNEVUdZTmgv?=
 =?gb2312?B?ZnVrMEk2dCsvelVmbXM0YTBIN05ldFB4Q2pIWTRnYk0yQXpQUGQ2RHNNNFEx?=
 =?gb2312?B?SWhQZGlPZlI3V3FZVHhKNHB2b0t2RFhUZ0k0OWlEYTlFUVVzOGwzbFYwK3hR?=
 =?gb2312?B?OHlUaEVmRm1rL3Z4aks5MEJ4QXB4OXA5aXFzVjdNdncyNEpLa3cwMmIyUFZP?=
 =?gb2312?B?RngySVd1VTdhb3NlY3V1NjdlQmlTcmFNdjc5bktaY3hXR1FiSkk3QXcrd3Fo?=
 =?gb2312?B?RnlkT3RUbERlODdENzhoazVVOEs3eU43ekFONlR6L1gwRVQyU3dGY3NJWjY0?=
 =?gb2312?B?THZid2FPYnI4ejFraldVaW1SeFBPaVJHclQvZzY5bm9ESkxCY1BFbGZocDhi?=
 =?gb2312?B?dWdIT01lKzRxZVArWEQxTUtCeGdYcTlnbjgrQXlsTFpqTmJlZzd0SmxEV3VK?=
 =?gb2312?B?TmRZT3dHbkFyUUZTYWM1MnRMM3NMS1FHdDV0emY4RlV6b29QK0JLbHB4dzhX?=
 =?gb2312?Q?jm/SMk?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?T0xKMExqU2dHdWNnekYwcTFZTmpMRkU5NGxMKy9kOGFlbGFBR0Zna29Kam5o?=
 =?gb2312?B?WlhyakxobFpwckQ3ZDFsOEJFQ0pnMVkyRkNXM0I5Qk1WdzBQNGZuQy9yZ21F?=
 =?gb2312?B?RUlsVFlaenFxVnNRSlNnSm1XTm13UlZoQjc3bmI4R0svb2swVXdMRklCbFhK?=
 =?gb2312?B?Rmo5NWJLbVY1WnVLYUpXT2JPVkxOTTg2N2FlTTFDSnRtTEZyWnJYMitHY1Qv?=
 =?gb2312?B?cUJqK2pjRHhOWlZpTFJJK21lU0MzcXU0NW5ybWFjTEdqT2xxRStOODhWazVl?=
 =?gb2312?B?MzNTdjhwUkNMQzNVdXgzT1MwMXZoamxrSlVVbzQ2ZlFaWHJCYTRocUFNMG1I?=
 =?gb2312?B?ZFdvZXBOeEQvWXpkMllKOTQvT25KbXc3NzhwY1RaU0J5Y2o0Y21MbEx2ejh5?=
 =?gb2312?B?QXJyWUhEWHBuSUZTVk5CbDZ1OGNmb1d1S1lZdTJNOWdRWjFLQzI4Zng1M0lz?=
 =?gb2312?B?Mmxvd0xpSU8xL2F5NUNIOC9HZ2dMZmtQTUcyYk5ZRkYrQ3ZiTkY1OUR5d2Z6?=
 =?gb2312?B?Vzl2c0VxR0FWQmh5UmxDZWIyczBHZENVMVJ5OTFlMlJsQUgxTFc3dGwrUUZB?=
 =?gb2312?B?NElQdmZJdGRhbDNZUnNvSThBM1RmSDYzMnFXd25ESndYK2Jueno1Y3hkaUF1?=
 =?gb2312?B?MGdkMWh5UWVoczBFR1B1cjVyTW13QW5jTlNDOFBneHVGZjR5Y05mWHNOWkh0?=
 =?gb2312?B?cm12Mm4wd2FQWXhtSUc1VUlkRGJxa0FsR0M2OEVuRVVwdjY1RVQ1VUxWZGxJ?=
 =?gb2312?B?RnQyV1I1Zlgxdzh1TVlRUk5jY0FVTzZobjJCd29pd0IrdU1HVVVnVzdDOWdT?=
 =?gb2312?B?dDdTQzRTWGFSSVZrNGZDeDUrRzNtTjRPdzVrVStwQWgwTUJNeHgwNXZRMy94?=
 =?gb2312?B?NW9PSHRtM2VjQnJYV0tZR1NYSUV5a05sN0hYenQwRW5TQ3ZMeENZeFJVSzgz?=
 =?gb2312?B?OTBtbVphbmJ6TG1aa0F1T0VkZHVpd2g5VUw0WTFHSWlCOTl3RkduVXVPYzZU?=
 =?gb2312?B?by9TeGgyZnU2S3VRV3BFcEdyY1JCR3lRT05DbHcwQjVOWjQ2VnVTY01WeW5T?=
 =?gb2312?B?UXcvYlBacFFxTkxiZVpyZWhtV3hDNzlFTVdVYm1JYnpsSzlyQTJGelRLQTZl?=
 =?gb2312?B?S01VdnZHWUFET08wWFMwMm1VcFJ4RmgzODBwNy9qWGQ1N3lteXJJeTgweitC?=
 =?gb2312?B?SEJwa2c3NjlmUURZZzM0R1VxUnVWNVpRTVlDMzB6L2ltZmlUVkhJa3hYWGNt?=
 =?gb2312?B?bmNQU1JFZWRIMDVYUzVXV0Q3ZCswcVVaMmE0Qm1odkwzQktROHltdm1qYkly?=
 =?gb2312?B?SEdSSzA4SUxGdnViaHhOUG8wVFB3ZEcxNnlsSDg3N0NWUWY0T1E1MVBhR212?=
 =?gb2312?B?OFRZMUlWWkcvUTBSQzVSTGxEbmovREJBY1dnTHZDNWRuYkVrOUF4Um10Wk9Z?=
 =?gb2312?B?OTBIMC9MNlZtVjd6blhqYjdZMmcrZ21zUlFudHdvVFlSS294UGNQeEJrWlRE?=
 =?gb2312?B?OW5HTHhFQ2Y3VHJncWVjek1KZUszYWJkeENWZHZNeHdKRndka1NkMUFCWGg1?=
 =?gb2312?B?QXFBcFhwSnRIc3NKc2tITFpRYWxaTWxObXU5cHc5N2pxWklNeXBMVER0M2ow?=
 =?gb2312?B?MXBJM0FoZ2FsOStOcy9neVRFRjV0N2Y4U0k4eXROQUVwMmlnZWMzak5VVXIy?=
 =?gb2312?B?aHFpS29IRlNJU3ZrL1VGTjQ0UnhXN3A0OFNQZzJBK3JQUXpsTzRJUkErR1R6?=
 =?gb2312?B?cHJ6RFpKYTFLVTZCR1JWNUZ4am1aMEk0MUNKRVhobElENkNBY2QwVi9tOWlU?=
 =?gb2312?B?cWFMd1Z4WVMvcU9jclBPR2hOUW41bHFTK2FjNDNkeTBPTTdvWFptbVRINXZ3?=
 =?gb2312?B?SHQ2dXhZYWFHUlAycFViMEljREZwbGxnSW10L2Vlc1NoZ0o0N1pqam01WXZY?=
 =?gb2312?B?b1BGbUdYc2Y1VDkwdlZYbXFBSW1WRE52NXA2d1IwSllBTHhQcHF6d0RxcDJh?=
 =?gb2312?B?UlMvSWtrUnJNT3k4YlVlNUhmWCthYmlaN0haMzZGTGxQN0FYYnY5cTk0N3lK?=
 =?gb2312?B?MUlheHoxOVAwY2hXYitLODdZanZ6dXNubEFmMnVtUGJWVzYwcFVUZXpoWVcr?=
 =?gb2312?B?bjNycHk5WGFsV2RwQzRTT0cvVWVKOCtDeVlaUXRrQ2ErN2FTZEtuNWRLWjAw?=
 =?gb2312?B?UHB3QWlxQTByZGdqdXFXbE1LZWRUU3dEUm1jTVkyM1BaMDlaR2JEN2k2Uk92?=
 =?gb2312?B?WWRkN1g1cVhIYy9sdUtzQ0ZEUmRHdEJ6MHB3S0FvYUx3UlI1ZHdYS2Nrc25I?=
 =?gb2312?Q?Bllv8diXrJnfkn6pm1?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ed98a638-c8e0-47be-ffa8-08de476d1c0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2025 06:31:48.0301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kOWLFQVTqH74RLYNhZ37Y5rg8lwETYMlMGfoUuXKMpjSPJKa0d54b+Lq5Bb94AnXENvTGThDo4Vh7zVgmpfZRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10871

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTaGF3biBHdW8gPHNoYXduZ3Vv
QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjXE6jEy1MIzMMjVIDExOjI4DQo+IFRvOiBIb25neGlu
ZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiBDYzogcm9iaEBrZXJuZWwub3JnOyBrcnpr
K2R0QGtlcm5lbC5vcmc7IGNvbm9yK2R0QGtlcm5lbC5vcmc7DQo+IGJoZWxnYWFzQGdvb2dsZS5j
b207IEZyYW5rIExpIDxmcmFuay5saUBueHAuY29tPjsgbC5zdGFjaEBwZW5ndXRyb25peC5kZTsN
Cj4gbHBpZXJhbGlzaUBrZXJuZWwub3JnOyBrd2lsY3p5bnNraUBrZXJuZWwub3JnOyBtYW5pQGtl
cm5lbC5vcmc7DQo+IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRyb25peC5k
ZTsgZmVzdGV2YW1AZ21haWwuY29tOw0KPiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBsaW51
eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGRldmljZXRyZWVAdmdlci5rZXJu
ZWwub3JnOyBpbXhAbGlzdHMubGludXguZGV2Ow0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEwIDQvNF0gYXJtNjQ6IGR0OiBpbXg5NTogQWRk
IHRoZSBtaXNzZWQgcmVmIGNsb2NrIGZvcg0KPiBQQ0llWzAsMV0NCj4gDQo+IE9uIFRodSwgRGVj
IDExLCAyMDI1IGF0IDAyOjQ4OjIxUE0gKzA4MDAsIFJpY2hhcmQgWmh1IHdyb3RlOg0KPiA+IGku
TVg5NSBQQ0llcyBoYXZlIHR3byByZWZlcmVuY2UgY2xvY2sgaW5wdXRzLCBvbmUgb2YgdGhlbSBp
cyBmcm9tDQo+ID4gaW50ZXJuYWwgUExMLiBJdCdzIHdpcmVkIGluc2lkZSBjaGlwIGFuZCBwcmVz
ZW50IGFzICJyZWYiIGNsb2NrLiBJdCdzDQo+ID4gbm90IGFuIG9wdGlvbmFsIGNsb2NrLg0KPiA+
DQo+ID4gQWRkIHRoZSBtaXNzZWQgcmVmIGNsb2NrIGZvciBQQ0llWzAsMV0uDQo+ID4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+IA0KPiBJ
dCBkb2Vzbid0IHNlZW0gdG8gYXBwbHkgdG8gbXkgdHJlZS4NCkhpIFNoYXduDQpUaGFua3MgZm9y
IHlvdXIgY29uY2VybnMuDQpZb3UncmUgcmlnaHQuDQpJIGNyZWF0ZSB0aGlzIHBhdGNoIGJhc2Vk
IG9uIHI2LjE4LXJjMS4gQW5kIGl0IHdvdWxkbqGvdCBiZSBhcHBsaWVkIHRvIHI2LjE5LXJjMS4N
ClBsZWFzZSBpZ25vcmUgaXQuIFRoYW5rcy4NCg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0K
PiANCj4gU2hhd24NCj4gDQo+ID4gLS0tDQo+ID4gIC4uLi9ib290L2R0cy9mcmVlc2NhbGUvaW14
OTUtdHFtYTk1OTZzYS1tYi1zbWFyYy0yLmR0cyB8IDEwDQo+ID4gKysrKysrLS0tLQ0KPiA+ICAx
IGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4g
ZGlmZiAtLWdpdA0KPiA+IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OTUtdHFt
YTk1OTZzYS1tYi1zbWFyYy0yLmR0cw0KPiA+IGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2Nh
bGUvaW14OTUtdHFtYTk1OTZzYS1tYi1zbWFyYy0yLmR0cw0KPiA+IGluZGV4IDViNmIyYmI4MGIy
ODguLjEyNThmY2I1NDY4MWUgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9m
cmVlc2NhbGUvaW14OTUtdHFtYTk1OTZzYS1tYi1zbWFyYy0yLmR0cw0KPiA+ICsrKyBiL2FyY2gv
YXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDk1LXRxbWE5NTk2c2EtbWItc21hcmMtMi5kdHMN
Cj4gPiBAQCAtMjM3LDggKzIzNyw5IEBAICZwY2llMCB7DQo+ID4gIAljbG9ja3MgPSA8JnNjbWlf
Y2xrIElNWDk1X0NMS19IU0lPPiwNCj4gPiAgCQkgPCZwY2llY2xrIDE+LA0KPiA+ICAJCSA8JnNj
bWlfY2xrIElNWDk1X0NMS19IU0lPUExMX1ZDTz4sDQo+ID4gLQkJIDwmc2NtaV9jbGsgSU1YOTVf
Q0xLX0hTSU9QQ0lFQVVYPjsNCj4gPiAtCWNsb2NrLW5hbWVzID0gInBjaWUiLCAicGNpZV9idXMi
LCAicGNpZV9waHkiLCAicGNpZV9hdXgiOw0KPiA+ICsJCSA8JnNjbWlfY2xrIElNWDk1X0NMS19I
U0lPUENJRUFVWD4sDQo+ID4gKwkJIDwmaHNpb19ibGtfY3RsIDA+Ow0KPiA+ICsJY2xvY2stbmFt
ZXMgPSAicGNpZSIsICJwY2llX2J1cyIsICJwY2llX3BoeSIsICJwY2llX2F1eCIsICJyZWYiOw0K
PiA+ICAJcmVzZXQtZ3BpbyA9IDwmZXhwYW5kZXIyIDkgR1BJT19BQ1RJVkVfTE9XPjsNCj4gPiAg
CXN0YXR1cyA9ICJva2F5IjsNCj4gPiAgfTsNCj4gPiBAQCAtMjUwLDggKzI1MSw5IEBAICZwY2ll
MSB7DQo+ID4gIAljbG9ja3MgPSA8JnNjbWlfY2xrIElNWDk1X0NMS19IU0lPPiwNCj4gPiAgCQkg
PCZwY2llY2xrIDA+LA0KPiA+ICAJCSA8JnNjbWlfY2xrIElNWDk1X0NMS19IU0lPUExMX1ZDTz4s
DQo+ID4gLQkJIDwmc2NtaV9jbGsgSU1YOTVfQ0xLX0hTSU9QQ0lFQVVYPjsNCj4gPiAtCWNsb2Nr
LW5hbWVzID0gInBjaWUiLCAicGNpZV9idXMiLCAicGNpZV9waHkiLCAicGNpZV9hdXgiOw0KPiA+
ICsJCSA8JnNjbWlfY2xrIElNWDk1X0NMS19IU0lPUENJRUFVWD4sDQo+ID4gKwkJIDwmaHNpb19i
bGtfY3RsIDA+Ow0KPiA+ICsJY2xvY2stbmFtZXMgPSAicGNpZSIsICJwY2llX2J1cyIsICJwY2ll
X3BoeSIsICJwY2llX2F1eCIsICJyZWYiOw0KPiA+ICAJcmVzZXQtZ3BpbyA9IDwmZXhwYW5kZXIy
IDEwIEdQSU9fQUNUSVZFX0xPVz47DQo+ID4gIAlzdGF0dXMgPSAib2theSI7DQo+ID4gIH07DQo+
ID4gLS0NCj4gPiAyLjM3LjENCj4gPg0K

