Return-Path: <linux-pci+bounces-25667-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7B6A85A38
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 12:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AD5C1BA61EB
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 10:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F23238C3C;
	Fri, 11 Apr 2025 10:37:10 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11021109.outbound.protection.outlook.com [52.101.129.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014CC221274;
	Fri, 11 Apr 2025 10:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744367830; cv=fail; b=BZ1OFzZ271Ae8O4gg+spp0zHJbAJYVDMorC9FvJhdPOX301trEqXwTHf2fcQOrCVyxYcheCnCp1dZiUp7Ujn6OggSDGtdNKnuUbBFSI9qgTUBEC3boUwuy/KVNDnP0oJuLW/eie0ig9dX8r93pcOgaZ3t7nyMGqxkFaE3LcajzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744367830; c=relaxed/simple;
	bh=NGPMAW6eLu3Yq7Qm19MaaCmUSN+xvBZVbGBbgAcOrg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nIBoVjsV1RedJTMTUnzdq5VnGKl4H+rEqYJxQb/mexAMZwm6vRac/6R7QPmzQ7vMqyA97+8FpOZPEaWYoEoKgtshEDR0NYtXOY6U2Bb3FqVc5vLXWV4GOF6EqAeTHtDOB8UBNJe9hygJRizPp5pP/J6UwtpTBbZyrGO70Bysy8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.129.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t97IVhKx50g6Y7L+32GXLLoFiA0pvkFdiHdWKx/G5Ok0AUXuJUjhHE8C2Df7dyT7z4Etc+Kq0Oy4uou2xS58z+s0Y8SiFSa+UPEcfobn9lYxtXof2/wqEaeiI+4IQQhOmNq02NnRn+3JFDNNemKgDWPqj7kdNGTo45MpkFg5PfYjOxiHrY1kTbC9l61CwGwCTFBgMaDfM9fPkU6vVVPVC+asGwmIZdu7xtwMCl4hNur2I+J5vofa6N9/Eg+rQLm3bNHuuPz8vzbPVdMjVsgwW/+uUREzbyhbqiUXJOMUojTUZITbiNkjsf3NJhkJGB+DOBC0dtigDH7pQQi4Voi/qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+3glvE11CLib6A6Y6GNBKXC+aUH/szqQdeQERn92T7w=;
 b=RpQ+0VfzQp/UddjdvmBIuKWtpVXwtv3uyRmK1hs3kJhsPeYdmVEF4cLAIy3OhPloU7dUxZsbDjW5VTq0zGkD2f/IeUjyyU6FZV6IAOhRw/pJTHc2KSMFwtTCZsrHW3yfmFcErempKi82etkuja67qczkkxmTdvTl/gRZ2EwqKrXqt4Uk1pGCxnaPliMYlnvbcQoF0vd0qP12j7dEnnSgzrzYV/5eHrTYh1AgJlefAt9OhXFIHoqO9rUAxX/kmR+c0bJDda2XlORC7oTmyIIALI90/oknaph58L+nj56PNTm5sGCDga52AOECE3JhRfvEcKmdAKNHbNDhV2MFKS1l1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from PS2PR02CA0033.apcprd02.prod.outlook.com (2603:1096:300:59::21)
 by JH0PR06MB7267.apcprd06.prod.outlook.com (2603:1096:990:97::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.36; Fri, 11 Apr
 2025 10:37:02 +0000
Received: from HK2PEPF00006FB0.apcprd02.prod.outlook.com
 (2603:1096:300:59:cafe::55) by PS2PR02CA0033.outlook.office365.com
 (2603:1096:300:59::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Fri,
 11 Apr 2025 10:37:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 HK2PEPF00006FB0.mail.protection.outlook.com (10.167.8.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Fri, 11 Apr 2025 10:36:59 +0000
Received: from localhost.localdomain (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 6FE1F4160CA6;
	Fri, 11 Apr 2025 18:36:58 +0800 (CST)
From: hans.zhang@cixtech.com
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manikandan K Pillai <mpillai@cadence.com>,
	Hans Zhang <hans.zhang@cixtech.com>
Subject: [PATCH v3 4/6] PCI: cadence: Add support for PCIe Endpoint HPA controller
Date: Fri, 11 Apr 2025 18:36:54 +0800
Message-ID: <20250411103656.2740517-5-hans.zhang@cixtech.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250411103656.2740517-1-hans.zhang@cixtech.com>
References: <20250411103656.2740517-1-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB0:EE_|JH0PR06MB7267:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 648b26cd-8d88-44fb-06d7-08dd78e4ca2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SrxZ8kON+PVPxQUDZ2wAMWeH8am+DVr0B216dT6Oo2K4cXGPAbSbLECdgj9L?=
 =?us-ascii?Q?ap38BBgfu8geoqj/sOFw0NTN4xm0OQmmxH2Be18NuzKcQo/arL0TwWzEkgg1?=
 =?us-ascii?Q?/DhLwf9KAGhMRl8wpftwQPqIf8dF+gH44tjm6DdTXJVaKRhIJyiyd+3T11gk?=
 =?us-ascii?Q?MxYCVhKJXKn5QHYzhS6b/3ez377Bfk/6xDxpTHNxzctXobppW7DLcnmtawmU?=
 =?us-ascii?Q?OHmdsBvoBkWewf9k8qmCLLz03BkDBJTZrvfVz4LzxXvWn0nSCV4P9xpqerHp?=
 =?us-ascii?Q?m/EZyuBcXKQtadL6ldogf34l6zxvjVdhVzt4HSxLUh9oaRa8XRH/aNJE/Nsb?=
 =?us-ascii?Q?YaO/mfxRJD00kL8VVWCh66jaSb3JCdUam9+BDGOxsij+ULdZvnRfuyC1NM7I?=
 =?us-ascii?Q?XT6lwmyOqN/aONgF0HkSDtZwEGgFJu+zHXvvWkYhPNQcaa/ni+imet4xbJhB?=
 =?us-ascii?Q?byQVDw2aquSajaWaKXaYNfERf+PDok5Hie35MjclCNogyP6oqkgeVqH0PXVG?=
 =?us-ascii?Q?4hwfgxGkH1E3GY0IjkMXjKMlmepM1Myk8NmNdnVwOrqx+BLWaD4/0AqVsb3P?=
 =?us-ascii?Q?v86rmknITnidMkccI4Wdx5ama3hakkfDfuoz5nMba0/UpzaSlaIMcF1h2c8W?=
 =?us-ascii?Q?td1miD1fNoorT3yler3vApPaSR7vnFzLlLlR7PtYk6phdt2PQW/EVhwesenQ?=
 =?us-ascii?Q?aNsQm2JCJlqaD8I3jFjSy5FBzGem5vUb7zZOuPIOUN2WDQxVQY0F84VGTADp?=
 =?us-ascii?Q?/h1QhUNPiamsGh3HvPjpamGRUmF+9PLXeq+KakQUVH/spnrnVFCrlT2sXD69?=
 =?us-ascii?Q?zDhrxRh8IYLY81mmOVIphK/PxF60bg8YMu0bw3EPQOjPFtTh/ZdPXpN7/aJ2?=
 =?us-ascii?Q?d2vx3M+8hPOSlPxbs5TSbRVCSzdJueL18rfnH5cM8jPS1HfEEmJptt0PqoZ/?=
 =?us-ascii?Q?Nujo+v+QZ2hpXAptZnggdYyyzMwx3bMm5aVt1rqnAROtuDfnTgPXmZdT/ifS?=
 =?us-ascii?Q?fNn2Zmg8n8s65YwhJlleXf5JmNLARF1x0EEzOSw9OOGnFYE/ldQIZCsIDnEQ?=
 =?us-ascii?Q?U8qIfE5LgWgEx9oqRxWtfXVP9oM5kVQI8wVhwVnmhoKu8S45liyp8gp26smU?=
 =?us-ascii?Q?WsI0vCM4Bp3/JxD6poEWmys+Gr7RUNK5VyB7V0BIByINfQtKvm0VNP58OoY7?=
 =?us-ascii?Q?idG8PcYVdzhtMnMdJN1A57/DG3ZL8OF2siofsVhlEvjlDpILs598yClbL2ov?=
 =?us-ascii?Q?jVSrM969+dW0ntFuRGCld6RWFgyguRE2qFQFDegt0c9U5t67JjRZv9x8TKnr?=
 =?us-ascii?Q?BKTxetypShghx0gUI9EAjqO8dsfIFpRdUjPSKm05foRe/6JtMVO6RDiaCs/o?=
 =?us-ascii?Q?LOMiXV9yFEu3etpThngYXDaaO1VsokFRVB4n3G0Uw3DNEfjBKh4weR/FRH8T?=
 =?us-ascii?Q?9SCRVa30CqvLtoxmJhD3A2ttrSxel4Sm1sHwinuzUHBsM+5p3wDj/JJjJERv?=
 =?us-ascii?Q?xrxabi4Z3n5pNtdO3OWrhlqCeiWyAnW40MSs?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 10:36:59.3606
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 648b26cd-8d88-44fb-06d7-08dd78e4ca2a
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: HK2PEPF00006FB0.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7267

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


