Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8025F7DB1
	for <lists+linux-pci@lfdr.de>; Fri,  7 Oct 2022 21:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiJGTOR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Oct 2022 15:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJGTOL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Oct 2022 15:14:11 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2048.outbound.protection.outlook.com [40.107.20.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E78A98C2;
        Fri,  7 Oct 2022 12:14:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mHmSr6/OvU4id/Zw1CLfWePVINOVWT/RDZ8fKpiZT2gCjooxfXS6qEiQoF1M2tMFBBzWcJHTImP5Celr3HB4iAl0O+AjpZUXIKGP2EoMs3GLQg2yFv8yAe6iD1PgMqJPtt1e0ccqq1UrAEUrIqBRokQTGmUSYIukyqPXACpsBnG2VGmexcwsjKHxtBgnGKCWeJJCGUB1zfGhxV1bC+otqVWoK30kH2I1LxFQs1BEnLsVS9ijXH2foaD7SS1Xsr1nKNT37W6ymPdyGoVy4kxWx2EhdX4fiIyxOL9E8yk2bZNwyHSnpru1J4ZDhYVf/e/oI4rw01t6tsH59EnpLc3Feg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ztuGq2FTvBPO9qE1epwO3aSqJAJQbfBz/Tjg3yJV2fA=;
 b=FPo8sfM9UBP1/v+jqZPur7PpB0kF3zcIazgkEX/GIKBsrHum3aNGMsBAS5AU/15cIwgzgAFEo9EeKvYgbQbzxXdN1hdjj6cgRkdyk7oNecTv+L8Xqh45LyvozSRTprO8RDs2sJuzWfQs3dh5Xx/VwyAX8buJnZU1JGs5E7ZiQiQijZT/oE7Hpn8pXYdZN2Uatyfd44Oq6SOgW7jdOOyKDCGfYuFvYICJ/RRqG9YQR447DrbiQc1TOSlxb/iA9hYiDjMAFraxuAgm7yr6Z29/7nivIGCaUbO7xgGMPdtH2MdPoqbppglO1jdcsMiz+kCjWstF6YFhGkUFg5jWcdVJhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ztuGq2FTvBPO9qE1epwO3aSqJAJQbfBz/Tjg3yJV2fA=;
 b=PW+E7dqb4ZrM7Ot/oj4CxYb19TJPYGXNjDarNLBCSoWB1hhkiubNM3rz1AbZ5TgRaYjAn2TjZKt2KIelWUqrcoeq3Cuew57soY2tOpbdLpD14TytZ/nSgIC2RFGZDXED77VJk2YFcBeWr3ZIaQuwS/W6Gt+meOlGxJJOoK1M3F8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com (2603:10a6:20b:408::22)
 by PAXPR04MB8192.eurprd04.prod.outlook.com (2603:10a6:102:1cd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Fri, 7 Oct
 2022 19:14:06 +0000
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::54da:4ebc:2916:de90]) by AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::54da:4ebc:2916:de90%5]) with mapi id 15.20.5676.038; Fri, 7 Oct 2022
 19:14:06 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     imx@lists.linux.dev, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        ntb@lists.linux.dev (open list:NTB DRIVER CORE),
        linux-pci@vger.kernel.org (open list:PCI ENDPOINT SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v13 1/6] PCI: endpoint: pci-epf-vntb: Clean up kernel_doc warning
