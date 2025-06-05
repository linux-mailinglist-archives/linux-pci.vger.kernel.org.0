Return-Path: <linux-pci+bounces-29024-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6165FACEE7E
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 13:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48ED3188649D
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 11:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C26319E971;
	Thu,  5 Jun 2025 11:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="B8Ufoly6";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="goFgE0mK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A321F5823;
	Thu,  5 Jun 2025 11:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749122610; cv=fail; b=UYvZ0msIRMyW1IouEOrkVnHqn7/DkAzDPjpTAmI2U4Xza19+q3Xf4Ts8B6XFxJAOun2yvVwyyinlPXzAOx68l1r5GdzzwHvKO9F9BcYUUo1L0+bd3javIW/tZWr0tq/kzbVqoeKFlXpoeLi4GI0izPnKITyxZFvqBCqjEKRnzcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749122610; c=relaxed/simple;
	bh=N07yxcO+E5IRKyyMAi9TXLdRr8ienr2WT78J6T5hBHk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lc9CMVzOxthO/hBsNlgkPRq9XkJRVwwrpeP8TksF8fb19PJIoENxp+xPOWvyBD0aLCvvDnjnHMmIdkqFNf8tW5KM1saPkJHzL/wU9DnZQqxSIBChtdnzELKY6M/9CtwpsJxGwETULFB+Ip+hTj+3BNZTIHyZ92VLEfWVdCMG3jE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=B8Ufoly6; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=goFgE0mK; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 7e21943e41ff11f0b33aeb1e7f16c2b6-20250605
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=N07yxcO+E5IRKyyMAi9TXLdRr8ienr2WT78J6T5hBHk=;
	b=B8Ufoly6veBjOqZju88ly6zy/p4wol//k8pQEcvkHhxYc4nYOL4yuPDEB0AEqfDWYtA+U8AoYfxTIYNfyoOzZegv5vlXsUsv/K0fJuT3Ygo3SKCEYoaQnrtQrlbuP+2Wans5TR3YHuNwkwJ2VtMEf56k0LbV52Q5tXR8o+XFR7I=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:2f561c8e-f4d8-4c2b-a1d3-8f26bdf85b23,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:6e30e8f1-fe3f-487e-8db5-d099c876a5c3,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:nil,Conte
	nt:0|50,EDM:-3,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 7e21943e41ff11f0b33aeb1e7f16c2b6-20250605
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1139193643; Thu, 05 Jun 2025 19:23:23 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Thu, 5 Jun 2025 19:23:05 +0800
Received: from SEYPR02CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Thu, 5 Jun 2025 19:23:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JrSNs/orWYqG7Zy88da3MHzXx+8RStSNN8pVgMkHuRWQyguCcUInL4/MJweUT9jS6IlUEzpDS+4D8xydr/20BfoWcWU5Un4yp7Xkz9xsuazkuBksjDO0FQXA6N6iO3wI4/lTJJ68Z3NBgmjDW8Vxa0LWNBG9kx4PIpSEK+ERIOkSAwEJQPv0tbPuQTruOVC+5fC+wLtxcrZo7hIsHQZYRgIpxkd0Ocn5VIovj94y1LOBU0etr74Ya9ZzlBDGFGssukNdp2B1rblIAgXvfxsrC7nQfbeaKnl90fO2brvLgetpMKwsOrvYgejWjBNPMd+fLSrp/ncqmTRD/mO67FK0vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N07yxcO+E5IRKyyMAi9TXLdRr8ienr2WT78J6T5hBHk=;
 b=b71b8b3+8waQmT6L/bKRdtB5oadifShw2Kt6/CpsWwJdkumCTvgV9mshWO4NQCpCrfsibU3Cjq26VzOQIPd6hMy1N0jlo+MyrfPjDGDcqAmx1zWfuaGH5c44prTUdKJ5nkcQPoqqBgxjvgzklCzoBPVOhu9uXL5R9TL3I+VGX91vseDN1GbIzaORhjVW5MCfSbUS0b/tz6GRqTFaJG+6WZjmqb2jnz4fuGnumpA5LKtclOleaxtMcgvm1gxRs+zqbDu5VLJ89p3Z3L5MyeAopnTTdbpqs8kQypyByBUiJYXd3KQEVdlSweOOOBAKlGLHaKibV5QhsAJ1bIB586ghqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N07yxcO+E5IRKyyMAi9TXLdRr8ienr2WT78J6T5hBHk=;
 b=goFgE0mKR5cPigsLO711oeX3fZ4tYrG0DoG8OTJx85ZX6wNiweInkUgRtKsSSf6J6gZ8vH7ppd5uQGDfNEz5Y1yasmKQRpnr8pgsJ/Ai69GkXrhS4hAG68Ae9Ahc3sKErJfL9zEF948koFGIw4sKwcw5vDHUUzMjVUahrg5ENkI=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by KL1PR03MB7056.apcprd03.prod.outlook.com (2603:1096:820:df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Thu, 5 Jun
 2025 11:23:03 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2557:de4d:a3c7:41e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2557:de4d:a3c7:41e8%3]) with mapi id 15.20.8813.018; Thu, 5 Jun 2025
 11:23:03 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: =?utf-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?= <Deren.Wu@mediatek.com>,
	=?utf-8?B?Sm9obm55LUNDIENoYW5nICjlvLXmmYvlmIkp?=
	<Johnny-CC.Chang@mediatek.com>,
	=?utf-8?B?TWluZ3llbiBIc2llaCAo6Kyd5piO6Ku6KQ==?=
	<Mingyen.Hsieh@mediatek.com>, =?utf-8?B?WWVuY2hpYSBDaGVuICjpmbPlvaXlmIkp?=
	<Yenchia.Chen@mediatek.com>, =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?=
	<pablo.sun@mediatek.com>, "helgaas@kernel.org" <helgaas@kernel.org>,
	=?utf-8?B?SmlleXkgWWFuZyAo5p2o5rSBKQ==?= <Jieyy.Yang@mediatek.com>,
	"ajayagarwal@google.com" <ajayagarwal@google.com>, "sashal@kernel.org"
	<sashal@kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	=?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?= <bear.wang@mediatek.com>,
	"david.e.box@linux.intel.com" <david.e.box@linux.intel.com>,
	"johan+linaro@kernel.org" <johan+linaro@kernel.org>,
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
	"sdalvi@google.com" <sdalvi@google.com>, "manivannan.sadhasivam@linaro.org"
	<manivannan.sadhasivam@linaro.org>,
	=?utf-8?B?SGFuc29uIExpbiAo5p6X6IGW5bOwKQ==?= <Hanson.Lin@mediatek.com>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>, "xueshuai@linux.alibaba.com"
	<xueshuai@linux.alibaba.com>, "manugautam@google.com"
	<manugautam@google.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "vidyas@nvidia.com"
	<vidyas@nvidia.com>
