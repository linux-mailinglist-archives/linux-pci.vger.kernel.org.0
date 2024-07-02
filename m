Return-Path: <linux-pci+bounces-9578-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D02FB9239FE
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 11:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4161CB2241C
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 09:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8A91514EF;
	Tue,  2 Jul 2024 09:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="gZzAI2mN";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="JtYHwTVk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808DB1514DA;
	Tue,  2 Jul 2024 09:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719912524; cv=fail; b=SVE1ptt54yBlSmDEZqq75FvT6ZD01ppqyCK1sibGQs7zVKR+tiubIKUMIJHbJ1N5Cm2VG6E7xtsn5oH+ocJU6pVYKeppfkxxXkfEREs+KIBl8u+4rDGJWnZKgM1ZPMVF0ep9dhj6KRuc4UuKvih9bOV4pFq6N5oVZFjQ6MpU3I4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719912524; c=relaxed/simple;
	bh=Gf7VMiczRusE6G6Vgp3SWFPvuXl69EimGzYzy3EgAq4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C3r9HRqKoI+MjdnF6kt56djKzs7YSEBoeI7yDzTEuxJJ79wWQlSXcDzoyKFHiJdwirvjtUoY4rbOGoEWsbvzsLjC9VoQbDrKCOd+Rcdt/6P6byKQT1UxVF4lQSu5WSM9qaV5ue3VXEdSHinGHFSC+kFd5h4rceAYPNL8X0ef3NE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=gZzAI2mN; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=JtYHwTVk; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 76607a1c385511ef8b8f29950b90a568-20240702
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Gf7VMiczRusE6G6Vgp3SWFPvuXl69EimGzYzy3EgAq4=;
	b=gZzAI2mNlEbh7+8KZobr0a7UkbKhwkV1WBiiyAKj4t+X01wCHIzjShqAMWxPN24LBW1Zl6Y2NzBqBxYJA1xC8FjT7XyUVZBbm9IVhzHaB0K5IKoquTt4qAMHLbRPcwsEQNFuc66VmsDI41d06wMnpBPbhwZhf03Fng3uYYoXD7w=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.40,REQID:49d895fd-a000-4a01-bde4-ddd985257b31,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:ba885a6,CLOUDID:dab0fed0-436f-4604-ad9d-558fa44a3bbe,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 76607a1c385511ef8b8f29950b90a568-20240702
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <jianjun.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 952389402; Tue, 02 Jul 2024 17:28:38 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 2 Jul 2024 17:28:36 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 2 Jul 2024 17:28:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VqYRPY10/sBtLWZN3qvHJSrAvcfGcf/+ya0hHYhNYN6/0KSUaxUPxtjJaujxNCMBvARiRTSYUVQeBmOQho69PZku7DJYmxDibK6RNUGhes6K5yhRnxjmBJsH32mH2CMtE7TJc67PDcgzF+s2Zx5cRXm7JtB7bt2d4wiCadzVs3SgdZJvbaJbXo6pa611amvC/b6PPpmghfQ23D2ItNJNXueta1fosrt9VK51tI5EDgTbsHp80HMC2L1INgDQnFv8g0MG5Ow/genbCvhz8dGppZ/pGDcJizXE+o5t19S058sLlA7DLPv8B1vwVxAyWIX1keT9QbRe08GCEefsZJ99Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gf7VMiczRusE6G6Vgp3SWFPvuXl69EimGzYzy3EgAq4=;
 b=ggENhZdLLG8QvDl5LnUDdqZPpIsZ4lieKvp9FL34lvDivKRc3J3z9CstCgbNXdcS6lz3sVTHGrjCChi+8piH/q8yaHRFJGbQ5pHLPMNwZYdUuwokN4a1xs9l6QBpcLjqCCGkqPjahooPi4KE23ExwHS/cWSQq1lxGglFsWHXZJI3nknroQWtZ2uWiz3Ti08/qeAUnIB7KzzS/fo07SpMRtuNK0Acj+NHJOlW3ffSYybFkXgHHmAZ4r3dJlHT2RWHZVTzhCiMRMymIJ2NAC3HgmUH/0+eXvopHpGtQFVElB82jktmP7Cw0Ck/rMG+hGryD4gmrVNwKxTCCgWUL3s8Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gf7VMiczRusE6G6Vgp3SWFPvuXl69EimGzYzy3EgAq4=;
 b=JtYHwTVkvJjSVBJm16bBUECtII/pFJeauXmvcAdYsr5YwnvfoWpDToZhtZQccKbZ2SpV3lhFAAomIS593BDmjJmbhvMT3BXaJ3ebDS8wNdhKhCJh1EJ/dyEOJCno6aCLbUWq/dckLHspJAyMLQu60ARzsyZ4DxSXdwoErZhGU4M=
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com (2603:1096:301:17::5)
 by KL1PR03MB8011.apcprd03.prod.outlook.com (2603:1096:820:101::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Tue, 2 Jul
 2024 09:28:34 +0000
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::1c6e:6591:5151:27e6]) by PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::1c6e:6591:5151:27e6%6]) with mapi id 15.20.7698.025; Tue, 2 Jul 2024
 09:28:33 +0000
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
	<bhelgaas@google.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"Ryder Lee" <Ryder.Lee@mediatek.com>, "lorenzo.bianconi83@gmail.com"
	<lorenzo.bianconi83@gmail.com>, upstream <upstream@airoha.com>
