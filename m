Return-Path: <linux-pci+bounces-23363-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 313D6A5A49D
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 21:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 477017A27F8
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 20:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C7C1D7E3E;
	Mon, 10 Mar 2025 20:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VwGZ6Adn"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2071.outbound.protection.outlook.com [40.107.20.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775C9139E;
	Mon, 10 Mar 2025 20:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741637846; cv=fail; b=nWsooqUbaaKe6pqmt2gpvEpRZApI9p3dOPY6g1TRNVdoL/u2hJdOjHmkdVJaty7QAE+pNKBgJk0HGKtv2neI3C8GMZXD3V5b6V+Lbx5S4n15dJlHG1AiKXP02hJHWrSNURtHZQZbY4N9M2a9D7LTUpueWn/c4zL17D59B4JrtOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741637846; c=relaxed/simple;
	bh=rpjV8ib+BKGHKp/ind90+7pvN3dGLE63Xta+NCdFcT0=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=CQUgBUk2o1fr31U3MN4nZ29EtsmaeNjcUt3SYnXUC9/7RF0CBXzd0jwdZarp6gL9O0Vd8akcFI2rwzzBFr4oS2lmvVAbfB4xAUYbzgYQd9Jxc38c+GGR0J0ZzZ7v3t6I/m157OuwbM3eDxl2tyibiiu9zfyVx8M+/KK/btQxjWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VwGZ6Adn; arc=fail smtp.client-ip=40.107.20.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xTTCydPAyancnASEZAdX96zAVk3RW+iPkUyZkwFUnD2OLeSVDczsfvNBVNPjeW0PL4rXkgZb5JysnVVN8uSjPjms12PNdcQZ1MjFSw+fHR/DQzszUHHnRq+MHrgaUWFzECya+oEYHPdGxmTdgYu+xodHSV2q0Jr3aoSGY+IEfqJ3zQPJuMg4KOIQ682vdyvcWbiy99NvWhgTY47Xq0/NSQY/EGVpoDlc6TuE1SqBq6LvpBRGXwMCWw5/PbPV+ZTzLAOslj19BP1FtEj/fYundUXHTULW1gHwZ8E0EYqanv36sXF9mySiG4VFgeVRvqoj09ScXW8ytBbvZXthVkW37Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n4ZxVERpLvmkqGZ7PjYCz4nQIvKyVijJa/+tDJTgiIs=;
 b=vthuJ99dwJjFYR2Oj85TbxjFpr7yg460gD19ipPOBXpNTdyfFLlYh2nNasFzh8IDQvYnG0c2oeyPYEi8Hs0jg8apbkVnRGv65mj2oMUS9W/gDuXUVfpIFrl19nWkywOHy3B4S1EZjOij/86oSbvAVp8yYlAaOSKdTtJt0mrhAEnSiuNegiCB3LKCoFB4WPg8RXm7XkWlrp3qrt0aFahq+AI7A+hYo6KrkoiCFEvcsLgM+xT2bFgLzFY8KUqjHm5tEYMQcC0qkytWVHhDyBlK94WExWadsTZbnxK9SCka1acaMzd9HajXI+XIBgJuEoadO62xuQF/fqK/nU5hC/muKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n4ZxVERpLvmkqGZ7PjYCz4nQIvKyVijJa/+tDJTgiIs=;
 b=VwGZ6AdnPO6EJcVtCsesVb61xO6u2BGAfnf4Nvx/TQimAxdi13WdKv1orRjp8sNZq6W1T8dyFU8aJRuBQmwtaL5UvDc6gzH7uLA2f5CKEVkyFtX5GGI/g1XdJ32ir2VjcH/XZMifdXLGYZp3bc255yPdHUd5pC5GRrX8wSTUPAPDr29dR50FSSFbJ3u5W+UQOZc+QbjdwQUv4P3P0yaQ1ve5oVWH3Dk/WL6xNAJNiqrg/UsZJLEWoTLHUd3GbtgrNhu0bog1k3KNZwr3kxeVvjrDyWwvG9TiVU+eNviH5OJUfN10XW5bixIKqSdiPrMPRiFlBmkXQO3SO85o2c5KXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10682.eurprd04.prod.outlook.com (2603:10a6:150:214::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 20:17:19 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 20:17:19 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v10 00/10] PCI: Use device bus range info to cleanup RC
 Host/EP pci_fixup_addr()
