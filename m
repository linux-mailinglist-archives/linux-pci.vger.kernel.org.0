Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE57772B87
	for <lists+linux-pci@lfdr.de>; Mon,  7 Aug 2023 18:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjHGQxc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Aug 2023 12:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbjHGQxb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Aug 2023 12:53:31 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2053.outbound.protection.outlook.com [40.107.7.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9D6199B;
        Mon,  7 Aug 2023 09:53:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nbypGh2ifn42PATn/cTQsOjk56kcTY+yatxoUOvGyocjWeoJg8ae4/GGRhw96AuwBeKeCR19oV3E8r/xW1XXUIntYP5WexRywjNL0ksjaYSCHaiQqbpWDzLjQpfhSWvnsZmLPlPq8/h1fH76aihH3v2w0MVptMUZAtsZBu71USHy6jS7wuJ9PrK3z4zgYNzd8ijxXieyHWc1Azuh21d+MhF/VN9wWfxOshxIZBjc7Q/BzjrZAAOQzcxpqS7gdWG5otHtA5HbmxWWECwHUeYnNEVGlD2RvZctXAgN3cBBh2+jC5KvWhEWfdcXWfp6QBPlm5i0jAczyOGAW3o54TDiqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RuZYozsszV04m9+f6PLw4EoD1EIVUX6sjonI35T2M80=;
 b=UjMzYmLkaXd9rp05de9D8B1GPCuUFeJi+kQPkV5H5ximlDSwdF31iMvlIOBLC2Z0O8FTAH0SCDnoRmsJ+pdtZprVVeIKVAlCrCFQBD6j40GSxRkzMPr96BUnEN7c9U+11n1souXsERM/x72eoidQgg03BIJBj4SeCNEILlVIKcr+jqs5v/r2oefQ6SeLHgLzlaAQ1m96X5HMdSMXA+AlCWzDdFsT4ctF3Fqzh+ay6gY4gnGDOplHcpbsGuiVIgurtTd8MIQyak0AtR1pVKw+hoIYhRuQ27zufoGsK30sfub4asMbkhFjkWyfU5UdNkDSeYYqUqKGF/y/kbNchvGQFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RuZYozsszV04m9+f6PLw4EoD1EIVUX6sjonI35T2M80=;
 b=J2BS3BK0PJAdK64OO/WJIVZGJ6ByKnpELstcH0cC1J0Q2VQSLKOZpqHDLqvBWxQ8mHMgGJSP6lv7CcXMUY2BoS3Kv3FgcBJiW1Xmo6PPRVwHN6mTfRReozg70EpqOb2Yp5TYMiZs0jhFGVspMH+wocWbpwSR7MEvF+Bm7MLI+JU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DBAPR04MB7318.eurprd04.prod.outlook.com (2603:10a6:10:1ab::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 16:53:11 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1%7]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 16:53:10 +0000
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
Subject: [PATCH v10 resent 2/3] PCI: dwc: Implement general suspend/resume functionality for L2/L3 transitions
Date:   Mon,  7 Aug 2023 12:52:37 -0400
Message-Id: <20230807165238.569297-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807165238.569297-1-Frank.Li@nxp.com>
References: <20230807165238.569297-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0093.namprd05.prod.outlook.com
 (2603:10b6:a03:334::8) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DBAPR04MB7318:EE_
X-MS-Office365-Filtering-Correlation-Id: f8d9c33d-8e95-452a-4da3-08db9766c85c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H23mEj2AqHxZfXvxN+PXsaMR6s89DekiariWrqQQFkIobgOaCsZ4IoQi10HmSgRhdZJO10lRApoClv2OdAv8TOEuP1UE2gpKi7xG9X1FXuHR8IOaahn9HZxFe1jiFl2EnSufapqZDoqVkeuh2eWx/DwxDIiGuQNqzgFO3MwO/kJ3CUrUlDtuClubBJA1EJV2MMDazw0Vq/QB4oqWx5IUw1066UkkSENlx8nsAG6Yam5FsBMb4uimcCY2YSs1A1f9iX/PEVOE5lMcKnJAsPepJWGIAhUa5z/KnK3lESXLH+TmZQRGeXKhoGB0JIVzYixuHc3m9UCC1d6vQ4GFHakcM7fEDLyz18gKbaDmKj5Z9HDxM+AOa7o6G3gTTaxw0Yt45tu9Xz06yJfMeZlwlatqu5wCEtXNcRGr0DuUCN0zNnVGPvnfoh8AByRJa5so5bKCuZyuEtLI076SOctmnlEli//4IzadnQXQ7esU9MADjHrs6pE1c2V1bs0WhDa2YrBEsIkNl5CYscXnEnz4/+qD/MjaeK9rmZEq3BEzeY64g5J15J5DiMWiDyLPqQCfh6eTeda4QwOfo7Lh9Utg+B0V+/kRoMrn159xAtQpdlFAwnTH7g//RMtw3kR/dEwrPMad
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(451199021)(186006)(1800799003)(2616005)(36756003)(6512007)(4326008)(316002)(6916009)(86362001)(478600001)(38350700002)(38100700002)(52116002)(6666004)(66946007)(6486002)(66556008)(66476007)(6506007)(41300700001)(1076003)(26005)(15650500001)(8676002)(8936002)(2906002)(83380400001)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uWRGKrNdA5nFq+yG7cWX4RTbzyJLx9i5F//VkNFpT8pmntaZHn4ImsvXxRE8?=
 =?us-ascii?Q?SDUX7C0CyjS0MrDocovKDC43lEX1cOZyoCDGePYHLy9Yl6N5QWSgQ8uhCQTQ?=
 =?us-ascii?Q?YtxfouEBc9nsvJaOB7Fpy2UwXuI9yp7I1HAOHHrn4hamtGvK/EMVKxDom+DL?=
 =?us-ascii?Q?0jtr4dJRK9UfrQSVaTBgF+B1y2qTDmbnidZKdrv9kbySipne2ItThVo4uh8/?=
 =?us-ascii?Q?xPBrJNb29KPCXYQroqYduULutKn8sTlxbSRZ/LN80KLmf42QS4ZXprZxKcko?=
 =?us-ascii?Q?34cLgwtSh/yu54VYJFDnUhLgQs9XfX+T8kwNxAXvI6qyv+kJ5phZT/MYdb0r?=
 =?us-ascii?Q?Am6/41cDOH/fa25EOAW/yPuCf2QLjDWZgQXDwVYtRVtKyPSGHAgCKNYOx2rW?=
 =?us-ascii?Q?VA0gVwIIR4QLCchkWQI1bpNXQE523e2tY5i5Nez6KTll8PpsegBw1yeI4I9o?=
 =?us-ascii?Q?xizMTbgRKTs5LP6+UhCKu4Cq4v8MEUxmzXvOXfJ6GkvdKkIx/cXpInlZZW65?=
 =?us-ascii?Q?44H39cU4rbHGlw+3fuC3UwFXypSCfZE3s9LSsmYgXoaLZTIyzLGX6vIURUqh?=
 =?us-ascii?Q?ioqNSM9VDUu9p5TwfWXV2TGByS7sT41yaa3MOvOeFwdS4HDDIKFN0p/kNtHp?=
 =?us-ascii?Q?iz0/18fRJBsi08KPKkPBYdXYx7bS43pc5HK/3JSBC5Xnx583Qm064AqxIik4?=
 =?us-ascii?Q?HEXgztYCV6ZJ4VPqZH6GHWezyOpimkD7c/lUohdhkNV4dUChWK5WRIXrjKeo?=
 =?us-ascii?Q?DPJwyLGc9QvynrL6sGV4bNOXxRpWLgz0Cq+YoD40/uJUoIE5BfNtthFPZku8?=
 =?us-ascii?Q?U51/obIIoEw6ulxG9Zum8N8n5OfFagfVhBlxzz+7FsgUQGnIeM3KxJXkdGw0?=
 =?us-ascii?Q?DWTBEPIAvsE+2lzJKxe4A5jAHYSqBWSx75B/kbcLfeBApsAm4ePw2nToHQhg?=
 =?us-ascii?Q?q6blnBokccz6kziTadNoABFJL+V/GkeSKlx0Ermv8jvAl6vQMIYLKe0fvqH1?=
 =?us-ascii?Q?whXc9G9yHDAr2LdRM8k1UuSpuNd/g1ekb0CZC3Nt/Ms0eRfGd1vI2iGDIsne?=
 =?us-ascii?Q?Mu0BKgEU3Une/ltIVPHdruFUxWf2ZNnHZx53sc6Gr710TITIk1pOexvkahsG?=
 =?us-ascii?Q?VVLith9m10PcwdYJlIpJhchRlflx0mKMDCaRnIJWn5ajUhNzvPGclPpuFjz3?=
 =?us-ascii?Q?k2pS8gc8uq3hGO23w3NtizqlKZ+HLWqxStYlqoaTKSAkoDyqnu0eeP25vrmP?=
 =?us-ascii?Q?ttpWrzdRUmOeKAQKrvJ/97v+OKmEoJwxpswQVuArDdY55nxdr7uilLWa2vCL?=
 =?us-ascii?Q?uo8pkFRCvJKFFhaiXo65e662x0oYWPVw/p4aKhn88KsQAs/74FIRv1n8xaaf?=
 =?us-ascii?Q?ICRyHvqZVY+cGOUYRg08pSaJS5zyCqHVijnDT+iBgte16B6kOajNCragm73H?=
 =?us-ascii?Q?yFIpfpK/4ms8NR+ZlbMmVEDR+fgykQzpa/EW/XkOLr2V3WXJIP72QANtLnx4?=
 =?us-ascii?Q?wYfV3Z14kakiJMw1KsrdDCim+6YDPcTZdj8tBbjubfHfOf3iGCUaZT7wbXwX?=
 =?us-ascii?Q?HmxIH+Lq4ViCxOzRFzP+0jnuED9Br9vDBg0st+HA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8d9c33d-8e95-452a-4da3-08db9766c85c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 16:53:10.9174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UZth4JX3e6mbGoA65CjkAodlKni2Rv+KVHm2EFcmsxRZsEpzJWFNR7RKqjIWK3fbSpr4OGaf0qnIYjeVvbIcOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7318
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
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

