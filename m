Return-Path: <linux-pci+bounces-17953-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 165589E9D6A
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 18:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49BC016068D
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 17:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3036A1552E7;
	Mon,  9 Dec 2024 17:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fEec73pH"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2066.outbound.protection.outlook.com [40.107.249.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648C1140E34;
	Mon,  9 Dec 2024 17:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733766522; cv=fail; b=j+IbUhwP4vQG8uylMo0pYdbCXB5a6rDoa0xkKonO9rBnIBr0rFVTJrqM/JomPJsIpo89FGoUnxB989FSeSWf1pksGTuj4vQTuIn2emm0pvPKAKhi+cnXIQLcmVe7EUoH25KTsERSEKEhSuvitZqkHD6KQ97yCOveSWmlrJhQ9Rc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733766522; c=relaxed/simple;
	bh=LwZKkgffD4LQgun+GAdCSYBbNjFFRo6II4pFFwHjCfE=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=uPs308PFS4NKvbYOdgHpOWumMvw2RrAp+XmmdsGXpgHztbDHnjcs9yybqYjz+3ulVr8qT5FLOBQLMeufwNxxJxss51PMe5HKcqr0MCAfxpufgZ/ThYjCLg3klheGXpbYaPbPEvqcRoUar0fUh/efhW9l/pjdFlGsTwuVO//ilyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fEec73pH; arc=fail smtp.client-ip=40.107.249.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NAtNm55Xl/dUwlQmDhaa6UXt4IwriCwKZtb5g4LxmcYblHEkMoCimKfEZjVi8Eub7NPwtSoVVcGoG9Q7CUM9kImrOObjQwcLshk1uLWhtX8nN1L+5XoPmXSnnQb4jugRMMZamo9KWGRBzYfEa2y+Q6W/H/26Ma5v/nkknVriWbjv5M5XBEIyW9wQKKM1jL/FFJlBucWX0VpUkH1yHGme23rzSbcrKrdk7SoGGfAiS5d1bYhdEfn3AwZwRXGkVM/OtcVz+FRPJjVOXd873tNyjxq5RN6GiR6zSWnbjfBbklG9gyTU+KgqlcPcjolTQtSI5Q9Z4utLSAbo5kcgRpKQow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJIfaPd45JflIwKJaxgB1f6UjHuV3xSNtxbfq5Z3Yjw=;
 b=Z/cxVDVxk29tdl/ZlPg8K7/9jWVZhgSNF6qzQ8B5ATKWmHKKsvA00+PprIvli1fJOi3BnWWthIbKJj+AaAvDOJNfc+S8V38kWOQ5VaREolgyrlh7h9NGEjSVpcR7/CTGAytukmVHUKgVhdWjUEE0TvDnqfbj1J0GqdkzAj6+7CO6qXE6HtV/9nsheiPy0jsU2kMAuE2Nk5j/iKRuMuhBoU/ADJYs8cyiI3ChN2b/eEqgMR9SfNhSGEB+R4yJBEKCsnXKRGWoKnNd/wWoxX5vkc8awYf/sHeZPgbgCxgJ2XnxZnzjMT26swhfjjZyzA4+RVOKmxcq+UZgn/UNoKX3/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJIfaPd45JflIwKJaxgB1f6UjHuV3xSNtxbfq5Z3Yjw=;
 b=fEec73pHgRPQLC1RD5EqvjlFc5e7l7scCNss4IGtzaE2KAnliNc7PyrMJuAY3O8uztU/zWDpJDuU/EC/ERhUYCecBJZVYfaMrYJs1xRmjR+ygQsvFoVTXzmoFlVLtxUxr3aQQNJsA6xLSQrud5ayhefLZ2VQl2b5XZdU30xAyTtfwhCT9snqXiWgzX+MxxMqrM6VSatrfXtmSgP2qe5ZkGOrJned3uXYlFyLU1E0XX/dTpcNW9DCX9fF9BQd6wkuXERohIw7jWTkfvhYra01pmfQP/SexTPc5mJSVq8wzXcw7W87yfidnDyJa0wkhzoBSGEblXylObyNny9xJ9hbgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB11017.eurprd04.prod.outlook.com (2603:10a6:150:21c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 17:48:35 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 17:48:35 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v11 0/7] PCI: EP: Add RC-to-EP doorbell with platform MSI
 controller
