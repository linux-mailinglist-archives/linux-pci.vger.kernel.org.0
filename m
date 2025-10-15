Return-Path: <linux-pci+bounces-38239-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6524FBDF5A9
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 17:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D3230504939
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 15:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58C23090DF;
	Wed, 15 Oct 2025 15:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Kvff5rIL"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011050.outbound.protection.outlook.com [52.101.65.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74125308F1F;
	Wed, 15 Oct 2025 15:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760542088; cv=fail; b=kiZDc56l8w0n34FZo1jPiS1CukwpPkfnX7PvLrFE0/ROjkGr385FwGKYuwYK2gCBy+f1xuInEJQ0gnBMLmo4pnKe6kdkpXHLNsMMOznoxp13kf30fo6qXlDrBqmv0pyd1ml4v13tp6mxEXswK45MXuAO/HgklcJGxFiuDTI1ZTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760542088; c=relaxed/simple;
	bh=d0jjuVYo95icEyMMHbl1KpYVYqWEhYeox4Hu6bQaCUA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=r6qmtQticAjiXNUj9Bm0Bw9CH6XizgClmazvMYtgLqiCeKblsEG/YzP05GnyyMnJpa8I5jbmELdLYc8ibTxWq+6oe1dW260lDziytBLJwVElwyGJA+WYeQbkWITCNq2r1HvliJoJKwOdgLEsMfc73Yvn8XtfYVT+1XFWnbzfof8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Kvff5rIL; arc=fail smtp.client-ip=52.101.65.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sRwB37FDKAYHZOeke3x3NDN086cdoUtAFDZq+Y3rUnKxF6Z2SixU6jdHRIdmp3XTfojSSCP6TxPsFetbI9Fdz4qXvAdBBtL8STb5pghHI+9u0dYzXexccJA+klFt0MULsgouhMsaSANyunStcrcsW8EphhxgGWOt+87nIwfsB86ZWwuY9v3xQIICkACdX6gZd+FRH/kTmZrQ0WB6Rw0UQr+H36hmOW6DM/fRfIR4JoMGcz/md/YUHXizKwvfPZbUOC+1skyeOdUEfXBsXqZY5ttWhKwrKLwX8K1USTXos6FAONMgLWPQqQ01SQBjixpjDOc4pW/yXyOKKUlapX9Iaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8y4e4S+bLanAvLAqO9fT65YPozTC12pO5ZF5Aywb35Y=;
 b=FfGXR/5NQWu+aCPW6nlZhbmXvXi3T7abonLqSg0RiUBl7ejFam+HM/CE1znq7iX53GJ1fvdnaIVTEwt3NgHnh+usFZLzj2zwdzRos0VG9/808VVhe9qHQDh4Bz5zyNeieCYV6xC9UKcSaBH4WjeaShhpYWhuzbYNRhP3dIzN4TjTd/JF3j2tZURuna8ne1BUfQ3fOSVrfA5sS22gzrXJyxfjNX2w0BGP15O/+9MQQWoQZHeRLgq0zTWbfOa4YVqFeXZRpLNFBDaRDHHZqRYpeitf1dJXkbPUSDIcpmERM/xQfynSNGf2HPWsVYijk3SBnbM9X7YgmqFmamuadeVvxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8y4e4S+bLanAvLAqO9fT65YPozTC12pO5ZF5Aywb35Y=;
 b=Kvff5rIL2WJizWbcBoCAs/bFr7t0pssBTwG7CkkxyZrPdjI3osFHOBATww2qRrkTb5+9iY8UMCWqalcDbsnVVK0EjeQnfujSdQ9envX5Sw/3SqyZL1z2AuEDKjzQCVIXW0+01BduBdzWdJ8ZGhQK4w3sab/+Ku/CDp17r38KEfurt+rDortXc4kwDnGe3n6gDOUY64Z4BwpbrjxLwb1m6vu2uFFgV0ld7bbnJQ6STU6VDdNuX+0YObzv79U4kM0ioBRR0Y+5NhpHj+yGRqi4Dxqd50wkcQVxGGyp24CnS1SideThzLRU5+hIGGfZF92j9WGaLw47odgnfZ3IIieJ9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AM0PR04MB6993.eurprd04.prod.outlook.com (2603:10a6:208:17d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Wed, 15 Oct
 2025 15:28:01 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9228.010; Wed, 15 Oct 2025
 15:28:01 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 15 Oct 2025 11:27:31 -0400
Subject: [PATCH v6 4/4] PCI: endpoint: pci-epf-vntb: Add MSI doorbell
 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-vntb_msi_doorbell-v6-4-9230298b1910@nxp.com>
References: <20251015-vntb_msi_doorbell-v6-0-9230298b1910@nxp.com>
In-Reply-To: <20251015-vntb_msi_doorbell-v6-0-9230298b1910@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Jon Mason <jdmason@kudzu.us>, 
 Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 ntb@lists.linux.dev, imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760542064; l=7571;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=d0jjuVYo95icEyMMHbl1KpYVYqWEhYeox4Hu6bQaCUA=;
 b=a53/3QQ81UfnM8JhoDLyunCetJpxWnNOI8HqOfs3ru6F/sHYdwdMf+FRA/o53l0KeQ0cZHDm2
 7L2D0o+zZ1VCWwaJRH0NvW6+u/JDiW7X6o8k9oFh4oP0WrvTgf40CEm
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
X-MS-Office365-Filtering-Correlation-Id: 0ec723ee-3b8b-4249-b1ff-08de0bff6d2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZFAwMkI1OXZWNHdsQ2J3ZU1ZdEYwTG1sTk8vYnBKV1U4eDZJRHNkdVF4VmhG?=
 =?utf-8?B?ZEpuK0xVNnpqbW5LMnFnN3llOXVwK1JPejg1Sm5Sa0t6ZjExV1JjTVdyQUxj?=
 =?utf-8?B?d3pwZFJnMUpqNFVJcHFoSXdLdXdicktMQTFaQzJtcnBhVy82amVXMU9hK0lS?=
 =?utf-8?B?ZmdTTmE1Mnd1Rk5FZ1VMUHYxZ0huanVFcURvQk8wUkczQ3NIL3FVM3lFbzV1?=
 =?utf-8?B?WE5qdG1nZjRMcW03QVdiY1hLZTJZcldHUTl4Q21NZG9GK1RMcmZZTU5Fdkcx?=
 =?utf-8?B?Wi95cWlBTEJYanc0bUY2NUZPNjVlbkxrMUlESjBBeFh1MW1LdkVRcFcvUjZ4?=
 =?utf-8?B?M3NTYmlVTzVMcklBalExbDRtK25NblRlRERKa2JDb1VRWTh2TldWNzlIWnhN?=
 =?utf-8?B?RnFEVmZZQ09rUjFvMG9iNVdYYnFDOWVvbGpDZllaOTl5ZFQyNzVnaUhlNmQ1?=
 =?utf-8?B?UCs2ZjZtU2RRenVrWWM1bzVqTkpiU0VWbm5pSWRXVmYxamZlNzFyS2Y2R1po?=
 =?utf-8?B?ZWhhcGo4YW1XN2hGZmd0Z1dPRHhrNUdlOEhSK2tEVjd2N2RUQlpJTlVKa3Bo?=
 =?utf-8?B?MktqUGNXRXVCRjY3alJMK0ZnQkV0NnY1QmJETkNKTGE4NTIxWWhxM3JWWGxj?=
 =?utf-8?B?amNEZTM5R3dxbDlnTEJyL1BKcjRDV1hsMkIzVjhwWU9YRkZNS21Db1doQUdM?=
 =?utf-8?B?aXpYaTFyOVRRWGhiSHRrWDRBVFpSbjZsY1ZmOTlYYWV6Qnk3ekhpNi9FNnY5?=
 =?utf-8?B?V3FZTGJUazF5KzM3QVlpdGVXTGFoNzBNMkRXN0ZlaXQ4SnBLMzJuN20yT3Bl?=
 =?utf-8?B?Si9iYlYxendtaVFLdk9oaHFyY2dEaVpLOVQ5dytWQ2l6OGRrSmlmTlVBYllH?=
 =?utf-8?B?VnJwNktwS1hteGZ2QXFTZU1WSjJCSWdtR29ndHh2MmdOajlRbGlVMFkwb29s?=
 =?utf-8?B?TFNUSGUxNmFPSEZlVmR1NDBsTlMxcXZ2cDdqdGo2aHBmQ05GdXZuaTB6NWdH?=
 =?utf-8?B?V1VycEpOelBGdEdMSVJJV01kTTcxWWRQQnNMeE9Bb25ZSVU5OU0wcFJDS2dO?=
 =?utf-8?B?WVQvODNrTGNDL1hEZmxleHJJZ1pGTHZOTEE5c1NmOE1aZWNGMlVDWVFheEoz?=
 =?utf-8?B?R1cxQTRLdEdGQUFxbjJRQzFPcU5RdU4rRlhDLzliMVFWNU5MYVIxaXlTWXM2?=
 =?utf-8?B?QVIzNklPQnhLSU1xWkhkOFJqSG8yRGNjS2RJL0JyUEdSY0tHb3VSbXFDa3pi?=
 =?utf-8?B?WWhLYm1BOHBhT3hub2lQTTBsU1BvVktxdmMzcTVTZy8raFBhbi83VTlENnRH?=
 =?utf-8?B?ajJFOStmUDY3MmVjR3RaMEZ5U3VYdmJnUysweWd1VWZhVytYVzFteDhQOXRi?=
 =?utf-8?B?RkdxcVczUkNXUUdoVzJKSllZT0RLMnQ5U1ZCdnpuZGxncUIrSytNSnNmandE?=
 =?utf-8?B?OWd2OXZYOCs5NXR0bWl6SXo3RkhyandJbVhlR3hRNWI3dXJhWGJCWk9jVmRD?=
 =?utf-8?B?bEdIZm04bFVpZy9RR3BpODA3clRLMloxZGljS3hTK3JHVUxVT0RQTFppazZh?=
 =?utf-8?B?MUliSjB6L1luMkppTkJEeHpEVXphbTc3bWdocnBDTkVrQXRnOW9Ca3NzOGRs?=
 =?utf-8?B?THlJTGJMQW1taUh5a2FRYnNEUURUS3cvenRxSjJTVGZJTVN0d2xzTU55U1Ro?=
 =?utf-8?B?N293Qy9XbC92eVk4UTM4MERJY3hJcTZIbENqSHM5TU9Nc0MvREluVTQ3b1FJ?=
 =?utf-8?B?Tys1QzM2WlQ3MHpPL1ArTFhUdE83U3FJLzV3OFEwY3lnM2ZGYmlCeU9zUjBi?=
 =?utf-8?B?THJRN0NtRTE5NEdFZlBZZTc1YzVsc1FuM2dXVEJGTHdnWnp1ZkhTZS9LMDMy?=
 =?utf-8?B?VzhKZXI2YWZjYjQ0NG5ZK0x3VHBKcllycFRYcmNuQWhSS0lvRVZualZSWVpH?=
 =?utf-8?B?dzNNREc3T2wzbTU4aGFROEt3MzY0SE53VUsraG02RzhyT2prMEpGdld1NlVi?=
 =?utf-8?B?dUJBQWRDTy96MzhxN0pETC9zdWdYNVFiVjRxVXVkQ21BZ0cxaHZtbDZKVUdr?=
 =?utf-8?Q?7NNiXS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zi9ZbW10MUk0aTRSMnNhdVNQTVBPZXFMeWE0WHZhVU9TVUNpVWppYjdzbUxH?=
 =?utf-8?B?SlRGRmNyWFMvNGpxOFlFeTVLK0N1dTNvVWFmL0tCeDZVbDRheHYyd091Y0Vi?=
 =?utf-8?B?VjFFK1o5a0p6Vkw2Q1FvenBsR2g2aFRLWS80N2lCTXUzZTZNc0ZKUnpVbk8y?=
 =?utf-8?B?WFpIb0grdDRJakhrajc3V28vbkZYaWlIVHhiTkEwV2VUN3oxSmNneDh1SE9j?=
 =?utf-8?B?VjhPMklKM290RHRWL1ZjTTI5K2dneTRjWkpCZ0lxbklnMFBucW5OS0xzNEV2?=
 =?utf-8?B?bk5IWTlubFNXVVBtS2hESk5CcDJDUVVYVnBmMk11YmQyTmljVVhzNzRUcXd0?=
 =?utf-8?B?Y3RtMlF0cTRrVHowWk05cXI5MXNtbXVqRW9hbnd1aGltK01lamlLT2lRYytG?=
 =?utf-8?B?UHROdWp3SmwvaWJwOHZQVXROOFpPcUdSbVBkNFQrUjBLbk1zN2NyUkxrTGxK?=
 =?utf-8?B?U05Sdktwd0VRSHlaRHJHdzFMNUVxMVZoQ05tRExERGVQdGp4ZnNqMS9MWVpS?=
 =?utf-8?B?S3ZDVXRocGtib0FkZDljcXpQVEdDU3o0cFUrY1hmSjdpdjdFeFd4N2p6MTVE?=
 =?utf-8?B?V2RxK3cydmtDMW9zbHc3ZFQ2SEdUeEVFQkQ4MzFtRk1mb2lpa2ZrL1VySGNk?=
 =?utf-8?B?VUFtdkN4T1RWMGdsa1YrRSthSFlYbWhjWGxBejNhMFpEU3hsbW9RT014eW0w?=
 =?utf-8?B?Yzk3Z0lPRnVTd3BhaFJGTGREaFA3NHVrVXBXbk14ck5paHNlS3o3STlFRzZH?=
 =?utf-8?B?OEhuN2dCZDcvQXd0MjhtQlAxb0NiSDMrbjROWFN5OUwyYkxnZ1lKV2E2Q3lJ?=
 =?utf-8?B?ODgyMlVSaEFqYmxFK0Uvc2xVTzQ5U3c0L0g1R0MvQU9XOE9pSFMrb0s0SHVS?=
 =?utf-8?B?VFZ0aVd4TURKVkd3K1Z5bXRyRGVWbXZLOGZ2djFMeGN2ckdWcHBNVUpNVW5E?=
 =?utf-8?B?WVhOMUtrNzZ4WENrOURhTWM4MWcydWZGYmFiRXhCaFJQWmNuUlJBKzUrRTQy?=
 =?utf-8?B?R1VJU3Y4RXNodWIwSDI2TVdMTVJPaTBSU09zVFJ5TytKaDM4cis2NEJGY3RD?=
 =?utf-8?B?Y3c4Mnp6S3VBNStFdmh1OEsyOXhYOHQzRUZEVzEzejVGMnJSRUF1NW5sWE15?=
 =?utf-8?B?L04yUlF1NnIwa2VHb2ZzYUswMm8wYmZ4MWI4c0tFU2hHZS9uTC8xWktHWjNy?=
 =?utf-8?B?ZW5RazJLK2NjUjVTZ01UVmI5cUNwUUY1d0hUN0x2MDBtK1NCNjJldyt5MWE2?=
 =?utf-8?B?YlhPQ0VzUy9lWjcxV0QvUFI2RWkzNkVQRzB3S1U2K093cHhRMHlMUkdQUWQy?=
 =?utf-8?B?YVdQODh1dTZGa2JReUN5TzA0dXlPc2dhanludGJVZGlUWXN5QVVvK25mOXJy?=
 =?utf-8?B?bS9vQXc5M1NDdFRvWXVIZ2FwZmhyOE9heko2RENQVHh6aXZmZytFcGFyVnZB?=
 =?utf-8?B?czZjT2Y5Q0JUZ2E5RnpZNk51dU9XOUtzaTg1amlEZ3BkOFRIZndjZ2diT0sv?=
 =?utf-8?B?VmFPUkF5YS9HWDBHS0M4UytrcXlmVmJaV09MSnZidGZkWUNSS0l2bkZUZVdx?=
 =?utf-8?B?bCtXZlJEa2tjczYzTVRpM0Zkc3NaVHpzRTBRcFl3TXhLTmJwTlc2RS9WTDN1?=
 =?utf-8?B?NnAycHR3SFJHaGVzVHgzUmxBcC9wMzA1aE1STUZ5bkZJUjN3YmtZeERrdUFI?=
 =?utf-8?B?ZUtpZmpBOGpJekF0OHlpUWNub0NTcEYzdktJelUrWmo1VVNuM1hPYmVVdmg3?=
 =?utf-8?B?OXRYWTRyOSt0NndpNHdLNTVjdFRiU2s3eTdUYWtrZDJoMldqbTBOZ0VhRHcv?=
 =?utf-8?B?VkkxcmdweWpmOTNuNE11K1RTc08reVVUdTBvZW9YOVVjdEgrMEZCZWtRMlIr?=
 =?utf-8?B?TGFUQjdSdXcrNUlsZVc5d29wNmJmT0gvcmoyc1dmUzhuckhWN1phbldqYVl6?=
 =?utf-8?B?N1hZZUh1SlpURGRCMVdZZFZsS2RPdUVHcFJ0dS9tU0IvWVNTWTY3c1hVcHhi?=
 =?utf-8?B?b2VvcEsra2Z5VkZzMzdwcFNweThpVW1kd21CZkJuQngxVkFoVm5kZXg5ZVVS?=
 =?utf-8?B?ZDhyNzY0dVh5NDhSRTBnMHRzOHNTQzRpbG1EUHJWM3R0Sk90NFF4SkxmZGth?=
 =?utf-8?Q?C38uwOKF0rvYEkaZOkPa2KPbM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ec723ee-3b8b-4249-b1ff-08de0bff6d2e
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 15:28:01.0981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PddskSLsA9TMqpCUtMdXN5GtuhOdq/cowX0gh/VKalSgRI640JdJdS4O2pcINYKAz550db9lxTrkClD2I6jtHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6993

Add MSI doorbell support to reduce latency between PCI host and EP.

Before this change:
  ping 169.254.172.137
  64 bytes from 169.254.172.137: icmp_seq=1 ttl=64 time=0.575 ms
  64 bytes from 169.254.172.137: icmp_seq=2 ttl=64 time=1.80 ms
  64 bytes from 169.254.172.137: icmp_seq=3 ttl=64 time=8.19 ms
  64 bytes from 169.254.172.137: icmp_seq=4 ttl=64 time=2.00 ms

After this change:
  ping 169.254.144.71
  64 bytes from 169.254.144.71: icmp_seq=1 ttl=64 time=0.215 ms
  64 bytes from 169.254.144.71: icmp_seq=2 ttl=64 time=0.456 ms
  64 bytes from 169.254.144.71: icmp_seq=3 ttl=64 time=0.448 ms

Change u64 db to atomic_64 because difference doorbell may happen at the
same time.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v5
- none

change in v4
- add check of return value pci_epf_assign_bar_space()

change in v3
- update api pci_epf_assign_bar_space
- remove dead code for db 0.

change in v2
- update api pci_epf_set_inbound_space
- atomic_64 should be enough, which just record doorbell events, which is
similar with W1C irq status register.
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 152 +++++++++++++++++++++++---
 1 file changed, 135 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 83e9ab10f9c4fc2b485d5463faa2172500f12999..6e48a1efe1eb267c4c80c7c09fe1c6f73c7ccf44 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -36,11 +36,13 @@
  * PCIe Root Port                        PCI EP
  */
 
+#include <linux/atomic.h>
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 
+#include <linux/pci-ep-msi.h>
 #include <linux/pci-epc.h>
 #include <linux/pci-epf.h>
 #include <linux/ntb.h>
@@ -126,12 +128,13 @@ struct epf_ntb {
 	u32 db_count;
 	u32 spad_count;
 	u64 mws_size[MAX_MW];
-	u64 db;
+	atomic64_t db;
 	u32 vbus_number;
 	u16 vntb_pid;
 	u16 vntb_vid;
 
 	bool linkup;
+	bool msi_doorbell;
 	u32 spad_size;
 
 	enum pci_barno epf_ntb_bar[VNTB_BAR_NUM];
@@ -258,9 +261,9 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 
 	ntb = container_of(work, struct epf_ntb, cmd_handler.work);
 
-	for (i = 1; i < ntb->db_count; i++) {
+	for (i = 1; i < ntb->db_count && !ntb->msi_doorbell; i++) {
 		if (ntb->epf_db[i]) {
-			ntb->db |= 1 << (i - 1);
+			atomic64_or(1 << (i - 1), &ntb->db);
 			ntb_db_event(&ntb->ntb, i);
 			ntb->epf_db[i] = 0;
 		}
@@ -319,7 +322,21 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 
 reset_handler:
 	queue_delayed_work(kpcintb_workqueue, &ntb->cmd_handler,
-			   msecs_to_jiffies(5));
+			   ntb->msi_doorbell ? msecs_to_jiffies(500) : msecs_to_jiffies(5));
+}
+
+static irqreturn_t epf_ntb_doorbell_handler(int irq, void *data)
+{
+	struct epf_ntb *ntb = data;
+	int i = 0;
+
+	for (i = 1; i < ntb->db_count; i++)
+		if (irq == ntb->epf->db_msg[i].virq) {
+			atomic64_or(1 << (i - 1), &ntb->db);
+			ntb_db_event(&ntb->ntb, i);
+		}
+
+	return IRQ_HANDLED;
 }
 
 /**
@@ -500,6 +517,93 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
 	return 0;
 }
 
+static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
+					    struct pci_epf_bar *db_bar,
+					    const struct pci_epc_features *epc_features,
+					    enum pci_barno barno)
+{
+	struct pci_epf *epf = ntb->epf;
+	dma_addr_t low, high;
+	struct msi_msg *msg;
+	size_t sz;
+	int ret;
+	int i;
+
+	ret = pci_epf_alloc_doorbell(epf,  ntb->db_count);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < ntb->db_count; i++) {
+		ret = request_irq(epf->db_msg[i].virq, epf_ntb_doorbell_handler,
+				  0, "vntb_db", ntb);
+
+		if (ret) {
+			dev_err(&epf->dev,
+				"Failed to request doorbell IRQ: %d\n",
+				epf->db_msg[i].virq);
+			goto err_request_irq;
+		}
+	}
+
+	msg = &epf->db_msg[0].msg;
+
+	high = 0;
+	low = (u64)msg->address_hi << 32 | msg->address_lo;
+
+	for (i = 0; i < ntb->db_count; i++) {
+		struct msi_msg *msg = &epf->db_msg[i].msg;
+		dma_addr_t addr = (u64)msg->address_hi << 32 | msg->address_lo;
+
+		low = min(low, addr);
+		high = max(high, addr);
+	}
+
+	sz = high - low + sizeof(u32);
+
+	ret = pci_epf_assign_bar_space(epf, sz, barno, epc_features, 0, low);
+	if (ret) {
+		dev_err(&epf->dev, "Doorbell BAR assign space failed\n");
+		goto err_request_irq;
+	}
+
+	ret = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no, ntb->epf->vfunc_no, db_bar);
+	if (ret) {
+		dev_err(&epf->dev, "Doorbell BAR set failed\n");
+		goto err_request_irq;
+	}
+
+	for (i = 0; i < ntb->db_count; i++) {
+		struct msi_msg *msg = &epf->db_msg[i].msg;
+		dma_addr_t addr;
+		size_t offset;
+
+		ret = pci_epf_align_inbound_addr(epf, db_bar->barno,
+				((u64)msg->address_hi << 32) | msg->address_lo,
+				&addr, &offset);
+
+		if (ret) {
+			ntb->msi_doorbell = false;
+			goto err_request_irq;
+		}
+
+		ntb->reg->db_data[i] = msg->data;
+		ntb->reg->db_offset[i] = offset;
+	}
+
+	ntb->reg->db_entry_size = 0;
+
+	ntb->msi_doorbell = true;
+
+	return 0;
+
+err_request_irq:
+	for (i--; i >= 0; i--)
+		free_irq(epf->db_msg[i].virq, ntb);
+
+	pci_epf_free_doorbell(ntb->epf);
+	return ret;
+}
+
 /**
  * epf_ntb_db_bar_init() - Configure Doorbell window BARs
  * @ntb: NTB device that facilitates communication between HOST and VHOST
@@ -520,21 +624,25 @@ static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
 					    ntb->epf->func_no,
 					    ntb->epf->vfunc_no);
 	barno = ntb->epf_ntb_bar[BAR_DB];
-
-	mw_addr = pci_epf_alloc_space(ntb->epf, size, barno, epc_features, 0);
-	if (!mw_addr) {
-		dev_err(dev, "Failed to allocate OB address\n");
-		return -ENOMEM;
-	}
-
-	ntb->epf_db = mw_addr;
-
 	epf_bar = &ntb->epf->bar[barno];
 
-	ret = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no, ntb->epf->vfunc_no, epf_bar);
+	ret = epf_ntb_db_bar_init_msi_doorbell(ntb, epf_bar, epc_features, barno);
 	if (ret) {
-		dev_err(dev, "Doorbell BAR set failed\n");
+		/* fall back to polling mode */
+		mw_addr = pci_epf_alloc_space(ntb->epf, size, barno, epc_features, 0);
+		if (!mw_addr) {
+			dev_err(dev, "Failed to allocate OB address\n");
+			return -ENOMEM;
+		}
+
+		ntb->epf_db = mw_addr;
+
+		ret = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
+				      ntb->epf->vfunc_no, epf_bar);
+		if (ret) {
+			dev_err(dev, "Doorbell BAR set failed\n");
 			goto err_alloc_peer_mem;
+		}
 	}
 	return ret;
 
