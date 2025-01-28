Return-Path: <linux-pci+bounces-20510-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAAB9A213F3
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 23:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB9583A7454
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 22:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBD61F561F;
	Tue, 28 Jan 2025 22:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gzBJfiNb"
X-Original-To: linux-pci@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013070.outbound.protection.outlook.com [40.107.159.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE29A1F4290;
	Tue, 28 Jan 2025 22:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738102137; cv=fail; b=p/QuWfuKu2Dc5an8TJQGHK01f/B/HO6Ow3+mVaNTFWeJP+I3IxcelBYRAWbjw/HJ+QpbdGzXtl61k6rNUUQ8xV99z0OArz/OwzWWRnN2jesq4u9xmGh72DhqjTG+rkJrxVVawPGLqaeX91UOgs7Mf2bzNsfYSWtuZl6mezY9epk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738102137; c=relaxed/simple;
	bh=Qtxc1V3k3e4Ca0xXnwE31Cml7yIQ9kLsWImFVASGIz8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=POa/MiygVhg3sKjr2//eZPC9RlT9KyOW4bYraPBIJhBIq2xrqke3I7XCIXZeW4DvZ68Q7K+XV2FpNESQBGM/l+qjncPetR66/xsxPL5uCGE68rgnXl93rfq6Dbzv9hCnJH9kRHUb2wdaBOyzKKYkNSe2g7Cs/oZwA2MF6PM8ogQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gzBJfiNb; arc=fail smtp.client-ip=40.107.159.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jk4wcmcOF24mbHrxyVVZvtWMXJywxSQ5vOAbr1QVdiM1MGZd6RvM7DQnBBOmVHopReJ9CDDBdDWmL5IJmNoci9s9XqVMqjG5yG2V+/g72rybUk+mzMi+XYV3Epe/OKwfA8PvOn6zzv9KQ/g9UATwP+UH4he9BMVj/CMAuQEr1B7OSWPW5VNr+2GFJtzYjaUMGz1D3WZ85DykGzXcxmTzyDwE/xRBgqPxIIPKHqp8eL0WTvVT/oAGFxv0ImK8pbAoiFxilKeUU71/bYCqQ+9ipNpgxwJ9BbQoWXq1AbUYojiVEmVushEymkKY0Am/i+oWAlWjvCMn3+uxq7mt7iGnWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ek6Zk7JGxc1j9p1VFdmOCv0GNNKfJXOaWInK2IQR9mk=;
 b=Bnyk+O42fTJNrXUKBkwOWXo2B7aln2pqo67E+LtXvsPL5totD7cV7kb0YIEcL5vv8RcH58sfS3Z6ZmtdTGIsg+6f/KVjFmSD7ziJDP1IuIH6rHpILf3QosgG99JQxvz8aNY+QcpRmnsxZUZ2OgSuNbaxsEwO2WPNF7rVNZRhM6IdfcEV0nApOj94DlNFzIWB/ZHLPZvuyaNOp28L8p6roY/viEea63/r/43hgx1hHkn8dLTDiM9olDaRDLG8h1xwgYDvIrvfvRNbLcyipyeUeAUWuApr0f3HuCR2IFEQ1m/j9bW7SwncDyBLGvuO35vMiSkTcyK7mtV9dgjacgC9Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ek6Zk7JGxc1j9p1VFdmOCv0GNNKfJXOaWInK2IQR9mk=;
 b=gzBJfiNb6AjdFo3Fky/3iLPmhyG66Gy3KBtoSt0veva78GnmSEvp5SOA0uC5Upwl4L95PeK1NY+WjUCqByvHgOYh6ErRNqKE+vW2qksw/9WkBe6/4jfWBLEqVTSyVOVJXKzXq8hkG79zMIXMNNvPoqVUyOf8rSjJgYNg2pNwlLRcJUuMlxshrnsOsWmDpIez91E3eIaX203aZm1MOjn1iROKLhdXAmmoSggxxwESqbo9l8AANh9k54FOCz4VyspKXAs/Pwyr8bjEq94W9shsdl+DvD6vVYH3keQD+5rs6X7hulOBWnggSgABSIZeE1xb3wJOwentl08e/RNjVmuSRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8555.eurprd04.prod.outlook.com (2603:10a6:20b:436::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Tue, 28 Jan
 2025 22:08:53 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8377.021; Tue, 28 Jan 2025
 22:08:53 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 28 Jan 2025 17:07:39 -0500
Subject: [PATCH v9 6/7] PCI: dwc: ep: Ensure proper iteration over outbound
 map windows
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-pci_fixup_addr-v9-6-3c4bb506f665@nxp.com>
References: <20250128-pci_fixup_addr-v9-0-3c4bb506f665@nxp.com>
In-Reply-To: <20250128-pci_fixup_addr-v9-0-3c4bb506f665@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738102099; l=1409;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Qtxc1V3k3e4Ca0xXnwE31Cml7yIQ9kLsWImFVASGIz8=;
 b=+mo5CH4A9gHYSrjIhSwt736ICapBVWSaLCW2H79VxFDRUagnRrLXvlZSZz6/eEB4Ts01iGG9s
 U7b11XwKC80By5EkByk7JMrO7si2GhOcWPbnG2kesE5Ktd5xAoa3zbf
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0130.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::15) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8555:EE_
X-MS-Office365-Filtering-Correlation-Id: e8a294f6-7ee1-4bda-9168-08dd3fe859fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NFNhalhvTmNnOFRPdis0cklTNWM5ZXE1c2Z5SGl4NmVSK1Jxb2w4YlEzVW5R?=
 =?utf-8?B?TnJWMlV6Sk9PdjFtdlpNdmdIMmQ2QXBtSjllY3dlYzVjeGRORkhZdWdlY0w5?=
 =?utf-8?B?Zk16eUhIdGVzaTNHVXUvUzVnYU8rMjV4OXgwZVV5N1hZZXJHMk1PRVJ1K1Fj?=
 =?utf-8?B?NTUvNVRIVVZwZzNJNEE5SjNCNXFzalB2Ykx0ZGxQN2htckxOcVBKSkd0bktN?=
 =?utf-8?B?OUVoMTMvbTFwRTVBeno1WEk2TlZqOEtteTRMOEtkMEpOeUxxbHNDc0pQV3Ex?=
 =?utf-8?B?ZXI0QWNpN3psZGdvaHNJWVVKTjFMcHlWa1M4VDV5VTZhYU43aWxxZnVlRC93?=
 =?utf-8?B?VDRieGhOUFA1UFh0bkt4Q2x3T2RuYzRScWJCc3hiTllUN1hvaXBqY25RMTRY?=
 =?utf-8?B?QU5ZQjY0RkEyQVpQZVhqU1NwcDhad210QTZBWXNXOEVVU2llWGNWb2krU3pt?=
 =?utf-8?B?TXBhdXczTlhqcjNkYzFPR2RJZjNSK2sxUFgvVXd3bmNGRERqdWpFeUViN2Nr?=
 =?utf-8?B?WnJoNFRMczh2amtadkQ2c0Y3d3g4TVkxbkNEUllwMkJLejE0K0NoZEhxZnZ1?=
 =?utf-8?B?cEhsNy9DMzRlQzRqbTd2TU01K1owUUhvQ3JJbTNMb3BWejl3RzBTdVJGZTgw?=
 =?utf-8?B?ZXkvRm56MUFWTFVQTlFvY2VXTmNDVk12UHZpeitSdGQ3anFVWU9vRFgzWTF3?=
 =?utf-8?B?c0N6SkhiOWN4WCsvTEpVWGxGQjJjc3ZmNWJIV2hDczdrWFNJU1pMcEhtYWJr?=
 =?utf-8?B?V1M4YzJ4U3ZmR0lmbW1yMkVTY2dydGt3a1N0dWpmS0V1WEZMdS8rKzM5ZUdH?=
 =?utf-8?B?bHBVZkJtOFdkKzVPQUNjZHk0R0hRcWpzcExGY2hraVZpRnFJS3JGSE1Hc0pp?=
 =?utf-8?B?OEdMdUJrWjc0VkU3WFdCcW80RGRwNWJhTTNUNEsvWHhKRlNQWXVHeUpzVnNF?=
 =?utf-8?B?aU83dWZGZXUzdnFlUVdHNTFlczFhWlZvV25jNStBTmkrT2hTRklabTVUQktP?=
 =?utf-8?B?Y3plYVZ3Q04yYWlqS3pYRWkyMGFKemE0Rk13S2dVTE51MnJJNFFpU2ZKQlBJ?=
 =?utf-8?B?M05kZzdxT0JIOVNBNzA2RTJoanBiaFRlZ0lJaHhYTkFiWTJ6dERhR3BZaUFX?=
 =?utf-8?B?OGFVZUd6WVRUUEg0QWFwdkc1K3ZBT2kwbVVlUzNuRnFuOG9zZ3JuOGVlYlFk?=
 =?utf-8?B?R3lTRHEvTnRSTFQ4bDRYRHdkWnlTRDc3YUNza1JXbGtUQm1xVEI3aitQVmxr?=
 =?utf-8?B?RU15aHEzdFp0QnpIN093VCtrWG5sZm5waEJoZEgvU1ZTZEwvN1dJVzQyY1F1?=
 =?utf-8?B?L0oyZ09Pck5kNmx5TFdXb2l1NnV4RnRsMnNReVJNcUVCemF3QmMwWUlFcVFO?=
 =?utf-8?B?endZc0pHR3o5bThoVGVjcHNFaWxqUC95aXc3Nm1jSFNONDl3Y0xFdjZweDBq?=
 =?utf-8?B?d1BWTExlYTFZbFVYVVJEU2FIcVYxSDVnbm9WSGx0dFQyWEx4dTNJQXVrc2xo?=
 =?utf-8?B?NTlXUGNVWkFkRG5xVC9iTHN2WlBPb3pmdE9FakV2cVduOGU0RnNBSDlrQ09K?=
 =?utf-8?B?ZDJZbmI0RnVGTnNVYWlkbHdVdFdXR2M0SC9IM2JweGU0cVdobmpTMzFZNUtl?=
 =?utf-8?B?ckNBdi9MWk5zc2xvTEUzd0VQVXU0dEdPOGJ6ZkNDbHUrSG8wNktLRFVHbVB0?=
 =?utf-8?B?L2tCR2FwdzNsMko4a1puLy9RM1hZY2tUZkJGcGdON2NlcW9MaWt4bTlEN0lt?=
 =?utf-8?B?ckVPSjQzMUhVejdxNWlxRUJQK3UwZm9FcUVGcU13V2tFVURjZmxuUGV3QVVU?=
 =?utf-8?B?S3NJeWg5VUwrZndjMFdkVitOc1RHeStzNE93eVU5VTlCeUxadkVZK0VoS2Rp?=
 =?utf-8?B?L0t1aVBBZklpUVFBNEZGUXlhaHdaUU5uaG54WFFHQWEzV3lYbms1bzRpVGhL?=
 =?utf-8?B?K2s5QnFqVkRITll3RUFGNmpoSm5oYkdOclNkNE1BdzRpZEprUGpTMUJMaFU2?=
 =?utf-8?B?cGU5VEhVZkhRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXpSb2NMTkUyTks4ZEg1V3krR0pxeXFTTDdVcTduN0VDSEZ5R1R5ZDJPQnh2?=
 =?utf-8?B?TnZQY0R4N3JmaFNDWlBjSXJpMmRQbzlLdTVuMllvbjhPNGErb1ZhYlFIeGdr?=
 =?utf-8?B?bDRIVUZUUFNsWno0VUhYVFNrVTZ0b2tpUUtmZlhSNVlISGl1TjJlMVdmVDZj?=
 =?utf-8?B?OTBvRndvSXZwcXp6WXlORzBSZG5aMW80M0Foc0pFZXBmVkVPSjlneHlUVktF?=
 =?utf-8?B?dy9vc3pIbGhNcFV2aFNQbUZ1c3ZMRXBINmZqNTNZekJGVHYyeUFiamdlNXhn?=
 =?utf-8?B?Rnh2bGF1VEJqajZmOS9pUENqRG1CYWNJQnVMTm15SDdHc1hFQWpnWkpWT2pR?=
 =?utf-8?B?WGgrY2VFVU1sNjBBVzlrOTZFc05uSG0wS1FiNVlQcm91ZVF4OThTRzhiOTBX?=
 =?utf-8?B?RmFhTUxPenIydVF4NHJBK2YwSWNLOFlZakZib0RRUGdKZzdkdnoxSTB2Qkw2?=
 =?utf-8?B?VlQ0SDN3Vk9KUjJzSGtQMmNXOVA3cjlFZ0JBVXMxZXptczlBa25CeGZJVS82?=
 =?utf-8?B?aHp2NGVQRllYUUVQc04xZ1hBNE05SitKL1RpbUQ0Zm5xdEJaZ3Z4WGxSVTNs?=
 =?utf-8?B?WGpob2xXZU0xaHBDMGpNZVBiT09aMEFOSWFkT25NSWlPUnFBQ0Q2YTBxS00y?=
 =?utf-8?B?QUtjclh1dlBENnNJNlNFdDZMbnNTWjRFOFJobVRxazNuYTBPMW5DdlpBSGxW?=
 =?utf-8?B?TGZTZmhDWUl0YkZQWUd2NU9aWEtiQlkwVnVBZ1I3VmFEeW1Fa3Z4ZVYvenBq?=
 =?utf-8?B?bGdzLzVjRUZwY0YwczBLSEZmbjlLY1F5OGE3VzJoTk1iaU10VUxpMTMxeGRa?=
 =?utf-8?B?UDZGQnNRNzNCakc3WEtxQ3g3L0g1YkFHaDVPcGlnZ3NoKzE0dVBzT0dpVEFK?=
 =?utf-8?B?cVROOExadzdiQWNYcFAwb1VrMVZPRTBMcW05V05sSk13UVBMbk1zUlJ4V0ZB?=
 =?utf-8?B?UzBMQlpPWlBEOFFDL1hlOUxVQ3pweU00Z0tjdTFuamtwVGxuRHltQlpjZmhE?=
 =?utf-8?B?WVBKNTRYTkVUNzdmVXVud1BubkRvQWxQcnV6UTB3TzlBdWJaVjZiMlcwQ2RH?=
 =?utf-8?B?SWMrK0ZzQzNkc0VvODlXS29PZjFOU2lpTGJ2UzZ2OCt0dGpKbVJ4YktUY3pa?=
 =?utf-8?B?TXpqWXd6bDNHYXhkUllqT2lpSnBoU2tGcUlob0xGQ2tKK29hMDhwRVo1Mmg0?=
 =?utf-8?B?ZGJkL3F2QU5zY2pEMU5qY1IxV094eFBkUDFlNGkvbURMOFhxcTUzc3Q5Yitk?=
 =?utf-8?B?SERScmszWnUxdUZnRm90UE9MWjdPdWpLZ01JS1g3SXNoR3dWWEJCMTdOZ0Ex?=
 =?utf-8?B?dlhqRUFZQjE4Y3grWmVFUFpqQVVUVTJ5Y2tPWStxV1lXNXkweWdFNDdNWm4w?=
 =?utf-8?B?YkRIc0FnckMzZit6VnRScGVMbncvUjQyK0FaN0pvY3BFV2pTU2kvL0VObXIy?=
 =?utf-8?B?MytycUcwWUZjUCtqaWVMNjlrYXhQOVJ5QXI4RTZ6VFV5THZXSWV4ZWdUVXJm?=
 =?utf-8?B?dmpLc1lBVzJ0bXFIaTNBTm5UaXl4SWJETE5Lb3R6WGN6YTk5YlZXclVkcWhU?=
 =?utf-8?B?c2NIU0pIN284Sy9RcTBKSi94SmFRQnBnK0trQkQvdEpyd3BGeXV0T29ob3k0?=
 =?utf-8?B?NzNPTk1HUzVaVXRpMkx0V3pzam1yOHQxdjFaWHVkQ3AzNkRoYy9pQUZ0QUlH?=
 =?utf-8?B?bCtYR1BqaGQ3UnJCMGkwYzhaNVhvRTVNUnpod3k0KytuVzBMblVUVTRwbVpp?=
 =?utf-8?B?VzJPcFgzS3d1a1JoZGhjVTBsN2xDY2NpdHlxMGVlRXFFQldsK1NET1czU0Mv?=
 =?utf-8?B?bVV1QVMrbE1UcmMrczdGQ2luNnYxcTdNM0lzYWlSYk5YNE5QQlkzUk9tbFpz?=
 =?utf-8?B?NllheGRVS29kRFBaNFYxNDUyVXBSOHRyNjhFQVJONG9sUlYyTE9taWRHTkVs?=
 =?utf-8?B?ZTlxNWlMNUxCQSt5VURZZGFiTTRFeDhraEJBRko5dFRDNTgweHpYYndmV2xN?=
 =?utf-8?B?ZDQ3emZYcEFva3l1OW1YRG5zWUFTZ1RRcDBmeXVEM1RNdktyZmdWWEw5Si9s?=
 =?utf-8?B?STNNTUN6eEdxZTlMNWlCL1JiMEVaMWw1b1MzbmdTYWxwWWFhemlDL0E2NTVE?=
 =?utf-8?Q?HCBO0hjnictxPOz68R/sc6+8N?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8a294f6-7ee1-4bda-9168-08dd3fe859fd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 22:08:53.2414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XsjqgVKJv0GyZ0LvLHVLez+rK2RoAaoddkPPLem/F5evG5VMU1P4DEF3xkLJ/U/wiJDcbiIyBmRnSFzkIlOJ3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8555

Most systems' PCIe outbound map windows have non-zero physical addresses,
but the possibility of encountering zero increased with commit
700cafbb642b ("PCI: dwc: ep: Add bus_addr_base for outbound window").

'ep->outbound_addr[n]', representing 'parent_bus_address', might be 0 on
some hardware, which trims high address bits through bus fabric before
sending to the PCIe controller.

Replace the iteration logic with 'for_each_set_bit()' to ensure only
allocated map windows are iterated when determining the ATU index from a
given address.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v8 to v9
- new patch
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index d0d6c4e8df80c..c1767450541a4 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -284,7 +284,7 @@ static int dw_pcie_find_index(struct dw_pcie_ep *ep, phys_addr_t addr,
 	u32 index;
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 
-	for (index = 0; index < pci->num_ob_windows; index++) {
+	for_each_set_bit(index, ep->ob_window_map, pci->num_ob_windows) {
 		if (ep->outbound_addr[index] != parent_bus_addr)
 			continue;
 		*atu_index = index;

-- 
2.34.1


