Return-Path: <linux-pci+bounces-1452-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FBC81F134
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 19:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3EC1B21FB2
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 18:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E4F46B9F;
	Wed, 27 Dec 2023 18:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="P9eieAw8"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2071.outbound.protection.outlook.com [40.107.7.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536EC46540;
	Wed, 27 Dec 2023 18:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=efR8T1fQYQfQcZXTipjkUrx0NvBRB3uLfcrjGdia14aRISC5rvN6CwL+vqyTDE8BNQMQQUURAkZ/8wGeIghh28AVdgcGg1VcjJJruzwSzIX5PdgF4t1rwqSBlOnLUrBKN10cwL1cvefuqkeUDaCEreD0ePxbpwK4gRCuJ+sqtgAIdu5cJN8Udn23KGvPT1DwH6Q2b8x6X5Bst7Jxpwk8QkXrnCRnupxti1EQhzhhffSV4mZLgXYGaNr7COl6qoQdA+wXgLp3/jKH+AtOGxX64mfx3C8/k12JD4yqWGxFvLt9AaWDTm77C1XVuSUEU8bWGcgu6oTygzha7vMWnh31Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DzfXaHwhpGJrlOiicly0YZxCE/pScxhw2QhpZqk9HcA=;
 b=FnPcdke2wQfVzPMMgwiCUQ4i/0rX7zBuNNJzHBbuJTOGXjG7TLFzVoMliU6rvq4+E2kWNM5FUEzdE8+FNf+8G0lxirta/dVKeTeWpJ70+vAUB8+5Rr7VQ4OsvaBI1yRXHur9TU5S1qe7FsFjkeK2dMwowHWdABmtv6UyC08kldnxKbgLpYjWl5OS5NsZ2G+mJVovjKAoAVBpj9GRP3CJIxGn6D5Tadt0TmZFbCDWsCVDmNaKuETI2Z4kOnFjCyd5rHhvWUWTyFW/cknN0dAA3eWelE3ZRiVqGABmF0mIwLwG+UpxI8PKF7wAy1WWE+kal7jd6+nrO6/8CX69vWJnBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DzfXaHwhpGJrlOiicly0YZxCE/pScxhw2QhpZqk9HcA=;
 b=P9eieAw8kC9SBxn9MSGvLJbtln56cPuaGTV+gZAJ7rfws+0zNiDktSFd0U8dBc9ip9aaI4dQICFc0HBRXWBJsDktTcPOgZtnF1GRCy3oe8y1a2k5Iy6X9EWyyktUbm03mCgESzpIGZyqw6eOLMEr+LZRsMaauZTbteg8qjKQ70Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DU2PR04MB9050.eurprd04.prod.outlook.com (2603:10a6:10:2e5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Wed, 27 Dec
 2023 18:27:48 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.027; Wed, 27 Dec 2023
 18:27:48 +0000
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
Subject: [PATCH v7 00/16] PCI: imx6: Clean up and add imx95 pci support
Date: Wed, 27 Dec 2023 13:27:11 -0500
Message-Id: <20231227182727.1747435-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0018.namprd07.prod.outlook.com
 (2603:10b6:a03:505::22) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DU2PR04MB9050:EE_
X-MS-Office365-Filtering-Correlation-Id: 9be0a1e1-2063-439e-52e2-08dc07098700
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ja0UAUBXIEQPLj/Ww4M1NOYHa/r34MNJdkJazuuyiInTOKLci0Fdah6w1eJKx+vn35rvgAxXtjRxUhPLDc/pEB/4RCQ9sitVGF+kZc83fbk30FdfQS1SQxqVQz4jyWUwK0g89DthkF4Y2kuz1ZQdbBq2K2bAV8sE/PWnNeGttycAsVqmK2lJAcK3578hbVXBo3kyIZWJBJ4GXg7m73mWJ1UtrfN4HTtEyv+ihk5ruRTJKk1i25EFVkYlP04syVcdb1ZUp6tXCmmru50vbpPB4LcIzVmJKRyuomAQESlHrN/ONgyA+nbWoAqN33Ulz6rAFBDPhhBJMsGazhRruLmTO3+/gad6zIXlLzwzqOmYlxYw2HIy32ptUfhe6qeYtFIP1Hl8SvXawBeBPIEgtrDf1tgLYnVZcIA3oTIJW877J1X6SWEFRhUKqJvqKTyJYNM/yP+FeDV0M8XZ1qpnXDkC/BOaBAt+MXXrDXoVXKylVypOdJU8CgZdTnxA0KG8Wl29hHXpj9JQ9wAeu9aoRZwqueVZ0vicixioMu5DVtFoc1vyWeNNMiGQ+DhdY+7lJzKk+Xd+W+MyEbUNs7h2y3XL6klPYMjJe+tMm8RYvqd81cQ6mGjUf1tTJCdqryGhATqp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(5660300002)(2906002)(7416002)(478600001)(38100700002)(2616005)(26005)(52116002)(1076003)(6486002)(41300700001)(36756003)(86362001)(38350700005)(66556008)(316002)(66476007)(66946007)(6916009)(6666004)(6512007)(8676002)(4326008)(8936002)(6506007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IUsR8i3iaqpy66HeNJww903v65mQh2XcoGVCZaNI+zXqYUTrmmlcHheJ4wQ3?=
 =?us-ascii?Q?FkcdEE7C2b7sCWmSPERQTWqv4PEVq88i2UabxWkjYBCQz7yfCW14rseQRdGX?=
 =?us-ascii?Q?SoAaVIm09T2s/Zj6LEdwGfdcoax/kbXgmOPphx7JlRxZaXMeQPh5RvH5GiUY?=
 =?us-ascii?Q?6r88/dXL3TatyOJP2JCMJ3JrqryDtSE9SkA9GeF4KPz1yfLvpGpPERBrKmRc?=
 =?us-ascii?Q?U9UIiXIPfeJwfhTXfbrLJCnebPltFaTwcL1EuS3rp4tSlZSx1q7i4SjhQibX?=
 =?us-ascii?Q?aqbt99POmw8U2oMm9gDT4uwnNvW4D8sOSOC92f5VqHP76j+pJyuX06Y0me1o?=
 =?us-ascii?Q?6JPOc+PdYSU/xc0A8uv9WXRt1npH+WOG4c2kBMidcJIAJBVIzsX7D5N4Y/m3?=
 =?us-ascii?Q?haZGkcoj/WM6g3ahouZPGWotkNnUXljk0VWVxszQTNsUnkjOAN+1G+Hegjv0?=
 =?us-ascii?Q?ezVYbE4bIUZfos5Q9nMjfGTP42ZTWg/jaH4SzfmZIE4JnjiQX7DbYZ9gqWoQ?=
 =?us-ascii?Q?Sx/0/mtNLHmKYLwu8t+ThobE06DFsfzwzTU+O52bTgMQ3UsuVFLMkM7bhtFh?=
 =?us-ascii?Q?oW0HWVBPr39rzDo4aybSpZ8h7vb8zb67vNW2mUkwBqyoVFPwfv4TM92qKPln?=
 =?us-ascii?Q?XDNGwXXgpooo+9jF7i6w+EBex8VLAl6N97MX2iNGIOmPh385+C+t73eBM1lh?=
 =?us-ascii?Q?uHVYtEmdtAtxPiOfpTdUzcjl27Zekqrd77Z/9HwgTKsfFCMOh8j0n4LQKNKj?=
 =?us-ascii?Q?4LQO2jcLTqyxUR9vhX+bEXabS1sm2x0ydfDI6jBIGmtv6wzfRcc6fmcOBYio?=
 =?us-ascii?Q?EnGSD4FOO/VJ3pfMduw4tlPgkbaiNfYVjkQKFBclNjxfW2n1Y1b31HXSeDPR?=
 =?us-ascii?Q?mNyM2Ddobzvq6ThynEWNBKZgYnlV45LBsOtXnSXFmDllNPQ95IiXj2rJdC/a?=
 =?us-ascii?Q?e73hW3btM5/BMRxP6qYMLkBHKGC4CLioTEgAnaKTktG3yTt0HevTnOT2JW5E?=
 =?us-ascii?Q?gj5FF/vSND6/nn0FHG175V/JwVeJkMW1YJa2uGf2UkR6lPtMUmpzqwEfNuWW?=
 =?us-ascii?Q?yX3y2jpqcbSW19eZ6hdyC3UEV9jCkESEKyvpFKx0JN91px48ztV9fMZrdG7L?=
 =?us-ascii?Q?1nwrCnWsIM5Ha+K9hWxZ2xcgECQvpiNjSKwngTdlldj9LQC3B5SCYYyjR3xD?=
 =?us-ascii?Q?+EZZmVS5nURAh1RY4I2xr24AQ8h7uBBCpqh1jUVLnGychMkVFiO+nVr2hTPZ?=
 =?us-ascii?Q?A9ng9PdicNFTZGDB5o3DVUj1At66LYaq5dJlZYX0B+mpxXvJewdEWiiAudRs?=
 =?us-ascii?Q?iIMZdO030P9uiCaKDKBR9o3poAflEhc5ym4FZY9vObpMIk5TfDvYqIUDUu7T?=
 =?us-ascii?Q?SckcNdKORz6Z+9V0NRj4ZHinJF1y4Pjt+DgALOn0N3azl+OJpOVXNL+TNzWb?=
 =?us-ascii?Q?j3Kzs3wLJroHR1BEX50LaX+TLcoPYVRSiJ0uML9h5AFsjaWSenzwsV3okFY1?=
 =?us-ascii?Q?Nz7LIeanTw+Wm1H/9LHJoF9JFGgKcwOU+HDy+zXHDK4h/kmnI9Z+0o/kueWr?=
 =?us-ascii?Q?mEgqmu66dsWjZRlEOfY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9be0a1e1-2063-439e-52e2-08dc07098700
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2023 18:27:48.2940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 013dc8vTVKH38QlgCbHZjqhTsKggEeHmBK9/ed1+J2wIcjcLwKu0shIiqUiwkCx+8RWo06m/IuC22CP2smLQpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9050

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


