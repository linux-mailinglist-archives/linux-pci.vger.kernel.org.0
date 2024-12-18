Return-Path: <linux-pci+bounces-18736-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F589F708D
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 00:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17C9416BDBE
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 23:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3881FECDC;
	Wed, 18 Dec 2024 23:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FkoWw0px"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2083.outbound.protection.outlook.com [40.107.20.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E431FECCF;
	Wed, 18 Dec 2024 23:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734563383; cv=fail; b=kuM9S+mIK9Fjo5tTaO2Py1wOuzCzUB9PrIK0i0e8M7oNGItkJ50E+S1KajgXNfMXAcevn/unUr5nc+QHmOhE3gFJMMpuO+Tg0Gi4NKs45p4WKivgwix8SvUNsdstOVCOQxWwOgOE66ISDT7ov2XOhd9X7AEyd0lNQ96B0LI6tSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734563383; c=relaxed/simple;
	bh=l2C6LMJUqwjfL15mBdBVMv+pFsAcLtUzpfL941VFEhU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=eftJLqzlI0E0AzROhoHyKks2M7X/dnJiRNdlrFTTeK8S3FqQh+pLmn2h/8Jr9n8zVN3zSZGVDz3L/EiLDOvmBVElci452OwKBAtfFe+4AEgxAYqv5hBfqQfgIboNU0DDcPcUsqslOcqflPXPkmjQKaDuof1cucmTagsnpLWLx3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FkoWw0px; arc=fail smtp.client-ip=40.107.20.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WFu6SC2/R0VBrev13OPujGXA4mzh4USOzvNuco3IB7BrcFRJNu6mMXpv1Jz61F6wwcsvgDRYWDAi3sbR9f/zXmVeJCjim01ecOUeRs+sEi0dT1G1H199KVVEbUzlKvPhhjKl6eBCtsdTd0KNG5OMqvF4R89bQ8tvXtSCbSnBiKVBFYYTuZB6CUL0DlOTjNpTn7ofhDXNzhXU0M2KAKKnxBheO2zXiWePWq+2AXAKjnnkfAB/Q9WQcN8ZwCSWPSetJPK0k1yQ15NTAh5t0f7Z76Q1DFYdmGJhpO1QWB+GFTdC00wpdY7gG6r4wvJQX/yhi1T1bkpk7DTsNQBe2mwPvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qMhmx3IfMKOGBT5AVmm/AVxd6Wdf4EwS7VY3c3uyOJQ=;
 b=D0TGwIRTSPSLIBbx36WwjCyeokt72Ujc+7K/ubEzxfDh8/SNHyg01MxuYC+sTYp5t89+a2JvNqkkKvezfY+HWPK6qRlFqTQrOExImnnRKP1YZZ72BRjUqeYoHl/ox5AI1kmLGC9DBeeu+OPp7XaJvPb6S1N9tJ8dWGmXt07ig3LafWMTfZTaLWu8JOgQ5HFy4N0X+GoA09XeLdOTM2QrUvEhA5I7oqhvdNCc7N46w/o+kmhd43TZj56xiCewZzRDm+9bmic+Vyj3TjvpIaHg5Iz+wr14NjMK/PgHCKl1nUWeP0Y2aML9i8plrWMROFXu5stKwJ4vPQsYu1uaI7k1ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMhmx3IfMKOGBT5AVmm/AVxd6Wdf4EwS7VY3c3uyOJQ=;
 b=FkoWw0pxN73Pc0zHafqohI6P3FSl1/jOxVG9Ow1kwWDzFLBpoDnBQGZYl8FzulDQayZGIrUeCp7fTUgpcQGYgFeaL3gOZg7+gFR7yJXSh6KaapNdCUFZFNGCElGJF9zLND/HiVDGWhmITZ2hfwuglD5fymPbICOZd1Bsp8l0t3jAja5Ul5OeFgLQVmNfFG+vYumNSspdkO+xgaBGofYQNoJBTkGu1vniK3oUJDbg3Z6vYVv9/pKVGH+5xwUYaNSMauDbp1ohGe7XEs2WptRJxBB9rg2l6dI6jdCHJ9h2mPbezbj3m+kdrabySLYxcT/7JbrRni0WL636Kke3nEEcKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB9939.eurprd04.prod.outlook.com (2603:10a6:10:4c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Wed, 18 Dec
 2024 23:09:38 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8272.005; Wed, 18 Dec 2024
 23:09:38 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 18 Dec 2024 18:08:43 -0500
Subject: [PATCH v13 8/9] misc: pci_endpoint_test: Add doorbell test case
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241218-ep-msi-v13-8-646e2192dc24@nxp.com>
References: <20241218-ep-msi-v13-0-646e2192dc24@nxp.com>
In-Reply-To: <20241218-ep-msi-v13-0-646e2192dc24@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734563339; l=5981;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=l2C6LMJUqwjfL15mBdBVMv+pFsAcLtUzpfL941VFEhU=;
 b=91oNFsG/tnoV+sN6DpKwYVDM/B8v2uynPI0+sX3ID3wYxbkT5ABMfcnrDgnFh0e8F5EyGWcYy
 CqBo5OASkCwDzFU8LgGfGB40n6qYwgzCRiAxJdAduyWosOcUOadnu/J
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0075.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB9939:EE_
X-MS-Office365-Filtering-Correlation-Id: 60a3e669-3326-4d3f-8d2a-08dd1fb90bfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V1Q4TW42cHd3eWdqdktjSlNsam5uL1U4dWRVNjlIbFhYRXU1cHk5SlpBY29i?=
 =?utf-8?B?NlBnN2xXYVlhTVhhZjk1WEpQdjVETkdlMFJWaXJoMFd3UnNDSlB1YnJHdDNl?=
 =?utf-8?B?WU1DT2wrYStFTjU0bWNoZHp1ZkFqRkpaR1I3bUxzaEFKeGt5TXpIbzhNQzhF?=
 =?utf-8?B?Um10RTVmVTZxcXg0Z2R6MGFWSTFDRkpHTnBhcUZLTmk4blJzYmpyOFphU05u?=
 =?utf-8?B?Vy96bEozdVp3MjFTbGh4WXorVElCZ3NFKzF5Vk51T1JjVmwyL0xFZXdsaVM5?=
 =?utf-8?B?bEdBbStrZVdWM0s5OWRTdW45WEtHRVFkZ2NMbkZIK3Vmd1ZBMFYrQTZHRnpX?=
 =?utf-8?B?SXQ5U0lTTjRkNkV0N2tzQWxzTEVkd2hNYXlMM3ROQXNZODlFOVZSaDhDb2JK?=
 =?utf-8?B?YnJRa1pMdTRUd2tLRUhnNDZzK2xqa082NG4vY2IxaUs2eWlXcFl3eTE0T0ZH?=
 =?utf-8?B?d0o3NFB6NDNseDFsT01YY0xsZUJGd1NZdkE4eFdSTEtTZUhQZTRMR3ZuR0lh?=
 =?utf-8?B?MjNjWm5kYzc1TFlzaTZESmQrWkptL1cvMytsV2dWd08vVXUyWnVVdmNxRWZQ?=
 =?utf-8?B?Q0JyTk1QZnlLbTdoYW5NOGdXWmxyS0dnWW4yM0FFdXBqYTJwOEt5YWt6TEJo?=
 =?utf-8?B?UjN0UldkdTQwb3hSaDc5VC9Nb0ZKVWY1bzNEUDF6WW1kWWJmSTB1Mm1DbVBO?=
 =?utf-8?B?QjNDdG5kRzBYaUp1Slp2YlJvRnZ4NXJZaE1zT1h1NmJUelJMZ29RTkVFSnNR?=
 =?utf-8?B?MXgyR0UrVERDL2JJeWN4d3RaZ1JQendYeDlYVng4eGxOdEk5b3BkbWJmQ1d6?=
 =?utf-8?B?bW5ObS9RWXNNUm1yYjdFKzFEM05wMWhtb1JkVkJnZVhzYVdURGxnb1NNTEE0?=
 =?utf-8?B?eVh5ZUIvUlAyZlBqeUZCVU1ncENRZXRXeFBQVXpHVHBtanZiSmxYVGwxVUNq?=
 =?utf-8?B?Q1FiRE1iRjJlYVZOc1A4NWtpUXlDaFVCbTBRRTYxOGRCMUxBUTNsbHhLNVYw?=
 =?utf-8?B?S1RKTE9sa0tCWDJheGlxcFYzZVNieXlyajZ3K2hPWWRaOU50TERLWFJzcklk?=
 =?utf-8?B?OXZCSitTOXd3dWVYVlBrUDRoODZKTHRWN1RxWU82T2I4THUweXh5YWVDRGpj?=
 =?utf-8?B?UVQwMTZwSUVnVmNzeE04SzNTN0l0azl6VzNZUGE1LytxVmR2ci81VEZpbW9X?=
 =?utf-8?B?TE5DM2RKRmtiN2I5YTVGRWF1U1ErTDRzRDgybkJTVkRJSWpNZVE3Ym45L0l4?=
 =?utf-8?B?aVhhcGNjbDVoNHd1Mk5PaU9WR2Q0ejM4UlI2dEZuRDJGOW4veWI4dEJFcmVr?=
 =?utf-8?B?bERMSzhBcnptL2tCRzJzNUdOOEhNSVBmMXU2ZzNNQkFSQmJxTXhBUlB3ZnJt?=
 =?utf-8?B?a1FaREM0aVp0YVNUY1NSWW1lSndHR0xLOC9aL3YrV0UzSmwycENLS2t6VE01?=
 =?utf-8?B?ckdWYTByZUhOY3pzYTFuQTM4cjB4MnFFQS8vMFg2QjVVbloyNVIvSWNkUHpF?=
 =?utf-8?B?V2RTZm9aQS91akEvclhwaWRGbHRxSTN2SUZwSW1mMzZoaWNDVThITms1YTNj?=
 =?utf-8?B?NFJVMlpDUHVBNktNT3FUQkJESGtRWWxobGR4N0NSZ0picVRZM0M0eHRaanJI?=
 =?utf-8?B?ZXBxWXFpM2R4bFNsOUs1T1UyVnpKdHBEOHBQTHZuTnpyNmoyVzFDcjgvT1NJ?=
 =?utf-8?B?T2E1SVJFUmo4MDNOUWoxVFJybkVXNVoySzdFeGJlYUN1bDNHNHF6T3Z4ejRp?=
 =?utf-8?B?dlBPUFovYUh2UjZHTFcxSWpKVUZoVnZqVVlQMGFjMmlvdmVYcHZZMXlOelpE?=
 =?utf-8?B?eDdBekp4WFlVMGpKTnJHc0VNb2Y3VTlWaElmQWRra0JuRG5GT0NFRCs1cDM4?=
 =?utf-8?B?SldadWdmU2l1UElJV29kMHVtckxnQXIwTFFFcHNIZnhlaFhxSUI4YW51M0gx?=
 =?utf-8?B?NmhnQ0o5MG9NWXkwVlZVamIvbVkwdjgzVHJnUlE5RHVhcnE3N2xmNStVam1V?=
 =?utf-8?B?cUlyQ09ndktRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QVhYYzZzdmhCZGZKclN1WWpzM3hic0JTMjZOaU12VVhjaGNtOFJTWEpBYkNJ?=
 =?utf-8?B?THdFVmhmQXlvVCtGVzJ6WC9pSlBPS0x0dnZqY1Zob2dDeUtydEIvNFBjaG43?=
 =?utf-8?B?S01MSnVOTXRPa0x6ZS9FamJCVE5oY1RhN3R6K0p5UE1CNXdFM0xxSk10RlZG?=
 =?utf-8?B?aWV2ZUIwaXludTR6OVhSbmlTYm5sSW90NUkzQkUyekw4NU1rSkE4S2VWNEVt?=
 =?utf-8?B?Uk5DSHBDSWN0UjNLTTN5cWttSEhmZjVtQzZnOWFKaURWSlRHcGtKZjgyTDVa?=
 =?utf-8?B?Um4yVkdRVGVtRzRpUEdpQmYycVpyOVlWTGkxa0lXWm5BK3JKQlJVVzExTlhU?=
 =?utf-8?B?VjFiTzBSdkxJKzBLaG9mcFd4TS9ET2lUZUp5b1Q0a2N5UW94VHlHblRoWVVY?=
 =?utf-8?B?b1dOdk1SUitNZUJaK1czWDJGUUV3Rkh3VmlJWVBtL28wYnJidjloaFBhdlF3?=
 =?utf-8?B?bTd3NWg1YVNkT1YwVENjamZiK29qSE1BN0czdENzQzg5eGMvZVVudzNDaHUz?=
 =?utf-8?B?cnEzWVRjVldrT05XWXpzc0dHa1RLdDZJVFpDMVNnMnVQdWEyU0xzSlhYNEJP?=
 =?utf-8?B?a1lTMURNaWg1R2o3YTdTbkV6MG5tSm9UWnAvZ0FqV0cwZjhROURURjA2YzNu?=
 =?utf-8?B?SEk3VFNJbmFOUGl5NkFtTHNGTjl1NXhsV2JVRk5PT0MwZEE5RHVHcnBHQjZX?=
 =?utf-8?B?ajZUVXlUSVlGeDN2b0NQWHJtbVNWVzBJMElqcDBMRjNQMlRqV1BXdi9rUnoz?=
 =?utf-8?B?WHlkN2w0cTdjUGVkMXNUSmZiSzNJbW5wblZqSm9YYnRWK244aExsWDdVcnJr?=
 =?utf-8?B?WExHbU1KQTBtUnhUMWlOeFIxWUhYTnEvcjZGWWszeTVkWDZacC9Wd3haTWo5?=
 =?utf-8?B?WW1qeTdRQWtObG5GOXU5bVpaRllTN1pxd3JSamlHSS8weUpQYm1nK1lsL2R0?=
 =?utf-8?B?aWNPOTRmYzJCUWFXZnVNL0p4YVVRLzhQWWh0RzhqMEp0V2NCMUFYbFJ0YkFP?=
 =?utf-8?B?ZjJ4cnpMVHgrQnZxVHI0NnBDVGVLcWhzUEtlODJnRHZSRjdzNUdYNlNLa2pU?=
 =?utf-8?B?bGR6TUVBZFZ4K3U0YkRMMmlBaHlOL05SVUdKWHhKTVVDZXcvNFFSL0d0anRE?=
 =?utf-8?B?OE91SFpVVFNQdWlXUU5sSGN5Y2hsU2p3aXN2MWlOTFVESVlFajlGZkJyZTFk?=
 =?utf-8?B?d0hPYXJTdWNabk5YZ2tMOEpkc0pVVDY2c2RiN1BsOEVHYXQ1ajRBSHFYd1Zy?=
 =?utf-8?B?eGwyYTY2MlFFbjVmOUsrRXJaRDNQcjZKYkZQSDEwODc5bU8rakFBSVZSY0c0?=
 =?utf-8?B?MGRlbjlXK0V2RGV2QmhSOS8wVXRibHpzQWhkWDkrQ0wwL0huQS9XYjJsY1J2?=
 =?utf-8?B?VE1PVW45WCtQa216KzJxVFZFdWlNRnVzRmpXVjczWWxsMzJtQ29hV1R2QXhZ?=
 =?utf-8?B?Tko4K3ZvNjdZRHp0ckI5N1Rsakh1dFFvTGF2R1hHYXV1d0tQSFluek00NGNn?=
 =?utf-8?B?bEJKYTVtNTRkcW4ySVdWeUIxdnNTNXhZYWRsMCtsTlQ0OUd2bGxGRXM2QU1k?=
 =?utf-8?B?U0pGS25LZzVvbFRYeHlTUGIyS25rditpSU9oWWhiUXlucDA4MkhOdDFRRGla?=
 =?utf-8?B?V0R6RkhHTm8vT2owRDhSc1VVUSsvWHZGS0t3RVkweEc5ZWQxeS9FRndic0th?=
 =?utf-8?B?VVBBbkkzeUxSLytLVGpwbnBqZDUwcmlwMndoVW5wa1NwNGErZUZlRGlEckZC?=
 =?utf-8?B?UWYxVkxJY1JJTkI5Z2pBWEJvSEtJTnVLb2V3MFFFRGN3TmI3S3UxalRFckNx?=
 =?utf-8?B?NFdQcEtlTmNMUHdYWGUrS2pnSVlUaTZTRlNwT09yOXpVMlFyYVJXT1NFcVNU?=
 =?utf-8?B?SytVZ29YMWhFV3QwYzRWWGVEUGw1cU9aaXFZMEh0Wko1bys3UmlmQ1BycXpL?=
 =?utf-8?B?MVFqbVVPaXdwZ1p0WFMzcGZtL0ZlN1E4cnlTeXVGUzhRZ2E1N1liRytLcjRC?=
 =?utf-8?B?SUdPYVZyWFV5Z0pKTk9lOVJzVW4ybFRFR0F2Z1p1YjA1dVZONUg2MGhGSFR3?=
 =?utf-8?B?ekdKZ3N5bllLOFhPUkxjMUNvK05BaWhqV0xEKzlwQm8yb05RM011RTVreUE4?=
 =?utf-8?Q?ZS/4dnOw7DIiFnNDY8X83GgK1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a3e669-3326-4d3f-8d2a-08dd1fb90bfe
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 23:09:38.7910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E6NatG5Afnz7WEyiQJTfL7pW8DfbYaGto6o8qKXS908t3ayNWyJ2PE9FjOnP/uHqsc+NdFVFcHJRuDhU56cicg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9939

Add three registers: PCIE_ENDPOINT_TEST_DB_BAR, PCIE_ENDPOINT_TEST_DB_ADDR,
and PCIE_ENDPOINT_TEST_DB_DATA.

Trigger the doorbell by writing data from PCI_ENDPOINT_TEST_DB_DATA to the
address provided by PCI_ENDPOINT_TEST_DB_OFFSET and wait for endpoint
feedback.

Add two command to COMMAND_ENABLE_DOORBELL and COMMAND_DISABLE_DOORBELL
to enable EP side's doorbell support and avoid compatible problem, which
host side driver miss-match with endpoint side function driver. See below
table:

		Host side new driver	Host side old driver
EP: new driver		S			F
EP: old driver		F			F

S: If EP side support MSI, 'pcitest -B' return success.
   If EP side doesn't support MSI, the same to 'F'.

F: 'pcitest -B' return failure, other case as usual.

Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v9 to v13
- none

Change from v8 to v9
- change PCITEST_DOORBELL to 0xa

Change form v6 to v8
- none

Change from v5 to v6
- %s/PCI_ENDPOINT_TEST_DB_ADDR/PCI_ENDPOINT_TEST_DB_OFFSET/g

Change from v4 to v5
- remove unused varible
- add irq_type at pci_endpoint_test_doorbell();

change from v3 to v4
- Add COMMAND_ENABLE_DOORBELL and COMMAND_DISABLE_DOORBELL.
- Remove new DID requirement.
---
 drivers/misc/pci_endpoint_test.c | 80 ++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/pcitest.h     |  1 +
 2 files changed, 81 insertions(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 3aaaf47fa4ee2..b3f36b6ba8ba2 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -42,6 +42,8 @@
 #define COMMAND_READ				BIT(3)
 #define COMMAND_WRITE				BIT(4)
 #define COMMAND_COPY				BIT(5)
+#define COMMAND_ENABLE_DOORBELL			BIT(6)
+#define COMMAND_DISABLE_DOORBELL		BIT(7)
 
 #define PCI_ENDPOINT_TEST_STATUS		0x8
 #define STATUS_READ_SUCCESS			BIT(0)
@@ -53,6 +55,11 @@
 #define STATUS_IRQ_RAISED			BIT(6)
 #define STATUS_SRC_ADDR_INVALID			BIT(7)
 #define STATUS_DST_ADDR_INVALID			BIT(8)
+#define STATUS_DOORBELL_SUCCESS			BIT(9)
+#define STATUS_DOORBELL_ENABLE_SUCCESS		BIT(10)
+#define STATUS_DOORBELL_ENABLE_FAIL		BIT(11)
+#define STATUS_DOORBELL_DISABLE_SUCCESS		BIT(12)
+#define STATUS_DOORBELL_DISABLE_FAIL		BIT(13)
 
 #define PCI_ENDPOINT_TEST_LOWER_SRC_ADDR	0x0c
 #define PCI_ENDPOINT_TEST_UPPER_SRC_ADDR	0x10
@@ -67,6 +74,10 @@
 #define PCI_ENDPOINT_TEST_IRQ_NUMBER		0x28
 
 #define PCI_ENDPOINT_TEST_FLAGS			0x2c
+#define PCI_ENDPOINT_TEST_DB_BAR		0x30
+#define PCI_ENDPOINT_TEST_DB_OFFSET		0x34
+#define PCI_ENDPOINT_TEST_DB_DATA		0x38
+
 #define FLAG_USE_DMA				BIT(0)
 
 #define PCI_DEVICE_ID_TI_AM654			0xb00c
@@ -108,6 +119,7 @@ enum pci_barno {
 	BAR_3,
 	BAR_4,
 	BAR_5,
+	NO_BAR = -1,
 };
 
 struct pci_endpoint_test {
@@ -746,6 +758,71 @@ static bool pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
 	return false;
 }
 
+static bool pci_endpoint_test_doorbell(struct pci_endpoint_test *test)
+{
+	struct pci_dev *pdev = test->pdev;
+	struct device *dev = &pdev->dev;
+	int irq_type = test->irq_type;
+	enum pci_barno bar;
+	u32 data, status;
+	u32 addr;
+
+	if (irq_type < IRQ_TYPE_INTX || irq_type > IRQ_TYPE_MSIX) {
+		dev_err(dev, "Invalid IRQ type option\n");
+		return false;
+	}
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
+				 COMMAND_ENABLE_DOORBELL);
+
+	wait_for_completion_timeout(&test->irq_raised, msecs_to_jiffies(1000));
+
+	status = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
+	if (status & STATUS_DOORBELL_ENABLE_FAIL) {
+		dev_err(dev, "Failed to enable doorbell\n");
+		return false;
+	}
+
+	data = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_DATA);
+	addr = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_OFFSET);
+	bar = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_BAR);
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_STATUS, 0);
+
+	bar = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_BAR);
+
+	writel(data, test->bar[bar] + addr);
+
+	wait_for_completion_timeout(&test->irq_raised, msecs_to_jiffies(1000));
+
+	status = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
+
+	if (!(status & STATUS_DOORBELL_SUCCESS))
+		dev_err(dev, "Endpoint have not received Doorbell\n");
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
+				 COMMAND_DISABLE_DOORBELL);
+
+	wait_for_completion_timeout(&test->irq_raised, msecs_to_jiffies(1000));
+
+	status |= pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
+
+	if (status & STATUS_DOORBELL_DISABLE_FAIL) {
+		dev_err(dev, "Failed to disable doorbell\n");
+		return false;
+	}
+
+	if (!(status & STATUS_DOORBELL_SUCCESS))
+		return false;
+
+	return true;
+}
+
 static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 				    unsigned long arg)
 {
@@ -793,6 +870,9 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 	case PCITEST_CLEAR_IRQ:
 		ret = pci_endpoint_test_clear_irq(test);
 		break;
+	case PCITEST_DOORBELL:
+		ret = pci_endpoint_test_doorbell(test);
+		break;
 	}
 
 ret:
diff --git a/include/uapi/linux/pcitest.h b/include/uapi/linux/pcitest.h
index 94b46b043b536..b82e7f2ed937d 100644
--- a/include/uapi/linux/pcitest.h
+++ b/include/uapi/linux/pcitest.h
@@ -20,6 +20,7 @@
 #define PCITEST_MSIX		_IOW('P', 0x7, int)
 #define PCITEST_SET_IRQTYPE	_IOW('P', 0x8, int)
 #define PCITEST_GET_IRQTYPE	_IO('P', 0x9)
+#define PCITEST_DOORBELL	_IO('P', 0xa)
 #define PCITEST_CLEAR_IRQ	_IO('P', 0x10)
 
 #define PCITEST_FLAGS_USE_DMA	0x00000001

-- 
2.34.1