Date: Mon, 09 Dec 2024 12:48:13 -0500
Message-Id: <20241209-ep-msi-v11-0-7434fa8397bd@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAF0tV2cC/13RzW7DIAwH8FepOI8J801Pe49pB8CwcmgaJVPUq
 cq7j1QqITva8u8vW36QOU0lzeR8epApLWUut6EWAG8nEi9++E60YG0QzrgEBoymkV7nQm2Q0Qc
 hAoRE6vA4pVzuz6TPr1pfyvxzm36fwYvYuq8I9YpYBGU0JozWedAR/MdwH9/j7Uq2gEV2SEBDs
 iIDBj1H5wK3R6R2BMw2pCryIJ2CyJAxc0S6Q8Ab0hVJlZ3hPInI/61neiQbMhWh9NF4nwPyeES
 2R7ohW5HOkLXNGSGEI3I74kw05LabNMMQRQaFeETAerXvVz/IqDVRGFsl6o6t6/oHax+biBACA
 AA=
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Anup Patel <apatel@ventanamicro.com>, 
 Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org, 
 jdmason@kudzu.us, linux-arm-kernel@lists.infradead.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733766511; l=8586;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=LwZKkgffD4LQgun+GAdCSYBbNjFFRo6II4pFFwHjCfE=;
 b=2WwrUQwmk7UUG0NJhUNX+9mQF5fSk889VGmrFCCSKgmvPTMQU/QhOz0MPuf+OEteWpLU1p7Z6
 ZEMNAvxsDL5ByEdpuiU1GB4G8NOXECWSWGnTo0oALw6WKWlooMgNCye
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR17CA0070.namprd17.prod.outlook.com
 (2603:10b6:a03:167::47) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB11017:EE_
