Return-Path: <linux-pci+bounces-5323-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5507D88FB0B
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 10:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFD84B254F5
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 09:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA78C54656;
	Thu, 28 Mar 2024 09:19:06 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2114.outbound.protection.partner.outlook.cn [139.219.146.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20A07BAF4;
	Thu, 28 Mar 2024 09:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711617546; cv=fail; b=hSb3WS4BriD3qAHCgooTeRSr3VCM/BwdbYuN8JRNVOlgLCIC6kP9acTDlV1jOk3owSKKJ2ytpKzx0Y6a40DlwQB5X7M75t7r6WlUjgtRtdlOaxg4K41l0zlTNM/NkqXUVPtkFeTqi08TBJRvYL5SDgn18VMWHTRM2009G+rEKHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711617546; c=relaxed/simple;
	bh=/ehzZl9QSVpPRZ/UAfCv29ylCqgtkbj83Tdj9z/HJIE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TtaqWs8SoD4sVXMpOrOQGOyhdk3ZKxfg6Zg1EHnJUzpUSuWAk0bQfeA/gqNFAZ5MdSjR+7eqRFzm4vnZdv+I8EclLpydmOtO0y7AdlILaU3bh90f4ndZlt80FATcjFbxMw0RTZC8wQt3bKdQ38pyUlBOEMCjCNJzygxaWFA0Dy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IUFeSqHbk6bSoHP9pZLoZCft6QxY34N5gpdKBB0jMQaFcziQhkAbxGPNgw+84qEbZjxo3C1Iamt8QGjWBsieQVJxC2Ufc/FCjzMTIEpGbs2J0mmXkuWGePBLR0pqggWXx2Hc/r+vv+DsKHhXK5zaIlc8Ez5vlYsDQt8ZH8GtI3ZmdkKKI8oQNbqsbfGAJ5SiGDG3KpU6HNe5u13xfqFnFHKvtVZG/a3K/t3Z86Ra8KOdiPXY1CYzr0naveXAnskdhOO2GLnW//JZCeltAhUvTx8M6bLqPUtODsFLxyt4m74d+Wmmy+gf9TWH2PhDi/LXtAgpf2maqwWFAYrBgyPmlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vfb6s05UiVePDPpYEZqYrC+O0vsMiLyoyD0g/Ym5o2M=;
 b=ZfuSaFSPBO4ORTMGhjrE5jYf3YHMZi7cxWVv9ygEc7YoO3F+OPcd0bpvXCRiwxGdE+W0Rr97PsmXXFvkSuoRypgXzda/bt4Cz0fzNEGEtvW0Lp3Uju90uISQfA3tdCuvqGqewVtNdmcIQ6PzZe4MbK20kjGtMpPiD8IlC+QdC4sibRvOdEu+IHpYg94zNJOu6es/6gt7DA4U+DZkZzE0sVIuPkc1L2VaqwbMbEkrfhFR6iP92gZEK8OyUQoOYJdyxRnDJudhzXucXzbuUjeY/hUyEtPPaUxRLrk98n4Id8usBnMfhMACnV2F2b4AK9FH/4Si0Hv74Dx8A1J99g7fLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0496.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 09:18:50 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::c738:9e6b:f92e:8bb9]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::c738:9e6b:f92e:8bb9%6])
 with mapi id 15.20.7409.031; Thu, 28 Mar 2024 09:18:50 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Conor Dooley <conor@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Mason Huo <mason.huo@starfivetech.com>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Kevin Xie <kevin.xie@starfivetech.com>,
	Minda Chen <minda.chen@starfivetech.com>
