Return-Path: <linux-pci+bounces-37803-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E30BCCC94
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 13:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F2250355363
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 11:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAAC283FFC;
	Fri, 10 Oct 2025 11:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="k/n3tobB"
X-Original-To: linux-pci@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010014.outbound.protection.outlook.com [52.101.229.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9F24414;
	Fri, 10 Oct 2025 11:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760096209; cv=fail; b=qokExJd7xIuMIbFyLBwQ46rJw7AK7DNKfkjHplp5QheE+2TqQVLGZVJZP2JangUcdWedFvEbQI9LgvgOwgwsJm9r9uTk+xcA6l2kKPrU0PEQfT1J/KRim9PTS/6xNdqEo3FlMwhY9en02CasVv7n2lmLhbU6hFMSg3JAdFH8BLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760096209; c=relaxed/simple;
	bh=bMd5mVq3iLn7fvCvUcyl6Oy8zu79tmCogyt3+467qkg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MMUEMJNQpwzNH81hhclrE2YukMGsJhWDKVMmIQTitjPHg556bVbmfj81IUZqMGz091sVIsgwn6gn62nWrup86lvUNZWjQ1pa3H24qPLs9cV4vDrZb/qQeomoFKj/lKMT0Fp9xwcJu45wVWiXPAuGYMx4Yw5kRWm61py0Ktqz6j4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=k/n3tobB; arc=fail smtp.client-ip=52.101.229.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YODuP/UhTCT4fp9VSWByYZSycTKZ0gUqJrCDV7d5a35ENAr+TsSZDO+DB7vuGtoBUQkxEYIUwoCqQqhS4OnQX0ptby+2cw7spKbJaxWPAQmiyYKh51NTVZWGMpZSQp8jQtZls/sMl2zmz6VUlsgpmJabnwEoE47dGttzpfATUQ1z8CPdZkrEoct7PGk/D1c5S1mZC2V6bcX1mXUJTgc8NYzSvDz3XQIob0R5DlZzXxb4qKMX1kC918GB3ExF5ZdTqRwSGoARyL14o2l9xhLh/qhXKbD1WXSe3Vtyp3E9PKbGYlhP0whNW+CcwxzbQe3WH2Rp1LclY6fp2XJOyovM/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bMd5mVq3iLn7fvCvUcyl6Oy8zu79tmCogyt3+467qkg=;
 b=fhzFS9l/BoFFReCzwf0waXnKwpRyyEXl3fhiafZ6KJ81jzRIRkzHTnSw90de+LIaXZOTj8diNj9TIy4pSJbxKRoWk/5ffVla/6nkirdSkoKpXgX1Ne0yA5ZAeTQENoF3VJHC7Quyn/537YvJQuA/EQIAmmcGHJiNhixVdXg7rfv7xH5Qjca0GV+v+zjeAycz4ecxgjimMgUv6oFRophXjHg649zvmfylCvznk+KuAQOWgmCI49ZaAZJHv1oeTzBBVFMUJOVoN76q5xJd0NHnufsSr8vKlFdb2KRpLCRRgbu+An1cM/5vagJFW7I5IyOY9AkZt+K4bU9s7sdRMVy5nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bMd5mVq3iLn7fvCvUcyl6Oy8zu79tmCogyt3+467qkg=;
 b=k/n3tobBSNP2oU3QrkimcwurnTwGd1eXy19qAyvlot98QDE3TsNw//igwIsua9QfQtBHkZbbZ1L+G0Ql0rtWpt8hwoYtQOg1W48IYRU8GMOt9FmGm0PtMbzgsxIo4eKyZQOcR96f76p4IXyNCWhnPIJIIyyDTQfjy0rOKrDRK1M=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYYPR01MB15676.jpnprd01.prod.outlook.com (2603:1096:405:294::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.6; Fri, 10 Oct
 2025 11:36:41 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.9228.005; Fri, 10 Oct 2025
 11:36:41 +0000
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
Thread-Index: AQHcN4+Xl3bUT1Hya0C1BFZ2Fpr8n7S2sSOwgASOuYCAAAQDwA==
Date: Fri, 10 Oct 2025 11:36:41 +0000
Message-ID:
 <TY3PR01MB11346B3365740A98B6B52872D86EFA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20251007133657.390523-1-claudiu.beznea.uj@bp.renesas.com>
 <20251007133657.390523-4-claudiu.beznea.uj@bp.renesas.com>
 <TY3PR01MB113461AF51BD346E1D96E43B486E0A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <7848e331-3d32-42ee-a05f-66ab40ef00be@tuxon.dev>
In-Reply-To: <7848e331-3d32-42ee-a05f-66ab40ef00be@tuxon.dev>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYYPR01MB15676:EE_
x-ms-office365-filtering-correlation-id: d7adb7f5-13b8-47a9-6d79-08de07f14855
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?cWhKclUrbDNtRmNXcGpRQmUzS1VmSkQ5dFM1dXBaQ3NlSUM4NTVXRHpTZU5v?=
 =?utf-8?B?bDh3U2J2MGx1SmcrOUdlSG9zc1Rqb2doRjVIQ2d5USsvQVlOaUd0M25ueWt6?=
 =?utf-8?B?d093WWxGT00rUldBM2Z5OENqSVlpcDBHN2tqanlRYlAwVkdHUUlSKzkySkVy?=
 =?utf-8?B?U05aYU9POFRpbTI2ME5RQ29oUTVKVG1xajEzUVBJVlBTNG12ZnNqeEorMHRr?=
 =?utf-8?B?Q0tzaGFuZTNybzY0eDBvcHdlaFFmWUVZRGI4YlV6aDJJUXRuNmZoR0hic0c2?=
 =?utf-8?B?QXVpZUxjWnNoTElyU3FGaGhXTHNQSHNXVWpOUHdEZzQ2QWhLRWlNTDN0VFpa?=
 =?utf-8?B?R1g2cWpuV0toRkFMU3FJY002czZVVWwxSE96Z3NiS0tyNERMT3hNNDJzWEFJ?=
 =?utf-8?B?N0VBRXc1T2VxWE1YSTBwZzdaWnZaMjQwSjVpbXRreW9kb2xuSkZscWRSOEdr?=
 =?utf-8?B?dituZHVsUG14L010TnlwRENjWEp0VVI1ekxheWVWTUdmemU3YXUzOXhDWFMr?=
 =?utf-8?B?WXl4Q1MzdndXTHAzNWtRaGJjSjQwOTVlMVV6SnVkOWpsM1A1L0RZMUZWUjR1?=
 =?utf-8?B?ZlQ4d2s4NUZreTE5bWVvZkFnMzZIbjVLdm5ndVRPWUNGUEdUbG85aEhkVlRH?=
 =?utf-8?B?MzhkQUNYTTFWYTBaMVU5UGNsY0JRN0FXWEVtMEJkK25abFFGV0o0a0REQzU0?=
 =?utf-8?B?MC9YN2ovTU5ZUmJOWDB5NTdHSUI0YVdJK0tUODlMT04zQUgzcWVScXJ3Rkxn?=
 =?utf-8?B?d21EUUJJODVYc0hwNFQraHNPdHJUb1pLWDUzSkFBV1Q5dXF2aUUzRDcyWW9o?=
 =?utf-8?B?eUl0czlVYU9qSWgrK1l2bHQxUk9iczJsa1ljdUE1SUV1ZWVxZzRBZHJWbm5X?=
 =?utf-8?B?YUx1clhoaGxGZE9IQ2wwaWFuczFjMDV5dnVqaGxoWUw0clg1U1doVTJQODZw?=
 =?utf-8?B?aEVOTHNLeW1xOGFFbnNrRFg5RWNMUURJQ3o5YWIveUllcFJmaEV0VWJKeFJk?=
 =?utf-8?B?RkNrcFJaaFBLZU1xRmNvYXBtSXR4c1k5MnJZUFhweEhKVDdFTXNhQ3NhMHBO?=
 =?utf-8?B?aTdRNmtNVXUwOUZZZ3RQRkFnS2g0aFZQZExZZkJDcDE4TU9qKzdFQkp5Zlp5?=
 =?utf-8?B?L1JNdlhXUTJ0aG1CL2ZIc04vWGhnOXY1NWxHZ1FwUTRvVzkyaHRQTlg0b2p4?=
 =?utf-8?B?M3ZnVkpWN0I1SDgzWFNPUkdxRmNFK1BBVHZzU1R1U3laUmdIM1BsVExwOWZH?=
 =?utf-8?B?UWM5YS9MSDVyV3lkdUJETkVnbGVKU0VCcUJIVFZGU2dPS0NGSDl1NjRzUGxF?=
 =?utf-8?B?OHFzYjNqMEV1NU1UemJBQ05uNGVnbm1Uc29kbmpMaE1MM3lBdW1USjA5b2Rw?=
 =?utf-8?B?cTRkOW5kazZTc3VsSmpMcG9vZE1WQ0RWRnNRcDdZbDNRdm9tczdFRnlqQjlm?=
 =?utf-8?B?QU9tY3hUWlN5VDJyL0dSTHVwWDl1YWkvVU5tSVJWT3NFMjExTERoeFV4b3hJ?=
 =?utf-8?B?SEFhcWREQ0VvVFBQQzBJV3FER2h5bkJEQ2xZT01mQStRazl2T3Y2TGlITzZI?=
 =?utf-8?B?NUNPN3pVekl2azJBTmhUV2N4UVh5NDdOM0UxKzhyNFpSN0MwRHZiTXFUdTBH?=
 =?utf-8?B?dEhXT2hZa3BKaVBXbWora0paSGdodnFtYllCaXlZdVUzdVNSR2JXY0R0OW05?=
 =?utf-8?B?Q3NEamR3YVRpckFYaTkrdXRCTitvSUxUdDVVMTF6VG52STgyQis2emQzNC9w?=
 =?utf-8?B?OFMvSVRUbTh2WXVFVTdNQStWSjBMVG5UMUFkN2xFSmdmS2ZpZTZ3Q2wvaS85?=
 =?utf-8?B?d3QyaDhqVUgyN2N4SERHemNhOHZjekN3QWRZaEl2Qy9ETVRMNjBvOWRReGRl?=
 =?utf-8?B?NDRMcHVrYW14TWN2TlJEWDl0VHlUYy8veWhrOEJWY2FHNVJWRmVxVlAxcXMr?=
 =?utf-8?B?R05KUWd3UlZIeWVkSWMvUlE4VzdsbWxBQ1JaVnJ4bTBqYjJsNDl6WFJWdjkw?=
 =?utf-8?B?UDdHdWp3WEN3dTBTbW9GaEs2Ni83OHdmYnBoeFg5c3VsOE1jNGFHZVBHZEkz?=
 =?utf-8?B?RHhETjQwTWhTc2RnQW45cXkxQ3lVWkJwU3J2dz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UElSb005V045QjVNa1pwM0JaenNCdU5SWHppallOQjVwTHdGaU9UOUZiRTdv?=
 =?utf-8?B?c1pybnpsdGF0M0pZYVRIb3A5amsvNDlnTHljUWhERWdFQlA1SnlQT2tTWmdr?=
 =?utf-8?B?VUlGNS80cDNFTzVkM1RRczJNSVhnNVlmZ28zUkxaand2cjBRS0R4SitJZkFu?=
 =?utf-8?B?V09UM1VQczBBR1hlN0Uxb0o2R3dIQXM4QkR6cHhBODMxL2JIKzcwOUhiQzI0?=
 =?utf-8?B?MWc5MUpVZUlxTUUxaEZBU2tkaWFacTVRRi9sMzdJTmVnVlY5ZGlPc0E3ak0w?=
 =?utf-8?B?REdWYzM3QjdNT0p5aEFkR3lDY1ZlMWY3THl3MVJHV3pTN3UxYzZIbTlQanVD?=
 =?utf-8?B?bDUySVcvOXVxV2tIOVhsL0RrdmJjTVBjT2xERnpLUnk0YzlIMmpxZkR2UTEv?=
 =?utf-8?B?RVd4bzBySG90Sy8yV1F5d3J0ZGh0cHJKVXBYUFpoU1R0MmIzRDFXZnNJeGRr?=
 =?utf-8?B?aEFNYkp1eXpXU3BraWpKSm1HcjJ1aDFudi9zb1d3OHl4VU1jakdxVkNhT0pV?=
 =?utf-8?B?WS9tQ0dpdEUrclpzTGh1SkxJU1l2aXh1NXpiaXRBQ256aWozbE1td1N4dWRr?=
 =?utf-8?B?Z2pDdklLNy9tWU5PN2lnZUFKVm9LYVdMTFl0ck5pYlJUdndsamxlQVQzQzdZ?=
 =?utf-8?B?Y1RMUm1pMjFUVG40QmtDeHhUYTRoeEFCTW02Zy9SOVJkVk0xV3RoMXNYTmJO?=
 =?utf-8?B?ZnN5RTNqQTJGRTJLZGY5WXRMbHFJcjdmakt1U01YdWIzSHlneTE0dUdyb0s0?=
 =?utf-8?B?dThNTUxLbHJzY21nRGE2MDMxaHM4UWlIeE56VXdKaHk5ak54bVRWRG5velQv?=
 =?utf-8?B?bW1QK0ZzN1dtTEhiZnhCb1pleXhRQ1BaWE1HbVY1bTU5akRjZ2REeFUwSk5k?=
 =?utf-8?B?RXJoYnpSWkdqTTRiMVc1Vk1HalNaTTdqbWRSeFk2MTlKVTFsN2JGSFdFVlcy?=
 =?utf-8?B?MFMyakdidVJ6Q3BwUlh1Z3JXdFNDaTdmbEx3Q3lrOUw4bUdaR1VleVo2NVJ4?=
 =?utf-8?B?YWhBcTZFNzZQOGZ5N1doZE03VHVKZVJhTzVoMzJyRXhaaUkvUERpdHlxVDFs?=
 =?utf-8?B?YVFWWkp0Y0Z1ekEyVkR0a1Q1Uzl2RmszVHFRdi9SMUFnMERjMVl4bTBZVSs3?=
 =?utf-8?B?UXMxZS9PMDJtTHpPUjV3WUVtalRIazBuTUJHRlZVRjBsUWNoUmpMME5la0Vw?=
 =?utf-8?B?TGx0Wm5tcFUyS1hTYW0wcE85MkJnL1BRdnhHWUxnbzU4Tkw0R0hWZXZ0b0Js?=
 =?utf-8?B?WkdPeExzR1dSZ3VUR2J0NThoc05HbE92azd4aThNYUVYL1A4TWF1R2VWV1No?=
 =?utf-8?B?MTRxTS9DRzhMODdtNW5HOG9pVDQweUtDTndqYnM0TUEvMG9ZNjZjdGpRcGs5?=
 =?utf-8?B?dzhuemtFQVRabGcvT2xibEJqY2FaQjR0TnkzU1ZFZ1dQRk9qTTRkYWQrZTU5?=
 =?utf-8?B?S0s0MFZ6VDVqdHczTk92Z3liSVhsT3BQM2MwQlFRQ01Rd29BVHZNY2FiT29W?=
 =?utf-8?B?Z2Y1UFpYb0VmMDBrY05WUngwNHI1TERxc1l4eW5oKzVka2JhNWo0di9OZUJS?=
 =?utf-8?B?djJGaVg0MnhNV2g0aEVuMURmaEJCTWhCNzMrV2V3cFhqTEMvTjlUM1NVbkx3?=
 =?utf-8?B?VGFMRGJkeTAyeVVIdktZYlRIVWFwWC9CWk5sR1RqNlJMeUVoOFltMFdHclN6?=
 =?utf-8?B?MFpTb081UXZxNVRBWHo3dExlcjRYR2RoUUY5QUJPajhJclhpOUdPd3Z6SWg1?=
 =?utf-8?B?akZwRDBsa3RvRE81VmV1OGtkZmhidWhuQmJiSWVtUGd4MmdoTW5jcUF0K0dC?=
 =?utf-8?B?cHpKSWozMmJqL3ZjR0t4d0JDVzNvalNXMm0yZFpUMVB2Mno4RHRoUnM2MWpO?=
 =?utf-8?B?aVBNNTA5STVzaUphZkkvbDlaQXRseElLeTZvQXFMTC9wb002RyswaERSRldI?=
 =?utf-8?B?bG4zbFhTY3A2WUpoZVgzVVE3VmZjdWh1bEJkSTRzcmFaaEc4azVqT3lQc3o0?=
 =?utf-8?B?bjFWVkNSb3JxTXR3T280amtPVmZheForSDlIWVhEN3cyUGJ1SDdLSkNYWkdj?=
 =?utf-8?B?WHFnWmE0eklSUGV2WStzbUxmYmlnRngrYnpPMTkvU090TW5BcWg0UWZGWjho?=
 =?utf-8?Q?iw8b7DjLphbU4774cJEhN4Kle?=
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
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7adb7f5-13b8-47a9-6d79-08de07f14855
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2025 11:36:41.5121
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: njRt30JyZcwuQypPX6znNcAwoOPjIIZdX0npviK3TQwyG2xnNDfRVHqPVI/OLCUcDO8gjvfUzBi8FChCvWvP3G69xf0h4TfnRlKClQdoQT8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB15676

SGkgQ2xhdWRpdSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDbGF1
ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAdHV4b24uZGV2Pg0KPiBTZW50OiAxMCBPY3RvYmVy
IDIwMjUgMTI6MTgNCiw+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMy82XSBhcm02NDogZHRzOiBy
ZW5lc2FzOiByOWEwOGcwNDU6IEFkZCBQQ0llIG5vZGUNCj4gDQo+IEhpLCBCaWp1LA0KPiANCj4g
T24gMTAvNy8yNSAxNjo0NCwgQmlqdSBEYXMgd3JvdGU6DQo+ID4gSGkgQ2xhdWRpdSwNCj4gPg0K
PiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBDbGF1ZGl1IDxjbGF1
ZGl1LmJlem5lYUB0dXhvbi5kZXY+DQo+ID4+IFNlbnQ6IDA3IE9jdG9iZXIgMjAyNSAxNDozNw0K
PiA+PiBTdWJqZWN0OiBbUEFUQ0ggdjUgMy82XSBhcm02NDogZHRzOiByZW5lc2FzOiByOWEwOGcw
NDU6IEFkZCBQQ0llIG5vZGUNCj4gPj4NCj4gPj4gRnJvbTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVk
aXUuYmV6bmVhLnVqQGJwLnJlbmVzYXMuY29tPg0KPiA+Pg0KPiA+PiBUaGUgUlovRzNTIFNvQyBo
YXMgYSB2YXJpYW50IChSOUEwOEcwNDVTMzMpIHdoaWNoIHN1cHBvcnRzIFBDSWUuIEFkZCB0aGUg
UENJZSBub2RlLg0KPiA+Pg0KPiA+PiBUZXN0ZWQtYnk6IFdvbGZyYW0gU2FuZyA8d3NhK3JlbmVz
YXNAc2FuZy1lbmdpbmVlcmluZy5jb20+DQo+ID4+IFJldmlld2VkLWJ5OiBHZWVydCBVeXR0ZXJo
b2V2ZW4gPGdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlPg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBDbGF1
ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWEudWpAYnAucmVuZXNhcy5jb20+DQo+ID4+IC0tLQ0K
PiA+Pg0KPiA+PiBDaGFuZ2VzIGluIHY1Og0KPiA+PiAtIHVwZGF0ZWQgdGhlIGxhc3QgcGFydCBv
ZiByYW5nZXMgYW5kIGRtYS1yYW5nZXMNCj4gPj4gLSBjb2xsZWN0ZWQgdGFncw0KPiA+Pg0KPiA+
PiBDaGFuZ2VzIGluIHY0Og0KPiA+PiAtIG1vdmVkIHRoZSBub2RlIHRvIHI5YTA4ZzA0NS5kdHNp
DQo+ID4+IC0gZHJvcHBlZCB0aGUgInMzMyIgZnJvbSB0aGUgY29tcGF0aWJsZSBzdHJpbmcNCj4g
Pj4gLSBhZGRlZCBwb3J0IG5vZGUNCj4gPj4gLSByZS1vcmRlcmVkIHByb3BlcnRpZXMgdG8gaGF2
ZSB0aGVtIGdyb3VwZWQgdG9nZXRoZXINCj4gPj4NCj4gPj4gQ2hhbmdlcyBpbiB2MzoNCj4gPj4g
LSBjb2xsZWN0ZWQgdGFncw0KPiA+PiAtIGNoYW5nZWQgdGhlIHJhbmdlcyBmbGFncw0KPiA+Pg0K
PiA+PiBDaGFuZ2VzIGluIHYyOg0KPiA+PiAtIHVwZGF0ZWQgdGhlIGRtYS1yYW5nZXMgdG8gcmVm
bGVjdCB0aGUgU29DIGNhcGFiaWxpdHk7IGFkZGVkIGENCj4gPj4gICBjb21tZW50IGFib3V0IGl0
Lg0KPiA+PiAtIHVwZGF0ZWQgY2xvY2stbmFtZXMsIGludGVycnVwdCBuYW1lcw0KPiA+PiAtIGRy
b3BwZWQgbGVnYWN5LWludGVycnVwdC1jb250cm9sbGVyIG5vZGUNCj4gPj4gLSBhZGRlZCBpbnRl
cnJ1cHQtY29udHJvbGxlciBwcm9wZXJ0eQ0KPiA+PiAtIG1vdmVkIHJlbmVzYXMsc3lzYyBhdCB0
aGUgZW5kIG9mIHRoZSBub2RlIHRvIGNvbXBseSB3aXRoDQo+ID4+ICAgRFQgY29kaW5nIHN0eWxl
DQo+ID4+DQo+ID4+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL3JlbmVzYXMvcjlhMDhnMDQ1LmR0c2kg
fCA2Ng0KPiA+PiArKysrKysrKysrKysrKysrKysrKysrDQo+ID4+ICAxIGZpbGUgY2hhbmdlZCwg
NjYgaW5zZXJ0aW9ucygrKQ0KPiA+Pg0KPiA+PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290
L2R0cy9yZW5lc2FzL3I5YTA4ZzA0NS5kdHNpDQo+ID4+IGIvYXJjaC9hcm02NC9ib290L2R0cy9y
ZW5lc2FzL3I5YTA4ZzA0NS5kdHNpDQo+ID4+IGluZGV4IDE2ZTZhYzYxNDQxNy4uMDBiNDMzNzc4
NzdlIDEwMDY0NA0KPiA+PiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL3JlbmVzYXMvcjlhMDhn
MDQ1LmR0c2kNCj4gPj4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9yZW5lc2FzL3I5YTA4ZzA0
NS5kdHNpDQo+ID4+IEBAIC03MTcsNiArNzE3LDcyIEBAIGV0aDE6IGV0aGVybmV0QDExYzQwMDAw
IHsNCj4gPj4gIAkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ID4+ICAJCX07DQo+ID4+DQo+ID4+
ICsJCXBjaWU6IHBjaWVAMTFlNDAwMDAgew0KPiA+PiArCQkJY29tcGF0aWJsZSA9ICJyZW5lc2Fz
LHI5YTA4ZzA0NS1wY2llIjsNCj4gPj4gKwkJCXJlZyA9IDwwIDB4MTFlNDAwMDAgMCAweDEwMDAw
PjsNCj4gPj4gKwkJCXJhbmdlcyA9IDwweDAyMDAwMDAwIDAgMHgzMDAwMDAwMCAwIDB4MzAwMDAw
MDAgMCAweDA4MDAwMDAwPjsNCj4gPj4gKwkJCS8qIE1hcCBhbGwgcG9zc2libGUgRFJBTSByYW5n
ZXMgKDQgR0IpLiAqLw0KPiA+PiArCQkJZG1hLXJhbmdlcyA9IDwweDQyMDAwMDAwIDAgMHg0MDAw
MDAwMCAwIDB4NDAwMDAwMDAgMSAweDAwMDAwMDAwPjsNCj4gPg0KPiA+IE9uIFJaL0czRSwgSFcg
bWFudWFsIG1lbnRpb25zIFBDSWUgY2FuIGFjY2VzcyB1cCB0byBhIDM2LWJpdCBhZGRyZXNzIHNw
YWNlIChhY2Nlc3MgdG8gRERSIGFuZA0KPiBQQ0lFMCkuDQo+ID4NCj4gPiBOb3Qgc3VyZSBhYm91
dCBSWi9HM1M/DQo+IA0KPiBBcyBvZiBteSBrbm93bGVkZ2UvaW52ZXN0aWdhdGlvbiwgYWNjb3Jk
aW5nIHRvIGNoYXB0ZXIgNS40LjIuMSAzNC1CaXQgQWRkcmVzcyBTcGFjZSBBY2Nlc3Mgb2YgSFcN
Cj4gbWFudWFsLCByZXZpc2lvbiAxLjEwLCBvbiBSWi9HM1MgdGhlcmUgYXJlIHNvbWUgYnVzIG1h
c3RlcnMgdGhhdCBjYW4gYWNjZXNzIHVwIHRvIDM0LWJpdCBhZGRyZXNzDQo+IHNwYWNlLCB0aGVz
ZSBiZWluZyBTREhJL2VNTUMsIEdFdGhlcm5ldCwgVVNCMi4wLCBETUFDLiBUaGUgcmVzdCBjYW4g
YWNjZXNzIHVwIHRvIDMyLWJpdCBhZGRyZXNzDQo+IHNwYWNlLg0KDQpPSywgVGhhbmtzIGZvciB0
aGUgaW5mby4gDQoNCkkgYW0ganVzdCB3b25kZXJpbmcsIGxhdGVyIGhvdyB0byBoYW5kbGUgdGhl
IENyb3NzLU92ZXIgNEcgbWVtb3J5IGluDQpkcml2ZXIgYXMgaGVyZSB3ZSBoYXZlIHNpemUgb2Yg
MHgxXzAwMDBfMDAwMCBhbmQgc3RhcnQgYWRkcmVzcyBpcyAweDQwMDBfMDAwMCB3aGljaA0KY3Jv
c3NlcyB0aGUgZmlyc3QgNEcgYm91bmRhcnkuIA0KDQpDaGVlcnMsDQpCaWp1DQo=

