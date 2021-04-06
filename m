Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8293354F36
	for <lists+linux-pci@lfdr.de>; Tue,  6 Apr 2021 10:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239646AbhDFI6k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Apr 2021 04:58:40 -0400
Received: from mail-eopbgr80041.outbound.protection.outlook.com ([40.107.8.41]:47938
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230032AbhDFI6k (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Apr 2021 04:58:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SFgnmr3BdfANS0IvDB5nZ5qIygnvXNW+NlaumxxpDQwczMt0v4BFzrDHrWvfCW7ek++5kMdh25yT8oPMu+8DopP/H4//VxUkA6Keg44TBZDJS3yWP/6ty6JtpaF709s0RWadvNl6NoMt3tKCaFRT2HKoVv+XWMKWU5JKErZA5CXyatZUnRJviDyPZC1jGPDsKfvGvlP7kbl2XLn87PuCer5z9gZ8G43TNiPABNBugm+cAtZ9B/3XmA27kmO4m3J5LXO8uG4Ofy9N+baTDEIkSffPi55S831o6j9CcYXL2Q8JTuuNBPeAjZAL1zC+5LydOnos/WfkUUkvtSQ/d4W/Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VAbBAoouRYaYgCHOwiaLhrepf+ZbxfLMS73y1W5APAk=;
 b=foCoGSqar68a3AvHLoxcMeZLBoh4CKXV0klQdGEp5hrQPl6vPVw18z/TIpUB6b15refwJS3K/xoV5Tu16MN4jU2ke0RMEv6RVdct+97xKqikH/zoBKtJsOARYxcXaS6oF7xutVMZAzbLl4It/VNyIYRtUfZF+4aVGJDdnM7lfNHxqjfCQcvF+z4IPb4risB92t/IDW6JFDxbaE0ablogQRhfiuP1EIH9kD2lgddV/LxWoXTh60r/eS3ayGQT00XlCoorUlv2uUQShxhJmOhUPRVaU96FYlOU9rUT0W5Azr2oKoSJ+TSzGzrOlSl4uZKNiSL7Zx2lpvgTRnEzGc9a0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VAbBAoouRYaYgCHOwiaLhrepf+ZbxfLMS73y1W5APAk=;
 b=QvDbgDuRQBPVfV4pooapmZmE04a0Y2pof0o4xiYafu38d0LwziThecBcVR/4xls8qlu6SNHtF91Nt+sXfRPL2SoKrXFdGBlet5byAaJq+riKanhd01ipBbW+Da2x1+haGqq+AYPTR+gwUQEAc6hTChpgdYgbDIJR2rr/t3GiQ04=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27)
 by HE1PR04MB3275.eurprd04.prod.outlook.com (2603:10a6:7:1a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Tue, 6 Apr
 2021 08:58:30 +0000
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::5df8:1a69:47c3:44fc]) by HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::5df8:1a69:47c3:44fc%3]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 08:58:30 +0000
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lorenzo.pieralisi@arm.com, robh+dt@kernel.org, bhelgaas@google.com,
        shawnguo@kernel.org, leoyang.li@nxp.com,
        gustavo.pimentel@synopsys.com
