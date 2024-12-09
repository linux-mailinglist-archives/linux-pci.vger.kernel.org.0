Return-Path: <linux-pci+bounces-17956-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 887279E9D71
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 18:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BCE228061D
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 17:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D027B1607AA;
	Mon,  9 Dec 2024 17:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HsiGkUGo"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2086.outbound.protection.outlook.com [40.107.247.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28FB1C5CCB;
	Mon,  9 Dec 2024 17:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733766532; cv=fail; b=LM7KRLy2Fe/KNi2UR6TKqqa6LMF4qYx0u2zg92htwUCM8spx3jnAWK0j0mQQtVXd1nkEUZvYiYLKacI/OKG9rpZFRV5o6GfkEHvJEMu8RHemUaQWwh1R+5meLEilKNMFJDRNgATyI3uDGhRfjkC/2sxz8LVVqPM/BmeAeuvEFpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733766532; c=relaxed/simple;
	bh=PgF8iXUfL14mEGYw4rl2HUwUv7bZbYuVrZCh/TdXXi0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=BMDqYu8SztFvWSTLZna/ru+dCIeAxLIBP2x7NPF+mwvVFjhYSVTARabD4P9ccsbNmTezBRlPm3t8FZdhusk17mqmSUYk1T6kDjmuCEq0A5gC5uMaVsAH1F1AJCaLzOvqU8u9HA3OZOz2cop7UyzLJ5dK03PVCTfiusv4l3V7qMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HsiGkUGo; arc=fail smtp.client-ip=40.107.247.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JUE0ywnMedM9XhwZANz6RIp554NCm09v2feUmLrdsTvz/ISHXCXZJO3qaXqdUdCpyzQaeC5qMBVnBuFtPezG3CiPnuDL8UnozfTSbFmKi85b3NknUI5K3/Tt3wiuqTgWFy20rxCMGFW2ngGXiRe5fXG/kcMyknLB/vou3vvu2eHGss479z4F5fHp3tk/ZP667otdUCySAfSPnPPMOmXTmijHqetO8UWmGDVNavnns3s/bUhPbhnp5Lm0jfHfeF0efmVSIQWU+h3Axzif1BaZXETSs8UuPf5UtO8A6XMNWnnnl/SOQLOzB2j3po/kTaD5dq4fYyWbgrO5mKQeMZvayA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mx8CH+EoHbmFyezPK355CdtDc8U5uUJoKs7Xm1ppR/E=;
 b=nlIbmBw4QIDr/NZaXxws3nSPvzZBJmjtGIhQObflUMlalPVjKUQ5ieMDa2mp0ckwmkOExODVGevkloJqpJipM33LMRASGsJERg8qvVeodw2wtIJZrKC9dzfUeDtirjvjK7RaZ5rytFT+NbUdTxXkaSgXGoXhon42GfvCswRatQ6OMH0IpNmJsXRjzF5PU9OXzzhPq+X/A5ys2F/kiPmltydQrLwaY3rzwuYc0hFv0P6E6LqfimcL0a+vBVNXMJMUZRHoutMHaeRYtAmprnPYQT4teNHxWaUUJ0KpN/pG13dtClxshl0WjaIJ3NLVkkvjNzFUN7ku5TXnLZOHRBQm4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mx8CH+EoHbmFyezPK355CdtDc8U5uUJoKs7Xm1ppR/E=;
 b=HsiGkUGoM+BegwZi5C2yUvUtnMKPzL2L+FJhZ1YMnWmJOSvczM++SiX7ATeN+CXtqef7zsgaw+NXX74oxeSEAd2RbpyAEUE5CBZjFGozyeTlKA2v6SWYZNx4bDwbyblrdCp5tHkvgcNFfcMSC/l7hqxbhcyVyxUeeGsuDUURYgO6HfRh3OMq8v1dK3iiG2wm7tzuxibrBNjhmjZI6p+fVucVpcMmbUVpzbNm9ybVcVmgDU5xMHhi8NIb7OaD6r3RHJjNkInH6toFplm5UFiw17bORN7zvrfLcnHVH79rv7D0WSDzfiIreOsWzXiPScD7tdOO1QEWCL2jvGGLpDNM2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB11017.eurprd04.prod.outlook.com (2603:10a6:150:21c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 17:48:48 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 17:48:48 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 09 Dec 2024 12:48:16 -0500
Subject: [PATCH v11 3/7] PCI: endpoint: pci-ep-msi: Add MSI address/data
 pair mutable check
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-ep-msi-v11-3-7434fa8397bd@nxp.com>
References: <20241209-ep-msi-v11-0-7434fa8397bd@nxp.com>
In-Reply-To: <20241209-ep-msi-v11-0-7434fa8397bd@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733766511; l=2150;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=PgF8iXUfL14mEGYw4rl2HUwUv7bZbYuVrZCh/TdXXi0=;
 b=qGaobY/De0ThtjW3FuLJDy16y88UAzIa6rABWSn8fvT+DldmtXWM8xEM8g43FYYmWlrRS0HKp
 fETRrwaJJUkCUBsB06yHVNCYZoYbO8iSTsQhEJw6WJQxkHMImpOhDDK
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR17CA0070.namprd17.prod.outlook.com
 (2603:10b6:a03:167::47) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB11017:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e4d280e-3d1f-45fd-42da-08dd1879bbdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cG1qK3lObEZDUHp0TkxQNXJsNHN5UnNNOFkraVVwVTJsWCtDdTJaMzMwU2gz?=
 =?utf-8?B?WHpaVlRqdkE1RzR3VkFYVWdtQjdJbCtUS2xNSlk0NmtLR0N4dHlXbi9IRTFD?=
 =?utf-8?B?Y1h3dWlGdzRIcXJlOXkxeU1IWFkyM0pHN2xmL1ZjUEJrSHlvNnVKQXYyWnd6?=
 =?utf-8?B?eDRwZ0NvUTVpQVQxNVVCbXdlYTlQNVFiUk1jV1d3YUQxaitLbVNRcWNhcG56?=
 =?utf-8?B?U25GVHd5L1dKVUkvb0ZpOU5aSnk5dXdrY1Q2eE04SDViaHVRWG9PVW52bjJL?=
 =?utf-8?B?OW1ncHU0Q01FN0E5NER1ZkFCSEhjdFREbkdFaTA5VjJyR2p0czZxdUE5YlM1?=
 =?utf-8?B?YlNBby9mTmF4MDIrQ0RNYjFCcjllK3RlZmxXRHpqd3dPNEgyby96UWJRSEt0?=
 =?utf-8?B?T0JmRGpuZXNUQU5QWC95bHphbTdBWDdnZWowYmcwMm1Ec1RrNEtWNTFQZXlX?=
 =?utf-8?B?UnQxT0Q1NHhGTDhkSEQ4WXpEdEtsc24xVE5GYmhGc3laN3N5SGxIRWcycjh6?=
 =?utf-8?B?VFdmUDJDVVpneEkxc3BGUkpBc2U1Z2FjbXNMdy9OcEIrSGRQRGRlck52MmNv?=
 =?utf-8?B?ZkVYSnVNZVYxVWVEOFFUQk52UlJZa2hmZzNBczRCVllDM3FQT2hzU1kwN0tl?=
 =?utf-8?B?OTFFb3hwVGNEN29ncTlibWNKVFJ0MVR2dTZZdFVXcldiMmNzRW03UjBRc1BJ?=
 =?utf-8?B?aDJVS3VNZndlNHJrSUdLRlFmRkJIV040Qzk3WDZhb1JweGQ2bFdWc3E1dng2?=
 =?utf-8?B?TmJTdVhad0dURVVEWFUyRDc2WDlLaDhKS0o0V2s2emZSS0V2NVlLd1J4VWRo?=
 =?utf-8?B?OUlvQzlEV2Y4NHJXWEV4Q0lHUTlCRzhsOGI0ZXEycHpyRDZvTUYzajNMK2Vi?=
 =?utf-8?B?ZmxYWTFpWll3aGxLQ0tZckNtQS85V2FJZjBjWVh4TXR5MHhjSDhaRUk2UjhQ?=
 =?utf-8?B?L3g2K2VpSk9ZVzlhYk92RllOc0ZQRElkRkFLSTlCaHVleEJHZVVDNjJqUlp0?=
 =?utf-8?B?Z2hIMEFYRC9EM1M5cnE1Rm5wTnM2VE9PSEJOSExhNmtNTnlrbzVJUFVjUHNI?=
 =?utf-8?B?Ymp5YmpGRTRLMFZNR2R6RnJmWURGR0J2MHpSWU4xVU5kQ2g2YWpDNlpGT1ZM?=
 =?utf-8?B?alZEZEZ4cmFQSWg5Qmt6eUQ1RmV6aFpHM3pWekpsUDh4TmZZTEFFbXFsbHFP?=
 =?utf-8?B?WjZQUzhTVzU1M1lPSUo3VXZ3aXp6d3ZxZHVrTnltaklySGg3emVaWGRxdkdT?=
 =?utf-8?B?bnFBWmtBU3lYeDBxbnBLTTRPaEEyNlBmeWdGQ2VCZkJwQzhTRmNlcGU0SlBT?=
 =?utf-8?B?MlJ2K3lkUzY0VWk1eVpJaWZvd0tSZG5qSU5vWVFVdmtGOTcwMVRGbDlHY1Ri?=
 =?utf-8?B?SGZlMmVGNVBUU2lNcXJWVEVRcHFPbTd6ZEE4T1N1aEtENWtVa01DSWZ1VEdi?=
 =?utf-8?B?SkpPOXVUODQ2Q1N3dnhtQkJ4WHYvN2pGck55SEZ2blIxczFWYWRhK3hEVUpl?=
 =?utf-8?B?SVQrRmlBMFY0QVVKTDRqWmxlME5MY3pzQUdzT0hiVVFuWlhVZ2d4T09qM1E4?=
 =?utf-8?B?RW5MZ05FNjZORjdOb1NXU3hRa2ZVQUZodHZXVitVdVdGaTNQc3I5L0dUVmZ2?=
 =?utf-8?B?VnV2R0t2YmxOSFR5dEc2QjJSOENSZ0RueFJpcnEzOElUSG5TTDUrWE5JQzJl?=
 =?utf-8?B?aDRsSEZrZGMvRC9yOEM4RDh6eHJJRml3VW4yV2xyclh1VTFhNThBM09yYXFD?=
 =?utf-8?B?amZDbFREeVltZHJuY1BlZlZpelpuOHZtLzFqcnl2ZGVMV1NEUmRBZFNRTG9D?=
 =?utf-8?B?b09RYTRmT3JHY2JTM0RNa05iQlI4MHZOYkY1ZzY5anFWTVhTODVzcXRsNVFl?=
 =?utf-8?B?VGE2aWFIa1BsVUlqQVlEKzFTOFZjaU5lQlNIMzZVNDlKcndweWRRYmVKYUVY?=
 =?utf-8?Q?FDqR9C5CET4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dzVpbmtTMHI5L0gwYmYvcHBtTXVSQ1pnMWxqOWNaUzRoY2sydk9IU3l3NWVV?=
 =?utf-8?B?Ti93ZmZKSVIrME4xV05LRzZROGlFaUZyTzJqWUJ1RWhjbUwweGx3bTdlRTg4?=
 =?utf-8?B?VjBNQXY4cXhML05jUzVuakU5VXZoek1LZm93UG9jN2dUMTI0bjdBTGx5b2FS?=
 =?utf-8?B?eUx4aElBVTJwNVU0b3BOTHArSm5CMnNVeXhhZEhVU2krMXJDd1l5S2JPZG1S?=
 =?utf-8?B?K1VDZlhHZ1ExaERTMXB0dlIyMDJnRk4zUFJHRm40STQ0cE84MnZraGU2QXJ0?=
 =?utf-8?B?dTFxZ0hjOTVJQWRwKzBCVWxwd1hlNXAwNHhHYkttQ1ZUbXJsQnpsTlNhNzZ5?=
 =?utf-8?B?TTAxRU94Y1FLRXd2ei8vUFVXSDZsU0EvdVNWd0szMnBZUlpMMnFsWUJnWHUz?=
 =?utf-8?B?eGx1R1lrcGFuRUdhc1ZNTlN4ZXV6R1ZjYWEyeXpNOTAra2R6N0RSTzViL2xF?=
 =?utf-8?B?UFNFQ1lxMCt2WS9aMmE3TENlZXQ2OGU1QkI0U3Z1cyswMmE3RStpQnpGbW1m?=
 =?utf-8?B?T3kwMVFSUWZrMFpSYmExNUxjaDAvQ0xCZmxrQTlRN1pZU2Q5NGFwNzJuSzNy?=
 =?utf-8?B?MlBoK0p0VEVqQ052UkhFNTYvRW5xTHI4ck5YMzloVWJGQmhOazVwNzAzOThE?=
 =?utf-8?B?SHF5eVNIZWdEMHdqT0lkcXIzeFFEZE5Uamp6eUpkeWRzZmRQN3JWSmROM2xk?=
 =?utf-8?B?K0s4RTIyVlRTTmVHSS9wRkh3R2hTRUZHWUlVNitZMjhuM2VZa2FNK3lEOWt4?=
 =?utf-8?B?T3c0cjNET08zbTRlWUFORk1GY1dta3l2NURBaVhRcVNILzhiL3NHQXBnT3RL?=
 =?utf-8?B?YWFtN3YxZG0wWXRUN29UaXdQQnM0WkNIZ0RpYnRIdmNXTDFTY0FBR1JYM2xw?=
 =?utf-8?B?NUVtL0J1b3VzRFpLNWZvL1hmaUs0TGlNZ1JudVFmMHZTdG15b0EzRHBvSExm?=
 =?utf-8?B?amhqNDJlMDJ0NlhrK0ZpRE5yeS9xbnRxY1o2YWF5azZaT0FvRHZjUlZwRmJx?=
 =?utf-8?B?cW1OcWJzZElsLzloMFlBdWZwaWYrU3RlQmtDYThaUlprL3p2QUsxK0d0NjlQ?=
 =?utf-8?B?a2s2eEx3V292VXhUMGdMTWdNaUJSdzloQnZZaGV6eGMrWkJaamxyaitnS3Iw?=
 =?utf-8?B?SDk5RTRZWDd3a0E0VUhJMmEvS1ZRWHdWVmZmOGVHdXdqbEp1VVp5elVYcFZD?=
 =?utf-8?B?VWk3KzNLYU1MbmlLMWJZczFuVXNhSmE0NkYyc1h1ZmZNd0dtNjQyU1lHTzNj?=
 =?utf-8?B?dnZNSDhoSmhrNmdKZHFQWFhrOWU4ek53ZlQ0MFUvUnFNUUEvQllhUFFCdU1O?=
 =?utf-8?B?NUptUmpzRHBSeGltMlFJSitEQVFyS1pGbWN3NzhXbFlaYXRwRWxuRGdGRWFy?=
 =?utf-8?B?Y2RnWkduZDYrdERacDJOdjdvaVhjaUJuUEgxdUtDeTNQNk5PSExsS0tZbGVr?=
 =?utf-8?B?UXZvODczd0k3WFdEZ0FDejd6S2J0N2dacXdCN29hRDR3WWpxVmdUR2Zpa0lU?=
 =?utf-8?B?KzRqUnVPTHVzUEV3WGZ6bmNTV1Z3NWNIYlEvSUozSDZqN2sxU1AxOUxXTUwv?=
 =?utf-8?B?aHVWT0xNNGhXV3N1TzQvSHd3SE11OVRRbDBQVm1jWndKUkdwd0JOWm1jUHdM?=
 =?utf-8?B?cytSQlJxUnVSYjg3ajJpL1UwdnVDTGkwNGp2b29YVkVuL0s5OGpwNDRia3RT?=
 =?utf-8?B?bmUxZDhwR1FTU0hqa0U5c0NRekxicHA4NjlvQ1AxMFJpY1B2eEkxUyt3ZDZi?=
 =?utf-8?B?bVVhdlhYeFB1aEFVVHd5bXFIYkpLSWd5QjZEcmcxS3lnUHVHUTVUUnBqQ3BN?=
 =?utf-8?B?bzBVME1icXlndC9nRFg2Zms2SGVBdUxadzI2SmpROHgzYW80RHBmN05LM3NW?=
 =?utf-8?B?c2Jwd3piYnV4cVRrQWFvTzhSKzFrVEZlbjNLNWM0YTlnR01uRkpkNlVKKzhz?=
 =?utf-8?B?WXlVdThCWjJjY0IxZU1RY05XSm5qbTRRS3E4cnpjME5oUThXRkMxMDlQZ0ZM?=
 =?utf-8?B?OEZoRmZMNVJWbUQ4R2VFWkVTdy9xcjhMdVNlNGdoSk5GQzRWWG1BQU5qc3lJ?=
 =?utf-8?B?ZDVFc1dzTkVQc1ZkUUJ1N00wTElPcFNFREI1bEpDM3hHN0xlTDdVWFR3bzdY?=
 =?utf-8?Q?tvVs=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e4d280e-3d1f-45fd-42da-08dd1879bbdf
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 17:48:47.9766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dpVDYNBgyfJbm7mBVvJcf1YDxhd9ptxFS5ditAwlEuWnC/ZCNXsTdNkILVeGK2v7hcaNs1DyHpM6/sOvp4RypA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11017

Some MSI controller change address/data pair when irq_set_affinity().
Current PCI endpoint can't support this type MSI controller. So add flag
MSI_FLAG_MSG_IMMUTABLE in include/linux/msi.h, set this flags in ARM GIC
ITS MSI controller and check it when allocate doorbell.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v9 to v11
- new patch
---
 drivers/irqchip/irq-gic-v3-its-msi-parent.c | 1 +
 drivers/pci/endpoint/pci-ep-msi.c           | 8 ++++++++
 include/linux/msi.h                         | 2 ++
 3 files changed, 11 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its-msi-parent.c b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
index 33e94cfc4d506..a34e9bf93f991 100644
--- a/drivers/irqchip/irq-gic-v3-its-msi-parent.c
+++ b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
@@ -16,6 +16,7 @@
 
 #define ITS_MSI_FLAGS_SUPPORTED (MSI_GENERIC_FLAGS_MASK |	\
 				 MSI_FLAG_PCI_MSIX      |	\
+				 MSI_FLAG_MSG_IMMUTABLE |	\
 				 MSI_FLAG_MULTI_PCI_MSI)
 
 #ifdef CONFIG_PCI_MSI
