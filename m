Return-Path: <linux-pci+bounces-6445-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAE48A9F83
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 18:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 060C01C211FE
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 16:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E2F171E48;
	Thu, 18 Apr 2024 16:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LoDvq+7+"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2040.outbound.protection.outlook.com [40.107.7.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A64217109D;
	Thu, 18 Apr 2024 16:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713456304; cv=fail; b=a2KTh34p5gf5zsJnnVxdhbr6qEEaWssqWyb9oszK6Fj7hDgPgSjsHte8iMj+FBSDyx0MQ6tFdDdTQYFREOEXvpL3FDdmSHfIV1a6k3JfdKIC6d8FyopHGn0N5FV+xeM3teD41rs1E7XJuqMzB3GL060n/p5n6HkRchpsv4lBbIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713456304; c=relaxed/simple;
	bh=iaMVhIlaxnDKrjo/B86UwmBA4lUHgRwjSU/hHDluay0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=JXU0Fd1BeI8l76zUYSI4uDPfhD+TcYfGtyWm/xpHDFJ9RHvOsAzdGCZWptYYUxsUZYhFJFyNj++mGSM52jRMgBDp1o0pu/gnzvQxP3rw24m/jle9Iu3+2TgzV21/Olf/Mj3arNHVPgF6BaAm2AK3utk5xKOvOnNbGHzd13zNNdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=LoDvq+7+; arc=fail smtp.client-ip=40.107.7.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HEYhfhLhaKwpRUauQU/g0R0mkqSqRb3QhONKflaexF/MDUakjptF8hA/iMOlEpj/RA6DwlFKdKzLFAF48MVwurJHInDovQRWpJRN1N5hcNvU4MRt+BSX8Mh0aJbfxUjG7O0nQ6ZYisDO41ZFEpblbIfk/NzY0GvsELJxDtdqxXDSsMu+qmkFvgPbLPAMpFebu3Lng8ZIwhAJKmGKKCuG57KveKFJ+TOOdCqFpk3Xfpq5B4i9zHweD/ePCqEsJfIWK6u+oQ0YiQPfPcE2VKTiNqckHNSqRRSnGFfRHg9acfMkLxFMrYJDnNTCnXJs3iDVNyjIi/ZNiZWQfZLWZus/fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wqraZNkbMXJ8bdVBUWBtPeGCWP+ilAu0pVj9SSD+e7E=;
 b=GhqTW8eKCMBMnWx0MWgRw47lNzdP89dnOt10db4GvYAYtKW5mHe/DxAHqLnxccIWVT84fyq+sXqrNneH/1k3/2qUvr9GedlIg8aRQ07VV/9YMYhi1bC0BVpWZi+3MViqC/wVmbWoO4Q1f7y7WCXXNvHo4Wxue2wItjp8dojAUBH5P/cfTgX0u5YqQZBxAz/ylkzlcBz4NUNwckoqZZeGhDV107dY2I52t7bW2MLvtCRKu7swKjwaFbs65MpMryy6uIM9YFksWqFT65xsL9ZHlLtfmRheok/R+FG+Ox6VeX52I2/zuighUoQ/gsNm2aVQDuD94Xtpat29wVY4SnC4Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wqraZNkbMXJ8bdVBUWBtPeGCWP+ilAu0pVj9SSD+e7E=;
 b=LoDvq+7+Oq8Oq/diMUt19H9B8qMxlmgYbIGOcOMBSua+9OZ7J3jyGz2RfYgIJRHefATDqEU7r+HF5737k5m0HGyOD04lvfkneY2qnD5I8g88PfqUKUic0d804ArqoyRiQ9siE79nOTfIJRLednY1iEAHVnEUxPuFkWV1axxrDc4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9405.eurprd04.prod.outlook.com (2603:10a6:20b:4db::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Thu, 18 Apr
 2024 16:04:53 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 16:04:53 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 18 Apr 2024 12:04:26 -0400
Subject: [PATCH v8 3/5] PCI: dwc: Add outbound MSG TLPs support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240418-pme_msg-v8-3-a54265c39742@nxp.com>
References: <20240418-pme_msg-v8-0-a54265c39742@nxp.com>
In-Reply-To: <20240418-pme_msg-v8-0-a54265c39742@nxp.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Serge Semin <fancer.lancer@gmail.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713456277; l=2940;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Vx141tscxeq3VO/J2v1vu73YFB2QjcNfIuChtPapKMY=;
 b=iwOZqP2aKkz3fxHP7oY5DWiBJdfEOijN4F+94PRNyBFAZMed+ytRGZ5bgOuGqZYhezGenVATX
 nsaal95CH3oAgiz7IVWf3nvlj6//qmrc8bSwopuqWWlzbZBG0FFEfdh
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR07CA0102.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::43) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS1PR04MB9405:EE_
X-MS-Office365-Filtering-Correlation-Id: bcd93de1-41e3-4303-6dca-08dc5fc148aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6GdEzSEt1fbBqePYEPYUPuukzsMKnGf4HHj2WBWHxohQBDDipjfodLlpaOGx0/djgCZhJjDEb8NuEIqOq6piwbosWqvYUy9zPcOy4QdZIN8k9efBodFYdgpq6J7iIokOTC2j946HCDmvxOW8+gEVxsjHvkKZk94WRg0TMgO8g0exdG/7R4EsUsR2tlYIaFI/6OkS6etj/uI1f77DPz4fHqEr54ijxSq+FRN1g5WXEGpAD5HrR2HE3aTLU2F8eR6MCcWCLh4WohQ0w+QHvjFHShqaSlq28Dzf/2EocXSABxFrv/6RNGFbcC7HPrRWLrEpZ302yFK+WOnJzN3hzNH6cq/Vy+cxPAvxn4LzBlcNUgCarfpM+yyGxkWFyBQhwbkZ7qXM4m6XGEU2tSB1J4wkUIQTGPKHKVO5dL7T786sntIWNAJQvQHRCr4zNFgauJ6AnjY+qlBYE0iN5z02UA1/6/2StiF3tKBMCGZizpC1h993pHARk8Z8QUfFU72xo5e8iqP16bQV/qA3iL2e7v3Fn77mggSu+c0h6Fhetaah/r2DdTPD17pUXxDsjZTrscgPT+21NDG/UT+WuBr2ly97oWqPi5GilVWDpLPc0jqwhXzE4C32Hdmm43bKX0dsfHXEAMYU2tk79q9j+11IrNLdDyl2s/7NIPzOcE7DfxJRaN3SEPfRYu1dBmY4cWKly1yrrQYDDf056zcqyq2nHyJWPGKZW7lFhUmGuf8IiHclBw8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(376005)(52116005)(1800799015)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dTlMT3lIVmRSNlVwa0xzME1YTm5jZVhLVng2RVdDSGhuWS9CN1Rmck1OVmZM?=
 =?utf-8?B?a0xBQ05HL2dKK3M5aWNPb2JHOS8xZHdWMVhTcmlSdGNUdjlsdmlLYnZLaUpC?=
 =?utf-8?B?Y3AxcE83eWlTRmVoZUMydUlrN3hQZ3lrNE42SHNuMDl5T1ovS1dBRWphZlZ0?=
 =?utf-8?B?R0p0aUU1MU1nbTI4WlREOXE5NGhjQ096aGkyazd2SnlCWURhREMzcW40c0Yw?=
 =?utf-8?B?bHphZXN3anVuSHVBcENRdEc5Z0F1WmtyVXJIWWhYbzNDTTVET244U3ZuL1Mx?=
 =?utf-8?B?QUxGTmYvWmNiK1NNN2RWcHNIWXpqRlFkYzBERFpSOXl3cW9UL0JqQ1ptc29I?=
 =?utf-8?B?d054ckU2V1hRWnpQUXRkeE1UMmtadVRsemd0S0NVWEdrYUJleWxCb3lGZjBp?=
 =?utf-8?B?NGpiS05NeVlTbkFCU3JPNjM5ODFQZXdOdE42cXBoZEtmN1NtLytHcUtyVEdn?=
 =?utf-8?B?OCt1dnFrV1FmaytCcVhwU252Q3ROU2NvUUpYVjRJK2k4a2U3Z0I5OU9OQ3Q1?=
 =?utf-8?B?c0o4TFlyOGpaeEs1UVB2bDZVN1d5YkdFVHJBMVdPS2hzeVllMmRNeFluZSt4?=
 =?utf-8?B?NUNJNytQZ3hwSmJoWURvZkdNTzh3YWZWTk8rWTBKc21zTmhYUlZLU2RpSWt3?=
 =?utf-8?B?Uk9TZktqd3VFWXhNcU5SY2p6Q0hiZXRZeTZUSG9oSVh5ck5pR2JHbkgxVk50?=
 =?utf-8?B?a0J5SWIyVmI4UEJLVUYxUXd5MzNnMTUzUEpvK0w3ZU95SnVvN2JzcW9ZVlcv?=
 =?utf-8?B?K3gyZ0Rzby9KR0dsTklnTjhiYmNZRzhuUWlpSzZJUFl4WGNRajQySGQ0TjZl?=
 =?utf-8?B?eW9ZZk9NOXFYcGN1eHh4dlJuUWYzZ1Jab2Y4bUliMVloVVZUcnZlSjY2aDBn?=
 =?utf-8?B?UUI0aHJtNFlyNC9RUnpSYkxKWWJsdVRUQ0xvd25HYms0RGZqSW9mNjNwOXVm?=
 =?utf-8?B?T3RpQWFDVkxyd1Zya2NBVVB5bGdYRGtaRHNuMU44Q00zWHY5bDRBV2NKcWY2?=
 =?utf-8?B?NmtrQUtnMkZyY0FVUTJpU3JwNWMyV0NMNE41dWdtOFpNdDZad0FNdHhnaEdz?=
 =?utf-8?B?YVRMcXRqWE1pajNZVSttZllad0RVVVJqc1V3RXlvQVlvTnExeGh3bEFUQkdN?=
 =?utf-8?B?eCthblFpYWNuU0NLeGFQdnFUSmtlYUFVQ25FUnBpd2p5SS9FOE1HT21FekpE?=
 =?utf-8?B?aUNyeW82WHM4VTdZQ0ZFY2VORWNMS2VzSnFqMUQrbjlyd0FNTEkzazR4ZDR6?=
 =?utf-8?B?cXRmZFlaMjErSytQQ3E4dTNndUhXNHdldmdidmo0Zm5QYnk4NGxZSlhvMlZq?=
 =?utf-8?B?cUFFVDJxK0hMUkdjT2k1bjN4clYvT3JNR0pIZ2JNMzlGR3ZzclltUCs5U1dC?=
 =?utf-8?B?VlZMVnE4QWxhTk9iREhuTXowbU00K2p4bktUWUE1dWNUTStYS2thcUtWREll?=
 =?utf-8?B?Mkk5Tks3OVlVenZhWGtBNGpLS1Z6bktnbjByN3N4M0laVUQrUTFFc09kLzZh?=
 =?utf-8?B?aEJoUXl6R1BGYkdoS0ZKYk42TzdQQ2VpazlKMWxwdnJEQmVVREVEYVpocm9r?=
 =?utf-8?B?RVlEbzJVY21NK3RKWi92cThUQ1V5dUZpRkxzQjBJTm1zejUyU3ZRd0M3bWV2?=
 =?utf-8?B?bnRRN0ZJaTFycS9uZGZGRTU1YzNMWXcxRzRIVDVkVU1aUUJHTGNnWUwzakJ1?=
 =?utf-8?B?WXVqeGlTVlQ3YnEweFJQZDMvRXdCdWw0NUs1WWt0eVBXZjJoZER2bDl6dzNu?=
 =?utf-8?B?MnFRdmtOZE1PemVYVWZRN3ZmWEZaS2p3Uzl3UCtlaGwyMm4zRjJnditJbVhQ?=
 =?utf-8?B?ZnhKY0pVck1wTXBoaFVRblhHQmNFaTVYZ2hpTktjTVNSZk9QWHgyb084L2JZ?=
 =?utf-8?B?VTBucjJrNDVZNUFvRnJrUGFyS044Tm9hUlMvYitUZ1MremFjV1V0cWFMQjhS?=
 =?utf-8?B?aVZoaGpSeW9LczJkdXpQTU12cDJ2N2V5WW9xQXpuTlkyOTFyZWQ1ai8yblBh?=
 =?utf-8?B?a2ZibkVCZDE4aDBNNStlOGRxajEyQm5LSU9QNjhJRmdoU0dLMlJrTG9CVHRK?=
 =?utf-8?B?bUtvdkNHSnl1RnNNeUlvNDN0cEw5eXA0aWxlOHBFbmVXTnFxSG00dE5wdWll?=
 =?utf-8?Q?Xf00fZl6KnRHO2NlrlK12fWls?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcd93de1-41e3-4303-6dca-08dc5fc148aa
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 16:04:53.3528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZMmBmVZrchFIu7Z9PiqTblHGDriUzXijO9LsnDpDDck8MvI/CCVkgrLxMqbnlOR1WfZGhN7UEaeksDq+zKqNLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9405

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Add "code" and "routing" into struct dw_pcie_ob_atu_cfg for triggering
INTx IRQs by iATU in the PCIe endpoint mode in near the future.
PCIE_ATU_INHIBIT_PAYLOAD is set to issue TLP type of Msg instead of
MsgD. So, this implementation supports the data-less messages only
for now.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 9 +++++++--
 drivers/pci/controller/dwc/pcie-designware.h | 4 ++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index df2575ec5f44c..ba909fade9db1 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -499,7 +499,7 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
 	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_UPPER_TARGET,
 			      upper_32_bits(atu->pci_addr));
 