X-MS-Office365-Filtering-Correlation-Id: fb00ea6e-2c3e-4afe-0411-08dd1879b446
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TkdGbHZXOWJJb3VMV3VMSVdLRHB5SThSQWpna2JpZEl3bzFEQ3QrOVhhRXRl?=
 =?utf-8?B?Y2pmMjhkMC8xWHBLOUFwcG5BTGdQMmt1d3RKbll0M05ZZExKaXRrejVQMFA1?=
 =?utf-8?B?aytJRkV2d2NaWEhybmQxajV3RnFhUlozWnl1VUpQb3pGc3lqNWlPUXFKeFJH?=
 =?utf-8?B?MElkbGhmYkYrM21nemlHQ0Z0VGNxVjc4S2FBT24zNHgyQ1ZSUzAvSkpDMGNk?=
 =?utf-8?B?ZmpCTzJMTmVVdHg5eU5xb0xCQ0taNXBOZ1NEUkQvcm5MVDJGY0R0TEllbk05?=
 =?utf-8?B?WmRVMVc2QzJjeURqSFZ6Qi92cENTSTByU0xhVmdPOFpqaVRrdmhkNHIwbGJw?=
 =?utf-8?B?WFpYWjN4N0wzUUIrQUtXVFQrMXdWcUxFUzAvaVRoMGxZaDUxa0FIQlFXOEls?=
 =?utf-8?B?QllXVDhqcSsxN211TjRGOG43dlA1N2EveElKWWcwS0xPbW9UNlpVQ1VoVjc0?=
 =?utf-8?B?R04yTnJIcDFUaHhjT09oKzVjbzNHdlVPQWJlTENjM21STlBKTHhveGZJUEs0?=
 =?utf-8?B?S0lRTnlhQTRtT3U5SjN6MUNpbVNMYVFpSlJWMVQrTzNPblIyNGZQWU9xeGZG?=
 =?utf-8?B?L3hqWjhpQklvY2xnZXBkaGtnRFZxYVdTMUpKdGx6N0QvWlpuUUF2TUo3Y3No?=
 =?utf-8?B?bEdKN2svdW9mM3dXUTJ5YnZhbndDbjhOeUFoNmluRk5hTklPeldVaUR5NVF5?=
 =?utf-8?B?T1dycHdqNW1FazZJU0g5Ty9iNnZnVEsySFBPWU1sNUg2ckViNEhqbmRRejFm?=
 =?utf-8?B?L05wNStod3gzOCtUVkhJd0hxU1NuM2l6alNoOXRXamFEd0orNHNaNHcvcVU5?=
 =?utf-8?B?ZFBva292TTN4SVNqRENPZDVBVFVzY05ra2hqNXRZUTJ5VzVrNkJEZ0RsZmIv?=
 =?utf-8?B?ZHRZMVhTc3ZUaVNPd0sweVk5NEZHWG1zU25KelNyVUFMaTlxaE9FTlIra0RH?=
 =?utf-8?B?VkhQeDQ0MmpzdEZaVUtzTE5nM3dnYzBnV2NSUnBxZGp6N3hvc0E1MkJjRWZB?=
 =?utf-8?B?cmtvYU5Oais1clpKVW9vc0xQT0xNZzRPT3JGSWtRVk40NzA2SDdzVktVblFt?=
 =?utf-8?B?R3F6Nzl1Ly9KOEZxUWlxTTZtb21YR204M2s4eUNmR1V2RU1ZWDZzTkJ4dWhn?=
 =?utf-8?B?Q3BFbnQxSXFUbVhaWGxKNm53SldvSjZuMVVYSkZGTGpCYmR2clNYcE12N2pj?=
 =?utf-8?B?YVBNOFVJb1RJV1RyNC9kMDhaWUozOVJ4bUE0VXNGWlZZVFhyNEZjZFdhTS9k?=
 =?utf-8?B?YVMvSXUvZFZqR0hUblRVRWo3Sy9wSmp2Y3ZDMmR1eC9TdG1rNldmTVFoY01p?=
 =?utf-8?B?VEN6YUczYlpMdGtyY0NGRzQvOFB5OW9PRU43emEvL2xoVjNhclJIdWU2RXFk?=
 =?utf-8?B?TllTTFJlT1M5czVhYWtYcXArRU9VSXNQYkZSN1E1c3NNYzNSZExsKzV2R3lG?=
 =?utf-8?B?bFVjZVlVWGdjUFg5WjA1cDNHYWp2MWk1WXN3RGtmc3R0NGg4eTJFOXFUWWtx?=
 =?utf-8?B?NXl6b0N0STY1NFJZcGZ6NkdCUjcva1p6ZzlCSFRDcmdBZ0lFNFhKQ3dWczVK?=
 =?utf-8?B?SzF0cEVSRHYzMHl2ZzhvMklNMWRib1YyRWJac1V4ZFZRRGRvSGdiVWhuRUpl?=
 =?utf-8?B?L2RLWU54d0tReS82SmUxV2dIODF3R1YzVk0vK3JJdndlQjN3cUJjTWVxLzNF?=
 =?utf-8?B?cGFMMW1wdDFZWVUvZlcyS2p4amV5dmtxT3hPdENUQkJ5c1FtVzVibUd1Yjhu?=
 =?utf-8?B?c0pZeTk5T3A4bi94N1BhR25tZDhwTjE2MzBUQlhoQ3l3YmRndlM1R0pIV0dK?=
 =?utf-8?B?amI0eUtnckQycjNabVYxWTlIaGVpbFVrYzB2aVJxNVprYzYwU0lIVG8rNng4?=
 =?utf-8?B?WDhWZ0JzK1RHVGNrUmZwQy9qcHBOKzJidzhqUnphWXllRS90WWJaNnNvakRz?=
 =?utf-8?Q?i5xKVVKAnek=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eVdTN2Zwb3FTYVZRNVdzNWttdUN3MmlIZEx5SVBHMXBhRGhTdFA3Y25kVkRt?=
 =?utf-8?B?M3JVcTZ0WG4rbXVSU0llcEVVN2JySHBDNGM3NWZSY3hVOCswTDBGbDZpbGlk?=
 =?utf-8?B?UmV2bUlMbUtXSHoveCtsb1N6SjJNRW5hTjAvWlg3YkQvQ1JtZG5TN2lXUXJQ?=
 =?utf-8?B?SVJYMDlyU1ZKNkZEZHNTRG5TY3FDRDFlVzY3SGJNemRvaUdBMWh0TE8yY3Bh?=
 =?utf-8?B?V0RkYlhiZmhBYStBaFFmWmg5NUQzZktScFNoVWhIcUJwZllKcldaZ0dGdVVF?=
 =?utf-8?B?MmJkc1p5VVRjYWp5b1VqUnFxVHN6VXRwMHpYM2xLd3NNUjVFa3VqMVFJdW8y?=
 =?utf-8?B?VmtIcHJJeDkrb3RCS054TjFKSTBqNlRVOGNnY2l0MzlDdmd3ajFYdVU2YTJ6?=
 =?utf-8?B?MmlIMDY0L0FvaW14MmhMc0dEL1hibHBRMTlUejNMMU5hdnhQZVBWa2lWRjBx?=
 =?utf-8?B?bXNFUEVUbjkyYjl2UHdQS3EwNFIyWE93WGJyeUZ5WTdkOW1ZN0h6Rm5BSkxR?=
 =?utf-8?B?THlWcTVrYUkwY1VRV0FlM2NnZ2VJQTBNclY4a3pjZHAxMVROeGdFcDhhVzN4?=
 =?utf-8?B?K2lLTEZablMrUk91Y0FHa0kvblhkWGdGVjNyaE53V1JzbmxKc2RwTE9veG5G?=
 =?utf-8?B?Q2x4eXpGQWx3U0pZK3dFTG4wUXF5VUlBOTZYYjgwMjFRd2tjdHZOYmF2YVBP?=
 =?utf-8?B?RGFNNHZNOXFPRzJnSXhtTFEwK29YeXBWSUc3N0kxWlNza2hOZ0JQaFZJTkps?=
 =?utf-8?B?YktnQ1Z5YkNZYlBzckkwY3lRZW50dlhVcUlBS0hTdCtNT1dORUVSajYrbUpl?=
 =?utf-8?B?WnNJYnJ5SUFXL25sN1ArbldGdkJoN0FYNlROMk9hRDI1RGc0NDY3TW8ycjNm?=
 =?utf-8?B?ZGdsdCtVaExJa01YeTZZRURrWnViR2NQK1NZeW5NVStrYlRpelNVQzdpbE5Y?=
 =?utf-8?B?UjdtMDlETmprYVc4QXVqZkxmQ0FxTURsMjVTdnhQRDV0cnAxdDBrZG9oMHRE?=
 =?utf-8?B?cHBFNWxtL2tMSmhDTjFINGo0ekIvSExCVXJQbnZGVXhBeStaQUNrNGZIeldD?=
 =?utf-8?B?bHE1UUE1U3VqbnVhSmFZY3lVTkQvbkpjb1V4OHArSFMrTWQzeG5zeWNlNWhP?=
 =?utf-8?B?MlhsY1BmdElrQlVFeWhleXpaV1BtRGFMVGJrWVcvQkhaL3U1NVlxOStrYjJS?=
 =?utf-8?B?WDFZbDRVUmZvSXc2ZDBaZkxOenNoS2F5WjZ0REtOWG4wM2lPMldKalFNcmNM?=
 =?utf-8?B?UitqbHhRS3A4Y3FycHlYb2I5QUUxbVoyV0kyWCtNSWUvR3E0TlUzRHRTbFdW?=
 =?utf-8?B?WkZBWloyMlJRcmVnYndOS1dlNWFSRXlISmhzT01jNFRsRUp0aFN1emd6TW8r?=
 =?utf-8?B?eWo5SXFjSzNmdkhmZzQyalRhdjlzSHB6RWJwbUNsZjZTSFVPZkN3SUVzYU9s?=
 =?utf-8?B?TnRQU3BpR00ycC8zSVlXMWFNS1hBQkxJcVVVZjI1STg4aFhJN2NGRklLZi9U?=
 =?utf-8?B?cXM5d1J4dDF1NXRyeVB0ajhXM3NkYTd1RU9NUVVydFNId3QvK0d1YWl1TEEx?=
 =?utf-8?B?OXlHUTEwSWkyb1R3UGliMFZkQlpYVzQ0Z0NRdm1vdVQ1QWlpNm9sa2I1SGNo?=
 =?utf-8?B?VmFCUjF4NWNkNE1XQnliUStwZkh4ME0vSVdaQUZxbEpJdmp6eDk3Q2FFMmFr?=
 =?utf-8?B?enJFQ2syRUhkdG1qeE9hM0plQS91a29FR0pnUDcwZTdkUXJIZURZRTNmOWc1?=
 =?utf-8?B?Z3RtTi9XVVI0c1gyWUNZNnRscklucE5YbWhxNkE2WnJzZHBock5UNFUzZm5r?=
 =?utf-8?B?S0hXNFZ5VnIreWdVS2FGWEtrWWc0VGN4Z3BWNTJFZ3Z5cmxMbEFIcjNIREdr?=
 =?utf-8?B?RUlaNWM4MzY3QlJ2Umg4WER2WDY5QlNHV3E3QzVwd0lnRnZBZjJlRVMzeHFu?=
 =?utf-8?B?WEhPbStuSjlFcUhCOWE0aG9HWHNLcDFaVCtDb3R2OFNlOWZXRUZvdENrTGVn?=
 =?utf-8?B?cGl1U2xraklXNGxGOUpIZHRlMGZVRkE3ZzBaTStuQXdNWXdKSWl0VkxSdDdz?=
 =?utf-8?B?M0NrcThydVpiaitxZFRQQUU1d1lrUnlQTVA3NzZ3NkMzVElPTFR0QmJOQXVM?=
 =?utf-8?Q?b6Ns=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb00ea6e-2c3e-4afe-0411-08dd1879b446
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 17:48:35.2175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tb6EdcZmePclHBcT9Ha3snpEIusL7//67YBvmTw+r6F1txrpUDi+gK0RROUv4Au4LIKA91wfKzYQle40n+Q+Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11017

