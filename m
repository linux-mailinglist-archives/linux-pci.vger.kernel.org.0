Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5931C76A164
	for <lists+linux-pci@lfdr.de>; Mon, 31 Jul 2023 21:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjGaTkh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jul 2023 15:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjGaTkf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jul 2023 15:40:35 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2062.outbound.protection.outlook.com [40.107.22.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB2619A2;
        Mon, 31 Jul 2023 12:40:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FcR+yyLe4Ro/rkHiqszukrQx7XU3c3YSKOI9aw48dOt1apG2KsEllspr/ibflmd1ASIm6ncbGkgdWHxV0MAEBF7SqUGw3qvxC0bMTOiuAbjr73Bk9/MMgmGLY0BMRV4DxfdVitWPQt6UkQciqf/Fh+JTzx3cAZ79fjpWJwfoMEraI19g6LqoltzjrxG+IEVGpv3/JdLgT05/RrnptRmYQ2oUbOW869hr2A29xqtTLNNSRTOKCs8OjYC45jOjBaI9Yv6sSHuU7hC2lIDiJV4FqjMstfGZOgx996DXiOSJsEk34S8j7wy3WFbEtozy9qCLKf1xMu4hmQxBSmHtmR01xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zz2r2hHL2LC3oYTGVkmkscPRMOeUXOrgP8c3nTPXCCc=;
 b=oFhs6eDmJrEzq6fwRLUG5SkPW7ltCSQQUQ/RZ7oFXKMO0qCCZv4rzUctrPNuUdS4qkYMRFSelxiia7VWfpatZuHatb6Fx1AGwEYUxTxUUQb1nFSJA9xhnxU/IvZ6+l+r7FH2gRD9rUveuKYLRZuZFNYYaG79Iz0153wRgw9LTpTO6LQZqEWrn0fxpUSs4Q31dRKkyB5iPeD3EznfgRKHjc/2w/goAXbHaSEM2fmyVPuEKfb5VaaxtbAEfG2CaJsCIWK55elAfNXCwafxaGl5M48U747+NhByIZfbDrKV7SWVyLQuKz04f3+jjGSOF70yl1ewvRGYncGeE+ulEJSXwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zz2r2hHL2LC3oYTGVkmkscPRMOeUXOrgP8c3nTPXCCc=;
 b=NXIMejZg+AhXI95cC6Qz0tqmT9W1nOTmoASE8MMJGIZyBuUEZRZU87KczElcJKFCAGQQ+0doQBlG8frqFButG56p49uRjZaTLkRFz0bwgIbhyDbDTTvtspLTLt29+7K8O+Ha7kheDsyzI8AhtAXYKOqy/AYWTvTUiSTgVnfwvUY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB8344.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 19:40:31 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1%7]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 19:40:30 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     lpieralisi@kernel.org
Cc:     Frank.Li@nxp.com, bhelgaas@google.com, devicetree@vger.kernel.org,
        gustavo.pimentel@synopsys.com, helgaas@kernel.org,
        imx@lists.linux.dev, kw@linux.com, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, mani@kernel.org,
        manivannan.sadhasivam@linaro.org, minghuan.lian@nxp.com,
        mingkai.hu@nxp.com, robh+dt@kernel.org, roy.zang@nxp.com,
        shawnguo@kernel.org, zhiqiang.hou@nxp.com
