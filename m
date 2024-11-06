Return-Path: <linux-pci+bounces-16090-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DC49BDB18
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 02:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 688941C20A1D
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 01:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BF225745;
	Wed,  6 Nov 2024 01:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="chNsUyTX";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="P7Pc7Pu8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627A3185B56
	for <linux-pci@vger.kernel.org>; Wed,  6 Nov 2024 01:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730855933; cv=fail; b=czTaN5n5AIauuIDuqVGQiBfkZl077TU7VIYSWHNAuyD0pIzKyMGLdQuwam5WCxSDF2D0xklnuCRO3hZQ17dxnbh230RYbtSNzfZMAyvahNmID4gsV68ojIyUfZZHuEuBaOuUpOcsgTy7woBbJvTfXTmpbNlKn9/LEJwdq2iErfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730855933; c=relaxed/simple;
	bh=g4j6SMj0hjTbyjeHAT2wNKlkXKntLsI/SPXpom0Wk+c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FWUayrg+i2ptdbo6ThHthdnGxL0phLl2rF5V3BtlgS+UhHGEslIzCPGa/R2Z/4vJ4lEqHpi4dh4leyWp2o/sEK5MGx/4UF/P+HhRbzFy7JjL/Zpn3VBDzp6krphnxYvOrTnIgsYlPOmoXujbLxU1q/yF4nci8Q63Jx/PPo7xTos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=chNsUyTX; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=P7Pc7Pu8; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 106beeee9bdd11efb88477ffae1fc7a5-20241106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=g4j6SMj0hjTbyjeHAT2wNKlkXKntLsI/SPXpom0Wk+c=;
	b=chNsUyTXAb/IRDNX3JIBiJ+n2XtVjOKt0HD0G0gejh5+qja+ktGNF5JTZzhXU1gcdas4kZk6y2R4XxfBoJwRJA0Dslhtq0He0j6QeDqp5Q6JsLKU4JUYZv6hUirbcYkqXjPRLE/kfv+/DFgKObAdniJIveFyGp4kTQGrXn0Fv0M=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:969846f2-61d9-43fe-9562-41fe70cde881,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:b0fcdc3,CLOUDID:ef5bc048-ca13-40ea-8070-fa012edab362,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 106beeee9bdd11efb88477ffae1fc7a5-20241106
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <jianjun.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 539908241; Wed, 06 Nov 2024 09:18:43 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 5 Nov 2024 17:18:42 -0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 6 Nov 2024 09:18:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a0jRga8a1CifsH7kG1vPUpmqCVOE8rGz89ioK8CqrKUTy7cRajRuAuF7JNYGfA9joqVcN4o8a7tGhrplZwb2BjQCVTDQjWOSray2AAsYXURg25I7SLpTX8zVGlk76rRWdXG2UVfVDiC55Z490rtw41p589rgsqN3TyuIaes88fWbL5Z3dao7K3HY1u5kAqil364Q7ADeRR3FuRpVtL/9vqT1t5sNZZwoQenH9qtvNgprYz4WTfIGesZF/FEy4PTp6GtB5LHERR1bk95p4NVEfjQ7tb9bpMhk5imyoT6LleMJCefiiEsko49joJ2bY9oEprJF2WhXgHFTFdnTtPY/zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g4j6SMj0hjTbyjeHAT2wNKlkXKntLsI/SPXpom0Wk+c=;
 b=fvxAUQCBhPn/EgtxBkMna9d+P6IpSbYR1mFr/WWwxkprDJ0H/eAcE0XAEpA4Qhi8UG3QM22gxSLogXOlAa0GhiWyjNk8ohmsM2UBOn+uNDgayQRFHY2GXshdoXpxPUExikAOd5KuWGLb8SkbPXbdN+3Sb0S+JoYCVD4qeOCerkL1l8Uz5W1Au7sKHdIYGxx6eWIsujQw7g/+Bi4oGGCnQ2psOMzE+J9aWa95JnNy3Vt+IRHItecukHfqK6oWbTgq7d7+cxp2yfUN1na+qi5KsBpb83jVNKsA2XIDietyPQRrtPNOmRXqPYu/ufa+xFh8pJAkWV/B0rxlrqNIU6sv2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4j6SMj0hjTbyjeHAT2wNKlkXKntLsI/SPXpom0Wk+c=;
 b=P7Pc7Pu82Ihdme5kIHiiiXI/pbTV2GwK7J+93f1Uo4HeBkAeVYNi1dWd9nCJVg6b2fuMWM8rdBXQnBWtKLIz8mJ2qmA9qzFHgERIU5U2zpUXToQDnOfImZvYQO+0TaTCMB5SYIBwv5JAW/RxUt+qqvgv6Wm2Gd2SRFAV61V0pyE=
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com (2603:1096:301:17::5)
 by TYSPR03MB8543.apcprd03.prod.outlook.com (2603:1096:405:61::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Wed, 6 Nov
 2024 01:18:38 +0000
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::1c6e:6591:5151:27e6]) by PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::1c6e:6591:5151:27e6%4]) with mapi id 15.20.8114.031; Wed, 6 Nov 2024
 01:18:36 +0000
