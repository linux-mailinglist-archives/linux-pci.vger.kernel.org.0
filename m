Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C019C614FD0
	for <lists+linux-pci@lfdr.de>; Tue,  1 Nov 2022 17:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbiKAQ5q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Nov 2022 12:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbiKAQ5i (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Nov 2022 12:57:38 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2064.outbound.protection.outlook.com [40.107.105.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53ACE1D0FE;
        Tue,  1 Nov 2022 09:57:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T9/jhFkdfN0Coz+HyHCYna693Y9bQgIfN+7WWiV0G3jiZzxB+f5ksAgJ5SKpRHhvHSICdOA3KxP1FXc0WJoWB6dhGjp7jrlArkYCwBJrKZADJoZgt/lHvtF4CM9SH9Ozynx/yCrhp+dSw+5jUc8fDdaM/UvCB7hfWn5cWA1yPrwO5DSQWRvrZpRgmZb1wMWCuv2wtqw0mdUHCuM/hE4JA842LeEinnVlr//ZdRwLoOzQMdkbaAYWxK3aDzGPPC+RcEB1b4gzmkU82KF200QDqTzaNqFMWDv293i+ERjgpWu5TTDrsl9uIwH1SeRvTQ81YR6IJB+LdiKc4b9jh8ZJUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+crJ9i3nm+wkdGC5mvPCy8uw2cmvfs1NDX++obGypGU=;
 b=McKMVRAgEEGDVYT6xKaCTADk9SGLGHWH/ADu9VE3swx7uFl+WvZE/o8sG+jJOQF3Lrs6DjLR1IwuNH6aymWwXD7GFjF+N1TTgM+qyvMKavHw1y/BH9+Ama24HccIGpOwG6CZbmxNy9nn8U219urvhKrgLo4t1KvMHS78U8ddqesWKvFPzLFfSvBrDGyB0GiHxDnCtWxtpDdyZmJJpV/PDqGqSLvLdBRcSjlnxeqcHOVeeJnu/x6EcDyEUooD6u/JCbw6H5btEfRdB4m104wRX+e3ZkKe30nfV394HQSL4D8sPTdbzUz6o8M8tpmA+xqHOLAheOtYvtKoZwn5F/Ui2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+crJ9i3nm+wkdGC5mvPCy8uw2cmvfs1NDX++obGypGU=;
 b=Jm//ar+uV2UDg9Beb9+FoczSP2k1YaVW+TcT0wlnnHOubqMeszu0AQFU2ZZet4Gr7iDDuSDTBimZzBadwCADbxD+ybX3KizhfLejPnt7jMcqOj7vUKwHjnJL8CoH57xXLdKJ2/RPp+tAIXRbegcxmAGn474IErgKgz6eFfcoc5g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by DU2PR04MB8631.eurprd04.prod.outlook.com (2603:10a6:10:2de::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Tue, 1 Nov
 2022 16:57:33 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::44bb:8387:8f4b:6a28]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::44bb:8387:8f4b:6a28%11]) with mapi id 15.20.5769.021; Tue, 1 Nov 2022
 16:57:33 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     mani@kernel.org
Cc:     Frank.Li@nxp.com, allenbh@gmail.com, bhelgaas@google.com,
        dave.jiang@intel.com, helgaas@kernel.org, imx@lists.linux.dev,
        jdmason@kudzu.us, kw@linux.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lpieralisi@kernel.org,
        ntb@lists.linux.dev
