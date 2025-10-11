Return-Path: <linux-pci+bounces-37835-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D930EBCEE19
	for <lists+linux-pci@lfdr.de>; Sat, 11 Oct 2025 03:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 859674E49EC
	for <lists+linux-pci@lfdr.de>; Sat, 11 Oct 2025 01:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E5A126BF1;
	Sat, 11 Oct 2025 01:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="OxlCp1VJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011013.outbound.protection.outlook.com [52.101.125.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF44378F20;
	Sat, 11 Oct 2025 01:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760146780; cv=fail; b=jL7f6pKZdxyP61YvEEsMv15TAwnwB4J2mri5R5iHiVNQVGxXjx/PTWTCA7yoOYF+M7e3ObyJliH5RZqSo9zyqSdav+H4jKMKLVoh/l9X8J6HjjofrzWx4VSjRCWlDb2aGxj9Yb+uMyQBRtbs3SXWLuJvkGfKCQcKvwnjEM2H+TU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760146780; c=relaxed/simple;
	bh=9Uqaaa/agjSGxCmSCQtsKVEr3IH96iMc0/gndLRRZ3A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XQPVmUi1/0LiXU30Ux6cDVqzsOAb04ZZw2YhYfSl6BB5H+d2sA22N4vmsIttH4M86FgGkzkgpeM3YxykY3armcldeE3KBJNihOGKzte68qxitdlKS1DVJkdyS/EuWyIRbVXpcgeVbz+BpZYDZZoi4dc7BdE6760MB1RjGQ9zoDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=OxlCp1VJ; arc=fail smtp.client-ip=52.101.125.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MFcDEOmX+BMDF7gXsiPV94i8l7zZKiIp4gPtgjJbrCrc5rrl26GVN1D/Aa0wW2b8K1mw9RszVPhgF4yVuMcNuHVTN/j9bVHqMoeKv2BM2yyKmJ7wQKe+0pGGN2YwHgtJ5WmL46PkoVS82wZTy4Br8SWHAg9O6+ZBnDvEF4kf6yGBz5Dp7paLgPbHJAGQu8V9VHFQeJdl098PNMJMudK7UnFz+3o1rehsA2tkqB1zm119ReEYH4Efe5ozEMmM10TLTUQrxZZoXRQ2i6PHLNHVOJY+BzkS8dxrgdA4+tQRAv+Vf1iWGu+nsFkLKpmzDlUW1xtjf94QomtWIHLxTRwN0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Uqaaa/agjSGxCmSCQtsKVEr3IH96iMc0/gndLRRZ3A=;
 b=OQJk9nlc6p5PkWts6z2ybgxfHE7jRtA0PeoYTcM+Lv8fLW7y8S0AT/zJJN4gbOTJGxPlVOSKSQzoNulVB6s3Fq6f3lZ8its3uRsslLhEqb8U8gMd2r4Sd8Gxy8u2PoCA23inl6Gl2yN1WMhqsoHEDb3JFrHK8IEcD3CijqNv50b10IFWSBW5dMVileHiz4pn/e8lsTTo1FEjVrg2OGIobA4mGF/sIGAegPQZSPquT80y0ipkg/IEuel0ljAxU/ezoerzFEzJpU4DeoxnxlAMVIP71Eg77phb7SRXQ5yvQMI8PRxag5I0mK1ahR6AFd9lbW7umSWIFApWpM9E0muljw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Uqaaa/agjSGxCmSCQtsKVEr3IH96iMc0/gndLRRZ3A=;
 b=OxlCp1VJmztE+UEhtYok/6gRgdea9JpMefOO7GJzyOjZuGToGr7EifIQ/IV+6Fv+C68J0wRrfW9ldt7d5rtDCIgUae7nNTBn9TbKF7auZdZfHpqYPDQmvytn3jUWiBmwvbS6B6EzRI8R2TBLNA8I+y/jHZb6PSvAdSqD+6BoSKg=
