Return-Path: <linux-pci+bounces-15549-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 691D79B4F88
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 17:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BDE61C227AC
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 16:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F5F20604D;
	Tue, 29 Oct 2024 16:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Vw8SfGzD"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2074.outbound.protection.outlook.com [40.107.20.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA3B205AD5;
	Tue, 29 Oct 2024 16:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730219842; cv=fail; b=Qg15utxid0od7I6GT7k7nLKcOKjnc5WzwuHvBV2NjRIrYaCd3dR0woC4dz1GbWUYe7uB4SauhTufAKDcc5HTAU45BSNs4n29nZpQOxL1giZj+IApB5KJZ3NUm0z+k2M9kgnuHep97B3Dj8Y1kDW7Xv9da/ll2PkKWft5FUOLfAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730219842; c=relaxed/simple;
	bh=lrLx8Z8SxZT/oJjco5fJswD/ZWUdBilHEZbhlGAZNXk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=c7B7UHcMaB7zzwgxKOFUusjcSl2+8+72sGZFAx1JwyMNXMfFQwOuY8bbag9uwxd0iImQzsLCDvyo1aHRMePrgPcckdPuvVHFEi7rljuTZ6YnXrU+kVwkIlzW9iBSQ0qAj9srNUFRygutho0LJDclGBtzfpEzd1bX8fjcOWbLsck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Vw8SfGzD; arc=fail smtp.client-ip=40.107.20.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dpindFmvBhlBe0ioOH4j4fJVGyJtmGuJNJCRs8+goRnLLIYvumA9Ffcg7z/MwA1A3HANZZN2oi9UCJWif9X9H1Y+ZnumLIditKhbfETycwtu9r/ZKeC/lgJbfI0WAa6NC5N0AC+mL/UMHo+QU5qAXlAUTHxRI+eg9CymeUXgTv2yqjaVym5VqIU0a8o4NO73YknU32lUOzkVXYJVSQT7Rsm/yn7I4twecjSntZEecGeG3z3u0Z/uD/KwkMSjZLYtZ/zKhx0hWRfP3GokGKrA9kiI32MPZnkeIrAv5+75kzbM3ejtkhZzq3mqxSKfEQU9Zp956YbOom/SLFdmaDHk2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rH+/ieqErUrPjrX69gEMyYnDDWNyEiJyuGTkw/pz68o=;
 b=jwml2pKyRZFNm1kpLvLVSueLkm3j76A420rq+kNfrqnXJkXDpyg+PX1FDilEGz//L3ABZxNSKMHp9ZsH8VrzBBoM2JiyFsdEEX8NDiZuIl1W1MbuCMqk8Lx58kXrXi5zWlbzcLy4CnXdz2xqKwlT9mQ7nmiT/JdcQr6+jwY1FHBds2RDiOYmbJCBRaMNGkRArI33E0Ioe/jv5vtRBOYm4G4fllSoxzHU0VW4jNvkviiiGpRjohR+WWbnIESW2L9OsXC8nRI1j/UIerxQ4gBmEmyfBHjyBro7yKMcLY4JX3HB9C4eY9S4uqfQ7oEj6OBU5SR6iq74g8FNfOcoLyFdbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rH+/ieqErUrPjrX69gEMyYnDDWNyEiJyuGTkw/pz68o=;
 b=Vw8SfGzDGnK1O9XUvG7rqCMaq3A/VnueWFnX5f8xZMSatTxziRo6xhB4PwI/iEDElEWeJIbKS9iQqterOiTVWbOtKCxSa9w9U0krr4ypYMmI2CkSowEiezq5E1aRqWKf+H8vTG7RE+XFfqN0y35bESBpUPJnkNEoc5EDCopwO4ihknA6kn6GNJGxtbxkRTcjPW/LSFSwHybDsQ9BuKTIZ1CeGjF0wr/zHLoWDeYZnl7MZGHB9Vvfy7J1+7M9SeavyTpdNDuDiQAtybG2KwcPZgFD8TrYIxzzPkFt8Qoe8YwwMtWU37RxNhkPySDo6cA+w1QY6QBtUd3NXelHGKJRZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7577.eurprd04.prod.outlook.com (2603:10a6:10:206::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 16:37:17 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8093.027; Tue, 29 Oct 2024
 16:37:17 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 29 Oct 2024 12:36:39 -0400
Subject: [PATCH v7 6/7] PCI: imx6: Pass correct sub mode when calling
 phy_set_mode_ext()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-pci_fixup_addr-v7-6-8310dc24fb7c@nxp.com>
References: <20241029-pci_fixup_addr-v7-0-8310dc24fb7c@nxp.com>
In-Reply-To: <20241029-pci_fixup_addr-v7-0-8310dc24fb7c@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730219803; l=1266;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=lrLx8Z8SxZT/oJjco5fJswD/ZWUdBilHEZbhlGAZNXk=;
 b=c00KuuZdG71AFNsfjgrrDHH6bo9k8MvyBrdD4imApf+17/aizFO9WqyddXoQ2iQWZILpwQFCA
 SiNNMyuFH0YB0NOmr/OPdMziMPNgryYxb7vlJ+sTTaGZ1cmaPJbkZma
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR13CA0035.namprd13.prod.outlook.com
 (2603:10b6:a03:180::48) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7577:EE_
X-MS-Office365-Filtering-Correlation-Id: 2147560c-08a7-4bc3-da26-08dcf837f329
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NEJLVzc1RTJ4RzFmL01Zamx3Zm5nT1hKUm1zNEV0by9GYTRnZTZSNU1Lb0Ju?=
 =?utf-8?B?S1Z0SWY0emlTN21uOUt5MjUzWEtLS0NKRjRYVFhXZlFaaEFBaGIrWjduanlo?=
 =?utf-8?B?b3Z0TUt0QjdIRk40ZzZBMWNMaDlNMGl4THp1TkdEMVdzVElwWDhlQ0RQc0tW?=
 =?utf-8?B?QVJaU2lGZXhRNVpnNUI1cUNMbWdsNXZ6TVQxMVBueDY2ZXZva0tXSXJCb2Z0?=
 =?utf-8?B?enFjZEl5bVdiYTMyMXAxRzhuZVZQRkhjWkZUOG43V1paQ0ZhTXJsdHpWR01M?=
 =?utf-8?B?QmUvRk04NHJncUFuMU5WWVl0aUFMKzQ4TjVQeWpVSDFSMHhnc1lhQllNN0VR?=
 =?utf-8?B?ZGNMQXJ1WkNIekpZcVYxb3ZQeUU5V0hYVzgwT2NyK0RsOTZlYU9LVGZUSGRN?=
 =?utf-8?B?QXFZckFqcGlRb1NEbmdNcUxJd1dIVUVJdXplMHBxWFB5NzZtQ1FXdFdyWE1P?=
 =?utf-8?B?dzl6cFRjOHlVbXNqbFdMMEgwTERwV1d3VDJiNlVDRG9SeUVJNlo2OWtlTGZp?=
 =?utf-8?B?TlBBRmhHZnZNZnlxcXhtTWxzb2hkU2I2T2RXM1B6Sk9vMzBoN1lmZVBsTlBI?=
 =?utf-8?B?czdOWjBvcm1PR0N5eWxWSm5BSEs2MmpJaXliajBtK3RTL3FTWmFleDhEblpr?=
 =?utf-8?B?ZkZZcnM0NThnM0E5Ry9sTXR3SFpNbm9ZTysvekhVVEJpMDJleEdkcXphYTQ0?=
 =?utf-8?B?VnpsQTIwcHJrVlpzWi9MRkhGOTM5NUo5ckdRZUhBZ2xzRGpLUFJic3JCT1lO?=
 =?utf-8?B?bTA4MzVjc0k5bjdvenFpRExTUGUwSk5iWlZQeFVQUnZxTVV6ckhzNjdJKzBR?=
 =?utf-8?B?SVN6VWx3UEt4NlZtd2t4eUhZV1Y4L0E4ZW93MnhZOUcyb0JVVWQzc0QzQ1Q3?=
 =?utf-8?B?bHJSdEMzcnk3TVV0Mmdxc3hWTkhHSXQrS3ZxaFRxTlQySnBDWUlpWTF2MUE4?=
 =?utf-8?B?NDdyMDY3V2p2TWhPYlJMU3dTRjZxOEdLSnBTNmJQOHdmSWh3dGVuTWdUaVdz?=
 =?utf-8?B?dHBVbGVUb0djTXZCUUNlaGE5bm51ajJzSUF0OHBOZGh0MTdJbHU2MEwzb2ow?=
 =?utf-8?B?THBXOTNaeDZNNSt1eE9yMlpuYkpoYlJlTFUrc21ZdkFLUmdMdFVNS1E4YWZV?=
 =?utf-8?B?MkVQdVloOEVZcW5CRkdxSjRlYU5xMzhvb2Rtd05yUnFyVnlIRmdraFpUVHdO?=
 =?utf-8?B?dWROK2dlVTRwQ2kwb09YSnBEOGI4d0RQMnlJbnpOMEdOUStVbkw2c2NTSkxn?=
 =?utf-8?B?bWJtZ2ZLWkV1WWhsYVlxS21CUGdZS2kwSk5nUWoyUmQ0aVJxUTIzTmZtOXlD?=
 =?utf-8?B?SmlXeFYwc3haek52bllhdW11MktQUjJDVE1qM2wrTVVxMlAvSitnNjMwRlZ2?=
 =?utf-8?B?aHdMbXJDRUsranBrTXZnbGhBZ21KWXdXRUJkMkpyYWhsRk85dU0xWEU3KzR5?=
 =?utf-8?B?VEVrMWpVcElWL2hmT0ZDTzc3R21FSkV5ZkZxZitzU2dSQ1dDdTE5djZGVzVJ?=
 =?utf-8?B?bVNMaXVEd0NsTGlzaUdGSTBJaExFUXNJWU94NnFBVWVJQ1JDdHFBK0tFNmVh?=
 =?utf-8?B?Qnh4U3JBdkloVWgzbDJJNEZhNHhSZ3dUZjF1NGpyc0JWZTg3Y1dRUXpPOG1p?=
 =?utf-8?B?cVFtSjlFdjk5T1NCUUE5cEQvYndqNUxVQzVhdkdXbFQ1UE9lRjdtSXZ0M0lE?=
 =?utf-8?B?bm4weWoxZ3djcGlobWx2TjNma3pURERubVJIMFk5OTJ0TVkyUUlHUG1LbVVr?=
 =?utf-8?B?OTFGZnRteTJ6VHQ3eVNWSUlBQXIrellmTVVIUzNzdjVubm5vZ1pLMnpObHZL?=
 =?utf-8?B?V0MzWFA2ckhVaXhNeHV5QlVtYVAwWmpjMFFkZUJpcFBURHlYTW1qN2ZBM2ZX?=
 =?utf-8?Q?kUct+LP3Aur9B?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bEMzTXI0MlVKUVd4ZnJWdVBmUjNiNTMxSG8vVW8ycXNOK0w4T3Y1TmprQ2Ji?=
 =?utf-8?B?TThOOUk1cVlYUE5FN0hwUUEyMzE2a2VVK3B3SHk3dVU4V240NmZRL09VTEIv?=
 =?utf-8?B?eUtoTzM2eHZ4a0JDUGlTSVdKbVJwVnFZNFVIa2hnYndUMlFpTUU2NjF4eGdN?=
 =?utf-8?B?NGdLdTQ4bEk4RDJkNjN2aDk3WE11S0hCS3RSYngyeExPMDVDVWxFMWFDN3lE?=
 =?utf-8?B?eDJuckJ6N2QxWUh2M1l1cm9zNTlQOFI3a1lvVDlOZ0ZZYlN5dDZQbGZCb29R?=
 =?utf-8?B?SWF1a0dXNXdxK0E4WUh4ejZHT2JqTU1KNUxpcWJRSmExbkZnZVg2blFxUWg0?=
 =?utf-8?B?d3Rqck1TTHd4UCs5bkhXMmhCaHgrVnpNRlRVdDQrNlE3cGh2UldlM0hEK1Mz?=
 =?utf-8?B?NGd3Ly8xWjQ3WVh3WVMrSTVPNEVEU0tkSUZmeG13YmlnRENCSU96OHordEpR?=
 =?utf-8?B?SlVxVkd4SkU1dlhVNTk3UmVFZ0ZsbnNEVzNpcjR5MzB6dytaL2V6T1lEaThT?=
 =?utf-8?B?Rlk2RG1CWHgyejhRd2NNdTkwVjZHNHZJNjFBK3BvelNRdEFmZFE5TDBZZFNQ?=
 =?utf-8?B?TTNva0VjRFc4Uk1sY1NRSUZLZ3RjQWs3eUNYem9jMWh2aFowVUJqUkxpc25h?=
 =?utf-8?B?UmFGME92QUJvREtyY3lPVnY3cWxUQk1iT2VwVzIvNnVsS0J3a0YwNlQxSm50?=
 =?utf-8?B?di9URkNUNkJ1YUsrS2lPaWdwcmRuQmhzRjg3d0lLZHBXVXhueDZCTkhQOFYv?=
 =?utf-8?B?Zy9xdGFUNG5EYjV3WmU4QjQ0cVVoVmRpMmVRRkc0REcyTHhlWkZreWZ5YTFG?=
 =?utf-8?B?eTJHR0FOUEtnVThKQk9GTVNJM29oVWl1T0x0cDhkc0tBM2ZMNzYyTEd6c29o?=
 =?utf-8?B?U2tGRmFIWm15dDdra0M1T1hLQXFldHdQRkZwZWwwdldUL3U2U1ZzL0o1TElk?=
 =?utf-8?B?ZlJ0ZmRlREVvWFpkelhBN3RGcmx2Unp6NXVRcFBpSms5aktZTnF4akVYSFla?=
 =?utf-8?B?MkxlWXdya3VzV0d0OUsvY1RsL25sV3ducUh0TWpmMklFYmIzdW5reHBzMGhw?=
 =?utf-8?B?cWxnWUVBaFVGSzFONE8rNWE1aHNka0ovRE9ER21jMnNpNzlKdUxYeGs4REF0?=
 =?utf-8?B?Z0oxemFZK0VvZmova1hkUUErQ3RxZFI4VXlhZFc5bHpENGozQXlHaVJXVjlp?=
 =?utf-8?B?UWJNTERpcHQwanNCdjVQU0NBeUtUdVRVM1ExT1hJUmYvNlBzTFNUWUJhSmhp?=
 =?utf-8?B?STg5VzVCaFdHN1crTFprSDNxR3BEMUtCU2kzbUZyMFlNdnV4R3dCUmgvaW9Z?=
 =?utf-8?B?Tk81SjlyTXVadWt1WERhN2VGUWFMTExBRUlpQWlZQXNuT2ZzT2k0czg3ak12?=
 =?utf-8?B?RVRxdE11ZEpWem5sSnlzYzFTUUFHb3Z6RmtpKytlanhFM3IvNlNGLzNYbXBn?=
 =?utf-8?B?eExYYzIwWUxJaVQyZ1JGRWIzR1h3aWY0MWd0UlFpMWZGUVNSQ3FXUGJFbzVo?=
 =?utf-8?B?YnNFN2hRZnRBcEI2OVZqalQwK2JnWVdnOGhERjNXZDlUNlNYU0MrKzQ5Sy9P?=
 =?utf-8?B?NHplY29XR0ltd1J2eUcxaHN4WTFyMTZSK05mTlZtOEJXME5ZRFRKYkZ5SVYz?=
 =?utf-8?B?OG0rTEJveDJSV3FTZGdpb3IwdzMzYUFhNkdJbER0SVpSQWU5V0lBTTA5TTl3?=
 =?utf-8?B?WVBrUmVqQUhidm9BeFpIOVpKdkpaMFk1TGdkV2E5am40ZDRIQnlZTEt3QVFk?=
 =?utf-8?B?ejY1bGNwaUI5VWZSTldZamJJSldJdjdXU2lUZER2UUQ0ZHpUSURmL0p0VzM4?=
 =?utf-8?B?TnJxS2RqcVdtWk5HSjR0ZWpSYW1BcUVsUU9vdlY2ZUl3aXJaeHZ2d0UvemxM?=
 =?utf-8?B?U2R0T2xTbS9GSDZwZUExT1hIZm5FK1U3dVhBc0RMcHp2eUtHVHZ0eVFreTZM?=
 =?utf-8?B?S2xEeW5CQ3JoNi9BajFMSTJKN0lSMU1mRDRQYnZwVWJOcVkyOFJKN3p6MTZx?=
 =?utf-8?B?ek5hRDFLRTNCVmRkVWw1Q2VTZXY2VXk1L3NOWURKSlQ4bjdIL3JRZmdWVDE1?=
 =?utf-8?B?YmVIcHlXSlhUTWJaZnZUWitzNjNXZFk5akhubmpYU0Z0NERxUlI3ZUtHcHgz?=
 =?utf-8?Q?1Iz/wgJJZWlXsjye+LBmWCMHu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2147560c-08a7-4bc3-da26-08dcf837f329
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 16:37:17.1292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: otaB2Zp4WQOoW+y9BqzNW3i79gnu3skGBNxiPKGXjh/zm0QS9B+aD1FitXE/6Im9l7ObNyFqL6jOH0toMYxrwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7577

Fix hardcoding to Root Complex (RC) mode by adding a drvdata mode check.
Pass PHY_MODE_PCIE_EP if the PCI controller operates in Endpoint (EP) mode.

Fixes: 8026f2d8e8a9 ("PCI: imx6: Call common PHY API to set mode, speed, and submode")
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v3->v7
- none
Change from v2->v3
- Add mani's review tag
---
 drivers/pci/controller/dwc/pci-imx6.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 533905b3942a1..8102a02a00b38 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -960,7 +960,9 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 			goto err_clk_disable;
 		}
 
-		ret = phy_set_mode_ext(imx_pcie->phy, PHY_MODE_PCIE, PHY_MODE_PCIE_RC);
+		ret = phy_set_mode_ext(imx_pcie->phy, PHY_MODE_PCIE,
+				       imx_pcie->drvdata->mode == DW_PCIE_EP_TYPE ?
+						PHY_MODE_PCIE_EP : PHY_MODE_PCIE_RC);
 		if (ret) {
 			dev_err(dev, "unable to set PCIe PHY mode\n");
 			goto err_phy_exit;

-- 
2.34.1


