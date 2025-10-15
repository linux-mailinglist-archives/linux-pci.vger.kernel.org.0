Return-Path: <linux-pci+bounces-38235-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D34DBDF57D
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 17:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3689F4EFEA4
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 15:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B589257853;
	Wed, 15 Oct 2025 15:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aEch4rpM"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011061.outbound.protection.outlook.com [52.101.65.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B9E2D3ECA;
	Wed, 15 Oct 2025 15:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760542074; cv=fail; b=RxzxGpQkzfsb32t51xP3gTV+l0vgZqd6801MwuLoECXpl4ZQelU/GIYz9gM/1EVSCJOdoWT8fhpXM8ma45lL8RQ7xy7//AERo1vUcHh55AFsQ3uMZpWaTtF7TeDqqHyoJlRh9SLe2kIsDfDnSVlWMShkoWxCyoTwfnMVQcwCLbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760542074; c=relaxed/simple;
	bh=78WVvFO7/sJP5lg46AWfuG9YmiZ9TBKJJpeELblYU7E=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=e0EARLyG59t5mZXMcH+z8sOGHk0XHSr4xkBVt19LDIQq/bXaGwi4r/eD/rfjufmvnK04UB54F8GHuxZZkhXhLG0XbpW8WqtgoMR+9iIQRXGoCQ70hlKW9AsNGWkq3di4dwIgG9EKtOrWvg3MhuctyWYUxEEjg9QGY2OfokzADTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aEch4rpM; arc=fail smtp.client-ip=52.101.65.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vx5wyqeZTJVhGaatwr/4HjfkkkV3og0JsNWtW9B5RTiLK9tXvXO7AHBh+e63S0GWxrm59a7IAKGjK2Un19o28QMVtWhtpyu3geUGzdTU1p8+zwilDkbD+n81sCmFa4Jsyc7KMma84Iubf7multgI1xgR/jRhp5A+enXPySjaXAFVFiMMwyx44+NBfeUnwComZPan48oxf4szjJ9cyrvcLcw43X+r4zyAXxMl80aeWiEF1C5tvOEHnhjnWZFGNq/L9qS2W6Yi5PntnJ5BOBa4S8BAiIyiFj7nc9jpj/6dHGD9XkzleAvRUOxH15zjB6qlJP3cCx8BtAc7dSEKl6pcBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a7XsFVjpLIcWoofJggFwaAEYgPPYMihZqYC5fiVnRxw=;
 b=pmL0hn61gdGgSGrHXsDbZWfagkB76GAzLA4m3vGYRfe2DAcOnpumzfMVEdWj8BTpz6zT5OI6P/cUnNjL5FSwCySj/N/v9AsUK/Pks2h8dqh/zHqPM8Cu8xGc2j8MRJ+7MgmGZSlvGiCGEFaHpZn4eUn9s4cOX2galkPpwfsdze//6a5wp4h+rP10DWwvhyhRnDofTMyCZXdDDn3QUqHivw73uCtBzSP12bY9dA8phy1gNckQTDfsktu5CNfoxu071xcIs6sdzfX4jTaULrrZTUoXnQbuHAR3VikRyRo+bcV7fzUv1wDQaOx+HMUH+TgYiEREKJL7A8sqNQREUs4eaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7XsFVjpLIcWoofJggFwaAEYgPPYMihZqYC5fiVnRxw=;
 b=aEch4rpMr2bMZTciBzRYmKv+hkUIsxUjz4pcc1+vVhN90XZbFhkWjRLGJwUkByNFsSRYr9ucpRbjJTfadPUTLnAPWX5pV82N9ADY7VqAQmmJetjsXcwLD7mYKoBq9GVOB4KSMwlVv+3qc0VZlotvNXCAdsgjLViAPjalG41rvRQMXRdDmsLv6tzbP/8EHJwBTIUCLDnt/QVB4q/qtF4DBwtkgCqI3pu9slE6C2GfSTPp49en5Ij0SWRdifM6cXq2elqYUtAygWS/ez4EBqRqr5gZIOVtxydHIrrNoqp4sigTx93HAszyqqOxl+VsqPMWjitAEMWLQ0/AAuiokJmQVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AM0PR04MB6993.eurprd04.prod.outlook.com (2603:10a6:208:17d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Wed, 15 Oct
 2025 15:27:47 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9228.010; Wed, 15 Oct 2025
 15:27:47 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v6 0/4] pci: endpoint: vntb: add MSI doorbell support
