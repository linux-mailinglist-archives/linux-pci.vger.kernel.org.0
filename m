Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A80B6BF217
	for <lists+linux-pci@lfdr.de>; Fri, 17 Mar 2023 21:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjCQUF5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Mar 2023 16:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjCQUF4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Mar 2023 16:05:56 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on0622.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0d::622])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3DD14218;
        Fri, 17 Mar 2023 13:05:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iYxB+TgKePFOEbd4Un5ViSZjpHU1LURM0ndfbKzYuupB7PRroj/LL4e5sWIznkE+xY8m/q6rdKjV9cnaerkD/98Oj98cOWm3VSH1yVWLTcEsV8dEssqMpZZD0SSrA/qYuyycETUA3t7UsQ9D3T2DVJKueEV9p9RYw3XcobAQIir9r8BKCJFNZs8odZREuEuGaPQjav2DiOAKNp8P5U44O8nE5vQqhKcEon3cnbNGsUyrtn33iDomm+n6Az4FaTMFKIsPmnOzR+/wzyxgDOtv6J7FeXIl5xnwKQCi2QU5FjLidVv4p8UVKERoy3jy1S9OCCP0AUHZI9F2vzNmmuQsXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3xOikXLUd3mdw4n/ebvDMoCshw6zEkWNoFHdj+c0CvY=;
 b=K0gHtqi7Ed2E54UmfLbKhhd5oWBwRNGkzgvBxnrO95hm/T3UB9r4J8uQXpn4RU8SY5YtPjLHWkF6gf3dr4aw7J0XowIYPZ3vtlQe4YZJTWey/+x/zNdXheqff7f6awcihbdZEV0Nkk3wTkv1qnXj8QFMvpLnsTDGcWxzx1FN0mQCbL2eAmBWFIDQGJbgofSqMzHHH/txDmkR5ORaIr4AhnWCDxVt+yvVBUpDUSZW9WFaVKObE7DQaMHzVKnBWJYhYCpW4MYMsdkf3ARuY93c2f/d8xFIzbVSjs0pvUNzHAi4ewTgV/Wpvg5r8asyw2GENZRWGZL9JS78ViKZpkPU9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3xOikXLUd3mdw4n/ebvDMoCshw6zEkWNoFHdj+c0CvY=;
 b=BKtPr3I0CUUC9/B+AZMaNx8xgJohyje2WcWCjXE8nyHWHCyL2/iGcRgkTZFUZS8EBXTQHfnQMKKC+X38X+sHnbaWi+R5MTvC7F2wla8Pm91xN3edfYb81AOOrL6grphY6s3LAwUA0MF530PGzLPLRXGgja5N0x/EjUc7a+jg4i0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB8446.eurprd04.prod.outlook.com (2603:10a6:10:2ce::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35; Fri, 17 Mar
 2023 20:05:47 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5%4]) with mapi id 15.20.6178.029; Fri, 17 Mar 2023
 20:05:47 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     lorenzo.pieralisi@arm.com
Cc:     kw@linux.com, Zhiqiang.Hou@nxp.com, bhelgaas@google.com,
        devicetree@vger.kernel.org, gustavo.pimentel@synopsys.com,
        leoyang.li@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        minghuan.Lian@nxp.com, mingkai.hu@nxp.com, robh+dt@kernel.org,
        roy.zang@nxp.com, shawnguo@kernel.org