┌────────────┐   ┌───────────────────────────────────┐   ┌────────────────┐
│            │   │                                   │   │                │
│            │   │ PCI Endpoint                      │   │ PCI Host       │
│            │   │                                   │   │                │
│            │◄──┤ 1.platform_msi_domain_alloc_irqs()│   │                │
│            │   │                                   │   │                │
│ MSI        ├──►│ 2.write_msi_msg()                 ├──►├─BAR<n>         │
│ Controller │   │   update doorbell register address│   │                │
│            │   │   for BAR                         │   │                │
│            │   │                                   │   │ 3. Write BAR<n>│
│            │◄──┼───────────────────────────────────┼───┤                │
│            │   │                                   │   │                │
│            ├──►│ 4.Irq Handle                      │   │                │
│            │   │                                   │   │                │
│            │   │                                   │   │                │
└────────────┘   └───────────────────────────────────┘   └────────────────┘

This patches based on old https://lore.kernel.org/imx/20221124055036.1630573-1-Frank.Li@nxp.com/

Original patch only target to vntb driver. But actually it is common
method.

This patches add new API to pci-epf-core, so any EP driver can use it.

Previous v2 discussion here.
https://lore.kernel.org/imx/20230911220920.1817033-1-Frank.Li@nxp.com/

Changes in v11:
- Change to use MSI_FLAG_MSG_IMMUTABLE
- Link to v10: https://lore.kernel.org/r/20241204-ep-msi-v10-0-87c378dbcd6d@nxp.com