Subject: Re: [PATCH v3 4/4] PCI: mediatek-gen3: Add Airoha EN7581 support
Thread-Topic: [PATCH v3 4/4] PCI: mediatek-gen3: Add Airoha EN7581 support
Thread-Index: AQHayiuwAamxp67ZEEaJ8gbta946HLHjMBEA
Date: Tue, 2 Jul 2024 09:28:33 +0000
Message-ID: <d04c396556612307b690c07a9b3fda7f0d4238ee.camel@mediatek.com>
References: <cover.1719668763.git.lorenzo@kernel.org>
	 <27d28fabbf761e7a38bc6c8371234bf6a6462473.1719668763.git.lorenzo@kernel.org>
In-Reply-To: <27d28fabbf761e7a38bc6c8371234bf6a6462473.1719668763.git.lorenzo@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5365:EE_|KL1PR03MB8011:EE_
x-ms-office365-filtering-correlation-id: 894fc246-6535-4907-bbda-08dc9a795809
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WTlOWE9uRXkrV3V4Mk16OXVtK3E4QnB3eDM0QTNNVi9oVjMyUmJYRXNIUXNN?=
 =?utf-8?B?SEplWUhHWmRSUHU2WmZxMWhBVUlLa0kzM2c1UThwZ2xWT0xDaERxZThsaEkz?=
 =?utf-8?B?SGJkVHZPRGVvZXpZZ1VnL2ovNXVaWm1RZmRrVXJDMjVJN01jMFhxKy9MODJX?=
 =?utf-8?B?aWYvTWJRTDBQNjM0aElPRGVhYTNWSWVGbmIvNkVZQ2lIYVRWRnhXL3JCbVB4?=
 =?utf-8?B?UlhnQTFwUng3YkxYRlluTDJDb2RyTU8yMm1FNFM1bmFYWWtSa3k1TDM4VTFh?=
 =?utf-8?B?QVdQenRpZCtjQ0pJVXFQVlJ4Q0FYZitiUlFmckk4cUg2b1RycHgyY0J5K0U3?=
 =?utf-8?B?ZFpWdjh5cHJnUkxYRmJNZndudXd6MkZBK2E2R2VPSXVmeTUwNzd3eVNmK2lQ?=
 =?utf-8?B?b3ZLRU1FekxTMWZWcThZNFpWSHRPcnF5TTVWY0xoT0NSMXNOSHhQcXpTUUVD?=
 =?utf-8?B?WTZSUlhXNm1SdU14Z2dFMXJvV2hTSWJ0MTc2VXZxSVZISm9BdzJXU0c3RHIx?=
 =?utf-8?B?WFFpNWFUWFdCVi9hWlQ1M2crODVMV2Q3V2ZCNVMzZjB1b2tWRno2NEROVDh3?=
 =?utf-8?B?S2wwYVpaRUpNcy9HekE1WUc0U0MyS09DeDU3aGtLVVFrY2wyRWdTSGlGU29q?=
 =?utf-8?B?WHdVT29SaUdOdFQxVjdDMEpzeTRLRS9IaUpUYlBGRFYySytKc0hLM2F2Wk5u?=
 =?utf-8?B?OTBpeFFYS01ZcWFZOXcwQU9QVWZPQW1VcUNCbDhhWDU2cjhqc2daVnR1UG1B?=
 =?utf-8?B?clkzc1MrdFlDMzNqWlFUVG9rbG9TTm03SW94RmJ4MWV1cFZLZ0tSNU96NDE2?=
 =?utf-8?B?WUtDRVhtZjEzWFF0UUprM0ZrMjZ0WTBmYTNQcWVSK3J5bVIwczJGSE4yakg3?=
 =?utf-8?B?MTMrWFdJZ1ZpVU1JaGl0VGNmc0d5UExZaytzN2pnRkNLVVJJdUg3WG9wRXc2?=
 =?utf-8?B?TmRqSnJsTXFjMlArclI1MEpKRUwxWThsR2pLdmdCSjg5NXIvdWZGY2hxaDBQ?=
 =?utf-8?B?RzV3eGw3cHFOR1g4T1lNQ0ZxUXJFdSttM0xsM0x2MTQrZTVJb0VHMjJwMzdm?=
 =?utf-8?B?T2Z3c0x3NlFWY21iRGtZK2tMVVptRS92Y0FHY0FlMWlvb3lGOGkwR21iV1dJ?=
 =?utf-8?B?ZGN6V0FJd050S09FYXlmRk5Ya3ZGdTFVdGpiYUxhK1NLd3YvemxPTWtmdXg5?=
 =?utf-8?B?c2VxVnViajkxRkFRVVNQTllIR2M2bk1BLzBRUUdyenJxMW4zaVlWaDQ5blh2?=
 =?utf-8?B?Wi9ZVWdDVG1rd0NKdlFUalZ1TS9Vdkgxa2hxSkJ0TkxJaHlxOEdhR1NuYkRy?=
 =?utf-8?B?eDlEdStBQmpHdFdxRW9ySlFzd0dqYndqQnFNMkc4emVIT0N3NDI2SUF0QkM5?=
 =?utf-8?B?RjVtaUZsREZRa0tRQ09rMHBZbStYV0N2ZVBsLzRmRHp2UEtQczZyUXdidWE0?=
 =?utf-8?B?QkUzYm5GMWp5cWF1Vk4vbzdZWVZ3Wm1CRkl4eFhWSHVSYWFTaFRsVDlZMDFF?=
 =?utf-8?B?RXUvZkxHYWk3SlVvbTJXSCtBQkl6RW5seXd6RnQva3RKTUkxbDlCczJGL2JJ?=
 =?utf-8?B?b0RtMnZ0TDhDUnordlFRcm8xd1FxT2JZSTRCTlZlTHN1RC80UHFScTV2MnFS?=
 =?utf-8?B?T2dCcUYxa1ozYmJyNVFVWmJML1Q3MERLWnBjOEk1SnE3ZTlkR0dLa3Rjcmxj?=
 =?utf-8?B?SmE3V0tWV2ZkNEVEbi9lQmtyTStCWHhuaDBJbE9kVHcxbXRoSDNoMHNuNkxT?=
 =?utf-8?B?K1RGSTI1TDlwUUc2TllVM0xIQlY2STk5OEdCdlRYUEJPRE9Td1BFOVVOM1Jx?=
 =?utf-8?B?Mm5kZktUV2xWZTdKRWxHWUZ6RWlzN0RlWWduY3RTdFNyUVYrQ0FJakhEeW00?=
 =?utf-8?B?TmFZdjY5Z0ticms0eGJjaEJpVnJKVWI1eVVvQlRETVNUd2c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5365.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MytaZGJqTTBteE9aQlZYN3V1cjQ1MklHN21LMjJGRXRCWDJIVFFmMlVmdmx2?=
 =?utf-8?B?Rk5YUElnamJ4UE1DcEFQdVJkQ2JmZGJqeW5EVVlEUTZDUzI0QkdPZEVhMFA3?=
 =?utf-8?B?aGdqWTdRNXQ5VWdoRWl6NDZFMmVaSmdzSVByTEJRSWx3TUw0MmlWYVRERUxN?=
 =?utf-8?B?amgyUjRGc2szb1JUNm90aHZkcFBCSFQzbjZvemFobFNtSDJnNUg3UHM1dXBo?=
 =?utf-8?B?OFdSU3dYank5ZzBacytNMnNXQ0ZLdWU3eGxHQnNlUmhqOU9zRWxqaHlBclUx?=
 =?utf-8?B?aEZ6OVJ0cU82SDUrOFZOSVVkRGwrWkx0cWJ0TnErYXd1T05tbXhoYUQwbThn?=
 =?utf-8?B?L1lLeFBWZkVPeXl0R1FUSmV4YWF1ZXFBS3JuUzJyL2luQjFUQTZ4VlFmU3FM?=
 =?utf-8?B?NStDNDZlQUw4TEFyK2U4anFxa0wvVDhZa29nVHpLNVRjWkN0TDZESzY3YS9I?=
 =?utf-8?B?Tk9nVW1rV2VrdmxvZnFLTUNJL2pLR1NhcVh6aUJ0OHZsaHlueWtPQ01RRVMv?=
 =?utf-8?B?aTB6NTAyc3JZNnMyS3FHaGxsRjJNZU1ZcUxsbUh1VU1BUHUxRFFBSG5ocDVn?=
 =?utf-8?B?K3ZIL1FjUmdDR1owY2JwdWRIZi9kSlZLWkNRb1g0M3lwU1F4Q1BOdlB4a1Iw?=
 =?utf-8?B?MDBmWWxvVlRONDJLMmRHMkRnbkVkRUthUXhTM2JtV0h5OEx4ZnRBY2l5WENB?=
 =?utf-8?B?OHJtU1RVUU0rcTliWmNMMEQ0MkIyczhqMkt6VVVMMmN0UFdGTG1mRnhEL3dC?=
 =?utf-8?B?ZjVMUXhnWjRkV0dzMTlsZVNvRG1JVEZmMktjUlF1bFQzSXQ0VjJWa3RnWTNn?=
 =?utf-8?B?Q1VFMHVESzZ4a0R3SVFSUUd5c0lVWFp6UE9LSzFvcXVqb0lMVVhkTk5CeTZO?=
 =?utf-8?B?cW5LWXMwTTJpWEFlOXN5aE8xL3huTGw2MFFPR0ZtMm9JN2NNTEpTcEV3RExy?=
 =?utf-8?B?RFl2WnNtMXg1ckNGdmsyYm9zNVd2WW5GMWoxRzcxdzNZRTdXdXhmb2JCYW9i?=
 =?utf-8?B?dVJXU2xvaFgvR3JoK3ozZklmbnBsZjJrVmlSaWV2M295NXRadWJNYStxajFk?=
 =?utf-8?B?b2NibEx4dWtscGZXbkJwdUlHNmdueXRCZktGK0J6UnVWMVVnKysxTXFmWkNr?=
 =?utf-8?B?RG5vbms1azhPSTNQdnl0cEovVDFSY09KTjdFd1IxK1FQZGFxczdudWV4QnF5?=
 =?utf-8?B?ckY2VGREclhpOUV2N0E1amZTRWp2c2dmcWIxcmRqblN4NDM5YzVQR0J2WkU4?=
 =?utf-8?B?UlgvTGdWK1pKYlhGL2c4N3d4WkdFeDhRQWR1L1M2UTRSR1g4SnhDdTBRVUgw?=
 =?utf-8?B?bS9KNjhTVTVJckNFaVlWQ0xYWHhWVGJCbDQwNC9LWTlNZjM2SmE2dHdaQWNz?=
 =?utf-8?B?QmNSOVVwRzBWY2gwUllQc1dBbmJBbzFCTUhPL0FLVXJMZ0pkdS9OZlBrb1Na?=
 =?utf-8?B?RkJaK3RNM2pPYUhOL0U2UTd5aXpIdm1ya3A1ODJSODVSeExSclVrWktxV2hB?=
 =?utf-8?B?QytYdlQvVi9GVnpZekw0VjBTZWpuYStPYUlyRWlORGxQVk5qUU5rM1VEMmlU?=
 =?utf-8?B?Qmd2dEN4QWlTZDBKUEt1SFJWdUFwV0hmVi9wb2kzK0x1RFNVekJ6TXJCYUpL?=
 =?utf-8?B?RlkyOEc2dG83Vlc2OWpDZzNBUVZvN0o2eGF3UFJHRVJJZ3JXZURwQnpEQmZz?=
 =?utf-8?B?VlFjZmhkTE5hUldwZTJjTWpPS2FnWE1kRUVhbERsUkg3dkdjRjNTb0YyWDRo?=
 =?utf-8?B?WVJGZDB5dzVWdFBWaU1Ba1FGbnQ4bnBMQ0dSY0liQ0NoWmRHM2huWHZTZktj?=
 =?utf-8?B?L3o5YUlTQ0I2U3R2QWdRQ2d1dkJOUTJ4STVYUzJXeEwrZGUrdXNmQ2lEZ08x?=
 =?utf-8?B?cUxNYUNPcm5lbHkrSkVROG82d1ZvakRUN2pMWTZFdncrTld3Mmd2QklFMXBD?=
 =?utf-8?B?V3NTeGY1bmpjc3FqWWJEN21PWXVlNkx3MU5oMklnZzYzckVwM2Q3RGUzMTF2?=
 =?utf-8?B?S3dFcldxQURYZG5UU0J1dFhpZHJwb2ZOOUZXT1RsWThXUnZyeHVhVGkvdjNr?=
 =?utf-8?B?QmdwUUU3NWZvd3hUOTJoWnlSVk8wbU5pbWVuOHRoN2RUTk53QU5FWEhEVm1U?=
 =?utf-8?B?RldSNFQzT2JWNENidy9iYWxXNjJsRVdxTi9OazFjTVhsWWFoaDJuNnlCQTMr?=
 =?utf-8?B?ZkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF3D3D710194A04A9BB0792641F0AE4E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5365.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 894fc246-6535-4907-bbda-08dc9a795809
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 09:28:33.8324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C510qHTOc9XJiQZcDlafDgEW4AMKWMGD+Et9ng6KQjaSKgtjKxt/VRXrFmsudJeJrQ3PeTDtoKGzEG6C5J0ilNXuKEQU62a321NMYMHuAiA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8011

