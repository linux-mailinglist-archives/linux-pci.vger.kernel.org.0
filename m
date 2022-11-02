Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F66B61648B
	for <lists+linux-pci@lfdr.de>; Wed,  2 Nov 2022 15:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbiKBOKp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Nov 2022 10:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbiKBOKn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Nov 2022 10:10:43 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2085.outbound.protection.outlook.com [40.107.21.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94251EED6;
        Wed,  2 Nov 2022 07:10:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WD/CAI15drUeA3+Lc09fRoQFWkhX8egZen67nrwmVKYuVpiZPUYaIfzN5K/atxlOep55Qri6xntkOYdw1WdiKMhOQSWtH9jXN1hWgRH8ZvHC5QeaBpjSVZ4mN8bvHqvwwcmyjkCJy+yWyCdulyQ8whsxqSraOPHOo9Ckgs2p8B8K284AcElt01C4TxHwP15QOMcs3RRU9zsNn3CXVDzuDhlwU3mFwxhqfKhtV05BiCRP1fYxiWquHkBcMgQnkZES9iAm5nlBqKkwtbrIrbv/9kayBHWs7heeHYu7llxA4xKP7TcSriFFJ0qFYDuT3R/FNK0FBdpLjEcXtYAvwvBeZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+crJ9i3nm+wkdGC5mvPCy8uw2cmvfs1NDX++obGypGU=;
 b=QCys+OuniUQrv1l3DWElXfIExRBuiFiEsVsxzRuJv/0TT0bPtZRwsRWD+iZI8NlUZfNX0sW48bNl2nNY+/j1lEsD53tV4piBN6cXek2+3pU0xKIpzKH90AiFDG9JdGyH8aZNLLH6Y2DJ0lokzk7U+pLOz8FUGpu0hk7jpJp5FCGcc4H5jaZQaMQQM3VXc+YIIS5AROt5fRlPHh5lfrUcUqSPxoPI1uB8zhycAcJbhuArbegWQqHFnyvjGHotDosmgJYDbTM4n1mLsyfcCzqhn6uYboZbBv7r0kspcnZtzRyZA53fbWjytz7MxR9Gywrf5ZHJXVdHzoz5YO3khuGVYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+crJ9i3nm+wkdGC5mvPCy8uw2cmvfs1NDX++obGypGU=;
 b=g24QaPeG82ns4U0qhl/hRfysj5dqrTr+INdDS0QOaHckWdGXG9GdwbmJ0m7QDYOjlbumllBXNX7x8eNGGaBLP4YnXxytmvq+sVRr9ObqOvALSCW4wwRsq3LwOABBllz7hGasxUsvx9P6EMl5kAg9IJOsY5udT/+v6aKKDwJagBE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by DB9PR04MB8234.eurprd04.prod.outlook.com (2603:10a6:10:25d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Wed, 2 Nov
 2022 14:10:37 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::44bb:8387:8f4b:6a28]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::44bb:8387:8f4b:6a28%11]) with mapi id 15.20.5769.021; Wed, 2 Nov 2022
 14:10:37 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     mani@kernel.org
Cc:     Frank.Li@nxp.com, allenbh@gmail.com, bhelgaas@google.com,
        dave.jiang@intel.com, helgaas@kernel.org, imx@lists.linux.dev,
        jdmason@kudzu.us, kw@linux.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lpieralisi@kernel.org,
        ntb@lists.linux.dev