diff --git a/drivers/pci/endpoint/pci-ep-msi.c b/drivers/pci/endpoint/pci-ep-msi.c
index b0a91fde202f3..1c157e0a81456 100644
--- a/drivers/pci/endpoint/pci-ep-msi.c
+++ b/drivers/pci/endpoint/pci-ep-msi.c
@@ -107,6 +107,14 @@ int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
 		return -EINVAL;
 	}
 
+	if (!dom->msi_parent_ops)
+		return -EINVAL;
+
+	if (!(dom->msi_parent_ops->supported_flags & MSI_FLAG_MSG_IMMUTABLE)) {
+		dev_err(dev, "Can't support mutable address/data pair MSI controller\n");
+		return -EINVAL;
+	}
+
 	dev_set_msi_domain(dev, dom);
 
 	msg = kcalloc(num_db, sizeof(struct pci_epf_doorbell_msg), GFP_KERNEL);
diff --git a/include/linux/msi.h b/include/linux/msi.h
index b10093c4d00ea..d95d979e4747a 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -556,6 +556,8 @@ enum {
 	MSI_FLAG_PCI_MSIX_ALLOC_DYN	= (1 << 20),
 	/* PCI MSIs cannot be steered separately to CPU cores */
 	MSI_FLAG_NO_AFFINITY		= (1 << 21),
+	/* Address and data pair is mutable when irq_set_affinity() */
+	MSI_FLAG_MSG_IMMUTABLE		= (1 << 22),
 };
 
 /**

-- 
2.34.1


