Return-Path: <linux-pci+bounces-1045-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2136F8141AA
	for <lists+linux-pci@lfdr.de>; Fri, 15 Dec 2023 07:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC9B9283249
	for <lists+linux-pci@lfdr.de>; Fri, 15 Dec 2023 06:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9F16FC6;
	Fri, 15 Dec 2023 06:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="mHf95kyj";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="mXgpiN19"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7492463CB;
	Fri, 15 Dec 2023 06:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 55dbbcee9b1011eeba30773df0976c77-20231215
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=v5xlY6yiVnPMwMFTzP3ppmSWq0Bwy1ZgkU8Fpg546N8=;
	b=mHf95kyjYOXkT27X8zX+679F1ruKRzMx4XPbqCpU+iZyj1sfGFBdnuBiDW1H2STDL1PWc6Hf9c8GJX7LMWhTjcu//0Dqfqym5b9hopHZwEzVVt19c0w22e5clUwZw20OoOc2S2WsRz8qOZVdOsN4N8kJWAw34db8UbQb6M+tpcM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:6551c134-c7da-48ac-bc5a-0b1e483e8045,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:5d391d7,CLOUDID:45f934bd-2ac7-4da2-9f94-677a477649d9,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 55dbbcee9b1011eeba30773df0976c77-20231215
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <jianjun.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1156973386; Fri, 15 Dec 2023 14:08:15 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 15 Dec 2023 14:08:14 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 15 Dec 2023 14:08:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fGvVQ4iB8oetP+WentIntI0VSmF/ttlHhm8c+Drqpl3SGo5qwyqstvYyGjgqHzpi9SZKm23FZF91ttWsT/p2LYCBEV2/Ks2IkOGJAu82RfmWQEUzvhrWpQJynlYY2Hk6+MmvE3gYaUCL36wu4c6YLIa6b2vGadYamBoKU817PQETE6lXZxwH8E2Ws9CuDtgWZ+oAOl87OFM63AzUUMS6mZKGEvSSGs1daA/giw8OZjaN4rWqGspteXSQ3R7sNEMjdRYCwqc6fw+/o4JwNbl16xr1JitfVppSG2oALvxpVOXmrGn6VuH3p/9wYTUTrAn1Uqo45f9/WL2Mq3/UnJTuiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v5xlY6yiVnPMwMFTzP3ppmSWq0Bwy1ZgkU8Fpg546N8=;
 b=P5Qj/q01XxDlS7Jw0MVNKABHJwgxRTsBkjmLOZXae8JT9hjcoYVunfFyP99uoX9D/nDS7pMeYxDFwqyufYPDS7FETJlWIUmP8wrz/TLZk7BYOWWZge7285mPWcMzHqQryE3s7hUQiW4YNt0YoPMyYYZWSkT3I9AbzqFoAW45XvdU/5seF6tf9L9T+mEEhyMPBNj1xCNZNP0NmaKzmapBuZXi0XSBU5MyAiLwH4oVb1CvHiQGKCnbOXHfVZmh+xfOSYikSajFgdlDV228IGG5n2Y+yQyzMjGfREm8fLYBhtyWCxnbV+1tCPXkqsGvoOKWvtxdQzLNCljsfX9UgHG5dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v5xlY6yiVnPMwMFTzP3ppmSWq0Bwy1ZgkU8Fpg546N8=;
 b=mXgpiN19VVM5CSH8EhS8/eqwLU7I9czF1yFKMKv9D9rOSBzHvqttR4nvA82e2eag1ulMNQBH0NT0C2n1SlxqzYJ52kKyo/AzXekTTLmVZH8ZDiaKUeT03xcXM3B3dbQDKO0g039+T7CIodfO4JDfBk9SFBbGtXIcYIiwut5AqV4=
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com (2603:1096:301:17::5)
 by JH0PR03MB8696.apcprd03.prod.outlook.com (2603:1096:990:99::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 06:08:11 +0000
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::bad5:5c99:1d71:2631]) by PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::bad5:5c99:1d71:2631%4]) with mapi id 15.20.7091.029; Fri, 15 Dec 2023
 06:08:11 +0000
From: =?utf-8?B?Smlhbmp1biBXYW5nICjnjovlu7rlhpsp?= <Jianjun.Wang@mediatek.com>
To: "robh@kernel.org" <robh@kernel.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "kw@linux.com" <kw@linux.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?SmlleXkgWWFuZyAo5p2o5rSBKQ==?= <Jieyy.Yang@mediatek.com>,
	=?utf-8?B?Q2h1YW5qaWEgTGl1ICjmn7PkvKDlmIkp?= <Chuanjia.Liu@mediatek.com>,
	=?utf-8?B?SmlhbiBZYW5nICjmnajmiKwp?= <Jian.Yang@mediatek.com>,
	=?utf-8?B?UWl6aG9uZyBDaGVuZyAo56iL5ZWf5b+gKQ==?=
	<Qizhong.Cheng@mediatek.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, Ryder Lee <Ryder.Lee@mediatek.com>
