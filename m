Return-Path: <linux-pci+bounces-9392-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F8291B56D
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jun 2024 05:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE23F282C7B
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jun 2024 03:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649091BF47;
	Fri, 28 Jun 2024 03:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="nGJ7PGOl";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="r/CUk1fv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C5517583;
	Fri, 28 Jun 2024 03:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719545146; cv=fail; b=jS4U6j1ICosOEPpCy0ZPGi7TP9zaq/1s5qIhYtpHwxWDQTxO87fOQP427rpHgTR/Bi/UUE5mL20Ty/QVs9ys9y3BQy04wZiKWzp2XsDfoTU/lc+YzuMSjbYZ5hy9OsamS4sLQlrfXKcC0YbULPK3cwHpwHtxBGJkg5vRn1w3o9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719545146; c=relaxed/simple;
	bh=0vH8PrR2cJkwR2d/Hf4icDd8bd51vEuWJrY3nwQNoQs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KFeLJpZiJnEPdN80CohHWUQz8ScCbhy8zCmJXRtX6KZRqAlhmOYiMJ8Q3TTDUADjl2ZRfNwaweF/WaYe8MugNCQ9au0tazcT10nvkKQ59WWiaesTAcwkOrJB2o5iytV69AnozWCJqe457qgaQpaxuKKnQ8MTG3L8oUmsLts6CRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=nGJ7PGOl; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=r/CUk1fv; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 141f405e34fe11ef99dc3f8fac2c3230-20240628
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=0vH8PrR2cJkwR2d/Hf4icDd8bd51vEuWJrY3nwQNoQs=;
	b=nGJ7PGOlfauCXxDbvATwpoQuH6171/0VRzScH9V0/v9yyAJs/dbuffIpu4qxL/N4XpMvsW1B95rhZqHXnWqwfA9PwjFdbN+uuWXAcmXwYlhbDB06TWhJuek6wPJaY1nSN+d1WE3K146S6DaaTLezlEKfXt4e0sCq6SbazU0IVwA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:b048bf12-2d24-458a-972e-cc2c72209dde,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:848fd6d0-436f-4604-ad9d-558fa44a3bbe,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 141f405e34fe11ef99dc3f8fac2c3230-20240628
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <jianjun.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 733398448; Fri, 28 Jun 2024 11:25:33 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 28 Jun 2024 11:25:31 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 28 Jun 2024 11:25:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JWjWfYBGdkeWcTJ9RSydZeuFQ8kK1SUgidATRHOFTdU3BduCynSykAq2bjll92S8bPXZlmg5yzmMmbHyIQV+TrNYp4C785ys1wW082HfRV+x9seOGR85BznqyGcdcl0qBjdE2xqEOH2iWgj8ibV75tl2LJMLu0PZm4TdF7P7O9S2oE7aJs1OcBZMLHcIjf86ueaE4ToKKVmGiHy3NH9DUvZCfftvH2XXjHgmSl5A0hF71b5OdvI04LW7B2hsiT0GP4dhLJqgPFlbZKSCCMED4q4cdITQbIaTgNZH6knhdNCiu7fW0nzaDHTXq1O9C/AIr5I7LaMHVveVJcAgvHTx9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0vH8PrR2cJkwR2d/Hf4icDd8bd51vEuWJrY3nwQNoQs=;
 b=TjcnaX9TuK2ypR+zc34tFTwjMODCa1sTUl9XOWvYCUDtWILSEwEAPsAlNIChwZfHJutBIIK46jCJmHYkU0G8ozv8rjmkMiY2zPRCwALolxTocS7V7m1B6Tq26J93Fin/iyIT5ruz7B67wpRFFVAqtkdASH4UEzRTBtlYunyumtPLpg/bU9FBf/KynUYDdPCMQMff9h29Q4zbGR07aVMWYH1ZdTYp3EtX70wDbV6FuXhXJPWj6opwNIqkG3ylMLucJWERL9l9Y823EVafQMlvwMgwt4KQ3TeSe8X61I7MMKQvKolLXFdGzHlKrRYmMkaO3xHaH7uL+wOYMD5JpnHj8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0vH8PrR2cJkwR2d/Hf4icDd8bd51vEuWJrY3nwQNoQs=;
 b=r/CUk1fvvkPTDLnshqBY6PhWFRZKpAPILhg+9YhpInb2wW11x0wr81ylLp7w8++kd1Zf4u+Xfmkx5QEZKzh3UZ20hSjUHPYPSndcWRJm+EZJ/HtczSeTY8xk6KDGji0mNmgeriaEzRsDKELk1Dv3KR6LB758FogUBIpA10/npzE=
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com (2603:1096:301:17::5)
 by SEZPR03MB7007.apcprd03.prod.outlook.com (2603:1096:101:ac::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Fri, 28 Jun
 2024 03:25:28 +0000
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::1c6e:6591:5151:27e6]) by PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::1c6e:6591:5151:27e6%6]) with mapi id 15.20.7698.025; Fri, 28 Jun 2024
 03:25:28 +0000
From: =?utf-8?B?Smlhbmp1biBXYW5nICjnjovlu7rlhpsp?= <Jianjun.Wang@mediatek.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"lorenzo@kernel.org" <lorenzo@kernel.org>
CC: "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "nbd@nbd.name"
	<nbd@nbd.name>, "dd@embedd.com" <dd@embedd.com>, "robh@kernel.org"
	<robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>, Ryder
 Lee <Ryder.Lee@mediatek.com>, "lorenzo.bianconi83@gmail.com"
	<lorenzo.bianconi83@gmail.com>, upstream <upstream@airoha.com>
