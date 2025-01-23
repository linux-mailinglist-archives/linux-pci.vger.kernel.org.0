Return-Path: <linux-pci+bounces-20275-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5C9A19FA2
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 09:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32A4D3A879C
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 08:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044E020C028;
	Thu, 23 Jan 2025 08:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="mJW8UytK";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="YHdfbBx4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB88020B81F;
	Thu, 23 Jan 2025 08:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737619900; cv=fail; b=XkssucF2Ky2M6nsCaSh/r2ddMzRQWqgOl2+VJiIXnqE6LWZXiaYOSxYMbB2Hk2vRjag3z8G+QpuKepmjvOrWSLgv7WRoq9xqLkfo0n2T2RzDmBo53+GW1B1Zjtp7IKoiMV909cteh1QGmc8nn2b9F4TqMkQEX7iGuVzvKyV4gLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737619900; c=relaxed/simple;
	bh=kStKzpltemDwPzAhO5qRW5Yl0kZx8AKwrzHDDlNG47s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aLyPweKmY/jMROaDIxQsFe4/Nw+H4mAi5zSlFvzMGqetW49djZsOiL9qSppWo2lsiPH/hZxO8deH/odMNRfEOBTEahA76VQHXKBLYO1YdlneRP4KEVaHkF/dYmoc0rL1alQ2qadkf0LdJGLtFUyeyeTH2DeFWpYMjfWZx9F5VgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=mJW8UytK; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=YHdfbBx4; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a3a7380ad96111ef99858b75a2457dd9-20250123
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=kStKzpltemDwPzAhO5qRW5Yl0kZx8AKwrzHDDlNG47s=;
	b=mJW8UytKuV6Q1rrYTYQwoDYTZDrvw+FqBSHNZOQABYGp9kXzVxqoe+qOxyLtlqqZhltypFKebzRQGP6RWLg7vXjBYtGRNF78KEIqMQKDAOn/zk/LrEUxD8QvtBHFx67uIbvzJLd4DWaywm1MhNEILUOh6/vMWhO7VZ0mDBWw8AU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:4d76c4ff-5abb-41b4-8b10-90ccbc0b0c41,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:27089a7e-427a-4311-9df4-bfaeeacd8532,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: a3a7380ad96111ef99858b75a2457dd9-20250123
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <jianjun.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2145838970; Thu, 23 Jan 2025 16:11:25 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 23 Jan 2025 16:11:22 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Thu, 23 Jan 2025 16:11:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZlRAkFYeqAGes6Y+g3ghscKbhWuN+NPYR4kSa1ZsUCC73MqmiQsaXVfl7P5DsAhPyIc4ClA53jLPtPYl+SDfPssbDnUBIUgUlOlOuKnRv41K+1od4t2QyGb+W/dj8N/Tm5BfClC0nJC5nhXWP8/qBdFlC8qcuGdq4yBtx7v5ca3dD4kw10zV9wW8/4OnRmBiBBftqak5rLxpWs0Y9jdM5j2iHqExQdoRDNVi8L4yItIEbLtaWZxZls2hDgHcAavL7F2itNgHnMSB0HXmAaAiqyZNZd7fesIoT6pe28cfAcxuYlFjmiq42g8E5K5SPAAg5Bobs2suAqhmdhQR4HK8kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kStKzpltemDwPzAhO5qRW5Yl0kZx8AKwrzHDDlNG47s=;
 b=xAUyeL1FACWBeYONkqo+oggTOuPherh/bC8BgBFKi6snEggTPg4x6pXPSO97aWCESMBfwy1sOC2XooriydYDwOXHv9p8MTx4hzXmn8ArhUa9JY0WQuteuxIbWBnNhXFZGhunUD81PyjKwcONT1q+dVxw55H0rkyvyRLWHEvfJMeXvdFjSsV/T6Ixgq1v/HaaA0dQiNeqMlfyJ550eCiOq+fQkDEwFCF1PNWgFQiIvqqGAf+j5h0cZ7NSpUt124m0Tb9nEtRDixmma5xA7gGsW8g+hIr87H9BxJzpL1zXXbYz9fkIQxw29ZmD7pRAKW4n6j7OIIY2bjyL00L/mKhGfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kStKzpltemDwPzAhO5qRW5Yl0kZx8AKwrzHDDlNG47s=;
 b=YHdfbBx4m4IhNzKTzssxNH3DoIHV5ejzvJAh8eGtXtbnIh3agZXhh0UGHkEKeAZ0d2wfnd+kQrXNK62vCpnJvuRFDMIxiz1jsXVX3eFG5fvfaozOjD9O7wNF0NLDu1aipb1whgeGtC1uak+kAXE14+79+eyS2Fp0p+jzOrIAbEo=
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com (2603:1096:301:17::5)
 by JH0PR03MB7856.apcprd03.prod.outlook.com (2603:1096:990:2c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Thu, 23 Jan
 2025 08:11:20 +0000
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::1c6e:6591:5151:27e6]) by PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::1c6e:6591:5151:27e6%3]) with mapi id 15.20.8356.020; Thu, 23 Jan 2025
 08:11:19 +0000
