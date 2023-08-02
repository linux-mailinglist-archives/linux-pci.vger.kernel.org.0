Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C841876D323
	for <lists+linux-pci@lfdr.de>; Wed,  2 Aug 2023 17:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235351AbjHBP6b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Aug 2023 11:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235619AbjHBP6Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Aug 2023 11:58:16 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2084.outbound.protection.outlook.com [40.107.20.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F1BD9;
        Wed,  2 Aug 2023 08:58:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mFCVp3bF7S8tDJ7AkBQ1UYCaj546m51DXYbmce7WVre+w0BiEysFNhMaHbVN+YLyNtUpbUrvkCDUMDQyn6KjqpggIQ8MHj/VxKoiKQ1SJ8QvEkuSVhRVMhJ1Ef4kP8NWUmh4JXeJoyUeNvygn1xFOxs1T9OzSaQnaQMC6UN79ZCZwZUiq7TMY5Dz1B+DbeZuKBqtQka3TDjT20UHy2qib0UcpOoWh9mmVOXpZn6WTn8VFqDRLjhnyRF6Bmc/fLyBKYNEev9ZBSWln9BHbIS/lP17Dq7cpKUs0YDDrHs0LSdkG7NlpOjIR4wcJItyoOCkIhhapSrCxjXMdjXaJNxWjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=telKg++iOHJ+T0XogWYp8GLhmLfsie10xeuwoabuvZw=;
 b=El3kQZIaXjoZpz4turPd2+zK8etOy8v36pHy58os0Uisk7tXl2KKwSBpI20k4YLUe3N3YrVs8+UrrePl3ScDUDXzUAJoBLFthrpFS3y6t30Sce3lDXZPM0icvzqoysqPOQDreYZe5dO/4JtQDepjQJyf/tJP7aFvUYLY6Vh2/3c7srpEmKomfxpFyiL9MK2/rkJKQ3GBG0zNXrrHOJgjK4pm2cBCJ+Cn83Oz9UPfs9ICAvKJwlhsswNNPFdRHhjjh6qb+Wv4jywiJBGozOKTJttL450C0jTIMtq+RpbK6FhYYAoYZsA0Z5jE+2TasLVlxZ/RxECD7krBcRgzYlWebA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=telKg++iOHJ+T0XogWYp8GLhmLfsie10xeuwoabuvZw=;
 b=dJ7XOWe9Hha2QIokKYWDWn5rNYKgQVomc9FwgtOgROPMMNLHYgi75kPBsXVHXOqICK3FUOfkL5RfKcLGQNQLCfmQ1OpMr6OuDXzQCJWnWD4DS4R+bUQ7VxLI+28SHlZHAn/n2Trb/8NjUoshRdyIXX74EshqTIM85M2WKX2pqLI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB7733.eurprd04.prod.outlook.com (2603:10a6:20b:288::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 2 Aug
 2023 15:58:12 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1%7]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 15:58:12 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     mani@kernel.org
Cc:     Frank.Li@nxp.com, bhelgaas@google.com, devicetree@vger.kernel.org,
        gustavo.pimentel@synopsys.com, helgaas@kernel.org,
        imx@lists.linux.dev, kw@linux.com, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, lpieralisi@kernel.org,
        manivannan.sadhasivam@linaro.org, minghuan.lian@nxp.com,
        mingkai.hu@nxp.com, robh+dt@kernel.org, roy.zang@nxp.com,
        shawnguo@kernel.org, zhiqiang.hou@nxp.com
Subject: [PATCH v7 1/2] PCI: dwc: Implement general suspend/resume functionality for L2/L3 transitions
Date:   Wed,  2 Aug 2023 11:57:47 -0400
Message-Id: <20230802155748.212377-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0178.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::33) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB7733:EE_
X-MS-Office365-Filtering-Correlation-Id: f54680d0-b307-48ba-e03a-08db937145ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y5ffD6N5MJ0wdpChnzIo+snrFbNIm8y+VOoZtjdWK73lIA9ZE/y30YAiTsGJTMI+J6de6PvJg/enkNOd8goZYxFh1nV/ZMM/prBluhGQYZ0t1KABTDVksjXZq30Rs6fHRofb3SfSpOmJirwyELnVqjH2g6V08Jrx1McNTersAJVwexjV06Rq2bfQPBJGElTKj3fltA+/XPVExKBp91HwA0P38rgyThf5MNg2CNv/XpgtEEKrz4vHs7v9vJGXGfui+EipJQpO30uTU8UbjFRW8KQoZPStgIJLohLDaCxquwTilTHQalsz4flx1hpsNL8/Zijm232D+eXZybP19pBWyWB4h3pp1RHjFFkq5qToqOZ6Q3XuxCLnrVgKDkqwmvyuxcdNWanrYJgsrfSoFcPtFsj3cjFJWD9/VAFCgZnfLfT0NBW3RcLdfwSPAKmqqjTrgU1aa+DTDLNiHQhOBWfOEy7BQ0EPxQY9q6fX0HFGopOItHmhvD7lk056sWEdur6OXlfmDajhnTRSJ3uWCF5nYgEoFTZP7ty7B7mR2wHNsWNFThKAqWnqB9lujfAQj3GUgtaNLr7xFTMYRpw86bWaIUVH7ZPtJYdIXeE8G2/mu5w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(136003)(346002)(376002)(39860400002)(451199021)(15650500001)(8936002)(7416002)(8676002)(316002)(5660300002)(6916009)(4326008)(41300700001)(2616005)(66556008)(2906002)(186003)(6486002)(66946007)(66476007)(52116002)(478600001)(6666004)(6512007)(6506007)(966005)(1076003)(86362001)(36756003)(83380400001)(26005)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9iBIWbLVxYZ4g8PrSIygGZREQA2y5r7YHhtjlWMfwzFNEgufwrvan4lILs5p?=
 =?us-ascii?Q?cTea0Fetcc52Wo4JL5ZUcgAk5T60rwc0fxT305WLuPPn7u6D3corIbSMm5bp?=
 =?us-ascii?Q?sF5r2QDiejHJ88Nj5ujRIcb8eUCIrlsGDTBoMc9x06zuSjGRN2hwQqtmVUIf?=
 =?us-ascii?Q?wvyQuQBUyTD4xDYnNjIkrqq2ep7noz4miy5BVXxWBfYmyGt6TAHaXYiZ+Gfk?=
 =?us-ascii?Q?1b+FnNI3VTMVA7lmUqR9emBHv8J2MNvfLKjPdBkUhSe8tKZcP50hLEbNunS7?=
 =?us-ascii?Q?+U/v4h8/FYljvLmulXRjDPcSJqPvwOiuSZg7nIT3C3jwoeqPPkUhTomoXPcz?=
 =?us-ascii?Q?PTJbzjCMFVFlv8fwUfNPJNjW2+cCjEENSmrIkdzdVubPwj7e09FPQ91WSoKF?=
 =?us-ascii?Q?s5BBf6DH6a0VokyyYGWrWNGfycJsGfnpCgb+JdJ+s07Gqmhq/w6eEoqeic06?=
 =?us-ascii?Q?ojpS43tWVlAVwCFb7gvFmfo1p5utZq0g5LrZdxvLxpE2b0CVrU0v5+WmbwEr?=
 =?us-ascii?Q?3LDKWS+iTh03r1h4AEOZ/WlChrco6+aqHDcbLcBT57FjxtVNA3+ZYRpsBpyO?=
 =?us-ascii?Q?wKrEzohbjC4eZeVV29jQ1z3BBJLOqN/WKBAfoLJ4fyk9fbP8t6Sx2Hxl8FaI?=
 =?us-ascii?Q?4s0Q9mpUPE9Z306BjUofN80j85RtIuv8Sx+/HGCIehWjJhJuzo6bZQ7HkiAt?=
 =?us-ascii?Q?SVgrMEd0I0FP69q/KNJDsrfSeEkXP0lGMzQHg1WvPcnYdjqQYfQZt/DqQcHs?=
 =?us-ascii?Q?10siDZiXrZfkTFMC947Idid3LFQxVfY5KlCt/jYV1MeLq5gNf1ijSise9eOk?=
 =?us-ascii?Q?nuxqQwyZyH9U4pdDJo0CdDsF2TDkdE5OAAwX4hZmEU8OFolM2ZXZZQEX5Z2X?=
 =?us-ascii?Q?qPnOgEl26kg17dQdZug/AWBFwPe1k5EpUut3t5QMRwA+FCTjymvyf+mPjak7?=
 =?us-ascii?Q?PyBQQ4cL3BGrCyrcowHzAVW70zpKGAnEWKF3XplDhvoUebD8EHN4A4GUxSxx?=
 =?us-ascii?Q?DTt0U4/FLhctcB0GbcZWZlbprY/ZsQSzNrCa06EWmzaocbfHTQRv7cnIv0Bw?=
 =?us-ascii?Q?SIOKWJ+imtB+3XXQr6961ekXCwYMW+T2uH4fp1X2E252xo3IOzEoLmfYfYBD?=
 =?us-ascii?Q?ERFshx+sLxO86prIOgcU8flFDoxGaTECFI77Us10g+B4Y74gHQaN8NILQbAT?=
 =?us-ascii?Q?rlH2/rqFVlOB2niq1r16jKSiroYE8y/uYuN30ssEobZNIzyfeRFTmpr3/iZy?=
 =?us-ascii?Q?gkkECc9/ljJAHRm3SZWTFdnDFOF8Npa9O813RYnAwqJWC5lPBupf1W8hmHs6?=
 =?us-ascii?Q?e9Gm/CITzSIJKz0c+yTy2mcYLkBrrkXCvydWjjueDQdKiP/3FRIPKDXFCxuv?=
 =?us-ascii?Q?G82U1Kcnl6kMgTSDNQs/b0KLvmt/YLVG3u6UXMRdaQcu1SI2HFB/hp25sJWB?=
 =?us-ascii?Q?MGJG/YNv64vwGB/3nfVE2mgy4g9YyQHYX7rJP2b2wxmAKWgYYYEcmRQM6fYP?=
 =?us-ascii?Q?w4jSdbLBq+VCuR42ecb/6u+LDp08GCNkt8Dp7pWspW+qYB4XkEqDXPyvBB58?=
 =?us-ascii?Q?3gb3U33DOAP/QwPMwog=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f54680d0-b307-48ba-e03a-08db937145ee
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 15:58:11.9676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hwwk7bhVxMYxJd8kePkXjxYIjWLUuiYKsdySH6DxFMjjh11jQCWucS8PLzyrLV64kj8+gUE9iJ4Pd2O9ysJE4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7733
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Introduce helper function dw_pcie_get_ltssm to retrieve SMLH_LTSS_STATE.

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
 Change from v6 to v7
 - change according to Manivannan's comments.
   fix sleep value 100 (should be 1000 for 1ms).
   use dev_err when timeout
 Change from v5 to v6:
 - refine commit message
   change according to Manivannan's comments.
   - remove reduncate step dw_pcie_set_dstate()
   - return 0 when .pme_turn_off is zero
   - call host_deinit() in suspend
   - check .host_deinit and .host_init point before call.

 Change from v4 to v5:
 - Closes: https://lore.kernel.org/oe-kbuild-all/202307211904.zExw4Q8H-lkp@intel.com/
 Change from v3 to v4:
 - change according to Manivannan's comments.
   I hope I have not missed anything. quite long discuss thread
 Change from v2 to v3:
 - Basic rewrite whole patch according rob herry suggestion.
   put common function into dwc, so more soc can share the same logic.

 .../pci/controller/dwc/pcie-designware-host.c | 78 +++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h  | 28 +++++++
 2 files changed, 106 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 9952057c8819c..bc01ecc1c3ec8 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -8,6 +8,7 @@
  * Author: Jingoo Han <jg1.han@samsung.com>
  */
 
+#include <linux/iopoll.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
 #include <linux/msi.h>
@@ -807,3 +808,80 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
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
+	/*
+	 * PCI Express Base Specification Rev 4.0 Section 5.3.3.2.1 PME
+	 * Synchronization Recommends 1ms to 10ms timeout to check L2 ready.
+	 */
+	ret = read_poll_timeout(dw_pcie_get_ltssm, val, val == DW_PCIE_LTSSM_L2_IDLE,
+				1000, 10000, false, pci);
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