From: =?utf-8?B?Smlhbmp1biBXYW5nICjnjovlu7rlhpsp?= <Jianjun.Wang@mediatek.com>
To: "lorenzo@kernel.org" <lorenzo@kernel.org>, "helgaas@kernel.org"
	<helgaas@kernel.org>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"ansuelsmth@gmail.com" <ansuelsmth@gmail.com>,
	=?utf-8?B?SHVpIE1hICjpqazmhacp?= <Hui.Ma@airoha.com>, "robh@kernel.org"
	<robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, Ryder Lee
	<Ryder.Lee@mediatek.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, upstream <upstream@airoha.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2] PCI: mediatek-gen3: Avoid PCIe resetting via PCIE_RSTB
 for Airoha EN7581 SoC
Thread-Topic: [PATCH v2] PCI: mediatek-gen3: Avoid PCIe resetting via
 PCIE_RSTB for Airoha EN7581 SoC
Thread-Index: AQHbLwUKxn3W3mufJ0mUHMDfaZ/NObKo8KgAgAAOPQCAAC3OAIAASNyA
Date: Wed, 6 Nov 2024 01:18:36 +0000
Message-ID: <a8e3aeac950ba6d0da0a33fc95e8f8c75ee0850e.camel@mediatek.com>
References: <20241105205748.GA1484220@bhelgaas>
In-Reply-To: <20241105205748.GA1484220@bhelgaas>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5365:EE_|TYSPR03MB8543:EE_
x-ms-office365-filtering-correlation-id: 5f1c4576-688a-4b69-8c23-08dcfe00f072
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?clFzM05PZmJGOU5TeHdiL2xnUVNsMXErRXl4Q2lHNGxUdmRGRkRydEhzY0Fp?=
 =?utf-8?B?dGVKSjFDbmZxNlM1S3orazhNNXNjclhpd3hBUEhtZUlYa2RaRUxtOXAycFdL?=
 =?utf-8?B?U3AwR0c2OUZJeHB5WHVIRkhENlZJVmVKaVB4cUFkNk9nc1FSaWxPL3FOa3Aw?=
 =?utf-8?B?VU1JZVpGOTN2SEdOelJab1JSSXo5SGZPNU5xMXFpSUlTTjdVSWRsTzRlWlVq?=
 =?utf-8?B?cldlMHBKQWRJTHUxUS9haXVuOStHZFRGSnhBVzMxZ0d6TThxN1Q4eEw1Z3Rv?=
 =?utf-8?B?TEVwckxZT2ZDM2hPZFFrV0FkN2hBblBud1E1T3R0M3BFbmlsZHFENXEvWWE5?=
 =?utf-8?B?bkhXOFo5bEFFVnBkdE1DY1BjdzdJTTJqTlZrazdscHI4S3VOOHVNcUh5UzJl?=
 =?utf-8?B?Zjc4blc4SXZORnpRZGtlbW4yYWwvckRYb3ZJSFJqSlV2dStzTkRGOXR3K1ZN?=
 =?utf-8?B?bEdIMFpIRTVtVHFSSUZCU1pxaVJxU08xZkhNd3NlQzlxLzFZQnFPbWozWUlB?=
 =?utf-8?B?UDIxWmJxWkZsVUt2Z0FZdDB3cWNqU09zQ0JKMTVzakV4ekduVHNBTW5IVWRG?=
 =?utf-8?B?cjdPck1iN1JmQlFpTXZWbWRPMTNQMDdhZVg5WHN2WlZZeVJySlcrdHdWQjlB?=
 =?utf-8?B?M3FwRldPMXZpRzRiSHBpSXJXdG9uWjN2bDF6ZGhxTkhLNVh5QlFjRXVkd2ZR?=
 =?utf-8?B?Q085Ni9xazhHYXRiTjB6VlkyL1hmTTZZV3JCemhkWG5POEZlNnlzSVM5OW1t?=
 =?utf-8?B?MFRmVHdoSGxMUHN6VGR0UGlrbmVYNFQ5QXI1QjZDZ2N4UjdSNW9xMHdMQjUy?=
 =?utf-8?B?VnpLNENtMVpDcFAzMTd4dTVhMFpnSnVwTG45ZDQ5M09MZHhBK0I0Wm9hWURC?=
 =?utf-8?B?R1A3aGVQTC9VL3NnR0VkZDdGRzZFamg0eXFaRWN4MkV2alYwTENUZmlFY01R?=
 =?utf-8?B?ck9xeHhmaTFNNW1xZDM2TjYrczhQc291TC84QmRzZWNZQUp5a2NBc2FoRjNu?=
 =?utf-8?B?MTF3bU9hbU53VzZlUE82V0NZUWlueU5QMTFxS1RXNUQ2T0UzcDhTZFlUekhj?=
 =?utf-8?B?TmF6TCtqUDlySWxoZ3cvYUdkR2hZbmlJM0tyUTZpYkx5TXFxUVJvREJ6bHlr?=
 =?utf-8?B?YUVwZnF1UTFxaGcyVEhrUWJ2by9RTytZSUtTejlwbDlCQWxuT2VjYWwrSnV3?=
 =?utf-8?B?QWRFQUR5ZytobUs4NnlpUzBmNkZFR0xHMnladFJHMnpLTGdEcEJNVmpnWVJN?=
 =?utf-8?B?ZU12ZGQ4Z2htTWpob1hsZUJFUzI1WXZQTXRxZHh2ang4V2QvN20rRWRsR2lO?=
 =?utf-8?B?MklTNEhGeGJ2L2VSaWlGejJYRStJMUVuL05Sd1lTQ2JhSFk2N01tbmVvaW9N?=
 =?utf-8?B?V0dRVnhFZ285c3ZyUnZIalRKUUpmNEVFSzNGNkFpalVNeDZnb2FxNzhiUFdk?=
 =?utf-8?B?M29NZngreXg4Sm9qRWpQQUZpNFZsSkd6dzFLNHR2Zkxta3dTbmp2NkZUSUVO?=
 =?utf-8?B?aTBFTlVHUlBrTWFwcm5oWmljUW9BaHBpVXNVQVN2bVZVdTZPYlVMQlhzb016?=
 =?utf-8?B?UkE5RlZ4dHNqYUFGWWdHNjZrTUNiUkVZUVIrcnhCcm9oUHM1S1BOcEJyUDRh?=
 =?utf-8?B?MG9IZ0FDbm5xV2ZtRFllWEtYeE4vOVhjRTluVFM1Wmdnc2poRWtrb1orM2hJ?=
 =?utf-8?B?RmJYRkloajhpaFIzdzlYUzUyRGlhS241Ui8zQS93aFpJdm9ndXgrZlp1Z0Rh?=
 =?utf-8?B?ak1KRkh2clVwbzVCU2NTTHlBSTZDbHRnKzM4VllOTFJJUm9iTGFNZnpiUSsz?=
 =?utf-8?B?QXZwN2RHby95UmJpVVRqZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5365.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0ltVVBjdllrSE12b044aHZDSCtUYWkwU3lubStpZE1UcURRZHptRkxaamRi?=
 =?utf-8?B?ZTJzNGdEU2loM2RCdDNhM1A1RTlEQzJ3Y0pLRUc0Wmg2TCtzTnJ0enNrNmth?=
 =?utf-8?B?cUVJY0NmMER3bHVZMUlqWlkwZjQvMEY5WjYrZmROYkYvaktlZGFCN09yelVk?=
 =?utf-8?B?MWozUDFHbUN2bG9vMFBHVVBDV3VQYlRJdmVHOC8yUnYxTEk3bWMrNWZhZ3hZ?=
 =?utf-8?B?anp0eTlmWTJFeXFudythUDRKSWtQVTZuZHBYZVhtVkNUc1FuMy9PQUZiNTFT?=
 =?utf-8?B?QkhrSUU3MDhpYWw3UWhKeGdsOGxqU0V1Q0pBNnloWGxnTFlvNThrQitwaGV5?=
 =?utf-8?B?d3J4TXFZVCtFRlB1UTFGcVFXVEVtV2M4MFpPMlNIT1dXdGg3aVVRVjlsZkh1?=
 =?utf-8?B?OUU3RzU0SzcwVndNVHl4d1VlemhDMDl0dW5mbWl5NG9XL0xNTDBzYTJFUGdO?=
 =?utf-8?B?TGN2QjdWYkVORGdENGVpUmxyUW1abmxqUFBlSithY3Arc0FvVFMrcm4wWGJL?=
 =?utf-8?B?ZEt5b1VyY09pYm4wQWlINEZuT0NZeFFSZC9LOHhrOHZTNVQrZlVCaVpWaFpo?=
 =?utf-8?B?ZEQ1QWdudGw3Y2s0RFNkNkhwTGo1Vkw0SnBPZzRYOStSNHFZMXIxZ0NUYmpw?=
 =?utf-8?B?OVJJQURIT0lFV2tnZWZuM0xybFRXc0RKN0hpdFNJbXBaUFJudVRHQ0JtRnUw?=
 =?utf-8?B?NG1icVQ5TEVraDkvTUZZaEw3eDdyQ2p5RmVjN2lZTTE2b25EMUNxY25lOFVB?=
 =?utf-8?B?Z1hVRzdyL1Y3aW5ucndOaGFxK0kydWVxdXdkYkFKTFJnS2UyNThIMThnTEdF?=
 =?utf-8?B?RjhIZ2tQVmk2ZzF1Rmwwckk3T3pUY2xVMFRuVUFIVXA0bWYrSkN2YlRrbVlJ?=
 =?utf-8?B?ZVRzL044c3Jnb2FQN3JzYXR6RUluOFlrbnlnU2VRK0IrdUREUGFUczBUcjRQ?=
 =?utf-8?B?RUNmUTkzdTEyVXppV3VZMVNNWHNaaFFXV3l5YXJ0K3dwNzV4S0p0bjF2WlFU?=
 =?utf-8?B?Z0xNMlgrZ3NvLzQ2NDUvQlJMbUVJV1dXN3JCK2tBVEZITUFOdVduZnBBenhn?=
 =?utf-8?B?OWo5WGZWTGxwNFZuenRzZW9tTy95MDZOc3B1SEFvME1QRlRJTnpyRUNXKzZ3?=
 =?utf-8?B?ZjRia3RrYWZRd2E3Sm5ab0p4QUFyWWdMTmVSUjhTUllvOWhLY1JwOU8ycGxV?=
 =?utf-8?B?ZStOVWhYeGR1Q1JtaWt0MTNHOHRNYW81QzFKQkZlTlFJMnZ1TEZpb00xREhJ?=
 =?utf-8?B?Mk55dGUxeHV3TGR1ZjFTRzhhMmhGajc4cDQ5RG1LUCtVVTd5NXhXWHZ6NmhC?=
 =?utf-8?B?cFJyc2V3K1FCTS9pK2ZzSTNNNmsxdjB6d1BpYTQ4YlNsaEVCYjZIckVmYWp4?=
 =?utf-8?B?UHdUUWJOZFJ4VUVwUUN4dVQyakcvcndJcjJ5RXFhK05ONGFUdFEvZHdvVUFF?=
 =?utf-8?B?a3hNaTFLTWZEYzJJL0F1NjgxdzVJajBCUHl0aXlOZ2V2c1UvRU05WE1TVzdW?=
 =?utf-8?B?Yy81eUZ6a3c4RzUwU2lEYXhtdTlEU2xRajd3Ymd4VVFUNzd6RzNRU3FmOCtS?=
 =?utf-8?B?UDRxZGhGZjdXa1l0SGJQUG9KQVc0dE15VXBQUUNNZmZyM2hBbEpUSEtNSnNL?=
 =?utf-8?B?K1pRUHVQalBRUmdFLzZxekVzbXVlM0Ixdlp2N1FHWWl5czZhWGxMSFpZQXBY?=
 =?utf-8?B?NFF6WkNsOUlFeEc5NWM0UlFXdTVXbWtXUElCS3JJOFBBNG5xb1d1K2dxSHM3?=
 =?utf-8?B?SUJPNmhuUWo4Q0VjSlpzUmxtT25hT1RpODhRRUs1QTRLcFVSTGZNc2RwZG1B?=
 =?utf-8?B?aFdQZXJtWnRqVkxOY0NMWlZ2V1ZJZFJRb2ZXOGlpdjRHN2UwVE9OZWVxeHZu?=
 =?utf-8?B?MDVvWndBM3VBRkQwMXRkdVA0YmNNTFBFa094cmdnLy81U1V4WEdMVE5iUFNy?=
 =?utf-8?B?SnJmRzdZbjJ6cGdnMlRXemN1MjhRUHQrNzNidUw1VVFNWnpRMDViTGh2UWtY?=
 =?utf-8?B?bGVlckk1aUt2VUpNTnZGczhyc2RTL0FheTlBc3RrQURMTzRqZWRGekRLSXkr?=
 =?utf-8?B?SE5BZSt5Uyt2aVUzT3pUaThIb3lxNGR5dFJ0QjJNNzNOcm9kR0JrUGdqdVBX?=
 =?utf-8?B?ZmpoOWgrbFlZU1NEOTBlOTlFVWI3MDdTejI4b3pQT0hyN1BKTlM0dEpBcFhZ?=
 =?utf-8?B?VHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2E13C26B10F41A49988A03BF1A06605E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5365.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f1c4576-688a-4b69-8c23-08dcfe00f072
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2024 01:18:36.6700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XjHXOxpjBAdEIqc4AXu2bfpBiAGh9JFSJg2tnEKGBLnW9LYeMGHAuKI+GzifBpydDAHXQgYI07hjdgdcPzHltEGutHbptW8I/MN+sODkXnQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8543

