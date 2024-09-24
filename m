Return-Path: <linux-pci+bounces-13415-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD13983D67
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 08:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D1551F21C8B
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 06:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D35877111;
	Tue, 24 Sep 2024 06:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airoha.com header.i=@airoha.com header.b="mMyZnRFo";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="sviaNfBa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B480F6E614
	for <linux-pci@vger.kernel.org>; Tue, 24 Sep 2024 06:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727160837; cv=fail; b=A9lTXIbHdNYwnlrtI+SJg8+RzD/2OBIdP/KOcOkS5Mw4ecWjILJWyfPCtpQYVDwjkKXdWytpq/cGxB/BjT4Y5P1YOX+O3Jf32kOstwh+eCRZtzZScWIw1eUFeGXna73bnhptjQtwsc7tk6LDsHl7R5BOb+JFCG+pf9y1r7uRh1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727160837; c=relaxed/simple;
	bh=RJHBuK/8Kfn/Y4OCLg1FueZwuSdQV4aXRcNR+8ZNbQs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IefOu021hrnf6z77T67YNKb5USJFcyyRkIti1b1TDQnwAAzpE6XE3mccVUzb3YP+ndQZgjxtzK+F9e060gvnWI6bh2ZCBCJn05Emrf5cEZLUpaE7sGtJPJ0uIt0X8475eQ+wbGQ7B+OEGghockdY+VetyHx7iZnbL0LVZfXaESI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=airoha.com; spf=pass smtp.mailfrom=airoha.com; dkim=pass (1024-bit key) header.d=airoha.com header.i=@airoha.com header.b=mMyZnRFo; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=sviaNfBa; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=airoha.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airoha.com
X-UUID: bfa49aae7a4111ef8b96093e013ec31c-20240924
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=airoha.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=RJHBuK/8Kfn/Y4OCLg1FueZwuSdQV4aXRcNR+8ZNbQs=;
	b=mMyZnRFoxps1lBEU7e4iPOgvT6grw4ThqCzcTauNQAkHgpTINtoY2qJLIcdrWugyevY89L/ofAs9vrx00TOON20xhf1jWgXPBu41mFNaV0u/eLMI4cYRNQf4ZevBhxFykojaeOcQxoKHQBLPpk8JG+og8Q5WW+3XsakBVpD5KLU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:c73e975c-f360-4823-a1f5-01cd22b12760,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:f4a22818-b42d-49a6-94d2-a75fa0df01d2,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:817|102,TC:nil,Content:0|-5,EDM:-3,I
	P:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,A
	V:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: bfa49aae7a4111ef8b96093e013ec31c-20240924
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <hui.ma@airoha.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 39805041; Tue, 24 Sep 2024 14:53:47 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 23 Sep 2024 23:53:46 -0700
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 24 Sep 2024 14:53:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c42cplYdb1Bpph/waUnQomS6WMrP2e6D9MvRBOW8du+ypgeiFH0g/ZQkAjvLciu7ZazAiGox6Fc7zHbKaO7Or+/XD2i3cqmff3cou+4MChCFWoP7OILzSIBhZkMaLKUYPsUMAts8/UcXNQJ1CZpbPlkWsaQZoXBYLolr539gYkapp/JZzhNmTgMlH0bWMsrkMUdyLPD4yIqnLVoAc8X8Dy+imVHfU7QS0F9eUptEnsc/1e/6dOP/pLciRWQy28CIJ3Ks9h3Iov1KmRsCN4ByczG1FkS30mibY7T3nbRvadEnqX+L3IELeoQnB0mtoKX44FQilC9Chpx9Gx724ZnbFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJHBuK/8Kfn/Y4OCLg1FueZwuSdQV4aXRcNR+8ZNbQs=;
 b=Oj0QtTEAx0CvhdL89VHtZwR0upIdbvitMIom6VYSmjFVyOhHcixqKBcpYKPPU1wRNM8vLHuNI5D0b8jfJmUomeqIPAN38VbNB5jJHEA66fHx3dJA3jm3nTfRXmm6WSAVMQ1zvZm+WfMt5f95O+9gOrHgn0d/kKD5ym9qFBwL5HIO8FhLhgOOcLiP8qi10LonCiEC7QtX6fXuDt9TfbwgRIVuxg3sdKTyrgBbsGFVWJviRwp0hy8TmzSRRkHfNkBgfGcHBmmrH5C8Vbm+C3UFbRqYWNML6PbmDLp/b2J7ph7BFZu7wRRrb8pjP4lK8bU3lIpvLAScfbEwNjfStwq3TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=airoha.com; dmarc=pass action=none header.from=airoha.com;
 dkim=pass header.d=airoha.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJHBuK/8Kfn/Y4OCLg1FueZwuSdQV4aXRcNR+8ZNbQs=;
 b=sviaNfBaKxCrTLFiyvTJfSZJInxk6qgCJcfTWFC9vuIiiuh+PySvRiKoH6LbVZ0sowm3pQeJimEQdj+1aj0V55y+EkpoYSDv2SLtWl6i6XKtdO+brSC8HIOP43Bgqeow/0+FxSajB6Mq/pZnNyKuKyL2grV/SIC7QE89czWPHvg=
