Return-Path: <linux-pci+bounces-23366-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A659DA5A4A7
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 21:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DD8918938AB
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 20:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B2A1DF974;
	Mon, 10 Mar 2025 20:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GGOzA3m1"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011060.outbound.protection.outlook.com [52.101.65.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F641B4153;
	Mon, 10 Mar 2025 20:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741637859; cv=fail; b=U21sCR04DkPBfm9f5hStKgeUr9cdweCWyi3uOYWUFThlF/tr4dumF9Blg9DwJ4t2PTA3t7AOagp8GoqKSv8HPMY6Q7LZZcKJzlPc28tgxMcPRC/fDcFPhJNIj19XCoE8yApa9kBlnBt8qlYuM8Nljb+tTXjF7kCc2EATnVHWRtk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741637859; c=relaxed/simple;
	bh=Fn+L4IFkCXUAdTYXCEsO4pUEJ4TA9gnMQx9u3K7yqLA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=gwfBvu7P5RMVtDVYOq/XZej1i2zOiHOdh4G+k+wn/8o9hS+pNSXjkZ31NWUtT5I9sIBulco5+bX/DVJbukDpu+Wc/6F2dxSD7EYgCO7vm4J4BeucSBjotSGF0JmrsQd9jgwu/QTUnX+X4jvQZG2OqD+eAFJ2taF+blj4uNSAWlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GGOzA3m1; arc=fail smtp.client-ip=52.101.65.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kHj30AsYz7a/H9UidcFG3tGOR/glsaZddcr0wE4be39J/MovqQDimK2DjWiAVMxERXP04IKA+Ht1yiWMcjBg/I0nblARk7NW1wUJuu0I8MU/HOK8MxI/p0eV/di375mLc41fDJk8xz1bbVfEr7vO6ggkhtUQOCGjawCJMuKDzDj4eFnc5dovvGzvVuFP3uFGx0yZ+QawI9jFtW/dGXxmDTCn0/Fd5zuU5Wevu5mvD+J6IRVmYyiYmYQxfawHxYcoQTwyeWkuEjj+CKA/lb6b6Hs0dWljTDAMbzhy78PmcW2ZzQ+IJo1GsP9yI/vTgi/dMdfARodk7KBjTP8yvtxRVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rTHKefLycHMhVtsdhP+f8dmoDvue/YvM2QNFOGG2uKc=;
 b=emL1i+0XUe9RKs5D2OFPPHLGx8oLp3HiZmlV4QI4HkCiCo4WIIZDsiJd+UL9Slq+pBa9xCFU29JG5bzWckr6hJ+KrgzkieZHtW1DVFJKWgy4IQYa3VK6wrkOvNH3k91Cp14zKTiWpIq6n0xh+HEUAW70Nq5cmSGGpO4oQ2MsFhCppXm775E2zSpNf242yo/oXB+qwJt1sVxMJU3GPWY+f1Rm5s7O5cnQHc31dPNV/LnzANmriNXI4JrzNJYR9m1qhlBGJBVblE6rFfjG37Dqe/Avdtzz+P3D1fExq9KaTMoyNhebxW6J/yXY2EdA+KQGB5Htfn17Ope4tTZLDqoRyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTHKefLycHMhVtsdhP+f8dmoDvue/YvM2QNFOGG2uKc=;
 b=GGOzA3m1Y1c/3ENWnY/XTOVPExbFaZuMFm6bj0Vy5q4UysGDWghO/kCOzeeRTRofWd1qsZYYOsheP0DyndA2iQUYDIbiqXu9j9AIS7IJ9H7RJ+2YnWRqy03G/jiNSy8V6+B7DJL7+kVb434Oz8YxxwPDSZ1UBXoliSwKbcAMvUtc9R4oB85rRbviPMdE+2+x2qEGBd0vNtuMSSbWOQKvZEj2UKEk8p+eLt1CqIFqr74EEnKVB+2nv8YKH8PfbFs/9Ryi0TIBkaQdUtq7v2B56By7FLUE48bJTye9cOJVNT/3O9KgvhrTaGiy1p6xEZZ0WWOydSK+c0JKU/rO3AY9wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8261.eurprd04.prod.outlook.com (2603:10a6:20b:3b1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 20:17:34 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 20:17:34 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 10 Mar 2025 16:16:41 -0400
Subject: [PATCH v10 03/10] PCI: dwc: Move cfg0 setup to
 dw_pcie_cfg0_setup()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250310-pci_fixup_addr-v10-3-409dafc950d1@nxp.com>
References: <20250310-pci_fixup_addr-v10-0-409dafc950d1@nxp.com>
In-Reply-To: <20250310-pci_fixup_addr-v10-0-409dafc950d1@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741637834; l=2708;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=x8RA+x9r9JuWyFDEhuMcFraJYfJMz2iE/r385KKEfTw=;
 b=rn34KzUVyIAvWAZIONyJQBCvqOOJxYdjVC16WYZ8Vhd6B7srKqHKl2Btn0uHMV4ipvrgrSQ8L
 E35tZn4eKELCyepn/aG5uqSqJZ/a4u3na8iedPa+gExXh31ap9xXTiE
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR08CA0058.namprd08.prod.outlook.com
 (2603:10b6:a03:117::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8261:EE_
X-MS-Office365-Filtering-Correlation-Id: 79bef7e5-3870-4528-0fb6-08dd601097c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a3k0Wnc4WjhNb3lJaXAyVThZQ2g1T1dzR09seWxvWmNRSmxYcWM3WjZXaC9z?=
 =?utf-8?B?MFN4d1BDWE94MDNxVE84K0x2WkpHblBGQThTUWFabmZ1bVBRTDFZQ0VpOVEv?=
 =?utf-8?B?dGlJS1crQWliYWJXM0ZKTERKWUs1V0QycXIyM3hUNG8yMTUxVUZBTW9KRlpC?=
 =?utf-8?B?L2NoNnY0Rlp4SFdDcytwS1c3Ykg1Rjh1eW4zaHh6K0I3MlRzNDlmckUrdlkw?=
 =?utf-8?B?Zk5zeVlRY3RjbjhaTFp4ME14Vk5nQ1l5TFhWSFcrWDdwYktIR2VKVElVNEpu?=
 =?utf-8?B?VTVnZ3FTNkRhMkd6aGhLS0oySHJQbmZTb2dSMzZ5TGJ4dHBxNTJSeW9lSkdh?=
 =?utf-8?B?T0xvUEJQa28zTjQ4YWEyZGZSN0JIYjJWa0RHWHdLVU1BTFZsY1pjWFNzRU8v?=
 =?utf-8?B?TGZNRmhhVXo5M1BPRVpRbzlZdFg4eTk4M3ViSzlUNjZ1ZmxVZE9VamJCdkpE?=
 =?utf-8?B?QitBenE3bE1pVUFaZ0NVOVZLYnU5N3dBMWhPa0tpazRpbUx2cUNOWWcxTDQv?=
 =?utf-8?B?bnVNQTl5NEJGWkVYa1RjYi8yK3dPR3VwTTQ3YzZtSFhkYTJTbFdnNCtMbU5R?=
 =?utf-8?B?UUpja0V5OHFvM1o0aURtdC9qQ1JFMnVVa0VVYkpTeWVjRm5jZzdNWnVZMFBl?=
 =?utf-8?B?K1NCQ2sydEtSa3pWQ0JJTWNSdy9CVWpxQVRoMi9odlN4Uk9NakZNQTdpMCsr?=
 =?utf-8?B?dVlmMmtHaTBRL09SRUZuOW9WK1ZBbGRrVWIwMFBEVXIvVXg1bUJxYXoyRWUr?=
 =?utf-8?B?UDlVTldNVlVjK1NOdk0wUno1bEVyc1F1N1QvYmwxV1ZsMjBJd1FScEZpanpt?=
 =?utf-8?B?aXJRb3Z4K3FvNElpK3BDNENEM2J0dHR6RFFFaXhHY2VsdVBXSVBkZ1B2b0Vl?=
 =?utf-8?B?UmRNZkJjOFg4MUtSUTNJa0dkU1FBeXpiOEdBSmppWnFRa1ppMjFGVlgwWTVF?=
 =?utf-8?B?ME1HVVlleU5jNStnRmtqaHVQbkl5NWE2YTMrWFhzeVhOSUVqTTJpZUFFb25z?=
 =?utf-8?B?aE5uM05ISFBqalB4cG8yb0hpZVZjdXhyTm82YXFrWjNBbEcxdEdwMXJiVVYx?=
 =?utf-8?B?SXFjRUZTaXdnbDF0N0FCSE5BSy9FaGVrakdaSzVyd1V2dTlUaTA4TlQvakpx?=
 =?utf-8?B?WFJwbnEwUVdkT3JZUUJxWjNpbWFkYW5QNU9iUm80VTBnaC8zeiszNUJlL3Yr?=
 =?utf-8?B?ZmRhQkUrRVhqR0d1K3h1UDcxQXZydC9MSS9Eb1UxaEVJMUNsVVBuYVF3bUY0?=
 =?utf-8?B?YzZkTnYzaFUrRWNhcHZEVUp3bFo4ZkR5ZTg3SjcvOE1HMitOMlpvL09ERmRj?=
 =?utf-8?B?YkxvNGoxMkFmSWxkZkh1bXR2UUlpT0U5VHlmVVdVdVNpbWQxRWZaZzJsT1FW?=
 =?utf-8?B?TjZ1WWRvcVMrZGlaN0ZEeVpQTXFaMzBkWEJZd2lCYUJFMURId2k1amUyT3h2?=
 =?utf-8?B?SEo0U1Y4d0daZWVNM0RoVEg0OEJjakRoWlk2NjZYRUlmQTFEemhyS1lNdFk5?=
 =?utf-8?B?bUhQK0ZZeDF0UzlxK0VpbWNuRXhya0ZDV1hnd0Y1SHYxM1hmeUpIa1ZOS1JT?=
 =?utf-8?B?VTdWT0hvRjF1TkVRWkcrVEo0bDZCeVRMR1d6V2xyVFh5UnA1NCtTTVRDVjli?=
 =?utf-8?B?NGF4emI0WSsyY2dXZHFjLzNGU2JLSkhOQTNjWGJneU8rRVBHN3R4dWhZbkty?=
 =?utf-8?B?Si94OEtuNlYyMjJEaUZzY2FqRjU3dk9IZ21hNGgrM0dZUFAyZ0V6TTllQk04?=
 =?utf-8?B?aTA4L2hpbDFTdHcwMkJ0RDFhNUFuV2VwVzI4alFpRlpvWHVROHlJZ1ZWMlN1?=
 =?utf-8?B?elJwaVNPdWJsWVB3VjI5Mm5MMmt1cVoxNlY4aHMvTmdFT0pyc2IzWVE0NFlI?=
 =?utf-8?B?MUtlaVJSZnZMbk1NTFNnblJZN0h5c0N1WGhEVHY2cGU1dHc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXExd1g2SkFZNGRpTEtpUnFpLzNwMWdmWVZXWjZzdjJiNkRDN3Y3TTIzVnVZ?=
 =?utf-8?B?RWpkTHFCRW1zckN4QjEzWUFKZDdPaWdPUXI0dUc5Tk1KRmdES0p5UmZ4Sk1t?=
 =?utf-8?B?WXlOZW56U0FBV2lWNW9BOVliRFlkUVdLVGlnUzV2U3ZkNEQ3S0VsMC8raEtR?=
 =?utf-8?B?SzZEcEJxekt5ZVhVK2IyeWFtMU9qK3RKV3NBNTg2KzBLdTlEM2N0bzVWT1lu?=
 =?utf-8?B?RnI3c0o3V3ZOT1RtMExoTlBHei9jbUcyNjJvdC93NXFrY0QzMk1NV0E0RS9r?=
 =?utf-8?B?MlFrb0M5MWZ4VElwTkV2akVhRURUVWcvNWpHVEM5NU5odGczbDdKdHoxYm8y?=
 =?utf-8?B?NDdIUE10UHowZkVyY1JxcXliNnlhT3BURVhTMHBVMlg3TXJjdy9uSHIxOXVT?=
 =?utf-8?B?M2VIMTdRTzExTG9sT09iK2FmYzJTS0ZhdkhHR1VudjA2WXZSU2szMkRTbVMv?=
 =?utf-8?B?dW1yNXE1Y09vQllRWndBNmk0blZiaWNUS2RUQStSYVNKWEMybEp1YXdKZjda?=
 =?utf-8?B?VFFuOFNjQ2VmVjFyQVpxZlZ0MVhtdHQwZm9JalZ3eW1CSVVjVFlGcGRScE9C?=
 =?utf-8?B?M3g5VDdVRXRidHNPeGYybWlFcXFzazYxclYwOTQwNHJyVFNJZHowUnRxcndE?=
 =?utf-8?B?Slp2cE1Ld1lQeVJhK2hwN1REVkNOZ2VvcFVDNDJ2bExES0M3V0Q1enhTWUd1?=
 =?utf-8?B?SS93ZTd4b1lJeEovT0Y2M0FLeU5mdnFZRTFDM04wVDhFdW9VdlVDU281bTIw?=
 =?utf-8?B?OTB3ZEFEcXlXanJnNFVZV01zbzVMYlBnLzJHVzU0RGQ3WWxKV3VlRm5lTzRw?=
 =?utf-8?B?ajQ3cGc4cGc1czBLb2RpUVhZVnJwN055UUE1Q3VwRGpjSzA1dnBGVTRCNzRF?=
 =?utf-8?B?RG16czZvUGJXRnh3bTVnVzJJZnN0aTByY09PaUgySGhYZUtYeEN3eE1JRlE2?=
 =?utf-8?B?b3dqWXNrbURMN015TkRsbjZrNm1hUThaKzJaVEVLQTlnOEt2bUsrZ0JNT3ps?=
 =?utf-8?B?WVlHUG1uTjd3NGV5SEtTVXI1ZTV0Sk5Sd0x6MHdnaHp4bzVUN1k0U2tFeUlx?=
 =?utf-8?B?dzJpbG0rVG9hQlVFOFFSRk55S3ZabjV4QkwvVEJ2dC92THVNa2dQTXdOMnZx?=
 =?utf-8?B?aVhvUW81dGVYNXp3dWJBdHQvZ2o3YmIrZmlEZlJhQmdqd2N2aE1KSHNMS3hy?=
 =?utf-8?B?eUpyb29McnVERXI3d3NjT1NFZ2t6UDQ2c0g2TmFyMmUxajBUWUdLTGwrVFdi?=
 =?utf-8?B?SlVxZXJjQnVTckVqNU9JbTVHWVlTdTdRdHZyK0VFZTF3RTEyM1RCUUpDNVdM?=
 =?utf-8?B?Wi9LQnZPS0hlSTF5M1Y3VU9kaXcyMlJ4SmRsSUtnV3FZNnRnV3ZmZ1RoVGlD?=
 =?utf-8?B?UVZUZXlldUUzNHhJQktTWS9mV3pYK3FPNHB1L1I2ZU9UTitiQURiWTEwTWhi?=
 =?utf-8?B?MC9GNUpoemhPdzdnUDVTNGZRSnkzWlZHTHdlNUpBWlBEaUxUSlNQMWRBRjl4?=
 =?utf-8?B?c01jQUZYOU5YTnZzZDlKUzlScDAyTTQzNGxHdTljS1k3OHpBWTR3SGhWQXFw?=
 =?utf-8?B?dmNHMVpiSTVjYVZUanFOSmw3dzYzTjQwVk9SV2NZM1N1L0YvTXJhRnZyVFcz?=
 =?utf-8?B?R0FZTXJQTitrenNyUUtJK0ZNVnZHa3RMcU95MHovY0U3Y3lMT0NsVEs3WTBj?=
 =?utf-8?B?M3BoR1ZtZFpiUFozUmVYL2tFam4wNzgxOW9OVVpPQ3BGVkRYajg3WVNCNXU1?=
 =?utf-8?B?Z1VMWnNSemh0RnZMQ2N4VTRiUys4NTY1OHdsWCttYk9lekxBYjhEOTNycFlQ?=
 =?utf-8?B?eHE3QWNkTmZMbmZXQXF2VHNqV25sZFhwTkpsV29BMzkzSG5XL2RxczY5eFl5?=
 =?utf-8?B?MTU2NG5ZLytGazNvZVpERmNBZHpPT1V6MEJJWTFZeVpoc2NjdUlqSGlkdU1k?=
 =?utf-8?B?VDVuWE14YWxET3FPdnQ0ajhqWHdrZFlDZWIxWnVCR05FREdHZzIvKy9YTk5w?=
 =?utf-8?B?cG92cGVNVEY2NVdlRnNZdE9Yb0dYYnJWWGkvbm1WdnBKb3p3Mm1idGhqcEtI?=
 =?utf-8?B?NkFPVE1ab1ZBbmFhSUJTTE5OT0gwSlBIZW5RalpXOWlFT2V6ZDE1RWNhdlM5?=
 =?utf-8?Q?JG5k=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79bef7e5-3870-4528-0fb6-08dd601097c8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 20:17:33.9988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3no/caYU2jUW9k5Ww9XjWShTOl4ORt5vg1P2FyMNU8TxyTHEtF5ukUIcXBVB02F2OKySS7T62NRukXkdqL8E1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8261

From: Bjorn Helgaas <bhelgaas@google.com>

Move pp->cfg0 setup to dw_pcie_cfg0_setup(). No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v9 to v10
v9 means https://lore.kernel.org/linux-pci/20250307233744.440476-1-helgaas@kernel.org/T/#maa0134c1826bffcccab6028c7732a13f7adcec4d

- move dw_pcie_cfg0_setup() ahead of dw_pcie_host_request_msg_tlp_res() to
nice git diff and easy to review.
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 40 +++++++++++++++--------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 1206b26bff3f2..c57831902686e 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -392,6 +392,29 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
 	return 0;
 }
 
+static int dw_pcie_cfg0_setup(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct device *dev = pci->dev;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct resource *res;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
+	if (!res) {
+		dev_err(dev, "Missing \"config\" reg space\n");
+		return -ENODEV;
+	}
+
+	pp->cfg0_size = resource_size(res);
+	pp->cfg0_base = res->start;
+
+	pp->va_cfg0_base = devm_pci_remap_cfg_resource(dev, res);
+	if (IS_ERR(pp->va_cfg0_base))
+		return PTR_ERR(pp->va_cfg0_base);
+
+	return 0;
+}
+
 static void dw_pcie_host_request_msg_tlp_res(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -423,10 +446,8 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct device *dev = pci->dev;
 	struct device_node *np = dev->of_node;
-	struct platform_device *pdev = to_platform_device(dev);
 	struct resource_entry *win;
 	struct pci_host_bridge *bridge;
-	struct resource *res;
 	int ret;
 
 	raw_spin_lock_init(&pp->lock);
@@ -435,18 +456,9 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 	if (ret)
 		return ret;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
-	if (!res) {
-		dev_err(dev, "Missing \"config\" reg space\n");
-		return -ENODEV;
-	}
-
-	pp->cfg0_size = resource_size(res);
-	pp->cfg0_base = res->start;
-
-	pp->va_cfg0_base = devm_pci_remap_cfg_resource(dev, res);
-	if (IS_ERR(pp->va_cfg0_base))
-		return PTR_ERR(pp->va_cfg0_base);
+	ret = dw_pcie_cfg0_setup(pp);
+	if (ret)
+		return ret;
 
 	bridge = devm_pci_alloc_host_bridge(dev, 0);
 	if (!bridge)

-- 
2.34.1


