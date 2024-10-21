Return-Path: <linux-pci+bounces-14954-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 230D49A9098
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2024 22:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5E76287AF6
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2024 20:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3728F1DE8A8;
	Mon, 21 Oct 2024 20:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="M8IB0YX8"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2074.outbound.protection.outlook.com [40.107.21.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067991DEFD8;
	Mon, 21 Oct 2024 20:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729541276; cv=fail; b=TD+scf17KRRUSHzs/JVmoO0Q5IfNvd8Qh+VXqxSc0Eh0aj7UM4rkHW5DhIbvtImRSuMcRMDm/gjBMVgCqYmvTIYtzfN3bphadTezCvxEuNGswOW9L2Q2LTybIzLBnE2Vc+F1/mhZoesNIXOH739QzzdPjE5K1fuz0ggL8Va7aPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729541276; c=relaxed/simple;
	bh=z/qjOkp5hDUbKkPREBnGFcyAmTYIDRDWM3qKhQ4IVc8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=EK31jCZroe8PEcZ8x5DU3/UvZliDOlL9KxQqSMwJb2HHDA5m2NGNi+N9bqizdNVfh9GkzDr2HZ1/31uWhyAmJvTz//8PYGJMXRLjknTp9HV1/qhSiRQ8awlsYhChnLn3a+xEau17NILWjXy5Zabf2cdghtSojEVDm7gtbO3cR1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=M8IB0YX8; arc=fail smtp.client-ip=40.107.21.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KfWAs6+M+oErTg3vqx92HCqpnf2hhuk0qF13zMI7UEdQV/e8t9zK5K46jLOVgu/GPM/fxu9B1tRFOThq2Sww/2xsbnXUErPeK71ksV2xy7SOtw+7rcHhb1Butlj1hEITIojy1b/d0sAXcaNZZo3tPXHG3As0LtGjp5hN74PUq4fQI200wRgoHu2BzfL1u73/HQeS6+XopbPxScaL7FGSiavZ899eMls+Eio3zM7dsSdTmF5HwmIDnf59JMmX/e6C+vtbwVA7rWZX4JcV5GcVSzxp0893oHalnepM015gZfDJJNO8A5Qc2EvJR6O78IT1lOrMgeXAH/tpKIWwbAw1YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Bk7q8jaB5ypFH4kg7DtQLBpo4spagjA9PptU/sPGm0=;
 b=TvEfiZwoLCMPaAE8WpUc2VZK2NHiM7eOW+p2SZf1kTbW/hVN6zJQVPW4/KtEJjU7iu1S6B2QPQhsudY/NYcQ98WKBqo2xuwjQKeXPQtFDAbcLpq6PnOdmuqGzDGGDyrJtrahZrrtWazBE3NVuzynFSFHSdo9cTmLTcZ6efOsI7Mtts55KhM9WYBKCt0vw5K0WPlqJAdJJLFdtzbDGXfDgINQU/CJKSPTitDyWK11iJx/hup/sNSa4TRjM37oZAHIWkCdbso5YDEZjFoRZQ9TS4Z6ckhdpO6D2lFqp/RS5A7g7VzLqtQs6pxQBs0MOsV3NofkqsUt3IkMEv0c6fQcow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Bk7q8jaB5ypFH4kg7DtQLBpo4spagjA9PptU/sPGm0=;
 b=M8IB0YX8v1nQuoBFCe1mAPduB5iEXeRIq60fESldaO9hLUmyBKIFcqHyY6FNtMUHzX7rCh+J5R3ZQJoyyH62p5RUlAe16Jru1noGJrizpPNGHFlZfYRi151iKnf5dz8QXasmNJUsx6hNF4YsNhRtOsr5PpyetMDas+0QC3zh0G4qyDwzMXV6cSnNWZzMRR+qUEmB+JvL/vmQvYqEO5SGUBfA4/ccmVS1tOvbS3Ji3vIRkVTAT1TpCk+qPs3N60U/3CfLNUSuwoH5OGHelmv30u8BVjpQB2EasGSaihh2r+1sGkkQu95RjbDaKuVSXbbNl8QhECBa1USX8Any1BuQtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM0PR04MB6882.eurprd04.prod.outlook.com (2603:10a6:208:184::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 20:07:52 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.024; Mon, 21 Oct 2024
 20:07:52 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 21 Oct 2024 16:07:36 -0400
Subject: [PATCH v3 1/4] PCI: dwc: ep: Add bus_addr_base for outbound window
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241021-pcie_ep_range-v3-1-b13526eb0089@nxp.com>
References: <20241021-pcie_ep_range-v3-0-b13526eb0089@nxp.com>
In-Reply-To: <20241021-pcie_ep_range-v3-0-b13526eb0089@nxp.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Abraham I <kishon@kernel.org>, 
 Saravana Kannan <saravanak@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
 Jesper Nilsson <jesper.nilsson@axis.com>, 
 Richard Zhu <hongxing.zhu@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@axis.com, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729541264; l=6071;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=z/qjOkp5hDUbKkPREBnGFcyAmTYIDRDWM3qKhQ4IVc8=;
 b=NB9QyP5FD+su171LzohM4TyXh/YDwW3sB1H/1vi82nQ6RRL5v8bUUFioIfVQ1pFn4ddhsOtSz
 uWCtPSYEejgDd/4ZJ7AQc0V9raeQ+4gaBmkL5dSA5Xd1GmrWNQJLxdy
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA9PR13CA0071.namprd13.prod.outlook.com
 (2603:10b6:806:23::16) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM0PR04MB6882:EE_
X-MS-Office365-Filtering-Correlation-Id: b262bce4-4927-4c3d-2e68-08dcf20c0b19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QllIUXg5MG9KRmh6TnZHanZ2VTdHMG1NWDNZREZockJqdGVWRmtjTGJqWE93?=
 =?utf-8?B?U2JNMjV3VmJHYW1DTUhsa3pENmZaWnc4M25SZFkvTEdEd1VSV3pKQ01ZZll2?=
 =?utf-8?B?eGFydkJtcFdkaS9iYkF3V09oQzZGOVc1MDZUQVc0WnpCVGY4Z0lqUFJrYmlG?=
 =?utf-8?B?ZUVYdEphQ25ZZjJIa1ZjRXp0ME02Rm5pRG5KTVlScjVjNm9NM01rUUdtQ3pr?=
 =?utf-8?B?THVodE9HRkIyVjdlRkc3dGhSNUxOUk9WTEJzWnljeGxmQWhIVngzdHVnSldE?=
 =?utf-8?B?NW5WREhnQTc5eE9yY0wzZ0t4bjI5aTZQUlpnRlJsNVhDK3U4RGoxblhuRXZp?=
 =?utf-8?B?VXZLWHYrVktwU3R2dUEyUEcza2hBRDh6M0xKSHdZVS9aQ2xRcHczL05tQzVB?=
 =?utf-8?B?R0dJcXhMcStjcENLZmFUdGs2NFQ3YWxUUnBXenlBeVZOdEM5YlYwUnJ0ai9s?=
 =?utf-8?B?QzkybkhhQ3J1cjIvUXlBSXEzQ2R0L3JUQkNmMFh2ZC9zY2pJeVdXOEY0dVd5?=
 =?utf-8?B?TjhyMk4za2ZEUnZ0ZEhMZ3ZJUzhOT2xJeU9ZRUxKQmZ1cCtUdGt1WnRwNVhL?=
 =?utf-8?B?UWRTSzBrWWV1WWlveEhnWGNRaklCZ3hUWC9hb2RCUURLSzVKMGFMMGhwdHQv?=
 =?utf-8?B?NTlnbC9JY3ZlUi8xaU9wTnExdytQenVXV2lVL2V3d3VvYWRWS2hSbmdlb1Fp?=
 =?utf-8?B?ZWtXT2ZRdVIrVzI3WWJHMlZaNVluTXFJVm1vR3pkL1grNzVwRVFjZTR0YWd2?=
 =?utf-8?B?ZDBhTUNROEp6eUtBK1JwUGdaSktNWDJxZUtkRjFualhTRzJSdElzamhXQXRo?=
 =?utf-8?B?RG1tNjA4TUxjYWJTUzZHakFzWnhFRWlXOHVra0RObGdjOGdOL1lnNWdNZE5N?=
 =?utf-8?B?TXJ6S2dhY3ZCMDhKbjJBWnV0UTJpUU5DblhYUi94U09jbkRyd3VIY3pvWlFG?=
 =?utf-8?B?U1htdjVJbms0ekMvQThuNkJ4NXdjZ2lrV2xOa3VlNENYM3A3dTEwWnNEMjRT?=
 =?utf-8?B?bTI1SSsvdzJZWm8zdEt4Q2FuV0hRSlNvY0NhT1FqZ3B6Q2JpYVN2UFE2K1pB?=
 =?utf-8?B?eldZK05HRFJnRWgrdVl0QTBRd2d1c2k5VHpNMnNkamF5NmV3V0ZRUG9hclln?=
 =?utf-8?B?TTdVcFd2dDJzNXRnUnRmOURPc3ZkbHVFcjlaUS91Z0UwYkZaZ0VVOVBGaXA4?=
 =?utf-8?B?TTVpeHhKRnJqWmJpeHFsYkxoSC9hVmQxaFNBc2MwZXF2MFdiT0orZWliL3h2?=
 =?utf-8?B?WTB2NWVSQlhwWHo5VUovQnBMbGRzL3BzOW83NUlXd2pScGxzQVlUMEpLSDNx?=
 =?utf-8?B?NXl4cEpwbi9DQ1pPd3llK2Zmdis1T0dtUEFGb1dRYldFRml3QzlkTjhaVlpy?=
 =?utf-8?B?NEN6SnlXZ2N0Uk1mamhhTnFXMGU1TXlyU05Zb0lxZ01LYTd1VEdURG5COUdX?=
 =?utf-8?B?YU80dmtQNHA0aUtQbTgvT2Rxbm8yWjZRZ1ZWblVtb3grZEhyRlRpQVlrc1Bw?=
 =?utf-8?B?YmkrcXZyTWR3T00vbHZIdVN2KzRPRW9hVEYwNm42RTlOdXpLdVZBNXRUNG9h?=
 =?utf-8?B?QmkxNW1wQjY3dmxweHpKNUdMS0FaQ1pHSjN5aHFRYTE3bzM0ekdWOE1tQmpU?=
 =?utf-8?B?YWhhOVFBRXVVdWNob0drRENUUmJzY2FmVjFKdjdwTlRnZ091VXptOXdlN0Jt?=
 =?utf-8?B?RlpqQzV3dWk2RXRzREFoaEpmalNGMGFpb3ZkaTFFMFlqMFNKVVZDQmoraVVR?=
 =?utf-8?B?QVMwcWJvL0YrUjZxVmpzZDJyZ0FvZkJDKy9iSGhkMXhDdUVhT0VQc2k1TVNw?=
 =?utf-8?B?cHBzQ2Z1N1lrdWdiL3BmREtaVjRoRTFWb2FyNjBDZVQ2ek1YSUdwQzFNY0Fs?=
 =?utf-8?Q?4Dkz+xlcD2rYq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T3JXTWVXSEtpbGJPdmkxRFVkN0c1MHQ3TzZBeFJCLzV2Znk4enVSbkpMNjNB?=
 =?utf-8?B?LzZaeGtIUzRUQ3RIMGwvUlYraVFCL3ZlWmtlTHFaTkE3Zk5CMWZXbDRSRzhZ?=
 =?utf-8?B?Um5DbHIvaldVRHU2aCtNQWlhZSs1YldaZGFwTFFDbld5bnRzbnQ5UUxkZmZU?=
 =?utf-8?B?QVNxV0h6YVF6Q1U1TDY2dzcxaXRTS3FrM3I1RXNxTXZzSyt3ZFNHNDhOWVVz?=
 =?utf-8?B?YWxIQ1dGNTArbzRBOUVJUzNGYVFObzkwVEtCRnFpaUtXMEUwMmp5dlJnYmxR?=
 =?utf-8?B?aUhNYzU1WExZRWFtN0c1OXdRaERhL1NBY244SXBUdWNtWDRZYVJTSHVBVXRP?=
 =?utf-8?B?ckFTd0ZmWllPSStPL21XWDgwZkM1MEpSUi9mQTM3ekxRb0RFL01uOFk5WXpS?=
 =?utf-8?B?cDJaV1RJVnRTSW15bFBJOEN1TDYvQmpTckhCcEhSWE54Z2tMdEc1YWdrRXpq?=
 =?utf-8?B?Sy85Q3BWV1grSmVEQXErUjFmR0ZJeDFKb29EVm9DVmU2dGhSUUJobXFrM1Bi?=
 =?utf-8?B?UXgzRlE4aXptQlU4UVR4bDBBamdJQWtCM01XdFVPYktiM3FrOHpJTU9Dd2sr?=
 =?utf-8?B?R25HZjlHL0tpVjdDcGJsNG9oTW1IS0VoM0JWSjhnZ3dZOHBoK0pQN3NrcHY2?=
 =?utf-8?B?YS9UNFAxNkE1aHpyN25Vb1hqQXhocm8yRjE1eHlyRVdDT1ZrN2kyV2Z5amV5?=
 =?utf-8?B?M3BLRk8zVlhwSGFLOHNDWWZieUo5L1FRbjdCbmppcU9xSS91RG15Si8vMHRy?=
 =?utf-8?B?cERlMVZ2RUtLVDNpSDNCdzdxUWttUW1QNEpwUFNWdmdHL0ZMK1hpS1NJZVRZ?=
 =?utf-8?B?MVB5NVNpdzdEeHcrOEl3TDJnQkx4YXlBUG9KUVRwT3lVSGlxUUtMMVVzSFp5?=
 =?utf-8?B?SDR0TkwrdFdIN2Q1bG5Od3dsYmUramJQSTBNaVlFTldzcnZub2RaM1JMZ0FW?=
 =?utf-8?B?R05XRVVRYmxqTlkzd1NYQmp4QXBtVW9LL0ZnYjB2U0srTjQzQy93REgvVExM?=
 =?utf-8?B?QTVFbVZMVjZmdC9CYWVmcGdxUFE5M2VjTmpramdKQ3pZMHA3bm5PTUF6Y21N?=
 =?utf-8?B?eDYwWHZhaGtVNS9nM29GQ2FuYjVTQ1k5aGMvTFFjbXlERDA1d1U0bkMxSm85?=
 =?utf-8?B?U1FmMHRXdi9WME5LSFNYYnNCT1pYY0xISHh5cmJMazdDWXRDVzRFbDl4dFNj?=
 =?utf-8?B?U01sNVRiQndlMVcrUVNCVUsvNzk5UER1UGxhU09FUkw1UXY2YjFONVhVeU42?=
 =?utf-8?B?ZWdqL0kzR1Vod2lvQnNMbmdJM2pXZUxhUVVtTXMxT0lBQW01MXNTMHpFVDRk?=
 =?utf-8?B?YTIxOVk2eXZweGp2aEpjV0t3MXNQb3N1THlOWmlHRXdqOHkzMUUya0oxUGR6?=
 =?utf-8?B?d05KcVd4VEFzRG5yOXV5Z0lKRkh5U2pTZkQ2UkhBOFU2Rjlib1ZPZ2JJcGxE?=
 =?utf-8?B?ZSsrWnlqYTRVTmxTZVZpMkUySGJ4Zk1ST1MxdFpucndGTzJJeVU4ZE9udlpq?=
 =?utf-8?B?ZHpjZnAvUHhWbkhzZEpoTklpU0tlOVpVOU9wQnozV1J4SWR3V0NxcTFvT2dv?=
 =?utf-8?B?UnBMQTV1di8vRWdIM1hiMndIQ1RvRWN3NG1zSU44TzJ2QTMyZU9DaEJGaG5t?=
 =?utf-8?B?QWxjVjZmd1A0b2s0Sm10bmIxYUhJKzFydWU5TGIrOWhOOXV3S2VRbEg4eVpC?=
 =?utf-8?B?OWV6ejc5UENRNVBtclBpVjVxM0RmY3hjV3JZcmc2UWo3THNmUy9iYnNHSHl3?=
 =?utf-8?B?T0FpUHUzcDR4RFkrcGo2aTNxL2NRd2ZXVmVSWkNCcEJRUXJzL09QMk9Qem9S?=
 =?utf-8?B?bVM5eEdRSnZ3RUdoODBHdVFUaFNERHNXV2w0dk1UK2ZQQVFGMWxzSmdyV2k3?=
 =?utf-8?B?RmhmVFkzUGt0RkQyRmVhaTVJSExGTmxFWEJqL3g1R1cvT3EzNzRDSk1yQWY5?=
 =?utf-8?B?VU1odHg4R2k3VEE4R21oK1ZvTnR5V0Zwai8ybHhVVTVtQ1RyR3oxYTNJc0RW?=
 =?utf-8?B?aERJQTZKMHBOQy9NR0NCWEsxdUFTdTV6Tm5kV0J4R1ZMblVmc2RiaEExYjN2?=
 =?utf-8?B?Y3A3ZVBLejM2UlB6MVlCT0tZR2hGQ2FNMkdYSStaODJaMmY1QUt3dE1TVXIy?=
 =?utf-8?Q?jEn4KbtN0FfHb2mACO/gRkJ23?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b262bce4-4927-4c3d-2e68-08dcf20c0b19
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 20:07:52.0156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cnibLKj8M7lRn/IX/PC/LWtI0rA07Zzpj/XcP5AnQDxHvmhsCtZ9R/HY/wbHn0P52hToJb+DhEV5+LoHHpjRBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6882

                               Endpoint          Root complex
                             ┌───────┐        ┌─────────┐
               ┌─────┐       │ EP    │        │         │      ┌─────┐
               │     │       │ Ctrl  │        │         │      │ CPU │
               │ DDR │       │       │        │ ┌────┐  │      └──┬──┘
               │     │◄──────┼─ATU ◄─┼────────┼─┤BarN│◄─┼─────────┘
               │     │       │       │        │ └────┘  │ Outbound Transfer
               └─────┘       │       │        │         │
                             │       │        │         │
                             │       │        │         │
                             │       │        │         │ Inbound Transfer
                             │       │        │         │      ┌──▼──┐
              ┌───────┐      │       │        │ ┌───────┼─────►│DDR  │
              │       │ outbound Transfer*    │ │       │      └─────┘
   ┌─────┐    │ Bus   ┼─────►│ ATU  ─┬────────┼─┘       │
   │     │    │ Fabric│Bus   │       │ PCI Addr         │
   │ CPU ├───►│       │Addr  │       │ 0xA000_0000      │
   │     │CPU │       │0x8000_0000   │        │         │
   └─────┘Addr└───────┘      │       │        │         │
          0x7000_0000        └───────┘        └─────────┘

Add `bus_addr_base` to configure the outbound window address for CPU write.
The bus fabric generally passes the same address to the PCIe EP controller,
but some bus fabrics convert the address before sending it to the PCIe EP
controller.

Above diagram, CPU write data to outbound windows address 0x7000_0000,
Bus fabric convert it to 0x8000_0000. ATU should use bus address
0x8000_0000 as input address and convert to PCI address 0xA000_0000.

Previously, `cpu_addr_fixup()` was used to handle address conversion. Now,
the device tree provides this information, preferring a common method.

bus@5f000000 {
	compatible = "simple-bus";
	ranges = <0x80000000 0x0 0x70000000 0x10000000>;

	pcie-ep@5f010000 {
		reg = <0x5f010000 0x00010000>,
		      <0x80000000 0x10000000>;
		reg-names = "dbi", "addr_space";
		...
	};
	...
};

'ranges' in bus@5f000000 descript how address convert from CPU address
to bus address.

Use `of_property_read_reg()` to obtain the bus address and set it to the
ATU correctly, eliminating the need for vendor-specific cpu_addr_fixup().

Add 'using_dtbus_info' to indicate device tree reflect correctly bus
address translation in case break compatibility.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v2 to v3
- Add using_dtbus_info to control if use device tree bus ranges
information.
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 14 +++++++++++++-
 drivers/pci/controller/dwc/pcie-designware.h    |  9 +++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 43ba5c6738df1..81b4057befa62 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -9,6 +9,7 @@
 #include <linux/align.h>
 #include <linux/bitfield.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/platform_device.h>
 
 #include "pcie-designware.h"
@@ -294,7 +295,7 @@ static int dw_pcie_ep_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 
 	atu.func_no = func_no;
 	atu.type = PCIE_ATU_TYPE_MEM;
-	atu.cpu_addr = addr;
+	atu.cpu_addr = addr - ep->phys_base + ep->bus_addr_base;
 	atu.pci_addr = pci_addr;
 	atu.size = size;
 	ret = dw_pcie_ep_outbound_atu(ep, &atu);
@@ -861,6 +862,7 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	struct device *dev = pci->dev;
 	struct platform_device *pdev = to_platform_device(dev);
 	struct device_node *np = dev->of_node;
+	int index;
 
 	INIT_LIST_HEAD(&ep->func_list);
 
@@ -873,6 +875,16 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 		return -EINVAL;
 
 	ep->phys_base = res->start;
+	ep->bus_addr_base = ep->phys_base;
+
+	if (pci->using_dtbus_info) {
+		index = of_property_match_string(np, "reg-names", "addr_space");
+		if (index < 0)
+			return -EINVAL;
+
+		of_property_read_reg(np, index, &ep->bus_addr_base, NULL);
+	}
+
 	ep->addr_size = resource_size(res);
 
 	if (ep->ops->pre_init)
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 347ab74ac35aa..e22d32b5a5f19 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -410,6 +410,7 @@ struct dw_pcie_ep {
 	struct list_head	func_list;
 	const struct dw_pcie_ep_ops *ops;
 	phys_addr_t		phys_base;
+	phys_addr_t		bus_addr_base;
 	size_t			addr_size;
 	size_t			page_size;
 	u8			bar_to_atu[PCI_STD_NUM_BARS];
@@ -463,6 +464,14 @@ struct dw_pcie {
 	struct reset_control_bulk_data	core_rsts[DW_PCIE_NUM_CORE_RSTS];
 	struct gpio_desc		*pe_rst;
 	bool			suspended;
+	/*
+	 * Use device tree 'ranges' property of bus node instead using
+	 * cpu_addr_fixup(). Some old platform dts 'ranges' in bus node may not
+	 * reflect real hardware's behavior. In case break these platform back
+	 * compatibility, add below flags. Set it true if dts already correct
+	 * indicate bus fabric address convert.
+	 */
+	bool			using_dtbus_info;
 };
 
 #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)

-- 
2.34.1


