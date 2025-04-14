Return-Path: <linux-pci+bounces-25776-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D08A87628
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 05:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3115C1890554
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 03:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B854CDF5C;
	Mon, 14 Apr 2025 03:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Pa5cILEt"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2043.outbound.protection.outlook.com [40.107.105.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C564F5E0;
	Mon, 14 Apr 2025 03:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744600534; cv=fail; b=ptW+KVvReo8H3TqHvshOLiGbET4aL/kfPKIbuH0qldJPxLmSX37H169bmapRKMJvMslSdN35maRTHhL1MqqENdcT7XlxJ+6bNRp9xkHDTKO2KmYf3j3bNSidllGOe+B0Gyejrp+atBsdc9hleXZcEboYlbeJwB806TYXxfzhOI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744600534; c=relaxed/simple;
	bh=QFz15Yb7ThbF0LEfpE6tdgbAs388WDj1TZuXwIdrWm0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uFWSEgrGnErKvXL0GOJKRzaUZNW0AIBVf/P/CPf1aw9wMEhMCvAWwOXWGoMVoGuOR1EtYZnU1sPxtxzwGSCiuUGygjVAKMvkAjxiDMxBBxOFrlscAk58sABccJY1CECx+dKDALD10tP6XUvwvZ3jv8YyXG9t5XmoddyaIk0XBKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Pa5cILEt; arc=fail smtp.client-ip=40.107.105.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rmgBh/ItOgOslCiAZ30uRcBXz7Wmzbiox+AaXs216kBB2vVaB6MaYagHKcX55OCSq2bIujd64bwRn17J72ISs7EVRLw8sbGrWyB14QGHmDaJbR8cywDmXH1RTZC6C1hpYP8DFeXraqCbpc2Tij87p0WxGenXfyTZUP2iM3CKC8DH6fC54Je1za2kQeRzyAvyS+aRwLrlHYFndYzn9rErDW8jtVeSHB58EiojzPjs3bjMP46lMv2dhJM/Fn75Y2yYgkezmDpqaHX8IFZbtJlOtVAzED/bP/h9asbVPXIDxoN0wFX1UNUALobALHMdkEr/Yniz6sVGiOAFTBPakjpsWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QFz15Yb7ThbF0LEfpE6tdgbAs388WDj1TZuXwIdrWm0=;
 b=dx3peYxW/lpk11uE0jFEQECkLE8BW+5mz0eBqFF++ls6di6SXiXCxfg/CJFzmOv1dVB3Lw5NxgyRYGMt3P3YRUAqy9frBPn9/0pn821w0ITn9HI1G8mpfzD1UZx5LIZNgbHBuEdFYIk/evjYTU3UgIMevAoSLOuHLBg/S9d5oUfW7X3drL9kIXblAAYTATv5WuupnCmcEjMIo6l9d5064H2y/nOOFqezsDwk2bto2DMvc7mUOdfSeHXODhyAY1dtQb9QGQOJ5+90E5RFAtwWDR9rHkEbsz407XfJ/Pc79iFfKIUxu66Cy6fZ4nhVFsIrVnN0baBuz6Lv5/p5VbSZhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFz15Yb7ThbF0LEfpE6tdgbAs388WDj1TZuXwIdrWm0=;
 b=Pa5cILEtvH8e17vQfhxctrpNokOezYpyccMoR+WKYx9EKTI/QkHBD9efHFuURlkCgET8ApAjdX7viUYw8ZASqQ5DrTPEcDlpiQElrP9RBhJkLp621OIKLVeIFrClfHcv9ueb/fCnrW9DuS1Wuty+mbcNt7yw4UTpeyxG2UiS8xwNGwh/0g54qcc1mJshSdrlLcvmHMWpI+qJT93UmPwrl58t/DqpS6y/NFfmZVUg/zkcJsqJ/C5ZBxeF+Vva+zC2BzjzzbNZZQ1gRyNBHuun5ftf8UeXTmhrlTfLtZXVLzJWabUoLoHzXTWwNiIu/FWArscexURhMnE3D1Ymc0Yhag==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by DUZPR04MB9782.eurprd04.prod.outlook.com (2603:10a6:10:4b1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Mon, 14 Apr
 2025 03:15:28 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 03:15:28 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: Frank Li <frank.li@nxp.com>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 3/6] PCI: imx6: Workaround i.MX95 PCIe may not exit L23
 ready
Thread-Topic: [PATCH v3 3/6] PCI: imx6: Workaround i.MX95 PCIe may not exit
 L23 ready
Thread-Index:
 AQHbn44DKK1oo7avrE6ytacDA3gL7LOP/LQAgAAFMnCAAIO0gIAAxEXQgAfaDNCAAnoMAIAAn9+QgAWXVoCAAMAcwA==