From: =?utf-8?B?Smlhbmp1biBXYW5nICjnjovlu7rlhpsp?= <Jianjun.Wang@mediatek.com>
To: "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Ryder Lee <Ryder.Lee@mediatek.com>
Subject: Re: [PATCH] PCI: mediatek: Remove the usage of virt_to_phys
Thread-Topic: [PATCH] PCI: mediatek: Remove the usage of virt_to_phys
Thread-Index: AQHbYMP5Jw313mzyHkGU+7mZHuBB6rMYJTcAgAv2BIA=
Date: Thu, 23 Jan 2025 08:11:19 +0000
Message-ID: <9e629b1779c2cb9c6fa34347ac16f9b4e2241430.camel@mediatek.com>
References: <20250107052108.8643-1-jianjun.wang@mediatek.com>
	 <20250115173156.a73ntoyyn3xy52ze@thinkpad>
In-Reply-To: <20250115173156.a73ntoyyn3xy52ze@thinkpad>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5365:EE_|JH0PR03MB7856:EE_
x-ms-office365-filtering-correlation-id: 75c8101d-78b5-4ed2-6980-08dd3b8584b1
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZElzR2tLUkprYjY2RkIrSXI1NUV2aWV5QkJuVUpab1lueVpWbDRVWVhOMVpo?=
 =?utf-8?B?bkx5VW9TQU5lYlJyVGtaZ2MvUjFtdEczckp2eEpQR1UvM1h4WTZmZG5wdm9L?=
 =?utf-8?B?NWhScmJ6QXptR1IzMEpGU2gvMldrTk1QWDJlR2s0b0Y0MzhDbEFnUksvOVlT?=
 =?utf-8?B?UGZobzdBSnJWRXJkL0ZoN2pyUDZGeFN2Q0NIYUpXWUZRdGxvR1dNYjFxWHpn?=
 =?utf-8?B?Rlp2UnZHZUFHKzkvQVRBdWFlZlM1dTVFNHJEOXpsVlFmM2R1ZEx1RVBmU2FW?=
 =?utf-8?B?VlFnbm1MWTNCbzRJQ0lvSWRYNVIvcCt5SlBQblpxeVNQNDQvNUprY0o4Q29D?=
 =?utf-8?B?amMvTVJKQ25CQ2trMnFmSlF2STdkbE5ieGxDMFhxVTR2Uk9rNExLTUFLRitT?=
 =?utf-8?B?QW9pOU4wcUxaQUZOTG5sMU10NXdJUDcvbDZkNHhwTnoxTkJjWlhKRXlFQ0ox?=
 =?utf-8?B?dzU4QVpKMTAzZlE3N2hpZFBQVEdKZTQ5OTh3RkNuU1N1MEJlZlJhK1ZMdHJh?=
 =?utf-8?B?a2RRWHduTVlpRWRmV015LzM1YlJKa1NCeU9aMjBhbGhGUFR1ejNuUm9xVGh0?=
 =?utf-8?B?Uk1DRHFxZjd0TUwxVkRoRkxCZDNHT09NaEhUcVREaS9ZcEhvT25BVTRCWW5v?=
 =?utf-8?B?UUtuSlRKcGJNbnJTdk5tZk9zMTVTaGlZd1ZPMUs2SHYwaE1sMFlTREtNdWRv?=
 =?utf-8?B?ZmxLdDd3b3YwY05qQi84N09VdWFDdmtETkVud3FvcWFnZG8vRFFpSGlEanBJ?=
 =?utf-8?B?ZWNGUGdRdmRtNlo1TTdzaWJ3Z1UyblJ4VXFqUTVtQ0RGbEl2cW13a0tLbkI4?=
 =?utf-8?B?LzJUVHp6V3loNzZkOTNQbU5SeE5SNkI1c1FCSXFqZFM3RGE5Mi9MWFFvaEYv?=
 =?utf-8?B?ZUpwTkY1dzg0cmpRZG5QamovUWVqOHcrQUlOVUNpNXBVYnNCWGM0dTIrZmxy?=
 =?utf-8?B?SnV5TDR5V1hsTExpbjU4MjBOWnJzOCtGVHlUb2NzSWRTWmJ3V1FNbUh2Z1NL?=
 =?utf-8?B?V3lQbklYYjRDQitRRVFiZ2lTVHJaZUZvbnNaUWFOckdmUGpLTXE1bjg4NTBJ?=
 =?utf-8?B?ZHg0UzBLQ2R0Vm40dHV3aStWQmUxdHZSRy9GZzNYNjFPRFc3QWdla3hNVjEx?=
 =?utf-8?B?WDFyM0hZc24yMkpBLy96Uy8vR2N3WE1uZ3h4N2hleWp4OHduWTFXLzlTRDBO?=
 =?utf-8?B?cGpSZnpIZEU5Uzk3amVLclZOSjFFYmJmd1dPTnNZMTdtMEFxTGdPNWlCQ1lh?=
 =?utf-8?B?NTV1TFdyYUk2d0pmREtFelFBTzYrNUluYUM2NGJRanhzV2pXc0gwQVp1VWF0?=
 =?utf-8?B?UzB2bk8veHNKSVVvUzVDQ1NXeFFzc29UbjZhcnpSZjQ0RTYzUVg2bVRXQldZ?=
 =?utf-8?B?ZUJJVURJRGZkUHlDYnU0R3ZwSGhBK1JvOU8vV0JuSnB6SSs4RW5iTzhrK2hz?=
 =?utf-8?B?REhDb0xESVQwWnVvU0lHWnNFWFIxb0hyaXF6VWVXbHQyeGxMV0MrMU4rMlBk?=
 =?utf-8?B?SGdVZGl4OWszQ1FSeGlGdUZVT2NMSER2eXNBMDVjem9tQ3lLYldmNVlXWkg2?=
 =?utf-8?B?SjBnWHRCUVgrSktIdjRBdWNDTFZ6SkFaaHVSVnJCbTBmNGZZUE1jZ2RyQnkz?=
 =?utf-8?B?b1lJUVo1ZEJ6WDlJMGowR2xjS0tEb2NRQ2JqWXEwUXV4Z2g2MkNIMmRoRDB1?=
 =?utf-8?B?WXQzN2d2RG0yV0FYTWhDem8yaElGNWpJZUNSTXQ0QWliNkMyT094VDFOQ2JP?=
 =?utf-8?B?QUtWVnBESW1IbWhlYXhOWEFyRXN1b01MY1EyejVXaHpVMFNBZXgvWXFXMm5R?=
 =?utf-8?B?L2xZVUJqejdYVU5pUFpVSnNoYzNRajNnWUFONmdTK2hxTS8vT1JCRjVaU2FV?=
 =?utf-8?B?VG83eTFHL2toZHF6YkpuaWkrRkNVTENHOHNLOWM4Szl2TjZnaE1KbzFZRlVh?=
 =?utf-8?Q?YgCWH+AB46V0DN3DbO943aOega7JrGz5?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5365.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Rlg0SURWY1R3ZjhCN0FHSXA5Q1FYYzVGbi9YUWdTQW9XRmJqdDN4a01wS3RE?=
 =?utf-8?B?ZXFmZ0Y1ZVdmdStaa2VMbHVCWjJUTHNLdEh3d29iSG9UUHNIZlNaNy9DMzVQ?=
 =?utf-8?B?RmFJTk1PbjhJU2dIcmNoRERYb2o1U3RPSTA0YWNvZ1Q3VzZHTlNVbDdsUG1P?=
 =?utf-8?B?Qy9odUh5dC85aTZudXhkUHlkaVV2bTcyQVphWGgwNithaUNqTVM4M091amI4?=
 =?utf-8?B?L05peWJwTnBJWTZ5aUkvUU5YT0xqUC83U214ZmpsT0Mzbm45aXR0M0lzMHdj?=
 =?utf-8?B?YlpGSnFjdU5pa0JCRzBSaGdzQ3VxVWlacEFmM2toSmY5SlpmZUxEa3pWbUQ4?=
 =?utf-8?B?UEMyTHpCbHdaTERqbG54TXNDU2JhV1Q2TTJiR3F5TXFOWnNGQXY2UUZLVjR3?=
 =?utf-8?B?V0dWa3dXTjc4cWwyTG05ZUNGUUsrTkxkdFZ5ZnU2Z0twc0p6S2kxTnJUQzBS?=
 =?utf-8?B?VkpiQVo0Z09JbVRGTzFMTVVGanZCR25wemoxem9tWW5IS0Z6Mmx2VTZDTHRX?=
 =?utf-8?B?MERKTTM3SWN3cEtMaUM0VVdwWlQxWGJqclZGSHVVUmtiNXJsMVp0MmVxSEJF?=
 =?utf-8?B?RDlSbVpLbjllclcrL1Q2VFk2ODUzREV2R1lpdkUydG5yR1dqeFFLN3E1czg3?=
 =?utf-8?B?RmdnYVdkMGNDaXFyZ3ltNC9zV2Exb0RXNVEwMExoUWo5NVZSZ0hYQ3JTc1k5?=
 =?utf-8?B?ekVDWS96aEtxalcwMHUycTFja090WDFIMTJLSk1lUWJWRTdvYTdiREI1bmly?=
 =?utf-8?B?WW1Kc21yR1d3am12NzQxU05qVk1nd0l3dDFscHhEU2dvdExId2dzTGlaMW1N?=
 =?utf-8?B?VmhTcFo0NVg4R1lVcmFOczUxZ2N4OWxyQ3VtQkNDTWJWYmpPOUJyYlRhMFRv?=
 =?utf-8?B?aGRmSGI0TGpNSUVkemd6cGtDODhvMU5rYnI5bGtiUmpTLzNKSFJ5OFUzaWFM?=
 =?utf-8?B?MTNidUc0eUdDNzh6Z3g5eVhhS0JEdXlSRXBncTV2TUh2OFZNUlBvMkpPK3ho?=
 =?utf-8?B?cEc5MlRST2pvY3h2TkhlS0hVd21UUWRLeG0wQkxJSkxGb0pOckJlbjhTZ2tF?=
 =?utf-8?B?WUpSOElOam1ZQ1FkNjBJTmJoYmw1RXFwZUpUaUdrTWJjNExCSmU2SEJuYU5K?=
 =?utf-8?B?MXB2NGtNS2Nhc1JnWCtEMWtLWU02SGR5cy8rSHZINy8wVGkvL3JMZjVRVXFK?=
 =?utf-8?B?YVBLckpEQnpqNWxvblFzQkZhTlNEQ1VuVmpWb0FDRWhycWdMOUVtQnlyVUJv?=
 =?utf-8?B?REwvZllQcmlMVXExRkdJNEtPaENNMUlBV243UGcrYXpuV05KVllOakFkcU1B?=
 =?utf-8?B?SkxWalBDaHdIWS94elZ0SUkzK1VscUdMeklwdm5LNVB6SnlzblE0NlM3VXpr?=
 =?utf-8?B?eUhUenh1RVNwdWUrbnhwUlIzU25kOElHbnJGQnZFNjR3QXcvcnkySUluYWU2?=
 =?utf-8?B?aVp3TzBxallPb29uR25Ia0pZSFRPd3VLekJGc2RDNksrbFdZNCtJZmg3eFZ4?=
 =?utf-8?B?ZExXb2d5alNiMGo3M3N2M1Yzb0VCT0Q1Z3ROcVpXbFhRUTMwV0tqM3hoWmdY?=
 =?utf-8?B?b3Z3VFdUSU8rb2dpeWJiUVFJd0lhYmRzT3M1ejdDKzA2b1NIaGpmMGpsL29m?=
 =?utf-8?B?OVBDQk5oUkUwVEkzcXRNeHlaSnhXdGZ0Nmhoenpoa2NxelR1WTRKaVJFLzlu?=
 =?utf-8?B?K01iQy9UUWdIYVllSUZPL3BNaU84YWhzTEkyNWpGTnNYb2hLV3B5dkVoem9k?=
 =?utf-8?B?Yi9FY1c5OTdSOWp2ZWhReUtsbEdhbDlwdjJGQ3pvT0RYSnVIQXArSmxuUzN1?=
 =?utf-8?B?NERjYTU5b2tzeTZUYlpDZlhCSGNPckFaVVpnQ25pSGxkbk1VZ0RIRmlvUDVU?=
 =?utf-8?B?V2RGK1dBVW1ncTBrK3VWczlvbGIyZmdwcHRTZmlCeURrTDJ5YmxnejJ6NTkr?=
 =?utf-8?B?bXlCVUpNbS82djZGekZoZTE0R0N4SWFMU2lKR0MrNTViYzE0UDFZSEt5NjJS?=
 =?utf-8?B?VU5GSHVDdzVmR2xqbmRwWDZTNC9UblNtNVAyaVM5RkllaW53M3hsdHNNdFBF?=
 =?utf-8?B?eWM2RVBsZnlDRjhRaUJ2ZnlqdmRQRitpTEQ3NCtnOGRDcDJpVUI3VHZxTjJ1?=
 =?utf-8?B?b2JMT2ZXZGZZeGp6RFFDRlRxRUZZZHpiU1c5NzlYL3pUYXdNamdZSFIrZUtj?=
 =?utf-8?B?THc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <010A13506F44A247BDBD9D8D9F6B17F6@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5365.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75c8101d-78b5-4ed2-6980-08dd3b8584b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2025 08:11:19.8867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RLusf6XH5oHa3rST4z1B4Wt7O8wNaTn7F/4TktE8z93E1V+i0fuQQrUsXhOx2pReoPNmuW3M+my/MnvHWaD303JdjLoKlOUmFufpf+yu1lQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7856

