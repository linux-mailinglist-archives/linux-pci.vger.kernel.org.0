Return-Path: <linux-pci+bounces-1838-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39595827B5E
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 00:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B68A51F23F1D
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 23:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9F155C08;
	Mon,  8 Jan 2024 23:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VtKdJikr"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2077.outbound.protection.outlook.com [40.107.8.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECDD1DDDC;
	Mon,  8 Jan 2024 23:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gs+eXVt5bNz7HvXs115MNwb+CJmYcCn/spC6GbR8IYWMGE/go4CPU8jwgBM7Fot9Tuu2lxNqtZJTH+zsBznC5Tq66jwcTYSgsebF7jOjCMi2DylE0/fw3kU10iDfNhdm2toFgIantumcVHsXjHsZmwGqPcUveZnqXsjnZo6IcYIL3EtibrPV0OrRt1m2aBUVksquufaVTWZ8BsZRWF4gNh3lHMppjYyVqrWJFIO1aQQgBZI7/iJWL3elgo31HdafK/6h4E/TrlSK8ypDRN/RZrHCeygkbWNcbg2tPASkY0eO1b6YI/LpSLhFUuHEu2CEdxX3kZ8dO2TYKYigDsRnrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TfSJ20Mzh34YMVizDGPzws+RiZ2TDZVIflUYDChjCSQ=;
 b=LaAq34cAucCJiAPnQaKDdGBiUfaE8WNJdvFrK28+dK78rch5EE3SwTLtR8MNJgN+r1Tp1w0riTo1lmSgD6gaNU/NzrCYa5DxVbqupeHT0/eVo6HqfoNAhvQStvSi38kCLHpIL8pgsTE/JohCIfEJOoxN1LmfDbhEZVnUq45/dn+IJj7o3naXH+K+OvbEI/X+bb39Fz6fjctJtNncE/ifweFTM/US2VsdrFN2XswkSuzLOWPnyivdwtvvOfkagdUxsomVPuwVBEn8DRIymIFb7qFIRkQjaUMlGT1EpE9Jj+aUSu1amXiT6SmVDU1VhNrmXb6JdM/wGHvr44gZuushfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TfSJ20Mzh34YMVizDGPzws+RiZ2TDZVIflUYDChjCSQ=;
 b=VtKdJikrKME4rwYxZWPiiCGzUzXVR2bz4cdtQxKmE+KHzzKzIFga9F/EX9Y2O/Cn28ukHzA3Q1mv1FbA5MpVXVl03Y2bcyLtCLnrQfR1SuGMfuVcm4zYLuyrzml0as/Ph/eLxW9ciDHVd5ai5riqb62hWo41imY7F1II0+1lqGQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com (2603:10a6:20b:23f::5)
 by AS4PR04MB9338.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 23:22:07 +0000
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469]) by AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469%4]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 23:22:06 +0000
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
Subject: [PATCH v8 00/16] PCI: imx6: Clean up and add imx95 pci support
Date: Mon,  8 Jan 2024 18:21:29 -0500
Message-Id: <20240108232145.2116455-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0063.namprd02.prod.outlook.com
 (2603:10b6:a03:54::40) To AS8PR04MB7511.eurprd04.prod.outlook.com
 (2603:10a6:20b:23f::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB7511:EE_|AS4PR04MB9338:EE_
X-MS-Office365-Filtering-Correlation-Id: 7014cf82-c396-4533-e543-08dc10a0a095
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qQfm576UrXS/p1omJ8Qyo6GqwW3xEL0e3nImwSUIL6gnJfEtKQbwix1DS2E7H8KZCOmbl3PfYiz8BFvj1LhGxmgnoTAm7ibwaY4sJRz6UxZssAhNBiSn312BUY5k7s71hxmZ5La1hKOZaE1LFo/+70nboBmqVi4m27ndJtk+E9E5tZwSYZnt3yClwomGbw47WEW/Lf3NDHE7x09wxDqy2Voa0q7CwuEjMhI4xsFAchZQLEGcBohDbJkYjzLxXyndcAbJvthVqG/IC6t6WqE7SVxwQ7WSrhurGwptvRYUT3VBPZJtv22berpXPNlYNeJ3oV+aMnEL3STXNR+J7B/Omz1T+gQ5pNh5o2irxjKh9/T2GGGuxlLn/1AgyFGijv4Fw/ncRPrEqeBiQs8hBXBsb5SnTB3mkwsy1dPHR5ry+JTqR8+bCWFa7M5xx+jsDUgo6yP7ROFe3M0r3NFxY4MvT4I+88xNiFiCBebmZBfZVBbT+6aVAowSUTyuvn92Bz6UEP+JVnpx7nNRmu5w6h2p7jZg2hJ+3oJNmoezGn3MTwshyObPgxL94yK0WNK9Ur/r5CAIM0gOIjikad37+qhVfXqapgTP0hadqvwL+m5YAbzQ2lJD5KE7+nyVfZDc/ve0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB7511.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(396003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(52116002)(6506007)(2616005)(1076003)(6666004)(6512007)(478600001)(26005)(6486002)(38100700002)(86362001)(38350700005)(36756003)(41300700001)(83380400001)(7416002)(66556008)(2906002)(316002)(66476007)(6916009)(4326008)(5660300002)(8676002)(8936002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qydj7RmSwL69WV14VqKE276mQHoT535Soofl65BcTfAsOWxs9f2BTJmTG1uQ?=
 =?us-ascii?Q?wtKk712IX6OqQucA6OZICzx8fdgXrNd2Oh9oYLFBaZTr46jcf0AbQRArdRdd?=
 =?us-ascii?Q?7hpRNAvwtjlCvpoZ0+P9JJiqaAa1BAZ8c2BYoVqz3r6/TYcIwxAj3Ayay1xS?=
 =?us-ascii?Q?X85Z8mMHJBUeCnhJsbEei9jJP+BYfu3+VuYpOJfvIzDYzDyjHC2WZh38G/oi?=
 =?us-ascii?Q?qILXqahKSVGFPoSq1SbqaegJXsl4Ex5lv3r26A5AT5nxBS+Ztn+7FBnOnc5h?=
 =?us-ascii?Q?oEIqqhtra94wwjaDCy+s3ZVyxzq62l9Tmi9E0xPHHL+6ba6CN8Gd4yuW075z?=
 =?us-ascii?Q?5MZnuw5Ih2p3SdBhFxa9eWDLs+OWoysd+Zsa9bdANI/82wFH0zkzxC9AOcwW?=
 =?us-ascii?Q?o5Aasq39EXqyPbd7j12gVlAzPgeCkW5G9w2RrJB+k27KsBDTpLbwFRtjB3A6?=
 =?us-ascii?Q?rHse1J6s0yDk8HbHvMO6zzSCqH3BzS/Tn902oeQl3bj8+FqS3ek1Mik6oW2+?=
 =?us-ascii?Q?fyMlLkBkymr6KtKrloA3/+1DakcF5hMFfp0uKUQ2MyulEZyTdIuyB8SToy1T?=
 =?us-ascii?Q?17co35Q/OlOKhHXyWM8q+En6SUCm7hZJbFh605ihzx0R4LRGzBefEhH75M7s?=
 =?us-ascii?Q?tn3U2LD8F2M1BwT7IG+xV/fwoihUR+m0+61axEn0LoxikJb00SZiLv0LWrE6?=
 =?us-ascii?Q?w/Ezq4E36iSUTj86M7NE4yaebmhd+r+TGAVPu9I+ounUDACOJkskSYuLZUQW?=
 =?us-ascii?Q?kdZVyrFbFsv48xnUCAVOs4Qfj6k4xQnzysBROX35ZBsrzvztNWC3xgXsEAZ/?=
 =?us-ascii?Q?3Rae1Pgu61I+7UIHrvFQls9B1Yb7wa0dtYScxYmWC+xWeQYFW2wKbpdSZCVY?=
 =?us-ascii?Q?WeVJpAy1XXkUdM0nexpb73eZ+cM2nwbcTNvpfyAbOb55ffbQ4FRAt8114rEA?=
 =?us-ascii?Q?uqAS1fHlv7yUvcuoCCpcooq3xaXbzYnnjTPlzaQVHOYfPND0SbCTw0wRuf0J?=
 =?us-ascii?Q?6dPuFh/T00lvihIX+pFHAoa2/G8oVzjNuH69H+B0qJiLhCaAzsq47CIFkNkr?=
 =?us-ascii?Q?TG5pq/UEzrTLEm6SZiUOk6jFZAwCxny8w7TSR/KJ5xAfRv1Kn4vmrlketVyT?=
 =?us-ascii?Q?gsiJ70GTlJ5FSJBoiNELv/iOtqrPShBQSZjMX2POXXezNMBoIAEXo1tJT6Ce?=
 =?us-ascii?Q?sF/Qejpc2heEsgBzz5+3RvbtgukN2EG5qSGR6yWrqf2ZUsjf6qVYhlLOsGR+?=
 =?us-ascii?Q?QKXHs7naU4uS7S6fB9lwyHWO+qbveHQ5PlMWekAWEFh1tOlCEr2L50vtE18E?=
 =?us-ascii?Q?cqwoTLkiUR9PY3bp9I6TcwoC9NBDDJ+RoVnYMOk483CGb6HHYoyuxFbXbxaT?=
 =?us-ascii?Q?pxG3fuUA9e3QJePmO54J2aWtFsHg9PQmP2dxQmtCvmdo8qcN5u3kqPQDlNzb?=
 =?us-ascii?Q?ogJLmqRmN3ZeYZfMb5XBWjKVSCLacxWYuEzH1Vnuh+S9Adoq0DgBMhdSeFoD?=
 =?us-ascii?Q?3o1bDeevNuXFmPSmkcY4ZnBv4TfrWwp/0jcnXqz4xbVrN09baSkxzWbYijfx?=
 =?us-ascii?Q?EHZ1UHdOfqqBo6Di3DDAD2Ofo4B8DrxAqSq5Vo4N?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7014cf82-c396-4533-e543-08dc10a0a095
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB7511.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 23:22:05.8346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UN3FUy25dF9PzuQf2BNX69Koq+5wXYNWIpW7BHLhlEY68pmNhr+vjnK6s8EZf7E8AqLHPNDNDgDXsehS0hnXDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9338

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
  dt-bindings: imx6q-pcie: restruct reg and reg-name
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
 drivers/pci/controller/dwc/pci-imx6.c         | 643 ++++++++++--------
 4 files changed, 465 insertions(+), 312 deletions(-)

-- 
2.34.1


