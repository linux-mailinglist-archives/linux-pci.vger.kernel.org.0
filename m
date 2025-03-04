Return-Path: <linux-pci+bounces-22891-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF87A4EAE2
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 19:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2D1817B3EF
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 18:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DAA26A0CF;
	Tue,  4 Mar 2025 17:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kIn5FdOc"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2050.outbound.protection.outlook.com [40.107.22.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C544C26461C;
	Tue,  4 Mar 2025 17:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741110601; cv=fail; b=V4l3fGaMJ6LpO0Hnqxg2AXoAq48gIwhf/2MLcOUzzExm4kUSJMzjtUa8d4n0f4yLj50yYM4dsYwYTN4H6ghmzzUfUn0PR/SFcRcyRT/RDa31iEhiKtVWKc0VM5mEq0MMH+nrJP9oh3MLmgcGSyDlsMWfe+84ad8FqBqARJx0bhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741110601; c=relaxed/simple;
	bh=MRnp2w1JbuZ64j6mC2lny38kcmCwfis2CxC++T4dC4w=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=ep7iH3RySZqqhCwMir2VOePYm6SGNqwQqTyicw4XqsHc8+f0hIMwgAC7CYelX3bB6/lCCudG3z8ELMC1wZ4NXYo0vPFay15FniSNBChVnCb2Up4X1QXPeAHgJwTjdTPENkGzudOBsqJua0N0z1h+QG0zkmEKYwGD7BRYGwD9Uv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kIn5FdOc; arc=fail smtp.client-ip=40.107.22.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fxM43FUPIf5+IC5WcEJhl1E5FhCpD43vzA87HN1tu1XGUb1N7xbJe69YzFaGOcbSqqsRiUPbSM9K/mVK+NVWtEAES0WxmSl22LDX9eO5KUlkT0yjygyDZwETTVvstnlX7lSbFxeRikHG4t6vfhwRpE8Yq0b3PSWASuhKvfvSkT2p24+PEkmfw2Yy74wNBJcNbydbVyRc5GEB7jEpd6yZTuhhgWWyU3LZ4q1FlmnMb7hrLxKz2Efub3LqXFCOwAWW9wlxcvYwt5tBRneBpQdb4jLoaCGwl+er6cHDPTIRGeafEHdYX72tG5kqbA8nFl4uegBvd8LHfdlAKOinZ91Qpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DMCF89lSvrwz6mp2CrHDDIe/TEjMPTqLsuTL5ToswGM=;
 b=ldTRDNoTNIcr8J9F8OIi8RUjga2w18N6cGNvClthAL7RVDxtR2sp78txOSFufN+ER9vjeKtzN//AY7yYUA0GlkJ3sqY6w0UZS8oJ871enTCMcalFEjsYI79wVRbxof7ZpROZhobEzRJ2dG/MA3w/Xg6RD++MRu6boPEU5i1u/PXgeE3gA5OmXM4+7IREEeapX9tmG1eG7YT1YLpWEaxW+uOA/puk9uk9hykW49C39Wc6+nz1YyJD6B/r938q+WKdGqvuCRn/i+hHM7cg4Yl9X6WEJof6WxpQ5DcSDQpcidwhTw5yPgcqZBAQhOflxoa8Jqa3GX2ol+oK4da6PcHcJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DMCF89lSvrwz6mp2CrHDDIe/TEjMPTqLsuTL5ToswGM=;
 b=kIn5FdOc5fxvpofrML3CrsjZra80Ho1lnEWmEqP8acfdoo+dhvnCGlwt389N8VHxdy5klbTt6l58EJFkb/+Pqe5z9fbC2umJzlWdafJgG8rP57RKPNC1unDBtF5nTNYMPaCtYshJLd9tJ2p553/5TGs+Vn+MYS4QP+8/jg0k1kMdribNDmrtfxPbxpnRNHDb+KU5ZcMQfkwxbMgPkpvpP5O6n+Rg7i0WZgAjKYWWHG+P6TeWrK5n1CoigpBpY9tj9F+Ma9hmMUEAIJ+NG8E4OCWWaK76tV7viVFkhtjFnEa3pb3vkFIf+6bvnRdynl/an9KKwIR+ODSEcvwK9QeApQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by PA1PR04MB10504.eurprd04.prod.outlook.com (2603:10a6:102:444::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 17:49:56 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 17:49:56 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH RFC NOT TESTED 0/2] PCI: artpec6: Try to clean up
 artpec6_pcie_cpu_addr_fixup()
Date: Tue, 04 Mar 2025 12:49:34 -0500
Message-Id: <20250304-axis-v1-0-ed475ab3a3ed@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC49x2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDYwMT3cSKzGJdsxRDI0tzA0tzsyQTJaDSgqLUtMwKsDHRSkFuzgp+/iE
 KIa7BIa4uSrG1tQDr31ilZgAAAA==
