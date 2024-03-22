Return-Path: <linux-pci+bounces-4981-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6358867C4
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 09:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A3E528653F
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 08:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA967134B7;
	Fri, 22 Mar 2024 08:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CKHLpcrs"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2081.outbound.protection.outlook.com [40.107.13.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FADA168D2;
	Fri, 22 Mar 2024 08:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711094502; cv=fail; b=knNJoF35rmy+BeK/4r2uhQhopcAL8Bsr0lVvYUKaKyRYACmzkPcsxPECZMRR7Kv3wKmdaWAy2hatZA8MDzyfhcUTiWzUX+/OIVoeClBmQdS/GQyZHUwlnok6XjStNe0+DvzH7yyaE3qdzlP4e2GShyFnNeTr5mjA5hOVCH/oHCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711094502; c=relaxed/simple;
	bh=WkMFy42pRAqncRl88pxKgnGW1no+kii3YxVZU3TisXw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=okpmdgH5RmQLfE3QfLqWsYONkXuJ+LE6fGmu0hblL4cd1R/p1ZbBY3BgjRSfleLRmC7I+VxZESd4qnkXmLVlSqYzo8pOYlsOqwuGGF8HcwsIprcfrskYr5YVJHocGKHao+zD0sAlQ5K9+/tdKoHAdTKHccKXjaI+gltLJIFm73s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=CKHLpcrs; arc=fail smtp.client-ip=40.107.13.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XmehetdNfXSa1yUa2FtLAG+KOHQVkHdrRpFH+TUaKFo154jKgh67u4Y99fXy4Npz08AsZFcAe2rt/caEZawN00TgHIRYOFe5xcgFypzQ61s2g3FEmleDriQEemml3lXaNMrwLnyGTx+W0v9RLOzdr6qsABE+i+MFJASGrCLcYbFaZXrsSCYo9/TCD2Y560xa3BgWZqGYR/zlHqxExpcTtbEjqGQsE0afyzPjFV2nUl4yzRHxklR0QMbGPwh4zjAsponkOFYno7BGEih7QIW/C8RirOkqKU8b/PGwx4Nx7n60PRlNYIkoumNHKbiJXsITpX0oI+1r/Zw7+GuGlnWF3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WkMFy42pRAqncRl88pxKgnGW1no+kii3YxVZU3TisXw=;
 b=kDPVhgf3winwqSKkfcz0rkjDpSep4LnbkWXMn+yxuxfXnbngzUQAlGE8ZfhYaXFAvbaNAaFCv178vZMZO6djcVNdBVzaOAXDx9y+8YGYC2Q5yxxS6Vf9nHqQB+ZwPSrf+N3gTyOxnzsBoeZCr5M43KwPnQF3MRyXL0fYnTdYQY1aIdN8Iqfkj3ca8JRfYI3OnptXQtHU0Bfkt56gB+f2ZDAyLQbTzB4axpV3YvsUtvmZdsVe2ImSsQAcA6GKL2jbfmim/pXO+6Mc9QPUDLcNhWgBdWHvebvMuCUutRz7vRa1Sw7g+R06tACimd7yq/STdzGSK9/X+I60oDjK1erW9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WkMFy42pRAqncRl88pxKgnGW1no+kii3YxVZU3TisXw=;
 b=CKHLpcrsQyBsYD5YznIrMKqja5UX4Eb+SWpkWawrSu2Q0JO5mJba0naMUanEgoXc4E2iuG8UiZxKRB35msF3ChKW45Nlye7TVZvmBuZge27qvEeB1ToQIIBWBjQcPzlB1gqCSPYHpH8z9LxbKt+3uOWgX30NuBCmZOUUI78KKAQ=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by DBBPR04MB7932.eurprd04.prod.outlook.com (2603:10a6:10:1ef::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.15; Fri, 22 Mar
 2024 08:01:36 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::5dad:f991:ed59:3123]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::5dad:f991:ed59:3123%5]) with mapi id 15.20.7409.023; Fri, 22 Mar 2024
 08:01:34 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: "l.stach@pengutronix.de" <l.stach@pengutronix.de>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "lorenzo.pieralisi@arm.com"
	<lorenzo.pieralisi@arm.com>, "marex@denx.de" <marex@denx.de>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] PCI: imx6: Fix i.MX8MP PCIe EP can not trigger MSI
