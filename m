Return-Path: <linux-pci+bounces-19390-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3E7A03A0A
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 09:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F40D71886C11
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 08:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9250A1E1A16;
	Tue,  7 Jan 2025 08:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Me74ibqw";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="nQ41cbhd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA5F1E3DD3;
	Tue,  7 Jan 2025 08:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736239446; cv=fail; b=IWXfMNKg0vrvDxIiK8GWXn2nIzxNtE23vw6pSJXRFoNjbks0snJJOoBEruRUtcfIxnJi3XDfTTTL74uKoUFzEj0S83i0x214GJgpxrbsvlZ2S0J+wjOkhb+sHr3Yodufq+7PRXbrYBGiMKcGdocLuENpDJ/cM62VNqd/8cb2fyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736239446; c=relaxed/simple;
	bh=uzFxnh4ChrRmkpdtdA3pwMJarANa6a6IrXbwAe8J0sE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lL0j0iMcP0xviVo70v0THiayzTFLA17UOU/Qbcdqnuk9tenDV452DNTaIRBycinXTMqlOSfsox27lJEmtxZV0jQDX/joC1i7v7p9ba2aliuWfVzwUKHoidKYqpaxrTrx4ezgckOT6Qi3lgV9VRa/zFMZlkjMbbZlE/ybHcXQa6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Me74ibqw; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=nQ41cbhd; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 89d016c6ccd311ef99858b75a2457dd9-20250107
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=uzFxnh4ChrRmkpdtdA3pwMJarANa6a6IrXbwAe8J0sE=;
	b=Me74ibqwDnllYaZv37OiFxT9HKKnIgQVp9WgpAM8naEjIiZJ5VNXnyWUNG3PvXk9NCRysN0X+OztbQA9niT0MDC29P0jrwX66T7qNJYU39O/mUFuiyxXVLGLf8v3JnTdpyHRANwW0yjfCsWtCQX1uZVtjw5ZIUPFhxf2jAQAuZ4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:75a6566d-980f-46af-8394-0693049343db,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:751a7e37-e11c-4c1a-89f7-e7a032832c40,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 89d016c6ccd311ef99858b75a2457dd9-20250107
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <jianjun.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1664267810; Tue, 07 Jan 2025 16:43:59 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 7 Jan 2025 16:43:58 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 7 Jan 2025 16:43:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xbdVxS7MCDGHYPhvBB83VE51N9ib7sjyjhZdOSbp3kol55ClE7dmYEVNXiykWBx8g9FdJ7TEVNYvq5rbnyD8uQFLPaNcfg7yhn5su/B5a7/ToInVTFFPR8fRZgATDEwsAO9PcH8Fb2bW3+6hRIbB4vAA+09vCZvA9TQpFe1xrZE0VvTey/vzGL57Vl0Pf1iJzdbGY+R9v1ChU6vELpC33+ZCJiSBTrb0GrGXiz3L0+tywNJNmtngD48hSYyzL4hltDtR5i+/wRJ8KonzCOdWzL+44xe9ScZFIPbWmLyzzA1Hb/V2GGUdZkM6kzoixZ0edM/ClOOVyiGeDF1bVOsc2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uzFxnh4ChrRmkpdtdA3pwMJarANa6a6IrXbwAe8J0sE=;
 b=LtdmhDknOtMopiSVhQoA7Zr0CiAu4Gd02bFLnXgldkQG7feNnZhTYrp9i3DP9tf76Mly5BVhjSy+XNO5JU3nug2FDzsfAdQmWFoVJSZI6uuy9BbmJd3dCAWPESfb+rndutHoIVaR3/T4bEMU2peh1EHhfjmHH4bqRcyaHiqNsCLK7j1luAmhO1EX8JP7FCDk2kU3TfX2eXYMbd0hDo3QA+ULGiXyKye2yyRdmJA0NMc/EzTNZ3oy7pKVFlU/ZMDnBzM1ZJjWlDKmDkRcIp0LoeV2mPRKRndCQiSX43B9C6JHph86RRE+qh9TjqumCR0CrSqBStxGnfY5E3zJGAVn2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uzFxnh4ChrRmkpdtdA3pwMJarANa6a6IrXbwAe8J0sE=;
 b=nQ41cbhdaD+vRPqr1N+7ADwtXi9y/uzMgz6DqVTPHcZURJ632vH1P/luuMYbGtNNWgxdyijaFc3TXUokHLqT+jSdTPdjN3OsR8KaJgsNLPA7GYOSyROJ7YOgeb7v73ueTJ01cd2hvUh8DmIiCsn2lzWVWmLk5+Lak9sEFpIQYIs=
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com (2603:1096:301:17::5)
 by TY0PR03MB6949.apcprd03.prod.outlook.com (2603:1096:400:277::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 08:43:55 +0000
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::1c6e:6591:5151:27e6]) by PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::1c6e:6591:5151:27e6%3]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 08:43:55 +0000
From: =?utf-8?B?Smlhbmp1biBXYW5nICjnjovlu7rlhpsp?= <Jianjun.Wang@mediatek.com>
To: "krzk@kernel.org" <krzk@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	Ryder Lee <Ryder.Lee@mediatek.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "manivannan.sadhasivam@linaro.org"
	<manivannan.sadhasivam@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "kw@linux.com"
	<kw@linux.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, =?utf-8?B?WGF2aWVyIENoYW5nICjlvLXnjbvmlocp?=
	<Xavier.Chang@mediatek.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [PATCH 1/5] dt-bindings: PCI: mediatek-gen3: Add MT8196 support
