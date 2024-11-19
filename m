Return-Path: <linux-pci+bounces-17092-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F18359D2EF2
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2024 20:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADE6F28241E
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2024 19:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1CF1D0F7D;
	Tue, 19 Nov 2024 19:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ywpjj4y5"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2055.outbound.protection.outlook.com [40.107.21.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB061CCEFC;
	Tue, 19 Nov 2024 19:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732045480; cv=fail; b=i/e61aWHHak5mLD7nQceAsgdDyFf6aIlMA4QyT3QWGOa9ewpY9b4bCbISe7Vgk/J07oUleCKnTvCYhriVd3IEA1FoBn1tSvq8ZN6UpAGQm/EMX3AlVPneIML7v0KeH5AfDZgcGP4z3yzCQkXYtw9ePx7SDrquC8V2hfiox7j/HE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732045480; c=relaxed/simple;
	bh=ZHfAqHp2FUc8L0ahnN6zqGKA8d6SniNCeP/YcqMxWMU=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=gKM9DViXn3t/zrQxF5Qm1fpvshsUAldueEDH6ZG0hAsrcldL0pPRKhNlknOR3KOEtrfFh2BLLbT3CN+EnTMZ6Ud2F6LLZsKFjXYSBbzoVr03Em3bWIMnPJYWMBjborgmuXfQ/RdA588EcGqi3ayDz1LXw3j+ASfqdy9HGfUurAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ywpjj4y5; arc=fail smtp.client-ip=40.107.21.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qqOJBwiOzWNyfbyvNPq13BM83RfZIQwb4pbpoawnnQl1eZarbviVk+7m3lSwgYKkwmUp8TJ5/v2laUxvkJLnvFJvAmK6Ds9zGGz1IR4xwwlrKSObKi22QIEjVzSKngfoUOsFtItIVSbDMHSHdlL1L5Rv7t+5UxX75N8VLVQV1auHeZxtmEyy/2oTN+0cUBtp06HMZf8TQa42hwUdI9CzMmMXVuVHXTw/ug9H4KJRJrlwWlohcOcLnztpIvlCwdYKYC0NlpP93mMQmtCqzgBBlPoJK0Ts0ZHKYMdlb+JfjpJNTgJeO8DWRXOr629QdFHlQR2sHXLxj30jgDRws1mI6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DfdzY+3TdLFWlO+OUTtsUU+jP1elxIXTvN0R+8efR3U=;
 b=wgrwsxTEaguujDthQD6mZNH7BFvQ8+Et6NZe5/Eiogviq+R3ecvsDw4yPsZQxyGbwn4dAXzoNlpouXG5wugifUIi14hQE3RxAoNJbhkxcUs7aUum8x0Kpyq8fKJIZwjl4RekOeLnlUb90QlFhUi/rXNCGelK1aXVbrbDzlvwDeBCHv/NUnFwrC7lVraGdlxjGuTya2rnKAZAS4O5wGhRoDGrWP8ogRjBxvK7Z7C1/8fQPg3zuHCKpgO5LH/m2JxeivxfuYuf81cXSKJrOqFOB1DLOx4/HVMT6PZS/pMBRHUzM/pGpBNvjam3vgSQfm6J18vM3pnYh8PbG2iIgCOPQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DfdzY+3TdLFWlO+OUTtsUU+jP1elxIXTvN0R+8efR3U=;
 b=Ywpjj4y57mGYM4QMZx9NSfU5xUgmMkuHtHbWTjMNYBvDXI5bd7HVuJpLuEC46D3/cgYvM7fk7w1MaYpLjruZXAssXjJOtoEwqdcSUC+Q2aZy5UkRYa8GlUovR6F69qrQdBKoTLHBN5qT8CrFyDT7yAGDDxfFzOI7QO24R2NCt9+JaP9mirx8zhvHDRapY0dqVuP7bABRD0s58BtQPZYJsKSzxCa8sNDB4IcWppnyra9sLdzlR0cRiKQLxfHDSySJt9zxKX04//jryERDTy1KQyqEamLPdBaxNnNqlamJL0IpOLOPikrS411Lp9RfME0nZCyULUVPLs2swkIlMNgrHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB11068.eurprd04.prod.outlook.com (2603:10a6:150:215::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Tue, 19 Nov
 2024 19:44:34 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8158.021; Tue, 19 Nov 2024
 19:44:34 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v8 0/7] PCI: dwc: opitimaze RC Host/EP pci_fixup_addr()
