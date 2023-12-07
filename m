Return-Path: <linux-pci+bounces-605-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4B78082C0
	for <lists+linux-pci@lfdr.de>; Thu,  7 Dec 2023 09:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68489B21B42
	for <lists+linux-pci@lfdr.de>; Thu,  7 Dec 2023 08:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCC91E4BB;
	Thu,  7 Dec 2023 08:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="KORW4T3N";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="cf6PUSgX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2CF10FF;
	Thu,  7 Dec 2023 00:19:05 -0800 (PST)
X-UUID: 4704b50094d911eea5db2bebc7c28f94-20231207
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Q8TSTDcgrP1vvR/xkaL8bBhunUNpUtzGVt4e4pM0Up4=;
	b=KORW4T3NvoORiKMp2Q270QXoSbWbn0aXg8vt4adIYwaT9fiD6OzYPxE82cCLZR41qLRRFwQRF8MUBDhIwMd9p2d0T4/yliCTug7mqM4U3b0GteGnbysEugpmNiQqLWZy/pm60yQUtp4pLMvs8M8TQ4gLkGPVdwsS5haJcvmVeq8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:165c9f1d-7009-44f5-bbec-803151221700,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:83eaeb60-c89d-4129-91cb-8ebfae4653fc,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 4704b50094d911eea5db2bebc7c28f94-20231207
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <jianjun.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 218695821; Thu, 07 Dec 2023 16:19:01 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 7 Dec 2023 16:18:59 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 7 Dec 2023 16:18:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VHe1/VA462jZvqTUAu3X4nHysHpsecQIasueytfTjPvRW2q7QL/nfrL7vUi1V98/OFEmkhGZf4cw4ftBdR87QliW64Uivd0zGMQQYq8gRppbe9jCb0duhF3x3zkgIX5Kw5Uh7BfjuWvXuKc97EULhjxTQSkHSdmCRJTEoiLcv9tXEbsHO5hF3mcw/BobPxpERkEKlA0zMNEOG+cGJxa+PWf923R4r/JCD+toHVNnG66QSHnMEbCkGNFb9dzVz92oT8ubT2wdKlg3TRE2p9lzCgN9SLAyTwuZjOwSdjRl/xSwmKnPZoVw0HE/h9hmRmB2PJJa90vQYHw87yozjkEjhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q8TSTDcgrP1vvR/xkaL8bBhunUNpUtzGVt4e4pM0Up4=;
 b=L/Ucs29sbacrAPrgjzUhM7T8N5UwnFFwOPzcaj/JOZfipzrGZJULOmzfm8Jir1ZNitU/HWvKcM/g8SP9zPOpOEXqJrNrH6YXxw9V/PJWfgCH4jAxiDH6tSz3lGG0LoRaRsdC3wQBTDX9MnDBIhe3OpgiQEVPbJHoVhgJTaXyEkl95zWJYSkPV9ssedbtiybMmPflA0PbuJ/+uzo6jzE24isreHVTFW7BG7ol/QssTysYg7jfLq5XftkELFo9ZwPCfCglvw3MEHxtFVJL4D02JcaA2aMD3Sd6Rp13wDcSkAnoQmGUfN4wz1x/f4vDmtlfLE0VWVT5+W0deH4miH0+Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8TSTDcgrP1vvR/xkaL8bBhunUNpUtzGVt4e4pM0Up4=;
 b=cf6PUSgXb1WDK/VA/MZ94qFnKLGEPlTjEOTNGTkbrCBc7ROpjVVnO6eNlbKt0WPPuQ31rXKXdBI1JXnyeZmxfEUFWjK1pXau+juziJx1Jz80T+cERNRvWOpwssW2XmlEOg4GGyc6e/aSvo2BaZQXKT5kBuQdg7D1rLOIkOTQiWI=
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com (2603:1096:301:17::5)
 by JH0PR03MB8209.apcprd03.prod.outlook.com (2603:1096:990:49::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Thu, 7 Dec
 2023 08:18:57 +0000
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::bad5:5c99:1d71:2631]) by PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::bad5:5c99:1d71:2631%4]) with mapi id 15.20.7068.025; Thu, 7 Dec 2023
 08:18:56 +0000