Date: Wed, 15 Oct 2025 11:27:27 -0400
Message-Id: <20251015-vntb_msi_doorbell-v6-0-9230298b1910@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF+972gC/23QzWoDIRSG4VsJrmvxf2pWvY9Sgh6PjZCMQYOkh
 Ln3OoE2SXH5Cc97wCupWBJWst1cScGWaspzH+ZlQ2Dv5i+kKfRNBBOavXFB23z2u2NNu5Bz8Xg
 4UB9Z9A5MMGEi3Z0KxnS5NT8++96nes7l+3ai8fX1t6YHtcYpo1KEaED5aA28z5fTK+QjWVtN3
 L0de9E9uIkbplEqpZ69fPBi6GX3DplnYCU4h89ePXjJRl51j06AVWBiFP+8/vOcMTvyunsF0U9
 +/QHkd78syw8wtJ4/sAEAAA==
X-Change-ID: 20250812-vntb_msi_doorbell-bf0fbac6d6d7
To: Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Jon Mason <jdmason@kudzu.us>, 
 Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 ntb@lists.linux.dev, imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>, 
 Niklas Cassel <cassel@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760542064; l=2008;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=78WVvFO7/sJP5lg46AWfuG9YmiZ9TBKJJpeELblYU7E=;
 b=lnKEkrNaz/pqf0kZfP4Sk0PcVxM6Eqkw5OVS+OZBNtEf+FizRhPnaHiflPemJz/g7BDL/c5Q+
 N8NvqGVvgNcACnI0/+QiJXyPp7xE0BlcUrVwH+D/8/DY8LJGcYaL3e8
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR04CA0007.namprd04.prod.outlook.com
 (2603:10b6:a03:217::12) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AM0PR04MB6993:EE_
