Return-Path: <linux-pci+bounces-14000-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5649957E6
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2024 21:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F93A1F26067
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2024 19:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BCF213EF3;
	Tue,  8 Oct 2024 19:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="W8q8Np/b"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011055.outbound.protection.outlook.com [52.101.70.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A93A213EEE;
	Tue,  8 Oct 2024 19:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728417270; cv=fail; b=DxCfsAS0S3TijUgrZGMOn8by9AYat7HViLDaHiHpC+t0P/KtILx97rZjkZr6l4ZV+SPBT1dQQLf0smvrEHKqy9IC4FDUocpyV4bCf/T80VpOPzJKw4FOI97JIBaNNP+2jD2dbagM5huYIzZ96CesUSMHnadovTYOyQivUj9fKDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728417270; c=relaxed/simple;
	bh=HO3RF+f1eP8myCyS6q1TjWPk2I7D1R5GldyB/e+ttPg=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=twTS31nmE3vAW+hfeGilLwgUkdTxN3FCvFstCaHjL25MHOS0Vb0jxl4KK/GNEDyAkjnwC9m6bcuTNYs1mGyBGgPXv+UxImZ8tz63sHp/WcyE6+mfVwETdSCwDcpydGul3R68ut7CDM0oAHIxXC9snx2SicsGJNURCmd0VAhjcns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=W8q8Np/b; arc=fail smtp.client-ip=52.101.70.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tAiq2G9utsKPqOgzBdL3TMhtrCvjwC76oPfbGxAPVVigmuLT8QLLROHNlfvXWeq0FHyUb773VDgrEKvnt4nhA9oXDGfg4nD78xiKLU6IjxQcDR/5oh62CpwZ3bs6FjHYRTLnlilHW3UNLTNY1pNLYRkdEGJ/ylvwAuFZ9nsSb8+Eye8Myz6obMFJgGJmxv2UdNH3lqeMI4XAijmdljBZ/aSsFILfagZWZL6C1FeK4xnZxTlKvdCcFnpFIBCgw4GrB+4917KS4qab8ZnZ9VOojXVggD+R3nsfsmLcQYRXBPK+uXY94dKxXeGvltWiIem3JCrwPByn1L0xUzLfLHtSEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NQ/vBBc27kEks902DM6ab+mHUnmP7cGQAewthgz7UTY=;
 b=c6EzRigi4sc6nLgDepWdvSxDZTVXT444tf1YMNbg53yelySMdALNMAud1GbPuO05emAPzXPdtuP2eZMb/5pLeG25y4+yBBrJC+0B6v+X5DddnTqooaoHI0FwVaJUTOiBdha2NdgMNC4og/DQfnK5FWqraSlcNI0m63YtpAhckLjJpn3Zhiyn1UfmTvfgLWq3oNf2IMii+pKk8DozfYhGkKV2q5k7Lx3khjR++YUoU9xENZ/ub/cC79lfBMW5T760BCcWj+Av/Zs9865pYO31h2JKiWJVcgGaFDlJJBLP4lRzt3/8vZpd7xEGOGYG9vaJBT9e1JtJn9LTPtJl8TPiNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQ/vBBc27kEks902DM6ab+mHUnmP7cGQAewthgz7UTY=;
 b=W8q8Np/bNhWXue9KNSCjsjOZysHaJMnDkN/svb5C3/X+dMpdek26OYQd+xjdIdT015ucA+u07rc2ezdUsxCzfC0Aklc/jFT5lbUFqVI457PdX4Tlz4ST4+N76c9X5kvCVMTaDTQfgGmXBgX17haLEriHCLyv+BKXUDLmmEntdbpo8eXQw3FDldplaHzK8KD7qxBoMtS/j72jCPpxBzT/SGpKRLxDOYX6Sq/KKZzvuQufqhpE7QmpHYRXULig3cACrZontoJw1iAeO+qYmd79Nr7n/whE/ccyuipe5ISJtBIfjFhbRlXPuoGOzQvhX9RkmFHTmMdRYuOYwavJLRHrAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by PA1PR04MB10577.eurprd04.prod.outlook.com (2603:10a6:102:493::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Tue, 8 Oct
 2024 19:54:24 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%3]) with mapi id 15.20.8026.019; Tue, 8 Oct 2024
 19:54:24 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v4 0/3] PCI: dwc: opitimaze RC host pci_fixup_addr()
