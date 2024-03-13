Return-Path: <linux-pci+bounces-4769-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B0587A1EF
	for <lists+linux-pci@lfdr.de>; Wed, 13 Mar 2024 04:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 134EB284CD9
	for <lists+linux-pci@lfdr.de>; Wed, 13 Mar 2024 03:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB06BC144;
	Wed, 13 Mar 2024 03:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="celGwZHt";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="lqXfa/wB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22E5372;
	Wed, 13 Mar 2024 03:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710300798; cv=fail; b=WoI4hpGMQsy6OCmSmrS5SCivKK2PkvZ27HQSpBS7W0XWpL5xr9pErKSvzLqfc6u84ejIrog0j7AkmyyivA27jQg/ZBY9agY5ah1TPg3juWOfKJF1+AynjMokXfjjG524ERE528sYT2Lsd175yUC39w6shdH6EyyZKCGXaVjN7Hs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710300798; c=relaxed/simple;
	bh=p7aK8/80K/Zx77+blpTNEr3pKVanY+n5TdRJpi5Lo8U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UZIByBx4pcotmb+G16qmIIUtlP0YsuCi3EYMrcsLFKjqZ43AjVEIQWt+ZdWQEiJLQldxpmkVjO93NcWu1aGhYaH0y00ch5cQbpSy26gOBa6R3DieCocwRYmUGwGZe+TX0g1Tj1/FM453YKPF3W5CbwyH4BimOeYjhjsjz07Ylpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=celGwZHt; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=lqXfa/wB; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 6732bbeee0ea11eeb8927bc1f75efef4-20240313
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=p7aK8/80K/Zx77+blpTNEr3pKVanY+n5TdRJpi5Lo8U=;
	b=celGwZHtkRCorGXXAmxcXnMdTaHF2RgKYcjAnCJKhubel2zSX1uvM5BwJhCZY94OKzmr5EKrMvEh25NmDIHK0MWxI1Ha3IPwlH2audWVxq06ImsGspa3Hy67bbdFBvCmKEM56VzmHvWo4TCB5GsBoX2kt9A1zoSsNm/adq7bl+s=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:ff1741f3-7369-4214-bf8b-f52fd9d87420,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:724a6f81-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 6732bbeee0ea11eeb8927bc1f75efef4-20240313
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <jianjun.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2113460127; Wed, 13 Mar 2024 11:33:05 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 13 Mar 2024 11:33:05 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 13 Mar 2024 11:33:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S2ioXd/TzXVcnpolkUpUdwGaUKKWuto5RFtBeErcXZlaBz8Z2Zm/42PG345VB0Zk9hX2eEG6o2/0NiyG79+Rs3QFdgKItjGR9lwZpzyxBJdsqQFpENqHZQgaX1NmBiR2GMEzru3YEBUEO/K7EknpmH9D+oKwXDqTRQIj87mPgErpQQLmYY9AmlkEi8Mm2EnEQD2qPQwuk1ibw4HyFA3MTdUjiB0xtsTDnRWkmjzBn+EzppxSgjgQ6SUaC8MYiuFoH9nzj46G+MoX0V+mK6luL/5xxtIzgFwFjBJSYXHkiETrstYiLXkvjfGhYOiE42DHZP52sp9an/e3PoLVZKdxOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p7aK8/80K/Zx77+blpTNEr3pKVanY+n5TdRJpi5Lo8U=;
 b=htJCp214BcS1ucA1EE58Gfpp/gwPN07bnrq/LpX3XniPBBNPwgVXOHAQGOdXHBeZ9I1ieOts/Go6D/ID0BaD1oVFW4P+eb7RJ8ikvkwSEfNTut9dlY6Uc+1znFnAQ5qsN7QIek99xRE84JAbwsP650KHf58a/FcpWhupCg/6J6a2wnaXK7B26S3vEJ0IWKSJ8UkhqM7+OuqP9Hn8BB30U9ggVy1ZdHCHZt9agPzKUl/5fbD2GYc6UG1/PFAexHAMxJP1qr2C3BA17r9twRXB2UF45+HM8gnHjlCeBp13r07zuNuofWQQOe9Jeeu68rUQnr1BPkLxQECv/x2+UKTNgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7aK8/80K/Zx77+blpTNEr3pKVanY+n5TdRJpi5Lo8U=;
 b=lqXfa/wBD/EWQJ1mkh8gfpkp94u/3xlLTEEvp+9y7eJ47KHCgHabrcskv2Z6DrnbGcIBgfVgfI798/smD16fVd2S/acuqHK4sFQDSqD0Eh6Eh4ZL/LXwjIIi+WG/jNs6c9xAgiwT9dNYqZwjlwQBY9f9wKmwpX3mZIrlDxcwuDQ=
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com (2603:1096:301:17::5)
 by JH0PR03MB9034.apcprd03.prod.outlook.com (2603:1096:990:7d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.34; Wed, 13 Mar
 2024 03:33:01 +0000
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::22dd:6695:c2ad:c4bf]) by PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::22dd:6695:c2ad:c4bf%7]) with mapi id 15.20.7362.035; Wed, 13 Mar 2024
 03:33:01 +0000
