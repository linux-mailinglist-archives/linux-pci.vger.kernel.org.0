Return-Path: <linux-pci+bounces-3025-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6D48472BC
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 16:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A1E71F24BB2
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 15:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF251468E7;
	Fri,  2 Feb 2024 15:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CASSWEq+"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2078.outbound.protection.outlook.com [40.107.8.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4062B145B39;
	Fri,  2 Feb 2024 15:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706886714; cv=fail; b=AjON/JicaDphjBcc91aFarDSO9pksD0dIpOlKfFYbvXX+zKS54x8cWyctmMzlzNHJ2Pj5IRZsthxmyb+tmuMSzocVOmgCXNQrkjxGuv4lfCz9yMFioj2AIrIojbsvp9+bT12rBor3FfmyMGZrPgl7MuFCzf893y5xrvEJprf318=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706886714; c=relaxed/simple;
	bh=2ryMSn+7oWVdWbaSqBP0ADpPZJzZOgdyFOobfKXU/2Y=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Vw5i3tdM5/FIvXhD9xZ+WXSFs9BaOOwxUe2NCi15UdGtlbntcXdHduWVG90b4fAFK/sR2Pl93N6A8elP/gfEf+uNaVIjTCRHkh8T2LkqqW6s7NZeQ87GKb5Rrl4NBM3daGajFk1sLcdQ/tNQPbm0vjmyWQ1rmTQPuFwhC1y+oq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=CASSWEq+; arc=fail smtp.client-ip=40.107.8.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SLYckvDzDnWPkcdaeIQHscb+FM+Vf514CLb/wp2cWdGAvpcraMKLANnLWjzQyr0sCjT/QDNNned+3BKwmJHgabwoqTrbkxiT4AfNqAHi+f4EdOnuN5XVSEYr/YZCDw5Hv00eQ+oagerZZzTXBptpEaRoO1Tf04KhvdfSVRmvLB4hCnWcGw78mrg37gu1mBa8RmRHgKtWqRDwD2IMtLx2cwMO58ZyZmdKqqGBqd3Dz3yr2ekxfpUUGNuvMFpRnAVQL0NRbTGOFM4gaIwYpQDMJUIOojKTaxReXYr83AllUu5J3u+xxhY3YeUvxYxBC6o0INF1Mf7QP/hPHbRwx79vcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/j9LMNuY8Cie7KYHeJpRADBHByenFKKikBZEbSU5P4=;
 b=UN2go0SVdS4GozohAWDujRu4DvIbarvfftFVIHpcZ1qUt5YEE/6RITeKtWHD2uCHzbTmBM2tqJQBb3li8mKirsVnY5dbMrP7bLvPXebTLogFWimbnU8LqnwTy+X8zSmVaAngZV9U0K0XzIoUtJX9j3hls/QvJoVAzUUcxxBVaVObIlnQYoktBIdLQp3/XZQ7i/QfLbHCe8DaflHtPVQIHoP4lKsz2ZLV5RkyClkh8PklmzHSg5cLkfHXBss3dlmUeKfhnXv3j+tUsjHCeSNdFnQjTfGuPEsbGCgN83YZOWT8OCeTmGHhnm8obRfX3X34opLQP6yF9Dq3ExuLwLiBFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/j9LMNuY8Cie7KYHeJpRADBHByenFKKikBZEbSU5P4=;
 b=CASSWEq+7XyBLgAgYmLB82PQe/gHcnfSMvzcNidDzkaLOSa8u0d9ulKQ0YZqzKRzRgKPhvrdlXECx8jhzmql9xYJn2GBV678HT/ljlexoygXKoqT6h5ZiVV2hr0XUcbhQ25AtLCRJb4Dx6jeXCm14iqCQS77h2v6ElB+6LpwhZc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8425.eurprd04.prod.outlook.com (2603:10a6:102:1c7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Fri, 2 Feb
 2024 15:11:44 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 15:11:44 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 02 Feb 2024 10:11:23 -0500
Subject: [PATCH v3 1/6] PCI: Add INTx Mechanism Messages macros
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240202-pme_msg-v3-1-ff2af57a02ad@nxp.com>
References: <20240202-pme_msg-v3-0-ff2af57a02ad@nxp.com>
In-Reply-To: <20240202-pme_msg-v3-0-ff2af57a02ad@nxp.com>
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
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706886696; l=1631;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=pajLHGu+pjoI9EU+H1bgcTzMS64qjiDozYPsqoeYdBU=;
 b=hFWRr08HEZaoxGgGVA30gRhckYZI/12FKHm19mEG9roYrrVXyRoCrS/RDpBXoFkoACnCkToTa
 EmeLwfMvb6WAJeJTkNn2mswbZ8bnJU883IjqSWHBSizFCug9Hcb4WMD
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0138.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::23) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8425:EE_
X-MS-Office365-Filtering-Correlation-Id: c570f9d2-8358-433e-c140-08dc24014486
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BaQT41tjsR7WjDXtHUMmvR6o1Cg4E8RwlmGlwfNMRPPvLOx7fu/iG0c35lkX6DEfWyoVMbUEQuphdfbdIJHjCWtxS8pGws2y7m9JFkt6pLcbPCBpMg2Q47TFsco7S8bIl3jd/bge0HQl2GExbuUwbX1/qQ66Nmsp8KyPv8GKa6bU+Wzrx3ImoleClEaPLns3XKCKwFNA6lfDhHOwE77tXTpBM+JUuXx8H85dg8tgTNlvNl8YFJOf4dzs0ui49Dn6ttdtSvkaUdMrwLo3Q+HfoatKn7Fee6WIE/Tsg1GgotorlPvla6WfaqZ9FQ8S7INAU9QyQdYtI8SPKygOOf2AivfZYX+/9MS5M99wZZfxkKJOPxUk8bRLZqUQAZLsNCSNRwjS3UHxAHVMUFmUNjuuaDEMMd4PFllHFRFl4vwTRUnZq4kSXzxDr288EZDefGZ8n8abGNAsSQbI8X4uCcODwD7HFh9mWNNqRB8pDA1EZU6JH05kF82aFLubLUCyvBCSIkYoIoCjBij5halxvXoJEfpoSSi2nwdmVw6XbmtLGZaULRgPMCEIuQ9HDJbDiqHU3QmjlGdoDoKgLaAolSirXIJ7GufIHWaZU963FPWFyK8Ulcu87+WB8+ZntxO1316hGCcdwaX76g7Iaj8d47bdLg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(346002)(366004)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(2906002)(478600001)(7416002)(5660300002)(15650500001)(83380400001)(921011)(38350700005)(4326008)(36756003)(66946007)(8936002)(8676002)(54906003)(316002)(66476007)(86362001)(6506007)(6486002)(52116002)(6512007)(6666004)(41300700001)(26005)(2616005)(66556008)(38100700002)(110136005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWp6K2RNVEFuOVE4VkdYekYrVW16WFgxRitRWm51a0l1cUFUMDc2bXNOQ05U?=
 =?utf-8?B?bXM3VVJ1STAvcTJPVlVYTEZQcTRscDBsVlA1Y05wZzlzV2pXbkg4TUVoaW1k?=
 =?utf-8?B?djV3RW1iV0tJQlN1Mkl2bTdubkhyTmdIU1kwQkpUOHhBNktpQzRVa3Y0Y1FN?=
 =?utf-8?B?MTFaN3FBK1FYdG1PNDJMTFdsZ3Z2QmxtWXpZSTVMU0NqUUhxR3pxSXlQeWZE?=
 =?utf-8?B?RFAvTjY5dkM0VU5tZXhGK2l6ZmFlU3p6R2ZiK0tqVG9VNEpjSmdXS2FOcXdi?=
 =?utf-8?B?d2g3dk1LTkl2ZkloekJwRUpKU3ZGUTBEdVl4SXVocm9ZUDR5bTNIYXZaSDFr?=
 =?utf-8?B?SHVNNEVVWFBHNUs4RDFuYVNyK3VVZVI2czRUQUNma1gvVTJqbUFZWFJ1VWQv?=
 =?utf-8?B?dzZ3dktwMnl2MHcxS0x4ZW5vRWlBRFRMNjlZV09zNnVIMU8rcjZ6YTQ5VXVj?=
 =?utf-8?B?MzdCNDg0LzlMNjYzMWxVNzBlVmRwdzZyOVZTQ3dLdXAvNElBS1JzdWZjR1FS?=
 =?utf-8?B?OE5MRlR4WFlodklOYW9HeE0wYlRRaDhSMWdpQTVYUUEwWEJXSEpFdStabzJj?=
 =?utf-8?B?b0lXdlNRcFFOUVBhS2d6TU1sM1VnanNpOHY4Q0lNZ21mZUl6UGZ0RkUwZ3dm?=
 =?utf-8?B?VmFQWkdBcC9YaG45N2JsSGQveVJTNmU2WC9TbFdSUHVsNkVnRUFVc1h5ZUxk?=
 =?utf-8?B?L1VZWUZWRDZWbGFtMm9iQ01vRFJnajJ0N0Y0aHpWU1ZlZ1NqZHNuNVR1SFBo?=
 =?utf-8?B?VFZBU3lnRTc5d2RXa2lWMk9PWEdVVXl0Yk9UUC8rbTEvZmE0MGNXakQ3S1N1?=
 =?utf-8?B?WlRnOHIyZHRWY3gwYXlNekJ6TmwyYlNUbHF6eVVGbWxwOXpFTFQzTzBNMlhW?=
 =?utf-8?B?S3FQTFkwUEtjNFA5eStQb2Vaa2ZVTklXS3RqVWVxMUNFQmhQZHcxT2ZndGFp?=
 =?utf-8?B?VERCbWpDakczR20rUXVkYmZHUWladVNtZG05SEdwVUlKd2E2Nm43Zko0aVNM?=
 =?utf-8?B?YlBlQlRIdmZGNmxhNnJYM2lrNWJwVlA0Ri8rbldRWmQvaXE5RmRqYTI0TlIx?=
 =?utf-8?B?eWJmYkpibWZaV0ZiRFNEQVBmRXhqc2hvMThWcG9uNXlmNHZSSWlkL1l3bkJu?=
 =?utf-8?B?YVFrWS96eHJiMWYxbUswSmlJYXc3b21rdXlwYlVxNW5pTG50YVNxd2QyK0hS?=
 =?utf-8?B?dTVLUHFuQ243U3UrOEtwY0E3S0J3UjRacURnRUtiQjFPdW1idkJpTzBGWjdm?=
 =?utf-8?B?OXV0R1JRdkl0TkwzTkJ0WmFCWEJhYVZVL3pGb0E0eWZhMi8zKzgvY0ptUGhv?=
 =?utf-8?B?MExZWWFuemxrVVdtQjF4Y2xLU2s4VmNMYWZzdkRVL3I0bGVxc0VGMnlzMWth?=
 =?utf-8?B?cDNGemF5QVFyUExOVlhBSXQzUHNySklYNFMzWVgwYktSQzMyWHJPc2pmUFVv?=
 =?utf-8?B?TkhodTJsNTdDdWpVYkxjYnJ4RnVOK2phSjhPVjBhR0lEYmN4UmFFdnR3dUZy?=
 =?utf-8?B?dEdRak1XYVN5NklNWUJvYkhnVTY5dmN5TVMvK0haWE93VzljcG1kMHlpby81?=
 =?utf-8?B?WXVaN1VMNlZtdDJqbTVLVXl2Smo0RlAySzRnOU9wOHNXUE8rUG1pS3lzMHlr?=
 =?utf-8?B?ZUhXb3RWTFRXT1MzVUFUTnN4ZFJieDZrOWlQeDZLRjFqdDBwTnVGOU9tODk2?=
 =?utf-8?B?TGo5UlJ1bGpjV0JHNWgzVkV6UDgzQ2NlN3JpTmtqUFYrcjRyU05uVGdnZVhj?=
 =?utf-8?B?RjliQ3ovS1haTVN0UzEwQ0s2TE84RFVKb09WdExjb2hYV3plYjRGL0Vhb0lZ?=
 =?utf-8?B?ZW9peTZmVndOdkY1WGhyL2c5NmpUWE52WUNrZ3JkcWI2L3FrbFlHS01WTEox?=
 =?utf-8?B?M0FEZmxDcXFHSlhPa1VtV2tsVXJERTZlaXRVL08wdVVUVU9QWitoeGtINmNE?=
 =?utf-8?B?UVNsOTk4T1FjNEZlcDZnSDgxRmJqMGpBVDRzYVB6cXF0LzlQVHp5YUFVQUFV?=
 =?utf-8?B?NENJMVJsby9OcElIaEcxbW5ZNkVDSHdqcDNTQUNuV2lLWEZBQWE0WUZRcEpy?=
 =?utf-8?B?TVRoTGozZVd3dWViTEhZakVFQzVzTThqbWtIM3ZRaVJBNS91VmJ2Y3FPMGhS?=
 =?utf-8?Q?KOSus3xZV7ckz0VBu/vGfvgRR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c570f9d2-8358-433e-c140-08dc24014486
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 15:11:44.4872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JCAD4K0JOmzm0jBIe4vFkastik2xhE4YvpFncLsMNB9AJmhV5QsaLdBa/Vn74cccdsECNtfjT6pVcbVxLM1BRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8425

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