SGkgQmpvcm4sDQoNCk9uIFR1ZSwgMjAyNC0xMS0wNSBhdCAxNDo1NyAtMDYwMCwgQmpvcm4gSGVs
Z2FhcyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBPbiBUdWUsIE5vdiAwNSwgMjAyNCBhdCAwNzox
Mzo1MlBNICswMTAwLCBMb3JlbnpvIEJpYW5jb25pIHdyb3RlOg0KPiA+ID4gT24gTW9uLCBOb3Yg
MDQsIDIwMjQgYXQgMTE6MDA6MDVQTSArMDEwMCwgTG9yZW56byBCaWFuY29uaSB3cm90ZToNCj4g
PiA+ID4gQWlyb2hhIEVONzU4MSBoYXMgYSBodyBidWcgYXNzZXJ0aW5nL3JlbGVhc2luZyBQQ0lF
X1BFX1JTVEINCj4gPiA+ID4gc2lnbmFsDQo+ID4gPiA+IGNhdXNpbmcgb2NjYXNpb25hbCBQQ0ll
IGxpbmsgZG93biBpc3N1ZXMuIEluIG9yZGVyIHRvIG92ZXJjb21lDQo+ID4gPiA+IHRoZQ0KPiA+
ID4gPiBwcm9ibGVtLCBQQ0lFX1JTVEIgc2lnbmFscyBhcmUgbm90IGFzc2VydGVkL3JlbGVhc2Vk
IGR1cmluZw0KPiA+ID4gPiBkZXZpY2UgcHJvYmUgb3INCj4gPiA+ID4gc3VzcGVuZC9yZXN1bWUg
cGhhc2UgYW5kIHRoZSBQQ0llIGJsb2NrIGlzIHJlc2V0IHVzaW5nDQo+ID4gPiA+IFJFR19QQ0lf
Q09OVFJPTA0KPiA+ID4gPiAoMHg4OCkgYW5kIFJFR19SRVNFVF9DT05UUk9MICgweDgzNCkgcmVn
aXN0ZXJzIGF2YWlsYWJsZSB2aWENCj4gPiA+ID4gdGhlIGNsb2NrDQo+ID4gPiA+IG1vZHVsZS4N
Cj4gPiA+ID4gSW50cm9kdWNlIGZsYWdzIGZpZWxkIGluIHRoZSBtdGtfZ2VuM19wY2llX3BkYXRh
IHN0cnVjdCBpbg0KPiA+ID4gPiBvcmRlciB0bw0KPiA+ID4gPiBzcGVjaWZ5IHBlci1Tb0MgY2Fw
YWJpbGl0aWVzLg0KPiA+ID4gDQo+ID4gPiBXaGVyZSBkb2VzIHRoaXMgYWx0ZXJuYXRlIHdheSBv
ZiBkb2luZyByZXNldCAodXNpbmcNCj4gPiA+IFJFR19QQ0lfQ09OVFJPTA0KPiA+ID4gYW5kIFJF
R19SRVNFVF9DT05UUk9MKSBoYXBwZW4/ICBXaHkgaXNuJ3QgdGhlcmUgc29tZXRoaW5nIGluIHRo
aXMNCj4gPiA+IHBhdGNoIHRvIHVzZSB0aGF0IGFsdGVybmF0ZSBtZXRob2QgYXQgdGhlIHNhbWUg
cG9pbnRzIHdoZXJlDQo+ID4gPiBQQ0lFX1BFX1JTVEIgaXMgdXNlZD8NCj4gPiANCj4gPiBSRUdf
UkVTRVRfQ09OVFJPTCAoMHg4MzQpIGlzIGFscmVhZHkgYXNzZXJ0ZWQvcmVsZWFzZWQgaW4gdGhl
DQo+ID4gZm9sbG93aW5nIGZsb3c6DQo+ID4gDQo+ID4gbXRrX3BjaWVfZW43NTgxX3Bvd2VyX3Vw
KCkgLT4gcmVzZXRfY29udHJvbF9idWxrX2RlYXNzZXJ0KCkgLT4NCj4gPiBlbjc1MjNfcmVzZXRf
dXBkYXRlKCkNCj4gPiANCmh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL2dpdGh1
Yi5jb20vdG9ydmFsZHMvbGludXgvYmxvYi9tYXN0ZXIvZHJpdmVycy9jbGsvY2xrLWVuNzUyMy5j
Kkw0NzBfXztJdyEhQ1RSTktBOXdNZzBBUmJ3IW1CNTgtdy13Q0Jsd25nMmIwVV9kY1hpanJiMHk5
WjlUNVhiMHVOcU1lTkxjTlprTjRTa3lHSzhjWGZjVzBiU0U1Ulgzd0VmdllJVFozQ0ZoZ1RaXyQN
Cj4gPiANCj4gPiBSRUdfUENJX0NPTlRST0wgKDB4ODgpIGlzIGFscmVhZHkgYXNzZXJ0ZWQvcmVs
ZWFzZWQgaW4gdGhlDQo+ID4gZm9sbG93aW5nIGZsb3c6DQo+ID4gbXRrX3BjaWVfZW43NTgxX3Bv
d2VyX3VwKCkgLT4gY2xrX2J1bGtfZW5hYmxlKCkgLT4NCj4gPiBlbjc1ODFfcGNpX2VuYWJsZSgp
DQo+ID4gDQpodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9naXRodWIuY29tL3Rv
cnZhbGRzL2xpbnV4L2Jsb2IvbWFzdGVyL2RyaXZlcnMvY2xrL2Nsay1lbjc1MjMuYypMMzg1X187
SXchIUNUUk5LQTl3TWcwQVJidyFtQjU4LXctd0NCbHduZzJiMFVfZGNYaWpyYjB5OVo5VDVYYjB1
TnFNZU5MY05aa040U2t5R0s4Y1hmY1cwYlNFNVJYM3dFZnZZSVRaM0w4TGxybnckDQo+IA0KPiBT
byBJSVVDLCB5b3UncmUgc2F5aW5nIHRoYXQgb24gRU43NTgxLCB0aGUgUENJIGhpZXJhcmNoeSBp
cyByZXNldCBieQ0KPiB0aGUgc29jLT5wb3dlcl91cCgpIGNhbGxiYWNrLCBtdGtfcGNpZV9lbjc1
ODFfcG93ZXJfdXAoKSwgdmlhDQo+IFJFR19QQ0lfQ09OVFJPTCBhbmQgUkVHX1JFU0VUX0NPTlRS
T0wuDQo+IA0KPiBJIGFzc3VtZSB0aGUgaGllcmFyY2h5IGlzIGFsc28gcmVzZXQgYnkgdGhlIG5v
bi1FTjc1ODEgLnBvd2VyX3VwKCkNCj4gY2FsbGJhY2ssIG10a19wY2llX3Bvd2VyX3VwKCk/DQo+
IA0KPiBBbmQgcHJpb3IgdG8gdGhpcyBwYXRjaCwgd2UgcmVzZXQgdGhlIGhpZXJhcmNoeSAqYWdh
aW4qIGluDQo+IG10a19wY2llX3N0YXJ0dXBfcG9ydCgpIHZpYSBQQ0lFX1JTVF9DVFJMX1JFRywg
YnV0IHRoaXMgY2F1c2VzDQo+IG9jY2FzaW9uYWwgImxpbmsgZG93biIgaXNzdWVzIGJlY2F1c2Ug
b2YgYSBFTjc1ODEgaGFyZHdhcmUgZGVmZWN0Lg0KPiANCj4gU28gZm9yIEVONzU4MSwgdGhpcyBw
YXRjaCBza2lwcyB0aGUgUENJRV9SU1RfQ1RSTF9SRUcgcmVzZXQgaW4NCj4gbXRrX3BjaWVfc3Rh
cnR1cF9wb3J0KCkuDQo+IA0KPiAucG93ZXJfdXAoKSBhbmQgbXRrX3BjaWVfc3RhcnR1cF9wb3J0
KCkgYXJlIHVzZWQgYm90aCBhdCBwcm9iZSB0aW1lDQo+IGFuZCBpbiBtdGtfcGNpZV9yZXN1bWVf
bm9pcnEoKS4gIFNvIGFmdGVyIHRoaXMgcGF0Y2gsIEkgYXNzdW1lOg0KPiANCj4gICAtIEVONzU4
MSByZXNldHMgdGhlIGhpZXJhcmNoeSBvbmNlIGF0IHByb2JlIGFuZCByZXN1bWUgaW5zdGVhZCBv
Zg0KPiAgICAgdHdpY2UuDQo+IA0KPiAgIC0gTm9uLUVONzU4MSByZXNldHMgdGhlIGhpZXJhcmNo
eSB0d2ljZSBhdCBwcm9iZSBhbmQgcmVzdW1lLg0KPiANCj4gSSBhc3N1bWUgSSdtIG1pc3Npbmcg
c29tZXRoaW5nIChtYXliZSBtdGtfcGNpZV9wb3dlcl91cCgpIGRvZXNuJ3QNCj4gYWN0dWFsbHkg
cmVzZXQgdGhlIGhpZXJhcmNoeT8pIGJlY2F1c2UgSSBkb24ndCBzZWUgd2h5IHdlIHdvdWxkIHJl
c2V0DQo+IHRoZSBoaWVyYXJjaHkgdHdpY2UgZm9yIGVpdGhlciBjb250cm9sbGVyLg0KDQpOb24t
RU43NTgxIG9ubHkgcmVzZXQgb25jZSwgdGhlIG9yaWdpbmFsIGludGVudGlvbiBvZg0KbXRrX3Bj
aWVfcG93ZXJfdXAoKSBpcyB0byBwZXJmb3JtIHNvbWUgcG93ZXItdXAgdGhpbmdzOg0KMS4gUmVs
ZWFzZSBoYXJkd2FyZSByZXNldHModGhpcyBpcyBub3QgUEVSU1QjLCBidXQgdGhlIGhhcmR3YXJl
IElQJ3MNCnJlc2V0KS4NCjIuIEluaXRpYWxpemUgdGhlIFBIWSB0aHJvdWdoIFBIWSBBUElzLg0K
My4gUG93ZXIgb24gYW5kIGVuYWJsZSB0aGUgTUFDJ3MgY2xvY2tzLg0KDQpBZnRlciB0aGVzZSBz
dGVwcywgd2UgaW5pdGlhbGl6ZSB0aGUgUENJZSBpbnRlcmZhY2UgaW4NCm10a19wY2llX3N0YXJ0
dXBfcG9ydCgpIGFuZCB0b2dnbGUgUEVSU1QjIHRvIHJlc2V0IHRoZSBoaWVyYXJjaHkgYXMNCnJl
cXVpcmVkIGJ5IHRoZSBQQ0llIFNwZWMuIEF0IHRoaXMgcG9pbnQsIHRoZSBQQ0llIGxpbmsgc2hv
dWxkIGJlDQpyZWFkeS4NCg0KVGhhbmtzLg0KDQo+IA0KPiBCam9ybg0KPiANCg==

