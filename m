Return-Path: <linux-pci+bounces-24902-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A03FA742B0
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 04:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33298189E35E
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 03:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C409210184;
	Fri, 28 Mar 2025 03:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Aj6x5hzR"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2053.outbound.protection.outlook.com [40.107.249.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E916E20E338;
	Fri, 28 Mar 2025 03:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743131030; cv=fail; b=dKT7+3UeXO5jfLdZjXdwwOWauR28HmLoX6ESwSY8elD1cMtrEHL+hP07+NG0bGsVlEc9JyK1fdE0SETuHi91agwgPeP7h8hdwJnDztg8s2vSMIF/rn+aNQ1JAk0F4fN748Asd6hVfW6ETyigai2SFKhIj/ycpj6xaQ4AEciGaT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743131030; c=relaxed/simple;
	bh=DFqqs0GqRXIRZCH+GyjtuMsUXniFCYnbR3ZUPcJHbV0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uRByuJysh7BWi60StXKkAHPi6rRh1ItF8uB2da9ZI8fmSVV0ZvAxhuA3U/+3aisPXopavejjwhDVWvGQf4ixD27tlta65741wQGKQ5D9aiX54AMtiBvgvPVEkV25KCVy00RyR6FiemIktQYmvRk8cnhAKEjIRRAgikpPw9OSxPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Aj6x5hzR; arc=fail smtp.client-ip=40.107.249.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vL7lDo4573K4ZuTZ/IpEcFPGzrt4zKt2wKG1ZQm2AMYt19/kZgZ4VTSTvjW3DhCFEAWBHwoepbcbx6tVNRjPUycB62G+fB7wBj+b1Inev/+TfTh4Ldy/W+XcuDcilMuirskLvHTQnL5iQQRXy0zBzTbxZwwG2Oi7c++pbWNWA4rCNi1RNQQ+rIeL0k1xa8HzQaFxIh1FakaRGxoBEOPJuCSkwDkNRGsarbiB64ZE3mAZLqbRqUe8Hsftr45qp8MKYrwPB2B+g4GiZ2vAXzPY3MRNAH6fkykdZjmSz112L2Iki7tWx/lpisRVlntqP2L34paeLjymm1XKNdPvgBoJJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3WnF5MaPL0vkEvqmEIuMdyzOkw6oxR0mcwbchi+5rt0=;
 b=TwS+9OnHUwoE0TmYeIqtIIIy8MoDNC5cZz1+CQvq2x/baQUvx4gIqy2CBi2aabGuUHKwCZpeqpFFes8AFh6mV35C4Dz5t1c2a2b8VoWlSuB01UMxKiYQ+Jx4D3i2o/9HNtJpEMrUyrDgUsQb2NUDie4JYE9svwVMJwSZW5wfBDNr3Y8x6cFh1BVjOP6fWr/E1le/GfeiZU5M2m0dymT1FmBL2gWXZa6Bw8L5p1417Tdw6/68YgHfCEOz6yKytiEkxXyf2NCTwcC+C6EqbNGMJuouvgafYiwLlB3IlIgDlfq0HJ38fWjIc1G1TPrfjtkpa2rW62GEwqmkhWOFej/86Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3WnF5MaPL0vkEvqmEIuMdyzOkw6oxR0mcwbchi+5rt0=;
 b=Aj6x5hzRYsL0iTM++i05dqcm+hPv8wc29go+WrMjISlnRLEh9o6L0I3Ccuh4yb1ux947Kh3nxJ9WjT+dxjIPjjF7zPcmugOow0PN8s5HuCjyNi7wqfxe7XV4tVl9KmZfUGCo0mbY1OO6YjI1/kjhKx9AjyFzHrzrO41iTu6Pn+HJ2hITXcjLvf6fXiHZ25m6G/pUmeoU+mWH5vEeYcIDS1ARtfVS8veM5JiGzWyYW/lRs7QkeEnKZHcrYN1xXeF+soEHu5ztA2cgAqQ/b0qR9nfZ7Pdg0kBpzX+x2mqDt3v9CodlXgNHSWaW6PAIeJPTCNy5t8L+9DGrNI8HSGRYJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8961.eurprd04.prod.outlook.com (2603:10a6:20b:42c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 03:03:48 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%5]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 03:03:48 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	bhelgaas@google.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v3 4/6] PCI: imx6: Let i.MX95 PCIe compliance with 8GT/s Receiver Impedance ECN