Date: Tue, 19 Nov 2024 14:44:18 -0500
Message-Id: <20241119-pci_fixup_addr-v8-0-c4bfa5193288@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJLqPGcC/3XQwU7EIBAG4FfZcLZmgBmge/I9jNkUGFwOtk2rz
 ZpN3126B9NKPP6Q74eZu5h5yjyL8+kuJl7ynIe+BPd0EuHa9e/c5FiyUKAQWoXNGPIl5dvXeOl
 inJrOkXGp9d5rFAWNE5fbR+HrW8nXPH8O0/ejf5Hb6b9Vi2ygIRsldq3kgOmlv43PYfgQW9Gi9
 thUWBXMSAoJJceER6x3WEOFdcEOmC1oUinYI8ZfLAFchbFgRUwKwJD14YhphyVVmAoOHIlMcKQ
 sHLHZYVW/bLaZPfsQXYqY/izM7nFbYbvNrCXEoDB5u/v2uq4/GvtSqBgCAAA=
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
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732045469; l=8321;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=ZHfAqHp2FUc8L0ahnN6zqGKA8d6SniNCeP/YcqMxWMU=;
 b=JXrwzs+UuA2n/sYPhUOVhreK1Z9pZNKE86g8AFm5wT5PpqldU9MsxIgmm6e8ljubN9dKTpQLJ
 cxU4LCKA9CcCG7veElSZzfGwEYPUk9p2m85T43rOh6Nv4eS4bItqw7j
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
X-MS-Office365-Filtering-Correlation-Id: 25271a61-b9a1-45b8-0ea1-08dd08d297b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dmRQNWJ0S2dTMWRqQVBPdU54U2hzL3hDQVorL2RsN1NhWE1ibmREQklibG1n?=
 =?utf-8?B?azRoQ0p6cjVjVFVMWGZ4YmlTdlRnNDFGVU9yRXBRai8wbC9rUWZhMkhCWXpz?=
 =?utf-8?B?SXN5eDdKKzJVMGxKNnVBK0k1VVlxT2hSaDg3NTdZcEt0a2pxaXZuTVhBMWlO?=
 =?utf-8?B?eHo4QTF2dlNMa1UyLzVqb3c1bEFPN2F4L0NGTkxydlk5S3JhSG9xRG5hVHds?=
 =?utf-8?B?WDl3QUFJeWhGZ1VTSjlHZU5tSE13ZXpyV05vRzUwSjJLVFNpanBDWHZ2YmNP?=
 =?utf-8?B?aklUT2lZVmJuUURwODJBWFk4a2NnRnRySjNzbjZQQWJyeVZEQUhzei9RUDU0?=
 =?utf-8?B?cThRQnNmNUg1VEZVZGN0azBPbG1FNkhEV3lNbGNIOEx6Zng1N0JxR0FsQ0pv?=
 =?utf-8?B?aGM0RCs4R29OSXl5VkRrem94d0tTb1RzdHUvRjBQa3pLTlg0Y3A3eXJqcDBH?=
 =?utf-8?B?OFlVbFR2QjJ2Y3BFaURpK0pFQTZXWjNQNWRaSlJPZmRJN0Z2V2ZwRTNTUlg0?=
 =?utf-8?B?ZlkrQXNqSFRkVkJyU08wYWxHNjZsd2VrT1RsMEZRWlM3YXlJaXZoYXFGbitk?=
 =?utf-8?B?cHRqS0tGNmhUeEU0Rzl3b0d5cEozWXNKUVpoYjBHZmNWRXY5ckFKRmpIL1la?=
 =?utf-8?B?T1k4R1NhR2hoTTRlaDJtU2VnMjl5SktJNlBPUVhnV000OGlvZDM0dDF3L0sy?=
 =?utf-8?B?Yi9GTThIY2xsZE9FQzE4a3hPWXNhNTYzNDVvQmRFbSt5SVlvd0RubDlXdjQ4?=
 =?utf-8?B?MlhZeWkvNmtrQ2VNUFhNaC9LU0sycFZLY0EwSkxBbS9Udlk1eDdRYkRpbHkz?=
 =?utf-8?B?Q0ozUVJDQ2FGNEIxZVd1dTlCbzRsQk1WYmU5NnVGaDVmaWNrYjAxdG03dHQ5?=
 =?utf-8?B?MlFOenlzUFhtcjZjVnpMOUdoTzBxQUlsY3BKTjNRdUhTejdTRXo1bnZhUUhM?=
 =?utf-8?B?YWwwR3R3eTFDYjZUUkk0WG1zZDVXbERmNE42aE9qOUxQWXBvNGRNakk3TmFy?=
 =?utf-8?B?cjB6WVppcnRPd3MrNVpReWpYWHBZQzhjbWZXR1IwWjhQaGgzektIMEo0allh?=
 =?utf-8?B?dUhuZDZybnZ5OHUwWGZPemRwbVk1L3Zwa2IyM3YxUTJiNE9PVndGSE1nUUpZ?=
 =?utf-8?B?OHpTa2dzKzhlaDJZVzAyOUpGWllUUE5IVkVlc1k2aWZOUjM4dFBUOHBZZTM2?=
 =?utf-8?B?K3A4eGhmdG5pVU9vV3pDV3dubzRqbDdrc3MwNlFYR1lXVVFsZzljOWNpMTdj?=
 =?utf-8?B?RzhRZXJmZnl5Mm44eEY0R2hjeURxc2k0UWQxMHFoeTQyS0Z3M0RmdEdnVmlX?=
 =?utf-8?B?YzhmaHFONjhBejkyYTlBMHNkTTFQNSsrRG9pWkppQXE2WVkvZmVhMjEvaUFT?=
 =?utf-8?B?QVpGbHQxQkxYeFhUeHZoTEMvQlpoSXppeWwraGluUUpHSGVielYrWjNtQ3pP?=
 =?utf-8?B?ZHhiK1pqUCtxeERYN2xyZzcxVC9Kd1VOMjJjRzJrWEZ5LzEyUy9BcG9lQ1Z4?=
 =?utf-8?B?bThLN2sySHkxQ09peFR2OUxsNk9aNjRPZUNtRkhSdDJsVVpYb1hYOU1kM08x?=
 =?utf-8?B?RFpRTTNsS3IyaUM3MlZSZzVlZ1AvZkRERGF4eldjN3hiakNtOUlhSkR4ODYv?=
 =?utf-8?B?TlBaWHpJYnl1WUdVVW9OUGRzVk9NOHlhV1FWWG83ek1XK21xaE9MajNaQnlN?=
 =?utf-8?B?N1hOODgwNTV5ZlBEdWFkbmMzMGpNclF3VkhlNTNmbGNsZXRqWUF2RnM3YTRz?=
 =?utf-8?B?ZXhENCt5bEI3Q0RROFZ6Sisvc2RHUTExalhwREM0SFh5VTlHZmphd2ZJT01S?=
 =?utf-8?B?UW9lbUhIbnpUbmJuSWRxb3dUSXhhVWNLRXY0MlNjakN0Q3JQbXgwSldhQTU4?=
 =?utf-8?Q?671dDnRsfWoHH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1h2aktrZUgxRG5UOHFVOWRvN2hxSlNXYmNCOFpadU5KNC85Um11RG8rV3hD?=
 =?utf-8?B?a2dFck9UNmxDTFRPd1YzUTIzcVZuUngva1Q0WnhJbFRSS1UzdFVJRG96dzRN?=
 =?utf-8?B?MEdNM3dpNTgzeHdiSm5DU1U1bEZ3ekVXejBTWXJncUFPbWh2QW5lcU54blpR?=
 =?utf-8?B?VmRvbWZ1ZEZDYm1ERHlXYUFEYTBaVHlTUVRlQkIxZ0FmTzMwMGhGNHhYS21J?=
 =?utf-8?B?YUExaHZVYk96WGUrUkhJS08rKzNRQkFody9wSjlHekJtOXZscXpqRjB6OU5n?=
 =?utf-8?B?alE2a2FvamtxU25CeHU4Rm1JSHRnYzdWYmhFaUtSYlRCUnFXYmxzKytNVCs5?=
 =?utf-8?B?MEplUTZJdmlPbVlnS1hyZmpUa3ZCd3hJMHlUSkpGYnBYcDBrVXpMT3FRMi9V?=
 =?utf-8?B?UXFDcWRuT1gxRUJHYnlkUisranVIQjhKelUvcGhuRkF4VWhOL3BSUU5iMGE3?=
 =?utf-8?B?QVpSQnRtYlVvcDZYZkZCRStjTXZkdG1LcXg3WUp1ak9jRGxuNHlHRStZTEc2?=
 =?utf-8?B?WHRCdjJFTWFQSEpPSkNMRDRSM0tmUWJXTkdwZDZKMlV0ZGlqWFRDQ2pJVzZv?=
 =?utf-8?B?ZzJpMU5lSm5zb0xUdW4wcjBsOXgvODUyWW1LSFZ2Ty9oTDlNWWRyWmVrNlBY?=
 =?utf-8?B?dys5R2ZlbXB2S0RzZHBCclZzcXgrMGVhMlVkc3NMVDZmRlAxbm5XYWJtcUo4?=
 =?utf-8?B?OUtMdnBrQjUwTEFBUWhPQ2pjRm5HNTdTR3IvTThFWWFFMXpwMVFhdVVUamJS?=
 =?utf-8?B?VnZCNnZGTWdQUW9FZmExUDlsVU42a3hibWxSUDFlWjhLNFVHcXlGUGUzZmJi?=
 =?utf-8?B?a2dibVhMSEJkQUR5TnE4aEtCM3BIYlBJMDVWVlVjQ0cydDhaUHpTN2swNkRh?=
 =?utf-8?B?Y3VmT2VwQ2dqMy84a3ZCQzBYSnpZQ3dlTmlmZ2NkKzAyQTFWTGFvdG1LKzVO?=
 =?utf-8?B?cE45ajlwaHdndlNBdWNZSWF2SlRMRkVTVUNaSXBTZ1NLWFNmZkhoK0pjOWl5?=
 =?utf-8?B?Z25uU1FWNzhaYkNKZjU1Mlk5aDZiZGM2d0ZlZmt1akh6ZlAyWnFoL0g5M3FC?=
 =?utf-8?B?Zm5lYzNpd3JxUXJuUS9tQTVCS0M0UEhFNnZ0VmxBLzk0UTVOelhhWjdxMTA0?=
 =?utf-8?B?OEpTL0RhYTR2YmhBVlNXMDNwd0VTWnMyaENPdE42QWpIMExuMHZRNmMzUk5R?=
 =?utf-8?B?Z1I5ai9Kd2lUYUNQYXYzV2JxaEMweGIxMldWS2NtVytnYUVLK3RGaWNyU2o2?=
 =?utf-8?B?VlJORnZTS1ZibGhWYjloSG4vQ04rZTJpRk04ekdONnUyUWRuVWZsRkdXSkNP?=
 =?utf-8?B?ejVxcXpPNitNSUtzKzE1eUwxTTB3ZUZ2MEVOelZNRjNkSDBNNUJHR25GZzdj?=
 =?utf-8?B?THFYcEtnVFdPd3NLN3pQNDNDYXpZTVBPMzNGK2wvUTJFZkROZHVnekRFQkxl?=
 =?utf-8?B?OHBPU0tqZkFjZzlpdGtGK2tkNVZJa1p0QytCZjNjOUM4eXVldm9HMW1xTVJz?=
 =?utf-8?B?b1JWeUVQODlnYVA4RlNFdzJjdC9zUGM1K1p4cGduY0VIemM1U3pyeFVMRGhq?=
 =?utf-8?B?a09Fb2hlT2FvS3V0SDJvc0JnbFozb2VneERmYURqQUREQTZNQUgxcndDQ25h?=
 =?utf-8?B?VDQrOXRCc3Bad1NSU1BpVDBNM3dlY0NaOGNZMlo4NnJzVXk3UnltbnNYSFRU?=
 =?utf-8?B?OXZ0b1JEWWVZYnlaWEltdW5XNmtpRVNnNy9TVjUzNFh6Q2VvUGZtUXA5MGVQ?=
 =?utf-8?B?SlFGTXZaclRlbkNKSmlMTzJPdll3R1pGdU9Ic2lkUWhOUGNRekpJcmhsT0Uy?=
 =?utf-8?B?Y3g2VHFpbjZRRFV4aVpuTk1wbU9UQUdsdDNEQlowd0QwSTVsU3ZicC9ROERY?=
 =?utf-8?B?UDl6UFcxMnBWalFDR1g4TStkTy8wZVpwcmp1OE5TUmVJWE9FcVM0akkrRlQ5?=
 =?utf-8?B?OGlEOXhpVXZHeGMwYTNuK0phZVNQVElCMHBEVnlTWFhPY3B4S0ZSeDlsUkdT?=
 =?utf-8?B?R0h4RHZ3VEVBVXpIUlAvNEZsRmg4bGs3ZDUxWnJnVnpSOE52Q0g4ems4aTd3?=
 =?utf-8?B?eU8xZUpIMEsvNkZnMWR3bSs3cFJzMHFBY3ZyMHc5SFRTNnl2VWtLazF2RCt1?=
 =?utf-8?Q?2HXs=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25271a61-b9a1-45b8-0ea1-08dd08d297b7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 19:44:33.9571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6E7G7ZgDVEfvEZrU1hNDAB2IYd6xkktQHbpgFT9Qv6b/oB6sgNgXybgN/Zpto+BJXCQ8numCYHMRp/u3bVVi3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11068

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
      of: address: Add parent_bus_addr to struct of_pci_range
      PCI: dwc: Use devicetree 'ranges' property to get rid of cpu_addr_fixup() callback
      PCI: dwc: ep: Add bus_addr_base for outbound window
      PCI: imx6: Remove cpu_addr_fixup()
      dt-bindings: PCI: fsl,imx6q-pcie-ep: Add compatible string fsl,imx8q-pcie-ep
      PCI: imx6: Pass correct sub mode when calling phy_set_mode_ext()
      PCI: imx6: Add i.MX8Q PCIe Endpoint (EP) support

 .../devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml | 38 ++++++++++++++-
 drivers/of/address.c                               |  2 +
 drivers/pci/controller/dwc/pci-imx6.c              | 46 +++++++++--------
 drivers/pci/controller/dwc/pcie-designware-ep.c    | 18 ++++++-
 drivers/pci/controller/dwc/pcie-designware-host.c  | 57 +++++++++++++++++++++-
 drivers/pci/controller/dwc/pcie-designware.c       |  9 ++++
 drivers/pci/controller/dwc/pcie-designware.h       |  8 +++
 include/linux/of_address.h                         |  1 +
 8 files changed, 155 insertions(+), 24 deletions(-)
---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20240924-pci_fixup_addr-a8568f9bbb34

Best regards,
---
Frank Li <Frank.Li@nxp.com>


