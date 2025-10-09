Return-Path: <linux-pci+bounces-37774-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4BABCAD6E
	for <lists+linux-pci@lfdr.de>; Thu, 09 Oct 2025 22:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C07873B1990
	for <lists+linux-pci@lfdr.de>; Thu,  9 Oct 2025 20:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1432B2741A0;
	Thu,  9 Oct 2025 20:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QTDVvun2"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010058.outbound.protection.outlook.com [52.101.69.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624B723D7DE;
	Thu,  9 Oct 2025 20:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760043300; cv=fail; b=KqvznTwYUDG1WF05nUn4AqXAD79zGsUNYeOQeJP/7/kMh+q++W62fg1N+ATimTYNEUX79hT/0yX0dPpxGKWhILtUhzSMd1K3TWbZDtzovaJ5DFuxVsUfm89Shc4HE2Ri7ogm3GRn3BLq3eOFp+jyl0UYTY7lmwp+M7uCfDd94lY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760043300; c=relaxed/simple;
	bh=AxwOQzwQHasw/KZscMX37TiLSge2242d5l69/5Q4OIk=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=r9hop4BN8VMyDNc3o9/Vtwia1aN143sXtqKFLkMW3YHsvS2Q2/3zhHaK7B1zhdMMQdQMEIRUG+OyOYMNYVTdH0OSa+5xgghJWZJ3gVmYn8sIeRNvOoG8ACZBJZlZCd3e3r7zB588MNOij7RoKEEN2s2VMC9sqDcglHlFJ6L3l8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QTDVvun2; arc=fail smtp.client-ip=52.101.69.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YGbVObIu0S1E/egP7Xdcxst3d6WbVzqGTeh7p8dQXWtt9Ryu8vt73Dm+DlpPTsJjFYKXXcFamjZVt9PqJj5vSO9lPciblD3097sCyPE3InPKfcE7/L7OVuMOQYNt+fvHdgY3TbmRsLAvR8b5zosT96H2TZUZuTDdZ7XGZ753hGCPUZm1WoADZmDnjGmOiT0DED1TOxdwolswj+ISDhBjcb5ghhwKt3cUngcqa+FkVR9ELsQCrbP41qAsAoKIrpwWPvIQrSrwg97Mv90iQsRjfGcbpoBaURdzBwB76xcNgTbQcToFi1k8DC+ncooET8pXvjONFshIotBRZxDZcUKB6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dRW8shH2GhXg8vKWnFtAivqdBP9fRXqclm0Cka+zhig=;
 b=jIi+1n1qEsyY+mUl32MF+6sP6duCpe0lbNdat6W23sxPR38v4iaBqpjAtDspceMuw7apacjY8+ZVXafSzzvaH1MqKzJP7rzOjUmUedRyYcJLrE+CM7rC0k9KauImcod2Fvoi0AVW07UuR4t43AEHgIbrbgs0SN9/wztAg8nPJXvhAtPa1dmp8Ry3eFzEbC5J1Fu3+vb6mEilFK12BY4DxUNJS4RXyz6W+W0ZbwC1RlHe7a00oJYB7AxCVFaTJ/I8k4mS8aGXgMj6IOriLI/Hy2tqgwy6agKs5Tz+43vFAXoe0YzYKnXwAzcV9ND8B+m6L1U3CApTxXFVvOpgbRepYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dRW8shH2GhXg8vKWnFtAivqdBP9fRXqclm0Cka+zhig=;
 b=QTDVvun2jBoGkagK2sdZlfNvENMmDn3ZROikFiLIfH0iTn6ZSl0RQOORxlM3aRE6/6h0xEs4/0SJR4geiK2AAxJHWMjHPoTqZOsAlNzLNAKsfjaU4+86JWLZP/Fe15zcxOA9oYAzTtMel2A1W/oqSxHNfWBLkLzY8PA9LotBylvMvyAg4+lbtIhPkz5vXIHsCc/+LGEmjAEkXwxM7kJVhA7C8JeZTgVn8CQ+rR566/Q6hMVTEKC1XGUkDcoEHByGrc3FkkJBDHsRgt71m1g4YCtmvx9Zvxyid63jOLQBWCaK/j+9cZEqIp/z0nul+BwvSfudxEGjjKw+p8xp7ZVrOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by VI1PR04MB9906.eurprd04.prod.outlook.com (2603:10a6:800:1e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Thu, 9 Oct
 2025 20:54:54 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9203.007; Thu, 9 Oct 2025
 20:54:54 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v5 0/4] pci: endpoint: vntb: add MSI doorbell support