Date:   Fri,  7 Oct 2022 15:13:21 -0400
Message-Id: <20221007191326.193079-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221007191326.193079-1-Frank.Li@nxp.com>
References: <20221007191326.193079-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::20) To AM9PR04MB8793.eurprd04.prod.outlook.com
 (2603:10a6:20b:408::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8793:EE_|PAXPR04MB8192:EE_
X-MS-Office365-Filtering-Correlation-Id: a54446d6-ef57-40b6-d7c3-08daa8981a7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qc+h491u7qLXfPp/n25Bj8S1NVpjI2i5uGZcMK8jmQ22qSt/hx5YxegySEfRQmPzKFdfCdHZJvLq1prK8lyfvkuSiuXi4rrwSP6z9T9xRFudZeiNkg9zTEC9ulnP3p+2P8NQJuBpdSUuLwt2JhLLoeo9yecXj9UOfmnhFUq3CpE1K8VhS9v+E26OGOOT/cKg2o3tjnM0T4xTn9yit9S45BV1FCC9Vmw3IgHARF7MRTlBDN0eZ2waBSNSXrXQkLUYZ+EqNXH2QyJQGbOUe12O2lj3t7vLg05hMe0K9aY8f0GB6CaK0mGsXDDgqIlVtUarD2CHReHkwGbu966nyfYThqdZEtVpcoB2wePCa+zbr7u6urkT1tzJf/iesn2TCkpV/g6jb/GISRkxo8facfEx5brqbqsdX+FmWaqckQNdAtOz6nCglcEVxlCJAbzEqGB1Sw47mbwusuSk1hLC0aNrmg0oWBWVAvbbT+pfQiU0eVlss3n0NvXNpzS7K69Bzj7aUXivVrunfNhrAnlcw2iwt1z9L2qMxSF1oCepsVbfhALETc76EIRDp+dxUbp4IkSnK7h2jHZZrbwZLV+Y8uEPuvDfSkoQ7uzuxqpCur5+VQk7E0x+HrAjhGYEFu5VvdgUKbnpq03T50GLyrYpPscStJpApALI3N6nbQxX8IjnDOjoVTnupcFzRhBspKlx/BFG12Ge/Txm6T8uEm7EAuGIZ+UoU0+GZ/kYawK9wM3ETOK55h1vxo34DNX2QvXwN33cJ1QI80zX83wsKzFkwAfn58xHP92cy8w41AYPM/0Wyb0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8793.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(39860400002)(346002)(376002)(366004)(451199015)(66946007)(36756003)(6666004)(7416002)(30864003)(38350700002)(8676002)(38100700002)(2906002)(1076003)(41300700001)(66476007)(186003)(66556008)(83380400001)(6512007)(8936002)(2616005)(52116002)(26005)(86362001)(5660300002)(921005)(6506007)(6486002)(110136005)(478600001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1TB/6/nNHCvQDUriav8Wai9u1S0pNwLp6Wjosck9AsRS7Rcn6cLLGv3BrG8g?=
 =?us-ascii?Q?zA2OS9bu33mmzu4s0ZBukpaEpQyTlD2XlVA2y0wpEXYT4GEYgKD2SyXkJbDZ?=
 =?us-ascii?Q?H2f2xYs0NBVEZ8qt6AmxexI5hyh3pRIs5RMslQSe4Z7oQPW46R5NIJYNNQNq?=
 =?us-ascii?Q?xHonJhsR5ZT7bmXKNepPPKhIKnsNsuQQv17SdG0QJGAuy4BbLBaEVGXJwb0I?=
 =?us-ascii?Q?u8BCBl5lcdiZHyOLDMzx7HwwzyRueLXc+NHon0SQH4vzRAhODo9ZGDnX9Ubv?=
 =?us-ascii?Q?rUPFDlNg+Wq0COzt8sRm32Ltsn+7qXYBYmJ5oG8advDWzXgNY4Ese2+j+LRP?=
 =?us-ascii?Q?4KoAhIM418K4rcsOe+lvT52s51uCjDsKi2i8UBmmoYCgewCGpLYAE3BOQPl3?=
 =?us-ascii?Q?vUCdOJhOffFi7UmlxaIwe3OZp9lR2DbZ5HTPVFZsFSGBkf8PuoM6xPzpOMXd?=
 =?us-ascii?Q?FjWqrq78QzmIZY3zUPbsLXwAAuCc0D3cxP9lJkDbKO8DCLBm1YOCtD//RQ8A?=
 =?us-ascii?Q?0kw03T9EwFRTzTSrdxz1J1k/arTm28bySywsVxvVHG/Gk2akOSAtXK+svW+Z?=
 =?us-ascii?Q?Es8Qvsa9DZvVYi8H5NEiZtj1+I23e0dz7ym2ML+2A5XQAX271459ROHwR3GA?=
 =?us-ascii?Q?svcRZ/iLsYjhwkWbBOUXx1C91AoKJ8Dij+M79UMB18QQrciJ7mWBYU34oulR?=
 =?us-ascii?Q?wrn9YAfJFDF0BcHERsgIaOE/TtoXyrfhLn2tkgEwjS3j7MVWZhSHMBcZEeOA?=
 =?us-ascii?Q?IsuiTFa36a1R/c+ko1zoTs5/lydQV0cPPpSg3f2fWZa7EGG+RNndpavmQsVi?=
 =?us-ascii?Q?PNIr8Mo0FJUGS5/Ci0rT3rATK7VSOvUnCNRUmmDc5OhOSQoMfcmSQBR4+K5L?=
 =?us-ascii?Q?ZCpJsXTK8OGt8Rdwt8NSJIr1zlq2eoRyT2rXyks9KUprteIib6wLZupeUDlI?=
 =?us-ascii?Q?zP7fSAfztBUyfJc82DhZ5xxb2/cnRW8TrXHABtfzE+ajOPKFZJ0z9oAwID6p?=
 =?us-ascii?Q?uD/xH5WxpL9FUFx5WoxJJYBcq/gVA8Tm2PTvpYSNHv93lLASFqnDTBfXXmK7?=
 =?us-ascii?Q?57Jry1paAecbcH7LHvixjDDPfBWrRApF5GO44QWQP3BXn+u6SvpzGtBEdSrP?=
 =?us-ascii?Q?XBj2+uW4xyh5zFJ2K7JxTBFdXU+fl1+uojML8nTL/DbAEJg48K5vsLzHSjCC?=
 =?us-ascii?Q?eu+waBUH6AIdbIVc8n7QO6JVHuo/1jAoeTwZCxa3kshFJ5XflUJ/r/nCwELd?=
 =?us-ascii?Q?x91wvTnysZp+VOUQxd9lgEmo+ZHUqBW/jZbSqZVoHpZ6P0YnIvGRZdhBfXi/?=
 =?us-ascii?Q?IWOW7py74dHuddDdVFe03UyB5UPnLSamYlAozJ6R6OqvrjdEmYoPx5oAvrlh?=
 =?us-ascii?Q?nZrfuv33UZVntlYcz/1yLH7M+muETy143mOvafArrVl13+loKMb5FN46lXT8?=
 =?us-ascii?Q?17CZJxsoNDwaeEhulQ9fwbq/rxlfyQOh/2q88/NfR2c24DuSwBx7yS2H3Gqc?=
 =?us-ascii?Q?tykb082/YCv+qhODQz08F/TQCgkHExfrTnbox291HCy4PALwuE/vqxEt0Nig?=
 =?us-ascii?Q?4BHcnPJ8iIk/jQHZhjEOWYdVvDECufrR6BMKXx7D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a54446d6-ef57-40b6-d7c3-08daa8981a7c
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8793.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 19:14:06.2299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5+TLgLDLrP2auykPfFpIlfRrsRNPu5OsfuFX+YlmEg16yYCCVs9L0K6C+BodGiDiQK6E08PyansRMUzN2coX2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8192
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

