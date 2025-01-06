Return-Path: <linux-pci+bounces-19324-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D65C7A021BC
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2025 10:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D2031882E24
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2025 09:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123FC1D8A0B;
	Mon,  6 Jan 2025 09:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="np05gLZD";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="T7q3aRMf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C702AD16;
	Mon,  6 Jan 2025 09:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736155586; cv=fail; b=K9FH8dk4lezOX4ZYuELOgzpuDYccnEMMUgYBO1+5VVZ73Y6BTdQfHmo+BwaY3azziA8Y6v9Gp5UqgJjJiO0kXKFPAy9N9tZfNlwKZLr7X6c9cs2bGcy9RhkhAPli3BBnMpYc1qSgNLaay1DrtLyWNd8AT4o6s/KSLPdRsDztMVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736155586; c=relaxed/simple;
	bh=zlUTTn++uYDMWpAweyF6CzvJx5RyBuS4haQ73fjzigs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=McSdRUs4/F0x1Dio694S8TjSkTGHvZ3vAJyLLy+pUYwSlAp1aVWDDTaWLZDSX7LppH6EOyGew1JJP1E82vsmZ3abXpujYyXKRkdKN2spWgNIzvqmLFTAic+fJogwfw01Lylm43lJGyWfUa4psg76lccTbWdI5sn6beiYslz9om4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=np05gLZD; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=T7q3aRMf; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 472f7640cc1011ef99858b75a2457dd9-20250106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=zlUTTn++uYDMWpAweyF6CzvJx5RyBuS4haQ73fjzigs=;
	b=np05gLZDfM71nGH1XzvT/m9NN5l/J+hN+6XFYjTpYDpfDE/YcgWwZpQM7l9mSFUL374U1GhMnAKiDXk0hUsxCHTj4BDa6/mhJrIYxFwS3+SI/7zX3U4u3TTpP8IiNCOmJopA8V2Ne1vzhJBoXV3lunb5moVc0VxWe6iZJpjzBH0=;
X-CID-CACHE: Type:Local,Time:202501061719+08,HitQuantity:2
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:e23f275d-3b04-4cc0-8411-43da5d3c29fa,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:5c976e37-e11c-4c1a-89f7-e7a032832c40,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 472f7640cc1011ef99858b75a2457dd9-20250106
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <jianjun.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 879783664; Mon, 06 Jan 2025 17:26:15 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 6 Jan 2025 17:26:14 +0800
Received: from SEYPR02CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 6 Jan 2025 17:26:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EUDOqnfitMEvx0r0yDTE65bAsqRRQLr/VBLATG2FGo7/Ggh55WPkpK57Q0HZ29gx+2XnAsEkCMevT6hfHY7yjagOPupCqvIrMfvhErYlEHC6ACH03TC+JHf8OQ0HF8cyny4QLIxWEwO3vcbnLXrXz+w6kUGF3qPf6BDq4ua/ysZJfDYU6Nv+AnddFbFnQDz14FfJNdMlaELJEgFmGCmt/J1HgkETYkIfs4YNCw5W1hJ6tpPNHqKSFtNpqErXNSBoJCB3KMbI1AIaV8TODCPQq99xWeP2X+9IaRu3zOgli4TNa5q0fYMta5jTqcDXTazeKvPvO26MdSZwoqeCaOHtIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zlUTTn++uYDMWpAweyF6CzvJx5RyBuS4haQ73fjzigs=;
 b=d+dSUpmsugdWpYhxMoWVTX9blp/brIDDcqrO3lI0u6Kf7uHMBeDynGLGnz2odWDM+3Do+XbS/13ZNbbEXNicTAvLM4Ln7rLstrOxI8uROCP0BE42TQ7IEh1Hl7iRhH1sY5FNrfrePAogmFcWR/i2GoVuSAftmT27ZJIVoT76os71ojk88IG2ou0EUlV5pPyh6ZGlKfKGyRxFI/5Ta8zVkmqQih8Bqw51d/uT288ifiOP8Ytxy7l3IqY3AyTX6zF+oDmTRMUfjQ0DODFbAdlfdQ2uUWbbdgdFJYvLdZK5jiRj4wKUtF/DDr3h6mxgqx6O/g7vzdWFTXuy/bnqveDyOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zlUTTn++uYDMWpAweyF6CzvJx5RyBuS4haQ73fjzigs=;
 b=T7q3aRMfaCi1hOVHu/t8dBuBEJlcgCJj9HraLkRNvaaau55pobKgf7fXlDFBMOX4epmXVqvap9Y4tSYG+FO2xtMSEzyFPiBC3O6lK0qiwl8rs53bcc+TXP910fB2qmq1IUkBt7NITGisR27Td76GxVsIAcVvG64filBbpAeJlhA=
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com (2603:1096:301:17::5)
 by TYSPR03MB8109.apcprd03.prod.outlook.com (2603:1096:400:470::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.14; Mon, 6 Jan
 2025 09:26:11 +0000
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::1c6e:6591:5151:27e6]) by PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::1c6e:6591:5151:27e6%3]) with mapi id 15.20.8314.015; Mon, 6 Jan 2025
 09:26:10 +0000
