Return-Path: <linux-pci+bounces-44922-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 027F7D23BB3
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 10:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A0472309631E
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 09:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F6B35EDC9;
	Thu, 15 Jan 2026 09:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="BJ+0NYcA"
X-Original-To: linux-pci@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011021.outbound.protection.outlook.com [52.101.125.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D56735B15D;
	Thu, 15 Jan 2026 09:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768470356; cv=fail; b=QZ/x3hRseU3tgXg4tJK3k+vI8e0UuVX3oCm6B8iLaNLDWOF4INHXYfjl+4oRM3uzgV1Ee4xMwReGKKWGv7QTqTED/OoTbGcVlXqg4YCk/Jv2WXn624IQ0IhfKtJtXbVFluy5MRa5RJysvaYeyHENusyiaYKv3HYhHKJbaSn0Xi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768470356; c=relaxed/simple;
	bh=tqPJIga7MGoqXbeFzlTNsrVnjOKMkWWqiN0KgkStxUw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h4GUshIoy1ge9dxXhFY3Pv+jqWV8QVTgpKCdth94uIDFiiPiTLY9Q2dLa1Db6FpzOKR0n4EdoeCOWyyGBH1Bff0EeBL2aYQlyGd7zVTmdqSKybyBLy3JSpXKwXOB2N8N9Rv6SIu2qdH0v1jrJNXw24bII009TeHhPRgEU4gm/z4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=BJ+0NYcA; arc=fail smtp.client-ip=52.101.125.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M07RLLF2oOWxoxD3KaLcBFegY9ZJLlDXIT8LHU/Vv40V+Ral2lEd9iAyNXL5I3rcC3Sx+Pt9/0YVs2ad5/piY/cWFASSGXRjImp2GIP3Ss9T7yPwWo4fvzZPq/C0q3fzYAzCLtjVvp1E6SPO3gOoN8Cj/mI1CaD0H1SuLwAIvdriFIrzuNtcGk8NJbtDow+or/tRT4GS4zHOo5WEKvl1tqS0yYXXQTxAxxuWBjLHPRpHNDT4+TqKpyTpDJoB2xXhKYjsRs+EJ9fPISERdYJ1bWey9t/F0fKjcaIUh8yK9iBg8B5/Ta2AihjM3H1dqk3lhezXJgmSEW2crJimbVLtdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yFHpT77rNGUiNaUYa43XBFqm17QbG+leybPh9kaaDgs=;
 b=mSRecuU4RmsGL393hRzdYaWOiAP/az1d1sxz7xMNjaM2gOB3c331TKQSaqJtpx5GzpIpnyvAe4IwUquOD/PUIiCEXGA2tXSM+6ponqIXhIVghrFFft1ONk6CsAnMKuceoorqW0Qbhm+od6UT4C/+C19TryYPdxoBNn+DqfV9GmtVEy00XJbWjMeh1zBmo39Q3rpvlGPyy1Pg/LFozwOxoOC4oMCyW/JHXME+4oxL3XPvV9PI3IszNMkaUpBQ1lNDUO0Wef64pUvEw+K2ZOcVoOI1NtTiQGAcz2ysVX617462qMAqWmFTA29U7/MJ+MXYEK52uJf3O2hTtHM4qqCFhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFHpT77rNGUiNaUYa43XBFqm17QbG+leybPh9kaaDgs=;
 b=BJ+0NYcAvj0iLw6lAtPx7yiDXCDUOIyyQAibegGpxLBrvAOdbp7zZ94LE4NUYUOf6ycZVAnzezUfEhCAxhhEugG55P+VmMUnh9Ak16lRb6ju0+krSZRGxai33KSc6yq6HynHlK3E/eWCwH2eCQHDGXK2m2a2yoGzT9H2TNsj0H0=
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by TYRPR01MB12724.jpnprd01.prod.outlook.com (2603:1096:405:1b8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Thu, 15 Jan
 2026 09:45:52 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::aa7e:1460:f303:3fd8]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::aa7e:1460:f303:3fd8%6]) with mapi id 15.20.9520.005; Thu, 15 Jan 2026
 09:45:52 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>, "geert+renesas@glider.be"
	<geert+renesas@glider.be>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	magnus.damm <magnus.damm@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "john.madieu@gmail.com" <john.madieu@gmail.com>