Thread-Topic: [PATCH 1/5] dt-bindings: PCI: mediatek-gen3: Add MT8196 support
Thread-Index: AQHbXaTW76fSj2ANakexjY3C+uSV4rMEw32AgAS7TICAADKxgIABU9KA
Date: Tue, 7 Jan 2025 08:43:54 +0000
Message-ID: <9b0a463312702fb78e4ca2ba79c9ec6b62e33c58.camel@mediatek.com>
References: <20250103060035.30688-1-jianjun.wang@mediatek.com>
	 <20250103060035.30688-2-jianjun.wang@mediatek.com>
	 <ndj6j2mmylipr7mxg42f3lcwgx55cvcjnuuofmlk6n6t5uz5pr@bxugolyfublc>
	 <04ae2a07e2c2d3c03e82596034b1b7711450a0ae.camel@mediatek.com>
	 <eb2088d3-81f6-4cb8-a4d7-6ef985aedbda@kernel.org>
In-Reply-To: <eb2088d3-81f6-4cb8-a4d7-6ef985aedbda@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5365:EE_|TY0PR03MB6949:EE_
x-ms-office365-filtering-correlation-id: 78bf8ae2-4916-43dc-b717-08dd2ef76b7c
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OFhnZXdNNDVmWnNzb2pOR05kczN6TEt2eEdwVVFjcHFmZHhxZ0ZCL1A0cGw2?=
 =?utf-8?B?QjZDSmdjZ1V1VkY4cUh3SWdMNkFLOUdjeHo2N25mOFBvckIzbWtLUzVwT2hk?=
 =?utf-8?B?Q2J4Mzl2am1qMnRXY01IUitXUlZLWFh2eWYzSENDM29ubDIzc3YxQ3Z1TUxD?=
 =?utf-8?B?ZCsyYW1GR3hNZjFqd2xrTDY4MUlVRVB3Vm9zNmtVVWhsclhCdkozTi81Nnhh?=
 =?utf-8?B?WExMSEpFM3YxdGhxcHpYR1JGek0wd1pWaDVzQzBqenlJWk9NVzd2ZHZjTVdL?=
 =?utf-8?B?ZDVJYTBOaEF5cklyV0xXaW44eldQemx0TkJJYlFFTElQbFBmYmN2bXI5YXhS?=
 =?utf-8?B?TzNzRU1nZXdjWjJkWFlvTWFRbno2eDNQTlN1c3k5Q2ZON3hzSTFzMlFoL0Rj?=
 =?utf-8?B?YjBIV3BCb3RUdFVyaDZxcC8ybXA1UFg5MHZrOTNOMkZxcm5pQTVGcDV4d1VK?=
 =?utf-8?B?Wk9lUXV3eENnK0FNM2hpU3d5RGRtRENycVQwWExIeFZpS2gvMTFGaFdRRkY3?=
 =?utf-8?B?anBRbUhvRzRHa2ZQNFVqczVib3hZUmhESVpYWjJRVkI0RnNMeWQvM0lVYzUv?=
 =?utf-8?B?TTJqNUVVTTFZNnZSS04yM1F6U011VTdVbEpQU0RUS08zUkFnQWFUR1JhVFlL?=
 =?utf-8?B?L0o5a3I2SXJFaVFJN240enZPZGp2Ymk3cU5NcytnQWRybmxNSjMweFp3aHk0?=
 =?utf-8?B?WkxqMGFTVUNLbkJkOGcwRWdpUHhISHloVHdsZmhFVmJybmRYTDdNbG9DNkcv?=
 =?utf-8?B?bTlNMEFKNXY2dTRVQk1XVmllcC9rRVNiOE4yWnFvbzNoWFZGeTk2OTdYK0pG?=
 =?utf-8?B?U29hNEw0U0dBQ0VaanpQb0RKUFR6Z0daME5ZNEhpdlNaOWZ6QWZaeWIyc2Zm?=
 =?utf-8?B?a1Z0aUoxZWdBR0RnZWx4SEJZN1VXd203R0haS2Nhdk93dG8wRjJKSG1MWlBH?=
 =?utf-8?B?ZXdKUHRjZnJldTlZMDBpY3dIUU9UMFBJYVY5Z3Z1cmwzNjkwSmNwRGFEN1Jz?=
 =?utf-8?B?eUYwRjZFeFZKbHJKUlZCaWN4YStwajByM2pqamVCV1hjdm5oT2phNkl3M0hy?=
 =?utf-8?B?dUwxTWZhS0J2NGR4SHV4dXpWeVM5bExOdkZYN2lvQW1tNUtnbFY2NUFZMDVm?=
 =?utf-8?B?WWlVbzI0VDNIVk44Q2p0STFBY0hMOUxtaVRNd0pyQTJDcVZpMzhMNSszUi8y?=
 =?utf-8?B?OHdZQ1JQbUM2OGVSV2ZVSXFzM1VmYXYxSFpzaGw5WjJQWDRLZDhvVjcxcnNr?=
 =?utf-8?B?b2g1cEFGOTI5T3lxbVFiMUZkaEwzZ1pEUFpwTDN4QzhGcXR3V0xrcGxFZGhq?=
 =?utf-8?B?L1BtZGNKdFZBN3krbmY5N1BIWTNwZzhJSnljUFhhN0ljQ3hDejJwZUtKUXJZ?=
 =?utf-8?B?OUxzL2dlUWNhNTZuR1NEb01WNkhGRzJKdWZIQmFmeDhXNmExNlorREVNODUv?=
 =?utf-8?B?Zll1UVhFR1hpWVRFTmNPcWZ5cjBHVUp0L0wrc010SnpwZlJjNHgrL3hTTkxO?=
 =?utf-8?B?L3FMMUVWU2FuajF6TjQvSU5zbEJvazBtSnlHeDh0dFlsVittNTg1MExwS2Zm?=
 =?utf-8?B?bVhUZXZQbFY2R0NCTHdWTlNkd0ZiclNON2w4Q2hoOGgrUjMzdUhrang5OVVM?=
 =?utf-8?B?ZWJueTdFajQzL3RCT24rMjBqclFxZ1o0TFJSZiswU01lQlN2WElIdHIxOGJk?=
 =?utf-8?B?OWlSYncycVI2WGFJbkpwVm95TUVqd2NBcVRyOXdYYkNIMStwTjZuOFZMRXNk?=
 =?utf-8?B?cC84ZVRaaHBna0FWMHBjTHFDVDFWZ0JMRlhkNlhRcFNYdCtlZHR2YUtyOVBk?=
 =?utf-8?B?RU1oYXl6QlJOektIQ00rSW5GZlEvQng1bmNPZGs5bVE2dmU1Nm1wdys5WHNm?=
 =?utf-8?B?UVNzeTdORGRUU3dWQWRXTmpjZWFPNnlwV2YrSUw0ZDRUVkpGdU9QdUt6T3VY?=
 =?utf-8?Q?BpQbyCq5byugcj5mTnYTrRKsFglBO0vw?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5365.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVgxZ1Y4K2poU1ZuaXNGNVBUUzVOQVh1NmFMSEJJU3E5T0E4cWtjOEFUU0tS?=
 =?utf-8?B?b0E1M1d2TnFGYTFiTXFPaVZxMVFoYmhWN0dPK3JHTjJwWnVqVkpiWUVvRWxM?=
 =?utf-8?B?bkdQM3hmZ0RTS3lvdzE3MkF4NFZRTzNBOSttc1ZXcTB4YmpHci8xaFZwN2Y1?=
 =?utf-8?B?L1Vyc2ZiYTlTQUR4Wm5OZ21CQ25uNmh3a3dqakRJbmVmMFIyMzF6OFFQMjNL?=
 =?utf-8?B?NndscHNJN3ZWdytJaThFdEZPK2lsUzJWYnQ1eGJNc1gxQkZvaVlGWnJobzNp?=
 =?utf-8?B?SmRzdU92VFVoSzdPWDJZZ3JDRlFZb0Z6Mk93Q1ZnbnRXWmtiNXFrK1RTejdR?=
 =?utf-8?B?YmFMYTZTT2hNcVNyTXRBQ3FCS3JGM2FzdlNDUWRCcE9MT1F1TFZ3bE9rQ3V4?=
 =?utf-8?B?czkvdW5uTHZGanZZS25aQllsWjd6U0s2WXV1dXpmTGtiNm1maXZpNGRTTERn?=
 =?utf-8?B?NmVsMnRnbHJTUWVaYkJ3YkRsdEFUZkZOTHdsbGpBQm1ZY0tvb0JPeko2anZ2?=
 =?utf-8?B?NGtpcUtnVmpDa2VsSWQ3c3k0ZjRiaHZ2RTZuL2VXdElCMFFZbUdNc29lcm1N?=
 =?utf-8?B?ZXZlcWNjOEdVRmszUkdpVDRCVXV1YmdFZStZNEVVT2RxNmVFVWQ0MC9mYkZx?=
 =?utf-8?B?NWNVeEtXcW02bkpDcm9uY3FwV2dUdHJnbzZTeHZKbGJxZ2paMTdoOU9UeUZS?=
 =?utf-8?B?OFZjUExTRVd1NVRNT0JiL0NnVExucitJbjBLaWI0UEF5cXRtS2VRQ21ZanEr?=
 =?utf-8?B?cDQ5ZVRLZzVJRktudzZ4eVA3dVVOWG5ISWJQSGFkeTUreUFrZFJHemhVOVE3?=
 =?utf-8?B?SUhDT0xxTDhRSzFtdDEwWE43N1pCYmtPcUNQMHNTeWZsc2lTbDJmdVB2dmhY?=
 =?utf-8?B?N1JtWFRoZUgzQ2NyZ1BrcUY0c0Z4eEdyTnQ5a29JN0pFOUJHZks3ZzcwcEhG?=
 =?utf-8?B?VnZKTEdOWk1PbTJmVUxJdzFHOXdyMXpUZlJaYlpqelprajlvVTkrTzBHSTJj?=
 =?utf-8?B?TkdaMVdlSXhrTnlmWWd6QlNMMVduak16ZUtXL0pWVGdKNGF2ck96Ri9SNFkr?=
 =?utf-8?B?Uzc1ZW1MOUk0YnVhRnFLQ085VGJENWhnTVJZaCtkQ1dUb1Zyell1SllGeTh6?=
 =?utf-8?B?OUxHWlBNdGkvK2NNUGxzVEdZZGgrVWxCWjJqa1I3NHFaTEw0aVFNN3Nlc0F4?=
 =?utf-8?B?YVdaSlZuMTZHRkg1Qnhsa05qL1VmOXhpU2QxL2lLMXJLcllCdm12bGJSSk1M?=
 =?utf-8?B?QWRsS2pSOTZNK0QzcG5ndy9UdGVOSHdMSk4vbXVtdGI0dEtlTEplN2NqNzZo?=
 =?utf-8?B?UTNTVjYrcm5rWUhWV3NjRDl0SDhneS84b0tVT3pIOEZBMHhlbXp6M3Fwam5V?=
 =?utf-8?B?R3IvcTJRcWVZSDVxYmV4cHVXWDBuTjRUVS93eDRaRXJPWEs4OTBkUXBHODlE?=
 =?utf-8?B?WW9KYU95TDdIanJaOC9xVFZyajh4ZVp1Wm13SmNBQ0NvYStnNzEySGtML1Zt?=
 =?utf-8?B?V2pBVVRDd044dm9xMFN0QkxxMnJBZzF3M1NwYzE5Yk5GSGtJM1FMaDBkZjhq?=
 =?utf-8?B?QS9HeEpKcVJrNzAzelZ3dlRZbkd0QzU0dmRsNEhWNFdBZHhyM09DckM4SUNt?=
 =?utf-8?B?bTNZNHJmeHY1L1RzSTZuaU9rekk3QVVULzVvdXdhSHNLWWZXZ25EdXlreW14?=
 =?utf-8?B?cmdHYUlRV2ZqSDV1L1ZJWFFneGFjVUNwd2VHYnB0TmI0Q0huU09ObEhkclZl?=
 =?utf-8?B?VU44Z2wxczVRRlZlTWNpMDhTWDB0S01SRmxMTEI1YlBOd2U5N0tyNVd5YjN4?=
 =?utf-8?B?TnEycUc5QTRlT0xBWExlVUdCVDByaGM5ak9hOEpIdFFMb25veDdUUS9IZW1X?=
 =?utf-8?B?Wk9QL1pjNmNzeFI0eGxBcUFGYStNL3VSMGMzalZJV29HdkwrdEVOdHJRRURr?=
 =?utf-8?B?dWw1Rk1laUM4MFBVVzEyM2p0d0JHcW5lWHppSFUyOTJUOURNVk9KK2NSUTVw?=
 =?utf-8?B?NmtaV1FlcXE4TXV5dGEvY2lzMFlZbjFucUhuWUVjMWluNmRlZ25qLzQ1MzQ5?=
 =?utf-8?B?QXJ4OUtwQUpLN2pkeDREWXZTRnB6aFg4SGVnUnBNY25hRHR1K2lzb1YydjVu?=
 =?utf-8?B?bUk5dkwwQXJhcFFzdGNCT1BpWE4zeGdxcDMzUjF1bVlvMUw4YjYvTjh6S0Zx?=
 =?utf-8?B?ZkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <899A2CCA36DB4F4DB16FB52BF122885C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5365.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78bf8ae2-4916-43dc-b717-08dd2ef76b7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2025 08:43:55.1097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uNE/RxrLAOJ2Djms/o2WEfEf+K3T6KeSV03TZ8CG54cigcuKPS2n8OQVYFfXLK1ojTL8F7ZrImwiM8csiZxLFEDwZ1Bix+TDTEnmd1iMIFA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6949

