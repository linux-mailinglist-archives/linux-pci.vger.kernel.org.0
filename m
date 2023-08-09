Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD78776401
	for <lists+linux-pci@lfdr.de>; Wed,  9 Aug 2023 17:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234405AbjHIPha (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Aug 2023 11:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbjHIPhM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Aug 2023 11:37:12 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on062f.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1f::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805063582;
        Wed,  9 Aug 2023 08:36:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V4U5/1T/cuEFa52xBTSldmVwjfxJH8fwCCWO3LJlOkVZGnzH0/ylXuWkupokyYjD5o/VetzS8FjEJPQ3YppPfs7y1GUy+ndEhR5XzAC4bGEmQB13S71/3l1T5qS913FY/tfa6D+YBogMBV8VH5MFb48kyiuO6GQwCGmiUwiaB6vgIy9RyOY1E9kgZlE+FRhQBIK5xvv5tIZ744cKXb0sB7W8qI2CJpxiIZPygsAhUJVG5lgXWg+fS+3kdF8Y4SRtf97kRVUKOQbBFpo1dPrCWYFBaXuavqHMLDYVBI7fMiKhdcPzv6wFlwOm6ftauSCT5krbaXd8/7u25D9OgK/Ivg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RuZYozsszV04m9+f6PLw4EoD1EIVUX6sjonI35T2M80=;
 b=TWCvYEptPM3o0iHv7UbsM0/a4/Sdjz5cwufxLkzCMEAfqY6h/1JvRZveBUw8Nvl8ubcR2eUjlfcsICxH7/mVhB6f/RaP317kGPDqIbV8mewaaoso5827LcMZe/U8cn76zmyfu97Jl2liu//Upvu9k0Ulo4gVA1vlSIyV+mPzqtjvFtREnhQYiuW4UW5onXZDaXICsIUlAu3q5kM5rGloWHmbBIWAWEizC8eE1ocDeWnCkWbwRXIHYZ0hxAcC83tb2c7T+AtJzt5oWWY40ApG//VUAhN378PC/E5Z3XCHO72sMVu7e1S7HAW/75JWlyprgGDeCOi4AUaj0EWfDNS3IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RuZYozsszV04m9+f6PLw4EoD1EIVUX6sjonI35T2M80=;
 b=od+A98TETNtYkyzo1jydc+3gLq02PGMP+Ib5pu9Rz1nn0zrQtQUteOhudZDlxQo/cXnwu8EKXstkMMsRzJtN5JTh/rqt5tYAbw0H5/w3nzYPtUiiCFAxG8RLGfMo2amO79FcnJEwZJwSPidxyJ21c14rziXqAAWlRxGkVTsC23E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB8PR04MB7161.eurprd04.prod.outlook.com (2603:10a6:10:124::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 15:36:14 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1%7]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 15:36:14 +0000
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
Subject: [PATCH v11 2/3] PCI: dwc: Implement general suspend/resume functionality for L2/L3 transitions
Date:   Wed,  9 Aug 2023 11:35:39 -0400
Message-Id: <20230809153540.834653-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230809153540.834653-1-Frank.Li@nxp.com>
References: <20230809153540.834653-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR04CA0018.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::28) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB8PR04MB7161:EE_
X-MS-Office365-Filtering-Correlation-Id: a4c57f22-0cc6-4ce8-875c-08db98ee5d6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 90Wvef7vXigxyDbdlsOcsK+ZyodQmh9lTE2zFzm3Y6IprZs3CuwB9LWpXd56C5CqnBen3YrO0ebCj4rfcVyrkNE2QBMK1/ab+flUk9MoH6VGV+uoblfWFZv8P3AsrWXLDGPxUYE5JRzbPBZNHhj1Bjg9Lcv9gJdNT0wOhNc/TB4QzENSRt0O/JF1GVdnba5rePKo2auEwcPhdFwcN7NVZCbh4E82k2QN8yf+p4HmHBHHs6zJrBiD0mOw6ydQ4207ZJ/5Zl8djvISSM9+Vh6tiOaerEpyz7AdG2IjZjG9KRB5qnNUU9LmWq/qSx8ENjgha/xFNm8I8+aIoMp4H83yrLuAp29t5b8snjt2z49x6X67s5p9+fl2KSiNmcsi4Xiaf6OhPVvUglyYvbRDqfAKs3N60inmLB+lUzqWJ7OLYqtWYuAFKIetEunrqbpd+TZtqwvkZheU54CFmYoqAUkZ1TmuGs2cKLBZU4VVvBFBt1U7sQYh4ZvEg0BFb+yjjZ0ibGxyHZyFKrDngfBw5IDDsRd0McbPTeHC9kWWxS/580tMDp9b7RI8dg9FWamWLX8geFuJq0NLtYCwSAPuSMR+wuCFI6GxNlcsOMNksgalpw9hS9yjrfGbOT8Etn9KN/W7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(186006)(451199021)(1800799006)(6666004)(6512007)(1076003)(6506007)(26005)(6486002)(52116002)(66476007)(66556008)(8676002)(8936002)(316002)(41300700001)(36756003)(83380400001)(38100700002)(38350700002)(86362001)(5660300002)(7416002)(2906002)(15650500001)(4326008)(6916009)(66946007)(478600001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FjX/6lupl9AgMqntJ4fCyeuT8SF2O03fMeQ8ghfR1X0Plk/EicvbAdvbOYIr?=
 =?us-ascii?Q?AHgHuN6M8X3kyKJFvQ6N099R+xf9hF+q7ReVcQS9bSE8v8VeHM/AG6qvn7Yd?=
 =?us-ascii?Q?t30AA8wuyVc1DyszbPz9w8mVLtfmkRjnCORMnwnznUNFDhm9i0dCBcftFFDP?=
 =?us-ascii?Q?98jWd27EqRq17WbVge7URvTG685Nk/IOZXOi0u+QaeqTxlW/SOKBbNBRIMU8?=
 =?us-ascii?Q?aOfBjOFQbcl/pxDj6U3ZYiqlUqj+r0n5rV1OsFp0B0Dvhuia1nYD+EYLTi+X?=
 =?us-ascii?Q?qCLRXc2YdIlhWf9r03OB5DmvZW4vRsoJxCXjMei0AQ/Aj5pV2CrSt15eQhbu?=
 =?us-ascii?Q?Utw7y4RkJf2pvmItnZgUaRHH7N1/DRH3f9UnvEedRzN4mMFzLQyDlFTNNUyU?=
 =?us-ascii?Q?LubVVLC4xYvRFy5v7t+nVRf4Mo7Icl5aIUp4d3/d0jQ9ftn91bTpVEABR337?=
 =?us-ascii?Q?ImB9OR3QpuivPSw8ih4IlHH9frC1pjOlPX3BeI/FDEvIJ7eRyFj5OiC/i4C2?=
 =?us-ascii?Q?NKXpHWDI0EjhXnTErP0fxv4fRuQ88oomlPKDRm63TqXd8xCwZl2ZCxFBTOqf?=
 =?us-ascii?Q?/RbZqMgF6cH+XBoFQ9Mbu7R7AHSKq/Hl+CnnulM+gwgzmq2uzy7Lqswp/Kf8?=
 =?us-ascii?Q?NbLXypOvXwliRuUPXEb5jioGSYlaDmP9UryxHAZmRSbQOEQDgASgdL8ikfKn?=
 =?us-ascii?Q?ij5lwbxlhjxjhIHWfEsjXZ5PgF23XRFz9TZdpUAO6qDGaMPP/n7rbjgcSHxu?=
 =?us-ascii?Q?zXSiW7zFE3TnMYCF7R56rFwQbC3GdrwsmauXuUJlgYZb3udbrAmLLrghehNG?=
 =?us-ascii?Q?exMUS7XlUXvZ/8b3Lrw0fQmFK8hCg1EFhVVkUr1H8PeUGhGXXPyRSBei37rE?=
 =?us-ascii?Q?g9JTiPJrbcDA7a0mnuNAAgWgh5mBt2w/7C+Pn9MZb96CFheQ7PVGrP894k5P?=
 =?us-ascii?Q?etlM08i+9zqz+GlFGaFfbQaTI8uUcFU/raIiKq302ev1sW+t7WOXMdqGDpma?=
 =?us-ascii?Q?BpfEjRWS3l66VNFpfuXbFu4zs5osxkuAh5PPpgN8MQ0M5M55jXli8t+dhg55?=
 =?us-ascii?Q?HoN6we+fa0+C+dtduAm273vzt8e9hpwa5hj9pThxfmey+OJsJsSS+7ENOtSN?=
 =?us-ascii?Q?UC5YyoN1AAjgBNMBBjd+ye8zu7Rh3tHUxt5iM0NqQZ6ClKfb2tG0CCy6udiI?=
 =?us-ascii?Q?Bc43qfa4L46oqRrsCqTz+u61vUBZG6DiDmP9Yv70+5T9f7G5B67Ww/kVFyDr?=
 =?us-ascii?Q?VFHyGmowlQJSTcxMWIkQFLc4XiyCYE2Gm9B52UatuNJxJwi4hn3+UDlcVr84?=
 =?us-ascii?Q?JxlDY/pfEqPMn3Q/pBGWVIA/fxs7slZAQfn7xGZVOjp0eKKsFHjb43SuMeKf?=
 =?us-ascii?Q?apSYHD4y6rPP8fjDMjbNptBmao7aazDoZfF/6dQxzioFPzAWBhZ6lVitRrKr?=
 =?us-ascii?Q?6UwqumoSDqP7nbUFqQxEys7kYm4tEOTCgO45+s0GS/56wjM4DiL9weU8PO/3?=
 =?us-ascii?Q?pINTB36FSyHxMUeugZ1ITG9//LXn5gMLvSJJ5//vsI73+lsOcYiruUGhaGbY?=
 =?us-ascii?Q?XdgXL8jRIjbuAA8EKcQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4c57f22-0cc6-4ce8-875c-08db98ee5d6f
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 15:36:14.2213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NxrT4AJxXwMg+99cnpwST+v0hDzH7YCIzMQaKuDMox334bFbjMqZojzjVRdyRpEqi/LVcZrt9st/GXSRLX169Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7161
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        T_SPF_PERMERROR,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
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

Acked-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../pci/controller/dwc/pcie-designware-host.c | 76 +++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h  | 29 +++++++
 2 files changed, 105 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 9952057c8819c..cdbff11a7d00e 100644
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
+			dev_err(pci->dev, "Host init failed: %d\n", ret);
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
index 79713ce075cc1..629bccfa92ddd 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -288,10 +288,22 @@ enum dw_pcie_core_rst {
 	DW_PCIE_NUM_CORE_RSTS
 };
 
+enum dw_pcie_ltssm {
+	/* Need to align with PCIE_PORT_DEBUG0 bits 0:5 */
+	DW_PCIE_LTSSM_DETECT_QUIET = 0x0,
+	DW_PCIE_LTSSM_DETECT_ACT = 0x1,
+	DW_PCIE_LTSSM_L0 = 0x11,
+	DW_PCIE_LTSSM_L2_IDLE = 0x15,
+
+	DW_PCIE_LTSSM_UNKNOWN = 0xFFFFFFFF,
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
@@ -364,6 +376,7 @@ struct dw_pcie_ops {
 	void    (*write_dbi2)(struct dw_pcie *pcie, void __iomem *base, u32 reg,
 			      size_t size, u32 val);
 	int	(*link_up)(struct dw_pcie *pcie);
+	enum dw_pcie_ltssm (*get_ltssm)(struct dw_pcie *pcie);
 	int	(*start_link)(struct dw_pcie *pcie);
 	void	(*stop_link)(struct dw_pcie *pcie);
 };
@@ -393,6 +406,7 @@ struct dw_pcie {
 	struct reset_control_bulk_data	app_rsts[DW_PCIE_NUM_APP_RSTS];
 	struct reset_control_bulk_data	core_rsts[DW_PCIE_NUM_CORE_RSTS];
 	struct gpio_desc		*pe_rst;
+	bool			suspended;
 };
 
 #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
@@ -430,6 +444,9 @@ void dw_pcie_iatu_detect(struct dw_pcie *pci);
 int dw_pcie_edma_detect(struct dw_pcie *pci);
 void dw_pcie_edma_remove(struct dw_pcie *pci);
 
+int dw_pcie_suspend_noirq(struct dw_pcie *pci);
+int dw_pcie_resume_noirq(struct dw_pcie *pci);
+
 static inline void dw_pcie_writel_dbi(struct dw_pcie *pci, u32 reg, u32 val)
 {
 	dw_pcie_write_dbi(pci, reg, 0x4, val);
@@ -501,6 +518,18 @@ static inline void dw_pcie_stop_link(struct dw_pcie *pci)
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