Subject: [PATCH 1/1] PCI: layerscape: Add power management support
Date:   Fri, 17 Mar 2023 16:05:28 -0400
Message-Id: <20230317200528.2481154-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0226.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::21) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB9PR04MB8446:EE_
X-MS-Office365-Filtering-Correlation-Id: 86f769e7-5bb7-4fb1-de5a-08db2722ff32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5802URhgl14onqhiSlHAVGH/vG8YOQcpa2UL3mG3Gas0u4go221oebohjauAy08IEMgYsvNagY0I7gJMw8iiVM6QC484MTyvRTpa6HjqRBdajKa1xm3tVxzUcJH97g2tXQUjw0SfMQyYu+q1vkFo4gJzrYpj0VFgWuN9lqeVvldt0aImit0Rc2U4Q5IIyBEj1sOJcBhXfhsa2kAh45j8ynUlda5M7jWL9AsiFPh7iJdFbX+jnTMj7RNJSVurLGzaxAjv2GKWgT0IK6QF9/+FBSCH77q/z2EV7oJ6C50L+W/LkhttpUN19RpdT/p033kyUSpzsqxcFnI8Z+JUv9U968FXlDh1KlD1TeCQdRSs+vMsvi/wwkkGrDCoEtN418rG/wek7KH77uN/8njiKGAtmlw9tkT4SQeZ+fLBWFeFCYQtKLewNRKK9ev9zLr2k4nT8XxXoV5D46wPdVGjC3qERLEh+hmpsnbsopLerMP25gDTGJkYbEduyP7/MNLljaY9PBN+X6iQsnEPrnlFnASbTsCTRRgX+SqEzzjBOwPpg7cwSNy4C0U56XsF5gD8piBZfg20rlpsjtgEPN65sMyILNzJ/O8UNzwhLPoXalxQx6tz/CkyobUjBqF4AYXfSfkLRRNCx/2iKHT5yMRmssTz97E9K9MVkokcwUWYirW0we3dgbIUUfMKa0rDJnxDBm6p
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(366004)(39860400002)(396003)(136003)(451199018)(41300700001)(30864003)(8936002)(5660300002)(2906002)(7416002)(86362001)(36756003)(38350700002)(38100700002)(478600001)(52116002)(6916009)(8676002)(6666004)(6486002)(966005)(66946007)(66556008)(66476007)(1076003)(4326008)(66574015)(83380400001)(316002)(6506007)(26005)(6512007)(2616005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGhRT0h6ZENMSzR1WGxicHA2TXVpdmdIUW12eG11cmVzK2Judjg5VzlvbjBz?=
 =?utf-8?B?M1VnMkxIWk9hRVpPZzZTd1lGalJBaTFjNmF2blNWYUxIc01CTlNvY01iRWtm?=
 =?utf-8?B?TFpHUkhHVWo1ZUdUM2YxWXJYTEIxVjZwbGRuMC9Ma3B5YUxQZm8yZU12Y1VS?=
 =?utf-8?B?bTNJTHZZWXF0Ry9lNlRWVjhkbU94VUhXemk5SG1yR2dpL3J1YXg1Zk5vaXMw?=
 =?utf-8?B?QVYvNklMaDgvQ0R4TTBVbEE1eFAwaXVnUGU5clVwNkRzTzgvdUJtbHlnWkNv?=
 =?utf-8?B?VFZRR3lLaURJUThWdyswZ1kyTDI0TzlhUmlrM3BPVk1YUThSdHE5akpXOW5H?=
 =?utf-8?B?bHlwc2Y5OGF5a2NtYm80NmUwcWFDMWpkL1VOYnFCMzRaVjBPL2xkcGxDRUd0?=
 =?utf-8?B?b1hUNWZwZnM0SXJZVE9YanM5RjlpUWUwMUlHbUFUR29pdmVaYTNDaGxVcita?=
 =?utf-8?B?VzBsRW55b0JoSGdEcUZhNWFiRldaWTBlTkdUMGtUamYxWTNld2wweTlpaEVv?=
 =?utf-8?B?U05QbXA3dngwN0hKeGc4Nk1NNmJpYVhMdmRhQldhb0lYS3hkRmlwMzllSHVl?=
 =?utf-8?B?c1JVY1p1ZWpHMmpnQ1dTVWJBQ0dCUzAzSzBHRHIzRm0wWFphMUsxM3JDOWtq?=
 =?utf-8?B?Z2JkWEtVTzFpdU9kaDltUVc5RXg3S01Ea3lGSkdMK0NRMktTZENBT2hTKy9W?=
 =?utf-8?B?OERoOFdKRmFVcy9UUGYzR3JEYWl2Z3Rva3hBWXlCc1NBdTdoU0N4TkNjVVZX?=
 =?utf-8?B?cW1uZGIxU2tiMmdiTmlyUXVZZXBnWGJFQ0VmZTU1WWtFODA2QnF4VXhGQkNP?=
 =?utf-8?B?cGVNRC9RazR1RmZYT0tpcTZjYUVQTitiaXUyeUxoMGFSbStpbkJxWSt0SFR0?=
 =?utf-8?B?RHVCYXhNditucTV3OU9hR3JiY3FVYk5nSjdxNGEwaXZ6ajNkN082VGlZaFBj?=
 =?utf-8?B?V2RJTnV0OHFOWTAva0RxMmF6eklEdWcyYjJzNFAxU0RoMk9TY1liMjAvSWhi?=
 =?utf-8?B?V0VGcS8zbFRHdUJQSm5BUkVLSm9XUC9QK3VmVHEwdndlU1p3VE0wZXBYVElT?=
 =?utf-8?B?a1RFU1kxZ1NDdWZwZlFKMVAyWk1BT2ZDUGllOWhRaXhPNk5ybGlRSGNlMFBC?=
 =?utf-8?B?bWtzYVBKWlBPRHhXbys3eWM0NFBhTFBESmJmWWlTMGhia0tRY0M2YUg0VjZm?=
 =?utf-8?B?NFZUM1lJSXorQU51NW5wRG1CY2ZBbFMrYXhDWFVWQVhTNGcwYVNIS0NkbTZs?=
 =?utf-8?B?MVg4eHFXalpBdlplbjM0bDFTYkczOXJFYUxDdXd3S1pGVThxR05SbHZlbU1J?=
 =?utf-8?B?YlVuVmNSd2JXOGdQUHl5NG4vTnlWemtYTnpZNklkc0NhNDE5QkZTazZ4Umd4?=
 =?utf-8?B?RjRlMTg5aW1YRS90cmpHL1hXMUdvd1B1L2VMdE5nekhSSTlVUklXZzVoTXF4?=
 =?utf-8?B?WDQ0d09hMnJPbGZRZlVTWm5ZbG8zL2ExNmRZaVc0SStiWHFBNTM3SnNmUTlp?=
 =?utf-8?B?SjBkSmROVDVHZVlXT3FtbnZhQmIzcFlxSEIrWWsxMmZXb2Zvbkk3UDFIRlA1?=
 =?utf-8?B?WVNJbjJxNTcvWDlud0VOaHlsV01Za0NQdi9YWXlxUGdhbUp3VzE5WjVudXFH?=
 =?utf-8?B?SzdKVnhEYjFQY3hEU0x0N29LaHVkazJVMmI4eHFadkUvcDNOdUZiTkdYcGNO?=
 =?utf-8?B?bzNDTmNaRmNGbnpYQWh5NGpwZUl5blRPRlJqNG1Fa3BielpkS20vQkYrZGhM?=
 =?utf-8?B?eDRWVzkzSWhYVDc5Ymd6OVdDY0paUnpJaEtvSEFlUTlidHRtcFVSRE5GRXZV?=
 =?utf-8?B?MVhHUVZnNHFpNFl0VTVEclplMDJwYkw3ak9MR0hlQ09lbVplYnRRampEazdK?=
 =?utf-8?B?L2RRbjZSc0hmT3Rrd2NlTWFOQzhKdWQ4UkZVWTM2K1dQVCsrSXBteXAyeDd5?=
 =?utf-8?B?VUpaUXNTRmx5L25hNFV3ZXNUajJ2ejdhU2ZOSVZIQjZ3aG90eG54bEJ2anFn?=
 =?utf-8?B?a0ZqWHg2VnlOQ01meDN3TERyVVgyNmlJTnVPSWZJeUgrMEZlQ0VpblgvUEEx?=
 =?utf-8?B?cHVta1BRRXYzSTFFeC9ZZlNCTVBqUmhlKzBpZElVTlV2RFQ4YW43b2V1ek5D?=
 =?utf-8?Q?YY9h1HkEK5eKr1u0zTNLOSRlG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86f769e7-5bb7-4fb1-de5a-08db2722ff32
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 20:05:47.1483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PL6yY7mZCzQ6KA8dEdzEoNdiaN3NhJR9blJDV+flZ7uP8aydqT0AXjO5Obv2iYIKXxcwlMp1Em75nX+R5KYrtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8446
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        T_SPF_PERMERROR,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Add PME_Turn_Off/PME_TO_Ack handshake sequence, and finally
put the PCIe controller into D3 state after the L2/L3 ready
state transition process completion.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

This patch continue an old serial https://lore.kernel.org/lkml/20210407030948.3845-1-Zhiqiang.Hou@nxp.com/

dt-bind document about big-endian patch already accepted.

This patch fixed Krzysztof Wilczyński's comments at v5 version and reposted.


 drivers/pci/controller/dwc/pci-layerscape.c  | 408 ++++++++++++++++++-
 drivers/pci/controller/dwc/pcie-designware.h |   1 +
 2 files changed, 400 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
index ed5fb492fe08..4e7be6b25832 100644
--- a/drivers/pci/controller/dwc/pci-layerscape.c
+++ b/drivers/pci/controller/dwc/pci-layerscape.c
@@ -8,9 +8,11 @@
  * Author: Minghuan Lian <Minghuan.Lian@freescale.com>
  */
 
+#include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
+#include <linux/iopoll.h>
 #include <linux/of_pci.h>
 #include <linux/of_platform.h>
 #include <linux/of_address.h>
@@ -27,12 +29,59 @@
 #define PCIE_ABSERR		0x8d0 /* Bridge Slave Error Response Register */
 #define PCIE_ABSERR_SETTING	0x9401 /* Forward error of non-posted request */
 
+/* PF Message Command Register */
+#define LS_PCIE_PF_MCR		0x2c
+#define PF_MCR_PTOMR		BIT(0)
+#define PF_MCR_EXL2S		BIT(1)
+
+/* LS1021A PEXn PM Write Control Register */
+#define SCFG_PEXPMWRCR(idx)	(0x5c + (idx) * 0x64)
+#define PMXMTTURNOFF		BIT(31)
+#define SCFG_PEXSFTRSTCR	0x190
+#define PEXSR(idx)		BIT(idx)
+
+/* LS1043A PEX PME Control Register */
+#define SCFG_PEXPMECR		0x144
+#define PEXPME(idx)		BIT(31 - (idx) * 4)
+
+/* LS1043A PEX LUT Debug Register */
+#define LS_PCIE_LDBG	0x7fc
+#define LDBG_SR		BIT(30)
+#define LDBG_WE		BIT(31)
+
 #define PCIE_IATU_NUM		6
 
+#define LS_PCIE_IS_L2(v)	\
+	(((v) & PORT_LOGIC_LTSSM_STATE_MASK) == PORT_LOGIC_LTSSM_STATE_L2)
+
+struct ls_pcie;
+
+struct ls_pcie_host_pm_ops {
+	int (*pm_init)(struct ls_pcie *pcie);
+	void (*send_turn_off_message)(struct ls_pcie *pcie);
+	void (*exit_from_l2)(struct ls_pcie *pcie);
+};
+
+struct ls_pcie_drvdata {
+	const u32 pf_off;
+	const u32 lut_off;
+	const struct ls_pcie_host_pm_ops *pm_ops;
+};
+
 struct ls_pcie {
 	struct dw_pcie *pci;
+	const struct ls_pcie_drvdata *drvdata;
+	void __iomem *pf_base;
+	void __iomem *lut_base;
+	bool big_endian;
+	bool ep_presence;
+	bool pm_support;
+	struct regmap *scfg;
+	int index;
 };
 
+#define ls_pcie_lut_readl_addr(addr)	ls_pcie_lut_readl(pcie, addr)
+#define ls_pcie_pf_readl_addr(addr)	ls_pcie_pf_readl(pcie, addr)
 #define to_ls_pcie(x)	dev_get_drvdata((x)->dev)
 
 static bool ls_pcie_is_bridge(struct ls_pcie *pcie)
@@ -73,6 +122,219 @@ static void ls_pcie_fix_error_response(struct ls_pcie *pcie)
 	iowrite32(PCIE_ABSERR_SETTING, pci->dbi_base + PCIE_ABSERR);
 }
 