T24gV2VkLCAyMDI1LTAxLTE1IGF0IDIzOjAxICswNTMwLCBNYW5pdmFubmFuIFNhZGhhc2l2YW0g
d3JvdGU6DQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBv
cGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3Ig
dGhlIGNvbnRlbnQuDQo+IA0KPiANCj4gT24gVHVlLCBKYW4gMDcsIDIwMjUgYXQgMDE6MjA6NThQ
TSArMDgwMCwgSmlhbmp1biBXYW5nIHdyb3RlOg0KPiA+IFJlbW92ZSB0aGUgdXNhZ2Ugb2Ygdmly
dF90b19waHlzLCBhcyBpdCB3aWxsIGNhdXNlIHNwYXJzZSB3YXJuaW5ncw0KPiA+IHdoZW4NCj4g
PiBidWlsZGluZyBvbiBzb21lIHBsYXRmb3Jtcy4NCj4gPiANCj4gDQo+IFN0cmFuZ2UuIFdoYXQg
YXJlIHRob3NlIHdhcm5pbmdzIGFuZCBwbGF0Zm9ybXM/DQoNClRoZXJlIGFyZSBzb21lIHdhcm5p
bmcgbWVzc2FnZXMgd2hlbiBidWlsZGluZyB0ZXN0cyB3aXRoIGRpZmZlcmVudA0KY29uZmlncyBv
biBkaWZmZXJlbnQgcGxhdGZvcm1zIChlLmcuLCBhbGxtb2Rjb25maWcuYXJtLA0KYWxsbW9kY29u
ZmlnLmkzODYsIGFsbG1vZGNvbmZpZy5taXBzLCBldGMuKToNCg0KcGNpZS1tZWRpYXRlay5jOjM5
OTo0MDogc3BhcnNlOiB3YXJuaW5nOiBpbmNvcnJlY3QgdHlwZSBpbiBhcmd1bWVudCAxDQooZGlm
ZmVyZW50IGFkZHJlc3Mgc3BhY2VzKQ0KcGNpZS1tZWRpYXRlay5jOjM5OTo0MDogc3BhcnNlOiAg
ICBleHBlY3RlZCB2b2lkIGNvbnN0IHZvbGF0aWxlICp4DQpwY2llLW1lZGlhdGVrLmM6Mzk5OjQw
OiBzcGFyc2U6ICAgIGdvdCB2b2lkIFtub2RlcmVmXSBfX2lvbWVtICoNCnBjaWUtbWVkaWF0ZWsu
Yzo1MTU6NDQ6IHNwYXJzZTogd2FybmluZzogaW5jb3JyZWN0IHR5cGUgaW4gYXJndW1lbnQgMQ0K
KGRpZmZlcmVudCBhZGRyZXNzIHNwYWNlcykNCnBjaWUtbWVkaWF0ZWsuYzo1MTU6NDQ6IHNwYXJz
ZTogICAgZXhwZWN0ZWQgdm9pZCBjb25zdCB2b2xhdGlsZSAqeA0KcGNpZS1tZWRpYXRlay5jOjUx
NTo0NDogc3BhcnNlOiAgICBnb3Qgdm9pZCBbbm9kZXJlZl0gX19pb21lbSAqDQoNClRoYW5rcy4N
Cg0KPiANCj4gLSBNYW5pDQo+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEppYW5qdW4gV2FuZyA8amlh
bmp1bi53YW5nQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9wY2kvY29udHJv
bGxlci9wY2llLW1lZGlhdGVrLmMgfCAxOSArKysrKysrKysrKystLS0tLS0tDQo+ID4gIDEgZmls
ZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbWVkaWF0ZWsuYw0KPiA+IGIv
ZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1lZGlhdGVrLmMNCj4gPiBpbmRleCAzYmNmYzRl
NThiYTIuLmRjMWU1ZmQ2YzdhYSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9s
bGVyL3BjaWUtbWVkaWF0ZWsuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNp
ZS1tZWRpYXRlay5jDQo+ID4gQEAgLTE3OCw2ICsxNzgsNyBAQCBzdHJ1Y3QgbXRrX3BjaWVfc29j
IHsNCj4gPiAgICogQHBoeTogcG9pbnRlciB0byBQSFkgY29udHJvbCBibG9jaw0KPiA+ICAgKiBA
c2xvdDogcG9ydCBzbG90DQo+ID4gICAqIEBpcnE6IEdJQyBpcnENCj4gPiArICogQG1zZ19hZGRy
OiBNU0kgbWVzc2FnZSBhZGRyZXNzDQo+ID4gICAqIEBpcnFfZG9tYWluOiBsZWdhY3kgSU5UeCBJ
UlEgZG9tYWluDQo+ID4gICAqIEBpbm5lcl9kb21haW46IGlubmVyIElSUSBkb21haW4NCj4gPiAg
ICogQG1zaV9kb21haW46IE1TSSBJUlEgZG9tYWluDQo+ID4gQEAgLTE5OCw2ICsxOTksNyBAQCBz
dHJ1Y3QgbXRrX3BjaWVfcG9ydCB7DQo+ID4gICAgICAgc3RydWN0IHBoeSAqcGh5Ow0KPiA+ICAg
ICAgIHUzMiBzbG90Ow0KPiA+ICAgICAgIGludCBpcnE7DQo+ID4gKyAgICAgcGh5c19hZGRyX3Qg
bXNnX2FkZHI7DQo+ID4gICAgICAgc3RydWN0IGlycV9kb21haW4gKmlycV9kb21haW47DQo+ID4g
ICAgICAgc3RydWN0IGlycV9kb21haW4gKmlubmVyX2RvbWFpbjsNCj4gPiAgICAgICBzdHJ1Y3Qg
aXJxX2RvbWFpbiAqbXNpX2RvbWFpbjsNCj4gPiBAQCAtMzkzLDEyICszOTUsMTAgQEAgc3RhdGlj
IHN0cnVjdCBwY2lfb3BzIG10a19wY2llX29wc192MiA9IHsNCj4gPiAgc3RhdGljIHZvaWQgbXRr
X2NvbXBvc2VfbXNpX21zZyhzdHJ1Y3QgaXJxX2RhdGEgKmRhdGEsIHN0cnVjdA0KPiA+IG1zaV9t
c2cgKm1zZykNCj4gPiAgew0KPiA+ICAgICAgIHN0cnVjdCBtdGtfcGNpZV9wb3J0ICpwb3J0ID0N
Cj4gPiBpcnFfZGF0YV9nZXRfaXJxX2NoaXBfZGF0YShkYXRhKTsNCj4gPiAtICAgICBwaHlzX2Fk
ZHJfdCBhZGRyOw0KPiA+IA0KPiA+ICAgICAgIC8qIE1UMjcxMi9NVDc2MjIgb25seSBzdXBwb3J0
IDMyLWJpdCBNU0kgYWRkcmVzc2VzICovDQo+ID4gLSAgICAgYWRkciA9IHZpcnRfdG9fcGh5cyhw
b3J0LT5iYXNlICsgUENJRV9NU0lfVkVDVE9SKTsNCj4gPiAgICAgICBtc2ctPmFkZHJlc3NfaGkg
PSAwOw0KPiA+IC0gICAgIG1zZy0+YWRkcmVzc19sbyA9IGxvd2VyXzMyX2JpdHMoYWRkcik7DQo+
ID4gKyAgICAgbXNnLT5hZGRyZXNzX2xvID0gbG93ZXJfMzJfYml0cyhwb3J0LT5tc2dfYWRkcik7
DQo+ID4gDQo+ID4gICAgICAgbXNnLT5kYXRhID0gZGF0YS0+aHdpcnE7DQo+ID4gDQo+ID4gQEAg
LTUxMCwxMCArNTEwLDggQEAgc3RhdGljIGludA0KPiA+IG10a19wY2llX2FsbG9jYXRlX21zaV9k
b21haW5zKHN0cnVjdCBtdGtfcGNpZV9wb3J0ICpwb3J0KQ0KPiA+ICBzdGF0aWMgdm9pZCBtdGtf
cGNpZV9lbmFibGVfbXNpKHN0cnVjdCBtdGtfcGNpZV9wb3J0ICpwb3J0KQ0KPiA+ICB7DQo+ID4g
ICAgICAgdTMyIHZhbDsNCj4gPiAtICAgICBwaHlzX2FkZHJfdCBtc2dfYWRkcjsNCj4gPiANCj4g
PiAtICAgICBtc2dfYWRkciA9IHZpcnRfdG9fcGh5cyhwb3J0LT5iYXNlICsgUENJRV9NU0lfVkVD
VE9SKTsNCj4gPiAtICAgICB2YWwgPSBsb3dlcl8zMl9iaXRzKG1zZ19hZGRyKTsNCj4gPiArICAg
ICB2YWwgPSBsb3dlcl8zMl9iaXRzKHBvcnQtPm1zZ19hZGRyKTsNCj4gPiAgICAgICB3cml0ZWwo
dmFsLCBwb3J0LT5iYXNlICsgUENJRV9JTVNJX0FERFIpOw0KPiA+IA0KPiA+ICAgICAgIHZhbCA9
IHJlYWRsKHBvcnQtPmJhc2UgKyBQQ0lFX0lOVF9NQVNLKTsNCj4gPiBAQCAtOTEzLDYgKzkxMSw3
IEBAIHN0YXRpYyBpbnQgbXRrX3BjaWVfcGFyc2VfcG9ydChzdHJ1Y3QgbXRrX3BjaWUNCj4gPiAq
cGNpZSwNCj4gPiAgICAgICBzdHJ1Y3QgbXRrX3BjaWVfcG9ydCAqcG9ydDsNCj4gPiAgICAgICBz
dHJ1Y3QgZGV2aWNlICpkZXYgPSBwY2llLT5kZXY7DQo+ID4gICAgICAgc3RydWN0IHBsYXRmb3Jt
X2RldmljZSAqcGRldiA9IHRvX3BsYXRmb3JtX2RldmljZShkZXYpOw0KPiA+ICsgICAgIHN0cnVj
dCByZXNvdXJjZSAqcmVnczsNCj4gPiAgICAgICBjaGFyIG5hbWVbMTBdOw0KPiA+ICAgICAgIGlu
dCBlcnI7DQo+ID4gDQo+ID4gQEAgLTkyMSwxMiArOTIwLDE4IEBAIHN0YXRpYyBpbnQgbXRrX3Bj
aWVfcGFyc2VfcG9ydChzdHJ1Y3QNCj4gPiBtdGtfcGNpZSAqcGNpZSwNCj4gPiAgICAgICAgICAg
ICAgIHJldHVybiAtRU5PTUVNOw0KPiA+IA0KPiA+ICAgICAgIHNucHJpbnRmKG5hbWUsIHNpemVv
ZihuYW1lKSwgInBvcnQlZCIsIHNsb3QpOw0KPiA+IC0gICAgIHBvcnQtPmJhc2UgPSBkZXZtX3Bs
YXRmb3JtX2lvcmVtYXBfcmVzb3VyY2VfYnluYW1lKHBkZXYsDQo+ID4gbmFtZSk7DQo+ID4gKyAg
ICAgcmVncyA9IHBsYXRmb3JtX2dldF9yZXNvdXJjZV9ieW5hbWUocGRldiwgSU9SRVNPVVJDRV9N
RU0sDQo+ID4gbmFtZSk7DQo+ID4gKyAgICAgaWYgKCFyZWdzKQ0KPiA+ICsgICAgICAgICAgICAg
cmV0dXJuIC1FSU5WQUw7DQo+ID4gKw0KPiA+ICsgICAgIHBvcnQtPmJhc2UgPSBkZXZtX2lvcmVt
YXBfcmVzb3VyY2UoZGV2LCByZWdzKTsNCj4gPiAgICAgICBpZiAoSVNfRVJSKHBvcnQtPmJhc2Up
KSB7DQo+ID4gICAgICAgICAgICAgICBkZXZfZXJyKGRldiwgImZhaWxlZCB0byBtYXAgcG9ydCVk
IGJhc2VcbiIsIHNsb3QpOw0KPiA+ICAgICAgICAgICAgICAgcmV0dXJuIFBUUl9FUlIocG9ydC0+
YmFzZSk7DQo+ID4gICAgICAgfQ0KPiA+IA0KPiA+ICsgICAgIHBvcnQtPm1zZ19hZGRyID0gcmVn
cy0+c3RhcnQgKyBQQ0lFX01TSV9WRUNUT1I7DQo+ID4gKw0KPiA+ICAgICAgIHNucHJpbnRmKG5h
bWUsIHNpemVvZihuYW1lKSwgInN5c19jayVkIiwgc2xvdCk7DQo+ID4gICAgICAgcG9ydC0+c3lz
X2NrID0gZGV2bV9jbGtfZ2V0KGRldiwgbmFtZSk7DQo+ID4gICAgICAgaWYgKElTX0VSUihwb3J0
LT5zeXNfY2spKSB7DQo+ID4gLS0NCj4gPiAyLjQ2LjANCj4gPiANCj4gDQo+IC0tDQo+IOCuruCu
o+Cuv+CuteCuo+CvjeCuo+CuqeCvjSDgrprgrqTgrr7grprgrr/grrXgrq7gr40NCg==