Received: from SG2PR03MB6341.apcprd03.prod.outlook.com (2603:1096:4:178::8) by
 JH0PR03MB7835.apcprd03.prod.outlook.com (2603:1096:990:2d::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.27; Tue, 24 Sep 2024 06:53:42 +0000
Received: from SG2PR03MB6341.apcprd03.prod.outlook.com
 ([fe80::619e:4ef8:147a:3554]) by SG2PR03MB6341.apcprd03.prod.outlook.com
 ([fe80::619e:4ef8:147a:3554%5]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 06:53:42 +0000
From: =?utf-8?B?SHVpIE1hICjpqazmhacp?= <Hui.Ma@airoha.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <Ryder.Lee@mediatek.com>,
	=?utf-8?B?Smlhbmp1biBXYW5nICjnjovlu7rlhpsp?= <Jianjun.Wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kw@linux.com>, Rob Herring
	<robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Matthias Brugger
	<matthias.bgg@gmail.com>
CC: Christian Marangi <ansuelsmth@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, upstream <upstream@airoha.com>
Subject: =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtQQVRDSF0gUENJOiBtZWRpYXRlay1nZW4zOiBB?=
 =?utf-8?Q?void_PCIe_resetting_for_Airoha_EN7581_SoC?=
Thread-Topic: =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIFBDSTogbWVkaWF0ZWstZ2VuMzogQXZvaWQgUENJ?=
 =?utf-8?Q?e_resetting_for_Airoha_EN7581_SoC?=
Thread-Index: AQHbCzbxAYsGTvHhZkiHFxmBi8znG7JlIyiAgAADJ5CAABqZAIABPkww
Date: Tue, 24 Sep 2024 06:53:42 +0000
Message-ID: <SG2PR03MB63415DB5791C58C7EA69FF01FF682@SG2PR03MB6341.apcprd03.prod.outlook.com>
References: <20240920-pcie-en7581-rst-fix-v1-1-1043fb63ffc9@kernel.org>
 <d8941149-9125-4fe2-a1c0-ab29223a0c87@collabora.com>
 <SG2PR03MB6341D9B41B5742BD45E09B46FF6F2@SG2PR03MB6341.apcprd03.prod.outlook.com>
 <05ec0016-09e8-4e84-92d1-698b3c195ec8@collabora.com>
In-Reply-To: <05ec0016-09e8-4e84-92d1-698b3c195ec8@collabora.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYXI3MDAzNTFcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy1iYTAzZTJmZS03YTQxLTExZWYtYTlkOS0xOGMwNGQ3NjVjYjBcYW1lLXRlc3RcYmEwM2UyZmYtN2E0MS0xMWVmLWE5ZDktMThjMDRkNzY1Y2IwYm9keS50eHQiIHN6PSIxNDMyMiIgdD0iMTMzNzE2MzQ0MTk1MjYwMTk0IiBoPSJQTlB4NkNoaTlMOG55OVZJam9pVkM1a0ZUUVU9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=airoha.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB6341:EE_|JH0PR03MB7835:EE_
x-ms-office365-filtering-correlation-id: 78aba101-3f3b-453c-0393-08dcdc65a090
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TG9pS0JsTEkvSXh3OUh6WXc1MG53d0psa09lN2pjeW1mT2tjby90bmdtUDBO?=
 =?utf-8?B?NnVSOTREYjVzWnM2R0wxZXNqSzJhMzhseVY3Ui80aDNPYUFQR1hGbDN1am1Q?=
 =?utf-8?B?TzBTUTJhWk4yZHV0VktwQ3hzRlVjOSt3UTVaaUozQjRCOTZJSWIwdnc5Rndz?=
 =?utf-8?B?empkSnBLMnYvTG0rbVJYR3JITm5CQUpzWnJONU54REZqNXQvc2djYkxUSENE?=
 =?utf-8?B?cHNuNEoyZStqVGkweXN1ckZiWG41dUszNjFZTjEwVUQyd2N6cktzQnhqVm1X?=
 =?utf-8?B?Y0xpdTZRTFZscXZ4elpSN01NKzFxN2JQMWUwV1RkOGZMeThRQUdtNUlLcHlB?=
 =?utf-8?B?OHg1OHVmQW5VUUVoeGtkWHNqN2EzNUY2bzlIekQwSllkbThVTFNPKy82Vnlk?=
 =?utf-8?B?bk9uRXhqNHREbEVpbmY0WklXVmVwMmMxWTVJLzJKcW4rZXI5NUcxVE9kSVE4?=
 =?utf-8?B?ckQ5QW1ldkdGOFJ3azQvOEdwb3ZOWXJBeVNQNWl0cFIyVXBSK09zcGZicnVB?=
 =?utf-8?B?Y25jZDZ4VXc2VWhmN2tZV3hiaDFUVmIzUlNRVVo0aWtjcUJoSFpTbkFFVUtn?=
 =?utf-8?B?ZjljbjYwUFZhWWNqbWhwTFNkekorOFROcnR0MU9STW5oNjN4ODhObHBGaE5n?=
 =?utf-8?B?czFIVnBSMXhxWEFiKy92bkRlS3lQQS84SzdNUzVWWGtRTXNpUGloMTFvd1R5?=
 =?utf-8?B?UnROcXl1aGpnZ3JscnJra1FXYkFYVTRqdmRLbjJ4K2srUUtPbHRpY2VPRnRU?=
 =?utf-8?B?QVI2aEF2M1pZbDdQeEFZc25VYllocDYwbGI3Nyt4WnJLaDRwVks4b0FTUmhn?=
 =?utf-8?B?dTJFVGtIWUJ5TGlkY3NkZ1NnRmgzZzBseWFmaHBsRG1xVVJDZDg0UkxwclZh?=
 =?utf-8?B?TlpqaXhJak9nYk41LzdZNDlEelhCNFVZeGNMbEkxTXZjQXJ2ZU1GZmRueE1K?=
 =?utf-8?B?bk9yN3lvdnduZzUyK0d2WTY2RDRhRU0yS2RYMlVhRkxZRkhvNWRjWHdKbUtq?=
 =?utf-8?B?bE5BcWVjeWp2RXh2b0ZiNFQvdkRDMURGQU1NTWxINTN1bm9LL3UzNEg1MGpY?=
 =?utf-8?B?SENmamgrbXFYQzZGa3c2QWlwdzdiazBwTEh6ME0wcnNhTCtSZWUyLzhmT3pU?=
 =?utf-8?B?aVgyMTErOTFLb2dBbzZFWVF2b0FGRUo3L2hSQ1hMdDFBaUhRZDI1S0RQU3JE?=
 =?utf-8?B?NEg4K2t4UXNaWFFMV1hXRFpqSzNRSXRic2cxZS94R1N6N3JleGZ4Vlhrb0ZL?=
 =?utf-8?B?cmJDR0p0bWtjVi82dTBJK24yOGNOK2sxSVA0TnhwcE5ocWNqR3RBV1BleERs?=
 =?utf-8?B?eEljblQ3dXo0enAvQVdENTdDN3h0YXpkUTBsNWdTK3JkT2pLS2FEeDY1SGJC?=
 =?utf-8?B?SHVyNUcvd3loQXRlNG5BQTFRNDR1Nk55ZWJqSWVqSWpTRjhRcjFucFBmc1o5?=
 =?utf-8?B?MUt5YkxQWEw5a0ZpWWltR0NwZzkxbkZMWUo5TUxNb2o5WHpTNExBM0p4akZu?=
 =?utf-8?B?QkZISzg0NHlVWmFzdGtSRkdvK2p2S0ZuOURTQ2tDWjJiUzhTT09sdDk3R1lD?=
 =?utf-8?B?Qi9WaUR4dFdYYmRWcHB3eU1hK080ZnBsaTNhK051QVN1SGxMQStEQk5mc05x?=
 =?utf-8?B?bXRFZ3hOdzNhQ2tZSzl2N3EyY3JtTlR0OEQ1VUlDWHFKZjRNVm9GY2ZvU2Jx?=
 =?utf-8?B?Z0tJRmZvWWJOY01GRFBUeXhiR0xrOHJra2VEZS8xY0g5NHJnZVY3NkorU0w4?=
 =?utf-8?B?citGTUtaVldmb29wT3J2Uk9nT1I4YlJmNGJ1T1ZSOHdRZFRZdXZvU1FGSExp?=
 =?utf-8?B?MjRubjJWVkdpeUN1RmdjUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6341.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RXE1cmlRbncrMWh6SVozOU1hR2NDVUZPZEZyaVdUNGtCRTdyYWU5YXNtQzdG?=
 =?utf-8?B?elZkVWEraldma0NxMUtmSkRMeVlMR0ZnSDB2SlJrKzVuMUdyS1FEc0xOK3o3?=
 =?utf-8?B?NG1rOE9Gc0N2ZHVFY1JEcDNFRVJobHFUNzJOdHQvZ3U3d0s3V0FFbmRXSlVO?=
 =?utf-8?B?SnJpZ1VtSWd6S0RoYWtkeXdaalZDYm92eUMwQitiUmMrT0E0T2pxaTB3YTZm?=
 =?utf-8?B?U09nRFU5alZBVHJYbHVHVHVFT0tRSVg2Z1dLY0dhdXhFaDVPek9pT1pGb2ln?=
 =?utf-8?B?MDEyRzZjN25aMmZSSEJtOXp5QXlpQ0RpUlRtSFFRcW9hRDB6RWNIN1BTYnY5?=
 =?utf-8?B?VStPWEt1OVBYdHZrc1QwY1dhMzlReGNML0FObXdZQXhYeE9EeDVlQW1DUFBH?=
 =?utf-8?B?SitmVy9SZ1Ewc01pSUVpMnRWdXgyOEhEeW1OZ29XYWNKWE4yeFU1YXgreERn?=
 =?utf-8?B?YWJ0YU1zSEFOYkdCSTZlQjdLY1ZHaFZaM2NEemdXL2VjRDlJdGR4bDNScEZj?=
 =?utf-8?B?WERIdllvZnpNcFlhNWJlTDBtS2FSQk96VkM0Vk9kckwxU3pYbGovaWZkRzB2?=
 =?utf-8?B?Z2FUMlJ1N1VVTkYxWTB2cmtITVVBb3A1RThWWFNzNzBOYXdYRk1vN0M0OTNJ?=
 =?utf-8?B?VU9RbzIraGNMdXE2N08wNDduaWFJcFFqb28xQ25GR2JkMFI2RkhHelN4Z0Uy?=
 =?utf-8?B?Mm9Jc3B4TDA4ejVBOGpQQ0dZSitxdGtrS2JKRGUrZzhTOWxLekdwemZOVWV5?=
 =?utf-8?B?WVNyOER2T3l6Vy9UalNiMVhwNmh1bFBlaW43TTlrc0ttYkU4T09ETTZpYVJn?=
 =?utf-8?B?dHErR2tYNmtHdmh3UUJ5MHlRREx6TE9LR3FTRHlFT1BkNnhYeG9NY3FIUHFp?=
 =?utf-8?B?MTV5YnRBR3R5QzB2VHdGMEJUWEp0UG04TDVINlRZRHFyYTRYQlVzNVV6a2Zt?=
 =?utf-8?B?VlRKQTFGMXdiZGVRWGpsdkcyYlFNSHI4ZGlRQmFnUnd5NEFMOExEN2dkQ0k4?=
 =?utf-8?B?dFI5b01ZMldLUHk1cENrT0gxTzJjMmplWWk3VUZkdXk4TzNraTNHdzVBV0RD?=
 =?utf-8?B?dFArMCtPYUR1dDNnR0kwNm5qUTNmdEVrL1VzVlBhK0NOVU1IczR6THNXcjhw?=
 =?utf-8?B?OFF5YXBpamNUb2dsR3VCeDYwbnE5UVdXWHN2NTJhZVF0RDBqK3liSmV1M2hZ?=
 =?utf-8?B?Q1hpRWYydXNzVHc1TWNiaXkyaVgvbXFHR2VueXVjc1VGVjEvc3dIVkNud2lX?=
 =?utf-8?B?UzFnMXdFenlBRFJjMDdmZXdxUTg5Wjc3UmREakk3czhTN2ZvVmhkLzVsWE02?=
 =?utf-8?B?WWlNVlVCMWtDUGhCRHQ0YXVzalIwMENYTlptYTJGYWFPLzd6NWtiNVRqQnVZ?=
 =?utf-8?B?WUtNL29HZUJDY0xsZXArL3FsMUhSQ0tyVi9pK1VkWXo2ODVMMEtlOHdYeTg2?=
 =?utf-8?B?b1BYVVgyM2lMT2ZEbFBuZmxJUXNwbzFQcnI2MXRmZHFIOHkrWnZjWWZ4bHYx?=
 =?utf-8?B?dHB2TGhUdGNEUFplZWJQdHI3bGtyOFRYY2oxM2hMbEl5dVc4ZWtwRnBTbkg5?=
 =?utf-8?B?ZEc5YzZTaElhekJRT2REcHRBaXU4aXNWNGFVNW8xU3IvSTEwTm1sRlBSRk11?=
 =?utf-8?B?Z2FXS280K3ZTQ3JoSzc2bVlrcGNJNmpjNWJxSy82SmhNME5iSWFBSkdOT241?=
 =?utf-8?B?cTVBMWVmYmZsSHFTWHhxM3ZQQnNCQUVjclRDc3N2YzVzUjJEVzJLNXFGa0VX?=
 =?utf-8?B?dFRxZmprSkpaYmRIUS95ckxYODBzdVNDRnZjaGhMSWZ3c1FoMG45ZTV2b2Y5?=
 =?utf-8?B?QkNPV2tHM3E2bXhUSmRseU5yVFVnVDJKVHlxZDYrbHZteWw4NFBvdzhwUkVY?=
 =?utf-8?B?d2ZDMU96anN1RGRrNnNBNWdNVVUwODM1WW1LcTJYd3VzQXgyUFkwcTlmS3p4?=
 =?utf-8?B?My96TjdCTGtnNVZlMmZ1OS9HMEs0YUxBVkVCSERhS2hwSjd4Vy9Uc0hEN28w?=
 =?utf-8?B?L1BscVA4cmdQeHJsWHgzSzc0b1A1UFZhZXJPSFNPWlhFVmFxODk5dFJLVVlC?=
 =?utf-8?B?TGhDdmhJRk91a3RPTjlTV0hHWGFZYllQREExNFl5eVBUNEFDS2ZOQzdRUUZT?=
 =?utf-8?Q?iAV4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6341.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78aba101-3f3b-453c-0393-08dcdc65a090
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2024 06:53:42.3286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GC4320/lY0XVw2q/D1Ex+wYocTUtDlVgiV2/YUP6lerCQNIShOT229xcaz2cHZUHM7gZ68XKRjH46XLnSEZyKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7835

DQo+IElsIDIzLzA5LzI0IDEyOjA2LCBIdWkgTWEgKOmprOaFpykgaGEgc2NyaXR0bzoNCj4gPiBI
aSBBbmdlbG/vvIwNCj4gPiANCj4gPiAgICAgICAgICAgRU43NTgxIGRvZXNuJ3Qgc3VwcG9ydCBw
dWxsaW5nIHVwL2Rvd24gUEVSU1QgYnkgYml0MyBvZiBQQ0llIE1BQyByZWdpc3RlciAweDE0OChQ
Q0lFX1JTVF9DVFJMX1JFRykuDQo+ID4gDQo+ID4gICAgICAgICAgIEVONzU4MSB0b2dnbGUgUEVS
U1QgaW4gY2xrX2J1bGtfZW5hYmxlIGZ1bmN0aW9uIGNhbGxlZCBieSBtdGtfcGNpZV9lbjc1ODFf
cG93ZXJfdXAgZnVuY3Rpb24uDQo+ID4gDQo+DQo+IEhlbGxvIEh1aSwNCj4gcGxlYXNlIGRvbid0
IHRvcCBwb3N0Lg0KDQo+IEFueXdheSwgYXJlIHRob3NlIGJpdHMgdW5leGlzdGFudCBvbiBFTjc1
ODEsIG9yIGFyZSB0aG9zZSB1c2VkIGZvciBkaWZmZXJlbnQgZnVuY3Rpb25zPw0KDQo+IElmIHRo
b3NlIGRvIG5vdCBleGlzdCwgYW5kIHNldHRpbmcgdGhvc2UgYml0cyB3aWxsIG5vdCBwcm9kdWNl
IGFkdmVyc2UgZWZmZWN0cywgaXQnZCBiZSBwb3NzaWJsZSB0byBhdm9pZCBjcmVhdGluZyBhIGRp
ZmZlcmVudCBjb2RlcGF0aCBhbmQganVzdCBhZGQgYSBjb21tZW50IHNheWluZyB0aGF0IHRoZSBz
ZXR0aW5nIGhhcyBubyBlZmZlY3Qgb24gQWlyb2hhIEVONzU4MS4NCg0KPiBSZWdhcmRzLA0KPiBB
bmdlbG8NCg0KPiA+IA0KDQoNCkhpIEFuZ2VsbywNCglTb3JyeSBmb3IgcmVwbHkgbGF0ZSByZXBs
eS4NCg0KCUJpdDMgb2YgdGhlIHJlZ2lzdGVyIGRvZXNuJ3Qgd29yayBvbiBFTjc1ODEgYmVjYXVz
ZSBvZiB0aGUgaGFyZHdhcmUgaXNzdWUuDQoJV2UgaGF2ZSBhbHJlYWR5IGNvbXBsZXRlZCBQQ0ll
IFJDL0VQIHJlc2V0IGFjdGlvbiBiZWZvcmUgc2V0dGluZyBQQ0llIE1BQyByZWdpc3RlciAweDE0
OC4NCglBdCB0aGlzIG1vbWVudO+8jHRoZSBkZXZpY2UgaXMgaW4gcmVsZWFzZSBzdGF0dXPvvIxp
ZiB3ZSB0b2dnbGUgUENJZSBNQUMgcmVnaXN0ZXIgMHgxNDjvvIxQQ0llIHdpbGwgbGluayBkb3du
IG9jY2FzaW9uYWxseS4NCg0KCUluIG9yZGVyIHRvIGF2b2lkIGNyZWF0aW5nIGEgZGlmZmVyZW50
IGNvZGVwYXRoLCB3ZSBhcmUgdHJ5aW5nIGFub3RoZXIgc29sdXRpb24uDQoNCg0KDQpSZWdhcmRz
LA0KSHVpDQoNCg0KDQoNCg0KDQoNCg0KDQoNCj4gPiANCj4gPiANCj4gPiANCj4gPiANCj4gPiAN
Cj4gLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0KPiDlj5Hku7bkuro6IEFuZ2Vsb0dpb2FjY2hpbm8g
RGVsIFJlZ25vIA0KPiA8YW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29tPg0K
PiDlj5HpgIHml7bpl7Q6IDIwMjTlubQ55pyIMjPml6UgMTc6NDINCj4g5pS25Lu25Lq6OiBMb3Jl
bnpvIEJpYW5jb25pIDxsb3JlbnpvQGtlcm5lbC5vcmc+OyBSeWRlciBMZWUgDQo+IDxSeWRlci5M
ZWVAbWVkaWF0ZWsuY29tPjsgSmlhbmp1biBXYW5nICjnjovlu7rlhpspIA0KPiA8Smlhbmp1bi5X
YW5nQG1lZGlhdGVrLmNvbT47IExvcmVuem8gUGllcmFsaXNpIA0KPiA8bHBpZXJhbGlzaUBrZXJu
ZWwub3JnPjsgS3J6eXN6dG9mIFdpbGN6ecWEc2tpIDxrd0BsaW51eC5jb20+OyBSb2IgDQo+IEhl
cnJpbmcgPHJvYmhAa2VybmVsLm9yZz47IEJqb3JuIEhlbGdhYXMgPGJoZWxnYWFzQGdvb2dsZS5j
b20+OyANCj4gTWF0dGhpYXMgQnJ1Z2dlciA8bWF0dGhpYXMuYmdnQGdtYWlsLmNvbT4NCj4g5oqE
6YCBOiBDaHJpc3RpYW4gTWFyYW5naSA8YW5zdWVsc210aEBnbWFpbC5jb20+OyANCj4gbGludXgt
cGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgtbWVkaWF0ZWtAbGlzdHMuaW5mcmFkZWFkLm9yZzsg
DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgdXBzdHJlYW0gPHVwc3Ry
ZWFtQGFpcm9oYS5jb20+OyANCj4gSHVpIE1hICjpqazmhacpIDxIdWkuTWFAYWlyb2hhLmNvbT4N
Cj4g5Li76aKYOiBSZTogW1BBVENIXSBQQ0k6IG1lZGlhdGVrLWdlbjM6IEF2b2lkIFBDSWUgcmVz
ZXR0aW5nIGZvciBBaXJvaGEgDQo+IEVONzU4MSBTb0MNCj4gDQo+IA0KPiANCj4gSWwgMjAvMDkv
MjQgMTA6MjYsIExvcmVuem8gQmlhbmNvbmkgaGEgc2NyaXR0bzoNCj4gDQo+PiBUaGUgUENJZSBj
b250cm9sbGVyIGF2YWlsYWJsZSBvbiB0aGUgRU43NTgxIFNvQyBkb2VzIG5vdCBzdXBwb3J0IA0K
Pj4gcmVzZXQNCj4gDQo+PiB2aWEgdGhlIGZvbGxvd2luZyBsaW5lczoNCj4gDQo+PiAtIFBDSUVf
TUFDX1JTVEINCj4gDQo+PiAtIFBDSUVfUEhZX1JTVEINCj4gDQo+PiAtIFBDSUVfQlJHX1JTVEIN
Cj4gDQo+PiAtIFBDSUVfUEVfUlNUQg0KPiANCj4+DQo+IA0KPj4gSW50cm9kdWNlIHRoZSByZXNl
dCBjYWxsYmFjayBpbiBvcmRlciB0byBhdm9pZCByZXNldHRpbmcgdGhlIFBDSWUgDQo+PiBwb3J0
DQo+IA0KPj4gZm9yIEFpcm9oYSBFTjc1ODEgU29DLg0KPiANCj4+DQo+IA0KPiANCj4gDQo+IEVO
NzU4MSBkb2Vzbid0IHN1cHBvcnQgcHVsbGluZyB1cC9kb3duIFBFUlNUIz8hDQo+IA0KPiBUaGF0
IGxvb2tzIGRlZmluaXRlbHkgb2RkLCBhcyB0aGF0IHNpZ25hbCBpcyBwYXJ0IG9mIHRoZSBQQ0kt
RXhwcmVzcyBDRU0gc3BlYy4NCj4gDQo+IA0KPiANCj4gQmVzaWRlcywgdGhlcmUncyBhbm90aGVy
IFBFUlNUIyBhc3NlcnRpb24gYXQgbXRrX3BjaWVfc3VzcGVuZF9ub2lycSgpLi4uDQo+IA0KPiAN
Cj4gDQo+IENoZWVycywNCj4gDQo+IEFuZ2Vsbw0KPiANCj4gDQo+IA0KPj4gVGVzdGVkLWJ5OiBI
dWkgTWEgPGh1aS5tYUBhaXJvaGEuY29tPG1haWx0bzpodWkubWFAYWlyb2hhLmNvbT4+DQo+IA0K
Pj4gU2lnbmVkLW9mZi1ieTogTG9yZW56byBCaWFuY29uaSANCj4+IDxsb3JlbnpvQGtlcm5lbC5v
cmc8bWFpbHRvOmxvcmVuem9Aa2VybmVsLm9yZz4+DQo+IA0KPj4gLS0tDQo+IA0KPj4gICAgZHJp
dmVycy9wY2kvY29udHJvbGxlci9wY2llLW1lZGlhdGVrLWdlbjMuYyB8IDQ0IA0KPj4gKysrKysr
KysrKysrKysrKysrLS0tLS0tLS0tLS0NCj4gDQo+PiAgICAxIGZpbGUgY2hhbmdlZCwgMjggaW5z
ZXJ0aW9ucygrKSwgMTYgZGVsZXRpb25zKC0pDQo+IA0KPj4NCj4gDQo+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1lZGlhdGVrLWdlbjMuYw0KPiANCj4+IGIvZHJp
dmVycy9wY2kvY29udHJvbGxlci9wY2llLW1lZGlhdGVrLWdlbjMuYw0KPiANCj4+IGluZGV4IDVj
MTlhYmFjNzRlOC4uOWNlYTY3ZTkyZDk4IDEwMDY0NA0KPiANCj4+IC0tLSBhL2RyaXZlcnMvcGNp
L2NvbnRyb2xsZXIvcGNpZS1tZWRpYXRlay1nZW4zLmMNCj4gDQo+PiArKysgYi9kcml2ZXJzL3Bj
aS9jb250cm9sbGVyL3BjaWUtbWVkaWF0ZWstZ2VuMy5jDQo+IA0KPj4gQEAgLTEyOCwxMCArMTI4
LDEyIEBAIHN0cnVjdCBtdGtfZ2VuM19wY2llOw0KPiANCj4+ICAgIC8qKg0KPiANCj4+ICAgICAq
IHN0cnVjdCBtdGtfZ2VuM19wY2llX3BkYXRhIC0gZGlmZmVyZW50aWF0ZSBiZXR3ZWVuIGhvc3Qg
DQo+PiBnZW5lcmF0aW9ucw0KPiANCj4+ICAgICAqIEBwb3dlcl91cDogcGNpZSBwb3dlcl91cCBj
YWxsYmFjaw0KPiANCj4+ICsgKiBAcmVzZXQ6IHBjaWUgcmVzZXQgY2FsbGJhY2sNCj4gDQo+PiAg
ICAgKiBAcGh5X3Jlc2V0czogcGh5IHJlc2V0IGxpbmVzIFNvQyBkYXRhLg0KPiANCj4+ICAgICAq
Lw0KPiANCj4+ICAgIHN0cnVjdCBtdGtfZ2VuM19wY2llX3BkYXRhIHsNCj4gDQo+PiAgICAgICAg
ICAgICBpbnQgKCpwb3dlcl91cCkoc3RydWN0IG10a19nZW4zX3BjaWUgKnBjaWUpOw0KPiANCj4+
ICsgICAgdm9pZCAoKnJlc2V0KShzdHJ1Y3QgbXRrX2dlbjNfcGNpZSAqcGNpZSk7DQo+IA0KPj4g
ICAgICAgICAgICAgc3RydWN0IHsNCj4gDQo+PiAgICAgICAgICAgICAgICAgICAgICAgY29uc3Qg
Y2hhciAqaWRbTUFYX05VTV9QSFlfUkVTRVRTXTsNCj4gDQo+PiAgICAgICAgICAgICAgICAgICAg
ICAgaW50IG51bV9yZXNldHM7DQo+IA0KPj4gQEAgLTM3Myw2ICszNzUsMjggQEAgc3RhdGljIHZv
aWQgbXRrX3BjaWVfZW5hYmxlX21zaShzdHJ1Y3QgDQo+PiBtdGtfZ2VuM19wY2llICpwY2llKQ0K
PiANCj4+ICAgICAgICAgICAgIHdyaXRlbF9yZWxheGVkKHZhbCwgcGNpZS0+YmFzZSArIFBDSUVf
SU5UX0VOQUJMRV9SRUcpOw0KPiANCj4+ICAgIH0NCj4gDQo+Pg0KPiANCj4+ICtzdGF0aWMgdm9p
ZCBtdGtfcGNpZV9yZXNldChzdHJ1Y3QgbXRrX2dlbjNfcGNpZSAqcGNpZSkgew0KPiANCj4+ICsg
ICAgdTMyIHZhbDsNCj4gDQo+PiArDQo+IA0KPj4gKyAgICAvKiBBc3NlcnQgYWxsIHJlc2V0IHNp
Z25hbHMgKi8NCj4gDQo+PiArICAgIHZhbCA9IHJlYWRsX3JlbGF4ZWQocGNpZS0+YmFzZSArIFBD
SUVfUlNUX0NUUkxfUkVHKTsNCj4gDQo+PiArICAgIHZhbCB8PSBQQ0lFX01BQ19SU1RCIHwgUENJ
RV9QSFlfUlNUQiB8IFBDSUVfQlJHX1JTVEIgfCANCj4+ICsgUENJRV9QRV9SU1RCOw0KPiANCj4+
ICsgICAgd3JpdGVsX3JlbGF4ZWQodmFsLCBwY2llLT5iYXNlICsgUENJRV9SU1RfQ1RSTF9SRUcp
Ow0KPiANCj4+ICsNCj4gDQo+PiArICAgIC8qDQo+IA0KPj4gKyAgICAqIERlc2NyaWJlZCBpbiBQ
Q0llIENFTSBzcGVjaWZpY2F0aW9uIHNlY3Rpb25zIDIuMiAoUEVSU1QjIA0KPj4gKyBTaWduYWwp
DQo+IA0KPj4gKyAgICAqIGFuZCAyLjIuMSAoSW5pdGlhbCBQb3dlci1VcCAoRzMgdG8gUzApKS4N
Cj4gDQo+PiArICAgICogVGhlIGRlYXNzZXJ0aW9uIG9mIFBFUlNUIyBzaG91bGQgYmUgZGVsYXll
ZCAxMDBtcyAoVFBWUEVSTCkNCj4gDQo+PiArICAgICogZm9yIHRoZSBwb3dlciBhbmQgY2xvY2sg
dG8gYmVjb21lIHN0YWJsZS4NCj4gDQo+PiArICAgICovDQo+IA0KPj4gKyAgICBtc2xlZXAoMTAw
KTsNCj4gDQo+PiArDQo+IA0KPj4gKyAgICAvKiBEZS1hc3NlcnQgcmVzZXQgc2lnbmFscyAqLw0K
PiANCj4+ICsgICAgdmFsICY9IH4oUENJRV9NQUNfUlNUQiB8IFBDSUVfUEhZX1JTVEIgfCBQQ0lF
X0JSR19SU1RCIHwgDQo+PiArIFBDSUVfUEVfUlNUQik7DQo+IA0KPj4gKyAgICB3cml0ZWxfcmVs
YXhlZCh2YWwsIHBjaWUtPmJhc2UgKyBQQ0lFX1JTVF9DVFJMX1JFRyk7IH0NCj4gDQo+PiArDQo+
IA0KPj4gICAgc3RhdGljIGludCBtdGtfcGNpZV9zdGFydHVwX3BvcnQoc3RydWN0IG10a19nZW4z
X3BjaWUgKnBjaWUpDQo+IA0KPj4gICAgew0KPiANCj4+ICAgICAgICAgICAgIHN0cnVjdCByZXNv
dXJjZV9lbnRyeSAqZW50cnk7DQo+IA0KPj4gQEAgLTQwMiwyMiArNDI2LDkgQEAgc3RhdGljIGlu
dCBtdGtfcGNpZV9zdGFydHVwX3BvcnQoc3RydWN0IA0KPj4gbXRrX2dlbjNfcGNpZSAqcGNpZSkN
Cj4gDQo+PiAgICAgICAgICAgICB2YWwgfD0gUENJRV9ESVNBQkxFX0RWRlNSQ19WTFRfUkVROw0K
PiANCj4+ICAgICAgICAgICAgIHdyaXRlbF9yZWxheGVkKHZhbCwgcGNpZS0+YmFzZSArIFBDSUVf
TUlTQ19DVFJMX1JFRyk7DQo+IA0KPj4NCj4gDQo+PiAtICAgICAvKiBBc3NlcnQgYWxsIHJlc2V0
IHNpZ25hbHMgKi8NCj4gDQo+PiAtICAgICB2YWwgPSByZWFkbF9yZWxheGVkKHBjaWUtPmJhc2Ug
KyBQQ0lFX1JTVF9DVFJMX1JFRyk7DQo+IA0KPj4gLSAgICAgdmFsIHw9IFBDSUVfTUFDX1JTVEIg
fCBQQ0lFX1BIWV9SU1RCIHwgUENJRV9CUkdfUlNUQiB8IFBDSUVfUEVfUlNUQjsNCj4gDQo+PiAt
ICAgICB3cml0ZWxfcmVsYXhlZCh2YWwsIHBjaWUtPmJhc2UgKyBQQ0lFX1JTVF9DVFJMX1JFRyk7
DQo+IA0KPj4gLQ0KPiANCj4+IC0gICAgIC8qDQo+IA0KPj4gLSAgICAgKiBEZXNjcmliZWQgaW4g
UENJZSBDRU0gc3BlY2lmaWNhdGlvbiBzZWN0aW9ucyAyLjIgKFBFUlNUIyBTaWduYWwpDQo+IA0K
Pj4gLSAgICAgKiBhbmQgMi4yLjEgKEluaXRpYWwgUG93ZXItVXAgKEczIHRvIFMwKSkuDQo+IA0K
Pj4gLSAgICAgKiBUaGUgZGVhc3NlcnRpb24gb2YgUEVSU1QjIHNob3VsZCBiZSBkZWxheWVkIDEw
MG1zIChUUFZQRVJMKQ0KPiANCj4+IC0gICAgICogZm9yIHRoZSBwb3dlciBhbmQgY2xvY2sgdG8g
YmVjb21lIHN0YWJsZS4NCj4gDQo+PiAtICAgICAqLw0KPiANCj4+IC0gICAgIG1zbGVlcCgxMDAp
Ow0KPiANCj4+IC0NCj4gDQo+PiAtICAgICAvKiBEZS1hc3NlcnQgcmVzZXQgc2lnbmFscyAqLw0K
PiANCj4+IC0gICAgIHZhbCAmPSB+KFBDSUVfTUFDX1JTVEIgfCBQQ0lFX1BIWV9SU1RCIHwgUENJ
RV9CUkdfUlNUQiB8IFBDSUVfUEVfUlNUQik7DQo+IA0KPj4gLSAgICAgd3JpdGVsX3JlbGF4ZWQo
dmFsLCBwY2llLT5iYXNlICsgUENJRV9SU1RfQ1RSTF9SRUcpOw0KPiANCj4+ICsgICAgLyogUmVz
ZXQgdGhlIFBDSWUgcG9ydCBpZiByZXF1ZXN0ZWQgYnkgdGhlIGh3ICovDQo+IA0KPj4gKyAgICBp
ZiAocGNpZS0+c29jLT5yZXNldCkNCj4gDQo+PiArICAgICAgICAgICAgIHBjaWUtPnNvYy0+cmVz
ZXQocGNpZSk7DQo+IA0KPj4NCj4gDQo+PiAgICAgICAgICAgICAvKiBDaGVjayBpZiB0aGUgbGlu
ayBpcyB1cCBvciBub3QgKi8NCj4gDQo+PiAgICAgICAgICAgICBlcnIgPSByZWFkbF9wb2xsX3Rp
bWVvdXQocGNpZS0+YmFzZSArIA0KPj4gUENJRV9MSU5LX1NUQVRVU19SRUcsIHZhbCwgQEANCj4g
DQo+PiAtMTIwNyw2ICsxMjE4LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBkZXZfcG1fb3BzIG10
a19wY2llX3BtX29wcyA9IHsNCj4gDQo+Pg0KPiANCj4+ICAgIHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
bXRrX2dlbjNfcGNpZV9wZGF0YSBtdGtfcGNpZV9zb2NfbXQ4MTkyID0gew0KPiANCj4+ICAgICAg
ICAgICAgIC5wb3dlcl91cCA9IG10a19wY2llX3Bvd2VyX3VwLA0KPiANCj4+ICsgICAgLnJlc2V0
ID0gbXRrX3BjaWVfcmVzZXQsDQo+IA0KPj4gICAgICAgICAgICAgLnBoeV9yZXNldHMgPSB7DQo+
IA0KPj4gICAgICAgICAgICAgICAgICAgICAgIC5pZFswXSA9ICJwaHkiLA0KPiANCj4+ICAgICAg
ICAgICAgICAgICAgICAgICAubnVtX3Jlc2V0cyA9IDEsDQo+IA0KPj4NCj4gDQo+PiAtLS0NCj4g
DQo+PiBiYXNlLWNvbW1pdDogZjIwMjQ5MDNjYjM4Nzk3MWFiZGJjNjM5OGE0MzBlNzM1YTliMzk0
Yw0KPiANCj4+IGNoYW5nZS1pZDogMjAyNDA5MjAtcGNpZS1lbjc1ODEtcnN0LWZpeC04MTYxNjU4
YzEzYzQNCj4gDQo+Pg0KPiANCj4+IEJlc3QgcmVnYXJkcywNCj4gDQo+IA0KDQo=

