Return-Path: <linux-pci+bounces-4120-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE42868FB9
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 13:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 058EF1F218AC
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 12:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3DA13A250;
	Tue, 27 Feb 2024 12:09:21 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2135.outbound.protection.partner.outlook.cn [139.219.17.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743D513A254;
	Tue, 27 Feb 2024 12:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709035761; cv=fail; b=UsNeY7K/w4YHbFMBjrx9ZFCJwIF/JeVDqVAhAsdjv+/JPDsOQ96Tm/044fgXLDFNFo2R86KZ9QjShonwhmlDhMnD3rJwM0Ev9JYOJt+zv4C7Z0mu7hi1UXb1g/Nv5/7Ft1960A2k29HdBEpKbU47GaGBHwc+d29xFzMKbdlHakY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709035761; c=relaxed/simple;
	bh=6IWs/9L5/U7olRhCkLt+mH+c3E5Xoo0SyzW6LQLbL8c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c6AtuD+ys1T5OEAn5icyN8I6ccNTE0KKU0Znp7H8OlRURi/QFybhAn/gd4wKHdaAFmosX+EH4yGd3gCST+sMdtunRPTqFAKCVEzzK0IrFYhDuYpHSgdG9pM0AEuw7dXVUaaTSbgSEovanREdsBP3zoLCkprK6g52K6Y4j1D2rpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ewKzZpu+vpnG5ubQi4Yg9STUpKDGkjpwKLYgqia1ywUKzX53TFndlp1kKuFJ6iKEnlOF6PF0KVH0e4vqnXGE9X8LRNJIt0SbmU7OLSI5Xb/VVpJvRDfSI94zXpc3SEajvXWG42wGbRm3QugDAxbTe+feEQTACSRf3QVhUEvwNGX/JOxd4L+NYN6NKMQQPCYOkmwvtJlopOP9pBBFzdaFCvEPIE96bs1Qszv6sccH3NvlkWx16cXpVX5xNTaP9NbjwYn0PxjS+7Df3zgEHwGo7TXDiWOVGJ0gALG0XuMiXsZEXtFO7vF9al/l3JcQGCW8vhw5vyOFI82tOkOKnSm1nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H1L2zCinMaKZ61leC9g0xpthGdFxAFSQ7l+a9Zn1/VQ=;
 b=fhoYK/OV2oTNgXV8mSHkvHWnQ8w6JDpdqNzbk1w0Vvgys4pQFkfSlWe134ODypQnxzkzReNYKDgpf+8Sw4b67kL7WK10mRBP24YTLl8tztGmeeDxyj4wN3RbrWASnBwAGIWYOEDdjGr7KsffT4ndj9s6JUAbJvSkjZkW6hdQ8n0WXW6ruprQVrxxNHGLsEodqzOPqxvrsv3stC2+7bCR5RVx3jyME70rLFzquFKuPwJA4aMruqAgeZpB1ObQ5yw2BfdJxcIEy49fO72Oa3cJ7cfaWT/u5ZGMkWJZ2bVTyTAtWliJBZzjHeWupNKXG7zFYrbVon6PATvi6uLIdeDtyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0496.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.47; Tue, 27 Feb
 2024 10:35:38 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::5a5a:fa59:15fd:63dc]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::5a5a:fa59:15fd:63dc%3])
 with mapi id 15.20.7270.047; Tue, 27 Feb 2024 10:35:38 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Conor Dooley <conor@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
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
Subject: [PATCH v15,RESEND 08/23] PCI: microchip: Change the argument of plda_pcie_setup_iomems()
Date: Tue, 27 Feb 2024 18:35:07 +0800
Message-Id: <20240227103522.80915-9-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240227103522.80915-1-minda.chen@starfivetech.com>
References: <20240227103522.80915-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0003.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::15) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0496:EE_
X-MS-Office365-Filtering-Correlation-Id: dd98a74f-6ca5-4cd0-2dfb-08dc377fd676
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3AMgjhdp2uCNh/GZgBGO1z6WB/7SNIk0plq3oiV+/TX7PJ8prte2Jr219dMISN1Pl9PVGheZ4FG1FX2Dbboyds3hIXatDMcOP/6kMSqJICTufJLbZhhUxAsitEPkKz5YzbhtwD/CMNdUJQtu2MskxQY9N+g8SoFKKlm+ufGXpWCQjQnzeev37DJDTGwvMgJjvsDP12Cv7cCRS1KWduujgQqKlGR2Pw4ked88UGIpzWRWeksvqhfzVXGB79AxkhtIwVtLy5uV+pqBTRl1iIZD6WE6WpZU5NiYOotg3PG2OAFn7O5bnW4FtdEwAugfNvTjA0EKSPs0CxAsGZkfVh/PAkDkUow6qTIv7p2g/kC22rhcb/vV7JUOJ2gvxINxWBDApEdykRrYcUjzPqQFO/CjOn3/I9q5jMNJJ7p2fDbDQj0BwzHT8dFR3sk74oYaM+Y0aBISisS9kxX7vkaZT44tgVjqFIOunH84U80UbE7/OrKpGVPniceWsQQsRobgTORVkG1P+QojarI4vUhauYXdWKTf2d9lasOkmbqlo4iY5RWo+trkFIlEu6/VsO5ufbAy31j5HaJKZOjom0nEXQc8kQc5VGfQa8sBnsd8r1TyQ06Y/LAd7T15Vwpwh6h96+8l
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ou5iJaF/MVtQi3xIKMzvYKY7VRXGoA9k91H9P8zuteup8vEc0nM/92vmSrmJ?=
 =?us-ascii?Q?J9nE05utn1efCxlxeYH0vRElF/ME1035LFRhf8u/eIs72g6B5JfhRKXOiBfB?=
 =?us-ascii?Q?Mbga6LMMvhXdMK/Pw6lXSUlyn9nXbrWnX5p22jW4WFaNmuBluy6xUgr14olH?=
 =?us-ascii?Q?vtDN8xwfmpu7fFftrBDy1tleHFUSKofN2OK+kxIrHsOtUeHnllkR9gq002Ml?=
 =?us-ascii?Q?e2fGdx0+F96EuJQz99L89Az9sq+7ig03CWTDoG9M7iDo/NGkBsJoUNjeVSE2?=
 =?us-ascii?Q?KNIMSfzjo5MjJBmtKcTi2g1g2FXMWX96kNyFXyIUu8YPkdeEZgcOm2x0m0hx?=
 =?us-ascii?Q?N7Ag1JJDvxQl8UC5mGmMrySHY0WFEXfbuGZJzATsHp8eFDPkoFEZhSrFYZ89?=
 =?us-ascii?Q?rKt8AiT57/lsZECI2AVd3uDkR3EwN1LqTIZ2KTNLlbTJs1EviH0ZqPR+p0wC?=
 =?us-ascii?Q?ZTBNapHSMqTlm3jo5bh5X1L5GagPX5DrQmRD49oIrqMEx4ZwX/b9I+7ayCiK?=
 =?us-ascii?Q?K55+XlDyfs5W75JWBczOI+0RbBfiiVTP+fFmlIOJwMiUDotIO4tawfW54CYZ?=
 =?us-ascii?Q?MB9Q8657LQwO/ma/F0sWgs7PyW+8J/h6UXbT314bm1c1KobG3REpponKDUoo?=
 =?us-ascii?Q?eyu2pL2kr3cOxXvUUn1M4no1upfymxXaQVhagKyk9QmygXsDSdYiBncl6UfE?=
 =?us-ascii?Q?qZpaXV48zLcpRqIstjEa3eDw9YGfAIELytKB9IHcomYFwbC1xd99mps0JIF0?=
 =?us-ascii?Q?oXg235+n9RJGE5OkI/Ji4Gzj5gHpVYTDQdfXUlRdf9nOu5tu8i/6riHyQ5Me?=
 =?us-ascii?Q?njlhoN7k6wUTO2hxiwN0qNCwhWUFJgaJaVcZq5DNsTPFYI1YrGW1VDmm+j6f?=
 =?us-ascii?Q?VBb2f19WHvoJ3yl7BytdxC+AJKBjWtVXJo3zVOGDYI9q8KPMPWX6pY1FrgDk?=
 =?us-ascii?Q?SirSHL/p/cH/rQonQGSb4VX4US5mG+ehpRNJOOOH09+U6YaeOnQZuhuZ/ikZ?=
 =?us-ascii?Q?/1uoZBEnEQJ3yyiPK3c4QNizjNK449eRjmzHyxdrH3JS0rwHnyqfLS/CY+uG?=
 =?us-ascii?Q?3pcviHA1zJH0zki76/WPo0dbKP0nkG1rYM8HfCbzxMoHyNdNyOiQQTxoSGJJ?=
 =?us-ascii?Q?c3AVkwoZIlu7Njge3zy6PCS54GVExCIp4zl7qKvrZ7po2urGHjeQggoHffy9?=
 =?us-ascii?Q?TOg9XZSR6fVeiJpqA3Zva43WRRVq4TVqeY54XArL0J1OuxdH0m9huhsHAT5v?=
 =?us-ascii?Q?9oKi8jpP8PeTeWwqEW/cJAMQZSOaGO1HMICY18vzqc9/ZLg9588BCzvuQo9c?=
 =?us-ascii?Q?PVn4/hUxuhs5IwHw0qs/3Bh+EPWdN9bGLWj59U+YMGAa3DspnC2HPW/cL6D5?=
 =?us-ascii?Q?nqXePdJbkW3GVUvLXdHg+47OVuwgpiSG9ww+agsTlx4hdANNT3TdPX+xspIq?=
 =?us-ascii?Q?y8N0XR9/Ae897BoKJA6QZ4oFD2ctJ1IWwRZNIen4KFJiTlkaL8IzoeZ44KLd?=
 =?us-ascii?Q?lobE4DWyNaNXVFXq+XRicLh8q4EjyfmRObF3+UjpH/EvtLMoF+EcWz87byVP?=
 =?us-ascii?Q?9p+fdmNAL+8nsEJ6zodrXJ2MfZi81eUVQeSQZ3mnxp/Ew6gFmm2GR94Ls7wx?=
 =?us-ascii?Q?hQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd98a74f-6ca5-4cd0-2dfb-08dc377fd676
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 10:35:37.9337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s+xjezcSfeCVVHa9A4KIUlTI4LB+ycV27cC5BhHHjHCTvEst68kbfdLDFd48tl/WHFt19c0qb6EDh76IoVoC112iYaK6scQtkuO2ofsYkic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0496