Date: Fri, 28 Mar 2025 11:02:11 +0800
Message-Id: <20250328030213.1650990-5-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250328030213.1650990-1-hongxing.zhu@nxp.com>
References: <20250328030213.1650990-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:3:18::35) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|AS8PR04MB8961:EE_
X-MS-Office365-Filtering-Correlation-Id: b684d01e-40c8-4d03-c203-08dd6da528ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QbqgTWeJhcs2+0VlH/Mu5BhsUm3S7sjzqnAl7pB4Srs+ELFjj8qf+/JHemWh?=
 =?us-ascii?Q?vyG/IBRq4Y2ZA0GhqopLyDbz3pmBp5zW6jfrdlet+JZv6MmYsGjCjtDz3E9e?=
 =?us-ascii?Q?S5p/3FynWjcOUAtBucI+/BUU3Fg9YQZjK6Ut6qNsbYcyZCYYmCuAaBVK/kaE?=
 =?us-ascii?Q?vbVUZk2DXU3T2GQLac+46uYgaFw2ZhFxGr9TrOaoQ9U5xF8ffyOK3SXV0pZN?=
 =?us-ascii?Q?kS8F1sCwl5xJgkQJ1M2uCkkfFQWBQGhHdQjmy27SUx1246k6N3/aUIyKUtT4?=
 =?us-ascii?Q?ytZP727i5A82t07fo0aurrIaeXOC4nKXiHYvPkMSTYKIkrX/JWiEnhFWO48g?=
 =?us-ascii?Q?EHj7KTPUhVWvlfnrY65mcbkg7GyTGtapWb++YgtPVvYWooJijfp/fPc+xc0k?=
 =?us-ascii?Q?9YmDY6dBMZdzReW92VDInUiHA5Xse06eGZWOI0tKvzwlri9oAIS4RqAegtO0?=
 =?us-ascii?Q?KJhON2jkjXF9oA+TmfgvJKGL3tMYkx6XyyAdByRnVLq9Pgxsl5w9TRfwfteE?=
 =?us-ascii?Q?aF4j52C+NFMupZINAW0xUPAG8B445uAYJDXXbtZ5ET5ztTGTzFtcUZ9AAyll?=
 =?us-ascii?Q?CKrjc5/M99fsXQsoiatynFgfYBVwKWT/PCR9wV6p8gOWDN3rmE0/66hfSvPe?=
 =?us-ascii?Q?l1W2FdBIaPIxSSQUPKbGCi0qd5QsF30Odo+BcCWm0xzFTyqH0nRUPvo3im5y?=
 =?us-ascii?Q?QhmUxuX0gdDW6BH6sl/c/+gCnZjvAQxyGFKv/RdKS1kvewjVm2tE9MbCPJX1?=
 =?us-ascii?Q?CfxglpwY2KdRGncR6ncANbLvtSZVW7DMNHK4CSv01ZVevVQ9tTmIkmdFMR38?=
 =?us-ascii?Q?Wwmvr61BwLZCFAByroA00Fnt7yxfxrn9QBBut7G+OiyGD/EhH+JksY2lqiF+?=
 =?us-ascii?Q?rf7+FmzDl7LRxXvhljm4iMFArPNQfTf+VfZCtx6N3BaqPJyzZ1EEkXOGwzoI?=
 =?us-ascii?Q?QM8OjptxQNcAT4PEL/pguuvVLBSqTI/JsJQejUfn75uPTmd6940JslPTbDIr?=
 =?us-ascii?Q?elhWoakp63b+1Sal2fMOyUrRoMdGtey4++qw/namk72AWLGh1R98iFHcsbMZ?=
 =?us-ascii?Q?b6BFU4Psuq8ZNZmrayrzeqUYClwCctYXDLn+qZZj6H6xtd5XHUBKWodXypAb?=
 =?us-ascii?Q?Zr+7KDvsX34/8frwXze1tEwWBPtYUPX0j6dtc1ce3Adil7l3WxUSK9ZNlCjI?=
 =?us-ascii?Q?+5kKVnzO1KYHJcbN0DTI2BjRifYCk9SNVCXVAkDaIdsorANZQm84bHINnsfY?=
 =?us-ascii?Q?YcJcamYZ5if6bJsB7JhdlBJktIpYpTRbvGBkXBfNpruyebIC8pEgC+e6hCjN?=
 =?us-ascii?Q?vCwg4Kf8frRo2gg58APT2RCiJcV/Mn3rMdQGPYk1j93vw1YC4mHgjZ3yQLHW?=
 =?us-ascii?Q?L1Q1bQJUw5nsaRhhUIWlNfBPSGndBQeelFsB6q23tdJASnQK2HZKaYe2yg5R?=
 =?us-ascii?Q?c9FVTJZEzdGPhVC6oxw/gfhKUaSxgwXbgKAOAf5V8TE3pPulWPKxKA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n8nxeOeitizUlQEjAUMh0FHZxVEHjCL4ijHVUyh9uQy5FW6fmBZ3AF2ByrkD?=
 =?us-ascii?Q?Y3ha5Ygyl/ONsJReTWFlPwGihS57bGSdnB9qAH6T4Oa4YouR1yAbmjSOSIac?=
 =?us-ascii?Q?pziVLlxXuXyv8/0ZtMlg3CSgOEiTXH8/HK4O71iIeYaiGBptIX0QYfDIcvR+?=
 =?us-ascii?Q?fy09kw4xHBYJi75FlK9BPVROWw0cifL+yOk6jxLWoVUERdtk/iJdjuNb/z1c?=
 =?us-ascii?Q?rXZsjWSgKABcZ0ELzkqbWjQesN4/IBevlHsS73cu6KB6sZs9zT2WWWNivsKL?=
 =?us-ascii?Q?cl+9nfFzELzqSlSML94KqTRZzlD6T3zYRMQJSFqwOlDYYZ3pdfBVobs3v2nx?=
 =?us-ascii?Q?2AH3t1/5tNMaqTYuQN0vBohSK5ZSVh4vh/jXVd2pYqju9TdPPa7ZCXbYGGnh?=
 =?us-ascii?Q?vJnxpd5tWhZ+NnrvGSL74yQuZzav/smXPLXsY68TnIAQZ+28awtT2PlKsnJ2?=
 =?us-ascii?Q?RKYzWYw3keqiuArK0aSgBV3Txf0Hevt9vautICKDXOqzeDM37+m3gbE7bgBN?=
 =?us-ascii?Q?r6Uow51rowpBvAaWKtVWNKK2xTqS4+dEwhCzFKjcfwcO5NsHOiw0YFLxJl9J?=
 =?us-ascii?Q?Pec2TnodtH3Ra7zkixXA0xDCG4jkKOTpJh8E4DyS6+/UIhguR0+yu+IpjOu4?=
 =?us-ascii?Q?cWb2p7T8X2bm4m5AJMtLPMXVaDDJNGeVQ0BI6fnhsIrEN9IGRfNglTzo3tl2?=
 =?us-ascii?Q?dN2ds+8g7rU6Kl6n44mtjML9HebSqnpTiOfNID0fiKii/Ndm5ZW4DieeAxFq?=
 =?us-ascii?Q?7YUrv13AgnJSGV+QWmr2Z2GOXJEMl28hgnTHBDkeSihfi2D+75dZgIThlBFt?=
 =?us-ascii?Q?neiVlhr6ycV+E8bUwIkdqlGZvJvYvkA17H+D+e2m3aA56SfjIWxbwXkbYjE9?=
 =?us-ascii?Q?gXo8YKiXL1hx3aKpsM2jGkC6mLq1almL7RoABwMilZAqBWUsdgwPspWbdzFW?=
 =?us-ascii?Q?B0BRiphANn0M8ly2q/l/LRmMx7JDwjFG5qAD82k7k7MbuP9qOeXQftTOkJwm?=
 =?us-ascii?Q?v3xIFZr5VEWfW6kug1uOJWZa3kZswYDRIUqSKm2HsghURjcK/X1awt5dsh77?=
 =?us-ascii?Q?DTnpC1ePc6/3M25yXGWQFR80Upp7Om/nxjbSBHpdX206xPs7qyVDpm6jUPsf?=
 =?us-ascii?Q?yfl6RfjiZbIzny/spvWAdtNeSpS557vzZkupnG4Kat2D8Bz9Swsfw/tTbrnP?=
 =?us-ascii?Q?PQTxeCkTXIlcLVireJcCyf/f63sjAM6Eqi71cF2QdH8h2Ge3GEAk73b/EDgk?=
 =?us-ascii?Q?LkksFhOFuLIsEHZn5UKxxiCspKsfAMEJaj+J2pCXUC0uYakkS4T4ebz2cslk?=
 =?us-ascii?Q?BGWPvAdJ/b3AiMaeJVzVsI+RvzRhYDwEr+Rakbl6DIP6WuFqxJrEhXVAVV8c?=
 =?us-ascii?Q?Y6cOycgp3qbnyDhfGnOaFKV1r/a79bzKl9K6zH8GML6vSU7jtPF7urU8ixPx?=
 =?us-ascii?Q?gV4woaUcvvLEnfbllFHrfKXj86TZWeKgBPgjbxwY3uiRUmcgg6BvV2yKtSkp?=
 =?us-ascii?Q?JYFX+A2ewA8Qc/OXkAP/M7FptJDxKcyVXvl1EnrbIxCNTixfMYPEz1VZogu0?=
 =?us-ascii?Q?vEt33U2soVch/LiqOZnCKKG36K2IDkARnoECCph1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b684d01e-40c8-4d03-c203-08dd6da528ef
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 03:03:48.1898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7OQQPDT3bkIuNOEdrKiYrVZUAyUhjyDdAj48D51TUcg1tfWCgaaFsD3l/fNXi9xJxdKiJ3Q/N/Zmg5/+2WobFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8961

