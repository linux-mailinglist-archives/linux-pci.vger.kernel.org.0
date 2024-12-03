Return-Path: <linux-pci+bounces-17592-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5E09E2D42
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 21:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79093166C94
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 20:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1B51F9F71;
	Tue,  3 Dec 2024 20:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DmpoFpIQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2043.outbound.protection.outlook.com [40.107.21.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D8D1FBEA7;
	Tue,  3 Dec 2024 20:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733258235; cv=fail; b=L2NCHQ9eHXz3E72i1/yRAMsc3wsxVkTqM78MfaH67bTJKEXh5luGu+cSUWCRGFom8WEBMzU+QNwYixFomYV6q84bqtgedr8+coWHuXM7X+lrafr/Vr5IqwN+TpPXqxAK/hm6Ae0OevbKA9Y8/AstqJTz/QaaVE/1fEWSngKTdqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733258235; c=relaxed/simple;
	bh=7/e6/0CXkB0mf+SY0mOWY+HgbTKlSQIetGfxHQ240Sk=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=FRCPHKPvf5kBywD091E2C0Jdi5Yg4EvtwcLdWRFePltD/dZHfJ7TjlhrGECYi1hd05Sbo/YgZO41oCAcbkBOS+dR78Z0LNtiJyvN4q0PbWOka7OadixlcTi4AotH3iQPQ9Qtyy+/ox1Y/1XzsJNli3s+8Ay8GRURykKur2kq+s4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DmpoFpIQ; arc=fail smtp.client-ip=40.107.21.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tjFZVaSx9TU48r9VqsIzFJq1mwrd/RxpvpTb5BONOHlxkA0sJREB5btdKpXpRVk6A8fgs5ciuvW5YmS7NmcHigDkwKuXT23cgjv8sKgi+9g2R7prkWIr8QD1uI+5dvPBE/QcBC2jz0aIXxokgsh3tmz9OPICVNceBeot+/PNwy5uy3hCsklgqRNWR0umeQlzU8JTCy5CmCtGyyCJwsOhzJFXzVAdMVV+A9shbS39Ph9yoIKMsjvGPXju8exBc8MhRXW3jXesbKno4+kzIF6LwWpHmmpL/CWSrNJNbQO3OnaZeXf1x07OXic2GirUNV/FOomEN18RcehjRkbvOL+3sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JSYvUhgjSkj1P/Yyh0xabH6otNss+YN/Gpw3l4EzCJY=;
 b=wrVSGrJ2bzJ/taQXr3+80D51DIQes1dKulG1d/8soI/x++m8GKoe8Tajw0YBzzuuOYUVAdsJlU6ZvP2TlUavhuSSkeparycBLpw7gIax24D0ZUYFkZghVhT2UiyCdLEw6+jZje6GFUzOawwIeLEDpfogp+QFQ+DtzEfFa9Ch2SFDSXuvoxm1lgzKS4833OhgR3toSI1oxBJ78bydKVbunMWjbRMiHNguc5VzqOdQHZ1L4GsKWU8spI/2sijQDcf7MkSbZOJ8Yh7adMJuUz+08VpSUUB/H+HgOcWQsR4FmnSf+w0slNVf/4d+pQ9Q6scNXXHR9YKSt58bvJTcbrL2eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JSYvUhgjSkj1P/Yyh0xabH6otNss+YN/Gpw3l4EzCJY=;
 b=DmpoFpIQgC1QAoY22/8rVYo7vMsHmYYABdnVCrqgvnQ0Pnh+2AzXGBuc7qlyUodTWTX15ZNlUlj2xGJbMsYw86vEfMyogWbn3nnOcU+o5W56T6lKUJ9cHw4NG5BbwyC3uf5wFctR1hFRu1yvWsKaqVzGtlMJCq1Mhv1nkmGYy/Ayfs6SEdKGJ0jo5Seb7GdFm/Hfuz1CKEA97FBc8EBxed2D9oWw2pNlewOB5LWjYsbiLkhRLtGRDSQme/offoNfgwg6+Cgerk+moB7lrCLEKgpl0+KXTfcYVYzcIlrnR3ifh54KbROctf+RNs89TKtBvw9v84PhbkTbMWLJMTyvMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8730.eurprd04.prod.outlook.com (2603:10a6:20b:43d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.10; Tue, 3 Dec
 2024 20:37:09 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 20:37:09 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v9 0/6] PCI: EP: Add RC-to-EP doorbell with platform MSI
 controller
Date: Tue, 03 Dec 2024 15:36:49 -0500
Message-Id: <20241203-ep-msi-v9-0-a60dbc3f15dd@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOFrT2cC/13OTW7DIBCG4atErEvF8E9WvUeVBQzQsIhtmcpKF
 fnuIZFC7C6/Ec8rbqSmuaRKjocbmdNSahmHNtzHgeDZDz+Jltg24YxLYMBomuilFmqDRB+ECBA
 SaY+nOeVyfYa+T22fS/0d579ndxGP6yuhXolFUEYxRbTOg0bwX8N1+sTxQh6BRW6QgI5kQwZM9
 Dw6F7jdI/VGwGxHqiEP0ilAFhkze6Q3CHhHuiGpsjOcJ4H83/fMFsmOTENRejTe5xA57pHdIt2
 RbUhnyNrmHCGEN1rX9Q6oNpLeowEAAA==
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Anup Patel <apatel@ventanamicro.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org, 
 maz@kernel.org, jdmason@kudzu.us, Frank Li <Frank.Li@nxp.com>, 
 stable@kernel.org
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733258225; l=7426;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=7/e6/0CXkB0mf+SY0mOWY+HgbTKlSQIetGfxHQ240Sk=;
 b=eQW9eX+icDMuqAihu8dYnxVl/wSAswx08NFs6z9SJ6eBEoGES5UoyW7UtFNxkpxMXz/776Gko
 O1uXJQix/thAlPtMzv0amYMB3CvGYNbtgNPvV7clPuXg6l4OYqOi23k
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::26) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8730:EE_
X-MS-Office365-Filtering-Correlation-Id: a79ce314-14e3-4047-3c85-08dd13da4246
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TlVia0ZIcWJqd3ZVVmJjMFJLZUx1UGgvcElnWkVKTWh0YWVpTG5qWUNodi9W?=
 =?utf-8?B?WGpyTmNhM2VwR2oxT09XVHNIOVFRU1hic0tGRENMaTQzQW9ySGtoSjdlemE4?=
 =?utf-8?B?Z3pZbk1FN2RXWmFWS1JUUVpSYU9UMllpTEVtR1lBN0J0b3NzandOYVlYRHEx?=
 =?utf-8?B?ZnUxKzduUytHaWtyTisvT0RXM2N0RWhiSHNoN1owdzJlKzBvQkNXM1Z6ZHVR?=
 =?utf-8?B?a3RZc0xkNlRtN3VLZFJlYlhNV2RPZGdZSldRSVpBUit1RXV1dWEvOXVpYXlW?=
 =?utf-8?B?SmNEWThQRlRCOTFETDQyWVYxYXBWNFJUNG02N01jMHg3UUxnb0JFTlJ1T2ta?=
 =?utf-8?B?NTYvWWZMVWdnOWdIQVdnUzQycDU1ckwxZWwzcEJMQ3BFSVY3bzhEbTROUFBn?=
 =?utf-8?B?c3lBWnNVVmRDcjFySWZmZGpiSTVmOFFLR1R5a3V2aFdXQXhYYi8xdHlpc2lv?=
 =?utf-8?B?d2lNVVl2aHRxSDJyUWE1WFowOUF2WXU2aGlHMTUxK2VFcWk2c0RBYUZHYnhI?=
 =?utf-8?B?NUdIZVIxck9kRUR1bGtvY0szdHVwZFBSWW9RY21sWTJGQWVOQllaRUdBZTRI?=
 =?utf-8?B?S1V5MFczR0dGNVFzK2l4WE91MTVGVks1WVM4TEtpNDZqWElQYUxUTDk3SVFu?=
 =?utf-8?B?MXhWR3ZMWGdRekx4dExTbm5aY1hsTlRkb1ltK09pemJCKzFGWGhtbGdOK1kr?=
 =?utf-8?B?TjYxSWszMGY0SXU3dUNEanNlZlhiOUQwZys5dDFzajdCY29YZkw5M1c0bG5G?=
 =?utf-8?B?d2R5UnhPcGFoS0V2MlN6Zkc2NUhHa1N4Y1pxSUw1eVlRRG1PQlY1RzB6U05H?=
 =?utf-8?B?OFpoeWhCNUpUWWdiMnN1SUllVlhTOVFteUtoRXMyb2lVOWhPeTBvaTM1VjVM?=
 =?utf-8?B?YWZFSkFURnVuZkwwMVZJME0xc0VqWjhrbUZzNTlhT3FGN3VmUTR1eEJOWTJz?=
 =?utf-8?B?cmJYOFNIQXd0L25NaWFJaEtRaGtoTE5PcTB0a2xPZjhldGo0MGdJbW13S1dy?=
 =?utf-8?B?VUZwVjJ0M2NxMGd4c1ZnNS82b0ZnOFFROUljSXNPS2haOXNieDM5QllyQzIv?=
 =?utf-8?B?RGZqOFByVXVHNUpIcGRXUWhTUUdSWXJYOWttZzdPRnZuUjZqUm9kUVhMTnJy?=
 =?utf-8?B?SGxKUnB6Z01BMEN1YjhKOTk4WnJCdTNVNDZtaXRiYWJ3KzlSOGxnT09RblhT?=
 =?utf-8?B?dzBRWVZvT0w2OXBFV3RSV0ZLM2pJOG1kMHZtdEl2S1hNL2hQQjRyTUhsaENv?=
 =?utf-8?B?M3VlOUJSQ1AyZzdzV2o0MmkvTXI4WUluY3VNa3RGTmpWUnVvVFo3STVEajFj?=
 =?utf-8?B?WE1rbVFqenJaWVNGVFovb1laeTJNckxZV3RGYzdQT2EvZ3NraE5RT1hjMSti?=
 =?utf-8?B?azlPdUNoMmF0RG1JSlhQZUVUdjVRcm5oQUp4Y05jYkRxdWRmQVl6VHVGWW02?=
 =?utf-8?B?RHJTTitlZ001OGhCTkNxV1BSMk9ZcWdpTWVKWnRIbWxFbHlMMXJEZURSbjg1?=
 =?utf-8?B?QjNSalhpUmRySDNoSWhyU014N2Q4bTR0NmhBZUlZWUk5b2lDNWRPaldvUSt5?=
 =?utf-8?B?OEdUVWlTVWI1bUtxenNmZHdkK09MMkYxMk9nbEZ0M1VFNlhlS1ZsWXd4R2pB?=
 =?utf-8?B?bXFuem5zVDJQOFpDNXI4MXJFM2hlcFM2U1lrYTlSdzUzU3J4STd2c1pkVHZ2?=
 =?utf-8?B?QytFa1I5dEkzdW51VlNaUWFoS1BjRFlDME16VW1RWHRzN2lWcEh0M0Y1QTJq?=
 =?utf-8?B?dFNwRHY2ZDVBWVc1V0NBZHVsckpqcWZvN24xenA4SmJ3Z0JnQ2VwZnFzRlFJ?=
 =?utf-8?B?S0duYW9aOHlvMUhRT1hRVGNvNXphbk5qenRXcS9tK1RpcDcxSHlDZkZPeGxN?=
 =?utf-8?B?bHdUNTJmdENTRWdMMGdwRVZRQ1lra1hZMjgrRE8vajAxYmc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZTJPYzlSeVlHZXFRVFQ1YmNqZG5YaXZRUnZQZEZhTGIzT2ljV29MY2F3VkUz?=
 =?utf-8?B?Q3FVVnl4bXBIQ2JpM0tpNFZxTFhDODdWNHh4R0VPUHROczE2Y0YzRThkYlBD?=
 =?utf-8?B?MlZzcE9DanJ3NElCTlNxMk10ZisxS2Q2Y3JwQjBmSWJZS0h0SGgvcUtkZlVm?=
 =?utf-8?B?eTkxZ0daRkxXQXRoOVAydFVKZTg0b2VObHJWdEhUbGU0SkhXTjBTSVZFc09q?=
 =?utf-8?B?YVpFMVhGeGlxNHRORklmVHF3TnBTWkQ2MktQOEJUQkdQMTgzU0RtZC9majBC?=
 =?utf-8?B?N3dtZkhYYXhLSUxVbDlkNEpRd3I1aE9MZmZNaXBOTWdYR1JoRTcyaFZjZnFt?=
 =?utf-8?B?SXRKdG9vcmIyYWE0bDdTRjhmcmVsQ0NtbjRpQWkyYXJGZkpYODFmQVBFWGxU?=
 =?utf-8?B?VzMyRXJzVWF3RXZEOEU5aVRuTUVOOCtIRUc1OE5vc3VGU2VCa3NvbmJIKzdK?=
 =?utf-8?B?YjVqeHA2Ykljb08ydy9kdHJIRlNrZmNrQktsKzIxd1pJRjdXcFY1MWZ2czdH?=
 =?utf-8?B?a2xzeklUR283ZFNEWXZCaFU3bCs5WThTUWJ1RW55TTFTRGI0eS92VytrUFQ5?=
 =?utf-8?B?ZER4cDAya1JpSjRQRXZkR1Nuck5zampHUTcrR1pFaUlLMTJrOGwrWTZQci96?=
 =?utf-8?B?MHQ4a1hkeTJhN0h6OEJEeVNaM2wrUy9pQjJZTXU1VElIbnZiTEZqRDhKUGhk?=
 =?utf-8?B?WmVjVnR3YTZ2M2R1RFdSRE9RcEdOOWVzN3lxTTZiSm1yRlBMMGcrLytVWlJC?=
 =?utf-8?B?WVdyZjNuUURKNm1ldTZuMGQwTnliUnV4dHJDMFNnakxWdTRlWTB1RGZFVEsz?=
 =?utf-8?B?TlptVUxlUkZWTGN4c0s0aXZoYmxCZ1VXN3h0VlNleWE3anE0RjhkUTlubnFB?=
 =?utf-8?B?dDRBb1IzV0NmZFRoSXpSTjJQczRKSHorMG83bXk5MDFCcWZWT2FMaWZLa3Zm?=
 =?utf-8?B?VWJ2RHdYM0hLOTJRNjYvdm0vQWVMVXlCK1M3VnJkRmJwU2U3L1lvVVBDZVVm?=
 =?utf-8?B?UWthVk9vVVRvbU0wV0ZPY1dlRUUrL0tqRFg2cWpDQVR1RFBQUEJRd1RBcWFK?=
 =?utf-8?B?VmE0OHVLcnYvQkMyOGJZRThOY3FhWVluenBPQlR1S3o0L1dHYVoyd3pYeHpw?=
 =?utf-8?B?WGRaK0haYVhueHNNNCt2Z1ZIRHM3K1U1bHV2NitvUkpia0xiZHR3a28rdHRJ?=
 =?utf-8?B?cEdkSldMQzFnckNqOFdMWlR3dzYwbHNLZ2c4TGhydXkvc0dwVFhNRGUrTHFm?=
 =?utf-8?B?Qy9rUU50cndPYmRMNDlPWTdyYWtubHNPRXRaVjVmV1VYb3cxQnova2U1cWJZ?=
 =?utf-8?B?T1F4MGpMVGF3NWsydlkwN09ZKzlHelY4M1BBSkhmYzRFVjUwV2ZaQXZuNnQv?=
 =?utf-8?B?aEl3dDhhZ2pGTXR3NXowZ0R0eUcyNE5POUJsbks4RFdmbnViQWQ2dW52bGpZ?=
 =?utf-8?B?MGNVekVwQkNNaDFWS0t5a2N5ZVpPZ2JMd2FrVUhERkMwM2I1UWxQT0RLN0Zl?=
 =?utf-8?B?a1NOeGprWUNRV1RNYlpMUWMwZzJTNHZVUysyR3FORTlCaDZqRmhjTURpRngv?=
 =?utf-8?B?a2RlQTh4ZDdvRGpPT0FNRjcxcjFBY3AycXZPSko1YmZHZW8zTnk5akExVzVh?=
 =?utf-8?B?Mm5RVnFydCtuejF5TXMyMFBLVG1TTld5TDlZeUpJWWw5eE5FQkdubVI1dVBk?=
 =?utf-8?B?clVmcG9IV21IOHNyTklSZmhuWWl4WHpiOWhTMFltSkxFemV3Tjg1eXlnNExL?=
 =?utf-8?B?M0hwMUxzS1lkM0lCVlRTdjVtQ0pOWnBwaFFuU0xOamNmeDM0Zm9EeXc5Ni9B?=
 =?utf-8?B?eG90VFFkOTRaMzJqb1lkRTc1Mkk2ZS8wUklVcHhDZndKQm1uaFQyNldIcTVk?=
 =?utf-8?B?N0JoMXU0QURENWtmK1NlckJIUzdiUlYwNnZ2YlNzK3RTQmh1QisxbTBZYjJ5?=
 =?utf-8?B?Uk1nTlZJTGwxMHNsSEhaMnhsSFJsTVRUc3NybjVPZU5kQ3M2bUZ6cFZxTFRX?=
 =?utf-8?B?SWZTK0lGOWM2YzYzZjQzSDBxWFEyUUp3cU03SWIxVGdCdUo3Kys4YWIvUGV0?=
 =?utf-8?B?d0RXYnA4ZE9CWEJxQ1l6RXJZMXlObkFCNngyZ1R1NW5iME5Ea01ZbzM0OFBJ?=
 =?utf-8?Q?MgLA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a79ce314-14e3-4047-3c85-08dd13da4246
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 20:37:09.3380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rhm+BN8cycLenp54t1TI9yRnntX+aYB1bkTuqWnk5GQ7YT1tnJLQyzgUXpg2ApI3UGXTR3sigPXhA2maTl4oMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8730

