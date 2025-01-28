Return-Path: <linux-pci+bounces-20504-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBD3A213DE
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 23:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E68A718895D9
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 22:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8E71C3BFE;
	Tue, 28 Jan 2025 22:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OCtLSXag"
X-Original-To: linux-pci@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013019.outbound.protection.outlook.com [40.107.159.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D0B19AD86;
	Tue, 28 Jan 2025 22:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738102110; cv=fail; b=OT3er1UgqSrdy926sueD2JDQqfxc3lGYKNViExM1u6tSVdbwmF9WsRQwD3aQkfFEXck/a4VG+VplGfylNkm7LeVukld7b79WBV7Cjh/8qm+4P5Yc7Mw52V4v98b6PyseIJL+BRnL+9u9T0080wM7KazISEEKvRyH5qSWDkEagGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738102110; c=relaxed/simple;
	bh=a06cLjebRMq7iVPAnU7NaTP56h6NgomTtXaHUCU61ck=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=vGne8HIbduwLcE0mSuqF0oEZiJ56EfvgmvnCBqg3nqzp3eFdyIvtX+gLcwFJCRi9wGxgQPUUUvmccNet1EOVXuaK5kexDq81yge5gcONWcyLXW2xUy6xnjPaaLMvQK8EDDuhASJ00cu5Wcem0U+w/vsAme4Ro77GeD67e02cubY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OCtLSXag; arc=fail smtp.client-ip=40.107.159.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uqG9d19yj/K8m1Y2m/W6VyiNqi/8Cc/IKJqFsfACYgX9/vbB03B67Kt3BXZeey5xVr4II4UKPE+7ZSEquynihmhanB+7kyKjFtgd6Ozjkn6QQY8FALxjELUKPDERLysokwPwVu4mqbG5xKuXdBw3WAXxCYLB80XI+PrEvN/XlIPJKR88lL3bN3RCvxWmnCYSDbNUfSFYZ+uMRaoifeTXAT3vMBjMD2GCBUs1Z4VFpEHuzArAjc1y1te0ONk6RN0ro47lBUOP3J8Vx7eOnhgk6kwvyHFs3uOrSKnO3mDlSmWrWr/EaT6QML6pjernpukk46FusVADn5hhFr1qm6VnPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dCKQlEJpo07jU5EJjFnfLwPZs6tuTxamS8VyFtNvFOo=;
 b=LX1ygmzWPtNMJ/f4Q/mgcKGzn9UM/sKTgSR4UCISqNNusYuSXXZ/X6yMQRUxIF45zgho8hu8iLFim876QdUvBSsSeAwEN4FXd5aQmzUfDvn2fdqLVIxaRYLl8HQm7brA/mj+tpETkfamWunZzVx7Ij7diaUWQpmRjL83estUTZdlmmorgyUx36H1eET0WUsTWY0Lnw5KLRrP4Arxh4IZKgznAFgsG84zEoVdLkHwLI+BMnTSLchqPyFlrqZ0inMyLoo537h1NOZoHAm0olcHsYJISIYSmbLwSlDgrS0Zwrt2ICxpOz+VkKnhM5XcZNYbl12fw7fh4dwM5CBTHI/7iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCKQlEJpo07jU5EJjFnfLwPZs6tuTxamS8VyFtNvFOo=;
 b=OCtLSXagppTlK1NixDrohuEs7Il1EesBE3Zu87awi3vsx7MUfwgmbGf0t+nQv8kqQie+spg30JBxVwmqGkCGNSK9bgi/MF7eBH1Snkj0yob49FISvZmZwFQovepyQjEYoWcTll/j+gDr8F856YA/0JpTGtxeE827R03GPmGpy7UoDGIMJCrF3KA69OCZTP2BMebPZR2NKaikmFJwfvgeSn+HwvwD3ZdSQR06h7SCkCOfHix7ENYyKQ5nczlKN351S6FaFga23Flm1qI89PT5DGvdplaKUKJru5u0Rn7w5mCH535U+cQ16UFq28R/VOA8plWw8a1JRXK9mb98AeKhtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8555.eurprd04.prod.outlook.com (2603:10a6:20b:436::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Tue, 28 Jan
 2025 22:08:24 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8377.021; Tue, 28 Jan 2025
 22:08:24 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v9 0/7] PCI: dwc: opitimaze RC Host/EP pci_fixup_addr()
Date: Tue, 28 Jan 2025 17:07:33 -0500
Message-Id: <20250128-pci_fixup_addr-v9-0-3c4bb506f665@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACVVmWcC/3XQQW7DIBAF0KtErOsKhhnAXfUeVRUZGBoWjS27t
 VJFvntxFo0d1OUHvc8MVzHxmHkSL4erGHnOU+7PJbRPBxFO3fmDmxxLFiABZQvYDCEfU758D8c
 uxrHpHBmXWu+9RlHQMHK5vRW+vZd8ytNXP/7c+me1nv5bNatGNmSjwq5VHDC9ni/Dc+g/xVo0w
 xabCkPBjARIqDgm3GO9wVpWWBfsJLOVmiAFu8f4h5WUrsJYMBATSGnI+rDHtMGKKkwFB45EJjg
 CK/fYbDDUL5t1Z88+RJcipocPs1vcVtiuO2slYwBM3j6M7e5YqRq7dWz0qSPVanDujpdl+QV7L
 SwFVQIAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738102098; l=10225;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=a06cLjebRMq7iVPAnU7NaTP56h6NgomTtXaHUCU61ck=;
 b=WhuK03KvdPNB3OnChJxT90PK3fbE4w06akDL2LQLSJUnAPC+YM3//NtQsGFkvx9KEkQdoVgBy
 dKuApUHNTTXDEGilPbfO114NnuFfDT4ACRLy872LzqlLrBocc7XO59E
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
X-MS-Office365-Filtering-Correlation-Id: 76cc1474-a4fe-491d-836b-08dd3fe848bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TDBzdnpkRGhmWHl1ZE1iQTFMblMrWHlHZEx0TkQ2ckg4bXVSYW8xazcvZTlm?=
 =?utf-8?B?THM1Q053VEZ2N1VDUE5rVXBOODQ2bGRTT3RRa3UyeGNaeElzNHFIdy9XTGRN?=
 =?utf-8?B?YVhHRHJVTWNyRndNK25LcmJJeHFyQ2FuM1JJejJsMHhqUldmWkhQbFhUdjhJ?=
 =?utf-8?B?L2JTTEhqVytLRE9VN1VBa2JMcjhwczVReithOE0vVnFCRWZMbXA2ODZ1Skgz?=
 =?utf-8?B?ZlNqbTFodk9tTEE5TXNTaDV1WlVtTmZlQldFWjdjblJZcnVrZlJLeFpDdnl0?=
 =?utf-8?B?WHV4ak1RMldFcEwxQjJlbVVpQzBmMnpZTUp1N0xqTXJyVmlkQ2IwTHlyblFk?=
 =?utf-8?B?UjJncDQ1RnF5QUJSeHdUTkZIaitSSWhyS3hrUTVLZ0c1Q0pndzB4d1A5WXJ0?=
 =?utf-8?B?SDFyNGVkeURHYmxyT0lORzc2SnhBNUtrUjd6NjdYdTJwa2haUGVRTW00UVJS?=
 =?utf-8?B?Umd3QW1rUVNpTzhCZStuY21nUEluZ2pSa0ZWWmFzWCtWN0EyNHoxUzFhakxh?=
 =?utf-8?B?U29IUU5USldoRUl6MDcxTGxMMW9ReWhhMlZ5UzNQY2JMYm9hZk8xU1dDVzdl?=
 =?utf-8?B?enliMWRiWGc2Q0tzeitnenhvTnFBalhiaEIrOE4vSEZHaDVDL2lFQXlxYXBY?=
 =?utf-8?B?VWpKblE5RkV3N0JCeHdnSC95RmlTUVV0NDFRMnJZUHZYcmVzd2FVKzFTSjhX?=
 =?utf-8?B?YzJRbWV3SlM0N283Yy9kcDlXdE1XQzEyNjN5L3FZVmJ3WmxHc3JZZmFyRmdu?=
 =?utf-8?B?ZFlrcnA4WDRlcklFZE9UYVdNYlVxaTlRUytWQWRJQi9id2o0VDJqM3BPZ2Q1?=
 =?utf-8?B?aGt3VDgrWGgydStKemp4Q25oUTViMDZBeFRQdWN2cmppKys0d0l1cExkT3p6?=
 =?utf-8?B?TVZlVndoY2dwUklxY1NZY2dDdlJYdUpHVUVUY05DcmEzMXB3TUhYVnM0WE54?=
 =?utf-8?B?aHJKaDBSczBLWWdnckY1WFlLTDBqZS81dWxYRVZVQ21JZGpxMjU5WG1tVCtG?=
 =?utf-8?B?YWRacVVkOERRUE1zd0Z4M2RvdjNEUXdhVUtPbzdsdUEzRDBZVm90U1JnckFp?=
 =?utf-8?B?TC9YYkVvcFlCKzV3UWpHVjF5L2hMdXhCY1FsRk9uU2VjZEo3a1REYzR3NUZC?=
 =?utf-8?B?a1pJV2QrUENVUWJGZkY3WmhQRWg2YnZVbEQyOXNOZ2FEZjdIMFhzbGhhUkVU?=
 =?utf-8?B?MzhZMyt3UGM5RE1XNVplb09KRElMUzZtUXBKamROdVcvZ1o4QUk1OGtmWGQ5?=
 =?utf-8?B?czIxS1Bab1hLN1FucSs2cDZ0NDFrR1dZcFBOZGVkVU5PNHVielE1bU0yaDBI?=
 =?utf-8?B?dElrbnVXL0t0d01LQ1g4QTBpYnEvNVZSaGNiVVEraVJOZnNxSGtOVVZJOGpw?=
 =?utf-8?B?dWtudzlVVkNmQkU5WEhCM2JjWHpJam0vdTlHRjB0NVAxRjQwTkxaRVFLRHho?=
 =?utf-8?B?cEZrSngwdGFrbnF5TUlqaUd5QkFSVzZQWjAxNlZsNEk2MTIvWjJLWjU4Uks5?=
 =?utf-8?B?TjV4K3dla3FXUk9YSkhUeU1oVkpoT0Vid0hlaCtBUDZYWWVYdHNDdm5NaVVk?=
 =?utf-8?B?bXZaaDNpY0dRWUJJZEl5cGJTZE1PY3pORVMyMmtLcEJBNHFCQWRpRHM0b01j?=
 =?utf-8?B?R1lMM0FQa1RWUm9vNkVkZ1J4aktaMlhHN1lNTHFzbzNXODFZSFlkWVhDWmZw?=
 =?utf-8?B?QitjYlltQ3l6alo0dHh2WnJXYTlFYndEclN0dGFIckJsMzFDWmgzaFBBM2tG?=
 =?utf-8?B?Ylg1b1F0cGszWkRRTlBwWCtHaHd0V1IwZWIzV2M2dllEUnN2WkVFWWZ0OEoz?=
 =?utf-8?B?VkdUUm5ERVlta3R3STRneFJXYjZKMldBYU9pSVFTVUYvR09CTWRmYVdNS2I3?=
 =?utf-8?B?LzIxcTFGZnpzcjR2cU05RFlnMCsydnI4cGp4UGNRRkhzTUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SDBlSSs3emdyUUpEWmpVcDA1OE1YL3JTUDlva0N4ckc0YjB3Mm43bURsWndh?=
 =?utf-8?B?RnlyYW9pM1QrbFV6M0JZd01oTzVicGowblN2M0FsVzJ6UE9VeUEraVJiOG9u?=
 =?utf-8?B?UTgzdmM1bW5XdHdncjBNa0N1RkU2V1U2dnVyMWJ2QlZ3b08ydStrVmxGeUUv?=
 =?utf-8?B?QVRNNkc3dDU2WHBMbHVVTlNTd1ZpTHVVU2grb3U4bXlhY0dzWHNzQW9uN0V6?=
 =?utf-8?B?RVlBbWxVdEt5SWNSTzZuLzZ4ZEczc1pzZ24rNWlUT3k5aEJGVHRmUThySDZr?=
 =?utf-8?B?OUM1ZFJyaU1xV3pWM3YzTE04ZXNHMEdEQXBvdWs5R1Y5N045K2llRHhXQU9u?=
 =?utf-8?B?RjRaTDdCYjYrNEV4Qm5LUGhjYmpaRzcwU1VFcEpFTzBsckd4OGpFRFlaN2FN?=
 =?utf-8?B?UDV0Y3ZjUFMrc3pjZU5YYVlFR3ZIKytkU1p0R3FjM3FxR3Q5c1NhN2lWME9l?=
 =?utf-8?B?aUFtRjAwVmUyRnd1N3FFU2NDUjNpQ01hMDhXMTZKdkJLMFpvdUtNTUQxbURH?=
 =?utf-8?B?ZlQ1YzV4NWFFYWFNYk9kNFdlTUFDV3ZxdU95L080dnNaOGRXbmhCQS9rOG5a?=
 =?utf-8?B?WENSWkVvQ0NaQy93NHk1a0hxYjhUemlHaEx1YnR2U09ubDJxYStpZ1Q4WnUw?=
 =?utf-8?B?RTA0WUpBWFBmdlhaSldZcmlWRHhWUkwwTm04VHZjeElmY3BLNE1qK0Y2dUNy?=
 =?utf-8?B?cnM2MUsyTFdLcExxa3hoalczZ1FxWk1CTlQzS1IweFNlYUpZREY3SFVZODVY?=
 =?utf-8?B?OHNpaDN4T1FxYTNTa0VaN05tVmN0T0QvTzkveWllY25RRzM1UUZENUFvcEJU?=
 =?utf-8?B?ZGptV2h2NHIrY1NYYjVnV1FHYWd3OTJqcGZhT2tOeVNBTFl6azBSandhM1Bl?=
 =?utf-8?B?ZGgwUVI5MEMxeWt3T21DSEw4Z1BybnlKT21MZHRPTEN6WnJGZEhVWUNHVklZ?=
 =?utf-8?B?NEdjVmszL3k4L3dSOG4rOXJHeC9JWHBDejBTVXJwYTdKZG5XaElSTmZEdVJJ?=
 =?utf-8?B?VmhsSVpmTWc1UnA1OVdlOWdnZEpaVHB1d0lTRzZkWDZxcjRYN3BHZWRyUlpL?=
 =?utf-8?B?WkxwUmlRQlBqTFFSdWJtU3RqNStZVGRtOEJVUkR0NUNzTXM5SjJtaFd3WFIx?=
 =?utf-8?B?aXBGUEw0NXhPTng2d3d0b015d2YrMXQ3S1JvTzJLTGs0OTVXUFBsemNsMVV6?=
 =?utf-8?B?TkJEc3VISWdrSk5PVGdtLzBIY3l0TEFZN2VTT1FWWXBVSlpIbU9icjFJZGhB?=
 =?utf-8?B?SWJwSS90dHBkeFlFc3llM3JNa0xFNDdkRFMrT1VNeFBwSFFCeGM5OFEwYm45?=
 =?utf-8?B?eEhtMGM5d3ozZGl1M084QldVSWJJOTU1WHNqK3ZjNjI3cmxNcWRvTUNGNXBR?=
 =?utf-8?B?czdvOVRvTHljR3REMVV4YXA5SVI0amJYaW9qdHdkSWJwRkNWbkY1MGpTYUZ6?=
 =?utf-8?B?RlAzeS9uVFlDa0JnOE43Q0FUOHMxb0VzOG5QcmdtbTIwMXVLcDR0TXZ6SHRh?=
 =?utf-8?B?bmFFK1J5d1NNSHMrU28wZ2E5dEt0RlpJNE9OUGUxRDBUR3locGVHSGl4dFNr?=
 =?utf-8?B?WUdwQXFrLzV2Qy9nc0FNVEF6dVdBWmhSeVdkYUk1L3FNZ2lJSy9Da29Jdkw4?=
 =?utf-8?B?SFBWQTN1V1MwNi9CcmpaMitERDgyMjFxL0ExdUQ1S1RPTkZmTW1RYnExMTdo?=
 =?utf-8?B?M3pGZEg1NXlVUjFnSm1naFd3MWYyMXY2TFhaYURDRm53QlRKTHRMR2tSdEZW?=
 =?utf-8?B?Rys0RkY5TSttbEhKZkRNRGs4QjJoVmljV1ViYkxOSEpwd0x3QzFValNUZDBE?=
 =?utf-8?B?bk12OE54akVzUnJFVXY3TWxUWjBzK2dvYlNLV1pqeURUK01jZitqMVRINVBH?=
 =?utf-8?B?UmNPSFBGWU1kV3hUbkNkOGl6bmkrbmpHa01TcGVCNnZxejNMcktVQng5NDlV?=
 =?utf-8?B?Q2NxMlAwOEw1MG1uV0RnZURteWZ0T1VBNUxsZmRObzNhTCtZZ3hOOWU1Mzlx?=
 =?utf-8?B?N0hWVnE5SlJRZytJTjRtY1M4ZjQ5eWJrWlFKQmp4MlN1b0pZZGg5cExvNENC?=
 =?utf-8?B?MVo5WU5jcnVpOEVycit1YlVnSmxBeEdDTnpJWlg2bVVKVmNuMUYrQ2drS1lH?=
 =?utf-8?Q?rRW2laRzTGXTgN3cTC2HmhTt+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76cc1474-a4fe-491d-836b-08dd3fe848bf
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 22:08:24.3228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Q9GV9+NHq7K/bxbS452SCkLFnGGvK55qSyCgutHeBVSMqBbdgUFWxSx5xjkaaMftI+rK7ixrkWrCNBLWrvsgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8555

== RC side:

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

== EP side:

                   Endpoint
  ┌───────────────────────────────────────────────┐
  │                             pcie-ep@5f010000  │
  │                             ┌────────────────┐│
  │                             │   Endpoint     ││
  │                             │   PCIe         ││
  │                             │   Controller   ││
  │           bus@5f000000      │                ││
  │           ┌──────────┐      │                ││
  │           │          │ Outbound Transfer     ││
  │┌─────┐    │  Bus     ┼─────►│ ATU  ──────────┬┬─────►
  ││     │    │  Fabric  │Bus   │                ││PCI Addr
  ││ CPU ├───►│          │Addr  │                ││0xA000_0000
  ││     │CPU │          │0x8000_0000            ││
  │└─────┘Addr└──────────┘      │                ││
  │       0x7000_0000           └────────────────┘│
  └───────────────────────────────────────────────┘

bus@5f000000 {
        compatible = "simple-bus";
        ranges = <0x80000000 0x0 0x70000000 0x10000000>;

        pcie-ep@5f010000 {
                reg = <0x5f010000 0x00010000>,
                      <0x80000000 0x10000000>;
                reg-names = "dbi", "addr_space";
                ...                ^^^^
        };
        ...
};

Add `bus_addr_base` to configure the outbound window address for CPU write.
The BUS fabric generally passes the same address to the PCIe EP controller,
but some BUS fabrics convert the address before sending it to the PCIe EP
controller.

Above diagram, CPU write data to outbound windows address 0x7000_0000,
Bus fabric convert it to 0x8000_0000. ATU should use BUS address
0x8000_0000 as input address and convert to PCI address 0xA000_0000.

Previously, `cpu_addr_fixup()` was used to handle address conversion. Now,
the device tree provides this information.

The both pave the road to eliminate ugle cpu_fixup_addr() callback function.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v9:
- There are some change in patches, if need drop review-tags, let me known.
- DTS part: https://lore.kernel.org/imx/20250128211559.1582598-2-Frank.Li@nxp.com/T/#u
- Keep "use_parent_dt_ranges" flags because need below combine logic

cpu_addr_fixup  use_parent_dt_ranges
NULL		X			No difference.
!NULL		true			Use device tree parent_address informaion [1]
!NULL		false			Keep use lagency method	[2]

Generally DTS is in different maintainer tree. It need two steps to cleanup
cpu_address_fixup() to avoid function block.
1. Update dts, which reflect the correct bus fabric behavior.
2. set "use_parent_dt_ranges" to true, then remove "cpu_address_fixup()" callback
in platform driver.

Bjorn's comments in https://lore.kernel.org/imx/20250123190900.GA650360@bhelgaas/

> After all cpu_address_fixup() removed, we can remove use_parent_dt_ranges
> in one clean up patches.
>
>
  ...
>  dw_pcie_rd_other_conf
>  dw_pcie_wr_other_conf
>    dw_pcie_prog_outbound_atu() only called if pp->cfg0_io_shared,
>    after an ECAM map via dw_pcie_other_conf_map_bus() and subsequent
>    successful access; atu.cpu_addr came from pp->io_base, set by
>    dw_pcie_host_init() from pci_pio_to_address(), which I'm pretty
>    sure returns a CPU address.

io_base is parent_bus_address

>    So this still looks wrong to me.  In addition, I think doing the
>    ATU setup in *_map() and restore in *rd/wr_other_conf() is ugly
>    and looks unreliable.

....

>  dw_pcie_pme_turn_off
>    atu.cpu_addr came from pp.msg_res, set by
>    dw_pcie_host_request_msg_tlp_res() to a CPU address at the end of
>    the first MMIO bridge window.  This one also looks wrong to me.

Fixed at this version.

- Link to v8: https://lore.kernel.org/r/20241119-pci_fixup_addr-v8-0-c4bfa5193288@nxp.com

Changes in v8:
- Add mani's review tages
- use rename use_dt_ranges to use_parent_dt_ranges
- Add dev_warn_once to reminder to fix their dt file and remove
cpu_fixup_addr() callback.
- rename dw_pcie_get_untranslate_addr() to dw_pcie_get_parent_addr()
- Link to v7: https://lore.kernel.org/r/20241029-pci_fixup_addr-v7-0-8310dc24fb7c@nxp.com

Changes in v7:
- fix
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410291546.kvgEWJv7-lkp@intel.com/
- Link to v6: https://lore.kernel.org/r/20241028-pci_fixup_addr-v6-0-ebebcd8fd4ff@nxp.com

Changes in v6:
- merge RC and EP to one thread!
- Link to v5: https://lore.kernel.org/r/20241015-pci_fixup_addr-v5-0-ced556c85270@nxp.com

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
Frank Li (7):
      PCI: dwc: Use resource start as iomap() input in dw_pcie_pme_turn_off()
      PCI: dwc: Rename cpu_addr to parent_bus_addr for ATU configuration
      PCI: Add parent_bus_offset to resource_entry
      PCI: dwc: Use devicetree 'ranges' property to get rid of cpu_addr_fixup() callback
      PCI: dwc: ep: Add parent_bus_addr for outbound window
      PCI: dwc: ep: Ensure proper iteration over outbound map windows
      PCI: imx6: Remove cpu_addr_fixup()

 drivers/pci/bus.c                                 | 11 +++++-
 drivers/pci/controller/dwc/pci-imx6.c             | 18 +--------
 drivers/pci/controller/dwc/pcie-designware-ep.c   | 29 +++++++++++---
 drivers/pci/controller/dwc/pcie-designware-host.c | 46 +++++++++++++++++++----
 drivers/pci/controller/dwc/pcie-designware.c      | 43 ++++++++++++---------
 drivers/pci/controller/dwc/pcie-designware.h      | 11 +++++-
 drivers/pci/of.c                                  | 12 +++++-
 include/linux/pci.h                               |  2 +
 include/linux/resource_ext.h                      |  1 +
 9 files changed, 121 insertions(+), 52 deletions(-)
---
base-commit: 5fcc194143ce5918ea0790a16323a844c5ab9499
change-id: 20240924-pci_fixup_addr-a8568f9bbb34

Best regards,
---
Frank Li <Frank.Li@nxp.com>