Changes in v10:

Thomas Gleixner:
	There are big change in pci-ep-msi.c. I am sure if go on the
corrent path. The key improvement is remove only 1 function devices's
limitation.

	I use new patch for imutable check, which relative additional
feature compared to base enablement patch.

- Remove patch Add msi_remove_device_irq_domain() in platform_device_msi_free_irqs_all()
- Add new patch irqchip/gic-v3-its: Avoid overwriting msi_prepare callback if provided by msi_domain_info
- Remove only support 1 endpoint function limiation.
- Create one MSI domain for each endpoint function devices.
- Use "msi-map" in pci ep controler node, instead of of msi-parent. first
argument is
	(func_no << 8 | vfunc_no)

- Link to v9: https://lore.kernel.org/r/20241203-ep-msi-v9-0-a60dbc3f15dd@nxp.com

Changes in v9
- Add patch platform-msi: Add msi_remove_device_irq_domain() in platform_device_msi_free_irqs_all()
- Remove patch PCI: endpoint: Add pci_epc_get_fn() API for customizable filtering
- Remove API pci_epf_align_inbound_addr_lo_hi
- Move doorbell_alloc in to doorbell_enable function.
- Link to v8: https://lore.kernel.org/r/20241116-ep-msi-v8-0-6f1f68ffd1bb@nxp.com

Changes in v8:
- update helper function name to pci_epf_align_inbound_addr()
- Link to v7: https://lore.kernel.org/r/20241114-ep-msi-v7-0-d4ac7aafbd2c@nxp.com

Changes in v7:
- Add helper function pci_epf_align_addr();
- Link to v6: https://lore.kernel.org/r/20241112-ep-msi-v6-0-45f9722e3c2a@nxp.com

Changes in v6:
- change doorbell_addr to doorbell_offset
- use round_down()
- add Niklas's test by tag
- rebase to pci/endpoint
- Link to v5: https://lore.kernel.org/r/20241108-ep-msi-v5-0-a14951c0d007@nxp.com

Changes in v5:
- Move request_irq to epf test function driver for more flexiable user case
- Add fixed size bar handler
- Some minor improvememtn to see each patches's changelog.
- Link to v4: https://lore.kernel.org/r/20241031-ep-msi-v4-0-717da2d99b28@nxp.com

