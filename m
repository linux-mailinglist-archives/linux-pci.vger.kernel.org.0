Return-Path: <linux-pci+bounces-3093-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC2884A0D0
	for <lists+linux-pci@lfdr.de>; Mon,  5 Feb 2024 18:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41F4F1C21ECE
	for <lists+linux-pci@lfdr.de>; Mon,  5 Feb 2024 17:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535EB44C6D;
	Mon,  5 Feb 2024 17:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TxDP+vrv"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2052.outbound.protection.outlook.com [40.107.21.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA73B40BEB;
	Mon,  5 Feb 2024 17:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707154440; cv=fail; b=u6GDiG231+c7Jr44tICqesPWTOwT99X2xRFtBJP4m2S88fdKlyzTAC8mWb3mVqogSgCELOZgpjPH/+c84UdrUm27TWz1m2xP194j2VXmSTBg4D8P8xcgkNVeyzEkUKYNbwKy6ExtKSQ09MZyacBposOPKYJGZXl4F/4zUNPKAfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707154440; c=relaxed/simple;
	bh=1GIrzEqUnZxVf6tZJncoLbULDSlld5lzLj0+YaOeUDw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=KMaAvoEZ02FC7V3HN328pTGJdU7nfK2m1m6W4zmY9IZp6BBSwKqTwvJkU93JsATzJQg2W3m6IEDPKkjRkNW+SmcAOj5fJUcdqTAz8WtKT/jiaFJyJjWmsGo3miODwtz7Ktn+ua+Zc5ZLd4dEgT3X4qubN8FGsBXpshixYGceQwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=TxDP+vrv; arc=fail smtp.client-ip=40.107.21.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DEbFNu1DltzaslagPhSFeG9J+XmncUN2Ge7E7ICdmu/EPBOrIJ5cmxNWo/IWWAon3xIjy7LghgsMnNBnujTWXWrLUASYN1hc4JQsz+80XRuaWqW9/tbCfiZ0/MCnCX8cOy3smZwmX2UX9xlsQLaa/R7uEpcG1dtxErSrRO+kWDpZaD/nlR296TgJ2YkaaezAYp9g7uwcK9QCOVviYn+R/xkjrBUcS7hYyK0lYEVu4EvBcWrIv0i+GImzEmFhm6GKWDuqrJVUlbc0aKouobnOOxzogMEDKI6wPinSqBvpMuzsA4TMlpIjNGgvu/hyiP+zldrJptLw3bZyUo8oyMoLxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PYS3q9SdMmxh+wrIHF5sf9TK6EZImOB5pI9Pz4qykr0=;
 b=jkKgqG1FHMIHNdT1emNl/8y/d+Npr14r+kxtgxajFa6IYplPlbjkT10bVrROiy0xFyISKm7paqOp3QfMzXAj448WOlwrr4MtSrLfhTIqGbXawr8NAXxVs52T+i6zDNV/0yvgj5HanEv09ylKFbMGLVdG1ay8eN8E7JJ8X/eNpn5vtvuxxaVKI2CLG2SoJv/hahoSBPbpEY5OUZD0vcOszmVYTygufLmp5HpRnjtkA4LVt5WvSykJfdZteI6Fz+ODbkgyneggnTNPwmZObsgwXgUoCD9pA/jKs0P8sRYf9s3hNKnDDhMNWRG8VM/zF1lX6Z6LNWuJAYt8YUJFaQo9hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PYS3q9SdMmxh+wrIHF5sf9TK6EZImOB5pI9Pz4qykr0=;
 b=TxDP+vrv5Mo5h1iFOPTXU/LN27gvtVWmkV++MGtG16hJae/u784Oxe0MgtEdUa2SI2VZ6EKhzSyAKqXiIFaqFEvgsD5uijoB1nmhVv7iizTRzpD0nvm7nQm8e86sS5iMth0nBP001GwkhApnB0Fqx/DFrceGm5xhvJAdvFoC+Ac=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7733.eurprd04.prod.outlook.com (2603:10a6:20b:288::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 17:33:55 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 17:33:54 +0000
From: Frank Li <Frank.Li@nxp.com>
To: lpieralisi@kernel.org
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
	krzysztof.kozlowski@linaro.org,
	kw@linux.com,
	l.stach@pengutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-imx@nxp.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: [PATCH v10 00/14] PCI: imx6: Clean up and add imx95 pci support
Date: Mon,  5 Feb 2024 12:33:21 -0500
Message-Id: <20240205173335.1120469-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0041.namprd07.prod.outlook.com
 (2603:10b6:a03:60::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7733:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b5471c2-71a7-4dd0-75b7-08dc2670a03a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yCDTEmFkJvmWNRHXTKKVHksjNanTkBTNRYNakhxJpxr5fSmo6rh0u6QgMFc60pSONj5e+pLIzFIii42p1KqdfZ5L1uBBw1A9JokQMt46IsbfKTgjoGB+sQC+niTAc7SnjG41o+vgC7UONUBj2DpaqJNBny3gTpI+gp1yvwB+07N5uPqKEKSTf1oT77Rkd0tiFeZ8vDchXFrzFA0M8r7HRDzOOEWOuYJ3Wf17ItRy/vcFJWJl36QaOnjz5mPIXd86HQn5k94GlBX+9pYRQwL93/Qc8d5DmfFUJAW/xjj8kXN5COjLMAoW/Uh6X/ecCI+gXl5MryCnb4G5Mdv8g+d91F1uSQCuPxhBxSTtTQgIST6XBfRyqNCWG54flr+uqN+MBBs579LsbAqXiTHBchFV5mSJVZRv0rXSq2q8BRI7Cjn7rNCStTIPR257SixYGEu5kCf8BqcyGWHgXuRj//a4rIqcl6xFHXaCYwO9PJkTv3CIuiJeTieMhRY4aVVr7H3XGibmojEvviPPNe8nPgGPsu5x6ritEQNOr7J5wer+49dC2UfQmPmlqcj7/Z0275P4Iiz0kA+GfwJgoh6JsRUT5fTxd87ETOE8qVK5ilorIEFi3+40oe9QXjWkWaZdDO5k
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(39860400002)(346002)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(38100700002)(41300700001)(66556008)(66946007)(6666004)(1076003)(478600001)(6486002)(6512007)(52116002)(6506007)(2616005)(2906002)(26005)(4326008)(8676002)(6916009)(316002)(8936002)(86362001)(7416002)(66476007)(5660300002)(83380400001)(36756003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JliJW3j0/D1pB6RDHOOBaBhmQObzvjgANA0ity+Y7KnNvk6XP7I680fsQRy1?=
 =?us-ascii?Q?0PNKSPeNKvcuwIBSKjJaOSqlN3d3f0kGExt/LCAVz8FGZ0j1Hc9ZoaKGAuBy?=
 =?us-ascii?Q?AFt+kgOU+ZHpdAz0RNNrO1cUmO9U3YLAKXAOP8M35z3onirVMAp/YIm+fat1?=
 =?us-ascii?Q?tTVv3cjSv0YFxuOR+g31Jy0cvYzlmUzpqKjFa2BkxNDfh9FSEhGsct5RsMoE?=
 =?us-ascii?Q?Fg4L6w1VqGNJHDy7ft1Ut5zBnrO52/E4x6Nw6pmDJD6T69YZboDXSUE1bUD4?=
 =?us-ascii?Q?WfPxVmyAk3ndihRFQ+4rOdvrWFIourEAq5FCBzALqypUZ3q1VBhTCn1FtzMF?=
 =?us-ascii?Q?+fa9gJZOOO88FtaTXBLGGHnOyIVaaDtWPYCM7vaf4R4CNj+HX+FvyoVSWU+H?=
 =?us-ascii?Q?NVOcDHKOFy976RLSzfxSclBay4Xm78abbpoNHqdaluDxmwC5CclL5qwEMC55?=
 =?us-ascii?Q?TJLZTqZQk99Xf5WUAqukSBP2TvqTClnV+JHAKQqOg17aljqKxvxPbJkOMtJq?=
 =?us-ascii?Q?B40I2sfjlmMzj767L2b4JH+S07qR/SVLYR+4n5gQTw8p5HT0KiLoRZLve3K1?=
 =?us-ascii?Q?7RJvGMLFahFIBTdHeqCQKmAyPyIhZHpH+1NdGH89ODmiiuZ63N/W4Yi+4yld?=
 =?us-ascii?Q?T/9+B+z/OD2IkIbdI0OyusuKFrhZz39NMWk9EemqTW22BzncnFsmw2EtbMiS?=
 =?us-ascii?Q?fsS35ZZDsSBFLxy3/2AVU+LF4sQ3icAOCpLCTUlCtDQ2z4I0EYa1PjgnYU82?=
 =?us-ascii?Q?Fg+t8u68iwJAtSANBAtzwDHyaBbP7N098uNFhzV18VUMX/e9NDRPAdBwrqwC?=
 =?us-ascii?Q?TQOd3unTC+7AZrxEzDVp+Mhj6Xe8ydLx5YuGyHRhC7wsWdcOJPq4Z+ATMrtU?=
 =?us-ascii?Q?BR/MA8hrmvxS9DWmm2RTQA2cTORG38XZfYjDLIA8fX3rHYz/4fyZVWziiO7n?=
 =?us-ascii?Q?gB1fXL4nq4HGd4vpbqfo03P5v9bj7hDq2MtomSpkOJ7tg+e5B8sx+yPoIzxc?=
 =?us-ascii?Q?QPGOyUt28ouAG/4mtDV95Trp27ooyGVsLOeqMNmbAPDlBChkq4Ug83gjoOox?=
 =?us-ascii?Q?OBw7+63+A6x7QGcqGa/BdO7vfkdzce/9uOmIuKinpgTZhWsc1KkVR2FufkK5?=
 =?us-ascii?Q?1/qyGDXSgJx1Ncg0yztZc/WZIP32XVtdoJP4zkhK1X2rGKKh7AnyNDa+8KeJ?=
 =?us-ascii?Q?rPQV6KDpCcsI8cU8Lj8MsJQnwfEkyXbJ4E+mMp2ZSgzTU7JVn2UHR2xCtcRr?=
 =?us-ascii?Q?0UgSZO81ycGP2gJPQCmTXUbWIfYEZoDwJ13gNzxKjM4ell71F6ZDIGHIi4OP?=
 =?us-ascii?Q?YzLpDRXhfuO37MNdMmuHOQtulxrb9gkc/mhQF0hALxdG3ssSezlo6uhp35x+?=
 =?us-ascii?Q?tEcWfRYcKduz31Y04KO8D3YqT6jzRTIfJ9g5BbGfcsj/4mr8phWHbAgP2iiC?=
 =?us-ascii?Q?sixSn3A1DLjh7tIJFi0sE4cMycyPJ23cNZZ4CmeSu0ejhSsXMP9GVJmRpwj/?=
 =?us-ascii?Q?2mhwENmr8UPvBWe2x1u3pJUHHbUfMCB7/943uYmd6Y4p/MOVs7f/kL3DQHRs?=
 =?us-ascii?Q?fgVOrSniLfzTWG7iF+M9lFMtpzwoBx2a4HabWkZi?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b5471c2-71a7-4dd0-75b7-08dc2670a03a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 17:33:54.7760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MkXYrZYHra3nVi6UlSnzV9BDTRGqPKX4tWkonVuWRaEy9NlySDDrpnz1GUwKjB0yNWDl7ukudp3ogadnyeDuqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7733

first 6 patches use drvdata: flags to simplify some switch-case code.
Improve maintaince and easy to read code.

Then add imx95 basic pci host function.

follow two patch do endpoint code clean up.
Then add imx95 basic endpont function.

Compared with v2, added EP function support and some fixes,  please change
notes at each patches.

Change from v9 to v10
- remove two patches:
>   dt-bindings: imx6q-pcie: Add linux,pci-domain as required for iMX8MQ
>   PCI: imx6: Using "linux,pci-domain" as slot ID
it is not good solution to fixed hardcode check to get controller id.
Will see better solution later.

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

Frank Li (13):
  PCI: imx6: Simplify clock handling by using clk_bulk*() function
  PCI: imx6: Simplify phy handling by using IMX6_PCIE_FLAG_HAS_PHYDRV
  PCI: imx6: Simplify reset handling by using by using
    *_FLAG_HAS_*_RESET
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

 .../bindings/pci/fsl,imx6q-pcie-common.yaml   |  17 +-
 .../bindings/pci/fsl,imx6q-pcie-ep.yaml       |  46 +-
 .../bindings/pci/fsl,imx6q-pcie.yaml          |  49 +-
 drivers/pci/controller/dwc/pci-imx6.c         | 634 ++++++++++--------
 4 files changed, 436 insertions(+), 310 deletions(-)

-- 
2.34.1


