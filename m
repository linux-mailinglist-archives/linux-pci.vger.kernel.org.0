Return-Path: <linux-pci+bounces-16300-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 286D29C13C5
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 02:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC86428324B
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 01:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE93614A90;
	Fri,  8 Nov 2024 01:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="pJT/g1Yw";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="rwfBngxQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810C814012;
	Fri,  8 Nov 2024 01:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731030235; cv=fail; b=CokLLwp0bmqWsvuy1RfWSekHMFDD2sKB6mD0AVe7kQbSxMmDyPYQHR/mTPKEb8iXKrnDnTeTq9+LHDXl/DHf8iPtAT8LYJu2Luhnmi0pgUAbcfh35Cd8oP7bEz2iryQBAjjk62HcghqU2Yqq/c+FKvcH0p45PcjHOjeueX/o0Y8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731030235; c=relaxed/simple;
	bh=QG/n+w90WdWRku0xrv9iIxmGluPTZ8/P/KAAgkZ6FPM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j/H8kp0tR0Zb/0aBKGMF4NjNF/lU9Wzw571yR2Aah8JEfdEWfBJTLd1NZFyEN6nyD9Q2wYsCqZOLA241cmK116i+E3b47xmnWraW3u/EmV82k2SQdophwiZify4FOUlk6M/X1Xu8zZyi3GVIpvbpfEW/nDzrUJn5auAIBqJTFgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=pJT/g1Yw; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=rwfBngxQ; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: e56d61409d7211efb88477ffae1fc7a5-20241108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=QG/n+w90WdWRku0xrv9iIxmGluPTZ8/P/KAAgkZ6FPM=;
	b=pJT/g1Ywe8by+ORW46GGIkDb9AKqvGzhg5iCMkBKRQ51tZfmYcTK6Q6DfN4IB7wj127hc5m9gCKyK3JkRaXIpzb1DwrsHPxaLlwSNFb8/7rn7n5ZKrgXDdPg6dGN2NEvU8LoH3dFLtfey44tOGlkDn+4/ffCVlBThZeqGJH2UFM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:8db22aa4-1f4c-4aed-93b5-924f7002ce77,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:b0fcdc3,CLOUDID:3ebdce1b-4f51-4e1d-bb6a-1fd98b6b19d2,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-UUID: e56d61409d7211efb88477ffae1fc7a5-20241108
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <jianjun.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1993080703; Fri, 08 Nov 2024 09:43:47 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 8 Nov 2024 09:43:46 +0800
Received: from SEYPR02CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 8 Nov 2024 09:43:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r5prxn2cmcwbT9VJA8t/flIEH1wiKv+Kxu8PQYoCBg9hPixyFCFVtQpcUek4K/h0DUWCbgSDddYrDMOTsi9PVrzGFr613Ld28DhbEMemiO2+HQXOEnTace957tPADPEuAtZr9r/thYarNBvs1g3pGjbCZyJ646XTfBZBO0kOHb4vnY4z06z1Jmby9Qa8jJuwdOUexr0NnAg2l6fgIsxEMIBJDkU0TRBXfChuzVW56/IZpYCH53H93PjLCaI4vfYCur1c+47OcoLcLcGhgxFNt1lbCOyUKsMn6lFxdfbxxHqeiNafKgpCkqxljUENrn7V4UFPJcPEKaFuNQAF3OYT2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QG/n+w90WdWRku0xrv9iIxmGluPTZ8/P/KAAgkZ6FPM=;
 b=SCySplk6KJWHzxC8Hc6wzae+fvmLr+Opr8RYNlaxkeig6gMM84Ph3KUHQKishstSRStOSyQ+KimGjLAusX0ddTJBMt1uZgC/Iwe1oUPho4LUDsHFwZETBPcmIb9X6B0K5Mx1ue0GVy3jPubeT+6+zYtV+otaehzphsa+hwcTFITCQ9amYhr4KInU9rZEw/dYKWU0mdBYpqckNtdhkAKvapfbSwznr2SH5n35KDkP2U1mRj21mvEYTIpEND/svgDb3PIKzGB3Qp2nqnNoy2WEArZ1R+ZLIISNoFNHZk/M8wzi2XjcV5BlYTvT5xSGQjNTq02LCkR3ptZneMIUYRQBzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QG/n+w90WdWRku0xrv9iIxmGluPTZ8/P/KAAgkZ6FPM=;
 b=rwfBngxQimPbe+S0Ee5zfpsRdBZ9l0xwzgwvhDZQ7iA9jsBu+FF60o94oZOVd0NqQEzQFk5tyA+XlJOKPbFz1uw5Uiu/ut1HbRL5TRSp7zvinBZx/CuzbWdhGV3RyFoWxhQ7YMD0IJpDHd1/3dm87LsIwPNU/CvWRlpKXwvR7Ik=
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com (2603:1096:301:17::5)
 by PUZPR03MB6988.apcprd03.prod.outlook.com (2603:1096:301:f7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Fri, 8 Nov
 2024 01:43:44 +0000
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::1c6e:6591:5151:27e6]) by PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::1c6e:6591:5151:27e6%4]) with mapi id 15.20.8137.019; Fri, 8 Nov 2024
 01:43:44 +0000
