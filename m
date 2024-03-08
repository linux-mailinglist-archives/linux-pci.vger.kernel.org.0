Return-Path: <linux-pci+bounces-4662-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CEB876376
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 12:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BFB21C20DE9
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 11:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D783C5645C;
	Fri,  8 Mar 2024 11:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="pASJtXlY"
X-Original-To: linux-pci@vger.kernel.org
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2072.outbound.protection.outlook.com [40.107.113.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932F43C24;
	Fri,  8 Mar 2024 11:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.113.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709898178; cv=fail; b=W1Ftrvcn9umzy44zpGBpuHLrm5YOpvQ8hlHiGxfNU66qgNPcShj/YCql2uH4q7xDXa1B++LgDyTiK/yBzEXKXE1XJJ2OekC+EkgcF4dF8/ryY8yoeDSbdeEFtTwgo1XdP/xPi6Kk1iJ2nQ+h4HYJlbyM+ZebMeB0sh8YVXg6DQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709898178; c=relaxed/simple;
	bh=z8cgDZ7B3iCq9XFzjhwSL2FLM/RktqmmlGjVusxvOdc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Vd0w8S1x5mRiwP4XR2tGB6x1O9CcpCXuS9KPob19vQASW4ggUnoSHA1aBmpGaJMoNPvPszkQuCWTRJw1AYlj9/sTiRbOea5GJ+FOBgdE/51TnPInnf3EO8/OvlZgyZSiYUqrNTHmrxMI3QZfC+NtXi08a1Oc/k5OoZPrVKnGitE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=pASJtXlY; arc=fail smtp.client-ip=40.107.113.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I2+l/FHYFSgNPJbD19MveFghendXvZWz0AotVItm6HervOarOrF3VWpmSx5eII3mxaUv/eNdf3+Y4xoSFL/BeBLz+8r5ocytTFUS1HK/7fhAgSWr9RUXSAxcS7fEYykr2hHM40kXYhowey3RGP/wikZ8WeoDo//uEX89rzDcdA4SdA6Fa+19yV1Kla8lblx4wmNMq3E+yN6muLtIhh6HymFWhp6kPOf63+YzetT6LrSpNvBR/suAxgwLL/E6ZopiE5jCojJNWn6N7b28zZalnuVqRBdR5R8uRcA1YueZLBIUwGqmFcGaWSNz5kWUsFVwB0l+8+ywJqEXp4BvOG+w/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z8cgDZ7B3iCq9XFzjhwSL2FLM/RktqmmlGjVusxvOdc=;
 b=oRw3XeHgEsJQqLj8OnUaMb8PP86VENxoUMq1pYcprfX/ykZ3wkLSVrXX2eYOVADC3LMohKreFNv+5F9JaoQSWqql5WlD/j+WcQgUTolNmvNHbFNtE6FzKHVXzv2u31KbZTi4SnQ3bhToPaon/pZRHMoyJtxrkB7U2eM8GsMPdT1LpCmfwKlMJSzlnG+I7NTjEBAYClWd3j9Kf99ra8REZjF54N7UE742UNnvUNTbDjT7W0qFaks3KiyGfmCYCb2MWjz5klE1MeDTP25XjmSe8s7O4chC5o2AFHs8qPuojDLhBgyzG5oQQBwE2FYrwdP9xgQ7MqXOMZc8CgxDRvkAHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8cgDZ7B3iCq9XFzjhwSL2FLM/RktqmmlGjVusxvOdc=;
 b=pASJtXlYLmiS3qutkhh2u+pQt5cLHZ4oQVQhsq9c3vxGFsz21azDG/BQGqLbgu59XlCRbyzYrevWJzWv5CM9aSzwmrv2Gts8e2WS+tikuFl/3a9qrxjOUVjjeoZ5FpCNc6yw+2PzDFtgxV5MpibqcT/yjzow7SwStbJgU+RxumU=
Received: from TYCPR01MB11040.jpnprd01.prod.outlook.com (2603:1096:400:3a7::6)
 by TYWPR01MB10774.jpnprd01.prod.outlook.com (2603:1096:400:2a6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Fri, 8 Mar
 2024 11:42:54 +0000
Received: from TYCPR01MB11040.jpnprd01.prod.outlook.com
 ([fe80::f9d2:106:9dc3:224f]) by TYCPR01MB11040.jpnprd01.prod.outlook.com
 ([fe80::f9d2:106:9dc3:224f%3]) with mapi id 15.20.7362.029; Fri, 8 Mar 2024
 11:42:54 +0000
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Jingoo Han
	<jingoohan1@gmail.com>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kw@linux.com>, Rob Herring
	<robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Marek Vasut
	<marek.vasut+renesas@gmail.com>, Kishon Vijay Abraham I <kishon@kernel.org>
CC: Serge Semin <fancer.lancer@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "linux-arm-msm@vger.kernel.org"
	<linux-arm-msm@vger.kernel.org>, "mhi@lists.linux.dev" <mhi@lists.linux.dev>,
	Siddharth Vadapalli <s-vadapalli@ti.com>, Frank Li <Frank.Li@nxp.com>
Subject: RE: [PATCH v4 2/5] PCI: dwc: Skip finding eDMA channels count for
 HDMA platforms
Thread-Topic: [PATCH v4 2/5] PCI: dwc: Skip finding eDMA channels count for
 HDMA platforms
Thread-Index: AQHab7Aw3T9l0x6d+UaXMgvucrUsebEtvARA
Date: Fri, 8 Mar 2024 11:42:54 +0000
Message-ID:
 <TYCPR01MB11040F44BB95F0483EFC8DF0CD8272@TYCPR01MB11040.jpnprd01.prod.outlook.com>
References: <20240306-dw-hdma-v4-0-9fed506e95be@linaro.org>
 <20240306-dw-hdma-v4-2-9fed506e95be@linaro.org>
In-Reply-To: <20240306-dw-hdma-v4-2-9fed506e95be@linaro.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11040:EE_|TYWPR01MB10774:EE_
x-ms-office365-filtering-correlation-id: dcc50823-1efa-4d51-17c9-08dc3f64e47e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 c8j4FVv/Lr2w4nZ3WQw2fdq8jKzTAnLfXe/u71O0awgGPxsLvvYFR3nHvQxJrSGaQf1swCmGmqZQ1yfcU2By0asKtdGgGchMlC/s9ixYRb4jNXqN6kiXkbcbehvixjqL2Q1qy2C1C8dStxbe77BalTPoMtgt+kV36S8iOMi5RsmSXu0P1+FIVpEmFdI+g+sw/jlW5nhMF6SSXDueEgFqXZhNE7gr+yNhX0Rcy+pCY9uWybd7+EEa9RFluwgZYpz9mr+R2nPJQ+oiHXD2bAMjjtFSOioLqD1xAE7xztc0UnsGmg2QW3eQlv0d2NOGUvgdGXSJxcZApfWlTiT83wnfVYrukQq9KWSyXR5r9LHItm8T7TveVETFBVLN//PesFhJSbzItdHC+Xt8pb3LW15CE5siLP0RrOuN/Cw+VR3UQDDpXqCi2OjyPQ4fxes76Vq0XWTijPhNpcMcSWOXKOps371tPJSVK3n3YQ9FlODAMvn0oyEjYusUMU1j6kB8Y5fu8nTrFbddcW94O16e5uXNqyFs7y2fMiJMcmxUx9ydBs1iil3sItKgr6htnsf65xv/R2RMCPf4iFN42ZRArGF4jCXJWmN3LIdZe2aLgTppbralrjPWuw2eaJ0FNsNq0HMZTShnFfg+rx8VD7/lRVZZYdI03KbYZO/8b9ZpgzOjiEEICD843stnPAZfBwDur8lEVBV82ryD2rN5Zxlr38egJWxzPHfWYbcmb4F0LYG1pU4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11040.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U1I4cjllbnhCdWZEWEhyV1BTejRPOU8zT3dvZ282cVZyUk9sNHNUTWR1akN0?=
 =?utf-8?B?TUpNbWFWa0xDYUNpMHpUOEk3Q1h6d1JPdC9NdG9oanR2YktoT0MrWGk0UzZq?=
 =?utf-8?B?YmwrQi9FNXB2TnpuWnh2SlA4Mzk2dUxKRjkyb2ZCVzg2U2doRFhCcXVSdFF4?=
 =?utf-8?B?eHNnOHRscTd2aWJFOHY5S2h0cXlDQXVDZzVSWWpiNW5BeXlLakpwNExjV0pO?=
 =?utf-8?B?T1E5alQ3UmhyeURpd2tpRVR4OExWaGNhTHhaOGxic0QwUHRVM0RhcjJHU2pa?=
 =?utf-8?B?YzVtb3A2ZWdNWURsV3A3Y2xmMi83cldmVTdLOUJhaEdFY1VIeVQ0dmFpbEtp?=
 =?utf-8?B?QmdyWXIxOFppOWRlUFFvazREQ09OS1FIUVlBSlNsS1pPRW1uc3B5MlFjR0tU?=
 =?utf-8?B?b0UvcXloOG9BZ0dyaFFxM2tWd2tVdmVLdE96Y3AyZk1iRjc3KzQ3eXlGa2xN?=
 =?utf-8?B?bElLdFBld1ZrbEFLRjlaUHhPUTdnWnNnSHdWaERIbzJwK1dyaEJFMzNxWjZJ?=
 =?utf-8?B?T20rMUxSdW83eGcvNUJkTFpYN0cyZnY5TDJjdm9HQllKU0NOUk4wK2F3enZW?=
 =?utf-8?B?akkxbmZ3bFpPQjZMNmUrNkZjTzNLU2Rra3JTY0djZ0MxRlU3RkdmNS81QzdN?=
 =?utf-8?B?czV4RklUa1VsNUdxb29ZRXBXbHNwZDR0YW41c1I0am9BRjV2ZU5lN2V0eHVM?=
 =?utf-8?B?T3pKQkRPMVRFMmZIcVdWMUs4WmduWit4eUZ6c1R4VEYzZmdCdXdNdGFZMnVm?=
 =?utf-8?B?Um9EOHRIcVZnVEp4RHI2bXhYeitkRDZnME9JL0wxWms2ZTA4b2ZzMHN5OFNn?=
 =?utf-8?B?OWltd1RwRzR4cE4zeWkvVGNCei9IejNBdkp3Zi9PMzg2Z1V4Rkg5WHI4SW5M?=
 =?utf-8?B?d3A2M3p0NEFhMWhERjlBeDVjbmVwV2NQbFFJeG5wbklMVXFlUXNNb0RxQjFz?=
 =?utf-8?B?NWtiUjVNK1N0RzlVdDVIUncvbHpvcmVXKzZmZU1NS0VqMytiM2FSVjN4b1Jo?=
 =?utf-8?B?Y0ZmTzB3RHRzVk01azM2SU05WTJJK2lmSHpTR2wvSDFXcnU5TEtUNXQySmlB?=
 =?utf-8?B?R2lEa0IrcVp1dFJRbWlkbE9jRHRNbFE5OEQzZUlQVlZpTFFvMlVRM29xKzJK?=
 =?utf-8?B?RHVNejhpeDk2c0hwemZaRVBhVjI3UllsS0RHSTF2MGpQNENZUUFpSk5NdGpG?=
 =?utf-8?B?YWxwa3BTenM4anRpTWJiSmFUbVJqN1ZFS1h3Zk5uRkhSbldaWk90QTVQSGtq?=
 =?utf-8?B?VWM0QUtEL0ZVeENJWjlsU1BDa29PZ1RBK0pDR1dmUGl2R0orbkFMT2NFNVlZ?=
 =?utf-8?B?elFUTmxYR0RPZ1pxWXkxSmU2OVZsRlM3eUZObWNrVnR0UTBKcUhvQ0xXQ1F3?=
 =?utf-8?B?U0RSQk9WZ2RjUTFBRVc2UEI1bDhiRmx0R3RSdWVManhvTGR2WEZrbDBtN1l6?=
 =?utf-8?B?bllqUlVmcVdiekdsU0tZdkdnVTdmSmt0N0t0VzhtdnFPTDhCcmgxd3M4RzF3?=
 =?utf-8?B?QUZtZHZRVmVPYWp1ZVhjMXg5RUtLaGU2dWd3cWFLSGZVS0pxWTJhQXNMcXBn?=
 =?utf-8?B?c3NHUWJOOWp1bm5GOVQ4N1RMbUY4SmpkcW4xK0lmd0g4S3JONlZKVERrUSsy?=
 =?utf-8?B?TUxmTVpjTFRkdzBtaDh4bWhKTHl5NS9GVklQQ0ZHdnk0OThNRDZyR1Q3ZVlj?=
 =?utf-8?B?NzcyYmxYNWRwZEphWjBxNDVyS2JDY0xlVWtxQXZqaG5ZT1k4VXZZTjJVV1dj?=
 =?utf-8?B?Q1RxOGs1WVJ3bFBhaWk4SFRPR1F2TVplUk03U09Vby81aitjd1I0bWYzY2wr?=
 =?utf-8?B?TnNpVklVeTB4V000MFJUOVhNTWRaRW42SUtYSVNrZU5JQmxVNUlIMFBUc2U3?=
 =?utf-8?B?OWI5Q3FKWFlLZ0pvWmdkbWg5WG5HTi9kQjl5UDhKQVF1VEh3c2t5TzViUEc2?=
 =?utf-8?B?ejdKbFpjMG81RlY3SWJJdENrZ3haMXFOaFhFMVdxQ1hCN25FK2ZFL2crOW9a?=
 =?utf-8?B?T2Z1Tlk5aENrUHFHczgrbUZiU1FqWDNjNlptSkhXRk5EcWRyRHRPeFZENU11?=
 =?utf-8?B?UTZzUnNWUFZXdU5reXNQQkdoUkZpZ1J4Q2xGbHNrU1BVTHUyWGJrMGptdWxr?=
 =?utf-8?B?MkV0eHRldzIza3BFZTBtUkQzTUZwUkRFNmIzNGxGYnZ0MCt1c25wVjJGc2hG?=
 =?utf-8?B?c1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11040.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcc50823-1efa-4d51-17c9-08dc3f64e47e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2024 11:42:54.1896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bOGSwZRaBocO0tvR3YvFc2iPigyLxNhakZU/BUTiE7QTF5J78YWhDiJ0Prxe4jK3KtlrtY/U/UleTrp4gJ92YDU8pzMPMy81DtutkOuo46a9Bme5EUiAkaNa/Ch9XDTA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10774

PiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2YW0sIFNlbnQ6IFdlZG5lc2RheSwgTWFyY2ggNiwg
MjAyNCA3OjIyIFBNDQo+IA0KPiBJbiB0aGUgY2FzZSBvZiBIeXBlciBETUEgKEhETUEpIHByZXNl
bnQgaW4gRFdDIGNvbnRyb2xsZXJzLCB0aGVyZSBpcyBubyB3YXkNCj4gdGhlIGRyaXZlcnMgY2Fu
IGF1dG8gZGV0ZWN0IHRoZSBudW1iZXIgb2YgcmVhZC93cml0ZSBjaGFubmVscyBhcyBsaWtlIGl0
cw0KPiBwcmVkZWNlc3NvciBlbWJlZGRlZCBETUEgKGVETUEpLiBTbyB0aGUgZ2x1ZSBkcml2ZXJz
IG1ha2luZyB1c2Ugb2YgSERNQQ0KPiBoYXZlIHRvIHBhc3MgdGhlIGNoYW5uZWxzIGNvdW50IGR1
cmluZyBwcm9iZS4NCj4gDQo+IFRvIGFjY29tbW9kYXRlIHRoYXQsIGxldCdzIHNraXAgdGhlIGV4
aXN0aW5nIGF1dG8gZGV0ZWN0aW9uIG9mIGNoYW5uZWxzDQo+IGNvdW50IHByb2NlZHVyZSBmb3Ig
SERNQSBiYXNlZCBwbGF0Zm9ybXMuIElmIHRoZSBjaGFubmVscyBjb3VudCBwYXNzZWQgYnkNCj4g
dGhlIGdsdWUgZHJpdmVycyB3ZXJlIHdyb25nIGluIGFueSBmb3JtLCB0aGVuIHRoZSBleGlzdGlu
ZyBzYW5pdHkgY2hlY2sNCj4gd2lsbCBjYXRjaCBpdC4NCj4gDQo+IFN1Z2dlc3RlZC1ieTogU2Vy
Z2UgU2VtaW4gPGZhbmNlci5sYW5jZXJAZ21haWwuY29tPg0KPiBSZXZpZXdlZC1ieTogU2lkZGhh
cnRoIFZhZGFwYWxsaSA8cy12YWRhcGFsbGlAdGkuY29tPg0KPiBSZXZpZXdlZC1ieTogRnJhbmsg
TGkgPEZyYW5rLkxpQG54cC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IE1hbml2YW5uYW4gU2FkaGFz
aXZhbSA8bWFuaXZhbm5hbi5zYWRoYXNpdmFtQGxpbmFyby5vcmc+DQoNClRoYW5rIHlvdSBmb3Ig
dGhlIHBhdGNoIQ0KDQpSZXZpZXdlZC1ieTogWW9zaGloaXJvIFNoaW1vZGEgPHlvc2hpaGlyby5z
aGltb2RhLnVoQHJlbmVzYXMuY29tPg0KDQpCZXN0IHJlZ2FyZHMsDQpZb3NoaWhpcm8gU2hpbW9k
YQ0KDQo+IC0tLQ0KPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJl
LmMgfCAxNSArKysrKysrKysrLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25z
KCspLCA1IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRy
b2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5jIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2Mv
cGNpZS1kZXNpZ253YXJlLmMNCj4gaW5kZXggM2EyNmRmYzUzNjhmLi41OTk5OTFiN2ZmYjIgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5j
DQo+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5jDQo+
IEBAIC05MjcsMTMgKzkyNywxOCBAQCBzdGF0aWMgaW50IGR3X3BjaWVfZWRtYV9maW5kX2NoYW5u
ZWxzKHN0cnVjdCBkd19wY2llICpwY2kpDQo+ICB7DQo+ICAJdTMyIHZhbDsNCj4gDQo+IC0JaWYg
KHBjaS0+ZWRtYS5tZiA9PSBFRE1BX01GX0VETUFfTEVHQUNZKQ0KPiAtCQl2YWwgPSBkd19wY2ll
X3JlYWRsX2RiaShwY2ksIFBDSUVfRE1BX1ZJRVdQT1JUX0JBU0UgKyBQQ0lFX0RNQV9DVFJMKTsN
Cj4gLQllbHNlDQo+ICsJLyoNCj4gKwkgKiBBdXRvZGV0ZWN0IHRoZSByZWFkL3dyaXRlIGNoYW5u
ZWxzIGNvdW50IG9ubHkgZm9yIG5vbi1IRE1BIHBsYXRmb3Jtcy4NCj4gKwkgKiBIRE1BIHBsYXRm
b3JtcyBkb2Vzbid0IHN1cHBvcnQgYXV0b2RldGVjdCwgc28gdGhlIGdsdWUgZHJpdmVycyBzaG91
bGQndmUNCj4gKwkgKiBwYXNzZWQgdGhlIHZhbGlkIGNvdW50IGFscmVhZHkuIElmIG5vdCwgdGhl
IGJlbG93IHNhbml0eSBjaGVjayB3aWxsDQo+ICsJICogY2F0Y2ggaXQuDQo+ICsJICovDQo+ICsJ
aWYgKHBjaS0+ZWRtYS5tZiAhPSBFRE1BX01GX0hETUFfTkFUSVZFKSB7DQo+ICAJCXZhbCA9IGR3
X3BjaWVfcmVhZGxfZG1hKHBjaSwgUENJRV9ETUFfQ1RSTCk7DQo+IA0KPiAtCXBjaS0+ZWRtYS5s
bF93cl9jbnQgPSBGSUVMRF9HRVQoUENJRV9ETUFfTlVNX1dSX0NIQU4sIHZhbCk7DQo+IC0JcGNp
LT5lZG1hLmxsX3JkX2NudCA9IEZJRUxEX0dFVChQQ0lFX0RNQV9OVU1fUkRfQ0hBTiwgdmFsKTsN
Cj4gKwkJcGNpLT5lZG1hLmxsX3dyX2NudCA9IEZJRUxEX0dFVChQQ0lFX0RNQV9OVU1fV1JfQ0hB
TiwgdmFsKTsNCj4gKwkJcGNpLT5lZG1hLmxsX3JkX2NudCA9IEZJRUxEX0dFVChQQ0lFX0RNQV9O
VU1fUkRfQ0hBTiwgdmFsKTsNCj4gKwl9DQo+IA0KPiAgCS8qIFNhbml0eSBjaGVjayB0aGUgY2hh
bm5lbHMgY291bnQgaWYgdGhlIG1hcHBpbmcgd2FzIGluY29ycmVjdCAqLw0KPiAgCWlmICghcGNp
LT5lZG1hLmxsX3dyX2NudCB8fCBwY2ktPmVkbWEubGxfd3JfY250ID4gRURNQV9NQVhfV1JfQ0gg
fHwNCj4gDQo+IC0tDQo+IDIuMjUuMQ0KDQo=

