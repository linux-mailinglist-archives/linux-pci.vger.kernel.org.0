Return-Path: <linux-pci+bounces-17093-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA679D2EF8
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2024 20:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7034B257CF
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2024 19:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1F21D2B21;
	Tue, 19 Nov 2024 19:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="d6GB91o9"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2055.outbound.protection.outlook.com [40.107.21.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170801D2234;
	Tue, 19 Nov 2024 19:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732045483; cv=fail; b=qxBo/FJ2Z/YalxJPTJKtqU+BZpzmshgvWSbYecoMtFy0525MiAHT5ekQF9n6c6P9cvU/ReOJIF/4OvMgSCktKontyNTVuyOptq5u7dTjN9LqJihEyjXQGi1f74aheAUQTAtybtXICUlbrB6M2iw3eO32Jf+Z0pHWRItf3W+n5b0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732045483; c=relaxed/simple;
	bh=qjpUcIbnkk/T4kjU5qqs7K3xKeASfuBpjDR59WiM6kE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=K1j+xSa/mCIQuMPy1oVgMOvQRGTiwPK6zBID/Fyi72s/zH0BOuEgHxDvJw6xtHvVgPONb8d6rM3RZyTl8NrKlSaHhu4hLJIBtyhOkGex/EtgmPQ5bTYzdWSWqr9EROZGv7LDeaD5IRJV/bR0tU3qqBUhQmm4MwSLacTYVMWfDs8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=d6GB91o9; arc=fail smtp.client-ip=40.107.21.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pRmzvwnZUT8O+vyPmjpVFs09Bs9HE7Vvctgl4+vjQjtL/lr8iDdc8+/53MDiIY4p4T7AxpyJwA4E2WycDcrMjbC+Me973H7OQG+aaQjAzX0qhmt7sBGw3XJKZ4gTZRxclHryQ3eHIyxvjhBkHwO85WWwzbwWHrc2Zpq/wD0sGFFOKX03s9iNYySRwUwMUK+drIFjXNvTh3oXIMv1PQFuBzS1RvnmkWNjyjUjCxfE8IhRMRjU4Z6ttbxVM8oWqxR8nhn0SdrdiLYCTDljq6jckpxW9svtpp5WxyY/Sac81q4+CE/xZoyFWLoMGIn5UuAu/kBfLEM9F9ptC/31SH/SgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xbHBynal3pF/RegJFlo7IroGpXvPbJAYX+a27w56dGQ=;
 b=XLPpPn+REQDj1VmvNnnRodJLWQLLomflFJOzUT8BkWaA/uF/gB4FuvJqmHbu0JTcjRK/pcpbVgT9/+kHm43CVGEFZfk8IfoZwzvcWXXAlUSLiBCIe0wCYQ1gEPAJXEPiGJFtbcQaqiq5nC17cMgJuF7Dgo4Op+Szv5t8lUYXc23W+3LCcZXpAGGWEhs1/Dp6FqkvGcmBkz9VojKDBzGQUa6HTxOatiZjPrNAJQwWgZdLlk4RNY2nEdOpgkPKjIBR165SRwBeEWO9kvAUTy6+nNtM1ph/CNTJml74RUMcrwERbItLiQ3A5wTcjZ2EuaDU7U2GFyLU5M9Yt44omsmPKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xbHBynal3pF/RegJFlo7IroGpXvPbJAYX+a27w56dGQ=;
 b=d6GB91o9boo2gFLzpuaCFvPvZ6HJVnCGruBwjnUbABYHkSspL7SlmGoQC0W4vMIYP88R4O9NnYLvZGgjLMrDdse1hbHrCsCl6/fjpvGhwn/AAdDezBpehVIPeD+iN3A8FjAHiyKTdPfNGpIxncTktqQ9bAigbmxJt1Yr79v9sYK3zYINzB8+5Jvtt2iN6gDtVZXNb9ADtIgdWl4AAAeYq74zXrwvjyaxbIrQrnCb0m+tgMv1SSepLOUDDwVSIANtRRUbot1J5zJND0dKP+5lnrO5awljPwVEa8szUXMI1Fn5hlk9WFWoUnIyRXYz2IdETyLC8+2yOw6TTzk4F7TaEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB11068.eurprd04.prod.outlook.com (2603:10a6:150:215::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Tue, 19 Nov
 2024 19:44:38 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8158.021; Tue, 19 Nov 2024
 19:44:38 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 19 Nov 2024 14:44:19 -0500
Subject: [PATCH v8 1/7] of: address: Add parent_bus_addr to struct
 of_pci_range
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241119-pci_fixup_addr-v8-1-c4bfa5193288@nxp.com>
References: <20241119-pci_fixup_addr-v8-0-c4bfa5193288@nxp.com>
In-Reply-To: <20241119-pci_fixup_addr-v8-0-c4bfa5193288@nxp.com>
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
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732045469; l=4876;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=qjpUcIbnkk/T4kjU5qqs7K3xKeASfuBpjDR59WiM6kE=;
 b=iO4hrat6JoC6X9ncQ2MPC4tB19yUm0v3tRRt1J3qno05fE/u5aLA7nr42Ka7xwfmMHmVTaLIP
 P/T24/1OxQfA0ABYFLq2EzOx7gpVAW8Wn5iRPR1VUVEXC5VfpgqvnqH
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB11068:EE_
X-MS-Office365-Filtering-Correlation-Id: 0354921e-19d6-4ec2-4389-08dd08d29a94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?czIrZi9yTXR4Zk9iQnZ0NHpQSjRHNDJmNzBSOHFrWDA4WXc4UlhlQTZXR0Vw?=
 =?utf-8?B?c3dFdW4zckFxTFlSTXVWOGJVTGo5RCsrVmFWWFN0Z1E5bGd0c3AzY3ZDeXhZ?=
 =?utf-8?B?NkpkN01wcFVRemhoNllmV0VzR1d4Y1BkUDFKSWJzdjQvNzhyUjB2cndrRU1K?=
 =?utf-8?B?eXYrcWM5bnpoSXFJdEZGTFRyelFUaTZLT3Jib0xZWXZDbmsvMExmYnMwQ0Vu?=
 =?utf-8?B?WW1Qd0tGUVAxd0lMSGY4NlJsOFZtanh4Y0lPYWpqbkY1dG9RY0s0TUp5UDFP?=
 =?utf-8?B?NCtZWXAxblp3L1BTYXMvOGgrYWpqd3d4RC96ZzgrV0R1aURrNlB2VHhWU29k?=
 =?utf-8?B?cTlOZkYzSnNjd0gvdWVIdzZVUWp2clVaVG05cUVzelhkdm9DQnI1UXl3Q1J6?=
 =?utf-8?B?OFRFMkVBK0ZGSW5vajlQZjhHbW8rUjRqY2lNVDN1V3ZhZ0VLZmlIRytuVis3?=
 =?utf-8?B?K1lJNTZqSzAwUUlWL1c3RVVIdnJpb2IxWVRoUVRGTE5ERFVsZlk5Uk5BRDVn?=
 =?utf-8?B?aGMxQ1VGUEVKVlZxYzRKdjE2Nkw1dHJuMzJmeDJpVk1WUDdDOVlIMjJrR25k?=
 =?utf-8?B?SHpma3BKY3d6Q1pJQ3FIWXJMR3F0cTJSazY4cVdIcm9aWmNIUWUwY3loZ2ND?=
 =?utf-8?B?MG00Q0xybkpiY2xYTjM1b0hta1JnZU1tQkkydDdYMXN2MDZsZ0l2WHpVSkly?=
 =?utf-8?B?bnVhUlU0dUVQU1RTRUlsaGV2MjFDK1VXc3JrSGtwZDdLbGpUTFZFZlpMbkdC?=
 =?utf-8?B?ckk4TG05bHlmN1MvOVRtaElpa2JPaWhVU0MxU28weHNFbkUzaFE5eU1odi8z?=
 =?utf-8?B?UDVqb2pSN2FXZHluUlUrOWlFeGFkbitBeFVYTXBLY0tDYXVKSCs5WVF2blcv?=
 =?utf-8?B?V09WdUp1L1JIdWtrbGJVSkgza1NyUzBuNHE0L0NkTVZQTEpxOTRybnFBZVpq?=
 =?utf-8?B?TzNKUFJwREhEcjJQeUNPZUp1K2ppdXNXbS8xbE9PcWh5OVdwMm4vL0dmc282?=
 =?utf-8?B?R1pUQmlHRkhEM1Y4TzBhdHJUY21MdmtRYVQ4Y1B2WWllTmpXZSs4NlpLOS9t?=
 =?utf-8?B?R0RlNnQ2NmUxdi9razUzcEszMlp2OW5lK0FYMnV0ZlFBbDJoaUVheTJCcGRP?=
 =?utf-8?B?YTNRbXBVMTd5Wkc1MXE1YmZmNDZrd2RHVGk2WHRncnNVTU1zVGFOUWxFaC9x?=
 =?utf-8?B?THo3MG95ZGk0cXpYdHhQck1WaTV6TVNpWDNvMERrMWUyV2ZkM05ZM3ppdU93?=
 =?utf-8?B?WS9lM0pGZmdZYkRQNnNPU005N2JmSVhXVTcrQUh5NHVVV2p4NWZvSFEyK3dR?=
 =?utf-8?B?dGdpbjlHNEZpV29nekQ0UlhHT2VhNkhRSVJNT1BOSW9XZ2ZDbW5HZGFzaTg5?=
 =?utf-8?B?bmFNNnJqOEw5NG8rbkkrYTdmSmRJSFA1Mjk0QjZLYWIwQ1JWTkZFOUIvNnc2?=
 =?utf-8?B?MEg5S2hnNVBYeGxsMGQrUklyVnkxMFFKcURVNWdROXdwajgxd0VmTU9jY2Zv?=
 =?utf-8?B?Tm4zSnN0RG1NUHRCNmg4a2kzc1M2SzR1RnBKMC9mZVpyYWRPUkVsMGNLYWVI?=
 =?utf-8?B?VE5yRitkT3laYlp2aTk4N0R3clhXS3dwZURpZ0dVWEVGYkk1eSsxcTVMVzZh?=
 =?utf-8?B?ZzBBN0VTSXY1Wi85WU1kU0IzUDI2MFMwOFkyd0d0c3U3ZkEwaGNlbUhWTEhG?=
 =?utf-8?B?d3gyakZHVmpMKzU4MTB3L2Z4TWRiRUVGQXR6RnBjU0dpMXozRmtUVjRYZ0Qx?=
 =?utf-8?B?aFhsTkNkbjR5eTNtN25tejB1RFB3WHp0ZXdyZ094QWRWbmpIQlY5eGExNiti?=
 =?utf-8?B?ZmF5WUhZbGZtN21LMjdkZ2VQMWNKblRtRmZkM1VEeVFkUzZ0bk5jZVUzaVE5?=
 =?utf-8?Q?DZA14VSWfsD1h?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUUxYkNHN210QXRpalRCU0VObXRiVWpxSCs3ZHVhM3JlVVk5cmR5MU5tVnoy?=
 =?utf-8?B?a0dnaUEvNmM3Vkk4NFR4dXh6OHNrT0JBaU9Rc3EvK3dWQjNlOUEzV01Vc08x?=
 =?utf-8?B?Wk8xbVNhR0NoSERqK0xhYWZPbERTT3pCNWk3dWtPOWRLdkwyeDRFaEoxeGI5?=
 =?utf-8?B?VGh5cU9XWGR4N0x4Y3RGazlXSXRzaXdPQjhNZ0U2R0h6K3VNa2dRUFNFL0ZW?=
 =?utf-8?B?U2k5dXZtK2hLRi93ZW5FTFg4ZXNmZWR5dFFjSVppdWpmZnQ0dkt3SHlZemtF?=
 =?utf-8?B?M2FMWVFTK0tOdkpDQStHREhDMVR2eW1uOGZFM0gzMlFwZnUxUVlsS2ZwaS91?=
 =?utf-8?B?VWdLVnNEb2dHMEtpNm53Z0o3OUEwR2dRbys5RUtyMkp6K0EyVkJnQTFYWk40?=
 =?utf-8?B?dkVsS2w2S2QyWHYyeVJjZHhHS1ovamdYd1JXWW9BanZ3MGJTdUZLczBMYjl6?=
 =?utf-8?B?RTllK0hTb3NUU2JoQkZFOVVjMFozc2xIU3NLUndudHo2anQ1QklxZG42eStG?=
 =?utf-8?B?V25nTFZPTTkxZDRzSnQ2WG1MZFNFSkFqNWhFaHVzMEFvWG5wOVpVTTJxNSt1?=
 =?utf-8?B?NGRMUDlLNkNLUTg4eVVNeGZuODYxSGhMeFV4ckRZRUJVRDB4TmRubUVqb3Fy?=
 =?utf-8?B?OHNxT1FyUElqdVBOeWJIL2VXWTZHd2pLblpLanFzZG4rVUdHT0ZiNXFSWVpw?=
 =?utf-8?B?NVZPTEhhMWVGcXlydnZzeEkvS0NUQVB0dnIyekJ6VTFWbmVVU2llYzBReFoz?=
 =?utf-8?B?YzhJY1VIdi8vMzJJd3hkdXo2M0ZrSG5yMG1qLzZNZ0UwbGJjeENEZjJFZXpz?=
 =?utf-8?B?NGpOUDVTMHZTK0JTK2U4YXpCRG4xRE9kRWkwOWUySVkxc1NKM3dEUHgvYWxS?=
 =?utf-8?B?R0IzZDJ2NkFRYkd5RW1Pb2FTZjJyYnhyWWZaOHg0VE90YVQ0ZWgwZmtWQWVP?=
 =?utf-8?B?RzJpcVdTL1c3Wk5INzR3ekM3QkdJdEtMdENUbVViNG9OeGFRaDZreVZYZ2tC?=
 =?utf-8?B?NnVOOTNGZVZoNEFtRmUwVm5jVGdyWEhoK1gySVVQMU14TnRxeE9zUHljdHJk?=
 =?utf-8?B?UlErMEw0TmwwSjErUlJlQ0lHSXIxeUlBNFd0Qnk3MFRSajhzREhSMDl3ekxl?=
 =?utf-8?B?MjVTKzFzQmptcWZ3dFNSVkdyUVY4dlg0RlJ5UVlZTzh4SWdqUGlOdE1KWlM5?=
 =?utf-8?B?SWJ4K2U4V2lOb0hKUzJYRjFxLzNHalBEdVdqMnlvL05hbjcyTnBXR0xWWFdS?=
 =?utf-8?B?YmlkZWtTMzNrUTFUOFc2QnZUMUNWckx4VGJ6V0RBRktUMDllVStwcFFNYWtS?=
 =?utf-8?B?cE5lbXhlQ2tEVkVWWm04SWJLcEs5VzIyOW1nbVJYOWZSMnVmK3VvVTgxMFg1?=
 =?utf-8?B?b2ZNOXc1c1BLZUQ5NGp1dVoyb25iUUVuS3BzYjNNOGlJbDQreWtzaSsxc2ZP?=
 =?utf-8?B?bjBGcnluVlpnUStmU3VRcmN6a2J5UzF1TWg1TW12ZlRFZUJ2ZjkvTnJHakd1?=
 =?utf-8?B?UmVTaWZXS2hLQ09DZkFheW1nQmUwYmVXWFNzL0xvUnhmVURJRU9rQXA2N3h2?=
 =?utf-8?B?NzRSNTkvVzduWDRTS2ZBZW0zWWlvd3lJc1dHRXcrc3M3SjFOL3JhcWFlbDM5?=
 =?utf-8?B?TmlyTzRUYVdzR3AzVWEwZ2JCZXdMQmJSUUpPaXhjQnNDZzZDblQ2aVBVZFRS?=
 =?utf-8?B?OTFqWWpVckJZNWxHd0hsTGIwMlhtbk5LUFN2SVVqdnVsNG1pSDN0UWp4eDl6?=
 =?utf-8?B?OFFoZjZUYmdodXdTKzZIWDFhdXhqbk1IZkpHRHdmT3krU0pEcFdsdENvUmRz?=
 =?utf-8?B?a1NxZ0RKL2VPYXdHQm0xdXJmYW1VUkQ1MFlJMElncGFROEplQUNtOGhFNGVn?=
 =?utf-8?B?b0F4dUs1TDQ5ajMvVmNMdFZRcTlrSEtac0NTSFNWb2FjV3FyUGhOQThJWFpB?=
 =?utf-8?B?OXdQQUdLM1pWZmpaRmVpTXlsSTlYQzBTWjFsaCttQzI3NVRqeVJEMnFzTUV0?=
 =?utf-8?B?T2FqSmRqMVUxejFVQUlmSGdSejBNSW9ZUEVJRlFqNUE5R3p0OWhJZ1ZLZkJL?=
 =?utf-8?B?SVQwa2JXL1JLSFMrL1Z1NWZqQVd1S25oSW9oaVBDeGE4QjJPT1lVaEFEbHZ6?=
 =?utf-8?Q?9EpRzMBQwtJKQgm3gsh4mk+K0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0354921e-19d6-4ec2-4389-08dd08d29a94
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 19:44:38.7371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sCr5miW0KnDWxaWOvy5hhUShmXcjiPz5YxbSPrOpyKLOHW89ClONC+YYev0g+bb/TIQbX143S5f/0b9MITRPBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11068

Introduce field 'parent_bus_addr' in struct of_pci_range to retrieve parent
bus address information.

Refer to the diagram below to understand that the bus fabric in some
systems (like i.MX8QXP) does not use a 1:1 address map between input and
output.

Currently, many controller drivers use .cpu_addr_fixup() callback hardcodes
that translation in the code, e.g., "cpu_addr & CDNS_PLAT_CPU_TO_BUS_ADDR"
(drivers/pci/controller/cadence/pcie-cadence-plat.c),
"cpu_addr + BUS_IATU_OFFSET"(drivers/pci/controller/dwc/pcie-intel-gw.c),
etc, even though those translations *should* be described via DT.

The .cpu_addr_fixup() can be eliminated if DT correct reflect hardware
behavior and driver use 'parent_bus_addr' in struct of_pci_range.

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

'parent_bus_addr' in struct of_pci_range can indicate above diagram internal
address (IA) address information.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v7 to v8
- add mani's ACK tag

Change from v5 to v7
-none

Change from v4 to v5
- remove confused  <0x5f000000 0x0 0x5f000000 0x21000000>
- change address order to 7ff8_0000, 7ff0_0000, 7000_0000
- In commit message use parent bus addres

Change from v3 to v4
- improve commit message by driver source code path.

Change from v2 to v3
- cpu_untranslate_addr -> parent_bus_addr
- Add Rob's review tag
  I changed commit message base on Bjorn, if you have concern about review
added tag, let me know.

Change from v1 to v2
- add parent_bus_addr in struct of_pci_range, instead adding new API.
---
 drivers/of/address.c       | 2 ++
 include/linux/of_address.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 286f0c161e332..1a0229ee4e0b2 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -811,6 +811,8 @@ struct of_pci_range *of_pci_range_parser_one(struct of_pci_range_parser *parser,
 	else
 		range->cpu_addr = of_translate_address(parser->node,
 				parser->range + na);
+
+	range->parent_bus_addr = of_read_number(parser->range + na, parser->pna);
 	range->size = of_read_number(parser->range + parser->pna + na, ns);
 
 	parser->range += np;
diff --git a/include/linux/of_address.h b/include/linux/of_address.h
index 26a19daf0d092..13dd79186d02c 100644
--- a/include/linux/of_address.h
+++ b/include/linux/of_address.h
@@ -26,6 +26,7 @@ struct of_pci_range {
 		u64 bus_addr;
 	};
 	u64 cpu_addr;
+	u64 parent_bus_addr;
 	u64 size;
 	u32 flags;
 };

-- 
2.34.1