Subject: [PATCH v16 1/7] PCI: endpoint: pci-epf-vntb: clean up kernel_doc warning
Date:   Wed,  2 Nov 2022 10:10:08 -0400
Message-Id: <20221102141014.1025893-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221102141014.1025893-1-Frank.Li@nxp.com>
References: <20221102141014.1025893-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0210.namprd05.prod.outlook.com
 (2603:10b6:a03:330::35) To HE1PR0401MB2331.eurprd04.prod.outlook.com
 (2603:10a6:3:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2331:EE_|DB9PR04MB8234:EE_
X-MS-Office365-Filtering-Correlation-Id: ee054991-efb9-4a4b-70c0-08dabcdc039b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P+8i7mOXvv53D22r4rcZDyuV6BzbYNJvFEapufPGIuIGsbI5zoZVS0PKLCgo8PRbPFR4IZzCoI4ELUQEzxTfwsiAZKFKaf+RbKJWvWOh1D9jfjfZF7kXNmpLIl59XNBvilxodh6tv+w6Bu1mFZM6XNlBge1SNXvrsdMVzdNE4MVgpwdDzzX4aswivQfypXP8DdgyGzltWLNmqO8MBkjRuaTSu5A2Yjp0thfBEPPrxxm0/pZDrAnn2YedDjN5iLkvizmsIRWOxee9gCyoUSwoTrGYQsStVdd3U0H2JurjTl0UPSpGRltrNewGoxM3g8875VZj1U2KLzyAtcOwtTBlRTSqZBZN3VaxQ8Rr3fiXzuMSPwM959v/qgVU9Q0o6/IhJVCfLekHejfOxjT97rRoRx9aKCNs/2ReXXEDCttlV85semOXFpFdvbsJawlUpRPj0lDZFrlldYjltvad7SFNoepCywsADAKkx3jw+UchTmqWVKm/qh8QAyEcr9ZQwQZI124oT1Vh4Ux2BS5xg6ftMdgUdTaFc3WW7iY+Owtm7OHbNKuDRlFa7A+99ie/r+l2U5FrBZ18J9olI64mHsZnIDorm50zoDlk5mRstJq3dwJ01g6cDtvKrFTh3/55So5I3OEBQOKndqKTlgVFqOyrnG185mJE2pUT2w9wVbfluhgEo8fabzscYLgs87bXbyZ+cMj4hUIbMJWjAuwUCcv/W4XYMJcUnAzP2vq4O2+yNpKNLq8ImniguXlmTQMCIAx/7QcXJsXZcujFJfuM5S1VKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39860400002)(396003)(376002)(366004)(451199015)(36756003)(6916009)(6486002)(5660300002)(7416002)(83380400001)(478600001)(30864003)(2906002)(41300700001)(66556008)(316002)(8676002)(66476007)(4326008)(66946007)(8936002)(26005)(6512007)(186003)(38100700002)(2616005)(1076003)(38350700002)(86362001)(6666004)(52116002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HO/5x42H3V1B4iXHPenv1mmf/s2ZiRzVYb/+pesL1wTzd48YyQ0IW+IqPRyI?=
 =?us-ascii?Q?rlBAGwN5RXPPFNMM+HaIKf5G8BOwcCVJ80xYiYhtlc05NhcJ1ZSk3VGvME9y?=
 =?us-ascii?Q?vzNTvHiXRAD2F3SzM7xQqk7iKp+roeFAEQvME40LXk5F/BSexAZC/ljJUqEX?=
 =?us-ascii?Q?e9voEqAJ6zUBSXnVvxPHwTqzb537NHJ6F8mMyFAblhQ+ivUazyCAQZFQuwEj?=
 =?us-ascii?Q?ScFIqnRh8U+XgKWB41waTvdd8NkyWUrxE/GIHTKaK4aTJAvILZba+dB+qmxi?=
 =?us-ascii?Q?UPlp+tm/HvEuXKMHMtIXkTueyI/HQi33WecJJhl8cL5ys2xVDoQrR9AR6Wid?=
 =?us-ascii?Q?GZp/Hhd+jFMo4x8qkk0N7SK8P22M+uIXZ614vOlFpZwUu5C4XOYB2M2pqRLM?=
 =?us-ascii?Q?FdMisYpnoTAqagTXDrJH1d9RriwLC/cYyloMsZ1Sn+V0J1GCnao61B0T29rR?=
 =?us-ascii?Q?JBs3yOK9Rs12nMYnl/htgSCDMkiMgvbMZlyTT6YVJF/d9dUTa6ahfwNyZfbh?=
 =?us-ascii?Q?BJzCRXWLB+yiWKQywy/xFn7+eCHy1EhayO8OxXbfpfX2b+WoI6NXCOVGQaS7?=
 =?us-ascii?Q?Nz6HoSU9HclLrFXjFvzwMmynYovzEAQjLqoh92P4v91NiByi69n1qkeA/KUR?=
 =?us-ascii?Q?0IqyOuJ1OZrWXvH45NYzMv3QgV3xiU+BVUAOqBYZbNMx4QgXMZjOjSZeWQ2m?=
 =?us-ascii?Q?Yml+SYuomltoISfSG1NEAQMWS/qADKh5D/2QsgJNFxZUM/LodQDthu2jjwrm?=
 =?us-ascii?Q?7AHA7B/IxYZ4l0UuEpcQn918yNT7VXD5rtU6Pe4n3wKBd0yLMZhE8fHZawbr?=
 =?us-ascii?Q?mqSSA+So7rUb9EKJumsIS+wVMfkkaHV/wCTnaU7Rh/g9SVwS7Z1x/H2b/q8T?=
 =?us-ascii?Q?k1smHLuyH5v8ZqcWP6GsIOOL1Pvgst4wVyUJxx1P50gYoSJfRYfzCMh/oWLb?=
 =?us-ascii?Q?AS2X832MRskPesU0emdZq9YVBHr9qEJUzesVd/blsPhQ7K08ewe/GiZDotDi?=
 =?us-ascii?Q?ZbiMxhjMIvDA0TZ1JBmf3+aWk4WJ7Re9lb4oH9+ZBnrEEkpDkRbAF2fjhyI5?=
 =?us-ascii?Q?I0fQsIL9tFZxXYCz7C+C3Om+DsbStQ5N5VTbKHh3w+I13V4e6Y9Bamw16jP+?=
 =?us-ascii?Q?Nm99kVIZI0+pPxMybsSV93pkxQwlH0bb6iz2OhI7klhyYHp3GR1AjopLcWCX?=
 =?us-ascii?Q?EW7dwye0IndTNo/GrUHfY8cWRsYDxNrZy6yomEBQUxWOOS/6p9ES757fPQZ3?=
 =?us-ascii?Q?y1YKNQU4hPsM4s78Ei6WSOih10wqtt1CJCjKQHHrXBFv/j7hDcv49tB0m08s?=
 =?us-ascii?Q?Mt/89wg52f/EoFKyCIUeShiT6hOxEm/z4WEwure6gBXz6v1CadvtWVanXlnw?=
 =?us-ascii?Q?1x6nqZcGkx+Q94PWN31HkNYiEXMBxV98i0PC9F+Fq43e3CprVHDEGh8Eoiq1?=
 =?us-ascii?Q?fveGTQaRQe7GuDzHvaQcnopfnyP4V/0OO6G04ojzPZQwGU5svGWc1hcOtEeB?=
 =?us-ascii?Q?4fHYHmdBX6IbCOL5aGHwvMuQO3hZU6z3AUTsLMnd2ao5ArLp+jlyvmFe6UiM?=
 =?us-ascii?Q?p7zicNYyOcWMPmZYV7sepMIlFUJ6oto//+kGnDhy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee054991-efb9-4a4b-70c0-08dabcdc039b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 14:10:36.9129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IYpmmNpiuiYm2F1SPkZxkKxCXHB2F/DcNsqDVZidw3gM6s5Ne82yVMKTuAdEFGPfXeWAG+EAdj2yaDGwKk5eTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8234
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