Date: Tue, 08 Oct 2024 15:53:57 -0400
Message-Id: <20241008-pci_fixup_addr-v4-0-25e5200657bc@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANWNBWcC/3XMyw6CMBCF4VcxXVvTy5SLK9/DGFLaqXQhkKINh
 vDuFjZiiMszk++fyIDB40DOh4kEjH7wXZsGHA/ENLq9I/U2bSKYAFYKoL3xlfPjq6+0tYHqQmW
 FK+u6lkAS6gOm7xq83tJu/PDswnvtR75c/6Yip4yq3HLQJUcD7tKO/cl0D7KEotjibIdFwghKg
 AKO1sEvlhss2Q7LhAuGmDOphDP5F8/z/AFRpHvBJAEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728417259; l=4665;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=HO3RF+f1eP8myCyS6q1TjWPk2I7D1R5GldyB/e+ttPg=;
 b=G4vFqdq8y7fJtg1OZDTXkcv6y0idRjaE5Pgkge0AJnx6IUBRXudORnBPNhw1jlmrfUMQm49x0
 eJfofFCWywkA6lk8RUNOPfhcjTOVwuqF9QQ7vplkATQAlSxRRYdHCBW
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0195.namprd05.prod.outlook.com
 (2603:10b6:a03:330::20) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|PA1PR04MB10577:EE_
