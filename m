Return-Path: <linux-pci+bounces-14580-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D645E99F71C
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 21:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 960D12818F0
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 19:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DD71F5828;
	Tue, 15 Oct 2024 19:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TZLHBpPr"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2075.outbound.protection.outlook.com [40.107.104.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594361F80C6;
	Tue, 15 Oct 2024 19:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729019865; cv=fail; b=KlPsUg61CVTpPmDCwLjDGhaSHumSveoy/qsKWh0l9qqzV9wygpSHFhVkGYVgwfbAZBZv9IkmZBZ0Rlyx+o++Osseo8o1oJTdRkYsdrn/u142nDveMBDNVEvrw5lEQP4Q+grmOeuUguxUVCC4XS1RD9lR4Zw8MfFfuWHOzzoIXZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729019865; c=relaxed/simple;
	bh=eJwd3O4EeKnRheRlRCKKSYQF1KJCtHBDVtXu5oOnzWQ=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=HDw2D/PSD+zE2P/rmsWOnltVfqJoM+QkAHTPCQva9qkJAPcvT9SVQrlhMbVibEWeJU5OdBEmwqfQx+FvBTK6Y423IxfnpDvNEf099cO5BZX1cEV67SeNcjisvCXWcCeiHIgRPJlIXfmABHhVlb4k7/oiPJTYOStn6NKEsI1+4TI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TZLHBpPr; arc=fail smtp.client-ip=40.107.104.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mVleSjpkZiAfdC7L+n8luRgsqIbIKnd3UJuA9yQxa0PGUvzTZ7Iow3//jaTaNgYXz26oOvevnxpitzYoLR16Bmb8oNHeHSVEs1C4xIm2S0BFlitWHayoLdIRTdf+71jXJNqlt6ds0lnmA4McXNH6/8kU10GBXRDOZFMhN71ggd25hOP1ysZ6Z6XdS1vfgcOLU6dHlPqqFiANW6f+xEX3mf0Gp/nvMfqVMaE5pIM7+jpZ8TUtAO1OKNWJeT1LfjBqNrZcjCNzioN8xo8vWrshw85IZ4RiuU5jRzUpzyoAmqb2ih6yUnJZXJfaJ3FskVJJq2lW3dE0vHOpTEl3Xm91zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/xL6fBPQNfNADh+MdEADBRMiYQL3C2whQzkdaGtdHrY=;
 b=mVo0yGPepCS51b9rJpMZ5oVbEqjYWseHxtrx32/ssqp/DYdNpKCvQVG/NQ2335ObxS+w1Cm78MatxS0QJgUbJPdw+QhDwwrDJDp/zTlrcc2ZJ2QLMmDf6IQ0hPY753ucEbpsJvrgOLO3m+ZskzleJaBs555tVpCFHrFq5Atw/s2TgOnLhmFqD8rynWQtNVmkYssbY4QKgTmCktpIJRRgrb82ZdX95ClN33BAzrIU4ZVoIFY2xQT3FgX65O/xvzReG0ZTdv6uQ9fQ8f7I3BkY5p4tYllrbdyFkQYi0dseyL8nkQlKQIEs9UCdL8oivj8s7c2rfUwbKIjTU00/BnnPVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xL6fBPQNfNADh+MdEADBRMiYQL3C2whQzkdaGtdHrY=;
 b=TZLHBpPrRCz8iZIorvsboiSTYzWRU4x6vLGoAvOyHdnRYxyu4rd4ECyhoVehGLe0lRBt3h1JndqtXJPwl+T4ENrD9xTv/ld9Q7FMk0x4VMeHXcGUXwjK0Q6+XHVb+T8YbmYfWPsuqwoNC4PYp+3wIdnhPaRZYBlRFtpiHUmXpqMGDNud48cu1FK+tP4gIpP1piNCxR/5QOBZneOs8Q7H0gAitj+VpY2tSiy0Nm0IKqR+h4//h96xY3Q21WGff7tpjYi7vpMsgtXjAa4NSKp6TgTXFuKOzobD3DGWqHjrhvQl1QBh7qIBFzPjV8EdDLx+DOhFXNZnzRkXuWDlpvPHhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI2PR04MB11002.eurprd04.prod.outlook.com (2603:10a6:800:280::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 19:17:39 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.016; Tue, 15 Oct 2024
 19:17:39 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v5 0/3] PCI: dwc: opitimaze RC host pci_fixup_addr()