@@ -554,6 +662,16 @@ static void epf_ntb_db_bar_clear(struct epf_ntb *ntb)
 {
 	enum pci_barno barno;
 
+	if (ntb->msi_doorbell) {
+		int i;
+
+		for (i = 0; i < ntb->db_count; i++)
+			free_irq(ntb->epf->db_msg[i].virq, ntb);
+	}
+
+	if (ntb->epf->db_msg)
+		pci_epf_free_doorbell(ntb->epf);
+
 	barno = ntb->epf_ntb_bar[BAR_DB];
 	pci_epf_free_space(ntb->epf, ntb->epf_db, barno, 0);
 	pci_epc_clear_bar(ntb->epf->epc,
@@ -1268,7 +1386,7 @@ static u64 vntb_epf_db_read(struct ntb_dev *ndev)
 {
 	struct epf_ntb *ntb = ntb_ndev(ndev);
 
-	return ntb->db;
+	return atomic64_read(&ntb->db);
 }
 
 static int vntb_epf_mw_get_align(struct ntb_dev *ndev, int pidx, int idx,
@@ -1308,7 +1426,7 @@ static int vntb_epf_db_clear(struct ntb_dev *ndev, u64 db_bits)
 {
 	struct epf_ntb *ntb = ntb_ndev(ndev);
 
-	ntb->db &= ~db_bits;
+	atomic64_and(~db_bits, &ntb->db);
 	return 0;
 }
 

-- 
2.34.1


