Return-Path: <linux-pci+bounces-10043-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4E592CAEE
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 08:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 801E11C21E67
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 06:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5D04174C;
	Wed, 10 Jul 2024 06:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="fdgGZNs+";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="nCQFN1Mc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC7B1B86FC;
	Wed, 10 Jul 2024 06:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720592587; cv=fail; b=J/2Uk1c1kHC4SjuYPbo+ZcBEQtbfRQyr4wpgPbtf2jIo5fTizmb+ZeJrem3bEId0oxR6+l1d2EHeLo/lxsGjKu8MKlF58Axd5qWvzkqoEwLM48c8yCKoZ9WEKqefFWVb6aROoCcw56kJ7zIU+l87xB5IICBvKYM88dvL/3WuHkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720592587; c=relaxed/simple;
	bh=v2k+F4r212jM3EyYX0/cOPGsyQHOe6QMFEJ9J29aLMY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tuMomH+RvX3/8PdkeLRZ8J3C7HuSIg7D3KdMo5gQPLrAe8BFrxqr4BYUWB6TSg2k1p05l9oM/LGyIftTnkvSN1kunYt1M107U6AnqFsUWkhEN2edS71mWNVwhJnnfhBxzwfHGH64cT99N+yPXibqdurmXBjgpfqA/2A7nq5izlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=fdgGZNs+; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=nCQFN1Mc; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d86a8efc3e8411ef87684b57767b52b1-20240710
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=v2k+F4r212jM3EyYX0/cOPGsyQHOe6QMFEJ9J29aLMY=;
	b=fdgGZNs+6VjYanbjnw1t5tcMd3+2QHJsBbrnuVbzNS84moa1X6TbbHSnPzVH0VIKtuMAxV9kJAPrm23Yp5rrOysL14cRHgI4yS1YL1VnfOMxWDmyncRFShxNqC/hjhpzK+ZbymPoeteXXyeQ8+96NsBWZ6m5f6gqL1R2qC/rtPQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.40,REQID:b314d279-e6ba-4261-88ad-d459fc1b69e6,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:ba885a6,CLOUDID:b5c2470d-46b0-425a-97d3-4623fe284021,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: d86a8efc3e8411ef87684b57767b52b1-20240710
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <jianjun.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1955066930; Wed, 10 Jul 2024 14:22:55 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 10 Jul 2024 14:22:56 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 10 Jul 2024 14:22:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NqJg/m4AZPUnt4+aEbBgAfDMsrpd31SvqayBKBGmBXcY3hhl0VaprUOE9KuDEp+FM1om8wWi+HgDYwWxKRr0XHf/hq1lsYO9uXNrqwJMhCXaFGwigQPx8CCbccEIGdXXGP+iL7xJzOGf3kMdcJj5jBrx0JrN2J34EbMk94qDyipxhRmnYmur2vzI7Pc1OkMFON1RHEVbo6GCOBCXNLzzzqCu8Uw1M5paNibrpwF/uwVMhEDbSWjR0/IOovqujlKWvTvV4GBIbU9d0Kx3AGMscXh44NQNsZ8wua7inAXRxwS7dhSahXPNNvZoWRUvgm2Z4Nm17J8yJs3sBNYizaTCvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v2k+F4r212jM3EyYX0/cOPGsyQHOe6QMFEJ9J29aLMY=;
 b=laL88t/ZDA3tLHsmzeGuQKTh7LQDc2lELIAJv3k1D5xAIgu+dGAunBoY1CtJK/JtVx96WJXzXeSjV6s43MKOyQhN9uPamZxnFRbk4BPcFSIO/F6dysgt8jHMT/VCndQNOPMSECb//Zqh8l1j7zvm0NiWQP1U0seVvVnPB8Yd7Yq3yQRabDtfQN2B7ghJYHc4ZyuQdI0b/LCwixcWhDFNVoe/pyZ+KhpZ2FX6oCT6JpbgXtx8YdS7Bkgwzix70DZmJhMQSBPB6i/ZWklQPkhlEmu5wXcmBk94EXIuWmjFt1zNeub/zi5DSCfLyhLckK+crXN9gI8BT0UiQSLYy605lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2k+F4r212jM3EyYX0/cOPGsyQHOe6QMFEJ9J29aLMY=;
 b=nCQFN1Mc1F2iEG9jlbHrJ++a86Z6SjXEKUSv4IdCdtdr6t3tzleyj3K3+Hl388PT2WEVieiX44hDiatQ7dfWnlPe7y4+UhK6XiydMT5DfalmK+sIFAcnF+Hr0t1gTHu64qEQWYoM9149ndDRi4PoFhV5XztHHmcxyka1LLYNyKY=
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com (2603:1096:301:17::5)
 by SEZPR03MB7266.apcprd03.prod.outlook.com (2603:1096:101:72::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Wed, 10 Jul
 2024 06:22:54 +0000
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::1c6e:6591:5151:27e6]) by PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::1c6e:6591:5151:27e6%4]) with mapi id 15.20.7762.016; Wed, 10 Jul 2024
 06:22:54 +0000