┌────────────┐   ┌───────────────────────────────────┐   ┌────────────────┐
│            │   │                                   │   │                │
│            │   │ PCI Endpoint                      │   │ PCI Host       │
│            │   │                                   │   │                │
│            │◄──┤ 1.platform_msi_domain_alloc_irqs()│   │                │
│            │   │                                   │   │                │
│ MSI        ├──►│ 2.write_msi_msg()                 ├──►├─BAR<n>         │
│ Controller │   │   update doorbell register address│   │                │
│            │   │   for BAR                         │   │                │
│            │   │                                   │   │ 3. Write BAR<n>│
│            │◄──┼───────────────────────────────────┼───┤                │
│            │   │                                   │   │                │
│            ├──►│ 4.Irq Handle                      │   │                │
│            │   │                                   │   │                │
│            │   │                                   │   │                │
└────────────┘   └───────────────────────────────────┘   └────────────────┘

This patches based on old https://lore.kernel.org/imx/20221124055036.1630573-1-Frank.Li@nxp.com/

Original patch only target to vntb driver. But actually it is common
method.

This patches add new API to pci-epf-core, so any EP driver can use it.

Previous v2 discussion here.
https://lore.kernel.org/imx/20230911220920.1817033-1-Frank.Li@nxp.com/

Changes in v9
- Add patch platform-msi: Add msi_remove_device_irq_domain() in platform_device_msi_free_irqs_all()
- Remove patch PCI: endpoint: Add pci_epc_get_fn() API for customizable filtering
- Remove API pci_epf_align_inbound_addr_lo_hi
- Move doorbell_alloc in to doorbell_enable function.
- Link to v8: https://lore.kernel.org/r/20241116-ep-msi-v8-0-6f1f68ffd1bb@nxp.com