Subject: [PATCH v6 1/2] PCI: dwc: Implement general suspend/resume functionality for L2/L3 transitions
Date:   Mon, 31 Jul 2023 15:40:09 -0400
Message-Id: <20230731194010.73016-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0018.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::31) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB8344:EE_
X-MS-Office365-Filtering-Correlation-Id: 596d22e9-bdcb-4150-3f66-08db91fdffbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +XrQUGqgQB+meaNd3uY9JTd54XHVebTQx/9HbJALMbCEUhSNmSv7AvUcRr1+s47GlevU2ZPHlwCQYVWgQchU9viDM8wjoou901A/VH9wDBvJQBklA6FMOe1JumDBbRLLhzpyAvKeFg5Y4kajPAIfzJHNinsXJirSLQ1fsRx9I4J9AMSsNDiLIHPj/mi1xlL33JdIw8GZZOYrY0H6CRWXjp3s9G/IKK7NEnmY/Peyn8QB6O83iJaibPqwHZKZAC3WIPaFui+3vOSH0r28HIBILYmVEuAF1RjUieTn6PRn5TF9j7Q5Y+58XmfnvwZsgGhKF0L+/decW/IEOiXkHdTEjURfYPUJk5S+nC1c/lxWxdBdlUGDJ9+v+cU/kgHoZOcY9jr7vPnp81vFQUOm52/HpOCX1egmiSkdJOYhLZnkg0kQeOBHRqy95yNHB7eqwhpwVoByGLaQh+MkEWDmHhqlnnCcfnfIwx9LzfQj1+LDO53JIFrPWvkUpNXECyEyBZv0WrZ/4Guhh+hJBpVLOu/SysgMuXYvh9xi7I8FWIZogTSkbqQwjo3yrHElS+ITPsgnSK/NHvOQI/nu8YhEtpZBcuuSaMq5RX3OdL+zLlTD8Wc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(39860400002)(366004)(136003)(451199021)(38100700002)(66476007)(86362001)(8676002)(8936002)(5660300002)(316002)(4326008)(6916009)(7416002)(41300700001)(66556008)(66946007)(38350700002)(15650500001)(478600001)(2906002)(6666004)(36756003)(966005)(6512007)(52116002)(6486002)(6506007)(26005)(1076003)(83380400001)(186003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wfRicOr6DypTVC5uTaPnuuKobhCbi3bNNVQsiBs2c2ZHJsxi08I+MIA1Orku?=
 =?us-ascii?Q?Bvx/pTy9gZvWlMJeRKqn6KH5lSLsLRsf6KCDavEN8kzooeFaqzv//t4ZUKHP?=
 =?us-ascii?Q?ucAulJA6//wMETowPgfYcEE2LAO3jtquINVxBu/jmgIto5nHn1l1tvF+B/9o?=
 =?us-ascii?Q?ynvI9eGKPfkx3/aloLPaKdoJ0Z+FiMIwk3qS0ESnEyF2xFtXHJK5Y6K5nhB9?=
 =?us-ascii?Q?yHTlbtHD4lqGOO9mj+1IDNYwQY8Yqbqx/ZQgHSeZ/FufKUb5+xBSkGmi+CDl?=
 =?us-ascii?Q?ac/w2PHKlmaqvcFp0jsaPhbwWsR1pnXJC+nnnvYqa9AY6xs05TXR+LUplf9B?=
 =?us-ascii?Q?JHqTbvy/gj5KXUA9IahZMosmsVX19H1LOStTuM1Uomtt9NguXP9ZWclxij+T?=
 =?us-ascii?Q?QkmnU2wmNctsFRo2kKt9mPUaBMK6vR69L5SblVVvQW1cORc+sqbLLssAog66?=
 =?us-ascii?Q?MnfN9TPVnxhXII6K6UraW2CaBrbUuO8gIGGGZqjPrZY52wBIc6R8okGtGt6m?=
 =?us-ascii?Q?FnmwcbcR5VsAO17U6Cyc7WwdwfuqTC0RDI71pFKWJfv3umzREXcaC/rsaRd3?=
 =?us-ascii?Q?b07cWuYAvU9BUHanf7C6VIqJCpAOYaQwghYnowOlbvuxyuuveajLoUCBI9Pw?=
 =?us-ascii?Q?X8qJuEgWtCPXbKtY/vgO7B3QUp8GFe+zvIzvbxyshlMOg1JMkhZWrAobPQaQ?=
 =?us-ascii?Q?5Y7ktjsK1jeftOpJ2kCjKAxL7ua5IzwmM9TrJlIzHZXOz/pzuQ8fiqPrHY68?=
 =?us-ascii?Q?aStYq2xEbmWVMyxYsGwcLsS4m95+WZ7IaJNUl8tP1TdwoKAXIxVRrK0hI4Gu?=
 =?us-ascii?Q?GpGmJAiHZ+/6JZCjJF9o6VRa4TjXQo6BIjhwyYxajBmQW71zc/Dcsoy9/k1p?=
 =?us-ascii?Q?vgAw9zO4j8d8GESeRG+yxsO3/KFb2yivqtQvdzqalnZowSt6EfN1PGcMb/Gp?=
 =?us-ascii?Q?7/iBS/DPjh38lN2coIbJhVwWOKo1Ywqk2sbQK+2LFmNfrcX31iFP1tLO0z6R?=
 =?us-ascii?Q?LUMAV47Hh22GhGdTyHQmgPy2ZkKeH6XKDUEm/gRkHqMf1V0vocTdRTtFD10E?=
 =?us-ascii?Q?p+4bzCmN/Nl1ii29I8tK1HsqA6Js7mJN0CSqyfOf0tiH+ateaupiezpGnvyB?=
 =?us-ascii?Q?MQuReBfAhWZ4UghhHIC2zvBOQHMXVs7C4Kxgob23MjXRJCsuBhcpvbiOXAIR?=
 =?us-ascii?Q?kN8Qo6+nidTHJwZVAB0v3bp25xFMCCQxuAdrg/nEVw9HlBxFZXWadX93RnIG?=
 =?us-ascii?Q?1mQ9x5e0mIlBSVivguaV0L7uK2SBMR2wgxuUpWgfZ5lSJKTf29LjZZObIYxz?=
 =?us-ascii?Q?rZTmoZi4CF/ieTmdSqPerqVv3jRMwDbG9ER7reEtdovjKsgeJNWa4mP19gqD?=
 =?us-ascii?Q?oj2O3nK2+nFvVXIekRUYkgZqW34OMgeTBbQm5x0SgA20z0pNbEFhcdkgzMd+?=
 =?us-ascii?Q?MfleU5xUO5kVMfRLewWGip3f/WpUuvJZjIYC/fljPeUki+j9YYZZuG3RKL1K?=
 =?us-ascii?Q?5AUwglU/fgzM3wLLl9+ijYjIBtA+lM4wHwYWKXi7wnDacBx4Jbl/N8Pi6yrs?=
 =?us-ascii?Q?12acWEWPiJUr4M7UgYg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 596d22e9-bdcb-4150-3f66-08db91fdffbf
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 19:40:30.8404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s1bXnxrkBCffl31D3gbyf9KAFviFnQBVJeHGTuWLmCynRDUTWKmxZRp3IDJKp+GwGWCo3qmbnyNxJ88kbKCeDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8344
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Introduce helper function dw_pcie_get_ltssm to retrieve SMLH_LTSS_STATE.

Add callback .pme_turn_off and .exit_from_l2 for platform specific PME
handle.

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
index 9952057c8819c..1822c04d370b2 100644
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
+	 * PCI Express Base Specification Rev 4.0 5.3.3.2.1 PME Synchronization
+	 * Recommands 1ms to 10ms timeout to check L2 ready
+	 */
+	ret = read_poll_timeout(dw_pcie_get_ltssm, val, val == DW_PCIE_LTSSM_L2_IDLE,
+				100, 10000, false, pci);
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
+			dev_err(pci->dev, "Host init failed! ret = 0x%x\n", ret);
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

