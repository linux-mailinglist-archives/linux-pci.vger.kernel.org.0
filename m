Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6657601A7
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jul 2023 23:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjGXV7A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jul 2023 17:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjGXV66 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jul 2023 17:58:58 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2085.outbound.protection.outlook.com [40.107.22.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0304B18C;
        Mon, 24 Jul 2023 14:58:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJWZobYBRlXqmMRk8J375y3upfZ8ZYsITAYYZ0yV07RpjxXyFAj7Nmh3io4vpu8Y+fkcbtDTKKZk1SidTEkw6a0nnNNcBVRWNhI0iMQNwNZUwhZVvQcd9oZCzaE9leCy4LEDn1USAEt8+XECFRmJwKl6AXkOvCRfmOkmvjk1AeeBNZNAAP2ZKOa8PQoFybrW+0/JJ/pdLYXfQGiCllX2VRg2xFJI3g7hKNv5Tmj3TDnyJ4WroZV2vkfcC3IZtPa6ITAbhoI3JFjhfBXnUlhTCyFWyUXzeJNyjVg9hMQFzQPJHm/nu41kheIWqu8+idnmdHRp/e2OhW8DCMBB8R4O1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q8qpVHG6G5BSP3ynfOwKaeEwtvUiWKIhvPO5TVGKS3s=;
 b=jxETzzsLg6XIVn6Bb/tQPaOQHhOdCp2jUPQ4e9cl3l+YnX8asoQzbd3TCWxFvu317bb4nzh+bjWsC+6/0SoxdRQF0QOpbX0R330TE/kUi8frudyhC2Eaau+VYYPOTBhXSg9+M826lTCSRmcfs2x2Oly9+sCxZh0Tp8HZI+Dxs43bmVviRcVkAm86cHDI7zn6Wg/LqdEhQUy/tiIBF0Ox94KJADY0iJjSiU7V01r6YLvREdD1n2EEvMsgX671RvAFhy07SFGpHn+Qap1WrzHLKCBirZHFEsJUs++rwvOaEgKNFa/U0Rg6aGv8qdTKkoerO+Hzepif2go/JIEj460JOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8qpVHG6G5BSP3ynfOwKaeEwtvUiWKIhvPO5TVGKS3s=;
 b=kL0XHQk+J8aw5xtFHcGR0Gr8Kwtxz+4GpQIS7m3u9JfCa5EjUMyoEjCgdHjk2txx1UbhlPxRa8G6WhyyvazoKpn059vdLrlkBjuDorxBuDDfggQSFmYVHuZfek7FKiiVBqHExglLdLc8uS7ol8OwAb8LsCQutkzoJ4UuSBgFsMs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM9PR04MB8226.eurprd04.prod.outlook.com (2603:10a6:20b:3ea::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 21:58:54 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1%7]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 21:58:54 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com, lorenzo.pieralisi@arm.com,
        manivannan.sadhasivam@linaro.org
Cc:     bhelgaas@google.com, devicetree@vger.kernel.org,
        gustavo.pimentel@synopsys.com, helgaas@kernel.org,
        imx@lists.linux.dev, kw@linux.com, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        mani@kernel.org, minghuan.lian@nxp.com, mingkai.hu@nxp.com,
        robh+dt@kernel.org, roy.zang@nxp.com, shawnguo@kernel.org,
        zhiqiang.hou@nxp.com
Subject: [PATCH v5 1/2] PCI: dwc: Implement general suspend/resume functionality for L2/L3 transitions
Date:   Mon, 24 Jul 2023 17:58:29 -0400
Message-Id: <20230724215830.2253112-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0007.namprd07.prod.outlook.com
 (2603:10b6:a03:505::12) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM9PR04MB8226:EE_
X-MS-Office365-Filtering-Correlation-Id: 064ea67f-32dd-43a7-d995-08db8c912bdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UUXjUyrwE+1m7OXTdwjniU7pLACsOud6rsRmH8j6nx23/lCCf2VRgZGLs0vZrECR56eG8NVzZgSQ3gLn25Dt6DtKwLn+wTmAP0atyFXP3rytyBCBRfPG/RFsmwqRBC07oZLpsOh2y1XBl3l2MfNSjRluuZWH9XEpbACnOyRL3Jo6miimVf5031vVz/wAmgeENajjm+cUYtHy0eD5vKh24KUapgBBfUuyabdpKr6KhOQRFCnWZyx7X2/eQz0TQfxo+NdmkyTGK2LQRs2PC8gyaeghYZeh9/IardTzOSQJteu32CDa3QUf7Lo8654uB1M5faPhSmvnYPFbHuaarmuaqRh75DYw+Z2w/ARROQz/h3pH+KnN/zWakKiAVTIyt5ZxlWNG80id05yWBaWrm9aTbL/JLrXE/89ghQAwE+JHPl3SRLd8DxVsGXuo47sqQcrxLvMHfb+i5WWCMrR6f76X0heNNqU6lBBa3C2ywmemY/TGugTrdlvMLMLR4nKSa3RETbhRl5zVTZLSy/CnNXl7pibsUY03tlcEAAX3vahQq66H8Ts0Dz5W7Qit5NDImXIZ1rwYOv0PzPEiBYPcmS6A+8UYRq42phGQqboUTWuk6Uo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(366004)(396003)(39860400002)(451199021)(38350700002)(38100700002)(36756003)(2616005)(83380400001)(7416002)(8676002)(8936002)(5660300002)(478600001)(66556008)(4326008)(66476007)(316002)(66946007)(41300700001)(26005)(1076003)(186003)(6506007)(52116002)(966005)(6512007)(6486002)(6666004)(15650500001)(2906002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5gHdHWxBmxVpo8rQL1+lme7jTG2ReE2C6rtQl0vMJbgisXdSk0GRVMBO6d4+?=
 =?us-ascii?Q?uR07p8bwFAaQr479hydY8gjfK72zacKTLQoDyLIqv8O/OUlCrfSWI9KzIhBR?=
 =?us-ascii?Q?QPrraliu3CvO9sIj3jWe531orZUCGYmVvRNzwa6kF/3ymnDfHpV4kgfzFJg6?=
 =?us-ascii?Q?iiXzJWAT3YNvbmF97TS1AseJPxN9PrQRW14A7RhNG9BCwW1K8xcW5PQfoCCI?=
 =?us-ascii?Q?FOR2UqkNGCvga9eySovxWNwzAsx+8jM2xz2saHd9jhksaoBJTatDXHbOcSDR?=
 =?us-ascii?Q?Xz+EQDq0ETw8CzaZVhYhUm/gLvqyORdKkBOu3JRTGQ5C1t2L/rlNlJweQPjy?=
 =?us-ascii?Q?AOic56eW+mOKQagVM3b+P6sbTeGH1TNQEhpPIa8k0XaFSxTvpV66auC4HDJg?=
 =?us-ascii?Q?5j6gmW/af2kCxhL9hoC6YWzDFnDN/1KoowX54tSjgFU3meCrN/Wp2GAbJwGA?=
 =?us-ascii?Q?n4APR6bfIfCHXEqb4kdo5d6MvVtjCGA6sRwyQh8apZ+tjSjZ3+jcV84QQQBk?=
 =?us-ascii?Q?+ZllKUCqjOurhqTeBI+Y74ATxb4bzKKgOWEgcUmAiEhFFBY1ObYEdRSOMf+E?=
 =?us-ascii?Q?xi10KfncUzlv16sGWYM/Uly+7YqoC9oWWtpJpCESHS0ejkd+1ND1up3d5/ZP?=
 =?us-ascii?Q?BVsDjnyqQeJGijHdqbuXAa2UZlYRO13pguk/NvdRPgZ8vj7UeV2DpVwA3Ybc?=
 =?us-ascii?Q?E2yH86Fjg5urk/oA72+sADb9wN+zjaWL4Jgq5LaFw6cVIoQxCqsLsBNWefUr?=
 =?us-ascii?Q?I9mm1fKdUyKdhQJji3Kmee0EYoQjwhlsqGvePTqEaHObksE1Vr7U6+zTfRia?=
 =?us-ascii?Q?5pIBnRYr67EpkPx/2kZMNnOt9Ib0/FQg+QzGD6BLQUvrp/kap8Xqm4znHz7b?=
 =?us-ascii?Q?8/Cg5L4W9T/0xZ7HqemnWAogZdKLRCBFZfBwa0CBTP45gurRef6/L4EtsCdV?=
 =?us-ascii?Q?jzzXP6gG2FsECtJ+qLYWNKAoMmXF08ApwWOK1Qnr9sC+8e+qAc4T/L8y9e+8?=
 =?us-ascii?Q?caRa1T56eT2yqgrI5NqOJFWO75IPZgUhI+SbPvglzkUi1GyhQxv2Q1d9pBCp?=
 =?us-ascii?Q?AXVt36PtD+6R5pAlYzjNrdjda8ANwellNg59psdPjTzyK+I5msRzQVGpaFoS?=
 =?us-ascii?Q?+cAwdJPe3zbUVioo1ht13fQm3ooPsC0ojSThoTuXFo2MvuVHS3UlKLv/pemE?=
 =?us-ascii?Q?pxNez5pTQw71vAD6AZllx3ZrsDTY7rQtFewVCrED1OaiBxxW7+n2rnl1o87A?=
 =?us-ascii?Q?sKyHA9ShT84kekntzypc9dfsjXg9q3rIpZpN8LdDQROu2oHg2jk5albsKyBf?=
 =?us-ascii?Q?f0AaGJAvTHH5ASXZCGmf2wLEeOYbKtztRFrc6BQAuEPYr+lXuz+s58iv4lN9?=
 =?us-ascii?Q?Mm/MfRCTAA1xJpREecGKHoDFQzvP1JDJF0t5Cll2JIOs84RvcH6bABtCrrTF?=
 =?us-ascii?Q?Ul/SXAAjvGnryRamJYN0bHRQAwz4ZHL2reAfASpqg+7Ho0XIBhHtJhas+QS4?=
 =?us-ascii?Q?Pjol6Rm7CVZ6tThKQoLx5BR6V5TMlhZr6vyaUXq9OtqV+6nXKPtq2wvQQ4cT?=
 =?us-ascii?Q?QvmOrH04g9cM6elLcNQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 064ea67f-32dd-43a7-d995-08db8c912bdc
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 21:58:53.9092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WXL4ESy7PWTODpV3j1gUnjxRFpObV85H5JDGWQF/TKZQ1KytzNAn/r3obIaqxdKN2wLpt8EqNt1NvqG/cRfr2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8226
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Introduced helper function dw_pcie_get_ltssm to retrieve SMLH_LTSS_STATE.
Added API pme_turn_off and exit_from_l2 for managing L2/L3 state transitions.

Typical L2 entry workflow:

1. Transmit PME turn off signal to PCI devices and wait for PME_To_Ack.
2. Await link entering L2_IDLE state.
3. Transition Root complex to D3 state.

Typical L2 exit workflow:

1. Transition Root complex to D0 state.
2. Issue exit from L2 command.
3. Reinitialize PCI host.
4. Wait for link to become active.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v4 to v5:
- Closes: https://lore.kernel.org/oe-kbuild-all/202307211904.zExw4Q8H-lkp@intel.com/
Change from v3 to v4:
- change according to Manivannan's comments.
  I hope I have not missed anything. quite long discuss thread
Change from v2 to v3:
- Basic rewrite whole patch according rob herry suggestion.
  put common function into dwc, so more soc can share the same logic.

 .../pci/controller/dwc/pcie-designware-host.c | 95 +++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h  | 28 ++++++
 2 files changed, 123 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 9952057c8819..031e1f9c0d0c 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -8,6 +8,7 @@
  * Author: Jingoo Han <jg1.han@samsung.com>
  */
 
+#include <linux/iopoll.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
 #include <linux/msi.h>
@@ -807,3 +808,97 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(dw_pcie_setup_rc);
+
+/*
+ * This resemble the pci_set_power_state() interfaces, but these are for
+ * configuring host controllers, which are bridges *to* PCI devices but
+ * are not PCI devices themselves.
+ */
+static void dw_pcie_set_dstate(struct dw_pcie *pci, pci_power_t dstate)
+{
+	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_PM);
+	u16 val;
+
+	val = dw_pcie_readw_dbi(pci, offset + PCI_PM_CTRL);
+	val &= ~PCI_PM_CTRL_STATE_MASK;
+	val |= ((u16 __force)dstate) & PCI_PM_CTRL_STATE_MASK;
+	dw_pcie_writew_dbi(pci, offset + PCI_PM_CTRL, val);
+}
+
+int dw_pcie_suspend_noirq(struct dw_pcie *pci)
+{
+	u8 offset;
+	u32 val;
+	int ret;
+
+	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	/*
+	 * If L1.1\L1.2 enable, devices (such as NVME) want short
+	 * resume latency, controller will not enter L2
+	 */
+	if (dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL) & PCI_EXP_LNKCTL_ASPM_L1)
+		return 0;
+
+	if (dw_pcie_get_ltssm(pci) <= DW_PCIE_LTSSM_DETECT_ACT)
+		return 0;
+
+	if (!pci->pp.ops->pme_turn_off)
+		return -EINVAL;
+
+	pci->pp.ops->pme_turn_off(&pci->pp);
+
+	/*
+	 * PCI Express Base Specification Rev 4.0
+	 * 5.3.3.2.1 PME Synchronization
+	 * Recommand 1ms to 10ms timeout to check L2 ready
+	 */
+	ret = read_poll_timeout(dw_pcie_get_ltssm, val, val == DW_PCIE_LTSSM_L2_IDLE,
+				100, 10000, false, pci);
+	if (ret) {
+		dev_err(pci->dev, "PCIe link enter L2 timeout! ltssm = 0x%x\n", val);
+		return ret;
+	}
+
+	dw_pcie_set_dstate(pci, PCI_D3hot);
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
+	dw_pcie_set_dstate(pci, PCI_D0);
+
+	if (!pci->pp.ops->exit_from_l2)
+		return -EINVAL;
+
+	pci->pp.ops->exit_from_l2(&pci->pp);
+
+	ret = pci->pp.ops->host_init(&pci->pp);
+	if (ret) {
+		dev_err(pci->dev, "Host init failed! ret = 0x%x\n", ret);
+		return ret;
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
index 79713ce075cc..effb07a506e4 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -288,10 +288,21 @@ enum dw_pcie_core_rst {
 	DW_PCIE_NUM_CORE_RSTS
 };
 
+enum dw_pcie_ltssm {
+	DW_PCIE_LTSSM_UNKNOWN = 0xFFFFFFFF,
+	/* Need align PCIE_PORT_DEBUG0 bit0:5 */
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