+static u32 ls_pcie_lut_readl(struct ls_pcie *pcie, u32 off)
+{
+	if (pcie->big_endian)
+		return ioread32be(pcie->lut_base + off);
+
+	return ioread32(pcie->lut_base + off);
+}
+
+static void ls_pcie_lut_writel(struct ls_pcie *pcie, u32 off, u32 val)
+{
+	if (pcie->big_endian)
+		return iowrite32be(val, pcie->lut_base + off);
+
+	return iowrite32(val, pcie->lut_base + off);
+}
+
+static u32 ls_pcie_pf_readl(struct ls_pcie *pcie, u32 off)
+{
+	if (pcie->big_endian)
+		return ioread32be(pcie->pf_base + off);
+
+	return ioread32(pcie->pf_base + off);
+}
+
+static void ls_pcie_pf_writel(struct ls_pcie *pcie, u32 off, u32 val)
+{
+	if (pcie->big_endian)
+		return iowrite32be(val, pcie->pf_base + off);
+
+	return iowrite32(val, pcie->pf_base + off);
+}
+
+static void ls_pcie_send_turnoff_msg(struct ls_pcie *pcie)
+{
+	u32 val;
+	int ret;
+
+	val = ls_pcie_pf_readl(pcie, LS_PCIE_PF_MCR);
+	val |= PF_MCR_PTOMR;
+	ls_pcie_pf_writel(pcie, LS_PCIE_PF_MCR, val);
+
+	ret = readx_poll_timeout(ls_pcie_pf_readl_addr, LS_PCIE_PF_MCR,
+				 val, !(val & PF_MCR_PTOMR), 100, 10000);
+	if (ret)
+		dev_warn(pcie->pci->dev, "poll turn off message timeout\n");
+}
+
+static void ls1021a_pcie_send_turnoff_msg(struct ls_pcie *pcie)
+{
+	u32 val;
+
+	if (!pcie->scfg) {
+		dev_dbg(pcie->pci->dev, "SYSCFG is NULL\n");
+		return;
+	}
+
+	/* Send Turn_off message */
+	regmap_read(pcie->scfg, SCFG_PEXPMWRCR(pcie->index), &val);
+	val |= PMXMTTURNOFF;
+	regmap_write(pcie->scfg, SCFG_PEXPMWRCR(pcie->index), val);
+
+	/*
+	 * Components with an upstream port must respond to
+	 * PME_Turn_Off with PME_TO_Ack but we can't check.
+	 *
+	 * The standard recommends a 1-10ms timeout after which to
+	 * proceed anyway as if acks were received.
+	 */
+	mdelay(10);
+
+	/* Clear Turn_off message */
+	regmap_read(pcie->scfg, SCFG_PEXPMWRCR(pcie->index), &val);
+	val &= ~PMXMTTURNOFF;
+	regmap_write(pcie->scfg, SCFG_PEXPMWRCR(pcie->index), val);
+}
+
+static void ls1043a_pcie_send_turnoff_msg(struct ls_pcie *pcie)
+{
+	u32 val;
+
+	if (!pcie->scfg) {
+		dev_dbg(pcie->pci->dev, "SYSCFG is NULL\n");
+		return;
+	}
+
+	/* Send Turn_off message */
+	regmap_read(pcie->scfg, SCFG_PEXPMECR, &val);
+	val |= PEXPME(pcie->index);
+	regmap_write(pcie->scfg, SCFG_PEXPMECR, val);
+
+	/*
+	 * Components with an upstream port must respond to
+	 * PME_Turn_Off with PME_TO_Ack but we can't check.
+	 *
+	 * The standard recommends a 1-10ms timeout after which to
+	 * proceed anyway as if acks were received.
+	 */
+	mdelay(10);
+
+	/* Clear Turn_off message */
+	regmap_read(pcie->scfg, SCFG_PEXPMECR, &val);
+	val &= ~PEXPME(pcie->index);
+	regmap_write(pcie->scfg, SCFG_PEXPMECR, val);
+}
+
+static void ls_pcie_exit_from_l2(struct ls_pcie *pcie)
+{
+	u32 val;
+	int ret;
+
+	val = ls_pcie_pf_readl(pcie, LS_PCIE_PF_MCR);
+	val |= PF_MCR_EXL2S;
+	ls_pcie_pf_writel(pcie, LS_PCIE_PF_MCR, val);
+
+	ret = readx_poll_timeout(ls_pcie_pf_readl_addr, LS_PCIE_PF_MCR,
+				 val, !(val & PF_MCR_EXL2S), 100, 10000);
+	if (ret)
+		dev_warn(pcie->pci->dev, "poll exit L2 state timeout\n");
+}
+
+static void ls_pcie_retrain_link(struct ls_pcie *pcie)
+{
+	struct dw_pcie *pci = pcie->pci;
+	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	u32 val;
+
+	val = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL);
+	val |= PCI_EXP_LNKCTL_RL;
+	dw_pcie_writew_dbi(pci, offset + PCI_EXP_LNKCTL, val);
+}
+
+static void ls1021a_pcie_exit_from_l2(struct ls_pcie *pcie)
+{
+	u32 val;
+
+	regmap_read(pcie->scfg, SCFG_PEXSFTRSTCR, &val);
+	val |= PEXSR(pcie->index);
+	regmap_write(pcie->scfg, SCFG_PEXSFTRSTCR, val);
+
+	regmap_read(pcie->scfg, SCFG_PEXSFTRSTCR, &val);
+	val &= ~PEXSR(pcie->index);
+	regmap_write(pcie->scfg, SCFG_PEXSFTRSTCR, val);
+
+	ls_pcie_retrain_link(pcie);
+}
+
+static void ls1043a_pcie_exit_from_l2(struct ls_pcie *pcie)
+{
+	u32 val;
+
+	val = ls_pcie_lut_readl(pcie, LS_PCIE_LDBG);
+	val |= LDBG_WE;
+	ls_pcie_lut_writel(pcie, LS_PCIE_LDBG, val);
+
+	val = ls_pcie_lut_readl(pcie, LS_PCIE_LDBG);
+	val |= LDBG_SR;
+	ls_pcie_lut_writel(pcie, LS_PCIE_LDBG, val);
+
+	val = ls_pcie_lut_readl(pcie, LS_PCIE_LDBG);
+	val &= ~LDBG_SR;
+	ls_pcie_lut_writel(pcie, LS_PCIE_LDBG, val);
+
+	val = ls_pcie_lut_readl(pcie, LS_PCIE_LDBG);
+	val &= ~LDBG_WE;
+	ls_pcie_lut_writel(pcie, LS_PCIE_LDBG, val);
+
+	ls_pcie_retrain_link(pcie);
+}
+
+static int ls1021a_pcie_pm_init(struct ls_pcie *pcie)
+{
+	struct device *dev = pcie->pci->dev;
+	u32 index[2];
+	int ret;
+
+	pcie->scfg = syscon_regmap_lookup_by_phandle(dev->of_node,
+						     "fsl,pcie-scfg");
+	if (IS_ERR(pcie->scfg)) {
+		ret = PTR_ERR(pcie->scfg);
+		dev_err(dev, "No syscfg phandle specified\n");
+		goto error;
+	}
+
+	ret = of_property_read_u32_array(dev->of_node, "fsl,pcie-scfg",
+					 index, 2);
+	if (ret)
+		goto error;
+
+	pcie->index = index[1];
+
+	return 0;
+error:
+	pcie->scfg = NULL;
+	return ret;
+}
+
+static int ls_pcie_pm_init(struct ls_pcie *pcie)
+{
+	return 0;
+}
+
+static void ls_pcie_set_dstate(struct ls_pcie *pcie, u32 dstate)
+{
+	struct dw_pcie *pci = pcie->pci;
+	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_PM);
+	u32 val;
+
+	val = dw_pcie_readw_dbi(pci, offset + PCI_PM_CTRL);
+	val &= ~PCI_PM_CTRL_STATE_MASK;
+	val |= dstate;
+	dw_pcie_writew_dbi(pci, offset + PCI_PM_CTRL, val);
+}
+
 static int ls_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -86,23 +348,65 @@ static int ls_pcie_host_init(struct dw_pcie_rp *pp)
 
 	ls_pcie_drop_msg_tlp(pcie);
 