From: =?utf-8?B?Smlhbmp1biBXYW5nICjnjovlu7rlhpsp?= <Jianjun.Wang@mediatek.com>
To: "krzk@kernel.org" <krzk@kernel.org>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	=?utf-8?B?WGF2aWVyIENoYW5nICjlvLXnjbvmlocp?= <Xavier.Chang@mediatek.com>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Ryder Lee <Ryder.Lee@mediatek.com>
Subject: Re: [PATCH 1/5] dt-bindings: PCI: mediatek-gen3: Add MT8196 support
Thread-Topic: [PATCH 1/5] dt-bindings: PCI: mediatek-gen3: Add MT8196 support
Thread-Index: AQHbXaTW76fSj2ANakexjY3C+uSV4rMEw32AgAS7TIA=
Date: Mon, 6 Jan 2025 09:26:10 +0000
Message-ID: <04ae2a07e2c2d3c03e82596034b1b7711450a0ae.camel@mediatek.com>
References: <20250103060035.30688-1-jianjun.wang@mediatek.com>
	 <20250103060035.30688-2-jianjun.wang@mediatek.com>
	 <ndj6j2mmylipr7mxg42f3lcwgx55cvcjnuuofmlk6n6t5uz5pr@bxugolyfublc>
In-Reply-To: <ndj6j2mmylipr7mxg42f3lcwgx55cvcjnuuofmlk6n6t5uz5pr@bxugolyfublc>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5365:EE_|TYSPR03MB8109:EE_
x-ms-office365-filtering-correlation-id: e7d32b26-9b00-4117-e57b-08dd2e342865
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7055299003|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aW5IL0k3UFEvTENPK0lhU0xIdFdxQ2JoZGlOWDRFbk15V2IyN1NySEdCb1Qr?=
 =?utf-8?B?R2dKV0poOWkzREIxR0MzZzZiQzhhUk5haXJKa3ZDdXJRZXQ2b3o1cUlHejd2?=
 =?utf-8?B?Q1RjNHZOZXpWV04yVTNoUUF3eG1GSE1Hbk9TTGQzbnVzT3dZRFQrcnhjYTkr?=
 =?utf-8?B?Ymw1eDZlSk1iQUNTbUlNR3FKUkJKSUdaN1BmWXo3UnhSbGE0ZGgwWEYzaE1S?=
 =?utf-8?B?TnNRaVA0MVhDT2g0eGZFZ2hMQ3A5U3huWGJaMmk3UUFZckQ3NTgvOXJiV0h1?=
 =?utf-8?B?WTZGcjRqWGZEMkdWT1B4cjgyYm5UZHQzaWRreEZmYXFMMkZIZjdDVmNMaE9r?=
 =?utf-8?B?blc5Szg5OElETFJJeHpNc082QWk3Z2NKMXFVVzQ2dHo5Nkw4Y2NmbVVHcUJM?=
 =?utf-8?B?VGpmUVUwYmxFS1R4MFVaOGZCc3oxcGlPaEI1dldMVUNXZmR0VWpicHRoMSt6?=
 =?utf-8?B?N0xFcnorWllUaE1KN1hYNG1HMDZBQnNhamRGUlhSR2YxaFp4d1Mzb2Y0MGk1?=
 =?utf-8?B?c2NZdldGTlNhN1VQOUFPVUE0aEdVaEVObGd0WmxCQVVIMUNDU3p6RUdSZFdG?=
 =?utf-8?B?RHNkQS9IdjJXOThBcUVNTTdwazJaUXNIMlp2THRaMlRWTWk1RnNCUStBSTdq?=
 =?utf-8?B?a3RTbnMxRUgxL3J3Y3VndnRKek0ydWV5cG5vbjhOaEdMRnp5SE5Pd3ltSFll?=
 =?utf-8?B?TFJFL1JNZUtDQitBeW9ZRStnV1FkRlVQbW1uTkVTYzVTZDVFZXU3SkdTZlpM?=
 =?utf-8?B?S0ZBV0VzMjVOQ2RUYnFuZTBlVDRkbXhNK1FwNGlCbmNOcXBoSDB1aDAxYWR5?=
 =?utf-8?B?ZG1zbHc0dGU4RHFXcW9vcksyaEtta2VteUs3MnhReCtaK2tjMnRvR1U4UnRu?=
 =?utf-8?B?K3JMTGNBWFhESENjbStoVzkxaXVPK05wY2NBVVpKRGhEbTdEeTU2UXg1SVNQ?=
 =?utf-8?B?NmhybVZQNzZoVTJqdm13Y09udmJoTXpacVhraURvMjhBQlNJek14T3g5NlZp?=
 =?utf-8?B?OGhtQUMraWw2aWdGSmxpc1N1T04xU2M5YTdvd3lkdFVwcGFhaXhSamdmcUpS?=
 =?utf-8?B?c1l0Mk9qVE15WEEzOFZ6TGxDUDR5WFI1c2JEd2NSU0tBN3l5UGtyb0Z0T1Fk?=
 =?utf-8?B?cUptZ2hTdEozNGpoWkRZR0RhbVo4YWNJQTlldWd3Yk16YTRHMTlsaHJwOWdX?=
 =?utf-8?B?azR6M0M5NVB6MXpMWjJsZG5Ra0xZS2MyTW9EcDl3dGRPaGEzVmVBQWV6WS9R?=
 =?utf-8?B?Y1JKcnIxYTh5TlV0dlJ0NUNEK0FzT3RWM3pEbVl1QmpqWTFOMWIrdzhudEhq?=
 =?utf-8?B?aHMrdnJBckNNdldxNjkyZTFDeDVjM3JqSnNXZVp2V2NqSHZZdFovT2hhTU9r?=
 =?utf-8?B?YTVqUnRCL0g1WkM3aHpmOFVmOHYxTlFhNnpDRWlJM1IwU3BIWlZlNzhUelhC?=
 =?utf-8?B?THZNdWNxajl2clBMQ1VEYTVTZkZOcFJUVDdQNGxWbnZUQ1VEejQ4bTBnSWhS?=
 =?utf-8?B?Qy8wRkY4NjRFNTRoRXBLamtTNjhLancweWtRNHFEckp3UHZOT2lWUzZSZ0hk?=
 =?utf-8?B?ejNmYVVWRzMwcjJ4ZDk2eS9GOEpUR1VWTXBUeHFKQ3I4citFS2dOdEJKTmxI?=
 =?utf-8?B?NGw5eDBPeHZaM1hiYXYzb3NRSUdLa21remZ0VjdNTVNjUndHeUZVdTdHcEMz?=
 =?utf-8?B?Q3dEYS9rZVlFSm5JVGd3UFdtdHpNR1J3QmFtS1hYSWlIYnVieTVjSnhpZldF?=
 =?utf-8?B?YVRDZmNVdHh1eE9EaE1abWxORG5SajVCS3FScWFIV0NNb1pCdk9yaDFEK1Qv?=
 =?utf-8?B?R0JLT0VXTnhkMDJid3JjbzB1akNvc1ZNdHBmUkVrV3dCOEtObjNZcEtqMExF?=
 =?utf-8?B?My9MYzhmbmEyQmFESVkzNFRHQkQvaWtCeFZSd2NBYWpzU1RxMHFhN0VCajFn?=
 =?utf-8?B?RDhIOFEzRjdFb21ZU0w2b0ttZitSMEtKYW0vNHcwVkhWT1NpWGl6ZEZCZEk0?=
 =?utf-8?B?bnpCb09GT3BnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5365.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7055299003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L2RqQ0FZWjAzN0YrZmtGUFZCTGl6ZUhrSThaeXF4ZlY3QVcvblRlMTNsR3F4?=
 =?utf-8?B?WHpkeEVvT01OdEZkSGhXOEV0N0NqNzE2Q0RzWmRlQ21oYm5HMXZkOUF1ZCtp?=
 =?utf-8?B?dGtWVW9mazFlTExaZVNHVGVNa2ZkVlFISTFNUG5tN1hsREZQaThQUGJFbjdJ?=
 =?utf-8?B?Q1BMS1J2ZGVIQlhxRU02a1pvM3p0S2oxUHEzVVVMeGIrcms5VmpFUkhUdXY5?=
 =?utf-8?B?emVEbXloOEJkUWo5S1drMWs1akNOaUpIcXNqbStJY3RiWGFNOGlrMUMvR1c2?=
 =?utf-8?B?SEpJcE9jQ2dIZ0JNRTdLT1J4QTIybVlqSmRMMlNHRzR4V3Z1QjM5S3dyUzV4?=
 =?utf-8?B?UzJjdEtKbDJ6a3dxM1kyWlJtY0x1ZDNLdi9IWlkzcXBhOTFKUFNSWGpWMS9o?=
 =?utf-8?B?Umc0K3ZvTkJSSUpQK2dNbmdvejZlSVdkQ2RjYU0rM0VQUmpmcWpEMnNhOUlH?=
 =?utf-8?B?YkcxN3JkYUQ4T0RxV1A1RE54RHg1R0VmSWQ3a1U2a1FXb2F1SUpBWFVOZUZw?=
 =?utf-8?B?NC9LMFFWWVlHazZOZ1BpSjNIazZDWjFMcEpvYi9oajk0S1dVdkQvSVh4Z2t3?=
 =?utf-8?B?WDJQOFl6a3VpaXlCT05JMW9MQTROaE1MSXF3dUl0Vmo4QXFtYU9PRjh6Rmt1?=
 =?utf-8?B?MytabGU0OHprb0xPdjA0R2tzakpQRmVOQllBT1JtTTlTNTBOUXA4dnVwRCtm?=
 =?utf-8?B?VGkwK1V5UnpaMGxXcmUrSkd3emxaS2o5T3VoMmh0K0JDL21peEN3dnBJMnpW?=
 =?utf-8?B?dVVMOXNhOEE1SmJqbU1KZ0FRbjMveWpYdm5jWnJUTTFlWHJDT3huNkVCSGs3?=
 =?utf-8?B?a1IrUGszTGhQdWRyMmhpUG55VEhmZFJGNXhraUE5bWJrOE4rYWRIeFFUVlMv?=
 =?utf-8?B?elorclJLaUlJanVJSjhRblFYWGZRV0I0T3hoVjJOMFJ5WmZmMHFxM2JubDVS?=
 =?utf-8?B?MTVJZ2hHOENxazhKWjJMR0NjVjQ5KzhVS3lIelJiWjR4SjkzR2dnc2dtZFh6?=
 =?utf-8?B?MU9qcmtnVWtBeGJ0d3locTBwUWk5NUhrcllmc1FwNE5VenVzTFJuRktiR2tS?=
 =?utf-8?B?TlFFMDIxQ2w2REJtOGZPTEhGQ05JQzVTTEpmUDlZY1BzOHdPcTBlTzM3NnZu?=
 =?utf-8?B?cEowc3ZwckIzaGVlbDRUUTY2TWhnWCs2aEZGd3c1TkdlSnluKzZCdnVycXhj?=
 =?utf-8?B?OXQwazlnakpwN25PY1MrMC9vRkthZTM0eFRjeDZjUFgxYUNZU29kRWxZdTZG?=
 =?utf-8?B?K3JISDJYTk9DZXNWaG8xQ0JzWTRKRFVqT09yQ3N5cDF6NjJLaCtKQmZNN1Fj?=
 =?utf-8?B?RWlMNWJrb3Y1NDVPNWR5OTJsQ3M1YnpBbXRGSmZneTRQbGhHa0xHcnlqS2pW?=
 =?utf-8?B?OUhSN014bHBsNU5DdHNMM0FGdTFHcFZqNWFwbVBoUllXa3poMm1rM0gyTjRj?=
 =?utf-8?B?Y09rWksyYnMwcTJOWFI3cnRRcjB3cUlQYXkxZFVRVS8xYWNxRkE0dytubTB0?=
 =?utf-8?B?aWNJWmhrNGJOeVppSHhISTQ1SGM5WGtnR3NudmgwOWs0OVIvam96TzM2REI0?=
 =?utf-8?B?bFQwVXpGUm1OMTZBV0pNdkNVQUdvc1BiRkRZQ3pLRHk1dUZSN2RDN1k5WGha?=
 =?utf-8?B?eTJ0eS9ZRDhCWU9IcU1ZWnlHWDFGMytVbXhxMU9Fcy9oNFErTjdFK2V6eWs1?=
 =?utf-8?B?N1B1aExDd092dlcwK1M3U3FkdHNJZDlwMzNVa0U0S0xwK09oK3AvWVNKRFQ1?=
 =?utf-8?B?cGpXM01DYkh4V0pteU9ReW4zL2Jyam45Y0Q0VFpxdnVmc1hzbU4rOUtjczV5?=
 =?utf-8?B?WGN4UWxPT3BBQ2Y0dExPT3B6cmRIZmlFSC8wSUc1aFJLb1laUFJjQUJRYVhp?=
 =?utf-8?B?ZHN2Z3ZKcmlkM0xadnRoejBPR21idFM1M3BRMkNzZER4UTRwYU9rVHEvWWVP?=
 =?utf-8?B?ZHZ5Y1ZlWEg4ck00bEE1SDhheGZxYk9OcUMyTHBpWXlqME84blY0NmtFVjdj?=
 =?utf-8?B?V1JTSm1QVVlIT0VIWHVVUUhXdThSSm5mSkVKTTYwNTNPRHA2NGQ0NENqOW9C?=
 =?utf-8?B?ak5NYUZuMW1DS1dUOERlNEtLN2lJSHFMVU52bUowaHA2NndNY0ZhTjVSZm1q?=
 =?utf-8?B?UDBnUS9kdnBhZkJ2YWJEeDN4Y2owNzJJU2I2VnhSOXY1b1NqbnVZMk5IUVRk?=
 =?utf-8?B?dXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <80234602844C344C83FA49C64413DA31@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5365.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7d32b26-9b00-4117-e57b-08dd2e342865
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2025 09:26:10.7277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F1iq68lTHkU4wj4zITYTkJIvJyG1c0i4pozSZ4Z3M9TIFHhddFe0kt2/Jy1HhXRcZMxx8CNiVyfuyvwHyJw2yOPYo5bJevLzeMcy6ejGJy4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8109