Changes in v8:
- update helper function name to pci_epf_align_inbound_addr()
- Link to v7: https://lore.kernel.org/r/20241114-ep-msi-v7-0-d4ac7aafbd2c@nxp.com

Changes in v7:
- Add helper function pci_epf_align_addr();
- Link to v6: https://lore.kernel.org/r/20241112-ep-msi-v6-0-45f9722e3c2a@nxp.com

Changes in v6:
- change doorbell_addr to doorbell_offset
- use round_down()
- add Niklas's test by tag
- rebase to pci/endpoint
- Link to v5: https://lore.kernel.org/r/20241108-ep-msi-v5-0-a14951c0d007@nxp.com

Changes in v5:
- Move request_irq to epf test function driver for more flexiable user case
- Add fixed size bar handler
- Some minor improvememtn to see each patches's changelog.
- Link to v4: https://lore.kernel.org/r/20241031-ep-msi-v4-0-717da2d99b28@nxp.com

Changes in v4:
- Remove patch genirq/msi: Add cleanup guard define for msi_lock_descs()/msi_unlock_descs()
- Use new method to avoid compatible problem.
  Add new command DOORBELL_ENABLE and DOORBELL_DISABLE.
  pcitest -B send DOORBELL_ENABLE first, EP test function driver try to