T24gTW9uLCAyMDI1LTAxLTA2IGF0IDEzOjI3ICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiANCj4gDQo+IE9uIDA2LzAxLzIwMjUgMTA6MjYsIEppYW5qdW4gV2FuZyAo
546L5bu65YabKSB3cm90ZToNCj4gPiBPbiBGcmksIDIwMjUtMDEtMDMgYXQgMTA6MTAgKzAxMDAs
IEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+ID4gPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFz
ZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cw0KPiA+ID4gdW50aWwNCj4g
PiA+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ID4gPiAN
Cj4gPiA+IA0KPiA+ID4gT24gRnJpLCBKYW4gMDMsIDIwMjUgYXQgMDI6MDA6MTFQTSArMDgwMCwg
Smlhbmp1biBXYW5nIHdyb3RlOg0KPiA+ID4gPiArICAgICAgICBjbG9jay1uYW1lczoNCj4gPiA+
ID4gKyAgICAgICAgICBpdGVtczoNCj4gPiA+ID4gKyAgICAgICAgICAgIC0gY29uc3Q6IHBsXzI1
MG0NCj4gPiA+ID4gKyAgICAgICAgICAgIC0gY29uc3Q6IHRsXzI2bQ0KPiA+ID4gPiArICAgICAg
ICAgICAgLSBjb25zdDogcGVyaV8yNm0NCj4gPiA+ID4gKyAgICAgICAgICAgIC0gY29uc3Q6IHBl
cmlfbWVtDQo+ID4gPiA+ICsgICAgICAgICAgICAtIGNvbnN0OiBhaGJfYXBiDQo+ID4gPiA+ICsg
ICAgICAgICAgICAtIGNvbnN0OiBsb3dfcG93ZXINCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICAg
ICByZXNldHM6DQo+ID4gPiA+ICsgICAgICAgICAgbWluSXRlbXM6IDENCj4gPiA+ID4gKyAgICAg
ICAgICBtYXhJdGVtczogMg0KPiA+ID4gPiArDQo+ID4gPiA+ICsgICAgICAgIHJlc2V0LW5hbWVz
Og0KPiA+ID4gPiArICAgICAgICAgIG1pbkl0ZW1zOiAxDQo+ID4gPiA+ICsgICAgICAgICAgbWF4
SXRlbXM6IDINCj4gPiA+IA0KPiA+ID4gV2h5IHJlc2V0cyBhcmUgZmxleGlibGU/DQo+ID4gDQo+
ID4gVGhlcmUgYXJlIHR3byByZXNldHMsIG9uZSBmb3IgTUFDIGFuZCBhbm90aGVyIGZvciBQSFks
IHNvbWUNCj4gPiBwbGF0Zm9ybXMNCj4gPiBtYXkgb25seSB1c2Ugb25lIG9mIHRoZW0uDQo+IA0K
PiBFdmVuIG1vcmUgcXVlc3Rpb25zLiBXaGF0IGRvZXMgaXQgbWVhbiB1c2U/IElzIGl0IHRoZXJl
IG9yIGlzIGl0IG5vdD8NCg0KSXQgd2lsbCBiZSB1c2VkIGJ5IGNhbGxpbmcgdGhlIHJlc2V0IGNv
bnRyb2xsZXIncyBBUElzIGluIHRoZSBQQ0llDQpjb250cm9sbGVyIGRyaXZlci4gSWRlYWxseSwg
aXQgc2hvdWxkIGJlIGRlLWFzc2VydGVkIGJlZm9yZSBQQ0llDQppbml0aWFsaXphdGlvbiBhbmQg
c2hvdWxkIGJlIGFzc2VydGVkIGlmIFBDSWUgcG93ZXJzIGRvd24gb3IgdGhlIGRyaXZlcg0KaXMg
cmVtb3ZlZC4NCg0KPiBQbGF0Zm9ybSBsaWtlIFNvQz8gQnV0IHRoaXMgaXMgb25lIHNwZWNpZmlj
IFNvQywgaXQgY2Fubm90IGJlIHVzZWQgb24NCj4gZGlmZmVyZW50IFNvQy4NCg0KWWVzLCBpdCBz
aG91bGQgYmUgU29DLCBlYWNoIFNvQyBoYXZlIGl0cyBvd24gcmVzZXRzLCBhbmQgdGhlIG51bWJl
ciBvZg0KcmVzZXRzIGZvciBlYWNoIFNvQyBpcyBkZWZpbmVkIGJ5IHRoZSBoYXJkd2FyZSBkZXNp
Z24sIG1vc3QgU29DcyBzaG91bGQNCmhhdmUgb25lIHJlc2V0IGZvciBNQUMgYW5kIG9uZSByZXNl
dCBmb3IgUEhZLg0KDQo+IA0KPiA+IA0KPiA+IFdvdWxkIHlvdSBwcmVmZXIgdG8gc2V0IHRoZSBu
dW1iZXIgb2YgcmVzZXRzIHRvIGEgZml4ZWQgdmFsdWUgZm9yDQo+ID4gc3BlY2lmaWMgcGxhdGZv
cm1zPw0KPiANCj4gRXZlcnl0aGluZyBzaG91bGQgYmUgY29uc3RyYWluZWQgdG8gbWF0Y2ggaGFy
ZHdhcmUuDQoNCkZvciBNVDgxOTYsIHRoZXJlIGFyZSAyIHJlc2V0cy4gU2hvdWxkIEkgdXNlIGEg
Zml4ZWQgaXRlbSBpbiB0aGlzIGNhc2U/DQoNClRoYW5rcy4NCg0KPiANCj4gDQo+IEJlc3QgcmVn
YXJkcywNCj4gS3J6eXN6dG9mDQo+IA0K