Subject: RE: [PATCH 00/16] PCI: renesas: Add RZ/G3E PCIe controller support
Thread-Topic: [PATCH 00/16] PCI: renesas: Add RZ/G3E PCIe controller support
Thread-Index: AQHchWtwLyagQP2qvEmbZhltpoTGLLVR8OUAgAELWQA=
Date: Thu, 15 Jan 2026 09:45:52 +0000
Message-ID:
 <TY6PR01MB17377629143F9424D062BF25EFF8CA@TY6PR01MB17377.jpnprd01.prod.outlook.com>
References: <20260114153337.46765-1-john.madieu.xa@bp.renesas.com>
 <TY3PR01MB113468B042E34541768F3E898868FA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To:
 <TY3PR01MB113468B042E34541768F3E898868FA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY6PR01MB17377:EE_|TYRPR01MB12724:EE_
x-ms-office365-filtering-correlation-id: 923ad89c-b756-499e-0a81-08de541adf3c
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021|7053199007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?8IMM9sbmU+sgxYm09BdS9R1svxHXrBZOMuYcBiaopsHIL4pHdS/Fn3QdIPiV?=
 =?us-ascii?Q?0OKuZjeFWf1GsZQRW5iAUKjl6T0KCSdseblpkZoRejXYObwVULSGC8EH2KKI?=
 =?us-ascii?Q?YsLLY/KUEd27gROc9gnCR0JN5WWEDZZ9Ql623vhcUzqo5op6+HVq2zvBcYT0?=
 =?us-ascii?Q?3DJ09z5EZN41utkYTebIdIMdo7Q0G0tr3R46fDNuWFSyBqQaJ7c3QF2WsdN4?=
 =?us-ascii?Q?wa22mVibnhaVHq5VbekrqlH1OyqlWDF3NU9PNUcMtcWNYG5oxDh5DVrQyYV1?=
 =?us-ascii?Q?WeBkSM55ThFgdPNt0PqRPczOccyetPK9HO0oe60fSgVrxo1Q2MJdhsWiUwLT?=
 =?us-ascii?Q?nfk/c/Xmz2ly5+4RxU8ytSyOsofBOtwOXaXeaKDgp6UhiCN8DWJa/HEWsbOT?=
 =?us-ascii?Q?9OxCTFwwR8dzUDxEkUDYon3wEGctVpctxoJTqogTObq3J7T9Ycwj/IvWSK0N?=
 =?us-ascii?Q?Iq2RP0oo2uIE2gEM10J4MM+1xYwEpW9eTlfK1o72pJiPwRT6ZcXGeL4DC3bz?=
 =?us-ascii?Q?ubWf3T5JQnN+MjQUx0spcfviLJ6LBDoWMeNoIAclZKGdkzktHdCorkTc+3mp?=
 =?us-ascii?Q?7pr6kTqQJaMRiFT9/9avCrAgXzY9Ltwh56nhDtazMsGK+Y10FXo4uPiS608/?=
 =?us-ascii?Q?IC84vqiGX91gxxIrOVkdh/gFW4IP9mLHRtYSAdQojtsHCYF45rMiANlOUz7O?=
 =?us-ascii?Q?pKn7hJrvJZq3JBPr/C0GVcpzjxSnwbXT2cYMQj9eOioCbocc+ULGVdr1gLbB?=
 =?us-ascii?Q?foLbi5T7r2dEU/un5Q6W0j3REoBs5KnqUf3ZNd4PRYSyrRhqhN+7M+o91BXF?=
 =?us-ascii?Q?lAHe25SbDfnaZ7HYPofxTHhuCv1FslSzKnhwXF/Hp3HHNsdycAjM4LKEHwzG?=
 =?us-ascii?Q?j9dpxX5+jG3Lah/ubLr8iDyxO0p4gLJrz9Xy1fuNoXnjAfPuWydfyFS5+VKn?=
 =?us-ascii?Q?Vl1j+5ahNT9wJxG71cw7pLaHhB6mBJwgO3OVPI6oFpA2EARv7sKodHc/xlLd?=
 =?us-ascii?Q?TPBRKwEXr9EeP5I/XyihJau0NQ+P9sDdHngDNKfpn+Jd+FWKi74fUwrOLuri?=
 =?us-ascii?Q?WYCzGmZDwInhl2j9MAfupS0tc/yBgCvGe8ysvQISw0PH17bD5wIy/6fstpQA?=
 =?us-ascii?Q?FmHfnujUk7VVuO8b9NHuA1ix4fTP5kyOiUkw7HlHOyefQkl35a04PgPd5sjq?=
 =?us-ascii?Q?UVok9AJBpBv+VUYL6PYDCWxhaRPzDKJZ1GuWhgqavQDGhR6lyFzRF3YcgKJ1?=
 =?us-ascii?Q?X/2Vat9LxJQVR+0TKYjEAW8ktA9uyzwM7sqELhnBRG7j26fwRcJfstHzeevU?=
 =?us-ascii?Q?PDuXOhut2C14HaMipVTI+rBMQUTMNjcMfgkt64JPEoZ0KhyGry0PsPRxtpel?=
 =?us-ascii?Q?i7zHRJ3/gT+F97V0kk0cjdYYagYYDPpEWtKQHWpi88YAyTm4E7FIG/Sw5V5l?=
 =?us-ascii?Q?xbVAvwZTQQY2bf7V1E74JmFhQ7d4xAooNsKlAVpTZrk26N43UExpAlAhoEk9?=
 =?us-ascii?Q?EC0TZ+coZj//hEcRXWr2PHF5EdFBMhmx79qRiPjs5KQ0124djPEcpZD4pH8m?=
 =?us-ascii?Q?aMOGlHwL6BotS1GI1we/D0hcOliT3gAQkZCy2BZdMD7d+sRXk8x9q9+ExSJY?=
 =?us-ascii?Q?Q6VJXCXzvIuExayjq8+EuLg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17377.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cFtBwXUZeWJg82nW83L2Yi5KECunCwXAvrKBLOmsoNYdupynrdfvVNe6mvSa?=
 =?us-ascii?Q?kZaSi1oqsqrKAMfUXnD6qkMvgmu62OZEYS6hB2C8HxWFNEyr4wxWjwZ3TrA9?=
 =?us-ascii?Q?gEQXqpu6WdOxPj6rsS6IqYFklu3+Qs7YI9pP7rH/suf0Uf6QqOob6Co2Ot9G?=
 =?us-ascii?Q?BA/n9tdMKn34Kg5+Jnt37XpoA30QyTA4o0llJHGNKGIvNHP3RqkfEnV2WHBf?=
 =?us-ascii?Q?mYpuXLUtcg/e6cEldXYr1mPA6zPaWBruux1ilgv4osQt2gZpGgrFtv+Pb7Bw?=
 =?us-ascii?Q?v14PiGC05FTm1vnE8n2w8IdxobWbJ7ujNyC9w4v80aHnOShCvh3qqiUn3L98?=
 =?us-ascii?Q?iOUBh/NrtmlnpzRCoR85rIQYPXCUUXTSjTO1gTNUVJQxDS0/OQTzRg92xn2f?=
 =?us-ascii?Q?I5AWRD9DHA4FVHpGuI/77Vu64pCOpBNhf/3/SCFk1hQa5NiilEBkejcsyPNh?=
 =?us-ascii?Q?hmdIQQnt3XT5+iZAN8SoKbs+m8rnRjVsFGw2xAgRiz3jldgt3fqKaRpxjkOz?=
 =?us-ascii?Q?p3DiV0eKWiH058ySSpAtcbNqLVx9DjZrnBXyz++0vxGBhxpEDLd3hb0X4sxO?=
 =?us-ascii?Q?4k07RzNLMx+fEDpVfBJ9MzxMb6t6YHBmgyVlxWCeIIPsLf0VeTmV7PqK4+qv?=
 =?us-ascii?Q?VaYvsxf/XvY8JBuSD0oT8xb8WcOq1DdM3oF3OypF9VjBX0i8NMYOkaE8qTKi?=
 =?us-ascii?Q?oUn2ve3CBmqoOoiqBLns6mHL7rMUqGnAhGveY7JNr0o86+Gn1aGfJJRGmFvg?=
 =?us-ascii?Q?9PtdU6A9IRYMpF7pZVRDlEueENTVanMpQvRbp/tJZr8h5ZmqHBLKW5ZFC6h6?=
 =?us-ascii?Q?eePmBxfoTi5oMBK998on0oJeqYSDJB5Bc3kGg0H1D+tdptuBFceiM1Wjt/cw?=
 =?us-ascii?Q?HKQ3FWCGkLGbf/plC2B9hxSNO/krxgya2uQ5g3sAiVvI2sPABrpCUFLz2I3K?=
 =?us-ascii?Q?HLan9xSu5QrvAEQzDa+0AanTrx4FvGwV7v3zi+fx/74fit2Fhk+RM9Y7gW9P?=
 =?us-ascii?Q?KtMOqy5UKCYxRwWQaejaLFzvkZbT+egQNUlkFbEYHtq+BXEUy+mlZB41FG65?=
 =?us-ascii?Q?hTmzqpUjVVxF5yBk5bRw4SNPZpdo93SzCHHTJheiBcfRVxCqxPnYelPvQSEl?=
 =?us-ascii?Q?QcHSjQaRi2hKu1N+ocnFpXBEnUyram3leNlSwCHQpHU2bWq0mhNIaLbFfu+l?=
 =?us-ascii?Q?a5oXzQO3EhpvxR9XUBF7JlcnGU0/5Kf6jXy6KEmrSXKURQXNPFCZ+2q8cOoX?=
 =?us-ascii?Q?gyNMLsuIdRGcxSoWNcsXPuCdewEfgRhC5s73RT4+W/TQBKcIZDgRhQ2FHwGN?=
 =?us-ascii?Q?ZwEBWrLm5RHEHzZArz4/kpwrSctdbp7EJuKx3ddRpzdTMdn1wUjugadpSE7J?=
 =?us-ascii?Q?HAtj0sRxzWg2uR1jX3znq3G3i3OELjsYgUt0GuDph57n+s521VeWl09yjRFB?=
 =?us-ascii?Q?wXeAqiMkXGDCmQ9GyQNTGDLscxwD2kREg1Kd5MDz88ZD1Gcc8QK6a0hoWkvt?=
 =?us-ascii?Q?XDL1M0xheL/d8JR5sN+jnFah+H1pLygd5yNuLKAWIf4CoRrGUcwreOTZTkK9?=
 =?us-ascii?Q?HVnBUPd0h21E5SimQDpYmcKTZry+ggXZxDLns4Vqrlv36cs0E1dasD7UERBY?=
 =?us-ascii?Q?h5YlCphmdLEeH389YZ/w+FjJWFVFDAKNYgT1GOe5FjLbBNmuWywCEjL9t+5V?=
 =?us-ascii?Q?bDVE39Ku5+3JDTh76iYT52mQhGyhtm8Tr5zmh5D0dA+0sJV6BnkXu+vHHJhI?=
 =?us-ascii?Q?/+ri212wpPMT/YQQlepaP4M6iLwlBb0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY6PR01MB17377.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 923ad89c-b756-499e-0a81-08de541adf3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2026 09:45:52.3771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zQlGMiu+FcV2G0UrR2pormMo7D7xQ9ioIuONePFMGh3JROSG635lJN6vF5TuyhEDSr0eL2MVG7N3HcpIjXdh+bkH4r6Tuc3AlKSHQhFfTlA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12724

