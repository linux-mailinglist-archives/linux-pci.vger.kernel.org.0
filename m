Return-Path: <linux-pci+bounces-1102-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E22815D73
	for <lists+linux-pci@lfdr.de>; Sun, 17 Dec 2023 06:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1794D1C21670
	for <lists+linux-pci@lfdr.de>; Sun, 17 Dec 2023 05:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3C9110A;
	Sun, 17 Dec 2023 05:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KaWMz0hr"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2067.outbound.protection.outlook.com [40.107.247.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0921136F;
	Sun, 17 Dec 2023 05:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LGNLime9wPvojAQQNMxevcNOeLrC5I/DTS+Xda6E2WhcJju8iKS4RB++n+zuA6h+1pNiwKxcpAIUWHjX6LNcrl/sjkJe1oXk+SmrmnhstNwRx46qg/OEHlY842jsqtkJL9iAY/w2DpJQiy503+TJDuOnVyLFuHShgOWXNbX5la3ROcPP02lhS04oQUzvetT2//l5k9ChL9FpX/ZzeSXkrPOXYo3jdRUvIZ2GYgdJdGvJXmB6xf4dR8NvSIVKzcCfAHaoDlRxAGJPe32Va4u5PpEMgbJGqlHpQZRexoZfqVZQzgCb8QaAeKibwh5NjmCh+KoJHX6WoxxBxOpqf8tZrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dvj0d9FBcMOKsEeJUls//kqQ5j1iixGM+C3FC7YnFgQ=;
 b=QoU1cvVaaW70x01aOKB5GBL3UBuJAdv4TqBmm5kGEOHICQ8EMn7nrC4rldo7kDiddXc8mTXG47v5qWdDiMUCPpMiyGYz3XSvd1YNG0lpWPzxKHx/4KWNfNKclt0rKhk7nRQ9fGeiXUmo2fr8u6BofhkXodednyAbJ+MYyGkqIorSR4c39Gdg0nYJ4w/8hEn8HU0J+RS0ErPdR+vOFbBE+9+j0YYJDcq9mIJJ41rg7YXjnN11kOi+AjCsHOTYxQvl5EUX5YW+/ikVpwVirxPaumLEJmTo0j+76HVddAH6303R62Y/6h5UgafCDRKqwIMA/5bshfwcSI3FLr7tnlzmLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dvj0d9FBcMOKsEeJUls//kqQ5j1iixGM+C3FC7YnFgQ=;
 b=KaWMz0hr6MWwpC76D7g/aCo4g1yAPLSelGDY3YKTulYICVWYgdi6O9+DXNKinApGmlxWVyKwvS5g+bSOlNAgkWYq5Rpn3NkKa/1PQxagpXOFNVpEVDjvte2zSQABSJYi0d+1AINYmoAfAIX2JNSvYtzuAOF5W7o0hIKbM09y9Ro=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB8174.eurprd04.prod.outlook.com (2603:10a6:102:1c4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.36; Sun, 17 Dec
 2023 05:12:35 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7091.034; Sun, 17 Dec 2023
 05:12:35 +0000
From: Frank Li <Frank.Li@nxp.com>
To: krzysztof.kozlowski@linaro.org
Cc: Frank.li@nxp.com,
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
Subject: [PATCH v4 00/15] PCI: imx6: Clean up and add imx95 pci support
Date: Sun, 17 Dec 2023 00:11:55 -0500
Message-Id: <20231217051210.754832-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0007.namprd04.prod.outlook.com
 (2603:10b6:a03:40::20) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB8174:EE_
X-MS-Office365-Filtering-Correlation-Id: 6be6589d-1a35-4ee9-f4de-08dbfebec7a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1JEPZYYV+U3xJSEMGij54ojgAOVI2oxvJk79ZEFo8GNvxc4U/2AZp4ou3hZJ2Neh3eHaaplAvBgeWpvXz1UFgLD+vMXOzUnXcTj7zz9oXE8c/I97GNbKI7VrQdcebLtFoy3F1+mUaKODJcahtldpWdUwEYvbiuRgGE+iR6UJahJ321b8vvIYMZJzXXHYzO4NfT0gvGN8RrJWVs1MtYSJCdggT1dspGbxEyhHOXKs7klOslWRQiQbsD8BZmA6rwbb3Gy/ZOYt/KIZPbpcUdKRM5nA8pJiMr/1kSOz+Gh5aGBoSR6GhJfC+DTkz3TIfdhFjbJVQRiUrL1a9ex+nqK0mxIFVno2pQj1OnDJRccHoE5jD6hLNejWuTkqLN0cX2Zk+5RyqDHGLaJY1BrYKrNjaRrcequoahROPTcJ9HVxfrv9VN08DaZ09S2a3eKJOlbiVzySP9lMDaaEs+VCxnEYjmr8IhtmFRDt+76pEhmtbLjH8iHAEY3FUDemQKYL93tIhXIpj4cqMoodMiNoA5QFdaPN+RYRAfKXPZKwTwVooAps8mi62I///11lR6YQ+6DreKEd4nq3Fq90DHPeOq6FDfi9sWof9wnAZTdYUCTwNqCeRZOstyp25Vbl9334Ex9y
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(136003)(396003)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(38350700005)(86362001)(36756003)(38100700002)(83380400001)(26005)(52116002)(2616005)(1076003)(478600001)(6486002)(2906002)(66476007)(66556008)(6916009)(6666004)(6512007)(6506007)(4326008)(8936002)(8676002)(66946007)(316002)(41300700001)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dtZbq3tZW27aoictjXOcdIQXx8fPfUtmpyvS5AZQbZaHwCcH2LMj3CY7+zj1?=
 =?us-ascii?Q?cE4+b0SEZDZOPf9YYa2W2PdPRMjlw5A1Ud01TeW8ehPNV6Zd/q2BUkVXtDc9?=
 =?us-ascii?Q?7K7J9Bl2lVOQHFRO4ITInYOkk4SbgnZq+V+OTYFGDnfxCRgqklTO8moppher?=
 =?us-ascii?Q?YQeL3kHchcC6Ertrha4H3sUm+McNhNUQM4NE2vkFuftHYoXz+S1Ps3Xf3v2r?=
 =?us-ascii?Q?z8JTldb56GXgW04Pkd3DG6aRUOKW08UR1ouZtFlTUUSugpbBgX00Sp6l26mv?=
 =?us-ascii?Q?g9Y1hJkLGFuDpWpZ4B2cmvXKzIZA/lRys7az/hWm+2QRbX7/AaTlh7YMbYca?=
 =?us-ascii?Q?9CuDtwmNSvEUBbTqyxQ33hC07jm77QYCGhGwmfKdaNtsJYhRZLdLjkH5tjEh?=
 =?us-ascii?Q?CDqSJ0YNdOGMMKYt+k6m4+bWk199ymLUbc/mszHFCDdASQauf7oR9QD6K2kQ?=
 =?us-ascii?Q?FlOSg60mz91KeDuzhpvRx47lSdLpbu+f/Oc//jPJFLiXJGFFvZJD4zbDdE3D?=
 =?us-ascii?Q?TMFrZaA8wjEMHJIWC3s2pKHNNKvn+bbstAcdKxb+eLvsI3Gi9yX/aSe8VmIH?=
 =?us-ascii?Q?T0k0ZXffSpfFndlWUCmUb0fF+lkyEKs3JpA7eY4Y9zbygDN9xgwz5y1PtLbN?=
 =?us-ascii?Q?HoNdw8oCIkd8wchsvWVBseOUWBGN3hR0YxZSf4w9m0Gnp3j5JpL4F4/5cSYu?=
 =?us-ascii?Q?oBgqJQrrSK9kXBMRJRxeE6I5YiCTSmDAGideC0O7+Q7ogdB8Ca3CSQLcQzr6?=
 =?us-ascii?Q?k+U/qwy5cTMpRLr22BvDK2Z/Ch/PQXfipgvarHioZZYJfim3GOwgzP8lt9dB?=
 =?us-ascii?Q?VZHfdzcFT4b18S9+fILfW0Z1ckORj+F54SQvr4ye+9K6oP1YHF5ou09EFKez?=
 =?us-ascii?Q?OkmkUtX3muiarEbp4m7Hyva5YNyI4/Ok+1SipAx2vdk9Zil2UvL42iFw+vEa?=
 =?us-ascii?Q?KSHyMy5LltVfxi4ywqs7Gam2AQ1E8DbFlzZSFVr+bLJdIlzpvHxn8qrAzX7g?=
 =?us-ascii?Q?RK92tRJOubzFOCMibLHa2rzaiw6VjQ8dqumKTJPfyfkAZFZURkhQn8W7JMBA?=
 =?us-ascii?Q?WLtTJF+mfOZpaxaUpNGynh++FK31jsUIGAbz70/CHDKSK6wWE7ED1WEerOTe?=
 =?us-ascii?Q?HIKmHzEbolEBddPM7chPnSpRBYrADBktlsZzM2UVmywzg0d5nm16ipHhM4Hc?=
 =?us-ascii?Q?HPUWmKeW4sUCJ7f8gLar+55Ghox7MTjfqoWZHWWWfjhw0CmWKuCphJzF2y2V?=
 =?us-ascii?Q?5X3JSA3K/HdME/YomqhCCf4w6K5MVGl7HpyiD2ozChwncZVhdIIelmv7m+jb?=
 =?us-ascii?Q?0+bGcg0VV6LhIVFurBoZIPjBLUBde2gY3K1EZgaLm6I1yWhiyi1ujBLPeVa8?=
 =?us-ascii?Q?1HqPnox7s7NrS8DLjQKtX6+Z9vgEKEIlVQ4fjmMHcyO4Do25XY2nrUjCbwNQ?=
 =?us-ascii?Q?NQR8WiJC163r4l4sqUMiXbD4B1jbLEdX6vNmvUsoP+nujFxq/MDf3CzF/LmK?=
 =?us-ascii?Q?IWJLDw++f+coMVbfHpJhTfBvaKLFqMAydcOqzg0x+HCY5Q+l+W+08pJFQMHX?=
 =?us-ascii?Q?vFUa0nIjrEloBYt754U=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6be6589d-1a35-4ee9-f4de-08dbfebec7a4
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2023 05:12:35.2159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z9bFaX8HeLQGfIFUElTu+GwfixB2U+0AI0RyNqd9CP5+hYIoPl0tQ0b67iDIiamxQj1Gk1Ncqh7OTY4NWxKGDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8174

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

Frank Li (14):
  PCI: imx6: Simplify clock handling by using bulk_clk_*() function
  PCI: imx6: Simplify phy handling by using by using
    IMX6_PCIE_FLAG_HAS_PHY
  PCI: imx6: Simplify reset handling by using by using
    *_FLAG_HAS_*_RESET
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

 .../bindings/pci/fsl,imx6q-pcie-common.yaml   |  17 +-
 .../bindings/pci/fsl,imx6q-pcie-ep.yaml       |  52 +-
 .../bindings/pci/fsl,imx6q-pcie.yaml          |  28 +-
 drivers/pci/controller/dwc/pci-imx6.c         | 628 ++++++++++--------
 4 files changed, 415 insertions(+), 310 deletions(-)

-- 
2.34.1


