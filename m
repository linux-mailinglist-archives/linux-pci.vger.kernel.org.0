Return-Path: <linux-pci+bounces-20511-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0FCA213F7
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 23:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1311167CA1
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 22:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D791F63EF;
	Tue, 28 Jan 2025 22:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Axiskoeq"
X-Original-To: linux-pci@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013029.outbound.protection.outlook.com [40.107.159.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461DA1F63E3;
	Tue, 28 Jan 2025 22:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738102142; cv=fail; b=XjcxA8j61fXKfX09Z9+i/Es+1vwwboX+pwRWr6PGAbz8jwl7g1H4DQcvqBQnKW5Q56cRYiX//jSOFpXT4e6zjgLMVQE0dh0/WhMXg1q1mJy5HKbaXKWEE+Csc3qmFudMHMGblxUHmqYTc0zJdNHhp4OyzNXJNfm8hC0ViNQ7O+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738102142; c=relaxed/simple;
	bh=82i+ZNN//yWfCS+EdpjUgo+KbP9Mi5MxOEllPA4oVrY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=iP02qOamBNQpxv5Ys0CyPzWIr19r28nHK6gCVi6oH8EDxh2aR9o29EvLKgBjVxwz+8HABojWcMUoZB1ScuPyPUs3ekQusLGeg8ffHubhKV6ixgkSxvhOShj47GSopE5O3tKGDvGHfEVbXQQS81rCsKP13cM7zaOnhrhM7YhFnDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Axiskoeq; arc=fail smtp.client-ip=40.107.159.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aMpqn7BkZcTE21npsfJVTqSfsmr+iohkzsgxiF7Z2FVCHzvplczElqEiAOYTsO+3Y91TwcDtVsPG1fCqgxQvACc0TL8Ld2IJ/4r/E+2VjrTlxmOhe+ZQt1x49ItNWpqjHENqWbTSu+un250UEraAdy+2QhBIViio6hyYL73mMg52Bn6jzxwkPDWQWLVeJRxkfKGhCZjkT4OpUJssocy6eDptAifJCetFBV4OeBzEisgnTpOBlkeYi6uK7Fh3MScj9Pb/JvgXePY2v9qnFgs6HmuFQzT+Xfj8HbvzE+7i8c2JkAF3a1n8mSTJDskft3aZiwWKaa44vwTChvyguhYG1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wJxChZP0aR0iCOpx4zJhPrHwj+xKeWc1Pssf1AAz6bQ=;
 b=AQ13e9UEqHhfdm2wHNiWle+wL1YlnnUV4X5xgaVugPMchGnunnOX1zWJ2PigRomgwSPNPD9ygghAqhsuUXAkw7coDsrRbLxDBmIfavCJfDDmG9IIh/JuTqzslFR7FVskuwGf40SAdzgVGgTJ3E5QLJ6m8c83JnnUQ6vg9UZdY6SIe+koN2jk0ItWecMpDtkBXc2lGgKyAY7Mx80udn4giL0pvSRjbAPB+I8mEFLl8BCl+jlkNNRpWm+FypxKj/FYcxc4jspB5jvU/vVxrydwBl0xP/A1FlIaYuww8I2RUvylbfkZnLXR1M943SJNAWvDY5KFgfNliWmrAy4recb1oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJxChZP0aR0iCOpx4zJhPrHwj+xKeWc1Pssf1AAz6bQ=;
 b=AxiskoeqDB97aktKh6nD3CJ4FlxjCwoc6VvgzSPnwKIsQbydcWE9z+XJA44tzk1BFUyHiUuzLSKbKnFMKm1Yg+otaG+evIJiMdIEKQuUSnB7T9H6O4ysAOci5ciDtUdg9hqp4NRT82pldMay3HSmCB1T6JtZBdZ6QUHTVQimkuxV/LcU+mrNwgpKVvvcmnJ/QyPsoHM9ugd7qzDkAq6r2CEeZLbwMrAhOp0JL/jTjw6uKdTSvsKRW0rZ/UGB6sxUS6tBjhBJ6AXftQfgN2OTJgrxW+KAga/+Ev5knn0wGTQU2iIJMv8a22D2ZEb3zBvgNbxk1Ou5xK82TOR0c1crGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8555.eurprd04.prod.outlook.com (2603:10a6:20b:436::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Tue, 28 Jan
 2025 22:08:58 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8377.021; Tue, 28 Jan 2025
 22:08:58 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 28 Jan 2025 17:07:40 -0500
Subject: [PATCH v9 7/7] PCI: imx6: Remove cpu_addr_fixup()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-pci_fixup_addr-v9-7-3c4bb506f665@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738102099; l=2187;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=82i+ZNN//yWfCS+EdpjUgo+KbP9Mi5MxOEllPA4oVrY=;
 b=jKJZ1FU69RghE7E2Y6Mg+P7Z+iK7AD42u2G9MBdt+1uL9MlogqwTnSfIaN0OhtJtZ+XLNgYdk
 eU1OWZGSxQ8B69FI0yYwhxT+y4v0+rvQjnMqSY3Xcg3mibWPpph1lcL
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
X-MS-Office365-Filtering-Correlation-Id: de8aa5f3-d534-488f-0cf2-08dd3fe85cd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b1pJcnRQTmpHK2g4U2FzMVRLOVRkUXZFLzBUWTJibTdTUFN3a3pJdmh0a1Bj?=
 =?utf-8?B?WjRlcWtWc3kvZ3lDMGdtMXZyZlRvOVBwc0F4ZTZkdDRqS09ISE5ncHVrZHA3?=
 =?utf-8?B?Uko5SzNYYm5FeGppdElpd0pLeTNVZkFQSVp6TTNMZk11ZmhKOTJMQUY4UkVE?=
 =?utf-8?B?TTkxSk91a1BpMk40SlFEZUg0a0xOczNJKzF3VTJubVlCdzc2OXdiSWl5VVg3?=
 =?utf-8?B?U1NrMHVMMVRKVDVXNG84dm5zZE82bTBTeHQwWnE3eldzV1RoblQ4RTBEclRv?=
 =?utf-8?B?c3FxUzlkQVZ5dTdER0JqZ1Ixd2Z5YXpzRzlwamxzV1M0TkhLYVZFRkdMUG9B?=
 =?utf-8?B?Q1pPY1dyV0FtWGpkdHU0cmpNc0VGZ1VSUmZPcWRnYXF6MFNrRnREck5MODhW?=
 =?utf-8?B?ajJvdTBoMWVuY2piU0pCcmd5NENVUEF0dXRNeisrcTNsanVMRG1TZWFpN0Ry?=
 =?utf-8?B?M1lVSDdEWGdKOWk0Q3o2RXQwUU1iYkxJTlFFUmhmd1lnMnlrckVPT1FYdEhl?=
 =?utf-8?B?R0gxd04xbDNpZjJlUXdzNHlzV2Vrc2RnK3dBamgvMzJXa0ZmT1luazVqSXFi?=
 =?utf-8?B?YW53U2picWJPb08zM1pKUWlHNVJyckV5OExrVUpWalh4L1h2cXBlL3MyR0JW?=
 =?utf-8?B?K0xpblZCNmt3WkFhMEhDUndLL29oL2EyMEVuNGlwU0tnRlU5dHRkVnR6MVla?=
 =?utf-8?B?Qk1GR2dsZUQvVzZjS2pGU29JZEg5STBZWWQ0ZEUrZjdKa2VFMVZIdVh5N1J2?=
 =?utf-8?B?YVhMamxaVjlHTXlUQmc2YVROeVFvQm90cTBmM1FCZHgwZlk5KzErd3FsOFpj?=
 =?utf-8?B?d3FGSWo2dG5jVEV6cE5SZVZjeXZOWk5SRTZ2ZXN3S3JqbGpUZmJjY3RJV3RR?=
 =?utf-8?B?QUxMKy8vNzUwOG1vOW1DUE02cjhMcVFQd0txZERacHFzbEg0UHNJZUNGYjJO?=
 =?utf-8?B?NWp5TVhDSzEybS9TQTJEdFZyaFF0dzJSMmpsUlJBdE1UTnFvS21lNXFnT2Jr?=
 =?utf-8?B?aHpyQ0RZUkRGb2FzdHgzRXhLSjczYU92Tm9lTHRHNzdzSEVMODJyakV1OGZF?=
 =?utf-8?B?V3ZjQ1Y3YVhCWHg3UHJZQlM2TzJ6dW5CT2ZMZkVCckRzUkMyOEtnWmpTMGtQ?=
 =?utf-8?B?aFQ0SnIyU2lRc1ducjNFaHNGM3AwWUtJdTBpay8yM21DUHlQWnQ3N2FVQlE2?=
 =?utf-8?B?bzQzSmcxUFE4bjY0ZXo5ZTdSUnlKK1hxVXlncW5Hc09pS3h1V3daN3JwSTdI?=
 =?utf-8?B?am93Vm15aWJSWUxKdG5jVjIxZkNucFZZazluUVlhSHhvUlluSmpKN01ZWWYy?=
 =?utf-8?B?Y1RlaFNrb3VIaDIzRDVyZHJMb0d6QkVkL3cwNGpNOG5vczd3T0s4bUlUcHFN?=
 =?utf-8?B?RXdkZWJVbWRWQmVRZW9lSzVhOXl4UGl3dEpvRnRtMXY0dHlzNzhSd2JzdGcw?=
 =?utf-8?B?THNPUXdES2VMZDFrbVJ1K0ZlZmE5WHhVTlNlTXhlZk83SU9wLzlMdGE1Yisr?=
 =?utf-8?B?eGRSZ2tzeHZjczArTSt5TW5abmxSeUgvODlyLytJMmN6bHhmbXAxWGhkNnZm?=
 =?utf-8?B?UU9vTFBsZEN4MWlHVUVnWFhPUUVMc3ZxKzJGbzE2RW9RMU9wSlo4Ymo1U2tY?=
 =?utf-8?B?b2RLa2YrVTcvYVRSQmV6aTNTYTBCVnMrc0RlaVM5a1JYV1h3VU0wMzZXeGd4?=
 =?utf-8?B?d3RyMDcxVUYzZnRQWDRTR1NaT3VUakszalY2TjZJSWhXMnRHamJlZXR1ZUtS?=
 =?utf-8?B?MFhDc0M1aGtzWXpQY2lSZ3dkaHBmaHR6T0hURDV2dHA2Uk9GeUJzVm9FM0h2?=
 =?utf-8?B?aEIrSjRJUi80UGdsb0pncEFUTVptZElHRTdoaTZvRStNRUZHOGtKWGJJWnBV?=
 =?utf-8?B?OVpjb3RJYmRvN20wUHdJZVVzcUxTQ1YvUC9FM1MwOEJYMjNqeEJTdmw4bExx?=
 =?utf-8?Q?wqucxZc4DNR3nDubsa1yrY8j6QESEybZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UzZYZmp3UHBKRzlMcm5HbUZ5UENtZER0YUNQZ1M4QzhhSldZeUxBSkhYNS8x?=
 =?utf-8?B?d3hFZThwdmVzU1Q4bFhQUEd3b3JCZjZqSDlndnlRd3ZuMzFGaHZwaHlYcktJ?=
 =?utf-8?B?c2JSRXBySXZXMGtlTjlOSnVJYmlXVEl1RDdDNG54RVg2a1grV29zYmpqWEJG?=
 =?utf-8?B?enJ4eDl5enJrYXFualY0NWt2SllUb0VLRUZyR1A4b212NkUyZVhjWE5OMnhZ?=
 =?utf-8?B?ZFBNelJrdDVDdTR3Z0lCaWZUZ3dSTEZ4cHo1ZGxFbEs0cFdXSW00UG90aXdx?=
 =?utf-8?B?MHJnVVdaNko1YzBUT0ppTEhSZTRrVHpMT1BNUlRoOFFCYnYydHJ4cTV0U0NH?=
 =?utf-8?B?UmRMd295RFJ0b1BYaXU5UzdYTXh4TEtqSGhySWtnR0FKRUNZbHI4Z2FycXhH?=
 =?utf-8?B?Qk5ZSHNwZEtWT0hHdzh5czJaNE9OTFdhNDVxYkhQOHlkZlc0Ri9Kb2J5R2dH?=
 =?utf-8?B?THdaVkI0TS9UeGg3aFFyMC9JckFHSVU0ZXJTeERRZmUvRTZINDlISDBXQXBB?=
 =?utf-8?B?TysvaVJPSlk3c2hWQStwN1h4SXZ0YmR6RXBpaVpDQ0tYa0FCT1BIL0FyVm5Q?=
 =?utf-8?B?VDR2SkF4Q0wvdU56TjVva3h2ZkZUL0VlWUNuemNTSW53ZXE3eWdxK1Q0WU9L?=
 =?utf-8?B?SlU4R2Mvd3FFc1VpUFJBTXBHRDI5alBFMFdWUmV4RlhDbDRUd2I0OWpIaWg5?=
 =?utf-8?B?cGo3ZEs1V1BlNnA5SWxjcWNvV3NaRzBialcxZzNCQkpNVXdzNkg5VWUra0dB?=
 =?utf-8?B?UGVTSmllc0d6U3FJR09IRUxudy9VS1F0am9DMnBWNVI2R21lTitzTEtsQ2M0?=
 =?utf-8?B?Mm5oZWtJbDcyeXlMNW5SZ0FqK0ZOS3plV1RUTFZTbWM4a09YUjIzR2F5bEVy?=
 =?utf-8?B?djZFZWZuWHZud3FwYjJRU3hWY2hVUGhENXY3VCtRaURFaDJhWU51RGlmcm0z?=
 =?utf-8?B?UTJSSE04M3IxRWpjdWxGbmRFM3BzckZYY0tPSGhLVVFGQjA4dzRtdlVSbjBV?=
 =?utf-8?B?aDROem9qTnBNYjhlQlVQRVZrQVhJZkp1ajBxbEtBQUc1cHQzTmtOVVpHM2p2?=
 =?utf-8?B?Q3VrZng4VGxsWDVCVnI4b0l2QzZSVGxVY28zVFRZS3pUbXo3WVVLNFE4a2Jl?=
 =?utf-8?B?Vk55SXREbmpSWGY0SkV0U29sUW8zSlIvMTY0cmY0VzZQTzJnZWtMK2NzTDZu?=
 =?utf-8?B?c0tFSVlVOWNyR2lmdDdCZ3JGc21XSXFlR1lyMytFTHZ5ckdZUmltNTNrUEhs?=
 =?utf-8?B?MFdTcEw1dUVlRCtqN1BLOEFYOVV6dXpHR0xhdmQ2Y2NNRVE4OUE0UVE4bGkw?=
 =?utf-8?B?bHBIRitXNitSdzZLcENxQ3c5Tk80M3k5ZFRsTnpXeVd1S1B4cEJIYWovVFk0?=
 =?utf-8?B?eEpEMVl4NGlURjh1aGljaE1QcWFGYUtLVjN2VjNYK3IwR2xnUDRvNXJzMktp?=
 =?utf-8?B?SEUxaW5LR1lORDV4Z2p1SXgyS2hFZVJmUjdsN2JxWXUwYm04bmkwWWloZHNs?=
 =?utf-8?B?VFBwUHNPTjJESVpJeHd1NnVpMUpDWjhWUWtNZ2c2T0N3QUVLVjF5UmdMZG9t?=
 =?utf-8?B?K2E4UGJ1Vkx4Q1NyNlhtdUVuRnNVSE1mbW9kTU1HZ01KUjN4YWZvVUhGbWpE?=
 =?utf-8?B?bzl0K1dIaUVjU28ra2hqUVJCWEpSMzkzZk15OGFLdThTaU5XRUNnLzVpejJm?=
 =?utf-8?B?U1JHSU9VL3hNL001UVV2UFJjREZxZm1zdWJyMkF3dXB6dWF2V0VBUGRRVktp?=
 =?utf-8?B?Zy9VaE5QVXlMekJIWmZVTEdwaWkvcXNpUzkzR29SNm4xR2kxd2MvYkRTWDZy?=
 =?utf-8?B?cVJnRzFqQ1kvYmRRNjNRWGMvYXpEMUMveFBTWUcxN0lNRTJnbTlOOWZOb3FT?=
 =?utf-8?B?b1BVbFRlTEpIelgrT1BLdW9VYXVmdzZsMkgxV1NYSUJCQ015WTR4cmpwbjJK?=
 =?utf-8?B?ZXFDUkJjTTlCci9YOEV5VUxRVkZDbUMvTGFudHpGa3NsRmFVZS9sRmFjZy91?=
 =?utf-8?B?dHhwbmdWSEJYMzFyTmpwdFJZL2tCbGE1WWdqSkxRYjRrVkFNdXZvS3NNeVI1?=
 =?utf-8?B?MXpaaTFkUkl3Zkl6VzlqeURJQlJWZGhQQmNza05yOVFKeHBwOWRENEdEemJw?=
 =?utf-8?Q?aKc7qcBBnbXMCMdtPo11xHEra?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de8aa5f3-d534-488f-0cf2-08dd3fe85cd6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 22:08:57.9884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WNO/bMXQFSN5Uc364JWnaC2psUsS3lraKRk4gHXfqqjJ5xTi0g+GqLOQ5RBBRzOsCAC3QXzF+k1pgusLiGkw0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8555

Remove cpu_addr_fixup() because dwc common driver already handle address
translate.

Acked-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v8 to v9
- rebase latest linux-next (close enough to v6.14-rc1)

Change from v7 to v8
- add mani and richard's review/ack tag
- use varible 'use_parent_dt_ranges'

Change from v2 to v7
- none
Change from v1 to v2
- set using_dtbus_info true
---
 drivers/pci/controller/dwc/pci-imx6.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 90ace941090f9..d1eb535df73e1 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1217,22 +1217,6 @@ static void imx_pcie_host_exit(struct dw_pcie_rp *pp)
 		regulator_disable(imx_pcie->vpcie);
 }
 
-static u64 imx_pcie_cpu_addr_fixup(struct dw_pcie *pcie, u64 cpu_addr)
-{
-	struct imx_pcie *imx_pcie = to_imx_pcie(pcie);
-	struct dw_pcie_rp *pp = &pcie->pp;
-	struct resource_entry *entry;
-
-	if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_CPU_ADDR_FIXUP))
-		return cpu_addr;
-
-	entry = resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
-	if (!entry)
-		return cpu_addr;
-
-	return cpu_addr - entry->offset;
-}
-
 /*
  * In old DWC implementations, PCIE_ATU_INHIBIT_PAYLOAD in iATU Ctrl2
  * register is reserved, so the generic DWC implementation of sending the
@@ -1263,7 +1247,6 @@ static const struct dw_pcie_host_ops imx_pcie_host_dw_pme_ops = {
 static const struct dw_pcie_ops dw_pcie_ops = {
 	.start_link = imx_pcie_start_link,
 	.stop_link = imx_pcie_stop_link,
-	.cpu_addr_fixup = imx_pcie_cpu_addr_fixup,
 };
 
 static void imx_pcie_ep_init(struct dw_pcie_ep *ep)
@@ -1645,6 +1628,7 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	pci->use_parent_dt_ranges = true;
 	if (imx_pcie->drvdata->mode == DW_PCIE_EP_TYPE) {
 		ret = imx_add_pcie_ep(imx_pcie, pdev);
 		if (ret < 0)

-- 
2.34.1