From: =?utf-8?B?Smlhbmp1biBXYW5nICjnjovlu7rlhpsp?= <Jianjun.Wang@mediatek.com>
To: "kw@linux.com" <kw@linux.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"kernel@collabora.com" <kernel@collabora.com>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"robh@kernel.org" <robh@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	Ryder Lee <Ryder.Lee@mediatek.com>, "fshao@chromium.org"
	<fshao@chromium.org>, "bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [PATCH v4 1/2] PCI: mediatek-gen3: Add support for setting
 max-link-speed limit
Thread-Topic: [PATCH v4 1/2] PCI: mediatek-gen3: Add support for setting
 max-link-speed limit
Thread-Index: AQHbLq/GV/ugg3ooikS0G3aAP9ZnArKnF2CAgAABDwCAAAQlAIAFhVQA
Date: Fri, 8 Nov 2024 01:43:44 +0000
Message-ID: <c5385db34878763ba7df3711a514e4332418cbbd.camel@mediatek.com>
References: <20241104114935.172908-1-angelogioacchino.delregno@collabora.com>
	 <20241104114935.172908-2-angelogioacchino.delregno@collabora.com>
	 <D5DF0QIO2UZQ.29U999LYCC05M@rocinante>
	 <f8ca0f82-2851-40d9-983b-2a143b44263a@collabora.com>
	 <20241104132512.GC2504924@rocinante>