Subject: [PATCH v15 1/7] PCI: endpoint: pci-epf-vntb: Clean up kernel_doc warning
Date:   Tue,  1 Nov 2022 12:57:03 -0400
Message-Id: <20221101165709.983416-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221101165709.983416-1-Frank.Li@nxp.com>
References: <20221101165709.983416-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::20) To HE1PR0401MB2331.eurprd04.prod.outlook.com
 (2603:10a6:3:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2331:EE_|DU2PR04MB8631:EE_
X-MS-Office365-Filtering-Correlation-Id: ad82594e-37e5-4aeb-e4d9-08dabc2a2b8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eWLnvOXilnBvDNUMP7ESM906YFXHoDZYhIMV26mvvQEQ7ESxHTt50QG2lJD4LE/bvpo0F1oGblOJf7F+JHxzM0WEroOMXn47INys4Roh3LoE0YyOenRjmgO7xKJcMZbQwVXJ+oM2GQ+8VAN8a0X09jgYI4g8AJVXlDe5fdO7BxrGpQUABmqQbEg4tem2iRyE8SyITu7QiWJ8nLMy3UKuD8pF5gbty+ZSsMdilR8Yze9G/OZ2FC+kiz32maMatCIQ+q9qVxPQMRaQJFlNmBB2xwyJM7eLjYI23L6x4Bs6MfaOYb4pDpWDIxTYIhQh/1nl91ciDdXkwkQzAKWLaJGaQIgSWOltTEqRI+abDCPXAeWhxawAUbwpWVU31KjtcCMbz6oSP9dEiA5sJNXBk63mrH8zWb6X8jOFNuGSOQWjQAw7FgwhUmrpOgBLLH0htzUrqnVWMDmMcTPFt5Hkbpq9whlEf4HhUXYYwulXhPm/RlxWBL2essoCkS2IrRduJdz50U5d9JeXe7l5KcUdGthO+6vkAtCRLjin7m/0OkYkPkk1G/b1TrQsBZG8bd9HbqQgr7zOBhCrNAP0N7UUmXWUREQkhTD5B/e3aKoG6DiVlgyadd82r3szW5xF8SRnotG+RtsFmJCqelcMYocxQkaNHeFtqYRM7vCKK5IzLD1o7TnJ7Hr2Y9fU2Dk1l2bpqKSH5X8ti37WWImLtq8jzb6nr21Nt6kVTrhAehO0xil3Ymjob4aKCo2v5SuamdARK7hLFm1BEWutQi5pruORYH3rfg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(366004)(136003)(376002)(451199015)(83380400001)(36756003)(86362001)(38350700002)(38100700002)(6916009)(316002)(6666004)(2616005)(1076003)(7416002)(5660300002)(30864003)(186003)(6486002)(2906002)(6512007)(26005)(41300700001)(6506007)(8676002)(4326008)(66476007)(66556008)(66946007)(52116002)(8936002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i/ijSYPZNqfrNliewZ60xgoaKSALNf1KOu53N+Pd8ik9uNpFlq9O7ILA/JD6?=
 =?us-ascii?Q?4rjunupcWU2AiolGQ6Kik4aQzYtQO3FrQ72+qp62JzAyN3ooqSYNxh/nK2Vy?=
 =?us-ascii?Q?wOc2ZyZcXbZtC0MkXTPshBNFivv2Tk0OCarUAhaprxTuZEKe3IJcF5ZOhBEo?=
 =?us-ascii?Q?bVBnlZBOfmANfW/1hYzfRLv0/mDGUzceRS8HjJ/AXbfOolBAMJRtBgst6a//?=
 =?us-ascii?Q?E7wiESUnW16vJkvdcKxNczFSH7P7AVyoHKd3YiimdL31q4ntHBZCNuA8l0Ql?=
 =?us-ascii?Q?W95jQaveUnhTwqJmrFR/IS8YgnyuU81gENtVKqjxJIQ6iKVzz/5P1IoDDc+g?=
 =?us-ascii?Q?j6GYBs0NrwwDDOcSXr+20nS/vE7ARp4vrxTAWqbZFbzsIHUK+hBYOD9b+H4N?=
 =?us-ascii?Q?nqqq+JkMgZib7EHWBuql+QxGGm+dnqk7OB6/j1xZqCRxdnqW9z0MImbJNuas?=
 =?us-ascii?Q?r54kNqWzaIOBs9K/e/Kn/ZcaojL33s17LUQ+3mZ7HdX7onENaewv2cTlJcdl?=
 =?us-ascii?Q?J/NOHJd9FbfDFd0GTIigQKoNTmEmRqqCdj5p7aFdL4y/JsgTzAThKnSeH8Lt?=
 =?us-ascii?Q?3YqsrjXNPVhtrWSZUSkA7sJOnKwohFzp2QavLGcCfo8mRWr/bhsXqMMf4zaF?=
 =?us-ascii?Q?ULn2IW0krzd9ywGXRY3tkjMhSC/7YDQ8Zc/zQlCfSHgwJKHWK5yJrY0FzZ1d?=
 =?us-ascii?Q?azZDpT0M0VTsx6ckx/mokyuwfmmrA2dK1+QG6lkYw9Xpx4uPKoi5TxfFF1+B?=
 =?us-ascii?Q?zVbHluU1NBpc4x8pcDBe/WGGU2GGfo6QRL0XA+KXGtr1dR23bvEzttLFcBf4?=
 =?us-ascii?Q?Ok3uqxWBOuR4fmTIosW7Wr03tFUA9FwVZeh+2QlCCQeI7hYIfE20O6QuMXkQ?=
 =?us-ascii?Q?t2A4yayB6Xkp1DNJITgnlELv0FRUqxezDW+upqhjD5CaipxYi2sQ8ZAFcPfU?=
 =?us-ascii?Q?Ig3RbiDVwIeNOAvg14YPVwe2xEec0ontDQ9W+f51Ky5wCtN5qKrjf62Xn7Ds?=
 =?us-ascii?Q?6dEKCT9Bf7i0zt5f9LizH2EsUFWsL5NZMlgXAwhWw5V3+Xa0vxehzfIaVNvA?=
 =?us-ascii?Q?KqE4gztgXgnq9REDHiJo+5MKPjAwukavirYsbTzow8xf344LXy3LHmreyJvC?=
 =?us-ascii?Q?UtgHhy3X4UM4hR9LEaKQHIGETuLOp12ByjqoDirUl10nskv/KmAZgwnZZQb8?=
 =?us-ascii?Q?NhRAtT5UT6vKeOYmEY/CRl8qr54Yscuvc7XXZDSOYDGJbPnp7l/CtOms3TVs?=
 =?us-ascii?Q?4ky1+lE0cE6JGzr7F1d8Ce8rdOTSSBHEzUIpbw7tkESAnk6XC07imkPFneM3?=
 =?us-ascii?Q?vc9VgMaK6yXZcDl45I8OdpXCkkVbgBoOF7WdMUwBrbF3zS0230+Iev7gFqV3?=
 =?us-ascii?Q?YCBd+q683Vs3pQRwd7LYUWcDcVxcrJHZqZgAH8fFeMGBxgGFFDPR2XAvpY6k?=
 =?us-ascii?Q?QdwpcEpdgeauALfUqse0F4mkvsWNte61TWAFGBoKUgBvsNgetr7z3Z3RPwzB?=
 =?us-ascii?Q?eBPsZPW2OW/z98il7eFqzdgVsdWLqB4My/ha54+2+IX7gIJxHRzz3jLen0La?=
 =?us-ascii?Q?olaP5uVYhDW4vlNSmSD6Sdb6YdrQCl/JLESoh4FR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad82594e-37e5-4aeb-e4d9-08dabc2a2b8f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 16:57:33.5282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 28PtiIm2MvKU0X5Xfi3u0dH8lL4W0nwpVuxQTCo7mmjJWXODHCp5Yn0tF7dGLFnNBHd7qdB0QZznDIpcrGGTKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8631
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Frank Li <frank.li@nxp.com>

Cleanup warning found by scripts/kernel-doc
Consolidate term
    host, host1 to HOST
    vhost, vHost, Vhost, VHOST2 to VHOST

Acked-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Frank Li <frank.li@nxp.com>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 83 ++++++++++++-------
 1 file changed, 54 insertions(+), 29 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 0ea85e1d292e..c0115bcb3b5e 100644
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
@@ -156,12 +156,14 @@ static struct pci_epf_header epf_ntb_header = {
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
@@ -175,9 +177,9 @@ static int epf_ntb_link_up(struct epf_ntb *ntb, bool link_up)
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
@@ -194,7 +196,9 @@ static int epf_ntb_link_up(struct epf_ntb *ntb, bool link_up)
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
@@ -219,7 +223,7 @@ static int epf_ntb_configure_mw(struct epf_ntb *ntb, u32 mw)
 
 /**
  * epf_ntb_teardown_mw() - Teardown the configured OB ATU
- * @ntb: NTB device that facilitates communication between HOST and vHOST
+ * @ntb: NTB device that facilitates communication between HOST and VHOST
  * @mw: Index of the memory window (either 0, 1, 2 or 3)
  *
  * Teardown the configured OB ATU configured in epf_ntb_configure_mw() using
@@ -234,12 +238,12 @@ static void epf_ntb_teardown_mw(struct epf_ntb *ntb, u32 mw)
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
@@ -321,8 +325,8 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 
 /**
  * epf_ntb_config_sspad_bar_clear() - Clear Config + Self scratchpad BAR
- * @ntb_epc: EPC associated with one of the HOST which holds peer's outbound
- *	     address.
+ * @ntb: EPC associated with one of the HOST which holds peer's outbound
+ *	 address.
  *
  * Clear BAR0 of EP CONTROLLER 1 which contains the HOST1's config and
  * self scratchpad region (removes inbound ATU configuration). While BAR0 is
@@ -331,8 +335,10 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
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
@@ -347,13 +353,15 @@ static void epf_ntb_config_sspad_bar_clear(struct epf_ntb *ntb)
 
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
@@ -380,7 +388,7 @@ static int epf_ntb_config_sspad_bar_set(struct epf_ntb *ntb)
 /**
  * epf_ntb_config_spad_bar_free() - Free the physical memory associated with
  *   config + scratchpad region
- * @ntb: NTB device that facilitates communication between HOST and vHOST
+ * @ntb: NTB device that facilitates communication between HOST and VHOST
  */
 static void epf_ntb_config_spad_bar_free(struct epf_ntb *ntb)
 {
@@ -393,11 +401,13 @@ static void epf_ntb_config_spad_bar_free(struct epf_ntb *ntb)
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
@@ -465,11 +475,13 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
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
@@ -511,7 +523,9 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
 
 /**
  * epf_ntb_db_bar_init() - Configure Doorbell window BARs
- * @ntb: NTB device that facilitates communication between HOST and vHOST
+ * @ntb: NTB device that facilitates communication between HOST and VHOST
+ *
+ * Returns: Zero for success, or an error code in case of failure
  */
 static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
 {
@@ -566,7 +580,7 @@ static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws);
 /**
  * epf_ntb_db_bar_clear() - Clear doorbell BAR and free memory
  *   allocated in peer's outbound address space
- * @ntb: NTB device that facilitates communication between HOST and vHOST
+ * @ntb: NTB device that facilitates communication between HOST and VHOST
  */
 static void epf_ntb_db_bar_clear(struct epf_ntb *ntb)
 {
@@ -582,8 +596,9 @@ static void epf_ntb_db_bar_clear(struct epf_ntb *ntb)
 
 /**
  * epf_ntb_mw_bar_init() - Configure Memory window BARs
- * @ntb: NTB device that facilitates communication between HOST and vHOST
+ * @ntb: NTB device that facilitates communication between HOST and VHOST
  *
+ * Returns: Zero for success, or an error code in case of failure
  */
 static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
 {
@@ -639,7 +654,7 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
 
 /**
  * epf_ntb_mw_bar_clear() - Clear Memory window BARs
- * @ntb: NTB device that facilitates communication between HOST and vHOST
+ * @ntb: NTB device that facilitates communication between HOST and VHOST
  */
 static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws)
 {
@@ -662,7 +677,7 @@ static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws)
 
 /**
  * epf_ntb_epc_destroy() - Cleanup NTB EPC interface
- * @ntb: NTB device that facilitates communication between HOST and vHOST
+ * @ntb: NTB device that facilitates communication between HOST and VHOST
  *
  * Wrapper for epf_ntb_epc_destroy_interface() to cleanup all the NTB interfaces
  */
@@ -675,7 +690,9 @@ static void epf_ntb_epc_destroy(struct epf_ntb *ntb)
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
@@ -716,11 +733,13 @@ static int epf_ntb_init_epc_bar(struct epf_ntb *ntb)
 
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
@@ -787,7 +806,7 @@ static int epf_ntb_epc_init(struct epf_ntb *ntb)
 
 /**
  * epf_ntb_epc_cleanup() - Cleanup all NTB interfaces
- * @ntb: NTB device that facilitates communication between HOST1 and HOST2
+ * @ntb: NTB device that facilitates communication between HOST and VHOST
  *
  * Wrapper to cleanup all NTB interfaces.
  */
@@ -951,6 +970,8 @@ static const struct config_item_type ntb_group_type = {
  *
  * Add configfs directory specific to NTB. This directory will hold
  * NTB specific properties like db_count, spad_count, num_mws etc.,
+ *
+ * Returns: Pointer to config_group
  */
 static struct config_group *epf_ntb_add_cfs(struct pci_epf *epf,
 					    struct config_group *group)
@@ -1292,6 +1313,8 @@ static struct pci_driver vntb_pci_driver = {
  * Invoked when a primary interface or secondary interface is bound to EPC
  * device. This function will succeed only when EPC is bound to both the
  * interfaces.
+ *
+ * Returns: Zero for success, or an error code in case of failure
  */
 static int epf_ntb_bind(struct pci_epf *epf)
 {
@@ -1377,6 +1400,8 @@ static struct pci_epf_ops epf_ntb_ops = {
  *
  * Probe NTB function driver when endpoint function bus detects a NTB
  * endpoint function.
+ *
+ * Returns: Zero for success, or an error code in case of failure
  */
 static int epf_ntb_probe(struct pci_epf *epf)
 {
-- 
2.34.1