Date: Tue, 15 Oct 2024 15:17:16 -0400
Message-Id: <20241015-pci_fixup_addr-v5-0-ced556c85270@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALy/DmcC/3XMTW7CMBCG4asgr2s0Hs/khxX3QBVK7HHxoknkQ
 EQV5e51WBRQ1OU3o+ed1SgpyqgOu1klmeIY+y4P/tgpd2m6L9HR560QkKBG0oOL5xDvt+HceJ9
 0U3FRhbptW0sqoyFJ/j6Cp8+8L3G89unn0Z/Mev03NRkNmktvqKmNOArH7j7sXf+t1tCEr7jYY
 MxYiJGYjPhA79i+YAsbbDOuQKQEyxhc+Y7pDxuAaoMpY2RhBCi4bN0TL8vyC/CtRjRhAQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729019855; l=4828;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=eJwd3O4EeKnRheRlRCKKSYQF1KJCtHBDVtXu5oOnzWQ=;
 b=O1YSQCILgtibqeu/5G7czt6ZNbdcMoefNn6fMgbGBUFHtH8MA6lLhPLMu+ngYP7lGCCXuOdOk
 k3GLaX27qUBAwKuvzZoi8NZ4AkoRrlVWtmaFCqgdw0/W9Sd9wGAAjaX
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0117.namprd05.prod.outlook.com
 (2603:10b6:a03:334::32) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI2PR04MB11002:EE_