Subject: [PATCH v16 07/22] PCI: microchip: Rename two setup functions
Date: Thu, 28 Mar 2024 17:18:20 +0800
Message-Id: <20240328091835.14797-8-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240328091835.14797-1-minda.chen@starfivetech.com>
References: <20240328091835.14797-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0020.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::16) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0496:EE_
X-MS-Office365-Filtering-Correlation-Id: c89e9911-47ac-4aad-3f8f-08dc4f0814dc
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sqppdAvWS+FxEdGiigkWv6C5ojQ/znEKDneWsMWKnUMlvgoOYpIUgQ8mKT0Z0fApszSkxVrKJA5H7ZWhyGZFD+yvKSA7sTMwoiEBBO8sDDM2+lTGulYZlx8MRVg2aIB+ie7yNy1ITSOMv93MY9/gles42TTUJNvcMNhumbR6sEKoCm75aybDaG+pe01a7ZFzMv1W4sCkV+mLZMnfYt7sL2JXC/zVAbgCOngYeB11GvWg4xAKddO2gB/i87atZBUxUYCXo4zBAO2Xv8N6aN3Xpd67Wa5Y4V+Sz+TklS/bPRarHK00rvREs5+zzvDbp5YgBx+LQV4zPHNx48P+rlRgIbzIAKbvYPVptGK6ExdSOBJbNd1vYh01Ufl6iEnX60AOj20mtaBRtH58QeSvNNGXokseN0RdQF3GsIC97ea0Vwwy1XPXR59iio9zvUK7eaPCRbyc9dmZvAC8nWYx5yPTr1lIE1/Qyy1TNTv+1dNy+fAttxpXTnyUjia6iKD+i6NqnwAmjLVJtD1xiGHBZP1S+mTxU2Q9mEwqtx9ipffftfUhlnALIM0A8j10K4zx6+tD9GQb8qCqyhe+QUqc6Da3Ktk5DURULEvc7IToitrPmZA2lZ1Sn1ba3VJTUfE90QWS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(7416005)(41320700004)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PdSfXkqIYca0eLPMf6h+8soaNLq07l92s0Yv3WJ2KY/rYfg690PMaYX1GudH?=
 =?us-ascii?Q?RXkIgzVpct7Nv9mJ3lQpPld1z4eJSgTYAtbJl2HvmSkcE09SoH9E/HiKsBls?=
 =?us-ascii?Q?kM416Vo8CTG4cLzSV1ExVuyPrpVAKRFzcr7JCIljJurlh/Bpx90ZejjtuzQu?=
 =?us-ascii?Q?1EReBXn7cw1Gm0464lWoQ5jMqnuzUFHVgbmNm6U7UN2TIlIAzNN76mK7eEMl?=
 =?us-ascii?Q?7X5+ZdD4ecx9R5TaaQhFf18pY2ZmNc7ls6TJ877MuZRagmzlpP2Oj9Jqdz6I?=
 =?us-ascii?Q?DYjR5zdu/kZKqM1ZVhqWLER3ff6iBNox0QQg/psWoyFlr22vxfJSxMTTP5Gg?=
 =?us-ascii?Q?35F+mBtFqBRfYnwsV6AMLUd+RgzDcjcrJfXY4PoDidWN2mWb08o660WchCyM?=
 =?us-ascii?Q?FUN1yrMnLu1aCnvEr0OWFPHf9jboDfKyf8F0NsZysPL0OaPqErlloitX4A5k?=
 =?us-ascii?Q?MnKGNLqudw8nsTC7zE1NpL/hB5/ohSnuANgwz/AjYZlZuxJOYN1PEfsnyYXi?=
 =?us-ascii?Q?d7oxEESkSf3i/Gsj+zl6X+YZEcmzHu9ZU3tYha/eGaX3zhNth9VL1Z31K60O?=
 =?us-ascii?Q?7A06ohUXY7cBjoVREHAUCR/PzDN+wpS7KsRgcoQgL0sMTpRkfnNJi/KOjIx8?=
 =?us-ascii?Q?5UpfCBBGP0FT4H1r8e93Wm8MkF6+GMMJl7wPaBzAXiIZy1w+smPIWIPhXX88?=
 =?us-ascii?Q?6NMMSuzhf8FqjZRahGH+Qcz3AZMqav25lACVyzib/29codV/4yoUA/RXKfnH?=
 =?us-ascii?Q?JOo+PEFs5f39kGrNEJrBr6Sw8m3Sd4qdC17uf8aADCsgWOuPjW/6KwNzrgTs?=
 =?us-ascii?Q?Z1yoJT7kfKHQy9dxSZjwClNGxiLUaJjTp95wpQQ69ZfNiJ4559MLDS9/n+7Z?=
 =?us-ascii?Q?s4xaYvdfKasF5W7ZY9aD0qu9zwVsq4VlKYYeUDxrpDDmLo/uhy8tKAeqHtpk?=
 =?us-ascii?Q?gyp0NXhJWnFPFiZzMzl8dM5+HNxZaxrZeSawZHddRdak+wr/tx+FS+ln9Yqg?=
 =?us-ascii?Q?qghWjuFuhzLBlW1OIVVeUkiBOHgDKcnqm7qQa40hoEm2BGpHBSmKs/50pddf?=
 =?us-ascii?Q?O369GgGpe1eaGpj8tGk+5HI37VHRvUXnH/sFv+bVexv3C2+jO/lrb95F+Y/H?=
 =?us-ascii?Q?VE5ywT70lxuNIAlpNahlyZGHjWQM+YxIsXqNgndRqvEqKEgb7QrKDXv6qOyo?=
 =?us-ascii?Q?aj7ymLFZ2MBKEpdDfPQhUNxMjgqxGf8dsS0nu2D/jWcrLky55eIy4uB0FfeN?=
 =?us-ascii?Q?NOxqnI8lcuQwWT5oTQF096EQk9os50rUALWh1MP+h4AGXl6n9p+cINeza3f3?=
 =?us-ascii?Q?7Cc+MvgbU/MSOlUf3FmdcwVgp46yeNfqKpdCIGctxEsiqdkMQ/GO9qadhw2v?=
 =?us-ascii?Q?HuhW6f+/AKw9mXvYw4HOMzf9QHqYSWQxYOGgrCXfdrlHHmF9CDTmhDuxvZrw?=
 =?us-ascii?Q?94pVBe9z+Zr1DVQzIaXIUIKQI3CJrefEfhZHmgWZYELEKPPndaXdjH2mrjaI?=
 =?us-ascii?Q?L0I1J/GPcR3IYzp9s6ft+nAE3gQJnRexHkTpG0flpUVUg2ppV8EbXWLekhR0?=
 =?us-ascii?Q?UEPcGK0g6TJoA9XsVKSy+c0oQmTaK46c/eIzw2kYXpLTHkgBxr0N6RjWxvXT?=
 =?us-ascii?Q?Mw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c89e9911-47ac-4aad-3f8f-08dc4f0814dc
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 09:18:50.9253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cPw+Mao2oxql5095ghqm4WH43F0BWhE9+b1csmwiC7m/5Vrcv+0SjFghlMXqrmJ01YEP43JpArLGqCQQ4mc33hzDNeIVqdf7v9voIyQp4tI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0496