From: =?utf-8?B?Smlhbmp1biBXYW5nICjnjovlu7rlhpsp?= <Jianjun.Wang@mediatek.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "lorenzo@kernel.org"
	<lorenzo@kernel.org>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "nbd@nbd.name"
	<nbd@nbd.name>, "dd@embedd.com" <dd@embedd.com>, "robh@kernel.org"
	<robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>, Ryder
 Lee <Ryder.Lee@mediatek.com>, "lorenzo.bianconi83@gmail.com"
	<lorenzo.bianconi83@gmail.com>, upstream <upstream@airoha.com>
Subject: Re: [PATCH v4 1/4] dt-bindings: PCI: mediatek-gen3: add support for
 Airoha EN7581
Thread-Topic: [PATCH v4 1/4] dt-bindings: PCI: mediatek-gen3: add support for
 Airoha EN7581
Thread-Index: AQHazWP8tlr4XawJCESgP36K/WVuWLHmPC0AgAlMO4A=
Date: Wed, 10 Jul 2024 06:22:54 +0000
Message-ID: <e1a557e71ae51a8d7358aa29a5f07f22c30a643f.camel@mediatek.com>
References: <cover.1720022580.git.lorenzo@kernel.org>
	 <138d65a140c3dcf2a6aefecc33ba6ba3ca300a23.1720022580.git.lorenzo@kernel.org>
	 <90342fc9-19ed-4976-8125-f8fccc8d4970@collabora.com>