T24gRnJpLCAyMDI1LTAxLTAzIGF0IDEwOjEwICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiANCj4gDQo+IE9uIEZyaSwgSmFuIDAzLCAyMDI1IGF0IDAyOjAwOjExUE0g
KzA4MDAsIEppYW5qdW4gV2FuZyB3cm90ZToNCj4gPiArICAgICAgICBjbG9jay1uYW1lczoNCj4g
PiArICAgICAgICAgIGl0ZW1zOg0KPiA+ICsgICAgICAgICAgICAtIGNvbnN0OiBwbF8yNTBtDQo+
ID4gKyAgICAgICAgICAgIC0gY29uc3Q6IHRsXzI2bQ0KPiA+ICsgICAgICAgICAgICAtIGNvbnN0
OiBwZXJpXzI2bQ0KPiA+ICsgICAgICAgICAgICAtIGNvbnN0OiBwZXJpX21lbQ0KPiA+ICsgICAg
ICAgICAgICAtIGNvbnN0OiBhaGJfYXBiDQo+ID4gKyAgICAgICAgICAgIC0gY29uc3Q6IGxvd19w
b3dlcg0KPiA+ICsNCj4gPiArICAgICAgICByZXNldHM6DQo+ID4gKyAgICAgICAgICBtaW5JdGVt
czogMQ0KPiA+ICsgICAgICAgICAgbWF4SXRlbXM6IDINCj4gPiArDQo+ID4gKyAgICAgICAgcmVz
ZXQtbmFtZXM6DQo+ID4gKyAgICAgICAgICBtaW5JdGVtczogMQ0KPiA+ICsgICAgICAgICAgbWF4
SXRlbXM6IDINCj4gDQo+IFdoeSByZXNldHMgYXJlIGZsZXhpYmxlPw0KDQpUaGVyZSBhcmUgdHdv
IHJlc2V0cywgb25lIGZvciBNQUMgYW5kIGFub3RoZXIgZm9yIFBIWSwgc29tZSBwbGF0Zm9ybXMN
Cm1heSBvbmx5IHVzZSBvbmUgb2YgdGhlbS4NCg0KV291bGQgeW91IHByZWZlciB0byBzZXQgdGhl
IG51bWJlciBvZiByZXNldHMgdG8gYSBmaXhlZCB2YWx1ZSBmb3INCnNwZWNpZmljIHBsYXRmb3Jt
cz8NCg0KVGhhbmtzLg0KDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KPiANCj4g
DQo=