From: =?utf-8?B?Smlhbmp1biBXYW5nICjnjovlu7rlhpsp?= <Jianjun.Wang@mediatek.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"wenst@chromium.org" <wenst@chromium.org>, "kernel@collabora.com"
	<kernel@collabora.com>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, Ryder Lee
	<Ryder.Lee@mediatek.com>, "nfraprado@collabora.com" <nfraprado@collabora.com>
Subject: Re: [PATCH v2] PCI: mediatek-gen3: Assert MAC reset only if PHY reset
 also present
Thread-Topic: [PATCH v2] PCI: mediatek-gen3: Assert MAC reset only if PHY
 reset also present
Thread-Index: AQHaavEyOFiHWdSs9EW2P5MBW1O/vrEiMBwAgAhAmACAAzPPAIAAN2IAgAc8hAA=
Date: Wed, 13 Mar 2024 03:33:01 +0000
Message-ID: <e6d657d8a08bce730e1ececee948bf4f283cc2f2.camel@mediatek.com>
References: <20240229092449.580971-1-angelogioacchino.delregno@collabora.com>
	 <30824df32636dec25b9a5972b1ee8de76b295feb.camel@mediatek.com>
	 <c55f2c6e-1de8-4248-a52a-d6c9e49b565a@collabora.com>
	 <8a5a695ccbc4401954f7df5a9690af726fc59173.camel@mediatek.com>
	 <fb9d4791-73e2-491a-8117-e8e5f811fe7a@collabora.com>
