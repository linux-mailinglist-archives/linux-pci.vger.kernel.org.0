Return-Path: <linux-pci+bounces-44312-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0BFD06CBB
	for <lists+linux-pci@lfdr.de>; Fri, 09 Jan 2026 03:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6974D303DABF
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jan 2026 02:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C718925CC40;
	Fri,  9 Jan 2026 02:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IDpWcovI"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012013.outbound.protection.outlook.com [52.101.66.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14536258EDB;
	Fri,  9 Jan 2026 02:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767924611; cv=fail; b=R1hFFHYOv5+kuy8Ii1in13Gc9yLDVPXBJAcxZ1E8b6mCe9fVjfaOaqC0c2PJIHnKtmH9WsDv+MJ5ImfOeidbZZqRokjvCO+YEPavPCJz873gHu6joXDsA1oHtI2NaYzoj9sAUwLPoIXEFaNpA7PNWPPYWUR3Vkv0OS1ewN9Xyto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767924611; c=relaxed/simple;
	bh=NBsofPEVAxyLt1p7kLFnJMCqBZ6qBqVvaHH2UhWhrxQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h6zOi/iuHoJhXYRYO8HFDGUeDHrM9c96xt4CW9Fr5WXW7l0urNMpmc1uABGkVEc/i8gAmrStnO7GWRGs9ZySgZ0j4ZAsQB6yynUKlEwEIpmTxskNmUulr2iJDFYdp0baRm7ZdIcPv7S6K8oio1F7dAGfolhaEpSz0AUB6k8GHuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IDpWcovI; arc=fail smtp.client-ip=52.101.66.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZaB6koQGvJJlWEUBuswxIWU1RUGnd5W3OH0bQAOiikhBcHsRdV6rnsgrdc5GRa0SjjQiMxecK88JKReaSxOdBotHF9exbC3Rzfea7mgIKhCy9Ov7AI77qmd/5+i6DOtYTkJ0OiNjL883AaH1DbncZAy6WMXdCbrA8z5V3kn8z2fAU1DvIfBlApIBJ+ed73dSuDBvofiJX0ZU64r7gE1+Tc18VLW7zJQtx1e7hOinOhLP4DH1wHu8bPwvDwfzMQ83zxVXITxR+OFmpEIW9TIOFkJHnt0vua1C3LTyzc0ct8dbOayYKimCwskRtX5gwVqHk4Sx0n1Zh1QYu8DWyxJY7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NBsofPEVAxyLt1p7kLFnJMCqBZ6qBqVvaHH2UhWhrxQ=;
 b=yc1n+ALIYAp8tso6RuC9It+MwjWo9mlCz6lMdP307WPuIPPzJn6P7r5US4j9FD0pf57/MIp42kWdOBs3jif7M45gKKQax5gUl2keAoSx1fzbHk8iRvhnq7p4JtrjS9HDtlyuwCBZmAXgOTPj9XQpz6rt9MH8kxirFFax+NnbLninEKnoC9CMRDnRfiHuCku06y8JY0+IiaMwYkHtnKSt2gKSdiABoVmzHzlWG4K8sM9cO2wUnMrKAcsB9T0lkvxOSm90NzhvmBEiJbj92puRrdf1h54W1PtOQIaGVHamODKRV6qRosaGkIp6BgnqlEQvkKJPZ6hoDK6nNjUxElhS0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBsofPEVAxyLt1p7kLFnJMCqBZ6qBqVvaHH2UhWhrxQ=;
 b=IDpWcovIQDAV25kEaqAI71LKzvscy8TggFX/QCge/L1bA95dNao6ctNTNhNNVJQITRnrxd2X1mN529ZVfUFF4vZbXPoeIpEeekYPEQs39z8A+zGXcLN3uJkoRuj8jb8cd5PeqUMt4ncIrz/ETogOpY5kUdru5dVcWQDtiPaKrvUEDSrJA+UUWEuKRJdRviz00S0/rw2U+6BbVQKZuXxjqD9HmH+4Pnu4UN2R4BdWUPimSZkX2sBwoP/sW0LZTRYnjwfIKT5QtVt1nE3U5iOv2fa92orXPdgSHbOBBiB1jNGCc58Og1hyJdZjisL5eIVzHqQPipc1xox6YlQY4fYpxw==
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by AMBPR04MB12206.eurprd04.prod.outlook.com (2603:10a6:20b:759::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Fri, 9 Jan
 2026 02:10:07 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%7]) with mapi id 15.20.9499.002; Fri, 9 Jan 2026
 02:10:07 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Frank Li <frank.li@nxp.com>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "mani@kernel.org"
	<mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 08/11] PCI: dwc: Invoke post_init in
 dw_pcie_resume_noirq()
