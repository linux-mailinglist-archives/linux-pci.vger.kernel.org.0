Return-Path: <linux-pci+bounces-20506-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E598A213E7
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 23:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 302171680CD
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 22:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3501F238B;
	Tue, 28 Jan 2025 22:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZrBEblGT"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010003.outbound.protection.outlook.com [52.101.69.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4401F12FA;
	Tue, 28 Jan 2025 22:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738102119; cv=fail; b=aC0ainJOaNkewSTK2D1jrssYzNOHam19IDrEt105KdE+g445CX5vMmbntVwAkOKj/UgO5PKiyJ8zIi+u8TurEkuOCde2g67v/NEgE+5UlEQWKxBcfR3F9sFjCqH48cJvNcGL/IHrkCpDKVRnX39nJC0WCPFFEpWH+6WyUx4UBhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738102119; c=relaxed/simple;
	bh=zdPiv6W4EwoEDikp6bIO3+h//fUGK+Gw+OhRncm83oA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=G1mqu7aI2ThnaDIgXMnjO5tApE1kLn84NUTSqpRzZKzN/o8hFaRJAb7FbRBrh3+NI57o6yZADG341aeKEtD4QCGNA7+gMmSMks5xxKt2WQJr1+krkaojDxlSSzI2qZ2esTkazbIW34HJN4Oy3488Yq4HSHCL6D75XiTWssuy8s8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZrBEblGT; arc=fail smtp.client-ip=52.101.69.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sHV9msM7L6FvCXn9BJsQy7UcQUV/0AXJd17Yv6qkad/vnRIzIXgT2H9UoOjt8vp+Nkw8hlSSBEM+bIAzH1f0uKzLPyUeir5+KZhnWkWLO9tvoxxsoJ5M5IOcRhnvykK8mlI6Ojo3oa+6opOpTXyeiJsZ6EgdBQHq6YqMWNZOgOrvEbxEYjzSnNMbO8JD5SoRmFxN9ZlhDLJNOwA854ksljo9YT9OzNrM1VbLh4YArKpFoHqZi7LYnX/0/xvS7Nyethsx61E8cDLQ7XQu5o/M9deK8GzcO3J+d9PSy5QQcH0LK0R1tUtEEGXS0u4T8nQMagGxD/r0LXJFeaHCXCPg1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uTuZtBV4X19Rh9dpt07l8O2/CoaPLj4uomuMR/R4G/4=;
 b=MOzkFde6H0ULFHzSl3EWP6w4AISNX/k4w4sjF/WzqeGHwStxEcp30zFjOERcyjmA1uw4VYebgmmMmuU0qHUhTzwF1lMGWKipX+pcN3JrPXBXzuUu72hR/TgIooxc69lkDiJ/zVf48ocN9u/xymuuxa81J5YKdYEjFJbLJKQXlQuND04aBF8X6asTbyBdb4anDADa1H6kOR7RQrXa42mWRZs2E8+7tnmBiSJwXrp1S1+jCj4lQaIYl1ZJOm8H8/1yC6m9E0HgWQeTlsCt4znwVtxWt2DJ2Oj+baDxLstz7cGdaiVhKBIj3PbLCd8aFS54+P7wTM28QK376kRoQ0cUrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTuZtBV4X19Rh9dpt07l8O2/CoaPLj4uomuMR/R4G/4=;
 b=ZrBEblGTmECPjTAu5WhVdrOtq/8g3oUG+PT1yDXTOywYoJi5kRKiY+LBG8L9vYVgUJGTOHICqVD84vAsgG9/CKcRTmVaCqbGsdQS7S+Z9URUnrVtJKUJhuNIWUx45Dtb2UuXi3OjpaUTxajcygYP4w/iXSCARL6WRmoERS6JDMbtgYGNd/ozMg37nRwCOBA5MuNpeXTtQ2AODWSet4fp2Qgy1ziixGQl0oBBZ0mebXXzQdMXDkQi37xv83lrBXDtknyQLRN1IBCDBUc1T22a0Wv1mtopd0cbIHjuZTE9QrMebdLcGEdGArJD/6YXSegiLjf9MunACBC9Zjf0aaX5ig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8555.eurprd04.prod.outlook.com (2603:10a6:20b:436::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Tue, 28 Jan
 2025 22:08:34 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8377.021; Tue, 28 Jan 2025
 22:08:34 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 28 Jan 2025 17:07:35 -0500
Subject: [PATCH v9 2/7] PCI: dwc: Rename cpu_addr to parent_bus_addr for
 ATU configuration
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-pci_fixup_addr-v9-2-3c4bb506f665@nxp.com>
References: <20250128-pci_fixup_addr-v9-0-3c4bb506f665@nxp.com>
In-Reply-To: <20250128-pci_fixup_addr-v9-0-3c4bb506f665@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738102099; l=8860;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=zdPiv6W4EwoEDikp6bIO3+h//fUGK+Gw+OhRncm83oA=;
 b=9SJ5Ha9pZUHxUxBTELsyjYZOVqsLA985hLWG/ZygSP1mnYEOJPGkDQxvP+8FEViYtsib6oScf
 vCREh5pHoX7BqioHcroCzbRxgQsBpCWMeE+pELBxAbqnGS11+lBeT2d
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
X-MS-Office365-Filtering-Correlation-Id: eed99987-69f1-4b5b-abe5-08dd3fe84ea3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OHFVWGhLeERvMjZQT0V5dzBzUDlldEZCM2hRU2RKZEV5TnhGa0t3SE9MSExX?=
 =?utf-8?B?Z3BRSnB4T2xGZUo0OWdabTRXN1JzeWU5WjVRK2tIdjEraU0vM0RFekd2YVMw?=
 =?utf-8?B?Rk5BMFRWMVRqMEZXeldXaUZycjlmUkp1MWszSEU0T09IY0NDTnh2TW80YzhW?=
 =?utf-8?B?MWx6aXA0K2pSK21rQ0xMVW5ySkpzZU9VM05GT1p4VEYzRDJtakd3Tzk1WUZz?=
 =?utf-8?B?aHlLZ0tiWkhZZ253Y291ZlRYU2RhcXU4UEVUdUpSUWN0bk5yUVpIWnByNkZE?=
 =?utf-8?B?dUdQam1JOWpnd2hxc3hSdkpycTJOS3p2YnEzMmVWbXFyeWluMEdMd1Q4T2tF?=
 =?utf-8?B?UXRRbWRZbXEwQ0E3TmQ3Zy82NEZ2MXJBUHoxUE1aejF4NW81SEN5bmo3VkVk?=
 =?utf-8?B?OGY4eXBpbjFjSTAweTBRMFg0b3NJQm4xcWZrNzdaUVFMTTlJWWVwc1g1d2VN?=
 =?utf-8?B?b1EyL3lLSFNMakpKOXgwdTlzVXFIYlFKWUZOdlNDTjdYVmpsZG9yMkYzekNu?=
 =?utf-8?B?YjZEZFVyZ3d6Q3BqT01Cb2hwR1dic0JxNlFxWk1vNVRVYWRrczBlY25yMDdu?=
 =?utf-8?B?MkhLRFh2RUdtUTF5WWtaNkV1ekxXZjVhcitRbWNSOExhNDB5Z2tZK1lIWjNv?=
 =?utf-8?B?MFcvRGZuYUhVL2xkUFBlRWtJNHBiUkFaWGFsT0xCUUc3MGtYNDJpc0Zhby9y?=
 =?utf-8?B?M0daYndqemVJckJwdkFGczlwSWRDMDk0MWNaemZ1Y3JyOEJ3cWhVQUQyWjdy?=
 =?utf-8?B?K0h6UUl1K3BaS3RrcTl0NlRTTk12cmJzU3o5TXFENUJkNjJ0SHVOUWR1ZE1X?=
 =?utf-8?B?MmtnWUJndFByL2l1eWdlbEhpQms5ZHNFc0ZINWxMZ2lXZXcrNHlqN0M3Qk1k?=
 =?utf-8?B?aHdXZEhrZ0ZMaHNPNzZKd3gySjZhNTJmaG15WS9SeHFicFgvaCtkRVY1dmZ0?=
 =?utf-8?B?cE1WMmdMNzJJTENnczkwaG5XajJmcWtPSUxzZnlUUVJLMi9TcGxSQTRUbjVR?=
 =?utf-8?B?QktMM2IvVjdxbS9KR0pEZzM3TjY0RUd4ZlJMRVVvNHBndWZnWGRTZjNGTkEz?=
 =?utf-8?B?eWVIR2ZrdjlNOUpRK2RZZnR6RVJRbzFiMjZZNmRWUHB6N1gwT0t5RmhMbUhw?=
 =?utf-8?B?MjRTRDYxYjNONHRsajg2alVXRk1QbTJ3a1RVV0k5Vk1KZHhNQ1krYVZ4TFls?=
 =?utf-8?B?RVJrQlNRRnVpOGJpUFgxQ2ljWWJ3SmJzbGgvQjN3SC9aaGlScWZ2MDlaanRM?=
 =?utf-8?B?aitDWllsS1dYaXgyQlQyYVV6QmZRT1lYQnpzSTQ2VnJraTdVQk1OZDhmUTho?=
 =?utf-8?B?SVhsY1kyMGJ0L1E1S1NoeUJyNUlKaGFtN3A5WERYUHE5VkQ0ZGpXVnlsLzNQ?=
 =?utf-8?B?bC9IelZvV1FTNDJ5K0tyVy9LMERQLzBUcE0rZ3pBc1cvZWhocmd4SE4rU2pT?=
 =?utf-8?B?MlhabjZNRnh1ZDR5eE1tS090eFZRS0lsVkdXNTYxbVZiNlMwNXA3dDFEMnJs?=
 =?utf-8?B?bzIwakp5Y0s3Ymw5R1VaNWNJUXZPWTRTRXQ1NFlIckZ3TVZJbkp0NEZyT0F5?=
 =?utf-8?B?Qmd2TUNia2kzZXdlc3pPRk1vd1JoRE04alZZSnlHTHp0UTd0OWNMWE1IQWRD?=
 =?utf-8?B?a0NxRmNxcHFhenRNUnF3VVFvazErZEk2MmlnZWIxZ3ZIUWFBWFhpUmUzeG15?=
 =?utf-8?B?RGpTcDhGY0JzUWpWa2pnM2JjK1ZKS25McHREU1EvdlFwSmsrSi83dWt3Vmh2?=
 =?utf-8?B?TnBCV1FIMnQ1ai8vN0VsZDAwTzV1SzlzTzRESWliaGxOZVpCenNVZTB3RVpj?=
 =?utf-8?B?RkQyUlhMcmVpODRrMXZWRzNaMlFYb0gxeXl1dUtMbEFQUUR1TlhLT1RUUEJ1?=
 =?utf-8?B?YmFPUmxKczJtS3pBeHBMWUp6RkFwWHhiS1VYUjlUZGExSkxkeG53dTBsejVq?=
 =?utf-8?B?M3ZWdkx1aXFFamR0cUkvZjY1ZGo4NDdQcFplRmhmMHBzZmtLU2NlSmJvbm1E?=
 =?utf-8?B?UmdXYzJrRXp3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QXlQYzdsL1FaeHZwRkpHcnpPRzZJZm1rWW5BQjhEdFE0Tmw2V2xxMXgzQjBB?=
 =?utf-8?B?amNDOFVlc0Rrd0FmWVFKRi90M3VBUXFWZkFzNlNCczdobWJKQTBIYjlpSVNZ?=
 =?utf-8?B?bDMwa3V4YUlFMlA1U3VjL1N6U2FZOVpnaE9KTGhDU1ZPTGN5Wk82aWZqRUpa?=
 =?utf-8?B?RlJTNzFZQVY5YnlIb2dFK1kwWFN0U0UyOGRIeitwNlJRc09SakcvUy9lYzBX?=
 =?utf-8?B?RzRpZC9JdW5oTU9HR0pqTzhDU1V0a2d6MnN1RE91ZlM4cmNrNWFBamhoVjh3?=
 =?utf-8?B?NmJhbWJRQ2JKdG5CcThsS3loeXBrSldUZ0s3WUxKZnIyMUorOEtsbjNwTkxS?=
 =?utf-8?B?ZnNHcUwvY2xtNk1OV1RUaGQ2bXUvUk8wcmVtQlVzZmZVc2hEakN0dzd1MUNp?=
 =?utf-8?B?SzkxSS8xUTgxaG9sdGgwaGVCbnZVRm45S1hkdlIzaUt1Z2dkUC9JWTJHZUR6?=
 =?utf-8?B?ejRlcldhYTdBVXNUYllRVVBCRDkvejhnZEVqL2Jnb0x3ZEp1N3k1ZDg3Vnkr?=
 =?utf-8?B?SzRrWDVkejZXUkFqS3c0cUlmSzZlYk1FRS9maGc0VzRSVjJOeVpDZEh2bHQy?=
 =?utf-8?B?eUpaM0N0Z29LMjRaRG02RUxVZjFsamVzeXRKYWFONXRpTnlUY2dvQ3lmNlps?=
 =?utf-8?B?M0ZLTXB1elJYR3RnRlgzVzVmcER2YkhsUDgzRWxyZlNlNnBxSzJwL2Rsdk9N?=
 =?utf-8?B?YnExY05DWnVKNzFhMTVQZG9PYWJ5NTlWdlFueGltbUVSV1JXK1BuZzBVYm4r?=
 =?utf-8?B?QXRMZnV0QTd6UWdlNGxZWE9MM1RUN0Y5aUQwbnJpRkQ3a2pJUnVlOVV1R2Q3?=
 =?utf-8?B?bCtVcHdHY1BpTXVUek5zWGJWRC9WMXh6ZUw0S01wb1oxeG5lWXJ0RUUzR0ln?=
 =?utf-8?B?VStiZktmN2k5b1V2dUxkcDU0SzFVL2Z6VTFZMDZCM25GTjFvYUw3azFjb0x1?=
 =?utf-8?B?U00rMXRrTEhMamxLNkxDNVBJb3NkWnhKUzZZZXMrTndVaTJOVVArU00xeHpC?=
 =?utf-8?B?QWV2My9PVFd6S09xb041N2E0dXNQWURUVnpRbnpvaTUwcUhWMk5Ub2tBaHc0?=
 =?utf-8?B?ek5UVE5aN2ovb0Z6ZE80eHdBS0NGd3pkN1Z0RlNYcm81dnpQTW9SWG1UdXlq?=
 =?utf-8?B?M09kL0NFZUlPS2FudUppZjBXSDRuWnprL0tiUkhGM1RVUC8ycmZFaURrSmFT?=
 =?utf-8?B?enVqU0R3WlFjYzhteGZ3K21jZHI5dU9senRxU1V2N3FFaXFuaHJPZzhybkl2?=
 =?utf-8?B?T0lscVhBRmhZZlJMcnBpNWlva2tyMGFlOTZWWTNIWnU4a05WVWtNQ2FGOVE3?=
 =?utf-8?B?NmhPRVA3SW9GSXRNdTBQL3JCUlYrUndRV1NCSmRlOE5zbkFnWVFIbzkrMXJz?=
 =?utf-8?B?WjVMUHBNMTZ5bjFKaXh6ZmJ1bVdvODMxVnArL1BHZjNlSSs4VXg3d2FhOXMw?=
 =?utf-8?B?MGRYOEQ5dTlTQWJtUk9kZDZvSE5EL2EzUHc3dERNdCt6RjNoSm1FNE5Obm83?=
 =?utf-8?B?cU5ybWRCQmZyYTVicjV4UXlwTWNrN1g1UUNZWVVFdjhyUUhBUzgrT1hZakZo?=
 =?utf-8?B?YkxJbTV6ZzdaUHE1OTlFTDhjVjNnSHA5b0Vlb1FmbzBHQUV3d0w2VWtuZXBI?=
 =?utf-8?B?WjNBellodDNHVVg1alhGSnBjNFdmdFplRWJMV1h2c0hic1poY054Q1ZvQ1hI?=
 =?utf-8?B?a21TTjFRcUovQ1FaMzl6NUhXemR6RU1jKy9jZWl3NG1OU053R242OE15UTNy?=
 =?utf-8?B?dm1pb2JZWFp1M3UvNzQrdlRtZ0lKWjllUk5Mc1BsZHQreEV1RUNhcVJvemtI?=
 =?utf-8?B?OXA4WUw5RytvdVdMNmJoOGdKazRmNzAwZlBYQkJ6NFpKYmEyYUJZZHlWZkI3?=
 =?utf-8?B?L0hZeDJRdTEreitiQ1UveXNZWVBRWldKbk1QaEJlRS9iSFdiMzJsMVlRMlNu?=
 =?utf-8?B?VWZveEptYnd1Smp5d3VnTm1vWGtiVG1aZTlEc3NGYWp0RmxRdFZGRHZxUlRY?=
 =?utf-8?B?MSt4T3FITkJ0MEFhT1NBS1Ywd1l0eUdob3lqb0FlWTFqRklBY3lFRHVybDFN?=
 =?utf-8?B?ci81aGdPSlp5cHNiUUdaNUR5M1FidkVDMjBRVFZyNVlWNmY3Q0NjOEY2dWhP?=
 =?utf-8?Q?oabyC1rqNcW6ucFiPIWZIgKV3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eed99987-69f1-4b5b-abe5-08dd3fe84ea3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 22:08:34.1834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2qAa9UtudV5vmuQbRqwHinlA3hTV8v9XP94aQibl3BxKxzwas/XOEzvdsDA9fsCcn0vhD5TglHrbTWl+qPChrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8555

Rename `cpu_addr` to `parent_bus_addr` in the DesignWare ATU configuration.
The ATU translates parent bus addresses to PCI addresses, which are often
the same as CPU addresses but can differ in systems where the bus fabric
translates addresses before passing them to the PCIe controller. This
renaming clarifies the purpose and avoids confusion.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v9 to v10
- new patch
---
 drivers/pci/controller/dwc/pcie-designware-ep.c   |  8 +++---
 drivers/pci/controller/dwc/pcie-designware-host.c | 12 ++++----
 drivers/pci/controller/dwc/pcie-designware.c      | 34 +++++++++++------------
 drivers/pci/controller/dwc/pcie-designware.h      |  2 +-
 4 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 8e07d432e74f2..80ac2f9e88eb5 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -128,7 +128,7 @@ static int dw_pcie_ep_write_header(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 }
 
 static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
-				  dma_addr_t cpu_addr, enum pci_barno bar,
+				  dma_addr_t parent_bus_addr, enum pci_barno bar,
 				  size_t size)
 {
 	int ret;
@@ -146,7 +146,7 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
 	}
 
 	ret = dw_pcie_prog_ep_inbound_atu(pci, func_no, free_win, type,
-					  cpu_addr, bar, size);
+					  parent_bus_addr, bar, size);
 	if (ret < 0) {
 		dev_err(pci->dev, "Failed to program IB window\n");
 		return ret;
@@ -181,7 +181,7 @@ static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep,
 		return ret;
 
 	set_bit(free_win, ep->ob_window_map);
-	ep->outbound_addr[free_win] = atu->cpu_addr;
+	ep->outbound_addr[free_win] = atu->parent_bus_addr;
 
 	return 0;
 }
