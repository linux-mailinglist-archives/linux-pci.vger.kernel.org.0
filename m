Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6045477078F
	for <lists+linux-pci@lfdr.de>; Fri,  4 Aug 2023 20:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjHDSIe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Aug 2023 14:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbjHDSId (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Aug 2023 14:08:33 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2061.outbound.protection.outlook.com [40.107.21.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB7F4C02;
        Fri,  4 Aug 2023 11:08:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ihtf9gGWX9GkknXmZnOahEjig+vuLPj2hzi0N2HI2uwre+HfBfBgDcV9Zzz/fucHrKax0FT3JCLq35JxFcaw5rC9N5hBXYgKSnS4yQPP/vL/lcgWGVWQyj3kW8doZ6pz9iAeAgRokMBuy78R801zIK3pSPlvrNi1plQF+RcrCF+nRbs+s0y9mfChJEk3QLFq3hJy8PGTZxRrd/mRCECwOoHbBcVEclCVkIu+vLW8cfUWFlbsXip1PdPzg7ZzwQoibfMpvy6pRV8SqaUkiDDTBP2rqamSUbyBRED1o0ZqbDci99iJ/a7RsFbCZNgf0WaPY6D7SZF7zvqJvI50+X80zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1dBaOM5+RcrzhFBzLx4+olAPOEAPw/dd4GZG04J6QFQ=;
 b=NgAiWAZdZXFjlc9MSu+I64pi9wCT3VjuF65MjPHJpUl8rb13uVumBqTBh532qFD5j/Jh5adGmoYx2m/YhEnJE6PwYTgWvnF74mO1YO6Gz/Q2TElUl098jGXUyDw+NafWobFXkWCWD3sWpJjdZhOM+7wqpxeveChKl0zIx/akCcEndoDAJ/KKZ56Rff0cwWWE+zXzhSXCTQAZdQ5P1mAkrsoWGo4Cz2cGuQdiek2ni3mjMZvaXl8MNoEGnHnwzW66DvWy9Wo9vUcCIXM9bLoAcYDFQOnkezPtRiRlWr6PNdcMrmHxp9KD2Qp9H8+JJiH6p75t1ZN0WyvlDk03sJPn/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1dBaOM5+RcrzhFBzLx4+olAPOEAPw/dd4GZG04J6QFQ=;
 b=ZIrq5JtQh0meOBa0QKg68Hngz5h8E2dlWalc530Hp+FfIzLSI461SyfRFaqGLQBursVFgYSshYTIoo1QkMt8/0ikWgbT1hU7XDx39j73FHUXO7AO1Liq8bLXnJX0Quo4SfgSZq7sKUS7zVZq4maKjdAC/NxmE2LS2AFTReM9K0Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DU0PR04MB9273.eurprd04.prod.outlook.com (2603:10a6:10:354::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 18:07:09 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1%7]) with mapi id 15.20.6631.049; Fri, 4 Aug 2023
 18:07:09 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     helgaas@kernel.org
Cc:     Frank.li@nxp.com, bhelgaas@google.com, devicetree@vger.kernel.org,
        gustavo.pimentel@synopsys.com, imx@lists.linux.dev, kw@linux.com,
        leoyang.li@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com,
        lpieralisi@kernel.org, mani@kernel.org,
        manivannan.sadhasivam@linaro.org, minghuan.lian@nxp.com,
        mingkai.hu@nxp.com, robh+dt@kernel.org, roy.zang@nxp.com,
        shawnguo@kernel.org, zhiqiang.hou@nxp.com
Subject: [PATCH v9 2/3] PCI: dwc: Implement general suspend/resume functionality for L2/L3 transitions
Date:   Fri,  4 Aug 2023 14:06:36 -0400
Message-Id: <20230804180637.462573-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804180637.462573-1-Frank.Li@nxp.com>
References: <20230804180637.462573-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0051.namprd05.prod.outlook.com
 (2603:10b6:a03:74::28) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DU0PR04MB9273:EE_
X-MS-Office365-Filtering-Correlation-Id: c34127c1-0ef9-42aa-df3b-08db95159ecb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KmO/DeTlz3+nqIML7ww0aVkep/0YNxP08aFqENoY3vGcKXvFrqZh+mbSEGPinHrYD5cEV7qZ+7ZqvQZn+Vx4QETFUxvIBs3ICHdJmmwbGQ/us71WjF61bOyXCNB8beN3Yid5v4h8y+HrbyjDbn839OFfQ58Uy7URe/PM3743EelakTv4FWDTTjWXZEg1Bt/lIvgls041QUm+iYpQJuyQG9l01/uPgEkkCz+/dul23CPuKgMrTdLujG3wHXcGQXGjaKStv/w1YOslmFrslHNNuAG1BTXg80RQVHq7rIIyHbjnco6FWBpDyM5VO6OcZiH1kGGuPbyCoiemft/9niNmRcnbpHtWH2VUmRsQbFhSaMWiEdgKH//jDEureyxOGg6+bKnc0vCr1RmAIkpj4GcoJS2pSPyVpELxW5ZDaHLatLRBbzO0InFXSuqOi4NVo3XgTNtz1f+qqOr8yUr0APZ5ta3qVRQjqGmTLiVY23zd2HCzaJwitGs5ZJ9quiqyvIT8mxHlpMOQQ20Kxk0CxqoDdsfXKe+BiUEt4bxoxbMwfOHKTd5gNbHhdUuVfv3IGeiO9FrZQ65zkdcLGDBWwb6sDy3BRoHWcZLLa/UvPBgBJ1XWaTn7oaRFcL17iB0J/t8W
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(366004)(376002)(396003)(451199021)(1800799003)(186006)(83380400001)(1076003)(2616005)(26005)(6506007)(8676002)(316002)(2906002)(66556008)(5660300002)(66946007)(66476007)(4326008)(6916009)(7416002)(41300700001)(8936002)(6486002)(15650500001)(6512007)(6666004)(52116002)(478600001)(38100700002)(38350700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NDWn0Lvu1urRnuk8asOcP6r1RimE91pcxYGAgKdsl+7XTftB7B3tDIp+xXvg?=
 =?us-ascii?Q?frDKtugUbTHEmgGZG6IEngePaXb2yACMxtrdCPaYmakKGiLGacCMDXeKzS9G?=
 =?us-ascii?Q?yZMoX181RUlDYhPA1BMIa5ozbG8cd8duAcGZH3jrlGxspQqV0YjbwjDdwntK?=
 =?us-ascii?Q?vpXedNJvONEkTsd/EM1DATUEvurdVhTBPQuMed2P7y0s3HmestUYMFFamkr4?=
 =?us-ascii?Q?celZPnsEj3WzMPzXa2B5pea/8MXEfQRFbVeo9DbRxS/Dsz4/a5UMpE9MW9xC?=
 =?us-ascii?Q?rl9i8b5BRzMymsRtEJZXLMc59iHqcz91hd7IK234Vaex93H4PSVgRv0oS+2z?=
 =?us-ascii?Q?TWGcLcS71+8JkBME7QIuNAWrtdGxKsJr1oMALjFp1iSIllKSVMlMe0TvXxq/?=
 =?us-ascii?Q?kd/hbTUf6USa/2w4s5nYMSoWw/8EyR0tM+kw2Fw0WNfy+Jqu18hNMkYQuID1?=
 =?us-ascii?Q?7Rp84xJnEdjcWqJv1AneVoeXNrzL294JgUutV0Nabyto9hFNB6qNlafpgG4m?=
 =?us-ascii?Q?vBEMiCvhSR000xGTQZqVEHxWm2x2us5G7IpLe4Gdf5v4li+Hrbbcs8V0YccG?=
 =?us-ascii?Q?nQjUGFPkKhRgF8WiBwzsuWbj4KimLpDzIIytUFduqzvwWkSPSqJLWWFmN7sl?=
 =?us-ascii?Q?NXknqte1393gCIYOrXJeNg7YAu5n+as9vspD8T9LPwrJ020xi9pxiK7Y1TjH?=
 =?us-ascii?Q?8jcGqDYAd6R/Qu2wrZB1UKG+OTAZqCDwp4tr1c3HjpleKFGGtywExFzhq5uB?=
 =?us-ascii?Q?mErW3dxa4WDqdBVm5PgUKfSR3DITA4jKML2n7CvjXYWIt4kwtxZlyeFMfljW?=
 =?us-ascii?Q?sRtHhHbs9XbCQvRbpeySR+C7L2n8metDpK8S4AoHVFgbG99aJj3LRHpUaMRU?=
 =?us-ascii?Q?HsC7sgET0GOsEnxmbMGzmxqDdEJ0TC9nP/JuXUHydHpBG2eIq3BWhxL8sMsi?=
 =?us-ascii?Q?wm+MZ+sASNtlGrn1uYsrfUk97q/siOgRmBLx2UDjkTH1KQUmK9n97d9QScTv?=
 =?us-ascii?Q?/pRo/WM3D4bbEao0ZVAtVED1+C0ALrFsqAEZoNR+DNc23boVTaAw0CckKLqP?=
 =?us-ascii?Q?LpVWL0PYN4ItFHhz/sB7+hOWBbGXvFOJQPibWORo8P8RNo64iPj/tP1726lA?=
 =?us-ascii?Q?MdsTG07WtAu6VoHgrmDEm/UclLwuABQmuyzZtRWZ4UvxA8zG20vYi61W9tg9?=
 =?us-ascii?Q?hgR/wFw/v5xTMFFy8sw43XYSv81xWCtR1VYumPDAr4/znqiejsSVupxS+ueD?=
 =?us-ascii?Q?Ap1xBufdK7ve0kaaHW35a5aDfzsOLth9qRxtyy3abgogJA83bZeuiqoEmpxx?=
 =?us-ascii?Q?MR4jYYMEb5x1y4gTa+bA0YHi0MYZerm26ukqJhaLef2nrOHxTmacVN83iEbO?=
 =?us-ascii?Q?uLUMxbQDdJVtOfPqS5Uekz3L49kPfdyE6sAwjpuHmvtjkaDS1WXJl/iVZgky?=
 =?us-ascii?Q?rLpzU+zUfPpPzs97MjraVE+dyG+Jx72lp8G47gx3McFH61C6Eqcy6JUiaK9R?=
 =?us-ascii?Q?NXGViG9Gl4nQxwRJSrLIfrc35NLbH3yCIBsGij445qHvZQ29fBWnbGJN6Jau?=
 =?us-ascii?Q?bnH/fLgF+XLaSFrTDO4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c34127c1-0ef9-42aa-df3b-08db95159ecb
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 18:07:09.5903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YSA5VTZnWTRSGFan4cWXZf2bmsbIEDk3dYf1zm1AIZD7Z+kP6sv9dPJLNWDp90So+IINLks89gX1s2gBNOMQAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9273
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Introduce helper function dw_pcie_get_ltssm() to retrieve SMLH_LTSS_STATE.

Add callback .pme_turn_off and .exit_from_l2 for platform specific PME
handling.

Add common dw_pcie_suspend(resume)_noirq() API to avoid duplicated code
in dwc pci host controller platform driver.

Typical L2 entry workflow/dw_pcie_suspend_noirq()

1. Transmit PME turn off signal to PCI devices and wait for PME_To_Ack.
2. Await link entering L2_IDLE state.

Typical L2 exit workflow/dw_pcie_resume_noirq()

1. Issue exit from L2 command.
2. Reinitialize PCI host.
3. Wait for link to become active.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../pci/controller/dwc/pcie-designware-host.c | 76 +++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h  | 28 +++++++
 2 files changed, 104 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 9952057c8819c..7d87ed61e2bf9 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -8,6 +8,7 @@
  * Author: Jingoo Han <jg1.han@samsung.com>
  */
 
+#include <linux/iopoll.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
 #include <linux/msi.h>
@@ -16,6 +17,7 @@
 #include <linux/pci_regs.h>
 #include <linux/platform_device.h>
 
+#include "../../pci.h"
 #include "pcie-designware.h"
 
 static struct pci_ops dw_pcie_ops;
@@ -807,3 +809,77 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(dw_pcie_setup_rc);
+
+int dw_pcie_suspend_noirq(struct dw_pcie *pci)
+{
+	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	u32 val;
+	int ret;
+
+	/*
+	 * If L1SS is supported, then do not put the link into L2 as some
+	 * devices such as NVMe expect low resume latency.
+	 */
+	if (dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL) & PCI_EXP_LNKCTL_ASPM_L1)
+		return 0;
+
+	if (dw_pcie_get_ltssm(pci) <= DW_PCIE_LTSSM_DETECT_ACT)
+		return 0;
+
+	if (!pci->pp.ops->pme_turn_off)
+		return 0;
+
+	pci->pp.ops->pme_turn_off(&pci->pp);
+
+	ret = read_poll_timeout(dw_pcie_get_ltssm, val, val == DW_PCIE_LTSSM_L2_IDLE,
+				PCIE_PME_TO_L2_TIMEOUT_US/10,
+				PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
+	if (ret) {
+		dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
+		return ret;
+	}
+
+	if (pci->pp.ops->host_deinit)
+		pci->pp.ops->host_deinit(&pci->pp);
+
+	pci->suspended = true;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dw_pcie_suspend_noirq);
+
+int dw_pcie_resume_noirq(struct dw_pcie *pci)
+{
+	int ret;
+
+	if (!pci->suspended)
+		return 0;
+
+	pci->suspended = false;
+
+	if (!pci->pp.ops->exit_from_l2)
+		return 0;
+
+	pci->pp.ops->exit_from_l2(&pci->pp);
+
+	if (pci->pp.ops->host_init) {
+		ret = pci->pp.ops->host_init(&pci->pp);
+		if (ret) {
+			dev_err(pci->dev, "Host init failed! ret = %d\n", ret);
+			return ret;
+		}
+	}
+
+	dw_pcie_setup_rc(&pci->pp);
+
+	ret = dw_pcie_start_link(pci);
+	if (ret)
+		return ret;
+
+	ret = dw_pcie_wait_for_link(pci);
+	if (ret)
+		return ret;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dw_pcie_resume_noirq);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 79713ce075cc1..cbba3ed19b3c0 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -288,10 +288,21 @@ enum dw_pcie_core_rst {
 	DW_PCIE_NUM_CORE_RSTS
 };
 
+enum dw_pcie_ltssm {
+	DW_PCIE_LTSSM_UNKNOWN = 0xFFFFFFFF,
+	/* Need to align with PCIE_PORT_DEBUG0 bits 0:5 */
+	DW_PCIE_LTSSM_DETECT_QUIET = 0x0,
+	DW_PCIE_LTSSM_DETECT_ACT = 0x1,
+	DW_PCIE_LTSSM_L0 = 0x11,
+	DW_PCIE_LTSSM_L2_IDLE = 0x15,
+};
+
 struct dw_pcie_host_ops {
 	int (*host_init)(struct dw_pcie_rp *pp);
 	void (*host_deinit)(struct dw_pcie_rp *pp);
 	int (*msi_host_init)(struct dw_pcie_rp *pp);
+	void (*pme_turn_off)(struct dw_pcie_rp *pp);
+	void (*exit_from_l2)(struct dw_pcie_rp *pp);
 };
 
 struct dw_pcie_rp {
@@ -364,6 +375,7 @@ struct dw_pcie_ops {
 	void    (*write_dbi2)(struct dw_pcie *pcie, void __iomem *base, u32 reg,
 			      size_t size, u32 val);
 	int	(*link_up)(struct dw_pcie *pcie);
+	enum dw_pcie_ltssm (*get_ltssm)(struct dw_pcie *pcie);
 	int	(*start_link)(struct dw_pcie *pcie);
 	void	(*stop_link)(struct dw_pcie *pcie);
 };
@@ -393,6 +405,7 @@ struct dw_pcie {
 	struct reset_control_bulk_data	app_rsts[DW_PCIE_NUM_APP_RSTS];
 	struct reset_control_bulk_data	core_rsts[DW_PCIE_NUM_CORE_RSTS];
 	struct gpio_desc		*pe_rst;
+	bool			suspended;
 };
 
 #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
@@ -430,6 +443,9 @@ void dw_pcie_iatu_detect(struct dw_pcie *pci);
 int dw_pcie_edma_detect(struct dw_pcie *pci);
 void dw_pcie_edma_remove(struct dw_pcie *pci);
 
+int dw_pcie_suspend_noirq(struct dw_pcie *pci);
+int dw_pcie_resume_noirq(struct dw_pcie *pci);
+
 static inline void dw_pcie_writel_dbi(struct dw_pcie *pci, u32 reg, u32 val)
 {
 	dw_pcie_write_dbi(pci, reg, 0x4, val);
@@ -501,6 +517,18 @@ static inline void dw_pcie_stop_link(struct dw_pcie *pci)
 		pci->ops->stop_link(pci);
 }
 
+static inline enum dw_pcie_ltssm dw_pcie_get_ltssm(struct dw_pcie *pci)
+{
+	u32 val;
+
+	if (pci->ops && pci->ops->get_ltssm)
+		return pci->ops->get_ltssm(pci);
+
+	val = dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG0);
+
+	return (enum dw_pcie_ltssm)FIELD_GET(PORT_LOGIC_LTSSM_STATE_MASK, val);
+}
+
 #ifdef CONFIG_PCIE_DW_HOST
 irqreturn_t dw_handle_msi_irq(struct dw_pcie_rp *pp);
 int dw_pcie_setup_rc(struct dw_pcie_rp *pp);
-- 
2.34.1