-	val = atu->type | PCIE_ATU_FUNC_NUM(atu->func_no);
+	val = atu->type | atu->routing | PCIE_ATU_FUNC_NUM(atu->func_no);
 	if (upper_32_bits(limit_addr) > upper_32_bits(cpu_addr) &&
 	    dw_pcie_ver_is_ge(pci, 460A))
 		val |= PCIE_ATU_INCREASE_REGION_SIZE;
@@ -507,7 +507,12 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
 		val = dw_pcie_enable_ecrc(val);
 	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL1, val);
 
-	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL2, PCIE_ATU_ENABLE);
+	val = PCIE_ATU_ENABLE;
+	if (atu->type == PCIE_ATU_TYPE_MSG) {
+		/* The data-less messages only for now */
+		val |= PCIE_ATU_INHIBIT_PAYLOAD | atu->code;
+	}
+	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL2, val);
 
 	/*
 	 * Make sure ATU enable takes effect before any subsequent config
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index d21db82e586d5..703b50bc5e0f1 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -148,11 +148,13 @@
 #define PCIE_ATU_TYPE_IO		0x2
 #define PCIE_ATU_TYPE_CFG0		0x4
 #define PCIE_ATU_TYPE_CFG1		0x5
+#define PCIE_ATU_TYPE_MSG		0x10
 #define PCIE_ATU_TD			BIT(8)
 #define PCIE_ATU_FUNC_NUM(pf)           ((pf) << 20)
 #define PCIE_ATU_REGION_CTRL2		0x004
 #define PCIE_ATU_ENABLE			BIT(31)
 #define PCIE_ATU_BAR_MODE_ENABLE	BIT(30)
+#define PCIE_ATU_INHIBIT_PAYLOAD	BIT(22)
 #define PCIE_ATU_FUNC_NUM_MATCH_EN      BIT(19)
 #define PCIE_ATU_LOWER_BASE		0x008
 #define PCIE_ATU_UPPER_BASE		0x00C
@@ -303,6 +305,8 @@ struct dw_pcie_ob_atu_cfg {
 	int index;
 	int type;
 	u8 func_no;
+	u8 code;
+	u8 routing;
 	u64 cpu_addr;
 	u64 pci_addr;
 	u64 size;

-- 
2.34.1


