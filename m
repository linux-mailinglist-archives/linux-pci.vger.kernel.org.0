Return-Path: <linux-pci+bounces-23368-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E74A5A4AF
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 21:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 854A1188748B
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 20:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D301E1041;
	Mon, 10 Mar 2025 20:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YsVo7dKB"
X-Original-To: linux-pci@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013033.outbound.protection.outlook.com [40.107.162.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6341E0E14;
	Mon, 10 Mar 2025 20:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741637868; cv=fail; b=SSAH9DWvCnN/ZmvoD2CRU9kb61/P0yKfCdld8/8YrpRtTfEH2XlwHzkX+8dCCNl4RQd+p6OsnMkkr2lscxB7uMPlEX6oiS0ahbuztaG6PqOFYZxMiaoEleBES1i8bTIFAt62H24zuRgoeulAcx574JdcuyzZ9dRqoBpgqMzDBg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741637868; c=relaxed/simple;
	bh=QhVF5V0DVVvhMdwW4CUPAVPj/0hNpWzMoasf1XPM7SI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=eQVw6UuHfAH/Bse2CYv5msfqyQuJTx3atKEm9CABCuJWCj1zJfaUTzH01dIco/knS/jHQS7CPlKimqL3/FQ9iQGrfgzyfXCIPAMexMks3yyGKFON0+zEnFZFH5mpATWvPFomlvXgFrS0EGG3eoo1apvXpyS4ONj2UBluimXlQ18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YsVo7dKB; arc=fail smtp.client-ip=40.107.162.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ohjcOWnDH31T+vjhONpR+l7/qTy3jpVh2arrnnB9q4+/cwDC7hyX8OS7bx4dAAe3bw3Can6shKpsAc54LmGxELT/LCXMJfEqSziBl8TCF20Qv0qQNF05MvE2Zj4nlJUJ2y2QulCx25uUXjJLlqiYIQJvUX/huG+NENuJAozO8XlbwQ4whxnt1NUXV2O+jFpoy7F7S/qJ7meVBVj5rYV1il37ufJE2e0x0singcMnrbae/V237ArgrB4PDk+e2O5YRo6lbIlKXL8eXXLp5Kq9ALyecXK2OssMlWuJ4afYIyWKADmNQCmrvDQhE97qunK8QuzWYHJJwDvSehKJze/FFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I46nKxQBiSzsvmNacEJWpnMZVMsbjrmSRod/YrWic9E=;
 b=f2crUR652oU4qTJEaHjL+JcuiQ15RKYmGjoPQ0gQIm0uEhoKKpvx2WEgKsOnDxB2w6s2G5wgficpbMrgsYvEAXB7K9EJJB8Lp6EE5Cs0MJ3ZDhJQSrdR70fa+5NWqbZOMoxGX4wBNfWIVdyJkXltnRj1Aa5hYpYUBvxSabBQsB6FO3JhS2VJXV8cZvRwEjyMbERlwr+iMh4LrOiT93ihK9q/R4rHwJYhsF+kB1+aKaSvBgSC82B4Asn7xMTk/WlepGUREr/HeR64LU2IjpP3DaJkddEs/1cKKRqbRD/j+7ffm4XlhhHUOROe8K/dJqt/K5uvElzOsZD5P3c9x1S2fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I46nKxQBiSzsvmNacEJWpnMZVMsbjrmSRod/YrWic9E=;
 b=YsVo7dKBvhZRiePkeYO5FaPvdHUqwiGfBVUmc7r5NqAaRkQ+7Q1BoFZ3htrldjfxlOT3tCrUH5SM158hoBW4Dp8RU60WrEdFmtuzJAEgQfppKqbrsoAr7W8wJiaMj9Mnv8cZuTUwIivjkdCVDd6+gz+KpEv/KkbxVvahvaN9UmIyeHxiulAk7dd8jwIJ6I0R2lAhggzbnUejMi/WyaMDP5+m2NvfHRL4Or9K7HlSMxmhaRlo3RopadD7/WFfSnW+Yp9FUVsXKA6bT2C9ySM/Jsz7fqyIp8JPt+nQswaHmyahdwT4YlUpGp1Jz9ugQ5JMGX0toT+QTndu6DxTDgoVfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8261.eurprd04.prod.outlook.com (2603:10a6:20b:3b1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 20:17:44 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 20:17:44 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 10 Mar 2025 16:16:43 -0400
Subject: [PATCH v10 05/10] PCI: dwc: Use devicetree 'ranges' property to
 get rid of cpu_addr_fixup() callback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250310-pci_fixup_addr-v10-5-409dafc950d1@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741637834; l=4970;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=QhVF5V0DVVvhMdwW4CUPAVPj/0hNpWzMoasf1XPM7SI=;
 b=oWeL08AV8kS3gF/j389YC8VnT3cApm29uf2dHqLBicwZKwv5LFKLxDff6cZ4J3RdSODMWJPP8
 IQU/wZJNXrNDP2jsAU+UEKJhSWBYKeLpY0WNJCJCmEUiqL5x3is9Cp5
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
X-MS-Office365-Filtering-Correlation-Id: 2440c4f4-e6a6-4544-d8f3-08dd60109dcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c3k4VExQdGJUY2ZnMGVyaDRsUXFIV2FGVU5kajU4c3FibGRoRjFGMDN5TXN6?=
 =?utf-8?B?SlNqYXorUzJ3SzBLUzlxMDFpUHluZU03bW9wbFRia0d3RnlLbHl6UzlIczB0?=
 =?utf-8?B?bDN6ZHNCTENhSTNPNUx2K0I4ZU5BMU5Ea3pkUkoxUWdyYVpYbWF6TG01aytu?=
 =?utf-8?B?cUdyZmJWdW90MG45WGVIYmsyTFFkQ1dlNE1xbXJ4NHJ2YkIwZElHUTB6REtv?=
 =?utf-8?B?WUtOWkViU1prMWdGMGEvc0liTm50QUFZT05ySy9BT1Z3c0VBbURPblNqSVF0?=
 =?utf-8?B?M0ZxTWJqcHh3MnlhV3czTHppZWxKMDQ2T29zdTJaNmhIWkFlck5MQlM2d3dO?=
 =?utf-8?B?dldKS3V0OExxWlQ5alpjNUZrNDlEVmhVM2ZlbUtQQ0VZazNoaVN0OWNURFp1?=
 =?utf-8?B?ZUxzUG1XYVFvMEJML3UweENlODc1R2t4YTVOVmZGNnFPMzJVZ2V0VHgxVTE3?=
 =?utf-8?B?TU5JMFA3NVhNOUR3dlFnSUtNOTBvdkFHZlAzYkFyUkJvUEdTKzdiQ0VtbVMv?=
 =?utf-8?B?aC8xRmpWOHVwZHZ0TnJnNjdXWjVBR1dXVHVkWjFmcWdGT1VaVzBvTkR6a0dS?=
 =?utf-8?B?Tm8xZnVIZXYvbmFLc0hQRVhkK2g5eFd0WkdPMTkreHBJVTlOSHhHMmY0VmZ6?=
 =?utf-8?B?dFBQeUd1N29NUC9QSVhjT0preFd3QmNxREFYUEt3WWxIVUZkQzRNYkdOOE03?=
 =?utf-8?B?aWV0QUxzeGtHZkM4L042WDZJdGgrZWNlTUp1QjRwSGw5UFJWQnhPdUtsSXA0?=
 =?utf-8?B?REg3K3l1OWJCZE9YYk9sZXc1akc2SENMNU4xNkxaK0ZUOEVrMndIVEUyWWUr?=
 =?utf-8?B?WnJzaW4rS1A4Wm00a0JHNFhkaGVtM29yc1ZSWng2UnhBQ21jalJGWTJLbFF5?=
 =?utf-8?B?RjFwN1NHRklMRTNXTkdiY2ZtNUk5SGNZNWxYR1RoK0tzTEJ5UXIydHBhUE5H?=
 =?utf-8?B?NEpVRzN6b1ZCcW5QS0s0WjlGelZQR0xKQ2lCK1Z4Zkw2SW9YTGt2eHN6ZC9B?=
 =?utf-8?B?RWxPVmxHS0xQcU9hb1dqQVQ5aG9RNlAranQrbVcvd2JIc1lPUkVSODlvcHNK?=
 =?utf-8?B?TUErcHZPRWZtTmsyQjM5c2kyVXp4WXFVZmFOOG9ITjlQSnB1OElKQnBCT2tj?=
 =?utf-8?B?d3lXSWpoWG1wQk5lWHhhUEhQUUFpaGxyak1lZjQydEFUQnpKbVpkTGMrNnp5?=
 =?utf-8?B?Zk5zK0R2bXpkbGY1aCt4VWZtVXJIVVIxQy9aUFVBWDhhUWtZWmYveU01YVVF?=
 =?utf-8?B?T0FDZmlaUU5NOEp3b0dkb3NudHM3cmFnd0lLSks5eWt3NkhrVmlpdlN3WTVi?=
 =?utf-8?B?czV1bEZPQklyOHMvRkhWY1pNT0Y3S0tLVmlncDZOS010a0hKc0VVWG1acFFu?=
 =?utf-8?B?b2lzclVBdk9FaDBYWUo3N2JaK0dJbEtSMlBha2k1RHZ6VDlYNHhEcjVid1Ni?=
 =?utf-8?B?cEZXLzZRTmI4L3Y3cWFWMjBNK2g4dlYzZTdFM1J3SVVKays0QytyYTNRSGpU?=
 =?utf-8?B?aGg3YkFXblkxNmxmYzh4eS9TQ0VRc0gyWXl5c1hmMVVEc3U2WURvVS96R1lq?=
 =?utf-8?B?WHo1alZOTEwrSVFwT24ydU9lQ2Z4YzFpYmpJaTRhRmF0NWcwU0dWL0pFMXlU?=
 =?utf-8?B?dzVRRUFxREI5TG9OUnU0QzZCT09VK2pzelAweC8wR3VEaVcvTTY4c1pkdDJY?=
 =?utf-8?B?RGR4cE1PNGNaanNJakNRT1VOVzRUWGZJU0VSeENheGpUKzJ5end4YitYQUZs?=
 =?utf-8?B?cDVQcnJ4ejFOU0Fhb242a05BUGc4VTlaYko4RGI5TmxGbjJtSlE2Q1phTXB4?=
 =?utf-8?B?OXVZNmV0SFFQMmwreXRZeElqNnBTTWk0L3FQTkp4NHNpcFhPMXdvVW9EOHc3?=
 =?utf-8?B?bHNobUpmMExDb2p1WllOVU5XMmpWVlMybXhtbUxxSisvQmFqUnBscXlIS1dh?=
 =?utf-8?B?bmFjc0hLZWJpUmtZS0krMHhMamZlOXB4TktNVTlGWTFUZzZvNm93L0xYc1Nr?=
 =?utf-8?B?UEF4b0kwN2JnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0s3c1dNcVVLZ3Y5TzQ2ZTd6UFZWSHJaWHdvdzZCdi8wV3JpTFExaXFEZGRw?=
 =?utf-8?B?NUtGemdITXBjM2ZjMXBiV0cwZmJGcDRHdmhDaC9oVTdtcGhaa1JibFdoa1BJ?=
 =?utf-8?B?NUVST0hXMjFiTEEzVjRHQUovOVVLSXB6RnUxMzZZR2tVMG1pMUQyeE5UdXM2?=
 =?utf-8?B?ME5KMzdDK0JvODRRMnVGeHBuSy9rcHllVnp2dEJQQ2s5QUFZd1ZBUjdPdzVJ?=
 =?utf-8?B?amVPYTNhMk9Wb0xZV2JOc0ExSU40VTJNRm1RSzMzck1pZ0V4WWRxV0FGR3d1?=
 =?utf-8?B?WlFmcDlRSk1WZTk2dlgwKyt3aExnQm9xWlBWYzVEU0kvMVZOK1RNUW5Kd0tw?=
 =?utf-8?B?a1ZiV1ExdXo5YU5UR3N1RURuaDJWK0d4bmhBcEVCOHhPMDhlRWd0RmV1d2tZ?=
 =?utf-8?B?WWZ0NGFBZ2luMitHcDE4RWNnYjJFRjVOM3hEekRtRjVIYzMxRlR0NFJTTFFN?=
 =?utf-8?B?NUdvbGdsVG1KMHV5N09uNW93b0Z5Y2ZuSmkveTR1MldONTRKUkxzWnlFTlJi?=
 =?utf-8?B?anUxNC9MVCtHWnRKMnRkUkNiL2NoWkV1b3h5UGNvaXhHMTIzZFVZZHM5bXgx?=
 =?utf-8?B?S0VjUEYwVm1MOW5mRE5tcDd2MmliN0ViMzFLQit6UUFNR2s4QWN2a2FwZXpp?=
 =?utf-8?B?K2MyTWJJeGZ6RE5zS0d0cnhZNzlieDB0RkVnSFlialpsZkVBbHI1UmRVbUha?=
 =?utf-8?B?NlZMMGt6V1dpMnFxS0JMMjJNWHpXT1ptM081dnBvRDlyWFFOVXpYQWlZN1dy?=
 =?utf-8?B?MzN0enBkYXNlb1lrYW04YmhGazBoVHFrZ0JySUlZWUZSaGVEV2xERUwzM2pB?=
 =?utf-8?B?RjQyTTl4Qk93NWorclBUL3V5T21zL2p1V2U0ZzNTSjFPWHVqcDdSYjJVMmJn?=
 =?utf-8?B?bkE0YldSODVBdzAzSy9YTURLV3RhMEN0bG9vKzM1SE93QS9XMDEyNEVoS2J0?=
 =?utf-8?B?ekdxYm1qcHhQaDBWT2NPMTRreHRTaHRrTXJETHBLNWY2aUZNdDJ0N3dHVkRi?=
 =?utf-8?B?VXRoclRjSUFZdUs4Z1pmTHljZXc2Y0FGYmhvSGpqWHcvQTJoYVIvN0ZXWjVk?=
 =?utf-8?B?bUV2L3dpZFhiRWNPallHaVdSdG4xSkF0REMzTkIzenNrVEwzZmZjNDVRbWJB?=
 =?utf-8?B?eU50RVJqVkJYM0szeldTdmU4T3RERHM4RmtKcHJ5Zkk1N3NnNUd5UDF4V0Ev?=
 =?utf-8?B?blpOaGI2aU1ucUVIbnVZMWpwVWZqZlF6c3RqZ1VCb1FZbHBCRmp6MEgzMm9J?=
 =?utf-8?B?M0o1YklBZG1xUUF2QUUzMnpWTjkySFBROXhNOWEyRjNNRGlsZFhlK1M3aEJJ?=
 =?utf-8?B?bkF4TFZQRFpoTVV2b2FBanE4MkhBLzNoV2o2TmZLekV6VTJOa3VzQVJoVDJK?=
 =?utf-8?B?cmF5SWV2a2N5eVVBRFZpUUN0YjlCazNLNkdUWEZQVVRObVVtOS9PRGY4RUcv?=
 =?utf-8?B?cTVVVWZOTEFkWE1lMG5vZm1sRms1cUVGeWhEN2NudUZoZHZhUVhWU29RQ2VD?=
 =?utf-8?B?M1RwZVFnZFRvc3ZkR2d4dHNnRTAvL1VnVm83K2E3UnFtNU9FN0poa0V4UTBy?=
 =?utf-8?B?cWZkV3ZZTFNMTE13Q0RiM09wNVVpNWRSbEN6M0JkT2c4RTVTblQwdlp4dFQw?=
 =?utf-8?B?VjdPLzRTbXA5RG96bWFoYXdaL3dIQWordWpHcVJrUjhMQk9XSllUTC90QTc3?=
 =?utf-8?B?ZXg4V2d6L09kVjliR3dJbzNoclczaHRrcFIzeXRsUkYyS1hTdXRoaE9UUTNM?=
 =?utf-8?B?Wk9OUGd3WHRJakE1aDJOaVZ4dzdXRDNPMUUzOXNMVTRkYzkraE1kSkwybkJZ?=
 =?utf-8?B?MEZvNkRnSzBGemVYZDlNVkkrTnlMVS9Ud080VTIvKzJhRDhhRmRJZzJZV3hC?=
 =?utf-8?B?WEhQWHZYYXhvRlA0SW5vTXdFZ1BHdGZVaTZZN0tCaGpzcjE4SnZITEZZcits?=
 =?utf-8?B?emtaSGJNUERYWDJnVE0vOWU2bi9VNmx0bTZKaDRqc1hBQnVFT01ucmNRL2VX?=
 =?utf-8?B?SWVDRElXOUFlK0d4MjNOMFYxQ0Y2UXhuS0s1Z1dQM1FWajhDbDBwbkhIQ0hs?=
 =?utf-8?B?OHVYMUpzQ0gweExTYWozZ1RKbkg1VUQ3Q1RxQVlRUXZZSmpPK1FFS2xWbjFy?=
 =?utf-8?Q?d7ew=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2440c4f4-e6a6-4544-d8f3-08dd60109dcb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 20:17:44.0877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0l18dtgLjP9SUNPPGH73bXXeY5N3MO4pRTQ3uPervCpIXaETcoif5oE0lb/HZ7S3UGMSQUWXflbMrXMYEfl5DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8261

parent_bus_offset in resource_entry can indicate address information just
ahead of PCIe controller. Most system's bus fabric use 1:1 map between
input and output address. but some hardware like i.MX8QXP doesn't use 1:1
map. See below diagram:

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

Term Intermediate address (IA) here means the address just before PCIe
controller. After ATU use this IA instead CPU address, cpu_addr_fixup() can
be removed.

Use reg-name "config" to detect parent_bus_addr_offset. Suppose the offset
is the same for all kinds of address translation.

Just set parent_bus_offset, but doesn't use it, so no functional change
intended yet.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v9 to v10
- call helper dw_pcie_init_parent_bus_offset()

chagne from v8 to v9
- use resoure_entry parent_bus_offset to simple code logic
- add check for use_parent_dt_ranges and cpu_addr_fixup to make sure only
one set.

Change from v7 to v8
- Add dev_warning_once at dw_pcie_iatu_detect() to reminder
cpu_addr_fixup() user to correct their code
- use 'use_parent_dt_ranges' control enable use dt parent bus node ranges.
- rename dw_pcie_get_untranslate_addr to dw_pcie_get_parent_addr().
- of_property_read_reg() already have comments, so needn't add more.
- return actual err code from function

Change from v6 to v7
Add a resource_size_t parent_bus_addr local varible to fix 32bit build
error.
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410291546.kvgEWJv7-lkp@intel.com/

Chagne from v5 to v6
-add comments for of_property_read_reg().

Change from v4 to v5
- remove confused 0x5f00_0000 range in sample dts.
- reorder address at above diagram.

Change from v3 to v4
- none

Change from v2 to v3
- %s/cpu_untranslate_addr/parent_bus_addr/g
- update diagram.
- improve commit message.

Change from v1 to v2
- update because patch1 change get untranslate address method.
- add using_dtbus_info in case break back compatibility for exited platform.
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index c57831902686e..eaa6dd4c7edda 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -478,6 +478,15 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 	bridge->ops = &dw_pcie_ops;
 	bridge->child_ops = &dw_child_pcie_ops;
 
+	/*
+	 * visconti_pcie_cpu_addr_fixup() use pp->io_base,
+	 * so have to call dw_pcie_init_parent_bus_offset() after init
+	 * pp->io_base.
+	 */
+	ret = dw_pcie_init_parent_bus_offset(pci, "config", pp->cfg0_base);
+	if (ret)
+		return ret;
+
 	if (pp->ops->init) {
 		ret = pp->ops->init(pp);
 		if (ret)

-- 
2.34.1


