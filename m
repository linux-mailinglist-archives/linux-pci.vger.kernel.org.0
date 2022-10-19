Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3466A604D91
	for <lists+linux-pci@lfdr.de>; Wed, 19 Oct 2022 18:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbiJSQj2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Oct 2022 12:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiJSQjZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Oct 2022 12:39:25 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2072.outbound.protection.outlook.com [40.107.22.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA9925EA2;
        Wed, 19 Oct 2022 09:39:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ngD30IkCgBtBSfKnO1m+dcLmZNaa/rG8f5Z+JG+7NB8KCf1tthZR7Vn8LMIo++rPvdWDMls4UvZI/DUULTzGxsBLQ0+Nhc4aoWqbLrd4xxFSXJqSdDH1vsAQydU40gFujNbdJtXSRjTQPmx+GofTMi3Cei/yMtYyxBmRMmy0JAiDAgLrbxUXMpC+roniq1WOvYPotsu2J5u5B6nv630fJPZUgHBs5rboT/cFZut9c2HqdOcaPLPsmoK4uC/myGwTMn/sLVe5AazLj3VepIJ6mEQiOsQTMsPrm0xkcMQ9mZYlLhMbMcv3kUFxDQluhTO570wwrrhynrOrut04rLqKQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ztuGq2FTvBPO9qE1epwO3aSqJAJQbfBz/Tjg3yJV2fA=;
 b=ml4w8bioQJqZ58UIqEBQdYyVZ+33jYuzex16AF10+8pUxHtUDqMSP0z4XDdJHNbS+h6lnYQMViUnzN9o95sRpFHyNfSBB9t8R2qrmyfPS5ehfYOdYa4zAtfC0ym/fikQzrya4rc4F8mJvf3mq4wRsznpKonT4Z5fXiSdMtCxT5pO6wa/qwkTDGoeK6jnK6JMmsgLlcCu8VVxehadsCVkzEJYR/cCL2axaapYs3IOCSucZ9XVfSgjdSO6NC2d6hgrNqH6WBy9OrRMbIivMDbGQ1Bw/KPGOTXdarS/x8daWQPQ6zgz3Jnfxj48ZpEY7UngUu2fCLBiQXZ18aSsNaFaqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ztuGq2FTvBPO9qE1epwO3aSqJAJQbfBz/Tjg3yJV2fA=;
 b=GumWHcwnbWETCOgsAHwyqmxjOPlU82hF2tSXuFGhpxVRJO31AOWpxu5vhpxPN2KK60tFi9rfE43nr7yNGqoDOxPanODJkNasEzj17kDWxetdlMw9AVTECNPMCxgUp9lKvy/AISdKy5FmN3NVp/KIMjxAFen1qNCc76g5zR4vq/s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by DBAPR04MB7318.eurprd04.prod.outlook.com (2603:10a6:10:1ab::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Wed, 19 Oct
 2022 16:39:19 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::6110:8304:5648:88f5]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::6110:8304:5648:88f5%10]) with mapi id 15.20.5723.034; Wed, 19 Oct
 2022 16:39:19 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     helgaas@kernel.org
Cc:     Frank.Li@nxp.com, allenbh@gmail.com, bhelgaas@google.com,
        dave.jiang@intel.com, imx@lists.linux.dev, jdmason@kudzu.us,
        kw@linux.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lpieralisi@kernel.org, mani@kernel.org,
        ntb@lists.linux.dev