Rename two setup functions to plda prefix. Prepare to re-use these two
setup functions.

Since two setup functions names are similar, rename mc_pcie_setup_windows()
to plda_pcie_setup_iomems().

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../pci/controller/plda/pcie-microchip-host.c | 24 +++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
index a554a56cc0e8..9b367927cd32 100644
--- a/drivers/pci/controller/plda/pcie-microchip-host.c
+++ b/drivers/pci/controller/plda/pcie-microchip-host.c
@@ -838,9 +838,9 @@ static int mc_pcie_init_irq_domains(struct plda_pcie_rp *port)
 	return mc_allocate_msi_domains(port);
 }
 
-static void mc_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
-				 phys_addr_t axi_addr, phys_addr_t pci_addr,
-				 size_t size)
+static void plda_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
+				   phys_addr_t axi_addr, phys_addr_t pci_addr,
+				   size_t size)
 {
 	u32 atr_sz = ilog2(size) - 1;
 	u32 val;
@@ -876,8 +876,8 @@ static void mc_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
 	writel(0, bridge_base_addr + ATR0_PCIE_WIN0_SRC_ADDR);
 }
 
-static int mc_pcie_setup_windows(struct platform_device *pdev,
-				 struct plda_pcie_rp *port)
+static int plda_pcie_setup_iomems(struct platform_device *pdev,
+				  struct plda_pcie_rp *port)
 {
 	void __iomem *bridge_base_addr = port->bridge_addr;
 	struct pci_host_bridge *bridge = platform_get_drvdata(pdev);
@@ -888,9 +888,9 @@ static int mc_pcie_setup_windows(struct platform_device *pdev,
 	resource_list_for_each_entry(entry, &bridge->windows) {
 		if (resource_type(entry->res) == IORESOURCE_MEM) {
 			pci_addr = entry->res->start - entry->offset;
-			mc_pcie_setup_window(bridge_base_addr, index,
-					     entry->res->start, pci_addr,
-					     resource_size(entry->res));
+			plda_pcie_setup_window(bridge_base_addr, index,
+					       entry->res->start, pci_addr,
+					       resource_size(entry->res));
 			index++;
 		}
 	}
@@ -1023,15 +1023,15 @@ static int mc_platform_init(struct pci_config_window *cfg)
 	int ret;
 
 	/* Configure address translation table 0 for PCIe config space */
-	mc_pcie_setup_window(bridge_base_addr, 0, cfg->res.start,
-			     cfg->res.start,
-			     resource_size(&cfg->res));
+	plda_pcie_setup_window(bridge_base_addr, 0, cfg->res.start,
+			       cfg->res.start,
+			       resource_size(&cfg->res));
 
 	/* Need some fixups in config space */
 	mc_pcie_enable_msi(port, cfg->win);
 
 	/* Configure non-config space outbound ranges */
-	ret = mc_pcie_setup_windows(pdev, &port->plda);
+	ret = plda_pcie_setup_iomems(pdev, &port->plda);
 	if (ret)
 		return ret;
 
-- 
2.17.1