Cc:     minghuan.Lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv4 1/6] PCI: layerscape: Change to use the DWC common link-up check function
Date:   Tue,  6 Apr 2021 17:04:44 +0800
Message-Id: <20210406090449.36352-2-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210406090449.36352-1-Zhiqiang.Hou@nxp.com>
References: <20210406090449.36352-1-Zhiqiang.Hou@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.73]
X-ClientProxiedBy: HK2PR06CA0001.apcprd06.prod.outlook.com
 (2603:1096:202:2e::13) To HE1PR0402MB3371.eurprd04.prod.outlook.com
 (2603:10a6:7:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.73) by HK2PR06CA0001.apcprd06.prod.outlook.com (2603:1096:202:2e::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend Transport; Tue, 6 Apr 2021 08:58:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7dbf0886-57c1-4426-0797-08d8f8da25e8
X-MS-TrafficTypeDiagnostic: HE1PR04MB3275:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR04MB3275D8DC1915D666C877B9FE84769@HE1PR04MB3275.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YEOz65d/NUv9RmIS9kdDW88hEttkKEIV2n+HhI/edPmcsqMkNscUInMe0Xdrr8iQUhXW8sM2FS3WZdsGBqI5x+F/+IHN+rb079B5MRXFgcBkj1xnNmTe7XoiIVOpM3tgH4SPdf/kv9SnEcnwtG8NlX4b80A4HkOpHcn3U+7Of2PiAsmqSE0o3L26a6WItVRLjh6BVFnFbwQIbnJWGDxnA6Zk15guHdiBtxMez3HpLowYHACFXFfk+ZB3Vu+G0ZJ5M6kehWGInxFFo0GomUkFDOERZxctfTOfMapEpn8T6hHubJbJaSDpGTZZuT5n5A+CTNmRxkpjJt6AB0poh8wxVdxQIbxfcUbMltB8Pq5/NFFeWTy/OdQFOBGObOPqkcq553TvdejYPy1vFDVnSXsyUSnfJ1DmGdxacGdI/2DJW4pmriCz3xiuWTu5F6J158T9hMctoFnu6S5SQinXX7UcE6sACeQUL6ZSvRY8jwG64RJewwp+OI0jv9YkHn2gw7HMVRwKKSo+zxP31s/eg5xjryKLQtMQ92oCvntZZEnZbPqwRQX/mVx1FzMCg7VFLNi8Sv6ZlCyw2jM2ZDUlb94RDyah0BVPzZawNeEpKn2SVcpBwvq2ylP0kK/j3kHMB/HAkz4eJQAXSHbsKS7MEPwuhxHjNTB9MMw5NugNBZ6xeYLJkPnZNTEvEd9m/5WuYR5B7BhyDbGg4TTceHwUzhOtZ1IOJn1+4pRlkzZ8JOCWr5FG9k7Jh+UfEV4/WDDMaIyd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3371.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(39860400002)(396003)(346002)(376002)(6506007)(38100700001)(8936002)(316002)(921005)(2906002)(66476007)(478600001)(36756003)(6512007)(5660300002)(6486002)(1076003)(8676002)(52116002)(69590400012)(4326008)(26005)(6666004)(186003)(66556008)(83380400001)(66946007)(86362001)(2616005)(16526019)(956004)(38350700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?YOADZ9rXpodjfODuB04FkDzKZOAmyJLNG4Fz2ECmzpxTvNxv1gycjklPBmzZ?=
 =?us-ascii?Q?ThGVbPbNKXJEvEhKIlD48V6Gm03k1g+Z6fQWrnEIPRegC44uVRNXsa707CBJ?=
 =?us-ascii?Q?g/BTysUbGdKYHSyrXMtUIurdzjFFXEeCLGZ+W0NYowFd/DXeVNEsh4+Vu982?=
 =?us-ascii?Q?hTMO+oZ3DBS/FeMF4BUkHoVQ36ZaDhwMibQ6SSnke5A1fz2kjQSX7KFV088U?=
 =?us-ascii?Q?unxTjC5ooZupgKFA3o0NZQXVhBM4IWrmkdgejjHMVgA3qe/tsCIF77FAx7dX?=
 =?us-ascii?Q?WCYfb6wuZbuv9R4NZAOX/1lLYe5H5AAsNUuNBmvCgWOWOKh0kQOZC5GSq5UB?=
 =?us-ascii?Q?PHDXeKVvRuqp2OM601t4HBYwy6prM5wz7OFoksNxlVbFalQXDHLDQjkDWrTO?=
 =?us-ascii?Q?qBW2SNDRBVfaXXw70Ch7qnydrgroAwwGS2EW/13aeXeGpOEsv4jmjNQ+5N3i?=
 =?us-ascii?Q?D4t20pER3nyMaoIDusFB+cTHWL6BWOMjyGgzS0VjpXeGL2hDK+vNHCeKw7up?=
 =?us-ascii?Q?sQwqdkZb34HSfs3mv0B2ta5h3DnpSnQ3ngbzK+TYmoY1jiKT4OXVniCjeNW1?=
 =?us-ascii?Q?R3Xbxv+GrdbergKQE56xV3pnadSoygCBUKFVHrUFx1QA0NQO3/rH92FB9yLn?=
 =?us-ascii?Q?LFqvkhfx+2DRgVnU/KjKLb38LUe5XV+VdVcA6iAHiRWFC/9SDLzblQdvkoXa?=
 =?us-ascii?Q?0Jwf08t8WpyK2lPfSuU3RtBrqLShUX3FwVWVeWLvz6tKJVJoZfjfMVU4bLKz?=
 =?us-ascii?Q?7p3I+z655GDIVnBkdoDCyeXavMCkFhrbgYjtUSdeLi7BP8K0SI6bQuSJS77o?=
 =?us-ascii?Q?2rzCyRu86EKDky1e0lWA262QA1OUHglG36Ms+D5HjhynIL/J9+PcnNe46g70?=
 =?us-ascii?Q?l+tcpWvm0PFLwRvBn9coiMeUAZIrchMG3KCgfGD3Ok6Al/x93L4mea4fWJY0?=
 =?us-ascii?Q?ydE9rNLI9e6uD94n2l6VMZ8tO897P/6TMJj1fwO3Uw39JrnjGERU0KDs+X5h?=
 =?us-ascii?Q?HArDvhSL3KxFkjUN9upxrTwUf+3W/t+GK5E0TICRNTVQkwz1m2wbfvSKBYcT?=
 =?us-ascii?Q?k34H+nz9IzUQddBl5IkUAAqLD8vgVdaBwDIj5YoRtQD5pyoFL9Du7obakGIv?=
 =?us-ascii?Q?ZvlUT7riJBiZ80qW1TPiwCNrRGzUZEAoKgxcwkcPHuZ5vYXlqyGEKFfzXV8V?=
 =?us-ascii?Q?iRHMLVB2fwZNEtQqnld95h/JVXzG5VGZsW+ZyuIK18k6ZLhpOD/qJnS6dwo9?=
 =?us-ascii?Q?bqwFY+rczxoC8kzXJeluk2fg5NhyUzJ018ZX/kR8ovTsCHhauLCCl61fAIYd?=
 =?us-ascii?Q?v6os8KK+X9UPKUh3lAVLbe+W?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dbf0886-57c1-4426-0797-08d8f8da25e8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3371.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 08:58:30.0974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rKNk8ks80R1MQymRIx+kAmumfJ8QVMLe4Vf4ZM1yGQw37aUsmFklQnY4h1+FKgvaslfJQfKFxH/2049Ols9ETA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3275
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

The current Layerscape PCIe driver directly uses the physical layer
LTSSM code to check the link-up state, which treats the > L0 states
as link-up. This is not correct, since there is not explicit map
between link-up state and LTSSM. So this patch changes to use the
DWC common link-up check function.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
V4:
 - Rebased against the latest code base

 drivers/pci/controller/dwc/pci-layerscape.c | 140 ++------------------
 1 file changed, 10 insertions(+), 130 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
index 5b9c625df7b8..71911ca4c589 100644
--- a/drivers/pci/controller/dwc/pci-layerscape.c
+++ b/drivers/pci/controller/dwc/pci-layerscape.c
@@ -22,12 +22,6 @@
 
 #include "pcie-designware.h"
 
-/* PEX1/2 Misc Ports Status Register */
-#define SCFG_PEXMSCPORTSR(pex_idx)	(0x94 + (pex_idx) * 4)
-#define LTSSM_STATE_SHIFT	20
-#define LTSSM_STATE_MASK	0x3f
-#define LTSSM_PCIE_L0		0x11 /* L0 state */
-
 /* PEX Internal Configuration Registers */
 #define PCIE_STRFMR1		0x71c /* Symbol Timer & Filter Mask Register1 */
 #define PCIE_ABSERR		0x8d0 /* Bridge Slave Error Response Register */
@@ -36,19 +30,12 @@
 #define PCIE_IATU_NUM		6
 
 struct ls_pcie_drvdata {
-	u32 lut_offset;
-	u32 ltssm_shift;
-	u32 lut_dbg;
 	const struct dw_pcie_host_ops *ops;
-	const struct dw_pcie_ops *dw_pcie_ops;
 };
 
 struct ls_pcie {
 	struct dw_pcie *pci;
-	void __iomem *lut;
-	struct regmap *scfg;
 	const struct ls_pcie_drvdata *drvdata;
-	int index;
 };
 
 #define to_ls_pcie(x)	dev_get_drvdata((x)->dev)
@@ -83,38 +70,6 @@ static void ls_pcie_drop_msg_tlp(struct ls_pcie *pcie)
 	iowrite32(val, pci->dbi_base + PCIE_STRFMR1);
 }
 
-static int ls1021_pcie_link_up(struct dw_pcie *pci)
-{
-	u32 state;
-	struct ls_pcie *pcie = to_ls_pcie(pci);
-
-	if (!pcie->scfg)
-		return 0;
-
-	regmap_read(pcie->scfg, SCFG_PEXMSCPORTSR(pcie->index), &state);
-	state = (state >> LTSSM_STATE_SHIFT) & LTSSM_STATE_MASK;
-
-	if (state < LTSSM_PCIE_L0)
-		return 0;
-
-	return 1;
-}
-
-static int ls_pcie_link_up(struct dw_pcie *pci)
-{
-	struct ls_pcie *pcie = to_ls_pcie(pci);
-	u32 state;
-
-	state = (ioread32(pcie->lut + pcie->drvdata->lut_dbg) >>
-		 pcie->drvdata->ltssm_shift) &
-		 LTSSM_STATE_MASK;
-
-	if (state < LTSSM_PCIE_L0)
-		return 0;
-
-	return 1;
-}
-
 /* Forward error response of outbound non-posted requests */
 static void ls_pcie_fix_error_response(struct ls_pcie *pcie)
 {
@@ -139,96 +94,24 @@ static int ls_pcie_host_init(struct pcie_port *pp)
 	return 0;
 }
 
-static int ls1021_pcie_host_init(struct pcie_port *pp)
-{
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct ls_pcie *pcie = to_ls_pcie(pci);
-	struct device *dev = pci->dev;
-	u32 index[2];
-	int ret;
-
-	pcie->scfg = syscon_regmap_lookup_by_phandle(dev->of_node,
-						     "fsl,pcie-scfg");
-	if (IS_ERR(pcie->scfg)) {
-		ret = PTR_ERR(pcie->scfg);
-		dev_err(dev, "No syscfg phandle specified\n");
-		pcie->scfg = NULL;
-		return ret;
-	}
-
-	if (of_property_read_u32_array(dev->of_node,
-				       "fsl,pcie-scfg", index, 2)) {
-		pcie->scfg = NULL;
-		return -EINVAL;
-	}
-	pcie->index = index[1];
-
-	return ls_pcie_host_init(pp);
-}
-
-static const struct dw_pcie_host_ops ls1021_pcie_host_ops = {
-	.host_init = ls1021_pcie_host_init,
-};
-
 static const struct dw_pcie_host_ops ls_pcie_host_ops = {
 	.host_init = ls_pcie_host_init,
 };
 
-static const struct dw_pcie_ops dw_ls1021_pcie_ops = {
-	.link_up = ls1021_pcie_link_up,
-};
-
-static const struct dw_pcie_ops dw_ls_pcie_ops = {
-	.link_up = ls_pcie_link_up,
-};
-
-static const struct ls_pcie_drvdata ls1021_drvdata = {
-	.ops = &ls1021_pcie_host_ops,
-	.dw_pcie_ops = &dw_ls1021_pcie_ops,
-};
-
-static const struct ls_pcie_drvdata ls1043_drvdata = {
-	.lut_offset = 0x10000,
-	.ltssm_shift = 24,
-	.lut_dbg = 0x7fc,
+static const struct ls_pcie_drvdata layerscape_drvdata = {
 	.ops = &ls_pcie_host_ops,
-	.dw_pcie_ops = &dw_ls_pcie_ops,
-};
-
-static const struct ls_pcie_drvdata ls1046_drvdata = {
-	.lut_offset = 0x80000,
-	.ltssm_shift = 24,
-	.lut_dbg = 0x407fc,
-	.ops = &ls_pcie_host_ops,
-	.dw_pcie_ops = &dw_ls_pcie_ops,
-};
-
-static const struct ls_pcie_drvdata ls2080_drvdata = {
-	.lut_offset = 0x80000,
-	.ltssm_shift = 0,
-	.lut_dbg = 0x7fc,
-	.ops = &ls_pcie_host_ops,
-	.dw_pcie_ops = &dw_ls_pcie_ops,
-};
-
-static const struct ls_pcie_drvdata ls2088_drvdata = {
-	.lut_offset = 0x80000,
-	.ltssm_shift = 0,
-	.lut_dbg = 0x407fc,
-	.ops = &ls_pcie_host_ops,
-	.dw_pcie_ops = &dw_ls_pcie_ops,
 };
 
 static const struct of_device_id ls_pcie_of_match[] = {
-	{ .compatible = "fsl,ls1012a-pcie", .data = &ls1046_drvdata },
-	{ .compatible = "fsl,ls1021a-pcie", .data = &ls1021_drvdata },
-	{ .compatible = "fsl,ls1028a-pcie", .data = &ls2088_drvdata },
-	{ .compatible = "fsl,ls1043a-pcie", .data = &ls1043_drvdata },
-	{ .compatible = "fsl,ls1046a-pcie", .data = &ls1046_drvdata },
-	{ .compatible = "fsl,ls2080a-pcie", .data = &ls2080_drvdata },
-	{ .compatible = "fsl,ls2085a-pcie", .data = &ls2080_drvdata },
-	{ .compatible = "fsl,ls2088a-pcie", .data = &ls2088_drvdata },
-	{ .compatible = "fsl,ls1088a-pcie", .data = &ls2088_drvdata },
+	{ .compatible = "fsl,ls1012a-pcie", .data = &layerscape_drvdata },
+	{ .compatible = "fsl,ls1021a-pcie", .data = &layerscape_drvdata },
+	{ .compatible = "fsl,ls1028a-pcie", .data = &layerscape_drvdata },
+	{ .compatible = "fsl,ls1043a-pcie", .data = &layerscape_drvdata },
+	{ .compatible = "fsl,ls1046a-pcie", .data = &layerscape_drvdata },
+	{ .compatible = "fsl,ls2080a-pcie", .data = &layerscape_drvdata },
+	{ .compatible = "fsl,ls2085a-pcie", .data = &layerscape_drvdata },
+	{ .compatible = "fsl,ls2088a-pcie", .data = &layerscape_drvdata },
+	{ .compatible = "fsl,ls1088a-pcie", .data = &layerscape_drvdata },
 	{ },
 };
 
@@ -250,7 +133,6 @@ static int ls_pcie_probe(struct platform_device *pdev)
 	pcie->drvdata = of_device_get_match_data(dev);
 
 	pci->dev = dev;
-	pci->ops = pcie->drvdata->dw_pcie_ops;
 	pci->pp.ops = pcie->drvdata->ops;
 
 	pcie->pci = pci;
@@ -260,8 +142,6 @@ static int ls_pcie_probe(struct platform_device *pdev)
 	if (IS_ERR(pci->dbi_base))
 		return PTR_ERR(pci->dbi_base);
 
-	pcie->lut = pci->dbi_base + pcie->drvdata->lut_offset;
-
 	if (!ls_pcie_is_bridge(pcie))
 		return -ENODEV;
 
-- 
2.17.1