Received: from TYCPR01MB11332.jpnprd01.prod.outlook.com (2603:1096:400:3c0::7)
 by TYCPR01MB8190.jpnprd01.prod.outlook.com (2603:1096:400:103::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Sat, 11 Oct
 2025 01:39:33 +0000
Received: from TYCPR01MB11332.jpnprd01.prod.outlook.com
 ([fe80::2511:10cd:e497:4d97]) by TYCPR01MB11332.jpnprd01.prod.outlook.com
 ([fe80::2511:10cd:e497:4d97%6]) with mapi id 15.20.9228.005; Sat, 11 Oct 2025
 01:39:28 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Claudiu.Beznea <claudiu.beznea@tuxon.dev>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"geert+renesas@glider.be" <geert+renesas@glider.be>, magnus.damm
	<magnus.damm@gmail.com>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>, wsa+renesas
	<wsa+renesas@sang-engineering.com>
Subject: RE: [PATCH v5 3/6] arm64: dts: renesas: r9a08g045: Add PCIe node
Thread-Topic: [PATCH v5 3/6] arm64: dts: renesas: r9a08g045: Add PCIe node
Thread-Index: AQHcN4+Xl3bUT1Hya0C1BFZ2Fpr8n7S2sSOwgASOuYCAAAQDwIAA7Dsg
Date: Sat, 11 Oct 2025 01:39:28 +0000
Message-ID:
 <TYCPR01MB11332C3B841AAD1EA8459129486ECA@TYCPR01MB11332.jpnprd01.prod.outlook.com>
References: <20251007133657.390523-1-claudiu.beznea.uj@bp.renesas.com>
 <20251007133657.390523-4-claudiu.beznea.uj@bp.renesas.com>
 <TY3PR01MB113461AF51BD346E1D96E43B486E0A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <7848e331-3d32-42ee-a05f-66ab40ef00be@tuxon.dev>
 <TY3PR01MB11346B3365740A98B6B52872D86EFA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To:
 <TY3PR01MB11346B3365740A98B6B52872D86EFA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11332:EE_|TYCPR01MB8190:EE_
x-ms-office365-filtering-correlation-id: a3d136d9-50f9-49cb-ca58-08de08670483
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?NExmMXlrVnNOL04rNWJ2TFRRSFdLbGRKMTdmZi9DR2xVVkx2ZkN0cjVkNzk0?=
 =?utf-8?B?d3MxSmZGZllJeC9QUHpiOGNkWlVzZGpSY0lQdTV4Y1VMaS9FeG4wTThaREhW?=
 =?utf-8?B?aDIrN0dnZmlGV09QRWtuUVVZV1BQTFcwVm1CUWlwTER3MFJtUU5XUEJMWnVv?=
 =?utf-8?B?UG1tdzJLcGRkbFViSmxKVDhnRStNc1dsTVRKNC9IYzFMVjBVOFlLZjM4and6?=
 =?utf-8?B?cU5rU2g5V0lNVTgwQ0dkNStXcTVuWUhETTRPczRzVCt5N1c3Y0svL3hwZmVw?=
 =?utf-8?B?ZXVTVFVuU25ROFJ6ZWlTVURia2FCWDArSkhiaGY2bUEyMUlzZG11dXU1Tllo?=
 =?utf-8?B?K1ZIbVdHMm5PUDVjRUYzK3BMbFIvanRPUkFvN3ZGMXcrOGVXckZlMmZzcXFs?=
 =?utf-8?B?VS9CRTNFem5OYUNQVSsrbnhhQzhoaWIrclU5a2dGQXdjN2VsTmhlVFg2QVJN?=
 =?utf-8?B?WFRCSWVwekZnRDducGgyWGpwR1RHUG4yN0hzV2UyWndqSGVvbDJjMjgrSVdn?=
 =?utf-8?B?bkZCWGJ0OGdzUzB1NFdDMlFIWC9sZ1VNYmdyYVV3aVNRUWM4L2dNWEtpRjVQ?=
 =?utf-8?B?MkkwUy9Ta09lTkx2MTQ1b2ZybHFpWjZ5WW1HUHd5VTZsVU5NMmRrUmNXc2di?=
 =?utf-8?B?SDJTWE92RzFmaGN2a29sRDAwOW5mSEp2VDVGMk91N29RL0ljV0o2cjhMMldX?=
 =?utf-8?B?VGNWRzh0YVhOcmxQdWZjWnIzbnoxOVl2TGFZMEtnblh5SmhOR1c1Q2JUUTlD?=
 =?utf-8?B?UFZXNEtwajFERDdEVHdqbmxwUEhlcHpseS94M0ZiaDE1TjlHcUtrbksrL0tE?=
 =?utf-8?B?NzFiUXVwamFwMHY3WFlEa1ExRHo2MkJOZFFuYllPQkExc1k1eEtBN1F2Wmxr?=
 =?utf-8?B?amFsazV5YWZFVG1zL2I5ZjVkakJmaUkraXpXNGZETkczZWxidTR3elBHZlA4?=
 =?utf-8?B?dGMrNytrRDlYUEZpNXlVd0NtUGdidjlFakZaNnE2bitlc3pCbEdMUm1QTnJa?=
 =?utf-8?B?TmtzeHhSeW9BeGFpS2E4RE0rejdGRHJIa1RpV3ZadGRwbU12RWlYUG02N0t4?=
 =?utf-8?B?aC9hVXJwWjdzTS9PN2hhb2VHWkk0b0tSY1FaS1hzY1I4a2J5QzlDZWdnTHZi?=
 =?utf-8?B?eEdrMU03M1lOaExFVEx5a1Q2RHhZY1ZEa3R2d2Z2SGxrbTJYV0VMODhzWGRS?=
 =?utf-8?B?Q0MzOWRjc3plaGl6aGcrYVdVOWFXeVV6UmVOeVRBSSt3WTczQ0dPVmpyMEdD?=
 =?utf-8?B?MkJKL1cxeSt1cmtMSUtDb2tzSU9JSDduTlVBMVlkSnBlTVJCRVFPT1Z4MDN0?=
 =?utf-8?B?eTFpZkFjczA1aythRXROQUdHRi96R0NRTXVuVFArcytnRGtIL0tUZURncTJY?=
 =?utf-8?B?VTNWbGtVNUhleW8xRGhNR3h4QStlQ1U0MWZ2M2U2RDRCRGhGZzh6VU52QVRN?=
 =?utf-8?B?aDR3TzJnM1FhLzJHVWhFZnQ0QXRwTUg2TXl5aHhxTU1BbnhwUkd1ZmFLWHVY?=
 =?utf-8?B?Y01RR21SaWxDN1FnanVMSXJJazBLSjZmcys4T3kvSy9OaTVKdTA4QnJhWFM2?=
 =?utf-8?B?cURLb2RyVVp2TVRKbGFLcnU3d3FDSkFKV1VmZFJ4cFZoeGtYNkhiRnFUSWhD?=
 =?utf-8?B?b2NuRG53d1g5UXJMc1JWZ0krbmE1ZFZuYVNPWVdES2NzYW1vNkdUV2JiMEJS?=
 =?utf-8?B?UnpDbHFGR0FCRDNpcXBWK0NPSzVPVms3ZjFmVmdRektSajBleXhsMTMrU2ds?=
 =?utf-8?B?S1ZCUVZLNmVZcEQzRzdhS3hiYzFram5USnZqQ1FreWJ5b3R4bVI1RFZBa2VQ?=
 =?utf-8?B?dVlTdXg5TEpFYWEzdGFGeXJ4ZVF2UDRReEhwNytBVlNBZ1ZhbmNsbjhlZThv?=
 =?utf-8?B?MExWNnA5SXZGRkM2M0xYdVFSMHlTK3UwOWZsZzVjUUw4ejFCbEVWc1pyZFBu?=
 =?utf-8?B?dlhxdGRPZ01BK2RtMnRQUXJuRGtyRHMrZlZrSHord0YydFh1Q3RWUDljUE1N?=
 =?utf-8?B?Z25ITnBqems0Z3BiallFV29iZktrdFpHM3BlV0RqNytSU0UwY3UwWlFMTlBE?=
 =?utf-8?B?bi9aUVROVGxldXlRU2d3MEZMaFZmNXFhZ2RsZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11332.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MXUzdmpLS2FzcjlNU25vZ3MyYXFhSnNBZ1g5VjQ0aG15Vy9JL3Mrb1VXZ3Ez?=
 =?utf-8?B?LzY4N01rVEY3TkEvcFNmR0xaa1JkeEtLaWRGdHdnbktyRGwwTWw5ZFlvUEJu?=
 =?utf-8?B?ZUk0QytyRTdBb2hrMFVoOEJTTkl2bURBR2hPcS9UL2pJTVdmL3czMEZ5YTRl?=
 =?utf-8?B?SG5pSzJvWHVaNHRhMjJieDVWZVA1SXE5VEtTd3FXN0FZN1JvK3FFTk84NW9r?=
 =?utf-8?B?TDdKY3Z3ZWY5L3lZWlgxQnFMbTRtNTEyMENONDBDUjBnYlJMQVBOOUxyd3lq?=
 =?utf-8?B?cmRxZUhJMk9Xdk9GMzlxelpIVUxxQkFTVFl2TGFITndUSnRkWDNLUldSTjkx?=
 =?utf-8?B?Z3BOSVc2NWF3NnBzR2ZFUkRVY1Q0ajBJcmthWkEyalQzbnNxZWZDN3Y3Sk9S?=
 =?utf-8?B?MEcwSU9KVXBEZ29Jcy9WU3pRejU4U0RxOTFxREFuU05ILzlyaStmV0NoRHJN?=
 =?utf-8?B?TFFRZklqa0FKWXhpNDNRRUxqVTN5M2RqVjBVY1N5T0VyUVoranpLY3VZblJh?=
 =?utf-8?B?ekY4b3ZwdzZ6ODE2OU95SytOMzc4YTg1YkZmWlBOZ0pXK3QyR3pON0N3R1NQ?=
 =?utf-8?B?QXQveFRKVG5qWFZaUmg2SlZFbWpRK3ZuYktMdHJkaldRUzdPbDZTMVV2a2VC?=
 =?utf-8?B?SUx5eVE3V1FYRER4czlhd0Z1Zk5iQ2w3ZHFHOEN4bVdldmZVRGZiaHVCYXl6?=
 =?utf-8?B?VndIZjNWOUZJL3grUGlmZjZZbFdBV1BRdGhMWVpKMk4xNDRabldCUW5MUUZM?=
 =?utf-8?B?YkM5V2RXdllpTjFwUDI4UExOYVJxc2YxdGJBSyt1WXdDaTZjbFRCWlZKbXBr?=
 =?utf-8?B?ZlRBd2d3RzVYQ2Z5TTV2UHNnSS9mS0pFYkNsaFdXcFNaQXo0dkRiVlVBbCtl?=
 =?utf-8?B?bnkrRHZVQ1B1VSt0b05VUE1pQUIrMzF2MG5NL0VMMXB0TEdlRUNUMldTSFEz?=
 =?utf-8?B?c2dwZGFpUzRZelh3OWZrWko5MVpLWlZteWlRekRLNmk3OGp6RldIcXFZMmdQ?=
 =?utf-8?B?bW1wMlA1eXlSSFpQNjRuWHhsQ1lJR016MzI1dGFZS2RVNzBsM0xoWFZ3enVG?=
 =?utf-8?B?SlRyS2RFT21WRW1WM1lPcXNSSkJ1TWJZbFVGOEtWWjdsdGR1TnVwc1V4ODUx?=
 =?utf-8?B?Z1ZPTEkvTEw3eEhDTUNuVTFJMldtYmloTFlEM3ROWHJ2dWlpQkl1WEl0WWZz?=
 =?utf-8?B?YzRXdGFITEw3OWhKalVQbnk4bUI2TFg4VU5MOVMzd2s3RG42OFNwTEgrQUll?=
 =?utf-8?B?MDVNejdKTmtmZzEwKzVJYnI2QjdIZXZza05NRXNiOER5eDJUb3AyNk5mWWdt?=
 =?utf-8?B?WE1iNUtoSTJKOEFtUVhFZVBCUXhyWG40U21RbnJIeUpwYU41VU54RWRldk5x?=
 =?utf-8?B?WFptSEg0dUVCLzhKOU5DdzlrSlgrbEtOVjFaOHJKeGpQZXpqNi9xeTlsY0hU?=
 =?utf-8?B?MWF0YlM3UVMweGNCUUhqQituK3I3WC8yc0J4TUNyODVXRldzTVkrZFpaM041?=
 =?utf-8?B?UVlkL1BnTStpcUFOTG0wZ0ZHNk0yTFh4UjNWN2ZMMkx2bkpzdGJsa05NdHFp?=
 =?utf-8?B?bW5iUzRQcVhFV2tVcHFRU0VEMW9WMWJLUTBwS1pMM01CSktXSVFURDJ2cTI5?=
 =?utf-8?B?Vk1Peml4aW13WEVCZTM5MDRkbFJPc1JpSDN1eVNoM1JMRG5pa0lrY0dOV0RN?=
 =?utf-8?B?c0ZsNkFFUU55TmtZZHlPdjNUNlpmTEtXODc5TXdSR045bTh4TktXWTVNdGZH?=
 =?utf-8?B?d1hMUzlVOGZVcmtWVGVXTVlPcEttNDlIdWxLUFF4bEF1RmtDcTYvR3JVSnNZ?=
 =?utf-8?B?WDZLWVNIM2ordEIzSjhzcnFCcnROVklRT3VnR05IMGFhTWg0SFVsWk85Tlhk?=
 =?utf-8?B?b3hCSjNZNy9idVN2QlBIMzRzdTV0OXFzM1dMM3hXQW9FWEZOOXhIZVg2RDAx?=
 =?utf-8?B?WEdWSjAwQzVyZWY4VEZ3SUN2cjZuNTNBMzJ5STVKRXhuVFdzczBQN3NaSUU2?=
 =?utf-8?B?YnpvMmJNMUJzQmhqNUZIMy9maFF4UzVXanRuVCtNT2MxWndzblVUU2VWcFc2?=
 =?utf-8?B?WDlBSFljL0JtbHBvMWorVFBWOGdKbHFqbkJ6Zk0xWkh4N2wvRGZBeHhyZGJr?=
 =?utf-8?Q?SOi70Z529WvPfAtugOqxYvcng?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11332.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3d136d9-50f9-49cb-ca58-08de08670483
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2025 01:39:28.3306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I4YxxME4nuYdbXLsnGh4I6cQWU1yg2HLpGIR4WqaqZAQkaFaUL4XyPZsnHXgkQxflmqA2vZfc0vM9Mt0cS+EeDy3ciB68TPyZ0DKVebI9E4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8190

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmlqdSBEYXMNCj4gU2Vu
dDogMTAgT2N0b2JlciAyMDI1IDEyOjM3DQo+IFRvOiAnQ2xhdWRpdSBCZXpuZWEnIDxjbGF1ZGl1
LmJlem5lYUB0dXhvbi5kZXY+OyBscGllcmFsaXNpQGtlcm5lbC5vcmc7IGt3aWxjenluc2tpQGtl
cm5lbC5vcmc7DQo+IG1hbmlAa2VybmVsLm9yZzsgcm9iaEBrZXJuZWwub3JnOyBiaGVsZ2Fhc0Bn
b29nbGUuY29tOyBrcnprK2R0QGtlcm5lbC5vcmc7IGNvbm9yK2R0QGtlcm5lbC5vcmc7DQo+IGdl
ZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlOyBtYWdudXMuZGFtbSA8bWFnbnVzLmRhbW1AZ21haWwuY29t
PjsgcC56YWJlbEBwZW5ndXRyb25peC5kZQ0KPiBDYzogbGludXgtcGNpQHZnZXIua2VybmVsLm9y
ZzsgbGludXgtcmVuZXNhcy1zb2NAdmdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2Vy
bmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IENsYXVkaXUgQmV6bmVh
IDxjbGF1ZGl1LmJlem5lYS51akBicC5yZW5lc2FzLmNvbT47IHdzYStyZW5lc2FzIDx3c2ErcmVu
ZXNhc0BzYW5nLQ0KPiBlbmdpbmVlcmluZy5jb20+DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggdjUg
My82XSBhcm02NDogZHRzOiByZW5lc2FzOiByOWEwOGcwNDU6IEFkZCBQQ0llIG5vZGUNCj4gDQo+
IEhpIENsYXVkaXUsDQo+IA0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJv
bTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQHR1eG9uLmRldj4NCj4gPiBTZW50OiAx
MCBPY3RvYmVyIDIwMjUgMTI6MTgNCj4gLD4gU3ViamVjdDogUmU6IFtQQVRDSCB2NSAzLzZdIGFy
bTY0OiBkdHM6IHJlbmVzYXM6IHI5YTA4ZzA0NTogQWRkIFBDSWUgbm9kZQ0KPiA+DQo+ID4gSGks
IEJpanUsDQo+ID4NCj4gPiBPbiAxMC83LzI1IDE2OjQ0LCBCaWp1IERhcyB3cm90ZToNCj4gPiA+
IEhpIENsYXVkaXUsDQo+ID4gPg0KPiA+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
ID4gPj4gRnJvbTogQ2xhdWRpdSA8Y2xhdWRpdS5iZXpuZWFAdHV4b24uZGV2Pg0KPiA+ID4+IFNl
bnQ6IDA3IE9jdG9iZXIgMjAyNSAxNDozNw0KPiA+ID4+IFN1YmplY3Q6IFtQQVRDSCB2NSAzLzZd
IGFybTY0OiBkdHM6IHJlbmVzYXM6IHI5YTA4ZzA0NTogQWRkIFBDSWUNCj4gPiA+PiBub2RlDQo+
ID4gPj4NCj4gPiA+PiBGcm9tOiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWEudWpAYnAu
cmVuZXNhcy5jb20+DQo+ID4gPj4NCj4gPiA+PiBUaGUgUlovRzNTIFNvQyBoYXMgYSB2YXJpYW50
IChSOUEwOEcwNDVTMzMpIHdoaWNoIHN1cHBvcnRzIFBDSWUuIEFkZCB0aGUgUENJZSBub2RlLg0K
PiA+ID4+DQo+ID4gPj4gVGVzdGVkLWJ5OiBXb2xmcmFtIFNhbmcgPHdzYStyZW5lc2FzQHNhbmct
ZW5naW5lZXJpbmcuY29tPg0KPiA+ID4+IFJldmlld2VkLWJ5OiBHZWVydCBVeXR0ZXJob2V2ZW4g
PGdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlPg0KPiA+ID4+IFNpZ25lZC1vZmYtYnk6IENsYXVkaXUg
QmV6bmVhIDxjbGF1ZGl1LmJlem5lYS51akBicC5yZW5lc2FzLmNvbT4NCj4gPiA+PiAtLS0NCj4g
PiA+Pg0KPiA+ID4+IENoYW5nZXMgaW4gdjU6DQo+ID4gPj4gLSB1cGRhdGVkIHRoZSBsYXN0IHBh
cnQgb2YgcmFuZ2VzIGFuZCBkbWEtcmFuZ2VzDQo+ID4gPj4gLSBjb2xsZWN0ZWQgdGFncw0KPiA+
ID4+DQo+ID4gPj4gQ2hhbmdlcyBpbiB2NDoNCj4gPiA+PiAtIG1vdmVkIHRoZSBub2RlIHRvIHI5
YTA4ZzA0NS5kdHNpDQo+ID4gPj4gLSBkcm9wcGVkIHRoZSAiczMzIiBmcm9tIHRoZSBjb21wYXRp
YmxlIHN0cmluZw0KPiA+ID4+IC0gYWRkZWQgcG9ydCBub2RlDQo+ID4gPj4gLSByZS1vcmRlcmVk
IHByb3BlcnRpZXMgdG8gaGF2ZSB0aGVtIGdyb3VwZWQgdG9nZXRoZXINCj4gPiA+Pg0KPiA+ID4+
IENoYW5nZXMgaW4gdjM6DQo+ID4gPj4gLSBjb2xsZWN0ZWQgdGFncw0KPiA+ID4+IC0gY2hhbmdl
ZCB0aGUgcmFuZ2VzIGZsYWdzDQo+ID4gPj4NCj4gPiA+PiBDaGFuZ2VzIGluIHYyOg0KPiA+ID4+
IC0gdXBkYXRlZCB0aGUgZG1hLXJhbmdlcyB0byByZWZsZWN0IHRoZSBTb0MgY2FwYWJpbGl0eTsg
YWRkZWQgYQ0KPiA+ID4+ICAgY29tbWVudCBhYm91dCBpdC4NCj4gPiA+PiAtIHVwZGF0ZWQgY2xv
Y2stbmFtZXMsIGludGVycnVwdCBuYW1lcw0KPiA+ID4+IC0gZHJvcHBlZCBsZWdhY3ktaW50ZXJy
dXB0LWNvbnRyb2xsZXIgbm9kZQ0KPiA+ID4+IC0gYWRkZWQgaW50ZXJydXB0LWNvbnRyb2xsZXIg
cHJvcGVydHkNCj4gPiA+PiAtIG1vdmVkIHJlbmVzYXMsc3lzYyBhdCB0aGUgZW5kIG9mIHRoZSBu
b2RlIHRvIGNvbXBseSB3aXRoDQo+ID4gPj4gICBEVCBjb2Rpbmcgc3R5bGUNCj4gPiA+Pg0KPiA+
ID4+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL3JlbmVzYXMvcjlhMDhnMDQ1LmR0c2kgfCA2Ng0KPiA+
ID4+ICsrKysrKysrKysrKysrKysrKysrKysNCj4gPiA+PiAgMSBmaWxlIGNoYW5nZWQsIDY2IGlu
c2VydGlvbnMoKykNCj4gPiA+Pg0KPiA+ID4+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3Qv
ZHRzL3JlbmVzYXMvcjlhMDhnMDQ1LmR0c2kNCj4gPiA+PiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMv
cmVuZXNhcy9yOWEwOGcwNDUuZHRzaQ0KPiA+ID4+IGluZGV4IDE2ZTZhYzYxNDQxNy4uMDBiNDMz
Nzc4NzdlIDEwMDY0NA0KPiA+ID4+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvcmVuZXNhcy9y
OWEwOGcwNDUuZHRzaQ0KPiA+ID4+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvcmVuZXNhcy9y
OWEwOGcwNDUuZHRzaQ0KPiA+ID4+IEBAIC03MTcsNiArNzE3LDcyIEBAIGV0aDE6IGV0aGVybmV0
QDExYzQwMDAwIHsNCj4gPiA+PiAgCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCj4gPiA+PiAgCQl9
Ow0KPiA+ID4+DQo+ID4gPj4gKwkJcGNpZTogcGNpZUAxMWU0MDAwMCB7DQo+ID4gPj4gKwkJCWNv
bXBhdGlibGUgPSAicmVuZXNhcyxyOWEwOGcwNDUtcGNpZSI7DQo+ID4gPj4gKwkJCXJlZyA9IDww
IDB4MTFlNDAwMDAgMCAweDEwMDAwPjsNCj4gPiA+PiArCQkJcmFuZ2VzID0gPDB4MDIwMDAwMDAg
MCAweDMwMDAwMDAwIDAgMHgzMDAwMDAwMCAwIDB4MDgwMDAwMDA+Ow0KPiA+ID4+ICsJCQkvKiBN
YXAgYWxsIHBvc3NpYmxlIERSQU0gcmFuZ2VzICg0IEdCKS4gKi8NCj4gPiA+PiArCQkJZG1hLXJh
bmdlcyA9IDwweDQyMDAwMDAwIDAgMHg0MDAwMDAwMCAwIDB4NDAwMDAwMDAgMQ0KPiA+ID4+ICsw
eDAwMDAwMDAwPjsNCj4gPiA+DQo+ID4gPiBPbiBSWi9HM0UsIEhXIG1hbnVhbCBtZW50aW9ucyBQ
Q0llIGNhbiBhY2Nlc3MgdXAgdG8gYSAzNi1iaXQgYWRkcmVzcw0KPiA+ID4gc3BhY2UgKGFjY2Vz
cyB0byBERFIgYW5kDQo+ID4gUENJRTApLg0KPiA+ID4NCj4gPiA+IE5vdCBzdXJlIGFib3V0IFJa
L0czUz8NCj4gPg0KPiA+IEFzIG9mIG15IGtub3dsZWRnZS9pbnZlc3RpZ2F0aW9uLCBhY2NvcmRp
bmcgdG8gY2hhcHRlciA1LjQuMi4xIDM0LUJpdA0KPiA+IEFkZHJlc3MgU3BhY2UgQWNjZXNzIG9m
IEhXIG1hbnVhbCwgcmV2aXNpb24gMS4xMCwgb24gUlovRzNTIHRoZXJlIGFyZQ0KPiA+IHNvbWUg
YnVzIG1hc3RlcnMgdGhhdCBjYW4gYWNjZXNzIHVwIHRvIDM0LWJpdCBhZGRyZXNzIHNwYWNlLCB0
aGVzZQ0KPiA+IGJlaW5nIFNESEkvZU1NQywgR0V0aGVybmV0LCBVU0IyLjAsIERNQUMuIFRoZSBy
ZXN0IGNhbiBhY2Nlc3MgdXAgdG8gMzItYml0IGFkZHJlc3Mgc3BhY2UuDQo+IA0KPiBPSywgVGhh
bmtzIGZvciB0aGUgaW5mby4NCj4gDQo+IEkgYW0ganVzdCB3b25kZXJpbmcsIGxhdGVyIGhvdyB0
byBoYW5kbGUgdGhlIENyb3NzLU92ZXIgNEcgbWVtb3J5IGluIGRyaXZlciBhcyBoZXJlIHdlIGhh
dmUgc2l6ZSBvZg0KPiAweDFfMDAwMF8wMDAwIGFuZCBzdGFydCBhZGRyZXNzIGlzIDB4NDAwMF8w
MDAwIHdoaWNoIGNyb3NzZXMgdGhlIGZpcnN0IDRHIGJvdW5kYXJ5Lg0KDQpJIGdvdCBjb25mdXNl
ZCB3aXRoIGNvbXBhcmluZyBSWi9HM0UgaGFyZHdhcmUgbWFudWFsLiBMb29rcyBsaWtlIFBDSWUg
YnVzIG1hc3RlciBkb2VzIG5vdA0KaGF2ZSBhbnkgcmVzdHJpY3Rpb24uDQoNCkNoZWVycywNCkJp
anUNCg0K

