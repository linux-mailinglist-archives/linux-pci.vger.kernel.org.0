Return-Path: <linux-pci+bounces-6446-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8648A9F87
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 18:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60131B2399C
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 16:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3D0172767;
	Thu, 18 Apr 2024 16:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hdpzfXsX"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2040.outbound.protection.outlook.com [40.107.7.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1C0171E54;
	Thu, 18 Apr 2024 16:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713456306; cv=fail; b=nZQq1cP2rTIBC90PNRPktTpl5QohdhG95K2/17kRsNDAQTxBw3JO0lW59k6QXYC1Rw3RLGe5VrmoA8yGi2vjJ8tLePZutbofdPlSb1CrcEJqHeoMpLVODhnHF2m70i9sC45o8dBXjsfqNx2gxtuDPKE3Dm0+MFtcB+sn9vzuScU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713456306; c=relaxed/simple;
	bh=HBrDDEQgS1PwyYGOiWMtqw4UVzX2aAOyF6VHJAfWOAM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=HLKnI7LSHLGD+RzyKIHaIt/yIjJM2INv0mYl6AYOuOfDzYsqDDRU/vta0RIJXvre6Sm1aLEcxbh66wp5gB8SDF7RnhNLjbWaQ5eLMl7+NN35C1oOL7kUTCGw4UA3K4vg+TpNMVtAKdL7iaun/YUlinWNijErxH5c7bGXmnE/0vI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=hdpzfXsX; arc=fail smtp.client-ip=40.107.7.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OApx1USON1cUDevmbXCiNvivU8qUMarbiv1RYaOCTGgt+mkc/UbT3yqqg1PBznvC0KFJI6yyXyP5gsoVZXvr3AwZCvEXd4kZwrVrP2UXy/q4g9m8UOhFKtd8SuitdHCfBanDkSZFulIkP2YNuAzQ+kmQVrMtiiPFWLlrRw19eQSFsBwuoItheierSRhNVC+ruWf/EUSNuyKSQERSJBc0Y8VFqmIWklFVWUcCJFL2YWteUq/rBDOJgSL+zjYyfOlGZiUI5bkYq5Rd4SuG66yb83cbuPKaxQbU8dEaxrR4eYGiI06Og/bOmFJhYL6bDUVIceb8qP0aXweQChdEMyXlwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+RRrFNJbIOOcLv6kDjbrp08Dv5ZMe1J/luxwYfXTdFg=;
 b=bKIfDjMs0W5zXAVtTABB1RAXpe9+BQLh3+znPgosd8ZCkpkS7HySwLq0ggnY0O2LjwMe6sB4S505MX2LLPo9HBUk8e/K2BuTOsMAJ9cet7cUbsUUt1DxY+eb06CbnRETLDzLSJidpOZ4qfSxoZmFgZ8/4UEOUrZjQFfNax8Xl+A53LjCEKKPupipqxAMGtr+8lCXSi/DvyeKE+PDV4yRv6uamY3Xne69oplGz5ajVuznoYRG8mUCGwvkGz97Rc5Anfb7GDl2UARm1Du07pL9rn3y9wBgtu9gq7+Gp+8NpFedv0iQxo7JT8cRe0uEdUpOUn/R4ImUugWcLOvUxH4x/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RRrFNJbIOOcLv6kDjbrp08Dv5ZMe1J/luxwYfXTdFg=;
 b=hdpzfXsX1PrjrLSrdR1TclxeZfdABRiTVR5Z6xs7rs7zOTnzI7fBs2577daKMbnU8UTi5OWIuDf9up4WrJOLITQxafZVoY9fitV0j4pCP+biG8jM668hnt1jtRNMANa2DMX6+9ADc4R3tZxdprUQ6d9uzqUtThPLsCWRplA2snQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9405.eurprd04.prod.outlook.com (2603:10a6:20b:4db::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Thu, 18 Apr
 2024 16:04:57 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 16:04:56 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 18 Apr 2024 12:04:27 -0400
Subject: [PATCH v8 4/5] PCI: Add PCIE_MSG_CODE_PME_TURN_OFF message macro
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240418-pme_msg-v8-4-a54265c39742@nxp.com>
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
 devicetree@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713456277; l=825;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=HBrDDEQgS1PwyYGOiWMtqw4UVzX2aAOyF6VHJAfWOAM=;
 b=L2LKw0QvR3Wj+V5JOI7ord1iNS6teTjk7N4/BpZgeOeetilUb0gFpYOny13TxfkRsWV/OCsma
 BumLCt/UpQfCEQh0jrnJ2xP6qpt9sElrPt5Z05cFoB019xrCeifu6c2
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
X-MS-Office365-Filtering-Correlation-Id: da0e7181-7619-4e28-277a-08dc5fc14ac8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	O7FyQ3lRbtnx7cDg8+uI4uecyRcnb3s8PnwmeVcKVKtjydxVonfVMxYpoxdKO9x8oxhhWWkLqK/UgUV/WVWkcBBJn2D9ns2fY66a59BDl1ZruwzWZLJgktR1SKI06mThpO+Y3gbsXTY2sMtcSHhhRlKI4YqetRxZKP8Ji+omtJ6uzHtisvcErimNtGpvwSasdmzektF0Jdq+M17BrpzgCr4OFUPvKx9tgdGSY/IV5+NSJDDRESZ/lj0CA2SN79olQcqwyfQuf2xSk9fGuXkRIGe6RElHYA8bjiwl56ff7kecf5/WCiKOX4UlO/dgzaxQTajfSL4BC/6G+H6RWL7x41S/DEsfisPIr4HYsDQn3TfoHdU/b2I9yTaBI1OLz81H/LneZTrBvzpM3leyGUjW7AEfvp2/Y6OoDc/7mOF6ljN38znE8NW59Y33IYgxecxTI93QvfyYeb5aHEuhDxug1h7kr6FldNvbZQujuwueP1JYmZXNyHBKIQvGK5eMBPmpS4SbpHWMwUBCtAUOm7owfhyp9vbKjbEZjiYBlrTeYgqDucuTp6uOMDbdjEAbPpgTuucK2D3ZvvXV0g2xUcB5VAuHj72S92au0G6HW7ZIezNeWghPxI+GZgan60WjzB0xCWI8ZpmmHTnxZ04SdJuBvCr4/0f40kwBZvmo1rTa73UiWqRs26BvwaA1FjNS1+iJKfX+h8TDXgd01uDso/qLtCSHctJwbXXGvivUrtoyaDU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(376005)(52116005)(1800799015)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cFFxN3hJZmtjV01tOHNBcy8xdVJNMHQwV0JZdjdtemFmNWg0Q3k5M3dRMmEr?=
 =?utf-8?B?M1N6SlZjTXdPMWZsU3dzQkE3UlMwSHlWOG1wRWsxamwvajloeTJ3UGlBR29O?=
 =?utf-8?B?clVVVVIwL1FYV2pwRnVMOHpFSzQ3cDlpOUNuWWpFZ1QweDJHRmhiaExtSEht?=
 =?utf-8?B?SlFUUzlkbnpmVUtscjNCd0g4Qkkwa0M2SGdlM1NyZEJqUzZGdzZ5K3NZMTZM?=
 =?utf-8?B?YTYzSmhwQlRBT2U5cWtnSlN5UzhRRVFGRmhWcXJxTFFVdzRFRGdZY0IwWTJD?=
 =?utf-8?B?TCsrZXJialBnVkYyTEV5ZVhMTTRMa21rME1CL1l6enpNQkQwS29nUG4vczkx?=
 =?utf-8?B?bytSamRocEtCbytlWGRjR1B1aXU3MFhqODY4VzErYXZ3OFVualdObXZQL0hn?=
 =?utf-8?B?ekdhWjhYenU4UDg5NGRCK2ZDdmFua0UvUHRpWFgydzhEenpYMXpoNWlUWUVV?=
 =?utf-8?B?d0ladjdpTCtINDJJeThOams1WUxBMW5tYWNiNW9xOGFucFNib1hYZGNTL0Nh?=
 =?utf-8?B?MnE3Mjl0Qm5RQ3JzS01BSkZZR2ZOby9SazZreHBJMjByc3kxaHlEVTdhdUw1?=
 =?utf-8?B?MDgxRmdpOU56ay9IclpSSVJmb050UyszNlU5enlKeTNuUlA0azFSRThtTEs3?=
 =?utf-8?B?bjdTb2g0RmR6enRGdlN5TXpQWFlPNS85ZTVRRXJCTE1MUEVUZmJKTWhWOG9B?=
 =?utf-8?B?NjMxQUFJRDE4cWJ6RWJHTDM3MDJYNHlZNm8zMjgzVkFkalV0OFo5TDg4Ukpq?=
 =?utf-8?B?NlNEMnpoODlXTS9SdGpVcHBENFdGRGlCUDVVeDdwSkhEeU16ZkMyRmp4VkRJ?=
 =?utf-8?B?THdTQkJlWkpDdnBRZzNwcnJjSFhxRzk3OGVrREhKTlk1dnpHTExGUzBxUFBh?=
 =?utf-8?B?am1hNWN1azE5dTM1cHlOdGxuSDlEWEdEYlpob21WUGhuZmFLamdIenMxZ1Ju?=
 =?utf-8?B?Vi82SkVDOExGWHhQMDJJN2krRjRYQWxpWk1ncVBsamdnaW5uR0ovdmpUc21H?=
 =?utf-8?B?bnd6dFFkVEUzOEQ5K2UzS1BQa1QxNDlrZXp1QXVOQ3JjdVR1TTR4WEZQcGdI?=
 =?utf-8?B?dG13SmVRdUVxZEdZYlZnRXYvMUhCekNFajZrczU0QnZLRWF2dnhwS01YZHR0?=
 =?utf-8?B?bnVTVGl6aWJuRWoyVUl6UEo4ZWJIWHBKMm5wTnZETXVvcEIvNnFwWFZpeFdr?=
 =?utf-8?B?K0ZkN1hobzJCNlhoNVhOdWdpSWJvWXJ6VVVDcjNuNVdWcWd3V3hoMndGZzJM?=
 =?utf-8?B?cUpNOUdIMFVmeWZGY0EyUVpVdGptWm1IMmIwL1AwMzBGeDI4VFhXNXFHaml0?=
 =?utf-8?B?bDB2TTlHYWtCdzRkYXpSUE56ejArRjZUTCs5ZjZQV2ZYc0luN2ZxbEsyRktX?=
 =?utf-8?B?RWNHZHB5RE1wNGo5SzdXQ3NjUmxOWkpsU2RDYmlRbnhSOUs2NFhLNEd5T1d4?=
 =?utf-8?B?emNVUmRrSnUwdzFwQnZQSFFjcHV0dVU1ZlJ3cGJseTBNSnZqd2dmMHZ3eEFj?=
 =?utf-8?B?bm9PS3V6ampPaGd6ak1JRDNpQ0tyejgwc3hoTGtjVTdzazlsWHViUUtkVEd2?=
 =?utf-8?B?Q1FKQWJnWHFnQzBoc09wSi9Sb3d2SFR1aWFidmpWeUIwdTFGQ0MvRVVjVVZ2?=
 =?utf-8?B?Q29ONFRMUStQbU1KWXE2c3U0UVVIMnVzTjU4TEFWNUtTVm9HeUNNaDR4cVlO?=
 =?utf-8?B?K2I5SHdZaGUvUTNmQXlka1R5V2R3djhrRVJnK3o1MzlpWEpsZE5aR01JWXVP?=
 =?utf-8?B?eE1Hb2hxUWExYzlKNmxvM1lOL3NkeFBvam56cXk3WkUzVzZkRkhpeXRyN01t?=
 =?utf-8?B?QnFFeUlZWWZkRDJBTC9iY3gxME5hcUdRMStEZzV4RWdrZExOMUFkSnBXOURn?=
 =?utf-8?B?N3lHUG0yb0FiaisyT0IxblcwU0tNRDdrZjBFbmNiVVk3Mi9Lb1Uxd09hNUJT?=
 =?utf-8?B?MUEzMGpVVzZPSXJHT2ticnNpMGNmUDlkc1dUQXhwcDBWVGRNdWU0TVNXREw0?=
 =?utf-8?B?Ni91SkwwbWtkTkpNZzlpL1BTRk1ZbDNpQi9Ebm1qUjNDQU54K0dUblc0TWlh?=
 =?utf-8?B?RHRmTWVUb0J0TkJWOE80SXV4TllVOHp4dXl0NmZjV2JTMmM5TCt3djdHbEFs?=
 =?utf-8?Q?deauCx5klh3q78xPjQYJ7aHsV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da0e7181-7619-4e28-277a-08dc5fc14ac8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 16:04:56.8849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jo6e75mJ3+c05d32KGbqrFKCn+EJV00g6kyoR8cz6vgDlqqx+LQ1eQYJS6yO34BWPrzCvi2AkN9Ec0czYaUCww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9405

Add PCIE_MSG_CODE_PME_TURN_OFF macros to enable a PCIe host driver to send
PME_Turn_Off messages.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/pci.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 02f46875fe2d9..36381fc7ebd32 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -30,6 +30,9 @@
 #define PCIE_MSG_TYPE_R_LOCAL	4
 #define PCIE_MSG_TYPE_R_GATHER	5
 
+/* Power Management Messages; PCIe r6.0, sec 2.2.8.2 */
+#define PCIE_MSG_CODE_PME_TURN_OFF	0x19
+
 /* INTx Mechanism Messages; PCIe r6.0, sec 2.2.8.1 */
 #define PCIE_MSG_CODE_ASSERT_INTA	0x20
 #define PCIE_MSG_CODE_ASSERT_INTB	0x21

-- 
2.34.1


