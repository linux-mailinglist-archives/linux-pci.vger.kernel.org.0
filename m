Return-Path: <linux-pci+bounces-2374-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55288832DB6
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 18:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EFD8B24BE8
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 17:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3C755C2D;
	Fri, 19 Jan 2024 17:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eLv1+vqB"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2043.outbound.protection.outlook.com [40.107.104.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA58254FB9;
	Fri, 19 Jan 2024 17:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705684309; cv=fail; b=koVEFyWAu9b1Ij89n/7TERJ+bd5R17crjBw+ebPqFdVrny1G+BefElx+p3ncZu4RJIxntDZGZfEWeaw31W0Ixt2/LULByo/Qci0eS98W+uIJqJCsjJJTrhkyw4ZrDK2i87X63pk0TmcBzWNr5KtMx552vNpKu6TbVAFJhTaQsZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705684309; c=relaxed/simple;
	bh=guE+VyRsayNuF1WnDsWrpJDmCrVH12bRZod47YGOwXc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=OnM74CRDZCKwBhCZG+NETWSnChMXUMFQjgVuFvnq/Q6TkNSdzUYR9jcx5FZ04F+9DkM4kNJ8IcfTm3aymlcIReIEjQg7MAGVDwr0NQU/rWGbceWhcZB8QXRAVA41lwBEaEBlSMJi2v+nsrc6OEtZUKst2UvRG0EHNC4DfdOLoYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=eLv1+vqB; arc=fail smtp.client-ip=40.107.104.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N0m0WechjDOHs2I973ESci8TdotEZteLvMljIXCn+A2kqndnTcjywnmWX08u2Qj8vDof5PnR+Fx9neg/Ewgj57m3EnN4dTsvxGuARYqByVyZMx5F15yz7Pm+S1KF0ggX9sh03FgRjX7hsFkiQleO1Vrn9A1mxYT0kHmGnk1FOAEbuldwh18c5uNzMqn/oasurIbdDHeq02SIu/IVdY5nnTdjUIYFooP7XJgXWxk/ZAjh5aH5wcjYHzaiMacYca/8LrhT9nnP2D41M+M53f+iLbJQ0CV7+++IDC9c7yIbuHT6OgTSCUgVNL05mcX9xCjvyNoi5EZ6v5MDREx+j2Hn4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3knW3jblvOnL/K5EX0UBqYtAPahp0eKqnsVyFmJXiI=;
 b=eX4FDAfV/UQoAS3AQhXdGZWPru4gImuUPwMvmJZpdx0VRPd2UJVVBfrnf8QWbDQyemiVtilL1HXMS/LdhkCnBvRWYiicCsxJX4yRnHEP44bAPj0WsI0AzaGzT8zqtIlUAwQOWq0Q2blibeN1JKfgCx8GITgVWyPUjw1ZfT8yYisRPLhEbrEZ6eeHZ+tNDOuhL6dVjihS0B/7lSky+E3yVvIdydsXamnPAnsKdbo8Z83VpxzILglXgGVlMjjXI6s19u+Bl8LDIqzJ2cMLrG+TBAmDocUPwklN4cvymvKV8ZWoNcD03StO25OYTOmzV5HO6DkUgSVU3qBtEwQmEQ6/9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3knW3jblvOnL/K5EX0UBqYtAPahp0eKqnsVyFmJXiI=;
 b=eLv1+vqBFNcgnRkJ0JSTK8jmOQ7TMhy2iUNFpPHQK21MFkwip9ZiJ8wSmSkjFD6C6zdcglkFiZXelbKhndu7CdzmsAQwLuQCz6rxr/on4ZeNoBicpJHqvIPQmY3C7SXHy9SGtD7vqAlnCbRuqyyUig473pBIYnrPNwH+WKrFSSU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10045.eurprd04.prod.outlook.com (2603:10a6:150:11a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Fri, 19 Jan
 2024 17:11:44 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9%4]) with mapi id 15.20.7202.020; Fri, 19 Jan 2024
 17:11:44 +0000
From: Frank Li <Frank.Li@nxp.com>
To: manivannan.sadhasivam@linaro.org
Cc: Frank.Li@nxp.com,
	bhelgaas@google.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	festevam@gmail.com,
	helgaas@kernel.org,
	hongxing.zhu@nxp.com,
	imx@lists.linux.dev,
	kernel@pengutronix.de,
	krzysztof.kozlowski+dt@linaro.org,
	krzysztof.kozlowski@linaro.org,
	kw@linux.com,
	l.stach@pengutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-imx@nxp.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lpieralisi@kernel.org,
	robh@kernel.org,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: [PATCH v9 00/16] PCI: imx6: Clean up and add imx95 pci support