Subject: Re: [PATCH v2 4/4] PCI: mediatek-gen3: Add Airoha EN7581 support
Thread-Topic: [PATCH v2 4/4] PCI: mediatek-gen3: Add Airoha EN7581 support
Thread-Index: AQHayGnlnJAu8XHuSUGmFkOvilkD/bHchM4A
Date: Fri, 28 Jun 2024 03:25:28 +0000
Message-ID: <d817ac92756c9c7d96d8f8cc8a8538bbcabd85f1.camel@mediatek.com>
References: <cover.1719475568.git.lorenzo@kernel.org>
	 <b2c794b21e15ec85a57de144006db9582ce0c949.1719475568.git.lorenzo@kernel.org>
In-Reply-To: <b2c794b21e15ec85a57de144006db9582ce0c949.1719475568.git.lorenzo@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5365:EE_|SEZPR03MB7007:EE_
x-ms-office365-filtering-correlation-id: 5f3b0014-ff3a-4f6c-4066-08dc9721f514
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NWZjOUdrTzY5b2ZMMkdrWTVoVXlpWGZjTkdvZUhwZFRXRHk2bXdtTnhiQzRB?=
 =?utf-8?B?aitDR1lUL0RpVzVlUXoxL01CcWYzOXVGMGM5VkJ0WC8yNUxFS09BaStRUFVY?=
 =?utf-8?B?S1ZlckNzRU5PNFlEenUydE94U1huZVAyOFFTeFJNL0E3RG1ZSU5hSU1MbkEy?=
 =?utf-8?B?c0JvQlZVQWZML3p0U0o0VlhEczBZNk1aNGhjTGIrdWlCdmRvRVBmTzQ0SStM?=
 =?utf-8?B?UVpPeG14ZVQ3K3d3ZzJPK3ZZa2hBcjBaSit3ZU80eTdrLy80NmlWNTFHZmdp?=
 =?utf-8?B?dWJHTnFYcDZHc1ppSElOeGZLSkNub0oxZzZsSUk3WjFwK0UvRVE0Qi96bU1q?=
 =?utf-8?B?Q0wvQ1JMRTh0SjgwN1ZZSjVPTGJ2andRL0NBV2UxYXdWOU1PdVd3OXdPVXZi?=
 =?utf-8?B?aVdMSWYvSWlVK24xeHJxTnJ2M2ZnRHdLUUVBSXFOV3hPbnlDR0NZbkc3dXpk?=
 =?utf-8?B?OXVKL2dVaGt3eldZMlJyMmN6bndYRHZZREVMTHJQeFM5SXJMR09nQVJueUpB?=
 =?utf-8?B?V0dGcmcvbzRUUXV1NXhYWkxqdmR2cEJsT3Z1Tlg1djg4Mll0SndSVFJqcDhY?=
 =?utf-8?B?dS9SMFNuWjluazhVVzZoMGhlWUt2SVIzWlRYaEZSbGNIVnVGY3lxcW1BREgv?=
 =?utf-8?B?Z1NPeFdBMXkxZm9FVnpBNTNENmlGaUgxNnpubkplOEo0UndrSXdNcjFlN1lj?=
 =?utf-8?B?elVidTI4R1pQWkFBek5MYkFNNUxYUTJ1N1RmTm0xNjJIdXMrVTU4TTA0czRr?=
 =?utf-8?B?WXZuY3hLNVRPeDdZYVdvdDNBaHJNSERaUlZzem5QbVpjWHNobWdlb29QN1Vu?=
 =?utf-8?B?d0dyMDJZQVZzMW84TGNlV2JYcXN2WXloTWxkVklFOEVJWDRFRTZIbkZLVkRZ?=
 =?utf-8?B?dGh2ZndJWVlXUUpaSmRQM2ZOVTZlSEg0cDdyWlFhSVFVZnBZU0tvZEFJeWxB?=
 =?utf-8?B?bDFuUmhCM2Zrd0hPbks5Z2RYRWNMSXFoQ1RxVW4rQnZTQU5HemVBYnEwd05J?=
 =?utf-8?B?WEd5VnlhaG5nTHFHYTN0bEhudHc5K2Z6TnFoK1BjSFZVMW9lM2Q5UTN0cUc3?=
 =?utf-8?B?eHdSTFBTWGZ2Y093cFRxZ2kwK1Z3U3g1VWRPTVdHVzB5NHJpa2hFcDNrS1Jp?=
 =?utf-8?B?QW85MXF3c2h5U012NW1RRXRVNGlWcUY2ZnFoZ2RLTTl2a0QwZFlXVk5QT2VD?=
 =?utf-8?B?eG1wenNaU1dqN1BRRTRVSFkvQlZHTmh0cnBFcGJzMTNEYUlud0hMOGJ0SnB4?=
 =?utf-8?B?N3hkUFVFWExoZzBHT0g0YUpmNWZmM2R6cUV5ZlMwNksxTSswY1JLc1Y4cTdE?=
 =?utf-8?B?R0Q2dXFuSnA3b2FXa1NLL05rOTA5ZmpkN0tiK1kvbzlNS0FvWlJ3Z2tJQ3lN?=
 =?utf-8?B?eG9qY2g3b1dpUUZUUVY5VnV6ek9IUkVpSUdDVG5mOXl4VTBwNFJTdW1WdzVu?=
 =?utf-8?B?bkxQb05wblhhR3FaOVJDaUtiQ0Job3NiSXBhRnNUMStsZXZWazUzdXBCTmhQ?=
 =?utf-8?B?OWVGOVNJTHF0RkJRaHJoSHZDN2lOZ2VlRTRlSS9HeUNqY1pRRU5majk2QVZu?=
 =?utf-8?B?WEVIa1VxYnJCaVZseDAxN2lUdWcrWFpIeVkwMlBsMjNTTWhJSFNRRG5JbzU1?=
 =?utf-8?B?bUNPS2laZFlGbFAxTy9OZkZORjVaU0YxNlJiOU5MV3dzOGZoK0xJZjhwUm92?=
 =?utf-8?B?eXE3dHRGdHhQa0ZKLzF0SGNjbnlXb053dGczWUpvY0NCTnVGRXRjUGFpM2p0?=
 =?utf-8?B?K0Q4aDdNTnNRMjYxVnYyUDhTYm9CbEFaRGJGcGR6ZG5OWVU2bUxZZzJUQkRR?=
 =?utf-8?B?SmlYVVE1T1NINURJdlVveER6K0VGczVGZ3JucVIvR3JTbkR0YW5UM0pybkh0?=
 =?utf-8?B?NDNpY3dHU0pkM0lrNVRKeUhLUFhxTzI2QlpPSUVDV09VeHc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5365.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eEUxT1VCSFpKY3U0M3JyL0JHaEs5Q3B4ZEFlY0pLNjhreDlVc0FnZFZIVzFO?=
 =?utf-8?B?UllnSVNkbGRNd0ZTS0RnTU9TbVpOK2Evdk5RcjltNDU2Qm5VZzV0c0hzZGhp?=
 =?utf-8?B?NnBRd2tyWXRZOFB5RFBXM2RDZU5LZndlcmEzSXBBU3RHSzZ0VnBBUmVxYWJK?=
 =?utf-8?B?eDBvbjRCd09aVE5ieXMyZnIvOG5RM2lwcURhaDZGRE5YOGJId0RRbUM5VStL?=
 =?utf-8?B?c0xHREVIc0c0WnE4QnZMem5oVFR2UU9sV1ErOVlrU05oSExUR3dhRjl6MElQ?=
 =?utf-8?B?ajB6ZTQ1UUpMNURMOEd1amV6TXVlbmhFeVRLZytGakQyQjJLcGs5QUphRHdy?=
 =?utf-8?B?bUhNWHFWYmVicDFjMlpaK010OG1oWC9raEd2WGNscEpFc2NiTXJwMEU1L3Bi?=
 =?utf-8?B?dEo3L0tjanR4WDQ0STVBQkpTdW84SFFpeG1vcWw2Z0gxclFRdEJWNUJVTWpD?=
 =?utf-8?B?MHRvTjREbm1GcTlSamFiOXhkYWREVFN6NTRaQzJjanlvQ0FrU1NXKzBTRkFu?=
 =?utf-8?B?VXZWd21rbHJ4RFpwZHRQeWU5czJLd01RSjZubnpzaXNlNlJ5UWNsbnhFaEdW?=
 =?utf-8?B?a1A1Nmd1VEEwMTgyS0lYOFcrSTAvRHJ3eDFaVzI4OGNuOGFlNkdybTkxYTNt?=
 =?utf-8?B?Qms5cHlUVU1HTjVRTUNlNHJLQVp6bVZLNnhQMkRYZmtkWExyVXFQU09CTC94?=
 =?utf-8?B?WXlablRjNlNYTXhYaS9xcWJ2UHdlR0RxajBYeHNiYk1YbkxIWVdscjgyamlp?=
 =?utf-8?B?N1ZrZ3QvMjNWajJaSmhRdGE5bmNPNGFGL0t5eitUeVRuTkozd2VYS0lhdlYy?=
 =?utf-8?B?NFBFamlqQ3BUNU1aNGlzeGZ4UWFQbnp0OE1mc3YwSnFLa1JRTDFWdEl6NW9H?=
 =?utf-8?B?Q2hTRFBuTUNlVUplREg5YnZzVWprdUtBdEQ2NkRoKzJyR0Y5YXhtRWtTWVhB?=
 =?utf-8?B?cVBUQ0c0VEExcXZvZHArQ0pyRUxCK3cyMkNQRWt1WkM3YWxKcXd6ay9Ibjhm?=
 =?utf-8?B?MzJxNFNIbzZuSHBiMmxYOGF1dXJJQ25nNDdFNWZFQkViVlNKRWhvaStBL2xN?=
 =?utf-8?B?bTRnRENEbHVLTzMxdzkzanh1UFJKZFZDcWUwT2dTc0lCTTVSMmRDYkZnMVJo?=
 =?utf-8?B?dldKVjBHcUVVeFNYOENPYVM0ckc1UWNUQWVleFBNV1ZFUzVNc3prRGU2eXY2?=
 =?utf-8?B?Vjc2c1BrM3NGeFEzYmd4ZVk0aWY2cDkwNzlNNzVvOFFGY2hoTmhReWRtOW9x?=
 =?utf-8?B?c2laV2FSL2FPUG5KUDFSTHF3Vk5BS2QwMG9pbTdDUElVeFl2RWJVaG92b05R?=
 =?utf-8?B?THI2WjlSVmxHeTR5U3ZNaGRGaWFkeUM4eUtoSTVjamwyZTZOQ0ZFNXc5Q3Az?=
 =?utf-8?B?TjFqMW1WUitzekk3ZjZabVNVVW9qdlkzWXQ2djlEVFVqSkUwYnJjNlZaanp1?=
 =?utf-8?B?NkNESllyWXJHOFNtUkNPc24reGFvOGJDVmFuT2JLT2FpZjZFd2RMWWU0SG42?=
 =?utf-8?B?ZnVlZGhNbnI2SkY5RlhDYkVsaFhNYVpWUWhIRndBK1ZyNFNaR25HdGFhYjY5?=
 =?utf-8?B?MGkwSnlPOVFsTGpvYURwdnBFLy9Wa1dueTF4dmlPaEpCbGdkejViSkpRUXE1?=
 =?utf-8?B?UWNtZ1FTUjJtb0EyWU5zVkwyNXFlNWE4MDcyMVVVVnkwakpid3BIalNscUNU?=
 =?utf-8?B?M3pOUjlML2djWXovRjIyNGxpMWtPdXpyeExEN2RzTXZ1RXJpdmJYeDBQVUI5?=
 =?utf-8?B?SmlPcW53ZlBOcm5BK1FYWjQydVhwMmI5RnFlQkw3UjRRbkN5UnhqNXlHaXR0?=
 =?utf-8?B?YWpIcWNzTlJKYkV2cFZ6eFFKRXFSdnlzUjlRODIvdVpHWUxBM3dOT1VIODRG?=
 =?utf-8?B?ckU1ZEhlaHlyd0NBWnZCV2ZudnBvYWUvSGJIR0k2VGtrYThyajFCcEhEenV1?=
 =?utf-8?B?MExLcTMvNGZEdmVLUmNhVlhmU09UclFkaUFHN3VMcHA1SkFFWjg0K2tXUDA5?=
 =?utf-8?B?cUo4by9xaCtvZlFQK3QrZVhyUnlJdnNEYnZaNUdqd1EvdFQ0RkxQYmlYdjJT?=
 =?utf-8?B?T3VJeFM5Uy92S084VnFpMjlCZlMxK2NnZnJuTDVBVXVoSHFQWEEvZ21QWnM3?=
 =?utf-8?B?c0hBY1hOTmJweTlCVGxKZzd1aWlTZFdXSkpKMjJZK2t6WVl0c2JpVmV3OXg5?=
 =?utf-8?B?b3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <10DE58484424134EBC02CB894AA521F5@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5365.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f3b0014-ff3a-4f6c-4066-08dc9721f514
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2024 03:25:28.1016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b67u80hApPREz8oPZtPQwy6ES9Brj5eFY3bmrqZTKQ2JnoUkgSihWXuV/L8eJOOZwdehOeXIdXgc7MLX9WpsftXFnBpqmHbI+a0eqOeegjE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7007
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--19.323300-8.000000
X-TMASE-MatchedRID: UWn79NfEZzbUL3YCMmnG4ia1MaKuob8PCJpCCsn6HCHBnyal/eRn3gzR
	CsGHURLuwpcJm2NYlPAF6GY0Fb6yCkttpN+KVVd9GVyS87Wb4lxKPIx+MJF9o99RlPzeVuQQ0JL
	YEuZmPHULXPAHvh6du1JaDhgFzZsBLZbtj42l31E00dkxYNMRt1o1rFkFFs1aDpCUEeEFm7AVjJ
	fIof7VRtX6wxB8S6f9kP6kp7D4HlfB1tTdqQfkDEf49ONH0RaSMZm0+sEE9mvczkKO5k4APkblr
	7fzqSHlCOXfNoaJObsQB3DHjpLpdR2J50HW8ezeS3OTftLNfg1QCOsAlaxN7ySb8v8wgv7yvCiw
	wGwIXrVP7yM7bfVWWJGTpe1iiCJq0u+wqOGzSV1WdFebWIc3VsRB0bsfrpPIFUFJm2B6H9E=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--19.323300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	77203379201462F4601950AACF486073988C26064BC893F84511D3D51EE773B92000:8