In-Reply-To: <fb9d4791-73e2-491a-8117-e8e5f811fe7a@collabora.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5365:EE_|JH0PR03MB9034:EE_
x-ms-office365-filtering-correlation-id: d53f062d-9c1e-4bb9-9a36-08dc430e4932
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 01V/MNbNCXBtnwKwNDbaig5VdUprfcoNdNqFS9e7zZ1+0+0lgK+LDJ6TYXYoKIOW2PqfOF8jmlOM0axkVH9Ujsjzc9yGvdeU1mVVolbx6tdgsA1Cpc1LaEXrj3HnW7boMXXgi0RnFg7AnbZhz96b5url1LIlnuRl9MML8BlHO3bz+BHi4HB9LaPzfh0T3ciT55Qkx5KG9ntmY4ghgxvkOP3L0tMB7xBKLWTDiArzWDcXHaDM88nQMLxaL7vtxzdwBtrc744pPizDqoEtPlfx0R+vfLUT5luI/oHm+9YL/79GzzokPw/JPdstRAM4hiQox0AL1b4/hN1LZ1gGPYxCMaLumT7TprwqqAg6C+jjUETGeb9Zbdpqz92qkgJq3uJytGIaa9LcPunmo32xM2F5KHmELsiAE7+IOJvrczchHqkbv/o1/arBoodVEdh40zoMEAglBAj5GVIN1YnfhjnNbU5hjDYpxMJxr6dypU6g7+op2yfACpYjcdeSU3wTV11gjf/VPMKdFREQZHlnNhvFzVfsegtoAoZD+Q5dEDpE/N/FrFuycABzs6DZEQVRCJ2Z0s7hReqxFRHHZ9zYAGwMUOgqRRTGXNbbYu7U4u2unwW47hKAp9dbUtJSOPnKPJTuWwsbHr3YaqeM9IGhThZmrfId8VVmoj+uAwEku7De9nJKNNO5TTi2SsVRRnhZOCkN4ltNWMW8h4r+dateKnXBX6UTku8zmmcIhdIIjAnYm9k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5365.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ym5rbFova01jZ1ZiQU1yZlhHZHVhSGVUN2pCTSthWk5iZkJ5S1oxRThxS1Fv?=
 =?utf-8?B?OGcvdzR1UDJNdXppcmxDMERNOFZVdytiV0E1Y2dsekFOTTBQNkxZR0wzTFVG?=
 =?utf-8?B?TkhScG9CZm9paFdWdEVWaFg3aTNUUlk5ODB3SkhTOXZNWVBnUXhSQjhSY3Y2?=
 =?utf-8?B?NGIvSzRQaXJuYWNkbHZ3RE8zNFB4cHlXZ3JwQ2hPYWJEVTk4WHArd2FkU2RE?=
 =?utf-8?B?VUVvY3FWZUc0NlEyUjl5eUtXRXhST24rdnNDbnBVNzhCQVl5UHNESUkvd1A5?=
 =?utf-8?B?WDJ4MGE1RzRUS2cwMVVUVk9LcFMzMFRiUUErc1FHMmo2SFgzNVdFNmFFbFIy?=
 =?utf-8?B?SmVIS2NJWGdnQzl6VzhGMFpDeGpkZ1VjK3pUd3YzYzlSZk1hMnNBb0ozNUtJ?=
 =?utf-8?B?aEs1QkIwVXRMNy9jTXBZb0NLWlUxa2dLR3FUcFVqamxHWFBzeG5Wak9NUkdn?=
 =?utf-8?B?YjVwU1A4N3FleDl0eHcrUGxUdmlaemNpanUwbG9ITXFRR01qd3c4Njlub05U?=
 =?utf-8?B?RDZiTTBPMFJ0a2VSeXQzM0twRFcyZTVZSmo2Y0Z6VmhCZG5JdXlrT0FLM2Yx?=
 =?utf-8?B?WHJGbmRrOXczUjRnL21HSEJuYnI1dStjWDdpY0FObk0vT3A1VGhldi9SSC9V?=
 =?utf-8?B?YUNwdmdFQzhhTWZuZ1haNXQxOG8vRURRTEh4RXZSRHFGLzRkczQvL1JidldR?=
 =?utf-8?B?ZUIvZE5OQnRXK3V2TDA2ODVYMitDcjdYRUVXMXJGYkxMZXRqajZvdFdQT3pa?=
 =?utf-8?B?VUV1Q3JIUEVQV2JYSU15VUJaZ1ZOSU9QN0lYMVE5WWJUTU9KTEJDVjd3ZHZF?=
 =?utf-8?B?RWRBK2dVWUZRbEJoaUppRVpLRjVWcC9BWHBSM3IzZWs0THJLNjI1Y085dmpH?=
 =?utf-8?B?TnhIc2FpZHE5Y2g5NzRBYVRKN0NqVzRlYml0WVpxN3JmWmgwVEZiS2lGUXR5?=
 =?utf-8?B?NVY3OGJhTTZCaHE5bXBDNzdGU05nQ05MWXc2VU1zVzRQSE5sSG1UNnNsSktt?=
 =?utf-8?B?cVBKc1FHMzk3dTlkWFc4ZVVxbU41UHRpd0VzVjUwQ1VzRm9wc3FzeEFNU3lU?=
 =?utf-8?B?bjlteDRnWmZBNjRENjRKemRaVmdMU3VRdmhxZ0NPMWRodlhadUF1Z1J6WFUw?=
 =?utf-8?B?dlp5QVlnU1k2SkZHd0M1b3d6WmlicFBrTTBBZ20yTDBVUEVjQTY0VG1SMnFV?=
 =?utf-8?B?MmxMZW53NnZJVEpvZnBkbWN2VEJkODBBMDc1Q1JMK3ZsdERRWjhieG9iNzR1?=
 =?utf-8?B?VGpaalZTS1R4S0xkN2JCdTdUc29MU1c4Unl5cytUUDBhWkRXUHpVQ0cwZ09t?=
 =?utf-8?B?Zloyc1JBQWV1dkdOeDZTNHpCS3ordkp4a3g1MlNCVmJWQndiUkVGUjZDZUY3?=
 =?utf-8?B?ek1sa1FSMllKWTZiaEw3dWdTVURDZ1VnZ1NYZWg4cFd3aWRXUm5TQlFqL0Zo?=
 =?utf-8?B?bm9xb2hsV0Z1aVZ6ZjdvMVV2cVhEamtOR1VxN04yeFBYb2oya0JVWTZxMXdJ?=
 =?utf-8?B?Z1Y1cjdubjZNY09yZ0FVZHltMXUyQzVkRGdiakdCZmp4QWxhVWVzTkNRdkxQ?=
 =?utf-8?B?WEUyRjczWmM2dHBxaEY1N2tHQlplcHVGSmdUM2hTRklBS09zUWhnTk9IbXFp?=
 =?utf-8?B?eWN4TkdpeWQvdlpnSGg1ZE1JVWZadHVoajRIVzh3TjVZUWZPZ0t6ZTczQnlM?=
 =?utf-8?B?eU5DTUhTckxudG9YUjl3SWxla0JvUXhGMFRFV2hTOXJrdXVNdkg2aUpMQ05C?=
 =?utf-8?B?dGgzaWhDNDVHbkFqSnE5SDNjTDRXbUJtbFRGTHhxZHd1NDBxL3pSUFRuRGZW?=
 =?utf-8?B?eFFnc2FsNklpeFhmVmovank4WG1UZkNMQ0xRamhtMDVFYmRxK1Rhbkgxbzdo?=
 =?utf-8?B?ZHZjaDZJNFhPU1NnNmVPZDJWQ3krWUJ3dDJsdmJUQWlCUml0Tm5hcS85UlQz?=
 =?utf-8?B?SjlwZ3h2b0ZHMy9lZjRvbWVIMWUyeFh6Zm4rWVg5TGZKQ3A3eGN5cXR4MFVZ?=
 =?utf-8?B?Y2dQa3pHT0FrMmtWZTdTN2RKSWNjSHYvQXhFS2xodU1oMzRvYnZXWXJSUnJY?=
 =?utf-8?B?clFxQndaWjVJNi9JYU5BVmR1ZTBXTUJEVjZaV2lYQk5zd05aS1NaclYweXdt?=
 =?utf-8?B?QTg2VDNIS0h6elBGemRwQWdXNFBNWTdER1AySlVOYVJzME56WHVKVEt5eUVa?=
 =?utf-8?B?eEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FBEFC9A200C25D478BBEA7EADF075B1C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5365.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d53f062d-9c1e-4bb9-9a36-08dc430e4932
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2024 03:33:01.5970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fK2hn4HaTAVG/yquHUAmtTNcGQA/x/Rb8sQNJmTTIoyMWjDn7Y7Co4WpPqppiX9jpS3DGZOZ3Z7Xbp6lylmogGkRmo28wQyKjFVcklVe+bw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB9034
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--29.478200-8.000000
X-TMASE-MatchedRID: MDgwTWowY3bUL3YCMmnG4kD6z8N1m1ALjLOy13Cgb4+qvcIF1TcLYHsN
	je6oE7/XUmsNbSHn8eAQDZh9tV+I0YjQo/Iw2s1SM8ORI7N4NZYpWss5kPUFdCqt2Dk7ZTAMY6s
	q+xRPSkBj/dLh9t0mGQitCJZE82T4rGqzbR7VPHmd4hCa7xSZobv00HtUkATFUekjLrC3lTDfyy
	MmbNfTqr7aCg+WDekTQOrxUK8RJo1iukh7cLo+q/28T9BUNXkhsEf8CpnIYtnfUZT83lbkEDydO
	VERLYzlR7R2zxLpJHlkLUniIb4AyKC1lU3nQJyvFYJUGv4DL3wxXH/dlhvLv1pbYq2f4jz+kqO2
	AbVSuPxUM8SJMgfHHUdR4F8gUNXYbNjNjHLDuHOpvjJtAL8lc6J6BGsfymksGrKZCS5aXXUkJCG
	PFvgt07feHiFvOKaJaq5LFy3qY2FOdkJru9i75Z4CIKY/Hg3AwWulRtvvYxTWRN8STJpl3PoLR4
	+zsDTtAqYBE3k9Mpw=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--29.478200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	B49D9814BC38015A581C48CCD335A3681A26BA1CF81D77C3227B0B4450F23AE82000:8

