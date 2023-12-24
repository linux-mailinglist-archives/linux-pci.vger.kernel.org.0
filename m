Return-Path: <linux-pci+bounces-1341-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA9081DBCA
	for <lists+linux-pci@lfdr.de>; Sun, 24 Dec 2023 19:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3733B20FF6
	for <lists+linux-pci@lfdr.de>; Sun, 24 Dec 2023 18:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBB2C8C7;
	Sun, 24 Dec 2023 18:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EEXJ7kx3"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2085.outbound.protection.outlook.com [40.107.22.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E85D266;
	Sun, 24 Dec 2023 18:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B1v4FqNvm8O9gtTKvdW8QvRpjrPGRxmK2dhMHJjMjbQ10WegDVM2VXGr7hL2/BcOpJ62z9wuUaVdQ9MykjDr4wCEnI7WoXej3jA/qioGNMK1bwM0qLR7dwuBXSPdoM85VLAhkBY1AsSx3vjnjT5uCXAVUt2D9MvrauUipQOmb/CY1uR2Xci//Y/xcClG/uuHwEkYBeWgMfGVyE9d2rlFQzPjWNGFi5BIh++ja86ol1/Msv0EuMrxgPXhqz350ao/J+IDJwLgjrjEJNVn5x5fljXRHdF9Y17XaZFI7aZ0ymqJBN/66a7ESQDqAxnbHP/3tvAxGZrSlJo5Vz3v1pHQjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DzfXaHwhpGJrlOiicly0YZxCE/pScxhw2QhpZqk9HcA=;
 b=nIEDPflh+Tyzpzx9EKL1bGxDphQT3oMKwvsMsUNftvB4PNzPB74Ic3dpJnEjum6Owky+1MTNPtiNUHsoBBPn4oIlmLrG8fJA+MdHtpwNHNqfmOrVHlBUaJ9+PQs8UUcqkEBMfcPUwGlBLa6YEOKcuDyLjz3Sjx+9MuHiHHeqJpFPIFdnNj9Gm1L2aF2k/peLYjXiHsrjV/4ioGyaSVFMHhIjx+MublXvJJzh+WtRJJBAUa64RS9I5yfU8wMsNwaugOlkJP+diPL/DMtNY6qyY/daWFRFpvKWjwcoFRt1L56LuIFZd9mHEe2KUxvNplq1wDLHTe1Sp0u2ii37MP5LZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DzfXaHwhpGJrlOiicly0YZxCE/pScxhw2QhpZqk9HcA=;
 b=EEXJ7kx3Ef2blFEZ1EwEysUN6Z88ZilZmvbCbaO3tMreWkmn6ueWbZvumf+4HJKuUjoFtWADWieIe1y0dnfyAuuWw6IkX+yg/yQ012jDLeFY1hKzuq8MMF1sxV9CoIjMtBRJzCPDdflPYqamTDr3d96MWSEylx1h9aV+H57MSMg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS5PR04MB10020.eurprd04.prod.outlook.com (2603:10a6:20b:682::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Sun, 24 Dec
 2023 18:33:01 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.026; Sun, 24 Dec 2023
 18:33:00 +0000
From: Frank Li <Frank.Li@nxp.com>
To: krzysztof.kozlowski@linaro.org
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
	kw@linux.com,
	l.stach@pengutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-imx@nxp.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: [PATCH v6 00/16] PCI: imx6: Clean up and add imx95 pci support
Date: Sun, 24 Dec 2023 13:32:26 -0500
Message-Id: <20231224183242.1675372-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0169.namprd03.prod.outlook.com
 (2603:10b6:a03:338::24) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS5PR04MB10020:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cb67010-debf-43c4-ad3d-08dc04aec186
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9wHTQ4py+wAESetb1eOEYmTlNhQdEFBIAyCQVD2iBBedrBfF1E7xabsBIDZKDhnf0YyESF+vUW0OKhueEtR7rXm2Li1XRDbmVJpl+KZFO8PrYJgzmtVqW/oiR2V6o/dvN4LCXnFM6CTxkv0y0VSUnEtE3tMRORLxFUdUfgObgWjzevjFYV/F8fU+8Y0Ix5NNHaDswcUDhqKcEVh3CPUILUErKGjqX63NVA+uq/1C+b4GR/MaOaRGIiuMRbkFa/QosugHifrIeD72obXwx0D3T1H4pc7dhq5hglB4Pzkacxxs0eKZu9eOHjuK0V3t6ZMIu8nK9UROteeBSB3eD3GqPEkOd4Rd4YMbigeUj6cMEj/qu2hMiLrBTrsOH6DUili8uS/tqqnaH3LaiH/dp4jGNxg4VsSRdNUCoLw28epPQzNf1kSehTurwX1E+TN3TVUk1+bQ18CI/6MWHSlwJuPXKluMIlcAhg1jiw2jkkcY1wdH1CK2Z4pXSEF0UsWiZCaMzNr50UT3gkR3FHbjDxiWvyOJWDhShNSpW4Z2fZcsqS1hlr/JT01MRAfQ2enMfuQzo8jC/ltb9kXDd9AsnQQS+368Ua27fN7/XHhdd5AlOgxY9x5DD7MiaoMxY8ZyyPcm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(346002)(376002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(38350700005)(41300700001)(86362001)(26005)(36756003)(2616005)(1076003)(83380400001)(38100700002)(52116002)(478600001)(6916009)(316002)(66476007)(6666004)(66946007)(66556008)(6512007)(6506007)(8676002)(8936002)(7416002)(5660300002)(2906002)(4326008)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AQFC51soZ3e9ogtmL46ryFz7A+kBWAGaMFmNJjgHZfqHYpp4/C84gM9qybUK?=
 =?us-ascii?Q?QujqFDKCsH3QszO2fzKEyNxDfrsbThzxLmNsFbd27bEtBxSZuXYskOfVe6VA?=
 =?us-ascii?Q?alvtyj8J+oPY1uZi24zWd88bRXXZDtw1+QqQyPzI5EfMw6hXR4ln09ghAIjg?=
 =?us-ascii?Q?wv9tJmK2NJ+W4p76C2MGfN+qXbld7nL3V31AhFhT38c6uJyf57ThGYYQgFKf?=
 =?us-ascii?Q?rOvjBjPYbaV1GYw/+qWD5F2isZhOMMykn0W/K4m37JjcE6GUaCk1tbWSGYu0?=
 =?us-ascii?Q?Q+A1euv3PCS8hKj1uO3lwsxY5otuSMuXQiCIPkz9NgLYOWN4Jd23WWJxQvOV?=
 =?us-ascii?Q?jsGvpx/hHgR1v7BpV8mVShOvzfTDe1Cx/9AXWhu8/sH8lmFAuC5LFkw3dJCu?=
 =?us-ascii?Q?1jrlgJcs+Ve3DEqlMTCyyIBk3DM9R9a2/NPEVAMkiNXwLnBBBzKLt13iqzQH?=
 =?us-ascii?Q?meUYb6POc0q/6JnSBDz70lKb8o3hu9hjsOcyB2N7YUKbhy7aUevcCtX0O8wC?=
 =?us-ascii?Q?B3PJu+voUct140SLxRanfTxxMYQDtGRIfU1TLzpC179cnsDmRfrB6bkqwTGs?=
 =?us-ascii?Q?0z9sEKjGrNnq4odiR5kLs6P/psl5pABQ4PhdmUCYJxC0uabctG1s1W1zBZS6?=
 =?us-ascii?Q?7hZgE7KIn6DAfrpD1w1glkqSyqIYgY983iNsjGTZbDFYgZ9Jg4xdQ5Hvqvd7?=
 =?us-ascii?Q?le+/yZChs3l2P8HeFKHU9Lzy4Gss25B9yvaE44BgpUEcvFVulf4WLacbf4Pw?=
 =?us-ascii?Q?C/H/qxHWnyDBzo5I3euglW5wl6LMSxFBPYc+uouYDltVH+LpueE7lFRnOJTB?=
 =?us-ascii?Q?fqpeh5KeyYGlxqEad8yKMO+Y/nCwcjDu98GG9ivuy01h2H5Yh/OZa3/CcMdI?=
 =?us-ascii?Q?sAtHKrAC7NJatT41Fk1u0HHfH8L4J5vAeAgMctkJ+jd8A2fLhIASqJVuGvrB?=
 =?us-ascii?Q?sEkLcTKbzTT2xtjIkqw/MXva7bqk4S1pfKSyS6Z9qWLB11XKfDod1aVgs201?=
 =?us-ascii?Q?50IBSj/A9dfq/+mp+ptu+4YKpvncWXGAfc3x1z9YjNsVp26EGAv6FQS9vQmz?=
 =?us-ascii?Q?ptcpWVcCEEFLYt1OGiCq+g5Mlss7m+toZCfl8xzAXASCaHtCREfbu7bcyirt?=
 =?us-ascii?Q?19PSoJpmMMjDEIc8jVlqza4vpXILn2xavryPrMs2HIH+26lr1oXzt7ejB3bF?=
 =?us-ascii?Q?yX6JmMIRumlzqDk3VRgd+Aeh1XgTkVzDh1LJbjtobxoQsda+ZmDJEnUQD3El?=
 =?us-ascii?Q?tpl5EVnMSd6I7fEpGKlE0ESHFcwjv69ogW1JtYvbw/P/JVaC6qvsTz+vSU9Y?=
 =?us-ascii?Q?2xRLlmOK/OhpLXO2OFPjObZDiUkaIPJhIz5Bme0bIp1uelphMNYis46l8iZC?=
 =?us-ascii?Q?KLZaZ6DWIPm8I28iTX/IEmXQoUVsV3DjkVENY8E7Iq7r645S7Ztb58nymPod?=
 =?us-ascii?Q?jDuSsWjjNmKy0suZmseQAT84qD5gadGuJquJ8cy+DQy3FvX8qcrmc+EQI8la?=
 =?us-ascii?Q?q2fuyqOMh2fqchjphaeij/wo5b1WuqvJYbfzkGF9mz6NtM5Y/ZQMR0Imbemy?=
 =?us-ascii?Q?3HSjzM83K2W4f85k8GE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cb67010-debf-43c4-ad3d-08dc04aec186
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2023 18:33:00.4757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bN5KFMp/VK3gWdjVejJTJKWrGXCl3S+wURG3Rc5CCR5IVTcCw0UliZ+pGW9q0AH0DM2e1chvyFc5LFK+AwdaOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10020

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
  dt-bindings: imx6q-pcie: restruct reg and reg-name
  PCI: imx6: Add iMX95 PCIe support
  PCI: imx6: Clean up get addr_space code
  PCI: imx6: Add epc_features in imx6_pcie_drvdata
  dt-bindings: imx6q-pcie: Add iMX95 pcie endpoint compatible string
  PCI: imx6: Add iMX95 Endpoint (EP) function support

Richard Zhu (1):
  dt-bindings: imx6q-pcie: Add imx95 pcie compatible string

 .../bindings/pci/fsl,imx6q-pcie-common.yaml   |  28 +-
 .../bindings/pci/fsl,imx6q-pcie-ep.yaml       |  57 +-
 .../bindings/pci/fsl,imx6q-pcie.yaml          |  49 +-
 drivers/pci/controller/dwc/pci-imx6.c         | 628 ++++++++++--------
 4 files changed, 452 insertions(+), 310 deletions(-)

-- 
2.34.1


