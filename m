Return-Path: <linux-pci+bounces-13993-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC73994593
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2024 12:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 052F828174A
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2024 10:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6791C0DF3;
	Tue,  8 Oct 2024 10:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airoha.com header.i=@airoha.com header.b="axXqIF0i";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="wUKH9NFc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB11A192B91
	for <linux-pci@vger.kernel.org>; Tue,  8 Oct 2024 10:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728383943; cv=fail; b=X51uZ5FeOQ9CE/1plkCSTn0/NTio6dxWa0gjPWEIZQ7sHa4UwSX5WT8hqDO8suN4jb/Tq0YMjLhwfDpamrpGqnXtXbaxy09P8XH6P8gggEV85tRrujO16rZpFhrNpRkpcy3/WcEKucAMsdgDPoNUIOUr0jU54bzC+WIzz0rTXuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728383943; c=relaxed/simple;
	bh=odsCNxGyZSszbMw307stEPS7dTjJCQIIn99jb+KRQXI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=antQKakSvEv3udN2z6vlBN7ROBEei9sYppUwv5M5pmBX9bNSEGla402FwPDQ2oqBTAsju+nnscgBsHqOtf0xHt4Mpv3Yr3DlU0yrohs6YEf/E4OsH1fx7x1orJKbum9aCElPLEm5fKWKJU7Ukm8BqFYI6748lgjb7Pxy7Qcw6cQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=airoha.com; spf=pass smtp.mailfrom=airoha.com; dkim=pass (1024-bit key) header.d=airoha.com header.i=@airoha.com header.b=axXqIF0i; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=wUKH9NFc; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=airoha.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airoha.com
X-UUID: 83fb3ff0856111ef88ecadb115cee93b-20241008
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=airoha.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=odsCNxGyZSszbMw307stEPS7dTjJCQIIn99jb+KRQXI=;
	b=axXqIF0iDGTP8pyRAslPUEvgGjdgOib7u7RaVMhRQlGDn4jCzwcEQ8bhPjr6rTcB3MJzrcX82qdeuY0Ndpwqt2RoDOelDzmkNjWbzj0132ZFP3ADhXuGsUAbhPayzkEZjgX+N4Cz0a2qgGX5IeLxhSq4Du55190trquNV8AkHEU=;
X-CID-CACHE: Type:Local,Time:202410081824+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:2505a3de-3604-43ae-bf63-471ae717581c,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:2399ed64-444a-4b47-a99a-591ade3b04b2,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:817|102,TC:nil,Content:0|-5,EDM:-3,I
	P:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,A
	V:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 83fb3ff0856111ef88ecadb115cee93b-20241008
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <hui.ma@airoha.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1439170047; Tue, 08 Oct 2024 18:38:54 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 8 Oct 2024 18:38:52 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 8 Oct 2024 18:38:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nm7Z4UqCqyLZ3rNxyhHvUuDRpr9hcyyLSVUrbiHsZigjPARfY7aKcwIG4IWEGoFjlzaBfq8fHufPrChHrEbLeR8WP4O3n65laOi56cs9DCAd/sA5z7EyCvmv/B9nJPQItDHiqFjKpsKRtaoDdskFBUpXD44VMCuIHPw7W55yu7bzCSoxyumsTo9ZJQGNKly16FiziZW4QJdeQBZ5LOeCyseMyoqlMCYK1b5atBEqvG9Keo2ImtGnx6EBTCqpJeyNoKwBb6Z7RGEBbW/DqrFN1GicMP/XUpZdKzVQS7R8XVtPdBqmf7Lhjvdq8sUnqmxI9Yop+aS/18KlUvYo1xiwZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=odsCNxGyZSszbMw307stEPS7dTjJCQIIn99jb+KRQXI=;
 b=quO49QlJ+Oqymil0aLRTnewv1wtcjau9wQF1e6pI9+IQVr9LaqWT51enZMlOAm/biwHbWPDuAE6DyDqMVzyTqwGTN5wEC/f2ffsIKGPA21mpbHfX44aosgy9hFGhOHxikZTdU3prjczpvxB3wuB4HVWn3tHR/bh96VZYv1ZgRLB31kYqd2qSqPvrk6E7aq71fPRnx1qs0K/7OPXR5fyqk0QqKhqfPdXtrLhLmrU4BqIModp9rrTVwTjiuOU5gm+T6Ucu/ZHMIoiNnKTMM2fYF/WtO0PXLUjmidyFpIEFHwK2Rsd6MHPOj25xaqyIbZ2IA8pxf7et6Rs2vOR/NeONeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=airoha.com; dmarc=pass action=none header.from=airoha.com;
 dkim=pass header.d=airoha.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=odsCNxGyZSszbMw307stEPS7dTjJCQIIn99jb+KRQXI=;
 b=wUKH9NFcqb7qJHHccolxhkwZ/NXROlTs4gbWJxRhVq6hdV1bsohM45tnBGgfE9svfcZeQcUTGoMNrRtvzQXRB8VSecOLae0E+PaI+klfDOEuJvdxc5N+tyuGde3mz0yTIy4j44o7HkkUgK3riOlMn80drDb+At6CyxjClbMNaIs=