X-MS-Office365-Filtering-Correlation-Id: 354cefd0-7d32-4635-46bf-08dce7d301df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|7416014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bTJra0h6WjZhdy9kNGw2Y21nSWZQazA0cXdySE10U1lZVmw0T1JsL3k4Nk54?=
 =?utf-8?B?U2V2R2dTR2pYWmhGcGIxc2hZTnZ2bUo1cXVSL3l4cFQzbTBURVN6V3k0TUdX?=
 =?utf-8?B?NUxuWE5vWU4ya3dzYy9ldWhhYjNqNmRaSE9maE82YTYvQnRjTlJ3YzBJRlc1?=
 =?utf-8?B?allhMFpwU0RPbko4Qlc5djFqNGhDSEU3RitKTHJYUjd5bVBxREs1S2toQWVy?=
 =?utf-8?B?MlRtcExMT2FrRXRBMmhRZGFtRHRERzNieDd0aCs0ZTFyclFzSnFmdHYzdklx?=
 =?utf-8?B?M1QycnlpMU15R1dXRXhXMnVWdjlXUlNmL3kvZEZPaVd0QkROTjcvRTZUQlBD?=
 =?utf-8?B?Mk94TFJCMnFqaHpHYzRwMUxVMms3MXozeFR4ZzU2S0ZlWkFjY0FZVmVKWlUy?=
 =?utf-8?B?b3JDVE5BaXZGbW1JcHUyamc0NnJWcGRDM1N0cmZwMHdiSWtHQlFaWXU0WXR3?=
 =?utf-8?B?MnlnUkEyTUJjVHk2a0U3ZDdxUjh3NGtBQlowV3ZRU0xzUitrR0M4cXNuclpq?=
 =?utf-8?B?R2xOZTVsSzREWWhYQzVOU0RwZjFaaUF1N1AvaWhTamdnRzJRcEc2SEVLSGIw?=
 =?utf-8?B?bTJaczMydGU4U0pRbzlySmNvTW8wZzE3TFd4TVhsYUZTbVcwTHdXNW1qYTZB?=
 =?utf-8?B?UDdqbzJaWFBvT0VERkF6aGRnb1R2bTNzQzR1cWlJOVpsSXBFUWRBRklsSUt4?=
 =?utf-8?B?RlhuTVowcnNld3g1L296a0lWZEtrNm1jbHc1K0FZWlNsMkJ5SEdEellqc0hY?=
 =?utf-8?B?d0pYTHNFZUY2M1pXZkxPVFdnYzFCVWF5NXZRR0gvbU44ZXI1cEhqeGJZb2hC?=
 =?utf-8?B?MGRDV2VtM3ZBYlJXaHRwUGlVNVBKeGozU2N3b2hNUytjZVNTaXBoNmphcGkr?=
 =?utf-8?B?aEsyZjVNUUZKRWRmR0VINjhIVHZMOHE1YjAzc0RrbThPTi9xTmxxcWoyMmRM?=
 =?utf-8?B?T2Y4aXEzS1RhQzcvakcrdm0yVC9Jd0lHVFk5STVTRWRzdzg4Mi9mVkhWYU1R?=
 =?utf-8?B?MmMwRjZ2YTZBQmdTS1l5My83RFhJSVhnaE5yNWxtL051aDYxVnNRemtONUsw?=
 =?utf-8?B?RDVCbktjZmZQUnA5TWs2VTk0alZtc1pHbnZGQUxWOTF1MHVGSUJiV1lQclJs?=
 =?utf-8?B?V2JRNjY3ajh2dElwNlh2NFY0bGkvc21oYmZGNGtHd24rUHdPQmxtZmpiS1NH?=
 =?utf-8?B?M3ltOFJqSlc5OWZRSFpnMkNzYU43Snp2eHowR2hWQmpKM21rVkRaY2I3ek10?=
 =?utf-8?B?eU1WR3BMZ25kZ2tMVldOcDdsdnpDTnVYK2VucXBiZU1YRmtJMzl5ZVVLbmlP?=
 =?utf-8?B?NHRVNHFnejdvK3NXa0hsbnoxM2Y0L1hQNlpEeHI3OUZoR0FtU2tlbmhiUTlT?=
 =?utf-8?B?Nm9UdHNLUFN3Q3grMlRhZDVKcU05SWUrcjdtckdiR3duLytUeG5JN3BLU21O?=
 =?utf-8?B?ZzJENGVCVTgrWmd1bnZhVG1QT2UzUldSZlFtRUU5UlNnQjQzdWdmSFdjOGtq?=
 =?utf-8?B?NVhnR2Y2bGNHcmYzQ25FclBqaU96THk0b0RwL3pVejJ3YzJlT2hMeFlYS25X?=
 =?utf-8?B?U3RBc25IMkVkenFpTklZdUFRbEhzYVBYdjAvdmdUd3dpVWhhVkp4NTBmL1FX?=
 =?utf-8?B?cUk4b3ZVK1AwcXo2bUxBRE1OY240engxU1hxOVZlR2diOHppcEhHT3dvWk16?=
 =?utf-8?B?ZTl0ZlpZUHFUU21tM3V2dEtJaUlsZmk3TDRKb0VFaU5tYVlScDQyNUhEUjBh?=
 =?utf-8?B?eHp5ZjU1UTQwMTVOM1BldEc5S3V3N2NEV1ZkR25LaFhoUXRKT2M5UGhjVWtU?=
 =?utf-8?Q?xshfECaApBVKv6GeJPCiGR8NsNbEF0sTdbd3A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0xEWXVQSm4rZWdFVUhKdVFLUFBHRUFFOTJmdVpuN01CT2RzUkwxUmM5Nm5J?=
 =?utf-8?B?SC8rVUdjR1QrMUZXeTBseDUvakF6S0crTURMWWJmbWhqOEQzSGhmNXNWbGUr?=
 =?utf-8?B?RzJ2SjY1WkdmdXJQRXN2RnhRaFI2Y2pPYlZzQVVocW0zWWxIdTgvMlREVWpx?=
 =?utf-8?B?a0Fjb2ZoTWppN3RGeWVjSVhmT0pvOGY3MFBMcmQzS0NPMnpGa3RHeVRadWZ3?=
 =?utf-8?B?Nko1KzVmTXAxZDlWcnprYkFxS25VazhxWmhuUmlvcFExc05xaEdjdzg2eDZt?=
 =?utf-8?B?T04zTTNmQ2J3cU5vVDNQSzh6dnpNTXZsd2xGNUhoaVNkN0RjU1VyN2s5RjZN?=
 =?utf-8?B?MTJtbzJBVStDQ0d5cEJPaUtTQjA2M0w4VWJWakh6RlJDNEYraWFJQUdMNkU2?=
 =?utf-8?B?OHo2MGJvUnlBcmRHZUFSMVMzd1ZsbmV6RHFCRFNjb3FxU3l3TmdhQ2FZM0lz?=
 =?utf-8?B?SkZveGV0Wi9lUDVQeGgrQUJENkZ2QVFBOXNiV2NMREdraTJubFB0Z1NhYU1T?=
 =?utf-8?B?dStTaHNjd1lxV0drbWV6ZTl5bGtXNnRlL3ZMVSt1cFZ6VzRGaFhya29XRnYv?=
 =?utf-8?B?NHVIVjVnUVpsK0pCUzBRWlNXZFdCM21YWjM4TUFJRFhWeGRWa3Y4T2dNeWhJ?=
 =?utf-8?B?b25UQ1dCSVE1UWpqZG56blNubkVlK0Z6MGFoK05uSU91cXFRYVdLYzZlemVH?=
 =?utf-8?B?UUZhb0VxRmRmeU5RUlA2UDNtUUtOM25XTm9vWUNmQURSclhqL3ZwUW13ZXdW?=
 =?utf-8?B?NXVPZGdBS2I3MXlwbUVDQldPVGQ0eXpZcFI3bnFlQkVoaVl1R0JPNG44MzJU?=
 =?utf-8?B?ZkYxQW1EYjRhcHFJdStTOGQ4dU1NbnNNblN6NmkzRjR3YUk3NjNKYnhzQ2Y4?=
 =?utf-8?B?MXE5bnBLcCthVE45bUpteWNxRUlzdlBVWlcrdU5OTXNJWjFqbkVHVFFtSHlL?=
 =?utf-8?B?eElWYmpQSEI0dmwwN213cUIzSkozalc2VmtLMVVBSEwreG96a212TzBGOEVu?=
 =?utf-8?B?VVU3V213NFBzMmd3eXRDYjlpQkU2d09uYTJZL0d6NmNyNFBybXl6MnFJVTlp?=
 =?utf-8?B?Z1VFdW9lRmNuSFhJeHYvZlBWd0hURTFZRTJaSmFqVklCcTJkQzVCZXNYK3Fv?=
 =?utf-8?B?MHNxSGdmN0pEZ0JGaHozZEtRRE00emxwdFN1Z3p5UnI0aFo0OHI3S0xLZHBx?=
 =?utf-8?B?dld5OTZqekRSMUYwMi9lZkFZN0lPOTZqVHdlWWRvL0tZYXVidmphVFAwKzg1?=
 =?utf-8?B?ZkNrTmxpSWl3a2VsanpMamRzN1BnbGVsa0NnNXZEaGt6TUxwZWR1dmZiVENZ?=
 =?utf-8?B?YjVFb3AzLzZpaGIrMnlqdDA2UUI1cHJKQjI4aXJycXFhUzNuSlFjSk84eHY3?=
 =?utf-8?B?NWphUTJublY1R0JzWGViZlFHWFhIQzlGc3gxcG9jR2p6RHRkOUtla3VrN2tW?=
 =?utf-8?B?ZlZJdTQ2aitNM3pLelVHVEp2TmYwZXcwbzhWNG5NdjQ4UlQ0WUorNWpDVEI5?=
 =?utf-8?B?bVFVRGxjUXBDMTNGVFhJZVhaYzZ3am4wVEZEV2VWNWd0QlhwVkRqbXdvZW1h?=
 =?utf-8?B?TmFYNUlRdnZqNG9GbkkvZG1tQ0xpZW8yQ0xlQW9OSVhQOHJSWU43UTZiTVVq?=
 =?utf-8?B?QWtpc2dsNndxOVVIeE9nOWYzdGFPNnd3ZHRCTEFqaUlxa3JWWVJmUTVua3A2?=
 =?utf-8?B?L0FycW0rSnBWTEZUUjM4SkVac1prbUR5QXYrVFQ4aHM0NUlXKzBURFRvaGJl?=
 =?utf-8?B?NHJ0emVGZDc3c3VlcXBlYzRWTEYyZmo0RUl2YkRlRHQwL251aXdTdnpLczZM?=
 =?utf-8?B?eEhtWCtCaWZkUzB4YmYwUTRhYkN5K1VEUmxmVjFYaXlWbnVsR0tvNVpGSkZj?=
 =?utf-8?B?M2Z6bUNpMGNJM3ZUY0ttWjAxV3FkUVhxWEozbGoxb21kcFdjTzM2KzZyT3JQ?=
 =?utf-8?B?L2tpYUNoUXdkWDh1QkV4NXRxZlpSeHBEdVJlZ1FTbjBzbHJON21uaDFzU3Fn?=
 =?utf-8?B?bWIvNGVPcWcrM3VReGRRZzM2ZnBCQjJydkhYZVN5TzR2Zlp5eStsY3BvL0NL?=
 =?utf-8?B?TisvMlV5N2VnUkVlS2owTXNMdUJ5R0VyUzVkRitBOGVRZC8yaE9vQjk0ZVdR?=
 =?utf-8?Q?o1OucvCQFdMFTMs7fGRwcDcKp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 354cefd0-7d32-4635-46bf-08dce7d301df
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 19:54:23.9643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OXlrbN4NYGEGTAtPzdBMllmSiMH/fNfWKH/bssceXF8VE1salyBvujeMEpH97fDttSDl+UZPAx9uu+5Qcg0FaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10577

┌─────────┐                    ┌────────────┐
 ┌─────┐    │         │ IA: 0x8ff0_0000    │            │
 │ CPU ├───►│   ┌────►├─────────────────┐  │ PCI        │
 └─────┘    │   │     │ IA: 0x8ff8_0000 │  │            │
  CPU Addr  │   │  ┌─►├─────────────┐   │  │ Controller │
0x7ff0_0000─┼───┘  │  │             │   │  │            │
            │      │  │             │   │  │            │   PCI Addr
0x7ff8_0000─┼──────┘  │             │   └──► CfgSpace  ─┼────────────►
            │         │             │      │            │    0
0x7000_0000─┼────────►├─────────┐   │      │            │
            └─────────┘         │   └──────► IOSpace   ─┼────────────►
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
            ranges = <0x5f000000 0x0 0x5f000000 0x21000000>,
                     <0x80000000 0x0 0x70000000 0x10000000>;

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
base-commit: 69940764dc1c429010d37cded159fadf1347d318
change-id: 20240924-pci_fixup_addr-a8568f9bbb34

Best regards,
---
Frank Li <Frank.Li@nxp.com>