In-Reply-To: <90342fc9-19ed-4976-8125-f8fccc8d4970@collabora.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5365:EE_|SEZPR03MB7266:EE_
x-ms-office365-filtering-correlation-id: 082d567b-dab4-4460-6474-08dca0a8bb9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NFFtdUlqeUVodlArZlhqZWJ3algrcnFpUmZHTXM0WU9nUHoxUHUrWVFORTZx?=
 =?utf-8?B?WW5ZT3hjcmlzak1CNGlid2k0dDJYa0duQ2dnZ1R2bnMyTUlkN2ZRbE1aOWNp?=
 =?utf-8?B?ZUpKUTVuY050Q0F3WExRLzIwTktCZnphY2R0YWpoanpiRTR4RU9hdDhXZGUr?=
 =?utf-8?B?Mjg2bHpBeXNBanZYSVJ4S01LZk54VDB5YWZLam50bDdnY1Fmc20wQUJ2YU5Z?=
 =?utf-8?B?WE82aENpd0ZBQWxwczNSTVczS2Rxb0xNOXZWWjl5aHRsQ1hsdXFnandYU3ls?=
 =?utf-8?B?RTJHdS9KNmFVdk9oQ1VNaDNXZndoTkE1bWR5ZGhaZWo3QlJiUXNpRU1YVEpy?=
 =?utf-8?B?eTg0M1Z3VEN6S2g3R0wxUEY4U3RWVDE2QUNjMUx6YldGSElneDVxMG9KbkNV?=
 =?utf-8?B?SWhHbVhNamtUL2lhUDI0bm9EUUZLdk9ob2lySngyQ1FtUDNTNDhoUjVBY0hi?=
 =?utf-8?B?aFQyemVIdmE1U1B0WlV4ZnJKT3hwREdTSlhobTk3SUJDVldOcmVwUGZFNkhh?=
 =?utf-8?B?WVh0ck9yeFNoVCtQNk1VVWZ5VDNiWWY0L2hOdEVra0J3amJGK3FXc0QwWUR2?=
 =?utf-8?B?Zk9mSVNqK2ErZVpVeWMvZytCaGFtSUpTcCtNQjlLcU9jdWhFUlA2Q1c5QzZY?=
 =?utf-8?B?Z1RMWFpjam1MQTdyMXJuR2lReEFPNFFDN2J0Nll1MGprOTgxM0RTd3FPdWlt?=
 =?utf-8?B?MUtlMndMUnRSSGdxRlRUZGl4WHZrSkdzaGsyUTRRZ2Z4b2J5VzBmYWMzUWph?=
 =?utf-8?B?VDIydmZmODk4SlQzdlFCa2JRcnVtTm9MUStCOXEzcTF5RnFDN0JGR2xiK3lY?=
 =?utf-8?B?dGJjU05uTDhreEhvdDFlVnl3SE50OHU5UUtXNng0WTVkMi8wemc3c0R1cW9u?=
 =?utf-8?B?bUk1UlJLSmIxT1JkekY3VXYzQ1ZxWDdCYzNuSDVCVG5Pd201U05aVXY4eERJ?=
 =?utf-8?B?UU1yQ2RBSUNkcXBsZ3pweVlzcHo0Zm9rNnp0aTcyK29SOS9kWmpGOFlON1JR?=
 =?utf-8?B?SDRSTmp6YjE3T0g4Tk80RGE3OUlOL0Jnb0NRUVUrbXdFWDlrSklhVWJ1cEsz?=
 =?utf-8?B?cXcvLzFOeXcrWUFjY0lyQzNVdkVXMVVuUHI3N3BRK2xRS1FIYjdyME4rc2FD?=
 =?utf-8?B?RnV6NVFiY042dVB0S3Q4VU8renNBVm5xbG9lbnQ1dUZwVzdUb1FPQVY3M25F?=
 =?utf-8?B?Q3VMQ2JzMUxtNG1Mck1oY29SYmJxeHRIVGkwQlpvVXl2REpzRWc5Ym85MmMr?=
 =?utf-8?B?V3o0R2VvMFloaEw4THFzVmtRbFVvbnBpWmZJRkNtYnFmQkhwVHAyL3NzNFY4?=
 =?utf-8?B?Q0JvRDBpYXc3V0VEYXRIOEtyNytOeEJuYnZCREF6ZHNWWWRZU2ZQOVNYZ2kw?=
 =?utf-8?B?NUtiMVdlYzZPZHh6OExEL0J6MXZxMGlrNVNwT2xKOXlpclhENTdocVUrY1V4?=
 =?utf-8?B?N1BITFFseG9RRXhwaXg3dCtEa0hiSi8vVGdpZWZvYkY5aHc4WkpkRHl3QitM?=
 =?utf-8?B?YlZvU0J4bS9tVSt4ZEZxMlQyTzJtVi9PNFFoaUppU2hpM0p4enBYMjdsMnBP?=
 =?utf-8?B?bGlRZ0dXdWpmbkEySUhUa3dGZ254cFlIbS9rdWFzVVBsSVI5TjA2TXNseGhT?=
 =?utf-8?B?dWVXbm82U3lLQlNSSWpET2lTMDYydHE4YmlybTNLUklDdkE4dk8waDBuMTl1?=
 =?utf-8?B?U1AvbGY5MlQvNHFoL0NsRForbXRZd3lhUEZqRWtXVzBLa3JRdVBNZW83Nzh2?=
 =?utf-8?B?ekZmLzZCSmJkYnRIWGFxZzQ2eWdSYmhuR0dBRWNyODUzT1lXOTRSVVJZU0d0?=
 =?utf-8?B?UEhKTVYrQUJibk9XWnd1K2tPTWZzakdyMzVRZU85NE1qZEdNdGZXYnAwZk1n?=
 =?utf-8?B?Mk0yNy9BWXRrYXM2cTh0bnVSck1ObXVkZVU0ZkxkQWFOalE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5365.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K0J6WVR2QldjOUhiTVBSam0vY1d1emcycWRxcytzNDQ5U1c4K0UyY3ZLcXNT?=
 =?utf-8?B?aGRkYjdiY2xyY3l1RlNLL1psRXJ0Qm9kUktTVGFtbEQ0UW1PZkt5T3NJS2hC?=
 =?utf-8?B?ZUh2WWlJWHlKa1JhZnlubmswM2R0ZFhQajRoOHRCaWpHeGMxcldTVDhrWjkx?=
 =?utf-8?B?MHEwNjNhdWhLb3YrM0VpSVU1b3Q1VEVGVWVvQ3dnRjY2SEV1ay81RHhMYlEr?=
 =?utf-8?B?RU1rMzRqZ2ZQSEdtT2cwT29rb2poU1ZUc2FBWTlRdlNLSm9IaFppcUllaTl5?=
 =?utf-8?B?OFZLa1Z2YnUzdVlEWW5VZVdBaEU1ZGJJRVJBNFpnd2l0RzBhYk95ZDJiZFEy?=
 =?utf-8?B?bkFSSDVVNGlmZXA2d2QraVlpWEx3YnJ3em0yTWJkVnM0bzRaN3EyZzR3bHZ0?=
 =?utf-8?B?eWUzVGtjTEZKNHhYU0N6N25qTHVuSWFtUXE1UW8ycHFEM0ZmVlJ1c2xOL0FD?=
 =?utf-8?B?NzVNcFR4SEk5VG9OMDVycjBKS1FGU2dLOVBhV2p4SzdwUjdvK3ZYNE95eEJ5?=
 =?utf-8?B?KzkvNTcvWTEyaEMzSEFvT3drZEsvYW94clpRbml3UC9qMHhndlZmK2xQOHJi?=
 =?utf-8?B?UEYzLzM4YXh5b003bVh4WFFsSUIwRGw2c3hZZEFiOHF3TVJXa1Z5UjRtV01a?=
 =?utf-8?B?aHNKWW1QMXc5WVhTdmZLYzNRdStodHUzbXAzRmFRUlU5Q3I5TWJZeHdHUm1r?=
 =?utf-8?B?ZUtKQmlDZTh3S3NKdENDWkoxanBtSkxoTC9qZ2ZRVzQvM3dNdlprTStUcVNE?=
 =?utf-8?B?Z1ovTzEyWktHUFpkTjkyQTNzS0lsRnZVWG5TdzZHZGJ4SWRlT2V2WUZNV2c0?=
 =?utf-8?B?bVltajBORndJQzhYb3hpa0NGL0F2T3hRcnd0VDZIRTJ2ZnhORzB2c0pwL0RX?=
 =?utf-8?B?dWVjN0FEU21DdmVDVmtHR2dRN1Y1M2ZWODNNeEdzU3JVSk94QzlxN09EYTI0?=
 =?utf-8?B?YklEYS90QmVFYm5YUm4vK3J0YzVORC9tbkU3WGs5eUxjd2NHZnNCT2UzWkpQ?=
 =?utf-8?B?QVdOZ0lvTkRpN29sSlgwbko5TGY1UHRHLy80R3VKRWVnWllqVndjZGo1emdh?=
 =?utf-8?B?dTl6NXlhYlYyeWdCSEhCV1ZXN2RtTDJmR09HSjNIZXlqQUhVUHpMcXNsTmRt?=
 =?utf-8?B?Vjl3QXdYQldLZjhvbkxvaTJBL2VtbWxLKzZQaHMrdTUrTE5zaXN6V2VaZ0Js?=
 =?utf-8?B?WGhwZXpBSW8yc20yQ3RIVmQ3M3o4YkozVXh2OGVCTGt5TVNlaHBXbFhlOEtk?=
 =?utf-8?B?bDhQUVBBc0JZZ3VLY28rMXJlaHlpb2gyMUF4cncyWCtaM215SkZ2OWtERm9i?=
 =?utf-8?B?cElqbEdZYjZ1cm51TEVrWUpwOUVLazlGRlZBTEVBZ2JRTFkrSTRzWHVlbzNS?=
 =?utf-8?B?N0lDZkxlak5OUlF3bUptOXhWdkVFbHlDRmxoSlBLMEF0NXlVaUZOTHN5TVFi?=
 =?utf-8?B?TW1nVEUyN2g1M3JVcHM4b0JrQ0txRkswNkZRTVkyUWllWkFJaDUyKzd5clZy?=
 =?utf-8?B?L284azkvZGhNN0d1V2d3aE05Q3l4dnoxem9mQzIyWWVaTUI3Z2k4NzdMSVl1?=
 =?utf-8?B?U3IvWis2L0ZxUVJEUEZRM3FWWllNc3N0NWRpcXlnZGM5Um5RUUdYNm8vRlRL?=
 =?utf-8?B?aW9VbzUxdmpMa2VvcUlxeDZueHp3Ujk2dW9sUEgxeHRid0xNNFFlMk56VTZl?=
 =?utf-8?B?cXJ5K1dPOUdSNGxzQVRkcE53eFViMkMzVTNMdEwwRDg5eXFCVmRGbllYUGVq?=
 =?utf-8?B?QktVUWlZQ0VNNktPUCs2aE1IQXFZb1hrYzJqT3B1Z0xjZnJaMDczWmFSUU8z?=
 =?utf-8?B?RklaU1U5S1kwQ0tZMlhiYlU4OW9LUG5IcXgybGJnYzZrTlBrVzVJbUZueU8v?=
 =?utf-8?B?U3Zqc0hyRXY0NnhRODBjWnoxdlp4bmpXOWJOZHlGQk1oV2VrYUc0cEpsOTAx?=
 =?utf-8?B?bXdIQWpTUE0vSWZvcytudzJCdzNPRm9XcE9vd01MaDRvZEJ5bDQ4NjdDTTdH?=
 =?utf-8?B?SFJ4SFJMRU0xY1RsY3dYR2RiMUpYMDAzaWFtTDBqUGE4ZVdSMmhGcnhwOFFE?=
 =?utf-8?B?YWZKenF2VmVjWnFVN0hIR3QwRytGckVFaHQ1OTBiTTJVend0Q28yUDhOU2ts?=
 =?utf-8?B?ZHE5T29zM05oNWVXWk1neUMyWWhGTWc4aVNaZXZpbEdHOW5EVmpoZzZoUFhm?=
 =?utf-8?B?Wmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A815D25BC6CFF44F94FD799F453C843E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5365.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 082d567b-dab4-4460-6474-08dca0a8bb9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2024 06:22:54.2176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xfCikO3BkQ2CC69419ahVV79cp6+Z9Kgd+7c6jpEQdztdLf4L3WkqB+8RWNSbV40ncsx9YhWruhS3PkuDAoP/lliD0KRgmYyXxQkc8/7VcE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7266
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--9.735300-8.000000
X-TMASE-MatchedRID: mIinBA9F1pzUL3YCMmnG4kD6z8N1m1ALjLOy13Cgb49qSjxROy+AU2yd
	bY7xfgXYvb6Wbu7L5KCx1lMnr76Jla3onYxS1J4DngIgpj8eDcDBa6VG2+9jFL8INwbAZ3yPk9d
	3W80cjoETEC0P9PvYRt0H8LFZNFG7bkV4e2xSge6MyjzJDrB9cFQ+pP4yAyBoA5kxnPTZwYQw8C
	+o1xWOCgkrYwrjkf4Y
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--9.735300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	8157F422FA76802E8FAC01891FFC9C93A5F33D0745DD0DC9D5E8806B24448A2A2000:8

T24gVGh1LCAyMDI0LTA3LTA0IGF0IDEwOjIzICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMDMvMDcvMjQgMTg6MTIsIExvcmVuem8gQmlhbmNvbmkgaGEgc2Ny
aXR0bzoNCj4gPiBJbnRyb2R1Y2UgQWlyb2hhIEVONzU4MSBlbnRyeSBpbiBtZWRpYXRlay1nZW4z
IFBDSWUgY29udHJvbGxlcg0KPiA+IGJpbmRpbmcNCj4gPiANCj4gPiBSZXZpZXdlZC1ieTogQ29u
b3IgRG9vbGV5IDxjb25vci5kb29sZXlAbWljcm9jaGlwLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBMb3JlbnpvIEJpYW5jb25pIDxsb3JlbnpvQGtlcm5lbC5vcmc+DQo+IA0KPiBSZXZpZXdlZC1i
eTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gPA0KPiBhbmdlbG9naW9hY2NoaW5vLmRlbHJl
Z25vQGNvbGxhYm9yYS5jb20+DQo+IA0KDQpBY2tlZC1ieTogSmlhbmp1biBXYW5nIDxqaWFuanVu
LndhbmdAbWVkaWF0ZWsuY29tPg0K

