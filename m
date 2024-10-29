Return-Path: <linux-pci+bounces-15550-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DBC9B4F8B
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 17:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A106286FD2
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 16:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C62A206E8C;
	Tue, 29 Oct 2024 16:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RogeAcJ1"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2053.outbound.protection.outlook.com [40.107.249.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC16206E67;
	Tue, 29 Oct 2024 16:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730219847; cv=fail; b=TiVFNqsIlXBQm94Ulz1RK+wYxdguz/4V7y3VsSv045/6H5u2kA5oSd4JlgIgvy8raTM0Yps4b1uQKDF/KczPlRVWxBeqixjfWQ8RmtzNJaHeQm72tlBRqH5uakDjw4MbdjUzT49lDhx2fmLkN0P7m4nvWHpzvObtPpTqgfrlX2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730219847; c=relaxed/simple;
	bh=ixQDYJyXuHUmAmlzLRMBWxuvNvNweOl8KqjaI6bcV3U=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=c/XDYB2MqcHoiLRSIaacErwHqwshZVaPI51wOi6gdLuq146Rl1P9PMcQP52qkWxyga/PvcM7vY7e1XRrGSKAgLLzOek1+OxD42laNPEqODUyd7MLD0OKDxLS1ORUbSf7oSLNfFoNTIXncws6mbBUGk7bVwKKEUIifRsmAF3GZPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RogeAcJ1; arc=fail smtp.client-ip=40.107.249.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vjjUZEtdarYuod/5WDJaUVGKwdlkVZJCPcn/qHnHMzF6abaq0Db9F2EedvLD6xHzLPpdzkk2DtlLrLNjOd+ZjPfZTXwigHbNa3o08/9OcoHxZAoABOknJNQ+8RyU9GWpB/XeT/eB4d09gk4XH/nBTwPSeAR7L/rZ7IN4iZTfEgQ3/1jsj/TCm35FRc5/DkskbbVc9KRyVf2+aNkPD1xKpIvV1sHihxv6F9OzQIA6/dsp7uvYcoVnqWngn28wDP7d+08qxxqAqTbFKV3V52KiMfnCRkeF7vNNrICss5epnz7/IkmYUUSXUiA48NUrElJY9Cjfdf28PiWmGO2zeeN2EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mAK1jmuAtg0H2cjB9iC8wvlwe8xRsTxVgM94PH4fUfU=;
 b=g4mzzs1wEUbIwKBzN+IfK95/zhyNQUCJzU0bK2JNyyOSw8plLUpy29E0WGE6G7NnLI7icPVgrPtTm8RyMBdQiw+ac20Id84q5hcBYaimwrRWEpMZCp1FRF3E8KwNhXA772OSwij5USJZHy6rEX34ZZyn/2d8B/DwvQe5YpA+szgLH6TOAutWnfiEYQbDBAImvSiLqSdlp8nhKgr35K2x5uDTUjdHydriKLSdcpTJN5ScHWwpCOMNAzIGE37T7vXdcOM6wdJqKyWfFU2xHPyVfpdp78kMR/Jp+lenJSdnHsr7W0fNGOHoeUZe2aFBkjaNzh99C4d35xDWXXnPSUeJCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mAK1jmuAtg0H2cjB9iC8wvlwe8xRsTxVgM94PH4fUfU=;
 b=RogeAcJ1TjXit+FtFRWMnBe/E4AY302awcPm08U4wVDm+CppqQcbkSPHAlU6debBV1Y9zvPhKSQcbGg8wq3e7/gK+/Nc5lHEY08kKJOaw07ZDqhX1MRhQYHIEoOifhrYfe6LHGYT278JwLTHwVhBnN9hrnwt8wbKCHBSTIrfbrNCEV+iH4M4s4heNzo3lNInLQgyCcXBIZMPPAP+MnI1Xf+pllgTFOWlhJMKMJiYz4Y+ruO+mwTz4e0Zj9T7Gj6+ahM1Vabq1eElCbEiZN5rw/C+Cw5N6d58RX2gGSMQkbIg1LNfjSjuiG+9N5KHRSBZvKCjcQBhmMG2i/KrNDz1jA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7577.eurprd04.prod.outlook.com (2603:10a6:10:206::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 16:37:22 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8093.027; Tue, 29 Oct 2024
 16:37:22 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 29 Oct 2024 12:36:40 -0400
Subject: [PATCH v7 7/7] PCI: imx6: Add i.MX8Q PCIe Endpoint (EP) support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-pci_fixup_addr-v7-7-8310dc24fb7c@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730219803; l=2548;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=ixQDYJyXuHUmAmlzLRMBWxuvNvNweOl8KqjaI6bcV3U=;
 b=ZR6A8qNeIAYIe8Ph71ciCpzXbLqQYWQXs8YoteOpdZhXLGpAGhyXH345js0CyOgwJBiejt6K0
 d9zLkq/wclsDnlAUIFVLSq+dWJTJAnmwfeKWhZ76wQ8E2vJlQnGjfoK
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
X-MS-Office365-Filtering-Correlation-Id: 1606a36f-a823-4388-7cbe-08dcf837f612
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZGdWNzJYWjl0QTFqbERMa1BESXFFWVZVdXdhWlFoVk1BVlhSaXUrZ3JkVC81?=
 =?utf-8?B?Z2JGQmc1czZLM0dmWVNLekhkZmZOVStZR1FuZWh0bWpjYUQ0Y2ZabHlYNWFC?=
 =?utf-8?B?S2JVSXV6d0VXelc4V0tYN0tYZEtrTzkwb1liT0tGMG0vbHBsMzRZWjMzZGdD?=
 =?utf-8?B?ZkNiT2dJTy9KMGpacUJhL2RZRXY2MXVEQ0ovYzdBYS9tV05RbW1WeUQyRjVK?=
 =?utf-8?B?TEpnLzR4TGpwankzZ2c3V245Tzh6eC9hbWV1ZXhLY3l0TGRJUzBSUG10V0J0?=
 =?utf-8?B?ZXRXdHJmQ3NnL2tGUGhTZEVKL1Ayd2dnY1lLNGJqd0xsRVVSWVhGLzlEZXhz?=
 =?utf-8?B?by9HRlhnOFh4VDY2WE5HM055b3FaZzBkUUxMZjBDMlBzVkFkdlcvSUlqajVr?=
 =?utf-8?B?Tnl4a0U1R2h5emhSeVdGL1ZQU1VVcUZJNnEza1hWUUlvM01na2p0TGV3VmNq?=
 =?utf-8?B?Y0MraGJEaEhxOHp1Um8yM1R2aTFhdHJ2VFlzejZOUDIyNU5veHF0YkpGa2F0?=
 =?utf-8?B?anRrM1pSa3RiWmJMaEUxWXdkRG5SaXU2b0l5TS9SRENvc1A4QS95UC9ZY2NN?=
 =?utf-8?B?bFRzZmhZcDhaNFpTVmFpMzFta3NEck12OTRWbGkyelVCZGlyQ3A1Nld5emxs?=
 =?utf-8?B?ZFkxYTIxVld4ZVhqeXo2S0F3bERndyswR1N3OWtxTUkwOVRSZ1lJQkw3bENJ?=
 =?utf-8?B?Nzl1WUx4MXlPc1gxVjRlTnhhZHR5Mkc4S2JkSi95TnhUTW82dWJQOGNHbFVF?=
 =?utf-8?B?bkZWSjlPT2dBakR2Z2dlMzNRWTR0TDlRdVpmWGprZjVhSHArNXJPZEQ3WG45?=
 =?utf-8?B?S2VKdk9UY29sWElacEpLc1l5UVR5N2FRTndGbUYyQ2xYMnordW5QVk5NVERN?=
 =?utf-8?B?M2o5VVp3UFIrZStReDJPSGhNZGRVV0tQOFd0NHVaR0ZjWE55TEtCdGxCa2Fq?=
 =?utf-8?B?N2lsdFJiRi90M09lYWRNSjd4UTJiYnd1YnQwVlZOdUxpUnhITjJud3hUZnZE?=
 =?utf-8?B?dW5wYWFZVWtvejRIVkZiZWFsVHFlQ0k1MTJOcTBDZU5JaXE1K1Zsa3ZTR28x?=
 =?utf-8?B?R1RWWllRZXYwcGU1amxMQTBTZ0Vsbk9uR0NESWk5aDNoL3hDdy9UMVc4ZEpJ?=
 =?utf-8?B?bEdVTWhkMDY1elFYRUkwYit5d2VEcWN6SXVtZm9CZzhndU1sUW1DQzUxWWpG?=
 =?utf-8?B?SzAvVDhrN3ozcDJza3RTZDc2b09WbDlvelpKVm1ueFo5RkllbGMrdEZBUHhq?=
 =?utf-8?B?aGZCMm5sTzExcHpmWG5kajMyN3VYMmY1Vm50RmlJRE1OYWVEUldScXhOSHVx?=
 =?utf-8?B?M1VQYUo5YzkxNmU3WTRPZnh2cEd6Qm1yUmNjQ0MxS1gxdU1KSW15MGkvQmlF?=
 =?utf-8?B?M3FoeGR5eHgxTEJNU0RER3pBSzdITDBBeTk5RXpsclNNUnBYZEJ2VGhlS214?=
 =?utf-8?B?N3B3NWlsQUJxRFdQNGhTdGMvMjZMR3VoMWs1eWtmRWVhQm9xMWUwekduTXc1?=
 =?utf-8?B?ZzJlcS9mWENJMVdnU0JaQk9PblNhdU9xbCtGbHlJWGRFNFI0b2Zkb1pUdC9X?=
 =?utf-8?B?SkZZQ0RkbGVKdlVQWVNRSFFaTldxQ3ZzUlNqaGQyaEJoY3YvQmt1dmhBUm8x?=
 =?utf-8?B?anpXKzRoWVUvZXhvZnN0TzdTQnk2ZFpHZThWSlVHc0RiNXh0aW5WV1dtYlB1?=
 =?utf-8?B?QVFaUy9jY3dWU2UrSXpqTEFVVGFqeERZL2ZqTXRZMHQ4NmJzWXI1ZUgvc3hx?=
 =?utf-8?B?TkN3SVF6VTZ6ekJ2SVRzVkQydG5NWEswQ2IxajloVDYweTg5cWl6TTJiMGVr?=
 =?utf-8?B?Wk1ISGMrWDQ3R3VPclpxRHduaHVvTjF3Ulg3TDlCRVcvUTk4c2htVmtEcWN3?=
 =?utf-8?Q?2aLtQzoUEfflJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UzVMaEdKNTNQQWRIbnRiWkh6SHZsVk1wTDVJdkdIZXpzQm9MaWtVRWt6OGov?=
 =?utf-8?B?QnN4Vi9YUFVVSkc5MTVlUVFzMmF2WldFKytUNjd5QTZBVzNRODlFQlNoYVJY?=
 =?utf-8?B?TE05cVBzS3Bpd3NSczMzY2ZvWWtnV21hTXZsck1zVmdTOHZnWXkzUFdESUFx?=
 =?utf-8?B?Y3h5WEhNS2lQQU42dWI5amh2MlcxZklPSndYSmJwb3Zpazhvb3RLYXArMStp?=
 =?utf-8?B?OWl4MzBKYWVOLzdLR0QvSDRHbDhOR3kxRTFDenVhU04zYUl0VUFXeWU3OUtu?=
 =?utf-8?B?R1NtSjlTeCtnRmVXOUswZGg0R1BXcnBjMGc0eXZzNWI0Mzhhc3RheE1ubEEv?=
 =?utf-8?B?SUp4MzVrZnpvNUNhd0FBejdrc01TQVhPWjhya1k4Q0wzc1YvY2UwLzFIS2Jl?=
 =?utf-8?B?T3F5QTVvUHRsMHQxRys2QWh3VEFoRFZGaHVBeEFoL3Nab2VKa0RXVVdwL2RD?=
 =?utf-8?B?cEVrSXhQTVF2dFhNTlRnbjBsMnpyby9SbXBEMEtEOGExTEkvSHVZRWQrR0Jq?=
 =?utf-8?B?Ri91c0MxQ05SWis0QTFjdDczdnhkWHRBM2pFWmFxWFUyUytHQ2t4cFpqRlFl?=
 =?utf-8?B?VHRNenZ2aDcxVktHSmREM2FCQzhzOXNva3ZlVDZOQW5jNk5GUEphaWN3c0JB?=
 =?utf-8?B?ekZNSVJ5WnBYaTlwakFRRnJ1ajZyN2cyWEMwMGVmeTUxNEExRG13U0ZCejlZ?=
 =?utf-8?B?bjhEalhjUDN2bkhObVNiVUpyOEZXOURSeUxLM25mUkMwMy81bkZ2UGNLNkJt?=
 =?utf-8?B?dHl0K1YzUDA1bkhFQTZ0b0tsdi9RQk5pcGpySDJDOVloMEpnRG0yRCszWUdi?=
 =?utf-8?B?eFNsVWZFTVNBSk45eWYwL2tERWNYMnB0aFBUMWMya3EvdVhRenVPa2RyMm82?=
 =?utf-8?B?N2F3Ujg3OFNYeGlzNjlYNmVkS1hsbWF5TXdydVlydnZVcVFqUmVMazhmOXRD?=
 =?utf-8?B?RkgyMEljY1ZvbkJCQTlORHp3QmVaYURnN09lendyV0REbkJjdG8yNVVEU0xC?=
 =?utf-8?B?VkY1RFlONnd6WVNMT1p1SEc0Y3JKSmtFTFNyRTh0UUdsYUVuNXB2cU1NZE5J?=
 =?utf-8?B?azk3RXJHVElmQXlXbnV2Smp6bE5FS0JYMVFOSEZ1TWFQelI2VVAyQkt3Z2Mz?=
 =?utf-8?B?UDg1TmNkeUpwV0Z3RG8yZUtiQ0dSbElLRjd3OTFwb2I3UTd3bnh2dS9OUTNU?=
 =?utf-8?B?M2U0TUZRUjFiNHk4eVg3eTY4bGR3dDZjLzFqRklrcWV0MStUeHF5VEt3cWd1?=
 =?utf-8?B?amNnWXFEck1mWHd3Ymx4dUhiRzh2SEJoZUp0TlBiTU1OdVpsU1EyeWl1NmZM?=
 =?utf-8?B?OXR6ZGJTYTVQeGRnWk5pemkvQ1oybE1HQXduU1JpMTNEUk0vci9vMmNraURO?=
 =?utf-8?B?Y0orR3dRREM1WmpucVE2ckF4ejVMZS9ZeVNBS29qMU9sS1VwM25sVW5SUlhC?=
 =?utf-8?B?SUgrT2tPVUM2SHJ1cnE3WGFMZFBTaXExMDdDcE1kakpQcy85RFBCbXZNY0l0?=
 =?utf-8?B?M09nTVpISDVrSENwRml1emRSTnM0djFRNFZWbnk2MmVNTDVhU1FmaWJBVEdt?=
 =?utf-8?B?MlA0dHFVSjhiUnkyaDBSOGp6Qy9CQXdGdmZTOXlzZkNIZ0xGK3dIdWFacjF1?=
 =?utf-8?B?WVZicmFwSzZkMVhyNThYcHI4KzNUb2NyNVR3NjBsZEhNQWNkZXh3aXFCbTRo?=
 =?utf-8?B?R2dBNm5oT3FlK0pwRDdwaDZQQ1RlN3ZMWnorZEVRdmd4bS9UaHY0WmhEUlMw?=
 =?utf-8?B?YXBzb01iTSs2NFFCZnVpQWpPOGxPTmhYNmNUSVJ2K0g2SWltQVk5ejJGYmpD?=
 =?utf-8?B?V3dEb0NqaTV0SWdVdTdJVFJpYk9VenhnZURkSzg5NWRQRzdGdEMvWlV0YzRj?=
 =?utf-8?B?RWM1OWxGcjgwQ1pNRjVaWWpDaVZ1WTBVMWVGL2F4QmU5eGduQ09RelVLcW5T?=
 =?utf-8?B?bW5YVDJBY1FqelFxWHVBOTFwdW5lOEkrb1JHZnZxZUtxajVrei8vcnNsV284?=
 =?utf-8?B?WmtoRWxtdlJFakZYdEdPd256MjIxK1E3MVpkQk03aGdaYTRwVlp4OHRidUg5?=
 =?utf-8?B?WW5IMHdWbFhodGJYSWVmZWFiRGlmVkM4QnM0MVU1cDZVUXIyM0dGRW9GeGxF?=
 =?utf-8?Q?w2OgzqwuPDLGP5zub3eSC910J?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1606a36f-a823-4388-7cbe-08dcf837f612
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 16:37:21.9389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XNdJ3e5DblFkhIQSATpwjcg+vxhj00ZALCMQ18ngz3vWmZYEprdD6KbzSwuKAOYDSum6HewaVY9O20TtkmP+TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7577

Add support for i.MX8Q series (i.MX8QM, i.MX8QXP, and i.MX8DXL) PCIe
Endpoint (EP). On i.MX8Q platforms, the PCI bus addresses differ from the
CPU addresses. The DesignWare (DWC) driver already handles this in the
common code.

Reviewed-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Chagne from v3 to v7
- none
change from v2 to v3
- add Mani's review tag
- Add pci->using_dtbus_info = true;
---
 drivers/pci/controller/dwc/pci-imx6.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 8102a02a00b38..94f3411352bf0 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -70,6 +70,7 @@ enum imx_pcie_variants {
 	IMX8MQ_EP,
 	IMX8MM_EP,
 	IMX8MP_EP,
+	IMX8Q_EP,
 	IMX95_EP,
 };
 
@@ -1061,6 +1062,16 @@ static const struct pci_epc_features imx8m_pcie_epc_features = {
 	.align = SZ_64K,
 };
 
+static const struct pci_epc_features imx8q_pcie_epc_features = {
+	.linkup_notifier = false,
+	.msi_capable = true,
+	.msix_capable = false,
+	.bar[BAR_1] = { .type = BAR_RESERVED, },
+	.bar[BAR_3] = { .type = BAR_RESERVED, },
+	.bar[BAR_5] = { .type = BAR_RESERVED, },
+	.align = SZ_64K,
+};
+
 /*
  * BAR#	| Default BAR enable	| Default BAR Type	| Default BAR Size	| BAR Sizing Scheme
  * ================================================================================================
@@ -1627,6 +1638,14 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.epc_features = &imx8m_pcie_epc_features,
 		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
 	},
+	[IMX8Q_EP] = {
+		.variant = IMX8Q_EP,
+		.flags = IMX_PCIE_FLAG_HAS_PHYDRV,
+		.mode = DW_PCIE_EP_TYPE,
+		.epc_features = &imx8q_pcie_epc_features,
+		.clk_names = imx8q_clks,
+		.clks_cnt = ARRAY_SIZE(imx8q_clks),
+	},
 	[IMX95_EP] = {
 		.variant = IMX95_EP,
 		.flags = IMX_PCIE_FLAG_HAS_SERDES |
@@ -1656,6 +1675,7 @@ static const struct of_device_id imx_pcie_of_match[] = {
 	{ .compatible = "fsl,imx8mq-pcie-ep", .data = &drvdata[IMX8MQ_EP], },
 	{ .compatible = "fsl,imx8mm-pcie-ep", .data = &drvdata[IMX8MM_EP], },
 	{ .compatible = "fsl,imx8mp-pcie-ep", .data = &drvdata[IMX8MP_EP], },
+	{ .compatible = "fsl,imx8q-pcie-ep", .data = &drvdata[IMX8Q_EP], },
 	{ .compatible = "fsl,imx95-pcie-ep", .data = &drvdata[IMX95_EP], },
 	{},
 };

-- 
2.34.1