@@ -333,7 +333,7 @@ static int dw_pcie_ep_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 
 	atu.func_no = func_no;
 	atu.type = PCIE_ATU_TYPE_MEM;
-	atu.cpu_addr = addr;
+	atu.parent_bus_addr = addr;
 	atu.pci_addr = pci_addr;
 	atu.size = size;
 	ret = dw_pcie_ep_outbound_atu(ep, &atu);
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index ae3fd2a5dbf85..1206b26bff3f2 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -616,7 +616,7 @@ static void __iomem *dw_pcie_other_conf_map_bus(struct pci_bus *bus,
 		type = PCIE_ATU_TYPE_CFG1;
 
 	atu.type = type;
-	atu.cpu_addr = pp->cfg0_base;
+	atu.parent_bus_addr = pp->cfg0_base;
 	atu.pci_addr = busdev;
 	atu.size = pp->cfg0_size;
 
@@ -641,7 +641,7 @@ static int dw_pcie_rd_other_conf(struct pci_bus *bus, unsigned int devfn,
 
 	if (pp->cfg0_io_shared) {
 		atu.type = PCIE_ATU_TYPE_IO;
-		atu.cpu_addr = pp->io_base;
+		atu.parent_bus_addr = pp->io_base;
 		atu.pci_addr = pp->io_bus_addr;
 		atu.size = pp->io_size;
 
@@ -667,7 +667,7 @@ static int dw_pcie_wr_other_conf(struct pci_bus *bus, unsigned int devfn,
 
 	if (pp->cfg0_io_shared) {
 		atu.type = PCIE_ATU_TYPE_IO;
-		atu.cpu_addr = pp->io_base;
+		atu.parent_bus_addr = pp->io_base;
 		atu.pci_addr = pp->io_bus_addr;
 		atu.size = pp->io_size;
 
@@ -736,7 +736,7 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 
 		atu.index = i;
 		atu.type = PCIE_ATU_TYPE_MEM;
-		atu.cpu_addr = entry->res->start;
+		atu.parent_bus_addr = entry->res->start;
 		atu.pci_addr = entry->res->start - entry->offset;
 
 		/* Adjust iATU size if MSG TLP region was allocated before */
@@ -758,7 +758,7 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 		if (pci->num_ob_windows > ++i) {
 			atu.index = i;
 			atu.type = PCIE_ATU_TYPE_IO;
-			atu.cpu_addr = pp->io_base;
+			atu.parent_bus_addr = pp->io_base;
 			atu.pci_addr = pp->io_bus_addr;
 			atu.size = pp->io_size;
 
@@ -902,7 +902,7 @@ static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
 	atu.size = resource_size(pci->pp.msg_res);
 	atu.index = pci->pp.msg_atu_index;
 
-	atu.cpu_addr = pci->pp.msg_res->start;
+	atu.parent_bus_addr = pci->pp.msg_res->start;
 
 	ret = dw_pcie_prog_outbound_atu(pci, &atu);
 	if (ret)
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 145e7f579072c..9d0a5f75effcc 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -470,25 +470,25 @@ static inline u32 dw_pcie_enable_ecrc(u32 val)
 int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
 			      const struct dw_pcie_ob_atu_cfg *atu)
 {
-	u64 cpu_addr = atu->cpu_addr;
+	u64 parent_bus_addr = atu->parent_bus_addr;
 	u32 retries, val;
 	u64 limit_addr;
 
 	if (pci->ops && pci->ops->cpu_addr_fixup)
-		cpu_addr = pci->ops->cpu_addr_fixup(pci, cpu_addr);
+		parent_bus_addr = pci->ops->cpu_addr_fixup(pci, parent_bus_addr);
 
-	limit_addr = cpu_addr + atu->size - 1;
+	limit_addr = parent_bus_addr + atu->size - 1;
 
-	if ((limit_addr & ~pci->region_limit) != (cpu_addr & ~pci->region_limit) ||
-	    !IS_ALIGNED(cpu_addr, pci->region_align) ||
+	if ((limit_addr & ~pci->region_limit) != (parent_bus_addr & ~pci->region_limit) ||
+	    !IS_ALIGNED(parent_bus_addr, pci->region_align) ||
 	    !IS_ALIGNED(atu->pci_addr, pci->region_align) || !atu->size) {
 		return -EINVAL;
 	}
 
 	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_LOWER_BASE,
-			      lower_32_bits(cpu_addr));
+			      lower_32_bits(parent_bus_addr));
 	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_UPPER_BASE,
-			      upper_32_bits(cpu_addr));
+			      upper_32_bits(parent_bus_addr));
 
 	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_LIMIT,
 			      lower_32_bits(limit_addr));
@@ -502,7 +502,7 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
 			      upper_32_bits(atu->pci_addr));
 
 	val = atu->type | atu->routing | PCIE_ATU_FUNC_NUM(atu->func_no);
-	if (upper_32_bits(limit_addr) > upper_32_bits(cpu_addr) &&
+	if (upper_32_bits(limit_addr) > upper_32_bits(parent_bus_addr) &&
 	    dw_pcie_ver_is_ge(pci, 460A))
 		val |= PCIE_ATU_INCREASE_REGION_SIZE;
 	if (dw_pcie_ver_is(pci, 490A))
@@ -545,13 +545,13 @@ static inline void dw_pcie_writel_atu_ib(struct dw_pcie *pci, u32 index, u32 reg
 }
 
 int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int type,
-			     u64 cpu_addr, u64 pci_addr, u64 size)
+			     u64 parent_bus_addr, u64 pci_addr, u64 size)
 {
 	u64 limit_addr = pci_addr + size - 1;
 	u32 retries, val;
 
 	if ((limit_addr & ~pci->region_limit) != (pci_addr & ~pci->region_limit) ||
-	    !IS_ALIGNED(cpu_addr, pci->region_align) ||
+	    !IS_ALIGNED(parent_bus_addr, pci->region_align) ||
 	    !IS_ALIGNED(pci_addr, pci->region_align) || !size) {
 		return -EINVAL;
 	}
@@ -568,9 +568,9 @@ int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int type,
 				      upper_32_bits(limit_addr));
 
 	dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_LOWER_TARGET,