From: =?utf-8?B?Smlhbmp1biBXYW5nICjnjovlu7rlhpsp?= <Jianjun.Wang@mediatek.com>
To: "helgaas@kernel.org" <helgaas@kernel.org>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?SmlleXkgWWFuZyAo5p2o5rSBKQ==?= <Jieyy.Yang@mediatek.com>,
	=?utf-8?B?Q2h1YW5qaWEgTGl1ICjmn7PkvKDlmIkp?= <Chuanjia.Liu@mediatek.com>,
	=?utf-8?B?SmlhbiBZYW5nICjmnajmiKwp?= <Jian.Yang@mediatek.com>,
	=?utf-8?B?UWl6aG9uZyBDaGVuZyAo56iL5ZWf5b+gKQ==?=
	<Qizhong.Cheng@mediatek.com>, "robh@kernel.org" <robh@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>,
	=?utf-8?B?Smlhbmd1byBaaGFuZyAo5byg5bu65Zu9KQ==?=
	<Jianguo.Zhang@mediatek.com>, Ryder Lee <Ryder.Lee@mediatek.com>
Subject: Re: [PATCH 1/2] PCI: mediatek: Allocate MSI address with
 dmam_alloc_coherent
Thread-Topic: [PATCH 1/2] PCI: mediatek: Allocate MSI address with
 dmam_alloc_coherent
