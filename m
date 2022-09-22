Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250845E6833
	for <lists+linux-pci@lfdr.de>; Thu, 22 Sep 2022 18:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbiIVQOT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Sep 2022 12:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232039AbiIVQOQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Sep 2022 12:14:16 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2044.outbound.protection.outlook.com [40.107.20.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2D8102504;
        Thu, 22 Sep 2022 09:13:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gmRzNip3FVeQUjbtPyyfkWjYii3bMBcNrX9IMfT4E43TT0EnnJ0PfLXdL5IFBm01nVO2TLBc+3XuvScLh5A5/44tGnzPk1e4FNgUYj1oinqLf8ZibYU47Cee+DJX/oYkJIR36YAI1oySD3XrNmk4JVxDT3hNd8zWSP6PzbFjLt5JcTQLK3Kxn2ZZ6PRw6blUVIsuFbvW0WQcbVcnvu0U9gqs4uAmBhMIHDjb8MNAbTBQR1OmJ9tyPyEF+XF+EzpFNwheu2CkPKP7mSp49HrZmtEeWhHFga/E847jDCL0pZLnC+ezcP38G5tbtXeToltRoMnJETNTMaUZmwu3qYjguA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sv21a6BMPaapi/PwjWIE7c4OBzC9tkTbhunXpI4m54w=;
 b=OuFdPjIJZJkZlLH5rvQphUGF/PJHcq9ylGYhLAOJF6fseLdV6nWT2TFZ4mIg6WoRxPJaD8hpgy37nqWSvIVvx9evhRKoIezm1XFZmtYyW9QioHx7aZ0d4KJrypE+SMw+g3VcUKKScVg5l00n1Nnw4RvIANdXHVM9EXER4yavoQvQZ8wNZc0+9n5QY0arXo206UNyDhUNFY2wgf0wgutOQdLHVmci5sNbCcj7T0kpzxlo59hJSoE121zmlYDwNeR5LI2Kv5C7KMiKFnDIQRG7GAUUn9zhbRvdVnl3oQ7PuTo1i9MSMwSYQfg4gB+7Etz1JioJOvxYMnk59XNY8LoNKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sv21a6BMPaapi/PwjWIE7c4OBzC9tkTbhunXpI4m54w=;
 b=IhZ71y8y9uDH41kHF/6BDDADKfO9csZg9CNA9xN2/JX0mZe/RCu+YQvRmx7UwgTG60O4ie2QzikKwwirEPRghRpprH2uEBIBhq6L9O6xwoct4HBU28dGRTqEwiQcv5UHNlWmAP0IH2XqCW0PXjvt0HT4eDoFXRggAqfStXaBxrs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8789.eurprd04.prod.outlook.com (2603:10a6:10:2e0::11)
 by AS8PR04MB7541.eurprd04.prod.outlook.com (2603:10a6:20b:29a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17; Thu, 22 Sep
 2022 16:13:53 +0000
Received: from DU2PR04MB8789.eurprd04.prod.outlook.com
 ([fe80::5c5d:d0e4:cd13:6428]) by DU2PR04MB8789.eurprd04.prod.outlook.com
 ([fe80::5c5d:d0e4:cd13:6428%5]) with mapi id 15.20.5654.018; Thu, 22 Sep 2022
 16:13:53 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     maz@kernel.org, tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kw@linux.com, bhelgaas@google.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        peng.fan@nxp.com, aisheng.dong@nxp.com, jdmason@kudzu.us,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        kishon@ti.com, lorenzo.pieralisi@arm.com, ntb@lists.linux.dev,
        lznuaa@gmail.com, imx@lists.linux.dev,
        manivannan.sadhasivam@linaro.org
Subject: [PATCH v12 5/6] PCI: endpoint: pci-epf-vntb: Clean up
Date:   Thu, 22 Sep 2022 11:12:45 -0500
Message-Id: <20220922161246.20586-6-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220922161246.20586-1-Frank.Li@nxp.com>
References: <20220922161246.20586-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0016.namprd05.prod.outlook.com
 (2603:10b6:a03:254::21) To DU2PR04MB8789.eurprd04.prod.outlook.com
 (2603:10a6:10:2e0::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8789:EE_|AS8PR04MB7541:EE_
X-MS-Office365-Filtering-Correlation-Id: e0cfb95b-8938-4f67-55b2-08da9cb57183
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 84CXFU+rM/U87wCJCmuT03LtoUrsxJeTjgW4pde2toDACXQKekJWGGaRCR5vc16NCF1BifyzpluJHrNnHlXwM/EGl8h52Nmx8Y5mcOH6UlsY89rcroKKAyzNfXUMt3aAmPIpl+jYXfU9v+C4GxR0Ae8JYqp+K/EEDQ3th9KJ3x2WLm+E12IxX5UqNBkOhsPqNI53b4+dfVolOJQjTWsDDSvLB5HizMNOmdLMX0iGUol7PC30LamuIj+7wY3n6+TQoM4qhQkhHLQllF8G2/LDs4nMKJAUWFck1eVQjOAX5nF5KCk9YKboFAiko3egkfdJBKihipUBUhxRQdePx7BTey6wctIE8YAY8PwC4SPvn2cuwq4r7CEazpadA6uT12bu2+LAM4NlrZUEm4LxhMQALEf4aty8qhLxIP7rTlG/o0bvBAhFI0J+w9yVOr1rzpfKXttUrSgDoMcQD/G+UjUc+16dgAwQznHORt7km1sTThqO1xxzNmhoZfIDJkFyNrM+ZX4NF0Y2ZQvFRj/ra/gKBXmVp7zTuNeM6qtEB1yrdY9EKs5QobrF7puVo7hPHsxcsD3KwEX/xmqBgoNsAXHFV+6khjNGwNN1xSiKlxmf9a0mYMXt9RkxFUT/5FXgV6ScrhatPBrB2STYt9AUKMv9hsagN8umwrrgCIGwhK0cJtNyGjS4SEEU35P7kg7bezrQdZy4u3krW1YbsiCJeJ3seJugo9/vlj1+3qG38NScTa8noLCgXfLUgMD+QHuR9zENqfUiOB+21sD4VYQlj0+lCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8789.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(396003)(376002)(346002)(136003)(451199015)(83380400001)(1076003)(2616005)(6512007)(186003)(38100700002)(52116002)(66556008)(30864003)(38350700002)(66476007)(8936002)(5660300002)(41300700001)(478600001)(2906002)(6506007)(6486002)(26005)(7416002)(6666004)(66946007)(4326008)(8676002)(36756003)(316002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zGuiZPGq6+JOINfIgooTbOqwwuRjkx8Uc9YPSPdJBmywHymuduyCbazc5gmr?=
 =?us-ascii?Q?+IkFmWIaqbsyXwFU6oi4xr2ORdNTT2rCki1hXu0wEn76JxsFJrum92qFVUth?=
 =?us-ascii?Q?p+1IYXNArwwgG/3aFmNUAAPcCA2+N/c3sM08S54z4GQvvcTdKZLOgG704pB1?=
 =?us-ascii?Q?EddO7biLUtFosujRb/P6Zn35F88l0ifNdxGF4YZ9Uqhul5eJk6Mcg/14GVyw?=
 =?us-ascii?Q?UlTZwuOemGz5KkdOCBICQxuSPiU7/8NxOA8bsRCOGatQOn2wvbBbexLKLPbm?=
 =?us-ascii?Q?fmzhVJPUGVS90hb5U6r/X40zHWWPNC12/BWW1/s6R/UsEaunhSFlQ+ccbOHr?=
 =?us-ascii?Q?iMYqvVj4N71PH/Q/wNX95BHq8bkCxKybK0ileAIic7djTG2YbSlWHZNHTptU?=
 =?us-ascii?Q?C1xj33R1abS6Zz0WCEnHmwOK44g0BE5VMda2jrAgNtGbgchR1rF8Oem0TwtE?=
 =?us-ascii?Q?tXRPMH/3sA1hRjZzg7FLl8jviRG0152hEWZuqExawT1PBB6z3BlJ7wcfHlY4?=
 =?us-ascii?Q?P1LYEEcaiRB0GxEAokf0TcggRfuEIZpa2hC0A4Tlyc5cS9GN2dMXIioEDUe5?=
 =?us-ascii?Q?wiq7CkA2fTFQ3P+NCRmNXHRalHPIYorShf6+Phg6q7eGVWTpUqV92tXk+kKW?=
 =?us-ascii?Q?TbK36qmbD/CGszRnVpOxzzOxB8Xtf4bVyAiwRG5wRXYMC8sRtSTt1LpfjcnB?=
 =?us-ascii?Q?6/bpv/VfgNx8iUQF1zKMuZ3Vf08ajAtPsfbBBhIOwJPOc7eJJeAgce1bD+xU?=
 =?us-ascii?Q?oz8huxf7rT9qio7YOMuGVvQQw0KY+i5yv7ebpLsCuAzGctyWOF5MYS4lgxCr?=
 =?us-ascii?Q?+5LFpjPwz7tLuhF218rIUu4dfmeT23ZsFK2ZTf/zY8BokdwpuN6ldUyoXQkP?=
 =?us-ascii?Q?hOKVKyJ5x7k+z2JW6DnZ1FskTPKF0QLl3/TReoXyUm/6N7Qntvs3LSZQYhV8?=
 =?us-ascii?Q?6WB7uR4FR1k+nySvn9VYZCO3YeXdJg8ZGMpytX1qV029PMcdQYBntUBIHOZE?=
 =?us-ascii?Q?1Qa7krYhD1nTNXeR8y5HqLGP2Phohb18RVVL4ZqETWMcwXWuK9nQekhXs+34?=
 =?us-ascii?Q?Dki4wCx8NV3oVaCnl8f3kNUTJRjm/SRDnCJWxrqmZEX8/ax/fDyIzqNPJy1D?=
 =?us-ascii?Q?o2GCLHb80o/iQ+aYKzPGYLT1mmIjwIDTCgFMgvT0QOMMBfv0R2LAlzq0xDWt?=
 =?us-ascii?Q?xAYy528/LNoAYDOxwe0bFSJMqhqCmdLPRTS5d4rTOAj756Qf9qxFVWmKvmOU?=
 =?us-ascii?Q?AkU2/1mxprpoiLGNtj18VvExDxhhUbDF3Y1BnPIUcmlf+C8wNnk9tPoUnkAc?=
 =?us-ascii?Q?cFae8yIzdTm3Zwn99j1erFzVgMPh/N3jsJSRte5z6+KazIE4wJuTK2CXpXvG?=
 =?us-ascii?Q?Ur+9WLERwGUspRo3F+n8iStE7oxkUuSHoZJxgMvrBgBB4bNtmuu6NFLSMh/P?=
 =?us-ascii?Q?E+3dOZIwRQuqJ4UIyA6LThCG2tNW3RB7N36QsMxQc0Mczj7Tts4CpFATUL6H?=
 =?us-ascii?Q?IWYIIACeb6bNv6Z+iv/Ep4NZbrKBg3g+WqdAU/A6YYXKPNvqoibZCzBV8QJy?=
 =?us-ascii?Q?nYvBxykwpeP61lAWoyVNLn/DP46rlfROruExIx3Z?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0cfb95b-8938-4f67-55b2-08da9cb57183
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8789.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 16:13:53.6774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WnmraiazQTCYXrm78uGgqsYCktxk7fIS1UioEJAo22KM9JNUpKYq+tNAI2hr2Hm+QxJXamDxOqok+dFddNeklw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7541
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove unused field: epf_db_phy.
Remove __iomem before epf_db.
Change epf_db to u32* from void *
Remove duplicate check if (readl(ntb->epf_db + i * 4)).
Using sizeof(u32) instead of number 4 at all place.

Clean up sparse build warning:
  Using  epf_db[i] instead of readl() because epf_db is located in local
  memory and allocated by dma_alloc_coherent(). Sparse build warning when
  there are not __iomem at readl().
  Added __iomem force type convert in vntb_epf_peer_spad_read\write() and
  vntb_epf_spad_read\write(). This require strong order at read and write.

Replace pci_epc_mem_free_addr() with pci_epf_free_space() at error handle
path to match pci_epf_alloc_space().

Cleanup warning found by scripts/kernel-doc
Fix indentation of the struct epf_ntb_ctrl
Consolidate term
  host, host1 to HOST
  vhost, vHost, Vhost, VHOST2 to VHOST

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 157 ++++++++++--------
 1 file changed, 90 insertions(+), 67 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 1466dd1904175..acea753af29ed 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -11,7 +11,7 @@
  * Author: Kishon Vijay Abraham I <kishon@ti.com>
  */
 
-/**
+/*
  * +------------+         +---------------------------------------+
  * |            |         |                                       |
  * +------------+         |                        +--------------+
@@ -99,20 +99,20 @@ enum epf_ntb_bar {
  *       NTB Driver               NTB Driver
  */
 struct epf_ntb_ctrl {
-	u32     command;
-	u32     argument;
-	u16     command_status;
-	u16     link_status;
-	u32     topology;
-	u64     addr;
-	u64     size;
-	u32     num_mws;
-	u32	reserved;
-	u32     spad_offset;
-	u32     spad_count;
-	u32	db_entry_size;
-	u32     db_data[MAX_DB_COUNT];
-	u32     db_offset[MAX_DB_COUNT];
+	u32 command;
+	u32 argument;
+	u16 command_status;
+	u16 link_status;
+	u32 topology;
+	u64 addr;
+	u64 size;
+	u32 num_mws;
+	u32 reserved;
+	u32 spad_offset;
+	u32 spad_count;
+	u32 db_entry_size;
+	u32 db_data[MAX_DB_COUNT];
+	u32 db_offset[MAX_DB_COUNT];
 } __packed;
 
 struct epf_ntb {
@@ -136,8 +136,7 @@ struct epf_ntb {
 
 	struct epf_ntb_ctrl *reg;
 
-	phys_addr_t epf_db_phy;
-	void __iomem *epf_db;
+	u32 *epf_db;
 
 	phys_addr_t vpci_mw_phy[MAX_MW];
 	void __iomem *vpci_mw_addr[MAX_MW];
@@ -156,12 +155,14 @@ static struct pci_epf_header epf_ntb_header = {
 };
 
 /**
- * epf_ntb_link_up() - Raise link_up interrupt to Virtual Host
+ * epf_ntb_link_up() - Raise link_up interrupt to Virtual Host (VHOST)
  * @ntb: NTB device that facilitates communication between HOST and VHOST
  * @link_up: true or false indicating Link is UP or Down
  *
  * Once NTB function in HOST invoke ntb_link_enable(),
- * this NTB function driver will trigger a link event to vhost.
+ * this NTB function driver will trigger a link event to VHOST.
+ *
+ * Returns: Zero for success, or an error code in case of failure
  */
 static int epf_ntb_link_up(struct epf_ntb *ntb, bool link_up)
 {
@@ -175,9 +176,9 @@ static int epf_ntb_link_up(struct epf_ntb *ntb, bool link_up)
 }
 
 /**
- * epf_ntb_configure_mw() - Configure the Outbound Address Space for vhost
- *   to access the memory window of host
- * @ntb: NTB device that facilitates communication between host and vhost
+ * epf_ntb_configure_mw() - Configure the Outbound Address Space for VHOST
+ *   to access the memory window of HOST
+ * @ntb: NTB device that facilitates communication between HOST and VHOST
  * @mw: Index of the memory window (either 0, 1, 2 or 3)
  *
  *                          EP Outbound Window
@@ -194,7 +195,9 @@ static int epf_ntb_link_up(struct epf_ntb *ntb, bool link_up)
  * |        |              |           |
  * |        |              |           |
  * +--------+              +-----------+
- *  VHost                   PCI EP
+ *  VHOST                   PCI EP
+ *
+ * Returns: Zero for success, or an error code in case of failure
  */
 static int epf_ntb_configure_mw(struct epf_ntb *ntb, u32 mw)
 {
@@ -219,7 +222,7 @@ static int epf_ntb_configure_mw(struct epf_ntb *ntb, u32 mw)
 
 /**
  * epf_ntb_teardown_mw() - Teardown the configured OB ATU
- * @ntb: NTB device that facilitates communication between HOST and vHOST
+ * @ntb: NTB device that facilitates communication between HOST and VHOST
  * @mw: Index of the memory window (either 0, 1, 2 or 3)
  *
  * Teardown the configured OB ATU configured in epf_ntb_configure_mw() using
@@ -234,12 +237,12 @@ static void epf_ntb_teardown_mw(struct epf_ntb *ntb, u32 mw)
 }
 
 /**
- * epf_ntb_cmd_handler() - Handle commands provided by the NTB Host
+ * epf_ntb_cmd_handler() - Handle commands provided by the NTB HOST
  * @work: work_struct for the epf_ntb_epc
  *
  * Workqueue function that gets invoked for the two epf_ntb_epc
  * periodically (once every 5ms) to see if it has received any commands
- * from NTB host. The host can send commands to configure doorbell or
+ * from NTB HOST. The HOST can send commands to configure doorbell or
  * configure memory window or to update link status.
  */
 static void epf_ntb_cmd_handler(struct work_struct *work)
@@ -254,12 +257,9 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 	ntb = container_of(work, struct epf_ntb, cmd_handler.work);
 
 	for (i = 1; i < ntb->db_count; i++) {
-		if (readl(ntb->epf_db + i * 4)) {
-			if (readl(ntb->epf_db + i * 4))
-				ntb->db |= 1 << (i - 1);
-
+		if (ntb->epf_db[i]) {
 			ntb_db_event(&ntb->ntb, i);
-			writel(0, ntb->epf_db + i * 4);
+			ntb->epf_db[i] = 0;
 		}
 	}
 
@@ -321,8 +321,8 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 
 /**
  * epf_ntb_config_sspad_bar_clear() - Clear Config + Self scratchpad BAR
- * @ntb_epc: EPC associated with one of the HOST which holds peer's outbound
- *	     address.
+ * @ntb: EPC associated with one of the HOST which holds peer's outbound
+ *	 address.
  *
  * Clear BAR0 of EP CONTROLLER 1 which contains the HOST1's config and
  * self scratchpad region (removes inbound ATU configuration). While BAR0 is
@@ -331,8 +331,10 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
  * used for self scratchpad from epf_ntb_bar[BAR_CONFIG].
  *
  * Please note the self scratchpad region and config region is combined to
- * a single region and mapped using the same BAR. Also note HOST2's peer
- * scratchpad is HOST1's self scratchpad.
+ * a single region and mapped using the same BAR. Also note VHOST's peer
+ * scratchpad is HOST's self scratchpad.
+ *
+ * Returns: void
  */
 static void epf_ntb_config_sspad_bar_clear(struct epf_ntb *ntb)
 {
@@ -347,13 +349,15 @@ static void epf_ntb_config_sspad_bar_clear(struct epf_ntb *ntb)
 
 /**
  * epf_ntb_config_sspad_bar_set() - Set Config + Self scratchpad BAR
- * @ntb: NTB device that facilitates communication between HOST and vHOST
+ * @ntb: NTB device that facilitates communication between HOST and VHOST
  *
- * Map BAR0 of EP CONTROLLER 1 which contains the HOST1's config and
+ * Map BAR0 of EP CONTROLLER which contains the VHOST's config and
  * self scratchpad region.
  *
  * Please note the self scratchpad region and config region is combined to
  * a single region and mapped using the same BAR.
+ *
+ * Returns: Zero for success, or an error code in case of failure
  */
 static int epf_ntb_config_sspad_bar_set(struct epf_ntb *ntb)
 {
@@ -380,7 +384,7 @@ static int epf_ntb_config_sspad_bar_set(struct epf_ntb *ntb)
 /**
  * epf_ntb_config_spad_bar_free() - Free the physical memory associated with
  *   config + scratchpad region
- * @ntb: NTB device that facilitates communication between HOST and vHOST
+ * @ntb: NTB device that facilitates communication between HOST and VHOST
  */
 static void epf_ntb_config_spad_bar_free(struct epf_ntb *ntb)
 {
@@ -393,11 +397,13 @@ static void epf_ntb_config_spad_bar_free(struct epf_ntb *ntb)
 /**
  * epf_ntb_config_spad_bar_alloc() - Allocate memory for config + scratchpad
  *   region
- * @ntb: NTB device that facilitates communication between HOST1 and HOST2
+ * @ntb: NTB device that facilitates communication between HOST and VHOST
  *
  * Allocate the Local Memory mentioned in the above diagram. The size of
  * CONFIG REGION is sizeof(struct epf_ntb_ctrl) and size of SCRATCHPAD REGION
  * is obtained from "spad-count" configfs entry.
+ *
+ * Returns: Zero for success, or an error code in case of failure
  */
 static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 {
@@ -424,7 +430,7 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 	spad_count = ntb->spad_count;
 
 	ctrl_size = sizeof(struct epf_ntb_ctrl);
-	spad_size = 2 * spad_count * 4;
+	spad_size = 2 * spad_count * sizeof(u32);
 
 	if (!align) {
 		ctrl_size = roundup_pow_of_two(ctrl_size);
@@ -454,7 +460,7 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 	ctrl->num_mws = ntb->num_mws;
 	ntb->spad_size = spad_size;
 
-	ctrl->db_entry_size = 4;
+	ctrl->db_entry_size = sizeof(u32);
 
 	for (i = 0; i < ntb->db_count; i++) {
 		ntb->reg->db_data[i] = 1 + i;
@@ -465,11 +471,13 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 }
 
 /**
- * epf_ntb_configure_interrupt() - Configure MSI/MSI-X capaiblity
- * @ntb: NTB device that facilitates communication between HOST and vHOST
+ * epf_ntb_configure_interrupt() - Configure MSI/MSI-X capability
+ * @ntb: NTB device that facilitates communication between HOST and VHOST
  *
  * Configure MSI/MSI-X capability for each interface with number of
  * interrupts equal to "db_count" configfs entry.
+ *
+ * Returns: Zero for success, or an error code in case of failure
  */
 static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
 {
@@ -511,18 +519,22 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
 
 /**
  * epf_ntb_db_bar_init() - Configure Doorbell window BARs
- * @ntb: NTB device that facilitates communication between HOST and vHOST
+ * @ntb: NTB device that facilitates communication between HOST and VHOST
+ *
+ * Returns: Zero for success, or an error code in case of failure
  */
 static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
 {
 	const struct pci_epc_features *epc_features;
-	u32 align;
 	struct device *dev = &ntb->epf->dev;
-	int ret;
 	struct pci_epf_bar *epf_bar;
-	void __iomem *mw_addr;
 	enum pci_barno barno;
-	size_t size = 4 * ntb->db_count;
+	void *mw_addr;
+	size_t size;
+	u32 align;
+	int ret;
+
+	size = sizeof(u32) * ntb->db_count;
 
 	epc_features = pci_epc_get_features(ntb->epf->epc,
 					    ntb->epf->func_no,
@@ -557,14 +569,14 @@ static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
 	return ret;
 
 err_alloc_peer_mem:
-	pci_epc_mem_free_addr(ntb->epf->epc, epf_bar->phys_addr, mw_addr, epf_bar->size);
+	pci_epf_free_space(ntb->epf, mw_addr, barno, 0);
 	return -1;
 }
 
 /**
  * epf_ntb_db_bar_clear() - Clear doorbell BAR and free memory
  *   allocated in peer's outbound address space
- * @ntb: NTB device that facilitates communication between HOST and vHOST
+ * @ntb: NTB device that facilitates communication between HOST and VHOST
  */
 static void epf_ntb_db_bar_clear(struct epf_ntb *ntb)
 {
@@ -580,8 +592,9 @@ static void epf_ntb_db_bar_clear(struct epf_ntb *ntb)
 
 /**
  * epf_ntb_mw_bar_init() - Configure Memory window BARs
- * @ntb: NTB device that facilitates communication between HOST and vHOST
+ * @ntb: NTB device that facilitates communication between HOST and VHOST
  *
+ * Returns: Zero for success, or an error code in case of failure
  */
 static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
 {
@@ -629,7 +642,7 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
 
 /**
  * epf_ntb_mw_bar_clear() - Clear Memory window BARs
- * @ntb: NTB device that facilitates communication between HOST and vHOST
+ * @ntb: NTB device that facilitates communication between HOST and VHOST
  */
 static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb)
 {
@@ -652,7 +665,7 @@ static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb)
 
 /**
  * epf_ntb_epc_destroy() - Cleanup NTB EPC interface
- * @ntb: NTB device that facilitates communication between HOST and vHOST
+ * @ntb: NTB device that facilitates communication between HOST and VHOST
  *
  * Wrapper for epf_ntb_epc_destroy_interface() to cleanup all the NTB interfaces
  */
@@ -665,7 +678,9 @@ static void epf_ntb_epc_destroy(struct epf_ntb *ntb)
 /**
  * epf_ntb_init_epc_bar() - Identify BARs to be used for each of the NTB
  * constructs (scratchpad region, doorbell, memorywindow)
- * @ntb: NTB device that facilitates communication between HOST and vHOST
+ * @ntb: NTB device that facilitates communication between HOST and VHOST
+ *
+ * Returns: Zero for success, or an error code in case of failure
  */
 static int epf_ntb_init_epc_bar(struct epf_ntb *ntb)
 {
@@ -706,11 +721,13 @@ static int epf_ntb_init_epc_bar(struct epf_ntb *ntb)
 
 /**
  * epf_ntb_epc_init() - Initialize NTB interface
- * @ntb: NTB device that facilitates communication between HOST and vHOST2
+ * @ntb: NTB device that facilitates communication between HOST and VHOST
  *
  * Wrapper to initialize a particular EPC interface and start the workqueue
- * to check for commands from host. This function will write to the
+ * to check for commands from HOST. This function will write to the
  * EP controller HW for configuring it.
+ *
+ * Returns: Zero for success, or an error code in case of failure
  */
 static int epf_ntb_epc_init(struct epf_ntb *ntb)
 {
@@ -777,7 +794,7 @@ static int epf_ntb_epc_init(struct epf_ntb *ntb)
 
 /**
  * epf_ntb_epc_cleanup() - Cleanup all NTB interfaces
- * @ntb: NTB device that facilitates communication between HOST1 and HOST2
+ * @ntb: NTB device that facilitates communication between HOST and VHOST
  *
  * Wrapper to cleanup all NTB interfaces.
  */
@@ -934,6 +951,8 @@ static const struct config_item_type ntb_group_type = {
  *
  * Add configfs directory specific to NTB. This directory will hold
  * NTB specific properties like db_count, spad_count, num_mws etc.,
+ *
+ * Returns: Pointer to config_group
  */
 static struct config_group *epf_ntb_add_cfs(struct pci_epf *epf,
 					    struct config_group *group)
@@ -1084,11 +1103,11 @@ static int vntb_epf_link_enable(struct ntb_dev *ntb,
 static u32 vntb_epf_spad_read(struct ntb_dev *ndev, int idx)
 {
 	struct epf_ntb *ntb = ntb_ndev(ndev);
-	int off = ntb->reg->spad_offset, ct = ntb->reg->spad_count * 4;
+	int off = ntb->reg->spad_offset, ct = ntb->reg->spad_count * sizeof(u32);
 	u32 val;
-	void __iomem *base = ntb->reg;
+	void __iomem *base = (void __iomem *)ntb->reg;
 
-	val = readl(base + off + ct + idx * 4);
+	val = readl(base + off + ct + idx * sizeof(u32));
 	return val;
 }
 
@@ -1096,10 +1115,10 @@ static int vntb_epf_spad_write(struct ntb_dev *ndev, int idx, u32 val)
 {
 	struct epf_ntb *ntb = ntb_ndev(ndev);
 	struct epf_ntb_ctrl *ctrl = ntb->reg;
-	int off = ctrl->spad_offset, ct = ctrl->spad_count * 4;
-	void __iomem *base = ntb->reg;
+	int off = ctrl->spad_offset, ct = ctrl->spad_count * sizeof(u32);
+	void __iomem *base = (void __iomem *)ntb->reg;
 
-	writel(val, base + off + ct + idx * 4);
+	writel(val, base + off + ct + idx * sizeof(u32));
 	return 0;
 }
 
@@ -1108,10 +1127,10 @@ static u32 vntb_epf_peer_spad_read(struct ntb_dev *ndev, int pidx, int idx)
 	struct epf_ntb *ntb = ntb_ndev(ndev);
 	struct epf_ntb_ctrl *ctrl = ntb->reg;
 	int off = ctrl->spad_offset;
-	void __iomem *base = ntb->reg;
+	void __iomem *base = (void __iomem *)ntb->reg;
 	u32 val;
 
-	val = readl(base + off + idx * 4);
+	val = readl(base + off + idx * sizeof(u32));
 	return val;
 }
 
@@ -1120,9 +1139,9 @@ static int vntb_epf_peer_spad_write(struct ntb_dev *ndev, int pidx, int idx, u32
 	struct epf_ntb *ntb = ntb_ndev(ndev);
 	struct epf_ntb_ctrl *ctrl = ntb->reg;
 	int off = ctrl->spad_offset;
-	void __iomem *base = ntb->reg;
+	void __iomem *base = (void __iomem *)ntb->reg;
 
-	writel(val, base + off + idx * 4);
+	writel(val, base + off + idx * sizeof(u32));
 	return 0;
 }
 
@@ -1275,6 +1294,8 @@ static struct pci_driver vntb_pci_driver = {
  * Invoked when a primary interface or secondary interface is bound to EPC
  * device. This function will succeed only when EPC is bound to both the
  * interfaces.
+ *
+ * Returns: Zero for success, or an error code in case of failure
  */
 static int epf_ntb_bind(struct pci_epf *epf)
 {
@@ -1359,6 +1380,8 @@ static struct pci_epf_ops epf_ntb_ops = {
  *
  * Probe NTB function driver when endpoint function bus detects a NTB
  * endpoint function.
+ *
+ * Returns: Zero for success, or an error code in case of failure
  */
 static int epf_ntb_probe(struct pci_epf *epf)
 {
-- 
2.35.1