ERR051586: Compliance with 8GT/s Receiver Impedance ECN.

The default value of GEN3_RELATED_OFF[GEN3_ZRXDC_NONCOMPL] is 1 which
makes receiver non-compliant with the ZRX-DC parameter for 2.5 GT/s when
operating at 8 GT/s or higher. It causes unnecessary timeout in L1.

Workaround: Program GEN3_RELATED_OFF[GEN3_ZRXDC_NONCOMPL] to 0.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 31 +++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 82402e52eff2..35194b543551 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -110,6 +110,7 @@ enum imx_pcie_variants {
  */
 #define IMX_PCIE_FLAG_BROKEN_SUSPEND		BIT(9)
 #define IMX_PCIE_FLAG_HAS_LUT			BIT(10)
+#define IMX_PCIE_FLAG_8GT_ECN_ERR051586		BIT(11)
 
 #define imx_check_flag(pci, val)	(pci->drvdata->flags & val)
 
@@ -1263,6 +1264,32 @@ static void imx_pcie_host_exit(struct dw_pcie_rp *pp)
 		regulator_disable(imx_pcie->vpcie);
 }
 
+static void imx_pcie_host_post_init(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
+	u32 val;
+
+	if (imx_pcie->drvdata->flags & IMX_PCIE_FLAG_8GT_ECN_ERR051586) {
+		/*
+		 * ERR051586: Compliance with 8GT/s Receiver Impedance ECN
+		 *
+		 * The default value of GEN3_RELATED_OFF[GEN3_ZRXDC_NONCOMPL]
+		 * is 1 which makes receiver non-compliant with the ZRX-DC
+		 * parameter for 2.5 GT/s when operating at 8 GT/s or higher.
+		 * It causes unnecessary timeout in L1.
+		 *
+		 * Workaround: Program GEN3_RELATED_OFF[GEN3_ZRXDC_NONCOMPL]
+		 * to 0.
+		 */
+		dw_pcie_dbi_ro_wr_en(pci);
+		val = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
+		val &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
+		dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
+		dw_pcie_dbi_ro_wr_dis(pci);
+	}
+}
+
 static u64 imx_pcie_cpu_addr_fixup(struct dw_pcie *pcie, u64 cpu_addr)
 {
 	struct imx_pcie *imx_pcie = to_imx_pcie(pcie);
@@ -1304,6 +1331,7 @@ static const struct dw_pcie_host_ops imx_pcie_host_ops = {
 static const struct dw_pcie_host_ops imx_pcie_host_dw_pme_ops = {
 	.init = imx_pcie_host_init,
 	.deinit = imx_pcie_host_exit,
+	.post_init = imx_pcie_host_post_init,
 };
 
 static const struct dw_pcie_ops dw_pcie_ops = {
@@ -1403,6 +1431,7 @@ static int imx_add_pcie_ep(struct imx_pcie *imx_pcie,
 	struct device *dev = pci->dev;
 
 	imx_pcie_host_init(pp);
+	imx_pcie_host_post_init(pp);
 	ep = &pci->ep;
 	ep->ops = &pcie_ep_ops;
 
@@ -1812,6 +1841,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.variant = IMX95,
 		.flags = IMX_PCIE_FLAG_HAS_SERDES |
 			 IMX_PCIE_FLAG_HAS_LUT |
+			 IMX_PCIE_FLAG_8GT_ECN_ERR051586 |
 			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.ltssm_off = IMX95_PE0_GEN_CTRL_3,
 		.ltssm_mask = IMX95_PCIE_LTSSM_EN,
@@ -1865,6 +1895,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 	[IMX95_EP] = {
 		.variant = IMX95_EP,
 		.flags = IMX_PCIE_FLAG_HAS_SERDES |
+			 IMX_PCIE_FLAG_8GT_ECN_ERR051586 |
 			 IMX_PCIE_FLAG_SUPPORT_64BIT,
 		.ltssm_off = IMX95_PE0_GEN_CTRL_3,
 		.ltssm_mask = IMX95_PCIE_LTSSM_EN,
-- 
2.37.1