remap one of BAR_N (except test register bar) to ITS MSI MMIO space. Old
driver don't support new command, so failure return, not side effect.
  After test, DOORBELL_DISABLE command send out to recover original map, so
pcitest bar test can pass as normal.
- Other detail change see each patches's change log
- Link to v3: https://lore.kernel.org/r/20241015-ep-msi-v3-0-cedc89a16c1a@nxp.com

Change from v2 to v3
- Fixed manivannan's comments
- Move common part to pci-ep-msi.c and pci-ep-msi.h
- rebase to 6.12-rc1
- use RevID to distingiush old version

mkdir /sys/kernel/config/pci_ep/functions/pci_epf_test/func1
echo 16 > /sys/kernel/config/pci_ep/functions/pci_epf_test/func1/msi_interrupts
echo 0x080c > /sys/kernel/config/pci_ep/functions/pci_epf_test/func1/deviceid
echo 0x1957 > /sys/kernel/config/pci_ep/functions/pci_epf_test/func1/vendorid
echo 1 > /sys/kernel/config/pci_ep/functions/pci_epf_test/func1/revid
^^^^^^ to enable platform msi support.
ln -s /sys/kernel/config/pci_ep/functions/pci_epf_test/func1 /sys/kernel/config/pci_ep/controllers/4c380000.pcie-ep