Received: from SG2PR03MB6341.apcprd03.prod.outlook.com (2603:1096:4:178::8) by
 KL1PR03MB7490.apcprd03.prod.outlook.com (2603:1096:820:e3::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.23; Tue, 8 Oct 2024 10:38:50 +0000
Received: from SG2PR03MB6341.apcprd03.prod.outlook.com
 ([fe80::619e:4ef8:147a:3554]) by SG2PR03MB6341.apcprd03.prod.outlook.com
 ([fe80::619e:4ef8:147a:3554%5]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 10:38:50 +0000
From: =?gb2312?B?SHVpIE1hICjC7bvbKQ==?= <Hui.Ma@airoha.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
CC: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ryder Lee <Ryder.Lee@mediatek.com>, =?gb2312?B?Smlhbmp1biBXYW5nICjN9b2ovvwp?=
	<Jianjun.Wang@mediatek.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?gb2312?B?S3J6eXN6dG9mIFdpbGN6eai9c2tp?= <kw@linux.com>, Rob Herring
	<robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Matthias Brugger
	<matthias.bgg@gmail.com>, Christian Marangi <ansuelsmth@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, upstream <upstream@airoha.com>
Subject: =?gb2312?B?u9i4tDogW1BBVENIXSBQQ0k6IG1lZGlhdGVrLWdlbjM6IEF2b2lkIFBDSWUg?=
 =?gb2312?Q?resetting_for_Airoha_EN7581_SoC?=
Thread-Topic: [PATCH] PCI: mediatek-gen3: Avoid PCIe resetting for Airoha
 EN7581 SoC
Thread-Index: AQHbCzbxAYsGTvHhZkiHFxmBi8znG7JlIyiAgAum6QCAAWpzAIAKkQXw
Date: Tue, 8 Oct 2024 10:38:50 +0000
Message-ID: <SG2PR03MB63414B9F1252ECB5400EA116FF7E2@SG2PR03MB6341.apcprd03.prod.outlook.com>
References: <d8941149-9125-4fe2-a1c0-ab29223a0c87@collabora.com>
 <20240930193756.GA187798@bhelgaas> <ZvwuIBr2V_FFbYYA@lore-desk>
In-Reply-To: <ZvwuIBr2V_FFbYYA@lore-desk>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=airoha.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB6341:EE_|KL1PR03MB7490:EE_
x-ms-office365-filtering-correlation-id: dc81050b-3524-4ba9-3859-08dce7856595
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?gb2312?B?cENsZ0V4b0llNG9GTVY2NGpVSFhHYW1US1lib3JlNkw0Ni96bUpyOG1UNFo1?=
 =?gb2312?B?Nnh1R1o1SkhTNVNWU0t1NWpXd2FNZFdLcVU1eHc0R2Y4bXQ5OHFTc29kbElG?=
 =?gb2312?B?VXR1NVV1ZUl6WnVCWW9vbTdEWmJ4TjRCQ2Z6eGNBT3JpM1NTNVhsMGFYWlFl?=
 =?gb2312?B?MEp3citRemF3cjVVVEExT1Z3cU5SSWVwRjBudmZIZW5abTJ2dkFiREVmWWRE?=
 =?gb2312?B?cWdhazJBRGtTbDc0ZFZkdXVGa3JxTzJyeHZFTWNRMGQrQzFIU0dnb1BraU8x?=
 =?gb2312?B?VkxiY2NZeHlMVkZoUnFrZ0dDR2U2K3B6c1dzM0ViaVJHR0h1aGVTaVRQT0FS?=
 =?gb2312?B?RU1UWlhCb3FDRWNqaEtwVGt0UzNmeGlGbXJCTmhLYzR4UTFOMXVUb0RxR2xt?=
 =?gb2312?B?ZU1LQXVlandod0oyZC9Qc3pwbmZhSE9IRHp1NzBBZ0wzeDExM1FiT0loNnRX?=
 =?gb2312?B?UWVNSUNYMzl6dTluZFY1MGZZN2RRZzF5RTdNNkNZTmFTdkIvL2FPUGw0SmVG?=
 =?gb2312?B?SXlrMWhBRnQrQ1RCcitYK3J5OU1wSTI4Q1VsbC9EY0dmNkt4QnQyTVNyZWlx?=
 =?gb2312?B?V2txOUdTTmhGanpsUTFhNHNJSUVoMi8xWEg1VjhxSU5VY3llZkVuczJzU0NK?=
 =?gb2312?B?azRSNVUwK1NrUzB1Zms0Qk9LbWV1TUowZ2JrVFNLVXd3S2RDQldqc21xWXRF?=
 =?gb2312?B?aHkyWU1Ia1RSWklZTlZ3ZndHQkdWcTBDa2VQM003VGlJR3ZGbXY3YU50b3hh?=
 =?gb2312?B?QVdZcGpKYVhUclRoYy9Fd3dacm0zMHBPV25tbHljbjVXcHo5THE1MUs2bjhJ?=
 =?gb2312?B?cXh6ekhsSmxFNDgwS2ZDNUtoT0lhSzJtbmtZeXBCYWptbmZpbGpuTTY2aXVQ?=
 =?gb2312?B?cEsrWVhicXQ1SjRERzdFdXJDSk1wZEk3TG5keHozQk8yTjlHQW1ITHQzeXJV?=
 =?gb2312?B?ZkUvaVZ1Y0pMWEtpWG5Ba1p6a0M4cnRsNXVtSFlYK0d3MHNhc0hYTGdUNzZ6?=
 =?gb2312?B?b2sxakVjcmgrazl5aEtYaFk2eVFzZ3ZsQXJlOXVxZGVUTU1XVHg1RTdtU1dE?=
 =?gb2312?B?cU15QzgrL0JRSHBoZkx1NVkrS1c0bXkyREtaN1pJS2N6TXJyZVREZHM5TStx?=
 =?gb2312?B?SDh3YVRyamFLZldwejRJVCtzWE9BUDArY2RCUHMyR0I4cU5MbEt5SWNtVy9x?=
 =?gb2312?B?MW54OC91RWgvR2pzcnVGMkNYeFkyRHY1L21PNThkc0hseldFTE9SUkxjR29j?=
 =?gb2312?B?Ry9ZS013dnh5WnpGSHRybSsyVmY5Z3l3QWVBWUd0c0JzMWJvakw1SkVFMk9G?=
 =?gb2312?B?UzlTQ010OEVnZjJXMHpWdU9jdWc3dVRvdTNnaERpZld2b2diMmR4ZkVIRlpi?=
 =?gb2312?B?c284RTc1MXhmd0NtNTV4ZEpiQTNuV1FVejExeU05dXc3RFpuZGtNT2tMK1BE?=
 =?gb2312?B?TW9tL0FuYnR0Y25tL1BWTzFaNnMyc1B6WFR2ZmlVd0t0SWR4MktUWEFOSW9V?=
 =?gb2312?B?YXYvb1JzQnFnNWV0NldrUXQ3ZlZHcDhoRWUzSnZiTXJOYmdMQWQwZTM3SHAy?=
 =?gb2312?B?VnVYZlpTYWNlQXdsWDcydjh2WmhhK1J1R1YvK2JJMEJ2REdFWGd2ajd1UkdL?=
 =?gb2312?B?eVdkNjZ6dnpGT2N1R2RtTStGSHJyVnpiUFkwS2FmK0JTL0xMK0JiTnVIK3pS?=
 =?gb2312?B?cXErSUREUzRsdzlLRWVWRkRwRjJaM3pvTitGdDQwTzJadVVMMmRyQVNRTGM3?=
 =?gb2312?B?RE9iaEo3V1cvMkNiU3ZsQ3MzdzVaQ0JGRStXaS9QWThndEtTNlFsQXBLMXVJ?=
 =?gb2312?B?UmdFcXhMc2VHa0U3Ym5uQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6341.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?YzdSNHBML0FaMWVXU2g2VTJaWWNPdlludkx4NGwrYzhYdHJteHlYbDdmNS9Y?=
 =?gb2312?B?STNJSUtLMFpIZmllYVpxd21rWmZXbnpKVzhRTjdCQXlIZEpveVV5TGhNQXJl?=
 =?gb2312?B?eUxvVFpCMVFDMDhRRDBaaTk2UTcrd1MvZXhyWlJpK2VxbzVMREpVRUpKUXkw?=
 =?gb2312?B?dm1TaFVSdjdBMW4vMUdhSGpnc1VLbENLWWxmMkVmYmNnYW04c2hlS3pwZWFE?=
 =?gb2312?B?bzR2L21sdHZFZ2Z4TVpNZTM2T3pheHo1MGFRVVBKbDNDcTQ1M3hJZ0g4VXZ3?=
 =?gb2312?B?NU9RVHEwdVI3anNoaE1COVg3Wmg4UUpueTlhT1NRa2ttN1JYdi9pQlJFLzBQ?=
 =?gb2312?B?cHFwRlhMZmJITHFXVEZzeStHN0Jpb0VneFZOQm9nNDBqSUdhUzB5bDNZU0Zo?=
 =?gb2312?B?T0IxWTlYTk1SMG9Wb3Fod3B3dmNnQ0JpVUxzM084aGdOZHRKQVRQV090b3dq?=
 =?gb2312?B?bUkxaFNzNXd2ZzF1Qi9MV0FIelFXdWFwOXZZM0VnUGltTng0TUpRUFo2Zk5Y?=
 =?gb2312?B?QnB0NWNtODJleHhvKzVFTlkxbDhIRmRiUmFQK1VwOXF3NGhmeVdPajE4RXJ1?=
 =?gb2312?B?dmNKY29GTE8yUUZCQkVkZU5VN2l2YXZ5OHF1WkFzM2NnRkIvbTk1Yy9BS3ZF?=
 =?gb2312?B?a3AwVWY0c3lRN3BJZ3l1V0tEUU5hcDVGdjVoZ1dWZE5OcUpLd2pPQ3pxbEpr?=
 =?gb2312?B?ZlVZTmV0LzNlVVR6Z2NuYUpwUTZUUGNDa1JqaWM1VlVHbHkxRzJZV1A2MVVV?=
 =?gb2312?B?S0NSSG91Tm5ScWZ2UEp3ZnQ2Y0JEdEh1TkpiaDlHeWlMQ2MySGxqK29SbDBp?=
 =?gb2312?B?aWFzbFVmekd5Ui9DYWR2WlowT0FYc2txMDRiUFRKOUx1Z29ZSmhxUUJJYVlR?=
 =?gb2312?B?NUZMYUwxSHBDRlA4cjhPaWpOUERoQUZxVkRKUFZvcDdSc0txUkpCMU5tNVhx?=
 =?gb2312?B?S1JRMXdmd3B3NmEzMWxaNkJXSW1KT0ZJQWdwazA3N0RlSGdRY3RLUTFpY3Vy?=
 =?gb2312?B?ZjFBdXlWTmh2RXNjNjIzQlNxcVlUMXNtSGpkMW5hYmVEUTZNZmQ5WGsybjUv?=
 =?gb2312?B?eXFnNzR1azZtUGloeXZnV0dQNE5vdlhEQ0hmSkp1OVhVV09uSWc5NzZRc1JK?=
 =?gb2312?B?K2dlN0VjVHM1TGNBUzdLYkhKdDNLUHN4bXkzSTQ4SmpFSU52aGZmV0F0ZW1k?=
 =?gb2312?B?d21mS2orMTU0SXhoYzRVMTBSSkkwWi81WWNJVi9TT3Iva0VjcXFxUzNzcTlY?=
 =?gb2312?B?TTRDV0ExbWNFcFIxTTNmSFUwRmZmV0NWMmxlTGN0Y1hIa1lHWEFkNExrQWVH?=
 =?gb2312?B?TnZwT1VzREJxdnZFSHlJUzNGQWhlY0ZEUU1KdWlIb0hZRHdDOTZESVNjSkZk?=
 =?gb2312?B?aGRGQjJJS0Joc0JhbG1Bb09kOGNsenhnTnRnY0JDV0prL1N1SDJHNUNPTzFi?=
 =?gb2312?B?V3I1RytWVndFUjhJVmZLaFMyd2VpYjdoV3p4bDlmMEMyVWIwNjdBNk1GR0Vz?=
 =?gb2312?B?dDNXM1E3TkY3akx4VHdaSnI4RlRWQzhhOFZEU0phN2VTMzZuSDRRM1M3NzZZ?=
 =?gb2312?B?azNxS0JJRXZVeXpYTWJNdGZ0WTZpYldIeDVzcUxVWG9TSUZuY3NuWUYrYjBK?=
 =?gb2312?B?S2FNUElRdzBleFZwTkwzeWtBNnFrRmV1VkwrQmhFRmR3RkFja0dQQ0J6b09O?=
 =?gb2312?B?QysrcnpYcWJleDlFZGZ4aHM3Zm5hR2l3eTdDV3YrenhkRkNLbVFBZXVQK3JB?=
 =?gb2312?B?OU15bTliK1ZScnJwZXA3cktmQWFWQlpFZU1nYlNtMVFieElGSkdFSjNYWjVH?=
 =?gb2312?B?dVpyL21NK0VwL3A0Um9aZVJTRExxUExRaE8rNFNCZ01VSDJkZEN2ZGR4Rk1B?=
 =?gb2312?B?TUxCMkZya203UHhvclRYYndtcDZ3ZFNUVWhBcElETkhNSUoxMWx0NG0rcG9q?=
 =?gb2312?B?TEd2aFNZMmxIaERUampDblNKMGsrWUxwNWFZMkI3UVEyUk1LdzZGY3lWSmdP?=
 =?gb2312?B?MmdTZm0xcEdOZE5Vb3lCY1BicWdQTjBldkZuNHppZjlHVnM1elgvNUtjVDBu?=
 =?gb2312?B?dlNBNHVuN1NSQm5qR1FqTWQ1Mm9VU294VWw5NlNnRkhoenN3ZVE3RWg1VHIr?=
 =?gb2312?Q?hbIc=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6341.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc81050b-3524-4ba9-3859-08dce7856595
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2024 10:38:50.0622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0yE02qnMJwIWv5ctNMQ5vsBzv0xIvknQFNOacdwOLM9NSqt8W7WjusOFiv8RtSvVIFmarsHkyLbubjPr2yvfoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7490
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--24.566500-8.000000
X-TMASE-MatchedRID: oMBNC5/fKrVbRbA/K/rHzN7SWiiWSV/1YefZ7F9kLguKlJ71TX9+g+FO
	X8NbYMhe31CIXhZE19Oph0miZI9ZJ1CXPvPMAtE+6vGX8vR+hqgPRI8ISSLxYsUdzAovpQT/c74
	WeISlC9spLWfglywyPuFWnXoRkATVPXdZx1sZHpAwiJTf3kjwfQrefVId6fzVR2YNIFh+clGozw
	9gka4divJH9UPjIVkv5EB0pvh6nLp3VjVXh/TSj4dlc1JaOB1TrHCvytg5b47nnSt+j12Cls4kL
	9su4eXSTZzKGE//pVl+jYofh6xrhf7OqtLSejYQl1zsjZ1/6ayBv2paO3NlNxHfiujuTbedSAKU
	IhfaB7CDYpkoit6PUOYWy83By29WNsajeS/qEBLCu3097eieeVctRqnPrLuBmyiLZetSf8n5kvm
	j69FXvFTfMl1spgOijaPj0W1qn0SQZS2ujCtcuA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--24.566500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	7AEE3627E0C8249B8E1DCE913352DA5D955B8F496C87760B5CEC1FF0AC7CCB322000:8

PiBPbiBNb24sIFNlcCAyMywgMjAyNCBhdCAxMTo0MTo0MUFNICswMjAwLCBBbmdlbG9HaW9hY2No
aW5vIERlbCBSZWdubyB3cm90ZToNCj4gPiBJbCAyMC8wOS8yNCAxMDoyNiwgTG9yZW56byBCaWFu
Y29uaSBoYSBzY3JpdHRvOg0KPiA+ID4gVGhlIFBDSWUgY29udHJvbGxlciBhdmFpbGFibGUgb24g
dGhlIEVONzU4MSBTb0MgZG9lcyBub3Qgc3VwcG9ydCANCj4gPiA+IHJlc2V0IHZpYSB0aGUgZm9s
bG93aW5nIGxpbmVzOg0KPiA+ID4gLSBQQ0lFX01BQ19SU1RCDQo+ID4gPiAtIFBDSUVfUEhZX1JT
VEINCj4gPiA+IC0gUENJRV9CUkdfUlNUQg0KPiA+ID4gLSBQQ0lFX1BFX1JTVEINCj4gPiA+IA0K
PiA+ID4gSW50cm9kdWNlIHRoZSByZXNldCBjYWxsYmFjayBpbiBvcmRlciB0byBhdm9pZCByZXNl
dHRpbmcgdGhlIFBDSWUgDQo+ID4gPiBwb3J0IGZvciBBaXJvaGEgRU43NTgxIFNvQy4NCj4gPiAN
Cj4gPiBFTjc1ODEgZG9lc24ndCBzdXBwb3J0IHB1bGxpbmcgdXAvZG93biBQRVJTVCM/ISAgVGhh
dCBsb29rcyANCj4gPiBkZWZpbml0ZWx5IG9kZCwgYXMgdGhhdCBzaWduYWwgaXMgcGFydCBvZiB0
aGUgUENJLUV4cHJlc3MgQ0VNIHNwZWMuDQo+ID4gDQo+ID4gQmVzaWRlcywgdGhlcmUncyBhbm90
aGVyIFBFUlNUIyBhc3NlcnRpb24gYXQgDQo+ID4gbXRrX3BjaWVfc3VzcGVuZF9ub2lycSgpLi4u
DQo+IA0KPiBJIGFncmVlLCBpdCBkb2Vzbid0IHNtZWxsIHJpZ2h0IHRoYXQgdGhpcyBTb0MgZG9l
c24ndCBoYXZlIGEgd2F5IHRvIA0KPiBhc3NlcnQgUEVSU1QjLg0KPiANCkhpIEJqb3JuICYgTG9y
ZW56bywNCgkiRU43NTgxIGRvZXNuJ3Qgc3VwcG9ydCBwdWxsaW5nIHVwL2Rvd24gUEVSU1QjPyEi
DQoJVGhlIGRlc2NyaWJlZCBhYm92ZSBpcyBub3QgZXhhY3RseSBhY2N1cmF0ZS4NCglFTjc1ODEg
c3VwcG9ydCBwdWxsaW5nIHVwL2Rvd24gUEVSU1QjLkJ1dCBFTjc1ODEgZG9lc24ndCBzdXBwb3J0
IHJlc2V0IFBDSWUgZGV2aWNlIGJ5IGJpdCBQQ0lFX1BFX1JTVEIgb2YgUENJRV9SU1RfQ1RSTF9S
RUcgcmVnaXN0ZXIuDQoJRU43NTgxIHVzZWQgMHgxZmIwMDA4OCByZWdpc3RlciBvZiBFTjc1ODEg
U29jIHRvIHJlc2V0IFBDSWUgZGV2aWNlIGluc3RlYWQuDQoNCglXaXRob3V0IHRoZSBwYXRjaChB
dm9pZCBQQ0llIHJlc2V0dGluZyBmb3IgQWlyb2hhIEVONzU4MSBTb0MpLHRoZSByZXNldCBzZXF1
ZW5jZSBvZiB0aGUgY3VycmVudCBjb2RlIGlzIGFzIGZvbGxvd3MuIA0KCXN0ZXAxLnNldCAweDFm
YjAwODM0o6g3NTgxU29jIHJlZyx1c2VkIHRvIHJlc2V0IFBDSWUgTUFDo6kgW3JlbGVhc2UoZGVm
YXVsdCktPnJlc2V0LT5yZWxlYXNlLl0gW3RoaXMgaXMgZG9uZSBpbiByZXNldCBjYWxsYmFja10N
CglzdGVwMi5zZXQgMHgxZmIwMDA4OKOoNzU4MVNvYyByZWcsdXNlZCB0byByZXNldCBQQ0llIGRl
dmljZSxjb250cm9sIFBFUlNUo6kgW3Jlc2V0KGRlZmF1bHQpLT5yZWxlYXNlXSBbdGhpcyBpcyBk
b25lIGluIGNsb2NrX2VuYWJsZSBjYWxsYmFja10NCglzdGVwMy5zZXQgUENJRV9NQUNfUlNUQqOo
UENJZSBtb2R1bGUgcmVnLHVzZWQgdG8gcmVzZXQgUENJZSBNQUMpIAlbcmVsZWFzZShkZWZhdWx0
KS0+cmVzZXQtPnJlbGVhc2UuXQ0KCXN0ZXA0LnNldCBQQ0lFX1BFX1JTVEKjqFBDSWUgbW9kdWxl
IHJlZyx1c2VkIHRvIHJlc2V0IFBDSWUgZGV2aWNlLGNvbnRyb2wgUEVSU1QsYnV0IGRvZXNuJ3Qg
d29yayBpbiBFTjc1ODGjqSBbcmVzZXQoZGVmYXVsdCktPnJlbGVhc2VdDQoNCglXaXRoIHRoZSA0
IHN0ZXBzLCB3ZSBlbmNvdW50ZXJlZCBQQ0llIGxpbmsgZG93biBpc3N1ZSBvY2Nhc2lvbmFsbHku
IA0KCVRoZSByb290IGNhdXNlIG9mIHRoZSBsaW5rIGRvd24gaXNzdWUgaXMgdGhhdCB0aGUgc3Rh
dHVzIG9mIFBFUlNUIGlzIHJlbGVhc2UgYWZ0ZXIgc3RlcDIuDQoJSG93ZXZlciB0aGVyZSBpcyBh
IHJ1bGUgdGhhdCB0aGUgc3RhdHVzIG9mIFBFUlNUIG11c3QgYmUgcmVzZXQgYmVmb3JlIGRvIFBD
SWUgTUFDIHJlc2V0LlNvIHN0ZXAzIGRvZXNuJ3QgbWVldCB0aGUgcnVsZS4NCg0KCVNvIHdlIHNo
b3VsZCBza2lwIHN0ZXAzJjQgdG8gZml4IHRoZSBQQ0llIGxpbmsgZG93biBpc3N1ZSBvZiBFTjc1
ODEuDQoNClJlZ2FyZHMsDQpIdWkNCg0KPiBUaGUgcmVzcG9uc2UgYXQNCj4gaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvci9TRzJQUjAzTUI2MzQxNURCNTc5MUM1OEM3RUE2OUZGMDFGRjY4MkBTRzJQ
Ug0KPiAwM01CNjM0MS5hcGNwcmQwMy5wcm9kLm91dGxvb2suY29tDQo+IHN1Z2dlc3RzIHRoYXQg
bWF5YmUgdGhlcmUncyBhIGhhcmR3YXJlIGRlZmVjdCB0aGF0IG1lYW5zIGFzc2VydGluZyANCj4g
UEVSU1QjIGRvZXNuJ3Qgd29yayBjb3JyZWN0bHk/ICBCdXQgc3VyZWx5IGZpcm13YXJlIG11c3Qg
aGF2ZSBhIHdheSBvZiANCj4gYXNzZXJ0aW5nIFBFUlNUIywgYXQgbGVhc3QgYXQgYm9vdCB0aW1l
Lg0KPiANCj4gSWYgdGhpcyBpcyB0cnVseSBhIGhhcmR3YXJlIGRlZmVjdCBhbmQgd2UgcmVhbGx5
IGNhbid0IGFzc2VydCBQRVJTVCMsIA0KPiBwbGVhc2Ugc2F5IHRoYXQgdGhpcyBpcyBhIGRlZmVj
dCBpbiB0aGUgY29tbWl0IGxvZyBzbyBwZW9wbGUgZG9uJ3QgDQo+IHRoaW5rIHRoYXQgbGFjayBv
ZiBQRVJTVCMgaXMgYW4gYWNjZXB0YWJsZSB0aGluZy4NCj4NCj5IaSBCam9ybiwNCj4NCj5JIGRv
IG5vdCBoYXZlIHZpc2liaWxpdHkgb24gdGhlc2UgaHcgZGV0YWlscy4NCj5ASHVpOiBhbnkgdXBk
YXRlIG9uIGl0Pw0KPg0KPlJlZ2FyZHMsDQo+TG9yZW56bw0KPg0KPiANCj4gQmpvcm4NCg==