Subject: [RESENT PATCH v13 1/6] PCI: endpoint: pci-epf-vntb: Clean up kernel_doc warning
Date:   Wed, 19 Oct 2022 12:38:50 -0400
Message-Id: <20221019163855.1267295-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221019163855.1267295-1-Frank.Li@nxp.com>
References: <20221019163855.1267295-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0352.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::27) To HE1PR0401MB2331.eurprd04.prod.outlook.com
 (2603:10a6:3:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2331:EE_|DBAPR04MB7318:EE_
X-MS-Office365-Filtering-Correlation-Id: a4f08106-af3b-4238-bd76-08dab1f07802
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Txv9TmqkATBOvPDSv03puwWZksyIS4Jz9cQKd/b44BPYRzHJ4q2f/RERPOk2r5bJ5VrIZ5QWIIx4wz7C0xPURUV72CQKwSnk8TTtsRpA9RYNPwS5NnQHj+r4GG7kcOfkRdjeZPmb/5w4YdRxQOhoYLg2JI8hY86QpjOkQPnixZUA6AiCNhcB094Z+SBlDGgUN7SJvtZtnjTZvdaCO2+Cqis2theB6QJvBKeC82Oo/eFgU1cDkhcUs2rJM6w93wpIPRxKRsi002h0Fx1CLkTloQPmc6VLiXeU9+UyNNWFNkhevYeVKX61mjv7SKVeyB1nTtLVzScWYn6Lj6K8qDJ8WyQZzWo3V806heI2bHH/sUQbVijqm/ay37d1ScGSjUp3QlwaVPecuGsglHJ3zUrVV6xroBeEEnXV65KxW1/zF9Vby1OV128Ll73B3286LudYgkVdPazGzMGVddqRcX8FtSisCH4xkdbJUdjrAu+xYbzlovwFwKIyvUJssMP45nVkBK58MGBclkvR5D7RuLJKdaYh2qnfcPJlGLszHk92088VfGSg+nvAiSgnov4iE+g5XZ4QJ6jUviedcUdskTKjF0iifm35RDiuT1tEfza8+97SZ1UeOumi4rIccFk5DGXebpu3alWTP36iVfuaOjfSvNAXH1NSyswvH1YItR7TFOgj+z0KTkWShCjNvIdYr+bulFb7dzpYCLv0laYQ6ljKcJ3Q+D3zOZz4wf3YIk9fAXOrGHtL9tecAB998za8J7pLVU5TmrahUEf4lzDq/rtS+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(366004)(346002)(396003)(451199015)(41300700001)(5660300002)(8936002)(2906002)(30864003)(26005)(316002)(66946007)(7416002)(6916009)(4326008)(8676002)(38100700002)(66556008)(66476007)(83380400001)(38350700002)(6666004)(52116002)(86362001)(6486002)(6506007)(478600001)(6512007)(186003)(1076003)(2616005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y3ZOF+jQolxjZIQ06oxVs1ZAz1NASeSazLrlLsRK+LKWjkJpogHC65bmQOHg?=
 =?us-ascii?Q?oNUqYtlh2cnGlxP9z59vgRdRzrYLu+RyeQgs8A24RaMORE62R8ETKu50FFEi?=
 =?us-ascii?Q?i+SZDnW9IErV+5QiVOm9WyKeK9iKgjsrLie2tOqChvjlXE+VnqtvX1K5rKM9?=
 =?us-ascii?Q?PHVMWjKevfLR5SktSZhLRR/c0AXoBw8fywjFVUYPsNVaGEwOKFdCQptb3CNb?=
 =?us-ascii?Q?xPBHvkf9UpHbNJgy8877kZ/7HflsXwOw4/5TKDlQBo3RWTZcdJim2S664oV3?=
 =?us-ascii?Q?vt/55BZXE04iaRhTHHUNsMZWWkg/gDsa4lSff4wnz2gx+P47iVGHhccXzZOG?=
 =?us-ascii?Q?EPGINzRNOnakW8Owm8mQvIttgEeCECUSDaM21J0NW9I6KKTfitfQHp07l21k?=
 =?us-ascii?Q?wO4RfIywcB/Je68pbevKVcEckhR5JFSDB0aFFIIiD06Pihx07pr6nu3ZytrW?=
 =?us-ascii?Q?ewRB5N41b14fNHospNZ09wKyHxaOTiNoELXleMk3xrO5c98n4t7QBb0NDNfM?=
 =?us-ascii?Q?VkofcMwPuefyquwi7Ser8HsGqq+/QCbKJAZ6xCmy3f7nSDZiCIaCLGtvgCXA?=
 =?us-ascii?Q?AjEXUrO3WX63cVEZlDuyiHJjG3vDZD72a1bCdHRfqNky6iNkqvbQbKgpdexK?=
 =?us-ascii?Q?chf3b/V8oLBNxNzEQjHzrDPvDGvyKVZxVB+ef7KpEIxEThJTYIl51n8+Rj98?=
 =?us-ascii?Q?yGUEVWtoCiH+txRcDLjHvxuKeZ7WsaBHhcgAz2uRC9MMATQJtlbMaZWrZ+/f?=
 =?us-ascii?Q?clsZIy58ItOdVi87sTr2Z4lc9G9l936YI6RX2zqbojGMmFD2cueaZK0cZza3?=
 =?us-ascii?Q?v3woagl/1WefCya6cP4Oy8pXzJfeDVueeNC+FBKkSu/Xzm+z0ug4UGqGLISr?=
 =?us-ascii?Q?P+ho9x3PT2kyjznqW2ZnfUNW6IX7aTwFFEtxmRtwVXW5MqBQZwC/lIedz4ha?=
 =?us-ascii?Q?lrnWeFxP/kiwxlHtnof9Fp9L5MmLsYRI2NVpjuOUaOBWlK74NMOUP6/VfMw0?=
 =?us-ascii?Q?Cpqy96VRH2GfPlqwLOw9KO4bkXNifBEYNpmYU0DRiVBy2fnHpn9dP5vWj0iw?=
 =?us-ascii?Q?NOvILlUDvjH+dvFpZYDMlHmalKBHhPXyHR074cz0Cd54QBnCMvIrcLp0awZu?=
 =?us-ascii?Q?ZxVr7XUekrav5ZZu1WbI2DTIHf9y/zimLidhrsF9Ri2MGyHCV7DyFE9w4rfo?=
 =?us-ascii?Q?JkU/SmpQCLSwbrH6dSgaCU3/RX+psrF5NEggC2yPrYYNVmqEvHxq34uzluEg?=
 =?us-ascii?Q?tHLKAEecuagxj3QKw26D84mktRNnKTKDyVCowSEYTN3X0CNutvnSAkWow6wm?=
 =?us-ascii?Q?7l++kVZDLCFbd6cRgtFwbbK/9BMhPLKykhPjxdL1vlyucmwbCaVjOs1MrEtM?=
 =?us-ascii?Q?KvfW/ObGwn0S9FvlO3GpOnNUhjXCDzBksTqKCaPGhG6N5i1QhD/rJpXldUWq?=
 =?us-ascii?Q?l3t4lqzKC/x6QfVgQw/I0yHVLCDGKYaOs2FJ9qGbV0Dk/HNiLIx1x5xTD3rd?=
 =?us-ascii?Q?1Nq2wJaHHwL4HfU+ygP0jYYG3N0Mi1iy9qgePpw3uucNh2j1mMnxfrl8yk4t?=
 =?us-ascii?Q?qznAHqeM+S0exx67cHQVDDrck17hiczVWUfYCD7O?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4f08106-af3b-4238-bd76-08dab1f07802
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 16:39:19.3496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 75b4GS/+bgN4Ijmz4Xz9VKIWW8YbsyYROc7mS9dk0MiTCoUXuen0ZJtCQTyungUpqBklFTkZ8+mjKE8/hpusgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7318
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