Date: Fri, 19 Jan 2024 12:11:06 -0500
Message-Id: <20240119171122.3057511-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0023.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::36) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB10045:EE_
X-MS-Office365-Filtering-Correlation-Id: da11bf3f-d9b0-4668-0b8b-08dc1911b611
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CMveh/DP0pGYJ52wL9fS/W2PWQcDKMemO9UY8a2UksmoVgPteXBYV3/B3knnQgiFUwB7ebJLYMWom/UoktSakKbvtxworUmY80hL36GpZowyhTZLmU638F4MIUTE7hP4oN3BEWndXBsS/h1J5pqOZ5UYy5V+Zsqz9yeV2kolnVZCd1d40cX4/fKG5DzkF6qSUpOxwsTWObDYa1ZVY2n0FGrJ+UA2a4IlUofXvRwhFpl+PVysp/Y9RN8PGSajJQPoruxmozd6R3Cl7cVOf9tzACBiVeQO0nx24oNvnO/Xhi8NcCYt0i/YBqseyQS4EvNVgVFe5iHuQvzxdk+mTPGE7ov8UHJdtKvZExgdLaRERqUglz26Fb9nAQ3eVmZSdZgWO+C0gh7UDGYUwrU4TIOleBryj+1v0jEoD5BPoL5b2Zt9KakVgsb7hwbgePv8AeX7HCjAVfMWThpY3LwnXaxszW8yE2xDtzVXPIT58JChg4mgPSk++giY5e0uVeMcwWHpuILrXx6l1UmES2Jfq5fjSFbDWLjBz4tfsm1eV4ooU4UIn7yr+4HsaRkFUVqbSwn6aQSSfGfPz/xJMTo5Gpmg+xbFZCcMMTIy13ctOyD74RJLVf3DKnWS83MGwM7vMi5D
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(39860400002)(376002)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(38100700002)(86362001)(36756003)(38350700005)(6506007)(4326008)(6512007)(6666004)(83380400001)(52116002)(478600001)(8936002)(8676002)(26005)(316002)(66556008)(1076003)(66946007)(6486002)(6916009)(66476007)(2616005)(5660300002)(2906002)(41300700001)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tfUdXqfr6IByuaGRvLXTMl830HEzfYTqLNe38xA/bb0rBho2oC9UVateZudl?=
 =?us-ascii?Q?B9bJ1GGLcLDcgTlTE1xpMk8Qp38FDu4cSaUUjk7RhKUb3Vpbh2AH+iokChac?=
 =?us-ascii?Q?uuZX/Y5Rbxh8PuBDhcYApGQZQ9IfjUeGK1xWLQXI1CwoF/8s5sckxo8qpkTp?=
 =?us-ascii?Q?BxV2h0NGQ5HeNyZFTQGSqEGY3yFrou54R5Nw/E7+ABT5yS7GG/OYrofukDBw?=
 =?us-ascii?Q?8y4nsmnBSyHOO4LcdD5BN6UGEc/Qgj0K9g0d8T0rHcouDATtNf0ZOmZvZmCl?=
 =?us-ascii?Q?cc495rM3gmQ0EYTXGf/m5Qc3rRo3L5rcJf1NV/YIbes4KFM5uCeHWEOf46/9?=
 =?us-ascii?Q?vmzf77s0OOAmWnOHgV3ss/Wolr95S4/uv1wWu7JNie8FBp5/iy5zOVhOc87r?=
 =?us-ascii?Q?x8FkpjTMbp1uTzmzMSNYMmPjWZR9qpf4SvmtpbDUthJhU5nW5/NDjCaZiOo2?=
 =?us-ascii?Q?bdKlnq9JAzKceO0ZS0OxAaSbD9vczhZ62s6fQFvhQ/ABtCax1n/wMFFQslJg?=
 =?us-ascii?Q?pj1YvxreZ8TTqFQzkatk5hA9GMWSAuN6nFb6ZTE41a+/Ll3+eE+6qbNI+oAE?=
 =?us-ascii?Q?ejPSgNwxA+UnKpqmAh5lLiPDiItwti4Sy0rp+9oTjpHPrEG5mX3+X0P9WCUz?=
 =?us-ascii?Q?mBNdKQ2wx2EhNc18bN7k6KC1fuNfVUurLf9NEqU+Q9LuDDKBORUMODWcczSn?=
 =?us-ascii?Q?Ad0rGZjXTSTJQkHWyBolPc7XKYetj6fRy4eOdiBgS8OF3kslQYJWKc6WRb6d?=
 =?us-ascii?Q?zei36CaIE91+QfQXz7KpKps4Ik7JGacBikrkv+zR3QTGuh+O67xcv58klRAI?=
 =?us-ascii?Q?7HoB5QkbYaJ/QzOInlMpz3g/O/NNSDNiBcCR4OBdHMRWd+PylcdGXJA2DsGx?=
 =?us-ascii?Q?CLwI9VZPiCHQEzBN3TR9xyuhG33rE7ORw/Ha28aHsKvGOe4JZIeqBpGv14rp?=
 =?us-ascii?Q?hKQqrg6hhrRkyUIOc4rAgG/dmeknSNKBCjfF/A7//C7gAsMCrJfChaLQSDrA?=
 =?us-ascii?Q?e5mW2ZhJ3FAZIQIFZ/2RiylDmEM9LCUmBIytHNJi59NlQ4yu+A+xqnFndVVM?=
 =?us-ascii?Q?72yFBZfpSfknrpAcC7rc7QcqK7X3lLKlD0C76FZnR9f0RqmERH8o0XO7D/BK?=
 =?us-ascii?Q?FMNNZCc6bJNRvdzwCdoaGBK18mr4cmTVShePmNkuoPot/ie44N+WSPCGpWal?=
 =?us-ascii?Q?tGeAdJ+fYz+wnnX7jJOmN05rPp8eOy3bzxyr1aD+X2f3XG5Htcz56jI01CMv?=
 =?us-ascii?Q?8eMd1IP3qK2Mvul9rWhsXjIK3zHAB+y9/tggpiKPYLBxqT31JkG8zz5RMZw/?=
 =?us-ascii?Q?4TPpHfeQ6Eyd4vwSSCjbU0ANY9KrZgT9L1wqoO9KhgwaypbU8Bzpuv2Jxg7W?=
 =?us-ascii?Q?7I/xzaQAj7EgMW2Iz9YlWAbuAxaVSyufvtgyBu6p/bgLHnKCew4bS5AN86Om?=
 =?us-ascii?Q?rt8QjuK/T6H9SD1YPjy5S1eVNJ9feyrHgOXEcYy5NRrl3s1zPE4T9AWufdvo?=
 =?us-ascii?Q?zRF0zxp5i+u+F2zAVdoBTJctGNgxJ/ulN2VS/Kv2VxEghc4MZuprrYA/6AIK?=
 =?us-ascii?Q?Szu8Nbgv8q+XxYWSHvE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da11bf3f-d9b0-4668-0b8b-08dc1911b611
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 17:11:44.1618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mZH+p4t6AROBaMs00IQwVYlLYLacZOC/fOT5Kgx8g89Nc23u70VkwMD5PvwiTygmZYyO9uNUH64vG97YQjNXGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10045