Date: Thu, 09 Oct 2025 16:54:34 -0400
Message-Id: <20251009-vntb_msi_doorbell-v5-0-4cfb7b6c4be1@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAoh6GgC/23N0QoCIRCF4VcJrzPc0bW2q94jInQcS6h10ZAi9
 t2zINpgL8/A98+TZUqBMtsunixRCTnEvo52uWB4Nv2JeHB1MxDQik0DvPQ3e7zmcHQxJkuXC7d
 eeGtQO+3WrLohkQ/3T3N/qPsc8i2mx+dFad7Xb62dqZWGCy7BeY3K+k7jrr8PK4xX9m4V+Plu3
 kP1aNaNFi1JpdS/lxMPs15Wb0hYgZ1EY+jfq4mXYs6r6skAdgq19zDx4zi+AGIAU9pwAQAA
X-Change-ID: 20250812-vntb_msi_doorbell-bf0fbac6d6d7
To: Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Jon Mason <jdmason@kudzu.us>, 
 Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 ntb@lists.linux.dev, imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760043291; l=1793;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=AxwOQzwQHasw/KZscMX37TiLSge2242d5l69/5Q4OIk=;
 b=ihVEllmONiLuo71k+7S3UBKSzkcQyEWGG3btUllkPz/HTkFqQuYBh0InjSYt0r2UiqbKHrBmg
 hCrZbFQUe+FAZ8Zg8MY4EbLX7F4szxRXqWpqVL8VlWDBbw42c+eX3kq
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH5P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:34a::16) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|VI1PR04MB9906:EE_
X-MS-Office365-Filtering-Correlation-Id: 0220aa02-f2a2-473f-5609-08de07761904
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|366016|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MldBTC9obGo2czJRdkdISHVNSXArczFjVjM0eVcyaGM5eHJsRmFZUjNndlpw?=
 =?utf-8?B?S2FacytidktHVCs5cDhKSXF2ek5IeGtVZUQwN1lIR2FWM0UvUmJ1SnYrWnZC?=
 =?utf-8?B?VnNvRE9DS1lOci82UU1seFVrMEh4Vm9uZkYxZFJkZlB6TCtHNjNlT3JkMnR2?=
 =?utf-8?B?MFBlYldsbzkvZ1dTSkdxblZ4bnZ3RWc1dEo1ck1hb1FFU0NUQWsrZnFEeU5s?=
 =?utf-8?B?TThBQXVxK2dQOUJRb3BQYU9BVjVUSHRkSTI4bEo0NzVoSjNiV0luVStxRk82?=
 =?utf-8?B?TkppVTM3bnc5cUtCNVdyQ1RmM203NThIcCtzNG0yS1Q0dkxWbTlpeUN3YUNP?=
 =?utf-8?B?S09iaU5yRVZjUkpuUnFjMFhtZ1E4RVo4aEQ3MFlJRGU4VWRPTXZsTTAxRDZu?=
 =?utf-8?B?b1hkOC9RbUZyWGtzb0NjMmtMaVhtME10dXUrdTV2OVJDTW8zRWxBYW9pdEJm?=
 =?utf-8?B?RVFyS1N0M0JackxLT0NybVpicHZBNENnVW81ZXI5RWVnK1RFNWFYSUdCT2VB?=
 =?utf-8?B?WmFIVnZGRHlGZUlEOXZ2OXNOcFE2dzltZHkxYlpQdjI4VFk5TlNkWUU4MkRx?=
 =?utf-8?B?cmtUc2lBdnF4VE5BbEE3KzdRRmVzKzRtc2c4NU1GNXB3YXVldkxKVCsyT1Nw?=
 =?utf-8?B?SFBXYzd2TmowcHN2b0VQZHZmYVVTQk44ejk5K0poa1puS3VVMnJmY0MvdVlF?=
 =?utf-8?B?Z241b2FwRnJPMjQ3eVQycWFKTXY3OG9kd1RnMGljOFRBKzBUR3E1TW4xamtn?=
 =?utf-8?B?bzR2dk9nbVoxN2FWL0tDRWVuZU8yZnZ0aTc4clNPTkVZUDlIb0VmNlBUdTdB?=
 =?utf-8?B?TVZiSHRxOTg1WU5Ncnh4blhESjBtTkVDM1pZN2wwSlBnL2lUV3ppLzVNSFZu?=
 =?utf-8?B?MlNzRllJdE82N1BBVUU1K2htSHJ0ZHJWS1hZL1VBd1k1SWp3T1NUKzRMQk91?=
 =?utf-8?B?T09FNk15MTlsZEZ0MFcvUWxkeURQNXlXV1FqSHczUTM3eko3NXJRMDN2L0lO?=
 =?utf-8?B?c1RxNVAwdjhZeDd0cXJsREZjaDhXb29PVVBBYXdJOWNldjh2aU5kbmF0dmVo?=
 =?utf-8?B?V1B4REJoSU5Ba2VRV2F5NTlkUGZtZGdVTGFWQ3B1U0IyL2VLRnhvODZVeEp0?=
 =?utf-8?B?SGdqdHl5YU40ek1KRGM2Y1hqZHYzZi9lN3FINlRzQmNBSzI3UTRpcWlnQSt3?=
 =?utf-8?B?R0FnRlhNT1Y4UVhLd1R2SFhrazhZeU1MWng4U0hkTGRiVm9EVm1SblNSNjhZ?=
 =?utf-8?B?TWpnUUxmb0JUZ1lENmRaeWR3b2puQTVPTkFXdWdPUEJWaVFBZTN0MjE2a3l3?=
 =?utf-8?B?V2tzOFZ6ODJ2TVBBS1RwWU1wazNYVlJJb2xFZ2ZqR3hGOFRxNHR1SEw4MTky?=
 =?utf-8?B?OC9CemNPbUlZSmlHVS9XWUhzQlBZOTFPcGkybmpJbTdLa2RjR0VtVnJBVWho?=
 =?utf-8?B?NnFGWlorYVFMOEsvZXVIVzl2YlkvekorSjlKQVNqejRXcG54RzFoWTkzU2lX?=
 =?utf-8?B?WW1VMDQyM2tPWjQ3TUUveks5UXBQdmlmMHdXam1FeVVXc2ZvWHMyR1JlVi9r?=
 =?utf-8?B?SjcxeUN5SXJyZTlPcFk3ellEdE9jTTNMMEVmSjQ2NWtpZFkvWmhKVHJMay9Q?=
 =?utf-8?B?bUFoL3haeFNYNzFGMU9QS1FBamo4SVBObWRKTkJrRE51QVc1ZWtuNW1EcEgw?=
 =?utf-8?B?Zy8wVFRKdFFPRFdJOWNiUktxRkplUmk0bEVvUHJpamxteTh2aHhCaGlxMlVJ?=
 =?utf-8?B?T2U3MEs2M0JEY2JRckQweDBkQVRlNVI2ZExPZnM3dEhZRFFZRk5PTVZCOWhI?=
 =?utf-8?B?RGtOdHVuc2NtYjAxY0NackdrRXM3b09kc2g4dCt1K2xqUHkyT01JOTNpazBp?=
 =?utf-8?B?ZXFHSWtuNkpnYU55bXJzZHlieS9KcTMvb0FpU1FrSTBocTV6TGNpNzRheC9y?=
 =?utf-8?B?aGhHRTA0OXNwcmttZTRSY2tyRllGcnQwVVpxeGFrQm42cjhPUjRKb2RBRW8w?=
 =?utf-8?B?Z1gwVVg3aTAwajlMM29QQ0RPRFp1U0JjTzdoR2F0WkRwdVJUUDJOdkZ6UkJE?=
 =?utf-8?Q?KecCjv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VlhLNzdpdTJRQTZ2aGNTQnVLQTdVb3p0OFZSV1V0cGcwR1pMdlNVZklIQlBY?=
 =?utf-8?B?Rm5ySHQxaGhNT251a2RUTnpTcDVOK1IzYVZlSzlIWms1d0pMcWpiSjM1ZEpj?=
 =?utf-8?B?NXlyNUNsWXFCWndqMEhWcDdwWWlmUm9XVitnQkNaVWx2bGV4dnQyWXZTYms0?=
 =?utf-8?B?NWgyR2ZZUy8rT3A5aFg4YlhIdktOeW5UbjVIMkdaUXJYN1Y3engyWW9lc08v?=
 =?utf-8?B?bnk5TkdjQ1hjeDJWQ1pYeXd1Y1A5TXFwUHh1MnlZT0V4dGRrQ2dqYzBheW9o?=
 =?utf-8?B?ZVBXWE9aUGxGR2tYV1BPR0FZWmJwcmZ4eXZMRm41VUVxOEtVZ2NYVnJVc2Ev?=
 =?utf-8?B?dlBjbWZKQlFsL2hDM3BDbDhDbWFFVER0NjJXVEpDUytZcUlpRUNJalBRU2pB?=
 =?utf-8?B?SnR2NTljZFplQnZvL3VyQ1J4ckZERUlwUDlDakM0S1ZscFFrWEVmNHFIZm1o?=
 =?utf-8?B?b3VIa1g2MUx6Y3V3OU15L2thMDdBTVVMQUx2NlF1dWVhcWdVbGR5UWN4ajNC?=
 =?utf-8?B?UVJ1SC92QjBSZ2d1WFl5QlRUenovbHozQU8ycmxialRYWWhHaEVNR29PaElI?=
 =?utf-8?B?aCtMaGhKS3B1UlJyRllES08zNkQ3bkF3TWpIV3NqR2U0VjkvU0V6K3R6bHRE?=
 =?utf-8?B?QTJyWFJNcjRtMFdrQ3BCbm9POUNwN3grMVEzRXJNZnp0M1FYSmU4UWpZenI3?=
 =?utf-8?B?NkNjYkdxZWJjTXp0S0c1TkFoTkNtbjdPZ1BSUncrL013b1RuUFphaVJOY3FS?=
 =?utf-8?B?NEhLekpYRmlvVEk2MUZGN0ZLcE1QRkloMWNiYnU1cEtSTDh3RjlJL0JaTWhW?=
 =?utf-8?B?NXRteEMxZ09WYjArYUUyczN2MElyVENDYndQWkhpMUhsTzRLbVpJU2hrUEZy?=
 =?utf-8?B?Wlh1ZEZ1aVpXeFIvOTIrZER2cWt0c3R2M0J1RHNCclJVU052eGZnL3ovYWlx?=
 =?utf-8?B?ODFuMzJFaTIvTzJoVE5SOXRiUDZZM1FQRWV6UzhORnFnRFg0TnYveDhxV2ky?=
 =?utf-8?B?L0kwVGtuenNhSUxJVW1tVW1hZ3BrNndpbmQyOUJ4OEpzNG1TczVrYlYzdHps?=
 =?utf-8?B?SUkxVnRCL25XRzZsZHJBUXBaZmlCcSs3US9VWTB2SXkzakl5NFBCUXZBajgx?=
 =?utf-8?B?QmR1SlJOQUc3dE8renA4WFl5cU44SEFLSnh5K3B1eWpmVWNFeWlTWFF5VkYr?=
 =?utf-8?B?SFF1VWVTbzJ1M1RGVWkyUFJoSUdCY2s4TVR6dmlFdFd3Zkp1Vm93WWwrSllL?=
 =?utf-8?B?OVpQb2VBOE81Mm1yMDdsTUFpeVppWi9BN1FDUTFwWlYyc05abEg3ZlIva0R3?=
 =?utf-8?B?WUorNFlDaEdycEJ0MmMvYk1sd0RGU1h1Si9GeitZN3d3NkI1TWErUDFycjRo?=
 =?utf-8?B?c3M1MERlMmJYRkIvdVh6ck5YTkdvM2pkWHRpRmZrcVhJcXFFcFhJWDNvYThk?=
 =?utf-8?B?VE5FUXRHMHpITEVlTTRBT3EzMXlnMWV6aVlobGxXbSs1T2kwUnpQQVFuaHlt?=
 =?utf-8?B?aFppUWVXWVdubm8xdTlraTBkOUUwQXZFNzJRbWdpb3QxWXhRa0JzdFdCNmJh?=
 =?utf-8?B?THJjSkMxZExCY1ZHM3U1UHczUHgxU3hGaWNDUk5ZQlRZUjl2S3ppSEcrNFpK?=
 =?utf-8?B?cG5nTGViQmxja1dvU2FXbGMybEtlTVgybWwwZWQ2M1FjeGh1UjY4ay9MQWlH?=
 =?utf-8?B?SVloYUUyMzdiOVNod1daTFJDY3JQRU5iYUt5STRKNFhRWVVzR08vc295V2tQ?=
 =?utf-8?B?SC9HYmJmTkJMY1pPc2N2dUhJRTJXODg1MVBBc3F0ZVhUVEhPMDJRV3hqRVM0?=
 =?utf-8?B?Y2xtM05WZ2ZBWm9zUVI0TkNRcHBBWTcveFJVMnNnU3JWTERWY29IS2ZUN3Bu?=
 =?utf-8?B?SWxlTmduMXJ5bmhoVXhTRC95eWtpdFUxczJYVUxEdjg2OTdxQy8vTFYrSHkx?=
 =?utf-8?B?YVhlSlFMVmdiL0FWUGw0SitzbWdGelpLeEoweG9BWHUrWFdabjRaanR0ZmE4?=
 =?utf-8?B?Q1ZSalhrenplNFcwUzRWMCtwK2ZqVWxtektkOUNXVHc1VGlBaFYrcDlkVXpC?=
 =?utf-8?B?bXB1c1dYTG0yZ2FER0VhamJwK0FMTWpPQi96amtmWHY5aU5Xa2w2NHU4SlNq?=
 =?utf-8?Q?LuDkA5n+x4udYSMjJJo6tmar5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0220aa02-f2a2-473f-5609-08de07761904
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 20:54:54.2238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aS6lfaE5Hyn8mbGlvjLU67ddHYgIXVn2x/yEEH3C0j2eQJ5tBfKi8Ecjx27Jk+kqtkRPYEWbtM29NAVH61Qcxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9906