Date: Mon, 14 Apr 2025 03:15:28 +0000
Message-ID:
 <AS8PR04MB8676CFD0FA7BCBB06AC51B018CB32@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20250328030213.1650990-1-hongxing.zhu@nxp.com>
 <20250328030213.1650990-4-hongxing.zhu@nxp.com>
 <ovaomfvo7b3uxoss3tzhrkgdy6cvxi4kr2zxmqsfjxds5qfohl@t6kc4rswq6gp>
 <AS8PR04MB8676687332C78840B927E7568CAF2@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <rqgl5jjauppyudgmugp34fillkeli3qkwf4uf2djghi6nslebg@pyi6rbwyduxd>
 <AS8PR04MB8676BB3EDFCF3E5A490AC0628CAE2@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <AS8PR04MB8676C5D0DB84975D34C4C65A8CB52@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <4qrfkx3ckywcbk7qbjplal5j7v6sjs3zebeehe5dnrgjz2ej2t@krdwjb4xm2sx>
 <AS8PR04MB8676221C998474EF5A9B94288CB72@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <h7pja24zffl4t7653rjaamp6v2j5nmukbzq7rdajynemlyb6l6@3e37ggkparjg>
In-Reply-To: <h7pja24zffl4t7653rjaamp6v2j5nmukbzq7rdajynemlyb6l6@3e37ggkparjg>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|DUZPR04MB9782:EE_
x-ms-office365-filtering-correlation-id: 0f039a40-4ca3-4a64-0386-08dd7b029bad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dzB6eTJvd2ZXM2NLZXZac2ovUGw2Q2lvSFV2dlpBYXZVQUc1QytXT1V1ajg4?=
 =?utf-8?B?NWJNNld4NWFXNTVvaWtWbWhrSDFTbE1XMGFhWDJQUmczdmVSb1VVMk9UZzVp?=
 =?utf-8?B?MmVsZUhhKzNnUmJ5c3dZZ2Q0aW9QUE9EZkVjL2lQTTNTMWRoaHNsMnRoZ2RU?=
 =?utf-8?B?ZnlSRlErQ1F6LzJkdWZ0T3Z1L3lJditVMFNlOFpMOGpCYmVQaG50M2NyS1pw?=
 =?utf-8?B?eW5iUEltVldBODFUczNkQkFIWCtaN0Z1ZTJGRkVkaitpU1htNTYwdFVEdzhu?=
 =?utf-8?B?STVBSUpmL0ZxazR0N0YvTm1Ec0JLOVp3YnBiUUtMOTlyajNwTUlwZS9memRH?=
 =?utf-8?B?V2hORVlzSlVROTNjR1ovaFVRRXp5akZqWVZTUzZzdGdPTXFDenY2ZmpjdUh0?=
 =?utf-8?B?bGQya0ozdkltcjVNMnB3QVQ1ZVFYbXlEcXFVQldsR1licEhIWVB0UkQyUTlu?=
 =?utf-8?B?UEJnTmE3TDh0cVNsSHBJcXNwM21HaVlKZ2tHMXdiM3F6dXJPY1FFaDl1WG44?=
 =?utf-8?B?eCt4WjNKTlRQcytiNVJINmZNaXRSREFJT2ZXTzBhdkpBajI3RmIyRWxUZnFU?=
 =?utf-8?B?ZXZBdWttWTdLQnZjcGFEaDk0QkZXTE9sZ2JDSG9JM2g3OUVZMExKemtLWjVz?=
 =?utf-8?B?U1ZtSUhEMEMvOUtBNkJFZHV6QUJtR29uRkF5anBQcG5jbURJWGJmN0RCT2c1?=
 =?utf-8?B?R2lHTDYwNjhIVTBJa2lXdmN1cEJuYjZSeU40QldaQ1k4UEtlWWh5Y0Q2YWpE?=
 =?utf-8?B?enRrQzB0N2Z6MGpYRmNSakk0cnJIL2Z6ZHpNT1U0SFRYeDJsZUlqQk5HUHpQ?=
 =?utf-8?B?Z0lqcGh0K2tmN1BEQzd2UW81aHZzWFJZQlZBV3gwUFF2a3dHeVIyY3ZHVExI?=
 =?utf-8?B?Q0ZvUkRJTHlwVDJGUDJqSCthdFlQU2ZOMmR5b2FOb29mKy9TY2xmUUVKcUtW?=
 =?utf-8?B?SlVxbGdma0YxU1o4NlpWU2dHOUd1MjlkcmtKblZra3NTaVo3c0JtQWJERlhl?=
 =?utf-8?B?UmRTR1JPL0l6eHdEU29lckRwRlZtZENaZ3JSZmE3cWxIcWloaENCOG5VdnBv?=
 =?utf-8?B?ZVFON0Vwdy9zRURvVVJxMXhoa09NazhqbVdYRlZDRzl5azEwSENMTXVLRUpE?=
 =?utf-8?B?UDJIZTdPNEFCdzlHRXVzd0V0ZTBZY2R0R2Q2NXhCUEhqeWFGN0cvb3RFL0Uw?=
 =?utf-8?B?L0RMM0x1UzBza2xYY2kxbDlBYStRMzd4S1h3YndsODg0bGNqUFhHS2d0blp1?=
 =?utf-8?B?RlphK0Q5UlJjV2c0bjkzTjlzTTBCS3NKNWNNWnNNWk1tS29GQ1Y0S0tpcStQ?=
 =?utf-8?B?UFByQ0pnTVRMbWNra1RkajdFc3hjZDJ1a2hyVUZybGZZb3Zvb29iVDVwUFNH?=
 =?utf-8?B?aUtlT3kzRWYzOWM1UmJoNkZ1Qnkvakd1b29GRkFmTjg0Vm1sQ0wwbTFTNDlt?=
 =?utf-8?B?Q2Zyd1dkRnF0Ylk0VTNCVTg1YXhlV1RzTzYzekJJdnNxQ282RUk1RjBwL2pZ?=
 =?utf-8?B?RGVhRUQrT2lPb25NVHViQVBIOHQ2L0lEN1FOZnhMZ2VZV3QxdzBoY2xNTFBn?=
 =?utf-8?B?VjBaWm1XOUMvbHRiSzlrRHVpcFA0bnV0V3dmQzZEM0NrQ2owdUxHRXYxUitS?=
 =?utf-8?B?SGxwRFp1c1RNb1FLZjUxeU9ZdGUzdXJxZC9vc1pJalYvb3JnMnFIeTJhazlJ?=
 =?utf-8?B?SVgwczl2TUlaTkhaNGVKSnBRZG5XZ3lkQ0RpS29NTHlPS3lBNkZmR0ZQUmRV?=
 =?utf-8?B?aUNGL3dNT2oraU93dElJRmNGRWpuWWo5U3NLUG5lN2RnUGIwVXI2aHVQWTk4?=
 =?utf-8?B?eGR2dWVzUlBzOWlWL0dDTVJIVE1OMEwxU1BhY2FyN0tjRmg1Q0xlM3FKVURP?=
 =?utf-8?B?QVdGbmROOUprQW9PRHV5UHBUTlRHRlRjNENQMVlBQXMwaStVbEpzS3ZyeTJa?=
 =?utf-8?B?VXVaWHJENzNWaGhtR0JTeE9PRVluZEdnMjhkdnZwREU1SVFIcVY0YTZqdWNw?=
 =?utf-8?B?SVkxckJSWThBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OG9vdWZBWUkrYTh2VmJkRWN1Z2c0TjVuZFpmRjgreGJlb256ZkR1U2xBUnlp?=
 =?utf-8?B?UVRIWUNldnR4SmFtNFFpRnhmK2pGa1BJbDhTMTdIMVdRUWYrNHBEMFJEN1FW?=
 =?utf-8?B?UVBZMkkvcHVqd0k1THdtSzBUbW5VOHpacDFIUjRhOFJIVjdsV3JvZXJ6QVNV?=
 =?utf-8?B?SzBrQ1FHampDTVVseldNb29jdERBWXBHK1QxMFBKVW42bmNHbDV1QmVkSGY2?=
 =?utf-8?B?cUtGT0hzNm1FV1pqY1d5Qnc5V2FGeENvR3NpL01RSFZHa2cyTXIwNVpFVXpQ?=
 =?utf-8?B?RklqVzFiMWtkdHIzK2MxQWViNUlyakRaZkhvV2xNNmNINnc2ZjFsOFVJck5r?=
 =?utf-8?B?SFhHc1RjQndOTnRCeXE1dk9CbFJ5aDZxcnN2YWpaWWVwUG5JKzgxYlcvb3FG?=
 =?utf-8?B?dW5mbTVtSmJZZEc3MEtGYkRuZVhLZzhPVEdNK3NSMXA3NzZOcjJ5N1VpaHFS?=
 =?utf-8?B?UkI0d0lQSWdCQ2FiZU5XeEYyWHNxYXg3Yi9lbEw1bXo3aVo5NHlGWG5hRkNN?=
 =?utf-8?B?UVcyZlpjQnJ3dlhldmx2RThReWYvUHQ0VDJHUzNWZi9GbWhJY3EvQVlrV056?=
 =?utf-8?B?VDNpekI5MEQ1ZEVXd013aVVlcGFsSURrRTM4NE1kaW9Ed243dkZOelhmTUp4?=
 =?utf-8?B?VjlIaGtjTWpzRjZWYWFGMEh6cnhjWTBWcFdIdnpTWG5tRXEwSjdFUkVQN2x0?=
 =?utf-8?B?ZjV5Wlc3REMvVWE3Zk56eFYyQ3NIVHFKNHBuVUV2L3hOUVdzZEhzaVg0ZWtn?=
 =?utf-8?B?TnVvVUw4aTJyc203U2ppWnpxN3pMNkg1Wlh5ekpnZm1ONUthZ1RlUGh5aXRU?=
 =?utf-8?B?Z2xnSVhlZG92ZU1GenVDN3RpbG9OdFF1L3haeFpaY2trZXZObmpPSmRnNjVs?=
 =?utf-8?B?VGRGYUdxNEhmQXV1bEZPMDk0eUcyK1BlSW1LMURiU2Nhbk1kU2dlejNGTGhz?=
 =?utf-8?B?aGo4bUNCemJLdU1qeDZyK1lEaEo0WG1MeGdrL0EvNU04d1VDMDlHdWllMzQ0?=
 =?utf-8?B?Vkszc1lkdmlyc1RoUlNYMy9GZlRBUVNNaFYzelRhaE1BbHFJVy96OUdTU1Q3?=
 =?utf-8?B?Z09vTm5MSTNORVhXYVdsVHBPM012aTd0OUZ1ZlIrNDdqeWp2K1RFZFAzSkZP?=
 =?utf-8?B?UEhsajc4RDBuWkxTcG95WC80UCs0c01SWkZXbWs4ZWdzcWJQVWJQNFYxTkFr?=
 =?utf-8?B?ZXVBSGMxRndHbG1OY1R5WkpxVDVFSlM4bFkwZWlrbDJqaDMvaEhmdUZjZVg5?=
 =?utf-8?B?dnQvbjI0K2VLck5maVlvc1h1MU02RUJFcjhFMTJlNFFqak01ZEkyN2NoalZ0?=
 =?utf-8?B?Znc1bVBGRGxZRklKODVqNktwZE1DUEVUSTRrd2lCZmdJNVNmdGVSeXpXRkFK?=
 =?utf-8?B?NjUwWDF6d245cEtvaUVvSlFORXFnbEZXYjMvMjNXWS9kYXdTRXVOOERRNDlZ?=
 =?utf-8?B?bDZVWjlmTVdUYkFDMmovaXdZZkEwdm5HVUNyKzUzTWkzc1ZqQkc0Sm1RUVhl?=
 =?utf-8?B?QzJEdktWL2pWaTc0TlhjZlJMZDg3SmY1amR2SUxUdjdPTVpvSU1paFhieEJI?=
 =?utf-8?B?MzNCOTZvcmVIWmsremRNV2NUTVArczg3WEJqc20wKzVEbnNtYnRJNHVyMEth?=
 =?utf-8?B?V05wVU8xMHlwU2JpWnRwREdnakxkc1p6OCtoY0RNb0tEbmpsdlZiWWRNYndn?=
 =?utf-8?B?Ym5QSzFHK3RpN3VVUUVBVUJ6bktDK1RzdG4zUEp5ZUM2SllZbE15UkFBR2lu?=
 =?utf-8?B?dFlHYkNPWEhRelBFa2dBbGxjc3RLTmRmdEFBTWs4dUVGclVQWEl1VHdyTXha?=
 =?utf-8?B?N2hLNllzTmNtSTNxTzhIeEsvSUZpRnFOYUJudndrWVRwYnlYSWZ3eUloNEY5?=
 =?utf-8?B?clJrMXFldDBlV0JnSGZFSmNIVUt5M25iakZmenZ5bjlzcDRNeUc0SjdxbmJZ?=
 =?utf-8?B?NkxkM2FEZnlaRXpjSlRkOEk3ckc2OTdmbzVOdjNjYnpnY2FnWW0zRmxITEkx?=
 =?utf-8?B?SlZSNFNKdVd1RDRhL1VUZTJibVZLTVdFMjlMV3NMOURyRXFLczQyTkJFR2pG?=
 =?utf-8?B?MnRvWHNaREdzSEduQ2wyKzBMOEVieU9kZzE2amZjZVcxaTEyRE5GUEgweGQy?=
 =?utf-8?Q?XFuBLbQsWuyhPy0fypHcCJ7Qc?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f039a40-4ca3-4a64-0386-08dd7b029bad
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2025 03:15:28.7823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +2DZ92PlOz9McBpvnBZddoJQrKztY3XnrsXC2gbkzfQfHKkOolW3H8jA+9gMP67qrPkGhMOfRIY2IApeXIc6KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9782

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2
YW0gPG1hbml2YW5uYW4uc2FkaGFzaXZhbUBsaW5hcm8ub3JnPg0KPiBTZW50OiAyMDI15bm0NOac
iDEz5pelIDIzOjM5DQo+IFRvOiBIb25neGluZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0K
PiBDYzogRnJhbmsgTGkgPGZyYW5rLmxpQG54cC5jb20+OyBsLnN0YWNoQHBlbmd1dHJvbml4LmRl
Ow0KPiBscGllcmFsaXNpQGtlcm5lbC5vcmc7IGt3QGxpbnV4LmNvbTsgcm9iaEBrZXJuZWwub3Jn
Ow0KPiBiaGVsZ2Fhc0Bnb29nbGUuY29tOyBzaGF3bmd1b0BrZXJuZWwub3JnOyBzLmhhdWVyQHBl
bmd1dHJvbml4LmRlOw0KPiBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNv
bTsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnOyBpbXhAbGlzdHMubGludXguZGV2Ow0KPiBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMy82XSBQQ0k6IGlteDY6IFdvcmth
cm91bmQgaS5NWDk1IFBDSWUgbWF5IG5vdCBleGl0DQo+IEwyMyByZWFkeQ0KPiANCj4gT24gVGh1
LCBBcHIgMTAsIDIwMjUgYXQgMDI6NDU6NTFBTSArMDAwMCwgSG9uZ3hpbmcgWmh1IHdyb3RlOg0K
PiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IE1hbml2YW5uYW4g
U2FkaGFzaXZhbSA8bWFuaXZhbm5hbi5zYWRoYXNpdmFtQGxpbmFyby5vcmc+DQo+ID4gPiBTZW50
OiAyMDI15bm0NOaciDEw5pelIDA6NDQNCj4gPiA+IFRvOiBIb25neGluZyBaaHUgPGhvbmd4aW5n
LnpodUBueHAuY29tPg0KPiA+ID4gQ2M6IEZyYW5rIExpIDxmcmFuay5saUBueHAuY29tPjsgbC5z
dGFjaEBwZW5ndXRyb25peC5kZTsNCj4gPiA+IGxwaWVyYWxpc2lAa2VybmVsLm9yZzsga3dAbGlu
dXguY29tOyByb2JoQGtlcm5lbC5vcmc7DQo+ID4gPiBiaGVsZ2Fhc0Bnb29nbGUuY29tOyBzaGF3
bmd1b0BrZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOw0KPiA+ID4ga2VybmVsQHBl
bmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207DQo+ID4gPiBsaW51eC1wY2lAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+ID4gPiBp
bXhAbGlzdHMubGludXguZGV2OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+ID4gPiBT
dWJqZWN0OiBSZTogW1BBVENIIHYzIDMvNl0gUENJOiBpbXg2OiBXb3JrYXJvdW5kIGkuTVg5NSBQ
Q0llIG1heQ0KPiA+ID4gbm90IGV4aXQgTDIzIHJlYWR5DQo+ID4gPg0KPiA+ID4gT24gVHVlLCBB
cHIgMDgsIDIwMjUgYXQgMDM6MDI6NDJBTSArMDAwMCwgSG9uZ3hpbmcgWmh1IHdyb3RlOg0KPiA+
ID4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiA+ID4gRnJvbTogSG9uZ3hp
bmcgWmh1DQo+ID4gPiA+ID4gU2VudDogMjAyNeW5tDTmnIgz5pelIDExOjIzDQo+ID4gPiA+ID4g
VG86IE1hbml2YW5uYW4gU2FkaGFzaXZhbSA8bWFuaXZhbm5hbi5zYWRoYXNpdmFtQGxpbmFyby5v
cmc+DQo+ID4gPiA+ID4gQ2M6IEZyYW5rIExpIDxmcmFuay5saUBueHAuY29tPjsgbC5zdGFjaEBw
ZW5ndXRyb25peC5kZTsNCj4gPiA+ID4gPiBscGllcmFsaXNpQGtlcm5lbC5vcmc7IGt3QGxpbnV4
LmNvbTsgcm9iaEBrZXJuZWwub3JnOw0KPiA+ID4gPiA+IGJoZWxnYWFzQGdvb2dsZS5jb207IHNo
YXduZ3VvQGtlcm5lbC5vcmc7DQo+ID4gPiA+ID4gcy5oYXVlckBwZW5ndXRyb25peC5kZTsga2Vy
bmVsQHBlbmd1dHJvbml4LmRlOw0KPiA+ID4gPiA+IGZlc3RldmFtQGdtYWlsLmNvbTsgbGludXgt
cGNpQHZnZXIua2VybmVsLm9yZzsNCj4gPiA+ID4gPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmlu
ZnJhZGVhZC5vcmc7DQo+ID4gPiA+ID4gaW14QGxpc3RzLmxpbnV4LmRldjsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZw0KPiA+ID4gPiA+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggdjMgMy82XSBQ
Q0k6IGlteDY6IFdvcmthcm91bmQgaS5NWDk1IFBDSWUNCj4gPiA+ID4gPiBtYXkgbm90IGV4aXQN
Cj4gPiA+ID4gPiBMMjMgcmVhZHkNCj4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gPiA+ID4gPiA+IEZyb206IE1hbml2YW5uYW4gU2FkaGFzaXZhbQ0K
PiA8bWFuaXZhbm5hbi5zYWRoYXNpdmFtQGxpbmFyby5vcmc+DQo+ID4gPiA+ID4gPiBTZW50OiAy
MDI15bm0NOaciDLml6UgMjM6MTgNCj4gPiA+ID4gPiA+IFRvOiBIb25neGluZyBaaHUgPGhvbmd4
aW5nLnpodUBueHAuY29tPg0KPiA+ID4gPiA+ID4gQ2M6IEZyYW5rIExpIDxmcmFuay5saUBueHAu
Y29tPjsgbC5zdGFjaEBwZW5ndXRyb25peC5kZTsNCj4gPiA+ID4gPiA+IGxwaWVyYWxpc2lAa2Vy
bmVsLm9yZzsga3dAbGludXguY29tOyByb2JoQGtlcm5lbC5vcmc7DQo+ID4gPiA+ID4gPiBiaGVs
Z2Fhc0Bnb29nbGUuY29tOyBzaGF3bmd1b0BrZXJuZWwub3JnOw0KPiA+ID4gPiA+ID4gcy5oYXVl
ckBwZW5ndXRyb25peC5kZTsga2VybmVsQHBlbmd1dHJvbml4LmRlOw0KPiA+ID4gPiA+ID4gZmVz
dGV2YW1AZ21haWwuY29tOyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOw0KPiA+ID4gPiA+ID4g
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiA+ID4gPiA+ID4gaW14QGxp
c3RzLmxpbnV4LmRldjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiA+ID4gPiA+ID4g
U3ViamVjdDogUmU6IFtQQVRDSCB2MyAzLzZdIFBDSTogaW14NjogV29ya2Fyb3VuZCBpLk1YOTUg
UENJZQ0KPiA+ID4gPiA+ID4gbWF5IG5vdCBleGl0IEwyMyByZWFkeQ0KPiA+ID4gPiA+ID4NCj4g
PiA+ID4gPiA+IE9uIFdlZCwgQXByIDAyLCAyMDI1IGF0IDA3OjU5OjI2QU0gKzAwMDAsIEhvbmd4
aW5nIFpodSB3cm90ZToNCj4gPiA+ID4gPiA+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPiA+ID4gPiA+ID4gPiA+IEZyb206IE1hbml2YW5uYW4gU2FkaGFzaXZhbQ0KPiA+ID4gPiA+
ID4gPiA+IDxtYW5pdmFubmFuLnNhZGhhc2l2YW1AbGluYXJvLm9yZz4NCj4gPiA+ID4gPiA+ID4g
PiBTZW50OiAyMDI15bm0NOaciDLml6UgMTU6MDgNCj4gPiA+ID4gPiA+ID4gPiBUbzogSG9uZ3hp
bmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gPiA+ID4gPiA+ID4gPiBDYzogRnJhbmsg
TGkgPGZyYW5rLmxpQG54cC5jb20+OyBsLnN0YWNoQHBlbmd1dHJvbml4LmRlOw0KPiA+ID4gPiA+
ID4gPiA+IGxwaWVyYWxpc2lAa2VybmVsLm9yZzsga3dAbGludXguY29tOyByb2JoQGtlcm5lbC5v
cmc7DQo+ID4gPiA+ID4gPiA+ID4gYmhlbGdhYXNAZ29vZ2xlLmNvbTsgc2hhd25ndW9Aa2VybmVs
Lm9yZzsNCj4gPiA+ID4gPiA+ID4gPiBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBrZXJuZWxAcGVu
Z3V0cm9uaXguZGU7DQo+ID4gPiA+ID4gPiA+ID4gZmVzdGV2YW1AZ21haWwuY29tOyBsaW51eC1w
Y2lAdmdlci5rZXJuZWwub3JnOw0KPiA+ID4gPiA+ID4gPiA+IGxpbnV4LWFybS1rZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZzsNCj4gPiA+ID4gPiA+ID4gPiBpbXhAbGlzdHMubGludXguZGV2OyBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+ID4gPiA+ID4gPiA+ID4gU3ViamVjdDogUmU6
IFtQQVRDSCB2MyAzLzZdIFBDSTogaW14NjogV29ya2Fyb3VuZCBpLk1YOTUNCj4gPiA+ID4gPiA+
ID4gPiBQQ0llIG1heSBub3QgZXhpdCBMMjMgcmVhZHkNCj4gPiA+ID4gPiA+ID4gPg0KPiA+ID4g
PiA+ID4gPiA+IE9uIEZyaSwgTWFyIDI4LCAyMDI1IGF0IDExOjAyOjEwQU0gKzA4MDAsIFJpY2hh
cmQgWmh1IHdyb3RlOg0KPiA+ID4gPiA+ID4gPiA+ID4gRVJSMDUxNjI0OiBUaGUgQ29udHJvbGxl
ciBXaXRob3V0IFZhdXggQ2Fubm90IEV4aXQgTDIzDQo+ID4gPiA+ID4gPiA+ID4gPiBSZWFkeSBU
aHJvdWdoIEJlYWNvbiBvciBQRVJTVCMgRGUtYXNzZXJ0aW9uDQo+ID4gPiA+ID4gPiA+ID4NCj4g
PiA+ID4gPiA+ID4gPiBJcyBpdCBwb3NzaWJsZSB0byBzaGFyZSB0aGUgbGluayB0byB0aGUgZXJy
YXR1bT8NCj4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiBTb3JyeSwgdGhlIGVycmF0dW0g
ZG9jdW1lbnQgaXNuJ3QgcmVhZHkgdG8gYmUgcHVibGlzaGVkIHlldC4NCj4gPiA+ID4gPiA+ID4g
PiA+DQo+ID4gPiA+ID4gPiA+ID4gPiBXaGVuIHRoZSBhdXhpbGlhcnkgcG93ZXIgaXMgbm90IGF2
YWlsYWJsZSwgdGhlDQo+ID4gPiA+ID4gPiA+ID4gPiBjb250cm9sbGVyIGNhbm5vdCBleGl0IGZy
b20NCj4gPiA+ID4gPiA+ID4gPiA+IEwyMyBSZWFkeSB3aXRoIGJlYWNvbiBvciBQRVJTVCMgZGUt
YXNzZXJ0aW9uIHdoZW4gbWFpbg0KPiA+ID4gPiA+ID4gPiA+ID4gcG93ZXIgaXMgbm90IHJlbW92
ZWQuDQo+ID4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4g
SSBkb24ndCB1bmRlcnN0YW5kIGhvdyB0aGUgcHJlc2VuY2Ugb2YgVmF1eCBhZmZlY3RzIHRoZQ0K
PiBjb250cm9sbGVyLg0KPiA+ID4gPiA+ID4gPiA+IFNhbWUgZ29lcyBmb3IgUEVSU1QjIGRlYXNz
ZXJ0aW9uLiBIb3cgZG9lcyB0aGF0IHJlbGF0ZSB0bw0KPiA+ID4gPiA+ID4gPiA+IFZhdXg/IElz
IHRoaXMgZXJyYXR1bSBmb3IgYSBzcGVjaWZpYyBlbmRwb2ludCBiZWhhdmlvcj8NCj4gPiA+ID4g
PiA+ID4gSU1ITyBJIGRvbid0IGtub3cgdGhlIGV4YWN0IGRldGFpbHMgb2YgdGhlIHBvd2VyIHN1
cHBsaWVzIGluDQo+ID4gPiA+ID4gPiA+IHRoaXMgSVANCj4gPiA+IGRlc2lnbi4NCj4gPiA+ID4g
PiA+ID4gUmVmZXIgdG8gbXkgZ3Vlc3MgLCBtYXliZSB0aGUgYmVhY29uIGRldGVjdCBvciB3YWtl
LXVwIGxvZ2ljDQo+ID4gPiA+ID4gPiA+IGluIGRlc2lnbnMgaXMgIHJlbGllZCBvbiB0aGUgc3Rh
dHVzIG9mIFNZU19BVVhfUFdSX0RFVA0KPiA+ID4gPiA+ID4gPiBzaWduYWxzIGluIHRoaXMNCj4g
PiA+IGNhc2UuDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gQ2FuIHlvdSBwbGVhc2UgdHJ5IHRv
IGdldCBtb3JlIGRldGFpbHM/IEkgY291bGRuJ3QgdW5kZXJzdGFuZCB0aGUNCj4gZXJyYXRhLg0K
PiA+ID4gPiA+ID4NCj4gPiA+ID4gPiBTdXJlLiBXaWxsIGNvbnRhY3QgZGVzaWduZXIgYW5kIHRy
eSB0byBnZXQgbW9yZSBkZXRhaWxzLg0KPiA+ID4gPiBIaSBNYW5pOg0KPiA+ID4gPiBHZXQgc29t
ZSBpbmZvcm1hdGlvbiBmcm9tIGRlc2lnbnMsIHRoZSBpbnRlcm5hbCBkZXNpZ24gbG9naWMgaXMN
Cj4gPiA+ID4gcmVsaWVkIG9uIHRoZSAgc3RhdHVzIG9mIFNZU19BVVhfUFdSX0RFVCBzaWduYWwg
dG8gaGFuZGxlIHRoZSBsb3cNCj4gcG93ZXIgc3R1ZmYuDQo+ID4gPiA+IFNvLCB0aGUgU1lTX0FV
WF9QV1JfREVUIGlzIHJlcXVpcmVkIHRvIGJlIDFiJzEgaW4gdGhlIFNXDQo+IHdvcmthcm91bmQu
DQo+ID4gPiA+DQo+ID4gPg0KPiA+ID4gT2suIFNvIGR1ZSB0byB0aGUgZXJyYXRhLCB3aGVuIHRo
ZSBsaW5rIGVudGVycyBMMjMgUmVhZHkgc3RhdGUsIGl0DQo+ID4gPiBjYW5ub3QgdHJhbnNpdGlv
biB0byBMMyB3aGVuIFZhdXggaXMgbm90IGF2YWlsYWJsZS4gQW5kIHRoZQ0KPiA+ID4gd29ya2Fy
b3VuZCByZXF1aXJlcyBzZXR0aW5nIFNZU19BVVhfUFdSX0RFVCBiaXQ/DQo+ID4gPg0KPiA+IFJl
ZmVyIHRvIHRoZSBkZXNjcmlwdGlvbiBvZiB0aGlzIGVycmF0YSwgaXQganVzdCBtZW50aW9ucyB0
aGUgZXhpc3QNCj4gPiBmcm9tDQo+ID4gIEwyMyBSZWFkeSBzdGF0ZS4NCj4gDQo+IEV4aXRpbmcg
ZnJvbSBMMjMgUmVhZHkgPT0gZW50ZXJpbmcgTDIvTDMuIEFuZCBzaW5jZSB5b3UgbWVudGlvbmVk
IHRoYXQgVmF1eA0KPiBpcyBub3QgYXZhaWxhYmxlLCBpdCBpcyBkZWZpbml0ZWx5IGVudGVyaW5n
IEwzLg0KPiANCj4gPiBZZXMsIHRoZSB3b3JrYXJvdW5kIHJlcXVpcmVzIHNldHRpbmcgU1lTX0FV
WF9QV1JfREVUIGJpdCB0byAxYicxLg0KPiA+DQo+ID4gPiBJSVVDLCB0aGUgaXNzdWUgaGVyZSBp
cyB0aGF0IHRoZSBjb250cm9sbGVyIGlzIG5vdCBhYmxlIHRvIGRldGVjdA0KPiA+ID4gdGhlIHBy
ZXNlbmNlIG9mIFZhdXggaW4gdGhlIEwyMyBSZWFkeSBzdGF0ZS4gU28gaXQgcmVsaWVzIG9uIHRo
ZQ0KPiA+ID4gU1lTX0FVWF9QV1JfREVUIGJpdC4gQnV0IGV2ZW4gaW4gdGhhdCBjYXNlLCBob3cg
d291bGQgeW91IHN1cHBvcnQgdGhlDQo+IGVuZHBvaW50ICp3aXRoKiBWYXV4Pw0KPiA+ID4NCj4g
PiBUaGlzIGVycmF0YSBpcyBvbmx5IGFwcGxpZWQgZm9yIGkuTVg5NSBkdWFsIFBDSWUgbW9kZSBj
b250cm9sbGVyLg0KPiA+IFRoZSBWYXV4IGlzIG5vdCBwcmVzZW50IGZvciBpLk1YOTUgUENJZSBF
UCBtb2RlIGVpdGhlci4NCj4gPg0KPiANCj4gRmlyc3Qgb2YgYWxsLCBkb2VzIHRoZSBjb250cm9s
bGVyIHJlYWxseSBrbm93IHdoZXRoZXIgVmF1eCBpcyBzdXBwbGllZCB0byB0aGUNCj4gZW5kcG9p
bnQgb3Igbm90PyBBRkFJSywgaXQgaXMgdXAgdG8gdGhlIGJvYXJkIGRlc2lnbmVycyB0byByb3V0
ZSBWYXV4IGFuZCBvbmx5DQo+IGVuZHBvaW50IHNob3VsZCBjYXJlIGFib3V0IGl0Lg0KPiANCj4g
SSBzdGlsbCBmZWVsIHRoYXQgdGhpcyBzcGVjaWZpYyBlcnJhdHVtIGlzIGZvciBmaXhpbmcgdGhl
IGlzc3VlIHdpdGggc29tZSBlbmRwb2ludHMNCj4gd2hlcmUgVmF1eCBpcyBub3Qgc3VwcGxpZWQg
YW5kIHRoZSBsaW5rIGRvZXNuJ3QgZXhpdCBMMjMgUmVhZHkuIEFnYWluLCB3aGF0DQo+IHdvdWxk
IGJlIHRoZSBiZWhhdmlvciBpZiBWYXV4IGlzIHN1cHBsaWVkIHRvIHRoZSBlbmRwb2ludD8gWW91
IGNhbm5vdCBqdXN0IHNheQ0KPiB0aGF0IHRoZSBjb250cm9sbGVyIGRvZXNuJ3Qgc3VwcG9ydCBW
YXV4LCB3aGljaCBpcyBub3QgYSB2YWxpZCBzdGF0ZW1lbnQgSU1PLg0KPiANClNvcnJ5LCBJIG1p
c3MtdW5kZXJzdGFuZCB0aGUgcXVlc3Rpb24geW91IHBvc3RlZCBpbiB0aGUgcHJldmlvdXMgcmVw
bHkuDQpJIGdldCB0aGUgZm9sbG93aW5nIGFuc3dlciBmcm9tIGRlc2lnbmVycyB3aGVuIHRoZSBW
YXV4IGlzIHN1cHBsaWVkIHRvIHRoZQ0KIHJlbW90ZSBlbmRwb2ludC4gSG9wZSBpdCBjYW4gZ2V0
IHJpZGUgb2YgeW91ciBjb25jZXJucy4NClE6DQpIb3cgYWJvdXQgdGhlIHNpdHVhdGlvbnMgd2hl
biByZW1vdGUgcGFydG5lciBoYXMgdGhlIFZhdXggcHJlc2VudD8NCkZvciBleGFtcGxlLCBpLk1Y
OTUgUENJZSB1c2VkIGFzIFJDLCBhbmQgYSBlbmRwb2ludCBkZXZpY2Ugd2l0aCBvbmUgVmF1eA0K
IHByZXNlbnQgaXMgY29ubmVjdGVkIHRvIGkuTVg5NSBQQ0llIFJDLg0KDQpBOg0KIiBBcyBwZXIg
bXkgdW5kZXJzdGFuZGluZyBpdCBzaG91bGQgd29yayBpcnJlc3BlY3RpdmUgb2YgdmF1eCBwcmVz
ZW5jZSBpbiByZW1vdGUgcGFydG5lci4iDQoNCkJlc3QgUmVnYXJkcw0KUmljaGFyZCBaaHUNCg0K
PiAtIE1hbmkNCj4gDQo+IC0tDQo+IOCuruCuo+Cuv+CuteCuo+CvjeCuo+CuqeCvjSDgrprgrqTg
rr7grprgrr/grrXgrq7gr40NCg==