SGkgTG9yZW56bywNCg0KT24gVGh1LCAyMDI0LTA2LTI3IGF0IDEwOjEyICswMjAwLCBMb3Jlbnpv
IEJpYW5jb25pIHdyb3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90
IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZp
ZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gIEludHJvZHVjZSBzdXBwb3J0IGZvciBB
aXJvaGEgRU43NTgxIFBDSWUgY29udHJvbGxlciB0byBtZWRpYXRlay1nZW4zDQo+IFBDSWUgY29u
dHJvbGxlciBkcml2ZXIuDQo+IA0KPiBUZXN0ZWQtYnk6IFpoZW5ncGluZyBaaGFuZyA8emhlbmdw
aW5nLnpoYW5nQGFpcm9oYS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IExvcmVuem8gQmlhbmNvbmkg
PGxvcmVuem9Aa2VybmVsLm9yZz4NCj4gLS0tDQo+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL0tj
b25maWcgICAgICAgICAgICAgIHwgIDIgKy0NCj4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNp
ZS1tZWRpYXRlay1nZW4zLmMgfCA5Ng0KPiArKysrKysrKysrKysrKysrKysrKy0NCj4gIDIgZmls
ZXMgY2hhbmdlZCwgOTYgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL0tjb25maWcNCj4gYi9kcml2ZXJzL3BjaS9j
b250cm9sbGVyL0tjb25maWcNCj4gaW5kZXggZTUzNGMwMmVlMzRmLi4zYmQ2Yzk0MzAwMTAgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvS2NvbmZpZw0KPiArKysgYi9kcml2
ZXJzL3BjaS9jb250cm9sbGVyL0tjb25maWcNCj4gQEAgLTE5Niw3ICsxOTYsNyBAQCBjb25maWcg
UENJRV9NRURJQVRFSw0KPiAgDQo+ICBjb25maWcgUENJRV9NRURJQVRFS19HRU4zDQo+ICAJdHJp
c3RhdGUgIk1lZGlhVGVrIEdlbjMgUENJZSBjb250cm9sbGVyIg0KPiAtCWRlcGVuZHMgb24gQVJD
SF9NRURJQVRFSyB8fCBDT01QSUxFX1RFU1QNCj4gKwlkZXBlbmRzIG9uIEFSQ0hfQUlST0hBIHx8
IEFSQ0hfTUVESUFURUsgfHwgQ09NUElMRV9URVNUDQo+ICAJZGVwZW5kcyBvbiBQQ0lfTVNJDQo+
ICAJaGVscA0KPiAgCSAgQWRkcyBzdXBwb3J0IGZvciBQQ0llIEdlbjMgTUFDIGNvbnRyb2xsZXIg
Zm9yIE1lZGlhVGVrIFNvQ3MuDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVy
L3BjaWUtbWVkaWF0ZWstZ2VuMy5jDQo+IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1l
ZGlhdGVrLWdlbjMuYw0KPiBpbmRleCA0MzhhNTIyMmQ5ODYuLmFmNTY3YjQzNTVmYSAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1lZGlhdGVrLWdlbjMuYw0KPiAr
KysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbWVkaWF0ZWstZ2VuMy5jDQo+IEBAIC03
LDYgKzcsNyBAQA0KPiAgICovDQo+ICANCj4gICNpbmNsdWRlIDxsaW51eC9jbGsuaD4NCj4gKyNp
bmNsdWRlIDxsaW51eC9jbGstcHJvdmlkZXIuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9kZWxheS5o
Pg0KPiAgI2luY2x1ZGUgPGxpbnV4L2lvcG9sbC5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L2lycS5o
Pg0KPiBAQCAtMTUsNiArMTYsOCBAQA0KPiAgI2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5oPg0KPiAg
I2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L21zaS5oPg0KPiAr
I2luY2x1ZGUgPGxpbnV4L29mX2RldmljZS5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L29mX3BjaS5o
Pg0KPiAgI2luY2x1ZGUgPGxpbnV4L3BjaS5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L3BoeS9waHku
aD4NCj4gICNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4NCj4gQEAgLTI5LDYgKzMy
LDcgQEANCj4gICNkZWZpbmUgUENJX0NMQVNTKGNsYXNzKQkJKGNsYXNzIDw8IDgpDQo+ICAjZGVm
aW5lIFBDSUVfUkNfTU9ERQkJCUJJVCgwKQ0KPiAgDQo+ICsjZGVmaW5lIFBDSUVfRVFfUFJFU0VU
XzAxX1JFRgkJMHgxMDANClNob3VsZCBiZSBQQ0lFX0VRX1BSRVNFVF8wMV9SRUcNCg0KPiAgI2Rl
ZmluZSBQQ0lFX0NGR05VTV9SRUcJCQkweDE0MA0KPiAgI2RlZmluZSBQQ0lFX0NGR19ERVZGTihk
ZXZmbikJCSgoZGV2Zm4pICYgR0VOTUFTSyg3LA0KPiAwKSkNCj4gICNkZWZpbmUgUENJRV9DRkdf
QlVTKGJ1cykJCSgoKGJ1cykgPDwgOCkgJiBHRU5NQVNLKDE1LCA4KSkNCj4gQEAgLTY4LDYgKzcy
LDcgQEANCj4gICNkZWZpbmUgUENJRV9NU0lfU0VUX0VOQUJMRV9SRUcJCTB4MTkwDQo+ICAjZGVm
aW5lIFBDSUVfTVNJX1NFVF9FTkFCTEUJCUdFTk1BU0soUENJRV9NU0lfU0VUX05VTSAtIDEsDQo+
IDApDQo+ICANCj4gKyNkZWZpbmUgUENJRV9QSVBFNF9QSUU4X1JFRwkJMHgzMzgNCj4gICNkZWZp
bmUgUENJRV9NU0lfU0VUX0JBU0VfUkVHCQkweGMwMA0KPiAgI2RlZmluZSBQQ0lFX01TSV9TRVRf
T0ZGU0VUCQkweDEwDQo+ICAjZGVmaW5lIFBDSUVfTVNJX1NFVF9TVEFUVVNfT0ZGU0VUCTB4MDQN
Cj4gQEAgLTEwMCw3ICsxMDUsMTcgQEANCj4gICNkZWZpbmUgUENJRV9BVFJfVExQX1RZUEVfTUVN
CQlQQ0lFX0FUUl9UTFBfVFlQRSgwKQ0KPiAgI2RlZmluZSBQQ0lFX0FUUl9UTFBfVFlQRV9JTwkJ
UENJRV9BVFJfVExQX1RZUEUoMikNCj4gIA0KPiAtI2RlZmluZSBNQVhfTlVNX1BIWV9SRVNFVFMJ
CTENCj4gKy8qIEVONzU4MSAqLw0KPiArI2RlZmluZSBQQ0lFX1BFWFRQX0RJR19HTEI0NF9QMF9S
RUcJMHgxMDA0NA0KPiArI2RlZmluZSBQQ0lFX1BFWFRQX0RJR19MTl9SWDMwX1AwX1JFRwkweDE1
MDMwDQo+ICsjZGVmaW5lIFBDSUVfUEVYVFBfRElHX0xOX1JYMzBfUDFfUkVHCTB4MTUxMzANClRo
ZXNlIHJlZ2lzdGVycyBiZWxvbmcgdG8gUEhZLCBJIHRoaW5rIHRoZXkgc2hvdWxkIGJlIGFkZGVk
IGluIHRoZSBwaHkNCmRyaXZlciwgd2hpY2ggaXMgbG9jYXRlZCBhdCBkcml2ZXJzL3BoeS9tZWRp
YXRlay9waHktbXRrLXBjaWUuYy4NCg0KPiArDQo+ICsvKiBQQ0llLVBIWSBpbml0aWFsaXphdGlv
biBkZWxheSBpbiBtcyAqLw0KPiArI2RlZmluZSBQSFlfSU5JVF9USU1FX01TCQkzMA0KPiArLyog
UENJZSByZXNldCBsaW5lIGRlbGF5IGluIG1zICovDQo+ICsjZGVmaW5lIFBDSUVfUkVTRVRfVElN
RV9NUwkJMTAwDQo+ICsNCj4gKyNkZWZpbmUgTUFYX05VTV9QSFlfUkVTRVRTCQkzDQo+ICANCj4g
IHN0cnVjdCBtdGtfZ2VuM19wY2llOw0KPiAgDQo+IEBAIC04NDcsNiArODYyLDc0IEBAIHN0YXRp
YyBpbnQgbXRrX3BjaWVfcGFyc2VfcG9ydChzdHJ1Y3QNCj4gbXRrX2dlbjNfcGNpZSAqcGNpZSkN
Cj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gIA0KPiArc3RhdGljIGludCBtdGtfcGNpZV9lbjc1ODFf
cG93ZXJfdXAoc3RydWN0IG10a19nZW4zX3BjaWUgKnBjaWUpDQo+ICt7DQo+ICsJc3RydWN0IGRl
dmljZSAqZGV2ID0gcGNpZS0+ZGV2Ow0KPiArCWludCBlcnI7DQo+ICsNCj4gKwkvKiBXYWl0IGZv
ciBidWxrIGFzc2VydCBjb21wbGV0aW9uIGluIG10a19wY2llX3NldHVwICovDQo+ICsJbWRlbGF5
KFBDSUVfUkVTRVRfVElNRV9NUyk7DQo+ICsNCj4gKwkvKiBTZXR1cCBUeC1SeCBkZXRlY3QgdGlt
ZSAqLw0KPiArCXdyaXRlbF9yZWxheGVkKDB4MjMwMjAxMzMsIHBjaWUtPmJhc2UgKw0KPiBQQ0lF
X1BFWFRQX0RJR19HTEI0NF9QMF9SRUcpOw0KUGxlYXNlIGFsc28gYWRkIGRlZmluaXRpb25zIGZv
ciBlYWNoIGZpZWxkLCB0aGUgbGF5b3V0IGZvcg0KUENJRV9QRVhUUF9ESUdfR0xCNDRfUDBfUkVH
IGlzOg0KQml0Wzc6MF0gDQogIE5hbWU6IHJnX3h0cF9yeGRldF92Y21fb2ZmX3N0Yl90X3NlbA0K
ICBEZXNjcmlwdGlvbjogU3RhYmxlIFRpbWUgU2VsZWN0aW9uIG9mIHR4X2Nta3BfZW4gRGUtQXNz
ZXJ0IChEQyBDb21tb24NCk1vZGUgVHVybi1PZmYpIER1cmluZyBSWCBEZXRlY3Rpb24sIHVuaXQ6
IDQgdXMNCkJpdFsxNTo4XQ0KICBOYW1lOiByZ194dHBfcnhkZXRfZW5fc3RiX3Rfc2VsDQogIERl
c2NyaXB0aW9uOiBTdGFibGUgVGltZSBTZWxlY3Rpb24gb2YgdHhfcnhkZXRfZW4gQXNzZXJ0IER1
cmluZyBSWA0KRGV0ZWN0aW9uLCB1bml0OiAxIHVzDQpCaXRbMjM6MTZdDQogIE5hbWU6IHJnX3h0
cF9yeGRldF9maW5pc2hfc3RiX3Rfc2VsDQogIERlc2NyaXB0aW9uOiByeGRldCBmaW5pc2ggc3Rh
YmxlIHRpbWUgc2VsZWN0aW9uLCB1bml0OiAxIHR4MjUwbV9jaw0KQml0WzI3OjI0XQ0KICBOYW1l
OiByZ194dHBfdHhwZF90eF9kYXRhX2VuX2RseQ0KICBEZXNjcmlwdGlvbjogY2twZF90eF9kYXRh
X2VuX3N5bmMgZGVsYXkgc2VsZWN0aW9uLCB1bml0OiAxIHR4MjUwbV9jaw0KQml0WzI4OjI4XQ0K
ICBOYW1lOiByZ194dHBfdHhwZF9yeGRldF9kb25lX2NkdA0KICBEZXNjcmlwdGlvbjogcnhkZXRf
ZG9uZSBjZHQgc2VsZWN0aW9uLCAwOiAhcGlwZV90eF9kZXRlY3RfcnggIDE6DQpwaXBlX3BoeV9z
dGF0dXMNCkJpdFszMToyOV0NCiAgTmFtZTogcmdfeHRwX3J4ZGV0X2xhdGNoX3N0Yl90X3NlbA0K
ICBEZXNjcmlwdGlvbjogcnhkZXRfbGF0Y2ggc3RhdGUgc3RhYmxlIHRpbWUgc2VsZWN0aW9uLCB1
bml0OiAxDQp0eDI1MG1fY2sNCg0KPiArCS8qIFNldHVwIFJ4IEFFUSB0cmFpbmluZyB0aW1lICov
DQo+ICsJd3JpdGVsX3JlbGF4ZWQoMHg1MDUwMDAzMiwgcGNpZS0+YmFzZSArDQo+IFBDSUVfUEVY
VFBfRElHX0xOX1JYMzBfUDBfUkVHKTsNCj4gKwl3cml0ZWxfcmVsYXhlZCgweDUwNTAwMDMyLCBw
Y2llLT5iYXNlICsNCj4gUENJRV9QRVhUUF9ESUdfTE5fUlgzMF9QMV9SRUcpOw0KTGF5b3V0IGZv
ciBQRVhUUF9ESUdfTE5fUlgzMDoNCkJpdFs3OjBdIHJnX3h0cF9sbl9yeF9wZG93bl9sMXAyX2V4
aXRfd2FpdF9jbnQNCkJpdFs4XSByZ194dHBfbG5fcnhfcGRvd25fdDJybGJfZGlnX2VuDQpCaXRb
Mjg6MTZdIHJnX3h0cF9sbl9yeF9wZG93bl9lMF9hZXFlbl93YWl0X3VzDQoNCj4gKw0KPiArCWVy
ciA9IHBoeV9pbml0KHBjaWUtPnBoeSk7DQo+ICsJaWYgKGVycikgew0KPiArCQlkZXZfZXJyKGRl
diwgImZhaWxlZCB0byBpbml0aWFsaXplIFBIWVxuIik7DQo+ICsJCXJldHVybiBlcnI7DQo+ICsJ
fQ0KPiArCW1kZWxheShQSFlfSU5JVF9USU1FX01TKTsNCj4gKw0KPiArCWVyciA9IHBoeV9wb3dl
cl9vbihwY2llLT5waHkpOw0KPiArCWlmIChlcnIpIHsNCj4gKwkJZGV2X2VycihkZXYsICJmYWls
ZWQgdG8gcG93ZXIgb24gUEhZXG4iKTsNCj4gKwkJZ290byBlcnJfcGh5X29uOw0KPiArCX0NCj4g
Kw0KPiArCWVyciA9IHJlc2V0X2NvbnRyb2xfYnVsa19kZWFzc2VydChwY2llLT5zb2MtDQo+ID5w
aHlfcmVzZXRzLm51bV9yZXNldHMsIHBjaWUtPnBoeV9yZXNldHMpOw0KPiArCWlmIChlcnIpIHsN
Cj4gKwkJZGV2X2VycihkZXYsICJmYWlsZWQgdG8gZGVhc3NlcnQgUEhZc1xuIik7DQo+ICsJCWdv
dG8gZXJyX3BoeV9kZWFzc2VydDsNCj4gKwl9DQo+ICsJbWRlbGF5KFBDSUVfUkVTRVRfVElNRV9N
Uyk7DQo+ICsNCj4gKwlwbV9ydW50aW1lX2VuYWJsZShkZXYpOw0KPiArCXBtX3J1bnRpbWVfZ2V0
X3N5bmMoZGV2KTsNCj4gKw0KPiArCWVyciA9IGNsa19idWxrX3ByZXBhcmUocGNpZS0+bnVtX2Ns
a3MsIHBjaWUtPmNsa3MpOw0KPiArCWlmIChlcnIpIHsNCj4gKwkJZGV2X2VycihkZXYsICJmYWls
ZWQgdG8gcHJlcGFyZSBjbG9ja1xuIik7DQo+ICsJCWdvdG8gZXJyX2Nsa19wcmVwYXJlOw0KPiAr
CX0NCj4gKw0KPiArCXdyaXRlbF9yZWxheGVkKDB4NDE0NzQxNDcsIHBjaWUtPmJhc2UgKyBQQ0lF
X0VRX1BSRVNFVF8wMV9SRUYpOw0KQml0WzY6MF0gdmFsX2xuMF9kbg0KICBCaXQgWzM6MF06IERv
d25zdHJlYW0gcG9ydCB0cmFuc21pdHRlciBwcmVzZXQNCiAgQml0IFs2OjRdOiBEb3duc3RyZWFt
IHBvcnQgcmVjZWl2ZXIgcHJlc2V0IGhpbnQNCkJpdFsxNDo4XSB2YWxfbG4wX3VwDQogIEJpdCBb
MTE6OF06IFVwc3RyZWFtIHBvcnQgdHJhbnNtaXR0ZXIgcHJlc2V0DQogIEJpdCBbMTQ6MTJdOiBV
cHN0cmVhbSBwb3J0IHJlY2VpdmVyIHByZXNldCBoaW50DQpCaXRbMjI6MTZdIHZhbF9sbjFfZG4N
CiAgQml0IFsxOToxNl06IERvd25zdHJlYW0gcG9ydCB0cmFuc21pdHRlciBwcmVzZXQNCiAgQml0
IFsyMjoyMF06IERvd25zdHJlYW0gcG9ydCByZWNlaXZlciBwcmVzZXQgaGludA0KQkl0WzMwOjI0
XSB2YWxfbG4xX3VwDQogIEJpdCBbMjc6MjRdOiBVcHN0cmVhbSBwb3J0IHRyYW5zbWl0dGVyIHBy
ZXNldA0KICBCaXQgWzMwOjI4XTogVXBzdHJlYW0gcG9ydCByZWNlaXZlciBwcmVzZXQgaGludA0K
DQo+ICsJd3JpdGVsX3JlbGF4ZWQoMHgxMDE4MDIwZiwgcGNpZS0+YmFzZSArIFBDSUVfUElQRTRf
UElFOF9SRUcpOw0KQml0WzU6MF0ga19maW5ldHVuZV9tYXgNCkJpdFs3OjZdIGtfZmluZXR1bmVf
ZXJyDQpCaXRbMTg6OF0ga19wcmVzZXRfdG9fdXNlDQpCaXRbMTk6MTldIGtfcGh5cGFyYW1fcXVl
cnkNCkJpdFsyMDoyMF0ga19xdWVyeV90aW1lb3V0DQpCaXRbMzE6MjFdIGtfcHJlc2V0X3RvX3Vz
ZV8xNmcNCg0KVGhhbmtzLg0KDQo+ICsNCj4gKwllcnIgPSBjbGtfYnVsa19lbmFibGUocGNpZS0+
bnVtX2Nsa3MsIHBjaWUtPmNsa3MpOw0KPiArCWlmIChlcnIpIHsNCj4gKwkJZGV2X2VycihkZXYs
ICJmYWlsZWQgdG8gcHJlcGFyZSBjbG9ja1xuIik7DQo+ICsJCWdvdG8gZXJyX2Nsa19lbmFibGU7
DQo+ICsJfQ0KPiArDQo+ICsJcmV0dXJuIDA7DQo+ICsNCj4gK2Vycl9jbGtfZW5hYmxlOg0KPiAr
CWNsa19idWxrX3VucHJlcGFyZShwY2llLT5udW1fY2xrcywgcGNpZS0+Y2xrcyk7DQo+ICtlcnJf
Y2xrX3ByZXBhcmU6DQo+ICsJcG1fcnVudGltZV9wdXRfc3luYyhkZXYpOw0KPiArCXBtX3J1bnRp
bWVfZGlzYWJsZShkZXYpOw0KPiArCXJlc2V0X2NvbnRyb2xfYnVsa19hc3NlcnQocGNpZS0+c29j
LT5waHlfcmVzZXRzLm51bV9yZXNldHMsDQo+IHBjaWUtPnBoeV9yZXNldHMpOw0KPiArZXJyX3Bo
eV9kZWFzc2VydDoNCj4gKwlwaHlfcG93ZXJfb2ZmKHBjaWUtPnBoeSk7DQo+ICtlcnJfcGh5X29u
Og0KPiArCXBoeV9leGl0KHBjaWUtPnBoeSk7DQo+ICsNCj4gKwlyZXR1cm4gZXJyOw0KPiArfQ0K
PiArDQo+ICBzdGF0aWMgaW50IG10a19wY2llX3Bvd2VyX3VwKHN0cnVjdCBtdGtfZ2VuM19wY2ll
ICpwY2llKQ0KPiAgew0KPiAgCXN0cnVjdCBkZXZpY2UgKmRldiA9IHBjaWUtPmRldjsNCj4gQEAg
LTExMTMsOCArMTE5NiwxOSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19nZW4zX3BjaWVfcGRh
dGENCj4gbXRrX3BjaWVfc29jX210ODE5MiA9IHsNCj4gIAl9LA0KPiAgfTsNCj4gIA0KPiArc3Rh
dGljIGNvbnN0IHN0cnVjdCBtdGtfZ2VuM19wY2llX3BkYXRhIG10a19wY2llX3NvY19lbjc1ODEg
PSB7DQo+ICsJLnBvd2VyX3VwID0gbXRrX3BjaWVfZW43NTgxX3Bvd2VyX3VwLA0KPiArCS5waHlf
cmVzZXRzID0gew0KPiArCQkuaWRbMF0gPSAicGh5LWxhbmUwIiwNCj4gKwkJLmlkWzFdID0gInBo
eS1sYW5lMSIsDQo+ICsJCS5pZFsyXSA9ICJwaHktbGFuZTIiLA0KPiArCQkubnVtX3Jlc2V0cyA9
IDMsDQo+ICsJfSwNCj4gK307DQo+ICsNCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNl
X2lkIG10a19wY2llX29mX21hdGNoW10gPSB7DQo+ICAJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRl
ayxtdDgxOTItcGNpZSIsIC5kYXRhID0NCj4gJm10a19wY2llX3NvY19tdDgxOTIgfSwNCj4gKwl7
IC5jb21wYXRpYmxlID0gImFpcm9oYSxlbjc1ODEtcGNpZSIsIC5kYXRhID0NCj4gJm10a19wY2ll
X3NvY19lbjc1ODEgfSwNCj4gIAl7fSwNCj4gIH07DQo+ICBNT0RVTEVfREVWSUNFX1RBQkxFKG9m
LCBtdGtfcGNpZV9vZl9tYXRjaCk7DQo+IC0tIA0KPiAyLjQ1LjINCj4gDQo=