- use new device ID, which identify support doorbell to avoid broken
compatility.

    Enable doorbell support only for PCI_DEVICE_ID_IMX8_DB, while other devices
    keep the same behavior as before.

           EP side             RC with old driver      RC with new driver
    PCI_DEVICE_ID_IMX8_DB          no probe              doorbell enabled
    Other device ID             doorbell disabled*       doorbell disabled*

    * Behavior remains unchanged.

Change from v1 to v2
- Add missed patch for endpont/pci-epf-test.c
- Move alloc and free to epc driver from epf.
- Provide general help function for EPC driver to alloc platform msi irq.
- Fixed manivannan's comments.

To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krzysztof Wilczyński <kw@linux.com>
To: Kishon Vijay Abraham I <kishon@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
To: Arnd Bergmann <arnd@arndb.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: imx@lists.linux.dev
Cc: Niklas Cassel <cassel@kernel.org>
Cc: cassel@kernel.org
Cc: dlemoal@kernel.org
Cc: maz@kernel.org
Cc: jdmason@kudzu.us
To: Rafael J. Wysocki <rafael@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
To: Anup Patel <apatel@ventanamicro.com>
To: Kishon Vijay Abraham I <kishon@kernel.org>

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (6):
      platform-msi: Add msi_remove_device_irq_domain() in platform_device_msi_free_irqs_all()
      PCI: endpoint: Add RC-to-EP doorbell support using platform MSI controller
      PCI: endpoint: Add pci_epf_align_inbound_addr() helper for address alignment
      PCI: endpoint: pci-epf-test: Add doorbell test support
      misc: pci_endpoint_test: Add doorbell test case
      tools: PCI: Add 'B' option for test doorbell

 drivers/base/platform-msi.c                   |   1 +
 drivers/misc/pci_endpoint_test.c              |  80 ++++++++++++++++
 drivers/pci/endpoint/Makefile                 |   2 +-
 drivers/pci/endpoint/functions/pci-epf-test.c | 132 ++++++++++++++++++++++++++
 drivers/pci/endpoint/pci-ep-msi.c             | 106 +++++++++++++++++++++
 drivers/pci/endpoint/pci-epf-core.c           |  44 +++++++++
 include/linux/pci-ep-msi.h                    |  15 +++
 include/linux/pci-epf.h                       |  19 ++++
 include/uapi/linux/pcitest.h                  |   1 +
 tools/pci/pcitest.c                           |  16 +++-
 10 files changed, 414 insertions(+), 2 deletions(-)
---
base-commit: 0b020199675f5fcb4df1120c33d01dc6e18ff8ae
change-id: 20241010-ep-msi-8b4cab33b1be

Best regards,
---
Frank Li <Frank.Li@nxp.com>


