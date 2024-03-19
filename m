Return-Path: <linux-pci+bounces-4902-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 206C288016C
	for <lists+linux-pci@lfdr.de>; Tue, 19 Mar 2024 17:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CABD228314F
	for <lists+linux-pci@lfdr.de>; Tue, 19 Mar 2024 16:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE6B81AC2;
	Tue, 19 Mar 2024 16:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cD3e55Uz"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2078.outbound.protection.outlook.com [40.107.15.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A1D81725;
	Tue, 19 Mar 2024 16:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710864448; cv=fail; b=BAlg1pl0F9EOTJoSTRwhKA2Wx94OGNQffltXmtOuekRFnywJc8tQzOi3XPXmTQ3UD+bMlg62gj9FXWHJv+CZxRWSZSkDC5pZ2W3C9BgDMiyUjNmVrppPJXvpsdjSFIOEGIjf1oOhjg2pLsPTX1bHzRvt3JnjBncZfVqWisUCqiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710864448; c=relaxed/simple;
	bh=2ryMSn+7oWVdWbaSqBP0ADpPZJzZOgdyFOobfKXU/2Y=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=esz+8+AsdPN49qK49nIszwzCh2VyHYMpKZbP3wLv0D1H/Eota+QjxPkJnsFQ0oHQD0TIWxk/CpivUXtEAsGNKWGcyX0mr53TP7OdzP8HZiyOKA7B7T5nlO/RAH71xxdPckRBzrbgSr83crVlbzUo8BhBhdaEhHevhxfyuZ65M5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=cD3e55Uz; arc=fail smtp.client-ip=40.107.15.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YCxFHexyDyJDYIJDnETaZ+7cSUGs3XbMbzWDARZx7lNbZpRuOzx1bva3ljditqWTrkpp9phE+54qoM6Zrq1POQz8t/xU2tDFQVvdi1QxrF1gEEgCIGKMTgYFIQDlGzfB8+TE1UWWtnNeRBb1yf1cAAIeVhBIUA6jDhVQcM4we/JifQ/hDtS7GBL7ef3nrlyN3ZOZKldJXW0J7vm1JztAZ1WGfx0XkW+WC7dHBJeZvoM5mSMDyVDjmf0ImWrc2yyZIJkYpS/SoYDoOZ6s6wgzWDQdyaPlr7G0Mv9yrDighD0w+A1oZt0zgqpxK3S3Z/tQNn1QG/vaa4xsK7myXIkGCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/j9LMNuY8Cie7KYHeJpRADBHByenFKKikBZEbSU5P4=;
 b=l3yzsEFUfhORrfikGR1uVh45bAhKWjKyfz0dWKLveYon23TToDkfzvjs0FDsolvqC98zuwQIT/ejXTRrM0FxUpquSCOJ6HSMIS0ndKWWgnf5aLXyqMWC93DXjxFGrB2yu7xD917CPvo34zXeEEX0FDLL44x/tAXhI/qnNX5hsMVknbq8JJw7QTr/wluUVDVudZ7bl14j/QG+ZpUh4uloUD0AL5ZC319+0lTVscgPo7t6dfVI+z/VEJWuWNsdAaR4TCebfWtHRkvxz/j4gKyS8QrpK7AJ7nolsjwsEOZIasE6zAjzOCDxHFFmi5v64ehLpcT8D764ReZwcjq4qbh0ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/j9LMNuY8Cie7KYHeJpRADBHByenFKKikBZEbSU5P4=;
 b=cD3e55UzlSGFdEexALe2tOZ837V66101ErCiL86WhUbIvOai40xqT3svAWpfQVuveB95btIVvsCDLivr+6Rvetr0gMnPn5ZrWg/oNLsntppnshvSSIQlNzEJaQfylIKkZJEM1ABhZwI+UHp5dRLqjNG1BmtLxbVZAFMoCn2tYIQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7772.eurprd04.prod.outlook.com (2603:10a6:10:1e3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Tue, 19 Mar
 2024 16:07:23 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 16:07:23 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 19 Mar 2024 12:07:11 -0400
Subject: [PATCH v5 1/5] PCI: Add INTx Mechanism Messages macros
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240319-pme_msg-v5-1-af9ffe57f432@nxp.com>
References: <20240319-pme_msg-v5-0-af9ffe57f432@nxp.com>
In-Reply-To: <20240319-pme_msg-v5-0-af9ffe57f432@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710864436; l=1631;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=pajLHGu+pjoI9EU+H1bgcTzMS64qjiDozYPsqoeYdBU=;
 b=SE6AW7dYycxh9+7spGycHPI+NjYDtO3Sn/mBgKiZU2EXshOBv2pKH+djRyDQ8ce176dZzPdC4
 NGdRbvrQ1D7BmU0TrugA+Trp6hX0DmRba4zpOea9b0ka5X3jLaHP1VU
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR07CA0104.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::45) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7772:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f5025d7-e973-4c97-af08-08dc482ea9d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	48J4fC1DiCZwn2FtI2yl4Y6VmWNYuQqB3OmSGJFskOQHQ6MoDmB47o4DKaVi9mRGfRPClt2SN65YYVZPZ3eTqemfUOO9KaZHjc98n9Qoo65ahNcrR18S15p6dPOutHDV/KHEZyCEl5T+nnF8K06i8EbdWjhQ4YSU4hs8csbplhHDVXqeP0QeBK5QyyqeErg1zMvyClGnGBMea3VwiflzPREkDupA7kflx5wjGivT6K324iHkI16d6LBNqPqmU9bX0rKH/D1fy4AW/WvvQXvNHfJc81NmMUfyOYVH44fX9/fqpiXBOHR9K8UOR7dMsBGCvwUIPOeYrFY1qWaQpWgMpSy+nCS+K/3MiW3d9oyCW3IAlsiP1hD9uzlTmB1ED+ThtQNgVfuIN3tTwQFplm0LuaghOWbRprWWJ1l3jAKUAMW/wzGB5C+Mj1/3nxlTOC6fr4sBYlXPQqG5BGhVl3ZmkekHFg+SLOnmDIAkNcq8CiNHnHCroeU1zXHLyrAaH4wH4u99Pzo7DUotVoTaDfrU3BffVmf8fsDVj2coyjaU+1g/5DsPzO0sCJkO1qqdBnRVkCpP+uLs0zOQpsxpsY72yqxLC3Ajyy4Hg8/816Fw8UQZDM/0oZz1zTdONe7OXPj4e9SpRg68CucQHBAk0/thGfwHTMgtEKL/wQcswcLV42ePaTA/ZvMo1SfOLd85n8JhwhH/DRCqVi6U6AMNXRk6JTKKGmGeCrR+dNmp5akds5s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(366007)(1800799015)(7416005)(376005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0xkNCs1Q1dtVzB2UDdjZ1BKanZzcDF4Znh2bHVlMEZIQlNTTTFQY2loOGpv?=
 =?utf-8?B?L2h2UmxRbXp5MWhIdXJHUGM0UUFNN1FPL3IweVJUVEd5bkRLelkyS3dCWHFp?=
 =?utf-8?B?ZnVHcElIZGMxeDJoVzJkNkY3K0xLYjI1RG9MeEl1RGd0N3hmKzlObFlCQUk1?=
 =?utf-8?B?K2Y3MjJvRG5rWVlNamE0dzlYWEFHTk1QMWFkMEJySnlyZjN0NTZxbTFNbWRk?=
 =?utf-8?B?UW5CUHpvMTM0MmhQKzRsMGRvU3hna2JGQWs5bEE1KzE0UjZmakFWWURSWUo0?=
 =?utf-8?B?cnlhMkE4TFg2cTJ2M3M3NEhVQ2VremRyUjR0N2VkbzBKYlBDWkl1QTBZeHRq?=
 =?utf-8?B?Vm1VUjhVblZpRlljSVVEWVlVT0V0KzJzN1FoNCs5NS80eUYrRHdLaXVWRkcx?=
 =?utf-8?B?bjNSRW9TMWlSUitXY2JvTVpINXRMN2NmS3RCbVRBc2dlUklVMEkwKzRsdTZL?=
 =?utf-8?B?WXhEaU44TURmYzh0L3NORTg1TW10MkFVQ0YrK1Y0dGVlYVRsTnBjZzVjVDFX?=
 =?utf-8?B?YnVYNmVUZ09jTHFyU2hhRTdVQnFhTmJSMGpyVWlnazk3c1FqeHJ2Y1RDSmNp?=
 =?utf-8?B?WmlpK29oU21GR0xIemFabG1vSlFOUTkrVFdtSHFnaCsvb2lqT0hHcm02cW9Z?=
 =?utf-8?B?UHlvaGpJME9NZU5VM2xqWm8vd0FPSjE3YVNaR2V5Y2xvcFFMR0lab201L29s?=
 =?utf-8?B?QTNNMnUxbGZ0R1dMUnhSbmtsQXFUbVdybHMzUWdsS1FNSWI4bENDN2hMUHND?=
 =?utf-8?B?MmltcUhwT2N6UXlsWWM2Z2tkdzlTVlJ3S2FDSmdJMGtCSnFDbEhKcTVQUTZG?=
 =?utf-8?B?enVObnp6OXNXSlpUZ0d0M05vOERrK3hHaFRzRHIrQ1NGWmFzUTBXamZLSWJW?=
 =?utf-8?B?bzlKNll2ekJVVWFLeWhIbFJlcnk2d0UxQmxwSmJFNzAvSE9ZOWtmak4zZG0x?=
 =?utf-8?B?WVFndldUWGhGbHhpTEdtWnFPa1ZWNTRWSXV6M3RibHBYd3dzSllBbXA1dW1p?=
 =?utf-8?B?bnNPYnBTQVRndTRpRDMrNWFyejlSZ0d1SHFLNkpIY1dydUlQN1QyMXFJYmI1?=
 =?utf-8?B?ZjExQ0ZSR1NiVy94My8yWmRSMkhEemRGZXdUTzVoNjVkZHBLSWlBbCsrR3Q1?=
 =?utf-8?B?NkdmOTRlaVdsc2NVeE4vL3RKWSt2UUZ0dFlwZ2hZWkRHdXdjVmI2SG1ybGRk?=
 =?utf-8?B?SG9wVG1kYzFMMlVWUEdCdWN4M1pONFdWczFOL3lZNkE4akhzeStQU3kyK0RC?=
 =?utf-8?B?V2h1MWUreWp5RG5mem4wY1NPSXhHZGk5QVM1MkRyR1Q2b3BtdXlwZnJJSjhJ?=
 =?utf-8?B?Mm1tZXVCMktDOE5nUHorMkdHcjdSYldLVjdJQWVpeXNLdHRJbitCZlJHMHpL?=
 =?utf-8?B?MElINkVwcStDWS9INmZCTzJxWDNNdnRhNXNkVlFleUNJZWZQQlN6U2JXRHRv?=
 =?utf-8?B?S0Jjc3FLM2RwV09jL1A3d29zUkdBRlVDdFVDTHVUSGxrOTVrK3hxRjhoTHZI?=
 =?utf-8?B?MjRicWVFYVdWQzNtZGdlNExLanpxL0VtZkt3akp1azhMV1BzRE5GK3U3a3Nx?=
 =?utf-8?B?SmxBRm15Q2ZrOHhoRk1xY0ZqVDJubHpXSWtvWTMzL1pkaXJXT2NYV004MzIz?=
 =?utf-8?B?SktDdTFqVUFBNkFxZERhVFIxTG9qOWFOOHhTVk5NY0w5Um8vbTBSd3l6eWhV?=
 =?utf-8?B?OHRGWWJqdDFYSnQwRnd2djBqMktzZzc4endaTFNpNHl6MS8xWitqVDRMTDF5?=
 =?utf-8?B?ODU3YkExQjRMcDAvODJ4Q1BoQ21aSEFmOTM5VXNOblYyMEdwaDk4VHN4bzY4?=
 =?utf-8?B?QWJCdUpiZVp5WjdnNER4c25NMkE3SkxPSHVDZEs4QjlGTFdUcHlIOHFNRHRM?=
 =?utf-8?B?Z1pWOU5HdldTWkV5bm1kbml0N1VPYWZ3aXZhVnArZFpFaGlrcmpBNXhrUU5N?=
 =?utf-8?B?ekhPa1JJSUt5UmV0VXRrSjEyalozOUhYd21ScSs1dGdaTkJDYXEvcy9UcXZ2?=
 =?utf-8?B?OVpGR2ErRHZBdUdJL1pXM0pWRmMzbHdkc0VPM2dlS2Z4dTV0WGVrUnVVWE1J?=
 =?utf-8?B?T004QTBuSW9RMHpyY2NaazNiaU44NFZTSDlYcXZkMXdQUkdLQTZhVmUvUnlZ?=
 =?utf-8?Q?Hnurx28WNewwufjUCaPxuOZxi?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f5025d7-e973-4c97-af08-08dc482ea9d6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 16:07:23.5828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VMKFD4SYzFF5fgSDtHyLDHyWFw0y+dE91w9Erxt4jDal7F3e1KjehY3Of1cJSyKzLRVo3QqY8ypFrr7rpDIksQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7772

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Add "Message Routing" and "INTx Mechanism Messages" macros to enable
a PCIe driver to send messages for INTx Interrupt Signaling.

The "Message Routing" is in the section 2.2.8, and the "INTx Mechanism
Messages" is in the section 2.2.8.1 on the PCI Express Base Specification,
Rev 6.1.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/pci.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 2336a8d1edab2..ffd066c15f3bb 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -22,6 +22,24 @@
  */
 #define PCIE_PME_TO_L2_TIMEOUT_US	10000
 
+/* Message Routing (r[2:0]) See: PCIe r6.0, sec 2.2.8 */
+#define PCIE_MSG_TYPE_R_RC	0
+#define PCIE_MSG_TYPE_R_ADDR	1
+#define PCIE_MSG_TYPE_R_ID	2
+#define PCIE_MSG_TYPE_R_BC	3
+#define PCIE_MSG_TYPE_R_LOCAL	4
+#define PCIE_MSG_TYPE_R_GATHER	5
+
+/* INTx Mechanism Messages See: PCIe r6.0, sec 2.2.8.1 */
+#define PCIE_MSG_CODE_ASSERT_INTA	0x20
+#define PCIE_MSG_CODE_ASSERT_INTB	0x21
+#define PCIE_MSG_CODE_ASSERT_INTC	0x22
+#define PCIE_MSG_CODE_ASSERT_INTD	0x23
+#define PCIE_MSG_CODE_DEASSERT_INTA	0x24
+#define PCIE_MSG_CODE_DEASSERT_INTB	0x25
+#define PCIE_MSG_CODE_DEASSERT_INTC	0x26
+#define PCIE_MSG_CODE_DEASSERT_INTD	0x27
+
 extern const unsigned char pcie_link_speed[];
 extern bool pci_early_dump;
 

-- 
2.34.1