Thread-Topic: [PATCH] PCI: imx6: Fix i.MX8MP PCIe EP can not trigger MSI
Thread-Index: AQHaenuSSA2lotDD3UGUlUBvdqGg57FCi9UAgADcggA=
Date: Fri, 22 Mar 2024 08:01:34 +0000
Message-ID:
 <AS8PR04MB86768BF09E2FEC34E78A61998C312@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1710906338-4596-1-git-send-email-hongxing.zhu@nxp.com>
 <ZfyBDBGizGwiQvgs@lizhi-Precision-Tower-5810>
In-Reply-To: <ZfyBDBGizGwiQvgs@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|DBBPR04MB7932:EE_
x-ms-office365-filtering-correlation-id: 0d0c9ad9-6971-4101-5ef7-08dc4a464b2a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 88lXRhC0TZAfiVKUa5621+vLtg8y/x0FijQ7LPIglhhY0h8s6MbhynY09O476FIhPdpB5hlqvr/rtup8kp1K6XbPSUyjD20UF2RMl8BTkH8s9w9NtNlQIav56MBXc3QmZcyldWUWtlOBJ2dExctTuh2VHOLaLlzZ92TWrTS6djH+t40zQbIgQRzqvDLrrd1W0rpc+VLkk6abFU7b50Yztvu0WswsNGKivRz2WN0uAKsm0/LeWpDBTqY/E9175hizaa9d589rW6injuHmbhEqUdyF2lBn2NftA97Rnj3o6Qadiu2eja0x6WTuD7vkAHyJRYSZrEFYqpx/TJjxYwWOTcHBLWd6oe3429c8euq8i39XcChbtWhJKadNRm0Q97qCSxuHY699cbO/hI4SUVhe8lJ9uW/QI7Wz8wkmDy33a+dLLSgMu8/DzYOp5xk4XAyDw1j5G1Wk1MayJ6eoCPmaONcdkRu6Ovrs/o3xGMWWDyX5xpeqe6DL6f8WrQ1AxGLH9VHkEiDvRnvItu30IrQbGZV4dJbTjWx4vRSsiHT5aTrttUjk7YFRZ96iTrhvfn+ojgtdSd430ip5MVOIP0BeNiOu/F04YPVD5OdN6jtyxzXY8tUk2aBPZRwilHFYRITlSVtzzUgx9Wm1nkUxxDc6t/ofnGX3vUaCegJRpSybqLg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?RVRNQ0M3d0VjWUxLMTZXZFNUM0VJb09vaGJVRm1IZDF3UHRKblp2L3pkRlJM?=
 =?gb2312?B?NGFNZktJUFcyOS9CRkxuRTYwRmZSeHZQeTlGS293RVE3YmdYekY0TFpGSXdW?=
 =?gb2312?B?a0hEdCs2dWoraWl5RldLeDJRNkQ4MW5Jd1NGTnlrN1JyV1lPZ2k4TEI0Ri9O?=
 =?gb2312?B?cWlndE1pcDZXeGF5MWJhTnBSVk5tQXVoQjBhT0VsM1VyUGtyRnJLYXNiQWhD?=
 =?gb2312?B?ajI0MHB0dTRTR0RkVlowQ3FYeDJTYXV2RFYrRWR0Nkx2b3dma2FJaStjS3Ar?=
 =?gb2312?B?MWxzU0RSWFpmT0s0R1JteWZmcDkzdngzUTdmVnVVVXhtaldsZlpnSmF4RGdB?=
 =?gb2312?B?K2ttOWNIdlZLc1dxb0ZEVXBFNUMrdVZSZ3hvdmg4V1RtM2d2MmcwREw1ZFA5?=
 =?gb2312?B?Zy9xNEE3ZHNXQUQ5K1hWWmpsTVg0cFlMZk80a0RZa0s2Y1F4UlM1QjhhMWF5?=
 =?gb2312?B?QU1ZZlBwbWxQaGQ3M2JnTGt3cHRGM3pwdGcvZGNheGFvQmlJcjB6QjQzdG5X?=
 =?gb2312?B?NStkd09PWUdqdUZhUWExbnNaV0FhaFRTRlRQN1ZtbkIrbFEyb2s5ZG9UK01w?=
 =?gb2312?B?MGxSSVVXUnYwVjFOUG9ESklrM2Y4ZnpHUFRGZHVteXhNb3NoRkMyM1Z5YVZu?=
 =?gb2312?B?MzA2OUVDWHFRbUJSYjNtNm1CMWhHL1U0QUs4NnpSekF4OFFJS09FOVROZVpT?=
 =?gb2312?B?cDNJbDlGdlU1WGM1L0NTRlBWSmJUblNCdTByVXFVVE0zemFBemhNMEphMk9P?=
 =?gb2312?B?K2hiRGYyM1VZM1FIZ1hlN0JxYzk1U2kyYk9NZFFZNmZNSzZFVyt1UDRBd0k1?=
 =?gb2312?B?eit3K0NiSGcvZDBnSjJQMjRaSTdzSTBTOWVuZDUyOUF4VlBlMnZSbWRPQ0Nz?=
 =?gb2312?B?WlhWLzdXZG1jdDRneUJjb2VYaW9FblZiM04wc0crdjVyQU5PZmMyWGpHK1Iw?=
 =?gb2312?B?T0Rxa1VCRnRuUlBYSjlnbUNGSjE1WXJ3Z1FuTzhZcElzMWowOUFJRmNJQTY5?=
 =?gb2312?B?U2E3S1Jrbktnem5JTzNzNkhsQ3JRbUl0d3U2aGVFSEI5VFZZWlcyK3N1WVRW?=
 =?gb2312?B?dUVsVzdnNitkMnRXZDR1VW1kQzhnNjZvOEdnRTYwNi9KRWJNRjFqcE5naFg3?=
 =?gb2312?B?d1FxWk83VnJrQ1J0SWErcUdMRG01Z0ZJY1R4c01yeDYzWWdHcFNoK2F6ZWty?=
 =?gb2312?B?d0ExcUNiS0ZaWWdkR1BYQzl5clZkUVgrWXcxZEJvWjdyOUFaNEp5bmdqWmwx?=
 =?gb2312?B?RE53Tzg5NEtBYWpGd1NObVI2K1NwbWtIcEVqMDU3N0g2eU9xRUpiYmVZQklY?=
 =?gb2312?B?Z2xFbkFWdmFYRFF0OVc0S2dwV2EwWDhFS1p0b3EzMHp5cE5lV29abTJvdGdJ?=
 =?gb2312?B?WXRtcUFYMTMxbE5TbTY2ZGFGWGh1dm1SdUZoMEYxcDBzTDNvdkdITHhPaUtQ?=
 =?gb2312?B?V3J5WXcvZEtZU1ZmZUpqVjR6L1FZenhCdHFWZ3p6NGlOVFNiWHlpbXh4SWFD?=
 =?gb2312?B?ZnRGc1BVOVV1eUtFZzdCUFJBZXJGVUhpUnpNa2F1Q2l2aWZWcmtxalhBdmJ0?=
 =?gb2312?B?SjREcExHR3NxZ1R0bmxFdENTQmtFT2hLeEY4WlhXQ3NMQWZVWXIrWEZRMWtQ?=
 =?gb2312?B?SlJKKy9XY056WUdyWUJGRXcvRXZhcy83UElSSUljMStJNkNscEhoV0VIM2x5?=
 =?gb2312?B?YzhDMUoydU9JcmU1bVQrR1JaM0hReGNjQnl5K1B6L2tGZmhwZUFqUDM1TkVL?=
 =?gb2312?B?eFRFN29nazdQdjFLVkNMbFNVMGh2V3NxRi9ubGVuUDhXVUtST3NmUHVQQjN0?=
 =?gb2312?B?RkJzRjhEclZCZGJ6VTFpb2lrM28rNS9rNlNwU1RkcDQxL09QQlBIdGNQTnVD?=
 =?gb2312?B?L2dwSGdSTTV3TXNRSEZ5Y2tLcjB6b2RJc0ZrOWZsbW1PWUlsdGZGSVBXcFlM?=
 =?gb2312?B?bEZ3VzZPcXNwT3UwdC9aN05yZ0krQ3g0RG9pK0JseDA5bWJQblpFNjhpVC9k?=
 =?gb2312?B?ZWNoRTBDd0hlR29HUEd4bFJyb1BEYW1YY0hIblBGazIyemRURmwwOXpmVEFI?=
 =?gb2312?B?ZnVNY2E2cWljWlJOWE1MRTkyaG5CS0oxVlFoM0VaVUdHaHNXaE1qalNvY3ZU?=
 =?gb2312?Q?gWpOqFVfYC9d53gzyqYetqC8I?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d0c9ad9-6971-4101-5ef7-08dc4a464b2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2024 08:01:34.8649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HKaf7ggTkROl33aYkC1frbP4ZgM4kJ/+jVS+HpMeKn5Kv5+S/NsJS1Ck5VoPggASq3SlzAPi2Kbjl2UqvWHrZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7932

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGcmFuayBMaSA8ZnJhbmsubGlA
bnhwLmNvbT4NCj4gU2VudDogMjAyNMTqM9TCMjLI1SAyOjQ5DQo+IFRvOiBIb25neGluZyBaaHUg
PGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiBDYzogbC5zdGFjaEBwZW5ndXRyb25peC5kZTsgYmhl
bGdhYXNAZ29vZ2xlLmNvbTsgbG9yZW56by5waWVyYWxpc2lAYXJtLmNvbTsNCj4gbWFyZXhAZGVu
eC5kZTsgbWFuaXZhbm5hbi5zYWRoYXNpdmFtQGxpbmFyby5vcmc7IGxpbnV4LXBjaUB2Z2VyLmtl
cm5lbC5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4ga2VybmVsQHBlbmd1dHJvbml4LmRlOyBkbC1saW51
eC1pbXggPGxpbnV4LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBQQ0k6IGlt
eDY6IEZpeCBpLk1YOE1QIFBDSWUgRVAgY2FuIG5vdCB0cmlnZ2VyIE1TSQ0KPiANCj4gT24gV2Vk
LCBNYXIgMjAsIDIwMjQgYXQgMTE6NDU6MzhBTSArMDgwMCwgUmljaGFyZCBaaHUgd3JvdGU6DQo+
ID4gRml4IGkuTVg4TVAgUENJZSBFUCBjYW4ndCB0cmlnZ2VyIE1TSSBpc3N1ZS4NCj4gPiBUaGVy
ZSBpcyBvbmUgNjRLYnl0ZXMgbWluaW1hbCByZXF1aXJlbWVudCBvbiBpLk1YOE0gUENJZSBvdXRi
b3VuZA0KPiA+IHJlZ2lvbiBjb25maWd1cmF0aW9uLg0KPiA+DQo+ID4gRVAgdXNlcyBCYXIwIHRv
IHNldCB0aGUgb3V0Ym91ZCByZWdpb24gdG8gY29uZmlndXJlIHRoZSBNU0kgc2V0dGluZy4NCj4g
PiBTZXQgdGhlIHBhZ2Vfc2l6ZSB0byAiZXBjX2ZlYXR1cmVzLT5hbGlnbiIgdG8gbWVldCB0aGUg
cmVxdWlyZW1lbnQsDQo+ID4gbGV0IHRoZSBNU0kgY2FuIGJlIHRyaWdnZXJlZCBzdWNjZXNzZnVs
bHkuDQo+ID4NCj4gPiBGaXhlczogMWJkMGQ0M2RjZjNiICgiUENJOiBpbXg2OiBDbGVhbiB1cCBh
ZGRyX3NwYWNlIHJldHJpZXZhbCBjb2RlIikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBSaWNoYXJkIFpo
dSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IEZyYW5rIExpIDxmcmFu
ay5saUBueHAuY29tPg0KPiA+IEFja2VkLWJ5OiBKYXNvbiBMaXUgPGphc29uLmh1aS5saXVAbnhw
LmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYu
YyB8IDUgKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4g
PiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiBpbmRleCA5OWE2
MDI3MGIyNmMuLjMyMzhiNjM3MjFiYyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250
cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9k
d2MvcGNpLWlteDYuYw0KPiA+IEBAIC0xMDEzLDkgKzEwMTMsMTQgQEAgc3RhdGljIHZvaWQgaW14
Nl9wY2llX2VwX2luaXQoc3RydWN0IGR3X3BjaWVfZXANCj4gPiAqZXApICB7DQo+ID4gIAllbnVt
IHBjaV9iYXJubyBiYXI7DQo+ID4gIAlzdHJ1Y3QgZHdfcGNpZSAqcGNpID0gdG9fZHdfcGNpZV9m
cm9tX2VwKGVwKTsNCj4gPiArCWNvbnN0IHN0cnVjdCBwY2lfZXBjX2ZlYXR1cmVzICplcGNfZmVh
dHVyZXM7DQo+ID4NCj4gPiAgCWZvciAoYmFyID0gQkFSXzA7IGJhciA8PSBCQVJfNTsgYmFyKysp
DQo+ID4gIAkJZHdfcGNpZV9lcF9yZXNldF9iYXIocGNpLCBiYXIpOw0KPiA+ICsJaWYgKGVwLT5v
cHMtPmdldF9mZWF0dXJlcykgew0KPiA+ICsJCWVwY19mZWF0dXJlcyA9IGVwLT5vcHMtPmdldF9m
ZWF0dXJlcyhlcCk7DQo+ID4gKwkJZXAtPnBhZ2Vfc2l6ZSA9IGVwY19mZWF0dXJlcy0+YWxpZ247
DQo+ID4gKwl9DQo+IA0KPiBJIHN1Z2dlc3QgaW4gaW14Nl9hZGRfcGNpZV9lcCgpDQo+IA0KPiAJ
ZXAtPnBhZ2Vfc2l6ZSA9IGlteF9wY2llLT5kcnZkYXRhLT5lcGNfZmVhdHVyZXMtPmFnbGdpbjsN
Cj4gDQo+IAlpdCBzaG91bGQgYmUgc2V0IGJlZm9yZSBjYWxsIGR3X3BjaWVfZXBfaW5pdCgpLg0K
PiANCj4gSWYgeW91IGxpa2UsIEkgY2FuIGFkZCB0aGlzIGZpeGVkIHRvIG15IHBhdGNoIHNlcmlh
bCB0byBhdm9pZCBjb25mbGljdA0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1wY2kv
WmZtNzIwZno5TkUwZkQlMkZQQGxpemhpLVByZWNpc2lvbi1Ub3dlci01DQo+IDgxMC9ULyN0DQo+
IA0KVGhhbmtzLCBJJ20gZmluZSBhbmQgZ2xhZCBhYm91dCB0aGF0Lg0KDQpCZXN0IFJlZ2FyZHMN
ClJpY2hhcmQgWmh1DQoNCj4gRnJhbmsNCj4gDQo+ID4gIH0NCj4gPg0KPiA+ICBzdGF0aWMgaW50
IGlteDZfcGNpZV9lcF9yYWlzZV9pcnEoc3RydWN0IGR3X3BjaWVfZXAgKmVwLCB1OCBmdW5jX25v
LA0KPiA+IC0tDQo+ID4gMi4zNy4xDQo+ID4NCg==