Since commit 1c3b002c6bf68 PCI: endpoint: Add RC-to-EP doorbell support
using platform MSI controller, PCI EP can get notification from Host.

VNTB use this feature to reduce ping latency.

The first patch impove epf core API to allow set any MMIO address to specfic
bar.

The second patch add MSI doorbell support.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v5:
- update atu field aligned_size to mem_size.
- Link to v4: https://lore.kernel.org/r/20250930-vntb_msi_doorbell-v4-0-ea2c94c6ff2e@nxp.com

Changes in v4:
- use 'bar_size' instead of aligned_bar_size
- Link to v3: https://lore.kernel.org/r/20250925-vntb_msi_doorbell-v3-0-ae0b0c93caae@nxp.com

Changes in v3:
- update function name to pci_epf_assign_bar_space()
- detail check each patch's change log
- Link to v2: https://lore.kernel.org/r/20250915-vntb_msi_doorbell-v2-0-ca71605e3444@nxp.com

Changes in v2:
- add help funciton to get bar's inbounce size
- fix miss x8 when caculate bits
- Link to v1: https://lore.kernel.org/r/20250815-vntb_msi_doorbell-v1-0-32df6c4bf96c@nxp.com

---
Frank Li (4):
      PCI: endpoint: Rename aligned_size to mem_size
      PCI: endpoint: Add helper function pci_epf_get_bar_required_size()
      PCI: endpoint: Add API pci_epf_assign_bar_space()
      PCI: endpoint: pci-epf-vntb: Add MSI doorbell support

 drivers/pci/endpoint/functions/pci-epf-vntb.c | 152 +++++++++++++++++++++---
 drivers/pci/endpoint/pci-epf-core.c           | 163 +++++++++++++++++++++-----
 include/linux/pci-epf.h                       |  12 +-
 3 files changed, 275 insertions(+), 52 deletions(-)
---
base-commit: c2a282d1fccc53a989da61a5da4f03c9d67ee99a
change-id: 20250812-vntb_msi_doorbell-bf0fbac6d6d7

Best regards,
--
Frank Li <Frank.Li@nxp.com>