Hi Biju,

Thanks for the feedback.

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Wednesday, January 14, 2026 6:48 PM
> To: John Madieu <john.madieu.xa@bp.renesas.com>; Claudiu Beznea
> <claudiu.beznea.uj@bp.renesas.com>; lpieralisi@kernel.org;
> kwilczynski@kernel.org; mani@kernel.org; geert+renesas@glider.be;
> krzk+dt@kernel.org
> Subject: RE: [PATCH 00/16] PCI: renesas: Add RZ/G3E PCIe controller
> support
>=20
> Hi John,
>=20
> Thnaks for the patch.
>=20
> > -----Original Message-----
> > From: John Madieu <john.madieu.xa@bp.renesas.com>
> > Sent: 14 January 2026 15:33
> > Subject: [PATCH 00/16] PCI: renesas: Add RZ/G3E PCIe controller
> > support
> >
> > The Renesas RZ/G3E SoC features a PCIe controller that shares
> > similarities with the existing RZ/G3S PCIe controller, but with several
> key differences.
> > This series adds support for the RZ/G3E PCIe controller by extending
> > the existing RZ/G3S driver and device tree bindings.
> >
> > Key differences between RZ/G3E and RZ/G3S PCIe controllers:
> >
> > Link Speed Support:
> >  - RZ/G3E: Supports PCIe Gen3 (8.0 GT/s) alongside Gen2 (5.0 GT/s)
> >  - RZ/G3S: Supports PCIe Gen2 (5.0 GT/s) only
> >
> > Reset Control:
> >  - RZ/G3E: Uses register-based reset control mechanism
> >  - RZ/G3S: Uses exclusively external reset control signals
> >
> > Inbound Window Configuration:
> >  - RZ/G3E: Requires precise power-of-2 window coverage with strict
> address
> >    alignment constraints. Non-power-of-2 memory regions must be split
> into
> >    multiple windows to avoid over-mapping, ensuring proper hardware
> address
> >    decoding for DMA operations.
> >  - RZ/G3S: Uses a simpler approach that rounds up to the next power-of-
> 2,
> >    creating single larger windows. The hardware tolerates over-mapped
> regions.
> >
> > Class/Revision IDs:
> >  - RZ/G3E: Requires explicit setting of class/revision values
> >  - RZ/G3S: Has default values in hardware
> >
> > Clock Naming:
> >  - RZ/G3E: Uses "clkpmu" PM control clock while CLKREQ_B is
> > deasserting
> >  - RZ/G3S: Uses "clkl1pm" clock for power management
>=20
> Typo: RZ/G3S and RZ/G3E swapped. FYI, the upcoming SoC has both clocks.
>=20