+	if (dw_pcie_link_up(pci)) {
+		dev_dbg(pci->dev, "Endpoint is present\n");
+		pcie->ep_presence = true;
+	}
+
+	if (pcie->drvdata->pm_ops && pcie->drvdata->pm_ops->pm_init &&
+	    !pcie->drvdata->pm_ops->pm_init(pcie))
+		pcie->pm_support = true;
+
 	return 0;
 }
 
+static struct ls_pcie_host_pm_ops ls1021a_pcie_host_pm_ops = {
+	.pm_init = &ls1021a_pcie_pm_init,
+	.send_turn_off_message = &ls1021a_pcie_send_turnoff_msg,
+	.exit_from_l2 = &ls1021a_pcie_exit_from_l2,
+};
+
+static struct ls_pcie_host_pm_ops ls1043a_pcie_host_pm_ops = {
+	.pm_init = &ls1021a_pcie_pm_init,
+	.send_turn_off_message = &ls1043a_pcie_send_turnoff_msg,
+	.exit_from_l2 = &ls1043a_pcie_exit_from_l2,
+};
+
+static struct ls_pcie_host_pm_ops ls_pcie_host_pm_ops = {
+	.pm_init = &ls_pcie_pm_init,
+	.send_turn_off_message = &ls_pcie_send_turnoff_msg,
+	.exit_from_l2 = &ls_pcie_exit_from_l2,
+};
+
 static const struct dw_pcie_host_ops ls_pcie_host_ops = {
 	.host_init = ls_pcie_host_init,
 };
 