Changes in v4:
- Remove patch genirq/msi: Add cleanup guard define for msi_lock_descs()/msi_unlock_descs()
- Use new method to avoid compatible problem.
  Add new command DOORBELL_ENABLE and DOORBELL_DISABLE.
  pcitest -B send DOORBELL_ENABLE first, EP test function driver try to
remap one of BAR_N (except test register bar) to ITS MSI MMIO space. Old
driver don't support new command, so failure return, not side effect.
  After test, DOORBELL_DISABLE command send out to recover original map, so
pcitest bar test can pass as normal.
- Other detail change see each patches's change log
- Link to v3: https://lore.kernel.org/r/20241015-ep-msi-v3-0-cedc89a16c1a@nxp.com

Change from v2 to v3
- Fixed manivannan's comments
- Move common part to pci-ep-msi.c and pci-ep-msi.h
- rebase to 6.12-rc1
- use RevID to distingiush old version

mkdir /sys/kernel/config/pci_ep/functions/pci_epf_test/func1
echo 16 > /sys/kernel/config/pci_ep/functions/pci_epf_test/func1/msi_interrupts
echo 0x080c > /sys/kernel/config/pci_ep/functions/pci_epf_test/func1/deviceid
echo 0x1957 > /sys/kernel/config/pci_ep/functions/pci_epf_test/func1/vendorid
echo 1 > /sys/kernel/config/pci_ep/functions/pci_epf_test/func1/revid
^^^^^^ to enable platform msi support.
ln -s /sys/kernel/config/pci_ep/functions/pci_epf_test/func1 /sys/kernel/config/pci_ep/controllers/4c380000.pcie-ep

- use new device ID, which identify support doorbell to avoid broken
compatility.

    Enable doorbell support only for PCI_DEVICE_ID_IMX8_DB, while other devices
    keep the same behavior as before.

           EP side             RC with old driver      RC with new driver
    PCI_DEVICE_ID_IMX8_DB          no probe              doorbell enabled
    Other device ID             doorbell disabled*       doorbell disabled*

    * Behavior remains unchanged.

Change from v1 to v2
- Add missed patch for endpont/pci-epf-test.c
- Move alloc and free to epc driver from epf.
- Provide general help function for EPC driver to alloc platform msi irq.
- Fixed manivannan's comments.

To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krzysztof Wilczyński <kw@linux.com>
To: Kishon Vijay Abraham I <kishon@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
To: Arnd Bergmann <arnd@arndb.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: imx@lists.linux.dev
Cc: Niklas Cassel <cassel@kernel.org>
Cc: dlemoal@kernel.org
Cc: jdmason@kudzu.us
To: Rafael J. Wysocki <rafael@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
To: Anup Patel <apatel@ventanamicro.com>
To: Kishon Vijay Abraham I <kishon@kernel.org>
To: Marc Zyngier <maz@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arm-kernel@lists.infradead.org

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (7):
      irqchip/gic-v3-its: Avoid overwriting msi_prepare callback if provided by msi_domain_info
      PCI: endpoint: Add RC-to-EP doorbell support using platform MSI controller
      PCI: endpoint: pci-ep-msi: Add MSI address/data pair mutable check
      PCI: endpoint: Add pci_epf_align_inbound_addr() helper for address alignment
      PCI: endpoint: pci-epf-test: Add doorbell test support
      misc: pci_endpoint_test: Add doorbell test case
      tools: PCI: Add 'B' option for test doorbell

 drivers/irqchip/irq-gic-v3-its-msi-parent.c   |   4 +-
 drivers/misc/pci_endpoint_test.c              |  80 +++++++++++++
 drivers/pci/endpoint/Makefile                 |   2 +-
 drivers/pci/endpoint/functions/pci-epf-test.c | 132 ++++++++++++++++++++++
 drivers/pci/endpoint/pci-ep-msi.c             | 156 ++++++++++++++++++++++++++
 drivers/pci/endpoint/pci-epf-core.c           |  44 ++++++++
 include/linux/msi.h                           |   2 +
 include/linux/pci-ep-msi.h                    |  15 +++
 include/linux/pci-epf.h                       |  19 ++++
 include/uapi/linux/pcitest.h                  |   1 +
 tools/pci/pcitest.c                           |  16 ++-
 11 files changed, 468 insertions(+), 3 deletions(-)
---
base-commit: b66d92bfe0a9e86a622e77a12e420b69af633d1d
change-id: 20241010-ep-msi-8b4cab33b1be

Best regards,
---
Frank Li <Frank.Li@nxp.com>


