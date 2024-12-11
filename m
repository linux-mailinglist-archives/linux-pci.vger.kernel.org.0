Return-Path: <linux-pci+bounces-18181-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 229739ED7F9
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 22:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 301411883157
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 21:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFA1229679;
	Wed, 11 Dec 2024 20:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XkuOxkTm"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2049.outbound.protection.outlook.com [40.107.105.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0962368F2;
	Wed, 11 Dec 2024 20:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733950680; cv=fail; b=Y7i9Pm5rppXNsaQcfYcs4LjE1jKQg7wpSR0LYQ8EhzId0ZYqM0sPn8vs6WX0z6UvLDsQifx0F5Id6OV1NBNSsbX2xuwBenbUHa2rPfFEuDY5ttLnA/ffXjlARSK4JKnuCkH3ZHJLF5Z5/kS1h6BSKwnBis8PNH9bP6o79pyzOHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733950680; c=relaxed/simple;
	bh=h9rTyIw7JBTy1EJzxkuF1XAJdSITdDV9rguxRpQSuCE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=iwEDw3tYulLtpRTJ/HYeoKyjtTGkjP27x+YpLdJ+8sKlAe2LqxJobhBe9f73amYSmcZ6sOHtkJrbWuTTnCAN5FcUpwcNa6nEqvqiUGxjJAEMFG/OUmJlzMruUUVs1GZaOydRP0tF8RBKaF1FuwUwvnMUizXN+P4QikyeNoLyy0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XkuOxkTm; arc=fail smtp.client-ip=40.107.105.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JutavMd2AbjR7Al0Z6/mYaqOwXP/wG87mNQOd6mWs1mCOELekf0Adl/bQzcUPrfMDs56Uql7YqTYpFWOQ62rN0Th7a0YdiAyMKzCxPWSE75avHsmT+BmBUaeKo6WxtwdH+eYXBv51wto98G6Ic9WxX+CEjvKDTH9yWs/4bCrs7gptwQNy/RfrXdAQoKhgW2m6qUn/32fJcdxUEhbwO8bIiSrBjI3gDoBYGzxNTjLb0AAvQnrFdmBDcjZ1mY2KWuuQ73eK75xEGQ9cXRBVhYlRIjY8L0VLRttXRQHaF6/tX02qLmGRM0bDSCMEfHVjnDGHAWUhRjKF0nUo63N2+Yq/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zg17DPPYOTuadjG+VkqD69CJqHyQvuSbj4mlECIwRQQ=;
 b=h397yoB125+bEMC0nmOP2p43mXrs/cmMRyf2wadW3rUo+U3P2QMSC0V0HNX59UMdlerbZYURgu/BZcwq041azthZT4aZStc4whIyUVaZfukjdqKqV0tjperKSeRN1x8fa8Q/rMwEuzbhYHBFV2UdxJdIpPIzROS1/DhI7ira37ivTe7EtA6GKAdyaNJ03Cg/lhYvp8Y1WBs0NYHmZ0QvnZwxVgv7LqINj3FxQ5e1jd4TsypcOwE8lq6+pCBjQv0NSbybcHi6W87OBV3o43PVOTptUQTR/wmLnjp4JGN4iTzPKIeA6BJ2pP3dp6PfPYiNlUj92UBEznC6HyoKPIa0fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zg17DPPYOTuadjG+VkqD69CJqHyQvuSbj4mlECIwRQQ=;
 b=XkuOxkTmzRSjcu1arez24AsI9ewQVEPvV5RLGP3boUpHuMDJ0xfqF7a3ohMnsk1taBt9JBWP5Q9wTHImvraOdoIuRs0mW6AO/uW/hi8XoqugBIdMNjGDjaOkrzNf7PPMsEpT4DqIFoIbCTOQiF3qOVm33kCrxr5HMV8u04ytF3lu2Qht8+daLjB8p+sFHhjZgQM0y1pywLuwNJf8GFBsNBqrxFfZ86F7sJ8nmkWJfWxmdB+xcejTYujSmYNmTr9Gzw3s0D3fUrEgFJfSpltNn/yY0nhtFcd6zb4NuylvM0AGnIJxfuoqjCwnNwZo+KQXz2R6f1IpY2eGA7el1+smPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM0PR04MB7139.eurprd04.prod.outlook.com (2603:10a6:208:19d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Wed, 11 Dec
 2024 20:57:54 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8230.010; Wed, 11 Dec 2024
 20:57:52 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 11 Dec 2024 15:57:29 -0500
Subject: [PATCH v12 1/9] irqchip/gic-v3-its: Avoid overwriting msi_prepare
 callback if provided by msi_domain_info
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241211-ep-msi-v12-1-33d4532fa520@nxp.com>
References: <20241211-ep-msi-v12-0-33d4532fa520@nxp.com>
In-Reply-To: <20241211-ep-msi-v12-0-33d4532fa520@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Anup Patel <apatel@ventanamicro.com>, 
 Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org, 
 jdmason@kudzu.us, linux-arm-kernel@lists.infradead.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733950663; l=2559;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=h9rTyIw7JBTy1EJzxkuF1XAJdSITdDV9rguxRpQSuCE=;
 b=2aRlvWumyidpf84WG24Qliz1Q9qLqiUdSsjcTrwNvTPPY3x2ktuzFuXMSb/6iwZFHnNVfmnUt
 yv9QILwBLtcCSGExXA40qui42uvNU/gexQNhy4K0gsrsaeSO/LvPRhG
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR01CA0037.prod.exchangelabs.com (2603:10b6:a03:94::14)
 To PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM0PR04MB7139:EE_
X-MS-Office365-Filtering-Correlation-Id: a224c0da-b0f9-4ac6-2aaa-08dd1a267a66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|7416014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V3FaSEMwdkpWOW1KS1ZLTGozSlVWTFE1blliZGQ2ZSt0RnJZSHpodlJyNVhE?=
 =?utf-8?B?OVRmeDI2MDZiRzVEUDJsWTZnZHhaRkpZeENLbDRpNktyWlI0U0QreHhLZ3lT?=
 =?utf-8?B?R0hwbkdpQytvR3B0WTRHVGMyWTNEcHFmM3BuZFY4T1NzRnE2Q2N4TTJiTkVM?=
 =?utf-8?B?SmNQdktxWFNkQytURnk2b0FEbVpVSDAvUzI3dVF0NzIwZUw2S3p3SXRZUjBK?=
 =?utf-8?B?UUo0clB0T1NsUE9JMFdiUDE4MkhSSHQvdVMrRXNRd3I4a1RMQkFZcmtNdjFn?=
 =?utf-8?B?QXJpNmdKUFF5NHFScytOeEVDUFR3alBzQXdxOURsaGtNS2ZPdHQyTFlYdXls?=
 =?utf-8?B?ZFNMUU92cDN0OWJlUitTaWtzdUw0NFU4aVZldEgvaFNvUXpkNmJGSUQ5MEU0?=
 =?utf-8?B?TjR2NFo4amFuMFVPOHdtR0JPZnk0amIxT2JOeENOMWttT0JGY2FrTHExOStL?=
 =?utf-8?B?cU5RMy9QalJwcG5XanY3MXRob0dNdlRUVnVqRXhUVXNlSk9reE9Tbk90Z0F2?=
 =?utf-8?B?ZHJ3dzdkOVdzcVpyNjVlVEdlVlRFSDExREwxLytlU21oNzVyOEwxSGtBUDFW?=
 =?utf-8?B?TVpCd1o4ODZ4c0lBaENXRnBLNjNCWERuZmRKNDZpN3N3QzF3UVozQWtnSFFG?=
 =?utf-8?B?bS9MSjgyNWFBcldNbzRnZHdlL0YybUhwYWhJeit1d3lxYkp6T0h6SGFJMGFk?=
 =?utf-8?B?cFR4QkVHU21UVmtNOEFLanR0MWNVaUovSUFSVFIreHFFSnBVRE41ZDNBdzd0?=
 =?utf-8?B?SzJRcy9NbzJGclhZQlBQY0lCajJzbEYwVWhXdUdqcTRxMmFiSnlXb3h5NUc4?=
 =?utf-8?B?RktCOXl3bkVyWTdZM3FFVHJDeERMR3poZmc4YXN0T3FxZjQ4aVVrZUthdTF0?=
 =?utf-8?B?UWlodUljLzF3RnV3NlU4d1BmTjRQWnRCZ0FxV2xsRU9mU3BlWVdaM0Q1dCty?=
 =?utf-8?B?QnoxMDluY1ZOdkxOdTFKZmREVitTZHVPQVF6MU9jdG5PRjRhY1RpNFRRVisw?=
 =?utf-8?B?emRWRUhEN1Jyd3NhNEowMUdFN2p6S0NmSFhXamM2VEF1dHZUSnFsUmNHS1Rs?=
 =?utf-8?B?Vk5USlRSbW9jalhkTzNOYmljMlBLNjJPcTVHZ1NVWFpDY2VhT2swbWZJWWFq?=
 =?utf-8?B?b2NZaENoWDE0YXhneUVYTnVoWnQ1aE5KcERkaXN6MlRnMTAyamtLQURJemxo?=
 =?utf-8?B?NU1LcTVJVHR0WS9DeHRkZDYybHovMHk3bldQSjdmMzdmQktHY1JENXZMVWMy?=
 =?utf-8?B?WFNWNEtvbWs2SWV4aEhyN3hnV2R2d3pSbzZnUlR4WmVGUE5hZ3RQZ04vbStM?=
 =?utf-8?B?NDhnN0pkTmtUTGtPckYvdERja29KK3RCR2pqdGExLzZVejBUWWpGb1M5OEpi?=
 =?utf-8?B?YUM4Rnh1QUhTZmsrS0tKVk4ycFhsaXRhR1NqTFE5Y0orbmNQSUxnNnhpb2Qy?=
 =?utf-8?B?STNacVl2UjU0eUZrUzF1RkF6Yjh6SXFKYmpiR2w3SFRYUFczT1ZjNTF5SG9r?=
 =?utf-8?B?SmdzRnBINGVkaDF3RFJ2MWdXOWV4Z29qRGRUV1VqdlJYenMzTW1LMnppWExn?=
 =?utf-8?B?K1Y4NTF5Y2kyMU0vYTlBQnR5MmRFSFM4NENrenRkeFk0QWJaODUxSjNQSlk2?=
 =?utf-8?B?NXd3YmF6MmlFVDZoRlptU0dnY0Y3cHpJSmRtNXgxY1J5RzZxOGEyVXAxMXI3?=
 =?utf-8?B?ZWN2TWg5TG1PMWs0SUlmbjA4S2Fic2VmSWZ5Sm15aXpnMGlJakNmMlBrUGN4?=
 =?utf-8?B?TlFZUXk5NGpiSjRwRDFVZmRNRW5WY25LRW5KTEtuU3ZmZGcydTYzeE1VWXVX?=
 =?utf-8?B?dmx2L2VTL2FHRHRQZGJzSCtlQzJITmdldVNNNFNSRlVRM0h6TW5XZWJTWDl4?=
 =?utf-8?B?N3B1OXViSzhtbWM5L3NVZEhtOFpGOTFvbHdXOUhqaHArcVdRd2FoekIrMXYy?=
 =?utf-8?Q?PPXRtb5hPzU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(7416014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aVhHTDM1SmRTYUdVZVRmQkdLNjd2TkQxSEc0YmZHVk5LSXJUdzgzM2E4c2Yx?=
 =?utf-8?B?ZFphQjBVYkRCSVZYZEsxRkV1NWpsSGNEdCs5MkxzWTBVWU9CMThJMkhzb3A1?=
 =?utf-8?B?Lzl1enUyTDVRY1VxMUkzZHdJdGlGVWc2TnRjblJFeFd3MjhScWx1WGdMVk5L?=
 =?utf-8?B?eHdZNU5weE9OWFg0b1lOazZmaGF1TndpYmVlUVNzU2YxdFBvYWdMajJDdE8x?=
 =?utf-8?B?bGowSmlKVlE2V0JTZWd3NnphUTNsZ3p6M1QwY0hTRnprRkNDYWZhVnVsZWhv?=
 =?utf-8?B?R0V6ODY5TlNMTEdNNStFaVFteEkzc1pIQkw2OHNIZUFkRHVtS0hYN1BsbHNR?=
 =?utf-8?B?YmZzMjZJYkdvaVkrbVpyaXBvZGRNNklSbVVlMDIvTWRnOEFCOWdsSldRMGZB?=
 =?utf-8?B?SEZkU2lBOTRMT0F5VWx4NEpab1BybW1BZmxXWGVVKytFVk5ZbHBSL2VuR0p3?=
 =?utf-8?B?aEZ6OEg5MmtBaUg2dUdwVGF1S3RyYmpmZHJBMWFvbVNDU1NZV1ZrelJQeVBZ?=
 =?utf-8?B?Z3dybWNTUG1YTVN5KzFkUG4xU09TSFpibnp4SHVkb2JaeStUbkNlUGswWlRS?=
 =?utf-8?B?ZTYwdDFBTmhiTjMvL2U0WEt2U0s2L1ZnMzdaMGFtQVF0dTNDeUlkTFI4V2FU?=
 =?utf-8?B?VVJTTlB6bU13QXZRVjNxdGhPTlNPK2daZ2JLMzNzL1RYT1FJOElmb2FVS1gy?=
 =?utf-8?B?UStYQ2laSWRvYmdtckVjK1BQY0xjZHc4aGNLK1huLzBTUmsxRWtIeHltYzEw?=
 =?utf-8?B?NzVKZ0tCaVpGMDF6VVloNzBOOW14ZE1tcFFmUDIvL3dlUUp4RVpObUlSYm9q?=
 =?utf-8?B?NjZOSTZyS2NLRm9VK0lUaTVGaXBQMDRsYzBGb3lzMmVVcFZuQVhHYWpyZFRp?=
 =?utf-8?B?NnlYMnEwcU80d0huMUpLbUJ1YUxnN21pNjhUbGhWWUtGdWV3aEVhbWx5Ukgr?=
 =?utf-8?B?c1U5NGlXaG5lYVNaUFFDcjZ3LzIxcy8xOHowL1NoVWdyTndtUm83aElvdmFL?=
 =?utf-8?B?RDFHYVZQM1hoc2NuQ21JQ3M1K3ZmZTNMN1ltd24zUmNzU2lZdXdvZlcrcS95?=
 =?utf-8?B?RnFyS0tWVkE5VEZzOEZyWjEwaWdlWGV5RzlSRStTVFU4Mm5PeEVPZWxNZDRj?=
 =?utf-8?B?eU5BQVlDcWg5UlN4ZmVSUVo5L0NzcVpySEN2ekIzRGdxYlREVkZQdGEwaDMv?=
 =?utf-8?B?cXpoejlzSjlvRHp3ZGNYYkZtZzRsYVhBQW11dzR0MDI1LytYOThhYStDcXpZ?=
 =?utf-8?B?VEFLR2tTczJtUFM3WFZkbW5oR0pJNk9MRGVzYkVRMEVFK2llblZVcUJrZmRL?=
 =?utf-8?B?cFNia0NkdEdDYVVTR0E0aTYrMmFaVDdQTFFuNW1tTjVBekpWYUNjU29NMVlt?=
 =?utf-8?B?QXI4a0lVYVlPalNhM3krNGJ3anFLL3h6eURQVDY0Ymt6M1NxaCtWRndyTHBM?=
 =?utf-8?B?TUxyS2h2N0pJYVZBcWYvaWZpZ1JkMXpLYSs3NDNNRjVhaG0wTkhWSXM2QVlK?=
 =?utf-8?B?MGdnVDFTRmtjQVRNUkpPT2FZV1Y2S1MvYVYyYW9TKytCcVVpUFJlTU0vS1Q4?=
 =?utf-8?B?ajBWaU9rRmMrWmwvMUI2eC9XN0QzMFRxWnlObHFjVzBFV2hMR2hEZmgwcVo3?=
 =?utf-8?B?SjlZV1J2M3BhRnBCdktsWHVLY3Q3NUNqWExFdFJqNk56azFhZm50WDAwbUFy?=
 =?utf-8?B?N1BuVzRCVWtFOVV1ZGwzTmhaNmgralB0eGgwY2pHVWxIcFBtdFh4Y09ZbENs?=
 =?utf-8?B?QW5LUGJpMUJqLzZKc2sxaHlEcTVBNlZvYlJ0SmltdHdNZnZEWkFoanVwaThn?=
 =?utf-8?B?Umpjc1IyaXBHT25GVTJxNVZnTEp3MmRwY1FkQ1hDajBjS0V5aWptTnZjMndH?=
 =?utf-8?B?Z0Yyd3lVZTk1NnBuWlpKcFhrMGNSRForT1EzR0lJWjk5cklzNStBUm9JTjlL?=
 =?utf-8?B?dmdlTU9lOFFQOXB4aUFuMHpJN0NtbmxxM2F0Z256Q2NHelgyWEFLRUF5MEVh?=
 =?utf-8?B?cjVnSFZLaWdsdHVZdlNzS1RCeWc0VHU3TzRxbExNVGRrbkJPbFp5VDFJZS9m?=
 =?utf-8?B?WDh6VzRSS0w3QjBJcEFlUGp2Z1FtUWFjR3p3Mk5LdFd0NW1BdzdXUDhTWFcz?=
 =?utf-8?Q?8EEAFvu3nskxRLpgeJ8Ab2ARQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a224c0da-b0f9-4ac6-2aaa-08dd1a267a66
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 20:57:52.2212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u9k7tLyGnIuJkTWZacOAhkqmg/m7GLDV35alYdLgRrOSZ2NO36vd0Gt54vH+RTAXGIOnPX8fABa/KRltnejoLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7139

  ┌───────────────────────────────┐    ┌───────┐
  │                               │    │       │
  │ PCI Endpoint Controller (1)   ├───►│ ITS   │
  │                               │    │       │
  └───────────────────────────────┘    └───────┘
      ▲        ▲
      │        │
  ┌───┴──┐  ┌──┴───┐
  │      │  │      │
  │Func1 │  │Func2 │
  │ (2)  │  │      │
  └──────┘  └──────┘
     ▲         ▲
     │         │
     └─────────┴─────────────── PCIe Bus

(1) is platform device, which is generally descripted by Device Tree(DT).
(2) Func1 and Func2 is created by configfs

The current platform MSI API supports only a single device. For instance,
a platform device (e.g., PCI Endpoint Controller) calls
platform_device_msi_init_and_alloc_irqs() to allocate MSI IRQs.

Child devices (e.g., function devices created by configfs) require
individual MSI domains, with the same MSI parent domain as the parent
device. These individual domains need specialized msi_prepare callbacks to
set  msi_alloc_info_t. However, the current ITS implementation overwrites
the msi_prepare callback with its_pmsi_prepare().

Modify the implementation to assign its_pmsi_prepare() only if
msi_domain_info::msi_prepare is NULL, allowing customized callbacks where
needed.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v11 to v12
- none

Change from v9 to v11
- new patch
---
 drivers/irqchip/irq-gic-v3-its-msi-parent.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its-msi-parent.c b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
index 75aa0d4bd1346..33e94cfc4d506 100644
--- a/drivers/irqchip/irq-gic-v3-its-msi-parent.c
+++ b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
@@ -195,7 +195,8 @@ static bool its_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
 		 * FIXME: See the above PCI prepare comment. The domain
 		 * size is also known at domain creation time.
 		 */
-		info->ops->msi_prepare = its_pmsi_prepare;
+		if (!info->ops->msi_prepare)
+			info->ops->msi_prepare = its_pmsi_prepare;
 		break;
 	default:
 		/* Confused. How did the lib return true? */

-- 
2.34.1


