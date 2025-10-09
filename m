Return-Path: <linux-pci+bounces-37777-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 930C2BCAD8F
	for <lists+linux-pci@lfdr.de>; Thu, 09 Oct 2025 22:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 17C0E3549C0
	for <lists+linux-pci@lfdr.de>; Thu,  9 Oct 2025 20:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E23B277016;
	Thu,  9 Oct 2025 20:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mxxjrPg5"
X-Original-To: linux-pci@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013013.outbound.protection.outlook.com [40.107.162.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE38C2765CD;
	Thu,  9 Oct 2025 20:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760043309; cv=fail; b=C8EKTeg4Z7IRoCzK3/N4nG1AT+1fg+XwutYEiRfoAY1B0gp8icac8tP5EzIpy+ZCrHEGS3xMqRw4vJsIy3N0UGBv60ji4IekkNwHxwU3sTugVcqFlAdJSTrhkV8/aoKclOoc4iSUeIZzDfDVVoUdMT55NNb0bYz0Ez6UENfwIHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760043309; c=relaxed/simple;
	bh=uuWJTyw995bIGlgoLpOyEfFcEHk+Dn9is5g61+XdMWc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=TEdC2bJ6zexmAUByRMwesLc88kezwHLABX/PySnSjMgENbEnp3KMIzDHEWbw6ZK+9KLVWZ4+A+1+eQhnFuuL4jMS84mQf91BrZg3Y82293GyrY0zST4isSAQLgSaVvS2FgBKunrIZHzAAEpwTh9IF6qdbPjXGNcFgibta1K0hL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mxxjrPg5; arc=fail smtp.client-ip=40.107.162.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SCiCg1xwakbgeue50f1paQ/QZat82a7fqh58qyTnmajDWdL7p0v267gZjno/IpgK9JgwLhmt9gtzIORkBWDwz9Naz3anqG7CL2qSemBOCL6BI+qtguQ91LosR+nZ8h5A8OMrjW490UqcRAhVgiMbBjmkGJiwuljv3fKODHQ1snmbpCn+7RARLvIZWaSjxC/3TMTwPQ7nhzWnsckW5/FuE3uDchAZD9vB7l9r0xUSKVVnqnDJO5QC4oIYeYNmbgnv2+ZkYo7Oj/DPYuiRTB7LhtNubd/mZ0F2iMF0h7G/bdVAc51FNqFjRJaT+OIQbvrgeCQPQRZEKYp02bLX6Gzj+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rzU9JICq+Qe7zYlVwBVK0h2pGRjAFccSsyhQbzao8Nw=;
 b=BMOhYkM5MRZAGeSAc0j0lEVF2B4k1ENE1Iv87t2tLlwZgZH7OLjGQsC+wckx3JqAhxtG1497e3ghuTAS2HvfUMv+uTqVqUOjjX352uxC0N7GnF2T6aQdX2vHYFC10Ogbclclzf0+nWROLUNYIv77MPRoTHbf5CPTtW57Mx9J6056KbG/8iFkBYhWeG3GS6J3SA+t8/lmnSWy+Bg3eJ6OHBXuKuGUXdN67EK3P4jgWjU+bYMSgO+bNGOc0TkLgeuzmJS7TmG3prGDnRu6CgieNme513LYK0cAqZxWLZu89frLFrdIFcNhjaJ8AAUOnvHOIhFiNqKqC9XhRUdcR+1ZPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rzU9JICq+Qe7zYlVwBVK0h2pGRjAFccSsyhQbzao8Nw=;
 b=mxxjrPg58X6oPvo/XaONfA8skk6duqQGQEFeuCHoq6i1rdzsG5y1d1J0vqwjLRdYMKJE2XjIdTG+41nGryMAo0dOQ7LlBRmkJ4dv37JTKTakjfFjxSER96UfMb0UHt/CoNvWAqw9AWHxpOeTsYN11JDFQtxqK58xXQIZZZG9uwOuk+EQDrRq4Bi7Czu9Wc55MgYLo+733xkbDhpQrLKFFtO9TTSYbfMYfj+yDTWZyhA3J/8KWqJvh5giPCMWCuKKfE9ghWIO/Aef9C9K5Hb9e8KRuPBh4Fh58ch9ZF5RiapQcOZdJ8V/1WGLdh2lxUl0UNt57bZ/wFe9Bn3z9jdRuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by VI1PR04MB9906.eurprd04.prod.outlook.com (2603:10a6:800:1e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Thu, 9 Oct
 2025 20:55:04 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9203.007; Thu, 9 Oct 2025
 20:55:04 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 09 Oct 2025 16:54:37 -0400
Subject: [PATCH v5 3/4] PCI: endpoint: Add API pci_epf_assign_bar_space()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251009-vntb_msi_doorbell-v5-3-4cfb7b6c4be1@nxp.com>
References: <20251009-vntb_msi_doorbell-v5-0-4cfb7b6c4be1@nxp.com>
In-Reply-To: <20251009-vntb_msi_doorbell-v5-0-4cfb7b6c4be1@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Jon Mason <jdmason@kudzu.us>, 
 Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 ntb@lists.linux.dev, imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760043291; l=4979;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=uuWJTyw995bIGlgoLpOyEfFcEHk+Dn9is5g61+XdMWc=;
 b=RK+1u8ducrH80hfRx2m8EY87VLamggbmPmo651TFrOpKPZ4YYH0pBEqymvvahHFZyNPtDBMNe
 zvEysHJH3P3ActiguCi9SnlIaB6vMA0T5l94f9eMnl0/cBGAzbCcPLt
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
X-MS-Office365-Filtering-Correlation-Id: 5356c982-6370-4d50-1bec-08de07761e6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|366016|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SlRRNDFEMUNiMFVqQ1RyN250QlVYb0htTldZQWh6MjBwMGdGeWdCWTVhOEp6?=
 =?utf-8?B?dDQ0WmRpbXZQVWdYNGRrZXc3VEVwU0wvNVpiRjN4SldQY1p2UGI1VUxzc3Bw?=
 =?utf-8?B?MVhjWGltREx5c3lHTjVvVG9vNmlZekVPUjZRWHFjQ2h5WUZOQ29IVTg3KzJq?=
 =?utf-8?B?cTM3Tjg5MnIyOTJrd0ZERk1NNlJiZVplbThLRVY1eFpCcXBEZTU0cExYWTFZ?=
 =?utf-8?B?ckFUcUlkc3NVRGtmS1hqaDhweVVXcGZGbUhicGVnVWRqN2tNYVJqaHlpMW5H?=
 =?utf-8?B?YnpCNjdFOHdVZmcvOHlnVkpWUDBHQ0M5RzJlQmp3c3pqQ0ZIbk1BbGQ4OHFJ?=
 =?utf-8?B?QytxKzF4L0hBcldMVURZc0hORStRWmpmcEFDYVZwRHdQWmNqK0dVbFc5bndO?=
 =?utf-8?B?OVd4Vk5oZ3o5R3g2THlSSmc5WTFWdXFyaHFiNWFzSUxmREltQ0dhNmx1ZkV2?=
 =?utf-8?B?S2NBeFFRM2pQYXoyRGE0YU84Yko1ODhaOU9VTklwRkVFRGdhcVVDalZ6TjJ4?=
 =?utf-8?B?UnVtc2MrV1VURU5xbGdxY205L3FRSXd4V2JsNGFNSWJPSUF5WWxrSGE1TE8v?=
 =?utf-8?B?S3JDZEFsUkJwN1BiVjdpMTZ2WjB3dnRjZVNINzJVTHlVN2VwbEpMdFZ2QUxB?=
 =?utf-8?B?R0NsKzY3MDBuaUIzQ3NDVm1RQlkyYmdIenNmQkpEOWF0SjhwMjBsWDZob21n?=
 =?utf-8?B?Ni9uOWE4R2JtN2xKZUpHSUNSaEVlSHI5elhUQlJiOXEwM2ZhbDhvZjRJMU1l?=
 =?utf-8?B?bVY2OWI2NHVoZHZ6TW0vWUtaR3NJRHQ1U295aDJkMVFHNEQrQU9IK0V6clB0?=
 =?utf-8?B?SVRGOE5VeVRMNVhFSTR4Z2tMSHVuSmxVUWxxaURJZXdxNktHK0VMUjVFU2d0?=
 =?utf-8?B?MUVOR2hZK21yM2t2OUVRcFBrSldySGIrRC9lUCtrR3NxL1REcnhVNGxodHpI?=
 =?utf-8?B?MzF2a2ZLZnFQdXZIM3AwSkMzb3pjQmw1djJYVFdpYUZzUXYrS3g5MkZJRDAy?=
 =?utf-8?B?KzVMK05YTmlnOEV4dUw0OWppZkIrTW5DcFV2WW56MFVsSGMrWWZleHFsTkl2?=
 =?utf-8?B?R2JkWlZ6YVVjd3BNRkNGUUZjdldMQUVDOFdFZ1F2UFljVmdVUGhiak1sVnRD?=
 =?utf-8?B?ekxZUloxcDVoSjE4YURJSzdCbjdPU0oyWVB5YUh2SkFPUENoWXdFRzFaeG1B?=
 =?utf-8?B?UGtMZjYzSmhGNkZLajQvZ0ZOcWRvUGl3YkpoV0NqWUJTQmNIa20wOFVNY0g3?=
 =?utf-8?B?MEx5YzlPdVJ0SGtDYTlqQlVEdkgreG51QitHRkxaOGtzcXNNcDBHL2YzSkNJ?=
 =?utf-8?B?aUNsSy93aWptNWhBNFkxeldyWWlDYm0zak8rR1BHWFVveTEwQUN2bTdMM2s3?=
 =?utf-8?B?enZFKzJkVjRYZmozcWNxYy9HdTNCQXIyRkFCcDhnL0hvMTR1N05sQk5tNFpQ?=
 =?utf-8?B?dGlEdzNLdHJpcng3bE9DQkVpVUJzNXlkSHFjUWQ5UldsQVpQcnlnRzAyT01N?=
 =?utf-8?B?ckR4ZVdxZkFNK3FNemhqZW94TkJIMTlITHMyWjRkVlhwNHZ0d3NGY3NDRXpm?=
 =?utf-8?B?OGdmdFVscjdoUE11NjNqRWMwNVdIU1Z4czlKc1JvbEd5WmsvTGQ4a0FxbTJL?=
 =?utf-8?B?S1dyNjMwWkR0bW5jUWU1emZ1bFRsQUJqRUFkRU5Rajkzb1duQkJiZ0dWeGRt?=
 =?utf-8?B?TXZFekhTOTF1c0VZVVkrdlZTejFadEVxOEF1L2gwM2ZVOXZ1bXEzNzlrZ2FI?=
 =?utf-8?B?dWlObVYveVpaRjBETXIvNEhmbi90T0J5cFV3QTVFVDhsSHlnZTJld1NXY1BL?=
 =?utf-8?B?VTJYZDFVRDR6N1ZZQ3hISmN4MHo4TmY1NzdWQUoyUFlIWjdUdmx3RDY4aGZG?=
 =?utf-8?B?WUY4NlBUQ0dyM3JEU1VmdUtDNHBDR1VYY1B3ejlqcXVSakRTd2Q4cWNHdFhi?=
 =?utf-8?B?OUhQZTQrYVpXV1FUQ045eXE5dGtTYm43ZUdnbEg4ZCsyUE9vS3ptcWlFMnRi?=
 =?utf-8?B?eU9iZXcxWnBiczVpWDJVeVJGM3k0WWJuNVlJZlEvMm1yL1pMWTJYb2h3V052?=
 =?utf-8?Q?OQ/o+i?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ejBkYlBVSWZMbWlvWUU5WVpTNVpLemtjQUpVdDBxY2JSdCtwRTNIWThDanNN?=
 =?utf-8?B?aEpnNnRHcEdzVGZ4aEthem9DV3VLVWpFOUxqZ05ZcWt3Um8yN291R1R3VWZF?=
 =?utf-8?B?KzEwR1NQUE51L0JaSXNRYlRHN2M3bXE2ZVVOVk9HYjVFZ2FPdm84bFZ2R3NQ?=
 =?utf-8?B?ZmRoSzRaVDdYOTRRSnJibzhXZkR3REo0NTVWTnF6SFZOS2YxbVRwak9nbXhC?=
 =?utf-8?B?YytuelZHZ0JEaFYwTzFYZkgwb0lmR2hjbXdIbGs0MTNIUnlnYzdyeUU3UzZG?=
 =?utf-8?B?SEhGb0FQcWtpMkJoODR3ZUNvcEVMcG4vV25Pb1ZQS2hEcUg1UHoyMzZJR2JN?=
 =?utf-8?B?QzJvc3RIZG9ER2JudHBrak1pdGN3UGwwUVMrTFVNU1ZEd1hRWFZqVzg1NnBG?=
 =?utf-8?B?RFZWT1pvckk1Z1JWdXphVlNCeTVvTGxTNmVVNi8xRytPQnZVdHZKczUzakpJ?=
 =?utf-8?B?YkJZcWxKTG9tMmxiVE5TK0ViTmd1N0hrWEQvYlhhODFPR3k2YmdRQURhdnNI?=
 =?utf-8?B?eG8yMVZxekk2VGhDY3hRRUZEOVVaQmNwa2k5anBvT2xobGt3RjcycERLdVI0?=
 =?utf-8?B?L1FzQXplSUtBRU5hM2Z0NDJycVhwalZPdnNRcXI2V3FsR3lzQ3M5VmJ5c1dx?=
 =?utf-8?B?TUx5QnYxR0lwRVdQT3dnM3JTQldDOGlJY0N5c0pMSTFLbFlaRlBvTG1tdm5y?=
 =?utf-8?B?d3UyVVVZTFd6ZUNYZ2ZiQkZjQ2FIWUJKSXZUOFdra2dCVEROTEY4VFlxdUtt?=
 =?utf-8?B?bzhzUTFvZlQydFpXd0M5SHdBdG1FWkt2SUJVUkVvYXlYUHJGV1JObHhTMkwz?=
 =?utf-8?B?dXc4L3NBVWdPaXVsZkc4cnJsL0Iwczh0dG45TmVncTNTbjVzSmg5SXMzQUNa?=
 =?utf-8?B?OVVuUlc0aldRV2tFRDFLV0taUmt0M3JvVk56bnJQNVh1UWlvaEJzS1k2eGdi?=
 =?utf-8?B?VnNzYnd2eGY1Ym9WMWpudWFVa2lhZDBVNVhna0c2MXNhN1JNcTZSUjdIM2l0?=
 =?utf-8?B?eEVoK0JkMWExWEdmQy9VZkxrV2ZBRFlJUERJVmF4SWZMaUJJd1hYZEEvODZz?=
 =?utf-8?B?ZzhIRFJJMnJyL3BlL3NTMXV1Mlg5OFIvbmZOcUd2blhsVXhLRDB2UFBRamFU?=
 =?utf-8?B?U2xJTStvU2RoMWsxem5MREJQU3hlSjc0THpwaTU5djN1WGd4SE83N2ZGbHhi?=
 =?utf-8?B?TGVSWjk3ZWFCZUFGMEc2UGNIUEs0bzJyeTQwSk9kemRBODM0TUJCY01uTzZT?=
 =?utf-8?B?NFdoOXFHR0lRRzA2Y2tqR1U4MWd3S0tqa3VpWSt2L2tYN24xa2NlSU9BWFVp?=
 =?utf-8?B?N1o2UkZxQmtycFJNRkF5WW0ydC9Ca0hQT282Q3NUeGNPNGNnaUtnbm13bEln?=
 =?utf-8?B?Z29ya2tLMUhwS2IxeHhrYzhFQ01yazIvdzkvTmI0eUFBblVVeEtjTjJuSHc5?=
 =?utf-8?B?aDFNb2M4eUF3Yk9OWGVtR1pGNXRjZ3hIbzEyWm5UQlNHbHBaZUlDY1dCcVdN?=
 =?utf-8?B?OWpvNUV0UDVSUVBVbnJYcmp1cHI3NzlzMWxTSHFqbjBQWGtHeGIxUlhvOW0z?=
 =?utf-8?B?bVhCaVdkd0R2c29idFJudU5tQ3AxMGJWaXA1eWpHek16NFV5TVNWUkE2THRL?=
 =?utf-8?B?NFFNbFV2djNiczNzY1B3WVJseWJCOUZINk9hd0hsZEpWODYxTndoeUd2YURw?=
 =?utf-8?B?OGcvZndSczM5OTR3dmxobFBBUTJVMDBPdWNMWlBIWXhSOUlvRmR2ZTAwZ0FF?=
 =?utf-8?B?MHpxOVErNzV3NGFoQWhyMm1sRUdxVjdrVVlzTnp6ZnhrY05iVU9oMHo3UXNq?=
 =?utf-8?B?QkhZMk12K2lmeTUrR0Q1UlNlQ2xtQXhNcDQ4T0JRNEJPN0J6VXhjOXZJL2VD?=
 =?utf-8?B?dzRadjE3bENyZFV0VUc3eFNDV3dSS0ZuU2VVS3lCVEpNMWZ5ZVFiandYVldX?=
 =?utf-8?B?SjU4eXpQU0xadU5aaDZ1bXdWbEhTOE9jdWxOdHRiWHBiU01xYlo0M3VxZHVT?=
 =?utf-8?B?YTJHaWxIZGRKQlVVaCtqUGRoQWxBdGl1YjBNM1haM3ZvblFJMTBaVVdrNTVD?=
 =?utf-8?B?cnNLQS9ienhZM1p1UUFuRERKS3ZYOVp5RCs1RzRjd0JHdk5PRVQydmxCTTAv?=
 =?utf-8?Q?tlBC2oMM7dTkJy2judvEHYZvE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5356c982-6370-4d50-1bec-08de07761e6c
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 20:55:04.0711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TXHj2/9Sc05QH1eKIZ4Cc+p2uhAjiV0Us9XMreciSgh1xjkssLkh14v1aHeH6Ss1Tc/IrkIjTBtMHJVIAogt2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9906

Add pci_epf_assign_bar_space() to allow setting any physical address as
inbound memory space, such as an MSI message base address.

Since PCI BAR size must be a power of two, the input MMIO range
[inbound_addr, inbound_addr + size) is mapped by finding n such that
[base, base + 2^n) covers the range. The base address is also required
to be aligned to 2^n.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v5
- use bar_addr in head file to align function define

change in v4
- use size for bar size.

chagne in v3.
- update function name to pci_epf_assign_bar_space()
- s/allocated/assigned/
- add check when align down input address to memory align require, may not
bar's size can't cover required ragion.

change in v2
- add new API pci_epf_set_inbound_space()
- fix bits 8 * size_of(dma_addr_t);
---
 drivers/pci/endpoint/pci-epf-core.c | 80 +++++++++++++++++++++++++++++++++++++
 include/linux/pci-epf.h             |  6 +++
 2 files changed, 86 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 38c4fd06e9693ceaa0c86f67090faa6e390425e1..1c64d69556e6c7c4841ef8a60866515a1f68333b 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -347,6 +347,86 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 }
 EXPORT_SYMBOL_GPL(pci_epf_alloc_space);
 
+/**
+ * pci_epf_assign_bar_space() - Assign PCI EPF BAR space
+ * @epf: the EPF device to whom allocate the memory
+ * @size: the size of the memory that has to be assigned
+ * @bar: the BAR number corresponding to the assigned register space
+ * @epc_features: the features provided by the EPC specific to this EPF
+ * @type: Identifies if the assignment is for primary EPC or secondary EPC
+ * @bar_addr: Address to be assigned for the @bar
+ *
+ * Invoke to assigned memory for the PCI EPF register space.
+ * Flag PCI_BASE_ADDRESS_MEM_TYPE_64 will automatically get set if the BAR
+ * can only be a 64-bit BAR, or if the requested size is larger than 2 GB.
+ */
+int pci_epf_assign_bar_space(struct pci_epf *epf, size_t size,
+			     enum pci_barno bar,
+			     const struct pci_epc_features *epc_features,
+			     enum pci_epc_interface_type type,
+			     dma_addr_t bar_addr)
+{
+	size_t bar_size, aligned_mem_size;
+	struct pci_epf_bar *epf_bar;
+	struct pci_epc *epc;
+	dma_addr_t limit;
+	int pos;
+
+	if (!size)
+		return -EINVAL;
+
+	limit = bar_addr + size - 1;
+
+	/*
+	 *  Bits:		15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0
+	 *  bar_addr:		U  U  U  U  U  U  0 X X X X X X X X X
+	 *  limit:		U  U  U  U  U  U  1 X X X X X X X X X
+	 *
+	 *  U means address bits have not change in Range [bar_addr, limit]
+	 *  X means bit 0 or 1.
+	 *
+	 *  bar_addr^limit	0  0  0  0  0  0  1 X X X X X X X X X
+	 *  Find first bit 1 pos from MSB, 2 ^ pos windows will cover
+	 *  [bar_Addr, limit] range.
+	 */
+	for (pos = 8 * sizeof(dma_addr_t) - 1; pos > 0; pos--)
+		if ((limit ^ bar_addr) & BIT_ULL(pos))
+			break;
+
+	if (pos == 8 * sizeof(dma_addr_t) - 1)
+		return -EINVAL;
+
+	bar_size = BIT_ULL(pos + 1);
+	if (pci_epf_get_bar_required_size(epf, &bar_size, &aligned_mem_size,
+					  bar, epc_features, type))
+		return -ENOMEM;
+
+	if (type == PRIMARY_INTERFACE) {
+		epc = epf->epc;
+		epf_bar = epf->bar;
+	} else {
+		epc = epf->sec_epc;
+		epf_bar = epf->sec_epc_bar;
+	}
+
+	epf_bar[bar].phys_addr = ALIGN_DOWN(bar_addr, aligned_mem_size);
+
+	if (epf_bar[bar].phys_addr + bar_size < limit)
+		return -ENOMEM;
+
+	epf_bar[bar].addr = NULL;
+	epf_bar[bar].size = bar_size;
+	epf_bar[bar].mem_size = aligned_mem_size;
+	epf_bar[bar].barno = bar;
+	if (upper_32_bits(size) || epc_features->bar[bar].only_64bit)
+		epf_bar[bar].flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;
+	else
+		epf_bar[bar].flags |= PCI_BASE_ADDRESS_MEM_TYPE_32;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_epf_assign_bar_space);
+
 static void pci_epf_remove_cfs(struct pci_epf_driver *driver)
 {
 	struct config_group *group, *tmp;
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 4022dd080e20f2959f3a5faf4cfe054ddb5856a7..48f68c4dcfa5e2e3bb97963c6b0f47effe87f53b 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -242,6 +242,12 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
 			enum pci_epc_interface_type type);
 
+int pci_epf_assign_bar_space(struct pci_epf *epf, size_t size,
+			     enum pci_barno bar,
+			     const struct pci_epc_features *epc_features,
+			     enum pci_epc_interface_type type,
+			     dma_addr_t bar_addr);
+
 int pci_epf_align_inbound_addr(struct pci_epf *epf, enum pci_barno bar,
 			       u64 addr, dma_addr_t *base, size_t *off);
 int pci_epf_bind(struct pci_epf *epf);

-- 
2.34.1