-			      lower_32_bits(cpu_addr));
+			      lower_32_bits(parent_bus_addr));
 	dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_UPPER_TARGET,
-			      upper_32_bits(cpu_addr));
+			      upper_32_bits(parent_bus_addr));
 
 	val = type;
 	if (upper_32_bits(limit_addr) > upper_32_bits(pci_addr) &&
@@ -597,18 +597,18 @@ int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int type,
 }
 
 int dw_pcie_prog_ep_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
-				int type, u64 cpu_addr, u8 bar, size_t size)
+				int type, u64 parent_bus_addr, u8 bar, size_t size)
 {
 	u32 retries, val;
 
-	if (!IS_ALIGNED(cpu_addr, pci->region_align) ||
-	    !IS_ALIGNED(cpu_addr, size))
+	if (!IS_ALIGNED(parent_bus_addr, pci->region_align) ||
+	    !IS_ALIGNED(parent_bus_addr, size))
 		return -EINVAL;
 
 	dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_LOWER_TARGET,
-			      lower_32_bits(cpu_addr));
+			      lower_32_bits(parent_bus_addr));
 	dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_UPPER_TARGET,
-			      upper_32_bits(cpu_addr));
+			      upper_32_bits(parent_bus_addr));
 
 	dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_REGION_CTRL1, type |
 			      PCIE_ATU_FUNC_NUM(func_no));
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 501d9ddfea163..ac23604c829f4 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -343,7 +343,7 @@ struct dw_pcie_ob_atu_cfg {
 	u8 func_no;
 	u8 code;
 	u8 routing;
-	u64 cpu_addr;
+	u64 parent_bus_addr;
 	u64 pci_addr;
 	u64 size;
 };

-- 
2.34.1