Thread-Topic: [PATCH v6 08/11] PCI: dwc: Invoke post_init in
 dw_pcie_resume_noirq()
Thread-Index: AQHcPYCbqB/mIx6Ah0yPq33H8etE97VJVn8AgAA8pLA=
Date: Fri, 9 Jan 2026 02:10:07 +0000
Message-ID:
 <AS8PR04MB88334B71E559AC00907BDE028C82A@AS8PR04MB8833.eurprd04.prod.outlook.com>
References: <20251015030428.2980427-9-hongxing.zhu@nxp.com>
 <20260108215006.GA500164@bhelgaas>
In-Reply-To: <20260108215006.GA500164@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8833:EE_|AMBPR04MB12206:EE_
x-ms-office365-filtering-correlation-id: 2c2c21cd-6b2d-4c9c-8a4f-08de4f2435ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?gb2312?B?UDJyOEtIYXA4UWVjNGMrVkRxM0lNdmtnamJXK1dxMHAwVXUzQUZreisvTFBn?=
 =?gb2312?B?c1E4MDBQSWkxd0oreU82RXZpYjhJY001bTVVV1R3NUV2eDJPMGNSd2tIUmdq?=
 =?gb2312?B?TUEyYUs4L2kzdWhGTVZHUld6MGtBeURNNDZwSGphZEVBQ1VLUjlWd0g3Lzk4?=
 =?gb2312?B?MGhvTGFtN0dvTlZtZ0wyV3JIKzNTekpMeTJXdW03ZWJxTmQvbTR3UldEQ3I1?=
 =?gb2312?B?cWk1S1U2NUZoSFlDTjBiT20rYlcvTHJwWlh6N2hRV3ZHbmVjUVpsODgzYno1?=
 =?gb2312?B?ZmpvMjV3eTVYYm9RRzlQTHR5VnIwMlRUTFRLSUVEYlM3UU50R3NmdXNOZkJ5?=
 =?gb2312?B?dzNoNmhKRnB1cDhVYlp3TjgyTHJwT1JjMTl4RVhBbE5DMUkyamRwRmdkYTRl?=
 =?gb2312?B?YmJNcnJPUm9WVzhPTktuSDM5YzFVVWVFdWxQaHkxeU1LUXYzWTdBYkUycHls?=
 =?gb2312?B?VzF5dFRldTRUakJJUnRRL1JKSkRSaEVRbVc2YkplVVFFOS9xRlp2TTNjNVhR?=
 =?gb2312?B?T2Y0Z2dpS3VOb3UybkV1NGUzMDk4bTJQemlmRTVXUElCaGJMNE5JQmY2QlJ1?=
 =?gb2312?B?TVEzWUhiR2ZpbGNCbGZFMjRIYXY5SzN5bU1LR1BTdVBWT2lMdlNaOU1DazZK?=
 =?gb2312?B?Z24xTTJsVDd3S0xMYnQrN2VZY01pNjRTYk42R3hHMHArSjgzZERSbnN6VWNW?=
 =?gb2312?B?R1hjS2RLTWg3Y1ZrYjFBOFB1RjRJSXgvMG9lT25LL0w1dmtTcGZHTEpFZ05Y?=
 =?gb2312?B?bzR5OXRocmxTN3FuQ2Y1MURCRlpCVzZ5VTNHcG0wRXpLN29BNlM5Nmc3V3Vi?=
 =?gb2312?B?UGVLb3dKQkRJQmdHZkszSFllclh2UWxWU3JXNGZQaXBkdllkL2JoMkZuTWI4?=
 =?gb2312?B?TCtrT2lQb1ZKb0V3TDhxMEpPRm9YdXFlbnRmeEQ5WlJoakt6bW81M2dKSjBE?=
 =?gb2312?B?dVhKR1pMUEIwbmsvSVlOaE5HYzNUblNXWGd6M2Zvc1d3TERSMjF6QjZWekJE?=
 =?gb2312?B?NDlRNjlaUDNza2JEd2pOWlE1MGFLVDdMdnFZU0tYTThaK3pGUzhxM24rS0V6?=
 =?gb2312?B?cmZweElZWWtpdmtZdjdNU1NvYnNYVmZObUFEZ0svVWN3MVZISXpqWGNpQlc2?=
 =?gb2312?B?aytZNlF2eUdOdlZJVXBybnBPZjlyM0FiYUE5dENGZXVtNzBYRXV0S2w4TGMv?=
 =?gb2312?B?dThBTTNTKzMxYzRLMjhkMU1EdVFoU25TSWFFQXljOC82WU92cXB4WHJlR01p?=
 =?gb2312?B?QWNUY3VwdVVCaFUvVFNMbmlCZzhMYUJ4VUxzWDJXUE1ZR05mbjZ4Q2tCaS93?=
 =?gb2312?B?UlZZVGhUL0Y3OE5JczRwTzdxS3NKbWRQZGpGOSthak41UjN5SjB2RlV0QzQ3?=
 =?gb2312?B?SXNMQ2ttTlR2Y0VHdzhhVGlldEJ5NmROam8wRzMxanp3NFNudWZtUm5Fa3Ra?=
 =?gb2312?B?clFCRjJpdUpLRC9VNTY0QTBoZ3pIM2VCckVWQXdydmhYTWk0cXNVbDc4TmFW?=
 =?gb2312?B?ZklhREhXYlpYV3hveHA2UWtia01YVC9qQzhBaWFRKzRiS2ZOcXFpdC81Mk52?=
 =?gb2312?B?MmZYU2c1V2ZML0ZuVnltV3Z5ZlFKc200Q3RrV2hMZU9OanVTdHROVmVBS2xW?=
 =?gb2312?B?Q2lRbytTbllXU3ZIQ0M0Ui9CQi9rOWJhbk9NRHlmY0pILzZxUlNkeXN0Mk1I?=
 =?gb2312?B?bGVBcVgzUUM4YWsyR1B4ZjdUTVNmbGIvYmR4eFZabEZ4WWxSZFhCc0RoM1Nl?=
 =?gb2312?B?WjRuRTB2V2RtMkpPK2FMeEVTbDhMRW5zdmkxMXRqTmlRZnJnZlJGUDlucEZp?=
 =?gb2312?B?ZW81dlpTczcrQTBtU2xxZ1A1REZtWi9PYUlJNmJ6ekdlei9WMld5UVhGRTZa?=
 =?gb2312?B?dVZNeW1IbjFZaUJOT1Mveml4d3Q5UVFqd0RmZ3REcHNLMHhWaFZMTDdsUEZ4?=
 =?gb2312?B?RUVoVWN4VVZBWnpKNVM3dmlGOUFzUnhzOVo5cy9HUEJNam91MmlUR0NiQVpX?=
 =?gb2312?B?V1lxYzNacUFqdk1ya2ZBZjBYT2U5WTNmeUdRSE1oRkhxWGNTZGxiMktsbURS?=
 =?gb2312?Q?PI/0UI?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?NjRNN1d0dzgydVJucUZMSWJvMHd5SXNTK1AweC9Fem8vUFRteHh5V2tHUGRW?=
 =?gb2312?B?aEdwY1NTd2czZm4zOWhZN0R6UEZDVFQ4by9NWG42RXN5SUhtQ0c3c0lMQkt2?=
 =?gb2312?B?c2x0RDZsNVhYZ1JpVUVlUk9aaUhoeWV2c2s1MWpiOFM1NTZCb2d6Um0xZ2VE?=
 =?gb2312?B?WEJqZE91M2cwMGI4OVgwakw4Sm5yOTlub2x3cHlTaVFLMHQ0NkdTMEtYcEFG?=
 =?gb2312?B?MWhuWGc0LzJRclZGVk9iL2dwL2x3b2szWFJ4d3llenk0TmxseVpvMDluem9k?=
 =?gb2312?B?SVRsb2hPdS9QRjBDeTBlbjRrNytoUlk3NStIL0UydVJqQ0pBMWpEVzZLWnRJ?=
 =?gb2312?B?VnR2MDRpU2NDL0JxbnI4YW5JcS9JODU4djNPblFVSkd6M1hrM1Eyd2JZUDEv?=
 =?gb2312?B?SlZJYzRUalBaY3pSMEw2NGFDWUEvdWdoWWZBbWhBcHpoRlZtbUpnNGprbUgw?=
 =?gb2312?B?UmFkRVRWczZrUVVUb2w2Sm5VQ1laZlVmY1NWWkc2eklIeDdOMjZoU01EUFBO?=
 =?gb2312?B?Z0pZNGJhRG14bXh3QlRKMzN5bk1RMERNaUJZVDE5MlNsQm5DbWpOM3JwR2d6?=
 =?gb2312?B?Szl1M3hzV01SVDlLNm5UY1RZUHIwbEVZN2o4Mld4SktvRUVFT0RqdmF5Ym5X?=
 =?gb2312?B?VnQwWDhCM0Z4VFNPdWVMUjBBUk9ncG5UM1Q5RjMzY2lnVUhwQ1dWZ0lydkVi?=
 =?gb2312?B?Y1F4VUdNWjh0c2dBUnEwKzdqeUxvUDZPaHZCWFMwdE4yUVlBTHN4anNpN01N?=
 =?gb2312?B?Q0pHcmVVVmxNWVdPNTlvQktwUmhFT0xPaEVjSHg5a2xkQUQzVnYxRzZXN3Zr?=
 =?gb2312?B?K1RwZWJROHJVN1lvaytld0t0NmZzcUY3a1I3NStIRGM4VUlkbWRmWEJPM0Zj?=
 =?gb2312?B?Si8yYzA3MTlqYzBmNFlRbk1ROGxXOGFGeTlIQUdiSkcwNWhzRmwrK2tvSnBi?=
 =?gb2312?B?Uk5CbGNSbnUyT09uNzdDM2FtL0dWd1V3cjBvb214TGdoY3grL2JicFdwSkhB?=
 =?gb2312?B?cDhNT285ZGdnNkcxUVJDQy92NitpVWx5RVA2Tjhya1JENm1KcnRxUy9HcWFn?=
 =?gb2312?B?ZFo5dG9mbmhxNGQ0Tkgyb3Z0ODc3cUVaRWFuZWJ5Y3UrQ0xBc1BMa0ZRSmh6?=
 =?gb2312?B?bldNM1FoMk5HVmswejFZS2xBeVh2MVRPZ1ZKSEVRcXhKWGJuS1FSRGVPUXN6?=
 =?gb2312?B?MW5uQ0FNSG1CVXoxdmdxVVE3UnNOalZ2bHJNbWFPZ0ZNTEl4alNsVjFOYTVh?=
 =?gb2312?B?NEJieUJLYTJIcHdxbjF0bVdYTEhGWk55THVaeWlZR0hLR1kvc0VzNXkrYm5h?=
 =?gb2312?B?c2ZxNE0rSXdSUVhndUFQR3QxV1l3RVkvVkFrSU54bXY0cXk2WU5lOGpXSFY0?=
 =?gb2312?B?NTgwY3NFVFhqY3VXM1UxSmU1Y09FdEE1NGFkdHBFNmtMSUJLWHBFRkZrU2Fv?=
 =?gb2312?B?Z0dDanM3cHpVL1Jtdk4wcGQwdCtVTHdZR09ibXVJTm9DQ1Njc0Y0cklPS2Jl?=
 =?gb2312?B?elJndytSTnpxV2RlSjc4aUZuSjJpYmM0MGkwcFdsSHYycFJtYlhTSGlYTkZm?=
 =?gb2312?B?NklzaktPZExuS1I0ZXM4MFNHNlRSeU04UU1aSERHNXcxRHRaRGc5eEdvYVpj?=
 =?gb2312?B?YzhtQzFIMllOS1N4UE9mOTMrL3Flb2xVYnlGS3kzMlFZeU5ZUnVVQzdEQkNh?=
 =?gb2312?B?VURISEJMU09naWZnZnV1LzFWZ2NyUGlwRGdmaTBuTVcvcGs2M2djanpLK2hW?=
 =?gb2312?B?UHA4Z1diTUZFSUJ3Rk1KR01UbnRFSnZFZTNUT1RJOUVwQk9ONndrRmd0L0dz?=
 =?gb2312?B?S0NtSzlHR2hzNWFLdUJmcFV4ZjRNejhnVXZFVDZpQWNETHlIa0VmbkxqbDdq?=
 =?gb2312?B?Vy9VdzJaZnFxL0xHMUprREJUNDhaYnEvbGhUUzVrenZRTVBtZ0dpM2lKV2gz?=
 =?gb2312?B?b2U2bUxOQ2J3ZmxwUmxwTWExVTRQaGpDK2kyZXlTdFM2YWtvWkI1SkQrai8x?=
 =?gb2312?B?eGZtMk9hemhYKzIrYlBpRlRDM1d6cUtIZEVhdXcwa01ZNWJ6dkJZZE1QYjdy?=
 =?gb2312?B?NzlFOTZoeW1UWDBHQzZZVnRJalZMeXRqbkUzTGw2L3BjYkIzcWRoZkM5RXhv?=
 =?gb2312?B?Uk9GelVsUlBhZTlwOUM4ZThnTU0vcEhHSUxXOHMwSVZxSFN0enlxZU1kUmtv?=
 =?gb2312?B?UmZ6UWJTenJjTWhBWkJRbHdhRlJ5bDc2eWlncUVGazJtdDNxamIrM25vd3Fu?=
 =?gb2312?B?Q1ZKMDYyWE9BOXhwMEVZR1N3ZnZ0cU1NZzZDUS9BMTRtMzhNbHhyR1plUnE3?=
 =?gb2312?Q?AohTX1L8ziw4ttKWHv?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c2c21cd-6b2d-4c9c-8a4f-08de4f2435ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2026 02:10:07.5152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2xYVUeDGXnZLDMXIxYJ0nCyDaFxdEAzN2PXKZA8Dl7FXFXM0FFQX264vasM87J7dkgX7ruqZrvrwOslOP5GK3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB12206

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCam9ybiBIZWxnYWFzIDxoZWxn
YWFzQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjbE6jHUwjnI1SA1OjUwDQo+IFRvOiBIb25neGlu
ZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiBDYzogRnJhbmsgTGkgPGZyYW5rLmxpQG54
cC5jb20+OyBsLnN0YWNoQHBlbmd1dHJvbml4LmRlOw0KPiBscGllcmFsaXNpQGtlcm5lbC5vcmc7
IGt3aWxjenluc2tpQGtlcm5lbC5vcmc7IG1hbmlAa2VybmVsLm9yZzsNCj4gcm9iaEBrZXJuZWwu
b3JnOyBrcnprK2R0QGtlcm5lbC5vcmc7IGNvbm9yK2R0QGtlcm5lbC5vcmc7DQo+IGJoZWxnYWFz
QGdvb2dsZS5jb207IHNoYXduZ3VvQGtlcm5lbC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7
DQo+IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29tOyBsaW51eC1wY2lA
dmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7
IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiBpbXhAbGlzdHMubGludXguZGV2OyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjYgMDgvMTFd
IFBDSTogZHdjOiBJbnZva2UgcG9zdF9pbml0IGluDQo+IGR3X3BjaWVfcmVzdW1lX25vaXJxKCkN
Cj4gDQo+IE9uIFdlZCwgT2N0IDE1LCAyMDI1IGF0IDExOjA0OjI1QU0gKzA4MDAsIFJpY2hhcmQg
Wmh1IHdyb3RlOg0KPiA+IElmIHRoZSBvcHMgaGFzIHBvc3RfaW5pdCBjYWxsYmFjaywgaW52b2tl
IGl0IGluIGR3X3BjaWVfcmVzdW1lX25vaXJxKCkuDQo+IA0KPiBJJ20gdHJ5aW5nIHRvIHdyaXRl
IHRoZSBtZXJnZSBjb21taXQgbG9nIGZvciB0aGlzIGJyYW5jaCwgYW5kIEkgZG9uJ3QgcXVpdGUN
Cj4gdW5kZXJzdGFuZCB0aGlzLg0KPiANCj4gVGhlIGVmZmVjdCBpcyB0byBhcHBseSB0aGUgR0VO
M19aUlhEQ19OT05DT01QTCB3b3JrYXJvdW5kIGZvciB0aGUNCj4gRVJSMDUxNTg2IGVycmF0dW0s
IGFuZCBNYW5pIGFkZGVkIHRoZSBoaW50IHRoYXQgdGhpcyBlbmFibGVzIFJFRkNMSw0KPiBkdXJp
bmcgcmVzdW1lLiAgQnV0IGl0IHNlZW1zIHdlaXJkIHRoYXQgd2UgYXBwbHkgYSBSRUZDTEsgd29y
a2Fyb3VuZA0KPiBhZnRlciB0aGUgbGluayBpcyBhbHJlYWR5IHVwLg0KPiANCj4gRHVyaW5nIHBy
b2JlLCAucG9zdF9pbml0KCkgaXMgcnVuIGFmdGVyIHBjaV9ob3N0X3Byb2JlKCksIHNvIHdlIGFw
cGx5IHRoZQ0KPiB3b3JrYXJvdW5kIGFmdGVyIGVudW1lcmF0aW5nIGFsbCB0aGUgZGV2aWNlcywg
d2hpY2ggbWVhbnMgUkVGQ0xLIG11c3QNCj4gYWxyZWFkeSBiZSB2YWxpZCBhbmQgdGhlIGxpbmsg
aXMgYWxyZWFkeSB1cC4NCj4gDQo+IElzICJlbmFibGluZyBSRUZDTEsiIGFjdHVhbGx5IHdoYXQg
aW14X3BjaWVfaG9zdF9wb3N0X2luaXQoKSBkb2VzPw0KVGhlIGNvZGVzIGFyZSB1c2VkIHRvIGNs
ZWFuIHVwIHRoZSBDTEtSRVEjIG92ZXJyaWRlIGFjdGl2ZSBsb3cgY29uZmlndXJhdGlvbnMNCmFm
dGVyIGxpbmsgaXMgdXAgYW5kIHRoZSBDTEtSRVEjIGlzIGRyb3ZlIHRvIGxvdyBieSByZW1vdGUg
ZW5kcG9pbnQgZGV2aWNlIGF0DQp0aGlzIHBvaW50KHN1cHBvcnQtY2xrcmVxIGlzIFRSVUUpLg0K
SXQgcGF2ZXMgdGhlIHdheSB0byBzdXBwb3J0IHRoZSBDTEtSRVEjIHRvZ2dsaW5nIG1hbmRhdG9y
eSByZXF1aXJlZCBieSBMMVNTLg0KDQo+IA0KPiBDb3VsZCB0aGUgd29ya2Fyb3VuZCBiZSBkb25l
IGluIGlteF9wY2llX2hvc3RfaW5pdCgpIGJlZm9yZSB0aGUgbGluayBpcw0KPiBicm91Z2h0IHVw
PyAgSWYgaXQgY291bGQsIGl0IGxvb2tzIGxpa2Ugd2Ugd291bGRuJ3QgbmVlZA0KPiBpbXhfcGNp
ZV9ob3N0X3Bvc3RfaW5pdCgpIGF0IGFsbC4NCj4gDQpUd28gYWN0aW9ucyBhcmUgZG9uZSBpbiBp
bXhfcGNpZV9wb3N0X2luaXQoKS4NCk9uZSBpcyB0byBhcHBseSB0aGUgd29ya2Fyb3VuZCBvZiBF
UlIwNTE1ODYgYnkgY29tbWl0IDc0NGExYzIwY2U5MyAoIlBDSToNCmlteDY6IEFkZCB3b3JrYXJv
dW5kIGZvciBlcnJhdGEgRVJSMDUxNTg2IikuIEl0IHNob3VsZCBiZSBhcHBsaWVkIGFmdGVyIGxp
bmsNCmlzIHVwLg0KVGhlIG90aGVyIG9uZSBpcyB0byBjbGVhbiB1cCB0aGUgQ0xLUkVRIyBvdmVy
cmlkZSBhY3RpdmUgbG93IGNvbmZpZ3VyYXRpb25zDQpwcmV2aW91cyBzZXQgaW4gaW14X3BjaWVf
aG9zdF9pbml0KCkuDQoNCkhvcGUgdGhpcyBjYW4gcmVzb2x2ZSB5b3VyIGNvbmZ1c2lvbnMuDQoN
CkJlc3QgUmVnYXJkcw0KUmljaGFyZCBaaHUNCj4gRm9yIG5vdywgSSBwdXQgdGhpcyBpbiB0aGUg
bWVyZ2UgY29tbWl0IGxvZzoNCj4gDQo+ICAgLSBBcHBseSBpLk1YOTUgRVJSMDUxNTg2IGVycmF0
dW0gd29ya2Fyb3VuZCBmb3IgUkVGQ0xLIGlzc3VlIGR1cmluZw0KPiAgICAgcmVzdW1lIChSaWNo
YXJkIFpodSkNCj4gDQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3Bj
aWUtZGVzaWdud2FyZS1ob3N0LmMgfCAzICsrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNl
cnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9k
d2MvcGNpZS1kZXNpZ253YXJlLWhvc3QuYw0KPiA+IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9k
d2MvcGNpZS1kZXNpZ253YXJlLWhvc3QuYw0KPiA+IGluZGV4IDIwYzkzMzNiY2IxYzQuLjJiNTll
N2QyZTYxNzkgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNp
ZS1kZXNpZ253YXJlLWhvc3QuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdj
L3BjaWUtZGVzaWdud2FyZS1ob3N0LmMNCj4gPiBAQCAtMTE5OSw2ICsxMTk5LDkgQEAgaW50IGR3
X3BjaWVfcmVzdW1lX25vaXJxKHN0cnVjdCBkd19wY2llICpwY2kpDQo+ID4gIAlpZiAocmV0KQ0K
PiA+ICAJCXJldHVybiByZXQ7DQo+ID4NCj4gPiArCWlmIChwY2ktPnBwLm9wcy0+cG9zdF9pbml0
KQ0KPiA+ICsJCXBjaS0+cHAub3BzLT5wb3N0X2luaXQoJnBjaS0+cHApOw0KPiA+ICsNCj4gPiAg
CXJldHVybiByZXQ7DQo+ID4gIH0NCj4gPiAgRVhQT1JUX1NZTUJPTF9HUEwoZHdfcGNpZV9yZXN1
bWVfbm9pcnEpOw0KPiA+IC0tDQo+ID4gMi4zNy4xDQo+ID4NCg==