first 6 patches use drvdata: flags to simplify some switch-case code.
Improve maintaince and easy to read code.

Then add imx95 basic pci host function.

follow two patch do endpoint code clean up.
Then add imx95 basic endpont function.

Compared with v2, added EP function support and some fixes,  please change
notes at each patches.

dt-binding pass pcie node:

pcie0: pcie@4c300000 {
                        compatible = "fsl,imx95-pcie";
                        reg = <0 0x4c300000 0 0x40000>,
                                <0 0x4c360000 0 0x10000>,
                                <0 0x4c340000 0 0x20000>,
                                <0 0x60100000 0 0xfe00000>;
                        reg-names = "dbi", "atu", "app", "config";
                        #address-cells = <3>;
                        #size-cells = <2>;
                        device_type = "pci";
                        linux,pci-domain = <0>;
                        bus-range = <0x00 0xff>;
                        ranges = <0x81000000 0x0 0x00000000 0x0 0x6ff00000 0 0x00100000>,
                                 <0x82000000 0x0 0x10000000 0x9 0x10000000 0 0x10000000>;
                        num-lanes = <1>;
                        num-viewport = <8>;
                        interrupts = <GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH>;
                        interrupt-names = "msi";
                        #interrupt-cells = <1>;
                        interrupt-map-mask = <0 0 0 0x7>;
                        interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH>,
                                        <0 0 0 2 &gic 0 0 GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH>,
                                        <0 0 0 3 &gic 0 0 GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>,
                                        <0 0 0 4 &gic 0 0 GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>;
                        fsl,max-link-speed = <3>;
                        clocks = <&scmi_clk IMX95_CLK_HSIO>,
                                 <&scmi_clk IMX95_CLK_HSIOPLL>,
                                 <&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
                                 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
                        clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux";
                        assigned-clocks =<&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
                                         <&scmi_clk IMX95_CLK_HSIOPLL>,
                                         <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
                        assigned-clock-rates = <3600000000>, <100000000>, <10000000>;
                        assigned-clock-parents = <0>, <0>,
                                                 <&scmi_clk IMX95_CLK_SYSPLL1_PFD1_DIV2>;
                        power-domains = <&scmi_devpd IMX95_PD_HSIO_TOP>;
                        /* 0x30~0x37 stream id for pci0 */
                        /*
                         * iommu-map = <0x000 &apps_smmu 0x30 0x1>,
                         * <0x100 &apps_smmu 0x31 0x1>;
                         */
                        status = "disabled";
                };