Indeed. I'll swap that back in v2's CL.

Regards,
John=20

> Cheers,
> Biju
>=20
> >
> > Phy Settings:
> >  - RZ/G3E: Does not need PHY settings as it works with default hw
> > values
> >  - RZ/G3S: Requires explicit PHY settings
> >
> > This series extends the existing driver to detect the SoC type from
> > the device tree compatible string and configure the controller
> > appropriately. The updates are minimal and focused on the hardware-
> specific differences while keeping the common code paths unified.
> >
> > Note: The clks "PCIE_0_REFCLK_IN" and "PCIE_0_CORECLKIN" are added by
> > mistake in hardware manual
> >
> > John Madieu (16):
> >   PCI: rzg3s-host: Fix reset handling in probe error path
> >   PCI: rzg3s-host: Fix inbound window size tracking
> >   clk: renesas: rzv2h-cpg: Add support for init_off clocks
> >   clk: renesas: r9a09g047: Add PCIe clocks and reset
> >   dt-bindings: PCI: renesas,r9a08g045s33-pcie: Document RZ/G3E SoC
> >   PCI: rzg3s-host: Make SYSC register offsets SoC-specific
> >   PCI: rzg3s-host: Make configuration reset lines optional
> >   PCI: rzg3s-host: Make inbound window setup SoC-specific
> >   PCI: rzg3s-host: Add SoC-specific configuration and initialization
> >     callbacks
> >   PCI: rzg3s-host: Explicitly set class code for RZ/G3E compatibility
> >   PCI: rzg3s-host: Add PCIe Gen3 (8.0 GT/s) link speed support
> >   PCI: rzg3s-host: Add support for RZ/G3E PCIe controller
> >   arm64: dts: renesas: r9a09g047: Add PCIe node
> >   arm64: dts: renesas: r9a09g047e57-smarc-som: Add PCIe reference clock
> >   arm64: dts: renesas: r9a09g047e57-smarc: Add PCIe pincontrol
> >   arm64: dts: renesas: r9a09g047e57-smarc: Enable PCIe
> >
> >  .../bindings/pci/renesas,r9a08g045-pcie.yaml  | 243 +++++++----
> >  arch/arm64/boot/dts/renesas/r9a09g047.dtsi    |  68 +++
> >  .../boot/dts/renesas/r9a09g047e57-smarc.dts   |  11 +
> >  .../boot/dts/renesas/renesas-smarc2.dtsi      |   7 +
> >  .../boot/dts/renesas/rzg3e-smarc-som.dtsi     |  11 +
> >  drivers/clk/renesas/r9a09g047-cpg.c           |   5 +
> >  drivers/clk/renesas/rzv2h-cpg.c               |   9 +
> >  drivers/clk/renesas/rzv2h-cpg.h               |  18 +-
> >  drivers/pci/controller/pcie-rzg3s-host.c      | 393 +++++++++++++++---
> >  9 files changed, 632 insertions(+), 133 deletions(-)
> >
> > --
> > 2.25.1


