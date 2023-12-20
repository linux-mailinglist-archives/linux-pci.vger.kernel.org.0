Return-Path: <linux-pci+bounces-1232-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA5C81A81F
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 22:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 611DE285FEA
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 21:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B81495DC;
	Wed, 20 Dec 2023 21:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IVMXGxVo"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2074.outbound.protection.outlook.com [40.107.20.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E7748CF0;
	Wed, 20 Dec 2023 21:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VwrREwPvFDm/3NrYS8cQXrjIA66LszvwiwI3C8aTdU//Vs6Ek/zzB/ffgbV5J4+lmR5lISGUV065XsoJuarF7KyX34fMY3q2o/mpmTS48Fw4veElHH0lLsGYDChcNIV8UKFMbgeqBSYou8EMmsxaP9XqQv7rREQyoljMRL8VcYq0CL9fhUNk7nSXb0D0q5kLOkC379GO2DVuINBcbNXNjlh0K4ci/YpmhzEGHsSqBlcVj2NXVVoy2DlFwtwLQVG1uobr7T/0wxLHetrr6k7IrRLIBBnBBJD6TCjKi2+j4GfGFeLA9O3gGQbdsGFlGzUYUd7t2ticERPyhubbuh+H9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T2UhOf4tMLjqCdjZTnvsMfNrO8+jEp5Nx4eT91hkVBA=;
 b=JAu18B6L8JL8OBH0ZYdQphEeeTsbzD8qj+IQU4jfmCYlNTZDpii1eYtQj6FRHw05+xnQzJ/BZzDceruq9ziB/3VYNwJfquxodny8Jvnnnaf4ePnuZu07u9RWRJL4ba9yo18MA5Xv9eDkd3RbEm9jUmjcHGrRyybXVV4mwyLavdMGtKly+GKf+FXjaa3SgtPVENDVXD4edUK85bPVB/fcULprJjkAWByJuV5EbpEhFZ+pI56JQcjVciibMTi5feQfJVINWXqD6uAJjt7Weusfgol2DGK/s8kgUthyIEjuxEtfWUkb3nX7FeXIWGJERzTuOUOm/KvV7acRirx5y2dx+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2UhOf4tMLjqCdjZTnvsMfNrO8+jEp5Nx4eT91hkVBA=;
 b=IVMXGxVow5ckQW8DYz7TESE81V/aJQLGZfL9C2RVAmGthmuHpqyYopyJ8rCodvg8SavKdWN+wBumfl1yNcyvsETPDcA6IRQgTh5X0bmH3IAqHp7ZwkqiokXoSkvnywdVDnldDRzL0jx+eecQAaYJsMRHx8hE+oQMVkmKUhxGp3o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB8PR04MB6777.eurprd04.prod.outlook.com (2603:10a6:10:11f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20; Wed, 20 Dec
 2023 21:36:43 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.019; Wed, 20 Dec 2023
 21:36:43 +0000
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
Subject: [PATCH v5 00/16] PCI: imx6: Clean up and add imx95 pci support
Date: Wed, 20 Dec 2023 16:35:59 -0500
Message-Id: <20231220213615.1561528-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0110.namprd07.prod.outlook.com
 (2603:10b6:510:4::25) To AM0PR04MB4834.eurprd04.prod.outlook.com
 (2603:10a6:208:c8::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB8PR04MB6777:EE_
X-MS-Office365-Filtering-Correlation-Id: c8ec618b-7e3b-41bf-246b-08dc01a3c21f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9TzhUcUeOAl1BFfp5pAQrbzc/Uns4nyxS60m3EloN4EXp3fQZ2ob9yiASebBf6s2Ustoz4w9DRgw4+AUTd/tzJmhvk3OmlhAtRHNfiNnq9yxftQxGk1DOyVkeZ01QMpF/JqtioDe+4+aMGM42w/P2LcbSNCOXTwDymmkWhctKXWz3mnb6FBUmXXxwNuQRzE27SpLMMRxXpOYyZmlslY5x1c+517QILJWvhSYPDbqQnSfH5gSWQNx8RmnJnnjiHhGNWaqWwc0IzMnYjCz6OI5q5B5bATdq3wOG1EipwODcFJbLD1YVWdilGzMlLx3kE4nkhqOL0i3iKCOCCWTKjdoic8vF6qwgPEncr7wWWj+tsJ8vWcTAWOXktmLdtiAQwH0xA00Y0k/yr+276bTAwN/YF/+QPvr5VGS33MadK03z19GrLz8xwPhas4tHvtVtXHquwH0OZbmFNCXxqjVy0gcXOuAAMnJqL1j5Z3evC/wZ267CxbOBTrlQ6sybXdPzbJ9BlbWPXaYrnPBbaDtPLjScIHauyJQ+griQHSGHxRLQRjlL4dV2d5uhZQuwJKQmcZ00bcoJ3eUus/wSEFaJah6NmH+Xz2/qK/2fzO4bLXvDcjrLayA3RFIRqiWpflMl47/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(39860400002)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(6486002)(6666004)(316002)(478600001)(6916009)(66476007)(66556008)(8676002)(8936002)(66946007)(83380400001)(6506007)(6512007)(52116002)(1076003)(26005)(2616005)(41300700001)(2906002)(7416002)(4326008)(5660300002)(86362001)(38350700005)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RRR9uAteuIHU5QPmrcH6Nre5/BjxIw6GS7elUNsoyBpNfcgvgMXj8exAVPPg?=
 =?us-ascii?Q?YC35qV6vPXPXc0T/PV0WEHFUx2Y/95T3ueU+YEmH82eJwLMUbphgcJrAMTlY?=
 =?us-ascii?Q?AF+dc+ouW8e0pJFzjaQy/yur2px+tszEB9V/4H4i637B8q2w/9Yu783VGnBZ?=
 =?us-ascii?Q?CvXmcOelo7KOu5KJDLoPsnKHTGvsI+1FqprE74cvsrL8ii7a78qSeSuTw0vH?=
 =?us-ascii?Q?MJwI1AE0w2/k8wNSoHRB53unGpcPS5zp65XFgCAoQHXgmmibQYvyKOufuJHO?=
 =?us-ascii?Q?pr+lPKhSlNYaHuaBtmQy2iei7Kphc+/aNXtLrkfrYiqth7pxZsaUFdLlW8xK?=
 =?us-ascii?Q?dWTNvSgXYSq0k2M42pklroNW1adQ7DikMF8bNvYINWqv7uUXxvXeNA47hjAp?=
 =?us-ascii?Q?hQ8rUk68S+Pqr3nAUdwzFLR5a/7UW6uUS+fIt61iSs8HN/3Azb2togGEKjh2?=
 =?us-ascii?Q?eXqnYlZqqHIwAems9pW87jGA826f8XdwLO7bBHOlsTZmUfQvKOP/zS8aDOGf?=
 =?us-ascii?Q?MLmo9XzeZ1/e4ZlirjD3+15jl731WI/amZbe315MY4jN0QKcsqxmnTQyWSK+?=
 =?us-ascii?Q?8B5W2juQY4i9e0gAcZLFrvxL7EDROYnavUd8njcerUTx3mtFDN3f2eNcdemU?=
 =?us-ascii?Q?KOtiVfEP0d0sxnmEhtir3obAPwKMkdlqjqhqbOOkI1iX/jr3kLZDVSbYOiKG?=
 =?us-ascii?Q?mO2zBXuMraHa3a5NvLhppRazUXGZupztCXU/ofCCbFL7obDBhWB52TD36mRd?=
 =?us-ascii?Q?JJvqwXi6Tupx6+xkWk1jr/+P0CstJGMEcXD5CfG3Dcd2TnTeVBT82pbymPe7?=
 =?us-ascii?Q?CeV8S3055eLvHnP+VhBcf1eB6kH+5rTBeKIy9LwHkQZJusKTj6B2qH9hMRCd?=
 =?us-ascii?Q?KyXf2UfElf87itts0duTfkPMkwDfMKqb3T77jrUgizN1xkWK54tIERTh10Ju?=
 =?us-ascii?Q?35zwqdSVji5fQXFQbdSFKv+XBbN3khHvsiDkq0SbIEbBx5dle6+MXIgAYNMB?=
 =?us-ascii?Q?BtMMfdW/IYlAsVC1JURba3wrEYYfqGNZAoWpHv/7NXsAvj6vUV+gmX1CJBI/?=
 =?us-ascii?Q?ceaY+O9H7/GHLTDV3CeuIZPAz15KfKBWArcMl9WXw9T8zUIr3M9wCtlUCf0J?=
 =?us-ascii?Q?jdoGs7k2fjny6BA90NgeY/waiFmxHKBPvnPLkaPITObQz9DHrg/QxDE6jvIz?=
 =?us-ascii?Q?j00mH2dcUnSP7qvr1IVAbov9nAQfgUHx8TKoLrDiPc4Xd9wncd/GLz93ouD8?=
 =?us-ascii?Q?F3pQvlvC1J6EBTyTw3ye/kXy7+5sDcEZ45/bqEyt12DWlny4Ws2DOCQm2G43?=
 =?us-ascii?Q?JgwR7BwfwO+Qeit9hglUNMDit1Jx7NcJAE13YV8WSj2WmdFPgkxLHCPiDq62?=
 =?us-ascii?Q?pVgELVQ4K9NlELO/HNPdo/iSCKf8Kak6rlHS73LEO2cPeGFI8Ir+UsNV4PXx?=
 =?us-ascii?Q?9BOUwS43JOV5AIysHeAIy4Ra5G6R3DAO9rL8wG565wDlcWvN5qOIXCCzTPWm?=
 =?us-ascii?Q?G1zX+FFr2Qx5XPVXBjg4KogbU5L5qliPfKaPntutD5NdZeHuyvzZ5KafR45x?=
 =?us-ascii?Q?5ZwhMxtTlT+Gg3MlTtE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8ec618b-7e3b-41bf-246b-08dc01a3c21f
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4834.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 21:36:43.1684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zjrkKh2+MQ6TPcmXRTU6qkZQlCM6DzU8eJ9RfIQRhw7vRAp05YKezEdrMUAEbbIkSuUwtk0nLNtYcFNCKK/Muw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6777

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
  PCI: imx6: Simplify clock handling by using bulk_clk_*() function
  PCI: imx6: Simplify phy handling by using by using
    IMX6_PCIE_FLAG_HAS_PHY
  PCI: imx6: Simplify reset handling by using by using
    *_FLAG_HAS_*_RESET
  dt-bindings: imx6q-pcie: Add linux,pci-domain as required for iMX8MQ
  PCI: imx6: Using "linux,pci-domain" as slot ID
  PCI: imx6: Simplify ltssm_enable() by using ltssm_off and ltssm_mask
  PCI: imx6: Simplify configure_type() by using mode_off and mode_mask
  PCI: imx6: Simplify switch-case logic by involve init_phy callback
  dt-bindings: imx6q-pcie: Clean up irrationality clocks check
  dt-bindings: imx6q-pcie: remove reg and reg-name
  PCI: imx6: Add iMX95 PCIe support
  PCI: imx6: Clean up get addr_space code
  PCI: imx6: Add epc_features in imx6_pcie_drvdata
  dt-bindings: imx6q-pcie: Add iMX95 pcie endpoint compatible string
  PCI: imx6: Add iMX95 Endpoint (EP) function support

Richard Zhu (1):
  dt-bindings: imx6q-pcie: Add imx95 pcie compatible string

 .../bindings/pci/fsl,imx6q-pcie-common.yaml   |  28 +-
 .../bindings/pci/fsl,imx6q-pcie-ep.yaml       |  52 +-
 .../bindings/pci/fsl,imx6q-pcie.yaml          |  28 +-
 drivers/pci/controller/dwc/pci-imx6.c         | 628 ++++++++++--------
 4 files changed, 426 insertions(+), 310 deletions(-)

-- 
2.34.1