Thread-Index: AQHaKB+QRiugv6/R9kOlVTki4BCl/7CcfTmAgAD+kYA=
Date: Thu, 7 Dec 2023 08:18:56 +0000
Message-ID: <5d289553a49274c92ce12eb63735cea2f1bf8bf1.camel@mediatek.com>
References: <20231206170747.GA718062@bhelgaas>
In-Reply-To: <20231206170747.GA718062@bhelgaas>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5365:EE_|JH0PR03MB8209:EE_
x-ms-office365-filtering-correlation-id: 719a1200-cd80-4e8f-34f1-08dbf6fd2834
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q1GcbqE1bthUIMAm5uf8tkzJh0nm6eQO7Oaxt4lh/s8k3SC+j0aZC4FbjAQvZ16mYEEXcsdput9QZWAkWxMxOYrWSesw4AdXluIFJtGVlwDG/+jRtE5wbuTQCnUijlFkjhgVTLyWrVHz5RFRLW2+z1dWuC4J4chhyqAl3nNe/aWZQzmKSE6F7P/39b17jgPPXT2tqU9vx3tR8GEbEMvLJlI80XYq+kxI2kAvK61Sl/aXllj9fjl1kf48dBMLjg+EbByymfGsbhqAn2t6kKBivZun8e3kRfHZPdEMlQSeS0Q2pG2QjladEPHlqWc7QIObN5XsQ9Vhri2SpcT2e/aS+VW/kzzyc4uxxlbpZ4Z5qXQxlMxKTaXTYJBMr6lko2dS55tqxzmzAwVsfAEv4sFw4TPGKdw/H9iCuN3b4y7YWeE3uMp4J1l1BxjqLOnmpv9eT/AFY+uzj80o9hQVduSsofGsPL8gmzR8PevFYCHWDpX9j/CgTphIPuzIES0eKJl25llDLnrgMAlTcDL7xMLrFtnh8PqChbNNWfIzyHogIxoO8TDVTtqoq7ffoZ/qkQ549SBApmP0oDZN6qOv1vf2/lxF7vH78LXgsF7PFvVBiMA3i56q5K53zuHPEYnAoopSpuy6x7g0/Mr8oP3TDjPSX8SOp66BnSKwRQG95Q69aN8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5365.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(136003)(366004)(376002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(36756003)(38100700002)(7416002)(122000001)(2906002)(85182001)(41300700001)(5660300002)(86362001)(6486002)(26005)(107886003)(71200400001)(91956017)(6506007)(6512007)(2616005)(478600001)(8936002)(8676002)(76116006)(66946007)(54906003)(64756008)(66446008)(66476007)(4326008)(316002)(6916009)(83380400001)(66556008)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q1dRelJuK3ovb2NteXJrTERjR1IzRUlkeGVkZW1vWldrUmtPcUhJaHo0ckIy?=
 =?utf-8?B?L2RHRWF0cVR6bmFiNWQvTTNNRFBCb25sTEc1YWVxSldGdXVDMFg3aXd2M3pl?=
 =?utf-8?B?T05BZ3VhaCtjOUQ5eVFEY0cybk04MjZ0em5tdU1FaUxVeVl0UjA5d2trUThY?=
 =?utf-8?B?TlhVSkpLSk9mQ3JYS2RCaDlKR0tqWnN6Zyt0UElPcXJnUm9VY1BWbXQyRVB5?=
 =?utf-8?B?amN5RXgzdnhnL2xhd3prelR0d2tNU09ad2YzV2xoWXhLM1h4K2VUeFNBby9Q?=
 =?utf-8?B?eUs4ejQ1cGdMOEUzekU3Tys2RmJrVTlndGI2bUxITWNLU0ZBdnkwY2NvYlVV?=
 =?utf-8?B?MnYvZmh4MW5GM0drclpBSkNONVA4Z3h4dXYvRkg3aHR1cXM2c25pNXJScFA2?=
 =?utf-8?B?QzNHWVhnVWc3d0lMYTRQMEh0cmlTR3hET3FHbXBXalJscnFpWmpWUDdnTHY5?=
 =?utf-8?B?YSs5NjBaZ2RGS2JCQVFNNnd3RG5IK09qNUhBU2pJZEU2ZlNKVXBMcG9pM0kz?=
 =?utf-8?B?Q1FoY2I5M2Z5YlRTNnVtUUU1aUdPMURpRlpTMjg5QnZiWTFlamlaZDMzSzIz?=
 =?utf-8?B?V2NFUzZxc21YSEpLTDM2OTExSi9wbnhGU000MW9YakgwMDJOMndJbk4wYU5x?=
 =?utf-8?B?K28wNU5tTEo5SGpwUVBHeWM5L3ArN3NFTG9WY2JTYk5ya2VoeTJ4R3dQeTZF?=
 =?utf-8?B?M2Jjd2luTmdxeUhvVEJkb0ZhYjlCbDFYUlhuUC9rUHliL2FsOUpWRnpRMWVD?=
 =?utf-8?B?aHVHelRjc29vYmdVSkVDRk85TTZxcDN0bU1VOHFVSmpUMmFYZW52VEowekpD?=
 =?utf-8?B?T1Y3NWUwVXkzUUl5SmM2Nkc3WHBTTnROTXpyaXlSZWJhSHVUZHN0Q3dHNFJZ?=
 =?utf-8?B?bHhBRW1yR3pXWGtOdUl1Qm92N2g5b1VocytCelhsdmlPSXBCQmZSSXVQMng0?=
 =?utf-8?B?SHpWcTRua1JicmZUaVR2d0Q2VFUySDBGT0NkbGZuRXFsZWpCdGlzWXVIcHA2?=
 =?utf-8?B?ZUp5VUkwQXJvVitQZ20wY1hiNnVjNThVckg4ZFRWQllpcFNJYnlXc1hJTGEr?=
 =?utf-8?B?WUI3S3llQ2l0U0dyK3M5ZFJUWlo3ZGYwSVVpbWFZS1hNZmpGQlIybk9VSm5q?=
 =?utf-8?B?NGZmTTNxelo1Qnl6ZldHUkJZdVViVzliRVJyVDlxU0RKOU9rRXdQamRCTWxZ?=
 =?utf-8?B?RTR1eE5Nbjdzcndtc3RDeVpTR1k0VEZqb3FRVE0yR0dYMUwyVzRmSElWaXd5?=
 =?utf-8?B?WEF2SE52WGgzVDU1WW55WU5XVjlqbk9UZVdIc0FPcDBwMC91RGNLWUNMQUw2?=
 =?utf-8?B?bS9wNmxQU2RzWUFzVDJaWm01ZktQSkxpbzdJaytJbjBHcFBlVnBUdG5rd05Q?=
 =?utf-8?B?TTVXV1NoREdaK3I3VnBOR0FJZWgySDVDWnB4bXJlNHlKNThxaWtHdUxxK3dT?=
 =?utf-8?B?SmVjTTNvd01PTzZ6Y2U2VHVxWGV3ay93K2JoU1l6dHFDbTM3MWhHU1JiTmc3?=
 =?utf-8?B?a3JhUTY5ZG56U3p0amxtZmNGQmx3YmxjZXVyZ3R2aW12WVR3UlN5aFMxTy9y?=
 =?utf-8?B?T1VWc1BKTGozc1hZNDNrZEc0dVQ5bFBudkl5NWF2V1pEVkJPUDFWVVIvekxo?=
 =?utf-8?B?VVJVL2JzRER3MWFkREtKK0swZ2lsT3JvMnluN3JPT1NIdXhLam9sdFR1ZEQ0?=
 =?utf-8?B?anlYdTNuT2pSUVZSaGR1L2hzVFFFNHk5bU84amNOQkplaWl1U2VXOHZxN1NZ?=
 =?utf-8?B?ODY4UjVOa0RsSTZrNlBGcDk5UVJlM2cvc0hzWHIrVGs1cW95ZG9ZWVJsaEsx?=
 =?utf-8?B?RDZPMlF0QWVUZy9iSncrRERzYkZsUTJDTEtHbW9nNGRTTythMk5lZTE0dlZ4?=
 =?utf-8?B?Z000R1o4TjZ3OWlvRXphcG1VeVNib1NyME5GQ0k3OU16Q2NReW9DaDhpODZW?=
 =?utf-8?B?dWVpdXJVUnc4YVhaT21oY0ZOZ3BEUlNOUTlMMWhnNThMMHVkandFeGlJZmdi?=
 =?utf-8?B?VnlwcHN1YnltUjUzTDlTYlVZc0NpRENZbVdYYVEyaVNRc003RUZhQS9YUGlo?=
 =?utf-8?B?YnZqbzlYNU4yUER0N1NRNE0wK1VreUF6aXNKRTZHZ2FNMHlJV1ZRTklWSCt3?=
 =?utf-8?B?VEFUaDlZWDUvc3FReFhhWC9wQUlYVC81MEhRWVRZOEtYaGg1UlVLSnVZSk43?=
 =?utf-8?B?ZkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4AA4E9054A967A4DA8F892623743E13B@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5365.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 719a1200-cd80-4e8f-34f1-08dbf6fd2834
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2023 08:18:56.4701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CP+w5SKeHsXRQKvnW72NSgqMwNWIZNdwDhwgi3wUe57/NXT2jbiBL4yO/AW4LRbc4TbJcMKosqrNA2+s3HTKq/hkRirkZzWyGeowDJY+2Mw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8209
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--12.967000-8.000000
X-TMASE-MatchedRID: w2TFuZOvAtfUL3YCMmnG4ia1MaKuob8PC/ExpXrHizyrmaMm8BwMJCpf
	0VJZhlxPIcDjxjCJglp/h7Ip5PWGrWc/On6gI+zzh2VzUlo4HVNA9T2hjmWWI7v408/GP5HqiXK
	bJK4FbCk7zzrzTKTxWP6HPbBy6Th1jyxvgNKrxKaZroPNdqiG830tCKdnhB58pTwPRvSoXL2ZMP
	CnTMzfOiq2rl3dzGQ1AWNzx+3BOqqxBTgoSLG5tsMpFSWdIWKol/wxSb/Yy+bPoesWyYPuxw==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--12.967000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	10B81604A001BFB2BBB7701EAF8ED324B60CE9DD47EF0E025741F42380622B0D2000:8

SGkgQmpvcm4sDQoNCk9uIFdlZCwgMjAyMy0xMi0wNiBhdCAxMTowNyAtMDYwMCwgQmpvcm4gSGVs
Z2FhcyB3cm90ZToNCj4gIE9uIFdlZCwgRGVjIDA2LCAyMDIzIGF0IDA0OjM3OjUyUE0gKzA4MDAs
IEppYW5qdW4gV2FuZyB3cm90ZToNCj4gPiBVc2UgJ2RtYW1fYWxsb2NfY29oZXJlbnQnIHRvIGFs
bG9jYXRlIHRoZSBNU0kgYWRkcmVzcywgaW5zdGVhZCBvZg0KPiB1c2luZw0KPiA+ICd2aXJ0X3Rv
X3BoeXMnLg0KPiANCj4gcy8nZG1hbV9hbGxvY19jb2hlcmVudCcvZG1hbV9hbGxvY19jb2hlcmVu
dCgpLw0KPiBzLyd2aXJ0X3RvX3BoeXMnL3ZpcnRfdG9fcGh5cygpLw0KPiANCj4gSW4gc3ViamVj
dCBhbHNvLg0KPiANCj4gPiBAQCAtNzMyLDggKzc0MCwxMSBAQCBzdGF0aWMgaW50IG10a19wY2ll
X3N0YXJ0dXBfcG9ydF92MihzdHJ1Y3QNCj4gbXRrX3BjaWVfcG9ydCAqcG9ydCkNCj4gPiAgdmFs
ICY9IH5JTlRYX01BU0s7DQo+ID4gIHdyaXRlbCh2YWwsIHBvcnQtPmJhc2UgKyBQQ0lFX0lOVF9N
QVNLKTsNCj4gPiAgDQo+ID4gLWlmIChJU19FTkFCTEVEKENPTkZJR19QQ0lfTVNJKSkNCj4gPiAt
bXRrX3BjaWVfZW5hYmxlX21zaShwb3J0KTsNCj4gPiAraWYgKElTX0VOQUJMRUQoQ09ORklHX1BD
SV9NU0kpKSB7DQo+ID4gK2VyciA9IG10a19wY2llX2VuYWJsZV9tc2kocG9ydCk7DQo+ID4gK2lm
IChlcnIpDQo+ID4gK3JldHVybiBlcnI7DQo+IA0KPiBJcyBmYWlsdXJlIHRvIGVuYWJsZSBNU0kg
YSBmYXRhbCBpc3N1ZT8gIEl0IGxvb2tzIGxpa2UgdGhpcyB3aWxsIG1ha2UNCj4gdGhlIGhvc3Qg
Y29udHJvbGxlciBjb21wbGV0ZWx5IHVudXNhYmxlIGlmIHdlIGNhbid0IHNldCB1cCBNU0ksIGV2
ZW4NCj4gaWYgZG93bnN0cmVhbSBQQ0kgZGV2aWNlcyBjb3VsZCB1c2UgSU5UeCBhbmQgZ2V0IGFs
b25nIHdpdGhvdXQgTVNJLg0KDQpUaGlzIHNob3VsZG4ndCBiZSBhIGZhdGFsIGlzc3VlLCB3ZSBj
YW4gc3RpbGwgdXNlIElOVHgsIEknbGwgZml4IHRoZW0NCmluIHRoZSBuZXh0IHZlcnNpb24sIHRo
YW5rcyBmb3IgeW91ciByZXZpZXcuDQoNClRoYW5rcy4NCj4gDQo+IEJqb3JuDQo=