T24gU2F0LCAyMDI0LTA2LTI5IGF0IDE1OjUxICswMjAwLCBMb3JlbnpvIEJpYW5jb25pIHdyb3Rl
Og0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9y
IG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBv
ciB0aGUgY29udGVudC4NCj4gIEludHJvZHVjZSBzdXBwb3J0IGZvciBBaXJvaGEgRU43NTgxIFBD
SWUgY29udHJvbGxlciB0byBtZWRpYXRlay1nZW4zDQo+IFBDSWUgY29udHJvbGxlciBkcml2ZXIu
DQo+IA0KPiBSZXZpZXdlZC1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gPA0KPiBhbmdl
bG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQo+IFRlc3RlZC1ieTogWmhlbmdw
aW5nIFpoYW5nIDx6aGVuZ3BpbmcuemhhbmdAYWlyb2hhLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTog
TG9yZW56byBCaWFuY29uaSA8bG9yZW56b0BrZXJuZWwub3JnPg0KPiAtLS0NCj4gIGRyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvS2NvbmZpZyAgICAgICAgICAgICAgfCAgIDIgKy0NCj4gIGRyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvcGNpZS1tZWRpYXRlay1nZW4zLmMgfCAxMDgNCj4gKysrKysrKysrKysr
KysrKysrKy0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgMTA4IGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9LY29uZmln
DQo+IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9LY29uZmlnDQo+IGluZGV4IGU1MzRjMDJlZTM0
Zi4uM2JkNmM5NDMwMDEwIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL0tj
b25maWcNCj4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9LY29uZmlnDQo+IEBAIC0xOTYs
NyArMTk2LDcgQEAgY29uZmlnIFBDSUVfTUVESUFURUsNCj4gIA0KPiAgY29uZmlnIFBDSUVfTUVE
SUFURUtfR0VOMw0KPiAgCXRyaXN0YXRlICJNZWRpYVRlayBHZW4zIFBDSWUgY29udHJvbGxlciIN
Cj4gLQlkZXBlbmRzIG9uIEFSQ0hfTUVESUFURUsgfHwgQ09NUElMRV9URVNUDQo+ICsJZGVwZW5k
cyBvbiBBUkNIX0FJUk9IQSB8fCBBUkNIX01FRElBVEVLIHx8IENPTVBJTEVfVEVTVA0KPiAgCWRl
cGVuZHMgb24gUENJX01TSQ0KPiAgCWhlbHANCj4gIAkgIEFkZHMgc3VwcG9ydCBmb3IgUENJZSBH
ZW4zIE1BQyBjb250cm9sbGVyIGZvciBNZWRpYVRlayBTb0NzLg0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9wY2kvY29udHJvbGxlci9wY2llLW1lZGlhdGVrLWdlbjMuYw0KPiBiL2RyaXZlcnMvcGNp
L2NvbnRyb2xsZXIvcGNpZS1tZWRpYXRlay1nZW4zLmMNCj4gaW5kZXggNDM4YTUyMjJkOTg2Li5m
M2Y3NmQxYmZkNGMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1t
ZWRpYXRlay1nZW4zLmMNCj4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1lZGlh
dGVrLWdlbjMuYw0KPiBAQCAtNyw2ICs3LDcgQEANCj4gICAqLw0KPiAgDQo+ICAjaW5jbHVkZSA8
bGludXgvY2xrLmg+DQo+ICsjaW5jbHVkZSA8bGludXgvY2xrLXByb3ZpZGVyLmg+DQo+ICAjaW5j
bHVkZSA8bGludXgvZGVsYXkuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9pb3BvbGwuaD4NCj4gICNp
bmNsdWRlIDxsaW51eC9pcnEuaD4NCj4gQEAgLTE1LDYgKzE2LDggQEANCj4gICNpbmNsdWRlIDxs
aW51eC9rZXJuZWwuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCj4gICNpbmNsdWRl
IDxsaW51eC9tc2kuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9vZl9kZXZpY2UuaD4NCj4gKyNpbmNs
dWRlIDxsaW51eC9vZl9wY2kuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9wY2kuaD4NCj4gICNpbmNs
dWRlIDxsaW51eC9waHkvcGh5Lmg+DQo+ICAjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNl
Lmg+DQo+IEBAIC0yOSw2ICszMiwxMiBAQA0KPiAgI2RlZmluZSBQQ0lfQ0xBU1MoY2xhc3MpCQko
Y2xhc3MgPDwgOCkNCj4gICNkZWZpbmUgUENJRV9SQ19NT0RFCQkJQklUKDApDQo+ICANCj4gKyNk
ZWZpbmUgUENJRV9FUV9QUkVTRVRfMDFfUkVHCQkweDEwMA0KPiArI2RlZmluZSBQQ0lFX1ZBTF9M
TjBfRE9XTlNUUkVBTQkJR0VOTUFTSyg2LCAwKQ0KPiArI2RlZmluZSBQQ0lFX1ZBTF9MTjBfVVBT
VFJFQU0JCUdFTk1BU0soMTQsIDgpDQo+ICsjZGVmaW5lIFBDSUVfVkFMX0xOMV9ET1dOU1RSRUFN
CQlHRU5NQVNLKDIyLCAxNikNCj4gKyNkZWZpbmUgUENJRV9WQUxfTE4xX1VQU1RSRUFNCQlHRU5N
QVNLKDMwLCAyNCkNCj4gKw0KPiAgI2RlZmluZSBQQ0lFX0NGR05VTV9SRUcJCQkweDE0MA0KPiAg
I2RlZmluZSBQQ0lFX0NGR19ERVZGTihkZXZmbikJCSgoZGV2Zm4pICYgR0VOTUFTSyg3LA0KPiAw
KSkNCj4gICNkZWZpbmUgUENJRV9DRkdfQlVTKGJ1cykJCSgoKGJ1cykgPDwgOCkgJiBHRU5NQVNL
KDE1LCA4KSkNCj4gQEAgLTY4LDYgKzc3LDE0IEBADQo+ICAjZGVmaW5lIFBDSUVfTVNJX1NFVF9F
TkFCTEVfUkVHCQkweDE5MA0KPiAgI2RlZmluZSBQQ0lFX01TSV9TRVRfRU5BQkxFCQlHRU5NQVNL
KFBDSUVfTVNJX1NFVF9OVU0gLSAxLA0KPiAwKQ0KPiAgDQo+ICsjZGVmaW5lIFBDSUVfUElQRTRf
UElFOF9SRUcJCTB4MzM4DQo+ICsjZGVmaW5lIFBDSUVfS19GSU5FVFVORV9NQVgJCUdFTk1BU0so
NSwgMCkNCj4gKyNkZWZpbmUgUENJRV9LX0ZJTkVUVU5FX0VSUgkJR0VOTUFTSyg3LCA2KQ0KPiAr
I2RlZmluZSBQQ0lFX0tfUFJFU0VUX1RPX1VTRQkJR0VOTUFTSygxOCwgOCkNCj4gKyNkZWZpbmUg
UENJRV9LX1BIWVBBUkFNX1FVRVJZCQlCSVQoMTkpDQo+ICsjZGVmaW5lIFBDSUVfS19RVUVSWV9U
SU1FT1VUCQlCSVQoMjApDQo+ICsjZGVmaW5lIFBDSUVfS19QUkVTRVRfVE9fVVNFXzE2RwlHRU5N
QVNLKDMxLCAyMSkNCj4gKw0KPiAgI2RlZmluZSBQQ0lFX01TSV9TRVRfQkFTRV9SRUcJCTB4YzAw
DQo+ICAjZGVmaW5lIFBDSUVfTVNJX1NFVF9PRkZTRVQJCTB4MTANCj4gICNkZWZpbmUgUENJRV9N
U0lfU0VUX1NUQVRVU19PRkZTRVQJMHgwNA0KPiBAQCAtMTAwLDcgKzExNywxMyBAQA0KPiAgI2Rl
ZmluZSBQQ0lFX0FUUl9UTFBfVFlQRV9NRU0JCVBDSUVfQVRSX1RMUF9UWVBFKDApDQo+ICAjZGVm
aW5lIFBDSUVfQVRSX1RMUF9UWVBFX0lPCQlQQ0lFX0FUUl9UTFBfVFlQRSgyKQ0KPiAgDQo+IC0j
ZGVmaW5lIE1BWF9OVU1fUEhZX1JFU0VUUwkJMQ0KPiArI2RlZmluZSBNQVhfTlVNX1BIWV9SRVNF
VFMJCTMNCj4gKw0KPiArLyogRU43NTgxICovDQo+ICsvKiBQQ0llLVBIWSBpbml0aWFsaXphdGlv
biBkZWxheSBpbiBtcyAqLw0KPiArI2RlZmluZSBQSFlfSU5JVF9USU1FX01TCQkzMA0KDQpTaW5j
ZSB3ZSBoYXZlIGFscmVhZHkgbW92ZWQgdGhlIFBIWSByZWxhdGVkIHNldHRpbmdzIHRvIHRoZSBQ
SFkgZHJpdmVyLA0KY2FuIHdlIGFsc28gbW92ZSB0aGlzIGluaXQgdGltZSB0byB0aGUgUEhZIGRy
aXZlcj8NCg0KVGhhbmtzLg0KDQo+ICsvKiBQQ0llIHJlc2V0IGxpbmUgZGVsYXkgaW4gbXMgKi8N
Cj4gKyNkZWZpbmUgUENJRV9SRVNFVF9USU1FX01TCQkxMDANCj4gIA0KPiAgc3RydWN0IG10a19n
ZW4zX3BjaWU7DQo+IA0K