Date: Mon, 10 Mar 2025 16:16:38 -0400
Message-Id: <20250310-pci_fixup_addr-v10-0-409dafc950d1@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKZIz2cC/3XQ207DMAwG4FeZck2Rk9g5cMV7IDQ1J5YL2qqFa
 mjqu5NOgrULXNrR99vOhU1xzHFiT4cLG+Ocp9x3peDwcGD+1HZvscmhNJgAgWAFNoPPx5TPn8O
 xDWFsWkPKJOuck8gKGsZYXq+JL6+lPuXpox+/rgNmvnb/jZp5Aw3pwLG1PHpMz915ePT9O1uDZ
 rHFqsKi4IgkkJDHkHCP5QZLqLAs2ECMGiSJ5PUe4y/mAKbCWLCgSAJAkXZ+j2mDOVWYCvYxECl
 vSGjYY7XBop6s1ptddD6YFDDdfZjeYlthvd4sOQQvMDl9t7a5Yc5rbNa10aWWuJXCmD22P5iA/
 7G2LVgW7QhUUopueFmWbyZt4LOTAgAA
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Jingoo Han <jingoohan1@gmail.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741637834; l=10919;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=rpjV8ib+BKGHKp/ind90+7pvN3dGLE63Xta+NCdFcT0=;
 b=op5b7GvUiifPIGi1CUkzaoEyibor57K9ogmlwrQvxpWavU1coiWPdKs3NfX5DO36nWR15FCVH
 5BJstYMCj12CRG0bHkOTcgn+EduAkxvivfY34Ea9ZOjLlwWRp1QWxYs
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR08CA0058.namprd08.prod.outlook.com
 (2603:10b6:a03:117::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB10682:EE_
X-MS-Office365-Filtering-Correlation-Id: 77604d17-9935-4f11-7b71-08dd60108f21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UkhLQWR4WUVwaFlDVGw3czZYMGhobTY5dDl5WmJwWkp6L09jRzdHV2N1QVJl?=
 =?utf-8?B?Z1dtTFVYYlVyaUxVdUdCdGRXK0lOOSs4S3FleHhNZFZ0WTRMOFJkeFduMnVj?=
 =?utf-8?B?a1NxTTVpV3lYQ0I5U1IvZ3FxczE3WlFhbDNPbDRyQUVGOUttdnpXaTQ5ZFIv?=
 =?utf-8?B?dnBKbkM1TE1nTUZsazB5TVlERzIxUVBaanVPTDNIN0NRZ1dIMGdINC91cVNV?=
 =?utf-8?B?ZWx0MVcwL2plOVg5YzcydDVkckJ0OVBsWll4cERzQlRTaWdKblBNN0IxQ2Jj?=
 =?utf-8?B?SmFESHJDK2I5cy9tNzY3ekppbkpHWG52TDNuTnM5MmlqT3g5V1lWTGZyQng0?=
 =?utf-8?B?U0E1dEtpcDRHNEp5L1ZZcy9XRjh3a3VldFZwOEhSVDh2SGlycWFRUlo2Q1Vl?=
 =?utf-8?B?U2c2YmRHem5zWGxCQlNJV0RWbzhYSjk5UnJmbEhMeUU1YkdxNUVaQjlReFBo?=
 =?utf-8?B?blBHeW9Fdm5LU2hJNUJyWDdHSEhxY3k1MGcwS01hL3RNbGI1MlUvci92cVVk?=
 =?utf-8?B?U1ZoMzNLVmJvQUFYdGxFZkxDNTU5UTFlU2lGSUVFM3hvT3dkbUIwM0hGVC9M?=
 =?utf-8?B?a0RMMUh1cHZxVDdFK0xVeFAzOHJ6NDZBdG5oS3V2dEsrZ1JJaUIxZXgyTnIw?=
 =?utf-8?B?aUhJVDQ5TzVwekdIbGMwNkViTy9kZHAzQ09CSUFwS3ZDRHRxVTdYeHBlWC9P?=
 =?utf-8?B?RFgvMkYyZmxvaDJsL3lib0NleDkrZ2xjR1JpTHZuNm4xTnZYUnViT08zaGg1?=
 =?utf-8?B?VmdBOGhxQTRVQlFDNVFheHh1THVxdnJDOEp0VzNWY3JPdUNrSkN2K0tsSFRK?=
 =?utf-8?B?N2Q5U2tsZEJPZXBLNFlSMTUvamhXWkFXVnhlU0E1THo0QXFqWVpKOFZKS29R?=
 =?utf-8?B?RUcwOTl2NDREcTJxK3ROUWFVN0VzdHVwT1VvMVpkRko0ZytPY0dWQ3BXaSts?=
 =?utf-8?B?d3dCYlJtM0t4eUQybmswb2RiWTdFUXduL2p5VTNxTmR6c1hwU2xaMk51RTN1?=
 =?utf-8?B?SGN4UDRIektUSnB5ZmZDVVF0M0t3WkNHRGl4U2NJa0o1eGZYU3Bjb2k5N29M?=
 =?utf-8?B?emo4Q2VxL1RrN3VKc2M0U2lRbU9qRmhKU3NjZjYwbHpUOTZjZlpObTJQQ1ll?=
 =?utf-8?B?RjlxMFcvZEUybDVxUVZlQVZiN24xMGNIZmJId2J6cGRKbGwxUzg4L0tXVFRw?=
 =?utf-8?B?UHo1VkVjL053SG4xMXRROHcvRzkwbkU0ZjFucmYwWld6cHlLZVF1QytmdTJr?=
 =?utf-8?B?WnFJMG1hRU9GQm1GSWd5WGNxWE92TzY4a0JRNjB1aUVDSEhsQnVVQnR1L25x?=
 =?utf-8?B?UWFaZEN4Vk5TN3UzUXhRLzBWMzI3RW9JN3RzdDdCcTB2QittdzlUYldjZW1X?=
 =?utf-8?B?RytvZENTa2hxOVdKeGoyV1ZyTmJCUHd3bmtMZTl2S0hWbVQvQm9PaC9wU29k?=
 =?utf-8?B?RjNBTlIxV0ZlR0hOMFkrQkUwWHhXa2laOGNSS21VNmJYckZZNHJXWWg2NGwv?=
 =?utf-8?B?R1dMNEFZVm0wSk90Y21JNzEwNkMzK1NXV1lBS2RLSWFmKzEyMUI4RzRndk5C?=
 =?utf-8?B?MFg1QlJXRUlheTd0NzFlU3VzQkdnSTRKWkoyeFZVSURDeHZjSjUwb2xXZ0Iz?=
 =?utf-8?B?NFZQSDNDZVlmd01aMEhESnhnTEViUG5KK1JMdFRKbzRhN1laaTl5U2tBTGhN?=
 =?utf-8?B?MndDUjZLTWN0KzE2ZVRjbkhuWVExR2xhdkZhTUFlSGN4TENIMDVISnZ4aEJv?=
 =?utf-8?B?WFNIUmhSekcyMmtBRE1vYVhxRktWdXBKLzRBV3N6S2VWbndkWDdBQ3VtWTNi?=
 =?utf-8?B?K09WM3Q2MmtUTnpsaUhydDArREM3YSt2aXBqY1Q4S2pkTW16bXh0dlEwUDJK?=
 =?utf-8?B?NW8zc2FpM0FNTHRWcE13NFpzdTFBM0M3YURRUGpMeEcvNGRsRjJoUTBKelgy?=
 =?utf-8?Q?KQJGFJa6uKE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mjc0cUU2QkRGdjJXSkV5ZDZYUFpLamxLK1JBSjNObCtKNjY2Unk2SVpWYitR?=
 =?utf-8?B?MjFZaDF4OXFsU3NCM3M3ZGJBNWZPM3pXV05DcWVnSENqemNWWUl0b0h4ZmZ6?=
 =?utf-8?B?OUFRWGg3N0cxTlJnK3ZpekVTazFrd0IxVmduVnVUUkNXdHp5YW5XZTdjNTlR?=
 =?utf-8?B?Y3g4anRNajlmM3BBWjdyV3lESlo4UDlzL0Zlc0FnMFZ1alp0S2pPTi8ySFcv?=
 =?utf-8?B?cDJvbFg5b2FST01YNG8yWnpmUVFXZm5FOCtuSG1RY3hyVVVpQnZ3S1NhSFJ6?=
 =?utf-8?B?empXNGplWHRaNy8yTnhoY2t6QktEdXlETEJYSWIra2VsTUFMaTh2YnlJY1pt?=
 =?utf-8?B?UUxHQzdQZjBNd3g4UnNnNURkZDVtTGJlUWRDbTF5R3FnRGlERjlrcVYvSGFa?=
 =?utf-8?B?U0xkcVcvMkorZzM5ODEvOWhlMzBZWWlOZjVYdDFTdzNWeHVGQ29zQ05ENXFL?=
 =?utf-8?B?SmF2cjRCSE03eHRrMmZFZzR6Mm9DSjVrZ2NYZzBpUmY3TWpTK2JKVXB6ZnJ0?=
 =?utf-8?B?R0NiNk56cG9Dd2FXWURaVUhZeDRtSFFFOEg4MGEvOWd2T1B2T3B6dnl1ZGRh?=
 =?utf-8?B?WVdZUE9NbnVQL25OWUxLVFJlaDUzSk05N1V0RVZRNUlGL3ZOV1M4QTBTcFhN?=
 =?utf-8?B?alNmNFhGTWF4QW5sWEt0UDY1Vk1aMmRaaGZNck4yM3crV2sra1VUVGQ2MWZx?=
 =?utf-8?B?b1VQLzlLMlQ1OFVEVW1mcysxT0E2bG9TeEI5ZGtxWmRBWVNJSVFMcDEvRjdB?=
 =?utf-8?B?ZDdQeE8zaGZMOWNEWHFQQU1kdnVFT2dZd3pBbXBRaEJycnNldGtnUkJ0MnFK?=
 =?utf-8?B?azRhMm95RTB4bmRoanVub2g3bW90Q2hLWUp6MGtuZno0M1llczZTTDBQajE0?=
 =?utf-8?B?YWhoejdQeVZvMmFiM0c2dG9PSWVBcmdGRmpmRW1jVzlORG9NMEdLNldyWi9z?=
 =?utf-8?B?eElLT25uK0NqVktqclJLNHE5R3FFNWxFV2gwRkkyNEo4NGlna1U2L1piNjVD?=
 =?utf-8?B?UHJmUW94dnFWeGp1aTR0NDVuTWRVSmhzVmpCd1M1bmlEMzkvMWVzOUFCdG0x?=
 =?utf-8?B?R0hNZEZYSFNZUy9qSm5JZHhLcVRKOUtsQnpkcHJVSTUvZmtTSGErSk00QmxE?=
 =?utf-8?B?R3dLVW5GOXMrdHBDYVRlclNjdGkrbzc1cjhBRDVtM1ZkOXVySGxsdzZRUjd0?=
 =?utf-8?B?VE5LOXJTUnU0NzEyS01NdEVCM3VZRHBNay82cjBZNmlibGpqeVY5VGtoUDcv?=
 =?utf-8?B?RklWdHU0TmFPU3oxdUpyMnkrOThHVE1KdW01Nm5ZNjUwNXFIVHpzSDE2b0o3?=
 =?utf-8?B?Q3B5VmQ3aGlsU2xxUFZKN3hMNHRLNmNJNm9wdmJXclFub1RDYklVVHdmZjNJ?=
 =?utf-8?B?UGM2b2dYUnVCbzlrKzUwT1E5bkFHYnF1bm1PeGVUV1k0K3FjWkdOYlF1VCtp?=
 =?utf-8?B?WVRsQmNEb0s0TnRGd1lubDAwMnU2NU45Q1FVWjgwUjgzRnFwK2hqRFVZWVRE?=
 =?utf-8?B?MTRKcGlOOGZVOGwvbGtqSHJ2V3pHUEVSUGkxVU5ReWhLdWl6dWh4enpMSVpI?=
 =?utf-8?B?VmxqVU1qUzFzQllxeCtibUlqTXcxMGdzbFM0MGJjQmRWY1pySnRGMm9BNWZx?=
 =?utf-8?B?R2ltR2plaVNjQ0xOaW1aK3V6ZUdXMEdxMXNqMEd6N3JmbVlHRFp0aUZTSWFz?=
 =?utf-8?B?SGxZUkwwa2FMYS85MFh4VVI0a1JtYzl5TVpNMHk2blF4UFExNjRHeklzQXRT?=
 =?utf-8?B?bmpZdGYvY2ZxZzdHbytJREowcWhaNmlVU3g5djBoZExQRDVBcklLSG1qTkov?=
 =?utf-8?B?SjZhb0xpaE1lZHFBdk5wdTJWQ1VBVjI1eURFTmlTNWk0UkxRS0hXOWtoRW12?=
 =?utf-8?B?eTdDUTRWWTlaQlFQUEZWWkNUUjg0VjNtbnBYVU5sa0o4bm80WlNuaklnNGlI?=
 =?utf-8?B?QnV5RlBlZE9PMDd0TUs3b2pzKzRmb2RnS1kyK1pHNVhSNFRjMFRTb1ZNUy81?=
 =?utf-8?B?c1AyK1hDUzFLS0hRRDFXSkx5Y3BhcjdvTFE5akVlNUFXYlFhNS9xazRFRm4r?=
 =?utf-8?B?KzkvQjNQcmZ4UWIrR1JQK3hnVzFWZXJ4MlVNc3dKcm9zZWNqd05DdCtRY204?=
 =?utf-8?Q?0k2s=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77604d17-9935-4f11-7b71-08dd60108f21
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 20:17:19.4960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yr1I3Q+s56GY0CE/TkSsf5JFRFcCPwK+NzdnbyBdw9wwcgBeOB+JgPjsUHmgMCQy2RjpDCNUJ2J7E1c9mIYsjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10682

== RC side:

            ┌─────────┐                    ┌────────────┐
 ┌─────┐    │         │ IA: 0x8ff8_0000    │            │
 │ CPU ├───►│   ┌────►├─────────────────┐  │ PCI        │
 └─────┘    │   │     │ IA: 0x8ff0_0000 │  │            │
  CPU Addr  │   │  ┌─►├─────────────┐   │  │ Controller │
0x7ff8_0000─┼───┘  │  │             │   │  │            │
            │      │  │             │   │  │            │   PCI Addr
0x7ff0_0000─┼──────┘  │             │   └──► IOSpace   ─┼────────────►
            │         │             │      │            │    0
0x7000_0000─┼────────►├─────────┐   │      │            │
            └─────────┘         │   └──────► CfgSpace  ─┼────────────►
             BUS Fabric         │          │            │    0
                                │          │            │
                                └──────────► MemSpace  ─┼────────────►
                        IA: 0x8000_0000    │            │  0x8000_0000
                                           └────────────┘

Current dwc implimemnt, pci_fixup_addr() call back is needed when bus
fabric convert cpu address before send to PCIe controller.

    bus@5f000000 {
            compatible = "simple-bus";
            #address-cells = <1>;
            #size-cells = <1>;
            ranges = <0x80000000 0x0 0x70000000 0x10000000>;

            pcie@5f010000 {
                    compatible = "fsl,imx8q-pcie";
                    reg = <0x5f010000 0x10000>, <0x8ff00000 0x80000>;
                    reg-names = "dbi", "config";
                    #address-cells = <3>;
                    #size-cells = <2>;
                    device_type = "pci";
                    bus-range = <0x00 0xff>;
                    ranges = <0x81000000 0 0x00000000 0x8ff80000 0 0x00010000>,
                             <0x82000000 0 0x80000000 0x80000000 0 0x0ff00000>;
            ...
            };
    };

Device tree already can descript all address translate. Some hardware
driver implement fixup function by mask some bits of cpu address. Last
pci-imx6.c are little bit better by fetch memory resource's offset to do
fixup.

static u64 imx_pcie_cpu_addr_fixup(struct dw_pcie *pcie, u64 cpu_addr)
{
	...
	entry = resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
	return cpu_addr - entry->offset;
}

But it is not good by using IORESOURCE_MEM to fix up io/cfg address map
although address translate is the same as IORESOURCE_MEM.

This patches to fetch untranslate range information for PCIe controller
(pcie@5f010000: ranges). So current config ATU without cpu_fixup_addr().

== EP side:

                   Endpoint
  ┌───────────────────────────────────────────────┐
  │                             pcie-ep@5f010000  │
  │                             ┌────────────────┐│
  │                             │   Endpoint     ││
  │                             │   PCIe         ││
  │                             │   Controller   ││
  │           bus@5f000000      │                ││
  │           ┌──────────┐      │                ││
  │           │          │ Outbound Transfer     ││
  │┌─────┐    │  Bus     ┼─────►│ ATU  ──────────┬┬─────►
  ││     │    │  Fabric  │Bus   │                ││PCI Addr
  ││ CPU ├───►│          │Addr  │                ││0xA000_0000
  ││     │CPU │          │0x8000_0000            ││
  │└─────┘Addr└──────────┘      │                ││
  │       0x7000_0000           └────────────────┘│
  └───────────────────────────────────────────────┘

bus@5f000000 {
        compatible = "simple-bus";
        ranges = <0x80000000 0x0 0x70000000 0x10000000>;

        pcie-ep@5f010000 {
                reg = <0x5f010000 0x00010000>,
                      <0x80000000 0x10000000>;
                reg-names = "dbi", "addr_space";
                ...                ^^^^
        };
        ...
};

Add `bus_addr_base` to configure the outbound window address for CPU write.
The BUS fabric generally passes the same address to the PCIe EP controller,
but some BUS fabrics convert the address before sending it to the PCIe EP
controller.

Above diagram, CPU write data to outbound windows address 0x7000_0000,
Bus fabric convert it to 0x8000_0000. ATU should use BUS address
0x8000_0000 as input address and convert to PCI address 0xA000_0000.

Previously, `cpu_addr_fixup()` was used to handle address conversion. Now,
the device tree provides this information.

The both pave the road to eliminate ugle cpu_fixup_addr() callback function.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v10:
- Remove patch PCI: Add parent_bus_offset to resource_entry because it
is detect by reg-names["config"] and reg-names["space_addr"];

- using Bjorn suggest method
https://lore.kernel.org/linux-pci/20250307233744.440476-1-helgaas@kernel.org/
- other detail change each patches's change log.
- PCI: dwc: Move cfg0 setup to dw_pcie_cfg0_setup() is not necessary, but
nice clean up, so keep it.

- Still keep use_parent_dt_ranges in case some platform without cpu_addr_fixup,
which use fake address transation at DTB. If no one report warning for
sometime, we can remove it safely. Bjoin, if you think this case is rare,
you can remove it.

- Link to v9: https://lore.kernel.org/r/20250128-pci_fixup_addr-v9-0-3c4bb506f665@nxp.com

Changes in v9:
- There are some change in patches, if need drop review-tags, let me known.
- DTS part: https://lore.kernel.org/imx/20250128211559.1582598-2-Frank.Li@nxp.com/T/#u
- Keep "use_parent_dt_ranges" flags because need below combine logic

cpu_addr_fixup  use_parent_dt_ranges
NULL		X			No difference.
!NULL		true			Use device tree parent_address informaion [1]
!NULL		false			Keep use lagency method	[2]

Generally DTS is in different maintainer tree. It need two steps to cleanup
cpu_address_fixup() to avoid function block.
1. Update dts, which reflect the correct bus fabric behavior.
2. set "use_parent_dt_ranges" to true, then remove "cpu_address_fixup()" callback
in platform driver.

Bjorn's comments in https://lore.kernel.org/imx/20250123190900.GA650360@bhelgaas/

> After all cpu_address_fixup() removed, we can remove use_parent_dt_ranges
> in one clean up patches.
>
>
  ...
>  dw_pcie_rd_other_conf
>  dw_pcie_wr_other_conf
>    dw_pcie_prog_outbound_atu() only called if pp->cfg0_io_shared,
>    after an ECAM map via dw_pcie_other_conf_map_bus() and subsequent
>    successful access; atu.cpu_addr came from pp->io_base, set by
>    dw_pcie_host_init() from pci_pio_to_address(), which I'm pretty
>    sure returns a CPU address.

io_base is parent_bus_address

>    So this still looks wrong to me.  In addition, I think doing the
>    ATU setup in *_map() and restore in *rd/wr_other_conf() is ugly
>    and looks unreliable.

....

>  dw_pcie_pme_turn_off
>    atu.cpu_addr came from pp.msg_res, set by
>    dw_pcie_host_request_msg_tlp_res() to a CPU address at the end of
>    the first MMIO bridge window.  This one also looks wrong to me.

Fixed at this version.

- Link to v8: https://lore.kernel.org/r/20241119-pci_fixup_addr-v8-0-c4bfa5193288@nxp.com

Changes in v8:
- Add mani's review tages
- use rename use_dt_ranges to use_parent_dt_ranges
- Add dev_warn_once to reminder to fix their dt file and remove
cpu_fixup_addr() callback.
- rename dw_pcie_get_untranslate_addr() to dw_pcie_get_parent_addr()
- Link to v7: https://lore.kernel.org/r/20241029-pci_fixup_addr-v7-0-8310dc24fb7c@nxp.com

Changes in v7:
- fix
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410291546.kvgEWJv7-lkp@intel.com/
- Link to v6: https://lore.kernel.org/r/20241028-pci_fixup_addr-v6-0-ebebcd8fd4ff@nxp.com

Changes in v6:
- merge RC and EP to one thread!
- Link to v5: https://lore.kernel.org/r/20241015-pci_fixup_addr-v5-0-ced556c85270@nxp.com

Changes in v5:
- update address order in diagram patches.
- remove confused 0x5f00_0000 range
- update patch1's commit message.
- Link to v4: https://lore.kernel.org/r/20241008-pci_fixup_addr-v4-0-25e5200657bc@nxp.com

Changes in v4:
- Improve commit message by add driver source code path.
- Link to v3: https://lore.kernel.org/r/20240930-pci_fixup_addr-v3-0-80ee70352fc7@nxp.com

Changes in v3:
- see each patch
- Link to v2: https://lore.kernel.org/r/20240926-pci_fixup_addr-v2-0-e4524541edf4@nxp.com

Changes in v2:
- see each patch
- Link to v1: https://lore.kernel.org/r/20240924-pci_fixup_addr-v1-0-57d14a91ec4f@nxp.com

---
Bjorn Helgaas (3):
      PCI: dwc: Move cfg0 setup to dw_pcie_cfg0_setup()
      PCI: dwc: Add helper dw_pcie_init_parent_bus_offset()
      PCI: dwc: Use parent_bus_offset

Frank Li (7):
      PCI: dwc: Use resource start as iomap() input in dw_pcie_pme_turn_off()
      PCI: dwc: Rename cpu_addr to parent_bus_addr for ATU configuration
      PCI: dwc: Use devicetree 'ranges' property to get rid of cpu_addr_fixup() callback
      PCI: dwc: ep: Add parent_bus_addr for outbound window
      PCI: dwc: Print warning message when cpu_addr_fixup() exists
      PCI: dwc: ep: Ensure proper iteration over outbound map windows
      PCI: imx6: Remove cpu_addr_fixup()

 drivers/pci/controller/dwc/pci-imx6.c             | 18 +----
 drivers/pci/controller/dwc/pcie-designware-ep.c   | 21 ++++--
 drivers/pci/controller/dwc/pcie-designware-host.c | 63 +++++++++++------
 drivers/pci/controller/dwc/pcie-designware.c      | 84 ++++++++++++++++++-----
 drivers/pci/controller/dwc/pcie-designware.h      | 20 +++++-
 5 files changed, 140 insertions(+), 66 deletions(-)
---
base-commit: 5fcc194143ce5918ea0790a16323a844c5ab9499
change-id: 20240924-pci_fixup_addr-a8568f9bbb34

Best regards,
---
Frank Li <Frank.Li@nxp.com>