pcie1: pcie-ep@4c380000 {
                        compatible = "fsl,imx95-pcie-ep";
                        reg = <0 0x4c380000 0 0x20000>,
                              <0 0x4c3e0000 0 0x1000>,
                              <0 0x4c3a0000 0 0x1000>,
                              <0 0x4c3c0000 0 0x10000>,
                              <0 0x4c3f0000 0 0x10000>,
                              <0xa 0 1 0>;
                        reg-names = "dbi", "atu", "dbi2", "app", "dma", "addr_space";
                        interrupts = <GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>;
                        interrupt-names = "dma";
                        fsl,max-link-speed = <3>;
                        clocks = <&scmi_clk IMX95_CLK_HSIO>,
                                 <&scmi_clk IMX95_CLK_HSIOPLL>,
                                 <&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
                                 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
                        clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux";
                        assigned-clocks =<&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
                                         <&scmi_clk IMX95_CLK_HSIOPLL>,
                                         <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
                        assigned-clock-rates = <3600000000>, <100000000>, <10000000>;
                        assigned-clock-parents = <0>, <0>,
                                                 <&scmi_clk IMX95_CLK_SYSPLL1_PFD1_DIV2>;
                        power-domains = <&scmi_devpd IMX95_PD_HSIO_TOP>;
                        status = "disabled";
                };

Frank Li (15):
  PCI: imx6: Simplify clock handling by using clk_bulk*() function
  PCI: imx6: Simplify phy handling by using IMX6_PCIE_FLAG_HAS_PHYDRV
  PCI: imx6: Simplify reset handling by using by using
    *_FLAG_HAS_*_RESET
  dt-bindings: imx6q-pcie: Add linux,pci-domain as required for iMX8MQ
  PCI: imx6: Using "linux,pci-domain" as slot ID
  PCI: imx6: Simplify ltssm_enable() by using ltssm_off and ltssm_mask
  PCI: imx6: Simplify configure_type() by using mode_off and mode_mask
  PCI: imx6: Simplify switch-case logic by involve init_phy callback
  dt-bindings: imx6q-pcie: Clean up irrationality clocks check
  dt-bindings: imx6q-pcie: Restruct reg and reg-name
  PCI: imx6: Add iMX95 PCIe Root Complex support
  PCI: imx6: Clean up get addr_space code
  PCI: imx6: Add epc_features in imx6_pcie_drvdata
  dt-bindings: imx6q-pcie: Add iMX95 pcie endpoint compatible string
  PCI: imx6: Add iMX95 Endpoint (EP) support

Richard Zhu (1):
  dt-bindings: imx6q-pcie: Add imx95 pcie compatible string

 .../bindings/pci/fsl,imx6q-pcie-common.yaml   |  28 +-
 .../bindings/pci/fsl,imx6q-pcie-ep.yaml       |  57 +-
 .../bindings/pci/fsl,imx6q-pcie.yaml          |  49 +-
 drivers/pci/controller/dwc/pci-imx6.c         | 640 ++++++++++--------
 4 files changed, 462 insertions(+), 312 deletions(-)

-- 
2.34.1