T24gRnJpLCAyMDI0LTAzLTA4IGF0IDE0OjAyICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMDgvMDMvMjQgMTA6NDQsIEppYW5qdW4gV2FuZyAo546L5bu65Yab
KSBoYSBzY3JpdHRvOg0KPiA+IE9uIFdlZCwgMjAyNC0wMy0wNiBhdCAwOTo1MCArMDEwMCwgQW5n
ZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8NCj4gPiB3cm90ZToNCj4gPiA+IElsIDAxLzAzLzI0IDAz
OjQ4LCBKaWFuanVuIFdhbmcgKOeOi+W7uuWGmykgaGEgc2NyaXR0bzoNCj4gPiA+ID4gSGkgQW5n
ZWxvLA0KPiA+ID4gPiANCj4gPiA+ID4gVGhhbmtzIGZvciB5b3VyIHBhdGNoLg0KPiA+ID4gPiAN
Cj4gPiA+ID4gT24gVGh1LCAyMDI0LTAyLTI5IGF0IDEwOjI0ICswMTAwLCBBbmdlbG9HaW9hY2No
aW5vIERlbCBSZWdubw0KPiA+ID4gPiB3cm90ZToNCj4gPiA+ID4gPiBTb21lIFNvQ3MgaGF2ZSB0
d28gUENJLUV4cHJlc3MgY29udHJvbGxlcnM6IGluIHRoZSBjYXNlIG9mDQo+ID4gPiA+ID4gTVQ4
MTk1LA0KPiA+ID4gPiA+IG9uZSBvZiB0aGVtIGlzIHVzaW5nIGEgZGVkaWNhdGVkIFBIWSwgYnV0
IHRoZSBvdGhlciB1c2VzIGENCj4gPiA+ID4gPiBjb21ibw0KPiA+ID4gPiA+IFBIWQ0KPiA+ID4g
PiA+IHRoYXQgaXMgc2hhcmVkIHdpdGggVVNCIGFuZCBpbiB0aGF0IGNhc2UgdGhlIFBIWSBjYW5u
b3QgYmUNCj4gPiA+ID4gPiByZXNldA0KPiA+ID4gPiA+IGZyb20gdGhlIFBDSWUgZHJpdmVyLCBv
ciBVU0IgZnVuY3Rpb25hbGl0eSB3aWxsIGJlIHVuYWJsZSB0bw0KPiA+ID4gPiA+IHJlc3VtZS4N
Cj4gPiA+ID4gPiANCj4gPiA+ID4gPiBSZXNldHRpbmcgdGhlIFBDSWUgTUFDIHdpdGhvdXQgYWxz
byByZXNldHRpbmcgdGhlIFBIWSB3aWxsDQo+ID4gPiA+ID4gcmVzdWx0DQo+ID4gPiA+ID4gaW4N
Cj4gPiA+ID4gPiBhIGZ1bGwgc3lzdGVtIGxvY2t1cCBhdCBQQ0llIHJlc3VtZSB0aW1lIGFuZCB0
aGUgb25seSBvcHRpb24NCj4gPiA+ID4gPiB0bw0KPiA+ID4gPiA+IHJlc3VtZSBvcGVyYXRpb24g
aXMgdG8gaGFyZCByZWJvb3QgdGhlIHN5c3RlbSAod2l0aCBhIFBNSUMNCj4gPiA+ID4gPiBjdXQt
DQo+ID4gPiA+ID4gb2ZmKS4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBUbyByZXNvbHZlIHRoaXMg
aXNzdWUsIGNoZWNrIGlmIHdlJ3ZlIGdvdCBib3RoIGEgUEhZIGFuZCBhDQo+ID4gPiA+ID4gTUFD
DQo+ID4gPiA+ID4gcmVzZXQNCj4gPiA+ID4gPiBhbmQsIGlmIG5vdCwgbmV2ZXIgYXNzZXJ0IHJl
c2V0cyBhdCBQTSBzdXNwZW5kIHRpbWU6IGluIHRoYXQNCj4gPiA+ID4gPiBjYXNlLA0KPiA+ID4g
PiA+IHRoZSBsaW5rIGlzIHN0aWxsIGdldHRpbmcgcG93ZXJlZCBkb3duIGFzIGJvdGggdGhlIGNs
b2NrcyBhbmQNCj4gPiA+ID4gPiB0aGUNCj4gPiA+ID4gPiBwb3dlciBkb21haW5zIHdpbGwgZ28g
ZG93biBhbnl3YXkuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gRml4ZXM6IGQ1MzdkYzEyNWYwNyAo
IlBDSTogbWVkaWF0ZWstZ2VuMzogQWRkIHN5c3RlbSBQTQ0KPiA+ID4gPiA+IHN1cHBvcnQiKQ0K
PiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDwNCj4g
PiA+ID4gPiBhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQo+ID4gPiA+
ID4gLS0tDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gQ2hhbmdlcyBpbiB2MjoNCj4gPiA+ID4gPiAg
ICAtIFJlYmFzZWQgb3ZlciBuZXh0LTIwMjQwMjI5DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gICAg
ZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1lZGlhdGVrLWdlbjMuYyB8IDI1DQo+ID4gPiA+
ID4gKysrKysrKysrKysrKystLS0tLQ0KPiA+ID4gPiA+IC0tDQo+ID4gPiA+ID4gICAgMSBmaWxl
IGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tZWRpYXRl
ay1nZW4zLmMNCj4gPiA+ID4gPiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tZWRpYXRl
ay1nZW4zLmMNCj4gPiA+ID4gPiBpbmRleCA5NzViMzAyNGZiMDguLjk5YjVkN2E0OWJlMSAxMDA2
NDQNCj4gPiA+ID4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbWVkaWF0ZWst
Z2VuMy5jDQo+ID4gPiA+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1lZGlh
dGVrLWdlbjMuYw0KPiA+ID4gPiA+IEBAIC04NzQsMTcgKzg3NCwyNiBAQCBzdGF0aWMgaW50IG10
a19wY2llX3Bvd2VyX3VwKHN0cnVjdA0KPiA+ID4gPiA+IG10a19nZW4zX3BjaWUgKnBjaWUpDQo+
ID4gPiA+ID4gICAgCXJldHVybiBlcnI7DQo+ID4gPiA+ID4gICAgfQ0KPiA+ID4gPiA+ICAgIA0K
PiA+ID4gPiA+IC1zdGF0aWMgdm9pZCBtdGtfcGNpZV9wb3dlcl9kb3duKHN0cnVjdCBtdGtfZ2Vu
M19wY2llICpwY2llKQ0KPiA+ID4gPiA+ICtzdGF0aWMgdm9pZCBtdGtfcGNpZV9wb3dlcl9kb3du
KHN0cnVjdCBtdGtfZ2VuM19wY2llICpwY2llLA0KPiA+ID4gPiA+IGJvb2wNCj4gPiA+ID4gPiBp
c19zdXNwZW5kKQ0KPiA+ID4gPiA+ICAgIHsNCj4gPiA+ID4gPiArCWJvb2wgc3VzcGVuZF9yZXNl
dF9zdXBwb3J0ZWQgPSBwY2llLT5tYWNfcmVzZXQgJiYgcGNpZS0NCj4gPiA+ID4gPiA+IHBoeV9y
ZXNldDsNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiArDQo+ID4gPiA+ID4gICAgCWNsa19idWxrX2Rp
c2FibGVfdW5wcmVwYXJlKHBjaWUtPm51bV9jbGtzLCBwY2llLT5jbGtzKTsNCj4gPiA+ID4gPiAg
ICANCj4gPiA+ID4gPiAgICAJcG1fcnVudGltZV9wdXRfc3luYyhwY2llLT5kZXYpOw0KPiA+ID4g
PiA+ICAgIAlwbV9ydW50aW1lX2Rpc2FibGUocGNpZS0+ZGV2KTsNCj4gPiA+ID4gPiAtCXJlc2V0
X2NvbnRyb2xfYXNzZXJ0KHBjaWUtPm1hY19yZXNldCk7DQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+
ICsJLyoNCj4gPiA+ID4gPiArCSAqIEFzc2VydCBNQUMgcmVzZXQgb25seSBpZiB3ZSBhbHNvIGdv
dCBhIFBIWSByZXNldCwNCj4gPiA+ID4gPiBvdGhlcndpc2UNCj4gPiA+ID4gPiArCSAqIHRoZSBz
eXN0ZW0gd2lsbCBsb2NrdXAgYXQgUE0gcmVzdW1lIHRpbWUuDQo+ID4gPiA+ID4gKwkgKi8NCj4g
PiA+ID4gPiArCWlmIChpc19zdXNwZW5kICYmIHN1c3BlbmRfcmVzZXRfc3VwcG9ydGVkKQ0KPiA+
ID4gPiA+ICsJCXJlc2V0X2NvbnRyb2xfYXNzZXJ0KHBjaWUtPm1hY19yZXNldCk7DQo+ID4gPiA+
ID4gICAgDQo+ID4gPiA+ID4gICAgCXBoeV9wb3dlcl9vZmYocGNpZS0+cGh5KTsNCj4gPiA+ID4g
PiAgICAJcGh5X2V4aXQocGNpZS0+cGh5KTsNCj4gPiA+ID4gPiAtCXJlc2V0X2NvbnRyb2xfYXNz
ZXJ0KHBjaWUtPnBoeV9yZXNldCk7DQo+ID4gPiA+ID4gKwlpZiAoaXNfc3VzcGVuZCAmJiBzdXNw
ZW5kX3Jlc2V0X3N1cHBvcnRlZCkNCj4gPiA+ID4gPiArCQlyZXNldF9jb250cm9sX2Fzc2VydChw
Y2llLT5waHlfcmVzZXQpOw0KPiA+ID4gPiA+ICAgIH0NCj4gPiA+ID4gPiAgICANCj4gPiA+ID4g
PiAgICBzdGF0aWMgaW50IG10a19wY2llX3NldHVwKHN0cnVjdCBtdGtfZ2VuM19wY2llICpwY2ll
KQ0KPiA+ID4gPiA+IEBAIC05MjAsNyArOTI5LDcgQEAgc3RhdGljIGludCBtdGtfcGNpZV9zZXR1
cChzdHJ1Y3QNCj4gPiA+ID4gPiBtdGtfZ2VuM19wY2llDQo+ID4gPiA+ID4gKnBjaWUpDQo+ID4g
PiA+ID4gICAgCXJldHVybiAwOw0KPiA+ID4gPiA+ICAgIA0KPiA+ID4gPiA+ICAgIGVycl9zZXR1
cDoNCj4gPiA+ID4gPiAtCW10a19wY2llX3Bvd2VyX2Rvd24ocGNpZSk7DQo+ID4gPiA+ID4gKwlt
dGtfcGNpZV9wb3dlcl9kb3duKHBjaWUsIGZhbHNlKTsNCj4gPiA+ID4gPiAgICANCj4gPiA+ID4g
PiAgICAJcmV0dXJuIGVycjsNCj4gPiA+ID4gPiAgICB9DQo+ID4gPiA+ID4gQEAgLTk1MSw3ICs5
NjAsNyBAQCBzdGF0aWMgaW50IG10a19wY2llX3Byb2JlKHN0cnVjdA0KPiA+ID4gPiA+IHBsYXRm
b3JtX2RldmljZQ0KPiA+ID4gPiA+ICpwZGV2KQ0KPiA+ID4gPiA+ICAgIAllcnIgPSBwY2lfaG9z
dF9wcm9iZShob3N0KTsNCj4gPiA+ID4gPiAgICAJaWYgKGVycikgew0KPiA+ID4gPiA+ICAgIAkJ
bXRrX3BjaWVfaXJxX3RlYXJkb3duKHBjaWUpOw0KPiA+ID4gPiA+IC0JCW10a19wY2llX3Bvd2Vy
X2Rvd24ocGNpZSk7DQo+ID4gPiA+ID4gKwkJbXRrX3BjaWVfcG93ZXJfZG93bihwY2llLCBmYWxz
ZSk7DQo+ID4gPiA+ID4gICAgCQlyZXR1cm4gZXJyOw0KPiA+ID4gPiA+ICAgIAl9DQo+ID4gPiA+
ID4gICAgDQo+ID4gPiA+ID4gQEAgLTk2OSw3ICs5NzgsNyBAQCBzdGF0aWMgdm9pZCBtdGtfcGNp
ZV9yZW1vdmUoc3RydWN0DQo+ID4gPiA+ID4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ID4g
PiA+ICAgIAlwY2lfdW5sb2NrX3Jlc2Nhbl9yZW1vdmUoKTsNCj4gPiA+ID4gPiAgICANCj4gPiA+
ID4gPiAgICAJbXRrX3BjaWVfaXJxX3RlYXJkb3duKHBjaWUpOw0KPiA+ID4gPiA+IC0JbXRrX3Bj
aWVfcG93ZXJfZG93bihwY2llKTsNCj4gPiA+ID4gPiArCW10a19wY2llX3Bvd2VyX2Rvd24ocGNp
ZSwgZmFsc2UpOw0KPiA+ID4gPiANCj4gPiA+ID4gSXMgdGhlcmUgYW55IHJlYXNvbiBub3QgdG8g
cmVzZXQgdGhlIE1BQyBhbmQgUEhZIHdoZW4gcHJvYmUNCj4gPiA+ID4gZmFpbHMNCj4gPiA+ID4g
YW5kDQo+ID4gPiA+IGRyaXZlciByZW1vdmluZz8gU29tZSBTb0NzIG1heSBub3QgaGF2ZSBNVENN
T1MgdG8gY3V0IG9mZiB0aGVpcg0KPiA+ID4gPiBwb3dlciwNCj4gPiA+ID4gd2UgbmVlZCB0byBh
c3NlcnQgdGhlIHJlc2V0IHNpZ25hbCB0byBzYXZlIHBvd2VyIGluIHRoYXQgY2FzZS4NCj4gPiA+
ID4gDQo+ID4gPiANCj4gPiA+IFNvcnJ5IGZvciB0aGUgbGF0ZSByZXBseSAtIHllcywgdGhlcmUg
aXMgYSByZWFzb24uDQo+ID4gPiANCj4gPiA+IE9uIHBsYXRmb3JtcyBuZWVkaW5nIHRoaXMgcXVp
cmssIHJlc2V0dGluZyBhdCAucmVtb3ZlKCkgdGltZSB3aWxsDQo+ID4gPiBoYW5nIHRoZQ0KPiA+
ID4gbWFjaGluZSBpZiB0aGUgbW9kdWxlIGlzIHJlaW5zZXJ0ZWQgbGF0ZXIgKGhlbmNlLCAucHJv
YmUoKSBjYWxsZWQNCj4gPiA+IGF0DQo+ID4gPiBhIGxhdGVyDQo+ID4gPiB0aW1lKS4NCj4gPiAN
Cj4gPiBEb2VzIHRoaXMgb25seSBoYXBwZW4gd2hlbiB0aGUgUENJZSBNQUMgaXMgcmVzZXQgd2l0
aG91dCByZXNldHRpbmcNCj4gPiB0aGUNCj4gPiBQSFk/IElzIGl0IHJlbGF0ZWQgdG8gdGhlIHJl
c2V0IGZyYW1ld29yaz8NCj4gPiANCj4gDQo+IEhhcHBlbnMgb25seSB3aGVuIE1BQyBpcyByZXNl
dCB3aXRob3V0IHJlc2V0dGluZyB0aGUgUEhZIGFmdGVyDQo+IGNhbGxpbmcNCj4gcGh5X3Bvd2Vy
X29mZigpOyBwaHlfZXhpdCgpOw0KPiANCj4gSXQncyBub3QgYSByZXNldCBmcmFtZXdvcmsgaXNz
dWUsIHRoYXQncyBmb3Igc3VyZS4NCg0KVGhhbmtzIGZvciB0aGUgZXhwbGFuYXRpb24uDQoNCklu
IHRoYXQgY2FzZSwgd2h5IGRvIHdlIG9ubHkgcmVzZXQgZHVyaW5nIHN1c3BlbmQ/IENhbiB3ZSBh
bHNvIHJlc2V0DQp0aGVtIHdoZW4gcHJvYmUgZmFpbHMgYW5kIGRyaXZlciByZW1vdmluZywgaWYg
Ym90aCB0aGUgUEhZIGFuZCBNQUMNCnJlc2V0cyBhcmUgcHJlc2VudD8NCg0KVGhhbmtzLg0KDQo+
IA0KPiBBbmdlbG8NCj4gDQo+ID4gVGhhbmtzLg0KPiA+ID4gDQo+ID4gPiBSZWdhcmRzLA0KPiA+
ID4gQW5nZWxvDQo+ID4gPiANCj4gPiA+ID4gVGhhbmtzLg0KPiA+ID4gPiANCj4gPiA+ID4gPiAg
ICB9DQo+ID4gPiA+ID4gICAgDQo+ID4gPiA+ID4gICAgc3RhdGljIHZvaWQgbXRrX3BjaWVfaXJx
X3NhdmUoc3RydWN0IG10a19nZW4zX3BjaWUgKnBjaWUpDQo+ID4gPiA+ID4gQEAgLTEwNDQsNyAr
MTA1Myw3IEBAIHN0YXRpYyBpbnQNCj4gPiA+ID4gPiBtdGtfcGNpZV9zdXNwZW5kX25vaXJxKHN0
cnVjdA0KPiA+ID4gPiA+IGRldmljZQ0KPiA+ID4gPiA+ICpkZXYpDQo+ID4gPiA+ID4gICAgCWRl
dl9kYmcocGNpZS0+ZGV2LCAiZW50ZXJlZCBMMiBzdGF0ZXMgc3VjY2Vzc2Z1bGx5Iik7DQo+ID4g
PiA+ID4gICAgDQo+ID4gPiA+ID4gICAgCW10a19wY2llX2lycV9zYXZlKHBjaWUpOw0KPiA+ID4g
PiA+IC0JbXRrX3BjaWVfcG93ZXJfZG93bihwY2llKTsNCj4gPiA+ID4gPiArCW10a19wY2llX3Bv
d2VyX2Rvd24ocGNpZSwgdHJ1ZSk7DQo+ID4gPiA+ID4gICAgDQo+ID4gPiA+ID4gICAgCXJldHVy
biAwOw0KPiA+ID4gPiA+ICAgIH0NCj4gPiA+ID4gPiBAQCAtMTA2MCw3ICsxMDY5LDcgQEAgc3Rh
dGljIGludCBtdGtfcGNpZV9yZXN1bWVfbm9pcnEoc3RydWN0DQo+ID4gPiA+ID4gZGV2aWNlDQo+
ID4gPiA+ID4gKmRldikNCj4gPiA+ID4gPiAgICANCj4gPiA+ID4gPiAgICAJZXJyID0gbXRrX3Bj
aWVfc3RhcnR1cF9wb3J0KHBjaWUpOw0KPiA+ID4gPiA+ICAgIAlpZiAoZXJyKSB7DQo+ID4gPiA+
ID4gLQkJbXRrX3BjaWVfcG93ZXJfZG93bihwY2llKTsNCj4gPiA+ID4gPiArCQltdGtfcGNpZV9w
b3dlcl9kb3duKHBjaWUsIGZhbHNlKTsNCj4gPiA+ID4gPiAgICAJCXJldHVybiBlcnI7DQo+ID4g
PiA+ID4gICAgCX0NCj4gPiA+ID4gPiAgICANCj4gPiA+IA0KPiA+ID4gDQo+ID4gPiANCj4gDQo+
IA0K