To: Jesper Nilsson <jesper.nilsson@axis.com>, 
 Lars Persson <lars.persson@axis.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arm-kernel@axis.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741110592; l=848;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=MRnp2w1JbuZ64j6mC2lny38kcmCwfis2CxC++T4dC4w=;
 b=4MvMCYfjLLRzrxCDf9dn9EyOlUtn3vG40KGTy4lbfm6uZyx3l7LsL5yYt6DlskAFe7//UGgJ5
 119BwVEoXqdCZUGQSVkM7wRUPDP+FzpU3/IEA9fKsOw0f1llP9P8Hdj
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR08CA0007.namprd08.prod.outlook.com
 (2603:10b6:a03:100::20) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|PA1PR04MB10504:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f44aa79-3f73-44a9-a9ea-08dd5b44f99d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SUJ6Nm9JWnJoZmJvMzByeGhlbW1Oa3lrZXZ4WitjZjJnMzF0NjVKbmNvSlgw?=
 =?utf-8?B?ZGJxUHNqSVdsYVZpaVpJM3FqS0FNVXJkNWVlYnZvYkVtTWE5YytJKzhicHVB?=
 =?utf-8?B?QktUeXU0ZnVWR3NNZUkyUWk2b2wwMy9yRXJod0JwMEN6SXlLa0RQT0ZGaXpL?=
 =?utf-8?B?ZTdla0ZVSlgwMERzVUU4b3N0cWw3WWlLYkc5Y2p0QktMRTlpWDg1anBCbG5s?=
 =?utf-8?B?Wkt1VzEyYndtVXg5ZCt0UGpzUUllYWEvQzQwYWpyZlRYSkFXa1RFdk4zcFAw?=
 =?utf-8?B?U3loclhRcDU5a3JNUXdNQWt4ZGRtOW9OT0tzK2hTSXNpOE9BcU1tTElBSSts?=
 =?utf-8?B?NHZUWVZhRHNFNTV0dUozWm9rWUd1dmgyUnUvWUZJeWxTNGhKMHI3c2lyYlF6?=
 =?utf-8?B?cVhTWDRGZVVYK2swazZXSDhXVzN4ZmlyRnVwdkJlWVJUU3k3N3ZyVkZ0R1Z0?=
 =?utf-8?B?V0NTVGh0S0RmNkhmbFRORzUzRS9VV2lZWVpLU0Q2NVROTW45N1lzTG8vZ2NN?=
 =?utf-8?B?NGNmdjFUb21Yd04yTUlabDVCZnlBUmlpL1dPUWtHMXlsdDhDTVh6TVNveW5N?=
 =?utf-8?B?eWRsQmR4K0FMM2ZVSFBBQzhPNHkvVXFVUkxlejRYdmRSUis5ekt6bzlxK1g5?=
 =?utf-8?B?QmRDL2IxMmttNkpmd1AvaUlFd0RJTVhEVEFlUnliaVo0V25vNHJ3eS9SQnhx?=
 =?utf-8?B?aWpXTTJ5THlOcmxkMU9hL3pjQXdRNEg0blAxbXovOUdiUHlmTW5HdWtiL3NR?=
 =?utf-8?B?eDNLOEE0QWMrSzNKQUFseGdnRWQwU1doRUN0RDB5c3d3em1sZnFZNzBUVURO?=
 =?utf-8?B?S3g2V0ZFZURCQWlpZUtkcEttT25ybUh5N0k2MVpFMklRZEMvUVdZV1NsS2s1?=
 =?utf-8?B?NjRtZnNLVE9heUc5cEdBVUZUQVdWOVRTbGVScVd1WnNBcXE0ZkgxRmtDNHRu?=
 =?utf-8?B?bzZaTURONnpEZFdYeTdJaUtJY2hmTmM1dDI1dnVja1h3OXFPRmtORHdUVjlq?=
 =?utf-8?B?WFd4VDZTRnVNWmErVXBkR045TUZSemd2TEc4Vzd2cXlLVmdLMU0wTjNsQ3FI?=
 =?utf-8?B?ZFM5Q2ltaGIwalBFMVpnUkxRdjF6aUNKeUJDSG03QTFGTnNDK3h6YWhXbmMr?=
 =?utf-8?B?WkorL1JuYjVySHA5NnBYbzRlLy9aNjVOaFhCNkkyK1dXQlBkb1BadFYvZEta?=
 =?utf-8?B?WVQxVFZ1TkRBM0hKcDhlSFhGQ2JJVVdDM014ZVRoc3RkdFN4My80ZVZnZ1R1?=
 =?utf-8?B?M0dqMFJmbFFTNHl2cklBVE1naEhSNHU5dEQzL3ZiRGFlVkk1VXFxTVRjNzNC?=
 =?utf-8?B?dTEyWEU3cWgxcjErQUE1ZUpNcXErdTA5T0x0YjVvRXlyb2NubDR1M1lwenRM?=
 =?utf-8?B?OU1NRUNVamtzR0ZVVlRSNS9PdDF4cXo5ZkFXQTZ3eWxnWGFWdmNSVU1KSW9J?=
 =?utf-8?B?T0RmZVNvUGkwM3JVRVM4cWdiNFdDQkpZdUlKUnJ2NmVFdTVTQlhvSnpDOHVC?=
 =?utf-8?B?OHpaeVFaYStQdGVub2R1UC8xOFN3by94OVc1dDdqUXJvUTJyemN6WU94Z2ll?=
 =?utf-8?B?dVJCckpBdm1DcTR2dHpZbDNuWk5MQ2F4RU4vbEowWEpqMGFhdmE1Tzd0bHVa?=
 =?utf-8?B?bWhYdmVLbGdkWHFMUUlMQlQvTWw1UEtvWG5WM1doSzNGaXptdDZPRHAya2FV?=
 =?utf-8?B?T0FWVFd4QU5DaTM5elR4L3hoalVMdGgwd3dVcXFTc3dIeUE1Vk9iTXBmcnN5?=
 =?utf-8?B?TU1tYitjZXRKMXlUS2VVS0tHK3BXU01zbU1WQ0ZaUGxITDBURFRub01Wd2pH?=
 =?utf-8?B?MkdsQ1pueVlyZ2JuN2ZiTTF6MEREZFdCWTYwKy9YK29LNkFwaU1BbjNEMW9I?=
 =?utf-8?B?bVBUUVBXNUEvdGFRYzlyMXA3QXNYSDdKWEJXam9xUkFlMkV1NTRseGpodk9x?=
 =?utf-8?Q?JB7hco1RyEfuTFXJlDocHBQyhZZlDuth?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T3I0dHhrYlNMbDFNVy9DcWwweVNZVVJjbXEyTHFzQnpkbGcrdTMvdGRyR0tN?=
 =?utf-8?B?dzJHRWFrSGJWT3ZaWmdaUk15MTlQaGNPOGtDZkhmN2ZyUTltTFRRV3dmRk5P?=
 =?utf-8?B?THloWWdacjVFWGhMZmVlcmVPRkloTmpMTDlKajlVR3ZnYWc2SzNzVFp3aDBN?=
 =?utf-8?B?Zm4rNm5HQWRkMlJ0VzZLczlWVGtqS2JHUU5OUnYrY3FHVlgySjdZaUZNa2VI?=
 =?utf-8?B?MTNjbG12UjVZZXg2S3V6ZHloc29UbWxyMXBaVm1GbTFiRFJ6cmYzQkhaMjh6?=
 =?utf-8?B?c2RocGMxd24zSVZ4TmlqcHRwdEZCTHZpb0RkMkYrQ3FQWGZnbzhDLzZOVk1G?=
 =?utf-8?B?dnl2dWszYXhYN2hQMDNmV1h2cmZMZzBYcytpbkh5U3VKV0RZQ0JUanhQb2Jj?=
 =?utf-8?B?dmFkWWJDZkdFa2gyaXQ5cFBCbWNLN0NXMktra1ZPSUFPcnU5L1BpVnQ4OWM1?=
 =?utf-8?B?ay9YOEZiYTlFYjVQS1VwOXhod0JDM0hzWndKNDIzMnQrOWhVY1RodzFNT1Bq?=
 =?utf-8?B?WjVrNWs0T0ZWclFFV3pSaVZqS1ZwNDVYdmdJWlNCY3kwWjZNL2FYVlJjc2g4?=
 =?utf-8?B?MnVqUUpraTlaa205TkhUUEN4VkthSVJvSG9QYTZWV3hsZDVWN3k5M0VmSXlq?=
 =?utf-8?B?R29IMndIL3Q5elh1ajA1VHIyQjRSMFIyeEFUN3F0Ym80ZU9kanY2aVFLT2tY?=
 =?utf-8?B?UTBIbXN4UC93UUNWakpUWjVjQTJZQk5ldUlUYmkyRWJTWW8zNkZOOEtQS0JU?=
 =?utf-8?B?enFZQWpJWC9jWWc2aTUrTi9VbnQyNnREVElCeGk0RW4zUlZ0VXZ2bzhjUXdQ?=
 =?utf-8?B?MTdyQi9LTERYd3ZtMVlMNVllMUpER3d1QW5jSjZSandPUjE2Y0UxeUl1QVJu?=
 =?utf-8?B?Q01DR21CN2h1MEc3OFhwYTZhczk1RVRpNU9LRVArUWthSm14eDdFd21ZY2tz?=
 =?utf-8?B?ekNwYWMwNmRlVGtseUVJM2RQSVlVaEpuYlFtaVdWNURFS0pDdWtkM0FUaGRW?=
 =?utf-8?B?dnI3UnF3UWVUN3NYU0JhaklXY1VpbERWVkJndEdVS2FUMnZSb1Q4b2NTRzdh?=
 =?utf-8?B?WHdhQkFEMWo2V1MxQWl0OGhmVzV2MDVsQVVjVUhlWWNoSi9RZDM4SW8xK0lL?=
 =?utf-8?B?SFkzZmRsckQxeGRVcys1R3hJR1J0ZDBYSTBZREJRdzl1NFovS1JneThpRlY0?=
 =?utf-8?B?dW0wamNobXk5Z3RzK1hBaEMrL0p6OU5TMDVZcjI1NGdMcWoxWnM1Z3k1bkJn?=
 =?utf-8?B?Q3Nsb0VheDZScUhoSE5NcjRsYUtCT0dRRnBSMGY5ZmVrbkwxeU9iemxlT3pJ?=
 =?utf-8?B?RnB3K0c4V3U1RWxJMnpKK09FeEg5aGhDc3pMaGJJdmpJQVVCVUJ4TzJZSHpH?=
 =?utf-8?B?T1Nua1lwSHV2bG1jaDh1dnVjYWRSRGwyS2VESlBZeDlLUnI1UjJqbytyRGVL?=
 =?utf-8?B?RzFkMzVMVTJqVExIU213WStxKzhWZGRyS0xtSTVSNWFLUXlldm1RUWlSSmdJ?=
 =?utf-8?B?TkdjSGF4bzNzSjNRVnhZWElxQmtzWFh3bC8yWVJGMGFHVzlyUDJSb0IyNEJX?=
 =?utf-8?B?OXZCeGxOUHBlSk1aM3ZLZ1lMOUF0ZnRlQTRlTk9hTHdCWW1BUUF1VlY4dlNY?=
 =?utf-8?B?RTQ5clByd3pBczBhVk1CelJ3NnkxMkdEMHQ5Vis2NW82NjVYeDdnbjV4ZWQ2?=
 =?utf-8?B?ZWlqMVNhZEg3T0t4eWV4amFwRTF5R1ZNM0plbDZ0bUNuNnVuWW1HSmh0YzhW?=
 =?utf-8?B?MTNsVlplVk51aWplV0d1QWJLcmxadlIrRHlYL1BET3VkV3hWNDNiUHNlRWVr?=
 =?utf-8?B?bHpRaXF3Y05BV1ZNcCtNZEVCZ21OMFhmUnE0SzY1b0tnamY2QU1CaDY0U0RQ?=
 =?utf-8?B?aFBPaWQwNXNUcC9KNWc0SElLcWxMZUliV01TdzA3SUNwYjE0dEFhWnJnbmVq?=
 =?utf-8?B?WkhkNDBGMk44bGJCTEU1dktSd1FTdVp6UU85MW5GQ2pjdWU4ZUVtN2dCU1Zx?=
 =?utf-8?B?WWxkWCtVbUM4R0VpTkZtL09wTXlMUFcvRTJPckJFQWgwV1pRTkc1SC9RNWNW?=
 =?utf-8?B?SW9odmdPTEdEMWt6YUI0cVpXaWJBS3ZQU2NUNHVmOUxuQ3dWenJkRllBYmFt?=
 =?utf-8?Q?DnRI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f44aa79-3f73-44a9-a9ea-08dd5b44f99d
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 17:49:56.1338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BEW+9EFM0zWODpGuJLs7jv9Kishisi60Hb2vUaIqi+4zerz0p9Vm+R4ZTZk3WW8vlnm4CdAfsnwvLIcrYTt/uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10504

This patches basic on
https://lore.kernel.org/imx/20250128-pci_fixup_addr-v9-0-3c4bb506f665@nxp.com/

I have not hardware to test and there are not axis,artpec7-pcie in kernel
tree.

Look for driver owner, who help test this and start move forward to remove
cpu_addr_fixup() work.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (2):
      ARM: dts: artpec6: Move PCIe nodes under bus@c0000000
      PCI: artpec6: Use use_parent_dt_ranges and clean up artpec6_pcie_cpu_addr_fixup()

 arch/arm/boot/dts/axis/artpec6.dtsi       | 92 +++++++++++++++++--------------
 drivers/pci/controller/dwc/pcie-artpec6.c | 20 +------
 2 files changed, 52 insertions(+), 60 deletions(-)
---
base-commit: 1552be4855dacca5ea39b15b1ef0b96c91dbea0d
change-id: 20250304-axis-6d12970976b4

Best regards,
---
Frank Li <Frank.Li@nxp.com>