+static const struct ls_pcie_drvdata ls1021a_drvdata = {
+	.pm_ops = &ls1021a_pcie_host_pm_ops,
+};
+
+static const struct ls_pcie_drvdata ls1043a_drvdata = {
+	.lut_off = 0x10000,
+	.pm_ops = &ls1043a_pcie_host_pm_ops,
+};
+
+static const struct ls_pcie_drvdata layerscape_drvdata = {
+	.lut_off = 0x80000,
+	.pf_off = 0xc0000,
+	.pm_ops = &ls_pcie_host_pm_ops,
+};
+
 static const struct of_device_id ls_pcie_of_match[] = {
-	{ .compatible = "fsl,ls1012a-pcie", },
-	{ .compatible = "fsl,ls1021a-pcie", },
-	{ .compatible = "fsl,ls1028a-pcie", },
-	{ .compatible = "fsl,ls1043a-pcie", },
-	{ .compatible = "fsl,ls1046a-pcie", },
-	{ .compatible = "fsl,ls2080a-pcie", },
-	{ .compatible = "fsl,ls2085a-pcie", },
-	{ .compatible = "fsl,ls2088a-pcie", },
-	{ .compatible = "fsl,ls1088a-pcie", },
+	{ .compatible = "fsl,ls1012a-pcie", .data = &layerscape_drvdata },
+	{ .compatible = "fsl,ls1021a-pcie", .data = &ls1021a_drvdata },
+	{ .compatible = "fsl,ls1028a-pcie", .data = &layerscape_drvdata },
+	{ .compatible = "fsl,ls1043a-pcie", .data = &ls1043a_drvdata },
+	{ .compatible = "fsl,ls1046a-pcie", .data = &layerscape_drvdata },
+	{ .compatible = "fsl,ls2080a-pcie", .data = &layerscape_drvdata },
+	{ .compatible = "fsl,ls2085a-pcie", .data = &layerscape_drvdata },
+	{ .compatible = "fsl,ls2088a-pcie", .data = &layerscape_drvdata },
+	{ .compatible = "fsl,ls1088a-pcie", .data = &layerscape_drvdata },
 	{ },
 };
 