If other vendor do not select PCI_HOST_COMMON, the driver data is not
struct pci_host_bridge.

Move calling platform_get_drvdata() to mc_platform_init().

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/pci/controller/plda/pcie-microchip-host.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
index 9b367927cd32..805870aed61d 100644
--- a/drivers/pci/controller/plda/pcie-microchip-host.c
+++ b/drivers/pci/controller/plda/pcie-microchip-host.c
@@ -876,11 +876,10 @@ static void plda_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
 	writel(0, bridge_base_addr + ATR0_PCIE_WIN0_SRC_ADDR);
 }
 
-static int plda_pcie_setup_iomems(struct platform_device *pdev,
+static int plda_pcie_setup_iomems(struct pci_host_bridge *bridge,
 				  struct plda_pcie_rp *port)
 {
 	void __iomem *bridge_base_addr = port->bridge_addr;
-	struct pci_host_bridge *bridge = platform_get_drvdata(pdev);
 	struct resource_entry *entry;
 	u64 pci_addr;
 	u32 index = 1;
@@ -1018,6 +1017,7 @@ static int mc_platform_init(struct pci_config_window *cfg)
 {
 	struct device *dev = cfg->parent;
 	struct platform_device *pdev = to_platform_device(dev);
+	struct pci_host_bridge *bridge = platform_get_drvdata(pdev);
 	void __iomem *bridge_base_addr =
 		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
 	int ret;
@@ -1031,7 +1031,7 @@ static int mc_platform_init(struct pci_config_window *cfg)
 	mc_pcie_enable_msi(port, cfg->win);
 
 	/* Configure non-config space outbound ranges */
-	ret = plda_pcie_setup_iomems(pdev, &port->plda);
+	ret = plda_pcie_setup_iomems(bridge, &port->plda);
 	if (ret)
 		return ret;
 
-- 
2.17.1