In-Reply-To: <20241104132512.GC2504924@rocinante>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5365:EE_|PUZPR03MB6988:EE_
x-ms-office365-filtering-correlation-id: 2411dbc2-eab9-43c3-838f-08dcff96c7d3
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cEVrYnVhc2ZhTnpaMWp3THd1Y2hqUWlYOXlRMzBDaytNYVlsY3RTVXBPb2Rt?=
 =?utf-8?B?ZVJobUZ6OW41MGJSU3FwVzZCemM2Y2ZDTURLaEppaWZvZy9tU1d1YVVmVFZs?=
 =?utf-8?B?ajR1MmhZZDdDYitKWmQ0SzRKTGMyV2R4ZS8raENJbVNGVkVLK1Vjak5xcEp5?=
 =?utf-8?B?QzQwR3cxVmhtNGNoYnhiejF4UXFDYjYyRW1IRE93Ynl0TXRHaUZqK1JKS3FC?=
 =?utf-8?B?SEgwL0l4cTF2K0dCSTArbUd4N0RqYko0MUtUQko0d2pDNXh6ZmlBVlNOdi9D?=
 =?utf-8?B?MHZFMVcyeHFacUp1L0FxWkswVEVXK3F2Y0VYZjhlaW9QSFBRSjRZdE4zeklU?=
 =?utf-8?B?UU9UL0c5RjN2V09QYWhtUnJuUXVNU212SlNKU2tVZWlMdFc4OWRyR0MrOVQ4?=
 =?utf-8?B?cmEzc3lMVUhoMmp3S2IxWmJsa3ZqWUthODYzaGJiUjdFVVlFekN1cnhnS0Rp?=
 =?utf-8?B?YktjQjBqN3oxVkpCUzRnNk5JcEpxa1lQTUxVYjFiN0Vzb1pkUElyVkUxOUZq?=
 =?utf-8?B?QnEzMTArbWdLNkJKL0FlZkkrOExGMWZOQ21xSU10czlQZmYrV2NsZHBGM1l6?=
 =?utf-8?B?dS95emxaU3BrRnl2V1JuYkV3bUc5SGpyUzU5OUwvZjZzVGIzaU9pZW9IUG5u?=
 =?utf-8?B?UTVaUUp6Q1c3dVBwTGx6aVFlcEp4T1gyYjZsUnpkYWF2UFNtSmI1Tm9sQnpO?=
 =?utf-8?B?TUJwUjArTVIyNlJSYlpKRVFRYTJnZjlFenBvWHUvc2VrNGQwWmV4ZS9hWjdm?=
 =?utf-8?B?TWFSdnordno3U1EwM3pmekZXSU5yWE1MWU1BYWRHWWpBV2VMZ2tvTmR3YzJN?=
 =?utf-8?B?VjZ0VEtEYXg4WHE3MEhxTnRFeXFCRXVVbnF1bGx2QUQyQ0FnMnJkSlpaaWNp?=
 =?utf-8?B?SDF3d1AwQktLamhUWjVzMDhJc25hSGxsNklxR3RLZWZPUlNqVkk3TU5xOERC?=
 =?utf-8?B?eFZWUWZFdi9VSDFHYkppTnN3Qm9MOVZhUmZXalMzQmlvaEgyTU54YUJBL0ZM?=
 =?utf-8?B?TG1QRFBRcGp3NWRzRElUanFRZFl3Q0xWMFlIK1VFK2NSTGdISlJhZHcwOEho?=
 =?utf-8?B?c2IxZlFMRDI3Q01OYjZTdGFKNFloc2J2cWtBOGN4SjRJUVBEa1Y1bDJLYzlT?=
 =?utf-8?B?cXVRMDcrQVhib0t0c3BteTRnVnpUUkE2bVJzZVJsYzJKRFZIejl3QTFzTVlX?=
 =?utf-8?B?cWRVcEEveGtxN3ZpQ2JoRzRYaFZVV0NrdlVZNmNTV3p3elMxVzhYNmZ0K2hZ?=
 =?utf-8?B?eTBjc295OElTcFJLUGhuZzNya0NqdW41cG1vU2hCTk1jclR1Q3g5L2UyeTh3?=
 =?utf-8?B?QVJVUjhiNC9wUmlTRURpcG9JYkVBTFBFS0NoaFJ2dEdmL1FFQldFZUpzOFdo?=
 =?utf-8?B?WllVN29VRVRvWk9qZGFyVU0rY1BWdEtzajdOdlA3bEpmWWozdm5ReGZ3NWhm?=
 =?utf-8?B?cjVqa2xTOG1NWFA2YlEyZWNvUUFZajY1SEFaSVVQTS9NM1pwWHJNREkzK2FQ?=
 =?utf-8?B?UlBlaGZNaWgrKzRXaE96RlhXOGsxVzdMMWxicTBzNW1MVDh0elNrVURtTllw?=
 =?utf-8?B?YkRkeVdRYlU3Sm4rSXh4N3o2amtJVUFERExZcHFmUnhXN2FPY3hBSTlZdXBI?=
 =?utf-8?B?MUo2VmtsYUpCbHQ4MnVhSU9yWEhvR2ZnMVNqWTM3MWVqRFJLWG1yZlRtRG94?=
 =?utf-8?B?SFBFcHVzZVNBTS9lMGtjTzRrS2dTOXlEakFERmNyVk9mRE5xczY1WkNhSm1Z?=
 =?utf-8?B?QjNlK3JHYmdHRllucC92K2pQb1VpczgxR2FackIrLzFLZncxZUI0c255MWpT?=
 =?utf-8?B?SFZBV2pzdTdWR1lLd1JsTFZhNGYxMzUwR2R0aCtKL3l3dGlBNnZQUW9sdXFv?=
 =?utf-8?Q?nged8uNMQZNhs?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5365.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?amZuTitzbmZnVGY5VXNKcldpK2pGR0lEN0FOazYvK1VUSjF6YXB4TEl6ZjQr?=
 =?utf-8?B?UlNOVDNGL1VwSkJJNmdEZ1pMaytxOTk0QjFqR2NVa3hINUVMN2FNK2dkbGZv?=
 =?utf-8?B?YmRCenZVekoyMnFwRUZhMnVVVE9SQmFQdnRyMDJ0ZEgvM0VFZTFXS2dNVTRq?=
 =?utf-8?B?UDhFclM1ZDdNcGNTUHF2MU9kQWJXemhISlk3REdYV2t5RHdlT1AyZWxsL1pp?=
 =?utf-8?B?ZmdzNUJxNkw5VTQxZFVwNkIyVlcyN2M5bXBvVG9mdE4vdS9kUHZBZVZGcnRz?=
 =?utf-8?B?azlCLy85ZnNLMEkza0tNeEkzbGV0VVowK0Zoc3hmWS9RUE9yeDZuRFRaOWZ1?=
 =?utf-8?B?S3VVdEN3TldRa2Z1NWxKNGl5MlZWcWNkYUJvTVlmZkYrc1QxRVg0UUtkaElk?=
 =?utf-8?B?NHh4ZURPWVJ0S1dGdGxFSThhUytYMHVBbldxaFJHN3pERkc2YWdHangzWi9s?=
 =?utf-8?B?OHMzc3RBQVc5QWt6NCtKZ201WEtmSTQ2cUFYaFhtTkxuTkZBL01SNEhJanpT?=
 =?utf-8?B?RndRSmVyb0RHNVk3SlRPL2lOcFpQUC82QTJkd2NXZEVOWkFWalBpYnVjaHVp?=
 =?utf-8?B?L01yZjhpLzg2VWNNUlFjcDArSCtncTN4ODNMZ1VlbmVrc0hPL29aQ1UrVWJy?=
 =?utf-8?B?Tm16a0pTQ241dEdwYy9lWXdHRlcwam85UzM2L2tMdFlPeERVZVNtMTcrNFpD?=
 =?utf-8?B?RW5qRDVPb0ZzeFpTS2RoMXhrWlk2Szc3SHR4LzU5WnlnUjJoMUNwOG1hRmx2?=
 =?utf-8?B?MXZPUXpLL3NsRk80ZGQzb2YwRDRhVTJNQXpySHVGMmhST1EzdFg2aGRlUm1E?=
 =?utf-8?B?M09rTHJMNnlzb3Bnd096Zi9NODU1YlNYWnFsSlRsb2N1akRsbTBVUEpMUXNQ?=
 =?utf-8?B?NEdsbzNoUFJPMi9zajZOZ0JzM3dLLzZCKzhneDNCSzJQWGxJRG5VTEc5VWw0?=
 =?utf-8?B?Si9lUERQOVdpWml0SU9GZTJ1REtXem9waVhRQU9PVjdsQjN3YUdWMWFjZFcx?=
 =?utf-8?B?TFNkV00zTTFzUmJwL0VtZkF3NGJtcnhrSnJZdWk4akNBcGxrNGRxdzRuQkQ2?=
 =?utf-8?B?Nzc1dzNYeWx4V0o3QVNyeXRXNDRPK2ZtQXJaV0lvb0ovN205c0tHRkQ3NU4x?=
 =?utf-8?B?REFkZm12SUNtR1JRYU5kYmIzdDBZSHczdmprQXVUQnNqZWhOK042dU00Z1Jk?=
 =?utf-8?B?NEszVUJ6OWV0SDB5dnAwa25UblhTY2t1RlhkaktGZ3NaVFpFQVpMNllwK2Fv?=
 =?utf-8?B?UE9LVGt2eHFBRTI3enBFcDVUNzhPcUc0dnJCb0RCK0hxcWg3V0dhU1dzZ1pV?=
 =?utf-8?B?UFd6OTc5V3d5VmpBSlFKbHZiYXdGaGlnTjNJbkc3LzVLb2Q5TG5Fa25ROGxu?=
 =?utf-8?B?eG9nWk9NMWFBdkRFSm9mcHJHZGRNbTA4T3gvZGdiaEJteVlyVWFKMHNHTG1i?=
 =?utf-8?B?S2x5VEtoTVFvSXNDUW50MzNyOU5URmZaSXNFQ3lkbmZBUTZqcm52L3JDQmZT?=
 =?utf-8?B?RkZZcHN3QmZXMzRjUnlXT2hqbkExV0ZtYmt2b1BNaCtmR0x5bXo3OU4rU3BM?=
 =?utf-8?B?d2UybTg5UWFSTTRIQTN1OFNpTnZyazZZbTYzcFRnRHlaZE5pbWxhUEQ5dTVp?=
 =?utf-8?B?SnU4S1hxcFdwcFNoem1qQTkwSzBwbC9WVFM0QzhHK3RqdzZJV1VUZWlpcWxL?=
 =?utf-8?B?bHpVcUQ1TTVQS1BxM2FsQitNVE80MlRodjVKZmtQMitsNnhUNExmR3NLSUFp?=
 =?utf-8?B?aDNxNTZYTnMrR24vaGN0RFQ2OGZ2OTIwU3FJam94d1BhTTFSZmdOK3h5ekpq?=
 =?utf-8?B?TDRYQWU0elFrUEp6U3VyT2htQlhaRTVSMDlubmFidHRTVWhDQ2JrSXo4RzN0?=
 =?utf-8?B?L1REQjUvRmtUVXVPcGRIODNLL1M1UlE4M1ZWZmFNbzhxWStHSE4wWGZPVXgv?=
 =?utf-8?B?bitUT1JiQVBHcXYwSGNsZTBLRVBkM3JjU2JQMjRSWjlwTG9Tam9qd0svbHBk?=
 =?utf-8?B?VUxsK2VsVmpGbFZad1c5VW02TkJiUi9YZUViS3grVVdzeUhzREFnMHVJaTdO?=
 =?utf-8?B?ZnFPT1NLODAzaHh3T0NiQWhSY0l6MlR6UWhobUZHVS9zWlZ0dlJBWkUzbjFQ?=
 =?utf-8?B?SjVhaWFxNWhOaStiSDVya3liN3JQbW4wWCtyRERkeGRLdnlDMHNqaEVkSHV6?=
 =?utf-8?B?SEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1892CA4BA718EE42BA8EF6E7BA6BC5BA@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5365.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2411dbc2-eab9-43c3-838f-08dcff96c7d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2024 01:43:44.2296
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UWagnotjttxhmCk0xTdW/WfwTakXevjQzzd73W/CBj9/6dc0GAZT4czD7MOLdYCheA4T9WSQcR0XV6dMb2KKHqpEBIUlndJ+FDMA0LfSBdU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB6988