@@ -121,6 +425,8 @@ static int ls_pcie_probe(struct platform_device *pdev)
 	if (!pci)
 		return -ENOMEM;
 
+	pcie->drvdata = of_device_get_match_data(dev);
+
 	pci->dev = dev;
 	pci->pp.ops = &ls_pcie_host_ops;
 
@@ -131,6 +437,14 @@ static int ls_pcie_probe(struct platform_device *pdev)
 	if (IS_ERR(pci->dbi_base))
 		return PTR_ERR(pci->dbi_base);
 
+	pcie->big_endian = of_property_read_bool(dev->of_node, "big-endian");
+
+	if (pcie->drvdata->lut_off)
+		pcie->lut_base = pci->dbi_base + pcie->drvdata->lut_off;
+
+	if (pcie->drvdata->pf_off)
+		pcie->pf_base = pci->dbi_base + pcie->drvdata->pf_off;
+
 	if (!ls_pcie_is_bridge(pcie))
 		return -ENODEV;
 
@@ -139,12 +453,88 @@ static int ls_pcie_probe(struct platform_device *pdev)
 	return dw_pcie_host_init(&pci->pp);
 }
 
+static bool ls_pcie_pm_check(struct ls_pcie *pcie)
+{
+	if (!pcie->ep_presence) {
+		dev_dbg(pcie->pci->dev, "Endpoint isn't present\n");
+		return false;
+	}
+
+	if (!pcie->pm_support)
+		return false;
+
+	return true;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int ls_pcie_suspend_noirq(struct device *dev)
+{
+	struct ls_pcie *pcie = dev_get_drvdata(dev);
+	struct dw_pcie *pci = pcie->pci;
+	u32 val;
+	int ret;
+
+	if (!ls_pcie_pm_check(pcie))
+		return 0;
+
+	pcie->drvdata->pm_ops->send_turn_off_message(pcie);
+
+	/* 10ms timeout to check L2 ready */
+	ret = readl_poll_timeout(pci->dbi_base + PCIE_PORT_DEBUG0,
+				 val, LS_PCIE_IS_L2(val), 100, 10000);
+	if (ret) {
+		dev_err(dev, "PCIe link enter L2 timeout! ltssm = 0x%x\n", val);
+		return ret;
+	}
+
+	ls_pcie_set_dstate(pcie, 0x3);
+
+	return 0;
+}
+
+static int ls_pcie_resume_noirq(struct device *dev)
+{
+	struct ls_pcie *pcie = dev_get_drvdata(dev);
+	struct dw_pcie *pci = pcie->pci;
+	int ret;
+
+	if (!ls_pcie_pm_check(pcie))
+		return 0;
+
+	ls_pcie_set_dstate(pcie, 0x0);
+
+	pcie->drvdata->pm_ops->exit_from_l2(pcie);
+
+	ret = ls_pcie_host_init(&pci->pp);
+	if (ret) {
+		dev_err(dev, "PCIe host init failed! ret = 0x%x\n", ret);
+		return ret;
+	}
+
+	dw_pcie_setup_rc(&pci->pp);
+
+	ret = dw_pcie_wait_for_link(pci);
+	if (ret) {
+		dev_err(dev, "Wait link up timeout! ret = 0x%x\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+#endif /* CONFIG_PM_SLEEP */
+
+static const struct dev_pm_ops ls_pcie_pm_ops = {
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(ls_pcie_suspend_noirq,
+				      ls_pcie_resume_noirq)
+};
+
 static struct platform_driver ls_pcie_driver = {
 	.probe = ls_pcie_probe,
 	.driver = {
 		.name = "layerscape-pcie",
 		.of_match_table = ls_pcie_of_match,
 		.suppress_bind_attrs = true,
+		.pm = &ls_pcie_pm_ops,
 	},
 };
 builtin_platform_driver(ls_pcie_driver);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 79713ce075cc..7de8409e2433 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -94,6 +94,7 @@
 #define PCIE_PORT_DEBUG0		0x728
 #define PORT_LOGIC_LTSSM_STATE_MASK	0x1f
 #define PORT_LOGIC_LTSSM_STATE_L0	0x11
+#define PORT_LOGIC_LTSSM_STATE_L2	0x15
 #define PCIE_PORT_DEBUG1		0x72C
 #define PCIE_PORT_DEBUG1_LINK_UP		BIT(4)
 #define PCIE_PORT_DEBUG1_LINK_IN_TRAINING	BIT(29)
-- 
2.34.1