X-MS-Office365-Filtering-Correlation-Id: 65c57f40-7973-4103-18e9-08dced4e0921
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|7416014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VFplUW9NQnMzcHp5bHdkbzZ0dzJDZTlQREpMMThoVVRDelRFV2M0aWZoOGZ6?=
 =?utf-8?B?bHFmSTgvRTRpdm5uL0JGYlY1a0FvRmZvYTNNSjdFODY4T1o4bld3Q1drejRW?=
 =?utf-8?B?VWw2L0FXWmV5WXNld1JPU1I1aG9tTWs2SlBsYVpMeXNmUG9zeFVRdVp4SWor?=
 =?utf-8?B?QS9BZy9XQ1p4WU05RUJuWFMySzBHUnNDWDY3Unl5NXRuNnI2RXRCVGR6a0tN?=
 =?utf-8?B?bkxBalNhZ1RpTWE0aXNYR2hKcnBPM1NrYkhTSldQSm9pcjZkZUh0WUFtRitP?=
 =?utf-8?B?NjhwWTBORVZPU0hRRWE2Zi9ST1ByKzV4Tktwa09iNk5sc2tKVVhZcHFiSmhH?=
 =?utf-8?B?Vk5DYTM2RDgwbTFNcHJVL2g2MnFvRkh5T3RyNlpKR1N4bzhQM3BXbThKNWlZ?=
 =?utf-8?B?RGhaNXhEOWUvMElLT3YvakYrYUlORERTZHVCY3ppMEE2Y0FOY3hqOXk0KzdC?=
 =?utf-8?B?enRuU0huZTg5SmpCK2YrUm5sVnBzWXBpbHNwT2NFUWc3QStaVVJYbEZpOGV2?=
 =?utf-8?B?SzNDVzdYRDBHQUdVU3JrVWU5RUhHM3B1L3Ntc2lob3haZVBiZytiMEFTVTZU?=
 =?utf-8?B?Z0g1MkljcjQ0ZXFGWmYrcVdSZllJY1h6MGpjcXgzZEcreTNYRFJ0bTkrNWpK?=
 =?utf-8?B?ancvc3V5cHgvVWFiNzEyVTNXVkY4aThwTXJQbkhZWktwWFhad3NOOVlzR3hv?=
 =?utf-8?B?RVc4MTJMUjRQZFVXVUc0OTc5NUVXNlVLU3ZzNXVjZ0xJWlJjWGlNaEc0OUpH?=
 =?utf-8?B?cGZ4Y2JUbGU1a3EyYXA3bzQrOStlV2YzUWo0dzdLS1JqVi83WFlwR2FmRm5t?=
 =?utf-8?B?QjVZUlBXR2puZTFXMkZ5elovMEpDaHRqNzllVENudEJDbmgwdEl1RXpud3pz?=
 =?utf-8?B?ZzdiN3JhandmUkZ6VGkzY2VkSGUyS0tmMUwvRk1OMnMxTEZPSnpkNTZwRC9W?=
 =?utf-8?B?anJ6QnJCZUJXYm5yKzVoYUY0a01adVk5Z1BhMTdGb01MQ2NBTHBwWFhqNUVx?=
 =?utf-8?B?c0sySnZCaGVSUTFPSS81Rnh1RFJ4cGhrWm9iZ1hQR3A2SFlEeENZUGFuQmpL?=
 =?utf-8?B?MXdBbng0aDVGaEhBcTJoZmNtby91ZHgvayt5em5RdTUxNTk5SW11QitSRzZ5?=
 =?utf-8?B?ODVRUE9TalZ6dGtGaE1jZ3BQNWxxT1dOOUROc0g0Z2x4bjZXbjFqQzVJSGh6?=
 =?utf-8?B?SWlhYWVFM1E3RTh5SW8wRW56KzJLUFVNcHhua2ljOTRyRTAwcnFXRFphd1Rp?=
 =?utf-8?B?WGpaUUF5eWtoUXAwMmFnMFA3U1JueTB3OXlyYm1wclh1MHBWbFRoWHAyV0Vk?=
 =?utf-8?B?ZE81U3Rtd3FYOWtVYXYrNHNqT3lydjdWZEZpbTJ6TVdOMDRyVmtIT3B3OTlI?=
 =?utf-8?B?dUlsZEkvRG0wU3JiSFBMR2Z0d3lodk85SGE4TUt2SVl5QzgyTFdScWd1NGEz?=
 =?utf-8?B?UE80d0NYZ2lJR2FVMWEyZitUVHZZSm9SbzJsV25iaU9jc05RK2hkcXFMZ3d1?=
 =?utf-8?B?S1krQ2diSGs1akpPUFI5eXhlYzNpbmFJc1ErNmgwSkhXeDRMUEJPeDVyRTFP?=
 =?utf-8?B?V3hSVk5NQUtrL3o3OUl3WnlSWXZFUy9Kd2F4dnlIRndJaGM4SFc4K01WVHMx?=
 =?utf-8?B?SGsvM1lNRDRtT1hRWnR2U29ySSs3bEhRck1STGJGT0FCcTlTZW5zVVg5ZER1?=
 =?utf-8?B?TldBeno5YnVVdDlLNklkbTNlOXlIUGFDTW9pU0tPOVlmRkcyZGJkQWFOdXM0?=
 =?utf-8?B?NHU0T0x0TU1hNUo1eDRjTDdsSzhRYlZZOURST0FJREJGZ2pCMmdjNXZPVzlu?=
 =?utf-8?Q?LpuDC07nX4J79W34za32hPDYQ5vnzd/aQM1Ug=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(7416014)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YmRJUEIwdjYxQ0dPTjdabW05MUdMVDhHRkZHa3NERy9tbUZKcnhUKzhlbCtr?=
 =?utf-8?B?ZjB3Tnp6aVZiRDgvM1oxWWUvL2tEUGJneXA4TFg2Zjlkb2VoRFpId3dPUkJM?=
 =?utf-8?B?dmRkVVdXTVlhYU9wUEk2cGs2YnltYWxlSEkwZTBtY3luU0hQYUlWTjZ6VG9U?=
 =?utf-8?B?YlRZNHRadWExR2lqa1FXTGZyUWJsTmIvNkRvTEgzdng0S2x1ZyswZGp5SVBZ?=
 =?utf-8?B?bVJlMFU1UitxQzlOdHd4Y0YxQTNyNisvNENCNnhwNDlreitUVVBFS2xuV1ZG?=
 =?utf-8?B?a0tLVG5oL2paTW5DT0twMW9IUmNoYzlRS3VyRG9CUFFtKytaSnZ6NlJneVRN?=
 =?utf-8?B?TFcrWnFML0hNcWlkQ3YvZEYxRVk1THJscllSeGd6OTZJQWthbnFxNGc5NXpK?=
 =?utf-8?B?cmVRSENYbHZreitiM1dXNGNNMnBuY2FWd2RUUWt3ekRVanlycGVRalZ1L0NQ?=
 =?utf-8?B?NjFac0pXdys5dTgvYyt5WHFZL204R0VONHFUVVBwVnRhUm9LQzFlYjhtMTli?=
 =?utf-8?B?MFBMTXhoRVFZdlo5RyswcTloY21VeDczTzQzVjZhcWJ6UVdjci9wT2NBMjNj?=
 =?utf-8?B?aUlhQmQ1QmxVdVlJZ0ZIMzhNVzZ4blQySnR4YzVUZHYrTFkvRThmb2ZPT2xX?=
 =?utf-8?B?YTA0VTQ5bXUwOUYzRGNtNGNoc0R4YWI1blhmN09ycERlYU5nUXphd05FclZ2?=
 =?utf-8?B?aHU4MWo0Z3psMW40emU2QkZ3U2JiWmRDU2NWNVpCR0xoRkJ5SHFIMzlzTGx5?=
 =?utf-8?B?RDhUWEVoUGJPZEU0L1l1eXJwZCtjNFhPSmpLZiswSmJ3a1NDTmt0aHh1eEVt?=
 =?utf-8?B?UVFRR05OUGhUWXZrdVhoS1ZsWHpMZ3o3RU9CRGlYWUhGY1F5aDBUalRDZjNh?=
 =?utf-8?B?VjZyUFZjMXBibDlvY3ZxekI0TnVKbUNMbEw2NElwQTNJM2Z6c3E2Y3NrOUFV?=
 =?utf-8?B?eEVpalg1eVhwRVlaRU8yWmlwRWNxNVYvWGFOQnJQRWZMamxkYXNkaFNJVUkx?=
 =?utf-8?B?cmxQYWtXbGZaWU5FMzVaWnNPd1VFd21mUzJzSlRtbXdhNTRFUHNNVjNKZDBZ?=
 =?utf-8?B?Vk80eGo4ellDajNuakx2eEc1UmgrbE9ibEkyN3FnTmphNktpa2I2L3ZBaWp6?=
 =?utf-8?B?NzJYd2lmelRwTjliZ1BQenNmVzFaelRiM0FyZVdtZFIraHlNamptbHJaeURJ?=
 =?utf-8?B?amJGbko5QUthNC9NUmdYN1BuNTVsajVNOXJuWHpDMXNkNXFUS1NDN2JobStO?=
 =?utf-8?B?dms2VWJpajJlK0hpVjdrODFBcWJuTm5YL2xtenJ2cUVRZTFrYXBCWlJ5TE0x?=
 =?utf-8?B?L2xUZjN6WUJSZkhlMVd4VCsrZTdnOFpIREl4TVVZRE1ENUhUbHloWFZvWERO?=
 =?utf-8?B?K2dJeVJwblBFMFJrSHZMd2U5ZUllQ1FTTjRSaW9DWEM3RnBGQVByRlN2dFVR?=
 =?utf-8?B?dCtqLy9XWjBybXFpVC9FekZqd0lIcUxtYlJsUktzUFRNRnBXUE12WkZTWVNN?=
 =?utf-8?B?T1Z4VzRVUmFQczVFZWhVMnVjTUd1RFVLWG9IUWNkWk1aWUJEZFFXMW83b0xw?=
 =?utf-8?B?UEJYS1IzNW9JRStQMzExakJKWTdRTlpjNVhheWdsblh6TXdWdXFWSkJvNURR?=
 =?utf-8?B?TUZkK2Y1M3RoNkxCZW5OK2FWMlZ0Z082MDltYlRESzBkRHlleWN6MG9uUVdX?=
 =?utf-8?B?aXp5SHpYcExpUWdQUmhZSlpLSmg2TXlVdGswY1RvM015dHR3RWM5L1JIQi9L?=
 =?utf-8?B?QTVEMHVVN2dXelpEc3dSdHFrSkw1TzU2N2cwUW5mV1VqRE9td0E4ajY0QVYx?=
 =?utf-8?B?eHhyZ3NnODZXOGRJUlg3YWxoaUlHS2dweEg3dDhweFk3bWtOVnUwUVozelJv?=
 =?utf-8?B?OHpNeVhpeUtYa29CQTZwSWVEOWkxd3pJODludDQrWlV5b0tHVTBoUVU2RkYv?=
 =?utf-8?B?Q2FFQm5USXVXVlppQWx4R1pjb3JKV2FEeE5xSTM3dEJJcGFoaXp6REZBTzlr?=
 =?utf-8?B?bitCYjgrUTVHUmN4UlBOQURKNGZ4ekYveldaazJpMEh0Q2loVXl0emFYdDFn?=
 =?utf-8?B?QXlEZEJFam50amJqZFczYTNBRENYWC9PRmpqbDFBY1I3bkg4RUNucCtHNm1n?=
 =?utf-8?Q?Budo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65c57f40-7973-4103-18e9-08dced4e0921
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 19:17:39.7119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E+8vqJu3CoR84OaADxU//PLUV0KNXF/KnEkmFkm5A46PVT7PYI7bI5o7C5ANoYDy7GUcK3h59SraNqQ/ujYCkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11002

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

EP side patch:
https://lore.kernel.org/linux-pci/20240923-pcie_ep_range-v2-0-78d2ea434d9f@nxp.com/T/#mfc73ca113a69ad2c0294a2e629ecee3105b72973

The both pave the road to eliminate ugle cpu_fixup_addr() callback function.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
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
Frank Li (3):
      of: address: Add parent_bus_addr to struct of_pci_range
      PCI: dwc: Using parent_bus_addr in of_range to eliminate cpu_addr_fixup()
      PCI: imx6: Remove cpu_addr_fixup()

 drivers/of/address.c                              |  2 ++
 drivers/pci/controller/dwc/pci-imx6.c             | 22 ++----------
 drivers/pci/controller/dwc/pcie-designware-host.c | 42 +++++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h      |  8 +++++
 include/linux/of_address.h                        |  1 +
 5 files changed, 55 insertions(+), 20 deletions(-)
---
base-commit: 9a3f54febedec23fde034d22bb19cf6f13143484
change-id: 20240924-pci_fixup_addr-a8568f9bbb34

Best regards,
---
Frank Li <Frank.Li@nxp.com>