Subject: Re: [PATCH v3] PCI/ASPM: Disable L1 before disabling L1ss
Thread-Topic: [PATCH v3] PCI/ASPM: Disable L1 before disabling L1ss
Thread-Index: AQHb1ghREmfBmJpQzUajylJ21PvNQ7KR9+EAgWJ0c4A=
Date: Thu, 5 Jun 2025 11:23:02 +0000
Message-ID: <8a7897f69c6347833c8e37ca5991ab051933de6e.camel@mediatek.com>
References: <20241022223018.GA893095@bhelgaas>
In-Reply-To: <20241022223018.GA893095@bhelgaas>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|KL1PR03MB7056:EE_
x-ms-office365-filtering-correlation-id: 95246ee2-2b78-4d63-3465-08dda423561b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZTVTaWw5bGhwWDJkSjJRelJQcEJEUi9CSTl3cW5WdnhuMFNsTmE5dnJ4UWcx?=
 =?utf-8?B?QzcvSFV3d216ckNGdHF1eklxMjVtVDF2aG9kNjBTNTQ5MHV5N0dMeWZNR05D?=
 =?utf-8?B?bFJpSzNOMnRSYktobTZVdVNMQmtqOVgwYmJoRFRkZFJMUU95d25pZHJEOHRG?=
 =?utf-8?B?YktuWUQwTFFFT2FiTDdtQnRZMU5oS1llQW1RWS9aWVBsek9SWEVJdEZwYll6?=
 =?utf-8?B?S3pTNk5oNHBBcnQvL1d2T2QzNEs2aGxYS2dGUWRFWHBkNStiRlErOURnWll3?=
 =?utf-8?B?WFB2aUNVaEJjcTNFb2syM0ZNKzMwbkNSaTAvQUNzcnNMQ251MGhOcnZDWWRh?=
 =?utf-8?B?T0FBSVpqQnNSWXJjbkthMHhHU3JKRE1zcUVBUXN3cFRjTEpzYmdNVERyS3R1?=
 =?utf-8?B?cGFFbFRxNnFEUTJaWnlpQ202M0RESWNwSW4vdlRwWGJHa2lKalFnamh4aW0w?=
 =?utf-8?B?bE9rM094Z01QTU54ZDQvYXhnMTFUYkhhQnJRcUtOREJoaFpiREp3SDg3Q1Vp?=
 =?utf-8?B?andGNzdlQ1VUakJGeVVQSkVTMEJUdndnaGJYUGQzWVNRalJRc3lqRVU5UnVr?=
 =?utf-8?B?YzBKMjkwS2dVRGdyWG1TdTMrOFZuamdRS2Q2VFAwSE81QW53NU51UE1kUGxa?=
 =?utf-8?B?MWNOK0JJbjVXNW1SN2t4a1pwZ0NDM1FMWmgxZlUwQmFRdkNZdS9jNWFNNWV0?=
 =?utf-8?B?ZUhzQjBwVndFWk9QUTBxR1ozcVA4ZG9MSUEwdklFMjdJa2ZVQ2FZTXJsY0dn?=
 =?utf-8?B?T3RTZ2VvNlBjUk45cExqbWcrRGdmSEQ2OVo2UEpIWk1VVHpFbm4zZ2tYVkI3?=
 =?utf-8?B?RitzbUhtNWZkU2Jwckg5WHZuZWNkY0E3MkpaS1FXWDlXNzNLTTR3Z2t1aTho?=
 =?utf-8?B?VTMvWDYzOFpKcDNKU05iMkd1K2RaeDlGWXZ5dTNQT1JXd3BKdjZ6OERkU3JV?=
 =?utf-8?B?c3RBV0M3U21BdUlLeGVIb2x6cVZYS1B3blc0SW9LaitJaWw4MDNQakF4RHFy?=
 =?utf-8?B?a0ZTaUJCdUVibHlSNGxmZiswT1l4SVJMWVZtaDZpSjRBTjFSSmo2a1pNT2ZD?=
 =?utf-8?B?WXNKZmRNaGQ2Y29ScHQwV01DSW4wYmZjdGpSRDE1c2NzQXJnckZ5ZmF0Y0d1?=
 =?utf-8?B?UFk0Rk9qNlFJdzliRSt1eG43dkpsTUlvbmxnd2JVb1JkOFltN1B0Q2NNR0Rn?=
 =?utf-8?B?V3RZT3ZPR092UG9vemZHRHVTb2tjSmZlTjZHSUFSaWdyUTd2Sng0WENpT0tq?=
 =?utf-8?B?ZTUzR3d1WEZIMXFOK0ZjTEhXZGxqcE9aMTdBemJzMmdBRVRmVGFsTStHak96?=
 =?utf-8?B?U09NYWtrYk1iMkY2WlU2WC9NVlJUS0dQMExVS1ZSci9tNjVOUndqV3FPRThk?=
 =?utf-8?B?aE02WG4xbjg3WkpXUXdvWG9udHVYTXFTZUVqN2lXcUwyU0t3UCtkNmVtV3F0?=
 =?utf-8?B?MGRyZWpCUnJxaUdSUzFlanI4YWVlczdnRWsvbHlhdmRSQmVDczBsSlpyVE9V?=
 =?utf-8?B?dVFIRmp6Y21uS3pOOHJ5aUExSHdnU3l2T0Y3SjVWekhxT3I0ZWVRZTl2NytY?=
 =?utf-8?B?MDg2b2JXUVAxN3dqbGlVdW9hY09FZzVOU1lOUytsZTdtRkxZQUlDQ0dTRy91?=
 =?utf-8?B?eU1GSkNEMkt4UTJyVkxCSmpQeGl1VDBUblE5OW8rMEYrNUlhQk5HK1lmV01i?=
 =?utf-8?B?SnAwVHpZb3F2UGFvTVFWWEFYc0RaTU5ob3JQOHBRNkxCQi8yMklab0pWemh5?=
 =?utf-8?B?c1k0ZVZXY3B0em16R3lkWUlrUGxVZDgwRDhzS2sxRUFXcUdlYVdCak93Zmxv?=
 =?utf-8?B?WFErK0RqMVBObzZyMkNGVDRCK3JvdXhSankxMXlXZHRhVGt5Z2lDL2QzeWRv?=
 =?utf-8?B?VFNIV3A4TFZqNmVwZ0FheHk2SVZXeEhuMkxlakdGQS9SMDc1UExnclJhYUVF?=
 =?utf-8?B?cGF2RE5iNjJWekh1ZEg2TlNnWDl2UGhjalRlVy9aT1pQSzZGQmNUb1RVZmlw?=
 =?utf-8?Q?bxradULUsw1d9FEJFrg36d/37IDKlo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB7810.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?andkSXpTRE1aZlNEZFpud2preUE2MlJxL2hSYkZxU2tERXA2a1lTLzB6Rks3?=
 =?utf-8?B?N0VYTlpGUVdSKzdkNTczWjlhNGl0NlRkRDJ5OEFXOUdOeXpvd1E0SzNmTzcw?=
 =?utf-8?B?WVpOQlFkSk5aV2dsSUlZdTFMeGJrRjM4cjkrNVhqeWdqdlV4TC9qZWpKajI4?=
 =?utf-8?B?aHRXV3Y0TGlZbit1UXhiSHE5VDUyRElvcUNidFRBdml4TE5ndWFEVnpXelIz?=
 =?utf-8?B?eGhaSW9mL2NZNnE5WVBuU28vMG5FQVdoM0c4YnJxZFNlZVAyTzRrbEU4Q3Nx?=
 =?utf-8?B?RGlOVC9TQ1JjWllTd0dnNCtjVjdVclFWOUZVaCtETVF4M3R6U1JZMWFrWjZy?=
 =?utf-8?B?S0FyZkhBZmZuUnYzYzB1ckhXaTFPRzM5RXcrMFZvVFltaXp3MjAzaENEajNJ?=
 =?utf-8?B?SUxvNWNuYmNnRS8vTlRUb2N2K0hZMWp5UnlRYjdtUkVMb1VDU3NjTDBNeWht?=
 =?utf-8?B?NUFDM3pJRGZnOVBZdmE0VTlkWFRmZHgvRmQzNnV5ZnhUdG5pL2hoNmJmeHRo?=
 =?utf-8?B?aEhsU3pNYjM4WHB6RWYyOWN5b1hjVG5MZUhrYndpTmNhcU5xRHIzUnAwemk2?=
 =?utf-8?B?dnAzT1RHZWxpUW1jWXM1MFg4aVorRzlhN2x6bGV5RmV5S1FIWXNycFhzS0c2?=
 =?utf-8?B?WFpzTU5GZmZuWGlUQktTSStYWmFKQjhvakJObFlEbklFTm5UbXY5SFAwV3FW?=
 =?utf-8?B?MXVXeDlCaUpBbXNVak81R082RGxwZlgyZGl4UkR3bmxRVVlIcmNTUkNVNlNT?=
 =?utf-8?B?alcyMkRpUlRpR3B1NE5HOWxNVlA3SlRoeUpqYzRWV3VxaysxUmxVNHFvSEg0?=
 =?utf-8?B?N2UxcEYzK0VFMWRYM1Z0QXhwV3U5SEZYazYrVHBLcmZsc1ZGWHdXc3JVcSt4?=
 =?utf-8?B?YUloUVRKNEVIVWxUamNXUlNQMzZkeWg1RUltdGI3VW82SG1Dd1cyYWdKK1JZ?=
 =?utf-8?B?KzlxQzJPMXI2KzBOWmx4MGRXMFhPOTdXSWlRcUpqNkhqOVdIL0Z4SWZ4V2Ji?=
 =?utf-8?B?WjVsY2ZBbEVqV2Z5Tnh3dDBsUWFoeDl1Q2lQVS9FMTBtSlRyaGljRERSNm9T?=
 =?utf-8?B?WnJaS0tGcFd4QTVyV3B6dUlBV3hhLzJsampNNmR5MWRrdEJBUFJ2MVZhUjA4?=
 =?utf-8?B?a3QwbXVHVUdaQkpLT0xaS0RicW1vclZzSDE2OVFGN1VPNEdWVmVxVlExeVN2?=
 =?utf-8?B?N2NqcWVLcWFtUHRJTDhGemhuYzFFeGE2YWw3MEUyaE85YVdZVTBqTDBZNWND?=
 =?utf-8?B?WmUrRUFCQW1uZE1tYlV5TVNYWGU4dURsOUtGcHl6SUtnM3pFVVJGa2Vsa2ND?=
 =?utf-8?B?NTIvRmhQbFpBWk5kREFxakVSVExINkoydVJxOGFXZy9pQTJzUkgzb29VaTIy?=
 =?utf-8?B?bmdMK0wvS0tSdFlTeENkSjBZTzJKNENhdHVQVG9MVk1oKzNGaVFBNnJKdXFB?=
 =?utf-8?B?aytycVR0UWxNaGRqOGtXMCt4bnRjNGlkYzk1MDRSOUExWlFDY2RhZmUxMGFJ?=
 =?utf-8?B?VWk1ZkVDRFF5QzhPRk5Vc1ZYNW9FZ1B5MktyelBYdTF6NUFSYkhYN3o3ZzBn?=
 =?utf-8?B?bm95S1ZwUnJ6VFhIbXFVc3BBT0gxdEJBQkZoUkQ5bHNCUkVuaCtva25jWmU1?=
 =?utf-8?B?elNETE8wTlFsVnZ4M05JV3FxV0xiL3ZlaHkrM0Y0c3NSWVh5aXVqOWVmVmJ6?=
 =?utf-8?B?V1FaUGxIZlh2d3RJKzF4RFgxWjBRSk9CMTFLUmY4Smt1STJKTXRzSUw2djVM?=
 =?utf-8?B?UXdTaG9mbndreFA3M3Q4aFh3NzBTaFhTU0NtVHpCWlVsVDY1VitoNy8zUWNI?=
 =?utf-8?B?aDAyMTBHMVcrbEl4SFMwWnhKdlpteXZCOWFwTG9aZGxvUlVHOC9xZHg0cE1Y?=
 =?utf-8?B?bFNGVlhadzBiaGxmSDZEL29Eei9qR011MytpeTIwVmtNVVJLOTlDTUtLUE5n?=
 =?utf-8?B?UmRVQTlQaUdnVm42R042VjgxQmh5WjBFOTA1OElGNnFodTArei94UW9GOVBz?=
 =?utf-8?B?VHlZUldsWDFDeEphNmtvTUlaYzQxemhBd1dYZXIvTE42a2FQRW5EdGNROGRC?=
 =?utf-8?B?SEtIRWIvQndOSzVSM05GMHhvSWNpWS9ycmFwMUVYUFByOXFKYUNZMHRBRC9K?=
 =?utf-8?B?dEpZUkJhOXhONHBGcEhocWxnT3VnRStHK3BtcWtESVlkczFMZkt0NGdmZXgv?=
 =?utf-8?B?Rnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <78169065EDC40F44A4C2367FF499796B@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95246ee2-2b78-4d63-3465-08dda423561b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2025 11:23:03.1616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GpSgmcrcK4qWrtOs0aqWW+il5XwC3nRJzsmHpLrYOJKV0w06L/BPGVQ5af2RXmqvgv9RVPdvG6z6/MylBlYqkND4W/hu0siu70eyGy9Fvt8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7056