Subject: Re: [PATCH v2] PCI: mediatek-gen3: Fix translation window
Thread-Topic: [PATCH v2] PCI: mediatek-gen3: Fix translation window
Thread-Index: AQHaBYj34jUTwwci5EyGDD9GhMp2WbCHTUQAgCLh0gA=
Date: Fri, 15 Dec 2023 06:08:11 +0000
Message-ID: <8becf27eac8ee682d10abeac3ed38e006e476078.camel@mediatek.com>
References: <20231023081423.18559-1-jianjun.wang@mediatek.com>
	 <80fc850062017a2ef2091a43759e19f3fcf2666f.camel@mediatek.com>
In-Reply-To: <80fc850062017a2ef2091a43759e19f3fcf2666f.camel@mediatek.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5365:EE_|JH0PR03MB8696:EE_
x-ms-office365-filtering-correlation-id: 91616fa2-1d34-415e-eba7-08dbfd343799
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4zdYD+zRAirAdkboc0YrvHM8nGguPAIURSBVBoGD3MWNiHci0iSlEmnPpFr8IuXDw1lLBRV7nctG6Kh7UPFI0iBdZaFayO9ovWgryHVr5mm4fwEnZjUkiwStBuE36psyn7c8qQ72MUoPme3vyKAat1wPk71InQR0GKKwRepHuiISmhPXGKM5xlb7lr90zfuKb4Ks1kdy4auIfITI/+wU+NZgUNH4G6GtljN2/g48/aY64iO/gFAv5MO9QPqtKb4ROxKXAPPmvKQPBoCe3J1f7fjsWbIwnARA86Mx7LXdH7EjEkKanEn/Mbyp1/kqSotzte5020IJYu0gqzuibsar0MoKLzuwaX76Pwp3dXKkOu6IINXFaSXJGh0w743oUaDNkNMfoU4VyJ2DkSyr0+1XHh520Un8G+aBH1iTIaA+vEk7jnjDGPFoN1zH3PHLDRDxyiFwqlqidpNB2wWMYlf246wsxcqbYncEkJdNKXCM7olpH1j+J+dlfE44XrTL2lLhicHJjxS1YCAyhJCDBxkVjP4/4QU7zasxtrWlTZLtCgFoNOdvFsYW8S9zfL6o+eBHYXp0KvKEN7dq6Om0uQnUSMdzgSYfvJsLBDV6XJHJOzmNhqJpLAiwFMR4Uh+UF7AyeEbWZPd3k1I9F9qip9/C7j5gUO4ZaLsO2HRSv4B6THJWtCLL0pi9yddHp8LJaLCVmRVPG1Vh5xSxwMzcCKe+gQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5365.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(346002)(376002)(136003)(230273577357003)(230922051799003)(230173577357003)(451199024)(186009)(64100799003)(1800799012)(83380400001)(38070700009)(36756003)(85182001)(86362001)(122000001)(38100700002)(41300700001)(4326008)(71200400001)(6486002)(8676002)(8936002)(478600001)(6512007)(6506007)(66946007)(76116006)(110136005)(91956017)(54906003)(316002)(64756008)(66476007)(66556008)(66446008)(2616005)(107886003)(26005)(2906002)(4001150100001)(7416002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VytJNTByUGp0dWVYOFFGUTJncnk2UTVsUXY3MU1oZWkzL3ZnbjkwRGx5TTRJ?=
 =?utf-8?B?MzRidm1YYXQzY3ROcVhUUURlUGJiaVFHdVpNeEhjTnhJOGtqSGdpVkk0Z09Z?=
 =?utf-8?B?WDM5Q0c1MjAwQlBLcVVGOFdkWTRMNFdEK2pQWldCYXNzTjlkT1MvNFVUM1Bx?=
 =?utf-8?B?RHQvOGdiL2RDODhrTkJmSUxlb1o2cVlWSU8xazBKcHRBVHdtZFBWenhmbHhl?=
 =?utf-8?B?dHNERERRZ1ZvRVN2bnQ0cC9TL1EraHBOeWhzRFIrYmlnRlY3SjlhSXUwNmlZ?=
 =?utf-8?B?MHQ4R2gwNWxjUy81QXFvQ1NBVWVCZnVZc2dZeHB1VTBtOXJrQ1VYQ21Ga1Mr?=
 =?utf-8?B?MFd3Umw2Tmp2em5SUFdVY0JhVDkwelE2UzUyM0Rob2tlaVluemUvd0pQZGlM?=
 =?utf-8?B?MlBSNWFvaVhQNVRvZVl2K2ZWMm95YnVSMitDRkdETGZXc1RmSjVpMklIQ0Ri?=
 =?utf-8?B?azNIajZlTnMxTXV5dk5WZDFiSnRiMmR4Ym41U3F2d2k5Z0dBS1M4aGFzeVNK?=
 =?utf-8?B?ZURlZU0zb3RTL1p0V25veUFKbit2eGVKdWRnWEZtYU9PZEdQc0FHK01mQmd6?=
 =?utf-8?B?V2hDQWp6OW5ta1E4TGZpbG81QTJqUWJXVlEyQTN0aHVYeUl4MXZXeko4a1lv?=
 =?utf-8?B?c1V3bGZCRmlabUFtcHpZVlg0aG0wK1pYcS84Y2h6aGFqUWxIZExmNHBYOEtK?=
 =?utf-8?B?aW9vQ3hWb1JnNGMrZXZXdzdubDh2SktNK0NNWTFuVzdEcFJkRlBPSzFnRDla?=
 =?utf-8?B?bU1TaEZDZG9hU29OVmQ2enNHWlNOQStGcm1CUkdEbW1Ud05YK2hUeWhMTzVy?=
 =?utf-8?B?eTVZYUVnZFdVVlBXNkxLWWpYU1VKc1pwK1FFL2dKelVmYWpML3dwTlltTFRL?=
 =?utf-8?B?WXhCdkUwdVRmZG9uT1pXcG92ZEFOQUdrdERLcHM3TXZrbEk2bk43ZW1ZdlI1?=
 =?utf-8?B?NWJvQUZtaTA2dFRNSnBRdngxVFFuWkV4OUg0T3FNdG9jek1VeWZjWVlPTXlm?=
 =?utf-8?B?d3VUVmNkZ2FZejIxZ3VYcnkrNmxmWUdIWEllNzBYRlhRcWppWkV4ZllkZER0?=
 =?utf-8?B?NE4vcklNT1lRQ3pGRWhtMmUzUEt4ZnZqVDk1R3NKTVdiT1g1TXpEeEYyWFJs?=
 =?utf-8?B?UW1hQ0JMeTA4bEhScnRPWEF4R050VmFLdVc5cEF6cjdKSENaTUNxbjI3Q1Jj?=
 =?utf-8?B?eFUwRzc3b3dvOEJQaWpaMFBDbGVTeXhLOTlIUjc1YnUvUkd6d2pFRWpUMllk?=
 =?utf-8?B?cVNKTGhRYUNBNGpEcHFKbERkTUtuR3krUHlab1AxSXRpaVJXMWV6L1BhMlpS?=
 =?utf-8?B?SHhjem8wdTBRN1NHQ00ybmNVeHBxU0pGOW8yYk8xU1JKMkdJbmFSN3BFdnNz?=
 =?utf-8?B?TVlKUHRmM05pQmZPQS9RM3ZjWHRkZ0lkZ3lPbXhWdjNOc1BvUndKdlFOd0ps?=
 =?utf-8?B?RmQxVHpjQmZoSUlJU3V1ME1PVG9sTDhYTEdZazN0RkRZZ1hrelVCNmhkYXZs?=
 =?utf-8?B?Nkd6ckxoK1daV2N3UzhHL1l3V0Z6MDJwdjZlYi9sNm82cFBKRFNwUHJWcDRm?=
 =?utf-8?B?SnhXbWRkUmh4dlVQQ2czTjBSK2hDTVpUTS91ZW5qeEFkS3RoK2Urc0NnSU9a?=
 =?utf-8?B?d2hSQ25RK0UrS0MzYjNqVlc3clhqamEwU3ExYS9LVGhiaFhuMjVYSTgzM2Fq?=
 =?utf-8?B?azlIbjgybjM1ZWdaTERRaVR6ZzZlQ2Z6THV1RkVPMGRsMWFCK2NDUncvQ3FX?=
 =?utf-8?B?MGVuZkI3SGdJZW5mWlIxWm1qM1hGVXpRbmNCbXJHOHNKcERqcm0vUCtKSEpB?=
 =?utf-8?B?bXNFTngwK05PL01aZm5YMGFMeFlNU1QxMDc5d2ZVUVE1bmRWZys5a2t6VE5D?=
 =?utf-8?B?cTBKeFJ6NWpyKzdwY2MyWnY5UGFueUJGejd5UGY5bmVqMXVwdzdrbmgzbFN0?=
 =?utf-8?B?em13WDllUC9ZMFdST2Uva2JmakZPQVd1VzZDVDBpU0FBb01BMDZiWTVOOVpv?=
 =?utf-8?B?ejltdWcxRXNFbEY0UkVrVnZ4YkVleVpld1pxbng2VUF2OTZtTmJlQ1ZpTG1B?=
 =?utf-8?B?NCs1WHBYUEtyOG0reW94Ulg4S1VySWMwNTRXRGR2RktWSEhQM215dEhNRFdk?=
 =?utf-8?B?U3AzUllaZUdwbWxXa3UrcFFoNmF5anlUNUVROVY1amJMcnEvZjFEaU91WVdK?=
 =?utf-8?B?cWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5525F296583AB4459981F05E26694CE7@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5365.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91616fa2-1d34-415e-eba7-08dbfd343799
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2023 06:08:11.5585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 07Kyixf6FN4cn6r71siUB5nCuhr0BSwVqScKfrkRJXzRmJ+cfUBVPocoH/WaCnqRz4Yhny/t8o6l5s4bvNYUGPht6aYWlCH4VNpV7RCqCVE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8696
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--22.602300-8.000000
X-TMASE-MatchedRID: 2SDSohiwfqTUL3YCMmnG4lt3XMydUaMX8uTf6U4SUIOo+b+yOP0oGG7H
	Y6NYk3sy1Fc61VCGvh07uvk6QO/AI8OQecnAhEpbL8+mpRda1YMZmNqpqQL8xp722hDqHosT/Py
	9qOi5zpcYQOIvxOoGr1pOmH7y6GJ5+uobhwVz9gBc/msUC5wFQbi8G4TZfQeVmKInQ61iaAOo4P
	C77j2kJWpa4IbS2Cpz49Jc7Pc1koF+dpL9dOXQEjIHIyLCTr7eVBDQSDMig9FPCuo2vnnNciGY2
	1eHqI6z48CHU6S1ISH7W1mdzsq7t+n2wHlv5vGuQ5lZokGzOao7r2Gtb9iBYX+xQ2Bqcl6t/F1B
	rea7byL35KkXf+A+vbpPKEWWQLj0WU/fB/XFmJyeAiCmPx4NwMFrpUbb72MU1kTfEkyaZdz6C0e
	Ps7A07QKmARN5PTKc
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--22.602300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	6CFEBD0CF97F1F063136F1F0E26633F06F5A0FDC094C2C6CD84B719AC5835C632000:8

SGkgQmpvcm4sIExvcmVuem8sDQoNClNvcnJ5IHRvIGJvdGhlciB5b3UsIGJ1dCB3b3VsZCB5b3Ug
bWluZCB0YWtpbmcgYSBsb29rIGF0IHRoaXMgcGF0Y2g/DQpBcHByZWNpYXRlIGFueSBzdWdnZXN0
aW9ucy4NCg0KVGhhbmtzLg0KDQpPbiBUaHUsIDIwMjMtMTEtMjMgYXQgMDE6MjcgKzAwMDAsIEpp
YW5qdW4gV2FuZyAo546L5bu65YabKSB3cm90ZToNCj4gSGkgTWFpbnRhaW5lcnMsDQo+IA0KPiBH
ZW50bGUgcGluZyBmb3IgdGhpcyBwYXRjaCwgaWYgdGhlcmUgaXMgYW55dGhpbmcgSSBuZWVkIHRv
IGRvLCBwbGVhc2UNCj4gbGV0IG1lIGtub3cuDQo+IA0KPiBUaGFua3MuDQo+IA0KPiBPbiBNb24s
IDIwMjMtMTAtMjMgYXQgMTY6MTQgKzA4MDAsIEppYW5qdW4gV2FuZyB3cm90ZToNCj4gPiBUaGUg
c2l6ZSBvZiB0cmFuc2xhdGlvbiB0YWJsZSBzaG91bGQgYmUgYSBwb3dlciBvZiAyLCB1c2luZyBm
bHMoKQ0KPiA+IGNhbm5vdCBnZXQgdGhlIHByb3BlciB2YWx1ZSB3aGVuIHRoZSBzaXplIGlzIG5v
dCBhIHBvd2VyIG9mIDIuIEZvcg0KPiA+IGV4YW1wbGUsIGZscygweDNlMDAwMDApIC0gMSA9IDI1
LCBoZW5jZSB0aGUgUENJZSB0cmFuc2xhdGlvbiB3aW5kb3cNCj4gPiBzaXplIHdpbGwgYmUgc2V0
IHRvIDB4MjAwMDAwMCBpbnN0ZWFkIG9mIHRoZSBleHBlY3RlZCBzaXplDQo+ID4gMHgzZTAwMDAw
Lg0KPiA+IA0KPiA+IEZpeCB0cmFuc2xhdGlvbiB3aW5kb3cgYnkgc3BsaXR0aW5nIHRoZSBNTUlP
IHNwYWNlIHRvIG11bHRpcGxlDQo+ID4gdGFibGVzDQo+ID4gaWYNCj4gPiBpdHMgc2l6ZSBpcyBu
b3QgYSBwb3dlciBvZiAyLg0KPiA+IA0KPiA+IEZpeGVzOiBkM2JmNzViNTc5YjkgKCJQQ0k6IG1l
ZGlhdGVrLWdlbjM6IEFkZCBNZWRpYVRlayBHZW4zIGRyaXZlcg0KPiA+IGZvciBNVDgxOTIiKQ0K
PiA+IFNpZ25lZC1vZmYtYnk6IEppYW5qdW4gV2FuZyA8amlhbmp1bi53YW5nQG1lZGlhdGVrLmNv
bT4NCj4gPiANCj4gPiAtLS0NCj4gPiBDaGFuZ2VzIGluIHYyOg0KPiA+IE9ubHkgcHJpbnQgd2Fy
bmluZyBtZXNzYWdlIHdoZW4gcmVhY2ggdGhlIG1heGltdW0gdHJhbnNsYXRpb24gdGFibGUNCj4g
PiBudW1iZXIsIHRoZSBNRU0gc3BhY2Ugc3RpbGwgd29ya3MgYnV0IHdpbGwgYmUgc21hbGxlciB0
aGFuDQo+ID4gZXhwZWN0ZWQuDQo+ID4gDQo+ID4gQm9vdHVwIGxvZ3Mgb24gTVQ4MTk1IFBsYXRm
b3JtOg0KPiA+IA0KPiA+ID4gQmVmb3JlIHRoaXMgcGF0Y2g6DQo+ID4gDQo+ID4gbXRrLXBjaWUt
Z2VuMyAxMTJmMDAwMC5wY2llOiBQYXJzaW5nIHJhbmdlcyBwcm9wZXJ0eS4uLg0KPiA+IG10ay1w
Y2llLWdlbjMgMTEyZjAwMDAucGNpZTogICAgICAgSU8gMHgwMDIwMDAwMDAwLi4weDAwMjAxZmZm
ZmYgLT4NCj4gPiAweDAwMjAwMDAwMDANCj4gPiBtdGstcGNpZS1nZW4zIDExMmYwMDAwLnBjaWU6
ICAgICAgTUVNIDB4MDAyMDIwMDAwMC4uMHgwMDIzZmZmZmZmIC0+DQo+ID4gMHgwMDIwMjAwMDAw
DQo+ID4gbXRrLXBjaWUtZ2VuMyAxMTJmMDAwMC5wY2llOiBzZXQgSU8gdHJhbnMgd2luZG93WzBd
OiBjcHVfYWRkciA9DQo+ID4gMHgyMDAwMDAwMCwgcGNpX2FkZHIgPSAweDIwMDAwMDAwLCBzaXpl
ID0gMHgyMDAwMDANCj4gPiBtdGstcGNpZS1nZW4zIDExMmYwMDAwLnBjaWU6IHNldCBNRU0gdHJh
bnMgd2luZG93WzFdOiBjcHVfYWRkciA9DQo+ID4gMHgyMDIwMDAwMCwgcGNpX2FkZHIgPSAweDIw
MjAwMDAwLCBzaXplID0gMHgzZTAwMDAwDQo+ID4gDQo+ID4gPiBXZSBleHBlY3QgdGhlIE1FTSB0
cmFucyB3aW5kb3cgc2l6ZSB0byBiZSAweDNlMDAwMDAsIGJ1dCBpdHMNCj4gPiA+IGFjdHVhbA0K
PiA+ID4gYXZhaWxhYmxlIHNpemUgaXMgMHgyMDAwMDAwLg0KPiA+ID4gQWZ0ZXIgYXBwbHlpbmcg
dGhpcyBwYXRjaDoNCj4gPiANCj4gPiBtdGstcGNpZS1nZW4zIDExMmYwMDAwLnBjaWU6IFBhcnNp
bmcgcmFuZ2VzIHByb3BlcnR5Li4uDQo+ID4gbXRrLXBjaWUtZ2VuMyAxMTJmMDAwMC5wY2llOiAg
ICAgICBJTyAweDAwMjAwMDAwMDAuLjB4MDAyMDFmZmZmZiAtPg0KPiA+IDB4MDAyMDAwMDAwMA0K
PiA+IG10ay1wY2llLWdlbjMgMTEyZjAwMDAucGNpZTogICAgICBNRU0gMHgwMDIwMjAwMDAwLi4w
eDAwMjNmZmZmZmYgLT4NCj4gPiAweDAwMjAyMDAwMDANCj4gPiBtdGstcGNpZS1nZW4zIDExMmYw
MDAwLnBjaWU6IHNldCBJTyB0cmFucyB3aW5kb3dbMF06IGNwdV9hZGRyID0NCj4gPiAweDIwMDAw
MDAwLCBwY2lfYWRkciA9IDB4MjAwMDAwMDAsIHNpemUgPSAweDIwMDAwMA0KPiA+IG10ay1wY2ll
LWdlbjMgMTEyZjAwMDAucGNpZTogc2V0IE1FTSB0cmFucyB3aW5kb3dbMV06IGNwdV9hZGRyID0N
Cj4gPiAweDIwMjAwMDAwLCBwY2lfYWRkciA9IDB4MjAyMDAwMDAsIHNpemUgPSAweDIwMDAwMA0K
PiA+IG10ay1wY2llLWdlbjMgMTEyZjAwMDAucGNpZTogc2V0IE1FTSB0cmFucyB3aW5kb3dbMl06
IGNwdV9hZGRyID0NCj4gPiAweDIwNDAwMDAwLCBwY2lfYWRkciA9IDB4MjA0MDAwMDAsIHNpemUg
PSAweDQwMDAwMA0KPiA+IG10ay1wY2llLWdlbjMgMTEyZjAwMDAucGNpZTogc2V0IE1FTSB0cmFu
cyB3aW5kb3dbM106IGNwdV9hZGRyID0NCj4gPiAweDIwODAwMDAwLCBwY2lfYWRkciA9IDB4MjA4
MDAwMDAsIHNpemUgPSAweDgwMDAwMA0KPiA+IG10ay1wY2llLWdlbjMgMTEyZjAwMDAucGNpZTog
c2V0IE1FTSB0cmFucyB3aW5kb3dbNF06IGNwdV9hZGRyID0NCj4gPiAweDIxMDAwMDAwLCBwY2lf
YWRkciA9IDB4MjEwMDAwMDAsIHNpemUgPSAweDEwMDAwMDANCj4gPiBtdGstcGNpZS1nZW4zIDEx
MmYwMDAwLnBjaWU6IHNldCBNRU0gdHJhbnMgd2luZG93WzVdOiBjcHVfYWRkciA9DQo+ID4gMHgy
MjAwMDAwMCwgcGNpX2FkZHIgPSAweDIyMDAwMDAwLCBzaXplID0gMHgyMDAwMDAwDQo+ID4gDQo+
ID4gPiBUb3RhbCBhdmFpbGFibGUgc2l6ZSBmb3IgTUVNIHRyYW5zIHdpbmRvdyBpcyAweDNlMDAw
MDAuDQo+ID4gDQo+ID4gLS0tDQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
cGNpZS1tZWRpYXRlay1nZW4zLmMgfCA4NSArKysrKysrKysrKystLS0tLQ0KPiA+IC0tDQo+ID4g
LS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDUwIGluc2VydGlvbnMoKyksIDM1IGRlbGV0aW9ucygt
KQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbWVk
aWF0ZWstZ2VuMy5jDQo+ID4gYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbWVkaWF0ZWst
Z2VuMy5jDQo+ID4gaW5kZXggZTBlMjc2NDVmZGY0Li45NzViMzAyNGZiMDggMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1lZGlhdGVrLWdlbjMuYw0KPiA+ICsr
KyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tZWRpYXRlay1nZW4zLmMNCj4gPiBAQCAt
MjQ1LDM1ICsyNDUsNjAgQEAgc3RhdGljIGludCBtdGtfcGNpZV9zZXRfdHJhbnNfdGFibGUoc3Ry
dWN0DQo+ID4gbXRrX2dlbjNfcGNpZSAqcGNpZSwNCj4gPiAgCQkJCSAgICByZXNvdXJjZV9zaXpl
X3QgY3B1X2FkZHIsDQo+ID4gIAkJCQkgICAgcmVzb3VyY2Vfc2l6ZV90IHBjaV9hZGRyLA0KPiA+
ICAJCQkJICAgIHJlc291cmNlX3NpemVfdCBzaXplLA0KPiA+IC0JCQkJICAgIHVuc2lnbmVkIGxv
bmcgdHlwZSwgaW50IG51bSkNCj4gPiArCQkJCSAgICB1bnNpZ25lZCBsb25nIHR5cGUsIGludCAq
bnVtKQ0KPiA+ICB7DQo+ID4gKwlyZXNvdXJjZV9zaXplX3QgcmVtYWluaW5nID0gc2l6ZTsNCj4g
PiArCXJlc291cmNlX3NpemVfdCB0YWJsZV9zaXplOw0KPiA+ICsJcmVzb3VyY2Vfc2l6ZV90IGFk
ZHJfYWxpZ247DQo+ID4gKwljb25zdCBjaGFyICpyYW5nZV90eXBlOw0KPiA+ICAJdm9pZCBfX2lv
bWVtICp0YWJsZTsNCj4gPiAgCXUzMiB2YWw7DQo+ID4gIA0KPiA+IC0JaWYgKG51bSA+PSBQQ0lF
X01BWF9UUkFOU19UQUJMRVMpIHsNCj4gPiAtCQlkZXZfZXJyKHBjaWUtPmRldiwgIm5vdCBlbm91
Z2ggdHJhbnNsYXRlIHRhYmxlIGZvcg0KPiA+IGFkZHI6ICUjbGx4LCBsaW1pdGVkIHRvIFslZF1c
biIsDQo+ID4gLQkJCSh1bnNpZ25lZCBsb25nIGxvbmcpY3B1X2FkZHIsDQo+ID4gUENJRV9NQVhf
VFJBTlNfVEFCTEVTKTsNCj4gPiAtCQlyZXR1cm4gLUVOT0RFVjsNCj4gPiAtCX0NCj4gPiArCXdo
aWxlIChyZW1haW5pbmcgJiYgKCpudW0gPCBQQ0lFX01BWF9UUkFOU19UQUJMRVMpKSB7DQo+ID4g
KwkJLyogVGFibGUgc2l6ZSBuZWVkcyB0byBiZSBhIHBvd2VyIG9mIDIgKi8NCj4gPiArCQl0YWJs
ZV9zaXplID0gQklUKGZscyhyZW1haW5pbmcpIC0gMSk7DQo+ID4gKw0KPiA+ICsJCWlmIChjcHVf
YWRkciA+IDApIHsNCj4gPiArCQkJYWRkcl9hbGlnbiA9IEJJVChmZnMoY3B1X2FkZHIpIC0gMSk7
DQo+ID4gKwkJCXRhYmxlX3NpemUgPSBtaW4odGFibGVfc2l6ZSwgYWRkcl9hbGlnbik7DQo+ID4g
KwkJfQ0KPiA+ICsNCj4gPiArCQkvKiBNaW5pbXVtIHNpemUgb2YgdHJhbnNsYXRlIHRhYmxlIGlz
IDRLaUIgKi8NCj4gPiArCQlpZiAodGFibGVfc2l6ZSA8IDB4MTAwMCkgew0KPiA+ICsJCQlkZXZf
ZXJyKHBjaWUtPmRldiwgImlsbGVnYWwgdGFibGUgc2l6ZQ0KPiA+ICUjbGx4XG4iLA0KPiA+ICsJ
CQkJKHVuc2lnbmVkIGxvbmcgbG9uZyl0YWJsZV9zaXplKTsNCj4gPiArCQkJcmV0dXJuIC1FSU5W
QUw7DQo+ID4gKwkJfQ0KPiA+ICANCj4gPiAtCXRhYmxlID0gcGNpZS0+YmFzZSArIFBDSUVfVFJB
TlNfVEFCTEVfQkFTRV9SRUcgKw0KPiA+IC0JCW51bSAqIFBDSUVfQVRSX1RMQl9TRVRfT0ZGU0VU
Ow0KPiA+ICsJCXRhYmxlID0gcGNpZS0+YmFzZSArIFBDSUVfVFJBTlNfVEFCTEVfQkFTRV9SRUcg
KyAqbnVtICoNCj4gPiBQQ0lFX0FUUl9UTEJfU0VUX09GRlNFVDsNCj4gPiArCQl3cml0ZWxfcmVs
YXhlZChsb3dlcl8zMl9iaXRzKGNwdV9hZGRyKSB8DQo+ID4gUENJRV9BVFJfU0laRShmbHModGFi
bGVfc2l6ZSkgLSAxKSwgdGFibGUpOw0KPiA+ICsJCXdyaXRlbF9yZWxheGVkKHVwcGVyXzMyX2Jp
dHMoY3B1X2FkZHIpLCB0YWJsZSArDQo+ID4gUENJRV9BVFJfU1JDX0FERFJfTVNCX09GRlNFVCk7
DQo+ID4gKwkJd3JpdGVsX3JlbGF4ZWQobG93ZXJfMzJfYml0cyhwY2lfYWRkciksIHRhYmxlICsN
Cj4gPiBQQ0lFX0FUUl9UUlNMX0FERFJfTFNCX09GRlNFVCk7DQo+ID4gKwkJd3JpdGVsX3JlbGF4
ZWQodXBwZXJfMzJfYml0cyhwY2lfYWRkciksIHRhYmxlICsNCj4gPiBQQ0lFX0FUUl9UUlNMX0FE
RFJfTVNCX09GRlNFVCk7DQo+ID4gIA0KPiA+IC0Jd3JpdGVsX3JlbGF4ZWQobG93ZXJfMzJfYml0
cyhjcHVfYWRkcikgfA0KPiA+IFBDSUVfQVRSX1NJWkUoZmxzKHNpemUpIC0gMSksDQo+ID4gLQkJ
ICAgICAgIHRhYmxlKTsNCj4gPiAtCXdyaXRlbF9yZWxheGVkKHVwcGVyXzMyX2JpdHMoY3B1X2Fk
ZHIpLA0KPiA+IC0JCSAgICAgICB0YWJsZSArIFBDSUVfQVRSX1NSQ19BRERSX01TQl9PRkZTRVQp
Ow0KPiA+IC0Jd3JpdGVsX3JlbGF4ZWQobG93ZXJfMzJfYml0cyhwY2lfYWRkciksDQo+ID4gLQkJ
ICAgICAgIHRhYmxlICsgUENJRV9BVFJfVFJTTF9BRERSX0xTQl9PRkZTRVQpOw0KPiA+IC0Jd3Jp
dGVsX3JlbGF4ZWQodXBwZXJfMzJfYml0cyhwY2lfYWRkciksDQo+ID4gLQkJICAgICAgIHRhYmxl
ICsgUENJRV9BVFJfVFJTTF9BRERSX01TQl9PRkZTRVQpOw0KPiA+ICsJCWlmICh0eXBlID09IElP
UkVTT1VSQ0VfSU8pIHsNCj4gPiArCQkJdmFsID0gUENJRV9BVFJfVFlQRV9JTyB8IFBDSUVfQVRS
X1RMUF9UWVBFX0lPOw0KPiA+ICsJCQlyYW5nZV90eXBlID0gIklPIjsNCj4gPiArCQl9IGVsc2Ug
ew0KPiA+ICsJCQl2YWwgPSBQQ0lFX0FUUl9UWVBFX01FTSB8DQo+ID4gUENJRV9BVFJfVExQX1RZ
UEVfTUVNOw0KPiA+ICsJCQlyYW5nZV90eXBlID0gIk1FTSI7DQo+ID4gKwkJfQ0KPiA+ICANCj4g
PiAtCWlmICh0eXBlID09IElPUkVTT1VSQ0VfSU8pDQo+ID4gLQkJdmFsID0gUENJRV9BVFJfVFlQ
RV9JTyB8IFBDSUVfQVRSX1RMUF9UWVBFX0lPOw0KPiA+IC0JZWxzZQ0KPiA+IC0JCXZhbCA9IFBD
SUVfQVRSX1RZUEVfTUVNIHwgUENJRV9BVFJfVExQX1RZUEVfTUVNOw0KPiA+ICsJCXdyaXRlbF9y
ZWxheGVkKHZhbCwgdGFibGUgKw0KPiA+IFBDSUVfQVRSX1RSU0xfUEFSQU1fT0ZGU0VUKTsNCj4g
PiAgDQo+ID4gLQl3cml0ZWxfcmVsYXhlZCh2YWwsIHRhYmxlICsgUENJRV9BVFJfVFJTTF9QQVJB
TV9PRkZTRVQpOw0KPiA+ICsJCWRldl9kYmcocGNpZS0+ZGV2LCAic2V0ICVzIHRyYW5zIHdpbmRv
d1slZF06IGNwdV9hZGRyID0NCj4gPiAlI2xseCwgcGNpX2FkZHIgPSAlI2xseCwgc2l6ZSA9ICUj
bGx4XG4iLA0KPiA+ICsJCQlyYW5nZV90eXBlLCAqbnVtLCAodW5zaWduZWQgbG9uZyBsb25nKWNw
dV9hZGRyLA0KPiA+ICsJCQkodW5zaWduZWQgbG9uZyBsb25nKXBjaV9hZGRyLCAodW5zaWduZWQg
bG9uZw0KPiA+IGxvbmcpdGFibGVfc2l6ZSk7DQo+ID4gKw0KPiA+ICsJCWNwdV9hZGRyICs9IHRh
YmxlX3NpemU7DQo+ID4gKwkJcGNpX2FkZHIgKz0gdGFibGVfc2l6ZTsNCj4gPiArCQlyZW1haW5p
bmcgLT0gdGFibGVfc2l6ZTsNCj4gPiArCQkoKm51bSkrKzsNCj4gPiArCX0NCj4gPiArDQo+ID4g
KwlpZiAocmVtYWluaW5nKQ0KPiA+ICsJCWRldl93YXJuKHBjaWUtPmRldiwgIm5vdCBlbm91Z2gg
dHJhbnNsYXRlIHRhYmxlIGZvcg0KPiA+IGFkZHI6ICUjbGx4LCBsaW1pdGVkIHRvIFslZF1cbiIs
DQo+ID4gKwkJCSAodW5zaWduZWQgbG9uZyBsb25nKWNwdV9hZGRyLA0KPiA+IFBDSUVfTUFYX1RS
QU5TX1RBQkxFUyk7DQo+ID4gIA0KPiA+ICAJcmV0dXJuIDA7DQo+ID4gIH0NCj4gPiBAQCAtMzgw
LDMwICs0MDUsMjAgQEAgc3RhdGljIGludCBtdGtfcGNpZV9zdGFydHVwX3BvcnQoc3RydWN0DQo+
ID4gbXRrX2dlbjNfcGNpZSAqcGNpZSkNCj4gPiAgCQlyZXNvdXJjZV9zaXplX3QgY3B1X2FkZHI7
DQo+ID4gIAkJcmVzb3VyY2Vfc2l6ZV90IHBjaV9hZGRyOw0KPiA+ICAJCXJlc291cmNlX3NpemVf
dCBzaXplOw0KPiA+IC0JCWNvbnN0IGNoYXIgKnJhbmdlX3R5cGU7DQo+ID4gIA0KPiA+IC0JCWlm
ICh0eXBlID09IElPUkVTT1VSQ0VfSU8pIHsNCj4gPiArCQlpZiAodHlwZSA9PSBJT1JFU09VUkNF
X0lPKQ0KPiA+ICAJCQljcHVfYWRkciA9IHBjaV9waW9fdG9fYWRkcmVzcyhyZXMtPnN0YXJ0KTsN
Cj4gPiAtCQkJcmFuZ2VfdHlwZSA9ICJJTyI7DQo+ID4gLQkJfSBlbHNlIGlmICh0eXBlID09IElP
UkVTT1VSQ0VfTUVNKSB7DQo+ID4gKwkJZWxzZSBpZiAodHlwZSA9PSBJT1JFU09VUkNFX01FTSkN
Cj4gPiAgCQkJY3B1X2FkZHIgPSByZXMtPnN0YXJ0Ow0KPiA+IC0JCQlyYW5nZV90eXBlID0gIk1F
TSI7DQo+ID4gLQkJfSBlbHNlIHsNCj4gPiArCQllbHNlDQo+ID4gIAkJCWNvbnRpbnVlOw0KPiA+
IC0JCX0NCj4gPiAgDQo+ID4gIAkJcGNpX2FkZHIgPSByZXMtPnN0YXJ0IC0gZW50cnktPm9mZnNl
dDsNCj4gPiAgCQlzaXplID0gcmVzb3VyY2Vfc2l6ZShyZXMpOw0KPiA+ICAJCWVyciA9IG10a19w
Y2llX3NldF90cmFuc190YWJsZShwY2llLCBjcHVfYWRkciwNCj4gPiBwY2lfYWRkciwgc2l6ZSwN
Cj4gPiAtCQkJCQkgICAgICAgdHlwZSwgdGFibGVfaW5kZXgpOw0KPiA+ICsJCQkJCSAgICAgICB0
eXBlLCAmdGFibGVfaW5kZXgpOw0KPiA+ICAJCWlmIChlcnIpDQo+ID4gIAkJCXJldHVybiBlcnI7
DQo+ID4gLQ0KPiA+IC0JCWRldl9kYmcocGNpZS0+ZGV2LCAic2V0ICVzIHRyYW5zIHdpbmRvd1sl
ZF06IGNwdV9hZGRyID0NCj4gPiAlI2xseCwgcGNpX2FkZHIgPSAlI2xseCwgc2l6ZSA9ICUjbGx4
XG4iLA0KPiA+IC0JCQlyYW5nZV90eXBlLCB0YWJsZV9pbmRleCwgKHVuc2lnbmVkIGxvbmcNCj4g
PiBsb25nKWNwdV9hZGRyLA0KPiA+IC0JCQkodW5zaWduZWQgbG9uZyBsb25nKXBjaV9hZGRyLCAo
dW5zaWduZWQgbG9uZw0KPiA+IGxvbmcpc2l6ZSk7DQo+ID4gLQ0KPiA+IC0JCXRhYmxlX2luZGV4
Kys7DQo+ID4gIAl9DQo+ID4gIA0KPiA+ICAJcmV0dXJuIDA7DQo=