X-MS-Office365-Filtering-Correlation-Id: d43a3a92-d6ad-45f2-9ec7-08de0bff6502
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZXIxd0UyZkFtR0k4cytHYTJSc05IRmtJV0ZlK0pkUGtxUHRoTkc4bVRualRv?=
 =?utf-8?B?YlpMMkV4ZFlKQ1NiTit6QXNqZW0vUS9YNnJUYy9ZeTZqcnhyRTNCelJ0a3BH?=
 =?utf-8?B?bldnRFp6a0pwanI1b211bzE1aFRQQmYyakMxYXBUZ3k0YjNxdWFtTWZoTXFS?=
 =?utf-8?B?U1g2NE4yRmlQMGhINUZpNDZCYnByYnVYOWhPREs5VVVZUVZLMUhlZ1k4TkpV?=
 =?utf-8?B?ZU5HbTV0SHpISHA3WmFCWG5peG4yTERuSzVRaWxyRDNWMnUxZnMyWEhvNjdu?=
 =?utf-8?B?d3lOdTUxUFBuRkY5S1dZS0ZmTjZwUC9LNUxhZ3JuR3VDRzBNMjg3VHQ3dW9Q?=
 =?utf-8?B?akJnZ0NCSXV3UHF2eTBCNCs1VlFITFhFVmthZGhIL29UVG1zVVdpKzZ3a0xi?=
 =?utf-8?B?TDBjNXczSG9QU0NXdG5zbUFybFhYT3lqL2RrbnJSbTlvQ2ZtVmJKc3VOQm93?=
 =?utf-8?B?c0VSaHYxTFJEUXpnUmE4dzFnZjNyYzVPZUs1eVZ0bFJwcFZ4eG9qaTV4WDU3?=
 =?utf-8?B?WUhYSjRtRmVwb3FHenFyUlpjeTZMLzZLamYyY3lQblRQZ0Vhbjc2QzJDams4?=
 =?utf-8?B?Unl4VWovdnJoVi90eUkxWXhaVzZoWjdYcGdXN1ZPN2FYclBNS21lQVM0Smw1?=
 =?utf-8?B?UmwvOWRmOFpFVXUzeTF5d2tMK1FXRzRuakdMaHhLVitTbllVdjZrUGxxcUlx?=
 =?utf-8?B?bUtvTWgvT0l1SnJCenp5dlZvaTVXR2RxL3UwSWpid0NYUkZJWWoza2hMamdo?=
 =?utf-8?B?Z2ptWmxjU0pMbjZuZ0Q1WGV6TjlJbzE3c1ZmVkwxQThJRXgrWVFJY2VhVi8v?=
 =?utf-8?B?WmtxTWFsR1FLdVdYSnJjRHkzdy93YkgxaVJKcHBTQU1DRWRiN1crOHlkNjVu?=
 =?utf-8?B?OHpsQUg1c3hwNExRVjVyV0pMQ0dLQnJydUNyTWpmS0tuekYxQnJ3OTR5RlZW?=
 =?utf-8?B?L01XOU1JNFR4SXl4R0dacEVKN2hUaDdSNVFLZk96NHVwWjNiTWwxYlVBK0d0?=
 =?utf-8?B?R2xMVkZIdU1EWjNlNnppMldTM1dxYnJuc1QvYjlQclVpcTlXd0JTcEV5clN4?=
 =?utf-8?B?NVBBbThIV0J1d3JUUEExRjVQMXpqbVdPUzNLTmoyUlBvV2tBRVN3L0pmS1V5?=
 =?utf-8?B?UVJTSXdwd0xYVVVKeTlVNC9mV3EzNjJtSE9UdzhGMEpvYys4OW94OUsya2ds?=
 =?utf-8?B?NHUxRm0zODFPbW43Vjd0dDgwdW95SXNvL3E1S2JwdmJGVmpVb2xNVm5yL2Q1?=
 =?utf-8?B?elRlQTRoNDJXSlEzZXN2VWd4VlVaWHVEOExKeDVwaEw3RXFzRXU5R3dya09C?=
 =?utf-8?B?WmVIdWxNdlcwNDdQUzBIbHAvOFFDeUlGWE1ZTEI5YnZpaXhGWWV6djdyU0R1?=
 =?utf-8?B?V2FiYnZBZ3AybkRsR2psWjhNQU9KdDF5Um5jRkdQTU9HbWQxSlhIOEJQMXpI?=
 =?utf-8?B?T2RnTWhKZmdMa0x2eVNJZXJFb3M2clM0WUV0Q29BTXM2REp4aFZLYUV4MnBY?=
 =?utf-8?B?eTJIbFBOcmxHTnBUVVNZZlNpWXBZTERUbUJBNXBreWJLRWQ4bXJFVnNnSlMy?=
 =?utf-8?B?ZURSR0k0c0QvMms3eXZaZ1RvdENXOHFEeHJsY21ITk0yb0Nrd1gzSUU5eXd5?=
 =?utf-8?B?VmpzT3RFTndYQnVBSHlTMGlsc0hkNzI0RjVtMlUxa3FzcjNZV2s3V3ZwWDha?=
 =?utf-8?B?NjFwaTdyMTg4QmQ1RjZvVktOVlgydDFwV1Y0UjVEOWRpSzlnOGtKZ09yZ1BL?=
 =?utf-8?B?cmZ2N3RCNjdvaUxia1p5VE9OVDA5RDFNcVd6bXdlQ1F4ZVFHR0oxZW5yRXZJ?=
 =?utf-8?B?di8wOVVuNURiNlV6ZGFadFEwWkI2bDBqNXMwYXVlSW13VDRGK1RTL2dPZWpE?=
 =?utf-8?B?MzJyRnBRZ1RNR1lqYy9MVWIrZnRzS2xnbVZGMFZnWC9sOEFiNVFNNXdlaW5U?=
 =?utf-8?B?U2pIUVlRSnFGVUxxb2lVMjYxQUNVZ0ZLSXhjSXVjandLUlljcjdVMENoNkdp?=
 =?utf-8?B?cm9XMGxjVFI0WkpKeW9oQjBsb2hodlM2UG5vdGVRdVphVDhMQko4ME9DRVBq?=
 =?utf-8?Q?knSFXL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cUpIakVQWEduM2JWTXJXUWhldzlvNTBic3hBcUxMd2ZOVjZEaEFhY0VUTkNC?=
 =?utf-8?B?d2xudXZKU1FWK0xUTHBZV29nbjVPWUo1eFhaMmRJODYzdnV4dE5XQ2VlVkVV?=
 =?utf-8?B?bzVzSndZQ1V0dWltYU1XTnFiUzgraFpIcmFJakVmUTV5TkoyVEFINllGNGhx?=
 =?utf-8?B?THUwZEE0dGFqM215ejRBdS9wTUR3L2RINm9yMUtZZWJONndQNTJzZmxralIy?=
 =?utf-8?B?bzZKb244TXNDWnd5OFQwZEpNUFM4T05GR0orMXB4U041TmRvTlRZMjdkNUtv?=
 =?utf-8?B?bmpVRm4yYTJDZmpzUDg3ajNFVk83VEJNaHMzL2dydGFtbjRVWUkyekN5cGtO?=
 =?utf-8?B?TlRONUxYd3JLNVNpQVVNV1puS1c3eHpNblhhcU9WNXp1YlIxL3N0Um13Tmdj?=
 =?utf-8?B?QVZrN3gwWWxvNFJ1REg0dnpCQUpJUHV2Y1pVRnNRK0FrQlFsQXpncEFoYmV1?=
 =?utf-8?B?dERBbFdzNzZRcjh4UGxVU3VQYVNRam9QdEtGbmEvNWVsaE1HV1Y4WUxMUkFB?=
 =?utf-8?B?RW5uZkVQSEduWEJ0M0VNS2huelQxTFNCY3BySHByZDVrUm1TVlkwakVmck9j?=
 =?utf-8?B?K2xiYnJ4R0xVWjlzYWZ5QUNCM2MvTmZ4UG9CR0lCQkFXTEh4UlJkVEM0am9Q?=
 =?utf-8?B?WWtzcGJ4akZZeVoxaHNpdTkxMFFld2ZPdXJxZzRhOEI5YjVmbHhuMHJieTIz?=
 =?utf-8?B?clcwb2JFSmVDM2x0QThKYmFDcTAwcEFNN3FORGIzUFNKQ2plcWQxc3h6R0hs?=
 =?utf-8?B?YmNzYWdVek96NUkvTTF3SngyemZPUXN0eHo1ZGJXQW82M1Q3ejVKc2MrSENL?=
 =?utf-8?B?cWtaRkRSOWdmeGZaclYwR1dlU1l5bE1JVkl5Vk5nZ3lmNTZsbnVYN3VzTWpY?=
 =?utf-8?B?YTV6ZFAvQnZnVGZKNGU0L25oTjZRbWRZRlJ1RUFoS3Z1c1VqSTl6dXpIR0Mz?=
 =?utf-8?B?YStLTTI1Y0Z0Z2VWMWlEU1NTQ2pKMXBpT1hYWDFNK1NRdlNqMUpIUmIxMVI3?=
 =?utf-8?B?Q3hmbURzbWZiUmNvOGpqVWlHTTdrelF6MGp3YU10ZnVnM1l5aUxWV0Z4OThS?=
 =?utf-8?B?T1BveEtiM3U3QlZDU3lmQnAwZFU0bFkzeDZzVXlZTE9KOE9hUVNzTjlYamJt?=
 =?utf-8?B?WTZjcGk1RWxkL05jcVpOeGxSS0o1UEpreWgwdjVkWFFaK0REamdOTzdCUWw4?=
 =?utf-8?B?Y2Z0bitUaS9pazAyVHBzRzk3MUtRQ0J0UXllcjJtd1FPU1IxdDZMVVRYdVpN?=
 =?utf-8?B?UkNNOEMrODlPanQ4SVN5bzhXV29JeVdkZnNrTmd0WUpDcEJhWWd3WGN2Yk4x?=
 =?utf-8?B?VkZRSEVkclNwZVJOTFl4ZmJmSXlLV3NPaXJKUUFjUDc1QmFieUY5YTc4L3Fq?=
 =?utf-8?B?MVFsRE9TcEZINmhoWHVxZ01Kblg5OWU1ZXY3NHVsc2x2T21McSswWFg3elVB?=
 =?utf-8?B?cm4vd093T3Qzb25nTkYrci9iemZFZTZYalZoV2d5Q0NYd3RtS0FMa2ZqY1hI?=
 =?utf-8?B?SlgydWp2SFkyRmo2cENJZ3B5WnpkMHhFWDhnUk5XQkxqeHBhYWtva3hwVVJj?=
 =?utf-8?B?cWhJOTBiY3lIUmRsRkR5YmJzZTkzYjB6d2dGQUd4T25pUjdWTmhOdkhxYUdT?=
 =?utf-8?B?dExkOGhwRVlnTDlTTmFQeVcycFJCOUlKaUZvTWltMkZ6dGxScTBSOTRGU1M0?=
 =?utf-8?B?SkxpZUJUWEtrcC8velUxZktKTFNPUEE3VDN1NkVZWEVncnVGYXYyQ2tJT09u?=
 =?utf-8?B?U3pTM2w0NGN2ZGp0VTRFNlJjQzVrNWluWjRjRlFXYWZkd3FOVU5ueGVncFVZ?=
 =?utf-8?B?M1NkdjhCNERrSzhQZnFhMmFhZmR5V3R4a3plazM2ZjNGY3U3dXdiUExxdVhE?=
 =?utf-8?B?cUpaNElxbDRwSEsrTVh4cVdEcHEyaGZ6WGlocGJHVlRyRjNHUENDUnQ2Y2Vz?=
 =?utf-8?B?M1U0eFl3MVMyeDduczByM1BxeDNvS3ZPcHNDRHZjUllUUjlhMUdOWDZFdzdQ?=
 =?utf-8?B?K0NFaktMYUVPZU5FYUFIeFBEU252OSt6UG5pUitTNjlmOXE2cDg0R0tORGs1?=
 =?utf-8?B?L1J3L1czYTJ4UnhNWktmd25rOXFpUXFJWFEwRGNlbXJyOW5Cc0tRam03NGpV?=
 =?utf-8?Q?z5WgMhNwzFZBxV3dPAei58jRL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d43a3a92-d6ad-45f2-9ec7-08de0bff6502
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 15:27:47.3936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xN/f6NSbaij6Njd7USbsaq5/CCO4pbrlRcij13CgQ7dRzWhsO5UQG/vibjU/3VK876OPmlZltmILKg35p8mpow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6993

Since commit 1c3b002c6bf68 PCI: endpoint: Add RC-to-EP doorbell support
using platform MSI controller, PCI EP can get notification from Host.

VNTB use this feature to reduce ping latency.

The first patch impove epf core API to allow set any MMIO address to specfic
bar.

The second patch add MSI doorbell support.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v6:
- update commit message by bar_size
- collect Niklas Cassel's review by tags
- rebased to v6.18-rc1
- Link to v5: https://lore.kernel.org/r/20251009-vntb_msi_doorbell-v5-0-4cfb7b6c4be1@nxp.com

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
base-commit: 48a881fd8adc6ef7d29b4cf2395b04cdc271e636
change-id: 20250812-vntb_msi_doorbell-bf0fbac6d6d7

Best regards,
--
Frank Li <Frank.Li@nxp.com>