SGkgS3J6eXN6dG9mLA0KDQpPbiBNb24sIDIwMjQtMTEtMDQgYXQgMjI6MjUgKzA5MDAsIEtyenlz
enRvZiBXaWxjennFhHNraSB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90
IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZp
ZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBIZWxsbywNCj4gDQo+ID4g
PiBJIHdvbmRlciBpZiB0aGlzIGRlYnVnIG1lc3NhZ2Ugd291bGQgYmUgYmV0dGVyIHNlcnZlZCBh
cyBhDQo+ID4gPiB3YXJuaW5nIHRvIGxldA0KPiA+ID4gdGhlIHVzZXIga25vdyB0aGF0IHRoZSBz
cGVlZCBoYXMgYmVlbiBvdmVycmlkZGVuIGR1ZSB0byB0aGUNCj4gPiA+IHBsYXRmb3JtDQo+ID4g
PiBsaW1pdGF0aW9uLiAgVGhvdWdodHM/DQo+ID4gPiANCj4gPiA+IEFsc28sIHRoZXJlIGlzIG5v
IG5lZWQgdG8gc2VudCBhIG5ldyBzZXJpZXMgaWYgeW91IGZpbmUgd2l0aCB0aGUNCj4gPiA+IHN1
Z2dlc3Rpb25zLiAgSSB3aWxsIG1lbmQgdGhlIGNvZGUgb24gdGhlIGJyYW5jaCB3aGVuIGFwcGx5
aW5nLg0KPiA+ID4gDQo+ID4gDQo+ID4gQSB3YXJuaW5nIHNlZW1zIHRvIGJlIGEgYml0IHRvbyBt
dWNoIGFuZCB3b3VsZCBhcHBlYXIgbGlrZQ0KPiA+IHNvbWV0aGluZyB0byB3b3JyeQ0KPiA+IGFi
b3V0IChvciBzb21ldGhpbmcgdW5pbnRlbmRlZCkuLi4NCj4gPiANCj4gPiBQZXJoYXBzIGEgZGV2
X2luZm8oKSB3b3VsZCB3b3JrIGJldHRlciBoZXJlPw0KPiANCj4gU291bmRzIGdvb2QhICBUaGFu
ayB5b3UhDQo+IA0KPiBXaWxsIGhhbmRsZSB0aGUgbmVjZXNzYXJ5IGNoYW5nZXMgd2hpbGUgYXBw
bHlpbmcgdGhlIHNlcmllcy4NCj4gDQo+ICAgICAgICAgS3J6eXN6dG9mDQoNClRoaXMgcGF0Y2gg
bWF5IG5lZWQgbW9yZSBkaXNjdXNzaW9uLiBJIGhhdmUgcmVwbGllZCBpbiB0aGUgcHJldmlvdXMN
CnZlcnNpb246DQoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXBjaS83ZTIyMDY5M2Yw
NzZjODRjYzFiYzNkOTFlNzk3NTgwYjMyMGI0NTk4LmNhbWVsQG1lZGlhdGVrLmNvbS9ULyNtMWI5
ZjJkMjZhMjI4NzEyYjZiOWQwMmViYTExZDgwNjM4NjI3NzJjMQ0KDQpTaG91bGQgd2Ugd2FpdCBs
b25nZXIgYmVmb3JlIGFwcGx5aW5nIHRoaXMgcGF0Y2g/IERvIHlvdSBoYXZlIGFueQ0Kc3VnZ2Vz
dGlvbnM/IEkgY2FuIHByb3ZpZGUgbW9yZSBsb2dzIG9yIHRlc3QgcmVzdWx0cyBpZiBuZWVkZWQu
IFNvcnJ5DQpmb3IgdGhlIGluY29udmVuaWVuY2UuDQoNClRoYW5rcy4NCg0KPiANCg==

