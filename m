Return-Path: <linux-pci+bounces-26628-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E403DA99DA9
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 03:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 232C97AD105
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 01:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2F613EFE3;
	Thu, 24 Apr 2025 01:04:57 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11021142.outbound.protection.outlook.com [52.101.129.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562A329405;
	Thu, 24 Apr 2025 01:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745456697; cv=fail; b=mE8WIBmTBfMYFFS+mjkt8r7KHYlXDlRfSp/CqW46J1g2uKfRUQdf6uUgLURZCQd4jN2Qf7gjzbsZHupGs1qTTNbogHjHsPfHcCIjZKkeZuxyGZPNYxcXn1pGvbNDfkX6Ke9I0busS/Dfhh4xrvCoxlCCEx2I9tBnep8t0kCI8Yw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745456697; c=relaxed/simple;
	bh=NGPMAW6eLu3Yq7Qm19MaaCmUSN+xvBZVbGBbgAcOrg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gaPTNVSVdpQLFttn17Iz6ZSyLlu63pY1gzLXQBloQfFnwToT0iNLWRdsfsxqid5KJYvq/cFRwSb4AqiLR2pTRlPqwnbRnmo7C64qczToeDNm0mIAKK3HgAO2hAVZjpL2LsqSIJN4U40m7Wsl4TFaeN/II+b1ZY3zkrhb3At/Vy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.129.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gO2vxTyd9Mb7Xj5y02uY7xPQfMzxPB84oRwmW4i/aldzcJuDioWCQApGMKietX6b5Iv4Imem6nnDZVzqVYib6p2SW3rGkGbA4DsX4hlg4mWLmoCKGaeo0MvgrlLVfEFPlFEDZSntHMmg5ys1oP38ADySnCbjd2R/6SZ1cXwNCrnPpoeFrMwmxaPuKp+MJ7xji1AYEAbGFYUe+i7NG2wcWEEGXwjiGYFwT5/Ux7A6AK9L3C0+Vr/R5ajiuK5v11L6Nni1KX36rZXbtyN7YikGIFxfYcxu/dbJ6dhZg1j6pCjSdiG4PAf3XYRoYEoEdpGxkxwwO3phe9zkX70mGvEG1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+3glvE11CLib6A6Y6GNBKXC+aUH/szqQdeQERn92T7w=;
 b=ooB5eAc0jKdb/ABLr7t3n1tV0mcGvI+HiqZyD0c/tWDqYVHc37/FYfspeoyNJlUYIUlt2ZTtziDymsCRZrmdNEY0C/e+mobTO3kr7iIanIplNE+9seykGfI3CkI5cqk3S5LAtS97Dzmz2xwJAZKOvDT2yvIbOcSrszUDU4cjdrnbGpkSLUJG0d6XzVqGuHOy6OtA6NDgNSi8X5zTSyFL4mQ0dgitSjYWrix2VSh3Ih3ztVFLuDhQ8+x7PfgVOOnNra6aLCjXyzz9vyMLOfoYviiq+2E8lThAm+9N+XUYS6Ruzc6//DttyfkIFIoXSRUIAhAUg+/Xiwyf8lmaGK7SuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from TY2PR02CA0071.apcprd02.prod.outlook.com (2603:1096:404:e2::35)
 by KL1PR0601MB5776.apcprd06.prod.outlook.com (2603:1096:820:b4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Thu, 24 Apr
 2025 01:04:49 +0000
Received: from TY2PEPF0000AB84.apcprd03.prod.outlook.com
 (2603:1096:404:e2:cafe::90) by TY2PR02CA0071.outlook.office365.com
 (2603:1096:404:e2::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Thu,
 24 Apr 2025 01:04:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB84.mail.protection.outlook.com (10.167.253.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Thu, 24 Apr 2025 01:04:47 +0000
Received: from localhost.localdomain (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id D1E9C4160511;
	Thu, 24 Apr 2025 09:04:46 +0800 (CST)
From: hans.zhang@cixtech.com
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: peter.chen@cixtech.com,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manikandan K Pillai <mpillai@cadence.com>,
	Hans Zhang <hans.zhang@cixtech.com>
Subject: [PATCH v4 4/5] PCI: cadence: Add support for PCIe Endpoint HPA controller
Date: Thu, 24 Apr 2025 09:04:43 +0800
Message-ID: <20250424010445.2260090-5-hans.zhang@cixtech.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250424010445.2260090-1-hans.zhang@cixtech.com>
References: <20250424010445.2260090-1-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB84:EE_|KL1PR0601MB5776:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b33928ef-0ec1-473e-cd7f-08dd82cc0242
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jJ6xER4Dy8/X+hGAeblACohhQtbeG02MCCD540Ok8IWPyTJvfxVHLDdqekNj?=
 =?us-ascii?Q?dQs2B4E8YkBl6T3PEaaubD/AGZRbVrlHMIYIdc9a9M3ymlvSA3NM+v9Rr23z?=
 =?us-ascii?Q?hUHaJH4pu8MslJCf/DQV4GH4UsMDuPC26vHKouADYq4GbRjCd1wmWyCa5JqS?=
 =?us-ascii?Q?jML4y9LGOx/msgDpTuQMdZhk3MpE8jy0cPU6lwFtnu1t5rxTOhaZ+xQLwDgn?=
 =?us-ascii?Q?vHOdB22a1vnaVBACoeKByRKXyh86K5AxPt0pVgVH/ss2WgrKilDMFgv0L3sh?=
 =?us-ascii?Q?g7q58oCejOayvJEZyN1PXeKEbn36TLYM3FiAptkRiGIHBPPqMGkRfRA5RQ92?=
 =?us-ascii?Q?HzVKjuxJJnasdyzNorANjzbaD7UQLUbrSB5ea6eTZq723/Gp8gQCLZcQ99yt?=
 =?us-ascii?Q?Wjd/HGhSZLQ2fqati1UtDm8/cddpnK1n/peqYX+v6CZAZFPLy5ssMusuvIXO?=
 =?us-ascii?Q?I9CqiBrGmfb6e7lj50tY7FsFmy6Mfeh5bs8JHYJgrgeErHJ84xkJWuA9VnJC?=
 =?us-ascii?Q?QeFqnewy2fmEHI0eAjwMXSFvLAuXrc6o1wEOKTAamZGGBrUNuxFwYiEwF+e/?=
 =?us-ascii?Q?onFr+zRNNwhJ+rxr9p8RbZWw0bOGWpLy0jaINeKxG6lpIofH9OXBkjeEY0or?=
 =?us-ascii?Q?j6VmGNZa6TPmb2rD3kMgsAH80AKszXEQbCklJqpXCaxIWkZPw+qR1apvxue2?=
 =?us-ascii?Q?xDskA0keVTVE2KfK8Lnwu6MhqZmucDQw2XNhNuAW1SJNKBHmPTZ7IGzFVY0o?=
 =?us-ascii?Q?xocHpzWi8YR6vrIA+DXGk264cqlbZfpGma3A5xP/lYNxIK085cFsiRK4RuDR?=
 =?us-ascii?Q?ZCAWiUD596p8OCs3rdYKFIIFEc2xx2kX1kotIwdrB3geQnUzNqI/DUENZ/vo?=
 =?us-ascii?Q?sw5B3Pus+CabxwrM/AiH/j3Be3F21foISzq8jAMZBRBdknsVdX6GIgVDeqf3?=
 =?us-ascii?Q?Z0Q4RVZSAw//VfHZdXYVngydEZZvdS+6PGAFPG1K0mgPvbdsL/gPkKsqw5AG?=
 =?us-ascii?Q?CG5zgFqlpY6AMKdfyIETZ88TtRHIXbMgSAx+Y1CCapKRRVdG7oicbG9ycwVY?=
 =?us-ascii?Q?mSIcEzslOEUxZ6pN5Uyq2uiF9soZ2MFtF/TOCQSGnsf625YWgYw3Xk3363FZ?=
 =?us-ascii?Q?9tx1Y/u6sfM8BitzyyLpGNDGaH7Vk/oug3GsTiNrkhdDHXnzEOOSmrkbsArq?=
 =?us-ascii?Q?BkXwy2zgH9xddOzFUjCRugVh1GWF5M3TjWDlInU1htYeioqox/7TbbH6w2/l?=
 =?us-ascii?Q?MUIqpq87dxhkjeBXIB7yXi3dRYoeiu2Z/cbnaKyne0PdYEP9L4AKL3XXiYoz?=
 =?us-ascii?Q?LNSroNYcJhN2rWPXg8/XYEU969eHpa23/LLMsGLNiEkoA7Dou9LcPJyTrEjH?=
 =?us-ascii?Q?2FTyE5skoh3tfnkEi/40e7AITpcv8IYwWIDlYKciiDFfYqVgrQMnAfpMg8pM?=
 =?us-ascii?Q?Qx2hiM20oe1oVOkC99WabJodjtqgh7OmhHC0aVYyd7faL8UrJb14BKxl62Rc?=
 =?us-ascii?Q?7n+m61mLLEsfAnom9e543ugyehvMgd+gTpgW?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 01:04:47.7318
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b33928ef-0ec1-473e-cd7f-08dd82cc0242
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF0000AB84.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5776

From: Manikandan K Pillai <mpillai@cadence.com>

Add support for the Cadence PCIe endpoint HPA controller by
adding the required functions based on the HPA registers
and register bit definitions.

Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
Co-developed-by: Hans Zhang <hans.zhang@cixtech.com>
Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
---
 .../pci/controller/cadence/pcie-cadence-ep.c  | 141 +++++++++++++++++-
 1 file changed, 136 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
index 599ec4b1223e..f3f956fa116b 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -568,7 +568,11 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
 	 * BIT(0) is hardwired to 1, hence function 0 is always enabled
 	 * and can't be disabled anyway.
 	 */
-	cdns_pcie_writel(pcie, CDNS_PCIE_LM_EP_FUNC_CFG, epc->function_num_map);
+	if (pcie->is_hpa)
+		cdns_pcie_hpa_writel(pcie, REG_BANK_IP_REG,
+				     CDNS_PCIE_HPA_LM_EP_FUNC_CFG, epc->function_num_map);
+	else
+		cdns_pcie_writel(pcie, CDNS_PCIE_LM_EP_FUNC_CFG, epc->function_num_map);
 
 	/*
 	 * Next function field in ARI_CAP_AND_CTR register for last function
@@ -605,6 +609,115 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
 	return 0;
 }
 
+static int cdns_pcie_hpa_ep_set_bar(struct pci_epc *epc, u8 fn, u8 vfn,
+				    struct pci_epf_bar *epf_bar)
+{
+	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
+	struct cdns_pcie_epf *epf = &ep->epf[fn];
+	struct cdns_pcie *pcie = &ep->pcie;
+	dma_addr_t bar_phys = epf_bar->phys_addr;
+	enum pci_barno bar = epf_bar->barno;
+	int flags = epf_bar->flags;
+	u32 addr0, addr1, reg, cfg, b, aperture, ctrl;
+	u64 sz;
+
+	/* BAR size is 2^(aperture + 7) */
+	sz = max_t(size_t, epf_bar->size, CDNS_PCIE_EP_MIN_APERTURE);
+
+	/*
+	 * roundup_pow_of_two() returns an unsigned long, which is not suited
+	 * for 64bit values.
+	 */
+	sz = 1ULL << fls64(sz - 1);
+
+	/* 128B -> 0, 256B -> 1, 512B -> 2, ... */
+	aperture = ilog2(sz) - 7;
+
+	if ((flags & PCI_BASE_ADDRESS_SPACE) == PCI_BASE_ADDRESS_SPACE_IO) {
+		ctrl = CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_IO_32BITS;
+	} else {
+		bool is_prefetch = !!(flags & PCI_BASE_ADDRESS_MEM_PREFETCH);
+		bool is_64bits = !!(flags & PCI_BASE_ADDRESS_MEM_TYPE_64);
+
+		if (is_64bits && (bar & 1))
+			return -EINVAL;
+
+		if (is_64bits && is_prefetch)
+			ctrl = CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_PREFETCH_MEM_64BITS;
+		else if (is_prefetch)
+			ctrl = CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_PREFETCH_MEM_32BITS;
+		else if (is_64bits)
+			ctrl = CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_MEM_64BITS;
+		else
+			ctrl = CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_MEM_32BITS;
+	}
+
+	addr0 = lower_32_bits(bar_phys);
+	addr1 = upper_32_bits(bar_phys);
+
+	if (vfn == 1)
+		reg = CDNS_PCIE_HPA_LM_EP_VFUNC_BAR_CFG(bar, fn);
+	else
+		reg = CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG(bar, fn);
+	b = (bar < BAR_4) ? bar : bar - BAR_4;
+
+	if (vfn == 0 || vfn == 1) {
+		cfg = cdns_pcie_hpa_readl(pcie, REG_BANK_IP_CFG_CTRL_REG, reg);
+		cfg &= ~(CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_APERTURE_MASK(b) |
+			CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(b));
+		cfg |= (CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_APERTURE(b, aperture) |
+			CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_CTRL(b, ctrl));
+		cdns_pcie_hpa_writel(pcie, REG_BANK_IP_CFG_CTRL_REG, reg, cfg);
+	}
+
+	fn = cdns_pcie_get_fn_from_vfn(pcie, fn, vfn);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_MASTER_COMMON,
+			     CDNS_PCIE_HPA_AT_IB_EP_FUNC_BAR_ADDR0(fn, bar), addr0);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_MASTER_COMMON,
+			     CDNS_PCIE_HPA_AT_IB_EP_FUNC_BAR_ADDR1(fn, bar), addr1);
+
+	if (vfn > 0)
+		epf = &epf->epf[vfn - 1];
+	epf->epf_bar[bar] = epf_bar;
+
+	return 0;
+}
+
+static void cdns_pcie_hpa_ep_clear_bar(struct pci_epc *epc, u8 fn, u8 vfn,
+				       struct pci_epf_bar *epf_bar)
+{
+	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
+	struct cdns_pcie_epf *epf = &ep->epf[fn];
+	struct cdns_pcie *pcie = &ep->pcie;
+	enum pci_barno bar = epf_bar->barno;
+	u32 reg, cfg, b, ctrl;
+
+	if (vfn == 1)
+		reg = CDNS_PCIE_HPA_LM_EP_VFUNC_BAR_CFG(bar, fn);
+	else
+		reg = CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG(bar, fn);
+	b = (bar < BAR_4) ? bar : bar - BAR_4;
+
+	if (vfn == 0 || vfn == 1) {
+		ctrl = CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_DISABLED;
+		cfg = cdns_pcie_hpa_readl(pcie, REG_BANK_IP_CFG_CTRL_REG, reg);
+		cfg &= ~(CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_APERTURE_MASK(b) |
+			CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(b));
+		cfg |= CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_CTRL(b, ctrl);
+		cdns_pcie_hpa_writel(pcie, REG_BANK_IP_CFG_CTRL_REG, reg, cfg);
+	}
+
+	fn = cdns_pcie_get_fn_from_vfn(pcie, fn, vfn);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_MASTER_COMMON,
+			     CDNS_PCIE_HPA_AT_IB_EP_FUNC_BAR_ADDR0(fn, bar), 0);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_MASTER_COMMON,
+			     CDNS_PCIE_HPA_AT_IB_EP_FUNC_BAR_ADDR1(fn, bar), 0);
+
+	if (vfn > 0)
+		epf = &epf->epf[vfn - 1];
+	epf->epf_bar[bar] = NULL;
+}
+
 static const struct pci_epc_features cdns_pcie_epc_vf_features = {
 	.linkup_notifier = false,
 	.msi_capable = true,
@@ -644,6 +757,21 @@ static const struct pci_epc_ops cdns_pcie_epc_ops = {
 	.get_features	= cdns_pcie_ep_get_features,
 };
 
+static const struct pci_epc_ops cdns_pcie_hpa_epc_ops = {
+	.write_header	= cdns_pcie_ep_write_header,
+	.set_bar	= cdns_pcie_hpa_ep_set_bar,
+	.clear_bar	= cdns_pcie_hpa_ep_clear_bar,
+	.map_addr	= cdns_pcie_ep_map_addr,
+	.unmap_addr	= cdns_pcie_ep_unmap_addr,
+	.set_msi	= cdns_pcie_ep_set_msi,
+	.get_msi	= cdns_pcie_ep_get_msi,
+	.set_msix	= cdns_pcie_ep_set_msix,
+	.get_msix	= cdns_pcie_ep_get_msix,
+	.raise_irq	= cdns_pcie_ep_raise_irq,
+	.map_msi_irq	= cdns_pcie_ep_map_msi_irq,
+	.start		= cdns_pcie_ep_start,
+	.get_features	= cdns_pcie_ep_get_features,
+};
 
 int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
 {
@@ -681,10 +809,13 @@ int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
 	if (!ep->ob_addr)
 		return -ENOMEM;
 
-	/* Disable all but function 0 (anyway BIT(0) is hardwired to 1). */
-	cdns_pcie_writel(pcie, CDNS_PCIE_LM_EP_FUNC_CFG, BIT(0));
-
-	epc = devm_pci_epc_create(dev, &cdns_pcie_epc_ops);
+	if (pcie->is_hpa) {
+		epc = devm_pci_epc_create(dev, &cdns_pcie_hpa_epc_ops);
+	} else {
+		/* Disable all but function 0 (anyway BIT(0) is hardwired to 1) */
+		cdns_pcie_writel(pcie, CDNS_PCIE_LM_EP_FUNC_CFG, BIT(0));
+		epc = devm_pci_epc_create(dev, &cdns_pcie_epc_ops);
+	}
 	if (IS_ERR(epc)) {
 		dev_err(dev, "failed to create epc device\n");
 		return PTR_ERR(epc);
-- 
2.47.1