T24gVHVlLCAyMDI0LTEwLTIyIGF0IDE3OjMwIC0wNTAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0K
PiBPbiBNb24sIE9jdCAwNywgMjAyNCBhdCAwODo1OToxN0FNICswNTMwLCBBamF5IEFnYXJ3YWwg
d3JvdGU6DQo+ID4gVGhlIGN1cnJlbnQgc2VxdWVuY2UgaW4gdGhlIGRyaXZlciBmb3IgTDFzcyB1
cGRhdGUgaXMgYXMgZm9sbG93cy4NCj4gPiANCj4gPiBEaXNhYmxlIEwxc3MNCj4gPiBEaXNhYmxl
IEwxDQo+ID4gRW5hYmxlIEwxc3MgYXMgcmVxdWlyZWQNCj4gPiBFbmFibGUgTDEgaWYgcmVxdWly
ZWQNCj4gPiANCj4gPiBXaXRoIHRoaXMgc2VxdWVuY2UsIGEgYnVzIGhhbmcgaXMgb2JzZXJ2ZWQg
ZHVyaW5nIHRoZSBMMXNzDQo+ID4gZGlzYWJsZSBzZXF1ZW5jZSB3aGVuIHRoZSBSQyBDUFUgYXR0
ZW1wdHMgdG8gY2xlYXIgdGhlIFJDIEwxc3MNCj4gPiByZWdpc3RlciBhZnRlciBjbGVhcmluZyB0
aGUgRVAgTDFzcyByZWdpc3Rlci4gSXQgbG9va3MgbGlrZSB0aGUNCj4gPiBSQyBhdHRlbXB0cyB0
byBlbnRlciBMMXNzIGFnYWluIGFuZCBhdCB0aGUgc2FtZSB0aW1lLCBhY2Nlc3MgdG8NCj4gPiBS
QyBMMXNzIHJlZ2lzdGVyIGZhaWxzIGJlY2F1c2UgYXV4IGNsayBpcyBzdGlsbCBub3QgYWN0aXZl
Lg0KPiA+IA0KPiA+IFBDSWUgc3BlYyByNi4yLCBzZWN0aW9uIDUuNS40LCByZWNvbW1lbmRzIHRo
YXQgc2V0dGluZyBlaXRoZXINCj4gPiBvciBib3RoIG9mIHRoZSBlbmFibGUgYml0cyBmb3IgQVNQ
TSBMMSBQTSBTdWJzdGF0ZXMgbXVzdCBiZSBkb25lDQo+ID4gd2hpbGUgQVNQTSBMMSBpcyBkaXNh
YmxlZC4gTXkgaW50ZXJwcmV0YXRpb24gaGVyZSBpcyB0aGF0DQo+ID4gY2xlYXJpbmcgTDFzcyBz
aG91bGQgYWxzbyBiZSBkb25lIHdoZW4gTDEgaXMgZGlzYWJsZWQuIFRoZXJlYnksDQo+ID4gY2hh
bmdlIHRoZSBzZXF1ZW5jZSBhcyBmb2xsb3dzLg0KPiA+IA0KPiA+IERpc2FibGUgTDENCj4gPiBE
aXNhYmxlIEwxc3MNCj4gPiBFbmFibGUgTDFzcyBhcyByZXF1aXJlZA0KPiA+IEVuYWJsZSBMMSBp
ZiByZXF1aXJlZA0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEFqYXkgQWdhcndhbCA8YWpheWFn
YXJ3YWxAZ29vZ2xlLmNvbT4NCj4gDQo+IEFwcGxpZWQgdG8gcGNpL2FzcG0gZm9yIHY2LjEzLCB0
aGFuayB5b3UsIEFqYXkhDQoNClRoYW5rcyEgTWVkaWFUZWsgYWxzbyBmb3VuZCB0aGlzIGlzc3Vl
IHdpbGwgaGFwcGVuIG9uIHNvbWUgb2xkIGtlcm5lbCwNCmZvciBleGFtcGxlIDYuMTEgb3IgNi4x
Mi4gd291bGQgeW91IHBsZWFzZSBwaWNrIHRoaXMgcGF0Y2ggYWxzbyB0byBzb21lDQpzdGFibGUg
dHJlZT8NCg0KTElOSzpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVs
L2dpdC9zdGFibGUvbGludXguZ2l0L2NvbW1pdC9kcml2ZXJzL3BjaS9wY2llL2FzcG0uYz9pZD03
NDQ3OTkwMTM3YmYwNmIyYWVlY2FkOWM2MDgxZTAxYTlmNDdmMmFhDQoNClRoYW5rcyBhIGxvdC4N
Ck1hY3BhdWwgTGluDQoNCg0K

